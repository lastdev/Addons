local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local g = BittensGlobalTables
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")
local m = a.CatSimulator
local u = g.GetTable("BittensUtilities")

local GetComboPoints = GetComboPoints
local GetCritChance = GetCritChance
local UnitDamage = UnitDamage
local GetEclipseDirection = GetEclipseDirection
local GetMastery = GetMastery
local GetMeleeHaste = GetMeleeHaste
local GetPowerRegen = GetPowerRegen
local GetSpecialization = GetSpecialization
local GetTime = GetTime
local IsMounted = IsMounted
local SPELL_POWER_ENERGY = SPELL_POWER_ENERGY
local SPELL_POWER_ECLIPSE = SPELL_POWER_ECLIPSE
local SPELL_POWER_RAGE = SPELL_POWER_RAGE
local UnitAttackPower = UnitAttackPower
local UnitGUID = UnitGUID
local UnitPower = UnitPower
local math = math
local select = select
local string = string
local print = print
local tostring = tostring

local RIP_ACCEPTABLE_DOWNTIME = 2
local RIP_FURY_DELAY = 2
local RAKE_FURY_DELAY = 2

local primalPending = 0
local primalPendingFromMangle = false

local function monitorPendPrimalRage(spellID, _, _, critical)
	if critical 
		and c.IdMatches(spellID, "Auto Attack", "Mangle(Bear Form)")
		and s.Form(c.GetID("Bear Form")) then
		
		primalPending = GetTime()
		primalPendingFromMangle = c.IdMatches(spellID, "Mangle(Bear Form)")
		c.Debug("Event", "Primal Fury Rage Pending")
	end
end

local function monitorConsumePrimalRage(spellID)
	if c.IdMatches(spellID, "Primal Fury Rage") then
		primalPending = 0
		c.Debug("Event", "Primal Fury Rage Happened")
	end
end

local function calcRage()
	a.Rage = c.GetPower(0, SPELL_POWER_RAGE)
	local bump = 0
	local soulMultiplier = 
		c.HasTalent("Soul of the Forest") and GetSpecialization() == 3 
			and 1.3 
			or 1
	if GetTime() - primalPending < .8 then
		bump = 15
		if primalPendingFromMangle then
			bump = bump * soulMultiplier
		end
	end
	if c.IsQueued("Mangle(Bear Form)") then
		bump = bump + 5 * soulMultiplier
	end
	if c.HasBuff("Enrage", true) and c.WearingSet(4, "GuardianT15") then
		bump = bump * 1.5
	end
	a.Rage =  math.min(s.MaxPower("player"), a.Rage + bump)
	a.EmptyRage = s.MaxPower("player") - a.Rage
end

a.Rotations = {}

----------------------------------------------------------------------- Balance
local pendingSecondDot = 0
local pendingLunarShower = 0

a.MoonfireTick = 2
a.SunfireTick = 2

local updateMoonfire = function()
	a.MoonfireTick = c.GetHastedTime(2)
	c.Debug("Event", "Moonfire ticks every", a.MoonfireTick)
end

local updateSunfire = function()
	a.SunfireTick = c.GetHastedTime(2)
	c.Debug("Event", "Sunfire ticks every", a.SunfireTick)
end

