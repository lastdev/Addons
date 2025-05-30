local isClassic = WOW_PROJECT_ID == (WOW_PROJECT_CLASSIC or 2)
local isBCC = WOW_PROJECT_ID == (WOW_PROJECT_BURNING_CRUSADE_CLASSIC or 5)
local catID
if isBCC or isClassic then
	catID = 3
else--retail or wrath classic and later
	catID = 2
end
local mod	= DBM:NewMod("Buru", "DBM-Raids-Vanilla", catID)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241207000042")
mod:SetCreatureID(15370)
mod:SetEncounterID(721)
mod:SetModelID(15654)
mod:SetZone(509)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"CHAT_MSG_MONSTER_EMOTE"
)

--TODO, see if CLASSIC data set has a spellID for pursuit before it can use generic alerts and voice pack suppot
local WarnDismember				= mod:NewStackAnnounce(96, 3, nil, "Tank", 2)
local warnPursue				= mod:NewAnnounce("WarnPursue", 3, 62374)

local specWarnDismember			= mod:NewSpecialWarningStack(96, nil, 5, nil, nil, 1, 6)
local specWarnDismemberTaunt	= mod:NewSpecialWarningTaunt(96, nil, nil, nil, 1, 2)
local specWarnPursue			= mod:NewSpecialWarning("SpecWarnPursue", nil, nil, nil, 4, 2)

local timerDismember			= mod:NewTargetTimer(10, 96, nil, "Tank", 2, 5, nil, DBM_COMMON_L.TANK_ICON)

function mod:OnCombatStart(delay)
	if not self:IsTrivial() then
		self:RegisterShortTermEvents(
			"SPELL_AURA_APPLIED 96",
			"SPELL_AURA_APPLIED_DOSE 96",
			"SPELL_AURA_REMOVED 96"
		)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpell(96) then
		local amount = args.amount or 1
		timerDismember:Start(args.destName)
		if amount >= 5 then
			if args:IsPlayer() then
				specWarnDismember:Show(amount)
				specWarnDismember:Play("stackhigh")
			elseif not DBM:UnitDebuff("player", args.spellName) and not UnitIsDeadOrGhost("player") then
				specWarnDismemberTaunt:Show(args.destName)
				specWarnDismemberTaunt:Play("tauntboss")
			else
				WarnDismember:Show(args.destName, amount)
			end
		else
			WarnDismember:Show(args.destName, amount)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpell(96) then
		timerDismember:Stop(args.destName)
	end
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg, _, _, _, target)
	-- "<15.57 22:24:07> [CHAT_MSG_MONSTER_EMOTE] %s sets eyes on Exikør!#Buru the Gorger###Exikør##0#0##0#914#nil#0#false#false#false#false",
	if not msg:find(L.PursueEmote) then return end
	if target then
		target = DBM:GetUnitFullName(target)
		if target == UnitName("player") then
			specWarnPursue:Show()
			specWarnPursue:Play("justrun")
		else
			warnPursue:Show(target)
		end
	end
end
