local __exports = LibStub:NewLibrary("ovale/states/DemonHunterSoulFragments", 90108)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
__imports.__enginestate = LibStub:GetLibrary("ovale/engine/state")
__imports.States = __imports.__enginestate.States
local aceEvent = __imports.aceEvent
local pairs = pairs
local max = math.max
local min = math.min
local GetTime = GetTime
local States = __imports.States
local generator = {
    [225919] = 2,
    [203782] = 1
}
local spender = {
    [263648] = -5,
    [228477] = -2,
    [247454] = -5
}
local soulFragmentsId = 203981
local trackedBuff = {
    [soulFragmentsId] = true,
    [187827] = true
}
local SoulFragmentsData = __class(nil, {
    constructor = function(self)
        self.count = 0
    end
})
__exports.OvaleDemonHunterSoulFragmentsClass = __class(States, {
    constructor = function(self, ovale, debug, aura, combatLogEvent, paperDoll)
        self.ovale = ovale
        self.aura = aura
        self.combatLogEvent = combatLogEvent
        self.paperDoll = paperDoll
        self.hasSoulFragmentsHandlers = false
        self.hasMetamorphosis = false
        self.count = 0
        self.pending = 0
        self.onEnable = function()
            if self.ovale.playerClass == "DEMONHUNTER" then
                self.module:RegisterMessage("Ovale_SpecializationChanged", self.onOvaleSpecializationChanged)
                local specialization = self.paperDoll:getSpecialization()
                self.onOvaleSpecializationChanged("onEnable", specialization, specialization)
            end
        end
        self.onDisable = function()
            if self.ovale.playerClass == "DEMONHUNTER" then
                self.module:UnregisterMessage("Ovale_SpecializationChanged")
                self.unregisterSoulFragmentsHandlers()
            end
        end
        self.onOvaleSpecializationChanged = function(event, newSpecialization, oldSpecialization)
            if newSpecialization == "vengeance" then
                self.registerSoulFragmentsHandlers()
                local now = GetTime()
                for auraId in pairs(trackedBuff) do
                    local aura = self.aura:getAura("player", auraId, now, "HELPFUL", true)
                    if aura and self.aura:isActiveAura(aura, now) then
                        self.onOvaleAuraEvent("Ovale_AuraChanged", now, aura.guid, aura.spellId, aura.source)
                    end
                end
            else
                self.unregisterSoulFragmentsHandlers()
            end
        end
        self.registerSoulFragmentsHandlers = function()
            if  not self.hasSoulFragmentsHandlers then
                self.module:RegisterMessage("Ovale_AuraAdded", self.onOvaleAuraEvent)
                self.module:RegisterMessage("Ovale_AuraChanged", self.onOvaleAuraEvent)
                self.module:RegisterMessage("Ovale_AuraRemoved", self.onOvaleAuraEvent)
                self.combatLogEvent.registerEvent("SPELL_CAST_SUCCESS", self, self.onSpellCastSuccess)
                self.hasSoulFragmentsHandlers = true
            end
        end
        self.unregisterSoulFragmentsHandlers = function()
            if self.hasSoulFragmentsHandlers then
                self.module:UnregisterMessage("Ovale_AuraAdded")
                self.module:UnregisterMessage("Ovale_AuraChanged")
                self.module:UnregisterMessage("Ovale_AuraRemoved")
                self.combatLogEvent.unregisterAllEvents(self)
                self.hasSoulFragmentsHandlers = false
                self.hasMetamorphosis = false
                self.count = 0
                self.pending = 0
                self.current.count = 0
            end
        end
        self.onOvaleAuraEvent = function(event, atTime, guid, auraId, caster)
            if guid == self.ovale.playerGUID then
                if auraId == 187827 then
                    if event == "Ovale_AuraAdded" or event == "Ovale_AuraChanged" then
                        self.hasMetamorphosis = true
                    elseif event == "Ovale_AuraRemoved" then
                        self.hasMetamorphosis = false
                    end
                elseif auraId == soulFragmentsId then
                    if event == "Ovale_AuraAdded" or event == "Ovale_AuraChanged" then
                        local aura = self.aura:getAura("player", auraId, atTime, "HELPFUL", true)
                        if aura and self.aura:isActiveAura(aura, atTime) then
                            local gained = aura.stacks - self.count
                            if gained > 0 then
                                self.pending = max(self.pending - gained, 0)
                            end
                            self.count = min(aura.stacks, 5)
                            self.updateCurrentSoulFragments()
                        end
                    elseif event == "Ovale_AuraRemoved" then
                        self.count = 0
                        self.updateCurrentSoulFragments()
                    end
                end
            end
        end
        self.onSpellCastSuccess = function(cleuEvent)
            local cleu = self.combatLogEvent
            if cleu.sourceGUID == self.ovale.playerGUID then
                local header = cleu.header
                local spellId = header.spellId
                local fragments = generator[spellId]
                if fragments and fragments > 0 then
                    self.pending = self.pending + fragments
                    if self.hasMetamorphosis then
                        self.pending = self.pending + 1
                    end
                    self.updateCurrentSoulFragments()
                end
            end
        end
        self.updateCurrentSoulFragments = function()
            self.current.count = min(self.count + self.pending, 5)
            self.pending = max(self.current.count - self.count, 0)
            self.tracer:debug(self.current.count .. " = " .. self.count .. " + " .. self.pending)
        end
        self.applySpellAfterCast = function(spellId, targetGUID, startCast, endCast, channel, spellcast)
            if self.hasSoulFragmentsHandlers then
                if spender[spellId] then
                    local fragments = spender[spellId]
                    if fragments < 0 then
                        local count = self.next.count + fragments
                        self.next.count = max(count, 0)
                    end
                end
                if generator[spellId] then
                    local fragments = generator[spellId]
                    if fragments > 0 then
                        local count = self.next.count + fragments
                        self.next.count = min(count, 5)
                    end
                end
            end
        end
        States.constructor(self, SoulFragmentsData)
        self.module = ovale:createModule("OvaleDemonHunterSoulFragments", self.onEnable, self.onDisable, aceEvent)
        self.tracer = debug:create(self.module:GetName())
    end,
    initializeState = function(self)
    end,
    resetState = function(self)
        if self.hasSoulFragmentsHandlers then
            self.next.count = self.current.count
        end
    end,
    cleanState = function(self)
    end,
    soulFragments = function(self, atTime)
        return self.next.count
    end,
})
