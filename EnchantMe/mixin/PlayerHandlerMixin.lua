local _, addon = ...
local PlayerHandlerMixin, private = addon.namespace('PlayerHandlerMixin')

addon.mixin(PlayerHandlerMixin, addon.HandlerMixin)

function PlayerHandlerMixin:Init()
    -- configure
    self.unit = 'player'
    self.slots = addon.SlotMixin.GetDefaultSlots()
    self.slots.HeadSlot.condition = function ()
        return C_QuestLog.IsQuestFlaggedCompleted(78429) -- 10.2 raid quest to get [Incandescent Essence]
    end

    -- register event listeners
    addon.on('PLAYER_ENTERING_WORLD', addon.bind(self, 'OnLogin'))
    addon.on('PLAYER_EQUIPMENT_CHANGED', addon.bind(self, 'UpdateFlags'))
    addon.on('PLAYER_LEVEL_UP', addon.bind(self, 'UpdateFlags'))
    addon.on('SOCKET_INFO_UPDATE', addon.bind(self, 'UpdateFlags'))
    addon.on('BAG_UPDATE', addon.defer(0.1, addon.bind(self, 'OnBagUpdate'))) -- this can fire many times
end

function PlayerHandlerMixin:GetSlotFrame(slotName)
    return _G['Character' .. slotName]
end

function PlayerHandlerMixin:OnLogin()
    C_Timer.After(0, addon.bind(self, 'UpdateFlags')) -- delay the update by 1 frame as item stats aren't available yet
end

function PlayerHandlerMixin:OnBagUpdate(bagId)
    if bagId == 0 then
        self:UpdateFlags()
    end
end
