local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetSpellCharges = GetSpellCharges
local GetTime = GetTime
local IsMounted = IsMounted
local SPELL_POWER_CHI = SPELL_POWER_CHI
local UnitGUID = UnitGUID
local UnitInRange = UnitInRange
local UnitIsDeadOrGhost = UnitIsDeadOrGhost
local UnitIsUnit = UnitIsUnit
local UnitPowerMax = UnitPowerMax
local math = math
local select = select
local string = string

local spellCosts = {}

local function setCost(name, energy, chi, freeBuff)
	spellCosts[s.SpellName(c.GetID(name))] = { 
		Energy = energy, 
		Chi = chi,
		FreeBuff = freeBuff and c.GetID(freeBuff),
	}
end

local function nameMatches(localizedName, name)
	return s.SpellName(c.GetID(name), true) == localizedName
end

function a.GetEnergyCost(localizedName)
	return spellCosts[localizedName] and spellCosts[localizedName].Energy
end

function a.GetChiCost(localizedName)
	local cost = spellCosts[localizedName]
	if cost == nil then
		return nil
	end
	
	
	if cost.FreeBuff and s.Buff(cost.FreeBuff, "player") then
		return 0
	end
	
	local cost = cost.Chi
	if nameMatches(localizedName, "Jab") 
			or nameMatches(localizedName, "Expel Harm") then
		
		if s.Form(c.GetID("Stance of the Fierce Tiger")) then
			cost = cost - 1
			if nameMatches(localizedName, "Jab") 
				and c.HasBuff("Power Strikes") then
				
				cost = cost - 1
			end
		end
	elseif nameMatches(localizedName, "Tiger Palm") then
		if a.Trained then
			cost = 0
		end
	end
	return cost
end

setCost("Jab", 40, -1)
setCost("Expel Harm", 40, -1)
setCost("Keg Smash", 40, -2)
setCost("Blackout Kick", 0, 2, "Combo Breaker: Blackout Kick")
setCost("Tiger Palm", 0, 1, "Combo Breaker: Tiger Palm")
setCost("Rising Sun Kick", 0, 2)
setCost("Fists of Fury", 0, 3)
setCost("Spinning Crane Kick", 40, -1)
setCost("Rushing Jade Wind", 40, -1)
setCost("Breath of Fire", 0, 2)
setCost("Touch of Death", 0, 3)
setCost("Guard", 0, 2)
setCost("Purifying Brew", 0, 1, "Purifier")
setCost("Enveloping Mist", 0, 3)
setCost("Surging Mist", 0, -1)
setCost("Renewing Mist", 0, -1)
setCost("Uplift", 0, 2)

local function checkChiBrew(z, chiPad)
	local charges, tilNext, tilMax = c.GetChargeInfo("Chi Brew")
	if a.MissingChi < 2 + chiPad or charges == 0 then
		return false
	end
	
	c.MakeMini(z, tilMax > 0)
	return true
end

------------------------------------------------------------------------ Common
local function modSpell(spell)
	local localizedName = s.SpellName(spell.ID)
	local cost = spellCosts[localizedName]
	if cost then
		spell.EvenIfNotUsable = true
		spell.NoPowerCheck = true
		spell.CheckLast = function()
--c.Debug("CheckLast", s.SpellName(spell.ID), cost.Energy, a.GetChiCost(localizedName))
			return a.Power >= cost.Energy 
				and a.Chi >= a.GetChiCost(localizedName)
		end
	end
end

local function addSpell(name, tag, attributes)
	modSpell(c.AddSpell(name, tag, attributes))
end

local function addOptionalSpell(name, tag, attributes)
	modSpell(c.AddOptionalSpell(name, tag, attributes))
end

c.RegisterForFullChannels("Spinning Crane Kick", 2, true)

addOptionalSpell("Roll", nil, {
	FlashID = { "Roll", "Chi Torpedo" },
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
		return c.GetHealthPercent("player") < 80
	end
})

