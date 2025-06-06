local mod	= DBM:NewMod("Lanathel", "DBM-Raids-WoTLK", 2)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,normal25,heroic,heroic25"

mod:SetRevision("20241103133102")
mod:SetCreatureID(37955)
mod:SetEncounterID(not mod:IsPostCata() and 853 or 1103)
mod:SetModelID(31165)
mod:SetUsedIcons(1, 2, 3, 4, 7)
mod:SetZone(631)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 71340 71510 70838 70877 70867 70879 70923 71772",
	"SPELL_AURA_REMOVED 71340 71510 70838 70877",
	"SPELL_CAST_SUCCESS 73070",
	"SPELL_DAMAGE 71726 70946",
	"SPELL_PERIODIC_DAMAGE 71277",
	"SPELL_PERIODIC_MISSED 71277",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnPactDarkfallen			= mod:NewTargetAnnounce(71340, 4)
local warnBloodMirror				= mod:NewTargetNoFilterAnnounce(71510, 3, nil, "Tank|Healer")
local warnSwarmingShadows			= mod:NewTargetAnnounce(71266, 4)
local warnInciteTerror				= mod:NewSpellAnnounce(73070, 3, nil, nil, nil, nil, nil, 2)
local warnVampricBite				= mod:NewTargetNoFilterAnnounce(70946, 2)
local warnBloodthirstSoon			= mod:NewSoonAnnounce(70877, 2)
local warnBloodthirst				= mod:NewTargetNoFilterAnnounce(70877, 3, nil, false)
local warnEssenceoftheBloodQueen	= mod:NewTargetNoFilterAnnounce(70867, 3, nil, false)

local specWarnBloodBolt				= mod:NewSpecialWarningSpell(71772, nil, nil, nil, 2, 2)
local specWarnPactDarkfallen		= mod:NewSpecialWarningYou(71340, nil, nil, nil, 1, 2)
local specWarnEssenceoftheBloodQueen= mod:NewSpecialWarningYou(70867, nil, nil, nil, 1, 2)
local specWarnBloodthirst			= mod:NewSpecialWarningYou(70877, nil, nil, nil, 3, 2)
local yellBloodthirst				= mod:NewYell(70877, L.YellFrenzy)
local specWarnSwarmingShadows		= mod:NewSpecialWarningYou(71266, nil, nil, nil, 1, 2)
local specWarnMindConrolled			= mod:NewSpecialWarningTarget(70923, "-Healer", nil, nil, 1, 2)
local specWarnGTFO					= mod:NewSpecialWarningGTFO(71266, nil, nil, nil, 1, 8)

