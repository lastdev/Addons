local __exports = LibStub:NewLibrary("ovale/simulationcraft/generator", 90048)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __engineast = LibStub:GetLibrary("ovale/engine/ast")
local isAstNodeWithChildren = __engineast.isAstNodeWithChildren
local type = type
local ipairs = ipairs
local wipe = wipe
local tonumber = tonumber
local pairs = pairs
local next = next
local remove = table.remove
local insert = table.insert
local sort = table.sort
local concat = table.concat
local __definitions = LibStub:GetLibrary("ovale/simulationcraft/definitions")
local optionalSkills = __definitions.optionalSkills
local __texttools = LibStub:GetLibrary("ovale/simulationcraft/text-tools")
local toLowerSpecialization = __texttools.toLowerSpecialization
local toOvaleFunctionName = __texttools.toOvaleFunctionName
local toOvaleTaggedFunctionName = __texttools.toOvaleTaggedFunctionName
local outputPool = __texttools.outputPool
local format = string.format
local maxDesiredTargets = 3
local definedFunctions = {}
local usedFunctions = {}
local function isNode(n)
    return type(n) == "table"
end
local function preOrderTraversalMark(node)
    if node.type == "custom_function" then
        usedFunctions[node.name] = true
    else
        if node.type == "add_function" then
            definedFunctions[node.name] = true
        end
        if isAstNodeWithChildren(node) then
            for _, childNode in ipairs(node.child) do
                preOrderTraversalMark(childNode)
            end
        end
    end
end
__exports.markNode = function(node)
    wipe(definedFunctions)
    wipe(usedFunctions)
    preOrderTraversalMark(node)
end
local function sweepComments(childNodes, index)
    local count = 0
    for k = index - 1, 1, -1 do
        if childNodes[k].type == "comment" then
            remove(childNodes, k)
            count = count + 1
        else
            break
        end
    end
    return count
end
__exports.sweepNode = function(node)
    local isChanged
    local isSwept
    isChanged, isSwept = false, false
    if node.type == "custom_function" and  not definedFunctions[node.name] then
        isChanged, isSwept = true, true
    elseif node.type == "group" or node.type == "script" then
        local child = node.child
        local index = #child
        while index > 0 do
            local childNode = child[index]
            local changed, swept = __exports.sweepNode(childNode)
            if isNode(swept) then
                if swept.type == "group" then
                    remove(child, index)
                    for k = #swept.child, 1, -1 do
                        insert(child, index, swept.child[k])
                    end
                    if node.type == "group" then
                        local count = sweepComments(child, index)
                        index = index - count
                    end
                else
                    child[index] = swept
                end
            elseif swept then
                remove(child, index)
                if node.type == "group" then
                    local count = sweepComments(child, index)
                    index = index - count
                end
            end
            isChanged = isChanged or changed or  not  not swept
            index = index - 1
        end
        if node.type == "group" or node.type == "script" then
            local childNode = child[1]
            while childNode and childNode.type == "comment" and ( not childNode.comment or childNode.comment == "") do
                isChanged = true
                remove(child, 1)
                childNode = child[1]
            end
        end
        isSwept = isSwept or #child == 0
        isChanged = isChanged or  not  not isSwept
    elseif node.type == "icon" then
        isChanged, isSwept = __exports.sweepNode(node.child[1])
    elseif node.type == "if" then
        isChanged, isSwept = __exports.sweepNode(node.child[2])
    elseif node.type == "logical" then
        if node.expressionType == "binary" then
            local lhsNode, rhsNode = node.child[1], node.child[2]
            for index, childNode in ipairs(node.child) do
                local changed, swept = __exports.sweepNode(childNode)
                if isNode(swept) then
                    node.child[index] = swept
                elseif swept then
                    if node.operator == "or" then
                        isSwept = (childNode == lhsNode and rhsNode) or lhsNode
                    else
                        isSwept = isSwept or swept
                    end
                    break
                end
                if changed then
                    isChanged = isChanged or changed
                    break
                end
            end
            isChanged = isChanged or  not  not isSwept
        end
    elseif node.type == "unless" then
        local changed, swept = __exports.sweepNode(node.child[2])
        if isNode(swept) then
            node.child[2] = swept
            isSwept = false
        elseif swept then
            isSwept = swept
        else
            changed, swept = __exports.sweepNode(node.child[1])
            if isNode(swept) then
                node.child[1] = swept
                isSwept = false
            elseif swept then
                isSwept = node.child[2]
            end
        end
        isChanged = isChanged or changed or  not  not isSwept
    elseif node.type == "simc_wait" then
        isChanged, isSwept = __exports.sweepNode(node.child[1])
    end
    return isChanged, isSwept
