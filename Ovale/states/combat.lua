local __exports = LibStub:NewLibrary("ovale/states/combat", 90048)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __enginestate = LibStub:GetLibrary("ovale/engine/state")
local States = __enginestate.States
local aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local GetTime = GetTime
local __enginecondition = LibStub:GetLibrary("ovale/engine/condition")
local returnBoolean = __enginecondition.returnBoolean
local returnConstant = __enginecondition.returnConstant
local returnValueBetween = __enginecondition.returnValueBetween
local INFINITY = math.huge
__exports.CombatState = __class(nil, {
    constructor = function(self)
        self.inCombat = false
        self.combatStartTime = 0
    end
})
__exports.OvaleCombatClass = __class(States, {
    constructor = function(self, ovale, debug, ovaleSpellBook)
        self.ovale = ovale
        self.ovaleSpellBook = ovaleSpellBook
        self.applySpellOnHit = function(spellId, targetGUID, startCast, endCast, channel)
            if  not self.next.inCombat and self.ovaleSpellBook:isHarmfulSpell(spellId) then
                self.next.inCombat = true
                if channel then
                    self.next.combatStartTime = startCast
                else
                    self.next.combatStartTime = endCast
                end
            end
        end
        self.onInitialize = function()
            self.module:RegisterEvent("PLAYER_REGEN_DISABLED", self.handlePlayerRegenDisabled)
            self.module:RegisterEvent("PLAYER_REGEN_ENABLED", self.handlePlayerRegenEnabled)
        end
        self.onRelease = function()
            self.module:UnregisterEvent("PLAYER_REGEN_DISABLED")
            self.module:UnregisterEvent("PLAYER_REGEN_ENABLED")
        end
        self.handlePlayerRegenDisabled = function(event)
            self.tracer:debug(event, "Entering combat.")
            local now = GetTime()
            self.current.inCombat = true
            self.current.combatStartTime = now
            self.ovale:needRefresh()
            self.module:SendMessage("Ovale_CombatStarted", now)
        end
        self.handlePlayerRegenEnabled = function(event)
            self.tracer:debug(event, "Leaving combat.")
            local now = GetTime()
            self.current.inCombat = false
            self.ovale:needRefresh()
            self.module:SendMessage("Ovale_CombatEnded", now)
        end
        self.inCombat = function(positionalParams, namedParams, atTime)
            local boolean = self:isInCombat(atTime)
            return returnBoolean(boolean)
        end
        self.timeInCombat = function(positionalParams, namedParams, atTime)
            if self:isInCombat(atTime) then
                local state = self:getState(atTime)
                local start = state.combatStartTime
                return returnValueBetween(start, INFINITY, 0, start, 1)
            end
            return returnConstant(0)
        end
        self.expectedCombatLength = function(positional, named, atTime)
            return returnConstant(15 * 60)
        end
        self.fightRemains = function()
            return returnConstant(15 * 60)
        end
        States.constructor(self, __exports.CombatState)
        self.module = ovale:createModule("Combat", self.onInitialize, self.onRelease, aceEvent)
        self.tracer = debug:create("OvaleCombat")
    end,
    registerConditions = function(self, condition)
        condition:registerCondition("incombat", false, self.inCombat)
        condition:registerCondition("timeincombat", false, self.timeInCombat)
        condition:registerCondition("expectedcombatlength", false, self.expectedCombatLength)
        condition:registerCondition("fightremains", false, self.fightRemains)
    end,
    isInCombat = function(self, atTime)
        return self:getState(atTime).inCombat
    end,
    initializeState = function(self)
    end,
    resetState = function(self)
        self.next.inCombat = self.current.inCombat
        self.next.combatStartTime = self.current.combatStartTime or 0
    end,
    cleanState = function(self)
    end,
})
