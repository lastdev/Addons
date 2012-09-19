local AddonName, a = ...
if a.BuildFail(50000) then return end
local L = a.Localize
local s = SpellFlashAddon

local config = {}

config.CheckButtonOptions = {
	LeftCheckButton1 = {
		DefaultChecked = true,
		ConfigKey = "affliction_off",
		Label = L["Flash Affliction"],
	},
--    LeftCheckButton2 = {
--        DefaultChecked = true,
--        ConfigKey = "demonology_off",
--        Label = L["Flash Demonology"],
--    },
--    LeftCheckButton3 = {
--        DefaultChecked = true,
--        ConfigKey = "destro_off",
--        Label = L["Flash Destruction"],
--    },
}

a.LoadConfigs(config)
