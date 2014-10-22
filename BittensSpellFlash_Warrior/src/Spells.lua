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
	FlashID = { "Battle Stance"},
	CheckFirst = function()
		return not s.Form(c.GetID("Battle Stance"))			
	end
})

--Arms  only
--Colossus Smashes a target for 225% Physical damage and costs 20 rageccf.
c.AddSpell("Colossus Smash", nil, {
})

--TALENT:
--You become a whirling storm of destructive force, striking 
--all targets within 8 yards for 120% weapon damage every 1 sec 
--for 6 sec.
--During a Bladestorm, you can continue to dodge, block, and parry, 
--and are immune to movement impairing and loss of control effects. 
--However, you can only perform shout abilities.
c.AddSpell("Bladestorm", nil, {
	Melee = true,
	Cooldown = 90,
})
--TALENT"
--Sends a wave of force in a frontal cone before you, 
--causing (75 / 100 * Attack power) damage and stunning 
--all enemy targets within 10 yards for 4 sec.
--Causing damage to 3 or more targets lowers the cooldown 
--of the next Shockwave by 20 sec.
c.AddSpell("Shockwave", nil, {
	Melee = true,
	Cooldown = 40,
})

--TALENT:
--Roar ferociously, causing 126 (+ 140% of Attack power) 
--damage to all enemies within 8 yards, knocking them back 
--and knocking them down for 0.50 sec. Dragon Roar is always 
--a critical strike and ignores all armor on the target.
c.AddSpell("Dragon Roar", nil, {
	Melee = true,
	Cooldown = 60,
})

