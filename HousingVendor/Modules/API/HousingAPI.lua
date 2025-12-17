-- Housing API Integration
-- Centralized API wrapper for all housing-related API calls
local HousingAPI = {}
HousingAPI.__index = HousingAPI

-- Check if housing APIs are available
function HousingAPI:IsAvailable()
    return C_HousingCatalog ~= nil
end

-- Check if C_Housing API is available
function HousingAPI:IsHousingAvailable()
    return C_Housing ~= nil
end

-- Get the current data mode (static, hybrid, or live)
function HousingAPI:GetDataMode()
    if self:IsAvailable() then
        return "hybrid"  -- Static data enhanced with live data
    else
        return "static"  -- Static data only
    end
end

------------------------------------------------------------
-- HELPER FUNCTIONS FOR TEXT PARSING
------------------------------------------------------------

-- Helper to strip WoW formatting (but preserve icons for cost)
local function CleanText(text, preserveIcons)
    if not text then return nil end
    text = text:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
    text = text:gsub("|H[^|]*|h", ""):gsub("|h", "")
    if not preserveIcons then
        text = text:gsub("|T[^|]*|t", "")  -- Strip icons unless preserving
    end
    text = text:gsub("|n", " ")
    text = text:match("^%s*(.-)%s*$")
    return text
end

