local mod	= DBM:NewMod(453, "DBM-Party-Vanilla", DBM:IsPostCata() and 10 or 16, 236)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241103114940")
mod:SetCreatureID(10438)
mod:SetEncounterID(481)
mod:SetZone(329)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 16869",
	"SPELL_AURA_APPLIED 16869"
)

local warningIceTomb				= mod:NewTargetNoFilterAnnounce(16869, 3)

local timerIceTombCD				= mod:NewAITimer(180, 16869, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON)

function mod:OnCombatStart(delay)
	timerIceTombCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpell(16869) then
		timerIceTombCD:Start()
	end
end


function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpell(16869) then
		warningIceTomb:Show(args.destName)
	end
end
