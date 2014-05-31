local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local x = s.UpdatedVariables
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetComboPoints = GetComboPoints
local GetSpellBonusHealing = GetSpellBonusHealing
local GetSpellCharges = GetSpellCharges
local GetTime = GetTime
local UnitAttackPower = UnitAttackPower
local UnitHealthMax = UnitHealthMax
local UnitInRange = UnitInRange
local UnitIsUnit = UnitIsUnit
local UnitPower = UnitPower
local UnitPowerMax = UnitPowerMax
local UnitStat = UnitStat
local select = select
local math = math

local function substantialFight()
	return a.Substantial
end

local function forceOfNatureCheck(z)
	local charges, untilNext, untilMax = c.GetChargeInfo(z.ID, true)
	return untilMax < 1	
end

local function setFaerieID(z)
	z.Name = nil
	if c.HasTalent("Faerie Swarm") then
		z.ID = c.GetID("Faerie Swarm")
	else
		z.ID = c.GetID("Faerie Fire")
	end
end

local function canTakeHealingTouch()
	local heal = 21800 + 1.86 * GetSpellBonusHealing()
	if c.HasTalent("Dream of Cenarius") then
		heal = 1.2 * heal
	end
	return c.GetHealth("player") + heal < UnitHealthMax("player")
end

------------------------------------------------------------------------ Common
c.AddOptionalSpell("Mark of the Wild", nil, {
	Override = function()
		return c.RaidBuffNeeded(c.STAT_BUFFS)
	end
})

c.AddOptionalSpell("Symbiosis", nil, {
	Override = function()
		if c.GetBuffDuration(a.SymbiosisSelfBuffs) > 5 * 60 then
			return false
		end
		for member in c.GetGroupMembers() do
			if not UnitIsUnit(member, "player") 
				and UnitInRange(member) 
				and (s.MyBuff(a.SymbiosisRaidBuffs, member)
					or not s.Buff(a.SymbiosisRaidBuffs, member)) then
				
				return true
			end
		end
	end
})

c.AddSpell("Faerie Fire", nil, {
	RunFirst = setFaerieID,
	Cooldown = 6,
})

c.AddOptionalSpell("Faerie Fire", "for Debuff", {
	Debuff = c.ARMOR_DEBUFFS,
	EarlyRefresh = 5,
	RunFirst = setFaerieID,
	CheckFirst = substantialFight,
})

c.AddOptionalSpell("Healing Touch", "Solo", {
	NoRangeCheck = true,
	CheckFirst = canTakeHealingTouch,
})

c.AddOptionalSpell("Nature's Vigil", nil, {
	NoRangeCheck = true,
	NoGCD = true,
})

c.AddOptionalSpell("Renewal", nil, {
	NoGCD = true,
	CheckFirst = function()
		return c.GetHealthPercent("player") < 70
	end,
})

c.AddDispel("Soothe", nil, "")

c.AddInterrupt("Skull Bash", nil, {
	NoGCD = true,
})

----------------------------------------------------------------------- Balance
c.AddOptionalSpell("Moonkin Form", nil, {
	Type = "form",
	CheckFirst = function()
		return x.EnemyDetected
	end,
})

c.AddOptionalSpell("Force of Nature: Balance", nil, {
	FlashID = { "Force of Nature", "Force of Nature: Balance" },
	NoGCD = true,
	CheckFirst = forceOfNatureCheck,
})

c.AddOptionalSpell("Incarnation: Chosen of Elune", nil, {
	CheckFirst = function()
		return a.Energy >= 100 or a.Energy <= -100
	end
})

c.AddOptionalSpell("Celestial Alignment", nil, {
	Override = function()
		if a.Lunar 
			or a.Solar
			or c.GetCooldown("Celestial Alignment", false, 180) > 0
			or c.GetCooldown("Incarnation: Chosen of Elune", false, 180) 
				< 10 then
			
			return false
		end
		
		if not c.HasBuff("Starfall") then
			c.PredictFlash("Starfall")
		end
		if not c.HasBuff("Shooting Stars") then
			c.PredictFlash("Moonfire")
		end
		return true
	end
})

c.AddOptionalSpell("Starfall", nil, {
	Override = function(z)
		if c.GetCooldown("Incarnation: Chosen of Elune") > 15 then
			z.FlashSize = nil
		elseif not a.GoingUp
			and (a.Energy <= -70 
				or (c.GetCooldown("Starsurge") == 0 and a.Energy <= -60)) then
			
			z.FlashSize = s.FlashSizePercent() / 2
		else
			return false
		end
		return not c.HasBuff("Starfall")
			and (c.GetCooldown("Starfall") == 0
				or (a.EclipsePending and a.Lunar))
	end
})

c.AddOptionalSpell("Wild Mushroom: Detonate", nil, {
	NoRangeCheck = true,
	NoGCD = true,
	CheckFirst = function()
		return a.Solar and not c.IsMissingTotem(3)
	end
})

c.AddSpell("Astral Communion", "Instant", {
	CheckFirst = function()
		return c.HasBuff("Astral Insight")
			and ((a.GoingUp and not a.Lunar and a.Energy < 70)
				or (not a.GoingUp and not a.Solar and a.Energy > -60))
			and not c.IsCasting("Astral Communion")
	end
})

c.AddSpell("Starsurge", nil, {
	NotIfActive = true,
})

c.AddSpell("Starsurge", "under Shooting Stars", {
	CheckFirst = function()
		return c.HasBuff("Shooting Stars")
	end
})

local function notCastThisEclipse(duration)
	return a.EclipsePending
		or duration < c.GetBuffDuration("Nature's Grace") - 2
end

