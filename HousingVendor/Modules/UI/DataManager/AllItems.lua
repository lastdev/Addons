-- Auto-extracted from the original DataManager.lua for modularization
local _G = _G
local DataManager = _G["HousingDataManager"]
if not DataManager then return end
local state = DataManager._state

-- Cache global references for performance (mirrors original DataManager.lua)
local pairs = pairs
local ipairs = ipairs
local tonumber = tonumber
local tostring = tostring
local string_format = string.format
local string_find = string.find
local string_lower = string.lower
local string_match = string.match
local string_gsub = string.gsub
local table_insert = table.insert
local table_sort = table.sort
local math_abs = math.abs
local Util = DataManager.Util or {}
local Constants = DataManager.Constants or {}
local INTERNED_STRINGS = Util.INTERNED_STRINGS or {}
local QUALITY_NAMES = Constants.QUALITY_NAMES or {}
local hordeFactionKeywords = Constants.hordeFactionKeywords or {}
local allianceFactionKeywords = Constants.allianceFactionKeywords or {}
local CRAFTED_ITEMS_LOOKUP = Constants.CRAFTED_ITEMS_LOOKUP or {}
local function InternString(str) return Util.InternString and Util.InternString(str) or str end
local function GetApiDataCache() return Util.GetApiDataCache and Util.GetApiDataCache() or {} end
local function TouchApiDataCacheItem(itemID) if Util.TouchApiDataCacheItem then Util.TouchApiDataCacheItem(itemID) end end
local function PruneApiDataCacheIfNeeded(cache) if Util.PruneApiDataCacheIfNeeded then Util.PruneApiDataCacheIfNeeded(cache) end end
local function NormalizeVendorName(vendorName) return Util.NormalizeVendorName and Util.NormalizeVendorName(vendorName) or vendorName end

-- Helper function to convert numeric faction to string label
local function FactionNumericToString(faction)
    if type(faction) == "number" then
        if faction == 0 then
            return "Neutral"
        elseif faction == 1 then
            return "Alliance"
        elseif faction == 2 then
            return "Horde"
        end
    end
    return faction  -- Already a string or nil
end

local function NormalizeFactionGroup(faction)
    if faction == nil then return nil end
    if faction == "" or faction == "None" then return nil end
    if type(faction) == "string" then
        if faction == "Alliance" or faction == "Horde" or faction == "Neutral" then
            return faction
        end
        return faction
    end
    if type(faction) == "number" then
        if faction == 0 then return "Neutral" end
        if faction == 1 then return "Alliance" end
        if faction == 2 then return "Horde" end
        return nil
    end
    return nil
end
local function CoalesceNonEmptyString(a,b) return Util.CoalesceNonEmptyString and Util.CoalesceNonEmptyString(a,b) or (a~=nil and a~="" and a or b) end
local function InferFactionFromText(text) return Util.InferFactionFromText and Util.InferFactionFromText(text) or INTERNED_STRINGS["Neutral"] end

-- API-only vendor mode - static VendorLocations enrichment disabled for accuracy with new content
local USE_STATIC_VENDOR_LOCATIONS = false

-- PERFORMANCE: Incremental item loading option (prevents UI freeze on first load)
-- Set to true to load items in batches with yields, false for synchronous loading
local ENABLE_INCREMENTAL_LOADING = true
local INCREMENTAL_BATCH_SIZE = 300  -- Process 300 items per batch

