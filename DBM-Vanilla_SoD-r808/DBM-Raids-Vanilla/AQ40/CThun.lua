local isClassic = WOW_PROJECT_ID == (WOW_PROJECT_CLASSIC or 2)
local isBCC = WOW_PROJECT_ID == (WOW_PROJECT_BURNING_CRUSADE_CLASSIC or 5)
local catID
if isBCC or isClassic then
	catID = 2
else--retail or wrath classic and later
	catID = 1
end
local mod	= DBM:NewMod("CThun", "DBM-Raids-Vanilla", catID)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241219145742")
mod:SetCreatureID(15589, 15727)
mod:SetEncounterID(717)
mod:SetHotfixNoticeRev(20200823000000)--2020, 8, 23
mod:SetMinSyncRevision(20200820000000)--2020, 8, 20
mod:SetZone(531)

mod:RegisterCombat("combat")
mod:SetWipeTime(25)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 26134 341722",
	"SPELL_CAST_SUCCESS 26586",
	"SPELL_AURA_APPLIED 26476",
	"SPELL_AURA_REMOVED 26476",
	"CHAT_MSG_MONSTER_EMOTE",
	"UNIT_DIED"
)

local warnEyeTentacle			= mod:NewAnnounce("WarnEyeTentacle", 2, 126)
local warnClawTentacle			= mod:NewAnnounce("WarnClawTentacle2", 2, 26391, false)
local warnGiantEyeTentacle		= mod:NewAnnounce("WarnGiantEyeTentacle", 3, 126)
local warnGiantClawTentacle		= mod:NewAnnounce("WarnGiantClawTentacle", 3, 26391)
local warnPhase2				= mod:NewPhaseAnnounce(2)

local specWarnDarkGlare			= mod:NewSpecialWarningDodge(26029, nil, nil, nil, 3, 2)
local specWarnWeakened			= mod:NewSpecialWarning("SpecWarnWeakened", nil, nil, nil, 2, 2, nil, 28598)
local specWarnEyeBeam			= mod:NewSpecialWarningYou(26134, nil, nil, nil, 1, 2)
local yellEyeBeam				= mod:NewYell(26134)

local timerDarkGlareCD			= mod:NewNextTimer(86, 26029)
local timerDarkGlare			= mod:NewBuffActiveTimer(39, 26029)
local timerEyeTentacle			= mod:NewTimer(45, "TimerEyeTentacle", 126, nil, nil, 1)
local timerGiantEyeTentacle		= mod:NewTimer(60, "TimerGiantEyeTentacle", 126, nil, nil, 1)
local timerClawTentacle			= mod:NewTimer(8, "TimerClawTentacle", 26391, nil, nil, 1) -- every 8 seconds
local timerGiantClawTentacle	= mod:NewTimer(60, "TimerGiantClawTentacle", 26391, nil, nil, 1)
local timerWeakened				= mod:NewTimer(45, "TimerWeakened", 28598)

mod:AddRangeFrameOption("10")
mod:AddSetIconOption("SetIconOnEyeBeam", 26134, true, 0, {1})
mod:AddInfoFrameOption(26476, true)

local firstBossMod = DBM:GetModByName("AQ40Trash")
local playersInStomach = {}
local fleshTentacles, diedTentacles = {}, {}

local updateInfoFrame
do
	local twipe, tsort = table.wipe, table.sort
	local lines = {}
	local sortedLines = {}
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = tostring(value)
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		twipe(lines)
		twipe(sortedLines)
		--First, process players in stomach and gather tentacle information and debuff stacks
		for name in pairs(playersInStomach) do
			local uId = DBM:GetRaidUnitId(name)
			if uId then
				--First, display their stomach debuff stacks
				local spellName, _, count, _, _, _, _, _, _, _, _, _, _, _, _, count2 = DBM:UnitDebuff(uId, 26476)
				if spellName and (count or count2) then
					addLine(name, count2 or count)
				end
				--Also, process their target information for tentacles
				local targetuId = uId.."target"
				local guid = UnitGUID(targetuId)
				if guid and (mod:GetCIDFromGUID(guid) == 15802) and not diedTentacles[guid] then--Targetting Flesh Tentacle
					fleshTentacles[guid] = math.floor(UnitHealth(targetuId) / UnitHealthMax(targetuId) * 100)
				end
			end
		end
		--Now, show tentacle data after it's been updated from player processing
		local nLines = 0
		for _, health in pairs(fleshTentacles) do
			nLines = nLines + 1
			addLine(L.FleshTent .. " " .. nLines, health == 0 and DEAD or (health .. "%"))
		end
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	table.wipe(playersInStomach)
	table.wipe(fleshTentacles)
	table.wipe(diedTentacles)
	self:SetStage(1)
	timerClawTentacle:Start(9-delay) -- Combatlog told me, the first Claw Tentacle spawn in 00:00:09, but need more test.
	timerEyeTentacle:Start(45-delay)
	timerDarkGlareCD:Start(48-delay)
	self:ScheduleMethod(48-delay, "DarkGlare")
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
end

