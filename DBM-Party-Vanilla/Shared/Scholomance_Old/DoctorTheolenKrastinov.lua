local mod	= DBM:NewMod("DoctorTheolenKrastinov", "DBM-Party-Vanilla", DBM:IsRetail() and 16 or 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20231012014002")
mod:SetCreatureID(11261)

mod:RegisterCombat("combat")
