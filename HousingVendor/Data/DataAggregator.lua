local DATA_ADDON_NAME = ...
local _G = _G

-- Initialize global indexed tables
_G.HousingExpansionData = _G.HousingExpansionData or {}
_G.HousingProfessionData = _G.HousingProfessionData or {}
_G.HousingReputationData = _G.HousingReputationData or {}
_G.HousingCostData = _G.HousingCostData or {}
-- Legacy name used by other modules (Reputation.lua / PreviewPanelData.lua)
_G.HousingReputations = _G.HousingReputations or _G.HousingReputationData

-- Vendor indexing (memory-focused):
-- - Avoid storing a full second copy of vendor item records in `_G.HousingAllVendorItems`.
-- - Instead, store:
--   - A shared vendor pool (`_G.HousingVendorPool`) and per-item vendor index arrays (`_G.HousingItemVendorIndex`)
--   - Compact per-expansion vendor/zone sets for filter dropdown population (`_G.HousingVendorFilterIndex`)
_G.HousingVendorPool = _G.HousingVendorPool or {}
_G.HousingVendorPoolIndex = _G.HousingVendorPoolIndex or {}
_G.HousingItemVendorIndex = _G.HousingItemVendorIndex or {}
_G.HousingVendorFilterIndex = _G.HousingVendorFilterIndex or { vendorsByExpansion = {}, zonesByExpansion = {} }

-- PERFORMANCE: Defer all data processing until first UI open
-- Store raw data in pending tables during file load, then process later
local pendingVendorData = {}
local pendingQuestData = {}
local pendingAchievementData = {}
local pendingDropData = {}
local pendingReputationData = {}
local pendingProfessionData = {}
local pendingCostData = {}
local isDataProcessed = false

-- Counters for statistics
local stats = {
    vendorCount = 0,
    questCount = 0,
    achievementCount = 0,
    dropCount = 0,
    reputationCount = 0,
    professionCount = 0
}

local function SafeString(v)
    if v == nil then return "" end
    if type(v) == "string" then return v end
    return tostring(v)
end

local function NormalizeNameKey(value)
    if value == nil then return nil end
    local s = tostring(value)
    s = s:lower()
    s = s:gsub("%s+", " ")
    s = s:match("^%s*(.-)%s*$")
    return (s and s ~= "") and s or nil
end

local function ResolveReputationFactionID(factionIDOrName)
    if factionIDOrName == nil or factionIDOrName == "" or factionIDOrName == "None" then
        return nil
    end

    local num = tonumber(factionIDOrName)
    if num then
        return tostring(num)
    end

    local key = NormalizeNameKey(factionIDOrName)
    if key then
        if _G.HousingVendorFactionIDsNormalized and _G.HousingVendorFactionIDsNormalized[key] then
            return tostring(_G.HousingVendorFactionIDsNormalized[key])
        end
        if _G.HousingVendorFactionIDs and _G.HousingVendorFactionIDs[factionIDOrName] then
            return tostring(_G.HousingVendorFactionIDs[factionIDOrName])
        end
    end

    return tostring(factionIDOrName)
end

local function AddFilterEntry(expansion, vendorName, zoneName)
    if not expansion or expansion == "" then
        return
    end

    local vfi = _G.HousingVendorFilterIndex
    if not vfi then
        return
    end

    if vendorName and vendorName ~= "" then
        local vendors = vfi.vendorsByExpansion[expansion]
        if not vendors then
            vendors = {}
            vfi.vendorsByExpansion[expansion] = vendors
        end
        vendors[vendorName] = true
    end

    if zoneName and zoneName ~= "" then
        local zones = vfi.zonesByExpansion[expansion]
        if not zones then
            zones = {}
            vfi.zonesByExpansion[expansion] = zones
        end
        zones[zoneName] = true
    end
end

