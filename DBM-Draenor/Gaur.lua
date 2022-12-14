local mod	= DBM:NewMod("Gaur", "DBM-Draenor", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20201111213748")
mod:SetCreatureID(90943)

mod:RegisterCombat("combat")
mod:SetMinCombatTime(15)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 180830 180868 180879",
	"SPELL_CAST_SUCCESS 180879"
)

local warnGoren				= mod:NewSpellAnnounce(180879, 2)

local specWarnEarthenSlam	= mod:NewSpecialWarningSpell(180868, nil, nil, nil, 2, 2)
local specWarnRunicSpike	= mod:NewSpecialWarningSpell(180830, "Melee", nil, nil, 2, 2)

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 180830 then
		specWarnRunicSpike:Show()
		specWarnRunicSpike:Play("watchstep")
	elseif spellId == 180868 then
		specWarnEarthenSlam:Show()
		specWarnEarthenSlam:Play("carefly")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 180879 then
		warnGoren:Show()
	end
end
