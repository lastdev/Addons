local mod	= DBM:NewMod(537, "DBM-Party-BC", 8, 250)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,heroic,timewalker"

mod:SetRevision("20200912133955")
mod:SetCreatureID(18344)
mod:SetEncounterID(1899)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)
