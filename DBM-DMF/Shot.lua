local mod	= DBM:NewMod("Shot", "DBM-DMF")
local L		= mod:GetLocalizedStrings()

<<<<<<< HEAD:DBM-DMF/Shot.lua
mod:SetRevision(("$Revision: 11506 $"):sub(12, -3))
=======
mod:SetRevision(("$Revision: 10922 $"):sub(12, -3))
>>>>>>> 4813c50ec5e1201a0d218a2d8838b8f442e2ca23:DBM-DMF/Shot.lua
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 101871",
	"SPELL_AURA_REMOVED 101871"
)
<<<<<<< HEAD:DBM-DMF/Shot.lua
mod.noStatistics = true
=======
>>>>>>> 4813c50ec5e1201a0d218a2d8838b8f442e2ca23:DBM-DMF/Shot.lua

local timerGame		= mod:NewBuffActiveTimer(60, 101871)

local countdownGame	= mod:NewCountdownFades(60, 101871)

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")
mod:AddBoolOption("SetBubbles", true)--Because the NPC is an annoying and keeps doing chat says while you're shooting which cover up the targets if bubbles are on.

local CVAR = false

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 101871 and args:IsPlayer() then
		timerGame:Start()
		countdownGame:Start(60)
		if self.Options.SetBubbles and GetCVarBool("chatBubbles") then
			CVAR = true
			SetCVar("chatBubbles", 0)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 101871 and args:IsPlayer() then
		timerGame:Cancel()
		countdownGame:Cancel()
		if self.Options.SetBubbles and not GetCVarBool("chatBubbles") and CVAR then--Only turn them back on if they are off now, but were on when we minigame
			SetCVar("chatBubbles", 1)
			CVAR = false
		end
	end
end