a.Rotations.Balance = {
	Spec = 1,
	
	UsefulStats = { 
		"Intellect", "Spell Hit", "Hit from Spirit", "Crit", "Haste" 
	},
	
	FlashInCombat = function()
		a.Energy = UnitPower("player", SPELL_POWER_ECLIPSE)
		a.Alignment = c.GetBuffDuration(
			"Celestial Alignment", false, false, true)
		
		if a.Alignment > 0 then
			a.Solar = true
			a.Lunar = true
		else
			a.Solar = c.HasBuff("Eclipse (Solar)") 
			a.Lunar = c.HasBuff("Eclipse (Lunar)")
		end
		a.GoingUp = GetEclipseDirection() ~= "moon"
		
		a.EclipsePending = false
		if a.Alignment == 0 then
			local bump = 0
			if c.IsCasting("Starfire") then
				if a.GoingUp then
					bump = 20
				end
			elseif c.IsCasting("Wrath") then
				if not a.GoingUp then
					bump = -15
				end
			elseif c.IsCasting("Starsurge") then
				if a.GoingUp then
					bump = 20
				else
					bump = -20
				end
			end
			if c.IsCasting("Astral Communion") 
				and c.HasBuff("Astral Insight") then
				
				if a.GoingUp then
					bump = bump + 100
				else
					bump = bump - 100
				end
			end
			if bump ~= 0 then
				if c.HasSpell("Euphoria")
					and not a.Solar
					and not a.Lunar then
					
					bump = bump * 2
				end
				a.Energy = a.Energy + bump
				if a.Energy <= -100 then
					a.GoingUp = true
					a.Lunar = true
					a.EclipsePending = true
				elseif a.Energy >= 100 then
					a.GoingUp = false
					a.Solar = true
					a.EclipsePending = true
				elseif a.Energy >= 0 then
					a.Lunar = false
				elseif a.Energy <= 0 then
					a.Solar = false
				end
			end
		end
		
		local now = GetTime()
		if now - pendingSecondDot < .8
			or (a.Alignment > 0 and c.IsCasting("Moonfire", "Sunfire")) then
			
			a.Moonfire = 14
			a.Sunfire = 14
		else
			a.Moonfire = c.GetMyDebuffDuration("Moonfire", false, false, true)
			a.Sunfire = c.GetMyDebuffDuration("Sunfire", false, false, true)
		end
		
		if now - pendingLunarShower < 0.8 
			or c.IsCasting("Moonfire", "Sunfire") then
			
			a.LunarShower = 3 - c.GetBusyTime()
		else
			a.LunarShower = c.GetBuffDuration("Lunar Shower")
		end
		
		c.FlashAll(
			"Starfall", 
			"Force of Nature: Balance", 
			"Incarnation: Chosen of Elune",
			"Nature's Vigil",
			"Celestial Alignment",
			"Wild Mushroom: Detonate",
			"Renewal",
			"Soothe",
			"Solar Beam")
		
		c.PriorityFlash(
			"Astral Communion Instant", 
			"Starsurge under Shooting Stars",
			"Moonfire under Eclipse",
			"Sunfire under Eclipse",
			"Moonfire",
			"Sunfire",
			"Starsurge",
			"Starfire under Celestial Alignment",
			"Wrath under Celestial Alignment",
			"Starfire",
			"Wrath")
	end,
	
	FlashOutOfCombat = function()
		c.FlashAll("Symbiosis", "Healing Touch Solo")
	end,
	
	FlashAlways = function()
		c.FlashAll("Mark of the Wild", "Moonkin Form")
	end,
	
	CastSucceeded = function(info)
		if c.InfoMatches(info, "Moonfire", "Sunfire") then
			if c.HasBuff("Celestial Alignment", true, false, true) then
				pendingSecondDot = GetTime()
				c.Debug("Event", "Pending Second DoT")
			end
			pendingLunarShower = GetTime()
			c.Debug("Event", "Lunar Shower Pending")
		end
	end,
	
	AuraApplied = function(spellID)
		if c.IdMatches(spellID, "Moonfire") then
			updateMoonfire()
		elseif c.IdMatches(spellID, "Starfire") then
			updateSunfire()
		elseif c.IdMatches(spellID, "Lunar Shower") then
			pendingLunarShower = 0
			c.Debug("Event", "Lunar Shower Happened")
		end
	end,
	
	SpellDamage = function(spellID, _, _, crit)
		if crit then
			if c.IdMatches(spellID, "Starsurge") then
				updateMoonfire()
				updateSunfire()
			elseif c.IdMatches(spellID, "Wrath") then
				updateSunfire()
			elseif c.IdMatches(spellID, "Starfire") then
				updateMoonfire()
			end
		end
	end,
	
	ExtraDebugInfo = function()
		return string.format(
			"e:%d s:%s l:%s u:%s p:%s m:%.1f s:%.1f l:%.1f a:%.1f",
			a.Energy,
			tostring(a.Solar),
			tostring(a.Lunar),
			tostring(a.GoingUp),
			tostring(a.EclipsePending),
			a.Moonfire,
			a.Sunfire,
			a.LunarShower,
			a.Alignment)
	end,
}

