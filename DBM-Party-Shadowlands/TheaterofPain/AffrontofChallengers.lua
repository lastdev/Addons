local mod	= DBM:NewMod(2397, "DBM-Party-Shadowlands", 6, 1187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250101235718")
mod:SetCreatureID(164451, 164463, 164461)--Dessia, Paceran, Sathel
mod:SetEncounterID(2391)
mod:SetHotfixNoticeRev(20220416000000)
mod:SetBossHPInfoToHighest()
mod:SetZone(2293)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 320063 1215741 1215738 1215600",
	"SPELL_CAST_SUCCESS 320069 320272 320248 333231 333222 320063 333540",
	"SPELL_AURA_APPLIED 320069 324085 320272 320293 333231 333222 333540 326892 1215600",
	"SPELL_PERIODIC_DAMAGE 320180",
	"SPELL_PERIODIC_MISSED 320180",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3",
	"UNIT_DIED"
)

--TODO, hybrid nameplate timers on combat start and rest of fight
--TODO, update all timers for 11.1
--[[
ability.id = 320063 and type = "begincast"
 or (ability.id = 320069 or ability.id = 320272 or ability.id = 333222 or ability.id = 320248 or ability.id = 333231 or ability.id = 333540) and type = "cast"
 or (ability.id = 324085 or ability.id = 320293) and (type = "applybuff" or type = "applydebuff")
 or (target.id = 164451 or target.id = 164463 or target.id = 164461) and type = "death"
 or type = "dungeonencounterstart" or type = "dungeonencounterend"
--]]
--Dessia the Decapitator
mod:AddTimerLine(DBM:EJ_GetSectionInfo(21582))
local warnSlam							= mod:NewCountAnnounce(320063, 3, nil, "Tank")
local warnMortalStrike					= mod:NewTargetNoFilterAnnounce(320069, 3, nil, "Tank|Healer")
local warnEnrage						= mod:NewTargetNoFilterAnnounce(324085, 3)
local warnFixate						= mod:NewTargetNoFilterAnnounce(326892, 2)

local specWarnMightySmash				= mod:NewSpecialWarningCount(1215741, nil, nil, nil, 2, 2)
local specWarnSlam						= mod:NewSpecialWarningDefensive(320063, false, nil, 2, 1, 2)--Cast very often, let this be an opt in
local specWarnEnrage					= mod:NewSpecialWarningDispel(324085, "RemoveEnrage", nil, nil, 1, 2)
local specWarnFixate					= mod:NewSpecialWarningYou(326892, nil, nil, nil, 1, 2)

