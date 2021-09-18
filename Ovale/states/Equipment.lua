local __exports = LibStub:NewLibrary("ovale/states/Equipment", 90107)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
__imports.__enginecondition = LibStub:GetLibrary("ovale/engine/condition")
__imports.returnBoolean = __imports.__enginecondition.returnBoolean
__imports.returnConstant = __imports.__enginecondition.returnConstant
__imports.returnValueBetween = __imports.__enginecondition.returnValueBetween
local aceEvent = __imports.aceEvent
local ipairs = ipairs
local kpairs = pairs
local pairs = pairs
local tonumber = tonumber
local type = type
local wipe = wipe
local INFINITY = math.huge
local find = string.find
local len = string.len
local lower = string.lower
local match = string.match
local sub = string.sub
local concat = table.concat
local insert = table.insert
local sort = table.sort
local C_Item = C_Item
local Enum = Enum
local GetInventorySlotInfo = GetInventorySlotInfo
local GetItemCooldown = GetItemCooldown
local GetItemStats = GetItemStats
local GetTime = GetTime
local GetWeaponEnchantInfo = GetWeaponEnchantInfo
local ItemLocation = ItemLocation
local returnBoolean = __imports.returnBoolean
local returnConstant = __imports.returnConstant
local returnValueBetween = __imports.returnValueBetween
__exports.inventorySlotNames = {
    AMMOSLOT = true,
    BACKSLOT = true,
    CHESTSLOT = true,
    FEETSLOT = true,
    FINGER0SLOT = true,
    FINGER1SLOT = true,
    HANDSSLOT = true,
    HEADSLOT = true,
    LEGSSLOT = true,
    MAINHANDSLOT = true,
    NECKSLOT = true,
    SECONDARYHANDSLOT = true,
    SHIRTSLOT = true,
    SHOULDERSLOT = true,
    TABARDSLOT = true,
    TRINKET0SLOT = true,
    TRINKET1SLOT = true,
    WAISTSLOT = true,
    WRISTSLOT = true
}
local slotIdByName = {}
local slotNameById = {}
local checkSlotName = {
    ammoslot = true,
    backslot = true,
    chestslot = true,
    feetslot = true,
    finger0slot = true,
    finger1slot = true,
    handsslot = true,
    headslot = true,
    legsslot = true,
    mainhandslot = true,
    neckslot = true,
    offhandslot = true,
    secondaryhandslot = true,
    shirtslot = true,
    shoulderslot = true,
    tabardslot = true,
    trinket0slot = true,
    trinket1slot = true,
    waistslot = true,
    wristslot = true
}
local slotNameByName = {
    ammoslot = "AMMOSLOT",
    backslot = "BACKSLOT",
    chestslot = "CHESTSLOT",
    feetslot = "FEETSLOT",
    finger0slot = "FINGER0SLOT",
    finger1slot = "FINGER1SLOT",
    handsslot = "HANDSSLOT",
    headslot = "HEADSLOT",
    legsslot = "LEGSSLOT",
    mainhandslot = "MAINHANDSLOT",
    neckslot = "NECKSLOT",
    offhandslot = "SECONDARYHANDSLOT",
    secondaryhandslot = "SECONDARYHANDSLOT",
    shirtslot = "SHIRTSLOT",
    shoulderslot = "SHOULDERSLOT",
    tabardslot = "TABARDSLOT",
    trinket0slot = "TRINKET0SLOT",
    trinket1slot = "TRINKET1SLOT",
    waistslot = "WAISTSLOT",
    wristslot = "WRISTSLOT"
}
local ovaleSlotNameByName = {}
local function resetItemInfo(item)
    item.exists = false
    item.guid = ""
    item.pending = nil
    item.link = nil
    item.location = nil
    item.name = nil
    item.quality = nil
    item.type = nil
    item.id = nil
    wipe(item.gem)
    wipe(item.bonus)
    wipe(item.modifier)
