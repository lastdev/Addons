local __exports = LibStub:NewLibrary("ovale/simulationcraft/parser", 90113)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.__enginelexer = LibStub:GetLibrary("ovale/engine/lexer")
__imports.OvaleLexer = __imports.__enginelexer.OvaleLexer
__imports.__definitions = LibStub:GetLibrary("ovale/simulationcraft/definitions")
__imports.keywords = __imports.__definitions.keywords
__imports.specialActions = __imports.__definitions.specialActions
__imports.sequenceActions = __imports.__definitions.sequenceActions
__imports.unaryOperators = __imports.__definitions.unaryOperators
__imports.binaryOperators = __imports.__definitions.binaryOperators
__imports.functionKeywords = __imports.__definitions.functionKeywords
__imports.modifierKeywords = __imports.__definitions.modifierKeywords
__imports.targetIfKeywords = __imports.__definitions.targetIfKeywords
__imports.litteralModifiers = __imports.__definitions.litteralModifiers
__imports.runeOperands = __imports.__definitions.runeOperands
__imports.__toolsPool = LibStub:GetLibrary("ovale/tools/Pool")
__imports.OvalePool = __imports.__toolsPool.OvalePool
__imports.__toolstools = LibStub:GetLibrary("ovale/tools/tools")
__imports.checkToken = __imports.__toolstools.checkToken
local OvaleLexer = __imports.OvaleLexer
local tostring = tostring
local tonumber = tonumber
local ipairs = ipairs
local wipe = wipe
local keywords = __imports.keywords
local specialActions = __imports.specialActions
local sequenceActions = __imports.sequenceActions
local unaryOperators = __imports.unaryOperators
local binaryOperators = __imports.binaryOperators
local functionKeywords = __imports.functionKeywords
local modifierKeywords = __imports.modifierKeywords
local targetIfKeywords = __imports.targetIfKeywords
local litteralModifiers = __imports.litteralModifiers
local runeOperands = __imports.runeOperands
local gsub = string.gsub
local gmatch = string.gmatch
local sub = string.sub
local insert = table.insert
local concat = table.concat
local OvalePool = __imports.OvalePool
local checkToken = __imports.checkToken
local childrenPool = __imports.OvalePool("OvaleSimulationCraft_childrenPool")
local SelfPool = __class(OvalePool, {
    constructor = function(self)
        OvalePool.constructor(self, "OvaleSimulationCraft_pool")
    end,
    clean = function(self, node)
        if node.type ~= "number" and node.type ~= "operand" and node.type ~= "action" then
            childrenPool:release(node.child)
        end
        wipe(node)
    end,
})
local selfPool = SelfPool()
local function newNode(nodeList)
    local node = selfPool:get()
    local nodeId = #nodeList + 1
    node.nodeId = nodeId
    nodeList[nodeId] = node
    return node
end
local function newNodeWithChild(nodeList)
    local node = selfPool:get()
    local nodeId = #nodeList + 1
    node.nodeId = nodeId
    nodeList[nodeId] = node
    node.child = childrenPool:get()
    return node
end
local ticksRemainTranslationHelper = function(p1, p2, p3, p4)
    if p4 then
        return p1 .. p2 .. " < " .. tostring(tonumber(p4) + 1)
    else
        return p1 .. "<" .. tostring(tonumber(p3) + 1)
    end
end

local tokenizeName = function(token)
    if keywords[token] then
        return "keyword", token
    else
        return "name", token
    end
end

local tokenizeNumber = function(token)
    return "number", token
end

local tokenize = function(token)
    return token, token
end

local noToken = function()
    return nil, nil
end

