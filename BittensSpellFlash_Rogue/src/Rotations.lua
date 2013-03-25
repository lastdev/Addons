local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetComboPoints = GetComboPoints
local GetPowerRegen = GetPowerRegen
local math = math
local select = select
local string = string

local relentlessPending = false
local finishers = { 
	"Slice and Dice", "Rupture", "Envenom", "Recuperate", "Eviscerate" 
}

local function triggersRelentless(info)
	return c.InfoMatches(info, finishers)
		and GetComboPoints("player") == 5
		and s.HasSpell(c.GetID("Relentless Strikes"))
end

local function processCast(info)
	if triggersRelentless(info) then
		relentlessPending = true
	elseif c.InfoMatches(info, "Expose Armor") then
		a.ExposePending = true
		c.Debug("Event", "Expose Armor pending")
	end
end

local function maybeConsumeRelentless(id)
	if id == c.GetID("Relentless Strikes") then
		relentlessPending = false
	end
end

local function unpendExpose(id)
	if id == c.ARMOR_DEBUFFS then
		a.ExposePending = false
		c.Debug("Event", "Expose Armor applied")
	end
end

a.Rotations = {}

function a.PreFlash()
	
	-- Calc regen
	a.Regen = select(2, GetPowerRegen())
	if s.HasSpell(c.GetID("Energetic Recovery")) then
		if c.HasBuff("Slice and Dice") or c.IsCasting("Slice and Dice") then
			a.Regen = a.Regen + 4
		end
	elseif s.HasSpell(c.GetID("Venomous Wounds")) then
		if c.HasMyDebuff("Rupture") or c.IsCasting("Rupture") then
			a.Regen = a.Regen + 10 * .75 / 2
--		elseif c.HasMyDebuff("Garrote") or c.IsCasting("Garrote") then
--			a.Regen = a.Regen + 10 * .75 / 3
		end
	end
	
	-- Calc power
	local info = c.GetQueuedInfo()
	a.CP = GetComboPoints("player")
	a.Energy = c.GetPower(a.Regen)
	if relentlessPending or triggersRelentless(info) then
		a.Energy = math.min(s.MaxPower("player"), a.Energy + 25)
	end
	
	-- Calc cp
	if c.InfoMatches(
		info,
		"Sinister Strike", 
		"Backstab", 
		"Dispatch",
		"Revealing Strike", 
		"Hemorrhage",
		"Expose Armor") then
		
		a.CP = math.min(5, a.CP + 1)
	elseif c.InfoMatches(info, finishers) then
		a.CP = 0
	elseif c.InfoMatches(info, "Mutilate", "Ambush") then
		a.CP = math.min(5, a.CP + 2)
	elseif c.InfoMatches(info, "Marked for Death") then
		a.CP = 5
	end
	
--c.Debug("Spam", a.CP, a.Energy, relentlessPending)
end

----------------------------------------------------------------- Assassination
a.LastRuptureCP = 0
a.Rotations.Assassination = {
	Spec = 1,
	
	FlashInCombat = function()
		c.FlashAll(
			"Vendetta", 
			"Marked for Death", 
			"Expose Armor", 
			"Recuperate", 
			"Kick")
		
		if c.HasBuff("Vanish") and c.HasTalent("Nightstalker") then
			c.PriorityFlash("Envenom")
		elseif c.HasBuff("Vanish") and c.HasTalent("Shadow Focus") then
			c.PriorityFlash("Mutilate")
		else
			local flashing = c.PriorityFlash(
				"Envenom to refresh Slice and Dice",
				"Slice and Dice for Assassination",
				"Rupture for Assassination",
				"Envenom",
				"Tricks of the Trade unglyphed",
				"Dispatch",
				"Mutilate",
				"Preparation",
				"Tricks of the Trade glyphed")
			if c.HasTalent("Nightstalker") then
				if flashing and string.find(flashing, "Envenom") then
					c.FlashAll("Vanish")
				end
			elseif c.HasTalent("Shadow Focus") then
				if flashing == "Mutilate" then
					c.FlashAll("Vanish")
				end
			end
		end
	end,
	
	FlashOutOfCombat = function(self)
		if c.HasBuff("Vanish") then
			self:FlashInCombat()
		end
	end,
	
	FlashAlways = function()
		c.FlashAll("Deadly Poison", "Non-Lethal Poison", "Redirect")
	end,
	
	CastSucceeded = function(info)
		processCast(info)
		if c.InfoMatches(info, "Rupture") then
			a.LastRuptureCP = GetComboPoints("player")
			c.Debug("Event", "Rupture at", a.LastRuptureCP, "CP")
		end
	end,
	
	Energized = maybeConsumeRelentless,
	
	AuraApplied = unpendExpose,
}

