local __exports = LibStub:NewLibrary("ovale/states/DemonHunterDemonic", 90047)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local GetSpecialization = GetSpecialization
local GetSpecializationInfo = GetSpecializationInfo
local GetTime = GetTime
local GetTalentInfoByID = GetTalentInfoByID
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local huge = math.huge
local select = select
local infinity = huge
local havocDemonicTalentId = 22547
local havocSpecId = 577
local havocEyeBeamSpellId = 198013
local havocMetaBuffId = 162264
local hiddenBuffId = -havocDemonicTalentId
local hiddenBuffDuration = infinity
local hiddenBuffExtendedByDemonic = "Extended by Demonic"
__exports.OvaleDemonHunterDemonicClass = __class(nil, {
    constructor = function(self, ovaleAura, ovale, ovaleDebug)
        self.ovaleAura = ovaleAura
        self.ovale = ovale
        self.isDemonHunter = false
        self.handleInitialize = function()
            self.isDemonHunter = (self.ovale.playerClass == "DEMONHUNTER" and true) or false
            if self.isDemonHunter then
                self.debug:debug("playerGUID: (%s)", self.ovale.playerGUID)
                self.module:RegisterMessage("Ovale_TalentsChanged", self.handleTalentsChanged)
            end
        end
        self.handleDisable = function()
            self.module:UnregisterMessage("Ovale_TalentsChanged")
        end
        self.handleTalentsChanged = function(event)
            self.isHavoc = (self.isDemonHunter and GetSpecializationInfo(GetSpecialization()) == havocSpecId and true) or false
            self.hasDemonic = (self.isHavoc and select(10, GetTalentInfoByID(havocDemonicTalentId, havocSpecId)) and true) or false
            if self.isHavoc and self.hasDemonic then
                self.debug:debug("We are a havoc DH with Demonic.")
                self.module:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
            else
                if  not self.isHavoc then
                    self.debug:debug("We are not a havoc DH.")
                elseif  not self.hasDemonic then
                    self.debug:debug("We don't have the Demonic talent.")
                end
                self:dropAura()
                self.module:UnregisterMessage("COMBAT_LOG_EVENT_UNFILTERED")
            end
        end
        self.module = ovale:createModule("OvaleDemonHunterDemonic", self.handleInitialize, self.handleDisable, aceEvent)
        self.debug = ovaleDebug:create(self.module:GetName())
        self.playerGUID = self.ovale.playerGUID
        self.isHavoc = false
        self.hasDemonic = false
    end,
    handleCombatLogEventUnfiltered = function(self, event, ...)
        local _, cleuEvent, _, sourceGUID, _, _, _, _, _, _, _, arg12, arg13 = CombatLogGetCurrentEventInfo()
        if sourceGUID == self.playerGUID and cleuEvent == "SPELL_CAST_SUCCESS" then
            local spellId, spellName = arg12, arg13
            if havocEyeBeamSpellId == spellId then
                self.debug:debug("Spell %d (%s) has successfully been cast. Gaining Aura (only during meta).", spellId, spellName)
                self:gainAura()
            end
        end
        if sourceGUID == self.playerGUID and cleuEvent == "SPELL_AURA_REMOVED" then
            local spellId, spellName = arg12, arg13
            if havocMetaBuffId == spellId then
                self.debug:debug("Aura %d (%s) is removed. Dropping Aura.", spellId, spellName)
                self:dropAura()
            end
        end
    end,
    gainAura = function(self)
        local now = GetTime()
        local auraMeta = self.ovaleAura:getAura("player", havocMetaBuffId, now, "HELPFUL", true)
        if auraMeta and self.ovaleAura:isActiveAura(auraMeta, now) then
            self.debug:debug("Adding '%s' (%d) buff to player %s.", hiddenBuffExtendedByDemonic, hiddenBuffId, self.playerGUID)
            local duration = hiddenBuffDuration
            local ending = now + hiddenBuffDuration
            self.ovaleAura:gainedAuraOnGUID(self.playerGUID, now, hiddenBuffId, self.playerGUID, "HELPFUL", false, nil, 1, nil, duration, ending, false, hiddenBuffExtendedByDemonic, nil, nil, nil)
        else
            self.debug:debug("Aura 'Metamorphosis' (%d) is not present.", havocMetaBuffId)
        end
    end,
    dropAura = function(self)
        local now = GetTime()
        self.debug:debug("Removing '%s' (%d) buff on player %s.", hiddenBuffExtendedByDemonic, hiddenBuffId, self.playerGUID)
        self.ovaleAura:lostAuraOnGUID(self.playerGUID, now, hiddenBuffId, self.playerGUID)
    end,
})
