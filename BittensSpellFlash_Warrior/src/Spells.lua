local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local x = s.UpdatedVariables
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetTime = GetTime
local math = math

------------------------------------------------------------------------ Common
local bothShouts = { c.GetID("Battle Shout"), c.GetID("Commanding Shout") }
local function chooseShout(z, fail)
	if fail then
		return false
	end
	
	local ap = s.Buff(c.ATTACK_POWER_BUFFS, "player")
	local sta = s.Buff(c.STAMINA_BUFFS, "player")
	local battleID = c.GetID("Battle Shout")
	local commandID = c.GetID("Commanding Shout")
	if s.MyBuff(battleID, "player") then
		z.FlashID = battleID
	elseif s.MyBuff(commandID, "player") then
		z.FlashID = commandID
	elseif ap and sta then
		z.FlashID = bothShouts
	elseif ap then
		z.FlashID = commandID
	elseif sta then
		z.FlashID = battleID
	else
		z.FlashID = bothShouts
	end
	return true
end

local function noRoomForShoutRage()
	if c.HasGlyph("Hoarse Voice") then
		return a.EmptyRage < 15
	else
		return a.EmptyRage < 30
	end
end

local function rageAfterHeroicStrike()
	if c.GetCooldown("Heroic Strike", false, 1.5) == 0 then
		return a.Rage - 30
	else
		return a.Rage
	end
end

c.AddSpell("Shout", nil, {
	ID = "Battle Shout",
	Cooldown = 60,
	CheckFirst = chooseShout
})

c.AddSpell("Shout", "for Rage", {
	ID = "Battle Shout",
	Cooldown = 60,
	CheckFirst = function(z)
		return chooseShout(z, noRoomForShoutRage())
	end
})

c.AddSpell("Shout", "for Rage unless Colossus Smash", {
	ID = "Battle Shout",
	Cooldown = 60,
	CheckFirst = function(z)
		return chooseShout(z, noRoomForShoutRage() or a.Smash > 0)
	end
})

c.AddOptionalSpell("Shout", "for Buff", {
	ID = "Battle Shout",
	Cooldown = 60,
	CheckFirst = function(z)
		if not x.EnemyDetected then
			return false
		end
		
		local ap = c.RaidBuffNeeded(c.ATTACK_POWER_BUFFS)
		local sta = c.RaidBuffNeeded(c.STAMINA_BUFFS)
		local battleID = c.GetID("Battle Shout")
		local commandID = c.GetID("Commanding Shout")
		if s.MyBuff(battleID, "player") then
			z.FlashID = battleID
			return ap
		elseif s.MyBuff(commandID, "player") then
			z.FlashID = commandID
			return sta
		elseif ap and sta then
			z.FlashID = bothShouts
		elseif ap then
			z.FlashID = battleID
		elseif sta then
			z.FlashID = commandID
		else
			return false
		end
		return true
	end,
})

c.AddOptionalSpell("Dps Stance", nil, {
	Type = "form",
	ID = "Battle Stance",
	FlashID = { "Battle Stance", "Berserker Stance" },
	CheckFirst = function()
		return not s.Form(c.GetID("Battle Stance"))
			and not s.Form(c.GetID("Berserker Stance"))
	end
})

c.AddSpell("Colossus Smash", nil, {
	CheckFirst = function()
		return a.Smash < 1.5
	end
})

c.AddSpell("Bladestorm", nil, {
	Melee = true,
	Cooldown = 90,
})

c.AddSpell("Shockwave", nil, {
	Melee = true,
	Cooldown = 40,
})

c.AddSpell("Dragon Roar", nil, {
	Melee = true,
	Cooldown = 60,
})

c.MakeMini(c.AddOptionalSpell("Heroic Leap", nil, {
	NoGCD = true,
	NoRangeCheck = true,
	CheckFirst = function()
		return a.Smash > 0 and not c.IsSolo()
	end
}))

local function victoryHealable()
	if a.VictoriousDuration > 4 
		and c.HasGlyph("Victory Rush") 
		and not c.HasTalent("Impending Victory") then
		
		return c.GetHealthPercent("player") < 70
	else
		return c.GetHealthPercent("player") < 80
	end
end

