local addonName, addon = ...

local function startSimulation(combination, missionID, callback)
    local info = C_Garrison.GetBasicMissionInfo(missionID)
    if (not info) or (info.offerEndTime and (info.offerEndTime < GetTime())) then
        callback({defeats = 0, victories = 0, ["missionID"] = missionID})
        return
    end
        
    addon:WODSimulate(combination[1], combination[2], combination[3], missionID, function(results)
        results.combination = {combination[1], combination[2], combination[3]}
        results.missionID = missionID  
        if results.successChance >= 100 then
            callback(results)
            return true
        end
    end)
end

function addon:arrangeWODFollowerCombinations(followers, missionID, callback, sortBy)
    followers = addon:sortFollowers(followers, sortBy)
    
    local lineup = {}
    
    local function testFollower(follower)
        table.insert(lineup, follower)
        local result = startSimulation({lineup[1], lineup[2], lineup[3]}, missionID, callback)
        table.remove(lineup)
        return result
    end
    
    local numSlots = C_Garrison.GetBasicMissionInfo(missionID).numFollowers
    
    if #followers < numSlots then return end
    
    for i = 1, #followers do
        if numSlots == 1 then
            local result = testFollower(followers[i])
            if result then return result end
        else
            table.insert(lineup, followers[i])
            for j = (i+1), #followers do
                if numSlots == 2 then
                    local result = testFollower(followers[j])
                    if result then return result end
                else
                    table.insert(lineup, followers[j])
                    for k = (j+1), #followers do
                        local result = testFollower(followers[k])
                        if result then return result end
                    end
                    table.remove(lineup)
                end
            end
            table.remove(lineup)
        end
    end
    
    -- all combinations failed
    callback({["defeats"] = 1, ["victories"] = 0})
end
