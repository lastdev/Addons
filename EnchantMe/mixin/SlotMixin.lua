local _, addon = ...
local SlotMixin = addon.namespace('SlotMixin')

function SlotMixin:Init(props)
    self.name = props.name
    self.enchantable = props.enchantable or false
    self.enchantCondition = props.enchantCondition
    self.socketable = props.socketable or 0
    self.socketCondition = props.socketCondition
end

function SlotMixin.GetDefaultSlots()
    local function showMissingJewelrySockets()
        return addon.config.db.showMissingJewelrySockets
    end

    local function showMissingArmorSockets()
        return addon.config.db.showMissingArmorSockets
    end

    return {
        HeadSlot = addon.new(SlotMixin, {
            name = 'HeadSlot',
            socketable = 1,
            socketCondition = showMissingArmorSockets,
        }),
        NeckSlot = addon.new(SlotMixin, {
            name = 'NeckSlot',
            socketable = 2,
            socketCondition = showMissingJewelrySockets,
        }),
        -- ShoulderSlot = addon.new(SlotMixin, {
        --     name = 'ShoulderSlot',
        -- }),
        BackSlot = addon.new(SlotMixin, {
            name = 'BackSlot',
            enchantable = true,
        }),
        ChestSlot = addon.new(SlotMixin, {
            name = 'ChestSlot',
            enchantable = true,
        }),
        WristSlot = addon.new(SlotMixin, {
            name = 'WristSlot',
            enchantable = true,
            socketable = 1,
            socketCondition = showMissingArmorSockets,
        }),
        MainHandSlot = addon.new(SlotMixin, {
            name = 'MainHandSlot',
            enchantable = true,
        }),
        SecondaryHandSlot = addon.new(SlotMixin, {
            name = 'SecondaryHandSlot',
            enchantable = true,
            enchantCondition = function (item)
                -- off hand weapons can be enchanted
                local invType = item:GetInvType()

                return invType == 'INVTYPE_WEAPON' or invType == 'INVTYPE_2HWEAPON'
            end,
        }),
        -- HandsSlot = addon.new(SlotMixin, {
        --     name = 'HandsSlot',
        -- }),
        WaistSlot = addon.new(SlotMixin, {
            name = 'WaistSlot',
            socketable = 1,
            socketCondition = showMissingArmorSockets,
        }),
        LegsSlot = addon.new(SlotMixin, {
            name = 'LegsSlot',
            enchantable = true,
        }),
        FeetSlot = addon.new(SlotMixin, {
            name = 'FeetSlot',
            enchantable = true,
        }),
        Finger0Slot = addon.new(SlotMixin, {
            name = 'Finger0Slot',
            enchantable = true,
            socketable = 2,
            socketCondition = showMissingJewelrySockets,
        }),
        Finger1Slot = addon.new(SlotMixin, {
            name = 'Finger1Slot',
            enchantable = true,
            socketable = 2,
            socketCondition = showMissingJewelrySockets,
        }),
        -- Trinket0Slot = addon.new(SlotMixin, {
        --     name = 'Trinket0Slot',
        -- }),
        -- Trinket1Slot = addon.new(SlotMixin, {
        --     name = 'Trinket1Slot',
        -- }),
    }
end

function SlotMixin:GetFlags(unit, itemLink)
    local flags = {}
    local item = addon.new(addon.ItemMixin, itemLink)

    if self:NeedsEnchant(item) then
        table.insert(flags, 'E')
    end

    local numGems, numSockets = item:GetGemStats()

    if numGems < numSockets then
        table.insert(flags, 'G')
    end

    if
        self.socketable
        and numSockets < self.socketable
        and (not self.socketCondition or self.socketCondition(item))
    then
        table.insert(flags, 'S')
    end

    addon.plugin.dispatch('slot.flags', {
        slot = self,
        unit = unit,
        item = item,
        flags = flags,
    })

    return flags
end

function SlotMixin:NeedsEnchant(item)
    if not self.enchantable or item:GetLinkValues()[2] ~= '' then
        return false -- not enchantable or already enchanted
    end

    if self.enchantCondition and not self.enchantCondition(item) then
        return false -- condition not satisfied
    end

    return true
end
