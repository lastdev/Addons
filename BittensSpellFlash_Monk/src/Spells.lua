local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetSpellCharges = GetSpellCharges
local GetTime = GetTime
local IsMounted = IsMounted
local SPELL_POWER_CHI = SPELL_POWER_CHI
local math = math
local select = select
local string = string

local spellCosts = {}

local function setCost(name, energy, chi)
	spellCosts[s.SpellName(c.GetID(name))] = { Energy = energy, Chi = chi }
end

function a.GetEnergyCost(localName)
	return spellCosts[localName] and spellCosts[localName].Energy
end

function a.GetChiCost(localName)
	return spellCosts[localName] and spellCosts[localName].Chi
end

setCost("Jab", 40, -1)
setCost("Expel Harm", 40, -1)
setCost("Keg Smash", 40, -2)
setCost("Blackout Kick", 0, 2)
setCost("Tiger Palm", 0, 1)
setCost("Rising Sun Kick", 0, 2)
setCost("Fists of Fury", 0, 3)
setCost("Spinning Crane Kick", 40, -1)
setCost("Breath of Fire", 0, 2)
setCost("Touch of Death", 0, 3)
setCost("Guard", 0, 2)
setCost("Purifying Brew", 0, 1)
setCost("Enveloping Mist", 0, 3)
setCost("Surging Mist", 0, -1)
setCost("Renewing Mist", 0, -1)
setCost("Uplift", 0, 2)

------------------------------------------------------------------------ Common
local function modSpell(spell)
	spell.NoStopChannel = true
	
	local cost = spellCosts[s.SpellName(spell.ID)]
	if cost then
		spell.EvenIfNotUsable = true
		spell.NoPowerCheck = true
		spell.NoStopChannel = true
		spell.CheckLast = function()
--c.Debug("CheckLast", s.SpellName(spell.ID), a.Power, cost.Energy, a.Chi, cost.Chi)
			return a.Power >= cost.Energy and a.Chi >= cost.Chi
		end
	end
end

local function addSpell(name, tag, attributes)
	modSpell(c.AddSpell(name, tag, attributes))
end

local function addOptionalSpell(name, tag, attributes)
	modSpell(c.AddOptionalSpell(name, tag, attributes))
end

c.RegisterForFullChannels("Spinning Crane Kick", 2)

addOptionalSpell("Roll", nil, {
	FlashSize = s.FlashSizePercent() / 2,
	CheckFirst = function(z)
		if IsMounted() or not s.Moving("player") then
			return false
		end
		
		if not c.HasTalent("Momentum") then
			return true
		end
		
		local duration = c.GetBuffDuration("Momentum")
		if duration > 0 then
			return duration < 1
		end
		
		local charges, _, start, duration = GetSpellCharges(c.GetID("Roll"))
		if start + duration - GetTime() < 9 then
			charges = charges + 1
		end
		return charges >= 2
	end
})

addOptionalSpell("Legacy of the Emperor", nil, {
	NoRangeCheck = 1,
	CheckFirst = function()
		return c.RaidBuffNeeded(c.STAT_BUFFS)
	end
})

addOptionalSpell("Touch of Death", nil, {
	CheckFirst = function()
		return s.Health() < s.MaxHealth("player")
	end
})

addOptionalSpell("Expel Harm", nil, {
	CheckFirst = function()
		return s.HealthPercent("player") < 80
	end
})

addOptionalSpell("Chi Brew", nil, {
	CheckFirst = function()
		return a.Chi == 0
	end
})

addOptionalSpell("Rushing Jade Wind")

addOptionalSpell("Invoke Xuen, the White Tiger")

addSpell("Spinning Crane Kick", nil, {
	Override = function()
		return a.Power >= 40 and s.MeleeDistance()
	end
})

c.AddInterrupt("Spear Hand Strike")

-------------------------------------------------------------------- Brewmaster
local function canUseAndStillShuffle(chi)
	if not s.HasSpell(c.GetID("Brewmaster Training")) then
		return true
	end
	
	local timeToNextShuffle = c.GetBuffDuration("Shuffle")
	if timeToNextShuffle < 1 then
		return false
	end
	
	local chiByNextShuffle = a.Chi - chi + math.min(
		timeToNextShuffle - 1, 
		(a.Power + timeToNextShuffle * a.Regen) / 40)
	return chiByNextShuffle >= 2
end