local function dotCheck(z, duration, tick, desiredEclipse, minEnergy, maxEnergy)
	if not desiredEclipse or duration > (a.LunarShower > 0 and tick or 0) then
		return false
	end
	
	local hold = c.GetCooldown("Celestial Alignment") < 2
		and (a.Energy < minEnergy or a.Energy > maxEnergy)
	c.MakeOptional(z, hold)
	c.MakeMini(z, hold)
	return true 
end

c.AddSpell("Moonfire", nil, {
	CheckFirst = function(z)
		return dotCheck(z, a.Moonfire, a.MoonfireTick, a.Solar, 40, 999)
	end
})

c.AddSpell("Moonfire", "under Eclipse", {
	CheckFirst = function(z)
		return a.Lunar 
			and (notCastThisEclipse(a.Moonfire) or a.Moonfire < a.MoonfireTick)
	end
})

c.AddSpell("Sunfire", nil, {
	CheckFirst = function(z)
		return dotCheck(z, a.Sunfire, a.SunfireTick, a.Lunar, -999, -40)
	end
})

c.AddSpell("Sunfire", "under Eclipse", {
	CheckFirst = function(z)
		return a.Solar 
			and (notCastThisEclipse(a.Sunfire) or a.Sunfire < a.SunfireTick)
	end
})

c.AddSpell("Wrath", "under Celestial Alignment", {
	CheckFirst = function()
		return a.Alignment > c.GetCastTime("Wrath") + .1
	end
})

c.AddSpell("Starfire", nil, {
	CheckFirst = function()
		return a.GoingUp
	end
})

c.AddSpell("Starfire", "under Celestial Alignment", {
	CheckFirst = function()
		return a.Alignment > c.GetCastTime("Starfire") + .1
	end
})

c.AddInterrupt("Solar Beam")

------------------------------------------------------------------------- Feral
local function getDelay(cost, usesCC)
	if usesCC and a.Clearcasting then
		return 0
	end
	
	if a.Berserk > 0 then
		local delay = (cost / 2 - a.Energy) / a.Regen
		if delay < a.Berserk then
			return math.max(0, delay)
		end
	end
	
	return math.max(0, (cost - a.Energy) / a.Regen)
end

local function modForDelay(spell, cost, usesCC)
	local delay = getDelay(cost, usesCC)
	c.MakePredictor(spell, delay > 0)
	return delay
end

c.AddSpell("Survival Instincts", "under 30", {
	NoGCD = true,
	FlashColor = "red",
	CheckFirst = function()
		return c.GetHealthPercent("player") < 30
	end
})

c.AddSpell("Barkskin", "under 30", {
	NoGCD = true,
	FlashColor = "red",
	CheckFirst = function()
		return c.GetHealthPercent("player") < 30
	end
})

c.AddOptionalSpell("Force of Nature: Feral", nil, {
	FlashID = { "Force of Nature", "Force of Nature: Feral" },
	NoGCD = true,
	CheckFirst = forceOfNatureCheck,
})

c.AddOptionalSpell("Maul", "for Feral", {
	Melee = true,
	NoGCD = true,
	Override = function(z)
		c.MakePredictor(z, c.GetCooldown("Maul", true) > 0)
		return true
	end,
})

c.AddOptionalSpell("Heart of the Wild", nil, {
	Melee = true,
	FlashSize = s.FlashSizePercent() / 2,
})

c.AddSpell("Thrash(Bear Form)", "for Feral", {
	FlashID = { "Thrash", "Thrash(Bear Form)", "Thrash(Cat Form)" },
	Melee = true,
	NotWhileActive = true,
	CheckFirst = function()
		return (c.GetMyDebuffDuration("Thrash(Bear Form)", false, true, true)
					< 2
				and a.Substantial)
			or c.AoE
	end,
})

c.AddSpell("Thrash(Bear Form)", "for Feral AoE", {
	FlashID = { "Thrash", "Thrash(Bear Form)", "Thrash(Cat Form)" },
	Melee = true,
	Cooldown = 6,
	CheckFirst = substantialFight,
})

c.AddSpell("Mangle(Bear Form)", "for Feral", {
	FlashID = { "Mangle", "Mangle(Bear Form)", "Mangle(Cat Form)" },
	CheckFirst = function()
		return a.TimeToCap > (a.Clearcasting and 4 or 3)
	end
})

c.AddSpell("Cat Form", nil, {
	Type = "form",
	CheckFirst = function(z)
		if not x.EnemyDetected then
			return false
		end
		
		-- If you change these, also adjust conditions in Swipe(Bear Form) Prime
		if not s.Form(c.GetID("Bear Form")) 
			or a.TimeToCap < (a.Clearcasting and 4 or 3) then
			
			return true
		elseif c.AoE then
			return c.GetMyDebuffDuration("Thrash(Cat Form)", false, true) < 3
		else
			return a.MinRip < (a.CP == 0 and 4 or 3) and a.Substantial
		end
	end,
})

c.AddOptionalSpell("Tiger's Fury", nil, {
	NoGCD = true,
	CheckFirst = function()
		return a.Energy <= 35 
			and not a.Clearcasting
			and a.Berserk == 0
	end
})

local function furySync(z, maxDelay)
	local wait = a.TigersFury == 0 
		and a.Substantial 
		and (not maxDelay or a.TigerCool < maxDelay)
	c.MakePredictor(z, wait, "yellow")
	return (a.TigersFury > 0 or a.TigerCool == 0) 
		or (wait and a.TigerCool < 3) 
		or not a.Substantial
end

c.AddOptionalSpell("Berserk", nil, {
	NoGCD = true,
	Cooldown = 180,
	CheckFirst = function(z)
		return furySync(z, 6)
	end
})

