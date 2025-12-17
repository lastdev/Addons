local addonName, addon = ...

local checkButtonHandler = function(gui, self, button, name)
    local db = gui.db
    if self:GetChecked() then
        for k, v in pairs(db.profile.excludedRewards) do
            if v == name then
                db.profile.excludedRewards[k] = nil
                self:SetChecked(false)
                gui:updateRewards()
                return
            end
        end
        
        for i = 1, 12 do
            if not db.profile.selectedRewards[i] then
                db.profile.selectedRewards[i] = name
                gui:updateRewards()
                return
            end
        end
    else
        for i = 1, 12 do
            if db.profile.selectedRewards[i] == name then
                for j = i, 12 do
                    if (j+1) > 12 then
                        db.profile.selectedRewards[j] = nil
                        table.insert(db.profile.excludedRewards, name)
                    else
                        db.profile.selectedRewards[j] = db.profile.selectedRewards[j+1]
                    end
                end
                gui:updateRewards()
                return
            end
        end
    end
    gui:updateRewards()
end

function addon.BaseGUIMixin.InitRewardCheckButtons(gui)
    for i, button in pairs(gui.checkButtons) do
        button:HookScript("OnClick", function(self, button) checkButtonHandler(gui, self, button, gui.rewardStrings[i]) end)
        gui.rows[i]:HookScript("OnDragStop", function(row) gui:RewardsOnRowDragStop(row, i, gui.rewardStrings) end)
    end

    gui.AnythingForXPCheckButton:HookScript("OnClick", function(button)
        gui.db.profile.anythingForXP = button:GetChecked()
        gui:updateRewards()
    end)

    gui.SacrificeCheckButton:HookScript("OnClick", function(button)
        gui.db.profile.sacrificeRemaining = button:GetChecked()
        gui:updateRewards()
    end)
end