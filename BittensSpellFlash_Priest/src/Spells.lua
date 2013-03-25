local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local CheckInteractDistance = CheckInteractDistance
local IsItemInRange = IsItemInRange
local math = math
local pairs = pairs

------------------------------------------------------------------------ common
c.AddOptionalSpell("Power Word: Fortitude", nil, {
	NoRangeCheck = true,
	CheckFirst = function()
		return c.RaidBuffNeeded(c.STAMINA_BUFFS)
	end
})

c.AddOptionalSpell("Inner Fire", nil, {
	Buff = "Inner Fire",
	BuffUnit = "player",
})

c.AddOptionalSpell("Power Infusion", nil, {
	NoGCD = true,
	NoRangeCheck = true,
})

c.AddOptionalSpell("Flash Heal", "under Surge of Light", {
	NoRangeCheck = true,
	NoStopChannel = true,
	CheckFirst = function()
		return c.HasBuff("Surge of Light")
	end
})

c.AddOptionalSpell("Shadowfiend", "for Mana", {
	NoStopChannel = true,
    CheckFirst = function()
        return s.PowerPercent("player") < 76
    end
})

c.AddOptionalSpell("Mindbender", "for Mana", {
	NoStopChannel = true,
	CheckFirst = function()
		return s.PowerPercent("player") < 85
	end
})

c.AddOptionalSpell("Inner Fire", "or Will", {
	FlashID = { "Inner Fire", "Inner Will" },
	CheckFirst = function()
		return not c.HasBuff("Inner Fire") and not c.HasBuff("Inner Will")
	end
})

c.AddOptionalSpell("Desperate Prayer", nil, {
	Override = function()
		return s.HealthPercent("player") < 70
			and s.HasSpell(c.GetID("Desperate Prayer"))
			and c.GetCooldown("Desperate Prayer") == 0
	end
})

c.AddOptionalSpell("Prayer of Mending", nil, {
	NoRangeCheck = true,
	NoStopChannel = true,
	CheckFirst = function()
		return not s.MyBuff(
			c.GetID("Prayer of Mending"), 
			a.PrayerOfMendingTarget,
			c.GetBusyTime())
	end
})

c.AddOptionalSpell("Binding Heal", nil, {
	NoRangeCheck = true,
	NoStopChannel = true,
	CheckFirst = function()
		return s.HealthPercent("player") < 85
	end
})

-------------------------------------------------------------------- Discipline
c.RegisterForFullChannels("Penance", 2)

c.AddOptionalSpell("Inner Focus", nil, {
	NoStopChannel = true,
})

c.AddOptionalSpell("Penance", "under Borrowed Time", {
	NoRangeCheck = true,
	NoStopChannel = true,
	CheckFirst = function()
		return c.HasBuff("Borrowed Time")
	end
})

c.AddOptionalSpell("Power Word: Shield", "under Divine Insight", {
	NoRangeCheck = true,
	NoStopChannel = true,
	CheckFirst = function()
		return c.HasBuff("Divine Insight")
	end
})

c.AddOptionalSpell("Archangel", nil, {
	NoStopChannel = true,
	CheckFirst = function(z)
		local dur = c.GetBuffDuration("Evangelism")
		local stack = c.GetBuffStack("Evangelism")
		if c.IsCasting("Penance", "Smite", "Holy Fire") then
			if dur > 0 then
				stack = math.min(5, stack + 1)
			else
				stack = 1
			end
			dur = 20
		end
		
		if dur == 0 or dur > 5 then
			return false
		end
		
		if stack < 5 then
			z.FlashSize = s.FlashSizePercent() / 2
		else
			z.FlashSize = nil
		end
		if dur < 1 then
			z.FlashColor = "red"
		else
			z.FlashColor = "yellow"
		end
		return true
	end
})

------------------------------------------------------------------------ Shadow
c.AddOptionalSpell("Shadowform", nil, {
	Type = "form",
})

c.AddOptionalSpell("Shadowfiend", nil, {
	Override = function()
		return c.GetCooldown("Shadowfiend") == 0
	end
})

c.AddOptionalSpell("Mindbender", nil, {
	Override = function()
		return c.GetCooldown("Mindbender") == 0
	end
})

