local addonName, a = ...
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetPowerRegen = GetPowerRegen
local IsMounted = IsMounted
local UnitExists = UnitExists
local math = math

c.AssociateTravelTimes(
	.5,
	"Serpent Sting",
	"Explosive Shot",
	"Black Arrow",
	"Cobra Shot",
	"Arcane Shot",
	"Kill Shot",
	"Steady Shot",
	"Chimera Shot",
	"Aimed Shot")

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

local function generatorWillCap(padding)
	if s.HasSpell("Fervor") and c.GetCooldown("Fervor") < 3 then
		padding = padding + 50
	end
	local castTime = c.GetCastTime("Cobra Shot")
	return a.Focus 
			+ a.FocusAdded(c.GetBusyTime() + castTime) 
			+ castTime * a.Regen 
			+ padding
		> s.MaxPower("player")
end

------------------------------------------------------------------------ Common
c.AddOptionalSpell("Mend Pet", nil, {
	CheckFirst = function()
		return s.HealthPercent("pet") < 80
			and not s.Buff(c.GetID("Mend Pet"), "pet", c.GetBusyTime() + 2)
	end
})

addOptionalSpell("Serpent Sting", nil, {
	Applies = { "Serpent Sting Debuff", "Improved Serpent Sting" },
	CheckFirst = function(z)
--		return not s.MyDebuff(c.GetID("Serpent Sting"))
--			and not c.IsCastingOrInAir("Serpent Sting")
		return c.ShouldCastToRefresh(
			"Serpent Sting", "Serpent Sting", 0, true, 
			"Cobra Shot", "Chimera Shot")
	end
})

c.AddOptionalSpell("Aspect of the Hawk", nil, {
	Type = "form",
	NotWhileMoving = true,
})

c.AddOptionalSpell("Aspect of the Iron Hawk", nil, {
	Type = "form",
	NotWhileMoving = true,
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

addSpell("Powershot", nil, {
	CheckFirst = function(z)
		if s.Moving("player") then
			z.Continue = true
			z.FlashColor = "yellow"
		else
			z.Continue = nil
			z.FlashColor = nil
		end
		return true
	end
})

addSpell("Barrage")

c.AddSpell("Dire Beast", nil, {
	CheckFirst = function()
		return s.MaxPower("player") - a.Focus > a.Regen
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

c.AddOptionalSpell("Lynx Rush", nil, {
	CheckFirst = function()
		return c.GetMyDebuffDuration("Lynx Rush") < 3
	end
})

c.AddSpell("Blink Strike")

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

addSpell("Cobra Shot", "for Serpent Sting", {
	CheckFirst = function()
--		return c.GetMyDebuffDuration("Serpent Sting") < 4
--			and not c.IsCastingOrInAir("Cobra Shot")
--			and not c.IsCastingOrInAir("Serpent Sting")
		return c.ShouldCastToRefresh(
			"Cobra Shot", "Serpent Sting", 4, false, "Serpent Sting")
	end
})

addSpell("Glaive Toss")

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
		return generatorWillCap(25) or c.HasBuff("The Beast Within")
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

------------------------------------------------------------------ Marksmanship
local function underCarefulAim()
	return s.HealthPercent() > 90 and not c.GetOption("NoCarefulAim")
end

local function nextMMCooldown()
	return math.min(
		c.GetCooldown("Chimera Shot"),
		s.HealthPercent() < 20 and c.GetCooldown("Kill Shot") or 9001,
		c.GetCooldown("Glaive Toss"),
		c.GetCooldown("Dire Beast"),
		c.GetCooldown("A Murder of Crows"),
		c.GetCooldown("Stampede"),
		c.GetCooldown("Lynx Rush"),
		c.GetCooldown("Blink Strike"),
		c.GetCooldown("Fervor"))
end

c.AddSpell("Steady Shot", "2", {
	CheckFirst = function()
		return a.NextSSIsImproved and c.GetBuffDuration("Steady Focus") < 5
	end
})

c.AddSpell("Steady Shot", "Opportunistic", {
	CheckFirst = function()
		local time = c.GetCastTime("Steady Shot")
		if c.GetBuffDuration("Steady Focus") < time + 1
			and not c.IsCasting("Steady Shot") then
			
			return true
		end
		
		local gain = 17 + time * a.Regen
		if not a.NextSSIsImproved then
			time = time * 2
			gain = gain * 2
		end
		time = time - .5 -- we're ok with a little waste
		return a.Focus + gain < 100 and nextMMCooldown() > time
	end
})

addSpell("Chimera Shot", nil, {
	CheckFirst = function()
		return not c.IsCasting("Chimera Shot")
	end
})

addSpell("Chimera Shot", "to save Serpent Sting", {
	CheckFirst = function()
--		local dur = c.GetMyDebuffDuration("Serpent Sting")
--		return dur > 1 and dur < 4
		return c.ShouldCastToRefresh(
			"Chimera Shot", "Serpent Sting", 1, false, "Serpent Sting")
	end
})

addOptionalSpell("Stampede", "for Marksmanship", {
	FlashSize = s.FlashSizePercent() / 2,
	CheckFirst = function()
		return (c.HasBuff("Rapid Fire") or c.HasBuff(c.BLOODLUST_BUFFS))
			and c.HasBuff("Steady Focus")
	end
})

addSpell("Aimed Shot", nil, {
	FlashID = { "Aimed Shot", "Aimed Shot!" },
	Override = function()
		return (c.HasBuff("Fire!") and not c.IsQueued("Aimed Shot"))
			or (a.Focus >= 50
				and (underCarefulAim() or c.GetCastTime("Aimed Shot") < 1.4))
	end
})

addSpell("Arcane Shot", "for Marksmanship", {
	CheckFirst = function()
		return not underCarefulAim()
			and (a.Focus >= 60
				or (a.Focus >= 43 and (
					c.GetCooldown("Chimera Shot") 
						>= c.GetCastTime("Steady Shot"))))
	end
})

---------------------------------------------------------------------- Survival
addSpell("Explosive Shot", nil, {
	CheckFirst = function()
		return not c.IsCasting("Explosive Shot") or c.HasBuff("Lock and Load")
	end
})

addSpell("Black Arrow", nil, {
	EarlyRefresh = 1,
	CheckFirst = function(z)
--		return not c.HasMyDebuff("Black Arrow")
		return c.ShouldCastToRefresh(
			"Black Arrow", "Black Arrow", z.EarlyRefresh, true)
	end
})
c.ManageDotRefresh("Black Arrow", 2)

addSpell("Arcane Shot", "for Survival", {
	CheckFirst = function()
		return generatorWillCap(a.Regen * 2) -- room for 2 surprise explosive shots
	end
})