c.AddOptionalSpell("Incarnation: King of the Jungle")

c.AddSpell("Healing Touch", "for Dream", {
	Override = function()
		return a.DreamStacks <= 0
			and a.Swiftness > 0
			and a.Energy + a.Regen < 100
			and c.HasTalent("Dream of Cenarius")
	end
})

c.AddSpell("Healing Touch", "for Vigil", {
	Override = function()
		return a.Swiftness > 0
			and a.Energy < 35
			and a.Vigil > 0
	end
})

c.AddOptionalSpell("Healing Touch", "for Feral Heal", {
	Override = function()
		return a.Swiftness > 0
			and a.TimeToCap > (a.Clearcasting and 2 or 1)
			and c.GetHealthPercent("player") < 85
			and not c.HasTalent("Dream of Cenarius")
	end
})

local function setRoarId(spell)
	if c.HasGlyph("Savagery") then
		spell.ID = c.GetID("Savage Roar Glyphed")
	else
		spell.ID = c.GetID("Savage Roar Unglyphed")
	end
end

c.AddSpell("Savage Roar", nil, {
	RunFirst = setRoarId,
	Override = function(z)
		return (a.CP > 0 or c.HasGlyph("Savagery"))
			and modForDelay(z, 25) >= a.Roar
	end,
})

c.AddSpell("Savage Roar", "Early", {
	RunFirst = setRoarId,
	Override = function(z)
		return a.CP == 5
			and a.Roar < a.Rip + 2
			and a.Roar - modForDelay(z, 25) < 6
			and a.Substantial
	end
})

c.AddSpell("Savage Roar", "for AoE", {
	RunFirst = setRoarId,
	Override = function(z)
		return (a.CP > 0 or c.HasGlyph("Savagery"))
			and (modForDelay(z, 25) >= a.Roar
				or (a.CP == 5 and a.Roar < 10))
	end,
})

c.AddSpell("Ferocious Bite", nil, {
	Melee = true,
	Override = function(z)
		local delay = modForDelay(z, 25, true)
		return a.CP == 5
			and (a.InExecute or a.Rip - delay > 6 or not a.Substantial)
	end
})

c.AddSpell("Ferocious Bite", "on Last Tick", {
	Melee = true,
	Override = function(z)
		local rip = a.Rip - modForDelay(z, 25, true)
		return a.InExecute and a.CP > 0 and rip > .1 and rip < 4
	end
})

c.AddSpell("Ferocious Bite", "for AoE", {
	Melee = true,
	Override = function(z)
		local delay = modForDelay(z, 25, true)
		return a.CP == 5
			and a.InExecute
			and a.Rip - delay < 10 
			and a.Substantial
	end
})

local function swiftable()
	return a.Swiftness == 0
		and a.DreamStacks == 0
		and a.CP == 5
		and a.Energy + a.Regen < 100
		and c.HasTalent("Dream of Cenarius")
		and a.Substantial
end

c.AddSpell("Rip", nil, {
	Melee = true,
	Override = function(z)
		return a.CP == 5
			and (not a.InExecute or a.Rip == 0)
			and a.Rip - modForDelay(z, 30, true) < 2
			and a.Substantial
	end
})

c.MakePredictor(c.AddSpell("Rip", "Delay", {
	Melee = true,
	Override = function()
		return not a.InExecute
			and a.CP == 5
			and a.TimeToCap > a.Rip + 1
			and a.Substantial
	end
}))

c.AddSpell("Rake", nil, {
	Melee = true,
	Override = function(z)
		local dur = a.Rake - modForDelay(z, 35, true)
		return dur < 3 or (dur < 6 and a.DreamStacks == 1 and a.CP >= 4)
	end
})

c.AddSpell("Thrash(Cat Form)", nil, {
	FlashID = { "Thrash", "Thrash(Bear Form)", "Thrash(Cat Form)" },
	Melee = true,
	Override = function()
		return getDelay(50, true) == 0
			and c.GetMyDebuffDuration("Thrash(Cat Form)", false, true, true) < 3
			and (a.Clearcasting or a.Rip > 7 or a.CP == 5)
			and a.Substantial
	end
})

c.AddSpell("Thrash(Cat Form)", "for AoE", {
	FlashID = { "Thrash", "Thrash(Bear Form)", "Thrash(Cat Form)" },
	Melee = true,
	Override = function(z)
		return c.GetMyDebuffDuration("Thrash(Cat Form)", false, true, true)
				- modForDelay(z, 50, true) 
			< 3
	end
})

c.AddSpell("Ravage", nil, {
	FlashID = { "Ravage", "Ravage!" },
	Melee = true,
	Override = function(z)
		return modForDelay(z, 45, true) < a.King
	end
})

c.AddSpell("Shred", nil, {
	FlashID = { "Shred", "Shred!" },
	Melee = true,
	Override = function(z)
		local delay = modForDelay(z, 40, true)
		local _, targetID = s.UnitInfo()
		return (a.Clearcasting or a.Berserk > delay or a.Regen > 15)
			and (not (a.NoShred[targetID] or c.IsTanking())
				or (c.HasGlyph("Shred") 
					and (a.TigersFury > delay or a.Berserk > delay)))
	end
})

c.AddSpell("Mangle(Cat Form)", nil, {
	FlashID = { "Mangle", "Mangle(Bear Form)", "Mangle(Cat Form)" },
	Melee = true,
	Override = function(z)
		modForDelay(z, 35, true)
		return true
	end
})

