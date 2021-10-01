local __exports = LibStub:NewLibrary("ovale/states/bloodtalons", 90108)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
__imports.__enginestate = LibStub:GetLibrary("ovale/engine/state")
__imports.States = __imports.__enginestate.States
local aceEvent = __imports.aceEvent
local pairs = pairs
local infinity = math.huge
local GetTime = GetTime
local States = __imports.States
local BloodtalonsData = __class(nil, {
    constructor = function(self)
        self.brutal_slash = {
            start = 0,
            ending = 0
        }
        self.moonfire_cat = {
            start = 0,
            ending = 0
        }
        self.rake = {
            start = 0,
            ending = 0
        }
        self.shred = {
            start = 0,
            ending = 0
        }
        self.swipe_cat = {
            start = 0,
            ending = 0
        }
        self.thrash_cat = {
            start = 0,
            ending = 0
        }
    end
})
local btTriggerIdByName = {
    brutal_slash = 202028,
    moonfire_cat = 115625,
    rake = 1822,
    shred = 5221,
    swipe_cat = 106785,
    thrash_cat = 106830
}
local btTriggerNameById = {}
for name, spellId in pairs(btTriggerIdByName) do
    local btTrigger = name
    btTriggerNameById[spellId] = btTrigger
end
local btWindow = 4 + 1
local btThreshold = 3
local btMaxCharges = 2
__exports.Bloodtalons = __class(States, {
    constructor = function(self, ovale, debug, aura, paperDoll, spellBook)
        self.ovale = ovale
        self.aura = aura
        self.paperDoll = paperDoll
        self.spellBook = spellBook
        self.hasBloodtalonsHandlers = false
        self.onEnable = function()
            if self.ovale.playerClass == "DRUID" then
                self.module:RegisterMessage("Ovale_SpecializationChanged", self.onOvaleSpecializationChanged)
                local specialization = self.paperDoll:getSpecialization()
                self.onOvaleSpecializationChanged("onEnable", specialization, specialization)
            end
        end
        self.onDisable = function()
            if self.ovale.playerClass == "DRUID" then
                self.module:UnregisterMessage("Ovale_SpecializationChanged")
                self.module:UnregisterMessage("Ovale_TalentsChanged")
                self.unregisterBloodtalonsHandlers()
            end
        end
        self.onOvaleSpecializationChanged = function(event, newSpecialization, oldSpecialization)
            if newSpecialization == "feral" then
                self.module:RegisterMessage("Ovale_TalentsChanged", self.onOvaleTalentsChanged)
                self.onOvaleTalentsChanged(event)
            end
        end
        self.onOvaleTalentsChanged = function(event)
            local hasBloodtalonsTalent = self.spellBook:getTalentPoints(21649) > 0
            if hasBloodtalonsTalent then
                self.registerBloodtalonsHandlers()
            else
                self.unregisterBloodtalonsHandlers()
            end
        end
        self.registerBloodtalonsHandlers = function()
            if  not self.hasBloodtalonsHandlers then
                self.tracer:debug("Installing Bloodtalons event handlers.")
                self.module:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", self.onUnitSpellCastSucceeded)
                self.module:RegisterMessage("Ovale_AuraAdded", self.onOvaleAuraAddedOrChanged)
                self.module:RegisterMessage("Ovale_AuraChanged", self.onOvaleAuraAddedOrChanged)
                self.hasBloodtalonsHandlers = true
            end
        end
        self.unregisterBloodtalonsHandlers = function()
            if self.hasBloodtalonsHandlers then
                self.tracer:debug("Removing Bloodtalons event handlers.")
                self.module:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
                self.module:UnregisterMessage("Ovale_AuraAdded")
                self.module:UnregisterMessage("Ovale_AuraChanged")
                self.hasBloodtalonsHandlers = false
            end
        end
        self.onUnitSpellCastSucceeded = function(event, unit, castGUID, spellId)
            if unit == "player" then
                local name = btTriggerNameById[spellId]
                if name then
                    local now = GetTime()
                    local btTrigger = name
                    local aura = self.current[btTrigger]
                    aura.start = now
                    aura.ending = now + btWindow
                    if self.tracer:isDebugging() then
                        local active = self:getActiveTrigger()
                        self.tracer:debug("active: " .. active .. ", " .. name .. " (" .. spellId .. ")")
                    end
                end
            end
        end
        self.onOvaleAuraAddedOrChanged = function(event, atTime, guid, auraId, caster)
            if guid == caster and guid == self.ovale.playerGUID and auraId == 145152 then
                local resetTriggers = false
                if event == "Ovale_AuraAdded" then
                    resetTriggers = true
                elseif event == "Ovale_AuraChanged" then
                    local aura = self.aura:getAuraByGUID(guid, auraId, nil, true, atTime)
                    if aura then
                        resetTriggers = aura.stacks == btMaxCharges
                    end
                end
                if resetTriggers then
                    self.tracer:debug("active: 0, Bloodtalons proc!")
                    for name in pairs(btTriggerIdByName) do
                        local btTrigger = name
                        local aura = self.current[btTrigger]
                        aura.start = 0
                        aura.ending = 0
                    end
                end
            end
        end
        self.applySpellAfterCast = function(spellId, targetGUID, startCast, endCast, channel, spellcast)
            if self.hasBloodtalonsHandlers then
                local name = btTriggerNameById[spellId]
                if name then
                    local btTrigger = name
                    local aura = self.next[btTrigger]
                    aura.start = endCast
                    aura.ending = endCast + btWindow
                    local active = self:getActiveTrigger(endCast)
                    if active >= btThreshold then
                        for name in pairs(btTriggerIdByName) do
                            local trigger = name
                            local triggerAura = self.next[trigger]
                            triggerAura.start = 0
                            triggerAura.ending = 0
                        end
                    end
                    self.triggerBloodtalons(endCast)
                end
            end
        end
        self.triggerBloodtalons = function(atTime)
            self.tracer:log("Triggering Bloodtalons.")
            local aura = self.aura:addAuraToGUID(self.ovale.playerGUID, 145152, self.ovale.playerGUID, "HELPFUL", nil, atTime, atTime + 30, atTime)
            aura.stacks = btMaxCharges
        end
        States.constructor(self, BloodtalonsData)
        self.module = ovale:createModule("Bloodtalons", self.onEnable, self.onDisable, aceEvent)
        self.tracer = debug:create(self.module:GetName())
    end,
    getActiveTrigger = function(self, atTime, name)
        local state = self:getState(atTime)
        atTime = atTime or GetTime()
        if name == nil then
            local numActive = 0
            local start = 0
            local ending = infinity
            for name in pairs(btTriggerIdByName) do
                local btTrigger = name
                local aura = state[btTrigger]
                if aura.start <= atTime and atTime < aura.ending then
                    numActive = numActive + 1
                    if start < aura.start then
                        start = aura.start
                    end
                    if ending > aura.ending then
                        ending = aura.ending
                    end
                end
            end
            if numActive > 0 then
                return numActive, start, ending
            end
        elseif btTriggerIdByName[name] then
            local btTrigger = name
            local aura = state[btTrigger]
            if aura.start <= atTime and atTime < aura.ending then
                return 1, aura.start, aura.ending
            end
        end
        return 0, 0, infinity
    end,
    initializeState = function(self)
    end,
    resetState = function(self)
        if self.hasBloodtalonsHandlers then
            local current = self.current
            local state = self.next
            for name in pairs(btTriggerIdByName) do
                local btTrigger = name
                state[btTrigger].start = current[btTrigger].start
                state[btTrigger].ending = current[btTrigger].ending
            end
        end
    end,
    cleanState = function(self)
    end,
})
