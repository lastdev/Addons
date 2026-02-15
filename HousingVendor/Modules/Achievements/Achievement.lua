-- HousingVendor Achievement Handler Module
-- Tracks housing-related achievements and their completion status

local AchievementHandler = {}
AchievementHandler.__index = AchievementHandler

-- Module state
local achievementCache = {}       -- Runtime cache: achievementID -> achievement data
local achievementIDList = {}      -- List of all housing achievement IDs
local isInitialized = false
local scanInProgress = false

------------------------------------------------------------
-- Achievement Data Structure
------------------------------------------------------------
--[[
Achievement data:
{
    id = number,
    name = string,
    description = string,
    icon = number,
    points = number,
    completed = boolean,
    completedDate = { month, day, year } or nil,
    numCriteria = number,
    numCompleted = number,
    criteria = {
        [index] = {
            text = string,
            completed = boolean,
            quantity = number,
            reqQuantity = number,
        }
    },
    expansion = string,
    itemID = number,  -- Associated housing item
    categoryID = number,  -- Achievement category ID (for organization)
    rewardItemID = number,  -- Item rewarded by completing achievement
    supercedingAchievements = table,  -- Next achievements in series/chain
    isGuild = boolean,  -- Whether this is a guild achievement
    lastUpdated = number,
}
]]

------------------------------------------------------------
-- Helper: Extract achievement IDs from data
------------------------------------------------------------

local function LoadAchievementIDsFromData()
    if not HousingExpansionData then
        return 0
    end

    local achievementMap = {}
    local count = 0

    for itemID, data in pairs(HousingExpansionData) do
        -- Check if this item has achievement data
        -- NOTE: achievement data is stored as an ARRAY (multiple achievements can reward same item)
        if data.achievement and type(data.achievement) == "table" then
            -- Handle both array and single object formats for compatibility
            local achList = data.achievement

            -- If it's a single achievement object (has achievementId field), wrap it in array
            if achList.achievementId or achList.id then
                achList = {achList}
            end

            -- Process all achievements for this item
            for _, achData in ipairs(achList) do
                local achID = achData.achievementId or achData.id

                if achID and achID > 0 then
                    if not achievementMap[achID] then
                        achievementMap[achID] = {
                            expansion = achData.expansion or data.expansion or "Unknown",
                            itemID = tonumber(itemID),
                            title = achData.title or data.title,
                        }
                        count = count + 1
                    end
                end
            end
        end
    end

    -- Convert to list
    achievementIDList = {}
    for achID, info in pairs(achievementMap) do
        table.insert(achievementIDList, {
            id = achID,
            expansion = info.expansion,
            itemID = info.itemID,
            title = info.title,
        })
    end

    return count
end

------------------------------------------------------------
-- Helper: Fetch achievement data from WoW API
------------------------------------------------------------

