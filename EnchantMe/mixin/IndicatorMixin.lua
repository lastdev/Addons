local _, addon = ...
local IndicatorMixin, private = addon.namespace('IndicatorMixin')
local positionOffsets = {
    TOPLEFT = {x = 3, y = -2},
    TOPRIGHT = {x = -3, y = -2},
    BOTTOMLEFT = {x = 3, y = 2},
    BOTTOMRIGHT = {x = -3, y = 2},
}

function IndicatorMixin:Init(parentFrame)
    self.flags = {}

    self.frame = CreateFrame('Frame', nil, parentFrame, 'BackdropTemplate')
    self.frame:SetSize(10, 10)
    self.frame:SetBackdrop({bgFile = nil, edgeFile = nil, tile = false, tileSize = 32, edgeSize = 0, insets = {left = 0, right = 0, top = 0, bottom = 0}})
    self.frame:SetBackdropColor(0, 0, 0, 0)

    local text = self.frame:CreateFontString(nil, 'ARTWORK')
    text:SetFont('Fonts\\FRIZQT__.TTF', 11, 'THICKOUTLINE')
    text:SetPoint('TOPLEFT', self.frame, 'TOPLEFT', 0, 0)
    self.frame.text = text

    self:UpdateFrame()
end

function IndicatorMixin:UpdateFrame()
    local point = addon.config.db.indicatorPos
    local offsets = positionOffsets[point]

    self.frame:ClearAllPoints()
    self.frame:SetPoint(point, self.frame:GetParent(), point, offsets.x, offsets.y)
    self:UpdateText()
end

function IndicatorMixin:SetFlags(flags)
    self.flags = flags
    self:UpdateText()
end

function IndicatorMixin:UpdateText()
    if #self.flags > 0 then
        self.frame.text:SetFormattedText('|c%s%s|r', addon.config.db.flagColor, table.concat(self.flags, ','))
        self.frame:Show()
    else
        self.frame:Hide()
    end
end
