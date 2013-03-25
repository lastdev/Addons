local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

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
	local myBattle = s.MyBuff(battleID, "player")
	local myCommand = s.MyBuff(commandID, "player")
	if myBattle then
		z.FlashID = battleID
	elseif myCommand then
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

local function rageAfterHeroicStrike()
	if c.GetCooldown("Heroic Strike") == 0 
		and not c.IsCasting("Heroic Strike") then
		
		return a.Rage - 25
	else
		return a.Rage
	end
end

c.AddSpell("Shout", nil, {
	ID = "Battle Shout",
	CheckFirst = chooseShout
})

c.AddSpell("Shout", "for Rage", {
	ID = "Battle Shout",
	CheckFirst = function(z)
		return chooseShout(z, a.EmptyRage < 30)
	end
})

c.AddSpell("Shout", "for Rage unless Colossus Smash", {
	ID = "Battle Shout",
	CheckFirst = function(z)
		return chooseShout(
			z, 
			a.EmptyRage < 30 or c.HasMyDebuff("Colossus Smash"))
	end
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
		return c.GetMyDebuffDuration("Colossus Smash") < 1.5
	end
})

c.AddSpell("Dragon Roar", nil, {
	Melee = true,
})

c.AddSpell("Shockwave", nil, {
	Melee = true,
})

c.AddOptionalSpell("Heroic Leap", nil, {
	NoGCD = true,
	NoRangeCheck = true,
	CheckFirst = function()
		return c.HasMyDebuff("Colossus Smash") and not c.IsSolo()
	end
})

local function victoryHealable()
	if c.GetBuffDuration("Victorious") > 4 then
		if c.HasGlyph("Victory Rush") then
			return s.HealthPercent("player") < 70
		else
			return s.HealthPercent("player") < 80
		end
	else
		return s.HealthPercent("player") < 85
	end
end

c.AddSpell("Impending Victory", nil, {
	Melee = true,
})

c.AddSpell("Impending Victory", "for Heals", {
	Melee = true,
	CheckFirst = victoryHealable,
})

c.AddSpell("Impending Victory", "unless Execute", {
	CheckFirst = function()
		return not a.InExecute
	end
})

c.AddOptionalSpell("Impending Victory", "for Heals, Optional", {
	Melee = true,
	CheckFirst = victoryHealable,
})

c.AddSpell("Victory Rush", nil, {
	Melee = true,
})

c.AddSpell("Victory Rush", "for Heals", {
	Melee = true,
	CheckFirst = victoryHealable,
})

c.AddSpell("Victory Rush", "unless Execute", {
	CheckFirst = function()
		return not a.InExecute
	end
})

c.AddOptionalSpell("Victory Rush", "for Heals, Optional", {
	Melee = true,
	CheckFirst = victoryHealable,
})

c.AddOptionalSpell("Enraged Regeneration", nil, {
	NoGCD = true,
	NoPowerCheck = true,
	CheckFirst = function()
		return a.Enraged and s.HealthPercent("player") < 80
	end,
})

c.AddOptionalSpell("Avatar", nil, {
	NoGCD = true,
	CheckFirst = function()
		local reckCd = c.GetCooldown("Recklessness")
		return reckCd > 42 or reckCd < 6
	end
})

c.AddOptionalSpell("Sunder Armor", nil, {
	CheckFirst = function()
		return s.InRaidOrParty()
			and (c.GetDebuffStack(c.ARMOR_DEBUFFS) < 3
				or c.GetDebuffDuration(c.ARMOR_DEBUFFS) < 3)
	end
})

c.AddInterrupt("Pummel")
c.AddInterrupt("Disrupting Shout")

-------------------------------------------------------------------------- Arms
local function hasSmashFor(time)
	local duration = c.GetMyDebuffDuration("Colossus Smash")
	return duration >= time 
		or c.GetCooldown("Colossus Smash") <= duration
		or not s.HasSpell(c.GetID("Colossus Smash"))
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
		return c.HasBuff("Bloodbath") or hasSmashFor(5)
	end
})

