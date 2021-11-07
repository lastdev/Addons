local __exports = LibStub:NewLibrary("ovale/engine/combat-log-event", 90112)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local aceEvent = __imports.aceEvent
local next = next
local pairs = pairs
local unpack = unpack
local find = string.find
local COMBATLOG_OBJECT_AFFILIATION_MINE = COMBATLOG_OBJECT_AFFILIATION_MINE
local COMBATLOG_OBJECT_AFFILIATION_PARTY = COMBATLOG_OBJECT_AFFILIATION_PARTY
local COMBATLOG_OBJECT_AFFILIATION_RAID = COMBATLOG_OBJECT_AFFILIATION_RAID
local COMBATLOG_OBJECT_REACTION_FRIENDLY = COMBATLOG_OBJECT_REACTION_FRIENDLY
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local Enum = Enum
__exports.unitFlag = {
    type = {
        mask = 64512,
        object = 16384,
        guardian = 8192,
        pet = 4096,
        npc = 2048,
        player = 1024
    },
    controller = {
        mask = 768,
        npc = 512,
        player = 256
    },
    reaction = {
        mask = 240,
        hostile = 64,
        neutral = 32,
        friendly = COMBATLOG_OBJECT_REACTION_FRIENDLY
    },
    affiliation = {
        mask = 15,
        outsider = 8,
        raid = COMBATLOG_OBJECT_AFFILIATION_RAID,
        party = COMBATLOG_OBJECT_AFFILIATION_PARTY,
        mine = COMBATLOG_OBJECT_AFFILIATION_MINE
    }
}
__exports.raidFlag = {
    raidTarget = {
        mask = 255,
        skull = 128,
        cross = 64,
        square = 32,
        moon = 16,
        triangle = 8,
        diamond = 4,
        circle = 2,
        star = 1
    }
}
__exports.CombatLogEvent = __class(nil, {
    constructor = function(self, ovale, debug)
        self.registry = {}
        self.pendingRegistry = {}
        self.fireDepth = 0
        self.arg = {}
        self.timestamp = 0
        self.subEvent = "SWING_DAMAGE"
        self.hideCaster = false
        self.sourceGUID = ""
        self.sourceName = ""
        self.sourceFlags = 0
        self.sourceRaidFlags = 0
        self.destGUID = ""
        self.destName = ""
        self.destFlags = 0
        self.destRaidFlags = 0
        self.header = {
            type = "SWING"
        }
        self.payload = {
            type = "DAMAGE"
        }
        self.onEnable = function()
            self.module:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", self.onCombatLogEventUnfiltered)
        end
        self.onDisable = function()
            self.module:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        end
        self.onCombatLogEventUnfiltered = function(event)
            local arg = self.arg
            arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7], arg[8], arg[9], arg[10], arg[11], arg[12], arg[13], arg[14], arg[15], arg[16], arg[17], arg[18], arg[19], arg[20], arg[21], arg[22], arg[23], arg[24] = CombatLogGetCurrentEventInfo()
            local subEvent = arg[2]
            if  not self.hasEventHandler(subEvent) then
                return 
            end
            self.timestamp = (arg[1]) or 0
            self.subEvent = subEvent
            self.hideCaster = ((arg[3]) and true) or false
            self.sourceGUID = (arg[4]) or ""
            self.sourceName = (arg[5]) or ""
            self.sourceFlags = (arg[6]) or 0
            self.sourceRaidFlags = arg[7]
            self.destGUID = (arg[8]) or ""
            self.destName = (arg[9]) or ""
            self.destFlags = (arg[10]) or 0
            self.destRaidFlags = (arg[11]) or 0
            if subEvent == "ENCHANT_APPLIED" then
                local header = self.header
                header.type = "ENCHANT_APPLIED"
                header.spellName = (arg[12]) or ""
                header.itemId = (arg[13]) or 0
                header.itemName = (arg[14]) or ""
            elseif subEvent == "ENCHANT_REMOVED" then
                local header = self.header
                header.type = "ENCHANT_APPLIED"
                header.spellName = (arg[12]) or ""
                header.itemId = (arg[13]) or 0
                header.itemName = (arg[14]) or ""
            elseif subEvent == "PARTY_KILL" then
                self.header.type = "PARTY_KILL"
            elseif subEvent == "UNIT_DIED" then
                local header = self.header
                header.type = "UNIT_DIED"
                header.recapId = (arg[12]) or 1
                header.unconsciousOnDeath = ((arg[13]) and true) or false
            elseif subEvent == "UNIT_DESTROYED" then
                local header = self.header
                header.type = "UNIT_DESTROYED"
                header.recapId = (arg[12]) or 1
                header.unconsciousOnDeath = ((arg[13]) and true) or false
            elseif subEvent == "UNIT_DISSIPATES" then
                local header = self.header
                header.type = "UNIT_DISSIPATES"
                header.recapId = (arg[12]) or 1
                header.unconsciousOnDeath = ((arg[13]) and true) or false
            else
                local index = 12
                if find(subEvent, "^SWING_") then
                    self.header.type = "SWING"
                    index = 12
                elseif find(subEvent, "^RANGE_") then
                    local header = self.header
                    header.type = "RANGE"
                    header.spellId = (arg[12]) or 0
                    header.spellName = (arg[13]) or ""
                    header.school = (arg[14]) or 0
                    index = 15
                elseif find(subEvent, "^SPELL_PERIODIC_") then
                    local header = self.header
                    header.type = "SPELL_PERIODIC"
                    header.spellId = (arg[12]) or 0
                    header.spellName = (arg[13]) or ""
                    header.school = (arg[14]) or 0
                    index = 15
                elseif find(subEvent, "^SPELL_BUILDING") then
                    local header = self.header
                    header.type = "SPELL_BUILDING"
                    header.spellId = (arg[12]) or 0
                    header.spellName = (arg[13]) or ""
                    header.school = (arg[14]) or 0
                    index = 15
                elseif find(subEvent, "^SPELL_") or find(subEvent, "^DAMAGE_") then
                    local header = self.header
                    header.type = "SPELL"
                    header.spellId = (arg[12]) or 0
                    header.spellName = (arg[13]) or ""
                    header.school = (arg[14]) or 0
                    index = 15
                elseif find(subEvent, "^ENVIRONMENTAL") then
                    local header = self.header
                    header.type = "ENVIRONMENTAL"
                    header.environmentalType = (arg[12]) or "Fire"
                    index = 13
                end
                if find(subEvent, "_DAMAGE$") or find(subEvent, "_SPLIT$") or find(subEvent, "_SHIELD$") then
                    local payload = self.payload
                    payload.type = "DAMAGE"
                    payload.amount = (arg[index]) or 0
                    payload.overkill = (arg[index + 1]) or 0
                    payload.school = (arg[index + 2]) or 0
                    payload.resisted = (arg[index + 3]) or 0
                    payload.blocked = (arg[index + 4]) or 0
                    payload.absorbed = (arg[index + 5]) or 0
                    payload.critical = ((arg[index + 6]) and true) or false
                    payload.glancing = ((arg[index + 7]) and true) or false
                    payload.crushing = ((arg[index + 8]) and true) or false
                    payload.isOffHand = ((arg[index + 9]) and true) or false
                elseif find(subEvent, "_MISSED$") then
                    local payload = self.payload
                    payload.type = "MISSED"
                    payload.missType = (arg[index]) or "MISS"
                    payload.isOffHand = ((arg[index + 1]) and true) or false
                    payload.amountMissed = (arg[index + 2]) or 0
                    payload.critical = ((arg[index + 3]) and true) or false
                elseif find(subEvent, "_HEAL$") then
                    local payload = self.payload
                    payload.type = "HEAL"
                    payload.amount = (arg[index]) or 0
                    payload.overhealing = (arg[index + 2]) or 0
                    payload.absorbed = (arg[index + 3]) or 0
                    payload.critical = ((arg[index + 4]) and true) or false
                elseif find(subEvent, "_HEAL_ABSORBED$") then
                    local payload = self.payload
                    payload.type = "HEAL_ABSORBED"
                    payload.guid = (arg[index]) or ""
                    payload.name = (arg[index + 1]) or ""
                    payload.flags = (arg[index + 2]) or 0
                    payload.raidFlags = (arg[index + 3]) or 0
                    payload.spellId = (arg[index + 4]) or 0
                    payload.spellName = (arg[index + 5]) or ""
                    payload.school = (arg[index + 6]) or 0
                    payload.amount = (arg[index + 7]) or 0
                elseif find(subEvent, "_ENERGIZE$") then
                    local payload = self.payload
                    payload.type = "ENERGIZE"
                    payload.amount = (arg[index]) or 0
                    payload.overEnergize = (arg[index + 1]) or 0
                    payload.powerType = (arg[index + 2]) or Enum.PowerType.None
                    payload.alternatePowerType = (arg[index + 3]) or Enum.PowerType.Alternate
                elseif find(subEvent, "_DRAIN$") then
                    local payload = self.payload
                    payload.type = "DRAIN"
                    payload.amount = (arg[index]) or 0
                    payload.powerType = (arg[index + 1]) or Enum.PowerType.None
                    payload.extraAmount = (arg[index + 2]) or 0
                elseif find(subEvent, "_LEECH$") then
                    local payload = self.payload
                    payload.type = "LEECH"
                    payload.amount = (arg[index]) or 0
                    payload.powerType = (arg[index + 1]) or Enum.PowerType.None
                    payload.extraAmount = (arg[index + 2]) or 0
                elseif find(subEvent, "_INTERRUPT$") then
                    local payload = self.payload
                    payload.type = "INTERRUPT"
                    payload.spellId = (arg[index]) or 0
                    payload.spellName = (arg[index + 1]) or ""
                    payload.school = (arg[index + 2]) or 0
                elseif find(subEvent, "_DISPEL$") then
                    local payload = self.payload
                    payload.type = "DISPEL"
                    payload.spellId = (arg[index]) or 0
                    payload.spellName = (arg[index + 1]) or ""
                    payload.school = (arg[index + 2]) or 0
                    payload.auraType = (arg[index + 3]) or "DEBUFF"
                elseif find(subEvent, "_DISPEL_FAILED$") then
                    local payload = self.payload
                    payload.type = "DISPEL_FAILED"
                    payload.spellId = (arg[index]) or 0
                    payload.spellName = (arg[index + 1]) or ""
                    payload.school = (arg[index + 2]) or 0
                elseif find(subEvent, "_STOLEN$") then
                    local payload = self.payload
                    payload.type = "STOLEN"
                    payload.spellId = (arg[index]) or 0
                    payload.spellName = (arg[index + 1]) or ""
                    payload.school = (arg[index + 2]) or 0
                    payload.auraType = (arg[index + 3]) or "DEBUFF"
                elseif find(subEvent, "_EXTRA_ATTACKS$") then
                    local payload = self.payload
                    payload.type = "EXTRA_ATTACKS"
                    payload.amount = (arg[index]) or 0
                elseif find(subEvent, "_AURA_APPLIED$") then
                    local payload = self.payload
                    payload.type = "AURA_APPLIED"
                    payload.auraType = (arg[index]) or "DEBUFF"
                    payload.amount = (arg[index + 1]) or 0
                elseif find(subEvent, "_AURA_REMOVED$") then
                    local payload = self.payload
                    payload.type = "AURA_REMOVED"
                    payload.auraType = (arg[index]) or "DEBUFF"
                    payload.amount = (arg[index + 1]) or 0
                elseif find(subEvent, "_AURA_APPLIED_DOSE$") then
                    local payload = self.payload
                    payload.type = "AURA_APPLIED_DOSE"
                    payload.auraType = (arg[index]) or "DEBUFF"
                    payload.amount = (arg[index + 1]) or 0
                elseif find(subEvent, "_AURA_REMOVED_DOSE$") then
                    local payload = self.payload
                    payload.type = "AURA_REMOVED_DOSE"
                    payload.auraType = (arg[index]) or "DEBUFF"
                    payload.amount = (arg[index + 1]) or 0
                elseif find(subEvent, "_AURA_REFRESH$") then
                    local payload = self.payload
                    payload.type = "AURA_REFRESH"
                    payload.auraType = (arg[index]) or "DEBUFF"
                    payload.amount = (arg[index + 1]) or 0
                elseif find(subEvent, "_AURA_BROKEN$") then
                    local payload = self.payload
                    payload.type = "AURA_BROKEN"
                    payload.auraType = (arg[index]) or "DEBUFF"
                elseif find(subEvent, "_AURA_BROKEN_SPELL$") then
                    local payload = self.payload
                    payload.type = "AURA_BROKEN_SPELL"
                    payload.spellId = (arg[index]) or 0
                    payload.spellName = (arg[index + 1]) or ""
                    payload.school = (arg[index + 2]) or 0
                    payload.auraType = (arg[index + 3]) or "DEBUFF"
                elseif find(subEvent, "_CAST_START$") then
                    self.payload.type = "CAST_START"
                elseif find(subEvent, "_CAST_SUCCESS$") then
                    self.payload.type = "CAST_SUCCESS"
                elseif find(subEvent, "_CAST_FAILED$") then
                    local payload = self.payload
                    payload.type = "CAST_FAILED"
                    payload.failedType = (arg[index]) or "CAST_FAILED"
                elseif find(subEvent, "_INSTAKILL$") then
                    self.payload.type = "INSTAKILL"
                elseif find(subEvent, "_DURABILITY_DAMAGE$") then
                    self.payload.type = "DURABILITY_DAMAGE"
                elseif find(subEvent, "_DURABILITY_DAMAGE_ALL$") then
                    self.payload.type = "DURABILITY_DAMAGE_ALL"
                elseif find(subEvent, "_CREATE$") then
                    self.payload.type = "CREATE"
                elseif find(subEvent, "_SUMMON$") then
                    self.payload.type = "SUMMON"
                elseif find(subEvent, "_DISSIPATES$") then
                    self.payload.type = "DISSIPATES"
                end
            end
            self.tracer:debug(self.subEvent, self:getCurrentEventInfo())
            self.fire(self.subEvent)
        end
        self.hasEventHandler = function(event)
            local handlers = self.registry[event]
            return (handlers and next(handlers) and true) or false
        end
        self.fire = function(event)
            if self.registry[event] then
                self.fireDepth = self.fireDepth + 1
                for _, handler in pairs(self.registry[event]) do
                    handler(event)
                end
                self.fireDepth = self.fireDepth - 1
                if self.fireDepth == 0 then
                    for event, handlers in pairs(self.pendingRegistry) do
                        for token, handler in pairs(handlers) do
                            self.insertEventHandler(self.registry, event, token, handler)
                        end
                    end
                end
            end
        end
        self.insertEventHandler = function(registry, event, token, handler)
            local handlers = registry[event] or {}
            local key = token
            handlers[key] = handler
            registry[event] = handlers
        end
        self.removeEventHandler = function(registry, event, token)
            local handlers = registry[event]
            if handlers then
                local key = token
                handlers[key] = nil
                if  not next(handlers) then
                    registry[event] = nil
                end
            end
        end
        self.registerEvent = function(event, token, handler)
            if self.fireDepth > 0 then
                self.insertEventHandler(self.pendingRegistry, event, token, handler)
            else
                self.insertEventHandler(self.registry, event, token, handler)
            end
        end
        self.unregisterEvent = function(event, token)
            self.removeEventHandler(self.pendingRegistry, event, token)
            self.removeEventHandler(self.registry, event, token)
        end
        self.unregisterAllEvents = function(token)
            for event in pairs(self.registry) do
                self.unregisterEvent(event, token)
            end
        end
        self.module = ovale:createModule("CombatLogEvent", self.onEnable, self.onDisable, aceEvent)
        self.tracer = debug:create(self.module:GetName())
    end,
    getCurrentEventInfo = function(self)
        return unpack(self.arg)
    end,
})
