local __exports = LibStub:NewLibrary("ovale/states/Enemies", 90048)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local aceTimer = LibStub:GetLibrary("AceTimer-3.0", true)
local band = bit.band
local bor = bit.bor
local ipairs = ipairs
local pairs = pairs
local wipe = wipe
local find = string.find
local GetTime = GetTime
local COMBATLOG_OBJECT_AFFILIATION_MINE = COMBATLOG_OBJECT_AFFILIATION_MINE
local COMBATLOG_OBJECT_AFFILIATION_PARTY = COMBATLOG_OBJECT_AFFILIATION_PARTY
local COMBATLOG_OBJECT_AFFILIATION_RAID = COMBATLOG_OBJECT_AFFILIATION_RAID
local COMBATLOG_OBJECT_REACTION_FRIENDLY = COMBATLOG_OBJECT_REACTION_FRIENDLY
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local __enginestate = LibStub:GetLibrary("ovale/engine/state")
local States = __enginestate.States
local groupMembers = bor(COMBATLOG_OBJECT_AFFILIATION_MINE, COMBATLOG_OBJECT_AFFILIATION_PARTY, COMBATLOG_OBJECT_AFFILIATION_RAID)
local eventTagSuffixes = {
    [1] = "_DAMAGE",
    [2] = "_MISSED",
    [3] = "_AURA_APPLIED",
    [4] = "_AURA_APPLIED_DOSE",
    [5] = "_AURA_REFRESH",
    [6] = "_CAST_START",
    [7] = "_INTERRUPT",
    [8] = "_DISPEL",
    [9] = "_DISPEL_FAILED",
    [10] = "_STOLEN",
    [11] = "_DRAIN",
    [12] = "_LEECH"
}
local autoAttackEvents = {
    RANGED_DAMAGE = true,
    RANGED_MISSED = true,
    SWING_DAMAGE = true,
    SWING_MISSED = true
}
local unitRemovedEvents = {
    UNIT_DESTROYED = true,
    UNIT_DIED = true,
    UNIT_DISSIPATES = true
}
local enemyNames = {}
local lastSeenEnemies = {}
local taggedEnemyLastSeens = {}
local reaperTimer = nil
local reapInterval = 3
local isTagEvent = function(cleuEvent)
    local isTagEvent = false
    if autoAttackEvents[cleuEvent] then
        isTagEvent = true
    else
        for _, suffix in ipairs(eventTagSuffixes) do
            if find(cleuEvent, suffix .. "$") then
                isTagEvent = true
                break
            end
        end
    end
    return isTagEvent
end

local isFriendly = function(unitFlags, isGroupMember)
    return (band(unitFlags, COMBATLOG_OBJECT_REACTION_FRIENDLY) > 0 and ( not isGroupMember or band(unitFlags, groupMembers) > 0))
end

