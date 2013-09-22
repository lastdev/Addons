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

local function getCost(spell)
	return s.SpellCost(s.SpellName(spell.ID))
end

local function hasSufficientEnergy(spell)
	return a.Energy >= getCost(spell)
end

local function modSpell(spell)
	local origColor = spell.FlashColor
	spell.NoPowerCheck = true
	spell.CheckLast = function()
		if spell.FlashColor ~= origColor and spell.FlashColor ~= "green" then
			origColor = spell.FlashColor
		end
		c.MakePredictor(spell, not hasSufficientEnergy(spell), origColor)
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
function a.CanAmbush()
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

c.AddOptionalSpell("Shadow Blades")

c.AddOptionalSpell("Marked for Death", nil, {
	CheckFirst = function()
		return a.CP == 0
			and not c.HasBuff("Shadow Blades", false, false, true)
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
	CheckFirst = a.CanAmbush,
})

c.AddOptionalSpell("Recuperate", nil, {
	Buff = "Recuperate",
	BuffUnit = "player",
	Override = function(z)
		c.MakePredictor(z, not hasSufficientEnergy(z), "yellow")
		return a.CP >= 5 and c.IsSolo() and c.HasGlyph("Deadly Momentum")
	end
})

c.AddSpell("Shuriken Toss", nil, {
	CheckFirst = function()
		return not s.MeleeDistance()
			and (a.Energy >= 75
				or not c.HasBuff("Shuriken Toss", false, false, true))
	end,
})

c.AddDispel("Shiv", nil, "")

c.AddInterrupt("Kick", nil, {
	NoGCD = true,
})

----------------------------------------------------------------- Assassination
local function canDispatch()
	return s.HealthPercent() < 35 
		or (c.HasBuff("Blindside") and not c.IsCasting("Dispatch"))
end

c.AddOptionalSpell("Vendetta")

c.AddOptionalSpell("Vanish", "for Assassination", {
	NoGCD = true,
	CheckFirst = function()
		return not c.IsSolo() and not c.HasBuff("Stealth")
	end
})

c.AddSpell("Slice and Dice", "for Assassination", {
	NoRangeCheck = true,
	CheckFirst = function(z)
		c.MakeOptional(z, c.IsSolo())
		return a.SnD == 0
	end
})

c.AddSpell("Dispatch", nil, {
	Melee = true,
	CheckFirst = canDispatch,
})

c.AddSpell("Dispatch", "pre-Rupture", {
	Melee = true,
	CheckFirst = function(z)
		if not canDispatch() then
			return false
		end
		if c.HasBuff("Blindside") then	
			return a.CP < 5 and a.Rupture < 3
		else
			return a.CP < 5 
				and a.Rupture == 0 
				and a.Energy + a.Regen - getCost(z) >= 25
		end
	end
})

c.AddSpell("Dispatch", "pre-Envenom", {
	Melee = true,
	CheckFirst = function()
		if not c.HasTalent("Anticipation") or not canDispatch() then
			return false
		end
		
		local empty = a.EmptyCP - 2
		if c.HasBuff("Shadow Blades", false, false, true) then
			empty = empty - 1
		end
		return empty >= 0 
			and (c.HasBuff("Blindside") or a.Energy + 1.5 * a.Regen < 90)
	end
})

c.AddSpell("Mutilate", nil, {
	NoPowerCheck = true,
	CheckFirst = hasSufficientEnergy,
})

c.AddSpell("Mutilate", "pre-Rupture", {
	CheckFirst = function(z)
		return a.CP < 5
			and a.Rupture == 0
			and a.Energy + a.Regen - getCost(z) >= 25
			and not canDispatch()
	end
})

c.AddSpell("Mutilate", "pre-Envenom", {
	NoPowerCheck = true,
	CheckFirst = function(z)
		c.MakePredictor(z, not hasSufficientEnergy(z))
		return a.CP >= 5
			and a.CP < 7
			and not canDispatch()
			and c.HasTalent("Anticipation")
			and not c.HasBuff("Shadow Blades", false, false, true)
	end
})

