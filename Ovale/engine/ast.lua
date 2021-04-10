local __exports = LibStub:NewLibrary("ovale/engine/ast", 90048)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __uiLocalization = LibStub:GetLibrary("ovale/ui/Localization")
local l = __uiLocalization.l
local __toolsPool = LibStub:GetLibrary("ovale/tools/Pool")
local OvalePool = __toolsPool.OvalePool
local __condition = LibStub:GetLibrary("ovale/engine/condition")
local getFunctionSignature = __condition.getFunctionSignature
local __lexer = LibStub:GetLibrary("ovale/engine/lexer")
local OvaleLexer = __lexer.OvaleLexer
local ipairs = ipairs
local next = next
local pairs = pairs
local tonumber = tonumber
local tostring = tostring
local type = type
local wipe = wipe
local kpairs = pairs
local format = string.format
local gsub = string.gsub
local lower = string.lower
local sub = string.sub
local concat = table.concat
local insert = table.insert
local sort = table.sort
local GetItemInfo = GetItemInfo
local __toolstools = LibStub:GetLibrary("ovale/tools/tools")
local checkToken = __toolstools.checkToken
local isNumber = __toolstools.isNumber
local __toolsTimeSpan = LibStub:GetLibrary("ovale/tools/TimeSpan")
local emptySet = __toolsTimeSpan.emptySet
local newTimeSpan = __toolsTimeSpan.newTimeSpan
local universe = __toolsTimeSpan.universe
local keywords = {
    ["and"] = true,
    ["if"] = true,
    ["not"] = true,
    ["or"] = true,
    ["unless"] = true,
    ["true"] = true,
    ["false"] = true
}
local declarationKeywords = {
    ["addactionicon"] = true,
    ["addcheckbox"] = true,
    ["addfunction"] = true,
    ["addicon"] = true,
    ["addlistitem"] = true,
    ["define"] = true,
    ["include"] = true,
    ["iteminfo"] = true,
    ["itemrequire"] = true,
    ["itemlist"] = true,
    ["scorespells"] = true,
    ["spellinfo"] = true,
    ["spelllist"] = true,
    ["spellrequire"] = true
}
local spellAuraKewords = {
    ["spelladdbuff"] = true,
    ["spelladddebuff"] = true,
    ["spelladdpetbuff"] = true,
    ["spelladdpetdebuff"] = true,
    ["spelladdtargetbuff"] = true,
    ["spelladdtargetdebuff"] = true,
    ["spelldamagebuff"] = true,
    ["spelldamagedebuff"] = true
}
__exports.checkSpellInfo = {
    add_cd = true,
    add_duration = true,
    add_duration_combopoints = true,
    alternate = true,
    arcanecharges = true,
    base = true,
    bonusap = true,
    bonusapcp = true,
    bonuscp = true,
    bonusmainhand = true,
    bonusoffhand = true,
    bonussp = true,
    buff_cd = true,
    buff_cdr = true,
    buff_totem = true,
    canStopChannelling = true,
    casttime = true,
    cd = true,
    cd_haste = true,
    channel = true,
    charge_cd = true,
    chi = true,
    combopoints = true,
    damage = true,
    duration = true,
    effect = true,
    energy = true,
    focus = true,
    forcecd = true,
    fury = true,
    gcd = true,
    gcd_haste = true,
    half_duration = true,
    haste = true,
    health = true,
    holypower = true,
    icd = true,
    inccounter = true,
    insanity = true,
    interrupt = true,
    lunarpower = true,
    maelstrom = true,
    mana = true,
    max_stacks = true,
    max_totems = true,
    max_travel_time = true,
    offgcd = true,
    pain = true,
    physical = true,
    rage = true,
    replaced_by = true,
    resetcounter = true,
    rppm = true,
    runes = true,
    runicpower = true,
    shared_cd = true,
    soulshards = true,
    stacking = true,
    tag = true,
    texture = true,
    tick = true,
    to_stance = true,
    totem = true,
    travel_time = true,
    unusable = true,
    addlist = true,
    dummy_replace = true,
    learn = true,
    pertrait = true,
    proc = true,
    max_alternate = true,
    max_arcanecharges = true,
    max_chi = true,
    max_combopoints = true,
    max_energy = true,
    max_focus = true,
    max_fury = true,
    max_holypower = true,
    max_insanity = true,
    max_lunarpower = true,
    max_maelstrom = true,
    max_mana = true,
    max_pain = true,
    max_rage = true,
    max_runicpower = true,
    max_soulshards = true,
    refund_alternate = true,
    refund_arcanecharges = true,
    refund_chi = true,
    refund_combopoints = true,
    refund_energy = true,
    refund_focus = true,
    refund_fury = true,
    refund_holypower = true,
    refund_insanity = true,
    refund_lunarpower = true,
    refund_maelstrom = true,
    refund_mana = true,
    refund_pain = true,
    refund_rage = true,
    refund_runicpower = true,
    refund_soulshards = true,
    set_alternate = true,
    set_arcanecharges = true,
    set_chi = true,
    set_combopoints = true,
    set_energy = true,
    set_focus = true,
    set_fury = true,
    set_holypower = true,
    set_insanity = true,
    set_lunarpower = true,
    set_maelstrom = true,
    set_mana = true,
    set_pain = true,
    set_rage = true,
    set_runicpower = true,
    set_soulshards = true
}
do
    for keyword, value in pairs(spellAuraKewords) do
        declarationKeywords[keyword] = value
    end
    for keyword, value in pairs(declarationKeywords) do
        keywords[keyword] = value
    end
end
local checkActionType = {
    item = true,
    macro = true,
    setstate = true,
    spell = true,
    texture = true,
    value = true
}
local actionParameterCounts = {
    ["item"] = 1,
    ["macro"] = 1,
    ["spell"] = 1,
    ["texture"] = 1,
    ["setstate"] = 2,
    value = 1
}
local stateActions = {
    ["setstate"] = true
}
local stringLookupFunctions = {
    ["itemname"] = true,
    ["l"] = true,
    ["spellname"] = true
}
local unaryOperators = {
    ["not"] = {
        [1] = "logical",
        [2] = 15
    },
    ["-"] = {
        [1] = "arithmetic",
        [2] = 50
    }
}
local binaryOperators = {
    ["or"] = {
        [1] = "logical",
        [2] = 5,
        [3] = "associative"
    },
    ["xor"] = {
        [1] = "logical",
        [2] = 8,
        [3] = "associative"
    },
    ["and"] = {
        [1] = "logical",
        [2] = 10,
        [3] = "associative"
    },
    ["!="] = {
        [1] = "compare",
        [2] = 20
    },
    ["<"] = {
        [1] = "compare",
        [2] = 20
    },
    ["<="] = {
        [1] = "compare",
        [2] = 20
    },
    ["=="] = {
        [1] = "compare",
        [2] = 20
    },
    [">"] = {
        [1] = "compare",
        [2] = 20
    },
    [">="] = {
        [1] = "compare",
        [2] = 20
    },
    ["+"] = {
        [1] = "arithmetic",
        [2] = 30,
        [3] = "associative"
    },
    ["-"] = {
        [1] = "arithmetic",
        [2] = 30
    },
    ["%"] = {
        [1] = "arithmetic",
        [2] = 40
    },
    ["*"] = {
        [1] = "arithmetic",
        [2] = 40,
        [3] = "associative"
    },
    ["/"] = {
        [1] = "arithmetic",
        [2] = 40
    },
    ["^"] = {
        [1] = "arithmetic",
        [2] = 100
    },
    [">?"] = {
        [1] = "arithmetic",
        [2] = 25
    },
    ["<?"] = {
        [1] = "arithmetic",
        [2] = 25
    }
}
local indent = {}
indent[0] = ""
local function indentation(key)
    local ret = indent[key]
    if ret == nil then
        ret = indentation(key - 1) .. " "
        indent[key] = ret
    end
    return ret
end
__exports.setResultType = function(result, type)
    result.type = type
end
__exports.isAstNodeWithChildren = function(node)
    return node.child ~= nil
end
local checkCheckBoxParameters = {
    enabled = true
}
local spellAuraListParametersCheck = {
    enabled = true,
    add = true,
    set = true,
    extend = true,
    refresh = true,
    refresh_keep_snapshot = true,
    toggle = true
}
local checkSpellRequireParameters = {
    add = true,
    percent = true,
    set = true,
    enabled = true
}
local checkAddFunctionParameters = {
    help = true
}
local checkListParameters = {
    enabled = true
}
local iconParametersCheck = {
    enemies = true,
    target = true,
    size = true,
    type = true,
    help = true,
    text = true,
    flash = true,
    enabled = true
}
local checkListItemParameters = {
    enabled = true
}
local function isExpressionNode(node)
    return (node.type == "logical" or node.type == "arithmetic" or node.type == "compare" or node.type == "expression")
end
local checkFunctionParameters = {
    filter = true,
    target = true,
    count = true,
    excludeTarget = true,
    haste = true,
    max = true,
    name = true,
    stacks = true,
    tagged = true,
    unlimited = true,
    usable = true,
    any = true,
    value = true
}
local checkActionParameters = {
    flash = true,
    help = true,
    nored = true,
    pool_resource = true,
    sound = true,
    soundtime = true,
    text = true,
    wait = true,
    target = true,
    usable = true,
    offgcd = true,
    extra_energy = true,
    extra_focus = true,
    texture = true
}
local tokenizeComment = function(token)
    return "comment", token
end

local tokenizeName = function(token)
    token = lower(token)
    if keywords[token] then
        return "keyword", token
    else
        return "name", token
    end
end

local tokenizeNumber = function(token)
    return "number", token
end

local tokenizeString = function(token)
    token = sub(token, 2, -2)
    return "string", token
end

local tokenizeWhitespace = function(token)
    return "space", token
end

local tokenize = function(token)
    return token, token
end

local noToken = function()
    return nil, nil
end

