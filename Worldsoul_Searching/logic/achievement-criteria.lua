AchievementCriteria = {}
AchievementCriteria.__index = AchievementCriteria

AchievementCriteriaTypes = {
    AnotherAchievement = 8,
    CompletingAQuest = 27
}

function AchievementCriteria:new(achievementId, entry, achievementRequirement)
    local criteriaString = GetAchievementCriteriaInfoByID(achievementId, entry.id)

    local obj = setmetatable({}, AchievementCriteria)

    obj.achievementId = achievementId
    obj.id = entry.id
    obj.criteriaType = entry.type or AchievementCriteriaTypes.CompletingAQuest
    obj.requirements = nil

    if entry.requirements then
        obj.requirements = AchievementRequirement:new(entry.requirements)
    end

    if not entry.requirements then
        entry.requirements = achievementRequirement or nil
    end

    local waypoints = {}

    if entry.waypoint then
        waypoints[#waypoints+1] = Waypoint:new(entry.waypoint, criteriaString)
    end

    if entry.waypoints and #entry.waypoints > 0 then
        for _, wp in pairs(entry.waypoints) do
            waypoints[#waypoints+1] = Waypoint:new(wp, criteriaString)
        end
    end

    obj.waypoints = waypoints

    return obj
end

function AchievementCriteria:GetWaypoints()
    return self.waypoints
end

function AchievementCriteria:GetFilteredWaypoints()
    if MetaAchievementConfigurationDB.addWpsOnlyForUncompletedAchis then
        local numCriteria = GetAchievementNumCriteria(self.achievementId)

        for i = 1, numCriteria do
            local criteriaString, criteriaType, completed, quantity, reqQuantity, charName, flags, assetID, quantityString, criteriaID, eligible = GetAchievementCriteriaInfo(self.achievementId, i)

            if self.id == criteriaID and not completed then
                return self.waypoints
            end
        end

        return nil
    else
        -- no filtering in this case
        return self.waypoints
    end
end
