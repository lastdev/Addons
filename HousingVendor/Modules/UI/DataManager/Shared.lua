-- Shared utilities/constants for HousingDataManager (loaded after Modules/UI/DataManager.lua)

local _G = _G

local DataManager = _G["HousingDataManager"]
if not DataManager then return end

-- Cache global references for performance
local pairs = pairs
local tonumber = tonumber
local tostring = tostring
local string_find = string.find
local string_lower = string.lower
local string_match = string.match
local string_gsub = string.gsub
local table_insert = table.insert
local table_sort = table.sort

DataManager.Constants = DataManager.Constants or {}
DataManager.Util = DataManager.Util or {}

local Constants = DataManager.Constants
local Util = DataManager.Util

-- String interning - reuse common strings to save memory
local INTERNED_STRINGS = {}
local function InternString(str)
    if not str then return str end
    if not INTERNED_STRINGS[str] then
        INTERNED_STRINGS[str] = str
    end
    return INTERNED_STRINGS[str]
end
Util.InternString = InternString
Util.INTERNED_STRINGS = INTERNED_STRINGS

-- Pre-intern common source types to avoid duplicates
INTERNED_STRINGS["Vendor"] = "Vendor"
INTERNED_STRINGS["Reputation"] = "Reputation"
INTERNED_STRINGS["Renown"] = "Renown"
INTERNED_STRINGS["Drop"] = "Drop"
INTERNED_STRINGS["Profession"] = "Profession"
INTERNED_STRINGS["Achievement"] = "Achievement"
INTERNED_STRINGS["Quest"] = "Quest"
INTERNED_STRINGS["Neutral"] = "Neutral"
INTERNED_STRINGS["Alliance"] = "Alliance"
INTERNED_STRINGS["Horde"] = "Horde"

-- Helper function to get API data cache (stored in HousingDB for persistence)
-- Session-only by default (to keep login memory low): do not persist large API caches in SavedVariables.
-- Note: older versions may have populated `HousingDB.apiDataCache` / `HousingDB.apiDataCacheAccess`; Core/Events.lua purges them on load.
local API_DATA_CACHE_MAX_ENTRIES = 5000
local API_DATA_CACHE_TRIM_TO = 4500

local sessionApiDataCache = {}
local sessionApiDataCacheAccess = {}

local function GetApiDataCache()
    return sessionApiDataCache
end
Util.GetApiDataCache = GetApiDataCache

local function GetApiDataCacheAccess()
    return sessionApiDataCacheAccess
end
Util.GetApiDataCacheAccess = GetApiDataCacheAccess

local function TouchApiDataCacheItem(itemID)
    if not itemID then return end
    local access = GetApiDataCacheAccess()
    access[itemID] = GetTime and GetTime() or 0
end
Util.TouchApiDataCacheItem = TouchApiDataCacheItem

local function PruneApiDataCacheIfNeeded(apiDataCache)
    if not apiDataCache or API_DATA_CACHE_MAX_ENTRIES <= 0 then
        return
    end

    local count = 0
    for _ in pairs(apiDataCache) do
        count = count + 1
        if count > API_DATA_CACHE_MAX_ENTRIES then
            break
        end
    end

    if count <= API_DATA_CACHE_MAX_ENTRIES then
        return
    end

    local access = GetApiDataCacheAccess()
    local entries = {}
    for id in pairs(apiDataCache) do
        table_insert(entries, { id = id, ts = access[id] or 0 })
    end
    table_sort(entries, function(a, b) return (a.ts or 0) < (b.ts or 0) end)

    local target = API_DATA_CACHE_TRIM_TO
    if target < 0 or target >= API_DATA_CACHE_MAX_ENTRIES then
        target = math.floor(API_DATA_CACHE_MAX_ENTRIES * 0.9)
    end

    local toRemove = #entries - target
    for i = 1, toRemove do
        local id = entries[i] and entries[i].id
        if id ~= nil then
            apiDataCache[id] = nil
            access[id] = nil
        end
    end
end
Util.PruneApiDataCacheIfNeeded = PruneApiDataCacheIfNeeded

local function ClearApiDataCache()
    sessionApiDataCache = {}
    sessionApiDataCacheAccess = {}
end
Util.ClearApiDataCache = ClearApiDataCache

-- Register mem stats
if _G.HousingMemReport and _G.HousingMemReport.Register then
    _G.HousingMemReport:Register("DBCaches", function()
        local function CountKeys(t)
            if type(t) ~= "table" then return 0 end
            local n = 0
            for _ in pairs(t) do n = n + 1 end
            return n
        end
        return {
            apiData = CountKeys(sessionApiDataCache),
            apiAccess = CountKeys(sessionApiDataCacheAccess),
            icons = (HousingIcons and HousingIcons.GetCacheStats and (HousingIcons:GetCacheStats().cache or 0)) or 0,
            wishlist = (HousingDB and CountKeys(HousingDB.wishlist) or 0),
            collectedDecor = (HousingDB and CountKeys(HousingDB.collectedDecor) or 0),
        }
    end)
end

local function InferFactionFromText(text)
    local lowerText = string_lower(tostring(text or ""))

    for _, keyword in ipairs(Constants.hordeFactionKeywords or {}) do
        if string_find(lowerText, keyword) then
            return INTERNED_STRINGS["Horde"]
        end
    end

    for _, keyword in ipairs(Constants.allianceFactionKeywords or {}) do
        if string_find(lowerText, keyword) then
            return INTERNED_STRINGS["Alliance"]
        end
    end

    return INTERNED_STRINGS["Neutral"]
