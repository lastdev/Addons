local addonName, addon = ...
addonName = "TLDRMissions-Legion"
--local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0")
local LibStub = addon.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("TLDRMissions")

function addon.LegionGUI:InitProfile()
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
            sacrificeRemaining = false,
            minimumTroops = 0,
            guiX = nil,
            guiY = nil,
            followerXPSpecialTreatment = false,
            followerXPSpecialTreatmentMinimum = 4,
            followerXPSpecialTreatmentAlgorithm = 1,
            animaCosts = {
                ["*"] = {
                    ["*"] = true,
                },
            },
            durationLower = 1,
            durationHigher = 24,
            AnimaCostLimit = 1000,
            LevelRestriction = 3,
            sortType = 1,
            useLethalMissionPriority = false,
        }
    }
    
    addon.Legiondb = LibStub("AceDB-3.0"):New("TLDRMissionsLegionProfiles", defaults, true)
    local db = addon.Legiondb
    self.db = db

	db.RegisterCallback(self, "OnProfileChanged", "ProfileChanged")
    db.RegisterCallback(self, "OnProfileCopied", "ProfileChanged")
	db.RegisterCallback(self, "OnProfileReset", "ProfileChanged")
    
    --[[
    local function setupAnimaCostDropDown(name)
        local options = {"10-24", "25-29", "30-49", "50-99", "100+"}

        LibDD:UIDropDownMenu_Initialize(_G["TLDRMissionsWOD"..name.."GarrisonResourceCostDropDown"], function(self, level, menuList)
            local info = LibDD:UIDropDownMenu_CreateInfo()        
            
            for _, option in ipairs(options) do
                info.text = option.." "..WORLD_QUEST_REWARD_FILTERS_RESOURCES
                info.checked = db.profile.animaCosts[name][option]
                info.isNotRadio = true
                info.keepShownOnClick = true
                info.arg1 = option
                info.func = function()
                    db.profile.animaCosts[name][option] = not db.profile.animaCosts[name][option]
                end
                LibDD:UIDropDownMenu_AddButton(info)
            end
        end)
    end
    
    if addon.isWOD then setupAnimaCostDropDown("Gold") end
    setupAnimaCostDropDown("GarrisonResources")
    setupAnimaCostDropDown("FollowerItems")
    setupAnimaCostDropDown("FollowerXP")
    setupAnimaCostDropDown("Gear")
    setupAnimaCostDropDown("Apexis")
    setupAnimaCostDropDown("Oil")
    setupAnimaCostDropDown("Seal")
    ]]
    
    local options = {type = "group", args = {}}
    LibStub("AceConfigRegistry-3.0"):ValidateOptionsTable(options, addonName)
    LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, options, {"tldrmissions-legion"})
    options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(db)
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName, nil, nil, "profiles")
    
    addon.LegionGUI:ProfileChanged()
end
    
function addon.LegionGUI:ProfileChanged()
    local db = addon.Legiondb
    local gui = addon.LegionGUI
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
    
    gui.PrioritiseLethalCheckButton:SetChecked(profile.useLethalMissionPriority)
    
    if profile.guiX and profile.guiY then
        gui:ClearAllPoints()
        gui:SetPoint("TOPLEFT", OrderHallMissionFrame, "TOPLEFT", profile.guiX, profile.guiY)
    end
    
    gui.AnimaCostLimitSlider:SetValue(profile.AnimaCostLimit)
    gui.LowerBoundLevelRestrictionSlider:SetValue(profile.LevelRestriction)
    gui.MinimumTroopsSlider:SetValue(profile.minimumTroops)
    
    TLDRMissions4FrameDurationLowerSliderText:SetText(L["DurationTimeSelectedLabel"]:format(profile.durationLower, profile.durationHigher))
    TLDRMissions4FrameDurationLowerSlider:SetValue(profile.durationLower)
    TLDRMissions4FrameDurationHigherSlider:SetValue(profile.durationHigher)
    gui.AutoShowButton:SetChecked(profile.autoShowUI)
    gui.AutoStartButton:SetChecked(profile.autoStart)
    
    self:updateRewards()
end