local function FetchAchievementData(achievementID)
    if not achievementID or achievementID == 0 then
        return nil
    end

    -- Validate achievement ID first
    if C_AchievementInfo and C_AchievementInfo.IsValidAchievement then
        if not C_AchievementInfo.IsValidAchievement(achievementID) then
            return nil
        end
    end

    -- Use modern C_AchievementInfo API with fallback to legacy
    local id, name, points, completed, month, day, year, description, flags, icon, rewardText, isGuild, wasEarnedByMe, earnedBy

    if C_AchievementInfo and C_AchievementInfo.GetAchievementInfo then
        -- Modern API (WoW 10.0+)
        local success, achInfo = pcall(C_AchievementInfo.GetAchievementInfo, achievementID)
        if success and achInfo then
            id = achievementID
            name = achInfo.name
            points = achInfo.points
            completed = achInfo.completed
            description = achInfo.description
            flags = achInfo.flags
            icon = achInfo.icon
            rewardText = achInfo.rewardText or nil
            isGuild = achInfo.isGuild or false
            wasEarnedByMe = achInfo.wasEarnedByMe or false
            earnedBy = achInfo.earnedBy or nil

            if completed and achInfo.completionDate then
                month = achInfo.completionDate.month
                day = achInfo.completionDate.day
                year = achInfo.completionDate.year
            end
        end
    end

    -- Fallback to legacy API
    if not id then
        local success
        success, id, name, points, completed, month, day, year, description, flags, icon, rewardText, isGuild, wasEarnedByMe, earnedBy = pcall(function()
            return GetAchievementInfo(achievementID)
        end)

        if not success or not id then
            return nil
        end
    end

    local data = {
        id = id,
        name = name,
        description = description,
        icon = icon,
        points = points,
        completed = completed,
        completedDate = (completed and month and day and year) and { month = month, day = day, year = year } or nil,
        rewardText = rewardText,
        isGuild = isGuild,
        wasEarnedByMe = wasEarnedByMe,
        earnedBy = earnedBy,
        flags = flags,
        lastUpdated = GetTime(),
    }

    -- Get achievement category (for organization)
    if GetAchievementCategory then
        local categoryID = GetAchievementCategory(achievementID)
        if categoryID then
            data.categoryID = categoryID
        end
    end

    -- Get reward item ID if available (NEW API)
    if C_AchievementInfo and C_AchievementInfo.GetRewardItemID then
        local rewardItemID = C_AchievementInfo.GetRewardItemID(achievementID)
        if rewardItemID and rewardItemID > 0 then
            data.rewardItemID = rewardItemID
        end
    end

    -- Get superceding achievements (achievement chain/series)
    if C_AchievementInfo and C_AchievementInfo.GetSupercedingAchievements then
        local superceding = C_AchievementInfo.GetSupercedingAchievements(achievementID)
        if superceding and #superceding > 0 then
            data.supercedingAchievements = superceding
        end
    end

    -- Check if this is a guild achievement
    if C_AchievementInfo and C_AchievementInfo.IsGuildAchievement then
        data.isGuild = C_AchievementInfo.IsGuildAchievement(achievementID)
    end

    -- Get criteria data
    local numCriteria = GetAchievementNumCriteria(achievementID)
    data.numCriteria = numCriteria
    data.numCompleted = 0
    data.criteria = {}

    for i = 1, numCriteria do
        local criteriaString, criteriaType, criteriaCompleted, quantity, reqQuantity, _, flags, assetID, quantityString = GetAchievementCriteriaInfo(achievementID, i)

        if criteriaString then
            data.criteria[i] = {
                text = criteriaString,
                type = criteriaType,
                completed = criteriaCompleted,
                quantity = quantity,
                reqQuantity = reqQuantity,
                assetID = assetID,
            }

            if criteriaCompleted then
                data.numCompleted = data.numCompleted + 1
            end
        end
    end

    return data
end

------------------------------------------------------------
-- Public API: Initialize module
------------------------------------------------------------

function AchievementHandler:Initialize()
    if isInitialized then
        return
    end

    -- Load achievement IDs from data
    local count = LoadAchievementIDsFromData()

    -- Initialize SavedVariables
    if not HousingDB then
        HousingDB = {}
    end
    if not HousingDB.achievementCache then
        HousingDB.achievementCache = {
            achievements = {},
            lastScan = nil,
        }
    end

    -- Load cached data into memory
    for achID, data in pairs(HousingDB.achievementCache.achievements or {}) do
        achievementCache[tonumber(achID)] = data
    end

    -- Register events
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("ACHIEVEMENT_EARNED")
    frame:RegisterEvent("CRITERIA_UPDATE")
    frame:SetScript("OnEvent", function(self, event, ...)
        if event == "ACHIEVEMENT_EARNED" then
            local achID = ...
            if achID then
                AchievementHandler:UpdateAchievement(achID)
            end
        elseif event == "CRITERIA_UPDATE" then
            -- Criteria updated, schedule a delayed refresh
            C_Timer.After(1, function()
                AchievementHandler:RefreshAllAchievements()
            end)
        end
    end)

    isInitialized = true
end

------------------------------------------------------------
-- Public API: Scan all housing achievements
------------------------------------------------------------

