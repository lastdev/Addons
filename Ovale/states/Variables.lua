local __exports = LibStub:NewLibrary("ovale/states/Variables", 90048)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local pairs = pairs
local wipe = wipe
local __enginecondition = LibStub:GetLibrary("ovale/engine/condition")
local returnConstant = __enginecondition.returnConstant
local huge = math.huge
local __engineast = LibStub:GetLibrary("ovale/engine/ast")
local setResultType = __engineast.setResultType
__exports.Variables = __class(nil, {
    constructor = function(self, combat, baseState, ovaleDebug)
        self.combat = combat
        self.baseState = baseState
        self.isState = true
        self.isInitialized = false
        self.futureVariable = {}
        self.futureLastEnable = {}
        self.variable = {}
        self.lastEnable = {}
        self.getState = function(positionalParams, namedParams, atTime)
            local name = positionalParams[1]
            local value = self:getStateValue(name)
            return returnConstant(value)
        end
        self.getStateDuration = function(positionalParams, namedParams, atTime)
            local name = positionalParams[1]
            local value = self:getStateDurationAtTime(name, atTime)
            return returnConstant(value)
        end
        self.setState = function(positionalParams, namedParams, atTime, result)
            local name = positionalParams[1]
            local value = positionalParams[2]
            local currentValue = self:getStateValue(name)
            if currentValue ~= value then
                setResultType(result, "state")
                result.value = value
                result.name = name
                result.timeSpan:copy(0, huge)
            else
                wipe(result.timeSpan)
            end
        end
        self.tracer = ovaleDebug:create("Variables")
    end,
    registerConditions = function(self, condition)
        condition:registerCondition("getstate", false, self.getState)
        condition:registerAction("setstate", self.setState)
        condition:registerCondition("getstateduration", false, self.getStateDuration)
    end,
    initializeState = function(self)
        if  not self.combat:isInCombat(nil) then
            for k in pairs(self.variable) do
                self.tracer:log("Resetting state variable '%s'.", k)
                self.variable[k] = nil
                self.lastEnable[k] = nil
            end
        end
    end,
    resetState = function(self)
        for k in pairs(self.futureVariable) do
            self.futureVariable[k] = nil
            self.futureLastEnable[k] = nil
        end
    end,
    cleanState = function(self)
        for k in pairs(self.futureVariable) do
            self.futureVariable[k] = nil
        end
        for k in pairs(self.futureLastEnable) do
            self.futureLastEnable[k] = nil
        end
        for k in pairs(self.variable) do
            self.variable[k] = nil
        end
        for k in pairs(self.lastEnable) do
            self.lastEnable[k] = nil
        end
    end,
    getStateValue = function(self, name)
        return self.futureVariable[name] or self.variable[name] or 0
    end,
    getStateDurationAtTime = function(self, name, atTime)
        local lastEnable = self.futureLastEnable[name] or self.lastEnable[name] or self.baseState.currentTime
        return atTime - lastEnable
    end,
    putState = function(self, name, value, isFuture, atTime)
        if isFuture then
            local oldValue = self:getStateValue(name)
            if value ~= oldValue then
                self.tracer:log("Setting future state: %s from %s to %s.", name, oldValue, value)
                self.futureVariable[name] = value
                self.futureLastEnable[name] = atTime
            end
        else
            local oldValue = self.variable[name] or 0
            if value ~= oldValue then
                self.tracer:debugTimestamp("Advancing combat state: %s from %s to %s.", name, oldValue, value)
                self.tracer:log("Advancing combat state: %s from %s to %s.", name, oldValue, value)
                self.variable[name] = value
                self.lastEnable[name] = atTime
            end
        end
    end,
})
