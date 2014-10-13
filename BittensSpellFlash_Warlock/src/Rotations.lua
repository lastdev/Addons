local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local x = s.UpdatedVariables
local g = BittensGlobalTables
local c = g.GetTable("BittensSpellFlashLibrary")
local u = g.GetTable("BittensUtilities")

local GetSpellBonusDamage = GetSpellBonusDamage
local GetSpellCritChance = GetSpellCritChance
local GetTime = GetTime
local MAX_POWER_PER_EMBER = MAX_POWER_PER_EMBER
local GetMastery = GetMastery
local SPELL_POWER_BURNING_EMBERS = SPELL_POWER_BURNING_EMBERS
local SPELL_POWER_DEMONIC_FURY = SPELL_POWER_DEMONIC_FURY
local SPELL_POWER_SOUL_SHARDS = SPELL_POWER_SOUL_SHARDS
local UnitGUID = UnitGUID
local UnitPower = UnitPower
local math = math
local pairs = pairs
local select = select
local string = string
local tostring = tostring

a.Rotations = {}

local function flashSummon(...)
	if c.HasTalent("Grimoire of Sacrifice") then
		if not c.SelfBuffNeeded("Grimoire of Sacrifice") then
			return
		end
		
		if x.PetAlive then
			s.Flash(c.GetID("Grimoire of Sacrifice"), "yellow")
			return
		end
	elseif x.PetAlive then
		return
	end
	
--	local current = a.GetCurrentPet()
--	for i = 1, select("#", ...) do
--		if select(i, ...) == current then
--			return
--		end
--	end
	
	s.Flash(c.GetID("Summon Demon"), "yellow")
	for i = 1, select("#", ...) do
		s.Flash(c.GetID("Summon " .. select(i, ...)), "yellow")
	end
end

a.Snapshots = { }
local dotInfo = {
	["Agony"] = {
		Tick = 2,
		SPBase = 280,
		SPCoeff = .26,
		MastBase = 1,
		MastCoeff = .031,
	},
	["Corruption"] = {
		Tick = 2,
		SPBase = 214,
		SPCoeff = .2,
		MastBase = 1,
		MastCoeff = .031,
	},
	["Unstable Affliction"] = {
		Tick = 2,
		SPBase = 256,
		SPCoeff = .24,
		MastBase = 1,
		MastCoeff = .031,
	},
	["Doom"] = {
		Tick = 15,
		SPBase = 1335,
		SPCoeff = 1.25,
		MastBase = 1,
		MastCoeff = .031,
	},
	["Shadowflame"] = {
		Tick = 1,
		SPBase = 1, -- only used for "Tick"
		SPCoeff = 1,
		MastBase = 1,
		MastCoeff = 1,
	},
	["Immolate"] = {
		Tick = 3,
		SPBase = 396,
		SPCoeff = .371,
		MastBase = 1.01,
		MastCoeff = .01,
	},
}

function a.GetDps(name)
	local critMultiplier = 2
	local info = dotInfo[name]
	local tick = c.GetHastedTime(info.Tick)
	return (info.SPBase + info.SPCoeff * GetSpellBonusDamage(6)) 
			* (info.MastBase + info.MastCoeff * GetMastery())
			* (1 + (critMultiplier - 1) * GetSpellCritChance(6) / 100) 
			/ tick,
		tick
end

local function recordSnapshot(spellID, _, targetID)
	for name, _ in pairs(dotInfo) do
		if spellID == c.GetID(name) then
			local snap = u.GetOrMakeTable(a.Snapshots, name, targetID)
			snap.Dps, snap.Tick = a.GetDps(name)
			snap.Miserable = s.Buff(c.GetID("Dark Soul: Misery"), "player")
			c.Debug("Event", name, "applied at", snap.Dps, "dps", 
				snap.Miserable and "with" or "without", "misery")
			return snap
		end
	end
end

-------------------------------------------------------------------- Affliction
local empoweredSoCTarget
local agonyMiss = 0
local agonySuccess = 0
local agonyTarget
a.SwapCast = 0

