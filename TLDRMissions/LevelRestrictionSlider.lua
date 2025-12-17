local addonName, addon = ...

function addon.LevelRestrictionSliderOnValueChangedHandler(self, value)
    local db = self:GetParent():GetParent().db.profile
    local gui = self:GetParent():GetParent()
    
    _G["TLDRMissions"..gui.followerTypeID.."FrameSliderText"]:SetText(value)
    db.LevelRestriction = value
end