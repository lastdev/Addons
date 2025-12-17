local addonName, addon = ...
local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")
local LibStub = addon.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("TLDRMissions")
local AceEvent = LibStub("AceAddon-3.0"):GetAddon("TLDRMissions-AceEvent")

function addon:CompleteMissionsButtonOnClickHandler()
    local i = 0
    local missions = C_Garrison.GetCompleteMissions(self:GetParent().followerTypeID)
    
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
                    if #C_Garrison.GetCompleteMissions(self:GetParent().followerTypeID) == 0 then
                        self:Hide()
                    end
                    self:SetText(L["CompleteMissionsButtonText"])
                    -- without this, the completion dialog stays on screen
                    --if BFAMissionFrameMissions and BFAMissionFrameMissions.CompleteDialog and BFAMissionFrameMissions.CompleteDialog.BorderFrame and BFAMissionFrameMissions.CompleteDialog.BorderFrame.ViewButton then
                    --    BFAMissionFrameMissions.CompleteDialog.BorderFrame.ViewButton:Click()
                    --end
                end)
            end
            
            C_Garrison.MarkMissionComplete(mission.missionID)
            C_Garrison.MissionBonusRoll(mission.missionID)
        end)
        
        i = i + 0.1
    end
end