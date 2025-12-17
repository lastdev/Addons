-- Collection API Module
-- Centralized collection status detection and caching

local CollectionAPI = {}
CollectionAPI.__index = CollectionAPI

-- Session caches (cleared on reload)
local sessionCollectionCache = {}  -- itemID -> boolean (is collected)

-- Helper: Get itemID from decorID using HousingDecorData
local function GetItemIDFromDecorID(decorID)
    if not HousingDecorData or not decorID then
        return nil
    end
    
    -- Search through HousingDecorData to find itemID for this decorID
    for itemID, decorData in pairs(HousingDecorData) do
        if decorData and decorData.decorID == decorID then
            return tonumber(itemID)
        end
    end
    
    return nil
end

-- Helper: Get decorID from itemID using HousingDecorData
local function GetDecorIDFromItemID(itemID)
    if not HousingDecorData or not itemID then
        return nil
    end
    
    local numericItemID = tonumber(itemID)
    if not numericItemID then
        return nil
    end
    
    local decorData = HousingDecorData[numericItemID]
    if decorData and decorData.decorID then
        return decorData.decorID
    end
    
    return nil
end

-- Initialize persistent collection cache in saved variables
local function InitializeCollectionCache()
    if not HousingDB then
        HousingDB = {}
    end
    if not HousingDB.collectedDecor then
        HousingDB.collectedDecor = {}
    end
    
    -- Migrate old HousingVendorCache.permanentCollections to HousingDB.collectedDecor
    if HousingVendorCache and HousingVendorCache.permanentCollections then
        local migrated = 0
        for itemID, _ in pairs(HousingVendorCache.permanentCollections) do
            if not HousingDB.collectedDecor[itemID] then
                HousingDB.collectedDecor[itemID] = true
                migrated = migrated + 1
            end
        end
        if migrated > 0 then
            -- Clear old cache after migration
            HousingVendorCache.permanentCollections = {}
        end
    end
end

-- Check if item is cached as collected (checks both session and persistent cache)
local function IsItemCached(itemID)
    -- Check persistent cache first (fastest, survives reloads)
    if HousingDB and HousingDB.collectedDecor and HousingDB.collectedDecor[itemID] == true then
        return true
    end
    
    -- Check session cache (faster than API, but cleared on reload)
    if sessionCollectionCache[itemID] == true then
        return true
    end
    
    return false
end

-- Mark item as collected in both session and persistent cache
local function CacheItemAsCollected(itemID)
    InitializeCollectionCache()
    
    -- Cache in persistent storage (survives reloads)
    if HousingDB and HousingDB.collectedDecor then
        HousingDB.collectedDecor[itemID] = true
    end
    
    -- Cache in session (faster lookups)
    sessionCollectionCache[itemID] = true
    
    -- Invalidate filter cache so collection filter can re-run with updated status
    -- This ensures that when items are cached (via tooltip callbacks or API checks),
    -- the filter will use the updated collection status on next application
    if HousingDataManager and HousingDataManager.InvalidateFilterCache then
        HousingDataManager:InvalidateFilterCache()
    end
end

-- Prime housing catalog searcher (caches decor data)
-- Being aggressive with creating searchers is fine - recache on zone transitions and searcher release
local function PrimeHousingCatalog()
    if not C_HousingCatalog then
        return
    end
    
    if C_HousingCatalog.CreateCatalogSearcher then
        pcall(C_HousingCatalog.CreateCatalogSearcher)
    end
end

-- Force recache catalog searcher (call on zone transitions and HOUSING_CATALOG_SEARCHER_RELEASED)
local function ForceRecacheCatalogSearcher()
    if not C_HousingCatalog then
        return
    end
    
    if C_HousingCatalog.CreateCatalogSearcher then
        pcall(C_HousingCatalog.CreateCatalogSearcher)
    end
end

------------------------------------------------------------
-- Public API: Check if item is collected (returns boolean)
------------------------------------------------------------

