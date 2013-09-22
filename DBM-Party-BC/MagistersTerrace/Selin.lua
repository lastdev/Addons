local mod = DBM:NewMod(530, "DBM-Party-BC", 16, 249)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 494 $"):sub(12, -3))

mod:SetCreatureID(24723)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_EMOTE"
)

local warnChanneling		= mod:NewSpellAnnounce("ej5081", 4, 44314)

local specWarnChannel		= mod:NewSpecialWarningSwitch("ej5081", false)

function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if msg == L.ChannelCrystal then
        warnChanneling:Show()
        specWarnChannel:Show()
	end
end