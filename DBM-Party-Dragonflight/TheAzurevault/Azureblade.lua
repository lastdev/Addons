local mod	= DBM:NewMod(2505, "DBM-Party-Dragonflight", 6, 1203)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20231029212301")
mod:SetCreatureID(186739)
mod:SetEncounterID(2585)
mod:SetHotfixNoticeRev(20230103000000)
--mod:SetMinSyncRevision(20211203000000)
--mod.respawnTime = 29
mod.sendMainBossGUID = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 372222 385578 384223 373932 384132",
	"SPELL_AURA_REMOVED 384132"
)

--TODO, change arcane orb to personal alert if target scanner works or remove yell if it doesn't
--TODO, verify post hotfix timers for new mana drain rate 03-13-23
--[[
(ability.id = 372222 or ability.id = 385578 or ability.id = 384223 or ability.id = 384132) and type = "begincast"
 or ability.id = 384132 and type = "removebuff"
 or type = "dungeonencounterstart" or type = "dungeonencounterend"
--]]
--https://www.warcraftlogs.com/reports/1fvXGDK69nmq3MA7#fight=1&pins=2%24Off%24%23244F4B%24expression%24(ability.id%20%3D%20372222%20or%20ability.id%20%3D%20385578%20or%20ability.id%20%3D%20384223%20or%20ability.id%20%3D%20384132)%20and%20type%20%3D%20%22begincast%22%0A%20or%20ability.id%20%3D%20384132%20and%20type%20%3D%20%22removebuff%22%0A%20or%20type%20%3D%20%22dungeonencounterstart%22%20or%20type%20%3D%20%22dungeonencounterend%22&view=events
local warnSummonDraconicImage					= mod:NewSpellAnnounce(384223, 3)

local specWarnArcaneCleave						= mod:NewSpecialWarningSpell(372222, nil, nil, nil, 1, 2)
local specWarnAncientOrb						= mod:NewSpecialWarningDodge(385578, nil, nil, nil, 2, 2)
local yellAncientOrb							= mod:NewYell(385578)
local specWarnIllusionaryBolt					= mod:NewSpecialWarningInterrupt(373932, "HasInterrupt", nil, nil, 1, 2)
local specWarnOverwhelmingEnergy				= mod:NewSpecialWarningSpell(384132, nil, nil, nil, 2, 2)

local timerArcaneCleaveCD						= mod:NewCDTimer(13.3, 372222, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--13.3-15
local timerAncientOrbCD							= mod:NewCDTimer(15.7, 385578, nil, nil, nil, 3)
local timerSummonDraconicImageCD				= mod:NewCDTimer(14.2, 384223, nil, nil, nil, 1)
local timerOverwhelmingenergyCD					= mod:NewCDTimer(35, 384132, nil, nil, nil, 6)

function mod:OrbTarget(targetname)
	if not targetname then return end
	if targetname == UnitName("player") then
		yellAncientOrb:Yell()
	end
end

function mod:OnCombatStart(delay)
	timerSummonDraconicImageCD:Start(3.5-delay)
	timerArcaneCleaveCD:Start(5-delay)
	timerAncientOrbCD:Start(10.1-delay)
	timerOverwhelmingenergyCD:Start(38.7-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 372222 then
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnArcaneCleave:Show()
			specWarnArcaneCleave:Play("shockwave")
		end
		timerArcaneCleaveCD:Start()
	elseif spellId == 385578 then
		self:ScheduleMethod(0.2, "BossTargetScanner", args.sourceGUID, "OrbTarget", 0.1, 8, true)
		specWarnAncientOrb:Show()
		specWarnAncientOrb:Play("watchorb")
		timerAncientOrbCD:Start()
	elseif spellId == 384223 then
		warnSummonDraconicImage:Show()
		timerSummonDraconicImageCD:Start()
	elseif spellId == 373932 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnIllusionaryBolt:Show(args.sourceName)
		specWarnIllusionaryBolt:Play("kickcast")
	elseif spellId == 384132 then--Overwhelming Energy
		timerArcaneCleaveCD:Stop()
		timerAncientOrbCD:Stop()
		timerSummonDraconicImageCD:Stop()
		specWarnOverwhelmingEnergy:Show()
		specWarnOverwhelmingEnergy:Play("phasechange")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 384132 then--Overwhelming Energy
		timerSummonDraconicImageCD:Start(4.7)--4.7-5.7
		timerArcaneCleaveCD:Start(7.1)--7.1-8.1
		timerAncientOrbCD:Start(12)--12-13
		timerOverwhelmingenergyCD:Start(70)
	end
end
