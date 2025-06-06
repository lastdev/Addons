local mod	= DBM:NewMod("GeneralVezax", "DBM-Raids-WoTLK", 5)
local L		= mod:GetLocalizedStrings()

if not mod:IsClassic() then--on classic, it's normal10,normal25, defined in toc, only retail overrides to flex/timewalking
	mod.statTypes = "normal,timewalker"
end

mod:SetRevision("20241103133102")
mod:SetCreatureID(33271)
if mod:IsPostCata() then
	mod:SetEncounterID(1134)
else
	mod:SetEncounterID(755)
end
mod:SetModelID(28548)
mod:SetUsedIcons(7, 8)
mod:SetHotfixNoticeRev(20230120000000)
mod:SetZone(603)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 62661 62662",
	"SPELL_AURA_APPLIED 62662",
	"SPELL_AURA_REMOVED 62662",
	"SPELL_CAST_SUCCESS 62660 63276 63364",
	"UNIT_DIED",
	"RAID_BOSS_EMOTE"
)

--TODO, log, detect, and cancel hardmode timer when any vapors get broken
local warnShadowCrash			= mod:NewTargetNoFilterAnnounce(62660, 4)
local warnLeechLife				= mod:NewTargetNoFilterAnnounce(63276, 3)
local warnSaroniteVapor			= mod:NewCountAnnounce(63337, 2)

local specWarnShadowCrash		= mod:NewSpecialWarningDodge(62660, nil, nil, nil, 1, 2)
local yellShadowCrash			= mod:NewYell(62660)
local specWarnSurgeDarkness		= mod:NewSpecialWarningDefensive(62662, nil, nil, 2, 1, 2)
local specWarnLifeLeechYou		= mod:NewSpecialWarningMoveAway(63276, nil, nil, nil, 3, 2)
local yellLifeLeech				= mod:NewYell(63276)
local specWarnSearingFlames		= mod:NewSpecialWarningInterruptCount(62661, "HasInterrupt", nil, nil, 1, 2)
local specWarnAnimus
if WOW_PROJECT_ID == (WOW_PROJECT_MAINLINE or 1) then
	specWarnAnimus			= mod:NewSpecialWarningSwitch("ej17651", nil, nil, nil, 1, 2)
else
	specWarnAnimus			= mod:NewSpecialWarning("specWarnAnimus", nil, nil, nil, 1, 2)
end

local timerEnrage				= mod:NewBerserkTimer(600)
local timerSurgeofDarkness		= mod:NewBuffActiveTimer(10, 62662, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerNextSurgeofDarkness	= mod:NewCDTimer(61.7, 62662, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerSaroniteVapors		= mod:NewNextCountTimer(30, 63322, nil, nil, nil, 5)
local timerShadowCrashCD		= mod:NewCDTimer(10, 62660, nil, "Ranged", nil, 3)
local timerLifeLeech			= mod:NewTargetTimer(10, 63276, nil, false, 2, 3)
local timerLifeLeechCD			= mod:NewCDTimer(20.4, 63276, nil, "Ranged", 2, 3, nil, nil, nil, 1, 3)
local timerHardmode				= mod:NewTimer(189, "hardmodeSpawn", nil, nil, nil, 1)

mod:AddSetIconOption("SetIconOnShadowCrash", 62660, true, 0, {8})
mod:AddSetIconOption("SetIconOnLifeLeach", 63276, true, 0, {7})

mod.vb.interruptCount = 0
mod.vb.vaporsCount = 0
mod.vb.lastMarkTarget = nil
local animusName = DBM:EJ_GetSectionInfo(17651)

function mod:ShadowCrashTarget(targetname, uId)
	if not targetname then return end
	if self.Options.SetIconOnShadowCrash then
		self:SetIcon(targetname, 8, 5)
	end
	if targetname == UnitName("player") then
		specWarnShadowCrash:Show()
		specWarnShadowCrash:Play("runaway")
		yellShadowCrash:Yell()
	else
		warnShadowCrash:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	self.vb.interruptCount = 0
	self.vb.vaporsCount = 0
	self.vb.lastMarkTarget = nil
	timerShadowCrashCD:Start(10.9-delay)
	timerLifeLeechCD:Start(15.7-delay)
	timerSaroniteVapors:Start(30-delay, 1)
	timerEnrage:Start(-delay)
	timerHardmode:Start(self:IsClassic() and 254 or 189-delay)
	timerNextSurgeofDarkness:Start(-delay)
	DBM:AddMsg("If vezax is not targeted or set to focus target when animus is out, you will not get alerts for shadow crash")
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 62661 then	-- Searing Flames
		self.vb.interruptCount = self.vb.interruptCount + 1
		if self.vb.interruptCount == 4 then
			self.vb.interruptCount = 1
		end
		local kickCount = self.vb.interruptCount
		specWarnSearingFlames:Show(args.sourceName, kickCount)
		specWarnSearingFlames:Play("kick"..kickCount.."r")
	elseif args.spellId == 62662 then
		local tanking, status = UnitDetailedThreatSituation("player", "boss1")
		if tanking or (status == 3) then--Player is current target
			specWarnSurgeDarkness:Show()
			specWarnSurgeDarkness:Play("defensive")
		end
		timerNextSurgeofDarkness:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 62662 then	-- Surge of Darkness
		timerSurgeofDarkness:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 62662 then
		timerSurgeofDarkness:Stop()
	end
end

local function resetMarkTarget(self)
	self.vb.lastMarkTarget = nil
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 62660 then		-- Shadow Crash
		self:BossTargetScanner(args.sourceGUID, "ShadowCrashTarget", 0.05, 12, nil, nil, nil, self.vb.lastMarkTarget, nil, nil, true)
		local timer = 10--Blizzard confirmed it's a 10-15 second variable timer on final version of fight (ie retail)
		if self:IsClassic() then
			timer = self:IsDifficulty("normal25") and 7 or 10
		end
		timerShadowCrashCD:Start(timer)
	elseif args.spellId == 63276 then	-- Mark of the Faceless
		self.vb.lastMarkTarget = args.destName
		if self.Options.SetIconOnLifeLeach then
			self:SetIcon(args.destName, 7, 10)
		end
		timerLifeLeech:Start(args.destName)
		timerLifeLeechCD:Start()
		if args:IsPlayer() then
			specWarnLifeLeechYou:Show()
			specWarnLifeLeechYou:Play("runout")
			yellLifeLeech:Yell()
		else
			warnLeechLife:Show(args.destName)
		end
		self:Schedule(3, resetMarkTarget, self)
	elseif args.spellId == 63364 then
		specWarnAnimus:Show()
		specWarnAnimus:Play("bigmob")
		DBM:AddMsg("If Vezax is not targeted by at least one raid member at all times, or set as YOUR focus target when animus is out, you will not get alerts for shadow crash")
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 33488 then--Saronite Vapor
		timerHardmode:Stop()
	end
end

function mod:RAID_BOSS_EMOTE(emote)
	if emote == L.EmoteSaroniteVapors or emote:find(L.EmoteSaroniteVapors) then
		self.vb.vaporsCount = self.vb.vaporsCount + 1
		warnSaroniteVapor:Show(self.vb.vaporsCount)
		local expectedVapors = self:IsClassic() and 8 or 6
		if self.vb.vaporsCount < expectedVapors then
			timerSaroniteVapors:Start(nil, self.vb.vaporsCount+1)
		end
	end
end
