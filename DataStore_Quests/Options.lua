if not DataStore then return end

local addonName = "DataStore_Quests"
local addon = _G[addonName]
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

function addon:SetupOptions()
	local f = DataStore.Frames.QuestsOptions

	DataStore:AddOptionCategory(f, addonName, "DataStore")

	-- localize options
	f.TrackTurnIns.Text:SetText(L["Track Quest Turn-ins"])
	f.AutoUpdateHistory.Text:SetText(L["Auto-update History"])
	
	DataStore:SetCheckBoxTooltip(f.TrackTurnIns, L["TRACK_TURNINS_TITLE"], L["TRACK_TURNINS_ENABLED"], L["TRACK_TURNINS_DISABLED"])
	DataStore:SetCheckBoxTooltip(f.AutoUpdateHistory, L["AUTO_UPDATE_TITLE"], L["AUTO_UPDATE_ENABLED"], L["AUTO_UPDATE_DISABLED"])
	
	-- restore saved options to gui
	f.TrackTurnIns:SetChecked(DataStore:GetOption(addonName, "TrackTurnIns"))
	f.AutoUpdateHistory:SetChecked(DataStore:GetOption(addonName, "AutoUpdateHistory"))
end
