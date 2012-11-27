local AddonName, a = ...
if a.BuildFail(50000) then return end
local L = a.Localize
local s = SpellFlashAddon
local c = BittensSpellFlashLibrary

local GetPowerRegen = GetPowerRegen
local math = math
local select = select

a.Rotations = {}
c.RegisterForEvents(a)
a.SetSpamFunction(function()
	a.InExecute = s.HealthPercent() < 20
	a.Rage = c.GetPower(select(2, GetPowerRegen()))
	a.Enraged = c.HasBuff("Enrage", true)
	local info = c.GetQueuedInfo()
--if info then c.Debug("Queued", info.Name) end
	if c.InfoMatches(info, "Berserker Rage") then
		a.Rage = math.min(s.MaxPower("player"), a.Rage + 10)
		a.Enraged = true
	elseif 
		c.InfoMatches(info, "Battle Shout", "Commanding Shout", "Charge") then
		
		a.Rage = math.min(s.MaxPower("player"), a.Rage + 20)
	end
	c.Flash(a)
end)

-------------------------------------------------------------------------- Arms
a.Rotations.Arms = {
	Spec = 1,
	OffSwitch = "arms_off",
	
	FlashInCombat = function()
		c.FlashAll(
			"Berserker Rage",
			"Heroic Leap",
			"Pummel")
		if a.InExecute then
			c.PriorityFlash(
				"Mortal Strike",
				"Colossus Smash",
				"Execute",
				"Storm Bolt",
				"Overpower",
				"Shockwave",
				"Dragon Roar",
				"Heroic Throw",
				"Shout for Rage")
		else
			c.FlashAll("Deadly Calm for Arms", "Heroic Strike for Arms")
			c.PriorityFlash(
				"Mortal Strike",
				"Colossus Smash",
				"Storm Bolt",
				"Overpower",
				"Shockwave",
				"Dragon Roar",
				"Slam with Colossus Smash or High Rage",
				"Heroic Throw",
				"Shout for Rage unless Colossus Smash",
				"Bladestorm for Arms",
				"Slam",
				"Impending Victory",
				"Shout for Rage")
		end
	end,
	
	FlashOutOfCombat = function()
		c.PriorityFlash("Battle Stance")
	end,
}

-------------------------------------------------------------------------- Fury
a.Rotations.Fury = {
	Spec = 2,
	OffSwitch = "fury_off",
	
	FlashInCombat = function()
		c.FlashAll(
			"Recklessness",
			"Berserker Rage",
			"Heroic Leap",
			"Deadly Calm",
			"Heroic Strike")
			
		local cd = c.GetCooldown("Bloodthirst")
		if cd > 0 and cd <= 1 then
			if not a.InExecute then
				c.PriorityFlash("Wild Strike under Bloodsurge")
			end
--c.Debug("Wait", a.Rage, not not a.Enraged)
			return
		end
		
		if a.InExecute then
			c.PriorityFlash(
				"Bloodthirst",
				"Colossus Smash",
				"Execute",
				"Storm Bolt",
				"Shockwave",
				"Dragon Roar",
				"Heroic Throw",
				"Shout")
		else
--c.Debug("Flash", a.Rage, not not a.Enraged,
			c.PriorityFlash(
				"Bloodthirst",
				"Colossus Smash",
				"Storm Bolt",
				"Raging Blow",
				"Wild Strike under Bloodsurge",
				"Shockwave",
				"Dragon Roar",
				"Heroic Throw",
				"Shout for Rage unless Colossus Smash",
				"Bladestorm for Fury",
				"Wild Strike under Colossus Smash",
				"Impending Victory",
				"Wild Strike at 60 unless Colossus Smash",
				"Shout for Rage")
--)
		end
	end,
	
	FlashAlways = function()
		c.FlashAll("Dps Stance")
	end,
}

-------------------------------------------------------------------- Protection
--local uncontrolledMitigationCooldowns = {
--	109774, -- Master Tactician LFR
--	107986, -- Master Tactician
--	109776, -- Master Tactician Heroic
--	74243, -- Windwalk
--	102667, -- Veil of Lies
--}
--
--a.Rotations.Protection = {
--	Spec = 3,
--	OffSwitch = "prot_off",
--	
--	FlashInCombat = function()
--		c.RotateCooldowns(
--			uncontrolledMitigationCooldowns,
--			"Shield Block",
--			"Fire of the Deep",
--			"Shield Wall",
--			"Enraged Regeneration")
--		c.FlashAll(
--			"Last Stand",
--			"Berserker Rage",
--			"Heroic Strike over 65",
--			"Taunt",
--			"Challenging Shout", 
--			"Pummel")
--		c.PriorityFlash(
--			"Thunder Clap for Debuff",
--			"Demoralizing Shout",
--			"Revenge with 2pT13",
--			"Thunder Clap for Rend",
--			"Shield Slam",
--			"Revenge",
--			"Shockwave",
--			"Rend",
--			"Devastate",
--			"Commanding Shout for Rage",
--			"Battle Shout for Rage")
--	end,
--	
--	FlashAlways = function()
--		c.FlashAll("Defensive Stance", "Vigilance")
--	end,
--	
--	CastSucceeded = function(info)
--		if c.InfoMatches(info, "Vigilance") then
--			a.VigilanceTarget = info.Target
--			c.Debug("Event", "Vigilance target:", info.Target)
--		end
--	end,
--}
