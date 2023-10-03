local wowToc, testBuild = DBM:GetTOC()
if (wowToc < 100200) and not testBuild then return end
local mod	= DBM:NewMod(2556, "DBM-Raids-Dragonflight", 1, 1207)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20230928210410")
mod:SetCreatureID(206172)
mod:SetEncounterID(2708)
mod:SetUsedIcons(8, 7, 6)
mod:SetHotfixNoticeRev(20230923000000)
mod:SetMinSyncRevision(20230923000000)
--mod.respawnTime = 29

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 420846 423094 426854",--426519 426147 424477
	"SPELL_CAST_SUCCESS 420907",
	"SPELL_SUMMON 421419 428465",
	"SPELL_AURA_APPLIED 420554 420920 425745 425781 423195 427722 426520",
	"SPELL_AURA_APPLIED_DOSE 420554 420920",
	"SPELL_AURA_REMOVED 413443 425745 425781 423195 427722 426520",
--	"SPELL_AURA_REMOVED_DOSE",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--[[

--]]
--TODO, https://www.wowhead.com/ptr-2/spell=413540/dream-tether for mythic?
--TODO, possibly infoframe to track some things, but need the fight overview and mythic mechanics to gauge it
--TODO, https://www.wowhead.com/ptr-2/spell=428471/waking-decimation cast bar, likely from add spawn if no aura or cast spell is added for it
--mod:AddTimerLine(DBM:EJ_GetSectionInfo(22309))
--local warnPhase									= mod:NewPhaseChangeAnnounce(2, nil, nil, nil, nil, nil, 2)
local warnProtectorsShroudOver						= mod:NewEndAnnounce(425794, 1)
local warnVerdantMatrix								= mod:NewCountAnnounce(420554, 2, nil, nil, DBM_CORE_L.AUTO_ANNOUNCE_OPTIONS.stack:format(420554))
local warnLifeSplice								= mod:NewStackAnnounce(420920, 2, nil, "Tank|Healer")--Not grouped, so spell key is shown separate in GUI
local warnThreadsofLife								= mod:NewCountAnnounce(425745, 2)
local warnViolentFlora								= mod:NewCountAnnounce(424477, 2)
local warnInflorescence								= mod:NewYouAnnounce(423195, 1)

local specWarnContinuum								= mod:NewSpecialWarningYou(420846, nil, nil, nil, 2, 2)
local specWarnNatureVolley							= mod:NewSpecialWarningInterruptCount(426854, "HasInterrupt", nil, nil, 1, 2)
local specWarnWeaversBurden							= mod:NewSpecialWarningMoveAway(426520, nil, nil, nil, 1, 2)
local yellWeaversBurden								= mod:NewShortYell(426520)
local yellWeaversBurdenFades						= mod:NewShortFadesYell(426520)
local specWarnWeaversBurdenOther					= mod:NewSpecialWarningTaunt(426520, nil, nil, nil, 1, 2)
local specWarnThreadsFixate							= mod:NewSpecialWarningYou(425745, nil, nil, nil, 1, 2)
local yellThreadsFixate								= mod:NewShortYell(425745)
--local specWarnViolentFlora						= mod:NewSpecialWarningDodgeCount(424477, nil, nil, nil, 2, 2)--Cast too often for special announce
local specWarnViridianRain							= mod:NewSpecialWarningDodgeCount(420907, nil, nil, nil, 2, 2)
--local specWarnGTFO								= mod:NewSpecialWarningGTFO(409058, nil, nil, nil, 1, 8)

