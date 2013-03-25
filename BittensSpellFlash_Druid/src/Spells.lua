local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local UnitInRange = UnitInRange
local UnitIsUnit = UnitIsUnit
local select = select
local math = math

------------------------------------------------------------------------ Common
local function setFaerieID(z)
	z.Name = nil
	if c.HasTalent("Faerie Swarm") then
		z.ID = c.GetID("Faerie Swarm")
	else
		z.ID = c.GetID("Faerie Fire")
	end
end

c.AddOptionalSpell("Mark of the Wild", nil, {
	Override = function()
		return c.RaidBuffNeeded(c.STAT_BUFFS)
	end
})

c.AddOptionalSpell("Symbiosis", nil, {
	Override = function()
		if c.GetBuffDuration(a.SymbiosisSelfBuffs) > 5 * 60 then
			return false
		end
		for member in c.GetGroupMembers() do
			if not UnitIsUnit(member, "player") 
				and UnitInRange(member) 
				and (s.MyBuff(a.SymbiosisRaidBuffs, member)
					or not s.Buff(a.SymbiosisRaidBuffs, member)) then
				
				return true
			end
		end
	end
})

c.AddOptionalSpell("Faerie Fire", "for Debuff", {
	Debuff = c.ARMOR_DEBUFFS,
	RunFirst = setFaerieID,
})

c.AddOptionalSpell("Faerie Fire", "Early", {
	Debuff = c.ARMOR_DEBUFFS,
	EarlyRefresh = 10,
	RunFirst = setFaerieID,
})

c.AddOptionalSpell("Force of Nature", nil, {
	NoRangeCheck = true,
})

c.AddInterrupt("Skull Bash", nil, {
	NoGCD = true,
})

----------------------------------------------------------------------- Balance
c.AddOptionalSpell("Moonkin Form", nil, {
	Type = "form",
})

c.AddOptionalSpell("Incarnation: Chosen of Elune", nil, {
	CheckFirst = function()
		return a.Energy >= 100 or a.Energy <= -100
	end
})

c.AddOptionalSpell("Celestial Alignment", nil, {
	CheckFirst = function()
		return not (a.Lunar or a.Solar)
			and c.GetCooldown("Incarnation: Chosen of Elune") > 10
	end
})

c.AddOptionalSpell("Starfall", nil, {
	Override = function(z)
		if c.GetCooldown("Incarnation: Chosen of Elune") > 15 then
			z.FlashSize = nil
		elseif not a.GoingUp
			and (a.Energy <= -70 
				or (c.GetCooldown("Starsurge") == 0 and a.Energy <= -60)) then
			z.FlashSize = s.FlashSizePercent() / 2
		else
			return false
		end
		return not c.HasBuff("Starfall")
			and (c.GetCooldown("Starfall") == 0
				or (a.EclipsePending and a.Lunar))
	end
})

c.AddSpell("Starsurge", nil, {
	NotIfActive = true,
})

c.AddSpell("Starsurge", "under Shooting Stars", {
	CheckFirst = function()
		return c.HasBuff("Shooting Stars")
	end
})

local function notCastThisEclipse(name)
	return a.EclipsePending
		or c.GetMyDebuffDuration(name) < c.GetBuffDuration("Nature's Grace") - 1
end

c.AddSpell("Moonfire", nil, {
	CheckFirst = function()
		return notCastThisEclipse("Moonfire")
	end
})

c.AddSpell("Moonfire", "under Eclipse", {
	EarlyRefresh = 99,
	CheckFirst = function(z)
		return a.Lunar 
			and (notCastThisEclipse("Moonfire") 
				or c.GetMyDebuffDuration("Moonfire") < z.EarlyRefresh)
	end
})
c.ManageDotRefresh("Moonfire under Eclipse", 1, "Moonfire")

c.AddSpell("Sunfire", nil, {
	CheckFirst = function()
		return notCastThisEclipse("Sunfire")
	end
})

