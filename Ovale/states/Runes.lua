local __exports = LibStub:NewLibrary("ovale/states/Runes", 90103)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __enginestate = LibStub:GetLibrary("ovale/engine/state")
local States = __enginestate.States
local aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local ipairs = ipairs
local wipe = wipe
local GetRuneCooldown = GetRuneCooldown
local GetTime = GetTime
local huge = math.huge
local sort = table.sort
local empowerRuneWeapon = 47568
local runeSlots = 6
local isActiveRune = function(rune, atTime)
    return rune.startCooldown == 0 or rune.endCooldown <= atTime
end

local RuneData = __class(nil, {
    constructor = function(self)
        self.rune = {}
    end
})
local usedRune = {}
__exports.OvaleRunesClass = __class(States, {
    constructor = function(self, ovale, ovaleDebug, ovaleProfiler, ovaleData, ovalePower, ovalePaperDoll)
        self.ovale = ovale
        self.ovaleData = ovaleData
        self.ovalePower = ovalePower
        self.ovalePaperDoll = ovalePaperDoll
        self.handleInitialize = function()
            if self.ovale.playerClass == "DEATHKNIGHT" then
                for slot = 1, runeSlots, 1 do
                    self.current.rune[slot] = {
                        endCooldown = 0,
                        startCooldown = 0
                    }
                end
                self.module:RegisterEvent("PLAYER_ENTERING_WORLD", self.handleUpdateAllRunes)
                self.module:RegisterEvent("RUNE_POWER_UPDATE", self.handleRunePowerUpdate)
                self.module:RegisterEvent("UNIT_RANGEDDAMAGE", self.handleUnitRangedDamage)
                self.module:RegisterEvent("UNIT_SPELL_HASTE", self.handleUnitRangedDamage)
                if self.ovale.playerGUID then
                    self.handleUpdateAllRunes()
                end
            end
        end
        self.handleDisable = function()
            if self.ovale.playerClass == "DEATHKNIGHT" then
                self.module:UnregisterEvent("PLAYER_ENTERING_WORLD")
                self.module:UnregisterEvent("RUNE_POWER_UPDATE")
                self.module:UnregisterEvent("UNIT_RANGEDDAMAGE")
                self.module:UnregisterEvent("UNIT_SPELL_HASTE")
                self.current.rune = {}
            end
        end
        self.handleRunePowerUpdate = function(event, slot, usable)
            self.tracer:debug(event, slot, usable)
            self:updateRune(slot)
        end
        self.handleUnitRangedDamage = function(event, unitId)
            if unitId == "player" then
                self.tracer:debug(event)
                self.handleUpdateAllRunes()
            end
        end
        self.handleUpdateAllRunes = function()
            for slot = 1, runeSlots, 1 do
                self:updateRune(slot)
            end
        end
        self.applySpellStartCast = function(spellId, targetGUID, startCast, endCast, isChanneled, spellcast)
            self.profiler:startProfiling("OvaleRunes_ApplySpellStartCast")
            if isChanneled then
                self:applyRuneCost(spellId, startCast, spellcast)
            end
            self.profiler:stopProfiling("OvaleRunes_ApplySpellStartCast")
        end
        self.applySpellAfterCast = function(spellId, targetGUID, startCast, endCast, isChanneled, spellcast)
            self.profiler:startProfiling("OvaleRunes_ApplySpellAfterCast")
            if  not isChanneled then
                self:applyRuneCost(spellId, endCast, spellcast)
                if spellId == empowerRuneWeapon then
                    for slot in ipairs(self.next.rune) do
                        self:reactivateRune(slot, endCast)
                    end
                end
            end
            self.profiler:stopProfiling("OvaleRunes_ApplySpellAfterCast")
        end
        States.constructor(self, RuneData)
        self.module = ovale:createModule("OvaleRunes", self.handleInitialize, self.handleDisable, aceEvent)
        self.tracer = ovaleDebug:create(self.module:GetName())
        self.profiler = ovaleProfiler:create(self.module:GetName())
    end,
    updateRune = function(self, slot)
        self.profiler:startProfiling("OvaleRunes_UpdateRune")
        local rune = self.current.rune[slot]
        local start, duration = GetRuneCooldown(slot)
        if start and duration then
            if start > 0 then
                rune.startCooldown = start
                rune.endCooldown = start + duration
            else
                rune.startCooldown = 0
                rune.endCooldown = 0
            end
            self.ovale:needRefresh()
        else
            self.tracer:debug("Warning: rune information for slot %d not available.", slot)
        end
        self.profiler:stopProfiling("OvaleRunes_UpdateRune")
    end,
    debugRunes = function(self)
        local now = GetTime()
        for slot = 1, runeSlots, 1 do
            local rune = self.current.rune[slot]
            if isActiveRune(rune, now) then
                self.tracer:print("rune[%d] is active.", slot)
            else
                self.tracer:print("rune[%d] comes off cooldown in %f seconds.", slot, rune.endCooldown - now)
            end
        end
    end,
    initializeState = function(self)
        self.next.rune = {}
        for slot in ipairs(self.current.rune) do
            self.next.rune[slot] = {
                endCooldown = 0,
                startCooldown = 0
            }
        end
    end,
    resetState = function(self)
        self.profiler:startProfiling("OvaleRunes_ResetState")
        for slot, rune in ipairs(self.current.rune) do
            local stateRune = self.next.rune[slot]
            stateRune.endCooldown = rune.endCooldown
            stateRune.startCooldown = rune.startCooldown
        end
        self.profiler:stopProfiling("OvaleRunes_ResetState")
    end,
    cleanState = function(self)
        for slot, rune in ipairs(self.next.rune) do
            wipe(rune)
            self.next.rune[slot] = nil
        end
    end,
    applyRuneCost = function(self, spellId, atTime, spellcast)
        local si = self.ovaleData.spellInfo[spellId]
        if si then
            local count = si.runes or 0
            while count > 0 do
                self:consumeRune(spellId, atTime, spellcast)
                count = count - 1
            end
        end
    end,
    reactivateRune = function(self, slot, atTime)
        local rune = self.next.rune[slot]
        if rune.startCooldown > atTime then
            rune.startCooldown = atTime
        end
        rune.endCooldown = atTime
    end,
    consumeRune = function(self, spellId, atTime, snapshot)
        self.profiler:startProfiling("OvaleRunes_state_ConsumeRune")
        local consumedRune
        for slot = 1, runeSlots, 1 do
            local rune = self.next.rune[slot]
            if isActiveRune(rune, atTime) then
                consumedRune = rune
                break
            end
        end
        if consumedRune then
            local start = atTime
            for slot = 1, runeSlots, 1 do
                local rune = self.next.rune[slot]
                if rune.endCooldown > start then
                    start = rune.endCooldown
                end
            end
            local duration = 10 / self.ovalePaperDoll:getSpellCastSpeedPercentMultiplier(snapshot)
            consumedRune.startCooldown = start
            consumedRune.endCooldown = start + duration
            local runicpower = (self.ovalePower.next.power.runicpower or 0) + 10
            local maxi = self.ovalePower.current.maxPower.runicpower
            self.ovalePower.next.power.runicpower = (runicpower < maxi and runicpower) or maxi
        end
        self.profiler:stopProfiling("OvaleRunes_state_ConsumeRune")
    end,
    runeCount = function(self, atTime)
        self.profiler:startProfiling("OvaleRunes_state_RuneCount")
        local state = self:getState(atTime)
        local count = 0
        local startCooldown, endCooldown = huge, huge
        for slot = 1, runeSlots, 1 do
            local rune = state.rune[slot]
            if isActiveRune(rune, atTime) then
                count = count + 1
            elseif rune.endCooldown < endCooldown then
                startCooldown, endCooldown = rune.startCooldown, rune.endCooldown
            end
        end
        self.profiler:stopProfiling("OvaleRunes_state_RuneCount")
        return count, startCooldown, endCooldown
    end,
    runeDeficit = function(self, atTime)
        self.profiler:startProfiling("OvaleRunes_state_RuneDeficit")
        local state = self:getState(atTime)
        local count = 0
        local startCooldown, endCooldown = huge, huge
        for slot = 1, runeSlots, 1 do
            local rune = state.rune[slot]
            if  not isActiveRune(rune, atTime) then
                count = count + 1
                if rune.endCooldown < endCooldown then
                    startCooldown, endCooldown = rune.startCooldown, rune.endCooldown
                end
            end
        end
        self.profiler:stopProfiling("OvaleRunes_state_RuneDeficit")
        return count, startCooldown, endCooldown
    end,
    getRunesCooldown = function(self, atTime, runes)
        if runes <= 0 then
            return 0
        end
        if runes > runeSlots then
            self.tracer:log("Attempt to read %d runes but the maximum is %d", runes, runeSlots)
            return 0
        end
        local state = self:getState(atTime)
        self.profiler:startProfiling("OvaleRunes_state_GetRunesCooldown")
        for slot = 1, runeSlots, 1 do
            local rune = state.rune[slot]
            if isActiveRune(rune, atTime) then
                usedRune[slot] = 0
            else
                usedRune[slot] = rune.endCooldown - atTime
            end
        end
        sort(usedRune)
        self.profiler:stopProfiling("OvaleRunes_state_GetRunesCooldown")
        return usedRune[runes]
    end,
})
