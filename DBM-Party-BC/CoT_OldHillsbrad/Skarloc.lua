local mod	= DBM:NewMod(539, "DBM-Party-BC", 11, 251)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 598 $"):sub(12, -3))
mod:SetCreatureID(17862)
mod:SetEncounterID(1907)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 29427",
	"SPELL_AURA_APPLIED 13005",
	"SPELL_AURA_REMOVED 13005",
	"SPELL_PERIODIC_DAMAGE 38385",
	"SPELL_PERIODIC_MISSED 38385"
)

local warnHammer                = mod:NewTargetAnnounce(13005, 2)

local specWarnHeal				= mod:NewSpecialWarningInterrupt(29427, "HasInterrupt")
local specWarnConsecration		= mod:NewSpecialWarningMove(38385)

local timerHammer               = mod:NewTargetTimer(6, 13005)

function mod:SPELL_CAST_START(args)
	if args.spellId == 29427 then
		specWarnHeal:Show(args.sourceName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 13005 then
		warnHammer:Show(args.destName)
		timerHammer:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 13005 then
		timerHammer:Stop(args.destName)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 38385 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnConsecration:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
