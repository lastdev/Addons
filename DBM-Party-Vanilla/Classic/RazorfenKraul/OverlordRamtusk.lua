local mod	= DBM:NewMod("OverlordRamtusk", "DBM-Party-Vanilla", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241103114940")
mod:SetCreatureID(4420)
--mod:SetEncounterID(1659)
mod:SetZone(47)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 8259"
)

local warningWhirlingBarrage		= mod:NewCastAnnounce(8259, 2)

function mod:SPELL_CAST_START(args)
	if args:IsSpell(8259) and self:AntiSpam(3, 1) then
		warningWhirlingBarrage:Show()
	end
end
