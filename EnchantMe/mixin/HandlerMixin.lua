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

    -- update flags
    for slotName, slot in pairs(self.slots) do
        local itemLink = GetInventoryItemLink(self.unit, GetInventorySlotInfo(slotName))
        local flags = itemLink and slot:GetFlags(self.unit, itemLink) or {}

        self:SetIndicatorFlags(slotName, flags)
    end
end

function HandlerMixin:SetIndicatorFlags(slotName, flags)
    if not self.indicators then
        self.indicators = {}
    end

    if not self.indicators[slotName] then
        self.indicators[slotName] = addon.new(addon.IndicatorMixin, self:GetSlotFrame(slotName))
    end

    self.indicators[slotName]:SetFlags(flags)
end

function HandlerMixin:ClearIndicatorFlags()
    if not self.indicators then
        return
    end

    for _, indicator in pairs(self.indicators) do
        indicator:SetFlags({})
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