------------------------------------------------------------------------- Feral
local lastRipTime = 0
local lastRipDuration = 0
local pendingRipExtension = 0

local function updateRipDuration()
	local duration = s.MyDebuffDuration(c.GetID("Rip"))
	local now = GetTime()
	if duration - lastRipDuration > 4 then
		pendingRipExtension = 6
--c.Debug("Rip", "Overwrite: ", duration - lastRipDuration)
	elseif pendingRipExtension > 0 and duration > lastRipDuration then
		pendingRipExtension = pendingRipExtension - 2
--c.Debug("Rip", "change of ", duration - lastRipDuration, " -> ", pendingRipExtension)
	end
	lastRipTime = now
	lastRipDuration = duration
	
	local busyTime = c.GetBusyTime()
	if c.IsAuraPendingFor("Rip") then
		a.Rip = 99
		a.MinRip = 99
	elseif duration > busyTime 
		or (duration > 0 
			and pendingRipExtension > 0 
			and c.IsCasting("Shred", "Ravage", "Mangle(Cat Form)")) then
		
		a.Rip = duration - busyTime
		a.MinRip = a.Rip
		if not c.AoE then
			a.Rip = a.Rip + pendingRipExtension
		end
	else
		a.Rip = 0
		a.MinRip = 0
	end
end

local castingRipCP = 1
local bleeds = { }
local damageCalcs = {
	Rip = function(physMod, bleedMod, cp)
		return (113 + cp * (320 + 0.0484 * UnitAttackPower("player")))
			* bleedMod
			* physMod
	end,
	Rake = function(physMod, bleedMod)
		return (99 + .3 * UnitAttackPower("player")) * bleedMod * physMod
	end,
	Mangle = function()
		local armor = 24835 * (1 - .04 * c.GetDebuffStack(c.ARMOR_DEBUFFS))
		local low, high = UnitDamage("player")
		return (78 + 2.5 * (low + high)) / 2
			* (1 - armor / (armor + 46257.5))
	end,
}

-- TODO this isn't exact (not sure why), but it's close
function a.CalcDamage(name, cp, roar, fury, dream, vigil)
	local critMultiplier = 2
	local physMod = 1
	if (roar or a.Roar) > 0 then
		physMod = physMod * 1.4
	end
	if (fury or a.TigersFury) > 0 then
		physMod = physMod * 1.15
	end
	if (dream or a.DreamStacks) > 0 then
		physMod = physMod * 1.3
	end
	if (vigil or a.Vigil) > 0 then
		physMod = physMod * 1.12
	end
	local noncrit = damageCalcs[name](
		physMod, 1 + .0313 * GetMastery(), cp or a.CP)
	local avg = noncrit * (1 + (critMultiplier - 1) * GetCritChance() / 100)
	return avg, noncrit
end

function a.ExistingBleedDamage(name)
	if c.IsCasting(name) then
		return a.CalcDamage(name)
	elseif a[name] == 0 then
		return 0
	else
		return u.GetOrMakeTable(bleeds, name)[UnitGUID(s.UnitSelection())]
	end
end

local lastEnergy = 0
local pendingBiteDrain = 0
local forestPending = 0
local biteTime = 0
local cpPending = 0
local furyCpPending = 0
local pendingRoarDrop = 0
local lastCP = 0
local pendingBearRage = 0

