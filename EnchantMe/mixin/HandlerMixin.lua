local _, addon = ...
local HandlerMixin = addon.namespace('HandlerMixin')

HandlerMixin.unit = nil
HandlerMixin.slots = nil
HandlerMixin.indicators = nil

function HandlerMixin:IsAvailable()
    return true
end

function HandlerMixin:UpdateFlags()
    -- check availability
    if
        not self:IsAvailable()
        or PlayerGetTimerunningSeasonID() ~= nil -- disable in timerunning
    then
        return
    end

    -- check unit level
    local unitLevel = UnitLevel(self.unit)

    if unitLevel < addon.main.MIN_UNIT_LEVEL or unitLevel > addon.main.MAX_UNIT_LEVEL then
        return
    end

    -- create indicators if not done yet
    if not self.indicators then
        self:CreateIndicators()
    end

    -- update flags
    for slotName, slot in pairs(self.slots) do
        local itemLink = GetInventoryItemLink(self.unit, GetInventorySlotInfo(slotName))

        self.indicators[slotName]:SetFlags(
            itemLink and slot:GetFlags(itemLink) or {}
        )
    end
end

function HandlerMixin:ClearFlags()
    if not self.indicators then
        return
    end

    for _, indicator in pairs(self.indicators) do
        indicator:SetFlags({})
    end
end

function HandlerMixin:CreateIndicators()
    self.indicators = {}

    for slotName in pairs(self.slots) do
        self.indicators[slotName] = addon.new(addon.IndicatorMixin, self:GetSlotFrame(slotName))
    end
end

function HandlerMixin:UpdateIndicators()
    if not self.indicators then
        return
    end

    for _, indicator in pairs(self.indicators) do
        indicator:UpdateFrame()
    end
end

function HandlerMixin:GetSlotFrame(slotName)
    error('Not implemented')
end
