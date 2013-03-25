local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")
local bcm = a.BCM

local GetItemCount = GetItemCount
local IsMounted = IsMounted
local UnitBuff = UnitBuff

------------------------------------------------------------------------ Common
c.AddOptionalSpell("Mage Armor", nil, {
	Buff = "Mage Armor",
	BuffUnit = "player",
})

c.AddOptionalSpell("Conjure Mana Gem", nil, {
	NotIfActive = true,
	CheckFirst = function()
		local count, target
		if c.HasGlyph("Mana Gem") then
			count = GetItemCount(c.GetID("Brilliant Mana Gem"), false, true)
			target = 7
		else
			count = GetItemCount(c.GetID("Mana Gem"), false, true)
			target = 3
		end 
		if c.IsSolo() then
			target = 1
		end
		return count < target
	end	
})

c.AddOptionalSpell("Mana Gem", nil, {
	Type = "item",
	CheckFirst = function()
		return a.ManaPercent < 80
	end
})

c.AddOptionalSpell("Brilliant Mana Gem", nil, {
	Type = "item",
	CheckFirst = function()
		return a.ManaPercent < 80
	end
})

c.AddOptionalSpell("Mirror Image")

c.AddOptionalSpell("Arcane Brilliance", nil, {
	NoRangeCheck = 1,
	CheckFirst = function()
		return c.RaidBuffNeeded(c.SPELL_POWER_BUFFS)
			or c.RaidBuffNeeded(c.CRIT_BUFFS)
	end
})

c.AddOptionalSpell("Dalaran Brilliance", nil, {
	NoRangeCheck = 1,
	CheckFirst = function()
		return c.RaidBuffNeeded(c.SPELL_POWER_BUFFS)
			or c.RaidBuffNeeded(c.CRIT_BUFFS)
	end
})

c.AddInterrupt("Counterspell")

c.AddOptionalSpell("Spellsteal", nil, {
	FlashColor = "aqua",
	CheckFirst = function()
		local unit = s.UnitSelection()
		if unit == nil or not s.Enemy(unit) then
			return false
		end
		
		for i = 1, 10000 do
			local _, _, _, _, _, _, _, _, isStealable, _, spellID
				= UnitBuff(unit, i)
			if spellID == nil then
				return false
			elseif isStealable then
				return true
			end
		end
	end
})

c.AddSpell("Nether Tempest", nil, {
	EarlyRefresh = 99,
	CheckFirst = function(z)
		if c.AoE or c.IsSolo() then
			z.FlashColor = "yellow"
			z.Continue = true
		else
			z.FlashColor = nil
			z.Continue = nil
		end
		return c.GetMyDebuffDuration("Nether Tempest") < z.EarlyRefresh
	end
})
c.ManageDotRefresh("Nether Tempest", 1)

c.AddSpell("Living Bomb", nil, {
	EarlyRefresh = 99,
	CheckFirst = function(z)
		if c.IsSolo() then
			z.FlashColor = "yellow"
			z.Continue = true
		else
			z.FlashColor = nil
			z.Continue = nil
		end
		return c.GetMyDebuffDuration("Living Bomb") < z.EarlyRefresh
	end
})
c.ManageDotRefresh("Living Bomb", 3)

c.AddSpell("Frost Bomb", nil, {
	CheckFirst = function(z)
		if c.IsSolo() then
			z.FlashColor = "yellow"
			z.Continue = true
		else
			z.FlashColor = nil
			z.Continue = nil
		end
		return not c.IsCasting("Frost Bomb")
			and c.GetCooldown("Frost Bomb") == 0
	end
})

c.AddOptionalSpell("Presence of Mind", nil, {
	NoGCD = true,
	CheckFirst = function()
		return not c.HasBuff("Alter Time", true)
	end
})

c.AddOptionalSpell("Evocation", nil, {
	CheckFirst = function()
		return a.ManaPercent <= 10
	end
})

c.AddOptionalSpell("Evocation", "for Health", {
	CheckFirst = function()
		return c.IsSolo()
			and c.HasGlyph("Evocation")
			and s.HealthPercent("player") < 60
	end
})

c.AddOptionalSpell("Evocation", "for Invoker's Energy", {
	CheckFirst = function()
		return c.HasTalent("Invocation")
			and c.GetBuffDuration("Invoker's Energy") < c.GetHastedTime(2.25)
	end
})

