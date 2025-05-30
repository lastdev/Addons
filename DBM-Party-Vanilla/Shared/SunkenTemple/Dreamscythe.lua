local mod	= DBM:NewMod("Dreamscythe", "DBM-Party-Vanilla", DBM:IsPostCata() and 12 or 17)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241103114940")
mod:SetCreatureID(5721)
mod:SetEncounterID(486)
mod:SetZone(109)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 12882 12884"
)

--TODO, Change timers to sourcename timers when not AI
local warnWingFlap						= mod:NewSpellAnnounce(12882, 2)
local warnAcidBreath					= mod:NewSpellAnnounce(12884, 2)

local timerWingFlapCD					= mod:NewAITimer(180, 12882, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerAcidBreathCD					= mod:NewAITimer(180, 12884, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

function mod:OnCombatStart(delay)
	timerWingFlapCD:Start(1-delay)
	timerAcidBreathCD:Start(1-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpell(12882) then
		warnWingFlap:Show()
		timerWingFlapCD:Start()
	elseif args:IsSpell(12884) then
		warnAcidBreath:Show()
		timerAcidBreathCD:Start()
	end
end
