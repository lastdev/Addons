local mod	= DBM:NewMod("RhahkZor", "DBM-Party-Vanilla", DBM:IsRetail() and 18 or 5)
local L		= mod:GetLocalizedStrings()

if mod:IsRetail() then
	mod.statTypes = "timewalker"
else
	mod.statTypes = "normal"
end

mod:SetRevision("20241103114940")
mod:SetCreatureID(644)
mod:SetEncounterID(2967)--Retail Encounter ID
mod:SetZone(36)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 6304",
	"SPELL_AURA_APPLIED 6304"
)

local warningSlam			= mod:NewTargetNoFilterAnnounce(6304, 2)

local timerSlamCD			= mod:NewAITimer(180, 6304, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

function mod:OnCombatStart(delay)
	timerSlamCD:Start(1-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpell(6304) then
		timerSlamCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpell(6304) then
		warningSlam:Show(args.destName)
	end
end