local tokenMatches = {}
do
    insert(tokenMatches, {
        [1] = "^%d+%a[%w_]+%.?[%w_.]*",
        [2] = tokenizeName
    })
    insert(tokenMatches, {
        [1] = "^%d+%.?%d*",
        [2] = tokenizeNumber
    })
    insert(tokenMatches, {
        [1] = "^[%w_]+%.?[%w_.]*",
        [2] = tokenizeName
    })
    insert(tokenMatches, {
        [1] = "^!=",
        [2] = tokenize
    })
    insert(tokenMatches, {
        [1] = "^<=",
        [2] = tokenize
    })
    insert(tokenMatches, {
        [1] = "^>=",
        [2] = tokenize
    })
    insert(tokenMatches, {
        [1] = "^!~",
        [2] = tokenize
    })
    insert(tokenMatches, {
        [1] = "^==",
        [2] = tokenize
    })
    insert(tokenMatches, {
        [1] = "^>%?",
        [2] = tokenize
    })
    insert(tokenMatches, {
        [1] = "^<%?",
        [2] = tokenize
    })
    insert(tokenMatches, {
        [1] = "^%%%%",
        [2] = tokenize
    })
    insert(tokenMatches, {
        [1] = "^.",
        [2] = tokenize
    })
    insert(tokenMatches, {
        [1] = "^$",
        [2] = noToken
    })
