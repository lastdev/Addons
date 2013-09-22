local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetTime = GetTime
local SPELL_POWER_SHADOW_ORBS = SPELL_POWER_SHADOW_ORBS
local UnitSpellHaste = UnitSpellHaste
local math = math
local string = string

a.Rotations = {}

local function monitorMending(spellID, target)
	if spellID == c.GetID("Prayer of Mending Buff") then
		a.PrayerOfMendingTarget = target
		c.Debug("Event", "Prayer of Mending target:", a.PrayerOfMendingTarget)
	end
end

-------------------------------------------------------------------- Discipline
a.Rotations.Discipline = {
	Spec = 1,
	
	UsefulStats = { "Intellect", "Spirit", "Crit", "Haste" },
	
	FlashInCombat = function()
		c.FlashAll(
			"Power Word: Shield under Divine Insight",
			"Archangel",
			"Inner Focus",
			"Prayer of Mending for Discipline",
			"Flash Heal under Surge of Light",
			"Binding Heal",
			"Shadowfiend for Mana",
			"Mindbender for Mana",
			"Desperate Prayer",
			"Dispel Magic")
	end,
	
	FlashAlways = function()
		c.FlashAll(
			"Power Word: Fortitude",
			"Inner Fire or Will")
	end,
	
	AuraApplied = monitorMending,
}

-------------------------------------------------------------------------- Holy
a.Rotations.Holy = {
	Spec = 2,
	
	UsefulStats = { "Intellect", "Spirit", "Crit", "Haste" },
	
	FlashInCombat = function()
		c.FlashAll(
			"Lightwell",
			"Prayer of Mending for Holy",
			"Greater Heal under Serendipity",
			"Prayer of Healing under Serendipity",
			"Flash Heal under Surge of Light",
			"Binding Heal",
			"Shadowfiend for Mana",
			"Mindbender for Mana",
			"Desperate Prayer",
			"Dispel Magic")
	end,
	
	FlashAlways = function()
		c.FlashAll(
			"Power Word: Fortitude",
			"Inner Fire or Will", 
			"Chakra")
	end,
	
	CastSucceeded = monitorMending,
}

------------------------------------------------------------------------ Shadow
local lastSWD = 0
local swdInARow = 0
a.FlayTick = 1
a.InsanityPending = 0
a.Rotations.Shadow = {
	Spec = 3,
	
	UsefulStats = { 
		"Intellect", "Spell Hit", "Hit from Spirit", "Crit", "Haste" 
	},
	
	FlashInCombat = function()
		a.SinceSWD = GetTime() - lastSWD
		if a.SinceSWD > .5 and a.SinceSWD < .8 then
			if c.GetCooldown("Shadow Word: Death") > 0 then
				swdInARow = 0
			else
				swdInARow = 1
			end
		elseif a.SinceSWD > 6 then
			swdInARow = 0
		end
		a.SinceSWD = a.SinceSWD + c.GetBusyTime()
		if c.IsCasting("Shadow Word: Death") then
			a.SWDinARow = swdInARow + 1
			a.SinceSWD = 0
		else
			a.SWDinARow = swdInARow
		end
		
		a.Orbs = s.Power("player", SPELL_POWER_SHADOW_ORBS)
		if c.IsCasting("Mind Blast") then
			a.Orbs = math.min(3, a.Orbs + 1)
		elseif c.IsCasting("Devouring Plague") then
			a.Orbs = 0
		elseif c.IsCasting("Shadow Word: Death") 
			and s.HealthPercent() < 20 
			and swdInARow == 0 then
			
			a.Orbs = math.min(3, a.Orbs + 1)
		end
		
		a.Surges = c.GetBuffStack("Surge of Darkness")
		if c.IsCasting("Mind Spike") then
			a.Surges = a.Surges - 1
		end
		
		a.Insanity = c.GetMyDebuffDuration("Mind Flay (Insanity)")
		if s.MyDebuff(c.GetID("Devouring Plague"))
			and c.HasTalent("Solace and Insanity")
			and (c.IsCasting("Mind Flay") 
				or GetTime() - a.InsanityPending < .5) then
			
			a.Insanity = (a.Insanity % a.FlayTick) + c.GetHastedTime(3)
		end
		
		a.InExecute = s.HealthPercent() < 20
		
		c.FlashAll(
			"Power Infusion",
			"Mindbender",
			"Shadowfiend",
			"Desperate Prayer",
			"Vampiric Embrace",
			"Dispel Magic",
			"Silence")
		c.DelayPriorityFlash(
			"Mind Blast",
			"Shadow Word: Death for Orb",
--			"Shadow Word: Death without Orb",
			"Shadow Word: Pain Application",
			"Vampiric Touch Application",
			"Mind Flay (Insanity)",
			"Mind Flay (Insanity) Delay",
			"Mind Spike under Surge of Darkness Cap",
			"Shadow Word: Pain",
			"Vampiric Touch",
			"Devouring Plague",
			"Cascade",
			"Divine Star",
			"Halo",
			"Shadow Word: Pain Early",
			"Vampiric Touch Early",
			"Mind Blast Delay",
			"Shadow Word: Death Delay",
			"Mind Spike under Surge of Darkness",
			"Mind Flay")
	end,
	
--	MovementFallthrough = function()
--		c.PriorityFlash(
--			"Shadow Word: Death",
--			"Shadow Word: Pain Moving")
--	end,
	
	FlashOutOfCombat = function()
		c.FlashAll("Dispersion")
	end,
	
	FlashAlways = function()
		c.FlashAll(
			"Power Word: Fortitude",
			"Shadowform", 
			"Inner Fire")
	end,
	
	CastSucceeded = function(info)
		if c.InfoMatches(info, "Shadow Word: Death") then
			lastSWD = GetTime()
			swdInARow = swdInARow + 1
			c.Debug("Event", "Shadow Word: Death cast")
		elseif c.InfoMatches(info, "Mind Flay") then
			if s.MyDebuff(c.GetID("Devouring Plague")) then
				a.InsanityPending = GetTime()
				c.Debug("Event", "insanity pending")
			end
		end
	end,
	
	AuraApplied = function(spellID)
		if c.IdMatches(spellID, "Mind Flay", "Mind Flay (Insanity)") then
			a.FlayTick = c.GetHastedTime(1)
			c.Debug("Event", "Mind Flay ticks every", a.FlayTick)
			
			if c.IdMatches(spellID, "Mind Flay (Insanity)") then
				a.InsanityPending = 0
				c.Debug("Event", "insanity happened")
			end
		end
	end,
	
	ExtraDebugInfo = function()
		return string.format("o:%d s:%d s:%d i:%.1f b:%.1f", 
			a.Orbs, a.Surges, a.SWDinARow, a.Insanity, c.GetBusyTime())
	end,
}
