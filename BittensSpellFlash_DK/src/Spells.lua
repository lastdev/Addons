local AddonName, a = ...
if a.BuildFail(50000) then return end
local L = a.Localize
local s = SpellFlashAddon
local c = BittensSpellFlashLibrary

local GetRuneType = GetRuneType
local GetTotemInfo = GetTotemInfo
local IsMounted = IsMounted
local UnitExists = UnitExists
local print = print
local select = select

c.Init(a)

a.Costs = {}
local function setCost(blood, frost, unholy, death, name, bonusRP, rime)
	a.Costs[s.SpellName(c.GetID(name))] = {
		Blood = blood,
		Frost = frost,
		Unholy = unholy,
		Death = death,
		BonusRP = bonusRP,
		Rime = rime,
	}
end

setCost(0, 0, 0, 0, "Empower Rune Weapon", 25)
setCost(0, 0, 0, 0, "Horn of Winter", 10)
setCost(0, 0, 1, 0, "Bone Shield")
setCost(0, 0, 1, 0, "Dark Transformation")
setCost(0, 0, 1, 0, "Death and Decay")
setCost(0, 0, 1, 0, "Plague Strike")
setCost(0, 0, 1, 0, "Scourge Strike")
--setCost(0, 1, 0, 0, "Chains of Ice")
setCost(0, 1, 0, 0, "Howling Blast", nil, true)
setCost(0, 1, 0, 0, "Icy Touch", nil, true)
setCost(0, 1, 0, 0, "Pillar of Frost")
setCost(0, 1, 1, 0, "Death Strike")
setCost(0, 1, 1, 0, "Obliterate")
setCost(1, 0, 0, 0, "Blood Boil")
setCost(1, 0, 0, 0, "Heart Strike")
setCost(1, 0, 0, 0, "Pestilence")
setCost(1, 1, 0, 0, "Festering Strike")
setCost(0, 0, 0, 1, "Death Siphon")

local function runeAvailable(runeId, delay)
	if delay == nil then
		delay = 0
	end
	return a.Runes[runeId] <= delay
end

local function fakeConsume(runeID, delay, needed, deathAvailable)
	if runeAvailable(runeID, delay) then
		if a.IsDeathRune(runeID) then
			deathAvailable = deathAvailable + 1
		elseif needed > 0 then
			needed = needed - 1
		end
	end
	return needed, deathAvailable
end

local function sufficientResources(id, noGCD)
	local name = s.SpellName(id)
	local cost = a.Costs[name]
	if cost then
		local delay = 0
		if noGCD then
			delay = -c.GetBusyTime()
		end
		local deathAvailable = a.PendingDeathRunes
		local bloodNeeded = cost.Blood
		local frostNeeded = cost.Rime and a.FreezingFog > 0 and 0 or cost.Frost
		local unholyNeeded = cost.Unholy
		bloodNeeded, deathAvailable = fakeConsume(
			1, delay, bloodNeeded, deathAvailable)
		bloodNeeded, deathAvailable = fakeConsume(
			2, delay, bloodNeeded, deathAvailable)
		frostNeeded, deathAvailable = fakeConsume(
			5, delay, frostNeeded, deathAvailable)
		frostNeeded, deathAvailable = fakeConsume(
			6, delay, frostNeeded, deathAvailable)
		unholyNeeded, deathAvailable = fakeConsume(
			3, delay, unholyNeeded, deathAvailable)
		unholyNeeded, deathAvailable = fakeConsume(
			4, delay, unholyNeeded, deathAvailable)
		if bloodNeeded + frostNeeded + unholyNeeded + cost.Death
			> deathAvailable then
			
			return false
		end
	end
--c.Debug("Resources", s.SpellCost(name), "<=", a.RP, "|", s.SpellCost(name) <= a.RP)
	return s.SpellCost(name) <= a.RP
end

