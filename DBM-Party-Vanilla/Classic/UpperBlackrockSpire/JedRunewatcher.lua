local mod	= DBM:NewMod("JedRunewatcher", "DBM-Party-Vanilla", DBM:IsCata() and 18 or 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241103114940")
mod:SetCreatureID(10509)
mod:SetZone(229)

mod:RegisterCombat("combat")