c.AddSpell("Sunfire", "under Eclipse", {
	EarlyRefresh = 99,
	CheckFirst = function(z)
		return a.Solar 
			and (notCastThisEclipse("Sunfire")
				or c.GetMyDebuffDuration("Sunfire") < z.EarlyRefresh)
	end
})
c.ManageDotRefresh("Sunfire under Eclipse", 1, "Sunfire")

c.AddSpell("Wrath", "under Celestial Alignment", {
	CheckFirst = function()
		return c.GetBuffDuration("Celestial Alignment") 	
			> c.GetCastTime("Wrath") + .1
	end
})

c.AddSpell("Starfire", nil, {
	CheckFirst = function()
		return a.GoingUp
	end
})

c.AddSpell("Starfire", "under Celestial Alignment", {
	CheckFirst = function()
		return c.GetBuffDuration("Celestial Alignment") 	
			> c.GetCastTime("Starfire") + .1
	end
})

c.AddInterrupt("Solar Beam")

------------------------------------------------------------------------- Feral
a.Costs = {
	["Ferocious Bite"] = 25,
	["Mangle(Cat Form)"] = 35,
	["Rake"] = 35,
	["Ravage"] = 45,
	["Rip"] = 30,
	["Savage Roar"] = 25,
	["Shred"] = 40,
}

c.AddOptionalSpell("Cat Form", nil, {
	Type = "form"
})

c.AddSpell("Survival Instincts", "under 30", {
	NoGCD = true,
	FlashColor = "red",
	CheckFirst = function()
		return s.HealthPercent("player") < 30
	end
})

c.AddSpell("Barkskin", "under 30", {
	NoGCD = true,
	FlashColor = "red",
	CheckFirst = function()
		return s.HealthPercent("player") < 30
	end
})

c.AddSpell("Savage Roar", nil, {
	NoRangeCheck = 1,
})

c.AddOptionalSpell("Tiger's Fury", nil, {
	NoGCD = true,
	CheckFirst = function()
		return a.Energy <= 35 
			and not a.Clearcasting
			and not c.HasBuff("Berserk", true)
	end
})

c.AddOptionalSpell("Berserk", nil, {
	NoGCD = true,
	CheckFirst = function()
		return c.GetCooldown("Tiger's Fury") > 6
	end
})

c.AddOptionalSpell("Incarnation: King of the Jungle", nil, {
--	NoGCD = true,
	CheckFirst = function()
		return c.GetCooldown("Tiger's Fury") > 6
	end
})

c.AddOptionalSpell("Healing Touch", "for Feral", {
	NoRangeCheck = 1,
	CheckFirst = function()
		return c.HasBuff("Predatory Swiftness")
	end
})

---------------------------------------------------------------------- Guardian
c.AddOptionalSpell("Bear Form", nil, {
	Type = "form",
})

c.AddOptionalSpell("Tooth and Claw", nil, {
	NoGCD = true,
	IsUp = function()
		return c.HasMyDebuff("Tooth and Claw", true)
	end,
})

c.AddOptionalSpell("Cenarion Ward", nil, {
	NoRangeCheck = true,
})

c.AddOptionalSpell("Nature's Swiftness", "for Guardian", {
	NoRangeCheck = true,
	InactiveFlashID = { "Healing Touch", "Nature's Swiftness" },
	RunFirst = function(z)
		if c.HasBuff("Nature's Swiftness") then
			z.ID = c.GetID("Healing Touch")
			z.FlashID = nil
		else
			z.ID = c.GetID("Nature's Swiftness")
			z.FlashID = z.InactiveFlashID
		end
	end, 
	ShouldHold = function()
		return s.HealthPercent("player") > 80
	end,
})

c.AddOptionalSpell("Barkskin", nil, {
	NoGCD = true,
})

c.AddOptionalSpell("Renewal", nil, {
	NoGCD = true,
	ShouldHold = function()
		return s.HealthPercent("player") > 70
	end,
})

c.AddOptionalSpell("Might of Ursoc", "at 2 mins", {
	NoGCD = true,
	IsUp = function()
		return c.HasBuff("Might of Ursoc", true)
			and c.WearingSet(2, "GuardianT14")
	end,
	Enabled = function()
		return c.WearingSet(2, "GuardianT14")
			and not c.HasGlyph("Might of Ursoc")
	end,
	ShouldHold = function()
		if c.HasGlyph("Might of Ursoc") then
			return s.HealthPercent("player") > 70
		else
			return s.HealthPercent("player") > 50
		end
	end,
})