a.Rotations.Afliction = {
	Spec = 1,
	
	UsefulStats = { "Intellect", "Spell Hit", "Crit", "Haste" },
	
	FlashInCombat = function()
		a.Shards = s.Power("player", SPELL_POWER_SOUL_SHARDS)
		if c.IsCasting("Soulburn", "Haunt") then
			a.Shards = a.Shards - 1
		end
		a.DarkSoul = c.HasBuff("Dark Soul: Misery", false, false, true)
		
		if empoweredSoCTarget ~= nil
			or (c.IsQueued("Seed of Corruption") 
				and c.HasBuff("Soulburn", false, false, true)) then
			
			a.SoCExplosionPending = true
		else
			a.SoCExplosionPending = false
			local now = GetTime()
			for _, snap in pairs(
				u.GetOrMakeTable(a.Snapshots, "Seed of Corruption")) do
				
				if snap.Exploded ~= nil and snap.Exploded > snap.Applied then
					if now - snap.Exploded < 1 then
						a.SoCExplosionPending = true
					end
				elseif now - snap.Applied < 20 then
					a.SoCExplosionPending = true
				end
			end
		end
		
		c.FlashAll(
			"Curse of the Elements",
			"Dark Soul: Misery",
			"Grimoire: Felhunter",
			"Clone Magic",
			"Devour Magic",
			"Spell Lock",
			"Optical Blast",
			"Command Spell Lock",
			"Soulshatter")
		if s.HealthPercent() <= 20 then
			c.PriorityFlash(
				"Soulburn during Execute",
				"Haunt during Execute",
				"Soul Swap",
				"Life Tap for Affliction",
				"Drain Soul")
		else
			c.PriorityFlash(
				"Soulburn under Dark Soul: Misery",
				"Soul Swap",
				"Agony within GCD",
				"Haunt",
				"Corruption within GCD",
				"Unstable Affliction within GCD",
				"Agony with Pandemic",
				"Unstable Affliction with Pandemic",
				"Corruption with Pandemic",
				"Agony Soon",
				"Unstable Affliction Soon",
				"Corruption Soon",
				"Life Tap for Affliction",
				"Agony before Malefic Grasp",
				"Malefic Grasp")
		end
	end,
	
	FlashAlways = function()
		c.FlashAll(
			"Dark Intent", 
			"Soulstone", 
			"Dark Regeneration",
			"Underwater Breath")
		flashSummon("Felhunter", "Observer")
		
		if agonySuccess > 0 then
			if agonySuccess ~= agonyMiss then
				recordSnapshot(c.GetID("Agony"), nil, agonyTarget)
			end
			agonySuccess = 0
		end
	end,
	
	FlashOutOfCombat = function()
		c.FlashAll("Life Tap", "Soul Swap")
	end,
	
	CastStarted = function(info)
		if c.InfoMatches(info, "Seed of Corruption") then
			if c.HasBuff("Soulburn") then
				empoweredSoCTarget = UnitGUID(s.UnitSelection())
			else
				empoweredSoCTarget = nil
			end
			c.Debug("Event", "Seed of Corruption cast start", empoweredSoCTarget)
		end
	end,
	
	CastFailed = function(info, quiet)
		if not quiet and c.InfoMatches(info, "Seed of Corruption") then
			empoweredSoCTarget = nil
			c.Debug("Event", "Seed of Corruption Failed")
		end
	end,
	
	CastSucceeded = function(info)
		if c.InfoMatches(info, "Seed of Corruption") and empoweredSoCTarget then
			u.GetOrMakeTable(
				a.Snapshots, 
				"Seed of Corruption", 
				empoweredSoCTarget).Applied = GetTime()
			empoweredSoCTarget = nil
			c.Debug("Event", "Empowered SoC Applied")
		end
	end,
	
	-- Agony uses AuraApplied when stacking, but not when re-applying
	-- Agony SUCCESS -> Agony MISSED
	-- Agony MISSED -> Soul Swap SUCCESS
	
	CastSucceeded_FromLog = function(spellID, _, targetID)
		if c.IdMatches(spellID, "Agony", "Soul Swap Soulburn") then
			agonySuccess = GetTime()
			agonyTarget = targetID
			if c.IdMatches(spellID, "Soul Swap Soulburn") then
				a.SwapCast = GetTime()
			end
		end
	end,
	
	SpellMissed = function(spellID)
		if c.IdMatches(spellID, "Agony") then
			agonyMiss = GetTime()
		end
	end,
	
	AuraApplied = function(spellID, _, targetID)
		if c.IdMatches(spellID, "Corruption", "Unstable Affliction") then
			recordSnapshot(spellID, nil, targetID)
			a.SwapCast = 0
		end
	end,
	
	AuraRemoved = function(spellID, _, targetID)
		if c.IdMatches(spellID, "Seed of Corruption") then
			local now = GetTime()
			local snap = u.GetFromTable(
				a.Snapshots, "Seed of Corruption", targetID)
			if snap ~= nil and now - snap.Applied < 20 then
				snap.Exploded = now
				c.Debug("Event", "Empowered SoC Exploded")
			end
		end
	end,
	
	LeftCombat = function()
		a.Snapshots = { }
		c.Debug("Event", "Left Combat")
	end,
	
	ExtraDebugInfo = function()
		return string.format("%.1f %s",
			a.Shards, tostring(a.SoCExplosionPending))
	end,
}

