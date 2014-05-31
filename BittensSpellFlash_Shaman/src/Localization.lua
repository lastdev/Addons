-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/bittens-spellflash-shaman/localization/

local addonName, a = ...
a.Localize = setmetatable({ }, { __index = function(_, key) return key end })
local L = a.Localize
local locale = GetLocale()
if locale == "ptBR" then -- Brazilian Portuguese
L["Earthliving"] = "Terraviva" -- Needs review
L["Flametongue"] = "Labaredas" -- Needs review
L["Flash Elemental"] = "Ativar em Elemental" -- Needs review
L["Flash Enhancement"] = "Ativar em Aperfeiçoamento" -- Needs review
L["Flash Restoration"] = "Ativar em Restauração" -- Needs review
L["Windfury"] = "Fúria dos Ventos" -- Needs review

elseif locale == "frFR" then -- French
L["Earthliving"] = "Viveterre"
L["Flametongue"] = "Langue de feu"
L["Flash Elemental"] = " Flash Élémentaire" -- Needs review
L["Flash Enhancement"] = "Flash Amélioration" -- Needs review
L["Flash Restoration"] = "Flash Restauration" -- Needs review
L["Windfury"] = "Furie-des-vents"

elseif locale == "deDE" then -- German
L["Earthliving"] = "Lebensgeister" -- Needs review
L["Flametongue"] = "Flammenzunge" -- Needs review
L["Flash Elemental"] = "Aufblitzen bei Elementar" -- Needs review
L["Flash Enhancement"] = "Aufblitzen bei Verstärkung"
L["Flash Restoration"] = "Aufblitzen bei Wiederherstellung"
L["Windfury"] = "Windzorn" -- Needs review

elseif locale == "itIT" then -- Italian
-- L["Earthliving"] = ""
-- L["Flametongue"] = ""
-- L["Flash Elemental"] = ""
-- L["Flash Enhancement"] = ""
-- L["Flash Restoration"] = ""
-- L["Windfury"] = ""

elseif locale == "koKR" then -- Korean
-- L["Earthliving"] = ""
-- L["Flametongue"] = ""
-- L["Flash Elemental"] = ""
-- L["Flash Enhancement"] = ""
-- L["Flash Restoration"] = ""
-- L["Windfury"] = ""

elseif locale == "esMX" then -- Latin American Spanish
L["Earthliving"] = "Vida terrestre"
L["Flametongue"] = "Lengua de Fuego"
L["Flash Elemental"] = "Flash Elemental"
L["Flash Enhancement"] = "Flash Mejora"
L["Flash Restoration"] = "Flash Restauración"
L["Windfury"] = "Viento Furioso"

elseif locale == "ruRU" then -- Russian
L["Earthliving"] = "Жизнь Земли" -- Needs review
L["Flametongue"] = "Язык пламени" -- Needs review
L["Flash Elemental"] = "Подсвечивать Стихии" -- Needs review
L["Flash Enhancement"] = "Подсвечивать Совершенствование" -- Needs review
L["Flash Restoration"] = "Подсвечивать Исцеление" -- Needs review
L["Windfury"] = "Неистовство ветра" -- Needs review

elseif locale == "zhCN" then -- Simplified Chinese
L["Earthliving"] = "大地生命" -- Needs review
L["Flametongue"] = "火舌" -- Needs review
L["Flash Elemental"] = "元素闪光" -- Needs review
L["Flash Enhancement"] = "增强闪光" -- Needs review
L["Flash Restoration"] = "恢复闪光" -- Needs review
L["Windfury"] = "风怒" -- Needs review

elseif locale == "esES" then -- Spanish
L["Earthliving"] = "Vida terrestre" -- Needs review
L["Flametongue"] = "Lengua de Fuego" -- Needs review
-- L["Flash Elemental"] = ""
-- L["Flash Enhancement"] = ""
-- L["Flash Restoration"] = ""
L["Windfury"] = "Viento Furioso" -- Needs review

elseif locale == "zhTW" then -- Traditional Chinese
L["Earthliving"] = "大地生命"
L["Flametongue"] = "火舌"
L["Flash Elemental"] = "閃爍元素" -- Needs review
L["Flash Enhancement"] = "閃爍增強" -- Needs review
L["Flash Restoration"] = "閃爍恢復" -- Needs review
L["Windfury"] = "風怒"

end