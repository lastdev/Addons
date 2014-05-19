local addonName, a = ...
local s = SpellFlashAddon
local x = s.UpdatedVariables
local g = BittensGlobalTables
local c = g.GetTable("BittensSpellFlashLibrary")
local u = g.GetTable("BittensUtilities")

local UnitLevel = UnitLevel
local GetPowerRegen = GetPowerRegen
local GetSpellBookItemName = GetSpellBookItemName
local GetTime = GetTime
local IsSwimming = IsSwimming
local SPELL_POWER_BURNING_EMBERS = SPELL_POWER_BURNING_EMBERS
local SPELL_POWER_SOUL_SHARDS = SPELL_POWER_SOUL_SHARDS
local UnitExists = UnitExists
local UnitGUID = UnitGUID
local math = math
local select = select

local baseLengths = {
	["Agony"] = 24,
	["Corruption"] = 18,
	["Unstable Affliction"] = 14,
	["Doom"] = 60,
	["Immolate"] = 15,
}

local function getDoTDuration(name)
	local duration = c.GetMyDebuffDuration(name)
	if name == "Immolate" then
		duration = math.max(duration, c.GetMyDebuffDuration("Immolate AoE"))
	end
	
	if c.IsCastingOrInAir(name)
		or c.IsCasting("Soul Swap")
		or GetTime() - a.SwapCast < .8
		or (name == "Corruption" and a.SocExplosionPending) then
		
		local base = baseLengths[name]
		return math.min(1.5 * base, duration + base)
	else
		return duration
	end
end

local function gcdCheck(name, padding)
	local time = math.max(1, c.GetHastedTime(1.5))
	if padding ~= nil then
		time = time + padding
	end
	return getDoTDuration(name) < time
end

local function soonCheck(name, considerCastTime)
	local time = u.GetFromTable(
		a.Snapshots, name, UnitGUID(s.UnitSelection()), "Tick")
	if time == nil then
		return false -- this is UA, and it is casting
	end
	
	if c.HasSpell("Pandemic") then
		time = 2 * time
	end
	if considerCastTime then
		time = time + c.GetCastTime(name)
	end
	return getDoTDuration(name) < time
end

local function pandemicCheck(name, z, castTime)
	if not c.HasSpell("Pandemic") then
		return false
	end
	
	local time = baseLengths[name] / 2 - 1
	if castTime then
		time = time + castTime
	end
	if getDoTDuration(name) > time then
		return false
	end
	
	if z ~= nil then
		local now = a.GetDps(name)
		local snapped = u.GetFromTable(
			a.Snapshots, name, UnitGUID(s.UnitSelection()), "Dps")
		if snapped == nil or now > snapped then
			z.FlashColor = "green"
		elseif now == snapped then
			z.FlashColor = "yellow"
		else
			z.FlashColor = "red"
		end
	end
	return true
end

local function doDarkSoul(z, easyCheck, hardCheck)
	if c.HasBuff(z.ID, false, false, true) then
		return false
	end
	
	if c.HasTalent("Archimonde's Darkness") then
		local charges, tilNext, tilMax = c.GetChargeInfo(z.ID)
		if tilMax == 0 then
			return easyCheck
		elseif charges > 0 then
			return hardCheck
		end
	else
		return easyCheck and c.GetCooldown(z.ID, false, 120) == 0
	end
end

------------------------------------------------------------------------ Common
local petIdentifiers = {
	[s.SpellName(c.GetID("Firebolt"), true)] = "Imp",
	[s.SpellName(c.GetID("Felbolt"), true)] = "Fel Imp",
	[s.SpellName(c.GetID("Torment"), true)] = "Voidwalker",
	[s.SpellName(c.GetID("Tongue Lash"), true)] = "Observer",
	[s.SpellName(c.GetID("Shadow Bite"), true)] = "Felhunter",
	[s.SpellName(c.GetID("Lash of Pain"), true)] = "Succubus",
}

function a.GetCurrentPet()
	for i = 1, 10000 do
		local spell = GetSpellBookItemName(i, "pet")
		if spell == nil then
			return nil
		end
		
		local pet = petIdentifiers[spell]
		if pet ~= nil then
			return pet
		end
	end
end

