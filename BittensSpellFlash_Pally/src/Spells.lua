local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetSpellBonusDamage = GetSpellBonusDamage
local UnitCreatureType = UnitCreatureType
local UnitLevel = UnitLevel
local UnitPowerMax = UnitPowerMax
local UnitStat = UnitStat
local math = math

local function setWogId(z)
	if c.HasSpell("Eternal Flame") then
		z.ID = c.GetID("Eternal Flame")
	else
		z.ID = c.GetID("Word of Glory")
	end
end

------------------------------------------------------------------------ Common
c.AddOptionalSpell("Blessing of Kings", nil, { NoRangeCheck = 1 })

c.AddOptionalSpell("Blessing of Might", nil, { NoRangeCheck = 1 })

c.AddOptionalSpell("Holy Avenger", nil, { 
	NoGCD = true,
	CheckFirst = function()
		return a.HolyPower < 3
	end
})

c.AddSpell("Judgment", nil, {
	GetDelay = function()
		return a.Judgment
	end,
})

c.AddSpell("Crusader Strike", nil, {
	GetDelay = function()
		return a.Crusader
	end,
})

c.AddSpell("Crusader Strike", "Delay", {
	IsMinDelayDefinition = true,
	GetDelay = function()
		return a.Crusader, .2
	end,
})

c.AddOptionalSpell("Lay on Hands", nil, {
	FlashColor = "red",
	NoRangeCheck = true,
	CheckFirst = function()
		return s.HealthPercent("player") < 20
			and not s.Debuff(c.GetID("Forebearance"), "player")
	end
})

c.AddInterrupt("Rebuke")

-------------------------------------------------------------------------- Holy
local function hpCheckFirst(z)
	if a.HolyPower < 3 then
		return false
	end
	
	local dp = c.GetBuffDuration("Divine Purpose")
	if dp > 0 and dp < 2.5 then
		z.FlashSize = nil
		z.FlashColor = "red"
		return true
	end
	
	z.FlashColor = "yellow"
	if a.HolyPower < 5 then
		z.FlashSize = s.FlashSizePercent() / 2
	else
		z.FlashSize = nil
	end
	return true
end

c.AddOptionalSpell("Seal of Insight", nil, {
	Type = "form",
})

c.AddOptionalSpell("Word of Glory", "for Holy", {
	RunFirst = setWogId,
	Override = hpCheckFirst,
})

c.AddOptionalSpell("Light of Dawn", "for Holy", {
	Override = hpCheckFirst,
})

c.AddOptionalSpell("Holy Shock", "under 5 with Daybreak", {
	NoRangeCheck = true,
	CheckFirst = function(z)
		local stack = c.GetBuffStack("Daybreak")
		if stack < 2 and c.IsCasting("Holy Radiance") then
			stack = stack + 1
		end
		c.MakeMini(z, stack == 1)
		return stack > 0 and a.HolyPower < 5
	end
})

c.AddOptionalSpell("Beacon of Light", nil, {
	Override = function()
		return s.InRaidOrParty()
			and not s.MyBuff(c.GetID("Beacon of Light"), a.BeaconTarget)
	end
})

c.AddOptionalSpell("Sacred Shield", "for Holy", {
	NoRangeCheck = true,
	CheckFirst = function()
		return not s.MyBuff(c.GetID("Sacred Shield"), a.SacredShieldTarget)
	end
})

c.AddOptionalSpell("Consume Selfless Healer", nil, { 
	ID = "Holy Radiance",
	FlashID = { "Divine Light", "Holy Radiance" },
	NoRangeCheck = true,
	CheckFirst = function()
		return a.SelflessHealer == 3
	end
})

c.AddOptionalSpell("Save Selfless Healer", nil, {
	ID = "Judgment",
	FlashID = { "Judgment", "Divine Light", "Holy Radiance" },
	NoRangeCheck = true,
	FlashColor = "red",
	CheckFirst = function()
		local duration = c.GetBuffDuration("Selfless Healer")
		return duration > 0 and duration < 2.5
	end
})

c.AddOptionalSpell("Divine Plea", nil, {
	NoRangeCheck = true,
	CheckFirst = function()
		local max = UnitPowerMax("player")
		local spirit = UnitStat("player", 5)
		local empower = math.max(.12 * max, 4.05 * spirit)
		if c.HasGlyph("Divine Plea") then
			empower = empower / 2
		end
		return c.GetPower() + empower < max
	end,
})

-------------------------------------------------------------------- Protection
c.AddOptionalSpell("Seal of Insight", "for Prot", {
	Type = "form",
	CheckFirst = function()
		return not s.Form()
	end
})