c.AddOptionalSpell("Bear Form", "for Feral", {
	Type = "form",
	Melee = true,
	NotWhileActive = true,
	CheckFirst = function()
		if a.Energy >= 35
			or a.TimeToCap < 4
			or a.Berserk > 0 then
			
			return false
		elseif c.AoE then
			return c.GetMyDebuffDuration("Thrash(Cat Form)", false, false, true)
					> 4.5
				and a.TigerCool > 4.5
		elseif a.Substantial then
			return a.MinRip > (a.CP == 0 and 4.5 or 5.5)
					and a.Rake > 4.5
					and a.TigerCool > 4.5
		else
			return a.TigerCool > 0
		end
	end
})

c.AddOptionalSpell("Bear Form", "for Feral AoE", {
	Type = "form",
	Melee = true,
	NotWhileActive = true,
	CheckFirst = function()
		return a.Energy < 45
			and a.TimeToCap > 4
			and a.Berserk == 0 
			and c.GetMyDebuffDuration("Thrash(Cat Form)", false, false, true)
					> 4
			and a.TigerCool > 4
	end
})

c.AddSpell("Swipe(Bear Form)", "for Feral", {
	FlashID = { "Swipe", "Swipe(Bear Form)", "Swipe(Cat Form)" },
	Melee = true,
	NotWhileActive = true,
	CheckFirst = function()
		return c.AoE
	end,
})

c.AddSpell("Swipe(Bear Form)", "Prime for Feral", {
	FlashID = { "Swipe", "Swipe(Bear Form)", "Swipe(Cat Form)" },
	Melee = true,
	NotWhileActive = true,
	CheckFirst = function()
		return c.AoE
			and a.TimeToCap > (a.Clearcasting and 5.5 or 4.5) 
			and c.GetMyDebuffDuration("Thrash(Cat Form)", false, true) > 4.5
	end,
})

c.AddSpell("Swipe(Cat Form)", "for Feral", {
	FlashID = { "Swipe", "Swipe(Bear Form)", "Swipe(Cat Form)" },
	Melee = true,
	Override = function(z)
		modForDelay(z, 45, true)
		return true
	end
})

--------------------------------- beta

c.AddSpell("Ravage", "under Stealth", {
	FlashID = { "Ravage", "Ravage!" },
	Melee = true,
	GetDelay = function(z)
		local _, targetID = s.UnitInfo()
		return not a.NoShred[targetID] 
			and c.HasBuff("Prowl") 
			and not c.IsTanking() 
			and getDelay(45, true)
	end
})

c.AddSpell("Ravage", "Filler", {
	FlashID = { "Ravage", "Ravage!" },
	Melee = true,
	GetDelay = function()
		local delay = getDelay(45, true)
		return a.King > delay and delay
	end
})

c.AddSpell("Healing Touch", "for Feral Beta", {
	NoRangeCheck = true,
	WhiteFlashOffset = -1,
	GetDelay = function(z)
		c.MakeOptional(z, a.Vigil == 0)
		return a.Swiftness > 0
			and (a.Vigil > 0 or c.GetHealthPercent("player") < 85)
			and 1
	end,
})

c.AddSpell("Healing Touch", "for Dream Beta", {
	NoRangeCheck = true,
	GetDelay = function()
		if a.DreamStacks > 0 
			or not c.HasTalent("Dream of Cenarius") 
			or a.Swiftness == 0 then
			
			return false
		elseif a.CP >= 4 then
			return 0
		else
			return a.Swiftness - 1.5
		end
	end,
})

c.AddSpell("Ferocious Bite", "on Last Tick Beta", {
	Melee = true,
	GetDelay = function()
		local delay = getDelay(25, true)
		return a.InExecute 
			and a.CP > 0 
			and a.Rip - delay > .1 
			and math.max(a.Rip - 3, delay)
	end
})

c.AddSpell("Ferocious Bite", "in Execute Pooling", {
	Melee = true,
	IsMinDelayDefinition = true,
	GetDelay = function()
		return a.InExecute 
			and a.CP == 5
			and a.Substantial
			and math.min(a.Rip, getDelay(50))
	end
})

c.AddSpell("Ferocious Bite", "in Execute", {
	Melee = true,
	GetDelay = function()
		local delay = getDelay(25, true)
		return a.InExecute 
			and a.CP == 5
			and a.Rip - delay > .1 
			and delay
	end
})

c.AddSpell("Ferocious Bite", "Pooling", {
	Melee = true,
	IsMinDelayDefinition = true,
	GetDelay = function()
		if a.CP < 5 or not a.Substantial then
			return false
		end
		
		local delay = math.min(a.Rip, a.TimeToCap - 1)
		local to25 = getDelay(50)
		if to25 < a.Berserk then
			delay = math.min(delay, to25)
		end
		local rage = c.GetBuffDuration("Feral Rage")
		if rage > 0 then
			delay = math.min(delay, rage - 1)
		end
		return delay
	end
})

c.AddSpell("Ferocious Bite", "Beta", {
	Melee = true,
	GetDelay = function()
		local delay = getDelay(25, true)
		return a.CP == 5
			and (a.Rip > delay or not a.Substantial)
			and delay
	end
})

c.AddSpell("Savage Roar", "at 0", {
	RunFirst = setRoarId,
	NoRangeCheck = true,
	GetDelay = function()
		return (a.CP > 0 or c.HasGlyph("Savagery"))
			and math.max(getDelay(25), a.Roar)
	end,
})

c.AddSpell("Savage Roar", "at 3 in Execute", {
	RunFirst = setRoarId,
	NoRangeCheck = true,
	GetDelay = function()
		return a.CP > 0
			and a.InExecute
			and math.max(getDelay(25), a.Roar - 3)
	end,
})

