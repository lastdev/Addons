if not DBM:IsSeasonal("SeasonOfDiscovery") then return end
local mod	= DBM:NewMod("Pyranis", "DBM-Party-Vanilla", 21)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241229223205")
mod:SetEncounterID(3030)
mod:SetCreatureID(227140)
mod:SetZone(2784)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
--	"SPELL_CAST_START",
--	"SPELL_CAST_SUCCESS,
--	"SPELL_AURA_APPLIED"
)

--function mod:OnCombatStart(delay)

--end

-- Summons adds that need to be killed, but didn't fully understand when they are summoned; also, it's really really obvious that this happens.

--[[
function mod:SPELL_CAST_START(args)
	if args:IsSpell(5174) then

	end
end
--]]
