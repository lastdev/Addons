local AddonName, a = ...
if a.BuildFail(50000) then return end
local L = a.Localize

local config = {}
config.CheckButtonOptions = {
    LeftCheckButton1 = {
        DefaultChecked = true,
        ConfigKey = "arms_off",
        Label = L["Flash Arms"],
    },
    LeftCheckButton2 = {
        DefaultChecked = true,
        ConfigKey = "fury_off",
        Label = L["Flash Fury"],
    },
--    LeftCheckButton3 = {
--        DefaultChecked = true,
--        ConfigKey = "prot_off",
--        Label = L["Flash Protection"],
--    },
}
a.LoadConfigs(config)