c.AddOptionalSpell("Righteous Fury", nil, {
	NoGCD = true,
	Buff = "Righteous Fury",
	BuffUnit = "player",
})

c.AddOptionalSpell("Avenging Wrath", "for Prot", {
	NoGCD = true,
	ShouldHold = function()
		return c.HasGlyph("Avenging Wrath") 
			and c.GetHealthPercent("player") > 85
	end
})

c.AddOptionalSpell("Avenging Wrath", "Damage Mode", {
	NoGCD = true,
	CheckFirst = c.InDamageMode,
})

c.AddOptionalSpell("Word of Glory", "for Prot", {
	RunFirst = setWogId,
	Override = function(z)
		if c.WearingSet(2, "ProtT15") 
			and c.GetBuffDuration("Shield of Glory") < 3 then
			
			z.FlashColor = "red"
		else
			z.FlashColor = "yellow"
		end
		return a.HolyPower > 0
			and c.GetCooldown(z.ID, true, 1.5) == 0 
			and 95 - c.GetHealthPercent("player")
				> math.min(3, a.HolyPower) 
					* 4 
					* (1 + .1 * c.GetBuffStack("Bastion of Glory", true))
	end
})

c.AddOptionalSpell("Holy Prism", "for Prot", {
	ShouldHold = function()
		return not c.InDamageMode() and c.GetHealthPercent() < 90
	end,
})

c.AddOptionalSpell("Hand of Purity", nil, {
	NoRangeCheck = true,
	CheckFirst = function()
		return not c.InDamageMode()
	end,
})

c.AddOptionalSpell("Divine Protection", nil, {
	NoGCD = true,
	CheckFirst = function()
		return c.HasGlyph("Divine Protection")
	end
})

c.AddOptionalSpell("Light's Hammer", "for Prot", {
	IsUp = function()
		return c.GetCooldown("Light's Hammer", false, 60) > 46
	end,
	ShouldHold = function()
		return c.GetHealthPercent() < 85
	end,
})

c.AddOptionalSpell("Execution Sentence", "for Prot", {
	ShouldHold = function()
		return not c.InDamageMode() and c.GetHealthPercent() < 85
	end,
})

c.AddOptionalSpell("Holy Avenger", "for Prot", { 
	NoGCD = true,
	ShouldHold = function()
		return a.HolyPower >= 3
	end
})

c.AddOptionalSpell("Holy Avenger", "Damage Mode", { 
	NoGCD = true,
	CheckFirst = c.InDamageMode,
	ShouldHold = function()
		return a.HolyPower >= 3
	end,
})

c.AddOptionalSpell("Guardian of Ancient Kings Prot", nil, {
	NoGCD = true,
	NoRangeCheck = true,
})

c.AddOptionalSpell("Ardent Defender", nil, {
	NoGCD = true,
	Enabled = function()
		return not c.WearingSet(2, "ProtT14")
	end
})

c.AddOptionalSpell("Ardent Defender", "2pT14", {
	NoGCD = true,
	Enabled = function()
		return c.WearingSet(2, "ProtT14")
	end
})

c.AddOptionalSpell("Shield of the Righteous")

c.MakePredictor(c.AddOptionalSpell("Shield of the Righteous", "Predictor"))

c.AddOptionalSpell("Shield of the Righteous", "to save Buffs", {
	NoGCD = true,
	Melee = true,
	Override = function()
		if a.HolyPower < 3 then
			return false
		end
		
		local duration = c.GetBuffDuration("Bastion of Glory")
		if duration > 0 and duration < 1.6 then
			return true
		end
		
		local duration = c.GetBuffDuration("Divine Purpose")
		if duration > 0 and duration < 1.6 then
			return true
		end
	end
})

c.AddSpell("Holy Wrath", nil, {
	Melee = true,
	NoRangeCheck = true,
	Cooldown = 9,
})

local hwStunnable = {
	[L["Demon"]] = true,
	[L["Undead"]] = true,
	[L["Dragonkin"]] = "glyphed",
	[L["Elemental"]] = "glyphed",
	[L["Aberration"]] = "glyphed",
}
c.AddSpell("Holy Wrath", "to Stun", {
	Melee = true,
	NoRangeCheck = true,
	Cooldown = 9,
	CheckFirst = function()
		local level = UnitLevel("target")
		if level == -1 or level > UnitLevel("player") then
			return false
		end
		
		local stunnable = hwStunnable[UnitCreatureType("target")]
		return stunnable == true
			or (stunnable == "glyphed" and c.HasGlyph("Holy Wrath"))
	end
})

local function needsWeakenedBlows()
	return c.GetDebuffDuration(c.WEAKENED_BLOWS_DEBUFFS) < c.LastGCD
		and not c.InDamageMode()
