local mod	= DBM:NewMod("Kologarn", "DBM-Raids-WoTLK", 5)
local L		= mod:GetLocalizedStrings()

if not mod:IsClassic() then--on classic, it's normal10,normal25, defined in toc, only retail overrides to flex/timewalking
	mod.statTypes = "normal,timewalker"
end

mod:SetRevision("20250408170354")
mod:SetCreatureID(32930)--, 32933, 32934
if mod:IsPostCata() then
	mod:SetEncounterID(1137)
else
	mod:SetEncounterID(749)
end
mod:SetModelID(28638)
mod:SetUsedIcons(5, 6, 7, 8)
mod:SetMinSyncRevision(20191109000000)
mod:SetZone(603)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 64003",
	"SPELL_AURA_APPLIED 64290 64292 64002 63355",
	"SPELL_AURA_APPLIED_DOSE 64002 63355",
	"SPELL_AURA_REMOVED 64290 64292",
	"SPELL_DAMAGE 63783 63982 63346 63976",
	"SPELL_MISSED 63783 63982 63346 63976",
	"RAID_BOSS_WHISPER",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--NOTE: Two crunch armors are setup to appear in gui twice on purpose, because they are very different mechanically. One is meant to be ignored and one is meant to be tank swap
local warnFocusedEyebeam		= mod:NewTargetNoFilterAnnounce(63346, 4)
local warnGrip					= mod:NewTargetNoFilterAnnounce(64292, 2)
local warnCrunchArmor			= mod:NewStackAnnounce(64002, 2, nil, "Tank|Healer")

local specWarnCrunchArmor2		= mod:NewSpecialWarningStack(64002, nil, 2, nil, 2, 1, 6)
local specWarnEyebeam			= mod:NewSpecialWarningRun(63346, nil, nil, nil, 4, 2)
local yellBeam					= mod:NewYell(63346)

local timerNextSmash			= mod:NewCDTimer(20.4, 64003, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerNextShockwave		= mod:NewCDTimer(15.9, 63982, nil, nil, nil, 2)--15.9-20
local timerNextEyebeam			= mod:NewCDTimer(18.2, 63346, nil, nil, nil, 3)
local timerNextGrip				= mod:NewCDTimer(20, 64292, nil, nil, nil, 3)
local timerRespawnLeftArm		= mod:NewTimer(48, "timerLeftArm", nil, nil, nil, 1)
local timerRespawnRightArm		= mod:NewTimer(48, "timerRightArm", nil, nil, nil, 1)
local timerTimeForDisarmed		= mod:NewTimer(10, "achievementDisarmed")	-- 10 HC / 12 nonHC

mod:AddSetIconOption("SetIconOnGripTarget", 64292, true, 0, {7, 6, 5})
mod:AddSetIconOption("SetIconOnEyebeamTarget", 63346, true, 0, {8})

mod.vb.disarmActive = false
local gripTargets = {}

local function armReset(self)
	self.vb.disarmActive = false
end

local function GripAnnounce(self)
	warnGrip:Show(table.concat(gripTargets, "<, >"))
	table.wipe(gripTargets)
end

function mod:OnCombatStart(delay)
	timerNextSmash:Start(10-delay)
	timerNextEyebeam:Start(11-delay)
	timerNextShockwave:Start(13.3-delay)
	if self:IsClassic() then
		DBM:AddMsg("Note: Eye beam targetting is disabled by Blizzard in classic, the settings for these features will not function in pre nerf state")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 64003 then
		timerNextSmash:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(64290, 64292) then
		if self.Options.SetIconOnGripTarget then
			self:SetIcon(args.destName, 8 - #gripTargets, 10)
		end
		table.insert(gripTargets, args.destName)
		self:Unschedule(GripAnnounce)
		if #gripTargets >= 3 then
			GripAnnounce(self)
		else
			self:Schedule(0.3, GripAnnounce, self)
		end
	elseif args:IsSpellID(64002, 63355) then	-- Crunch Armor
		local amount = args.amount or 1
		if amount >= 2 then
			if args:IsPlayer() then
				specWarnCrunchArmor2:Show(amount)
				specWarnCrunchArmor2:Play("stackhigh")
			else
				warnCrunchArmor:Show(args.destName, amount)
			end
		else
			warnCrunchArmor:Show(args.destName, amount)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(64290, 64292) then
		self:SetIcon(args.destName, 0)
    end
end

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 32934 then 		-- right arm
		timerRespawnRightArm:Start()
		timerNextGrip:Cancel()
		if not self.vb.disarmActive then
			self.vb.disarmActive = true
			--TODO, verify it's 12 and 12, both were changed to 12 later on but early on it was 10 and 12
			timerTimeForDisarmed:Start(12)
			self:Schedule(12, armReset, self)
		end
	elseif self:GetCIDFromGUID(args.destGUID) == 32933 then		-- left arm
		timerRespawnLeftArm:Start()
		if not self.vb.disarmActive then
			self.vb.disarmActive = true
			timerTimeForDisarmed:Start(12)
			self:Schedule(12, armReset, self)
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if (spellId == 63346 or spellId == 63976) and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnEyebeam:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find(L.FocusedEyebeam) then
		specWarnEyebeam:Show()
		specWarnEyebeam:Play("justrun")
		specWarnEyebeam:ScheduleVoice(1, "keepmove")
		yellBeam:Yell()
	end
end

function mod:OnTranscriptorSync(msg, targetName)
	if msg:find(L.FocusedEyebeam) then--
		targetName = Ambiguate(targetName, "none")
		if self:AntiSpam(5, targetName) then--Antispam sync by target name, since this doesn't use dbms built in onsync handler.
			warnFocusedEyebeam:Show(targetName)
			if self.Options.SetIconOnEyebeamTarget then
				self:SetIcon(targetName, 5, 8)
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 63983 then--Arm Sweep
		self:SendSync("Shockwave")
	elseif spellId == 63342 then--Focused Eyebeam Summon Trigger
		self:SendSync("Eyebeam")
	end
end

function mod:OnSync(event, args)
	if not self:IsInCombat() then return end
	if event == "Shockwave" then
		timerNextShockwave:Start()
	elseif event == "Eyebeam" then
		timerNextEyebeam:Start()
	end
end
