local AddonName, a = ...
if a.BuildFail(40000, 50000) then return end
local L = a.Localize
local s = SpellFlashAddon
local c = BittensSpellFlashLibrary

local UnitCreatureType = UnitCreatureType
local UnitLevel = UnitLevel

c.Init(a)

------------------------------------------------------------------------ common
local function threeHolyPower()
	return a.HolyPower == 3
end

local function needsHolyPower()
	return a.HolyPower < 3
end

c.AddOptionalSpell("Avenging Wrath", nil, { NoGCD = true })

c.AddOptionalSpell("Seal of Truth", nil, {
    CheckFirst = function()
        return c.SelfBuffNeeded("Seal of Truth")
    end
})

c.AddOptionalSpell("Seal of Insight", nil, {
    CheckFirst = function()
        return c.SelfBuffNeeded("Seal of Insight")
    end
})

c.AddOptionalSpell("Judgement", "for Buff", {
    NoRangeCheck = true,
    CheckFirst = function()
        return not c.HasBuff("Judgements of the Pure")
        	and c.HasTalent("Judgements of the Pure")
    end
})

c.AddOptionalSpell("Consecration", "over 50", {
	Melee = true,
    CheckFirst = function()
        return s.PowerPercent("player") > 50
    end
})

c.AddOptionalSpell("Auras", nil, {
    Type = "form",
    ID = "Devotion Aura",
    FlashID = { 
    	"Concentration Aura", 
    	"Crusader Aura", 
    	"Devotion Aura", 
    	"Resistance Aura", 
    	"Retribution Aura" 
    },
    Override = function()
        return not s.Form()
    end
})

c.AddOptionalSpell("Blessing of Kings", nil, { NoRangeCheck = 1 })

c.AddOptionalSpell("Blessing of Might", nil, { NoRangeCheck = 1 })

c.AddInterrupt("Rebuke")

-------------------------------------------------------------------------- holy
c.AddOptionalSpell("Word of Glory", "at 3", {
    NoRangeCheck = 1,
    CheckFirst = threeHolyPower,
})

c.AddOptionalSpell("Light of Dawn", "at 3", {
    NoRangeCheck = 1,
    CheckFirst = threeHolyPower,
})

c.AddOptionalSpell("Holy Shock", "under 3 with Daybreak", {
    NoRangeCheck = 1,
    CheckFirst = function()
        return a.HolyPower < 3 and c.HasBuff("Daybreak")
    end
})

c.AddOptionalSpell("Divine Light", nil, { NoRangeCheck = 1 })

c.AddOptionalSpell("Flash of Light", nil, { NoRangeCheck = 1 })

c.AddOptionalSpell("Holy Radiance", nil, { NoRangeCheck = 1 })

c.AddOptionalSpell("Beacon of Light", nil, {
    Override = function()
        if not s.InRaidOrParty() then
            return false
        end
        
        if not a.BeaconTarget then
            return true
        end
        
        if s.InCombat() then
            return not s.MyBuff(c.GetID("Beacon of Light"), a.BeaconTarget)
        else
            return s.MyBuffDuration(
            	c.GetID("Beacon of Light"), a.BeaconTarget) < 2 * 60
        end
    end
})

-------------------------------------------------------------------- protection
c.AddSpell("Word of Glory", "at 90", {
    Unit = "player",
    CheckFirst = function()
        return a.HolyPower == 3
            and s.HealthPercent("player") < 90
    end
})

c.AddSpell("Crusader Strike", "for Holy Power", { CheckFirst = needsHolyPower })

c.AddSpell("Shield of the Righteous", "unless WoG", {
    CheckFirst = function()
        return a.HolyPower == 3 and c.GetCooldown("Word of Glory") > 12
    end
})

c.AddSpell("Avenger's Shield", "for Holy Power", {
    CheckFirst = function()
        return c.HasBuff("Grand Crusader")
    end
})

c.AddSpell("Judgement", "for Debuff", {
    Debuff = c.SLOW_MELEE_DEBUFFS,
    EarlyRefresh = 3,
})

c.AddSpell("Judgement", "for Bubble", {
    CheckFirst = function()
        return c.WearingSet(2, "ProtT13")
    end
})

c.AddSpell("Crusader Strike", "for Debuff", {
    Debuff = c.PHYSICAL_DAMAGE_DEBUFFS,
    EarlyRefresh = 3,
    CheckFirst = function()
    	return c.HasTalent("Vindication")
    end
})

c.AddSpell("Hammer of the Righteous", "for Debuff", {
    Debuff = c.PHYSICAL_DAMAGE_DEBUFFS,
    EarlyRefresh = 3,
    CheckFirst = function()
    	return c.HasTalent("Vindication")
    end
})

c.AddOptionalSpell("Righteous Fury", nil, {
    Buff = "Righteous Fury",
    BuffUnit = "player",
})

c.AddSpell("Holy Wrath", nil, {
	Melee = true,
})

c.AddSpell("Holy Wrath", "to Stun", {
	Melee = true,
    CheckFirst = function()
        local level = UnitLevel("target")
        if level == -1 or level > UnitLevel("player") then
            return false
        end
        
        local ct = UnitCreatureType("target")
        return UnitLevel("target") <= UnitLevel("player")
            and (ct == L["Demon"]
                or ct == L["Dragonkin"]
                or ct == L["Elemental"]
                or ct == L["Undead"])
    end
})

c.AddOptionalSpell("Ardent Defender")

c.AddOptionalSpell("Holy Shield")

c.AddOptionalSpell("Divine Protection")

c.AddOptionalSpell("Guardian of Ancient Kings")

c.AddOptionalSpell("Fire of the Deep", nil, {
    Type = "item",
    Buff = "Elusive",
})

c.AddTaunt("Hand of Reckoning", nil, { NoGCD = true })

c.AddTaunt("Righteous Defense", nil, { NoGCD = true })

------------------------------------------------------------------- retribution
c.AddSpell("Divine Storm", "for Holy Power", {
    CheckFirst = needsHolyPower,
})

c.AddSpell("Judgement", "for Holy Power", {
    CheckFirst = needsHolyPower,
})

c.AddSpell("Exorsism", "under Art of War", {
    CheckFirst = function()
        return c.HasBuff("The Art of War")
    end
})

c.AddSpell("Exorsism", "under Art of War against Undead", {
    CheckFirst = function()
        return c.HasBuff("The Art of War")
            and UnitCreatureType("target") == L["Undead"]
    end
})

c.AddSpell("Templar's Verdict", nil, { CheckFirst = threeHolyPower })

c.AddOptionalSpell("Zealotry", nil, {
	NoGCD = true,
	CheckFirst = function()
		return not c.AoE or c.WearingSet(4, "RetT13")
	end
})

c.AddSpell("Inquisition", nil, {
    CheckFirst = function()
        return a.HolyPower == 3
        	and c.GetBuffDuration("Inquisition") < 3
    end
})
