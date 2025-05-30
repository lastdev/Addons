local mod	= DBM:NewMod(2587, "DBM-Party-WarWithin", 7, 1272)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250320200628")
mod:SetCreatureID(210267)
mod:SetEncounterID(2929)
mod:SetHotfixNoticeRev(20240425000000)
--mod:SetMinSyncRevision(20211203000000)
mod:SetZone(2661)
--mod.respawnTime = 29
mod.sendMainBossGUID = true

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 439365 439202 439031",
	"SPELL_CAST_SUCCESS 440082",
	"SPELL_AURA_APPLIED 440147 442122 439325",
	"SPELL_AURA_REMOVED 440147 442122",
	"SPELL_PERIODIC_DAMAGE 441179 440087",
	"SPELL_PERIODIC_MISSED 441179 440087"
--	"UNIT_DIED"
--	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, Fill Er Up shield tracker infoframe?
--[[
(ability.id = 439365 or ability.id = 439202 or ability.id = 439031) and type = "begincast"
or ability.id = 440082 and type = "cast"
or ability.id = 440147 and (type = "applybuff" or type = "removebuff")
or type = "dungeonencounterstart" or type = "dungeonencounterend"
--]]
local warnFillerUp							= mod:NewTargetNoFilterAnnounce(440147, 4)
local warnFillerUpFaded						= mod:NewFadesAnnounce(440147, 1)
local warnBurningFermentation				= mod:NewCountAnnounce(439202, 2)

local specWarnSpoutingStout					= mod:NewSpecialWarningCount(439365, nil, nil, nil, 1, 2)
--local yellSomeAbility						= mod:NewYell(372107)
local specWarnBurningFermentation			= mod:NewSpecialWarningYou(439202, false, nil, nil, 1, 17)
local specWarnBottomsUppercut				= mod:NewSpecialWarningDefensive(439031, nil, nil, nil, 1, 2)
local specWarnGTFO							= mod:NewSpecialWarningGTFO(441179, nil, nil, nil, 1, 8)

local timerSpoutingStoutCD					= mod:NewNextCountTimer(47.3, 439365, nil, nil, nil, 1)
local timerRelocationForm					= mod:NewCastTimer(20, 448718, nil, nil, nil, 1)
local timerBurningFermentationCD			= mod:NewNextCountTimer(47.3, 439202, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON..DBM_COMMON_L.MAGIC_ICON)
local timerBottomsUppercutCD				= mod:NewNextCountTimer(47.3, 439031, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddNamePlateOption("NPOnFrothy", 442122)

mod.vb.stoutCount = 0
mod.vb.fermCount = 0
mod.vb.uppercutCount = 0

function mod:OnCombatStart(delay)
	self.vb.stoutCount = 0
	self.vb.fermCount = 0
	self.vb.uppercutCount = 0
	timerSpoutingStoutCD:Start(10, 1)
	timerBottomsUppercutCD:Start(26.3, 1)
	timerBurningFermentationCD:Start(35.1, 1)
	if self.Options.NPOnFrothy then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.NPOnFrothy then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 439365 then
		self.vb.stoutCount = self.vb.stoutCount + 1
		specWarnSpoutingStout:Show(self.vb.stoutCount)
		specWarnSpoutingStout:Play("watchstep")
		specWarnSpoutingStout:ScheduleVoice(2, "killmob")
		timerSpoutingStoutCD:Start(nil, self.vb.stoutCount+1)
	elseif spellId == 439202 then
		self.vb.fermCount = self.vb.fermCount + 1
		warnBurningFermentation:Show(self.vb.fermCount)
		timerBurningFermentationCD:Start(nil, self.vb.fermCount+1)
	elseif spellId == 439031 then
		self.vb.uppercutCount = self.vb.uppercutCount + 1
		timerBottomsUppercutCD:Start(nil, self.vb.uppercutCount+1)
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnBottomsUppercut:Show()
			specWarnBottomsUppercut:Play("carefly")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 440082 then--If Unreliable, switch to UNIT_DIED+2
		timerRelocationForm:Start(20, args.sourceGUID)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 440147 then
		warnFillerUp:Show(args.destName)
	elseif spellId == 442122 then
		if self.Options.NPOnFrothy then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 439325 and args:IsPlayer() then
		specWarnBurningFermentation:Show()
		specWarnBurningFermentation:Play("debuffyou")
	end
end
--mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 440147 then
		warnFillerUpFaded:Show()
	elseif spellId == 442122 then
		if self.Options.NPOnFrothy then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 441179 or spellId == 440087) and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--[[
function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 223562 or cid == 210270 or cid == 219301 then--Brew Drop (219301 confirmed on normal)

	end
end
--]]

--[[
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 74859 then

	end
end
--]]
