local __exports = LibStub:NewLibrary("ovale/states/Enemies", 90108)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
__imports.aceTimer = LibStub:GetLibrary("AceTimer-3.0", true)
__imports.__enginestate = LibStub:GetLibrary("ovale/engine/state")
__imports.States = __imports.__enginestate.States
__imports.__enginecombatlogevent = LibStub:GetLibrary("ovale/engine/combat-log-event")
__imports.unitFlag = __imports.__enginecombatlogevent.unitFlag
local aceEvent = __imports.aceEvent
local aceTimer = __imports.aceTimer
local band = bit.band
local bor = bit.bor
local pairs = pairs
local wipe = wipe
local GetTime = GetTime
local States = __imports.States
local unitFlag = __imports.unitFlag
local groupMembers = bor(unitFlag.affiliation.mine, unitFlag.affiliation.party, unitFlag.affiliation.raid)
local friendlyReaction = unitFlag.reaction.friendly
local tagEvent = {
    DAMAGE_SHIELD = true,
    DAMAGE_SHIELD_MISSED = true,
    RANGE_DAMAGE = true,
    RANGE_MISSED = true,
    SPELL_AURA_APPLIED = true,
    SPELL_AURA_APPLIED_DOSE = true,
    SPELL_AURA_REFRESH = true,
    SPELL_CAST_START = true,
    SPELL_DAMAGE = true,
    SPELL_DISPEL = true,
    SPELL_DISPEL_FAILED = true,
    SPELL_DRAIN = true,
    SPELL_INTERRUPT = true,
    SPELL_LEECH = true,
    SPELL_MISSED = true,
    SPELL_STOLEN = true,
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
local isFriendly = function(unitFlags, isGroupMember)
    return (band(unitFlags, friendlyReaction) > 0 and ( not isGroupMember or band(unitFlags, groupMembers) > 0))
end

local EnemiesData = __class(nil, {
    constructor = function(self)
        self.activeEnemies = 0
        self.taggedEnemies = 0
        self.enemies = nil
    end
})
__exports.OvaleEnemiesClass = __class(States, {
    constructor = function(self, ovaleGuid, combatLogEvent, ovale, ovaleDebug)
        self.ovaleGuid = ovaleGuid
        self.combatLogEvent = combatLogEvent
        self.ovale = ovale
        self.handleInitialize = function()
            if  not reaperTimer then
                reaperTimer = self.module:ScheduleRepeatingTimer(self.removeInactiveEnemies, reapInterval)
            end
            self.module:RegisterEvent("PLAYER_REGEN_DISABLED", self.handlePlayerRegenDisabled)
            for event in pairs(tagEvent) do
                self.combatLogEvent.registerEvent(event, self, self.handleCombatLogEvent)
            end
        end
        self.handleDisable = function()
            if reaperTimer then
                self.module:CancelTimer(reaperTimer)
                reaperTimer = nil
            end
            self.module:UnregisterEvent("PLAYER_REGEN_DISABLED")
            self.combatLogEvent.unregisterAllEvents(self)
        end
        self.handleCombatLogEvent = function(cleuEvent)
            local cleu = self.combatLogEvent
            local sourceGUID = cleu.sourceGUID
            local sourceName = cleu.sourceName
            local sourceFlags = cleu.sourceFlags
            local destGUID = cleu.destGUID
            local destName = cleu.destName
            local destFlags = cleu.destFlags
            if unitRemovedEvents[cleuEvent] then
                local now = GetTime()
                self:removeEnemy(cleuEvent, destGUID, now, true)
            elseif sourceGUID ~= "" and destGUID ~= "" and tagEvent[cleuEvent] then
                if  not isFriendly(sourceFlags) and isFriendly(destFlags, true) then
                    local now = GetTime()
                    self:addEnemy(cleuEvent, sourceGUID, sourceName, now)
                elseif isFriendly(sourceFlags, true) and  not isFriendly(destFlags) then
                    local now = GetTime()
                    local isPlayerTag = sourceGUID == self.ovale.playerGUID or self.ovaleGuid.getOwnerGUIDByGUID(sourceGUID) == self.ovale.playerGUID
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
        end
        States.constructor(self, EnemiesData)
        self.module = ovale:createModule("OvaleEnemies", self.handleInitialize, self.handleDisable, aceEvent, aceTimer)
        self.tracer = ovaleDebug:create(self.module:GetName())
    end,
    addEnemy = function(self, cleuEvent, guid, name, timestamp, isTagged)
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
    end,
    removeEnemy = function(self, cleuEvent, guid, timestamp, isDead)
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
    end,
    removeTaggedEnemy = function(self, cleuEvent, guid, timestamp)
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
        self.next.activeEnemies = self.current.activeEnemies
        self.next.taggedEnemies = self.current.taggedEnemies
    end,
    cleanState = function(self)
        self.next.activeEnemies = 0
        self.next.taggedEnemies = 0
        self.next.enemies = nil
    end,
})
