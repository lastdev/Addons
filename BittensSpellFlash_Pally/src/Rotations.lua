local AddonName, a = ...
if a.BuildFail(40000, 50000) then return end
local L = a.Localize
local s = SpellFlashAddon
local c = BittensSpellFlashLibrary

local SPELL_POWER_HOLY_POWER = SPELL_POWER_HOLY_POWER
local select = select
local math = math

local function castGivesHP(info, delay)
	return c.InfoMatches(info, "Holy Radiance")
		or (c.InfoMatches(info, "Divine Light")
			and s.MyBuff(c.GetID("Beacon of Light"), info.Target, delay)
			and c.GetTalentRank("Tower of Radiance") == 3)
end

a.Rotations = {}
c.RegisterForEvents(a)
s.Spam[AddonName] = function()
	
	-- calculate holy power
	a.HolyPower = s.Power("player", SPELL_POWER_HOLY_POWER)
	
	-- bump it from spells that are casting
	local info = c.GetCastingInfo()
	local delay = s.GetCasting() or 0
	if castGivesHP(info, delay) then
		a.HolyPower = math.min(3, a.HolyPower + 1)
		c.Debug("Holy Power", "Casting Bump")
	end
	
	-- bump/consume it from spells that are queued
	info = c.GetQueuedInfo()
	if c.HasBuff("Zealotry") and c.InfoMatches(info, "Crusader Strike") then
		
		a.HolyPower = 3
--c.Debug("Holy Power", "Zealotry!")
	elseif c.InfoMatches(info, 
			"Holy Shock",
			"Crusader Strike", 
			"Divine Storm", 
			"Hammer of the Righteous")
		or (info and castGivesHP(info, delay + s.CastTime(info.Name)))
		or (c.InfoMatches(info, "Judgement") and c.WearingSet(2, "RetT13")) then
		
		a.HolyPower = math.min(3, a.HolyPower + 1)
--c.Debug("Holy Power", "Queued bump from", info.Name)
	elseif c.InfoMatches(info,
			"Word of Glory",
			"Light of Dawn",
			"Shield of the Righteous",
			"Inquisition",
			"Templar's Verdict")
		and not c.HasBuff("Divine Purpose") then
		
		a.HolyPower = 0
--c.Debug("Holy Power", "Queued consume from", info.Name)
	elseif c.HasBuff("Divine Purpose") then
		a.HolyPower = 3
--c.Debug("Holy Power", "Divine Purpose")
	end
--c.Debug("Holy Power", a.HolyPower)
	
	-- flash!
	c.Flash(a)
end

local function flashRaidBuffs()
	local duration = 0
	if not s.InCombat() then
		duration = 5 * 60
	end
	
	-- if I have my own kings, make sure everyone else does too
	if s.MyBuff(c.GetID("Blessing of Kings"), "player") then
		if not s.Buff(c.FIVE_PERCENT_BUFFS, "raid|all|range", duration) then
			c.FlashAll("Blessing of Kings")
		end
		return
	end
	
	-- if I have my own might, make sure everyone else does too
	if s.MyBuff(c.GetID("Blessing of Might"), "player") then
		if not s.Buff(c.ATTACK_POWER_BUFFS, "raid|all|range", duration)
			or not s.Buff(c.MP5_BUFFS, "raid|all|range|mana", duration) then
			
			c.FlashAll("Blessing of Might")
		end
		return
	end
	
	-- check the raid for both kings and might
	if not s.Buff(c.FIVE_PERCENT_BUFFS, "raid|all|range", duration) then
		c.FlashAll("Blessing of Kings")
	end
	if not s.Buff(c.ATTACK_POWER_BUFFS, "raid|all|range", duration)
		or not s.Buff(c.MP5_BUFFS, "raid|all|range|mana", duration) then

		c.FlashAll("Blessing of Might")
	end
end

local function flashSeal(name, ...)
	for i = 1, select("#", ...) do
		if not c.SelfBuffNeeded(select(i, ...)) then
			return
		end
	end
	c.FlashAll(name)
end

-------------------------------------------------------------------------- Holy
local consumingInfusion = false
a.Rotations.Holy = {
	Spec = 1,
	OffSwitch = "holy_off",
	
	FlashAlways = function()
		c.FlashAll("Seal of Insight", "Beacon of Light", "Auras")
		flashRaidBuffs()
	end,
	
	FlashInCombat = function()
		c.FlashAll(
			"Judgement for Buff",
			"Word of Glory at 3",
			"Light of Dawn at 3",
			"Holy Shock under 3 with Daybreak",
			"Rebuke")
		if c.HasBuff("Infusion of Light") and not consumingInfusion then
			c.FlashAll("Divine Light", "Holy Radiance", "Flash of Light")
		end
	end,
	
	CastStarted = function(info)
		if c.InfoMatches(info, "Divine Light", "Holy Radiance")
			and c.HasBuff("Infusion of Light") then
			
			consumingInfusion = true
			c.Debug("Event", "Consuming Infusion of Light")
		end
	end,
	
	CastFailed = function(info)
		if consumingInfusion
			and c.InfoMatches(info, "Divine Light", "Holy Radiance") then
			
			consumingInfusion = false
			c.Debug("Event", "Resuming Infusion of Light (failure)")
		end
	end,
	
	CastSucceeded = function(info)
		if consumingInfusion
			and c.InfoMatches(
				info, "Divine Light", "Holy Radiance", "Flash of Light") then
			
			consumingInfusion = false
			c.Debug("Event", "Resuming Infusion of Light (success)")
		end
	end,
	
	AuraApplied = function(spellID, target)
		if spellID == c.GetID("Beacon of Light") then
			a.BeaconTarget = target
			c.Debug("Event", "Beacon target:", target)
		end
	end,
}

