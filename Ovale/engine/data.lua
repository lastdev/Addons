local __exports = LibStub:NewLibrary("ovale/engine/data", 90113)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.__toolstools = LibStub:GetLibrary("ovale/tools/tools")
__imports.isNumber = __imports.__toolstools.isNumber
__imports.oneTimeMessage = __imports.__toolstools.oneTimeMessage
local type = type
local ipairs = ipairs
local pairs = pairs
local wipe = wipe
local find = string.find
local isNumber = __imports.isNumber
local oneTimeMessage = __imports.oneTimeMessage
local GetSpellInfo = GetSpellInfo
local concat = table.concat
local insert = table.insert
local bloodelfClasses = {
    ["DEATHKNIGHT"] = true,
    ["DEMONHUNTER"] = true,
    ["DRUID"] = false,
    ["HUNTER"] = true,
    ["MAGE"] = true,
    ["MONK"] = true,
    ["PALADIN"] = true,
    ["PRIEST"] = true,
    ["ROGUE"] = true,
    ["SHAMAN"] = false,
    ["WARLOCK"] = true,
    ["WARRIOR"] = true
}
local pandarenClasses = {
    ["DEATHKNIGHT"] = false,
    ["DEMONHUNTER"] = false,
    ["DRUID"] = false,
    ["HUNTER"] = true,
    ["MAGE"] = true,
    ["MONK"] = true,
    ["PALADIN"] = false,
    ["PRIEST"] = true,
    ["ROGUE"] = true,
    ["SHAMAN"] = true,
    ["WARLOCK"] = false,
    ["WARRIOR"] = true
}
local taurenClasses = {
    ["DEATHKNIGHT"] = true,
    ["DEMONHUNTER"] = false,
    ["DRUID"] = true,
    ["HUNTER"] = true,
    ["MAGE"] = false,
    ["MONK"] = true,
    ["PALADIN"] = true,
    ["PRIEST"] = true,
    ["ROGUE"] = false,
    ["SHAMAN"] = true,
    ["WARLOCK"] = false,
    ["WARRIOR"] = true
}
local statNames = {
    [1] = "agility",
    [2] = "bonus_armor",
    [3] = "critical_strike",
    [4] = "haste",
    [5] = "intellect",
    [6] = "mastery",
    [7] = "spirit",
    [8] = "spellpower",
    [9] = "strength",
    [10] = "versatility"
}
local startShortNames = {
    agility = "agi",
    critical_strike = "crit",
    intellect = "int",
    strength = "str",
    spirit = "spi"
}
local statUseNames = {
    [1] = "trinket_proc",
    [2] = "trinket_stacking_proc",
    [3] = "trinket_stacking_stat",
    [4] = "trinket_stat",
    [5] = "trinket_stack_proc"
}
__exports.OvaleDataClass = __class(nil, {
    constructor = function(self, runner, ovaleDebug)
        self.runner = runner
        self.statNames = statNames
        self.shortNames = startShortNames
        self.statUseNames = statUseNames
        self.bloodElfClasses = bloodelfClasses
        self.pandarenClasses = pandarenClasses
        self.taurenClasses = taurenClasses
        self.itemInfo = {}
        self.itemList = {}
        self.spellInfo = {}
        self.spellDebug = {}
        self.debugOptions = {
            data = {
                name = "Data",
                type = "group",
                args = {
                    spells = {
                        name = "Spell data",
                        type = "input",
                        multiline = 25,
                        width = "full",
                        get = function(info)
                            local array = {}
                            local properties = {}
                            for spellName, spellNameDebug in pairs(self.spellDebug) do
                                local display = false
                                for _, spellDebug in pairs(spellNameDebug) do
                                    if spellDebug.auraAsked or spellDebug.spellAsked then
                                        display = true
                                        break
                                    end
                                end
                                if display then
                                    insert(array, spellName .. ":")
                                    for spellId, spellDebug in pairs(spellNameDebug) do
                                        wipe(properties)
                                        if spellDebug.auraAsked then
                                            insert(properties, "aura asked")
                                        end
                                        if spellDebug.auraSeen then
                                            insert(properties, "aura seen")
                                        end
                                        if spellDebug.spellAsked then
                                            insert(properties, "spell asked")
                                        end
                                        if spellDebug.spellCast then
                                            insert(properties, "spell cast")
                                        end
                                        insert(array, "  " .. spellId .. ": " .. concat(properties, ", "))
                                    end
                                end
                            end
                            return concat(array, "\n")
                        end
                    }
                }
            }
        }
        self.buffSpellList = {
            attack_power_multiplier_buff = {
                [6673] = true
            },
            critical_strike_buff = {
                [1459] = true
            },
            haste_buff = {},
            mastery_buff = {},
            spell_power_multiplier_buff = {
                [1459] = true
            },
            stamina_buff = {
                [21562] = true
            },
            str_agi_int_buff = {},
            versatility_buff = {},
            bleed_debuff = {
                [113344] = true,
                [121411] = true,
                [115767] = true,
                [703] = true,
                [154953] = true,
                [155722] = true,
                [772] = true,
                [1079] = true,
                [1943] = true,
                [106830] = true,
                [324073] = true
            },
            healing_reduced_debuff = {
                [8680] = true,
                [115804] = true
            },
            stealthed_buff = {
                [102543] = true,
                [5215] = true,
                [58984] = true,
                [185422] = true,
                [1784] = true,
                [115192] = true,
                [1856] = true,
                [11327] = true,
                [115191] = true,
                [115193] = true,
                [347037] = true
            },
            rogue_stealthed_buff = {
                [1784] = true,
                [185422] = true,
                [115192] = true,
                [1856] = true,
                [11327] = true,
                [115191] = true,
                [115193] = true,
                [347037] = true
            },
            mantle_stealthed_buff = {
                [1784] = true,
                [1856] = true,
                [11327] = true,
                [115193] = true
            },
            burst_haste_buff = {
                [2825] = true,
                [309658] = true,
                [178207] = true,
                [146555] = true,
                [256740] = true,
                [230935] = true,
                [32182] = true,
                [264667] = true,
                [80353] = true
            },
            burst_haste_debuff = {
                [57723] = true,
                [57724] = true,
                [80354] = true
            },
            raid_movement_buff = {
                [106898] = true,
                [192082] = true
            },
            roll_the_bones_buff = {
                [193356] = true,
                [199600] = true,
                [193358] = true,
                [193357] = true,
                [199603] = true,
                [193359] = true
            },
            lethal_poison_buff = {
                [2823] = true,
                [315584] = true,
                [8679] = true
            },
            non_lethal_poison_buff = {
                [3408] = true,
                [5761] = true
            }
        }
        self.defaultSpellLists = {}
        for _, useName in pairs(statUseNames) do
            local name
            for _, statName in pairs(statNames) do
                name = useName .. "_" .. statName .. "_buff"
                self.buffSpellList[name] = {}
                local shortName = startShortNames[statName]
                if shortName then
                    name = useName .. "_" .. shortName .. "_buff"
                    self.buffSpellList[name] = {}
                end
            end
            name = useName .. "_any_buff"
            self.buffSpellList[name] = {}
        end
        do
            for name in pairs(self.buffSpellList) do
                self.defaultSpellLists[name] = true
            end
        end
        for k, v in pairs(self.debugOptions) do
            ovaleDebug.defaultOptions.args[k] = v
        end
    end,
    getSpellDebug = function(self, spellId)
        local spellName = GetSpellInfo(spellId)
        if  not spellName then
            spellName = "unknown"
        end
        local spellDebugName = self.spellDebug[spellName]
        if  not spellDebugName then
            spellDebugName = {}
            self.spellDebug[spellName] = spellDebugName
        end
        local spellDebug = spellDebugName[spellId]
        if  not spellDebug then
            spellDebug = {}
            spellDebugName[spellId] = spellDebug
        end
        return spellDebug
    end,
    registerSpellCast = function(self, spellId)
        self:getSpellDebug(spellId).spellCast = true
    end,
    registerAuraSeen = function(self, spellId)
        self:getSpellDebug(spellId).auraSeen = true
    end,
    registerAuraAsked = function(self, spellId)
        self:getSpellDebug(spellId).auraAsked = true
    end,
    registerSpellAsked = function(self, spellId)
        self:getSpellDebug(spellId).spellAsked = true
    end,
    reset = function(self)
        wipe(self.itemInfo)
        wipe(self.spellInfo)
        for k, v in pairs(self.buffSpellList) do
            if  not self.defaultSpellLists[k] then
                wipe(v)
                self.buffSpellList[k] = nil
            elseif find(k, "^trinket_") then
                wipe(v)
            end
        end
    end,
    getSpellInfo = function(self, spellId)
        local si = self.spellInfo[spellId]
        if  not si then
            si = {
                aura = {
                    player = {
                        HELPFUL = {},
                        HARMFUL = {}
                    },
                    target = {
                        HELPFUL = {},
                        HARMFUL = {}
                    },
                    pet = {
                        HELPFUL = {},
                        HARMFUL = {}
                    },
                    damage = {
                        HELPFUL = {},
                        HARMFUL = {}
                    }
                },
                require = {}
            }
            self.spellInfo[spellId] = si
        end
        return si
    end,
    getSpellOrListInfo = function(self, spellId)
        if type(spellId) == "number" then
            return self.spellInfo[spellId]
        elseif self.buffSpellList[spellId] then
            for auraId in pairs(self.buffSpellList[spellId]) do
                if self.spellInfo[auraId] then
                    return self.spellInfo[auraId]
                end
            end
        end
    end,
    getItemInfo = function(self, itemId)
        local ii = self.itemInfo[itemId]
        if  not ii then
            ii = {
                require = {}
            }
            self.itemInfo[itemId] = ii
        end
        return ii
    end,
    getItemTagInfo = function(self, spellId)
        return "cd", false
    end,
    getSpellTagInfo = function(self, spellId)
        local tag = "main"
        local invokesGCD = true
        local si = self.spellInfo[spellId]
        if si then
            invokesGCD =  not si.gcd or si.gcd > 0
            tag = si.tag
            if  not tag then
                local cd = si.cd
                if cd then
                    if cd > 90 then
                        tag = "cd"
                    elseif cd > 29 or  not invokesGCD then
                        tag = "shortcd"
                    end
                elseif  not invokesGCD then
                    tag = "shortcd"
                end
                si.tag = tag
            end
            tag = tag or "main"
        end
        return tag, invokesGCD
    end,
    checkSpellAuraData = function(self, auraId, spellData, atTime, guid)
        local _, named = self.runner:computeParameters(spellData, atTime)
        return named
    end,
    getItemInfoProperty = function(self, itemId, atTime, property)
        local ii = self:getItemInfo(itemId)
        if ii then
            return self:getProperty(ii, atTime, property)
        end
        return nil
    end,
    getSpellInfoProperty = function(self, spellId, atTime, property, targetGUID)
        local si = self.spellInfo[spellId]
        if si then
            return self:getProperty(si, atTime, property)
        end
        return nil
    end,
    getProperty = function(self, si, atTime, property)
        local value = si[property]
        if atTime then
            local requirements = si.require[property]
            if requirements then
                for _, requirement in ipairs(requirements) do
                    local _, named = self.runner:computeParameters(requirement, atTime)
                    if named.enabled == nil or named.enabled then
                        if named.set ~= nil then
                            value = named.set
                        end
                        if named.add ~= nil and isNumber(value) and isNumber(named.add) then
                            value = (value + named.add)
                        end
                        if named.percent ~= nil and isNumber(value) and isNumber(named.percent) then
                            value = ((value * named.percent) / 100)
                        end
                    end
                end
            end
        end
        return value
    end,
    getSpellInfoPropertyNumber = function(self, spellId, atTime, property, targetGUID, splitRatio)
        local si = self.spellInfo[spellId]
        if  not si then
            return 
        end
        local ratioParam = property .. "_percent"
        local ratio = self:getProperty(si, atTime, ratioParam)
        if ratio ~= nil then
            ratio = ratio / 100
        else
            ratio = 1
        end
        local value = self:getProperty(si, atTime, property)
        if ratio ~= 0 and value ~= nil then
            local addParam = "add_" .. property
            local addProperty = self:getProperty(si, atTime, addParam)
            if addProperty then
                value = value + addProperty
            end
        else
            value = 0
        end
        if splitRatio then
            return value, ratio
        end
        return value * ratio
    end,
    resolveSpell = function(self, spellId, atTime, targetGUID)
        local maxGuard = 20
        local guard = 0
        local nextId
        local id = spellId
        while id and guard < maxGuard do
            guard = guard + 1
            nextId = id
            id = self:getSpellInfoProperty(nextId, atTime, "replaced_by", targetGUID)
        end
        if guard >= maxGuard then
            oneTimeMessage("Recursive 'replaced_by' chain for spell ID '" .. spellId .. "'.")
        end
        return nextId
    end,
    getDamage = function(self, spellId, attackpower, spellpower, mainHandWeaponDPS, offHandWeaponDPS, combopoints)
        local si = self.spellInfo[spellId]
        if  not si then
            return nil
        end
        local damage = si.base or 0
        attackpower = attackpower or 0
        spellpower = spellpower or 0
        mainHandWeaponDPS = mainHandWeaponDPS or 0
        offHandWeaponDPS = offHandWeaponDPS or 0
        combopoints = combopoints or 0
        if si.bonusmainhand then
            damage = damage + si.bonusmainhand * mainHandWeaponDPS
        end
        if si.bonusoffhand then
            damage = damage + si.bonusoffhand * offHandWeaponDPS
        end
        if si.bonuscp then
            damage = damage + si.bonuscp * combopoints
        end
        if si.bonusap then
            damage = damage + si.bonusap * attackpower
        end
        if si.bonusapcp then
            damage = damage + si.bonusapcp * attackpower * combopoints
        end
        if si.bonussp then
            damage = damage + si.bonussp * spellpower
        end
        return damage
    end,
})
