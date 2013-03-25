local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetComboPoints = GetComboPoints
local GetTime = GetTime
local UnitDebuff = UnitDebuff
local UnitIsUnit = UnitIsUnit
local math = math
local select = select

function a.CanBackstab()
	local _, targetID = s.UnitInfo()
	return not a.NoBackstab[targetID] and not c.IsTanking()
end

local function modSpell(spell)
	local origColor = spell.FlashColor
	spell.NoPowerCheck = true
	spell.CheckLast = function()
		if spell.FlashColor ~= origColor and spell.FlashColor ~= "green" then
			origColor = spell.FlashColor
		end
		if a.Energy < s.SpellCost(s.SpellName(spell.ID)) then
			spell.FlashColor = "green"
			spell.FlashSize = s.FlashSizePercent() / 2
		else
			spell.FlashColor = origColor
			spell.FlashSize = nil
		end
		return true
	end
end

local function addSpell(name, tag, attributes)
	modSpell(c.AddSpell(name, tag, attributes))
end

local function addOptionalSpell(name, tag, attributes)
	modSpell(c.AddOptionalSpell(name, tag, attributes))
end

------------------------------------------------------------------------ Common
local function canAmbush()
	local _, targetID = s.UnitInfo()
	return a.CanBackstab()
		and (not c.HasTalent("Cloak and Dagger") 
			or not a.NoShadowstep[targetID])
end

c.AddOptionalSpell("Tricks of the Trade", nil, {
	NoRangeCheck = true,
	CheckFirst = function()
		return s.InRaidOrParty()
	end
})

addOptionalSpell("Tricks of the Trade", "unglyphed", {
	NoRangeCheck = true,
	CheckFirst = function()
		return s.InRaidOrParty() and not c.HasGlyph("Tricks of the Trade")
	end
})

c.AddOptionalSpell("Tricks of the Trade", "glyphed", {
	NoRangeCheck = true,
	CheckFirst = function()
		return s.InRaidOrParty() and c.HasGlyph("Tricks of the Trade")
	end
})

c.AddOptionalSpell("Deadly Poison", nil, {
	FlashID = { "Deadly Poison", "Poisons" },
	CheckFirst = function()
		return c.SelfBuffNeeded("Deadly Poison")
			and c.SelfBuffNeeded("Wound Poison")
	end
})

c.AddOptionalSpell("Non-Lethal Poison", nil, {
	ID = "Crippling Poison",
	FlashID = { 
		"Crippling Poison", 
		"Mind-numbing Poison", 
		"Leeching Poison", 
		"Paralytic Poison",
		"Poisons" 
	},
	CheckFirst = function()
		return c.SelfBuffNeeded("Crippling Poison")
			and c.SelfBuffNeeded("Mind-numbing Poison")
			and c.SelfBuffNeeded("Leeching Poison")
			and c.SelfBuffNeeded("Paralytic Poison")
	end
})

c.AddOptionalSpell("Redirect", nil, {
	CheckFirst = function()
		return GetComboPoints("player") == 0
			and s.UsableSpell(c.GetID("Recuperate"))
	end
})

c.AddOptionalSpell("Preparation", nil, {
	FlashSize = s.FlashSizePercent() / 2,
	CheckFirst = function()
		return c.GetCooldown("Vanish") > 60
	end
})

c.AddOptionalSpell("Marked for Death", nil, {
	CheckFirst = function()
		return a.CP == 0
	end
})

c.AddOptionalSpell("Expose Armor", nil, {
	CheckFirst = function()
		if c.IsSolo() then
			return false
		end
		
		if c.GetDebuffDuration(c.ARMOR_DEBUFFS) < 3 then
			return true
		end
		
		local stack = c.GetDebuffStack(c.ARMOR_DEBUFFS)
		if c.IsQueued("Expose Armor") or a.ExposePending then
			if c.HasGlyph("Expose Armor") then
				stack = 3
			else
				stack = stack + 1
			end
		end
		return stack < 3
	end
})

addSpell("Ambush", nil, {
	CheckFirst = canAmbush,
})

c.AddInterrupt("Kick", nil, {
	NoGCD = true,
})

c.AddOptionalSpell("Recuperate", nil, {
	NoRangeCheck = true,
	CheckFirst = function()
		return a.CP == 5
			and c.IsSolo()
			and not c.HasBuff("Recuperate")
			and c.HasGlyph("Deadly Momentum")
	end
})

