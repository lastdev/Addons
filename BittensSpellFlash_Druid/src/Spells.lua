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
	return s.Health() > 1.5 * s.MaxHealth("player")
end

local function forceOfNatureCheck(z)
	local charges, _, start, duration = GetSpellCharges(z.ID)
	if start + duration < GetTime() + c.GetBusyTime(false) + 2 then
		charges = charges + 1
	end
	return charges >= 3
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
				and substantialFight())
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
			return a.MinRip < (a.CP == 0 and 4 or 3) and substantialFight()
		end
	end,
})

c.AddOptionalSpell("Tiger's Fury", nil, {
	NoGCD = true,
	CheckFirst = function()
		return a.Energy <= 35 
			and not a.Clearcasting
			and not c.HasBuff("Berserk", true)
	end
})

c.AddOptionalSpell("Berserk", nil, {
	NoGCD = true,
	CheckFirst = function(z)
		local furyCool = c.GetCooldown("Tiger's Fury")
		if furyCool > 6 or not substantialFight() then
			z.FlashColor = "yellow"
		else
			z.FlashColor = "green"
		end
		
		c.MakeMini(z, furyCool == 0 and substantialFight())
		return furyCool > 6 or furyCool == 0 or not substantialFight()
	end
})

c.AddOptionalSpell("Incarnation: King of the Jungle")

c.AddSpell("Healing Touch", "for Dream", {
	Override = function()
		return a.DreamStacks <= 0
			and a.Swiftness
			and a.Energy + a.Regen < 100
			and c.HasTalent("Dream of Cenarius")
	end
})

c.AddSpell("Healing Touch", "for Vigil", {
	Override = function()
		return a.Swiftness
			and a.Energy < 35
			and c.HasBuff("Nature's Vigil", false, false, true)
	end
})

c.AddOptionalSpell("Healing Touch", "for Feral Heal", {
	Override = function()
		return a.Swiftness 
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
			and substantialFight()
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
			and (a.InExecute or a.Rip - delay > 6 or not substantialFight())
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
			and substantialFight()
	end
})

local function swiftable()
	return not a.Swiftness
		and a.DreamStacks == 0
		and a.CP == 5
		and a.Energy + a.Regen < 100
		and c.HasTalent("Dream of Cenarius")
		and substantialFight()
end

c.AddSpell("Rip", nil, {
	Melee = true,
	Override = function(z)
		return a.CP == 5
			and (not a.InExecute or a.Rip == 0)
			and a.Rip - modForDelay(z, 30, true) < 2
			and substantialFight()
	end
})

c.MakePredictor(c.AddSpell("Rip", "Delay", {
	Melee = true,
	Override = function()
		return not a.InExecute
			and a.CP == 5
			and a.TimeToCap > a.Rip + 1
			and substantialFight()
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
			and substantialFight()
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
				and c.GetCooldown("Tiger's Fury") > 4.5
		elseif substantialFight() then
			return a.MinRip > (a.CP == 0 and 4.5 or 5.5)
					and a.Rake > 4.5
					and c.GetCooldown("Tiger's Fury") > 4.5
		else
			return c.GetCooldown("Tiger's Fury") > 0
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
			and c.GetCooldown("Tiger's Fury") > 4
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

---------------------------------------------------------------------- Guardian
c.AddOptionalSpell("Bear Form", nil, {
	Type = "form",
	CheckFirst = function()
		return x.EnemyDetected
	end
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
		if c.HasBuff("Savage Defense", true) and a.Rage < 90 then
			return false
		end
		
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
		return (not c.HasBuff("Frenzied Regeneration") or a.Rage >= 90) 
			and c.IsTanking()
			and not c.InDamageMode()
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

c.AddOptionalSpell("Healing Touch", "for Guardian", {
	NoRangeCheck = true,
	CheckFirst = function()
		return c.HasBuff("Dream of Cenarius - Guardian")
			and canTakeHealingTouch()
	end,
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
	EarlyRefresh = 1,
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
c.ManageDotRefresh("Lifebloom", 1)

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
	Override = doHTandRG,
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