function AchievementHandler:ScanAllAchievements(callback, forceRescan)
    if scanInProgress then
        if callback then
            callback(false, "Scan already in progress")
        end
        return
    end

    -- CRITICAL: Ensure data is processed before scanning
    -- ProcessPendingData() populates HousingExpansionData from pending achievement data
    if HousingDataAggregator and HousingDataAggregator.ProcessPendingData then
        HousingDataAggregator:ProcessPendingData()
    end

    -- Reload achievement IDs if list is empty (data might not have been ready during Initialize)
    if not achievementIDList or #achievementIDList == 0 then
        local count = LoadAchievementIDsFromData()
        if count == 0 then
            if callback then
                callback(false, "No achievement data found. Make sure HousingExpansionData is loaded.")
            end
            return
        end
    end

    -- Check if we have recent cached data (unless forceRescan is true)
    if not forceRescan and HousingDB.achievementCache and HousingDB.achievementCache.lastScan then
        local cacheAge = time() - HousingDB.achievementCache.lastScan
        local maxCacheAge = 3600  -- 1 hour in seconds

        if cacheAge < maxCacheAge and next(HousingDB.achievementCache.achievements) ~= nil then
            -- Use cached data
            local cached = 0
            local completed = 0
            for achID, data in pairs(HousingDB.achievementCache.achievements) do
                cached = cached + 1
                if data.completed then
                    completed = completed + 1
                end
            end

            if callback then
                callback(true, nil, cached, completed)
            end
            return
        end
    end

    scanInProgress = true
    local scanned = 0
    local completed = 0

    -- Process in batches
    local batchSize = 10
    local currentBatch = 1

    local function ProcessBatch()
        local startIdx = (currentBatch - 1) * batchSize + 1
        local endIdx = math.min(startIdx + batchSize - 1, #achievementIDList)

        if startIdx > #achievementIDList then
            -- Scan complete
            scanInProgress = false
            HousingDB.achievementCache.lastScan = time()

            if callback then
                callback(true, nil, scanned, completed)
            end
            return
        end

        -- Process batch
        for i = startIdx, endIdx do
            local achInfo = achievementIDList[i]
            local data = FetchAchievementData(achInfo.id)

            if data then
                -- Add expansion and item info
                data.expansion = achInfo.expansion
                data.itemID = achInfo.itemID

                -- Cache it
                achievementCache[achInfo.id] = data
                HousingDB.achievementCache.achievements[tostring(achInfo.id)] = data

                scanned = scanned + 1
                if data.completed then
                    completed = completed + 1
                end
            end
        end

        -- Schedule next batch
        currentBatch = currentBatch + 1
        C_Timer.After(0.05, ProcessBatch)
    end

    -- Start processing
    ProcessBatch()
end

------------------------------------------------------------
-- Public API: Update single achievement
------------------------------------------------------------

function AchievementHandler:UpdateAchievement(achievementID)
    local data = FetchAchievementData(achievementID)

    if data then
        -- Find expansion and itemID
        for _, achInfo in ipairs(achievementIDList) do
            if achInfo.id == achievementID then
                data.expansion = achInfo.expansion
                data.itemID = achInfo.itemID
                break
            end
        end

        -- Cache it
        achievementCache[achievementID] = data
        HousingDB.achievementCache.achievements[tostring(achievementID)] = data
    end
end

------------------------------------------------------------
-- Public API: Refresh all cached achievements (fast update)
------------------------------------------------------------

function AchievementHandler:RefreshAllAchievements()
    for achID, _ in pairs(achievementCache) do
        self:UpdateAchievement(achID)
    end
end

------------------------------------------------------------
-- Public API: Get achievement data
------------------------------------------------------------

function AchievementHandler:GetAchievement(achievementID)
    return achievementCache[achievementID]
end

function AchievementHandler:GetAllAchievements()
    return achievementCache
end

function AchievementHandler:GetAchievementList()
    return achievementIDList
end

------------------------------------------------------------
-- Public API: Get statistics
------------------------------------------------------------

function AchievementHandler:GetStatistics()
    local total = #achievementIDList
    local completed = 0
    local byExpansion = {}

    for achID, data in pairs(achievementCache) do
        if data.completed then
            completed = completed + 1
        end

        local exp = data.expansion or "Unknown"
        if not byExpansion[exp] then
            byExpansion[exp] = { total = 0, completed = 0 }
        end
        byExpansion[exp].total = byExpansion[exp].total + 1
        if data.completed then
            byExpansion[exp].completed = byExpansion[exp].completed + 1
        end
    end

    return {
        total = total,
        completed = completed,
        byExpansion = byExpansion,
    }
end

------------------------------------------------------------
-- Public API: Check if achievement is completed
------------------------------------------------------------

function AchievementHandler:IsCompleted(achievementID)
    local data = achievementCache[achievementID]
    return data and data.completed or false
end

------------------------------------------------------------
-- Make globally accessible
------------------------------------------------------------

_G["HousingAchievementHandler"] = AchievementHandler

return AchievementHandler
