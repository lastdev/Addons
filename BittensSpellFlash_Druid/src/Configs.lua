local AddonName, a = ...
if a.BuildFail(50000) then return end
local L = a.Localize

a.LoadConfigs({
	CheckButtonOptions = {
		LeftCheckButton1 = {
			DefaultChecked = true,
			ConfigKey = "balance_off",
			Label = L["Flash Balance"],
		},
		LeftCheckButton2 = {
			DefaultChecked = true,
			ConfigKey = "cat_off",
			Label = L["Flash Feral"],
		},
--		LeftCheckButton3 = {
--			DefaultChecked = true,
--			ConfigKey = "bear_off",
--			Label = L["Flash Guardian"],
--		},
--		LeftCheckButton4 = {
--			DefaultChecked = true,
--			ConfigKey = "resto_off",
--			Label = L["Flash Resto"],
--		},
	}
})
