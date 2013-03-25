local addonName, a = ...

local L = a.Localize
local s = SpellFlashAddon
local g = BittensGlobalTables
local c = g.GetTable("BittensSpellFlashLibrary")
local u = g.GetTable("BittensUtilities")

local GetTime = GetTime
local GetTotemInfo = GetTotemInfo
local IsSwimming = IsSwimming
local UnitGUID = UnitGUID
local math = math

local function shouldFlashImbue(buffTooltipName, offhand)
	local min
	if s.InCombat() then
		min = 0
	elseif c.IsSolo() then
		min = 2 * 60
	else
		min = 5 * 60
	end
	if offhand then
		return not s.OffHandItemBuff(L[buffTooltipName], min)
	else
		return not s.MainHandItemBuff(L[buffTooltipName], min)
	end
end

------------------------------------------------------------------------ Common
c.AddOptionalSpell("Lightning Shield", nil, {
	Override = function()
		return c.GetBuffStack("Lightning Shield") < 2
			and c.SelfBuffNeeded("Lightning Shield")
	end
})

c.AddOptionalSpell("Ancestral Swiftness", nil, {
	CheckFirst = function()
		return not c.HasBuff("Ascendance")
	end
})

c.AddOptionalSpell("Earth Elemental Totem", nil, {
	CheckFirst = function()
		return c.GetCooldown("Fire Elemental Totem") > 50
	end
})

c.AddOptionalSpell("Fire Elemental Totem", nil, {
	CheckFirst = function()
		return c.IsMissingTotem(1)
	end
})

c.AddOptionalSpell("Elemental Mastery")

c.AddSpell("Elemental Blast", nil, {
	NotIfActive = true,
})

c.AddOptionalSpell("Searing Totem", nil, {
	CheckFirst = function()
		return c.IsMissingTotem(1)
	end
})

c.AddOptionalSpell("Healing Surge", "when Solo", {
	Override = function()
		return c.IsSolo() and s.HealthPercent("player") < 80
	end
})

c.AddOptionalSpell("Water Walking", nil, {
	Override = function()
		return IsSwimming() and c.SelfBuffNeeded("Water Walking")
	end
})

c.AddInterrupt("Wind Shear")

--------------------------------------------------------------------- Elemental
c.AddOptionalSpell("Elemental Mastery", "unless Bloodlust", {
	CheckFirst = function()
		return not c.HasBuff(c.BLOODLUST_BUFFS)
	end
})

c.AddOptionalSpell("Ascendance", "for Elemental", {
	CheckFirst = function()
		return c.GetMyDebuffDuration("Flame Shock") >= 15
			and (c.GetCooldown("Lava Burst") > 0 or c.IsCasting("Lava Burst"))
			and not c.HasBuff("Ascendance")
	end
})

c.AddSpell("Flame Shock", "for Elemental", {
	EarlyRefresh = 0,
	NotIfActive = true,
	CheckFirst = function(z)
		if c.HasBuff("Ascendance") then
			return false
		end
		
		local duration = c.GetMyDebuffDuration("Flame Shock")
		if c.HasBuff("Elemental Mastery") or c.HasBuff(c.BLOODLUST_BUFFS) then
			return duration <= 2 * z.EarlyRefresh
		else
			return duration <= z.EarlyRefresh
		end
	end
})
c.ManageDotRefresh("Flame Shock for Elemental", 3, "Flame Shock")

c.AddSpell("Lava Burst", nil, {
	CheckFirst = function()
		return (c.GetMyDebuffDuration("Flame Shock")
					> c.GetCastTime("Lava Burst") + .1
				or c.IsAuraPendingFor("Flame Shock"))
			and (not c.IsCasting("Lava Burst")
				or (c.HasBuff("Lava Surge") and not c.IsQueued("Lava Burst")) 
				or c.HasBuff("Ascendance"))
	end
})

c.AddSpell("Earth Shock", "for Fulmination", {
	CheckFirst = function()
        local stacks = s.BuffStack(c.GetID("Lightning Shield"), "player")
        if stacks == 7 then
        	return true
        end
        
        local remaining = c.GetMyDebuffDuration("Flame Shock")
        return stacks > 3 and (remaining > 6 and remaining < 8)
	end
})

c.AddSpell("Unleash Elements", "for Elemental", {
	CheckFirst = function()
		return c.HasTalent("Unleashed Fury") and not c.HasBuff("Ascendance")
	end
})

c.AddOptionalSpell("Searing Totem", "for Elemental", {
	CheckFirst = function()
		return c.IsMissingTotem(1) 
			and c.GetCooldown("Fire Elemental Totem") > 15
	end
})

c.AddOptionalSpell("Thunderstorm", nil, {
	CheckFirst = function()
		return s.PowerPercent("player") < 85
	end
})

c.AddOptionalSpell("Flametongue Weapon", nil, {
	FlashID = { "Flametongue Weapon", "Weapon Imbues" },
	Override = function()
		return shouldFlashImbue("Flametongue")
	end
})

----------------------------------------------------------------------- Enhance
c.AddOptionalSpell("Windfury Weapon", nil, {
	FlashID = { "Windfury Weapon", "Weapon Imbues" },
	Override = function()
		return shouldFlashImbue("Windfury")
	end
})

c.AddOptionalSpell("Flametongue Weapon", "Offhand", {
	FlashID = { "Flametongue Weapon", "Weapon Imbues" },
	Override = function()
		return shouldFlashImbue("Flametongue", true)
	end
})

