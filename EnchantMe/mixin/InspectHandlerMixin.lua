local _, addon = ...
local InspectHandlerMixin, private = addon.namespace('InspectHandlerMixin')

addon.mixin(InspectHandlerMixin, addon.HandlerMixin)

function InspectHandlerMixin:Init()
    -- configure
    self.unit = 'target'
    self.slots = addon.SlotMixin.GetDefaultSlots()

    -- register event listeners
    addon.on('INSPECT_READY', addon.defer(0.1, addon.bind(self, 'UpdateFlags'))) -- this can fire many times
end

function InspectHandlerMixin:IsAvailable()
    return InspectFrame and InspectFrame:IsShown()
end

addon.overrideMixin(InspectHandlerMixin, 'CreateIndicators', function (self, super)
    -- clear indicators when inspect is closed so old indicators don't show up for other players before inspect is ready
    hooksecurefunc(InspectFrame, 'Hide', addon.bind(self, 'ClearFlags'))

    return super()
end)

function InspectHandlerMixin:GetSlotFrame(slotName)
    return _G['Inspect' .. slotName]
end
