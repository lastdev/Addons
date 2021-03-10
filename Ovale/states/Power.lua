local __exports = LibStub:NewLibrary("ovale/states/Power", 90047)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __uiLocalization = LibStub:GetLibrary("ovale/ui/Localization")
local l = __uiLocalization.l
local aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local ceil = math.ceil
local INFINITY = math.huge
local floor = math.floor
local pairs = pairs
local kpairs = pairs
local lower = string.lower
local concat = table.concat
local insert = table.insert
local GetPowerRegen = GetPowerRegen
local GetManaRegen = GetManaRegen
local GetSpellPowerCost = GetSpellPowerCost
local UnitPower = UnitPower
local UnitPowerMax = UnitPowerMax
local UnitPowerType = UnitPowerType
local Enum = Enum
local MAX_COMBO_POINTS = MAX_COMBO_POINTS
local __toolstools = LibStub:GetLibrary("ovale/tools/tools")
local isNumber = __toolstools.isNumber
local oneTimeMessage = __toolstools.oneTimeMessage
local __enginestate = LibStub:GetLibrary("ovale/engine/state")
local States = __enginestate.States
local strlower = lower
local spellcastInfoPowerTypes = {
    [1] = "chi",
    [2] = "holypower"
}
local PowerState = __class(nil, {
    constructor = function(self)
        self.powerType = "mana"
        self.activeRegen = {}
        self.inactiveRegen = {}
        self.maxPower = {}
        self.power = {}
    end
})
local powers = {
    mana = true,
    rage = true,
    focus = true,
    energy = true,
    combopoints = true,
    runicpower = true,
    soulshards = true,
    lunarpower = true,
    holypower = true,
    alternate = true,
    maelstrom = true,
    chi = true,
    insanity = true,
    arcanecharges = true,
    pain = true,
    fury = true
}
__exports.powerTypes = {}
__exports.pooledResources = {
    ["DRUID"] = "energy",
    ["HUNTER"] = "focus",
    ["MONK"] = "energy",
    ["ROGUE"] = "energy"
}
__exports.primaryPowers = {
    energy = true,
    focus = true,
    mana = true
}
__exports.OvalePowerClass = __class(States, {
    constructor = function(self, ovaleDebug, ovale, ovaleProfiler, ovaleData, baseState, ovaleSpellBook, combat)
        self.ovale = ovale
        self.ovaleData = ovaleData
        self.baseState = baseState
        self.ovaleSpellBook = ovaleSpellBook
        self.combat = combat
        self.powerInfos = {}
        self.powerTypes = {}
        self.handleInitialize = function()
            self.module:RegisterEvent("PLAYER_ENTERING_WORLD", self.handleEventHandler)
            self.module:RegisterEvent("PLAYER_LEVEL_UP", self.handleEventHandler)
            self.module:RegisterEvent("UNIT_DISPLAYPOWER", self.handleUnitDisplayPower)
            self.module:RegisterEvent("UNIT_LEVEL", self.handleUnitLevel)
            self.module:RegisterEvent("UNIT_MAXPOWER", self.handleUnitMaxPower)
            self.module:RegisterEvent("UNIT_POWER_UPDATE", self.handleUnitPowerUpdate)
            self.module:RegisterEvent("UNIT_POWER_FREQUENT", self.handleUnitPowerUpdate)
            self.module:RegisterEvent("UNIT_RANGEDDAMAGE", self.handleUnitRangedDamage)
            self.module:RegisterEvent("UNIT_SPELL_HASTE", self.handleUnitRangedDamage)
            self.module:RegisterMessage("Ovale_StanceChanged", self.handleEventHandler)
            self.module:RegisterMessage("Ovale_TalentsChanged", self.handleEventHandler)
            self:initializePower()
        end
        self.handleDisable = function()
            self.module:UnregisterEvent("PLAYER_ENTERING_WORLD")
            self.module:UnregisterEvent("PLAYER_LEVEL_UP")
            self.module:UnregisterEvent("UNIT_DISPLAYPOWER")
            self.module:UnregisterEvent("UNIT_LEVEL")
            self.module:UnregisterEvent("UNIT_MAXPOWER")
            self.module:UnregisterEvent("UNIT_POWER_UPDATE")
            self.module:UnregisterEvent("UNIT_POWER_FREQUENT")
            self.module:UnregisterEvent("UNIT_RANGEDDAMAGE")
            self.module:UnregisterEvent("UNIT_SPELL_HASTE")
            self.module:UnregisterMessage("Ovale_StanceChanged")
            self.module:UnregisterMessage("Ovale_TalentsChanged")
        end
        self.handleEventHandler = function(event)
            self:updatePowerType(event)
            self:updateMaxPower(event)
            self:updatePower(event)
            self:updatePowerRegen(event)
        end
        self.handleUnitDisplayPower = function(event, unitId)
            if unitId == "player" then
                self:updatePowerType(event)
                self:updatePowerRegen(event)
            end
        end
        self.handleUnitLevel = function(event, unitId)
            if unitId == "player" then
                self.handleEventHandler(event)
            end
        end
        self.handleUnitMaxPower = function(event, unitId, powerToken)
            if unitId == "player" then
                local powerType = self.powerTypes[powerToken]
                if powerType then
                    self:updateMaxPower(event, powerType)
                end
            end
        end
        self.handleUnitPowerUpdate = function(event, unitId, powerToken)
            if unitId == "player" then
                local powerType = self.powerTypes[powerToken]
                if powerType then
                    self:updatePower(event, powerType)
                end
            end
        end
        self.handleUnitRangedDamage = function(event, unitId)
            if unitId == "player" then
                self:updatePowerRegen(event)
            end
        end
        self.copySpellcastInfo = function(mod, spellcast, dest)
            for _, powerType in pairs(spellcastInfoPowerTypes) do
                if spellcast[powerType] then
                    dest[powerType] = spellcast[powerType]
                end
            end
        end
        self.applySpellStartCast = function(spellId, targetGUID, startCast, endCast, isChanneled, spellcast)
            self.profiler:startProfiling("OvalePower_ApplySpellStartCast")
            if isChanneled then
                self:applyPowerCost(spellId, targetGUID, startCast, spellcast)
            end
            self.profiler:stopProfiling("OvalePower_ApplySpellStartCast")
        end
        self.applySpellAfterCast = function(spellId, targetGUID, startCast, endCast, isChanneled, spellcast)
            self.profiler:startProfiling("OvalePower_ApplySpellAfterCast")
            if  not isChanneled then
                self:applyPowerCost(spellId, targetGUID, endCast, spellcast)
            end
            self.profiler:stopProfiling("OvalePower_ApplySpellAfterCast")
        end
        States.constructor(self, PowerState)
        self.module = ovale:createModule("OvalePower", self.handleInitialize, self.handleDisable, aceEvent)
        self.tracer = ovaleDebug:create(self.module:GetName())
        self.profiler = ovaleProfiler:create(self.module:GetName())
        local debugOptions = {
            power = {
                name = l["power"],
                type = "group",
                args = {
                    power = {
                        name = l["power"],
                        type = "input",
                        multiline = 25,
                        width = "full",
                        get = function(info)
                            return self:debugPower()
                        end
                    }
                }
            }
        }
        for k, v in pairs(debugOptions) do
            ovaleDebug.defaultOptions.args[k] = v
        end
    end,
    initializePower = function(self)
        local possiblePowerTypes = {
            DEATHKNIGHT = {
                runicpower = "RUNIC_POWER"
            },
            DEMONHUNTER = {
                pain = "PAIN",
                fury = "FURY"
            },
            DRUID = {
                mana = "MANA",
                rage = "RAGE",
                energy = "ENERGY",
                combopoints = "COMBO_POINTS",
                lunarpower = "LUNAR_POWER"
            },
            HUNTER = {
                focus = "FOCUS"
            },
            MAGE = {
                mana = "MANA",
                arcanecharges = "ARCANE_CHARGES"
            },
            MONK = {
                mana = "MANA",
                energy = "ENERGY",
                chi = "CHI"
            },
            PALADIN = {
                mana = "MANA",
                holypower = "HOLY_POWER"
            },
            PRIEST = {
                mana = "MANA",
                insanity = "INSANITY"
            },
            ROGUE = {
                energy = "ENERGY",
                combopoints = "COMBO_POINTS"
            },
            SHAMAN = {
                mana = "MANA",
                maelstrom = "MAELSTROM"
            },
            WARLOCK = {
                mana = "MANA",
                soulshards = "SOUL_SHARDS"
            },
            WARRIOR = {
                rage = "RAGE"
            }
        }
        for powerType, powerId in pairs(Enum.PowerType) do
            local powerTypeLower = strlower(powerType)
            local powerToken = self.ovale.playerClass ~= nil and possiblePowerTypes[self.ovale.playerClass][powerTypeLower]
            if powerToken then
                self.powerTypes[powerId] = powerTypeLower
                self.powerTypes[powerToken] = powerTypeLower
                self.powerInfos[powerTypeLower] = {
                    id = powerId,
                    token = powerToken,
                    mini = 0,
                    type = powerTypeLower,
                    maxCost = (powerTypeLower == "combopoints" and MAX_COMBO_POINTS) or 0
                }
                insert(__exports.powerTypes, powerTypeLower)
            end
        end
    end,
    updateMaxPower = function(self, event, powerType)
        self.profiler:startProfiling("OvalePower_UpdateMaxPower")
        if powerType then
            local powerInfo = self.powerInfos[powerType]
            if powerInfo then
                local maxPower = UnitPowerMax("player", powerInfo.id, powerInfo.segments)
                if self.current.maxPower[powerType] ~= maxPower then
                    self.current.maxPower[powerType] = maxPower
                    self.ovale:needRefresh()
                end
            end
        else
            for powerType, powerInfo in pairs(self.powerInfos) do
                local maxPower = UnitPowerMax("player", powerInfo.id, powerInfo.segments)
                if self.current.maxPower[powerType] ~= maxPower then
                    self.current.maxPower[powerType] = maxPower
                    self.ovale:needRefresh()
                end
            end
        end
        self.profiler:stopProfiling("OvalePower_UpdateMaxPower")
    end,
    updatePower = function(self, event, powerType)
        self.profiler:startProfiling("OvalePower_UpdatePower")
        if powerType then
            local powerInfo = self.powerInfos[powerType]
            if powerInfo then
                local power = UnitPower("player", powerInfo.id, powerInfo.segments)
                self.tracer:debugTimestamp("%s: %d -> %d (%s).", event, self.current.power[powerType], power, powerType)
                if self.current.power[powerType] ~= power then
                    self.current.power[powerType] = power
                end
            end
        else
            for powerType, powerInfo in kpairs(self.powerInfos) do
                local power = UnitPower("player", powerInfo.id, powerInfo.segments)
                self.tracer:debugTimestamp("%s: %d -> %d (%s).", event, self.current.power[powerType], power, powerType)
                if self.current.power[powerType] ~= power then
                    self.current.power[powerType] = power
                end
            end
        end
        if event == "UNIT_POWER_UPDATE" then
            self.ovale:needRefresh()
        end
        self.profiler:stopProfiling("OvalePower_UpdatePower")
    end,
    updatePowerRegen = function(self, event)
        self.profiler:startProfiling("OvalePower_UpdatePowerRegen")
        for powerType in pairs(self.powerInfos) do
            local currentType = self.current.powerType
            if powerType == currentType then
                local inactiveRegen, activeRegen = GetPowerRegen()
                self.current.inactiveRegen[powerType], self.current.activeRegen[powerType] = inactiveRegen, activeRegen
                self.ovale:needRefresh()
            elseif powerType == "mana" then
                local inactiveRegen, activeRegen = GetManaRegen()
                self.current.inactiveRegen[powerType], self.current.activeRegen[powerType] = inactiveRegen, activeRegen
                self.ovale:needRefresh()
            elseif self.current.activeRegen[powerType] == nil then
                local inactiveRegen, activeRegen = 0, 0
                if powerType == "energy" then
                    inactiveRegen, activeRegen = 10, 10
                end
                self.current.inactiveRegen[powerType], self.current.activeRegen[powerType] = inactiveRegen, activeRegen
                self.ovale:needRefresh()
            end
        end
        self.profiler:stopProfiling("OvalePower_UpdatePowerRegen")
    end,
    updatePowerType = function(self, event)
        self.profiler:startProfiling("OvalePower_UpdatePowerType")
        local powerId = UnitPowerType("player")
        local powerType = self.powerTypes[powerId]
        if self.current.powerType ~= powerType then
            self.current.powerType = powerType
            self.ovale:needRefresh()
        end
        self.profiler:stopProfiling("OvalePower_UpdatePowerType")
    end,
    getSpellCost = function(self, spell, powerType)
        local spellId = self.ovaleSpellBook:getKnownSpellId(spell)
        if spellId then
            local spellPowerCosts = GetSpellPowerCost(spellId)
            local spellPowerCost = spellPowerCosts and spellPowerCosts[1]
            if spellPowerCost then
                local cost = spellPowerCost.cost
                local typeId = spellPowerCost.type
                for pt, p in pairs(self.powerInfos) do
                    if p.id == typeId and (powerType == nil or pt == powerType) then
                        return cost, p.type
                    end
                end
            end
        else
            oneTimeMessage("No spell cost for " .. spell)
        end
        return nil, nil
    end,
    debugPower = function(self)
        local array = {}
        insert(array, "Current Power Type: " .. self.current.powerType)
        for powerType, v in pairs(self.current.power) do
            insert(array, "\nPower Type: " .. powerType)
            insert(array, "Power: " .. v .. " / " .. self.current.maxPower[powerType])
            insert(array, "Active Regen: / " .. self.current.activeRegen[powerType])
            insert(array, "Inactive Regen: / " .. self.current.inactiveRegen[powerType])
        end
        return concat(array, "\n")
    end,
    initializeState = function(self)
        for powerType in kpairs(self.powerInfos) do
            self.next.power[powerType] = 0
            self.next.inactiveRegen[powerType], self.next.activeRegen[powerType] = 0, 0
        end
    end,
    resetState = function(self)
        self.profiler:startProfiling("OvalePower_ResetState")
        for powerType in kpairs(self.powerInfos) do
            self.next.power[powerType] = self.current.power[powerType] or 0
            self.next.maxPower[powerType] = self.current.maxPower[powerType] or 0
            self.next.activeRegen[powerType] = self.current.activeRegen[powerType] or 0
            self.next.inactiveRegen[powerType] = self.current.inactiveRegen[powerType] or 0
        end
        self.profiler:stopProfiling("OvalePower_ResetState")
    end,
    cleanState = function(self)
        for powerType in kpairs(self.powerInfos) do
            self.next.power[powerType] = nil
        end
    end,
    applyPowerCost = function(self, spellId, targetGUID, atTime, spellcast)
        self.profiler:startProfiling("OvalePower_state_ApplyPowerCost")
        local si = self.ovaleData.spellInfo[spellId]
        do
            local cost, powerType = self:getSpellCost(spellId)
            if cost and powerType and self.next.power[powerType] and  not (si and si[powerType]) then
                local power = self.next.power[powerType]
                if power then
                    self.next.power[powerType] = power - cost
                end
            end
        end
        if si then
            for powerType, powerInfo in kpairs(self.powerInfos) do
                local cost, refund = self:getPowerCostAt(self.next, spellId, powerInfo.type, atTime, targetGUID)
                local power = self:getPowerAt(self.next, powerType, atTime)
                local mini = powerInfo.mini or 0
                if power - cost < mini then
                    cost = power
                end
                power = (self.next.power[powerType] or 0) + refund - cost
                local maxi = self.current.maxPower[powerType]
                if maxi ~= nil and power > maxi then
                    power = maxi
                end
                self.next.power[powerType] = power
            end
        end
        self.profiler:stopProfiling("OvalePower_state_ApplyPowerCost")
    end,
    powerCost = function(self, spellId, powerType, atTime, targetGUID, maximumCost)
        return self:getPowerCostAt(self:getState(atTime), spellId, powerType, atTime, targetGUID, maximumCost)
    end,
    getPowerRateAt = function(self, state, powerType, atTime)
        local rate
        if self.combat:isInCombat(atTime) then
            rate = state.activeRegen[powerType] or 0
        else
            rate = state.inactiveRegen[powerType] or 0
        end
        local regenRateMinThreshold = 0.05
        if (rate > 0 and rate < regenRateMinThreshold) or (rate < 0 and rate > -1 * regenRateMinThreshold) then
            rate = 0
        end
        return rate
    end,
    getPowerAt = function(self, state, powerType, atTime)
        local power = state.power[powerType] or 0
        local now = self.baseState.currentTime
        local seconds = atTime - now
        local powerRate = self:getPowerRateAt(state, powerType, atTime)
        power = power + powerRate * seconds
        return power
    end,
    getTimeToPowerAt = function(self, state, powerLevel, powerType, atTime)
        local power = self:getPowerAt(state, powerType, atTime)
        if power < powerLevel then
            local seconds = INFINITY
            local powerRate = self:getPowerRateAt(state, powerType, atTime)
            if powerRate > 0 then
                seconds = (powerLevel - power) / powerRate
            end
            return seconds
        end
        return 0
    end,
    getPowerCostAt = function(self, state, spellId, powerType, atTime, targetGUID, maximumCost)
        self.profiler:startProfiling("OvalePower_PowerCost")
        local spellCost = 0
        local spellRefund = 0
        local si = self.ovaleData.spellInfo[spellId]
        if si and si[powerType] then
            local cost, ratio = self.ovaleData:getSpellInfoPropertyNumber(spellId, atTime, powerType, targetGUID, true)
            local setPowerValue = self.ovaleData:getProperty(si, atTime, "set_" .. powerType)
            if isNumber(setPowerValue) then
                local power = self:getPowerAt(state, powerType, atTime)
                spellCost = power - setPowerValue
                if spellCost < cost then
                    spellCost = cost
                end
            else
                local maxCost = self.ovaleData:getProperty(si, atTime, "max_" .. powerType)
                if isNumber(maxCost) then
                    local power = self:getPowerAt(state, powerType, atTime)
                    if power > maxCost or maximumCost then
                        if cost < maxCost then
                            cost = maxCost
                        end
                    elseif power > cost then
                        cost = power
                    end
                end
                if ratio and ratio ~= 0 then
                    if cost > 0 then
                        spellCost = floor(cost * ratio)
                    else
                        spellCost = ceil(cost * ratio)
                    end
                end
            end
            local refund = self.ovaleData:getProperty(si, atTime, "refund_" .. powerType)
            if refund == "cost" then
                spellRefund = spellCost
            elseif isNumber(refund) then
                spellRefund = refund
            end
        else
            local cost = self:getSpellCost(spellId, powerType)
            if cost then
                spellCost = cost
            end
        end
        self.profiler:stopProfiling("OvalePower_PowerCost")
        return spellCost, spellRefund
    end,
})
