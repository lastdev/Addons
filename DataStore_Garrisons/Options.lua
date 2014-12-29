if not DataStore then return end

local addonName = "DataStore_Garrisons"
local addon = _G[addonName]
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

function addon:SetupOptions()
	local f = DataStore.Frames.GarrisonsOptions
	
	DataStore:AddOptionCategory(f, addonName, "DataStore")

	-- localize options
	f.ReportUncollected.Text:SetText(L["REPORT_UNCOLLECTED_LABEL"])

	DataStore:SetCheckBoxTooltip(f.ReportUncollected, L["REPORT_UNCOLLECTED_TITLE"], L["REPORT_UNCOLLECTED_ENABLED"], L["REPORT_UNCOLLECTED_DISABLED"])
	
	-- restore saved options to gui
	f.ReportUncollected:SetChecked(DataStore:GetOption(addonName, "ReportUncollected"))
end
