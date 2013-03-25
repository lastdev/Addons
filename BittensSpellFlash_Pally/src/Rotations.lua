local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local SPELL_POWER_HOLY_POWER = SPELL_POWER_HOLY_POWER
local math = math
local select = select
local string = string

local function castGivesHP(info)
	return c.InfoMatches(info, "Holy Radiance")
		or (c.InfoMatches(info, "Divine Light")
			and s.MyBuff(c.GetID("Beacon of Light"), info.Target))
end

local selflessStackPending = false
local selflessClearPending = false

local function bumpHolyPower()
	if s.Buff(c.GetID("Holy Avenger"), "player") then
		a.HolyPower = math.min(5, a.HolyPower + 3)
	else
		a.HolyPower = math.min(5, a.HolyPower + 1)
	end
end

a.Rotations = {}

function a.PreFlash()
	
	-- calculate holy power
	a.HolyPower = s.Power("player", SPELL_POWER_HOLY_POWER)
    
    -- bump it from spells that are casting
    local info = c.GetCastingInfo()
    if castGivesHP(info) then
        bumpHolyPower()
    end
    
    -- bump/consume it from spells that are queued
    a.RawHolyPower = -1
	if c.IsQueued(
		"Inquisition", 
		"Templar's Verdict", 
		"Shield of the Righteous", 
		"Word of Glory", 
		"Eternal Flame",
		"Light of Dawn") then
		
		if not s.Buff(c.GetID("Divine Purpose"), "player") then
			a.HolyPower = math.max(0, a.HolyPower - 3)
		end
	else
		local info = c.GetQueuedInfo()
		if c.IsQueued(
				"Crusader Strike", 
				"Hammer of the Righteous",
				"Exorcism",
				"Hammer of Wrath")
			or (c.IsQueued("Judgment") 
				and s.HasSpell(c.GetID("Judgments of the Bold")))
			or (c.IsQueued("Avenger's Shield")
				and s.Buff(c.GetID("Grand Crusader"), "player"))
	    	or castGivesHP(info) then
			
			bumpHolyPower()
		end
		if s.Buff(c.GetID("Divine Purpose"), "player") then
			a.RawHolyPower = a.HolyPower
			a.HolyPower = math.max(3, a.HolyPower)
		end
	end
	if a.RawHolyPower < 0 then
		a.RawHolyPower = a.HolyPower
	end
	
	-- selfless healer monitoring
	a.SelflessHealer = c.GetBuffStack("Selfless Healer")
	if c.HasTalent("Selfless Healer") then
		if selflessStackPending then
			a.SelflessHealer = math.min(3, a.SelflessHealer + 1)
		end
		if selflessClearPending then
			a.SelflessHealer = 0
		end
		if c.IsQueued("Judgment") then
			a.SelflessHealer = math.min(3, a.SelflessHealer + 1)
		elseif c.IsQueued("Flash of Light") then
			a.SelflessHealer = 0
		end
	end
end

local function selflessTriggerMonitor(info)
	if c.HasTalent("Selfless Healer") then
		if c.InfoMatches(info, "Judgment") then
			selflessStackPending = true
			c.Debug("Event", "Selfless Healer stack pending")
		elseif c.InfoMatches(info, "Flash of Light") then
			selflessClearPending = true
			c.Debug("Event", "Selfless Healer clear pending")
		end
	end
end

local function clearSelflessPending(spellID, applicableSpell)
	if spellID == c.GetID(applicableSpell) 
		and c.HasTalent("Selfless Healer") then
		
		selflessStackPending = false
		c.Debug("Event", "Selfless Healer stack applied (or failed)")
	end
end

local function clearSelflessMonitor(spellID)
	if c.HasTalent("Selfless Healer") then
		if spellID == c.GetID("Selfless Healer") then
			selflessClearPending = false
			c.Debug("Event", "Selfless Healer cleared")
		end
	end
end

local function flashRaidBuffs()
	local duration = 0
	if not s.InCombat() then
		if s.InRaidOrParty() then
			duration = 5 * 60
		else
			duration = 2 * 60
		end
	end
	
	-- if I have my own kings, make sure everyone else does too
	if s.MyBuff(c.GetID("Blessing of Kings"), "player") then
		if not s.Buff(c.STAT_BUFFS, "raid|all|range", duration) then
			c.FlashAll("Blessing of Kings")
		end
		return
	end
	
	-- if I have my own might, make sure everyone else does too
	if s.MyBuff(c.GetID("Blessing of Might"), "player") then
		if not s.Buff(c.MASTERY_BUFFS, "raid|all|range", duration) then
			c.FlashAll("Blessing of Might")
		end
		return
	end
	
	-- check the raid for both kings and might
	if not s.Buff(c.STAT_BUFFS, "raid|all|range", duration) then
		c.FlashAll("Blessing of Kings")
	end
	if not s.Buff(c.MASTERY_BUFFS, "raid|all|range", duration) then
		c.FlashAll("Blessing of Might")
	end