c.AddOptionalSpell("Summon Black Ox Statue", nil, {
	NoRangeCheck = true,
	CheckFirst = function()
		return c.IsMissingTotem(1) and not c.IsSolo()
	end
})

addOptionalSpell("Dampen Harm")

addOptionalSpell("Fortifying Brew", nil, {
	NoGCD = true,
	ShouldHold = function()
		if c.HasGlyph("Fortifying Brew") then
			return s.HealthPercent("player") > 90
		else
			return s.HealthPercent("player") > 80
		end
	end
})

addOptionalSpell("Elusive Brew", nil, {
	NoGCD = true,
	IsUp = function()
		return c.HasBuff("Elusive Brew", true, true)
	end,
	ShouldHold = function()
		return c.HasBuff("Healing Elixirs") and s.HealthPercent("player") > 85
	end,
})

addOptionalSpell("Elusive Brew", "at 10", {
	NoGCD = true,
	IsUp = function()
		return false -- already reported "up" by the non-"at 10" version above
	end,
	CheckFirst = function()
		return c.GetBuffStack("Elusive Brew Stacker", true, true) >= 10
	end,
	ShouldHold = function()
		return c.HasBuff("Healing Elixirs") and s.HealthPercent("player") > 85
	end,
})

addOptionalSpell("Guard", nil, {
	NoGCD = true,
	CheckFirst = function()
		return a.Chi >= 4 -- leave enough Chi for Blackout Kick
			and (c.HasBuff("Power Guard")
				or not s.HasSpell(c.GetID("Brewmaster Training")))
	end
})

addOptionalSpell("Purifying Brew", nil, {
	NoGCD = true,
	CheckFirst = function()
		if c.HasBuff("Healing Elixirs") and s.HealthPercent("player") > 85 then
			return false
		end
		return s.Debuff(c.GetID("Moderate Stagger"), "player")
			or s.Debuff(c.GetID("Heavy Stagger"), "player")
			or (s.Debuff(c.GetID("Light Stagger"), "player") and a.Chi > 2)
	end	
})

c.AddOptionalSpell("Stance of the Sturdy Ox", nil, {
	Type = "form",
})

addSpell("Blackout Kick", "for Shuffle", {
	Applies = { "Shuffle" },
	CheckFirst = function(z)
		return c.GetBuffDuration("Shuffle") < 2
			and not c.IsAuraPendingFor("Blackout Kick")
			and s.HasSpell(c.GetID("Brewmaster Training"))
	end
})

addSpell("Keg Smash", nil, {
	Melee = true,
})

addSpell("Keg Smash", "for Dizzying Haze", {
	Melee = true,
	CheckFirst = function()
		return not s.Debuff(c.GetID("Dizzying Haze"), nil, 2 + c.GetBusyTime())
			and not c.IsAuraPendingFor("Keg Smash")
	end
})

addSpell("Keg Smash", "for Chi", {
	Melee = true,
	CheckFirst = function()
		if s.MaxPower("player") - a.Power < a.Regen then
			return true -- we will cap within 1 second
		end
		
		if a.MissingChi < 2 then
			return false -- don't waste chi
		end
		
		-- gen chi unless we can wait and get better use out of expel harm
		return a.Power 
			>= math.max(0, 40 - c.GetCooldown("Expel Harm") * a.Regen)
	end
})

addSpell("Jab", "for Brewmaster", {
	CheckFirst = function()
		if s.MaxPower("player") - a.Power < a.Regen then
			return true -- we will cap within 1 second
		end
		
		if a.MissingChi == 0 then
			return false -- don't waste chi
		end
		
		-- gen unless we can wait and get better use out of expel harm/keg smash
		return a.Power - 40 
			>= math.max(0, 40 - c.GetCooldown("Keg Smash") * a.Regen)
				+ math.max(0, 40 - c.GetCooldown("Expel Harm") * a.Regen)
	end
})

addSpell("Expel Harm", "for Brewmaster", {
	CheckFirst = function()
		return s.HealthPercent("player") < 90
	end
})

c.AddSpell("Tiger Palm", "for Brewmaster", {
	Override = function()
		return s.MeleeDistance()
			and s.HasSpell(c.GetID("Brewmaster Training"))
	end
})

addSpell("Chi Wave", "for Brewmaster", {
	CheckFirst = function()
		return s.HealthPercent("player") < 90
	end
})