-------------------------------------------------------------------- Demonology
local furyBonuses = {
	["Shadow Bolt"] = 25,
	["Soul Fire"] = 30,
}

local furyCosts = {
	["Touch of Chaos"] = 40,
	["Void Ray"] = 40,
	["Doom"] = 60,
	["Soul Fire"] = 80,
}

local furyTick = {
	["Shadowflame"] = 2,
	["Corruption"] = 4,
}

local function bumpFury(amount)
	if c.WearingSet(4, "T15") then	
		amount = amount * 1.1
	end
	a.Fury = a.Fury + amount
end

a.Rotations.Demonology = {
	Spec = 2,
	
	UsefulStats = { "Intellect", "Spell Hit", "Crit", "Haste" },
	
	FlashInCombat = function()
		a.Fury = s.Power("player", SPELL_POWER_DEMONIC_FURY)
		a.DarkSoul = c.GetBuffDuration(
			"Dark Soul: Knowledge", false, false, true)
		a.Morphed = s.Form(c.GetID("Metamorphosis"))
		if a.Morphed then
			for name, cost in pairs(furyCosts) do
				if c.IsCasting(name) then
					a.Fury = a.Fury - cost
				end
			end
		else
			for name, bonus in pairs(furyBonuses) do
				if c.IsCasting(name) then
					bumpFury(bonus)
				end
			end
		end
		local busy = c.GetBusyTime()
		for name, bonus in pairs(furyTick) do
			local dur = c.GetMyDebuffDuration(name)
			local tick = u.GetFromTable(
				a.Snapshots, name, UnitGUID(s.UnitSelection()), "Tick")
			if dur > 0 and tick ~= nil and busy > dur % tick then
				bumpFury(bonus)
			end
		end

		c.FlashAll(
			"Dark Soul: Knowledge",
			"Felstorm",
			"Wrathstorm",
			"Grimoire: Felguard",
			"Clone Magic",
			"Devour Magic",
			"Spell Lock",
			"Optical Blast",
			"Command Spell Lock",
			"Axe Toss",
			"Super Axe Toss",
			"Soulshatter")
		if c.AoE then
			if a.Morphed then
				c.FlashAll("Aura of the Elements")
				c.PriorityFlash(
					"Metamorphosis Cancel AoE",
					"Immolation Aura",
					"Doom",
					"Void Ray")
			else
				c.PriorityFlash(
					"Corruption for Demonology",
					"Hand of Gul'dan",
					"Metamorphosis AoE",
					"Hellfire",
					"Life Tap",
					"Hellfire Out of Range")
			end
		elseif a.Morphed then
			c.PriorityFlash(
				"Touch of Chaos to Save Corruption",
				"Doom",
				"Touch of Chaos to Extend Corruption",
				"Metamorphosis Cancel",
				"Soul Fire",
				"Touch of Chaos")
		else
			c.FlashAll("Curse of the Elements")
			c.PriorityFlash(
				"Corruption for Demonology",
				"Metamorphosis",
				"Hand of Gul'dan",
				"Soul Fire",
				"Life Tap",
				"Shadow Bolt")
		end
	end,
	
	FlashAlways = function()
		c.FlashAll(
			"Dark Intent", 
			"Soulstone", 
			"Dark Regeneration",
			"Underwater Breath")
		flashSummon("Felguard", "Wrathguard")
	end,
	
	FlashOutOfCombat = function()
		c.FlashAll("Life Tap")
	end,
	
	AuraApplied = recordSnapshot,
	
	LeftCombat = function()
		a.Snapshots = { }
		c.Debug("Event", "Left combat")
	end,
	
	ExtraDebugInfo = function()
		return string.format("%s %s", tostring(a.Fury), tostring(a.Morphed))
	end,
}

------------------------------------------------------------------- Destruction
local lastEmbers = nil
local pendingEmberBump = 0
local pendingEmberDrop = 0

a.RoFCast = 0

function a.T15EmberCost()
	if c.WearingSet(2, "T15") then
		return .8
	else
		return 1
	end		
end

