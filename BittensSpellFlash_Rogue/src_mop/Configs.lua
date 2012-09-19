local AddonName, a = ...
if a.BuildFail(50000) then return end
local L = a.Localize
local s = SpellFlashAddon

local config = {}
config.CheckButtonOptions = {
--	LeftCheckButton1 = {
--		DefaultChecked = true,
--		ConfigKey = "assassination_off",
--		Label = L["Flash Assassination"],
--	},
--	LeftCheckButton2 = {
--		DefaultChecked = true,
--		ConfigKey = "combat_off",
--		Label = L["Flash Combat"],
--	},
	LeftCheckButton1 = {
		DefaultChecked = true,
		ConfigKey = "sub_off",
		Label = L["Flash Subtlety"],
	},
	LeftCheckButton3 = {
		DefaultChecked = true,
		ConfigKey = "solo_off",
		Label = L["Solo Mode when not Grouped"],
	},
}

a.LoadConfigs(config)
