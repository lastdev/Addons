local addonName, a = ...
local L = a.Localize
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.Options = {
   FeralBear = {
      Widget = "RightCheckButton2",
      Label = L["Incorporate Bear Form"],
      Default = false,
   },
}

c.AddRotationSwitches()
c.AddSoloSwitch()
c.RegisterAddon()
