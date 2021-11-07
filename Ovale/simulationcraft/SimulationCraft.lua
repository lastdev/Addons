local __exports = LibStub:NewLibrary("ovale/simulationcraft/SimulationCraft", 90112)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.AceConfig = LibStub:GetLibrary("AceConfig-3.0", true)
__imports.AceConfigDialog = LibStub:GetLibrary("AceConfigDialog-3.0", true)
__imports.__uiLocalization = LibStub:GetLibrary("ovale/ui/Localization")
__imports.l = __imports.__uiLocalization.l
__imports.__toolstools = LibStub:GetLibrary("ovale/tools/tools")
__imports.isLuaArray = __imports.__toolstools.isLuaArray
__imports.__definitions = LibStub:GetLibrary("ovale/simulationcraft/definitions")
__imports.Annotation = __imports.__definitions.Annotation
__imports.consumableItems = __imports.__definitions.consumableItems
__imports.ovaleIconTags = __imports.__definitions.ovaleIconTags
__imports.classInfos = __imports.__definitions.classInfos
__imports.__texttools = LibStub:GetLibrary("ovale/simulationcraft/text-tools")
__imports.printRepeat = __imports.__texttools.printRepeat
__imports.toOvaleFunctionName = __imports.__texttools.toOvaleFunctionName
__imports.toOvaleTaggedFunctionName = __imports.__texttools.toOvaleTaggedFunctionName
__imports.outputPool = __imports.__texttools.outputPool
__imports.toLowerSpecialization = __imports.__texttools.toLowerSpecialization
__imports.toCamelCase = __imports.__texttools.toCamelCase
__imports.__generator = LibStub:GetLibrary("ovale/simulationcraft/generator")
__imports.markNode = __imports.__generator.markNode
__imports.sweepNode = __imports.__generator.sweepNode
local AceConfig = __imports.AceConfig
local AceConfigDialog = __imports.AceConfigDialog
local l = __imports.l
local format = string.format
local gmatch = string.gmatch
local gsub = string.gsub
local lower = string.lower
local match = string.match
local sub = string.sub
local ipairs = ipairs
local pairs = pairs
local tonumber = tonumber
local type = type
local wipe = wipe
local kpairs = pairs
local concat = table.concat
local insert = table.insert
local sort = table.sort
local RAID_CLASS_COLORS = RAID_CLASS_COLORS
local isLuaArray = __imports.isLuaArray
local Annotation = __imports.Annotation
local consumableItems = __imports.consumableItems
local ovaleIconTags = __imports.ovaleIconTags
local classInfos = __imports.classInfos
local printRepeat = __imports.printRepeat
local toOvaleFunctionName = __imports.toOvaleFunctionName
local toOvaleTaggedFunctionName = __imports.toOvaleTaggedFunctionName
local outputPool = __imports.outputPool
local toLowerSpecialization = __imports.toLowerSpecialization
local toCamelCase = __imports.toCamelCase
local markNode = __imports.markNode
local sweepNode = __imports.sweepNode
local lastSimC = ""
local lastScript = ""
local name = "OvaleSimulationCraft"
__exports.OvaleSimulationCraftClass = __class(nil, {
    constructor = function(self, ovaleOptions, ovaleData, emiter, ovaleAst, parser, unparser, ovaleDebug, ovaleCompile, splitter, generator, ovale, controls)
        self.ovaleOptions = ovaleOptions
        self.ovaleData = ovaleData
        self.emiter = emiter
        self.ovaleAst = ovaleAst
        self.parser = parser
        self.unparser = unparser
        self.ovaleDebug = ovaleDebug
        self.ovaleCompile = ovaleCompile
        self.splitter = splitter
        self.generator = generator
        self.ovale = ovale
        self.controls = controls
        self.handleInitialize = function()
            self.emiter:initializeDisambiguation()
            self:createOptions()
        end
        self.handleDisable = function()
        end
        self:registerOptions()
        self.module = ovale:createModule("OvaleSimulationCraft", self.handleInitialize, self.handleDisable)
        self.tracer = ovaleDebug:create("SimulationCraft")
    end,
    addSymbol = function(self, annotation, symbol)
        local symbolTable = annotation.symbolTable or {}
        local symbolList = annotation.symbolList
        if  not symbolTable[symbol] and  not self.ovaleData.defaultSpellLists[symbol] then
            symbolTable[symbol] = true
            symbolList[#symbolList + 1] = symbol
        end
        annotation.symbolTable = symbolTable
        annotation.symbolList = symbolList
    end,
    registerOptions = function(self)
        local actions = {
            simc = {
                name = "SimulationCraft",
                type = "execute",
                func = function()
                    local appName = name
                    AceConfigDialog:SetDefaultSize(appName, 700, 550)
                    AceConfigDialog:Open(appName)
                end

            }
        }
        for k, v in pairs(actions) do
            self.ovaleOptions.actions.args[k] = v
        end
        local defaultDB = {
            overrideCode = ""
        }
        for k, v in pairs(defaultDB) do
            (self.ovaleOptions.defaultDB.profile)[k] = v
        end
    end,
    toString = function(self, tbl)
        local output = printRepeat(tbl)
        return concat(output, "\n")
    end,
    release = function(self, profile)
        if profile.annotation then
            local annotation = profile.annotation
            if annotation.astAnnotation then
                self.ovaleAst:releaseAnnotation(annotation.astAnnotation)
            end
            if annotation.nodeList then
                self.parser:release(annotation.nodeList)
            end
            for key, value in kpairs(annotation) do
                if type(value) == "table" then
                    wipe(value)
                end
                annotation[key] = nil
            end
        end
        wipe(profile)
    end,
    readProfile = function(self, simc)
        local parsedProfile = {}
        for _line in gmatch(simc, "[^\r\n]+") do
            local line = match(_line, "^%s*(.-)%s*$")
            if  not (match(line, "^#.*") or match(line, "^$")) then
                local k, operator, value = match(line, "([^%+=]+)(%+?=)(.*)")
                local key = k
                if operator == "=" then
                    (parsedProfile)[key] = value
                elseif operator == "+=" then
                    if type(parsedProfile[key]) ~= "table" then
                        local oldValue = parsedProfile[key]
                        parsedProfile[key] = {}
                        insert(parsedProfile[key], oldValue)
                    end
                    insert(parsedProfile[key], value)
                end
            end
        end
        for k, v in kpairs(parsedProfile) do
            if isLuaArray(v) then
                (parsedProfile)[k] = concat(v)
            end
        end
        parsedProfile.templates = {}
        for k in kpairs(parsedProfile) do
            if sub(k, 1, 2) == "$(" and sub(k, -1) == ")" then
                insert(parsedProfile.templates, k)
            end
        end
        return parsedProfile
    end,
    parseProfile = function(self, simc, dictionary, dbc)
        local profile = self:readProfile(simc)
        local classId = nil
        local name = nil
        for className in kpairs(RAID_CLASS_COLORS) do
            local lowerClass = lower(className)
            if profile[lowerClass] then
                classId = className
                name = profile[lowerClass]
            end
        end
        if  not classId or  not name or  not profile.spec then
            return nil
        end
        local annotation = __imports.Annotation(self.ovaleData, name, classId, profile.spec)
        if dbc then
            annotation.dbc = dbc
        end
        if dictionary then
            annotation.dictionary = dictionary
        end
        profile.annotation = annotation
        local ok = true
        local nodeList = {}
        local actionList = {}
        for k, _v in kpairs(profile) do
            local v = _v
            if ok and match(k, "^actions") then
                local name = match(k, "^actions%.([%w_]+)")
                if  not name then
                    name = "_default"
                end
                for index = #profile.templates, 1, -1 do
                    local template = profile.templates[index]
                    local variable = sub(template, 3, -2)
                    local pattern = "%$%(" .. variable .. "%)"
                    v = gsub(v, pattern, profile[template])
                end
                local node = self.parser:parseActionList(name, v, nodeList, annotation)
                if node then
                    actionList[#actionList + 1] = node
                else
                    self.tracer:error("Error while parsing action list " .. name)
                    break
                end
            end
        end
        sort(actionList, function(a, b)
            return a.name < b.name
        end
)
        annotation.specialization = profile.spec
        annotation.level = profile.level
        ok = ok and annotation.classId ~= nil and annotation.specialization ~= nil and annotation.level ~= nil
        annotation.pet = profile.default_pet
        local consumables = annotation.consumables
        for k, v in pairs(consumableItems) do
            if v then
                if profile[k] ~= nil then
                    consumables[k] = profile[k]
                end
            end
        end
        if profile.role == "tank" then
            annotation.role = profile.role
            annotation.melee = annotation.classId
        elseif profile.role == "spell" then
            annotation.role = profile.role
            annotation.ranged = annotation.classId
        elseif profile.role == "attack" or profile.role == "dps" then
            annotation.role = "attack"
            if profile.position == "ranged_back" then
                annotation.ranged = annotation.classId
            else
                annotation.melee = annotation.classId
            end
        end
        annotation.position = profile.position
        local taggedFunctionName = annotation.taggedFunctionName
        for _, node in ipairs(actionList) do
            local fname = toOvaleFunctionName(node.name, annotation)
            taggedFunctionName[fname] = true
            for _, tag in pairs(ovaleIconTags) do
                local bodyName, conditionName = toOvaleTaggedFunctionName(fname, tag)
                if bodyName and conditionName then
                    taggedFunctionName[lower(bodyName)] = true
                    taggedFunctionName[lower(conditionName)] = true
                end
            end
        end
        annotation.functionTag = {}
        profile.actionList = actionList
        profile.annotation = annotation
        annotation.nodeList = nodeList
        if  not ok then
            self:release(profile)
            return nil
        end
        return profile
    end,
    unparse = function(self, profile)
        local output = outputPool:get()
        if profile.actionList then
            for _, node in ipairs(profile.actionList) do
                output[#output + 1] = self.unparser:unparse(node) or ""
            end
        end
        local s = concat(output, "\n")
        outputPool:release(output)
        return s
    end,
    emitAST = function(self, profile)
        local nodeList = {}
        local ast = self.ovaleAst:newNodeWithChildren("script", profile.annotation.astAnnotation)
        local child = ast.child
        local annotation = profile.annotation
        local ok = true
        if profile.actionList then
            if annotation.astAnnotation then
                annotation.astAnnotation.nodeList = nodeList
            else
                annotation.astAnnotation = {
                    nodeList = nodeList,
                    definition = annotation.dictionary
                }
            end
            self.ovaleDebug:resetTrace()
            local dictionaryAnnotation = {
                nodeList = {},
                definition = profile.annotation.dictionary
            }
            local dictionaryFormat = [[
            Include(ovale_common)
            Include(ovale_%s_spells)
            %s
        ]]
            local dictionaryCode = format(dictionaryFormat, lower(annotation.classId), self.ovaleOptions.db.profile.overrideCode or "")
            local dictionaryAST = self.ovaleAst:parseCode("script", dictionaryCode, dictionaryAnnotation.nodeList, dictionaryAnnotation)
            if dictionaryAST and dictionaryAST.type == "script" then
                dictionaryAST.annotation = dictionaryAnnotation
                annotation.dictionaryAST = dictionaryAST
                annotation.dictionary = dictionaryAnnotation.definition
                self.ovaleAst:propagateConstants(dictionaryAST)
                self.ovaleAst:propagateStrings(dictionaryAST)
                self.controls:reset()
                self.ovaleCompile:evaluateScript(dictionaryAST, true)
            end
            for _, node in ipairs(profile.actionList) do
                local addFunctionNode = self.emiter.emitActionList(node, nodeList, annotation, nil)
                if addFunctionNode and addFunctionNode.type == "add_function" then
                    if node.name == "_default" and  not annotation.interrupt then
                        local defaultInterrupt = classInfos[annotation.classId][annotation.specialization]
                        if defaultInterrupt and defaultInterrupt.interrupt then
                            local interruptCall = self.ovaleAst:newNodeWithParameters("custom_function", annotation.astAnnotation)
                            interruptCall.name = lower(toLowerSpecialization(annotation) .. "InterruptActions")
                            annotation.interrupt = annotation.classId
                            annotation[defaultInterrupt.interrupt] = annotation.classId
                            insert(addFunctionNode.body.child, 1, interruptCall)
                        end
                    end
                    local actionListName = gsub(node.name, "^_+", "")
                    local commentNode = self.ovaleAst:newNode("comment", annotation.astAnnotation)
                    commentNode.comment = "## actions." .. actionListName
                    child[#child + 1] = commentNode
                    for _, tag in pairs(ovaleIconTags) do
                        local bodyNode, conditionNode = self.splitter.splitByTag(tag, addFunctionNode, nodeList, annotation)
                        if bodyNode and conditionNode then
                            child[#child + 1] = bodyNode
                            child[#child + 1] = conditionNode
                        end
                    end
                else
                    ok = false
                    break
                end
            end
        end
        if ok then
            annotation.supportingFunctionCount = self.generator:insertSupportingFunctions(child, annotation)
            annotation.supportingInterruptCount = (annotation.interrupt and self.generator:insertInterruptFunctions(child, annotation)) or nil
            annotation.supportingControlCount = self.generator:insertSupportingControls(child, annotation)
            self.generator:insertVariables(child, annotation)
            local className, specialization = annotation.classId, annotation.specialization
            local lowerclass = lower(className)
            local aoeToggle = "opt_" .. lowerclass .. "_" .. specialization .. "_aoe"
            do
                local commentNode = self.ovaleAst:newNode("comment", annotation.astAnnotation)
                commentNode.comment = "## " .. toCamelCase(specialization) .. " icons."
                insert(child, commentNode)
                local code = format("AddCheckBox(%s L(AOE) default enabled=(specialization(%s)))", aoeToggle, specialization)
                local node = self.ovaleAst:parseCode("checkbox", code, nodeList, annotation.astAnnotation)
                if node then
                    insert(child, node)
                end
            end
            do
                local fmt = [[
				AddIcon enabled=(not checkboxon(%s) and specialization(%s)) enemies=1 help=shortcd
				{
					%s
				}
			]]
                local code = format(fmt, aoeToggle, specialization, self.generator:generateIconBody("shortcd", profile))
                local node = self.ovaleAst:parseCode("icon", code, nodeList, annotation.astAnnotation)
                if node then
                    insert(child, node)
                end
            end
            do
                local fmt = [[
				AddIcon enabled=(checkboxon(%s) and specialization(%s)) help=shortcd
				{
					%s
				}
			]]
                local code = format(fmt, aoeToggle, specialization, self.generator:generateIconBody("shortcd", profile))
                local node = self.ovaleAst:parseCode("icon", code, nodeList, annotation.astAnnotation)
                if node then
                    insert(child, node)
                end
            end
            do
                local fmt = [[
				AddIcon enemies=1 help=main enabled=(specialization(%s))
				{
					%s
				}
			]]
                local code = format(fmt, specialization, self.generator:generateIconBody("main", profile))
                local node = self.ovaleAst:parseCode("icon", code, nodeList, annotation.astAnnotation)
                if node then
                    insert(child, node)
                end
            end
            do
                local fmt = [[
				AddIcon help=aoe enabled=(checkboxon(%s) and specialization(%s))
				{
					%s
				}
			]]
                local code = format(fmt, aoeToggle, specialization, self.generator:generateIconBody("main", profile))
                local node = self.ovaleAst:parseCode("icon", code, nodeList, annotation.astAnnotation)
                if node then
                    insert(child, node)
                end
            end
            do
                local fmt = [[
				AddIcon enemies=1 help=cd enabled=(not checkboxon(%s) and specialization(%s))
				{
					%s
				}
			]]
                local code = format(fmt, aoeToggle, specialization, self.generator:generateIconBody("cd", profile))
                local node = self.ovaleAst:parseCode("icon", code, nodeList, annotation.astAnnotation)
                if node then
                    insert(child, node)
                end
            end
            do
                local fmt = [[
				AddIcon enabled=(checkboxon(%s) and specialization(%s)) help=cd
				{
					%s
				}
			]]
                local code = format(fmt, aoeToggle, specialization, self.generator:generateIconBody("cd", profile))
                local node = self.ovaleAst:parseCode("icon", code, nodeList, annotation.astAnnotation)
                if node then
                    insert(child, node)
                end
            end
            markNode(ast)
            local changed = sweepNode(ast)
            while changed do
                markNode(ast)
                changed = sweepNode(ast)
            end
            markNode(ast)
            sweepNode(ast)
        end
        if  not ok then
            self.ovaleAst:release(ast)
            return nil
        end
        return ast
    end,
    emit = function(self, profile, noFinalNewLine)
        local ast = self:emitAST(profile)
        if  not ast then
            return "error"
        end
        local annotation = profile.annotation
        local className = annotation.classId
        local lowerclass = lower(className)
        local specialization = annotation.specialization
        local output = outputPool:get()
        do
            output[#output + 1] = "# Based on SimulationCraft profile " .. annotation.name .. "."
            output[#output + 1] = "#	class=" .. lowerclass
            output[#output + 1] = "#	spec=" .. specialization
            if profile.talents then
                output[#output + 1] = "#	talents=" .. profile.talents
            end
            if profile.glyphs then
                output[#output + 1] = "#	glyphs=" .. profile.glyphs
            end
            if profile.default_pet then
                output[#output + 1] = "#	pet=" .. profile.default_pet
            end
        end
        do
            output[#output + 1] = ""
            output[#output + 1] = "Include(ovale_common)"
            output[#output + 1] = format("Include(ovale_%s_spells)", lowerclass)
            local overrideCode = self.ovaleOptions.db.profile.overrideCode
            if overrideCode and overrideCode ~= "" then
                output[#output + 1] = ""
                output[#output + 1] = "# Overrides."
                output[#output + 1] = overrideCode
            end
            if annotation.supportingControlCount and annotation.supportingControlCount > 0 then
                output[#output + 1] = ""
            end
        end
        output[#output + 1] = self.ovaleAst:unparse(ast)
        if profile.annotation.symbolTable then
            output[#output + 1] = ""
            output[#output + 1] = "### Required symbols"
            sort(profile.annotation.symbolList)
            for _, symbol in ipairs(profile.annotation.symbolList) do
                if  not tonumber(symbol) and  not profile.annotation.dictionary[symbol] and  not self.ovaleData.buffSpellList[symbol] then
                    self.tracer:print("Warning: Symbol '%s' not defined", symbol)
                end
                output[#output + 1] = "# " .. symbol
            end
        end
        annotation.dictionary = {}
        if annotation.dictionaryAST then
            self.ovaleAst:release(annotation.dictionaryAST)
        end
        if  not noFinalNewLine and output[#output] ~= "" then
            output[#output + 1] = ""
        end
        local s = concat(output, "\n")
        outputPool:release(output)
        self.ovaleAst:release(ast)
        return s
    end,
    createOptions = function(self)
        local options = {
            name = self.ovale:GetName() .. " SimulationCraft",
            type = "group",
            args = {
                input = {
                    order = 10,
                    name = l["input"],
                    type = "group",
                    args = {
                        description = {
                            order = 10,
                            name = l["simulationcraft_profile_content"] .. "\nhttps://code.google.com/p/simulationcraft/source/browse/profiles",
                            type = "description"
                        },
                        input = {
                            order = 20,
                            name = l["simulationcraft_profile"],
                            type = "input",
                            multiline = 25,
                            width = "full",
                            get = function()
                                return lastSimC
                            end,
                            set = function(info, value)
                                lastSimC = value
                                local profile = self:parseProfile(lastSimC)
                                local code = ""
                                if profile then
                                    code = self:emit(profile)
                                end
                                lastScript = gsub(code, "	", "    ")
                            end
                        }
                    }
                },
                overrides = {
                    order = 20,
                    name = l["overrides"],
                    type = "group",
                    args = {
                        description = {
                            order = 10,
                            name = l["simulationcraft_overrides_description"],
                            type = "description"
                        },
                        overrides = {
                            order = 20,
                            name = l["overrides"],
                            type = "input",
                            multiline = 25,
                            width = "full",
                            get = function()
                                local code = self.ovaleOptions.db.profile.code
                                return gsub(code, "	", "    ")
                            end,
                            set = function(info, value)
                                self.ovaleOptions.db.profile.overrideCode = value
                                if lastSimC then
                                    local profile = self:parseProfile(lastSimC)
                                    local code = ""
                                    if profile then
                                        code = self:emit(profile)
                                    end
                                    lastScript = gsub(code, "	", "    ")
                                end
                            end
                        }
                    }
                },
                output = {
                    order = 30,
                    name = l["output"],
                    type = "group",
                    args = {
                        description = {
                            order = 10,
                            name = l["simulationcraft_profile_translated"],
                            type = "description"
                        },
                        output = {
                            order = 20,
                            name = l["script"],
                            type = "input",
                            multiline = 25,
                            width = "full",
                            get = function()
                                return lastScript
                            end

                        }
                    }
                }
            }
        }
        local appName = self.module:GetName()
        AceConfig:RegisterOptionsTable(appName, options)
        AceConfigDialog:AddToBlizOptions(appName, "SimulationCraft", self.ovale:GetName())
    end,
})
