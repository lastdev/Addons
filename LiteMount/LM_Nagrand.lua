--[[----------------------------------------------------------------------------

  LiteMount/LM_Nagrand.lua

  Nagrand mounts, Telaari Talbuk and Frostwolf War Wolf.

  Draenor Ability spells are weird.

  The name of the Garrison Ability (localized) is
        name = GetSpellInfo(161691)
  But,
        GetSpellInfo(name)
  returns the actual current spell that's active.

  Copyright 2011-2021 Mike Battersby

----------------------------------------------------------------------------]]--

local _, LM = ...

--[==[@debug@
if LibDebug then LibDebug() end
--@end-debug@]==]

LM.Nagrand = setmetatable({ }, LM.Spell)
LM.Nagrand.__index = LM.Nagrand

function LM.Nagrand:Get(spellID, faction, ...)
    local m = LM.Spell.Get(self, spellID, ...)

    if m then
        local playerFaction = UnitFactionGroup("player")
        m.baseSpellID = LM.SPELL.GARRISON_ABILITY
        m.baseSpellName = GetSpellInfo(m.baseSpellID)
        m.isFiltered = ( playerFaction ~= faction )
        m.needsFaction = faction
        m.isCollected = (not m.isFiltered) and IsSpellKnown(m.baseSpellID)
    end

    return m
end

function LM.Nagrand:Refresh()
    self.isCollected = IsSpellKnown(self.baseSpellID)
    LM.Mount.Refresh(self)
end

function LM.Nagrand:GetCastAction(context)
    return LM.SecureAction:Spell(self.baseSpellName)
end

-- Check if the spell is in one of the zone spell slots.

function LM.Nagrand:IsCastable()
    local zoneAbilities = C_ZoneAbility.GetActiveAbilities()
    for _,info in ipairs(zoneAbilities) do
        local zoneSpellName = GetSpellInfo(info.spellID)
        local zoneSpellID = select(7, GetSpellInfo(zoneSpellName))
        if zoneSpellID == self.spellID then
            return IsUsableSpell(info.spellID) and LM.Mount.IsCastable(self)
        end
    end
    return false
end