------------------------------------------------------------------------ Combat
local guile = 0
a.Rotations.Combat = {
	Spec = 2,
		
	FlashInCombat = function()
		if c.IsQueued("Sinister Strike", "Revealing Strike") then
			a.Guile = guile + 1
		else
			a.Guile = guile
		end
		
		if a.Guile > 8 and not s.Buff(c.GetID("Deep Insight"), "player") then
			a.DeepInsight = 15
		else
			a.DeepInsight = c.GetBuffDuration("Deep Insight")
		end
		
		c.FlashAll(
			"Shadow Blades for Combat", 
			"Killing Spree",
			"Adrenaline Rush", 
			"Vanish for Combat", 
			"Marked for Death",
			"Expose Armor",
			"Recuperate",
			"Kick")
		c.PriorityFlash(
			"Ambush", 
			"Slice and Dice for Combat", 
			"Revealing Strike if Down",
			"Rupture for Combat",
			"Eviscerate for Combat",
			"Tricks of the Trade unglyphed",
			"Revealing Strike",
			"Sinister Strike",
			"Preparation",
			"Tricks of the Trade glyphed")
	end,
	
	FlashOutOfCombat = function(self)
		if c.HasBuff("Vanish") then
			self:FlashInCombat()
		end
	end,
	
	FlashAlways = function()
		c.FlashAll("Deadly Poison", "Non-Lethal Poison", "Redirect")
	end,
	
	CastSucceeded = function(info)
		processCast(info)
		if c.InfoMatches(info, "Sinister Strike", "Revealing Strike") then
			guile = guile + 1
			c.Debug("Event", "Guile Bump", guile)
		end
	end,
	
	Energized = maybeConsumeRelentless,
	
	AuraApplied = function(spellID)
		unpendExpose(spellID)
		if spellID == c.GetID("Shallow Insight") then
			if guile < 4 then
				guile = 4
				c.Debug("Event", "Guile Set to 4")
			end
		elseif spellID == c.GetID("Moderate Insight") then
			if guile < 8 then
				guile = 8
				c.Debug("Event", "Guile Set to 8")
			end
		elseif spellID == c.GetID("Deep Insight") then
			guile = 0
			c.Debug("Event", "Guile Set to 0")
		end
	end,
	
	AuraRemoved = function(spellID)
		if spellID == c.GetID("Shallow Insight")
			or spellID == c.GetID("Moderate Insight")
			or spellID == c.GetID("Deep Insight") then
			
			guile = 0
			c.Debug("Event", "Guile Reset")
		end
	end,
	
	ExtraDebugInfo = function()
		return string.format("%s %s %s %.1f",
			a.CP, a.Guile, a.DeepInsight, a.Energy)
	end,
}

---------------------------------------------------------------------- Subtlety
a.Rotations.Subtlety = {
	Spec = 3,
	
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
		
		c.FlashAll("Marked for Death", "Recuperate", "Expose Armor", "Kick")
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
					or c.IsSolo())) then
			
			c.PriorityFlash(
				"Ambush",
				"Hemorrhage for Bleed",
				"Tricks of the Trade unglyphed",
				"Backstab",
				"Hemorrhage",
				"Preparation",
				"Tricks of the Trade glyphed")
		elseif a.CP == 5 then
			c.PriorityFlash(
				"Slice and Dice for Subtlety",
				"Rupture",
				"Ambush for Last Second Find Weakness",
				"Eviscerate",
				"Preparation",
				"Tricks of the Trade")
		end
	end,
	
	FlashOutOfCombat = function(self)
		if c.HasBuff("Vanish") then
			self:FlashInCombat()
		end
	end,
	
	FlashAlways = function()
		c.FlashAll("Deadly Poison", "Non-Lethal Poison", "Redirect")
	end,
	
	CastSucceeded = processCast,
	
	Energized = maybeConsumeRelentless,
	
	AuraApplied = unpendExpose,
}
