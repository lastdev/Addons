local addonName = ...
local L = DataStore:SetLocale(addonName, "deDE")
if not L then return end

L["Disabled"] = "Deaktiviert"
L["Enabled"] = "Aktiviert"
L["Memory used for %d |4character:characters;:"] = "Verwendeter Arbeitsspeicher für %d |4Charakter:Charaktere;:"

