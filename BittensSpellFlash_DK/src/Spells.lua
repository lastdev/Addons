local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local x = s.UpdatedVariables
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetRuneType = GetRuneType
local GetSpecialization = GetSpecialization
local GetTime = GetTime
local GetTotemInfo = GetTotemInfo
local UnitExists = UnitExists
local print = print
local select = select
local type = type

a.Costs = {}
function a.SetCost(blood, frost, unholy, death, name, bonusRP, rime)
	a.Costs[s.SpellName(c.GetID(name))] = {
		Blood = blood,
		Frost = frost,
		Unholy = unholy,
		Death = death,
		BonusRP = bonusRP,
		Rime = rime,
	}
end

--a.SetCost(0, 1, 0, 0, "Chains of Ice")
a.SetCost(0, 0, 0, 0, "Empower Rune Weapon", 25)
a.SetCost(0, 0, 0, 0, "Horn of Winter")
a.SetCost(0, 0, 0, 1, "Death Siphon")
a.SetCost(0, 0, 1, 0, "Bone Shield")
a.SetCost(0, 0, 1, 0, "Dark Transformation")
a.SetCost(0, 0, 1, 0, "Death and Decay")
a.SetCost(0, 0, 1, 0, "Plague Strike")
a.SetCost(0, 0, 1, 0, "Scourge Strike")
a.SetCost(0, 1, 0, 0, "Howling Blast", nil, true)
a.SetCost(0, 1, 0, 0, "Icy Touch", nil, true)
a.SetCost(0, 1, 0, 0, "Pillar of Frost")
a.SetCost(0, 1, 1, 0, "Death Strike")
a.SetCost(0, 1, 1, 0, "Obliterate")
a.SetCost(1, 0, 0, 0, "Blood Boil")
a.SetCost(1, 0, 0, 0, "Heart Strike")
a.SetCost(1, 0, 0, 0, "Pestilence")
a.SetCost(1, 0, 0, 0, "Strangulate")
a.SetCost(1, 1, 0, 0, "Festering Strike")

local function runeAvailable(runeId, delay)
	if delay == nil then
		delay = 0
	end
	if a.Runes[runeId] <= delay then
		return 1
	end
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

local function sufficientRunes(blood, frost, unholy, death, forbidDeath, noGCD)
	local deathAvailable = a.PendingDeathRunes
	local delay = 0
	if noGCD then
		delay = -c.GetBusyTime()
	end
	blood, deathAvailable = fakeConsume(1, delay, blood, deathAvailable)
	blood, deathAvailable = fakeConsume(2, delay, blood, deathAvailable)
	frost, deathAvailable = fakeConsume(5, delay, frost, deathAvailable)
	frost, deathAvailable = fakeConsume(6, delay, frost, deathAvailable)
	unholy, deathAvailable = fakeConsume(3, delay, unholy, deathAvailable)
	unholy, deathAvailable = fakeConsume(4, delay, unholy, deathAvailable)
	if forbidDeath then
		deathAvailable = 0
	end
--c.Debug("sufficientRunes", blood, frost, unholy, death, deathAvailable)
	return blood + frost + unholy + death <= deathAvailable
end

local function sufficientResources(id, noGCD)
	local name = s.SpellName(id)
	local cost = a.Costs[name]
	if cost then
		local frost = cost.Rime and a.FreezingFog > 0 and 0 or cost.Frost
		if not sufficientRunes(
			cost.Blood, frost, cost.Unholy, cost.Death, false, noGCD) then
			
--c.Debug("sufficientResources", name)
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
		or (c.HasSpell("Scarlet Fever")
			and c.IsCasting("Blood Boil")
			and s.MyDebuff(c.GetID("Frost Fever"))
		or (c.HasSpell("Ebon Plaguebringer")
			and c.IsAuraPendingFor("Plague Strike")))
end

