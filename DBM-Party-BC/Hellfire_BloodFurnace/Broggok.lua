local mod	= DBM:NewMod(556, "DBM-Party-BC", 2, 256)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 494 $"):sub(12, -3))
mod:SetCreatureID(17380)

mod:RegisterCombat("combat")

mod:RegisterEvents(
)