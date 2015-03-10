local addonName, a = ...
local L = a.Localize
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.Options = {
   BTMacro = {
      Widget = "LeftCheckButton6",
      Label = L["Blood Tap is Macroed to everything"],
      Default = false,
   },
}

c.AddRotationSwitches()
c.AddSoloSwitch()
c.RegisterAddon()