local function hasBloodPlague(earlyRefresh)
	if c.IsCasting("Plague Leech") then
		return false
	end
	
	return c.GetMyDebuffDuration("Blood Plague") > earlyRefresh
		or c.IsAuraPendingFor("Outbreak")
		or c.IsAuraPendingFor("Plague Strike")
		or GetTime() - a.BloodPlagueRefreshPending < .8
		or c.HasBuff("Unholy Blight")
		or c.IsCasting("Unholy Blight")
		or (c.IsCasting("Blood Boil")
			and s.MyDebuff(c.GetID("Blood Plague"))
			and c.HasSpell("Scarlet Fever"))
end

local function hasBothDiseases(earlyRefresh)
	return hasFrostFever(earlyRefresh) and hasBloodPlague(earlyRefresh)
end

local function shouldStrikeForResources()
	if c.HasTalent("Blood Tap") then
		return a.BloodCharges <= 10
			or c.GetBuffDuration("Blood Charge") < 5
	elseif c.HasTalent("Runic Empowerment") then
		return hasFullyDepleted(1, 2, 3, 4, 5, 6)
	elseif c.HasTalent("Runic Corruption") then
		return c.GetBuffDuration("Runic Corruption") == 0
	end
end

local function soulReaperIsReady(delay)
	if type(delay) ~= "number" then
		delay = 0
	end
	
	return a.InExecute
		and GetTime() + c.GetBusyTime() + delay - a.LastSoulReaper >= 6
		and s.MeleeDistance()
		and not c.IsCasting(
			"Soul Reaper - Frost", 
			"Soul Reaper - Unholy", 
			"Soul Reaper - Blood")
end

c.AddSpell("Horn of Winter", nil, {
	Cooldown = 20,
	CheckFirst = function()
		return s.MaxPower("player") - a.RP > a.HornOfWinterBonus()
	end
})

c.AddOptionalSpell("Empower Rune Weapon", nil, {
	NoGCD = true,
	FlashSize = s.FlashSizePercent() / 2,
})

c.AddOptionalSpell("Empower Rune Weapon", "when low", {
	NoGCD = true,
	FlashSize = s.FlashSizePercent() / 2,
	CheckFirst = function()
		return not (runeAvailable(1)
				or runeAvailable(2)
				or runeAvailable(5)
				or runeAvailable(6)
				or runeAvailable(3)
				or runeAvailable(4))
			and a.PendingDeathRunes == 0
			and a.RP < 32
	end
})

c.AddOptionalSpell("Blood Tap", nil, {
	NoGCD = true,
	CheckFirst = function()
		return a.BloodCharges >= 5 
			and hasFullyDepleted(1, 2, 3, 4, 5, 6)
	end
})

c.AddOptionalSpell("Blood Tap", "at 11", {
	NoGCD = true,
	CheckFirst = function()
		return a.BloodCharges >= 11
			and hasFullyDepleted(1, 2, 3, 4, 5, 6)
	end
})

addOptionalSpell("Death Siphon", nil, {
	CheckFirst = function()
		return c.GetHealthPercent("player") < 80
	end
})

c.AddSpell("Outbreak", nil, {
	Applies = { "Blood Plague", "Frost Fever" },
	CheckFirst = function()
		return not hasBothDiseases(0)
	end
})

c.AddSpell("Outbreak", "at 2", {
	CheckFirst = function()
		return c.GetCooldown("Outbreak") == 0 and not hasBothDiseases(2)
	end
})

c.AddSpell("Outbreak", "at 3", {
	CheckFirst = function()
		return c.GetCooldown("Outbreak") == 0 and not hasBothDiseases(3)
	end
})

c.AddSpell("Unholy Blight", nil, {
	Melee = true,
	CheckFirst = function()
		return c.GetCooldown("Unholy Blight") == 0 and not hasBothDiseases(0)
	end
})

c.AddSpell("Unholy Blight", "at 2", {
	Melee = true,
	CheckFirst = function()
		return c.GetCooldown("Unholy Blight") == 0 and not hasBothDiseases(2)
	end
})

c.AddSpell("Unholy Blight", "at 3", {
	Melee = true,
	CheckFirst = function()
		return c.GetCooldown("Unholy Blight") == 0 and not hasBothDiseases(3)
	end
})

