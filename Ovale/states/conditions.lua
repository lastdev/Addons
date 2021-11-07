local __exports = LibStub:NewLibrary("ovale/states/conditions", 90112)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.LibBabbleCreatureType = LibStub:GetLibrary("LibBabble-CreatureType-3.0", true)
__imports.LibRangeCheck = LibStub:GetLibrary("LibRangeCheck-2.0", true)
__imports.__enginecondition = LibStub:GetLibrary("ovale/engine/condition")
__imports.parseCondition = __imports.__enginecondition.parseCondition
__imports.returnBoolean = __imports.__enginecondition.returnBoolean
__imports.returnConstant = __imports.__enginecondition.returnConstant
__imports.returnValue = __imports.__enginecondition.returnValue
__imports.returnValueBetween = __imports.__enginecondition.returnValueBetween
__imports.__toolstools = LibStub:GetLibrary("ovale/tools/tools")
__imports.isNumber = __imports.__toolstools.isNumber
__imports.oneTimeMessage = __imports.__toolstools.oneTimeMessage
local LibBabbleCreatureType = __imports.LibBabbleCreatureType
local LibRangeCheck = __imports.LibRangeCheck
local parseCondition = __imports.parseCondition
local returnBoolean = __imports.returnBoolean
local returnConstant = __imports.returnConstant
local returnValue = __imports.returnValue
local returnValueBetween = __imports.returnValueBetween
local ipairs = ipairs
local pairs = pairs
local type = type
local GetBuildInfo = GetBuildInfo
local GetItemCount = GetItemCount
local GetNumTrackingTypes = GetNumTrackingTypes
local GetTrackingInfo = GetTrackingInfo
local GetUnitName = GetUnitName
local GetUnitSpeed = GetUnitSpeed
local HasFullControl = HasFullControl
local IsStealthed = IsStealthed
local UnitCastingInfo = UnitCastingInfo
local UnitChannelInfo = UnitChannelInfo
local UnitClass = UnitClass
local UnitClassification = UnitClassification
local UnitCreatureFamily = UnitCreatureFamily
local UnitCreatureType = UnitCreatureType
local UnitDetailedThreatSituation = UnitDetailedThreatSituation
local UnitExists = UnitExists
local UnitInParty = UnitInParty
local UnitInRaid = UnitInRaid
local UnitIsDead = UnitIsDead
local UnitIsFriend = UnitIsFriend
local UnitIsPVP = UnitIsPVP
local UnitIsUnit = UnitIsUnit
local UnitLevel = UnitLevel
local UnitPower = UnitPower
local UnitPowerMax = UnitPowerMax
local UnitRace = UnitRace
local INFINITY = math.huge
local min = math.min
local lower = string.lower
local upper = string.upper
local sub = string.sub
local isNumber = __imports.isNumber
local oneTimeMessage = __imports.oneTimeMessage
local function bossArmorDamageReduction(target)
    return 0.3
end
local function capitalize(word)
    if  not word then
        return word
    end
    return upper(sub(word, 1, 1)) .. lower(sub(word, 2))
