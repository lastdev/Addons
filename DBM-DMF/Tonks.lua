local mod	= DBM:NewMod("Tonks", "DBM-DMF")
local L		= mod:GetLocalizedStrings()

<<<<<<< HEAD:DBM-DMF/Tonks.lua
mod:SetRevision(("$Revision: 11506 $"):sub(12, -3))
=======
mod:SetRevision(("$Revision: 10922 $"):sub(12, -3))
>>>>>>> 4813c50ec5e1201a0d218a2d8838b8f442e2ca23:DBM-DMF/Tonks.lua
mod:SetZone()

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS 102341",
	"UNIT_SPELLCAST_SUCCEEDED player",
	"UNIT_DIED",
	"UNIT_EXITED_VEHICLE player"
)
<<<<<<< HEAD:DBM-DMF/Tonks.lua
mod.noStatistics = true
=======
>>>>>>> 4813c50ec5e1201a0d218a2d8838b8f442e2ca23:DBM-DMF/Tonks.lua

local warnMarked				= mod:NewSpellAnnounce(102341, 4)

local specWarnMarked			= mod:NewSpecialWarningRun(102341)

local timerGame					= mod:NewBuffActiveTimer(60, 102178)

local countdownGame				= mod:NewCountdownFades(60, 102178)

local soundMarked				= mod:NewSound(102341)

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 102341 and UnitGUID("pet") == args.destGUID and self:AntiSpam() then
		warnMarked:Show()
		specWarnMarked:Show()
		soundMarked:Play()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName)
	if spellName == GetSpellInfo(102178) then
		timerGame:Start()
		countdownGame:Start(60)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 54588 and UnitGUID("pet") == args.destGUID then
		timerGame:Cancel()
		countdownGame:Cancel()
	end
end

function mod:UNIT_EXITED_VEHICLE(uId)
	timerGame:Cancel()
	countdownGame:Cancel()
end
