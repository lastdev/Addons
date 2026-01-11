local addonName, addon = ...

function addon.ResourceCostLimitSliderOnValueChangedHandler(self, value)
    local db = self:GetParent():GetParent().db.profile
    local gui = self:GetParent():GetParent()
    
    _G["TLDRMissions"..gui.followerTypeID.."FrameAnimaCostSliderText"]:SetText(value)
    db.AnimaCostLimit = value
end