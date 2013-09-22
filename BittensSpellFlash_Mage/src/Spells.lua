local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local x = s.UpdatedVariables
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")
local bcm = a.BCM

local GetItemCount = GetItemCount
local IsMounted = IsMounted
local UnitBuff = UnitBuff
local UnitLevel = UnitLevel

local function getRuneDuration()
	if c.IsCasting("Rune of Power") then	
		return 60
	end
	
	local t1 = c.GetTotemDuration(1)
	local t2 = c.GetTotemDuration(2)
	return math.max(t1, t2)
end

------------------------------------------------------------------------ Common
c.AddOptionalSpell("Mage Armor", nil, {
	Buff = { "Mage Armor", "Frost Armor" },
	FlashID = { "Mage Armor", "Frost Armor" },
	BuffUnit = "player",
})

c.AddOptionalSpell("Conjure Mana Gem", nil, {
	NotIfActive = true,
	CheckFirst = function()
		if not s.Spec(1) and not s.HasTalent("Invocation") then
			return false
		end
		
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
		return a.ManaPercent < 80 and not a.AlterTime
	end
})

c.AddOptionalSpell("Mana Gem", "at 10", {
	Type = "item",
	CheckFirst = function()
		return a.ManaPercent < 10 and not a.AlterTime
	end
})

c.AddOptionalSpell("Brilliant Mana Gem", nil, {
	Type = "item",
	CheckFirst = function()
		return a.ManaPercent < 80
	end
})

c.AddOptionalSpell("Brilliant Mana Gem", "at 10", {
	Type = "item",
	CheckFirst = function()
		return a.ManaPercent < 10 and not a.AlterTime
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
	MyDebuff = "Nether Tempest",
	RunFirst = function(z)
		c.MakeOptional(z, c.IsAoE or c.IsSolo())
	end
})
c.ManageDotRefresh("Nether Tempest", 1)

c.AddSpell("Living Bomb", nil, {
	SpecialGCD = 1,
	EarlyRefresh = 99,
	MyDebuff = "Living Bomb",
	RunFirst = function(z)
		c.MakeOptional(z, c.IsSolo())
	end
})
c.ManageDotRefresh("Living Bomb", 3)

c.AddSpell("Frost Bomb", nil, {
	NotIfActive = true,
	RunFirst = function(z)
		c.MakeOptional(z, c.IsSolo())
	end
})

c.AddOptionalSpell("Presence of Mind", nil, {
	NoGCD = true,
	CheckFirst = function()
		return not a.AlterTime
	end
})

c.AddOptionalSpell("Evocation", nil, {
	CheckFirst = function()
		return a.ManaPercent <= 10 
			and not a.AlterTime
			and not c.HasBuff("Replenish Mana", false, false, "Mana Gem")
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
			and c.GetBuffDuration("Invoker's Energy", false, false, "Evocation") 
				< c.GetHastedTime(3)
	end
})

c.AddOptionalSpell("Evocation", "for Invoker's Energy at 5", {
	CheckFirst = function()
		return not a.AlterTime
			and c.HasTalent("Invocation")
			and c.GetBuffDuration("Invoker's Energy", false, false, "Evocation") 
				< 5 + c.GetHastedTime(3)
			and not c.IsSolo()
	end
})

c.AddOptionalSpell("Evocation", "for Invoker's Energy Pre-Combat", {
	CheckFirst = function()
		return x.EnemyDetected
			and c.HasTalent("Invocation")
			and c.GetBuffDuration("Invoker's Energy", false, false, "Evocation") 
				< 15
	end
})

c.AddOptionalSpell("Rune of Power", nil, {
	NoRangeCheck = true,
	NotIfActive = true,
	CheckFirst = function()
		return not c.HasBuff("Rune of Power", false, false, true)
			or getRuneDuration() == 0
	end
})

c.AddOptionalSpell("Rune of Power", "at 5", {
	NoRangeCheck = true,
	CheckFirst = function()
		return not a.AlterTime
			and getRuneDuration() < 5 + c.GetCastTime("Rune of Power") 
			and not c.IsSolo()
	end
})

c.AddOptionalSpell("Rune of Power", "Pre-Combat", {
	NoRangeCheck = true,
	CheckFirst = function()
		return x.EnemyDetected
			and (not c.HasBuff("Rune of Power", false, false, true)
				or getRuneDuration() < 15)
	end
})

c.AddSpell("Fire Blast", nil, {
	NotIfActive = true,
})