local function canPlagueLeech()
	if not hasBothDiseases(0) then
		return false
	end
	
	local spec = GetSpecialization()
	if spec == 3 then -- unholy spec
		return hasFullyDepleted(1, 2, 5, 6) -- blood & frost runes
	else -- blood or frost spec
		return hasFullyDepleted(5, 6, 3, 4) -- frost & unholy runes
	end
end

c.AddSpell("Plague Leech", nil, {
	CheckFirst = canPlagueLeech,
})

c.AddSpell("Plague Leech", "at 1", {
	CheckFirst = function()
		return canPlagueLeech() and not hasBothDiseases(1)
	end
})

c.AddSpell("Plague Leech", "at 2", {
	CheckFirst = function()
		return canPlagueLeech() and not hasBothDiseases(2)
	end
})

c.AddSpell("Plague Leech", "at 3", {
	CheckFirst = function()
		return canPlagueLeech() and not hasBothDiseases(3)
	end
})

c.AddSpell("Plague Leech", "if Outbreak", {
	CheckFirst = function()
		return canPlagueLeech() and c.GetCooldown("Outbreak", false, 60) < 1 
	end
})

addSpell("Plague Strike", "for Blood Plague", {
	Applies = { "Blood Plague" },
	CheckFirst = function()
		return not hasBloodPlague(0)
	end
})

c.AddOptionalSpell("Raise Dead", nil, {
	NoRangeCheck = 1,
	CheckFirst = function()
		return not UnitExists("pet")
	end
})

addOptionalSpell("Death and Decay", nil, {
	NoRangeCheck = true,
	CheckFirst = function()
		return c.GetCooldown("Death and Decay", false, 30) == 0
	end
})

c.AddOptionalSpell("Horn of Winter", "for Buff, Optional", {
	Cooldown = 20,
	CheckFirst = function()
		return c.RaidBuffNeeded(c.ATTACK_POWER_BUFFS)
	end
})

c.AddInterrupt("Mind Freeze", nil, {
	NoGCD = true,
})

c.AddInterrupt("Asphyxiate")

c.AddInterrupt("Strangulate", nil, {
	NoGCD = true,
})

------------------------------------------------------------------------- Blood
local function canBloodTapForDeathStrike()
	local frost = 0
	local unholy = 0
	local death = a.PendingDeathRunes
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
	return (frost + unholy + death == 1)
		or (death == 0 and (
				(frost == 0 and unholy > 0)
			or (unholy == 0 and frost > 0)))
end

local function getDeathStrikeHeal(forceUseScentStacks)
	local stack = c.GetBuffStack("Scent of Blood")
	if not forceUseScentStacks and c.IsCasting("Death Strike") then
		stack = 0
	end
	local heal = 7 * (1 + .2 * stack)
	if c.WearingSet(2, "BloodT14") then
		heal = heal * 1.1
	end
	return heal 
end

function a.ShouldDeathStrikeForHealth()
	local health = c.GetHealthPercent("player") + getDeathStrikeHeal()
	if c.IsCasting("Death Strike") then
		health = health + getDeathStrikeHeal(true)
	end
	return health < 100
end

local function shouldDeathStrikeForShield()
	return c.GetBuffDuration("Blood Shield") < 2
		and not c.IsCasting("Death Strike")
end

c.AddOptionalSpell("Blood Presence", nil, {
	Type = "form"
})

addSpell("Death Strike")

addSpell("Death Strike", "for Health", {
	CheckFirst = a.ShouldDeathStrikeForHealth
})

addSpell("Death Strike", "to Save Shield", {
	CheckFirst = shouldDeathStrikeForShield
})

addSpell("Death Strike", "if Two Available", {
	CheckFirst = function()
		local avail = a.PendingDeathRunes
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
		if a.BloodCharges >= 10 then
			avail = avail + 2
		elseif a.BloodCharges >= 5 then
			avail = avail + 1
		end
		return avail >= 4
	end
})

c.AddOptionalSpell("Blood Tap", "for Death Strike", {
	NoGCD = true,
	Melee = true,
	CheckFirst = function()
		return a.BloodCharges >= 5
			and (a.ShouldDeathStrikeForHealth() or shouldDeathStrikeForShield())
			and canBloodTapForDeathStrike()
	end
})

