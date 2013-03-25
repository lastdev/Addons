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

a.Rotations = {}

function a.PreFlash()
	bcm.UpdateVisibility()
	
	local mana = c.GetPower(select(2, GetPowerRegen()))
	a.ManaPercent = mana / s.MaxPower("player") * 100
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
		
		c.FlashAll(
			"Arcane Power",
			"Alter Time for Arcane", 
			"Rune of Power",
			"Evocation for Arcane",
			"Evocation Interrupt",
			"Mirror Image",
			"Mana Gem",
			"Brilliant Mana Gem",
			"Counterspell", 
			"Spellsteal")
		if c.AoE then
			c.PriorityFlash(
				"Nether Tempest",
				"Living Bomb",
				"Frost Bomb",
				"Flamestrike",
				"Arcane Barrage for AoE",
				"Arcane Missiles for AoE",
				"Arcane Explosion",
				"Arcane Blast")
		else
			c.PriorityFlash(
				"Arcane Barrage if Losing Stacks",
				"Nether Tempest",
				"Living Bomb",
				"Frost Bomb",
				"Arcane Missiles",
				"Arcane Barrage",
				"Presence of Mind",
				"Arcane Blast")
		end
	end,
	
	FlashOutOfCombat = function()
		c.FlashAll("Conjure Mana Gem", "Evocation for Health")
	end,
	
	FlashAlways = function()
		c.FlashAll(
			"Mage Armor",
			"Arcane Brilliance",
			"Dalaran Brilliance")
	end,
	
	ExtraDebugInfo = function()
		return string.format("%d, %d, %.1f, %.1f",
			a.MissilesStacks, a.ChargeStacks, a.ChargeDuration, a.ManaPercent)
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
			"Counterspell", 
			"Spellsteal", 
			"Mana Gem", 
			"Brilliant Mana Gem",
			"Rune of Power",
			"Evocation for Invoker's Energy")
		c.PriorityFlash(
			"Combustion when Big",
			"Pyroblast",
			"Inferno Blast",
			"Nether Tempest",
			"Living Bomb",
			"Frost Bomb",
			"Combustion",
			"Mirror Image",
			"Presence of Mind",
			"Evocation",
			"Scorch",
			"Frostfire Bolt",
			"Fireball")
	end,
	
	FlashOutOfCombat = function()
		c.FlashAll("Conjure Mana Gem", "Evocation for Health")
	end,
	
	FlashAlways = function()
		c.FlashAll(
			"Molten Armor",
			"Arcane Brilliance",
			"Dalaran Brilliance")
	end,
	
	CastSucceeded = function(info)
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
    
    FlashInCombat = function()
        c.FlashAll(
        	"Deep Freeze",
            "Counterspell",
            "Spellsteal",
            "Presence of Mind",
			"Rune of Power")
        c.PriorityFlash(
        	"Ice Lance within 2",
        	"Frost Bomb",
        	"Living Bomb",
        	"Nether Tempest",
            "Frozen Orb",
            "Icy Veins", 
            "Mirror Image",
            "Evocation for Invoker's Energy",
            "Ice Lance within 5",
            "Frostbolt for Debuff",
            "Freeze",
            "Ice Lance",
            "Frostfire Bolt under Brain Freeze",
            "Mana Gem",
            "Evocation",
            "Frostbolt")
    end,
    
    FlashOutOfCombat = function()
        c.FlashAll("Conjure Mana Gem", "Evocation for Health")
    end,
    
    FlashAlways = function()
        c.FlashAll(
            "Frost Armor", 
            "Summon Water Elemental", 
            "Arcane Brilliance", 
            "Dalaran Brilliance")
    end,
    
    CastSucceeded = function(info)
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
    	return string.format("%d, %d", a.FingerCount, blizzFingerCount)
    end
}