c.AddOptionalSpell("Might of Ursoc", "above 2 mins", {
	NoGCD = true,
	Enabled = function()
		return not c.WearingSet(2, "GuardianT14") 
			or c.HasGlyph("Might of Ursoc")
	end,
	ShouldHold = function()
		if c.HasGlyph("Might of Ursoc") then
			return s.HealthPercent("player") > 70
		else
			return s.HealthPercent("player") > 50
		end
	end,
})

c.AddOptionalSpell("Survival Instincts", "Unglyphed", {
	NoGCD = true,
	Enabled = function()
		return not c.HasGlyph("Survival Instincts")
	end,
	CheckFirst = function()
		return not c.HasBuff("Frenzied Regeneration", true)
	end,
})

c.AddOptionalSpell("Survival Instincts", "Glyphed", {
	NoGCD = true,
	Enabled = function()
		return c.HasGlyph("Survival Instincts")
	end,
	CheckFirst = function()
		return not c.HasBuff("Frenzied Regeneration", true)
	end,
})

c.AddOptionalSpell("Frenzied Regeneration", nil, {
	NoGCD = true,
	CheckFirst = function()
		if c.HasBuff("Savage Defense", true) or not c.IsTanking() then
			return false
		end
		
		local damage = s.HealthDamagePercent("player")
		if c.HasGlyph("Frenzied Regeneration") then
			return damage > 15 and a.Rage >= 60
		else
			return damage > math.min(60, a.Rage) * .3
		end
	end,
})

c.AddOptionalSpell("Savage Defense", nil, {
	NoGCD = true,
	Melee = true,
	CheckFirst = function()
		return not c.HasBuff("Frenzied Regeneration") and c.IsTanking()
	end
})

c.AddOptionalSpell("Maul", nil, {
	NoGCD = true,
	CheckFirst = function()
		return a.EmptyRage < 10 and c.HasBuff("Tooth and Claw", true)
	end,
})

c.AddTaunt("Growl", nil, {
	NoGCD = true,
})

c.AddSpell("Thrash", nil, {
	Melee = true,
	NoRangeCheck = true,
})

c.AddSpell("Thrash", "for Weakened Blows", {
	Melee = true,
	NoRangeCheck = true,
	CheckFirst = function()
		return not c.HasDebuff(c.WEAKENED_BLOWS_DEBUFFS)
	end,
})

c.AddSpell("Thrash", "for Bleed", {
	Melee = true,
	NoRangeCheck = true,
	MyDebuff = "Thrash",
	EarlyRefresh = 2,
})

c.AddOptionalSpell("Healing Touch", "for Guardian", {
	CheckFirst = function()
		return c.HasBuff("Nature's Swiftness") 
			and s.HealthPercent("player") < 80
	end,
})

c.AddOptionalSpell("Rejuvenation", "for Guardian", {
	CheckFirst = function(z)
		return c.HasBuff("Heart of the Wild") and not c.HasBuff("Rejuvenation")
	end,
})

c.AddOptionalSpell("Rejuvenation", "Refresh for Guardian", {
	EarlyRefresh = 99,
	CheckFirst = function(z)
		return c.HasBuff("Heart of the Wild")
			and c.GetBuffDuration("Rejuvenation") < z.EarlyRefresh
	end,
})
c.ManageDotRefresh("Rejuvenation Refresh for Guardian", 3, "Rejuvenation")

c.AddSpell("Faerie Fire", nil, {
	RunFirst = setFaerieID,
})

c.AddSpell("Faerie Fire", "for Debuff for Guardian", {
	Debuff = c.ARMOR_DEBUFFS,
	RunFirst = setFaerieID,
})

c.AddSpell("Enrage", nil, {
	NoGCD = true,
	CheckFirst = function()
		return a.EmptyRage > 20 and c.IsTanking()
	end,
})
