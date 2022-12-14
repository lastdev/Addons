local mod	= DBM:NewMod("Akama", "DBM-BlackTemple")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220128001316")
mod:SetCreatureID(22841)
mod:SetEncounterID(603)
mod:SetModelID(21357)

mod:RegisterCombat("combat")
mod:SetWipeTime(50)--Adds come about every 50 seconds, so require at least this long to wipe combat if they die instantly

mod:RegisterEventsInCombat(
	"UNIT_DIED"
)

mod:RegisterEvents(
	"SPELL_AURA_REMOVED 34189"
)

local warnPhase2		= mod:NewPhaseAnnounce(2)
local warnDefender		= mod:NewSpellAnnounce("ej15615", 2, 41180)
local warnSorc			= mod:NewSpellAnnounce("ej15606", 2, 40520)

local specWarnAdds		= mod:NewSpecialWarningAddsCustom(216726, "-Healer", nil, nil, 1, 2)

local timerCombatStart	= mod:NewCombatTimer(12)
local timerAddsCD		= mod:NewAddsCustomTimer(25, 216726)--NewAddsCustomTimer
local timerDefenderCD	= mod:NewNextCountTimer(25, "ej15615", nil, nil, nil, 1, 41180)
local timerSorcCD		= mod:NewNextCountTimer(25, "ej15606", nil, nil, nil, 1, 40520)

mod.vb.phase = 1
mod.vb.AddsWestCount = 0
mod.vb.sorcCount = 0
mod.vb.defenderCount = 0

local function addsWestLoop(self)
	self.vb.AddsWestCount = self.vb.AddsWestCount + 1
	specWarnAdds:Show(DBM_COMMON_L.WEST)
	specWarnAdds:Play("killmob")
	specWarnAdds:ScheduleVoice(1, "west")
	if self.vb.AddsWestCount == 2 then--Special
		self:Schedule(51, addsWestLoop, self)
		timerAddsCD:Start(51, DBM_COMMON_L.WEST)
	else
		self:Schedule(47, addsWestLoop, self)
		timerAddsCD:Start(47, DBM_COMMON_L.WEST)
	end
end

local function addsEastLoop(self)
	specWarnAdds:Show(DBM_COMMON_L.EAST)
	specWarnAdds:Play("killmob")
	specWarnAdds:ScheduleVoice(1, "east")
	self:Schedule(51, addsEastLoop, self)
	timerAddsCD:Start(51, DBM_COMMON_L.EAST)
end

local function sorcLoop(self)
	self.vb.sorcCount = self.vb.sorcCount + 1
	warnSorc:Show(self.vb.sorcCount)
	self:Schedule(25, sorcLoop, self)
	timerSorcCD:Start(25, self.vb.sorcCount+1)
end

local function defenderLoop(self)
	self.vb.defenderCount = self.vb.defenderCount + 1
	warnDefender:Show(self.vb.defenderCount)
	self:Schedule(30, defenderLoop, self)
	timerDefenderCD:Start(30, self.vb.defenderCount+1)
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.AddsWestCount = 0
	self.vb.sorcCount = 0
	self.vb.defenderCount = 0
	self:RegisterShortTermEvents(
		"SWING_DAMAGE",
		"SWING_MISSED",
		"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
	)
	self:Schedule(1, defenderLoop, self)
	self:Schedule(1, sorcLoop, self)
	self:Schedule(1, addsWestLoop, self)
	self:Schedule(18, addsEastLoop, self)
	timerAddsCD:Start(18, DBM_COMMON_L.EAST or "East")
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end


function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 34189 and args:GetDestCreatureID() == 23191 then--Coming out of stealth (he's been activated)
		timerCombatStart:Start()
	end
end

function mod:SWING_DAMAGE(_, sourceName)
	if sourceName == L.name and self.vb.phase == 1 then
		self:UnregisterShortTermEvents()
		self.vb.phase = 2
		warnPhase2:Show()
		timerAddsCD:Stop()
		timerDefenderCD:Stop()
		timerSorcCD:Stop()
		self:Unschedule(addsWestLoop)
		self:Unschedule(addsEastLoop)
		self:Unschedule(sorcLoop)
		self:Unschedule(defenderLoop)
	end
end
mod.SWING_MISSED = mod.SWING_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if (spellId == 40607 or spellId == 40955) and self.vb.phase == 1 then--Fixate/Summon Shade of Akama Trigger
		self:UnregisterShortTermEvents()
		self.vb.phase = 2
		warnPhase2:Show()
		timerAddsCD:Stop()
		timerDefenderCD:Stop()
		timerSorcCD:Stop()
		self:Unschedule(addsWestLoop)
		self:Unschedule(addsEastLoop)
		self:Unschedule(sorcLoop)
		self:Unschedule(defenderLoop)
	end
end

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 22841 then
		DBM:EndCombat(self)
	end
end
