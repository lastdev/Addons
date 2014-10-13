local addonName, a = ...
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetPowerRegen = GetPowerRegen
local GetTime = GetTime
local SPELL_POWER_FOCUS = SPELL_POWER_FOCUS
local math = math
local pairs = pairs
local select = select
local string = string
local tostring = tostring

function a.FocusAdded(delay)
	if s.Buff(c.GetID("Steady Focus"), "player", delay) then
		return 17
	else
		return 14
	end
end

local function adjustCost(info)
	if c.InfoMatches(info, "Cobra Shot", "Steady Shot") then
		info.Cost[SPELL_POWER_FOCUS] = -a.FocusAdded(
			info.CastStart + s.CastTime(info.Name) - GetTime())
	elseif c.InfoMatches(info, "Fervor") then
		info.Cost[SPELL_POWER_FOCUS] = -50
	end
end

a.Rotations = { }

function a.PreFlash()
	a.Regen = select(2, GetPowerRegen())
	if c.HasBuff("Fervor") or c.IsAuraPendingFor("Fervor") then
		a.Regen = a.Regen + 5
	end
	if c.HasBuff("Rapid Recuperation") then
		a.Regen = a.Regen + 4
	end
	a.Focus = c.GetPower(a.Regen, SPELL_POWER_FOCUS)
	a.EmptyFocus = s.MaxPower("player") - a.Focus
end

----------------------------------------------------------------- Beast Mastery
a.LastMultiShot = 0

a.Rotations.BeastMastery = {
	Spec = 1,
	
	UsefulStats = { "Agility", "Melee Hit", "Crit", "Haste" },
	
	FlashInCombat = function()
		c.FlashAll(
			"Fervor", 
			"Bestial Wrath", 
			"Explosive Trap for Mini-AoE",
			"Multi-Shot for Mini-AoE",
			"Exhilaration", 
			"Heart of the Phoenix",
			"Growl",
			"Cower",
			"Last Stand",
			"Bullheaded",
			"Mend Pet at 50",
			"Counter Shot",
			"Tranquilizing Shot")
		c.PriorityFlash(
			"Serpent Sting", 
			"Cobra Shot for Serpent Sting",
			"Stampede",
			"A Murder of Crows",
			"Lynx Rush",
			"Dire Beast",
			"Kill Shot",
			"Kill Command",
			"Glaive Toss",
			"Arcane Shot under Thrill of the Hunt",
			"Focus Fire",
			"Rapid Fire for BM",
			"Powershot",
			"Arcane Shot for BM",
--			"Barrage",
			"Mend Pet", 
			"Cobra Shot")
		if c.Flashing["Bestial Wrath"] and c.Flashing["Cobra Shot"] then
			c.PredictFlash("Arcane Shot")
		end
	end,
	
	FlashOutOfCombat = function()
		c.FlashAll("Mend Pet")
	end,
	
	FlashAlways = function()
		c.FlashAll(
			"Aspect of the Hawk",
			"Aspect of the Iron Hawk", 
			"Call Pet", 
			"Revive Pet")
	end,
	
	CastQueued = adjustCost,
	
	CastSucceeded = function(info)
		if c.InfoMatches(info, "Multi-Shot") then
			a.LastMultiShot = GetTime()
			c.Debug("Event", "Multi Shot")
		end
	end,
	
	ExtraDebugInfo = function()
		return string.format("%.1f", a.Focus)
	end
}

------------------------------------------------------------------ Marksmanship
local nextSSIsImproved
local ssUnimprovers = {
	"Arcane Shot",
	"Chimera Shot",
	"Aimed Shot",
	"Aimed Shot!",
	"Glaive Toss", -- guess
	"Powershot", -- guess
	"Barrage", -- guess
	"A Murder of Crows",
	"Dire Beast",
	"Serpent Sting",
	"Multi-Shot",
	"Tranquilizing Shot",
-- Perhaps the below are not worth including, since they are not part of the
-- rotation
--	"Distracting Shot",
--	"Silencing Shot",
--	"Wyvern Sting",
--	"Binding Shot",
}
-- Things that do NOT break SS pairs:
-- Traps
-- Things not on the GCD
-- Deterrence
-- Disengage
-- Feign Death
-- Flare
-- Hunter's Mark
-- Mend Pet
-- Lynx Rush
-- Fervor