-------------------------------------------------------------------------- Prot
local uncontrolledMitigationBuffs = { "Windwalk", "Veil of Lies" }
a.Rotations.Protection = {
	Spec = 2,
	OffSwitch = "prot_off",
	
	FlashInCombat = function()
		c.FlashAll(
		   "Avenging Wrath", "Hand of Reckoning", "Righteous Defense", "Rebuke")
		
		if c.FlashAll("Holy Wrath to Stun") then
			return
		end
		
		-- TODO: add "if not stunned"
		c.RotateCooldowns(
			uncontrolledMitigationBuffs,
			"Holy Shield", 
			"Divine Protection", 
			"Fire of the Deep", 
			"Guardian of Ancient Kings", 
			"Ardent Defender")
		
		if c.FlashAll("Word of Glory at 90") then
			return
		end
		
		if a.HolyPower == 3
			and s.HealthPercent("player") < 90 
			and c.GetCooldown("Word of Glory") < 1 then
				
			return
		end
		
		if c.AoE then
			if c.PriorityFlash(
				"Hammer of the Righteous for Debuff", 
				"Judgement for Bubble",
				"Hammer of the Righteous", 
				"Avenger's Shield for Holy Power") then
				
				return
			end
			if c.GetCooldown("Hammer of the Righteous") < .5 then
				return
			end
			c.PriorityFlash(
				"Avenger's Shield",
				"Consecration over 50",
				"Shield of the Righteous unless WoG",
				"Hammer of Wrath",
				"Judgement",
				"Holy Wrath")
		else
			if c.PriorityFlash(
				"Crusader Strike for Debuff", 
				"Judgement for Debuff",
				"Judgement for Bubble",
				"Shield of the Righteous unless WoG",
				"Crusader Strike", 
				"Avenger's Shield for Holy Power") then
				
				return
			end
			if c.GetCooldown("Crusader Strike") < .5 then
				return
			end
			c.PriorityFlash(
				"Hammer of Wrath",
				"Avenger's Shield",
				"Consecration over 50",
				"Judgement",
				"Holy Wrath")
		end
	end,
	
	FlashAlways = function()
		c.FlashAll("Righteous Fury", "Auras")
		flashSeal("Seal of Insight", "Seal of Truth", "Seal of Justice")
		flashRaidBuffs()
	end,
}

--------------------------------------------------------------------------- Ret
local pendingRet2pT13 = false
a.Rotations.Retribution = {
	Spec = 3,
	OffSwitch = "ret_off",
	
	FlashInCombat = function()
		if pendingRet2pT13 then
			a.HolyPower = math.min(3, a.HolyPower + 1)
		end
		c.FlashAll("Zealotry", "Avenging Wrath", "Rebuke")
		if c.AoE then
			c.PriorityFlash(
				"Inquisition",
				"Divine Storm for Holy Power",
				"Judgement for Holy Power",
				"Exorsism under Art of War against Undead",
				"Hammer of Wrath",
				"Exorsism under Art of War",
				"Templar's Verdict",
				"Divine Storm",
				"Consecration over 50",
				"Judgement",
				"Holy Wrath",
				"Divine Plea")
		else
			c.PriorityFlash(
				"Inquisition",
				"Crusader Strike for Holy Power",
				"Judgement for Holy Power",
				"Exorsism under Art of War against Undead",
				"Hammer of Wrath",
				"Exorsism under Art of War",
				"Templar's Verdict",
				"Crusader Strike",
				"Judgement",
				"Holy Wrath",
				"Consecration over 50",
				"Divine Plea")
			end
	end,
	
	FlashAlways = function()
		c.FlashAll("Auras")
		if c.AoE then
			flashSeal(
				"Seal of Truth", "Seal of Justice", "Seal of Righteousness")
		else
			flashSeal("Seal of Truth", "Seal of Justice")
		end
		flashRaidBuffs()
	end,
	
	CastSucceeded = function(info)
		if c.InfoMatches(info, "Judgement") and c.WearingSet(2, "RetT13") then
			pendingRet2pT13 = true
			c.Debug("Event", "Pending 2pT13")
		end
	end,
	
	Energized = function(spellID)
		if spellID == c.GetID("Virtuous Empowerment") then
			pendingRet2pT13 = false
			c.Debug("Event", "2pT13 occurred")
		end
	end
}
