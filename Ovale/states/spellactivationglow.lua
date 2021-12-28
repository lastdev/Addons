local __exports = LibStub:NewLibrary("ovale/states/spellactivationglow", 90113)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
__imports.__enginecondition = LibStub:GetLibrary("ovale/engine/condition")
__imports.returnBoolean = __imports.__enginecondition.returnBoolean
local aceEvent = __imports.aceEvent
local returnBoolean = __imports.returnBoolean
local GetSpellInfo = GetSpellInfo
__exports.SpellActivationGlow = __class(nil, {
    constructor = function(self, ovale, ovaleDebug)
        self.spellActivationSpellsShown = {}
        self.handleInitialize = function()
            self.module:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW", self.handleSpellActivationOverlayGlow)
            self.module:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE", self.handleSpellActivationOverlayGlow)
        end
        self.handleDisable = function()
            self.module:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
            self.module:UnregisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
        end
        self.handleSpellActivationOverlayGlow = function(event, spellId)
            local spellName = GetSpellInfo(spellId)
            self.debug:debug("Event %s with spellId %d (%s)", event, spellId, spellName)
            self.spellActivationSpellsShown[spellId] = event == "SPELL_ACTIVATION_OVERLAY_GLOW_SHOW" or false
        end
        self.spellActivationGlowActive = function(positionalParams, namedParams, atTime)
            local spellId = positionalParams[1]
            local retValue = self:hasSpellActivationGlow(spellId) or false
            return returnBoolean(retValue)
        end
        self.module = ovale:createModule("SpellActivationGlow", self.handleInitialize, self.handleDisable, aceEvent)
        self.debug = ovaleDebug:create("SpellActivationGlow")
    end,
    hasSpellActivationGlow = function(self, spellId)
        return self.spellActivationSpellsShown[spellId] or false
    end,
    registerConditions = function(self, ovaleCondition)
        ovaleCondition:registerCondition("spellactivationglowactive", false, self.spellActivationGlowActive)
        ovaleCondition:registerAlias("spellactivationglowactive", "spellactivationglowshown")
    end,
})
