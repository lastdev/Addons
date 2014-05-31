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
		a.Mana = 
			100 * c.GetPower(select(2, GetPowerRegen())) / s.MaxPower("player")
		if c.HasBuff("Lucidity") then
			a.Conserve = false
			a.Neutral = false
			a.OnlyHeal = false
		else
			a.Conserve = a.Mana < c.GetOption("ConservePercent")
			if c.IsSolo() then
				a.Neutral = false
				a.OnlyHeal = false
			else
				a.Neutral = a.Mana < c.GetOption("NeutralPercent")
				a.OnlyHeal = a.Mana < c.GetOption("OnlyHealPercent")
			end
		end
		
		local now = GetTime()
		local start, duration = GetSpellCooldown(c.GetID("Penance"))
		local cdUp = start + duration
		a.PenanceCD = cdUp - now - c.GetBusyTime()
		if now - penDropPend < .8 then
			if cdUp < penCdUp or cdUp < now then
				penDropPend = 0
				c.Debug("Event", "Penance CD drop happened")
			else
				a.PenanceCD = a.PenanceCD - .5
			end
		end
		penCdUp = cdUp
		if c.IsCasting("Penance") then
			a.PenanceCD = 9
		elseif c.IsCasting("Smite") then
			a.PenanceCD = a.PenanceCD - .5
		end
		a.PenanceCD = math.max(0, a.PenanceCD)
		
		c.FlashAll(
			"Shadowfiend", 
			"Mindbender", 
			"Soothing Talisman of the Shado-Pan Assault",
			"Desperate Prayer", 
			"Dispel Magic")
		if a.OnlyHeal and not a.HealingNeeded then
			c.PriorityFlash("Power Word: Solace")
		elseif a.Conserve then
			c.FlashAll("Power Infusion")
			c.DelayPriorityFlash(
				"Power Word: Solace",
				"Penance",
				"Penance Delay",
				"Holy Fire",
				"Shadow Word: Death",
				"Shadow Word: Pain Refresh",
				"Smite Glyphed",
				"Smite")
		else
			c.FlashAll("Power Infusion")
			c.DelayPriorityFlash(
				"Shadow Word: Pain Apply",
				"Shadow Word: Death",
				"Penance",
				"Power Word: Solace",
				"Holy Fire",
				"Shadow Word: Pain Refresh",
				"Penance Delay",
				"Smite Glyphed",
				"Smite")
		end
	end,
	
	FlashAlways = function()
		c.FlashAll("Power Word: Fortitude", "Inner Fire")
	end,
	
	CastSucceeded = function(info)
		if c.InfoMatches(info, "Smite") then
			penDropPend = GetTime()
			c.Debug("Event", "Penance Drop Queued")
		end
	end,
	
	ExtraDebugInfo = function()
		return string.format("b:%.1f m:%.1f c:%s n:%s o:%s n:%s p:%.1f p:%.1f", 
			c.GetBusyTime(),
			a.Mana, 
			tostring(a.Conserve),
			tostring(a.Neutral),
			tostring(a.OnlyHeal),
			tostring(a.HealingNeeded),
			a.PenanceCD,
			s.SpellCooldown(c.GetID("Penance")))
	end,
}
