local mod	= DBM:NewMod(489, "DBM-Party-Vanilla", DBM:IsPostCata() and 15 or 20, 241)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241103114940")
mod:SetCreatureID(7267)--7797/ruuzlu
mod:SetEncounterID(600)
mod:SetZone(209)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 8269"
)

--TODO, Add cleave timer?
local warningEnrage			= mod:NewTargetNoFilterAnnounce(8269, 2)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpell(8269) and args:IsDestTypePlayer() then
		warningEnrage:Show(args.destName)
	end
end
