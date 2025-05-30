local mod	= DBM:NewMod("Gothik", "DBM-Raids-WoTLK", 8)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250307060227")
mod:SetCreatureID(16060)
mod:SetEncounterID(1109)
mod:SetModelID(16279)
mod:SetZone(533)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"UNIT_DIED"
)

--TODO, sync infoframe from classic era version?
--(source.type = "NPC" and source.firstSeen = timestamp) or (target.type = "NPC" and target.firstSeen = timestamp)
local warnWaveNow		= mod:NewAnnounce("WarningWaveSpawned", 3, nil, false)
local warnWaveSoon		= mod:NewAnnounce("WarningWaveSoon", 2)
local warnRiderDown		= mod:NewAnnounce("WarningRiderDown", 4)
local warnKnightDown	= mod:NewAnnounce("WarningKnightDown", 2)
local warnPhase2		= mod:NewPhaseAnnounce(2, 3)

local timerPhase2		= mod:NewTimer(270, "TimerPhase2", "136116", nil, nil, 6)
local timerWave			= mod:NewTimer(20, "TimerWave", "135974", nil, nil, 1)

mod.vb.wave = 0
local wavesNormal = {
	{2, L.Trainee, timer = 20},
	{2, L.Trainee, timer = 20},
	{2, L.Trainee, timer = 10},
	{1, L.Knight, timer = 10},
	{2, L.Trainee, timer = 15},
	{1, L.Knight, timer = 5},
	{2, L.Trainee, timer = 20},
	{1, L.Knight, 2, L.Trainee, timer = 10},
	{1, L.Rider, timer = 10},
	{2, L.Trainee, timer = 5},
	{1, L.Knight, timer = 15},
	{2, L.Trainee, 1, L.Rider, timer = 10},
	{2, L.Knight, timer = 10},
	{2, L.Trainee, timer = 10},
	{1, L.Rider, timer = 5},
	{1, L.Knight, timer = 5},
	{2, L.Trainee, timer = 20},
	{1, L.Rider, 1, L.Knight, 2, L.Trainee, timer = 15},
	{2, L.Trainee},
}

local wavesHeroic = {
	{3, L.Trainee, timer = 20},
	{3, L.Trainee, timer = 20},
	{3, L.Trainee, timer = 10},
	{2, L.Knight, timer = 10},
	{3, L.Trainee, timer = 15},
	{2, L.Knight, timer = 5},
	{3, L.Trainee, timer = 20},
	{3, L.Trainee, 2, L.Knight, timer = 10},
	{3, L.Trainee, timer = 10},
	{1, L.Rider, timer = 5},
	{3, L.Trainee, timer = 15},
	{1, L.Rider, timer = 10},
	{2, L.Knight, timer = 10},
	{1, L.Rider, timer = 10},
	{1, L.Rider, 3, L.Trainee, timer = 5},
	{1, L.Knight, 3, L.Trainee, timer = 5},
	{1, L.Rider, 3, L.Trainee, timer = 20},
	{1, L.Rider, 2, L.Knight, 3, L.Trainee},
}


local waves = wavesNormal

local function getWaveString(wave)
	local waveInfo = waves[wave]
	if #waveInfo == 2 then
		return L.WarningWave1:format(unpack(waveInfo))
	elseif #waveInfo == 4 then
		return L.WarningWave2:format(unpack(waveInfo))
	elseif #waveInfo == 6 then
		return L.WarningWave3:format(unpack(waveInfo))
	end
end

local function NextWave(self)
	self.vb.wave = self.vb.wave + 1
	warnWaveNow:Show(self.vb.wave, getWaveString(self.vb.wave))
	local timer = waves[self.vb.wave].timer
	if timer and timer > 0 then
		timerWave:Start(timer, self.vb.wave + 1)
		warnWaveSoon:Schedule(timer - 3, self.vb.wave + 1, getWaveString(self.vb.wave + 1))
		self:Schedule(timer, NextWave, self)
	end
end

function mod:OnCombatStart(delay)
	if self:IsDifficulty("normal25") then
		waves = wavesHeroic
	else
		waves = wavesNormal
	end
	self.vb.wave = 0
	timerPhase2:Start()
	warnPhase2:Schedule(270)
	timerWave:Start(25, self.vb.wave + 1)
	warnWaveSoon:Schedule(22, self.vb.wave + 1, getWaveString(self.vb.wave + 1))
	self:Schedule(25, NextWave, self)
end

function mod:OnTimerRecovery()
	if self:IsDifficulty("normal25") then
		waves = wavesHeroic
	else
		waves = wavesNormal
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 16126 then -- Unrelenting Rider
		warnRiderDown:Show()
	elseif cid == 16125 then -- Unrelenting Deathknight
		warnKnightDown:Show()
	end
end