addSpell("Death Siphon", "for Health", {
	CheckFirst = function()
		-- use the same criteria as for Death Strike, so we know Death Siphon
		-- is only used when Death Strike cannot be
		return a.ShouldDeathStrikeForHealth()
	end
})

c.AddSpell("Outbreak", "for Weakened Blows", {
	Debuff = c.WEAKENED_BLOWS_DEBUFFS,
	CheckFirst = function()
		return not hasBloodPlague(10)
	end,
})

c.AddSpell("Outbreak", "Early", {
	CheckFirst = function()
		return not hasBothDiseases(5)
	end
})

addSpell("Plague Strike", "for Weakened Blows", {
	Debuff = c.WEAKENED_BLOWS_DEBUFFS,
	CheckFirst = function()
		return not hasBloodPlague(10)
	end,
})

addSpell("Rune Strike")

addSpell("Rune Strike", "for Resources", {
	CheckFirst = shouldStrikeForResources
})

addSpell("Rune Strike", "for Resources if Capped", {
	CheckFirst = function()
		return s.MaxPower("player") - a.RP < 40 
			and (shouldStrikeForResources() or c.HasTalent("Runic Corruption"))
	end
})

addSpell("Rune Strike", "for Runic Corruption", {
	CheckFirst = function()
		return c.HasTalent("Runic Corruption")
	end
})

addOptionalSpell("Death and Decay", "Free", {
	NoRangeCheck = true,
	CheckFirst = function()
		return a.CrimsonScourge
			and c.GetCooldown("Death and Decay", false, 30) == 0
	end
})

addOptionalSpell("Death and Decay", "without Consequence", {
	NoRangeCheck = true,
	CheckFirst = function()
		return c.AoE
			and a.CrimsonScourge
			and hasBothDiseases(15)
			and c.GetCooldown("Death and Decay", false, 30) == 0
	end
})

c.AddSpell("Blood Boil", "for Runic Power", {
	Melee = true,
	Override = function()
		return not a.CrimsonScourge 
			and s.MaxPower("player") - a.RP >= 30 
			and sufficientRunes(1, 0, 0, 0, true)
	end
})

c.AddSpell("Blood Boil", "Free", {
	Melee = true,
	Override = function()
		return a.CrimsonScourge
	end
})

c.AddSpell("Blood Boil", "for Weakened Blows", {
	Melee = true,
	Override = function(z)
		if not hasBloodPlague(0) 
			or hasBloodPlague(10) 
			or not c.HasSpell("Scarlet Fever") then
			
			return false
		end
		
		local duration = c.GetDebuffDuration(c.WEAKENED_BLOWS_DEBUFFS)
		if a.CrimsonScourge then
			return duration <= 5
		end
		
		if not sufficientResources(z.ID) then
			return false
		end
		
		if duration <= 5 and c.GetCooldown("Outbreak") > duration then
			return true
		end
		
		return c.HasMyDebuff("Frost Fever")
			and sufficientRunes(1, 0, 0, 0, true)
	end
})

c.AddSpell("Blood Boil", "for AoE or Free", {
	Melee = true,
	Override = function(z)
		if a.CrimsonScourge then
			z.Continue = false
			return true
		elseif sufficientResources(z.ID) then
			z.Continue = true
			return true
		end
	end
})

c.AddSpell("Blood Boil", "for AoE B or Free", {
	Melee = true,
	Override = function(z)
		if a.CrimsonScourge then
			z.Continue = false
			return true
		elseif sufficientRunes(1, 0, 0, 0, true) then
			z.Continue = true
			return true
		end
	end
})

c.AddSpell("Horn of Winter", "for Buff", {
	Cooldown = 20,
	CheckFirst = function()
		return c.RaidBuffNeeded(c.ATTACK_POWER_BUFFS)
	end
})

c.AddSpell("Horn of Winter", "for Runic Power", {
	Cooldown = 20,
	CheckFirst = function()
		return s.MaxPower("player") - a.RP >= 20 + a.HornOfWinterBonus()
	end
})

addSpell("Soul Reaper - Blood", nil, {
	CheckFirst = soulReaperIsReady,
})

