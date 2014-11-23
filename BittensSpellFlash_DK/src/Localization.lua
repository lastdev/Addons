-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/bittens-spellflash-dk/localization/

local addonName, a = ...
a.Localize = setmetatable({ }, { __index = function(_, key) return key end })
local L = a.Localize
local locale = GetLocale()
if locale == "ptBR" then -- Brazilian Portuguese
-- L["Flash Blood"] = ""
-- L["Flash Frost"] = ""
-- L["Flash Unholy"] = ""
-- L["Solo Mode when not Grouped"] = ""

elseif locale == "frFR" then -- French
L["Flash Blood"] = "Flash Sang" -- Needs review
L["Flash Frost"] = "Flash Givre" -- Needs review
L["Flash Unholy"] = "Flash Impie" -- Needs review
L["Solo Mode when not Grouped"] = "Mode solo lorsque vous n'êtes pas groupé" -- Needs review

elseif locale == "deDE" then -- German
L["Flash Blood"] = "Aufblitzen bei Blut" -- Needs review
L["Flash Frost"] = "Aufblitzen bei Frost" -- Needs review
L["Flash Unholy"] = "Aufblitzen bei Unheilig" -- Needs review
L["Solo Mode when not Grouped"] = "Solo Modus wenn nicht in einer Gruppe" -- Needs review

elseif locale == "itIT" then -- Italian
-- L["Flash Blood"] = ""
-- L["Flash Frost"] = ""
-- L["Flash Unholy"] = ""
L["Solo Mode when not Grouped"] = "Modalità Solitaria quando non in Gruppo" -- Needs review

elseif locale == "koKR" then -- Korean
-- L["Flash Blood"] = ""
-- L["Flash Frost"] = ""
-- L["Flash Unholy"] = ""
-- L["Solo Mode when not Grouped"] = ""

elseif locale == "esMX" then -- Latin American Spanish
-- L["Flash Blood"] = ""
-- L["Flash Frost"] = ""
-- L["Flash Unholy"] = ""
-- L["Solo Mode when not Grouped"] = ""

elseif locale == "ruRU" then -- Russian
-- L["Flash Blood"] = ""
-- L["Flash Frost"] = ""
-- L["Flash Unholy"] = ""
-- L["Solo Mode when not Grouped"] = ""

elseif locale == "zhCN" then -- Simplified Chinese
L["Flash Blood"] = "鲜血闪光" -- Needs review
L["Flash Frost"] = "冰霜闪光" -- Needs review
L["Flash Unholy"] = "邪恶闪光" -- Needs review
L["Solo Mode when not Grouped"] = "无队伍时使用单人模式" -- Needs review

elseif locale == "esES" then -- Spanish
-- L["Flash Blood"] = ""
-- L["Flash Frost"] = ""
-- L["Flash Unholy"] = ""
-- L["Solo Mode when not Grouped"] = ""

elseif locale == "zhTW" then -- Traditional Chinese
L["Flash Blood"] = "血魄閃光" -- Needs review
L["Flash Frost"] = "冰霜閃光" -- Needs review
L["Flash Unholy"] = "穢邪閃光" -- Needs review
L["Solo Mode when not Grouped"] = "無組隊時使用單人模式" -- Needs review

end
