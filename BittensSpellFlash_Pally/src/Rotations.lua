local AddonName, a = ...
if a.BuildFail(50000) then return end
local L = a.Localize
local s = SpellFlashAddon
local c = BittensSpellFlashLibrary

local SPELL_POWER_HOLY_POWER = SPELL_POWER_HOLY_POWER
local select = select
local math = math

--local function castGivesHP(info, delay)
--	return c.InfoMatches(info, "Holy Radiance")
--		or (c.InfoMatches(info, "Divine Light")
--			and s.MyBuff(c.GetID("Beacon of Light"), info.Target, delay)
--			and c.GetTalentRank("Tower of Radiance") == 3)
--end

local selflessStackPending = false
local selflessClearPending = false

a.Rotations = {}
c.RegisterForEvents(a)
a.SetSpamFunction(function()
	
	-- calculate holy power
	a.HolyPower = s.Power("player", SPELL_POWER_HOLY_POWER)
	
	-- bump/consume it from spells that are queued
	local info = c.GetQueuedInfo()
	if c.InfoMatches(info, 
			"Crusader Strike", 
			"Hammer of the Righteous",
			"Exorcism",
			"Hammer of Wrath",
			"Judgment") then
		
		if s.Buff(c.GetID("Holy Avenger"), "player") then
			a.HolyPower = math.min(5, a.HolyPower + 3)
		else
			a.HolyPower = math.min(5, a.HolyPower + 1)
		end
--c.Debug("Spam", "Queued bump from", info.Name)
	elseif c.InfoMatches(info,
		"Inquisition",
		"Templar's Verdict") then
		
		if not s.Buff(c.GetID("Divine Purpose"), "player") then
			a.HolyPower = math.max(0, a.HolyPower - 3)
		end
--c.Debug("Spam", "Queued consume from", info.Name)
	elseif s.Buff(c.GetID("Divine Purpose"), "player") then
		a.HolyPower = math.max(3, a.HolyPower)
--c.Debug("Spam", "Divine Purpose")
	end
--c.Debug("Spam", a.HolyPower)
	
	-- selfless healer monitoring
	a.SelflessHealer = c.GetBuffStack("Selfless Healer")
	if c.HasTalent("Selfless Healer") then
		if selflessStackPending then
			a.SelflessHealer = math.min(3, a.SelflessHealer + 1)
		end
		if selflessClearPending then
			a.SelflessHealer = 0
		end
		if c.InfoMatches(info, "Judgment") then
			a.SelflessHealer = math.min(3, a.SelflessHealer + 1)
--c.Debug("Spam", "selfless queued")
		elseif c.InfoMatches(info, "Flash of Light") then
			a.SelflessHealer = 0
--c.Debug("Spam", "selfless clear queued")
		end
	end
	
	-- flash!
	c.Flash(a)
end)

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
		duration = 5 * 60
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
--local consumingInfusion = false
--a.Rotations.Holy = {
--	Spec = 1,
--	OffSwitch = "holy_off",
--	
--	FlashAlways = function()
--		c.FlashAll("Seal of Insight", "Beacon of Light", "Auras")
--		flashRaidBuffs()
--	end,
--	
--	FlashInCombat = function()
--		c.FlashAll(
--			"Judgement for Buff",
--			"Word of Glory at 3",
--			"Light of Dawn at 3",
--			"Holy Shock under 3 with Daybreak",
--			"Rebuke")
--		if c.HasBuff("Infusion of Light") and not consumingInfusion then
--			c.FlashAll("Divine Light", "Holy Radiance", "Flash of Light")
--		end
--	end,
--	
--	CastStarted = function(info)
--		if c.InfoMatches(info, "Divine Light", "Holy Radiance")
--			and c.HasBuff("Infusion of Light") then
--			
--			consumingInfusion = true
--			c.Debug("Event", "Consuming Infusion of Light")
--		end
--	end,
--	
--	CastFailed = function(info)
--		if consumingInfusion
--			and c.InfoMatches(info, "Divine Light", "Holy Radiance") then
--			
--			consumingInfusion = false
--			c.Debug("Event", "Resuming Infusion of Light (failure)")
--		end
--	end,
--	
--	CastSucceeded = function(info)
--		if consumingInfusion
--			and c.InfoMatches(
--				info, "Divine Light", "Holy Radiance", "Flash of Light") then
--			
--			consumingInfusion = false
--			c.Debug("Event", "Resuming Infusion of Light (success)")
--		end
--	end,
--	
--	AuraApplied = function(spellID, target)
--		if spellID == c.GetID("Beacon of Light") then
--			a.BeaconTarget = target
--			c.Debug("Event", "Beacon target:", target)
--		end
--	end,
--}

-------------------------------------------------------------------------- Prot
local uncontrolledMitigationBuffs = { "Windwalk", "Veil of Lies" }
a.Rotations.Protection = {
	Spec = 2,
	OffSwitch = "prot_off",
	
	FlashInCombat = function()
--c.Debug("Flash", a.HolyPower, a.SelflessHealer)
		c.FlashAll(
		   "Avenging Wrath if Plain", 
		   "Hand of Reckoning", 
		   "Rebuke",
		   "Word of Glory for Prot",
		   "Shield of the Righteous to save Bastion of Glory")
		
		c.FlashMitigationBuffs(
			1,
			uncontrolledMitigationBuffs,
			"Divine Protection", 
			"Fire of the Deep", 
			"Holy Avenger",
			"Avenging Wrath if Cool for Prot",
			"Guardian of Ancient Kings", 
			"Ardent Defender")
		
		-- mitigation
		if c.PriorityFlash(
			"Holy Wrath to Stun",
			"Hammer of the Righteous for Debuff",
			"Eternal Flame",
			"Sacred Shield",
			"Flash of Light for Prot") then
			
			return
		end
			
		-- holy power
		if c.PriorityFlash(
			"Crusader Strike",
			"Judgment",
			"Avenger's Shield under Grand Crusader") then
			
			c.FlashAll("Shield of the Righteous")
			return
		end
		
		if not c.PriorityFlash(
			
			-- thinking ahead mitigation
			"Sacred Shield Refresh",
			
			-- damage
			"Avenger's Shield",
			"Hammer of Wrath",
			"Consecration",
			"Holy Wrath") then
			
			c.FlashAll("Shield of the Righteous")
		end
	end,
	
	FlashAlways = function()
		c.FlashAll("Righteous Fury", "Seal of Insight for Prot")
		flashRaidBuffs()
	end,
	
	CastSucceeded = selflessTriggerMonitor,
	
	SpellMissed = function(spellID)
		clearSelflessPending(spellID, "Judgment")
	end,
	
	AuraApplied = function(spellID)
		clearSelflessPending(spellID, "Selfless Healer")
	end,
	
	AuraRemoved = clearSelflessMonitor,
}

--------------------------------------------------------------------------- Ret
a.Rotations.Retribution = {
	Spec = 3,
	OffSwitch = "ret_off",
	
	FlashInCombat = function()
		c.FlashAll("Avenging Wrath", "Holy Avenger", "Rebuke")
		c.PriorityFlash(
			"Inquisition",
			"Templar's Verdict at 5",
			"Hammer of Wrath for Ret",
			"Exorcism",
			"Crusader Strike",
			"Judgment",
			"Seal of Insight below 20",
			"Templar's Verdict")
	end,
	
	FlashAlways = function()
--		if s.PowerPercent() < 20 then
--			c.FlashAll("Seal of Insight")
--		elseif s.PowerPercent() > 90 or s.Form() == nil then
			c.FlashAll("Seal of Truth")
--		end
		flashRaidBuffs()
	end,
}