c.AddSpell("Soul Reaper - Blood", "B", {
	Override = function()
		return soulReaperIsReady() and sufficientRunes(1, 0, 0, 0, true)
	end
})

c.AddSpell("Soul Reaper - Blood", "for Runic Power unless AoE", {
	Override = function()
		return not c.AoE
			and soulReaperIsReady()
			and s.MaxPower("player") - a.RP >= 30
			and sufficientRunes(1, 0, 0, 0, true)
	end
})

c.AddSpell("Soul Reaper - Blood", "BB", {
	Override = function()
		return soulReaperIsReady()
			and a.BothRunesAvailable("Blood", 1)
			and not a.IsDeathRune(1)
			and not a.IsDeathRune(2)
	end
})

addSpell("Heart Strike", nil, {
	Melee = true,
})

c.AddSpell("Heart Strike", "for Runic Power unless AoE", {
	Melee = true,
	Override = function()
		return not c.AoE
			and s.MaxPower("player") - a.RP >= 30
			and sufficientRunes(1, 0, 0, 0, true)
	end
})

c.AddSpell("Heart Strike", "BB", {
	Melee = true,
	Override = function()
		return a.BothRunesAvailable("Blood", 1)
			and not a.IsDeathRune(1)
			and not a.IsDeathRune(2)
	end
})

c.AddSpell("Heart Strike", "B", {
	Melee = true,
	Override = function()
		return sufficientRunes(1, 0, 0, 0, true)
	end
})

addSpell("Icy Touch", "for Frost Fever", {
	Applies = { "Frost Fever" },
	CheckFirst = function()
		return not hasFrostFever(0)
	end
})

c.AddOptionalSpell("Rune Tap", nil, {
	NoGCD = true,
	CheckFirst = function()
		local damage = 100 - c.GetHealthPercent("player")
		if damage < 10 then
			return false
		end
		
		if a.ShouldDeathStrikeForHealth()
			and sufficientResources(c.GetID("Death Strike")) then
			
			return damage > getDeathStrikeHeal() + 10
		else
			return true
		end
	end
})

c.AddOptionalSpell("Dancing Rune Weapon", nil, {
	NoGCD = true,
	Melee = true,
	CheckFirst = function()
		return not c.WearingSet(4, "BloodT16")
	end,
})

c.AddOptionalSpell("Dancing Rune Weapon", "Prime", {
	NoGCD = true,
	Melee = true,
	CheckFirst = function()
		return (c.WearingSet(4, "BloodT16")
				and (not (runeAvailable(1)
					or runeAvailable(2)
					or runeAvailable(3)
					or runeAvailable(4))))
			or c.InDamageMode()
	end,
})

c.AddOptionalSpell("Bone Shield", nil, {
	CheckFirst = function()
		if s.InCombat() then
			return not c.HasBuff("Bone Shield")
		elseif x.EnemyDetected then
			return c.GetBuffDuration("Bone Shield") < 60
				or s.BuffStack(c.GetID("Bone Shield"), "player") < 6
		end
	end
})

c.AddOptionalSpell("Vampiric Blood", nil, {
	NoGCD = true,
	CheckFirst = function()
		return not c.IsSolo() or sufficientResources(c.GetID("Death Strike"))
	end,
	ShouldHold = function()
		return s.HealthPercent("player") > 85
	end,
})

c.AddOptionalSpell("Death Pact", nil, {
	NoRangeCheck = 1,
	Enabled = function()
		local ghoulIsOut = GetTotemInfo(1)
		return ghoulIsOut
	end,
	ShouldHold = function()
		local ghoulIsOut = GetTotemInfo(1)
		return ghoulIsOut and c.GetHealthPercent("player") > 60
	end
})

c.AddOptionalSpell("Raise Dead", "for Death Pact", {
	NoRangeCheck = 1,
	CheckFirst = function()
		return c.HasTalent("Death Pact") and c.GetCooldown("Raise Dead") < 1
	end
})