end
__exports.Parser = __class(nil, {
    constructor = function(self, ovaleDebug)
        self.tracer = ovaleDebug:create("SimulationCraftParser")
    end,
    release = function(self, nodeList)
        for _, node in ipairs(nodeList) do
            selfPool:release(node)
        end
    end,
    syntaxError = function(self, tokenStream, pattern, ...)
        self.tracer:warning(pattern, ...)
        local context = {
            [1] = "Next tokens:"
        }
        for i = 1, 20, 1 do
            local tokenType, token = tokenStream:peek(i)
            if tokenType and token then
                context[#context + 1] = token
            else
                context[#context + 1] = "<EOS>"
                break
            end
        end
        self.tracer:warning(concat(context, " "))
    end,
    parseActionList = function(self, name, actionList, nodeList, annotation)
        local child = childrenPool:get()
        for action in gmatch(actionList, "[^/]+") do
            local actionNode = self:parseAction(action, nodeList, annotation, name)
            if  not actionNode then
                childrenPool:release(child)
                return nil
            end
            child[#child + 1] = actionNode
        end
        local node = newNode(nodeList)
        node.type = "action_list"
        node.name = name
        node.child = child
        return node
    end,
    parseAction = function(self, action, nodeList, annotation, actionListName)
        local stream = action
        do
            stream = gsub(stream, "||", "|")
        end
        do
            stream = gsub(stream, ",,", ",")
            stream = gsub(stream, "%&%&", "&")
            stream = gsub(stream, "target%.target%.", "target.")
            stream = gsub(stream, "name=name=", "name=")
            stream = gsub(stream, "name=BT&", "name=BT_")
            stream = gsub(stream, "ebonsoul_vice", "ebonsoul_vise")
        end
        do
            stream = gsub(stream, "buff%.from_the_shadows%.", "target.debuff.from_the_shadows.")
            stream = gsub(stream, "tormented_insight_355321", "shadowed_orb_of_torment_355321")
            stream = gsub(stream, "darkmoon_deck_+", "darkmoon_deck_")
        end
        do
            stream = gsub(stream, "(active_dot%.[%w_]+)=0", "!(%1>0)")
            stream = gsub(stream, "([^_%.])(cooldown_remains)=0", "%1!(%2>0)")
            stream = gsub(stream, "([a-z_%.]+%.cooldown_remains)=0", "!(%1>0)")
            stream = gsub(stream, "([^_%.])(remains)=0", "%1!(%2>0)")
            stream = gsub(stream, "([a-z_%.]+%.remains)=0", "!(%1>0)")
            stream = gsub(stream, "([^_%.])(ticks_remain)(<?=)([0-9]+)", ticksRemainTranslationHelper)
            stream = gsub(stream, "([a-z_%.]+%.ticks_remain)(<?=)([0-9]+)", ticksRemainTranslationHelper)
        end
        do
            stream = gsub(stream, "%@([a-z_%.]+)<(=?)([0-9]+)", "(%1<%2%3&%1>%2-%3)")
            stream = gsub(stream, "%@([a-z_%.]+)>(=?)([0-9]+)", "(%1>%2%3|%1<%2-%3)")
        end
        do
            stream = gsub(stream, "!([a-z_%.]+)%.cooldown%.up", "%1.cooldown.down")
        end
        do
            stream = gsub(stream, "!talent%.([a-z_%.]+)%.enabled", "talent.%1.disabled")
        end
        do
            stream = gsub(stream, "sim.target", "sim_target")
        end
        local tokenStream = __imports.OvaleLexer("SimulationCraft", stream, tokenMatches)
        local tokenType, token = tokenStream:peek()
        if  not token then
            self:syntaxError(tokenStream, "Warning: end of stream when parsing Action")
            return nil
        end
        if (tokenType == "keyword" and specialActions[token]) or tokenType == "name" then
            local node
            if sequenceActions[token] then
                node = self:parseSequenceAction(tokenStream, nodeList, annotation, action)
            else
                node = self:parseSimpleAction(tokenStream, nodeList, annotation, action)
            end
            if node then
                node.actionListName = actionListName
            end
            return node
        else
            tokenStream:consume()
            self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing action line '%s'; name or special action expected.", token, action)
            return nil
        end
    end,
    parseSimpleAction = function(self, tokenStream, nodeList, annotation, action)
        local tokenType, token = tokenStream:consume()
        if token then
            local name = token
            local modifiers = childrenPool:get()
            tokenType, token = tokenStream:peek()
            while tokenType == "," do
                tokenStream:consume()
                local modifier, expressionNode = self:parseModifier(tokenStream, nodeList, annotation)
                if modifier and expressionNode then
                    modifiers[modifier] = expressionNode
                    tokenType, token = tokenStream:peek()
                else
                    self:syntaxError(tokenStream, "Warning: missing modifier when parsing simple action '%s' in '%s'.", name, action)
                    childrenPool:release(modifiers)
                    return nil
                end
            end
            local node = newNode(nodeList)
            node.type = "action"
            node.action = action
            node.name = name
            node.modifiers = modifiers
            annotation.sync = annotation.sync or {}
            annotation.sync[name] = annotation.sync[name] or node
            return node
        end
        return nil
    end,
    parseSequenceAction = function(self, tokenStream, nodeList, annotation, action)
        local tokenType, token = tokenStream:peek()
        if  not (token and sequenceActions[token]) then
            tokenStream:consume()
            self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing sequence; 'sequence' or 'strict_sequence' expected.", token)
            return nil
        end
        local sequenceNode = self:parseSimpleAction(tokenStream, nodeList, annotation, action)
        if sequenceNode then
            tokenType, token = tokenStream:peek()
            if tokenType ~= ":" then
                tokenStream:consume()
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing sequence; ':' expected.", token)
                return nil
            end
            local sequence = childrenPool:get()
            while token == ":" do
                tokenStream:consume()
                local node = self:parseSimpleAction(tokenStream, nodeList, annotation, action)
                if  not node then
                    self:syntaxError(tokenStream, "Warning: missing simple action when parsing sequence action '%s'.", action)
                    childrenPool:release(sequence)
                    return nil
                end
                insert(sequence, node)
                tokenType, token = tokenStream:peek()
            end
            sequenceNode.sequence = sequence
            return sequenceNode
        end
        return nil
    end,
    parseExpression = function(self, tokenStream, nodeList, annotation, minPrecedence)
        minPrecedence = minPrecedence or 0
        local node
        local targetIf
        local tokenType, token = tokenStream:peek()
        if  not tokenType then
            return nil
        end
        if targetIfKeywords[token] then
            local tokenType2 = tokenStream:peek(2)
            if tokenType2 == ":" then
                targetIf = token
                tokenStream:consume()
                tokenStream:consume()
                tokenType, token = tokenStream:peek()
            end
        end
        local opInfo = unaryOperators[token]
        if opInfo then
            local opType, precedence = opInfo[1], opInfo[2]
            local asType = (opType == "logical" and "boolean") or "value"
            tokenStream:consume()
            local operator = token
            local rhsNode = self:parseExpression(tokenStream, nodeList, annotation, precedence)
            if rhsNode == nil then
                return nil
            end
            if operator == "-" and rhsNode.type == "number" then
                rhsNode.value = -1 * rhsNode.value
                node = rhsNode
            else
                node = newNodeWithChild(nodeList)
                node.type = "operator"
                node.operatorType = opType
                node.expressionType = "unary"
                node.operator = operator
                node.precedence = precedence
                node.child[1] = rhsNode
                rhsNode.asType = asType
            end
        else
            local n = self:parseSimpleExpression(tokenStream, nodeList, annotation)
            if  not n then
                return nil
            end
            node = n
            node.asType = "boolean"
        end
        while true do
            local keepScanning = false
            local tokenType, token = tokenStream:peek()
            if  not tokenType then
                break
            end
            local opInfo = binaryOperators[token]
            if opInfo then
                local opType, precedence = opInfo[1], opInfo[2]
                local asType = (opType == "logical" and "boolean") or "value"
                if precedence and precedence > minPrecedence then
                    keepScanning = true
                    tokenStream:consume()
                    local operator = token
                    local lhsNode = node
                    local rhsNode = self:parseExpression(tokenStream, nodeList, annotation, precedence)
                    if  not rhsNode then
                        return nil
                    end
                    node = newNodeWithChild(nodeList)
                    node.type = "operator"
                    node.operatorType = opType
                    node.expressionType = "binary"
                    node.operator = operator
                    node.precedence = precedence
                    node.child[1] = lhsNode
                    node.child[2] = rhsNode
                    lhsNode.asType = asType
                    if  not rhsNode then
                        self:syntaxError(tokenStream, "Internal error: no right operand in binary operator %s.", token)
                        return nil
                    end
                    rhsNode.asType = asType
                    while node.type == rhsNode.type and node.operator == rhsNode.operator and binaryOperators[node.operator][3] == "associative" and rhsNode.expressionType == "binary" do
                        node.child[2] = rhsNode.child[1]
                        rhsNode.child[1] = node
                        node = rhsNode
                        rhsNode = node.child[2]
                    end
                end
            elseif  not node then
                self:syntaxError(tokenStream, "Syntax error: %s of type %s is not a binary operator", token, tokenType)
                return nil
            end
            if  not keepScanning then
                break
            end
        end
        node.targetIf = targetIf
        return node
    end,
    parseFunction = function(self, tokenStream, nodeList, annotation)
        local name
        local tokenType, token = tokenStream:consume()
        if  not token then
            self:syntaxError(tokenStream, "Warning: end of stream when parsing Function")
            return nil
        end
        if tokenType == "keyword" and functionKeywords[token] then
            name = token
        else
            self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing FUNCTION; name expected.", token)
            return nil
        end
        tokenType, token = tokenStream:consume()
        if tokenType ~= "(" then
            self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing FUNCTION; '(' expected.", token)
            return nil
        end
        local argumentNode = self:parseExpression(tokenStream, nodeList, annotation)
        if  not argumentNode then
            return nil
        end
        tokenType, token = tokenStream:consume()
        if tokenType ~= ")" then
            self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing FUNCTION; ')' expected.", token)
            return nil
        end
        local node = newNodeWithChild(nodeList)
        node.type = "function"
        node.name = name
        node.child[1] = argumentNode
        return node
    end,
    parseIdentifier = function(self, tokenStream, nodeList, annotation)
        local _, token = tokenStream:consume()
        if  not token then
            self:syntaxError(tokenStream, "Warning: end of stream when parsing Identifier")
            return nil
        end
        local node = newNode(nodeList)
        node.type = "operand"
        node.name = token
        annotation.operand = annotation.operand or {}
        annotation.operand[#annotation.operand + 1] = node
        return node
    end,
    parseModifier = function(self, tokenStream, nodeList, annotation)
        local name
        local tokenType, token = tokenStream:consume()
        if tokenType == "keyword" and checkToken(modifierKeywords, token) then
            name = token
        else
            self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing action line; expression keyword expected.", token)
            return 
        end
        tokenType, token = tokenStream:consume()
        if tokenType ~= "=" then
            self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing action line; '=' expected.", token)
            return 
        end
        local expressionNode
        if litteralModifiers[name] then
            expressionNode = self:parseIdentifier(tokenStream, nodeList, annotation)
        else
            expressionNode = self:parseExpression(tokenStream, nodeList, annotation)
            if expressionNode and name == "sec" then
                expressionNode.asType = "value"
            end
        end
        return name, expressionNode
    end,
    parseNumber = function(self, tokenStream, nodeList)
        local value
        local tokenType, token = tokenStream:consume()
        if tokenType == "number" then
            value = tonumber(token)
        else
            self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing NUMBER; number expected.", token)
            return nil
        end
        local node = newNode(nodeList)
        node.type = "number"
        node.value = value
        return node
    end,
    parseOperand = function(self, tokenStream, nodeList, annotation)
        local name
        local tokenType, token = tokenStream:consume()
        if  not token then
            self:syntaxError(tokenStream, "Warning: end of stream when parsing OPERAND")
            return nil
        end
        if tokenType == "name" then
            name = token
        elseif tokenType == "keyword" and (token == "target" or token == "cooldown") then
            name = token
        else
            self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing OPERAND; operand expected.", token)
            return nil
        end
        local node = newNode(nodeList)
        node.type = "operand"
        node.name = name
        node.rune = runeOperands[name]
        if node.rune then
            local firstCharacter = sub(name, 1, 1)
            node.includeDeath = firstCharacter == "B" or firstCharacter == "F" or firstCharacter == "U"
        end
        annotation.operand = annotation.operand or {}
        annotation.operand[#annotation.operand + 1] = node
        return node
    end,
    parseParentheses = function(self, tokenStream, nodeList, annotation)
        local leftToken, rightToken
        local tokenType, token = tokenStream:consume()
        if tokenType == "(" then
            leftToken, rightToken = "(", ")"
        elseif tokenType == "{" then
            leftToken, rightToken = "{", "}"
        else
            self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing PARENTHESES; '(' or '{' expected.", token)
            return nil
        end
        local node = self:parseExpression(tokenStream, nodeList, annotation)
        if  not node then
            return nil
        end
        tokenType, token = tokenStream:consume()
        if tokenType ~= rightToken then
            self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing PARENTHESES; '%s' expected.", token, rightToken)
            return nil
        end
        node.left = leftToken
        node.right = rightToken
        return node
    end,
    parseSimpleExpression = function(self, tokenStream, nodeList, annotation)
        local node
        local tokenType, token = tokenStream:peek()
        if  not token then
            self:syntaxError(tokenStream, "Warning: end of stream when parsing SIMPLE EXPRESSION")
            return nil
        end
        if tokenType == "number" then
            node = self:parseNumber(tokenStream, nodeList)
        elseif tokenType == "keyword" then
            if functionKeywords[token] then
                node = self:parseFunction(tokenStream, nodeList, annotation)
            elseif token == "target" or token == "cooldown" then
                node = self:parseOperand(tokenStream, nodeList, annotation)
            else
                self:syntaxError(tokenStream, "Warning: unknown keyword %s when parsing SIMPLE EXPRESSION", token)
                return nil
            end
        elseif tokenType == "name" then
            node = self:parseOperand(tokenStream, nodeList, annotation)
        elseif tokenType == "(" then
            node = self:parseParentheses(tokenStream, nodeList, annotation)
        else
            self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing SIMPLE EXPRESSION", token)
            tokenStream:consume()
            return nil
        end
        return node
    end,
})