c.AddOptionalSpell("Ascendance", "for Enhancement", {
	CheckFirst = function()
		return c.GetCooldown("Stormstrike") > 3
			and not c.HasBuff("Ascendance")
	end
})

c.AddSpell("Unleash Elements", "with Unleashed Fury", {
	CheckFirst = function()
		return c.HasTalent("Unleashed Fury")
	end
})

c.AddSpell("Stormblast", nil, {
	FlashID = { "Stormblast", "Stormstrike" },
})

c.AddSpell("Stormstrike", nil, {
	Melee = true,
	FlashID = { "Stormblast", "Stormstrike" },
})

c.AddSpell("Lightning Bolt", "at 5", {
	CheckFirst = function()
		return a.Maelstrom == 5
	end
})

c.AddSpell("Lightning Bolt", "at 3", {
	CheckFirst = function()
		return a.Maelstrom >= 3 
			and not c.HasBuff("Ascendance")
			and (not s.Moving("player") or c.HasBuff("Spiritwalker's Grace"))
	end
})

c.AddSpell("Lightning Bolt", "at 2", {
	NotWhileMoving = true,
	CheckFirst = function()
		return a.Maelstrom >= 2 
			and not c.HasBuff("Ascendance")
			and (not s.Moving("player") or c.HasBuff("Spiritwalker's Grace"))
			and c.GetMinCooldown(
					"Lava Lash", 
					"Unleash Elements",
					"Earth Shock",
					"Feral Spirit",
					"Stormstrike", -- reports on cooldown w/ stormblast
					"Ascendance", -- resets stormblast cooldown
					"Elemental Blast")
				> .5
	end
})

c.AddSpell("Lightning Bolt", "2pT15", {
	NotWhileMoving = true,
	CheckFirst = function()
		return a.Maelstrom >= 4 
			and not c.HasBuff("Ascendance")
			and (not s.Moving("player") or c.HasBuff("Spiritwalker's Grace"))
			and c.WearingSet(2, "EnhanceT15")
	end
})

c.AddSpell("Lightning Bolt", "under Ancestral Swiftness", {
	CheckFirst = function()
		return c.HasBuff("Ancestral Swiftness")
	end
})

c.AddOptionalSpell("Ancestral Swiftness", "under 2", {
	CheckFirst = function()
		return c.GetBuffStack("Maelstrom Weapon") < 2
	end
})

c.AddSpell("Flame Shock", "Apply", {
	CheckFirst = function()
		return not c.HasMyDebuff("Flame Shock")
	end
})

c.AddSpell("Flame Shock", "Empowered Apply", {
	CheckFirst = function()
		return c.HasBuff("Unleash Flame") and not c.HasMyDebuff("Flame Shock")
	end
})

c.AddSpell("Flame Shock", "Improve", {
	CheckFirst = function()
		if not c.HasBuff("Unleash Flame") then
			return false
		end
		
		if c.GetMyDebuffDuration("Flame Shock") < 15 then
			return true
		end
		
		local dps = a.GetFSStats(true)
		local snap = u.GetFromTable(a.FSStats, UnitGUID(s.UnitSelection()))
		return snap == nil or dps > snap.Dps
	end
})

c.AddOptionalSpell("Feral Spirit", nil, {
	NoRangeCheck = true,
})

c.AddOptionalSpell("Feral Spirit", "4pT15", {
	NoRangeCheck = true,
	CheckFirst = function()
		return c.WearingSet(4, "EnhanceT15")
	end
})

c.AddSpell("Searing Totem", "Refresh", {
	CheckFirst = function(z)
		local dur, name = c.GetTotemDuration(1)
		return name == s.SpellName(z.ID)
			and dur < 30
			and c.GetMinCooldown(
					"Lava Lash", 
					"Unleash Elements",
					"Earth Shock",
					"Feral Spirit",
					"Stormstrike", -- reports on cooldown w/ stormblast
					"Ascendance", -- resets stormblast cooldown
					"Elemental Blast")
				> c.LastGCD
	end
})

------------------------------------------------------------------------- Resto
c.AddOptionalSpell("Earthliving Weapon", nil, {
	FlashID = { "Earthliving Weapon", "Weapon Imbues" },
	Override = function()
		return shouldFlashImbue("Earthliving")
	end
})

c.AddOptionalSpell("Water Shield", nil, {
	Override = function()
		return c.SelfBuffNeeded("Water Shield")
	end
})

c.AddOptionalSpell("Earth Shield", nil, {
	Override = function(z)
		if c.IsSolo() then
			return false
		end
		
		if not a.EarthShieldTarget then
			return true
		end
		
		if s.InCombat() then
			return not s.MyBuff(z.ID, a.EarthShieldTarget)
		else
			return s.MyBuffDuration(z.ID, a.EarthShieldTarget) < 2 * 60
				or s.MyBuffStack(z.ID, a.EarthShieldTarget) < 9
		end
	end
})

c.AddOptionalSpell("Healing Stream Totem", nil, {
	CheckFirst = function()
		return c.IsMissingTotem(3)
	end
})

c.AddOptionalSpell("Mana Tide Totem", nil, {
	CheckFirst = function()
		return c.IsMissingTotem(3) and s.PowerPercent("player") < 75
	end
})

c.AddOptionalSpell("Lightning Bolt", "for Mana", {
	Override = function()
		return c.HasGlyph("Telluric Currents")
			and s.PowerPercent("player") < 95
			and s.HealthPercent("raid|range") > 90
	end
})