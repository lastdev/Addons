local __exports = LibStub:NewLibrary("ovale/states/Aura", 90103)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __uiLocalization = LibStub:GetLibrary("ovale/ui/Localization")
local l = __uiLocalization.l
local __toolsPool = LibStub:GetLibrary("ovale/tools/Pool")
local OvalePool = __toolsPool.OvalePool
local __enginestate = LibStub:GetLibrary("ovale/engine/state")
local States = __enginestate.States
local aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local pairs = pairs
local tonumber = tonumber
local tostring = tostring
local wipe = wipe
local next = next
local kpairs = pairs
local unpack = unpack
local lower = string.lower
local concat = table.concat
local insert = table.insert
local sort = table.sort
local GetTime = GetTime
local UnitAura = UnitAura
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local INFINITY = math.huge
local huge = math.huge
local __toolstools = LibStub:GetLibrary("ovale/tools/tools")
local isNumber = __toolstools.isNumber
local isString = __toolstools.isString
local __enginecondition = LibStub:GetLibrary("ovale/engine/condition")
local parseCondition = __enginecondition.parseCondition
local returnConstant = __enginecondition.returnConstant
local returnValue = __enginecondition.returnValue
local returnValueBetween = __enginecondition.returnValueBetween
local strlower = lower
local tconcat = concat
local playerGUID = "fake_guid"
local petGUIDs = {}
local pool = OvalePool("OvaleAura_pool")
local unknownGuid = "0"
__exports.debuffTypes = {
    curse = true,
    disease = true,
    enrage = true,
    magic = true,
    poison = true
}
__exports.spellInfoDebuffTypes = {}
do
    for debuffType in pairs(__exports.debuffTypes) do
        local siDebuffType = strlower(debuffType)
        __exports.spellInfoDebuffTypes[siDebuffType] = debuffType
    end
end
local spellAuraEvents = {
    SPELL_AURA_APPLIED = true,
    SPELL_AURA_REMOVED = true,
    SPELL_AURA_APPLIED_DOSE = true,
    SPELL_AURA_REMOVED_DOSE = true,
    SPELL_AURA_REFRESH = true,
    SPELL_AURA_BROKEN = true,
    SPELL_AURA_BROKEN_SPELL = true
}
local spellPeriodicEvents = {
    SPELL_PERIODIC_DAMAGE = true,
    SPELL_PERIODIC_HEAL = true,
    SPELL_PERIODIC_ENERGIZE = true,
    SPELL_PERIODIC_DRAIN = true,
    SPELL_PERIODIC_LEECH = true
}
local array = {}
__exports.putAura = function(auraDB, guid, auraId, casterGUID, aura)
    local auraForGuid = auraDB[guid]
    if  not auraForGuid then
        auraForGuid = pool:get()
        auraDB[guid] = auraForGuid
    end
    local auraForId = auraForGuid[auraId]
    if  not auraForId then
        auraForId = pool:get()
        auraForGuid[auraId] = auraForId
    end
    local previousAura = auraForId[casterGUID]
    if previousAura then
        pool:release(previousAura)
    end
    auraForId[casterGUID] = aura
    aura.guid = guid
    aura.spellId = auraId
    aura.source = casterGUID
end
__exports.getAura = function(auraDB, guid, auraId, casterGUID)
    if auraDB[guid] and auraDB[guid][auraId] and auraDB[guid][auraId][casterGUID] then
        return auraDB[guid][auraId][casterGUID]
    end
end
local function getAuraAnyCaster(auraDB, guid, auraId)
    local auraFound
    if auraDB[guid] and auraDB[guid][auraId] then
        for _, aura in pairs(auraDB[guid][auraId]) do
            if  not auraFound or auraFound.ending < aura.ending then
                auraFound = aura
            end
        end
    end
    return auraFound
end
local function getDebuffType(auraDB, guid, debuffType, filter, casterGUID)
    local auraFound
    if auraDB[guid] then
        for _, whoseTable in pairs(auraDB[guid]) do
            local aura = whoseTable[casterGUID]
            if aura and aura.debuffType == debuffType and aura.filter == filter then
                if  not auraFound or auraFound.ending < aura.ending then
                    auraFound = aura
                end
            end
        end
    end
    return auraFound
end
local function getDebuffTypeAnyCaster(auraDB, guid, debuffType, filter)
    local auraFound
    if auraDB[guid] then
        for _, whoseTable in pairs(auraDB[guid]) do
            for _, aura in pairs(whoseTable) do
                if aura and aura.debuffType == debuffType and aura.filter == filter then
                    if  not auraFound or auraFound.ending < aura.ending then
                        auraFound = aura
                    end
                end
            end
        end
    end
    return auraFound
end
local function getAuraOnGUID(auraDB, guid, auraId, filter, mine)
    local auraFound
    if __exports.debuffTypes[auraId] then
        if mine and playerGUID then
            auraFound = getDebuffType(auraDB, guid, auraId, filter, playerGUID)
            if  not auraFound then
                for petGUID in pairs(petGUIDs) do
                    local aura = getDebuffType(auraDB, guid, auraId, filter, petGUID)
                    if aura and ( not auraFound or auraFound.ending < aura.ending) then
                        auraFound = aura
                    end
                end
            end
        else
            auraFound = getDebuffTypeAnyCaster(auraDB, guid, auraId, filter)
        end
    else
        if mine and playerGUID then
            auraFound = __exports.getAura(auraDB, guid, auraId, playerGUID)
            if  not auraFound then
                for petGUID in pairs(petGUIDs) do
                    local aura = __exports.getAura(auraDB, guid, auraId, petGUID)
                    if aura and ( not auraFound or auraFound.ending < aura.ending) then
                        auraFound = aura
                    end
                end
            end
        else
            auraFound = getAuraAnyCaster(auraDB, guid, auraId)
        end
    end
    return auraFound
end
__exports.removeAurasOnGUID = function(auraDB, guid)
    if auraDB[guid] then
        local auraTable = auraDB[guid]
        for auraId, whoseTable in pairs(auraTable) do
            for casterGUID, aura in pairs(whoseTable) do
                pool:release(aura)
                whoseTable[casterGUID] = nil
            end
            pool:release(whoseTable)
            auraTable[auraId] = nil
        end
        pool:release(auraTable)
        auraDB[guid] = nil
    end
