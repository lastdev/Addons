local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")
local bcm = a.BCM

local GetPowerRegen = GetPowerRegen
local GetTime = GetTime
local math = math
local select = select
local string = string
local tostring = tostring

a.LastRuneCast = 0

local function processCast(info)
	if c.InfoMatches(info, "Rune of Power") then
		a.LastRuneCast = GetTime()
		c.Debug("Event", "Rune of Power cast")
	end
end

a.Rotations = {}

function a.PreFlash()
	bcm.UpdateVisibility()
	
	local mana = c.GetPower(select(2, GetPowerRegen()))
	a.ManaPercent = mana / s.MaxPower("player") * 100
	a.AlterTime = c.HasBuff("Alter Time", false, false, true)
end

s.AddSettingsListener(
	function()
		bcm.UpdateVisibility()
	end
)

------------------------------------------------------------------------ Arcane
local chargeStart

local function bumpChargesAt(time)
	if time - chargeStart < 10 then
		a.ChargeStacks = math.min(4, a.ChargeStacks + 1)
	else
		a.ChargeStacks = 1
	end
	chargeStart = time
end

a.Rotations.Arcane = {
	Spec = 1,
	
	UsefulStats = { "Intellect", "Spell Hit", "Crit", "Haste" },
	
	FlashInCombat = function()
		a.ChargeStacks = s.DebuffStack(c.GetID("Arcane Charge"), "player")
		chargeStart = GetTime() 
			+ s.DebuffDuration(c.GetID("Arcane Charge"), "player") 
			- 10
		
		a.MissilesStacks = c.GetBuffStack("Arcane Missiles!")
		if c.IsQueued("Arcane Missiles") then
			a.MissilesStacks = a.MissilesStacks - 1
		end
		
		local info = c.GetCastingInfo()
		if info then
			if c.InfoMatches(info, "Arcane Blast", "Arcane Missiles") then
				bumpChargesAt(
					GetTime() + s.GetCastingOrChanneling(nil, "player"))
			elseif c.InfoMatches(info, "Arcane Barrage") then
				a.ChargeStacks = 0
			end
		end
		
		info = c.GetQueuedInfo()
		if info then
			if c.InfoMatches(info, "Arcane Blast", "Arcane Missiles") then
				bumpChargesAt(
					info.CastStart + s.CastTime(c.GetID("Arcane Blast")))
			elseif c.InfoMatches(info, "Arcane Barrage") then
				a.ChargeStacks = 0
			end
		end
		
		if a.ChargeStacks == 0 then
			a.ChargeDuration = 0
		else
			a.ChargeDuration = math.max(
				0, chargeStart + 10 - GetTime() - c.GetBusyTime())
			if a.ChargeDuration == 0 then
				a.ChargeStacks = 0
			end
		end
		
		a.ArcanePower = c.HasBuff("Arcane Power", false, false, true)
		
		c.FlashAll(
			"Arcane Power",
			"Presence of Mind before AT",
			"Alter Time for Arcane", 
			"Rune of Power",
			"Evocation for Arcane",
			"Evocation Interrupt",
			"Mirror Image",
			"Mana Gem",
			"Brilliant Mana Gem",
			"Cold Snap",
			"Counterspell", 
			"Spellsteal")
		if c.AoE then
			c.PriorityFlash(
				"Nether Tempest",
				"Living Bomb",
				"Frost Bomb",
				"Presence of Mind before Flamestrike",
				"Flamestrike",
				"Arcane Explosion",
				"Arcane Barrage for AoE",
				"Arcane Missiles for AoE",
				"Arcane Blast")
		else
			c.PriorityFlash(
				"Arcane Barrage if Losing Stacks",
				"Nether Tempest",
				"Living Bomb",
				"Frost Bomb",
				"Arcane Missiles",
				"Arcane Barrage",
				"Presence of Mind before AB",
				"Arcane Blast")
		end
	end,
	
	MovementFallthrough = function()
		c.PriorityFlash(
			"Arcane Barrage when Moving",
			"Fire Blast",
			"Ice Lance")
	end,
	
	FlashOutOfCombat = function()
		c.FlashAll(
			"Conjure Mana Gem", 
			"Evocation for Health",
			"Evocation for Invoker's Energy Pre-Combat",
			"Rune of Power Pre-Combat")
	end,
	
	FlashAlways = function()
		c.FlashAll(
			"Mage Armor",
			"Arcane Brilliance",
			"Dalaran Brilliance",
			"Ice Barrier")
	end,
	
	CastSucceeded = processCast,
	
	ExtraDebugInfo = function()
		return string.format("m:%d c:%d c:%.1f m:%.1f a:%s",
			a.MissilesStacks, 
			a.ChargeStacks, 
			a.ChargeDuration, 
			a.ManaPercent,
			tostring(a.AlterTime))
	end
}

