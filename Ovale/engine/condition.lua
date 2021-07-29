local __exports = LibStub:NewLibrary("ovale/engine/condition", 90103)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local next = next
local ipairs = ipairs
local unpack = unpack
local huge = math.huge
local __toolstools = LibStub:GetLibrary("ovale/tools/tools")
local isString = __toolstools.isString
local insert = table.insert
local infinity = huge
__exports.getFunctionSignature = function(name, infos)
    local result = name .. "("
    for k, v in ipairs(infos.parameters) do
        if k > 1 then
            result = result .. ", "
        end
        result = result .. v.name .. ": " .. v.type
    end
    return result .. ")"
end
__exports.OvaleConditionClass = __class(nil, {
    constructor = function(self, baseState)
        self.baseState = baseState
        self.conditions = {}
        self.actions = {}
        self.spellBookConditions = {
            spell = true
        }
        self.typedConditions = {}
    end,
    registerCondition = function(self, name, isSpellBookCondition, func)
        self.conditions[name] = func
        if isSpellBookCondition then
            self.spellBookConditions[name] = true
        end
    end,
    register = function(self, name, func, returnParameters, ...)
        local infos = {
            func = func,
            parameters = {...},
            namedParameters = {},
            returnValue = returnParameters
        }
        for k, v in ipairs(infos.parameters) do
            infos.namedParameters[v.name] = k
            if v.name == "target" then
                infos.targetIndex = k
            end
            if v.type == "string" and v.mapValues then
                infos.replacements = infos.replacements or {}
                insert(infos.replacements, {
                    index = k,
                    mapValues = v.mapValues
                })
            end
        end
        self.typedConditions[name] = infos
    end,
    registerAlias = function(self, name, alias)
        self.typedConditions[alias] = self.typedConditions[name]
    end,
    call = function(self, name, atTime, positionalParams)
        local infos = self.typedConditions[name]
        if infos.replacements then
            for _, v in ipairs(infos.replacements) do
                local value = positionalParams[v.index]
                if value then
                    local replacement = v.mapValues[value]
                    if replacement then
                        positionalParams[v.index] = replacement
                    end
                end
            end
        end
        if infos.targetIndex and (positionalParams[infos.targetIndex] == "target" or positionalParams[infos.targetIndex] == "cycle") then
            positionalParams[infos.targetIndex] = self.baseState.defaultTarget
        end
        return infos.func(atTime, unpack(positionalParams))
    end,
    registerAction = function(self, name, func)
        self.actions[name] = func
    end,
    unregisterCondition = function(self, name)
        self.conditions[name] = nil
    end,
    getInfos = function(self, name)
        return self.typedConditions[name]
    end,
    isCondition = function(self, name)
        return self.conditions[name] ~= nil
    end,
    isSpellBookCondition = function(self, name)
        return self.spellBookConditions[name] ~= nil
    end,
    evaluateCondition = function(self, name, positionalParams, namedParams, atTime)
        return self.conditions[name](positionalParams, namedParams, atTime)
    end,
    hasAny = function(self)
        return next(self.conditions) ~= nil
    end,
})
__exports.parseCondition = function(namedParams, baseState, defaultTarget)
    local target = (isString(namedParams.target) and namedParams.target) or defaultTarget or "player"
    namedParams.target = namedParams.target or target
    if target == "cycle" or target == "target" then
        target = baseState.defaultTarget
    end
    local filter
    if namedParams.filter then
        if namedParams.filter == "debuff" then
            filter = "HARMFUL"
        elseif namedParams.filter == "buff" then
            filter = "HELPFUL"
        end
    end
    local mine = true
    if namedParams.any and namedParams.any == 1 then
        mine = false
    end
    return target, filter, mine
end
__exports.returnValue = function(value, origin, rate)
    return 0, infinity, value, origin, rate
end
__exports.returnValueBetween = function(start, ending, value, origin, rate)
    if start >= ending then
        return 
    end
    return start, ending, value, origin, rate
end
__exports.returnConstant = function(value)
    return 0, infinity, value, 0, 0
end
__exports.returnBoolean = function(value)
    if value then
        return 0, infinity
    end
    return 
end