end
local AuraInterface = __class(nil, {
    constructor = function(self)
        self.aura = {}
        self.serial = {}
        self.auraSerial = 0
    end
})
local count
local stacks
local startChangeCount, endingChangeCount
local startFirst, endingLast
__exports.OvaleAuraClass = __class(States, {
    constructor = function(self, ovaleState, ovalePaperDoll, baseState, ovaleData, ovaleGuid, lastSpell, ovaleOptions, ovaleDebug, ovale, ovaleProfiler, ovaleSpellBook, ovalePower)
        self.ovaleState = ovaleState
        self.ovalePaperDoll = ovalePaperDoll
        self.baseState = baseState
        self.ovaleData = ovaleData
        self.ovaleGuid = ovaleGuid
        self.lastSpell = lastSpell
        self.ovaleOptions = ovaleOptions
        self.ovaleDebug = ovaleDebug
        self.ovale = ovale
        self.ovaleSpellBook = ovaleSpellBook
        self.ovalePower = ovalePower
        self.handleInitialize = function()
            playerGUID = self.ovale.playerGUID
            petGUIDs = self.ovaleGuid.petGUID
            self.module:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", self.handleCombatLogEventUnfiltered)
            self.module:RegisterEvent("PLAYER_ENTERING_WORLD", self.handlePlayerEnteringWorld)
            self.module:RegisterEvent("PLAYER_REGEN_ENABLED", self.handlePlayerRegenEnabled)
            self.module:RegisterEvent("UNIT_AURA", self.handleUnitAura)
            self.module:RegisterMessage("Ovale_GroupChanged", self.handleOvaleGroupChanged)
            self.module:RegisterMessage("Ovale_UnitChanged", self.handleUnitChanged)
        end
        self.handleDisable = function()
            self.module:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
            self.module:UnregisterEvent("PLAYER_ENTERING_WORLD")
            self.module:UnregisterEvent("PLAYER_REGEN_ENABLED")
            self.module:UnregisterEvent("PLAYER_UNGHOST")
            self.module:UnregisterEvent("UNIT_AURA")
            self.module:UnregisterMessage("Ovale_GroupChanged")
            self.module:UnregisterMessage("Ovale_UnitChanged")
            for guid in pairs(self.current.aura) do
                __exports.removeAurasOnGUID(self.current.aura, guid)
            end
            pool:drain()
        end
        self.handleCombatLogEventUnfiltered = function(event, ...)
            self.debug:debugTimestamp("COMBAT_LOG_EVENT_UNFILTERED", CombatLogGetCurrentEventInfo())
            local _, cleuEvent, _, sourceGUID, _, _, _, destGUID, _, _, _, spellId, spellName, _, auraType, amount = CombatLogGetCurrentEventInfo()
            local mine = sourceGUID == playerGUID or self.ovaleGuid:isPlayerPet(sourceGUID)
            if mine and cleuEvent == "SPELL_MISSED" then
                local unitId = self.ovaleGuid:getUnitByGuid(destGUID)
                if unitId then
                    self.debug:debugTimestamp("%s: %s (%s)", cleuEvent, destGUID, unitId)
                    self:scanAuras(unitId, destGUID)
                end
            end
            if spellAuraEvents[cleuEvent] then
                self.ovaleData:registerAuraSeen(spellId)
                local unitId = self.ovaleGuid:getUnitByGuid(destGUID)
                self.debug:debugTimestamp("UnitId: ", unitId)
                if unitId then
                    if  not self.ovaleGuid.unitAuraUnits[unitId] then
                        self.debug:debugTimestamp("%s: %s (%s)", cleuEvent, destGUID, unitId)
                        self:scanAuras(unitId, destGUID)
                    end
                elseif mine then
                    self.debug:debugTimestamp("%s: %s (%d) on %s", cleuEvent, spellName, spellId, destGUID)
                    local now = GetTime()
                    if cleuEvent == "SPELL_AURA_REMOVED" or cleuEvent == "SPELL_AURA_BROKEN" or cleuEvent == "SPELL_AURA_BROKEN_SPELL" then
                        self:lostAuraOnGUID(destGUID, now, spellId, sourceGUID)
                    else
                        local filter = (auraType == "BUFF" and "HELPFUL") or "HARMFUL"
                        local si = self.ovaleData.spellInfo[spellId]
                        local aura = getAuraOnGUID(self.current.aura, destGUID, spellId, filter, true)
                        local duration = 15
                        if aura then
                            duration = aura.duration
                        elseif si and si.duration then
                            duration = self.ovaleData:getSpellInfoPropertyNumber(spellId, now, "duration", destGUID) or 15
                        end
                        local expirationTime = now + duration
                        local count
                        if cleuEvent == "SPELL_AURA_APPLIED" then
                            count = 1
                        elseif cleuEvent == "SPELL_AURA_APPLIED_DOSE" or cleuEvent == "SPELL_AURA_REMOVED_DOSE" then
                            count = amount
                        elseif cleuEvent == "SPELL_AURA_REFRESH" then
                            count = (aura and aura.stacks) or 1
                        end
                        self:gainedAuraOnGUID(destGUID, now, spellId, sourceGUID, filter, true, nil, count, nil, duration, expirationTime, false, spellName)
                    end
                end
            elseif mine and spellPeriodicEvents[cleuEvent] and playerGUID then
                self.ovaleData:registerAuraSeen(spellId)
                self.debug:debugTimestamp("%s: %s", cleuEvent, destGUID)
                local aura = __exports.getAura(self.current.aura, destGUID, spellId, playerGUID)
                local now = GetTime()
                if aura and self:isActiveAura(aura, now) then
                    local name = aura.name or "Unknown spell"
                    local baseTick, lastTickTime = aura.baseTick, aura.lastTickTime
                    local tick
                    if lastTickTime then
                        tick = now - lastTickTime
                    elseif  not baseTick then
                        self.debug:debug("    First tick seen of unknown periodic aura %s (%d) on %s.", name, spellId, destGUID)
                        local si = self.ovaleData.spellInfo[spellId]
                        baseTick = (si and si.tick and si.tick) or 3
                        tick = self:getTickLength(spellId)
                    else
                        tick = baseTick
                    end
                    aura.baseTick = baseTick
                    aura.lastTickTime = now
                    aura.tick = tick
                    self.debug:debug("    Updating %s (%s) on %s, tick=%s, lastTickTime=%s", name, spellId, destGUID, tick, lastTickTime)
                    self.ovale.refreshNeeded[destGUID] = true
                end
            end
        end
        self.handlePlayerEnteringWorld = function(event)
            self:scanAllUnitAuras()
        end
        self.handlePlayerRegenEnabled = function(event)
            self:removeAurasOnInactiveUnits()
            pool:drain()
        end
        self.handleUnitAura = function(event, unitId)
            self.debug:debug(event, unitId)
            self:scanAuras(unitId)
        end
        self.handleOvaleGroupChanged = function()
            return self:scanAllUnitAuras()
        end
        self.handleUnitChanged = function(event, unitId, guid)
            if (unitId == "pet" or unitId == "target") and guid then
                self.debug:debug(event, unitId, guid)
                self:scanAuras(unitId, guid)
            end
        end
        self.buffLastExpire = function(positionalParameters, namedParameters, atTime)
            local spellId = unpack(positionalParameters)
            local target, filter, mine = parseCondition(namedParameters, self.baseState)
            local aura = self:getAura(target, spellId, atTime, filter, mine)
            if  not aura then
                return 
            end
            return returnValue(0, aura.ending, 1)
        end
        self.ticksGainedOnRefresh = function(positionalParameters, namedParameters, atTime)
            local target, filter, mine = parseCondition(namedParameters, self.baseState)
            local auraId, spellId = unpack(positionalParameters)
            auraId = tonumber(auraId)
            if isNumber(spellId) then
                spellId = tonumber(spellId)
            elseif isString(spellId) then
                spellId = tostring(spellId)
            else
                spellId = nil
            end
            local duration = self:getBaseDuration(auraId, spellId, atTime, self.ovalePaperDoll.next)
            local tick = self:getTickLength(auraId, self.ovalePaperDoll.next)
            local aura = self:getAura(target, auraId, atTime, filter, mine)
            if aura then
                local remainingDuration = aura.ending - atTime
                local pandemicDuration = 0.3 * (aura.ending - aura.start)
                local refreshedDuration = pandemicDuration + duration
                if remainingDuration < pandemicDuration then
                    refreshedDuration = remainingDuration + duration
                end
                return returnValueBetween(aura.gain, INFINITY, (refreshedDuration - remainingDuration) / tick, atTime, -1 / tick)
            end
            return returnConstant(duration / tick)
        end
        self.applySpellStartCast = function(spellId, targetGUID, startCast, endCast, isChanneled, spellcast)
            self.profiler:startProfiling("OvaleAura_ApplySpellStartCast")
            if isChanneled then
                local si = self.ovaleData.spellInfo[spellId]
                if si and si.aura then
                    if si.aura.player then
                        self:applySpellAuras(spellId, playerGUID, startCast, si.aura.player, spellcast)
                    end
                    if si.aura.target then
                        self:applySpellAuras(spellId, targetGUID, startCast, si.aura.target, spellcast)
                    end
                    if si.aura.pet then
                        local petGUID = self.ovaleGuid:getUnitGUID("pet")
                        if petGUID then
                            self:applySpellAuras(spellId, petGUID, startCast, si.aura.pet, spellcast)
                        end
                    end
                end
            end
            self.profiler:stopProfiling("OvaleAura_ApplySpellStartCast")
        end
        self.applySpellAfterCast = function(spellId, targetGUID, startCast, endCast, isChanneled, spellcast)
            self.profiler:startProfiling("OvaleAura_ApplySpellAfterCast")
            if  not isChanneled then
                local si = self.ovaleData.spellInfo[spellId]
                if si and si.aura then
                    if si.aura.player then
                        self:applySpellAuras(spellId, playerGUID, endCast, si.aura.player, spellcast)
                    end
                    if si.aura.pet then
                        local petGUID = self.ovaleGuid:getUnitGUID("pet")
                        if petGUID then
                            self:applySpellAuras(spellId, petGUID, startCast, si.aura.pet, spellcast)
                        end
                    end
                end
            end
            self.profiler:stopProfiling("OvaleAura_ApplySpellAfterCast")
        end
        self.applySpellOnHit = function(spellId, targetGUID, startCast, endCast, isChanneled, spellcast)
            self.profiler:startProfiling("OvaleAura_ApplySpellAfterHit")
            if  not isChanneled then
                local si = self.ovaleData.spellInfo[spellId]
                if si and si.aura and si.aura.target then
                    local travelTime = si.travel_time or 0
                    if travelTime > 0 then
                        local estimatedTravelTime = 1
                        if travelTime < estimatedTravelTime then
                            travelTime = estimatedTravelTime
                        end
                    end
                    local atTime = endCast + travelTime
                    self:applySpellAuras(spellId, targetGUID, atTime, si.aura.target, spellcast)
                end
            end
            self.profiler:stopProfiling("OvaleAura_ApplySpellAfterHit")
        end
        States.constructor(self, AuraInterface)
        self.module = ovale:createModule("OvaleAura", self.handleInitialize, self.handleDisable, aceEvent)
        self.debug = ovaleDebug:create("OvaleAura")
        self.profiler = ovaleProfiler:create("OvaleAura")
        self.ovaleState:registerState(self)
        self:addDebugOptions()
    end,
    registerConditions = function(self, condition)
        condition:registerCondition("bufflastexpire", true, self.buffLastExpire)
        condition:registerCondition("ticksgainedonrefresh", true, self.ticksGainedOnRefresh)
    end,
    isWithinAuraLag = function(self, time1, time2, factor)
        factor = factor or 1
        local auraLag = self.ovaleOptions.db.profile.apparence.auraLag
        local tolerance = (factor * auraLag) / 1000
        return time1 - time2 < tolerance and time2 - time1 < tolerance
    end,
    countMatchingActiveAura = function(self, aura)
        self.debug:log("Counting aura %s found on %s with (%s, %s)", aura.spellId, aura.guid, aura.start, aura.ending)
        count = count + 1
        stacks = stacks + aura.stacks
        if aura.ending < endingChangeCount then
            startChangeCount, endingChangeCount = aura.gain, aura.ending
        end
        if aura.gain < startFirst then
            startFirst = aura.gain
        end
        if aura.ending > endingLast then
            endingLast = aura.ending
        end
    end,
    addDebugOptions = function(self)
        local output = {}
        local debugOptions = {
            playerAura = {
                name = l["auras_player"],
                type = "group",
                args = {
                    buff = {
                        name = l["auras_on_player"],
                        type = "input",
                        multiline = 25,
                        width = "full",
                        get = function(info)
                            wipe(output)
                            local now = GetTime()
                            local helpful = self:debugUnitAuras("player", "HELPFUL", now)
                            if helpful then
                                output[#output + 1] = "== BUFFS =="
                                output[#output + 1] = helpful
                            end
                            local harmful = self:debugUnitAuras("player", "HARMFUL", now)
                            if harmful then
                                output[#output + 1] = "== DEBUFFS =="
                                output[#output + 1] = harmful
                            end
                            return tconcat(output, "\n")
                        end
                    }
                }
            },
            targetAura = {
                name = l["auras_target"],
                type = "group",
                args = {
                    targetbuff = {
                        name = l["auras_on_target"],
                        type = "input",
                        multiline = 25,
                        width = "full",
                        get = function(info)
                            wipe(output)
                            local now = GetTime()
                            local helpful = self:debugUnitAuras("target", "HELPFUL", now)
                            if helpful then
                                output[#output + 1] = "== BUFFS =="
                                output[#output + 1] = helpful
                            end
                            local harmful = self:debugUnitAuras("target", "HARMFUL", now)
                            if harmful then
                                output[#output + 1] = "== DEBUFFS =="
                                output[#output + 1] = harmful
                            end
                            return tconcat(output, "\n")
                        end
                    }
                }
            }
        }
        for k, v in pairs(debugOptions) do
            self.ovaleDebug.defaultOptions.args[k] = v
        end
    end,
    scanAllUnitAuras = function(self)
        for unitId in pairs(self.ovaleGuid.unitAuraUnits) do
            self:scanAuras(unitId)
        end
    end,
    removeAurasOnInactiveUnits = function(self)
        for guid in pairs(self.current.aura) do
            local unitId = self.ovaleGuid:getUnitByGuid(guid)
            if  not unitId then
                self.debug:debug("Removing auras from GUID %s", guid)
                __exports.removeAurasOnGUID(self.current.aura, guid)
                self.current.serial[guid] = nil
            end
        end
    end,
    isActiveAura = function(self, aura, atTime)
        local boolean = false
        if aura.state then
            if aura.serial == self.next.auraSerial and aura.stacks > 0 and aura.gain <= atTime and atTime <= aura.ending then
                boolean = true
            elseif aura.consumed and self:isWithinAuraLag(aura.ending, atTime) then
                boolean = true
            end
        else
            if aura.serial == self.current.serial[aura.guid] and aura.stacks > 0 and aura.gain <= atTime and atTime <= aura.ending then
                boolean = true
            elseif aura.consumed and self:isWithinAuraLag(aura.ending, atTime) then
                boolean = true
            end
        end
        return boolean
    end,
    gainedAuraOnGUID = function(self, guid, atTime, auraId, casterGUID, filter, visible, icon, count, debuffType, duration, expirationTime, isStealable, name, value1, value2, value3)
        self.profiler:startProfiling("OvaleAura_GainedAuraOnGUID")
        casterGUID = casterGUID or unknownGuid
        count = (count and count > 0 and count) or 1
        duration = (duration and duration > 0 and duration) or INFINITY
        expirationTime = (expirationTime and expirationTime > 0 and expirationTime) or INFINITY
        local aura = __exports.getAura(self.current.aura, guid, auraId, casterGUID)
        local auraIsActive
        if aura then
            auraIsActive = aura.stacks > 0 and aura.gain <= atTime and atTime <= aura.ending
        else
            aura = pool:get()
            __exports.putAura(self.current.aura, guid, auraId, casterGUID, aura)
            auraIsActive = false
        end
        local auraIsUnchanged = aura.source == casterGUID and aura.duration == duration and aura.ending == expirationTime and aura.stacks == count and aura.value1 == value1 and aura.value2 == value2 and aura.value3 == value3
        aura.serial = self.current.serial[guid]
        if  not auraIsActive or  not auraIsUnchanged then
            self.debug:debug("    Adding %s %s (%s) to %s at %f, aura.serial=%d, duration=%f, expirationTime=%f, auraIsActive=%s, auraIsUnchanged=%s", filter, name, auraId, guid, atTime, aura.serial, duration, expirationTime, (auraIsActive and "true") or "false", (auraIsUnchanged and "true") or "false")
            aura.name = name
            aura.duration = duration
            aura.ending = expirationTime
            if duration < INFINITY and expirationTime < INFINITY then
                aura.start = expirationTime - duration
            else
                aura.start = atTime
            end
            aura.gain = atTime
            aura.lastUpdated = atTime
            local direction = aura.direction or 1
            if aura.stacks then
                if aura.stacks < count then
                    direction = 1
                elseif aura.stacks > count then
                    direction = -1
                end
            end
            aura.direction = direction
            aura.stacks = count
            aura.consumed = false
            aura.filter = filter
            aura.visible = visible
            aura.icon = icon
            aura.debuffType = (isString(debuffType) and lower(debuffType)) or debuffType
            aura.stealable = isStealable
            aura.value1, aura.value2, aura.value3 = value1, value2, value3
            local mine = casterGUID == playerGUID or self.ovaleGuid:isPlayerPet(casterGUID)
            if mine then
                local spellcast = self.lastSpell:lastInFlightSpell()
                if spellcast and spellcast.stop and  not self:isWithinAuraLag(spellcast.stop, atTime) then
                    spellcast = self.lastSpell.lastSpellcast
                    if spellcast and spellcast.stop and  not self:isWithinAuraLag(spellcast.stop, atTime) then
                        spellcast = nil
                    end
                end
                if spellcast and spellcast.target == guid then
                    local spellId = spellcast.spellId
                    local spellName = self.ovaleSpellBook:getSpellName(spellId) or "Unknown spell"
                    local keepSnapshot = false
                    local si = self.ovaleData.spellInfo[spellId]
                    if si and si.aura then
                        local auraTable = (self.ovaleGuid:isPlayerPet(guid) and si.aura.pet) or si.aura.target
                        if auraTable and auraTable[filter] then
                            local spellData = auraTable[filter][auraId]
                            if spellData and spellData.cachedParams.named.refresh_keep_snapshot and (spellData.cachedParams.named.enabled == nil or spellData.cachedParams.named.enabled) then
                                keepSnapshot = true
                            end
                        end
                    end
                    if keepSnapshot then
                        self.debug:debug("    Keeping snapshot stats for %s %s (%d) on %s refreshed by %s (%d) from %f, now=%f, aura.serial=%d", filter, name, auraId, guid, spellName, spellId, aura.snapshotTime, atTime, aura.serial)
                    else
                        self.debug:debug("    Snapshot stats for %s %s (%d) on %s applied by %s (%d) from %f, now=%f, aura.serial=%d", filter, name, auraId, guid, spellName, spellId, spellcast.snapshotTime, atTime, aura.serial)
                        self.lastSpell:copySpellcastInfo(spellcast, aura)
                    end
                end
                local si = self.ovaleData.spellInfo[auraId]
                if si then
                    if si.tick then
                        self.debug:debug("    %s (%s) is a periodic aura.", name, auraId)
                        if  not auraIsActive then
                            aura.baseTick = si.tick
                            if spellcast and spellcast.target == guid then
                                aura.tick = self:getTickLength(auraId, spellcast)
                            else
                                aura.tick = self:getTickLength(auraId)
                            end
                        end
                    end
                    if si.buff_cd and guid == playerGUID then
                        self.debug:debug("    %s (%s) is applied by an item with a cooldown of %ds.", name, auraId, si.buff_cd)
                        if  not auraIsActive then
                            aura.cooldownEnding = aura.gain + si.buff_cd
                        end
                    end
                end
            end
            if  not auraIsActive then
                self.module:SendMessage("Ovale_AuraAdded", atTime, guid, auraId, aura.source)
            elseif  not auraIsUnchanged then
                self.module:SendMessage("Ovale_AuraChanged", atTime, guid, auraId, aura.source)
            end
            self.ovale.refreshNeeded[guid] = true
        end
        self.profiler:stopProfiling("OvaleAura_GainedAuraOnGUID")
    end,
    lostAuraOnGUID = function(self, guid, atTime, auraId, casterGUID)
        self.profiler:startProfiling("OvaleAura_LostAuraOnGUID")
        local aura = __exports.getAura(self.current.aura, guid, auraId, casterGUID)
        if aura then
            local filter = aura.filter
            self.debug:debug("    Expiring %s %s (%d) from %s at %f.", filter, aura.name, auraId, guid, atTime)
            if aura.ending > atTime then
                aura.ending = atTime
            end
            local mine = casterGUID == playerGUID or self.ovaleGuid:isPlayerPet(casterGUID)
            if mine then
                aura.baseTick = nil
                aura.lastTickTime = nil
                aura.tick = nil
                if aura.start + aura.duration > aura.ending then
                    local spellcast
                    if guid == playerGUID then
                        spellcast = self.lastSpell:lastSpellSent()
                    else
                        spellcast = self.lastSpell.lastSpellcast
                    end
                    if spellcast then
                        if (spellcast.success and spellcast.stop and self:isWithinAuraLag(spellcast.stop, aura.ending)) or (spellcast.queued and self:isWithinAuraLag(spellcast.queued, aura.ending)) then
                            aura.consumed = true
                            local spellName = self.ovaleSpellBook:getSpellName(spellcast.spellId) or "Unknown spell"
                            self.debug:debug("    Consuming %s %s (%d) on %s with queued %s (%d) at %f.", filter, aura.name, auraId, guid, spellName, spellcast.spellId, spellcast.queued)
                        end
                    end
                end
            end
            aura.lastUpdated = atTime
            self.module:SendMessage("Ovale_AuraRemoved", atTime, guid, auraId, aura.source)
            self.ovale.refreshNeeded[guid] = true
        end
        self.profiler:stopProfiling("OvaleAura_LostAuraOnGUID")
    end,
    scanAuras = function(self, unitId, guid)
        self.profiler:startProfiling("OvaleAura_ScanAuras")
        guid = guid or self.ovaleGuid:getUnitGUID(unitId)
        if guid then
            local harmfulFilter = (self.ovaleOptions.db.profile.apparence.fullAuraScan and "HARMFUL") or "HARMFUL|PLAYER"
            local helpfulFilter = (self.ovaleOptions.db.profile.apparence.fullAuraScan and "HELPFUL") or "HELPFUL|PLAYER"
            self.debug:debugTimestamp("Scanning auras on %s (%s)", guid, unitId)
            local serial = self.current.serial[guid] or 0
            serial = serial + 1
            self.debug:debug("    Advancing age of auras for %s (%s) to %d.", guid, unitId, serial)
            self.current.serial[guid] = serial
            local i = 1
            local filter = helpfulFilter
            local now = GetTime()
            while true do
                local name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, _, spellId, _, _, _, value1, value2, value3 = UnitAura(unitId, i, filter)
                if  not name then
                    if filter == helpfulFilter then
                        filter = harmfulFilter
                        i = 1
                    else
                        break
                    end
                else
                    local casterGUID = unitCaster and self.ovaleGuid:getUnitGUID(unitCaster)
                    if casterGUID then
                        if debuffType == "" then
                            debuffType = "enrage"
                        end
                        local auraType = (filter == harmfulFilter and "HARMFUL") or "HELPFUL"
                        self:gainedAuraOnGUID(guid, now, spellId, casterGUID, auraType, true, icon, count, debuffType, duration, expirationTime, isStealable, name, value1, value2, value3)
                    end
                    i = i + 1
                end
            end
            if self.current.aura[guid] then
                local auraTable = self.current.aura[guid]
                for auraId, whoseTable in pairs(auraTable) do
                    for casterGUID, aura in pairs(whoseTable) do
                        if aura.serial == serial - 1 then
                            if aura.visible then
                                self:lostAuraOnGUID(guid, now, tonumber(auraId), casterGUID)
                            else
                                aura.serial = serial
                                self.debug:debug("    Preserving aura %s (%d), start=%s, ending=%s, aura.serial=%d", aura.name, aura.spellId, aura.start, aura.ending, aura.serial)
                            end
                        end
                    end
                end
            end
            self.debug:debug("End scanning of auras on %s (%s).", guid, unitId)
        end
        self.profiler:stopProfiling("OvaleAura_ScanAuras")
    end,
    getStateAura = function(self, guid, auraId, casterGUID, atTime)
        local state = self:getState(atTime)
        local aura = __exports.getAura(state.aura, guid, auraId, casterGUID)
        if atTime and ( not aura or aura.serial < self.next.auraSerial) then
            aura = __exports.getAura(self.current.aura, guid, auraId, casterGUID)
        end
        if aura then
            self.debug:log("Found aura with stack = %d", aura.stacks)
        end
        return aura
    end,
    debugUnitAuras = function(self, unitId, filter, atTime)
        wipe(array)
        local guid = self.ovaleGuid:getUnitGUID(unitId)
        if atTime and guid and self.next.aura[guid] then
            for auraId, whoseTable in pairs(self.next.aura[guid]) do
                for _, aura in pairs(whoseTable) do
                    if self:isActiveAura(aura, atTime) and aura.filter == filter and  not aura.state then
                        local name = aura.name or "Unknown spell"
                        insert(array, name .. ": " .. auraId .. " " .. (aura.debuffType or "nil") .. " enrage=" .. ((aura.debuffType == "enrage" and 1) or 0))
                    end
                end
            end
        end
        if guid and self.current.aura[guid] then
            for auraId, whoseTable in pairs(self.current.aura[guid]) do
                for _, aura in pairs(whoseTable) do
                    if self:isActiveAura(aura, atTime) and aura.filter == filter then
                        local name = aura.name or "Unknown spell"
                        insert(array, name .. ": " .. auraId .. " " .. (aura.debuffType or "nil") .. " enrage=" .. ((aura.debuffType == "enrage" and 1) or 0))
                    end
                end
            end
        end
        if next(array) then
            sort(array)
            return concat(array, "\n")
        end
    end,
    getStateAuraAnyCaster = function(self, guid, auraId, atTime)
        local auraFound
        if self.current.aura[guid] and self.current.aura[guid][auraId] then
            for _, aura in pairs(self.current.aura[guid][auraId]) do
                if aura and  not aura.state and self:isActiveAura(aura, atTime) then
                    if  not auraFound or auraFound.ending < aura.ending then
                        auraFound = aura
                    end
                end
            end
        end
        if atTime and self.next.aura[guid] and self.next.aura[guid][auraId] then
            for _, aura in pairs(self.next.aura[guid][auraId]) do
                if aura.stacks > 0 then
                    if  not auraFound or auraFound.ending < aura.ending then
                        auraFound = aura
                    end
                end
            end
        end
        return auraFound
    end,
    getStateDebuffType = function(self, guid, debuffType, filter, casterGUID, atTime)
        local auraFound = nil
        if self.current.aura[guid] then
            for _, whoseTable in pairs(self.current.aura[guid]) do
                local aura = whoseTable[casterGUID]
                if aura and  not aura.state and self:isActiveAura(aura, atTime) then
                    if aura.debuffType == debuffType and aura.filter == filter then
                        if  not auraFound or auraFound.ending < aura.ending then
                            auraFound = aura
                        end
                    end
                end
            end
        end
        if atTime and self.next.aura[guid] then
            for _, whoseTable in pairs(self.next.aura[guid]) do
                local aura = whoseTable[casterGUID]
                if aura and aura.stacks > 0 then
                    if aura.debuffType == debuffType and aura.filter == filter then
                        if  not auraFound or auraFound.ending < aura.ending then
                            auraFound = aura
                        end
                    end
                end
            end
        end
        return auraFound
    end,
    getStateDebuffTypeAnyCaster = function(self, guid, debuffType, filter, atTime)
        local auraFound
        if self.current.aura[guid] then
            for _, whoseTable in pairs(self.current.aura[guid]) do
                for _, aura in pairs(whoseTable) do
                    if aura and  not aura.state and self:isActiveAura(aura, atTime) then
                        if aura.debuffType == debuffType and aura.filter == filter then
                            if  not auraFound or auraFound.ending < aura.ending then
                                auraFound = aura
                            end
                        end
                    end
                end
            end
        end
        if atTime and self.next.aura[guid] then
            for _, whoseTable in pairs(self.next.aura[guid]) do
                for _, aura in pairs(whoseTable) do
                    if aura and  not aura.state and aura.stacks > 0 then
                        if aura.debuffType == debuffType and aura.filter == filter then
                            if  not auraFound or auraFound.ending < aura.ending then
                                auraFound = aura
                            end
                        end
                    end
                end
            end
        end
        return auraFound
    end,
    getStateAuraOnGUID = function(self, guid, auraId, filter, mine, atTime)
        local auraFound = nil
        if __exports.debuffTypes[auraId] then
            if mine then
                auraFound = self:getStateDebuffType(guid, auraId, filter, playerGUID, atTime)
                if  not auraFound then
                    for petGUID in pairs(petGUIDs) do
                        local aura = self:getStateDebuffType(guid, auraId, filter, petGUID, atTime)
                        if aura and ( not auraFound or auraFound.ending < aura.ending) then
                            auraFound = aura
                        end
                    end
                end
            else
                auraFound = self:getStateDebuffTypeAnyCaster(guid, auraId, filter, atTime)
            end
        else
            if mine then
                local aura = self:getStateAura(guid, auraId, playerGUID, atTime)
                if aura and aura.stacks > 0 then
                    auraFound = aura
                else
                    for petGUID in pairs(petGUIDs) do
                        aura = self:getStateAura(guid, auraId, petGUID, atTime)
                        if aura and aura.stacks > 0 then
                            auraFound = aura
                            break
                        end
                    end
                end
            else
                auraFound = self:getStateAuraAnyCaster(guid, auraId, atTime)
            end
        end
        return auraFound
    end,
    getAuraByGUID = function(self, guid, auraId, filter, mine, atTime)
        local auraFound = nil
        if self.ovaleData.buffSpellList[auraId] then
            for id in pairs(self.ovaleData.buffSpellList[auraId]) do
                local aura = self:getStateAuraOnGUID(guid, id, filter, mine, atTime)
                if aura and ( not auraFound or auraFound.ending < aura.ending) then
                    self.debug:log("Aura %s matching '%s' found on %s with (%s, %s)", id, auraId, guid, aura.start, aura.ending)
                    auraFound = aura
                end
            end
            if  not auraFound then
                self.debug:log("Aura matching '%s' is missing on %s.", auraId, guid)
            end
        else
            auraFound = self:getStateAuraOnGUID(guid, auraId, filter, mine, atTime)
            if auraFound then
                self.debug:log("Aura %s found on %s with (%s, %s) [stacks=%d]", auraId, guid, auraFound.start, auraFound.ending, auraFound.stacks)
            else
                self.debug:log("Aura %s is missing on %s (mine=%s).", auraId, guid, mine)
            end
        end
        return auraFound
    end,
    getAura = function(self, unitId, auraId, atTime, filter, mine)
        local guid = self.ovaleGuid:getUnitGUID(unitId)
        if  not guid then
            return 
        end
        if isNumber(auraId) then
            self.ovaleData:registerAuraAsked(auraId)
        end
        return self:getAuraByGUID(guid, auraId, filter, mine, atTime)
    end,
    getAuraWithProperty = function(self, unitId, propertyName, filter, atTime)
        local count = 0
        local guid = self.ovaleGuid:getUnitGUID(unitId)
        if  not guid then
            return 
        end
        local start = huge
        local ending = 0
        if self.current.aura[guid] then
            for _, whoseTable in pairs(self.current.aura[guid]) do
                for _, aura in pairs(whoseTable) do
                    if self:isActiveAura(aura, atTime) and  not aura.state then
                        if aura[propertyName] and aura.filter == filter then
                            count = count + 1
                            start = (aura.gain < start and aura.gain) or start
                            ending = (aura.ending > ending and aura.ending) or ending
                        end
                    end
                end
            end
        end
        if self.next.aura[guid] then
            for _, whoseTable in pairs(self.next.aura[guid]) do
                for _, aura in pairs(whoseTable) do
                    if self:isActiveAura(aura, atTime) then
                        if aura[propertyName] and aura.filter == filter then
                            count = count + 1
                            start = (aura.gain < start and aura.gain) or start
                            ending = (aura.ending > ending and aura.ending) or ending
                        end
                    end
                end
            end
        end
        if count > 0 then
            self.debug:log("Aura with '%s' property found on %s (count=%s, minStart=%s, maxEnding=%s).", propertyName, unitId, count, start, ending)
        else
            self.debug:log("Aura with '%s' property is missing on %s.", propertyName, unitId)
            return 
        end
        return start, ending
    end,
    auraCount = function(self, auraId, filter, mine, minStacks, atTime, excludeUnitId)
        self.profiler:startProfiling("OvaleAura_state_AuraCount")
        minStacks = minStacks or 1
        count = 0
        stacks = 0
        startChangeCount, endingChangeCount = huge, huge
        startFirst, endingLast = huge, 0
        local excludeGUID = (excludeUnitId and self.ovaleGuid:getUnitGUID(excludeUnitId)) or nil
        for guid, auraTable in pairs(self.current.aura) do
            if guid ~= excludeGUID and auraTable[auraId] then
                if mine and playerGUID then
                    local aura = self:getStateAura(guid, auraId, playerGUID, atTime)
                    if aura and self:isActiveAura(aura, atTime) and aura.filter == filter and aura.stacks >= minStacks and  not aura.state then
                        self:countMatchingActiveAura(aura)
                    end
                    for petGUID in pairs(petGUIDs) do
                        aura = self:getStateAura(guid, auraId, petGUID, atTime)
                        if aura and self:isActiveAura(aura, atTime) and aura.filter == filter and aura.stacks >= minStacks and  not aura.state then
                            self:countMatchingActiveAura(aura)
                        end
                    end
                else
                    for casterGUID in pairs(auraTable[auraId]) do
                        local aura = self:getStateAura(guid, auraId, casterGUID, atTime)
                        if aura and self:isActiveAura(aura, atTime) and aura.filter == filter and aura.stacks >= minStacks and  not aura.state then
                            self:countMatchingActiveAura(aura)
                        end
                    end
                end
            end
        end
        for guid, auraTable in pairs(self.next.aura) do
            if guid ~= excludeGUID and auraTable[auraId] then
                if mine then
                    local aura = auraTable[auraId][playerGUID]
                    if aura then
                        if self:isActiveAura(aura, atTime) and aura.filter == filter and aura.stacks >= minStacks then
                            self:countMatchingActiveAura(aura)
                        end
                    end
                    for petGUID in pairs(petGUIDs) do
                        aura = auraTable[auraId][petGUID]
                        if aura and self:isActiveAura(aura, atTime) and aura.filter == filter and aura.stacks >= minStacks and  not aura.state then
                            self:countMatchingActiveAura(aura)
                        end
                    end
                else
                    for _, aura in pairs(auraTable[auraId]) do
                        if aura and self:isActiveAura(aura, atTime) and aura.filter == filter and aura.stacks >= minStacks then
                            self:countMatchingActiveAura(aura)
                        end
                    end
                end
            end
        end
        self.debug:log("AuraCount(%d) is %s, %s, %s, %s, %s, %s", auraId, count, stacks, startChangeCount, endingChangeCount, startFirst, endingLast)
        self.profiler:stopProfiling("OvaleAura_state_AuraCount")
        return count, stacks, startChangeCount, endingChangeCount, startFirst, endingLast
    end,
    initializeState = function(self)
        self.next.aura = {}
        self.next.auraSerial = 0
        playerGUID = self.ovale.playerGUID
    end,
    resetState = function(self)
        self.profiler:startProfiling("OvaleAura_ResetState")
        self.next.auraSerial = self.next.auraSerial + 1
        if next(self.next.aura) then
            self.debug:log("Resetting aura state:")
        end
        for guid, auraTable in pairs(self.next.aura) do
            for auraId, whoseTable in pairs(auraTable) do
                for casterGUID, aura in pairs(whoseTable) do
                    pool:release(aura)
                    whoseTable[casterGUID] = nil
                    self.debug:log("    Aura %d on %s removed.", auraId, guid)
                end
                if  not next(whoseTable) then
                    pool:release(whoseTable)
                    auraTable[auraId] = nil
                end
            end
            if  not next(auraTable) then
                pool:release(auraTable)
                self.next.aura[guid] = nil
            end
        end
        self.profiler:stopProfiling("OvaleAura_ResetState")
    end,
    cleanState = function(self)
        for guid in pairs(self.next.aura) do
            __exports.removeAurasOnGUID(self.next.aura, guid)
        end
    end,
    applySpellAuras = function(self, spellId, guid, atTime, auraList, spellcast)
        self.profiler:startProfiling("OvaleAura_state_ApplySpellAuras")
        for filter, filterInfo in kpairs(auraList) do
            for auraIdKey, spellData in pairs(filterInfo) do
                local auraId = tonumber(auraIdKey)
                local duration = self:getBaseDuration(auraId, spellId, atTime, spellcast)
                local stacks = 1
                local count = nil
                local extend = 0
                local toggle = nil
                local refresh = false
                local keepSnapshot = false
                local data = self.ovaleData:checkSpellAuraData(auraId, spellData, atTime, guid)
                if data.refresh then
                    refresh = true
                elseif data.refresh_keep_snapshot then
                    refresh = true
                    keepSnapshot = true
                elseif data.toggle then
                    toggle = true
                elseif isNumber(data.set) then
                    count = data.set
                elseif isNumber(data.extend) then
                    extend = data.extend
                elseif isNumber(data.add) then
                    stacks = data.add
                else
                    self.debug:log("Aura has nothing defined")
                end
                if data.enabled == nil or data.enabled then
                    local si = self.ovaleData.spellInfo[auraId]
                    local auraFound = self:getAuraByGUID(guid, auraId, filter, true, atTime)
                    if auraFound and self:isActiveAura(auraFound, atTime) then
                        local aura
                        if auraFound.state then
                            aura = auraFound
                        else
                            aura = self:addAuraToGUID(guid, auraId, auraFound.source, filter, nil, 0, huge, atTime)
                            for k, v in kpairs(auraFound) do
                                (aura)[k] = v
                            end
                            aura.serial = self.next.auraSerial
                            self.debug:log("Aura %d is copied into simulator.", auraId)
                        end
                        if toggle then
                            self.debug:log("Aura %d is toggled off by spell %d.", auraId, spellId)
                            stacks = 0
                        end
                        if count and count > 0 then
                            stacks = count - aura.stacks
                        end
                        if refresh or extend > 0 or stacks > 0 then
                            if refresh then
                                self.debug:log("Aura %d is refreshed to %d stack(s).", auraId, aura.stacks)
                            elseif extend > 0 then
                                self.debug:log("Aura %d is extended by %f seconds, preserving %d stack(s).", auraId, extend, aura.stacks)
                            else
                                local maxStacks = 1
                                if si and si.max_stacks then
                                    maxStacks = si.max_stacks
                                end
                                aura.stacks = aura.stacks + stacks
                                if aura.stacks > maxStacks then
                                    aura.stacks = maxStacks
                                end
                                self.debug:log("Aura %d gains %d stack(s) to %d because of spell %d.", auraId, stacks, aura.stacks, spellId)
                            end
                            if extend > 0 then
                                aura.duration = aura.duration + extend
                                aura.ending = aura.ending + extend
                            else
                                aura.start = atTime
                                if aura.tick and aura.tick > 0 then
                                    local remainingDuration = aura.ending - atTime
                                    local extensionDuration = 0.3 * duration
                                    if remainingDuration < extensionDuration then
                                        aura.duration = remainingDuration + duration
                                    else
                                        aura.duration = extensionDuration + duration
                                    end
                                else
                                    aura.duration = duration
                                end
                                aura.ending = aura.start + aura.duration
                            end
                            aura.gain = atTime
                            self.debug:log("Aura %d with duration %s now ending at %s", auraId, aura.duration, aura.ending)
                            if keepSnapshot then
                                self.debug:log("Aura %d keeping previous snapshot.", auraId)
                            elseif spellcast then
                                self.lastSpell:copySpellcastInfo(spellcast, aura)
                            end
                        elseif stacks == 0 or stacks < 0 then
                            if stacks == 0 then
                                aura.stacks = 0
                            else
                                aura.stacks = aura.stacks + stacks
                                if aura.stacks < 0 then
                                    aura.stacks = 0
                                end
                                self.debug:log("Aura %d loses %d stack(s) to %d because of spell %d.", auraId, -1 * stacks, aura.stacks, spellId)
                            end
                            if aura.stacks == 0 then
                                self.debug:log("Aura %d is completely removed.", auraId)
                                aura.ending = atTime
                                aura.consumed = true
                            end
                        end
                    else
                        if toggle then
                            self.debug:log("Aura %d is toggled on by spell %d.", auraId, spellId)
                            stacks = 1
                        end
                        if  not refresh and stacks > 0 then
                            self.debug:log("New aura %d at %f on %s", auraId, atTime, guid)
                            local debuffType
                            if si then
                                for k, v in pairs(__exports.spellInfoDebuffTypes) do
                                    if si[k] == 1 then
                                        debuffType = v
                                        break
                                    end
                                end
                            end
                            local aura = self:addAuraToGUID(guid, auraId, playerGUID, filter, debuffType, 0, huge, atTime)
                            aura.stacks = stacks
                            aura.start = atTime
                            aura.duration = duration
                            if si and si.tick then
                                aura.baseTick = si.tick
                                aura.tick = self:getTickLength(auraId, spellcast)
                            end
                            aura.ending = aura.start + aura.duration
                            aura.gain = aura.start
                            if spellcast then
                                self.lastSpell:copySpellcastInfo(spellcast, aura)
                            end
                        end
                    end
                else
                    self.debug:log("Aura %d (%s) is not applied.", auraId, spellData)
                end
            end
        end
        self.profiler:stopProfiling("OvaleAura_state_ApplySpellAuras")
    end,
    addAuraToGUID = function(self, guid, auraId, casterGUID, filter, debuffType, start, ending, atTime, snapshot)
        local aura = pool:get()
        aura.state = true
        aura.serial = self.next.auraSerial
        aura.lastUpdated = atTime
        aura.filter = filter
        aura.start = start or 0
        aura.ending = ending or huge
        aura.duration = aura.ending - aura.start
        aura.gain = aura.start
        aura.stacks = 1
        aura.debuffType = (isString(debuffType) and lower(debuffType)) or debuffType
        self.ovalePaperDoll:updateSnapshot(aura, snapshot)
        __exports.putAura(self.next.aura, guid, auraId, casterGUID, aura)
        return aura
    end,
    removeAuraOnGUID = function(self, guid, auraId, filter, mine, atTime)
        local auraFound = self:getAuraByGUID(guid, auraId, filter, mine, atTime)
        if auraFound and self:isActiveAura(auraFound, atTime) then
            local aura
            if auraFound.state then
                aura = auraFound
            else
                aura = self:addAuraToGUID(guid, auraId, auraFound.source, filter, nil, 0, huge, atTime)
                for k, v in kpairs(auraFound) do
                    (aura)[k] = v
                end
                aura.serial = self.next.auraSerial
            end
            aura.stacks = 0
            aura.ending = atTime
            aura.lastUpdated = atTime
        end
    end,
    getBaseDuration = function(self, auraId, spellId, atTime, spellcast)
        spellcast = spellcast or self.ovalePaperDoll:getState(atTime)
        local duration = INFINITY
        local si = self.ovaleData.spellInfo[auraId]
        if si and si.duration then
            local value, ratio = self.ovaleData:getSpellInfoPropertyNumber(auraId, nil, "duration", nil, true) or 15, 1
            if si.add_duration_combopoints then
                local powerState = self.ovalePower:getState(atTime)
                local combopoints = spellcast.combopoints or powerState.power.combopoints or 0
                duration = (value + si.add_duration_combopoints * combopoints) * ratio
            else
                duration = value * ratio
            end
        end
        if si and si.half_duration and spellId then
            if self.ovaleData.buffSpellList[spellId] then
                for id in pairs(self.ovaleData.buffSpellList[spellId]) do
                    if id == si.half_duration then
                        duration = duration * 0.5
                        break
                    end
                end
            elseif spellId == si.half_duration then
                duration = duration * 0.5
            end
        end
        if si and si.haste and spellcast then
            local hasteMultiplier = self.ovalePaperDoll:getHasteMultiplier(si.haste, spellcast)
            duration = duration / hasteMultiplier
        end
        return duration
    end,
    getTickLength = function(self, auraId, snapshot)
        snapshot = snapshot or self.ovalePaperDoll.current
        local tick = 3
        local si = self.ovaleData.spellInfo[auraId]
        if si then
            tick = si.tick or tick
            local hasteMultiplier = self.ovalePaperDoll:getHasteMultiplier(si.haste, snapshot)
            tick = tick / hasteMultiplier
        end
        return tick
    end,
})