addSpell("Zen Sphere", "for Brewmaster", {
	NoRangeCheck = true,
	CheckFirst = function()
		return (not c.HasBuff("Zen Sphere") or s.HealthPercent("player") < 90)
			and not c.IsCasting("Zen Sphere")
	end
})

addSpell("Chi Burst", "for Brewmaster", {
	CheckFirst = function()
		return s.HealthPercent("player") < 90
	end
})

addSpell("Rushing Jade Wind", "for Brewmaster")

c.AddTaunt("Provoke", nil, { NoGCD = true })

-------------------------------------------------------------------- Mistweaver
c.AddOptionalSpell("Stance of the Wise Serpent", nil, {
	Type = "form",
})

c.AddOptionalSpell("Summon Jade Serpent Statue", nil, {
	NoRangeCheck = true,
	CheckFirst = function()
		return c.IsMissingTotem(1) and not c.IsSolo()
	end
})

c.AddOptionalSpell("Mana Tea", nil, {
	Override = function(z)
		local stack = c.GetBuffStack("Mana Tea")
		if c.HasGlyph("Mana Tea") then
			z.FlashColor = "yellow"
			return stack >= 2 
				and s.PowerPercent("player") < 92
				and c.GetCooldown("Mana Tea") == 0
		end
		
		if s.PowerPercent("player") > 86 then
			if c.IsCasting("Mana Tea") then
				z.FlashColor = "red"
				return true
			else
				z.FlashColor = "yellow"
				return false
			end
		end
		
		z.FlashColor = nil
		local dur = c.GetBuffDuration("Mana Tea")
		return dur > 0 and (dur < 10 or stack == 20)
	end
})

c.AddOptionalSpell("Surging Mist", nil, {
	Override = function()
		return a.SoothDamage > 50
			or (a.MissingChi > 0 and c.GetBuffStack("Vital Mists") == 5)
	end
})

c.AddOptionalSpell("Enveloping Mist", nil, {
	Override = function(z)
		return a.Chi >= 3 
			and a.SoothDamage > 30 
			and not s.MyBuff(
				c.GetID("Enveloping Mist"), a.SoothTarget, c.GetBusyTime()) 
	end
})

c.AddOptionalSpell("Uplift", nil, {
	Override = function()
		if a.Chi < 2 and not c.HasGlyph("Uplift") then
			return false
		end
		
		local mistId = c.GetID("Renewing Mist")
		local busy = c.GetBusyTime()
		local damage = 0
		for member in c.GetGroupMembers() do
			if s.MyBuff(mistId, member, busy) then
				damage = damage + math.min(15, s.HealthDamagePercent(member))
			end
		end
		return damage > 60
	end
})

c.AddOptionalSpell("Touch of Death", "for Mistweaver", {
	FlashSize = s.FlashSizePercent() / 2,
	Override = function()
		return a.Chi >= 3
			and s.Health() < s.MaxHealth("player")
			and s.MeleeDistance()
	end
})

c.AddSpell("Blackout Kick", "for Serpent's Zeal", {
	FlashSize = s.FlashSizePercent() / 2,
	Override = function()
		return (a.MissingChi == 0 
				or (a.Chi >= 2 and c.HasBuff("Muscle Memory")))
			and not c.HasBuff("Serpent's Zeal")
			and not c.IsCasting("Blackout Kick")
			and s.MeleeDistance()
	end
})

c.AddSpell("Tiger Palm", "for Mistweaver", {
	FlashSize = s.FlashSizePercent() / 2,
	Override = function()
		return (a.MissingChi == 0 
				or (a.Chi >= 1 
					and c.HasBuff("Muscle Memory") 
					and c.HasBuff("Serpent's Zeal")))
			and s.MeleeDistance()
	end
})

c.AddSpell("Expel Harm", "for Mistweaver", {
	FlashSize = s.FlashSizePercent() / 2,
	Override = function()
		return s.HealthPercent("player") < 80 
			and s.MeleeDistance()
			and c.GetCooldown("Expel Harm") == 0
	end
})

c.AddSpell("Jab", "for Mistweaver", {
	FlashSize = s.FlashSizePercent() / 2,
})

c.AddSpell("Crackling Jade Lightning", nil, {
	FlashSize = s.FlashSizePercent() / 2,
})

-------------------------------------------------------------------- Windwalker
c.AddOptionalSpell("Stance of the Fierce Tiger", nil, {
	Type = "form",
})