function CollectionAPI:IsItemCollected(itemID)
    if not itemID or itemID == "" then
        return false
    end

    local numericItemID = tonumber(itemID)
    if not numericItemID then
        return false
    end

    -- Request item data to be loaded first (important after cache deletion)
    if C_Item and C_Item.RequestLoadItemDataByID then
        C_Item.RequestLoadItemDataByID(numericItemID)
    end

    -- Check local cache first (avoid repeated API calls)
    -- This checks both session and persistent cache
    if IsItemCached(numericItemID) then
        return true
    end

    -- Skip HousingAPICache - go directly to API calls for more reliable results
    -- (HousingAPICache has TTL which can cause stale data)
    
    -- Fallback to direct API calls
    local isCollected = false

    -- Method 1: Use C_Housing.IsDecorCollected (correct API for housing decor)
    if C_Housing and C_Housing.IsDecorCollected then
        local success, collected = pcall(function()
            return C_Housing.IsDecorCollected(numericItemID)
        end)
        if success and collected ~= nil then
            isCollected = collected
            if isCollected then
                CacheItemAsCollected(numericItemID)
            end
        end
    end

    -- Method 2a: Try GetCatalogEntryInfoByRecordID first (preferred method)
    -- Use HousingDecorData to get decorID from itemID if HousingAPI doesn't work
    if not isCollected and C_HousingCatalog and C_HousingCatalog.GetCatalogEntryInfoByRecordID then
        -- Get decorID from itemID (may need item data loaded first)
        local baseInfo = nil
        local decorID = nil
        
        -- Try HousingAPI first
        if HousingAPI then
            -- Request item data load before getting decor info (important after cache deletion)
            if C_Item and C_Item.RequestLoadItemDataByID then
                C_Item.RequestLoadItemDataByID(numericItemID)
            end
            baseInfo = HousingAPI:GetDecorItemInfoFromItemID(numericItemID)
            if baseInfo and baseInfo.decorID then
                decorID = baseInfo.decorID
            end
        end
        
        -- Fallback to HousingDecorData if HousingAPI didn't work
        if not decorID then
            decorID = GetDecorIDFromItemID(numericItemID)
        end
        
        if decorID then
            local decorType = Enum.HousingCatalogEntryType.Decor
            PrimeHousingCatalog()
            local success, state = pcall(function()
                return C_HousingCatalog.GetCatalogEntryInfoByRecordID(decorType, decorID, true)
            end)
            if success and state then
                local sum = (state.numStored or 0) + (state.numPlaced or 0)
                if sum > 0 and sum < 1000000 then
                    isCollected = true
                    CacheItemAsCollected(numericItemID)
                end
            end
        end
    end

    -- Method 2b: Fallback - Check numStored + numPlaced from catalog using GetCatalogEntryInfoByItem
    -- This works even if decorID isn't available (uses itemID directly)
    -- This is the most reliable method for filtering
    if not isCollected and C_HousingCatalog and C_HousingCatalog.GetCatalogEntryInfoByItem then
        PrimeHousingCatalog()
        local success, state = pcall(function()
            return C_HousingCatalog.GetCatalogEntryInfoByItem(numericItemID, true)
        end)
        if success and state then
            local sum = (state.numStored or 0) + (state.numPlaced or 0)
            if sum > 0 and sum < 1000000 then
                isCollected = true
                CacheItemAsCollected(numericItemID)
            end
        end
    end

    -- Method 3: Fallback to housing catalog API (alternative method)
    if not isCollected and C_HousingCatalog and C_HousingCatalog.GetCatalogEntryByItemID then
        PrimeHousingCatalog()
        local success, entryInfo = pcall(function()
            return C_HousingCatalog.GetCatalogEntryByItemID(numericItemID)
        end)
        if success and entryInfo then
            if entryInfo.isCollected ~= nil then
                isCollected = entryInfo.isCollected
                if isCollected then
                    CacheItemAsCollected(numericItemID)
                end
            elseif entryInfo.collected ~= nil then
                isCollected = entryInfo.collected
                if isCollected then
                    CacheItemAsCollected(numericItemID)
                end
            end
        end
    end

    -- Method 4: Fallback to generic item collection API (for non-decor items)
    if not isCollected and C_PlayerInfo and C_PlayerInfo.IsItemCollected then
        local success, collected = pcall(function()
            return C_PlayerInfo.IsItemCollected(numericItemID)
        end)
        if success and collected ~= nil then
            isCollected = collected
            if isCollected then
                CacheItemAsCollected(numericItemID)
            end
        end
    end

    return isCollected
end

------------------------------------------------------------
-- Public API: Get detailed collection info
------------------------------------------------------------

