local __exports = LibStub:NewLibrary("ovale/states/eclipse", 90107)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
__imports.__enginecondition = LibStub:GetLibrary("ovale/engine/condition")
__imports.returnBoolean = __imports.__enginecondition.returnBoolean
__imports.returnConstant = __imports.__enginecondition.returnConstant
__imports.__enginestate = LibStub:GetLibrary("ovale/engine/state")
__imports.States = __imports.__enginestate.States
local aceEvent = __imports.aceEvent
local infinity = math.huge
local concat = table.concat
local insert = table.insert
local GetSpellCount = GetSpellCount
local GetTime = GetTime
local UnitCastingInfo = UnitCastingInfo
local returnBoolean = __imports.returnBoolean
local returnConstant = __imports.returnConstant
local States = __imports.States
local EclipseData = __class(nil, {
    constructor = function(self)
        self.starfire = 0
        self.starfireMax = 0
        self.wrath = 0
        self.wrathMax = 0
    end
})
local balanceSpellId = {
    starfire = 194153,
    wrath = 190984
}
local balanceAffinitySpellId = {
    talent = 22163,
    starfire = 197628,
    wrath = 5176
}
local celestialAlignmentId = 194223
local incarnationId = 102560
local eclipseLunarId = 48518
local eclipseSolarId = 48517
local leafOnTheWaterId = 334604
__exports.Eclipse = __class(States, {
    constructor = function(self, ovale, debug, aura, combat, paperDoll, spellBook)
        self.ovale = ovale
        self.aura = aura
        self.combat = combat
        self.paperDoll = paperDoll
        self.spellBook = spellBook
        self.hasEclipseHandlers = false
        self.isCasting = false
        self.adjustCount = false
        self.starfireId = 0
        self.wrathId = 0
        self.debugEclipse = {
            type = "group",
            name = "Eclipse",
            args = {
                eclipse = {
                    type = "input",
                    name = "Eclipse",
                    multiline = 25,
                    width = "full",
                    get = function()
                        local output = {}
                        insert(output, "Starfire spell ID: " .. self.starfireId)
                        insert(output, "Wrath spell ID: " .. self.wrathId)
                        insert(output, "")
                        insert(output, "Total Starfire(s) to Solar Eclipse: " .. self.current.starfireMax)
                        insert(output, "Total Wrath(s) to Lunar Eclipse: " .. self.current.starfireMax)
                        insert(output, "")
                        insert(output, "Starfire(s) to Solar Eclipse: " .. self.current.starfire)
                        insert(output, "Wrath(s) to Lunar Eclipse: " .. self.current.wrath)
                        return concat(output, "\n")
                    end
                }
            }
        }
        self.onEnable = function()
            if self.ovale.playerClass == "DRUID" then
                self.module:RegisterEvent("PLAYER_ENTERING_WORLD", self.onUpdateEclipseHandlers)
                self.module:RegisterMessage("Ovale_SpecializationChanged", self.onUpdateEclipseHandlers)
                self.module:RegisterMessage("Ovale_TalentsChanged", self.onUpdateEclipseHandlers)
                self.onUpdateEclipseHandlers("onEnable")
            end
        end
        self.onDisable = function()
            if self.ovale.playerClass == "DRUID" then
                self.module:UnregisterEvent("PLAYER_ENTERING_WORLD")
                self.module:UnregisterMessage("Ovale_SpecializationChanged")
                self.module:UnregisterMessage("Ovale_TalentsChanged")
                self.unregisterEclipseHandlers()
            end
        end
        self.onUpdateEclipseHandlers = function(event)
            local isBalanceDruid = self.paperDoll:isSpecialization("balance")
            local hasBalanceAffinity = self.spellBook:getTalentPoints(balanceAffinitySpellId.talent) > 0
            if isBalanceDruid or hasBalanceAffinity then
                if isBalanceDruid then
                    self.starfireId = balanceSpellId.starfire
                    self.wrathId = balanceSpellId.wrath
                elseif hasBalanceAffinity then
                    self.starfireId = balanceAffinitySpellId.starfire
                    self.wrathId = balanceAffinitySpellId.wrath
                else
                    self.starfireId = 0
                    self.wrathId = 0
                end
                self.registerEclipseHandlers()
                self.updateSpellMaxCounts(event)
                self.updateSpellCounts(event)
            else
                self.unregisterEclipseHandlers()
            end
        end
        self.registerEclipseHandlers = function()
            if  not self.hasEclipseHandlers then
                self.tracer:debug("Installing eclipse event handlers.")
                self.module:RegisterEvent("UNIT_SPELLCAST_FAILED", self.onUnitSpellCastStop)
                self.module:RegisterEvent("UNIT_SPELLCAST_FAILED_QUIET", self.onUnitSpellCastStop)
                self.module:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED", self.onUnitSpellCastStop)
                self.module:RegisterEvent("UNIT_SPELLCAST_START", self.onUnitSpellCastStart)
                self.module:RegisterEvent("UNIT_SPELLCAST_STOP", self.onUnitSpellCastStop)
                self.module:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", self.onUnitSpellCastSucceeded)
                self.module:RegisterEvent("UPDATE_SHAPESHIFT_COOLDOWN", self.onUpdateShapeshiftCooldown)
                self.module:RegisterMessage("Ovale_AuraAdded", self.onOvaleAuraAddedOrRemoved)
                self.module:RegisterMessage("Ovale_AuraRemoved", self.onOvaleAuraAddedOrRemoved)
                self.hasEclipseHandlers = true
            end
        end
        self.unregisterEclipseHandlers = function()
            if self.hasEclipseHandlers then
                self.tracer:debug("Removing eclipse event handlers.")
                self.module:UnregisterEvent("UNIT_SPELLCAST_FAILED")
                self.module:UnregisterEvent("UNIT_SPELLCAST_FAILED_QUIET")
                self.module:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED")
                self.module:UnregisterEvent("UNIT_SPELLCAST_START")
                self.module:UnregisterEvent("UNIT_SPELLCAST_STOP")
                self.module:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
                self.module:UnregisterEvent("UPDATE_SHAPESHIFT_COOLDOWN")
                self.module:UnregisterMessage("Ovale_AuraAdded")
                self.module:UnregisterMessage("Ovale_AuraRemoved")
                self.hasEclipseHandlers = false
            end
        end
        self.onUnitSpellCastStart = function(event, unit, castGUID, spellId)
            if unit == "player" and (spellId == self.starfireId or spellId == self.wrathId) then
                local name, _, _, _, _, _, _, _, castSpellId = UnitCastingInfo(unit)
                if name and spellId == castSpellId then
                    self.isCasting = true
                end
            end
        end
        self.onUnitSpellCastStop = function(event, unit, castGUID, spellId)
            if unit == "player" and (spellId == self.starfireId or spellId == self.wrathId) then
                self.isCasting = false
                self.adjustCount = false
            end
        end
        self.onUnitSpellCastSucceeded = function(event, unit, castGUID, spellId)
            local current = self.current
            if unit == "player" and (spellId == celestialAlignmentId or spellId == incarnationId or spellId == self.starfireId or spellId == self.wrathId) then
                self.tracer:debug(event .. ": " .. spellId)
                self.isCasting = false
                self.updateSpellCounts(event)
                if self.adjustCount then
                    if spellId == self.starfireId and current.starfire > 0 then
                        current.starfire = current.starfire - 1
                        self.tracer:debug("%s: adjust starfire: %d", event, current.starfire)
                    elseif spellId == self.wrathId and current.wrath > 0 then
                        current.wrath = current.wrath - 1
                        self.tracer:debug("%s: adjust wrath: %d", event, current.wrath)
                    end
                    self.adjustCount = false
                end
            end
        end
        self.onUpdateShapeshiftCooldown = function(event)
            if  not self.combat:isInCombat(nil) then
                self.updateSpellCounts(event)
            end
        end
        self.onOvaleAuraAddedOrRemoved = function(event, atTime, guid, auraId, caster)
            if guid == self.ovale.playerGUID then
                if auraId == leafOnTheWaterId then
                    self.updateSpellMaxCounts(event, atTime)
                elseif auraId == eclipseLunarId or auraId == eclipseSolarId then
                    if event == "Ovale_AuraRemoved" and self.isCasting then
                        self.adjustCount = true
                    end
                    self.updateSpellCounts(event)
                end
            end
        end
        self.updateSpellMaxCounts = function(event, atTime)
            atTime = atTime or GetTime()
            local aura = self.aura:getAura("player", leafOnTheWaterId, atTime, "HELPFUL")
            local starfireMax = 2
            local wrathMax = 2
            if aura then
                starfireMax = 1
                wrathMax = 1
            end
            local current = self.current
            if current.starfireMax ~= starfireMax or current.wrathMax ~= wrathMax then
                current.starfireMax = starfireMax
                current.wrathMax = wrathMax
                self.tracer:debug("%s: starfireMax: %d, wrathMax: %d", event, starfireMax, wrathMax)
                self.ovale:needRefresh()
            end
        end
        self.updateSpellCounts = function(event)
            local current = self.current
            local starfire = GetSpellCount(self.starfireId)
            local wrath = GetSpellCount(self.wrathId)
            if current.starfire ~= starfire or current.wrath ~= wrath then
                current.starfire = starfire
                current.wrath = wrath
                self.tracer:debug("%s: starfire: %d, wrath: %d", event, starfire, wrath)
                self.ovale:needRefresh()
            end
        end
        self.applySpellAfterCast = function(spellId, targetGUID, startCast, endCast, channel, spellcast)
            if  not self.hasEclipseHandlers then
                return 
            end
            local state = self.next
            local prevStarfire = state.starfire
            local prevWrath = state.wrath
            local starfire = prevStarfire
            local wrath = prevWrath
            if spellId == celestialAlignmentId then
                starfire = 0
                wrath = 0
                self.tracer:log("Spell ID '%d' Celestial Alignment resets counts to 0.", spellId)
                local duration = self.aura:getBaseDuration(celestialAlignmentId, nil, endCast) or 20
                self.triggerEclipse(endCast, "lunar", duration)
                self.triggerEclipse(endCast, "solar", duration)
            elseif spellId == incarnationId then
                starfire = 0
                wrath = 0
                self.tracer:log("Spell ID '%d' Incarnation: Chosen of Elune resets counts to 0.", spellId)
                local duration = self.aura:getBaseDuration(incarnationId, nil, endCast) or 30
                self.triggerEclipse(endCast, "lunar", duration)
                self.triggerEclipse(endCast, "solar", duration)
            else
                if spellId == self.starfireId and prevStarfire > 0 then
                    starfire = prevStarfire - 1
                    self.tracer:log("Spell ID '%d' Starfire decrements count to %d.", spellId, starfire)
                elseif spellId == self.wrathId and prevWrath > 0 then
                    wrath = prevWrath - 1
                    self.tracer:log("Spell ID '%d' Wrath decrements count to %d.", spellId, wrath)
                end
                if prevStarfire > 0 and starfire == 0 then
                    local duration = self.aura:getBaseDuration(eclipseSolarId, nil, endCast) or 15
                    self.triggerEclipse(endCast, "solar", duration)
                    wrath = 0
                end
                if prevWrath > 0 and wrath == 0 then
                    local duration = self.aura:getBaseDuration(eclipseLunarId, nil, endCast) or 15
                    self.triggerEclipse(endCast, "lunar", duration)
                    starfire = 0
                end
            end
            state.starfire = starfire
            state.wrath = wrath
        end
        self.triggerEclipse = function(atTime, eclipseType, duration)
            if eclipseType == "lunar" or eclipseType == "solar" then
                self.tracer:log("Triggering %s eclipse.", eclipseType)
                local auraId = (eclipseType == "lunar" and eclipseLunarId) or eclipseSolarId
                self.aura:addAuraToGUID(self.ovale.playerGUID, auraId, self.ovale.playerGUID, "HELPFUL", nil, atTime, atTime + duration, atTime)
            end
        end
        self.getEclipseAuras = function(atTime)
            local lunar = self.aura:getAura("player", eclipseLunarId, atTime, "HELPFUL")
            local solar = self.aura:getAura("player", eclipseSolarId, atTime, "HELPFUL")
            return lunar, solar
        end
        self.getSpellCounts = function(atTime)
            local state = self.next
            local starfire = state.starfire
            local wrath = state.wrath
            if starfire == 0 and wrath == 0 then
                local lunar, solar = self.getEclipseAuras(atTime)
                local inLunar = (lunar and self.aura:isActiveAura(lunar, atTime)) or false
                local inSolar = (solar and self.aura:isActiveAura(solar, atTime)) or false
                if  not inLunar and  not inSolar then
                    local lunarEnding = (lunar and lunar.ending) or 0
                    local solarEnding = (solar and solar.ending) or 0
                    if self.aura:isWithinAuraLag(lunarEnding, solarEnding) then
                        starfire = state.starfireMax
                        wrath = state.wrathMax
                    elseif lunarEnding < solarEnding then
                        wrath = state.wrathMax
                    elseif lunarEnding > solarEnding then
                        starfire = state.starfireMax
                    end
                end
            end
            self.tracer:log("Spell counts at time = %f: starfire = %d, wrath = %d", atTime, starfire, wrath)
            return starfire, wrath
        end
        self.getEclipse = function(atTime)
            local eclipse = "any_next"
            local starfire, wrath = self.getSpellCounts(atTime)
            if starfire > 0 and wrath > 0 then
                eclipse = "any_next"
            elseif starfire > 0 and wrath == 0 then
                eclipse = "solar_next"
            elseif starfire == 0 and wrath > 0 then
                eclipse = "lunar_next"
            else
                local lunar, solar = self.getEclipseAuras(atTime)
                local inLunar = (lunar and self.aura:isActiveAura(lunar, atTime)) or false
                local inSolar = (solar and self.aura:isActiveAura(solar, atTime)) or false
                if inLunar and inSolar then
                    eclipse = "in_both"
                elseif inLunar then
                    eclipse = "in_lunar"
                elseif inSolar then
                    eclipse = "in_solar"
                end
            end
            return eclipse
        end
        self.isNextEclipseAny = function(positionalParameters, namedParameters, atTime)
            local eclipse = self.getEclipse(atTime)
            local value = eclipse == "any_next"
            return returnBoolean(value)
        end
        self.isNextEclipseLunar = function(positionalParameters, namedParameters, atTime)
            local eclipse = self.getEclipse(atTime)
            local value = eclipse == "lunar_next"
            return returnBoolean(value)
        end
        self.isNextEclipseSolar = function(positionalParameters, namedParameters, atTime)
            local eclipse = self.getEclipse(atTime)
            local value = eclipse == "solar_next"
            return returnBoolean(value)
        end
        self.enterEclipseLunarIn = function(positionalParameters, namedParameters, atTime)
            local _, wrath = self.getSpellCounts(atTime)
            if wrath > 0 then
                return returnConstant(wrath)
            end
            return returnConstant(infinity)
        end
        self.enterEclipseSolarIn = function(positionalParameters, namedParameters, atTime)
            local starfire = self.getSpellCounts(atTime)
            if starfire > 0 then
                return returnConstant(starfire)
            end
            return returnConstant(infinity)
        end
        States.constructor(self, EclipseData)
        self.module = ovale:createModule("Eclipse", self.onEnable, self.onDisable, aceEvent)
        self.tracer = debug:create(self.module:GetName())
        debug.defaultOptions.args["eclipse"] = self.debugEclipse
    end,
    initializeState = function(self)
    end,
    resetState = function(self)
        if self.hasEclipseHandlers then
            local current = self.current
            local state = self.next
            state.starfire = current.starfire or 0
            state.starfireMax = current.starfireMax
            state.wrath = current.wrath or 0
            state.wrathMax = current.wrathMax
        end
    end,
    cleanState = function(self)
    end,
    registerConditions = function(self, condition)
        condition:registerCondition("eclipseanynext", false, self.isNextEclipseAny)
        condition:registerCondition("eclipselunarin", false, self.enterEclipseLunarIn)
        condition:registerCondition("eclipselunarnext", false, self.isNextEclipseLunar)
        condition:registerCondition("eclipsesolarin", false, self.enterEclipseSolarIn)
        condition:registerCondition("eclipsesolarnext", false, self.isNextEclipseSolar)
    end,
})
