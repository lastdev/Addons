local __exports = LibStub:NewLibrary("ovale/states/Spells", 90048)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local INFINITY = math.huge
local kpairs = pairs
local tonumber = tonumber
local aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local GetSpellCount = GetSpellCount
local IsSpellInRange = IsSpellInRange
local IsUsableItem = IsUsableItem
local IsUsableSpell = IsUsableSpell
local UnitIsFriend = UnitIsFriend
local __toolstools = LibStub:GetLibrary("ovale/tools/tools")
local isNumber = __toolstools.isNumber
local warriorInterceptSpellId = 198304
local warriorHeroicThrowSpellId = 57755
__exports.OvaleSpellsClass = __class(nil, {
    constructor = function(self, spellBook, ovale, ovaleDebug, ovaleProfiler, ovaleData, power, runes)
        self.spellBook = spellBook
        self.ovaleData = ovaleData
        self.power = power
        self.runes = runes
        self.handleInitialize = function()
        end
        self.handleDisable = function()
        end
        self.module = ovale:createModule("OvaleSpells", self.handleInitialize, self.handleDisable, aceEvent)
        self.tracer = ovaleDebug:create(self.module:GetName())
        self.profiler = ovaleProfiler:create(self.module:GetName())
    end,
    getCastTime = function(self, spellId)
        if spellId then
            local name, _, _, castTime = self.spellBook:getSpellInfo(spellId)
            if name then
                if castTime then
                    castTime = castTime / 1000
                else
                    castTime = 0
                end
            else
                return nil
            end
            return castTime
        end
    end,
    getSpellCount = function(self, spellId)
        local index, bookType = self.spellBook:getSpellBookIndex(spellId)
        if index and bookType then
            local spellCount = GetSpellCount(index, bookType)
            self.tracer:debug("GetSpellCount: index=%s bookType=%s for spellId=%s ==> spellCount=%s", index, bookType, spellId, spellCount)
            return spellCount
        else
            local spellName = self.spellBook:getSpellName(spellId)
            if spellName then
                local spellCount = GetSpellCount(spellName)
                self.tracer:debug("GetSpellCount: spellName=%s for spellId=%s ==> spellCount=%s", spellName, spellId, spellCount)
                return spellCount
            end
            return 0
        end
    end,
    isSpellInRange = function(self, spellId, unitId)
        local index, bookType = self.spellBook:getSpellBookIndex(spellId)
        local returnValue
        if index and bookType then
            returnValue = IsSpellInRange(index, bookType, unitId)
        elseif self.spellBook:isKnownSpell(spellId) then
            local name = self.spellBook:getSpellName(spellId)
            if name then
                returnValue = IsSpellInRange(name, unitId)
            end
        end
        if returnValue == 1 and spellId == warriorInterceptSpellId then
            return (UnitIsFriend("player", unitId) or self:isSpellInRange(warriorHeroicThrowSpellId, unitId))
        end
        if returnValue == 1 then
            return true
        end
        if returnValue == 0 then
            return false
        end
        return nil
    end,
    cleanState = function(self)
    end,
    initializeState = function(self)
    end,
    resetState = function(self)
    end,
    isUsableItem = function(self, itemId, atTime)
        self.profiler:startProfiling("OvaleSpellBook_state_IsUsableItem")
        local isUsable = IsUsableItem(itemId)
        local ii = self.ovaleData:getItemInfo(itemId)
        if ii then
            if isUsable then
                local unusable = self.ovaleData:getItemInfoProperty(itemId, atTime, "unusable")
                if unusable and unusable > 0 then
                    self.tracer:log("Item ID '%s' is flagged as unusable.", itemId)
                    isUsable = false
                end
            end
        end
        self.profiler:stopProfiling("OvaleSpellBook_state_IsUsableItem")
        return isUsable
    end,
    isUsableSpell = function(self, spellId, atTime, targetGUID)
        self.profiler:startProfiling("OvaleSpellBook_state_IsUsableSpell")
        local isUsable, noMana = false, false
        local isKnown = self.spellBook:isKnownSpell(spellId)
        local si = self.ovaleData.spellInfo[spellId]
        if  not isKnown then
            self.tracer:log("Spell ID '%s' is not known.", spellId)
            isUsable, noMana = false, false
        elseif si ~= nil then
            local unusable = self.ovaleData:getSpellInfoProperty(spellId, atTime, "unusable", targetGUID)
            if unusable ~= nil and tonumber(unusable) > 0 then
                self.tracer:log("Spell ID '%s' is flagged as unusable.", spellId)
                isUsable, noMana = false, false
            else
                local seconds = self:timeToPowerForSpell(spellId, atTime, targetGUID, nil)
                if seconds > 0 then
                    self.tracer:log("Spell ID '%s' does not have enough power.", spellId)
                    isUsable, noMana = false, true
                else
                    self.tracer:log("Spell ID '%s' meets power requirements.", spellId)
                    isUsable, noMana = true, false
                end
            end
        else
            isUsable, noMana = IsUsableSpell(spellId)
        end
        self.profiler:stopProfiling("OvaleSpellBook_state_IsUsableSpell")
        return isUsable, noMana
    end,
    timeToPowerForSpell = function(self, spellId, atTime, targetGUID, powerType, extraPower)
        local timeToPower = 0
        local si = self.ovaleData.spellInfo[spellId]
        if si then
            for _, powerInfo in kpairs(self.power.powerInfos) do
                local pType = powerInfo.type
                if powerType == nil or powerType == pType then
                    local cost = self.power:powerCost(spellId, pType, atTime, targetGUID)
                    if cost > 0 then
                        if extraPower then
                            local extraAmount
                            if pType == "energy" then
                                extraAmount = extraPower.extra_energy
                            elseif pType == "focus" then
                                extraAmount = extraPower.extra_focus
                            end
                            if isNumber(extraAmount) then
                                self.tracer:log("    Spell ID '%d' has cost of %d (+%d) %s", spellId, cost, extraAmount, pType)
                                cost = cost + extraAmount
                            end
                        else
                            self.tracer:log("    spell ID '%d' has cost of %d %s", spellId, cost, pType)
                        end
                        local seconds = self.power:getTimeToPowerAt(self.power.next, cost, pType, atTime)
                        self.tracer:log("    spell ID '%d' requires %f seconds for %d %s", spellId, seconds, cost, pType)
                        if timeToPower < seconds then
                            timeToPower = seconds
                        end
                        if timeToPower == INFINITY then
                            self.tracer:log("    short-circuiting checks for other power requirements")
                            break
                        end
                    end
                end
            end
            if timeToPower ~= INFINITY then
                local runes = self.ovaleData:getSpellInfoProperty(spellId, atTime, "runes", targetGUID)
                if runes then
                    local seconds = self.runes:getRunesCooldown(atTime, runes)
                    self.tracer:log("    spell ID '%d' requires %f seconds for %d runes", spellId, seconds, runes)
                    if timeToPower < seconds then
                        timeToPower = seconds
                    end
                end
            end
        end
        self.tracer:log("Spell ID '%d' requires %f seconds for power requirements.", spellId, timeToPower)
        return timeToPower
    end,
})