end
__exports.Generator = __class(nil, {
    constructor = function(self, ovaleAst, ovaleData)
        self.ovaleAst = ovaleAst
        self.ovaleData = ovaleData
    end,
    insertInterruptFunction = function(self, child, annotation, interrupts)
        local nodeList = annotation.astAnnotation.nodeList
        local camelSpecialization = toLowerSpecialization(annotation)
        local spells = interrupts or {}
        sort(spells, function(a, b)
            return tonumber(a.order or 0) >= tonumber(b.order or 0)
        end
)
        local lines = {}
        for _, spell in pairs(spells) do
            annotation:addSymbol(spell.name)
            if spell.addSymbol ~= nil then
                for _, v in pairs(spell.addSymbol) do
                    annotation:addSymbol(v)
                end
            end
            local conditions = {}
            if spell.range == nil then
                insert(conditions, format("target.InRange(%s)", spell.name))
            elseif spell.range ~= "" then
                insert(conditions, spell.range)
            end
            if spell.interrupt == 1 then
                insert(conditions, "target.IsInterruptible()")
            end
            if spell.worksOnBoss == 0 or spell.worksOnBoss == nil then
                insert(conditions, "not target.Classification(worldboss)")
            end
            if spell.extraCondition ~= nil then
                insert(conditions, spell.extraCondition)
            end
            local line = ""
            if #conditions > 0 then
                line = line .. "if " .. concat(conditions, " and ") .. " "
            end
            line = line .. format("Spell(%s)", spell.name)
            insert(lines, line)
        end
        local fmt = [[
            AddFunction %sInterruptActions
            {
                if CheckBoxOn(opt_interrupt) and not target.IsFriend() and target.Casting()
                {
                    %s
                }
            }
        ]]
        local code = format(fmt, camelSpecialization, concat(lines, "\n"))
        local node = self.ovaleAst:parseCode("add_function", code, nodeList, annotation.astAnnotation)
        if node and node.type == "add_function" then
            insert(child, 1, node)
            annotation.functionTag[node.name] = "cd"
        end
    end,
    insertInterruptFunctions = function(self, child, annotation)
        local interrupts = {}
        local className = annotation.classId
        if self.ovaleData.pandarenClasses[className] then
            insert(interrupts, {
                name = "quaking_palm",
                stun = 1,
                order = 98
            })
        end
        if self.ovaleData.taurenClasses[className] then
            insert(interrupts, {
                name = "war_stomp",
                stun = 1,
                order = 99,
                range = "target.Distance() < 5"
            })
        end
        if annotation.mind_freeze == "DEATHKNIGHT" then
            insert(interrupts, {
                name = "mind_freeze",
                interrupt = 1,
                worksOnBoss = 1,
                order = 10
            })
            if annotation.specialization == "blood" or annotation.specialization == "unholy" then
                insert(interrupts, {
                    name = "asphyxiate",
                    stun = 1,
                    order = 20
                })
            end
            if annotation.specialization == "frost" then
                insert(interrupts, {
                    name = "blinding_sleet",
                    disorient = 1,
                    range = "target.Distance() < 12",
                    order = 20
                })
            end
        end
        if annotation.disrupt == "DEMONHUNTER" then
            insert(interrupts, {
                name = "disrupt",
                interrupt = 1,
                worksOnBoss = 1,
                order = 10
            })
            insert(interrupts, {
                name = "imprison",
                cc = 1,
                extraCondition = "target.CreatureType(Demon Humanoid Beast)",
                order = 999
            })
            if annotation.specialization == "havoc" then
                insert(interrupts, {
                    name = "chaos_nova",
                    stun = 1,
                    range = "target.Distance() < 8",
                    order = 100
                })
                insert(interrupts, {
                    name = "fel_eruption",
                    stun = 1,
                    order = 20
                })
            end
            if annotation.specialization == "vengeance" then
                insert(interrupts, {
                    name = "sigil_of_silence",
                    interrupt = 1,
                    order = 110,
                    range = "",
                    extraCondition = "not SigilCharging(silence misery chains) and (target.RemainingCastTime() >= (2 - Talent(quickened_sigils_talent) + GCDRemaining()))"
                })
                insert(interrupts, {
                    name = "sigil_of_misery",
                    disorient = 1,
                    order = 120,
                    range = "",
                    extraCondition = "not SigilCharging(silence misery chains) and (target.RemainingCastTime() >= (2 - Talent(quickened_sigils_talent) + GCDRemaining()))"
                })
                insert(interrupts, {
                    name = "sigil_of_chains",
                    pull = 1,
                    order = 130,
                    range = "",
                    extraCondition = "not SigilCharging(silence misery chains) and (target.RemainingCastTime() >= (2 - Talent(quickened_sigils_talent) + GCDRemaining()))"
                })
            end
        end
        if annotation.skull_bash == "DRUID" or annotation.solar_beam == "DRUID" then
            if annotation.specialization == "guardian" or annotation.specialization == "feral" then
                insert(interrupts, {
                    name = "skull_bash",
                    interrupt = 1,
                    worksOnBoss = 1,
                    order = 10
                })
            end
            if annotation.specialization == "balance" then
                insert(interrupts, {
                    name = "solar_beam",
                    interrupt = 1,
                    worksOnBoss = 1,
                    order = 10
                })
            end
            insert(interrupts, {
                name = "mighty_bash",
                stun = 1,
                order = 20
            })
            if annotation.specialization == "guardian" then
                insert(interrupts, {
                    name = "incapacitating_roar",
                    incapacitate = 1,
                    order = 30,
                    range = "target.Distance() < 10"
                })
            end
            insert(interrupts, {
                name = "typhoon",
                knockback = 1,
                order = 110,
                range = "target.Distance() < 15"
            })
            if annotation.specialization == "feral" then
                insert(interrupts, {
                    name = "maim",
                    stun = 1,
                    order = 40
                })
            end
        end
        if annotation.counter_shot == "HUNTER" then
            insert(interrupts, {
                name = "counter_shot",
                interrupt = 1,
                worksOnBoss = 1,
                order = 10
            })
        end
        if annotation.muzzle == "HUNTER" then
            insert(interrupts, {
                name = "muzzle",
                interrupt = 1,
                worksOnBoss = 1,
                order = 10
            })
        end
        if annotation.counterspell == "MAGE" then
            insert(interrupts, {
                name = "counterspell",
                interrupt = 1,
                worksOnBoss = 1,
                order = 10
            })
        end
        if annotation.spear_hand_strike == "MONK" then
            insert(interrupts, {
                name = "spear_hand_strike",
                interrupt = 1,
                worksOnBoss = 1,
                order = 10
            })
            insert(interrupts, {
                name = "paralysis",
                cc = 1,
                order = 999
            })
            insert(interrupts, {
                name = "leg_sweep",
                stun = 1,
                order = 30,
                range = "target.Distance() < 5"
            })
        end
        if annotation.rebuke == "PALADIN" then
            insert(interrupts, {
                name = "rebuke",
                interrupt = 1,
                worksOnBoss = 1,
                order = 10
            })
            insert(interrupts, {
                name = "hammer_of_justice",
                stun = 1,
                order = 20
            })
            if annotation.specialization == "protection" then
                insert(interrupts, {
                    name = "avengers_shield",
                    interrupt = 1,
                    worksOnBoss = 1,
                    order = 15
                })
                insert(interrupts, {
                    name = "blinding_light",
                    disorient = 1,
                    order = 50,
                    range = "target.Distance() < 10"
                })
            end
        end
        if annotation.silence == "PRIEST" then
            insert(interrupts, {
                name = "silence",
                interrupt = 1,
                worksOnBoss = 1,
                order = 10
            })
            insert(interrupts, {
                name = "mind_bomb",
                stun = 1,
                order = 30,
                extraCondition = "target.RemainingCastTime() > 2"
            })
        end
        if annotation.kick == "ROGUE" then
            insert(interrupts, {
                name = "kick",
                interrupt = 1,
                worksOnBoss = 1,
                order = 10
            })
            insert(interrupts, {
                name = "cheap_shot",
                stun = 1,
                order = 20
            })
            if annotation.specialization == "outlaw" then
                insert(interrupts, {
                    name = "gouge",
                    incapacitate = 1,
                    order = 100
                })
            end
            insert(interrupts, {
                name = "kidney_shot",
                stun = 1,
                order = 30
            })
        end
        if annotation.wind_shear == "SHAMAN" then
            insert(interrupts, {
                name = "wind_shear",
                interrupt = 1,
                worksOnBoss = 1,
                order = 10
            })
            if annotation.specialization == "enhancement" then
                insert(interrupts, {
                    name = "sundering",
                    knockback = 1,
                    order = 20,
                    range = "target.Distance() < 5"
                })
            end
            insert(interrupts, {
                name = "capacitor_totem",
                stun = 1,
                order = 30,
                range = "",
                extraCondition = "target.RemainingCastTime() > 2"
            })
            insert(interrupts, {
                name = "hex",
                cc = 1,
                order = 100,
                extraCondition = "target.RemainingCastTime() > CastTime(hex) + GCDRemaining() and target.CreatureType(Humanoid Beast)"
            })
        end
        if annotation.pummel == "WARRIOR" then
            insert(interrupts, {
                name = "pummel",
                interrupt = 1,
                worksOnBoss = 1,
                order = 10
            })
            insert(interrupts, {
                name = "shockwave",
                stun = 1,
                worksOnBoss = 0,
                order = 20,
                range = "target.Distance() < 10"
            })
            insert(interrupts, {
                name = "storm_bolt",
                stun = 1,
                worksOnBoss = 0,
                order = 20
            })
            insert(interrupts, {
                name = "intimidating_shout",
                incapacitate = 1,
                worksOnBoss = 0,
                order = 100
            })
        end
        if #interrupts > 0 then
            self:insertInterruptFunction(child, annotation, interrupts)
        end
        return #interrupts
    end,
    insertSupportingFunctions = function(self, child, annotation)
        local count = 0
        local nodeList = annotation.astAnnotation.nodeList
        local camelSpecialization = toLowerSpecialization(annotation)
        local lowerSpecialization = toLowerSpecialization(annotation)
        if annotation.desired_targets then
            local lines = {}
            for k = maxDesiredTargets, 1, -1 do
                insert(lines, "if List(opt_" .. lowerSpecialization .. "_desired_targets desired_targets_" .. k .. ") " .. k)
            end
            insert(lines, "1")
            local fmt = [[
                AddFunction %sDesiredTargets
                {
                    %s
                }
            ]]
            local code = format(fmt, camelSpecialization, concat(lines, "\n"))
            local node = self.ovaleAst:parseCode("add_function", code, nodeList, annotation.astAnnotation)
            if node then
                insert(child, 1, node)
                count = count + 1
            end
        end
        if annotation.melee == "DEATHKNIGHT" then
            local fmt = [[
                AddFunction %sGetInMeleeRange
                {
                    if CheckBoxOn(opt_melee_range) and not target.InRange(death_strike) Texture(misc_arrowlup help=L(not_in_melee_range))
                }
            ]]
            local code = format(fmt, camelSpecialization)
            local node = self.ovaleAst:parseCode("add_function", code, nodeList, annotation.astAnnotation)
            if node and node.type == "add_function" then
                insert(child, 1, node)
                annotation.functionTag[node.name] = "shortcd"
                annotation:addSymbol("death_strike")
                count = count + 1
            end
        end
        if annotation.melee == "DEMONHUNTER" and annotation.specialization == "havoc" then
            local fmt = [[
                AddFunction %sGetInMeleeRange
                {
                    if CheckBoxOn(opt_melee_range) and not target.InRange(chaos_strike) 
                    {
                        if target.InRange(felblade) Spell(felblade)
                        Texture(misc_arrowlup help=L(not_in_melee_range))
                    }
                }
            ]]
            local code = format(fmt, camelSpecialization)
            local node = self.ovaleAst:parseCode("add_function", code, nodeList, annotation.astAnnotation)
            if node and node.type == "add_function" then
                insert(child, 1, node)
                annotation.functionTag[node.name] = "shortcd"
                annotation:addSymbol("chaos_strike")
                count = count + 1
            end
        end
        if annotation.melee == "DEMONHUNTER" and annotation.specialization == "vengeance" then
            local fmt = [[
                AddFunction %sGetInMeleeRange
                {
                    if CheckBoxOn(opt_melee_range) and not target.InRange(shear) Texture(misc_arrowlup help=L(not_in_melee_range))
                }
            ]]
            local code = format(fmt, camelSpecialization)
            local node = self.ovaleAst:parseCode("add_function", code, nodeList, annotation.astAnnotation)
            if node and node.type == "add_function" then
                insert(child, 1, node)
                annotation.functionTag[node.name] = "shortcd"
                annotation:addSymbol("shear")
                count = count + 1
            end
        end
        if annotation.melee == "DRUID" then
            local fmt = [[
                AddFunction %sGetInMeleeRange
                {
                    if CheckBoxOn(opt_melee_range)
                    {
                        if Stance(druid_bear_form) and not target.InRange(mangle)
                        {
                            if target.InRange(wild_charge_bear) Spell(wild_charge_bear)
                            Texture(misc_arrowlup help=L(not_in_melee_range))
                        }
                        if (Stance(druid_cat_form) or Stance(druid_claws_of_shirvallah)) and not target.InRange(shred)
                        {
                            if target.InRange(wild_charge_cat) Spell(wild_charge_cat)
                            Texture(misc_arrowlup help=L(not_in_melee_range))
                        }
                    }
                }
            ]]
            local code = format(fmt, camelSpecialization)
            local node = self.ovaleAst:parseCode("add_function", code, nodeList, annotation.astAnnotation)
            if node and node.type == "add_function" then
                insert(child, 1, node)
                annotation.functionTag[node.name] = "shortcd"
                annotation:addSymbol("mangle")
                annotation:addSymbol("shred")
                annotation:addSymbol("wild_charge_bear")
                annotation:addSymbol("wild_charge_cat")
                count = count + 1
            end
        end
        if annotation.melee == "HUNTER" then
            local fmt = [[
                AddFunction %sGetInMeleeRange
                {
                    if CheckBoxOn(opt_melee_range) and not target.InRange(raptor_strike)
                    {
                        Texture(misc_arrowlup help=L(not_in_melee_range))
                    }
                }
            ]]
            local code = format(fmt, camelSpecialization)
            local node = self.ovaleAst:parseCode("add_function", code, nodeList, annotation.astAnnotation)
            if node and node.type == "add_function" then
                insert(child, 1, node)
                annotation.functionTag[node.name] = "shortcd"
                annotation:addSymbol("raptor_strike")
                count = count + 1
            end
        end
        if annotation.summon_pet == "HUNTER" then
            local fmt
            fmt = [[
                AddFunction %sSummonPet
                {
                    if not pet.Present() and not pet.IsDead() and not PreviousSpell(revive_pet) Texture(ability_hunter_beastcall help=L(summon_pet))
                }
            ]]
            local code = format(fmt, camelSpecialization)
            local node = self.ovaleAst:parseCode("add_function", code, nodeList, annotation.astAnnotation)
            if node and node.type == "add_function" then
                insert(child, 1, node)
                annotation.functionTag[node.name] = "shortcd"
                annotation:addSymbol("revive_pet")
                count = count + 1
            end
        end
        if annotation.melee == "MONK" then
            local fmt = [[
                AddFunction %sGetInMeleeRange
                {
                    if CheckBoxOn(opt_melee_range) and not target.InRange(tiger_palm) Texture(misc_arrowlup help=L(not_in_melee_range))
                }
            ]]
            local code = format(fmt, camelSpecialization)
            local node = self.ovaleAst:parseCode("add_function", code, nodeList, annotation.astAnnotation)
            if node and node.type == "add_function" then
                insert(child, 1, node)
                annotation.functionTag[node.name] = "shortcd"
                annotation:addSymbol("tiger_palm")
                count = count + 1
            end
        end
        if annotation.time_to_hpg_heal == "PALADIN" then
            local code = [[
                AddFunction HolyTimeToHPG
                {
                    SpellCooldown(crusader_strike holy_shock judgment)
                }
            ]]
            local node = self.ovaleAst:parseCode("add_function", code, nodeList, annotation.astAnnotation)
            if node then
                insert(child, 1, node)
                annotation:addSymbol("crusader_strike")
                annotation:addSymbol("holy_shock")
                annotation:addSymbol("judgment")
                count = count + 1
            end
        end
        if annotation.time_to_hpg_melee == "PALADIN" then
            local code = [[
                AddFunction RetributionTimeToHPG
                {
                    SpellCooldown(crusader_strike hammer_of_wrath judgment usable=1)
                }
            ]]
            local node = self.ovaleAst:parseCode("add_function", code, nodeList, annotation.astAnnotation)
            if node then
                insert(child, 1, node)
                annotation:addSymbol("crusader_strike")
                annotation:addSymbol("hammer_of_wrath")
                annotation:addSymbol("judgment")
                count = count + 1
            end
        end
        if annotation.time_to_hpg_tank == "PALADIN" then
            local code = [[
                AddFunction ProtectionTimeToHPG
                {
                    if Talent(sanctified_wrath_talent) SpellCooldown(crusader_strike holy_wrath judgment)
                    if not Talent(sanctified_wrath_talent) SpellCooldown(crusader_strike judgment)
                }
            ]]
            local node = self.ovaleAst:parseCode("add_function", code, nodeList, annotation.astAnnotation)
            insert(child, 1, node)
            annotation:addSymbol("crusader_strike")
            annotation:addSymbol("holy_wrath")
            annotation:addSymbol("judgment")
            annotation:addSymbol("sanctified_wrath_talent")
            count = count + 1
        end
        if annotation.melee == "PALADIN" then
            local fmt = [[
                AddFunction %sGetInMeleeRange
                {
                    if CheckBoxOn(opt_melee_range) and not target.InRange(rebuke) Texture(misc_arrowlup help=L(not_in_melee_range))
                }
            ]]
            local code = format(fmt, camelSpecialization)
            local node = self.ovaleAst:parseCode("add_function", code, nodeList, annotation.astAnnotation)
            if node and node.type == "add_function" then
                insert(child, 1, node)
                annotation.functionTag[node.name] = "shortcd"
                annotation:addSymbol("rebuke")
                count = count + 1
            end
        end
        if annotation.melee == "ROGUE" then
            local fmt = [[
                AddFunction %sGetInMeleeRange
                {
                    if CheckBoxOn(opt_melee_range) and not target.InRange(kick)
                    {
                        Spell(shadowstep)
                        Texture(misc_arrowlup help=L(not_in_melee_range))
                    }
                }
            ]]
            local code = format(fmt, camelSpecialization)
            local node = self.ovaleAst:parseCode("add_function", code, nodeList, annotation.astAnnotation)
            if node and node.type == "add_function" then
                insert(child, 1, node)
                annotation.functionTag[node.name] = "shortcd"
                annotation:addSymbol("kick")
                annotation:addSymbol("shadowstep")
                count = count + 1
            end
        end
        if annotation.melee == "SHAMAN" then
            local fmt = [[
                AddFunction %sGetInMeleeRange
                {
                    if CheckBoxOn(opt_melee_range) and not target.InRange(stormstrike) 
                    {
                        if target.InRange(feral_lunge) Spell(feral_lunge)
                        Texture(misc_arrowlup help=L(not_in_melee_range))
                    }
                }
            ]]
            local code = format(fmt, camelSpecialization)
            local node = self.ovaleAst:parseCode("add_function", code, nodeList, annotation.astAnnotation)
            if node and node.type == "add_function" then
                insert(child, 1, node)
                annotation.functionTag[node.name] = "shortcd"
                annotation:addSymbol("feral_lunge")
                annotation:addSymbol("stormstrike")
                count = count + 1
            end
        end
        if annotation.bloodlust == "SHAMAN" then
            local fmt = [[
                AddFunction %sBloodlust
                {
                    if CheckBoxOn(opt_bloodlust) and DebuffExpires(burst_haste_debuff any=1)
                    {
                        Spell(bloodlust)
                        Spell(heroism)
                    }
                }
            ]]
            local code = format(fmt, camelSpecialization)
            local node = self.ovaleAst:parseCode("add_function", code, nodeList, annotation.astAnnotation)
            if node and node.type == "add_function" then
                insert(child, 1, node)
                annotation.functionTag[node.name] = "cd"
                annotation:addSymbol("bloodlust")
                annotation:addSymbol("heroism")
                count = count + 1
            end
        end
        if annotation.melee == "WARRIOR" then
            local fmt = [[
                AddFunction %sGetInMeleeRange
                {
                    if CheckBoxOn(opt_melee_range) and not InFlightToTarget(%s) and not InFlightToTarget(heroic_leap) and not target.InRange(pummel)
                    {
                        if target.InRange(%s) Spell(%s)
                        if SpellCharges(%s) == 0 and target.Distance() >= 8 and target.Distance() <= 40 Spell(heroic_leap)
                        Texture(misc_arrowlup help=L(not_in_melee_range))
                    }
                }
            ]]
            local charge = "charge"
            if annotation.specialization == "protection" then
                charge = "intercept"
            end
            local code = format(fmt, camelSpecialization, charge, charge, charge, charge)
            local node = self.ovaleAst:parseCode("add_function", code, nodeList, annotation.astAnnotation)
            if node and node.type == "add_function" then
                insert(child, 1, node)
                annotation.functionTag[node.name] = "shortcd"
                annotation:addSymbol(charge)
                annotation:addSymbol("heroic_leap")
                annotation:addSymbol("pummel")
                count = count + 1
            end
        end
        if annotation.use_item then
            local fmt = [[
                AddFunction %sUseItemActions
                {
                    Item(Trinket0Slot usable=1 text=13)
                    Item(Trinket1Slot usable=1 text=14)
                }
            ]]
            local code = format(fmt, camelSpecialization)
            local node = self.ovaleAst:parseCode("add_function", code, nodeList, annotation.astAnnotation)
            if node and node.type == "add_function" then
                insert(child, 1, node)
                annotation.functionTag[node.name] = "cd"
                count = count + 1
            end
        end
        return count
    end,
    addOptionalSkillCheckBox = function(self, child, annotation, data, skill)
        local nodeList = annotation.astAnnotation.nodeList
        if data.class ~= annotation[skill] then
            return 0
        end
        local defaultText
        if data.default then
            defaultText = " default"
        else
            defaultText = ""
        end
        local fmt = [[
            AddCheckBox(opt_%s SpellName(%s)%s enabled=(specialization(%s)))
        ]]
        local code = format(fmt, skill, skill, defaultText, annotation.specialization)
        local node = self.ovaleAst:parseCode("checkbox", code, nodeList, annotation.astAnnotation)
        insert(child, 1, node)
        annotation:addSymbol(skill)
        return 1
    end,
    insertSupportingControls = function(self, child, annotation)
        local count = 0
        for skill, data in pairs(optionalSkills) do
            count = count + self:addOptionalSkillCheckBox(child, annotation, data, skill)
        end
        local nodeList = annotation.astAnnotation.nodeList
        local lowerSpecialization = toLowerSpecialization(annotation)
        local ifSpecialization = "enabled=(specialization(" .. annotation.specialization .. "))"
        if annotation.using_apl and next(annotation.using_apl) then
            for name in pairs(annotation.using_apl) do
                if name ~= "normal" then
                    local fmt = [[
                        AddListItem(opt_using_apl %s "%s APL")
                    ]]
                    local code = format(fmt, name, name)
                    local node = self.ovaleAst:parseCode("list_item", code, nodeList, annotation.astAnnotation)
                    insert(child, 1, node)
                end
            end
            do
                local code = [[
                    AddListItem(opt_using_apl normal L(normal_apl) default)
                ]]
                local node = self.ovaleAst:parseCode("list_item", code, nodeList, annotation.astAnnotation)
                insert(child, 1, node)
            end
        end
        if annotation.desired_targets then
            for k = maxDesiredTargets, 0, -1 do
                local fmt = "AddListItem(%s %s %s %s%s)"
                local code = format(fmt, "opt_" .. lowerSpecialization .. "_desired_targets", "desired_targets_" .. k, "\"Desired targets: " .. k .. "\"", (k == 1 and "default ") or "", ifSpecialization)
                local node = self.ovaleAst:parseCode("list_item", code, nodeList, annotation.astAnnotation)
                insert(child, 1, node)
                count = count + 1
            end
        end
        if annotation.options then
            for v in pairs(annotation.options) do
                local fmt = "\n                    AddCheckBox(" .. v .. " L(" .. v .. ") default %s)\n                "
                local code = format(fmt, ifSpecialization)
                local node = self.ovaleAst:parseCode("checkbox", code, nodeList, annotation.astAnnotation)
                insert(child, 1, node)
                count = count + 1
            end
        end
        if annotation.use_legendary_ring then
            local legendaryRing = annotation.use_legendary_ring
            local fmt = [[
                AddCheckBox(opt_%s ItemName(%s) default %s)
            ]]
            local code = format(fmt, legendaryRing, legendaryRing, ifSpecialization)
            local node = self.ovaleAst:parseCode("checkbox", code, nodeList, annotation.astAnnotation)
            insert(child, 1, node)
            annotation:addSymbol(legendaryRing)
            count = count + 1
        end
        if annotation.opt_use_consumables then
            local fmt = [[
                AddCheckBox(opt_use_consumables L(opt_use_consumables) default %s)
            ]]
            local code = format(fmt, ifSpecialization)
            local node = self.ovaleAst:parseCode("checkbox", code, nodeList, annotation.astAnnotation)
            insert(child, 1, node)
            count = count + 1
        end
        if annotation.melee then
            local fmt = [[
                AddCheckBox(opt_melee_range L(not_in_melee_range) %s)
            ]]
            local code = format(fmt, ifSpecialization)
            local node = self.ovaleAst:parseCode("checkbox", code, nodeList, annotation.astAnnotation)
            insert(child, 1, node)
            count = count + 1
        end
        if annotation.interrupt then
            local fmt = [[
                AddCheckBox(opt_interrupt L(interrupt) default %s)
            ]]
            local code = format(fmt, ifSpecialization)
            local node = self.ovaleAst:parseCode("checkbox", code, nodeList, annotation.astAnnotation)
            insert(child, 1, node)
            count = count + 1
        end
        if annotation.opt_priority_rotation then
            local fmt = [[
                AddCheckBox(opt_priority_rotation L(opt_priority_rotation) default %s)
            ]]
            local code = format(fmt, ifSpecialization)
            local node = self.ovaleAst:parseCode("checkbox", code, nodeList, annotation.astAnnotation)
            insert(child, 1, node)
            count = count + 1
        end
        return count
    end,
    insertVariables = function(self, child, annotation)
        for _, v in pairs(annotation.variable) do
            insert(child, 1, v)
        end
    end,
    generateIconBody = function(self, tag, profile)
        local annotation = profile.annotation
        local precombatName = toOvaleFunctionName("precombat", annotation)
        local defaultName = toOvaleFunctionName("_default", annotation)
        local precombatBodyName = toOvaleTaggedFunctionName(precombatName, tag)
        local defaultBodyName = toOvaleTaggedFunctionName(defaultName, tag)
        local mainBodyCode
        if annotation.using_apl and next(annotation.using_apl) then
            local output = outputPool:get()
            output[#output + 1] = format("if List(opt_using_apl normal) %s()", defaultBodyName)
            for name in pairs(annotation.using_apl) do
                local aplName = toOvaleFunctionName(name, annotation)
                local aplBodyName = toOvaleTaggedFunctionName(aplName, tag)
                output[#output + 1] = format("if List(opt_using_apl %s) %s()", name, aplBodyName)
            end
            mainBodyCode = concat(output, "\n")
            outputPool:release(output)
        else
            mainBodyCode = defaultBodyName .. "()"
        end
        local code
        if profile["actions.precombat"] then
            local fmt = [[
                if not InCombat() %s()
                %s
            ]]
            code = format(fmt, precombatBodyName, mainBodyCode)
        else
            code = mainBodyCode
        end
        return code
    end,
})
