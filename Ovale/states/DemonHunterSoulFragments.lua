local __exports = LibStub:NewLibrary("ovale/states/DemonHunterSoulFragments", 90048)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local GetTime = GetTime
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local soulFragmentsBuffId = 203981
local metamorphosisBuffId = 187827
local soulFragmentSpells = {
    [225919] = 2,
    [203782] = 1,
    [228477] = -2
}
local soulFragmentFinishers = {
    [247454] = true,
    [263648] = true
}
__exports.OvaleDemonHunterSoulFragmentsClass = __class(nil, {
    constructor = function(self, ovaleAura, ovale, ovalePaperDoll)
        self.ovaleAura = ovaleAura
        self.ovale = ovale
        self.ovalePaperDoll = ovalePaperDoll
        self.estimatedCount = 0
        self.handleInitialize = function()
            if self.ovale.playerClass == "DEMONHUNTER" then
                self.module:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", self.handleCombatLogEventUnfiltered)
            end
        end
        self.handleDisable = function()
            if self.ovale.playerClass == "DEMONHUNTER" then
                self.module:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
            end
        end
        self.handleCombatLogEventUnfiltered = function(event, ...)
            if  not self.ovalePaperDoll:isSpecialization("vengeance") then
                return 
            end
            local _, subtype, _, sourceGUID, _, _, _, _, _, _, _, spellID = CombatLogGetCurrentEventInfo()
            local me = self.ovale.playerGUID
            if sourceGUID == me then
                if subtype == "SPELL_CAST_SUCCESS" and soulFragmentSpells[spellID] then
                    local getTime = GetTime()
                    local fragments = soulFragmentSpells[spellID]
                    if fragments > 0 and self:hasMetamorphosis(getTime) then
                        fragments = fragments + 1
                    end
                    self:addPredictedSoulFragments(getTime, fragments)
                end
                if subtype == "SPELL_CAST_SUCCESS" and soulFragmentFinishers[spellID] then
                    self:setPredictedSoulFragment(GetTime(), 0)
                end
            end
        end
        self.module = ovale:createModule("OvaleDemonHunterSoulFragments", self.handleInitialize, self.handleDisable, aceEvent)
    end,
    addPredictedSoulFragments = function(self, atTime, added)
        local currentCount = self:getSoulFragmentsBuffStacks(atTime) or 0
        self:setPredictedSoulFragment(atTime, currentCount + added)
    end,
    setPredictedSoulFragment = function(self, atTime, count)
        self.estimatedCount = (count < 0 and 0) or (count > 5 and 5) or count
        self.atTime = atTime
        self.estimated = true
    end,
    soulFragments = function(self, atTime)
        local stacks = self:getSoulFragmentsBuffStacks(atTime)
        if self.estimated then
            if atTime - (self.atTime or 0) < 1.2 then
                stacks = self.estimatedCount
            else
                self.estimated = false
            end
        end
        return stacks
    end,
    getSoulFragmentsBuffStacks = function(self, atTime)
        local aura = self.ovaleAura:getAura("player", soulFragmentsBuffId, atTime, "HELPFUL", true)
        local stacks = (aura and self.ovaleAura:isActiveAura(aura, atTime) and aura.stacks) or 0
        return stacks
    end,
    hasMetamorphosis = function(self, atTime)
        local aura = self.ovaleAura:getAura("player", metamorphosisBuffId, atTime, "HELPFUL", true)
        return (aura and self.ovaleAura:isActiveAura(aura, atTime)) or false
    end,
})
