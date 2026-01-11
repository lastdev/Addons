local addonName, addon = ...

function addon.MinimumTroopsSliderOnValueChangedHandler(self, value)
    local db = self:GetParent():GetParent().db.profile
    local gui = self:GetParent():GetParent()
    
    _G["TLDRMissions"..gui.followerTypeID.."FrameMinimumTroopsSliderText"]:SetText(value)
    db.minimumTroops = value
end