c.AddOptionalSpell("Dark Intent", nil, {
	Override = function()
		return c.RaidBuffNeeded(c.SPELL_POWER_BUFFS)
			or c.RaidBuffNeeded(c.STAMINA_BUFFS)
	end
})

c.AddOptionalSpell("Curse of the Elements", nil, {
	Debuff = c.MAGIC_VULNERABILITY_DEBUFFS,
})

c.AddOptionalSpell("Soulstone", nil, {
	NoRangeCheck = true,
	CheckFirst = function()
		return x.EnemyDetected 
			and c.SelfBuffNeeded("Soulstone") 
			and c.IsSolo(true)
	end
})

c.AddOptionalSpell("Dark Regeneration", nil, {
	CheckFirst = function(z)
		if s.HealthPercent("player") < 70 then
			z.FlashSize = nil
			return true
		end
		
		if UnitExists("pet") and s.HealthPercent("pet") < 70 then
			z.FlashSize = s.FlashSizePercent() / 2
			return true
		end
	end
})

c.AddOptionalSpell("Underwater Breath", nil, {
	Override = function()
		return IsSwimming() and c.SelfBuffNeeded("Underwater Breath")
	end
})

c.AddOptionalSpell("Life Tap", nil, {
	CheckFirst = function()
		local powerAfter = 
			100 * ((s.Power("player") + .15 * s.MaxHealth("player"))
					/ s.MaxPower("player"))
		local healthBefore = s.HealthPercent("player")
		return powerAfter < 100
			and (healthBefore - 15 > powerAfter
				or (healthBefore > 90 and s.InRaidOrParty()))
	end
})

c.AddOptionalSpell("Soulshatter", nil, {
	FlashColor = "red",
	CheckFirst = function()
		return s.InRaidOrParty() and c.IsTanking()
	end
})

c.AddOptionalSpell("Clone Magic", nil, {
	Type = "pet",
	FlashColor = "aqua",
	CheckFirst = function()
		local unit = s.UnitSelection()
		if unit == nil or not s.Enemy(unit) then
			return false
		end
		
		for i = 1, 10000 do
			local _, _, _, _, _, _, _, _, isStealable, _, spellID
				= UnitBuff(unit, i)
			if spellID == nil then
				return false
			elseif isStealable then
				return true
			end
		end
	end
})

c.AddDispel("Devour Magic", nil, "Magic", {
	Type = "pet",
})

c.AddInterrupt("Spell Lock", nil, {
	NoGCD = true,
})

c.AddInterrupt("Command Spell Lock", nil, {
	NoGCD = true,
})

c.AddInterrupt("Optical Blast", nil, {
	NoGCD = true,
})

-------------------------------------------------------------------- Affliction
local function getCorruptionWithMiseryDuration()
	if u.GetFromTable(
		a.Snapshots, 
		"Corruption", 
		UnitGUID(s.UnitSelection()), 
		"Miserable") then
		
		return getDoTDuration("Corruption")
	else
		return 0
	end
end

local function getMinUntilMisery()
	if not c.HasTalent("Archimonde's Darkness") then
		return c.GetCooldown("Dark Soul: Misery", false, 120)
	end
	
	local min
	local charges, tilNext, tilMax = c.GetChargeInfo("Dark Soul: Misery")
	if charges > 0 then
		min = 0
	else
		min = tilNext
	end
	min = math.max(min, getCorruptionWithMiseryDuration())
	return min
end

local function getMaxUntilMisery()
	if not c.HasTalent("Archimonde's Darkness") then
		return c.GetCooldown("Dark Soul: Misery", false, 120)
	end
	
	local charges, tilNext, tilMax = c.GetChargeInfo("Dark Soul: Misery")
	return tilMax
end

local function sizeForDarkSoul(z, ...)
	if a.Shards == 0 or a.DarkSoul then
		z.FlashSize = nil
		return
	end
	
	local untilMisery = getMaxUntilMisery()
	for i = 1, select("#", ...) do
		local name = select(i, ...)
		if c.GetMyDebuffDuration(name) < untilMisery then
			z.FlashSize = nil
			return
		end
	end
	z.FlashSize = s.FlashSizePercent() / 2
end

c.RegisterForFullChannels("Malefic Grasp", 4)
c.AssociateTravelTimes(.8, "Haunt")

