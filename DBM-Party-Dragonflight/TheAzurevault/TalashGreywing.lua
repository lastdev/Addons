local mod	= DBM:NewMod(2483, "DBM-Party-Dragonflight", 6, 1203)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240601044955")
mod:SetCreatureID(186737)
mod:SetEncounterID(2583)
mod:SetHotfixNoticeRev(20221027000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29
mod.sendMainBossGUID = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 386781 387151 388008",
	"SPELL_AURA_APPLIED 386881",
	"SPELL_AURA_REMOVED 386881",
	"SPELL_PERIODIC_DAMAGE 387150",
	"SPELL_PERIODIC_MISSED 387150"
)

--TODO, detect icy devastator target working? Show range frame entire fight, or just when icy is out?
--TODO, are timers different on M+ or same as before? right now it's assumed timers are just different on M0
--[[
(ability.id = 388008 or ability.id = 386781 or ability.id = 387151) and type = "begincast"
 or type = "dungeonencounterstart" or type = "dungeonencounterend"
--]]
--local warnStaggeringBarrage					= mod:NewSpellAnnounce(361018, 3)

--local specWarnInfusedStrikes					= mod:NewSpecialWarningStack(361966, nil, 8, nil, nil, 1, 6)
local specWarnFrostBomb							= mod:NewSpecialWarningMoveAway(386781, nil, nil, nil, 1, 2)
local yellFrostBomb								= mod:NewYell(386781)
local yellFrostBombFades						= mod:NewShortFadesYell(386781)
local specWarnIcyDevastator						= mod:NewSpecialWarningMoveAway(387151, nil, nil, nil, 1, 2)
local yellIcyDevastator							= mod:NewYell(387151)
local specWarAbsoluteZero						= mod:NewSpecialWarningMoveTo(388008, nil, nil, nil, 3, 2)
local specWarnGTFO								= mod:NewSpecialWarningGTFO(387150, nil, nil, nil, 1, 8)

local timerFrostBombCD							= mod:NewCDTimer(15.3, 386781, nil, nil, nil, 3)--15-24 (mod should account for two  mechanics that cause these delays)
local timerIcyDevastatorCD						= mod:NewCDTimer(22.6, 387151, nil, nil, nil, 3)
local timerAbsoluteZeroCD						= mod:NewNextTimer(60, 388008, nil, nil, nil, 2)

mod:AddRangeFrameOption(8, 387151)


local vaultRuin = DBM:GetSpellName(388072)

function mod:DevastatorTarget(targetname)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnIcyDevastator:Show()
		specWarnIcyDevastator:Play("runout")
		yellIcyDevastator:Yell()
	end
end

function mod:OnCombatStart(delay)
	timerFrostBombCD:Start(3.6-delay)
	timerIcyDevastatorCD:Start(10-delay)--14.7 now?
	timerAbsoluteZeroCD:Start(21.8-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 386781 then
		timerFrostBombCD:Start()
	elseif spellId == 387151 then
		timerIcyDevastatorCD:Start(22.6)--No longer 32.8 in non M+
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "DevastatorTarget", 0.1, 6, true)
		--If time remaining on frost bomb less than 6, time remaining increased to 6
		if timerFrostBombCD:GetRemaining() < 6 then
			local elapsed, total = timerFrostBombCD:GetTime()
			local extend = 6 - (total-elapsed)
			DBM:Debug("timerFrostBombCD extended by: "..extend, 2)
			timerFrostBombCD:Update(elapsed, total+extend)
		end
	elseif spellId == 388008 then
		specWarAbsoluteZero:Show(vaultRuin)
		specWarAbsoluteZero:Play("findshelter")
		timerAbsoluteZeroCD:Start()
		timerFrostBombCD:Stop()
		timerFrostBombCD:Start(12.2)
		timerIcyDevastatorCD:Stop()
		timerIcyDevastatorCD:Start(self:IsMythicPlus() and 19.6 or 23.2)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 386881 then
		if args:IsPlayer() then
			specWarnFrostBomb:Show()
			specWarnFrostBomb:Play("runout")
			yellFrostBomb:Yell()
			yellFrostBombFades:Countdown(spellId)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 386881 then
		if args:IsPlayer() then
			yellFrostBombFades:Cancel()
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 387150 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
