local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local g = BittensGlobalTables
local c = g.GetTable("BittensSpellFlashLibrary")
local u = g.GetTable("BittensUtilities")

local GetSpecialization = GetSpecialization
local GetSpellBonusDamage = GetSpellBonusDamage
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

local function bumpHolyPower(amount)
	if s.Buff(c.GetID("Holy Avenger"), "player") then
		a.HolyPower = math.min(5, a.HolyPower + 3)
	else
		a.HolyPower = math.min(5, a.HolyPower + amount)
	end
end

a.Rotations = { }

function a.PreFlash()
	
	-- calculate holy power
	a.HolyPower = s.Power("player", SPELL_POWER_HOLY_POWER)
    
    -- bump it from spells that are casting
    if castGivesHP(c.GetCastingInfo()) then
        bumpHolyPower(1)
    end
    
    -- bump/consume it from spells that are queued
    a.RawHolyPower = -1
    a.DivinePurpose = s.Buff(c.GetID("Divine Purpose"), "player")
	if c.IsQueued(
		"Inquisition", 
		"Templar's Verdict", 
		"Shield of the Righteous", 
		"Word of Glory", 
		"Eternal Flame",
		"Light of Dawn") then
		
		if a.DivinePurpose then
			a.DivinePurpose = false
		else
			a.HolyPower = math.max(0, a.HolyPower - 3)
			a.DivinePurpose = c.HasBuff("Divine Purpose") -- expires before gcd?
		end
	else
		if c.IsQueued("Judgment") 
			and c.HasTalent("Sanctified Wrath") 
			and c.HasBuff("Avenging Wrath", false, false, true) 
			and GetSpecialization() == 2 then
			
			bumpHolyPower(2)
		elseif c.IsQueued(
				"Crusader Strike", 
				"Hammer of the Righteous",
				"Exorcism",
				"Hammer of Wrath")
			or (c.IsQueued("Judgment") 
				and (c.HasSpell("Judgments of the Bold")
					or c.HasSpell("Judgments of the Wise")
					or (GetSpecialization() == 1 
						and c.HasTalent("Selfless Healer"))))
			or (c.IsQueued("Avenger's Shield")
				and s.Buff(c.GetID("Grand Crusader"), "player"))
	    	or castGivesHP(c.GetQueuedInfo()) then
			
			bumpHolyPower(1)
		end
		if a.DivinePurpose then
			a.RawHolyPower = a.HolyPower
			a.HolyPower = math.max(3, a.HolyPower)
			a.DivinePurpose = c.HasBuff("Divine Purpose") -- expires before gcd?
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
		elseif c.IsQueued(
			"Divine Light", "Holy Radiance", "Flash of Light") then
			
			a.SelflessHealer = 0
		end
	end
	
	-- buff/cooldown timers
	a.Judgment = c.GetCooldown("Judgment", false, 6)
	if c.IsCasting("Crusader Strike", "Hammer of the Righteous") then
		a.Crusader = 4.5
	else
		a.Crusader = c.GetCooldown("Crusader Strike")
	end
	
	a.HoWPhase = s.HealthPercent() <= 20
end

local function selflessTriggerMonitor(info)
	if c.HasTalent("Selfless Healer") then
		if c.InfoMatches(info, "Judgment") then
			selflessStackPending = true
			c.Debug("Event", "Selfless Healer stack pending")
		elseif c.InfoMatches(
			info, "Divine Light", "Holy Radiance", "Flash of Light") then
			
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
	
	UsefulStats = { "Intellect", "Spirit", "Crit", "Haste" },
	
	FlashInCombat = function()
		c.FlashAll(
			"Sacred Shield for Holy",
			"Word of Glory for Holy",
			"Light of Dawn for Holy",
			"Holy Shock under 5 with Daybreak",
			"Save Selfless Healer",
			"Consume Selfless Healer",
			"Divine Plea",
			"Rebuke")
	end,
	
	FlashAlways = function()
		c.FlashAll("Seal of Insight", "Beacon of Light")
		flashRaidBuffs()
	end,
	
	CastSucceeded = selflessTriggerMonitor,
	
	SpellMissed = function(spellID)
		clearSelflessPending(spellID, "Judgment")
	end,
	
	AuraApplied = function(spellID)
		if c.IdMatches(spellID, "Sacred Shield") then
			a.SacredShieldPower = GetSpellBonusDamage(2)
			c.Debug("Event", "Sacred Shield applied at", a.SacredShieldPower)
		end
	end,
	
	AuraRemoved = clearSelflessMonitor,
	
	AuraApplied = function(spellID, target)
		if c.IdMatches(spellID, "Beacon of Light") then
			a.BeaconTarget = target
			c.Debug("Event", "Beacon target:", target)
		elseif c.IdMatches(spellID, "Sacred Shield") then
			a.SacredShieldTarget = target
			c.Debug("Event", "Sacred Shield target:", target)
		else
			clearSelflessPending(spellID, "Selfless Healer")
		end
	end,
}

-------------------------------------------------------------------------- Prot
local uncontrolledMitigationBuffs = { 
	"Divine Shield",
}

a.SacredShieldPower = 0