local function burnable()
	if c.HasSpell("Pandemic") then
		return pandemicCheck("Agony")
			or pandemicCheck("Unstable Affliction")
			or pandemicCheck("Corruption")
	else
		return soonCheck("Agony")
			or soonCheck("Unstable Affliction")
			or soonCheck("Corruption")
	end
end

c.AddOptionalSpell("Dark Soul: Misery", nil, {
	NextFlashID = { 
		"Soulburn", "Soul Swap", "Soul Swap Soulburn", "Soul Swap Exhale" }, 
	Override = function(z)
		if burnable() then
			z.PredictFlashID = z.NextFlashID
		else
			z.PredictFlashID = nil
		end
		return getMinUntilMisery() == 0
			and doDarkSoul(
				z, 
				a.Shards > 0, 
				a.Shards >= 3 and c.HasMyDebuff("Haunt", false, false, true))
	end
})

c.AddSpell("Soulburn", "under Dark Soul: Misery", {
	PredictFlashID = { "Soul Swap", "Soul Swap Soulburn", "Soul Swap Exhale" }, 
	CheckFirst = function(z)
		return a.DarkSoul 
			and burnable()
			and not c.HasBuff("Soulburn", false, false, true)
	end
})

c.AddSpell("Soulburn", "during Execute", {
	PredictFlashID = { "Soul Swap", "Soul Swap Soulburn", "Soul Swap Exhale" }, 
	CheckFirst = function(z)
		if c.HasBuff("Soulburn", false, false, true) then
			return false
		end
		
		sizeForDarkSoul(z, "Agony", "Corruption", "Unstable Affliction")
		
		if gcdCheck("Agony", .3)
			or gcdCheck("Unstable Affliction")
			or gcdCheck("Corruption") then
			
			z.FlashColor = nil
			z.Continue = nil
			return true
		end
		
		if pandemicCheck("Agony", z)
			or pandemicCheck("Unstable Affliction", z)
			or pandemicCheck("Corruption", z) then
			
			if a.DarkSoul then
				z.FlashColor = nil
				z.Continue = nil
			else
				z.Continue = true
			end
			return true
		end
	end
})

c.AddSpell("Soul Swap", nil, {
	FlashID = { "Soul Swap", "Soul Swap Exhale", "Soul Swap Soulburn" },
	CheckFirst = function()
		return c.HasBuff("Soulburn", false, false, true)
			and not c.IsCasting("Soul Swap")
	end
})

c.AddOptionalSpell("Grimoire: Felhunter")

c.AddSpell("Haunt", nil, {
	CheckFirst = function(z)
		if a.Shards == 0
			or not c.ShouldCastToRefresh("Haunt", "Haunt", 0, true) then
			
			return false
		end
		
		if a.Shards >= (c.HasTalent("Archimonde's Darkness") and 4 or 3) 
			or a.DarkSoul 
			or getCorruptionWithMiseryDuration() > 6 then
			
			z.FlashColor = nil
			z.Continue = nil
			z.FlashSize = nil
			return true
		end
		
		z.Continue = true
		z.FlashColor = "yellow"
		c.MakeMini(z, getMinUntilMisery() < 35)
		return true
	end
})

c.AddSpell("Haunt", "during Execute", {
	CheckFirst = function(z)
		return a.Shards > 0
			and c.ShouldCastToRefresh("Haunt", "Haunt", 0, true)
	end
})

c.AddSpell("Agony", "within GCD", {
	CheckFirst = function(z)
		sizeForDarkSoul(z, "Unstable Affliction")
		return gcdCheck("Agony", .3)
	end
})

c.AddOptionalSpell("Agony", "with Pandemic", {
	CheckFirst = function(z)
		sizeForDarkSoul(z, "Agony")
		return pandemicCheck("Agony", z)
	end
})

c.AddSpell("Agony", "Soon", {
	CheckFirst = function(z)
		sizeForDarkSoul(z, "Agony")
		return soonCheck("Agony")
	end
})

c.AddSpell("Agony", "before Malefic Grasp", {
	CheckFirst = function(z)
		sizeForDarkSoul(z, "Agony")
		return getDoTDuration("Agony") < c.GetHastedTime(4)
	end
})

c.AddSpell("Corruption", "within GCD", {
	CheckFirst = function(z)
		sizeForDarkSoul(z, "Corruption")
		return gcdCheck("Corruption")
	end
})