-- Extract field value from sourceText
local function ExtractFieldValue(sourceText, fieldName)
    -- Find the field pattern: "FieldName: value" (case-insensitive)
    local startPattern = fieldName .. ":"
    local startPos = sourceText:find(startPattern, 1, true)  -- plain search, case-sensitive
    if not startPos then 
        -- Try case-insensitive
        startPos = sourceText:lower():find(fieldName:lower() .. ":", 1, true)
        if startPos then
            -- Find the actual position in original string
            local lowerText = sourceText:lower()
            local lowerPattern = fieldName:lower() .. ":"
            startPos = lowerText:find(lowerPattern, 1, true)
        end
    end
    if not startPos then return nil end
    
    -- Skip past the field name and colon, find where value starts
    local valueStart = startPos + #startPattern
    -- Skip any whitespace after colon
    valueStart = sourceText:find("%S", valueStart) or valueStart
    
    -- Find the next field name (or end of line/string)
    local nextFieldPos = nil
    local allFields = {"Cost", "Zone", "Vendor", "Category", "Achievement", "Quest", "Renown", "Profession", "Reputation", "Event", "Class", "Race"}
    
    for _, nextField in ipairs(allFields) do
        if nextField ~= fieldName then
            -- Look for next field name with various patterns
            local patterns = {
                " " .. nextField .. ":",  -- Space before field
                "\n" .. nextField .. ":", -- Newline before field
                "\r" .. nextField .. ":", -- Carriage return before field
                "\t" .. nextField .. ":", -- Tab before field
                nextField .. ":"          -- Field directly (no space)
            }
            for _, pattern in ipairs(patterns) do
                local pos = sourceText:find(pattern, valueStart, true)  -- plain search
                if pos and (not nextFieldPos or pos < nextFieldPos) then
                    nextFieldPos = pos
                    break
                end
            end
        end
    end
    
    -- Also check for newline/carriage return
    local newlinePos = sourceText:find("[\r\n]", valueStart)
    if newlinePos and (not nextFieldPos or newlinePos < nextFieldPos) then
        nextFieldPos = newlinePos
    end
    
    -- Extract the value (stop before next field or at end)
    local valueEnd = nextFieldPos or (#sourceText + 1)
    local value = sourceText:sub(valueStart, valueEnd - 1)
    
    -- Trim whitespace
    value = value:match("^%s*(.-)%s*$")
    
    -- If value is empty or just whitespace, return nil
    if not value or value == "" then
        return nil
    end
    
    return value
end

------------------------------------------------------------
-- CATALOG API FUNCTIONS
------------------------------------------------------------

-- Get full catalog data for an item (includes parsing sourceText)
function HousingAPI:GetCatalogData(itemID)
    local result = {}
    local id = tonumber(itemID)
    if not id or not self:IsAvailable() then return result end

    -- Step 1: GetCatalogEntryInfoByItem
    local ok, entryInfo = pcall(C_HousingCatalog.GetCatalogEntryInfoByItem, id, true)
    if not ok or not entryInfo or not entryInfo.entryID then
        return result
    end

    local entryID = entryInfo.entryID
    if type(entryID) ~= "table" or not entryID.recordID or not entryID.entryType then
        return result
    end

    local recordID = entryID.recordID
    local entryType = entryID.entryType

    -- Step 2: GetCatalogEntryInfoByRecordID
    local ok2, fullEntry = pcall(C_HousingCatalog.GetCatalogEntryInfoByRecordID, entryType, recordID, true)
    if not ok2 or not fullEntry then
        return result
    end

    -- Extract basic data
    result.name = fullEntry.name
    result.iconTexture = fullEntry.iconTexture
    result.quality = fullEntry.quality
    result.sourceText = fullEntry.sourceText
    result.asset = fullEntry.asset
    result.uiModelSceneID = fullEntry.uiModelSceneID  -- For 3D preview
    result.numPlaced = fullEntry.numPlaced
    result.numStored = fullEntry.numStored
    result.quantity = fullEntry.quantity
    
    -- Extract filter tags if available (for expansion, theme, style, etc.)
    if fullEntry.filterTagIDs then
        result.filterTagIDs = fullEntry.filterTagIDs
    end
    if fullEntry.filterTags then
        result.filterTags = fullEntry.filterTags
    end

    -- Get category names
    if fullEntry.categoryIDs and #fullEntry.categoryIDs > 0 then
        result.categoryNames = {}
        for _, catID in ipairs(fullEntry.categoryIDs) do
            local ok3, catInfo = pcall(C_HousingCatalog.GetCatalogCategoryInfo, catID)
            if ok3 and catInfo and catInfo.name then
                table.insert(result.categoryNames, catInfo.name)
            end
        end
    end

    -- Get subcategory names
    if fullEntry.subcategoryIDs and #fullEntry.subcategoryIDs > 0 then
        result.subcategoryNames = {}
        for _, subcatID in ipairs(fullEntry.subcategoryIDs) do
            local ok3, subcatInfo = pcall(C_HousingCatalog.GetCatalogSubcategoryInfo, subcatID)
            if ok3 and subcatInfo and subcatInfo.name then
                table.insert(result.subcategoryNames, subcatInfo.name)
            end
        end
    end

    -- Parse sourceText for vendor, zone, cost, achievement, etc.
    if fullEntry.sourceText then
        local sourceText = fullEntry.sourceText
        
        local vendor = ExtractFieldValue(sourceText, "Vendor")
        if vendor then
            vendor = CleanText(vendor)
            if vendor and vendor ~= "" then
                result.vendor = vendor
            end
        end

        local zone = ExtractFieldValue(sourceText, "Zone")
        if zone then
            zone = CleanText(zone)
            if zone and zone ~= "" then
                result.zone = zone
            end
        end

        local cost = ExtractFieldValue(sourceText, "Cost")
        if cost then
            -- Store raw cost before cleaning (for tooltip)
            result.costRaw = cost
            -- Preserve icons for cost (gold/currency icons)
            cost = CleanText(cost, true)  -- preserveIcons = true
            if cost and cost ~= "" then
                result.cost = cost
            end
        end

        local achievement = ExtractFieldValue(sourceText, "Achievement")
        if achievement then
            -- Extract achievement ID from hyperlink before cleaning
            local achievementID = achievement:match("|Hachievement:(%d+)")
            if achievementID then
                result.achievementID = tonumber(achievementID)
            end
            
            achievement = CleanText(achievement)
            if achievement and achievement ~= "" then
                result.achievement = achievement
            end
        end

        -- Extract additional unlock requirements from sourceText (as fallback)
        local quest = ExtractFieldValue(sourceText, "Quest")
        if quest then
            -- Extract quest ID from hyperlink before cleaning
            local questID = quest:match("|Hquest:(%d+)")
            if questID then
                result.questID = tonumber(questID)
            end
            
            quest = CleanText(quest)
            if quest and quest ~= "" then
                result.quest = quest
            end
        end

        local renown = ExtractFieldValue(sourceText, "Renown")
        if renown then
            renown = CleanText(renown)
            if renown and renown ~= "" then
                result.renown = renown
            end
        end

        local profession = ExtractFieldValue(sourceText, "Profession")
        if profession then
            profession = CleanText(profession)
            if profession and profession ~= "" then
                result.profession = profession
            end
        end

        local reputation = ExtractFieldValue(sourceText, "Reputation")
        if reputation then
            reputation = CleanText(reputation)
            if reputation and reputation ~= "" then
                result.reputation = reputation
            end
        end

        local event = ExtractFieldValue(sourceText, "Event")
        if event then
            event = CleanText(event)
            if event and event ~= "" then
                result.event = event
            end
        end

        local class = ExtractFieldValue(sourceText, "Class")
        if class then
            class = CleanText(class)
            if class and class ~= "" then
                result.class = class
            end
        end

        local race = ExtractFieldValue(sourceText, "Race")
        if race then
            race = CleanText(race)
            if race and race ~= "" then
                result.race = race
            end
        end
    end

    return result
end

-- Get catalog entry info by item ID (simple wrapper)
function HousingAPI:GetCatalogEntryInfoByItem(itemID)
    if not self:IsAvailable() then return nil end
    local id = tonumber(itemID)
    if not id then return nil end
    
    local ok, entryInfo = pcall(C_HousingCatalog.GetCatalogEntryInfoByItem, id, true)
    if ok and entryInfo then
        return entryInfo
    end
    return nil
end

-- Get catalog entry info by record ID
function HousingAPI:GetCatalogEntryInfoByRecordID(entryType, recordID)
    if not self:IsAvailable() then return nil end
    
    local ok, fullEntry = pcall(C_HousingCatalog.GetCatalogEntryInfoByRecordID, entryType, recordID, true)
    if ok and fullEntry then
        return fullEntry
    end
    return nil
end

-- Get catalog category info
function HousingAPI:GetCatalogCategoryInfo(categoryID)
    if not self:IsAvailable() then return nil end
    
    local ok, catInfo = pcall(C_HousingCatalog.GetCatalogCategoryInfo, categoryID)
    if ok and catInfo then
        return catInfo
    end
    return nil
end

-- Pre-built expansion tag lookup table (tagID -> expansion name)
local expansionTagLookup = nil
local expansionTagLookupTimestamp = 0
local EXPANSION_LOOKUP_TTL = 3600  -- 1 hour cache

-- Build expansion tag lookup table (O(1) lookup instead of O(groups * tags))
local function BuildExpansionTagLookup()
    local currentTime = GetTime()

    -- Return cached lookup if still valid
    if expansionTagLookup and (currentTime - expansionTagLookupTimestamp) < EXPANSION_LOOKUP_TTL then
        return expansionTagLookup
    end

    -- Build new lookup table
    local lookup = {}

    -- Get tag groups from HousingAPICache if available
    local tagGroups = nil
    if HousingAPICache then
        tagGroups = HousingAPICache:GetFilterTagGroups()
    else
        local ok, groups = pcall(C_HousingCatalog.GetAllFilterTagGroups)
        if ok and groups then
            tagGroups = groups
        end
    end

    if not tagGroups then
        return nil
    end

    -- Find Expansion group and build lookup
    for _, group in ipairs(tagGroups) do
        if group and group.name and string.lower(group.name) == "expansion" then
            -- Handle different API response structures
            if group.tags then
                -- Structure 1: tags is a table of {tagID -> {name = "...", ...}}
                for tagID, tagData in pairs(group.tags) do
                    if tagData and tagData.name then
                        lookup[tagID] = tagData.name
                    end
                end
            elseif group.tagIDs and group.tagNames then
                -- Structure 2: separate arrays of tagIDs and tagNames
                for i, tagID in ipairs(group.tagIDs) do
                    if group.tagNames[i] then
                        lookup[tagID] = group.tagNames[i]
                    elseif group.tagNames[tagID] then
                        lookup[tagID] = group.tagNames[tagID]
                    end
                end
            end
            break
        end
    end

    -- Cache the lookup table
    expansionTagLookup = lookup
    expansionTagLookupTimestamp = currentTime

    return lookup
end

-- Get expansion from filter tags (if available from API) - OPTIMIZED VERSION
function HousingAPI:GetExpansionFromFilterTags(itemID)
    if not self:IsAvailable() then return nil end

    -- Build/get expansion tag lookup table (cached for 1 hour)
    local lookup = BuildExpansionTagLookup()
    if not lookup then
        return nil
    end

    local id = tonumber(itemID)
    if not id then return nil end

    -- Get catalog entry (cached by HousingAPICache if available)
    local ok, entryInfo = pcall(C_HousingCatalog.GetCatalogEntryInfoByItem, id, true)
    if not ok or not entryInfo or not entryInfo.entryID then
        return nil
    end

    local entryID = entryInfo.entryID
    if type(entryID) ~= "table" or not entryID.recordID or not entryID.entryType then
        return nil
    end

    local ok2, fullEntry = pcall(C_HousingCatalog.GetCatalogEntryInfoByRecordID, entryID.entryType, entryID.recordID, true)
    if not ok2 or not fullEntry or not fullEntry.filterTagIDs then
        return nil
    end

    -- O(1) lookup: check each filterTagID against pre-built expansion lookup
    for _, tagID in ipairs(fullEntry.filterTagIDs) do
        if lookup[tagID] then
            return lookup[tagID]
        end
    end

    return nil
end

-- Get catalog subcategory info
function HousingAPI:GetCatalogSubcategoryInfo(subcategoryID)
    if not self:IsAvailable() then return nil end
    
    local ok, subcatInfo = pcall(C_HousingCatalog.GetCatalogSubcategoryInfo, subcategoryID)
    if ok and subcatInfo then
        return subcatInfo
    end
    return nil
end

-- Create catalog searcher (for caching)
function HousingAPI:CreateCatalogSearcher()
    if not self:IsAvailable() then return false end
    
    local ok = pcall(C_HousingCatalog.CreateCatalogSearcher)
    return ok
end

------------------------------------------------------------
-- DECOR API FUNCTIONS (C_Housing)
------------------------------------------------------------

-- Get decor item info from item ID
function HousingAPI:GetDecorItemInfoFromItemID(itemID)
    if not self:IsHousingAvailable() then return nil end
    local id = tonumber(itemID)
    if not id then return nil end
    
    local ok, baseInfo = pcall(C_Housing.GetDecorItemInfoFromItemID, id)
    if ok and baseInfo then
        return baseInfo
    end
    return nil
end

-- Get decor vendor info
function HousingAPI:GetDecorVendorInfo(decorID)
    if not self:IsHousingAvailable() or not C_Housing.GetDecorVendorInfo then return nil end
    if not decorID then return nil end
    
    local ok, vendorInfo = pcall(C_Housing.GetDecorVendorInfo, decorID)
    if ok and vendorInfo then
        return vendorInfo
    end
    return nil
end

-- Get decor unlock requirements
function HousingAPI:GetDecorUnlockRequirements(decorID)
    if not self:IsHousingAvailable() or not C_Housing.GetDecorUnlockRequirements then return nil end
    if not decorID then return nil end
    
    local ok, unlockInfo = pcall(C_Housing.GetDecorUnlockRequirements, decorID)
    if ok and unlockInfo then
        -- Check if unlockInfo is actually empty (all fields nil)
        local hasData = false
        if unlockInfo.achievementID or unlockInfo.questID or unlockInfo.renownLevel or 
           unlockInfo.professionLevel or unlockInfo.reputationFactionID or unlockInfo.reputationLevel or
           unlockInfo.eventRequirement or unlockInfo.classRequirement or unlockInfo.raceRequirement then
            hasData = true
        end
        
        -- Return nil if it's an empty table (no requirements)
        if not hasData then
            return nil
        end
        
        return unlockInfo
    end
    return nil
end

-- Check if decor is collected
function HousingAPI:IsDecorCollected(decorID)
    if not self:IsHousingAvailable() or not C_Housing.IsDecorCollected then return nil end
    if not decorID then return nil end
    
    local ok, isCollected = pcall(C_Housing.IsDecorCollected, decorID)
    if ok and isCollected ~= nil then
        return isCollected
    end
    return nil
end

-- Check if decor is favorited
function HousingAPI:IsDecorFavorited(decorID)
    if not self:IsHousingAvailable() or not C_Housing.IsDecorFavorited then return nil end
    if not decorID then return nil end
    
    local ok, isFavorite = pcall(C_Housing.IsDecorFavorited, decorID)
    if ok and isFavorite ~= nil then
        return isFavorite
    end
    return nil
end

-- Set decor favorited status
function HousingAPI:SetDecorFavorited(decorID, favorited)
    if not self:IsHousingAvailable() or not decorID then return false end
    
    -- Try SetDecorFavorited first
    if C_Housing.SetDecorFavorited then
        local ok = pcall(C_Housing.SetDecorFavorited, decorID, favorited)
        if ok then return true end
    end
    
    -- Try ToggleDecorFavorite
    if C_Housing.ToggleDecorFavorite and not favorited then
        local currentState = self:IsDecorFavorited(decorID)
        if currentState == true then
            local ok = pcall(C_Housing.ToggleDecorFavorite, decorID)
            if ok then return true end
        end
    end
    
    -- Try SetFavorite
    if C_Housing.SetFavorite then
        local ok = pcall(C_Housing.SetFavorite, decorID, favorited)
        if ok then return true end
    end
    
    return false
end

-- Toggle decor favorite
function HousingAPI:ToggleDecorFavorite(decorID)
    if not self:IsHousingAvailable() or not decorID then return false end
    
    local currentState = self:IsDecorFavorited(decorID)
    if currentState == nil then return false end
    
    return self:SetDecorFavorited(decorID, not currentState)
end

------------------------------------------------------------
-- SUPPORTING API FUNCTIONS
------------------------------------------------------------

-- Get achievement info
function HousingAPI:GetAchievementInfo(achievementID)
    if not achievementID or not C_AchievementInfo or not C_AchievementInfo.GetAchievementInfo then return nil end
    
    local ok, achievementInfo = pcall(C_AchievementInfo.GetAchievementInfo, achievementID)
    if ok and achievementInfo then
        return achievementInfo
    end
    return nil
end

-- Get quest info
function HousingAPI:GetQuestInfo(questID)
    if not questID or not C_QuestLog or not C_QuestLog.GetQuestInfo then return nil end
    
    local ok, questInfo = pcall(C_QuestLog.GetQuestInfo, questID)
    if ok and questInfo then
        return questInfo
    end
    return nil
end

-- Get faction info by ID
function HousingAPI:GetFactionInfoByID(factionID)
    if not factionID or not C_Reputation or not C_Reputation.GetFactionInfoByID then return nil end
    
    local ok, factionInfo = pcall(C_Reputation.GetFactionInfoByID, factionID)
    if ok and factionInfo then
        return factionInfo
    end
    return nil
end

-- Get currency info
function HousingAPI:GetCurrencyInfo(currencyID)
    if not currencyID or not C_CurrencyInfo or not C_CurrencyInfo.GetCurrencyInfo then return nil end
    
    local ok, currencyInfo = pcall(C_CurrencyInfo.GetCurrencyInfo, currencyID)
    if ok and currencyInfo then
        return currencyInfo
    end
    return nil
end

------------------------------------------------------------
-- INITIALIZE
------------------------------------------------------------

-- Initialize the API module
function HousingAPI:Initialize()
    if self:IsAvailable() then
        -- Live API access available (silent)
        -- Initialize catalog searcher for caching
        self:CreateCatalogSearcher()
    else
        -- Live API not available (silent)
    end
end

-- Make globally accessible
_G["HousingAPI"] = HousingAPI

return HousingAPI
