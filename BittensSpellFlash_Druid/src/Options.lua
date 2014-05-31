local addonName, a = ...
local L = a.Localize
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.Options = {
	FeralBeta = {
		Widget = "RightCheckButton2",
		Label = L["Beta Feral Rotation"],
		Default = false,
	},
}

c.AddRotationSwitches()
c.AddSoloSwitch()
c.RegisterAddon()
