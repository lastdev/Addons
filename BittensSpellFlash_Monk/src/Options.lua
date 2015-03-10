local addonName, a = ...
local L = a.Localize
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.Options = {
--      TigerSyncBuff = {
--         Type = "editbox",
--         Widget = "LeftEditBox1",
--         Label = L["Synchronize Tigereye Brew with:"],
--         Default = "",
--      },
   MeleeCutoff = {
      Type = "editbox",
      Widget = "LeftEditBox1",
      Label = L["Flash Melee Abilities Above % Mana:"],
      MaxCharacters = 3,
      Numeric = true,
      Default = 50,
   },
}

c.AddRotationSwitches()
c.AddSoloSwitch()
c.RegisterAddon()
