local mod = DBM:NewMod(603, "DBM-Party-WotLK", 16, 276)
local L = mod:GetLocalizedStrings()

<<<<<<< HEAD
mod:SetRevision(("$Revision: 155 $"):sub(12, -3))
=======
mod:SetRevision(("$Revision: 143 $"):sub(12, -3))
>>>>>>> 4813c50ec5e1201a0d218a2d8838b8f442e2ca23
--mod:SetEncounterID(843, 844)

mod:RegisterEvents(
	"SPELL_AURA_REMOVED",
	"CHAT_MSG_MONSTER_YELL"
)

<<<<<<< HEAD
local WarnWave		= mod:NewAnnounce("WarnWave", 2)
=======
local WarnWave	= mod:NewAnnounce("WarnWave", 2)
>>>>>>> 4813c50ec5e1201a0d218a2d8838b8f442e2ca23

local timerEscape	= mod:NewAchievementTimer(360, 4526, "achievementEscape")

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local ragingGoul = EJ_GetSectionInfo(7276)
local witchDoctor = EJ_GetSectionInfo(7278)
local abomination = EJ_GetSectionInfo(7282)

local addWaves = {
	[1] = { "6 "..ragingGoul, "1 "..witchDoctor },
	[2] = { "6 "..ragingGoul, "2 "..witchDoctor, "1 "..abomination },
	[3] = { "6 "..ragingGoul, "2 "..witchDoctor, "2 "..abomination },
	[4] = { "12 "..ragingGoul, "3 "..witchDoctor, "3 "..abomination },
}

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 69708 then			--Lich King has broken out of his iceblock, this starts actual event
		if self:IsDifficulty("heroic5") then
			timerEscape:Start()
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Wave1 or msg:find(L.Wave1) then
		WarnWave:Show(table.concat(addWaves[1], ", "))
	elseif msg == L.Wave2 or msg:find(L.Wave2) then
		WarnWave:Show(table.concat(addWaves[2], ", "))
	elseif msg == L.Wave3 or msg:find(L.Wave3) then
		WarnWave:Show(table.concat(addWaves[3], ", "))
	elseif msg == L.Wave4 or msg:find(L.Wave4) then
		WarnWave:Show(table.concat(addWaves[4], ", "))
	end
end