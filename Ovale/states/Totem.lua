local __exports = LibStub:NewLibrary("ovale/states/Totem", 90108)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
__imports.__enginestate = LibStub:GetLibrary("ovale/engine/state")
__imports.States = __imports.__enginestate.States
local aceEvent = __imports.aceEvent
local ipairs = ipairs
local pairs = pairs
local kpairs = pairs
local GetTotemInfo = GetTotemInfo
local MAX_TOTEMS = MAX_TOTEMS
local States = __imports.States
local serial = 0
local TotemData = __class(nil, {
    constructor = function(self)
        self.totems = {}
    end
})
__exports.OvaleTotemClass = __class(States, {
    constructor = function(self, ovale, ovaleState, ovaleData, ovaleFuture, ovaleAura, ovaleSpellBook, ovaleDebug)
        self.ovale = ovale
        self.ovaleData = ovaleData
        self.ovaleFuture = ovaleFuture
        self.ovaleAura = ovaleAura
        self.ovaleSpellBook = ovaleSpellBook
        self.handleInitialize = function()
            self.module:RegisterEvent("PLAYER_ENTERING_WORLD", self.update)
            self.module:RegisterEvent("PLAYER_TALENT_UPDATE", self.update)
            self.module:RegisterEvent("PLAYER_TOTEM_UPDATE", self.update)
            self.module:RegisterEvent("UPDATE_SHAPESHIFT_FORM", self.update)
        end
        self.handleDisable = function()
            self.module:UnregisterEvent("PLAYER_ENTERING_WORLD")
            self.module:UnregisterEvent("PLAYER_TALENT_UPDATE")
            self.module:UnregisterEvent("PLAYER_TOTEM_UPDATE")
            self.module:UnregisterEvent("UPDATE_SHAPESHIFT_FORM")
        end
        self.update = function()
            serial = serial + 1
            self.ovale:needRefresh()
        end
        self.applySpellAfterCast = function(spellId, targetGUID, startCast, endCast, isChanneled, spellcast)
            local si = self.ovaleData.spellInfo[spellId]
            if si and si.totem then
                self:summonTotem(spellId, endCast)
            end
        end
        States.constructor(self, TotemData)
        self.debug = ovaleDebug:create("OvaleTotem")
        self.module = ovale:createModule("OvaleTotem", self.handleInitialize, self.handleDisable, aceEvent)
        ovaleState:registerState(self)
    end,
    initializeState = function(self)
        self.next.totems = {}
        for slot = 1, MAX_TOTEMS + 1, 1 do
            self.next.totems[slot] = {
                slot = slot,
                serial = 0,
                start = 0,
                duration = 0
            }
        end
    end,
    resetState = function(self)
    end,
    cleanState = function(self)
        for slot, totem in pairs(self.next.totems) do
            for k in kpairs(totem) do
                totem[k] = nil
            end
            self.next.totems[slot] = nil
        end
    end,
    isActiveTotem = function(self, totem, atTime)
        if  not totem then
            return false
        end
        if  not totem.serial or totem.serial < serial then
            totem = self:getTotem(totem.slot)
        end
        return (totem and totem.serial == serial and totem.start and totem.duration and totem.start < atTime and atTime < totem.start + totem.duration)
    end,
    getTotem = function(self, slot)
        local totem = self.next.totems[slot]
        if totem and ( not totem.serial or totem.serial < serial) then
            local haveTotem, name, startTime, duration, icon = GetTotemInfo(slot)
            if haveTotem then
                totem.name = name
                totem.start = startTime
                totem.duration = duration
                totem.icon = icon
            else
                totem.name = ""
                totem.start = 0
                totem.duration = 0
                totem.icon = ""
            end
            totem.slot = slot
            totem.serial = serial
        end
        return totem
    end,
    getTotemInfo = function(self, spellId, atTime)
        local start, ending
        local count = 0
        local si = self.ovaleData.spellInfo[spellId]
        if si and si.totem then
            self.debug:log("Spell %s is a totem spell", spellId)
            local buffPresent = self.ovaleFuture.next.lastGCDSpellId == spellId
            if  not buffPresent and si.buff_totem then
                local aura = self.ovaleAura:getAura("player", si.buff_totem, atTime, "HELPFUL")
                buffPresent = (aura and self.ovaleAura:isActiveAura(aura, atTime)) or false
            end
            if  not si.buff_totem or buffPresent then
                local texture = self.ovaleSpellBook:getSpellTexture(spellId)
                local maxTotems = si.max_totems or MAX_TOTEMS + 1
                for slot in ipairs(self.next.totems) do
                    local totem = self:getTotem(slot)
                    if self:isActiveTotem(totem, atTime) and totem.icon == texture then
                        count = count + 1
                        if  not start or start > totem.start then
                            start = totem.start
                        end
                        if  not ending or ending < totem.start + totem.duration then
                            ending = totem.start + totem.duration
                        end
                    end
                    if count >= maxTotems then
                        break
                    end
                end
            end
        else
            self.debug:log("Spell %s is NOT a totem spell", spellId)
        end
        return count, start, ending
    end,
    summonTotem = function(self, spellId, atTime)
        local totemSlot = self:getAvailableTotemSlot(spellId, atTime)
        if totemSlot then
            local name, _, icon = self.ovaleSpellBook:getSpellInfo(spellId)
            local duration = self.ovaleData:getSpellInfoProperty(spellId, atTime, "duration", nil)
            local totem = self.next.totems[totemSlot]
            totem.name = name
            totem.start = atTime
            totem.duration = duration or 15
            totem.icon = icon
            totem.slot = totemSlot
            self.debug:log("Spell ID '%d' summoned a totem in state slot %d", spellId, totemSlot)
        end
    end,
    getAvailableTotemSlot = function(self, spellId, atTime)
        local availableSlot = nil
        local si = self.ovaleData.spellInfo[spellId]
        if si and si.totem then
            local _, _, icon = self.ovaleSpellBook:getSpellInfo(spellId)
            for i = 1, MAX_TOTEMS + 1, 1 do
                local totem = self.next.totems[i]
                if availableSlot == nil and ( not self:isActiveTotem(totem, atTime) or (si.max_totems == 1 and totem.icon == icon)) then
                    availableSlot = i
                end
            end
            if availableSlot == nil then
                availableSlot = 1
                local firstTotem = self.next.totems[1]
                local smallestEndTime = firstTotem.start + firstTotem.duration
                for i = 2, MAX_TOTEMS + 1, 1 do
                    local totem = self.next.totems[i]
                    local endTime = totem.start + totem.duration
                    if endTime < smallestEndTime then
                        availableSlot = i
                    end
                end
            end
        end
        return availableSlot
    end,
})
