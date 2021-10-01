local __exports = LibStub:NewLibrary("ovale/states/DemonHunterSigils", 90108)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
__imports.__enginestate = LibStub:GetLibrary("ovale/engine/state")
__imports.States = __imports.__enginestate.States
__imports.__toolsQueue = LibStub:GetLibrary("ovale/tools/Queue")
__imports.Queue = __imports.__toolsQueue.Queue
local aceEvent = __imports.aceEvent
local pairs = pairs
local GetTime = GetTime
local States = __imports.States
local Queue = __imports.Queue
local SigilData = __class(nil, {
    constructor = function(self)
        self.chains = __imports.Queue()
        self.flame = __imports.Queue()
        self.kyrian = __imports.Queue()
        self.misery = __imports.Queue()
        self.silence = __imports.Queue()
    end,
})
local checkSigilType = {
    chains = true,
    flame = true,
    kyrian = true,
    misery = true,
    silence = true
}
local sigilTrigger = {
    [306830] = {
        type = "kyrian"
    },
    [189110] = {
        type = "flame",
        talent = 22502
    },
    [202138] = {
        type = "chains"
    },
    [204596] = {
        type = "flame"
    },
    [207684] = {
        type = "misery"
    },
    [202137] = {
        type = "silence"
    }
}
__exports.OvaleSigilClass = __class(States, {
    constructor = function(self, ovale, debug, paperDoll, spellBook)
        self.ovale = ovale
        self.paperDoll = paperDoll
        self.spellBook = spellBook
        self.chargeDuration = 2
        self.onEnable = function()
            if self.ovale.playerClass == "DEMONHUNTER" then
                self.module:RegisterMessage("Ovale_SpecializationChanged", self.onOvaleSpecializationChanged)
                self.module:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", self.onUnitSpellCastSucceeded)
                local specialization = self.paperDoll:getSpecialization()
                self.onOvaleSpecializationChanged("onEnable", specialization, specialization)
            end
        end
        self.onDisable = function()
            if self.ovale.playerClass == "DEMONHUNTER" then
                self.module:UnregisterMessage("Ovale_SpecializationChanged")
                self.module:UnregisterMessage("Ovale_TalentsChanged")
                self.module:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
            end
        end
        self.onOvaleSpecializationChanged = function(event, newSpecialization, oldSpecialization)
            if newSpecialization == "vengeance" then
                self.module:RegisterMessage("Ovale_TalentsChanged", self.onOvaleTalentsChanged)
                self.onOvaleTalentsChanged(event)
            end
        end
        self.onOvaleTalentsChanged = function(event)
            local talent = 22510
            local hasQuickenedSigils = self.spellBook:getTalentPoints(talent) > 0
            self.chargeDuration = 2
            if hasQuickenedSigils then
                self.chargeDuration = self.chargeDuration - 1
            end
        end
        self.onUnitSpellCastSucceeded = function(event, unitId, guid, spellId)
            if unitId == "player" then
                if sigilTrigger[spellId] then
                    local info = sigilTrigger[spellId]
                    local sigilType = info.type
                    local talent = info.talent
                    if  not talent or self.spellBook:getTalentPoints(talent) > 0 then
                        local now = GetTime()
                        local state = self.current
                        self.triggerSigil(state, sigilType, now)
                        local count = state[sigilType].length
                        self.tracer:debug("\"" .. sigilType .. "\" (" .. count .. ") placed at " .. now)
                    end
                end
            end
        end
        self.triggerSigil = function(state, sigilType, atTime)
            local queue = state[sigilType]
            local activationTime = queue:front()
            while activationTime and activationTime < atTime do
                queue:shift()
                activationTime = queue:front()
            end
            activationTime = atTime + self.chargeDuration
            queue:push(activationTime)
        end
        self.applySpellAfterCast = function(spellId, targetGUID, startCast, endCast, channel, spellcast)
            if self.ovale.playerClass == "DEMONHUNTER" then
                if sigilTrigger[spellId] then
                    local info = sigilTrigger[spellId]
                    local sigilType = info.type
                    local talent = info.talent
                    if  not talent or self.spellBook:getTalentPoints(talent) > 0 then
                        local state = self.next
                        self.triggerSigil(state, sigilType, endCast)
                        local count = state[sigilType].length
                        self.tracer:log("\"" .. sigilType .. "\" (" .. count .. ") placed at " .. endCast)
                    end
                end
            end
        end
        States.constructor(self, SigilData)
        self.module = ovale:createModule("OvaleSigil", self.onEnable, self.onDisable, aceEvent)
        self.tracer = debug:create(self.module:GetName())
    end,
    initializeState = function(self)
    end,
    resetState = function(self)
        if self.ovale.playerClass == "DEMONHUNTER" then
            for sigilType in pairs(checkSigilType) do
                local current = self.current[sigilType]
                local next = self.next[sigilType]
                next:clear()
                for i = 1, current.length do
                    local activationTime = current:at(i)
                    if activationTime then
                        next:push(activationTime)
                    end
                end
            end
        end
    end,
    cleanState = function(self)
    end,
    isSigilCharging = function(self, sigilType, atTime)
        local queue = self.next[sigilType]
        for i = 1, queue.length do
            local activationTime = queue:at(i)
            if activationTime then
                local start = activationTime - self.chargeDuration
                if start <= atTime and atTime < activationTime then
                    return true
                end
            end
        end
        return false
    end,
})
