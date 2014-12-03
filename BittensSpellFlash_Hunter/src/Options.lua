local addonName, a = ...
local L = a.Localize
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.Options = {
   NoCarefulAim = {
      Widget = "RightCheckButton2",
   Label = L["Ignore Careful Aim (for target dummy testing)"],
   Default = false,
    },
}

c.AddRotationSwitches()
c.RegisterAddon()
