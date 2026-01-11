-- Centralized API Response Cache
-- Reduces redundant API calls and improves performance

local HousingAPICache = {}
HousingAPICache.__index = HousingAPICache

-- Cache TTL (Time To Live) in seconds
local CACHE_TTL = 300  -- 5 minutes

-- Hard caps to prevent unbounded growth when browsing large catalogs.
-- Trimming is only triggered when inserting and a cache exceeds its limit.
local MAX_CATALOG_ENTRIES = 1200
local MAX_VENDOR_ENTRIES = 600
local MAX_COLLECTED_ENTRIES = 4000
local MAX_EXPANSION_ENTRIES = 2500
local MAX_UNLOCK_ENTRIES = 1200

-- Cache storage
local caches = {
    catalogData = {},      -- {[itemID] = {data, timestamp}}
    vendorInfo = {},       -- {[decorID] = {data, timestamp}}
    collectionStatus = {}, -- {[itemID] = {status, timestamp}}
    filterTagGroups = nil, -- Single cached value with timestamp
    expansionTags = {},    -- {[itemID] = {expansion, timestamp}}
    unlockRequirements = {} -- {[itemID] = {requirements, timestamp}}
}

-- Register mem stats
if _G.HousingMemReport and _G.HousingMemReport.Register then
    _G.HousingMemReport:Register("APICache", function()
        local function CountKeys(t)
            if type(t) ~= "table" then return 0 end
            local n = 0
            for _ in pairs(t) do n = n + 1 end
            return n
        end
        return {
            catalog = CountKeys(caches.catalogData),
            vendor = CountKeys(caches.vendorInfo),
            collected = CountKeys(caches.collectionStatus),
            expansions = CountKeys(caches.expansionTags),
            unlocks = CountKeys(caches.unlockRequirements),
            filterTags = (caches.filterTagGroups and 1 or 0),
        }
    end)
end

-- Check if cached data is still valid
local function IsCacheValid(cacheEntry, ttl)
    if not cacheEntry then return false end
    local age = GetTime() - (cacheEntry.timestamp or 0)
    return age < (ttl or CACHE_TTL)
end

local function HasTableData(t)
    return type(t) == "table" and next(t) ~= nil
end

local function TrimCacheToLimit(cacheTable, limit)
    if type(cacheTable) ~= "table" or not limit or limit <= 0 then return end

    local entries = {}
    local n = 0
    for key, entry in pairs(cacheTable) do
        n = n + 1
        entries[n] = { key = key, ts = entry and entry.timestamp or 0 }
    end

    if n <= limit then return end

    table.sort(entries, function(a, b) return (a.ts or 0) < (b.ts or 0) end)

    local toRemove = n - limit
    for i = 1, toRemove do
        cacheTable[entries[i].key] = nil
    end
end

-- Clear expired entries from a cache table
local function ClearExpiredEntries(cacheTable, ttl)
    local currentTime = GetTime()
    local expired = {}

    for key, entry in pairs(cacheTable) do
        if currentTime - (entry.timestamp or 0) > (ttl or CACHE_TTL) then
            table.insert(expired, key)
        end
    end

    for _, key in ipairs(expired) do
        cacheTable[key] = nil
    end
end

-- Get catalog data (with caching)
function HousingAPICache:GetCatalogData(itemID)
    -- TAINT FIX: Safety check before calling Housing APIs
    -- Uses global flag _G.HousingCatalogSafeToCall set by CollectionAPI
    if not _G.HousingCatalogSafeToCall then
        return nil
    end

    local cached = caches.catalogData[itemID]
    if IsCacheValid(cached) then
        return cached.data
    end

    -- Not cached or expired, fetch from API
    if HousingAPI then
        local data = HousingAPI:GetCatalogData(itemID)
        if HasTableData(data) then
            caches.catalogData[itemID] = {
                data = data,
                timestamp = GetTime()
            }
            if MAX_CATALOG_ENTRIES then
                ClearExpiredEntries(caches.catalogData)
                TrimCacheToLimit(caches.catalogData, MAX_CATALOG_ENTRIES)
            end
            return data
        end
    end

    return nil
end

-- Get vendor info (with caching)
function HousingAPICache:GetVendorInfo(decorID)
    -- TAINT FIX: Safety check before calling Housing APIs
    -- Uses global flag _G.HousingCatalogSafeToCall set by CollectionAPI
    if not _G.HousingCatalogSafeToCall then
        return nil
    end

    local cached = caches.vendorInfo[decorID]
    if IsCacheValid(cached) then
        return cached.data
    end

    -- Not cached or expired, fetch from API
    if HousingAPI then
        local data = HousingAPI:GetDecorVendorInfo(decorID)
        if HasTableData(data) then
            caches.vendorInfo[decorID] = {
                data = data,
                timestamp = GetTime()
            }
            if MAX_VENDOR_ENTRIES then
                ClearExpiredEntries(caches.vendorInfo)
                TrimCacheToLimit(caches.vendorInfo, MAX_VENDOR_ENTRIES)
            end
            return data
        end
    end

    return nil
end