local tokenMatches = {
    [1] = {
        [1] = "^%s+",
        [2] = tokenizeWhitespace
    },
    [2] = {
        [1] = "^%d+%.?%d*",
        [2] = tokenizeNumber
    },
    [3] = {
        [1] = "^[%a_][%w_]*",
        [2] = tokenizeName
    },
    [4] = {
        [1] = "^((['\"])%2)",
        [2] = tokenizeString
    },
    [5] = {
        [1] = [[^(['"]).-\%1]],
        [2] = tokenizeString
    },
    [6] = {
        [1] = [[^(['\"]).-[^\]%1]],
        [2] = tokenizeString
    },
    [7] = {
        [1] = "^#.-\n",
        [2] = tokenizeComment
    },
    [8] = {
        [1] = "^!=",
        [2] = tokenize
    },
    [9] = {
        [1] = "^==",
        [2] = tokenize
    },
    [10] = {
        [1] = "^<=",
        [2] = tokenize
    },
    [11] = {
        [1] = "^>=",
        [2] = tokenize
    },
    [12] = {
        [1] = "^>%?",
        [2] = tokenize
    },
    [13] = {
        [1] = "^<%?",
        [2] = tokenize
    },
    [14] = {
        [1] = "^.",
        [2] = tokenize
    },
    [15] = {
        [1] = "^$",
        [2] = noToken
    }
}
local lexerFilters = {
    comments = tokenizeComment,
    space = tokenizeWhitespace
}
local SelfPool = __class(OvalePool, {
    constructor = function(self, ovaleAst)
        self.ovaleAst = ovaleAst
        OvalePool.constructor(self, "OvaleAST_pool")
    end,
    clean = function(self, node)
        if __exports.isAstNodeWithChildren(node) then
            self.ovaleAst.childrenPool:release(node.child)
        end
        if node.postOrder then
            self.ovaleAst.postOrderPool:release(node.postOrder)
        end
        wipe(node)
    end,
})
local function isAstNode(a)
    return type(a) == "table"
end
__exports.OvaleASTClass = __class(nil, {
    constructor = function(self, ovaleCondition, ovaleDebug, ovaleProfiler, ovaleScripts, ovaleSpellBook)
        self.ovaleCondition = ovaleCondition
        self.ovaleScripts = ovaleScripts
        self.ovaleSpellBook = ovaleSpellBook
        self.indent = 0
        self.outputPool = OvalePool("OvaleAST_outputPool")
        self.listPool = OvalePool("OvaleAST_listPool")
        self.checkboxPool = OvalePool("OvaleAST_checkboxPool")
        self.positionalParametersPool = OvalePool("OvaleAST_FlattenParameterValues")
        self.rawNamedParametersPool = OvalePool("OvaleAST_rawNamedParametersPool")
        self.rawPositionalParametersPool = OvalePool("OVALEAST_rawPositionParametersPool")
        self.namedParametersPool = OvalePool("OvaleAST_FlattenParametersPool")
        self.childrenPool = OvalePool("OvaleAST_childrenPool")
        self.postOrderPool = OvalePool("OvaleAST_postOrderPool")
        self.postOrderVisitedPool = OvalePool("OvaleAST_postOrderVisitedPool")
        self.nodesPool = SelfPool(self)
        self.unparseAddCheckBox = function(node)
            local s
            if (node.rawPositionalParams and next(node.rawPositionalParams)) or (node.rawNamedParams and next(node.rawNamedParams)) then
                s = format("AddCheckBox(%s %s %s)", node.name, self:unparse(node.description), self:unparseParameters(node.rawPositionalParams, node.rawNamedParams))
            else
                s = format("AddCheckBox(%s %s)", node.name, self:unparse(node.description))
            end
            return s
        end
        self.unparseAddFunction = function(node)
            local s
            if self:hasParameters(node) then
                s = format("AddFunction %s %s%s", node.name, self:unparseParameters(node.rawPositionalParams, node.rawNamedParams), self.unparseGroup(node.body))
            else
                s = format("AddFunction %s%s", node.name, self.unparseGroup(node.body))
            end
            return s
        end
        self.unparseAddIcon = function(node)
            local s
            if self:hasParameters(node) then
                s = format("AddIcon %s%s", self:unparseParameters(node.rawPositionalParams, node.rawNamedParams), self.unparseGroup(node.body))
            else
                s = format("AddIcon%s", self.unparseGroup(node.body))
            end
            return s
        end
        self.unparseAddListItem = function(node)
            local s
            if self:hasParameters(node) then
                s = format("AddListItem(%s %s %s %s)", node.name, node.item, self:unparse(node.description), self:unparseParameters(node.rawPositionalParams, node.rawNamedParams))
            else
                s = format("AddListItem(%s %s %s)", node.name, node.item, self:unparse(node.description))
            end
            return s
        end
        self.unparseBangValue = function(node)
            return "!" .. self:unparse(node.child[1])
        end
        self.unparseBoolean = function(node)
            return (node.value and "true") or "false"
        end
        self.unparseComment = function(node)
            if  not node.comment or node.comment == "" then
                return ""
            else
                return "#" .. node.comment
            end
        end
        self.unparseDefine = function(node)
            return format("Define(%s %s)", node.name, node.value)
        end
        self.unparseExpression = function(node)
            local expression
            local precedence = self:getPrecedence(node)
            if node.expressionType == "unary" then
                local rhsExpression
                local rhsNode = node.child[1]
                local rhsPrecedence = self:getPrecedence(rhsNode)
                if rhsPrecedence and precedence >= rhsPrecedence then
                    rhsExpression = "{ " .. self:unparse(rhsNode) .. " }"
                else
                    rhsExpression = self:unparse(rhsNode)
                end
                if node.operator == "-" then
                    expression = "-" .. rhsExpression
                else
                    expression = node.operator .. " " .. rhsExpression
                end
            elseif node.expressionType == "binary" then
                local lhsExpression, rhsExpression
                local lhsNode = node.child[1]
                local lhsPrecedence = self:getPrecedence(lhsNode)
                if lhsPrecedence and lhsPrecedence < precedence then
                    lhsExpression = "{ " .. self:unparse(lhsNode) .. " }"
                else
                    lhsExpression = self:unparse(lhsNode)
                end
                local rhsNode = node.child[2]
                local rhsPrecedence = self:getPrecedence(rhsNode)
                if rhsPrecedence and precedence > rhsPrecedence then
                    rhsExpression = "{ " .. self:unparse(rhsNode) .. " }"
                elseif rhsPrecedence and precedence == rhsPrecedence then
                    local operatorInfo = binaryOperators[node.operator]
                    if operatorInfo and operatorInfo[3] == "associative" and rhsNode.type == "expression" and node.operator == rhsNode.operator then
                        rhsExpression = self:unparse(rhsNode)
                    else
                        rhsExpression = "{ " .. self:unparse(rhsNode) .. " }"
                    end
                else
                    rhsExpression = self:unparse(rhsNode)
                end
                expression = lhsExpression .. " " .. node.operator .. " " .. rhsExpression
            else
                self.debug:error("node.expressionType '" .. node.expressionType .. "' is not known")
                return "Not_Unparsable"
            end
            return expression
        end
        self.unparseAction = function(node)
            return format("%s(%s)", node.name, self:unparseParameters(node.rawPositionalParams, node.rawNamedParams, true))
        end
        self.unparseFunction = function(node)
            local s
            if self:hasParameters(node) then
                local name
                local filter = node.rawNamedParams.filter
                if filter and self:unparse(filter) == "debuff" then
                    name = gsub(node.name, "^Buff", "Debuff")
                else
                    name = node.name
                end
                local target = node.rawNamedParams.target
                if target and target.type == "string" then
                    s = format("%s.%s(%s)", target.value, name, self:unparseParameters(node.rawPositionalParams, node.rawNamedParams, true, true))
                else
                    s = format("%s(%s)", name, self:unparseParameters(node.rawPositionalParams, node.rawNamedParams, true))
                end
            else
                s = format("%s()", node.name)
            end
            return s
        end
        self.unparseUndefined = function()
            return "undefined"
        end
        self.unparseTypedFunction = function(node)
            local s
            if self:hasParameters(node) then
                s = node.name .. "("
                if node.rawNamedParams.target and node.rawNamedParams.target.type == "string" then
                    s = node.rawNamedParams.target.value .. "." .. s
                end
                local infos = self.ovaleCondition:getInfos(node.name)
                if infos then
                    local nameParameters = false
                    local first = true
                    for k, v in ipairs(infos.parameters) do
                        local value = node.rawPositionalParams[k]
                        if value and value.type ~= "undefined" then
                            if v.name == "filter" or v.name == "target" or (v.defaultValue ~= nil and ((v.type == "boolean" and value.type == "boolean" and value.value == v.defaultValue) or (v.type == "number" and value.type == "value" and value.value == v.defaultValue) or (v.type == "string" and value.type == "string" and value.value == v.defaultValue))) then
                                nameParameters = true
                            else
                                if first then
                                    first = false
                                else
                                    s = s .. " "
                                end
                                if nameParameters then
                                    s = s .. (v.name .. "=")
                                end
                                s = s .. self:unparseParameter(value)
                            end
                        else
                            nameParameters = true
                        end
                    end
                end
                s = s .. ")"
            else
                s = format("%s()", node.name)
            end
            return s
        end
        self.unparseGroup = function(node)
            local output = self.outputPool:get()
            output[#output + 1] = ""
            output[#output + 1] = indentation(self.indent) .. "{"
            self.indent = self.indent + 1
            for _, statementNode in ipairs(node.child) do
                local s = self:unparse(statementNode)
                if s == "" then
                    output[#output + 1] = s
                else
                    output[#output + 1] = indentation(self.indent) .. s
                end
            end
            self.indent = self.indent - 1
            output[#output + 1] = indentation(self.indent) .. "}"
            local outputString = concat(output, "\n")
            self.outputPool:release(output)
            return outputString
        end
        self.unparseIf = function(node)
            if node.child[2].type == "group" then
                return format("if %s%s", self:unparse(node.child[1]), self.unparseGroup(node.child[2]))
            else
                return format("if %s %s", self:unparse(node.child[1]), self:unparse(node.child[2]))
            end
        end
        self.unparseItemInfo = function(node)
            local identifier = (node.name and node.name) or node.itemId
            return format("ItemInfo(%s %s)", identifier, self:unparseParameters(node.rawPositionalParams, node.rawNamedParams))
        end
        self.unparseItemRequire = function(node)
            local identifier = (node.name and node.name) or node.itemId
            return format("ItemRequire(%s %s %s)", identifier, node.property, self:unparseParameters(node.rawPositionalParams, node.rawNamedParams))
        end
        self.unparseList = function(node)
            return format("%s(%s %s)", node.keyword, node.name, self:unparseParameters(node.rawPositionalParams, node.rawNamedParams))
        end
        self.unparseValue = function(node)
            if node.name then
                return node.name
            end
            return tostring(node.value)
        end
        self.unparseScoreSpells = function(node)
            return format("ScoreSpells(%s)", self:unparseParameters(node.rawPositionalParams, node.rawNamedParams))
        end
        self.unparseScript = function(node)
            local output = self.outputPool:get()
            local previousDeclarationType
            for _, declarationNode in ipairs(node.child) do
                if declarationNode.type == "item_info" or declarationNode.type == "spell_aura_list" or declarationNode.type == "spell_info" or declarationNode.type == "spell_require" then
                    local s = self:unparse(declarationNode)
                    if s == "" then
                        output[#output + 1] = s
                    else
                        output[#output + 1] = indentation(self.indent + 1) .. s
                    end
                else
                    local insertBlank = false
                    if previousDeclarationType and previousDeclarationType ~= declarationNode.type then
                        insertBlank = true
                    end
                    if declarationNode.type == "add_function" or declarationNode.type == "icon" then
                        insertBlank = true
                    end
                    if insertBlank then
                        output[#output + 1] = ""
                    end
                    output[#output + 1] = self:unparse(declarationNode)
                    previousDeclarationType = declarationNode.type
                end
            end
            local outputString = concat(output, "\n")
            self.outputPool:release(output)
            return outputString
        end
        self.unparseSpellAuraList = function(node)
            local identifier = node.name or node.spellId
            local buffName = node.buffName or node.buffSpellId
            return format("%s(%s %s %s)", node.keyword, identifier, buffName, self:unparseParameters(node.rawPositionalParams, node.rawNamedParams))
        end
        self.unparseSpellInfo = function(node)
            local identifier = (node.name and node.name) or node.spellId
            return format("SpellInfo(%s %s)", identifier, self:unparseParameters(node.rawPositionalParams, node.rawNamedParams))
        end
        self.unparseSpellRequire = function(node)
            local identifier = (node.name and node.name) or node.spellId
            return format("SpellRequire(%s %s %s)", identifier, node.property, self:unparseParameters(node.rawPositionalParams, node.rawNamedParams))
        end
        self.unparseString = function(node)
            if node.name then
                if node.func then
                    return node.func .. "(" .. node.name .. ")"
                end
                return node.name
            end
            return "\"" .. node.value .. "\""
        end
        self.unparseUnless = function(node)
            if node.child[2].type == "group" then
                return format("unless %s%s", self:unparse(node.child[1]), self.unparseGroup(node.child[2]))
            else
                return format("unless %s %s", self:unparse(node.child[1]), self:unparse(node.child[2]))
            end
        end
        self.unparseVariable = function(node)
            return node.name
        end
        self.unparseVisitors = {
            ["action"] = self.unparseAction,
            ["add_function"] = self.unparseAddFunction,
            ["arithmetic"] = self.unparseExpression,
            ["bang_value"] = self.unparseBangValue,
            ["boolean"] = self.unparseBoolean,
            ["checkbox"] = self.unparseAddCheckBox,
            ["compare"] = self.unparseExpression,
            ["comment"] = self.unparseComment,
            ["custom_function"] = self.unparseFunction,
            ["define"] = self.unparseDefine,
            ["function"] = self.unparseFunction,
            ["group"] = self.unparseGroup,
            ["icon"] = self.unparseAddIcon,
            ["if"] = self.unparseIf,
            ["item_info"] = self.unparseItemInfo,
            ["itemrequire"] = self.unparseItemRequire,
            ["list"] = self.unparseList,
            ["list_item"] = self.unparseAddListItem,
            ["logical"] = self.unparseExpression,
            ["score_spells"] = self.unparseScoreSpells,
            ["script"] = self.unparseScript,
            ["spell_aura_list"] = self.unparseSpellAuraList,
            ["spell_info"] = self.unparseSpellInfo,
            ["spell_require"] = self.unparseSpellRequire,
            ["state"] = self.unparseFunction,
            ["string"] = self.unparseString,
            ["typed_function"] = self.unparseTypedFunction,
            ["undefined"] = self.unparseUndefined,
            ["unless"] = self.unparseUnless,
            ["value"] = self.unparseValue,
            ["variable"] = self.unparseVariable
        }
        self.parseAddCheckBox = function(tokenStream, annotation)
            local tokenType, token = tokenStream:consume()
            if  not (tokenType == "keyword" and token == "addcheckbox") then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing ADDCHECKBOX; 'AddCheckBox' expected.", token)
                return nil
            end
            tokenType, token = tokenStream:consume()
            if tokenType ~= "(" then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing ADDCHECKBOX; '(' expected.", token)
                return nil
            end
            local name = ""
            tokenType, token = tokenStream:consume()
            if tokenType == "name" and token ~= nil then
                name = token
            else
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing ADDCHECKBOX; name expected.", token)
                return nil
            end
            local descriptionNode = self.parseString(tokenStream, annotation)
            if  not descriptionNode then
                return nil
            end
            local positionalParams, namedParams = self:parseParameters(tokenStream, "ParseAddCheckBox", annotation, 1, checkCheckBoxParameters)
            if  not positionalParams or  not namedParams then
                return nil
            end
            tokenType, token = tokenStream:consume()
            if tokenType ~= ")" then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing ADDCHECKBOX; ')' expected.", token)
                return nil
            end
            local node = self:newNodeWithParameters("checkbox", annotation, positionalParams, namedParams)
            node.name = name
            node.description = descriptionNode
            return node
        end
        self.parseAddFunction = function(tokenStream, annotation)
            local tokenType, token = tokenStream:consume()
            if  not (tokenType == "keyword" and token == "addfunction") then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing ADDFUNCTION; 'AddFunction' expected.", token)
                return nil
            end
            local name
            tokenType, token = tokenStream:consume()
            if tokenType == "name" and token then
                name = token
            else
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing ADDFUNCTION; name expected.", token)
                return nil
            end
            local positionalParams, namedParams = self:parseParameters(tokenStream, "ParseAddFunction", annotation, 0, checkAddFunctionParameters)
            if  not positionalParams or  not namedParams then
                return nil
            end
            local bodyNode = self.innerParseGroup(tokenStream, annotation)
            if  not bodyNode then
                return nil
            end
            local node = self:newNodeWithBodyAndParameters("add_function", annotation, bodyNode, positionalParams, namedParams)
            node.name = name
            annotation.parametersReference = annotation.parametersReference or {}
            annotation.parametersReference[#annotation.parametersReference + 1] = node
            annotation.postOrderReference = annotation.postOrderReference or {}
            annotation.postOrderReference[#annotation.postOrderReference + 1] = bodyNode
            annotation.customFunction = annotation.customFunction or {}
            annotation.customFunction[name] = node
            return node
        end
        self.parseAddIcon = function(tokenStream, annotation)
            local tokenType, token = tokenStream:consume()
            if  not (tokenType == "keyword" and token == "addicon") then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing ADDICON; 'AddIcon' expected.", token)
                return nil
            end
            local positionalParams, namedParams = self:parseParameters(tokenStream, "addicon", annotation, 0, iconParametersCheck)
            if  not positionalParams or  not namedParams then
                return nil
            end
            local bodyNode = self.innerParseGroup(tokenStream, annotation)
            if  not bodyNode then
                return nil
            end
            local node = self:newNodeWithBodyAndParameters("icon", annotation, bodyNode, positionalParams, namedParams)
            annotation.postOrderReference = annotation.postOrderReference or {}
            annotation.postOrderReference[#annotation.postOrderReference + 1] = bodyNode
            return node
        end
        self.parseAddListItem = function(tokenStream, annotation)
            local tokenType, token = tokenStream:consume()
            if  not (tokenType == "keyword" and token == "addlistitem") then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing ADDLISTITEM; 'AddListItem' expected.", token)
                return nil
            end
            tokenType, token = tokenStream:consume()
            if tokenType ~= "(" then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing ADDLISTITEM; '(' expected.", token)
                return nil
            end
            local name
            tokenType, token = tokenStream:consume()
            if tokenType == "name" and token then
                name = token
            else
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing ADDLISTITEM; name expected.", token)
                return nil
            end
            local item
            tokenType, token = tokenStream:consume()
            if tokenType == "name" and token then
                item = token
            else
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing ADDLISTITEM; name expected.", token)
                return nil
            end
            local descriptionNode = self.parseString(tokenStream, annotation)
            if  not descriptionNode then
                return nil
            end
            local positionalParams, namedParams = self:parseParameters(tokenStream, "ParseAddListItem", annotation, 1, checkListItemParameters)
            if  not positionalParams or  not namedParams then
                return nil
            end
            tokenType, token = tokenStream:consume()
            if tokenType ~= ")" then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing ADDLISTITEM; ')' expected.", token)
                return nil
            end
            local node = self:newNodeWithParameters("list_item", annotation, positionalParams, namedParams)
            node.name = name
            node.item = item
            node.description = descriptionNode
            return node
        end
        self.parseComment = function()
            return nil
        end
        self.parseDeclaration = function(tokenStream, annotation)
            local node
            local tokenType, token = tokenStream:peek()
            if tokenType == "keyword" and token and declarationKeywords[token] then
                if token == "addcheckbox" then
                    node = self.parseAddCheckBox(tokenStream, annotation)
                elseif token == "addfunction" then
                    node = self.parseAddFunction(tokenStream, annotation)
                elseif token == "addicon" then
                    node = self.parseAddIcon(tokenStream, annotation)
                elseif token == "addlistitem" then
                    node = self.parseAddListItem(tokenStream, annotation)
                elseif token == "define" then
                    node = self.parseDefine(tokenStream, annotation)
                elseif token == "include" then
                    node = self.parseInclude(tokenStream, annotation)
                elseif token == "iteminfo" then
                    node = self.parseItemInfo(tokenStream, annotation)
                elseif token == "itemrequire" then
                    node = self.parseItemRequire(tokenStream, annotation)
                elseif token == "itemlist" then
                    node = self.parseList(tokenStream, annotation)
                elseif token == "scorespells" then
                    node = self.parseScoreSpells(tokenStream, annotation)
                elseif checkToken(spellAuraKewords, token) then
                    node = self.parseSpellAuraList(tokenStream, annotation)
                elseif token == "spellinfo" then
                    node = self.parseSpellInfo(tokenStream, annotation)
                elseif token == "spelllist" then
                    node = self.parseList(tokenStream, annotation)
                elseif token == "spellrequire" then
                    node = self.parseSpellRequire(tokenStream, annotation)
                else
                    self:syntaxError(tokenStream, "Syntax error: unknown keywork '%s'", token)
                    return 
                end
            else
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing DECLARATION; declaration keyword expected.", token)
                tokenStream:consume()
                return nil
            end
            return node
        end
        self.parseDefine = function(tokenStream, annotation)
            local tokenType, token = tokenStream:consume()
            if  not (tokenType == "keyword" and token == "define") then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing DEFINE; 'Define' expected.", token)
                return nil
            end
            tokenType, token = tokenStream:consume()
            if tokenType ~= "(" then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing DEFINE; '(' expected.", token)
                return nil
            end
            local name
            tokenType, token = tokenStream:consume()
            if tokenType == "name" and token then
                name = token
            else
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing DEFINE; name expected.", token)
                return nil
            end
            local value
            tokenType, token = tokenStream:consume()
            if tokenType == "-" then
                tokenType, token = tokenStream:consume()
                if tokenType == "number" then
                    value = -1 * tonumber(token)
                else
                    self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing DEFINE; number expected after '-'.", token)
                    return nil
                end
            elseif tokenType == "number" then
                value = tonumber(token)
            elseif tokenType == "string" and token then
                value = token
            else
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing DEFINE; number or string expected.", token)
                return nil
            end
            tokenType, token = tokenStream:consume()
            if tokenType ~= ")" then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing DEFINE; ')' expected.", token)
                return nil
            end
            local node = self:newNode("define", annotation)
            node.name = name
            node.value = value
            annotation.definition = annotation.definition or {}
            annotation.definition[name] = value
            return node
        end
        self.parseExpression = function(tokenStream, annotation, minPrecedence)
            minPrecedence = minPrecedence or 0
            local node
            local tokenType, token = tokenStream:peek()
            if tokenType then
                local opInfo = unaryOperators[token]
                if opInfo then
                    local opType, precedence = opInfo[1], opInfo[2]
                    tokenStream:consume()
                    local operator = token
                    local rhsNode = self.parseExpression(tokenStream, annotation, precedence)
                    if rhsNode then
                        if operator == "-" and rhsNode.type == "value" then
                            local value = -1 * tonumber(rhsNode.value)
                            node = self:getNumberNode(value, annotation)
                        else
                            node = self:newNodeWithChildren(opType, annotation)
                            node.expressionType = "unary"
                            node.operator = operator
                            node.precedence = precedence
                            node.child[1] = rhsNode
                        end
                    else
                        return nil
                    end
                elseif token == "{" then
                    local expression = self:parseGroup(tokenStream, annotation)
                    if  not expression then
                        return nil
                    end
                    node = expression
                else
                    local simpleExpression = self:parseSimpleExpression(tokenStream, annotation)
                    if  not simpleExpression then
                        return nil
                    end
                    node = simpleExpression
                end
            else
                return nil
            end
            local keepScanning = true
            while keepScanning do
                keepScanning = false
                local tokenType, token = tokenStream:peek()
                if tokenType then
                    local opInfo = binaryOperators[token]
                    if opInfo then
                        local opType, precedence = opInfo[1], opInfo[2]
                        if precedence and precedence > minPrecedence then
                            keepScanning = true
                            tokenStream:consume()
                            local operator = token
                            local lhsNode = node
                            local rhsNode = self.parseExpression(tokenStream, annotation, precedence)
                            if rhsNode then
                                node = self:newNodeWithChildren(opType, annotation)
                                node.expressionType = "binary"
                                node.operator = operator
                                node.precedence = precedence
                                node.child[1] = lhsNode
                                node.child[2] = rhsNode
                                local operatorInfo = binaryOperators[node.operator]
                                if  not operatorInfo then
                                    return nil
                                end
                                while node.type == rhsNode.type and node.operator == rhsNode.operator and operatorInfo[3] == "associative" and rhsNode.expressionType == "binary" do
                                    node.child[2] = rhsNode.child[1]
                                    rhsNode.child[1] = node
                                    node = rhsNode
                                    rhsNode = node.child[2]
                                end
                            else
                                return nil
                            end
                        end
                    end
                end
            end
            return node
        end
        self.parseFunction = function(tokenStream, annotation)
            local name
            do
                local tokenType, token = tokenStream:consume()
                if (tokenType == "name" or tokenType == "keyword") and token then
                    name = token
                else
                    self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing FUNCTION; name expected.", token)
                    return nil
                end
            end
            if checkToken(checkActionType, name) then
                return self:parseAction(tokenStream, annotation, name)
            end
            local target
            local tokenType, token = tokenStream:peek()
            if tokenType == "." then
                target = name
                tokenType, token = tokenStream:consume(2)
                if tokenType == "name" and token then
                    name = token
                else
                    self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing FUNCTION; name expected.", token)
                    return nil
                end
            end
            if  not target then
                if sub(name, 1, 6) == "target" then
                    target = "target"
                    name = sub(name, 7)
                end
            end
            local filter
            if sub(name, 1, 6) == "debuff" then
                filter = "debuff"
            elseif sub(name, 1, 4) == "buff" then
                filter = "buff"
            elseif sub(name, 1, 11) == "otherdebuff" then
                filter = "debuff"
            elseif sub(name, 1, 9) == "otherbuff" then
                filter = "buff"
            end
            local infos = self.ovaleCondition:getInfos(name)
            if infos then
                return self:parseTypedFunction(tokenStream, annotation, name, target, filter, infos)
            end
            if  not self:parseToken(tokenStream, "FUNCTION", "(") then
                return nil
            end
            local positionalParams, namedParams = self:parseParameters(tokenStream, "function", annotation, nil, checkFunctionParameters)
            if  not positionalParams or  not namedParams then
                return nil
            end
            if  not self:parseToken(tokenStream, "FUNCTION", ")") then
                return nil
            end
            if target then
                namedParams.target = self:newString(annotation, target)
            end
            if filter then
                namedParams.filter = self:newString(annotation, filter)
            end
            local nodeType
            if stateActions[name] then
                nodeType = "state"
            elseif stringLookupFunctions[name] then
                nodeType = "function"
            elseif self.ovaleCondition:isCondition(name) then
                nodeType = "function"
            else
                nodeType = "custom_function"
            end
            local node = self:newNodeWithParameters(nodeType, annotation, positionalParams, namedParams)
            node.name = name
            if stringLookupFunctions[name] then
                annotation.stringReference = annotation.stringReference or {}
                annotation.stringReference[#annotation.stringReference + 1] = node
            end
            node.asString = self.unparseFunction(node)
            if nodeType == "custom_function" then
                annotation.functionCall = annotation.functionCall or {}
                annotation.functionCall[node.name] = true
            end
            if nodeType == "function" and self.ovaleCondition:isSpellBookCondition(name) then
                local parameter = positionalParams[1]
                if  not parameter then
                    self:syntaxError(tokenStream, "Type error: %s function expect a spell id parameter", name)
                end
                annotation.spellNode = annotation.spellNode or {}
                annotation.spellNode[#annotation.spellNode + 1] = parameter
            end
            return node
        end
        self.innerParseGroup = function(tokenStream, annotation)
            local tokenType, token = tokenStream:consume()
            if tokenType ~= "{" then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing GROUP; '{' expected.", token)
                return nil
            end
            local node = self:newNodeWithChildren("group", annotation)
            local child = node.child
            tokenType = tokenStream:peek()
            while tokenType and tokenType ~= "}" do
                local statementNode = self.parseStatement(tokenStream, annotation)
                if statementNode then
                    child[#child + 1] = statementNode
                    tokenType = tokenStream:peek()
                else
                    self.nodesPool:release(node)
                    return nil
                end
            end
            tokenType, token = tokenStream:consume()
            if tokenType ~= "}" then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing GROUP; '}' expected.", token)
                self.nodesPool:release(node)
                return nil
            end
            return node
        end
        self.parseIf = function(tokenStream, annotation)
            local tokenType, token = tokenStream:consume()
            if  not (tokenType == "keyword" and token == "if") then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing IF; 'if' expected.", token)
                return nil
            end
            local conditionNode = self.parseStatement(tokenStream, annotation)
            if  not conditionNode then
                return nil
            end
            local bodyNode = self.parseStatement(tokenStream, annotation)
            if  not bodyNode then
                return nil
            end
            local node = self:newNodeWithChildren("if", annotation)
            node.child[1] = conditionNode
            node.child[2] = bodyNode
            return node
        end
        self.parseInclude = function(tokenStream, nodeList, annotation)
            local tokenType, token = tokenStream:consume()
            if  not (tokenType == "keyword" and token == "include") then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing INCLUDE; 'Include' expected.", token)
                return nil
            end
            tokenType, token = tokenStream:consume()
            if tokenType ~= "(" then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing INCLUDE; '(' expected.", token)
                return nil
            end
            local name
            tokenType, token = tokenStream:consume()
            if tokenType == "name" and token then
                name = token
            else
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing INCLUDE; script name expected.", token)
                return nil
            end
            tokenType, token = tokenStream:consume()
            if tokenType ~= ")" then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing INCLUDE; ')' expected.", token)
                return nil
            end
            local code = self.ovaleScripts:getScript(name)
            if code == nil then
                self.debug:error("Script '%s' not found when parsing INCLUDE.", name)
                return nil
            end
            local includeTokenStream = OvaleLexer(name, code, tokenMatches, lexerFilters)
            local node = self.parseScriptStream(includeTokenStream, nodeList, annotation)
            includeTokenStream:release()
            return node
        end
        self.parseItemInfo = function(tokenStream, annotation)
            local name
            local tokenType, token = tokenStream:consume()
            if  not (tokenType == "keyword" and token == "iteminfo") then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing ITEMINFO; 'ItemInfo' expected.", token)
                return nil
            end
            tokenType, token = tokenStream:consume()
            if tokenType ~= "(" then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing ITEMINFO; '(' expected.", token)
                return nil
            end
            local itemId
            tokenType, token = tokenStream:consume()
            if tokenType == "number" then
                itemId = token
            elseif tokenType == "name" then
                name = token
            else
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing ITEMINFO; number or name expected.", token)
                return nil
            end
            local positionalParams, namedParams = self:parseParameters(tokenStream, "iteminfo", annotation, nil, __exports.checkSpellInfo)
            if  not positionalParams or  not namedParams then
                return nil
            end
            tokenType, token = tokenStream:consume()
            if tokenType ~= ")" then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing ITEMINFO; ')' expected.", token)
                return nil
            end
            local node = self:newNodeWithParameters("item_info", annotation, positionalParams, namedParams)
            node.itemId = tonumber(itemId)
            if name then
                node.name = name
                annotation.nameReference = annotation.nameReference or {}
                annotation.nameReference[#annotation.nameReference + 1] = node
            end
            return node
        end
        self.parseItemRequire = function(tokenStream, annotation)
            local tokenType, token = tokenStream:consume()
            if  not (tokenType == "keyword" and token == "itemrequire") then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing ITEMREQUIRE; keyword expected.", token)
                return nil
            end
            tokenType, token = tokenStream:consume()
            if tokenType ~= "(" then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing ITEMREQUIRE; '(' expected.", token)
                return nil
            end
            local itemId, name
            tokenType, token = tokenStream:consume()
            if tokenType == "number" then
                itemId = token
            elseif tokenType == "name" then
                name = token
            else
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing ITEMREQUIRE; number or name expected.", token)
                return nil
            end
            local property = self:parseCheckedNameToken(tokenStream, "ITEMREQUIRE", __exports.checkSpellInfo)
            if  not property then
                return nil
            end
            local positionalParams, namedParams = self:parseParameters(tokenStream, "itemrequire", annotation, 0, checkSpellRequireParameters)
            if  not positionalParams or  not namedParams then
                return nil
            end
            tokenType, token = tokenStream:consume()
            if tokenType ~= ")" then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing ITEMREQUIRE; ')' expected.", token)
                return nil
            end
            local node = self:newNodeWithParameters("itemrequire", annotation, positionalParams, namedParams)
            node.itemId = tonumber(itemId)
            if name then
                node.name = name
            end
            node.property = property
            if name then
                annotation.nameReference = annotation.nameReference or {}
                annotation.nameReference[#annotation.nameReference + 1] = node
            end
            return node
        end
        self.parseList = function(tokenStream, annotation)
            local keyword
            local tokenType, token = tokenStream:consume()
            if tokenType == "keyword" and (token == "itemlist" or token == "spelllist") then
                keyword = token
            else
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing LIST; keyword expected.", token)
                return nil
            end
            tokenType, token = tokenStream:consume()
            if tokenType ~= "(" then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing LIST; '(' expected.", token)
                return nil
            end
            local name
            tokenType, token = tokenStream:consume()
            if tokenType == "name" and token then
                name = token
            else
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing LIST; name expected.", token)
                return nil
            end
            local positionalParams, namedParams = self:parseParameters(tokenStream, "list", annotation, nil, checkListParameters)
            if  not positionalParams or  not namedParams then
                return nil
            end
            tokenType, token = tokenStream:consume()
            if tokenType ~= ")" then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing LIST; ')' expected.", token)
                return nil
            end
            local node = self:newNodeWithParameters("list", annotation, positionalParams, namedParams)
            node.keyword = keyword
            node.name = name
            annotation.definition[name] = name
            return node
        end
        self.parseNumber = function(tokenStream, annotation)
            local value
            local tokenType, token = tokenStream:consume()
            if tokenType == "number" then
                value = tonumber(token)
            else
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing NUMBER; number expected.", token)
                return nil
            end
            local node = self:getNumberNode(value, annotation)
            return node
        end
        self.parseScoreSpells = function(tokenStream, annotation)
            local tokenType, token = tokenStream:consume()
            if  not (tokenType == "keyword" and token == "scorespells") then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing SCORESPELLS; 'ScoreSpells' expected.", token)
                return nil
            end
            tokenType, token = tokenStream:consume()
            if tokenType ~= "(" then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing SCORESPELLS; '(' expected.", token)
                return nil
            end
            local positionalParams, namedParams = self:parseParameters(tokenStream, "scorespells", annotation, nil, checkListParameters)
            if  not positionalParams or  not namedParams then
                return nil
            end
            tokenType, token = tokenStream:consume()
            if tokenType ~= ")" then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing SCORESPELLS; ')' expected.", token)
                return nil
            end
            local node = self:newNodeWithParameters("score_spells", annotation, positionalParams, namedParams)
            return node
        end
        self.parseScriptStream = function(tokenStream, annotation)
            self.profiler:startProfiling("OvaleAST_ParseScript")
            local ast = self:newNodeWithChildren("script", annotation)
            local child = ast.child
            while true do
                local tokenType, token = tokenStream:peek()
                if tokenType then
                    local declarationNode = self.parseDeclaration(tokenStream, annotation)
                    if  not declarationNode then
                        self.debug:error("Failed on " .. token)
                        self.nodesPool:release(ast)
                        return nil
                    end
                    if declarationNode.type == "script" then
                        for _, node in ipairs(declarationNode.child) do
                            child[#child + 1] = node
                        end
                        self.nodesPool:release(declarationNode)
                    else
                        child[#child + 1] = declarationNode
                    end
                else
                    break
                end
            end
            self.profiler:stopProfiling("OvaleAST_ParseScript")
            return ast
        end
        self.parseSimpleParameterValue = function(tokenStream, annotation)
            local isBang = false
            local tokenType = tokenStream:peek()
            if tokenType == "!" then
                isBang = true
                tokenStream:consume()
            end
            local expressionNode
            tokenType = tokenStream:peek()
            if tokenType == "(" or tokenType == "-" then
                expressionNode = self.parseExpression(tokenStream, annotation)
            else
                expressionNode = self:parseSimpleExpression(tokenStream, annotation)
            end
            if  not expressionNode then
                return nil
            end
            local node
            if isBang then
                node = self:newNodeWithChildren("bang_value", annotation)
                node.child[1] = expressionNode
            else
                node = expressionNode
            end
            return node
        end
        self.parseSpellAuraList = function(tokenStream, annotation)
            local keyword = self:parseKeywordTokens(tokenStream, "SPELLAURALIST", spellAuraKewords)
            if  not keyword then
                self.debug:error("Failed on keyword")
                return nil
            end
            if  not self:parseToken(tokenStream, "SPELLAURALIST", "(") then
                self.debug:error("Failed on (")
                return nil
            end
            local spellId, name = self:parseNumberOrNameParameter(tokenStream, "SPELLAURALIST")
            local buffSpellId, buffName = self:parseNumberOrNameParameter(tokenStream, "SPELLAURALIST")
            local positionalParams, namedParams = self:parseParameters(tokenStream, "spellauralist", annotation, 0, spellAuraListParametersCheck)
            if  not positionalParams or  not namedParams then
                return nil
            end
            if  not self:parseToken(tokenStream, "SPELLAURALIST", ")") then
                self.debug:error("Failed on )")
                return nil
            end
            local node = self:newNodeWithParameters("spell_aura_list", annotation, positionalParams, namedParams)
            node.keyword = keyword
            if spellId then
                node.spellId = spellId
            elseif name then
                node.name = name
            end
            if buffSpellId then
                node.buffSpellId = buffSpellId
            elseif buffName then
                node.buffName = buffName
            end
            if name or buffName then
                annotation.nameReference = annotation.nameReference or {}
                annotation.nameReference[#annotation.nameReference + 1] = node
            end
            return node
        end
        self.parseSpellInfo = function(tokenStream, annotation)
            local name
            local tokenType, token = tokenStream:consume()
            if  not (tokenType == "keyword" and token == "spellinfo") then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing SPELLINFO; 'SpellInfo' expected.", token)
                return nil
            end
            tokenType, token = tokenStream:consume()
            if tokenType ~= "(" then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing SPELLINFO; '(' expected.", token)
                return nil
            end
            local spellId
            tokenType, token = tokenStream:consume()
            if tokenType == "number" then
                spellId = tonumber(token)
            elseif tokenType == "name" then
                name = token
            else
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing SPELLINFO; number or name expected.", token)
                return nil
            end
            local positionalParams, namedParams = self:parseParameters(tokenStream, "spellinfo", annotation, 0, __exports.checkSpellInfo)
            if  not positionalParams or  not namedParams then
                return nil
            end
            tokenType, token = tokenStream:consume()
            if tokenType ~= ")" then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing SPELLINFO; ')' expected.", token)
                return nil
            end
            local node = self:newNodeWithParameters("spell_info", annotation, positionalParams, namedParams)
            if spellId then
                node.spellId = spellId
            end
            if name then
                node.name = name
                annotation.nameReference = annotation.nameReference or {}
                annotation.nameReference[#annotation.nameReference + 1] = node
            end
            return node
        end
        self.parseSpellRequire = function(tokenStream, annotation)
            if self:parseKeywordToken(tokenStream, "SPELLREQUIRE", "spellrequire") == nil then
                return nil
            end
            if  not self:parseToken(tokenStream, "SPELLREQUIRE", "(") then
                return nil
            end
            local spellId, name = self:parseNumberOrNameParameter(tokenStream, "SPELLREQUIRE")
            if  not spellId and  not name then
                return nil
            end
            local property = self:parseCheckedNameToken(tokenStream, "SPELLREQUIRE", __exports.checkSpellInfo)
            if  not property then
                return nil
            end
            local positionalParams, namedParams = self:parseParameters(tokenStream, "spellrequire", annotation, 0, checkSpellRequireParameters)
            if  not positionalParams or  not namedParams then
                return nil
            end
            if  not self:parseToken(tokenStream, "SPELLREQUIRE", ")") then
                return nil
            end
            local node = self:newNodeWithParameters("spell_require", annotation, positionalParams, namedParams)
            if spellId then
                node.spellId = spellId
            end
            node.property = property
            if name then
                node.name = name
                annotation.nameReference = annotation.nameReference or {}
                annotation.nameReference[#annotation.nameReference + 1] = node
            end
            return node
        end
        self.parseStatement = function(tokenStream, annotation)
            local node
            local tokenType, token = tokenStream:peek()
            if tokenType then
                if token == "{" then
                    local i = 1
                    local count = 0
                    while tokenType do
                        if token == "{" then
                            count = count + 1
                        elseif token == "}" then
                            count = count - 1
                        end
                        i = i + 1
                        tokenType, token = tokenStream:peek(i)
                        if count == 0 then
                            break
                        end
                    end
                    if  not tokenType or binaryOperators[token] then
                        node = self.parseExpression(tokenStream, annotation)
                    else
                        node = self:parseGroup(tokenStream, annotation)
                    end
                elseif token == "if" then
                    node = self.parseIf(tokenStream, annotation)
                elseif token == "unless" then
                    node = self.parseUnless(tokenStream, annotation)
                else
                    node = self.parseExpression(tokenStream, annotation)
                end
            end
            return node
        end
        self.parseString = function(tokenStream, annotation)
            local value
            local tokenType, token = tokenStream:peek()
            if tokenType == "string" and token then
                value = token
                tokenStream:consume()
            elseif tokenType == "name" and token then
                if stringLookupFunctions[lower(token)] then
                    return self.parseFunction(tokenStream, annotation)
                else
                    value = token
                    tokenStream:consume()
                end
            else
                tokenStream:consume()
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing STRING; string, variable, or function expected.", token)
                return nil
            end
            local node = self:newString(annotation, value)
            annotation.stringReference = annotation.stringReference or {}
            annotation.stringReference[#annotation.stringReference + 1] = node
            return node
        end
        self.parseUnless = function(tokenStream, annotation)
            local tokenType, token = tokenStream:consume()
            if  not (tokenType == "keyword" and token == "unless") then
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing UNLESS; 'unless' expected.", token)
                return nil
            end
            local conditionNode = self.parseExpression(tokenStream, annotation)
            if  not conditionNode then
                return nil
            end
            local bodyNode = self.parseStatement(tokenStream, annotation)
            if  not bodyNode then
                return nil
            end
            local node = self:newNodeWithChildren("unless", annotation)
            node.child[1] = conditionNode
            node.child[2] = bodyNode
            return node
        end
        self.parseVariable = function(tokenStream, annotation)
            local name
            local tokenType, token = tokenStream:consume()
            if (tokenType == "name" or tokenType == "keyword") and token then
                name = token
            else
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing VARIABLE; name expected.", token)
                return nil
            end
            local node = self:newNode("variable", annotation)
            node.name = name
            annotation.nameReference = annotation.nameReference or {}
            annotation.nameReference[#annotation.nameReference + 1] = node
            return node
        end
        self.parseVisitors = {
            ["action"] = self.parseFunction,
            ["add_function"] = self.parseAddFunction,
            ["arithmetic"] = self.parseExpression,
            ["bang_value"] = self.parseSimpleParameterValue,
            ["checkbox"] = self.parseAddCheckBox,
            ["compare"] = self.parseExpression,
            ["comment"] = self.parseComment,
            ["custom_function"] = self.parseFunction,
            ["define"] = self.parseDefine,
            ["expression"] = self.parseStatement,
            ["function"] = self.parseFunction,
            ["group"] = self.parseGroup,
            ["icon"] = self.parseAddIcon,
            ["if"] = self.parseIf,
            ["item_info"] = self.parseItemInfo,
            ["itemrequire"] = self.parseItemRequire,
            ["list"] = self.parseList,
            ["list_item"] = self.parseAddListItem,
            ["logical"] = self.parseExpression,
            ["score_spells"] = self.parseScoreSpells,
            ["script"] = self.parseScriptStream,
            ["spell_aura_list"] = self.parseSpellAuraList,
            ["spell_info"] = self.parseSpellInfo,
            ["spell_require"] = self.parseSpellRequire,
            ["string"] = self.parseString,
            ["unless"] = self.parseUnless,
            ["value"] = self.parseNumber,
            ["variable"] = self.parseVariable
        }
        self.debug = ovaleDebug:create("OvaleAST")
        self.profiler = ovaleProfiler:create("OvaleAST")
    end,
    printRecurse = function(self, node, indent, done, output)
        done = done or {}
        output = output or {}
        indent = indent or ""
        for key, value in kpairs(node) do
            if isAstNode(value) then
                if done[value.nodeId] then
                    insert(output, indent .. "[" .. tostring(key) .. "] => (self_reference)")
                else
                    done[value.nodeId] = true
                    if value.type then
                        insert(output, indent .. "[" .. tostring(key) .. "] =>")
                    else
                        insert(output, indent .. "[" .. tostring(key) .. "] => {")
                    end
                    self:printRecurse(value, indent .. "    ", done, output)
                    if  not value.type then
                        insert(output, indent .. "}")
                    end
                end
            else
                insert(output, indent .. "[" .. tostring(key) .. "] => " .. tostring(value))
            end
        end
        return output
    end,
    getNumberNode = function(self, value, annotation)
        annotation.numberFlyweight = annotation.numberFlyweight or {}
        local node = annotation.numberFlyweight[value]
        if  not node then
            node = self:newValue(annotation, value)
            annotation.numberFlyweight[value] = node
        end
        return node
    end,
    postOrderTraversal = function(self, node, array, visited)
        if __exports.isAstNodeWithChildren(node) then
            for _, childNode in ipairs(node.child) do
                if  not visited[childNode.nodeId] then
                    self:postOrderTraversal(childNode, array, visited)
                    array[#array + 1] = node
                end
            end
        end
        array[#array + 1] = node
        visited[node.nodeId] = true
    end,
    getPrecedence = function(self, node)
        if isExpressionNode(node) then
            local precedence = node.precedence
            if  not precedence then
                local operator = node.operator
                if operator then
                    if node.expressionType == "unary" then
                        local operatorInfos = unaryOperators[operator]
                        if operatorInfos then
                            precedence = operatorInfos[2]
                        end
                    elseif node.expressionType == "binary" then
                        local operatorInfos = binaryOperators[operator]
                        if operatorInfos then
                            precedence = operatorInfos[2]
                        end
                    end
                end
            end
            return precedence
        end
        return 0
    end,
    hasParameters = function(self, node)
        return next(node.rawPositionalParams) or next(node.rawNamedParams)
    end,
    unparse = function(self, node)
        if node.asString then
            return node.asString
        else
            local visitor = self.unparseVisitors[node.type]
            if  not visitor then
                self.debug:error("Unable to unparse node of type '%s'.", node.type)
                return "Unkown_" .. node.type
            else
                node.asString = visitor(node)
                return node.asString
            end
        end
    end,
    unparseParameter = function(self, node)
        if node.type == "string" or node.type == "value" or node.type == "variable" or node.type == "boolean" then
            return self:unparse(node)
        else
            return "(" .. self:unparse(node) .. ")"
        end
    end,
    unparseParameters = function(self, positionalParams, namedParams, noFilter, noTarget)
        local output = self.outputPool:get()
        if namedParams then
            for k, v in kpairs(namedParams) do
                if ( not noFilter or k ~= "filter") and ( not noTarget or k ~= "target") then
                    output[#output + 1] = format("%s=%s", k, self:unparseParameter(v))
                end
            end
        end
        sort(output)
        for k = #positionalParams, 1, -1 do
            insert(output, 1, self:unparseParameter(positionalParams[k]))
        end
        local outputString = concat(output, " ")
        self.outputPool:release(output)
        return outputString
    end,
    syntaxError = function(self, tokenStream, pattern, ...)
        self.debug:warning(pattern, ...)
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
        self.debug:warning(concat(context, " "))
    end,
    parse = function(self, nodeType, tokenStream, nodeList, annotation)
        local visitor = self.parseVisitors[nodeType]
        self.debug:debug("Visit " .. nodeType)
        if  not visitor then
            self.debug:error("Unable to parse node of type '%s'.", nodeType)
            return nil
        else
            local result = visitor(tokenStream, annotation)
            if  not result then
                self.debug:error([[Failed in %s visitor]], nodeType)
            end
            return result
        end
    end,
    parseTypedFunction = function(self, tokenStream, annotation, name, target, filter, infos)
        if  not self:parseToken(tokenStream, "FUNCTION", "(") then
            return nil
        end
        local positionalParams, namedParams = self:parseParameters(tokenStream, "function", annotation, nil)
        if  not positionalParams or  not namedParams then
            return nil
        end
        if target then
            namedParams.target = self:newString(annotation, target)
        end
        if filter then
            namedParams.filter = self:newString(annotation, filter)
        end
        if #positionalParams > #infos.parameters then
            self:syntaxError(tokenStream, "Type error: the %s function takes %d parameters", name, #infos.parameters)
            return nil
        end
        for key, node in kpairs(namedParams) do
            local parameterIndex = infos.namedParameters[key]
            if parameterIndex ~= nil then
                if positionalParams[parameterIndex] ~= nil then
                    self:syntaxError(tokenStream, "Type error: the %s parameters is named in the %s function although it appears already in the parameters list", key, name)
                    return nil
                end
                positionalParams[parameterIndex] = node
            else
                self:syntaxError(tokenStream, "Type error: unknown %s parameter in %s function", key, getFunctionSignature(name, infos))
                return nil
            end
        end
        for key, parameterInfos in ipairs(infos.parameters) do
            local parameter = positionalParams[key]
            if  not parameter then
                if parameterInfos.defaultValue ~= nil then
                    if parameterInfos.type == "string" then
                        positionalParams[key] = self:newString(annotation, parameterInfos.defaultValue)
                    elseif parameterInfos.type == "number" then
                        positionalParams[key] = self:newValue(annotation, parameterInfos.defaultValue)
                    elseif parameterInfos.type == "boolean" then
                        positionalParams[key] = self:newBoolean(annotation, parameterInfos.defaultValue)
                    else
                        self:syntaxError(tokenStream, "Type error: parameter type unknown in %s function", name)
                        return nil
                    end
                elseif  not parameterInfos.optional then
                    self:syntaxError(tokenStream, "Type error: parameter %s is required in %s function", parameterInfos.name, name)
                    return nil
                else
                    positionalParams[key] = self:newUndefined(annotation)
                end
            else
                if parameterInfos.type == "number" then
                    if parameterInfos.isSpell then
                        annotation.spellNode = annotation.spellNode or {}
                        insert(annotation.spellNode, parameter)
                    end
                elseif parameterInfos.type == "string" and parameter.type == "string" then
                    if parameterInfos.checkTokens then
                        if  not checkToken(parameterInfos.checkTokens, parameter.value) then
                            self:syntaxError(tokenStream, "Type error: parameter %s has not a valid value in function %s", key, name)
                            return nil
                        end
                    end
                end
            end
        end
        if  not self:parseToken(tokenStream, "FUNCTION", ")") then
            return nil
        end
        local node = self:newNodeWithParameters("typed_function", annotation, positionalParams, namedParams)
        node.name = name
        node.asString = self.unparseTypedFunction(node)
        return node
    end,
    parseAction = function(self, tokenStream, annotation, name)
        if  not self:parseToken(tokenStream, "ACTION", "(") then
            return nil
        end
        local count = actionParameterCounts[name]
        local positionalParams, namedParams = self:parseParameters(tokenStream, "function", annotation, count, checkActionParameters)
        if  not positionalParams or  not namedParams then
            return nil
        end
        if  not self:parseToken(tokenStream, "ACTION", ")") then
            return nil
        end
        local node = self:newNodeWithParameters("action", annotation, positionalParams, namedParams)
        node.name = name
        if stringLookupFunctions[name] then
            annotation.stringReference = annotation.stringReference or {}
            annotation.stringReference[#annotation.stringReference + 1] = node
        end
        node.asString = self.unparseAction(node)
        if name == "spell" then
            local parameter = positionalParams[1]
            if  not parameter then
                self:syntaxError(tokenStream, "Type error: %s function expect a spell id parameter", name)
            end
            annotation.spellNode = annotation.spellNode or {}
            annotation.spellNode[#annotation.spellNode + 1] = parameter
        end
        return node
    end,
    parseGroup = function(self, tokenStream, annotation)
        local group = self.innerParseGroup(tokenStream, annotation)
        if group and #group.child == 1 then
            local result = group.child[1]
            self.nodesPool:release(group)
            return result
        end
        return group
    end,
    parseParameters = function(self, tokenStream, methodName, annotation, maxNumberOfParameters, namedParameters)
        local positionalParams = self.rawPositionalParametersPool:get()
        local namedParams = (self.rawNamedParametersPool:get())
        while true do
            local tokenType = tokenStream:peek()
            if tokenType then
                local nextTokenType = tokenStream:peek(2)
                if nextTokenType == "=" then
                    local parameterName
                    if namedParameters then
                        parameterName = self:parseCheckedNameToken(tokenStream, methodName, namedParameters)
                    else
                        parameterName = self:parseNameToken(tokenStream, methodName)
                    end
                    if  not parameterName then
                        return 
                    end
                    tokenStream:consume()
                    local node = self.parseSimpleParameterValue(tokenStream, annotation)
                    if  not node then
                        return 
                    end
                    namedParams[parameterName] = node
                else
                    local node
                    if tokenType == "name" or tokenType == "keyword" then
                        node = self.parseVariable(tokenStream, annotation)
                        if  not node then
                            return 
                        end
                    elseif tokenType == "number" then
                        node = self.parseNumber(tokenStream, annotation)
                        if  not node then
                            return 
                        end
                    elseif tokenType == "-" then
                        tokenStream:consume()
                        node = self.parseNumber(tokenStream, annotation)
                        if node then
                            local value = -1 * node.value
                            node = self:getNumberNode(value, annotation)
                        else
                            return 
                        end
                    elseif tokenType == "string" then
                        node = self.parseString(tokenStream, annotation)
                        if  not node then
                            return 
                        end
                    else
                        break
                    end
                    positionalParams[#positionalParams + 1] = node
                    if maxNumberOfParameters and #positionalParams > maxNumberOfParameters then
                        self:syntaxError(tokenStream, "Error: the maximum number of parameters in %s is %s", methodName, maxNumberOfParameters)
                        return 
                    end
                end
            else
                break
            end
        end
        annotation.rawPositionalParametersList = annotation.rawPositionalParametersList or {}
        annotation.rawPositionalParametersList[#annotation.rawPositionalParametersList + 1] = positionalParams
        annotation.rawNamedParametersList = annotation.rawNamedParametersList or {}
        annotation.rawNamedParametersList[#annotation.rawNamedParametersList + 1] = namedParams
        return positionalParams, namedParams
    end,
    parseParentheses = function(self, tokenStream, annotation)
        local leftToken, rightToken
        do
            local tokenType, token = tokenStream:consume()
            if tokenType == "(" then
                leftToken, rightToken = "(", ")"
            elseif tokenType == "{" then
                leftToken, rightToken = "{", "}"
            else
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing PARENTHESES; '(' or '{' expected.", token)
                return nil
            end
        end
        local node = self.parseExpression(tokenStream, annotation)
        if  not node then
            return nil
        end
        local tokenType, token = tokenStream:consume()
        if tokenType ~= rightToken then
            self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing PARENTHESES; '%s' expected.", token, rightToken)
            return nil
        end
        node.left = leftToken
        node.right = rightToken
        return node
    end,
    parseSimpleExpression = function(self, tokenStream, annotation)
        local node
        local tokenType, token = tokenStream:peek()
        if tokenType == "number" then
            node = self.parseNumber(tokenStream, annotation)
        elseif tokenType == "string" then
            node = self.parseString(tokenStream, annotation)
        elseif tokenType == "keyword" and (token == "true" or token == "false") then
            tokenStream:consume()
            node = self:newBoolean(annotation, token == "true")
        elseif tokenType == "name" or tokenType == "keyword" then
            tokenType, token = tokenStream:peek(2)
            if tokenType == "." or tokenType == "(" then
                node = self.parseFunction(tokenStream, annotation)
            else
                node = self.parseVariable(tokenStream, annotation)
            end
        elseif tokenType == "(" or tokenType == "{" then
            node = self:parseParentheses(tokenStream, annotation)
        else
            tokenStream:consume()
            self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing SIMPLE EXPRESSION", token)
            return nil
        end
        return node
    end,
    parseNumberOrNameParameter = function(self, tokenStream, methodName)
        local tokenType, token = tokenStream:consume()
        local spellId, name
        if tokenType == "-" then
            tokenType, token = tokenStream:consume()
            if tokenType == "number" then
                spellId = -tonumber(token)
            else
                self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' wheren parsing '%s'; number expected", token, methodName)
                return 
            end
        elseif tokenType == "number" then
            spellId = tonumber(token)
        elseif tokenType == "name" then
            name = token
        else
            self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing '%s'; number or name expected.", token, methodName)
            return 
        end
        return spellId, name
    end,
    parseToken = function(self, tokenStream, methodName, expectedToken)
        local tokenType, token = tokenStream:consume()
        if tokenType ~= expectedToken then
            self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing %s; '%s' expected.", token, methodName, expectedToken)
            return false
        end
        return true
    end,
    parseKeywordTokens = function(self, tokenStream, methodName, keyCheck)
        local keyword
        local tokenType, token = tokenStream:consume()
        if tokenType == "keyword" and token and checkToken(keyCheck, token) then
            keyword = token
        else
            self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing %s; keyword expected.", token, methodName)
            return nil
        end
        return keyword
    end,
    parseKeywordToken = function(self, tokenStream, methodName, keyCheck)
        local keyword
        local tokenType, token = tokenStream:consume()
        if tokenType == "keyword" and token and token == keyCheck then
            keyword = keyCheck
        else
            self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing %s; keyword %s expected.", token, methodName, keyCheck)
            return nil
        end
        return keyword
    end,
    parseCheckedNameToken = function(self, tokenStream, methodName, keyCheck)
        local keyword
        local tokenType, token = tokenStream:consume()
        if tokenType == "name" and token and checkToken(keyCheck, token) then
            keyword = token
        else
            self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing %s; name expected.", token, methodName)
            return nil
        end
        return keyword
    end,
    parseNameToken = function(self, tokenStream, methodName)
        local keyword
        local tokenType, token = tokenStream:consume()
        if tokenType == "name" and token then
            keyword = token
        else
            self:syntaxError(tokenStream, "Syntax error: unexpected token '%s' when parsing %s; name expected.", token, methodName)
            return nil
        end
        return keyword
    end,
    newFunction = function(self, name, annotation)
        local node = self:newNodeWithParameters("function", annotation)
        node.name = name
        return node
    end,
    newString = function(self, annotation, value)
        local node = self:newNode("string", annotation)
        node.value = value
        node.result.constant = true
        local result = node.result
        result.timeSpan:copyFromArray(universe)
        result.type = "value"
        result.value = value
        return node
    end,
    newVariable = function(self, annotation, name)
        local node = self:newNode("variable", annotation)
        node.name = name
        return node
    end,
    newValue = function(self, annotation, value)
        local node = self:newNode("value", annotation)
        node.value = value
        node.result.constant = true
        local result = node.result
        result.type = "value"
        result.value = value
        result.timeSpan:copyFromArray(universe)
        result.origin = 0
        result.rate = 0
        return node
    end,
    newBoolean = function(self, annotation, value)
        local node = self:newNode("boolean", annotation)
        node.value = value
        node.result.constant = true
        local result = node.result
        if value then
            result.timeSpan:copyFromArray(universe)
        else
            wipe(result.timeSpan)
        end
        result.type = "none"
        return node
    end,
    newUndefined = function(self, annotation)
        local node = self:newNode("undefined", annotation)
        node.result.constant = true
        node.result.timeSpan:copyFromArray(emptySet)
        return node
    end,
    internalNewNodeWithParameters = function(self, type, annotation, rawPositionalParameters, rawNamedParams)
        local node = self:internalNewNodeWithChildren(type, annotation)
        node.rawNamedParams = rawNamedParams or self.rawNamedParametersPool:get()
        node.rawPositionalParams = rawPositionalParameters or self.rawPositionalParametersPool:get()
        node.cachedParams = {
            named = self.namedParametersPool:get(),
            positional = self.positionalParametersPool:get()
        }
        annotation.parametersReference = annotation.parametersReference or {}
        annotation.parametersReference[#annotation.parametersReference + 1] = node
        return node
    end,
    internalNewNodeWithChildren = function(self, type, annotation)
        local node = self:internalNewNode(type, annotation)
        node.child = self.childrenPool:get()
        return node
    end,
    internalNewNode = function(self, type, annotation)
        local node = self.nodesPool:get()
        node.type = type
        node.annotation = annotation
        local nodeList = annotation.nodeList
        local nodeId = #nodeList + 1
        node.nodeId = nodeId
        nodeList[nodeId] = node
        node.result = {
            type = "none",
            timeSpan = newTimeSpan(),
            serial = 0
        }
        return node
    end,
    newNodeWithBodyAndParameters = function(self, type, annotation, body, rawPositionalParameters, rawNamedParams)
        local node = self:internalNewNodeWithParameters(type, annotation, rawPositionalParameters, rawNamedParams)
        node.body = body
        node.child[1] = body
        return node
    end,
    newNodeWithParameters = function(self, type, annotation, rawPositionalParameters, rawNamedParams)
        return self:internalNewNodeWithParameters(type, annotation, rawPositionalParameters, rawNamedParams)
    end,
    newNodeWithChildren = function(self, type, annotation)
        return self:internalNewNodeWithChildren(type, annotation)
    end,
    newNode = function(self, type, annotation)
        return self:internalNewNode(type, annotation)
    end,
    nodeToString = function(self, node)
        local output = self:printRecurse(node)
        return concat(output, "\n")
    end,
    releaseAnnotation = function(self, annotation)
        if annotation.checkBoxList then
            for _, control in ipairs(annotation.checkBoxList) do
                self.checkboxPool:release(control)
            end
        end
        if annotation.listList then
            for _, control in ipairs(annotation.listList) do
                self.listPool:release(control)
            end
        end
        if annotation.rawPositionalParametersList then
            for _, parameters in ipairs(annotation.rawPositionalParametersList) do
                self.rawPositionalParametersPool:release(parameters)
            end
        end
        if annotation.rawNamedParametersList then
            for _, parameters in ipairs(annotation.rawNamedParametersList) do
                self.rawNamedParametersPool:release(parameters)
            end
        end
        if annotation.nodeList then
            for _, node in ipairs(annotation.nodeList) do
                self.nodesPool:release(node)
            end
        end
        for _, value in kpairs(annotation) do
            if type(value) == "table" then
                wipe(value)
            end
        end
        wipe(annotation)
    end,
    release = function(self, ast)
        ast.result.timeSpan:release()
        wipe(ast.result)
        wipe(ast)
        self.nodesPool:release(ast)
    end,
    parseCode = function(self, nodeType, code, nodeList, annotation)
        local tokenStream = OvaleLexer("Ovale", code, tokenMatches, {
            comments = tokenizeComment,
            space = tokenizeWhitespace
        })
        local node = self:parse(nodeType, tokenStream, nodeList, annotation)
        tokenStream:release()
        if  not node then
            return 
        end
        return node, nodeList, annotation
    end,
    parseScript = function(self, code, options)
        options = options or {
            optimize = true,
            verify = true
        }
        local annotation = {
            nodeList = {},
            verify = options.verify,
            definition = {}
        }
        local ast = self:parseCode("script", code, annotation.nodeList, annotation)
        if ast then
            if ast.type == "script" then
                ast.annotation = annotation
                self:propagateConstants(ast)
                self:propagateStrings(ast)
                self:verifyFunctionCalls(ast)
                if options.optimize then
                    self:optimize(ast)
                end
                self:insertPostOrderTraversal(ast)
                return ast
            end
            self.debug:debug("Unexpected type " .. ast.type .. " in parseScript")
            self:release(ast)
        else
            self.debug:error("Parse failed")
        end
        self:releaseAnnotation(annotation)
        return nil
    end,
    parseNamedScript = function(self, name, options)
        local code = self.ovaleScripts:getScriptOrDefault(name)
        if code then
            return self:parseScript(code, options)
        else
            self.debug:debug("No code to parse")
            return nil
        end
    end,
    getId = function(self, name, dictionary)
        local itemId = dictionary[name]
        if itemId then
            if isNumber(itemId) then
                return itemId
            else
                self.debug:error(name .. " is as string and not an item id")
            end
        end
        return 0
    end,
    propagateConstants = function(self, ast)
        self.profiler:startProfiling("OvaleAST_PropagateConstants")
        if ast.annotation then
            local dictionary = ast.annotation.definition
            if dictionary and ast.annotation.nameReference then
                for _, node in ipairs(ast.annotation.nameReference) do
                    if (node.type == "item_info" or node.type == "itemrequire") and node.name then
                        node.itemId = self:getId(node.name, dictionary)
                    elseif node.type == "spell_aura_list" or node.type == "spell_info" or node.type == "spell_require" then
                        if node.name then
                            node.spellId = self:getId(node.name, dictionary)
                        end
                        if node.type == "spell_aura_list" and node.buffName then
                            node.buffSpellId = self:getId(node.buffName, dictionary)
                        end
                    elseif node.type == "variable" then
                        local name = node.name
                        local value = dictionary[name]
                        if value then
                            if isNumber(value) then
                                local valueNode = node
                                valueNode.type = "value"
                                valueNode.name = name
                                valueNode.value = value
                                valueNode.origin = 0
                                valueNode.rate = 0
                            else
                                local valueNode = node
                                valueNode.type = "string"
                                valueNode.value = value
                                valueNode.name = name
                            end
                        else
                            local valueNode = node
                            valueNode.type = "string"
                            valueNode.value = name
                        end
                    end
                end
            end
        end
        self.profiler:stopProfiling("OvaleAST_PropagateConstants")
    end,
    propagateStrings = function(self, ast)
        self.profiler:startProfiling("OvaleAST_PropagateStrings")
        if ast.annotation and ast.annotation.stringReference then
            for _, node in ipairs(ast.annotation.stringReference) do
                local nodeAsString = node
                if node.type == "string" then
                    local key = node.value
                    local value = l[key]
                    if value then
                        nodeAsString.value = value
                        nodeAsString.name = key
                    end
                elseif node.type == "variable" then
                    nodeAsString.type = "string"
                    local name = node.name
                    nodeAsString.name = node.name
                    nodeAsString.value = name
                elseif node.type == "value" then
                    local value = node.value
                    nodeAsString.type = "string"
                    nodeAsString.name = tostring(node.value)
                    nodeAsString.value = tostring(value)
                elseif node.type == "function" then
                    local key = node.rawPositionalParams[1]
                    local stringKey
                    if isAstNode(key) then
                        if key.type == "value" then
                            stringKey = tostring(key.value)
                        elseif key.type == "variable" then
                            stringKey = key.name
                        elseif key.type == "string" then
                            stringKey = key.value
                        else
                            stringKey = nil
                        end
                    else
                        stringKey = tostring(key)
                    end
                    if stringKey then
                        local value
                        local name = node.name
                        if name == "itemname" then
                            value = GetItemInfo(stringKey)
                            if  not value then
                                value = "item:" .. stringKey
                            end
                        elseif name == "l" then
                            value = l[stringKey] or stringKey
                        elseif name == "spellname" then
                            value = self.ovaleSpellBook:getSpellName(tonumber(stringKey)) or "spell:" .. stringKey
                        end
                        if value then
                            nodeAsString.type = "string"
                            nodeAsString.value = value
                            nodeAsString.func = node.name
                            nodeAsString.name = stringKey
                        end
                    end
                end
            end
        end
        self.profiler:stopProfiling("OvaleAST_PropagateStrings")
    end,
    verifyFunctionCalls = function(self, ast)
        self.profiler:startProfiling("OvaleAST_VerifyFunctionCalls")
        if ast.annotation and ast.annotation.verify then
            local customFunction = ast.annotation.customFunction
            local functionCall = ast.annotation.functionCall
            if functionCall then
                for name in pairs(functionCall) do
                    if  not (checkToken(checkActionType, name) or stringLookupFunctions[name] or self.ovaleCondition:isCondition(name) or (customFunction and customFunction[name])) then
                        self.debug:error("unknown function '%s'.", name)
                    end
                end
            end
        end
        self.profiler:stopProfiling("OvaleAST_VerifyFunctionCalls")
    end,
    insertPostOrderTraversal = function(self, ast)
        self.profiler:startProfiling("OvaleAST_InsertPostOrderTraversal")
        local annotation = ast.annotation
        if annotation and annotation.postOrderReference then
            for _, node in ipairs(annotation.postOrderReference) do
                local array = self.postOrderPool:get()
                local visited = self.postOrderVisitedPool:get()
                self:postOrderTraversal(node, array, visited)
                self.postOrderVisitedPool:release(visited)
                node.postOrder = array
            end
        end
        self.profiler:stopProfiling("OvaleAST_InsertPostOrderTraversal")
    end,
    optimize = function(self, ast)
        self.profiler:startProfiling("OvaleAST_CommonSubExpressionElimination")
        if ast and ast.annotation and ast.annotation.nodeList then
            local expressionHash = {}
            for _, node in ipairs(ast.annotation.nodeList) do
                local hash = node.asString
                if hash then
                    expressionHash[hash] = expressionHash[hash] or node
                end
            end
            for _, node in ipairs(ast.annotation.nodeList) do
                if __exports.isAstNodeWithChildren(node) then
                    for i, childNode in ipairs(node.child) do
                        local hash = childNode.asString
                        if hash then
                            local hashNode = expressionHash[hash]
                            if hashNode then
                                node.child[i] = hashNode
                            else
                                expressionHash[hash] = childNode
                            end
                        end
                    end
                end
            end
            ast.annotation.expressionHash = expressionHash
        end
        self.profiler:stopProfiling("OvaleAST_CommonSubExpressionElimination")
    end,
})
