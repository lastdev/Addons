local AddonName, a = ...
if a.BuildFail(40000, 50000) then return end
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

------------------------------------------------------------------------ Common
local function poisonNeeded(names, offhand)
	local min
	if s.InCombat() then
		min = 0
	else
		min = 5 * 60
	end
	if offhand then
		return not s.OffHandItemBuff(names, min)
	else
		return not s.MainHandItemBuff(names, min)
	end
end

c.AddOptionalSpell("Instant Poison", nil, {
	Type = "item",
	CheckFirst = function()
		return poisonNeeded(L["Instant Poison"], false)
	end
})

local instantOrWound = { L["Instant Poison"], L["Wound Poison"] }
c.AddOptionalSpell("Instant Poison", "or Wound", {
	Type = "item",
	FlashID = { "Instant Poison", "Wound Poison" },
	CheckFirst = function()
		return poisonNeeded(instantOrWound, false)
	end
})

c.AddOptionalSpell("Deadly Poison", nil, {
	Type = "item",
	CheckFirst = function()
		return poisonNeeded(L["Deadly Poison"], true)
	end
})

local deadlyOrWound = { L["Deadly Poison"], L["Wound Poison"] }
c.AddOptionalSpell("Deadly Poison", "or Wound", {
	Type = "item",
	FlashID = { "Deadly Poison", "Wound Poison" },
	CheckFirst = function()
		return poisonNeeded(deadlyOrWound, true)
	end
})

c.AddSpell("Slice and Dice", nil, {
	Buff = "Slice and Dice",
	BuffUnit = "player",
	NoRangeCheck = true,
})

c.CloneSpell("Slice and Dice", "unless Solo", {
	CheckFirst = function()
		return not a.InSoloMode()
	end
})

c.AddOptionalSpell("Recuperate", nil, {
	NoRangeCheck = true,
})

c.AddOptionalSpell("Tricks of the Trade", nil, {
	NoRangeCheck = true,
	CheckFirst = function()
		return s.InRaidOrParty()
			and (not c.WearingSet(2, "T13")
				or not (c.HasBuff("Adrenaline Rush")
					or s.Buff(c.BLOODLUST_BUFFS, "player")))
	end
})

c.AddOptionalSpell("Redirect", nil, {
	CheckFirst = function()
		return GetComboPoints("player") == 0
			and s.Castable(c.GetSpell("Recuperate"))
	end
})

c.AddInterrupt("Kick", nil, {
	NoGCD = true,
})

----------------------------------------------------------------- Assassination
local function inExecute()
	return s.HealthPercent() < 35
		and a.CanBackstab()
		and c.GetTalentRank("Murderous Intent") == 2
end

local function doFinisher()
	return a.CP == 5 or (not inExecute() and a.CP == 4)
end

c.AddSpell("Mutilate", nil, {
	CheckFirst = function()
		return a.CP < 4 and not inExecute()
	end
})

c.AddSpell("Backstab", "during Execute", {
	CheckFirst = function()
		return a.CP < 5 and inExecute()
	end
})

c.AddSpell("Envenom", "to refresh Slice and Dice", {
	CheckFirst = function()
		local snd = c.GetBuffDuration("Slice and Dice")
		return snd > .1 and snd < 3
	end
})

c.AddSpell("Envenom", "for Assassination", {
	CheckFirst = function()
		if not doFinisher() then
			return false
		end
		
		if a.InSoloMode() then
			return true
		end
		
		local regen = a.Regen
		local rupture = c.GetMyDebuffDuration("Rupture")
		local untilCap = s.MaxPower("player") - a.Energy - 10
		return untilCap <= 0
			or (rupture > untilCap / regen and not c.HasBuff("Envenom"))
	end
})

c.AddOptionalSpell("Rupture", "for Assassination", {
	MyDebuff = "Rupture",
	CheckFirst = function(z)
		if not doFinisher() or a.InSoloMode() then
			return false
		end
		
		if a.CP < a.LastRuptureCP then
			z.EarlyRefresh = nil
		else
			z.EarlyRefresh = 1.9
		end
		
		local t = 0
		local e = a.Energy
		local regen = select(2, GetPowerRegen()) -- be conservative!
		
		-- sim casting rupture
		t = t + 1
		e = e - 25 + regen
		if a.CP == 5 and c.GetTalentRank("Relentless Strikes") == 3 then
			e = e + 25
		end
		
		-- sim generating at least one combo point
		t = t + 1
		if inExecute() then
			e = e - 30 + regen
		else
			e = e - 55 + regen
		end
		
		-- ensure we can cast envenom before SnD wears off
		t = c.GetBuffDuration("Slice and Dice") - t
		e = e + t * regen
		return t > .5 and e >= 35
	end
})

c.AddOptionalSpell("Vendetta")

c.AddOptionalSpell("Vanish", "for Assassination", {
	NoGCD = true,
	CheckFirst = function()
		return not a.InSoloMode()
			and not c.HasBuff("Overkill", true)
			and not c.HasMyDebuff("Garrote", true)
			and a.CP < 5
	end
})

------------------------------------------------------------------------ Combat
local function sndIsNext()
	-- Can we wait for SnD to wear off without capping?
	-- Only called at 4 or 5 combo points, so no need to consider double combo
	-- point generation.
	return not a.InSoloMode()
		and a.Energy
				 + a.Regen * c.GetBuffDuration("Slice and Dice")
				 - (5 - a.CP) * c.GetCost("Sinister Strike")
			< s.MaxPower("player") - 15
