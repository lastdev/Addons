local AddonName, a = ...
if a.BuildFail(50000) then return end
local L = a.Localize
local s = SpellFlashAddon
local x = s.UpdatedVariables
local c = BittensSpellFlashLibrary

local GetTime = GetTime
local IsMounted = IsMounted
local MAX_POWER_PER_EMBER = MAX_POWER_PER_EMBER
local SPELL_POWER_BURNING_EMBERS = SPELL_POWER_BURNING_EMBERS
local UnitPower = UnitPower
local select = select

a.Rotations = {}
c.RegisterForEvents(a)
a.SetSpamFunction(function()
	c.Flash(a)
end)

local function flashSummon(...)
	if IsMounted() then
		return
	end
	
	if c.HasTalent("Grimoire of Sacrifice") then
		if not c.SelfBuffNeeded("Grimoire of Sacrifice") then
			return
		end
		
		if x.PetAlive then
			s.Flash(c.GetID("Grimoire of Sacrifice"), "yellow")
			return
		end
	end
	
	local current = a.GetCurrentPet()
	for i = 1, select("#", ...) do
		if select(i, ...) == current then
			return
		end
	end
	
	s.Flash(c.GetID("Summon Demon"), "yellow")
	for i = 1, select("#", ...) do
		s.Flash(c.GetID("Summon " .. select(i, ...)), "yellow")
	end
end

a.Rotations.Afliction = {
	Spec = 1,
	OffSwitch = "affliction_off",
	
	FlashInCombat = function()
		c.FlashAll(
			"Curse of the Elements",
			"Dark Soul: Misery",
			"Soulburn under Dark Soul: Misery",
			"Soul Swap under Soulburn",
			"Grimoire: Felhunter",
			"Spell Lock",
			"Optical Blast")
		if s.HealthPercent() <= 20 then
			c.PriorityFlash(
				"Haunt",
				"Soulburn during Execute",
				"Soul Swap during Execute",
				"Life Tap",
				"Drain Soul")
		else
			c.PriorityFlash(
				"Haunt",
				"Agony",
				"Corruption",
				"Unstable Affliction",
				"Life Tap",
				"Malefic Grasp")
		end
	end,
	
	FlashAlways = function()
		c.FlashAll("Dark Intent")
		flashSummon("Felhunter", "Observer")
	end,
	
	AuraApplied = function(spellID)
		
		-- Do this here instead of c.ManageDotRefresh so that it updates when
		-- cast via Soul Swap
		if spellID == c.GetID("Corruption") then
			c.GetSpell("Corruption").EarlyRefresh = c.GetHastedTime(2)
		elseif spellID == c.GetID("Unstable Affliction") then
			c.GetSpell("Unstable Affliction").EarlyRefresh = c.GetHastedTime(2)
		end
	end,
}

--a.ImmolateRefresh = 0
--a.Rotations.Demonology = {
--	Spec = 2,
--	OffSwitch = "demonology_off",
--	
--	FlashInCombat = function()
--		a.FlashAll(
--			"Felstorm",
--			"Curse of the Elements",
--			"Metamorphosis",
--			"Summon Doomguard",
--			"Demon Soul",
--			"Axe Toss",
--			"Spell Lock")
--		a.Flash(
--			"Soul Fire with T13",
--			"Immolate",
--			"Bane of Doom",
--			"Bane of Agony",
--			"Summon Felhunter in Combat",
--			"Corruption",
--			"Shadowflame",
--			"Hand of Gul'dan",
--			"Immolation Aura",
--			"Incinerate under Molten Core",
--			"Refresh Bane of Doom",
--			"Life Tap",
--			"Soul Fire and Soulburn",
--			"Soul Fire under Decimation",
--			"Incinerate")
--	end,
--	
--	FlashOutOfCombat = function()
--		a.FlashAll("Create Soulstone")
--		a.Flash("Summon Felguard", "Soul Link")
--		a.Flash("Life Tap out of Combat", "Soul Harvest")
--	end,
--	
--	FlashAlways = function()
--		a.FlashAll("Dark Intent", "Fel Armor")
--	end,
--	
--	CastSucceeded = trackDarkIntent,
--	
--	SpellDamage = function(
--		spellID, target, amount, critical, spellSchool, damageSchool, periodic)
--		
--		if spellID == c.GetID("Hand of Gul'dan")
--			and s.MyDebuff(c.GetID("Immolate"))
--			and c.HasTalent("Cremation") then
--			
--			a.ImmolateRefresh = GetTime()
--			c.Debug("Event", "Immolate Refresh")
--		end
--	end,
--}

local lastEmbers = 0
local pendingEmberBump = false
local pendingEmberDrop = false

a.Rotations.Destruction = {
	Spec = 3,
	OffSwitch = "destro_off",
	
	FlashInCombat = function()
		a.Embers = UnitPower("player", SPELL_POWER_BURNING_EMBERS, true) 
			/ MAX_POWER_PER_EMBER
		if a.Embers > lastEmbers then
			pendingEmberBump = false
			c.Debug("Flash", "Ember bump occurred")
		elseif a.Embers < lastEmbers then
			pendingEmberDrop = false
			c.Debug("Flash", "Ember drop occurred")
		end
		lastEmbers = a.Embers
		if pendingEmberBump then
			a.Embers = a.Embers + .1
		end
		if pendingEmberDrop then
			a.Embers = a.Embers - 1
		end
		
		if c.IsCasting("Incinerate") then
			a.Embers = a.Embers + .1
		elseif c.IsCasting("Chaos Bolt") or c.IsCasting("Shadowburn") then
			a.Embers = a.Embers - 1
		end
		
		a.Backdraft = c.GetBuffStack("Backdraft")
		if a.Backdraft > 0 and c.IsCasting("Incinerate") then
			a.Backdraft = a.Backdraft - 1
		elseif c.IsCasting("Conflagrate") then
			a.Backdraft = 3
		end
		
		
		c.FlashAll(
			"Curse of the Elements",
			"Dark Soul: Instability",
			"Grimoire: Imp")
--c.Debug("Flash", a.Embers, a.Backdraft,
		c.PriorityFlash(
			"Shadowburn",
			"Immolate",
			"Chaos Bolt if Capped",
			"Conflagrate",
			"Incinerate",
			"Chaos Bolt")
--)
	end,
	
	FlashAlways = function()
		c.FlashAll("Dark Intent")
		flashSummon("Imp", "Fel Imp")
	end,
	
--CastQueued = function(info)
--c.Debug("Event", "Queued", info.Name)
--end,

CastSucceeded = function(info)
	if c.InfoMatches(info, "Incinerate") then
		pendingEmberBump = true
		c.Debug("Event", "Ember bump pending")
	elseif c.InfoMatches(info, "Chaos Bolt") then
		pendingEmberDrop = true
		c.Debug("Event", "Ember drop pending")
	end
end,

--SpellDamage = function(spellID)
--if spellID == c.GetID("Incinerate") then
--c.Debug("Event", "Incinerate Does Damage")
--end
--end,
}