c.AddSpell("Impending Victory", nil, {
	Melee = true,
	Cooldown = 30,
})

c.AddSpell("Impending Victory", "for Heals", {
	Melee = true,
	Cooldown = 30,
	CheckFirst = victoryHealable,
})

c.AddSpell("Impending Victory", "for Free", {
	Melee = true, 
	Cooldown = 30,
	CheckFirst = function()
		return a.VictoriousDuration > 0
	end
})

c.AddSpell("Impending Victory", "unless Execute", {
	Melee = true, 
	Cooldown = 30,
	CheckFirst = function()
		return not a.InExecute or a.VictoriousDuration > 0
	end
})

c.AddOptionalSpell("Impending Victory", "for Heals, Optional", {
	Melee = true,
	Cooldown = 30,
	CheckFirst = victoryHealable,
})

c.AddSpell("Victory Rush", nil, {
	Melee = true,
	CheckFirst = function()
		return a.VictoriousDuration > 0
	end,
})

c.AddSpell("Victory Rush", "for Heals", {
	Melee = true,
	CheckFirst = function()
		return a.VictoriousDuration > 0 and victoryHealable()
	end,
})

c.AddOptionalSpell("Victory Rush", "for Heals, Optional", {
	Melee = true,
	CheckFirst = function()
		return a.VictoriousDuration > 0 and victoryHealable()
	end,
})

c.AddOptionalSpell("Enraged Regeneration", nil, {
	NoGCD = true,
	NoPowerCheck = true,
	Cooldown = 60,
	CheckFirst = function()
		return a.Enraged and c.GetHealthPercent("player") < 80
	end,
})

c.AddOptionalSpell("Avatar", nil, {
	NoGCD = true,
	CheckFirst = function()
		local reckCd = c.GetCooldown("Recklessness", true, 180)
		return reckCd > 42 or reckCd < 6
	end
})

c.AddOptionalSpell("Sunder Armor", nil, {
	CheckFirst = function()
		return not c.IsSolo()
			and (c.GetDebuffStack(c.ARMOR_DEBUFFS) < 3
				or c.GetDebuffDuration(c.ARMOR_DEBUFFS) < 3)
	end
})

c.AddInterrupt("Pummel")
c.AddInterrupt("Disrupting Shout")

-------------------------------------------------------------------------- Arms
local function hasSmashFor(time)
	return a.Smash >= time 
		or a.SmashCD <= a.Smash
		or not c.HasSpell("Colossus Smash")
end

c.AddOptionalSpell("Recklessness", "for Arms", {
	CheckFirst = function(z)
		z.FlashSize = nil
		
		if c.IsSolo() or c.WearingSet(4, "DpsT14") then
			return true
		end
		
		if not a.InExecute then
			z.FlashSize = s.FlashSizePercent() / 2
		end
		return a.Bloodbath or hasSmashFor(5)
	end
})

c.AddOptionalSpell("Bloodbath", "for Arms", {
	NoGCD = true,
	CheckFirst = function()
		return hasSmashFor(5)
	end
})

c.AddOptionalSpell("Berserker Rage", "for Arms", {
	NoGCD = true,
	CheckFirst = function()
		return not a.Enraged and a.EmptyRage >= 10
	end
})

c.AddOptionalSpell("Heroic Strike", "for Arms", {
	NoGCD = true,
	CheckFirst = function()
		return not a.InExecute
			and (a.EmptyRage < 15
				or (a.EmptyRage < 40 
					and c.HasMyDebuff("Colossus Smash", true, false, true)))
	end
})

c.AddOptionalSpell("Cleave", "for Arms", {
	NoGCD = true,
	CheckFirst = function()
		return a.EmptyRage < 10
	end,
})

c.AddOptionalSpell("Sweeping Strikes", nil, {
	NoGCD = true,
})

c.AddSpell("Mortal Strike", nil, {
	Melee = true,
	Override = function()
		local cd = c.GetCooldown("Mortal Strike", false, 6)
		if c.IsCasting("Overpower") then
			return cd <= .5
		else
			return cd == 0
		end
	end,
})

c.AddSpell("Storm Bolt", "for Arms", {
	CheckFirst = function()
		return a.Smash > 0
	end
})

