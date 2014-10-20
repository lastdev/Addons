local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetPowerRegen = GetPowerRegen
local GetSpellCooldown = GetSpellCooldown
local GetTime = GetTime
local UnitInRange = UnitInRange
local UnitIsDeadOrGhost = UnitIsDeadOrGhost
local UnitIsUnit = UnitIsUnit
local math = math
local select = select
local string = string
local tostring = tostring

a.Rotations = {}

local function setHealingNeeded()
	for unit in c.GetGroupMembers() do
		if s.HealthPercent(unit) < c.GetOption("HealPercent")
			and (UnitInRange(unit) or UnitIsUnit(unit, "player"))
			and not UnitIsDeadOrGhost(unit) then
			
			a.HealingNeeded = true
			return
		end
	end
	a.HealingNeeded = false
end

local penCdUp = 0
local penDropPend = 0

a.Rotations.Atonement = {
	Spec = 1,
	
	UsefulStats = { "Intellect", "Spirit", "Crit", "Haste" },
	
	FlashInCombat = function()
		setHealingNeeded()
		
		a.PenanceCD = c.GetCooldown("Penance", false, 9)
		a.HasSolace = c.HasTalent("Power Word: Solace")
		
		c.FlashAll(
			"Shadowfiend", 
			"Mindbender", 
			"Soothing Talisman of the Shado-Pan Assault",
			"Desperate Prayer", 
			"Dispel Magic",
			"Power Infusion",
			"Silence")
		c.DelayPriorityFlash(
			"Shadow Word: Pain Apply",
			"Power Word: Solace Glyphed",
			"Penance",
			"Holy Fire Glyphed",
			"Power Word: Solace",
			"Holy Fire",
			"Shadow Word: Pain Refresh",
			"Smite Glyphed",
			"Penance Delay",
			"Smite")
	end,
	
	FlashAlways = function()
		c.FlashAll("Power Word: Fortitude")
	end,
	
	ExtraDebugInfo = function()
		return string.format("b:%.1f n:%s p:%.1f", 
			c.GetBusyTime(), tostring(a.HealingNeeded), a.PenanceCD)
	end,
}