local timerContinuumCD								= mod:NewNextCountTimer(90, 420846, nil, nil, nil, 3)
local timerNatureVolleyCD							= mod:NewCDNPTimer(11.8, 426854, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)--Nameplate only timer
local timerWeaversBurdenCD							= mod:NewCDCountTimer(11.8, 426520, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerThreadsofLifeCD							= mod:NewCDCountTimer(49, 425745, nil, nil, nil, 3)
local timerViolentFloraCD							= mod:NewCDCountTimer(49, 424477, nil, nil, nil, 3)
local timerViridianRainCD							= mod:NewCDCountTimer(49, 420907, nil, nil, nil, 3)
--local berserkTimer								= mod:NewBerserkTimer(600)

--mod:AddRangeFrameOption("5/6/10")
--mod:AddInfoFrameOption(407919, true)
mod:AddSetIconOption("SetIconOnWarden", -27432, true, 5, {7, 6})
mod:AddSetIconOption("SetIconOnManifestedDream", -28223, true, 5, {8})
mod:AddNamePlateOption("NPFixate", 425745, true)

mod.vb.contCount = 0
mod.vb.blastCount = 0
mod.vb.burdenCount = 0
mod.vb.threadsCount = 0
mod.vb.floraCount = 0
mod.vb.rainCount = 0
mod.vb.wardenIcon = 7
local castsPerGUID = {}
local playerInflorescence = false
local difficultyName = "heroic"
local allTimers = {
	["heroic"] = {
		--Violent Flora
		[424477] = {15.1, 13.4, 14.4, 12.1, 8.4, 13.5, 31.8, 20.0, 20.0, 21.5, 26.6, 9.9, 15.2, 12.0, 6.5, 12.0, 32.1, 7.8, 15.0, 14.0, 4.5, 15.5, 32.5, 20.0, 20.0, 21.6, 26.5, 9.9, 15.1},
		--Weaver's Burden
		[426520] = {27.0, 25.1, 23.5, 64.1, 25.5, 64.4, 24.0, 69.5, 20.0, 64.6, 25.5},
		--Threads of Life
		[425745] = {35.0, 13.0, 12.0, 18.7, 36.7, 8.0, 12.0, 18.0, 10.4, 29.4, 11.0, 18.0, 12.0, 18.0, 28.6, 2.1, 10.3, 16.5, 12.0, 20.9, 37.1, 8.0, 12.0, 18.0, 13.6, 29.5, 12.5, 16.4},
		--Viridian Rain
		[420907] = {7.0, 33.0, 37.0, 31.8, 15.0, 20.5, 29.5, 23.1, 7.8, 11.7, 6.5, 10.4, 8.0, 10.5, 4.5, 112.5, 15.6, 20.0, 29.4, 23.1, 7.9, 12.0, 9.5},--the 112-114 is not a mistake, saw in more than one pull
	},
}

function mod:OnCombatStart(delay)
	table.wipe(castsPerGUID)
	self.vb.contCount = 0
	self.vb.blastCount = 0
	self.vb.burdenCount = 0
	self.vb.threadsCount = 0
	self.vb.floraCount = 0
	self.vb.rainCount = 0
	self.vb.wardenIcon = 7
	timerViridianRainCD:Start(7-delay, 1)
	timerViolentFloraCD:Start(15.1-delay, 1)
	timerWeaversBurdenCD:Start(27-delay, 1)
	timerThreadsofLifeCD:Start(35-delay, 1)
	timerContinuumCD:Start(90-delay, 1)
	if self.Options.NPFixate then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
--	if self:IsMythic() then
--		difficultyName = "mythic"
--	elseif self:IsHeroic() then
		difficultyName = "heroic"
--	elseif self:IsNormal() then
--		difficultyName = "normal"
--	else
--		difficultyName = "lfr"
--	end
end

function mod:OnCombatEnd()
	if self.Options.NPFixate then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:OnTimerRecovery()
	if DBM:UnitBuff("player", 423195) then
		playerInflorescence = true
	end
--	if self:IsMythic() then
--		difficultyName = "mythic"
--	elseif self:IsHeroic() then
		difficultyName = "heroic"
--	elseif self:IsNormal() then
--		difficultyName = "normal"
--	else
--		difficultyName = "lfr"
--	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 420846 then
		self.vb.contCount = self.vb.contCount + 1
		self.vb.wardenIcon = 7
		specWarnContinuum:Show(self.vb.contCount)
		specWarnContinuum:Play("aesoon")
		timerContinuumCD:Start(nil, self.vb.contCount+1)
	elseif spellId == 423094 then
		self.vb.threadsCount = self.vb.threadsCount + 1
		warnThreadsofLife:Show(self.vb.threadsCount)
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.threadsCount+1)
		if timer then
			timerThreadsofLifeCD:Start(timer, self.vb.threadsCount+1)
		end
	elseif spellId == 426854 then
--		timerNatureVolleyCD:Start(nil, args.sourceGUID)
		if not castsPerGUID[args.sourceGUID] then--Shouldn't happen, but just in case
			castsPerGUID[args.sourceGUID] = 0
			if self.Options.SetIconOnWarden then
				self:ScanForMobs(args.sourceGUID, 2, self.vb.wardenIcon, 1, nil, 12, "SetIconOnWarden")
			end
			self.vb.wardenIcon = self.vb.wardenIcon - 1
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then--Count interrupt, so cooldown is not checked
			specWarnNatureVolley:Show(args.sourceName, count)
			if count < 6 then
				specWarnNatureVolley:Play("kick"..count.."r")
			else
				specWarnNatureVolley:Play("kickcast")
			end
		end
