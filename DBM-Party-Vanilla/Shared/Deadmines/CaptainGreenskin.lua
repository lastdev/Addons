local mod	= DBM:NewMod("CaptainGreenskin", "DBM-Party-Vanilla", DBM:IsRetail() and 18 or 5)
local L		= mod:GetLocalizedStrings()

if mod:IsRetail() then
	mod.statTypes = "timewalker"
else
	mod.statTypes = "normal"
end

mod:SetRevision("20241103114940")
mod:SetCreatureID(647)
mod:SetEncounterID(2971)--Retail Encounter ID
mod:SetZone(36)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 5208",
	"SPELL_AURA_APPLIED 5208"
)

--TODO, consider a cleave timer if not cast too often
local warningPoisonedHarpoon		= mod:NewTargetNoFilterAnnounce(5208, 2, nil, "RemovePoison")

local timerPoisonedHarpoonCD		= mod:NewAITimer(30, 5208, nil, "RemovePoison", nil, 5, nil, DBM_COMMON_L.POISON_ICON)

function mod:OnCombatStart(delay)
	timerPoisonedHarpoonCD:Start(1-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpell(5208) then
		timerPoisonedHarpoonCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpell(5208) then
		warningPoisonedHarpoon:Show(args.destName)
	end
end
