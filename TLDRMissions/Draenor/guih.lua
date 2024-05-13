local addonName = ...
local addon = _G[addonName]
local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")
local LibStub = addon.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("TLDRMissions")
local AceEvent = LibStub("AceAddon-3.0"):NewAddon("TLDRMissions-AceEvent", "AceEvent-3.0")

local gui = addon.WODGUI

local nextMission
local hasNextMission
local missionCounter
local missionCounterUpper
local calculateNextMission
local setNextMissionText

local pauseReports

local missionWaitingUserAcceptance
local calculatedMissionBacklog = {}

local alreadyUsedFollowers

local numSent
local numSkipped
local numFailed

gui.CompleteMissionsButton:SetScript("OnClick", function(self, button)
    local i = 0
    local missions = C_Garrison.GetCompleteMissions(1)
    
    if table.getn(missions) == 0 then
        self:SetText(L["NotYet"])
        C_Timer.After(5, function()
            self:SetText(L["CompleteMissionsButtonText"])
        end)
        return
    end
    
    local size = table.getn(missions)
    for _, mission in pairs(missions) do
        self:SetText(size)
        C_Timer.After(i, function()
            size = size - 1
            self:SetText(size)
            if size < 1 then
                self:SetText(DONE.."!")
                AceEvent:SendMessage("TLDRMISSIONS_COMPLETE_MISSIONS_FINISHED")
                if WeakAuras then
                    WeakAuras.ScanEvents("TLDRMISSIONS_COMPLETE_MISSIONS_FINISHED")
                end
                C_Timer.After(2, function()
                    if #C_Garrison.GetCompleteMissions(1) == 0 then
                        self:Hide()
                    elseif oncePerLogin then
                        oncePerLogin = false
                        gui.CompleteMissionsButton:Click()
                        return
                    end
                    self:SetText(L["CompleteMissionsButtonText"])
                    -- without this, the completion dialog stays on screen
                    GarrisonMissionFrame:Hide()
                    GarrisonMissionFrame:Show()
                end)
            end
            
            C_Garrison.MarkMissionComplete(mission.missionID)
            C_Garrison.MissionBonusRoll(mission.missionID)
        end)
        i = i + 0.1
    end
end)
