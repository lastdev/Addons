local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetPowerRegen = GetPowerRegen
local GetTime = GetTime
local UnitPowerMax = UnitPowerMax
local math = math
local select = select
local string = string
local tostring = tostring

a.Rotations = {}

local function t15RageBump(amount)
	if c.WearingSet(4, "ProtT15") 
		and s.Debuff(c.GetID("Demoralizing Shout")) then
		
		a.Rage = a.Rage + 1.5 * amount
	else
		a.Rage = a.Rage + amount
	end
end

local smashPending = 0

local monitorSmashPending = function(info)
	if c.InfoMatches(info, "Colossus Smash") then
		smashPending = GetTime()
		c.Debug("Event", "Colossus Smash Pending")
	end
end

local monitorSmashApplied = function(spellID)
	if c.IdMatches(spellID, "Colossus Smash") then
		smashPending = 0
		c.Debug("Event", "Colossus Smash Applied")
	end
end

function a.PreFlash()
	a.InExecute = s.HealthPercent() <= 20
	a.Rage = c.GetPower(0)
	a.Enraged = c.HasBuff("Enrage", true)
	if c.IsQueued("Berserker Rage") then
		a.Rage = a.Rage + 10
		a.Enraged = true
	end
	if c.IsQueued("Charge") then
		t15RageBump(20)
	end		
	if c.IsQueued("Bloodthirst", "Mortal Strike") then
		a.Rage = a.Rage + 10
	elseif c.IsQueued("Battle Shout", "Commanding Shout") then
		a.Rage = a.Rage + 20
	elseif c.IsQueued("Shield Slam") then
		if s.Buff(c.GetID("Sword and Board"), "player") then
			t15RageBump(25)
		else
			t15RageBump(20)
		end
	elseif c.IsQueued("Revenge") then
		t15RageBump(15)
	end
	local max = UnitPowerMax("player")
	a.Rage = math.min(max, a.Rage)
	a.EmptyRage = max - a.Rage
	
	if c.IsCasting("Colossus Smash") or GetTime() - smashPending < .8 then
		a.Smash = 6
	else
		a.Smash = c.GetMyDebuffDuration("Colossus Smash", false, 6)
	end
	a.SmashCD = c.GetCooldown("Colossus Smash", false, 20)
	
	if c.IsCasting("Victory Rush", "Impending Victory") then
		a.VictoriousDuration = 0
	else
		a.VictoriousDuration = c.GetBuffDuration("Victorious")
	end
	
	a.Bloodbath = c.HasBuff("Bloodbath", false, false, true)
end

-------------------------------------------------------------------------- Arms
local tastePending = 0

a.Rotations.Arms = {
	Spec = 1,
	
	UsefulStats = { "Strength", "Melee Hit", "Crit", "Haste" },
	
	FlashInCombat = function()
		a.TasteStacks = c.GetBuffStack("Taste for Blood")
		if c.IsCasting("Mortal Strike") or GetTime() - tastePending < .8 then
			a.TasteStacks = a.TasteStacks + 2
		elseif c.IsCasting("Overpower") then
			a.TasteStacks = a.TasteStacks - 1
		end
		
		a.OverpowerIsFree = c.HasBuff("Sudden Execute", false, false, "Execute")
		a.CanOverpower = 
			a.TasteStacks > 0 and (a.Rage >= 10 or a.OverpowerIsFree)
		
		c.FlashAll(
			"Recklessness for Arms",
			"Avatar",
			"Bloodbath",
			"Berserker Rage for Arms",
			"Heroic Leap",
			"Impending Victory for Heals, Optional",
			"Victory Rush for Heals, Optional",
			"Enraged Regeneration",
			"Sunder Armor",
			"Pummel",
			"Disrupting Shout")
		if c.AoE then
			c.FlashAll("Cleave for Arms", "Sweeping Strikes")
			c.PriorityFlash(
				"Mortal Strike",
				"Bladestorm",
				"Shockwave",
				"Dragon Roar",
				"Thunder Clap",
				"Whirlwind for Arms",
				"Colossus Smash",
				"Overpower AoE",
				"Shout for Rage",
				"Storm Bolt",
				"Heroic Throw")
		else
			c.FlashAll("Heroic Strike for Arms")
			c.PriorityFlash(
				"Mortal Strike",
				"Storm Bolt for Arms",
				"Dragon Roar Prime for Arms",
				"Colossus Smash for Arms",
				"Execute for Arms",
				"Dragon Roar for Arms",
				"Slam Double Prime",
				"Overpower Prime",
				"Slam Prime",
				"Overpower",
				"Slam",
				"Shout for Rage",
				"Shockwave",
				"Impending Victory for Free",
				"Victory Rush",
				"Heroic Throw")
		end
	end,
	
	FlashAlways = function()
		c.FlashAll("Dps Stance", "Shout for Buff")
	end,
	
	CastSucceeded = function(info)
		if c.InfoMatches(info, "Mortal Strike") then
			tastePending = GetTime()
			c.Debug("Event", "Taste for Blood pending")
		else
			monitorSmashPending(info)
		end
	end,
	
	AuraApplied = function(spellID)
		if c.IdMatches(spellID, "Taste for Blood") then
			tastePending = 0
			c.Debug("Event", "Taste for Blood applied")
		else
			monitorSmashApplied(spellID)
		end
	end,
	
	ExtraDebugInfo = function()
		return string.format("b:%.1f r:%d e:%s e:%s t:%d o:%s f:%s s:%.1f", 
			c.GetBusyTime(), 
			a.Rage, 
			tostring(a.InExecute), 
			tostring(not not a.Enraged), 
			a.TasteStacks,
			tostring(a.CanOverpower),
			tostring(a.OverpowerIsFree),
			a.Smash)
	end,
}

