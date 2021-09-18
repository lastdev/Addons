local __exports = LibStub:NewLibrary("ovale/states/Health", 90107)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
__imports.__toolstools = LibStub:GetLibrary("ovale/tools/tools")
__imports.oneTimeMessage = __imports.__toolstools.oneTimeMessage
local aceEvent = __imports.aceEvent
local pairs = pairs
local wipe = wipe
local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax
local UnitGetTotalAbsorbs = UnitGetTotalAbsorbs
local UnitGetTotalHealAbsorbs = UnitGetTotalHealAbsorbs
local infinity = math.huge
local oneTimeMessage = __imports.oneTimeMessage
local healthEvent = {
    DAMAGE_SHIELD = true,
    DAMAGE_SPLIT = true,
    ENVIRONMENTAL_DAMAGE = true,
    RANGE_DAMAGE = true,
    SPELL_BUILDING_DAMAGE = true,
    SPELL_DAMAGE = true,
    SPELL_HEAL = true,
    SPELL_PERIODIC_DAMAGE = true,
    SPELL_PERIODIC_HEAL = true,
    SWING_DAMAGE = true
}
__exports.OvaleHealthClass = __class(nil, {
    constructor = function(self, ovaleGuid, ovale, ovaleOptions, ovaleDebug, combatLogEvent)
        self.ovaleGuid = ovaleGuid
        self.ovaleOptions = ovaleOptions
        self.combatLogEvent = combatLogEvent
        self.health = {}
        self.maxHealth = {}
        self.absorb = {}
        self.healAbsorb = {}
        self.totalDamage = {}
        self.totalHealing = {}
        self.firstSeen = {}
        self.lastUpdated = {}
        self.handleInitialize = function()
            self.module:RegisterEvent("PLAYER_REGEN_DISABLED", self.handlePlayerRegenDisabled)
            self.module:RegisterEvent("PLAYER_REGEN_ENABLED", self.handlePlayerRegenEnabled)
            if self.ovaleOptions.db.profile.apparence.frequentHealthUpdates then
                self.module:RegisterEvent("UNIT_HEALTH", self.handleUpdateHealth)
            else
                self.module:RegisterEvent("UNIT_HEALTH", self.handleUpdateHealth)
            end
            self.module:RegisterEvent("UNIT_MAXHEALTH", self.handleUpdateHealth)
            self.module:RegisterEvent("UNIT_ABSORB_AMOUNT_CHANGED", self.handleUpdateAbsorb)
            self.module:RegisterEvent("UNIT_HEAL_ABSORB_AMOUNT_CHANGED", self.handleUpdateAbsorb)
            self.module:RegisterMessage("Ovale_UnitChanged", self.handleUnitChanged)
        end
        self.handleDisable = function()
            self.module:UnregisterEvent("PLAYER_REGEN_ENABLED")
            self.module:UnregisterEvent("PLAYER_TARGET_CHANGED")
            self.module:UnregisterEvent("UNIT_HEALTH")
            self.module:UnregisterEvent("UNIT_HEALTH")
            self.module:UnregisterEvent("UNIT_MAXHEALTH")
            self.module:UnregisterEvent("UNIT_ABSORB_AMOUNT_CHANGED")
            self.module:UnregisterEvent("UNIT_HEAL_ABSORB_AMOUNT_CHANGED")
            self.module:UnregisterMessage("Ovale_UnitChanged")
        end
        self.handleCombatLogEvent = function(cleuEvent)
            if  not healthEvent[cleuEvent] then
                return 
            end
            local cleu = self.combatLogEvent
            local timestamp = cleu.timestamp
            local destGUID = cleu.destGUID
            local destName = cleu.destName
            local healthUpdate = false
            if cleu.payload.type == "DAMAGE" then
                local payload = cleu.payload
                local amount = payload.amount
                self.tracer:debug(cleuEvent, destGUID, destName, amount)
                local total = self.totalDamage[destGUID] or 0
                self.totalDamage[destGUID] = total + amount
                healthUpdate = true
            elseif cleu.payload.type == "HEAL" then
                local payload = cleu.payload
                local amount = payload.amount
                self.tracer:debug(cleuEvent, destGUID, destName, amount)
                local total = self.totalHealing[destGUID] or 0
                self.totalHealing[destGUID] = total + amount
                healthUpdate = true
            end
            if healthUpdate then
                if  not self.firstSeen[destGUID] then
                    self.firstSeen[destGUID] = timestamp
                end
                self.lastUpdated[destGUID] = timestamp
            end
        end
        self.handlePlayerRegenDisabled = function(event)
            for event in pairs(healthEvent) do
                self.combatLogEvent.registerEvent(event, self, self.handleCombatLogEvent)
            end
        end
        self.handlePlayerRegenEnabled = function(event)
            self.combatLogEvent.unregisterAllEvents(self)
            wipe(self.totalDamage)
            wipe(self.totalHealing)
            wipe(self.firstSeen)
            wipe(self.lastUpdated)
        end
        self.handleUnitChanged = function(event, unitId, guid)
            if unitId == "target" or unitId == "focus" then
                self.tracer:debug(event, unitId, guid)
                self.handleUpdateHealth("UNIT_HEALTH", unitId)
                self.handleUpdateHealth("UNIT_MAXHEALTH", unitId)
                self.handleUpdateAbsorb("UNIT_ABSORB_AMOUNT_CHANGED", unitId)
                self.handleUpdateAbsorb("UNIT_HEAL_ABSORB_AMOUNT_CHANGED", unitId)
            end
        end
        self.handleUpdateAbsorb = function(event, unitId)
            if  not unitId then
                return 
            end
            local func
            local db
            if event == "UNIT_ABSORB_AMOUNT_CHANGED" then
                func = UnitGetTotalAbsorbs
                db = self.absorb
            elseif event == "UNIT_HEAL_ABSORB_AMOUNT_CHANGED" then
                func = UnitGetTotalHealAbsorbs
                db = self.absorb
            else
                oneTimeMessage("Warning: Invalid event (%s) in UpdateAbsorb.", event)
                return 
            end
            local amount = func(unitId)
            if amount >= 0 then
                local guid = self.ovaleGuid:getUnitGUID(unitId)
                self.tracer:debug(event, unitId, guid, amount)
                if guid then
                    db[guid] = amount
                end
            end
        end
        self.handleUpdateHealth = function(event, unitId)
            if  not unitId then
                return 
            end
            local func
            local db
            if event == "UNIT_HEALTH" then
                func = UnitHealth
                db = self.health
            elseif event == "UNIT_MAXHEALTH" then
                func = UnitHealthMax
                db = self.maxHealth
            else
                oneTimeMessage("Warning: Invalid event (%s) in UpdateHealth.", event)
                return 
            end
            local amount = func(unitId)
            if amount then
                local guid = self.ovaleGuid:getUnitGUID(unitId)
                self.tracer:debug(event, unitId, guid, amount)
                if guid then
                    if amount > 0 then
                        db[guid] = amount
                    else
                        db[guid] = nil
                        self.firstSeen[guid] = nil
                        self.lastUpdated[guid] = nil
                    end
                end
            end
        end
        self.module = ovale:createModule("OvaleHealth", self.handleInitialize, self.handleDisable, aceEvent)
        self.tracer = ovaleDebug:create(self.module:GetName())
    end,
    getUnitHealth = function(self, unitId, guid)
        return self:getUnitAmount(UnitHealth, self.health, unitId, guid)
    end,
    getUnitHealthMax = function(self, unitId, guid)
        return self:getUnitAmount(UnitHealthMax, self.maxHealth, unitId, guid)
    end,
    getUnitAbsorb = function(self, unitId, guid)
        return self:getUnitAmount(UnitGetTotalAbsorbs, self.absorb, unitId, guid)
    end,
    getUnitHealAbsorb = function(self, unitId, guid)
        return self:getUnitAmount(UnitGetTotalHealAbsorbs, self.healAbsorb, unitId, guid)
    end,
    getUnitAmount = function(self, func, db, unitId, guid)
        local amount
        if unitId then
            guid = guid or self.ovaleGuid:getUnitGUID(unitId)
            if guid then
                if (unitId == "focus" or unitId == "target") and db[guid] ~= nil then
                    amount = db[guid]
                else
                    amount = func(unitId)
                    if amount ~= nil then
                        db[guid] = amount
                    else
                        amount = 0
                    end
                end
            else
                amount = 0
            end
        else
            amount = 0
        end
        return amount
    end,
    getUnitTimeToDie = function(self, unitId, effectiveHealth, guid)
        local timeToDie = infinity
        guid = guid or self.ovaleGuid:getUnitGUID(unitId)
        if guid then
            local health = self:getUnitHealth(unitId, guid) or 0
            if effectiveHealth then
                health = health + self:getUnitAbsorb(unitId, guid) - self:getUnitHealAbsorb(unitId, guid)
            end
            local maxHealth = self:getUnitHealthMax(unitId, guid)
            if health and maxHealth > 0 then
                if health == 0 then
                    timeToDie = 0
                    self.firstSeen[guid] = nil
                    self.lastUpdated[guid] = nil
                elseif maxHealth > 5 then
                    local firstSeen, lastUpdated = self.firstSeen[guid], self.lastUpdated[guid]
                    local damage = self.totalDamage[guid] or 0
                    local healing = self.totalHealing[guid] or 0
                    if firstSeen and lastUpdated and lastUpdated > firstSeen and damage > healing then
                        timeToDie = (health * (lastUpdated - firstSeen)) / (damage - healing)
                    end
                end
            end
        end
        return timeToDie
    end,
    cleanState = function(self)
    end,
    initializeState = function(self)
    end,
    resetState = function(self)
    end,
})
