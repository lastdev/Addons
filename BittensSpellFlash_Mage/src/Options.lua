local addonName, a = ...
local L = a.Localize
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

c.AddRotationSwitches()
c.AddSoloSwitch()
c.RegisterAddon()