-- Aggregate all items from HousingAllItems and enrich with API
function DataManager:GetAllItems()
    -- Ensure pending vendor/quest/achievement data is processed before building item cache
    if _G.HousingDataAggregator and _G.HousingDataAggregator.ProcessPendingData then
        _G.HousingDataAggregator:ProcessPendingData()
    end

    local currentDataRevision = _G.HousingDataAggregatorRevision or 0

    -- Return cached data if available (and still matches the current data revision)
    if state.itemCache and state._aggregatorRevision == currentDataRevision then
        return state.itemCache
    end

    -- Data changed since the last build; rebuild caches.
    state.itemCache = nil
    state.filterOptionsCache = nil
    state._aggregatorRevision = currentDataRevision

    -- Reset batch loading state
    state.batchLoadInProgress = false

    -- Cache frequently accessed globals for performance in the hot loop
    local HousingDNTItems = _G.HousingDNTItems
    local C_Item_GetItemNameByID = C_Item and C_Item.GetItemNameByID or nil
    local HousingDataEnrichment = _G.HousingDataEnrichment
    local HousingExpansionData = _G.HousingExpansionData
    local HousingProfessionData = _G.HousingProfessionData
    local HousingVendorItemToFaction = _G.HousingVendorItemToFaction
    local HousingMissingItems = _G.HousingMissingItems
    local HousingNotReleased = _G.HousingNotReleased
    local HousingMiscellaneous = _G.HousingMiscellaneous
    local UnitFactionGroup = _G.UnitFactionGroup

    local allItems = {}
    local filterOptions = {
        expansions = {},
        vendors = {},
        zones = {},
        types = {},
        categories = {},
        factions = {},
        sources = {},
        qualities = {},
        requirements = {}
    }

    -- Multi-source support: items can be Vendor+Quest, Vendor+Drop, etc.
    -- We track all applicable sources for filtering (while still keeping a primary `_sourceType` for display).
    local function AddSourceType(itemRecord, sourceType)
        if not itemRecord or not sourceType or sourceType == "" then
            return
        end
        if not itemRecord._sourceTypes then
            itemRecord._sourceTypes = {}
        end
        itemRecord._sourceTypes[sourceType] = true
        filterOptions.sources[sourceType] = true
    end

    -- PERFORMANCE OPTIMIZATION: Use pre-built vendor index (O(1) lookup instead of O(n²) nested loops)
    -- The index is built once in VendorIndex.lua and cached, not rebuilt every time GetAllItems() is called
    local vendorItemIndex = nil
    local itemVendorLookup = nil

    -- Check if HousingVendorIndex is available (from VendorIndex.lua in DataPack)
    if USE_STATIC_VENDOR_LOCATIONS and _G.HousingVendorIndex then
        -- Force build if not already built (lazy initialization)
        if not _G.HousingVendorIndex.IsBuilt() then
            _G.HousingVendorIndex.Rebuild()
        end
        -- Note: vendorItemIndex will be populated from HousingVendorIndex.Get() during item loop
        vendorItemIndex = {}
    elseif USE_STATIC_VENDOR_LOCATIONS and HousingVendorLocations then
        -- FALLBACK: Old method if VendorIndex.lua not available
        vendorItemIndex = {}

        local expansions = {"Classic", "The Burning Crusade", "Wrath of the Lich King", "Cataclysm",
                           "Mists of Pandaria", "Warlords of Draenor", "Legion", "Battle for Azeroth",
                           "Shadowlands", "Dragonflight", "The War Within", "Midnight"}

        if HousingVersionFilter then
            local availableExpansions = {}
            for _, expansion in ipairs(expansions) do
                if HousingVersionFilter:ShouldShowExpansion(expansion) then
                    table.insert(availableExpansions, expansion)
                end
            end
            expansions = availableExpansions
        end

        local vendorLocationCount = 0
        for _, expansion in ipairs(expansions) do
            local expData = HousingVendorLocations[expansion]
            if expData then
                for zoneName, vendors in pairs(expData) do
                    -- Add ALL zones to filter options (even if they have no items in AllItems.lua yet)
                    if zoneName and zoneName ~= "" then
                        filterOptions.zones[zoneName] = true
                    end

                    for _, vendorData in ipairs(vendors) do
                        -- Add ALL vendors to filter options (even if they have no items in AllItems.lua yet)
                        if vendorData.vendorName and vendorData.vendorName ~= "" then
                            filterOptions.vendors[vendorData.vendorName] = true
                            vendorLocationCount = vendorLocationCount + 1
                        end

                        if vendorData.items then
                            for _, itemData in ipairs(vendorData.items) do
                                local indexedItemID = itemData and itemData.itemID and tonumber(itemData.itemID) or nil
                                if indexedItemID then
                                    local entry = {
                                        expansion = expansion,
                                        zoneName = zoneName,
                                        vendorName = vendorData.vendorName,
                                        npcID = vendorData.npcID,
                                        faction = NormalizeFactionGroup(vendorData.faction),
                                        coords = vendorData.coords or vendorData.vendorCoords,
                                        factionID = vendorData.factionID,
                                        factionName = vendorData.factionName,
                                        reputationRequired = itemData.reputation
                                    }
                                    -- Some location files historically put a reputation factionID into `faction`.
                                    -- If it's not a 0/1/2 faction-group value, treat it as a factionID instead.
                                    if not entry.faction and type(vendorData.faction) == "number" then
                                        if vendorData.faction ~= 0 and vendorData.faction ~= 1 and vendorData.faction ~= 2 then
                                            entry.factionID = entry.factionID or vendorData.faction
                                        end
                                    end

                                    if not vendorItemIndex[indexedItemID] then
                                        vendorItemIndex[indexedItemID] = {
                                            entries = {},
                                            factions = {}
                                        }
                                    end

                                    table.insert(vendorItemIndex[indexedItemID].entries, entry)

                                    local factionKey = entry.faction or "Neutral"
                                    if factionKey == "" then factionKey = "Neutral" end
                                    vendorItemIndex[indexedItemID].factions[factionKey] = true
                                end
                            end
                        end
                    end
                end
            end
        end

        -- Also build itemVendorLookup from VendorLocations data
        if not itemVendorLookup then
            itemVendorLookup = {}
        end
        for itemID, vendorIndex in pairs(vendorItemIndex) do
            if not itemVendorLookup[itemID] then
                itemVendorLookup[itemID] = {
                    vendors = {},
                    zones = {},
                    vendorData = {}
                }
            end
            for _, entry in ipairs(vendorIndex.entries) do
                if entry.vendorName and entry.vendorName ~= "" then
                    itemVendorLookup[itemID].vendors[entry.vendorName] = true
                    table.insert(itemVendorLookup[itemID].vendorData, {
                        name = entry.vendorName,
                        location = entry.zoneName,
                        coords = entry.coords,
                        faction = entry.faction,
                        expansion = entry.expansion
                    })
                end
                if entry.zoneName and entry.zoneName ~= "" then
                    itemVendorLookup[itemID].zones[entry.zoneName] = true
                end
            end
        end
    end

    -- Vendor filter prepopulation (compact, no full per-item record duplication).
    -- Data/DataAggregator.lua builds:
    --  - `_G.HousingVendorFilterIndex` (vendors/zones sets by expansion)
    --  - `_G.HousingVendorPool` + `_G.HousingItemVendorIndex` (per-item vendor indices)
    local vendorPool = _G.HousingVendorPool
    local itemVendorIndex = _G.HousingItemVendorIndex

    local vendorFilterIndex = _G.HousingVendorFilterIndex
    if vendorFilterIndex and vendorFilterIndex.vendorsByExpansion then
        local expansions = {"Classic", "The Burning Crusade", "Wrath of the Lich King", "Cataclysm",
                           "Mists of Pandaria", "Warlords of Draenor", "Legion", "Battle for Azeroth",
                           "Shadowlands", "Dragonflight", "The War Within", "Midnight"}

        if HousingVersionFilter then
            local availableExpansions = {}
            for _, expansion in ipairs(expansions) do
                if HousingVersionFilter:ShouldShowExpansion(expansion) then
                    table.insert(availableExpansions, expansion)
                end
            end
            expansions = availableExpansions
        end

        for _, expansion in ipairs(expansions) do
            local vendors = vendorFilterIndex.vendorsByExpansion[expansion]
            if vendors then
                for vendorName in pairs(vendors) do
                    if vendorName and vendorName ~= "" and vendorName ~= "None" then
                        filterOptions.vendors[vendorName] = true
                    end
                end
            end

            local zones = vendorFilterIndex.zonesByExpansion[expansion]
            if zones then
                for zoneName in pairs(zones) do
                    if zoneName and zoneName ~= "" then
                        filterOptions.zones[zoneName] = true
                    end
                end
            end
        end
    end

    -- Load from HousingAllItems and enrich with API
    if not HousingAllItems then
        print("|cFFFF4040HousingVendor:|r ERROR: HousingAllItems not loaded!")
        return {}
    end

    -- Iterate through all items in HousingAllItems
    -- Array format: {decorID, modelFileID, iconFileID} (NAME field removed for memory savings)
    for itemID, decorData in pairs(HousingAllItems) do
        local itemIDNum = tonumber(itemID)
        if itemIDNum then
            -- Skip DNT items (check against DNT list first for performance)
            local isDNT = false
            if HousingDNTItems and HousingDNTItems[itemIDNum] then
                isDNT = true
            end

            if not isDNT then
                -- Fetch item name from game API instead of storing it in AllItems.lua (saves 100-200 KB)
                local itemName = (C_Item_GetItemNameByID and C_Item_GetItemNameByID(itemIDNum)) or "Unknown Item"

                -- Also check if item name contains [DNT] tag
                if string_find(itemName, "%[DNT%]") then
                    isDNT = true
                end
            end

            if not isDNT then
                -- Skip unreleased items (released = false)
                -- Items without a 'released' field are treated as released (default behavior)
                if decorData.released == false then
                    -- Skip this item - it's not yet released in-game
                else
                -- Create simplified item record (removed lowercase duplicates - compute on-demand)
                local itemRecord = {
                    name = itemName,
                    itemID = tostring(itemIDNum),
                    decorID = decorData[1],  -- Index 1 = decorID (HousingItemFields.DECOR_ID)
                    modelFileID = decorData[2] or "",  -- Index 2 = modelFileID (HousingItemFields.MODEL_FILE_ID)
                    model3D = decorData[2] or nil,  -- Copy modelFileID to model3D for 3D preview
                    thumbnailFileID = decorData[3] or "",  -- Index 3 = iconFileID (HousingItemFields.ICON_FILE_ID)

                    -- Core data
                    faction = "Neutral",
                    vendorName = nil,
                    coords = {x = 0, y = 0},
                    zoneName = nil,
                    expansionName = nil,
                    mapID = 0,

                    -- All possible vendors for this item (indices into `_G.HousingVendorPool`).
                    -- We intentionally do NOT store per-item vendor/zone hash tables; those explode memory.
                    _vendorIndices = itemVendorIndex and itemVendorIndex[itemIDNum] or nil,

                    -- API data fields (lazy loaded)
                    _apiExpansion = nil,
                    _apiCategory = nil,
                    _apiSubcategory = nil,
                    _apiVendor = nil,
                    _apiZone = nil,
                    _apiQuality = nil,
                    _apiNumStored = 0,
                    _apiNumPlaced = 0,
                    _apiAchievement = nil,
                    _apiSourceText = nil,
                    _apiDataLoaded = false,

                    -- Source type (determined after enrichment)
                    _sourceType = "Vendor",
                    _sourceTypes = {},
                    _isProfessionItem = false
                }

                -- Only mark as Vendor-sourced if the item actually has vendor indices.
                if itemRecord._vendorIndices and next(itemRecord._vendorIndices) then
                    AddSourceType(itemRecord, INTERNED_STRINGS["Vendor"] or "Vendor")
                end

                -- Enhance with HousingItemTrackerDB data if available
                if HousingDataEnrichment and HousingDataEnrichment.EnhanceItemRecord then
                    itemRecord = HousingDataEnrichment:EnhanceItemRecord(itemRecord)
                    
                    -- Use enriched category/subcategory if API doesn't have them
                    if itemRecord._enrichedCategory and not itemRecord._apiCategory then
                        itemRecord._apiCategory = itemRecord._enrichedCategory
                    end
                    if itemRecord._enrichedSubcategory and not itemRecord._apiSubcategory then
                        itemRecord._apiSubcategory = itemRecord._enrichedSubcategory
                    end
                    
                    -- Add enriched sources to filter options
                    if itemRecord._enrichedSources then
                        for _, source in ipairs(itemRecord._enrichedSources) do
                            filterOptions.sources[source] = true
                        end
                    end
                end

                -- Try to get cached API data
                local apiDataCache = GetApiDataCache()
                if apiDataCache[itemIDNum] then
                    local apiData = apiDataCache[itemIDNum]
                    TouchApiDataCacheItem(itemIDNum)
                    itemRecord._apiExpansion = apiData.expansion
                    itemRecord._apiCategory = apiData.category
                    itemRecord._apiSubcategory = apiData.subcategory
                    itemRecord._apiVendor = apiData.vendor
                    itemRecord._apiZone = apiData.zone
                    itemRecord._apiQuality = apiData.quality
                    itemRecord._apiNumStored = apiData.numStored or 0
                    itemRecord._apiNumPlaced = apiData.numPlaced or 0
                    itemRecord._apiAchievement = apiData.achievement
                    itemRecord._achievementId = apiData.achievementID
                    itemRecord._apiSourceText = apiData.sourceText
                    itemRecord._sourceType = apiData.sourceType or "Vendor"
                    itemRecord._apiDataLoaded = true

                    -- Update vendor location data (only if coords look valid)
                    if apiData.coords and type(apiData.coords) == "table" then
                        local cx = apiData.coords.x
                        local cy = apiData.coords.y
                        if type(cx) == "number" and type(cy) == "number" and cx > 0 and cy > 0 then
                            -- Only use API coords if we don't already have usable static coords
                            local hasStaticCoords = false
                            if itemRecord.coords and type(itemRecord.coords) == "table" then
                                local sx, sy = itemRecord.coords.x, itemRecord.coords.y
                                hasStaticCoords = type(sx) == "number" and type(sy) == "number" and sx > 0 and sy > 0
                            end
                            if not hasStaticCoords then
                                itemRecord.coords = apiData.coords
                            end
                        end
                    end
                    if apiData.mapID and (not itemRecord.mapID or itemRecord.mapID == 0) then
                        itemRecord.mapID = apiData.mapID
                    end
                    -- Vendor/zone names should primarily come from hard data; only fill if missing.
                    if apiData.vendor and apiData.vendor ~= "" and (not itemRecord.vendorName or itemRecord.vendorName == "") then
                        itemRecord.vendorName = apiData.vendor
                    end
                    if apiData.zone and apiData.zone ~= "" and (not itemRecord.zoneName or itemRecord.zoneName == "") then
                        itemRecord.zoneName = apiData.zone
                    end
                    if apiData.expansion then itemRecord.expansionName = apiData.expansion end

                    -- Update filter options from cached data
                    if apiData.expansion then filterOptions.expansions[apiData.expansion] = true end
                    if apiData.category then filterOptions.categories[apiData.category] = true end
                    if apiData.subcategory then
                        filterOptions.types[apiData.subcategory] = true
                        -- Also add subcategory to categories for easier filtering
                        filterOptions.categories[apiData.subcategory] = true
                    end
                    if apiData.vendor and apiData.vendor ~= "" then filterOptions.vendors[apiData.vendor] = true end
                    if apiData.zone and apiData.zone ~= "" then filterOptions.zones[apiData.zone] = true end
                    if apiData.sourceType then filterOptions.sources[apiData.sourceType] = true end
                    if apiData.qualityName then filterOptions.qualities[apiData.qualityName] = true end
                    -- Add to requirements filter, but skip "Profession" (already in Sources)
                    if apiData.requirementType and apiData.requirementType ~= "Profession" then
                        filterOptions.requirements[apiData.requirementType] = true
                    end
                end

                -- Fallback: Get quality from C_Item API if Housing APIs didn't provide it (API safety)
                if itemRecord._apiQuality == nil and itemIDNum and _G.C_Item and _G.C_Item.GetItemQualityByID then
                    local quality = _G.C_Item.GetItemQualityByID(itemIDNum)
                    if quality ~= nil then
                        itemRecord._apiQuality = quality
                    end
                end

                -- COMPREHENSIVE ENRICHMENT: Check ALL data files
                
                -- 1. VendorLocations - All expansion vendor data
                if USE_STATIC_VENDOR_LOCATIONS and vendorItemIndex then
                    local vendorBundle = vendorItemIndex[itemIDNum]
                    if vendorBundle then
                        local entries = vendorBundle.entries
                        local vendorInfo = vendorBundle
                        if not entries then
                            -- Backwards compatibility (older single-entry shape)
                            entries = { vendorBundle }
                            vendorInfo = {
                                entries = entries,
                                factions = { [NormalizeFactionGroup(vendorBundle.faction) or "Neutral"] = true }
                            }
                        end

                        local playerFaction = UnitFactionGroup and UnitFactionGroup("player") or nil
                        local selected = nil

                        if playerFaction then
                            for _, e in ipairs(entries) do
                                if e.faction == playerFaction then
                                    selected = e
                                    break
                                end
                            end
                        end
                        if not selected then
                            for _, e in ipairs(entries) do
                                if not e.faction or e.faction == "" or e.faction == "Neutral" then
                                    selected = e
                                    break
                                end
                            end
                        end
                        if not selected then
                            selected = entries[1]
                        end

                        local combinedFaction = nil
                        if vendorInfo.factions then
                            if vendorInfo.factions["Alliance"] and vendorInfo.factions["Horde"] then
                                combinedFaction = "Neutral"
                            elseif vendorInfo.factions["Neutral"] then
                                combinedFaction = "Neutral"
                            else
                                for factionKey in pairs(vendorInfo.factions) do
                                    if type(factionKey) == "string" then
                                        combinedFaction = factionKey
                                        break
                                    end
                                end
                            end
                        end

                        -- Keep all vendor sources for debugging/inspection
                        itemRecord._vendorSources = entries

                        if selected.vendorName and (not itemRecord.vendorName or itemRecord.vendorName == "") then
                            itemRecord.vendorName = selected.vendorName
                        end
                        if selected.zoneName and (not itemRecord.zoneName or itemRecord.zoneName == "") then
                            itemRecord.zoneName = selected.zoneName
                        end
                        if selected.coords and selected.coords.x and selected.coords.y then
                            local hasCoords = itemRecord.coords and itemRecord.coords.x and itemRecord.coords.y and (itemRecord.coords.x ~= 0 or itemRecord.coords.y ~= 0)
                            if not hasCoords then
                                itemRecord.coords = { x = selected.coords.x, y = selected.coords.y }
                            end
                            if selected.coords.mapID and (not itemRecord.mapID or itemRecord.mapID == 0) then
                                itemRecord.mapID = selected.coords.mapID
                            end
                        end
                        if selected.expansion and (not itemRecord.expansionName or itemRecord.expansionName == "") then
                            itemRecord.expansionName = selected.expansion
                        end
                        if combinedFaction and combinedFaction ~= "" then
                            -- Only set faction if we don't already have a stronger source (e.g. reputations)
                            if (not itemRecord.faction or itemRecord.faction == "" or itemRecord.faction == "Neutral") and combinedFaction ~= "Neutral" then
                                itemRecord.faction = combinedFaction
                            end
                        end
                        if selected.npcID then
                            itemRecord.npcID = selected.npcID
                        end
                        if selected.factionID then
                            itemRecord.factionID = selected.factionID
                        end
                        if selected.factionName then
                            itemRecord.factionName = selected.factionName
                        end
                        if selected.reputationRequired then
                            itemRecord.reputationRequired = selected.reputationRequired
                        end

                        -- Check if zoneName is a class name (class-restricted vendor)
                        local zoneName = selected.zoneName
                        if zoneName then
                            local classNames = {
                                "Death Knight", "Demon Hunter", "Druid", "Hunter",
                                "Mage", "Monk", "Paladin", "Priest", "Rogue",
                                "Shaman", "Warlock", "Warrior", "Evoker"
                            }
                            for _, className in ipairs(classNames) do
                                if zoneName == className then
                                    itemRecord.classRestriction = className
                                    break
                                end
                            end
                        end

                        -- Update filter options
                        if itemRecord.vendorName and itemRecord.vendorName ~= "" then
                            filterOptions.vendors[itemRecord.vendorName] = true
                        end
                        if itemRecord.zoneName and itemRecord.zoneName ~= "" then
                            filterOptions.zones[itemRecord.zoneName] = true
                        end
                        if itemRecord.expansionName and itemRecord.expansionName ~= "" then
                            filterOptions.expansions[itemRecord.expansionName] = true
                        end
                        if itemRecord.faction and itemRecord.faction ~= "" then
                            local factionStr = NormalizeFactionGroup(itemRecord.faction)
                            if factionStr then
                                itemRecord.faction = factionStr
                                filterOptions.factions[factionStr] = true
                            end
                        end
                        itemRecord._sourceType = INTERNED_STRINGS["Vendor"] or "Vendor"
                        AddSourceType(itemRecord, INTERNED_STRINGS["Vendor"] or "Vendor")
                    end
                end
                
                -- 2. NEW: Load from expansion files - vendor, quest, achievement, reputation, drop tables
                -- These are defined in files like Classic.lua, KhazAlgar.lua, etc.
                if _G["HousingExpansionData"] then
                    local expData = _G["HousingExpansionData"][itemIDNum]
                    if expData then
                        local staticName = nil
                        if expData.vendor and expData.vendor.itemName and expData.vendor.itemName ~= "" then
                            staticName = expData.vendor.itemName
                        elseif expData.quest then
                            local q = expData.quest[1] or expData.quest
                            staticName = (q and (q.itemName or q.ItemName or q.title or q.name)) or nil
                        elseif expData.achievement then
                            local a = expData.achievement[1] or expData.achievement
                            staticName = (a and (a.title or a.itemName or a.ItemName or a.name)) or nil
                        elseif expData.drop then
                            local d = expData.drop[1] or expData.drop
                            staticName = (d and (d.itemName or d.ItemName or d.title or d.name)) or nil
                        end

                        if staticName and staticName ~= "" then
                            itemRecord._searchName = staticName
                        end

                        if itemRecord.name == "Unknown Item" and staticName and staticName ~= "" then
                            itemRecord.name = staticName
                        end

                        -- Process each source type
                        if expData.reputation then
                            local repSource = (expData.reputation.rep == "renown")
                                and (INTERNED_STRINGS["Renown"] or "Renown")
                                or (INTERNED_STRINGS["Reputation"] or "Reputation")

                            itemRecord._sourceType = repSource
                            AddSourceType(itemRecord, repSource)

                            -- Store faction info
                            if expData.reputation.factionID then
                                itemRecord.factionID = expData.reputation.factionID
                            end
                            if expData.reputation.label then
                                itemRecord.factionName = expData.reputation.label
                            end
                            if expData.reputation.rep then
                                itemRecord.reputationType = expData.reputation.rep
                            end
                            if expData.reputation.group then
                                itemRecord.factionGroup = expData.reputation.group
                            end
                            if expData.reputation.expansion then
                                itemRecord.expansionName = expData.reputation.expansion
                                filterOptions.expansions[expData.reputation.expansion] = true
                            end
                            if expData.reputation.faction then
                                local factionStr = NormalizeFactionGroup(expData.reputation.faction)
                                if factionStr then
                                    itemRecord.faction = factionStr
                                    filterOptions.factions[factionStr] = true
                                end
                            end
                        end

                        if expData.vendor then
                            AddSourceType(itemRecord, INTERNED_STRINGS["Vendor"] or "Vendor")
                            if not itemRecord._sourceType then
                                itemRecord._sourceType = INTERNED_STRINGS["Vendor"] or "Vendor"
                            end

                            local vendorItem = expData.vendor
                            local vd = vendorItem.vendorDetails

                            if vd then
                                if vd.vendorName and vd.vendorName ~= "None" then
                                    itemRecord.vendorName = vd.vendorName
                                    filterOptions.vendors[vd.vendorName] = true
                                end
                                if vd.coords then
                                    itemRecord.coords = { x = vd.coords.x, y = vd.coords.y, mapID = vd.coords.mapID }
                                    if vd.coords.mapID then
                                        itemRecord.mapID = vd.coords.mapID

                                        -- LOCALIZATION FIX: Get localized zone name from mapID instead of hardcoded English string
                                        -- This ensures zone names display in the player's client language
                                        local localizedZoneName = vd.location -- Fallback to English if API fails
                                        if C_Map and C_Map.GetMapInfo then
                                            local success, mapInfo = pcall(function()
                                                return C_Map.GetMapInfo(vd.coords.mapID)
                                            end)
                                            if success and mapInfo and mapInfo.name then
                                                localizedZoneName = mapInfo.name
                                            end
                                        end
                                        itemRecord.zoneName = localizedZoneName
                                        filterOptions.zones[localizedZoneName] = true
                                    end
                                elseif vd.location then
                                    -- Fallback if no mapID available (use English name)
                                    itemRecord.zoneName = vd.location
                                    filterOptions.zones[vd.location] = true
                                end
                                if vd.npcID and vd.npcID ~= "None" then
                                    itemRecord.npcID = vd.npcID
                                end
                                if vd.expansion then
                                    itemRecord.expansionName = vd.expansion
                                    filterOptions.expansions[vd.expansion] = true
                                end
                                if vd.faction and vd.faction ~= "None" then
                                    local factionStr = NormalizeFactionGroup(vd.faction)
                                    if factionStr then
                                        itemRecord.faction = factionStr
                                        filterOptions.factions[factionStr] = true
                                    end
                                end
                            end

                            -- NEW FORMAT: Read factionName, reputationLevel, renownLevel from vendor item level
                            -- These fields are at the top level of the vendor item, not inside vendorDetails
                            local newFactionName = vendorItem.factionName
                            local newReputationLevel = vendorItem.reputationLevel
                            local newRenownLevel = vendorItem.renownLevel

                            -- Set factionName from new format or legacy vendorDetails
                            if newFactionName and newFactionName ~= "" and newFactionName ~= "None" then
                                itemRecord.factionName = newFactionName
                            elseif vd and vd.factionName and vd.factionName ~= "None" then
                                itemRecord.factionName = vd.factionName
                            end

                            -- Set factionID from legacy vendorDetails (new format doesn't have factionID at item level)
                            if vd and vd.factionID and vd.factionID ~= "None" then
                                itemRecord.factionID = vd.factionID
                            end

                            -- Set reputationRequired from new format (reputationLevel/renownLevel) or legacy vendorDetails
                            if newRenownLevel and newRenownLevel > 0 then
                                itemRecord.reputationRequired = "Renown " .. tostring(newRenownLevel)
                                itemRecord.renownLevel = newRenownLevel
                            elseif newReputationLevel and newReputationLevel ~= "" and newReputationLevel ~= "None" then
                                itemRecord.reputationRequired = newReputationLevel
                            elseif vd and vd.reputation and vd.reputation ~= "None" then
                                itemRecord.reputationRequired = vd.reputation
                            end

                            -- Treat vendor items gated by reputation/renown as "Reputation" sources
                            -- so Source/Requirement filtering can find them.
                            if itemRecord._sourceType == INTERNED_STRINGS["Vendor"] then
                                local hasFactionGate = itemRecord.factionID or (itemRecord.factionName and itemRecord.factionName ~= "")
                                local hasReputationGate = itemRecord.reputationRequired and itemRecord.reputationRequired ~= ""
                                if hasFactionGate and hasReputationGate then
                                    local repSource = (type(itemRecord.reputationRequired) == "string" and itemRecord.reputationRequired:match("^Renown"))
                                        and (INTERNED_STRINGS["Renown"] or "Renown")
                                        or (INTERNED_STRINGS["Reputation"] or "Reputation")

                                    itemRecord._sourceType = repSource
                                    AddSourceType(itemRecord, repSource)
                                end
                            end
                        end

                        if expData.drop then
                            -- Drop items should be marked as Drop type, even if they also appear in vendor data.
                            -- This ensures drops are properly categorized in the info panel.
                            itemRecord._sourceType = INTERNED_STRINGS["Drop"] or "Drop"
                            AddSourceType(itemRecord, INTERNED_STRINGS["Drop"] or "Drop")

                            -- Handle drop as array or single object
                            local dropData = expData.drop
                            local firstDrop = nil
                            if type(dropData) == "table" then
                                if dropData[1] then
                                    firstDrop = dropData[1]
                                elseif dropData.zone or dropData.npcName or dropData.sources then
                                    firstDrop = dropData
                                end
                            end
                            if firstDrop then
                                -- Preserve full drop source list for richer preview panel details.
                                if dropData and dropData[1] then
                                    itemRecord._allDrops = dropData
                                elseif dropData then
                                    itemRecord._allDrops = { dropData }
                                end

                                if firstDrop.zone then
                                    itemRecord.zoneName = firstDrop.zone
                                    filterOptions.zones[firstDrop.zone] = true
                                end
                                -- Extract NPC/Boss name for drop items
                                if firstDrop.npcName and firstDrop.npcName ~= "" then
                                    itemRecord.vendorName = firstDrop.npcName
                                    itemRecord.npcName = firstDrop.npcName
                                    filterOptions.vendors[firstDrop.npcName] = true
                                end
                                if firstDrop.npcID then
                                    itemRecord.npcID = firstDrop.npcID
                                end
                                -- Extract coordinates for waypoint
                                if firstDrop.coordinates then
                                    itemRecord.coords = firstDrop.coordinates
                                end
                                -- Preserve notes for preview panel.
                                if firstDrop.notes and firstDrop.notes ~= "" then
                                    itemRecord.dropNotes = firstDrop.notes
                                    -- Reuse the reward-style details line for non-vendor sources too.
                                    if not itemRecord.sourceDetails or itemRecord.sourceDetails == "" then
                                        itemRecord.sourceDetails = firstDrop.notes
                                    end
                                end
                                if firstDrop.expansion then
                                    itemRecord.expansionName = firstDrop.expansion
                                    filterOptions.expansions[firstDrop.expansion] = true
                                end
                            end
                        end

                        if expData.reward then
                            -- Reward items should be marked as Reward type, even if they also appear in vendor data.
                            -- This ensures rewards are properly categorized in the info panel.
                            itemRecord._sourceType = INTERNED_STRINGS["Reward"] or "Reward"
                            AddSourceType(itemRecord, INTERNED_STRINGS["Reward"] or "Reward")

                            -- Handle reward as array or single object
                            local rewardData = expData.reward
                            local firstReward = nil
                            if type(rewardData) == "table" then
                                if rewardData[1] then
                                    firstReward = rewardData[1]
                                elseif rewardData.zone or rewardData.source then
                                    firstReward = rewardData
                                end
                            end
                            if firstReward then
                                if firstReward.zone then
                                    itemRecord.zoneName = firstReward.zone
                                    filterOptions.zones[firstReward.zone] = true
                                end
                                if firstReward.source then
                                    itemRecord.vendorName = firstReward.source
                                    filterOptions.vendors[firstReward.source] = true
                                end
                                if firstReward.expansion then
                                    itemRecord.expansionName = firstReward.expansion
                                    filterOptions.expansions[firstReward.expansion] = true
                                end
                                -- FIX: Store rewardType and sourceDetails for display in UI
                                if firstReward.rewardType then
                                    itemRecord.rewardType = firstReward.rewardType
                                end
                                if firstReward.sourceDetails then
                                    itemRecord.sourceDetails = firstReward.sourceDetails
                                end
                            end
                        end

                        if expData.quest then
                            -- Quest items should always be marked as Quest type, even if they also appear in vendor data.
                            -- This ensures quest rewards are properly categorized in the info panel.
                            itemRecord._sourceType = INTERNED_STRINGS["Quest"] or "Quest"
                            AddSourceType(itemRecord, INTERNED_STRINGS["Quest"] or "Quest")

                            -- Handle quest as array or single object
                            local questData = expData.quest
                            local firstQuest = nil
                            if type(questData) == "table" then
                                if questData[1] then
                                    firstQuest = questData[1]
                                elseif questData.questId or questData.questID or questData.questName then
                                    firstQuest = questData
                                end
                            end
                            if firstQuest then
                                -- Preserve full quest list for richer preview panel details.
                                if questData and questData[1] then
                                    itemRecord._allQuests = questData
                                elseif questData then
                                    itemRecord._allQuests = { questData }
                                end

                                -- Support both questId (legacy) and questID (current data format)
                                local qid = firstQuest.questId or firstQuest.questID
                                if qid then
                                    itemRecord._questId = qid
                                end
                                -- Prefer a human-readable quest name in the preview panel:
                                -- many generated files use numeric questName placeholders, while `title` is the display name.
                                local qName = firstQuest.questName
                                if type(qName) == "string" and qName:match("^%d+$") and firstQuest.title and firstQuest.title ~= "" then
                                    qName = firstQuest.title
                                end
                                if (not qName or qName == "") and firstQuest.title and firstQuest.title ~= "" then
                                    qName = firstQuest.title
                                end
                                if qName and qName ~= "" then
                                    itemRecord._questName = qName
                                end
                                if firstQuest.title then
                                    itemRecord.title = firstQuest.title
                                end
                                if firstQuest.expansion then
                                    itemRecord.expansionName = firstQuest.expansion
                                    filterOptions.expansions[firstQuest.expansion] = true
                                end
                                if firstQuest.faction then
                                    local factionStr = NormalizeFactionGroup(firstQuest.faction)
                                    if factionStr then
                                        itemRecord.faction = factionStr
                                        filterOptions.factions[factionStr] = true
                                    end
                                end
                                -- Store all quest IDs for potential future use
                                itemRecord._allQuestIds = {}
                                if questData[1] then
                                    -- It's an array
                                    for _, q in ipairs(questData) do
                                        local questIdVal = q.questId or q.questID
                                        if questIdVal then
                                            table.insert(itemRecord._allQuestIds, questIdVal)
                                        end
                                    end
                                else
                                    -- Single object
                                    local questIdVal = questData.questId or questData.questID
                                    if questIdVal then
                                        table.insert(itemRecord._allQuestIds, questIdVal)
                                    end
                                end
                            end
                        end

                        if expData.achievement then
                            -- Achievement items should be marked as Achievement type, even if they also appear in vendor data.
                            -- This ensures achievement rewards are properly categorized in the info panel.
                            itemRecord._sourceType = INTERNED_STRINGS["Achievement"] or "Achievement"
                            AddSourceType(itemRecord, INTERNED_STRINGS["Achievement"] or "Achievement")

                            -- Handle achievement as array (items can have multiple achievements)
                            -- Also handle single object format for compatibility
                            local achData = expData.achievement
                            local firstAch = nil
                            if type(achData) == "table" then
                                -- Check if it's an array (has numeric index 1) or a single object
                                if achData[1] then
                                    firstAch = achData[1]
                                elseif achData.achievementId or achData.achievementName then
                                    -- Single achievement object, not wrapped in array
                                    firstAch = achData
                                end
                            end

                            if firstAch then
                                if firstAch.achievementId then
                                    itemRecord._achievementId = firstAch.achievementId
                                end
                                if firstAch.achievementName then
                                    itemRecord._achievementName = firstAch.achievementName
                                end
                                if firstAch.model3D then
                                    itemRecord.model3D = firstAch.model3D
                                end
                                if firstAch.title then
                                    itemRecord.title = firstAch.title
                                end
                                if firstAch.expansion and not itemRecord.expansionName then
                                    itemRecord.expansionName = firstAch.expansion
                                    filterOptions.expansions[firstAch.expansion] = true
                                end
                                if firstAch.category then
                                    itemRecord._apiSubcategory = firstAch.category
                                    filterOptions.types[firstAch.category] = true
                                    filterOptions.categories[firstAch.category] = true
                                end
                                if firstAch.faction then
                                    local factionStr = NormalizeFactionGroup(firstAch.faction)
                                    if factionStr then
                                        itemRecord.faction = factionStr
                                        filterOptions.factions[factionStr] = true
                                    end
                                end
                            end
                        end
                    end
                end

                -- 3. NEW: Load profession data
                if _G.HousingProfessionData and _G.HousingProfessionData[itemIDNum] then
                    local profData = _G.HousingProfessionData[itemIDNum]

                    AddSourceType(itemRecord, INTERNED_STRINGS["Profession"] or "Profession")
                    if not itemRecord._sourceType then
                        itemRecord._sourceType = INTERNED_STRINGS["Profession"] or "Profession"
                    end
                    itemRecord._isProfessionItem = true

                    -- Add specific profession name to sources (e.g., "Tailoring", "Cooking")
                    if profData.profession then
                        AddSourceType(itemRecord, profData.profession)
                        itemRecord.profession = profData.profession
                        itemRecord.vendorName = profData.profession
                        filterOptions.vendors[profData.profession] = true
                    end

                    -- Store skill requirement
                    if profData.skill then
                        itemRecord.professionSkill = profData.skill
                        itemRecord.zoneName = profData.skill
                        filterOptions.zones[profData.skill] = true
                    end

                    -- Store skill level needed
                    if profData.skillNeeded then
                        itemRecord.professionSkillNeeded = profData.skillNeeded
                    end

                    -- Store spell and recipe IDs
                    if profData.spellID then
                        itemRecord.professionSpellID = profData.spellID
                    end
                    if profData.recipeID then
                        itemRecord.professionRecipeID = profData.recipeID
                    end

                    -- Store reagents list
                    if profData.reagents then
                        itemRecord.professionReagents = profData.reagents
                    end
                end

                -- 3b. Reputation/renown gating lookup (vendor items gated by faction standing)
                if HousingVendorItemToFaction and itemIDNum then
                    local repInfo = HousingVendorItemToFaction[itemIDNum]
                    if repInfo and (itemRecord._sourceType == INTERNED_STRINGS["Vendor"] or itemRecord._sourceType == "Vendor") then
                        if repInfo.rep == "renown" then
                            itemRecord._sourceType = INTERNED_STRINGS["Renown"] or "Renown"
                            AddSourceType(itemRecord, itemRecord._sourceType)
                        else
                            itemRecord._sourceType = INTERNED_STRINGS["Reputation"] or "Reputation"
                            AddSourceType(itemRecord, INTERNED_STRINGS["Reputation"] or "Reputation")
                        end

                        if repInfo.factionID then
                            itemRecord.factionID = repInfo.factionID
                        end
                        if repInfo.faction then
                            itemRecord.factionName = repInfo.faction
                        end
                        if repInfo.requiredStanding then
                            itemRecord.reputationRequired = repInfo.requiredStanding
                        end

                        -- FIX: Add vendor name and zone from reputation data for search
                        if repInfo.vendorName and repInfo.vendorName ~= "" then
                            if not itemRecord.vendorName or itemRecord.vendorName == "" then
                                itemRecord.vendorName = repInfo.vendorName
                            end
                        end
                        if repInfo.zoneName and repInfo.zoneName ~= "" then
                            if not itemRecord.zoneName or itemRecord.zoneName == "" then
                                itemRecord.zoneName = repInfo.zoneName
                            end
                        end
                    end
                end

                -- 4. LEGACY: HousingMissingItems - New items from live API
                if HousingMissingItems then
                    local missingData = nil
                    local missingCategory = nil

                    for _, category in pairs({"vendor", "quest", "achievement", "profession", "miscellaneous"}) do
                        if HousingMissingItems[category] and HousingMissingItems[category][itemIDNum] then
                            missingData = HousingMissingItems[category][itemIDNum]
                            missingCategory = category
                            break
                        end
                    end

                    if missingData then
                        -- Set source type based on which category it came from
                        if missingCategory == "vendor" then
                            itemRecord._sourceType = INTERNED_STRINGS["Vendor"] or "Vendor"
                            AddSourceType(itemRecord, INTERNED_STRINGS["Vendor"] or "Vendor")
                        elseif missingCategory == "quest" then
                            itemRecord._sourceType = INTERNED_STRINGS["Quest"] or "Quest"
                            AddSourceType(itemRecord, INTERNED_STRINGS["Quest"] or "Quest")
                        elseif missingCategory == "achievement" then
                            itemRecord._sourceType = INTERNED_STRINGS["Achievement"] or "Achievement"
                            AddSourceType(itemRecord, INTERNED_STRINGS["Achievement"] or "Achievement")
                        elseif missingCategory == "profession" then
                            itemRecord._sourceType = INTERNED_STRINGS["Profession"] or "Profession"
                            AddSourceType(itemRecord, INTERNED_STRINGS["Profession"] or "Profession")
                            -- Add specific profession name to sources if available
                            if missingData.profession then
                                AddSourceType(itemRecord, missingData.profession)
                            end
                        elseif missingCategory == "miscellaneous" then
                            itemRecord._sourceType = "Miscellaneous"
                            AddSourceType(itemRecord, "Miscellaneous")
                        end

                        if missingData.vendors and #missingData.vendors > 0 then
                            local firstVendor = missingData.vendors[1]
                            if firstVendor.name then
                                itemRecord.vendorName = firstVendor.name
                                filterOptions.vendors[firstVendor.name] = true
                            end
                            if firstVendor.zone then
                                itemRecord.zoneName = firstVendor.zone
                                filterOptions.zones[firstVendor.zone] = true
                            end
                        end

                        if missingData.coordinates then
                            if missingData.coordinates.mapID then
                                itemRecord.mapID = missingData.coordinates.mapID
                            end
                            if missingData.coordinates.x and missingData.coordinates.y then
                                itemRecord.coords = {x = missingData.coordinates.x, y = missingData.coordinates.y}
                            end
                        end

                        if missingData.quality then
                            -- CRITICAL: Store quality as NUMBER (not string) for consistent filtering
                            -- Filtering.lua expects _apiQuality to be a number (0-5) to look up in qualityNames table
                            itemRecord._apiQuality = missingData.quality
                            local qualityName = QUALITY_NAMES[missingData.quality] or "Common"
                            filterOptions.qualities[qualityName] = true
                        end

                        if missingData.subcategoryNames and #missingData.subcategoryNames > 0 then
                            local subcat = missingData.subcategoryNames[1]
                            itemRecord._apiSubcategory = subcat
                            filterOptions.types[subcat] = true
                            filterOptions.categories[subcat] = true
                        end

                        itemRecord._fromMissingItems = true
                    end
                end

                -- 5. LEGACY: HousingNotReleased - Midnight expansion and unreleased items
                if HousingNotReleased and HousingNotReleased[itemIDNum] then
                    local notReleasedData = HousingNotReleased[itemIDNum]
                    
                    -- Set source type
                    itemRecord._sourceType = "Not Yet Released"
                    AddSourceType(itemRecord, "Not Yet Released")
                    
                    -- Set expansion (usually "Midnight")
                    if notReleasedData.expansion then
                        itemRecord.expansionName = notReleasedData.expansion
                        filterOptions.expansions[notReleasedData.expansion] = true
                    end
                    
                    -- Store recordID for reference
                    if notReleasedData.recordID then
                        itemRecord._recordID = notReleasedData.recordID
                    end
                    
                    itemRecord._fromNotReleased = true
                end

                -- 6. LEGACY: HousingMiscellaneous - Catch-all for other sources
                if HousingMiscellaneous and not itemRecord._sourceType then
                    for _, miscData in ipairs(HousingMiscellaneous) do
                        if miscData.itemID == itemIDNum then
                            itemRecord._sourceType = "Miscellaneous"
                            AddSourceType(itemRecord, "Miscellaneous")
                            break
                        end
                    end
                end

                table.insert(allItems, itemRecord)
                end  -- Close else block for released check
            end
        end
    end

    -- Always ensure Wishlist is available
    filterOptions.sources["Wishlist"] = true

    print(string.format("|cFF00FF00HousingVendor:|r Loaded %d items from HousingAllItems", #allItems))

    -- Convert filter options to sorted arrays
    -- Special handling for expansions: ensure "The War Within" and "Midnight" are clearly separated
    local sortedExpansions = self:_SortKeys(filterOptions.expansions)
    -- Add visual indicator for Midnight (not yet released)
    for i, exp in ipairs(sortedExpansions) do
        if exp == "Midnight" then
            sortedExpansions[i] = "Midnight"
        end
    end
    
    state.filterOptionsCache = {
        expansions = sortedExpansions,
        vendors = self:_SortKeys(filterOptions.vendors),
        zones = self:_SortKeys(filterOptions.zones),
        types = self:_SortKeys(filterOptions.types),
        categories = self:_SortKeys(filterOptions.categories),
        factions = self:_SortKeys(filterOptions.factions),
        sources = self:_SortKeys(filterOptions.sources),
        qualities = self:_SortKeys(filterOptions.qualities),
        requirements = self:_SortKeys(filterOptions.requirements)
    }
    
    -- Cache results
    state.itemCache = allItems
    state._aggregatorRevision = currentDataRevision

    -- IMPORTANT: Do NOT automatically batch-load API data on startup.
    -- This is expensive and can cause significant memory growth over time.
    -- If desired, it can be enabled explicitly via settings.
    if HousingDB and HousingDB.settings and HousingDB.settings.preloadApiData then
        if HousingAPICache and not state.batchLoadInProgress then
            state.batchLoadInProgress = true
            C_Timer.After(0.1, function()
                DataManager:BatchLoadAPIData(allItems, filterOptions)
            end)
        end
    end

    return allItems
end
