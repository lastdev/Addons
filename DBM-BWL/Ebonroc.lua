local mod	= DBM:NewMod("Ebonroc", "DBM-BWL", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 597 $"):sub(12, -3))
mod:SetCreatureID(14601)
mod:SetEncounterID(614)
mod:SetModelID(6377)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 23339 22539",
	"SPELL_AURA_APPLIED 23340",
	"SPELL_AURA_REMOVED 23340"
)

local warnWingBuffet	= mod:NewCastAnnounce(23339)
local warnShadowFlame	= mod:NewCastAnnounce(22539)
local warnShadow		= mod:NewTargetAnnounce(23340)

local timerWingBuffet	= mod:NewNextTimer(31, 23339)
local timerShadowFlame	= mod:NewCastTimer(2, 22539)
local timerShadow		= mod:NewTargetTimer(8, 23340)

function mod:OnCombatStart(delay)
	timerWingBuffet:Start(-delay)
end

function mod:SPELL_CAST_START(args)--did not see ebon use any of these abilities
	if args.spellId == 23339 then
		warnWingBuffet:Show()
		timerWingBuffet:Start()
	elseif args.spellId == 22539 then
		timerShadowFlame:Start()
		warnShadowFlame:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 23340 then
		warnShadow:Show(args.destName)
		timerShadow:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 23340 then
		timerShadow:Cancel(args.destName)
	end
end