-------------------------------------------------------------------------- Fury
a.CleaverPending = 0
a.CleaverDumpPending = 0

a.Rotations.Fury = {
	Spec = 2,
	
	UsefulStats = { "Strength", "Melee Hit", "Crit", "Haste" },
	
	FlashInCombat = function()
		c.FlashAll(
			"Recklessness for Fury",
			"Avatar",
			"Bloodbath for Fury",
			"Berserker Rage for Fury",
			"Heroic Leap",
			"Impending Victory for Heals, Optional",
			"Victory Rush for Heals, Optional",
			"Enraged Regeneration",
			"Sunder Armor",
			"Pummel",
			"Disrupting Shout")
		if c.AoE then
			c.FlashAll("Cleave for Fury")
			c.PriorityFlash(
				"Dragon Roar",
				"Shockwave",
				"Bladestorm",
				"Bloodthirst",
				"Colossus Smash",
				"Raging Blow AoE",
				"Whirlwind",
				"Shout for Rage",
				"Storm Bolt",
				"Heroic Throw")
		else
			c.FlashAll("Heroic Strike for Fury")
			c.PriorityFlash(
				"Raging Blow Prime",
				"Bloodthirst",
				"Wild Strike before Bloodthirst",
				"Bloodthirst Wait",
				"Dragon Roar for Fury",
				"Colossus Smash",
				"Execute for Fury",
				"Storm Bolt",
				"Raging Blow",
				"Wild Strike under Bloodsurge",
				"Shockwave",
				"Heroic Throw for Fury",
				"Shout for Rage unless Colossus Smash",
				"Wild Strike under Colossus Smash",
				"Impending Victory unless Execute",
				"Victory Rush",
				"Wild Strike with High Rage",
				"Shout for Rage")
		end
	end,
	
	FlashAlways = function()
		c.FlashAll("Dps Stance", "Shout for Buff")
	end,
	
	CastSucceeded = function(info)
		if c.InfoMatches(info, "Whirlwind") then
			a.CleaverPending = GetTime()
			c.Debug("Event", "Meat Cleaver Pending")
		elseif c.InfoMatches(info, "Raging Blow") then
			a.CleaverDumpPending = GetTime()
			c.Debug("Event", "Meat Cleaver Spend Pending")
		else
			monitorSmashPending(info)
		end
	end,
	
	AuraApplied = function(spellID)
		if c.IdMatches(spellID, "Meat Cleaver") then
			a.CleaverPending = 0
			c.Debug("Event", "Meat Cleaver Applied")
		else
			monitorSmashApplied(spellID)
		end
	end,
	
	AuraRemoved = function(spellID)
		if c.IdMatches(spellID, "Meat Cleaver") then
			a.CleaverDumpPending = 0
			c.Debug("Event", "Meat Cleaver Spend Happened")
		end
	end,
	
	ExtraDebugInfo = function()
		return string.format("r:%d e:%s e:%s", 
			a.Rage, 
			tostring(a.InExecute), 
			tostring(not not a.Enraged))
	end,
}

-------------------------------------------------------------------- Protection
local uncontrolledMitigationCooldowns = {
	"Spell Reflection",
}

a.RevengeReset = 0

a.Rotations.Protection = {
	Spec = 3,
	
	UsefulStats = { "Stamina", "Strength", "Dodge", "Parry", "Tanking Hit" },
	
	FlashInCombat = function()
		c.FlashMitigationBuffs(
			1,
			uncontrolledMitigationCooldowns,
			c.COMMON_TANKING_BUFFS,
			"No Mitigation if Victory Available",
			"Demoralizing Shout",
			"Enraged Regeneration for Prot",
			"Shield Wall under 3 min",
			"Last Stand",
			"Shield Wall 3+ min")
		c.FlashAll(
			"Shield Block",
			"Shield Barrier",
			"Berserker Rage for Prot",
			"Heroic Strike for Prot",
			"Cleave for Prot",
			"Taunt",
			"Sunder Armor",
			"Pummel",
			"Disrupting Shout")
		c.DelayPriorityFlash(
--			"Shockwave for Stun",
--			"Dragon's Roar for Stun",
			"Thunder Clap for Debuff",
			"Impending Victory for Heals",
			"Victory Rush for Heals",
			"Shield Slam",
			"Revenge",
			"Shout for Rage",
			"Delay for Prot Rage Generator",
			"Thunder Clap for Refresh",
			"Devestate for Debuff unless AoE",
			"Bladestorm",
			"Shockwave",
			"Dragon Roar",
			"Storm Bolt",
			"Devestate")
	end,
	
	FlashAlways = function()
		c.FlashAll("Defensive Stance", "Shout for Buff")
	end,
	
	Avoided = function(missType)
		if missType == "DODGE" or missType == "PARRY" then
			a.RevengeReset = GetTime()
			c.Debug("Event", "Revenge Reset Pending")
		end
	end,
	
	CastSucceeded = function(info)
		if c.InfoMatches(info, "Revenge") then
			a.RevengeReset = 0
			c.Debug("Event", "Revenge Cast")
		end
	end,
	
	ExtraDebugInfo = function()
		return string.format("r:%d e:%s e:%s, r:%.1f", 
			a.Rage, 
			tostring(a.InExecute), 
			tostring(not not a.Enraged),
			s.SpellCooldown(c.GetID("Revenge")))
	end,
}
