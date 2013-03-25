local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetPowerRegen = GetPowerRegen
local GetTime = GetTime
local math = math
local select = select

a.Rotations = {}

function a.PreFlash()
	a.InExecute = s.HealthPercent() < 20
	a.Rage = c.GetPower(select(2, GetPowerRegen()))
	a.Enraged = c.HasBuff("Enrage", true)
	if c.IsQueued("Bloodthirst", "Mortal Strike") then
		a.Rage = a.Rage + 10
	elseif c.IsQueued("Berserker Rage") then
		a.Rage = a.Rage + 10
		a.Enraged = true
	elseif c.IsQueued("Battle Shout", "Commanding Shout", "Charge") then
		a.Rage = a.Rage + 20
	elseif c.IsQueued("Shield Slam") then
		if s.Buff("player", c.GetID("Sword and Board")) then
			a.Rage = a.Rage + 25
		else
			a.Rage = a.Rage + 20
		end
	elseif c.IsQueued("Revenge") then
		a.Rage = a.Rage + 15
	end
	a.Rage = math.min(s.MaxPower("player"), a.Rage)
	a.EmptyRage = s.MaxPower("player") - a.Rage
end

-------------------------------------------------------------------------- Arms
local tastePending = 0

a.Rotations.Arms = {
	Spec = 1,
	
	FlashInCombat = function()
		a.TasteStacks = c.GetBuffStack("Taste for Blood")
		if c.IsCasting("Mortal Strike") or GetTime() - tastePending < .8 then
			a.TasteStacks = a.TasteStacks + 2
		elseif c.IsCasting("Overpower") then
			a.TasteStacks = a.TasteStacks - 1
		end
		c.FlashAll(
			"Recklessness for Arms",
			"Avatar",
			"Bloodbath",
			"Berserker Rage for Arms",
			"Heroic Strike for Arms",
			"Heroic Leap",
			"Impending Victory for Heals, Optional",
			"Victory Rush for Heals, Optional",
			"Enraged Regeneration",
			"Sunder Armor",
			"Pummel",
			"Disrupting Shout")
c.Debug("Flash", a.Rage, a.InExecute, not not a.Enraged, a.TasteStacks,
		c.PriorityFlash(
			"Mortal Strike",
			"Colossus Smash for Arms",
			"Storm Bolt for Arms",
			"Execute under Smash",
			"Dragon Roar",
			"Execute",
			"Impending Victory unless Execute",
			"Victory Rush unless Execute",
			"Slam with High Rage",
			"Overpower",
			"Slam",
			"Shockwave",
			"Shout for Rage",
			"Heroic Throw")
)
	end,
	
	FlashAlways = function()
		c.FlashAll("Dps Stance")
	end,
	
	CastSucceeded = function(info)
		if c.InfoMatches(info, "Mortal Strike") then
			tastePending = GetTime()
			c.Debug("Event", "Taste for Blood pending")
		end
	end,
	
	AuraApplied = function(spellID)
		if c.IdMatches(spellID, "Taste for Blood") then
			tastePending = 0
			c.Debug("Event", "Taste for Blood applied")
		end
	end
}

-------------------------------------------------------------------------- Fury
a.Rotations.Fury = {
	Spec = 2,
	
	FlashInCombat = function()
		c.FlashAll(
			"Recklessness for Fury",
			"Avatar",
			"Bloodbath for Fury",
			"Berserker Rage for Fury",
			"Heroic Strike for Fury",
			"Heroic Leap",
			"Impending Victory for Heals, Optional",
			"Victory Rush for Heals, Optional",
			"Enraged Regeneration",
			"Sunder Armor",
			"Pummel",
			"Disrupting Shout")
		
c.Debug("Flash", a.Rage, a.InExecute, not not a.Enraged,
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
				"Victory Rush unless Execute",
				"Wild Strike with High Rage",
				"Shout for Rage")
)
	end,
	
	FlashAlways = function()
		c.FlashAll("Dps Stance")
	end,
}

-------------------------------------------------------------------- Protection
local uncontrolledMitigationCooldowns = {
	"Second Wind",
	"Spell Reflection",
	"Rallying Cry",
	-- demoralizing banner?
}

a.Rotations.Protection = {
	Spec = 3,
	
	FlashInCombat = function()
		c.FlashMitigationBuffs(
			1,
			uncontrolledMitigationCooldowns,
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
			"Heroic Strike for free",
			"Taunt",
			"Sunder Armor",
			"Pummel",
			"Disrupting Shout")
c.Debug("Flash", a.Rage,
		c.PriorityFlash(
--			"Shockwave for Stun",
--			"Dragon's Roar for Stun",
			"Thunder Clap for Debuff",
			"Impending Victory for Heals",
			"Victory Rush for Heals",
			"Shield Slam",
			"Revenge",
			"Shout for Rage",
			"Thunder Clap for Refresh",
			"Devestate")
)
	end,
	
	FlashAlways = function()
		c.FlashAll("Defensive Stance")
	end,
}