local function masterOverride(z)
	if z.Melee then
		if not s.MeleeDistance() then
			return false
		end
	elseif not z.NoRangeCheck and s.SpellHasRange(z.ID) then
		if not s.SpellInRange(z.ID) then
			return false
		end
	end
	return (z.CheckFirst == nil or z:CheckFirst())
		and sufficientResources(z.ID)
end

-- Use this for all spells with rune or RP costs.  Spells added this way may
-- only use the CheckFirst and NoRangeCheck attributes.  All others will be
-- ignored.  Cooldowns will NOT be checked.
local function addSpell(name, tag, attributes)
	c.AddSpell(name, tag, attributes).Override = masterOverride
end

local function addOptionalSpell(name, tag, attributes)
	c.AddOptionalSpell(name, tag, attributes).Override = masterOverride
end

------------------------------------------------------------------------ common
function a.IsDeathRune(runeId)
	return GetRuneType(runeId) == 4
end

function a.BothRunesAvailable(runeName, delay)
	if runeName == "Blood" then
		return runeAvailable(1, delay) and runeAvailable(2, delay)
	elseif runeName == "Frost" then
		return runeAvailable(5, delay) and runeAvailable(6, delay)
	elseif runeName == "Unholy" then
		return runeAvailable(3, delay) and runeAvailable(4, delay)
	end
	print("Bad rune name: ", runeName)
end

local function isFullyDepleted(runeID)
	local otherID
	if runeID % 2 == 0 then
		otherID = runeID - 1
	else
		otherID = runeID + 1
	end
	local otherCD = a.Runes[otherID]
	return otherCD > 0 and a.Runes[runeID] > otherCD
end

local function hasFullyDepleted(...)
	for i = 1, select("#", ...) do
		if isFullyDepleted(select(i, ...)) then
			return true
		end
	end
end

local function hasFrostFever(earlyRefresh)
	if c.IsCasting("Plague Leech") then
		return false
	end
	
	return c.GetMyDebuffDuration("Frost Fever") > earlyRefresh
		or c.IsAuraPendingFor("Outbreak")
		or c.IsAuraPendingFor("Icy Touch")
		or c.IsAuraPendingFor("Howling Blast")
		or c.HasBuff("Unholy Blight")
		or c.IsCasting("Unholy Blight")
		or (s.HasSpell(c.GetID("Scarlet Fever"))
			and c.IsCasting("Blood Boil")
			and s.MyDebuff(c.GetID("Frost Fever")))
end

local function hasBloodPlague(earlyRefresh)
	if c.IsCasting("Plague Leech") then
		return false
	end
	
	return c.GetMyDebuffDuration("Blood Plague") > earlyRefresh
		or c.IsAuraPendingFor("Outbreak")
		or c.IsAuraPendingFor("Plague Strike")
		or a.BloodPlagueRefreshPending
		or c.HasBuff("Unholy Blight")
		or c.IsCasting("Unholy Blight")
		or (c.IsCasting("Blood Boil")
			and s.MyDebuff(c.GetID("Blood Plague"))
			and s.HasSpell(c.GetID("Scarlet Fever")))
end

local function hasBothDiseases(earlyRefresh)
	return hasFrostFever(earlyRefresh) and hasBloodPlague(earlyRefresh)
end

local function shouldStrikeForResources()
	if c.HasTalent("Blood Tap") then
		return c.GetBuffStack("Blood Charge") <= 10
			or c.GetBuffDuration("Blood Charge") < 5
	elseif c.HasTalent("Runic Empowerment") then
		return hasFullyDepleted(1, 2, 3, 4, 5, 6)
	elseif c.HasTalent("Runic Corruption") then
		return c.GetBuffDuration("Runic Corruption") < 1
	end
end

c.AddSpell("Horn of Winter", nil, {
	CheckFirst = function()
		return s.MaxPower("player") - a.RP > 10
	end
})