c.AddOptionalSpell("Rune of Power", nil, {
	Buff = "Rune of Power",
	BuffUnit = "player",
	NoRangeCheck = true,
})

------------------------------------------------------------------------ Arcane
local function hasT6TalentFor(duration)
	return (not c.HasTalent("Rune of Power") or c.HasBuff("Rune of Power"))
		and (not c.HasTalent("Invocation")
			or c.GetBuffDuration("Invoker's Energy") >= duration)
		and (not c.HasTalent("Incanter's Ward") 
			or c.GetCooldown("Incanter's Ward") == 0
			or c.GetBuffDuration("Incanter's Absorption") > duration)
end

local function doPower()
	return a.MissilesStacks > 0
		and a.ChargeStacks > 2
		and not c.HasBuff("Alter Time")
		and hasT6TalentFor(15)
end

c.AddOptionalSpell("Arcane Power", nil, {
	CheckFirst = doPower,
})

c.AddOptionalSpell("Alter Time", "for Arcane", {
	CheckFirst = function(z)
		if c.HasBuff("Arcane Power") then
			z.FlashSize = nil
			return not c.HasBuff("Alter Time")
		elseif doPower() then
			z.FlashSize = s.FlashSizePercent() / 2
			return true
		end
	end
})

c.AddOptionalSpell("Evocation", "for Arcane", {
	CheckFirst = function()
		if c.HasBuff("Alter Time") then
			return false
		end
		
		return a.ManaPercent < 70
			or (c.HasTalent("Invocation") 
				and c.GetBuffDuration("Invoker's Energy") 
					< c.GetCastTime("Arcane Blast"))
	end
})

c.AddOptionalSpell("Evocation", "Interrupt", {
	FlashColor = "red",
	Override = function()
		return c.IsCasting("Evocation")
			and not c.HasTalent("Invocation") 
			and s.PowerPercent("player") > 98
	end
})

c.RegisterForFullChannels("Arcane Missiles", 2)

c.AddSpell("Arcane Missiles", nil, {
	CheckFirst = function(z)
		z.FlashColor = nil
		z.FlashSize = nil
		z.Continue = nil
		if c.HasBuff("Alter Time") or c.IsSolo() then
			return true
		end
		
		if a.MissilesStacks == 2 then
			if c.GetCooldown("Alter Time") == 0 then
				z.FlashSize = s.FlashSizePercent() / 2
				z.FlashColor = "yellow"
				z.Continue = true
			end
			return true
		end
		
		if a.ChargeStacks == 4 then
			if c.GetCooldown("Arcane Power") < 6 then
				z.FlashSize = s.FlashSizePercent() / 2
				z.FlashColor = "yellow"
				z.Continue = true
			end
			return true
		end
	end
})

c.AddOptionalSpell("Arcane Missiles", "for AoE")

c.AddSpell("Arcane Barrage", nil, {
	NoStopChannel = true,
	CheckFirst = function()
		return a.ChargeStacks == 4 and not c.HasBuff("Alter Time")
	end
})

c.AddSpell("Arcane Barrage", "for AoE", {
	NoStopChannel = true,
	CheckFirst = function()
		return a.ChargeStacks == 4
	end
})

c.AddSpell("Arcane Barrage", "if Losing Stacks", {
	FlashColor = "red",
	NoStopChannel = true,
	CheckFirst = function()
		local duration = a.ChargeDuration
		if c.HasBuff("Alter Time") then
			duration = math.min(duration, c.GetBuffDuration("Alter Time"))
		end
		return duration > 0 and duration < c.GetCastTime("Arcane Blast") + .1
	end
})

c.AddOptionalSpell("Flamestrike", nil, {
	NoRangeCheck = true,
	CheckFirst = function()
		return not c.IsCasting("Flamestrike")
	end
})

c.AddSpell("Arcane Explosion", nil, {
	Melee = true,
})

-------------------------------------------------------------------------- Fire
c.AssociateTravelTimes(.5, "Fireball", "Pyroblast", "Frostfire Bolt")
c.AssociateTravelTimes(.2, "Scorch", "Inferno Blast")

local function combustionCheckFirst(z, multiplier)
	local threshhold = c.GetOption("CombustionMin") * multiplier
	if bcm.PredictDamage(false, false) >= threshhold then
		if bcm.PredictDamage(true, false) >= threshhold then
			z.FlashColor = "yellow"
		else
			z.FlashColor = "red"
		end
		return true
	end