end

c.AddSpell("Hammer of the Righteous", "for Debuff", {
	GetDelay = function(z)
		return c.AoE and needsWeakenedBlows() and a.Crusader
	end
})

c.AddSpell("Hammer of the Righteous", "for Prot AoE", {
	GetDelay = function()
		return c.AoE and a.Crusader
	end,
})

c.AddSpell("Crusader Strike", "for Debuff", {
	GetDelay = function(z)
		return needsWeakenedBlows() and a.Crusader
	end
})

c.AddSpell("Crusader Strike", "for Prot", {
	GetDelay = function()
		return a.Crusader
	end,
})

c.AddSpell("Sacred Shield", "for Prot", {
	Buff = "Sacred Shield",
	BuffUnit = "player",
	UseBuffID = true,
	NoRangeCheck = true,
	Cooldown = 6,
	Melee = true, -- let "refresh" flash if needed when out of melee range,
	              -- otherwise small green flashes are easy to confuse w/ big 
	              -- green flashes
	CheckFirst = function()
		return not c.InDamageMode()
	end,
})

c.AddSpell("Sacred Shield", "Refresh", {
	NoRangeCheck = true,
	Cooldown = 6,
	CheckFirst = function(z)
		if c.InDamageMode() then
			return false
		elseif GetSpellBonusDamage(2) > a.SacredShieldPower then
			z.FlashColor = "green"
			return true
		elseif c.GetBuffDuration("Sacred Shield", false, true, true) < 6 then
			z.FlashColor = nil
			return true
		end
	end,
})

c.AddSpell("Flash of Light", "for Prot", {
	NoRangeCheck = true,
	CheckFirst = function()
		return a.SelflessHealer == 3 and c.GetHealthPercent("player") < 85
	end
})

c.AddSpell("Judgment", "under Sanctified Wrath", {
	Cooldown = 6,
	CheckFirst = function()
		return c.HasTalent("Sanctified Wrath") 
			and c.HasBuff("Avenging Wrath", false, true)
	end,
})

c.AddSpell("Judgment", "under Sanctified Wrath Delay", {
	ID = "Judgment",
	IsMinDelayDefinition = true,
	GetDelay = function()
		return a.Judgment, c.InDamageMode() and .2 or c.LastGCD / 2
	end
})

c.AddSpell("Avenger's Shield", nil, {
	Cooldown = 15,
})

c.AddSpell("Avenger's Shield", "under Grand Crusader", {
	Cooldown = 15,
	CheckFirst = function()
		return c.HasBuff("Grand Crusader")
	end
})

c.AddSpell("Prot HP Gen Delay", nil, {
	ID = "Crusader Strike",
	IsMinDelayDefinition = true,
	GetDelay = function()
		return math.min(a.Judgment, a.Crusader), 
			c.InDamageMode() and .2 or c.LastGCD - .2
	end
})

c.AddSpell("Hammer of Wrath", nil, {
	Cooldown = 6,
	CheckFirst = function()
		return a.HoWPhase
	end
})

local getConsecrationDelay = function(z)
	if c.HasGlyph("Consecration") then
		z.Melee = nil
		return c.GetCooldown("Consecration Glyphed", false, 9)
	else
		z.Melee = true
		return c.GetCooldown("Consecration", false, 9)
	end
end

c.AddOptionalSpell("Consecration", nil, {
	NoRangeCheck = true,
	GetDelay = getConsecrationDelay,
})

c.AddOptionalSpell("Consecration", "for AoE", {
	NoRangeCheck = true,
	GetDelay = getConsecrationDelay,
	CheckFirst = function()
		return c.AoE
	end,
})

c.AddTaunt("Hand of Reckoning", nil, { NoGCD = true })

------------------------------------------------------------------- Retribution
c.AddOptionalSpell("Seal of Truth", nil, {
	Type = "form",
	CheckFirst = function()
		return s.Form() == nil
	end
})

c.AddOptionalSpell("Word of Glory", "for Ret", {
	RunFirst = setWogId,
	Override = function()
		return a.HolyPower > 0
			and not s.InRaidOrParty() 
			and 95 - c.GetHealthPercent("player") 
				> 8 * math.min(3, a.HolyPower)
			and (not s.InCombat() or a.HolyPower >= 3)
	end
})

c.AddOptionalSpell("Flash of Light", "for Ret", {
	NoRangeCheck = true,
	CheckFirst = function()
		return (a.SelflessHealer == 3 or not s.InCombat())
			and c.GetHealthPercent("player") < 80
	end
})

c.AddOptionalSpell("Avenging Wrath", "for Ret", { 
	CheckFirst = function()
		return a.Inquisition > 0
	end
})