local function GetOrCreateVendorIndex(vd)
    if not vd then return nil end

    local name = vd.vendorName
    local location = vd.location
    local faction = vd.faction
    local expansion = vd.expansion

    if not name or name == "" or name == "None" then
        return nil
    end

    -- Convert numeric faction to string for consistent comparisons
    if type(faction) == "number" then
        if faction == 0 then
            faction = "Neutral"
        elseif faction == 1 then
            faction = "Alliance"
        elseif faction == 2 then
            faction = "Horde"
        end
    end

    local key = SafeString(name) .. "|" .. SafeString(location) .. "|" .. SafeString(faction) .. "|" .. SafeString(expansion)
    local existing = _G.HousingVendorPoolIndex[key]
    if existing then
        return existing
    end

    local idx = #_G.HousingVendorPool + 1
    _G.HousingVendorPool[idx] = {
        name = name,
        location = location,
        coords = vd.coords,
        faction = faction,  -- Now stored as string
        expansion = expansion,
    }
    _G.HousingVendorPoolIndex[key] = idx
    return idx
end

-- Helper to register data by itemID
local function RegisterByItemID(targetTable, items, dataType, statKey)
    if not items then return end
    for _, item in ipairs(items) do
        local itemID = tonumber(item.itemID)
        if itemID then
            if not targetTable[itemID] then
                targetTable[itemID] = {}
            end

            -- For quest/achievement/drop, store arrays to support multiple sources per item
            -- For vendor, keep single entry (vendors are handled separately via HousingItemVendorIndex)
            if dataType == "quest" or dataType == "achievement" or dataType == "drop" then
                if not targetTable[itemID][dataType] then
                    targetTable[itemID][dataType] = {}
                end
                -- Add to array instead of overwriting
                table.insert(targetTable[itemID][dataType], item)
            else
                -- Vendor and other types use single entry (vendor has separate index system)
                targetTable[itemID][dataType] = item
            end

            if statKey then
                stats[statKey] = stats[statKey] + 1
            end
        end
    end
end

-- Public registration API (preferred by data files)
_G.HousingDataAggregator = _G.HousingDataAggregator or {}

function _G.HousingDataAggregator:RegisterExpansionItems(dataType, items)
    -- PERFORMANCE: Don't process data at file load time - just store it for later
    -- This eliminates the 20%+ CPU spike at ADDON_LOADED
    if dataType == "vendor" then
        table.insert(pendingVendorData, items)
    elseif dataType == "quest" then
        table.insert(pendingQuestData, items)
    elseif dataType == "achievement" then
        table.insert(pendingAchievementData, items)
    elseif dataType == "drop" then
        table.insert(pendingDropData, items)
    end
end

function _G.HousingDataAggregator:RegisterReputation(items)
    -- PERFORMANCE: Defer processing until UI opens
    if items then
        table.insert(pendingReputationData, items)
    end
end

function _G.HousingDataAggregator:RegisterProfession(items)
    -- PERFORMANCE: Defer processing until UI opens
    if items then
        table.insert(pendingProfessionData, items)
    end
end

function _G.HousingDataAggregator:RegisterCosts(costs)
    -- PERFORMANCE: Defer processing until UI opens
    if type(costs) == "table" then
        table.insert(pendingCostData, costs)
    end
end

