-- Data Manager (core)
-- This file intentionally stays small; implementation lives in `Modules/UI/DataManager/*.lua`.

local _G = _G

local DataManager = {}
DataManager.__index = DataManager

DataManager._state = {
    itemCache = nil,
    filterOptionsCache = nil,
    filteredResultsCache = nil,
    lastFilterHash = nil,
    batchLoadInProgress = false,
    isInitialized = false,

    -- Low-overhead mode (IDs + on-demand records)
    allItemIDs = nil,
    filteredIDCache = nil,
    _itemMeta = nil,
    _seenExpansions = nil,
    _nameCache = nil,
    _itemRecordCache = nil,
    _itemRecordCacheCount = 0,

    -- Pre-allocated tables for FilterItems (performance optimization)
    filteredResults = {},
    debugCounts = {},

    -- UI lifecycle (used to gate background work)
    uiActive = false,
}

DataManager.Constants = DataManager.Constants or {}
DataManager.Util = DataManager.Util or {}

function DataManager:Initialize()
    if self._state.isInitialized then return end
    self._state.itemCache = nil
    self._state.filterOptionsCache = nil
    self._state.filteredResultsCache = nil
    self._state.lastFilterHash = nil
    self._state.batchLoadInProgress = false
    self._state.isInitialized = true
end

function DataManager:IsInitialized()
    return self._state.isInitialized
end

function DataManager:HasItemCache()
    return self._state.itemCache ~= nil
end

-- Helper: Convert hash table keys to sorted array
function DataManager:_SortKeys(hashTable)
    local keys = {}
    for key in pairs(hashTable) do
        table.insert(keys, key)
    end
    table.sort(keys)
    return keys
end

-- Get filter options (expansions, vendors, zones, etc.)
function DataManager:GetFilterOptions()
    if not self._state.filterOptionsCache then
        if self.GetAllItemIDs then
            self:GetAllItemIDs() -- Populates filterOptionsCache via Indexing.lua
        else
            self:GetAllItems() -- Legacy fallback
        end
    end
    return self._state.filterOptionsCache
end

-- Public method to check if an item is collected (for use by other modules)
-- Uses centralized HousingCollectionAPI
function DataManager:IsItemCollected(itemID)
    if HousingCollectionAPI then
        return HousingCollectionAPI:IsItemCollected(itemID)
    end
    return false
end

-- Clear cache (call when data changes)
function DataManager:ClearCache()
    self._state.itemCache = nil
    self._state.filterOptionsCache = nil
    self._state.filteredResultsCache = nil
    self._state.lastFilterHash = nil
    self._state.batchLoadInProgress = false
    self._state.allItemIDs = nil
    self._state.filteredIDCache = nil
    self._state._itemMeta = nil
    self._state._seenExpansions = nil
    self._state._nameCache = nil
    self._state._itemRecordCache = nil
    self._state._itemRecordCacheCount = 0
    self._state.uiActive = false
    self._state._qualityRetryAt = nil
    self._state._lastQualityWarmKick = nil

    if self.Util and self.Util.ClearApiDataCache then
        self.Util.ClearApiDataCache()
    end
end

function DataManager:SetUIActive(active)
    self._state.uiActive = active == true
end

function DataManager:IsUIActive()
    return self._state.uiActive == true
end

-- Invalidate filter cache (call when collection status changes)
function DataManager:InvalidateFilterCache()
    self._state.filteredResultsCache = nil
    self._state.lastFilterHash = nil
end

-- Make globally accessible
_G["HousingDataManager"] = DataManager

-- Register mem stats
if _G.HousingMemReport and _G.HousingMemReport.Register then
    _G.HousingMemReport:Register("DataManager", function()
        local s = DataManager._state or {}
        local function CountKeys(t)
            if type(t) ~= "table" then return 0 end
            local n = 0
            for _ in pairs(t) do n = n + 1 end
            return n
        end
        local function CountArray(t)
            if type(t) ~= "table" then return 0 end
            local n = #t
            if n and n > 0 then return n end
            return CountKeys(t)
        end

        local vendorPoolSize = 0
        local pool = _G.HousingVendorPool
        if type(pool) == "table" then
            vendorPoolSize = #pool
            if vendorPoolSize == 0 then
                vendorPoolSize = CountKeys(pool)
            end
        end

        return {
            itemCache = (s.itemCache and CountArray(s.itemCache) or 0),
            filtered = (s.filteredResultsCache and CountArray(s.filteredResultsCache) or 0),
            filterOptions = (s.filterOptionsCache and 1 or 0),
            vendorPool = vendorPoolSize,
        }
    end)
end

return DataManager