local EnemiesData = __class(nil, {
    constructor = function(self)
        self.activeEnemies = 0
        self.taggedEnemies = 0
        self.enemies = nil
    end
})
__exports.OvaleEnemiesClass = __class(States, {
    constructor = function(self, ovaleGuid, ovale, ovaleProfiler, ovaleDebug)
        self.ovaleGuid = ovaleGuid
        self.ovale = ovale
        self.handleInitialize = function()
            if  not reaperTimer then
                reaperTimer = self.module:ScheduleRepeatingTimer(self.removeInactiveEnemies, reapInterval)
            end
            self.module:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", self.handleCombatLogEventUnfiltered)
            self.module:RegisterEvent("PLAYER_REGEN_DISABLED", self.handlePlayerRegenDisabled)
        end
        self.handleDisable = function()
            if reaperTimer then
                self.module:CancelTimer(reaperTimer)
                reaperTimer = nil
            end
            self.module:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
            self.module:UnregisterEvent("PLAYER_REGEN_DISABLED")
        end
        self.handleCombatLogEventUnfiltered = function(event, ...)
            local _, cleuEvent, _, sourceGUID, sourceName, sourceFlags, _, destGUID, destName, destFlags = CombatLogGetCurrentEventInfo()
            if unitRemovedEvents[cleuEvent] then
                local now = GetTime()
                self:removeEnemy(cleuEvent, destGUID, now, true)
            elseif sourceGUID and sourceGUID ~= "" and sourceName and sourceFlags and destGUID and destGUID ~= "" and destName and destFlags then
                if  not isFriendly(sourceFlags) and isFriendly(destFlags, true) then
                    if  not (cleuEvent == "SPELL_PERIODIC_DAMAGE" and isTagEvent(cleuEvent)) then
                        local now = GetTime()
                        self:addEnemy(cleuEvent, sourceGUID, sourceName, now)
                    end
                elseif isFriendly(sourceFlags, true) and  not isFriendly(destFlags) and isTagEvent(cleuEvent) then
                    local now = GetTime()
                    local isPlayerTag
                    if sourceGUID == self.ovale.playerGUID then
                        isPlayerTag = true
                    else
                        isPlayerTag = self.ovaleGuid:isPlayerPet(sourceGUID)
                    end
                    self:addEnemy(cleuEvent, destGUID, destName, now, isPlayerTag)
                end
            end
        end
        self.handlePlayerRegenDisabled = function()
            wipe(enemyNames)
            wipe(lastSeenEnemies)
            wipe(taggedEnemyLastSeens)
            self.current.activeEnemies = 0
            self.current.taggedEnemies = 0
        end
        self.removeInactiveEnemies = function()
            self.profiler:startProfiling("OvaleEnemies_RemoveInactiveEnemies")
            local now = GetTime()
            for guid, timestamp in pairs(lastSeenEnemies) do
                if now - timestamp > reapInterval then
                    self:removeEnemy("REAPED", guid, now)
                end
            end
            for guid, timestamp in pairs(taggedEnemyLastSeens) do
                if now - timestamp > reapInterval then
                    self:removeTaggedEnemy("REAPED", guid, now)
                end
            end
            self.profiler:stopProfiling("OvaleEnemies_RemoveInactiveEnemies")
        end
        States.constructor(self, EnemiesData)
        self.module = ovale:createModule("OvaleEnemies", self.handleInitialize, self.handleDisable, aceEvent, aceTimer)
        self.profiler = ovaleProfiler:create(self.module:GetName())
        self.tracer = ovaleDebug:create(self.module:GetName())
    end,
    addEnemy = function(self, cleuEvent, guid, name, timestamp, isTagged)
        self.profiler:startProfiling("OvaleEnemies_AddEnemy")
        if guid then
            enemyNames[guid] = name
            local changed = false
            do
                if  not lastSeenEnemies[guid] then
                    self.current.activeEnemies = self.current.activeEnemies + 1
                    changed = true
                end
                lastSeenEnemies[guid] = timestamp
            end
            if isTagged then
                if  not taggedEnemyLastSeens[guid] then
                    self.current.taggedEnemies = self.current.taggedEnemies + 1
                    changed = true
                end
                taggedEnemyLastSeens[guid] = timestamp
            end
            if changed then
                self.tracer:debugTimestamp("%s: %d/%d enemy seen: %s (%s)", cleuEvent, self.current.taggedEnemies, self.current.activeEnemies, guid, name)
                self.ovale:needRefresh()
            end
        end
        self.profiler:stopProfiling("OvaleEnemies_AddEnemy")
    end,
    removeEnemy = function(self, cleuEvent, guid, timestamp, isDead)
        self.profiler:startProfiling("OvaleEnemies_RemoveEnemy")
        if guid then
            local name = enemyNames[guid]
            local changed = false
            if lastSeenEnemies[guid] then
                lastSeenEnemies[guid] = nil
                if self.current.activeEnemies > 0 then
                    self.current.activeEnemies = self.current.activeEnemies - 1
                    changed = true
                end
            end
            if taggedEnemyLastSeens[guid] then
                taggedEnemyLastSeens[guid] = nil
                if self.current.taggedEnemies > 0 then
                    self.current.taggedEnemies = self.current.taggedEnemies - 1
                    changed = true
                end
            end
            if changed then
                self.tracer:debugTimestamp("%s: %d/%d enemy %s: %s (%s)", cleuEvent, self.current.taggedEnemies, self.current.activeEnemies, (isDead and "died") or "removed", guid, name)
                self.ovale:needRefresh()
                self.module:SendMessage("Ovale_InactiveUnit", guid, isDead)
            end
        end
        self.profiler:stopProfiling("OvaleEnemies_RemoveEnemy")
    end,
    removeTaggedEnemy = function(self, cleuEvent, guid, timestamp)
        self.profiler:startProfiling("OvaleEnemies_RemoveTaggedEnemy")
        if guid then
            local name = enemyNames[guid]
            local tagged = taggedEnemyLastSeens[guid]
            if tagged then
                taggedEnemyLastSeens[guid] = nil
                if self.current.taggedEnemies > 0 then
                    self.current.taggedEnemies = self.current.taggedEnemies - 1
                end
                self.tracer:debugTimestamp("%s: %d/%d enemy removed: %s (%s), last tagged at %f", cleuEvent, self.current.taggedEnemies, self.current.activeEnemies, guid, name, tagged)
                self.ovale:needRefresh()
            end
        end
        self.profiler:stopProfiling("OvaleEnemies_RemoveTaggedEnemy")
    end,
    debugEnemies = function(self)
        for guid, seen in pairs(lastSeenEnemies) do
            local name = enemyNames[guid]
            local tagged = taggedEnemyLastSeens[guid]
            if tagged then
                self.tracer:print("Tagged enemy %s (%s) last seen at %f", guid, name, tagged)
            else
                self.tracer:print("Enemy %s (%s) last seen at %f", guid, name, seen)
            end
        end
        self.tracer:print("Total enemies: %d", self.current.activeEnemies)
        self.tracer:print("Total tagged enemies: %d", self.current.taggedEnemies)
    end,
    initializeState = function(self)
        self.next.enemies = nil
    end,
    resetState = function(self)
        self.profiler:startProfiling("OvaleEnemies_ResetState")
        self.next.activeEnemies = self.current.activeEnemies
        self.next.taggedEnemies = self.current.taggedEnemies
        self.profiler:stopProfiling("OvaleEnemies_ResetState")
    end,
    cleanState = function(self)
        self.next.activeEnemies = 0
        self.next.taggedEnemies = 0
        self.next.enemies = nil
    end,
})