addSpell("Chi Burst", nil, {
	NotWhileMoving = true,
	NotIfActive = true,
	Cooldown = 30,
})

c.AddSpell("Zen Sphere", nil, {
	NoRangeCheck = true,
	MyBuff = "Zen Sphere",
	BuffUnit = "player",
})

addOptionalSpell("Invoke Xuen, the White Tiger", nil, { NoGCD = true })

addSpell("Spinning Crane Kick", nil, {
	Melee = true,
	Override = function()
		return a.Power >= 40
	end
})

addSpell("Rushing Jade Wind", nil, {
	Melee = true,
	Buff = "Rushing Jade Wind",
	BuffUnit = "player",
	Override = function()
		return a.Power >= 40
	end
})

c.AddInterrupt("Spear Hand Strike")

-------------------------------------------------------------------- Brewmaster
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
			return c.GetHealthPercent("player") > 90
		else
			return c.GetHealthPercent("player") > 80
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
			and (c.HasBuff("Power Guard") or not a.Trained)
			and not c.InDamageMode()
	end
})

addOptionalSpell("Purifying Brew", nil, {
	NoGCD = true,
	CheckFirst = function()
		if (c.HasBuff("Healing Elixirs") and s.HealthPercent("player") > 85)
			or c.IsCasting("Purifying Brew") then
			
			return false
		end
		
		return s.Debuff(c.GetID("Moderate Stagger"), "player")
			or s.Debuff(c.GetID("Heavy Stagger"), "player")
			or (s.Debuff(c.GetID("Light Stagger"), "player") 
				and (a.Chi > 2 or c.HasBuff("Purifier", true)))
	end	
})

addOptionalSpell("Chi Brew", "for Brewmaster", {
	CheckFirst = function(z)
		return checkChiBrew(z, 2) 
			and a.Power + a.Regen <= UnitPowerMax("player")
			and c.GetBuffStack("Elusive Brew Stacker", false, true) < 8
	end
})

c.AddOptionalSpell("Stance of the Sturdy Ox", nil, {
	Type = "form",
})

addSpell("Blackout Kick")

addSpell("Blackout Kick", "for Shuffle", {
	Applies = { "Shuffle" },
	CheckFirst = function(z)
		return a.Shuffle < 1
			and not c.IsAuraPendingFor("Blackout Kick")
			and a.Trained
			and not c.InDamageMode()
	end
})

addSpell("Blackout Kick", "for Extended Shuffle", {
	CheckFirst = function(z)
		return (a.MissingChi == 0 
				or (a.MissingChi == 1 
					and c.GetCooldown("Keg Smash") < c.LastGCD)) 
			and a.Trained
	end
})

addSpell("Blackout Kick", "for AoE", {
	CheckFirst = function(z)
		return (a.Shuffle < 2 or a.MissingChi <= 1) 
			and a.Trained 
			and not c.InDamageMode()
	end
})

addSpell("Keg Smash", nil, {
	Melee = true,
	Cooldown = 8,
})

addSpell("Keg Smash", "for Dizzying Haze", {
	Melee = true,
	Cooldown = 8,
	CheckFirst = function()
		return not s.Debuff(c.GetID("Dizzying Haze"), nil, 2 + c.GetBusyTime())
			and not c.IsAuraPendingFor("Keg Smash")
	end
})

addSpell("Keg Smash", "for Chi", {
	Melee = true,
	Cooldown = 8,
	Applies = { "Dizzying Haze" },
	CheckFirst = function()
		if UnitPowerMax("player") - a.Power < a.Regen then
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
		local timeToCap = (UnitPowerMax("player") - a.Power) / a.Regen
		if timeToCap < 1 
			or (timeToCap < 2 and (a.Shuffle < 2 or a.MissingChi < 2)) then
			
			return true
		end
		
		-- gen unless we can wait and get better use out of expel harm/keg smash
		local wanted = 0
		local function addWanted(name)
			wanted = wanted + math.max(0, 40 - c.GetCooldown(name) * a.Regen)
		end
		addWanted("Keg Smash")
		if c.InDamageMode() then
			if c.AoE then
				addWanted("Rushing Jade Wind")
			end
		else
			addWanted("Expel Harm")
		end
		return a.Power - 40 >= wanted
	end
})

