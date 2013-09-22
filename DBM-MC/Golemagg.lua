local mod	= DBM:NewMod("Golemagg", "DBM-MC", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 500 $"):sub(12, -3))
mod:SetCreatureID(11988)--, 11672
mod:SetModelID(11986)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local warnTrust		= mod:NewSpellAnnounce(20553)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 20553 then
		warnTrust:Show()
	end
end
