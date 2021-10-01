local __exports = LibStub:NewLibrary("ovale/states/Stagger", 90108)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
__imports.__enginecondition = LibStub:GetLibrary("ovale/engine/condition")
__imports.returnConstant = __imports.__enginecondition.returnConstant
__imports.returnValueBetween = __imports.__enginecondition.returnValueBetween
__imports.__toolsQueue = LibStub:GetLibrary("ovale/tools/Queue")
__imports.Deque = __imports.__toolsQueue.Deque
__imports.__toolstools = LibStub:GetLibrary("ovale/tools/tools")
__imports.isNumber = __imports.__toolstools.isNumber
local UnitStagger = UnitStagger
local aceEvent = __imports.aceEvent
local pairs = pairs
local returnConstant = __imports.returnConstant
local returnValueBetween = __imports.returnValueBetween
local Deque = __imports.Deque
local isNumber = __imports.isNumber
local staggerAuraId = {
    [124273] = true,
    [124274] = true,
    [124275] = true
}
__exports.OvaleStaggerClass = __class(nil, {
    constructor = function(self, ovale, debug, aura, health, paperDoll, combatLogEvent)
        self.ovale = ovale
        self.aura = aura
        self.health = health
        self.paperDoll = paperDoll
        self.combatLogEvent = combatLogEvent
        self.staggerTicks = __imports.Deque(30, true)
        self.onEnable = function()
            if self.ovale.playerClass == "MONK" then
                self.module:RegisterMessage("Ovale_SpecializationChanged", self.onOvaleSpecializationChanged)
            end
            local specialization = self.paperDoll:getSpecialization()
            self.onOvaleSpecializationChanged("onEnable", specialization, specialization)
        end
        self.onDisable = function()
            if self.ovale.playerClass == "MONK" then
                self.module:UnregisterMessage("Ovale_SpecializationChanged")
                self.module:UnregisterMessage("Ovale_AuraRemoved")
                self.combatLogEvent.unregisterAllEvents(self)
                self.staggerTicks:clear()
            end
        end
        self.onOvaleSpecializationChanged = function(event, newSpecialization, oldSpecialization)
            if newSpecialization == "brewmaster" then
                self.tracer:debug("Installing stagger event handlers.")
                self.module:RegisterMessage("Ovale_AuraRemoved", self.onOvaleAuraRemoved)
                self.combatLogEvent.registerEvent("SPELL_PERIODIC_DAMAGE", self, self.onSpellPeriodicDamage)
            else
                self.tracer:debug("Removing stagger event handlers.")
                self.module:UnregisterMessage("Ovale_AuraRemoved")
                self.combatLogEvent.unregisterAllEvents(self)
                self.staggerTicks:clear()
            end
        end
        self.onOvaleAuraRemoved = function(event, atTime, guid, auraId, caster)
            if staggerAuraId[auraId] then
                local stagger = UnitStagger("player")
                if stagger == 0 then
                    self.tracer:debug("Empty stagger pool; clearing ticks.")
                    self.staggerTicks:clear()
                end
            end
        end
        self.onSpellPeriodicDamage = function(cleuEvent)
            local cleu = self.combatLogEvent
            if cleu.sourceGUID == self.ovale.playerGUID then
                local header = cleu.header
                if header.spellId == 124255 then
                    local payload = cleu.payload
                    local amount = payload.amount
                    self.tracer:debug("stagger tick " .. amount .. " (" .. self.staggerTicks.length .. ")")
                    self.staggerTicks:push(amount)
                end
            end
        end
        self.staggerRemaining = function(positionalParams, namedParams, atTime)
            local aura = self:getAnyStaggerAura(atTime)
            if aura then
                local gain, start, ending = aura.gain, aura.start, aura.ending
                local stagger = UnitStagger("player")
                local rate = (-1 * stagger) / (ending - start)
                return returnValueBetween(gain, ending, 0, ending, rate)
            end
            return 
        end
        self.staggerPercent = function(positionalparameters, namedParams, atTime)
            local start, ending, value, origin, rate = self.staggerRemaining(positionalparameters, namedParams, atTime)
            local healthMax = self.health:getUnitHealthMax("player")
            if value and isNumber(value) then
                value = (value * 100) / healthMax
            end
            if rate then
                rate = (rate * 100) / healthMax
            end
            return start, ending, value, origin, rate
        end
        self.missingStaggerPercent = function(positionalparameters, namedParams, atTime)
            local start, ending, value, origin, rate = self.staggerRemaining(positionalparameters, namedParams, atTime)
            local healthMax = self.health:getUnitHealthMax("player")
            if value and isNumber(value) then
                value = ((healthMax - value) * 100) / healthMax
            end
            if rate then
                rate = -(rate * 100) / healthMax
            end
            return start, ending, value, origin, rate
        end
        self.staggerTick = function(positionalParams, namedParams, atTime)
            local count = positionalParams[1]
            local damage = self:lastTickDamage(count)
            return returnConstant(damage)
        end
        self.module = ovale:createModule("OvaleStagger", self.onEnable, self.onDisable, aceEvent)
        self.tracer = debug:create(self.module:GetName())
    end,
    getAnyStaggerAura = function(self, atTime)
        for auraId in pairs(staggerAuraId) do
            local aura = self.aura:getAura("player", auraId, atTime, "HARMFUL")
            if aura and self.aura:isActiveAura(aura, atTime) then
                return aura
            end
        end
        return nil
    end,
    lastTickDamage = function(self, countTicks)
        if  not countTicks or countTicks == 0 or countTicks < 0 then
            countTicks = 1
        end
        local damage = 0
        local queue = self.staggerTicks
        for i = queue.length, 1, -1 do
            if countTicks > 0 then
                local amount = queue:at(i) or 0
                damage = damage + amount
                countTicks = countTicks - 1
            end
        end
        return damage
    end,
    registerConditions = function(self, ovaleCondition)
        ovaleCondition:registerCondition("staggerremaining", false, self.staggerRemaining)
        ovaleCondition:registerCondition("staggerremains", false, self.staggerRemaining)
        ovaleCondition:registerCondition("staggertick", false, self.staggerTick)
        ovaleCondition:registerCondition("staggerpercent", false, self.staggerPercent)
        ovaleCondition:registerCondition("staggermissingpercent", false, self.missingStaggerPercent)
    end,
})
