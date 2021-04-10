local __exports = LibStub:NewLibrary("ovale/states/Equipment", 90048)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local pairs = pairs
local wipe = wipe
local ipairs = ipairs
local kpairs = pairs
local type = type
local sub = string.sub
local GetInventoryItemID = GetInventoryItemID
local GetInventoryItemLink = GetInventoryItemLink
local GetItemStats = GetItemStats
local GetItemInfoInstant = GetItemInfoInstant
local INVSLOT_FIRST_EQUIPPED = INVSLOT_FIRST_EQUIPPED
local INVSLOT_LAST_EQUIPPED = INVSLOT_LAST_EQUIPPED
local GetItemCooldown = GetItemCooldown
local GetWeaponEnchantInfo = GetWeaponEnchantInfo
local GetTime = GetTime
local INVSLOT_AMMO = INVSLOT_AMMO
local INVSLOT_HEAD = INVSLOT_HEAD
local INVSLOT_NECK = INVSLOT_NECK
local INVSLOT_BODY = INVSLOT_BODY
local INVSLOT_LEGS = INVSLOT_LEGS
local INVSLOT_FEET = INVSLOT_FEET
local INVSLOT_HAND = INVSLOT_HAND
local INVSLOT_FINGER1 = INVSLOT_FINGER1
local INVSLOT_TRINKET1 = INVSLOT_TRINKET1
local INVSLOT_BACK = INVSLOT_BACK
local INVSLOT_OFFHAND = INVSLOT_OFFHAND
local INVSLOT_MAINHAND = INVSLOT_MAINHAND
local INVSLOT_TABARD = INVSLOT_TABARD
local INVSLOT_FINGER2 = INVSLOT_FINGER2
local INVSLOT_TRINKET2 = INVSLOT_TRINKET2
local INVSLOT_WRIST = INVSLOT_WRIST
local INVSLOT_WAIST = INVSLOT_WAIST
local INVSLOT_CHEST = INVSLOT_CHEST
local INVSLOT_SHOULDER = INVSLOT_SHOULDER
local concat = table.concat
local insert = table.insert
local __toolstools = LibStub:GetLibrary("ovale/tools/tools")
local isNumber = __toolstools.isNumber
local __enginecondition = LibStub:GetLibrary("ovale/engine/condition")
local returnBoolean = __enginecondition.returnBoolean
local returnConstant = __enginecondition.returnConstant
local returnValueBetween = __enginecondition.returnValueBetween
local huge = math.huge
local slotIdBySlotNames = {
    ammoslot = INVSLOT_AMMO,
    headslot = INVSLOT_HEAD,
    neckslot = INVSLOT_NECK,
    shoulderslot = INVSLOT_SHOULDER,
    shirtslot = INVSLOT_BODY,
    chestslot = INVSLOT_CHEST,
    waistslot = INVSLOT_WAIST,
    legsslot = INVSLOT_LEGS,
    feetslot = INVSLOT_FEET,
    wristslot = INVSLOT_WRIST,
    handsslot = INVSLOT_HAND,
    finger0slot = INVSLOT_FINGER1,
    finger1slot = INVSLOT_FINGER2,
    trinket0slot = INVSLOT_TRINKET1,
    trinket1slot = INVSLOT_TRINKET2,
    backslot = INVSLOT_BACK,
    mainhandslot = INVSLOT_MAINHAND,
    secondaryhandslot = INVSLOT_OFFHAND,
    tabardslot = INVSLOT_TABARD
}
local slotNameBySlotIds = {}
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
    secondaryhandslot = true,
    shirtslot = true,
    shoulderslot = true,
    tabardslot = true,
    trinket0slot = true,
    trinket1slot = true,
    waistslot = true,
    wristslot = true
}
local oneHandedWeapons = {
    INVTYPE_WEAPON = true,
    INVTYPE_WEAPONOFFHAND = true,
    INVTYPE_WEAPONMAINHAND = true
}
local rangedWeapons = {
    INVTYPE_RANGEDRIGHT = true,
    INVTYPE_RANGED = true
}
__exports.OvaleEquipmentClass = __class(nil, {
    constructor = function(self, ovale, ovaleDebug, ovaleProfiler, data)
        self.ovale = ovale
        self.data = data
        self.ready = false
        self.equippedItemById = {}
        self.equippedItemBySlot = {}
        self.equippedItemBySharedCooldown = {}
        self.mainHandDPS = 0
        self.offHandDPS = 0
        self.armorSetCount = {}
        self.lastChangedSlot = nil
        self.output = {}
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
                            return self:debugEquipment()
                        end
                    }
                }
            }
        }
        self.handleInitialize = function()
            self.module:RegisterEvent("PLAYER_ENTERING_WORLD", self.updateEquippedItems)
            self.module:RegisterEvent("PLAYER_EQUIPMENT_CHANGED", self.handlePlayerEquipmentChanged)
        end
        self.handleDisable = function()
            self.module:UnregisterEvent("PLAYER_ENTERING_WORLD")
            self.module:UnregisterEvent("PLAYER_EQUIPMENT_CHANGED")
        end
        self.handlePlayerEquipmentChanged = function(event, slotId, hasItem)
            self.profiler:startProfiling("OvaleEquipment_PLAYER_EQUIPMENT_CHANGED")
            local changed = self:updateItemBySlot(slotId)
            if changed then
                self.lastChangedSlot = slotId
                self.ovale:needRefresh()
                self.module:SendMessage("Ovale_EquipmentChanged")
            end
            self.profiler:stopProfiling("OvaleEquipment_PLAYER_EQUIPMENT_CHANGED")
        end
        self.updateEquippedItems = function()
            self.profiler:startProfiling("OvaleEquipment_UpdateEquippedItems")
            local changed = false
            for slotId = INVSLOT_FIRST_EQUIPPED, INVSLOT_LAST_EQUIPPED, 1 do
                if slotNameBySlotIds[slotId] and self:updateItemBySlot(slotId) then
                    changed = true
                end
            end
            if changed then
                self.ovale:needRefresh()
                self.module:SendMessage("Ovale_EquipmentChanged")
            end
            self.ready = true
            self.profiler:stopProfiling("OvaleEquipment_UpdateEquippedItems")
        end
        self.hasItemEquipped = function(positionalParams, namedParams, atTime)
            local itemId = positionalParams[1]
            local boolean = false
            local slotId
            if type(itemId) == "number" then
                slotId = self:isItemEquipped(itemId)
                if slotId then
                    boolean = true
                end
            elseif self.data.itemList[itemId] then
                for _, v in pairs(self.data.itemList[itemId]) do
                    slotId = self:isItemEquipped(v)
                    if slotId then
                        boolean = true
                        break
                    end
                end
            end
            return returnBoolean(boolean)
        end
        self.hasShieldCondition = function(positionalParams, namedParams, atTime)
            local boolean = self:hasShield()
            return returnBoolean(boolean)
        end
        self.hasTrinketCondition = function(positionalParams, namedParams, atTime)
            local trinketId = positionalParams[1]
            local boolean = nil
            if type(trinketId) == "number" then
                boolean = self:hasTrinket(trinketId)
            elseif self.data.itemList[trinketId] then
                for _, v in pairs(self.data.itemList[trinketId]) do
                    boolean = self:hasTrinket(v)
                    if boolean then
                        break
                    end
                end
            end
            return returnBoolean(boolean ~= nil)
        end
        self.itemCooldown = function(atTime, itemId, slot, sharedCooldown)
            if sharedCooldown then
                itemId = self:getEquippedItemBySharedCooldown(sharedCooldown)
            end
            if slot then
                itemId = self:getEquippedItemBySlotName(slot)
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
                itemId = self:getEquippedItemBySlotName(slot)
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
            return returnConstant(self:getEquippedItemBySlotName(slot))
        end
        self.weaponEnchantExpires = function(positionalParams)
            local expectedEnchantmentId = positionalParams[1]
            local hand = positionalParams[2]
            local hasMainHandEnchant, mainHandExpiration, enchantmentId, hasOffHandEnchant, offHandExpiration = GetWeaponEnchantInfo()
            local now = GetTime()
            if hand == "main" or hand == nil then
                if hasMainHandEnchant and expectedEnchantmentId == enchantmentId then
                    mainHandExpiration = mainHandExpiration / 1000
                    return now + mainHandExpiration, huge
                end
            elseif hand == "offhand" or hand == "off" then
                if hasOffHandEnchant then
                    offHandExpiration = offHandExpiration / 1000
                    return now + offHandExpiration, huge
                end
            end
            return 0, huge
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
                itemId = self:getEquippedItemBySlotName(slot)
            end
            if itemId then
                return returnConstant(self.data:getItemInfoProperty(itemId, atTime, "rppm"))
            end
            return 
        end
        self.module = ovale:createModule("OvaleEquipment", self.handleInitialize, self.handleDisable, aceEvent)
        self.profiler = ovaleProfiler:create(self.module:GetName())
        for k, v in pairs(self.debugOptions) do
            ovaleDebug.defaultOptions.args[k] = v
        end
        for slotName, invSlotId in kpairs(slotIdBySlotNames) do
            slotNameBySlotIds[invSlotId] = slotName
        end
    end,
    registerConditions = function(self, ovaleCondition)
        ovaleCondition:registerCondition("hasequippeditem", false, self.hasItemEquipped)
        ovaleCondition:registerCondition("hasshield", false, self.hasShieldCondition)
        ovaleCondition:registerCondition("hastrinket", false, self.hasTrinketCondition)
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
    getArmorSetCount = function(self, name)
        return 0
    end,
    getEquippedItemBySlotName = function(self, slotName)
        if slotName then
            local slotId = slotIdBySlotNames[slotName]
            if slotId ~= nil then
                return self.equippedItemBySlot[slotIdBySlotNames[slotName]]
            end
        end
        return nil
    end,
    getEquippedItemBySharedCooldown = function(self, sharedCooldown)
        return self.equippedItemBySharedCooldown[sharedCooldown]
    end,
    getEquippedTrinkets = function(self)
        return self.equippedItemBySlot[slotIdBySlotNames["trinket0slot"]], self.equippedItemBySlot[slotIdBySlotNames["trinket1slot"]]
    end,
    isItemEquipped = function(self, itemId)
        return (self.equippedItemById[itemId] and true) or false
    end,
    hasMainHandWeapon = function(self, handedness)
        if  not self.mainHandItemType then
            return false
        end
        if handedness then
            if handedness == 1 then
                return oneHandedWeapons[self.mainHandItemType]
            elseif handedness == 2 then
                return self.mainHandItemType == "INVTYPE_2HWEAPON"
            end
        else
            return (oneHandedWeapons[self.mainHandItemType] or self.mainHandItemType == "INVTYPE_2HWEAPON")
        end
        return false
    end,
    hasOffHandWeapon = function(self, handedness)
        if  not self.offHandItemType then
            return false
        end
        if handedness then
            if handedness == 1 then
                return oneHandedWeapons[self.offHandItemType]
            elseif handedness == 2 then
                return self.offHandItemType == "INVTYPE_2HWEAPON"
            end
        else
            return (oneHandedWeapons[self.offHandItemType] or self.offHandItemType == "INVTYPE_2HWEAPON")
        end
        return false
    end,
    hasShield = function(self)
        return self.offHandItemType == "INVTYPE_SHIELD"
    end,
    hasRangedWeapon = function(self)
        return self.mainHandItemType and rangedWeapons[self.mainHandItemType]
    end,
    hasTrinket = function(self, itemId)
        return self:isItemEquipped(itemId)
    end,
    hasTwoHandedWeapon = function(self)
        return (self.mainHandItemType == "INVTYPE_2HWEAPON" or self.offHandItemType == "INVTYPE_2HWEAPON")
    end,
    hasOneHandedWeapon = function(self, slotId)
        if slotId and  not isNumber(slotId) then
            slotId = slotIdBySlotNames[slotId]
        end
        if slotId then
            if slotId == slotIdBySlotNames["mainhandslot"] then
                return (self.mainHandItemType and oneHandedWeapons[self.mainHandItemType])
            elseif slotId == slotIdBySlotNames["secondaryhandslot"] then
                return (self.offHandItemType and oneHandedWeapons[self.offHandItemType])
            end
        else
            return ((self.mainHandItemType and oneHandedWeapons[self.mainHandItemType]) or (self.offHandItemType and oneHandedWeapons[self.offHandItemType]))
        end
        return false
    end,
    updateItemBySlot = function(self, slotId)
        local prevItemId = self.equippedItemBySlot[slotId]
        if prevItemId then
            self.equippedItemById[prevItemId] = nil
        end
        local newItemId = GetInventoryItemID("player", slotId)
        if newItemId then
            self.equippedItemById[newItemId] = slotId
            self.equippedItemBySlot[slotId] = newItemId
            if slotId == slotIdBySlotNames["mainhandslot"] then
                local itemEquipLoc, dps = self:updateWeapons(slotId, newItemId)
                self.mainHandItemType = itemEquipLoc
                self.mainHandDPS = dps
            elseif slotId == slotIdBySlotNames["secondaryhandslot"] then
                local itemEquipLoc, dps = self:updateWeapons(slotId, newItemId)
                self.offHandItemType = itemEquipLoc
                self.offHandDPS = dps
            end
            local itemInfo = self.data.itemInfo[newItemId]
            if itemInfo then
                if itemInfo.shared_cd then
                    self.equippedItemBySharedCooldown[itemInfo.shared_cd] = newItemId
                end
            end
        else
            self.equippedItemBySlot[slotId] = nil
            if slotId == slotIdBySlotNames["mainhandslot"] then
                self.mainHandItemType = nil
                self.mainHandDPS = 0
            elseif slotId == slotIdBySlotNames["secondaryhandslot"] then
                self.offHandItemType = nil
                self.offHandDPS = 0
            end
        end
        if prevItemId ~= newItemId then
            return true
        end
        return false
    end,
    updateWeapons = function(self, slotId, itemId)
        local _, _, _, itemEquipLoc = GetItemInfoInstant(itemId)
        local dps = 0
        local itemLink = GetInventoryItemLink("player", slotId)
        if itemLink then
            local stats = GetItemStats(itemLink)
            if stats then
                dps = stats["ITEM_MOD_DAMAGE_PER_SECOND_SHORT"] or 0
            end
        end
        return itemEquipLoc, dps
    end,
    debugEquipment = function(self)
        wipe(self.output)
        local array = {}
        for slotId, slotName in ipairs(slotNameBySlotIds) do
            local itemId = self.equippedItemBySlot[slotId] or ""
            local shortSlotName = sub(slotName, 1, -5)
            insert(array, shortSlotName .. ": " .. itemId)
        end
        insert(array, [[
]])
        insert(array, "Main Hand DPS = " .. self.mainHandDPS)
        if self:hasOffHandWeapon() then
            insert(array, "Off hand DPS = " .. self.offHandDPS)
        end
        for _, v in ipairs(array) do
            self.output[#self.output + 1] = v
        end
        return concat(self.output, "\n")
    end,
})