----------------------------------------------------------------- Assassination
local function canDispatch()
	return s.HealthPercent() < 35 
		or (c.HasBuff("Blindside") and not c.IsCasting("Dispatch"))
end

addSpell("Mutilate", nil, {
	CheckFirst = function()
		if c.HasBuff("Vanish") 
			and c.HasTalent("Shadow Focus") 
			and not c.IsCasting("Mutilate") then
			
			return true
		end
		
		if a.CP < 4 then
			return true
		end
		
		if a.CP == 5 then
			return false
		end
		
		-- If we can just wait at 4 combo points for a rupture, do that.
		local dur = c.GetMyDebuffDuration("Rupture") 
		return dur == 0
			or a.Energy + a.Regen * dur > s.MaxPower("player") - 10
	end
})

addSpell("Dispatch", nil, {
	CheckFirst = function()
		return a.CP < 5 and canDispatch()
	end
})

addSpell("Slice and Dice", "for Assassination", {
	NoRangeCheck = true,
	CheckFirst = function(z)
		if c.IsSolo() then
			z.FlashColor = "yellow"
			z.Continue = true
		else
			z.FlashColor = nil
			z.Continue = nil
		end
		return not c.HasBuff("Slice and Dice") 
			and not c.IsCasting("Slice and Dice")
	end
})

addSpell("Envenom", nil, {
	CheckFirst = function()
		if c.HasBuff("Vanish") 
			and c.HasTalent("Nightstalker") 
			and not c.IsCasting("Envenom") then
			
			return true
		end
		
		if a.CP < 5 then
			return false
		end
		
		if c.IsSolo() then
			return true
		end
		
		local untilCap = s.MaxPower("player") - a.Energy - 10
		return untilCap <= 0
			or (c.GetMyDebuffDuration("Rupture") > untilCap / a.Regen 
				and not c.HasBuff("Envenom"))
	end
})

addSpell("Envenom", "to refresh Slice and Dice", {
	CheckFirst = function()
		local snd = c.GetBuffDuration("Slice and Dice")
		return snd > .1 and snd < 3
	end
})

addOptionalSpell("Rupture", "for Assassination", {
	MyDebuff = "Rupture",
	CheckFirst = function(z)
		if c.IsSolo() then
			return false
		end
		
		if a.CP < a.LastRuptureCP then
			z.EarlyRefresh = nil
		else
			z.EarlyRefresh = 1.9
		end
		
		local t = 0
		local e = a.Energy
		
		-- sim casting rupture
		t = t + 1
		e = e - 25 + a.Regen
		if a.CP == 5 then
			e = e + 25
		end
		
		-- sim generating at least one combo point
		t = t + 1
		if canDispatch() then
			e = e - 30 + a.Regen
		else
			e = e - 55 + a.Regen
		end
		
		-- ensure we can cast envenom before SnD wears off
		t = c.GetBuffDuration("Slice and Dice") - t
		e = e + t * a.Regen
		return t > .5 and e >= 35
	end
})

c.AddOptionalSpell("Vendetta")

c.AddOptionalSpell("Vanish", nil, {
	NoGCD = true,
	CheckFirst = function()
		return not c.IsSolo() and not c.HasBuff("Stealth")
	end
})

------------------------------------------------------------------------ Combat
local function shouldSpendCpCombat()
	-- this should have more logic once I implement Anticipation
	return a.CP == 5
end

local function shouldSpendEnergyCombat()
	return a.Energy > 60 
		or a.DeepInsight == 0 
		or a.DeepInsight > 5 - a.CP
		or c.IsSolo()
end

c.AddOptionalSpell("Shadow Blades", "for Combat", {
	CheckFirst = function()
		if not c.WearingSet(4, "T14") then
			return true
		end
		
		local ks = c.GetCooldown("Killing Spree")
		local ar = c.GetCooldown("Adrenaline Rush")
		return (ks > 30.5 and ar <= 9) 
			or (a.Energy < 35 and (ks == 0 or ar == 0))
	end
})

c.AddOptionalSpell("Killing Spree", nil, {
	NoRangeCheck = true,
	CheckFirst = function()
		local _, targetID = s.UnitInfo()
		if a.NoKillingSpree[targetID] or c.HasBuff("Adrenaline Rush") then
			return false
		end
		
		if c.WearingSet(4, "T14") then
			local sb = c.GetBuffDuration("Shadow Blades")
			if sb == 0 then
				return c.GetCooldown("Shadow Blades") > 30
			else
				return sb <= 3.5 or a.Energy < 35
			end
		else
			return a.Energy < 35
		end
	end
})

