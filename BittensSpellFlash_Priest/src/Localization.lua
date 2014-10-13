-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/bittens-spellflash-priest/localization/

local addonName, a = ...
a.Localize = setmetatable({ }, { __index = function(_, key) return key end })
local L = a.Localize
local locale = GetLocale()
if locale == "ptBR" then -- Brazilian Portuguese
L["Flash Discipline"] = "Flash Disciplina" -- Needs review
L["Flash Holy"] = "Flash Sagrado" -- Needs review
L["Flash Shadow"] = "Flash Sombra" -- Needs review
-- L["PW: Shield & Binding Heal on Mouseover"] = ""

elseif locale == "frFR" then -- French
-- L["Flash Discipline"] = ""
-- L["Flash Holy"] = ""
-- L["Flash Shadow"] = ""
-- L["PW: Shield & Binding Heal on Mouseover"] = ""

elseif locale == "deDE" then -- German
L["Flash Discipline"] = "Aufblitzen bei Disziplin"
L["Flash Holy"] = "Aufblitzen bei Heilig"
L["Flash Shadow"] = "Aufblitzen bei Schatten"
L["PW: Shield & Binding Heal on Mouseover"] = "Mw: Schild & Verbindende Heilung bei Mouseover" -- Needs review

elseif locale == "itIT" then -- Italian
-- L["Flash Discipline"] = ""
-- L["Flash Holy"] = ""
-- L["Flash Shadow"] = ""
-- L["PW: Shield & Binding Heal on Mouseover"] = ""

elseif locale == "koKR" then -- Korean
-- L["Flash Discipline"] = ""
-- L["Flash Holy"] = ""
-- L["Flash Shadow"] = ""
-- L["PW: Shield & Binding Heal on Mouseover"] = ""

elseif locale == "esMX" then -- Latin American Spanish
-- L["Flash Discipline"] = ""
-- L["Flash Holy"] = ""
-- L["Flash Shadow"] = ""
-- L["PW: Shield & Binding Heal on Mouseover"] = ""

elseif locale == "ruRU" then -- Russian
-- L["Flash Discipline"] = ""
-- L["Flash Holy"] = ""
-- L["Flash Shadow"] = ""
-- L["PW: Shield & Binding Heal on Mouseover"] = ""

elseif locale == "zhCN" then -- Simplified Chinese
L["Flash Discipline"] = "戒律闪光" -- Needs review
L["Flash Holy"] = "神圣闪光" -- Needs review
L["Flash Shadow"] = "暗影闪光" -- Needs review
L["PW: Shield & Binding Heal on Mouseover"] = "真言术:盾&绑定治疗于鼠标指向" -- Needs review

elseif locale == "esES" then -- Spanish
-- L["Flash Discipline"] = ""
-- L["Flash Holy"] = ""
-- L["Flash Shadow"] = ""
-- L["PW: Shield & Binding Heal on Mouseover"] = ""

elseif locale == "zhTW" then -- Traditional Chinese
L["Flash Discipline"] = "戒律閃光" -- Needs review
L["Flash Holy"] = "神聖閃光" -- Needs review
L["Flash Shadow"] = "暗影閃光" -- Needs review
L["PW: Shield & Binding Heal on Mouseover"] = "真言術:盾&綁定治療到滑鼠遊標" -- Needs review

end