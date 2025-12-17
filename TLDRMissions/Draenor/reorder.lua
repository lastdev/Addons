local addonName, addon = ...

local defaultOrder = {
    "garrison-resources",
    "follower-items",
    "followerxp",
    "gear",
    "apexis",
    "oil",
    "seal",
    "archaeology",
}

if addon.isWOD then
    table.insert(defaultOrder, "gold", 1)
end

function addon:WODReorder()
    local maxIndex = 0
    local skipThese = {}
    for i = 1, #defaultOrder do
        local isSelected
        for j = 1, #defaultOrder do
            if defaultOrder[i] == addon.WODdb.profile.selectedRewards[j] then
                isSelected = true
                maxIndex = maxIndex + 1
                skipThese[i] = true
                local row = addon.WODGUI.rows[i]
                row:ClearAllPoints()
                row:SetPoint("TOPLEFT", addon.WODGUI.TitleBarTexture, "BOTTOMLEFT", 50, -5 - (22 * (j-1)))
            end
        end
    end
    
    local buffer = 0
    for i = 1, #defaultOrder do
        if not skipThese[i] then
            local row = addon.WODGUI.rows[i]
            row:ClearAllPoints()
            row:SetPoint("TOPLEFT", addon.WODGUI.TitleBarTexture, "BOTTOMLEFT", 50, -5 - (22 * (buffer + maxIndex)))
            buffer = buffer + 1
        end
    end
end

local gui = addon.WODGUI

function addon:WODOnRowDragStop(row, i, rewardStrings)
    local selectedRewards = addon.WODdb.profile.selectedRewards
    local currentPriority
    for k = 1, #gui.rows do
        if selectedRewards[k] == rewardStrings[i] then
            currentPriority = k
            break
        end
    end
    
    for j, targetRow in ipairs(gui.rows) do
        if targetRow ~= row then
            if targetRow:IsMouseOver() then
                for k, v in pairs(addon.WODdb.profile.excludedRewards) do
                    if v == rewardStrings[i] then
                        addon.WODdb.profile.excludedRewards[k] = nil
                    end
                end
                
                local targetRewardString = rewardStrings[targetRow.index]
                local targetPriority
                for k = 1, #gui.rows do
                    if selectedRewards[k] == targetRewardString then
                        targetPriority = k
                        break
                    end
                end
                
                if targetPriority then
                    if currentPriority then
                        -- picked up row and the row being dropped on are both selected
                        if currentPriority < targetPriority then
                            for k = currentPriority, targetPriority-1 do
                                selectedRewards[k] = selectedRewards[k+1]
                            end
                            selectedRewards[targetPriority] = rewardStrings[i]
                        else
                            for k = currentPriority, targetPriority+1, -1 do
                                selectedRewards[k] = selectedRewards[k-1]
                            end
                            selectedRewards[targetPriority] = rewardStrings[i]
                        end
                    else
                        for k = #gui.rows, targetPriority+1, -1 do
                            selectedRewards[k] = selectedRewards[k-1]
                        end
                        selectedRewards[targetPriority] = rewardStrings[i]
                    end
                else
                    if currentPriority then
                        for k = currentPriority, #gui.rows do
                            selectedRewards[k] = selectedRewards[k+1]
                        end
                    else
                    
                    end
                end
                
                break
            end
        end
    end
    addon:updateWODRewards()
end