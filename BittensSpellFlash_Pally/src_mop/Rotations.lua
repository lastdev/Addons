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
c.Debug("Holy Power", "Queued bump from", info.Name)
	elseif c.InfoMatches(info,
		"Inquisition",
		"Templar's Verdict") then
		
		if not s.Buff(c.GetID("Divine Purpose"), "player") then
			a.HolyPower = math.max(0, a.HolyPower - 3)
		end
c.Debug("Holy Power", "Queued consume from", info.Name)
	elseif s.Buff(c.GetID("Divine Purpose"), "player") then
		a.HolyPower = math.max(3, a.HolyPower)
c.Debug("Holy Power", "Divine Purpose")
	end
c.Debug("Holy Power", a.HolyPower)
	
	-- flash!
	c.Flash(a)
end)

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
--local uncontrolledMitigationBuffs = { "Windwalk", "Veil of Lies" }
--a.Rotations.Protection = {
--	Spec = 2,
--	OffSwitch = "prot_off",
--	
--	FlashInCombat = function()
--		c.FlashAll(
--		   "Avenging Wrath", "Hand of Reckoning", "Righteous Defense", "Rebuke")
--		
--		if c.FlashAll("Holy Wrath to Stun") then
--			return
--		end
--		
--		-- TODO: add "if not stunned"
--		c.RotateCooldowns(
--			uncontrolledMitigationBuffs,
--			"Holy Shield", 
--			"Divine Protection", 
--			"Fire of the Deep", 
--			"Guardian of Ancient Kings", 
--			"Ardent Defender")
--		
--		if c.FlashAll("Word of Glory at 90") then
--			return
--		end
--		
--		if a.HolyPower == 3
--			and s.HealthPercent("player") < 90 
--			and c.GetCooldown("Word of Glory") < 1 then
--				
--			return
--		end
--		
--		if c.AoE then
--			if c.PriorityFlash(
--				"Hammer of the Righteous for Debuff", 
--				"Judgement for Bubble",
--				"Hammer of the Righteous", 
--				"Avenger's Shield for Holy Power") then
--				
--				return
--			end
--			if c.GetCooldown("Hammer of the Righteous") < .5 then
--				return
--			end
--			c.PriorityFlash(
--				"Avenger's Shield",
--				"Consecration over 50",
--				"Shield of the Righteous unless WoG",
--				"Hammer of Wrath",
--				"Judgement",
--				"Holy Wrath")
--		else
--			if c.PriorityFlash(
--				"Crusader Strike for Debuff", 
--				"Judgement for Debuff",
--				"Judgement for Bubble",
--				"Shield of the Righteous unless WoG",
--				"Crusader Strike", 
--				"Avenger's Shield for Holy Power") then
--				
--				return
--			end
--			if c.GetCooldown("Crusader Strike") < .5 then
--				return
--			end
--			c.PriorityFlash(
--				"Hammer of Wrath",
--				"Avenger's Shield",
--				"Consecration over 50",
--				"Judgement",
--				"Holy Wrath")
--		end
--	end,
--	
--	FlashAlways = function()
--		c.FlashAll("Righteous Fury", "Auras")
--		flashSeal("Seal of Insight", "Seal of Truth", "Seal of Justice")
--		flashRaidBuffs()
--	end,
--}

--------------------------------------------------------------------------- Ret
a.Rotations.Retribution = {
	Spec = 3,
	OffSwitch = "ret_off",
	
	FlashInCombat = function()
		c.FlashAll("Avenging Wrath", "Holy Avenger", "Rebuke")
		c.PriorityFlash(
			"Inquisition",
			"Templar's Verdict at 5",
			"Hammer of Wrath",
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
