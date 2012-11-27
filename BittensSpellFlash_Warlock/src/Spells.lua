local AddonName, a = ...
if a.BuildFail(50000) then return end
local s = SpellFlashAddon
local x = s.UpdatedVariables
local c = BittensSpellFlashLibrary

--local GetItemCount = GetItemCount
local UnitLevel = UnitLevel
local GetSpellBookItemName = GetSpellBookItemName
local GetTime = GetTime
local SPELL_POWER_BURNING_EMBERS = SPELL_POWER_BURNING_EMBERS
local SPELL_POWER_SOUL_SHARDS = SPELL_POWER_SOUL_SHARDS
--local UnitExists = UnitExists
--local IsMounted = IsMounted

c.Init(a)

------------------------------------------------------------------------ Common
local petIdentifiers = {
	[s.SpellName(c.GetID("Firebolt"), true)] = "Imp",
	[s.SpellName(c.GetID("Felbolt"), true)] = "Fel Imp",
	[s.SpellName(c.GetID("Torment"), true)] = "Voidwalker",
	[s.SpellName(c.GetID("Tongue Lash"), true)] = "Observer",
	[s.SpellName(c.GetID("Shadow Bite"), true)] = "Felhunter",
	[s.SpellName(c.GetID("Lash of Pain"), true)] = "Succubus",
}

function a.GetCurrentPet()
	for i = 1, 10000 do
		local spell = GetSpellBookItemName(i, "pet")
		if spell == nil then
			return nil
		end
		
		local pet = petIdentifiers[spell]
		if pet ~= nil then
			return pet
		end
	end
end

c.AddOptionalSpell("Dark Intent", nil, {
	Override = function()
		return c.RaidBuffNeeded(c.SPELL_POWER_BUFFS)
	end
})

c.AddOptionalSpell("Curse of the Elements", nil, {
	Debuff = c.MAGIC_VULNERABILITY_DEBUFFS
})

c.AddInterrupt("Spell Lock", nil, {
	NoGCD = true,
})

c.AddInterrupt("Optical Blast", nil, {
	NoGCD = true,
})

-------------------------------------------------------------------- Affliction
local function shouldRefreshDot(name, baseLength, earlyRefresh)
	if c.IsCastingOrInAir(name) then
		return false
	end
	
	local duration = c.GetMyDebuffDuration(name)
	if s.HasSpell(c.GetID("Pandemic")) then
		return duration < baseLength / 2 - 2
	else
		return duration < earlyRefresh + .1
	end
end

c.RegisterForFullChannels("Malefic Grasp", 4)
c.AssociateTravelTimes(.8, "Haunt")

c.AddOptionalSpell("Soulburn", "under Dark Soul: Misery", {
	CheckFirst = function()
		return c.HasBuff("Dark Soul: Misery") 
			and GetTime() - a.LastDarkSoul > 30
			and not c.HasBuff("Soulburn")
	end
})

c.AddSpell("Soulburn", "during Execute", {
	CheckFirst = function()
		if c.HasBuff("Soulburn") or c.IsCasting("Soulburn") then
			return false
		else
			return c.GetSpell("Agony"):CheckFirst()
				or c.GetSpell("Corruption"):CheckFirst()
				or c.GetSpell("Unstable Affliction"):CheckFirst()
		end
	end
})

c.AddOptionalSpell("Soul Swap", "under Soulburn", {
	CheckFirst = function()
		return c.HasBuff("Soulburn")
	end
})

c.AddSpell("Soul Swap", "during Execute", {
	CheckFirst = function()
		return c.HasBuff("Soulburn")
	end
})

c.AddOptionalSpell("Dark Soul: Misery", nil, {
	CheckFirst = function()
		return a.Shards > 0
	end
})

c.AddOptionalSpell("Grimoire: Felhunter")

c.AddSpell("Haunt", nil, {
	CheckFirst = function(z)
		if a.Shards == 0
			or not c.ShouldCastToRefresh("Haunt", "Haunt", 0, true) then
			
			return false
		end
		
		if a.Shards >= s.MaxPower("player", SPELL_POWER_SOUL_SHARDS) - 1 
			or GetTime() + c.GetBusyTime() - a.LastDarkSoul < 30 then
			
			z.FlashColor = nil
			z.Continue = nil
			z.FlashSize = nil
			return true
		end
		
		local miseryCD = c.GetCooldown("Dark Soul: Misery")
		if miseryCD < 35 then
			return false
		end
		
		z.FlashColor = "yellow"
		z.Continue = true
		local castTime = c.GetCastTime("Haunt")
		if miseryCD < castTime then
			z.FlashSize = nil
		else
			z.FlashSize = s.FlashSizePercent() / 2
		end
		return true
	end
})

c.AddSpell("Agony", nil, {
	CheckFirst = function()
		return shouldRefreshDot("Agony", 24, c.GetHastedTime(4))
	end
})

c.AddSpell("Corruption", nil, {
	EarlyRefresh = 99,
	CheckFirst = function(z)
		return shouldRefreshDot("Corruption", 18, z.EarlyRefresh)
	end
})
c.ManageDotRefresh("Corruption", 2)

c.AddSpell("Unstable Affliction", nil, {
	EarlyRefresh = 99,
	CheckFirst = function(z)
		return shouldRefreshDot("Unstable Affliction", 14, z.EarlyRefresh)
	end
})
c.ManageDotRefresh("Unstable Affliction", 2)

c.AddOptionalSpell("Life Tap", "for Affliction", {
	CheckFirst = function()
		if c.HasBuff("Dark Soul: Misery") or c.HasBuff(c.BLOODLUST_BUFFS) then
			return false
		end
		
		if s.HealthPercent() <= 20 then
			return s.PowerPercent("player") < 10
		else
			return s.PowerPercent("player") < 50
		end
	end
})

------------------------------------------------------------------- Destruction
c.AddOptionalSpell("Dark Soul: Instability")

c.AddOptionalSpell("Grimoire: Imp")

c.AddSpell("Immolate", nil, {
	CheckFirst = function()
		if c.IsCastingOrInAir("Immolate") then
			return false
		end
		
		local cinCast = c.GetCastTime("Incinerate")
		local realDraft = s.Buff(c.GetID("Backdraft"), "player")
		if a.Backdraft > 0 and not realDraft then
			cinCast = cinCast / 1.3
		elseif a.Backdraft == 0 and realDraft then
			cinCast = cinCast * 1.3
		end
		return c.GetMyDebuffDuration("Immolate") 
			< c.GetCastTime("Immolate") + cinCast + .1
	end
})

c.AddSpell("Chaos Bolt", "if Capped", {
	CheckFirst = function()
		return s.MaxPower("player", SPELL_POWER_BURNING_EMBERS) - a.Embers 
				< .5
			or c.GetBuffDuration("Dark Soul: Instability") 
				> c.GetCastTime("Chaos Bolt")
	end
})

c.AddSpell("Conflagrate", nil, {
	CheckFirst = function()
		return a.Backdraft == 0
	end
})