c.AddOptionalSpell("Legacy of the White Tiger", nil, {
	NoRangeCheck = 1,
	CheckFirst = function()
		return c.RaidBuffNeeded(c.CRIT_BUFFS)
	end
})

addOptionalSpell("Energizing Brew", nil, {
	CheckFirst = function()
		return (s.MaxPower("player") - a.Power) / a.Regen > 5
	end
})

addOptionalSpell("Tigereye Brew", nil, {
	CheckFirst = function()
		local isUp = c.HasBuff("Tigereye Brew", false, true)
		if isUp and a.BrewIsBuffed then
			return false
		end
		
		if c.GetBuffStack("Tigereye Brew Stacker", false, true) >= 20 then
			return true
		end
		
		local normalTime = a.Chi >= 2
			and c.GetCooldown("Rising Sun Kick") == 0
			and not isUp
			and c.HasBuff("Tiger Power")
			and c.HasMyDebuff("Rising Sun Kick")
		
		local syncBuff = c.GetOption("TigerSyncBuff")
		if string.len(syncBuff) == 0 then
			return normalTime
		end
		
		local syncDur = math.max(
			0, s.BuffDuration(syncBuff, "player") - c.GetBusyTime())
		return syncDur > 0 and (normalTime or syncDur < 2)
	end
})

addSpell("Rising Sun Kick")

addSpell("Rising Sun Kick", "for Debuff", {
	CheckFirst = function()
		return not c.HasMyDebuff("Rising Sun Kick")
			and not c.IsAuraPendingFor("Rising Sun Kick")
	end
})

addSpell("Tiger Palm", "for Tiger Power", {
	CheckFirst = function()
		return not c.HasBuff("Tiger Power")
			and (not s.HasSpell("Rising Sun Kick") 
				or c.HasMyDebuff("Rising Sun Kick"))
			and a.Power + a.Regen <= s.MaxPower("player")
			and not c.IsCasting("Tiger Palm")
	end
})

addSpell("Tiger Palm", "under Combo Breaker", {
	CheckFirst = function()
		return c.HasBuff("Combo Breaker: Tiger Palm")
			and not c.IsCasting("Tiger Palm")
	end
})

addSpell("Fists of Fury", nil, {
	Melee = true,
	NoRangeCheck = true,
	NotWhileMoving = true,
	CheckFirst = function(z)
		if c.GetCooldown("Energizing Brew") == 0 then
			z.FlashSize = s.FlashSizePercent() / 2
			z.FlashColor = "yellow"
			z.Continue = true
		else
			z.FlashSize = nil
			z.FlashColor = nil
			z.Continue = nil
		end
		
		local castTime = c.GetHastedTime(4)
		return not c.HasBuff("Energizing Brew") 
			and a.Power + a.Regen * castTime < s.MaxPower("player")
			and c.GetBuffDuration("Tiger Power") > castTime
	end
})
c.RegisterForFullChannels("Fists of Fury", 4)

c.AddSpell("Chi Wave", "for Windwalker", {
	CheckFirst = function()
		return a.Power + a.Regen * 2 <= s.MaxPower("player")
	end
})

addSpell("Blackout Kick", "under Combo Breaker", {
	CheckFirst = function()
		return c.HasBuff("Combo Breaker: Blackout Kick")
			and not c.IsCasting("Blackout Kick")
	end
})

addSpell("Blackout Kick", "without blocking RSK", {
	CheckFirst = function()
		local cd = c.GetCooldown("Rising Sun Kick")
		return a.Chi >= 4
			or (cd >= 1 and a.Power + a.Regen * (cd - 1) >= 40)
	end
})

addOptionalSpell("Expel Harm", "for Windwalker", {
	CheckFirst = function()
		return s.HealthPercent("player") < 80
			and a.Chi + 2 <= s.MaxPower("player", SPELL_POWER_CHI)
	end
})

addSpell("Jab", "for Windwalker", {
	CheckFirst = function()
		return a.Chi + 2 <= s.MaxPower("player", SPELL_POWER_CHI)
	end
})

c.AddOptionalSpell("Flying Serpent Kick 1")

c.AddSpell("Zen Sphere", "for Windwalker", {
	NoRangeCheck = true,
	CheckFirst = function()
		return not c.HasBuff("Zen Sphere")
	end
})