c.AddOptionalSpell("Conversion", nil, {
	NoGCD = true,
	Buff = "Conversion",
	CheckFirst = function()
		return a.RP > 50 and not c.HasBuff("Conversion")
	end,
	ShouldHold = function()
		return c.GetHealthPercent("player") > 80
	end
})

c.AddOptionalSpell("Conversion", "Cancel", {
	NoGCD = true,
	FlashColor = "red",
	CheckFirst = function()
		return c.HasBuff("Conversion", true)
			and not a.ShouldDeathStrikeForHealth()
	end
})

c.AddOptionalSpell("Icebound Fortitude", "Unglyphed", {
	Score = 2,
	NoGCD = true,
	Enabled = function()
		return not c.HasGlyph("Icebound Fortitude")
	end,
})

c.AddOptionalSpell("Icebound Fortitude", "Glyphed", {
	Score = 2,
	NoGCD = true,
	Enabled = function()
		return c.HasGlyph("Icebound Fortitude")
	end,
})

c.AddTaunt("Dark Command", nil, {
	NoGCD = true
})

c.AddTaunt("Death Grip", nil, {
	NoGCD = true 
})

------------------------------------------------------------------------- Frost
c.AddOptionalSpell("Frost Presence", nil, { Type = "form" })

c.AddOptionalSpell("Pillar of Frost", nil, { 
	NoGCD = true,
})

addSpell("Frost Strike", nil, {
	Melee = true,
})

addSpell("Frost Strike", "under KM", {
	Melee = true,
	CheckFirst = function()
		return a.KillingMachine
	end
})

addSpell("Frost Strike", "at 88", {
	Melee = true,
	CheckFirst = function()
		return a.KillingMachine and a.RP >= 88
	end
})

addSpell("Frost Strike", "at 76", {
	Melee = true,
	CheckFirst = function()
		return a.KillingMachine and a.RP >= 76
	end
})

addSpell("Frost Strike", "at 40", {
	Melee = true,
	CheckFirst = function()
		return a.RP >= 40
	end
})

addSpell("Frost Strike", "for Resources", {
	Melee = true,
	CheckFirst = shouldStrikeForResources
})

addSpell("Frost Strike", "for Runic Empowerment", {
	Melee = true,
	CheckFirst = function()
		return c.HasTalent("Runic Empowerment") and not hasFullyDepleted(5, 6)
	end
})

--addSpell("Frost Strike", "for Resources unless KM", {
--	Melee = true,
--	CheckFirst = function()
--		return not a.KillingMachine and shouldStrikeForResources()
--	end
--})

addSpell("Soul Reaper - Frost", nil, {
	CheckFirst = soulReaperIsReady,
})

c.AddSpell("Blood Tap", "for Soul Reaper - Frost", {
	NoGCD = true,
	Melee = true,
	FlashID = { "Blood Tap", "Soul Reaper - Frost" },
	CheckFirst = function()
		return soulReaperIsReady()
			and a.BloodCharges >= 5
			and hasFullyDepleted(1, 2, 3, 4, 5, 6)
	end
})

c.AddSpell("Blood Tap", "for OB KM", {
	NoGCD = true,
	Melee = true,
	FlashID = { "Blood Tap", "Obliterate" },
	CheckFirst = function()
		return a.KillingMachine
			and a.BloodCharges >= 5
			and (a.PendingDeathRunes > 0
				or runeAvailable(1)
				or runeAvailable(2)
				or runeAvailable(5)
				or runeAvailable(6)
				or runeAvailable(3)
				or runeAvailable(4))
	end
})

c.AddOptionalSpell("Blood Tap", "at 8 or Non-Execute", {
	NoGCD = true,
	CheckFirst = function()
		if not hasFullyDepleted(1, 2, 3, 4, 5, 6) then
			return false
		end
		
		if a.BloodCharges >= 8 then
			return true
		end
		
		return a.BloodCharges >= 5 and not a.InExecute
	end
})

addSpell("Howling Blast")

addSpell("Howling Blast", "for Frost Fever", {
	Applies = { "Frost Fever" },
	CheckFirst = function()
		return not hasFrostFever(0)
	end
})

addSpell("Howling Blast", "under Freezing Fog", {
	CheckFirst = function()
		return a.FreezingFog > 0
	end
})

