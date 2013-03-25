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

local function expiresWithin(name, time)
	if name == "Immolate" and c.GetMyDebuffDuration("Immolate AoE") > time then
		return false
	end
	
	return not c.IsCastingOrInAir(name) 
		and not c.IsQueued("Soul Swap") 
		and not (name == "Corruption" and a.SoCExplosionPending)
		and c.GetMyDebuffDuration(name) < time
end

local function gcdCheck(name, padding)
	local time = math.max(1, c.GetHastedTime(1.5))
	if padding ~= nil then
		time = time + padding
	end
	return expiresWithin(name, time)
end

local function soonCheck(name, considerCastTime)
	local time = u.GetFromTable(
		a.Snapshots, name, UnitGUID(s.UnitSelection()), "Tick")
	if time == nil then
		return false -- this is UA, and it is casting
	end
	
	if s.HasSpell(c.GetID("Pandemic")) then
		time = 2 * time
	end
	if considerCastTime then
		time = time + c.GetCastTime(name)
	end
	return expiresWithin(name, time)
end

local function pandemicCheck(name, z, castTime)
	if not s.HasSpell(c.GetID("Pandemic")) then
		return false
	end
	
	local time = baseLengths[name] / 2 - 1
	if castTime then
		time = time + castTime
	end
	if not expiresWithin(name, time) then
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
		return c.SelfBuffNeeded("Soulstone") and c.IsSolo(true)
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
local function sizeForDarkSoul(z, ...)
	if a.Shards == 0 then
		z.FlashSize = nil
		return
	end
	
	for i = 1, select("#", ...) do
		local name = select(i, ...)
		if c.GetMyDebuffDuration(name) < c.GetCooldown("Dark Soul: Misery") 
			or c.HasBuff("Dark Soul: Misery") then
			
			z.FlashSize = nil
			return
		end
	end
	z.FlashSize = s.FlashSizePercent() / 2
end

c.RegisterForFullChannels("Malefic Grasp", 4)
c.AssociateTravelTimes(.8, "Haunt")

c.AddSpell("Soulburn", "under Dark Soul: Misery", {
	CheckFirst = function()
		if not c.HasBuff("Dark Soul: Misery") 
			or c.HasBuff("Soulburn") 
			or c.IsCasting("Soulburn") then
			
			return false
		elseif s.HasSpell(c.GetID("Pandemic")) then
			return pandemicCheck("Agony")
				or pandemicCheck("Unstable Affliction")
				or pandemicCheck("Corruption")
		else
			return soonCheck("Agony")
				or soonCheck("Unstable Affliction")
				or soonCheck("Corruption")
		end
	end
})

c.AddSpell("Soulburn", "during Execute", {
	CheckFirst = function(z)
		if c.HasBuff("Soulburn") or c.IsCasting("Soulburn") then
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
			
			if c.HasBuff("Dark Soul: Misery") then
				z.FlashColor = nil
				z.Continue = nil
			else
				z.Continue = true
			end
			return true
		end
	end
})

c.AddSpell("Soul Swap", "under Soulburn", {
	CheckFirst = function()
		return c.HasBuff("Soulburn")
	end
})

c.AddSpell("Soul Swap", "during Execute", {
	CheckFirst = function()
		return c.HasBuff("Soulburn")
	end
})

c.AddOptionalSpell("Dark Soul: Misery", nil, {
	Override = function()
		return a.Shards > 0 and c.GetCooldown("Dark Soul: Misery") == 0
	end
})

c.AddOptionalSpell("Grimoire: Felhunter")

c.AddSpell("Haunt", nil, {
	CheckFirst = function(z)
		if a.Shards == 0
			or not c.ShouldCastToRefresh("Haunt", "Haunt", 0, true) then
			
			return false
		end
		
		if a.Shards >= s.MaxPower("player", SPELL_POWER_SOUL_SHARDS) - 1 
			or c.HasBuff("Dark Soul: Misery") then
			
			z.FlashColor = nil
			z.Continue = nil
			z.FlashSize = nil
			return true
		end
		
		z.Continue = true
		z.FlashColor = "yellow"
		local miseryCD = c.GetCooldown("Dark Soul: Misery")
		if miseryCD < 35 then
			z.FlashSize = s.FlashSizePercent() / 2
		else
			z.FlashSize = nil
		end
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
		return expiresWithin("Agony", c.GetHastedTime(4))
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
		if a.Shards == 0 or not c.HasBuff("Dark Soul: Misery") then
			castTime = c.GetCastTime("Unstable Affliction")
		end
		return pandemicCheck("Unstable Affliction", z, castTime)
	end
})

c.AddSpell("Unstable Affliction", "Soon", {
	CheckFirst = function(z)
		sizeForDarkSoul(z, "Unstable Affliction")
		return soonCheck(
			"Unstable Affliction", 
			a.Shards == 0 or not c.HasBuff("Dark Soul: Misery"))
	end
})

