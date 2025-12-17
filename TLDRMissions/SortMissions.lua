local addonName, addon = ...

local function sortByDuration(a, b)
    if a.missionScalar == b.missionScalar then
        return a.missionID < b.missionID
    end
    return a.missionScalar < b.missionScalar
end

local function sortByResourceCost(a, b)
    if a.cost == b.cost then
        return a.missionID < b.missionID
    end
    return a.cost < b.cost
end

local function sortByXP(a, b)
    if a.xp == b.xp then
        return a.missionID < b.missionID
    end
    return a.xp > b.xp
end

function addon.BaseGUIMixin:UsesLethalTroopPriority()
    return self.db.profile.useLethalMissionPriority
end

-- from https://wago.tools/db2/GarrAbility?filter%5BName_lang%5D=lethal&page=1
local lethalAbilityIDs = {
    [437] = true,
    [1080] = true,
}

local function isLethalMission(mission)
    local missionDeploymentInfo = C_Garrison.GetMissionDeploymentInfo(mission.missionID)
    if missionDeploymentInfo.enemies then
        for _, enemy in pairs(missionDeploymentInfo.enemies) do
            if enemy.mechanics then
                for _, mechanic in pairs(enemy.mechanics) do
                    if mechanic.ability then
                        if mechanic.ability.id then
                            if lethalAbilityIDs[mechanic.ability.id] then
                                return true
                            end
                        end
                    end
                end
            end
        end
    end
end

function addon.BaseGUIMixin:SortMissions(missions)
    local priorityMissions = {}
    local regularMissions = missions
    if self:UsesLethalTroopPriority() then
        regularMissions = {}
        for _, mission in pairs(missions) do
            if isLethalMission(mission) then
                table.insert(priorityMissions, mission)
            else
                table.insert(regularMissions, mission)
            end
        end
    end
    
    local sort_func = sortByDuration
    if self.db.profile.sortType == addon.Enums.sortType.resourceCost then
        sort_func = sortByResourceCost
    elseif self.db.profile.sortType == addon.Enums.sortType.xp then
        sort_func = sortByXP
    end
    
    table.sort(priorityMissions, sort_func)
    table.sort(regularMissions, sort_func)
    
    for _, mission in ipairs(regularMissions) do
        table.insert(priorityMissions, mission)
    end
    
    return priorityMissions
end