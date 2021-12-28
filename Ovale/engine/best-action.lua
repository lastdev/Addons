local __exports = LibStub:NewLibrary("ovale/engine/best-action", 90113)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
__imports.__ast = LibStub:GetLibrary("ovale/engine/ast")
__imports.setResultType = __imports.__ast.setResultType
__imports.__toolstools = LibStub:GetLibrary("ovale/tools/tools")
__imports.isNumber = __imports.__toolstools.isNumber
__imports.isString = __imports.__toolstools.isString
local aceEvent = __imports.aceEvent
local pairs = pairs
local tonumber = tonumber
local tostring = tostring
local GetActionCooldown = GetActionCooldown
local GetActionTexture = GetActionTexture
local GetItemIcon = GetItemIcon
local GetItemCooldown = GetItemCooldown
local GetItemSpell = GetItemSpell
local GetSpellTexture = GetSpellTexture
local IsActionInRange = IsActionInRange
local IsItemInRange = IsItemInRange
local IsUsableAction = IsUsableAction
local IsUsableItem = IsUsableItem
local setResultType = __imports.setResultType
local isNumber = __imports.isNumber
local isString = __imports.isString
__exports.OvaleBestActionClass = __class(nil, {
    constructor = function(self, ovaleEquipment, ovaleActionBar, ovaleData, ovaleCooldown, ovale, guids, future, spellBook, ovaleDebug, variables, spells, runner)
        self.ovaleEquipment = ovaleEquipment
        self.ovaleActionBar = ovaleActionBar
        self.ovaleData = ovaleData
        self.ovaleCooldown = ovaleCooldown
        self.guids = guids
        self.future = future
        self.spellBook = spellBook
        self.variables = variables
        self.spells = spells
        self.runner = runner
        self.onInitialize = function()
        end
        self.getActionItemInfo = function(node, atTime, target)
            local itemId = node.cachedParams.positional[1]
            local result = node.result
            setResultType(result, "action")
            if  not isNumber(itemId) then
                local slot = tostring(itemId)
                local itemIdFromSlot = self.ovaleEquipment:getEquippedItemId(slot)
                if  not itemIdFromSlot then
                    self.tracer:log("Unknown item '%s'.", itemId)
                    return result
                end
                itemId = itemIdFromSlot
            end
            self.tracer:log("Item ID '%s'", itemId)
            local actionSlot = self.ovaleActionBar:getItemActionSlot(itemId)
            local spellName = GetItemSpell(itemId)
            if node.cachedParams.named.texture then
                result.actionTexture = "Interface\\Icons\\" .. node.cachedParams.named.texture
            else
                result.actionTexture = GetItemIcon(itemId)
            end
            result.actionInRange = IsItemInRange(itemId, target)
            result.actionCooldownStart, result.actionCooldownDuration, result.actionEnable = GetItemCooldown(itemId)
            result.actionUsable = (spellName and IsUsableItem(itemId) and self.spells:isUsableItem(itemId, atTime)) or false
            result.actionSlot = actionSlot
            result.actionType = "item"
            result.actionId = itemId
            result.actionTarget = target
            result.castTime = self.future:getGCD(atTime)
            return result
        end
        self.getActionMacroInfo = function(element, atTime, target)
            local result = element.result
            local macro = element.cachedParams.positional[1]
            local actionSlot = self.ovaleActionBar:getMacroActionSlot(macro)
            setResultType(result, "action")
            if  not actionSlot then
                self.tracer:log("Unknown macro '%s'.", macro)
                return result
            end
            if element.cachedParams.named.texture then
                result.actionTexture = "Interface\\Icons\\" .. element.cachedParams.named.texture
            else
                result.actionTexture = GetActionTexture(actionSlot)
            end
            result.actionInRange = IsActionInRange(actionSlot, target)
            result.actionCooldownStart, result.actionCooldownDuration, result.actionEnable = GetActionCooldown(actionSlot)
            result.actionUsable = IsUsableAction(actionSlot)
            result.actionSlot = actionSlot
            result.actionType = "macro"
            result.actionId = macro
            result.castTime = self.future:getGCD(atTime)
            return result
        end
        self.getActionSpellInfo = function(element, atTime, target)
            local spell = element.cachedParams.positional[1]
            if isNumber(spell) then
                return self:getSpellActionInfo(spell, element, atTime, target)
            elseif isString(spell) then
                local spellList = self.ovaleData.buffSpellList[spell]
                if spellList then
                    for spellId in pairs(spellList) do
                        if self.spellBook:isKnownSpell(spellId) then
                            return self:getSpellActionInfo(spellId, element, atTime, target)
                        end
                    end
                end
            end
            setResultType(element.result, "action")
            return element.result
        end
        self.getActionTextureInfo = function(element, atTime, target)
            local result = element.result
            setResultType(result, "action")
            result.actionTarget = target
            local actionTexture
            do
                local texture = element.cachedParams.positional[1]
                local spellId = tonumber(texture)
                if spellId then
                    actionTexture = GetSpellTexture(spellId)
                else
                    actionTexture = "Interface\\Icons\\" .. texture
                end
            end
            result.actionTexture = actionTexture
            result.actionInRange = false
            result.actionCooldownStart = 0
            result.actionCooldownDuration = 0
            result.actionEnable = true
            result.actionUsable = true
            result.actionSlot = nil
            result.actionType = "texture"
            result.actionId = actionTexture
            result.castTime = self.future:getGCD(atTime)
            return result
        end
        self.handleDisable = function()
            self.module:UnregisterMessage("Ovale_ScriptChanged")
        end
        self.module = ovale:createModule("BestAction", self.onInitialize, self.handleDisable, aceEvent)
        self.tracer = ovaleDebug:create(self.module:GetName())
        runner:registerActionInfoHandler("item", self.getActionItemInfo)
        runner:registerActionInfoHandler("macro", self.getActionMacroInfo)
        runner:registerActionInfoHandler("spell", self.getActionSpellInfo)
        runner:registerActionInfoHandler("texture", self.getActionTextureInfo)
    end,
    getSpellActionInfo = function(self, spellId, element, atTime, target)
        local targetGUID = self.guids:getUnitGUID(target)
        local result = element.result
        self.ovaleData:registerSpellAsked(spellId)
        local si = self.ovaleData.spellInfo[spellId]
        local replacedSpellId = nil
        if si then
            local replacementSpellId = self.ovaleData:resolveSpell(spellId, atTime, targetGUID)
            if replacementSpellId and replacementSpellId ~= spellId then
                replacedSpellId = spellId
                spellId = replacementSpellId
                si = self.ovaleData.spellInfo[spellId]
                self.tracer:log("Spell ID '%s' is replaced by spell ID '%s'.", replacedSpellId, spellId)
            end
        end
        local actionSlot = self.ovaleActionBar:getSpellActionSlot(spellId)
        if  not actionSlot and replacedSpellId then
            self.tracer:log("Action not found for spell ID '%s'; checking for replaced spell ID '%s'.", spellId, replacedSpellId)
            actionSlot = self.ovaleActionBar:getSpellActionSlot(replacedSpellId)
            if actionSlot then
                spellId = replacedSpellId
            end
        end
        local isKnownSpell = self.spellBook:isKnownSpell(spellId)
        if  not isKnownSpell and replacedSpellId then
            self.tracer:log("Spell ID '%s' is not known; checking for replaced spell ID '%s'.", spellId, replacedSpellId)
            isKnownSpell = self.spellBook:isKnownSpell(replacedSpellId)
            if isKnownSpell then
                spellId = replacedSpellId
            end
        end
        if  not isKnownSpell and  not actionSlot then
            setResultType(result, "none")
            self.tracer:log("Unknown spell ID '%s'.", spellId)
            return result
        end
        local isUsable, noMana = self.spells:isUsableSpell(spellId, atTime, targetGUID)
        self.tracer:log("OvaleSpells:IsUsableSpell(%d, %f, %s) returned %s, %s", spellId, atTime, targetGUID, isUsable, noMana)
        if  not isUsable and  not noMana then
            setResultType(result, "none")
            return result
        end
        setResultType(result, "action")
        if element.cachedParams.named.texture then
            result.actionTexture = "Interface\\Icons\\" .. element.cachedParams.named.texture
        else
            result.actionTexture = GetSpellTexture(spellId)
        end
        result.actionInRange = self.spells:isSpellInRange(spellId, target)
        result.actionCooldownStart, result.actionCooldownDuration, result.actionEnable = self.ovaleCooldown:getSpellCooldown(spellId, atTime)
        self.tracer:log("GetSpellCooldown returned %f, %f", result.actionCooldownStart, result.actionCooldownDuration)
        result.actionCharges = self.ovaleCooldown:getSpellCharges(spellId, atTime)
        result.actionResourceExtend = 0
        result.actionUsable = isUsable
        result.actionSlot = actionSlot
        result.actionType = "spell"
        result.actionId = spellId
        if si then
            if si.texture then
                result.actionTexture = "Interface\\Icons\\" .. si.texture
            end
            if result.actionCooldownStart and result.actionCooldownDuration then
                local timeToCd = (result.actionCooldownDuration > 0 and result.actionCooldownStart + result.actionCooldownDuration - atTime) or 0
                local timeToPower = self.spells:timeToPowerForSpell(spellId, atTime, targetGUID, nil, element.cachedParams.named)
                if timeToPower > timeToCd then
                    result.actionResourceExtend = timeToPower - timeToCd
                    self.tracer:log("Spell ID '%s' requires an extra %f seconds for power requirements.", spellId, result.actionResourceExtend)
                end
            end
            if si.casttime then
                result.castTime = si.casttime
            end
        end
        if  not si or  not si.casttime then
            result.castTime = self.spellBook:getCastTime(spellId)
        end
        result.actionTarget = target
        local offgcd = element.cachedParams.named.offgcd or self.ovaleData:getSpellInfoProperty(spellId, atTime, "offgcd", targetGUID) or 0
        result.offgcd = (offgcd == 1 and true) or nil
        return result
    end,
    startNewAction = function(self)
        self.runner:refresh()
    end,
    getAction = function(self, node, atTime)
        local groupNode = node.child[1]
        local element = self.runner:postOrderCompute(groupNode, atTime)
        if element.type == "state" and element.timeSpan:hasTime(atTime) then
            local variable, value = element.name, element.value
            local isFuture =  not element.timeSpan:hasTime(atTime)
            if variable ~= nil and value ~= nil then
                self.variables:putState(variable, value, isFuture, atTime)
            end
        end
        return element
    end,
})
