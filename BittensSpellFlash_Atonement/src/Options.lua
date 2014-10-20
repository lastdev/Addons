local addonName, a = ...
local L = a.Localize
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.Options = {
	HealPercent = {
		Type = "editbox",
		Widget = "LeftEditBox1",
		Label = L["Prioritize healing under % health:"],
		MaxCharacters = 2,
		Numeric = true,
		Default = 90,
	},
}

c.RegisterAddon()
