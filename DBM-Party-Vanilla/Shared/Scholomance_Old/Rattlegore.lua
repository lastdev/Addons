local mod	= DBM:NewMod("Rattlegore", "DBM-Party-Vanilla", DBM:IsRetail() and 16 or 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20231012014002")
mod:SetCreatureID(11622)

mod:RegisterCombat("combat")
