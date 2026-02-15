local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)

local Utilities = KhamulsAchievementFilter:NewModule("Utilities")
local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function Utilities:GetAchievementName(achievementID, prefix) 
    --print(achievementID)
    if not prefix then
        prefix = ""
    end

    local name = select(2, GetAchievementInfo(achievementID)) or self.GetUnknownAchievementString()
    
    if name == self.GetUnknownAchievementString() then
        -- try to get the achievementname from locale
        local achievementLocaleKey = "ACM_" .. achievementID

        if L[achievementLocaleKey] then
            name = L[achievementLocaleKey]
        else
            name = name .. ": (" .. achievementID .. ")"
        end
    end
    
    return prefix .. name
end

function Utilities:IsAchievementCompleted(achievementId) 
    local _, _, _, completed, _, _, _, _, _, _, _, _, _, earnedBy = GetAchievementInfo(achievementId)

    return completed
end

function Utilities:ShowOnlyCompletedAchievementsWhenRequirementsAreMet(achLimit, achievementsTable)
    local completed = {}

    for i,v in ipairs(achievementsTable) do 
        if self:IsAchievementCompleted(v) then 
            table.insert(completed, v)
        end
    end

    if (#completed >= achLimit) then
        return completed
    end

    return achievementsTable
end

-- possible decisionTypes are:
--   currentFactionOnly: returns the achievementID for the current faction (Default)
--   completedThanFaction: returns the achievementID which is completed, if both are completed of not completed, the faction achievementID will be returned
function Utilities:AchievementShowDecider(achievementIdOne, achievementIdTwo, factionAchievements, decisionType)
    --print(achievementIdOne .. "/" .. achievementIdTwo)
    -- Default decision type to "currentFactionOnly" if nil
    decisionType = decisionType or "currentFactionOnly"

    local function GetFactionForAchievementId(table, id) 
        
        local function TableContainsValue(table, value) 
            for _, v in pairs(table) do 
                if v == value then
                    return true
                end
            end
            return false
        end
        -- check alliance first
        if TableContainsValue(table[1], id) then
            return "Alliance"
        end

        if TableContainsValue(table[2], id) then
            return "Horde"
        end

        --print("Missing ID in factionAchievementTable: " .. id)

        return nil
    end

    -- Get player faction
    local playerFaction = UnitFactionGroup("player") -- Returns "Horde" or "Alliance"

    -- Get details for both achievements
    local completedOne = self:IsAchievementCompleted(achievementIdOne)
    local factionOne = GetFactionForAchievementId(factionAchievements, achievementIdOne)
    local completedTwo = self:IsAchievementCompleted(achievementIdTwo)
    local factionTwo = GetFactionForAchievementId(factionAchievements, achievementIdTwo)

    --print("ACM_1: " .. achievementIdOne .. "/" .. tostring(completedOne) .. "/" .. factionOne)
    --print("ACM_2: " .. achievementIdTwo .. "/" .. tostring(completedTwo) .. "/" .. factionTwo)

    -- Decision logic
    if decisionType == "currentFactionOnly" then
        if factionOne == playerFaction then
            return achievementIdOne
        elseif factionTwo == playerFaction then
            return achievementIdTwo
        else
            return nil -- Neither achievement matches the current faction
        end
    elseif decisionType == "completedBeforeFaction" then
        if completedOne and not completedTwo then
            return achievementIdOne
        elseif completedTwo and not completedOne then
            return achievementIdTwo
        else
            -- Both have the same completion status; prioritize current faction
            if factionOne == playerFaction then
                return achievementIdOne
            elseif factionTwo == playerFaction then
                return achievementIdTwo
            else
                return nil -- Neither matches current faction; return nothing
            end
        end
    else
        error("Invalid decisionType: " .. tostring(decisionType))
    end
end

function Utilities:GetAchievementNameWithPrefix(achievementID, prefix) 
    --print(achievementID)
    if not prefix then
        prefix = ""
    end

    local name = self:GetAchievementName(achievementID)
    
    if name == self.GetUnknownAchievementString() then
        -- try to get the achievementname from locale
        local achievementLocaleKey = "ACM_" .. achievementID

        if L[achievementLocaleKey] then
            name = L[achievementLocaleKey]
        else
            name = name .. ": (" .. achievementID .. ")"
        end
    end
    
    return prefix .. name
end

function Utilities:ReplacePlaceholderInText(template, values) 
    return template:gsub("{(%d+)}", function(index)
        return values[tonumber(index)] or "{" .. index .. "}"
    end)
end

-- https://www.wowhead.com/guide/list-of-zone-map-id-number-for-navigation-in-wow-and-tomtom-19501
function Utilities:GetZoneNameByMapID(mapID)
    local map = C_Map.GetMapInfo(mapID)
    
    if map then
        return map.name
    end
    
    return QUEUED_STATUS_UNKNOWN
end

function Utilities:GetDungeonNameByLFGDungeonID(dungeonID)
  local name, typeID, subtypeID = GetLFGDungeonInfo(dungeonID)

  if name then
    return name
  end
  return QUEUED_STATUS_UNKNOWN
end

function Utilities:GetAchievementCategoryNameByCategoryID(categoryId)
  if type(categoryId) ~= "number" then
    return QUEUED_STATUS_UNKNOWN
  end

  local name = GetCategoryInfo(categoryId)
  return name
end

-- @param achievementID number
-- @return string|nil
function Utilities:GetAchievementRewardInfo(achievementID)
    if type(achievementID) ~= "number" then
        return nil
    end

    -- rewardText is the UI-accurate, localized reward string
    local _, _, _, _, _, _, _, _, _, _, rewardText = GetAchievementInfo(achievementID)

    return rewardText
end

function Utilities:GetExpansionNameById(expansionId)
    return expansionId and ("EXPANSION_NAME" .. tostring(expansionId));
end

function Utilities:GetUnknownAchievementString() 
    return _G.UNKNOWN .. " " .. _G.BATTLE_PET_SOURCE_6
end