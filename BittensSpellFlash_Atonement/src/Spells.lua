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

c.AddOptionalSpell("Shadowfiend")

c.AddOptionalSpell("Mindbender")

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
		return c.GetCastTime("Smite") > 1.2
	end,
})

c.AddOptionalSpell("Soothing Talisman of the Shado-Pan Assault", nil, {
	Type = "item",
	CheckFirst = function()
		return c.GetPower() + 11882 < s.MaxPower("player")
	end,
})

c.AddDispel("Dispel Magic", nil, "Magic")

c.AddInterrupt("Silence", nil, {
  NoGCD = true,
})

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

local function inquisable()
  return c.HasGlyph("Inquisitor")
    and c.GetHealthPercent("player") > c.GetOption("HealPercent")
end

c.AddSpell("Holy Fire", nil, {
  FlashID = { "Power Word: Solace", "Holy Fire" },
  Cooldown = 10,
  CheckFirst = function()
    return not a.HasSolace
  end
})

c.AddSpell("Holy Fire", "Glyphed", {
  FlashID = { "Power Word: Solace", "Holy Fire" },
  Cooldown = 10,
  CheckFirst = function()
    return not a.HasSolace and inquisable()
  end
})

c.AddSpell("Power Word: Solace", nil, {
  FlashID = { "Power Word: Solace", "Holy Fire" },
  Cooldown = 10,
  CheckFirst = function()
    return a.HasSolace
  end
})

c.AddSpell("Power Word: Solace", "Glyphed", {
  FlashID = { "Power Word: Solace", "Holy Fire" },
  Cooldown = 10,
  CheckFirst = function()
    return a.HasSolace and inquisable()
  end
})

c.AddSpell("Smite", "Glyphed", {
	CheckFirst = function()
		if not c.HasGlyph("Smite") then
			return false
		end
		
		local dot = a.HasSolace and "Power Word: Solace" or "Holy Fire"
		if c.GetMyDebuffDuration(dot, false, false, true) 
				< c.GetCastTime("Smite") then
			
			return false
		end
		
		return true
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
