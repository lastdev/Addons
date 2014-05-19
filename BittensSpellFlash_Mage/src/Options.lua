local addonName, a = ...
local L = a.Localize
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.Options = {
	CombustionMonitor = {
		Widget = "RightCheckButton2",
		Label = L["Show Combustion Monitor"],
		Default = true,
	},
	
	CombustionMin = {
		Type = "editbox",
		Widget = "LeftEditBox1",
		Label = L["Minumum Combustion total damage:"],
		MaxCharacters = 7,
		Numeric = true,
		Default = 1,
	},
}

c.AddRotationSwitches()
c.AddSoloSwitch()
c.RegisterAddon()
a.BCM.UpdateVisibility()