--	elseif spellId == 426519 then
--		self.vb.burdenCount = self.vb.burdenCount + 1
--		timerWeaversBurdenCD:Start()
--	elseif spellId == 424477 then
--		self.vb.floraCount = self.vb.floraCount + 1
--		specWarnViolentFlora:Show(self.vb.floraCount)
--		specWarnViolentFlora:Play("watchstep")
--		timerViolentFloraCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 420907 then
		self.vb.rainCount = self.vb.rainCount + 1
		specWarnViridianRain:Show(self.vb.rainCount)
		specWarnViridianRain:Play("watchstep")
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.rainCount+1)
		if timer then
			timerViridianRainCD:Start(timer, self.vb.rainCount+1)
		end
	end
end

--https://www.wowhead.com/ptr-2/spell=418491/everweaving-threads
function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 421419 then--Cycle Warden
		if not castsPerGUID[args.destGUID] then
			timerNatureVolleyCD:Start(nil, args.destGUID)
			castsPerGUID[args.destGUID] = 0
			if self.Options.SetIconOnWarden then
				self:ScanForMobs(args.destGUID, 2, self.vb.wardenIcon, 1, nil, 12, "SetIconOnWarden")
			end
			self.vb.wardenIcon = self.vb.wardenIcon - 1
		end
	elseif spellId == 428465 then--Manifested Dream
		if not castsPerGUID[args.destGUID] then
			castsPerGUID[args.destGUID] = 0
			if self.Options.SetIconOnManifestedDream then
				self:ScanForMobs(args.destGUID, 2, 8, 1, nil, 12, "SetIconOnManifestedDream")
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 420554 then
		if args:IsPlayer() and not playerInflorescence then
			warnVerdantMatrix:Cancel()
			warnVerdantMatrix:Schedule(1, args.amount or 1)
		end
	elseif spellId == 420920 then
		local amount = args.amount or 1
--		local _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
--		local remaining
--		if expireTime then
--			remaining = expireTime-GetTime()
--		end
--		local timer = (self:GetFromTimersTable(allTimers, difficultyName, false, 376279, self.vb.slamCount+1) or 17.9) - 5
--		if (not remaining or remaining and remaining < timer) and not UnitIsDeadOrGhost("player") and not self:IsHealer() then
--			specWarnConcussiveSlamTaunt:Show(args.destName)
--			specWarnConcussiveSlamTaunt:Play("tauntboss")
--		else
			warnLifeSplice:Show(args.destName, amount)
--		end
	elseif spellId == 427722 or spellId == 426520 then--426520 confirmed on heroic, 427722 is probably lfr/normal
		if args:IsPlayer() then
			specWarnWeaversBurden:Show()
			specWarnWeaversBurden:Play("runout")
			yellWeaversBurden:Yell()
			yellWeaversBurdenFades:Countdown(spellId)
		else
			specWarnWeaversBurdenOther:Show(args.destName)
			specWarnWeaversBurdenOther:Play("tauntboss")
		end
	elseif spellId == 425745 or spellId == 425781 then--425745 confirmed on heroic
		if args:IsPlayer() then
			specWarnThreadsFixate:Show()
			specWarnThreadsFixate:Play("targetyou")
			yellThreadsFixate:Yell()
			if self.Options.NPFixate then
				DBM.Nameplate:Show(true, args.sourceGUID, spellId)
			end
		end
	elseif spellId == 423195 then
		if args:IsPlayer() then
			playerInflorescence = true
			if self:AntiSpam(3, 1) then
				warnInflorescence:Show()
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 413443 then
		warnProtectorsShroudOver:Show()
	elseif spellId == 427722 or spellId == 426520 then--426520 confirmed on heroic
		if args:IsPlayer() then
			yellWeaversBurdenFades:Cancel()
		end
	elseif spellId == 425745 or spellId == 425781 then--425745 confirmed on heroic
		if args:IsPlayer() then
			if self.Options.NPFixate then
				DBM.Nameplate:Hide(true, args.sourceGUID, spellId)
			end
		end
	elseif spellId == 423195 then
		if args:IsPlayer() then
			playerInflorescence = false
		end
	end
end
--mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 409058 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 428465 then--Manifested Dream

	elseif cid == 209800 then--cycle-warden
		timerNatureVolleyCD:Stop(args.destGUID)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 423858 then--Violent Flora
		self.vb.floraCount = self.vb.floraCount + 1
		warnViolentFlora:Show(self.vb.floraCount)
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.floraCount+1)
		if timer then
			timerViolentFloraCD:Start(timer, self.vb.floraCount+1)
		end
	elseif spellId == 426519 then--Weaver's Burden
		self.vb.burdenCount = self.vb.burdenCount + 1
		local timer = self:GetFromTimersTable(allTimers, difficultyName, false, spellId, self.vb.burdenCount+1)
		if timer then
			timerWeaversBurdenCD:Start(timer, self.vb.burdenCount+1)
		end
	end
end
