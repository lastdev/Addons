Achievement = {}
Achievement.__index = Achievement

ACHIEVEMENT_DEFAULT_ICON = "Interface\\Icons\\INV_Misc_QuestionMark"
ACHIEVEMENT_DEFAULT_NAME = "Unknown Achievement"

local function loadCriteria(achievementId, criteriaList)
    local returnValue = {}

    for _, item in pairs(criteriaList) do
        returnValue[#returnValue+1] = AchievementCriteria:new(achievementId, item)
    end

    return returnValue
end

local function figureOutIfChildrenAreCompleted(achievementEntry)
    local _, _, _, completed, _, _, _, _, _, _ = GetAchievementInfo(achievementEntry.id)
    if not completed then
        return false
    end

    for _, achi in pairs(achievementEntry.children or {}) do
        if figureOutIfChildrenAreCompleted(achi) == false then
            return false
        end
    end

    return true
end

local function getAchievementWaypoints(achi)
    local returnValue = {}
    for _, item in pairs(achi.waypoints) do
        returnValue[#returnValue+1] = Waypoint:new(item)
    end

    return returnValue
end

function Achievement:new(achievementEntry, parentAchievementRequirements)
    local obj = setmetatable({}, Achievement)

    obj.id = achievementEntry.id

    local _, name, _, completed, _, _, _, _, _, icon = GetAchievementInfo(obj.id)

    obj.children = achievementEntry.children or {}
    obj.completed = completed
    obj.name = name or achievementEntry.name or ACHIEVEMENT_DEFAULT_NAME
    obj.icon = icon or achievementEntry.icon or ACHIEVEMENT_DEFAULT_ICON
    obj.chidrenCompleted = figureOutIfChildrenAreCompleted(achievementEntry)

    if achievementEntry.requirements then
        obj.requirements = AchievementRequirement:new(achievementEntry.requirements)
    end

    if not obj.requirements then
        obj.requirements = parentAchievementRequirements or nil
    end

    obj.criteria = loadCriteria(obj.id, achievementEntry.criteria or {})

    local waypoints = {}
    for _, wp in pairs(achievementEntry.waypoints or {}) do
        waypoints[#waypoints+1] = Waypoint:new(wp)
    end
    obj.waypoints = waypoints

    return obj
end

function Achievement:createFromId(id)
    return Achievement:new({ id = id })
end

function Achievement:GetAllWaypoints()
    local returnValue = getAchievementWaypoints(self)

    for _, criteria in pairs(self.criteria) do
        local tmp = criteria:GetWaypoints()

        if tmp and #tmp > 0 then
            for _, wp in pairs(tmp) do
                returnValue[#returnValue+1] = wp
            end
        end
    end

    return returnValue
end

function Achievement:GetFilteredWaypoints()
    local returnValue = getAchievementWaypoints({ waypoints = self.waypoints })

    for _, criteria in pairs(self.criteria or {}) do
        local tmp = criteria:GetFilteredWaypoints()

        if tmp and #tmp > 0 then
            for _, wp in pairs(tmp) do
            returnValue[#returnValue+1] = wp
            end
        end
    end

    return returnValue
end