c.AddOptionalSpell("Corruption", "with Pandemic", {
	CheckFirst = function(z)
		sizeForDarkSoul(z, "Corruption")
		return pandemicCheck("Corruption", z)
	end
})

c.AddSpell("Corruption", "Soon", {
	CheckFirst = function(z)
		sizeForDarkSoul(z, "Corruption")
		return soonCheck("Corruption")
	end
})

c.AddSpell("Unstable Affliction", "within GCD", {
	CheckFirst = function(z)
		sizeForDarkSoul(z, "Unstable Affliction")
		return gcdCheck(
			"Unstable Affliction", c.GetCastTime("Unstable Affliction"))
	end
})

c.AddOptionalSpell("Unstable Affliction", "with Pandemic", {
	CheckFirst = function(z)
		sizeForDarkSoul(z, "Unstable Affliction")
		local castTime = 0
		if a.Shards == 0 or not a.DarkSoul then
			castTime = c.GetCastTime("Unstable Affliction")
		end
		return pandemicCheck("Unstable Affliction", z, castTime)
	end
})

c.AddSpell("Unstable Affliction", "Soon", {
	CheckFirst = function(z)
		sizeForDarkSoul(z, "Unstable Affliction")
		return soonCheck("Unstable Affliction", a.Shards == 0 or not a.DarkSoul)
	end
})

c.AddOptionalSpell("Life Tap", "for Affliction", {
	CheckFirst = function()
		if a.DarkSoul or c.HasBuff(c.BLOODLUST_BUFFS) then
			return false
		end
		
		if s.HealthPercent() <= 20 then
			return s.PowerPercent("player") < 10
		else
			return s.PowerPercent("player") < 50
		end
	end
})

-------------------------------------------------------------------- Demonology
local function hasFuryFor(amount)
	if c.WearingSet(2, "T15") then
		amount = amount * .7
	end
	return a.Fury >= amount
end

local function getRange(normal, mannoroth)
	if c.HasBuff("Mannoroth's Fury", false, false, true) then
		return normal
	else
		return mannoroth or normal * 5
	end
end

c.AddOptionalSpell("Dark Soul: Knowledge", nil, {
	Override = function(z)
		return doDarkSoul(z, true, a.Fury > 950)
	end,
})

c.AddOptionalSpell("Grimoire: Felguard")

c.AddOptionalSpell("Aura of the Elements", nil, {
	FlashID = { "Curse of the Elements", "Aura of the Elements" },
	Range = 20, -- not affected by Mannoroth's Fury
	Debuff = c.MAGIC_VULNERABILITY_DEBUFFS,
	Override = function()
		return hasFuryFor(150) and not c.HasBuff("Aura of the Elements")
	end
})

c.AddOptionalSpell("Felstorm", nil, {
	Override = function()
		return s.SpellCooldown(c.GetID("Felstorm")) == 0
	end
})

c.AddOptionalSpell("Wrathstorm", nil, {
	Override = function()
		return s.SpellCooldown(c.GetID("Wrathstorm")) == 0
	end
})

c.AddOptionalSpell("Metamorphosis", nil, {
	Type = "form",
	CheckFirst = function()
		if a.Fury > 950 or (a.DarkSoul > 0 and a.Fury / 32 > a.DarkSoul) then
			return true
		end
		
		local needed = 0
		if c.GetMyDebuffDuration("Corruption") < 5 then
			needed = 40
		end
		if not c.HasMyDebuff("Doom") then
			if needed > 0 then
				needed = needed + 69
			else
				needed = 60
			end
		end
		return needed > 0 and hasFuryFor(needed)
	end
})

c.AddOptionalSpell("Metamorphosis", "Cancel", {
	Type = "form",
	FlashColor = "red",
	Override = function(z)
		return a.Fury < 650 and a.DarkSoul == 0
	end
})

c.AddOptionalSpell("Metamorphosis", "AoE", {
	Type = "form",
	CheckFirst = function()
		if not hasFuryFor(40) then
			return false
		end
		return a.Fury > 950 or a.DarkSoul > 0
	end
})

c.AddOptionalSpell("Metamorphosis", "Cancel AoE", {
	Type = "form",
	FlashColor = "red",
	Override = function(z)
		return a.Fury < 650
			and not c.HasBuff("Immolation Aura")
			and a.DarkSoul == 0
	end
})

