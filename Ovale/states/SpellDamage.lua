local __exports = LibStub:NewLibrary("ovale/states/SpellDamage", 90103)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local combatLogDamageEvents = {
    SPELL_DAMAGE = true,
    SPELL_PERIODIC_AURA = true
}
__exports.OvaleSpellDamageClass = __class(nil, {
    constructor = function(self, ovale, ovaleProfiler)
        self.ovale = ovale
        self.value = {}
        self.handleInitialize = function()
            self.module:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", self.handleCombatLogEventUnfiltered)
        end
        self.handleDisable = function()
            self.module:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        end
        self.handleCombatLogEventUnfiltered = function(event, ...)
            local _, cleuEvent, _, sourceGUID, _, _, _, _, _, _, _, arg12, _, _, arg15 = CombatLogGetCurrentEventInfo()
            if sourceGUID == self.ovale.playerGUID then
                self.profiler:startProfiling("OvaleSpellDamage_COMBAT_LOG_EVENT_UNFILTERED")
                if combatLogDamageEvents[cleuEvent] then
                    local spellId, amount = arg12, arg15
                    self.value[spellId] = amount
                    self.ovale:needRefresh()
                end
                self.profiler:stopProfiling("OvaleSpellDamage_COMBAT_LOG_EVENT_UNFILTERED")
            end
        end
        self.module = ovale:createModule("OvaleSpellDamage", self.handleInitialize, self.handleDisable, aceEvent)
        self.profiler = ovaleProfiler:create(self.module:GetName())
    end,
    getSpellDamage = function(self, spellId)
        return self.value[spellId]
    end,
})
