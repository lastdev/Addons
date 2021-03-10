local __exports = LibStub:NewLibrary("ovale/states/DemonHunterSigils", 90047)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local ipairs = ipairs
local tonumber = tonumber
local insert = table.insert
local remove = table.remove
local GetTime = GetTime
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local updateDelay = 0.5
local sigilActivationTime = 2
local activatedSigils = {}
local sigilStart = {
    [204513] = {
        type = "flame"
    },
    [204596] = {
        type = "flame"
    },
    [189110] = {
        type = "flame",
        talent = 22502
    },
    [202137] = {
        type = "silence"
    },
    [207684] = {
        type = "misery"
    },
    [202138] = {
        type = "chains"
    }
}
local sigilEnd = {
    [204598] = {
        type = "flame"
    },
    [204490] = {
        type = "silence"
    },
    [207685] = {
        type = "misery"
    },
    [204834] = {
        type = "chains"
    }
}
__exports.OvaleSigilClass = __class(nil, {
    constructor = function(self, ovalePaperDoll, ovale, ovaleSpellBook)
        self.ovalePaperDoll = ovalePaperDoll
        self.ovale = ovale
        self.ovaleSpellBook = ovaleSpellBook
        self.handleInitialize = function()
            if self.ovale.playerClass == "DEMONHUNTER" then
                self.module:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", self.handleUnitSpellCastSucceeded)
                self.module:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", self.handleCombatLogEventUnfiltered)
            end
        end
        self.handleDisable = function()
            if self.ovale.playerClass == "DEMONHUNTER" then
                self.module:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
                self.module:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
            end
        end
        self.handleCombatLogEventUnfiltered = function(event, ...)
            if  not self.ovalePaperDoll:isSpecialization("vengeance") then
                return 
            end
            local _, cleuEvent, _, sourceGUID, _, _, _, _, _, _, _, spellid = CombatLogGetCurrentEventInfo()
            if sourceGUID == self.ovale.playerGUID and cleuEvent == "SPELL_AURA_APPLIED" then
                if sigilEnd[spellid] ~= nil then
                    local s = sigilEnd[spellid]
                    local t = s.type
                    remove(activatedSigils[t], 1)
                end
            end
        end
        self.handleUnitSpellCastSucceeded = function(event, unitId, guid, spellId, ...)
            if  not self.ovalePaperDoll:isSpecialization("vengeance") then
                return 
            end
            if unitId == nil or unitId ~= "player" then
                return 
            end
            local id = tonumber(spellId)
            if sigilStart[id] ~= nil then
                local s = sigilStart[id]
                local t = s.type
                local tal = s.talent or nil
                if tal == nil or self.ovaleSpellBook:getTalentPoints(tal) > 0 then
                    insert(activatedSigils[t], GetTime())
                end
            end
        end
        self.module = ovale:createModule("OvaleSigil", self.handleInitialize, self.handleDisable, aceEvent)
        activatedSigils["flame"] = {}
        activatedSigils["silence"] = {}
        activatedSigils["misery"] = {}
        activatedSigils["chains"] = {}
    end,
    isSigilCharging = function(self, type, atTime)
        if #activatedSigils[type] == 0 then
            return false
        end
        local charging = false
        for _, v in ipairs(activatedSigils[type]) do
            local activationTime = sigilActivationTime + updateDelay
            if self.ovaleSpellBook:getTalentPoints(22510) > 0 then
                activationTime = activationTime - 1
            end
            charging = charging or atTime < v + activationTime
        end
        return charging
    end,
    cleanState = function(self)
    end,
    initializeState = function(self)
    end,
    resetState = function(self)
    end,
})