local timerNextInciteTerror			= mod:NewNextTimer(100, 73070, nil, nil, nil, 6)
local timerFirstBite				= mod:NewNextTimer(15, 70946, nil, "Dps", nil, 5)
local timerNextPactDarkfallen		= mod:NewNextTimer(30.5, 71340, nil, nil, nil, 3)
local timerNextSwarmingShadows		= mod:NewNextTimer(30.5, 71266, nil, nil, nil, 3)
local timerInciteTerror				= mod:NewBuffActiveTimer(4, 73070)
local timerBloodBolt				= mod:NewBuffActiveTimer(6, 71772, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerBloodThirst				= mod:NewBuffFadesTimer(10, 70877, nil, nil, nil, 5)
local timerEssenceoftheBloodQueen	= mod:NewBuffFadesTimer(60, 70867, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)

local berserkTimer					= mod:NewBerserkTimer(320)

mod:AddSetIconOption("BloodMirrorIcon", 71510, false, 0, {7})--red x for blood link
mod:AddSetIconOption("SwarmingShadowsIcon2", 71266, false, 0, {4})
mod:AddSetIconOption("SetIconOnDarkFallen2", 71340, false, 0, {1, 2, 3})
mod:AddRangeFrameOption(8, 71446)

local pactTargets = {}
mod.vb.pactIcons = 1

local function warnPactTargets(self)
	warnPactDarkfallen:Show(table.concat(pactTargets, "<, >"))
	table.wipe(pactTargets)
	timerNextPactDarkfallen:Start(30)
	self.vb.pactIcons = 1
end

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerFirstBite:Start(-delay)
	timerNextPactDarkfallen:Start(15-delay)
	timerNextSwarmingShadows:Start(-delay)
	table.wipe(pactTargets)
	self.vb.pactIcons = 1
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
	if self:IsDifficulty("normal10", "heroic10") then
		timerNextInciteTerror:Start(124-delay)
	else
		timerNextInciteTerror:Start(127-delay)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 71340 then		--Pact of the Darkfallen
		pactTargets[#pactTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnPactDarkfallen:Show()
			specWarnPactDarkfallen:Play("linegather")
		end
		if self.Options.SetIconOnDarkFallen2 then
			self:SetIcon(args.destName, self.vb.pactIcons)
		end
		self.vb.pactIcons = self.vb.pactIcons + 1
		self:Unschedule(warnPactTargets)
		if #pactTargets >= 3 then
			warnPactTargets(self)
		else
			self:Schedule(0.3, warnPactTargets, self)
		end
	elseif args:IsSpellID(71510, 70838) then
		warnBloodMirror:Show(args.destName)
		if self.Options.BloodMirrorIcon then
			self:SetIcon(args.destName, 7)
		end
	elseif args.spellId == 70877 then
		warnBloodthirst:Show(args.destName)
		if args:IsPlayer() then
			specWarnBloodthirst:Show()
			specWarnBloodthirst:Play("frenzy")--Eh, closest voice to blood thirst
			yellBloodthirst:Yell()
			if self:IsDifficulty("normal10", "heroic10") then
				timerBloodThirst:Start(15)--15 seconds on 10 man
			else
				timerBloodThirst:Start()--10 seconds on 25 man
			end
		end
	elseif args:IsSpellID(70867, 70879) then	--Essence of the Blood Queen
		warnEssenceoftheBloodQueen:Show(args.destName)
		if args:IsPlayer() then
			specWarnEssenceoftheBloodQueen:Show()
			specWarnEssenceoftheBloodQueen:Play("targetyou")
			if self:IsDifficulty("normal10", "heroic10") then
				timerEssenceoftheBloodQueen:Start(75)--75 seconds on 10 man
				warnBloodthirstSoon:Schedule(70)
			else
				timerEssenceoftheBloodQueen:Start()--60 seconds on 25 man
				warnBloodthirstSoon:Schedule(55)
			end
		end
	elseif args.spellId == 70923 then
		specWarnMindConrolled:Show(args.destName)
		specWarnMindConrolled:Play("findmc")
	elseif args.spellId == 71772 then
		specWarnBloodBolt:Show()
		specWarnBloodBolt:Play("scatter")
		timerBloodBolt:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 71340 then				--Pact of the Darkfallen
		if self.Options.SetIconOnDarkFallen2 then
			self:SetIcon(args.destName, 0)		--Clear icon once you got to where you are supposed to be
		end
	elseif args:IsSpellID(71510, 70838) then	--Blood Mirror
		if self.Options.BloodMirrorIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 70877 then
		if args:IsPlayer() then
			timerBloodThirst:Cancel()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 73070 then				--Incite Terror (fear before air phase)
		warnInciteTerror:Show()
		warnInciteTerror:Play("fearsoon")
		timerInciteTerror:Start()
		timerNextSwarmingShadows:Start()--This resets the swarming shadows timer
		timerNextPactDarkfallen:Start(25)--and the Pact timer also reset -5 seconds
		if self:IsDifficulty("normal10", "heroic10") then
			timerNextInciteTerror:Start(120)--120 seconds in between first and second on 10 man
		else
			timerNextInciteTerror:Start()--100 seconds in between first and second on 25 man
		end
	end
end

function mod:SPELL_DAMAGE(sourceGUID, _, _, _, _, destName, _, _, spellId)
	if (spellId == 71726 or spellId == 70946) and self:GetCIDFromGUID(sourceGUID) == 37955 then	-- Vampric Bite (first bite only, hers)
		warnVampricBite:Show(destName)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 71277 and destGUID == UnitGUID("player") and self:AntiSpam() then		--Swarn of Shadows (spell damage, you're standing in it.)
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:match(L.SwarmingShadows) and target then
		target = DBM:GetUnitFullName(target) or target
		timerNextSwarmingShadows:Start()
		if target == UnitName("player") then
			specWarnSwarmingShadows:Show()
			specWarnSwarmingShadows:Play("runout")
			specWarnSwarmingShadows:ScheduleVoice(1.5, "keepmove")
		else
			warnSwarmingShadows:Show(target)
		end
		if target and self.Options.SwarmingShadowsIcon2 then
			self:SetIcon(target, 4, 6)
		end
	end
end