c.AddSpell("Corruption", "for Demonology", {
	FlashID = { "Corruption", "Doom" },
	MyDebuff = "Corruption", 
})

c.AddOptionalSpell("Doom", nil, {
	FlashID = { "Corruption", "Doom" },
	EarlyRefresh = 15,
	Override = function(z)
		if not hasFuryFor(60) then
			return false
		end
		
		if c.GetMyDebuffDuration("Doom") < z.EarlyRefresh then
			z.FlashColor = "white"
			return true
		else
			return pandemicCheck("Doom", z)
		end
	end
})

c.AddSpell("Hand of Gul'dan", nil, {
	Applies = { "Shadowflame" },
	CheckFirst = function()
		return not c.HasMyDebuff("Shadowflame")
			and not c.IsAuraPendingFor("Hand of Gul'dan")
	end
})

c.AddSpell("Touch of Chaos", nil, {
	FlashID = { "Touch of Chaos", "Shadow Bolt", "Shadow Bolt Glyphed" },
	Override = function()
		return hasFuryFor(40)
	end
})

c.AddSpell("Touch of Chaos", "to Save Corruption", {
	FlashID = { "Touch of Chaos", "Shadow Bolt", "Shadow Bolt Glyphed" },
	Override = function()
		local duration = c.GetMyDebuffDuration("Corruption")
		return hasFuryFor(40) and duration > 0 and duration < 1.7
	end
})

c.AddSpell("Touch of Chaos", "to Extend Corruption", {
	FlashID = { "Touch of Chaos", "Shadow Bolt", "Shadow Bolt Glyphed" },
	Override = function()
		local duration = c.GetMyDebuffDuration("Corruption")
		return hasFuryFor(40) and duration > 0 and duration < 20
	end
})

c.AddSpell("Soul Fire", nil, {
	CheckFirst = function()
		local stacks = c.GetBuffStack("Molten Core")
		if c.IsCasting("Soul Fire") then
			stacks = stacks - 1
		end
		if stacks <= 0 then
			return false
		end
		
		if c.GetCastTime("Soul Fire") < a.DarkSoul then
			return true
		end
		
		if a.Morphed then
			return a.DarkSoul == 0
		else
			return c.GetCastTime("Shadow Bolt") > a.DarkSoul
		end
	end
})

c.AddSpell("Shadow Bolt", nil, {
	FlashID = { "Touch of Chaos", "Shadow Bolt", "Shadow Bolt Glyphed" },
})

c.AddSpell("Immolation Aura", nil, {
	FlashID = { "Hellfire", "Immolation Aura" },
	RunFirst = function(z)
		z.Range = getRange(10, 20)
	end,
	Override = function()
		return not c.HasBuff("Immolation Aura")
	end
})

c.AddSpell("Void Ray", nil, {
	FlashID = { "Fel Flame", "Void Ray" },
	Range = 20, -- not affected by Mannoroth's Fury
	Override = function(z)
		return hasFuryFor(40)
	end
})

c.AddSpell("Hellfire", nil, {
	FlashID = { "Hellfire", "Immolation Aura" },
	RunFirst = function(z)
		z.Range = getRange(10, 20)
	end,
})

c.AddSpell("Hellfire", "Out of Range", {
	FlashColor = "red",
	FlashID = { "Hellfire", "Immolation Aura" },
})

c.AddInterrupt("Axe Toss", nil, {
	NoGCD = true,
})

c.AddInterrupt("Super Axe Toss", nil, {
	NoGCD = true,
})

------------------------------------------------------------------- Destruction
local function getImmolateCastTime()
	local cast = c.GetCastTime("Incinerate")
	local realDraft = s.Buff(c.GetID("Backdraft"), "player")
	if a.Backdraft > 0 and not realDraft then
		return cast / 1.3
	elseif a.Backdraft == 0 and realDraft then
		return cast * 1.3
	else
		return cast
	end
end

c.AddOptionalSpell("Dark Soul: Instability", nil, {
	Override = function(z)
		return doDarkSoul(z, true, a.Embers > 3.5)
	end,
})

c.AddOptionalSpell("Grimoire: Imp")

