local isClassic = WOW_PROJECT_ID == (WOW_PROJECT_CLASSIC or 2)
local isBCC = WOW_PROJECT_ID == (WOW_PROJECT_BURNING_CRUSADE_CLASSIC or 5)
local catID
if isBCC or isClassic then
	catID = 2
else--retail or wrath classic and later
	catID = 1
end
local mod	= DBM:NewMod("Huhuran", "DBM-Raids-Vanilla", catID)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250119115238")
mod:SetCreatureID(15509)
mod:SetEncounterID(714)
mod:SetModelID(15739)
mod:SetZone(531)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 26180 26053 26051 26068 26050 1215757 1215752 1215753 1215755 1215885",
	"SPELL_AURA_APPLIED_DOSE 26050 1215757",
	"SPELL_AURA_REMOVED 26180 26053 26050 1215757 1215752 1215753 26051 1215755",
	"SPELL_CAST_SUCCESS 26053 1215752 1215755",
	"UNIT_HEALTH"
)

local warnSting			= mod:NewTargetAnnounce(26180, 2)
local warnAcid			= mod:NewStackAnnounce(26050, 3, nil, "Tank", 2)
local warnPoison		= mod:NewSpellAnnounce(26053, 3)
local warnEnrage		= mod:NewSpellAnnounce(26051, 2, nil, "Tank|Healer", 2)
local warnBerserkSoon	= mod:NewSoonAnnounce(26068, 2)
local warnBerserk		= mod:NewSpellAnnounce(26068, 2)

local specWarnAcid		= mod:NewSpecialWarningStack(26050, nil, 10, nil, nil, 1, 6)
local specWarnAcidTaunt	= mod:NewSpecialWarningTaunt(26050, nil, nil, nil, 1, 2)
local specWarnFrenzy	= mod:NewSpecialWarningDispel(26051, "RemoveEnrage", nil, nil, 1, 6)


local timerSting		= mod:NewBuffFadesTimer(12, 26180, nil, nil, nil, 3, nil, DBM_COMMON_L.POISON_ICON..DBM_COMMON_L.DEADLY_ICON)
local timerStingCD		= mod:NewCDTimer(25, 26180, nil, nil, nil, 3, nil, DBM_COMMON_L.POISON_ICON..DBM_COMMON_L.DEADLY_ICON)
local timerPoisonCD		= mod:NewCDTimer(11, 26053, nil, nil, nil, 3)
local timerPoison		= mod:NewBuffFadesTimer(8, 26053)
local timerEnrageCD		= mod:NewCDTimer(11.8, 26051, nil, false, 3, 5, nil, DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.HEALER_ICON)--Off by default do to ridiculous variation
local timerEnrage		= mod:NewBuffActiveTimer(8, 26051, nil, false, 3, 5, nil, DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.HEALER_ICON)
local timerAcid			= mod:NewTargetTimer(30, 26050, nil, "Tank", 2, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddRangeFrameOption("18", nil, "-Melee")

mod.vb.prewarn_berserk = false
local StingTargets = {}

function mod:OnCombatStart(delay)
	self.vb.prewarn_berserk = false
	table.wipe(StingTargets)
	timerEnrageCD:Start(8.1-delay)
	timerPoisonCD:Start(11-delay)
	timerStingCD:Start(20-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(18)
	end
end

function mod:OnCombatEnd(wipe)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

local function warnStingTargets()
	warnSting:Show(table.concat(StingTargets, "<, >"))
	timerStingCD:Start()
	table.wipe(StingTargets)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpell(26053, 1215752) then
		warnPoison:Show()
		timerPoisonCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpell(26180, 1215753) then
		StingTargets[#StingTargets + 1] = args.destName
		self:Unschedule(warnStingTargets)
		self:Schedule(1, warnStingTargets)
		if args:IsPlayer() then
			timerSting:Start()
		end
	elseif args:IsSpell(26053, 1215752) and args:IsPlayer() then
		timerPoison:Start()
	elseif args:IsSpell(26051, 1215755) then
		timerEnrage:Start()
		timerEnrageCD:Start()
		if self.Options.SpecWarn26051dispel then
			specWarnFrenzy:Show(args.destName)
			specWarnFrenzy:Play("trannow")
		else
			warnEnrage:Show()
		end
	elseif args:IsSpell(26068, 1215885) then
		warnBerserk:Show()
		timerStingCD:Stop()
		timerEnrageCD:Stop()
		timerPoisonCD:Stop()
	elseif args:IsSpell(26050, 1215757) and not self:IsTrivial() then
		local amount = args.amount or 1
		timerAcid:Start(args.destName)
		if amount >= 10 then
			if args:IsPlayer() then
				specWarnAcid:Show(amount)
				specWarnAcid:Play("stackhigh")
			elseif not DBM:UnitDebuff("player", args.spellName) and not UnitIsDeadOrGhost("player") then
				specWarnAcidTaunt:Show(args.destName)
				specWarnAcidTaunt:Play("tauntboss")
			else
				warnAcid:Show(args.destName, amount)
			end
		else
			warnAcid:Show(args.destName, amount)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpell(26180, 1215753) and args:IsPlayer() then
		timerSting:Stop()
	elseif args:IsSpell(26053, 1215752) and args:IsPlayer() then
		timerPoison:Stop()
	elseif args:IsSpell(26050, 1215757) then
		timerAcid:Stop(args.destName)
	elseif args:IsSpell(26051, 1215755) then
		timerEnrage:Stop()
	end
end

function mod:UNIT_HEALTH(uId)
	if UnitHealth(uId) / UnitHealthMax(uId) <= 0.35 and self:GetUnitCreatureId(uId) == 15509 and not self.vb.prewarn_berserk then
		warnBerserkSoon:Show()
		self.vb.prewarn_berserk = true
	end
end
