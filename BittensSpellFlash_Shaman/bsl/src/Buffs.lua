local g = BittensGlobalTables
local c = g.GetTable("BittensSpellFlashLibrary")
local u = g.GetTable("BittensUtilities")
if u.SkipOrUpgrade(c, "Buffs", 9) then
	return
end

local s = SpellFlashAddon

local math = math
local pairs = pairs
local select = select
local type = type

c.STAT_BUFFS = {
	1126, -- Mark of the Wild
	115921, -- Legacy of the Emperor
	20217, -- Blessing of Kings
	90363, -- Embrace of the Shale Spider
}

c.STAMINA_BUFFS = {
	21562, -- Power Word: Fortitude
	109773, -- Dark Intent
	469, -- Commanding Shout
	90364, -- Qiraji Fortitude
}

c.ATTACK_POWER_BUFFS = {
	57330, -- Horn of Winter
	19506, -- Trueshot Arua
	6673, -- Battle Shout
}

c.SPELL_POWER_BUFFS = {
	1459, -- Arcane Brilliance
	61316, -- Dalaran Brialliance
	77747, -- Burning Wrath
	109773, -- Dark Intent
	126309, -- Still Water
}

c.MELEE_HASTE_BUFFS = {
	55610, -- Unholy Aura
	113742, -- Swiftblade's Cunning
	30809, -- Unleashed Rage
	128432, -- Cackling Howl
	128433, -- Serpent's Swiftness
}

c.SPELL_HASTE_BUFFS = {
	24907, -- Moonkin Aura
	15473, -- Shadowform
	49868, -- Mind Quickening (applied to raid members by Shadowform)
	51470, -- Elemental Oath
	135678, -- Energizing Spores
}

c.CRIT_BUFFS = {
	17007, -- Leader of the Pack
	1459, -- Arcane Brilliance
	61316, -- Dalaran Brialliance
	116781, -- Legacy of the White Tiger
	97229, -- Bellowing Roar
	24604, -- Furious Howl
	90309, -- Terrifying Roar
	126373, -- Fearless Roar
	126309, -- Still Water
}

c.MASTERY_BUFFS = {
	19740, -- Blessing of Might
	116956, -- Grace of Air
	93435, -- Roar of Courage
	128997, -- Spirit Beast Blessing
}

c.BLOODLUST_BUFFS = {
    90355, -- Ancient Hysteria
    80353, -- Time Warp
    2825, -- Bloodlust
    32182, -- Heroism
}

c.ARMOR_DEBUFFS = 113746

c.PHYSICAL_VULNERABILITY_DEBUFFS = 81326

c.MAGIC_VULNERABILITY_DEBUFFS = {
	58410, -- Master Poisoner
	1490, -- Curse of the Elements
	34889, -- Fire Breath
	24844, -- Lightning Breath
	116202, -- Aura of the Elements
}

c.WEAKENED_BLOWS_DEBUFFS = 115798

c.SLOW_CASTING_DEBUFFS = {
	73975, -- Necrotic Strike
	31589, -- Slow
	5761, -- Mind-numbing Poison
	109466, -- Curse of Enfeeblement
	50274, -- Spore Cloud
	90314, -- Tailspin
	126402, -- Trample
	58604, -- Lava Breath
}

c.MORTAL_WOUNDS_DEBUFFS = 115804