c.AddSpell("Shadowburn", nil, {
	CheckFirst = function(z)
		if a.Embers < 1 then
			return false
		end
		
		local optional = a.Embers <= 3.5 and a.DarkSoul == 0
		c.MakeOptional(z, optional)
--		c.MakeMini(z, optional)
		return true
	end,
})

c.AddSpell("Shadowburn", "Last Resort")

c.AddSpell("Immolate", nil, {
	FlashID = { "Immolate", "Immolate AoE" },
	CheckFirst = function()
		if c.IsCastingOrInAir("Immolate") 
			or c.IsCastingOrInAir("Immolate AoE") then
			
			return false
		end
		
		return math.max(
				c.GetMyDebuffDuration("Immolate"), 
				c.GetMyDebuffDuration("Immolate AoE")) 
			< c.GetCastTime("Immolate") + getImmolateCastTime() + .1
	end
})

c.AddOptionalSpell("Immolate", "Pandemic", {
	FlashID = { "Immolate", "Immolate AoE" },
	CheckFirst = function(z)
		return pandemicCheck("Immolate", z, getImmolateCastTime())
	end
})

c.AddSpell("Conflagrate", "Single Target", {
	CheckFirst = function(z)
		if c.GetChargeInfo("Conflagrate") == 0
			or c.Flashing["Shadowburn"] 
			or c.Flashing["Chaos Bolt"] then
			
			return false
		end
		
		local optional = a.DarkSoul == 0
			and (a.Backdraft > 0 
				or (c.HasBuff("Backlash") 
					and not c.IsCasting("Incinerate", "Incinerate AoE")))
		c.MakeOptional(z, optional)
--		c.MakeMini(z, optional)
		return true
	end,
})

c.AddSpell("Conflagrate", "at Cap", {
	CheckFirst = function()
		local _, _, tilMax = c.GetChargeInfo("Conflagrate")
		return tilMax < c.GetCastTime("Incinerate")
			or c.GetBuffDuration("Backdraft", false, false, "Conflagrate")
				< c.GetCastTime("Chaos Bolt")
	end
})

c.AddSpell("Conflagrate", "AoE", {
	CheckFirst = function()
		return c.GetChargeInfo("Conflagrate") == 0
			or (a.Backdraft == 0
				and (not c.HasBuff("Backlash") 
					or c.IsCasting("Incinerate") 
					or c.IsCasting("Incinerate AoE")))
	end
})

c.AddSpell("Chaos Bolt", nil, {
	CheckFirst = function(z)
		if a.Embers < a.T15EmberCost() 
			or a.Backdraft >= 3 
			or c.Flashing["Shadowburn"] then
			
			return false
		end
		
		local optional = a.Embers <= 3.5 
			and a.DarkSoul < c.GetCastTime("Chaos Bolt")
		c.MakeOptional(z, optional)
--		c.MakeMini(z, optional)
		return true
	end
})

c.AddSpell("Chaos Bolt", "Last Resort")

c.AddSpell("Incinerate", nil, {
	FlashID = { "Incinerate", "Incinerate AoE" },
})

c.AddOptionalSpell("Ember Tap", nil, {
	CheckFirst = function()
		if c.HasGlyph("Ember Tap") then
			return s.HealthPercent("player") < 72
		else
			return s.HealthPercent("player") < 79
		end
	end
})

local function rofCheck()
	return not ((c.HasBuff("Rain of Fire") and c.HasMyDebuff("Rain of Fire"))
		or c.IsCasting("Rain of Fire")
		or GetTime() - a.RoFCast < .8)
end

c.AddOptionalSpell("Rain of Fire", nil, {
	NoRangeCheck = true,
	CheckFirst = rofCheck,
})

c.AddOptionalSpell("Rain of Fire", "Single Target", {
	NoRangeCheck = true,
	CheckFirst = function()
		return rofCheck() and c.GetPowerPercent() > 50
	end
})

c.AddOptionalSpell("Fire and Brimstone", nil, {
	Buff = "Fire and Brimstone",
	BuffUnit = "player",
	NoGCD = true,
	CheckFirst = function()
		return a.Embers >= 1
	end
})

c.AddOptionalSpell("Fire and Brimstone", "Cancel", {
	FlashColor = "red",
	NoGCD = true,
	Override = function()
		return a.Embers >= 1 and c.HasBuff("Fire and Brimstone")
	end
})