local function initState()
	a.InExecute = s.HealthPercent() < 25
	
	calcRage()
	local now = GetTime()
	if now - pendingBearRage < .8 then
		a.Rage = a.Rage + 10
	end
	
	if s.Power("player") < lastEnergy or now - biteTime > 1 then
		pendingBiteDrain = 0
	end
	lastEnergy = s.Power("player")
	
	updateRipDuration()
	
	local curCP = GetComboPoints("player")
	local added = curCP - lastCP
	a.CP = curCP
	if now - cpPending < .8 then
		if added > 0 then
			added = added - 1
			cpPending = 0
			c.Debug("Event", "Mangle CP Happened")
		else
			a.CP = a.CP + 1
		end
	end
	if now - furyCpPending < .8 then
		if added > 0 then
			furyCpPending = 0
			c.Debug("Event", "Primal Fury CP Happened")
		else
			a.CP = a.CP + 1
		end
	end
	if now - pendingRoarDrop < .8 then
		if curCP == 0 then
			pendingRoarDrop = 0
			c.Debug("Event", "Savage Roar CP Use Happened")
		else
			a.CP = 0
		end
	end
	a.CP = math.min(5, a.CP)
	lastCP = curCP
	
	a.Regen = 10 + GetMeleeHaste() / 10
	a.Energy = 
		c.GetPower(a.Regen, SPELL_POWER_ENERGY) 
		- pendingBiteDrain 
		+ forestPending
	a.Roar = c.GetBuffDuration("Savage Roar", false, false, true)
	a.Rake = c.GetMyDebuffDuration("Rake", false, false, true)
	a.ThrashCat = c.GetMyDebuffDuration("Thrash(Cat Form)", false, true, true)
	a.DreamStacks = c.GetBuffStack("Dream of Cenarius - Feral", false, true)
	if c.IsCasting("Healing Touch") then
		a.Swiftness = 0
		if c.HasTalent("Dream of Cenarius") then
			a.DreamStacks = 2
		end
	else
		a.Swiftness = c.GetBuffDuration("Predatory Swiftness")
		if a.DreamStacks > 0 
			and c.IsCasting(
				"Shred", 
				"Shred!",
				"Thrash(Bear Form)",
				"Mangle(Bear Form)",
				"Rake", 
				"Ravage", 
				"Ravage!",
				"Rip", 
				"Ferocious Bite", 
				"Thrash(Cat Form)", 
				"Mangle(Cat Form)",
				"Swipe") then
			
			a.DreamStacks = a.DreamStacks - 1
		end
		if c.IsCasting(
			"Shred", 
			"Shred!", 
			"Rake", 
			"Ravage", 
			"Ravage!", 
			"Mangle(Cat Form)") then
			
			a.CP = math.min(5, a.CP + 1)
		elseif c.IsCasting("Rip", "Savage Roar", "Ferocious Bite") then
			if a.CP == 5 then
				a.Swiftness = 8
			end
			if c.HasTalent("Soul of the Forest") then
				a.Energy = a.Energy + 4 * a.CP
			end
			
			a.CP = 0
		end
	end
	a.Energy = math.max(0, math.min(100, a.Energy))
	
	a.Clearcasting = c.HasBuff("Clearcasting")
	if a.Clearcasting 
		and c.IsCasting(
			"Shred",
			"Shred!",
			"Rake",
			"Ravage",
			"Ravage!",
			"Rip",
			"Ferocious Bite",
			"Thrash(Cat Form)",
			"Mangle(Cat Form)",
			"Swipe") then
		
		a.Clearcasting = false
	end
	
	a.Berserk = c.GetBuffDuration("Berserk", false, false, true)
	a.TigersFury = c.GetBuffDuration("Tiger's Fury", false, false, true)
	a.TigerCool = c.GetCooldown("Tiger's Fury")
	a.King = c.GetBuffDuration(
		"Incarnation: King of the Jungle", false, false, true)
	a.Vigil = c.GetBuffDuration("Nature's Vigil", false, false, true)
	
	a.TimeToCap = (100 - a.Energy) / a.Regen
	a.Substantial = s.Health() > 1.5 * s.MaxHealth("player") or s.Dummy()
end

a.TimeToCap = 0

