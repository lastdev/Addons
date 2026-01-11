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

local function IsItemAvailableByID(itemID)
    local idNum = tonumber(itemID)
    if not idNum then return false end

    if _G.HousingNotReleased and _G.HousingNotReleased[idNum] then
        return false
    end

    return true
end

-- Use shared GetFilterHash from Util (moved to Shared.lua to eliminate duplication)
local function GetFilterHash(filters)
    return Util.GetFilterHash and Util.GetFilterHash(filters) or ""
end

function DataManager:FilterItems(items, filters)
    if not items or #items == 0 then
        wipe(state.filteredResults)
        return state.filteredResults
    end

    -- Check cache first
    local filterHash = GetFilterHash(filters)
    if state.filteredResultsCache and state.lastFilterHash == filterHash then
        return state.filteredResultsCache
    end

    -- Reuse pre-allocated tables instead of creating new ones (performance optimization)
    wipe(state.filteredResults)
    wipe(state.debugCounts)
    local filtered = state.filteredResults
    local debugCounts = state.debugCounts
    local searchText = string.lower(filters.searchText or "")

    -- Initialize debug counters
    debugCounts.total = #items
    debugCounts.searchFiltered = 0
    debugCounts.expansionFiltered = 0
    debugCounts.vendorFiltered = 0
    debugCounts.zoneFiltered = 0
    debugCounts.typeFiltered = 0
    debugCounts.categoryFiltered = 0
    debugCounts.factionFiltered = 0
    debugCounts.sourceFiltered = 0
    debugCounts.collectionFiltered = 0
    debugCounts.qualityFiltered = 0
    debugCounts.requirementFiltered = 0
    debugCounts.visitedFiltered = 0
    
    for _, item in ipairs(items) do
        local show = true
        
        -- Search filter - compute lowercase on-demand (memory optimization)
        if searchText ~= "" then
            local searchMatch = false
            
            -- Check core fields (convert to lowercase on-demand)
            if string.find(string.lower(item.name or ""), searchText, 1, true) or
               string.find(string.lower(item.zoneName or ""), searchText, 1, true) or
               string.find(string.lower(item.vendorName or ""), searchText, 1, true) then
                searchMatch = true
            end
            
            -- Check API data if available
            if not searchMatch and item._apiDataLoaded then
                if (item._apiExpansion and string.find(string.lower(item._apiExpansion), searchText, 1, true)) or
                   (item._apiCategory and string.find(string.lower(item._apiCategory), searchText, 1, true)) or
                   (item._apiSubcategory and string.find(string.lower(item._apiSubcategory), searchText, 1, true)) or
                   (item._apiVendor and string.find(string.lower(item._apiVendor), searchText, 1, true)) or
                   (item._apiZone and string.find(string.lower(item._apiZone), searchText, 1, true)) then
                    searchMatch = true
                end
            end
            
            if not searchMatch then
                show = false
                debugCounts.searchFiltered = debugCounts.searchFiltered + 1
            end
        end
        
        -- Expansion filter (supports multi-select)
        if show and filters.selectedExpansions then
            -- Count how many expansions are selected
            local hasSelections = false
            for _, _ in pairs(filters.selectedExpansions) do
                hasSelections = true
                break
            end
            
            -- Only filter if there are specific selections
            if hasSelections then
                local itemExpansion = item._apiExpansion or item.expansionName
                
                -- Check if item's expansion is in the selected list
                if not filters.selectedExpansions[itemExpansion] then
                    show = false
                    debugCounts.expansionFiltered = debugCounts.expansionFiltered + 1
                end
            end
        end
        
        -- Vendor filter (check ALL possible vendors for this item)
        if show and filters.vendor and filters.vendor ~= "All Vendors" then
            local matchesVendor = false

            -- Check vendor pool indices (memory-optimized multi-vendor support)
            if not matchesVendor and item._vendorIndices and type(item._vendorIndices) == "table" then
                local pool = _G.HousingVendorPool
                if pool and type(pool) == "table" then
                    local normalizedFilterVendor = NormalizeVendorName(filters.vendor)
                    for _, idx in ipairs(item._vendorIndices) do
                        local v = idx and pool[idx] or nil
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
            end

            -- Also check API and static single vendor fields
            if not matchesVendor then
                local itemVendor = CoalesceNonEmptyString(item._apiVendor, item.vendorName)
                if itemVendor == filters.vendor then
                    matchesVendor = true
                else
                    local normalizedItemVendor = NormalizeVendorName(itemVendor)
                    local normalizedFilterVendor = NormalizeVendorName(filters.vendor)
                    if normalizedItemVendor == normalizedFilterVendor then
                        matchesVendor = true
                    end
                end
            end

            if not matchesVendor then
                show = false
                debugCounts.vendorFiltered = debugCounts.vendorFiltered + 1
            end
        end
        
        -- Zone filter (check API data first, then fallback to static data)
        if show and filters.zone and filters.zone ~= "All Zones" then
            -- Profession/reputation/renown items are not inherently tied to the player's current physical zone.
            -- If the user explicitly filtered to these sources, don't let an auto zone-filter hide everything.
            local bypassZoneFilter = false
            local sourceType = item._sourceType
            if sourceType == INTERNED_STRINGS["Profession"]
                or sourceType == INTERNED_STRINGS["Reputation"]
                or sourceType == INTERNED_STRINGS["Renown"] then

                if filters.selectedSources and (filters.selectedSources[sourceType] or filters.selectedSources[tostring(sourceType)]) then
                    bypassZoneFilter = true
                elseif filters.source and (filters.source == sourceType or filters.source == tostring(sourceType)) then
                    bypassZoneFilter = true
                end
            end

            if bypassZoneFilter then
                -- do nothing
            else
                local matchesZone = false

                -- PRIORITY: Use mapID-based matching if available (language-independent)
                if filters.zoneMapID and item.mapID and item.mapID ~= 0 then
                    if item.mapID == filters.zoneMapID then
                        matchesZone = true
                    end
                end

                -- Fallback: Check vendor pool indices (memory-optimized multi-zone support via vendor locations)
                if not matchesZone and item._vendorIndices and type(item._vendorIndices) == "table" then
                    local pool = _G.HousingVendorPool
                    if pool and type(pool) == "table" then
                        for _, idx in ipairs(item._vendorIndices) do
                            local v = idx and pool[idx] or nil
                            -- Try mapID matching first
                            if filters.zoneMapID and v and v.coords and v.coords.mapID then
                                if v.coords.mapID == filters.zoneMapID then
                                    matchesZone = true
                                    break
                                end
                            end
                            -- Fallback to zone name matching
                            local zoneName = v and v.location or nil
                            if zoneName and zoneName ~= "" and zoneName == filters.zone then
                                matchesZone = true
                                break
                            end
                        end
                    end
                end

                -- Fallback: Check API and static single zone fields (zone name matching)
                if not matchesZone then
                    local apiZone = CoalesceNonEmptyString(item._apiZone, nil)
                    local staticZone = CoalesceNonEmptyString(item.zoneName, nil)
                    if apiZone == filters.zone or staticZone == filters.zone then
                        matchesZone = true
                    end
                end

                if not matchesZone then
                    show = false
                    debugCounts.zoneFiltered = debugCounts.zoneFiltered + 1
                end
            end
        end
        
        -- Type filter (check API subcategory, API category, then fallback to static type)
        if show and filters.type and filters.type ~= "All Types" then
            local matchesType = false
            -- Check API subcategory first (specific: Beds, Chairs, Tables, etc.)
            if item._apiSubcategory and item._apiSubcategory == filters.type then
                matchesType = true
            end
            -- Check API category (high-level: Furniture, Structural, etc.)
            if not matchesType and item._apiCategory and item._apiCategory == filters.type then
                matchesType = true
            end
            -- Fallback to static type
            if not matchesType and item.type and item.type == filters.type then
                matchesType = true
            end
            
            if not matchesType then
                show = false
                debugCounts.typeFiltered = debugCounts.typeFiltered + 1
            end
        end
        
        -- Category filter (supports multi-select)
        if show and filters.selectedCategories then
            -- Count how many categories are selected
            local hasSelections = false
            for _, _ in pairs(filters.selectedCategories) do
                hasSelections = true
                break
            end
            
            -- Only filter if there are specific selections
            if hasSelections then
                local matchesCategory = false
                
                -- Check each selected category
                for selectedCategory, _ in pairs(filters.selectedCategories) do
                    -- Check API category (high-level: Furniture, Structural, etc.)
                    if item._apiCategory and item._apiCategory == selectedCategory then
                        matchesCategory = true
                        break
                    end
                    -- Check API subcategory (specific: Beds, Chairs, Tables, etc.)
                    if item._apiSubcategory and item._apiSubcategory == selectedCategory then
                        matchesCategory = true
                        break
                    end
                    -- Fallback to static category
                    if item.category and item.category == selectedCategory then
                        matchesCategory = true
                        break
                    end
                end
                
                if not matchesCategory then
                    show = false
                    debugCounts.categoryFiltered = debugCounts.categoryFiltered + 1
                end
            end
        end
        
        -- Faction filter
        -- When a specific faction is selected (Alliance or Horde), also show Neutral items
        if show and filters.faction and filters.faction ~= "All Factions" then
            local itemFaction = item.faction or "Neutral"
            if itemFaction ~= filters.faction and itemFaction ~= "Neutral" then
                show = false
                debugCounts.factionFiltered = debugCounts.factionFiltered + 1
            end
        end
        
        -- Source filter (supports multi-select)
        if show and filters.selectedSources then
            -- Count how many sources are selected
            local hasSelections = false
            for _, _ in pairs(filters.selectedSources) do
                hasSelections = true
                break
            end
            
            -- Only filter if there are specific selections
            if hasSelections then
                local matchesSource = false
                
                -- Check each selected source
                for selectedSource, _ in pairs(filters.selectedSources) do
                    if selectedSource == "Wishlist" then
                        -- Check if item is in wishlist
                        local itemID = tonumber(item.itemID)
                        if itemID and HousingDB and HousingDB.wishlist and HousingDB.wishlist[itemID] then
                            matchesSource = true
                            break
                        end
                    elseif selectedSource == "Crafted" then
                        -- Check if item is a profession/crafted item using the stored flag
                        if item._isProfessionItem then
                            matchesSource = true
                            break
                        end
                    elseif selectedSource == "Reputation" or selectedSource == "Renown" then
                        -- Reputation/renown items may still have _sourceType "Vendor" but be gated by faction standing
                        local itemID = tonumber(item.itemID)
                        local repInfo = itemID and HousingVendorItemToFaction and HousingVendorItemToFaction[itemID] or nil
                        if repInfo then
                            if selectedSource == "Renown" then
                                matchesSource = (repInfo.rep == "renown")
                            else
                                matchesSource = (repInfo.rep ~= "renown")
                            end
                        else
                            local itemSource = item._sourceType or "Vendor"
                            matchesSource = (itemSource == selectedSource)
                        end
                        if matchesSource then
                            break
                        end
                    else
                        -- Check if filter is a specific profession name (Cooking, Tailoring, etc.)
                        local isProfessionFilter = item._isProfessionItem and item.profession == selectedSource
                        
                        -- Check item's source type
                        local itemSource = item._sourceType or "Vendor"
                        
                        -- Show if either: exact source type match OR specific profession match
                        if itemSource == selectedSource or isProfessionFilter then
                            matchesSource = true
                            break
                        end
                    end
                end
                
                if not matchesSource then
                    show = false
                    debugCounts.sourceFiltered = debugCounts.sourceFiltered + 1
                end
            end
        end

        -- Collection filter (check quantity data first, then HousingCollectionAPI - same logic as item bar)
        if show and filters.collection and filters.collection ~= "All" then
            local isCollected = false

            -- First check: Do we have quantity data showing ownership? (owned = collected)
            local numStored = item._apiNumStored or 0
            local numPlaced = item._apiNumPlaced or 0
            local totalOwned = numStored + numPlaced

            if totalOwned > 0 then
                isCollected = true
            else
                -- Fallback: Check via HousingCollectionAPI (for items without quantity data yet)
                local itemID = tonumber(item.itemID)
                if itemID and HousingCollectionAPI then
                    isCollected = HousingCollectionAPI:IsItemCollected(itemID)
                end
            end

            -- For quest/achievement items, also check if they're complete
            -- If quest/achievement is complete, treat as "obtainable" (not outstanding)
            local isQuestComplete = false
            local isAchievementComplete = false
            local sourceType = item._sourceType or item.sourceType or "Vendor"

            if sourceType == "Quest" or sourceType == INTERNED_STRINGS["Quest"] then
                local questID = item._questId or item.questRequired
                if questID then
                    local numericQuestID = tonumber(questID)
                    -- If questID is text, try to extract numeric ID
                    if not numericQuestID and type(questID) == "string" then
                        numericQuestID = tonumber(string.match(questID, "%d+"))
                    end
                    if numericQuestID and C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted then
                        isQuestComplete = C_QuestLog.IsQuestFlaggedCompleted(numericQuestID)
                    end
                end
            elseif sourceType == "Achievement" or sourceType == INTERNED_STRINGS["Achievement"] then
                local achievementID = item._achievementId or item.achievementRequired
                if achievementID then
                    local numericAchievementID = tonumber(achievementID)
                    -- If achievementID is text, try to extract numeric ID
                    if not numericAchievementID and type(achievementID) == "string" then
                        numericAchievementID = tonumber(string.match(achievementID, "%d+"))
                    end
                    if numericAchievementID and C_AchievementInfo and C_AchievementInfo.GetAchievementInfo then
                        local achievementInfo = C_AchievementInfo.GetAchievementInfo(numericAchievementID)
                        if achievementInfo then
                            isAchievementComplete = achievementInfo.completed or false
                        end
                    end
                end
            end

            -- When filtering for "Uncollected":
            -- - Hide if item is collected
            -- - Hide if quest/achievement is complete (since it's obtainable, not truly outstanding)
            if filters.collection == "Uncollected" then
                if isCollected or isQuestComplete or isAchievementComplete then
                    show = false
                    debugCounts.collectionFiltered = debugCounts.collectionFiltered + 1
                end
            elseif filters.collection == "Collected" and not isCollected then
                show = false
                debugCounts.collectionFiltered = debugCounts.collectionFiltered + 1
            end
        end

        -- Quality filter (API data required - skip items without data instead of hiding)
        if show and filters.quality and filters.quality ~= "All Qualities" then
            local itemQuality = item._apiQuality
            if itemQuality then
                -- Map quality number to quality name
                local qualityNames = {
                    [0] = "Poor",
                    [1] = "Common",
                    [2] = "Uncommon",
                    [3] = "Rare",
                    [4] = "Epic",
                    [5] = "Legendary"
                }
                local qualityName = qualityNames[itemQuality]

                -- API data loaded - apply filter
                if qualityName ~= filters.quality then
                    show = false
                    debugCounts.qualityFiltered = debugCounts.qualityFiltered + 1
                end
            end
            -- Note: Items without API quality data are shown (not filtered out)
        end

        -- Requirement filter (check if item has any requirements)
        if show and filters.requirement and filters.requirement ~= "All Requirements" then
            local itemRequirement = "None"
            
            -- Check HousingVendorItemToFaction lookup for reputation/renown items
            if HousingVendorItemToFaction then
                local repInfo = HousingVendorItemToFaction[tonumber(item.itemID)]
                if repInfo then
                    if repInfo.rep == "renown" then
                        itemRequirement = "Renown"
                    else
                        -- Treat any faction-gated item as Reputation even if `rep` is missing/unknown
                        itemRequirement = "Reputation"
                    end
                end
            end
            
            -- Check other requirement types if not reputation/renown
            if itemRequirement == "None" then
                if item._apiAchievement and item._apiAchievement ~= "" then
                    itemRequirement = "Achievement"
                elseif item._sourceType == INTERNED_STRINGS["Quest"] then
                    itemRequirement = "Quest"
                elseif item.professionSkillNeeded and item.professionSkillNeeded > 0 then
                    itemRequirement = "Profession"
                elseif item._apiRequirementType and item._apiRequirementType ~= "None" then
                    itemRequirement = item._apiRequirementType
                -- Check for class requirement from vendor data
                elseif item.classRestriction and item.classRestriction ~= "" then
                    itemRequirement = "Class"
                end
            end
            
            if itemRequirement ~= filters.requirement then
                show = false
                debugCounts.requirementFiltered = debugCounts.requirementFiltered + 1
            end
        end

        -- Hide Visited Vendors filter
        if show and filters.hideVisited and HousingCompletionTracker then
            -- Check if this vendor has been visited
            if item.npcID and HousingCompletionTracker:IsVendorVisited(item.npcID) then
                show = false
                debugCounts.visitedFiltered = debugCounts.visitedFiltered + 1
            end
        end

        -- Hide Not Released items filter
        if show and filters.hideNotReleased then
            -- First check if it's in the NotReleased table (fast check)
            if item._fromNotReleased then
                show = false
                debugCounts.notReleasedFiltered = (debugCounts.notReleasedFiltered or 0) + 1
            end
            -- Note: We rely on the NotReleased table for now
            -- GetItemInfo() is unreliable for detecting unreleased items as it may return nil
            -- for items that simply aren't cached yet, not just unreleased items
        end

        -- Show Only Available Items filter (API-verified items only)
        if show and filters.showOnlyAvailable then
            local itemID = item.itemID and tonumber(item.itemID) or nil
            if itemID then
                if not IsItemAvailableByID(itemID) then
                    show = false
                    debugCounts.availabilityFiltered = (debugCounts.availabilityFiltered or 0) + 1
                end
            else
                show = false
                debugCounts.availabilityFiltered = (debugCounts.availabilityFiltered or 0) + 1
            end
        end

        -- Hide items with no valid data (question mark icons or missing tooltip info)
        if show then
            local itemID = item.itemID and tonumber(item.itemID) or nil
            
            -- Hide items with no itemID
            if not itemID or itemID == 0 then
                show = false
            else
                -- Check if icon cache explicitly has a question mark (definitely no data)
                local hasQuestionMark = false
                do
                    local cacheKey = tostring(itemID)
                    local cachedIcon = nil
                    if HousingIcons and HousingIcons.GetCachedIcon then
                        cachedIcon = HousingIcons:GetCachedIcon(itemID)
                    elseif HousingDB and HousingDB.iconCache then
                        cachedIcon = HousingDB.iconCache[cacheKey]
                    end
                    if cachedIcon and (
                        cachedIcon == "Interface\\Icons\\INV_Misc_QuestionMark" or
                        string.find(cachedIcon, "INV_Misc_QuestionMark")
                    ) then
                        hasQuestionMark = true
                    end
                end
                
                -- Check if we can get item info (tooltip data available)
                local hasTooltipData = false
                if C_Item and C_Item.GetItemInfo then
                    local itemInfo = C_Item.GetItemInfo(itemID)
                    if itemInfo and itemInfo.iconFileID and itemInfo.iconFileID > 0 then
                        hasTooltipData = true
                    end
                end
                
                -- If we have API data loaded, assume item has valid data (even if icon not loaded yet)
                if item._apiDataLoaded then
                    hasTooltipData = true
                end
                
                -- Hide item if it has a question mark icon in cache AND no tooltip data
                if hasQuestionMark and not hasTooltipData then
                    show = false
                end
            end
        end

        if show then
            table.insert(filtered, item)
        end
    end

    -- Silently return filtered results
    -- Debug output removed to reduce chat spam

    -- Cache results
    state.filteredResultsCache = filtered
    state.lastFilterHash = filterHash

    return filtered
end
