local AddonName, a = ...
if a.BuildFail(50000) then return end
local L = a.Localize
local s = SpellFlashAddon
local c = BittensSpellFlashLibrary

local select = select
local math = math

c.Init(a)

------------------------------------------------------------------------ Common
c.AddOptionalSpell("Mark of the Wild", nil, {
	Override = function()
		return c.RaidBuffNeeded(c.STAT_BUFFS)
	end
})

c.AddOptionalSpell("Faerie Fire", nil, {
	Debuff = c.ARMOR_DEBUFFS,
})

c.AddOptionalSpell("Faerie Fire", "Early", {
	Debuff = c.ARMOR_DEBUFFS,
	EarlyRefresh = 10,
})

c.AddOptionalSpell("Force of Nature", nil, {
	NoRangeCheck = true,
})

----------------------------------------------------------------------- Balance
c.AddOptionalSpell("Moonkin Form", nil, {
	Type = "form",
})

c.AddOptionalSpell("Incarnation: Chosen of Elune", nil, {
	CheckFirst = function()
		return a.Lunar or a.Solar
	end
})

c.AddOptionalSpell("Celestial Alignment", nil, {
	CheckFirst = function()
		if c.HasTalent("Incarnation") then
			return c.HasBuff("Incarnation: Chosen of Elune")
		else
			return a.Lunar or a.Solar
		end
	end
})

c.AddSpell("Starfall", nil, {
	Buff = "Starfall",
	BuffUnit = "player",
})

c.AddSpell("Wrath", "Near Cap", {
	CheckFirst = function()
		return not a.GoingUp and a.Energy <= -70
	end
})

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

c.AddSpell("Starfire", "Near Cap", {
	CheckFirst = function()
		return a.GoingUp and a.Energy >= 60
	end
})

c.AddSpell("Starfire", "under Celestial Alignment", {
	CheckFirst = function()
		return c.GetBuffDuration("Celestial Alignment") 	
			> c.GetCastTime("Starfire") + .1
	end
})

c.AddSpell("Moonfire", nil, {
	MyDebuff = "Moonfire",
	CheckFirst = function()
		return not c.HasBuff("Celestial Alignment")
	end
})
c.ManageDotRefresh("Moonfire", 2)

c.AddSpell("Moonfire", "Overwrite", {
	CheckFirst = function()
		return a.Lunar 
			and c.GetMyDebuffDuration("Moonfire") 
				< c.GetBuffDuration("Nature's Grace") - 2
			and not c.IsAuraPendingFor("Moonfire")
	end
})

c.AddSpell("Sunfire", nil, {
	MyDebuff = "Sunfire",
	CheckFirst = function()
		return not c.HasBuff("Celestial Alignment")
	end
})
c.ManageDotRefresh("Sunfire", 2)

c.AddSpell("Sunfire", "Overwrite", {
	CheckFirst = function()
		return a.Solar 
			and c.GetMyDebuffDuration("Sunfire") 
				< c.GetBuffDuration("Nature's Grace") - 2
			and not c.IsAuraPendingFor("Sunfire")
	end
})

c.AddSpell("Starsurge", nil, {
	NotIfActive = true,
})

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
