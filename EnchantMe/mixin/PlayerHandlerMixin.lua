local _, addon = ...
local PlayerHandlerMixin, private = addon.namespace('PlayerHandlerMixin')
local equipmentUpdated = false

addon.mixin(PlayerHandlerMixin, addon.HandlerMixin)

function PlayerHandlerMixin:Init()
    -- configure
    self.unit = 'player'
    self.slots = addon.SlotMixin.GetDefaultSlots()

    -- update flags once character frame is shown
    hooksecurefunc(CharacterFrame, 'Show', addon.bind(self, 'UpdateFlags'))

    -- register event listeners
    addon.on('PLAYER_EQUIPMENT_CHANGED', addon.bind(self, 'UpdateFlagsIfVisible')) -- changing gear, adding sockets
    addon.on('PLAYER_LEVEL_UP', addon.bind(self, 'UpdateFlagsIfVisible')) -- leveling up
    addon.on('SOCKET_INFO_UPDATE', addon.bind(self, 'UpdateFlagsIfVisible')) -- socket info becoming available
    addon.on('BAG_UPDATE', addon.bind(self, 'OnBagUpdate')) -- adding enchants, gems
    addon.on('BAG_UPDATE_DELAYED', addon.bind(self, 'OnBagUpdateDelayed')) -- adding enchants, gems
end

function PlayerHandlerMixin:GetSlotFrame(slotName)
    return _G['Character' .. slotName]
end

function PlayerHandlerMixin:UpdateFlagsIfVisible()
    if CharacterFrame:IsShown() then
        self:UpdateFlags()
    end
end

function PlayerHandlerMixin:OnBagUpdate(bagId)
    if bagId == 0 then
        -- this also fires for the default backpack, but it seems impossible to differentiate
        equipmentUpdated = true
    end
end

function PlayerHandlerMixin:OnBagUpdateDelayed()
    if equipmentUpdated then
        self:UpdateFlagsIfVisible()
        equipmentUpdated = false
    end
end