a.Rotations.Destruction = {
	Spec = 3,
	
	UsefulStats = { "Intellect", "Spell Hit", "Crit", "Haste" },
	
	FlashInCombat = function()
		a.Embers = UnitPower("player", SPELL_POWER_BURNING_EMBERS, true) 
			/ MAX_POWER_PER_EMBER
		a.DarkSoul = c.GetBuffDuration(
			"Dark Soul: Instability", false, false, true)
		if lastEmbers ~= nil then
			if a.Embers > lastEmbers then
				pendingEmberBump = math.max(
					0, pendingEmberBump - (a.Embers - lastEmbers))
				c.Debug("Flash", "Ember bump occurred")
			elseif a.Embers < lastEmbers then
				pendingEmberDrop = 0
				c.Debug("Flash", "Ember drop occurred")
			end
		end
		lastEmbers = a.Embers
		a.Embers = a.Embers + pendingEmberBump - pendingEmberDrop
		
		if c.IsCasting("Incinerate", "Conflagrate") then
			a.Embers = a.Embers + .1
		elseif c.IsCasting("Chaos Bolt", "Shadowburn") then
			a.Embers = a.Embers - a.T15EmberCost()
		elseif c.IsCasting("Fire and Brimstone") then
			a.Embers = a.Embers - 1
		end
		
		a.Backdraft = c.GetBuffStack("Backdraft")
		if a.Backdraft > 0 and c.IsCasting("Incinerate") then
			a.Backdraft = a.Backdraft - 1
		elseif c.IsCasting("Conflagrate") then
			a.Backdraft = a.Backdraft + 3
		end
		
		
		c.FlashAll(
			"Curse of the Elements",
			"Dark Soul: Instability",
			"Grimoire: Felhunter",
			"Ember Tap",
			"Clone Magic",
			"Devour Magic",
			"Spell Lock",
			"Optical Blast",
			"Command Spell Lock",
			"Soulshatter")
		if c.AoE then
			local flashing = c.PriorityFlash(
				"Rain of Fire",
				"Immolate",
				"Conflagrate AoE",
				"Incinerate")
			if flashing == "Immolate" 
				or (a.Embers >= 2 and flashing == "Incinerate") then
				
				c.FlashAll("Fire and Brimstone")
			else
				c.FlashAll("Fire and Brimstone Cancel")
			end
		else
			c.PriorityFlash(
				"Shadowburn",
				"Immolate",
				"Immolate Pandemic",
				"Conflagrate at Cap",
				"Chaos Bolt",
				"Rain of Fire Single Target",
				"Conflagrate Single Target",
				"Incinerate",
				"Shadowburn Last Resort",
				"Chaos Bolt Last Resort")
		end
	end,
	
	FlashAlways = function()
		c.FlashAll(
			"Dark Intent", 
			"Soulstone", 
			"Dark Regeneration",
			"Underwater Breath")
		flashSummon("Felhunter", "Observer")
	end,
	
--CastQueued = function(info)
--c.Debug("Event", "Queued", info.Name)
--end,
	
	CastSucceeded = function(info)
		if c.InfoMatches(
			info, 
			"Incinerate", 
			"Conflagrate", 
			"Incinerate AoE", 
			"Conflagrate AoE") then
			
			pendingEmberBump = pendingEmberBump + .1
			c.Debug("Event", "Ember bump pending:", info.Name)
		elseif c.InfoMatches(info, "Chaos Bolt", "Shadowburn") then
			pendingEmberDrop = a.T15EmberCost()
			c.Debug("Event", "Ember drop pending:", info.Name)
		elseif c.InfoMatches(info, "Fire and Brimstone") then
			pendingEmberDrop = 1
			c.Debug("Event", "Ember drop pending:", info.Name)
		elseif c.InfoMatches(info, "Rain of Fire") then
			a.RoFCast = GetTime()
		end
	end,
	
	SpellDamage = function(spellID, target, _, critical)
--c.Debug("Event", "Damage:", spellID, s.SpellName(spellID), target, amount, critical)
		if critical 
			and (spellID == c.GetID("Incinerate")
				or spellID == c.GetID("Conflagrate")
				or spellID == c.GetID("Immolate")
				or spellID == c.GetID("Incinerate AoE")
				or spellID == c.GetID("Conflagrate AoE")
				or spellID == c.GetID("Immolate AoE")) then
			
			pendingEmberBump = pendingEmberBump + .1
			c.Debug("Event", "Ember bump pending from crit")
		end
	end,
	
	AuraApplied = function(spellId, _, targetId)
		if c.IdMatches(spellId, "Rain of Fire") then
			a.RoFCast = 0
		else
			if spellId == c.GetID("Immolate AoE") then
				spellId = c.GetID("Immolate")
			end
			recordSnapshot(spellId, _, targetId)
		end
	end,
	
	LeftCombat = function()
		a.Snapshots = { }
		lastEmbers = nil
		pendingEmberBump = 0
		pendingEmberDrop = 0
		c.Debug("Event", "Left combat")
	end,
	
	ExtraDebugInfo = function()
		return string.format("%.1f %d %.1f %d m:%d", 
			a.Embers, 
			a.Backdraft, 
			pendingEmberBump, 
			pendingEmberDrop,
			c.GetPowerPercent())
	end,
}
