-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/bittens-spellflash-mage/localization/

local addonName, a = ...
a.Localize = setmetatable({ }, { __index = function(_, key) return key end })
local L = a.Localize
local locale = GetLocale()
if locale == "ptBR" then -- Brazilian Portuguese
-- L["Flash Arcane"] = ""
-- L["Flash Fire"] = ""
-- L["Flash Frost"] = ""
-- L["Minumum Combustion total damage:"] = ""
-- L["Show Combustion Monitor"] = ""
-- L["Solo Mode when not Grouped"] = ""

elseif locale == "frFR" then -- French
-- L["Flash Arcane"] = ""
-- L["Flash Fire"] = ""
-- L["Flash Frost"] = ""
-- L["Minumum Combustion total damage:"] = ""
-- L["Show Combustion Monitor"] = ""
L["Solo Mode when not Grouped"] = "Mode solo si pas groupé" -- Needs review

elseif locale == "deDE" then -- German
L["Flash Arcane"] = "Aufblitzen bei Arkan"
-- L["Flash Fire"] = ""
L["Flash Frost"] = "Aufblitzen bei Frost"
-- L["Minumum Combustion total damage:"] = ""
-- L["Show Combustion Monitor"] = ""
L["Solo Mode when not Grouped"] = "Solo Modus wenn nicht in einer Gruppe" -- Needs review

elseif locale == "itIT" then -- Italian
L["Flash Arcane"] = "Flash Arcano" -- Needs review
L["Flash Fire"] = "Flash Fuoco" -- Needs review
L["Flash Frost"] = "Flash Gelo" -- Needs review
L["Minumum Combustion total damage:"] = "Combustione danno totale Minimo" -- Needs review
L["Show Combustion Monitor"] = "Mosta Monitor Combustione" -- Needs review
L["Solo Mode when not Grouped"] = "Modalità Solitaria quando non in Gruppo" -- Needs review

elseif locale == "koKR" then -- Korean
-- L["Flash Arcane"] = ""
-- L["Flash Fire"] = ""
-- L["Flash Frost"] = ""
-- L["Minumum Combustion total damage:"] = ""
-- L["Show Combustion Monitor"] = ""
-- L["Solo Mode when not Grouped"] = ""

elseif locale == "esMX" then -- Latin American Spanish
-- L["Flash Arcane"] = ""
-- L["Flash Fire"] = ""
-- L["Flash Frost"] = ""
-- L["Minumum Combustion total damage:"] = ""
-- L["Show Combustion Monitor"] = ""
-- L["Solo Mode when not Grouped"] = ""

elseif locale == "ruRU" then -- Russian
-- L["Flash Arcane"] = ""
-- L["Flash Fire"] = ""
-- L["Flash Frost"] = ""
-- L["Minumum Combustion total damage:"] = ""
-- L["Show Combustion Monitor"] = ""
-- L["Solo Mode when not Grouped"] = ""

elseif locale == "zhCN" then -- Simplified Chinese
L["Flash Arcane"] = "奥术闪光"
L["Flash Fire"] = "火焰闪光"
L["Flash Frost"] = "冰霜闪光"
L["Minumum Combustion total damage:"] = "点燃总伤害的最小值:"
L["Show Combustion Monitor"] = "显示点燃监视器"
L["Solo Mode when not Grouped"] = "无队伍时使用单人模式"

elseif locale == "esES" then -- Spanish
-- L["Flash Arcane"] = ""
-- L["Flash Fire"] = ""
-- L["Flash Frost"] = ""
-- L["Minumum Combustion total damage:"] = ""
-- L["Show Combustion Monitor"] = ""
-- L["Solo Mode when not Grouped"] = ""

elseif locale == "zhTW" then -- Traditional Chinese
L["Flash Arcane"] = "秘法閃光"
L["Flash Fire"] = "火焰閃光"
L["Flash Frost"] = "冰霜閃光"
L["Minumum Combustion total damage:"] = "點燃總傷害的最小值:"
L["Show Combustion Monitor"] = "顯示點燃監視器"
L["Solo Mode when not Grouped"] = "無組隊時使用單人模式"

end