c.AddSpell("Rupture", "for Assassination", {
	NoPowerCheck = true,
	CheckFirst = function(z)
		local cost = getCost(z)
		c.MakeOptional(z, c.IsSolo())
		c.MakePredictor(z, a.Energy < cost, z.FlashColor)
		
		local dur = a.Rupture
		if a.Energy < cost then
			dur = dur - (cost - a.Energy) / a.Regen
		end
		return (a.CP > 0 and dur <= 0) or (a.CP >= 5 and dur < 2)
	end
})

c.AddSpell("Envenom", nil, {
	Melee = true,
	NoPowerCheck = true,
	CheckFirst = function(z)
		c.MakePredictor(z, not hasSufficientEnergy(z))
		return a.CP >= 5
	end
})

c.AddSpell("Envenom", "for Buff", {
	Melee = true,
	NoPowerCheck = true,
	CheckFirst = function(z)
		local cost = getCost(z)
		c.MakePredictor(z, a.Energy < cost)
		return a.CP >= 5
			and c.GetBuffDuration("Envenom", false, false, true) 
					- (cost - a.Energy) / a.Regen 
				< 1
	end
})

c.AddSpell("Envenom", "to refresh Slice and Dice", {
	Melee = true,
	CheckFirst = function()
		return a.SnD > .1 and a.SnD < 3
	end
})

------------------------------------------------------------------------ Combat
local function shouldSpendCpCombat()
	if a.CP < 5 then
		return false
	end
	
	return not c.HasTalent("Anticipation")
		or a.EmptyCP < 2
		or (a.EmptyCP < 3 and c.HasBuff("Shadow Blades"))
		or a.DeepInsight > 0 
		or (c.GetCooldown("Shadow Blades") < 3 
			and not c.IsCasting("Shadow Blades"))
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
			or a.EmptyCP < 2
			or (c.HasBuff("Shadow Blades") and a.EmptyCP < 3) then
			
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

c.AddOptionalSpell("Marked for Death", "for Combat", {
	CheckFirst = function()
		return a.CP <= 1
			and not c.HasBuff("Shadow Blades", false, false, true)
	end
})

addSpell("Slice and Dice", "for Combat", {
	NoRangeCheck = true,
	CheckFirst = function(z)
		if c.IsSolo() then
			z.FlashColor = "yellow"
			z.Continue = true
			if c.HasGlyph("Deadly Momentum") then
				return a.SnD == 0 and a.CP >= 5
			else
				return a.SnD < 2
			end
		else
			z.FlashColor = nil
			z.Continue = nil
			return a.SnD < 2 or (a.Guile == 11 and a.SnD < 16 and a.CP >= 4)
		end
		
	end
})

addOptionalSpell("Rupture", "for Combat", {
	CheckFirst = function()
		return shouldSpendCpCombat()
			and a.Rupture < 2
			and not c.HasBuff("Blade Flurry")
			and not c.IsSolo()
	end
})

addSpell("Eviscerate", "for Combat", {
	CheckFirst = shouldSpendCpCombat,
})

c.AddSpell("Revealing Strike", nil, {
	Melee = true,
	Override = function(z)
		if c.GetMyDebuffDuration("Revealing Strike") > 2
			or c.IsAuraPendingFor("Revealing Strike")
			or not shouldSpendEnergyCombat() then
			
			return false
		end
		
		c.MakePredictor(z, not hasSufficientEnergy(z))
		return true
	end
})

c.AddSpell("Revealing Strike", "if Down", {
	Melee = true,
	Override = function(z)
		local duration = c.GetMyDebuffDuration("Revealing Strike")
		local cost = getCost(z)
		if a.Energy < cost then
			duration = duration + (cost - a.Energy) * a.Regen
		end
		if duration > .1 or c.IsAuraPendingFor("Revealing Strike") then
			return false
		end
		
		c.MakePredictor(z, a.Energy < cost)
		return true
	end
})

c.AddSpell("Sinister Strike", nil, {
	Melee = true,
	Override = function(z)
		return hasSufficientEnergy(z) and shouldSpendEnergyCombat() 
	end,
})

---------------------------------------------------------------------- Subtlety
local function getEnergyIn(delay)
	local energy = a.Energy + delay * a.Regen
	if a.RecoveryDelay < 0 then
		return energy
	elseif delay < a.SnD then
		return energy + 8 * math.floor((delay - a.RecoveryDelay) / 2)
	else
		return energy + 4 * (a.SnD - a.RecoveryDelay)
	end
end

