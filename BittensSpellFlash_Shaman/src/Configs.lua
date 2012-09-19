local AddonName, a = ...
if a.BuildFail(50000) then return end

local L = a.Localize
local s = SpellFlashAddon

local config = {}
config.CheckButtonOptions = {
    LeftCheckButton1 = {
        DefaultChecked = true,
        ConfigKey = "elemental_off",
        Label = L["Flash Elemental"],
    },
    LeftCheckButton2 = {
        DefaultChecked = true,
        ConfigKey = "enhance_off",
        Label = L["Flash Enhancement"],
    },
--    LeftCheckButton3 = {
--        DefaultChecked = true,
--        ConfigKey = "resto_off",
--        Label = L["Flash Restoration"],
--    },
}
a.LoadConfigs(config)