c.AddOptionalSpell("Bloodbath", "for Arms", {
	CheckFirst = function()
		return hasSmashFor(5)
	end
})

c.AddOptionalSpell("Berserker Rage", "for Arms", {
	CheckFirst = function()
		return not a.Enraged and a.EmptyRage >= 10
	end
})

c.AddOptionalSpell("Heroic Strike", "for Arms", {
	NoGCD = true,
	CheckFirst = function()
		return a.EmptyRage <= 15
			or (a.Rage >= 70 
				and not a.InExecute 
				and c.HasMyDebuff("Colossus Smash", true))
	end
})

c.AddSpell("Colossus Smash", "for Arms", {
	CheckFirst = function()
		return c.GetMyDebuffDuration("Colossus Smash") <= 1.5
	end
})

c.AddSpell("Storm Bolt", "for Arms", {
	CheckFirst = function()
		return c.HasMyDebuff("Colossus Smash")
	end
})

c.AddSpell("Execute", "under Smash", {
	CheckFirst = function()
		return c.HasMyDebuff("Colossus Smash")
	end
})

c.AddSpell("Slam", nil, {
	CheckFirst = function()
		return a.Rage >= 40 and not a.InExecute
	end
})

c.AddSpell("Slam", "with High Rage", {
	CheckFirst = function()
		return not a.InExecute
			and s.MaxPower("player") - rageAfterHeroicStrike() <= 30 
	end
})

c.AddSpell("Overpower", nil, {
	Override = function()
		return a.TasteStacks > 0 
			and (a.Rage >= 10
				or c.IsCasting("Execute") 
				or (c.HasBuff("Sudden Execute") 
					and not c.IsCasting("Overpower")))
	end
})

-------------------------------------------------------------------------- Fury
local function shouldFlashBloodthirst()
	return not a.InExecute
		or a.Rage < 30
		or not c.HasMyDebuff("Colossus Smash")
end

c.AddOptionalSpell("Recklessness", "for Fury", {
	CheckFirst = function(z)
		z.FlashSize = nil
		
		if c.IsSolo() or c.WearingSet(4, "DpsT14") then
			return true
		end
		
		if c.HasTalent("Bloodbath") then
			return c.HasBuff("Bloodbath")
		else
			if not a.InExecute then
				z.FlashSize = s.FlashSizePercent() / 2
			end
			return c.GetMyDebuffDuration("Colossus Smash") > 5
				or c.GetCooldown("Colossus Smash") < 2
				or not s.HasSpell(c.GetID("Colossus Smash"))
		end
	end
})

c.AddOptionalSpell("Bloodbath", "for Fury", {
	CheckFirst = function()
		return c.GetMyDebuffDuration("Colossus Smash", true) > 5
			or c.GetCooldown("Colossus Smash") < 2
	end
})

c.AddOptionalSpell("Berserker Rage", "for Fury", {
	CheckFirst = function()
		return (not a.Enraged
				and (c.GetBuffStack("Raging Blow", true) < 2 or a.InExecute))
			or (c.GetBuffDuration("Recklessness", true) > 10 
				and not c.HasBuff("Raging Blow", true))
	end
})

c.AddOptionalSpell("Heroic Strike", "for Fury", {
	NoGCD = true,
	CheckFirst = function()
		return a.EmptyRage <= 10
			or (not a.InExecute
				and rageAfterHeroicStrike() >= 40
				and c.HasMyDebuff("Colossus Smash"))
	end
})

c.AddSpell("Raging Blow", nil, {
	CheckFirst = function()
		return c.GetBuffStack("Raging Blow") == 2
			or c.GetBuffDuration("Raging Blow") < 3
			or c.HasMyDebuff("Colossus Smash")
			or c.GetCooldown("Colossus Smash") > 3
	end
})

c.AddSpell("Raging Blow", "Prime", {
	CheckFirst = function()
		return not a.InExecute
			and c.GetBuffStack("Raging Blow") == 2
			and c.HasMyDebuff("Colossus Smash")
	end
})

