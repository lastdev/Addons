local __exports = LibStub:NewLibrary("ovale/states/DamageTaken", 90107)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.__toolsPool = LibStub:GetLibrary("ovale/tools/Pool")
__imports.OvalePool = __imports.__toolsPool.OvalePool
__imports.__toolsQueue = LibStub:GetLibrary("ovale/tools/Queue")
__imports.Deque = __imports.__toolsQueue.Deque
__imports.aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local OvalePool = __imports.OvalePool
local Deque = __imports.Deque
local aceEvent = __imports.aceEvent
local band = bit.band
local pairs = pairs
local Enum = Enum
local GetTime = GetTime
local pool = __imports.OvalePool("OvaleDamageTaken_pool")
local damageTakenWindow = 20
local schoolMaskMagic = Enum.Damageclass.MaskMagical
local damageTakenEvent = {
    RANGE_DAMAGE = true,
    SPELL_DAMAGE = true,
    SPELL_PERIODIC_DAMAGE = true,
    SWING_DAMAGE = true
}
__exports.OvaleDamageTakenClass = __class(nil, {
    constructor = function(self, ovale, ovaleDebug, combatLogEvent)
        self.ovale = ovale
        self.combatLogEvent = combatLogEvent
        self.damageEvent = __imports.Deque()
        self.handleInitialize = function()
            self.module:RegisterEvent("PLAYER_REGEN_ENABLED", self.handlePlayerRegenEnabled)
            for event in pairs(damageTakenEvent) do
                self.combatLogEvent.registerEvent(event, self, self.handleCombatLogEvent)
            end
        end
        self.handleDisable = function()
            self.module:UnregisterEvent("PLAYER_REGEN_ENABLED")
            self.combatLogEvent.unregisterAllEvents(self)
            pool:drain()
        end
        self.handleCombatLogEvent = function(cleuEvent)
            local cleu = self.combatLogEvent
            local destGUID = cleu.destGUID
            if destGUID == self.ovale.playerGUID then
                local payload = cleu.payload
                local amount = payload.amount
                local now = GetTime()
                if cleu.header.type == "SWING" then
                    self.tracer:debug("%s caused %d damage.", cleuEvent, amount)
                    self:addDamageTaken(now, amount)
                else
                    local spellName
                    local school
                    if cleu.header.type == "RANGE" then
                        local header = cleu.header
                        spellName = header.spellName
                        school = header.school
                    elseif cleu.header.type == "SPELL" then
                        local header = cleu.header
                        spellName = header.spellName
                        school = header.school
                    elseif cleu.header.type == "SPELL_PERIODIC" then
                        local header = cleu.header
                        spellName = header.spellName
                        school = header.school
                    end
                    if spellName and school then
                        local isMagicDamage = band(school, schoolMaskMagic) > 0
                        if isMagicDamage then
                            self.tracer:debug("%s (%s) caused %d magic damage.", cleuEvent, spellName, amount)
                        else
                            self.tracer:debug("%s (%s) caused %d damage.", cleuEvent, spellName, amount)
                        end
                        self:addDamageTaken(now, amount, isMagicDamage)
                    end
                end
            end
        end
        self.handlePlayerRegenEnabled = function(event)
            pool:drain()
        end
        self.module = ovale:createModule("OvaleDamageTaken", self.handleInitialize, self.handleDisable, aceEvent)
        self.tracer = ovaleDebug:create(self.module:GetName())
    end,
    addDamageTaken = function(self, timestamp, damage, isMagicDamage)
        local event = pool:get()
        event.timestamp = timestamp
        event.damage = damage
        event.magic = isMagicDamage or false
        self.damageEvent:push(event)
        self:removeExpiredEvents(timestamp)
        self.ovale:needRefresh()
    end,
    getRecentDamage = function(self, interval)
        local now = GetTime()
        local lowerBound = now - interval
        self:removeExpiredEvents(now)
        local total, totalMagic = 0, 0
        local iterator = self.damageEvent:backToFrontIterator()
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
        while true do
            local event = self.damageEvent:front()
            if  not event then
                break
            end
            if timestamp - event.timestamp < damageTakenWindow then
                break
            end
            self.damageEvent:shift()
            pool:release(event)
            self.ovale:needRefresh()
        end
    end,
    debugDamageTaken = function(self)
        self.tracer:print(self.module:GetName())
        local iterator = self.damageEvent:backToFrontIterator()
        while iterator:next() do
            local event = iterator.value
            self.tracer:print("%d: %d damage", event.timestamp, event.damage)
        end
    end,
})