c.AddSpell("Savage Roar", "at 3", {
	RunFirst = setRoarId,
	NoRangeCheck = true,
	GetDelay = function()
		-- If it's about to fall off, and we'll be casting Rip soon, refresh
		-- now so we can build up CP for Rip.
		return a.CP > 0
			and a.Roar > a.Rip - 2 -- only if Rip is falling off
			and math.max(getDelay(25), a.Roar - 3)
	end,
})

c.AddSpell("Savage Roar", "at 6", {
	RunFirst = setRoarId,
	NoRangeCheck = true,
	GetDelay = function()
		-- refresh early if it won't be up when refreshing Rip
		local delay = math.max(getDelay(25), a.Roar - 6)
		return a.CP == 5
			and a.Roar < a.Rip - 2 -- only if it falls off before rip
			and a.Rip > delay
			and delay
	end,
})

c.AddSpell("Savage Roar", "at 12", {
	RunFirst = setRoarId,
	NoRangeCheck = true,
	GetDelay = function()
		-- if we're about to energy cap, 
		local delay = math.max(getDelay(25), a.Roar - 12, a.TimeToCap - 1)
		return a.CP == 5
			and a.Roar < a.Rip + 6
			and a.Rip > delay
			and delay
	end,
})

c.AddOptionalSpell("Incarnation: King of the Jungle", "Beta", {
	GetDelay = function()
		local delay = math.max(
			c.GetCooldown("Incarnation: King of the Jungle", false, 180), 
			a.TigerCool - 1)
		return a.Energy + a.Regen * delay < 35 and delay
	end,
})

c.AddOptionalSpell("Tiger's Fury", "Beta", {
	NoGCD = true,
	GetDelay = function()
		local delay = math.max(a.TigerCool, a.Berserk)
		return not a.Clearcasting
			and a.Energy + a.Regen * delay < 35 
			and delay
	end,
})

c.AddOptionalSpell("Nature's Vigil", "Beta", {
	NoRangeCheck = true,
	NoGCD = true,
	Cooldown = 90,
	CheckFirst = function(z)
		return furySync(z)
	end,
})

c.AddSpell("Thrash(Cat Form)", "under Omen", {
	FlashID = { "Thrash", "Thrash(Bear Form)", "Thrash(Cat Form)" },
	Melee = true,
	GetDelay = function()
		return a.Clearcasting
			and a.Substantial
			and math.max(a.ThrashCat - 3, getDelay(50, true))
	end,
})

local function thrashCatDelay(forMinDelay)
	local energyDelay = getDelay(50, true)
	local delay = math.max(energyDelay, a.ThrashCat - 3)
	return (not forMinDelay or delay == energyDelay)
		and a.Rip > delay
		and (a.CP == 5
			or a.Berserk > delay
			or (a.Rip > delay + 8 and a.Roar > delay + 12))
		and a.Substantial
		and delay
end

c.AddSpell("Thrash(Cat Form)", "Beta", {
	FlashID = { "Thrash", "Thrash(Bear Form)", "Thrash(Cat Form)" },
	Melee = true,
	GetDelay = function()
		return thrashCatDelay(false)
	end,
})

c.AddSpell("Thrash(Cat Form)", "Delay", {
	Melee = true,
	IsMinDelayDefinition = true,
	GetDelay = function()
		return thrashCatDelay(true)
	end,
})

local function thrashOriginationDelay(forMinDelay)
	local rig = c.GetBuffDuration("Re-Origination")
	local energyDelay = getDelay(50, true)
	local delay = math.max(rig - 1.5, a.ThrashCat - 9, energyDelay)
	return (not forMinDelay or delay == energyDelay)
		and rig > delay
		and a.Rip > delay
		and (a.CP == 5
			or a.Berserk > delay
			or (a.Rip > delay + 8 and a.Roar > delay + 12))
		and a.Substantial
		and delay
end

c.AddSpell("Thrash(Cat Form)", "Re-Origination", {
	FlashID = { "Thrash", "Thrash(Bear Form)", "Thrash(Cat Form)" },
	Melee = true,
	GetDelay = function()
		return thrashOriginationDelay(false)
	end,
})

c.AddSpell("Thrash(Cat Form)", "Re-Origination Delay", {
	Melee = true,
	IsMinDelayDefinition = true,
	GetDelay = function()
		return thrashOriginationDelay(true)
	end,
})

c.AddSpell("Rip", "Overwrite", {
	Melee = true,
	GetDelay = function()
		if not a.Substantial or a.CP < 5 then
			return false
		end
		
		local delay = getDelay(30, true)
		if a.CalcDamage("Rip") < 1.15 * a.ExistingBleedDamage("Rip") then
			delay = math.max(delay, a.Rip)
		end
		return delay
	end,
})

c.AddSpell("Rip", "for Re-Origination", {
	Melee = true,
	GetDelay = function()
		local rig = c.GetBuffDuration("Re-Origination")
		local delay = getDelay(30, true)
		return a.Substantial
			and a.CP >= 4 
			and rig > 0 
			and rig - delay < 1.5 
			and a.CalcDamage("Rip") > .95 * a.ExistingBleedDamage("Rip")
			and math.max(rig - 1.5, delay)
	end,
})

c.AddSpell("Rip", "unless Fury Soon", {
	Melee = true,
	GetDelay = function()
		local delay = getDelay(30, true)
		return a.Substantial
			and a.CP == 5 
			and (a.Rip + 2 < a.TigerCool or a.Berserk > delay) 
			and math.max(a.Rip - 2, delay)
	end,
})

c.AddSpell("Rake", "for Re-Origination", {
	Melee = true,
	GetDelay = function()
		local rig = c.GetBuffDuration("Re-Origination")
		local delay = getDelay(30, true)
		return rig > 0 
			and rig - delay < 1.5 
			and math.max(rig - 1.5, a.Rake - 9, delay)
	end,
})