c.AddOptionalSpell("Empower Rune Weapon", "when low", {
	NoGCD = true,
	CheckFirst = function()
		return not runeAvailable(1)
			and not runeAvailable(2)
			and not runeAvailable(3)
			and not runeAvailable(4)
			and not runeAvailable(5)
			and not runeAvailable(6)
			and a.RP < 32
	end
})

c.AddSpell("Outbreak", nil, {
	CheckFirst = function()
		return not hasBothDiseases(0)
	end
})
c.RegisterAura("Outbreak", "Frost Fever")
c.RegisterAura("Icy Touch", "Frost Fever")
c.RegisterAura("Plague Strike", "Blood Plague")

c.AddInterrupt("Mind Freeze", nil, {
	NoGCD = true,
})

------------------------------------------------------------------------- Blood
local function canBloodTapForDeathStrike()
	local frost = 0
	local unholy = 0
	local death = 0
	if runeAvailable(3) then
		if a.IsDeathRune(3) then
			death = death + 1
		else
			unholy = unholy + 1
		end
	end
	if runeAvailable(4) then
		if a.IsDeathRune(4) then
			death = death + 1
		else
			unholy = unholy + 1
		end
	end
	if runeAvailable(5) then
		if a.IsDeathRune(5) then
			death = death + 1
		else
			frost = frost + 1
		end
	end
	if runeAvailable(6) then
		if a.IsDeathRune(6) then
			death = death + 1
		else
			frost = frost + 1
		end
	end
	return (frost + unholy + death == 1)
		or (death == 0 and (
				(frost == 0 and unholy > 0)
			or (unholy == 0 and frost > 0)))
end

local function getDeathStrikeHeal()
	return 7 * (1 + .2 * c.GetBuffStack("Scent of Blood"))
end

local function shouldDeathStrikeForHealth()
	return s.HealthDamagePercent("player") >= getDeathStrikeHeal()
end

local function shouldDeathStrikeForShield()
	return c.GetBuffDuration("Blood Shield") < 2
end

c.AddOptionalSpell("Blood Presence", nil, {
	Type = "form"
})

addSpell("Death Strike", "for Health", {
	CheckFirst = shouldDeathStrikeForHealth
})

addSpell("Death Strike", "to Save Shield", {
	CheckFirst = shouldDeathStrikeForShield
})

addSpell("Death Strike", "if Two Available", {
	CheckFirst = function()
		local avail = 0
		if a.IsDeathRune(1) and runeAvailable(1, 1) then
			avail = avail + 1
		end
		if a.IsDeathRune(2) and runeAvailable(2, 1) then
			avail = avail + 1
		end
		if runeAvailable(5, 1) then
			avail = avail + 1
		end
		if runeAvailable(6, 1) then
			avail = avail + 1
		end
		if runeAvailable(3, 1) then
			avail = avail + 1
		end
		if runeAvailable(4, 1) then
			avail = avail + 1
		end
		local charges = c.GetBuffStack("Blood Charge")
		if charges >= 10 then
			avail = avail + 2
		elseif charges >= 5 then
			avail = avail + 1
		end
		return avail >= 4
	end
})

c.AddOptionalSpell("Blood Tap", "for Death Strike", {
	NoGCD = true,
	CheckFirst = function()
		return c.GetBuffStack("Blood Charge") >= 5
			and (shouldDeathStrikeForHealth() or shouldDeathStrikeForShield())
			and canBloodTapForDeathStrike()
	end
})

addSpell("Death Siphon", "for Health", {
	CheckFirst = function()
		-- use the same criteria as for Death Strike, so we know Death Siphon
		-- is only used when Death Strike cannot be
		return shouldDeathStrikeForHealth()
	end
})

c.AddSpell("Outbreak", "for Blood Plague", {
	CheckFirst = function()
		return not hasBloodPlague(1)
	end
})

c.AddSpell("Outbreak", "Early", {
	CheckFirst = function()
		return not hasBothDiseases(5)
	end
})

addSpell("Plague Strike", "for Blood Plague", {
	CheckFirst = function()
		return not hasBloodPlague(0)
	end
})