end

-------------------------------------------------------------------------- Holy
a.Rotations.Holy = {
	Spec = 1,
	
	FlashInCombat = function()
c.Debug("Flash", a.HolyPower)
		c.FlashAll(
			"Sacred Shield for Holy",
			"Word of Glory for Holy",
			"Eternal Flame for Holy",
			"Light of Dawn for Holy",
			"Holy Shock under 5 with Daybreak",
			"Judgment to Save Selfless Healer",
			"Flash of Light to Save Selfless Healer",
			"Flash of Light under Selfless Healer",
			"Rebuke")
	end,
	
	FlashAlways = function()
		c.FlashAll("Seal of Insight", "Beacon of Light")
		flashRaidBuffs()
	end,
	
	AuraApplied = function(spellID, target)
		if spellID == c.GetID("Beacon of Light") then
			a.BeaconTarget = target
			c.Debug("Event", "Beacon target:", target)
		elseif spellID == c.GetID("Sacred Shield") then
			a.SacredShieldTarget = target
			c.Debug("Event", "Sacred Shield target:", target)
		end
	end,
}

-------------------------------------------------------------------------- Prot
local uncontrolledMitigationBuffs = { 
	"Devotion Aura",
	"Divine Shield",
	"Hand of Protection",
}

a.Rotations.Protection = {
	Spec = 2,
	
	FlashInCombat = function()
		c.FlashAll(
			"Avenging Wrath if Plain", 
			"Hand of Reckoning", 
			"Rebuke",
			"Word of Glory for Prot",
			"Shield of the Righteous to save Buffs",
			"Lay on Hands")

		c.FlashMitigationBuffs(
			1,
			uncontrolledMitigationBuffs,
			"Hand of Purity",
			"Divine Protection", 
			"Holy Avenger for Prot",
			"Ardent Defender 2pT14",
			"Avenging Wrath if Cool for Prot",
			"Guardian of Ancient Kings", 
			"Ardent Defender")
		
		local flashing = c.PriorityFlash(
			
			-- mitigation
			"Holy Wrath to Stun",
			"Hammer of the Righteous for Debuff",
			"Eternal Flame for Prot",
			"Sacred Shield for Prot",
			"Flash of Light for Prot",
			
			-- holy power
			"Crusader Strike",
			"Judgment",
			"Avenger's Shield under Grand Crusader",
			
			-- thinking ahead mitigation
			"Sacred Shield Refresh",
			
			-- damage
			"Avenger's Shield",
			"Hammer of Wrath",
			"Consecration",
			"Holy Wrath")
		
		if (flashing == "Hammer of the Righteous for Debuff"
				or flashing == "Crusader Strike"
				or flashing == "Judgment"
				or flashing == "Avenger's Shield under Grand Crusader")
			and a.HolyPower + (c.HasBuff("Holy Avenger") and 3 or 1) > 5 then
			
			c.FlashAll("Shield of the Righteous")
		end
	end,
	
	FlashAlways = function()
		c.FlashAll("Righteous Fury", "Seal of Insight for Prot")
		flashRaidBuffs()
	end,
	
	CastSucceeded = function(info)
		selflessTriggerMonitor(info)
	end,
	
	SpellMissed = function(spellID)
		clearSelflessPending(spellID, "Judgment")
	end,
	
	AuraApplied = function(spellID)
		clearSelflessPending(spellID, "Selfless Healer")
	end,
	
	AuraRemoved = clearSelflessMonitor,
	
	ExtraDebugInfo = function()
		return string.format("%s %s", a.HolyPower, a.SelflessHealer)
	end,
}

--------------------------------------------------------------------------- Ret
a.Rotations.Retribution = {
	Spec = 3,
	
	FlashInCombat = function()
		c.FlashAll(
			"Avenging Wrath for Ret", 
			"Holy Avenger", 
			"Lay on Hands", 
			"Rebuke")
		c.PriorityFlash(
			"Inquisition",
			"Execution Sentence",
			"Hammer of Wrath for Ret",
			"Inquisition before Templar's Verdict at 5",
			"Templar's Verdict at 5",
			"Exorcism",
			"Judgment unless Wastes GCD",
			"Crusader Strike",
			"Judgment",
			"Light's Hammer",
			"Holy Prism",
			"Inquisition before Templar's Verdict",
			"Templar's Verdict",
			"Sacred Shield for Ret")
	end,
	
	FlashAlways = function()
		c.FlashAll(
			"Seal of Truth", "Flash of Light for Ret", "Word of Glory for Ret")
		flashRaidBuffs()
	end,
	
	ExtraDebugInfo = function()
		return string.format("%s %s", a.HolyPower, a.RawHolyPower)
	end,
}