function CollectionAPI:GetCollectionInfo(itemID)
    if not itemID or itemID == "" then
        return {
            isCollected = false,
            numStored = 0,
            numPlaced = 0,
            totalOwned = 0
        }
    end

    local numericItemID = tonumber(itemID)
    if not numericItemID then
        return {
            isCollected = false,
            numStored = 0,
            numPlaced = 0,
            totalOwned = 0
        }
    end

    -- Request item data to be loaded first (important after cache deletion)
    if C_Item and C_Item.RequestLoadItemDataByID then
        C_Item.RequestLoadItemDataByID(numericItemID)
    end

    -- Check cache first
    local isCollected = IsItemCached(numericItemID)
    local numStored = 0
    local numPlaced = 0

    -- If cached, try to get quantity info from API
    if isCollected then
        if HousingAPI then
            local state = HousingAPI:GetCatalogEntryInfoByItem(numericItemID)
            if state then
                numStored = state.numStored or 0
                numPlaced = state.numPlaced or 0
            end
        end
    else
        -- Not cached, query API - try both methods
        local state = nil
        
        -- Try GetCatalogEntryInfoByRecordID first 
        if C_HousingCatalog and C_HousingCatalog.GetCatalogEntryInfoByRecordID then
            local baseInfo = nil
            if HousingAPI then
                -- Request item data load before getting decor info
                if C_Item and C_Item.RequestLoadItemDataByID then
                    C_Item.RequestLoadItemDataByID(numericItemID)
                end
                baseInfo = HousingAPI:GetDecorItemInfoFromItemID(numericItemID)
            end
            
            if baseInfo and baseInfo.decorID then
                local decorType = Enum.HousingCatalogEntryType.Decor
                PrimeHousingCatalog()
                local success, recordState = pcall(function()
                    return C_HousingCatalog.GetCatalogEntryInfoByRecordID(decorType, baseInfo.decorID, true)
                end)
                if success and recordState then
                    state = recordState
                end
            end
        end
        
        -- Fallback to GetCatalogEntryInfoByItem if recordID method didn't work
        if not state and C_HousingCatalog and C_HousingCatalog.GetCatalogEntryInfoByItem then
            PrimeHousingCatalog()
            local success, itemState = pcall(function()
                return C_HousingCatalog.GetCatalogEntryInfoByItem(numericItemID, true)
            end)
            if success and itemState then
                state = itemState
            end
        end
        
        if state then
            numStored = state.numStored or 0
            numPlaced = state.numPlaced or 0
            local sum = numStored + numPlaced
            if sum > 0 and sum < 1000000 then
                isCollected = true
                CacheItemAsCollected(numericItemID)
            end
        end
    end

    local totalOwned = numStored + numPlaced

    return {
        isCollected = isCollected,
        numStored = numStored,
        numPlaced = numPlaced,
        totalOwned = totalOwned
    }
end

------------------------------------------------------------
-- Public API: Manually mark item as collected
------------------------------------------------------------

function CollectionAPI:MarkItemCollected(itemID)
    if not itemID or itemID == "" then
        return
    end

    local numericItemID = tonumber(itemID)
    if not numericItemID then
        return
    end

    CacheItemAsCollected(numericItemID)
end

------------------------------------------------------------
-- Public API: Clear collection cache
------------------------------------------------------------

function CollectionAPI:ClearCache(itemID)
    if itemID then
        local numericItemID = tonumber(itemID)
        if numericItemID then
            -- Clear from persistent cache
            if HousingDB and HousingDB.collectedDecor then
                HousingDB.collectedDecor[numericItemID] = nil
            end
            -- Clear from session cache
            sessionCollectionCache[numericItemID] = nil
        end
    else
        -- Clear all caches
        if HousingDB and HousingDB.collectedDecor then
            HousingDB.collectedDecor = {}
        end
        wipe(sessionCollectionCache)
    end
end

------------------------------------------------------------
-- Public API: Clear session cache only (keeps persistent cache)
------------------------------------------------------------

function CollectionAPI:ClearSessionCache()
    wipe(sessionCollectionCache)
end

------------------------------------------------------------
-- Public API: Get cache statistics
------------------------------------------------------------

function CollectionAPI:GetCacheStats()
    local persistentCount = 0
    if HousingDB and HousingDB.collectedDecor then
        for _ in pairs(HousingDB.collectedDecor) do
            persistentCount = persistentCount + 1
        end
    end
    
    local sessionCount = 0
    for _ in pairs(sessionCollectionCache) do
        sessionCount = sessionCount + 1
    end
    
    return {
        persistent = persistentCount,
        session = sessionCount,
        total = persistentCount + sessionCount
    }
end

------------------------------------------------------------
-- Public API: Get collection status using HousingAPI wrapper
-- (for compatibility with existing code that uses HousingAPI)
------------------------------------------------------------

