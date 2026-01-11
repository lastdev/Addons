-- Indexing.lua
-- Low-overhead ID indexing + filtering + on-demand item record creation.

local _G = _G
local DataManager = _G["HousingDataManager"]
if not DataManager then return end

local pairs = pairs
local ipairs = ipairs
local tonumber = tonumber
local tostring = tostring
local type = type
local table_insert = table.insert
local table_sort = table.sort
local string_lower = string.lower

local Util = DataManager.Util or {}
local Constants = DataManager.Constants or {}
local INTERNED_STRINGS = Util.INTERNED_STRINGS or {}
local function InternString(str) return Util.InternString and Util.InternString(str) or str end
local function NormalizeVendorName(vendorName) return Util.NormalizeVendorName and Util.NormalizeVendorName(vendorName) or vendorName end
local function CoalesceNonEmptyString(a, b) return Util.CoalesceNonEmptyString and Util.CoalesceNonEmptyString(a, b) or (a ~= nil and a ~= "" and a or b) end
local QUALITY_NAMES = Constants.QUALITY_NAMES or {
    [0] = "Poor",
    [1] = "Common",
    [2] = "Uncommon",
    [3] = "Rare",
    [4] = "Epic",
    [5] = "Legendary",
    [6] = "Artifact",
    [7] = "Heirloom",
}