c.AddOptionalSpell("Ice Barrier", nil, {
	CheckFirst = function(z)
		if not c.IsSolo() then
			return false
		elseif s.InCombat() then
			return not c.HasBuff("Ice Barrier")
		elseif x.EnemyDetected then
			if c.GetBuffDuration("Ice Barrier") < 15 then
				return true
			end
			
			local val = select(15, UnitBuff("player", s.SpellName(z.ID)))
			return val < (UnitLevel("player") - 29) * 50
		end
	end,
})

c.AddOptionalSpell("Cold Snap", nil, {
	CheckFirst = function()
		return c.GetHealthPercent("Player") < 70
	end
})

c.AddSpell("Ice Floes", nil, { NoGCD = true })
c.AddSpell("Temporal Shield", nil, { NoGCD = true })

------------------------------------------------------------------------ Arcane
local function hasT6TalentFor(duration)
	if c.HasTalent("Rune of Power") then 
		return c.HasBuff("Rune of Power") and getRuneDuration() >= duration
	elseif c.HasTalent("Invocation") then
		return c.GetBuffDuration("Invoker's Energy") >= duration
	elseif c.HasTalent("Incanter's Ward") then 
		return c.GetCooldown("Incanter's Ward", false, 25) == 0
			or c.GetBuffDuration("Incanter's Absorption") > duration
	else
		return true
	end
end

local function doPower()
	return a.MissilesStacks > 0
		and a.ChargeStacks > 2
		and not a.AlterTime
		and hasT6TalentFor(15)
end

c.RegisterForFullChannels("Arcane Missiles", 2)

c.AddOptionalSpell("Arcane Power", nil, {
	NoGCD = true,
	CheckFirst = doPower,
})

c.AddOptionalSpell("Presence of Mind", "before AT", {
	NoGCD = true,
	CheckFirst = function(z)
		if c.GetCastTime("Arcane Blast") < 1.2
			or (not a.ArcanePower 
				and (not doPower() or c.GetCooldown("Arcane Power") > 0)) then
			
			return false
		end
		
		c.MakePredictor(z, not a.ArcanePower, "yellow")
		return (a.ArcanePower 
				or (c.GetCooldown("Arcane Power") == 0 and doPower()))
			and c.GetCastTime("Arcane Blast") > 1.2
	end
})

c.AddOptionalSpell("Presence of Mind", "before AB", {
	NoGCD = true,
	CheckFirst = function(z)
		return c.GetCastTime("Arcane Blast") > 1.2
			and c.GetCooldown("Alter Time", false, 180) > 30
	end
})

c.AddOptionalSpell("Presence of Mind", "before Flamestrike", {
	NoGCD = true,
	CheckFirst = function(z)
		return c.GetCastTime("Flamestrike") > 1.2
			and c.GetCooldown("Alter Time", false, 180) > 30
	end
})

c.AddOptionalSpell("Alter Time", "for Arcane", {
	CheckFirst = function(z)
		if not a.ArcanePower 
			and (not doPower() or c.GetCooldown("Arcane Power") > 0) then
			
			return false
		end
		
		c.MakePredictor(
			z, 
			not a.ArcanePower
				or (not c.HasBuff("Presence of Mind", false, false, true)
					and c.GetCooldown("Presence of Mind") == 0),
			"yellow")
		return true
	end
})