c.AddSpell("Dragon Roar", "for Arms", {
	Melee = true,
	CheckFirst = function()
		return a.Smash == 0 or a.Bloodbath
	end,
})

c.AddSpell("Dragon Roar", "Prime for Arms", {
	Melee = true,
	CheckFirst = function()
		return not a.InExecute and a.Smash == 0 and a.Bloodbath
	end,
})

c.AddSpell("Colossus Smash", "for Arms", {
	CheckFirst = function()
		return a.Smash <= 1.5
	end
})

c.AddSpell("Execute", "Prime for Arms", {
	CheckFirst = function()
		return a.Smash > 0
			or s.MaxPower("player") - rageAfterHeroicStrike() < 25
			or c.HasBuff("Recklessness", false, false, true)
	end
})

c.AddSpell("Slam", nil, {
	CheckFirst = function()
		return a.Rage >= 40 and not a.InExecute
	end
})

c.AddSpell("Slam", "Prime", {
	CheckFirst = function()
		return a.Smash > 0
			and a.Smash < 2.5
			and not a.InExecute
	end
})

c.AddSpell("Slam", "Double Prime", {
	CheckFirst = function()
		return not a.InExecute and a.Smash > 0 and a.Smash < 1
	end
})

c.AddSpell("Overpower", "at 3", {
	SpecialGCD = 1,
	Melee = true,
	Override = function()
		return a.CanOverpower and a.TasteStacks >= 3 and not a.InExecute
	end
})

c.AddSpell("Overpower", "unless Execute", {
	SpecialGCD = 1,
	Melee = true,
	Override = function()
		return a.CanOverpower and (a.OverpowerIsFree or a.InExecute)
	end
})

c.AddSpell("Overpower", "AoE", {
	SpecialGCD = 1,
	Melee = true,
	Override = function()
		return a.CanOverpower and a.Rage >= 40
	end
})

c.AddSpell("Thunder Clap", nil, {
	Melee = true,
})

c.AddSpell("Whirlwind", "for Arms", {
	Melee = true,
	CheckFirst = function()
		return a.Rage >= 90
	end,
})

-------------------------------------------------------------------------- Fury
local function shouldFlashBloodthirst()
	return (not a.InExecute 
			or a.Rage < 30 
			or a.Smash == 0)
		and not c.IsCasting("Bloodthirst")
end

local function getRagingBlowStacks(noGCD)
	local stacks = c.GetBuffStack("Raging Blow!", noGCD)
	if c.IsCasting("Enrage") then
		stacks = stacks + 1
	end
	if c.IsCasting("Raging Blow") then
		stacks = stacks - 1
	end
	return math.min(math.max(0, stacks), 2)
end

c.AddOptionalSpell("Recklessness", "for Fury", {
	NoGCD = true,
	CheckFirst = function(z)
		z.FlashSize = nil
		
		if c.IsSolo() or c.WearingSet(4, "DpsT14") then
			return true
		end
		
		if c.HasTalent("Bloodbath") then
			return a.Bloodbath
		else
			if not a.InExecute then
				z.FlashSize = s.FlashSizePercent() / 2
			end
			return a.Smash > 5
				or a.SmashCD < 2
				or not c.HasSpell("Colossus Smash")
		end
	end
})

c.AddOptionalSpell("Bloodbath", "for Fury", {
	NoGCD = true,
	CheckFirst = function()
		return a.Smash > 5 or a.SmashCD < 2
	end
})

c.AddOptionalSpell("Berserker Rage", "for Fury", {
	NoGCD = true,
	CheckFirst = function()
		local blowStacks = getRagingBlowStacks(true)
		return (not a.Enraged and (blowStacks < 2 or a.InExecute))
			or (c.GetBuffDuration("Recklessness", true, true) > 10 
				and blowStacks == 0)
	end
})

c.AddOptionalSpell("Heroic Strike", "for Fury", {
	NoGCD = true,
	CheckFirst = function()
		return a.EmptyRage <= 10
			or (not a.InExecute and a.Rage >= 40 and a.Smash > 0)
	end
})

c.AddOptionalSpell("Cleave", "for Fury", {
	NoGCD = true,
	CheckFirst = function()
		return a.EmptyRage <= 10
	end
})

