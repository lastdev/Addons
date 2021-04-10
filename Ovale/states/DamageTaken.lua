local __exports = LibStub:NewLibrary("ovale/states/DamageTaken", 90048)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __toolsPool = LibStub:GetLibrary("ovale/tools/Pool")
local OvalePool = __toolsPool.OvalePool
local __toolsQueue = LibStub:GetLibrary("ovale/tools/Queue")
local OvaleQueue = __toolsQueue.OvaleQueue
local aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local band = bit.band
local bor = bit.bor
local sub = string.sub
local GetTime = GetTime
local SCHOOL_MASK_ARCANE = SCHOOL_MASK_ARCANE
local SCHOOL_MASK_FIRE = SCHOOL_MASK_FIRE
local SCHOOL_MASK_FROST = SCHOOL_MASK_FROST
local SCHOOL_MASK_HOLY = SCHOOL_MASK_HOLY
local SCHOOL_MASK_NATURE = SCHOOL_MASK_NATURE
local SCHOOL_MASK_SHADOW = SCHOOL_MASK_SHADOW
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local pool = OvalePool("OvaleDamageTaken_pool")
local damageTakenWindow = 20
local schoolMaskMagic = bor(SCHOOL_MASK_ARCANE, SCHOOL_MASK_FIRE, SCHOOL_MASK_FROST, SCHOOL_MASK_HOLY, SCHOOL_MASK_NATURE, SCHOOL_MASK_SHADOW)
__exports.OvaleDamageTakenClass = __class(nil, {
    constructor = function(self, ovale, profiler, ovaleDebug)
        self.ovale = ovale
        self.damageEvent = OvaleQueue("OvaleDamageTaken_damageEvent")
        self.handleInitialize = function()
            self.module:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", self.handleCombatLogEventUnfiltered)
            self.module:RegisterEvent("PLAYER_REGEN_ENABLED", self.handlePlayerRegenEnabled)
        end
        self.handleDisable = function()
            self.module:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
            self.module:UnregisterEvent("PLAYER_REGEN_ENABLED")
            pool:drain()
        end
        self.handleCombatLogEventUnfiltered = function(event, ...)
            local _, cleuEvent, _, _, _, _, _, destGUID, _, _, _, arg12, arg13, arg14, arg15 = CombatLogGetCurrentEventInfo()
            if destGUID == self.ovale.playerGUID and sub(cleuEvent, -7) == "_DAMAGE" then
                self.profiler:startProfiling("OvaleDamageTaken_COMBAT_LOG_EVENT_UNFILTERED")
                local now = GetTime()
                local eventPrefix = sub(cleuEvent, 1, 6)
                if eventPrefix == "SWING_" then
                    local amount = arg12
                    self.tracer:debug("%s caused %d damage.", cleuEvent, amount)
                    self:addDamageTaken(now, amount)
                elseif eventPrefix == "RANGE_" or eventPrefix == "SPELL_" then
                    local spellName, spellSchool, amount = arg13, arg14, arg15
                    local isMagicDamage = band(spellSchool, schoolMaskMagic) > 0
                    if isMagicDamage then
                        self.tracer:debug("%s (%s) caused %d magic damage.", cleuEvent, spellName, amount)
                    else
                        self.tracer:debug("%s (%s) caused %d damage.", cleuEvent, spellName, amount)
                    end
                    self:addDamageTaken(now, amount, isMagicDamage)
                end
                self.profiler:stopProfiling("OvaleDamageTaken_COMBAT_LOG_EVENT_UNFILTERED")
            end
        end
        self.handlePlayerRegenEnabled = function(event)
            pool:drain()
        end
        self.module = ovale:createModule("OvaleDamageTaken", self.handleInitialize, self.handleDisable, aceEvent)
        self.profiler = profiler:create(self.module:GetName())
        self.tracer = ovaleDebug:create(self.module:GetName())
    end,
    addDamageTaken = function(self, timestamp, damage, isMagicDamage)
        self.profiler:startProfiling("OvaleDamageTaken_AddDamageTaken")
        local event = pool:get()
        event.timestamp = timestamp
        event.damage = damage
        event.magic = isMagicDamage or false
        self.damageEvent:insertFront(event)
        self:removeExpiredEvents(timestamp)
        self.ovale:needRefresh()
        self.profiler:stopProfiling("OvaleDamageTaken_AddDamageTaken")
    end,
    getRecentDamage = function(self, interval)
        local now = GetTime()
        local lowerBound = now - interval
        self:removeExpiredEvents(now)
        local total, totalMagic = 0, 0
        local iterator = self.damageEvent:frontToBackIterator()
        while iterator:next() do
            local event = iterator.value
            if event.timestamp < lowerBound then
                break
            end
            total = total + event.damage
            if event.magic then
                totalMagic = totalMagic + event.damage
            end
        end
        return total, totalMagic
    end,
    removeExpiredEvents = function(self, timestamp)
        self.profiler:startProfiling("OvaleDamageTaken_RemoveExpiredEvents")
        while true do
            local event = self.damageEvent:back()
            if  not event then
                break
            end
            if event then
                if timestamp - event.timestamp < damageTakenWindow then
                    break
                end
                self.damageEvent:removeBack()
                pool:release(event)
                self.ovale:needRefresh()
            end
        end
        self.profiler:stopProfiling("OvaleDamageTaken_RemoveExpiredEvents")
    end,
    debugDamageTaken = function(self)
        self.tracer:print(self.damageEvent:debuggingInfo())
        local iterator = self.damageEvent:backToFrontIterator()
        while iterator:next() do
            local event = iterator.value
            self.tracer:print("%d: %d damage", event.timestamp, event.damage)
        end
    end,
})
