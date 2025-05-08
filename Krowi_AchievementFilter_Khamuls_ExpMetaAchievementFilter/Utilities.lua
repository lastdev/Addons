local addonName, addon = ...;

addon.Achievements = addon.Achievements or {}

-- Setup some vars
addon.L = LibStub("AceLocale-3.0"):GetLocale(addonName);

function GetAchievementName(achievementID, prefix) 
    --print(achievementID)
    if not prefix then
        prefix = ""
    end

    local name = select(2, GetAchievementInfo(achievementID)) or addon.L["Unknown Achievement"]
    
    if name == addon.L["Unknown Achievement"] then
        -- try to get the achievementname from locale
        local achievementLocaleKey = "ACM_" .. achievementID

        if addon.L[achievementLocaleKey] then
            name = addon.L[achievementLocaleKey]
        else
            name = name .. ": (" .. achievementID .. ")"
        end
    end
    
    return prefix .. name
end

function IsAchievementCompleted(achievementId) 
    local _, _, _, completed, _, _, _, _, _, _, _, _, _, earnedBy = GetAchievementInfo(achievementId)

    return completed
end

function ShowOnlyCompletedAchievementsWhenRequirementsAreMet(achLimit, achievementsTable)
    local completed = {}

    for i,v in ipairs(achievementsTable) do 
        if IsAchievementCompleted(v) then 
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
function AchievementShowDecider(achievementIdOne, achievementIdTwo, factionAchievements, decisionType)
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
    local completedOne = IsAchievementCompleted(achievementIdOne)
    local factionOne = GetFactionForAchievementId(factionAchievements, achievementIdOne)
    local completedTwo = IsAchievementCompleted(achievementIdTwo)
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