function CollectionAPI:IsItemCollectedViaHousingAPI(itemID)
    if not itemID or itemID == "" then
        return false
    end

    local numericItemID = tonumber(itemID)
    if not numericItemID then
        return false
    end

    -- Check cache first
    if IsItemCached(numericItemID) then
        return true
    end

    -- Use HousingAPI wrapper
    if HousingAPI then
        local baseInfo = HousingAPI:GetDecorItemInfoFromItemID(numericItemID)
        if baseInfo and baseInfo.decorID then
            local collected = HousingAPI:IsDecorCollected(baseInfo.decorID)
            if collected ~= nil then
                if collected then
                    CacheItemAsCollected(numericItemID)
                end
                return collected
            end
        end

        -- Fallback: Check numStored + numPlaced via HousingAPI
        local state = HousingAPI:GetCatalogEntryInfoByItem(numericItemID)
        if state then
            local sum = (state.numStored or 0) + (state.numPlaced or 0)
            if sum > 0 and sum < 1000000 then
                CacheItemAsCollected(numericItemID)
                return true
            end
        end
    end

    return false
end

------------------------------------------------------------
-- Public API: Force recache for specific item
------------------------------------------------------------

function CollectionAPI:ForceRecache(itemID)
    if not itemID or itemID == "" then
        return
    end

    local numericItemID = tonumber(itemID)
    if not numericItemID then
        return
    end

    -- Clear cache for this item
    if HousingDB and HousingDB.collectedDecor then
        HousingDB.collectedDecor[numericItemID] = nil
    end

    -- Re-check collection status
    return self:IsItemCollected(numericItemID)
end

------------------------------------------------------------
-- Public API: Force recache catalog searcher
------------------------------------------------------------

function CollectionAPI:RecacheCatalogSearcher()
    ForceRecacheCatalogSearcher()
end

------------------------------------------------------------
-- Public API: Batch refresh collection status
-- Refreshes collection status for a list of itemIDs
------------------------------------------------------------

function CollectionAPI:BatchRefreshCollectionStatus(itemIDs)
    if not itemIDs or #itemIDs == 0 then
        return {}
    end

    local refreshed = {}
    PrimeHousingCatalog()

    for _, itemID in ipairs(itemIDs) do
        local numericItemID = tonumber(itemID)
        if numericItemID and not IsItemCached(numericItemID) then
            -- Check collection status (will cache if collected)
            local isCollected = self:IsItemCollected(numericItemID)
            if isCollected then
                table.insert(refreshed, numericItemID)
            end
        end
    end

    return refreshed
end

------------------------------------------------------------
-- Public API: Force scan all housing decor items
-- Scans all items in HousingDecorData and updates collection cache
------------------------------------------------------------

function CollectionAPI:ScanAllDecorItems(callback)
    if not HousingDecorData then
        if callback then
            callback(false, 0, 0, "HousingDecorData not available")
        end
        return
    end
    
    if not C_HousingCatalog then
        if callback then
            callback(false, 0, 0, "Housing Catalog API not available")
        end
        return
    end
    
    -- Prime catalog searcher
    PrimeHousingCatalog()
    
    -- Collect all itemIDs from HousingDecorData
    local itemIDs = {}
    for itemID, decorData in pairs(HousingDecorData) do
        local numericItemID = tonumber(itemID)
        if numericItemID and decorData and decorData.name then
            -- Skip [DNT] items
            if not string.find(decorData.name, "%[DNT%]") then
                table.insert(itemIDs, numericItemID)
            end
        end
    end
    
    local totalItems = #itemIDs
    local scanned = 0
    local collected = 0
    
    -- Scan in batches to avoid performance issues
    local batchSize = 50
    local currentBatch = 1
    
    local function ScanBatch()
        local startIdx = (currentBatch - 1) * batchSize + 1
        local endIdx = math.min(startIdx + batchSize - 1, totalItems)
        
        if startIdx > totalItems then
            -- All done
            if callback then
                callback(true, scanned, collected, nil)
            end
            return
        end
        
        -- Scan this batch
        for i = startIdx, endIdx do
            local itemID = itemIDs[i]
            if itemID then
                -- Force check (bypasses cache)
                local wasCached = IsItemCached(itemID)
                local isCollected = self:IsItemCollected(itemID)
                
                scanned = scanned + 1
                if isCollected and not wasCached then
                    collected = collected + 1
                end
            end
        end
        
        -- Schedule next batch
        currentBatch = currentBatch + 1
        C_Timer.After(0.1, ScanBatch)
    end
    
    -- Start scanning
    ScanBatch()
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("HOUSING_CATALOG_SEARCHER_RELEASED")  -- Critical: recache when searcher is released
eventFrame:RegisterEvent("HOUSING_STORAGE_UPDATED")  -- Fires when storage changes (triggers twice, so delay)
eventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")  -- Zone transition (most reliable)
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")  -- Zone transition fallback
eventFrame:RegisterEvent("PLAYER_LOGOUT")  -- Cleanup on logout

