local AddonName, a = ...
if a.BuildFail(50000) then return end

local L = a.Localize
local config = {}
config.CheckButtonOptions = {
	LeftCheckButton1 = {
		DefaultChecked = true,
		ConfigKey = "blood_off",
		Label = L["Flash Blood"],
	},
	LeftCheckButton2 = {
		DefaultChecked = true,
		ConfigKey = "frost_off",
		Label = L["Flash Frost"],
	},
	LeftCheckButton3 = {
		DefaultChecked = true,
		ConfigKey = "unholy_off",
		Label = L["Flash Unholy"],
	},
}
a.LoadConfigs(config)
