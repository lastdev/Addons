local __exports = LibStub:NewLibrary("ovale/states/PaperDoll", 90107)
if not __exports then return end
local __class = LibStub:GetLibrary("tslib").newClass
local __imports = {}
__imports.__enginestate = LibStub:GetLibrary("ovale/engine/state")
__imports.States = __imports.__enginestate.States
__imports.aceEvent = LibStub:GetLibrary("AceEvent-3.0", true)
__imports.__toolstools = LibStub:GetLibrary("ovale/tools/tools")
__imports.isNumber = __imports.__toolstools.isNumber
__imports.__enginecondition = LibStub:GetLibrary("ovale/engine/condition")
__imports.returnBoolean = __imports.__enginecondition.returnBoolean
local States = __imports.States
local aceEvent = __imports.aceEvent
local tonumber = tonumber
local ipairs = ipairs
local unpack = unpack
local GetCombatRating = GetCombatRating
local GetCombatRatingBonus = GetCombatRatingBonus
local GetCritChance = GetCritChance
local GetMastery = GetMastery
local GetMasteryEffect = GetMasteryEffect
local GetHaste = GetHaste
local GetMeleeHaste = GetMeleeHaste
local GetRangedCritChance = GetRangedCritChance
local GetRangedHaste = GetRangedHaste
local GetSpecialization = GetSpecialization
local GetSpellBonusDamage = GetSpellBonusDamage
local GetSpellCritChance = GetSpellCritChance
local UnitAttackPower = UnitAttackPower
local UnitLevel = UnitLevel
local UnitRangedAttackPower = UnitRangedAttackPower
local UnitSpellHaste = UnitSpellHaste
local UnitStat = UnitStat
local CR_CRIT_MELEE = CR_CRIT_MELEE
local CR_HASTE_MELEE = CR_HASTE_MELEE
local CR_VERSATILITY_DAMAGE_DONE = CR_VERSATILITY_DAMAGE_DONE
local isNumber = __imports.isNumber
local returnBoolean = __imports.returnBoolean
local spellDamageSchools = {
    DEATHKNIGHT = 4,
    DEMONHUNTER = 3,
    DRUID = 4,
    HUNTER = 4,
    MAGE = 5,
    MONK = 4,
    PALADIN = 2,
    PRIEST = 2,
    ROGUE = 4,
    SHAMAN = 4,
    WARLOCK = 6,
    WARRIOR = 4
}
__exports.ovaleSpecializationName = {
    DEATHKNIGHT = {
        [1] = "blood",
        [2] = "frost",
        [3] = "unholy"
    },
    DEMONHUNTER = {
        [1] = "havoc",
        [2] = "vengeance"
    },
    DRUID = {
        [1] = "balance",
        [2] = "feral",
        [3] = "guardian",
        [4] = "restoration"
    },
    HUNTER = {
        [1] = "beast_mastery",
        [2] = "marksmanship",
        [3] = "survival"
    },
    MAGE = {
        [1] = "arcane",
        [2] = "fire",
        [3] = "frost"
    },
    MONK = {
        [1] = "brewmaster",
        [2] = "mistweaver",
        [3] = "windwalker"
    },
    PALADIN = {
        [1] = "holy",
        [2] = "protection",
        [3] = "retribution"
    },
    PRIEST = {
        [1] = "discipline",
        [2] = "holy",
        [3] = "shadow"
    },
    ROGUE = {
        [1] = "assassination",
        [2] = "outlaw",
        [3] = "subtlety"
    },
    SHAMAN = {
        [1] = "elemental",
        [2] = "enhancement",
        [3] = "restoration"
    },
    WARLOCK = {
        [1] = "affliction",
        [2] = "demonology",
        [3] = "destruction"
    },
    WARRIOR = {
        [1] = "arms",
        [2] = "fury",
        [3] = "protection"
    }
}
__exports.PaperDollData = __class(nil, {
    constructor = function(self)
        self.strength = 0
        self.agility = 0
        self.stamina = 0
        self.intellect = 0
        self.attackPower = 0
        self.spellPower = 0
        self.critRating = 0
        self.meleeCrit = 0
        self.rangedCrit = 0
        self.spellCrit = 0
        self.hasteRating = 0
        self.hastePercent = 0
        self.meleeAttackSpeedPercent = 0
        self.rangedAttackSpeedPercent = 0
        self.spellCastSpeedPercent = 0
        self.masteryRating = 0
        self.masteryEffect = 0
        self.versatilityRating = 0
        self.versatility = 0
        self.mainHandWeaponDPS = 0
        self.offHandWeaponDPS = 0
    end
})
local statName = {
    [1] = "strength",
    [2] = "agility",
    [3] = "stamina",
    [4] = "intellect",
    [5] = "attackPower",
    [6] = "spellPower",
    [7] = "critRating",
    [8] = "meleeCrit",
    [9] = "rangedCrit",
    [10] = "spellCrit",
    [11] = "hasteRating",
    [12] = "hastePercent",
    [13] = "meleeAttackSpeedPercent",
    [14] = "rangedAttackSpeedPercent",
    [15] = "spellCastSpeedPercent",
    [16] = "masteryRating",
    [17] = "masteryEffect",
    [18] = "versatilityRating",
    [19] = "versatility",
    [20] = "mainHandWeaponDPS",
    [21] = "offHandWeaponDPS"
}
__exports.OvalePaperDollClass = __class(States, {
    constructor = function(self, ovaleEquipement, ovale, ovaleDebug)
        self.ovaleEquipement = ovaleEquipement
        self.ovale = ovale
        self.level = UnitLevel("player")
        self.specialization = nil
        self.hasSpecialization = function(positional)
            local id = unpack(positional)
            if self.specialization then
                return returnBoolean(__exports.ovaleSpecializationName[self.class][self.specialization] == id)
            end
            return 
        end
        self.handleInitialize = function()
            self.class = self.ovale.playerClass
            self.module:RegisterEvent("UNIT_STATS", self.handleUnitStats)
            self.module:RegisterEvent("COMBAT_RATING_UPDATE", self.handleCombatRatingUpdate)
            self.module:RegisterEvent("MASTERY_UPDATE", self.handleMasteryUpdate)
            self.module:RegisterEvent("UNIT_ATTACK_POWER", self.handleUnitAttackPower)
            self.module:RegisterEvent("UNIT_RANGED_ATTACK_POWER", self.handleUnitRangedAttackPower)
            self.module:RegisterEvent("SPELL_POWER_CHANGED", self.handleSpellPowerChanged)
            self.module:RegisterEvent("UNIT_DAMAGE", self.handleUpdateDamage)
            self.module:RegisterEvent("PLAYER_ENTERING_WORLD", self.handleUpdateStats)
            self.module:RegisterEvent("PLAYER_ALIVE", self.handleUpdateStats)
            self.module:RegisterEvent("PLAYER_LEVEL_UP", self.handlePlayerLevelUp)
            self.module:RegisterEvent("UNIT_LEVEL", self.handleUnitLevel)
            self.module:RegisterMessage("Ovale_EquipmentChanged", self.handleOvaleEquipmentChanged)
            self.module:RegisterMessage("Ovale_TalentsChanged", self.handleUpdateStats)
        end
        self.handleDisable = function()
            self.module:UnregisterEvent("UNIT_STATS")
            self.module:UnregisterEvent("COMBAT_RATING_UPDATE")
            self.module:UnregisterEvent("MASTERY_UPDATE")
            self.module:UnregisterEvent("UNIT_ATTACK_POWER")
            self.module:UnregisterEvent("UNIT_RANGED_ATTACK_POWER")
            self.module:UnregisterEvent("SPELL_POWER_CHANGED")
            self.module:UnregisterEvent("UNIT_DAMAGE")
            self.module:UnregisterEvent("PLAYER_ENTERING_WORLD")
            self.module:UnregisterEvent("PLAYER_ALIVE")
            self.module:UnregisterEvent("PLAYER_LEVEL_UP")
            self.module:UnregisterEvent("UNIT_LEVEL")
            self.module:UnregisterMessage("Ovale_EquipmentChanged")
            self.module:UnregisterMessage("Ovale_StanceChanged")
            self.module:UnregisterMessage("Ovale_TalentsChanged")
        end
        self.handleOvaleEquipmentChanged = function(event, slot)
            if slot == "mainhandslot" or slot == "secondaryhandslot" or slot == "offhandslot" then
                self.handleUpdateDamage()
            end
        end
        self.handleUnitStats = function(event, unitId)
            if unitId == "player" then
                self.current.strength = UnitStat(unitId, 1)
                self.current.agility = UnitStat(unitId, 2)
                self.current.stamina = UnitStat(unitId, 3)
                self.current.intellect = UnitStat(unitId, 4)
                self.ovale:needRefresh()
            end
        end
        self.handleCombatRatingUpdate = function()
            self.current.critRating = GetCombatRating(CR_CRIT_MELEE)
            self.current.meleeCrit = GetCritChance()
            self.current.rangedCrit = GetRangedCritChance()
            self.current.spellCrit = GetSpellCritChance(spellDamageSchools[self.class])
            self.current.hasteRating = GetCombatRating(CR_HASTE_MELEE)
            self.current.hastePercent = GetHaste()
            self.current.meleeAttackSpeedPercent = GetMeleeHaste()
            self.current.rangedAttackSpeedPercent = GetRangedHaste()
            self.current.spellCastSpeedPercent = UnitSpellHaste("player")
            self.current.versatilityRating = GetCombatRating(CR_VERSATILITY_DAMAGE_DONE)
            self.current.versatility = GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE)
            self.ovale:needRefresh()
        end
        self.handleMasteryUpdate = function()
            self.current.masteryRating = GetMastery()
            if self.level < 80 then
                self.current.masteryEffect = 0
            else
                self.current.masteryEffect = GetMasteryEffect()
                self.ovale:needRefresh()
            end
        end
        self.handleUnitAttackPower = function(event, unitId)
            if unitId == "player" and  not self.ovaleEquipement:hasRangedWeapon() then
                local base, posBuff, negBuff = UnitAttackPower(unitId)
                self.current.attackPower = base + posBuff + negBuff
                self.ovale:needRefresh()
                self.handleUpdateDamage()
            end
        end
        self.handleUnitRangedAttackPower = function(unitId)
            if unitId == "player" and self.ovaleEquipement:hasRangedWeapon() then
                local base, posBuff, negBuff = UnitRangedAttackPower(unitId)
                self.ovale:needRefresh()
                self.current.attackPower = base + posBuff + negBuff
            end
        end
        self.handleSpellPowerChanged = function()
            self.current.spellPower = GetSpellBonusDamage(spellDamageSchools[self.class])
            self.ovale:needRefresh()
        end
        self.handlePlayerLevelUp = function(event, level)
            self.level = tonumber(level) or UnitLevel("player")
            self.ovale:needRefresh()
            self.debug:debugTimestamp("%s: level = %d", event, self.level)
        end
        self.handleUnitLevel = function(event, unitId)
            self.ovale.refreshNeeded[unitId] = true
            if unitId == "player" then
                self.level = UnitLevel(unitId)
                self.debug:debugTimestamp("%s: level = %d", event, self.level)
            end
        end
        self.handleUpdateDamage = function()
            self.current.mainHandWeaponDPS = self.ovaleEquipement.mainHandDPS or 0
            self.current.offHandWeaponDPS = self.ovaleEquipement.offHandDPS or 0
            self.ovale:needRefresh()
        end
        self.handleUpdateStats = function(event)
            self:updateSpecialization()
            self.handleUnitStats(event, "player")
            self.handleCombatRatingUpdate()
            self.handleMasteryUpdate()
            self.handleUnitAttackPower(event, "player")
            self.handleUnitRangedAttackPower("player")
            self.handleSpellPowerChanged()
            self.handleUpdateDamage()
        end
        States.constructor(self, __exports.PaperDollData)
        self.class = ovale.playerClass
        self.module = ovale:createModule("OvalePaperDoll", self.handleInitialize, self.handleDisable, aceEvent)
        self.debug = ovaleDebug:create("OvalePaperDoll")
    end,
    registerConditions = function(self, condition)
        condition:registerCondition("specialization", false, self.hasSpecialization)
    end,
    updateSpecialization = function(self)
        local newSpecialization = GetSpecialization()
        if self.specialization ~= newSpecialization then
            local oldSpecialization = self.specialization
            self.specialization = newSpecialization
            self.ovale:needRefresh()
            self.module:SendMessage("Ovale_SpecializationChanged", self:getSpecialization(newSpecialization), self:getSpecialization(oldSpecialization))
        end
    end,
    getSpecialization = function(self, specialization)
        specialization = specialization or self.specialization or 1
        return __exports.ovaleSpecializationName[self.class][specialization] or "arms"
    end,
    isSpecialization = function(self, name)
        if name and self.specialization then
            if isNumber(name) then
                return name == self.specialization
            else
                return (name == __exports.ovaleSpecializationName[self.class][self.specialization])
            end
        end
        return false
    end,
    getMasteryMultiplier = function(self, atTime)
        local state = self:getState(atTime)
        return 1 + state.masteryEffect / 100
    end,
    getBaseHasteMultiplier = function(self, atTime)
        local state = self:getState(atTime)
        return 1 + state.hastePercent / 100
    end,
    getMeleeAttackSpeedPercentMultiplier = function(self, atTime)
        local state = self:getState(atTime)
        return 1 + state.meleeAttackSpeedPercent / 100
    end,
    getRangedAttackSpeedPercentMultiplier = function(self, atTime)
        local state = self:getState(atTime)
        return 1 + state.rangedAttackSpeedPercent / 100
    end,
    getSpellCastSpeedPercentMultiplier = function(self, atTime)
        local state = self:getState(atTime)
        return 1 + state.spellCastSpeedPercent / 100
    end,
    getHasteMultiplier = function(self, haste, atTime)
        local multiplier = self:getBaseHasteMultiplier(atTime) or 1
        if haste == "melee" then
            multiplier = self:getMeleeAttackSpeedPercentMultiplier(atTime)
        elseif haste == "ranged" then
            multiplier = self:getRangedAttackSpeedPercentMultiplier(atTime)
        elseif haste == "spell" then
            multiplier = self:getSpellCastSpeedPercentMultiplier(atTime)
        end
        return multiplier
    end,
    initializeState = function(self)
        self.next.strength = 0
        self.next.agility = 0
        self.next.stamina = 0
        self.next.intellect = 0
        self.next.attackPower = 0
        self.next.spellPower = 0
        self.next.critRating = 0
        self.next.meleeCrit = 0
        self.next.rangedCrit = 0
        self.next.spellCrit = 0
        self.next.hasteRating = 0
        self.next.hastePercent = 0
        self.next.meleeAttackSpeedPercent = 0
        self.next.rangedAttackSpeedPercent = 0
        self.next.spellCastSpeedPercent = 0
        self.next.masteryRating = 0
        self.next.masteryEffect = 0
        self.next.versatilityRating = 0
        self.next.versatility = 0
        self.next.mainHandWeaponDPS = 0
        self.next.offHandWeaponDPS = 0
    end,
    cleanState = function(self)
    end,
    resetState = function(self)
        for _, key in ipairs(statName) do
            local value = self.current[key]
            if value then
                self.next[key] = value
            end
        end
    end,
})
