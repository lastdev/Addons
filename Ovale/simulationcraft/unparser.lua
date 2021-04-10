local __exports = LibStub:NewLibrary("ovale/simulationcraft/unparser", 90048)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __definitions = LibStub:GetLibrary("ovale/simulationcraft/definitions")
local unaryOperators = __definitions.unaryOperators
local binaryOperators = __definitions.binaryOperators
local tostring = tostring
local pairs = pairs
local tonumber = tonumber
local kpairs = pairs
local __texttools = LibStub:GetLibrary("ovale/simulationcraft/text-tools")
local outputPool = __texttools.outputPool
local concat = table.concat
local function getPrecedence(node)
    if node.type ~= "operator" then
        return 0
    end
    local precedence = node.precedence
    if  not precedence then
        local operator = node.operator
        if operator then
            if node.expressionType == "unary" and unaryOperators[operator] then
                precedence = unaryOperators[operator][2]
            elseif node.expressionType == "binary" and binaryOperators[operator] then
                precedence = binaryOperators[operator][2]
            end
        end
    end
    return precedence
end
__exports.Unparser = __class(nil, {
    constructor = function(self, ovaleDebug)
        self.unparseAction = function(node)
            local output = outputPool:get()
            output[#output + 1] = node.name
            for modifier, expressionNode in kpairs(node.modifiers) do
                output[#output + 1] = modifier .. "=" .. self:unparse(expressionNode)
            end
            local s = concat(output, ",")
            outputPool:release(output)
            return s
        end
        self.unparseActionList = function(node)
            local output = outputPool:get()
            local listName
            if node.name == "_default" then
                listName = "action"
            else
                listName = "action." .. node.name
            end
            output[#output + 1] = ""
            for i, actionNode in pairs(node.child) do
                local operator = (tonumber(i) == 1 and "=") or "+=/"
                output[#output + 1] = listName .. operator .. self:unparse(actionNode)
            end
            local s = concat(output, "\n")
            outputPool:release(output)
            return s
        end
        self.unparseExpression = function(node)
            local expression
            local precedence = getPrecedence(node)
            if node.expressionType == "unary" then
                local rhsExpression
                local rhsNode = node.child[1]
                local rhsPrecedence = getPrecedence(rhsNode)
                if rhsPrecedence and precedence >= rhsPrecedence then
                    rhsExpression = "(" .. self:unparse(rhsNode) .. ")"
                else
                    rhsExpression = self:unparse(rhsNode)
                end
                expression = node.operator .. rhsExpression
            elseif node.expressionType == "binary" then
                local lhsExpression, rhsExpression
                local lhsNode = node.child[1]
                local lhsPrecedence = getPrecedence(lhsNode)
                if lhsPrecedence and lhsPrecedence < precedence then
                    lhsExpression = "(" .. self:unparse(lhsNode) .. ")"
                else
                    lhsExpression = self:unparse(lhsNode)
                end
                local rhsNode = node.child[2]
                local rhsPrecedence = getPrecedence(rhsNode)
                if rhsPrecedence and precedence > rhsPrecedence then
                    rhsExpression = "(" .. self:unparse(rhsNode) .. ")"
                elseif rhsPrecedence and precedence == rhsPrecedence then
                    if rhsNode.type == "operator" and binaryOperators[node.operator][3] == "associative" and node.operator == rhsNode.operator then
                        rhsExpression = self:unparse(rhsNode)
                    else
                        rhsExpression = "(" .. self:unparse(rhsNode) .. ")"
                    end
                else
                    rhsExpression = self:unparse(rhsNode)
                end
                expression = lhsExpression .. node.operator .. rhsExpression
            else
                return "Unknown node expression type"
            end
            return expression
        end
        self.unparseFunction = function(node)
            return node.name .. "(" .. self:unparse(node.child[1]) .. ")"
        end
        self.unparseNumber = function(node)
            return tostring(node.value)
        end
        self.unparseOperand = function(node)
            return node.name
        end
        self.unparseVisitors = {
            ["action"] = self.unparseAction,
            ["action_list"] = self.unparseActionList,
            ["operator"] = self.unparseExpression,
            ["function"] = self.unparseFunction,
            ["number"] = self.unparseNumber,
            ["operand"] = self.unparseOperand
        }
        self.tracer = ovaleDebug:create("SimulationCraftUnparser")
    end,
    unparse = function(self, node)
        local visitor = self.unparseVisitors[node.type]
        if  not visitor then
            self.tracer:error("Unable to unparse node of type '%s'.", node.type)
        else
            return visitor(node)
        end
    end,
})
