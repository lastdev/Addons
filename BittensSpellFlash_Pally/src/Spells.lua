local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local UnitCreatureType = UnitCreatureType
local UnitLevel = UnitLevel
local math = math

------------------------------------------------------------------------ common
c.AddOptionalSpell("Blessing of Kings", nil, { NoRangeCheck = 1 })

c.AddOptionalSpell("Blessing of Might", nil, { NoRangeCheck = 1 })

c.AddOptionalSpell("Holy Avenger", nil, { 
	NoGCD = true,
	CheckFirst = function()
		return a.HolyPower < 3
	end
})

c.AddSpell("Crusader Strike", nil, {
	NotIfActive = true,
	CheckFirst = function()
		return not c.IsCasting("Hammer of the Righteous")
	end,
})

c.AddSpell("Judgment", nil, {
	NotIfActive = true,
})

c.AddOptionalSpell("Lay on Hands", nil, {
	FlashColor = "red",
	NoRangeCheck = true,
	CheckFirst = function()
		return s.HealthPercent("player") < 20
			and not s.Debuff(c.GetID("Forebearance"), "player")
	end
})

c.AddInterrupt("Rebuke")

-------------------------------------------------------------------------- Holy
local function hpCheckFirst(z)
	if a.HolyPower < 3 then
		return false
	end
	
	local dp = c.GetBuffDuration("Divine Purpose")
	if dp > 0 and dp < 2.5 then
		z.FlashSize = nil
		z.FlashColor = "red"
		return true
	end
	
	z.FlashColor = "yellow"
	if a.HolyPower < 5 then
		z.FlashSize = s.FlashSizePercent() / 2
	else
		z.FlashSize = nil
	end
	return true
end

c.AddOptionalSpell("Seal of Insight", nil, {
	Type = "form",
})

c.AddOptionalSpell("Word of Glory", "for Holy", {
	Override = hpCheckFirst,
})

c.AddOptionalSpell("Eternal Flame", "for Holy", {
	Override = hpCheckFirst,
})

c.AddOptionalSpell("Light of Dawn", "for Holy", {
	Override = hpCheckFirst,
})

c.AddOptionalSpell("Holy Shock", "under 5 with Daybreak", {
	NoRangeCheck = 1,
	CheckFirst = function()
		return a.HolyPower < 5 
			and (c.HasBuff("Daybreak") or c.IsCasting("Holy Radiance"))
	end
})

c.AddOptionalSpell("Beacon of Light", nil, {
	Override = function()
		return s.InRaidOrParty()
			and not s.MyBuff(c.GetID("Beacon of Light"), a.BeaconTarget)
	end
})

c.AddOptionalSpell("Sacred Shield", "for Holy", {
	NoRangeCheck = true,
	CheckFirst = function()
		return not s.MyBuff(c.GetID("Sacred Shield"), a.SacredShieldTarget)
	end
})

c.AddOptionalSpell("Flash of Light", "under Selfless Healer", { 
	NoRangeCheck = 1,
	CheckFirst = function()
		return c.GetBuffStack("Selfless Healer") == 3
	end
})

c.AddOptionalSpell("Flash of Light", "to Save Selfless Healer", {
	NoRangeCheck = 1,
	FlashColor = "red",
	CheckFirst = function()
		local duration = c.GetBuffDuration("Selfless Healer")
		return duration > 0 and duration < 2.5
	end
})

c.AddOptionalSpell("Judgment", "to Save Selfless Healer", {
	NoRangeCheck = 1,
	FlashColor = "red",
	CheckFirst = function()
		local duration = c.GetBuffDuration("Selfless Healer")
		return duration > 0 and duration < 2.5
	end
})

-------------------------------------------------------------------- Protection
c.AddOptionalSpell("Seal of Insight", "for Prot", {
	Type = "form",
	CheckFirst = function()
		return not s.Form()
	end
})

c.AddOptionalSpell("Righteous Fury", nil, {
	NoGCD = true,
	Buff = "Righteous Fury",
	BuffUnit = "player",
})

c.AddOptionalSpell("Avenging Wrath", "if Plain", {
	NoGCD = true,
	CheckFirst = function()
		return not c.HasTalent("Sanctified Wrath")
			and not c.HasGlyph("Avenging Wrath")
	end
})

c.AddOptionalSpell("Avenging Wrath", "if Cool for Prot", {
	NoGCD = true,
	Enabled = function()
		return c.HasTalent("Sanctified Wrath") or c.HasGlyph("Avenging Wrath")
	end,
	ShouldHold = function()
		return c.HasGlyph("Avenging Wrath") and s.HealthPercent("player") > 85
	end
})

c.AddOptionalSpell("Word of Glory", "for Prot", {
	Override = function()
		return a.HolyPower > 0
			and c.GetCooldown("Word of Glory", true) == 0 
			and s.HealthDamagePercent("player") - 5 
				> math.min(3, a.HolyPower) 
					* 4 
					* (1 + .1 * c.GetBuffStack("Bastion of Glory", true))
	end
})