end
__exports.OvaleEquipmentClass = __class(nil, {
    constructor = function(self, ovale, ovaleDebug, data)
        self.ovale = ovale
        self.data = data
        self.mainHandDPS = 0
        self.offHandDPS = 0
        self.equippedItem = {}
        self.equippedItemBySharedCooldown = {}
        self.isEquippedItemById = {}
        self.debugOptions = {
            itemsequipped = {
                name = "Items equipped",
                type = "group",
                args = {
                    itemsequipped = {
                        name = "Items equipped",
                        type = "input",
                        multiline = 25,
                        width = "full",
                        get = function(info)
                            return self.debugEquipment()
                        end
                    }
                }
            }
        }
        self.handleInitialize = function()
            self.module:RegisterEvent("ITEM_DATA_LOAD_RESULT", self.handleItemDataLoadResult)
            self.module:RegisterEvent("PLAYER_ENTERING_WORLD", self.handlePlayerEnteringWorld)
            self.module:RegisterEvent("PLAYER_EQUIPMENT_CHANGED", self.handlePlayerEquipmentChanged)
        end
        self.handleDisable = function()
            self.module:UnregisterEvent("ITEM_DATA_LOAD_RESULT")
            self.module:UnregisterEvent("PLAYER_ENTERING_WORLD")
            self.module:UnregisterEvent("PLAYER_EQUIPMENT_CHANGED")
        end
        self.handleItemDataLoadResult = function(event, itemId, success)
            if success and self.isEquippedItemById[itemId] then
                for slot, item in pairs(self.equippedItem) do
                    if item.pending then
                        local slotId = slotIdByName[slot]
                        local location = ItemLocation:CreateFromEquipmentSlot(slotId)
                        if location:IsValid() and item.pending == itemId then
                            self.finishUpdateForSlot(slot, itemId, location)
                        end
                    end
                end
            end
        end
        self.handlePlayerEnteringWorld = function(event)
            for slot in kpairs(__exports.inventorySlotNames) do
                self.queueUpdateForSlot(slot)
            end
        end
        self.handlePlayerEquipmentChanged = function(event, slotId, hasCurrent)
            local slot = slotNameById[slotId]
            self.queueUpdateForSlot(slot)
        end
        self.parseItemLink = function(link, item)
            local s = match(link, "item:([%-?%d:]+)")
            local pattern = "[^:]*:"
            local i, j = find(s, pattern)
            local eos = len(s)
            local numBonus = 0
            local numModifiers = 0
            local index = 0
            while i do
                local token = tonumber(sub(s, i, j - 1)) or 0
                index = index + 1
                if index == 1 then
                    item.id = token
                elseif 3 <= index and index <= 5 then
                    if token ~= 0 then
                        local gem = item.gem or {}
                        insert(gem, token)
                        item.gem = gem
                    end
                elseif index == 13 then
                    numBonus = token
                elseif index > 13 and index <= 13 + numBonus then
                    local bonus = item.bonus or {}
                    insert(bonus, token)
                    item.bonus = bonus
                elseif index == 13 + numBonus + 1 then
                    numModifiers = token
                elseif index > 13 + numBonus + 1 and index <= 13 + numBonus + 1 + numModifiers then
                    local modifier = item.modifier or {}
                    insert(modifier, token)
                    item.modifier = modifier
                end
                if j < eos then
                    s = sub(s, j + 1)
                    i, j = find(s, pattern)
                else
                    break
                end
            end
        end
        self.queueUpdateForSlot = function(slot)
            local slotId = slotIdByName[slot]
            local location = ItemLocation:CreateFromEquipmentSlot(slotId)
            local item = self.equippedItem[slot]
            if location:IsValid() then
                local itemId = C_Item.GetItemID(location)
                self.isEquippedItemById[itemId] = true
                local link = C_Item.GetItemLink(location)
                if link then
                    self.finishUpdateForSlot(slot, itemId, location)
                else
                    item.pending = itemId
                    C_Item.RequestLoadItemData(location)
                    self.tracer:debug("Slot " .. slot .. ", item " .. itemId .. ": queued")
                end
            else
                self.tracer:debug("Slot " .. slot .. ": empty")
                resetItemInfo(item)
            end
        end
        self.finishUpdateForSlot = function(slot, itemId, location)
            self.tracer:debug("Slot " .. slot .. ", item " .. itemId .. ": finished")
            local item = self.equippedItem[slot]
            if location:IsValid() then
                local prevGUID = item.guid
                local prevItemId = item.id
                if prevItemId ~= nil then
                    self.isEquippedItemById[prevItemId] = nil
                end
                resetItemInfo(item)
                item.exists = true
                item.guid = C_Item.GetItemGUID(location)
                item.id = itemId
                item.location = location
                item.name = C_Item.GetItemName(location)
                item.quality = C_Item.GetItemQuality(location)
                item.type = C_Item.GetItemInventoryType(location)
                local link = C_Item.GetItemLink(location)
                if link then
                    item.link = link
                    self.parseItemLink(link, item)
                    if slot == "MAINHANDSLOT" or slot == "SECONDARYHANDSLOT" then
                        local stats = GetItemStats(link)
                        if stats ~= nil then
                            local dps = stats["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] or 0
                            if slot == "MAINHANDSLOT" then
                                self.mainHandDPS = dps
                            elseif slot == "SECONDARYHANDSLOT" then
                                self.offHandDPS = dps
                            end
                        end
                    end
                end
                self.isEquippedItemById[itemId] = true
                local info = self.data.itemInfo[itemId]
                if info ~= nil and info.shared_cd ~= nil then
                    self.equippedItemBySharedCooldown[info.shared_cd] = itemId
                end
                if prevGUID ~= item.guid then
                    self.ovale:needRefresh()
                    local slotName = ovaleSlotNameByName[slot]
                    self.module:SendMessage("Ovale_EquipmentChanged", slotName)
                end
            else
                resetItemInfo(item)
            end
        end
        self.debugEquipment = function()
            local output = {}
            local array = {}
            insert(output, "Equipped Items:")
            for id in kpairs(self.isEquippedItemById) do
                insert(array, "    " .. id)
            end
            sort(array)
            for _, v in ipairs(array) do
                insert(output, v)
            end
            insert(output, "")
            wipe(array)
            for slot, item in pairs(self.equippedItem) do
                local shortSlot = lower(sub(slot, 1, -5))
                if item.exists then
                    local s = shortSlot .. ": " .. item.id
                    if #item.gem > 0 then
                        s = s .. " gem["
                        for _, v in ipairs(item.gem) do
                            s = s .. " " .. v
                        end
                        s = s .. "]"
                    end
                    if #item.bonus > 0 then
                        s = s .. " bonus["
                        for _, v in ipairs(item.bonus) do
                            s = s .. " " .. v
                        end
                        s = s .. "]"
                    end
                    if #item.modifier > 0 then
                        s = s .. " mod["
                        for _, v in ipairs(item.modifier) do
                            s = s .. " " .. v
                        end
                        s = s .. "]"
                    end
                    insert(array, s)
                else
                    insert(array, shortSlot .. ": empty")
                end
            end
            sort(array)
            for _, v in ipairs(array) do
                insert(output, v)
            end
            insert(output, "")
            insert(output, "Main-hand DPS = " .. self.mainHandDPS)
            insert(output, "Off-hand DPS = " .. self.offHandDPS)
            return concat(output, "\n")
        end
        self.hasItemEquipped = function(positionalParams, namedParams, atTime)
            local itemId = positionalParams[1]
            local boolean = false
            if type(itemId) == "number" then
                boolean = self.isEquippedItemById[itemId]
            elseif self.data.itemList[itemId] ~= nil then
                for _, id in pairs(self.data.itemList[itemId]) do
                    boolean = self.isEquippedItemById[id]
                    if boolean then
                        break
                    end
                end
            end
            return returnBoolean(boolean)
        end
        self.hasShield = function(positionalParams, namedParams, atTime)
            local item = self.equippedItem["SECONDARYHANDSLOT"]
            local boolean = item.exists and item.type == Enum.InventoryType.IndexShieldType
            return returnBoolean(boolean)
        end
        self.hasTrinket = function(positionalParams, namedParams, atTime)
            local itemId = positionalParams[1]
            local boolean = false
            if type(itemId) == "number" then
                boolean = (self.equippedItem["TRINKET0SLOT"].exists and self.equippedItem["TRINKET0SLOT"].id == itemId) or (self.equippedItem["TRINKET1SLOT"].exists and self.equippedItem["TRINKET1SLOT"].id == itemId)
            elseif self.data.itemList[itemId] ~= nil then
                for _, id in pairs(self.data.itemList[itemId]) do
                    boolean = (self.equippedItem["TRINKET0SLOT"].exists and self.equippedItem["TRINKET0SLOT"].id == id) or (self.equippedItem["TRINKET1SLOT"].exists and self.equippedItem["TRINKET1SLOT"].id == id)
                    if boolean then
                        break
                    end
                end
            end
            return returnBoolean(boolean)
        end
        self.hasWeapon = function(positionalParameter, namedParameter, atTime)
            local slot = positionalParameter[1]
            local handedness = positionalParameter[2]
            local invSlot = slotNameByName[slot]
            local invType = (handedness == "1h" and Enum.InventoryType.IndexWeaponType) or Enum.InventoryType.Index2HweaponType
            local item = self.equippedItem[invSlot]
            if item.exists and item.type then
                return returnBoolean(item.type == invType)
            end
            return returnBoolean(false)
        end
        self.itemCooldown = function(atTime, itemId, slot, sharedCooldown)
            if sharedCooldown then
                itemId = self:getEquippedItemIdBySharedCooldown(sharedCooldown)
            end
            if slot ~= nil then
                itemId = self:getEquippedItemId(slot)
            end
            if itemId then
                local start, duration = GetItemCooldown(itemId)
                if start > 0 and duration > 0 then
                    local ending = start + duration
                    return returnValueBetween(start, ending, duration, start, -1)
                end
            end
            return returnConstant(0)
        end
        self.itemCooldownDuration = function(atTime, itemId, slot)
            if slot ~= nil then
                itemId = self:getEquippedItemId(slot)
            end
            if  not itemId then
                return returnConstant(0)
            end
            local _, duration = GetItemCooldown(itemId)
            if duration <= 0 then
                duration = (self.data:getItemInfoProperty(itemId, atTime, "cd")) or 0
            end
            return returnConstant(duration)
        end
        self.itemInSlot = function(atTime, slot)
            local itemId = self:getEquippedItemId(slot)
            return returnConstant(itemId)
        end
        self.weaponEnchantExpires = function(positionalParams)
            local expectedEnchantmentId = positionalParams[1]
            local hand = positionalParams[2]
            local hasMainHandEnchant, mainHandExpiration, enchantmentId, hasOffHandEnchant, offHandExpiration = GetWeaponEnchantInfo()
            local now = GetTime()
            if hand == "main" or hand == nil then
                if hasMainHandEnchant and expectedEnchantmentId == enchantmentId then
                    mainHandExpiration = mainHandExpiration / 1000
                    return now + mainHandExpiration, INFINITY
                end
            elseif hand == "offhand" or hand == "off" then
                if hasOffHandEnchant then
                    offHandExpiration = offHandExpiration / 1000
                    return now + offHandExpiration, INFINITY
                end
            end
            return 0, INFINITY
        end
        self.weaponEnchantPresent = function(positionalParams)
            local expectedEnchantmentId = positionalParams[1]
            local hand = positionalParams[2]
            local hasMainHandEnchant, mainHandExpiration, enchantmentId, hasOffHandEnchant, offHandExpiration = GetWeaponEnchantInfo()
            local now = GetTime()
            if hand == "main" or hand == nil then
                if hasMainHandEnchant and expectedEnchantmentId == enchantmentId then
                    mainHandExpiration = mainHandExpiration / 1000
                    return 0, now + mainHandExpiration
                end
            elseif hand == "offhand" or hand == "off" then
                if hasOffHandEnchant then
                    offHandExpiration = offHandExpiration / 1000
                    return 0, now + offHandExpiration
                end
            end
            return 
        end
        self.itemRppm = function(atTime, itemId, slot)
            if slot then
                itemId = self:getEquippedItemId(slot)
            end
            if itemId then
                local rppm = self.data:getItemInfoProperty(itemId, atTime, "rppm")
                return returnConstant(rppm)
            end
            return 
        end
        self.module = ovale:createModule("OvaleEquipment", self.handleInitialize, self.handleDisable, aceEvent)
        self.tracer = ovaleDebug:create("OvaleEquipment")
        for k, v in pairs(self.debugOptions) do
            ovaleDebug.defaultOptions.args[k] = v
        end
        for slot in kpairs(__exports.inventorySlotNames) do
            ovaleSlotNameByName[slot] = lower(slot)
            local slotId = GetInventorySlotInfo(slot)
            slotIdByName[slot] = slotId
            slotNameById[slotId] = slot
            self.equippedItem[slot] = {
                exists = false,
                guid = "",
                gem = {},
                bonus = {},
                modifier = {}
            }
        end
    end,
    getArmorSetCount = function(self, name)
        return 0
    end,
    getEquippedItemId = function(self, slot)
        local invSlot = slotNameByName[slot]
        local item = self.equippedItem[invSlot]
        return (item and item.exists and item.id) or nil
    end,
    getEquippedItemIdBySharedCooldown = function(self, sharedCooldown)
        return self.equippedItemBySharedCooldown[sharedCooldown]
    end,
    getEquippedItemLocation = function(self, slot)
        local invSlot = slotNameByName[slot]
        local item = self.equippedItem[invSlot]
        if item and item.exists then
            if item.location and item.location:IsValid() then
                return item.location
            end
        end
        return nil
    end,
    getEquippedItemQuality = function(self, slot)
        local invSlot = slotNameByName[slot]
        local item = self.equippedItem[invSlot]
        return (item and item.exists and item.quality) or nil
    end,
    getEquippedItemBonusIds = function(self, slot)
        local invSlot = slotNameByName[slot]
        local item = self.equippedItem[invSlot]
        return (item and item.bonus) or {}
    end,
    hasRangedWeapon = function(self)
        local item = self.equippedItem["MAINHANDSLOT"]
        if item.exists and item.type ~= nil then
            return (item.type == Enum.InventoryType.IndexRangedType or item.type == Enum.InventoryType.IndexRangedrightType)
        end
        return false
    end,
    registerConditions = function(self, ovaleCondition)
        ovaleCondition:registerCondition("hasequippeditem", false, self.hasItemEquipped)
        ovaleCondition:registerCondition("hasshield", false, self.hasShield)
        ovaleCondition:registerCondition("hastrinket", false, self.hasTrinket)
        ovaleCondition:registerCondition("hasweapon", false, self.hasWeapon)
        local slotParameter = {
            type = "string",
            name = "slot",
            checkTokens = checkSlotName,
            optional = true
        }
        local itemParameter = {
            name = "item",
            type = "number",
            optional = true,
            isItem = true
        }
        ovaleCondition:register("itemcooldown", self.itemCooldown, {
            type = "number"
        }, itemParameter, slotParameter, {
            name = "shared",
            type = "string",
            optional = true
        })
        ovaleCondition:register("itemrppm", self.itemRppm, {
            type = "number"
        }, {
            type = "number",
            name = "item",
            optional = true
        }, {
            type = "string",
            name = "slot",
            checkTokens = checkSlotName,
            optional = true
        })
        ovaleCondition:register("itemcooldownduration", self.itemCooldownDuration, {
            type = "number"
        }, itemParameter, slotParameter)
        ovaleCondition:registerCondition("weaponenchantexpires", false, self.weaponEnchantExpires)
        ovaleCondition:registerCondition("weaponenchantpresent", false, self.weaponEnchantPresent)
        ovaleCondition:register("iteminslot", self.itemInSlot, {
            type = "number"
        }, {
            type = "string",
            optional = false,
            name = "slot",
            checkTokens = checkSlotName
        })
    end,
})