c.AddSpell("Rake", "Overwrite", {
	Melee = true,
	GetDelay = function()
		local existing = a.ExistingBleedDamage("Rake")
		local delay = getDelay(30, true)
		if not a.Substantial then
			return existing == 0 and delay
		end
		
		local new = a.CalcDamage("Rake")
		if new > existing then
			return delay
		elseif new > .75 * existing then
			return math.max(delay, a.Rake - 3)
		else
			return math.max(delay, a.Rake)
		end 
	end,
})

c.AddSpell("Rake", "Filler", {
	Melee = true,
	GetDelay = function()
		local new = a.CalcDamage("Rake")
		local mangle = a.CalcDamage("Mangle")
		local delay = getDelay(30, true)
		if a.Substantial then
			local existing = a.ExistingBleedDamage("Rake")
			local ticks = math.floor(a.Rake / 3) + 1
			return new * (ticks + 1) > mangle + existing * ticks
				and delay
		else
			return new > mangle and delay
		end
	end,
})

c.AddSpell("Filler Delay", nil, {
	ID = "Mangle(Cat Form)",
	Melee = true,
	IsMinDelayDefinition = true,
	GetDelay = function()
		if a.Clearcasting or not a.Substantial then
			return false
		end
		
		-- If you can sneak in a filler before any of these conditions, do it.
		-- Otherwise wait (for clearcasting or the energy cap).
		local unless = math.max(
			c.GetBuffDuration("Feral Fury"),
			a.Berserk,
			a.TigersFury,
			a.TigerCool - 3)
		if a.CP == 0 then
			unless = math.max(unless, a.Roar - 2)
		end
		if a.CP < 5 then
			unless = math.max(unless, a.Rip - 3)
		end
		
		local delay = a.TimeToCap - 1
		return unless < delay and delay, delay - unless
	end,
})

c.AddSpell("Shred", "Filler", {
	FlashID = { "Shred", "Shred!" },
	Melee = true,
	GetDelay = function()
		local delay = math.max(getDelay(40, true), a.King)
		local _, targetID = s.UnitInfo()
		return (a.Clearcasting or a.Berserk > delay or a.Regen > 15)
			and (not (a.NoShred[targetID] or c.IsTanking())
				or (c.HasGlyph("Shred") 
					and (a.TigersFury > delay or a.Berserk > delay)))
			and delay
	end,
})

c.AddSpell("Mangle(Cat Form)", "Filler", {
	FlashID = { "Mangle", "Mangle(Bear Form)", "Mangle(Cat Form)" },
	Melee = true,
	GetDelay = function()
		return math.max(getDelay(35, true), a.King)
	end,
})

---------------------------------------------------------------------- Guardian
c.AddOptionalSpell("Bear Form", nil, {
	Type = "form",
	CheckFirst = function()
		return x.EnemyDetected
	end
})

c.AddSpell("Healing Touch", "Mitigation Delay", {
	NoRangeCheck = true,
	CheckFirst = function()
		return c.HasBuff("Dream of Cenarius - Guardian")
	end,
	ShouldHold = function()
		return true
	end,
})

c.AddOptionalSpell("Healing Touch", "for Guardian", {
	NoRangeCheck = true,
	CheckFirst = function()
		return c.HasBuff("Dream of Cenarius - Guardian")
			and canTakeHealingTouch()
	end,
})

c.AddOptionalSpell("Tooth and Claw", nil, {
	NoGCD = true,
	IsUp = function()
		return c.HasMyDebuff("Tooth and Claw", true)
	end,
})

c.AddOptionalSpell("Cenarion Ward", "for Guardian", {
	NoRangeCheck = true,
	CheckFirst = function()
		return not c.InDamageMode()
	end,
})

c.AddOptionalSpell("Bone Shield", nil, {
	FlashID = a.SymbiosisGuardianFlashIDs,
	NoRangeCheck = true,
	CheckFirst = function()
		local stack = c.GetBuffStack("Bone Shield")
		if s.InCombat() then
			return stack == 0
		else
			return stack < 3 or c.GetBuffDuration("Bone Shield") < 20
		end
	end,
})

c.AddOptionalSpell("Elusive Brew", nil, {
	FlashID = a.SymbiosisGuardianFlashIDs,
	NoRangeCheck = true,
	NoGCD = true,
})

c.AddOptionalSpell("Barkskin", nil, {
	NoGCD = true,
})

c.AddOptionalSpell("Flashing Steel Talisman", nil, {
	Type = "item",
	NoRangeCheck = true,
	Buff = "Flashing Steel",
	BuffUnit = "player",
})

c.AddOptionalSpell("Renewal", "for Guardian", {
	NoGCD = true,
	ShouldHold = function()
		return c.GetHealthPercent("player") > 70
	end,
})

c.AddOptionalSpell("Survival Instincts", "Unglyphed", {
	NoGCD = true,
	Enabled = function()
		return not c.HasGlyph("Survival Instincts")
	end,
	CheckFirst = function()
		return a.Rage > 90 or not c.HasBuff("Frenzied Regeneration", true)
	end,
})

c.AddOptionalSpell("Survival Instincts", "Glyphed", {
	NoGCD = true,
	Enabled = function()
		return c.HasGlyph("Survival Instincts")
	end,
	CheckFirst = function()
		return a.Rage > 90 or not c.HasBuff("Frenzied Regeneration", true)
	end,
})

c.AddOptionalSpell("Fortitude of the Zandalari", nil, {
	Type = "item",
	NoGCD = true,
	ShouldHold = function()
		return c.GetHealthPercent("player") > 90
	end,
})