c.COMMON_TANKING_BUFFS = {
	
	-- from DKs
	50461, -- Anti-Magic Zone
	
	-- from Druids
	102342, -- Ironbark
	
	-- from Hunters
	53480, -- Roar of Sacrifice
	
	-- from Monks
	115213, -- Avert Harm (both caster and raid members)
	116844, -- Ring of Peace
	115176, -- Zen Meditation (on raid members)
	131523, -- Zen Meditation (on caster)
	
	-- from Paladins
	1022, -- Hand of Protection
	6940, -- Hand of Sacrifice
	31821, -- Devotion Aura
	114039, -- Hand of Purity
	
	-- from Priests
	33206, -- Pain Suppression
	81782, -- Power Word: Barrier
	47788, -- Guardian Spirit
	
	-- from Rogues
	76577, -- Smoke Bomb
	
	-- from Shamans
	8178, -- Grounding Totem Effect
	
	-- from Warriors
	114028, -- Mass Spell Reflection
	46947, -- Safeguard
	114030, -- Vigilance
	--114203, -- Demoralizing Banner
	
	-- from Items
	116660, -- River's Song (buff from the weapon enchant)
	105698, -- Potion of the Mountains
	137593, -- Fortitude (proc from Indomitable Primal Diamond)
}

local function getScore(buff)
	return (type(buff) == "string"
			and c.A.Spells[buff]
			and c.A.Spells[buff].Score)
		or 1
end

local function isUp(buff)
	if type(buff) ~= "string" then
		return c.HasBuff(buff, false, true)
	end
	
	local spell = c.A.Spells[buff]
	if spell == nil then
		return c.HasBuff(buff, false, true)
	end
	
	if spell.RunFirst ~= nil then
		spell:RunFirst()
	end
	
	if spell.Enabled and not spell:Enabled() then
		return false
	end
	
	if spell.IsUp then
		return spell:IsUp()
	end
	
	buff = spell.Buff or spell.ID
	return s.Buff(
		buff, 
		"player", 
		c.GetBusyTime(spell.NoGCD), 
		nil, 
		nil, 
		spell.UseBuffID)
end

local function getCurrentScore(buff)
	if type(buff) == "table" then
		local score = 0
		for _, buff in pairs(buff) do
			score = score + getCurrentScore(buff)
		end
		return score
	end
	
--c.Debug("getCurrentScore", buff, isUp(buff))
	return isUp(buff) and getScore(buff) or 0
end

function c.FlashMitigationBuffs(targetScore, ...)
	if not c.IsTanking() and not s.Dummy() then
		return
	end
	
	for i = 1, select("#", ...) do
		targetScore = targetScore - getCurrentScore(select(i, ...))
	end
	for i = 1, select("#", ...) do
		if targetScore <= 0 then
			return
		end
		
		-- test castable before flashable, in case it changes the id
		local name = select(i, ...)
		local spell = c.A.Spells[name]
		if spell 
			and (spell.Enabled == nil or spell:Enabled()) 
			and s.Castable(spell) then
			
			local flashable = s.Flashable
			local flash = s.Flash
			if spell.Type == "item" then
				flashable = s.ItemFlashable
				flash = s.FlashItem
			end
			if flashable(spell.ID) then
				local color = spell.FlashColor
				local size = spell.FlashSize
				if spell.ShouldHold ~= nil and spell:ShouldHold() then
					color = "green"
					size = s.FlashSizePercent() / 3
				end
				flash(spell.FlashID or spell.ID, color, size)
				targetScore = targetScore - (spell.Score or 1)
			end
		end
	end
end

local function isApplied(name, ...)
	for i = 1, select("#", ...) do
		local applied = select(i, ...)
		if applied == true then
			applied = name
		end
		if c.IsAuraPendingFor(applied) then
			return true
		end
	end
end

local function getAppliedDuration(name, ...)
	return isApplied(name, ...) and 9001
end

local function hasAura(
	name, noGCD, matchSpellID, checkFunction, durationFunction, target, ...)
	
	local id = c.GetID(name)
	if isApplied(name, ...) then
		return true
	end
	
	local duration = durationFunction(id, target, nil, nil, nil, matchSpellID)
	if duration == 0 then
		-- duration == 0 for permanent buffs
		return checkFunction(id, target, nil, nil, nil, matchSpellID)
	else
		return duration > c.GetBusyTime(noGCD)
	end
end