-- Hard-data-only mode (strip API-enriched facets from filtering/records).
-- This keeps filtering stable even when Housing APIs or caches are unavailable/unwarmed.
local HARD_DATA_ONLY = true
DataManager.HARD_DATA_ONLY = HARD_DATA_ONLY
-- Allow API cache usage for quality filtering only (rarity isn't stored in our hard tables).
local ALLOW_API_QUALITY = true
DataManager.ALLOW_API_QUALITY = ALLOW_API_QUALITY

local function GetApiDataCache()
    if HARD_DATA_ONLY and not ALLOW_API_QUALITY then return nil end
    return Util.GetApiDataCache and Util.GetApiDataCache() or {}
end

local function IsItemAvailableByID(itemID)
    local idNum = tonumber(itemID)
    if not idNum then return false end

    -- DNT / DO NOT USE items should never appear in the addon UI.
    if _G.HousingDNTItems and _G.HousingDNTItems[idNum] then
        return false
    end

    -- Treat explicit "not released" flags as unavailable (these are curated by the addon).
    if _G.HousingNotReleased and _G.HousingNotReleased[idNum] then
        return false
    end

    -- Items in HousingAllItems are assumed to exist; WoW item APIs can be uncached/unreliable
    -- and should not blank the UI.
    return true
end

local function TouchApiDataCacheItem(itemID)
    if HARD_DATA_ONLY and not ALLOW_API_QUALITY then return end
    if Util.TouchApiDataCacheItem then
        Util.TouchApiDataCacheItem(itemID)
    end
end

local function GetLocalItemQuality(itemID)
    local idNum = tonumber(itemID)
    if not idNum then return nil end

    if _G.C_Item and _G.C_Item.GetItemQualityByID then
        local q = _G.C_Item.GetItemQualityByID(idNum)
        if q ~= nil then return q end
    end

    if _G.C_Item and _G.C_Item.GetItemInfo then
        local _, _, q = _G.C_Item.GetItemInfo(idNum)
        if q ~= nil then return q end
    end
    if _G.GetItemInfo then
        local _, _, q = _G.GetItemInfo(idNum)
        if q ~= nil then return q end
    end

    return nil
end

local function RequestApplyFiltersDebounced(state)
    if not state then return end
    if state._applyFiltersPending then return end
    state._applyFiltersPending = true

    local C_Timer = _G.C_Timer
    if not (C_Timer and C_Timer.After) then
        state._applyFiltersPending = false
        if _G.HousingFilters and _G.HousingFilters.ApplyFilters then
            pcall(_G.HousingFilters.ApplyFilters, _G.HousingFilters)
        end
        return
    end

    C_Timer.After(0.35, function()
        state._applyFiltersPending = false
        if _G.HousingFilters and _G.HousingFilters.ApplyFilters then
            pcall(_G.HousingFilters.ApplyFilters, _G.HousingFilters)
        end
    end)
end

-- Lightweight caches (avoid building full item-record tables for all items).
local MAX_ITEM_RECORD_CACHE = 250

local function InferExpansionFromProfessionSkill(skill)
    if type(skill) ~= "string" or skill == "" then return nil end
    local s = skill:lower()
    if s:find("classic") then return "Classic" end
    if s:find("burning crusade") or s:find("tbc") then return "The Burning Crusade" end
    if s:find("wrath") then return "Wrath of the Lich King" end
    if s:find("cataclysm") then return "Cataclysm" end
    if s:find("mists") then return "Mists of Pandaria" end
    if s:find("warlords") or s:find("draenor") then return "Warlords of Draenor" end
    if s:find("legion") then return "Legion" end
    if s:find("battle for azeroth") or s:find("azeroth") then return "Battle for Azeroth" end
    if s:find("shadowlands") then return "Shadowlands" end
    if s:find("dragonflight") then return "Dragonflight" end
    if s:find("war within") then return "The War Within" end
    if s:find("midnight") then return "Midnight" end
    return nil
end

local function InferTypeAndCategoryFromName(name)
    if type(name) ~= "string" or name == "" then return nil, nil end
    local s = string_lower(name)

    local function Has(word)
        return s:find(word, 1, true) ~= nil
    end

    -- Rugs
    if Has("rug") then return "Rug", "Rugs" end

    -- Paintings
    if Has("painting") or Has("portrait") or Has("mosaic") then return "Painting", "Paintings" end

    -- Banners
    if Has("banner") or Has("flag") then return "Banner", "Banners" end

    -- Books
    if Has("bookcase") or Has("bookshelf") then return "Bookshelf", "Books" end
    if Has("tome") or Has("scroll") or Has("book") then return "Book", "Books" end

    -- Lighting
    if Has("chandelier") then return "Chandelier", "Lighting" end
    if Has("candelabra") then return "Candelabra", "Lighting" end
    if Has("sconce") then return "Sconce", "Lighting" end
    if Has("torch") then return "Torch", "Lighting" end
    if Has("lantern") then return "Lantern", "Lighting" end
    if Has("lamp") then return "Lamp", "Lighting" end
    if Has("candle") then return "Candle", "Lighting" end

    -- Furniture
    if Has("bed") then return "Bed", "Furniture" end
    if Has("chair") then return "Chair", "Furniture" end
    if Has("stool") then return "Stool", "Furniture" end
    if Has("bench") then return "Bench", "Furniture" end
    if Has("couch") or Has("sofa") then return "Couch", "Furniture" end
    if Has("table") then return "Table", "Furniture" end
    if Has("desk") then return "Desk", "Furniture" end
    if Has("wardrobe") or Has("cabinet") then return "Wardrobe", "Furniture" end
    if Has("shelf") then return "Shelf", "Furniture" end

    -- Plants
    if Has("tree") or Has("bush") or Has("flowers") or Has("flower") or Has("plant") or Has("topiary") or Has("grass") then
        return "Plant", "Plants"
    end

    -- Placeables / structural-ish
    if Has("platform") then return "Platform", "Placeables" end
    if Has("fencepost") then return "Fencepost", "Placeables" end
    if Has("fence") then return "Fence", "Placeables" end
    if Has("door") then return "Door", "Placeables" end
    if Has("window") then return "Window", "Placeables" end
    if Has("pillar") then return "Pillar", "Placeables" end

    -- Containers / misc props
    if Has("weapon rack") then return "Weapon Rack", "Placeables" end
    if Has("chest") then return "Chest", "Placeables" end
    if Has("crate") or Has("barrel") or Has("basket") then return "Container", "Placeables" end
    if Has("tent") then return "Tent", "Placeables" end

    return nil, nil
end

local function EnsureDataLoaded()
    if _G.HousingDataLoader and _G.HousingDataLoader.IsDataLoaded and not _G.HousingDataLoader:IsDataLoaded() then
        if _G.HousingDataLoader.LoadData then
            _G.HousingDataLoader:LoadData()
        end
    end
end

local function BuildFilterOptionsFromIndexes(state)
    local filterOptions = {
        expansions = {},
        vendors = {},
        zones = {},
        types = {},
        categories = {},
        factions = {},
        sources = {},
        qualities = {},
        requirements = {},
    }

    -- Qualities: keep stable options even when API caches are empty/unavailable.
    for _, qualityName in pairs(QUALITY_NAMES) do
        if type(qualityName) == "string" and qualityName ~= "" then
            filterOptions.qualities[qualityName] = true
        end
    end

    -- Sources (static list, plus whatever is seen)
    filterOptions.sources[INTERNED_STRINGS["Vendor"] or "Vendor"] = true
    filterOptions.sources[INTERNED_STRINGS["Quest"] or "Quest"] = true
    filterOptions.sources[INTERNED_STRINGS["Achievement"] or "Achievement"] = true
    filterOptions.sources[INTERNED_STRINGS["Drop"] or "Drop"] = true
    filterOptions.sources[INTERNED_STRINGS["Profession"] or "Profession"] = true
    filterOptions.sources[INTERNED_STRINGS["Reputation"] or "Reputation"] = true
    filterOptions.sources[INTERNED_STRINGS["Renown"] or "Renown"] = true
    filterOptions.sources[INTERNED_STRINGS["Wishlist"] or "Wishlist"] = true

    -- Factions (static)
    filterOptions.factions[INTERNED_STRINGS["Neutral"] or "Neutral"] = true
    filterOptions.factions[INTERNED_STRINGS["Alliance"] or "Alliance"] = true
    filterOptions.factions[INTERNED_STRINGS["Horde"] or "Horde"] = true

    -- Expansions: use what we actually indexed (plus stable ordering)
    if state._facetIndex and state._facetIndex.expansions then
        for exp in pairs(state._facetIndex.expansions) do
            if exp and exp ~= "" then
                filterOptions.expansions[exp] = true
            end
        end
    elseif state._seenExpansions then
        for exp in pairs(state._seenExpansions) do
            if exp and exp ~= "" then
                filterOptions.expansions[exp] = true
            end
        end
    end

    -- Vendors/Zones: compact vendor filter index built by DataAggregator in the datapack
    local vfi = _G.HousingVendorFilterIndex
    if vfi and vfi.vendorsByExpansion then
        for _, vendors in pairs(vfi.vendorsByExpansion) do
            for name in pairs(vendors) do
                if name and name ~= "" and name ~= "None" then
                    filterOptions.vendors[name] = true
                end
            end
        end
    end
    if vfi and vfi.zonesByExpansion then
        for _, zones in pairs(vfi.zonesByExpansion) do
            for zoneName in pairs(zones) do
                if zoneName and zoneName ~= "" then
                    filterOptions.zones[zoneName] = true
                end
            end
        end
    end

    -- Fallback (preferred in hard-data-only mode): use the facet index built from vendor pools.
    if next(filterOptions.vendors) == nil and state._facetIndex and state._facetIndex.vendorsByName then
        for vendorName in pairs(state._facetIndex.vendorsByName) do
            if vendorName and vendorName ~= "" and vendorName ~= "None" then
                filterOptions.vendors[vendorName] = true
            end
        end
    end
    if next(filterOptions.zones) == nil and state._facetIndex and state._facetIndex.zonesByName then
        for zoneName in pairs(state._facetIndex.zonesByName) do
            if zoneName and zoneName ~= "" then
                filterOptions.zones[zoneName] = true
            end
        end
    end

    -- Types/Categories: prefer API-provided tag groups when available, otherwise fall back to whatever
    -- has already been seen in the session API cache.
    local function AddTagGroupOptions(tagGroups)
        if type(tagGroups) ~= "table" then return end

        for _, group in ipairs(tagGroups) do
            local groupName = group and group.name and string_lower(tostring(group.name)) or ""
            local isCategoryGroup = groupName == "category" or groupName == "categories"
            local isTypeGroup = groupName == "type" or groupName == "types" or groupName == "subcategory" or groupName == "subcategories"
            if isCategoryGroup or isTypeGroup then
                if type(group.tags) == "table" then
                    for _, tagData in pairs(group.tags) do
                        local tagName = tagData and tagData.name or nil
                        if tagName and tagName ~= "" then
                            if isTypeGroup then
                                filterOptions.types[tagName] = true
                            else
                                filterOptions.categories[tagName] = true
                            end
                        end
                    end
                elseif type(group.tagNames) == "table" then
                    for _, tagName in pairs(group.tagNames) do
                        if tagName and tagName ~= "" then
                            if isTypeGroup then
                                filterOptions.types[tagName] = true
                            else
                                filterOptions.categories[tagName] = true
                            end
                        end
                    end
                end
            end
        end
    end

    if false and _G.HousingAPICache and _G.HousingAPICache.GetFilterTagGroups then
        local ok, tagGroups = pcall(_G.HousingAPICache.GetFilterTagGroups, _G.HousingAPICache)
        if ok and tagGroups then
            AddTagGroupOptions(tagGroups)
        end
    end

    -- Seen API cache values (helps when tag groups aren’t available yet)
    if false then
        local apiDataCache = GetApiDataCache()
        if type(apiDataCache) == "table" then
            for _, apiData in pairs(apiDataCache) do
                if type(apiData) == "table" then
                    if apiData.category and apiData.category ~= "" then
                        filterOptions.categories[apiData.category] = true
                    end
                    if apiData.subcategory and apiData.subcategory ~= "" then
                        filterOptions.types[apiData.subcategory] = true
                    end
                end
            end
        end
    end

    -- Static inferred values from our indexed data (works without Housing APIs)
    if type(state._itemMeta) == "table" then
        for _, m in pairs(state._itemMeta) do
            if type(m) == "table" then
                if m.inferredType and m.inferredType ~= "" then
                    filterOptions.types[m.inferredType] = true
                end
                if m.inferredCategory and m.inferredCategory ~= "" then
                    filterOptions.categories[m.inferredCategory] = true
                end
            end
        end
    end

    -- Final fallback: keep the UI usable even if we couldn't infer anything yet.
    if next(filterOptions.categories) == nil then
        local defaults = {
            "Furniture", "Decorations", "Lighting", "Placeables", "Accessories",
            "Rugs", "Plants", "Paintings", "Banners", "Books", "Food", "Toys",
        }
        for _, v in ipairs(defaults) do
            filterOptions.categories[v] = true
        end
    end
    if next(filterOptions.types) == nil then
        local defaults = {
            "Chair", "Table", "Bed", "Lamp", "Candle", "Rug", "Painting", "Banner",
            "Plant", "Bookshelf", "Chest", "Weapon Rack", "Window", "Door", "Platform",
        }
        for _, v in ipairs(defaults) do
            filterOptions.types[v] = true
        end
    end

    local function SortKeys(hashTable)
        local keys = {}
        for k in pairs(hashTable or {}) do
            table_insert(keys, k)
        end
        table_sort(keys)
        return keys
    end

    state.filterOptionsCache = {
        expansions = SortKeys(filterOptions.expansions),
        vendors = SortKeys(filterOptions.vendors),
        zones = SortKeys(filterOptions.zones),
        types = SortKeys(filterOptions.types),
        categories = SortKeys(filterOptions.categories),
        factions = SortKeys(filterOptions.factions),
        sources = SortKeys(filterOptions.sources),
        qualities = SortKeys(filterOptions.qualities),
        requirements = SortKeys(filterOptions.requirements),
    }
end

function DataManager:InvalidateIndexes()
    local s = self._state
    s.allItemIDs = nil
    s._itemMeta = nil
    s._seenExpansions = nil
    s._facetIndex = nil
    s._qualityWarmCursor = nil
    s.filterOptionsCache = nil
    s.filteredIDCache = nil
    s.lastFilterHash = nil
    s._itemRecordCache = nil
    s._itemRecordCacheCount = 0
end

function DataManager:HasIndexCache()
    local s = self._state
    return type(s.allItemIDs) == "table" and #s.allItemIDs > 0
end

function DataManager:GetAllItemIDs()
    EnsureDataLoaded()

    local s = self._state
    if type(s.allItemIDs) == "table" and #s.allItemIDs > 0 then
        return s.allItemIDs
    end

    local ids = {}
    local meta = {}
    local seenExpansions = {}

    if not _G.HousingAllItems or type(_G.HousingAllItems) ~= "table" then
        s.allItemIDs = {}
        s._itemMeta = {}
        s._seenExpansions = {}
        BuildFilterOptionsFromIndexes(s)
        return s.allItemIDs
    end

    -- Ensure HousingVendorItemToFaction is built before we build metadata
    if _G.HousingReputationLoader and _G.HousingReputationLoader.Rebuild then
        pcall(_G.HousingReputationLoader.Rebuild, _G.HousingReputationLoader)
    end

    local expansionData = _G.HousingExpansionData
    local professionData = _G.HousingProfessionData
    local repLookup = _G.HousingVendorItemToFaction
    local dntItems = _G.HousingDNTItems
    local vendorPool = _G.HousingVendorPool
    local vendorIndex = _G.HousingItemVendorIndex

    local function FirstOrSelf(v)
        if type(v) == "table" and v[1] and type(v[1]) == "table" then
            return v[1]
        end
        return v
    end

    local facetIndex = {
        expansions = {},
        vendorsByName = {},
        vendorsByNormalized = {},
        zonesByName = {},
        zonesByMapID = {},
    }

    local function AddFacetArray(map, key, id)
        if key == nil or key == "" then return end
        local arr = map[key]
        if not arr then
            arr = {}
            map[key] = arr
        end
        arr[#arr + 1] = id
    end

    for itemID in pairs(_G.HousingAllItems) do
        local idNum = tonumber(itemID)
        if idNum then
            local skip = false

            -- DNT / DO NOT USE items should never appear.
            if dntItems and dntItems[idNum] then
                skip = true
            end

            -- Also check the data-provided name for a [DNT] marker.
            if not skip then
                local sourcesForName = expansionData and expansionData[idNum] or nil
                if sourcesForName and type(sourcesForName) == "table" then
                    local n = nil
                    if sourcesForName.vendor and sourcesForName.vendor.itemName then
                        n = sourcesForName.vendor.itemName
                    elseif sourcesForName.quest and sourcesForName.quest.title then
                        n = sourcesForName.quest.title
                    elseif sourcesForName.achievement and sourcesForName.achievement.title then
                        n = sourcesForName.achievement.title
                    elseif sourcesForName.drop and sourcesForName.drop.title then
                        n = sourcesForName.drop.title
                    end
                    if type(n) == "string" and n:find("%[DNT%]") then
                        skip = true
                    end
                end
            end

            if not skip then
                ids[#ids + 1] = idNum

                local srcType = INTERNED_STRINGS["Vendor"] or "Vendor"
                local expName = nil
                local qid, aid = nil, nil
                local isProfession = false
                local requirement = nil

                local sources = expansionData and expansionData[idNum] or nil
                if sources and type(sources) == "table" then
                    local q = FirstOrSelf(sources.quest)
                    local a = FirstOrSelf(sources.achievement)
                    local d = FirstOrSelf(sources.drop)

                    if q then
                        srcType = INTERNED_STRINGS["Quest"] or "Quest"
                        expName = q.expansion or expName
                        qid = q.questId or qid
                        requirement = INTERNED_STRINGS["Quest"] or "Quest"
                    elseif a then
                        srcType = INTERNED_STRINGS["Achievement"] or "Achievement"
                        expName = a.expansion or expName
                        aid = a.achievementId or aid
                        requirement = INTERNED_STRINGS["Achievement"] or "Achievement"
                    elseif d then
                        srcType = INTERNED_STRINGS["Drop"] or "Drop"
                        expName = d.expansion or expName
                    elseif sources.vendor and sources.vendor.vendorDetails then
                        expName = sources.vendor.vendorDetails.expansion or expName
                    end
                end

                local inferredType, inferredCategory = nil, nil
                if sources and type(sources) == "table" then
                    local n = nil
                    if sources.vendor and sources.vendor.itemName then
                        n = sources.vendor.itemName
                    elseif sources.quest and FirstOrSelf(sources.quest) and FirstOrSelf(sources.quest).title then
                        n = FirstOrSelf(sources.quest).title
                    elseif sources.achievement and FirstOrSelf(sources.achievement) and FirstOrSelf(sources.achievement).title then
                        n = FirstOrSelf(sources.achievement).title
                    elseif sources.drop and FirstOrSelf(sources.drop) and FirstOrSelf(sources.drop).title then
                        n = FirstOrSelf(sources.drop).title
                    end
                    inferredType, inferredCategory = InferTypeAndCategoryFromName(n)
                end

                if professionData and professionData[idNum] then
                    isProfession = true
                    srcType = INTERNED_STRINGS["Profession"] or "Profession"
                    expName = InferExpansionFromProfessionSkill(professionData[idNum].skill) or expName
                    requirement = INTERNED_STRINGS["Profession"] or "Profession"
                end

                if repLookup and repLookup[idNum] then
                    local repInfo = repLookup[idNum]
                    local repType = repInfo and repInfo.rep or nil
                    if repType then
                        local repLower = string_lower(tostring(repType))
                        if repLower == "renown" then
                            requirement = INTERNED_STRINGS["Renown"] or "Renown"
                        else
                            requirement = INTERNED_STRINGS["Reputation"] or "Reputation"
                        end
                    else
                        -- Treat any faction-gated vendor item as reputation-gated, even if rep type is missing.
                        requirement = INTERNED_STRINGS["Reputation"] or "Reputation"
                    end
                end

                -- Treat reputation/renown-gated vendor items as their own "source type" so the Source
                -- filter behaves as users expect (without relying on API enrichment).
                if srcType == (INTERNED_STRINGS["Vendor"] or "Vendor") then
                    if requirement == (INTERNED_STRINGS["Reputation"] or "Reputation") then
                        srcType = INTERNED_STRINGS["Reputation"] or "Reputation"
                    elseif requirement == (INTERNED_STRINGS["Renown"] or "Renown") then
                        srcType = INTERNED_STRINGS["Renown"] or "Renown"
                    end
                end

                if expName and expName ~= "" then
                    seenExpansions[expName] = true
                    facetIndex.expansions[expName] = true
                end

                meta[idNum] = {
                    sourceType = srcType,
                    expansion = expName,
                    questId = qid,
                    achievementId = aid,
                    isProfession = isProfession,
                    requirement = requirement,
                    inferredType = inferredType,
                    inferredCategory = inferredCategory,
                }

                -- Vendor / zone indices (for fast candidate narrowing during filtering).
                if vendorIndex and vendorPool then
                    local indices = vendorIndex[idNum]
                    if type(indices) == "table" then
                        local seenVendorName = {}
                        local seenVendorNorm = {}
                        local seenZoneName = {}
                        local seenMapID = {}

                        for _, idx in ipairs(indices) do
                            local v = idx and vendorPool[idx] or nil
                            if v then
                                local vn = v.name
                                if vn and vn ~= "" and vn ~= "None" and not seenVendorName[vn] then
                                    seenVendorName[vn] = true
                                    AddFacetArray(facetIndex.vendorsByName, vn, idNum)
                                end
                                local norm = vn and NormalizeVendorName(vn) or nil
                                if norm and norm ~= "" and not seenVendorNorm[norm] then
                                    seenVendorNorm[norm] = true
                                    AddFacetArray(facetIndex.vendorsByNormalized, norm, idNum)
                                end

                                local zoneName = v.location
                                if zoneName and zoneName ~= "" and not seenZoneName[zoneName] then
                                    seenZoneName[zoneName] = true
                                    AddFacetArray(facetIndex.zonesByName, zoneName, idNum)
                                end
                                local mapID = v.coords and v.coords.mapID or nil
                                if type(mapID) == "number" and mapID > 0 and not seenMapID[mapID] then
                                    seenMapID[mapID] = true
                                    AddFacetArray(facetIndex.zonesByMapID, mapID, idNum)
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    table_sort(ids)

    s.allItemIDs = ids
    s._itemMeta = meta
    s._seenExpansions = seenExpansions
    s._facetIndex = facetIndex

    BuildFilterOptionsFromIndexes(s)

    return s.allItemIDs
end

-- Use shared GetFilterHash from Util (moved to Shared.lua to eliminate duplication)
local function GetFilterHash(filters)
    return Util.GetFilterHash and Util.GetFilterHash(filters) or ""
end

function DataManager:FilterItemIDs(itemIDs, filters)
    if not itemIDs or #itemIDs == 0 then
        return {}
    end

    local s = self._state
    local filterHash = GetFilterHash(filters or {})
    -- While quality data is still loading, bypass the cache so filters can refine results as item
    -- data arrives (C_Item.RequestLoadItemDataByID is async and may take multiple passes).
    if s.filteredIDCache and s.lastFilterHash == filterHash and not s._qualityFilterLoading then
        return s.filteredIDCache
    end

    local meta = s._itemMeta or {}
    local out = {}
    local facetIndex = s._facetIndex

    local searchText = (filters and filters.searchText and string_lower(filters.searchText)) or ""
    local wantSearch = searchText ~= ""

    local selectedExpansions = filters and filters.selectedExpansions or nil
    local selectedSources = filters and filters.selectedSources or nil
    local selectedCategories = filters and filters.selectedCategories or nil

    local wantVendor = filters and filters.vendor and filters.vendor ~= "All Vendors"
    local wantZone = filters and filters.zone and filters.zone ~= "All Zones"
    local wantCollection = filters and filters.collection and filters.collection ~= "" and filters.collection ~= "All"
    local wantFaction = filters and filters.faction and filters.faction ~= "All Factions"
    local wantRequirement = filters and filters.requirement and filters.requirement ~= "All Requirements"
    -- Quality should work even if the Housing API cache is empty/disabled; prefer API when available,
    -- otherwise fall back to local item data (C_Item/GetItemInfo).
    local wantQuality = (filters and filters.quality and filters.quality ~= "" and filters.quality ~= "All Qualities") or false
    local wantApiQuality = wantQuality and ALLOW_API_QUALITY or false
    local wantType = filters and filters.type and filters.type ~= "All Types"
    local wantCategory = (filters and filters.category and filters.category ~= "All Categorys" and filters.category ~= "All Categories") or (selectedCategories and next(selectedCategories) ~= nil)

    local wantSource = (filters and filters.source and filters.source ~= "All Sources") or (selectedSources and next(selectedSources) ~= nil)
    local wantExpansion = (filters and filters.expansion and filters.expansion ~= "" and filters.expansion ~= "All Expansions") or (selectedExpansions and next(selectedExpansions) ~= nil)

    local vendorPool = _G.HousingVendorPool
    local vendorIndex = _G.HousingItemVendorIndex
    local repLookup = _G.HousingVendorItemToFaction

    local apiDataCache = wantApiQuality and GetApiDataCache() or nil
    local wantApiFacets = wantApiQuality
    local apiMissing = 0
    local localQualityMissing = 0

    local localQualityCache = s._localQualityCache
    if not localQualityCache then
        localQualityCache = {}
        s._localQualityCache = localQualityCache
    end

    local nameCache = s._nameCache
    if not nameCache then
        nameCache = {}
        s._nameCache = nameCache
    end

    -- Narrow the scan set early using precomputed facet indexes (huge win for vendor/zone filters).
    local scanIDs = itemIDs
    if facetIndex then
        if wantVendor and facetIndex.vendorsByNormalized then
            local norm = NormalizeVendorName(filters.vendor)
            scanIDs = (norm and facetIndex.vendorsByNormalized[norm]) or {}
        elseif wantZone and (facetIndex.zonesByMapID or facetIndex.zonesByName) then
            if filters and filters.zoneMapID and facetIndex.zonesByMapID and facetIndex.zonesByMapID[filters.zoneMapID] then
                scanIDs = facetIndex.zonesByMapID[filters.zoneMapID]
            elseif filters and filters.zone and facetIndex.zonesByName and facetIndex.zonesByName[filters.zone] then
                scanIDs = facetIndex.zonesByName[filters.zone]
            else
                scanIDs = {}
            end
        end
    end

    for _, idNum in ipairs(scanIDs) do
        local m = meta[idNum] or {}
        local ok = true

        if ok and wantExpansion then
            local exp = m.expansion or "Other"
            local hasSelections = false
            if selectedExpansions then
                for _, _ in pairs(selectedExpansions) do
                    hasSelections = true
                    break
                end
            end
            if hasSelections then
                if not selectedExpansions[exp] then
                    ok = false
                end
            elseif filters and filters.expansion and filters.expansion ~= "All Expansions" and filters.expansion ~= "" then
                if exp ~= filters.expansion then
                    ok = false
                end
            end
        end

        if ok and wantSource then
            local st = tostring(m.sourceType or (INTERNED_STRINGS["Vendor"] or "Vendor"))
            -- Some users expect "Reputation"/"Renown" to behave like a source filter even though
            -- these are vendor items with a gating requirement. Treat those as matchable sources.
            local repSource = nil
            if repLookup and repLookup[idNum] then
                local repInfo = repLookup[idNum]
                local repType = repInfo and repInfo.rep or nil
                if repType and string_lower(tostring(repType)) == "renown" then
                    repSource = INTERNED_STRINGS["Renown"] or "Renown"
                else
                    repSource = INTERNED_STRINGS["Reputation"] or "Reputation"
                end
            end
            if selectedSources and next(selectedSources) ~= nil then
                local matches = (selectedSources[st] or selectedSources[tostring(st)] or (repSource and (selectedSources[repSource] or selectedSources[tostring(repSource)])))

                -- Wishlist is a virtual source (not a real sourceType); check saved state.
                if not matches and (selectedSources["Wishlist"] or selectedSources[tostring(INTERNED_STRINGS["Wishlist"] or "Wishlist")]) then
                    if _G.HousingDB and _G.HousingDB.wishlist and (_G.HousingDB.wishlist[idNum] or _G.HousingDB.wishlist[tostring(idNum)]) then
                        matches = true
                    end
                end

                if not matches then
                    ok = false
                end
            elseif filters and filters.source and filters.source ~= "All Sources" then
                local want = tostring(filters.source)
                if want == "Wishlist" or want == tostring(INTERNED_STRINGS["Wishlist"] or "Wishlist") then
                    if not (_G.HousingDB and _G.HousingDB.wishlist and (_G.HousingDB.wishlist[idNum] or _G.HousingDB.wishlist[tostring(idNum)])) then
                        ok = false
                    end
                else
                if st ~= want and (not repSource or tostring(repSource) ~= want) then
                    ok = false
                end
                end
            end
        end

        if ok and wantRequirement then
            local req = m.requirement or "None"
            if req == "None" and repLookup and repLookup[idNum] then
                local repInfo = repLookup[idNum]
                local repType = repInfo and repInfo.rep or nil
                if repType and string_lower(tostring(repType)) == "renown" then
                    req = "Renown"
                else
                    req = "Reputation"
                end
            end
            if filters.requirement == "None" then
                if req ~= "None" then ok = false end
            elseif req ~= filters.requirement then
                ok = false
            end
        end

        if ok and wantQuality then
            local q = localQualityCache[idNum]

            if q == nil and apiDataCache then
                local apiData = apiDataCache[idNum]
                if apiData then
                    TouchApiDataCacheItem(idNum)
                    q = apiData.quality
                else
                    apiMissing = apiMissing + 1
                end
            end

            if q == nil then
                q = GetLocalItemQuality(idNum)
                if q ~= nil then
                    localQualityCache[idNum] = q
                end
            end

            if q ~= nil then
                if QUALITY_NAMES[q] ~= filters.quality then
                    ok = false
                end
            else
                -- Without quality data we can't reliably filter yet; hide the item for now.
                -- The warm-up logic below will request data and re-apply filters as it arrives.
                localQualityMissing = localQualityMissing + 1
                ok = false
            end
        end

        if ok and (wantType or wantCategory) then
            local inferredType = m.inferredType
            local inferredCategory = m.inferredCategory

            if wantType then
                local matches = (inferredType == filters.type) or (inferredCategory == filters.type)
                if not matches then ok = false end
            end

            if ok and wantCategory then
                local matchesCategory = false

                if selectedCategories and next(selectedCategories) ~= nil then
                    for selectedCategory, isSelected in pairs(selectedCategories) do
                        if isSelected then
                            if (selectedCategory == inferredCategory or selectedCategory == inferredType) then
                                matchesCategory = true
                                break
                            end
                        end
                    end
                elseif filters and filters.category and filters.category ~= "" and filters.category ~= "All Categories" and filters.category ~= "All Categorys" then
                    matchesCategory =
                        (filters.category == inferredCategory) or
                        (filters.category == inferredType) or
                        false
                else
                    matchesCategory = true
                end

                if not matchesCategory then ok = false end
            end
        end

        if ok and wantFaction then
            local itemFaction = "Neutral"
            local indices = vendorIndex and vendorIndex[idNum] or nil
            if indices and vendorPool then
                local hasAlliance = false
                local hasHorde = false
                for _, idx in ipairs(indices) do
                    local v = idx and vendorPool[idx] or nil
                    local f = v and v.faction or nil
                    if f == "Alliance" or f == 1 then
                        hasAlliance = true
                    elseif f == "Horde" or f == 2 then
                        hasHorde = true
                    end
                end
                -- If item has both Alliance and Horde vendors, it's Neutral (available to both)
                if hasAlliance and hasHorde then
                    itemFaction = "Neutral"
                elseif hasAlliance then
                    itemFaction = "Alliance"
                elseif hasHorde then
                    itemFaction = "Horde"
                end
            else
                -- Fallback: use the single-vendor details when the vendor index isn't present.
                local sources = _G.HousingExpansionData and _G.HousingExpansionData[idNum] or nil
                local vd = sources and sources.vendor and sources.vendor.vendorDetails or nil
                local f = vd and vd.faction or nil
                if f == "Alliance" or f == 1 then
                    itemFaction = "Alliance"
                elseif f == "Horde" or f == 2 then
                    itemFaction = "Horde"
                elseif f == "Neutral" or f == 0 then
                    itemFaction = "Neutral"
                end
            end
            if itemFaction ~= filters.faction and itemFaction ~= "Neutral" then
                ok = false
            end
        end

        if ok and wantVendor then
            local matchesVendor = false
            local indices = vendorIndex and vendorIndex[idNum] or nil
            if indices and vendorPool then
                local normalizedFilterVendor = NormalizeVendorName(filters.vendor)
                for _, idx in ipairs(indices) do
                    local v = idx and vendorPool[idx] or nil
                    local vendorName = v and v.name or nil
                    if vendorName and vendorName ~= "" and vendorName ~= "None" then
                        if vendorName == filters.vendor then
                            matchesVendor = true
                            break
                        end
                        if normalizedFilterVendor and NormalizeVendorName(vendorName) == normalizedFilterVendor then
                            matchesVendor = true
                            break
                        end
                    end
                end
            end
            if not matchesVendor then
                ok = false
            end
        end

        if ok and wantZone then
            local matchesZone = false
            local indices = vendorIndex and vendorIndex[idNum] or nil
            local wantMapID = filters and filters.zoneMapID and tonumber(filters.zoneMapID) or nil

            if indices and vendorPool then
                for _, idx in ipairs(indices) do
                    local v = idx and vendorPool[idx] or nil
                    if v then
                        if wantMapID and v.coords and tonumber(v.coords.mapID) == wantMapID then
                            matchesZone = true
                            break
                        end

                        local zoneName = v.location
                        if zoneName and zoneName ~= "" and zoneName == filters.zone then
                            matchesZone = true
                            break
                        end
                    end
                end
            end

            if not matchesZone then
                ok = false
            end
        end

        if ok and wantCollection then
            local isCollected = false
            if _G.HousingCollectionAPI and _G.HousingCollectionAPI.IsItemCollected then
                isCollected = _G.HousingCollectionAPI:IsItemCollected(idNum)
            end
            if filters.collection == "Collected" and not isCollected then
                ok = false
            elseif filters.collection == "Uncollected" and isCollected then
                ok = false
            end
        end

        if ok and wantSearch then
            local cached = nameCache[idNum]
            if cached == nil then
                local name = nil
                if _G.C_Item and _G.C_Item.GetItemNameByID then
                    name = _G.C_Item.GetItemNameByID(idNum)
                end
                cached = name and string_lower(name) or ""
                nameCache[idNum] = cached
            end
            if cached == "" then
                if not tostring(idNum):find(searchText, 1, true) then
                    ok = false
                end
            else
                if not cached:find(searchText, 1, true) and not tostring(idNum):find(searchText, 1, true) then
                    ok = false
                end
            end
        end

        -- Show Only Available Items filter
        if ok and filters and filters.showOnlyAvailable then
            if not IsItemAvailableByID(idNum) then
                ok = false
            end
        end

        if ok then
            out[#out + 1] = idNum
        end
    end

    -- If an API-dependent filter produced 0 results while API data is missing, kick off a batch load and
    -- return the unfiltered list for now (avoids “everything disappears” until cache warms).
    -- Track quality loading state for the empty-state UI.
    s._qualityFilterLoading = wantQuality and (apiMissing > 0 or localQualityMissing > 0) or false

    -- Quality filter warm-up (chunked): avoid freezing by never scheduling huge ID lists at once.
    -- We load quality only and re-apply filters as the cache fills.
    local apiDisabled = HousingDB and HousingDB.settings and HousingDB.settings.disableApiCalls
    local uiActive = s.uiActive == true
    if uiActive and (not apiDisabled) and wantApiFacets and apiMissing > 0 and not s.batchLoadInProgress and self.BatchLoadAPIDataForItemIDs then
        -- Throttle kicks to avoid CPU churn when filters re-apply rapidly.
        local now = GetTime and GetTime() or 0
        if (tonumber(s._lastQualityWarmKick) or 0) > 0 and now - (tonumber(s._lastQualityWarmKick) or 0) < 0.75 then
            s.filteredIDCache = out
            s.lastFilterHash = filterHash
            return out
        end
        s._lastQualityWarmKick = now

        local total = #itemIDs
        local batchSize = 250
        local cursor = tonumber(s._qualityWarmCursor) or 1
        if cursor < 1 or cursor > total then cursor = 1 end

        local idsToLoad = {}
        local added = 0
        local i = cursor
        local retryAt = s._qualityRetryAt
        while added < batchSize and added < total do
            local candidateID = itemIDs[i]
            local nextRetry = (retryAt and candidateID and retryAt[candidateID]) or 0
            if candidateID and (not nextRetry or nextRetry <= now) then
                idsToLoad[#idsToLoad + 1] = candidateID
                added = added + 1
            end
            i = i + 1
            if i > total then i = 1 end
            if i == cursor then break end
        end

        s._qualityWarmCursor = i
        if #idsToLoad > 0 then
            pcall(self.BatchLoadAPIDataForItemIDs, self, idsToLoad, function()
                s.filteredIDCache = nil
                s.lastFilterHash = nil
                RequestApplyFiltersDebounced(s)
            end, { qualityOnly = true })
        else
            -- Nothing eligible to retry yet; stop showing loading state.
            s._qualityFilterLoading = false
        end
    end

    -- Local item-quality warm-up (does not use Housing API calls).
    if uiActive and wantQuality and localQualityMissing > 0 and _G.C_Item and _G.C_Item.RequestLoadItemDataByID then
        local now = GetTime and GetTime() or 0
        if (tonumber(s._lastLocalQualityWarmKick) or 0) == 0 or now - (tonumber(s._lastLocalQualityWarmKick) or 0) >= 0.75 then
            s._lastLocalQualityWarmKick = now

            local total = #itemIDs
            local batchSize = 250
            local cursor = tonumber(s._localQualityWarmCursor) or 1
            if cursor < 1 or cursor > total then cursor = 1 end

            local retryAt = s._localQualityRetryAt
            if not retryAt then
                retryAt = {}
                s._localQualityRetryAt = retryAt
            end

            local added = 0
            local i = cursor
            while added < batchSize and added < total do
                local candidateID = itemIDs[i]
                local nextRetry = (retryAt and candidateID and retryAt[candidateID]) or 0
                if candidateID and (not nextRetry or nextRetry <= now) then
                    pcall(_G.C_Item.RequestLoadItemDataByID, candidateID)
                    retryAt[candidateID] = now + 1.0
                    added = added + 1
                end
                i = i + 1
                if i > total then i = 1 end
                if i == cursor then break end
            end

            s._localQualityWarmCursor = i
            if added > 0 then
                RequestApplyFiltersDebounced(s)
            end
        end
    end

    s.filteredIDCache = out
    s.lastFilterHash = filterHash
    return out
end

function DataManager:GetItemMeta(itemID)
    local s = self._state
    return (s._itemMeta and s._itemMeta[itemID]) or nil
end

function DataManager:GetItemRecord(itemID)
    local idNum = tonumber(itemID)
    if not idNum then return nil end

    EnsureDataLoaded()

    -- DNT / DO NOT USE items should never appear.
    if _G.HousingDNTItems and _G.HousingDNTItems[idNum] then
        return nil
    end

    local s = self._state
    local cache = s._itemRecordCache
    if not cache then
        cache = {}
        s._itemRecordCache = cache
        s._itemRecordCacheCount = 0
    end

    if cache[idNum] then
        return cache[idNum]
    end

    local decorData = _G.HousingAllItems and _G.HousingAllItems[idNum] or nil
    if not decorData then
        return nil
    end

    local m = (s._itemMeta and s._itemMeta[idNum]) or {}

    local itemName = nil
    if _G.C_Item and _G.C_Item.GetItemNameByID then
        itemName = _G.C_Item.GetItemNameByID(idNum)
    end

    local sources = _G.HousingExpansionData and _G.HousingExpansionData[idNum] or nil
    if (not itemName or itemName == "" or itemName == "Unknown Item") and sources then
        if sources.vendor and sources.vendor.itemName then
            itemName = sources.vendor.itemName
        elseif sources.quest and sources.quest.title then
            itemName = sources.quest.title
        elseif sources.achievement and sources.achievement.title then
            itemName = sources.achievement.title
        elseif sources.drop and sources.drop.title then
            itemName = sources.drop.title
        end
    end
    if not itemName or itemName == "" then
        itemName = "Unknown Item"
    end

    local record = {
        name = itemName,
        itemID = tostring(idNum),
        decorID = decorData[1],
        modelFileID = decorData[2] or "",
        model3D = decorData[2] or nil,
        thumbnailFileID = decorData[3] or "",

        -- Static cost fallbacks (optional): populated from `_G.HousingCostData`
        cost = nil,
        buyPriceCopper = nil,
        price = nil, -- gold (integer), legacy UI/statistics field
        currency = nil, -- only for non-gold single-currency items (optional)

        expansionName = m.expansion,
        _sourceType = m.sourceType or (INTERNED_STRINGS["Vendor"] or "Vendor"),
        _isProfessionItem = m.isProfession or false,
        _questId = m.questId,
        _achievementId = m.achievementId,

        coords = { x = 0, y = 0 },
        mapID = 0,
        faction = INTERNED_STRINGS["Neutral"] or "Neutral",
        npcID = nil,

        _vendorIndices = _G.HousingItemVendorIndex and _G.HousingItemVendorIndex[idNum] or nil,

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
    }

    -- Static inferred facets (works even when Housing APIs are unavailable)
    record.type = m.inferredType
    record.category = m.inferredCategory

    local apiDataCache = GetApiDataCache()
    if apiDataCache and apiDataCache[idNum] then
        local apiData = apiDataCache[idNum]
        TouchApiDataCacheItem(idNum)

        if not HARD_DATA_ONLY then
            record._apiExpansion = apiData.expansion
            record._apiCategory = apiData.category
            record._apiSubcategory = apiData.subcategory
            record._apiVendor = apiData.vendor
            record._apiZone = apiData.zone
            record._apiQuality = apiData.quality
            record._apiNumStored = apiData.numStored or 0
            record._apiNumPlaced = apiData.numPlaced or 0
            record._apiAchievement = apiData.achievement
            record._apiSourceText = apiData.sourceText
            record._sourceType = apiData.sourceType or record._sourceType
            record._apiDataLoaded = true

            -- Basic coords
            if apiData.coords and type(apiData.coords) == "table" then
                local cx, cy = apiData.coords.x, apiData.coords.y
                if type(cx) == "number" and type(cy) == "number" and cx > 0 and cy > 0 then
                    record.coords = apiData.coords
                    record.mapID = apiData.coords.mapID or record.mapID
                end
            end
        elseif ALLOW_API_QUALITY then
            -- Hard-data-only mode: apply ONLY quality (used for display/filtering stability).
            record._apiQuality = apiData.quality
        end
    end

    -- If vendor details exist for this item, use them for map/coords/faction/expansionName
    if sources and sources.vendor and sources.vendor.vendorDetails then
        local vd = sources.vendor.vendorDetails
        record.expansionName = record.expansionName or vd.expansion
        if vd.coords and type(vd.coords) == "table" then
            record.coords = vd.coords
            record.mapID = vd.coords.mapID or record.mapID
        end
        if vd.npcID and vd.npcID ~= "None" and vd.npcID ~= "" then
            record.npcID = vd.npcID
        end

        -- Check if item has multiple vendors with different factions
        local hasAlliance = false
        local hasHorde = false

        if record._vendorIndices and _G.HousingVendorPool then
            for _, vendorIdx in ipairs(record._vendorIndices) do
                local vendor = _G.HousingVendorPool[vendorIdx]
                if vendor and vendor.faction then
                    if vendor.faction == 1 or vendor.faction == "Alliance" then
                        hasAlliance = true
                    elseif vendor.faction == 2 or vendor.faction == "Horde" then
                        hasHorde = true
                    end
                end
            end
        end

        -- Set faction based on all vendors (not just the first one)
        if hasAlliance and hasHorde then
            -- Item sold by both factions - mark as Neutral so both can see it
            record.faction = INTERNED_STRINGS["Neutral"] or "Neutral"
        elseif vd.faction == 1 or vd.faction == "Alliance" then
            record.faction = INTERNED_STRINGS["Alliance"] or "Alliance"
        elseif vd.faction == 2 or vd.faction == "Horde" then
            record.faction = INTERNED_STRINGS["Horde"] or "Horde"
        else
            record.faction = INTERNED_STRINGS["Neutral"] or "Neutral"
        end

        record.vendorName = vd.vendorName
        record.zoneName = vd.location
    end

    -- Static cost enrichment (does not touch vendor/coords; only adds missing cost info)
    local costData = _G.HousingCostData and _G.HousingCostData[idNum] or nil
    if costData and type(costData) == "table" then
        local function WithGoldIcon(text)
            if type(text) ~= "string" or text == "" then
                return text
            end
            -- Replace "75 gold" / "1,000 gold*" with a gold coin icon tag while preserving any trailing "*".
            return (text:gsub("([%d,]+)%s*[Gg]old(%*?)", "%1 |TInterface\\MoneyFrame\\UI-GoldIcon:0|t%2"))
        end

        if (not record.cost or record.cost == "") and type(costData.cost) == "string" and costData.cost ~= "" then
            record.cost = WithGoldIcon(costData.cost)
        end

        -- Preserve structured currency cost components for icon rendering in UI when API doesn't provide cost breakdown.
        if type(costData.costComponents) == "table" and (not record._staticCostComponents) then
            record._staticCostComponents = costData.costComponents
        end

        local copper = tonumber(costData.buyPriceCopper)
        if copper and copper > 0 then
            record.buyPriceCopper = record.buyPriceCopper or copper
            if not record.price or record.price <= 0 then
                record.price = math.floor(copper / 10000)
            end
        end
    end

    -- Profession details (optional)
    if _G.HousingProfessionData and _G.HousingProfessionData[idNum] then
        local p = _G.HousingProfessionData[idNum]
        record.profession = p.profession
        record.skill = p.skill
    end

    -- Cache with a simple cap
    cache[idNum] = record
    s._itemRecordCacheCount = (s._itemRecordCacheCount or 0) + 1
    if (s._itemRecordCacheCount or 0) > MAX_ITEM_RECORD_CACHE then
        s._itemRecordCache = {}
        s._itemRecordCacheCount = 0
    end

    return record
end
