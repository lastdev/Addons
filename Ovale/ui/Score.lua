local __exports = LibStub:NewLibrary("ovale/ui/Score", 90113)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.__Ovale = LibStub:GetLibrary("ovale/Ovale")
__imports.messagePrefix = __imports.__Ovale.messagePrefix
__imports.aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
__imports.aceSerializer = LibStub:GetLibrary("AceSerializer-3.0", true)
local messagePrefix = __imports.messagePrefix
local aceEvent = __imports.aceEvent
local aceSerializer = __imports.aceSerializer
local pairs = pairs
local IsInGroup = IsInGroup
local SendAddonMessage = SendAddonMessage
local LE_PARTY_CATEGORY_INSTANCE = LE_PARTY_CATEGORY_INSTANCE
local GetTime = GetTime
local UnitCastingInfo = UnitCastingInfo
local UnitChannelInfo = UnitChannelInfo
__exports.OvaleScoreClass = __class(nil, {
    constructor = function(self, ovale, ovaleFuture, ovaleDebug, ovaleSpellBook, combat)
        self.ovale = ovale
        self.ovaleFuture = ovaleFuture
        self.ovaleSpellBook = ovaleSpellBook
        self.combat = combat
        self.damageMeterMethod = {}
        self.score = 0
        self.maxScore = 0
        self.scoredSpell = {}
        self.handleInitialize = function()
            self.module:RegisterEvent("CHAT_MSG_ADDON", self.handleChatMsgAddon)
            self.module:RegisterEvent("PLAYER_REGEN_ENABLED", self.handlePlayerRegenEnabled)
            self.module:RegisterEvent("PLAYER_REGEN_DISABLED", self.handlePlayerRegenDisabled)
            self.module:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START", self.handleUnitSpellCastChannelStart)
            self.module:RegisterEvent("UNIT_SPELLCAST_START", self.handleUnitSpellCastStart)
        end
        self.handleDisable = function()
            self.module:UnregisterEvent("CHAT_MSG_ADDON")
            self.module:UnregisterEvent("PLAYER_REGEN_ENABLED")
            self.module:UnregisterEvent("PLAYER_REGEN_DISABLED")
            self.module:UnregisterEvent("UNIT_SPELLCAST_START")
        end
        self.handleChatMsgAddon = function(event, prefix, message, _, sender)
            if prefix == messagePrefix then
                local ok, msgType, scored, scoreMax, guid = self.module:Deserialize(message)
                if ok and msgType == "S" then
                    self:sendScore(sender, guid, scored, scoreMax)
                end
            end
        end
        self.handlePlayerRegenEnabled = function()
            if self.maxScore > 0 and IsInGroup() then
                local message = self.module:Serialize("score", self.score, self.maxScore, self.ovale.playerGUID)
                local channel = (IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT") or "RAID"
                SendAddonMessage(messagePrefix, message, channel)
            end
        end
        self.handlePlayerRegenDisabled = function()
            self.score = 0
            self.maxScore = 0
        end
        self.handleUnitSpellCastChannelStart = function(event, unitId, lineId, spellId)
            if unitId == "player" or unitId == "pet" then
                local now = GetTime()
                local spell = self.ovaleSpellBook:getSpellName(spellId)
                if spell then
                    local spellcast = self.ovaleFuture:getSpellcast(spell, spellId, nil, now)
                    if spellcast then
                        local name = UnitChannelInfo(unitId)
                        if name == spell then
                            self:scoreSpell(spellId)
                        end
                    end
                end
            end
        end
        self.handleUnitSpellCastStart = function(event, unitId, lineId, spellId)
            if unitId == "player" or unitId == "pet" then
                local spell = self.ovaleSpellBook:getSpellName(spellId)
                if spell then
                    local now = GetTime()
                    local spellcast = self.ovaleFuture:getSpellcast(spell, spellId, lineId, now)
                    if spellcast then
                        local name, _, _, _, _, _, castId = UnitCastingInfo(unitId)
                        if lineId == castId and name == spell then
                            self:scoreSpell(spellId)
                        end
                    end
                end
            end
        end
        self.module = ovale:createModule("OvaleScore", self.handleInitialize, self.handleDisable, aceEvent, aceSerializer)
        self.tracer = ovaleDebug:create(self.module:GetName())
    end,
    registerDamageMeter = function(self, moduleName, func)
        self.damageMeterMethod[moduleName] = func
    end,
    unregisterDamageMeter = function(self, moduleName)
        self.damageMeterMethod[moduleName] = nil
    end,
    addSpell = function(self, spellId)
        self.scoredSpell[spellId] = true
    end,
    scoreSpell = function(self, spellId)
        if self.combat:isInCombat(nil) and self.scoredSpell[spellId] then
            local scored = 0
            self.tracer:debugTimestamp("Scored %s for %d.", scored, spellId)
            if scored then
                self.score = self.score + scored
                self.maxScore = self.maxScore + 1
                self:sendScore(self.module:GetName(), self.ovale.playerGUID, scored, 1)
            end
        end
    end,
    sendScore = function(self, name, guid, scored, scoreMax)
        for _, method in pairs(self.damageMeterMethod) do
            method(name, guid, scored, scoreMax)
        end
    end,
})
