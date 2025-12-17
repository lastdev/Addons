AngleurUnderlight_TutorialTooltipMixin = {}

function AngleurUnderlight_TutorialTooltipMixin:OnShow()
    self:SetPadding(self.paddingL, self.paddingB, self.paddingR, self.paddingT)
end

function AngleurUnderlight_TutorialTooltipMixin:PlaceTexture(texturePath, width, height, anchor, padOffsetX, padOffsetY)
    if not texturePath then return end
    self.texture:ClearAllPoints()
    self.texture:SetTexture(texturePath)
    self.texture:SetSize(width, height)
    self.texture:SetPoint(anchor, self, anchor)
    self:ResetPadding()
    if anchor == "TOPLEFT" then
        self.paddingL = width + padOffsetX
        self.paddingT = height + padOffsetY
    elseif anchor == "TOPRIGHT" then
        self.paddingR = width + padOffsetX
        self.paddingT = height + padOffsetY
    elseif anchor == "BOTTOMLEFT" then
        self.paddingL = width + padOffsetX
        self.paddingB = height + padOffsetY
    elseif anchor == "BOTTOMRIGHT" then
        self.paddingR = width + padOffsetX
        self.paddingB = height + padOffsetY
    end
end

function AngleurUnderlight_TutorialTooltipMixin:ResetPadding()
    self.paddingL = 0
    self.paddingB = 0
    self.paddingR = 0
    self.paddingT = 0
end

function AngleurUnderlight_TutorialTooltipMixin:OnHide()
    self.texture:SetTexture(nil)
    self.texture:ClearAllPoints()
    self:ResetPadding()    
end