c.AddOptionalSpell("Hand of Purity", nil, {
	NoRangeCheck = true,
})

c.AddOptionalSpell("Divine Protection", nil, {
	NoGCD = true,
	CheckFirst = function()
		return c.HasGlyph("Divine Protection")
	end
})

c.AddOptionalSpell("Holy Avenger", "for Prot", { 
	NoGCD = true,
	ShouldHold = function()
		return a.HolyPower >= 3
	end
})

c.AddOptionalSpell("Guardian of Ancient Kings", nil, {
	NoGCD = true,
	NoRangeCheck = true,
})

c.AddOptionalSpell("Ardent Defender", nil, {
	NoGCD = true,
	Enabled = function()
		return not c.WearingSet(2, "ProtT14")
	end
})

c.AddOptionalSpell("Ardent Defender", "2pT14", {
	NoGCD = true,
	Enabled = function()
		return c.WearingSet(2, "ProtT14")
	end
})

c.AddOptionalSpell("Shield of the Righteous")

c.AddOptionalSpell("Shield of the Righteous", "to save Buffs", {
	Override = function()
		if a.HolyPower < 3 or not s.MeleeDistance() then
			return false
		end
		
		local duration = c.GetBuffDuration("Bastion of Glory")
		if duration > 0 and duration < 1.6 then
			return true
		end
		
		local duration = c.GetBuffDuration("Divine Purpose")
		if duration > 0 and duration < 1.6 then
			return true
		end
	end
})

c.AddSpell("Holy Wrath", nil, {
	Melee = true,
	NoRangeCheck = true,
	NotIfActive = true,
})

c.AddSpell("Holy Wrath", "to Stun", {
	Melee = true,
	NotIfActive = true,
	NoRangeCheck = true,
	CheckFirst = function()
		local level = UnitLevel("target")
		if level == -1 or level > UnitLevel("player") then
			return false
		end
		
		local ct = UnitCreatureType("target")
		if ct == L["Demon"] or ct == L["Undead"] then
			return true
		end
		
		if not c.HasGlyph("Holy Wrath") then
			return false
		end
		
		return ct == L["Dragonkin"] or ct == L["Elemental"]
	end
})

c.AddSpell("Hammer of the Righteous", "for Debuff", {
	Debuff = c.WEAKENED_BLOWS_DEBUFFS,
	CheckFirst = function(z)
		z.EarlyRefresh = c.GetHastedTime(4.5)
		return not c.IsCasting("Crusader Strike")
	end
})

c.AddSpell("Eternal Flame", "for Prot", {
	EarlyRefresh = 1, -- overwritten once applied
	CheckFirst = function(z)
		return a.HolyPower >= 3 
			and c.GetBuffDuration("Eternal Flame") < z.EarlyRefresh
	end
})
c.ManageDotRefresh("Eternal Flame", 3)

c.AddSpell("Sacred Shield", "for Prot", {
	Buff = "Sacred Shield",
	BuffUnit = "player",
	NoRangeCheck = true,
	NotIfActive = true,
})

c.AddSpell("Sacred Shield", "Refresh", {
	NoRangeCheck = true,
	NotIfActive = true,
	CheckFirst = function()
		return c.GetBuffDuration("Sacred Shield") < 5
	end
})

c.AddSpell("Flash of Light", "for Prot", {
	NoRangeCheck = true,
	CheckFirst = function()
		return a.SelflessHealer == 3 and s.HealthPercent("player") < 85
	end
})

c.AddSpell("Avenger's Shield", nil, {
	NotIfActive = true,
})

c.AddSpell("Avenger's Shield", "under Grand Crusader", {
	NotIfActive = true,
	CheckFirst = function()
		return c.HasBuff("Grand Crusader")
	end
})

c.AddOptionalSpell("Consecration", nil, {
	NoRangeCheck = true,
	CheckFirst = function(z)
		if c.HasGlyph("Consecration") then
			z.Melee = nil
			return c.GetCooldown("Consecration Glyphed") == 0
		else
			z.Melee = true
			return true
		end
	end
})

c.AddTaunt("Hand of Reckoning", nil, { NoGCD = true })

------------------------------------------------------------------- retribution
c.AddOptionalSpell("Seal of Truth", nil, {
	Type = "form",
	CheckFirst = function()
		return s.Form() == nil
	end
})

c.AddOptionalSpell("Word of Glory", "for Ret", {
	FlashID = { "Word of Glory", "Eternal Flame" },
	Override = function()
		return a.HolyPower > 0
			and not s.InRaidOrParty() 
			and s.HealthDamagePercent("player") - 5 
				> 8 * math.min(3, a.HolyPower)
			and (not s.InCombat() or a.HolyPower >= 3)
	end
})