end

c.AddOptionalSpell("Adrenaline Rush", nil, {
	NoGCD = true,
	CheckFirst = function()
		return a.Energy < 25
	end
})

c.AddOptionalSpell("Killing Spree", nil, {
	NoRangeCheck = true,
	CheckFirst = function()
		local _, targetID = s.UnitInfo()
		return not a.NoKillingSpree[targetID]
			and a.Energy < 25
	end
})

c.AddOptionalSpell("Expose Armor", nil, {
	Debuff = c.ARMOR_DEBUFFS,
	EarlyRefresh = 5,
	CheckFirst = function()
		return a.CP == 5 and not sndIsNext() and not a.InSoloMode()
	end
})

c.AddOptionalSpell("Rupture", "unless SnD", {
	MyDebuff = "Rupture",
	EarlyRefresh = 1.9,
	RequireDebuff = c.BLEED_DEBUFFS,
	CheckFirst = function()
		return a.CP == 5
			and not sndIsNext()
			and not s.Buff("Blade Flurry", "player")
			and not a.InSoloMode()
	end
})

c.AddSpell("Eviscerate", "for Combat", {
	CheckFirst = function()
		return a.CP == 5 and (not sndIsNext() or a.InSoloMode())
	end
})

c.AddSpell("Revealing Strike", nil, {
	MyDebuff = "Revealing Strike",
	EarlyRefresh = 2,
	CheckFirst = function()
		return a.CP == 4 and not sndIsNext()
	end
})

-- improvement: wait before putting on that 5th combo point to get a better
-- estimate on sndIsNext()
c.AddSpell("Sinister Strike", "Smart", {
	CheckFirst = function()
		return a.CP < 4 or (a.CP == 4 and sndIsNext())
	end
})


---------------------------------------------------------------------- Subtlety
c.AddSpell("Shadow Dance", nil, {
	Type = "form",
	NoGCD = true,
	FlashColor = "yellow",
	CheckFirst = function()
		return not c.HasBuff("Master of Subtlety", true)
	end
})

c.AddSpell("Vanish", "for Subtlety", {
	NoGCD = true,
	FlashColor = "yellow",
	CheckFirst = function()
		return not a.InSoloMode()
			and a.CP < 3
			and not c.HasBuff("Master of Subtlety")
	end
})

c.AddOptionalSpell("Preparation", nil, {
	FlashSize = s.FlashSizePercent() / 2,
	CheckFirst = function()
		return c.GetCooldown("Vanish") > 20
			and c.GetCooldown("Shadowstep") > 5
	end
})

c.AddOptionalSpell("Premeditation", nil, {
	NoGCD = true,
	CheckFirst = function()
		return a.CP < 4
	end
})

c.AddOptionalSpell("Shadowstep", nil, {
	NoGCD = true,
	CheckFirst = function()
		local _, targetID = s.UnitInfo()
		return not a.NoShadowstep[targetID]
			and s.Castable(c.GetSpell("Ambush"))
	end
})

c.AddSpell("Ambush", nil, {
	CheckFirst = a.CanBackstab,
})

local function canFlashRupture(z)
	if a.InSoloMode() then
		return false
	end
	
	local duration = c.GetDebuffDuration("Rupture")
	local canEvisIn = math.max(
		0, (35 - a.Energy) / a.Regen)
	if duration > canEvisIn + .1 then
		z.FlashID = c.GetID("Eviscerate")
		z.Continue = nil
		z.FlashColor = nil
	else
		z.FlashID = nil
		z.Continue = 1
		z.FlashColor = "yellow"
	end
	return duration < 1.9
end

c.AddSpell("Rupture", "for Subtlety", {
	CheckFirst = canFlashRupture,
})

c.AddSpell("Rupture", "with Master of Subtlety", {
	CheckFirst = function(z)
		return c.HasBuff("Master of Subtlety") and canFlashRupture(z)
	end
})

c.AddSpell("Recuperate", "for Energetic Recovery", {
	Buff = "Recuperate",
	BuffUnit = "player",
	EarlyRefresh = 2.9,
	NoRangeCheck = true,
	CheckFirst = function()
		return c.HasTalent("Energetic Recovery")
	end
})

c.AddSpell("Hemorrhage", nil, {
	CheckFirst = function()
		if a.InSoloMode() or not a.CanBackstab() then
			return true
		end
		
		if not s.HasGlyph("Glyph of Hemorrhage")
			or c.IsAuraPendingFor("Hemorrhage") then
			
			return false
		end
		
		for i = 1, 500000 do
			local _, _, _, _, _, _, expires, source, _, _, id
				= UnitDebuff("target", i)
			if id == nil then
				return true -- no hemorrhage debuff found
			
			-- refresh the bleed at 3 seconds
			elseif id == 89775 and UnitIsUnit(source, "player") then
				return expires - GetTime() - c.GetBusyTime() < 2.9
			
			-- if the bleed debuff is fresh, the bleed may be pending
			elseif id == 16511 and UnitIsUnit(source, "player") then
				local duration = expires - GetTime()
				if duration > 55 then
					return false
				end
			end
		end
	end
})

c.AddSpell("Backstab", nil, {
	CheckFirst = a.CanBackstab(),
})