addSpell("Expel Harm", "for Brewmaster", {
	CheckFirst = function()
		return c.GetHealthPercent("player") < 85
	end
})

c.AddSpell("Tiger Palm", "for Brewmaster", {
	Override = function()
		return s.MeleeDistance() and a.Trained
	end
})

addSpell("Chi Wave", "for Brewmaster", {
	Cooldown = 15,
	CheckFirst = function()
		return c.GetHealthPercent("player") < 90
	end
})

addSpell("Chi Burst", "for Brewmaster", {
	NotWhileMoving = true,
	NotIfActive = true,
	Cooldown = 30,
	CheckFirst = function()
		return c.GetHealthPercent("player") < 90
	end
})

addSpell("Breath of Fire", nil, {
	Melee = true,
	CheckFirst = function()
		return c.InDamageMode()
	end,
})

addSpell("Breath of Fire", "for DoT", {
	Melee = true,
	MyDebuff = "Breath of Fire",
	Tick = 2,
	CheckFirst = function()
		return c.InDamageMode() 
			and c.HasMyDebuff("Dizzying Haze", nil, nil, "Keg Smash")
	end,
})

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

addOptionalSpell("Chi Brew", "for Mistweaver", {
	CheckFirst = function(z)
		return checkChiBrew(z, 1) 
			and c.GetBuffStack("Mana Tea") < 16
	end
})

c.AddOptionalSpell("Surging Mist", nil, {
	Override = function()
		if a.SoothDamage > 50 then
			return true
		end
		
		if a.MissingChi > 0 and c.GetBuffStack("Vital Mists") == 5 then
			for member in c.GetGroupMembers() do
				if c.GetHealthPercent(member) < 80
					and (UnitInRange(member) or UnitIsUnit(member, "player"))
					and not UnitIsDeadOrGhost(member) then
					
					return true
				end
			end
		end
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
	Melee = true,
	Override = function()
		return a.Chi >= 3
			and s.Health() < s.MaxHealth("player")
			and c.GetCooldown("Touch of Death") == 0
	end
})

c.AddSpell("Blackout Kick", "for Serpent's Zeal", {
	FlashSize = s.FlashSizePercent() / 2,
	Melee = true,
	Buff = "Serpent's Zeal",
	BuffUnit = "player",
	EarlyRefresh = 1,
	Override = function()
		return (a.MissingChi == 0 or (a.Chi >= 2 and a.MuscleMemory))
			and not c.IsMissingTotem(1)
	end
})

c.AddSpell("Chi Wave", "for Mistweaver", {
	FlashSize = s.FlashSizePercent() / 2,
	Cooldown = 15,
})

c.AddSpell("Tiger Palm", "for Mistweaver", {
	FlashSize = s.FlashSizePercent() / 2,
	Melee = true,
	Override = function()
		return (a.MissingChi == 0 and not c.AoE) 
			or (a.Chi >= 1 
				and a.MuscleMemory 
				and (c.HasBuff("Serpent's Zeal", false, false, "Blackout Kick") 
					or c.IsMissingTotem(1)))
	end
})