c.AddSpell("Bloodthirst", nil, {
	CheckFirst = shouldFlashBloodthirst
})

c.AddSpell("Bloodthirst", "Wait", {
	FlashColor = "green",
	FlashSize = s.FlashSizePercent() / 2,
	Override = function()
		return c.GetCooldown("Bloodthirst") < 1 
			and shouldFlashBloodthirst() 
			and s.MeleeDistance()
	end
})

c.AddSpell("Wild Strike", "before Bloodthirst", {
	NoPowerCheck = true,
	CheckFirst = function()
		return a.Rage >= 10
			and not a.InExecute
			and c.HasBuff("Bloodsurge")
			and c.GetCooldown("Bloodthirst") < 1
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
		return not a.InExecute and c.HasMyDebuff("Colossus Smash")
	end
})

c.AddSpell("Wild Strike", "with High Rage", {
	CheckFirst = function()
		return rageAfterHeroicStrike() >= 80
			and not a.InExecute
			and c.GetCooldown("Colossus Smash") > 2
	end
})

c.AddSpell("Dragon Roar", "for Fury", {
	Melee = true,
	CheckFirst = function()
		return not c.HasMyDebuff("Colossus Smash") 
			and (not c.HasTalent("Bloodbath") or c.HasBuff("Bloodbath"))
	end
})

c.AddSpell("Execute", "for Fury", {
	CheckFirst = function()
		return a.Enraged
			or c.HasMyDebuff("Colossus Smash")
			or c.HasBuff("Recklessness")
			or rageAfterHeroicStrike() > 90
	end
})

c.AddSpell("Heroic Throw", "for Fury", {
	CheckFirst = function()
		return not c.HasMyDebuff("Colossus Smash")
	end
})

-------------------------------------------------------------------- Protection
c.AddOptionalSpell("Defensive Stance", nil, {
	Type = "form",
})

c.AddSpell("No Mitigation if Victory Available", nil, {
	ID = 0,
	RunFirst = function(z)
		if c.HasTalent("Impending Victory") then
			z.ID = c.GetID("Impending Victory")
		else
			z.ID = c.GetID("Victory Rush")
		end
	end,
	ShouldHold = function()
		return true
	end
})

c.AddOptionalSpell("Demoralizing Shout", nil, {
	NoGCD = true,
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
		return s.HealthPercent("player") > 90
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
		return c.IsTanking() and not c.HasBuff("Shield Barrier", true)
	end,
})

c.AddOptionalSpell("Shield Barrier", nil, {
	NoGCD = true,
	CheckFirst = function()
		return c.IsTanking()
			and not c.HasBuff("Shield Barrier", true) 
			and not c.HasBuff("Shield Block", true)
	end,
})

c.AddOptionalSpell("Berserker Rage", "for Prot", {
	NoGCD = true,
	CheckFirst = function()
		return a.EmptyRage > 10 and c.IsTanking()
	end,
})

c.AddOptionalSpell("Heroic Strike", "for free", {
	NoGCD = true,
	CheckFirst = function()
		return c.HasBuff("Ultimatum", true) or c.HasBuff("Incite", true)
	end,
})

c.AddTaunt("Taunt", nil, {
	NoGCD = true,
})

c.AddSpell("Thunder Clap", "for Debuff", {
	Melee = true,
	CheckFirst = function()
		return not c.HasDebuff(c.WEAKENED_BLOWS_DEBUFFS)
	end,
})

c.AddSpell("Thunder Clap", "for Refresh", {
	Melee = true,
	CheckFirst = function()
		return c.GetDebuffDuration(c.WEAKENED_BLOWS_DEBUFFS) < 4
	end,
})

c.AddSpell("Shield Slam", nil, {
	CheckFirst = function()
		if c.HasBuff("Sword and Board") then
			return a.EmptyRage > 25
		else
			return a.EmptyRage > 20
		end
	end,
})

c.AddSpell("Revenge", nil, {
	CheckFirst = function()
		return a.EmptyRage > 15
	end,
})

c.AddSpell("Devestate", nil, {
	Melee = true, -- not sure why this is necessary.
})