local function getDelay(needed)
	needed = needed - a.Energy
	local delay = math.max(0, needed / a.Regen)
--	if a.SnD == 0
--		or delay <= a.RecoveryTick 
--		or not c.HasSpell("Energetic Recovery") then
		
		return delay
--	end
--	
--	delay = a.RecoveryTick
--	local snd = a.SnD
--	local energy = a.Energy + delay
--	while energy < needed do
--		local nextneeded = needed - 2 * a.Regen
--		if nextneeded <= 0 then
--			return delay + needed / a.Regen
--		end
--		
--		delay = delay + 2
--		if snd > 1 then
--			snd = snd - 2
--			needed = nextneeded - 8
--		end
--		if needed <= 0 then
--			return delay
--		end
--	end
end

local function modForDelay(spell, normalColor)
	local delay = getDelay(getCost(spell))
	c.MakePredictor(spell, delay > 0, normalColor)
	return delay
end

local function sizeForPooling(spell)
	c.MakeMini(
		spell, 
		a.Energy > 80
			and not c.HasBuff("Shadow Dance", false, false, true)
			and not c.HasBuff("Master of Subtlety", false, false, true)
			and not c.HasMyDebuff("Find Weakness", false, false, "Ambush")
			and (getEnergyIn(c.GetCooldown("Shadow Dance")) < 80
				or getEnergyIn(c.GetCooldown("Vanish")) < 60))
end

local function shouldAmbushForSubtlety()
	if c.HasTalent("Anticipation") then
		return a.EmptyCP >= 3 and a.CanAmbush()
	else
		return a.CP < 5 and a.CanAmbush()
	end
end

c.AddOptionalSpell("Premeditation", nil, {
	CheckFirst = function()
		return a.EmptyCP >= 4
	end
})

addSpell("Ambush", "for Subtlety", {
	Melee = true,
	Applies = { "Find Weakness" },
	CheckFirst = shouldAmbushForSubtlety,
})

c.AddOptionalSpell("Shadow Dance", nil, {
	Melee = true,
	CheckFirst = function(z)
		c.MakePredictor(z, a.Energy < 75, "yellow")
		return a.NoStealthiness and a.NeedsWeakness
	end
})

c.AddOptionalSpell("Vanish", "for Subtlety", {
	Melee = true,
	CheckFirst = function(z)
		c.MakePredictor(z, a.Energy < 45, "yellow")
		return a.Energy < 80
			and a.NoStealthiness
			and a.NeedsWeakness
			and not c.HasBuff("Master of Subtlety")
			and (not a.CanAmbush() or shouldAmbushForSubtlety())
			and not c.IsSolo()
	end
})

addSpell("Slice and Dice", "for Subtlety", {
	NoRangeCheck = true,
	CheckFirst = function(z)
		c.MakeOptional(z, c.IsSolo())
		local delay = modForDelay(z, z.FlashColor)
		local dur = a.SnD - delay
		if c.IsSolo() and c.HasGlyph("Deadly Momentum") then
			return dur <= 0 and a.CP >= 5
		else
			return dur < 4
		end
	end
})

c.AddSpell("Rupture", "for Subtlety", {
	Melee = true,
	NoPowerCheck = true,
	CheckFirst = function(z)
		c.MakeOptional(z, c.IsSolo())
		return a.Rupture - modForDelay(z, z.FlashColor) < 4
	end
})

addSpell("Eviscerate", "for Subtlety", {
	Melee = true,
})

c.AddSpell("Hemorrhage", "for Bleed", {
	Melee = true,
	NoPowerCheck = true,
	CheckFirst = function(z)
		local delay = modForDelay(z)
		if delay == 0 then
			sizeForPooling(z)
		end
		return c.GetMyDebuffDuration("Hemorrhage", false, false, true) - delay 
			< 3
	end
})

c.AddSpell("Hemorrhage", "if no Backstab", {
	Melee = true,
	NoPowerCheck = true,
	RunFirst = sizeForPooling,
	CheckFirst = function(z)
		return a.Energy > 30 and not a.CanBackstab()
	end
})

c.AddSpell("Backstab", nil, {
	Melee = true,
	NoPowerCheck = true,
	RunFirst = sizeForPooling,
	CheckFirst = function()
		return a.Energy > 35 and a.CanBackstab()
	end
})
