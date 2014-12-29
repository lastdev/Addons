if not DataStore then return end

local addonName = "DataStore_Crafts"
local addon = _G[addonName]
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

function addon:SetupOptions()
	local f = DataStore.Frames.CraftsOptions
	
	DataStore:AddOptionCategory(f, addonName, "DataStore")

	-- localize options
	f.BroadcastProfs.Text:SetText(L["Broadcast my profession links to guild at logon"])
	DataStore:SetCheckBoxTooltip(f.BroadcastProfs, L["BROADCAST_PROFS_TITLE"], L["BROADCAST_PROFS_ENABLED"], L["BROADCAST_PROFS_DISABLED"])
	
	-- restore saved options to gui
	f.BroadcastProfs:SetChecked(DataStore:GetOption(addonName, "BroadcastProfs"))
end
