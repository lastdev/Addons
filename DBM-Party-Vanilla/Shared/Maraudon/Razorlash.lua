local mod	= DBM:NewMod(424, "DBM-Party-Vanilla", DBM:IsPostCata() and 6 or 8, 232)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241103114940")
mod:SetCreatureID(12258)
mod:SetEncounterID(423)
mod:SetZone(349)

mod:RegisterCombat("combat")
