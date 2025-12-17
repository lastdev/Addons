local addonName, addon = ...
local LibStub = addon.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale("TLDRMissions")

local function handler(self, value, userInput, isHigher)
    if not userInput then return end
    
    local db = self:GetParent():GetParent().db.profile
    local gui = self:GetParent():GetParent()
    
    if isHigher then
        db.durationHigher = value
    else
        db.durationLower = value
    end
    
    if tonumber(db.durationLower) > tonumber(db.durationHigher) then
        local a = db.durationLower
        db.durationLower = db.durationHigher
        db.durationHigher = a
        gui.DurationLowerSlider:SetValue(db.durationLower)
        gui.DurationHigherSlider:SetValue(db.durationHigher)
    end
    
    _G["TLDRMissions"..gui.followerTypeID.."FrameDurationLowerSliderText"]:SetText(L["DurationTimeSelectedLabel"]:format(db.durationLower, db.durationHigher))
end

function addon.DurationLowerSliderOnValueChangedHandler(self, value, userInput)
    handler(self, value, userInput)
end

function addon.DurationHigherSliderOnValueChangedHandler(self, value, userInput)
    handler(self, value, userInput, true)
end