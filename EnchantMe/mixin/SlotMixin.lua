local _, addon = ...
local SlotMixin, private = addon.namespace('SlotMixin')

function SlotMixin:Init(props)
    self.enchantable = props.enchantable or false
    self.socketable = props.socketable or 0
    self.condition = props.condition
end

function SlotMixin.GetDefaultSlots()
    return {
        HeadSlot = addon.new(SlotMixin, {
            enchantable = true, -- [Incandescent Essence] from Amirdrassil raid quest
        }),
        NeckSlot = addon.new(SlotMixin, {
            socketable = 3,
        }),
        -- ShoulderSlot = addon.new(SlotMixin, {
        -- }),
        BackSlot = addon.new(SlotMixin, {
            enchantable = true,
        }),
        ChestSlot = addon.new(SlotMixin, {
            enchantable = true,
        }),
        WristSlot = addon.new(SlotMixin, {
            enchantable = true,
        }),
        MainHandSlot = addon.new(SlotMixin, {
            enchantable = true,
        }),
        SecondaryHandSlot = addon.new(SlotMixin, {
            enchantable = true,
            condition = function (item)
                -- off hand weapons can be enchanted
                local invType = item:GetInvType()

                return invType == 'INVTYPE_WEAPON' or invType == 'INVTYPE_2HWEAPON'
            end,
        }),
        HandsSlot = addon.new(SlotMixin, {
        }),
        WaistSlot = addon.new(SlotMixin, {
            enchantable = true,
            condition = function ()
                return not addon.config.db.ignoreBelt
            end,
        }),
        LegsSlot = addon.new(SlotMixin, {
            enchantable = true,
        }),
        FeetSlot = addon.new(SlotMixin, {
            enchantable = true,
        }),
        Finger0Slot = addon.new(SlotMixin, {
            enchantable = true,
        }),
        Finger1Slot = addon.new(SlotMixin, {
            enchantable = true,
        }),
        -- Trinket0Slot = addon.new(SlotMixin, {
        -- }),
        -- Trinket1Slot = addon.new(SlotMixin, {
        -- }),
    }
end

function SlotMixin:GetFlags(itemLink)
    local flags = {}
    local item = addon.new(addon.ItemMixin, itemLink)

    if self:NeedsEnchant(item) then
        table.insert(flags, 'E')
    end

    local numGems, numSockets = item:GetGemStats()

    if numGems < numSockets then
        table.insert(flags, 'G')
    end

    if self.socketable and numSockets < self.socketable then
        table.insert(flags, 'S')
    end

    return flags
end

function SlotMixin:NeedsEnchant(item)
    if not self.enchantable or item:GetLinkValues()[2] ~= '' then
        return false -- not enchantable or already enchanted
    end

    if self.condition and not self.condition(item) then
        return false -- condition not satisfied
    end

    return true
end
