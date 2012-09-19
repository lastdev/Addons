local AddonName, a = ...
if a.BuildFail(50000) then return end
local L = a.Localize
local s = SpellFlashAddon
local c = BittensSpellFlashLibrary
local bcm = a.BCM

local GetItemCount = GetItemCount
local UnitBuff = UnitBuff

c.Init(a)

------------------------------------------------------------------------ Common
c.AddOptionalSpell("Mage Armor", nil, {
	Buff = "Mage Armor",
	BuffUnit = "player",
})

c.AddOptionalSpell("Conjure Mana Gem", nil, {
	NotIfActive = true,
	CheckFirst = function()
		if c.HasGlyph("Mana Gem") then
			return GetItemCount(c.GetID("Brilliant Mana Gem"), false, true) < 7
		else
			return GetItemCount(c.GetID("Mana Gem"), false, true) < 3
		end 
	end	
})

c.AddOptionalSpell("Mana Gem", nil, {
	Type = "item",
	CheckFirst = function()
		return a.ManaPercent < 80
	end
})

c.AddOptionalSpell("Brilliant Mana Gem", nil, {
	Type = "item",
	CheckFirst = function()
		return a.ManaPercent < 80
	end
})

c.AddOptionalSpell("Mirror Image")

c.AddOptionalSpell("Arcane Brilliance", nil, {
	NoRangeCheck = 1,
	CheckFirst = function()
		return c.RaidBuffNeeded(c.SPELL_POWER_BUFFS)
			or c.RaidBuffNeeded(c.CRIT_BUFFS)
	end
})

c.AddOptionalSpell("Dalaran Brilliance", nil, {
	NoRangeCheck = 1,
	CheckFirst = function()
		return c.RaidBuffNeeded(c.SPELL_POWER_BUFFS)
			or c.RaidBuffNeeded(c.CRIT_BUFFS)
	end
})

c.AddInterrupt("Counterspell")

c.AddOptionalSpell("Spellsteal", nil, {
	FlashColor = "aqua",
	CheckFirst = function()
		local unit = s.UnitSelection()
		if unit == nil or not s.Enemy(unit) then
			return false
		end
		
		for i = 1, 10000 do
			local _, _, _, _, _, _, _, _, isStealable, _, spellID
				= UnitBuff(unit, i)
			if spellID == nil then
				return false
			elseif isStealable then
				return true
			end
		end
	end
})

c.AddSpell("Nether Tempest", nil, {
	MyDebuff = "Nether Tempest",
	NoStopChannel = true,
})
c.ManageDotRefresh("Nether Tempest", 1)

c.AddSpell("Living Bomb", nil, {
	MyDebuff = "Living Bomb",
	NoStopChannel = true,
})

c.AddSpell("Frost Bomb", nil, {
	NoStopChannel = true,
	NotIfActive = true,
})

c.AddOptionalSpell("Presence of Mind", nil, {
	NoGCD = true,
})

c.AddOptionalSpell("Evocation", nil, {
	CheckFirst = function()
		return a.ManaPercent <= 10
	end
})

c.AddOptionalSpell("Molten Armor", nil, {
	Buff = "Molten Armor",
	BuffUnit = "player",
})

------------------------------------------------------------------------ Arcane
c.AddOptionalSpell("Arcane Power", nil, {
	CheckFirst = function()
		return a.ChargeStacks > 2 and a.StolenTimeRemaining == 0
	end
})

c.AddSpell("Arcane Blast", "at Cap", {
	CheckFirst = function(z)
		return a.ManaPercent > a.GetConfig("cap_percent")
	end
})

c.AddSpell("Arcane Barrage", nil, {
	NoStopChannel = true,
	CheckFirst = function()
		local burnLength = a.GetConfig("burn_length")
		local burnAmount = 100 - a.GetConfig("evocate_percent")
		
		local name = s.ItemName(c.GetID("Mana Gem"))
		if s.Flashable(name)
			and GetItemCount(name, false, true) > 0
			and s.ItemCooldown(name) < burnLength / burnAmount * 20 then
			
			return false
		end
		
		name = s.ItemName(c.GetID("Brilliant Mana Gem"))
		if s.Flashable(name)
			and GetItemCount(name, false, true) > 0
			and s.ItemCooldown(name) < burnLength / burnAmount * 20 then
			
			return false
		end
		
		name = s.SpellName(c.GetID("Evocation"))
		if s.Flashable(name)
			and s.SpellCooldown(name) < burnLength then
			
			return false
		end
		
		return true
	end
})

c.AddSpell("Evocation", "for Arcane", {
	CheckFirst = function()
		return a.ManaPercent <= a.GetConfig("evocate_percent")
	end
})

-------------------------------------------------------------------------- Fire
c.AssociateTravelTimes(.5, "Fireball", "Pyroblast", "Frostfire Bolt")
c.AssociateTravelTimes(.2, "Scorch", "Inferno Blast")

local function combustionCheckFirst(z, multiplier)
	local threshhold = a.GetConfig("combust_at") * multiplier
	if bcm.PredictDamage(false, false) >= threshhold then
		if bcm.PredictDamage(true, false) >= threshhold then
			z.FlashColor = "yellow"
		else
			z.FlashColor = "red"
		end
		return true
	end
end

c.AddOptionalSpell("Combustion", nil, {
	NoGCD = true,
	CheckFirst = function(z)
		return combustionCheckFirst(z, 1)
	end
})

c.AddOptionalSpell("Combustion", "when Big", {
	NoGCD = true,
	CheckFirst = function(z)
		return combustionCheckFirst(z, 1.4)
	end
})

c.AddSpell("Pyroblast", nil, {
	CheckFirst = function()
		return a.PyroProc 
			or c.HasBuff("Presence of Mind") 
			or c.IsCasting("Presence of Mind")
	end
})

c.AddSpell("Inferno Blast", nil, {
	CheckFirst = function()
		return a.HeatingProc
	end
})

c.AddSpell("Scorch", nil, {
	Continue = true,
	CheckFirst = function()
		return s.Moving("player")
	end
})

c.AddSpell("Frostfire Bolt", nil, {
	Continue = true,
	CheckFirst = function()
		return c.HasGlyph("Frostfire Bolt")
	end
})
