if not DataStore then return end

local addonName = "DataStore_Garrisons"
local addon = _G[addonName]
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

function addon:SetupOptions()
	local f = DataStore.Frames.GarrisonsOptions
	
	DataStore:AddOptionCategory(f, addonName, "DataStore")

	-- localize options
	DataStoreGarrisonsOptions_SliderReportLevel.tooltipText = L["REPORT_LEVEL_TOOLTIP"]
	DataStoreGarrisonsOptions_SliderReportLevelLow:SetText("350")
	DataStoreGarrisonsOptions_SliderReportLevelHigh:SetText("475")
	f.ReportUncollected.Text:SetText(L["REPORT_UNCOLLECTED_LABEL"])

	DataStore:SetCheckBoxTooltip(f.ReportUncollected, L["REPORT_UNCOLLECTED_TITLE"], L["REPORT_UNCOLLECTED_ENABLED"], L["REPORT_UNCOLLECTED_DISABLED"])
	
	-- restore saved options to gui
	local value = DataStore:GetOption(addonName, "ReportLevel")
	DataStoreGarrisonsOptions_SliderReportLevel:SetValue(value)
	DataStoreGarrisonsOptions_SliderReportLevelText:SetText(format(L["REPORT_LEVEL_LABEL"], "|cFF00FF00", value))
	f.ReportUncollected:SetChecked(DataStore:GetOption(addonName, "ReportUncollected"))
end
