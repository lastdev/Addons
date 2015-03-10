local _, a = ...
local L = a.Localize
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.Options = {
   Contrast = {
      Widget = "LeftCheckButton6",
      Label = L["High Contrast Flash Color"],
      Default = false,
   },
}

c.AddRotationSwitches()
c.AddSoloSwitch()
c.RegisterAddon()
