local __exports = LibStub:NewLibrary("ovale/engine/runner", 90113)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.__ast = LibStub:GetLibrary("ovale/engine/ast")
__imports.isAstNodeWithChildren = __imports.__ast.isAstNodeWithChildren
__imports.setResultType = __imports.__ast.setResultType
__imports.__toolsTimeSpan = LibStub:GetLibrary("ovale/tools/TimeSpan")
__imports.newTimeSpan = __imports.__toolsTimeSpan.newTimeSpan
__imports.releaseTimeSpans = __imports.__toolsTimeSpan.releaseTimeSpans
__imports.universe = __imports.__toolsTimeSpan.universe
__imports.__toolstools = LibStub:GetLibrary("ovale/tools/tools")
__imports.isNumber = __imports.__toolstools.isNumber
__imports.isString = __imports.__toolstools.isString
__imports.oneTimeMessage = __imports.__toolstools.oneTimeMessage
local ipairs = ipairs
local kpairs = pairs
local loadstring = loadstring
local tostring = tostring
local wipe = wipe
local abs = math.abs
local huge = math.huge
local INFINITY = math.huge
local max = math.max
local min = math.min
local isAstNodeWithChildren = __imports.isAstNodeWithChildren
local setResultType = __imports.setResultType
local newTimeSpan = __imports.newTimeSpan
local releaseTimeSpans = __imports.releaseTimeSpans
local universe = __imports.universe
local isNumber = __imports.isNumber
local isString = __imports.isString
local oneTimeMessage = __imports.oneTimeMessage
__exports.Runner = __class(nil, {
    constructor = function(self, ovaleDebug, baseState, ovaleCondition)
        self.baseState = baseState
        self.ovaleCondition = ovaleCondition
        self.serial = 0
        self.actionHandlers = {}
        self.computeBoolean = function(node)
            if node.value then
                self:getTimeSpan(node, universe)
            else
                self:getTimeSpan(node)
            end
            return node.result
        end
        self.computeAction = function(node, atTime)
            local nodeId = node.nodeId
            local timeSpan = self:getTimeSpan(node)
            self.tracer:log("[%d]    evaluating action: %s()", nodeId, node.name)
            local _, namedParameters = self:computeParameters(node, atTime)
            local result = self:getActionInfo(node, atTime, namedParameters)
            if result.type ~= "action" then
                return result
            end
            local action = node.name
            if result.actionTexture == nil then
                self.tracer:log("[%d]    Action %s not found.", nodeId, action)
                wipe(timeSpan)
                setResultType(result, "none")
            elseif  not result.actionEnable then
                self.tracer:log("[%d]    Action %s not enabled.", nodeId, action)
                wipe(timeSpan)
                setResultType(result, "none")
            elseif namedParameters.usable == 1 and  not result.actionUsable then
                self.tracer:log("[%d]    Action %s not usable.", nodeId, action)
                wipe(timeSpan)
                setResultType(result, "none")
            else
                if result.castTime == nil then
                    result.castTime = 0
                end
                local start
                if result.actionCooldownStart ~= nil and result.actionCooldownStart > 0 and (result.actionCharges == nil or result.actionCharges == 0) then
                    self.tracer:log("[%d]    Action %s (actionCharges=%s)", nodeId, action, result.actionCharges or "(nil)")
                    if result.actionCooldownDuration ~= nil and result.actionCooldownDuration > 0 then
                        self.tracer:log("[%d]    Action %s is on cooldown (start=%f, duration=%f).", nodeId, action, result.actionCooldownStart, result.actionCooldownDuration)
                        start = result.actionCooldownStart + result.actionCooldownDuration
                    else
                        self.tracer:log("[%d]    Action %s is waiting on the GCD (start=%f).", nodeId, action, result.actionCooldownStart)
                        start = result.actionCooldownStart
                    end
                else
                    if result.actionCharges == nil then
                        self.tracer:log("[%d]    Action %s is off cooldown.", nodeId, action)
                        start = atTime
                    elseif result.actionCooldownDuration ~= nil and result.actionCooldownDuration > 0 then
                        self.tracer:log("[%d]    Action %s still has %f charges and is not on GCD.", nodeId, action, result.actionCharges)
                        start = atTime
                    else
                        self.tracer:log("[%d]    Action %s still has %f charges but is on GCD (start=%f).", nodeId, action, result.actionCharges, result.actionCooldownStart)
                        start = result.actionCooldownStart or 0
                    end
                end
                if result.actionResourceExtend ~= nil and result.actionResourceExtend > 0 then
                    if namedParameters.pool_resource ~= nil and namedParameters.pool_resource == 1 then
                        self.tracer:log("[%d]    Action %s is ignoring resource requirements because it is a pool_resource action.", nodeId, action)
                    else
                        self.tracer:log("[%d]    Action %s is waiting on resources (start=%f, extend=%f).", nodeId, action, start, result.actionResourceExtend)
                        start = start + result.actionResourceExtend
                    end
                end
                self.tracer:log("[%d]    start=%f atTime=%f", nodeId, start, atTime)
                if result.offgcd then
                    self.tracer:log("[%d]    Action %s is off the global cooldown.", nodeId, action)
                elseif start < atTime then
                    self.tracer:log("[%d]    Action %s is waiting for the global cooldown.", nodeId, action)
                    start = atTime
                end
                self.tracer:log("[%d]    Action %s can start at %f.", nodeId, action, start)
                timeSpan:copy(start, huge)
            end
            return result
        end
        self.computeArithmetic = function(element, atTime)
            local timeSpan = self:getTimeSpan(element)
            local result = element.result
            local nodeA = self:compute(element.child[1], atTime)
            local a, b, c, timeSpanA = self:asValue(atTime, nodeA)
            local nodeB = self:compute(element.child[2], atTime)
            local x, y, z, timeSpanB = self:asValue(atTime, nodeB)
            timeSpanA:intersect(timeSpanB, timeSpan)
            if timeSpan:measure() == 0 then
                self.tracer:log("[%d]    arithmetic '%s' returns %s with zero measure", element.nodeId, element.operator, timeSpan)
                self:setValue(element, 0)
            else
                local operator = element.operator
                local t = atTime
                self.tracer:log("[%d]    %s+(t-%s)*%s %s %s+(t-%s)*%s", element.nodeId, a, b, c, operator, x, y, z)
                local l, m, n
                if  not isNumber(a) or  not isNumber(x) then
                    self.tracer:error("[%d] Operands of arithmetic operators must be numbers", element.nodeId)
                    return result
                end
                local at = a + (t - b) * c
                local bt = x + (t - y) * z
                if operator == "+" then
                    l = at + bt
                    m = t
                    n = c + z
                elseif operator == "-" then
                    l = at - bt
                    m = t
                    n = c - z
                elseif operator == "*" then
                    l = at * bt
                    m = t
                    n = at * z + bt * c
                elseif operator == "/" then
                    if bt == 0 then
                        if at ~= 0 then
                            oneTimeMessage("[%d] Division by 0 in %s", element.nodeId, element.asString)
                        end
                        bt = 0.00001
                    end
                    l = at / bt
                    m = t
                    n = c / bt - (at / bt) * (z / bt)
                    local bound
                    if z == 0 then
                        bound = huge
                    else
                        bound = abs(bt / z)
                    end
                    local scratch = timeSpan:intersectInterval(t - bound, t + bound)
                    timeSpan:copyFromArray(scratch)
                    scratch:release()
                elseif operator == "%" then
                    if c == 0 and z == 0 then
                        l = at % bt
                        m = t
                        n = 0
                    else
                        self.tracer:error("[%d]    Parameters of modulus operator '%' must be constants.", element.nodeId)
                        l = 0
                        m = 0
                        n = 0
                    end
                elseif operator == "<?" or operator == ">?" then
                    if z == c then
                        l = (operator == "<?" and min(at, bt)) or max(at, bt)
                        m = t
                        n = z
                    else
                        local ct = (bt - at) / (z - c)
                        if ct <= 0 then
                            local scratch = timeSpan:intersectInterval(t + ct, INFINITY)
                            timeSpan:copyFromArray(scratch)
                            scratch:release()
                            if z < c then
                                l = (operator == ">?" and at) or bt
                            else
                                l = (operator == "<?" and at) or bt
                            end
                        else
                            local scratch = timeSpan:intersectInterval(0, t + ct)
                            timeSpan:copyFromArray(scratch)
                            scratch:release()
                            if z < c then
                                l = (operator == "<?" and at) or bt
                            else
                                l = (operator == ">?" and at) or bt
                            end
                        end
                        m = t
                        n = (l == at and c) or z
                    end
                end
                self.tracer:log("[%d]    arithmetic '%s' returns %s+(t-%s)*%s", element.nodeId, operator, l, m, n)
                self:setValue(element, l, m, n)
            end
            return result
        end
        self.computeCompare = function(element, atTime)
            local timeSpan = self:getTimeSpan(element)
            local elementA = self:compute(element.child[1], atTime)
            local a, b, c, timeSpanA = self:asValue(atTime, elementA)
            local elementB = self:compute(element.child[2], atTime)
            local x, y, z, timeSpanB = self:asValue(atTime, elementB)
            timeSpanA:intersect(timeSpanB, timeSpan)
            if timeSpan:measure() == 0 then
                self.tracer:log("[%d]    compare '%s' returns %s with zero measure", element.nodeId, element.operator, timeSpan)
            else
                local operator = element.operator
                self.tracer:log("[%d]    %s+(t-%s)*%s %s %s+(t-%s)*%s", element.nodeId, a, b, c, operator, x, y, z)
                if  not isNumber(a) or  not isNumber(x) then
                    if (operator == "==" and a ~= b) or (operator == "!=" and a == b) then
                        wipe(timeSpan)
                    end
                    return element.result
                end
                local at = a - b * c
                local bt = x - y * z
                if c == z then
                    if  not ((operator == "==" and at == bt) or (operator == "!=" and at ~= bt) or (operator == "<" and at < bt) or (operator == "<=" and at <= bt) or (operator == ">" and at > bt) or (operator == ">=" and at >= bt)) then
                        wipe(timeSpan)
                    end
                else
                    local diff = bt - at
                    local t
                    if diff == huge then
                        t = huge
                    else
                        t = diff / (c - z)
                    end
                    t = (t > 0 and t) or 0
                    self.tracer:log("[%d]    intersection at t = %s", element.nodeId, t)
                    local scratch
                    if (c > z and operator == "<") or (c > z and operator == "<=") or (c < z and operator == ">") or (c < z and operator == ">=") then
                        scratch = timeSpan:intersectInterval(0, t)
                    elseif (c < z and operator == "<") or (c < z and operator == "<=") or (c > z and operator == ">") or (c > z and operator == ">=") then
                        scratch = timeSpan:intersectInterval(t, huge)
                    end
                    if scratch then
                        timeSpan:copyFromArray(scratch)
                        scratch:release()
                    else
                        wipe(timeSpan)
                    end
                end
                self.tracer:log("[%d]    compare '%s' returns %s", element.nodeId, operator, timeSpan)
            end
            return element.result
        end
        self.computeCustomFunction = function(element, atTime)
            local timeSpan = self:getTimeSpan(element)
            local result = element.result
            local node = element.annotation.customFunction and element.annotation.customFunction[element.name]
            if node then
                if self.tracer.debugTools.trace then
                    self.tracer:log("[%d]: calling custom function [%d] %s", element.nodeId, node.child[1].nodeId, element.name)
                end
                local elementA = self:compute(node.child[1], atTime)
                timeSpan:copyFromArray(elementA.timeSpan)
                if self.tracer.debugTools.trace then
                    self.tracer:log("[%d]: [%d] %s is returning %s with timespan = %s", element.nodeId, node.child[1].nodeId, element.name, self:resultToString(elementA), timeSpan)
                end
                self:copyResult(result, elementA)
            else
                self.tracer:error("Unable to find " .. element.name)
                wipe(timeSpan)
            end
            return result
        end
        self.computeFunction = function(element, atTime)
            local timeSpan = self:getTimeSpan(element)
            local positionalParams, namedParams = self:computeParameters(element, atTime)
            local start, ending, value, origin, rate = self.ovaleCondition:evaluateCondition(element.name, positionalParams, namedParams, atTime)
            if start ~= nil and ending ~= nil then
                timeSpan:copy(start, ending)
            else
                wipe(timeSpan)
            end
            if value ~= nil then
                self:setValue(element, value, origin, rate)
            end
            self.tracer:log("[%d]    condition '%s' returns %s, %s, %s, %s, %s", element.nodeId, element.name, start, ending, value, origin, rate)
            return element.result
        end
        self.computeTypedFunction = function(element, atTime)
            local timeSpan = self:getTimeSpan(element)
            local positionalParams = self:computePositionalParameters(element, atTime)
            local start, ending, value, origin, rate = self.ovaleCondition:call(element.name, atTime, positionalParams)
            if start ~= nil and ending ~= nil then
                timeSpan:copy(start, ending)
            else
                wipe(timeSpan)
            end
            if value ~= nil then
                self:setValue(element, value, origin, rate)
            end
            self.tracer:log("[%d]    condition '%s' returns %s, %s, %s, %s, %s", element.nodeId, element.name, start, ending, value, origin, rate)
            return element.result
        end
        self.computeGroup = function(group, atTime)
            local bestTimeSpan, bestElement
            local best = newTimeSpan()
            local currentTimeSpanAfterTime = newTimeSpan()
            for _, child in ipairs(group.child) do
                local nodeString = child.asString or child.type
                self.tracer:log("[%d]    checking child '%s' [%d]", group.nodeId, nodeString, child.nodeId)
                local currentElement = self:compute(child, atTime)
                local currentElementTimeSpan = currentElement.timeSpan
                wipe(currentTimeSpanAfterTime)
                currentElementTimeSpan:intersectInterval(atTime, huge, currentTimeSpanAfterTime)
                self.tracer:log("[%d]    child '%s' [%d]: %s", group.nodeId, nodeString, child.nodeId, currentTimeSpanAfterTime)
                if currentTimeSpanAfterTime:measure() > 0 then
                    local currentIsBetter = false
                    if best:measure() == 0 or bestElement == nil then
                        self.tracer:log("[%d]    group first best is '%s' [%d]: %s", group.nodeId, nodeString, child.nodeId, currentTimeSpanAfterTime)
                        currentIsBetter = true
                    else
                        local threshold = (bestElement.type == "action" and bestElement.options and bestElement.options.wait) or 0
                        local difference = best[1] - currentTimeSpanAfterTime[1]
                        if difference > threshold or (difference == threshold and bestElement.type == "action" and currentElement.type == "action" and  not bestElement.actionUsable and currentElement.actionUsable) then
                            self.tracer:log("[%d]    group new best is '%s' [%d]: %s", group.nodeId, nodeString, child.nodeId, currentElementTimeSpan)
                            currentIsBetter = true
                        else
                            self.tracer:log("[%d]    group best is still %s: %s", group.nodeId, self:resultToString(group.result), best)
                        end
                    end
                    if currentIsBetter then
                        best:copyFromArray(currentTimeSpanAfterTime)
                        bestTimeSpan = currentElementTimeSpan
                        bestElement = currentElement
                    end
                else
                    self.tracer:log("[%d]    child '%s' [%d] has zero measure, skipping", group.nodeId, nodeString, child.nodeId)
                end
            end
            releaseTimeSpans(best, currentTimeSpanAfterTime)
            local timeSpan = self:getTimeSpan(group, bestTimeSpan)
            if bestElement then
                self:copyResult(group.result, bestElement)
                self.tracer:log("[%d]    group best action remains %s at %s", group.nodeId, self:resultToString(group.result), timeSpan)
            else
                setResultType(group.result, "none")
                self.tracer:log("[%d]    group no best action returns %s at %s", group.nodeId, self:resultToString(group.result), timeSpan)
            end
            return group.result
        end
        self.computeIf = function(element, atTime)
            local timeSpan = self:getTimeSpan(element)
            local result = element.result
            local timeSpanA = self:computeBool(element.child[1], atTime)
            local conditionTimeSpan = timeSpanA
            if element.type == "unless" then
                conditionTimeSpan = timeSpanA:complement()
            end
            if conditionTimeSpan:measure() == 0 then
                timeSpan:copyFromArray(conditionTimeSpan)
                self.tracer:log("[%d]    '%s' returns %s with zero measure", element.nodeId, element.type, timeSpan)
            else
                local elementB = self:compute(element.child[2], atTime)
                conditionTimeSpan:intersect(elementB.timeSpan, timeSpan)
                self.tracer:log("[%d]    '%s' returns %s (intersection of %s and %s)", element.nodeId, element.type, timeSpan, conditionTimeSpan, elementB.timeSpan)
                self:copyResult(result, elementB)
            end
            if element.type == "unless" then
                conditionTimeSpan:release()
            end
            return result
        end
        self.computeLogical = function(element, atTime)
            local timeSpan = self:getTimeSpan(element)
            local timeSpanA = self:computeBool(element.child[1], atTime)
            if element.operator == "and" then
                if timeSpanA:measure() == 0 then
                    timeSpan:copyFromArray(timeSpanA)
                    self.tracer:log("[%d]    logical '%s' short-circuits with zero measure left argument", element.nodeId, element.operator)
                else
                    local timeSpanB = self:computeBool(element.child[2], atTime)
                    timeSpanA:intersect(timeSpanB, timeSpan)
                end
            elseif element.operator == "not" then
                timeSpanA:complement(timeSpan)
            elseif element.operator == "or" then
                if timeSpanA:isUniverse() then
                    timeSpan:copyFromArray(timeSpanA)
                    self.tracer:log("[%d]    logical '%s' short-circuits with universe as left argument", element.nodeId, element.operator)
                else
                    local timeSpanB = self:computeBool(element.child[2], atTime)
                    timeSpanA:union(timeSpanB, timeSpan)
                end
            elseif element.operator == "xor" then
                local timeSpanB = self:computeBool(element.child[2], atTime)
                local left = timeSpanA:union(timeSpanB)
                local scratch = timeSpanA:intersect(timeSpanB)
                local right = scratch:complement()
                left:intersect(right, timeSpan)
                releaseTimeSpans(left, scratch, right)
            else
                wipe(timeSpan)
            end
            self.tracer:log("[%d]    logical '%s' returns %s", element.nodeId, element.operator, timeSpan)
            return element.result
        end
        self.computeLua = function(element)
            if  not element.lua then
                return element.result
            end
            local value = loadstring(element.lua)()
            self.tracer:log("[%d]    lua returns %s", element.nodeId, value)
            if value ~= nil then
                self:setValue(element, value)
            end
            self:getTimeSpan(element, universe)
            return element.result
        end
        self.computeValue = function(element)
            self.tracer:log("[%d]    value is %s", element.nodeId, element.value)
            self:getTimeSpan(element, universe)
            self:setValue(element, element.value, element.origin, element.rate)
            return element.result
        end
        self.computeString = function(element)
            self.tracer:log("[%d]    value is %s", element.nodeId, element.value)
            self:getTimeSpan(element, universe)
            self:setValue(element, element.value, nil, nil)
            return element.result
        end
        self.computeVariable = function(element)
            self.tracer:log("[%d]    value is %s", element.nodeId, element.name)
            self:getTimeSpan(element, universe)
            self:setValue(element, element.name, nil, nil)
            return element.result
        end
        self.computeVisitors = {
            ["action"] = self.computeAction,
            ["arithmetic"] = self.computeArithmetic,
            ["boolean"] = self.computeBoolean,
            ["compare"] = self.computeCompare,
            ["custom_function"] = self.computeCustomFunction,
            ["function"] = self.computeFunction,
            ["group"] = self.computeGroup,
            ["if"] = self.computeIf,
            ["logical"] = self.computeLogical,
            ["lua"] = self.computeLua,
            ["state"] = self.computeFunction,
            ["string"] = self.computeString,
            ["typed_function"] = self.computeTypedFunction,
            ["unless"] = self.computeIf,
            ["value"] = self.computeValue,
            ["variable"] = self.computeVariable
        }
        self.tracer = ovaleDebug:create("runner")
    end,
    refresh = function(self)
        self.serial = self.serial + 1
        self.tracer:log("Advancing age to %d.", self.serial)
    end,
    postOrderCompute = function(self, element, atTime)
        local result
        local postOrder = element.postOrder
        if postOrder and element.result.serial ~= self.serial then
            self.tracer:log("[%d] [[[ Compute '%s' post-order nodes.", element.nodeId, element.type)
            local index = 1
            local n = #postOrder
            while index < n do
                local childNode, parentNode = postOrder[index], postOrder[index + 1]
                index = index + 2
                result = self:postOrderCompute(childNode, atTime)
                local shortCircuit = false
                if isAstNodeWithChildren(parentNode) and parentNode.child[1] == childNode then
                    if parentNode.type == "if" and result.timeSpan:measure() == 0 then
                        self.tracer:log("[%d]    '%s' [%d] will trigger short-circuit evaluation of parent node '%s' [%d] with zero-measure time span.", element.nodeId, childNode.type, childNode.nodeId, parentNode.type, parentNode.nodeId)
                        shortCircuit = true
                    elseif parentNode.type == "unless" and result.timeSpan:isUniverse() then
                        self.tracer:log("[%d]    '%s' [%d] will trigger short-circuit evaluation of parent node '%s' [%d] with universe as time span.", element.nodeId, childNode.type, childNode.nodeId, parentNode.type, parentNode.nodeId)
                        shortCircuit = true
                    elseif parentNode.type == "logical" and parentNode.operator == "and" and result.timeSpan:measure() == 0 then
                        self.tracer:log("[%d]    '%s' [%d] will trigger short-circuit evaluation of parent node '%s' [%d] with zero measure.", element.nodeId, childNode.type, childNode.nodeId, parentNode.type, parentNode.nodeId)
                        shortCircuit = true
                    elseif parentNode.type == "logical" and parentNode.operator == "or" and result.timeSpan:isUniverse() then
                        self.tracer:log("[%d]    '%s' [%d] will trigger short-circuit evaluation of parent node '%s' [%d] with universe as time span.", element.nodeId, childNode.type, childNode.nodeId, parentNode.type, parentNode.nodeId)
                        shortCircuit = true
                    end
                end
                if shortCircuit then
                    while parentNode ~= postOrder[index] and index <= n do
                        index = index + 2
                    end
                    if index > n then
                        self.tracer:error("Ran off end of postOrder node list for node %d.", element.nodeId)
                    end
                end
            end
            self.tracer:log("[%d] ]]] Compute '%s' post-order nodes: complete.", element.nodeId, element.type)
        end
        self:recursiveCompute(element, atTime)
        return element.result
    end,
    recursiveCompute = function(self, element, atTime)
        self.tracer:log("[%d] >>> Computing '%s' at time=%f", element.nodeId, element.asString or element.type, atTime)
        if element.result.constant then
            self.tracer:log("[%d] <<< '%s' returns %s with constant %s", element.nodeId, element.asString or element.type, element.result.timeSpan, self:resultToString(element.result))
            return element.result
        elseif element.result.serial == -1 then
            oneTimeMessage("Recursive call is not supported in '%s'. Please fix the script.", element.asString or element.type)
            return element.result
        elseif element.result.serial == self.serial then
            self.tracer:log("[%d] <<< '%s' returns %s with cached %s", element.nodeId, element.asString or element.type, element.result.timeSpan, self:resultToString(element.result))
        else
            element.result.serial = -1
            local visitor = self.computeVisitors[element.type]
            local result
            if visitor then
                result = visitor(element, atTime)
                element.result.serial = self.serial
                self.tracer:log("[%d] <<< '%s' returns %s with computed %s", element.nodeId, element.asString or element.type, result.timeSpan, self:resultToString(element.result))
            else
                self.tracer:error("[%d] Runtime error: unable to compute node of type '%s': %s.", element.nodeId, element.type, element.asString)
                wipe(element.result.timeSpan)
                element.result.serial = self.serial
            end
        end
        return element.result
    end,
    computeBool = function(self, element, atTime)
        local newElement = self:compute(element, atTime)
        return newElement.timeSpan
    end,
    registerActionInfoHandler = function(self, name, handler)
        self.actionHandlers[name] = handler
    end,
    getActionInfo = function(self, element, atTime, namedParameters)
        if element.result.serial == self.serial then
            self.tracer:log("[%d]    using cached result (age = %d/%d)", element.nodeId, element.result.serial, self.serial)
        else
            local target = (isString(namedParameters.target) and namedParameters.target) or self.baseState.defaultTarget
            local result = self.actionHandlers[element.name](element, atTime, target)
            if result.type == "action" then
                result.options = namedParameters
            end
        end
        return element.result
    end,
    copyResult = function(self, target, source)
        for k in kpairs(target) do
            if k ~= "timeSpan" and k ~= "type" and k ~= "serial" and source[k] == nil then
                target[k] = nil
            end
        end
        for k, v in kpairs(source) do
            if k ~= "timeSpan" and k ~= "serial" and k ~= "constant" and target[k] ~= v then
                target[k] = v
            end
        end
    end,
    resultToString = function(self, result)
        if result.type == "value" then
            if result.value == nil then
                return "nil value"
            end
            if isString(result.value) then
                return "value \"" .. result.value .. "\""
            end
            if isNumber(result.value) then
                return "value " .. result.value .. " + (t - " .. tostring(result.origin) .. ") * " .. tostring(result.rate)
            end
            return "value " .. ((result.value == true and "true") or "false")
        elseif result.type == "action" then
            return "action " .. (result.actionType or "?") .. " " .. (result.actionId or "nil")
        elseif result.type == "none" then
            return [[none]]
        elseif result.type == "state" then
            return "state " .. result.name
        end
        return ""
    end,
    setValue = function(self, node, value, origin, rate)
        local result = node.result
        if result.type ~= "value" then
            setResultType(result, "value")
        end
        value = value or 0
        origin = origin or 0
        rate = rate or 0
        if value ~= result.value or result.origin ~= origin or result.rate ~= rate then
            result.value = value
            result.origin = origin
            result.rate = rate
        end
    end,
    asValue = function(self, atTime, node)
        local value, origin, rate, timeSpan
        if node.type == "value" and node.value ~= nil then
            value = node.value
            origin = node.origin or 0
            rate = node.rate or 0
            timeSpan = node.timeSpan or universe
        elseif node.timeSpan:hasTime(atTime) then
            value, origin, rate, timeSpan = 1, 0, 0, universe
        else
            value, origin, rate, timeSpan = 0, 0, 0, universe
        end
        return value, origin, rate, timeSpan
    end,
    getTimeSpan = function(self, node, defaultTimeSpan)
        local timeSpan = node.result.timeSpan
        if defaultTimeSpan then
            timeSpan:copyFromArray(defaultTimeSpan)
        else
            wipe(timeSpan)
        end
        return timeSpan
    end,
    compute = function(self, element, atTime)
        return self:postOrderCompute(element, atTime)
    end,
    computeAsBoolean = function(self, element, atTime)
        local result = self:recursiveCompute(element, atTime)
        return result.timeSpan:hasTime(atTime)
    end,
    computeAsNumber = function(self, element, atTime)
        local result = self:recursiveCompute(element, atTime)
        if result.type == "value" and isNumber(result.value) then
            if result.origin ~= nil and result.rate ~= nil then
                return result.value + result.rate * (atTime - result.origin)
            end
            return result.value
        end
        return 0
    end,
    computeAsString = function(self, element, atTime)
        local result = self:recursiveCompute(element, atTime)
        if result.type == "value" and isString(result.value) then
            return result.value
        end
        return nil
    end,
    computeAsValue = function(self, element, atTime)
        local result = self:recursiveCompute(element, atTime)
        if result.type == "value" then
            if  not result.timeSpan:hasTime(atTime) then
                return nil
            end
            return result.value
        end
        return result.timeSpan:hasTime(atTime)
    end,
    computeParameters = function(self, node, atTime)
        if node.cachedParams.serial == nil or node.cachedParams.serial < self.serial then
            node.cachedParams.serial = self.serial
            for k, v in ipairs(node.rawPositionalParams) do
                node.cachedParams.positional[k] = self:computeAsValue(v, atTime) or false
            end
            for k, v in kpairs(node.rawNamedParams) do
                node.cachedParams.named[k] = self:computeAsValue(v, atTime)
            end
        end
        return node.cachedParams.positional, node.cachedParams.named
    end,
    computePositionalParameters = function(self, node, atTime)
        if node.cachedParams.serial == nil or node.cachedParams.serial < self.serial then
            self.tracer:log("computing positional parameters")
            node.cachedParams.serial = self.serial
            for k, v in ipairs(node.rawPositionalParams) do
                node.cachedParams.positional[k] = self:computeAsValue(v, atTime)
            end
        end
        return node.cachedParams.positional
    end,
})