function c.HasBuff(name, noGCD, matchSpellID, ...)
	return hasAura(
		name, noGCD, matchSpellID, s.Buff, s.BuffDuration, "player", ...)
end

function c.GetBuffDuration(name, noGCD, matchSpellID, ...)
	return getAppliedDuration(name, ...)
		or math.max(
			0, 
			s.BuffDuration(c.GetID(name), "player", nil, nil, nil, matchSpellID)
				- c.GetBusyTime(noGCD))
end

function c.GetBuffStack(name, noGCD, matchSpellID)
	local id = c.GetID(name)
	if c.HasBuff(id, noGCD, matchSpellID) then -- ensure won't to expire
		return s.BuffStack(id, "player", nil, nil, nil, matchSpellID)
	else
		return 0
	end
end

function c.HasMyBuff(name, noGCD, matchSpellID, ...)
	return hasAura(
		name, 
		noGCD, 
		matchSpellID, 
		s.MyBuff, 
		s.MyBuffDuration, 
		"player", 
		...)
end

function c.GetMyBuffDuration(name, noGCD, matchSpellID, ...)
	return getAppliedDuration(name, ...)
		or math.max(
			0, 
			s.MyBuffDuration(
					c.GetID(name), "player", nil, nil, nil, matchSpellID)
				- c.GetBusyTime(noGCD))
end

function c.GetMyBuffStack(name, noGCD, matchSpellID)
	local id = c.GetID(name)
	if c.HasMyBuff(id, noGCD, matchSpellID) then -- ensure won't to expire
		return s.MyBuffStack(id, "player", nil, nil, nil, matchSpellID)
	else
		return 0
	end
end

function c.HasMyDebuff(name, noGCD, matchSpellID, ...)
	return hasAura(
		name, noGCD, matchSpellID, s.MyDebuff, s.MyDebuffDuration, nil, ...)
end

function c.GetMyDebuffStack(name, noGCD, matchSpellID)
	if c.HasMyDebuff(name, noGCD, matchSpellID) then -- ensure it won't expire
		return s.MyDebuffStack(c.GetID(name), nil, nil, nil, nil, matchSpellID)
	else
		return 0
	end
end

function c.GetMyDebuffDuration(name, noGCD, matchSpellID, ...)
	return getAppliedDuration(name, ...)
		or math.max(
			0, 
			s.MyDebuffDuration(c.GetID(name), nil, nil, nil, nil, matchSpellID) 
				- c.GetBusyTime(noGCD))
end

function c.HasDebuff(name, noGCD, matchSpellID, ...)
	return hasAura(
		name, noGCD, matchSpellID, s.Debuff, s.DebuffDuration, nil, ...)
end

function c.GetDebuffStack(name, noGCD, matchSpellID)
	if c.HasDebuff(name, noGCD, matchSpellID) then -- ensure it won't expire
		return s.DebuffStack(c.GetID(name), nil, nil, nil, nil, matchSpellID)
	else
		return 0
	end
end

function c.GetDebuffDuration(name, noGCD, matchSpellID, ...)
	return getAppliedDuration(name, ...)
		or math.max(
			0, 
			s.DebuffDuration(c.GetID(name), nil, nil, nil, nil, matchSpellID) 
				- c.GetBusyTime(noGCD))
end

function c.SelfBuffNeeded(name)
	if s.InCombat() then
		return not c.HasBuff(name)
	else
		local min = s.InRaidOrParty() and 5 or 2
		return c.GetBuffDuration(name) < min * 60
	end
end

function c.RaidBuffNeeded(idTable)
	local duration = 0
	if not s.InCombat() then
		duration = s.InRaidOrParty() and 5 or 2
	end
	local flags = "raid|all|range"
	if idTable == c.SPELL_HASTE_BUFFS
		or idTable == c.SPELL_POWER_BUFFS then
		
		flags = flags .. "|mana"
	end
	return not s.Buff(idTable, flags, duration * 60)
end