c.AddSpell("Expel Harm", "for Mistweaver", {
	FlashSize = s.FlashSizePercent() / 2,
	Override = function()
		return c.GetHealthPercent("player") < 80 
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

c.AddSpell("Spinning Crane Kick", "for Mistweaver", {
	Melee = true,
	EvenIfNotUsable = true,
	CheckFirst = function()
		return c.AoE
	end,
})

c.AddSpell("Rushing Jade Wind", "for Mistweaver", {
	Melee = true,
	Buff = "Rushing Jade Wind",
	BuffUnit = "player",
	EvenIfNotUsable = true,
	CheckFirst = function()
		return c.AoE
	end,
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

c.AddSpell("Storm, Earth, and Fire", nil, {
	CheckFirst = function(z)
		if a.SefTargets[UnitGUID(s.UnitSelection())] then
			z.FlashColor = "red"
			return true
		elseif c.AoE and c.GetBuffStack("Storm, Earth, and Fire") < 2 then
			z.FlashColor = "yellow"
			return true
		end
	end
})

addOptionalSpell("Energizing Brew", nil, {
	CheckFirst = function()
		return (UnitPowerMax("player") - a.Power) / a.Regen > 5
	end
})

addOptionalSpell("Tigereye Brew", nil, {
	NoGCD = true,
	CheckFirst = function(z)
		if c.GetBuffStack("Tigereye Brew Stacker", false, true) 
			>= (c.WearingSet(4, "WWT15") and 18 or 19) then
			
			z.FlashColor = "red"
			return true
		else
			z.FlashColor = "yellow"
		end
		
		local isUp = c.HasBuff("Tigereye Brew", false, true)
		if c.IsSolo() then
			return not isUp
		end
		
		return not isUp
			and ((a.Chi >= 2
					and c.GetCooldown("Rising Sun Kick") == 0
					and c.HasBuff("Tiger Power")
					and c.HasMyDebuff("Rising Sun Kick"))
				or c.IsSolo())
	end
})

addOptionalSpell("Chi Brew", "for Windwalker", {
	CheckFirst = function(z)
		return checkChiBrew(z, 1) 
			and a.Power + a.Regen <= UnitPowerMax("player")
			and c.GetBuffStack("Tigereye Brew Stacker", false, true) < 16
	end
})

addSpell("Rising Sun Kick")

addSpell("Rising Sun Kick", "for Debuff", {
	CheckFirst = function()
		return not c.HasMyDebuff("Rising Sun Kick", nil, nil, true)
	end
})

addSpell("Tiger Palm", "for Tiger Power", {
	CheckFirst = function()
		return not c.HasBuff("Tiger Power")
			and (not c.HasSpell("Rising Sun Kick") 
				or c.HasMyDebuff("Rising Sun Kick"))
			and a.Power + a.Regen <= UnitPowerMax("player")
			and not c.IsCasting("Tiger Palm")
	end
})

addSpell("Tiger Palm", "under Combo Breaker", {
	CheckFirst = function()
		return c.HasBuff("Combo Breaker: Tiger Palm")
			and not c.IsCasting("Tiger Palm")
	end
})

addOptionalSpell("Fists of Fury", nil, {
	Melee = true,
	NoRangeCheck = true,
	NotWhileMoving = true,
	CheckFirst = function(z)
		c.MakeMini(z, c.GetCooldown("Energizing Brew") == 0)
		local castTime = c.GetHastedTime(4)
		return not c.HasBuff("Energizing Brew") 
			and a.Power + a.Regen * castTime < UnitPowerMax("player")
			and c.GetBuffDuration("Tiger Power") > castTime
	end
})
c.RegisterForFullChannels("Fists of Fury", 4)

c.AddSpell("Chi Wave", "for Windwalker", {
	Cooldown = 15,
	CheckFirst = function()
		return a.Power + a.Regen * 2 <= UnitPowerMax("player")
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
		return c.GetHealthPercent("player") < 80
			and a.Chi + 2 <= UnitPowerMax("player", SPELL_POWER_CHI)
	end
})

addSpell("Jab", "for Windwalker", {
	CheckFirst = function()
		return a.Chi + 2 <= UnitPowerMax("player", SPELL_POWER_CHI)
			and (not c.AoE or a.Power + a.Regen >= 80)
	end
})

c.MakeMini(c.AddOptionalSpell("Flying Serpent Kick 1"))
