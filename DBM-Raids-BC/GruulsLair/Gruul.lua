local mod	= DBM:NewMod("Gruul", "DBM-Raids-BC", 7)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal25"

mod:SetRevision("20241103131702")
mod:SetCreatureID(19044)
mod:SetEncounterID(650, 2456)
mod:SetModelID(18698)
mod:SetZone(565)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 33525 33654",
	"SPELL_CAST_SUCCESS 36297",
	"SPELL_AURA_APPLIED 36300 36240",
	"SPELL_AURA_APPLIED_DOSE 36300"
)

--TODO, add an option that lets users choose between 11, 13, and 18, 18 being default
--[[
(ability.id = 33525 or ability.id = 33654) and type = "begincast"
 or ability.id = 36297 and type = "cast"
 or ability.id = 36300
--]]
local warnGrowth		= mod:NewStackAnnounce(36300, 2)
local warnGroundSlam	= mod:NewSpellAnnounce(33525, 3)
local warnShatter		= mod:NewSpellAnnounce(33654, 4)
local warnSilence		= mod:NewSpellAnnounce(36297, 4)

local specWarnCaveIn	= mod:NewSpecialWarningGTFO(36240, nil, nil, nil, 1, 6)
local specWarnShatter	= mod:NewSpecialWarningMoveAway(33654, nil, nil, nil, 1, 6)

local timerGrowthCD		= mod:NewNextTimer(30, 36300, nil, nil, nil, 6)
local timerGroundSlamCD	= mod:NewCDTimer(74, 33525, nil, nil, nil, 2)--74-80 second variation,and this is just from 2 pulls.
local timerShatterCD	= mod:NewNextTimer(10, 33654, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON, nil, 1, 4)--10 seconds after ground slam
--local timerSilenceCD	= mod:NewCDTimer(32, 36297, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)--Also showing a HUGE variation of 32-48 seconds.

mod:AddRangeFrameOption(mod.Options.RangeDistance == "Smaller" and 11 or 18, 33654)
mod:AddDropdownOption("RangeDistance", {"Smaller", "Safe"}, "Safe", "misc", nil, 33654)

function mod:OnCombatStart(delay)
	timerGrowthCD:Start(-delay)
	timerGroundSlamCD:Start(40-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(self.Options.RangeDistance == "Smaller" and 11 or 18)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 33525 then--Ground Slam
		warnGroundSlam:Show()
		timerShatterCD:Start()
		timerGroundSlamCD:Start()
		specWarnShatter:Schedule(3)
		specWarnShatter:ScheduleVoice(3, "scatter")
	elseif args.spellId == 33654 then--Shatter
		warnShatter:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 36297 then--Reverberation (Silence)
		warnSilence:Show()
--		timerSilenceCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 36300 then--Growth
		local amount = args.amount or 1
		warnGrowth:Show(args.spellName, amount)
		timerGrowthCD:Start()
--		if amount == 3 then--First silence is 15 seconds after 3rd growth.
--			timerSilenceCD:Start(15)
--		end
	elseif args.spellId == 36240 and args:IsPlayer() and not self:IsTrivial() then--Cave In
		specWarnCaveIn:Show()
		specWarnCaveIn:Play("watchfeet")
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
