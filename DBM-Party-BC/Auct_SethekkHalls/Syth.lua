local mod = DBM:NewMod(541, "DBM-Party-BC", 9, 252)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 494 $"):sub(12, -3))

mod:SetCreatureID(18472)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_SUMMON"
)

local warnSummon   = mod:NewSpellAnnounce("ej5235", 3)

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(33537, 33538, 33539, 33540) and self:AntiSpam() then
		warnSummon:Show()
	end
end