a.Rotations.Feral = {
	Spec = 2,
	
	UsefulStats = { "Agility", "Melee Hit", "Strength", "Crit", "Haste" },
	
	FlashInCombat = function()
		initState()
		
		c.FlashAll(
			"Force of Nature: Feral", 
			"Faerie Fire for Debuff",
			"Renewal",
			"Soothe",
			"Skull Bash",
			"Survival Instincts under 30", 
			"Barkskin under 30")
		
		if s.Form(c.GetID("Bear Form")) then
			c.FlashAll("Heart of the Wild", "Healing Touch for Feral Heal")
			local flashing = c.PriorityFlash(
				"Swipe(Bear Form) Prime for Feral",
				"Thrash(Bear Form) for Feral",
				"Cat Form",
				"Swipe(Bear Form) for Feral",
				"Mangle(Bear Form)",
				"Lacerate",
				"Faerie Fire")
			local freely = flashing ~= "Cat Form"
			if a.Rage >= (c.AoE and freely and 45 or 30) 
				and (freely or c.GetCooldown("Maul") == 0) then
				
				c.FlashAll("Maul for Feral") 
			end
			return
		end
		
		if c.FlashAll("Cat Form") then
			return
		end
		
		if c.AoE then
			c.FlashAll(
				"Tiger's Fury", 
				"Berserk", 
				"Nature's Vigil",
				"Healing Touch for Feral Heal",
				"Incarnation: King of the Jungle")
			c.PriorityFlash(
				"Healing Touch for Dream",
				"Savage Roar for AoE",
				"Rip",
				"Ferocious Bite for AoE",
				"Bear Form for Feral AoE",
				"Thrash(Cat Form) for AoE",
				"Swipe(Cat Form) for Feral")
		elseif c.GetOption("FeralBeta") then
			c.DelayPriorityFlash(
				"Ravage under Stealth",
				"Healing Touch for Feral Beta",
				"Ferocious Bite on Last Tick Beta",
				"Healing Touch for Dream Beta",
				"Savage Roar at 0",
				"Incarnation: King of the Jungle Beta",
				"Tiger's Fury Beta",
				"Nature's Vigil Beta",
				"Berserk",
				"Thrash(Cat Form) under Omen",
				"Savage Roar at 3 in Execute",
				"Rip Overwrite",
				"Ferocious Bite in Execute Pooling",
				"Ferocious Bite in Execute",
				"Rip unless Fury Soon",
				"Savage Roar at 12",
				"Rake for Re-Origination",
				"Rake Overwrite",
				"Thrash(Cat Form) Beta",
				"Thrash(Cat Form) Delay",
				"Thrash(Cat Form) Re-Origination",
				"Thrash(Cat Form) Re-Origination Delay",
				"Ferocious Bite Pooling",
				"Ferocious Bite Beta",
				"Filler Delay",
				"Ravage Filler",
				"Rake Filler",
				"Shred Filler",
				"Mangle(Cat Form) Filler")
		else
			c.FlashAll(
				"Tiger's Fury", 
				"Berserk", 
				"Nature's Vigil",
				"Healing Touch for Feral Heal",
				"Incarnation: King of the Jungle")
			c.PriorityFlash(
				"Healing Touch for Dream",
				"Savage Roar",
				"Ferocious Bite on Last Tick",
				"Rip",
				"Savage Roar Early",
				"Ferocious Bite",
				"Rake",
				"Thrash(Cat Form)",
				"Healing Touch for Vigil",
				"Rip Delay",
				"Bear Form for Feral",
				"Ravage",
				"Shred",
				"Mangle(Cat Form)")
		end
	end,
	
	FlashOutOfCombat = function()
		c.FlashAll("Symbiosis", "Healing Touch Solo", "Cat Form")
	end,
	
	FlashAlways = function()
		c.FlashAll("Mark of the Wild")
	end,
	
	CastQueued = function(info)
		if c.InfoMatches(info, "Ferocious Bite") then
			local _, regen = GetPowerRegen()
			local cost = s.SpellCost(info.Name)
			local energy = s.Power("player") + s.UpdatedVariables.Lag * regen
			cost = cost + math.min(25, energy - cost)
			info.Cost[SPELL_POWER_ENERGY] = cost
			c.Debug("Event", "FB will cost", cost)
		elseif c.InfoMatches(info, "Rip") then
			castingRipCP = GetComboPoints("player")
		end
	end,
	
	CastSucceeded = function(info)
		local hasForest = c.HasTalent("Soul of the Forest")
		
		if c.IdMatches(info.ID, "Mangle(Cat Form)") then
			cpPending = GetTime()
			c.Debug("Event", "Mangle CP Pending")
		elseif c.InfoMatches(info, "Savage Roar Glyphed") then
			pendingRoarDrop = GetTime()
			c.Debug("Event", "Savage Roar CP Use Pending")
		elseif c.InfoMatches(info, "Ferocious Bite") then
			lastEnergy = s.Power("player")
			if hasForest then
				pendingBiteDrain = math.min(
					25, lastEnergy - 4 * GetComboPoints("player"))
			else
				pendingBiteDrain = math.min(25, lastEnergy)
			end
			biteTime = GetTime()
			c.Debug("Event", "FB will still cost", pendingBiteDrain)
		elseif c.InfoMatches(info, "Bear Form") then
			pendingBearRage = GetTime()
			c.Debug("Event", "Bear Form Rage Pending")
		end
		
		if hasForest
			and c.InfoMatches(
				info, 
				"Rip",
				"Savage Roar Glyphed", 
				"Savage Roar Unglyphed") then
			
			forestPending = 4 * GetComboPoints("player")
			c.Debug("Event", "Soul of the Forest Pending:", forestPending)
		end
	end,
	
	CastSucceeded_FromLog = function(spellID, _, targetID)
		local name = 
			(c.IdMatches(spellID, "Rip") and "Rip")
				or (c.IdMatches(spellID, "Rake") and "Rake")
		if name then
			local avg, noncrit = 
				a.CalcDamage(
					name, 
					castingRipCP, 
					s.BuffDuration(c.GetID("Savage Roar"), "player"),
					s.BuffDuration(c.GetID("Tiger's Fury"), "player"),
					s.BuffStack(c.GetID("Dream of Cenarius - Feral"), "player"),
					s.BuffDuration(c.GetID("Nature's Vigil"), "player"))
			u.GetOrMakeTable(bleeds, name)[targetID] = avg
			c.Debug("Event", 
				string.format("%s is ticking for %.1f avg (%.1f noncrit)", 
					name, avg, noncrit))
		end
	end,
	
	SpellMissed = function(spellID)
		if c.IdMatches(spellID, "Rip", "Ferocious Bite") then
			forestPending = 0
			c.Debug("Event", "Never mind on Soul of the Forest ... it missed")
		end
		if c.IdMatches(spellID, "Ferocious Bite") then
			pendingBiteDrain = 0
			c.Debug("Event", "Oh, and never mind on FB either")
		end
	end,
	
	SpellDamage = function(spellID, _, _, crit, tick)
		if crit
			and not tick
			and c.IdMatches(
				spellID, 
				"Shred", 
				"Shred!", 
				"Rake",
				"Ravage",
				"Ravage!",
				"Mangle(Cat Form)") then
			
			furyCpPending = GetTime()
			c.Debug("Event", "Primal Fury CP Pending")
		else
			monitorPendPrimalRage(spellID, nil, nil, crit)
		end
	end,
	
	AutoAttack = monitorPendPrimalRage,
	
	Energized = function(spellID)
		if c.IdMatches(spellID, "Soul of the Forest") then
			forestPending = 0
			c.Debug("Event", "Soul of the Forest Happened")
		elseif c.IdMatches(spellID, "Bear Form Rage") then
			pendingBearRage = 0
			c.Debug("Event", "Bear Form Rage Happened")
		else
			monitorConsumePrimalRage(spellID)
		end
	end,
	
	LeftCombat = function()
		bleeds = { }
		c.Debug("Event", "Left Combat")
	end,
	
	ExtraDebugInfo = function()
		return string.format(
			"b:%.1f r:%.1f e:%.1f c:%d c:%s s:%.1f d:%d b:%.1f t:%.1f k:%.1f r:%.1f r:%.1f x:%s", 
			c.GetBusyTime(),
			a.Rage,
			a.Energy, 
			a.CP,
			tostring(not not a.Clearcasting),
			a.Swiftness,
			a.DreamStacks,
			a.Berserk,
			a.TigersFury,
			a.King,
			a.Rip,
			a.Roar,
			tostring(not not a.InExecute))
	end,
}

