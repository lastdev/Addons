local __exports = LibStub:NewLibrary("ovale/simulationcraft/splitter", 90103)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local ipairs = ipairs
local wipe = wipe
local __definitions = LibStub:GetLibrary("ovale/simulationcraft/definitions")
local getTagPriority = __definitions.getTagPriority
local __texttools = LibStub:GetLibrary("ovale/simulationcraft/text-tools")
local toOvaleTaggedFunctionName = __texttools.toOvaleTaggedFunctionName
local find = string.find
local sub = string.sub
local insert = table.insert
__exports.Splitter = __class(nil, {
    constructor = function(self, ovaleAst, ovaleDebug, ovaleData)
        self.ovaleAst = ovaleAst
        self.ovaleData = ovaleData
        self.splitByTag = function(tag, node, nodeList, annotation)
            local visitor = self.splitByTagVisitors[node.type]
            if  not visitor then
                self.tracer:error("Unable to split-by-tag node of type '%s'.", node.type)
                return 
            else
                return visitor(tag, node, nodeList, annotation)
            end
        end
        self.splitByTagAction = function(tag, node, nodeList, annotation)
            local bodyNode, conditionNode
            local actionTag, invokesGCD
            local name = "UNKNOWN"
            local actionType = node.name
            if actionType == "item" or actionType == "spell" then
                local firstParamNode = node.rawPositionalParams[1]
                local id, name
                if firstParamNode.type == "variable" then
                    name = firstParamNode.name
                    id = annotation.dictionary and annotation.dictionary[name]
                elseif firstParamNode.type == "value" then
                    name = firstParamNode.value
                    id = firstParamNode.value
                end
                if id then
                    if actionType == "item" then
                        actionTag, invokesGCD = self.ovaleData:getItemTagInfo(id)
                    elseif actionType == "spell" then
                        actionTag, invokesGCD = self.ovaleData:getSpellTagInfo(id)
                    end
                else
                    self.tracer:print("Warning: Unable to find %s '%s'", actionType, name)
                end
            elseif actionType == "texture" then
                local firstParamNode = node.rawPositionalParams[1]
                local id, name
                if firstParamNode.type == "variable" then
                    name = firstParamNode.name
                    id = annotation.dictionary and annotation.dictionary[name]
                elseif firstParamNode.type == "value" then
                    name = firstParamNode.value
                    id = name
                end
                if id then
                    actionTag, invokesGCD = self.ovaleData:getSpellTagInfo(id)
                    if actionTag == nil then
                        actionTag, invokesGCD = self.ovaleData:getItemTagInfo(id)
                    end
                end
                if actionTag == nil then
                    actionTag = "main"
                    invokesGCD = true
                end
            else
                self.tracer:print("Warning: Unknown action type '%'", actionType)
            end
            if  not actionTag then
                actionTag = "main"
                invokesGCD = true
                self.tracer:print("Warning: Unable to determine tag for '%s', assuming '%s' (actionType: %s).", name, actionTag, actionType)
            end
            if actionTag == tag then
                bodyNode = node
            elseif invokesGCD and getTagPriority(actionTag) < getTagPriority(tag) then
                conditionNode = node
            end
            return bodyNode, conditionNode
        end
        self.splitByTagAddFunction = function(tag, node, nodeList, annotation)
            local bodyName, conditionName = toOvaleTaggedFunctionName(node.name, tag)
            if  not bodyName or  not conditionName then
                return 
            end
            local bodyNode, conditionNode = self.splitByTag(tag, node.child[1], nodeList, annotation)
            if  not bodyNode or bodyNode.type ~= "group" then
                local newGroupNode = self.ovaleAst:newNodeWithChildren("group", annotation.astAnnotation)
                if bodyNode then
                    newGroupNode.child[1] = bodyNode
                end
                bodyNode = newGroupNode
            end
            if  not conditionNode or conditionNode.type ~= "group" then
                local newGroupNode = self.ovaleAst:newNodeWithChildren("group", annotation.astAnnotation)
                if conditionNode then
                    newGroupNode.child[1] = conditionNode
                end
                conditionNode = newGroupNode
            end
            local bodyFunctionNode = self.ovaleAst:newNodeWithBodyAndParameters("add_function", annotation.astAnnotation, bodyNode)
            bodyFunctionNode.name = bodyName
            local conditionFunctionNode = self.ovaleAst:newNodeWithBodyAndParameters("add_function", annotation.astAnnotation, conditionNode)
            conditionFunctionNode.name = conditionName
            return bodyFunctionNode, conditionFunctionNode
        end
        self.splitByTagCustomFunction = function(tag, node, nodeList, annotation)
            local bodyNode, conditionNode
            local functionName = node.name
            if annotation.taggedFunctionName[functionName] then
                local bodyName, conditionName = toOvaleTaggedFunctionName(functionName, tag)
                if bodyName and conditionName then
                    bodyNode = self.ovaleAst:newNodeWithParameters("custom_function", annotation.astAnnotation)
                    bodyNode.name = bodyName
                    bodyNode.asString = bodyName .. "()"
                    conditionNode = self.ovaleAst:newNodeWithParameters("custom_function", annotation.astAnnotation)
                    conditionNode.name = conditionName
                    conditionNode.asString = conditionName .. "()"
                end
            else
                local functionTag = annotation.functionTag[functionName]
                if  not functionTag then
                    if find(functionName, "bloodlust") then
                        functionTag = "cd"
                    elseif find(functionName, "getinmeleerange") then
                        functionTag = "shortcd"
                    elseif find(functionName, "interruptactions") then
                        functionTag = "cd"
                    elseif find(functionName, "summonpet") then
                        functionTag = "shortcd"
                    elseif find(functionName, "useitemactions") then
                        functionTag = "cd"
                    elseif find(functionName, "usepotion") then
                        functionTag = "cd"
                    elseif find(functionName, "useheartessence") then
                        functionTag = "cd"
                    end
                end
                if functionTag then
                    if functionTag == tag then
                        bodyNode = node
                    end
                else
                    self.tracer:print("Warning: Unable to determine tag for '%s()'.", node.name)
                    bodyNode = node
                end
            end
            return bodyNode, conditionNode
        end
        self.splitByTagGroup = function(tag, node, nodeList, annotation)
            local index = #node.child
            local bodyList = {}
            local conditionList = {}
            local remainderList = {}
            while index > 0 do
                local childNode = node.child[index]
                index = index - 1
                if childNode.type ~= "comment" then
                    local bodyNode, conditionNode = self.splitByTag(tag, childNode, nodeList, annotation)
                    if conditionNode then
                        insert(conditionList, 1, conditionNode)
                        insert(remainderList, 1, conditionNode)
                    end
                    if bodyNode then
                        if #conditionList == 0 then
                            insert(bodyList, 1, bodyNode)
                        elseif #bodyList == 0 then
                            wipe(conditionList)
                            insert(bodyList, 1, bodyNode)
                        else
                            local unlessNode = self.ovaleAst:newNodeWithChildren("unless", annotation.astAnnotation)
                            local condition = self:concatenatedConditionNode(conditionList, nodeList, annotation)
                            local body = self:concatenatedBodyNode(bodyList, nodeList, annotation)
                            if condition and body then
                                unlessNode.child[1] = condition
                                unlessNode.child[2] = body
                            end
                            wipe(bodyList)
                            wipe(conditionList)
                            insert(bodyList, 1, unlessNode)
                            local commentNode = self.ovaleAst:newNode("comment", annotation.astAnnotation)
                            insert(bodyList, 1, commentNode)
                            insert(bodyList, 1, bodyNode)
                        end
                        if index > 0 then
                            childNode = node.child[index]
                            if childNode.type ~= "comment" then
                                bodyNode, conditionNode = self.splitByTag(tag, childNode, nodeList, annotation)
                                if  not bodyNode and index > 1 then
                                    local start = index - 1
                                    for k = index - 1, 1, -1 do
                                        childNode = node.child[k]
                                        if childNode.type == "comment" then
                                            if childNode.comment and sub(childNode.comment, 1, 5) == "pool_" then
                                                start = k
                                                break
                                            end
                                        else
                                            break
                                        end
                                    end
                                    if start < index - 1 then
                                        for k = index - 1, start, -1 do
                                            insert(bodyList, 1, node.child[k])
                                        end
                                        index = start - 1
                                    end
                                end
                            end
                        end
                        while index > 0 do
                            childNode = node.child[index]
                            if childNode.type == "comment" then
                                insert(bodyList, 1, childNode)
                                index = index - 1
                            else
                                break
                            end
                        end
                    end
                end
            end
            local bodyNode = self:concatenatedBodyNode(bodyList, nodeList, annotation)
            local conditionNode = self:concatenatedConditionNode(conditionList, nodeList, annotation)
            local remainderNode = self:concatenatedConditionNode(remainderList, nodeList, annotation)
            if bodyNode then
                if conditionNode then
                    local unlessNode = self.ovaleAst:newNodeWithChildren("unless", annotation.astAnnotation)
                    unlessNode.child[1] = conditionNode
                    unlessNode.child[2] = bodyNode
                    local groupNode = self.ovaleAst:newNodeWithChildren("group", annotation.astAnnotation)
                    groupNode.child[1] = unlessNode
                    bodyNode = groupNode
                end
                conditionNode = remainderNode
            end
            return bodyNode, conditionNode
        end
        self.splitByTagIf = function(tag, node, nodeList, annotation)
            local bodyNode, conditionNode = self.splitByTag(tag, node.child[2], nodeList, annotation)
            if conditionNode then
                local lhsNode = node.child[1]
                local rhsNode = conditionNode
                if node.type == "unless" then
                    lhsNode = self:newLogicalNode("not", lhsNode, nil, annotation.astAnnotation)
                end
                local andNode = self:newLogicalNode("and", lhsNode, rhsNode, annotation.astAnnotation)
                conditionNode = andNode
            end
            if bodyNode then
                local ifNode = self.ovaleAst:newNodeWithChildren(node.type, annotation.astAnnotation)
                ifNode.type = node.type
                ifNode.child[1] = node.child[1]
                ifNode.child[2] = bodyNode
                bodyNode = ifNode
            end
            return bodyNode, conditionNode
        end
        self.splitByTagState = function(tag, node, nodeList, annotation)
            return node, nil
        end
        self.splitByTagVisitors = {
            ["action"] = self.splitByTagAction,
            ["add_function"] = self.splitByTagAddFunction,
            ["custom_function"] = self.splitByTagCustomFunction,
            ["group"] = self.splitByTagGroup,
            ["if"] = self.splitByTagIf,
            ["state"] = self.splitByTagState,
            ["unless"] = self.splitByTagIf
        }
        self.tracer = ovaleDebug:create("SimulationCraftSplitter")
    end,
    newLogicalNode = function(self, operator, lhsNode, rhsNode, annotation)
        local node = self.ovaleAst:newNodeWithChildren("logical", annotation)
        node.operator = operator
        if  not rhsNode then
            node.expressionType = "unary"
            node.child[1] = lhsNode
        else
            node.expressionType = "binary"
            node.child[1] = lhsNode
            node.child[2] = rhsNode
        end
        return node
    end,
    concatenatedConditionNode = function(self, conditionList, nodeList, annotation)
        local conditionNode
        if #conditionList > 0 then
            if #conditionList == 1 then
                conditionNode = conditionList[1]
            elseif #conditionList > 1 then
                local lhsNode = conditionList[1]
                local rhsNode = conditionList[2]
                conditionNode = self:newLogicalNode("or", lhsNode, rhsNode, annotation.astAnnotation)
                for k = 3, #conditionList, 1 do
                    lhsNode = conditionNode
                    rhsNode = conditionList[k]
                    conditionNode = self:newLogicalNode("or", lhsNode, rhsNode, annotation.astAnnotation)
                end
            end
        end
        return conditionNode
    end,
    concatenatedBodyNode = function(self, bodyList, nodeList, annotation)
        local bodyNode
        if #bodyList > 0 then
            bodyNode = self.ovaleAst:newNodeWithChildren("group", annotation.astAnnotation)
            for k, node in ipairs(bodyList) do
                bodyNode.child[k] = node
            end
        end
        return bodyNode
    end,
})
