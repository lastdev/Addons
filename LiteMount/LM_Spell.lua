--[[----------------------------------------------------------------------------

  LiteMount/LM_Spell.lua

  A mount summoned directly from a spell with no Mount Journal entry.

  Copyright 2011 Mike Battersby

----------------------------------------------------------------------------]]--

local _, LM = ...

--[==[@debug@
if LibDebug then LibDebug() end
--@end-debug@]==]

LM.Spell = setmetatable({ }, LM.Mount)
LM.Spell.__index = LM.Spell

function LM.Spell:Get(spellID, ...)

    local name, _, icon = GetSpellInfo(spellID)

    if not name then
        LM.Debug("LM.Mount: Failed GetSpellInfo #"..spellID)
        return
    end

    local m = LM.Mount.new(self, spellID)

    m.name = name
    m.spellID = spellID
    m.icon = icon
    m.flags = { }

    for i = 1, select('#', ...) do
        local f = select(i, ...)
        m.flags[f] = true
    end

    return m
end

function LM.Spell:IsCollected()
    return IsSpellKnown(self.spellID)
end

function LM.Spell:IsCastable()
    if not IsSpellKnown(self.spellID) then
        return false
    end

    if not IsUsableSpell(self.spellID) then
        return false
    end

    if GetSpellCooldown(self.spellID) > 0 then
        return false
    end

    return LM.Mount.IsCastable(self)
end
