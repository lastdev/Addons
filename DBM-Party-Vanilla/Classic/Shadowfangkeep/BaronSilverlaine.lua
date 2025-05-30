local mod	= DBM:NewMod("BaronSilverlaine", "DBM-Party-Vanilla", 14)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241103114940")
mod:SetCreatureID(3887)
mod:SetZone(33)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 7068",
	"SPELL_AURA_APPLIED 7068"
)

local warningVeilofShadow			= mod:NewTargetNoFilterAnnounce(7068, 2)

local timerVeilofShadowCD			= mod:NewAITimer(180, 7068, nil, nil, nil, 3, nil, DBM_COMMON_L.CURSE_ICON)

function mod:OnCombatStart(delay)
	timerVeilofShadowCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpell(7068) then
		timerVeilofShadowCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpell(7068) then
		warningVeilofShadow:Show(args.destName)
	end
end
