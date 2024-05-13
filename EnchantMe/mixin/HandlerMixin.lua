local _, addon = ...
local HandlerMixin, private = addon.namespace('HandlerMixin')
local minLevel = 60

HandlerMixin.unit = nil
HandlerMixin.slots = nil
HandlerMixin.indicators = nil

function HandlerMixin:IsAvailable()
    return true
end

function HandlerMixin:UpdateFlags()
    if not self:IsAvailable() then
        return
    end

    if not self.indicators then
        self:CreateIndicators()
    end

    if UnitLevel(self.unit) < minLevel then
        return
    end

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
