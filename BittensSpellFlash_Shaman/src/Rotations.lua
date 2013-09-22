local addonName, a = ...

local s = SpellFlashAddon
local g = BittensGlobalTables
local c = g.GetTable("BittensSpellFlashLibrary")
local u = g.GetTable("BittensUtilities")

local GetMastery = GetMastery
local GetSpellBonusDamage = GetSpellBonusDamage
local GetSpellCritChance = GetSpellCritChance

a.Rotations = { }

function a.PreFlash()
	a.Ascended = c.HasBuff("Ascendance", false, false, true)
end

--------------------------------------------------------------------- Elemental
a.Rotations.Elemental = {
	Spec = 1,
	
	UsefulStats = { 
		"Intellect", "Spell Hit", "Hit from Spirit", "Crit", "Haste" 
	},
	
	FlashInCombat = function()
		c.FlashAll(
			"Elemental Mastery", 
			"Ancestral Swiftness for Elemental",
			"Ascendance for Elemental",
			"Fire Elemental Totem",
			"Spiritwalker's Grace",
			"Purge",
			"Wind Shear")
		if c.AoE then
			c.PriorityFlash(
				"Lava Beam",
				"Magma Totem",
				"Flame Shock AoE",
				"Lava Burst AoE",
				"Thunderstorm",
				"Chain Lightning",
				"Lightning Bolt")
		else
			c.PriorityFlash(
				"Unleash Elements for Elemental",
				"Flame Shock Prime for Elemental",
				"Lava Burst",
				"Flame Shock for Elemental",
				"Elemental Blast",
				"Earth Shock for Fulmination",
				"Earth Elemental Totem",
				"Searing Totem for Elemental",
				"Thunderstorm",
				"Lightning Bolt")
		end
	end,
	
	MovementFallthrough = function() end,
	
	FlashOutOfCombat = function()
		c.FlashAll("Thunderstorm", "Water Walking")
	end,
	
	FlashAlways = function()
		c.FlashAll(
			"Lightning Shield", 
			"Flametongue Weapon", 
			"Healing Surge when Solo")
	end,
}

------------------------------------------------------------------- Enhancement
a.FSStats = {}

function a.GetFSStats(hasUnleashFlame)
	local critMultiplier = 2
	local tick = c.GetHastedTime(3)
	return (266.2 + .2385 * GetSpellBonusDamage(3)) 
			* (1 + .02 * GetMastery())
			* (1 + (critMultiplier - 1) * GetSpellCritChance(3) / 100) 
			* (hasUnleashFlame and 1.3 or 1)
			/ tick,
		tick
end

a.Rotations.Enhancement = {
	Spec = 2,
	
	UsefulStats = { "Agility", "Melee Hit", "Strength", "Crit", "Haste" },
	
	FlashInCombat = function()
		if c.IsCasting("Lightning Bolt") 
			and not c.HasBuff("Ancestral Swiftness") then
			
			a.Maelstrom = 0
		else
			a.Maelstrom = c.GetBuffStack("Maelstrom Weapon")
		end
		
		c.FlashAll(
			"Elemental Mastery", 
			"Fire Elemental Totem",
			"Searing Totem",
			"Ascendance for Enhancement", 
			"Purge",
			"Wind Shear")
		c.PriorityFlash(
			"Unleash Elements with Unleashed Fury",
			"Elemental Blast for Enhance",
			"Lightning Bolt at 5",
			"Feral Spirit 4pT15",
			"Flame Shock Empowered Apply",
			"Stormblast",
			"Stormstrike",
			"Lava Lash",
			"Lightning Bolt 2pT15",
			"Flame Shock Improve",
			"Unleash Elements",
			"Lightning Bolt at 3",
			"Ancestral Swiftness under 2",
			"Lightning Bolt under Ancestral Swiftness",
			"Flame Shock Apply",
			"Earth Shock",
			"Feral Spirit",
			"Earth Elemental Totem",
			"Lightning Bolt at 2",
			"Searing Totem Refresh")
	end,
	
	FlashOutOfCombat = function()
		c.FlashAll("Water Walking")
	end,
	
	FlashAlways = function()
		c.FlashAll(
			"Lightning Shield", 
			"Windfury Weapon", 
			"Flametongue Weapon Offhand", 
			"Healing Surge when Solo")
	end,
	
	AuraApplied = function(spellID, _, targetID)
		if c.IdMatches(spellID, "Flame Shock") then
			local snap = u.GetOrMakeTable(a.FSStats, targetID)
			snap.Dps, snap.Tick = a.GetFSStats(
				s.Buff(c.GetID("Unleash Flame"), "player"))
			c.Debug("Event", "Flame Shock ticking at", snap.Dps, "dps")
		end
	end,
	
	LeftCombat = function()
		a.FSStats = {}
		c.Debug("Event", "Left Combat")
	end,
	
	ExtraDebugInfo = function()
		return a.Maelstrom
	end,
}

------------------------------------------------------------------- Restoration
a.Rotations.Restoration = {
	Spec = 3,
	
	UsefulStats = { "Intellect", "Spirit", "Crit", "Haste" },
	
	FlashInCombat = function()
		c.FlashAll(
			"Healing Stream Totem",
			"Mana Tide Totem",
			"Lightning Bolt for Mana",
			"Purge",
			"Wind Shear")
	end,
	
	FlashOutOfCombat = function()
		c.FlashAll("Water Walking")
	end,
	
	FlashAlways = function()
		c.FlashAll(
			"Earth Shield", 
			"Water Shield", 
			"Earthliving Weapon")
	end,
    
    CastSucceeded = function(info)
	    if c.InfoMatches(info, "Earth Shield") then
	        a.EarthShieldTarget = info.Target
	        c.Debug("Event", "Earth Shield target:", a.EarthShieldTarget)
	    end
    end,
}