function mod:OnCombatEnd(wipe, isSecondRun)
	table.wipe(diedTentacles)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	--Only run on second run, to ensure trash mod has had enough time to update requiredBosses
	if not wipe and isSecondRun and firstBossMod.vb.firstEngageTime and firstBossMod.Options.SpeedClearTimer then
		if firstBossMod.vb.requiredBosses < 5 then
			DBM:AddMsg(L.NotValid:format(5 - firstBossMod.vb.requiredBosses .. "/4"))
		end
	end
end

function mod:DarkGlare()
	--ghost check, because if someone releases during encounter, this loop continues until they zone back in
	--We don't want to spam dark glare warnings while they are a ghost outside running back on a wipe
	if not UnitIsDeadOrGhost("player") then
		specWarnDarkGlare:Show()
		specWarnDarkGlare:Play("laserrun")--Or "watchstep" ?
	end
	timerDarkGlare:Start()
	timerDarkGlareCD:Start()
	self:ScheduleMethod(86, "DarkGlare")
end

do
	function mod:EyeBeamTarget(targetname, uId)
		if not targetname then return end
		if targetname == UnitName("player") then
			specWarnEyeBeam:Show()
			specWarnEyeBeam:Play("targetyou")
			yellEyeBeam:Yell()
		end
		if self.Options.SetIconOnEyeBeam then
			self:SetIcon(targetname, 1, 3)
		end
	end

	function mod:SPELL_CAST_START(args)
		if args:IsSpell(26134, 341722) then
			-- the eye target can change to the correct target a tiny bit after the cast starts
			self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "EyeBeamTarget", 0.1, 3)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpell(26586) then
		 local cid = self:GetCIDFromGUID(args.sourceGUID)
		 if self:AntiSpam(5, cid) then--Throttle multiple spawn within 5 seconds
			if cid == 15726 then--Eye Tentacle
				timerEyeTentacle:Stop()
				warnEyeTentacle:Show()
				timerEyeTentacle:Start(self:GetStage(2) and 30 or 45)
			elseif cid == 15725 then -- Claw Tentacle
				timerClawTentacle:Stop()
				warnClawTentacle:Show()
				timerClawTentacle:Start()
			elseif cid == 15334 then -- Giant Eye Tentacle
				timerGiantEyeTentacle:Stop()
				warnGiantEyeTentacle:Show()
				timerGiantEyeTentacle:Start()
			elseif cid == 15728 then -- Giant Claw Tentacle
				timerGiantClawTentacle:Stop()
				warnGiantClawTentacle:Show()
				timerGiantClawTentacle:Start()
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpell(26476) then
		--I'm aware debuff stacks, but it's a context that doesn't matter to this mod
		if not playersInStomach[args.destName] then
			self:TestTrace("EnterStomach", args.destName)
		end
		playersInStomach[args.destName] = true
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:SetHeader(L.Stomach)
			DBM.InfoFrame:Show(42, "function", updateInfoFrame, false, false)
			DBM.InfoFrame:SetColumns(1)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpell(26476) then
		playersInStomach[args.destName] = nil
		self:TestTrace("LeaveStomach", args.destName)
	end
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if msg == L.Weakened or msg:find(L.Weakened) then
		self:SendSync("Weakened")
	end
end

local function removeDeadTentacle(guid)
	fleshTentacles[guid] = nil
	diedTentacles[guid] = true
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 15589 then
		self:SetStage(2)
		warnPhase2:Show()
		timerDarkGlareCD:Stop()
		timerEyeTentacle:Stop()
		timerClawTentacle:Stop() -- Claw Tentacle never respawns in phase2
		timerEyeTentacle:Start(40.5)
		timerGiantClawTentacle:Start(10.5)
		timerGiantEyeTentacle:Start(41.3)
		self:UnscheduleMethod("DarkGlare")
	elseif cid == 15802 then -- Flesh Tentacle
		-- Delayed removal to keep dead tentacles visible in the frame while the phase is still ongoing
		-- Weaken will also clear the table clearing the frame
		fleshTentacles[args.destGUID] = 0
		self:Schedule(30, removeDeadTentacle, args.destGUID)
	end
end

function mod:OnSync(msg)
	if not self:IsInCombat() then return end
	if msg == "Weakened" then
		table.wipe(fleshTentacles)
		specWarnWeakened:Show()
		specWarnWeakened:Play("targetchange")
		timerEyeTentacle:Stop()
		timerGiantClawTentacle:Stop()
		timerGiantEyeTentacle:Stop()
		timerWeakened:Start()
		timerEyeTentacle:Start(83) -- 53+30
		timerGiantClawTentacle:Start(53) -- Renew Giant Claw Tentacle Spawn Timer, After C'Thun be Weakened
		timerGiantEyeTentacle:Start(83.7) -- Renew Giant Eye Tentacle Spawn Timer, After C'Thun be Weakened, A litter later than Eye Tentacles Spawn.(0.7s)
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	end
end