addSpell("Rune Strike", "for Resources", {
	CheckFirst = shouldStrikeForResources
})

addSpell("Rune Strike", "for Resources if Capped", {
	CheckFirst = function()
		return s.MaxPower("player") - a.RP >= 40 and shouldStrikeForResources()
	end
})

addSpell("Blood Boil", "for Runic Power", {
	CheckFirst = function()
		-- we only worry about it if Crimson Scourge is up - since if a blood
		-- rune was available we'd be using Heart Strike
		return s.MaxPower("player") - a.RP >= 30
			and c.HasBuff("Crimson Scourge")
			and not c.IsCasting("Blood Boil")
	end
})

addSpell("Blood Boil", "for Blood Plague", {
	CheckFirst = function()
		if not hasBloodPlague(0) or hasBloodPlague(10) then
			return false
		end
		
		local duration = c.GetBuffDuration("Blood Plague")
		if c.HasBuff("Crimson Scourge") then
			return duration <= 3
		end
		
		if duration <= 3 and c.GetCooldown("Outbreak") > duration then
			return true
		end
		
		return c.HasMyDebuff("Frost Fever")
			and ((runeAvailable(1) and not a.IsDeathRune(1))
				or (runeAvailable(2) and not a.IsDeathRune(2)))
	end
})

c.AddSpell("Horn of Winter", "for Buff", {
	CheckFirst = function()
		return c.RaidBuffNeeded(c.ATTACK_POWER_BUFFS)
	end
})

c.AddSpell("Horn of Winter", "for Runic Power", {
	CheckFirst = function()
		return s.MaxPower("player") - a.RP >= 30
	end
})

c.AddSpell("Heart Strike", "for Runic Power", {
	Override = function()
		return s.MaxPower("player") - a.RP >= 30
		 and ((runeAvailable(1) and not a.IsDeathRune(1))
			or (runeAvailable(2) and not a.IsDeathRune(2)))
	end
})

c.AddOptionalSpell("Rune Tap", nil, {
	CheckFirst = function()
		local damage = s.HealthDamagePercent("player")
		if damage < 10 then
			return false
		end
		
		if shouldDeathStrikeForHealth()
			and sufficientResources(c.GetID("Death Strike")) then
			
			return damage > getDeathStrikeHeal() + 10
		else
			return true
		end
	end
})

c.AddOptionalSpell("Dancing Rune Weapon")

c.AddOptionalSpell("Bone Shield", nil, {
	CheckFirst = function()
		if s.InCombat() then
			return not c.HasBuff("Bone Shield")
		else
			return c.GetBuffDuration("Bone Shield") < 2 * 60
				or s.BuffStack(c.GetID("Bone Shield"), "player") < 6
		end
	end
})

c.AddOptionalSpell("Vampiric Blood", nil, {
	ShouldHold = function()
		return s.HealthDamagePercent("player") < 15
	end
})

c.AddOptionalSpell("Death Pact", nil, {
	NoRangeCheck = 1,
	Override = function(z)
		if not c.HasTalent("Death Pact") or c.GetCooldown("Death Pact") > 0 then
			return false
		end
		
		local ghoulIsOut = GetTotemInfo(1)
		if ghoulIsOut then
			z.ID = c.GetID("Death Pact")
			return true
		else
			z.ID = c.GetID("Raise Dead")
			return c.GetCooldown("Raise Dead") == 0
		end
	end,
	ShouldHold = function()
		local ghoulIsOut = GetTotemInfo(1)
		return ghoulIsOut and s.HealthDamagePercent("player") < 40
	end
})

c.AddOptionalSpell("Conversion", nil, {
	Buff = "Conversion",
	CheckFirst = function()
		return a.RP > 50 and not c.HasBuff("Conversion")
	end,
	ShouldHold = function()
		return s.HealthDamagePercent("player") < 20
	end
})