c.AddSpell("Raging Blow", nil, {
	CheckFirst = function()
		local stacks = getRagingBlowStacks()
		return stacks > 0
			and (stacks == 2
				or c.GetBuffDuration("Raging Blow") < 3
				or a.Smash > 0
				or a.SmashCD > 3)
	end
})

c.AddSpell("Raging Blow", "Prime", {
	CheckFirst = function()
		return not a.InExecute
			and a.Smash > 0
			and getRagingBlowStacks() == 2
	end
})

c.AddSpell("Raging Blow", "AoE", {
	CheckFirst = function()
		local now = GetTime()
		if c.IsCasting("Raging Blow") or now - a.CleaverDumpPending < .8 then
			return false
		end
		
		local stack = c.GetBuffStack("Meat Cleaver")
		if GetTime() - a.CleaverPending < .8 then
			stack = stack + 1
		end
		return stack >= 3
	end
})

c.AddSpell("Bloodthirst", nil, {
	CheckFirst = shouldFlashBloodthirst
})

c.MakePredictor(c.AddSpell("Bloodthirst", "Wait", {
	Melee = true,
	Override = function()
		return c.GetCooldown("Bloodthirst") < 1 and shouldFlashBloodthirst() 
	end
}))

c.AddSpell("Wild Strike", "before Bloodthirst", {
	NoPowerCheck = true,
	SpecialGCD = 1,
	CheckFirst = function()
		return a.Rage >= 10
			and not a.InExecute
			and c.HasBuff("Bloodsurge")
			and c.GetCooldown("Bloodthirst", false, 4.5) < 1
	end
})

c.AddSpell("Wild Strike", "under Bloodsurge", {
	NoPowerCheck = true,
	CheckFirst = function()
		return a.Rage >= 10 and c.HasBuff("Bloodsurge")
	end
})

c.AddSpell("Wild Strike", "under Colossus Smash", {
	CheckFirst = function()
		return not a.InExecute and a.Smash > 0
	end
})

c.AddSpell("Wild Strike", "with High Rage", {
	CheckFirst = function()
		return rageAfterHeroicStrike() >= 80
			and not a.InExecute
			and a.SmashCD > 2
	end
})

c.AddSpell("Dragon Roar", "for Fury", {
	Melee = true,
	CheckFirst = function()
		return a.Smash == 0 and (not c.HasTalent("Bloodbath") or a.Bloodbath)
	end
})

c.AddSpell("Execute", "for Fury", {
	CheckFirst = function()
		return a.Enraged
			or a.Smash > 0
			or c.HasBuff("Recklessness", false, false, true)
			or rageAfterHeroicStrike() > 90
			or c.IsSolo()
	end
})

c.AddSpell("Heroic Throw", "for Fury", {
	Cooldown = 30,
	CheckFirst = function()
		return a.Smash == 0
	end
})

c.AddSpell("Whirlwind", "for Fury", {
	Melee = true,
	Override = function()
		return a.Rage >= 30
	end,
})

-------------------------------------------------------------------- Protection
local function shouldDumpProt()
	return c.HasBuff("Ultimatum", true) 
		or c.HasBuff("Incite", true)
		or (c.HasGlyph("Incite") and c.IsCasting("Demoralizing Shout"))
		or (a.EmptyRage < 20 and not c.IsTanking())
		or c.InDamageMode()
end

c.AddOptionalSpell("Defensive Stance", nil, {
	Type = "form",
})

c.AddSpell("No Mitigation if Victory Available", nil, {
	ID = 0,
	RunFirst = function(z)
		z.ID = c.HasTalent("Impending Victory")
			and c.GetID("Impending Victory")
			or c.GetID("Victory Rush")
	end,
	ShouldHold = function()
		return true
	end
})

c.AddOptionalSpell("Demoralizing Shout", nil, {
	NoGCD = true,
	Melee = true,
	IsUp = function()
		return c.HasMyDebuff("Demoralizing Shout", true)
	end,
	CheckFirst = function(z)
		return not z.IsUp()
	end,
})

c.AddOptionalSpell("Enraged Regeneration", "for Prot", {
	NoGCD = true,
	NoPowerCheck = true,
	CheckFirst = function()
		return a.Enraged
	end,
	ShouldHold = function()
		return c.GetHealthPercent("player") > 90
	end,
})

