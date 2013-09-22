local addonName, a = ...
local L = a.Localize
local s = SpellFlashAddon
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

local GetPowerRegen = GetPowerRegen
local GetTime = GetTime
local SPELL_POWER_CHI = SPELL_POWER_CHI
local SPELL_POWER_ENERGY = SPELL_POWER_ENERGY
local select = select
local string = string
local tostring = tostring
local wipe = wipe

local lastPowerStrike = 0

local function setCost(info)
	info.Cost[SPELL_POWER_ENERGY] = a.GetEnergyCost(info.Name)
	info.Cost[SPELL_POWER_CHI] = a.GetChiCost(info.Name)
end

a.Rotations = { }

function a.PreFlash()
	a.Regen = select(2, GetPowerRegen())
	a.Power = c.GetPower(a.Regen, SPELL_POWER_ENERGY)
	a.Chi = c.GetPower(0, SPELL_POWER_CHI)
	a.MissingChi = s.MaxPower("player", SPELL_POWER_CHI) - a.Chi
	
--c.Debug("Power Calcs", a.Chi, a.Power, a.Regen,
--c.HasBuff("Combo Breaker: Blackout Kick"), c.HasBuff("Combo Breaker: Tiger Palm"))
end

-------------------------------------------------------------------------- Noob
a.Rotations.Noob = {
	FlashInCombat = function()
		if s.Flashable(c.GetID("Blackout Kick")) then
			c.PriorityFlash(
				"Tiger Palm for Tiger Power", "Blackout Kick", "Jab")
		else
			c.PriorityFlash("Tiger Palm", "Jab")
		end
	end,
	
	FlashAlways = function()
		c.FlashAll("Roll")
	end,
	
	CastQueued = setCost,
}

-------------------------------------------------------------------- Brewmaster
local uncontrolledMitigationBuffs = {
	"Diffuse Magic",
	"Staggering", -- 2pT15
}
a.Rotations.Brewmaster = {
	Spec = 1,
	
	UsefulStats = { 
		"Agility", "Dodge", "Parry", "Tanking Hit", "Stamina", "Crit", "Haste" 
	},
	
	FlashInCombat = function()
		a.Trained = c.HasSpell("Brewmaster Training")
		a.Shuffle = c.GetBuffDuration("Shuffle")
		if c.IsQueued("Blackout Kick") then
			a.Shuffle = a.Shuffle + 6
		end
		c.FlashAll(
			"Purifying Brew",
			"Chi Brew for Brewmaster",
			"Summon Black Ox Statue", 
			"Spear Hand Strike", 
			"Provoke")
		c.FlashMitigationBuffs(
			1,
			uncontrolledMitigationBuffs,
			c.COMMON_TANKING_BUFFS,
			"Elusive Brew at 10",
			"Guard",
			"Dampen Harm",
			"Fortifying Brew",
			"Elusive Brew")
			
		if c.AoE and c.PriorityFlash(
			"Blackout Kick for Shuffle",
			"Expel Harm for Brewmaster",
			"Blackout Kick for AoE",
			"Keg Smash",
			"Breath of Fire",
			"Rushing Jade Wind",
			"Spinning Crane Kick") then
			
			return
		end
		
		if c.InDamageMode() then
			c.PriorityFlash(
				"Touch of Death",
				"Chi Wave",
				"Keg Smash",
				"Chi Burst",
				"Tiger Palm for Tiger Power",
				"Breath of Fire for DoT",
				"Blackout Kick",
				"Expel Harm for Brewmaster",
				"Jab for Brewmaster",
				"Zen Sphere",
				"Tiger Palm for Brewmaster")
		else
			c.PriorityFlash(
				"Touch of Death",
				"Blackout Kick for Shuffle",
				"Keg Smash for Dizzying Haze",
				"Expel Harm for Brewmaster",
				"Chi Wave for Brewmaster",
				"Zen Sphere",
				"Chi Burst for Brewmaster",
				"Blackout Kick for Extended Shuffle",
				"Keg Smash for Chi",
				"Jab for Brewmaster",
				"Tiger Palm for Brewmaster")
		end
	end,
	
	FlashAlways = function()
		c.FlashAll("Stance of the Sturdy Ox", "Legacy of the Emperor", "Roll")
	end,
	
	CastQueued = setCost,
	
	ExtraDebugInfo = function()
		return string.format("c:%d e:%.1f s:%.1f b:%.1f", 
			a.Chi, a.Power, a.Shuffle, c.GetBusyTime())
	end,
}

