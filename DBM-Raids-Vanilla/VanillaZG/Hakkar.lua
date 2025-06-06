local isClassic = WOW_PROJECT_ID == (WOW_PROJECT_CLASSIC or 2)
local isBCC = WOW_PROJECT_ID == (WOW_PROJECT_BURNING_CRUSADE_CLASSIC or 5)
local isWrath = WOW_PROJECT_ID == (WOW_PROJECT_WRATH_CLASSIC or 11)
local catID
if isBCC or isClassic then
	catID = 4
elseif isWrath then--Wrath classic
	catID = 3
else--Cataclysm classic
	catID = 5
end
local mod	= DBM:NewMod("Hakkar", "DBM-Raids-Vanilla", catID)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241214191036")
mod:SetCreatureID(14834)
mod:SetEncounterID(793)
mod:SetHotfixNoticeRev(20200419000000)--2020, 04, 19
mod:SetZone(309)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 24324 24686 24687 24688 24689 24690",
	"SPELL_AURA_APPLIED 24327 24328 24686 24687 24689 24690 468408 468012 468491",
	"SPELL_AURA_REMOVED 24328 24689"
)

--TODO, get a buff check for starting initial hard mode timers
--TODO, an infoframe showing list of players silenced by Jeklik on hard mode instead uf using a spammy timer
--[[
(ability.id = 24324 or ability.id = 24686 or ability.id = 24687 or ability.id = 24688 or ability.id = 24689 or ability.id = 24690) and type = "cast"
--]]
local warnSiphonSoon			= mod:NewSoonAnnounce(24324)
local warnInsanity				= mod:NewTargetNoFilterAnnounce(24327, 4)
local warnBlood					= mod:NewTargetAnnounce(24328, 2)--Not excempt from filter since it could be spammy
local warnAspectOfMarli			= mod:NewTargetNoFilterAnnounce(24686, 2)
local warnAspectOfThekal		= mod:NewSpellAnnounce(24689, 3, nil, "Tank|RemoveEnrage|Healer", 4)
local warnAspectOfArlokk		= mod:NewTargetNoFilterAnnounce(24690, 3)

local specWarnBlood				= mod:NewSpecialWarningMoveAway(24328, nil, nil, nil, 1, 2)
local yellBlood					= mod:NewYell(24328, nil, false, 2)
local specWarnAspectOfThekal	= mod:NewSpecialWarningDispel(24689, "RemoveEnrage", nil, nil, 1, 6)

local timerSiphon				= mod:NewNextTimer(90, 24324, nil, nil, nil, 2)
local timerAspectOfMarli
local timerAspectOfMarliCD
local timerAspectOfJeklik
local timerAspectOfJeklikCD
local timerAspectOfVenoxisCD
local timerAspectOfThekal
local timerAspectOfThekalCD
local timerAspectOfArlokk
local timerAspectOfArlokkCD
local timerNextAspect, timerSilenced
if DBM:IsSeasonal("SeasonOfDiscovery") then
	timerNextAspect				= mod:NewNextSpecialTimer(20, 24687)
	timerSilenced				= mod:NewBuffFadesTimer(10, 468012)
	timerAspectOfThekal			= mod:NewBuffActiveTimer(8, 24689, nil, "Tank|RemoveEnrage|Healer", 3, 5, nil, DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.ENRAGE_ICON)
else
	timerAspectOfMarli			= mod:NewTargetTimer(6, 24686, nil, nil, nil, 5)
	timerAspectOfMarliCD		= mod:NewCDTimer(16, 24686, nil, nil, nil, 2)--16-20
	timerAspectOfJeklik			= mod:NewTargetTimer(5, 24687, nil, false, 2, 5)--Could be spammy so off by default. Users can turn it on who want to see this
	timerAspectOfJeklikCD		= mod:NewCDTimer(23, 24687, nil, nil, nil, 2)--23-24
	timerAspectOfVenoxisCD		= mod:NewCDTimer(16.2, 24688, nil, nil, nil, 2)--16.2-18.3
	timerAspectOfThekal			= mod:NewBuffActiveTimer(8, 24689, nil, "Tank|RemoveEnrage|Healer", 3, 5, nil, DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.ENRAGE_ICON)
	timerAspectOfThekalCD		= mod:NewCDTimer(15.8, 24689, nil, nil, nil, 2)
	timerAspectOfArlokk			= mod:NewTargetTimer(2, 24690, nil, nil, nil, 2)
	timerAspectOfArlokkCD		= mod:NewNextTimer(30, 24690, nil, nil, nil, 2)--Needs more data to verify it's a next timer, rest aren't
end
local timerInsanity				= mod:NewTargetTimer(10, 24327, nil, nil, nil, 5)
local timerInsanityCD			= mod:NewCDTimer(20, 24327, nil, nil, nil, 3)

local enrageTimer				= mod:NewBerserkTimer(585)

