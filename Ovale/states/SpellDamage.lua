local __exports = LibStub:NewLibrary("ovale/states/SpellDamage", 90113)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
__exports.OvaleSpellDamageClass = __class(nil, {
    constructor = function(self, ovale, combatLogEvent)
        self.ovale = ovale
        self.combatLogEvent = combatLogEvent
        self.value = {}
        self.handleInitialize = function()
            self.combatLogEvent.registerEvent("SPELL_DAMAGE", self, self.handleCombatLogEvent)
            self.combatLogEvent.registerEvent("SPELL_PERIODIC_DAMAGE", self, self.handleCombatLogEvent)
        end
        self.handleDisable = function()
            self.combatLogEvent.unregisterAllEvents(self)
        end
        self.handleCombatLogEvent = function(cleuEvent)
            local cleu = self.combatLogEvent
            if cleu.sourceGUID == self.ovale.playerGUID then
                local spellId
                if cleu.header.type == "SPELL" then
                    local header = cleu.header
                    spellId = header.spellId
                elseif cleu.header.type == "SPELL_PERIODIC" then
                    local header = cleu.header
                    spellId = header.spellId
                end
                if spellId then
                    local payload = cleu.payload
                    self.value[spellId] = payload.amount
                    self.ovale:needRefresh()
                end
            end
        end
        ovale:createModule("OvaleSpellDamage", self.handleInitialize, self.handleDisable)
    end,
    getSpellDamage = function(self, spellId)
        return self.value[spellId]
    end,
})
