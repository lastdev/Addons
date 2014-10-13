local addonName, a = ...
local L = a.Localize
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.Options = {
<<<<<<< HEAD
	FeralBear = {
		Widget = "RightCheckButton2",
		Label = L["Incorporate Bear Form"],
=======
	FeralBeta = {
		Widget = "RightCheckButton2",
		Label = L["Beta Feral Rotation"],
>>>>>>> 4813c50ec5e1201a0d218a2d8838b8f442e2ca23
		Default = false,
	},
}

c.AddRotationSwitches()
c.AddSoloSwitch()
c.RegisterAddon()
