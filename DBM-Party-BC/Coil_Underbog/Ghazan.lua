local mod	= DBM:NewMod(577, "DBM-Party-BC", 5, 262)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190417010024")
mod:SetCreatureID(18105)
mod:SetEncounterID(1945)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)