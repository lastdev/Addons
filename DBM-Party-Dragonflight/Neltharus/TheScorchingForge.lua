local mod	= DBM:NewMod(2489, "DBM-Party-Dragonflight", 4, 1199)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240714045506")
mod:SetCreatureID(189478)--Forgemaster Gorek
mod:SetEncounterID(2612)
--mod:SetUsedIcons(1, 2, 3)
--mod:SetHotfixNoticeRev(20220322000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29
mod.sendMainBossGUID = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 374969 374839",
	"SPELL_CAST_SUCCESS 374635 374534",
	"SPELL_AURA_APPLIED 374842 374534",
	"SPELL_AURA_REMOVED 374534 374842"
)

--[[
(ability.id = 374969 or ability.id = 374839) and type = "begincast"
 or (ability.id = 374635 or ability.id = 374534) and type = "cast"
 or type = "dungeonencounterstart" or type = "dungeonencounterend"
--]]
local warnBlazinAegis							= mod:NewTargetNoFilterAnnounce(374842, 3)
local warnHeatedSwings							= mod:NewTargetNoFilterAnnounce(374534, 3)

local specWarnMightoftheForge					= mod:NewSpecialWarningCount(374635, nil, nil, nil, 2, 2)
local specWarnBlazinAegis						= mod:NewSpecialWarningMoveAway(374842, nil, nil, nil, 1, 2)
local yellBlazinAegis							= mod:NewYell(374842)
local yellBlazinAegisFades						= mod:NewShortFadesYell(374842)
local specWarnHeatedSwings						= mod:NewSpecialWarningMoveAwayCount(374534, nil, nil, nil, 1, 2)
local yellHeatedSwings							= mod:NewYell(374534)
local yellHeatedSwingsFades						= mod:NewShortFadesYell(374534)
local specWarnForgestorm						= mod:NewSpecialWarningDodgeCount(374969, nil, nil, nil, 2, 2)

--All timers are 30-31 ish
local timerMightoftheForgeCD					= mod:NewNextCountTimer(30.3, 374635, nil, nil, nil, 6, nil, DBM_COMMON_L.HEALER_ICON)--Technically Blazing Hammer is healer icon, but it's passive of this stage
local timerBlazinAegisCD						= mod:NewNextCountTimer(30.3, 374842, nil, nil, nil, 3)
local timerHeatedSwingsCD						= mod:NewNextCountTimer(30.3, 374534, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--Tracked by all since it has 8 yard splash damage
local timerForgestormCD							= mod:NewNextCountTimer(30.3, 374969, nil, nil, nil, 2)

mod.vb.setCount = 0

function mod:OnCombatStart(delay)
	self.vb.setCount = 1--All timers are 30, so only need one variable that'll increment after each set of all 4 casts
	timerMightoftheForgeCD:Start(3.1-delay, 1)
	timerBlazinAegisCD:Start(11.5-delay, 1)
	timerHeatedSwingsCD:Start(20.1-delay, 1)
	timerForgestormCD:Start(26.6-delay, 1)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 374969 then
		specWarnForgestorm:Show(self.vb.setCount)
		specWarnForgestorm:Play("watchstep")
		timerForgestormCD:Start(nil, self.vb.setCount+1)
		self.vb.setCount = self.vb.setCount + 1--Forgestorm is last sability of the 4 ability cast rotation, so increment for next set
	elseif spellId == 374839 then
		timerBlazinAegisCD:Start(nil, self.vb.setCount+1)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 374635 then
		specWarnMightoftheForge:Show(self.vb.setCount)
		specWarnMightoftheForge:Play("aesoon")
		timerMightoftheForgeCD:Start(nil, self.vb.setCount+1)
	elseif spellId == 374534 then
		timerHeatedSwingsCD:Start(nil, self.vb.setCount+1)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 374842 then
		warnBlazinAegis:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnBlazinAegis:Show()
			specWarnBlazinAegis:Play("scatter")
			yellBlazinAegis:Yell()
			yellBlazinAegisFades:Countdown(spellId)
		end
	elseif spellId == 374534 then
		if args:IsPlayer() then
			specWarnHeatedSwings:Show(self.vb.setCount)
			specWarnHeatedSwings:Play("specialsoon")
			yellHeatedSwings:Yell()
			yellHeatedSwingsFades:Countdown(spellId)
		else
			warnHeatedSwings:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 374534 then
		if args:IsPlayer() then
			yellHeatedSwingsFades:Cancel()
		end
	elseif spellId == 374842 then
		if args:IsPlayer() then
			yellBlazinAegisFades:Cancel()
		end
	end
end
