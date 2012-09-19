local mod = DBM:NewMod("Selin", "DBM-Party-BC", 16)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 403 $"):sub(12, -3))

mod:SetCreatureID(24723)
mod:SetModelID(22642)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_EMOTE"
)

local warnChanneling		= mod:NewAnnounce("warnChanneling", 4, 44314)

function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if msg == L.ChannelCrystal then
        warnChanneling:Show()
	end
end