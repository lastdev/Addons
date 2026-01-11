local addonName, addon = ...
local LibStub = addon.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("TLDRMissions")

local function skipMissionButtonHandler(self)
    local gui = self:GetParent():GetParent()
    gui.numSkipped = gui.numSkipped + 1
    self:SetEnabled(false)
    gui.CostLabel:Hide()
    gui.CostResultLabel:SetText("")
    gui.StartMissionButton:SetEnabled(false)
    
    if not gui.missionWaitingUserAcceptance then
        print("Error: mission awaiting user acceptance not found")
        return
    end
    
    gui.missionWaitingUserAcceptance = nil
    
    if gui:hasNextMission() then
        gui:calculateNextMission()
    else
        gui:clearReportText(true)
        gui.EstimateLabel:SetText()
        gui.CalculateButton:SetEnabled(true)
        
        local numFollowersAvailable = 0
        for _, follower in pairs(C_Garrison.GetFollowers(gui.followerTypeID)) do
            if (not follower.status) and (follower.isCollected) then
                numFollowersAvailable = numFollowersAvailable + 1
            end
        end
        gui.FailedCalcLabel:SetText(L["MissionsSentPartial"]:format(gui.numSent, gui.numSkipped, gui.numFailed, numFollowersAvailable))
    end
end

function addon.BaseGUIMixin:InitSkipMissionButton()
    self.SkipMissionButton:SetScript("OnClick", skipMissionButtonHandler)
end