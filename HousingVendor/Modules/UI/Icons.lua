-- Simple Icon Cache
-- Session-only icon caching (no persistent storage to SavedVariables)

local Icons = {}
Icons.__index = Icons

-- Icon cache: [itemID] = iconPath (session-only, cleared on reload)
local iconCache = {}

local ICON_CACHE_MAX_ENTRIES = 5000
local function PruneIconCacheIfNeeded()
    if not iconCache then return end
    local n = 0
    for _ in pairs(iconCache) do
        n = n + 1
        if n > ICON_CACHE_MAX_ENTRIES then
            break
        end
    end
    if n <= ICON_CACHE_MAX_ENTRIES then
        return
    end

    local removed = 0
    for k in pairs(iconCache) do
        iconCache[k] = nil
        removed = removed + 1
        if (n - removed) <= ICON_CACHE_MAX_ENTRIES then
            break
        end
    end
end

-- Initialize icon cache (session-only)
function Icons:Initialize()
    iconCache = {}
end

function Icons:GetCachedIcon(itemID)
    if not itemID or itemID == "" then return nil end
    local numericItemID = tonumber(itemID)
    if not numericItemID then return nil end
    return iconCache[tostring(numericItemID)]
end

-- Get icon for itemID (with caching)
-- Priority: thumbnailFileID > C_Item.GetItemInfo > GetItemIcon
function Icons:GetIcon(itemID, thumbnailFileID)
    -- PRIORITY 1: Use thumbnailFileID if provided (FileDataID)
    if thumbnailFileID and thumbnailFileID ~= "" then
        local numericThumbnailID = tonumber(thumbnailFileID)
        if numericThumbnailID and numericThumbnailID > 0 then
            local cacheKey = "thumb_" .. tostring(numericThumbnailID)
            
            -- Check cache first
            if iconCache[cacheKey] then
                return iconCache[cacheKey]
            end

            -- Use FileDataID directly; `SetTexture(fileDataID)` works in modern clients.
            iconCache[cacheKey] = numericThumbnailID
            PruneIconCacheIfNeeded()
            return numericThumbnailID
        end
    end
    
    -- PRIORITY 2: Use itemID with C_Item.GetItemInfo
    if not itemID or itemID == "" then
        return nil
    end
    
    local numericItemID = tonumber(itemID)
    if not numericItemID then
        return nil
    end
    
    local cacheKey = tostring(numericItemID)
    
    -- Check cache first
    if iconCache[cacheKey] then
        return iconCache[cacheKey]
    end
    
    -- Try C_Item.GetItemInfo first (modern API)
    if C_Item and C_Item.GetItemInfo then
        -- Request item data load first
        if C_Item.RequestLoadItemDataByID then
            C_Item.RequestLoadItemDataByID(numericItemID)
        end

        local ok, itemInfo = pcall(C_Item.GetItemInfo, numericItemID)
        if ok and itemInfo and itemInfo.iconFileID then
            local iconFileID = itemInfo.iconFileID
            -- Use FileDataID directly; `SetTexture(fileDataID)` works in modern clients.
            iconCache[cacheKey] = iconFileID
            PruneIconCacheIfNeeded()
            return iconFileID
        end
    end
    
    -- PRIORITY 3: Fallback to GetItemIcon (deprecated but still works)
    local iconPath = GetItemIcon(numericItemID)
    if iconPath and iconPath ~= "" then
        -- Cache it (session-only)
        iconCache[cacheKey] = iconPath
        PruneIconCacheIfNeeded()
        return iconPath
    end

    return nil
end

-- Clear cache (session-only)
function Icons:ClearCache()
    iconCache = {}
end

-- Make globally accessible
_G["HousingIcons"] = Icons

-- Backwards compatibility: older code expects `HousingIconCache:GetItemIcon(...)`.
_G["HousingIconCache"] = Icons

function Icons:GetItemIcon(itemID, thumbnailFileID)
    return self:GetIcon(itemID, thumbnailFileID)
end

function Icons:GetCacheStats()
    local cache = 0
    for _ in pairs(iconCache) do cache = cache + 1 end
    local persisted = 0
    if HousingDB and HousingDB.iconCache then
        for _ in pairs(HousingDB.iconCache) do persisted = persisted + 1 end
    end
    return {
        cache = cache,
        persisted = persisted,
        max = ICON_CACHE_MAX_ENTRIES,
        persistEnabled = PersistEnabled(),
    }
end

-- Register mem stats
if _G.HousingMemReport and _G.HousingMemReport.Register then
    _G.HousingMemReport:Register("Icons", function()
        local stats = Icons:GetCacheStats()
        return {
            cache = stats.cache,
            persisted = stats.persisted,
            max = stats.max,
        }
    end)
end

return Icons