c.AddOptionalSpell("Adrenaline Rush", nil, {
	CheckFirst = function()
		local sb = c.GetBuffDuration("Shadow Blades")
		if c.WearingSet(4, "T14") then
			return sb > 0 and (a.Energy < 35 or sb <= 15)
		else
			return sb > 0 or a.Energy < 35
		end
	end
})

c.AddOptionalSpell("Vanish", "for Combat", {
	CheckFirst = function()
		if c.IsSolo() 
			or c.HasBuff("Stealth") 
			or a.CP > 3
			or (c.HasBuff("Shadow Blades") and a.CP > 2) then
			
			return false
		end
		
		if c.HasTalent("Shadow Focus") then
			return a.Energy < 20 and not c.HasBuff("Adrenaline Rush")
		elseif c.HasTalent("Subterfuge") then
			return a.Energy >= 90
		else
			return a.Energy >= 60
		end
	end
})

addSpell("Slice and Dice", "for Combat", {
	NoRangeCheck = true,
	CheckFirst = function(z)
		local duration = c.GetBuffDuration("Slice and Dice")
		if c.IsSolo() then
			z.FlashColor = "yellow"
			z.Continue = true
			if c.HasGlyph("Deadly Momentum") then
				return duration == 0 and a.CP == 5
			else
				return duration < 2
			end
		else
			z.FlashColor = nil
			z.Continue = nil
			return duration < 2 
				or (a.Guile == 11 and duration < 16 and a.CP >= 4)
		end
		
	end
})

addOptionalSpell("Rupture", "for Combat", {
	CheckFirst = function()
		return shouldSpendCpCombat()
			and c.GetMyDebuffDuration("Rupture") < 2
			and not c.HasBuff("Blade Flurry")
			and not c.IsSolo()
	end
})

addSpell("Eviscerate", "for Combat", {
	CheckFirst = shouldSpendCpCombat,
})

c.AddSpell("Revealing Strike", nil, {
	Override = function()
		return a.Energy >= 40
			and c.GetMyDebuffDuration("Revealing Strike") < 2
			and not c.IsAuraPendingFor("Revealing Strike")
			and shouldSpendEnergyCombat()
	end
})

c.AddSpell("Revealing Strike", "if Down", {
	Override = function(z)
		local duration = c.GetMyDebuffDuration("Revealing Strike")
		if a.Energy < 40 then
			duration = duration + (40 - a.Energy) * a.Regen
		end
		if duration > .1 or c.IsAuraPendingFor("Revealing Strike") then
			return false
		end
		
		if a.Energy < 40 then
			z.FlashSize = s.FlashSizePercent() / 2
			z.FlashColor = "green"
		else
			z.FlashSize = nil
			z.FlashColor = nil
		end
		return true
	end
})

c.AddSpell("Sinister Strike", nil, {
	Override = function()
		return a.Energy >= 40 
			and shouldSpendEnergyCombat() 
			and s.MeleeDistance()
	end,
})

---------------------------------------------------------------------- Subtlety
addSpell("Slice and Dice", "for Subtlety", {
	NoRangeCheck = true,
	CheckFirst = function(z)
		local duration = c.GetBuffDuration("Slice and Dice")
		if c.IsSolo() then
			z.FlashColor = "yellow"
			z.Continue = true
			if c.HasGlyph("Deadly Momentum") then
				return duration == 0 and a.CP == 5
			else
				return duration < 3
			end
		else
			z.FlashColor = nil
			z.Continue = nil
			return duration < 3
		end
	end
})

addOptionalSpell("Rupture", nil, {
	CheckFirst = function()
		return not c.IsSolo() and c.GetMyDebuffDuration("Rupture") < 5
	end
})

addSpell("Ambush", "for Last Second Find Weakness", {
	CheckFirst = function()
		return canAmbush() and c.GetBuffDuration("Shadow Dance") < 2
	end
})

addSpell("Eviscerate")

addSpell("Hemorrhage")

addSpell("Hemorrhage", "for Bleed", {
	CheckFirst = function()
		return c.GetMyDebuffDuration("Hemorrhage") < 4
			and not c.IsAuraPendingFor("Hemorrhage")
	end
})

addSpell("Backstab", nil, {
	CheckFirst = a.CanBackstab
})

c.AddOptionalSpell("Shadow Dance")

c.AddOptionalSpell("Premeditation")