c.AddOptionalSpell("Conversion", "Cancel", {
	NoGCD = true,
	FlashColor = "red",
	CheckFirst = function()
		return c.HasBuff("Conversion", true)
			and not shouldDeathStrikeForHealth()
	end
})

c.AddOptionalSpell("Icebound Fortitude", nil, {
	Score = 2,
})

c.AddOptionalSpell("Fire of the Deep", nil, {
	Type = "item",
	Buff = "Elusive",
})

c.AddTaunt("Dark Command", nil, {
	NoGCD = true
})

c.AddTaunt("Death Grip", nil, {
	NoGCD = true 
})

------------------------------------------------------------------------- Frost
c.AddOptionalSpell("Frost Presence", nil, { Type = "form" })

addSpell("Frost Strike", nil, {
	Melee = true,
})

addSpell("Frost Strike", "under KM", {
	Melee = true,
	CheckFirst = function()
		return a.KillingMachine
	end
})

addSpell("Frost Strike", "under KM no Diseases", {
	Melee = true,
	CheckFirst = function()
		return a.KillingMachine and not hasBothDiseases(0)
	end
})

addSpell("Frost Strike", "for Resources", {
	Melee = true,
	CheckFirst = shouldStrikeForResources
})

c.RegisterAura("Howling Blast", "Frost Fever")

addSpell("Howling Blast")

addSpell("Howling Blast", "Freezing Fog", {
	CheckFirst = function()
		return a.FreezingFog > 0
	end
})

addSpell("Howling Blast", "for FF", {
	CheckFirst = function()
		return not hasFrostFever(0)
	end
})

addSpell("Plague Strike", "for BP unless Outbreak", {
	Melee = true,
	CheckFirst = function()
		return not hasBloodPlague(0)
			and (not s.Flashable(c.GetID("Outbreak"))
				or c.GetCooldown("Outbreak"))
	end
})

addSpell("Obliterate", nil, {
	CheckFirst = function()
		return hasBothDiseases(0)
	end
})

addSpell("Obliterate", "UU", {
	CheckFirst = function()
		return a.BothRunesAvailable("Unholy", 1) and hasBothDiseases(0)
	end
})

addSpell("Obliterate", "KM UU", {
	CheckFirst = function()
		return a.KillingMachine
			and a.BothRunesAvailable("Unholy", 1) 
			and hasBothDiseases(0)
	end
})

c.AddSpell("Plague Leech", "for Frost", {
	CheckFirst = function()
		if not hasBothDiseases(0) or not hasFullyDepleted(1, 2, 3, 4, 5, 6) then
			return false
		end
		
		if c.GetCooldown("Outbreak") <= 1 and not c.IsCasting("Outbreak") then
			return true
		end
		
		if not c.HasBuff("Freezing Fog") or c.IsCasting("Howling Blast") then
			return false
		end
		
		for runeID = 3, 6 do
			if runeAvailable(runeID) then
				return true
			end
		end
		return false
	end
})

--addSpell("Death Siphon", nil, {
--	Run = function()
--		c.Debug("Death Siphon", "running")
--	end
--})
--
--addSpell("Death Siphon", "DD", {
--	CheckFirst = function()
--		return a.BothRunesAvailable("Blood", 1)
--	end
--})

c.AddOptionalSpell("Pillar of Frost", nil, { 
	NoGCD = true,
})

c.AddOptionalSpell("Blood Tap", "for Frost", {
	NoGCD = true,
	CheckFirst = function()
		local stack = c.GetBuffStack("Blood Charge")
		if stack < 5 then
			return false
		end
		
		if stack >= 10 then
			return hasFullyDepleted(1, 2, 3, 4, 5, 6)
		end
		
		return hasFullyDepleted(3, 4, 5, 6)
	end
})

------------------------------------------------------------------------ Unholy
c.AddOptionalSpell("Unholy Presence", nil, {
	Type = "form",
})