a.Rotations.Protection = {
	Spec = 2,
	
	UsefulStats = { 
		"Stamina", "Strength", "Dodge", "Parry", "Tanking Hit", "Haste" 
	},
	
	FlashInCombat = function()
		c.FlashAll(
			"Hand of Reckoning", 
			"Rebuke",
			"Word of Glory for Prot",
			"Shield of the Righteous to save Buffs",
			"Lay on Hands")

		c.FlashMitigationBuffs(
			1,
			uncontrolledMitigationBuffs,
			c.COMMON_TANKING_BUFFS,
			"Holy Avenger Damage Mode",
			"Avenging Wrath Damage Mode",
			"Holy Prism for Prot",
			"Hand of Purity",
			"Divine Protection", 
--			"Light's Hammer for Prot",
			"Execution Sentence for Prot",
			"Holy Avenger for Prot",
			"Ardent Defender 2pT14",
			"Avenging Wrath for Prot",
			"Guardian of Ancient Kings Prot", 
			"Ardent Defender")
		
		local flashing, delay = c.DelayPriorityFlash(
			
			-- mitigation
			"Holy Wrath to Stun",
			"Hammer of the Righteous for Debuff",
			"Crusader Strike for Debuff",
			"Sacred Shield for Prot",
			"Flash of Light for Prot",
			
			-- holy power
			"Judgment under Sanctified Wrath",
			"Judgment under Sanctified Wrath Delay",
			"Hammer of the Righteous for Prot AoE",
			"Crusader Strike for Prot",
			"Crusader Strike Delay",
			"Judgment",
			"Avenger's Shield under Grand Crusader",
			"Prot HP Gen Delay",
			
			-- think-ahead mitigation
			"Sacred Shield Refresh",
			
			-- damage
			"Consecration for AoE",
			"Avenger's Shield",
			"Holy Wrath",
			"Hammer of Wrath",
			"Consecration")
		
		-- All of the following is logic for when to flash Shield of the 
		-- Righteous
		
		if c.InDamageMode() then
			c.FlashAll("Shield of the Righteous")
			return
		end
		
		if not flashing then
			return
		end
		
		local bump = 0
		if flashing == "Judgment under Sanctified Wrath" then
			bump = 2
		elseif u.StartsWith(flashing, "Crusader Strike") 
			or u.StartsWith(flashing, "Hammer of the Righteous") 
			or u.StartsWith(flashing, "Judgment") 
			or u.StartsWith(flashing, "Judgment")
			or flashing == "Avenger's Shield under Grand Crusader" then
			
			bump = 1
		end
		if bump == 1 and c.HasBuff("Holy Avenger", false, true) then
			bump = 3
		end
		if a.HolyPower + bump > 5 then
			if delay then
				c.FlashAll("Shield of the Righteous Predictor")
			else
				c.FlashAll("Shield of the Righteous")
			end
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
		if c.IdMatches(spellID, "Sacred Shield") then
			a.SacredShieldPower = GetSpellBonusDamage(2)
			c.Debug("Event", "Sacred Shield applied at", a.SacredShieldPower)
		else
			clearSelflessPending(spellID, "Selfless Healer")
		end
	end,
	
	AuraRemoved = clearSelflessMonitor,
	
	ExtraDebugInfo = function()
		return string.format("%s %s", a.HolyPower, a.SelflessHealer)
	end,
}

--------------------------------------------------------------------------- Ret
a.Rotations.Retribution = {
	Spec = 3,
	
	UsefulStats = { "Strength", "Melee Hit", "Crit", "Haste" },
	
	FlashInCombat = function()
		a.Inquisition = c.GetBuffDuration("Inquisition", false, false, true)
		if c.HasGlyph("Mass Exorcism") then
			a.Exorcism = c.GetCooldown("Glyphed Exorcism", false, 15)
		else
			a.Exorcism = c.GetCooldown("Exorcism", false, 15)
		end
		a.AvengingWrath = c.GetBuffDuration(
			"Avenging Wrath", false, false, true)
		a.HolyAvenger = c.GetBuffDuration("Holy Avenger", false, false, true)
		a.DivineCrusader = 
			c.HasBuff("Divine Crusader") and not c.IsCasting("Divine Storm")
		
		c.FlashAll(
			"Avenging Wrath for Ret", 
			"Holy Avenger", 
			"Guardian of Ancient Kings Ret",
			"Lay on Hands", 
			"Rebuke")
		c.DelayPriorityFlash(
			"Inquisition",
			"Execution Sentence",
			"Inquisition before Templar's Verdict at 5",
			"Divine Storm at 5",
			"Templar's Verdict at 5",
			"Exorcism for AoE",
			"Hammer of Wrath for Ret",
			"Hammer of Wrath Delay",
			"Hammer of the Righteous for Ret",
			"Templar's Verdict 4pT15",
			"Crusader Strike",
			"Crusader Strike Delay",
			"Judgment",
			"Judgment Delay",
			"Divine Storm with Divine Crusader",
			"Templar's Verdict with Divine Purpose",
			"Exorcism",
			"Exorcism Delay",
			"Inquisition before Templar's Verdict",
			"Divine Storm",
			"Templar's Verdict",
			"Light's Hammer",
			"Holy Prism",
			"Sacred Shield for Ret")
	end,
	
	FlashAlways = function()
		c.FlashAll(
			"Seal of Truth", "Flash of Light for Ret", "Word of Glory for Ret")
		flashRaidBuffs()
	end,
	
	ExtraDebugInfo = function()
		return string.format(
			"h:%d h:%d j:%.1f, c:%.1f i:%.1f e:%.1f a:%.1f h:%.1f d:%s c:%s", 
			a.HolyPower, 
			a.RawHolyPower, 
			a.Judgment, 
			a.Crusader,
			a.Inquisition,
			a.Exorcism,
			a.AvengingWrath,
			a.HolyAvenger,
			a.DivinePurpose and "t" or "f",
			a.DivineCrusader and "t" or "f")
	end,
}