end
Util.InferFactionFromText = InferFactionFromText

local function NormalizeVendorName(vendorName)
    if not vendorName then return nil end
    if type(vendorName) ~= "string" then
        vendorName = tostring(vendorName)
    end
    if vendorName == "" then return nil end

    local trimmed = string_match(vendorName, "^%s*(.-)%s*$")
    if not trimmed or trimmed == "" then return nil end
    return string_lower(string_gsub(trimmed, '["\']', ""))
end
Util.NormalizeVendorName = NormalizeVendorName

local function CoalesceNonEmptyString(primary, fallback)
    if primary ~= nil and primary ~= "" then
        return primary
    end
    return fallback
end
Util.CoalesceNonEmptyString = CoalesceNonEmptyString

-- Quality names lookup (from Enum.ItemQuality)
Constants.QUALITY_NAMES = {
    [0] = "Poor",
    [1] = "Common",
    [2] = "Uncommon",
    [3] = "Rare",
    [4] = "Epic",
    [5] = "Legendary",
    [6] = "Artifact",
    [7] = "Heirloom"
}

-- Faction lookup tables (pre-built for performance)
Constants.hordeFactionKeywords = {
    "orgrimmar", "thunder bluff", "undercity", "silvermoon",
    "durotar", "mulgore", "tirisfal", "eversong"
}
Constants.allianceFactionKeywords = {
    "stormwind", "ironforge", "darnassus", "exodar",
    "elwynn", "dun morogh", "teldrassil", "azuremyst"
}

-- Crafted source detection is driven by `HousingProfessionData` now.
-- Keep this table for backwards compatibility, but don't populate it at load time.
Constants.CRAFTED_ITEMS_LOOKUP = Constants.CRAFTED_ITEMS_LOOKUP or {}

-- Convenience helper: non-alloc table lower checks used by filters
function Util.StringContainsAny(haystack, needles)
    if not haystack or haystack == "" or not needles then return false end
    local lower = string_lower(haystack)
    for i = 1, #needles do
        if string_find(lower, needles[i], 1, true) then
            return true
        end
    end
    return false
end

-- ============================================================================
-- Consolidated Functions (moved from duplicate locations)
-- ============================================================================

--- Clean WoW formatting codes from text (color codes, icons, hyperlinks, etc)
--- Previously duplicated in: PreviewPanelData.lua, HousingAPI.lua, PreviewPanelUI.lua
--- @param text string The text to clean
--- @param preserveIcons boolean Optional: if true, keep |T texture icons
--- @return string Cleaned text
function Util.CleanText(text, preserveIcons)
    if not text or text == "" then return "" end
    local clean = text
    clean = string_gsub(clean, "|c%x%x%x%x%x%x%x%x", "")  -- Remove color codes
    clean = string_gsub(clean, "|r", "")  -- Remove color reset
    clean = string_gsub(clean, "|H[^|]*|h", "")  -- Remove hyperlink start
    clean = string_gsub(clean, "|h", "")  -- Remove hyperlink end
    if not preserveIcons then
        clean = string_gsub(clean, "|T[^|]*|t", "")  -- Remove texture icons
    end
    clean = string_gsub(clean, "|n", " ")  -- Replace newlines with spaces
    clean = string_match(clean, "^%s*(.-)%s*$") or clean  -- Trim whitespace
    return clean
end

--- Serialize a set table to a sorted comma-separated string for cache keys
--- Previously duplicated in: Filtering.lua, Indexing.lua
--- @param setTable table A table where selected items are marked as true
--- @return string Sorted comma-separated list of selected keys
local function SerializeSelectedSet(setTable)
    if not setTable then return "" end
    local keys = {}
    for key, selected in pairs(setTable) do
        if selected then
            table_insert(keys, tostring(key))
        end
    end
    table_sort(keys)
    return table.concat(keys, ",")
end
Util.SerializeSelectedSet = SerializeSelectedSet

--- Generate hash key from filter values for caching filtered results
--- Previously duplicated in: Filtering.lua, Indexing.lua
--- @param filters table Filter configuration object
--- @return string Hash string representing filter state
-- Reusable table to avoid allocation on every call (performance optimization)
local filterHashParts = {}

function Util.GetFilterHash(filters)
    wipe(filterHashParts)

    filterHashParts[1] = filters.searchText or ""
    filterHashParts[2] = filters.expansion or ""
    filterHashParts[3] = filters.vendor or ""
    filterHashParts[4] = filters.zone or ""
    filterHashParts[5] = filters.type or ""
    filterHashParts[6] = filters.category or ""
    filterHashParts[7] = filters.faction or ""
    filterHashParts[8] = filters.source or ""
    filterHashParts[9] = filters.collection or ""
    filterHashParts[10] = filters.quality or ""
    filterHashParts[11] = filters.requirement or ""
    filterHashParts[12] = SerializeSelectedSet(filters.selectedExpansions)
    filterHashParts[13] = SerializeSelectedSet(filters.selectedCategories)
    filterHashParts[14] = SerializeSelectedSet(filters.selectedSources)
    filterHashParts[15] = filters.hideVisited and "1" or "0"
    filterHashParts[16] = filters.hideNotReleased and "1" or "0"
    filterHashParts[17] = filters.showOnlyAvailable and "1" or "0"

    return table.concat(filterHashParts, "|")
end
