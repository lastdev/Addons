local isClassic = WOW_PROJECT_ID == (WOW_PROJECT_CLASSIC or 2)
local isBCC = WOW_PROJECT_ID == (WOW_PROJECT_BURNING_CRUSADE_CLASSIC or 5)
local catID
if isBCC or isClassic then
	catID = 2
else--retail or wrath classic and later
	catID = 1
end
local mod	= DBM:NewMod("Fankriss", "DBM-Raids-Vanilla", catID)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241219133704")
mod:SetCreatureID(15510)
mod:SetEncounterID(712)
mod:SetModelID(15743)
mod:SetZone(531)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_SUMMON 518 25832 25831"
)

local warnWound			= mod:NewStackAnnounce(25646, 3, nil, "Tank", 2)
local warnWorm			= mod:NewSpellAnnounce(25831, 3, 30732)

local specWarnWound		= mod:NewSpecialWarningStack(25646, nil, 5, nil, nil, 1, 6)
local specWarnWoundTaunt= mod:NewSpecialWarningTaunt(25646, nil, nil, nil, 1, 2)

local timerWound		= mod:NewTargetTimer(20, 25646, nil, "Tank", 2, 5, nil, DBM_COMMON_L.TANK_ICON)

function mod:OnCombatStart(delay)
	if not self:IsTrivial() then
		self:RegisterShortTermEvents(
			"SPELL_AURA_APPLIED 25646",
			"SPELL_AURA_APPLIED_DOSE 25646",
			"SPELL_AURA_REMOVED 25646"
		)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpell(25646) then
		local amount = args.amount or 1
		timerWound:Show(args.destName)
		if amount >= 5 then
			if args:IsPlayer() then
				specWarnWound:Show(amount)
				specWarnWound:Play("stackhigh")
			elseif not DBM:UnitDebuff("player", args.spellName) and not UnitIsDeadOrGhost("player") then
				specWarnWoundTaunt:Show(args.destName)
				specWarnWoundTaunt:Play("tauntboss")
			else
				warnWound:Show(args.destName, amount)
			end
		else
			warnWound:Show(args.destName, amount)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpell(25646) then
		timerWound:Stop(args.destName)
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpell(518, 25832, 25831) and self:AntiSpam(3, "SummonWorm") then
		warnWorm:Show()
	end
end