-- Aspects in SoD: Cast exactly every 20 seconds, order seems to be random, but he casts them all before repeating one as far as I can tell
-- The second cycle is random again
-- Spawn of Mar'li just randomly show up with no SPELL_SUMMON or anything, there's an emote 20 seconds later but that's too late
-- One other aspect is also somehow missing entirely from the log, so just repeating the timer on a 20 second loop as a fallback

mod:AddRangeFrameOption(10, 24328)

local function IsHardMode(self)
	-- SoD: 1832497 hp
	local hpThreshold = DBM:IsSeasonal("SeasonOfDiscovery") and 1500000 or 1079325
	if IsInRaid() then
		for i = 1, GetNumGroupMembers() do
			local UnitID = "raid"..i.."target"
			local guid = UnitGUID(UnitID)
			if guid then
				local cid = self:GetCIDFromGUID(guid)
				if cid == 14834 then
					if UnitHealthMax(UnitID) >= hpThreshold then
						return true
					end
				end
			end
		end
	elseif IsInGroup() then
		for i = 1, GetNumSubgroupMembers() do
			local UnitID = "party"..i.."target"
			local guid = UnitGUID(UnitID)
			if guid then
				local cid = self:GetCIDFromGUID(guid)
				if cid == 14834 then
					if UnitHealthMax(UnitID) >= hpThreshold then
						return true
					end
				end
			end
		end
	else--Solo Raid?, maybe in classic TBC or classic WRATH. Future proofing the mod
		local guid = UnitGUID("target")
		if guid then
			local cid = self:GetCIDFromGUID(guid)
			if cid == 14834 then
				if UnitHealthMax("target") >= hpThreshold then
					return true
				end
			end
		end
	end
	return false
end

function mod:AspectTimer(delay)
	delay = delay or 0
	if not timerNextAspect then return end
	timerNextAspect:Start(20-delay)
	self:UnscheduleMethod("AspectTimer")
	self:ScheduleMethod(22 - delay, "AspectTimer", 2)
end

function mod:OnCombatStart(delay)
	enrageTimer:Start(585-delay)
	warnSiphonSoon:Schedule(80-delay)
	timerSiphon:Start(90-delay)
	--Hard Mode Timers
	--This just checks for Hakkar's health which is higher on hard mode
	--Can't just start these on all normal mode pulls
	if IsHardMode(self) then
		if timerNextAspect then
			self:AspectTimer()
		else
			timerAspectOfMarliCD:Start(10-delay)
			timerAspectOfThekalCD:Start(10-delay)
			timerAspectOfVenoxisCD:Start(14-delay)
			timerAspectOfJeklikCD:Start(21-delay)
			timerAspectOfArlokkCD:Start(30-delay)
		end
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	self:UnscheduleMethod("AspectTimer")
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpell(24324) then
		warnSiphonSoon:Cancel()
		warnSiphonSoon:Schedule(80)
		timerSiphon:Start()
	elseif args:IsSpell(24686) and timerAspectOfMarliCD then
		timerAspectOfMarliCD:Start()
	elseif args:IsSpell(24687) and timerAspectOfJeklikCD then
		timerAspectOfJeklikCD:Start()
	elseif args:IsSpell(24688) and timerAspectOfVenoxisCD then
		timerAspectOfVenoxisCD:Start()
	elseif args:IsSpell(24689) and timerAspectOfThekalCD then
		timerAspectOfThekalCD:Start()
	elseif args:IsSpell(24690) and timerAspectOfArlokkCD then
		timerAspectOfArlokkCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpell(24327) then
		warnInsanity:Show(args.destName)
		timerInsanity:Start(args.destName)
		timerInsanityCD:Start()
	elseif args:IsSpell(24328) then
		if args:IsPlayer() then
			specWarnBlood:Show()
			specWarnBlood:Play("runout")
			yellBlood:Yell()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		else
			warnBlood:Show(args.destName)
		end
	elseif args:IsSpell(24686) then
		warnAspectOfMarli:Show(args.destName)
		timerAspectOfMarli:Start(args.destName)
	elseif args:IsSpell(24687) then
		timerAspectOfJeklik:Start(args.destName)
	elseif (args:IsSpell(24689) or args:IsSpell(468408)) and args:IsDestTypeHostile() then
		if self.Options.SpecWarn24689dispel then
			specWarnAspectOfThekal:Show(args.destName)
			specWarnAspectOfThekal:Play("enrage")
		else
			warnAspectOfThekal:Show()
		end
		timerAspectOfThekal:Start()
		self:AspectTimer()
	elseif args:IsSpell(24690) then
		warnAspectOfArlokk:Show(args.destName)
		timerAspectOfArlokk:Start(args.destName)
	elseif args:IsSpell(468012) and self:AntiSpam(3, "Silence") then
		timerSilenced:Start()
		self:AspectTimer()
	elseif args:IsSpell(468491) and self:AntiSpam(3, "Aoe") then
		self:AspectTimer()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpell(24328) then
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	elseif args:IsSpell(24689) and args:IsDestTypeHostile() then
		timerAspectOfThekal:Stop()
	end
end
