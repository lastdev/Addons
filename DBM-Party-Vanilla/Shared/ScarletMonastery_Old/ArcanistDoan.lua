local mod	= DBM:NewMod("ArcanistDoan", "DBM-Party-Vanilla", DBM:IsPostCata() and 17 or 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241214052000")
mod:SetCreatureID(6487)
mod:SetEncounterID(447)
mod:SetZone(189)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 9435 8988",
	"SPELL_CAST_SUCCESS 9433",
	"SPELL_AURA_APPLIED 13323"
)

local warningPolymorph				= mod:NewTargetNoFilterAnnounce(13323, 2)
local warningSilence				= mod:NewCastAnnounce(8988, 2)
local warningArcaneExplosion		= mod:NewSpellAnnounce(9433, 2, nil, false, 2)--Can be spammy if cast multiple times in succession

local specWarnDetonation			= mod:NewSpecialWarningRun(9435, nil, nil, nil, 4, 2)

--local timerDetonationCD			= mod:NewCDTimer(180, 9435, nil, nil, nil, 2)
local timerSilenceCD				= mod:NewVarTimer("v15.5-19", 8988, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)--15-19

function mod:OnCombatStart(delay)
	--timerDetonationCD:Start(17.5-delay)--17.5-24
	timerSilenceCD:Start(string.format("v%s-%s", 9.9-delay, 16-delay))--9.9-16
end

function mod:SPELL_CAST_START(args)
	if args:IsSpell(9435) then
		specWarnDetonation:Show()
		specWarnDetonation:Play("justrun")
		--timerDetonationCD:Start()
	elseif args:IsSpell(8988) and args:IsSrcTypeHostile() then
		warningSilence:Show()
		timerSilenceCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpell(9433) and args:IsSrcTypeHostile()  then
		warningArcaneExplosion:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpell(13323) and args:IsDestTypePlayer() then
		warningPolymorph:Show(args.destName)
	end
end
