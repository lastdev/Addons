local addonName, a = ...
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetPowerRegen = GetPowerRegen
local GetTime = GetTime
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
		info.Cost = -a.FocusAdded(
			info.CastStart + s.CastTime(info.Name) - GetTime())
	elseif c.InfoMatches(info, "Fervor") then
		info.Cost = -50
	end
end

a.Rotations = {}

function a.PreFlash()
	a.Regen = select(2, GetPowerRegen())
	if c.HasBuff("Fervor") or c.IsAuraPendingFor("Fervor") then
		a.Regen = a.Regen + 5
	end
	if c.HasBuff("Rapid Recuperation") then
		a.Regen = a.Regen + 4
	end
	adjustCost(c.GetCastingInfo())
	adjustCost(c.GetQueuedInfo())
	a.Focus = c.GetPower(a.Regen)
	if c.IsCasting("Fervor") then
		a.Focus = math.min(100, a.Focus + 50)
	end
end

----------------------------------------------------------------- Beast Mastery
a.Rotations.BeastMastery = {
	Spec = 1,
	
	FlashInCombat = function()
		c.FlashAll("Fervor", "Bestial Wrath")
		c.PriorityFlash(
			"Serpent Sting", 
			"Cobra Shot for Serpent Sting",
			"Stampede",
			"A Murder of Crows",
			"Lynx Rush",
			"Dire Beast",
			"Kill Shot",
			"Blink Strike",
			"Kill Command",
			"Glaive Toss",
			"Arcane Shot under Thrill of the Hunt",
			"Focus Fire",
			"Powershot",
			"Readiness",
			"Arcane Shot for BM",
			"Rapid Fire for BM",
			"Barrage",
			"Cobra Shot")
	end,
	
	FlashAlways = function()
		c.FlashAll(
			"Aspect of the Hawk",
			"Aspect of the Iron Hawk", 
			"Mend Pet", 
			"Call Pet")
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
	"Blink Strike",
	"Dire Beast",
	"Serpent Sting",
	"Multi-Shot",
-- Perhaps the below are not worth including, since they are not part of the
-- rotation
--	"Distracting Shot",
--	"Tranquilizing Shot",
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
-- Readiness
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
	
	FlashInCombat = function()
		
		-- adjust resources/cooldowns to reflect casting & queued spells
		local casting = c.GetCastingInfo()
		local queued = c.GetQueuedInfo()
		a.NextSSIsImproved = getImprovedStatus(casting, nextSSIsImproved)
		a.NextSSIsImproved = getImprovedStatus(queued, a.NextSSIsImproved)
		if c.InfoMatches(queued, "Chimera Shot") then
			a.CSCool = 10
		else
			a.CSCool = c.GetCooldown("Chimera Shot")
		end
		
		-- flash
		c.FlashAll("Fervor")
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
			"Blink Strike",
			"Rapid Fire",
			"Readiness",
			"Steady Shot Opportunistic",
			"Arcane Shot under Thrill of the Hunt",
			"Powershot", 
			"Aimed Shot",
			"Arcane Shot for Marksmanship",
			"Barrage",
			"Steady Shot")
	end,
	
	FlashAlways = function()
		c.FlashAll(
			"Aspect of the Hawk", 
			"Aspect of the Iron Hawk", 
			"Mend Pet", 
			"Call Pet")
	end,
	
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
	
	FlashInCombat = function()
		c.FlashAll("Fervor")
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
			"Blink Strike",
			"Arcane Shot under Thrill of the Hunt",
			"Powershot",
			"Readiness",
			"Arcane Shot for Survival",
			"Rapid Fire",
			"Barrage",
			"Cobra Shot")
	end,
	
	FlashAlways = function()
		c.FlashAll(
			"Aspect of the Hawk",
			"Aspect of the Iron Hawk", 
			"Mend Pet", 
			"Call Pet")
	end,
	
	ExtraDebugInfo = function()
		return string.format("%.1f", a.Focus)
	end,
}
