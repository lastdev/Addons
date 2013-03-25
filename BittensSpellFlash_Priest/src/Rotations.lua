local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetTime = GetTime
local SPELL_POWER_SHADOW_ORBS = SPELL_POWER_SHADOW_ORBS
local UnitSpellHaste = UnitSpellHaste

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
	
	FlashInCombat = function()
		c.FlashAll(
			"Flash Heal under Surge of Light",
			"Prayer of Mending",
			"Binding Heal",
			"Desperate Prayer",
			"Inner Focus",
			"Shadowfiend for Mana",
			"Mindbender for Mana",
			"Penance under Borrowed Time",
			"Power Word: Shield under Divine Insight",
			"Archangel")
	end,
	
	FlashAlways = function()
		c.FlashAll(
			"Power Word: Fortitude",
			"Inner Fire or Will")
	end,
	
	AuraApplied = monitorMending,
}

-------------------------------------------------------------------------- Holy
--a.Rotations.Holy = {
--	Spec = 2,
--	
--	FlashInCombat = function()
--		c.FlashAll(
--			"Prayer of Mending",
--			"Flash Heal under Surge of Light",
--			"Shadowfiend for Mana",
--			"Lightwell",
--			"Greater Heal under Serendipity",
--			"Prayer of Healing under Serendipity",
--			"Binding Heal",
--			"Holy Word: Chastise",
--			"Holy Word: Serenity",
--			"Holy Word: Sanctuary",
--			"Desperate Prayer")
--	end,
--	
--	FlashAlways = function()
--		c.FlashAll(
--			"Power Word: Fortitude",
--			"Shadow Protection",
--			"Inner Fire unless Inner Will", 
--			"Inner Will unless Inner Fire",
--			"Chakra")
--	end,
--	
--	CastSucceeded = monitorMending,
--}

------------------------------------------------------------------------ Shadow
local lastSWD = 0
local swdInARow = 0
a.SWDinARow = 0
a.Rotations.Shadow = {
	Spec = 3,
	
	FlashInCombat = function()
		if GetTime() - lastSWD > 6 then
			swdInARow = 0
		end
		a.SWDinARow = swdInARow
		if c.IsCasting("Shadow Word: Death") then
			a.SWDinARow = a.SWDinARow + 1
		end
		
		a.Orbs = s.Power("player", SPELL_POWER_SHADOW_ORBS)
		if c.IsCasting("Mind Blast") then
			a.Orbs = a.Orbs + 1
		elseif c.IsCasting("Devouring Plague") then
			a.Orbs = 0
		elseif c.IsCasting("Shadow Word: Death") 
			and s.HealthPercent() < 20 
			and swdInARow == 0 then
			
			a.Orbs = a.Orbs + 1
		end
		
		a.Surges = c.GetBuffStack("Surge of Darkness")
		if c.IsCasting("Mind Spike") then
			a.Surges = a.Surges - 1
		end
		
		c.FlashAll(
			"Power Infusion",
			"Mindbender",
			"Shadowfiend",
			"Desperate Prayer")
c.Debug("Flash", a.Orbs, a.Surges, a.SWDinARow,
		c.PriorityFlash(
			"Devouring Plague to Prevent Cap",
			"Shadow Word: Death",
			"Mind Blast",
			"Shadow Word: Pain application",
			"Vampiric Touch application",
			"Mind Spike under Surge of Darkness Cap",
			"Shadow Word: Pain",
			"Vampiric Touch",
			"Halo",
			"Devouring Plague",
			"Cascade",
			"Shadow Word: Death wait",
			"Mind Blast wait",
			"Mind Spike under Surge of Darkness",
			"Mind Flay")
)
	end,
	
	FlashOutOfCombat = function()
		c.PriorityFlash("Dispursion")
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
		end
	end,
}
