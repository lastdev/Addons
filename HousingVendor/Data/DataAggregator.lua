local DATA_ADDON_NAME = ...
local _G = _G

-- Initialize global indexed tables
_G.HousingExpansionData = _G.HousingExpansionData or {}
_G.HousingProfessionData = _G.HousingProfessionData or {}
_G.HousingProfessionTrainers = _G.HousingProfessionTrainers or {}
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
local pendingRewardData = {}
local pendingReputationData = {}
local pendingProfessionData = {}
local pendingProfessionTrainerData = {}
local pendingCostData = {}
local isDataProcessed = false
local isProcessingPendingData = false
local dataRevision = 0

local function HasAnyPendingData()
    return (#pendingVendorData > 0)
        or (#pendingQuestData > 0)
        or (#pendingAchievementData > 0)
        or (#pendingDropData > 0)
        or (#pendingRewardData > 0)
        or (#pendingReputationData > 0)
        or (#pendingProfessionData > 0)
        or (#pendingProfessionTrainerData > 0)
        or (#pendingCostData > 0)
end

local function Info(msg)
    local log = _G.HousingVendorLog
    if log and log.Info then
        log:Info(msg)
    end
end

-- Counters for statistics
local stats = {
    vendorCount = 0,
    questCount = 0,
    achievementCount = 0,
    dropCount = 0,
    rewardCount = 0,
    reputationCount = 0,
    professionCount = 0,
    professionTrainerCount = 0,
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
    local npcID = vd.npcID

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
        -- Backfill npcID if later data provides it (older pool entries may not include it).
        local existingVendor = _G.HousingVendorPool and _G.HousingVendorPool[existing]
        if existingVendor and (existingVendor.npcID == nil or existingVendor.npcID == "" or existingVendor.npcID == "None" or existingVendor.npcID == 0) then
            if npcID ~= nil and npcID ~= "" and npcID ~= "None" and npcID ~= 0 then
                existingVendor.npcID = npcID
            end
        end
        return existing
    end

    local idx = #_G.HousingVendorPool + 1
    _G.HousingVendorPool[idx] = {
        name = name,
        location = location,
        coords = vd.coords,
        faction = faction,  -- Now stored as string
        expansion = expansion,
        npcID = (npcID ~= nil and npcID ~= "" and npcID ~= "None" and npcID ~= 0) and npcID or nil,
    }
    _G.HousingVendorPoolIndex[key] = idx
    return idx
end

-- Iterate over both dense arrays and sparse numeric-keyed tables.
-- `ipairs()` stops at the first nil, which drops later entries in sparse tables like {[1]=..., [30]=...}.
local function IterateSparseNumeric(t)
    if type(t) ~= "table" then
        return ipairs({})
    end

    local n = #t
    for k in pairs(t) do
        if type(k) == "number" and k >= 1 and k % 1 == 0 and k > n then
            local keys = {}
            for kk in pairs(t) do
                if type(kk) == "number" and kk >= 1 and kk % 1 == 0 then
                    keys[#keys + 1] = kk
                end
            end
            table.sort(keys)

            local i = 0
            return function()
                i = i + 1
                local key = keys[i]
                if not key then
                    return nil
                end
                return i, t[key]
            end
        end
    end

    return ipairs(t)
end

-- Helper to register data by itemID
local function RegisterByItemID(targetTable, items, dataType, statKey)
    if not items then return end

    for _, item in IterateSparseNumeric(items) do
        local itemID = tonumber(item and item.itemID)
        if not itemID and item and item.itemID ~= nil then
            itemID = tonumber(tostring(item.itemID))
        end
        if itemID then
            -- Some autogenerated datapacks used a "quest" placeholder row for items that were actually
            -- copied from vendor tables (questID=0 / "Transferred from VendorLocations"). These pollute
            -- the UI by showing "Quest" without real quest details.
            local skip = false
            if dataType == "quest" and type(item) == "table" then
                local qid = tonumber(item.questId or item.questID)
                if qid == 0 then
                    skip = true
                elseif type(item.questName) == "string" and item.questName:find("Transferred from VendorLocations", 1, true) then
                    skip = true
                end
            end
            if skip then
                -- do nothing
            else
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
    elseif dataType == "reward" then
        table.insert(pendingRewardData, items)
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

function _G.HousingDataAggregator:RegisterProfessionTrainers(trainers)
    -- PERFORMANCE: Defer processing until UI opens
    if type(trainers) == "table" then
        table.insert(pendingProfessionTrainerData, trainers)
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
    if isProcessingPendingData then
        return
    end
    if not HasAnyPendingData() then
        isDataProcessed = true
        return
    end

    isProcessingPendingData = true

    local function ProcessImpl()
        Info("Processing deferred data aggregation...")

        -- Process vendor data
        for _, items in ipairs(pendingVendorData) do
            RegisterByItemID(_G.HousingExpansionData, items, "vendor", "vendorCount")

            if items then
                for _, item in IterateSparseNumeric(items) do
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

                    -- Extract cost data from vendor items (new format with goldCost/currencies)
                    if itemID then
                        local goldCost = item.goldCost
                        local currencies = item.currencies
                        local itemCosts = item.itemCosts

                        -- Only store if there's actual cost data
                        local hasCost = (goldCost and goldCost > 0) or (currencies and #currencies > 0) or (itemCosts and #itemCosts > 0)
                        if hasCost then
                            local costEntry = _G.HousingCostData[itemID]
                            if not costEntry then
                                costEntry = {}
                                _G.HousingCostData[itemID] = costEntry
                            end

                            -- Store gold cost (in copper)
                            if goldCost and goldCost > 0 and (not costEntry.buyPriceCopper or costEntry.buyPriceCopper == 0) then
                                costEntry.buyPriceCopper = goldCost
                            end

                            -- Convert currencies to costComponents format
                            if currencies and #currencies > 0 and (not costEntry.costComponents or #costEntry.costComponents == 0) then
                                costEntry.costComponents = {}
                                for _, curr in ipairs(currencies) do
                                    if curr.currencyID and curr.amount then
                                        table.insert(costEntry.costComponents, {
                                            currencyTypeID = curr.currencyID,
                                            amount = curr.amount,
                                        })
                                    end
                                end
                            end

                            -- Convert itemCosts to costComponents format (items required as currency)
                            if itemCosts and #itemCosts > 0 then
                                if not costEntry.costComponents then
                                    costEntry.costComponents = {}
                                end
                                for _, itemCost in ipairs(itemCosts) do
                                    if itemCost.itemID and itemCost.amount then
                                        table.insert(costEntry.costComponents, {
                                            itemID = tonumber(itemCost.itemID),
                                            amount = itemCost.amount,
                                        })
                                    end
                                end
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

        -- Process reward data
        for _, items in ipairs(pendingRewardData) do
            RegisterByItemID(_G.HousingExpansionData, items, "reward", "rewardCount")
        end

        -- Process reputation data
        for _, items in ipairs(pendingReputationData) do
            local repVendors = nil
            if type(items) == "table" then
                repVendors = items.vendors or items.Vendors or nil
            end

            for _, item in IterateSparseNumeric(items) do
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

                local function IndexReputationItem(repItem, parentFaction)
                    if not (repItem and repItem.itemID) then
                        return
                    end

                    -- Some reputation datasets store vendor info only on the faction header and omit per-reward vendorDetails.
                    -- Synthesize vendorDetails so these vendors appear in Vendor dropdowns and vendor pool indexing.
                    if repItem.vendorDetails == nil and type(parentFaction) == "table" then
                        local vd = nil

                        -- New format: reward/vendor items can reference a shared `vendors` table via `vendorId`,
                        -- similar to VendorLocations files.
                        local vendorRef = nil
                        local vendorId = repItem.vendorId or parentFaction.vendorId

                        -- Some reputations have different vendors per player faction (same reputation factionID).
                        -- Keep the data files static and pick the correct vendor here.
                        local pf = nil
                        pcall(function()
                            if _G.UnitFactionGroup then
                                pf = _G.UnitFactionGroup("player")
                            end
                        end)

                        if tonumber(parentFaction.factionID) == 1515 then
                            -- Arakkoa Outcasts (WoD): Stormshield vs Warspear vendors
                            vendorId = (pf == "Horde") and 54 or 47
                        end

                        if vendorId ~= nil and type(repVendors) == "table" then
                            vendorRef = repVendors[vendorId] or repVendors[tonumber(vendorId)]
                        end

                        if type(vendorRef) == "table" then
                            local coords = vendorRef.coords
                            local mapID = nil
                            local x = nil
                            local y = nil

                            if type(coords) == "table" then
                                mapID = tonumber(coords.mapID or coords.MapID)
                                x = tonumber(coords.x)
                                y = tonumber(coords.y)
                            end

                            if not mapID then
                                mapID = tonumber(vendorRef.mapID or vendorRef.MapID)
                            end
                            if not x then
                                x = tonumber(vendorRef.x)
                            end
                            if not y then
                                y = tonumber(vendorRef.y)
                            end

                            vd = {
                                expansion = vendorRef.expansion or parentFaction.expansion,
                                location = vendorRef.location or vendorRef.zone or parentFaction.zone or parentFaction.location or parentFaction.subzone,
                                vendorName = vendorRef.vendorName or vendorRef.name or parentFaction.vendorName,
                                npcID = vendorRef.npcID or parentFaction.npcID,
                                faction = vendorRef.faction or parentFaction.faction,
                                coords = (mapID and x and y) and { x = x, y = y, mapID = mapID } or nil,
                                factionID = parentFaction.factionID,
                                factionName = parentFaction.label,
                                reputation = repItem.requiredStanding or parentFaction.requiredStanding,
                                extra = "None",
                            }
                        elseif parentFaction.vendorName then
                            local mapID = nil
                            local x = nil
                            local y = nil

                            if type(parentFaction.coords) == "table" then
                                mapID = tonumber(parentFaction.coords.mapID or parentFaction.coords.MapID)
                                x = tonumber(parentFaction.coords.x)
                                y = tonumber(parentFaction.coords.y)
                            end

                            if not mapID then mapID = tonumber(parentFaction.MapID or parentFaction.mapID) end
                            if not x then x = tonumber(parentFaction.x) end
                            if not y then y = tonumber(parentFaction.y) end

                            vd = {
                                expansion = parentFaction.expansion,
                                location = parentFaction.zone or parentFaction.location or parentFaction.subzone,
                                vendorName = parentFaction.vendorName,
                                npcID = parentFaction.npcID,
                                faction = parentFaction.faction,
                                coords = (mapID and x and y) and { x = x, y = y, mapID = mapID } or nil,
                                factionID = parentFaction.factionID,
                                factionName = parentFaction.label,
                                reputation = repItem.requiredStanding or parentFaction.requiredStanding,
                                extra = "None",
                            }
                        end

                        repItem.vendorDetails = vd
                    end

                    if not repItem.vendorDetails then
                        return
                    end

                    local itemID = tonumber(repItem.itemID)
                    if not itemID then
                        return
                    end

                    if not _G.HousingExpansionData[itemID] then
                        _G.HousingExpansionData[itemID] = {}
                    end
                    _G.HousingExpansionData[itemID].vendor = repItem

                    local vd = repItem.vendorDetails
                    if not vd then
                        return
                    end

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

                -- Support both formats:
                -- - Top-level reputation item entries (legacy)
                -- - Faction entries with nested rewards (current generated file)
                IndexReputationItem(item, nil)
                if item.rewards and type(item.rewards) == "table" then
                    for _, reward in ipairs(item.rewards) do
                        IndexReputationItem(reward, item)
                    end
                end
            end
        end

        -- Process profession data
        for _, items in ipairs(pendingProfessionData) do
            for _, item in IterateSparseNumeric(items) do
                local itemID = tonumber(item.itemID)
                if itemID and not _G.HousingProfessionData[itemID] then
                    _G.HousingProfessionData[itemID] = item
                    stats.professionCount = stats.professionCount + 1
                end
            end
        end

        -- Process profession trainer data (profession -> expansion -> faction -> trainer).
        for _, trainers in ipairs(pendingProfessionTrainerData) do
            for professionName, professionData in pairs(trainers) do
                if type(professionName) == "string" and type(professionData) == "table" then
                    _G.HousingProfessionTrainers[professionName] = professionData
                    stats.professionTrainerCount = stats.professionTrainerCount + 1
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
        pendingRewardData = {}
        pendingReputationData = {}
        pendingProfessionData = {}
        pendingProfessionTrainerData = {}
        pendingCostData = {}

        isDataProcessed = true
        dataRevision = dataRevision + 1
        _G.HousingDataAggregatorRevision = dataRevision

        -- Report stats
        local expansionCount = 0
        for _ in pairs(_G.HousingExpansionData) do
            expansionCount = expansionCount + 1
        end
        Info(string.format("Processed %d items (%d vendors, %d quests, %d achievements, %d professions, %d trainer sets)",
            expansionCount, stats.vendorCount, stats.questCount, stats.achievementCount, stats.professionCount, stats.professionTrainerCount))
    end

    local function Traceback(err)
        if _G.debugstack then
            return tostring(err) .. "\n" .. tostring(_G.debugstack(2, 30, 30))
        end
        if _G.debug and _G.debug.traceback then
            return _G.debug.traceback(tostring(err), 2)
        end
        return tostring(err)
    end

    local ok, err = xpcall(ProcessImpl, Traceback)
    if not ok then
        if _G.HousingVendorLog and _G.HousingVendorLog.Error then
            _G.HousingVendorLog:Error("Deferred data aggregation failed: " .. tostring(err))
        else
            print("|cFFFF4040HousingVendor:|r Deferred data aggregation failed: " .. tostring(err))
        end
    end

    isProcessingPendingData = false
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

function _G.HousingDataAggregator_RegisterProfessionTrainers(trainers)
    return _G.HousingDataAggregator:RegisterProfessionTrainers(trainers)
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
            elseif key == "professionTrainers" and type(value) == "table" then
                _G.HousingDataAggregator:RegisterProfessionTrainers(value)
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