local function getImprovedStatus(info, curValue)
	if info then
		if c.InfoMatches(info, "Steady Shot") then
			return not curValue
		elseif c.InfoMatches(info, ssUnimprovers) then
			return false
		end
	end
	return curValue
end

a.Rotations.Marksmanship = {
	Spec = 2,
	
	UsefulStats = { "Agility", "Melee Hit", "Crit", "Haste" },
	
	FlashInCombat = function()
		
		-- adjust resources/cooldowns to reflect casting & queued spells
		local casting = c.GetCastingInfo()
		local queued = c.GetQueuedInfo()
		a.NextSSIsImproved = getImprovedStatus(casting, nextSSIsImproved)
		a.NextSSIsImproved = getImprovedStatus(queued, a.NextSSIsImproved)
		a.CSCool = c.GetCooldown("Chimera Shot", false, 9)
		
		-- flash
		c.FlashAll(
			"Fervor", 
			"Exhilaration", 
			"Heart of the Phoenix",
			"Growl",
			"Cower",
			"Last Stand",
			"Bullheaded",
			"Mend Pet at 50",
			"Counter Shot",
			"Tranquilizing Shot")
		c.PriorityFlash(
			"Steady Shot 2",
			"Chimera Shot to save Serpent Sting",
			"Serpent Sting",
			"Stampede for Marksmanship",
			"A Murder of Crows",
			"Lynx Rush",
			"Dire Beast",
			"Chimera Shot",
			"Kill Shot",
			"Glaive Toss",
			"Rapid Fire",
			"Steady Shot Opportunistic",
			"Arcane Shot under Thrill of the Hunt",
			"Powershot", 
			"Aimed Shot",
			"Arcane Shot for Marksmanship",
			"Barrage",
			"Mend Pet",
			"Steady Shot")
	end,
	
	FlashOutOfCombat = function()
		c.FlashAll("Mend Pet")
	end,
	
	FlashAlways = function()
		c.FlashAll(
			"Aspect of the Hawk", 
			"Aspect of the Iron Hawk", 
			"Call Pet", 
			"Revive Pet")
	end,
	
	CastQueued = adjustCost,
	
	CastSucceeded = function(info)
		nextSSIsImproved = getImprovedStatus(info, nextSSIsImproved)
	end,
	
	ExtraDebugInfo = function()
		return string.format("%.1f %s %.1f", 
			a.Focus, tostring(a.NextSSIsImproved), a.CSCool)
	end,
}

---------------------------------------------------------------------- Survival
a.Rotations.Survival = {
	Spec = 3,
	
	UsefulStats = { "Agility", "Melee Hit", "Crit", "Haste" },
	
	FlashInCombat = function()
		c.FlashAll(
			"Fervor", 
			"Exhilaration", 
			"Heart of the Phoenix",
			"Growl",
			"Cower",
			"Last Stand",
			"Bullheaded",
			"Mend Pet at 50",
			"Counter Shot",
			"Tranquilizing Shot")
		c.PriorityFlash(
			"Serpent Sting",
			"Cobra Shot for Serpent Sting",
			"Stampede",
			"A Murder of Crows",
			"Lynx Rush",
			"Black Arrow",
			"Dire Beast",
			"Kill Shot",
			"Explosive Shot",
			"Glaive Toss",
			"Arcane Shot under Thrill of the Hunt",
			"Powershot",
			"Arcane Shot for Survival",
			"Rapid Fire",
			"Barrage",
			"Mend Pet",
			"Cobra Shot")
	end,
	
	FlashOutOfCombat = function()
		c.FlashAll("Mend Pet")
	end,
	
	FlashAlways = function()
		c.FlashAll(
			"Aspect of the Hawk",
			"Aspect of the Iron Hawk", 
			"Call Pet", 
			"Revive Pet")
	end,
	
	CastQueued = adjustCost,
	
	ExtraDebugInfo = function()
		return string.format("%.1f", a.Focus)
	end,
}
