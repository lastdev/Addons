local addonName = ...
local addon = _G[addonName]
local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")
local LibStub = addon.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("TLDRMissions")


function addon.WODGUI:RefreshProfile()
    local defaults = {
        profile = {
            selectedRewards = {
                ["*"] = nil,
            },
            excludedRewards = {
                ["*"] = nil,
            },
            anythingForXP = false,
            autoStart = false,
            autoShowUI = false,
            DEVTESTING = nil,
            sacrificeRemaining = false,
            guiX = nil,
            guiY = nil,
            followerXPSpecialTreatment = false,
            followerXPSpecialTreatmentMinimum = 4,
            followerXPSpecialTreatmentAlgorithm = 1,
            autoStart = false,
            autoShowUI = false,
            animaCosts = {
                ["*"] = {
                    ["*"] = true,
                },
            },
            durationLower = 1,
            durationHigher = 24,
        }
    }
    
    addon.WODdb = LibStub("AceDB-3.0"):New("TLDRMissionsWODProfiles", defaults, true)
    local db = addon.WODdb

	db.RegisterCallback(self, "OnProfileChanged", "ProfileChanged")
    db.RegisterCallback(self, "OnProfileCopied", "ProfileChanged")
	db.RegisterCallback(self, "OnProfileReset", "ProfileChanged")
    
    local options = {type = "group", args = {}}
    LibStub("AceConfigRegistry-3.0"):ValidateOptionsTable(options, addonName)
    LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName.."-WOD", options, {"tldrmissions-wod"})
    options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(db)
    
    addon.WODGUI:ProfileChanged()
end
    
    
function addon.WODGUI:ProfileChanged()
    local db = addon.WODdb
    local gui = addon.WODGUI
    local profile = db.profile
    
    gui.CalculateButton:SetEnabled(false)
    for i = 1, 12 do
        if profile.selectedRewards[i] then
            gui.CalculateButton:SetEnabled(true)
            break
        end
    end
    if profile.anythingForXP then
        gui.CalculateButton:SetEnabled(true)
    end
    gui.AnythingForXPCheckButton:SetChecked(profile.anythingForXP)    
    
    gui.AutoStartButton:SetChecked(profile.autoStart)
    
    if profile.guiX and profile.guiY then
        gui:ClearAllPoints()
        gui:SetPoint("TOPLEFT", GarrisonMissionFrame, "TOPLEFT", profile.guiX, profile.guiY)
    end
    
    addon:updateWODRewards()
end