-------------------------------------------------------------------- Mistweaver
a.Rotations.Mistweaver = {
	Spec = 2,
	AoEColor = "orange",
	
	UsefulStats = { "Intellect", "Spirit", "Crit", "Haste" },
	
	FlashInCombat = function()
		if c.IsCasting("Soothing Mist") or c.IsQueued("Soothing Mist") then
			a.SoothDamage = s.HealthDamagePercent(a.SoothTarget)
		else
			a.SoothDamage = 0
		end
		
		c.FlashAll(
			"Spear Hand Strike", 
			"Chi Brew for Mistweaver",
			"Mana Tea", 
			"Enveloping Mist",
			"Surging Mist", 
			"Uplift",
			"Summon Jade Serpent Statue")
			
		if not c.HasSpell("Muscle Memory") then
			return
		end
		
		if c.IsCasting("Tiger Palm", "Blackout Kick") then
			a.MuscleMemory = false
		elseif c.IsCasting(
			"Jab", "Spinning Crane Kick", "Rushing Jade Wind") then
			
			a.MuscleMemory = true
		else
			a.MuscleMemory = c.HasBuff("Muscle Memory")
		end
		if a.MuscleMemory
			or s.PowerPercent("player") > c.GetOption("MeleeCutoff")
			or c.IsSolo() then
		
			c.PriorityFlash(
				"Touch of Death for Mistweaver",
				"Blackout Kick for Serpent's Zeal",
				"Chi Wave for Mistweaver",
				"Expel Harm for Mistweaver",
				"Tiger Palm for Mistweaver",
				"Rushing Jade Wind for Mistweaver",
				"Spinning Crane Kick for Mistweaver",
				"Jab for Mistweaver",
				"Crackling Jade Lightning")
		end
	end,
	
	FlashAlways = function()
		c.FlashAll(
			"Stance of the Wise Serpent", "Legacy of the Emperor", "Roll")
	end,
	
	CastQueued = function(info)
		setCost(info)
		if c.InfoMatches(info, "Soothing Mist") then
			a.SoothTarget = info.Target
			c.Debug("Event", "Soothing Mist cast at", a.SoothTarget)
		end
	end,
	
	ExtraDebugInfo = function()
		return string.format("c:%d m:%s s:%s d:%.1f", 
			a.Chi, 
			tostring(a.MuscleMemory),
			a.SoothTarget or "none", 
			a.SoothDamage or 0)
	end,
}

-------------------------------------------------------------------- Windwalker
a.SefTargets = { }

a.Rotations.Windwalker = {
	Spec = 3,
	
	UsefulStats = { "Agility", "Melee Hit", "Strength", "Crit", "Haste" },
	
	FlashInCombat = function()
		if not c.HasBuff("Storm, Earth, and Fire") then
			wipe(a.SefTargets)
		end
		
		c.FlashAll(
			"Storm, Earth, and Fire",
			"Tigereye Brew", 
			"Chi Brew for Windwalker",
			"Energizing Brew", 
			"Spear Hand Strike")
		
		if c.AoE then
			local flashing = c.PriorityFlash(
				"Rising Sun Kick for Debuff",
				"Tiger Palm for Tiger Power",
				"Invoke Xuen, the White Tiger",
				"Rushing Jade Wind",
				"Spinning Crane Kick",
				"Flying Serpent Kick 1",
				"Chi Wave",
				"Zen Sphere",
				"Chi Burst")
			if flashing and not c.GetSpell(flashing).Continue then
				return
			end
		end
		
		c.PriorityFlash(
			"Touch of Death",
			"Rising Sun Kick for Debuff",
			"Tiger Palm for Tiger Power",
			"Invoke Xuen, the White Tiger",
			"Rising Sun Kick",
			"Fists of Fury",
			"Blackout Kick under Combo Breaker",
			"Chi Wave for Windwalker",
			"Tiger Palm under Combo Breaker",
			"Expel Harm for Windwalker",
			"Jab for Windwalker",
			"Blackout Kick without blocking RSK",
			"Chi Wave",
			"Chi Burst",
			"Flying Serpent Kick 1",
			"Zen Sphere")
	end,
	
	FlashAlways = function()
		c.FlashAll(
			"Stance of the Fierce Tiger", 
			"Legacy of the Emperor", 
			"Legacy of the White Tiger", 
			"Roll")
	end,
	
	CastQueued = setCost,
	
	CastSucceeded = function(info)
		if info.TargetID and c.InfoMatches(info, "Storm, Earth, and Fire") then
			a.SefTargets[info.TargetID] = true
			c.Debug("Event", 
				"Storm, Earth, and Fire on", info.Target, info.TargetID)
		end
	end,
	
	UncastSpellFailed = function(info)
		if info.TargetID and c.InfoMatches(info, "Storm, Earth, and Fire") then
			a.SefTargets[info.TargetID] = nil
			c.Debug("Event", 
				"Storm, Earth, and Fire removed from", 
				info.Target, 
				info.TargetID)
		end
	end,
	
	ExtraDebugInfo = function()
		return string.format("%d, %.1f", a.Chi, a.Power)
	end,
}
