local AddonName, a = ...
if a.BuildFail(50000) then return end
local s = SpellFlashAddon
local x = s.UpdatedVariables
local c = BittensSpellFlashLibrary

--local GetItemCount = GetItemCount
local UnitLevel = UnitLevel
local GetSpellBookItemName = GetSpellBookItemName
--local GetTime = GetTime
local SPELL_POWER_BURNING_EMBERS = SPELL_POWER_BURNING_EMBERS
--local SPELL_POWER_SOUL_SHARDS = SPELL_POWER_SOUL_SHARDS
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
c.RegisterForFullChannels("Malefic Grasp", 4)
c.AssociateTravelTimes(.8, "Haunt")

c.AddOptionalSpell("Soulburn", "under Dark Soul: Misery", {
	CheckFirst = function()
		local duration = c.GetBuffDuration("Dark Soul: Misery")
		return duration >= 18.5	or (duration > .1 and duration < 1.5)
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

c.AddOptionalSpell("Dark Soul: Misery")

c.AddOptionalSpell("Grimoire: Felhunter")

c.AddSpell("Haunt", nil, {
	CheckFirst = function()
		return c.ShouldCastToRefresh("Haunt", "Haunt", 0, true)
	end
})

c.AddSpell("Agony", nil, {
	CheckFirst = function()
		return c.GetMyDebuffDuration("Agony") < c.GetHastedTime(4) + .1
			and not c.IsCastingOrInAir("Agony")
	end
})

c.AddSpell("Corruption", nil, {
	EarlyRefresh = 99,
	CheckFirst = function(z)
		return c.GetMyDebuffDuration("Corruption") < z.EarlyRefresh
			and not c.IsCastingOrInAir("Corruption")
	end
})
c.ManageDotRefresh("Corruption", 2)

c.AddSpell("Unstable Affliction", nil, {
	EarlyRefresh = 99,
	CheckFirst = function(z)
		return c.GetMyDebuffDuration("Unstable Affliction") < z.EarlyRefresh
			and not c.IsCastingOrInAir("Unstable Affliction")
	end
})
c.ManageDotRefresh("Unstable Affliction", 2)

c.AddSpell("Life Tap", nil, {
	CheckFirst = function()
		return s.PowerPercent("player") < 35
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
