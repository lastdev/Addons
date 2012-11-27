local AddonName, a = ...
if a.BuildFail(50000) then return end
local L = a.Localize
local s = SpellFlashAddon
local c = BittensSpellFlashLibrary

c.Init(a)

------------------------------------------------------------------------ Common
local bothShouts = { c.GetID("Battle Shout"), c.GetID("Commanding Shout") }
local function chooseShout(z, fail)
	if fail then
		return false
	end
	
	local battleID = c.GetID("Battle Shout")
	local commandID = c.GetID("Commanding Shout")
	if s.MyBuff(battleID, "player")
		or not s.Buff(c.ATTACK_POWER_BUFFS, "player") then
		
		z.ID = battleID
		z.FlashID = nil
	elseif s.MyBuff(commandID, "player")
		or not s.Buff(c.STAMINA_BUFFS, "player") then
		
		z.ID = commandID
		z.FlashID = nil
	else
		if s.Flashable(battleID) then
			z.ID = battleID
		else
			z.ID = commandID
		end
		z.FlashID = bothShouts
	end
	return true
end

c.AddSpell("Shout", nil, {
	ID = 0,
	CheckFirst = chooseShout
})

c.AddSpell("Shout", "for Rage", {
	ID = 0,
	CheckFirst = function(z)
		return chooseShout(z, s.MaxPower("player") - a.Rage < 30)
	end
})

c.AddSpell("Shout", "for Rage unless Colossus Smash", {
	ID = 0,
	CheckFirst = function(z)
		return chooseShout(
			z, 
			s.MaxPower("player") - a.Rage < 30 
				or c.HasMyDebuff("Colossus Smash"))
	end
})

c.AddOptionalSpell("Dps Stance", nil, {
	Type = "form",
	ID = "Battle Stance",
	FlashID = { "Battle Stance", "Berserker Stance" },
	CheckFirst = function()
		return not s.Form(c.GetID("Battle Stance"))
			and not s.Form(c.GetID("Berserker Stance"))
	end
})

c.AddSpell("Colossus Smash", nil, {
	CheckFirst = function()
		return c.GetMyDebuffDuration("Colossus Smash") < 1.5
	end
})

c.AddSpell("Shockwave", nil, {
	Melee = true,
})

c.AddSpell("Dragon Roar", nil, {
	Melee = true,
})

c.AddOptionalSpell("Berserker Rage", nil, {
	NoGCD = true,
	CheckFirst = function()
		return not a.Enraged
	end
})

c.AddOptionalSpell("Heroic Leap", nil, {
	NoGCD = true,
	NoRangeCheck = true,
	CheckFirst = function()
		return c.HasMyDebuff("Colossus Smash")
	end
})

c.AddOptionalSpell("Deadly Calm", nil, {
	NoGCD = true,
	CheckFirst = function()
		return a.Rage >= 40
	end
})

c.AddInterrupt("Pummel")

-------------------------------------------------------------------------- Arms
c.AddOptionalSpell("Deadly Calm", "for Arms", {
	NoGCD = true,
	CheckFirst = function()
		local duration = c.GetMyDebuffDuration("Colossus Smash")
		return a.Rage >= 40 
			and (duration > 1.6 
				or (duration > .1 and c.GetCooldown("Colossus Smash") == 0))
	end
})

c.AddOptionalSpell("Heroic Strike", "for Arms", {
	NoGCD = true,
	CheckFirst = function()
		local cs = c.GetMyDebuffDuration("Colossus Smash")
		if cs == 0 then
			return false
		end
		
		if s.MaxPower("player") - a.Rage <= 10 then
			return true
		end
		
		if c.HasBuff("Deadly Calm") then
			return true
		end
		
		if c.GetBuffStack("Taste for Blood") == 5 
			and c.HasBuff("Overpower") then
			
			return true
		end
		
		local tb = c.GetBuffDuration("Taste for Blood")
		if tb == 0 then
			return false
		end
		
		return tb <= 2
			or (cs <= 2 and c.GetCooldown("Colossus Smash") > 2)
	end
})

c.AddSpell("Bladestorm", "for Arms", {
	Melee = true,
	CheckFirst = function()
		return c.GetCooldown("Colossus Smash") >= 5
			and not c.HasMyDebuff("Colossus Smash")
			and c.GetCooldown("Bloodthirst") >= 2
	end
})

c.AddSpell("Slam", "with Colossus Smash or High Rage", {
	CheckFirst = function()
		return c.HasMyDebuff("Colossus Smash")
			or s.MaxPower("player") - a.Rage < 30
	end
})

-------------------------------------------------------------------------- Fury
function a.ShouldFlashBloodthirst()
	return not a.InExecute
		or a.Rage < 30
		or not c.HasMyDebuff("Colossus Smash")
end

c.AddOptionalSpell("Recklessness", nil, {
	NoGCD = true,
	FlashSize = s.FlashSizePercent() / 2,
	CheckFirst = function(z)
		return a.InExecute
			and (c.GetMyDebuffDuration("Colossus Smash", true) > 5
				or c.GetCooldown("Colossus Smash", true) <= 4)
	end
})

c.AddOptionalSpell("Heroic Strike", nil, {
	NoGCD = true,
	CheckFirst = function()
		if s.MaxPower("player") - a.Rage <= 10 then
			return true
		end
		
		if a.InExecute then
			return false
		end
		
		if c.HasBuff("Deadly Calm") then
			return a.Rage >= 30
		end
		
		if c.HasMyDebuff("Colossus Smash") then
			return a.Rage >= 40
		end
	end
})

c.AddSpell("Bloodthirst", nil, {
	CheckFirst = a.ShouldFlashBloodthirst
})

c.AddSpell("Wild Strike", "under Bloodsurge", {
	CheckFirst = function()
		return c.HasBuff("Bloodsurge")
	end
})

c.AddSpell("Wild Strike", "under Colossus Smash", {
	CheckFirst = function()
		return c.HasMyDebuff("Colossus Smash")
	end
})

c.AddSpell("Wild Strike", "at 60 unless Colossus Smash", {
	CheckFirst = function()
		return a.Rage >= 60 and c.GetCooldown("Colossus Smash") >= 1
	end
})

c.AddSpell("Bladestorm", "for Fury", {
	CheckFirst = function()
		return not c.HasMyDebuff("Colossus Smash")
			and c.GetCooldown("Colossus Smash") >= 5
			and c.GetCooldown("Bloodthirst") >= 2
	end
})
