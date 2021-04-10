local __exports = LibStub:NewLibrary("ovale/states/Future", 90048)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __LastSpell = LibStub:GetLibrary("ovale/states/LastSpell")
local lastSpellCastPool = __LastSpell.lastSpellCastPool
local createSpellCast = __LastSpell.createSpellCast
local aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local ipairs = ipairs
local pairs = pairs
local wipe = wipe
local kpairs = pairs
local unpack = unpack
local sub = string.sub
local insert = table.insert
local remove = table.remove
local GetSpellInfo = GetSpellInfo
local GetTime = GetTime
local UnitCastingInfo = UnitCastingInfo
local UnitChannelInfo = UnitChannelInfo
local UnitExists = UnitExists
local UnitGUID = UnitGUID
local UnitName = UnitName
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local __enginestate = LibStub:GetLibrary("ovale/engine/state")
local States = __enginestate.States
local __toolstools = LibStub:GetLibrary("ovale/tools/tools")
local isNumber = __toolstools.isNumber
local __enginecondition = LibStub:GetLibrary("ovale/engine/condition")
local returnValueBetween = __enginecondition.returnValueBetween
local strsub = sub
local tremove = remove
local timeAuraAdded = nil
local spellAuraEvents = {
    SPELL_AURA_APPLIED = "hit",
    SPELL_AURA_APPLIED_DOSE = "hit",
    SPELL_AURA_BROKEN = "hit",
    SPELL_AURA_BROKEN_SPELL = "hit",
    SPELL_AURA_REFRESH = "hit",
    SPELL_AURA_REMOVED = "hit",
    SPELL_AURA_REMOVED_DOSE = "hit"
}
local spellCastFinishEvents = {
    SPELL_DAMAGE = "hit",
    SPELL_DISPEL = "hit",
    SPELL_DISPEL_FAILED = "miss",
    SPELL_HEAL = "hit",
    SPELL_INTERRUPT = "hit",
    SPELL_MISSED = "miss",
    SPELL_STOLEN = "hit"
}
local spellCastEvents = {
    SPELL_CAST_FAILED = true,
    SPELL_CAST_START = true,
    SPELL_CAST_SUCCESS = true
}
do
    for cleuEvent, v in pairs(spellAuraEvents) do
        spellCastFinishEvents[cleuEvent] = v
    end
    for cleuEvent in pairs(spellCastFinishEvents) do
        spellCastEvents[cleuEvent] = true
    end
end
local spellCastAurOrder = {
    [1] = "target",
    [2] = "pet"
}
local whiteAttackIds = {
    [75] = true,
    [5019] = true,
    [6603] = true
}
local whitAttackNames = {}
do
    for spellId in pairs(whiteAttackIds) do
        local name = GetSpellInfo(spellId)
        if name then
            whitAttackNames[name] = true
        end
    end
end
local isSameSpellcast = function(a, b)
    local boolean = a.spellId == b.spellId and a.queued == b.queued
    if boolean then
        if a.channel or b.channel then
            if a.channel ~= b.channel then
                boolean = false
            end
        elseif a.lineId ~= b.lineId then
            boolean = false
        end
    end
    return boolean
end

