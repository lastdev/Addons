local AddonName, a = ...
if a.BuildFail(50000) then return end
local L = a.Localize
local s = SpellFlashAddon
local c = BittensSpellFlashLibrary

local config = {}
config.CheckButtonOptions = {
	LeftCheckButton1 = {
		DefaultChecked = true,
		ConfigKey = "bm_off",
		Label = L["Flash Beast Mastery"],
	},
--	LeftCheckButton2 = {
--        DefaultChecked = true,
--        ConfigKey = "marks_off",
--        Label = L["Flash Marksmanship"],
--    },
	LeftCheckButton3 = {
		DefaultChecked = true,
		ConfigKey = "survival_off",
		Label = L["Flash Survival"],
	},
--    RightCheckButton2 = {
--        DefaultChecked = false,
--        ConfigKey = "no_careful_aim",
--        Label = L["Ignore Careful Aim (for target dummy testing)"],
--    },
}

a.LoadConfigs(config)
