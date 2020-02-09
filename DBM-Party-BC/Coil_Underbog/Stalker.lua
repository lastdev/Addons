local mod	= DBM:NewMod(579, "DBM-Party-BC", 5, 262)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190417010024")
mod:SetCreatureID(17882)
mod:SetEncounterID(1948)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)