__exports.OvaleFutureData = __class(nil, {
    pushGCDSpellId = function(self, spellId)
        if self.lastGCDSpellId then
            insert(self.lastGCDSpellIds, self.lastGCDSpellId)
            if #self.lastGCDSpellIds > 5 then
                remove(self.lastGCDSpellIds, 1)
            end
        end
        self.lastGCDSpellId = spellId
    end,
    getCounter = function(self, id)
        return self.counter[id] or 0
    end,
    isChanneling = function(self, atTime)
        return self.currentCast.channel and atTime < self.currentCast.stop
    end,
    constructor = function(self)
        self.lastCastTime = {}
        self.lastOffGCDSpellcast = createSpellCast()
        self.lastGCDSpellcast = createSpellCast()
        self.lastGCDSpellIds = {}
        self.lastGCDSpellId = 0
        self.counter = {}
        self.lastCast = {}
        self.currentCast = createSpellCast()
        self.nextCast = 0
    end
})
__exports.OvaleFutureClass = __class(States, {
    constructor = function(self, ovaleData, ovaleAura, ovalePaperDoll, baseState, ovaleCooldown, ovaleState, ovaleGuid, lastSpell, ovale, ovaleDebug, ovaleProfiler, ovaleStance, ovaleSpellBook, runner)
        self.ovaleData = ovaleData
        self.ovaleAura = ovaleAura
        self.ovalePaperDoll = ovalePaperDoll
        self.baseState = baseState
        self.ovaleCooldown = ovaleCooldown
        self.ovaleState = ovaleState
        self.ovaleGuid = ovaleGuid
        self.lastSpell = lastSpell
        self.ovale = ovale
        self.ovaleStance = ovaleStance
        self.ovaleSpellBook = ovaleSpellBook
        self.runner = runner
        self.isChanneling = function(positionalParameters, namedParameters, atTime)
            local spellId = unpack(positionalParameters)
            local state = self:getState(atTime)
            if state.currentCast.spellId ~= spellId or  not state.currentCast.channel then
                return 
            end
            return returnValueBetween(state.currentCast.start, state.currentCast.stop, 1, state.currentCast.start, 0)
        end
        self.handleInitialize = function()
            self.module:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", self.handleCombatLogEventUnfiltered)
            self.module:RegisterEvent("PLAYER_ENTERING_WORLD", self.handlePlayerEnteringWorld)
            self.module:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START", self.handleUnitSpellCastChannelStart)
            self.module:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", self.handleSpellCastChannelStop)
            self.module:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", self.handleSpellCastChannelUpdate)
            self.module:RegisterEvent("UNIT_SPELLCAST_DELAYED", self.handleUnitSpellCastDelayed)
            self.module:RegisterEvent("UNIT_SPELLCAST_FAILED", self.handleUnitSpellcastEnded)
            self.module:RegisterEvent("UNIT_SPELLCAST_FAILED_QUIET", self.handleUnitSpellcastEnded)
            self.module:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED", self.handleUnitSpellcastEnded)
            self.module:RegisterEvent("UNIT_SPELLCAST_SENT", self.handleUnitSpellCastSent)
            self.module:RegisterEvent("UNIT_SPELLCAST_START", self.handleUnitSpellCastStart)
            self.module:RegisterEvent("UNIT_SPELLCAST_STOP", self.handleUnitSpellcastEnded)
            self.module:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", self.handleUnitSpellCastSucceeded)
            self.module:RegisterMessage("Ovale_AuraAdded", self.handleAuraAdded)
            self.module:RegisterMessage("Ovale_AuraChanged", self.handleAuraChanged)
        end
        self.handleDisable = function()
            self.module:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
            self.module:UnregisterEvent("PLAYER_ENTERING_WORLD")
            self.module:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_START")
            self.module:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
            self.module:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE")
            self.module:UnregisterEvent("UNIT_SPELLCAST_DELAYED")
            self.module:UnregisterEvent("UNIT_SPELLCAST_FAILED")
            self.module:UnregisterEvent("UNIT_SPELLCAST_FAILED_QUIET")
            self.module:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED")
            self.module:UnregisterEvent("UNIT_SPELLCAST_SENT")
            self.module:UnregisterEvent("UNIT_SPELLCAST_START")
            self.module:UnregisterEvent("UNIT_SPELLCAST_STOP")
            self.module:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
            self.module:UnregisterMessage("Ovale_AuraAdded")
            self.module:UnregisterMessage("Ovale_AuraChanged")
        end
        self.handleCombatLogEventUnfiltered = function(event, ...)
            local _, cleuEvent, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellId, spellName, _, _, _, _, _, _, _, _, _, _, isOffHand = CombatLogGetCurrentEventInfo()
            if sourceGUID == self.ovale.playerGUID or self.ovaleGuid:isPlayerPet(sourceGUID) then
                self.profiler:startProfiling("OvaleFuture_COMBAT_LOG_EVENT_UNFILTERED")
                if spellCastEvents[cleuEvent] then
                    local now = GetTime()
                    if strsub(cleuEvent, 1, 11) == "SPELL_CAST_" and destName and destName ~= "" then
                        self.tracer:debugTimestamp("CLEU", cleuEvent, sourceName, sourceGUID, destName, destGUID, spellId, spellName)
                        local spellcast = self:getSpellcast(spellName, spellId, nil, now)
                        if spellcast and spellcast.targetName and spellcast.targetName == destName and spellcast.target ~= destGUID then
                            self.tracer:debug("Disambiguating target of spell %s (%d) to %s (%s).", spellName, spellId, destName, destGUID)
                            spellcast.target = destGUID
                        end
                    end
                    self.tracer:debugTimestamp("CLUE", cleuEvent)
                    local finish = spellCastFinishEvents[cleuEvent]
                    if cleuEvent == "SPELL_DAMAGE" or cleuEvent == "SPELL_HEAL" then
                        if isOffHand then
                            finish = nil
                        end
                    end
                    if finish then
                        local anyFinished = false
                        for i = #self.lastSpell.queue, 1, -1 do
                            local spellcast = self.lastSpell.queue[i]
                            if spellcast.success and (spellcast.spellId == spellId or spellcast.auraId == spellId) then
                                if self:finishSpell(spellcast, cleuEvent, sourceName, sourceGUID, destName, destGUID, spellId, spellName, finish, i) then
                                    anyFinished = true
                                end
                            end
                        end
                        if  not anyFinished then
                            self.tracer:debug("Found no spell to finish for %s (%d)", spellName, spellId)
                            for i = #self.lastSpell.queue, 1, -1 do
                                local spellcast = self.lastSpell.queue[i]
                                if spellcast.success and spellcast.spellName == spellName then
                                    if self:finishSpell(spellcast, cleuEvent, sourceName, sourceGUID, destName, destGUID, spellId, spellName, finish, i) then
                                        anyFinished = true
                                    end
                                end
                            end
                            if  not anyFinished then
                                self.tracer:debug("No spell found for %s", spellName, spellId)
                            end
                        end
                    end
                end
                self.profiler:stopProfiling("OvaleFuture_COMBAT_LOG_EVENT_UNFILTERED")
            end
        end
        self.handlePlayerEnteringWorld = function(event)
            self.profiler:startProfiling("OvaleFuture_PLAYER_ENTERING_WORLD")
            self.tracer:debug(event)
            self.profiler:stopProfiling("OvaleFuture_PLAYER_ENTERING_WORLD")
        end
        self.handleUnitSpellCastChannelStart = function(event, unitId, lineId, spellId)
            if (unitId == "player" or unitId == "pet") and  not whiteAttackIds[spellId] then
                local spell = self.ovaleSpellBook:getSpellName(spellId)
                self.profiler:startProfiling("OvaleFuture_UNIT_SPELLCAST_CHANNEL_START")
                self.tracer:debugTimestamp(event, unitId, spell, lineId, spellId)
                local now = GetTime()
                local spellcast = self:getSpellcast(spell, spellId, nil, now)
                if spellcast then
                    local name, _, _, startTime, endTime = UnitChannelInfo(unitId)
                    if name == spell then
                        startTime = startTime / 1000
                        endTime = endTime / 1000
                        spellcast.channel = true
                        spellcast.spellId = spellId
                        spellcast.success = now
                        spellcast.start = startTime
                        spellcast.stop = endTime
                        local delta = now - spellcast.queued
                        self.tracer:debug("Channelling spell %s (%d): start = %s (+%s), ending = %s", spell, spellId, startTime, delta, endTime)
                        self:saveSpellcastInfo(spellcast, now)
                        self:updateLastSpellcast(now, spellcast)
                        self:updateCounters(spellId, spellcast.start, spellcast.target)
                        self.ovale:needRefresh()
                    elseif  not name then
                        self.tracer:debug("Warning: not channelling a spell.")
                    else
                        self.tracer:debug("Warning: channelling unexpected spell %s", name)
                    end
                else
                    self.tracer:debug("Warning: channelling spell %s (%d) without previous UNIT_SPELLCAST_SENT.", spell, spellId)
                end
                self.profiler:stopProfiling("OvaleFuture_UNIT_SPELLCAST_CHANNEL_START")
            end
        end
        self.handleSpellCastChannelStop = function(event, unitId, lineId, spellId)
            if (unitId == "player" or unitId == "pet") and  not whiteAttackIds[spellId] then
                local spell = self.ovaleSpellBook:getSpellName(spellId)
                self.profiler:startProfiling("OvaleFuture_UNIT_SPELLCAST_CHANNEL_STOP")
                self.tracer:debugTimestamp(event, unitId, spell, lineId, spellId)
                local now = GetTime()
                local spellcast, index = self:getSpellcast(spell, spellId, nil, now)
                if spellcast and spellcast.channel then
                    self.tracer:debug("Finished channelling spell %s (%d) queued at %s.", spell, spellId, spellcast.queued)
                    spellcast.stop = now
                    self:updateLastSpellcast(now, spellcast)
                    local targetGUID = spellcast.target
                    tremove(self.lastSpell.queue, index)
                    lastSpellCastPool:release(spellcast)
                    self.ovale:needRefresh()
                    self.module:SendMessage("Ovale_SpellFinished", now, spellId, targetGUID, "hit")
                end
                self.profiler:stopProfiling("OvaleFuture_UNIT_SPELLCAST_CHANNEL_STOP")
            end
        end
        self.handleSpellCastChannelUpdate = function(event, unitId, lineId, spellId)
            if (unitId == "player" or unitId == "pet") and  not whiteAttackIds[spellId] then
                local spell = self.ovaleSpellBook:getSpellName(spellId)
                self.profiler:startProfiling("OvaleFuture_UNIT_SPELLCAST_CHANNEL_UPDATE")
                self.tracer:debugTimestamp(event, unitId, spell, lineId, spellId)
                local now = GetTime()
                local spellcast = self:getSpellcast(spell, spellId, nil, now)
                if spellcast and spellcast.channel then
                    local name, _, _, startTime, endTime = UnitChannelInfo(unitId)
                    if name == spell then
                        startTime = startTime / 1000
                        endTime = endTime / 1000
                        local delta = endTime - spellcast.stop
                        spellcast.start = startTime
                        spellcast.stop = endTime
                        self.tracer:debug("Updating channelled spell %s (%d) to ending = %s (+%s).", spell, spellId, endTime, delta)
                        self.ovale:needRefresh()
                    elseif  not name then
                        self.tracer:debug("Warning: not channelling a spell.")
                    else
                        self.tracer:debug("Warning: delaying unexpected channelled spell %s.", name)
                    end
                else
                    self.tracer:debug("Warning: no queued, channelled spell %s (%d) found to update.", spell, spellId)
                end
                self.profiler:stopProfiling("OvaleFuture_UNIT_SPELLCAST_CHANNEL_UPDATE")
            end
        end
        self.handleUnitSpellCastDelayed = function(event, unitId, lineId, spellId)
            if (unitId == "player" or unitId == "pet") and  not whiteAttackIds[spellId] then
                local spell = self.ovaleSpellBook:getSpellName(spellId)
                self.profiler:startProfiling("OvaleFuture_UNIT_SPELLCAST_DELAYED")
                self.tracer:debugTimestamp(event, unitId, spell, lineId, spellId)
                local now = GetTime()
                local spellcast = self:getSpellcast(spell, spellId, lineId, now)
                if spellcast then
                    local name, _, _, startTime, endTime, _, castId = UnitCastingInfo(unitId)
                    if lineId == castId and name == spell then
                        startTime = startTime / 1000
                        endTime = endTime / 1000
                        local delta = endTime - spellcast.stop
                        spellcast.start = startTime
                        spellcast.stop = endTime
                        self.tracer:debug("Delaying spell %s (%d) to ending = %s (+%s).", spell, spellId, endTime, delta)
                        self.ovale:needRefresh()
                    elseif  not name then
                        self.tracer:debug("Warning: not casting a spell.")
                    else
                        self.tracer:debug("Warning: delaying unexpected spell %s.", name)
                    end
                else
                    self.tracer:debug("Warning: no queued spell %s (%d) found to delay.", spell, spellId)
                end
                self.profiler:stopProfiling("OvaleFuture_UNIT_SPELLCAST_DELAYED")
            end
        end
        self.handleUnitSpellCastSent = function(event, unitId, targetName, lineId, spellId)
            if (unitId == "player" or unitId == "pet") and  not whiteAttackIds[spellId] then
                local spellName = self.ovaleSpellBook:getSpellName(spellId)
                self.tracer:debugTimestamp(event, unitId, spellName, targetName, lineId)
                self:addSpellCast(lineId, unitId, spellName, spellId, targetName)
                self.profiler:stopProfiling("OvaleFuture_UNIT_SPELLCAST_SENT")
            end
        end
        self.handleUnitSpellCastStart = function(event, unitId, lineId, spellId)
            if (unitId == "player" or unitId == "pet") and  not whiteAttackIds[spellId] then
                self.ovaleData:registerSpellCast(spellId)
                local spellName = self.ovaleSpellBook:getSpellName(spellId)
                self.profiler:startProfiling("OvaleFuture_UNIT_SPELLCAST_START")
                self.tracer:debugTimestamp(event, unitId, spellName, lineId, spellId)
                local now = GetTime()
                local spellcast = self:getSpellcast(spellName, spellId, lineId, now)
                if  not spellcast then
                    self.tracer:debug("Warning: casting spell %s (%d) without previous sent data.", spellName, spellId)
                    spellcast = self:addSpellCast(lineId, unitId, spellName, spellId, nil)
                end
                local name, _, _, startTime, endTime, _, castId = UnitCastingInfo(unitId)
                if lineId == castId and name == spellName then
                    startTime = startTime / 1000
                    endTime = endTime / 1000
                    spellcast.spellId = spellId
                    spellcast.start = startTime
                    spellcast.stop = endTime
                    spellcast.channel = false
                    local delta = now - spellcast.queued
                    self.tracer:debug("Casting spell %s (%d): start = %s (+%s), ending = %s.", spellName, spellId, startTime, delta, endTime)
                    local auraId, auraGUID = self:getAuraFinish(spellId, spellcast.target, now)
                    if auraId and auraGUID then
                        spellcast.auraId = auraId
                        spellcast.auraGUID = auraGUID
                        self.tracer:debug("Spell %s (%d) will finish after updating aura %d on %s.", spellName, spellId, auraId, auraGUID)
                    end
                    self:saveSpellcastInfo(spellcast, now)
                    self:updateLastSpellcast(now, spellcast)
                    self.ovale:needRefresh()
                elseif  not name then
                    self.tracer:debug("Warning: not casting a spell.")
                else
                    self.tracer:debug("Warning: casting unexpected spell %s.", name)
                end
                self.profiler:stopProfiling("OvaleFuture_UNIT_SPELLCAST_START")
            end
        end
        self.handleUnitSpellCastSucceeded = function(event, unitId, lineId, spellId)
            if (unitId == "player" or unitId == "pet") and  not whiteAttackIds[spellId] then
                self.ovaleData:registerSpellCast(spellId)
                local spell = self.ovaleSpellBook:getSpellName(spellId)
                self.profiler:startProfiling("OvaleFuture_UNIT_SPELLCAST_SUCCEEDED")
                self.tracer:debugTimestamp(event, unitId, spell, lineId, spellId)
                local now = GetTime()
                local spellcast, index = self:getSpellcast(spell, spellId, lineId, now)
                if spellcast then
                    local success = false
                    if  not spellcast.success and spellcast.start and spellcast.stop and  not spellcast.channel then
                        self.tracer:debug("Succeeded casting spell %s (%d) at %s, now in flight.", spell, spellId, spellcast.stop)
                        spellcast.success = now
                        self:updateSpellcastSnapshot(spellcast, now)
                        success = true
                    else
                        local name = UnitChannelInfo(unitId)
                        if  not name then
                            local now = GetTime()
                            spellcast.spellId = spellId
                            spellcast.start = now
                            spellcast.stop = now
                            spellcast.channel = false
                            spellcast.success = now
                            local delta = now - spellcast.queued
                            self.tracer:debug("Instant-cast spell %s (%d): start = %s (+%s).", spell, spellId, now, delta)
                            local auraId, auraGUID = self:getAuraFinish(spellId, spellcast.target, now)
                            if auraId and auraGUID then
                                spellcast.auraId = auraId
                                spellcast.auraGUID = auraGUID
                                self.tracer:debug("Spell %s (%d) will finish after updating aura %d on %s.", spell, spellId, auraId, auraGUID)
                            end
                            self:saveSpellcastInfo(spellcast, now)
                            success = true
                        else
                            self.tracer:debug("Succeeded casting spell %s (%d) but it is channelled.", spell, spellId)
                        end
                    end
                    if success then
                        local targetGUID = spellcast.target
                        self:updateLastSpellcast(now, spellcast)
                        if  not spellcast.offgcd then
                            self.next:pushGCDSpellId(spellcast.spellId)
                        end
                        self:updateCounters(spellId, spellcast.stop, targetGUID)
                        local finished = false
                        local finish = "miss"
                        if  not spellcast.targetName then
                            self.tracer:debug("Finished spell %s (%d) with no target queued at %s.", spell, spellId, spellcast.queued)
                            finished = true
                            finish = "hit"
                        elseif targetGUID == self.ovale.playerGUID and self.ovaleSpellBook:isHelpfulSpell(spellId) then
                            self.tracer:debug("Finished helpful spell %s (%d) cast on player queued at %s.", spell, spellId, spellcast.queued)
                            finished = true
                            finish = "hit"
                        end
                        if finished then
                            tremove(self.lastSpell.queue, index)
                            lastSpellCastPool:release(spellcast)
                            self.ovale:needRefresh()
                            self.module:SendMessage("Ovale_SpellFinished", now, spellId, targetGUID, finish)
                        end
                    end
                else
                    self.tracer:debug("Warning: no queued spell %s (%d) found to successfully complete casting.", spell, spellId)
                end
                self.profiler:stopProfiling("OvaleFuture_UNIT_SPELLCAST_SUCCEEDED")
            end
        end
        self.handleAuraAdded = function(event, atTime, guid, auraId, caster)
            if guid == self.ovale.playerGUID then
                timeAuraAdded = atTime
                self:updateSpellcastSnapshot(self.lastSpell.lastGCDSpellcast, atTime)
                self:updateSpellcastSnapshot(self.current.lastOffGCDSpellcast, atTime)
            end
        end
        self.handleAuraChanged = function(event, atTime, guid, auraId, caster)
            self.tracer:debugTimestamp("Ovale_AuraChanged", event, atTime, guid, auraId, caster)
            if caster == self.ovale.playerGUID then
                local anyFinished = false
                for i = #self.lastSpell.queue, 1, -1 do
                    local spellcast = self.lastSpell.queue[i]
                    if spellcast.success and spellcast.auraId == auraId then
                        if self:finishSpell(spellcast, "Ovale_AuraChanged", caster, self.ovale.playerGUID, spellcast.targetName, guid, spellcast.spellId, spellcast.spellName, "hit", i) then
                            anyFinished = true
                        end
                    end
                end
                if  not anyFinished then
                    self.tracer:debug("No spell found to finish for auraId %d", auraId)
                end
            end
        end
        self.handleUnitSpellcastEnded = function(event, unitId, lineId, spellId)
            if (unitId == "player" or unitId == "pet") and  not whiteAttackIds[spellId] then
                if event == "UNIT_SPELLCAST_INTERRUPTED" then
                    self.next.lastGCDSpellId = 0
                end
                local spellName = self.ovaleSpellBook:getSpellName(spellId)
                self.profiler:startProfiling("OvaleFuture_UnitSpellcastEnded")
                self.tracer:debugTimestamp(event, unitId, spellName, lineId, spellId)
                local now = GetTime()
                local spellcast, index = self:getSpellcast(spellName, spellId, lineId, now)
                if spellcast then
                    self.tracer:debug("End casting spell %s (%d) queued at %s due to %s.", spellName, spellId, spellcast.queued, event)
                    if  not spellcast.success then
                        self.tracer:debug("Remove spell from queue because there was no success before")
                        tremove(self.lastSpell.queue, index)
                        lastSpellCastPool:release(spellcast)
                        self.ovale:needRefresh()
                    end
                elseif lineId then
                    self.tracer:debug("Warning: no queued spell %s (%d) found to end casting.", spellName, spellId)
                end
                self.profiler:stopProfiling("OvaleFuture_UnitSpellcastEnded")
            end
        end
        self.applySpellStartCast = function(spellId, targetGUID, startCast, endCast, channel, spellcast)
            self.profiler:startProfiling("OvaleFuture_ApplySpellStartCast")
            if channel then
                self:updateCounters(spellId, startCast, targetGUID)
            end
            self.profiler:stopProfiling("OvaleFuture_ApplySpellStartCast")
        end
        self.applySpellAfterCast = function(spellId, targetGUID, startCast, endCast, channel, spellcast)
            self.profiler:startProfiling("OvaleFuture_ApplySpellAfterCast")
            if  not channel then
                self:updateCounters(spellId, endCast, targetGUID)
            end
            self.profiler:stopProfiling("OvaleFuture_ApplySpellAfterCast")
        end
        States.constructor(self, __exports.OvaleFutureData)
        local name = "OvaleFuture"
        self.tracer = ovaleDebug:create(name)
        self.profiler = ovaleProfiler:create(name)
        self.module = ovale:createModule(name, self.handleInitialize, self.handleDisable, aceEvent)
    end,
    registerConditions = function(self, condition)
        condition:registerCondition("channeling", true, self.isChanneling)
    end,
    updateStateCounters = function(self, state, spellId, atTime, targetGUID)
        local inccounter = self.ovaleData:getSpellInfoProperty(spellId, atTime, "inccounter", targetGUID)
        if inccounter then
            local value = (state.counter[inccounter] and state.counter[inccounter]) or 0
            state.counter[inccounter] = value + 1
        end
        local resetcounter = self.ovaleData:getSpellInfoProperty(spellId, atTime, "resetcounter", targetGUID)
        if resetcounter then
            state.counter[resetcounter] = 0
        end
    end,
    finishSpell = function(self, spellcast, cleuEvent, sourceName, sourceGUID, destName, destGUID, spellId, spellName, finish, i)
        local finished = false
        if  not spellcast.auraId then
            self.tracer:debugTimestamp("CLEU", cleuEvent, sourceName, sourceGUID, destName, destGUID, spellId, spellName)
            if  not spellcast.channel then
                self.tracer:debug("Finished (%s) spell %s (%d) queued at %s due to %s.", finish, spellName, spellId, spellcast.queued, cleuEvent)
                finished = true
            end
        elseif spellAuraEvents[cleuEvent] and spellcast.auraGUID and destGUID == spellcast.auraGUID then
            self.tracer:debugTimestamp("CLEU", cleuEvent, sourceName, sourceGUID, destName, destGUID, spellId, spellName)
            self.tracer:debug("Finished (%s) spell %s (%d) queued at %s after seeing aura %d on %s.", finish, spellName, spellId, spellcast.queued, spellcast.auraId, spellcast.auraGUID)
            finished = true
        elseif cleuEvent == "Ovale_AuraChanged" and spellcast.auraGUID and destGUID == spellcast.auraGUID then
            self.tracer:debug("Finished (%s) spell %s (%d) queued at %s after Ovale_AuraChanged was called for aura %d on %s.", finish, spellName, spellId, spellcast.queued, spellcast.auraId, spellcast.auraGUID)
            finished = true
        end
        if finished then
            local now = GetTime()
            if timeAuraAdded then
                if isSameSpellcast(spellcast, self.lastSpell.lastGCDSpellcast) then
                    self:updateSpellcastSnapshot(self.lastSpell.lastGCDSpellcast, timeAuraAdded)
                end
                if isSameSpellcast(spellcast, self.current.lastOffGCDSpellcast) then
                    self:updateSpellcastSnapshot(self.current.lastOffGCDSpellcast, timeAuraAdded)
                end
            end
            local delta = now - spellcast.stop
            local targetGUID = spellcast.target
            self.tracer:debug("Spell %s (%d) was in flight for %f seconds.", spellName, spellId, delta)
            tremove(self.lastSpell.queue, i)
            lastSpellCastPool:release(spellcast)
            self.ovale:needRefresh()
            self.module:SendMessage("Ovale_SpellFinished", now, spellId, targetGUID, finish)
        end
        return finished
    end,
    addSpellCast = function(self, lineId, unitId, spellName, spellId, targetName)
        self.profiler:startProfiling("OvaleFuture_UNIT_SPELLCAST_SENT")
        local now = GetTime()
        local caster = self.ovaleGuid:getUnitGUID(unitId)
        local spellcast = lastSpellCastPool:get()
        spellcast.lineId = lineId
        spellcast.caster = caster
        spellcast.castByPlayer = caster == self.ovale.playerGUID
        spellcast.spellId = spellId
        spellcast.spellName = spellName or "Unknown spell"
        spellcast.queued = now
        insert(self.lastSpell.queue, spellcast)
        if targetName == "" or targetName == nil then
            self.tracer:debug("Queueing (%d) spell %s with no target.", #self.lastSpell.queue, spellName)
        else
            spellcast.targetName = targetName
            local targetGUID, nextGUID = self.ovaleGuid:getGuidByName(targetName)
            if nextGUID then
                local name = self.ovaleGuid:getUnitName("target")
                if name == targetName then
                    targetGUID = self.ovaleGuid:getUnitGUID("target")
                else
                    name = self.ovaleGuid:getUnitName("focus")
                    if name == targetName then
                        targetGUID = self.ovaleGuid:getUnitGUID("focus")
                    elseif UnitExists("mouseover") then
                        name = UnitName("mouseover")
                        if name == targetName then
                            targetGUID = UnitGUID("mouseover")
                        end
                    end
                end
                spellcast.target = targetGUID or "unknown"
                self.tracer:debug("Queueing (%d) spell %s to %s (possibly %s).", #self.lastSpell.queue, spellName, targetName, targetGUID)
            else
                spellcast.target = targetGUID or "unknown"
                self.tracer:debug("Queueing (%d) spell %s to %s (%s).", #self.lastSpell.queue, spellName, targetName, targetGUID)
            end
        end
        self:saveSpellcastInfo(spellcast, now)
        return spellcast
    end,
    getSpellcast = function(self, spellName, spellId, lineId, atTime)
        self.profiler:startProfiling("OvaleFuture_GetSpellcast")
        local spellcast = nil
        local index = 0
        if  not lineId or lineId ~= "" then
            for i, sc in ipairs(self.lastSpell.queue) do
                if  not lineId or sc.lineId == lineId then
                    if spellId and sc.spellId == spellId then
                        spellcast = sc
                        index = i
                        break
                    elseif spellName then
                        local spellName = sc.spellName or self.ovaleSpellBook:getSpellName(spellId)
                        if spellName == spellName then
                            spellcast = sc
                            index = i
                            break
                        end
                    end
                end
            end
        end
        if spellcast then
            spellName = spellName or spellcast.spellName or self.ovaleSpellBook:getSpellName(spellId)
            if spellcast.targetName then
                self.tracer:debug("Found spellcast for %s to %s queued at %f.", spellName, spellcast.targetName, spellcast.queued)
            else
                self.tracer:debug("Found spellcast for %s with no target queued at %f.", spellName, spellcast.queued)
            end
        end
        self.profiler:stopProfiling("OvaleFuture_GetSpellcast")
        return spellcast, index
    end,
    getAuraFinish = function(self, spellId, targetGUID, atTime)
        self.profiler:startProfiling("OvaleFuture_GetAuraFinish")
        local auraId, auraGUID
        local si = self.ovaleData.spellInfo[spellId]
        if si and si.aura then
            for _, unitId in ipairs(spellCastAurOrder) do
                for _, auraList in kpairs(si.aura[unitId]) do
                    for id, spellData in kpairs(auraList) do
                        local value = self.ovaleData:checkSpellAuraData(id, spellData, atTime, targetGUID)
                        if (value.enabled == nil or value.enabled) and isNumber(value.add) and value.add > 0 then
                            auraId = id
                            auraGUID = self.ovaleGuid:getUnitGUID(unitId)
                            break
                        end
                    end
                    if auraId then
                        break
                    end
                end
                if auraId then
                    break
                end
            end
        end
        self.profiler:stopProfiling("OvaleFuture_GetAuraFinish")
        return auraId, auraGUID
    end,
    saveSpellcastInfo = function(self, spellcast, atTime)
        self.profiler:startProfiling("OvaleFuture_SaveSpellcastInfo")
        self.tracer:debug("    Saving information from %s to the spellcast for %s.", atTime, spellcast.spellName)
        if spellcast.spellId then
            spellcast.damageMultiplier = self:getDamageMultiplier(spellcast.spellId, spellcast.target, atTime)
        end
        for _, mod in pairs(self.lastSpell.modules) do
            local func = mod.saveSpellcastInfo
            if func then
                func(spellcast, atTime)
            end
        end
        self.profiler:stopProfiling("OvaleFuture_SaveSpellcastInfo")
    end,
    getDamageMultiplier = function(self, spellId, targetGUID, atTime)
        local damageMultiplier = 1
        local si = self.ovaleData.spellInfo[spellId]
        if si and si.aura and si.aura.damage then
            for filter, auraList in kpairs(si.aura.damage) do
                for auraId, spellData in pairs(auraList) do
                    local multiplier
                    local verified
                    local _, namedParameters = self.runner:computeParameters(spellData, atTime)
                    multiplier = namedParameters.set
                    verified = namedParameters.enabled == nil or namedParameters.enabled
                    if verified then
                        local aura = self.ovaleAura:getAuraByGUID(self.ovale.playerGUID, auraId, filter, false, atTime)
                        if aura and self.ovaleAura:isActiveAura(aura, atTime) then
                            local siAura = self.ovaleData.spellInfo[auraId]
                            if siAura and siAura.stacking and siAura.stacking > 0 then
                                multiplier = 1 + (multiplier - 1) * aura.stacks
                            end
                            damageMultiplier = damageMultiplier * multiplier
                        end
                    end
                end
            end
        end
        return damageMultiplier
    end,
    updateCounters = function(self, spellId, atTime, targetGUID)
        return self:updateStateCounters(self:getState(atTime), spellId, atTime, targetGUID)
    end,
    isActive = function(self, spellId)
        for _, spellcast in ipairs(self.lastSpell.queue) do
            if spellcast.spellId == spellId and spellcast.start then
                return true
            end
        end
        return false
    end,
    isInFlight = function(self, spellId)
        return self:isActive(spellId)
    end,
    updateLastSpellcast = function(self, atTime, spellcast)
        self.profiler:startProfiling("OvaleFuture_UpdateLastSpellcast")
        self.current.lastCastTime[spellcast.spellId] = atTime
        if spellcast.castByPlayer then
            if spellcast.offgcd then
                self.tracer:debug("    Caching spell %s (%d) as most recent off-GCD spellcast.", spellcast.spellName, spellcast.spellId)
                for k, v in kpairs(spellcast) do
                    (self.current.lastOffGCDSpellcast)[k] = v
                end
                self.lastSpell.lastSpellcast = self.current.lastOffGCDSpellcast
                self.next.lastOffGCDSpellcast = self.current.lastOffGCDSpellcast
            else
                self.tracer:debug("    Caching spell %s (%d) as most recent GCD spellcast.", spellcast.spellName, spellcast.spellId)
                for k, v in kpairs(spellcast) do
                    (self.lastSpell.lastGCDSpellcast)[k] = v
                end
                self.lastSpell.lastSpellcast = self.lastSpell.lastGCDSpellcast
                self.next.lastGCDSpellId = self.lastSpell.lastGCDSpellcast.spellId
            end
        end
        self.profiler:stopProfiling("OvaleFuture_UpdateLastSpellcast")
    end,
    updateSpellcastSnapshot = function(self, spellcast, atTime)
        if spellcast.queued and ( not spellcast.snapshotTime or (spellcast.snapshotTime < atTime and atTime < spellcast.stop + 1)) then
            if spellcast.targetName then
                self.tracer:debug("    Updating to snapshot from %s for spell %s to %s (%s) queued at %s.", atTime, spellcast.spellName, spellcast.targetName, spellcast.target, spellcast.queued)
            else
                self.tracer:debug("    Updating to snapshot from %s for spell %s with no target queued at %s.", atTime, spellcast.spellName, spellcast.queued)
            end
            self.ovalePaperDoll:updateSnapshot(spellcast, self.ovalePaperDoll.current, true)
            if spellcast.spellId then
                spellcast.damageMultiplier = self:getDamageMultiplier(spellcast.spellId, spellcast.target, atTime)
                if spellcast.damageMultiplier ~= 1 then
                    self.tracer:debug("        persistent multiplier = %f", spellcast.damageMultiplier)
                end
            end
        end
    end,
    getCounter = function(self, id, atTime)
        return self:getState(atTime).counter[id] or 0
    end,
    getTimeOfLastCast = function(self, spellId, atTime)
        if  not atTime then
            return self.current.lastCastTime[spellId]
        end
        return (self.next.lastCastTime[spellId] or self.current.lastCastTime[spellId] or 0)
    end,
    isChannelingAtTime = function(self, atTime)
        return self:getState(atTime):isChanneling(atTime)
    end,
    getCurrentCast = function(self, atTime)
        if atTime and self.next.currentCast and self.next.currentCast.start <= atTime and self.next.currentCast.stop >= atTime then
            return self.next.currentCast
        end
        for _, value in ipairs(self.lastSpell.queue) do
            if value.start and value.start <= atTime and ( not value.stop or value.stop >= atTime) then
                return value
            end
        end
    end,
    getGCD = function(self, atTime, spellId, targetGUID)
        spellId = spellId or self.next.currentCast.spellId
        targetGUID = targetGUID or self.ovaleGuid:getUnitGUID(self.baseState.defaultTarget)
        local gcd = spellId and self.ovaleData:getSpellInfoProperty(spellId, atTime, "gcd", targetGUID)
        if  not gcd then
            local haste
            gcd, haste = self.ovaleCooldown:getBaseGCD()
            if self.ovale.playerClass == "MONK" and self.ovalePaperDoll:isSpecialization("mistweaver") then
                gcd = 1.5
                haste = "spell"
            elseif self.ovale.playerClass == "DRUID" then
                if self.ovaleStance:isStance("druid_cat_form", atTime) then
                    gcd = 1
                    haste = "none"
                end
            end
            local gcdHaste = spellId and self.ovaleData:getSpellInfoProperty(spellId, atTime, "gcd_haste", targetGUID)
            if gcdHaste then
                haste = gcdHaste
            else
                local siHaste = spellId and self.ovaleData:getSpellInfoProperty(spellId, atTime, "haste", targetGUID)
                if siHaste then
                    haste = siHaste
                end
            end
            local multiplier = self.ovalePaperDoll:getHasteMultiplier(haste, self.ovalePaperDoll.next)
            gcd = gcd / multiplier
            gcd = (gcd > 0.75 and gcd) or 0.75
        end
        return gcd
    end,
    initializeState = function(self)
        self.next.lastCast = {}
        self.next.counter = {}
    end,
    resetState = function(self)
        self.profiler:startProfiling("OvaleFuture_ResetState")
        local now = self.baseState.currentTime
        self.tracer:log("Reset state with current time = %f", now)
        self.next.nextCast = now
        wipe(self.next.lastCast)
        wipe(__exports.OvaleFutureClass.staticSpellcast)
        self.next.currentCast = __exports.OvaleFutureClass.staticSpellcast
        local reason = ""
        local start, duration = self.ovaleCooldown:getGlobalCooldown(now)
        if start and start > 0 then
            local ending = start + duration
            if self.next.nextCast < ending then
                self.next.nextCast = ending
                reason = " (waiting for GCD)"
            end
        end
        local lastGCDSpellcastFound, lastOffGCDSpellcastFound, lastSpellcastFound
        for i = #self.lastSpell.queue, 1, -1 do
            local spellcast = self.lastSpell.queue[i]
            if spellcast.spellId and spellcast.start then
                self.tracer:log("    Found cast %d of spell %s (%d), start = %s, stop = %s.", i, spellcast.spellName, spellcast.spellId, spellcast.start, spellcast.stop)
                if  not lastSpellcastFound then
                    if spellcast.start and spellcast.stop and spellcast.start <= now and now < spellcast.stop then
                        self.next.currentCast = spellcast
                    end
                    lastSpellcastFound = true
                end
                if  not lastGCDSpellcastFound and  not spellcast.offgcd and spellcast.castByPlayer then
                    if spellcast.stop and self.next.nextCast < spellcast.stop then
                        self.next.nextCast = spellcast.stop
                        reason = " (waiting for spellcast)"
                    end
                    lastGCDSpellcastFound = true
                end
                if  not lastOffGCDSpellcastFound and spellcast.offgcd then
                    self.next.lastOffGCDSpellcast = spellcast
                    lastOffGCDSpellcastFound = true
                end
            end
            if lastGCDSpellcastFound and lastOffGCDSpellcastFound and lastSpellcastFound then
                break
            end
        end
        if  not lastSpellcastFound then
            local spellcast = self.lastSpell.lastSpellcast
            if spellcast then
                if spellcast.start and spellcast.stop and spellcast.start <= now and now < spellcast.stop then
                    self.next.currentCast = spellcast
                end
            end
        end
        if  not lastGCDSpellcastFound then
            local spellcast = self.lastSpell.lastGCDSpellcast
            if spellcast then
                self.next.lastGCDSpellcast = spellcast
                if spellcast.stop and self.next.nextCast < spellcast.stop then
                    self.next.nextCast = spellcast.stop
                    reason = " (waiting for spellcast)"
                end
            end
        end
        if  not lastOffGCDSpellcastFound then
            self.next.lastOffGCDSpellcast = self.current.lastOffGCDSpellcast
        end
        self.tracer:log("    nextCast = %f%s", self.next.nextCast, reason)
        for k, v in pairs(self.current.counter) do
            self.next.counter[k] = v
        end
        self.profiler:stopProfiling("OvaleFuture_ResetState")
    end,
    cleanState = function(self)
        for k in pairs(self.next.lastCast) do
            self.next.lastCast[k] = nil
        end
        for k in pairs(self.next.counter) do
            self.next.counter[k] = nil
        end
    end,
    staticSpellcast = createSpellCast(),
    applySpell = function(self, spellId, targetGUID, startCast, endCast, channel, spellcast)
        channel = channel or false
        self.profiler:startProfiling("OvaleFuture_state_ApplySpell")
        if spellId then
            if  not targetGUID then
                targetGUID = self.ovale.playerGUID
            end
            local castTime
            if startCast and endCast then
                castTime = endCast - startCast
            else
                castTime = self.ovaleSpellBook:getCastTime(spellId) or 0
                startCast = startCast or self.next.nextCast
                endCast = endCast or startCast + castTime
            end
            if  not spellcast then
                spellcast = __exports.OvaleFutureClass.staticSpellcast
                wipe(spellcast)
                spellcast.caster = self.ovale.playerGUID
                spellcast.castByPlayer = true
                spellcast.spellId = spellId
                spellcast.spellName = self.ovaleSpellBook:getSpellName(spellId) or "unknown spell"
                spellcast.target = targetGUID
                spellcast.targetName = self.ovaleGuid:getNameByGuid(targetGUID) or "target"
                spellcast.start = startCast
                spellcast.stop = endCast
                spellcast.channel = channel
                self.ovalePaperDoll:updateSnapshot(spellcast, self.ovalePaperDoll.next)
                local atTime = (channel and startCast) or endCast
                for _, mod in pairs(self.lastSpell.modules) do
                    local func = mod.saveSpellcastInfo
                    if func then
                        func(spellcast, atTime, self.ovalePaperDoll.next)
                    end
                end
            end
            if spellcast.castByPlayer then
                self.next.currentCast = spellcast
                self.next.lastCast[spellId] = endCast
                local gcd = self:getGCD(spellId, startCast, targetGUID)
                local nextCast = (castTime > gcd and endCast) or startCast + gcd
                if self.next.nextCast < nextCast then
                    self.next.nextCast = nextCast
                end
                self.tracer:log("Apply spell %d at %f currentTime=%f nextCast=%f endCast=%f targetGUID=%s", spellId, startCast, self.baseState.currentTime, nextCast, endCast, targetGUID)
            end
            if startCast > self.baseState.currentTime then
                self.ovaleState:applySpellStartCast(spellId, targetGUID, startCast, endCast, channel, spellcast)
            end
            if endCast > self.baseState.currentTime then
                self.ovaleState:applySpellAfterCast(spellId, targetGUID, startCast, endCast, channel, spellcast)
            end
            self.ovaleState:applySpellOnHit(spellId, targetGUID, startCast, endCast, channel, spellcast)
        end
        self.profiler:stopProfiling("OvaleFuture_state_ApplySpell")
    end,
    applyInFlightSpells = function(self)
        self.profiler:startProfiling("OvaleFuture_ApplyInFlightSpells")
        local now = GetTime()
        local index = 1
        while index <= #self.lastSpell.queue do
            local spellcast = self.lastSpell.queue[index]
            self.tracer:log("Spell cast %s %d %d", spellcast.spellName, spellcast.spellId, spellcast.stop)
            if spellcast.stop then
                local isValid = false
                local description
                if now < spellcast.stop then
                    isValid = true
                    description = (spellcast.channel and "channelling") or "being cast"
                elseif now < spellcast.stop + 5 then
                    isValid = true
                    description = "in flight"
                end
                if isValid then
                    if spellcast.target then
                        self.tracer:log("Active spell %s (%d) is %s to %s (%s), now=%f, endCast=%f, start=%f", spellcast.spellName, spellcast.spellId, description, spellcast.targetName, spellcast.target, now, spellcast.stop, spellcast.start)
                    else
                        self.tracer:log("Active spell %s (%d) is %s, now=%f, endCast=%f, start=%f", spellcast.spellName, spellcast.spellId, description, now, spellcast.stop, spellcast.start)
                    end
                    self:applySpell(spellcast.spellId, spellcast.target, spellcast.start, spellcast.stop, spellcast.channel, spellcast)
                else
                    if spellcast.target then
                        self.tracer:debug("Warning: removing active spell %s (%d) to %s (%s) that should have finished.", spellcast.spellName, spellcast.spellId, spellcast.targetName, spellcast.target)
                    else
                        self.tracer:debug("Warning: removing active spell %s (%d) that should have finished.", spellcast.spellName, spellcast.spellId)
                    end
                    remove(self.lastSpell.queue, index)
                    lastSpellCastPool:release(spellcast)
                    index = index - 1
                end
            end
            index = index + 1
        end
        self.profiler:stopProfiling("OvaleFuture_ApplyInFlightSpells")
    end,
})
