local addonName, addon = ...

local result
function addon.BaseGUIMixin:SimulateFollower(lineup, follower, missionID)
    table.insert(lineup, follower)
    result = self:GetMissionSuccessChance(lineup[1], lineup[2], lineup[3], missionID)
    if result >= 100 then
        return result
    end
    table.remove(lineup)
end

function addon.BaseGUIMixin:arrangeFollowerTroopCombinations(followers, troops, missionID, sortBy)
    local minimumTroops = self.db.profile.minimumTroops
    followers = addon:sortFollowers(followers, sortBy)
    
    local lineup = {}
    local numSlots = C_Garrison.GetBasicMissionInfo(missionID).numFollowers
    
    -- in BFA, not every slot has to be filled. If there arent enough followers, lets just pretend there are fewer slots
    if #followers + #troops < numSlots then
        numSlots = #followers + #troops
    end
    
    if (numSlots == 2) and (minimumTroops > 1) then
        minimumTroops = 1
    end
    
    for i = 1, #followers do
        if numSlots == 1 then
            if self:SimulateFollower(lineup, followers[i], missionID) then return lineup, result end
        else
            if minimumTroops == 0 then
                if self:SimulateFollower(lineup, followers[i], missionID) then return lineup, result end
            end
            
            table.insert(lineup, followers[i])
            
            if minimumTroops == 0 then
                for j = (i+1), #followers do
                    if numSlots == 2 then
                        if self:SimulateFollower(lineup, followers[j], missionID) then return lineup, result end
                    else
                        if self:SimulateFollower(lineup, followers[j], missionID) then return lineup, result end
                        table.insert(lineup, followers[j])
                        for k = (j+1), #followers do
                            if self:SimulateFollower(lineup, followers[k], missionID) then return lineup, result end
                        end
                        for k = 1, #troops do
                            if self:SimulateFollower(lineup, followers[k], missionID) then return lineup, result end
                        end
                        table.remove(lineup)
                    end
                end
                for j = 1, #troops do
                    if numSlots == 2 then
                        if self:SimulateFollower(lineup, troops[j], missionID) then return lineup, result end
                    else
                        if self:SimulateFollower(lineup, troops[j], missionID) then return lineup, result end
                        table.insert(lineup, troops[j])
                        for k = (j+1), #troops do
                            if self:SimulateFollower(lineup, troops[k], missionID) then return lineup, result end
                        end
                        table.remove(lineup)
                    end
                end
            elseif minimumTroops == 1 then
                for j = 1, #troops do
                    if self:SimulateFollower(lineup, troops[j], missionID) then return lineup, result end
                    if numSlots == 3 then
                        table.insert(lineup, troops[j])
                        for k = i+1, #followers do
                            if self:SimulateFollower(lineup, followers[k], missionID) then return lineup, result end
                        end
                        for k = j+1, #troops do
                            if self:SimulateFollower(lineup, troops[k], missionID) then return lineup, result end
                        end
                        table.remove(lineup)
                    end
                end
            elseif minimumTroops == 2 then
                for j = 1, #troops do
                    table.insert(lineup, troops[j])
                    for k = j+1, #troops do
                        if self:SimulateFollower(lineup, troops[k], missionID) then return lineup, result end
                    end
                    table.remove(lineup)
                end
            elseif minimumTroops == 3 then
                -- this is the "use as many troops as are available" option
                if #troops == 1 then
                    if self:SimulateFollower(lineup, troops[1], missionID) then return lineup, result end
                    table.insert(lineup, troops[1])
                    for j = i+1, #followers do
                        if self:SimulateFollower(lineup, followers[j], missionID) then return lineup, result end
                    end
                    table.remove(lineup)
                elseif #troops > 1 then
                    for j = 1, #troops do
                        table.insert(lineup, troops[j])
                        for k = j+1, #troops do
                            if self:SimulateFollower(lineup, troops[k], missionID) then return lineup, result end
                        end
                        table.remove(lineup)
                    end
                end
                -- if no troops are left, do not try anything
            end
            
            table.remove(lineup)
        end
    end
    
    -- all combinations failed
end