-------------------------------------------------------------------------- Fire
local str
local pendingNaturalCrit = false
local pendingBlast = false
local consumerLandedAt = 0
local affectsCritStreak = {
	[c.GetID("Combustion")] = true,
	[c.GetID("Fireball")] = "delay",
	[c.GetID("Frostfire Bolt")] = "delay",
--	[c.GetID("Inferno Blast")] = true,
	[c.GetID("Pyroblast")] = "delay",
	[c.GetID("Scorch")] = "delay",
}

local function applyFireProc()
	if a.HeatingProc then
		a.HeatingProc = false
		a.PyroProc = true
	else
		a.HeatingProc = true
	end
end

a.Rotations.Fire = {
	Spec = 2,
	
	UsefulStats = { "Intellect", "Spell Hit", "Crit", "Haste" },
	
	FlashInCombat = function()
		
		-- Manage Pyroblast! and Heating Up
		a.HeatingProc = c.HasBuff("Heating Up")
		a.PyroProc = c.HasBuff("Pyroblast!")
str = "(" .. (a.HeatingProc and "true" or "false") .. "," .. (a.PyroProc and "true" or "false") .. ")->"
		if pendingBlast or c.IsCastingOrInAir("Inferno Blast") then
str = str .. "pendingBlast->"
			applyFireProc()
		end
		if pendingNaturalCrit then
str = str .. "naturalCrit->"
			applyFireProc()
		end
		if a.HeatingProc then
			local endDelay = c.GetBusyTime() - .01
			if GetTime() - consumerLandedAt < 1
				or c.CountLandings("Fireball", -3, endDelay, false) > 0 
				or c.CountLandings("Pyroblast", -3, endDelay, false) > 0
				or c.CountLandings("Frostfire Bolt", -3, endDelay, false) > 0
				or c.CountLandings("Scorch", -3, endDelay, false) > 0 
				or c.IsCastingOrInAir("Combustion") then
				
str = str .. "landingDirties->"
				a.HeatingProc = false
			
--c.Debug("dirty", endDelay,
--	GetTime() - consumerLandedAt < 1,
--	c.CountLandings("Fireball", -3, endDelay, false),
--	c.CountLandings("Pyroblast", -3, endDelay, false),
--	c.CountLandings("Frostfire Bolt", -3, endDelay, false),
--	c.CountLandings("Scorch", -3, endDelay, false),
--	c.IsCastingOrInAir("Combustion")
--)
			end
		end
		if a.PyroProc and c.IsCasting("Pyroblast") then
str = str .. "pyroConsume->"
			a.PyroProc = false
		end
		
		-- Flash
		c.FlashAll(
			"Combustion",
			"Alter Time for Fire",
			"Presence of Mind for Fire",
			"Rune of Power for Fire",
			"Evocation for Invoker's Energy for Fire",
			"Cold Snap",
			"Counterspell", 
			"Spellsteal")
		c.PriorityFlash(
			"Pyroblast",
			"Inferno Blast",
			"Mirror Image",
			"Nether Tempest",
			"Living Bomb",
			"Frost Bomb",
			"Evocation for Invoker's Energy at 5",
			"Rune of Power at 5",
			"Mana Gem at 10",
			"Brilliant Mana Gem at 10",
			"Evocation",
			"Frostfire Bolt",
			"Fireball")
	end,
	
	MovementFallthrough = function()
		c.FlashAll("Scorch")
	end,
	
	FlashOutOfCombat = function()
		c.FlashAll(
			"Conjure Mana Gem", 
			"Evocation for Health",
			"Evocation for Invoker's Energy Pre-Combat",
			"Rune of Power Pre-Combat")
	end,
	
	FlashAlways = function()
		c.FlashAll(
			"Molten Armor",
			"Arcane Brilliance",
			"Dalaran Brilliance",
			"Ice Barrier")
	end,
	
	CastSucceeded = function(info)
		processCast(info)
		if c.InfoMatches(info, "Inferno Blast") then
			pendingBlast = true
			c.Debug("Event", "blast pending")
		end
	end,
	
	SpellMissed = function(spellID)
		if spellID == c.GetID("Inferno Blast") then
			pendingBlast = false
			c.Debug("Event", "blast missed")
		end
	end,
	
	SpellDamage = function(spellID, _, _, critical, isTick)
		if affectsCritStreak[spellID] and not isTick then
			if critical then
				pendingNaturalCrit = true
			else
				pendingNaturalCrit = false
				consumerLandedAt = GetTime()
			end
			c.Debug("Event", s.SpellName(spellID), "crit?:", critical)
		end
	end,
	
	AuraApplied = function(spellID)
		if spellID == c.GetID("Pyroblast!")
			or spellID == c.GetID("Heating Up") then
			
			pendingNaturalCrit = false
			pendingBlast = false
			consumerLandedAt = 0
			c.Debug("Event", s.SpellName(spellID), "applied")
		end
	end,
	
	AuraRemoved = function(spellID)
		if spellID == c.GetID("Pyroblast!")
			or spellID == c.GetID("Heating Up") then
			
			pendingNaturalCrit = false
			pendingBlast = false
			consumerLandedAt = 0
			c.Debug("Event", s.SpellName(spellID), "removed")
		end
	end,
	
	LeftCombat = function()
		bcm.UpdateVisibility()
	end,
	
	ExtraDebugInfo = function()
		return string.format("%s (%s, %s)", 
			str, tostring(not not a.HeatingProc), tostring(not not a.PyroProc))
	end
}