-- Get collection status (with caching)
function HousingAPICache:IsItemCollected(itemID)
    -- Prefer the centralized HousingCollectionAPI (single source of truth/caching).
    if _G.HousingCollectionAPI and _G.HousingCollectionAPI.IsItemCollected then
        return _G.HousingCollectionAPI:IsItemCollected(itemID)
    end

    local cached = caches.collectionStatus[itemID]
    if IsCacheValid(cached) then
        return cached.status
    end

    -- Not cached or expired, fetch from API
    if HousingAPI then
        local baseInfo = HousingAPI:GetDecorItemInfoFromItemID(itemID)
        if baseInfo and baseInfo.decorID then
            local status = HousingAPI:IsDecorCollected(baseInfo.decorID)
            if status ~= nil then
                caches.collectionStatus[itemID] = {
                    status = status,
                    timestamp = GetTime()
                }
                if MAX_COLLECTED_ENTRIES then
                    ClearExpiredEntries(caches.collectionStatus)
                    TrimCacheToLimit(caches.collectionStatus, MAX_COLLECTED_ENTRIES)
                end
                return status
            end
        end
    end

    return false
end

-- Get filter tag groups (cached once per session)
function HousingAPICache:GetFilterTagGroups()
    -- TAINT FIX: Safety check before calling Housing APIs
    -- Uses global flag _G.HousingCatalogSafeToCall set by CollectionAPI
    if not _G.HousingCatalogSafeToCall then
        return nil
    end

    if IsCacheValid(caches.filterTagGroups, 3600) then  -- 1 hour TTL
        return caches.filterTagGroups.data
    end

    -- Not cached or expired, fetch from API
    if C_HousingCatalog and C_HousingCatalog.GetAllFilterTagGroups then
        local ok, data = pcall(C_HousingCatalog.GetAllFilterTagGroups)
        if ok and data then
            caches.filterTagGroups = {
                data = data,
                timestamp = GetTime()
            }
            return data
        end
    end

    return nil
end

-- Get expansion from filter tags (with caching)
function HousingAPICache:GetExpansion(itemID)
    -- TAINT FIX: Safety check before calling Housing APIs
    -- Uses global flag _G.HousingCatalogSafeToCall set by CollectionAPI
    if not _G.HousingCatalogSafeToCall then
        return nil
    end

    local cached = caches.expansionTags[itemID]
    if IsCacheValid(cached) then
        return cached.expansion
    end

    -- Not cached or expired, fetch from API
    if HousingAPI then
        local expansion = HousingAPI:GetExpansionFromFilterTags(itemID)
        if expansion then
            caches.expansionTags[itemID] = {
                expansion = expansion,
                timestamp = GetTime()
            }
            if MAX_EXPANSION_ENTRIES then
                ClearExpiredEntries(caches.expansionTags)
                TrimCacheToLimit(caches.expansionTags, MAX_EXPANSION_ENTRIES)
            end
            return expansion
        end
    end

    return nil
end

-- Get unlock requirements (with caching)
function HousingAPICache:GetUnlockRequirements(itemID)
    -- TAINT FIX: Safety check before calling Housing APIs
    -- Uses global flag _G.HousingCatalogSafeToCall set by CollectionAPI
    if not _G.HousingCatalogSafeToCall then
        return nil
    end

    local cached = caches.unlockRequirements[itemID]
    if IsCacheValid(cached) then
        return cached.requirements
    end

    -- Not cached or expired, fetch from API
    if HousingAPI then
        local requirements = HousingAPI:GetDecorUnlockRequirements(itemID)
        if requirements then
            caches.unlockRequirements[itemID] = {
                requirements = requirements,
                timestamp = GetTime()
            }
            if MAX_UNLOCK_ENTRIES then
                ClearExpiredEntries(caches.unlockRequirements)
                TrimCacheToLimit(caches.unlockRequirements, MAX_UNLOCK_ENTRIES)
            end
            return requirements
        end
    end

    return nil
end

-- Invalidate collection status cache (call when items are collected/removed)
function HousingAPICache:InvalidateCollectionStatus(itemID)
    if itemID then
        caches.collectionStatus[itemID] = nil
    else
        -- Clear all
        caches.collectionStatus = {}
    end
end

-- Invalidate all caches
function HousingAPICache:InvalidateAll()
    caches.catalogData = {}
    caches.vendorInfo = {}
    caches.collectionStatus = {}
    caches.filterTagGroups = nil
    caches.expansionTags = {}
    caches.unlockRequirements = {}
end

------------------------------------------------------------
-- Cleanup Timer Management
-- CRITICAL: Only run cleanup when addon is actively being used
------------------------------------------------------------
local cleanupTicker = nil

-- Start periodic cleanup (call when UI opens or cache is being used)
function HousingAPICache:StartCleanupTimer()
    if not cleanupTicker then
        cleanupTicker = C_Timer.NewTicker(60, function()
            ClearExpiredEntries(caches.catalogData)
            ClearExpiredEntries(caches.vendorInfo)
            ClearExpiredEntries(caches.collectionStatus)
            ClearExpiredEntries(caches.expansionTags)
            ClearExpiredEntries(caches.unlockRequirements)
        end)
    end
end

-- Stop periodic cleanup (call when UI closes)
function HousingAPICache:StopCleanupTimer()
    if cleanupTicker then
        cleanupTicker:Cancel()
        cleanupTicker = nil
    end
end

-- Check if cleanup timer is running
function HousingAPICache:IsCleanupTimerRunning()
    return cleanupTicker ~= nil
end

-- Make globally accessible
_G["HousingAPICache"] = HousingAPICache

return HousingAPICache
