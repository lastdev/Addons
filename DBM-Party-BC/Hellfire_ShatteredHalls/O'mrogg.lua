local mod	= DBM:NewMod("O'mrogg", "DBM-Party-BC", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 315 $"):sub(12, -3))
mod:SetCreatureID(16809)
mod:SetModelID(18031)

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