end

c.AddOptionalSpell("Molten Armor", nil, {
	Buff = "Molten Armor",
	BuffUnit = "player",
})

c.AddOptionalSpell("Combustion", nil, {
	NoGCD = true,
	CheckFirst = function(z)
		return combustionCheckFirst(z, 1)
	end
})

c.AddOptionalSpell("Combustion", "when Big", {
	NoGCD = true,
	CheckFirst = function(z)
		return combustionCheckFirst(z, 1.4)
	end
})

c.AddSpell("Pyroblast", nil, {
	CheckFirst = function()
		return a.PyroProc 
			or c.HasBuff("Presence of Mind") 
			or c.IsCasting("Presence of Mind")
	end
})

c.AddSpell("Inferno Blast", nil, {
	CheckFirst = function()
		return a.HeatingProc
	end
})

c.AddSpell("Scorch", nil, {
	Continue = true,
	CheckFirst = function()
		return s.Moving("player")
	end
})

c.AddSpell("Frostfire Bolt", nil, {
	Continue = true,
	CheckFirst = function()
		return c.HasGlyph("Frostfire Bolt")
	end
})

------------------------------------------------------------------------- Frost
c.AssociateTravelTimes(.7, "Frostbolt")

c.AddOptionalSpell("Summon Water Elemental", nil, {
    FlashColor = "yellow",
    CheckFirst = function()
        return not s.UpdatedVariables.PetAlive
            and not IsMounted()
    end
})

c.AddOptionalSpell("Frost Armor", nil, {
	Buff = "Frost Armor",
	BuffUnit = "player",
})

c.AddOptionalSpell("Freeze", nil, {
    Type = "pet",
    NoRangeCheck = 1,
    NoGCD = true,
    CheckFirst = function()
        return a.FingerCount < 2 
        	and s.SpellCooldown(c.GetID("Freeze")) == 0
        	and not s.Boss() 
    end
})

c.AddSpell("Ice Lance", nil, {
	CheckFirst = function()
		return a.FingerCount > 0
	end
})

c.AddSpell("Ice Lance", "within 2", {
	CheckFirst = function()
		return (a.FingerCount > 0 and c.GetBuffDuration("Fingers of Frost") < 2)
			or (a.FingerCount < 2 
				and (c.HasDebuff("Deep Freeze") 
					or c.IsAuraPendingFor("Deep Freeze")))
	end
})

c.AddSpell("Ice Lance", "within 5", {
	CheckFirst = function()
		return a.FingerCount > 0 and c.GetBuffDuration("Fingers of Frost") < 5
	end
})

c.AddOptionalSpell("Frozen Orb", nil, {
	NoRangeCheck = true,
})

--c.AddOptionalSpell("Frozen Orb", "with Icy Veins", {
--	NoRangeCheck = true,
--	CheckFirst = function()
--		return a.FingerCount < 2
--			and c.HasGlyph("Icy Veins")
--			and c.GetCooldown("Icy Veins") < c.GetHastedTime(1.5)
--	end
--})

c.AddOptionalSpell("Icy Veins", nil, {
	CheckFirst = function(z)
		if c.HasGlyph("Icy Veins") then
			z.ID = c.GetID("Icy Veins Glyphed")
			return c.GetCooldown("Frozen Orb") > 50
		else
			z.ID = c.GetID("Icy Veins")
			return true
		end
	end
})

c.AddSpell("Frostbolt", "for Debuff", {
	CheckFirst = function()
		return c.GetMyDebuffStack("Frostbolt", false, true)
					+ c.CountLandings("Frostbolt", -3, 10)
				< 3
			and not c.IsSolo()
	end
})

c.AddSpell("Frostfire Bolt", "under Brain Freeze", {
	CheckFirst = function()
		return c.HasBuff("Brain Freeze")
	end
})

c.AddOptionalSpell("Deep Freeze", nil, {
	CheckFirst = function()
		return a.FingerCount < 2 
			and not s.Boss() 
			and c.GetCooldown("Frozen Orb") < 50
	end
})

--c.AddOptionalSpell("Frost Nova", nil, {
--	CheckFirst = function()
--		return c.IsSolo() 
--			and c.DistanceAtTheMost() <= 12 
--			and not c.HasDebuff("Deep Freeze")
--			and not s.Boss()
--	end
--})