c.AddOptionalSpell("Raise Dead", nil, {
	NoRangeCheck = 1,
	CheckFirst = function()
		return not UnitExists("pet") and not IsMounted()
	end
})

c.AddOptionalSpell("Unholy Frenzy", nil, {
	NoRangeCheck = 1,
	Melee = 1,
	CheckFirst = function()
		return not s.Buff(c.BLOODLUST_BUFFS, "player")
	end
})

c.AddOptionalSpell("Blood Tap", "for Unholy", {
	CheckFirst = function()
		return c.GetBuffStack("Blood Charge") >= 5
	end
})

addOptionalSpell("Summon Gargoyle", nil, {
	CheckFirst = function()
		return c.GetCooldown("Summon Gargoyle") == 0
	end
})

addSpell("Outbreak", "Refresh", {
	CheckFirst = function()
		return c.GetCooldown("Outbreak") == 0 and not hasBothDiseases(3)
	end
})

addSpell("Unholy Blight", "Refresh", {
	CheckFirst = function()
		return c.GetCooldown("Unholy Blight") == 0 and not hasBothDiseases(3)
	end
})

addSpell("Icy Touch", "for FF", {
	CheckFirst = function()
		return not hasFrostFever(0)
	end
})

addSpell("Plague Strike", "for BP", {
	CheckFirst = function()
		return not hasBloodPlague(0)
	end
})

c.AddSpell("Plague Leech", "for Unholy", {
	CheckFirst = function()
		return c.GetCooldown("Outbreak") <= 1 and not c.IsCasting("Outbreak")
	end
})

addSpell("Dark Transformation", nil, {
	CheckFirst = function()
		if s.Buff(c.GetID("Dark Transformation"), "pet")
			or c.IsAuraPendingFor("Dark Transformation") then
			
			return false
		end
		
		local stacks = s.BuffStack(c.GetID("Shadow Infusion"), "pet")
		if a.ShadowInfusionPending or c.IsCasting("Death Coil") then
			stacks = stacks + 1
		end
		return stacks >= 5
	end
})

addSpell("Death Coil")

addSpell("Death Coil", "under Sudden Doom", {
	CheckFirst = function()
		return c.HasBuff("Sudden Doom") and not c.IsCasting("Death Coil")
	end
})

addSpell("Death Coil", "unless Gargoyle", {
	CheckFirst = function()
		return c.GetCooldown("Summon Gargoyle") > 8
			or c.IsCasting("Summon Gargoyle")
	end
})

local function DB_or_DF_or_UU()
	return a.BothRunesAvailable("Unholy", 1)
		or (a.IsDeathRune(1) and runeAvailable(1, 0) and runeAvailable(2, 1))
		or (a.IsDeathRune(2) and runeAvailable(2, 0) and runeAvailable(1, 1))
		or (a.IsDeathRune(5) and runeAvailable(5, 0) and runeAvailable(6, 1))
		or (a.IsDeathRune(6) and runeAvailable(6, 0) and runeAvailable(5, 1))
end

addOptionalSpell("Death and Decay", nil, {
	NoRangeCheck = true,
	CheckFirst = function()
		return c.GetCooldown("Death and Decay") == 0
	end
})

addOptionalSpell("Death and Decay", "DB or DF or UU", {
	NoRangeCheck = true,
	CheckFirst = function()
		return c.GetCooldown("Death and Decay") == 0 and DB_or_DF_or_UU()
	end
})

addSpell("Scourge Strike")

addSpell("Scourge Strike", "UU", {
	CheckFirst = function()
		return a.BothRunesAvailable("Unholy", 1)
	end
})

addSpell("Scourge Strike", "DB or DF or UU", {
	CheckFirst = DB_or_DF_or_UU,
})

addSpell("Festering Strike")

addSpell("Festering Strike", "BBFF", {
	CheckFirst = function()
		return a.BothRunesAvailable("Blood", 1)
			or a.BothRunesAvailable("Frost", 1)
	end
})