c.AddOptionalSpell("Might of Ursoc", "at 2 mins", {
	NoGCD = true,
	IsUp = function()
		return false
	end,
	Enabled = function()
		return c.WearingSet(2, "GuardianT14")
			and not c.HasGlyph("Might of Ursoc")
	end,
	ShouldHold = function()
		return s.HealthPercent("player") > 70
	end,
})

c.AddOptionalSpell("Might of Ursoc", "above 2 mins", {
	NoGCD = true,
	IsUp = function()
		return false
	end,
	Enabled = function()
		return not c.WearingSet(2, "GuardianT14") 
			or c.HasGlyph("Might of Ursoc")
	end,
	ShouldHold = function()
		local max = c.HasGlyph("Might of Ursoc") and 50 or 70
		return s.HealthPercent("player") > max
	end,
})

c.AddOptionalSpell("Berserk", "for Guardian", {
	NoGCD = true,
	CheckFirst = function()
		return not c.AoE 
			and c.GetDebuffDuration(c.WEAKENED_BLOWS_DEBUFFS) > 13.5
	end,
	ShouldHold = function()
		return c.GetCooldown("Mangle(Bear Form)") < .5
	end,
})

c.AddOptionalSpell("Berserk", "in Damage Mode", {
	NoGCD = true,
	CheckFirst = function()
		return not c.AoE 
			and c.GetDebuffDuration(c.WEAKENED_BLOWS_DEBUFFS) > 13.5
			and c.InDamageMode()
	end,
	ShouldHold = function()
		return c.GetCooldown("Mangle(Bear Form)") < .5
	end,
})

c.AddOptionalSpell("Incarnation: Son of Ursoc", nil, {
	CheckFirst = function()
		return not c.AoE
	end,
	ShouldHold = function()
		return c.GetCooldown("Mangle(Bear Form)") < .5
	end,
})

c.AddOptionalSpell("Incarnation: Son of Ursoc", "in Damage Mode", {
	CheckFirst = function()
		return not c.AoE and c.InDamageMode()
	end,
	ShouldHold = function()
		return c.GetCooldown("Mangle(Bear Form)") < .5
	end,
})

c.AddOptionalSpell("Frenzied Regeneration", nil, {
	NoGCD = true,
	CheckFirst = function()
		if c.HasGlyph("Frenzied Regeneration") then
			return a.Rage >= 50 
				and not c.HasBuff("Frenzied Regeneration", true)
				and s.HealthPercent("player") < 85 
				and c.IsTanking()
				and not c.IsSolo()
		else
			local maxHeal = math.max(
					2 * UnitAttackPower("player") - 4 * UnitStat("player", 2),
					2.5 * UnitStat("player", 3))
				* (1 + .1 * c.GetBuffStack("Improved Regeneration"))
			if c.WearingSet(4, "GuardianT14") then
				maxHeal = maxHeal * 1.1
			end
			return a.Rage > 0 
				and s.MaxHealth("player") - c.GetHealth("player") 
					> math.min(1, a.Rage / 50) * maxHeal
		end
	end,
})

c.AddOptionalSpell("Savage Defense", nil, {
	NoGCD = true,
	Melee = true,
	CheckFirst = function()
		return c.IsTanking() and not c.InDamageMode()
	end
})

local bleeds = c.GetIDs(
	"Lacerate",
	"Thrash(Bear Form)",
	"Thrash(Cat Form)",
	"Rake",
	"Rip",
	"Pounce Bleed",
	"Deep Wounds",
	"Rupture",
	"Hemorrhage",
	"Garrote")

c.AddOptionalSpell("Maul", "for Guardian", {
	NoGCD = true,
	CheckFirst = function()
		return (a.EmptyRage < 10 
				and (c.HasBuff("Tooth and Claw", true) or not c.IsTanking()))
			or (c.InDamageMode() and c.HasDebuff(bleeds))
	end,
})

c.AddTaunt("Growl", nil, {
	NoGCD = true,
})

c.AddSpell("Thrash(Bear Form)", nil, {
	FlashID = { "Thrash", "Thrash(Bear Form)", "Thrash(Cat Form)" },
	Melee = true,
	Cooldown = 6,
})

c.AddSpell("Thrash(Bear Form)", "for Weakened Blows", {
	FlashID = { "Thrash", "Thrash(Bear Form)", "Thrash(Cat Form)" },
	Melee = true,
	Debuff = c.WEAKENED_BLOWS_DEBUFFS,
	EarlyRefresh = 1.5,
	Cooldown = 6,
	CheckFirst = function()
		return not c.InDamageMode()
	end,
})

c.AddSpell("Thrash(Bear Form)", "for Bleed", {
	FlashID = { "Thrash", "Thrash(Bear Form)", "Thrash(Cat Form)" },
	Melee = true,
	MyDebuff = "Thrash(Bear Form)",
	UseBuffID = true,
	EarlyRefresh = 2,
	Cooldown = 6,
})

c.AddSpell("Thrash(Bear Form)", "for Damage", {
	FlashID = { "Thrash", "Thrash(Bear Form)", "Thrash(Cat Form)" },
	Melee = true,
	MyDebuff = "Thrash(Bear Form)",
	UseBuffID = true,
	EarlyRefresh = 2,
	Cooldown = 6,
	CheckFirst = c.InDamageMode,
})

c.AddSpell("Thrash(Bear Form)", "for AoE", {
	FlashID = { "Thrash", "Thrash(Bear Form)", "Thrash(Cat Form)" },
	Melee = true,
	Cooldown = 6,
	CheckFirst = function()
		return c.AoE
	end
})

