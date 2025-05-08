local _, addon = ...
local SlotMixin = addon.namespace('SlotMixin')

function SlotMixin:Init(props)
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
            socketable = 1,
            socketCondition = showMissingArmorSockets,
        }),
        NeckSlot = addon.new(SlotMixin, {
            socketable = 2,
            socketCondition = showMissingJewelrySockets,
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
            socketable = 1,
            socketCondition = showMissingArmorSockets,
        }),
        MainHandSlot = addon.new(SlotMixin, {
            enchantable = true,
        }),
        SecondaryHandSlot = addon.new(SlotMixin, {
            enchantable = true,
            enchantCondition = function (item)
                -- off hand weapons can be enchanted
                local invType = item:GetInvType()

                return invType == 'INVTYPE_WEAPON' or invType == 'INVTYPE_2HWEAPON'
            end,
        }),
        -- HandsSlot = addon.new(SlotMixin, {
        -- }),
        WaistSlot = addon.new(SlotMixin, {
            socketable = 1,
            socketCondition = showMissingArmorSockets,
        }),
        LegsSlot = addon.new(SlotMixin, {
            enchantable = true,
        }),
        FeetSlot = addon.new(SlotMixin, {
            enchantable = true,
        }),
        Finger0Slot = addon.new(SlotMixin, {
            enchantable = true,
            socketable = 2,
            socketCondition = showMissingJewelrySockets,
        }),
        Finger1Slot = addon.new(SlotMixin, {
            enchantable = true,
            socketable = 2,
            socketCondition = showMissingJewelrySockets,
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

    if
        self.socketable
        and numSockets < self.socketable
        and (not self.socketCondition or self.socketCondition(item))
    then
        table.insert(flags, 'S')
    end

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