c.AddOptionalSpell("Guardian of Ancient Kings Ret", nil, {
	NoGCD = true,
	NoRangeCheck = true,
	CheckFirst = function()
		return a.Inquisition > 0
	end
})

c.AddSpell("Inquisition", nil, {
	GetDelay = function()
		return a.HolyPower >= 1 and a.Inquisition
	end
})

c.AddSpell("Inquisition", "before Templar's Verdict at 5", {
	GetDelay = function()
		return (a.HolyPower == 5 
				or (a.HolyPower >= 3 and a.HolyAvenger > 0))
			and a.Inquisition - 3
	end
})

c.AddSpell("Inquisition", "before Templar's Verdict", {
	GetDelay = function()
		return a.HolyPower >= 3 and a.Inquisition - 4
	end
})

c.AddOptionalSpell("Execution Sentence", nil, {
	Cooldown = 60,
	CheckFirst = function()
		return a.Inquisition > 0
	end
})

c.AddSpell("Templar's Verdict", nil, { 
	Melee = true,
	CheckFirst = function(z)
		return a.HolyPower >= 3
	end
})

c.AddSpell("Templar's Verdict", "at 5", { 
	Melee = true,
	CheckFirst = function(z)
		return a.HolyPower == 5 
			or (a.HolyPower >= 3 and a.HolyAvenger > c.LastGCD)
	end,
})

c.AddSpell("Templar's Verdict", "4pT15", { 
	Melee = true,
	CheckFirst = function()
		return a.HolyPower >= 3 
			and a.Crusader < c.LastGCD
			and not c.AoE
			and c.HasBuff("Ret 4pT15 Buff")
	end,
})

c.AddSpell("Templar's Verdict", "with Divine Purpose", { 
	Melee = true,
	CheckFirst = function(z)
		return a.HolyPower >= 3 and a.DivinePurpose
	end
})

local function howDelay()
	local cd = c.GetCooldown("Hammer of Wrath", false, 6)
	return (a.HoWPhase or a.AvengingWrath > 0)
		and s.SpellInRange(c.GetID("Hammer of Wrath"))
		and cd
end

c.AddSpell("Hammer of Wrath", "for Ret", {
	GetDelay = howDelay,
})

c.AddSpell("Hammer of Wrath", "Delay", {
	IsMinDelayDefinition = true,
	GetDelay = function()
		return howDelay(), .2
	end,
})

c.AddSpell("Judgment", "Delay", {
	IsMinDelayDefinition = true,
	GetDelay = function()
		return a.Judgment, .2
	end
})

local function exorcismDelay()
	return (not c.HasGlyph("Mass Exorcism") or s.MeleeDistance())
		and a.Exorcism
end

c.AddSpell("Exorcism", nil, {
	GetDelay = exorcismDelay,
})

c.AddSpell("Exorcism", "Delay", {
	IsMinDelayDefinition = true,
	GetDelay = function()
		return exorcismDelay(), .2
	end,
})

c.AddSpell("Exorcism", "for AoE", {
	Melee = true,
	GetDelay = function()
		return c.AoE and c.HasGlyph("Mass Exorcism") and a.Exorcism
	end,
})

c.AddSpell("HP Gen Delay for Ret", nil, {
	ID = "Crusader Strike",
	IsMinDelayDefinition = true,
	GetDelay = function()
		return math.min(a.Exorcism, a.Judgment, a.Crusader), .2
	end
})

c.AddOptionalSpell("Light's Hammer", nil, {
	Cooldown = 60,
	NoRangeCheck = true,
})

c.AddSpell("Holy Prism", nil, {
	Cooldown = 20,
})

c.AddOptionalSpell("Sacred Shield", "for Ret", {
	NoRangeCheck = true,
	GetDelay = function(z)
		local delay = math.max(
			c.LastGCD, c.GetCooldown("Sacred Shield", false, 6))
		z.WhiteFlashOffset = -delay
		return delay
	end
})

c.AddSpell("Divine Storm", nil, { 
	Melee = true,
	CheckFirst = function()
		return c.AoE and a.HolyPower >= 3
	end
})

c.AddSpell("Divine Storm", "at 5", {
	Melee = true,
	CheckFirst = function()
		return (c.AoE or a.DivineCrusader) and
			(a.HolyPower == 5 
				or (a.HolyPower >= 3 and a.HolyAvenger > c.LastGCD))
	end,
})

c.AddSpell("Divine Storm", "with Divine Crusader", { 
	Melee = true,
	CheckFirst = function()
		return a.DivineCrusader
	end
})

c.AddSpell("Hammer of the Righteous", "for Ret", {
	GetDelay = function()
		return c.AoE and a.Crusader
	end,
})