---------------------------------------------------------------------- Guardian
local uncontrolledMitigationCooldowns = {
	"Feint",
	"Spell Reflection",
	"Tooth and Claw",
}

a.Rotations.Guardian = {
	Spec = 3,
	AoEColor = "aqua",
	
	UsefulStats = { 
		"Agility", "Dodge", "Tanking Hit", "Stamina", "Crit", "Haste"
	},
	
	FlashInCombat = function()
		calcRage()
		c.FlashMitigationBuffs(
			1,
			uncontrolledMitigationCooldowns,
			c.COMMON_TANKING_BUFFS,
			"Healing Touch Mitigation Delay",
			"Berserk in Damage Mode",
			"Incarnation: Son of Ursoc in Damage Mode",
			"Cenarion Ward for Guardian",
			"Bone Shield",
			"Elusive Brew",
			"Barkskin",
			"Flashing Steel Talisman",
			"Renewal for Guardian",
			"Survival Instincts Glyphed",
			"Fortitude of the Zandalari",
			"Might of Ursoc at 2 mins",
			"Berserk for Guardian",
			"Incarnation: Son of Ursoc",
			"Survival Instincts Unglyphed",
			"Might of Ursoc above 2 mins")
		c.FlashAll(
			"Frenzied Regeneration",
			"Savage Defense",
			"Maul for Guardian",
			"Skull Bash",
			"Growl")
		c.DelayPriorityFlash(
			"Thrash(Bear Form) for Weakened Blows",
			"Healing Touch for Guardian",
			"Rejuvenation for Guardian",
			"Thrash(Bear Form) for Damage",
			"Mangle(Bear Form) for Guardian",
			"Mangle(Bear Form) Delay",
			"Rejuvenation Refresh for Guardian",
			"Swipe(Bear Form) for AoE",
			"Swipe(Bear Form) for AoE Delay",
			"Thrash(Bear Form) for AoE",
			"Thrash(Bear Form) for Bleed",
			"Faerie Fire for Debuff for Guardian",
			"Enrage",
			"Lacerate for Guardian",
			"Faerie Fire",
			"Thrash(Bear Form)")
	end,
	
	FlashOutOfCombat = function()
		c.FlashAll("Symbiosis", "Healing Touch Solo", "Bone Shield")
	end,
	
	FlashAlways = function()
		c.FlashAll("Mark of the Wild", "Bear Form")
	end,
	
	SpellDamage = monitorPendPrimalRage,
	
	AutoAttack = monitorPendPrimalRage,
	
	Energized = monitorConsumePrimalRage,
	
	ExtraDebugInfo = function()
		return string.format("r:%.1f b:%.2f", a.Rage, c.GetBusyTime())
	end,
}

------------------------------------------------------------------- Restoration
a.Rotations.Restoration = {
	Spec = 4,
	
	UsefulStats = { "Intellect", "Spirit", "Crit", "Haste" },
	
	FlashInCombat = function()
		c.FlashAll(
			"Force of Nature: Restoration", 
			"Lifebloom",
			"Swiftmend",
			"Nourish",
			"Healing Touch for Restoration",
			"Regrowth",
			"Wild Mushroom",
			"Innervate",
			"Renewal",
			"Cenarion Ward for Restoration",
			"Soothe")
	end,
	
	FlashAlways = function()
		c.FlashAll("Mark of the Wild")
	end,
	
	AuraApplied = function(spellID, target)
		if c.IdMatches(spellID, "Lifebloom") then
			a.LifebloomTarget = target
			c.Debug("Event", "Lifebloom on", target)
		end
	end,
}