c.AddOptionalSpell("Rejuvenation", "for Guardian", {
	NoRangeCheck = true,
	GetDelay = function()
		return c.HasBuff("Heart of the Wild") 
			and not c.InDamageMode()
			and c.GetMyBuffDuration("Rejuvenation"), 0
	end,
})

c.AddOptionalSpell("Rejuvenation", "Refresh for Guardian", {
	Tick = 3,
	NoRangeCheck = true,
	GetDelay = function(z)
		return c.HasBuff("Heart of the Wild") 
			and not c.InDamageMode()
			and c.GetMyBuffDuration("Rejuvenation") - z.EarlyRefresh, 0
	end,
})

c.AddSpell("Mangle(Bear Form)", "for Guardian", {
	RunFirst = function(z)
		if c.HasBuff("Berserk") or c.HasBuff("Incarnation: Son of Ursoc") then
			z.Cooldown = 0
		else
			z.Cooldown = 6
		end
	end,
})

c.AddSpell("Mangle(Bear Form)", "Delay", {
	IsMinDelayDefinition = true,
	GetDelay = function()
		return c.GetCooldown("Mangle(Bear Form)", false, 6), .5
	end
})

c.AddSpell("Faerie Fire", "for Debuff for Guardian", {
	Debuff = c.ARMOR_DEBUFFS,
	RunFirst = setFaerieID,
	SpecialGCD = "hasted",
	Cooldown = 6,
})

c.AddSpell("Enrage", nil, {
	Cooldown = 60,
	CheckFirst = function()
		return a.EmptyRage > 20 and c.IsTanking()
	end,
})

c.AddSpell("Lacerate", "for Guardian", {
	Cooldown = 3,
})

c.AddSpell("Swipe(Bear Form)", "for AoE", {
	FlashID = { "Swipe", "Swipe(Bear Form)", "Swipe(Cat Form)" },
	Melee = true,
	Cooldown = 3,
	CheckFirst = function()
		return c.AoE
	end
})

c.AddSpell("Swipe(Bear Form)", "for AoE Delay", {
	IsMinDelayDefinition = true,
	FlashID = { "Swipe", "Swipe(Bear Form)", "Swipe(Cat Form)" },
	Melee = true,
	GetDelay = function()
		return c.AoE and c.GetCooldown("Swipe(Bear Form)", false, 3), .5
	end
})

------------------------------------------------------------------- Restoration
c.RegisterForFullChannels("Tranquility")

c.AddOptionalSpell("Force of Nature: Restoration", nil, {
	FlashID = { "Force of Nature", "Force of Nature: Restoration" },
	NoRangeCheck = true,
	NoGCD = true,
	CheckFirst = forceOfNatureCheck,
})

c.AddSpell("Lifebloom", nil, {
	NoRangeCheck = true,
	Tick = 1,
	CheckFirst = function(z)
--		if c.HasBuff("Incarnation: Tree of Life", false, false, true) then
--			c.MakeMini(z, false)
--			return true
--		end
		
		local dur = s.MyBuffDuration(z.ID, a.LifebloomTarget)
		if dur > 0
			and c.IsCastingAt(
				a.LifebloomTarget, "Regrowth", "Healing Touch", "Nourish")
			and c.GetBusyTime(true) < dur then
				
			return false
		end
		
		dur = dur - c.GetBusyTime()
		local rgCast = c.GetCastTime("Regrowth")
		local htCast = c.GetCastTime("Healing Touch")
		if dur < rgCast then
			z.FlashColor = "red"
			c.MakeMini(z, dur > z.EarlyRefresh)
			return true
		elseif dur < rgCast + z.EarlyRefresh then
			z.FlashColor = "yellow"
			c.MakeMini(z, false)
			return true
		elseif dur < htCast then
			return false
		elseif dur < htCast + z.EarlyRefresh then
			z.FlashColor = "yellow"
			c.MakeMini(z, true)
			return true
		end
	end,
})

local function harmonyNeeded()
	return not c.HasBuff("Harmony")
		and not c.IsCasting("Swiftmend", "Healing Touch", "Regrowth", "Nourish")
end

c.AddOptionalSpell("Swiftmend", nil, {
	Override = harmonyNeeded,
})

c.AddOptionalSpell("Nourish", nil, {
	Override = harmonyNeeded,
})

local function doHTandRG(z)
	local h = harmonyNeeded()
	local cc = c.HasBuff("Clearcasting") 
		and not c.IsCasting("Healing Touch", "Regrowth")
	c.MakeMini(z, h and not cc)
	return h or cc
end

c.AddOptionalSpell("Healing Touch", "for Restoration", {
	Override = function(z)
		local dur = c.GetBuffDuration("Sage Mender")
		if dur > 0 then
			if dur < 2 then
				z.FlashColor = "red"
				return true
			elseif c.GetBuffStack("Sage Mender") == 5 then
				z.FlashColor = "yellow"
				return true
			else
				return false
			end
		end
		
		z.FlashColor = "yellow"
		return doHTandRG(z)
	end, 
})

c.AddOptionalSpell("Regrowth", nil, {
	Override = doHTandRG,
})

c.AddOptionalSpell("Innervate", nil, {
	NoRangeCheck = true,
	CheckFirst = function()
		local max = UnitPowerMax("player")
		local spirit = UnitStat("player", 5)
		local empower = math.max(.08 * max, 5 * spirit)
		return c.GetPower() + empower < max
	end
})

c.AddOptionalSpell("Cenarion Ward", "for Restoration", {
	NoRangeCheck = true,
})

c.AddOptionalSpell("Wild Mushroom", nil, {
	NoRangeCheck = true,
	CheckFirst = function()
		return c.IsMissingTotem(1)
	end,
})
