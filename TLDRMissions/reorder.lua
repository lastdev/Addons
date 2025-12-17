local addonName, addon = ...

local defaultOrder = {
    [Enum.GarrisonFollowerType.FollowerType_6_0_GarrisonFollower] = { -- WOD
        "garrison-resources",
        "follower-items",
        "followerxp",
        "gear",
        "apexis",
        "oil",
        "seal",
        "archaeology",
    },
    [Enum.GarrisonFollowerType.FollowerType_7_0_GarrisonFollower] = { -- Legion
        "orderhall-resources",
        "follower-items",
        "pet-charms",
        "reputation",
        "gear",
        "crafting-reagents",
    },
    [Enum.GarrisonFollowerType.FollowerType_8_0_GarrisonFollower] = { -- BFA
        "BFA-resources",
        --"follower-items",
        --"pet-charms",
        "reputation",
        --"gear",
        --"crafting-reagents",
        "artifact-power",
    },
}

if addon.isWOD then
    table.insert(defaultOrder[1], "gold", 1)
end

--if addon.isBFA then
--    table.insert(defaultOrder, "gold", 1)
--end

function addon.BaseGUIMixin:updateRewards()
    for _, label in pairs(self.priorityLabels) do
        label:SetText()
    end
    
    for _, button in pairs(self.checkButtons) do
        button.ExclusionLabel:Hide()
        button:SetChecked(false)
    end
    
    local db = self.db
        
    local wasSomethingChecked = false
    for i, button in pairs(self.checkButtons) do
        for k, v in pairs(db.profile.selectedRewards) do
            if v == self.rewardStrings[i] then
                button:SetChecked(true)
                self.priorityLabels[i]:SetText(k)
                wasSomethingChecked = true
                break
            end
        end
    end
    
    for k, v in pairs(db.profile.excludedRewards) do
        for i, rewardString in ipairs(self.rewardStrings) do
            if rewardString == v then
                self.checkButtons[i].ExclusionLabel:Show()
            end
        end
    end
    
    if db.profile.anythingForXP or db.profile.sacrificeRemaining then
        wasSomethingChecked = true
    end
    
    if wasSomethingChecked then
        self.CalculateButton:SetEnabled(true)
    else
        self.CalculateButton:SetEnabled(false)
    end
    
    self:RewardsReorder()
end

function addon.BaseGUIMixin:RewardsReorder()
    local maxIndex = 0
    local skipThese = {}
    local defaultOrder = defaultOrder[self.followerTypeID]
    for i = 1, #defaultOrder do
        local isSelected
        for j = 1, #defaultOrder do
            if defaultOrder[i] == self.db.profile.selectedRewards[j] then
                isSelected = true
                maxIndex = maxIndex + 1
                skipThese[i] = true
                local row = self.rows[i]
                row:ClearAllPoints()
                row:SetPoint("TOPLEFT", self.TitleBarTexture, "BOTTOMLEFT", 50, -5 - (22 * (j-1)))
            end
        end
    end
    
    local buffer = 0
    for i = 1, #defaultOrder do
        if not skipThese[i] then
            local row = self.rows[i]
            row:ClearAllPoints()
            row:SetPoint("TOPLEFT", self.TitleBarTexture, "BOTTOMLEFT", 50, -5 - (22 * (buffer + maxIndex)))
            buffer = buffer + 1
        end
    end
end

function addon.BaseGUIMixin:RewardsOnRowDragStop(row, i, rewardStrings)
    local db = self.db
    local selectedRewards = db.profile.selectedRewards
    local currentPriority
    for k = 1, #self.rows do
        if selectedRewards[k] == rewardStrings[i] then
            currentPriority = k
            break
        end
    end
    
    for j, targetRow in ipairs(self.rows) do
        if targetRow ~= row then
            if targetRow:IsMouseOver() then
                for k, v in pairs(db.profile.excludedRewards) do
                    if v == rewardStrings[i] then
                        db.profile.excludedRewards[k] = nil
                    end
                end
                
                local targetRewardString = rewardStrings[targetRow.index]
                local targetPriority
                for k = 1, #self.rows do
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
                        for k = #self.rows, targetPriority+1, -1 do
                            selectedRewards[k] = selectedRewards[k-1]
                        end
                        selectedRewards[targetPriority] = rewardStrings[i]
                    end
                else
                    if currentPriority then
                        for k = currentPriority, #self.rows do
                            selectedRewards[k] = selectedRewards[k+1]
                        end
                    else
                    
                    end
                end
                
                break
            end
        end
    end
    self:updateRewards()
end