c.AddOptionalSpell("Halo", nil, {
	Override = function(z)
		if not s.HasSpell(c.GetID("Halo")) or c.GetCooldown("Halo") > 0 then
			return false
		end
		
		z.FlashSize = nil
		local dist = c.DistanceAtTheLeast()
		if dist >= 25 then
			z.FlashColor = "red"
		elseif dist >= 20 then
			if not CheckInteractDistance(s.UnitSelection(), 1) then
				z.FlashSize = s.FlashSizePercent() / 2
			end
			z.FlashColor = "green"
		elseif dist >= 15 then
			z.FlashColor = "yellow"
		else
			z.FlashColor = "red"
		end
		return true
	end
})

c.AddSpell("Cascade", nil, {
	Override = function(z)
		if c.GetCooldown("Cascade") > 0 then
			return false
		end
		
		local dist = c.DistanceAtTheLeast()
		if dist >= 40 then
			return false
		elseif dist >= 30 then
			z.FlashColor = "green"
		elseif dist >= 20 then
			z.FlashColor = "yellow"
		else
			z.FlashColor = "red"
		end
		return true
	end
})

c.AddSpell("Devouring Plague", nil, {
	EarlyRefresh = 99,
	Override = function(z)
		return a.Orbs >= 3 
			and c.GetMyDebuffDuration("Devouring Plague") < z.EarlyRefresh
	end
})
c.ManageDotRefresh("Devouring Plague", 3)

c.AddSpell("Devouring Plague", "to Prevent Cap", {
	Override = function(z)
		return a.Orbs >= 3
			and (c.GetCooldown("Mind Blast") < 1.5
				or (s.HealthPercent() < 20 
					and c.GetCooldown("Shadow Word: Death") < 1.5
					and a.SWDinARow == 0))
	end
})

c.AddSpell("Shadow Word: Death", nil, {
	Override = function(z)
		return s.HealthPercent() < 20
			and (a.SWDinARow == 1
				or (a.SWDinARow == 0 
					and c.GetCooldown("Shadow Word: Death") == 0))
	end
})

c.AddSpell("Shadow Word: Death", "wait", {
	FlashColor = "green",
	FlashSize = s.FlashSizePercent() / 2,
	Override = function(z)
		return a.SWDinARow < 2
			and s.HealthPercent() < 20
			and c.GetCooldown("Shadow Word: Death") < .5
	end
})

c.AddSpell("Mind Blast", nil, {
	Override = function()
		return c.GetCooldown("Mind Blast") == 0
			and not c.IsCasting("Mind Blast")
	end
})

c.AddSpell("Mind Blast", "wait", {
	FlashColor = "green",
	FlashSize = s.FlashSizePercent() / 2,
	Override = function()
		return c.GetCooldown("Mind Blast") < .5
			and not c.IsCasting("Mind Blast")
	end
})

c.AddSpell("Shadow Word: Pain", nil, {
	EarlyRefresh = 99,
	Override = function(z)
		return c.GetMyDebuffDuration("Shadow Word: Pain") < z.EarlyRefresh
			and not c.IsCastingOrInAir("Shadow Word: Pain")
	end
})
c.ManageDotRefresh("Shadow Word: Pain", 3)

c.AddSpell("Shadow Word: Pain", "application", {
	Override = function(z)
		return not c.HasMyDebuff("Shadow Word: Pain")
			and not c.IsCastingOrInAir("Shadow Word: Pain")
	end
})

c.AddSpell("Vampiric Touch", nil, {
	EarlyRefresh = 99,
	Override = function(z)
		return c.GetMyDebuffDuration("Vampiric Touch") 
				< c.GetCastTime("Vampiric Touch") + z.EarlyRefresh
			and not c.IsCastingOrInAir("Vampiric Touch")
	end
})
c.ManageDotRefresh("Vampiric Touch", 3)

c.AddSpell("Vampiric Touch", "application", {
	Override = function(z)
		return c.GetMyDebuffDuration("Vampiric Touch") 
				< c.GetCastTime("Vampiric Touch")
			and not c.IsCastingOrInAir("Vampiric Touch")
	end
})

c.AddSpell("Mind Spike", "under Surge of Darkness", {
	Override = function()
		return a.Surges > 0
	end
})

c.AddSpell("Mind Spike", "under Surge of Darkness Cap", {
	Override = function()
		return a.Surges == 2
	end
})

c.AddOptionalSpell("Dispursion", nil, {
	CheckFirst = function()
		return s.PowerPercent("player") < 64
	end
})
