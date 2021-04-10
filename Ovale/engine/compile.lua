local __exports = LibStub:NewLibrary("ovale/engine/compile", 90048)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __statesPower = LibStub:GetLibrary("ovale/states/Power")
local powerTypes = __statesPower.powerTypes
local aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
local ipairs = ipairs
local pairs = pairs
local tonumber = tonumber
local tostring = tostring
local wipe = wipe
local kpairs = pairs
local match = string.match
local sub = string.sub
local insert = table.insert
local GetSpellInfo = GetSpellInfo
local __toolstools = LibStub:GetLibrary("ovale/tools/tools")
local isNumber = __toolstools.isNumber
local numberPattern = "^%-?%d+%.?%d*$"
__exports.requireValue = function(value)
    local required = sub(tostring(value), 1, 1) ~= "!"
    if  not required then
        value = sub(value, 2)
        if match(value, numberPattern) then
            return tonumber(value), required
        end
    end
    return value, required
end
__exports.requireNumber = function(value)
    if isNumber(value) then
        return value, true
    end
    local required = sub(tostring(value), 1, 1) ~= "!"
    if  not required then
        value = sub(value, 2)
        return tonumber(value), required
    end
    return tonumber(value), required
end
local auraTableDispatch = {
    spelladdbuff = {
        filter = "HELPFUL",
        target = "player"
    },
    spelladddebuff = {
        filter = "HARMFUL",
        target = "player"
    },
    spelladdpetbuff = {
        filter = "HELPFUL",
        target = "pet"
    },
    spelladdpetdebuff = {
        filter = "HARMFUL",
        target = "pet"
    },
    spelladdtargetbuff = {
        filter = "HELPFUL",
        target = "target"
    },
    spelladdtargetdebuff = {
        filter = "HARMFUL",
        target = "target"
    },
    spelldamagebuff = {
        filter = "HELPFUL",
        target = "damage"
    },
    spelldamagedebuff = {
        filter = "HARMFUL",
        target = "damage"
    }
}
__exports.OvaleCompileClass = __class(nil, {
    constructor = function(self, ovaleAzerite, ovaleAst, ovaleCondition, ovaleCooldown, ovaleData, ovaleProfiler, ovaleDebug, ovale, ovaleScore, ovaleSpellBook, controls, script)
        self.ovaleAzerite = ovaleAzerite
        self.ovaleAst = ovaleAst
        self.ovaleCondition = ovaleCondition
        self.ovaleCooldown = ovaleCooldown
        self.ovaleData = ovaleData
        self.ovaleDebug = ovaleDebug
        self.ovale = ovale
        self.ovaleScore = ovaleScore
        self.ovaleSpellBook = ovaleSpellBook
        self.controls = controls
        self.script = script
        self.serial = nil
        self.ast = nil
        self.nextSerial = 0
        self.timesEvaluated = 0
        self.icon = {}
        self.handleInitialize = function()
            self.module:RegisterMessage("Ovale_CheckBoxValueChanged", self.handleScriptControlChanged)
            self.module:RegisterMessage("Ovale_ListValueChanged", self.handleScriptControlChanged)
            self.module:RegisterMessage("Ovale_ScriptChanged", self.handleScriptChanged)
            self.module:RegisterMessage("Ovale_SpecializationChanged", self.handleScriptChanged)
            self.module:SendMessage("Ovale_ScriptChanged")
        end
        self.handleDisable = function()
            self.module:UnregisterMessage("Ovale_CheckBoxValueChanged")
            self.module:UnregisterMessage("Ovale_ListValueChanged")
            self.module:UnregisterMessage("Ovale_ScriptChanged")
            self.module:UnregisterMessage("Ovale_SpecializationChanged")
        end
        self.handleScriptChanged = function(event)
            self:compileScript(self.script:getCurrentSpecScriptName())
            self.eventHandler(event)
        end
        self.handleScriptControlChanged = function(event, name)
            if  not name then
                self.eventHandler(event)
            else
                local control
                if event == "Ovale_CheckBoxValueChanged" then
                    control = self.controls.checkBoxesByName[name]
                elseif event == "Ovale_ListValueChanged" then
                    control = self.controls.listsByName[name]
                end
                if control and control.triggerEvaluation then
                    self.eventHandler(event)
                end
            end
        end
        self.eventHandler = function(event)
            self.nextSerial = self.nextSerial + 1
            self.tracer:debug("%s: advance age to %d.", event, self.nextSerial)
            self.ovale:needRefresh()
        end
        self.tracer = ovaleDebug:create("OvaleCompile")
        self.profiler = ovaleProfiler:create("OvaleCompile")
        self.module = ovale:createModule("OvaleCompile", self.handleInitialize, self.handleDisable, aceEvent)
    end,
    evaluateAddCheckBox = function(self, node)
        local ok = true
        local name, positionalParams, namedParams = node.name, node.rawPositionalParams, node.rawNamedParams
        local description = (node.description.type == "string" and node.description.value) or node.name
        local defaultValue = false
        for _, v in ipairs(positionalParams) do
            if v.type == "string" and v.value == "default" then
                defaultValue = true
                break
            end
        end
        if self.controls:addCheckBox(name, description, defaultValue, namedParams.enabled) then
            self.nextSerial = self.nextSerial + 1
            self.tracer:debug("New checkbox '%s': advance age to %d.", name, self.nextSerial)
        end
        return ok
    end,
    evaluateAddIcon = function(self, node)
        self.icon[#self.icon + 1] = node
        return true
    end,
    evaluateAddListItem = function(self, node)
        local ok = true
        local name, item, positionalParams, namedParams = node.name, node.item, node.rawPositionalParams, node.rawNamedParams
        if item then
            local defaultValue = false
            for _, v in ipairs(positionalParams) do
                if v.type == "string" and v.value == "default" then
                    defaultValue = true
                    break
                end
            end
            local description = (node.description.type == "string" and node.description.value) or item
            if self.controls:addListItem(name, item, description, defaultValue, namedParams.enabled) then
                self.nextSerial = self.nextSerial + 1
                self.tracer:debug("New list '%s': advance age to %d.", name, self.nextSerial)
            end
        end
        return ok
    end,
    evaluateItemInfo = function(self, node)
        local ok = true
        local itemId, namedParams = node.itemId, node.rawNamedParams
        if itemId then
            local ii = self.ovaleData:getItemInfo(itemId)
            for k, v in kpairs(namedParams) do
                if v.type == "value" or v.type == "string" then
                    ii[k] = v.value
                else
                    ok = false
                    break
                end
            end
            self.ovaleData.itemInfo[itemId] = ii
        end
        return ok
    end,
    evaluateItemRequire = function(self, node)
        local property = node.property
        local ii = self.ovaleData:getItemInfo(node.itemId)
        local tbl = ii.require[property] or {}
        insert(tbl, node)
        ii.require[property] = tbl
        return true
    end,
    evaluateList = function(self, node)
        local ok = true
        local name, positionalParams = node.name, node.rawPositionalParams
        local listDB
        if node.keyword == "ItemList" then
            listDB = "itemList"
        else
            listDB = "buffSpellList"
        end
        local list = self.ovaleData[listDB][name] or {}
        for _, _id in pairs(positionalParams) do
            if _id.type == "value" and isNumber(_id.value) then
                list[_id.value] = true
            else
                self.tracer:error("%s is not a number in the '%s' list", _id.asString, name)
                ok = false
                break
            end
        end
        self.ovaleData[listDB][name] = list
        return ok
    end,
    evaluateScoreSpells = function(self, node)
        local ok = true
        local positionalParams = node.rawPositionalParams
        for _, _spellId in ipairs(positionalParams) do
            if _spellId.type == "value" and isNumber(_spellId.value) then
                self.ovaleScore:addSpell(_spellId.value)
            else
                ok = false
                break
            end
        end
        return ok
    end,
    evaluateSpellAuraList = function(self, node)
        local ok = true
        local spellId = node.spellId
        if  not spellId then
            self.tracer:error("No spellId for name %s", node.name)
            return false
        end
        local keyword = node.keyword
        local si = self.ovaleData:getSpellInfo(spellId)
        if si.aura then
            local auraInfo = auraTableDispatch[keyword]
            local auraTable = si.aura[auraInfo.target]
            local filter = auraInfo.filter
            local tbl = auraTable[filter] or {}
            tbl[node.buffSpellId] = node
            local buff = self.ovaleData:getSpellInfo(node.buffSpellId)
            buff.effect = auraInfo.filter
        end
        return ok
    end,
    evaluateSpellInfo = function(self, node)
        local addpower = {}
        for _, powertype in ipairs(powerTypes) do
            local key = "add" .. powertype
            addpower[key] = powertype
        end
        local ok = true
        local spellId, _, namedParams = node.spellId, node.rawPositionalParams, node.rawNamedParams
        if spellId then
            local si = self.ovaleData:getSpellInfo(spellId)
            for k, v in kpairs(namedParams) do
                if k == "add_duration" then
                    if v.type == "value" then
                        local realValue = v.value
                        if namedParams.pertrait and namedParams.pertrait.type == "value" then
                            realValue = v.value * self.ovaleAzerite:traitRank(namedParams.pertrait.value)
                        end
                        local addDuration = si.add_duration or 0
                        si.add_duration = addDuration + realValue
                    else
                        ok = false
                        break
                    end
                elseif k == "add_cd" then
                    local value = tonumber(v)
                    if value then
                        local addCd = si.add_cd or 0
                        si.add_cd = addCd + value
                    else
                        ok = false
                        break
                    end
                elseif k == "addlist" and v.type == "string" then
                    local list = self.ovaleData.buffSpellList[v.value] or {}
                    list[spellId] = true
                    self.ovaleData.buffSpellList[v.value] = list
                elseif k == "dummy_replace" and v.type == "string" then
                    local spellName = GetSpellInfo(v.value)
                    if  not spellName then
                        spellName = v.value
                    end
                    self.ovaleSpellBook:addSpell(spellId, spellName)
                elseif k == "learn" and v.type == "value" and v.value == 1 then
                    local spellName = GetSpellInfo(spellId)
                    if spellName then
                        self.ovaleSpellBook:addSpell(spellId, spellName)
                    end
                elseif k == "shared_cd" and v.type == "string" then
                    si.shared_cd = v.value
                    self.ovaleCooldown:addSharedCooldown(v.value, spellId)
                elseif addpower[k] ~= nil then
                    if v.type == "value" then
                        local realValue = v.value
                        if namedParams.pertrait and namedParams.pertrait.type == "value" then
                            realValue = v.value * self.ovaleAzerite:traitRank(namedParams.pertrait.value)
                        end
                        local power = si[k] or 0
                        (si)[k] = power + realValue
                    else
                        self.tracer:error("Unexpected value type %s in a addpower SpellInfo parameter (should be value)", v.type)
                        ok = false
                        break
                    end
                else
                    if v.type == "value" or v.type == "string" then
                        si[k] = v.value
                    else
                        self.tracer:error("Unexpected value type %s in a SpellInfo parameter (should be value or string)", v.type)
                        ok = false
                        break
                    end
                end
            end
        end
        return ok
    end,
    evaluateSpellRequire = function(self, node)
        local ok = true
        local spellId = node.spellId, node.rawPositionalParams, node.rawNamedParams
        local property = node.property
        local si = self.ovaleData:getSpellInfo(spellId)
        local tbl = si.require[property] or {}
        insert(tbl, node)
        si.require[property] = tbl
        return ok
    end,
    addMissingVariantSpells = function(self, annotation)
        if annotation.spellNode then
            for _, spellIdParam in ipairs(annotation.spellNode) do
                if spellIdParam.type == "value" then
                    local spellId = spellIdParam.value
                    if  not self.ovaleSpellBook:isKnownSpell(spellId) and  not self.ovaleCooldown:isSharedCooldown(spellId) then
                        local spellName = self.ovaleSpellBook:getSpellName(spellId)
                        if spellName then
                            local name = GetSpellInfo(spellName)
                            if spellName == name then
                                self.tracer:debug("Learning spell %s with ID %d.", spellName, spellId)
                                self.ovaleSpellBook:addSpell(spellId, spellName)
                            end
                        elseif spellId > 0 then
                            self.tracer:error("Unknown spell with ID %s.", spellId)
                        end
                    end
                elseif spellIdParam.type == "string" then
                    if  not self.ovaleData.buffSpellList[spellIdParam.value] then
                        self.tracer:error("Unknown spell list %s", spellIdParam.value)
                    end
                elseif spellIdParam.type == "variable" then
                    self.tracer:error("Spell argument %s must be either a spell id or a spell list name.", spellIdParam.name)
                else
                    self.tracer:error("Spell argument must be either a spell id or a spell list name.")
                end
            end
        end
    end,
    updateTrinketInfo = function(self)
    end,
    compileScript = function(self, name)
        self.ovaleDebug:resetTrace()
        self.tracer:debug("Compiling script '%s'.", name)
        if self.ast then
            self.ovaleAst:release(self.ast)
            self.ast = nil
        end
        if self.ovaleCondition:hasAny() then
            self.ast = self.ovaleAst:parseNamedScript(name)
            self.tracer:debug("Compilation result: " .. ((self.ast ~= nil and "success") or "failed"))
        else
            self.tracer:debug("No conditions. No need to compile.")
        end
        self.controls:reset()
        return self.ast
    end,
    evaluateScript = function(self, ast, forceEvaluation)
        self.profiler:startProfiling("OvaleCompile_EvaluateScript")
        local changed = false
        ast = ast or self.ast
        if ast and (forceEvaluation or  not self.serial or self.serial < self.nextSerial) then
            self.tracer:debug("Script has changed. Evaluating...")
            changed = true
            local ok = true
            wipe(self.icon)
            self.ovaleData:reset()
            self.ovaleCooldown:resetSharedCooldowns()
            self.timesEvaluated = self.timesEvaluated + 1
            self.serial = self.nextSerial
            for _, node in ipairs(ast.child) do
                if node.type == "checkbox" then
                    ok = self:evaluateAddCheckBox(node)
                elseif node.type == "icon" then
                    ok = self:evaluateAddIcon(node)
                elseif node.type == "list_item" then
                    ok = self:evaluateAddListItem(node)
                elseif node.type == "item_info" then
                    ok = self:evaluateItemInfo(node)
                elseif node.type == "itemrequire" then
                    ok = self:evaluateItemRequire(node)
                elseif node.type == "list" then
                    ok = self:evaluateList(node)
                elseif node.type == "score_spells" then
                    ok = self:evaluateScoreSpells(node)
                elseif node.type == "spell_aura_list" then
                    ok = self:evaluateSpellAuraList(node)
                elseif node.type == "spell_info" then
                    ok = self:evaluateSpellInfo(node)
                elseif node.type == "spell_require" then
                    ok = self:evaluateSpellRequire(node)
                elseif node.type ~= "define" and node.type ~= "add_function" then
                    self.tracer:error("Unknown node type", node.type)
                    ok = false
                end
                if  not ok then
                    break
                end
            end
            if ok then
                if ast.annotation then
                    self:addMissingVariantSpells(ast.annotation)
                end
                self:updateTrinketInfo()
            end
        end
        self.profiler:stopProfiling("OvaleCompile_EvaluateScript")
        return changed
    end,
    getFunctionNode = function(self, name)
        local node
        if self.ast and self.ast.annotation and self.ast.annotation.customFunction then
            node = self.ast.annotation.customFunction[name]
        end
        return node
    end,
    getIconNodes = function(self)
        return self.icon
    end,
    debugCompile = function(self)
        self.tracer:print("Total number of times the script was evaluated: %d", self.timesEvaluated)
    end,
})
