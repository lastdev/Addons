local AddonName, a = ...
if a.BuildFail(50000) then return end
local L = a.Localize
local s = SpellFlashAddon
local c = BittensSpellFlashLibrary

local GetTime = GetTime
local UnitDebuff = UnitDebuff
local UnitIsUnit = UnitIsUnit
local math = math
local select = select

c.Init(a)

function a.InSoloMode()
	return (not s.InRaidOrParty()) and (not a.GetConfig("solo_off"))
end

function a.CanBackstab()
	local _, targetID = s.UnitInfo()
	return not a.NoBackstab[targetID] and not c.IsTanking()
end

local function modSpell(spell)
	local origColor = spell.FlashColor
	spell.NoPowerCheck = true
	spell.CheckLast = function()
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
c.AddOptionalSpell("Tricks of the Trade", nil, {
	NoRangeCheck = true,
	CheckFirst = function()
		if not s.InRaidOrParty() then
			return false
		end
		
		if not c.WearingSet(2, "T13") then
			return true
		end
		
		return not s.Buff(c.BLOODLUST_BUFFS, "player")
--			and not c.HasBuff("Adrenaline Rush")
	end
})

c.AddOptionalSpell("Deadly Poison", nil, {
	FlashID = { "Deadly Poison", "Poisons" },
	CheckFirst = function()
		return c.SelfBuffNeeded("Deadly Poison")
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

c.AddInterrupt("Kick", nil, {
	NoGCD = true,
})
--
--local deadlyOrWound = { L["Deadly Poison"], L["Wound Poison"] }
--c.AddOptionalSpell("Deadly Poison", "or Wound", {
--	Type = "item",
--	FlashID = { "Deadly Poison", "Wound Poison" },
--	CheckFirst = function()
--		return poisonNeeded(deadlyOrWound, true)
--	end
--})
--
--c.AddSpell("Slice and Dice", nil, {
--	Buff = "Slice and Dice",
--	BuffUnit = "player",
--	NoRangeCheck = true,
--	EarlyRerfesh = 3,
--})
--
--c.CloneSpell("Slice and Dice", "unless Solo", {
--	CheckFirst = function()
--		return not a.InSoloMode()
--	end
--})
--
--c.AddOptionalSpell("Recuperate", nil, {
--	NoRangeCheck = true,
--})

----------------------------------------------------------------- Assassination
--local function inExecute()
--	return s.HealthPercent() < 35
--		and a.CanBackstab()
--		and c.GetTalentRank("Murderous Intent") == 2
--end
--
--local function doFinisher()
--	return a.CP == 5 or (not inExecute() and a.CP == 4)
--end
--
--c.AddSpell("Mutilate", nil, {
--	CheckFirst = function()
--		return a.CP < 4 and not inExecute()
--	end
--})
--
--c.AddSpell("Backstab", "during Execute", {
--	CheckFirst = function()
--		return a.CP < 5 and inExecute()
--	end
--})
--
--c.AddSpell("Envenom", "to refresh Slice and Dice", {
--	CheckFirst = function()
--		local snd = c.GetBuffDuration("Slice and Dice")
--		return snd > .1 and snd < 3
--	end
--})
--
--c.AddSpell("Envenom", "for Assassination", {
--	CheckFirst = function()
--		if not doFinisher() then
--			return false
--		end
--		
--		if a.InSoloMode() then
--			return true
--		end
--		
--		local regen = a.Regen
--		local rupture = c.GetMyDebuffDuration("Rupture")
--		local untilCap = s.MaxPower("player") - a.Energy - 10
--		return untilCap <= 0
--			or (rupture > untilCap / regen and not c.HasBuff("Envenom"))
--	end
--})
--
--c.AddOptionalSpell("Rupture", "for Assassination", {
--	MyDebuff = "Rupture",
--	CheckFirst = function(z)
--		if not doFinisher() or a.InSoloMode() then
--			return false
--		end
--		
--		if a.CP < a.LastRuptureCP then
--			z.EarlyRefresh = nil
--		else
--			z.EarlyRefresh = 1.9
--		end
--		
--		local t = 0
--		local e = a.Energy
--		local regen = select(2, GetPowerRegen()) -- be conservative!
--		
--		-- sim casting rupture
--		t = t + 1
--		e = e - 25 + regen
--		if a.CP == 5 and c.GetTalentRank("Relentless Strikes") == 3 then
--			e = e + 25
--		end
--		
--		-- sim generating at least one combo point
--		t = t + 1
--		if inExecute() then
--			e = e - 30 + regen
--		else
--			e = e - 55 + regen
--		end
--		
--		-- ensure we can cast envenom before SnD wears off
--		t = c.GetBuffDuration("Slice and Dice") - t
--		e = e + t * regen
--		return t > .5 and e >= 35
--	end
--})
--
--c.AddOptionalSpell("Vendetta")
--
--c.AddOptionalSpell("Vanish", "for Assassination", {
--	NoGCD = true,
--	CheckFirst = function()
--		return not a.InSoloMode()
--			and not c.HasBuff("Overkill", true)
--			and not c.HasMyDebuff("Garrote", true)
--			and a.CP < 5
--	end
--})

------------------------------------------------------------------------ Combat
--local function sndIsNext()
--	-- Can we wait for SnD to wear off without capping?
--	-- Only called at 4 or 5 combo points, so no need to consider double combo
--	-- point generation.
--	return not a.InSoloMode()
--		and a.Energy
--				 + a.Regen * c.GetBuffDuration("Slice and Dice")
--				 - (5 - a.CP) * c.GetCost("Sinister Strike")
--			< s.MaxPower("player") - 15
--end
--
--c.AddOptionalSpell("Adrenaline Rush", nil, {
--	NoGCD = true,
--	CheckFirst = function()
--		return a.Energy < 25
--	end
--})
--
--c.AddOptionalSpell("Killing Spree", nil, {
--	NoRangeCheck = true,
--	CheckFirst = function()
--		local _, targetID = s.UnitInfo()
--		return not a.NoKillingSpree[targetID]
--			and a.Energy < 25
--	end
--})
--
--c.AddOptionalSpell("Expose Armor", nil, {
--	Debuff = c.ARMOR_DEBUFFS,
--	EarlyRefresh = 5,
--	CheckFirst = function()
--		return a.CP == 5 and not sndIsNext() and not a.InSoloMode()
--	end
--})
--
--c.AddOptionalSpell("Rupture", "unless SnD", {
--	MyDebuff = "Rupture",
--	EarlyRefresh = 1.9,
--	RequireDebuff = c.BLEED_DEBUFFS,
--	CheckFirst = function()
--		return a.CP == 5
--			and not sndIsNext()
--			and not s.Buff("Blade Flurry", "player")
--			and not a.InSoloMode()
--	end
--})
--
--c.AddSpell("Eviscerate", "for Combat", {
--	CheckFirst = function()
--		return a.CP == 5 and (not sndIsNext() or a.InSoloMode())
--	end
--})
--
--c.AddSpell("Revealing Strike", nil, {
--	MyDebuff = "Revealing Strike",
--	EarlyRefresh = 2,
--	CheckFirst = function()
--		return a.CP == 4 and not sndIsNext()
--	end
--})
--
---- improvement: wait before putting on that 5th combo point to get a better
---- estimate on sndIsNext()
--c.AddSpell("Sinister Strike", "Smart", {
--	CheckFirst = function()
--		return a.CP < 4 or (a.CP == 4 and sndIsNext())
--	end
--})


---------------------------------------------------------------------- Subtlety
addSpell("Slice and Dice", nil, {
	NoRangeCheck = true,
	CheckFirst = function(z)
		if a.InSoloMode() then
			z.FlashColor = "yellow"
			z.Continue = true
		else
			z.FlashColor = nil
			z.Continue = nil
		end
		return c.GetBuffDuration("Slice and Dice") < 3
	end
})

addOptionalSpell("Rupture", nil, {
	CheckFirst = function()
		return not a.InSoloMode() and c.GetMyDebuffDuration("Rupture") < 5
	end
})

addSpell("Ambush", nil, {
	CheckFirst = function()
		return a.CanBackstab()
	end
})

addSpell("Ambush", "for Last Second Find Weakness", {
	CheckFirst = function()
		return a.CanBackstab()
			and c.GetBuffDuration("Shadow Dance") < 2
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

--c.AddSpell("Shadow Dance", nil, {
--	Type = "form",
--	NoGCD = true,
--	FlashColor = "yellow",
--	CheckFirst = function()
--		return not c.HasBuff("Master of Subtlety", true)
--	end
--})
--
--c.AddSpell("Vanish", "for Subtlety", {
--	NoGCD = true,
--	FlashColor = "yellow",
--	CheckFirst = function()
--		return not a.InSoloMode()
--			and a.CP < 3
--			and not c.HasBuff("Master of Subtlety")
--	end
--})
--
--c.AddOptionalSpell("Premeditation", nil, {
--	NoGCD = true,
--	CheckFirst = function()
--		return a.CP < 4
--	end
--})
--
--c.AddOptionalSpell("Shadowstep", nil, {
--	NoGCD = true,
--	CheckFirst = function()
--		local _, targetID = s.UnitInfo()
--		return not a.NoShadowstep[targetID]
--			and s.Castable(c.GetSpell("Ambush"))
--	end
--})
--
--c.AddSpell("Ambush", nil, {
--	CheckFirst = a.CanBackstab,
--})
--
--local function canFlashRupture(z)
--	if a.InSoloMode() then
--		return false
--	end
--	
--	local duration = c.GetDebuffDuration("Rupture")
--	local canEvisIn = math.max(
--		0, (35 - a.Energy) / a.Regen)
--	if duration > canEvisIn + .1 then
--		z.FlashID = c.GetID("Eviscerate")
--		z.Continue = nil
--		z.FlashColor = nil
--	else
--		z.FlashID = nil
--		z.Continue = 1
--		z.FlashColor = "yellow"
--	end
--	return duration < 1.9
--end
--
--c.AddSpell("Rupture", "for Subtlety", {
--	CheckFirst = canFlashRupture,
--})
--
--c.AddSpell("Rupture", "with Master of Subtlety", {
--	CheckFirst = function(z)
--		return c.HasBuff("Master of Subtlety") and canFlashRupture(z)
--	end
--})
--
--c.AddSpell("Recuperate", "for Energetic Recovery", {
--	Buff = "Recuperate",
--	BuffUnit = "player",
--	EarlyRefresh = 2.9,
--	NoRangeCheck = true,
--	CheckFirst = function()
--		return c.HasTalent("Energetic Recovery")
--	end
--})
--
--c.AddSpell("Hemorrhage", nil, {
--	CheckFirst = function()
--		if a.InSoloMode() or not a.CanBackstab() then
--			return true
--		end
--		
--		if not s.HasGlyph("Glyph of Hemorrhage")
--			or c.IsAuraPendingFor("Hemorrhage") then
--			
--			return false
--		end
--		
--		for i = 1, 500000 do
--			local _, _, _, _, _, _, expires, source, _, _, id
--				= UnitDebuff("target", i)
--			if id == nil then
--				return true -- no hemorrhage debuff found
--			
--			-- refresh the bleed at 3 seconds
--			elseif id == 89775 and UnitIsUnit(source, "player") then
--				return expires - GetTime() - c.GetBusyTime() < 2.9
--			
--			-- if the bleed debuff is fresh, the bleed may be pending
--			elseif id == 16511 and UnitIsUnit(source, "player") then
--				local duration = expires - GetTime()
--				if duration > 55 then
--					return false
--				end
--			end
--		end
--	end
--})
--
--c.AddSpell("Backstab", nil, {
--	CheckFirst = a.CanBackstab(),
--})