end
local amplification = 146051
local increasedCritEffect3Percents = 44797
local imbuedBuffId = 214336
local steadyFocus = 177668
local checkHaste = {
    base = true,
    melee = true,
    none = true,
    ranged = true,
    spell = true
}
local mapFilter = {
    buff = "HELPFUL",
    debuff = "HARMFUL"
}
__exports.OvaleConditions = __class(nil, {
    computeParameter = function(self, spellId, paramName, atTime)
        return self.data:getSpellInfoProperty(spellId, atTime, paramName, nil)
    end,
    getHastedTime = function(self, seconds, haste, atTime)
        seconds = seconds or 0
        local multiplier = self.paperDoll:getHasteMultiplier(haste, atTime)
        return seconds / multiplier
    end,
    getDiseases = function(self, target, atTime)
        local bpAura = self.auras:getAura(target, 55078, atTime, "HARMFUL", true)
        local ffAura = self.auras:getAura(target, 55095, atTime, "HARMFUL", true)
        return bpAura, ffAura
    end,
    maxPower = function(self, powerType, positionalParams, namedParams, atTime)
        local target = self:parseCondition(positionalParams, namedParams)
        local value
        if target == "player" then
            value = self.powers.current.maxPower[powerType]
        else
            local powerInfo = self.powers.powerInfos[powerType]
            value = (powerInfo and UnitPowerMax(target, powerInfo.id, powerInfo.segments)) or 0
        end
        return returnConstant(value)
    end,
    power = function(self, powerType, positionalParams, namedParams, atTime)
        local target = self:parseCondition(positionalParams, namedParams)
        if target == "player" then
            local value = self.powers.next.power[powerType] or 0
            local rate = self.powers:getPowerRateAt(self.powers.next, powerType, atTime)
            return returnValueBetween(atTime, INFINITY, value, atTime, rate)
        else
            local powerInfo = self.powers.powerInfos[powerType]
            local value = (powerInfo and UnitPower(target, powerInfo.id)) or 0
            return returnConstant(value)
        end
    end,
    powerDeficit = function(self, powerType, positionalParams, namedParams, atTime)
        local target = self:parseCondition(positionalParams, namedParams)
        if target == "player" then
            local powerMax = self.powers.current.maxPower[powerType] or 0
            if powerMax > 0 then
                local power = self.powers.next.power[powerType] or 0
                local rate = self.powers:getPowerRateAt(self.powers.next, powerType, atTime)
                return returnValueBetween(atTime, INFINITY, powerMax - power, atTime, -1 * rate)
            end
        else
            local powerInfo = self.powers.powerInfos[powerType]
            local powerMax = (powerInfo and UnitPowerMax(target, powerInfo.id, powerInfo.segments)) or 0
            if powerMax > 0 then
                local power = (powerInfo and UnitPower(target, powerInfo.id)) or 0
                local value = powerMax - power
                return returnConstant(value)
            end
        end
        return returnConstant(0)
    end,
    powerPercent = function(self, powerType, positionalParams, namedParams, atTime)
        local target = self:parseCondition(positionalParams, namedParams)
        if target == "player" then
            local powerMax = self.powers.current.maxPower[powerType] or 0
            if powerMax > 0 then
                local ratio = 100 / powerMax
                local power = self.powers.next.power[powerType] or 0
                local rate = ratio * self.powers:getPowerRateAt(self.powers.next, powerType, atTime)
                if (rate > 0 and power >= powerMax) or (rate < 0 and power == 0) then
                    rate = 0
                end
                return returnValueBetween(atTime, INFINITY, power * ratio, atTime, rate)
            end
        else
            local powerInfo = self.powers.powerInfos[powerType]
            local powerMax = (powerInfo and UnitPowerMax(target, powerInfo.id, powerInfo.segments)) or 0
            if powerMax > 0 then
                local ratio = 100 / powerMax
                local value = (powerInfo and ratio * UnitPower(target, powerInfo.id)) or 0
                return returnConstant(value)
            end
        end
        return returnConstant(0)
    end,
    powerCost = function(self, powerType, positionalParams, namedParams, atTime)
        local spell = positionalParams[1]
        local spellId = self.spellBook:getKnownSpellId(spell)
        local target = self:parseCondition(positionalParams, namedParams, "target")
        local maxCost = namedParams.max == 1
        local value = (spellId and self.powers:powerCost(spellId, powerType, atTime, target, maxCost)) or 0
        return returnConstant(value)
    end,
    snapshot = function(self, statName, defaultValue, positionalParams, namedParams, atTime)
        local value = self.paperDoll:getState(atTime)[statName] or defaultValue
        return returnConstant(value)
    end,
    snapshotCritChance = function(self, statName, defaultValue, positionalParams, namedParams, atTime)
        local value = self.paperDoll:getState(atTime)[statName] or defaultValue
        if namedParams.unlimited ~= 1 and value > 100 then
            value = 100
        end
        return returnConstant(value)
    end,
    timeToPower = function(self, powerType, level, atTime)
        level = level or 0
        local seconds = self.powers:getTimeToPowerAt(self.powers.next, level, powerType, atTime)
        if seconds == 0 then
            return returnConstant(0)
        elseif seconds < INFINITY then
            return returnValueBetween(0, atTime + seconds, seconds, atTime, -1)
        else
            return returnConstant(INFINITY)
        end
    end,
    timeToPowerFor = function(self, powerType, positionalParams, namedParams, atTime)
        local spellId = positionalParams[1]
        local target = self:parseCondition(positionalParams, namedParams, "target")
        local targetGuid = self.guids:getUnitGUID(target)
        if  not targetGuid then
            return 
        end
        local seconds = self.spells:timeToPowerForSpell(spellId, atTime, targetGuid, powerType)
        if seconds == 0 then
            return returnConstant(0)
        elseif seconds < INFINITY then
            return returnValueBetween(0, atTime + seconds, seconds, atTime, -1)
        else
            return returnConstant(INFINITY)
        end
    end,
    parseCondition = function(self, positionalParams, namedParams, defaultTarget)
        return parseCondition(namedParams, self.baseState, defaultTarget)
    end,
    constructor = function(self, ovaleCondition, data, paperDoll, azeriteEssence, auras, baseState, bloodtalons, cooldown, future, spellBook, frameModule, guids, damageTaken, powers, enemies, lastSpell, health, ovaleOptions, lossOfControl, spellDamage, totem, sigil, demonHunterSoulFragments, runes, bossMod, spells)
        self.data = data
        self.paperDoll = paperDoll
        self.azeriteEssence = azeriteEssence
        self.auras = auras
        self.baseState = baseState
        self.bloodtalons = bloodtalons
        self.cooldown = cooldown
        self.future = future
        self.spellBook = spellBook
        self.frameModule = frameModule
        self.guids = guids
        self.damageTaken = damageTaken
        self.powers = powers
        self.enemies = enemies
        self.lastSpell = lastSpell
        self.health = health
        self.ovaleOptions = ovaleOptions
        self.lossOfControl = lossOfControl
        self.spellDamage = spellDamage
        self.totem = totem
        self.sigil = sigil
        self.demonHunterSoulFragments = demonHunterSoulFragments
        self.runes = runes
        self.bossMod = bossMod
        self.spells = spells
        self.getArmorSetBonus = function(positionalParams, namedParams, atTime)
            oneTimeMessage("Warning: 'ArmorSetBonus()' is depreciated.  Returns 0")
            local value = 0
            return 0, INFINITY, value, 0, 0
        end
        self.getArmorSetParts = function(positionalParams, namedParams, atTime)
            local value = 0
            oneTimeMessage("Warning: 'ArmorSetBonus()' is depreciated.  Returns 0")
            return returnConstant(value)
        end
        self.azeriteEssenceIsMajor = function(positionalParams, namedParams, atTime)
            local essenceId = positionalParams[1]
            local value = self.azeriteEssence:isMajorEssence(essenceId)
            return returnBoolean(value)
        end
        self.azeriteEssenceIsMinor = function(positionalParams, namedParams, atTime)
            local essenceId = positionalParams[1]
            local value = self.azeriteEssence:isMinorEssence(essenceId)
            return returnBoolean(value)
        end
        self.azeriteEssenceIsEnabled = function(positionalParams, namedParams, atTime)
            local essenceId = positionalParams[1]
            local value = self.azeriteEssence:isMajorEssence(essenceId) or self.azeriteEssence:isMinorEssence(essenceId)
            return returnBoolean(value)
        end
        self.azeriteEssenceRank = function(positionalParams, namedParams, atTime)
            local essenceId = positionalParams[1]
            local value = self.azeriteEssence:essenceRank(essenceId)
            return returnConstant(value)
        end
        self.baseDuration = function(positionalParams, namedParams, atTime)
            local auraId = positionalParams[1]
            local value = 0
            if self.data.buffSpellList[auraId] then
                local spellList = self.data.buffSpellList[auraId]
                for id in pairs(spellList) do
                    value = self.auras:getBaseDuration(id, nil, atTime)
                    if value ~= INFINITY then
                        break
                    end
                end
            else
                value = self.auras:getBaseDuration(auraId, nil, atTime)
            end
            return returnConstant(value)
        end
        self.bloodtalonsTriggerCount = function(atTime)
            local active = self.bloodtalons:getActiveTrigger(atTime)
            return returnConstant(active)
        end
        self.bloodtalonsTriggerBuffPresent = function(atTime, name)
            local active, start, ending = self.bloodtalons:getActiveTrigger(atTime, name)
            if active > 0 then
                return start, ending
            end
            return 
        end
        self.bloodtalonsBrutalSlashPresent = function(atTime)
            return self.bloodtalonsTriggerBuffPresent(atTime, "brutal_slash")
        end
        self.bloodtalonsMoonfirePresent = function(atTime)
            return self.bloodtalonsTriggerBuffPresent(atTime, "moonfire_cat")
        end
        self.bloodtalonsRakePresent = function(atTime)
            return self.bloodtalonsTriggerBuffPresent(atTime, "rake")
        end
        self.bloodtalonsShredPresent = function(atTime)
            return self.bloodtalonsTriggerBuffPresent(atTime, "shred")
        end
        self.bloodtalonsSwipePresent = function(atTime)
            return self.bloodtalonsTriggerBuffPresent(atTime, "swipe_cat")
        end
        self.bloodtalonsThrashPresent = function(atTime)
            return self.bloodtalonsTriggerBuffPresent(atTime, "thrash_cat")
        end
        self.buffAmount = function(positionalParams, namedParams, atTime)
            local auraId = positionalParams[1]
            local target, filter, mine = self:parseCondition(positionalParams, namedParams)
            local value = namedParams.value or 1
            local statName = "value1"
            if value == 1 then
                statName = "value1"
            elseif value == 2 then
                statName = "value2"
            elseif value == 3 then
                statName = "value3"
            end
            local aura = self.auras:getAura(target, auraId, atTime, filter, mine)
            if aura and self.auras:isActiveAura(aura, atTime) then
                local value = aura[statName] or 0
                return returnValueBetween(aura.gain, aura.ending, value, aura.start, 0)
            end
            return returnConstant(0)
        end
        self.buffComboPoints = function(positionalParams, namedParams, atTime)
            local combopoints = 0
            oneTimeMessage("Warning: 'BuffComboPoints()' is not implemented.")
            return returnConstant(combopoints)
        end
        self.buffCooldown = function(positionalParams, namedParams, atTime)
            local auraId = positionalParams[1]
            if  not isNumber(auraId) then
                return 
            end
            local target, filter, mine = self:parseCondition(positionalParams, namedParams)
            local aura = self.auras:getAura(target, auraId, atTime, filter, mine)
            if aura then
                local gain = aura.gain
                local cooldownEnding = aura.cooldownEnding or 0
                return returnValueBetween(gain, INFINITY, 0, cooldownEnding, -1)
            end
            return returnConstant(0)
        end
        self.buffCount = function(positionalParams, namedParams, atTime)
            local auraId = positionalParams[1]
            local target, filter, mine = self:parseCondition(positionalParams, namedParams)
            local spellList = self.data.buffSpellList[auraId]
            local count = 0
            for id in pairs(spellList) do
                local aura = self.auras:getAura(target, id, atTime, filter, mine)
                if aura and self.auras:isActiveAura(aura, atTime) then
                    count = count + 1
                end
            end
            return returnConstant(count)
        end
        self.buffCooldownDuration = function(positionalParams, namedParams, atTime)
            local auraId = positionalParams[1]
            local minCooldown = INFINITY
            if self.data.buffSpellList[auraId] then
                for id in pairs(self.data.buffSpellList[auraId]) do
                    local si = self.data.spellInfo[id]
                    local cd = si and si.buff_cd
                    if cd and minCooldown > cd then
                        minCooldown = cd
                    end
                end
            else
                minCooldown = 0
            end
            return returnConstant(minCooldown)
        end
        self.buffCountOnAny = function(positionalParams, namedParams, atTime)
            local auraId = positionalParams[1]
            local _, filter, mine = self:parseCondition(positionalParams, namedParams)
            local excludeUnitId = (namedParams.excludeTarget == 1 and self.baseState.defaultTarget) or nil
            local fractional = (namedParams.count == 0 and true) or false
            local count, _, startChangeCount, endingChangeCount, startFirst, endingLast = self.auras:auraCount(auraId, filter, mine, namedParams.stacks, atTime, excludeUnitId)
            if count > 0 and startChangeCount < INFINITY and fractional then
                local rate = -1 / (endingChangeCount - startChangeCount)
                return returnValueBetween(startFirst, endingLast, count, startChangeCount, rate)
            end
            return returnConstant(count)
        end
        self.buffDirection = function(positionalParams, namedParams, atTime)
            local auraId = positionalParams[1]
            local target, filter, mine = self:parseCondition(positionalParams, namedParams)
            local aura = self.auras:getAura(target, auraId, atTime, filter, mine)
            if aura then
                return returnValueBetween(aura.gain, INFINITY, aura.direction, aura.gain, 0)
            end
            return returnConstant(0)
        end
        self.buffDuration = function(positionalParams, namedParams, atTime)
            local auraId = positionalParams[1]
            local target, filter, mine = self:parseCondition(positionalParams, namedParams)
            local aura = self.auras:getAura(target, auraId, atTime, filter, mine)
            if aura and self.auras:isActiveAura(aura, atTime) then
                local duration = aura.ending - aura.start
                return returnValueBetween(aura.gain, aura.ending, duration, aura.start, 0)
            end
            return returnConstant(0)
        end
        self.buffExpires = function(positionalParams, namedParams, atTime)
            local auraId, seconds = positionalParams[1], positionalParams[2] or 0
            local target, filter, mine = self:parseCondition(positionalParams, namedParams)
            if  not isNumber(auraId) or  not isNumber(seconds) then
                return 
            end
            local aura = self.auras:getAura(target, auraId, atTime, filter, mine)
            if aura then
                local gain, _, ending = aura.gain, aura.start, aura.ending
                local hastedSeconds = self:getHastedTime(seconds, namedParams.haste, atTime)
                if ending - hastedSeconds <= gain then
                    return gain, INFINITY
                else
                    return ending - hastedSeconds, INFINITY
                end
            end
            return 0, INFINITY
        end
        self.buffPresent = function(atTime, auraId, target, filter, mine, seconds, haste)
            local aura = self.auras:getAura(target, auraId, atTime, filter, mine)
            if aura then
                local gain, _, ending = aura.gain, aura.start, aura.ending
                seconds = self:getHastedTime(seconds, haste, atTime)
                if ending - seconds <= gain then
                    return 
                else
                    return gain, ending - seconds
                end
            end
            return 
        end
        self.buffGain = function(positionalParams, namedParams, atTime)
            local auraId = positionalParams[1]
            local target, filter, mine = self:parseCondition(positionalParams, namedParams)
            local aura = self.auras:getAura(target, auraId, atTime, filter, mine)
            if aura then
                local gain = aura.gain or 0
                return returnValueBetween(gain, INFINITY, 0, gain, 1)
            end
            return returnConstant(0)
        end
        self.buffImproved = function(positionalParams, namedParams, atTime)
            local _, _ = self:parseCondition(positionalParams, namedParams)
            return returnConstant(0)
        end
        self.buffPersistentMultiplier = function(positionalParams, namedParams, atTime)
            local auraId = positionalParams[1]
            local target, filter, mine = self:parseCondition(positionalParams, namedParams)
            local aura = self.auras:getAura(target, auraId, atTime, filter, mine)
            if aura and self.auras:isActiveAura(aura, atTime) then
                local value = aura.damageMultiplier or 1
                return returnValueBetween(aura.gain, aura.ending, value, aura.start, 0)
            end
            return returnConstant(1)
        end
        self.buffRemaining = function(positionalParams, namedParams, atTime)
            local auraId = positionalParams[1]
            local target, filter, mine = self:parseCondition(positionalParams, namedParams)
            local aura = self.auras:getAura(target, auraId, atTime, filter, mine)
            if aura and aura.ending >= atTime then
                return returnValueBetween(aura.gain, INFINITY, 0, aura.ending, -1)
            end
            return returnConstant(0)
        end
        self.buffRemainingOnAny = function(positionalParams, namedParams, atTime)
            local auraId = positionalParams[1]
            local _, filter, mine = self:parseCondition(positionalParams, namedParams)
            local excludeUnitId = (namedParams.excludeTarget == 1 and self.baseState.defaultTarget) or nil
            local count, _, _, _, startFirst, endingLast = self.auras:auraCount(auraId, filter, mine, namedParams.stacks, atTime, excludeUnitId)
            if count > 0 then
                return returnValueBetween(startFirst, INFINITY, 0, endingLast, -1)
            end
            return returnConstant(0)
        end
        self.buffStacks = function(positionalParams, namedParams, atTime)
            local auraId = positionalParams[1]
            local target, filter, mine = self:parseCondition(positionalParams, namedParams)
            local aura = self.auras:getAura(target, auraId, atTime, filter, mine)
            if aura and self.auras:isActiveAura(aura, atTime) then
                local value = aura.stacks or 0
                return returnValueBetween(aura.gain, aura.ending, value, aura.start, 0)
            end
            return returnConstant(0)
        end
        self.maxStacks = function(positionalParams, namedParameters, atTime)
            local auraId = positionalParams[1]
            local spellInfo = self.data:getSpellOrListInfo(auraId)
            local maxStacks = (spellInfo and spellInfo.max_stacks) or 0
            return returnConstant(maxStacks)
        end
        self.buffStacksOnAny = function(positionalParams, namedParams, atTime)
            local auraId = positionalParams[1]
            local _, filter, mine = self:parseCondition(positionalParams, namedParams)
            local excludeUnitId = (namedParams.excludeTarget == 1 and self.baseState.defaultTarget) or nil
            local count, stacks, _, endingChangeCount, startFirst = self.auras:auraCount(auraId, filter, mine, 1, atTime, excludeUnitId)
            if count > 0 then
                return returnValueBetween(startFirst, endingChangeCount, stacks, startFirst, 0)
            end
            return returnConstant(count)
        end
        self.buffStealable = function(positionalParams, namedParams, atTime)
            local target = self:parseCondition(positionalParams, namedParams)
            return self.auras:getAuraWithProperty(target, "stealable", "HELPFUL", atTime)
        end
        self.canCast = function(positionalParams, namedParams, atTime)
            local spellId = positionalParams[1]
            local start, duration = self.cooldown:getSpellCooldown(spellId, atTime)
            return start + duration, INFINITY
        end
        self.castTime = function(positionalParams, namedParams, atTime)
            local spellId = positionalParams[1]
            local castTime = self.spellBook:getCastTime(spellId) or 0
            return returnConstant(castTime)
        end
        self.executeTime = function(positionalParams, namedParams, atTime)
            local spellId = positionalParams[1]
            local castTime = self.spellBook:getCastTime(spellId) or 0
            local gcd = self.future:getGCD(atTime)
            local t = (castTime > gcd and castTime) or gcd
            return returnConstant(t)
        end
        self.casting = function(positionalParams, namedParams, atTime)
            local spellId = positionalParams[1]
            local target = self:parseCondition(positionalParams, namedParams)
            local start, ending, castSpellId, castSpellName
            if target == "player" then
                start = self.future.next.currentCast.start
                ending = self.future.next.currentCast.stop
                castSpellId = self.future.next.currentCast.spellId
                castSpellName = self.spellBook:getSpellName(castSpellId)
            else
                local spellName, _, _, startTime, endTime = UnitCastingInfo(target)
                if  not spellName then
                    spellName, _, _, startTime, endTime = UnitChannelInfo(target)
                end
                if spellName then
                    castSpellName = spellName
                    start = startTime / 1000
                    ending = endTime / 1000
                end
            end
            if (castSpellId or castSpellName) and start and ending then
                if  not spellId then
                    return start, ending
                elseif self.data.buffSpellList[spellId] then
                    for id in pairs(self.data.buffSpellList[spellId]) do
                        if id == castSpellId or self.spellBook:getSpellName(id) == castSpellName then
                            return start, ending
                        end
                    end
                elseif spellId == "harmful" and self.spellBook:isHarmfulSpell(spellId) then
                    return start, ending
                elseif spellId == "helpful" and self.spellBook:isHelpfulSpell(spellId) then
                    return start, ending
                elseif spellId == castSpellId then
                    oneTimeMessage("%f %f %d %s => %d (%f)", start, ending, castSpellId, castSpellName, spellId, self.baseState.currentTime)
                    return start, ending
                elseif type(spellId) == "number" and self.spellBook:getSpellName(spellId) == castSpellName then
                    return start, ending
                end
            end
            return 
        end
        self.checkBoxOff = function(positionalParams, namedParams, atTime)
            for _, id in ipairs(positionalParams) do
                if self.frameModule.frame and self.frameModule.frame:isChecked(id) then
                    return 
                end
            end
            return 0, INFINITY
        end
        self.checkBoxOn = function(positionalParams, namedParams, atTime)
            for _, id in ipairs(positionalParams) do
                if self.frameModule.frame and  not self.frameModule.frame:isChecked(id) then
                    return 
                end
            end
            return 0, INFINITY
        end
        self.getClass = function(positionalParams, namedParams, atTime)
            local className = positionalParams[1]
            local target = self:parseCondition(positionalParams, namedParams)
            local classToken
            if target == "player" then
                classToken = self.paperDoll.class
            else
                _, classToken = UnitClass(target)
            end
            local boolean = classToken == upper(className)
            return returnBoolean(boolean)
        end
        self.classification = function(positionalParams, namedParams, atTime)
            local classification = positionalParams[1]
            local targetClassification
            local target = self:parseCondition(positionalParams, namedParams)
            if UnitLevel(target) < 0 then
                targetClassification = "worldboss"
            elseif UnitExists("boss1") and self.guids:getUnitGUID(target) == self.guids:getUnitGUID("boss1") then
                targetClassification = "worldboss"
            else
                local aura = self.auras:getAura(target, imbuedBuffId, atTime, "HARMFUL", false)
                if aura and self.auras:isActiveAura(aura, atTime) then
                    targetClassification = "worldboss"
                else
                    targetClassification = UnitClassification(target)
                    if targetClassification == "rareelite" then
                        targetClassification = "elite"
                    elseif targetClassification == "rare" then
                        targetClassification = "normal"
                    end
                end
            end
            local boolean = targetClassification == classification
            return returnBoolean(boolean)
        end
        self.counter = function(positionalParams, namedParams, atTime)
            local counter = positionalParams[1]
            local value = self.future:getCounter(counter, atTime)
            return returnConstant(value)
        end
        self.creatureFamily = function(_, name, target)
            name = capitalize(name)
            local family = UnitCreatureFamily(target)
            local lookupTable = LibBabbleCreatureType and LibBabbleCreatureType:GetLookupTable()
            return returnBoolean(lookupTable and family == lookupTable[name])
        end
        self.creatureType = function(positionalParams, namedParams, atTime)
            local target = self:parseCondition(positionalParams, namedParams)
            local creatureType = UnitCreatureType(target)
            local lookupTable = LibBabbleCreatureType and LibBabbleCreatureType:GetLookupTable()
            if lookupTable then
                for _, name in ipairs(positionalParams) do
                    local capitalizedName = capitalize(name)
                    if creatureType == lookupTable[capitalizedName] then
                        return 0, INFINITY
                    end
                end
            end
            return 
        end
        self.critDamage = function(positionalParams, namedParams, atTime)
            local spellId = positionalParams[1]
            local target = self:parseCondition(positionalParams, namedParams, "target")
            local value = self:computeParameter(spellId, "damage", atTime) or 0
            local si = self.data.spellInfo[spellId]
            if si and si.physical == 1 then
                value = value * (1 - bossArmorDamageReduction(target))
            end
            local critMultiplier = 2
            do
                local aura = self.auras:getAura("player", amplification, atTime, "HELPFUL")
                if aura and self.auras:isActiveAura(aura, atTime) then
                    critMultiplier = critMultiplier + (aura.value1 or 0)
                end
            end
            do
                local aura = self.auras:getAura("player", increasedCritEffect3Percents, atTime, "HELPFUL")
                if aura and self.auras:isActiveAura(aura, atTime) then
                    critMultiplier = critMultiplier * (aura.value1 or 0)
                end
            end
            value = critMultiplier * value
            return returnConstant(value)
        end
        self.damage = function(positionalParams, namedParams, atTime)
            local spellId = positionalParams[1]
            local target = self:parseCondition(positionalParams, namedParams, "target")
            local value = self:computeParameter(spellId, "damage", atTime) or 0
            local si = self.data.spellInfo[spellId]
            if si and si.physical == 1 then
                value = value * (1 - bossArmorDamageReduction(target))
            end
            return returnConstant(value)
        end
        self.getDamageTaken = function(positionalParams, namedParams, atTime)
            local interval = positionalParams[1]
            local value = 0
            if interval > 0 then
                local total = self.damageTaken:getRecentDamage(interval)
                value = total
            end
            return returnConstant(value)
        end
        self.magicDamageTaken = function(positionalParams, namedParams, atTime)
            local interval = positionalParams[1]
            local value = 0
            if interval > 0 then
                local _, totalMagic = self.damageTaken:getRecentDamage(interval)
                value = totalMagic
            end
            return returnConstant(value)
        end
        self.physicalDamageTaken = function(positionalParams, namedParams, atTime)
            local interval = positionalParams[1]
            local value = 0
            if interval > 0 then
                local total, totalMagic = self.damageTaken:getRecentDamage(interval)
                value = total - totalMagic
            end
            return returnConstant(value)
        end
        self.diseasesRemaining = function(positionalParams, namedParams, atTime)
            local target, _ = self:parseCondition(positionalParams, namedParams)
            local bpAura, ffAura = self:getDiseases(target, atTime)
            local aura
            if bpAura and self.auras:isActiveAura(bpAura, atTime) and ffAura and self.auras:isActiveAura(ffAura, atTime) then
                aura = (bpAura.ending < ffAura.ending and bpAura) or ffAura
            end
            if aura then
                return returnValueBetween(aura.gain, INFINITY, 0, aura.ending, -1)
            end
            return returnConstant(0)
        end
        self.diseasesTicking = function(positionalParams, namedParams, atTime)
            local target, _ = self:parseCondition(positionalParams, namedParams)
            local bpAura, ffAura = self:getDiseases(target, atTime)
            local gain, ending
            if bpAura and ffAura then
                gain = (bpAura.gain > ffAura.gain and bpAura.gain) or ffAura.gain
                ending = (bpAura.ending < ffAura.ending and bpAura.ending) or ffAura.ending
            end
            if gain and ending and ending > gain then
                return gain, ending
            end
            return 
        end
        self.diseasesAnyTicking = function(positionalParams, namedParams, atTime)
            local target, _ = self:parseCondition(positionalParams, namedParams)
            local bpAura, ffAura = self:getDiseases(target, atTime)
            local aura
            if bpAura or ffAura then
                aura = bpAura or ffAura
                if bpAura and ffAura then
                    aura = (bpAura.ending > ffAura.ending and bpAura) or ffAura
                end
            end
            if aura then
                local gain, _, ending = aura.gain, aura.start, aura.ending
                if ending > gain then
                    return gain, ending
                end
            end
            return 
        end
        self.distance = function(positionalParams, namedParams, atTime)
            local target = self:parseCondition(positionalParams, namedParams)
            local value = (LibRangeCheck and LibRangeCheck:GetRange(target)) or 0
            return returnConstant(value)
        end
        self.getEnemies = function(positionalParams, namedParams, atTime)
            local value = self.enemies.next.enemies
            if  not value then
                local useTagged = self.ovaleOptions.db.profile.apparence.taggedEnemies
                if namedParams.tagged == 0 then
                    useTagged = false
                elseif namedParams.tagged == 1 then
                    useTagged = true
                end
                value = (useTagged and self.enemies.next.taggedEnemies) or self.enemies.next.activeEnemies
            end
            if value < 1 then
                value = 1
            end
            return returnConstant(value)
        end
        self.energyRegenRate = function(positionalParams, namedParams, atTime)
            local value = self.powers:getPowerRateAt(self.powers.next, "energy", atTime)
            return returnConstant(value)
        end
        self.enrageRemaining = function(positionalParams, namedParams, atTime)
            local target = self:parseCondition(positionalParams, namedParams)
            local aura = self.auras:getAura(target, "enrage", atTime, "HELPFUL", false)
            if aura and aura.ending >= atTime then
                return returnValueBetween(aura.gain, INFINITY, 0, aura.ending, -1)
            end
            return returnConstant(0)
        end
        self.exists = function(positionalParams, namedParams, atTime)
            local target = self:parseCondition(positionalParams, namedParams)
            local boolean = UnitExists(target)
            return returnBoolean(boolean)
        end
        self.getFalse = function(positionalParams, namedParams, atTime)
            return 
        end
        self.focusRegenRate = function(positionalParams, namedParams, atTime)
            local value = self.powers:getPowerRateAt(self.powers.next, "focus", atTime)
            return returnConstant(value)
        end
        self.focusCastingRegen = function(positionalParams, namedParams, atTime)
            local spellId = positionalParams[1]
            local regenRate = self.powers:getPowerRateAt(self.powers.next, "focus", atTime)
            local power = 0
            local castTime = self.spellBook:getCastTime(spellId) or 0
            local gcd = self.future:getGCD(atTime)
            local castSeconds = (castTime > gcd and castTime) or gcd
            power = power + regenRate * castSeconds
            local aura = self.auras:getAura("player", steadyFocus, atTime, "HELPFUL", true)
            if aura then
                local seconds = aura.ending - atTime
                if seconds <= 0 then
                    seconds = 0
                elseif seconds > castSeconds then
                    seconds = castSeconds
                end
                power = power + regenRate * 1.5 * seconds
            end
            return returnConstant(power)
        end
        self.getGCD = function(positionalParams, namedParams, atTime)
            local value = self.future:getGCD(atTime)
            return returnConstant(value)
        end
        self.getGCDRemaining = function(positionalParams, namedParams, atTime)
            local target = self:parseCondition(positionalParams, namedParams, "target")
            if self.future.next.lastGCDSpellId then
                local duration = self.future:getGCD(self.future.next.lastGCDSpellId, atTime, self.guids:getUnitGUID(target))
                local spellcast = self.lastSpell:lastInFlightSpell()
                local start = (spellcast and spellcast.start) or 0
                local ending = start + duration
                if atTime < ending then
                    return returnValueBetween(start, INFINITY, 0, ending, -1)
                end
            end
            return returnConstant(0)
        end
        self.glyph = function(positionalParams, namedParams, atTime)
            return returnBoolean(false)
        end
        self.getGuid = function(positionalParams, namedParams)
            local target = self:parseCondition(positionalParams, namedParams, "target")
            return returnConstant(self.guids:getUnitGUID(target))
        end
        self.getTargetGuid = function(positionalParams, namedParams)
            local target = self:parseCondition(positionalParams, namedParams, "target")
            local unitId = target .. "target"
            return returnConstant(self.guids:getUnitGUID(unitId))
        end
        self.hasFullControlCondition = function(positionalParams, namedParams, atTime)
            local boolean = HasFullControl()
            return returnBoolean(boolean)
        end
        self.getHealth = function(positionalParams, namedParams, atTime)
            local target = self:parseCondition(positionalParams, namedParams)
            local health = self.health:getUnitHealth(target) or 0
            if health > 0 then
                local now = self.baseState.currentTime
                local timeToDie = self.health:getUnitTimeToDie(target)
                local rate = (-1 * health) / timeToDie
                return returnValueBetween(now, INFINITY, health, now, rate)
            end
            return returnConstant(0)
        end
        self.effectiveHealth = function(positionalParams, namedParams, atTime)
            local target = self:parseCondition(positionalParams, namedParams)
            local health = self.health:getUnitHealth(target) + self.health:getUnitAbsorb(target) - self.health:getUnitHealAbsorb(target) or 0
            local now = self.baseState.currentTime
            local timeToDie = self.health:getUnitTimeToDie(target)
            local rate = (-1 * health) / timeToDie
            return returnValueBetween(now, INFINITY, health, now, rate)
        end
        self.healthMissing = function(positionalParams, namedParams, atTime)
            local target = self:parseCondition(positionalParams, namedParams)
            local health = self.health:getUnitHealth(target) or 0
            local maxHealth = self.health:getUnitHealthMax(target) or 1
            if health > 0 then
                local now = self.baseState.currentTime
                local missing = maxHealth - health
                local timeToDie = self.health:getUnitTimeToDie(target)
                local rate = health / timeToDie
                return returnValueBetween(now, INFINITY, missing, now, rate)
            end
            return returnConstant(maxHealth)
        end
        self.healthPercent = function(positionalParams, namedParams, atTime)
            local target = self:parseCondition(positionalParams, namedParams)
            local health = self.health:getUnitHealth(target) or 0
            if health > 0 then
                local now = self.baseState.currentTime
                local maxHealth = self.health:getUnitHealthMax(target) or 1
                local healthPct = (health / maxHealth) * 100
                local timeToDie = self.health:getUnitTimeToDie(target)
                local rate = (-1 * healthPct) / timeToDie
                return returnValueBetween(now, INFINITY, healthPct, now, rate)
            end
            return returnConstant(0)
        end
        self.effectiveHealthPercent = function(positionalParams, namedParams, atTime)
            local target = self:parseCondition(positionalParams, namedParams)
            local health = self.health:getUnitHealth(target) + self.health:getUnitAbsorb(target) - self.health:getUnitHealAbsorb(target) or 0
            local now = self.baseState.currentTime
            local maxHealth = self.health:getUnitHealthMax(target) or 1
            local healthPct = (health / maxHealth) * 100
            local timeToDie = self.health:getUnitTimeToDie(target)
            local rate = (-1 * healthPct) / timeToDie
            return returnValueBetween(now, INFINITY, healthPct, now, rate)
        end
        self.maxHealth = function(positionalParams, namedParams, atTime)
            local target = self:parseCondition(positionalParams, namedParams)
            local value = self.health:getUnitHealthMax(target)
            return returnConstant(value)
        end
        self.timeToDie = function(positionalParams, namedParams, atTime)
            local target = self:parseCondition(positionalParams, namedParams)
            local now = self.baseState.currentTime
            local timeToDie = self.health:getUnitTimeToDie(target)
            return returnValueBetween(now, INFINITY, timeToDie, now, -1)
        end
        self.timeToHealthPercent = function(positionalParams, namedParams, atTime)
            local percent = positionalParams[1]
            local target = self:parseCondition(positionalParams, namedParams)
            local health = self.health:getUnitHealth(target) or 0
            if health > 0 then
                local maxHealth = self.health:getUnitHealthMax(target) or 1
                local healthPct = (health / maxHealth) * 100
                if healthPct >= percent then
                    local now = self.baseState.currentTime
                    local timeToDie = self.health:getUnitTimeToDie(target)
                    local t = (timeToDie * (healthPct - percent)) / healthPct
                    return returnValueBetween(now, now + t, t, now, -1)
                end
            end
            return returnConstant(0)
        end
        self.inFlightToTarget = function(positionalParams, namedParams, atTime)
            local spellId = positionalParams[1]
            local boolean = self.future.next.currentCast.spellId == spellId or self.future:isInFlight(spellId)
            return returnBoolean(boolean)
        end
        self.inRange = function(positionalParams, namedParams, atTime)
            local spellId = positionalParams[1]
            local target = self:parseCondition(positionalParams, namedParams)
            local boolean = self.spells:isSpellInRange(spellId, target)
            return returnBoolean(boolean or false)
        end
        self.isAggroed = function(positionalParams, namedParams, atTime)
            local target = self:parseCondition(positionalParams, namedParams)
            local boolean = UnitDetailedThreatSituation("player", target)
            return returnBoolean(boolean or false)
        end
        self.isDead = function(positionalParams, namedParams, atTime)
            local target = self:parseCondition(positionalParams, namedParams)
            local boolean = UnitIsDead(target)
            return returnBoolean(boolean or false)
        end
        self.isEnraged = function(positionalParams, namedParams, atTime)
            local target = self:parseCondition(positionalParams, namedParams)
            local aura = self.auras:getAura(target, "enrage", atTime, "HELPFUL", false)
            if aura then
                local gain, _, ending = aura.gain, aura.start, aura.ending
                return gain, ending
            end
            return 
        end
        self.isFeared = function(positionalParams, namedParams, atTime)
            local boolean = self.lossOfControl.hasLossOfControl("FEAR", atTime) or self.lossOfControl.hasLossOfControl("FEAR_MECHANIC", atTime)
            return returnBoolean(boolean)
        end
        self.isFriend = function(positionalParams, namedParams, atTime)
            local target = self:parseCondition(positionalParams, namedParams)
            local boolean = UnitIsFriend("player", target)
            return returnBoolean(boolean)
        end
        self.isIncapacitated = function(positionalParams, namedParams, atTime)
            local boolean = self.lossOfControl.hasLossOfControl("CONFUSE", atTime) or self.lossOfControl.hasLossOfControl("STUN", atTime)
            return returnBoolean(boolean)
        end
        self.isInterruptible = function(positionalParams, namedParams, atTime)
            local target = self:parseCondition(positionalParams, namedParams)
            local name, _, _, _, _, _, _, notInterruptible = UnitCastingInfo(target)
            if  not name then
                name, _, _, _, _, _, notInterruptible = UnitChannelInfo(target)
            end
            local boolean = notInterruptible ~= nil and  not notInterruptible
            return returnBoolean(boolean)
        end
        self.isPVP = function(positionalParams, namedParams, atTime)
            local target = self:parseCondition(positionalParams, namedParams)
            local boolean = UnitIsPVP(target)
            return returnBoolean(boolean)
        end
        self.isRooted = function(positionalParams, namedParams, atTime)
            local boolean = self.lossOfControl.hasLossOfControl("ROOT", atTime)
            return returnBoolean(boolean)
        end
        self.isStunned = function(positionalParams, namedParams, atTime)
            local boolean = self.lossOfControl.hasLossOfControl("STUN_MECHANIC", atTime)
            return returnBoolean(boolean)
        end
        self.itemCharges = function(positionalParams, namedParams, atTime)
            local itemId = positionalParams[1]
            local value = GetItemCount(itemId, false, true)
            return returnConstant(value)
        end
        self.itemCount = function(positionalParams, namedParams, atTime)
            local itemId = positionalParams[1]
            local value = GetItemCount(itemId)
            return returnConstant(value)
        end
        self.lastDamage = function(positionalParams, namedParams, atTime)
            local spellId = positionalParams[1]
            local value = self.spellDamage:getSpellDamage(spellId)
            if value then
                return returnConstant(value)
            end
            return 
        end
        self.level = function(positionalParams, namedParams, atTime)
            local target = self:parseCondition(positionalParams, namedParams)
            local value
            if target == "player" then
                value = self.paperDoll.level
            else
                value = UnitLevel(target)
            end
            return returnConstant(value)
        end
        self.list = function(positionalParams, namedParams, atTime)
            local name, value = positionalParams[1], positionalParams[2]
            if name and self.frameModule.frame and self.frameModule.frame:getListValue(name) == value then
                return 0, INFINITY
            end
            return 
        end
        self.name = function(atTime, target)
            return returnConstant(GetUnitName(target, true))
        end
        self.isPtr = function(positionalParams, namedParams, atTime)
            local version, _, _, uiVersion = GetBuildInfo()
            local value = ((version > "9.0.2" or uiVersion > 90002) and 1) or 0
            return returnConstant(value)
        end
        self.persistentMultiplier = function(positionalParams, namedParams, atTime)
            local spellId = positionalParams[1]
            local target = self:parseCondition(positionalParams, namedParams, "target")
            local targetGuid = self.guids:getUnitGUID(target)
            if  not targetGuid then
                return 
            end
            local value = self.future:getDamageMultiplier(spellId, targetGuid, atTime)
            return returnConstant(value)
        end
        self.petPresent = function(positionalParams, namedParams, atTime)
            local name = namedParams.name
            local target = "pet"
            local boolean = UnitExists(target) and  not UnitIsDead(target) and (name == nil or name == GetUnitName(target, true))
            return returnBoolean(boolean)
        end
        self.alternatePower = function(positionalParams, namedParams, atTime)
            return self:power("alternate", positionalParams, namedParams, atTime)
        end
        self.astralPower = function(positionalParams, namedParams, atTime)
            return self:power("lunarpower", positionalParams, namedParams, atTime)
        end
        self.chi = function(positionalParams, namedParams, atTime)
            return self:power("chi", positionalParams, namedParams, atTime)
        end
        self.comboPoints = function(positionalParams, namedParams, atTime)
            return self:power("combopoints", positionalParams, namedParams, atTime)
        end
        self.energy = function(positionalParams, namedParams, atTime)
            return self:power("energy", positionalParams, namedParams, atTime)
        end
        self.focus = function(positionalParams, namedParams, atTime)
            return self:power("focus", positionalParams, namedParams, atTime)
        end
        self.fury = function(positionalParams, namedParams, atTime)
            return self:power("fury", positionalParams, namedParams, atTime)
        end
        self.holyPower = function(positionalParams, namedParams, atTime)
            return self:power("holypower", positionalParams, namedParams, atTime)
        end
        self.insanity = function(positionalParams, namedParams, atTime)
            return self:power("insanity", positionalParams, namedParams, atTime)
        end
        self.mana = function(positionalParams, namedParams, atTime)
            return self:power("mana", positionalParams, namedParams, atTime)
        end
        self.maelstrom = function(positionalParams, namedParams, atTime)
            return self:power("maelstrom", positionalParams, namedParams, atTime)
        end
        self.pain = function(positionalParams, namedParams, atTime)
            return self:power("pain", positionalParams, namedParams, atTime)
        end
        self.rage = function(positionalParams, namedParams, atTime)
            return self:power("rage", positionalParams, namedParams, atTime)
        end
        self.runicPower = function(positionalParams, namedParams, atTime)
            return self:power("runicpower", positionalParams, namedParams, atTime)
        end
        self.soulShards = function(positionalParams, namedParams, atTime)
            return self:power("soulshards", positionalParams, namedParams, atTime)
        end
        self.arcaneCharges = function(positionalParams, namedParams, atTime)
            return self:power("arcanecharges", positionalParams, namedParams, atTime)
        end
        self.alternatePowerDeficit = function(positionalParams, namedParams, atTime)
            return self:powerDeficit("alternate", positionalParams, namedParams, atTime)
        end
        self.astralPowerDeficit = function(positionalParams, namedParams, atTime)
            return self:powerDeficit("lunarpower", positionalParams, namedParams, atTime)
        end
        self.chiDeficit = function(positionalParams, namedParams, atTime)
            return self:powerDeficit("chi", positionalParams, namedParams, atTime)
        end
        self.comboPointsDeficit = function(positionalParams, namedParams, atTime)
            return self:powerDeficit("combopoints", positionalParams, namedParams, atTime)
        end
        self.energyDeficit = function(positionalParams, namedParams, atTime)
            return self:powerDeficit("energy", positionalParams, namedParams, atTime)
        end
        self.focusDeficit = function(positionalParams, namedParams, atTime)
            return self:powerDeficit("focus", positionalParams, namedParams, atTime)
        end
        self.furyDeficit = function(positionalParams, namedParams, atTime)
            return self:powerDeficit("fury", positionalParams, namedParams, atTime)
        end
        self.holyPowerDeficit = function(positionalParams, namedParams, atTime)
            return self:powerDeficit("holypower", positionalParams, namedParams, atTime)
        end
        self.manaDeficit = function(positionalParams, namedParams, atTime)
            return self:powerDeficit("mana", positionalParams, namedParams, atTime)
        end
        self.painDeficit = function(positionalParams, namedParams, atTime)
            return self:powerDeficit("pain", positionalParams, namedParams, atTime)
        end
        self.rageDeficit = function(positionalParams, namedParams, atTime)
            return self:powerDeficit("rage", positionalParams, namedParams, atTime)
        end
        self.runicPowerDeficit = function(positionalParams, namedParams, atTime)
            return self:powerDeficit("runicpower", positionalParams, namedParams, atTime)
        end
        self.soulShardsDeficit = function(positionalParams, namedParams, atTime)
            return self:powerDeficit("soulshards", positionalParams, namedParams, atTime)
        end
        self.manaPercent = function(positionalParams, namedParams, atTime)
            return self:powerPercent("mana", positionalParams, namedParams, atTime)
        end
        self.maxAlternatePower = function(positionalParams, namedParams, atTime)
            return self:maxPower("alternate", positionalParams, namedParams, atTime)
        end
        self.maxChi = function(positionalParams, namedParams, atTime)
            return self:maxPower("chi", positionalParams, namedParams, atTime)
        end
        self.maxComboPoints = function(positionalParams, namedParams, atTime)
            return self:maxPower("combopoints", positionalParams, namedParams, atTime)
        end
        self.maxEnergy = function(positionalParams, namedParams, atTime)
            return self:maxPower("energy", positionalParams, namedParams, atTime)
        end
        self.maxFocus = function(positionalParams, namedParams, atTime)
            return self:maxPower("focus", positionalParams, namedParams, atTime)
        end
        self.maxFury = function(positionalParams, namedParams, atTime)
            return self:maxPower("fury", positionalParams, namedParams, atTime)
        end
        self.maxHolyPower = function(positionalParams, namedParams, atTime)
            return self:maxPower("holypower", positionalParams, namedParams, atTime)
        end
        self.maxMana = function(positionalParams, namedParams, atTime)
            return self:maxPower("mana", positionalParams, namedParams, atTime)
        end
        self.maxPain = function(positionalParams, namedParams, atTime)
            return self:maxPower("pain", positionalParams, namedParams, atTime)
        end
        self.maxRage = function(positionalParams, namedParams, atTime)
            return self:maxPower("rage", positionalParams, namedParams, atTime)
        end
        self.maxRunicPower = function(positionalParams, namedParams, atTime)
            return self:maxPower("runicpower", positionalParams, namedParams, atTime)
        end
        self.maxSoulShards = function(positionalParams, namedParams, atTime)
            return self:maxPower("soulshards", positionalParams, namedParams, atTime)
        end
        self.maxArcaneCharges = function(positionalParams, namedParams, atTime)
            return self:maxPower("arcanecharges", positionalParams, namedParams, atTime)
        end
        self.energyCost = function(positionalParams, namedParams, atTime)
            return self:powerCost("energy", positionalParams, namedParams, atTime)
        end
        self.focusCost = function(positionalParams, namedParams, atTime)
            return self:powerCost("focus", positionalParams, namedParams, atTime)
        end
        self.manaCost = function(positionalParams, namedParams, atTime)
            return self:powerCost("mana", positionalParams, namedParams, atTime)
        end
        self.rageCost = function(positionalParams, namedParams, atTime)
            return self:powerCost("rage", positionalParams, namedParams, atTime)
        end
        self.runicPowerCost = function(positionalParams, namedParams, atTime)
            return self:powerCost("runicpower", positionalParams, namedParams, atTime)
        end
        self.astralPowerCost = function(positionalParams, namedParams, atTime)
            return self:powerCost("lunarpower", positionalParams, namedParams, atTime)
        end
        self.mainPowerCost = function(positionalParams, namedParams, atTime)
            return self:powerCost(self.powers.current.powerType, positionalParams, namedParams, atTime)
        end
        self.present = function(positionalParams, namedParams, atTime)
            local target = self:parseCondition(positionalParams, namedParams)
            local boolean = UnitExists(target) and  not UnitIsDead(target)
            return returnBoolean(boolean)
        end
        self.previousGCDSpell = function(positionalParams, namedParams, atTime)
            local spell = positionalParams[1]
            local spellId = self.spellBook:getKnownSpellId(spell)
            local count = namedParams.count
            local boolean
            if count and count > 1 then
                boolean = spellId == self.future.next.lastGCDSpellIds[#self.future.next.lastGCDSpellIds - count + 2]
            else
                boolean = spellId == self.future.next.lastGCDSpellId
            end
            return returnBoolean(boolean)
        end
        self.previousOffGCDSpell = function(positionalParams, namedParams, atTime)
            local spell = positionalParams[1]
            local spellId = self.spellBook:getKnownSpellId(spell)
            local boolean = spellId == self.future.next.lastOffGCDSpellcast.spellId
            return returnBoolean(boolean)
        end
        self.previousSpell = function(positionalParams, namedParams, atTime)
            local spell = positionalParams[1]
            local spellId = self.spellBook:getKnownSpellId(spell)
            local boolean = spellId == self.future.next.lastGCDSpellId
            return returnBoolean(boolean)
        end
        self.relativeLevel = function(positionalParams, namedParams, atTime)
            local target = self:parseCondition(positionalParams, namedParams)
            local value, level
            if target == "player" then
                level = self.paperDoll.level
            else
                level = UnitLevel(target)
            end
            if level < 0 then
                value = 3
            else
                value = level - self.paperDoll.level
            end
            return returnConstant(value)
        end
        self.refreshable = function(positionalParams, namedParams, atTime)
            local auraId = positionalParams[1]
            local target, filter, mine = self:parseCondition(positionalParams, namedParams)
            local aura = self.auras:getAura(target, auraId, atTime, filter, mine)
            if aura then
                local baseDuration = self.auras:getBaseDuration(auraId, nil, atTime)
                if baseDuration == INFINITY then
                    baseDuration = aura.ending - aura.start
                end
                local extensionDuration = 0.3 * baseDuration
                return aura.ending - extensionDuration, INFINITY
            end
            return 0, INFINITY
        end
        self.remainingCastTime = function(positionalParams, namedParams, atTime)
            local target = self:parseCondition(positionalParams, namedParams)
            local _, _, _, startTime, endTime = UnitCastingInfo(target)
            if startTime and endTime then
                startTime = startTime / 1000
                endTime = endTime / 1000
                return returnValueBetween(startTime, endTime, 0, endTime, -1)
            end
            return 
        end
        self.rune = function(positionalParams, namedParams, atTime)
            local count, startCooldown, endCooldown = self.runes:runeCount(atTime)
            if startCooldown < INFINITY then
                local rate = 1 / (endCooldown - startCooldown)
                return returnValueBetween(startCooldown, INFINITY, count, startCooldown, rate)
            end
            return returnConstant(count)
        end
        self.runeDeficit = function(positionalParams, namedParams, atTime)
            local count, startCooldown, endCooldown = self.runes:runeDeficit(atTime)
            if startCooldown < INFINITY then
                local rate = -1 / (endCooldown - startCooldown)
                return returnValueBetween(startCooldown, INFINITY, count, startCooldown, rate)
            end
            return returnConstant(count)
        end
        self.runeCount = function(positionalParams, namedParams, atTime)
            local count, startCooldown, endCooldown = self.runes:runeCount(atTime)
            if startCooldown < INFINITY then
                return returnValueBetween(startCooldown, endCooldown, count, startCooldown, 0)
            end
            return returnConstant(count)
        end
        self.timeToRunes = function(positionalParams, namedParams, atTime)
            local runes = positionalParams[1]
            local seconds = self.runes:getRunesCooldown(atTime, runes)
            if seconds < 0 then
                seconds = 0
            end
            return returnValue(seconds, atTime, -1)
        end
        self.agility = function(positionalParams, namedParams, atTime)
            return self:snapshot("agility", 0, positionalParams, namedParams, atTime)
        end
        self.attackPower = function(positionalParams, namedParams, atTime)
            return self:snapshot("attackPower", 0, positionalParams, namedParams, atTime)
        end
        self.critRating = function(positionalParams, namedParams, atTime)
            return self:snapshot("critRating", 0, positionalParams, namedParams, atTime)
        end
        self.hasteRating = function(positionalParams, namedParams, atTime)
            return self:snapshot("hasteRating", 0, positionalParams, namedParams, atTime)
        end
        self.intellect = function(positionalParams, namedParams, atTime)
            return self:snapshot("intellect", 0, positionalParams, namedParams, atTime)
        end
        self.masteryEffect = function(positionalParams, namedParams, atTime)
            return self:snapshot("masteryEffect", 0, positionalParams, namedParams, atTime)
        end
        self.masteryRating = function(positionalParams, namedParams, atTime)
            return self:snapshot("masteryRating", 0, positionalParams, namedParams, atTime)
        end
        self.meleeCritChance = function(positionalParams, namedParams, atTime)
            return self:snapshotCritChance("meleeCrit", 0, positionalParams, namedParams, atTime)
        end
        self.meleeAttackSpeedPercent = function(positionalParams, namedParams, atTime)
            return self:snapshot("meleeAttackSpeedPercent", 0, positionalParams, namedParams, atTime)
        end
        self.rangedCritChance = function(positionalParams, namedParams, atTime)
            return self:snapshotCritChance("rangedCrit", 0, positionalParams, namedParams, atTime)
        end
        self.spellCritChance = function(positionalParams, namedParams, atTime)
            return self:snapshotCritChance("spellCrit", 0, positionalParams, namedParams, atTime)
        end
        self.spellCastSpeedPercent = function(positionalParams, namedParams, atTime)
            return self:snapshot("spellCastSpeedPercent", 0, positionalParams, namedParams, atTime)
        end
        self.spellpower = function(positionalParams, namedParams, atTime)
            return self:snapshot("spellPower", 0, positionalParams, namedParams, atTime)
        end
        self.stamina = function(positionalParams, namedParams, atTime)
            return self:snapshot("stamina", 0, positionalParams, namedParams, atTime)
        end
        self.strength = function(positionalParams, namedParams, atTime)
            return self:snapshot("strength", 0, positionalParams, namedParams, atTime)
        end
        self.versatility = function(positionalParams, namedParams, atTime)
            return self:snapshot("versatility", 0, positionalParams, namedParams, atTime)
        end
        self.versatilityRating = function(positionalParams, namedParams, atTime)
            return self:snapshot("versatilityRating", 0, positionalParams, namedParams, atTime)
        end
        self.speed = function(positionalParams, namedParams, atTime)
            local target = self:parseCondition(positionalParams, namedParams)
            local value = (GetUnitSpeed(target) * 100) / 7
            return returnConstant(value)
        end
        self.spellChargeCooldown = function(positionalParams, namedParams, atTime)
            local spellId = positionalParams[1]
            local charges, maxCharges, start, duration = self.cooldown:getSpellCharges(spellId, atTime)
            if charges and charges < maxCharges then
                local ending = start + duration
                return returnValueBetween(start, ending, duration, start, -1)
            end
            return returnConstant(0)
        end
        self.spellCharges = function(positionalParams, namedParams, atTime)
            local spellId = positionalParams[1]
            local charges, maxCharges, start, duration = self.cooldown:getSpellCharges(spellId, atTime)
            if namedParams.count == 0 and charges < maxCharges then
                return returnValueBetween(atTime, INFINITY, charges + 1, start + duration, 1 / duration)
            end
            return returnConstant(charges)
        end
        self.spellFullRecharge = function(positionalParams, namedParams, atTime)
            local spellId = positionalParams[1]
            local charges, maxCharges, start, chargeDuration = self.cooldown:getSpellCharges(spellId, atTime)
            if charges and charges < maxCharges then
                local duration = (maxCharges - charges) * chargeDuration
                local ending = start + duration
                return returnValueBetween(start, ending, duration, start, -1)
            end
            return returnConstant(0)
        end
        self.spellCooldown = function(positionalParams, namedParams, atTime)
            local usable = namedParams.usable == 1
            local target = self:parseCondition(positionalParams, namedParams, "target")
            local targetGuid = self.guids:getUnitGUID(target)
            if  not targetGuid then
                return 
            end
            local earliest = INFINITY
            for _, spellId in ipairs(positionalParams) do
                local id = self.data:resolveSpell(spellId, atTime, targetGuid)
                if id then
                    if  not usable or self.spells:isUsableSpell(id, atTime, targetGuid) then
                        local start, duration = self.cooldown:getSpellCooldown(id, atTime)
                        local t = 0
                        if start > 0 and duration > 0 then
                            t = start + duration
                        end
                        if earliest > t then
                            earliest = t
                        end
                    end
                end
            end
            if earliest == INFINITY then
                return returnConstant(0)
            elseif earliest > 0 then
                return returnValue(0, earliest, -1)
            end
            return returnConstant(0)
        end
        self.spellCooldownDuration = function(positionalParams, namedParams, atTime)
            local spellId = positionalParams[1]
            local target = self:parseCondition(positionalParams, namedParams, "target")
            local duration = self.cooldown:getSpellCooldownDuration(spellId, atTime, target)
            return returnConstant(duration)
        end
        self.spellRechargeDuration = function(positionalParams, namedParams, atTime)
            local spellId = positionalParams[1]
            local target = self:parseCondition(positionalParams, namedParams, "target")
            local cd = self.cooldown:getCD(spellId, atTime)
            local duration = cd.chargeDuration or self.cooldown:getSpellCooldownDuration(spellId, atTime, target)
            return returnConstant(duration)
        end
        self.spellData = function(positionalParams, namedParams, atTime)
            local spellId, key = positionalParams[1], positionalParams[2]
            local si = self.data.spellInfo[spellId]
            if si then
                local value = si[key]
                if value then
                    return returnConstant(value)
                end
            end
            return 
        end
        self.spellInfoProperty = function(positionalParams, namedParams, atTime)
            local spellId, key = positionalParams[1], positionalParams[2]
            local value = self.data:getSpellInfoProperty(spellId, atTime, key, nil)
            if value then
                return returnConstant(value)
            end
            return 
        end
        self.spellCount = function(positionalParams, namedParams, atTime)
            local spellId = positionalParams[1]
            local spellCount = self.spells:getSpellCount(spellId)
            return returnConstant(spellCount)
        end
        self.spellKnown = function(positionalParams, namedParams, atTime)
            local spellId = positionalParams[1]
            local boolean = self.spellBook:isKnownSpell(spellId)
            return returnBoolean(boolean)
        end
        self.spellMaxCharges = function(positionalParams, namedParams, atTime)
            local spellId = positionalParams[1]
            local _, maxCharges, _ = self.cooldown:getSpellCharges(spellId, atTime)
            if  not maxCharges then
                return 
            end
            maxCharges = maxCharges or 1
            return returnConstant(maxCharges)
        end
        self.spellUsable = function(positionalParams, namedParams, atTime)
            local spellId = positionalParams[1]
            local target = self:parseCondition(positionalParams, namedParams, "target")
            local targetGuid = self.guids:getUnitGUID(target)
            if  not targetGuid then
                return 
            end
            local isUsable, noMana = self.spells:isUsableSpell(spellId, atTime, targetGuid)
            local boolean = isUsable or noMana
            return returnBoolean(boolean)
        end
        self.stealthed = function(positionalParams, namedParams, atTime)
            local boolean = self.auras:getAura("player", "stealthed_buff", atTime, "HELPFUL") ~= nil or IsStealthed()
            return returnBoolean(boolean)
        end
        self.lastSwing = function(positionalParams, namedParams, atTime)
            local start = 0
            oneTimeMessage("Warning: 'LastSwing()' is not implemented.")
            return returnValueBetween(start, INFINITY, 0, start, 1)
        end
        self.nextSwing = function(positionalParams, namedParams, atTime)
            local ending = 0
            oneTimeMessage("Warning: 'NextSwing()' is not implemented.")
            return returnValueBetween(0, ending, 0, ending, -1)
        end
        self.talent = function(positionalParams, namedParams, atTime)
            local talentId = positionalParams[1]
            local boolean = self.spellBook:getTalentPoints(talentId) > 0
            return returnBoolean(boolean)
        end
        self.talentPoints = function(positionalParams, namedParams, atTime)
            local talent = positionalParams[1]
            local value = self.spellBook:getTalentPoints(talent)
            return returnConstant(value)
        end
        self.targetIsPlayer = function(positionalParams, namedParams, atTime)
            local target = self:parseCondition(positionalParams, namedParams)
            local boolean = UnitIsUnit("player", target .. "target")
            return returnBoolean(boolean)
        end
        self.threat = function(positionalParams, namedParams, atTime)
            local target = self:parseCondition(positionalParams, namedParams, "target")
            local _, _, value = UnitDetailedThreatSituation("player", target)
            return returnConstant(value)
        end
        self.tickTime = function(positionalParams, namedParams, atTime)
            local auraId = positionalParams[1]
            local target, filter, mine = self:parseCondition(positionalParams, namedParams)
            local aura = self.auras:getAura(target, auraId, atTime, filter, mine)
            local tickTime
            if aura and self.auras:isActiveAura(aura, atTime) then
                tickTime = aura.tick
            else
                tickTime = self.auras:getTickLength(auraId, atTime)
            end
            if tickTime and tickTime > 0 then
                return returnConstant(tickTime)
            end
            return returnConstant(INFINITY)
        end
        self.currentTickTime = function(positionalParams, namedParams, atTime)
            local auraId = positionalParams[1]
            local target, filter, mine = self:parseCondition(positionalParams, namedParams)
            local aura = self.auras:getAura(target, auraId, atTime, filter, mine)
            local tickTime
            if aura and self.auras:isActiveAura(aura, atTime) then
                tickTime = aura.tick or 0
            else
                tickTime = 0
            end
            return returnConstant(tickTime)
        end
        self.ticksRemaining = function(positionalParams, namedParams, atTime)
            local auraId = positionalParams[1]
            local target, filter, mine = self:parseCondition(positionalParams, namedParams)
            local aura = self.auras:getAura(target, auraId, atTime, filter, mine)
            if aura then
                local tick = aura.tick
                if tick and tick > 0 then
                    return returnValueBetween(aura.gain, INFINITY, 1, aura.ending, -1 / tick)
                end
            end
            return returnConstant(0)
        end
        self.tickTimeRemaining = function(positionalParams, namedParams, atTime)
            local auraId = positionalParams[1]
            local target, filter, mine = self:parseCondition(positionalParams, namedParams)
            local aura = self.auras:getAura(target, auraId, atTime, filter, mine)
            if aura and self.auras:isActiveAura(aura, atTime) then
                local lastTickTime = aura.lastTickTime or aura.start
                local tick = aura.tick or self.auras:getTickLength(auraId, atTime)
                local remainingTime = tick - (atTime - lastTickTime)
                if remainingTime and remainingTime > 0 then
                    return returnValueBetween(aura.gain, INFINITY, tick, lastTickTime, -1)
                end
            end
            return returnConstant(0)
        end
        self.timeSincePreviousSpell = function(positionalParams, namedParams, atTime)
            local spell = positionalParams[1]
            local spellId = self.spellBook:getKnownSpellId(spell)
            if  not spellId then
                return 
            end
            local t = self.future:getTimeOfLastCast(spellId, atTime)
            return returnValue(0, t, 1)
        end
        self.timeToBloodlust = function(positionalParams, namedParams, atTime)
            local value = 3600
            return returnConstant(value)
        end
        self.timeToEclipse = function(positionalParams, namedParams, atTime)
            local value = 3600 * 24 * 7
            oneTimeMessage("Warning: 'TimeToEclipse()' is not implemented.")
            return returnValue(value, atTime, -1)
        end
        self.timeToEnergy = function(positionalParams, namedParams, atTime)
            local level = positionalParams[1]
            return self:timeToPower("energy", level, atTime)
        end
        self.timeToMaxEnergy = function(positionalParams, namedParams, atTime)
            local powerType = "energy"
            local level = self.powers.current.maxPower[powerType] or 0
            return self:timeToPower(powerType, level, atTime)
        end
        self.timeToFocus = function(positionalParams, namedParams, atTime)
            local level = positionalParams[1]
            return self:timeToPower("focus", level, atTime)
        end
        self.timeToMaxFocus = function(positionalParams, namedParams, atTime)
            local powerType = "focus"
            local level = self.powers.current.maxPower[powerType] or 0
            return self:timeToPower(powerType, level, atTime)
        end
        self.timeToMaxMana = function(positionalParams, namedParams, atTime)
            local powerType = "mana"
            local level = self.powers.current.maxPower[powerType] or 0
            return self:timeToPower(powerType, level, atTime)
        end
        self.timeToEnergyFor = function(positionalParams, namedParams, atTime)
            return self:timeToPowerFor("energy", positionalParams, namedParams, atTime)
        end
        self.timeToFocusFor = function(positionalParams, namedParams, atTime)
            return self:timeToPowerFor("focus", positionalParams, namedParams, atTime)
        end
        self.timeToSpell = function(positionalParams, namedParams, atTime)
            oneTimeMessage("Warning: 'TimeToSpell()' is not implemented.")
            return returnValue(0, atTime, -1)
        end
        self.timeWithHaste = function(positionalParams, namedParams, atTime)
            local seconds = positionalParams[1]
            local haste = (namedParams.haste) or "spell"
            local value = self:getHastedTime(seconds, haste, atTime)
            return returnConstant(value)
        end
        self.totemExpires = function(positionalParams, namedParams, atTime)
            local id = positionalParams[1]
            local seconds = positionalParams[2]
            seconds = seconds or 0
            local count, _, ending = self.totem:getTotemInfo(id, atTime)
            if count ~= nil and ending ~= nil and count > 0 then
                return ending - seconds, INFINITY
            end
            return 0, INFINITY
        end
        self.totemPresent = function(positionalParams, namedParams, atTime)
            local id = positionalParams[1]
            local count, start, ending = self.totem:getTotemInfo(id, atTime)
            if count ~= nil and ending ~= nil and start ~= nil and count > 0 then
                return start, ending
            end
            return 
        end
        self.totemRemaining = function(positionalParams, namedParams, atTime)
            local id = positionalParams[1]
            local count, start, ending = self.totem:getTotemInfo(id, atTime)
            if count ~= nil and start ~= nil and ending ~= nil and count > 0 then
                return returnValueBetween(start, ending, 0, ending, -1)
            end
            return returnConstant(0)
        end
        self.tracking = function(positionalParams, namedParams, atTime)
            local spellId = positionalParams[1]
            local spellName = self.spellBook:getSpellName(spellId)
            local numTrackingTypes = GetNumTrackingTypes()
            local boolean = false
            for i = 1, numTrackingTypes, 1 do
                local name, _, active = GetTrackingInfo(i)
                if name and name == spellName then
                    boolean = active == 1
                    break
                end
            end
            return returnBoolean(boolean)
        end
        self.travelTime = function(positionalParams, namedParams, atTime)
            local spellId = positionalParams[1]
            local si = spellId and self.data.spellInfo[spellId]
            local travelTime = 0
            if si then
                travelTime = si.travel_time or si.max_travel_time or 0
            end
            if travelTime > 0 then
                local estimatedTravelTime = 1
                if travelTime < estimatedTravelTime then
                    travelTime = estimatedTravelTime
                end
            end
            return returnConstant(travelTime)
        end
        self.getTrue = function(positionalParams, namedParams, atTime)
            return 0, INFINITY
        end
        self.weaponDPS = function(positionalParams, namedParams, atTime)
            local hand = positionalParams[1]
            local value = 0
            if hand == "offhand" or hand == "off" then
                value = self.paperDoll.current.offHandWeaponDPS or 0
            elseif hand == "mainhand" or hand == "main" then
                value = self.paperDoll.current.mainHandWeaponDPS or 0
            else
                value = self.paperDoll.current.mainHandWeaponDPS or 0
            end
            return returnConstant(value)
        end
        self.sigilCharging = function(positionalParams, namedParams, atTime)
            local charging = false
            for _, v in ipairs(positionalParams) do
                charging = charging or self.sigil:isSigilCharging(v, atTime)
            end
            return returnBoolean(charging)
        end
        self.isBossFight = function(positionalParams, namedParams, atTime)
            local bossEngaged = self.bossMod:isBossEngaged(atTime)
            return returnBoolean(bossEngaged)
        end
        self.race = function(positionalParams, namedParams, atTime)
            local isRace = false
            local target = (namedParams.target) or "player"
            local _, targetRaceId = UnitRace(target)
            for _, v in ipairs(positionalParams) do
                isRace = isRace or v == targetRaceId
            end
            return returnBoolean(isRace)
        end
        self.unitInPartyCond = function(positionalParams, namedParams, atTime)
            local target = (namedParams.target) or "player"
            local boolean = UnitInParty(target)
            return returnBoolean(boolean)
        end
        self.unitInRaidCond = function(positionalParams, namedParams, atTime)
            local target = (namedParams.target) or "player"
            local raidIndex = UnitInRaid(target)
            return returnBoolean(raidIndex ~= nil)
        end
        self.soulFragments = function(positionalParams, namedParams, atTime)
            local value = self.demonHunterSoulFragments:soulFragments(atTime)
            return returnConstant(value)
        end
        self.hasDebuffType = function(positionalParams, namedParams, atTime)
            local target = self:parseCondition(positionalParams, namedParams)
            for _, debuffType in ipairs(positionalParams) do
                local aura = self.auras:getAura(target, lower(debuffType), atTime, (target == "player" and "HARMFUL") or "HELPFUL", false)
                if aura then
                    local gain, _, ending = aura.gain, aura.start, aura.ending
                    return gain, ending
                end
            end
            return 
        end
        self.stackTimeTo = function(positionalParams, namedParams, atTime)
            local spellId = positionalParams[1]
            local stacks = positionalParams[2]
            local direction = positionalParams[3]
            local incantersFlowBuff = self.data:getSpellOrListInfo(spellId)
            local tickCycle = (incantersFlowBuff and (incantersFlowBuff.max_stacks or 5) * 2) or 0
            local posLo
            local posHi
            if direction == "up" then
                posLo = stacks
                posHi = stacks
            elseif direction == "down" then
                posLo = tickCycle - stacks + 1
                posHi = posLo
            else
                posLo = stacks
                posHi = tickCycle - stacks + 1
            end
            local aura = self.auras:getAura("player", spellId, atTime, "HELPFUL")
            if  not aura or aura.tick == nil or aura.lastTickTime == nil then
                return 
            end
            local buffPos
            local buffStacks = aura.stacks
            if aura.direction < 0 then
                buffPos = tickCycle - buffStacks + 1
            else
                buffPos = buffStacks
            end
            if posLo == buffPos or posHi == buffPos then
                return returnValue(0, 0, 0)
            end
            local ticksLo = (tickCycle + posLo - buffPos) % tickCycle
            local ticksHi = (tickCycle + posHi - buffPos) % tickCycle
            local tickTime = aura.tick
            local tickRem = tickTime - (atTime - aura.lastTickTime)
            local value = tickRem + tickTime * (min(ticksLo, ticksHi) - 1)
            return returnValue(value, atTime, -1)
        end
        self.message = function(positionalParameters)
            oneTimeMessage(positionalParameters[1])
            return returnConstant(0)
        end
        ovaleCondition:registerCondition("message", false, self.message)
        ovaleCondition:registerCondition("present", false, self.present)
        ovaleCondition:registerCondition("stacktimeto", false, self.stackTimeTo)
        ovaleCondition:registerCondition("armorsetbonus", false, self.getArmorSetBonus)
        ovaleCondition:registerCondition("armorsetparts", false, self.getArmorSetParts)
        ovaleCondition:registerCondition("azeriteessenceismajor", false, self.azeriteEssenceIsMajor)
        ovaleCondition:registerCondition("azeriteessenceisminor", false, self.azeriteEssenceIsMinor)
        ovaleCondition:registerCondition("azeriteessenceisenabled", false, self.azeriteEssenceIsEnabled)
        ovaleCondition:registerCondition("azeriteessencerank", false, self.azeriteEssenceRank)
        ovaleCondition:registerCondition("baseduration", false, self.baseDuration)
        ovaleCondition:registerCondition("buffdurationifapplied", false, self.baseDuration)
        ovaleCondition:registerCondition("debuffdurationifapplied", false, self.baseDuration)
        ovaleCondition:register("bloodtalonstriggercount", self.bloodtalonsTriggerCount, {
            type = "number"
        })
        ovaleCondition:register("bloodtalonsbrutalslashpresent", self.bloodtalonsBrutalSlashPresent, {
            type = "none"
        })
        ovaleCondition:register("bloodtalonsmoonfirepresent", self.bloodtalonsMoonfirePresent, {
            type = "none"
        })
        ovaleCondition:register("bloodtalonsrakepresent", self.bloodtalonsRakePresent, {
            type = "none"
        })
        ovaleCondition:register("bloodtalonsshredpresent", self.bloodtalonsShredPresent, {
            type = "none"
        })
        ovaleCondition:register("bloodtalonsswipepresent", self.bloodtalonsSwipePresent, {
            type = "none"
        })
        ovaleCondition:register("bloodtalonsthrashpresent", self.bloodtalonsThrashPresent, {
            type = "none"
        })
        ovaleCondition:registerCondition("buffamount", false, self.buffAmount)
        ovaleCondition:registerCondition("debuffamount", false, self.buffAmount)
        ovaleCondition:registerCondition("tickvalue", false, self.buffAmount)
        ovaleCondition:registerCondition("buffcombopoints", false, self.buffComboPoints)
        ovaleCondition:registerCondition("debuffcombopoints", false, self.buffComboPoints)
        ovaleCondition:registerCondition("buffcooldown", false, self.buffCooldown)
        ovaleCondition:registerCondition("debuffcooldown", false, self.buffCooldown)
        ovaleCondition:registerCondition("buffcount", false, self.buffCount)
        ovaleCondition:registerCondition("buffcooldownduration", false, self.buffCooldownDuration)
        ovaleCondition:registerCondition("debuffcooldownduration", false, self.buffCooldownDuration)
        ovaleCondition:registerCondition("buffcountonany", false, self.buffCountOnAny)
        ovaleCondition:registerCondition("debuffcountonany", false, self.buffCountOnAny)
        ovaleCondition:registerCondition("buffdirection", false, self.buffDirection)
        ovaleCondition:registerCondition("debuffdirection", false, self.buffDirection)
        ovaleCondition:registerCondition("buffduration", false, self.buffDuration)
        ovaleCondition:registerCondition("debuffduration", false, self.buffDuration)
        ovaleCondition:registerCondition("buffexpires", false, self.buffExpires)
        ovaleCondition:registerCondition("debuffexpires", false, self.buffExpires)
        local targetParameter = {
            name = "target",
            optional = true,
            defaultValue = "player",
            type = "string"
        }
        local filterParameter = {
            name = "filter",
            optional = true,
            defaultValue = "buff",
            type = "string",
            mapValues = mapFilter
        }
        local mineParameter = {
            name = "mine",
            type = "boolean",
            defaultValue = true,
            optional = true
        }
        ovaleCondition:register("buffpresent", self.buffPresent, {
            type = "number"
        }, {
            name = "aura",
            type = "number",
            optional = false
        }, targetParameter, filterParameter, mineParameter, {
            name = "seconds",
            type = "number",
            defaultValue = 0,
            optional = true
        }, {
            name = "haste",
            type = "string",
            checkTokens = checkHaste,
            defaultValue = "none",
            optional = true
        })
        ovaleCondition:registerAlias("buffpresent", "debuffpresent")
        ovaleCondition:registerCondition("buffgain", false, self.buffGain)
        ovaleCondition:registerCondition("debuffgain", false, self.buffGain)
        ovaleCondition:registerCondition("buffimproved", false, self.buffImproved)
        ovaleCondition:registerCondition("debuffimproved", false, self.buffImproved)
        ovaleCondition:registerCondition("buffpersistentmultiplier", false, self.buffPersistentMultiplier)
        ovaleCondition:registerCondition("debuffpersistentmultiplier", false, self.buffPersistentMultiplier)
        ovaleCondition:registerCondition("buffremaining", false, self.buffRemaining)
        ovaleCondition:registerCondition("debuffremaining", false, self.buffRemaining)
        ovaleCondition:registerCondition("buffremains", false, self.buffRemaining)
        ovaleCondition:registerCondition("debuffremains", false, self.buffRemaining)
        ovaleCondition:registerCondition("buffremainingonany", false, self.buffRemainingOnAny)
        ovaleCondition:registerCondition("debuffremainingonany", false, self.buffRemainingOnAny)
        ovaleCondition:registerCondition("buffremainsonany", false, self.buffRemainingOnAny)
        ovaleCondition:registerCondition("debuffremainsonany", false, self.buffRemainingOnAny)
        ovaleCondition:registerCondition("buffstacks", false, self.buffStacks)
        ovaleCondition:registerCondition("debuffstacks", false, self.buffStacks)
        ovaleCondition:registerCondition("maxstacks", true, self.maxStacks)
        ovaleCondition:registerCondition("buffstacksonany", false, self.buffStacksOnAny)
        ovaleCondition:registerCondition("debuffstacksonany", false, self.buffStacksOnAny)
        ovaleCondition:registerCondition("buffstealable", false, self.buffStealable)
        ovaleCondition:registerCondition("cancast", true, self.canCast)
        ovaleCondition:registerCondition("casttime", true, self.castTime)
        ovaleCondition:registerCondition("executetime", true, self.executeTime)
        ovaleCondition:registerCondition("casting", false, self.casting)
        ovaleCondition:registerCondition("checkboxoff", false, self.checkBoxOff)
        ovaleCondition:registerCondition("checkboxon", false, self.checkBoxOn)
        ovaleCondition:registerCondition("class", false, self.getClass)
        ovaleCondition:registerCondition("classification", false, self.classification)
        ovaleCondition:registerCondition("counter", false, self.counter)
        ovaleCondition:register("creaturefamily", self.creatureFamily, {
            type = "none"
        }, {
            name = "name",
            type = "string",
            optional = false
        }, targetParameter)
        ovaleCondition:registerCondition("creaturetype", false, self.creatureType)
        ovaleCondition:registerCondition("critdamage", false, self.critDamage)
        ovaleCondition:registerCondition("damage", false, self.damage)
        ovaleCondition:registerCondition("damagetaken", false, self.getDamageTaken)
        ovaleCondition:registerCondition("incomingdamage", false, self.getDamageTaken)
        ovaleCondition:registerCondition("magicdamagetaken", false, self.magicDamageTaken)
        ovaleCondition:registerCondition("incomingmagicdamage", false, self.magicDamageTaken)
        ovaleCondition:registerCondition("physicaldamagetaken", false, self.physicalDamageTaken)
        ovaleCondition:registerCondition("incomingphysicaldamage", false, self.physicalDamageTaken)
        ovaleCondition:registerCondition("diseasesremaining", false, self.diseasesRemaining)
        ovaleCondition:registerCondition("diseasesticking", false, self.diseasesTicking)
        ovaleCondition:registerCondition("diseasesanyticking", false, self.diseasesAnyTicking)
        ovaleCondition:registerCondition("distance", false, self.distance)
        ovaleCondition:registerCondition("enemies", false, self.getEnemies)
        ovaleCondition:registerCondition("energyregen", false, self.energyRegenRate)
        ovaleCondition:registerCondition("energyregenrate", false, self.energyRegenRate)
        ovaleCondition:registerCondition("enrageremaining", false, self.enrageRemaining)
        ovaleCondition:registerCondition("exists", false, self.exists)
        ovaleCondition:registerCondition("never", false, self.getFalse)
        ovaleCondition:registerCondition("focusregen", false, self.focusRegenRate)
        ovaleCondition:registerCondition("focusregenrate", false, self.focusRegenRate)
        ovaleCondition:registerCondition("focuscastingregen", false, self.focusCastingRegen)
        ovaleCondition:registerCondition("gcd", false, self.getGCD)
        ovaleCondition:registerCondition("gcdremaining", false, self.getGCDRemaining)
        ovaleCondition:registerCondition("glyph", false, self.glyph)
        ovaleCondition:registerCondition("guid", false, self.getGuid)
        ovaleCondition:registerCondition("targetguid", false, self.getTargetGuid)
        ovaleCondition:registerCondition("hasfullcontrol", false, self.hasFullControlCondition)
        ovaleCondition:registerCondition("health", false, self.getHealth)
        ovaleCondition:registerCondition("life", false, self.getHealth)
        ovaleCondition:registerCondition("effectivehealth", false, self.effectiveHealth)
        ovaleCondition:registerCondition("healthmissing", false, self.healthMissing)
        ovaleCondition:registerCondition("lifemissing", false, self.healthMissing)
        ovaleCondition:registerCondition("healthpercent", false, self.healthPercent)
        ovaleCondition:registerCondition("lifepercent", false, self.healthPercent)
        ovaleCondition:registerCondition("effectivehealthpercent", false, self.effectiveHealthPercent)
        ovaleCondition:registerCondition("maxhealth", false, self.maxHealth)
        ovaleCondition:registerCondition("deadin", false, self.timeToDie)
        ovaleCondition:registerCondition("timetodie", false, self.timeToDie)
        ovaleCondition:registerCondition("timetohealthpercent", false, self.timeToHealthPercent)
        ovaleCondition:registerCondition("timetolifepercent", false, self.timeToHealthPercent)
        ovaleCondition:registerCondition("inflighttotarget", false, self.inFlightToTarget)
        ovaleCondition:registerCondition("inrange", false, self.inRange)
        ovaleCondition:registerCondition("isaggroed", false, self.isAggroed)
        ovaleCondition:registerCondition("isdead", false, self.isDead)
        ovaleCondition:registerCondition("isenraged", false, self.isEnraged)
        ovaleCondition:registerCondition("isfeared", false, self.isFeared)
        ovaleCondition:registerCondition("isfriend", false, self.isFriend)
        ovaleCondition:registerCondition("isincapacitated", false, self.isIncapacitated)
        ovaleCondition:registerCondition("isinterruptible", false, self.isInterruptible)
        ovaleCondition:registerCondition("ispvp", false, self.isPVP)
        ovaleCondition:registerCondition("isrooted", false, self.isRooted)
        ovaleCondition:registerCondition("isstunned", false, self.isStunned)
        ovaleCondition:registerCondition("itemcharges", false, self.itemCharges)
        ovaleCondition:registerCondition("itemcount", false, self.itemCount)
        ovaleCondition:registerCondition("lastdamage", false, self.lastDamage)
        ovaleCondition:registerCondition("lastspelldamage", false, self.lastDamage)
        ovaleCondition:registerCondition("level", false, self.level)
        ovaleCondition:registerCondition("list", false, self.list)
        ovaleCondition:register("name", self.name, {
            type = "string"
        }, targetParameter)
        ovaleCondition:registerCondition("ptr", false, self.isPtr)
        ovaleCondition:registerCondition("persistentmultiplier", false, self.persistentMultiplier)
        ovaleCondition:registerCondition("petpresent", false, self.petPresent)
        ovaleCondition:registerCondition("alternatepower", false, self.alternatePower)
        ovaleCondition:registerCondition("arcanecharges", false, self.arcaneCharges)
        ovaleCondition:registerCondition("astralpower", false, self.astralPower)
        ovaleCondition:registerCondition("chi", false, self.chi)
        ovaleCondition:registerCondition("combopoints", false, self.comboPoints)
        ovaleCondition:registerCondition("energy", false, self.energy)
        ovaleCondition:registerCondition("focus", false, self.focus)
        ovaleCondition:registerCondition("fury", false, self.fury)
        ovaleCondition:registerCondition("holypower", false, self.holyPower)
        ovaleCondition:registerCondition("insanity", false, self.insanity)
        ovaleCondition:registerCondition("maelstrom", false, self.maelstrom)
        ovaleCondition:registerCondition("mana", false, self.mana)
        ovaleCondition:registerCondition("pain", false, self.pain)
        ovaleCondition:registerCondition("rage", false, self.rage)
        ovaleCondition:registerCondition("runicpower", false, self.runicPower)
        ovaleCondition:registerCondition("soulshards", false, self.soulShards)
        ovaleCondition:registerCondition("alternatepowerdeficit", false, self.alternatePowerDeficit)
        ovaleCondition:registerCondition("astralpowerdeficit", false, self.astralPowerDeficit)
        ovaleCondition:registerCondition("chideficit", false, self.chiDeficit)
        ovaleCondition:registerCondition("combopointsdeficit", false, self.comboPointsDeficit)
        ovaleCondition:registerCondition("energydeficit", false, self.energyDeficit)
        ovaleCondition:registerCondition("focusdeficit", false, self.focusDeficit)
        ovaleCondition:registerCondition("furydeficit", false, self.furyDeficit)
        ovaleCondition:registerCondition("holypowerdeficit", false, self.holyPowerDeficit)
        ovaleCondition:registerCondition("manadeficit", false, self.manaDeficit)
        ovaleCondition:registerCondition("paindeficit", false, self.painDeficit)
        ovaleCondition:registerCondition("ragedeficit", false, self.rageDeficit)
        ovaleCondition:registerCondition("runicpowerdeficit", false, self.runicPowerDeficit)
        ovaleCondition:registerCondition("soulshardsdeficit", false, self.soulShardsDeficit)
        ovaleCondition:registerCondition("manapercent", false, self.manaPercent)
        ovaleCondition:registerCondition("maxalternatepower", false, self.maxAlternatePower)
        ovaleCondition:registerCondition("maxarcanecharges", false, self.maxArcaneCharges)
        ovaleCondition:registerCondition("maxchi", false, self.maxChi)
        ovaleCondition:registerCondition("maxcombopoints", false, self.maxComboPoints)
        ovaleCondition:registerCondition("maxenergy", false, self.maxEnergy)
        ovaleCondition:registerCondition("maxfocus", false, self.maxFocus)
        ovaleCondition:registerCondition("maxfury", false, self.maxFury)
        ovaleCondition:registerCondition("maxholypower", false, self.maxHolyPower)
        ovaleCondition:registerCondition("maxmana", false, self.maxMana)
        ovaleCondition:registerCondition("maxpain", false, self.maxPain)
        ovaleCondition:registerCondition("maxrage", false, self.maxRage)
        ovaleCondition:registerCondition("maxrunicpower", false, self.maxRunicPower)
        ovaleCondition:registerCondition("maxsoulshards", false, self.maxSoulShards)
        ovaleCondition:registerCondition("powercost", true, self.mainPowerCost)
        ovaleCondition:registerCondition("astralpowercost", true, self.astralPowerCost)
        ovaleCondition:registerCondition("energycost", true, self.energyCost)
        ovaleCondition:registerCondition("focuscost", true, self.focusCost)
        ovaleCondition:registerCondition("manacost", true, self.manaCost)
        ovaleCondition:registerCondition("ragecost", true, self.rageCost)
        ovaleCondition:registerCondition("runicpowercost", true, self.runicPowerCost)
        ovaleCondition:registerCondition("previousgcdspell", true, self.previousGCDSpell)
        ovaleCondition:registerCondition("previousoffgcdspell", true, self.previousOffGCDSpell)
        ovaleCondition:registerCondition("previousspell", true, self.previousSpell)
        ovaleCondition:registerCondition("relativelevel", false, self.relativeLevel)
        ovaleCondition:registerCondition("refreshable", false, self.refreshable)
        ovaleCondition:registerCondition("debuffrefreshable", false, self.refreshable)
        ovaleCondition:registerCondition("buffrefreshable", false, self.refreshable)
        ovaleCondition:registerCondition("remainingcasttime", false, self.remainingCastTime)
        ovaleCondition:registerCondition("rune", false, self.rune)
        ovaleCondition:registerCondition("runecount", false, self.runeCount)
        ovaleCondition:registerCondition("timetorunes", false, self.timeToRunes)
        ovaleCondition:registerCondition("runedeficit", false, self.runeDeficit)
        ovaleCondition:registerCondition("agility", false, self.agility)
        ovaleCondition:registerCondition("attackpower", false, self.attackPower)
        ovaleCondition:registerCondition("critrating", false, self.critRating)
        ovaleCondition:registerCondition("hasterating", false, self.hasteRating)
        ovaleCondition:registerCondition("intellect", false, self.intellect)
        ovaleCondition:registerCondition("mastery", false, self.masteryEffect)
        ovaleCondition:registerCondition("masteryeffect", false, self.masteryEffect)
        ovaleCondition:registerCondition("masteryrating", false, self.masteryRating)
        ovaleCondition:registerCondition("meleecritchance", false, self.meleeCritChance)
        ovaleCondition:registerCondition("meleeattackspeedpercent", false, self.meleeAttackSpeedPercent)
        ovaleCondition:registerCondition("rangedcritchance", false, self.rangedCritChance)
        ovaleCondition:registerCondition("spellcritchance", false, self.spellCritChance)
        ovaleCondition:registerCondition("spellcastspeedpercent", false, self.spellCastSpeedPercent)
        ovaleCondition:registerCondition("spellpower", false, self.spellpower)
        ovaleCondition:registerCondition("stamina", false, self.stamina)
        ovaleCondition:registerCondition("strength", false, self.strength)
        ovaleCondition:registerCondition("versatility", false, self.versatility)
        ovaleCondition:registerCondition("versatilityRating", false, self.versatilityRating)
        ovaleCondition:registerCondition("speed", false, self.speed)
        ovaleCondition:registerCondition("spellchargecooldown", true, self.spellChargeCooldown)
        ovaleCondition:registerCondition("charges", true, self.spellCharges)
        ovaleCondition:registerCondition("spellcharges", true, self.spellCharges)
        ovaleCondition:registerCondition("spellfullrecharge", true, self.spellFullRecharge)
        ovaleCondition:registerCondition("spellcooldown", true, self.spellCooldown)
        ovaleCondition:registerCondition("spellcooldownduration", true, self.spellCooldownDuration)
        ovaleCondition:registerCondition("spellrechargeduration", true, self.spellRechargeDuration)
        ovaleCondition:registerCondition("spelldata", false, self.spellData)
        ovaleCondition:registerCondition("spellinfoproperty", false, self.spellInfoProperty)
        ovaleCondition:registerCondition("spellcount", true, self.spellCount)
        ovaleCondition:registerCondition("spellknown", true, self.spellKnown)
        ovaleCondition:registerCondition("spellmaxcharges", true, self.spellMaxCharges)
        ovaleCondition:registerCondition("spellusable", true, self.spellUsable)
        ovaleCondition:registerCondition("isstealthed", false, self.stealthed)
        ovaleCondition:registerCondition("stealthed", false, self.stealthed)
        ovaleCondition:registerCondition("lastswing", false, self.lastSwing)
        ovaleCondition:registerCondition("nextswing", false, self.nextSwing)
        ovaleCondition:registerCondition("talent", false, self.talent)
        ovaleCondition:registerCondition("hastalent", false, self.talent)
        ovaleCondition:registerCondition("talentpoints", false, self.talentPoints)
        ovaleCondition:registerCondition("istargetingplayer", false, self.targetIsPlayer)
        ovaleCondition:registerCondition("targetisplayer", false, self.targetIsPlayer)
        ovaleCondition:registerCondition("threat", false, self.threat)
        ovaleCondition:registerCondition("ticktime", false, self.tickTime)
        ovaleCondition:registerCondition("currentticktime", false, self.currentTickTime)
        ovaleCondition:registerCondition("ticksremaining", false, self.ticksRemaining)
        ovaleCondition:registerCondition("ticksremain", false, self.ticksRemaining)
        ovaleCondition:registerCondition("ticktimeremaining", false, self.tickTimeRemaining)
        ovaleCondition:registerCondition("timesincepreviousspell", false, self.timeSincePreviousSpell)
        ovaleCondition:registerCondition("timetobloodlust", false, self.timeToBloodlust)
        ovaleCondition:registerCondition("timetoeclipse", false, self.timeToEclipse)
        ovaleCondition:registerCondition("timetoenergy", false, self.timeToEnergy)
        ovaleCondition:registerCondition("timetofocus", false, self.timeToFocus)
        ovaleCondition:registerCondition("timetomaxenergy", false, self.timeToMaxEnergy)
        ovaleCondition:registerCondition("timetomaxfocus", false, self.timeToMaxFocus)
        ovaleCondition:registerCondition("timetomaxmana", false, self.timeToMaxMana)
        ovaleCondition:registerCondition("timetoenergyfor", true, self.timeToEnergyFor)
        ovaleCondition:registerCondition("timetofocusfor", true, self.timeToFocusFor)
        ovaleCondition:registerCondition("timetospell", true, self.timeToSpell)
        ovaleCondition:registerCondition("timewithhaste", false, self.timeWithHaste)
        ovaleCondition:registerCondition("totemexpires", false, self.totemExpires)
        ovaleCondition:registerCondition("totempresent", false, self.totemPresent)
        ovaleCondition:registerCondition("totemremaining", false, self.totemRemaining)
        ovaleCondition:registerCondition("totemremains", false, self.totemRemaining)
        ovaleCondition:registerCondition("tracking", false, self.tracking)
        ovaleCondition:registerCondition("traveltime", true, self.travelTime)
        ovaleCondition:registerCondition("maxtraveltime", true, self.travelTime)
        ovaleCondition:registerCondition("always", false, self.getTrue)
        ovaleCondition:registerCondition("weapondps", false, self.weaponDPS)
        ovaleCondition:registerCondition("sigilcharging", false, self.sigilCharging)
        ovaleCondition:registerCondition("isbossfight", false, self.isBossFight)
        ovaleCondition:registerCondition("race", false, self.race)
        ovaleCondition:registerCondition("unitinparty", false, self.unitInPartyCond)
        ovaleCondition:registerCondition("unitinraid", false, self.unitInRaidCond)
        ovaleCondition:registerCondition("soulfragments", false, self.soulFragments)
        ovaleCondition:registerCondition("hasdebufftype", false, self.hasDebuffType)
    end,
})
