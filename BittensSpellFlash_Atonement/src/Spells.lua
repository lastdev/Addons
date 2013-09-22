local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetTime = GetTime
local UnitStat = UnitStat
local select = select

c.RegisterForFullChannels("Penance", 2)

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

c.AddOptionalSpell("Shadowfiend", nil, {
	CheckFirst = function(z)
--		c.MakeMini(z, a.HealingNeeded)
		return a.Mana < 76
	end
})

c.AddOptionalSpell("Mindbender", nil, {
	CheckFirst = function(z)
--		c.MakeMini(z, a.HealingNeeded)
		return a.Mana < 82
	end
})

c.AddOptionalSpell("Desperate Prayer", nil, {
	NoGCD = true,
	Override = function()
		return c.GetHealthPercent("player") < 70
			and c.GetCooldown("Desperate Prayer") == 0
	end
})

c.AddOptionalSpell("Power Infusion", nil, { 
	NoRangeCheck = true, 
	NoGCD = true,
	CheckFirst = function()
		return (a.HealingNeeded or not a.Neutral or c.IsSolo())
			and c.GetCastTime("Smite") > 1.2
	end,
})

c.AddOptionalSpell("Soothing Talisman of the Shado-Pan Assault", nil, {
	Type = "item",
	CheckFirst = function()
		return s.MaxPower("player") * (1 - a.Mana / 100) > 40000
	end,
})

c.AddDispel("Dispel Magic", nil, "Magic")

c.AddSpell("Penance", nil, {
	GetDelay = function()
		return a.PenanceCD
	end
})

c.AddSpell("Penance", "Delay", {
	IsMinDelayDefinition = true,
	GetDelay = function()
		return a.PenanceCD, .5
	end,
})

c.AddSpell("Holy Fire", nil, {
	FlashID = { "Power Word: Solace", "Holy Fire" },
	Cooldown = 10,
	CheckFirst = function()
		return not c.HasTalent("Solace and Insanity")
	end
})

c.AddSpell("Power Word: Solace", nil, {
	FlashID = { "Power Word: Solace", "Holy Fire" },
	Cooldown = 10,
})

c.AddSpell("Smite", nil, {
	CheckFirst = function()
		if a.HealingNeeded then
			return true
		elseif a.HealOnly or a.Neutral then
			return false
		elseif a.Conserve then
			return not c.HasGlyph("Smite")
		else
			return true
		end
	end,
})

c.AddSpell("Smite", "Glyphed", {
	CheckFirst = function()
		if not c.HasGlyph("Smite") then
			return false
		end
		
		local dot = 
			c.HasTalent("Solace and Insanity") 
				and "Power Word: Solace" 
				or "Holy Fire"
		if c.GetMyDebuffDuration(dot, false, false, true) 
				< c.GetCastTime("Smite") then
			
			return false
		end
		
		if a.HealingNeeded then
			return true
		elseif a.Neutral then
			return false
		else
			return true
		end
	end
})

c.AddOptionalSpell("Shadow Word: Pain", "Apply", {
    MyDebuff = "Shadow Word: Pain",
    CheckFirst = function()
    	return not a.HealingNeeded
    end,
})

c.AddOptionalSpell("Shadow Word: Pain", "Refresh", {
    MyDebuff = "Shadow Word: Pain",
    Tick = 3,
    CheckFirst = function()
    	return not a.HealingNeeded
    end,
})

c.AddOptionalSpell("Shadow Word: Death", nil, {
	Cooldown = 8,
    CheckFirst = function()
        return not a.HealingNeeded and s.HealthPercent() < 20
    end
})

--c.AddOptionalSpell("Divine Star", nil, {
--	NoRangeCheck = true,
--	Cooldown = 15,
--	RunFirst = function(z)
--		if c.DistanceAtTheMost() > 24 then
--			z.FlashColor = "red"
--		else
--			z.FlashColor = "yellow"
--		end
--	end
--})
--
--c.AddSpell("Cascade", nil, {
--	NoRangeCheck = true,
--	CheckFirst = function(z)
--		if a.HealingNeeded then
--			return false
--		end
--		
--		local dist = c.DistanceAtTheLeast()
--		if dist >= 40 then
--			return false
--		elseif dist >= 30 then
--			z.FlashColor = "green"
--		elseif dist >= 20 then
--			z.FlashColor = "yellow"
--		else
--			z.FlashColor = "red"
--		end
--		return true
--	end
--})