c.AddOptionalSpell("Evocation", "for Arcane", {
	NotIfActive = true,
	CheckFirst = function()
		if a.AlterTime then
			return false
		end
		
		if c.HasTalent("Invocation") then
			return (a.ChargeStacks == 0 and a.ManaPercent < 70)
				or c.GetBuffDuration("Invoker's Energy") 
					< c.GetCastTime("Arcane Blast")
		else
			return a.ChargeStacks == 0 and a.ManaPercent < 80
		end
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

c.AddSpell("Arcane Missiles", nil, {
	CheckFirst = function(z)
		local apcd = c.GetCooldown("Arcane Power", false, 90)
		c.MakeOptional(z, a.MissilesStacks == 1 and (apcd == 0 or c.IsSolo()))
		c.MakeMini(z, a.MissilesStacks == 1 and apcd < 6)
		return a.AlterTime
			or a.MissilesStacks == 2
			or a.ChargeStacks == 4
	end
})

c.AddSpell("Arcane Missiles", "for AoE")

c.AddSpell("Arcane Barrage", nil, {
	CheckFirst = function()
		return a.ChargeStacks == 4 and not a.AlterTime
	end
})

c.AddSpell("Arcane Barrage", "for AoE", {
	CheckFirst = function()
		return a.ChargeStacks == 4
	end
})

c.AddSpell("Arcane Barrage", "if Losing Stacks", {
	FlashColor = "red",
	CheckFirst = function()
		local duration = a.ChargeDuration
		if a.AlterTime then
			duration = math.min(duration, c.GetBuffDuration("Alter Time"))
		end
		return duration > 0 and duration < c.GetCastTime("Arcane Blast") + .1
	end
})

c.AddSpell("Arcane Barrage", "when Moving", {
	NotWhileActive = true,
})

c.AddOptionalSpell("Flamestrike", nil, {
	NoRangeCheck = true,
	CheckFirst = function()
		return not c.IsCasting("Flamestrike")
	end
})

c.AddOptionalSpell("Arcane Explosion", nil, {
	Melee = true,
})

-------------------------------------------------------------------------- Fire
c.AssociateTravelTimes(.5, "Fireball", "Pyroblast", "Frostfire Bolt")
c.AssociateTravelTimes(.2, "Scorch", "Inferno Blast")

c.AddOptionalSpell("Molten Armor", nil, {
	Buff = "Molten Armor",
	BuffUnit = "player",
})

c.AddOptionalSpell("Combustion", nil, {
	NoGCD = true,
	CheckFirst = function(z)
		local threshhold = c.GetOption("CombustionMin")
		if a.AlterTime 
			or a.PyroProc 
			or c.HasBuff("Presence of Mind", false, false, true) then
			
			threshhold = threshhold * 2
		end
		
		if bcm.PredictDamage(false, false) >= threshhold then
			if bcm.PredictDamage(true, false) >= threshhold then
				z.FlashColor = "yellow"
			else
				z.FlashColor = "red"
			end
			return true
		end
	end
})

c.AddOptionalSpell("Alter Time", "for Fire", {
	CheckFirst = function(z)
		c.MakePredictor(
			z, 
			not c.HasBuff("Presence of Mind", false, false, true) 
				and c.GetCooldown("Presence of Mind") == 0, 
			"yellow")
		return a.PyroProc
	end
})

c.AddOptionalSpell("Presence of Mind", "for Fire", {
	NoGCD = true,
	Override = function()
		if c.GetCooldown("Presence of Mind", false, 90) > 0 then
			return false
		end
		
		local at = c.GetCooldown("Alter Time", true, 90)
		if at > 60
			or (at == 0 
				and c.GetSpell("Alter Time for Fire"):CheckFirst()) then
			 
			s.Flash(c.GetID("Pyroblast"), "green", s.FlashSizePercent() / 2)
			return true
		end
	end
})

c.AddOptionalSpell("Evocation", "for Invoker's Energy for Fire", {
	CheckFirst = function()
		local dur = c.GetBuffDuration(
			"Invoker's Energy", false, false, "Evocation")
		local cast = c.GetHastedTime(3)
		return c.HasTalent("Invocation")
			and (dur == 0 
				or (c.GetCooldown("Alter Time", false, 180) < cast 
					and dur < cast + 6
					and not c.IsSolo()))
	end
})

c.AddOptionalSpell("Rune of Power", "for Fire", {
	NoRangeCheck = true,
	CheckFirst = function()
		local cast = c.GetCastTime("Rune of Power")
		return not c.HasBuff("Rune of Power", false, false, true)
			or (c.GetCooldown("Alter Time", false, 180) < cast
				and getRuneDuration() < cast + 6
				and not c.IsSolo())
	end
})

c.AddSpell("Pyroblast", nil, {
	CanCastWhileMoving = true,
	CheckFirst = function()
		return a.PyroProc 
			or (c.HasBuff("Presence of Mind", false, false, true) 
				and not c.IsCasting("Pyroblast"))
	end
})

c.AddSpell("Inferno Blast", nil, {
	CheckFirst = function()
		return a.HeatingProc
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

c.AddOptionalSpell("Evocation", "for Invoker's Energy for Frost", {
	CheckFirst = function()
		local dur = c.GetBuffDuration(
			"Invoker's Energy", false, false, "Evocation")
		local cast = c.GetHastedTime(3)
		return c.HasTalent("Invocation")
			and (dur == 0 
				or (a.VeinsCD < cast and dur < cast + 6 and not c.IsSolo()))
	end
})

c.AddOptionalSpell("Rune of Power", "for Frost", {
	NoRangeCheck = true,
	CheckFirst = function()
		local cast = c.GetCastTime("Rune of Power")
		return not c.HasBuff("Rune of Power", false, false, true)
			or (a.VeinsCD < cast 
				and getRuneDuration() < cast + 26 
				and not c.IsSolo())
	end
})

c.AddOptionalSpell("Frozen Orb", nil, {
	NoRangeCheck = true,
	CheckFirst = function()
		return a.FingerCount == 0
	end
})

c.AddOptionalSpell("Icy Veins", nil, {
	CheckFirst = function(z)
		z.ID = a.VeinsID
		local atcd = c.GetCooldown("Alter Time")
		return atcd < 4 or atcd > 49
	end
})

c.AddOptionalSpell("Presence of Mind", "for Frost", {
	NoGCD = true,
	CheckFirst = function(z)
		c.MakePredictor(
			z, c.HasGlyph("Icy Veins") and a.VeinsCD == 0, "yellow")
		local at = c.GetCooldown("Alter Time")
		return not a.AlterTime
			and (at > 15 
				or (at == 0 
					and c.GetSpell("Alter Time for Frost"):CheckFirst())) 
			and (not c.HasGlyph("Icy Veins") 
				or a.VeinsCD > 15
				or (a.VeinsCD == 0 
					and c.GetSpell("Icy Veins"):CheckFirst()))
			and c.GetCastTime("Frostbolt") > 1
	end
})

c.AddOptionalSpell("Alter Time", "for Frost", {
	CheckFirst = function(z)
		local hasVeins = c.HasBuff("Icy Veins", false, false, true)
		c.MakePredictor(
			z, 
			(not hasVeins and a.VeinsCD == 0) 
				or (not c.HasBuff("Presence of Mind") 
					and c.GetCooldown("Presence of Mind") == 0), 
			"yellow")
		return (a.VeinsCD == 0 or hasVeins or a.VeinsCD > 45)
			and (a.BrainFreeze or a.FingerCount > 0)
	end
})

c.AddOptionalSpell("Freeze", nil, {
    Type = "pet",
    NoRangeCheck = 1,
    NoGCD = true,
    CheckFirst = function()
        if s.SpellCooldown(c.GetID("Freeze")) > 0 or s.Boss() then
        	return false
        elseif c.AoE then
        	return a.FingerCount == 0
        elseif c.IsSolo() and c.GetCooldown("Deep Freeze") < 25 then
        	return a.FingerCount == 0
        		and not a.BrainFreeze
        		and c.GetCooldown("Deep Freeze") == 0
        		and s.SpellInRange(c.GetID("Deep Freeze"))
        else
        	return a.FingerCount < 2 and not c.HasMyDebuff("Deep Freeze")
        end
    end
})

c.AddOptionalSpell("Deep Freeze", nil, {
	CheckFirst = function()
		if s.Boss() or c.GetCooldown("Frozen Orb") > 50 then
			return false
		elseif c.IsSolo() and c.GetCooldown("Freeze", true, 25) == 0 then
			return a.FingerCount == 0
		else
			return a.FingerCount < 2
		end
	end
})

c.AddSpell("Frostfire Bolt", "Prime", {
	CheckFirst = function()
		return a.BrainFreeze 
			and (a.AlterTime or c.GetBuffDuration("Brain Freeze") < 2)
	end
})

c.AddSpell("Frostfire Bolt", "under Brain Freeze", {
	CheckFirst = function(z)
		c.MakeOptional(z, a.HoldProcs)
		c.MakeMini(z, a.HoldProcs)
		return a.BrainFreeze and not a.HoldForVeins
	end
})

c.AddSpell("Ice Lance", "when Frozen", {
	CheckFirst = function(z)
		c.MakeOptional(z, a.HoldProcs)
		c.MakeMini(z, a.HoldProcs)
		return a.FingerCount > 0
	end
})

c.AddSpell("Ice Lance", "Prime", {
	CheckFirst = function()
		return (a.FingerCount > 0 
				and (a.AlterTime or c.GetBuffDuration("Fingers of Frost") < 2))
			or (a.FingerCount < 2 
				and c.HasDebuff("Deep Freeze", false, false, true))
	end
})

c.AddSpell("Ice Lance", "before Cap", {
	CheckFirst = function(z)
		c.MakeOptional(z, a.HoldProcs)
		c.MakeMini(z, a.HoldProcs)
		return a.FingerCount == 2
			and (c.GetCooldown("Frozen Orb") > 50 
				or c.CountLandings("Frostbolt", -3, 10) > 0
				or c.CountLandings("Frostfire Bolt", -3, 10) > 0)
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
