local mod	= DBM:NewMod("TwinEmpsAQ", "DBM-AQ40", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220116021832")
mod:SetCreatureID(15276, 15275)
mod:SetEncounterID(715)
mod:SetModelID(15778)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 799 800 26613 26607",
	"SPELL_CAST_SUCCESS 802 804"--26613
)

--Add warning for classic to actually swap for strike? boss taunt immune though.
local warnStrike			= mod:NewTargetAnnounce(26613, 3, nil, "Tank|Healer")
local warnTeleport			= mod:NewSpellAnnounce(800, 3)
local warnExplodeBug		= mod:NewSpellAnnounce(804, 2, nil, false)
local warnMutateBug			= mod:NewSpellAnnounce(802, 2, nil, false)

local specWarnStrike		= mod:NewSpecialWarningDefensive(26613, nil, nil, nil, 1, 2)
local specWarnGTFO			= mod:NewSpecialWarningGTFO(26607, nil, nil, nil, 8, 2)

local timerTeleport			= mod:NewCDTimer(29.2, 800, nil, nil, nil, 6, nil, nil, true, 1, 4)
local timerExplodeBugCD		= mod:NewCDTimer(4.9, 804, nil, false, nil, 1)--4.9-9
local timerMutateBugCD		= mod:NewCDTimer(11, 802, nil, false, nil, 1)--11-16
--local timerStrikeCD			= mod:NewCDTimer(9.7, 26613, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--9.7-42.6

local berserkTimer			= mod:NewBerserkTimer(900)

function mod:OnCombatStart(delay)
	--timerStrikeCD:Start(14.2-delay)
	berserkTimer:Start()
	timerTeleport:Start(-delay)
end

--pull:30.6, 35.2, 37.8, 40.1, 36.5, 36.6, 37.7, 31.9, 31.7, 38.8, 32.9, 30.4, 40.2, 30.6, 37.6, 35.4, 32.9, 34.2, 35.3, 36.5, 30.4, 29.2, 34.3, 32.8, 40.0, 35.4, 36.5, 35.3
function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(799, 800) and self:AntiSpam(5, 1) then
		warnTeleport:Show()
		timerTeleport:Start()
	elseif args.spellId == 26613 and not self:IsTrivial() then
		if args:IsPlayer() then
			specWarnStrike:Show()
			specWarnStrike:Play("defensive")
		else
			warnStrike:Show(args.destName)
		end
	elseif args.spellId == 26607 and args:IsPlayer() and not self:IsTrivial() then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 802 then
		warnMutateBug:Show()
		timerMutateBugCD:Start()
	elseif args.spellId == 804 then
		warnExplodeBug:Show()
		timerExplodeBugCD:Start()
--	elseif spellId == 26613 then
		--timerStrikeCD:Start()
	end
end
