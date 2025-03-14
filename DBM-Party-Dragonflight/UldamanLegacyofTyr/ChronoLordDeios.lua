local mod	= DBM:NewMod(2479, "DBM-Party-Dragonflight", 2, 1197)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240601044955")
mod:SetCreatureID(184125)
mod:SetEncounterID(2559)
mod:SetHotfixNoticeRev(20230510000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29
mod.sendMainBossGUID = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 376292 376208 376049 375727",
	"SPELL_AURA_APPLIED 376325 377405",
	"SPELL_AURA_REMOVED 377405",
	"SPELL_PERIODIC_DAMAGE 376325",
	"SPELL_PERIODIC_MISSED 376325"
)

--TODO, mark orbs with https://www.wowhead.com/beta/spell=376293/eternity-orb ? Probably impractical
--TODO, maybe tell players to move to temporal zone? Only if BW does it though, minimizing handholding unless someone else does it first.
--TODO, does boss reset his CD timers when he he reverses flow? right now it's assumed yes
--[[
(ability.id = 376292 or ability.id = 376208 or ability.id = 376049 or ability.id = 375727) and type = "begincast"
 or ability.id = 377405 and type = "applydebuff"
 or type = "dungeonencounterstart" or type = "dungeonencounterend"
--]]
local warnEternalOrb							= mod:NewCountAnnounce(376292, 3, nil, false)
local warnRewindTimeflow						= mod:NewCountAnnounce(376208, 1)
local warnTimeSink								= mod:NewTargetAnnounce(377405, 1)

local specWarnWingBuffet						= mod:NewSpecialWarningCount(376049, nil, nil, nil, 2, 2)
local specWarnTimeSink							= mod:NewSpecialWarningMoveAway(377405, nil, nil, nil, 1, 2)
local yellTimeSink								= mod:NewYell(377405)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(376325, nil, nil, nil, 1, 8)
local specWarnSandBreath						= mod:NewSpecialWarningDefensive(375727, nil, nil, nil, 1, 2)

local timerEternalOrbCD							= mod:NewCDCountTimer(6.8, 376292, nil, false, 2, 3)--3-9
local timerRewindTimeflowCD						= mod:NewCDCountTimer(42.3, 376208, nil, nil, nil, 6)
local timerRewindTimeflow						= mod:NewBuffActiveTimer(14, 376208, nil, nil, nil, 5)--12+2sec cast
local timerWingBuffetCD							= mod:NewCDCountTimer(23, 376049, nil, nil, nil, 2)
local timerTimeSinkCD							= mod:NewCDTimer(15.7, 377405, nil, nil, nil, 3, nil, DBM_COMMON_L.HEROIC_ICON..DBM_COMMON_L.MAGIC_ICON)
local timerSandBreathCD							= mod:NewCDCountTimer(18.1, 375727, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddRangeFrameOption(5, 377405)

mod.vb.orbSet = 0
mod.vb.rewindCount = 0
mod.vb.breathCount = 0
mod.vb.buffetCount = 0
--mod.vb.sinkCount = 0--It's only once per rotation, no reason to count that

function mod:OnCombatStart(delay)
	self.vb.orbSet = 0
	self.vb.rewindCount = 0
	self.vb.breathCount = 0
	self.vb.buffetCount = 0
--	self.vb.sinkCount = 0
	timerEternalOrbCD:Start(2.1-delay, 1)
	if self:IsHard() then
		timerTimeSinkCD:Start(5.5-delay)
	end
	timerWingBuffetCD:Start(6-delay, 1)
	timerSandBreathCD:Start(12.3-delay, 1)
	timerRewindTimeflowCD:Start(39-delay, 1)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 376292 then
		self.vb.orbSet = self.vb.orbSet + 1
		warnEternalOrb:Show(self.vb.orbSet)
		if self.vb.orbSet < 5 then
			timerEternalOrbCD:Start(nil, self.vb.orbSet+1)
		end
	elseif spellId == 376208 then
		self.vb.rewindCount = self.vb.rewindCount + 1
		self.vb.orbSet = 0
		self.vb.breathCount = 0
		self.vb.buffetCount = 0
--		self.vb.sinkCount = 0
		warnRewindTimeflow:Show(self.vb.rewindCount)
		--Reboot Timers
		timerSandBreathCD:Stop()
		timerSandBreathCD:Start(14.5, 1)
		timerWingBuffetCD:Stop()
		timerWingBuffetCD:Start(18.1, 1)
		timerEternalOrbCD:Stop()
		timerEternalOrbCD:Start(21.8, 1)
		if self:IsHard() then
			timerTimeSinkCD:Stop()
			timerTimeSinkCD:Start(22.8)
		end
		timerRewindTimeflowCD:Start(56.7, self.vb.rewindCount+1)
	elseif spellId == 376049 then
		self.vb.buffetCount = self.vb.buffetCount + 1
		specWarnWingBuffet:Show(self.vb.buffetCount)
		specWarnWingBuffet:Play("carefly")
		if self.vb.buffetCount == 1 and self.vb.rewindCount >= 1 then
			timerWingBuffetCD:Start(nil, 2)
		end
	elseif spellId == 375727 then
		self.vb.breathCount = self.vb.breathCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnSandBreath:Show()
			specWarnSandBreath:Play("defensive")
		end
		local maxBreath = (self.vb.rewindCount == 0) and 2 or 3
		if self.vb.breathCount < maxBreath then
			timerSandBreathCD:Start(nil, self.vb.breathCount+1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 376325 and args:IsPlayer() and self:AntiSpam(3, 2) then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	elseif spellId == 377405 then
		warnTimeSink:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnTimeSink:Show()
			specWarnTimeSink:Play("range5")
			yellTimeSink:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(5)
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 377405 and args:IsPlayer() and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 376325 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