-- PERFORMANCE: Process all pending data (called on first UI open)
function _G.HousingDataAggregator:ProcessPendingData()
    if isDataProcessed then
        return  -- Already processed
    end

    print("|cFF8A7FD4HousingVendor:|r Processing deferred data aggregation...")

    -- Process vendor data
    for _, items in ipairs(pendingVendorData) do
        RegisterByItemID(_G.HousingExpansionData, items, "vendor", "vendorCount")

        if items then
            for _, item in ipairs(items) do
                local itemID = tonumber(item and item.itemID)
                local vd = item and item.vendorDetails or nil

                if vd then
                    if vd.factionID and vd.factionID ~= "" and vd.factionID ~= "None" then
                        vd.factionID = ResolveReputationFactionID(vd.factionID) or vd.factionID
                    end

                    local expansion = vd.expansion
                    local vendorName = vd.vendorName
                    local zoneName = vd.location

                    if vendorName and vendorName ~= "" and vendorName ~= "None" then
                        AddFilterEntry(expansion, vendorName, zoneName)

                        local vendorIndex = GetOrCreateVendorIndex(vd)
                        if itemID and vendorIndex then
                            local list = _G.HousingItemVendorIndex[itemID]
                            if not list then
                                list = {}
                                _G.HousingItemVendorIndex[itemID] = list
                            end
                            list[#list + 1] = vendorIndex
                        end
                    end
                end
            end
        end
    end

    -- Process quest data
    for _, items in ipairs(pendingQuestData) do
        RegisterByItemID(_G.HousingExpansionData, items, "quest", "questCount")
    end

    -- Process achievement data
    for _, items in ipairs(pendingAchievementData) do
        RegisterByItemID(_G.HousingExpansionData, items, "achievement", "achievementCount")
    end

    -- Process drop data
    for _, items in ipairs(pendingDropData) do
        RegisterByItemID(_G.HousingExpansionData, items, "drop", "dropCount")
    end

    -- Process reputation data
    for _, items in ipairs(pendingReputationData) do
        for _, item in ipairs(items) do
            -- Check if this is a faction definition
            if item.factionID and not item.itemID then
                local factionIDStr = tostring(item.factionID)
                local factionIDNum = tonumber(item.factionID)

                _G.HousingReputationData[factionIDStr] = item
                _G.HousingReputations[factionIDStr] = item

                if factionIDNum then
                    _G.HousingReputationData[factionIDNum] = item
                    _G.HousingReputations[factionIDNum] = item
                end
                stats.reputationCount = stats.reputationCount + 1
            end

            -- Check if this is a reputation-gated item
            if item.itemID and item.vendorDetails then
                local itemID = tonumber(item.itemID)
                if itemID then
                    if not _G.HousingExpansionData[itemID] then
                        _G.HousingExpansionData[itemID] = {}
                    end
                    _G.HousingExpansionData[itemID].vendor = item

                    local vd = item.vendorDetails
                    if vd then
                        if vd.factionID and vd.factionID ~= "" and vd.factionID ~= "None" then
                            vd.factionID = ResolveReputationFactionID(vd.factionID) or vd.factionID
                        end

                        local expansion = vd.expansion
                        local vendorName = vd.vendorName
                        local zoneName = vd.location

                        if vendorName and vendorName ~= "" and vendorName ~= "None" then
                            AddFilterEntry(expansion, vendorName, zoneName)

                            local vendorIndex = GetOrCreateVendorIndex(vd)
                            if vendorIndex then
                                local list = _G.HousingItemVendorIndex[itemID]
                                if not list then
                                    list = {}
                                    _G.HousingItemVendorIndex[itemID] = list
                                end
                                list[#list + 1] = vendorIndex
                            end
                        end
                    end
                end
            end
        end
    end

    -- Process profession data
    for _, items in ipairs(pendingProfessionData) do
        for _, item in ipairs(items) do
            local itemID = tonumber(item.itemID)
            if itemID and not _G.HousingProfessionData[itemID] then
                _G.HousingProfessionData[itemID] = item
                stats.professionCount = stats.professionCount + 1
            end
        end
    end

    -- Process cost data
    for _, costs in ipairs(pendingCostData) do
        local function ApplyCostForItemID(itemID, costInfo)
            local idNum = tonumber(itemID)
            if not idNum or type(costInfo) ~= "table" then
                return
            end

            local existing = _G.HousingCostData[idNum]
            if not existing then
                existing = {}
                _G.HousingCostData[idNum] = existing
            end

            if (existing.cost == nil or existing.cost == "") and type(costInfo.cost) == "string" and costInfo.cost ~= "" then
                existing.cost = costInfo.cost
            end

            if (existing.buyPriceCopper == nil or existing.buyPriceCopper == 0) and tonumber(costInfo.buyPriceCopper) then
                existing.buyPriceCopper = tonumber(costInfo.buyPriceCopper) or existing.buyPriceCopper
            end

            if (existing.costComponents == nil or type(existing.costComponents) ~= "table" or #existing.costComponents == 0) and type(costInfo.costComponents) == "table" then
                existing.costComponents = costInfo.costComponents
            end
        end

        for itemID, costInfo in pairs(costs) do
            if type(itemID) == "table" then
                for _, groupedID in ipairs(itemID) do
                    ApplyCostForItemID(groupedID, costInfo)
                end
            else
                ApplyCostForItemID(itemID, costInfo)
            end
        end
    end

    -- Clear pending data to free memory
    pendingVendorData = {}
    pendingQuestData = {}
    pendingAchievementData = {}
    pendingDropData = {}
    pendingReputationData = {}
    pendingProfessionData = {}
    pendingCostData = {}

    isDataProcessed = true

    -- Report stats
    local expansionCount = 0
    for _ in pairs(_G.HousingExpansionData) do
        expansionCount = expansionCount + 1
    end
    print(string.format("|cFF8A7FD4HousingVendor:|r Processed %d items (%d vendors, %d quests, %d achievements, %d professions)",
        expansionCount, stats.vendorCount, stats.questCount, stats.achievementCount, stats.professionCount))
end

-- Convenience function globals for generated files
function _G.HousingDataAggregator_RegisterExpansionItems(dataType, items)
    return _G.HousingDataAggregator:RegisterExpansionItems(dataType, items)
end

function _G.HousingDataAggregator_RegisterReputation(items)
    return _G.HousingDataAggregator:RegisterReputation(items)
end

function _G.HousingDataAggregator_RegisterProfession(items)
    return _G.HousingDataAggregator:RegisterProfession(items)
end

function _G.HousingDataAggregator_RegisterCosts(costs)
    return _G.HousingDataAggregator:RegisterCosts(costs)
end

-- Legacy compatibility (best-effort):
-- Some old generated files assign globals like `vendor = { ... }` instead of calling the
-- registration helpers. Historically we captured that via a _G metatable hook, but modern WoW
-- clients protect _G's metatable and will error ("cannot change a protected metatable").
--
-- We now attempt to install the hook safely; if it's blocked, data files must use the explicit
-- `HousingDataAggregator_Register*` functions (all current generated files do).
-- NOTE: Disabled by default to prevent UI taint (this hook can taint protected UI on ESC/logout).
local ENABLE_LEGACY_GLOBAL_ASSIGNMENT_HOOK = false
local function TryInstallLegacyGlobalAssignmentHook()
    local existingMeta = getmetatable(_G)
    if type(existingMeta) ~= "table" then
        existingMeta = nil
    end

    local originalNewIndex = (existingMeta and existingMeta.__newindex) or rawset
    local newMeta = existingMeta or {}

    newMeta.__newindex = function(t, key, value)
        local success, err = pcall(function()
            if key == "vendor" and type(value) == "table" then
                _G.HousingDataAggregator:RegisterExpansionItems("vendor", value)
            elseif key == "quest" and type(value) == "table" then
                _G.HousingDataAggregator:RegisterExpansionItems("quest", value)
            elseif key == "achievement" and type(value) == "table" then
                _G.HousingDataAggregator:RegisterExpansionItems("achievement", value)
            elseif key == "drop" and type(value) == "table" then
                _G.HousingDataAggregator:RegisterExpansionItems("drop", value)
            elseif key == "reputation" and type(value) == "table" then
                _G.HousingDataAggregator:RegisterReputation(value)
            elseif key == "profession" and type(value) == "table" then
                _G.HousingDataAggregator:RegisterProfession(value)
            end
        end)

        if not success then
            print("|cFFFF0000HousingVendor DataAggregator Error:|r " .. tostring(err))
        end

        if originalNewIndex == rawset then
            rawset(t, key, value)
        else
            originalNewIndex(t, key, value)
        end
    end

    pcall(setmetatable, _G, newMeta)
end

if ENABLE_LEGACY_GLOBAL_ASSIGNMENT_HOOK then
    TryInstallLegacyGlobalAssignmentHook()
end

-- PERFORMANCE: No ADDON_LOADED handler needed - all processing is deferred to first UI open
-- Previously this calculated stats, but that work is now done in ProcessPendingData()