c.AddOptionalSpell("Flash of Light", "for Ret", {
	NoRangeCheck = true,
	CheckFirst = function()
		return (a.SelflessHealer == 3 or not s.InCombat())
			and s.HealthPercent("player") < 80
	end
})

c.AddOptionalSpell("Avenging Wrath", "for Ret", { 
	CheckFirst = function()
		return c.HasBuff("Inquisition")
	end
})

c.AddSpell("Inquisition", nil, {
	Override = function()
		return a.HolyPower >= 1
			and not c.HasBuff("Inquisition")
			and not c.IsCasting("Inquisition")
	end
})

c.AddSpell("Inquisition", "before Templar's Verdict at 5", {
	Override = function()
		return (a.HolyPower == 5 
				or (a.HolyPower >= 3 and c.HasBuff("Holy Avenger")))
			and c.GetBuffDuration("Inquisition") < 3
			and not c.IsCasting("Inquisition")
	end
})

c.AddSpell("Inquisition", "before Templar's Verdict", {
	Override = function()
		return a.HolyPower >= 3
			and c.GetBuffDuration("Inquisition") < 4
			and not c.IsCasting("Inquisition")
	end
})

c.AddOptionalSpell("Execution Sentence", nil, {
	CheckFirst = function()
		return c.HasBuff("Inquisition")
	end
})

c.AddSpell("Hammer of Wrath", "for Ret", {
	Override = function(z)
		if (s.HealthPercent() > 20 and not c.HasBuff("Avenging Wrath"))
			or c.IsCasting("Hammer of Wrath")
			or not s.SpellInRange(c.GetID("Hammer of Wrath")) then
			
			return false
		end
		
		if c.IsCasting("Hammer of Wrath") then
			return false
		end
		
		local cd = c.GetCooldown("Hammer of Wrath")
		if cd == 0 then
			z.FlashColor = nil
			z.FlashSize = nil
			return true
		elseif z.FlashColor == nil then
			z.FlashColor = "green"
			z.FlashSize = s.FlashSizePercent() / 2
		end
		return cd < .2
	end
})

c.AddSpell("Templar's Verdict", nil, { 
	Override = function()
		return a.HolyPower >= 3 and s.MeleeDistance()
	end
})

c.AddSpell("Templar's Verdict", "at 5", { 
	Override = function()
		return (a.HolyPower == 5 
				or (a.HolyPower >= 3 
					and c.GetBuffDuration("Holy Avenger") > c.LastGCD))
			and s.MeleeDistance()
	end
})

c.AddSpell("Exorcism", nil, {
	Override = function()
		if c.HasGlyph("Mass Exorcism") then
			return c.GetCooldown("Glyphed Exorcism") == 0
				and not c.IsCasting("Glyphed Exorcism")
				and s.MeleeDistance()
		else
			return c.GetCooldown("Exorcism") == 0
				and not c.IsCasting("Exorcism")
		end
	end
})

local function countCasts(span)
	local casts = 0
	if c.GetCooldown("Exorcism") < span then
		casts = casts + 1
	end
	
	local avenge = c.GetBuffDuration("Avenging Wrath")
	local hammer = c.GetCooldown("Hammer of Wrath")
	if (s.HealthPercent() <= 20 or (avenge > 0 and avenge >= hammer))
		and hammer < span then
		
		casts = casts + 1
	end
	
	if c.GetCooldown("Execution Sentence") < span then
		casts = casts + 1
	end
	
	avenge = c.GetBuffDuration("Holy Avenger")
	if avenge > 0 then
		casts = casts + 1
		if avenge > 2 * c.LastGCD then
			casts = casts + 1
		end
	elseif a.RawHolyPower >= 3 then
		casts = casts + 1
		if c.HasBuff("Divine Purpose") then
			casts = casts + 1
		end
	end
	
	return casts
end

c.AddSpell("Judgment", "unless Wastes GCD", {
	CheckFirst = function()
		return (c.HasTalent("Sanctified Wrath") and c.HasBuff("Avenging Wrath"))
			or (countCasts(2 * c.LastGCD) > 0 and countCasts(3 * c.LastGCD) > 1)
	end
})

c.AddOptionalSpell("Light's Hammer")

local function cdOver1GCD(name)
	return c.IsCasting(name) or c.GetCooldown(name) > c.LastGCD
end

c.AddOptionalSpell("Sacred Shield", "for Ret", {
	NoRangeCheck = true,
	NotIfActive = true,
	CheckFirst = function()
		return cdOver1GCD("Judgment")
			and cdOver1GCD("Crusader Strike")
			and cdOver1GCD("Exorcism")
			and ((s.HealthPercent() > 20 and not c.HasBuff("Avenging Wrath"))
				or cdOver1GCD("Hammer of Wrath"))
			and cdOver1GCD("Light's Hammer")
			and cdOver1GCD("Holy Prism")
			and cdOver1GCD("Execution Sentence")
	end
})
