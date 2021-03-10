local __exports = LibStub:NewLibrary("ovale/simulationcraft/emiter", 90047)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __definitions = LibStub:GetLibrary("ovale/simulationcraft/definitions")
local specialActions = __definitions.specialActions
local interruptsClasses = __definitions.interruptsClasses
local unaryOperators = __definitions.unaryOperators
local binaryOperators = __definitions.binaryOperators
local checkOptionalSkill = __definitions.checkOptionalSkill
local characterProperties = __definitions.characterProperties
local miscOperands = __definitions.miscOperands
local tonumber = tonumber
local kpairs = pairs
local ipairs = ipairs
local tostring = tostring
local __engineast = LibStub:GetLibrary("ovale/engine/ast")
local isAstNodeWithChildren = __engineast.isAstNodeWithChildren
local format = string.format
local gmatch = string.gmatch
local find = string.find
local match = string.match
local lower = string.lower
local gsub = string.gsub
local sub = string.sub
local len = string.len
local upper = string.upper
local insert = table.insert
local __texttools = LibStub:GetLibrary("ovale/simulationcraft/text-tools")
local toLowerSpecialization = __texttools.toLowerSpecialization
local toCamelCase = __texttools.toCamelCase
local toOvaleFunctionName = __texttools.toOvaleFunctionName
local __statesPower = LibStub:GetLibrary("ovale/states/Power")
local pooledResources = __statesPower.pooledResources
local __toolstools = LibStub:GetLibrary("ovale/tools/tools")
local isNumber = __toolstools.isNumber
local makeString = __toolstools.makeString
local operandTokenPattern = "[^.]+"
local function isTotem(name)
    if sub(name, 1, 13) == "efflorescence" then
        return true
    elseif name == "rune_of_power" then
        return true
    elseif sub(name, -7, -1) == "_statue" then
        return true
    elseif match(name, "invoke_(chiji|yulon)") then
        return true
    elseif sub(name, -6, -1) == "_totem" then
        return true
    elseif name == "raise_dead" then
        return true
    elseif name == "summon_gargoyle" then
        return true
    end
    return false
end
local function emitTrinketCondition(pattern, slot)
    if slot then
        return format(pattern, slot)
    else
        return "{" .. format(pattern, "trinket0slot") .. " and " .. format(pattern, "trinket1slot") .. "}"
    end