c.AddOptionalSpell("Shield Wall", "under 3 min", {
	NoGCD = true,
	Enabled = function()
		return not c.HasGlyph("Shield Wall")
	end,
})

c.AddOptionalSpell("Shield Wall", "3+ min", {
	NoGCD = true,
	Enabled = function()
		return c.HasGlyph("Shield Wall")
	end,
})

c.AddOptionalSpell("Last Stand", nil, {
	NoGCD = true,
	ShouldHold = function()
		return s.HealthPercent("player") > 70
	end
})

c.AddOptionalSpell("Shield Block", nil, {
	NoGCD = true,
	Melee = true,
	CheckFirst = function()
		return c.IsTanking() 
			and not c.HasBuff("Shield Barrier", true)
			and not c.InDamageMode()
	end,
})

c.AddOptionalSpell("Shield Barrier", nil, {
	NoGCD = true,
	CheckFirst = function()
		return c.IsTanking()
			and not c.HasBuff("Shield Barrier", true) 
			and not c.HasBuff("Shield Block", true)
			and not c.InDamageMode()
	end,
})

c.AddOptionalSpell("Berserker Rage", "for Prot", {
	NoGCD = true,
	Cooldown = 30,
	CheckFirst = function()
		return a.EmptyRage > 10 and (c.IsTanking() or c.InDamageMode())
	end,
})

c.AddOptionalSpell("Heroic Strike", "for Prot", {
	NoGCD = true,
	CheckFirst = function()
		return not c.AoE and shouldDumpProt()
	end,
})

c.AddOptionalSpell("Cleave", "for Prot", {
	NoGCD = true,
	CheckFirst = function()
		return c.AoE and shouldDumpProt()
	end,
})

c.AddTaunt("Taunt", nil, {
	NoGCD = true,
	Cooldown = 6,
})

c.AddSpell("Thunder Clap", "for Debuff", {
	Melee = true,
	Cooldown = 6,
	CheckFirst = function()
		local debuffNeeded = not c.HasDebuff(c.WEAKENED_BLOWS_DEBUFFS)
		local damageMode = c.InDamageMode()
		if c.AoE then
			return debuffNeeded or damageMode
		else
			return debuffNeeded and not damageMode
		end
	end,
})

c.AddSpell("Thunder Clap", "for Refresh", {
	Melee = true,
	Cooldown = 6,
	CheckFirst = function()
		return c.GetDebuffDuration(c.WEAKENED_BLOWS_DEBUFFS) < 4 or c.AoE
	end,
})

c.AddSpell("Shield Slam", nil, {
	Cooldown = 6,
	CheckFirst = function()
		if c.InDamageMode() then
			return true
		end
		
		if c.HasBuff("Sword and Board") then
			return a.EmptyRage > 25
		else
			return a.EmptyRage > 20
		end
	end,
})

c.AddSpell("Revenge", nil, {
	Melee = true,
	GetDelay = function()
		return (a.EmptyRage > 15 or c.InDamageMode())
			and (GetTime() - a.RevengeReset < .8
				and 0
				or c.GetCooldown("Revenge", false, 9))
	end,
})

c.AddSpell("Delay for Prot Rage Generator", nil, {
	ID = "Battle Shout",
	IsMinDelayDefinition = true,
	GetDelay = function()
		return math.min(
				c.GetCooldown("Shield Slam", false, 6), 
				c.GetCooldown("Revenge", false, 9),
				c.GetCooldown("Battle Shout", false, 60)), 
			c.InDamageMode() and .2 or .5
	end,
})

c.AddSpell("Devestate", nil, {
	Melee = true, -- not sure why this is necessary.
})

c.AddSpell("Devestate", "for Debuff unless AoE", {
	Melee = true, -- not sure why this is necessary.
	CheckFirst = function()
		local stack = c.GetDebuffStack(c.ARMOR_DEBUFFS)
		local duration
		if c.IsCasting("Devestate") then
			stack = stack + 1
			duration = 30
		else
			duration = c.GetDebuffDuration(c.ARMOR_DEBUFFS)
		end
		return (stack < 3 or duration < 3) and not c.AoE
	end,
})