-- Conditionally register Midnight API event (only if available)
local housingCatalogUpdatedRegistered = false
local success, err = pcall(function()
    eventFrame:RegisterEvent("HOUSING_CATALOG_UPDATED")
    housingCatalogUpdatedRegistered = true
end)
if not success then
    -- Event doesn't exist in this client version (not Midnight/12.x), skip it
    housingCatalogUpdatedRegistered = false
end

eventFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "HOUSING_CATALOG_SEARCHER_RELEASED" then
        -- Force recache when searcher is released
        ForceRecacheCatalogSearcher()
    elseif event == "HOUSING_STORAGE_UPDATED" then
        -- This event triggers twice, so add delay
        -- Refresh collection status after storage update
        C_Timer.After(2, function()
            -- Don't clear all - just let it refresh naturally on next check
        end)
    elseif event == "HOUSING_CATALOG_UPDATED" and housingCatalogUpdatedRegistered then
        -- Clear session cache when catalog updates (persistent cache remains)
        -- Only handle if event was successfully registered (Midnight API)
        CollectionAPI:ClearSessionCache()
    elseif event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_ENTERING_WORLD" then
        -- Recache on zone transitions (being aggressive is fine)
        C_Timer.After(0.5, function()
            ForceRecacheCatalogSearcher()
        end)
    elseif event == "PLAYER_LOGOUT" then
        -- Clear session cache on logout (persistent cache is saved automatically)
        CollectionAPI:ClearSessionCache()
    end
end)

------------------------------------------------------------
-- Housing Catalog Tooltip Callback
-- Cache collection status when tooltips are shown in housing catalog UI
-- This provides passive collection updates when users browse the catalog
------------------------------------------------------------

if EventRegistry and EventRegistry.RegisterCallback then
    EventRegistry:RegisterCallback("HousingCatalogEntry.TooltipCreated", function(val1, entryFrame, tooltip)
        -- Don't process when house editor is active (unnecessary)
        if C_HouseEditor and C_HouseEditor.IsHouseEditorActive and C_HouseEditor.IsHouseEditorActive() then
            return
        end

        if not entryFrame or not entryFrame.entryInfo then
            return
        end

        local entryInfo = entryFrame.entryInfo
        
        -- Check collection status from tooltip entryInfo
        -- This provides passive collection updates when users browse the catalog
        if entryInfo.numStored or entryInfo.numPlaced then
            local sum = (entryInfo.numStored or 0) + (entryInfo.numPlaced or 0)
            if sum > 0 and sum < 1000000 then
                -- Try multiple methods to get itemID
                local itemID = nil
                
                -- Method 1: Direct itemID from entryInfo
                if entryInfo.itemID then
                    itemID = entryInfo.itemID
                end
                
                -- Method 2: Try to get from entryID.itemID
                if not itemID and entryInfo.entryID and entryInfo.entryID.itemID then
                    itemID = entryInfo.entryID.itemID
                end
                
                -- Method 3: If we have decorID, try to look up itemID via HousingDecorData
                if not itemID and entryInfo.entryID and entryInfo.entryID.recordID then
                    local decorID = entryInfo.entryID.recordID
                    itemID = GetItemIDFromDecorID(decorID)
                end
                
                -- Method 4: Try to extract from tooltip text (last resort)
                if not itemID and tooltip then
                    -- Tooltip might have item link we can parse
                    local tooltipText = tooltip:GetText()
                    if tooltipText then
                        -- Look for item link pattern: |Hitem:ITEMID:...
                        local itemLinkPattern = "|Hitem:(%d+):"
                        local foundID = tooltipText:match(itemLinkPattern)
                        if foundID then
                            itemID = tonumber(foundID)
                        end
                    end
                end
                
                -- If we have itemID, cache it immediately (passive update)
                if itemID then
                    local numericItemID = tonumber(itemID)
                    if numericItemID then
                        CacheItemAsCollected(numericItemID)
                    end
                end
            end
        end
    end)
end

------------------------------------------------------------
-- Initialize
------------------------------------------------------------

function CollectionAPI:Initialize()
    InitializeCollectionCache()
    PrimeHousingCatalog()
end

-- Make globally accessible
_G["CollectionAPI"] = CollectionAPI

return CollectionAPI

