WoWAchievement = {}
WoWAchievement.__index = WoWAchievement

AchievementCriteriaTypes = {
    CompletingAQuest = 27
}

function WoWAchievement:new(id)
    local obj = setmetatable({}, WoWAchievement)

    obj.id = id

    return obj
end

--[[
function WoWAchievement:dumpinfo()
    print("info")
    local numCriteria = GetAchievementNumCriteria(self.id)
    for i = 1, numCriteria do
        local criteriaString, criteriaType, completed, quantity, reqQuantity, charName, flags, assetID, quantityString, criteriaID, eligible = GetAchievementCriteriaInfo(self.id, i)

        print("----- Criteria " .. i .. " -----")
        print("criteriaString: " .. tostring(criteriaString))
--        print("criteriaType: " .. tostring(criteriaType))
--        print("completed: " .. tostring(completed))
--        print("quantity: " .. tostring(quantity))
--        print("reqQuantity: " .. tostring(reqQuantity))
--        print("charName: " .. tostring(charName))
--        print("flags: " .. tostring(flags))
--        print("assetID: " .. tostring(assetID))
--        print("quantityString: " .. tostring(quantityString))
        print("criteriaID: " .. tostring(criteriaID))
--        print("eligible: " .. tostring(eligible))
    end
end
]]

function WoWAchievement:filterWaypoints(waypoints)
    local returnData = {}
    local numCriteria = GetAchievementNumCriteria(self.id)

    for _, wp in pairs(waypoints) do
        for i = 1, numCriteria do
            local criteriaString, criteriaType, completed, quantity, reqQuantity, charName, flags, assetID, quantityString, criteriaID, eligible = GetAchievementCriteriaInfo(self.id, i)

            -- if waypoint criteriaId is not nil and matches criteria ID 
            if wp.criteriaId and wp.criteriaId == criteriaID then
                -- if it's a quest completion
                if criteriaType == AchievementCriteriaTypes.CompletingAQuest then
                    if not C_QuestLog.IsQuestFlaggedCompletedOnAccount(assetID) then
                        returnData[#returnData+1] = wp
                    end
                end
            end
        end
    end

    return returnData
end
