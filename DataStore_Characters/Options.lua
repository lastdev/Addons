if not DataStore then return end

local addonName = "DataStore_Characters"
local addon = _G[addonName]
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

function addon:SetupOptions()
	local f = DataStore.Frames.CharactersOptions
	
	DataStore:AddOptionCategory(f, addonName, "DataStore")

	-- localize options
	f.RequestPlayTime.Text:SetText(L["REQUEST_PLAYTIME_TEXT"])
	f.HideRealPlayTime.Text:SetText(L["HIDE_PLAYTIME_TEXT"])
	
	DataStore:SetCheckBoxTooltip(f.RequestPlayTime, L["REQUEST_PLAYTIME_TITLE"], L["REQUEST_PLAYTIME_ENABLED"], L["REQUEST_PLAYTIME_DISABLED"])
	DataStore:SetCheckBoxTooltip(f.HideRealPlayTime, L["HIDE_PLAYTIME_TITLE"], L["HIDE_PLAYTIME_ENABLED"], L["HIDE_PLAYTIME_DISABLED"])
	
	-- restore saved options to gui
	f.RequestPlayTime:SetChecked(DataStore:GetOption(addonName, "RequestPlayTime"))
	f.HideRealPlayTime:SetChecked(DataStore:GetOption(addonName, "HideRealPlayTime"))
end
