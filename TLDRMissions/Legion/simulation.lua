local addonName, addon = ...

function addon:WODSimulate(leftFollowerID, middleFollowerID, rightFollowerID, missionID, callback)
    C_Garrison.AddFollowerToMission(missionID, leftFollowerID, 1)
    if middleFollowerID then
        C_Garrison.AddFollowerToMission(missionID, middleFollowerID, 2)
    end
    if rightFollowerID then
        C_Garrison.AddFollowerToMission(missionID, rightFollowerID, 3)
    end
    
    local successChance = C_Garrison.GetMissionSuccessChance(missionID)
    
    C_Garrison.RemoveFollowerFromMission(missionID, leftFollowerID, 1)
    if middleFollowerID then
        C_Garrison.RemoveFollowerFromMission(missionID, middleFollowerID, 2)
    end
    if rightFollowerID then
        C_Garrison.RemoveFollowerFromMission(missionID, rightFollowerID, 3)
    end
    
    callback({["successChance"] = successChance})
end
