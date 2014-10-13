local mod	= DBM:NewMod(536, "DBM-Party-BC", 8, 250)
local L		= mod:GetLocalizedStrings()

<<<<<<< HEAD
mod:SetRevision(("$Revision: 540 $"):sub(12, -3))
=======
mod:SetRevision(("$Revision: 526 $"):sub(12, -3))
>>>>>>> 4813c50ec5e1201a0d218a2d8838b8f442e2ca23
mod:SetCreatureID(22930)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
<<<<<<< HEAD
)
mod.onlyHeroic = true
=======
)
>>>>>>> 4813c50ec5e1201a0d218a2d8838b8f442e2ca23