end
__exports.Emiter = __class(nil, {
    constructor = function(self, ovaleDebug, ovaleAst, ovaleData, unparser)
        self.ovaleAst = ovaleAst
        self.ovaleData = ovaleData
        self.unparser = unparser
        self.emitDisambiguations = {}
        self.emitModifier = function(modifier, parseNode, nodeList, annotation, action, modifiers)
            local node, code
            local className = annotation.classId
            local specialization = annotation.specialization
            if modifier == "if" then
                node = self:emit(parseNode, nodeList, annotation, action)
            elseif modifier == "target_if" then
                node = self:emit(parseNode, nodeList, annotation, action)
            elseif modifier == "five_stacks" and action == "focus_fire" then
                local value = tonumber(self.unparser:unparse(parseNode))
                if value == 1 then
                    local buffName = "frenzy_pet_buff"
                    self:addSymbol(annotation, buffName)
                    code = format("pet.BuffStacks(%s) >= 5", buffName)
                end
            elseif modifier == "line_cd" then
                if  not specialActions[action] then
                    self:addSymbol(annotation, action)
                    local node = self:emit(parseNode, nodeList, annotation, action)
                    if  not node then
                        return nil
                    end
                    local expressionCode = self.ovaleAst:unparse(node)
                    code = format("TimeSincePreviousSpell(%s) > %s", action, expressionCode)
                end
            elseif modifier == "max_cycle_targets" then
                local debuffName = self:disambiguate(annotation, action, className, specialization, nil, "debuff")
                self:addSymbol(annotation, debuffName)
                local node = self:emit(parseNode, nodeList, annotation, action)
                if  not node then
                    return nil
                end
                local expressionCode = self.ovaleAst:unparse(node)
                code = format("DebuffCountOnAny(%s) < Enemies() and DebuffCountOnAny(%s) <= %s", debuffName, debuffName, expressionCode)
            elseif modifier == "max_energy" then
                local value = tonumber(self.unparser:unparse(parseNode))
                if value == 1 then
                    code = format("Energy() >= EnergyCost(%s max=1)", action)
                end
            elseif modifier == "min_frenzy" and action == "focus_fire" then
                local value = tonumber(self.unparser:unparse(parseNode))
                if value then
                    local buffName = "frenzy_pet_buff"
                    self:addSymbol(annotation, buffName)
                    code = format("pet.BuffStacks(%s) >= %d", buffName, value)
                end
            elseif modifier == "moving" then
                local value = tonumber(self.unparser:unparse(parseNode))
                if value == 0 then
                    code = "not Speed() > 0"
                else
                    code = "Speed() > 0"
                end
            elseif modifier == "precombat" then
                local value = tonumber(self.unparser:unparse(parseNode))
                if value == 1 then
                    code = "not InCombat()"
                else
                    code = "InCombat()"
                end
            elseif modifier == "sync" then
                local name = self.unparser:unparse(parseNode)
                if  not name then
                    return nil
                end
                if name == "whirlwind_mh" then
                    name = "whirlwind"
                end
                node = annotation.astAnnotation and annotation.astAnnotation.sync and annotation.astAnnotation.sync[name]
                if  not node then
                    local syncParseNode = annotation.sync and annotation.sync[name]
                    if syncParseNode then
                        local syncActionNode = self.emitAction(syncParseNode, nodeList, annotation, action)
                        if syncActionNode then
                            if syncActionNode.type == "action" then
                                node = syncActionNode
                            elseif syncActionNode.type == "custom_function" then
                                node = syncActionNode
                            elseif syncActionNode.type == "if" or syncActionNode.type == "unless" then
                                local lhsNode = syncActionNode.child[1]
                                if syncActionNode.type == "unless" then
                                    local notNode = self.ovaleAst:newNodeWithChildren("logical", annotation.astAnnotation)
                                    notNode.expressionType = "unary"
                                    notNode.operator = "not"
                                    notNode.child[1] = lhsNode
                                    lhsNode = notNode
                                end
                                local rhsNode = syncActionNode.child[2]
                                local andNode = self.ovaleAst:newNodeWithChildren("logical", annotation.astAnnotation)
                                andNode.expressionType = "binary"
                                andNode.operator = "and"
                                andNode.child[1] = lhsNode
                                andNode.child[2] = rhsNode
                                node = andNode
                            else
                                self.tracer:print("Warning: Unable to emit action for 'sync=%s'.", name)
                                name = self:disambiguate(annotation, name, className, specialization)
                                self:addSymbol(annotation, name)
                                code = format("Spell(%s)", name)
                            end
                        end
                    end
                end
                if node then
                    annotation.astAnnotation.sync = annotation.astAnnotation.sync or {}
                    annotation.astAnnotation.sync[name] = node
                end
            end
            if  not node and code then
                annotation.astAnnotation = annotation.astAnnotation or {}
                node = self.ovaleAst:parseCode("expression", code, nodeList, annotation.astAnnotation)
            end
            return node
        end
        self.emitConditionNode = function(nodeList, bodyNode, extraConditionNode, parseNode, annotation, action, modifiers)
            local conditionNode = nil
            for modifier, expressionNode in kpairs(parseNode.modifiers) do
                local rhsNode = self.emitModifier(modifier, expressionNode, nodeList, annotation, action, modifiers)
                if rhsNode then
                    if  not conditionNode then
                        conditionNode = rhsNode
                    else
                        local lhsNode = conditionNode
                        conditionNode = self.ovaleAst:newNodeWithChildren("logical", annotation.astAnnotation)
                        conditionNode.expressionType = "binary"
                        conditionNode.operator = "and"
                        conditionNode.child[1] = lhsNode
                        conditionNode.child[2] = rhsNode
                    end
                end
            end
            if extraConditionNode then
                if conditionNode then
                    local lhsNode = conditionNode
                    local rhsNode = extraConditionNode
                    conditionNode = self.ovaleAst:newNodeWithChildren("logical", annotation.astAnnotation)
                    conditionNode.expressionType = "binary"
                    conditionNode.operator = "and"
                    conditionNode.child[1] = lhsNode
                    conditionNode.child[2] = rhsNode
                else
                    conditionNode = extraConditionNode
                end
            end
            if conditionNode then
                local node = self.ovaleAst:newNodeWithChildren("if", annotation.astAnnotation)
                node.type = "if"
                node.child[1] = conditionNode
                node.child[2] = bodyNode
                if bodyNode.type == "simc_pool_resource" then
                    node.simc_pool_resource = true
                elseif bodyNode.type == "simc_wait" then
                    node.simc_wait = true
                end
                return node
            else
                return bodyNode
            end
        end
        self.emitNamedVariable = function(name, nodeList, annotation, modifiers, parseNode, action, conditionNode)
            local node = annotation.variable[name]
            local group
            if  not node then
                group = self.ovaleAst:newNodeWithChildren("group", annotation.astAnnotation)
                node = self.ovaleAst:newNodeWithBodyAndParameters("add_function", annotation.astAnnotation, group)
                annotation.variable[name] = node
                node.name = name
            else
                group = node.body
            end
            annotation.currentVariable = node
            local value = modifiers.value and self:emit(modifiers.value, nodeList, annotation, action)
            local newNode = self.emitConditionNode(nodeList, value or self.ovaleAst:newValue(annotation.astAnnotation, 0), conditionNode, parseNode, annotation, action, modifiers)
            if newNode.type == "if" then
                insert(group.child, 1, newNode)
            else
                insert(group.child, newNode)
            end
            annotation.currentVariable = nil
        end
        self.emitVariableMin = function(name, nodeList, annotation, modifier, parseNode, action)
            self.emitNamedVariable(name .. "_min", nodeList, annotation, modifier, parseNode, action)
            local valueNode = annotation.variable[name]
            valueNode.name = name .. "_value"
            annotation.variable[valueNode.name] = valueNode
            local bodyCode = format("AddFunction %s { if %s_value() > %s_min() %s_value() %s_min() }", name, name, name, name, name)
            local node = self.ovaleAst:parseCode("add_function", bodyCode, nodeList, annotation.astAnnotation)
            if node then
                annotation.variable[name] = node
            end
        end
        self.emitVariableMax = function(name, nodeList, annotation, modifier, parseNode, action)
            self.emitNamedVariable(name .. "_max", nodeList, annotation, modifier, parseNode, action)
            local valueNode = annotation.variable[name]
            valueNode.name = name .. "_value"
            annotation.variable[valueNode.name] = valueNode
            local bodyCode = format("AddFunction %s { if %s_value() < %s_max() %s_value() %s_max() }", name, name, name, name, name)
            local node = self.ovaleAst:parseCode("add_function", bodyCode, nodeList, annotation.astAnnotation)
            if node then
                annotation.variable[name] = node
            end
        end
        self.emitVariableAdd = function(name, nodeList, annotation, modifiers, parseNode, action)
            local valueNode = annotation.variable[name]
            if valueNode then
                return 
            end
            self.emitNamedVariable(name, nodeList, annotation, modifiers, parseNode, action)
        end
        self.emitVariableSub = function(name, nodeList, annotation, modifiers, parseNode, action)
            local valueNode = annotation.variable[name]
            if valueNode then
                return 
            end
            self.emitNamedVariable(name, nodeList, annotation, modifiers, parseNode, action)
        end
        self.emitVariableIf = function(name, nodeList, annotation, modifiers, parseNode, action)
            local node = annotation.variable[name]
            local group
            if  not node then
                group = self.ovaleAst:newNodeWithChildren("group", annotation.astAnnotation)
                node = self.ovaleAst:newNodeWithBodyAndParameters("add_function", annotation.astAnnotation, group)
                annotation.variable[name] = node
                node.name = name
            else
                group = node.body
            end
            annotation.currentVariable = node
            if  not modifiers.condition or  not modifiers.value or  not modifiers.value_else then
                self.tracer:error("Modifier missing in if")
                return 
            end
            local ifNode = self.ovaleAst:newNodeWithChildren("if", annotation.astAnnotation)
            local condition = self:emit(modifiers.condition, nodeList, annotation, nil)
            local value = self:emit(modifiers.value, nodeList, annotation, nil)
            if  not condition or  not value then
                return 
            end
            ifNode.child[1] = condition
            ifNode.child[2] = value
            insert(group.child, ifNode)
            local elseNode = self.ovaleAst:newNodeWithChildren("unless", annotation.astAnnotation)
            elseNode.child[1] = ifNode.child[1]
            local valueElse = self:emit(modifiers.value_else, nodeList, annotation, nil)
            if  not valueElse then
                return 
            end
            elseNode.child[2] = valueElse
            insert(group.child, elseNode)
            annotation.currentVariable = nil
        end
        self.emitVariable = function(nodeList, annotation, modifier, parseNode, action, conditionNode)
            local op = (modifier.op and self.unparser:unparse(modifier.op)) or "set"
            if  not modifier.name then
                self.tracer:error("Modifier name is missing in %s", action)
                return 
            end
            local name = self.unparser:unparse(modifier.name)
            if  not name then
                self.tracer:error("Unable to parse name of variable in %s", modifier.name)
                return 
            end
            if match(name, "^%d") then
                name = "_" .. name
            end
            if op == "min" then
                self.emitVariableMin(name, nodeList, annotation, modifier, parseNode, action)
            elseif op == "max" then
                self.emitVariableMax(name, nodeList, annotation, modifier, parseNode, action)
            elseif op == "add" then
                self.emitVariableAdd(name, nodeList, annotation, modifier, parseNode, action)
            elseif op == "set" or op == "reset" then
                self.emitNamedVariable(name, nodeList, annotation, modifier, parseNode, action, conditionNode)
            elseif op == "setif" then
                self.emitVariableIf(name, nodeList, annotation, modifier, parseNode, action)
            elseif op == "sub" then
                self.emitVariableSub(name, nodeList, annotation, modifier, parseNode, action)
            else
                self.tracer:error("Unknown variable operator '%s'.", op)
            end
        end
        self.emitAction = function(parseNode, nodeList, annotation)
            local node
            local canonicalizedName = lower(gsub(parseNode.name, ":", "_"))
            local className = annotation.classId
            local specialization = annotation.specialization
            local camelSpecialization = toLowerSpecialization(annotation)
            local action, type = self:disambiguate(annotation, canonicalizedName, className, specialization, "spell")
            local bodyNode
            local conditionNode
            if  not ((action == "auto_attack" and  not annotation.melee) or action == "auto_shot" or action == "choose_target" or action == "augmentation" or action == "flask" or action == "food" or action == "snapshot_stats") then
                local bodyCode, conditionCode
                local expressionType = "expression"
                local modifiers = parseNode.modifiers
                local isSpellAction = true
                if interruptsClasses[action] == className then
                    bodyCode = camelSpecialization .. "InterruptActions()"
                    annotation[action] = className
                    annotation.interrupt = className
                    isSpellAction = false
                elseif className == "DEMONHUNTER" and action == "pick_up_fragment" then
                    bodyCode = "texture(spell_shadow_soulgem text=pickup)"
                    conditionCode = "soulfragments() > 0"
                    isSpellAction = false
                elseif className == "DRUID" and action == "primal_wrath" then
                    conditionCode = "Enemies(tagged=1) > 1"
                elseif className == "DRUID" and action == "wild_charge" then
                    bodyCode = camelSpecialization .. "GetInMeleeRange()"
                    annotation[action] = className
                    isSpellAction = false
                elseif className == "DRUID" and action == "new_moon" then
                    conditionCode = "not SpellKnown(half_moon) and not SpellKnown(full_moon)"
                    self:addSymbol(annotation, "half_moon")
                    self:addSymbol(annotation, "full_moon")
                elseif className == "DRUID" and action == "half_moon" then
                    conditionCode = "SpellKnown(half_moon)"
                elseif className == "DRUID" and action == "full_moon" then
                    conditionCode = "SpellKnown(full_moon)"
                elseif className == "MAGE" and find(action, "pet_") then
                    conditionCode = "pet.Present()"
                elseif className == "MAGE" and (action == "start_burn_phase" or action == "start_pyro_chain" or action == "stop_burn_phase" or action == "stop_pyro_chain") then
                    local stateAction, stateVariable = match(action, "([^_]+)_(.*)")
                    local value = (stateAction == "start" and 1) or 0
                    if value == 0 then
                        conditionCode = format("GetState(%s) > 0", stateVariable)
                    else
                        conditionCode = format("not GetState(%s) > 0", stateVariable)
                    end
                    bodyCode = format("SetState(%s %d)", stateVariable, value)
                    isSpellAction = false
                elseif className == "MAGE" and action == "time_warp" then
                    conditionCode = "CheckBoxOn(opt_time_warp) and DebuffExpires(burst_haste_debuff any=1)"
                    annotation[action] = className
                elseif className == "MAGE" and action == "ice_floes" then
                    conditionCode = "Speed() > 0"
                elseif className == "MAGE" and action == "blast_wave" then
                    conditionCode = "target.Distance() < 8"
                elseif className == "MAGE" and action == "dragons_breath" then
                    conditionCode = "target.Distance() < 12"
                elseif className == "MAGE" and action == "arcane_blast" then
                    conditionCode = "Mana() > ManaCost(arcane_blast)"
                elseif className == "MAGE" and action == "cone_of_cold" then
                    conditionCode = "target.Distance() < 12"
                elseif className == "MONK" and action == "chi_sphere" then
                    isSpellAction = false
                elseif className == "MONK" and action == "gift_of_the_ox" then
                    isSpellAction = false
                elseif className == "MONK" and action == "storm_earth_and_fire" then
                    conditionCode = "CheckBoxOn(opt_storm_earth_and_fire) and not BuffPresent(storm_earth_and_fire)"
                    annotation[action] = className
                elseif className == "MONK" and action == "storm_earth_and_fire_fixate" then
                    isSpellAction = false
                elseif className == "MONK" and action == "touch_of_death" then
                elseif className == "PALADIN" and action == "blessing_of_kings" then
                    conditionCode = "BuffExpires(mastery_buff)"
                elseif className == "PALADIN" and action == "judgment" then
                    if modifiers.cycle_targets then
                        self:addSymbol(annotation, action)
                        bodyCode = "Spell(" .. action .. " text=double)"
                        isSpellAction = false
                    end
                elseif className == "PALADIN" and specialization == "protection" and action == "arcane_torrent_holy" then
                    isSpellAction = false
                elseif className == "ROGUE" and action == "adrenaline_rush" then
                    conditionCode = "EnergyDeficit() > 1"
                elseif className == "ROGUE" and action == "apply_poison" then
                    local lethal = nil
                    if modifiers.lethal then
                        lethal = self.unparser:unparse(modifiers.lethal)
                    elseif specialization == "assassination" then
                        lethal = "deadly"
                    else
                        lethal = "instant"
                    end
                    action = lethal .. "_poison"
                    local buffName = "lethal_poison_buff"
                    self:addSymbol(annotation, buffName)
                    conditionCode = format("BuffRemaining(%s) < 1200", buffName)
                elseif className == "ROGUE" and action == "cancel_autoattack" then
                    isSpellAction = false
                elseif className == "ROGUE" and specialization == "assassination" and action == "vanish" then
                    annotation.vanish = className
                    conditionCode = format("CheckBoxOn(opt_vanish)", action)
                elseif className == "SHAMAN" and sub(action, 1, 11) == "ascendance_" then
                    local buffName = self:disambiguate(annotation, action, className, specialization, nil, "buff")
                    self:addSymbol(annotation, buffName)
                    conditionCode = format("BuffExpires(%s)", buffName)
                elseif className == "SHAMAN" and action == "bloodlust" then
                    bodyCode = camelSpecialization .. "Bloodlust()"
                    annotation[action] = className
                    isSpellAction = false
                elseif className == "WARLOCK" and action == "felguard_felstorm" then
                    conditionCode = "pet.Present() and pet.CreatureFamily(Felguard)"
                elseif className == "WARLOCK" and action == "grimoire_of_sacrifice" then
                    conditionCode = "pet.Present()"
                elseif className == "WARLOCK" and action == "havoc" then
                    conditionCode = "Enemies() > 1"
                elseif className == "WARLOCK" and action == "service_pet" then
                    if annotation.pet then
                        local spellName = "service_" .. annotation.pet
                        self:addSymbol(annotation, spellName)
                        bodyCode = format("Spell(%s)", spellName)
                    else
                        bodyCode = "Texture(spell_nature_removecurse help=ServicePet)"
                    end
                    isSpellAction = false
                elseif className == "WARLOCK" and action == "summon_pet" then
                    if annotation.pet then
                        local spellName = "summon_" .. annotation.pet
                        self:addSymbol(annotation, spellName)
                        bodyCode = format("Spell(%s)", spellName)
                    else
                        bodyCode = "Texture(spell_nature_removecurse help=L(summon_pet))"
                    end
                    conditionCode = "not pet.Present()"
                    isSpellAction = false
                elseif className == "WARLOCK" and action == "wrathguard_wrathstorm" then
                    conditionCode = "pet.Present() and pet.CreatureFamily(Wrathguard)"
                elseif className == "WARRIOR" and action == "charge" then
                    conditionCode = "CheckBoxOn(opt_melee_range) and target.InRange(charge) and not target.InRange(pummel)"
                    self:addSymbol(annotation, "pummel")
                elseif className == "WARRIOR" and sub(action, 1, 7) == "execute" then
                    if modifiers.target then
                        local target = tonumber(self.unparser:unparse(modifiers.target))
                        if target then
                            isSpellAction = false
                        end
                    end
                elseif className == "WARRIOR" and action == "heroic_leap" then
                    conditionCode = "CheckBoxOn(opt_melee_range) and target.Distance() >= 8 and target.Distance() <= 40"
                elseif action == "auto_attack" then
                    bodyCode = camelSpecialization .. "GetInMeleeRange()"
                    isSpellAction = false
                elseif className == "DEMONHUNTER" and action == "metamorphosis_havoc" then
                    conditionCode = "not CheckBoxOn(opt_meta_only_during_boss) or IsBossFight()"
                    if  not annotation.options then
                        annotation.options = {}
                    end
                    annotation.options["opt_meta_only_during_boss"] = true
                elseif className == "DEMONHUNTER" and action == "consume_magic" then
                    conditionCode = "target.HasDebuffType(magic)"
                elseif checkOptionalSkill(action, className, specialization) then
                    annotation[action] = className
                    conditionCode = "CheckBoxOn(opt_" .. action .. ")"
                elseif action == "cycling_variable" then
                    self:emitCyclingVariable(nodeList, annotation, modifiers, parseNode, action)
                    isSpellAction = false
                elseif action == "variable" then
                    self.emitVariable(nodeList, annotation, modifiers, parseNode, action)
                    isSpellAction = false
                elseif action == "call_action_list" or action == "run_action_list" or action == "swap_action_list" then
                    if modifiers.name then
                        local name = self.unparser:unparse(modifiers.name)
                        if name then
                            local functionName = toOvaleFunctionName(name, annotation)
                            bodyCode = functionName .. "()"
                            if className == "MAGE" and specialization == "arcane" and (name == "burn" or name == "init_burn") then
                                conditionCode = "CheckBoxOn(opt_arcane_mage_burn_phase)"
                                if  not annotation.options then
                                    annotation.options = {}
                                end
                                annotation.options["opt_arcane_mage_burn_phase"] = true
                            end
                        end
                        isSpellAction = false
                    end
                elseif action == "cancel_buff" then
                    if modifiers.name then
                        local spellName = self.unparser:unparse(modifiers.name)
                        if spellName then
                            local buffName = self:disambiguate(annotation, spellName, className, specialization, "spell", "buff")
                            self:addSymbol(annotation, buffName)
                            bodyCode = format("Texture(%s text=cancel)", buffName)
                            conditionCode = format("BuffPresent(%s)", buffName)
                            isSpellAction = false
                        end
                    end
                elseif action == "cancel_action" then
                    bodyCode = "texture(INV_Pet_ExitBattle text=cancel)"
                    isSpellAction = false
                elseif action == "pool_resource" then
                    bodyNode = self.ovaleAst:newNode("simc_pool_resource", annotation.astAnnotation)
                    bodyNode.for_next = modifiers.for_next ~= nil
                    if modifiers.extra_amount then
                        bodyNode.extra_amount = tonumber(self.unparser:unparse(modifiers.extra_amount))
                    end
                    isSpellAction = false
                elseif action == "potion" then
                    local name = (modifiers.name and self.unparser:unparse(modifiers.name)) or annotation.consumables["potion"]
                    if name then
                        if name == "disabled" then
                            return nil
                        end
                        name = self:disambiguate(annotation, name, className, specialization, "item", "item")
                        bodyCode = format("Item(%s usable=1)", name)
                        conditionCode = "CheckBoxOn(opt_use_consumables) and target.Classification(worldboss)"
                        annotation.opt_use_consumables = className
                        self:addSymbol(annotation, name)
                        isSpellAction = false
                    end
                elseif action == "sequence" or action == "strict_sequence" then
                    isSpellAction = false
                elseif action == "summon_pet" then
                    bodyCode = camelSpecialization .. "SummonPet()"
                    annotation[action] = className
                    isSpellAction = false
                elseif action == "use_items" then
                    bodyCode = camelSpecialization .. "UseItemActions()"
                    annotation["use_item"] = true
                    isSpellAction = false
                elseif action == "use_item" then
                    local legendaryRing = nil
                    if modifiers.slot then
                        local slot = self.unparser:unparse(modifiers.slot)
                        if slot and match(slot, "finger") then
                            legendaryRing = self:disambiguate(annotation, "legendary_ring", className, specialization)
                        end
                    elseif modifiers.name then
                        local name = self.unparser:unparse(modifiers.name)
                        if name then
                            name = self:disambiguate(annotation, name, className, specialization)
                            if match(name, "legendary_ring") then
                                legendaryRing = name
                            end
                        end
                    elseif modifiers.effect_name then
                    end
                    if legendaryRing then
                        conditionCode = format("CheckBoxOn(opt_%s)", legendaryRing)
                        bodyCode = format("Item(%s usable=1)", legendaryRing)
                        self:addSymbol(annotation, legendaryRing)
                        annotation.use_legendary_ring = legendaryRing
                    else
                        bodyCode = camelSpecialization .. "UseItemActions()"
                        annotation[action] = true
                    end
                    isSpellAction = false
                elseif action == "wait" then
                    if modifiers.sec then
                        local seconds = tonumber(self.unparser:unparse(modifiers.sec))
                        if  not seconds then
                            bodyNode = self.ovaleAst:newNodeWithChildren("simc_wait", annotation.astAnnotation)
                            local expressionNode = self:emit(modifiers.sec, nodeList, annotation, action)
                            if expressionNode then
                                local code = self.ovaleAst:unparse(expressionNode)
                                conditionCode = code .. " > 0"
                            end
                        end
                    end
                    isSpellAction = false
                elseif action == "wait_for_cooldown" then
                    if modifiers.name then
                        local spellName = self.unparser:unparse(modifiers.name)
                        if spellName then
                            isSpellAction = true
                            action = spellName
                        end
                    end
                elseif action == "heart_essence" then
                    bodyCode = [[Spell(296208)]]
                    conditionCode = [[hasequippeditem(158075) and level() < 50]]
                    isSpellAction = false
                elseif parseNode.actionListName == "precombat" then
                    local definition = annotation.dictionary[action]
                    if isNumber(definition) then
                        local spellInfo = self.ovaleData:getSpellOrListInfo(definition)
                        if spellInfo and spellInfo.aura then
                            for _, info in kpairs(spellInfo.aura.player.HELPFUL) do
                                if info.buffSpellId then
                                    local buffSpellInfo = self.ovaleData:getSpellOrListInfo(info.buffSpellId)
                                    if buffSpellInfo and ( not buffSpellInfo.duration or buffSpellInfo.duration > 59) then
                                        conditionCode = "buffexpires(" .. (info.buffName or info.buffSpellId) .. ")"
                                    end
                                end
                            end
                        end
                    end
                end
                if isSpellAction then
                    self:addSymbol(annotation, action)
                    if modifiers.target then
                        local actionTarget = self.unparser:unparse(modifiers.target)
                        if actionTarget == "2" then
                            actionTarget = "other"
                        end
                        if actionTarget ~= "1" then
                            bodyCode = format("%s(%s text=%s)", type, action, actionTarget)
                        end
                    end
                    bodyCode = bodyCode or type .. "(" .. action .. ")"
                end
                if  not bodyNode and bodyCode then
                    bodyNode = self.ovaleAst:parseCode(expressionType, bodyCode, nodeList, annotation.astAnnotation)
                end
                if  not conditionNode and conditionCode then
                    conditionNode = self.ovaleAst:parseCode(expressionType, conditionCode, nodeList, annotation.astAnnotation)
                end
                if bodyNode then
                    node = self.emitConditionNode(nodeList, bodyNode, conditionNode, parseNode, annotation, action, modifiers)
                end
            end
            return node
        end
        self.emitActionList = function(parseNode, nodeList, annotation)
            local groupNode = self.ovaleAst:newNodeWithChildren("group", annotation.astAnnotation)
            local child = groupNode.child
            local poolResourceNode
            local emit = true
            for _, actionNode in ipairs(parseNode.child) do
                local commentNode = self.ovaleAst:newNode("comment", annotation.astAnnotation)
                commentNode.comment = actionNode.action
                child[#child + 1] = commentNode
                if emit then
                    local statementNode = self.emitAction(actionNode, nodeList, annotation, actionNode.name)
                    if statementNode then
                        if statementNode.type == "simc_pool_resource" then
                            local powerType = pooledResources[annotation.classId]
                            if powerType then
                                if statementNode.for_next then
                                    poolResourceNode = statementNode
                                    poolResourceNode.powerType = powerType
                                else
                                    emit = false
                                end
                            end
                        elseif poolResourceNode then
                            child[#child + 1] = statementNode
                            local bodyNode
                            local poolingConditionNode
                            if isAstNodeWithChildren(statementNode) then
                                poolingConditionNode = statementNode.child[1]
                                bodyNode = statementNode.child[2]
                            else
                                bodyNode = statementNode
                            end
                            local powerType = toCamelCase(poolResourceNode.powerType)
                            local extraAmount = poolResourceNode.extra_amount
                            if extraAmount and poolingConditionNode then
                                local code = self.ovaleAst:unparse(poolingConditionNode)
                                local extraAmountPattern = powerType .. "%(%) >= [%d.]+"
                                local replaceString = format("always(pool_%s %d)", poolResourceNode.powerType, extraAmount)
                                code = gsub(code, extraAmountPattern, replaceString)
                                poolingConditionNode = self.ovaleAst:parseCode("expression", code, nodeList, annotation.astAnnotation)
                            end
                            if bodyNode.type == "action" and bodyNode.rawPositionalParams and bodyNode.rawPositionalParams[1] then
                                local name = self.ovaleAst:unparse(bodyNode.rawPositionalParams[1])
                                local powerCondition
                                if extraAmount then
                                    powerCondition = format("TimeTo%s(%d)", powerType, extraAmount)
                                else
                                    powerCondition = format("TimeTo%sFor(%s)", powerType, name)
                                end
                                local code = format("SpellUsable(%s) and SpellCooldown(%s) < %s", name, name, powerCondition)
                                local conditionNode = self.ovaleAst:parseCode("expression", code, nodeList, annotation.astAnnotation)
                                if conditionNode then
                                    if isAstNodeWithChildren(statementNode) and poolingConditionNode then
                                        local rhsNode = conditionNode
                                        conditionNode = self.ovaleAst:newNodeWithChildren("logical", annotation.astAnnotation)
                                        conditionNode.expressionType = "binary"
                                        conditionNode.operator = "and"
                                        conditionNode.child[1] = poolingConditionNode
                                        conditionNode.child[2] = rhsNode
                                    end
                                    local restNodeType
                                    if statementNode.type == "unless" then
                                        restNodeType = "if"
                                    else
                                        restNodeType = "unless"
                                    end
                                    local restNode = self.ovaleAst:newNodeWithChildren(restNodeType, annotation.astAnnotation)
                                    child[#child + 1] = restNode
                                    restNode.child[1] = conditionNode
                                    restNode.child[2] = self.ovaleAst:newNodeWithChildren("group", annotation.astAnnotation)
                                    child = restNode.child[2].child
                                end
                            end
                            poolResourceNode = nil
                        elseif (statementNode.type == "if" or statementNode.type == "unless") and statementNode.simc_wait then
                            local restNode = self.ovaleAst:newNodeWithChildren("unless", annotation.astAnnotation)
                            child[#child + 1] = restNode
                            restNode.type = "unless"
                            restNode.child[1] = statementNode.child[1]
                            restNode.child[2] = self.ovaleAst:newNodeWithChildren("group", annotation.astAnnotation)
                            child = restNode.child[2].child
                        elseif statementNode.type ~= "simc_wait" then
                            child[#child + 1] = statementNode
                            if (statementNode.type == "if" or statementNode.type == "unless") and statementNode.simc_pool_resource then
                                if statementNode.type == "if" then
                                    statementNode.type = "unless"
                                elseif statementNode.type == "unless" then
                                    statementNode.type = "if"
                                end
                                statementNode.child[2] = self.ovaleAst:newNodeWithChildren("group", annotation.astAnnotation)
                                child = statementNode.child[2].child
                            end
                        end
                    end
                end
            end
            local node = self.ovaleAst:newNodeWithBodyAndParameters("add_function", annotation.astAnnotation, groupNode)
            node.name = toOvaleFunctionName(parseNode.name, annotation)
            return node
        end
        self.emitExpression = function(parseNode, nodeList, annotation, action)
            local node
            local msg
            if parseNode.expressionType == "unary" then
                local opInfo = unaryOperators[parseNode.operator]
                if opInfo then
                    local operator
                    if parseNode.operator == "!" then
                        operator = "not"
                    elseif parseNode.operator == "-" then
                        operator = parseNode.operator
                    end
                    if operator then
                        local rhsNode = self:emit(parseNode.child[1], nodeList, annotation, action)
                        if rhsNode then
                            if operator == "-" and rhsNode.type == "value" then
                                rhsNode.value = -1 * rhsNode.value
                            else
                                node = self.ovaleAst:newNodeWithChildren(opInfo[1], annotation.astAnnotation)
                                node.expressionType = "unary"
                                node.operator = operator
                                node.precedence = opInfo[2]
                                node.child[1] = rhsNode
                            end
                        end
                    end
                end
            elseif parseNode.expressionType == "binary" then
                local opInfo = binaryOperators[parseNode.operator]
                if opInfo then
                    local parseNodeOperator = parseNode.operator
                    local operator
                    if parseNodeOperator == "&" then
                        operator = "and"
                    elseif parseNodeOperator == "^" then
                        operator = "xor"
                    elseif parseNodeOperator == "|" then
                        operator = "or"
                    elseif parseNodeOperator == "=" then
                        operator = "=="
                    elseif parseNodeOperator == "%" then
                        operator = "/"
                    elseif parseNodeOperator == "%%" then
                        operator = "%"
                    elseif parseNode.operatorType == "compare" or parseNode.operatorType == "arithmetic" then
                        if parseNodeOperator ~= "~" and parseNodeOperator ~= "!~" then
                            operator = parseNodeOperator
                        end
                    end
                    if (parseNode.operator == "=" or parseNode.operator == "!=") and (parseNode.child[1].name == "target" or parseNode.child[1].name == "current_target") and parseNode.child[2].name then
                        local name = parseNode.child[2].name
                        if find(name, "^[%a_]+%.") then
                            name = match(name, "^[%a_]+%.([%a_]+)")
                        end
                        local code
                        if name == "sim_target" then
                            code = "always(target_is_sim_target)"
                        elseif name == "target" then
                            code = "never(target_is_target)"
                        else
                            code = format("target.Name(%s)", name)
                            self:addSymbol(annotation, name)
                        end
                        if parseNode.operator == "!=" then
                            code = "not " .. code
                        end
                        annotation.astAnnotation = annotation.astAnnotation or {}
                        node = self.ovaleAst:parseCode("expression", code, nodeList, annotation.astAnnotation)
                    elseif (parseNode.operator == "=" or parseNode.operator == "!=") and parseNode.child[1].name == "sim_target" then
                        local code
                        if parseNode.operator == "=" then
                            code = "always(target_is_sim_target)"
                        else
                            code = "never(target_is_sim_target)"
                        end
                        annotation.astAnnotation = annotation.astAnnotation or {}
                        node = self.ovaleAst:parseCode("expression", code, nodeList, annotation.astAnnotation)
                    elseif operator then
                        local lhsNode = self:emit(parseNode.child[1], nodeList, annotation, action)
                        local rhsNode = self:emit(parseNode.child[2], nodeList, annotation, action)
                        if lhsNode and rhsNode then
                            node = self.ovaleAst:newNodeWithChildren(opInfo[1], annotation.astAnnotation)
                            node.expressionType = "binary"
                            node.operator = operator
                            node.child[1] = lhsNode
                            node.child[2] = rhsNode
                        elseif lhsNode then
                            msg = makeString("Warning: %s operator '%s' right failed.", parseNode.type, parseNode.operator)
                        elseif rhsNode then
                            msg = makeString("Warning: %s operator '%s' left failed.", parseNode.type, parseNode.operator)
                        else
                            msg = makeString("Warning: %s operator '%s' left and right failed.", parseNode.type, parseNode.operator)
                        end
                    end
                end
            end
            if node then
                if parseNode.left and parseNode.right then
                    node.left = "{"
                    node.right = "}"
                end
            else
                msg = msg or makeString("Warning: Operator '%s' is not implemented.", parseNode.operator)
                self.tracer:print(msg)
                local stringNode = self.ovaleAst:newNode("string", annotation.astAnnotation)
                stringNode.value = "FIXME_" .. parseNode.operator
                return stringNode
            end
            return node
        end
        self.emitFunction = function(parseNode, nodeList, annotation, action)
            local node
            if parseNode.name == "ceil" or parseNode.name == "floor" then
                node = self:emit(parseNode.child[1], nodeList, annotation, action)
            else
                self.tracer:print("Warning: Function '%s' is not implemented.", parseNode.name)
                node = self.ovaleAst:newNode("variable", annotation.astAnnotation)
                node.name = "FIXME_" .. parseNode.name
            end
            return node
        end
        self.emitNumber = function(parseNode, nodeList, annotation, action)
            local node = self.ovaleAst:newNode("value", annotation.astAnnotation)
            node.value = parseNode.value
            node.origin = 0
            node.rate = 0
            return node
        end
        self.emitOperand = function(parseNode, nodeList, annotation, action)
            local node
            local operand = parseNode.name
            local token = match(operand, operandTokenPattern)
            local target
            if token == "target" or token == "self" then
                node = self.emitOperandTarget(operand, parseNode, nodeList, annotation, action)
                if  not node then
                    target = token
                    operand = sub(operand, len(target) + 2)
                    token = match(operand, operandTokenPattern)
                end
            end
            if  not node then
                node = self.emitOperandRune(operand, parseNode, nodeList, annotation, action)
            end
            if  not node then
                node = self.emitOperandSpecial(operand, parseNode, nodeList, annotation, action, target)
            end
            if  not node then
                node = self.emitOperandRaidEvent(operand, parseNode, nodeList, annotation, action)
            end
            if  not node then
                node = self.emitOperandRace(operand, parseNode, nodeList, annotation, action)
            end
            if  not node then
                node = self.emitOperandAction(operand, parseNode, nodeList, annotation, action, target)
            end
            if  not node then
                node = self.emitOperandCharacter(operand, parseNode, nodeList, annotation, action, target)
            end
            if  not node then
                if token == "active_dot" then
                    target = target or "target"
                    node = self.emitOperandActiveDot(operand, parseNode, nodeList, annotation, action, target)
                elseif token == "aura" then
                    node = self.emitOperandBuff(operand, parseNode, nodeList, annotation, action, target)
                elseif token == "azerite" then
                    node = self.emitOperandAzerite(operand, parseNode, nodeList, annotation, action, target)
                elseif token == "buff" then
                    node = self.emitOperandBuff(operand, parseNode, nodeList, annotation, action, target)
                elseif token == "consumable" then
                    node = self.emitOperandBuff(operand, parseNode, nodeList, annotation, action, target)
                elseif token == "cooldown" then
                    node = self.emitOperandCooldown(operand, parseNode, nodeList, annotation, action)
                elseif token == "dbc" then
                    node = self.emitOperandDbc(operand, parseNode, nodeList, annotation, action, target)
                elseif token == "debuff" then
                    target = target or "target"
                    node = self.emitOperandBuff(operand, parseNode, nodeList, annotation, action, target)
                elseif token == "disease" then
                    target = target or "target"
                    node = self.emitOperandDisease(operand, parseNode, nodeList, annotation, action, target)
                elseif token == "dot" then
                    target = target or "target"
                    node = self.emitOperandDot(operand, parseNode, nodeList, annotation, action, target)
                elseif token == "essence" then
                    node = self.emitOperandEssence(operand, parseNode, nodeList, annotation, action, target)
                elseif token == "glyph" then
                    node = self.emitOperandGlyph(operand, parseNode, nodeList, annotation, action)
                elseif token == "pet" then
                    node = self.emitOperandPet(operand, parseNode, nodeList, annotation, action)
                elseif token == "prev" or token == "prev_gcd" or token == "prev_off_gcd" then
                    node = self.emitOperandPreviousSpell(operand, parseNode, nodeList, annotation, action)
                elseif token == "refreshable" then
                    node = self.emitOperandRefresh(operand, parseNode, nodeList, annotation, action)
                elseif token == "seal" then
                    node = self.emitOperandSeal(operand, parseNode, nodeList, annotation, action)
                elseif token == "set_bonus" then
                    node = self.emitOperandSetBonus(operand, parseNode, nodeList, annotation, action)
                elseif token == "stack" then
                    node = self.ovaleAst:parseCode("expression", "buffstacks(" .. action .. ")", nodeList, annotation.astAnnotation)
                elseif token == "talent" then
                    node = self.emitOperandTalent(operand, parseNode, nodeList, annotation, action)
                elseif token == "totem" then
                    node = self.emitOperandTotem(operand, parseNode, nodeList, annotation, action)
                elseif token == "trinket" then
                    node = self.emitOperandTrinket(operand, parseNode, nodeList, annotation, action)
                elseif token == "variable" then
                    node = self.emitOperandVariable(operand, parseNode, nodeList, annotation, action)
                elseif token == "ground_aoe" then
                    node = self.emitOperandGroundAoe(operand, parseNode, nodeList, annotation, action)
                else
                    node = self:emitMiscOperand(operand, parseNode, nodeList, annotation, action)
                end
            end
            if  not node then
                self.tracer:print("Warning: Variable '%s' is not implemented.", parseNode.name)
                node = self.ovaleAst:newFunction("message", annotation.astAnnotation)
                node.rawPositionalParams[1] = self.ovaleAst:newString(annotation.astAnnotation, parseNode.name .. " is not implemented")
            end
            return node
        end
        self.emitOperandAction = function(operand, parseNode, nodeList, annotation, action, target)
            local node
            local name
            local property
            if sub(operand, 1, 7) == "action." then
                local tokenIterator = gmatch(operand, operandTokenPattern)
                tokenIterator()
                name = tokenIterator()
                property = tokenIterator()
            else
                name = action
                property = operand
            end
            if  not name then
                return nil
            end
            local className, specialization = annotation.classId, annotation.specialization
            name = self:disambiguate(annotation, name, className, specialization)
            target = (target and target .. ".") or ""
            local buffName
            buffName = self:disambiguate(annotation, name, className, specialization, nil, "debuff")
            local buffSpellId = annotation.dictionary[buffName]
            local prefix
            local buffTarget
            if buffSpellId and isNumber(buffSpellId) then
                local buffSpellInfo = self.ovaleData:getSpellOrListInfo(buffSpellId)
                if buffSpellInfo then
                    if buffSpellInfo.effect == "HARMFUL" then
                        prefix = "Debuff"
                    elseif buffSpellInfo.effect == "HELPFUL" then
                        prefix = "Buff"
                    end
                end
            end
            if  not prefix then
                prefix = (find(buffName, "_debuff$") and "Debuff") or "Buff"
            end
            buffTarget = (prefix == "Debuff" and "target.") or target
            local talentName = name .. "_talent"
            talentName = self:disambiguate(annotation, talentName, className, specialization)
            local symbol = name
            local code
            if property == "active" then
                if isTotem(name) then
                    code = format("TotemPresent(%s)", name)
                else
                    code = format("%s%sPresent(%s)", target, prefix, buffName)
                    symbol = buffName
                end
            elseif property == "ap_check" then
                code = format("AstralPower() >= AstralPowerCost(%s)", name)
            elseif property == "cast_regen" then
                code = format("FocusCastingRegen(%s)", name)
            elseif property == "cast_time" then
                if name == "use_item" then
                    code = "0"
                else
                    code = format("CastTime(%s)", name)
                end
            elseif property == "charges" then
                code = format("Charges(%s)", name)
            elseif property == "max_charges" then
                code = format("SpellMaxCharges(%s)", name)
            elseif property == "charges_fractional" then
                code = format("Charges(%s count=0)", name)
            elseif property == "channeling" then
                code = format("channeling(%s)", name)
            elseif property == "cooldown" then
                if name == "use_item" then
                    code = format("ItemCooldown(slot=\"trinket0slot\")")
                else
                    code = format("SpellCooldown(%s)", name)
                end
            elseif property == "cooldown_react" then
                code = format("not SpellCooldown(%s) > 0", name)
            elseif property == "cost" then
                code = format("PowerCost(%s)", name)
            elseif property == "crit_damage" then
                code = format("%sCritDamage(%s)", target, name)
            elseif property == "damage" then
                code = format("%sDamage(%s)", target, name)
            elseif property == "duration" or property == "new_duration" then
                code = format("BaseDuration(%s)", buffName)
                symbol = buffName
            elseif property == "last_used" then
                code = format("TimeSincePreviousSpell(%s)", name)
            elseif property == "enabled" then
                if parseNode.asType == "boolean" then
                    code = format("Talent(%s)", talentName)
                else
                    code = format("TalentPoints(%s)", talentName)
                end
                symbol = talentName
            elseif property == "execute_time" or property == "execute_remains" then
                code = format("ExecuteTime(%s)", name)
            elseif property == "executing" then
                code = format("ExecuteTime(%s) > 0", name)
            elseif property == "full_reduction" or property == "tick_reduction" then
                code = "0"
            elseif property == "gcd" then
                code = "GCD()"
            elseif property == "hit_damage" then
                code = format("%sDamage(%s)", target, name)
            elseif property == "in_flight" or property == "in_flight_to_target" then
                code = format("InFlightToTarget(%s)", name)
            elseif property == "in_flight_remains" then
                code = "0"
            elseif property == "miss_react" then
                code = "always(miss_react)"
            elseif property == "persistent_multiplier" or property == "pmultiplier" then
                code = format("PersistentMultiplier(%s)", buffName)
            elseif property == "recharge_time" then
                code = format("SpellChargeCooldown(%s)", name)
            elseif property == "full_recharge_time" then
                code = format("SpellFullRecharge(%s)", name)
            elseif property == "remains" then
                if isTotem(name) then
                    code = format("TotemRemaining(%s)", name)
                else
                    code = format("%s%sRemaining(%s)", buffTarget, prefix, buffName)
                    symbol = buffName
                end
            elseif property == "shard_react" then
                code = "SoulShards() >= 1"
            elseif property == "tick_dmg" or property == "tick_damage" then
                code = format("%sLastDamage(%s)", buffTarget, buffName)
            elseif property == "tick_time" then
                code = format("%sCurrentTickTime(%s)", buffTarget, buffName)
                symbol = buffName
            elseif property == "ticking" then
                code = format("%s%sPresent(%s)", buffTarget, prefix, buffName)
                symbol = buffName
            elseif property == "ticks_remain" then
                code = format("%sTicksRemaining(%s)", buffTarget, buffName)
                symbol = buffName
            elseif property == "travel_time" then
                code = format("TravelTime(%s)", name)
            elseif property == "usable" then
                code = format("CanCast(%s)", name)
            elseif property == "usable_in" then
                code = format("SpellCooldown(%s)", name)
            elseif property == "marks_next_gcd" then
                code = "0"
            end
            if code then
                if name == "call_action_list" and property ~= "gcd" then
                    self.tracer:print("Warning: dubious use of call_action_list in %s", code)
                end
                annotation.astAnnotation = annotation.astAnnotation or {}
                node = self.ovaleAst:parseCode("expression", code, nodeList, annotation.astAnnotation)
                if  not specialActions[symbol] then
                    self:addSymbol(annotation, symbol)
                end
            end
            return node
        end
        self.emitOperandActiveDot = function(operand, parseNode, nodeList, annotation, action, target)
            local node
            local tokenIterator = gmatch(operand, operandTokenPattern)
            local token = tokenIterator()
            if token == "active_dot" then
                local name = tokenIterator()
                name = self:disambiguate(annotation, name, annotation.classId, annotation.specialization)
                local dotName
                dotName = self:disambiguate(annotation, name, annotation.classId, annotation.specialization, nil, "debuff")
                local prefix = (find(dotName, "_buff$") and "Buff") or "Debuff"
                target = (target and target .. ".") or ""
                local code = format("%sCountOnAny(%s)", prefix, dotName)
                if code then
                    node = self.ovaleAst:parseCode("expression", code, nodeList, annotation.astAnnotation)
                    self:addSymbol(annotation, dotName)
                end
            end
            return node
        end
        self.emitOperandAzerite = function(operand, parseNode, nodeList, annotation, action, target)
            local node
            local tokenIterator = gmatch(operand, operandTokenPattern)
            local token = tokenIterator()
            if token == "azerite" then
                local code
                local name = tokenIterator()
                local property = tokenIterator()
                if property == "rank" then
                    code = format("AzeriteTraitRank(%s_trait)", name)
                elseif property == "enabled" then
                    code = format("HasAzeriteTrait(%s_trait)", name)
                end
                if code then
                    annotation.astAnnotation = annotation.astAnnotation or {}
                    node = self.ovaleAst:parseCode("expression", code, nodeList, annotation.astAnnotation)
                    self:addSymbol(annotation, name .. "_trait")
                end
            end
            return node
        end
        self.emitOperandEssence = function(operand, parseNode, nodeList, annotation, action, target)
            local node
            local tokenIterator = gmatch(operand, operandTokenPattern)
            local token = tokenIterator()
            if token == "essence" then
                local code
                local name = tokenIterator()
                local property = tokenIterator()
                local essenceId = format("%s_essence_id", name)
                essenceId = self:disambiguate(annotation, essenceId, annotation.classId, annotation.specialization)
                if property == "major" then
                    code = format("AzeriteEssenceIsMajor(%s)", essenceId)
                elseif property == "minor" then
                    code = format("AzeriteEssenceIsMinor(%s)", essenceId)
                elseif property == "enabled" then
                    code = format("AzeriteEssenceIsEnabled(%s)", essenceId)
                elseif property == "rank" then
                    code = format("AzeriteEssenceRank(%s)", essenceId)
                end
                if code then
                    node = self.ovaleAst:parseCode("expression", code, nodeList, annotation.astAnnotation)
                    self:addSymbol(annotation, essenceId)
                end
            end
            return node
        end
        self.emitOperandRefresh = function(operand, parseNode, nodeList, annotation, action, target)
            local node
            local tokenIterator = gmatch(operand, operandTokenPattern)
            local token = tokenIterator()
            if token == "refreshable" and action then
                local buffName
                buffName = self:disambiguate(annotation, action, annotation.classId, annotation.specialization, nil, "debuff")
                local target
                local prefix = (find(buffName, "_buff$") and "Buff") or "Debuff"
                if prefix == "Debuff" then
                    target = "target."
                else
                    target = ""
                end
                local any = (self.ovaleData.defaultSpellLists[buffName] and " any=1") or ""
                local code = format("%sRefreshable(%s%s)", target, buffName, any)
                node = self.ovaleAst:parseCode("expression", code, nodeList, annotation.astAnnotation)
                self:addSymbol(annotation, buffName)
            end
            return node
        end
        self.emitOperandDbc = function(operand, parseNode, nodeList, annotation, action, target)
            if  not annotation.dbc then
                return nil
            end
            local tokenIterator = gmatch(operand, operandTokenPattern)
            local token = tokenIterator()
            if token ~= "dbc" then
                return nil
            end
            local dataBaseName = tokenIterator()
            if dataBaseName == "effect" then
                local effectId = tonumber(tokenIterator())
                local property = tokenIterator()
                if property == "base_value" then
                    local effect = annotation.dbc.effect[effectId]
                    if effect then
                        return self.ovaleAst:newValue(annotation.astAnnotation, effect.base_value)
                    end
                end
            end
            return nil
        end
        self.emitOperandBuff = function(operand, parseNode, nodeList, annotation, action, target)
            local node
            local tokenIterator = gmatch(operand, operandTokenPattern)
            local token = tokenIterator()
            if token == "aura" or token == "buff" or token == "debuff" or token == "consumable" then
                local name = tokenIterator()
                local property = tokenIterator()
                if token == "consumable" and property == nil then
                    property = "remains"
                end
                local code
                local buffName
                if self:isDaemon(name) then
                    if name == "tyrant" then
                        buffName = "demonic_tyrant"
                    else
                        buffName = name
                    end
                    if property == "remains" then
                        code = "demonduration(" .. buffName .. ")"
                    elseif property == "stack" then
                        code = "demons(" .. buffName .. ")"
                    elseif property == "down" then
                        code = "demonduration(" .. buffName .. ") <= 0"
                    end
                elseif name == "arcane_charge" then
                    if property == "stack" then
                        code = "arcanecharges()"
                    elseif property == "max_stack" then
                        code = "maxarcanecharges()"
                    end
                elseif name == "frozen_pulse" then
                    if property == "up" then
                        code = "runecount() < 3"
                    end
                else
                    buffName = self:disambiguate(annotation, name, annotation.classId, annotation.specialization, nil, token)
                    local prefix
                    if  not find(buffName, "_debuff$") and  not find(buffName, "_debuff$") then
                        prefix = (target == "target" and "Debuff") or "Buff"
                    else
                        prefix = (find(buffName, "_debuff$") and "Debuff") or "Buff"
                    end
                    local any = (self.ovaleData.defaultSpellLists[buffName] and " any=1") or ""
                    target = (target and target .. ".") or ""
                    if buffName == "dark_transformation" and target == "" then
                        target = "pet."
                    end
                    if buffName == "beast_cleave_buff" and target == "" then
                        target = "pet."
                    end
                    if buffName == "frenzy_pet_buff" and target == "" then
                        target = "pet."
                    end
                    if property == "cooldown_remains" then
                        code = format("SpellCooldown(%s)", name)
                    elseif property == "down" then
                        code = format("%s%sExpires(%s%s)", target, prefix, buffName, any)
                    elseif property == "duration" then
                        code = format("BaseDuration(%s)", buffName)
                    elseif property == "last_expire" then
                        code = format("%sBuffLastExpire(%s)", target, buffName)
                    elseif property == "max_stack" then
                        code = format("SpellData(%s max_stacks)", buffName)
                    elseif property == "react" or property == "stack" then
                        if parseNode.asType == "boolean" then
                            code = format("%s%sPresent(%s%s)", target, prefix, buffName, any)
                        else
                            code = format("%s%sStacks(%s%s)", target, prefix, buffName, any)
                        end
                    elseif property == "remains" then
                        if parseNode.asType == "boolean" then
                            code = format("%s%sPresent(%s%s)", target, prefix, buffName, any)
                        else
                            code = format("%s%sRemaining(%s%s)", target, prefix, buffName, any)
                        end
                    elseif property == "up" then
                        code = format("%s%sPresent(%s%s)", target, prefix, buffName, any)
                    elseif property == "refreshable" then
                        code = format("%s%sRefreshable(%s)", target, prefix, buffName)
                    elseif property == "improved" then
                        code = format("%sImproved(%s%s)", prefix, buffName)
                    elseif property == "stack_value" then
                        code = format("%s%sStacks(%s%s)", target, prefix, buffName, any)
                    elseif property == "value" then
                        code = format("%s%sAmount(%s%s)", target, prefix, buffName, any)
                    end
                end
                if code then
                    annotation.astAnnotation = annotation.astAnnotation or {}
                    node = self.ovaleAst:parseCode("expression", code, nodeList, annotation.astAnnotation)
                    if buffName then
                        self:addSymbol(annotation, buffName)
                    end
                end
            end
            return node
        end
        self.emitOperandCharacter = function(operand, parseNode, nodeList, annotation, action, target)
            local node
            local className = annotation.classId
            local specialization = annotation.specialization
            local camelSpecialization = toLowerSpecialization(annotation)
            target = (target and target .. ".") or ""
            local code
            if characterProperties[operand] then
                code = target .. characterProperties[operand]
            elseif operand == "position_front" then
                code = (annotation.position == "front" and "always(position_front)") or "never(position_front)"
            elseif operand == "position_back" then
                code = (annotation.position == "back" and "always(position_back)") or "never(position_back)"
            elseif className == "MAGE" and operand == "incanters_flow_dir" then
                local name = "incanters_flow_buff"
                code = format("BuffDirection(%s)", name)
                self:addSymbol(annotation, name)
            elseif className == "PALADIN" and operand == "time_to_hpg" then
                code = camelSpecialization .. "TimeToHPG()"
                if specialization == "holy" then
                    annotation.time_to_hpg_heal = className
                elseif specialization == "protection" then
                    annotation.time_to_hpg_tank = className
                elseif specialization == "retribution" then
                    annotation.time_to_hpg_melee = className
                end
            elseif className == "PRIEST" and operand == "shadowy_apparitions_in_flight" then
                code = "1"
            elseif operand == "rtb_buffs" then
                code = "BuffCount(roll_the_bones_buff)"
            elseif className == "ROGUE" and operand == "anticipation_charges" then
                local name = "anticipation_buff"
                code = format("BuffStacks(%s)", name)
                self:addSymbol(annotation, name)
            elseif sub(operand, 1, 22) == "active_enemies_within." then
                code = "Enemies()"
            elseif find(operand, "^incoming_damage_") then
                local _seconds, measure = match(operand, "^incoming_damage_([%d]+)(m?s?)$")
                local seconds = tonumber(_seconds)
                if measure == "ms" then
                    seconds = seconds / 1000
                end
                if parseNode.asType == "boolean" then
                    code = format("IncomingDamage(%f) > 0", seconds)
                else
                    code = format("IncomingDamage(%f)", seconds)
                end
            elseif sub(operand, 1, 10) == "main_hand." then
                local weaponType = sub(operand, 11)
                if weaponType == "1h" then
                    code = "HasWeapon(main type=one_handed)"
                elseif weaponType == "2h" then
                    code = "HasWeapon(main type=two_handed)"
                end
            elseif operand == "mastery_value" then
                code = format("%sMasteryEffect() / 100", target)
            elseif sub(operand, 1, 5) == "role." then
                local role = match(operand, "^role%.([%w_]+)")
                if role and role == annotation.role then
                    code = format("always(role_%s)", role)
                else
                    code = format("never(role_%s)", role)
                end
            elseif operand == "spell_haste" or operand == "stat.spell_haste" then
                code = "100 / { 100 + SpellCastSpeedPercent() }"
            elseif operand == "attack_haste" or operand == "stat.attack_haste" then
                code = "100 / { 100 + MeleeAttackSpeedPercent() }"
            elseif sub(operand, 1, 13) == "spell_targets" then
                code = "Enemies(tagged=1)"
            elseif operand == "t18_class_trinket" then
                code = format("HasTrinket(%s)", operand)
                self:addSymbol(annotation, operand)
            end
            if code then
                annotation.astAnnotation = annotation.astAnnotation or {}
                node = self.ovaleAst:parseCode("expression", code, nodeList, annotation.astAnnotation)
            end
            return node
        end
        self.emitOperandCooldown = function(operand, parseNode, nodeList, annotation, action)
            local node
            local tokenIterator = gmatch(operand, operandTokenPattern)
            local token = tokenIterator()
            if token == "cooldown" then
                local name = tokenIterator()
                local property = tokenIterator()
                local prefix
                local isSymbol
                if match(name, "^item_cd_") then
                    name = "shared=\"" .. name .. "\""
                    prefix = "Item"
                    isSymbol = false
                else
                    name, prefix = self:disambiguate(annotation, name, annotation.classId, annotation.specialization, "spell")
                    isSymbol = true
                end
                local code
                if property == "execute_time" then
                    code = format("ExecuteTime(%s)", name)
                elseif property == "duration" then
                    code = format("%sCooldownDuration(%s)", prefix, name)
                elseif property == "ready" then
                    code = format("%sCooldown(%s) <= 0", prefix, name)
                elseif property == "remains" or property == "remains_guess" or property == "adjusted_remains" then
                    if parseNode.asType == "boolean" then
                        code = format("%sCooldown(%s) > 0", prefix, name)
                    else
                        code = format("%sCooldown(%s)", prefix, name)
                    end
                elseif property == "up" then
                    code = format("not %sCooldown(%s) > 0", prefix, name)
                elseif property == "charges" then
                    if parseNode.asType == "boolean" then
                        code = format("%sCharges(%s) > 0", prefix, name)
                    else
                        code = format("%sCharges(%s)", prefix, name)
                    end
                elseif property == "charges_fractional" then
                    code = format("%sCharges(%s count=0)", prefix, name)
                elseif property == "max_charges" then
                    code = format("%sMaxCharges(%s)", prefix, name)
                elseif property == "full_recharge_time" then
                    code = format("%sCooldown(%s)", prefix, name)
                end
                if code then
                    node = self.ovaleAst:parseCode("expression", code, nodeList, annotation.astAnnotation)
                    if isSymbol then
                        self:addSymbol(annotation, name)
                    end
                end
            end
            return node
        end
        self.emitOperandDisease = function(operand, parseNode, nodeList, annotation, action, target)
            local node
            local tokenIterator = gmatch(operand, operandTokenPattern)
            local token = tokenIterator()
            if token == "disease" then
                local property = tokenIterator()
                target = (target and target .. ".") or ""
                local code
                if property == "max_ticking" then
                    code = target .. "DiseasesAnyTicking()"
                elseif property == "min_remains" then
                    code = target .. "DiseasesRemaining()"
                elseif property == "min_ticking" then
                    code = target .. "DiseasesTicking()"
                elseif property == "ticking" then
                    code = target .. "DiseasesAnyTicking()"
                end
                if code then
                    node = self.ovaleAst:parseCode("expression", code, nodeList, annotation.astAnnotation)
                end
            end
            return node
        end
        self.emitOperandGroundAoe = function(operand, parseNode, nodeList, annotation, action)
            local node
            local tokenIterator = gmatch(operand, operandTokenPattern)
            local token = tokenIterator()
            if token == "ground_aoe" then
                local name = tokenIterator()
                local property = tokenIterator()
                name = self:disambiguate(annotation, name, annotation.classId, annotation.specialization)
                local dotName
                dotName = self:disambiguate(annotation, name, annotation.classId, annotation.specialization, nil, "debuff")
                local prefix = (find(dotName, "_buff$") and "Buff") or "Debuff"
                local target = (prefix == "Debuff" and "target.") or ""
                local code
                if property == "remains" then
                    code = format("%s%sRemaining(%s)", target, prefix, dotName)
                end
                if code then
                    node = self.ovaleAst:parseCode("expression", code, nodeList, annotation.astAnnotation)
                    self:addSymbol(annotation, dotName)
                end
            end
            return node
        end
        self.emitOperandDot = function(operand, parseNode, nodeList, annotation, action, target)
            local node
            local tokenIterator = gmatch(operand, operandTokenPattern)
            local token = tokenIterator()
            if token == "dot" then
                local name = tokenIterator()
                if match(name, "_dot$") then
                    name = gsub(name, "_dot$", "")
                end
                local property = tokenIterator()
                local dotName = self:disambiguate(annotation, name, annotation.classId, annotation.specialization, nil, "debuff")
                local prefix = (find(dotName, "_buff$") and "Buff") or "Debuff"
                target = (target and target .. ".") or ""
                local code
                if property == "duration" then
                    code = format("%s%sDuration(%s)", target, prefix, dotName)
                elseif property == "pmultiplier" then
                    code = format("%s%sPersistentMultiplier(%s)", target, prefix, dotName)
                elseif property == "remains" then
                    code = format("%s%sRemaining(%s)", target, prefix, dotName)
                elseif property == "stack" then
                    code = format("%s%sStacks(%s)", target, prefix, dotName)
                elseif property == "tick_dmg" then
                    code = format("%sTickValue(%s)", target, prefix, dotName)
                elseif property == "ticking" then
                    code = format("%s%sPresent(%s)", target, prefix, dotName)
                elseif property == "ticks_remain" then
                    code = format("%sTicksRemaining(%s)", target, dotName)
                elseif property == "tick_time_remains" then
                    code = format("%sTickTimeRemaining(%s)", target, dotName)
                elseif property == "exsanguinated" then
                    code = format("TargetDebuffRemaining(%s_exsanguinated)", dotName)
                elseif property == "refreshable" then
                    code = format("%s%sRefreshable(%s)", target, prefix, dotName)
                elseif property == "max_stacks" then
                    code = format("MaxStacks(%s)", dotName)
                end
                if code then
                    node = self.ovaleAst:parseCode("expression", code, nodeList, annotation.astAnnotation)
                    self:addSymbol(annotation, dotName)
                end
            end
            return node
        end
        self.emitOperandGlyph = function(operand, parseNode, nodeList, annotation, action)
            local node
            local tokenIterator = gmatch(operand, operandTokenPattern)
            local token = tokenIterator()
            if token == "glyph" then
                local name = tokenIterator()
                local property = tokenIterator()
                name = self:disambiguate(annotation, name, annotation.classId, annotation.specialization)
                local glyphName = "glyph_of_" .. name
                glyphName = self:disambiguate(annotation, glyphName, annotation.classId, annotation.specialization)
                local code
                if property == "disabled" then
                    code = format("not Glyph(%s)", glyphName)
                elseif property == "enabled" then
                    code = format("Glyph(%s)", glyphName)
                end
                if code then
                    node = self.ovaleAst:parseCode("expression", code, nodeList, annotation.astAnnotation)
                    self:addSymbol(annotation, glyphName)
                end
            end
            return node
        end
        self.emitOperandPet = function(operand, parseNode, nodeList, annotation, action)
            local node
            local tokenIterator = gmatch(operand, operandTokenPattern)
            local token = tokenIterator()
            if token == "pet" then
                local name = tokenIterator()
                local property = tokenIterator()
                local target = "pet"
                if name == "buff" then
                    local pattern = format("^pet%%.([%%w_.]+)", operand)
                    local petOperand = match(operand, pattern)
                    node = self.emitOperandBuff(petOperand, parseNode, nodeList, annotation, action, target)
                else
                    local pattern = format("^pet%%.%s%%.([%%w_.]+)", name)
                    local petOperand = match(operand, pattern)
                    if petOperand then
                        node = self.emitOperandSpecial(petOperand, parseNode, nodeList, annotation, action, target)
                    end
                    if  not node then
                        local code
                        local spellName = self:disambiguate(annotation, name, annotation.classId, annotation.specialization)
                        if isTotem(spellName) then
                            if property == "active" then
                                code = format("TotemPresent(%s)", spellName)
                            elseif property == "remains" then
                                code = format("TotemRemaining(%s)", spellName)
                            end
                            self:addSymbol(annotation, spellName)
                        elseif property == "active" then
                            code = "pet.Present()"
                        end
                        if code then
                            node = self.ovaleAst:parseCode("expression", code, nodeList, annotation.astAnnotation)
                        end
                        if  not node then
                            node = self.emitOperandAction(petOperand, parseNode, nodeList, annotation, action, target)
                        end
                        if  not node then
                            node = self.emitOperandCharacter(petOperand, parseNode, nodeList, annotation, action, target)
                        end
                        if  not node then
                            local petAbilityName = match(petOperand, "^[%w_]+%.([^.]+)")
                            petAbilityName = self:disambiguate(annotation, petAbilityName, annotation.classId, annotation.specialization)
                            if sub(petAbilityName, 1, 4) ~= "pet_" and name ~= "main" then
                                petOperand = gsub(petOperand, "^([%w_]+)%.", "%1." .. name .. "_")
                            end
                            if property == "buff" then
                                node = self.emitOperandBuff(petOperand, parseNode, nodeList, annotation, action, target)
                            elseif property == "cooldown" then
                                node = self.emitOperandCooldown(petOperand, parseNode, nodeList, annotation, action)
                            elseif property == "debuff" then
                                node = self.emitOperandBuff(petOperand, parseNode, nodeList, annotation, action, target)
                            elseif property == "dot" then
                                node = self.emitOperandDot(petOperand, parseNode, nodeList, annotation, action, target)
                            end
                        end
                    end
                end
            end
            return node
        end
        self.emitOperandPreviousSpell = function(operand, parseNode, nodeList, annotation, action)
            local node
            local tokenIterator = gmatch(operand, operandTokenPattern)
            local token = tokenIterator()
            if token == "prev" or token == "prev_gcd" or token == "prev_off_gcd" then
                local name = tokenIterator()
                local howMany = 1
                if tonumber(name) then
                    howMany = tonumber(name)
                    name = tokenIterator()
                end
                name = self:disambiguate(annotation, name, annotation.classId, annotation.specialization)
                local code
                if token == "prev" then
                    code = format("PreviousSpell(%s)", name)
                elseif token == "prev_gcd" then
                    if howMany ~= 1 then
                        code = format("PreviousGCDSpell(%s count=%d)", name, howMany)
                    else
                        code = format("PreviousGCDSpell(%s)", name)
                    end
                else
                    code = format("PreviousOffGCDSpell(%s)", name)
                end
                if code then
                    node = self.ovaleAst:parseCode("expression", code, nodeList, annotation.astAnnotation)
                    self:addSymbol(annotation, name)
                end
            end
            return node
        end
        self.emitOperandRaidEvent = function(operand, parseNode, nodeList, annotation, action)
            local node
            local name
            local property
            if sub(operand, 1, 11) == "raid_event." then
                local tokenIterator = gmatch(operand, operandTokenPattern)
                tokenIterator()
                name = tokenIterator()
                property = tokenIterator()
            else
                local tokenIterator = gmatch(operand, operandTokenPattern)
                name = tokenIterator()
                property = tokenIterator()
            end
            local code
            if name == "movement" then
                if property == "cooldown" or property == "in" then
                    code = "600"
                elseif property == "distance" then
                    code = "target.Distance()"
                elseif property == "exists" then
                    code = "never(raid_event_movement_exists)"
                elseif property == "remains" then
                    code = "0"
                end
            elseif name == "adds" then
                if property == "cooldown" then
                    code = "600"
                elseif property == "count" then
                    code = "0"
                elseif property == "exists" or property == "up" then
                    code = "never(raid_event_adds_exists)"
                elseif property == "in" then
                    code = "600"
                elseif property == "duration" then
                    code = "10"
                elseif property == "remains" then
                    code = "0"
                end
            elseif name == "invulnerable" then
                if property == "up" then
                    code = "never(raid_events_invulnerable_up)"
                elseif property == "exists" then
                    code = "never(raid_event_invulnerable_exists)"
                end
            end
            if code then
                node = self.ovaleAst:parseCode("expression", code, nodeList, annotation.astAnnotation)
            end
            return node
        end
        self.emitOperandRace = function(operand, parseNode, nodeList, annotation, action)
            local node
            local tokenIterator = gmatch(operand, operandTokenPattern)
            local token = tokenIterator()
            if token == "race" then
                local race = lower(tokenIterator())
                local code
                if race then
                    local raceId = nil
                    if race == "blood_elf" then
                        raceId = "BloodElf"
                    elseif race == "troll" then
                        raceId = "Troll"
                    elseif race == "orc" then
                        raceId = "Orc"
                    elseif race == "night_elf" then
                        raceId = "NightElf"
                    else
                        self.tracer:print("Warning: Race '%s' not defined", race)
                    end
                    code = format("Race(%s)", raceId)
                end
                if code then
                    node = self.ovaleAst:parseCode("expression", code, nodeList, annotation.astAnnotation)
                end
            end
            return node
        end
        self.emitOperandRune = function(operand, parseNode, nodeList, annotation, action)
            local node
            local code
            if parseNode.rune then
                if parseNode.asType == "boolean" then
                    code = "RuneCount() >= 1"
                else
                    code = "RuneCount()"
                end
            elseif match(operand, "^rune.time_to_([%d]+)$") then
                local runes = match(operand, "^rune.time_to_([%d]+)$")
                code = format("TimeToRunes(%d)", runes)
            else
                return nil
            end
            node = self.ovaleAst:parseCode("expression", code, nodeList, annotation.astAnnotation)
            return node
        end
        self.emitOperandSetBonus = function(operand, parseNode, nodeList, annotation, action)
            local node
            local setBonus = match(operand, "^set_bonus%.(.*)$")
            local code
            if setBonus then
                local tokenIterator = gmatch(setBonus, "[^_]+")
                local name = tokenIterator()
                local count = tokenIterator()
                local role = tokenIterator()
                if name and count then
                    local setName, level = match(name, "^(%a+)(%d*)$")
                    if setName == "tier" then
                        setName = "T"
                    else
                        setName = upper(setName)
                    end
                    if level then
                        name = setName .. tostring(level)
                    end
                    if role then
                        name = name .. "_" .. role
                    end
                    count = match(count, "(%d+)pc")
                    if name and count then
                        code = format("ArmorSetBonus(%s %d)", name, count)
                    end
                end
            end
            if code then
                node = self.ovaleAst:parseCode("expression", code, nodeList, annotation.astAnnotation)
            end
            return node
        end
        self.emitOperandSeal = function(operand, parseNode, nodeList, annotation, action)
            local node
            local tokenIterator = gmatch(operand, operandTokenPattern)
            local token = tokenIterator()
            if token == "seal" then
                local name = lower(tokenIterator())
                local code
                if name then
                    code = format("Stance(paladin_seal_of_%s)", name)
                end
                if code then
                    node = self.ovaleAst:parseCode("expression", code, nodeList, annotation.astAnnotation)
                end
            end
            return node
        end
        self.emitOperandSpecial = function(operand, parseNode, nodeList, annotation, action, target)
            local node
            local className = annotation.classId
            local specialization = annotation.specialization
            target = (target and target .. ".") or ""
            operand = lower(operand)
            local code
            if operand == "desired_targets" then
                code = toCamelCase(specialization) .. "DesiredTargets()"
                annotation.desired_targets = true
            elseif className == "DEATHKNIGHT" and operand == "dot.breath_of_sindragosa.ticking" then
                local buffName = "breath_of_sindragosa"
                code = format("BuffPresent(%s)", buffName)
                self:addSymbol(annotation, buffName)
            elseif className == "DEATHKNIGHT" and sub(operand, 1, 24) == "pet.dancing_rune_weapon." then
                local petOperand = sub(operand, 25)
                local tokenIterator = gmatch(petOperand, operandTokenPattern)
                local token = tokenIterator()
                if token == "active" then
                    local buffName = "dancing_rune_weapon_buff"
                    code = format("BuffPresent(%s)", buffName)
                    self:addSymbol(annotation, buffName)
                elseif token == "dot" then
                    if target == "" then
                        target = "target"
                    else
                        target = sub(target, 1, -2)
                    end
                    node = self.emitOperandDot(petOperand, parseNode, nodeList, annotation, action, target)
                end
            elseif className == "DEATHKNIGHT" and sub(operand, 1, 15) == "pet.army_ghoul." then
                local petOperand = sub(operand, 15)
                local tokenIterator = gmatch(petOperand, operandTokenPattern)
                local token = tokenIterator()
                if token == "active" then
                    local spell = "army_of_the_dead"
                    code = format("SpellCooldownDuration(%s) - SpellCooldown(%s) < 30", spell, spell)
                    self:addSymbol(annotation, spell)
                end
            elseif className == "DEATHKNIGHT" and sub(operand, 1, 15) == "pet.apoc_ghoul." then
                local petOperand = sub(operand, 15)
                local tokenIterator = gmatch(petOperand, operandTokenPattern)
                local token = tokenIterator()
                if token == "active" then
                    local spell = "apocalypse"
                    code = format("SpellCooldownDuration(%s) - SpellCooldown(%s) < 15", spell, spell)
                    self:addSymbol(annotation, spell)
                end
            elseif className == "DEMONHUNTER" and match(operand, "^buff%.out_of_range%.") then
                local tokenIterator = gmatch(operand, operandTokenPattern)
                tokenIterator()
                tokenIterator()
                local modifier = lower(tokenIterator())
                local spell = "chaos_strike"
                if specialization == "vengeance" then
                    spell = "shear"
                end
                if modifier == "up" then
                    code = format("not target.InRange(%s)", spell)
                elseif modifier == "down" then
                    code = format("target.InRange(%s)", spell)
                end
                self:addSymbol(annotation, spell)
            elseif className == "DEMONHUNTER" and operand == "buff.metamorphosis.extended_by_demonic" then
                code = "not BuffExpires(extended_by_demonic_buff)"
            elseif className == "DEMONHUNTER" and operand == "cooldown.chaos_blades.ready" then
                code = "Talent(chaos_blades_talent) and SpellCooldown(chaos_blades) <= 0"
                self:addSymbol(annotation, "chaos_blades_talent")
                self:addSymbol(annotation, "chaos_blades")
            elseif className == "DEMONHUNTER" and operand == "cooldown.nemesis.ready" then
                code = "Talent(nemesis_talent) and SpellCooldown(nemesis) <= 0"
                self:addSymbol(annotation, "nemesis_talent")
                self:addSymbol(annotation, "nemesis")
            elseif className == "DEMONHUNTER" and operand == "cooldown.metamorphosis.ready" and specialization == "havoc" then
                code = "(not CheckBoxOn(opt_meta_only_during_boss) or IsBossFight()) and SpellCooldown(metamorphosis) <= 0"
                self:addSymbol(annotation, "metamorphosis")
            elseif className == "DRUID" and match(operand, "^druid%.") then
                local tokenIterator = gmatch(operand, operandTokenPattern)
                tokenIterator()
                local name = lower(tokenIterator())
                local debuffName = self:disambiguate(annotation, name, annotation.classId, annotation.specialization, nil, "debuff")
                local property = tokenIterator()
                if property == "ticks_gained_on_refresh" then
                    if debuffName == "primal_wrath" then
                        code = "target.TicksGainedOnRefresh(rip primal_wrath)"
                        self:addSymbol(annotation, "primal_wrath")
                        self:addSymbol(annotation, "rip")
                    else
                        code = format("target.TicksGainedOnRefresh(%s)", debuffName)
                        self:addSymbol(annotation, debuffName)
                    end
                end
            elseif className == "DRUID" and operand == "buff.wild_charge_movement.down" then
                code = "always(wild_charge_movement_down)"
            elseif className == "DRUID" and operand == "eclipse_dir.lunar" then
                code = "EclipseDir() < 0"
            elseif className == "DRUID" and operand == "eclipse_dir.solar" then
                code = "EclipseDir() > 0"
            elseif className == "DRUID" and operand == "max_fb_energy" then
                local spellName = "ferocious_bite"
                code = format("EnergyCost(%s max=1)", spellName)
                self:addSymbol(annotation, spellName)
            elseif className == "DRUID" and operand == "solar_wrath.ap_check" then
                local spellName = "solar_wrath"
                code = format("AstralPower() >= AstralPowerCost(%s)", spellName)
                self:addSymbol(annotation, spellName)
            elseif className == "DRUID" and operand == "starfire.ap_check" then
                local spellName = "starfire"
                code = format("AstralPower() >= AstralPowerCost(%s)", spellName)
                self:addSymbol(annotation, spellName)
            elseif className == "HUNTER" and operand == "buff.careful_aim.up" then
                code = "target.HealthPercent() > 80 or BuffPresent(rapid_fire_buff)"
                self:addSymbol(annotation, "rapid_fire_buff")
            elseif className == "HUNTER" and operand == "buff.stampede.remains" then
                local spellName = "stampede"
                code = format("TimeSincePreviousSpell(%s) < 40", spellName)
                self:addSymbol(annotation, spellName)
            elseif className == "HUNTER" and operand == "lowest_vuln_within.5" then
                code = "target.DebuffRemaining(vulnerable)"
                self:addSymbol(annotation, "vulnerable")
            elseif className == "HUNTER" and operand == "cooldown.trueshot.duration_guess" then
                code = "0"
            elseif className == "HUNTER" and operand == "ca_execute" then
                code = "Talent(careful_aim_talent) and (target.HealthPercent() > 80 or target.HealthPercent() < 20)"
                self:addSymbol(annotation, "careful_aim_talent")
            elseif className == "MAGE" and operand == "buff.rune_of_power.remains" then
                code = "TotemRemaining(rune_of_power)"
            elseif className == "MAGE" and operand == "buff.shatterlance.up" then
                code = "HasTrinket(t18_class_trinket) and PreviousGCDSpell(frostbolt)"
                self:addSymbol(annotation, "frostbolt")
                self:addSymbol(annotation, "t18_class_trinket")
            elseif className == "MAGE" and (operand == "burn_phase" or operand == "pyro_chain") then
                if parseNode.asType == "boolean" then
                    code = format("GetState(%s) > 0", operand)
                else
                    code = format("GetState(%s)", operand)
                end
            elseif className == "MAGE" and (operand == "burn_phase_duration" or operand == "pyro_chain_duration") then
                local variable = sub(operand, 1, -10)
                if parseNode.asType == "boolean" then
                    code = format("GetStateDuration(%s) > 0", variable)
                else
                    code = format("GetStateDuration(%s)", variable)
                end
            elseif className == "MAGE" and operand == "firestarter.active" then
                code = "Talent(firestarter_talent) and target.HealthPercent() >= 90"
                self:addSymbol(annotation, "firestarter_talent")
            elseif className == "MAGE" and operand == "brain_freeze_active" then
                code = "target.DebuffPresent(winters_chill_debuff)"
                self:addSymbol(annotation, "winters_chill_debuff")
            elseif className == "MAGE" and operand == "action.frozen_orb.in_flight" then
                code = "TimeSincePreviousSpell(frozen_orb) < 10"
                self:addSymbol(annotation, "frozen_orb")
            elseif className == "MONK" and sub(operand, 1, 35) == "debuff.storm_earth_and_fire_target." then
                local property = sub(operand, 36)
                if target == "" then
                    target = "target."
                end
                local debuffName = "storm_earth_and_fire_target_debuff"
                self:addSymbol(annotation, debuffName)
                if property == "down" then
                    code = format("%sDebuffExpires(%s)", target, debuffName)
                elseif property == "up" then
                    code = format("%sDebuffPresent(%s)", target, debuffName)
                end
            elseif className == "MONK" and operand == "dot.zen_sphere.ticking" then
                local buffName = "zen_sphere_buff"
                code = format("BuffPresent(%s)", buffName)
                self:addSymbol(annotation, buffName)
            elseif className == "MONK" and operand == "spinning_crane_kick.count" then
                code = "SpellCount(spinning_crane_kick)"
                self:addSymbol(annotation, "spinning_crane_kick")
            elseif className == "MONK" and operand == "combo_strike" then
                if action then
                    code = format("not PreviousSpell(%s)", action)
                end
            elseif className == "MONK" and operand == "combo_break" then
                if action then
                    code = format("PreviousSpell(%s)", action)
                end
            elseif className == "PALADIN" and operand == "dot.sacred_shield.remains" then
                local buffName = "sacred_shield_buff"
                code = format("BuffRemaining(%s)", buffName)
                self:addSymbol(annotation, buffName)
            elseif className == "PRIEST" and operand == "mind_harvest" then
                code = "target.MindHarvest()"
            elseif className == "PRIEST" and operand == "natural_shadow_word_death_range" then
                code = "target.HealthPercent() < 20"
            elseif className == "PRIEST" and operand == "primary_target" then
                code = "1"
            elseif className == "ROGUE" and operand == "trinket.cooldown.up" then
                code = "HasTrinket(draught_of_souls) and ItemCooldown(draught_of_souls) > 0"
                self:addSymbol(annotation, "draught_of_souls")
            elseif className == "ROGUE" and operand == "mantle_duration" then
                code = "BuffRemaining(master_assassins_initiative)"
                self:addSymbol(annotation, "master_assassins_initiative")
            elseif className == "ROGUE" and operand == "poisoned_enemies" then
                code = "0"
            elseif className == "ROGUE" and operand == "poisoned_bleeds" then
                code = "DebuffCountOnAny(rupture) + DebuffCountOnAny(garrote) + Talent(internal_bleeding_talent) * DebuffCountOnAny(internal_bleeding_debuff)"
                self:addSymbol(annotation, "rupture")
                self:addSymbol(annotation, "garrote")
                self:addSymbol(annotation, "internal_bleeding_talent")
                self:addSymbol(annotation, "internal_bleeding_debuff")
            elseif className == "ROGUE" and operand == "exsanguinated" then
                code = "target.DebuffPresent(exsanguinated)"
                self:addSymbol(annotation, "exsanguinated")
            elseif className == "ROGUE" and operand == "ss_buffed" then
                code = "never(ss_buffed)"
            elseif className == "ROGUE" and operand == "non_ss_buffed_targets" then
                code = "Enemies() - DebuffCountOnAny(garrote)"
                self:addSymbol(annotation, "garrote")
            elseif className == "ROGUE" and operand == "ss_buffed_targets_above_pandemic" then
                code = "0"
            elseif className == "ROGUE" and operand == "master_assassin_remains" then
                code = "BuffRemaining(master_assassin_buff)"
                self:addSymbol(annotation, "master_assassin_buff")
            elseif className == "ROGUE" and operand == "buff.roll_the_bones.remains" then
                code = "BuffRemaining(roll_the_bones_buff)"
                self:addSymbol(annotation, "roll_the_bones_buff")
            elseif className == "ROGUE" and operand == "buff.roll_the_bones.up" then
                code = "BuffPresent(roll_the_bones_buff)"
                self:addSymbol(annotation, "roll_the_bones_buff")
            elseif className == "SHAMAN" and operand == "buff.resonance_totem.remains" then
                local spell = self:disambiguate(annotation, "totem_mastery", annotation.classId, annotation.specialization)
                code = format("TotemRemaining(%s)", spell)
                self:addSymbol(annotation, spell)
            elseif className == "SHAMAN" and match(operand, "pet.[a-z_]+.active") then
                code = "pet.Present()"
            elseif className == "WARLOCK" and match(operand, "pet%.service_[a-z_]+%..+") then
                local spellName, property = match(operand, "pet%.(service_[a-z_]+)%.(.+)")
                if property == "active" then
                    code = format("SpellCooldown(%s) > 100", spellName)
                    self:addSymbol(annotation, spellName)
                end
            elseif className == "WARLOCK" and match(operand, "dot.unstable_affliction_([1-5]).remains") then
                local num = match(operand, "dot.unstable_affliction_([1-5]).remains")
                code = format("target.DebuffStacks(unstable_affliction_debuff) >= %s", num)
            elseif className == "WARLOCK" and operand == "buff.active_uas.stack" then
                code = "target.DebuffStacks(unstable_affliction_debuff)"
            elseif className == "WARLOCK" and match(operand, "pet%.[a-z_]+%..+") then
                local spellName, property = match(operand, "pet%.([a-z_]+)%.(.+)")
                if property == "remains" then
                    code = format("DemonDuration(%s)", spellName)
                elseif property == "active" then
                    code = format("DemonDuration(%s) > 0", spellName)
                end
            elseif className == "WARLOCK" and operand == "contagion" then
                code = "BuffRemaining(unstable_affliction_buff)"
            elseif className == "WARLOCK" and operand == "buff.wild_imps.stack" then
                code = "Demons(wild_imp) + Demons(wild_imp_inner_demons)"
                self:addSymbol(annotation, "wild_imp")
                self:addSymbol(annotation, "wild_imp_inner_demons")
            elseif className == "WARLOCK" and operand == "buff.dreadstalkers.remains" then
                code = "DemonDuration(dreadstalker)"
                self:addSymbol(annotation, "dreadstalker")
            elseif className == "WARLOCK" and match(operand, "imps_spawned_during.([%d]+)") then
                local ms = match(operand, "imps_spawned_during.([%d]+)")
                code = format("ImpsSpawnedDuring(%d)", ms)
            elseif className == "WARLOCK" and operand == "time_to_imps.all.remains" then
                code = "0"
            elseif className == "WARLOCK" and operand == "havoc_active" then
                code = "DebuffCountOnAny(havoc) > 0"
                self:addSymbol(annotation, "havoc")
            elseif className == "WARLOCK" and operand == "havoc_remains" then
                code = "DebuffRemainingOnAny(havoc)"
                self:addSymbol(annotation, "havoc")
            elseif className == "WARRIOR" and operand == "gcd.remains" and (action == "battle_cry" or action == "avatar") then
                code = "0"
            elseif operand == "buff.enrage.down" then
                code = "not " .. target .. "IsEnraged()"
            elseif operand == "buff.enrage.remains" then
                code = target .. "EnrageRemaining()"
            elseif operand == "buff.enrage.up" then
                code = target .. "IsEnraged()"
            elseif operand == "debuff.casting.react" then
                code = target .. "IsInterruptible()"
            elseif operand == "debuff.casting.up" then
                local t = (target == "" and "target.") or target
                code = t .. "IsInterruptible()"
            elseif operand == "distance" then
                code = target .. "Distance()"
            elseif sub(operand, 1, 9) == "equipped." then
                local name = self:disambiguate(annotation, sub(operand, 10) .. "_item", className, specialization)
                local itemId = tonumber(name)
                local itemName = name
                local item = (itemId and tostring(itemId)) or itemName
                code = format("HasEquippedItem(%s)", item)
                self:addSymbol(annotation, item)
            elseif operand == "gcd.max" then
                code = "GCD()"
            elseif operand == "gcd.remains" then
                code = "GCDRemaining()"
            elseif sub(operand, 1, 15) == "legendary_ring." then
                local name = self:disambiguate(annotation, "legendary_ring", className, specialization)
                local buffName = name .. "_buff"
                local properties = sub(operand, 16)
                local tokenIterator = gmatch(properties, operandTokenPattern)
                local token = tokenIterator()
                if token == "cooldown" then
                    token = tokenIterator()
                    if token == "down" then
                        code = format("ItemCooldown(%s) > 0", name)
                        self:addSymbol(annotation, name)
                    elseif token == "remains" then
                        code = format("ItemCooldown(%s)", name)
                        self:addSymbol(annotation, name)
                    elseif token == "up" then
                        code = format("not ItemCooldown(%s) > 0", name)
                        self:addSymbol(annotation, name)
                    end
                elseif token == "has_cooldown" then
                    code = format("ItemCooldownDuration(%s) > 0", name)
                    self:addSymbol(annotation, name)
                elseif token == "up" then
                    code = format("BuffPresent(%s)", buffName)
                    self:addSymbol(annotation, buffName)
                elseif token == "remains" then
                    code = format("BuffRemaining(%s)", buffName)
                    self:addSymbol(annotation, buffName)
                end
            elseif operand == "ptr" then
                code = "PTR()"
            elseif operand == "time_to_die" then
                code = "target.TimeToDie()"
            elseif sub(operand, 1, 10) == "using_apl." then
                local aplName = match(operand, "^using_apl%.([%w_]+)")
                code = format("List(opt_using_apl %s)", aplName)
                annotation.using_apl = annotation.using_apl or {}
                annotation.using_apl[aplName] = true
            elseif operand == "cooldown.buff_sephuzs_secret.remains" then
                code = "BuffCooldown(sephuzs_secret_buff)"
                self:addSymbol(annotation, "sephuzs_secret_buff")
            elseif operand == "is_add" then
                local t = target or "target."
                code = format("not %sClassification(worldboss)", t)
            elseif operand == "priority_rotation" then
                code = "CheckBoxOn(opt_priority_rotation)"
                annotation.opt_priority_rotation = className
            end
            if code then
                node = self.ovaleAst:parseCode("expression", code, nodeList, annotation.astAnnotation)
            end
            return node
        end
        self.emitOperandTalent = function(operand, parseNode, nodeList, annotation, action)
            local node
            local tokenIterator = gmatch(operand, operandTokenPattern)
            local token = tokenIterator()
            if token == "talent" then
                local name = lower(tokenIterator())
                local property = tokenIterator()
                local talentName = name .. "_talent"
                talentName = self:disambiguate(annotation, talentName, annotation.classId, annotation.specialization)
                local code
                if property == "disabled" then
                    if parseNode.asType == "boolean" then
                        code = format("not HasTalent(%s)", talentName)
                    else
                        code = format("HasTalent(%s no)", talentName)
                    end
                elseif property == "enabled" or property == nil then
                    if parseNode.asType == "boolean" then
                        code = format("HasTalent(%s)", talentName)
                    else
                        code = format("TalentPoints(%s)", talentName)
                    end
                end
                if code then
                    node = self.ovaleAst:parseCode("expression", code, nodeList, annotation.astAnnotation)
                    self:addSymbol(annotation, talentName)
                end
            end
            return node
        end
        self.emitOperandTarget = function(operand, parseNode, nodeList, annotation, action)
            local node
            local tokenIterator = gmatch(operand, operandTokenPattern)
            local target = tokenIterator()
            if target == "self" then
                target = "player"
            end
            local property = tokenIterator()
            local howMany = 1
            if tonumber(property) then
                howMany = tonumber(property)
                property = tokenIterator()
            end
            if howMany > 1 then
                self.tracer:print("Warning: target.%d.%property has not been implemented for multiple targets. (%s)", operand)
            end
            local code
            if  not property then
                code = target .. ".guid()"
            elseif property == "adds" then
                code = "Enemies()-1"
            elseif property == "target" then
                code = target .. ".targetguid()"
            elseif property == "time_to_die" then
                code = target .. ".TimeToDie()"
            elseif property == "distance" then
                code = target .. ".Distance()"
            elseif property == "is_boss" then
                code = target .. ".classification(worldboss)"
            elseif property == "health" then
                local modifier = tokenIterator()
                if modifier == "pct" then
                    code = target .. ".HealthPercent()"
                end
            elseif property then
                local percent = match(property, "^time_to_pct_(%d+)")
                if percent then
                    code = target .. ".TimeToHealthPercent(" .. percent .. ")"
                end
            end
            if code then
                node = self.ovaleAst:parseCode("expression", code, nodeList, annotation.astAnnotation)
            end
            return node
        end
        self.emitOperandTotem = function(operand, parseNode, nodeList, annotation, action)
            local node
            local tokenIterator = gmatch(operand, operandTokenPattern)
            local token = tokenIterator()
            if token == "totem" then
                local name = lower(tokenIterator())
                local property = tokenIterator()
                local code
                if property == "active" then
                    code = format("TotemPresent(%s)", name)
                elseif property == "remains" then
                    code = format("TotemRemaining(%s)", name)
                end
                if code then
                    node = self.ovaleAst:parseCode("expression", code, nodeList, annotation.astAnnotation)
                end
            end
            return node
        end
        self.emitOperandTrinket = function(operand, parseNode, nodeList, annotation, action)
            local node
            local tokenIterator = gmatch(operand, operandTokenPattern)
            local token = tokenIterator()
            if token == "trinket" then
                local procType = tokenIterator()
                local slot
                if procType == "1" or procType == "2" then
                    slot = "trinket" .. (tonumber(procType) - 1) .. "slot"
                    procType = tokenIterator()
                end
                local statName = tokenIterator()
                local code
                if procType == "is" and slot and statName then
                    local item = self:disambiguate(annotation, statName .. "_item", annotation.classId, annotation.specialization)
                    code = "iteminslot(\"" .. slot .. "\") == " .. item
                    self:addSymbol(annotation, item)
                elseif procType == "cooldown" then
                    if statName == "remains" then
                        code = emitTrinketCondition([[ItemCooldown(slot="%s")]], slot)
                    elseif statName == "duration" then
                        code = emitTrinketCondition([[ItemCooldownDuration(slot="%s")]], slot)
                    end
                elseif procType == "ready_cooldown" then
                    code = "0"
                elseif procType == "has_cooldown" then
                    code = emitTrinketCondition([[ItemCooldownDuration(slot="%s")]], slot)
                elseif procType == "has_proc" then
                    code = emitTrinketCondition([[ItemRppm(slot="%s") > 0]], slot)
                elseif procType == "has_stat" then
                    code = "false"
                else
                    local property = statName
                    local buffName = self:disambiguate(annotation, procType .. "_item", annotation.classId, annotation.specialization)
                    if property == "cooldown" then
                        code = format("BuffCooldownDuration(%s)", buffName)
                    elseif property == "cooldown_remains" then
                        code = format("BuffCooldown(%s)", buffName)
                    elseif property == "down" then
                        code = format("BuffExpires(%s)", buffName)
                    elseif property == "react" then
                        if parseNode.asType == "boolean" then
                            code = format("BuffPresent(%s)", buffName)
                        else
                            code = format("BuffStacks(%s)", buffName)
                        end
                    elseif property == "remains" then
                        code = format("BuffRemaining(%s)", buffName)
                    elseif property == "stack" then
                        code = format("BuffStacks(%s)", buffName)
                    elseif property == "up" then
                        code = format("BuffPresent(%s)", buffName)
                    end
                    self:addSymbol(annotation, buffName)
                end
                if code then
                    node = self.ovaleAst:parseCode("expression", code, nodeList, annotation.astAnnotation)
                end
            end
            return node
        end
        self.emitOperandVariable = function(operand, parseNode, nodeList, annotation, action)
            local tokenIterator = gmatch(operand, operandTokenPattern)
            local token = tokenIterator()
            local node
            if token == "variable" then
                local name = tokenIterator()
                if  not name then
                    self.tracer:error("Unable to parse variable name in EmitOperandVariable")
                else
                    if match(name, "^%d") then
                        name = "_" .. name
                    end
                    if annotation.currentVariable and annotation.currentVariable.name == name then
                        local group = annotation.currentVariable.body
                        if #group.child == 0 then
                            node = self.ovaleAst:parseCode("expression", "0", nodeList, annotation.astAnnotation)
                        else
                            node = self.ovaleAst:parseCode("group", self.ovaleAst:unparse(group), nodeList, annotation.astAnnotation)
                        end
                    else
                        node = self.ovaleAst:newNodeWithParameters("function", annotation.astAnnotation)
                        node.name = name
                    end
                end
            end
            return node
        end
        self.emitVisitors = {
            ["action"] = self.emitAction,
            ["action_list"] = self.emitActionList,
            ["operator"] = self.emitExpression,
            ["function"] = self.emitFunction,
            ["number"] = self.emitNumber,
            ["operand"] = self.emitOperand
        }
        self.tracer = ovaleDebug:create("SimulationCraftEmiter")
    end,
    addDisambiguation = function(self, name, info, className, specialization, _type)
        self:addPerClassSpecialization(self.emitDisambiguations, name, info, className, specialization, _type)
    end,
    disambiguateExact = function(self, annotation, name, className, specialization, _type)
        local disname, distype = self:getPerClassSpecialization(self.emitDisambiguations, name, className, specialization)
        if disname then
            return disname, distype
        end
        if annotation.dictionary[name] then
            return name, _type
        end
        return nil, nil
    end,
    disambiguate = function(self, annotation, name, className, specialization, _type, suffix)
        local disname
        local distype
        if suffix then
            disname, distype = self:disambiguateExact(annotation, name .. "_" .. specialization .. "_" .. suffix, className, specialization, _type)
            if disname then
                return disname, distype
            end
            disname, distype = self:disambiguateExact(annotation, name .. "_" .. lower(className) .. "_" .. suffix, className, specialization, _type)
            if disname then
                return disname, distype
            end
        end
        disname, distype = self:disambiguateExact(annotation, name .. "_" .. specialization, className, specialization, _type)
        if disname then
            return disname, distype
        end
        if suffix then
            disname, distype = self:disambiguateExact(annotation, name .. "_" .. suffix, className, specialization, _type)
            if disname then
                return disname, distype
            end
        end
        disname, distype = self:disambiguateExact(annotation, name .. "_" .. lower(className), className, specialization, _type)
        if disname then
            return disname, distype
        end
        disname, distype = self:disambiguateExact(annotation, name, className, specialization, _type)
        if disname then
            return disname, distype
        end
        return name, _type
    end,
    addPerClassSpecialization = function(self, tbl, name, info, className, specialization, _type)
        className = className or "ALL_CLASSES"
        specialization = specialization or "ALL_SPECIALIZATIONS"
        tbl[className] = tbl[className] or {}
        tbl[className][specialization] = tbl[className][specialization] or {}
        tbl[className][specialization][name] = {
            [1] = info,
            [2] = _type or "Spell"
        }
    end,
    getPerClassSpecialization = function(self, tbl, name, className, specialization)
        local info
        while  not info do
            while  not info do
                if tbl[className] and tbl[className][specialization] and tbl[className][specialization][name] then
                    info = tbl[className][specialization][name]
                end
                if specialization ~= "ALL_SPECIALIZATIONS" then
                    specialization = "ALL_SPECIALIZATIONS"
                else
                    break
                end
            end
            if className ~= "ALL_CLASSES" then
                className = "ALL_CLASSES"
            else
                break
            end
        end
        if info then
            return info[1], info[2]
        end
        return 
    end,
    initializeDisambiguation = function(self)
        self:addDisambiguation("exhaustion_buff", "exhaustion_debuff")
        self:addDisambiguation("inevitable_demise_az_buff", "inevitable_demise", "WARLOCK")
        self:addDisambiguation("dark_soul", "dark_soul_misery", "WARLOCK", "affliction")
        self:addDisambiguation("flagellation_cleanse", "flagellation", "ROGUE")
        self:addDisambiguation("ashvanes_razor_coral", "razor_coral")
        self:addDisambiguation("bok_proc_buff", "blackout_kick_aura_buff", "MONK", "windwalker")
        self:addDisambiguation("dance_of_chiji_azerite_buff", "dance_of_chiji_buff", "MONK", "windwalker")
        self:addDisambiguation("energizing_elixer_talent", "energizing_elixir_talent", "MONK", "windwalker")
        self:addDisambiguation("chiji_the_red_crane", "invoke_chiji_the_red_crane", "MONK", "mistweaver")
        self:addDisambiguation("yulon_the_jade_serpent", "invoke_yulon_the_jade_serpent", "MONK", "mistweaver")
        self:addDisambiguation("blink_any", "blink", "MAGE")
        self:addDisambiguation("buff_disciplinary_command", "disciplinary_command", "MAGE")
        self:addDisambiguation("hyperthread_wristwraps_300142", "hyperthread_wristwraps", "MAGE", "fire")
        self:addDisambiguation("use_mana_gem", "replenish_mana", "MAGE")
        self:addDisambiguation("unbridled_fury_buff", "potion_of_unbridled_fury")
        self:addDisambiguation("swipe_bear", "swipe", "DRUID")
        self:addDisambiguation("wound_spender", "scourge_strike", "DEATHKNIGHT")
        self:addDisambiguation("any_dnd", "death_and_decay", "DEATHKNIGHT")
        self:addDisambiguation("incarnation_talent", "incarnation_tree_of_life_talent", "DRUID", "restoration")
        self:addDisambiguation("lunar_inspiration", "moonfire_cat", "DRUID", "feral")
        self:addDisambiguation("incarnation_talent", "incarnation_guardian_of_ursoc_talent", "DRUID", "guardian")
        self:addDisambiguation("incarnation_talent", "incarnation_chosen_of_elune_talent", "DRUID", "balance")
        self:addDisambiguation("incarnation_talent", "incarnation_king_of_the_jungle_talent", "DRUID", "feral")
        self:addDisambiguation("ca_inc", "celestial_alignment", "DRUID")
        self:addDisambiguation("adaptive_swarm_heal", "adaptive_swarm", "DRUID")
        self:addDisambiguation("spectral_intellect_item", "potion_of_spectral_intellect_item")
        self:addDisambiguation("spectral_strength_item", "potion_of_spectral_strength_item")
        self:addDisambiguation("spectral_agility_item", "potion_of_spectral_agility_item")
        self:addDisambiguation("dreadfire_vessel_344732", "dreadfire_vessel", "MAGE")
        self:addDisambiguation("fiend", "shadowfiend", "PRIEST")
        self:addDisambiguation("deeper_strategem_talent", "deeper_stratagem_talent", "ROGUE")
        self:addDisambiguation("gargoyle", "summon_gargoyle", "DEATHKNIGHT", "unholy")
        self:addDisambiguation("ghoul", "raise_dead", "DEATHKNIGHT", "blood")
        self:addDisambiguation("ghoul", "raise_dead", "DEATHKNIGHT", "frost")
        self:addDisambiguation("dark_trasnformation", "dark_transformation", "DEATHKNIGHT")
        self:addDisambiguation("frenzy", "frenzy_pet_buff", "HUNTER")
        self:addDisambiguation("blood_fury", "blood_fury_ap_int", "MONK")
        self:addDisambiguation("blood_fury", "blood_fury_ap_int", "SHAMAN")
        self:addDisambiguation("blood_fury", "blood_fury_ap", "DEATHKNIGHT")
        self:addDisambiguation("blood_fury", "blood_fury_ap", "HUNTER")
        self:addDisambiguation("blood_fury", "blood_fury_ap", "ROGUE")
        self:addDisambiguation("blood_fury", "blood_fury_ap", "WARRIOR")
        self:addDisambiguation("blood_fury", "blood_fury_int", "MAGE")
        self:addDisambiguation("blood_fury", "blood_fury_int", "PRIEST")
        self:addDisambiguation("blood_fury", "blood_fury_int", "WARLOCK")
        self:addDisambiguation("blood_fury_buff", "blood_fury_ap_int", "MONK")
        self:addDisambiguation("blood_fury_buff", "blood_fury_ap_int", "SHAMAN")
        self:addDisambiguation("blood_fury_buff", "blood_fury_ap", "DEATHKNIGHT")
        self:addDisambiguation("blood_fury_buff", "blood_fury_ap", "HUNTER")
        self:addDisambiguation("blood_fury_buff", "blood_fury_ap", "ROGUE")
        self:addDisambiguation("blood_fury_buff", "blood_fury_ap", "WARRIOR")
        self:addDisambiguation("blood_fury_buff", "blood_fury_int", "MAGE")
        self:addDisambiguation("blood_fury_buff", "blood_fury_int", "PRIEST")
        self:addDisambiguation("blood_fury_buff", "blood_fury_int", "WARLOCK")
        self:addDisambiguation("elemental_equilibrium_debuff", "elemental_equilibrium_buff", "SHAMAN", "elemental")
        self:addDisambiguation("doom_winds_debuff", "doom_winds", "SHAMAN")
        self:addDisambiguation("meat_cleaver", "whirlwind_buff", "WARRIOR", "fury")
        self:addDisambiguation("roaring_blaze", "conflagrate_debuff", "WARLOCK", "destruction")
        self:addDisambiguation("chaos_theory_buff", "chaos_blades", "DEMONHUNTER")
        self:addDisambiguation("phantom_fire_item", "potion_of_phantom_fire_item")
    end,
    emit = function(self, parseNode, nodeList, annotation, action)
        local visitor = self.emitVisitors[parseNode.type]
        if  not visitor then
            self.tracer:error("Unable to emit node of type '%s'.", parseNode.type)
        else
            return visitor(parseNode, nodeList, annotation, action)
        end
    end,
    addSymbol = function(self, annotation, symbol)
        local symbolTable = annotation.symbolTable or {}
        local symbolList = annotation.symbolList or {}
        if  not symbolTable[symbol] and  not self.ovaleData.defaultSpellLists[symbol] then
            symbolTable[symbol] = true
            symbolList[#symbolList + 1] = symbol
        end
        annotation.symbolTable = symbolTable
        annotation.symbolList = symbolList
    end,
    emitMiscOperand = function(self, operand, parseNode, nodeList, annotation, action)
        local tokenIterator = gmatch(operand, operandTokenPattern)
        local miscOperand = tokenIterator()
        local info = miscOperands[miscOperand]
        if info then
            local modifier = tokenIterator()
            if info.code then
                if info.symbolsInCode then
                    for _, symbol in ipairs(info.symbolsInCode) do
                        annotation:addSymbol(symbol)
                    end
                    local result = self.ovaleAst:parseCode("expression", info.code, nodeList, annotation.astAnnotation)
                    if result then
                        return result
                    end
                    return nil
                end
            end
            local result = self.ovaleAst:newNodeWithParameters("function", annotation.astAnnotation)
            result.name = info.name or miscOperand
            if info.extraParameter then
                if isNumber(info.extraParameter) then
                    insert(result.rawPositionalParams, self.ovaleAst:newValue(annotation.astAnnotation, info.extraParameter))
                else
                    insert(result.rawPositionalParams, self.ovaleAst:newString(annotation.astAnnotation, info.extraParameter))
                end
            end
            if info.extraNamedParameter then
                if isNumber(info.extraNamedParameter.value) then
                    result.rawNamedParams[info.extraNamedParameter.name] = self.ovaleAst:newValue(annotation.astAnnotation, info.extraNamedParameter.value)
                else
                    result.rawNamedParams[info.extraNamedParameter.name] = self.ovaleAst:newString(annotation.astAnnotation, info.extraNamedParameter.value)
                end
            end
            if info.extraSymbol then
                insert(result.rawPositionalParams, self.ovaleAst:newVariable(annotation.astAnnotation, info.extraSymbol))
                annotation:addSymbol(info.extraSymbol)
            end
            while modifier do
                if  not info.modifiers and info.symbol == nil then
                    self.tracer:warning("Use of " .. modifier .. " for " .. operand .. " but no modifier has been registered")
                    self.ovaleAst:release(result)
                    return nil
                end
                local modifierParameters = info.modifiers and info.modifiers[modifier]
                if modifierParameters then
                    local modifierName = modifierParameters.name or modifier
                    if modifierParameters.code then
                        if modifierParameters.symbolsInCode then
                            for _, symbol in ipairs(modifierParameters.symbolsInCode) do
                                annotation:addSymbol(symbol)
                            end
                        end
                        self.ovaleAst:release(result)
                        local newCode = self.ovaleAst:parseCode("expression", modifierParameters.code, nodeList, annotation.astAnnotation)
                        if newCode then
                            return newCode
                        end
                        return nil
                    elseif modifierParameters.type == 1 then
                        result.name = modifierName .. result.name
                    elseif modifierParameters.type == 0 then
                        result.name = result.name .. modifierName
                    elseif modifierParameters.type == 2 then
                        insert(result.rawPositionalParams, self.ovaleAst:newString(annotation.astAnnotation, modifierName))
                    elseif modifierParameters.type == 6 then
                        insert(result.rawPositionalParams, self.ovaleAst:newVariable(annotation.astAnnotation, modifierName))
                        annotation:addSymbol(modifierName)
                    elseif modifierParameters.type == 4 then
                        result.name = modifierName
                    end
                    if modifierParameters.createOptions then
                        if  not annotation.options then
                            annotation.options = {}
                        end
                        annotation.options[modifierName] = true
                    end
                    if modifierParameters.extraParameter then
                        if isNumber(modifierParameters.extraParameter) then
                            insert(result.rawPositionalParams, self.ovaleAst:newValue(annotation.astAnnotation, modifierParameters.extraParameter))
                        else
                            insert(result.rawPositionalParams, self.ovaleAst:newString(annotation.astAnnotation, modifierParameters.extraParameter))
                        end
                    end
                    if modifierParameters.extraSymbol then
                        insert(result.rawPositionalParams, self.ovaleAst:newVariable(annotation.astAnnotation, modifierParameters.extraSymbol))
                        annotation:addSymbol(modifierParameters.extraSymbol)
                    end
                elseif info.symbol ~= nil then
                    if info.symbol ~= "" then
                        modifier = modifier .. "_" .. info.symbol
                    end
                    modifier = self:disambiguate(annotation, modifier, annotation.classId, annotation.specialization)
                    self:addSymbol(annotation, modifier)
                    insert(result.rawPositionalParams, self.ovaleAst:newVariable(annotation.astAnnotation, modifier))
                else
                    self.tracer:warning("Modifier parameters not found for " .. modifier .. " in " .. result.name)
                    self.ovaleAst:release(result)
                    return nil
                end
                modifier = tokenIterator()
            end
            return result
        end
        return nil
    end,
    emitCyclingVariable = function(self, nodeList, annotation, modifiers, parseNode, action, conditionNode)
        local op = (modifiers.op and self.unparser:unparse(modifiers.op)) or "min"
        if  not modifiers.name then
            self.tracer:error("Modifier name is missing in %s", action)
            return 
        end
        local name = self.unparser:unparse(modifiers.name)
        if  not name then
            self.tracer:error("Unable to parse name of variable in %s", modifiers.name)
            return 
        end
        if op == "min" or op == "max" then
            self.emitVariableAdd(name, nodeList, annotation, modifiers, parseNode, action)
        else
            self.tracer:error("Unknown cycling_variable operator " .. op)
        end
    end,
    isDaemon = function(self, name)
        return (name == "vilefiend" or name == "wild_imps" or name == "tyrant")
    end,
})
