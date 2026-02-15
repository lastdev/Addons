AchievementRequirement = {}
AchievementRequirement.__index = AchievementRequirement


local function checkWorldEvent(worldEvent)
    local currentEvents = C_Calendar.GetNumDayEvents(0, 0)

    for i = 1, currentEvents do
        local event = C_Calendar.GetDayEvent(0, 0, i)
        if event.eventID == worldEvent.eventId then
            return true
        end
    end

    return false
end

local function checkActiveQuest(questId)
    return C_TaskQuest.IsActive(questId)
end

local SUPPORTED_ACHIEVEMENT_REQUIREMENTS = {
    event = checkWorldEvent,
    quest = checkActiveQuest
}

function AchievementRequirement:new(requirement)
    local obj = setmetatable({}, AchievementRequirement)

    obj.requirements = {}

    for type, _ in pairs(SUPPORTED_ACHIEVEMENT_REQUIREMENTS) do
        if requirement[type] then
            obj.requirements[type] = requirement[type]
        end
    end

    return obj
end

function AchievementRequirement:HasSpecialRequirements()
    return #self.requirements > 0
end

function AchievementRequirement:AreRequirementsMet()
    local returnValue = true

    for type, callback in pairs(SUPPORTED_ACHIEVEMENT_REQUIREMENTS) do
        if self.requirements[type] ~= nil then
            returnValue = returnValue and callback(self.requirements[type])
        end
    end

    return returnValue
end