--SPELL:
--Leap through the air towards a targeted location, slamming 
--down with destructive force to deal 1 (+ 50% of Attack power) 
--Physical damage to all enemies within 8 yards.
c.MakeMini(c.AddOptionalSpell("Heroic Leap", nil, {
	NoGCD = true,
	Cooldown = 45,
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

--TALENTS:
--Instantly attack the target, causing (200% of Attack power) 
--damage and healing you for 15% of your maximum health.
--Killing an enemy that yields experience or honor resets 
--the cooldown of Impending Victory.
--Replaces Victory Rush.
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

--TALENT:
--Instantly heals you for 10% of your maximum health, 
--and an additional 20% over 5 sec.  Usable while stunned.
--c.AddOptionalSpell("Enraged Regeneration", nil, {
--	NoGCD = true,
--	NoPowerCheck = true,
--	Cooldown = 60,
--	CheckFirst = function()
--		return a.Enraged and c.GetHealthPercent("player") < 80
--	end,
--})

--TALENT:
--Every 30 rage that you spend reduces the remaining cooldown 
--of several of your abilities by 1 sec:
--  Avatar
--  Bloodbath
--  Bladestorm
--  Storm Bolt
--  Shockwave
--  Dragon Roar
--  Mocking Banner
--  Heroic Leap
--  Recklessness
--  Die by the Sword
c.AddOptionalSpell("Anger Management", nil, {
  NoGCD = true,
})

--TALENT:  Associated Buff: Avatar
--Transform into a colossus for 24 sec, dealing 20% 
--increased damage and removing all roots and snares.
c.AddOptionalSpell("Avatar", nil, {
	NoGCD = true,
	Cooldown = 180,
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
		return (a.EmptyRage < 15 and not a.InExecute)
			or (a.Smash > 0 and a.Rage > 60 and c.WearingSet(2, "DpsT16"))
	end
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
		return a.Bloodbath
	end,
})

c.AddSpell("Dragon Roar", "Prime for Arms", {
	Melee = true,
	CheckFirst = function()
		return a.Smash == 0
	end,
})

c.AddSpell("Colossus Smash", "for Arms", {
	CheckFirst = function()
		return a.Smash <= 1.5
	end
})

c.AddSpell("Execute", "for Arms", {
	CheckFirst = function()
		return not a.OverpowerIsFree
			or a.TasteStacks == 0
			or a.Recklessness
			or a.EmptyRage < 25
			or (a.Smash > 0 and not c.WearingSet(2, "DpsT16"))
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
		return not a.InExecute 
			and a.Smash > 0 
			and (a.Smash < 1 or c.HasBuff("Recklessness", false, true))
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
-- 

local function shouldFlashBloodthirst()
	return (not a.InExecute)
		and not c.IsCasting("Bloodthirst")
end

local function getRagingBlowStacks(noGCD)
	local stacks = c.GetBuffStack("Raging Blow!", noGCD)
	if c.IsCasting("Enrage") then
		stacks = stacks + 1
		c.Debug("Event","Casting Enrage")
	end
	if c.IsCasting("Raging Blow") then
		stacks = stacks - 1
		c.Debug("Event","Casting Raging Blow")
	end
	local str = tostring(math.min(math.max(0, stacks), 2))
	c.Debug("Event Stacks",str)
	return math.min(math.max(0, stacks), 2)
end

--10122014 rdh: Changed the return to true and added Cooldown
c.AddOptionalSpell("Recklessness", "for Fury", {
	NoGCD = true,
	Cooldown = 180,
	CheckFirst = function(z)
		z.FlashSize = nil
		
		if c.HasTalent("Bloodbath") then
			return a.Bloodbath
		else
			if not a.InExecute then
				z.FlashSize = s.FlashSizePercent() / 2
			end
		end
		
		if c.IsSolo() or c.WearingSet(4, "DpsT16") then
      return true
    end
	end
})

c.AddOptionalSpell("Bloodbath", "for Fury", {
	NoGCD = true,
	Cooldown = 60,
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

c.AddSpell("Raging Blow", nil, {
	Override = function(z)
	  z.FlashSize = nil
		local stacks = getRagingBlowStacks()
		if stacks == 2 then
		  z.FlashSize = s.FlashSizePercent() * 2
		  return true
		end
		
		if stacks == 1 then
		  z.FlashSize = s.FlashSizePercent() * 0.5
		  return true
		end
	end
})

c.AddSpell("Raging Blow", "Prime", {
	CheckFirst = function()
	c.Debug("Event","Raging Blow Prime call")
		return not a.InExecute
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
		return c.HasTalent("Unquenchable Thirst") and c.GetCooldown("Bloodthirst") < 1 and shouldFlashBloodthirst() 
	end
}))

c.AddSpell("Wild Strike", nil, {  
  NoPowerCheck = true,
  CheckFirst = function(z)
    z.FlashSize = nil
    if c.HasBuff("Bloodsurge") then
      c.Debug("Event","Bloodsurge Buffed")
      z.FlashSize = s.FlashSizePercent() * 2
      return a.Rage >= 10
    else
      c.Debug("Event","NOT Bloodsurge")
      z.FlashSize = s.FlashSizePercent() * 0.5
      return a.Rage >= 45 and (getRagingBlowStacks() < 2)
    end
  end
})

c.AddSpell("Wild Strike", "under Bloodsurge", {  
	NoPowerCheck = true,
	CheckFirst = function(z)
	  z.FlashSize = nil
	  if c.HasBuff("Bloodsurge") then
	    z.FlashSize = s.FlashSizePercent() * 2
	    return a.Rage >= 10
	  else
	    z.FlashSize = s.FlashSizePercent() * 0.5
	    return a.Rage >= 80
	  end
	end
})

c.AddSpell("Wild Strike", "with High Rage", {
	CheckFirst = function()
		return a.Rage >= 80
	end
})

--10122014 rdh: Removed reference to Smash
--Deals 1,371 damage to all enemies within 8 yards and knocking 
--them back and down for .5 sec.  Damage ignores all armor and is 
--always a critical strike.
c.AddSpell("Dragon Roar", "for Fury", {
	Melee = true,
	CheckFirst = function()
--		return a.Smash == 0 and (not c.HasTalent("Bloodbath") or a.Bloodbath)
    return (not c.HasTalent("Bloodbath") or a.Bloodbath)
	end
})

--10122014 rdh: Changed rage check from 90 to 30
--   Removed a.smash since Colossus Smash has been removed.
--Attempt to finish off a wounded foe, causing
--3,237 Physical damage with main-hand and 969 
--Physical damage with off-hand.  Only usable on 
--enemies with less than 20% health.
c.AddSpell("Execute", "for Fury", {
	CheckFirst = function()
		return a.Enraged
--			or a.Smash > 0
			or c.HasBuff("Sudden Death", false, false, true)
--			or rageAfterHeroicStrike() > 90
      or a.Rage > 30
--			or c.IsSolo()
	end
})

--10122014 rdh: Changed Cooldown from 30 to 6
--  Removed the Smash return, not necessary
--Throw weapon at the enemy, causing 510 Physical damage.
--Generates high threat.
--Note: What does Smash have to do with Heroic Throw?
c.AddSpell("Heroic Throw", "for Fury", {
	Cooldown = 6,
--	CheckFirst = function()
--		return a.Smash == 0
--	end
})

--In a whirlwind of steel you attack all enemies within 8 yards 
--causing 815 Physical damage with main-hand and 238 Physical 
--damage with off-hand to each enemy.  Dealing damage with Whirlwind 
--increases the number of targets that your Raging Blow hits by 1.
--Note:  What is the Override return?
--stacking up to 3.
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

--10122014 rdh: Added Cooldown
--Demoralizes all enemies within 10 yards, reducing the
--damage they do to you by 20% for 8 sec.
c.AddOptionalSpell("Demoralizing Shout", nil, {
	NoGCD = true,
	Melee = true,
	Cooldown = 60,
	IsUp = function()
		return c.HasMyDebuff("Demoralizing Shout", true)
	end,
	CheckFirst = function(z)
		return not z.IsUp()
	end,
})

--10122014 rdh:  Removed for Prot,and added Cooldown
--Instantly heals for 10% of your maximum health, and an additional
--20% over 5 sec.  Usable while stunned.
--c.AddOptionalSpell("Enraged Regeneration", "for Prot", {
c.AddOptionalSpell("Enraged Regeneration", nil, {
	NoGCD = true,
	NoPowerCheck = true,
	Cooldown = 60,
	CheckFirst = function()
		return a.Enraged
	end,
	ShouldHold = function()
		return c.GetHealthPercent("player") > 90
	end,
})

--Reduces all damage taken by 40% for 8 sec.
c.AddOptionalSpell("Shield Wall", "under 3 min", {
	NoGCD = true,
	Enabled = function()
		return not c.HasGlyph("Shield Wall")
	end,
})

--Reduces all damage taken by 40% for 8 sec.
c.AddOptionalSpell("Shield Wall", "3+ min", {
	NoGCD = true,
	Enabled = function()
		return c.HasGlyph("Shield Wall")
	end,
})

--10122014 rdh: Added cooldown
--Note: Confused about the return value.
--Increases Current and Maximum health by 30% for 15 sec.
c.AddOptionalSpell("Last Stand", nil, {
	NoGCD = true,
	Cooldown = 180,
	ShouldHold = function()
		return s.HealthPercent("player") > 70
	end
})

--10122014 rdh: Removed Tanking check and added Rage check
--Raise our shield blocking every melee attack for the next 6 seconds.
--These can be critical blocks.  Maximum 2 charges.
c.AddOptionalSpell("Shield Block", nil, {
	NoGCD = true,
	Melee = true,
	CheckFirst = function()
--		return c.IsTanking() 
    return a.Rage > 60
			and not c.HasBuff("Shield Barrier", true)
			and not c.InDamageMode()
	end,
})

--10122014 rdh: Removed the tanking check
--Raise our shield absorbing  899 damage for the next 6 seconds.
--Consumes up to 40 additional Rage to increase the damage taken.
--Note: WoD allows this on ALL Warriors. Confused how this works 
--      with Fury and Arms.
c.AddOptionalSpell("Shield Barrier", nil, {
	NoGCD = true,
	Cooldown = 1.38,
	CheckFirst = function()
--		return c.IsTanking()
--			and not c.HasBuff("Shield Barrier", true) 
--			and not c.HasBuff("Shield Block", true)
--			and not c.InDamageMode()
    return not c.HasBuff("Shield Barrier", true) 
      and not c.HasBuff("Shield Block", true)
      and not c.InDamageMode()
	end,
})

--10122014 rdh: Removed Rage check
--You go berserk, removing and granting immunity to Fear,
--Sap, and Incapacitate effects for 6 sec.
c.AddOptionalSpell("Berserker Rage", "for Prot", {
	NoGCD = true,
	Cooldown = 30,
	CheckFirst = function()
--		return a.EmptyRage > 10 and (c.IsTanking() or c.InDamageMode())
    return (c.IsTanking() or c.InDamageMode())
	end,
})

-- 10122014 rdh: Added the cooldown and Rage check
--Instantly deals 1,071 Physical damage.  Not on Global cooldown.
c.AddOptionalSpell("Heroic Strike", "for Prot", {
	NoGCD = true,
	Cooldown = 1.38,
	CheckFirst = function()
		return a.EmptyRage > 30 and not c.AoE and shouldDumpProt()
	end,
})

--10122014 rdh: Obsolete for Wod
--c.AddOptionalSpell("Cleave", "for Prot", {
--	NoGCD = true,
--	CheckFirst = function()
--		return c.AoE and shouldDumpProt()
--	end,
--})

c.AddTaunt("Taunt", nil, {
	NoGCD = true,
	Cooldown = 6,
})

--10122014 rdh: Removed Weakend_Blows and changed cooldown from 6 to 5.54
c.AddSpell("Thunder Clap", "for Debuff", {
	Melee = true,
	Cooldown = 5.54,
	CheckFirst = function()
--		local debuffNeeded = not c.HasDebuff(c.WEAKENED_BLOWS_DEBUFFS)
		local damageMode = c.InDamageMode()
		if c.AoE then
--			return debuffNeeded or damageMode
			return damageMode
		else
--			return debuffNeeded and not damageMode
      return not damageMode
		end
	end,
})

c.AddSpell("Thunder Clap", "for Refresh", {
	Melee = true,
	Cooldown = 5.54,
	CheckFirst = function()
--		return c.GetDebuffDuration(c.WEAKENED_BLOWS_DEBUFFS) < 4 or c.AoE
    return c.AoE
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
