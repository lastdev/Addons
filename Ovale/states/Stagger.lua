local __exports = LibStub:NewLibrary("ovale/states/Stagger", 90047)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local UnitStagger = UnitStagger
local pairs = pairs
local insert = table.insert
local remove = table.remove
local __enginecondition = LibStub:GetLibrary("ovale/engine/condition")
local parseCondition = __enginecondition.parseCondition
local returnConstant = __enginecondition.returnConstant
local returnValueBetween = __enginecondition.returnValueBetween
local __toolstools = LibStub:GetLibrary("ovale/tools/tools")
local isNumber = __toolstools.isNumber
local lightStagger = 124275
local moderateStagger = 124274
local heavyStagger = 124273
local serial = 1
local maxLength = 30
__exports.OvaleStaggerClass = __class(nil, {
    constructor = function(self, ovale, combat, baseState, aura, health)
        self.ovale = ovale
        self.combat = combat
        self.baseState = baseState
        self.aura = aura
        self.health = health
        self.staggerTicks = {}
        self.handleInitialize = function()
            if self.ovale.playerClass == "MONK" then
                self.module:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", self.handleCombatLogEventUnfiltered)
            end
        end
        self.handleDisable = function()
            if self.ovale.playerClass == "MONK" then
                self.module:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
            end
        end
        self.handleCombatLogEventUnfiltered = function(event, ...)
            local _, cleuEvent, _, sourceGUID, _, _, _, _, _, _, _, spellId, _, _, amount = CombatLogGetCurrentEventInfo()
            if sourceGUID ~= self.ovale.playerGUID then
                return 
            end
            serial = serial + 1
            if cleuEvent == "SPELL_PERIODIC_DAMAGE" and spellId == 124255 then
                insert(self.staggerTicks, amount)
                if #self.staggerTicks > maxLength then
                    remove(self.staggerTicks, 1)
                end
            end
        end
        self.staggerRemaining = function(positionalParams, namedParams, atTime)
            local target = parseCondition(namedParams, self.baseState)
            return self:getAnyStaggerAura(target, atTime)
        end
        self.staggerPercent = function(positionalparameters, namedParams, atTime)
            local target = parseCondition(namedParams, self.baseState)
            local start, ending, value, origin, rate = self:getAnyStaggerAura(target, atTime)
            local healthMax = self.health:getUnitHealthMax(target)
            if value ~= nil and isNumber(value) then
                value = (value * 100) / healthMax
            end
            if rate ~= nil then
                rate = (rate * 100) / healthMax
            end
            return start, ending, value, origin, rate
        end
        self.missingStaggerPercent = function(positionalparameters, namedParams, atTime)
            local target = parseCondition(namedParams, self.baseState)
            local start, ending, value, origin, rate = self:getAnyStaggerAura(target, atTime)
            local healthMax = self.health:getUnitHealthMax(target)
            if value ~= nil and isNumber(value) then
                value = ((healthMax - value) * 100) / healthMax
            end
            if rate ~= nil then
                rate = -(rate * 100) / healthMax
            end
            return start, ending, value, origin, rate
        end
        self.staggerTick = function(positionalParams, namedParams, atTime)
            local count = positionalParams[1]
            local damage = self:lastTickDamage(count)
            return returnConstant(damage)
        end
        self.module = ovale:createModule("OvaleStagger", self.handleInitialize, self.handleDisable, aceEvent)
    end,
    registerConditions = function(self, ovaleCondition)
        ovaleCondition:registerCondition("staggerremaining", false, self.staggerRemaining)
        ovaleCondition:registerCondition("staggerremains", false, self.staggerRemaining)
        ovaleCondition:registerCondition("staggertick", false, self.staggerTick)
        ovaleCondition:registerCondition("staggerpercent", false, self.staggerPercent)
        ovaleCondition:registerCondition("staggermissingpercent", false, self.missingStaggerPercent)
    end,
    cleanState = function(self)
    end,
    initializeState = function(self)
    end,
    resetState = function(self)
        if  not self.combat:isInCombat(nil) then
            for k in pairs(self.staggerTicks) do
                self.staggerTicks[k] = nil
            end
        end
    end,
    lastTickDamage = function(self, countTicks)
        if  not countTicks or countTicks == 0 or countTicks < 0 then
            countTicks = 1
        end
        local damage = 0
        local arrLen = #self.staggerTicks
        if arrLen < 1 then
            return 0
        end
        for i = arrLen, arrLen - (countTicks - 1), -1 do
            damage = damage + (self.staggerTicks[i] or 0)
        end
        return damage
    end,
    getAnyStaggerAura = function(self, target, atTime)
        local aura = self.aura:getAura(target, heavyStagger, atTime, "HARMFUL")
        if  not aura or  not self.aura:isActiveAura(aura, atTime) then
            aura = self.aura:getAura(target, moderateStagger, atTime, "HARMFUL")
        end
        if  not aura or  not self.aura:isActiveAura(aura, atTime) then
            aura = self.aura:getAura(target, lightStagger, atTime, "HARMFUL")
        end
        if aura and self.aura:isActiveAura(aura, atTime) then
            local gain, start, ending = aura.gain, aura.start, aura.ending
            local stagger = UnitStagger(target)
            local rate = (-1 * stagger) / (ending - start)
            return returnValueBetween(gain, ending, 0, ending, rate)
        end
        return 
    end,
})
