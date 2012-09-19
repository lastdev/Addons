local AddonName, a = ...
if a.BuildFail(50000) then return end
local L = a.Localize
local s = SpellFlashAddon
local c = BittensSpellFlashLibrary

local GetComboPoints = GetComboPoints
local GetPowerRegen = GetPowerRegen
local math = math
local select = select

local relentlessPending = false
local finishers = { "Slice and Dice", "Rupture", --[["Envenom",]] "Recuperate" }

local function triggersRelentless(info)
	return c.InfoMatches(info, finishers)
		and GetComboPoints("player") == 5
		and s.HasSpell(c.GetID("Relentless Strikes"))
end

local function maybePendRelentless(info)
	if triggersRelentless(info) then
		relentlessPending = true
	end
end

local function maybeConsumeRelentless(id)
	if id == c.GetID("Relentless Strikes") then
		relentlessPending = false
	end
end

a.Rotations = {}
c.RegisterForEvents(a)
a.SetSpamFunction(function()
	c.Init(a)

	a.Regen = select(2, GetPowerRegen())
	if s.HasSpell(c.GetID("Energetic Recovery"))
		and (c.HasBuff("Slice and Dice") or c.IsCasting("Slice and Dice")) then
		
		a.Regen = a.Regen + 4
	end
--	local extra = .6 * 5 * c.GetTalentRank("Venomous Wounds")
--	if extra > 0 then
--		if c.HasMyDebuff("Garrote") or c.IsAuraPendingFor("Garrote") then
--			a.Regen = a.Regen + extra / 3
--		end
--		if c.HasMyDebuff("Rupture") or c.IsAuraPendingFor("Rupture") then
--			a.Regen = a.Regen + extra / 2
--		end
--	end
	
	local info = c.GetQueuedInfo()
	a.CP = GetComboPoints("player")
	if a.CP == 5 
		and c.GetTalentRank("Relentless Strikes") == 3
		and c.InfoMatches(info, finishers) then
		
		info.Cost = s.SpellCost(info.Name) - 25
	end
	a.Energy = c.GetPower(a.Regen)
	if relentlessPending or triggersRelentless(info) then
		a.Energy = math.min(s.MaxPower("player"), a.Energy + 25)
	end
	
	if c.InfoMatches(
		info,
--		"Sinister Strike", 
		"Backstab", 
--		"Revealing Strike", 
--		"Garrote", 
		"Hemorrhage") then
		
		a.CP = math.min(5, a.CP + 1)
	elseif c.InfoMatches(info, finishers) then
		a.CP = 0
	elseif c.InfoMatches(info, --[["Mutilate",]] "Ambush") then
		a.CP = math.min(5, a.CP + 2)
	end
	
--c.Debug("Spam", a.CP, a.Energy, relentlessPending)
	c.Flash(a)
end)

