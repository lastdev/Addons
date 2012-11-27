local AddonName, a = ...
if a.BuildFail(50000) then return end
local L = a.Localize
local s = SpellFlashAddon
local c = BittensSpellFlashLibrary

local UnitCreatureType = UnitCreatureType
local UnitLevel = UnitLevel

c.Init(a)

------------------------------------------------------------------------ common
c.AddOptionalSpell("Blessing of Kings", nil, { NoRangeCheck = 1 })

c.AddOptionalSpell("Blessing of Might", nil, { NoRangeCheck = 1 })

c.AddOptionalSpell("Holy Avenger", nil, { 
	NoGCD = true,
	CheckFirst = function()
		return a.HolyPower < 3
	end
})

c.AddInterrupt("Rebuke")
--
--c.AddOptionalSpell("Seal of Truth", nil, {
--    CheckFirst = function()
--        return c.SelfBuffNeeded("Seal of Truth")
--    end
--})
--
--c.AddOptionalSpell("Judgement", "for Buff", {
--    NoRangeCheck = true,
--    CheckFirst = function()
--        return not c.HasBuff("Judgements of the Pure")
--        	and c.HasTalent("Judgements of the Pure")
--    end
--})
--
--c.AddOptionalSpell("Consecration", "over 50", {
--	Melee = true,
--    CheckFirst = function()
--        return s.PowerPercent("player") > 50
--    end
--})
--
--c.AddOptionalSpell("Auras", nil, {
--    Type = "form",
--    ID = "Devotion Aura",
--    FlashID = { 
--    	"Concentration Aura", 
--    	"Crusader Aura", 
--    	"Devotion Aura", 
--    	"Resistance Aura", 
--    	"Retribution Aura" 
--    },
--    Override = function()
--        return not s.Form()
--    end
--})

-------------------------------------------------------------------------- holy
--c.AddOptionalSpell("Word of Glory", "at 3", {
--    NoRangeCheck = 1,
--    CheckFirst = threeHolyPower,
--})
--
--c.AddOptionalSpell("Light of Dawn", "at 3", {
--    NoRangeCheck = 1,
--    CheckFirst = threeHolyPower,
--})
--
--c.AddOptionalSpell("Holy Shock", "under 3 with Daybreak", {
--    NoRangeCheck = 1,
--    CheckFirst = function()
--        return a.HolyPower < 3 and c.HasBuff("Daybreak")
--    end
--})
--
--c.AddOptionalSpell("Divine Light", nil, { NoRangeCheck = 1 })
--
--c.AddOptionalSpell("Flash of Light", nil, { NoRangeCheck = 1 })
--
--c.AddOptionalSpell("Holy Radiance", nil, { NoRangeCheck = 1 })
--
--c.AddOptionalSpell("Beacon of Light", nil, {
--    Override = function()
--        if not s.InRaidOrParty() then
--            return false
--        end
--        
--        if not a.BeaconTarget then
--            return true
--        end
--        
--        if s.InCombat() then
--            return not s.MyBuff(c.GetID("Beacon of Light"), a.BeaconTarget)
--        else
--            return s.MyBuffDuration(
--            	c.GetID("Beacon of Light"), a.BeaconTarget) < 2 * 60
--        end
--    end
--})

-------------------------------------------------------------------- protection
c.AddOptionalSpell("Seal of Insight", "for Prot", {
    Type = "form",
    CheckFirst = function()
    	return not s.Form()
    end
})

c.AddOptionalSpell("Righteous Fury", nil, {
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
	CheckFirst = function()
		return c.HasTalent("Sanctified Wrath") or c.HasGlyph("Avenging Wrath")
	end,
	ShouldHold = function()
		return c.HasGlyph("Avenging Wrath") and s.HealthPercent("player") > 85
	end
})

c.AddOptionalSpell("Word of Glory", "for Prot", {
	NoGCD = true,
	CheckFirst = function()
		local heal = a.HolyPower * 4 
			* (1 + .1 * c.GetBuffStack("Bastion of Glory"))
		return s.HealthDamagePercent("player") > heal + 5
	end
})