------------------------------------------------------------------------- Frost
local blizzFingerCount = -1
a.FingerCount = blizzFingerCount

a.Rotations.Frost = {
	Spec = 3,
	
	UsefulStats = { "Intellect", "Spell Hit", "Crit", "Haste" },
	
	FlashInCombat = function()
		a.BrainFreeze = c.HasBuff("Brain Freeze") 
			and not c.IsCasting("Frostfire Bolt")
		if c.HasGlyph("Icy Veins") then
			a.VeinsID = c.GetID("Icy Veins Glyphed")
		else
			a.VeinsID = c.GetID("Icy Veins")
		end
		a.VeinsCD = c.GetCooldown(a.VeinsID)
		a.HoldProcs =
			((c.HasGlyph("Icy Veins") and a.VeinsCD < 2)
					or c.GetCooldown("Alter Time") < 2)
				and not c.IsSolo()
		
		c.FlashAll(
			"Mirror Image",
			"Evocation for Invoker's Energy for Frost",
			"Rune of Power for Frost",
			"Frozen Orb",
			"Icy Veins",
			"Presence of Mind for Frost", 
			"Alter Time for Frost",
			"Freeze",
			"Deep Freeze",
			"Cold Snap",
			"Counterspell",
			"Spellsteal")
		c.PriorityFlash(
			"Frostfire Bolt Prime",
			"Ice Lance Prime",
			"Nether Tempest",
			"Living Bomb",
			"Frost Bomb",
			"Frostfire Bolt under Brain Freeze",
			"Ice Lance before Cap",
			"Ice Lance when Frozen",
			"Evocation for Invoker's Energy at 5",
			"Rune of Power at 5",
			"Mana Gem at 10",
			"Brilliant Mana Gem at 10",
			"Evocation",
			"Frostbolt")
	end,
	
	MovementFallthrough = function()
		c.PriorityFlash("Fire Blast", "Ice Lance")
	end,
	
	FlashOutOfCombat = function()
		c.FlashAll(
			"Conjure Mana Gem", 
			"Evocation for Health",
			"Evocation for Invoker's Energy Pre-Combat",
			"Rune of Power Pre-Combat")
	end,
	
	FlashAlways = function()
		c.FlashAll(
			"Frost Armor", 
			"Summon Water Elemental", 
			"Arcane Brilliance", 
			"Dalaran Brilliance",
			"Ice Barrier")
	end,
	
	CastSucceeded = function(info)
		processCast(info)
		if c.InfoMatches(info, "Ice Lance") then
			a.FingerCount = math.max(0, a.FingerCount - 1)
			c.Debug("Event", "Pretend FoF is now at", a.FingerCount)
		end
	end,
	
	AuraApplied = function(spellID)
		if spellID == c.GetID("Fingers of Frost") then
			local stack = c.GetBuffStack("Fingers of Frost")
			if a.FingerCount == blizzFingerCount - 1 then
				a.FingerCount = stack - 1
			else
				a.FingerCount = stack
			end
			c.Debug("Event",
				"Gained FoF. Stack =", stack, "Pretend =", a.FingerCount)
			blizzFingerCount = stack
		end
	end,
	
	AuraRemoved = function(spellID)
		if spellID == c.GetID("Fingers of Frost") then
			local stack = c.GetBuffStack("Fingers of Frost")
			a.FingerCount = stack
			c.Debug("Event", "Lost FoF. Stack =", stack)
			blizzFingerCount = stack
		end
	end, 
	
	ExtraDebugInfo = function()
		return string.format("f:%d, f:%d h:%s f:%d b:%s a:%s", 
			blizzFingerCount, 
			a.FingerCount, 
			tostring(a.HoldProcs), 
			a.FBStacks, 
			tostring(a.BrainFreeze),
			tostring(a.AlterTime))
	end
}