addSpell("Howling Blast", "BB or FF", {
	CheckFirst = function()
		return a.BothRunesAvailable("Blood", 1) 
			or a.BothRunesAvailable("Frost", 1)
	end
})

addSpell("Howling Blast", "BB or FF or DU", {
	CheckFirst = function()
		return a.BothRunesAvailable("Blood", 1) 
			or a.BothRunesAvailable("Frost", 1)
			or (a.IsDeathRune(3) and runeAvailable(3) and runeAvailable(4, 1))
			or (a.IsDeathRune(4) and runeAvailable(4) and runeAvailable(3, 1))
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

addSpell("Obliterate", "U w/out KM", {
	CheckFirst = function()
		return hasBothDiseases(0)
			and ((runeAvailable(3) and not a.IsDeathRune(3))
				or (runeAvailable(4) and not a.IsDeathRune(4)))
			and not a.KillingMachine
			and not c.GetOption("Mastersimple")
	end
})

addSpell("Obliterate", "under KM", {
	CheckFirst = function()
		return a.KillingMachine and hasBothDiseases(0)
	end
})

--addSpell("Obliterate", "KM UU", {
--	CheckFirst = function()
--		return a.KillingMachine
--			and a.BothRunesAvailable("Unholy", 1) 
--			and hasBothDiseases(0)
--	end
--})

addSpell("Obliterate", "BB or FF or UU", {
	CheckFirst = function()
		return hasBothDiseases(0)
			and (a.BothRunesAvailable("Blood", 1)
				or a.BothRunesAvailable("Frost", 1)
				or a.BothRunesAvailable("Unholy", 1))
	end
})

addOptionalSpell("Death Coil", "at 60", {
	CheckFirst = function()
		return a.RP >= 60
	end
})

addOptionalSpell("Death and Decay", "U", {
	NoRangeCheck = true,
	CheckFirst = function()
		return c.GetCooldown("Death and Decay", false, 30) == 0 
			and sufficientRunes(0, 0, 1, 0, true)
			and c.GetOption("Mastersimple")
	end
})

addSpell("Plague Strike", "U", {
	CheckFirst = function()
		return sufficientRunes(0, 0, 1, 0, true) and c.GetOption("Mastersimple")
	end
})

addSpell("Plague Strike", "UU", {
	CheckFirst = function()
		return a.BothRunesAvailable("Unholy", 1)
	end
})

addSpell("Plague Strike", "unless RE", {
	CheckFirst = function()
		return not c.HasTalent("Runic Empowerment")
	end
})

------------------------------------------------------------------------ Unholy
c.AddOptionalSpell("Unholy Presence", nil, {
	Type = "form",
})

c.AddOptionalSpell("Unholy Frenzy", nil, {
	NoRangeCheck = 1,
	Melee = 1,
	CheckFirst = function()
		return not s.Buff(c.BLOODLUST_BUFFS, "player")
	end
})

addSpell("Soul Reaper - Unholy", nil, {
	CheckFirst = soulReaperIsReady,
})

c.AddSpell("Blood Tap", "for Soul Reaper - Unholy", {
--	NoGCD = true,
	Melee = true,
	FlashID = { "Blood Tap", "Soul Reaper - Unholy" },
	CheckFirst = function()
		return soulReaperIsReady()
			and a.BloodCharges >= 5
			and hasFullyDepleted(1, 2, 3, 4, 5, 6)
	end
})

addSpell("Plague Strike", "for Both Diseases", {
	CheckFirst = function()
		return not hasBothDiseases(0)
	end
})

addOptionalSpell("Summon Gargoyle", nil, {
	CheckFirst = function()
		return c.GetCooldown("Summon Gargoyle") == 0
	end
})

local function shouldDT()
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

addSpell("Dark Transformation", nil, {
	CheckFirst = shouldDT,
})

c.AddSpell("Blood Tap", "for Dark Transformation", {
--	NoGCD = true,
	FlashID = { "Blood Tap", "Dark Transformation" },
	CheckFirst = function()
		return a.BloodCharges >= 5
			and hasFullyDepleted(1, 2, 3, 4, 5, 6)
			and shouldDT()
	end
})

addSpell("Death Coil", "at 90", {
	CheckFirst = function()
		return a.RP > 90
	end
})

addOptionalSpell("Death and Decay", "UU", {
	NoRangeCheck = true,
	CheckFirst = function()
		return c.GetCooldown("Death and Decay", false, 30) == 0 
			and a.BothRunesAvailable("Unholy", 1)
	end
})

addOptionalSpell("Death and Decay", "unless Soul Reaper", {
	NoRangeCheck = true,
	CheckFirst = function()
		return c.GetCooldown("Death and Decay", false, 30) == 0 
			and (not a.InExecute
				or not soulReaperIsReady(1)
				or sufficientRunes(0, 0, 2, 0, false))
	end
})

c.AddOptionalSpell("Blood Tap", "for D&D", {
--	NoGCD = true,
	FlashID = { "Blood Tap", "Death and Decay" },
	CheckFirst = function()
		return a.BloodCharges >= 5
			and c.GetCooldown("Death and Decay") == 0
			and not sufficientResources(c.GetID("Death and Decay"))
			and not c.IsCasting("Death and Decay")
	end
})

addSpell("Scourge Strike", "UU", {
	CheckFirst = function()
		return a.BothRunesAvailable("Unholy", 1)
	end
})

addSpell("Scourge Strike", "unless Soul Reaper", {
	CheckFirst = function()
		return not a.InExecute
			or not soulReaperIsReady(1)
			or sufficientRunes(0, 0, 2, 0, false)
	end
})

addSpell("Festering Strike", nil, {
	CheckFirst = function()
		return sufficientRunes(1, 1, 0, 0, true)
	end
})

addSpell("Festering Strike", "BBFF", {
	CheckFirst = function()
		return a.BothRunesAvailable("Blood", 1)
			or a.BothRunesAvailable("Frost", 1)
	end
})

addSpell("Death Coil", "under Sudden Doom or for Dark Transformation", {
	CheckFirst = function()
		if c.HasBuff("Sudden Doom") and not c.IsCasting("Death Coil") then
			return true
		end
		
		if GetTime() - a.DTCast < .8
			or s.BuffDuration(c.GetID("Dark Transformation"), "pet")
				> c.GetBusyTime()
			or c.IsCasting("Dark Transformation") then
			
			return false
		end
		
		-- make sure unholy runes stay on cooldown?
		local runes = a.PendingDeathRunes
		if runeAvailable(1, 1) and a.IsDeathRune(1) then
			runes = runes + 1
		end
		if runeAvailable(2, 1) and a.IsDeathRune(2) then
			runes = runes + 1
		end
		if runeAvailable(5, 1) and a.IsDeathRune(5) then
			runes = runes + 1
		end
		if runeAvailable(6, 1) and a.IsDeathRune(6) then
			runes = runes + 1
		end
		if runeAvailable(3, 1) then
			runes = runes + 1
		end
		if runeAvailable(4, 1) then
			runes = runes + 1
		end
		return runes <= 1
	end
})

addSpell("Death Coil", "unless Gargoyle or Dark Transformation", {
	CheckFirst = function()
		local dt
		if c.IsAuraPendingFor("Dark Transformation") then
			dt = 30
		else
			dt = s.BuffDuration(c.GetID("Dark Transformation"), "pet")
				- c.GetBusyTime()
			if dt <= 0 then
				return true
			end
		end
		
		return dt > 8 
			and (c.GetCooldown("Summon Gargoyle") > 8 
				or c.IsCasting("Summon Gargoyle"))
	end
})

c.AddOptionalSpell("Blood Tap", "at 8 or for Dark Transformation", {
	NoGCD = true,
	CheckFirst = function()
		if a.InExecute or not hasFullyDepleted(1, 2, 3, 4, 5, 6) then
			return false
		end
		
		if a.BloodCharges >= 8 then
			return true
		end
		
		return a.BloodCharges >= 5 
			and s.BuffDuration(c.GetID("Dark Transformation"), "pet")
				<= c.GetBusyTime()
	end
})
