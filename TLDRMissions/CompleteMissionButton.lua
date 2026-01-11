local addonName, addon = ...
local LibStub = addon.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("TLDRMissions")
local AceEvent = LibStub("AceAddon-3.0"):GetAddon("TLDRMissions-AceEvent")

local rewardLimits = {
    [824] = 10000, -- Garrison Resources
    [1101] = 100000, -- Oil
    [821] = 250, -- Draenor Clans Archaeology Fragment
    [829] = 250, -- Arakkoa
    [828] = 250, -- Ogre
}

function addon.CompleteMissionsButtonOnClickHandler(button)
    local i = 0
    local missions = C_Garrison.GetCompleteMissions(button:GetParent():GetParent().followerTypeID)
    
    if table.getn(missions) == 0 then
        button:SetText(L["NotYet"])
        C_Timer.After(5, function()
            button:SetText(L["CompleteMissionsButtonText"])
        end)
        return
    end
    
    local size = table.getn(missions)
    for _, mission in pairs(missions) do
        button:SetText(size)
        
        local rewards = C_Garrison.GetMissionRewardInfo(mission.missionID)
        local skip
        if button:GetParent():GetParent().db.profile.skipFullResources then
            for _, rewardInfo in ipairs(rewards) do
                if rewardInfo.currencyID and rewardLimits[rewardInfo.currencyID] then
                    local currencyInfo = C_CurrencyInfo.GetCurrencyInfo(rewardInfo.currencyID)
                    if currencyInfo.quantity + rewardInfo.quantity > rewardLimits[rewardInfo.currencyID] then
                        skip = true
                        print("TLDRMissions: this currency is full or nearly full, skipping " .. currencyInfo.name)
                    end
                end
            end
        end
        
        C_Timer.After(i, function()
            size = size - 1
            button:SetText(size)
            if size < 1 then
                button:SetText(DONE.."!")
                AceEvent:SendMessage("TLDRMISSIONS_COMPLETE_MISSIONS_FINISHED")
                if WeakAuras then
                    WeakAuras.ScanEvents("TLDRMISSIONS_COMPLETE_MISSIONS_FINISHED")
                end
                C_Timer.After(2, function()
                    if #C_Garrison.GetCompleteMissions(button:GetParent():GetParent().followerTypeID) == 0 then
                        button:Hide()
                    end
                    button:SetText(L["CompleteMissionsButtonText"])
                    -- without this, the completion dialog stays on screen
                    --if BFAMissionFrameMissions and BFAMissionFrameMissions.CompleteDialog and BFAMissionFrameMissions.CompleteDialog.BorderFrame and BFAMissionFrameMissions.CompleteDialog.BorderFrame.ViewButton then
                    --    BFAMissionFrameMissions.CompleteDialog.BorderFrame.ViewButton:Click()
                    --end
                end)
            end
            
            if not skip then
                C_Garrison.MarkMissionComplete(mission.missionID)
                C_Garrison.MissionBonusRoll(mission.missionID)
            end
        end)
        
        i = i + 0.1
    end
end