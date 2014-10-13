local addonName, a = ...
local L = a.Localize
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.Options = {
	Mastersimple = {
		Widget = "RightCheckButton2",
		Label = L["Mastersimple"],
		Default = false,
	},
}

c.AddRotationSwitches()
c.AddSoloSwitch()
c.RegisterAddon()
