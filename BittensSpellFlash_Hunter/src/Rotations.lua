local AddonName, a = ...
if a.BuildFail(50000) then return end
local L = a.Localize
local s = SpellFlashAddon
local c = BittensSpellFlashLibrary

local GetPowerRegen = GetPowerRegen
local GetTime = GetTime
local math = math
local pairs = pairs
local select = select

function a.FocusAdded()
	local added = 14
	if c.WearingSet(2, "T13") then
		added = 2 * added
	end
	return added
end

local function adjustCost(info)
	if c.InfoMatches(info, "Cobra Shot") then
		info.Cost = -a.FocusAdded()
	elseif c.InfoMatches(info, "Fervor") then
		info.Cost = -50
	end
end

a.Focus = 0
a.Rotations = {}
c.RegisterForEvents(a)
a.SetSpamFunction(function()
	c.Init(a)
	a.Regen = select(2, GetPowerRegen())
	if c.HasBuff("Fervor") or c.IsAuraPendingFor("Fervor") then
		a.Regen = a.Regen + 5
	end
	adjustCost(c.GetCastingInfo())
	adjustCost(c.GetQueuedInfo())
	a.Focus = c.GetPower(a.Regen)
	if c.IsCasting("Fervor") then
		a.Focus = math.min(100, a.Focus + 50)
	end
	c.Flash(a)
end)

----------------------------------------------------------------- Beast Mastery
a.Rotations.BeastMastery = {
	Spec = 1,
	OffSwitch = "bm_off",
	
	FlashInCombat = function()
		c.FlashAll(
			"Hunter's Mark", 
			"Focus Fire",
			"Kiroptyric Sigil")
--c.Debug("Flash", string.format("%.1f", a.Focus),
		c.PriorityFlash(
			"Serpent Sting", 
			"Fervor",
			"Bestial Wrath",
			"Kill Shot",
			"A Murder of Crows",
			"Blink Strike",
			"Lynx Rush",
			"Rapid Fire for BM",
			"Kill Command",
			"Dire Beast",
			"Arcane Shot under Thrill of the Hunt",
			"Readiness",
			"Arcane Shot for BM",
			"Focus Fire",
			"Cobra Shot")
--)
	end,
	
	FlashAlways = function()
		c.FlashAll("Aspect of the Hawk", "Mend Pet", "Call Pet")
	end,
}

---------------------------------------------------------------------- Survival
a.Rotations.Survival = {
	Spec = 3,
	OffSwitch = "survival_off",
	
	FlashInCombat = function()
		c.FlashAll(
			"Hunter's Mark", 
			"Kiroptyric Sigil")
c.Debug("Flash", string.format("%.1f", a.Focus),
		c.PriorityFlash(
			"A Murder of Crows",
			"Blink Strike",
			"Lynx Rush",
			"Explosive Shot under Lock and Load",
			"Serpent Sting",
			"Explosive Shot",
			"Kill Shot",
			"Black Arrow",
			"Arcane Shot under Thrill of the Hunt",
			"Dire Beast",
			"Rapid Fire",
			"Readiness",
			"Fervor",
			"Cobra Shot for Serpent Sting",
			"Arcane Shot",
			"Cobra Shot")
)
	end,
	
	FlashAlways = function()
		c.FlashAll("Aspect of the Hawk", "Mend Pet", "Call Pet")
	end,
}
