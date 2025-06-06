local isClassic = WOW_PROJECT_ID == (WOW_PROJECT_CLASSIC or 2)
local isBCC = WOW_PROJECT_ID == (WOW_PROJECT_BURNING_CRUSADE_CLASSIC or 5)
local catID
if isBCC or isClassic then
	catID = 2
else--retail or wrath classic and later
	catID = 1
end
local mod	= DBM:NewMod("TwinEmpsAQ", "DBM-Raids-Vanilla", catID)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241214191036")
mod:SetCreatureID(15276, 15275)
mod:SetEncounterID(715)
if not mod:IsClassic() then
	mod:SetModelID(15778)--Renders too close in classic
end
mod:SetZone(531)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 799 800 26613 26607 804",
	"SPELL_AURA_REMOVED 804",
	"SPELL_CAST_SUCCESS 802 804 1217333"--26613
)

--Add warning for classic to actually swap for strike? boss taunt immune though.
local warnStrike			= mod:NewTargetAnnounce(26613, 3, nil, "Tank|Healer")
local warnTeleport			= mod:NewSpellAnnounce(800, 3)
local warnMutateBug			= mod:NewSpellAnnounce(802, 2, nil, false)

local specWarnStrike		= mod:NewSpecialWarningDefensive(26613, nil, nil, nil, 1, 2)
local specWarnExplodeBug	= mod:NewSpecialWarningMove(804, nil, nil, nil, 1, 2)
local specWarnGTFO			= mod:NewSpecialWarningGTFO(26607, nil, nil, nil, 8, 2)

local timerTeleport			= DBM:IsSeasonal("SeasonOfDiscovery")
	and mod:NewCDTimer(29.2, 800, nil, nil, nil, 6, nil, nil, true, 1, 4)
	or mod:NewVarTimer("v29.2-40.2", 800, nil, nil, nil, 6, nil, nil, true, 1, 4)--29.2-40.2
local timerExplodeBugCD		= mod:NewVarTimer("v4.9-9", 804, nil, false, nil, 1)--4.9-9
local timerMutateBugCD		= mod:NewVarTimer("v11-16", 802, nil, false, nil, 1)--11-16
--local timerStrikeCD			= mod:NewCDTimer(9.7, 26613, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--9.7-42.6

local berserkTimer			= mod:NewBerserkTimer(900)

mod:AddNamePlateOption("NPAuraOnMutateBug", 802)

function mod:OnCombatStart(delay)
	--timerStrikeCD:Start(14.2-delay)
	berserkTimer:Start()
	if DBM:IsSeasonal("SeasonOfDiscovery") then
		timerTeleport:Start(31 - delay)
	else
		timerTeleport:Start() --fixme: -delay for variable timers?
	end
	if self.Options.NPAuraOnMutateBug then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	if self.Options.NPAuraOnMutateBug then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

--Teleport-pull:30.6, 35.2, 37.8, 40.1, 36.5, 36.6, 37.7, 31.9, 31.7, 38.8, 32.9, 30.4, 40.2, 30.6, 37.6, 35.4, 32.9, 34.2, 35.3, 36.5, 30.4, 29.2, 34.3, 32.8, 40.0, 35.4, 36.5, 35.3
function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpell(799, 800) and not DBM:IsSeasonal("SeasonOfDiscovery") and self:AntiSpam(5, 1) then
		warnTeleport:Show()
		timerTeleport:Start()
	elseif args:IsSpell(26613) and not self:IsTrivial() then
		if args:IsPlayer() then
			specWarnStrike:Show()
			specWarnStrike:Play("defensive")
		else
			warnStrike:Show(args.destName)
		end
	elseif args:IsSpell(26607) and args:IsPlayer() and args:IsSrcTypeHostile() and not self:IsTrivial() then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
	elseif args:IsSpell(804) then
		if self.Options.NPAuraOnMutateBug then
			DBM.Nameplate:Show(true, args.destGUID, 804, 135826, 4)
		end
		if not self:IsTrivial() then
			for i = 1, 40 do
				local GUID = UnitGUID("nameplate"..i)
				if GUID and GUID == args.destGUID then--Bug is in nameplate range
					specWarnExplodeBug:Show()
					specWarnExplodeBug:Play("runaway")
					break
				end
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpell(804) then
		if self.Options.NPAuraOnMutateBug then
			DBM.Nameplate:Hide(true, args.destGUID, 804, 135826)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpell(802) then
		warnMutateBug:Show()
		timerMutateBugCD:Start()
	elseif args:IsSpell(804) then
		timerExplodeBugCD:Start()
--	elseif args:IsSpell(26613) then
		--timerStrikeCD:Start()
	elseif args:IsSpell(1217333) and self:AntiSpam(5, 1) then -- SoD teleport
		-- https://sod.warcraftlogs.com/reports/BGT3zQYnb82wfAkM#fight=48&type=casts&options=1026&hostility=1&source=165&ability=1217333&view=events
		warnTeleport:Show()
		timerTeleport:Start(35.5)
	end
end