--a.LastRuptureCP = 0
--a.Rotations.Assassination = {
--	Spec = 1,
--	OffSwitch = "assassination_off",
--	
--	FlashInCombat = function()
--		c.FlashAll(
--			"Vendetta",
--			"Vanish for Assassination",
--			"Tricks of the Trade",
--			"Kick")
--		if c.HasBuff("Vanish") then
--			c.PriorityFlash("Garrote")
--		else
--			c.PriorityFlash(
--				"Envenom to refresh Slice and Dice",
--				"Slice and Dice",
--				"Rupture for Assassination",
--				"Envenom for Assassination",
--				"Backstab during Execute",
--				"Mutilate")
--		end
--	end,
--	
--	FlashOutOfCombat = function(self)
--		if c.HasBuff("Vanish") then
--			self:FlashInCombat()
--		elseif a.InSoloMode() then
--			c.FlashAll("Recuperate")
--		end
--	end,
--	
--	FlashAlways = function()
--		c.FlashAll("Deadly Poison", "Instant Poison", "Redirect")
--	end,
--	
--	CastSucceeded = function(info)
--		maybePendRelentless(info)
--		if c.InfoMatches(info, "Rupture") then
--			a.LastRuptureCP = GetComboPoints("player")
--			c.Debug("Event", "Rupture at", a.LastRuptureCP, "CP")
--		end
--	end,
--	
--	Energized = maybeConsumeRelentless,
--}
--
--local uncontrolledCooldowns = {}
--a.Rotations.Combat = {
--	Spec = 2,
--	OffSwitch = "combat_off",
--		
--	FlashInCombat = function()
--		c.FlashAll("Tricks of the Trade", "Kick")
--		c.RotateCooldowns(
--			uncontrolledCooldowns, "Adrenaline Rush", "Killing Spree")
--		c.PriorityFlash(
--			"Slice and Dice",
--			"Expose Armor",
--			"Rupture unless SnD",
--			"Eviscerate for Combat",
--			"Revealing Strike",
--			"Sinister Strike Smart")
--	end,
--	
--	FlashOutOfCombat = function()
--		if a.InSoloMode() then
--			c.FlashAll("Recuperate")
--		end
--	end,
--	
--	FlashAlways = function()
--		c.FlashAll(
--			"Deadly Poison or Wound", "Instant Poison or Wound", "Redirect")
--	end,
--	
--	CastSucceeded = maybePendRelentless,
--	
--	Energized = maybeConsumeRelentless,
--}

a.Rotations.Subtlety = {
	Spec = 3,
	OffSwitch = "sub_off",
	
	FlashInCombat = function()
		if a.CanBackstab() 
			and (c.HasBuff("Vanish") or c.IsCasting("Vanish")) 
			and not c.HasTalent("Subterfuge") then
			
			c.PriorityFlash("Ambush")
			if a.CP < 3 then
				c.FlashAll("Premeditation")
			end
			return
		end
		
		c.FlashAll("Kick")
		local untilCap = s.MaxPower("player") - a.Energy - a.Regen / 2
		local cdDealBreaker =
			c.HasBuff("Master of Subtlety") 
			or c.HasBuff("Find Weakness") 
			or c.HasBuff("Stealth")
			or c.HasBuff("Shadow Dance")
			or c.IsCasting("Shadow Dance")
		if untilCap < a.Regen / 2 and not cdDealBreaker then
			if not c.FlashAll("Shadow Dance")
				and (not c.HasTalent("Shadow Focus") 
					or untilCap < 3 / 2 * a.Regen) then
				
				c.FlashAll("Vanish")
			end
		end
		
		if a.CP < 5 and c.PriorityFlash("Ambush") then
			return
		end
		
		local nextCool
		if cdDealBreaker then
			nextCool = 500
		else
			nextCool = math.min(
				c.GetCooldown("Shadow Dance"), c.GetCooldown("Vanish"))
		end
		if (a.CP < 4 and untilCap / a.Regen < nextCool)
			or (a.CP < 5 and (
				untilCap <= 0
					or c.HasBuff("Shadow Dance")
					or a.InSoloMode())) then
			
			c.PriorityFlash(
				"Ambush",
				"Hemorrhage for Bleed",
				"Backstab",
				"Hemorrhage",
				"Preparation",
				"Tricks of the Trade")
		elseif a.CP == 5 then
--c.Debug("Flash",
			c.PriorityFlash(
				"Slice and Dice",
				"Rupture",
				"Ambush for Last Second Find Weakness",
				"Eviscerate",
				"Preparation",
				"Tricks of the Trade")
--)
		end
	end,
	
	FlashOutOfCombat = function(self)
		if c.HasBuff("Vanish") then
			self:FlashInCombat()
--		elseif a.InSoloMode() then
--			c.FlashAll("Recuperate")
		end
	end,
	
	FlashAlways = function()
		c.FlashAll("Deadly Poison", "Redirect")
	end,
	
	CastSucceeded = maybePendRelentless,
	
	Energized = maybeConsumeRelentless,
}
