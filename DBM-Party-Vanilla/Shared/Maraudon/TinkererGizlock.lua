local mod	= DBM:NewMod(425, "DBM-Party-Vanilla", DBM:IsPostCata() and 6 or 8, 232)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241103114940")
mod:SetCreatureID(13601)
mod:SetEncounterID(427)
mod:SetZone(349)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 21833"
)

--TODO, support his other spells? technicaly they won't be cast if you stack on him
--TODO, more timer review on goblin Dragon Gun
local warningGoblinDragonGun		= mod:NewSpellAnnounce(21833, 2)

local timerGoblinDragonGunCD		= mod:NewCDTimer(20.7, 21833, nil, nil, nil, 3)

function mod:OnCombatStart(delay)
	timerGoblinDragonGunCD:Start(9.7-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpell(21833) then
		warningGoblinDragonGun:Show()
		timerGoblinDragonGunCD:Start()
	end
end