c.AddOptionalSpell("Divine Protection", nil, {
	NoGCD = true,
	CheckFirst = function()
		return c.HasGlyph("Divine Protection")
	end
})

c.AddOptionalSpell("Fire of the Deep", nil, {
    Type = "item",
    Buff = "Elusive",
})

c.AddOptionalSpell("Holy Avenger", "for Prot", { 
	NoGCD = true,
	ShouldHold = function()
		return a.HolyPower >= 3
	end
})

c.AddOptionalSpell("Guardian of Ancient Kings", nil, {
	NoRangeCheck = true,
})

c.AddOptionalSpell("Ardent Defender")

c.AddOptionalSpell("Shield of the Righteous", nil, {
	NoGCD = true,
    CheckFirst = function()
    	return a.HolyPower == 5-- and c.IsTanking()
    end
})

c.AddOptionalSpell("Shield of the Righteous", "to save Bastion of Glory", {
	NoGCD = true,
    CheckFirst = function()
    	local duration = c.GetBuffDuration("Bastion of Glory")
        return a.HolyPower >= 3 
        	and (duration > 0 and duration < 1) 
        --	and c.IsTanking()
    end
})

c.AddSpell("Holy Wrath", nil, {
	Melee = true,
	NoRangeCheck = true,
})

c.AddSpell("Holy Wrath", "to Stun", {
	Melee = true,
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
    Run = function(z)
    	z.EarlyRefresh = c.GetHastedTime(4.5)
    end
})

c.AddSpell("Eternal Flame", nil, {
	EarlyRefresh = 1, -- overwritten once applied
	CheckFirst = function(z)
		return a.HolyPower >= 3 
			and c.GetBuffDuration("Eternal Flame") < z.EarlyRefresh
	end
})
c.ManageDotRefresh("Eternal Flame", 3)

c.AddSpell("Sacred Shield", nil, {
	Buff = "Sacred Shield",
	BuffUnit = "player",
	NoRangeCheck = true,
})

c.AddSpell("Sacred Shield", "Refresh", {
	NoRangeCheck = true,
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

c.AddSpell("Avenger's Shield", "under Grand Crusader", {
    CheckFirst = function()
        return c.HasBuff("Grand Crusader")
    end
})

c.AddOptionalSpell("Consecration", nil, {
	NoRangeCheck = true,
	CheckFirst = function(z)
		z.Melee = not c.HasGlyph("Consecration")
		return c.GetCooldown("Consecration Glyphed") == 0
	end
})

c.AddTaunt("Hand of Reckoning", nil, { NoGCD = true })

------------------------------------------------------------------- retribution
c.AddOptionalSpell("Avenging Wrath", nil, { 
	NoGCD = true,
	CheckFirst = function()
		return c.HasBuff("Inquisition")
	end
})

c.AddSpell("Inquisition", nil, {
    Override = function()
        return a.HolyPower >= 3
        	and c.GetBuffDuration("Inquisition") < 2
        	and not c.IsCasting("Inquisition")
    end
})

c.AddSpell("Templar's Verdict", nil, { 
	Override = function()
		return a.HolyPower >= 3
	end
})

c.AddSpell("Templar's Verdict", "at 5", { 
	Override = function()
		return a.HolyPower == 5
	end
})

c.AddSpell("Hammer of Wrath", "for Ret", {
	Override = function(z)
		if (s.HealthPercent() > 20 and not c.HasBuff("Avenging Wrath"))
			or c.IsCasting("Hammer of Wrath") then
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

c.AddSpell("Exorcism", nil, {
	Run = function(z)
		if c.HasGlyph("Mass Exorcism") then
			z.Melee = true
			z.ID = c.GetID("Glyphed Exorcism")
		else
			z.Melee = nil
			z.ID = c.GetID("Exorcism")
		end
	end
})

c.AddOptionalSpell("Seal of Insight", "below 20", {
	Type = "form",
	CheckFirst = function()
		return s.PowerPercent("player") < 20
	end
})

c.AddOptionalSpell("Seal of Truth", nil, {
	Type = "form",
	CheckFirst = function()
		return s.Form() == nil
			or (s.Form("Seal of Insight") and s.PowerPercent("player") > 90)
	end
})
