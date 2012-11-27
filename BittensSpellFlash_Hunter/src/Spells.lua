local AddonName, a = ...
if a.BuildFail(50000) then return end
local L = a.Localize
local s = SpellFlashAddon
local c = BittensSpellFlashLibrary

local GetPowerRegen = GetPowerRegen
local IsMounted = IsMounted
local UnitExists = UnitExists
local math = math

c.Init(a)

c.AssociateTravelTimes(
	.75,
	"Serpent Sting",
	"Multi-Shot")

c.AssociateTravelTimes(
	.5,
	"Explosive Shot",
	"Black Arrow",
	"Cobra Shot",
	"Arcane Shot",
	"Kill Shot")

local function sufficientResources(z)
	return c.GetCost(z.ID) <= a.Focus
end

local function modSpell(spell)
	spell.EvenIfNotUsable = true
	spell.NoPowerCheck = true
	spell.CheckLast = sufficientResources
end

local function addSpell(name, tag, attributes)
	modSpell(c.AddSpell(name, tag, attributes))
end

local function addOptionalSpell(name, tag, attributes)
	modSpell(c.AddOptionalSpell(name, tag, attributes))
end

local function generatorWillCap()
	return a.Focus 
			+ a.FocusAdded() 
			+ c.GetCastTime("Cobra Shot") * a.Regen 
			+ 10 
		> s.MaxPower("player")
end

------------------------------------------------------------------------ Common
c.AddOptionalSpell("Mend Pet", nil, {
	FlashColor = "red",
	CheckFirst = function()
		return s.HealthPercent("pet") < 80
			and not s.Buff(c.GetID("Mend Pet"), "pet", c.GetBusyTime() + 2)
	end
})

c.AddOptionalSpell("Hunter's Mark", nil, {
	Debuff = "Hunter's Mark",
	CheckFirst = function()
		return not c.HasGlyph("Marked for Death")
	end
})

addOptionalSpell("Serpent Sting", nil, {
	CheckFirst = function(z)
		return c.ShouldCastToRefresh(
			"Serpent Sting", "Serpent Sting", 0, true, "Cobra Shot")
	end
})

c.AddOptionalSpell("Aspect of the Hawk", nil, {
	Type = "form",
	NotWhileMoving = true,
	CheckFirst = function()
		return not s.Form("Aspect of the Wild")
	end
})

c.AddOptionalSpell("Call Pet", nil, {
	ID = "Call Pet 1",
	FlashID = {
		"Call Pet",
		"Call Pet 1",
		"Call Pet 2",
		"Call Pet 3",
		"Call Pet 4",
		"Call Pet 5",
		"Revive Pet",
	},
	CheckFirst = function()
		return not IsMounted() and not UnitExists("pet")
	end
})

c.AddOptionalSpell("Fervor", nil, {
	CheckFirst = function()
		return not c.HasBuff("Fervor")
			and s.MaxPower("player") - a.Focus > 55
	end
})

addOptionalSpell("A Murder of Crows", nil, {
	MyDebuff = "A Murder of Crows",
})

c.AddSpell("Dire Beast", nil, {
	CheckFirst = function()
		return s.MaxPower("player") - a.Focus > 30
	end
})

c.AddSpell("Arcane Shot", "under Thrill of the Hunt", {
	CheckFirst = function()
		local stacks = c.GetBuffStack("Thrill of the Hunt")
		if c.IsCasting("Arcane Shot") or c.IsCasting("Multi-Shot") then
			stacks = stacks - 1
		end
		return stacks > 0
	end
})

c.AddOptionalSpell("Lynx Rush")

c.AddOptionalSpell("Blink Strike")

c.AddOptionalSpell("Rapid Fire", nil, {
	CheckFirst = function()
		return not s.Buff(c.BLOODLUST_BUFFS, "player")
			and not c.HasBuff("Rapid Fire")
	end
})

c.AddOptionalSpell("Readiness", nil, {
	FlashSize = s.FlashSizePercent() / 2,
	CheckFirst = function()
		return c.GetCooldown("Rapid Fire") > 2.5 * 60
	end
})

c.AddOptionalSpell("Stampede", nil, {
	FlashSize = s.FlashSizePercent() / 2,
	CheckFirst = function()
		return c.HasBuff("Rapid Fire") or c.HasBuff(c.BLOODLUST_BUFFS)
	end
})

addSpell("Arcane Shot", nil, {
	CheckFirst = function()
		return generatorWillCap()
			or (s.HasSpell("Fervor") and c.GetCooldown("Fervor") < 3)
	end
})

addSpell("Cobra Shot", "for Serpent Sting", {
	CheckFirst = function()
		return c.ShouldCastToRefresh(
			"Cobra Shot", "Serpent Sting", 4, false, "Serpent Sting")
	end
})

----------------------------------------------------------------- Beast Mastery
c.AddOptionalSpell("Focus Fire", nil, {
	CheckFirst = function()
		return s.BuffStack(c.GetID("Frenzy"), "pet") == 5
			and not c.HasBuff("Focus Fire")
	end
})

addSpell("Kill Command")

addSpell("Arcane Shot", "for BM", {
	CheckFirst = function()
		return generatorWillCap()
			or c.HasBuff("The Beast Within")
			or (s.HasSpell("Fervor") and c.GetCooldown("Fervor") < 3)
	end
})

c.AddOptionalSpell("Bestial Wrath", nil, {
	CheckFirst = function()
		return a.Focus > 60
			and not c.HasBuff("The Beast Within")
	end
})

c.AddOptionalSpell("Rapid Fire", "for BM", {
	CheckFirst = function()
		return not c.HasBuff("Rapid Fire")
	end
})

---------------------------------------------------------------------- Survival
addSpell("Explosive Shot", nil, {
	CheckFirst = function()
		return not c.IsCasting("Explosive Shot") or c.HasBuff("Lock and Load")
	end
})

addSpell("Explosive Shot", "under Lock and Load", {
	CheckFirst = function()
		local stack = c.GetBuffStack("Lock and Load")
		if c.IsCasting("Explosive Shot") then
			stack = stack - 1
		end
		return stack > 0
	end
})

addSpell("Black Arrow", nil, {
	EarlyRefresh = 1,
	CheckFirst = function(z)
		return c.ShouldCastToRefresh(
			"Black Arrow", "Black Arrow", z.EarlyRefresh, true)
	end
})
c.ManageDotRefresh("Black Arrow", 2)
