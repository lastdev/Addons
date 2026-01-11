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
local function CoalesceNonEmptyString(a,b) return Util.CoalesceNonEmptyString and Util.CoalesceNonEmptyString(a,b) or (a~=nil and a~="" and a or b) end
local function InferFactionFromText(text) return Util.InferFactionFromText and Util.InferFactionFromText(text) or INTERNED_STRINGS["Neutral"] end

-- API-only vendor mode - static VendorLocations fallbacks disabled for accuracy
local USE_STATIC_VENDOR_LOCATIONS = false

function DataManager:CancelBatchLoads()
    state._batchCancelToken = (tonumber(state._batchCancelToken) or 0) + 1
    state.batchLoadInProgress = false
end

-- Batch load API data for all items (50 items at a time)
function DataManager:BatchLoadAPIData(allItems, filterOptions)
    local token = (tonumber(state._batchCancelToken) or 0)
    local itemsToLoad = {}

    -- Collect items that need API data loaded
    local apiDataCache = GetApiDataCache()
    for _, item in ipairs(allItems) do
        if item.itemID and item.itemID ~= "" and not item._apiDataLoaded then
            local itemID = tonumber(item.itemID)
            if itemID and not apiDataCache[itemID] then
                table_insert(itemsToLoad, {itemID = itemID, itemRecord = item})
            end
        end
    end

    if #itemsToLoad == 0 then
        state.batchLoadInProgress = false
        return
    end

    -- Process in batches of 50
    local batchSize = 50
    local currentBatch = 1

    local function ProcessBatch(startIndex)
        if (tonumber(state._batchCancelToken) or 0) ~= token then
            state.batchLoadInProgress = false
            return
        end
        local endIndex = math.min(startIndex + batchSize - 1, #itemsToLoad)
        local apiDataCache = GetApiDataCache()
        local wroteAny = false

        for i = startIndex, endIndex do
            local entry = itemsToLoad[i]
            local itemID = entry.itemID
            local itemRecord = entry.itemRecord

            -- Use HousingAPICache for all API calls
            local apiExpansion = HousingAPICache:GetExpansion(itemID)
            local catalogData = HousingAPICache:GetCatalogData(itemID)
            local apiVendor = nil
            local apiZone = nil

            -- Get vendor info through cache
            local apiCost = nil
            local apiCoords = nil
            local apiMapID = nil
            local baseInfo = HousingAPI and HousingAPI:GetDecorItemInfoFromItemID(itemID)
            if baseInfo and baseInfo.decorID then
                local vendorInfo = HousingAPICache:GetVendorInfo(baseInfo.decorID)
                if vendorInfo then
                    apiVendor = vendorInfo.name
                    apiZone = vendorInfo.zone
                    -- Store cost data from API
                    if vendorInfo.cost and #vendorInfo.cost > 0 then
                        apiCost = vendorInfo.cost
                    end
                    -- Store coordinates from API
                    if vendorInfo.coords and vendorInfo.coords.x and vendorInfo.coords.y then
                        apiCoords = vendorInfo.coords
                    end
                    -- Store mapID from API
                    if vendorInfo.mapID then
                        apiMapID = vendorInfo.mapID
                    end
                end
            end

            -- Determine requirement type from catalog data
            local requirementType = "None"
            if catalogData then
                if catalogData.achievement or catalogData.achievementID then
                    requirementType = "Achievement"
                elseif catalogData.quest or catalogData.questID then
                    requirementType = "Quest"
                elseif catalogData.reputation then
                    requirementType = "Reputation"
                elseif catalogData.renown then
                    requirementType = "Renown"
                elseif catalogData.profession then
                    requirementType = "Profession"
                elseif catalogData.event then
                    requirementType = "Event"
                elseif catalogData.class then
                    requirementType = "Class"
                elseif catalogData.race then
                    requirementType = "Race"
                end
            end

            -- Get quality name
            local qualityValue = catalogData and catalogData.quality
            local qualityName = qualityValue and QUALITY_NAMES[qualityValue] or nil

            -- Cache the aggregated API data (including all rich fields)
            apiDataCache[itemID] = {
                expansion = apiExpansion,
                category = catalogData and catalogData.categoryNames and catalogData.categoryNames[1] or nil,
                subcategory = catalogData and catalogData.subcategoryNames and catalogData.subcategoryNames[1] or nil,
                vendor = apiVendor,
                zone = apiZone,
                cost = apiCost,
                coords = apiCoords,  -- Vendor coordinates from API
                mapID = apiMapID,    -- Map ID from API
                -- Additional rich data from API
                asset = catalogData and catalogData.asset or nil,
                quality = qualityValue,
                qualityName = qualityName,
                requirementType = requirementType,
                numStored = catalogData and catalogData.numStored or 0,
                numPlaced = catalogData and catalogData.numPlaced or 0,
                achievement = catalogData and catalogData.achievement or nil,
                achievementID = catalogData and catalogData.achievementID or nil,
                sourceText = catalogData and catalogData.sourceText or nil,
                recordID = catalogData and catalogData.recordID or nil,
                entryType = catalogData and catalogData.entryType or nil
            }
            wroteAny = true
            TouchApiDataCacheItem(itemID)

            -- Update item record with all rich API data
            if itemRecord then
                local apiData = apiDataCache[itemID]
                itemRecord._apiExpansion = apiData.expansion
                itemRecord._apiCategory = apiData.category
                itemRecord._apiSubcategory = apiData.subcategory
                itemRecord._apiVendor = apiData.vendor
                itemRecord._apiZone = apiData.zone
                itemRecord._apiCost = apiData.cost
                -- Store additional rich data
                itemRecord._apiAsset = apiData.asset
                itemRecord._apiQuality = apiData.quality
                itemRecord._apiQualityName = apiData.qualityName
                itemRecord._apiRequirementType = apiData.requirementType
                itemRecord._apiNumStored = apiData.numStored
                itemRecord._apiNumPlaced = apiData.numPlaced
                itemRecord._apiAchievement = apiData.achievement
                itemRecord._apiSourceText = apiData.sourceText
                itemRecord._apiRecordID = apiData.recordID
                itemRecord._apiEntryType = apiData.entryType
                itemRecord._apiDataLoaded = true

                -- Update vendor location data on item record
                if apiData.coords then
                    itemRecord.coords = apiData.coords
                end
                if apiData.mapID then
                    itemRecord.mapID = apiData.mapID
                end
                -- Store API vendor/zone data separately - DO NOT overwrite authoritative static data
                if apiData.vendor and apiData.vendor ~= "" then
                    itemRecord._apiVendor = apiData.vendor
                    -- Only set vendorName if it's not already set from authoritative sources
                    if not itemRecord.vendorName or itemRecord.vendorName == "" then
                        itemRecord.vendorName = apiData.vendor
                    end
                end
                if apiData.zone and apiData.zone ~= "" then
                    itemRecord._apiZone = apiData.zone
                    -- Only set zoneName if it's not already set from authoritative sources
                    if not itemRecord.zoneName or itemRecord.zoneName == "" then
                        itemRecord.zoneName = apiData.zone
                    end
                end
                if apiData.expansion then
                    itemRecord.expansionName = apiData.expansion
                end
                
                -- If item has vendor name from API but no coords, look up vendor in HousingVendorLocations
                if USE_STATIC_VENDOR_LOCATIONS and apiData.vendor and apiData.vendor ~= "" and not itemRecord.coords and HousingVendorLocations then
                    -- Normalize vendor name for matching (remove quotes, trim whitespace, lowercase)
                    local normalizedApiVendor = string.lower(string.gsub(apiData.vendor, '["\']', ''):match("^%s*(.-)%s*$"))
                     
                    for expansion, zones in pairs(HousingVendorLocations) do
                        for zoneName, vendors in pairs(zones) do
                            for _, vendorData in ipairs(vendors) do
                                if vendorData.vendorName then
                                    local normalizedVendorName = string.lower(vendorData.vendorName:match("^%s*(.-)%s*$"))
                                    if normalizedVendorName == normalizedApiVendor and vendorData.coords then
                                        itemRecord.coords = vendorData.coords
                                        if vendorData.coords.mapID then
                                            itemRecord.mapID = vendorData.coords.mapID
                                        end
                                        if not itemRecord.zoneName then
                                            itemRecord.zoneName = zoneName
                                        end
                                        if not itemRecord.expansionName then
                                            itemRecord.expansionName = expansion
                                        end
                                        break
                                    end
                                end
                            end
                            if itemRecord.coords then break end
                        end
                        if itemRecord.coords then break end
                    end
                end

                -- Update filter options with API data
                if apiData.expansion then
                    filterOptions.expansions[apiData.expansion] = true
                end
                if apiData.category then
                    filterOptions.categories[apiData.category] = true
                    -- Also add category to types for easier filtering
                    filterOptions.types[apiData.category] = true
                end
                if apiData.subcategory then
                    filterOptions.types[apiData.subcategory] = true
                    -- Also add subcategory to categories for easier filtering
                    filterOptions.categories[apiData.subcategory] = true
                end
                if apiData.vendor and apiData.vendor ~= "" then
                    filterOptions.vendors[apiData.vendor] = true
                end
                if apiData.zone and apiData.zone ~= "" then
                    filterOptions.zones[apiData.zone] = true
                end
                if apiData.qualityName then
                    filterOptions.qualities[apiData.qualityName] = true
                end
                if apiData.requirementType then
                    filterOptions.requirements[apiData.requirementType] = true
                end
            end
        end

        if wroteAny then
            PruneApiDataCacheIfNeeded(apiDataCache)
        end

        -- Schedule next batch or complete
        if endIndex < #itemsToLoad then
            currentBatch = currentBatch + 1
            C_Timer.After(0, function()
                ProcessBatch(endIndex + 1)
            end)
        else
            -- All batches complete - refresh filter options and UI
            state.batchLoadInProgress = false

            -- Update filter options cache with new API data
            state.filterOptionsCache = {
                expansions = DataManager:_SortKeys(filterOptions.expansions),
                vendors = DataManager:_SortKeys(filterOptions.vendors),
                zones = DataManager:_SortKeys(filterOptions.zones),
                types = DataManager:_SortKeys(filterOptions.types),
                categories = DataManager:_SortKeys(filterOptions.categories),
                factions = DataManager:_SortKeys(filterOptions.factions),
                sources = DataManager:_SortKeys(filterOptions.sources),
                qualities = DataManager:_SortKeys(filterOptions.qualities),
                requirements = DataManager:_SortKeys(filterOptions.requirements)
            }

            -- Invalidate filter cache to force refresh
            state.filteredResultsCache = nil
            state.lastFilterHash = nil

            -- Refresh filters
            C_Timer.After(0.1, function()
                if HousingFilters then
                    HousingFilters:ApplyFilters()
                end
            end)
        end
    end

    -- Start processing first batch
    ProcessBatch(1)
end

-- Batch load API data for a list of numeric itemIDs (low-overhead mode).
-- This populates the session API cache used by ID-based filtering (quality/type/category/etc).
function DataManager:BatchLoadAPIDataForItemIDs(itemIDs, onComplete, opts)
    if type(itemIDs) ~= "table" or #itemIDs == 0 then
        if type(onComplete) == "function" then
            pcall(onComplete, true)
        end
        return
    end

    if state.batchLoadInProgress then
        return
    end
    state.batchLoadInProgress = true

    local token = (tonumber(state._batchCancelToken) or 0)

    opts = opts or {}
    local qualityOnly = opts.qualityOnly == true

    local itemsToLoad = {}
    local apiDataCache = GetApiDataCache()
    for _, idNum in ipairs(itemIDs) do
        local itemID = tonumber(idNum)
        if itemID and not apiDataCache[itemID] then
            table_insert(itemsToLoad, itemID)
        end
    end

    if #itemsToLoad == 0 then
        state.batchLoadInProgress = false
        if type(onComplete) == "function" then
            pcall(onComplete, true)
        end
        return
    end

    local batchSize = 50

    local function ProcessBatch(startIndex)
        if (tonumber(state._batchCancelToken) or 0) ~= token then
            state.batchLoadInProgress = false
            if type(onComplete) == "function" then
                pcall(onComplete, false)
            end
            return
        end
        local endIndex = math.min(startIndex + batchSize - 1, #itemsToLoad)
        local apiDataCache = GetApiDataCache()
        local wroteAny = false

        for i = startIndex, endIndex do
            local itemID = itemsToLoad[i]
            if itemID and not apiDataCache[itemID] then
                local catalogData = HousingAPICache and HousingAPICache.GetCatalogData and HousingAPICache:GetCatalogData(itemID) or (HousingAPI and HousingAPI.GetCatalogData and HousingAPI:GetCatalogData(itemID)) or nil
                local qualityValue = catalogData and catalogData.quality
                local qualityName = qualityValue and QUALITY_NAMES[qualityValue] or nil

                if qualityOnly then
                    -- Don't cache "unknown" quality; it would block future retries.
                    if qualityValue ~= nil then
                        apiDataCache[itemID] = {
                            quality = qualityValue,
                            qualityName = qualityName,
                        }
                        wroteAny = true
                        TouchApiDataCacheItem(itemID)
                    else
                        state._qualityRetryAt = state._qualityRetryAt or {}
                        state._qualityRetryAt[itemID] = (GetTime and GetTime() or 0) + 30
                    end
                else
                    local apiExpansion = HousingAPICache and HousingAPICache.GetExpansion and HousingAPICache:GetExpansion(itemID) or nil

                    local apiVendor, apiZone, apiCost, apiCoords, apiMapID = nil, nil, nil, nil, nil
                    local baseInfo = HousingAPI and HousingAPI.GetDecorItemInfoFromItemID and HousingAPI:GetDecorItemInfoFromItemID(itemID) or nil
                    if baseInfo and baseInfo.decorID then
                        local vendorInfo = nil
                        if HousingAPICache and HousingAPICache.GetVendorInfo then
                            vendorInfo = HousingAPICache:GetVendorInfo(baseInfo.decorID)
                        elseif HousingAPI and HousingAPI.GetDecorVendorInfo then
                            vendorInfo = HousingAPI:GetDecorVendorInfo(baseInfo.decorID)
                        end
                        if vendorInfo then
                            apiVendor = vendorInfo.name
                            apiZone = vendorInfo.zone
                            if vendorInfo.cost and #vendorInfo.cost > 0 then
                                apiCost = vendorInfo.cost
                            end
                            if vendorInfo.coords and vendorInfo.coords.x and vendorInfo.coords.y then
                                apiCoords = vendorInfo.coords
                            end
                            if vendorInfo.mapID then
                                apiMapID = vendorInfo.mapID
                            end
                        end
                    end

                    local requirementType = "None"
                    if catalogData then
                        if catalogData.achievement or catalogData.achievementID then
                            requirementType = "Achievement"
                        elseif catalogData.quest or catalogData.questID then
                            requirementType = "Quest"
                        elseif catalogData.reputation then
                            requirementType = "Reputation"
                        elseif catalogData.renown then
                            requirementType = "Renown"
                        elseif catalogData.profession then
                            requirementType = "Profession"
                        elseif catalogData.event then
                            requirementType = "Event"
                        elseif catalogData.class then
                            requirementType = "Class"
                        elseif catalogData.race then
                            requirementType = "Race"
                        end
                    end

                    apiDataCache[itemID] = {
                        expansion = apiExpansion,
                        category = catalogData and catalogData.categoryNames and catalogData.categoryNames[1] or nil,
                        subcategory = catalogData and catalogData.subcategoryNames and catalogData.subcategoryNames[1] or nil,
                        vendor = apiVendor,
                        zone = apiZone,
                        cost = apiCost,
                        coords = apiCoords,
                        mapID = apiMapID,
                        asset = catalogData and catalogData.asset or nil,
                        quality = qualityValue,
                        qualityName = qualityName,
                        requirementType = requirementType,
                        numStored = catalogData and catalogData.numStored or 0,
                        numPlaced = catalogData and catalogData.numPlaced or 0,
                        achievement = catalogData and catalogData.achievement or nil,
                        achievementID = catalogData and catalogData.achievementID or nil,
                        sourceText = catalogData and catalogData.sourceText or nil,
                        recordID = catalogData and catalogData.recordID or nil,
                        entryType = catalogData and catalogData.entryType or nil,
                    }
                    wroteAny = true
                    TouchApiDataCacheItem(itemID)
                end
            end
        end

        if wroteAny then
            PruneApiDataCacheIfNeeded(apiDataCache)
        end

        if endIndex < #itemsToLoad then
            C_Timer.After(0.01, function()
                if (tonumber(state._batchCancelToken) or 0) ~= token then
                    state.batchLoadInProgress = false
                    if type(onComplete) == "function" then
                        pcall(onComplete, false)
                    end
                    return
                end
                ProcessBatch(endIndex + 1)
            end)
        else
            state.batchLoadInProgress = false
            if type(onComplete) == "function" then
                pcall(onComplete, true)
            end
        end
    end

    C_Timer.After(0.01, function()
        if (tonumber(state._batchCancelToken) or 0) ~= token then
            state.batchLoadInProgress = false
            if type(onComplete) == "function" then
                pcall(onComplete, false)
            end
            return
        end
        ProcessBatch(1)
    end)
end
