local mod	= DBM:NewMod(2389, "DBM-Party-Shadowlands", 6, 1187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250101235718")
mod:SetCreatureID(162309)
mod:SetEncounterID(2364)
mod:SetZone(2293)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 1216474 1215787 474087 473513",
	"SPELL_CAST_SUCCESS 319521 319626 319589 473959 473540",
	"SPELL_AURA_APPLIED 319521 319416 319626 333567",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--TODO, Spectral Reach (319669) needed?
--TODO, update timers/events for rework
--TODO, can tank sidestep the dash?
--[[
(ability.id = 319521 or ability.id = 319626 or ability.id = 319589) and type = "cast"
--]]
local warnDrawSoul					= mod:NewTargetAnnounce(319521, 2)
local warnPhantasmalParasite		= mod:NewTargetNoFilterAnnounce(319626, 3, nil, "Healer|RemoveMagic")
local warnPossession				= mod:NewTargetNoFilterAnnounce(333567, 4)

local specWarnDrawSoul				= mod:NewSpecialWarningRun(319521, nil, nil, nil, 4, 2)--Want to run away from boss to spawn it further away
--local yellDrawSoul				= mod:NewYell(319521)
local specWarnTornSoul				= mod:NewSpecialWarningYou(319416, nil, nil, nil, 1, 2)--expel Soul debuff
--local yellTornSoul				= mod:NewYell(319416)
local specWarnPhantasmalParasite	= mod:NewSpecialWarningMoveAway(319626, nil, nil, nil, 1, 2)
local specWarnPhantasmalParasiteDPL	= mod:NewSpecialWarningDispel(319626, "RemoveMagic", nil, nil, 1, 2)
local yellPhantasmalParasite		= mod:NewYell(319626)
local specWarnGraspingHands			= mod:NewSpecialWarningDodge(319589, nil, nil, nil, 2, 2)
local specWarnMarchoftheDamned		= mod:NewSpecialWarningDodge(1216474, nil, nil, nil, 2, 2)
local specWarnPoltergeistDash		= mod:NewSpecialWarningDodge(474087, nil, nil, nil, 1, 15)
local specWarnFeastoftheDamned		= mod:NewSpecialWarningCount(473513, nil, nil, nil, 2, 2)
--local specWarnGTFO				= mod:NewSpecialWarningGTFO(257274, nil, nil, nil, 1, 8)

local timerDrawSoulCD				= mod:NewCDCountTimer(20.5, 319521, nil, nil, nil, 3, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerPhantasmalParasiteCD		= mod:NewCDCountTimer(25.5, 319626, nil, nil, nil, 3, nil, DBM_COMMON_L.HEALER_ICON..DBM_COMMON_L.MAGIC_ICON)
local timerGraspingHandsCD			= mod:NewCDTimer(20.6, 319589, nil, nil, nil, 3)
local timerMarchOfTheDamnedCD		= mod:NewAITimer(20.6, 1216474, nil, nil, nil, 3)
local timerPoltergeistDashCD		= mod:NewAITimer(20.6, 474087, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerFeastoftheDamnedCD		= mod:NewAITimer(20.6, 473513, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)

--mod:GroupSpells(319521, 333567)--Draw soul is mechanic, possession is screwing up mechanic

mod.vb.drawCount = 0
mod.vb.parasiteCount = 0
mod.vb.feastCount = 0

function mod:OnCombatStart(delay)
	self.vb.drawCount = 0
	self.vb.parasiteCount = 0
	self.vb.feastCount = 0
	timerPhantasmalParasiteCD:Start(3.3-delay, 1)--SUCCESS
	if DBM:GetTOC() < 110100 then--Removed in 11.1 rework
		timerGraspingHandsCD:Start(8.2-delay)--SUCCESS
	else
		timerMarchOfTheDamnedCD:Start(1-delay)--START
		timerPoltergeistDashCD:Start(1-delay)--START
	end
	timerDrawSoulCD:Start(15.5-delay, 1)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 1216474 or spellId == 1215787 then
		specWarnMarchoftheDamned:Show()
		specWarnMarchoftheDamned:Play("watchstep")
		timerMarchOfTheDamnedCD:Start()
	elseif spellId == 474087 then
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnPoltergeistDash:Show()
			specWarnPoltergeistDash:Play("frontal")
		end
		timerPoltergeistDashCD:Start()
	elseif spellId == 473513 then
		self.vb.feastCount = self.vb.feastCount + 1
		specWarnFeastoftheDamned:Show(self.vb.feastCount)
		specWarnFeastoftheDamned:Play("aesoon")
		timerFeastoftheDamnedCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 319521 or spellId == 473959 then
		self.vb.drawCount = self.vb.drawCount + 1
		timerDrawSoulCD:Start(nil, self.vb.drawCount+1)
	elseif spellId == 319626 or spellId == 473540 then
		self.vb.parasiteCount = self.vb.parasiteCount + 1
		timerPhantasmalParasiteCD:Start(nil, self.vb.parasiteCount+1)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 319521 then
		warnDrawSoul:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnDrawSoul:Show()
			specWarnDrawSoul:Play("justrun")
			--yellDrawSoul:Yell()
		end
	elseif spellId == 319416 then
		if args:IsPlayer() then
			specWarnTornSoul:Show()
			specWarnTornSoul:Play("targetyou")
			--yellTornSoul:Yell()
		end
	elseif spellId == 319626 then
		local dispelWarned = false
		if self.Options.SpecWarn319626dispel and args:IsDestTypePlayer() and self:CheckDispelFilter("magic") then
			specWarnPhantasmalParasiteDPL:Show(args.destName)
			specWarnPhantasmalParasiteDPL:Play("helpdispel")
			dispelWarned = true
		end
		if args:IsPlayer() then
			if not dispelWarned then--If player is a dispeller, they may have already gotten alert to dispel themselves
				specWarnPhantasmalParasite:Show()
				specWarnPhantasmalParasite:Play("runout")
			end
			yellPhantasmalParasite:Yell()
		else
			warnPhantasmalParasite:CombinedShow(0.3, args.destName)
		end
	elseif spellId == 333567 then
		warnPossession:Show(args.destName)
	end
end

--[[
function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 309991 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
--]]

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 319589 then
		specWarnGraspingHands:Show()
		specWarnGraspingHands:Play("watchstep")
		timerGraspingHandsCD:Start()
	end
end
