local mod	= DBM:NewMod("Souls", "DBM-BlackTemple")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 612 $"):sub(12, -3))
mod:SetCreatureID(23420)
mod:SetEncounterID(606)
mod:SetModelID(21483)
mod:SetZone()
mod:SetUsedIcons(4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 41305 41431 41376 41303 41294 41410",
	"SPELL_AURA_REMOVED 41305",
	"SPELL_CAST_START 41410 41426",
	"SPELL_CAST_SUCCESS 41350 41337",
	"SPELL_DAMAGE 41545",
	"SPELL_MISSED 41545",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3"
)

--TODO, if boss unit IDs ar never added, register target/mouseover to detect the phase change transitions
local warnFixate		= mod:NewTargetAnnounce(41294, 3, nil, "Tank|Healer")
local warnDrain			= mod:NewTargetAnnounce(41303, 3, nil, "Healer", 2)
local warnEnrage		= mod:NewSpellAnnounce(41305, 4, 41292)
local warnEnrageSoon	= mod:NewPreWarnAnnounce(41305, 5, 3)
local warnEnrageEnd		= mod:NewEndAnnounce(41305, 3)

local warnPhase2		= mod:NewPhaseAnnounce(2, 2)
local warnMana			= mod:NewAnnounce("WarnMana", 4, 41350)
local warnDeaden		= mod:NewTargetAnnounce(41410, 3)
local warnShield		= mod:NewSpellAnnounce(41431, 3)

local warnPhase3		= mod:NewPhaseAnnounce(3, 2)
local warnSoul			= mod:NewSpellAnnounce(41545, 3)
local warnSpite			= mod:NewTargetAnnounce(41376, 3)

local specWarnShock		= mod:NewSpecialWarningInterrupt(41426, "HasInterrupt", nil, 2)
local specWarnShield	= mod:NewSpecialWarningDispel(41431, "MagicDispeller", nil, 2)
local specWarnSpite		= mod:NewSpecialWarningYou(41376)

local timerPhaseChange	= mod:NewPhaseTimer(41)
local timerEnrage		= mod:NewBuffActiveTimer(15, 41305)
local timerNextEnrage	= mod:NewNextTimer(32, 41305)
local timerDeaden		= mod:NewTargetTimer(10, 41410)
local timerNextDeaden	= mod:NewCDTimer(31, 41410)
local timerMana			= mod:NewTimer(160, "TimerMana", 41350)
local timerNextShield	= mod:NewCDTimer(15, 41431)
local timerNextSoul		= mod:NewCDTimer(10, 41545)
local timerNextShock	= mod:NewCDTimer(12, 41426, nil, nil, nil, 4)--Blizz lied, this is a 12-15 second cd. you can NOT solo interrupt these with most classes

local countdownDeaden	= mod:NewCountdown(31, 41410, "Tank" and select(2, UnitClass("player")) == "WARRIOR")

mod:AddSetIconOption("DrainIcon", 41303, false)
mod:AddSetIconOption("SpiteIcon", 41376, false)

mod.vb.lastFixate = "None"

function mod:OnCombatStart(delay)
	self.vb.lastFixate = "None"
	timerNextEnrage:Start(47-delay)
	warnEnrageSoon:Schedule(42-delay)
	if DBM.BossHealth:IsShown() then
		DBM.BossHealth:Clear()
		DBM.BossHealth:Show(L.name)
		DBM.BossHealth:AddBoss(23418, L.Suffering)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 41305 then
		warnEnrage:Show()
		timerEnrage:Start()
	elseif args.spellId == 41431 and not args:IsDestTypePlayer() then
		warnShield:Show()
		timerNextShield:Start()
		specWarnShield:Show(args.destName)
	elseif args.spellId == 41376 then
		warnSpite:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnSpite:Show()
		end
		if self.Options.SpiteIcon then
			self:SetAlphaIcon(0.5, args.destName)
		end
	elseif args.spellId == 41303 then
		warnDrain:CombinedShow(1, args.destName)
		if self.Options.DrainIcon then
			self:SetAlphaIcon(1, args.destName)
		end
	elseif args.spellId == 41294 then
		if self.vb.lastFixate ~= args.destName then
			warnFixate:Show(args.destName)
			self.vb.lastFixate = args.destName
		end
	elseif args.spellId == 41410 then
		warnDeaden:Show(args.destName)
		timerDeaden:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 41305 then
		warnEnrageEnd:Show()
		warnEnrageSoon:Schedule(27)
		timerNextEnrage:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 41410 then
		timerNextDeaden:Start()
		countdownDeaden:Start()
	elseif args.spellId == 41426 then
		timerNextShock:Start()
		specWarnShock:Show(args.sourceName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 41350 then --Aura of Desire
		warnPhase2:Show()
		warnMana:Schedule(130)
		timerMana:Start()
		timerNextShield:Start(13)
		timerNextDeaden:Start(28)
		if DBM.BossHealth:IsShown() then
			DBM.BossHealth:AddBoss(23419, L.Desire)
		end
	elseif args.spellId == 41337 then --Aura of Anger
		warnPhase3:Show()
		timerNextSoul:Start()
		if DBM.BossHealth:IsShown() then
			DBM.BossHealth:AddBoss(23450, L.Anger)
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, _, _, _, _, spellId)
	if spellId == 41545 and self:AntiSpam(3, 1) then
		warnSoul:Show()
		timerNextSoul:Start()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 28819 and self:AntiSpam(2, 2) then--Submerge Visual
		self:SendSync("PhaseEnd")
	end
end

function mod:OnSync(msg)
	if msg == "PhaseEnd" then
		warnEnrageEnd:Cancel()
		warnEnrageSoon:Cancel()
		warnMana:Cancel()
		timerNextEnrage:Stop()
		timerEnrage:Stop()
		timerMana:Stop()
		timerNextShield:Stop()
		timerNextDeaden:Stop()
		countdownDeaden:Cancel()
		timerNextShock:Stop()
		timerPhaseChange:Start()--41
		if DBM.BossHealth:IsShown() then
			DBM.BossHealth:Clear()
		end
	end
end
