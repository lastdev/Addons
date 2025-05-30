local mod	= DBM:NewMod("Malygos", "DBM-Raids-WoTLK", 6)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241103133102")
mod:SetCreatureID(28859)
mod:SetEncounterID(1094)
mod:SetModelID(26752)
mod:SetZone(616)

mod:RegisterCombat("combat")
mod:SetWipeTime(45)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 60936 57407",
	"SPELL_CAST_START 56505",
	"SPELL_CAST_SUCCESS 56105 57430"
)

local warnSpark					= mod:NewSpellAnnounce(56140, 2, 59381)
local warnVortex				= mod:NewSpellAnnounce(56105, 3)
local warnVortexSoon			= mod:NewSoonAnnounce(56105, 2)
local warnBreathInc				= mod:NewSoonAnnounce(56505, 3)
local warnSurge					= mod:NewTargetAnnounce(60936, 3)
local warnStaticField			= mod:NewTargetNoFilterAnnounce(57430, 3)

local specWarnBreath			= mod:NewSpecialWarningSpell(56505, nil, nil, nil, 2, 2)
local specWarnSurge				= mod:NewSpecialWarningDefensive(60936, nil, nil, nil, 1, 2)
local specWarnStaticField		= mod:NewSpecialWarningYou(57430, nil, nil, nil, 1, 2)
local yellStaticField			= mod:NewYell(57430)

local timerSpark				= mod:NewNextTimer(30, 56140, nil, nil, nil, 1, 59381, DBM_COMMON_L.DAMAGE_ICON)
local timerVortex				= mod:NewCastTimer(11, 56105, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerVortexCD				= mod:NewNextTimer(60, 56105, nil, nil, nil, 2)
local timerBreath				= mod:NewBuffActiveTimer(8, 56505, nil, nil, nil, 5)--lasts 5 seconds plus 3 sec cast.
local timerBreathCD				= mod:NewCDTimer(59, 56505, nil, nil, nil, 2)
local timerStaticFieldCD		= mod:NewCDTimer(15.5, 57430, nil, nil, nil, 3)--High 15-25 second variatoin
local timerAchieve      		= mod:NewAchievementTimer(360, 1875)

local enrageTimer				= mod:NewBerserkTimer(615)

local tableBuild = false
local guids = {}
local surgeTargets = {}

local function buildGuidTable()
	table.wipe(guids)
	for uId in DBM:GetGroupMembers() do
		local name = DBM:GetUnitFullName(uId)
		guids[UnitGUID(uId.."pet") or "none"] = name
	end
	tableBuild = true
end

local function announceTargets(self)
	warnSurge:Show(table.concat(surgeTargets, "<, >"))
	table.wipe(surgeTargets)
end

function mod:StaticFieldTarget()
	local targetname, uId = self:GetBossTarget(28859)
	if not targetname or not uId then return end
	local targetGuid = UnitGUID(uId)
	if not tableBuild then
		buildGuidTable()
	end
	local announcetarget = guids[targetGuid]
	if not announcetarget then return end
	if announcetarget == UnitName("player") then
		specWarnStaticField:Show()
		specWarnStaticField:Play("runaway")
		yellStaticField:Yell()
	else
		warnStaticField:Show(announcetarget)
	end
end

function mod:OnCombatStart(delay)
	tableBuild = false
	self:SetStage(1)
	timerVortexCD:Start(44.6-delay)--Will verify with more logs next week.
	enrageTimer:Start(-delay)
	timerAchieve:Start(-delay)
	table.wipe(guids)
	if not self:IsClassic() then--Use better more accurate method on retail where boss UnitIds are available
		self:RegisterShortTermEvents(
			"UNIT_SPELLCAST_SUCCEEDED boss1"
		)
	else--Use legacy localized trigger and syncs
		self:RegisterShortTermEvents(
			"RAID_BOSS_EMOTE"
		)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(60936, 57407) then
		local target = guids[args.destGUID or 0]
		if target then
			surgeTargets[#surgeTargets + 1] = target
			self:Unschedule(announceTargets)
			if #surgeTargets >= 3 then
				announceTargets(self)
			else
				self:Schedule(0.5, announceTargets, self)
			end
			if target == UnitName("player") then
				specWarnSurge:Show()
				specWarnSurge:Play("defensive")
			end
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 56505 then--His deep breath
		specWarnBreath:Show()
		specWarnBreath:Play("findshield")
		timerBreath:Start()
		timerBreathCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 56105 then
		timerVortexCD:Start()
		warnVortexSoon:Schedule(54)
		warnVortex:Show()
		timerVortex:Start()
		if timerSpark:GetTime() < 11 and timerSpark:IsStarted() then
			timerSpark:Update(18, 30)
		end
	elseif args.spellId == 57430 then
		self:ScheduleMethod(0.1, "StaticFieldTarget")
--		warnStaticField:Show()
		timerStaticFieldCD:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	--Secondary pull trigger, so we can detect combat when he's pulled while already in combat (which is about 99% of time)
	if (msg == L.YellPull or msg:find(L.YellPull)) and not self:IsInCombat() then
		DBM:StartCombat(self, 0)
	elseif msg:sub(0, L.YellPhase2:len()) == L.YellPhase2 then
		self:SendSync("Phase2")
	elseif msg == L.YellBreath or msg:find(L.YellBreath) then
		self:SendSync("BreathSoon")
	elseif msg:sub(0, L.YellPhase3:len()) == L.YellPhase3 then
		self:SendSync("Phase3")
	end
end

--Localized trigger for Wrath Classic
function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.EmoteSpark or msg:find(L.EmoteSpark) then
		self:SendSync("Spark")
	end
end

--localization free triggers that's better but can only be used on retail where boss1 UnitId available
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
--	"<39.8> [UNIT_SPELLCAST_SUCCEEDED] Malygos:Possible Target<Omegal>:target:Summon Power Spark::0:56140", -- [998]
	if spellId == 56140 then
		warnSpark:Show()
		timerSpark:Start()
	end
end

function mod:OnSync(event, arg)
	if not self:IsInCombat() then return end
	if event == "Phase2" then
		self:SetStage(2)
		timerSpark:Cancel()
		timerVortexCD:Cancel()
		warnVortexSoon:Cancel()
		timerBreathCD:Start(94)
	elseif event == "BreathSoon" then
		warnBreathInc:Show()
	elseif event == "Phase3" then
		self:SetStage(3)
		self:Schedule(6, buildGuidTable)
		timerBreathCD:Cancel()
--		timerStaticFieldCD:Start(49.5)--Consistent?
	elseif event == "Spark" then
		warnSpark:Show()
		timerSpark:Start()
	end
end
