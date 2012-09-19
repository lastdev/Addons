local AddonName, a = ...
if a.BuildFail(50000) then return end
local L = a.Localize
local s = SpellFlashAddon

local config = {}

config.CheckButtonOptions = {
--    LeftCheckButton1 = {
--        DefaultChecked = true,
--        ConfigKey = "holy_off",
--        Label = L["Flash Holy"],
--    },
--    LeftCheckButton2 = {
--        DefaultChecked = true,
--        ConfigKey = "prot_off",
--        Label = L["Flash Prot"],
--    },
    LeftCheckButton1 = {
        DefaultChecked = true,
        ConfigKey = "ret_off",
        Label = L["Flash Ret"],
    },
}

a.LoadConfigs(config)