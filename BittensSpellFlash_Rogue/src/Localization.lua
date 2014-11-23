-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/bittens-spellflash-rogue/localization/

local addonName, a = ...
a.Localize = setmetatable({ }, { __index = function(_, key) return key end })
local L = a.Localize
local locale = GetLocale()
if locale == "ptBR" then -- Brazilian Portuguese
    L["Deadly Poison"] = "Veneno Mortal" -- Needs review
    L["Flash Assassination"] = "Piscar para Assassinato" -- Needs review
    L["Flash Combat"] = "Piscar para Combate" -- Needs review
    L["Instant Poison"] = "Theres no longer such an item. w00t da fuck?" -- Needs review
    L["Solo Mode when not Grouped"] = "Modo Solo (Não esta em grupo)" -- Needs review
    L["Wound Poison"] = "Veneno Ferino" -- Needs review

elseif locale == "frFR" then -- French
    L["Deadly Poison"] = "Poison mortel"
    L["Flash Assassination"] = "Flash Assassinat"
    L["Flash Combat"] = "Flash Combat"
    L["Instant Poison"] = "Poison instantané. N\'est plus considéré comme un item"
    L["Solo Mode when not Grouped"] = "Mode solo quand vous n\'êtes pas groupé"
    L["Wound Poison"] = "Poison douloureux"

elseif locale == "deDE" then -- German
    L["Deadly Poison"] = "Tödliches Gift"
    L["Flash Assassination"] = "Aufblitzen bei Meucheln"
    L["Flash Combat"] = "Aufblitzen bei Kampf"
    L["Instant Poison"] = "Sofort wirkendes Gift"
    L["Solo Mode when not Grouped"] = "Solo Modus wenn nicht in einer Gruppe"
    L["Wound Poison"] = "Wundgift"

elseif locale == "itIT" then -- Italian
-- L["Deadly Poison"] = ""
-- L["Flash Assassination"] = ""
-- L["Flash Combat"] = ""
-- L["Instant Poison"] = ""
    L["Solo Mode when not Grouped"] = "Modalità Solitaria quando non in Gruppo" -- Needs review
-- L["Wound Poison"] = ""

elseif locale == "koKR" then -- Korean
-- L["Deadly Poison"] = ""
-- L["Flash Assassination"] = ""
-- L["Flash Combat"] = ""
-- L["Instant Poison"] = ""
-- L["Solo Mode when not Grouped"] = ""
-- L["Wound Poison"] = ""

elseif locale == "esMX" then -- Latin American Spanish
-- L["Deadly Poison"] = ""
-- L["Flash Assassination"] = ""
-- L["Flash Combat"] = ""
-- L["Instant Poison"] = ""
-- L["Solo Mode when not Grouped"] = ""
-- L["Wound Poison"] = ""

elseif locale == "ruRU" then -- Russian
-- L["Deadly Poison"] = ""
-- L["Flash Assassination"] = ""
-- L["Flash Combat"] = ""
-- L["Instant Poison"] = ""
-- L["Solo Mode when not Grouped"] = ""
-- L["Wound Poison"] = ""

elseif locale == "zhCN" then -- Simplified Chinese
    L["Deadly Poison"] = "致命膏药" -- Needs review
    L["Flash Assassination"] = "刺杀闪光" -- Needs review
    L["Flash Combat"] = "战斗闪光" -- Needs review
    L["Instant Poison"] = "速效膏药" -- Needs review
    L["Solo Mode when not Grouped"] = "无组队时使用单人模式" -- Needs review
    L["Wound Poison"] = "致伤药膏" -- Needs review

elseif locale == "esES" then -- Spanish
-- L["Deadly Poison"] = ""
-- L["Flash Assassination"] = ""
-- L["Flash Combat"] = ""
-- L["Instant Poison"] = ""
-- L["Solo Mode when not Grouped"] = ""
-- L["Wound Poison"] = ""

elseif locale == "zhTW" then -- Traditional Chinese
    L["Deadly Poison"] = "致命毒藥" -- Needs review
    L["Flash Assassination"] = "啟用刺殺專精" -- Needs review
    L["Flash Combat"] = "啟用戰鬥專精" -- Needs review
    L["Instant Poison"] = "速效毒藥" -- Needs review
    L["Solo Mode when not Grouped"] = "單練模式" -- Needs review
    L["Wound Poison"] = "致傷毒藥" -- Needs review

end