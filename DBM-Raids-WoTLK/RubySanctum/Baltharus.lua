local mod	= DBM:NewMod("Baltharus", "DBM-Raids-WoTLK", 1)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,normal25,heroic,heroic25"

mod:SetRevision("20241103133102")
mod:SetCreatureID(39751)
mod:SetEncounterID(not mod:IsPostCata() and 890 or 1147)
mod:SetModelID(31761)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetZone(724)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 74509",
	"SPELL_AURA_APPLIED 75125 74505",
	"UNIT_HEALTH boss1"
)

--Melee don't need to know abot WW?
local warningSplitSoon		= mod:NewAnnounce("WarningSplitSoon", 2)
local warnWhirlwind			= mod:NewSpellAnnounce(75125, 3, nil, "Tank|Healer")
local warningWarnBrand		= mod:NewTargetAnnounce(74505, 4)

local specWarnBrand			= mod:NewSpecialWarningYou(74505, nil, nil, nil, 3, 2)
local specWarnRepellingWave	= mod:NewSpecialWarningSpell(74509, nil, nil, nil, 2, 2)

local timerWhirlwind		= mod:NewBuffActiveTimer(4, 75125, nil, "Tank|Healer", nil, 3)
local timerRepellingWave	= mod:NewCastTimer(4, 74509, nil, nil, nil, 2)--1 second cast + 3 second stun
local timerBrand			= mod:NewBuffActiveTimer(10, 74505, nil, nil, nil, 5)

mod:AddSetIconOption("SetIconOnBrand", 74505, false, 0, {1, 2, 3, 4, 5, 6, 7, 8})
mod:AddRangeFrameOption(12, 74505)

mod.vb.warnedSplit1	= false
mod.vb.warnedSplit2	= false
mod.vb.warnedSplit3	= false
local brandTargets = {}
mod.vb.brandIcon	= 8

local function showBrandWarning(self)
	warningWarnBrand:Show(table.concat(brandTargets, "<, >"))
	table.wipe(brandTargets)
	self.vb.brandIcon = 8
end

function mod:OnCombatStart(delay)
	self.vb.warnedSplit1 = false
	self.vb.warnedSplit2 = false
	self.vb.warnedSplit3 = false
	table.wipe(brandTargets)
	self.vb.brandIcon = 8
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(12)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 74509 then
		specWarnRepellingWave:Show()
		specWarnRepellingWave:Play("carefly")
		timerRepellingWave:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 75125 then
		warnWhirlwind:Show()
		timerWhirlwind:Show()
	elseif args.spellId == 74505 and self:IsInCombat() then--Only do this when boss is actually engaged, otherwise it doesn't really matter and just spams.
		brandTargets[#brandTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnBrand:Show()
			specWarnBrand:Play("targetyou")
			timerBrand:Show()
		end
		if self.vb.brandIcon > 0 then
			if self.Options.SetIconOnBrand then
				self:SetIcon(args.destName, self.vb.brandIcon, 10)
			end
			self.vb.brandIcon = self.vb.brandIcon - 1
		end
		self:Unschedule(showBrandWarning)
		self:Schedule(0.5, showBrandWarning, self)
	end
end

function mod:UNIT_HEALTH(uId)
	if self:IsDifficulty("normal25", "heroic25") then
		if not self.vb.warnedSplit1 and self:GetUnitCreatureId(uId) == 39751 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.70 then
			self.vb.warnedSplit1 = true
			warningSplitSoon:Show()
		elseif not self.vb.warnedSplit3 and self:GetUnitCreatureId(uId) == 39751 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.37 then
			self.vb.warnedSplit3 = true
			warningSplitSoon:Show()
		end
	else
		if not self.vb.warnedSplit2 and self:GetUnitCreatureId(uId) == 39751 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.54 then
			self.vb.warnedSplit2 = true
			warningSplitSoon:Show()
		end
	end
end
