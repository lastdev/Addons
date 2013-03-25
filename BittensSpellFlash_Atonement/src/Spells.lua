local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local UnitStat = UnitStat
local select = select

local function modSpell(damageOnly, spell)
	spell.NoStopChannel = true
	if damageOnly then
		spell.CheckLast = function()
			return not a.HealingNeeded
		end
	end
end

local function addSpell(damageOnly, name, tag, attributes)
	modSpell(damageOnly, c.AddSpell(name, tag, attributes))
end

local function addOptionalSpell(damageOnly, name, tag, attributes)
	modSpell(damageOnly, c.AddOptionalSpell(name, tag, attributes))
end

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

addOptionalSpell(false, "Power Word: Shield", nil, {
	Override = function(z)
		if s.MyBuff(z.ID, a.ShieldTarget) then
			return false
		end
		
		local manaReturn = 1.5 * select(2, UnitStat("player", 5))
		return manaReturn > c.GetCost("Power Word: Shield")
	end
})

addOptionalSpell(false, "Shadowfiend", nil, {
    CheckFirst = function()
        return not a.HealingNeeded and a.Mana < 76
    end
})

addOptionalSpell(false, "Mindbender", nil, {
	CheckFirst = function()
		return not a.HealingNeeded and a.Mana < 85
	end
})

addOptionalSpell(false, "Power Infusion", nil, { 
	NoRangeCheck = true, 
})

addSpell(false, "Penance")
c.RegisterForFullChannels("Penance", 2)

addSpell(false, "Holy Fire", nil, {
	CheckFirst = function()
		return not c.HasTalent("Solace and Insanity")
	end
})

addSpell(false, "Power Word: Solace", nil, {
	CheckFirst = function()
		return c.HasTalent("Solace and Insanity")
	end
})

addSpell(false, "Smite")

addSpell(false, "Smite", "Glyphed", {
	CheckFirst = function()
		local dot = "Holy Fire"
		if c.HasTalent("Solace and Insanity") then
			dot = "Power Word: Solace"
		end
		return c.HasGlyph("Smite") 
			and (c.IsAuraPendingFor(dot) 
				or c.GetMyDebuffDuration(dot) > c.GetCastTime("Smite"))
	end
})

addOptionalSpell(true, "Shadow Word: Pain", nil, {
    MyDebuff = "Shadow Word: Pain",
})
c.ManageDotRefresh("Shadow Word: Pain", 3)

addSpell(true, "Shadow Word: Death", nil, {
    CheckFirst = function()
        return s.HealthPercent() < 20
    end
})