local timerMightySmashCD				= mod:NewAITimer(15.8, 1215741, nil, nil, nil, 2, nil)
local timerMortalStrikeCD				= mod:NewCDCountTimer(21.8, 320069, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--21.8-32.7
local timerSlamCD						= mod:NewCDCountTimer(7.3, 320063, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--7.3-10.9
--Paceran the Virulent
mod:AddTimerLine(DBM:EJ_GetSectionInfo(21581))
local warnGeneticAlteration				= mod:NewSpellAnnounce(320248, 2)--Goes on everyone

local specWarnDecayingBreath			= mod:NewSpecialWarningDodgeCount(1215738, nil, nil, nil, 2, 2)
local specWarnGTFO						= mod:NewSpecialWarningGTFO(320180, nil, nil, nil, 1, 8)

local timerNoxiousSporeCD				= mod:NewCDCountTimer(15.8, 320180, nil, nil, nil, 3)
local timerDecayingBreathCD				= mod:NewAITimer(15.8, 1215738, nil, nil, nil, 3)
--Sathel the Accursed
mod:AddTimerLine(DBM:EJ_GetSectionInfo(21591))
local warnSearingDeath					= mod:NewTargetAnnounce(333231, 3)
local warnOnewithDeath					= mod:NewTargetNoFilterAnnounce(320293, 3)

local specWarnSearingDeath				= mod:NewSpecialWarningMoveAway(333231, nil, nil, nil, 1, 2)
local yellSearingDeath					= mod:NewYell(333231)
local specWarnSpectralTransference		= mod:NewSpecialWarningDispel(320272, "MagicDispeller", nil, nil, 1, 2)
local specWarnWitheringTouch			= mod:NewSpecialWarningDispel(1215600, "RemoveMagic", nil, nil, 1, 2)

local timerSearingDeathCD				= mod:NewCDCountTimer(11.7, 333231, nil, nil, nil, 3)--11.7-24
local timerSpectralTransferenceCD		= mod:NewCDCountTimer(13.4, 320272, nil, nil, nil, 5, nil, DBM_COMMON_L.MAGIC_ICON)--13.4-57
local timerWitheringTouchCD				= mod:NewAITimer(15.8, 1215600, nil, nil, nil, 5, nil, DBM_COMMON_L.MAGIC_ICON)
--Xira the Underhanded
mod:AddTimerLine(DBM:EJ_GetSectionInfo(23841))
local warnOpportunityStrikes			= mod:NewTargetNoFilterAnnounce(333540, 4)--And re-added in 9.1?

local yellOpportunityStrikes			= mod:NewYell(333540)

local timerOpportunityStrikesCD			= mod:NewCDTimer(30, 333540, nil, nil, nil, 3, nil, DBM_COMMON_L.MYTHIC_ICON)--And re-added in 9.1?

--General
mod.vb.willCount = 0
--Dessia
mod.vb.smashCount = 0
mod.vb.mortalStrikeCount = 0
mod.vb.slamCount = 0
--Paceran
mod.vb.sporeCount = 0
mod.vb.breathCount = 0
--Sathel
mod.vb.deathCount = 0
mod.vb.dispelCount = 0

local isNewShit = DBM:GetTOC() >= 110100

function mod:OnCombatStart(delay)
	self.vb.willCount = 0
	self.vb.smashCount = 0
	self.vb.mortalStrikeCount = 0
	self.vb.slamCount = 0
	self.vb.sporeCount = 0
	self.vb.breathCount = 0
	self.vb.deathCount = 0
	self.vb.dispelCount = 0
	--Dessia
	if isNewShit then
		timerMightySmashCD:Start(1-delay)
	end
	timerSlamCD:Start(9.4-delay, 1)
	timerMortalStrikeCD:Start(22.6-delay, 1)--SUCCESS (Health based?), 22-26 from some data but 2nd cast gets worse 21-32 variance in logs
	--Paceran
	timerNoxiousSporeCD:Start(17.7-delay, 1)
	if isNewShit then
		timerDecayingBreathCD:Start(1-delay)
	end
	--Sathel
	timerSearingDeathCD:Start(10.2-delay, 1)--SUCCESS 10-15
	if isNewShit then
		timerWitheringTouchCD:Start(1-delay)
	else
		timerSpectralTransferenceCD:Start(10.5-delay)--SUCCESS 10-13
	end
	if self:IsMythic() and not isNewShit then
		timerOpportunityStrikesCD:Start(40-delay)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 320063 and self:AntiSpam(4, 1) then--Boss can stutter cast this (self interrupt and start cast over)
		self.vb.slamCount = self.vb.slamCount + 1
		if self.Options.SpecWarn320063defensive2 and self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnSlam:Show()
			specWarnSlam:Play("defensive")
		else
			warnSlam:Show(self.vb.slamCount)
		end
	elseif spellId == 1215741 then
		self.vb.smashCount = self.vb.smashCount + 1
		specWarnMightySmash:Show(self.vb.smashCount)
		specWarnMightySmash:Play("aesoon")
		timerMightySmashCD:Start()--nil, self.vb.smashCount+1
	elseif spellId == 1215738 then
		self.vb.breathCount = self.vb.breathCount + 1
		specWarnDecayingBreath:Show(self.vb.breathCount)
		specWarnDecayingBreath:Play("breathsoon")
		timerDecayingBreathCD:Start()--nil, self.vb.breathCount+1
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 320069 then
		self.vb.mortalStrikeCount = self.vb.mortalStrikeCount + 1
--		timerMortalStrikeCD:Start()--nil, self.vb.mortalStrikeCount+1
	elseif spellId == 320272 or spellId == 333222 then--Seems to have two spellIds in older logs but may be fixed in newer ones
		self.vb.dispelCount = self.vb.dispelCount + 1
		timerSpectralTransferenceCD:Start(nil, self.vb.dispelCount+1)
	elseif spellId == 320248 then
		warnGeneticAlteration:Show()
	elseif spellId == 333231 then
		self.vb.deathCount = self.vb.deathCount + 1
		local timer = self.vb.willCount == 2 and 3 or self.vb.willCount == 1 and 7.5 or 11.7
		timerSearingDeathCD:Start(isNewShit and timer or 11.7)--self.vb.deathCount+1
	elseif spellId == 320063 then
		self.vb.slamCount = self.vb.slamCount + 1
		timerSlamCD:Start(6.4, self.vb.slamCount+1)--Started in success do to stutter casting, cast time removed from CD
	elseif spellId == 333540 then
		timerOpportunityStrikesCD:Start()--Not seen more than once during a pull, rarely even see it once
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 320069 then
		warnMortalStrike:Show(args.destName)
	elseif spellId == 324085 then
		if self.Options.SpecWarn324085dispel then
			specWarnEnrage:Show(args.destName)
		else
			warnEnrage:Show(args.destName)
		end
	elseif spellId == 320272 or spellId == 333222 then--Seems to have two spellIds in older logs but may be fixed in newer ones
		specWarnSpectralTransference:Show(args.destName)--Combined because of Mass Transference
		specWarnSpectralTransference:Play("dispelboss")
	elseif spellId == 320293 then
		warnOnewithDeath:Show(args.destName)
	elseif spellId == 333231 then
		if args:IsPlayer() then
			specWarnSearingDeath:Show()
			specWarnSearingDeath:Play("runout")
			yellSearingDeath:Yell()
		else
			warnSearingDeath:Show(args.destName)
		end
	elseif spellId == 333540 then
		warnOpportunityStrikes:Show(args.destName)
		if args:IsPlayer() then
			yellOpportunityStrikes:Yell()
		end
	elseif spellId == 326892 and args:IsDestTypePlayer() then
		if args:IsPlayer() then
			specWarnFixate:Show()
			specWarnFixate:Play("targetyou")
		else
			warnFixate:Show(args.destName)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 320180 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 164451 then--Dessia the Decapitator
		self.vb.willCount = self.vb.willCount + 1
		timerMortalStrikeCD:Stop()
		timerSlamCD:Stop()
	elseif cid == 164463 then--Paceran the Virulent
		self.vb.willCount = self.vb.willCount + 1
		timerNoxiousSporeCD:Stop()
	elseif cid == 164461 then--Sathel the Accursed
		self.vb.willCount = self.vb.willCount + 1
		timerSpectralTransferenceCD:Stop()
		timerSearingDeathCD:Stop()
	end
end

--"<48.53 02:10:59> [UNIT_SPELLCAST_SUCCEEDED] Paceran the Virulent(??) -Noxious Spore- [[boss3:Cast-3-2084-2293-25939-324118-000024A504:324118]]
--"<52.18 02:11:03> [CLEU] SPELL_AURA_APPLIED#Creature-0-2084-2293-25939-164463-000024A49F#Paceran the Virulent#Player-970-004E060B#Viterratwo-TheMaw#320180#Noxious Spore#DEBUFF#nil", -- [579]
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 324118 then--Noxious Spore (spawn event)
		self.vb.sporeCount = self.vb.sporeCount + 1
		local timer = self.vb.willCount == 2 and 4 or self.vb.willCount == 1 and 10 or 15.8
		timerNoxiousSporeCD:Start(isNewShit and timer or 15.8, self.vb.sporeCount+1)
	end
end