c.AddOptionalSpell("Life Tap", "for Affliction", {
	CheckFirst = function()
		if c.HasBuff("Dark Soul: Misery") or c.HasBuff(c.BLOODLUST_BUFFS) then
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
c.AddOptionalSpell("Dark Soul: Knowledge")

c.AddOptionalSpell("Grimoire: Felguard")

c.AddOptionalSpell("Aura of the Elements", nil, {
	FlashID = { "Curse of the Elements", "Aura of the Elements" },
	Override = function()
		return a.Fury >= 150 
			and not c.HasDebuff(c.MAGIC_VULNERABILITY_DEBUFFS)
			and not c.HasBuff("Aura of the Elements")
			and c.DistanceAtTheMost() <= 20
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
		local ds = c.GetBuffDuration("Dark Soul: Knowledge")
		if a.Fury > 950 or (ds > 0 and a.Fury / 32 > ds) then
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
		return needed > 0 and a.Fury >= needed
	end
})

c.AddOptionalSpell("Metamorphosis", "Cancel", {
	Type = "form",
	FlashColor = "red",
	Override = function(z)
		return a.Fury < 650 and not c.HasBuff("Dark Soul: Knowledge")
	end
})

c.AddOptionalSpell("Metamorphosis", "AoE", {
	Type = "form",
	CheckFirst = function()
		if a.Fury < 40 then
			return false
		end
		return a.Fury > 950
			or c.HasBuff("Dark Soul: Knowledge")
			or c.GetMyDebuffDuration("Corruption") < 10
	end
})

c.AddOptionalSpell("Metamorphosis", "Cancel AoE", {
	Type = "form",
	FlashColor = "red",
	Override = function(z)
		return a.Fury < 650
			and not c.HasBuff("Immolation Aura")
			and c.GetMyDebuffDuration("Corruption") > 10
			and not c.HasBuff("Dark Soul: Knowledge")
	end
})

c.AddSpell("Corruption", "for Demonology", {
	FlashID = { "Corruption", "Doom" },
	CheckFirst = function()
		return not c.HasMyDebuff("Corruption")
	end
})

c.AddOptionalSpell("Doom", nil, {
	FlashID = { "Corruption", "Doom" },
	EarlyRefresh = 15,
	Override = function(z)
		if a.Fury < 60 then
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
		return a.Fury >= 40
	end
})

c.AddSpell("Touch of Chaos", "to Save Corruption", {
	FlashID = { "Touch of Chaos", "Shadow Bolt", "Shadow Bolt Glyphed" },
	Override = function()
		local duration = c.GetMyDebuffDuration("Corruption")
		return a.Fury >= 40 and duration > 0 and duration < 1.7
	end
})

c.AddSpell("Touch of Chaos", "to Extend Corruption", {
	FlashID = { "Touch of Chaos", "Shadow Bolt", "Shadow Bolt Glyphed" },
	Override = function()
		local duration = c.GetMyDebuffDuration("Corruption")
		return a.Fury >= 40 and duration > 0 and duration < 20
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
		
		local ds = c.GetBuffDuration("Dark Soul: Knowledge")
		if c.GetCastTime("Soul Fire") < ds then
			return true
		end
		
		if a.Morphed then
			return ds == 0
		else
			return c.GetCastTime("Shadow Bolt") > ds
		end
	end
})

c.AddSpell("Shadow Bolt", nil, {
	FlashID = { "Touch of Chaos", "Shadow Bolt", "Shadow Bolt Glyphed" },
})

c.AddSpell("Immolation Aura", nil, {
	FlashID = { "Hellfire", "Immolation Aura" },
	Override = function()
		return not c.HasBuff("Immolation Aura")
			and c.DistanceAtTheMost() <= 10
	end
})

c.AddSpell("Void Ray", nil, {
	FlashID = { "Fel Flame", "Void Ray" },
	Override = function()
		return a.Fury >= 40
			and c.DistanceAtTheMost() <= 20
	end
})

c.AddSpell("Void Ray", "for Corruption", {
	FlashID = { "Fel Flame", "Void Ray" },
	Override = function()
		local corr = c.GetMyDebuffDuration("Corruption")
		return a.Fury >= 40
			and corr > 0
			and corr < 10
			and c.DistanceAtTheMost() <= 20
	end
})

c.AddSpell("Hellfire", nil, {
	FlashID = { "Hellfire", "Immolation Aura" },
	CheckFirst = function()
		return c.DistanceAtTheMost() <= 10
	end
})

c.AddSpell("Hellfire", "Out of Range", {
	FlashColor = "red",
	FlashID = { "Hellfire", "Immolation Aura" },
})

c.AddSpell("Harvest Life", "for Demonology", {
	CheckFirst = function()
		return true
			and c.DistanceAtTheLeast() >= 10
	end
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

c.AddOptionalSpell("Dark Soul: Instability")

c.AddOptionalSpell("Grimoire: Imp")

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

c.AddSpell("Chaos Bolt", nil, {
	CheckFirst = function()
		return a.Backdraft < 3
			and (c.GetPower(select(2, GetPowerRegen())) / s.MaxPower("player") 
					< .8
				or not s.InRaidOrParty())
			and (s.MaxPower("player", SPELL_POWER_BURNING_EMBERS) - a.Embers 
					< .5
				or c.GetBuffDuration("Dark Soul: Instability") 
					> c.GetCastTime("Chaos Bolt"))
	end
})

c.AddSpell("Conflagrate", nil, {
	CheckFirst = function()
		return a.Backdraft == 0
			and (not c.HasBuff("Backlash") 
				or c.IsCasting("Incinerate") 
				or c.IsCasting("Incinerate AoE"))
	end
})

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

c.AddOptionalSpell("Rain of Fire", nil, {
	CheckFirst = function()
		return not c.HasBuff("Rain of Fire") 
			or not c.HasMyDebuff("Rain of Fire")
	end
})

c.AddOptionalSpell("Rain of Fire", "above 50", {
	MyDebuff = "Rain of Fire",
	CheckFirst = function()
		return s.PowerPercent("player") > 50
			and (not c.HasBuff("Rain of Fire") 
				or not c.HasMyDebuff("Rain of Fire"))
	end
})
