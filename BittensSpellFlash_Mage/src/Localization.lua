-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/bittens-spellflash-mage/localization/

local addonName, a = ...
local function DefaultFunction(_, key) return key end
a.Localize = setmetatable({}, {__index = DefaultFunction})
local L = a.Localize

if GetLocale() == "ptBR" then -- Brazilian Portuguese
-- L["Flash Arcane"] = ""
-- L["Flash Fire"] = ""
-- L["Flash Frost"] = ""
-- L["Minumum Combustion total damage:"] = ""
-- L["Show Combustion Monitor"] = ""
-- L["Solo Mode when not Grouped"] = ""

elseif GetLocale() == "frFR" then -- French
-- L["Flash Arcane"] = ""
-- L["Flash Fire"] = ""
-- L["Flash Frost"] = ""
-- L["Minumum Combustion total damage:"] = ""
-- L["Show Combustion Monitor"] = ""
-- L["Solo Mode when not Grouped"] = ""

elseif GetLocale() == "deDE" then -- German
L["Flash Arcane"] = "Aufblitzen bei Arkan"
-- L["Flash Fire"] = ""
L["Flash Frost"] = "Aufblitzen bei Frost"
-- L["Minumum Combustion total damage:"] = ""
-- L["Show Combustion Monitor"] = ""
-- L["Solo Mode when not Grouped"] = ""

elseif GetLocale() == "koKR" then -- Korean
-- L["Flash Arcane"] = ""
-- L["Flash Fire"] = ""
-- L["Flash Frost"] = ""
-- L["Minumum Combustion total damage:"] = ""
-- L["Show Combustion Monitor"] = ""
-- L["Solo Mode when not Grouped"] = ""

elseif GetLocale() == "esMX" then -- Latin American Spanish
-- L["Flash Arcane"] = ""
-- L["Flash Fire"] = ""
-- L["Flash Frost"] = ""
-- L["Minumum Combustion total damage:"] = ""
-- L["Show Combustion Monitor"] = ""
-- L["Solo Mode when not Grouped"] = ""

elseif GetLocale() == "ruRU" then -- Russian
-- L["Flash Arcane"] = ""
-- L["Flash Fire"] = ""
-- L["Flash Frost"] = ""
-- L["Minumum Combustion total damage:"] = ""
-- L["Show Combustion Monitor"] = ""
-- L["Solo Mode when not Grouped"] = ""

elseif GetLocale() == "zhCN" then -- Simplified Chinese
-- L["Flash Arcane"] = ""
-- L["Flash Fire"] = ""
-- L["Flash Frost"] = ""
-- L["Minumum Combustion total damage:"] = ""
-- L["Show Combustion Monitor"] = ""
-- L["Solo Mode when not Grouped"] = ""

elseif GetLocale() == "esES" then -- Spanish
-- L["Flash Arcane"] = ""
-- L["Flash Fire"] = ""
-- L["Flash Frost"] = ""
-- L["Minumum Combustion total damage:"] = ""
-- L["Show Combustion Monitor"] = ""
-- L["Solo Mode when not Grouped"] = ""

elseif GetLocale() == "zhTW" then -- Traditional Chinese
-- L["Flash Arcane"] = ""
-- L["Flash Fire"] = ""
-- L["Flash Frost"] = ""
-- L["Minumum Combustion total damage:"] = ""
-- L["Show Combustion Monitor"] = ""
-- L["Solo Mode when not Grouped"] = ""

end