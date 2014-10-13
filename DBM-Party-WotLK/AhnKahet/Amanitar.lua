local mod	= DBM:NewMod(583, "DBM-Party-WotLK", 1, 271)
local L		= mod:GetLocalizedStrings()

<<<<<<< HEAD
mod:SetRevision(("$Revision: 157 $"):sub(12, -3))
=======
mod:SetRevision(("$Revision: 112 $"):sub(12, -3))
>>>>>>> 4813c50ec5e1201a0d218a2d8838b8f442e2ca23
mod:SetCreatureID(30258)
mod:SetEncounterID(262)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START"
)
mod.onlyHeroic = true

local warningMini	= mod:NewSpellAnnounce(57055, 3)
local timerMiniCD	= mod:NewCDTimer(30, 57055)

function mod:SPELL_CAST_START(args)
	if args.spellId == 57055 then
		warningMini:Show()
		timerMiniCD:Start()
	end
end