-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/bittens-spellflash-pally/localization/

local addonName, a = ...
a.Localize = setmetatable({ }, { __index = function(_, key) return key end })
local L = a.Localize
local locale = GetLocale()
if locale == "ptBR" then -- Brazilian Portuguese
-- L["Aberration"] = ""
-- L["Demon"] = ""
-- L["Dragonkin"] = ""
-- L["Elemental"] = ""
-- L["Flash Holy"] = ""
-- L["Flash Prot"] = ""
-- L["Flash Ret"] = ""
-- L["Undead"] = ""
-- L["Wearing Prot 2pT13"] = ""

elseif locale == "frFR" then -- French
-- L["Aberration"] = ""
-- L["Demon"] = ""
-- L["Dragonkin"] = ""
-- L["Elemental"] = ""
-- L["Flash Holy"] = ""
-- L["Flash Prot"] = ""
-- L["Flash Ret"] = ""
-- L["Undead"] = ""
-- L["Wearing Prot 2pT13"] = ""

elseif locale == "deDE" then -- German
-- L["Aberration"] = ""
L["Demon"] = "Dämon" -- Needs review
L["Dragonkin"] = "Drachkin" -- Needs review
L["Elemental"] = "Elementar" -- Needs review
L["Flash Holy"] = "Aufblitzen bei Heilig" -- Needs review
L["Flash Prot"] = "Aufblitzen bei Schutz" -- Needs review
L["Flash Ret"] = "Aufblitzen bei Vergeltung" -- Needs review
L["Undead"] = "Untot" -- Needs review
L["Wearing Prot 2pT13"] = "Trage 2 Schutz T13 Teile" -- Needs review

elseif locale == "itIT" then -- Italian
-- L["Aberration"] = ""
-- L["Demon"] = ""
-- L["Dragonkin"] = ""
-- L["Elemental"] = ""
-- L["Flash Holy"] = ""
-- L["Flash Prot"] = ""
-- L["Flash Ret"] = ""
-- L["Undead"] = ""
-- L["Wearing Prot 2pT13"] = ""

elseif locale == "koKR" then -- Korean
-- L["Aberration"] = ""
-- L["Demon"] = ""
-- L["Dragonkin"] = ""
-- L["Elemental"] = ""
-- L["Flash Holy"] = ""
-- L["Flash Prot"] = ""
-- L["Flash Ret"] = ""
-- L["Undead"] = ""
-- L["Wearing Prot 2pT13"] = ""

elseif locale == "esMX" then -- Latin American Spanish
-- L["Aberration"] = ""
-- L["Demon"] = ""
-- L["Dragonkin"] = ""
-- L["Elemental"] = ""
-- L["Flash Holy"] = ""
-- L["Flash Prot"] = ""
-- L["Flash Ret"] = ""
-- L["Undead"] = ""
-- L["Wearing Prot 2pT13"] = ""

elseif locale == "ruRU" then -- Russian
-- L["Aberration"] = ""
-- L["Demon"] = ""
-- L["Dragonkin"] = ""
-- L["Elemental"] = ""
-- L["Flash Holy"] = ""
-- L["Flash Prot"] = ""
-- L["Flash Ret"] = ""
-- L["Undead"] = ""
-- L["Wearing Prot 2pT13"] = ""

elseif locale == "zhCN" then -- Simplified Chinese
-- L["Aberration"] = ""
L["Demon"] = "恶魔" -- Needs review
L["Dragonkin"] = "龙类" -- Needs review
L["Elemental"] = "元素" -- Needs review
L["Flash Holy"] = "圣光闪光" -- Needs review
L["Flash Prot"] = "防护闪光" -- Needs review
L["Flash Ret"] = "惩戒闪光" -- Needs review
L["Undead"] = "亡灵" -- Needs review
L["Wearing Prot 2pT13"] = "有防护T13两件套效果" -- Needs review

elseif locale == "esES" then -- Spanish
-- L["Aberration"] = ""
-- L["Demon"] = ""
-- L["Dragonkin"] = ""
-- L["Elemental"] = ""
-- L["Flash Holy"] = ""
-- L["Flash Prot"] = ""
-- L["Flash Ret"] = ""
-- L["Undead"] = ""
-- L["Wearing Prot 2pT13"] = ""

elseif locale == "zhTW" then -- Traditional Chinese
-- L["Aberration"] = ""
L["Demon"] = "惡魔" -- Needs review
L["Dragonkin"] = "龍類" -- Needs review
L["Elemental"] = "元素" -- Needs review
L["Flash Holy"] = "聖光閃光" -- Needs review
L["Flash Prot"] = "防護閃光" -- Needs review
L["Flash Ret"] = "懲戒閃光" -- Needs review
L["Undead"] = "不死族" -- Needs review
L["Wearing Prot 2pT13"] = "有T13兩件套效果" -- Needs review

end