local mod	= DBM:NewMod(178, "DBM-Party-Cataclysm", 11, 76, 1)
local L		= mod:GetLocalizedStrings()

<<<<<<< HEAD
mod:SetRevision(("$Revision: 121 $"):sub(12, -3))
=======
mod:SetRevision(("$Revision: 88 $"):sub(12, -3))
>>>>>>> 4813c50ec5e1201a0d218a2d8838b8f442e2ca23
mod:SetCreatureID(52271)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED"
)
mod.onlyHeroic = true

