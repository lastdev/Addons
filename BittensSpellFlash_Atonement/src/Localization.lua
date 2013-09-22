-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/bittens-spellflash-atonement/localization/

local addonName, a = ...
a.Localize = setmetatable({ }, { __index = function(_, key) return key end })
local L = a.Localize
local locale = GetLocale()
if locale == "ptBR" then -- Brazilian Portuguese
L["Healing only under % mana:"] = "Cura apenas sob % de mana:" -- Needs review
L["Mana-conscious rotation under % mana:"] = "Rotação consciente de mana sob % de mana:" -- Needs review
-- L["Mana-neutral rotation under % mana:"] = ""
L["Prioritize healing under % health:"] = "Priorizar cura sob % de vida:" -- Needs review
-- L["Solo Mode when not Grouped"] = ""

elseif locale == "frFR" then -- French
-- L["Healing only under % mana:"] = ""
-- L["Mana-conscious rotation under % mana:"] = ""
-- L["Mana-neutral rotation under % mana:"] = ""
-- L["Prioritize healing under % health:"] = ""
L["Solo Mode when not Grouped"] = "Mode solo si pas groupé" -- Needs review

elseif locale == "deDE" then -- German
-- L["Healing only under % mana:"] = ""
-- L["Mana-conscious rotation under % mana:"] = ""
-- L["Mana-neutral rotation under % mana:"] = ""
-- L["Prioritize healing under % health:"] = ""
L["Solo Mode when not Grouped"] = "Solo Modus wenn nicht in einer Gruppe" -- Needs review

elseif locale == "itIT" then -- Italian
-- L["Healing only under % mana:"] = ""
-- L["Mana-conscious rotation under % mana:"] = ""
-- L["Mana-neutral rotation under % mana:"] = ""
-- L["Prioritize healing under % health:"] = ""
L["Solo Mode when not Grouped"] = "Modalità Solitaria quando non in Gruppo" -- Needs review

elseif locale == "koKR" then -- Korean
-- L["Healing only under % mana:"] = ""
-- L["Mana-conscious rotation under % mana:"] = ""
-- L["Mana-neutral rotation under % mana:"] = ""
-- L["Prioritize healing under % health:"] = ""
-- L["Solo Mode when not Grouped"] = ""

elseif locale == "esMX" then -- Latin American Spanish
-- L["Healing only under % mana:"] = ""
-- L["Mana-conscious rotation under % mana:"] = ""
-- L["Mana-neutral rotation under % mana:"] = ""
-- L["Prioritize healing under % health:"] = ""
-- L["Solo Mode when not Grouped"] = ""

elseif locale == "ruRU" then -- Russian
-- L["Healing only under % mana:"] = ""
-- L["Mana-conscious rotation under % mana:"] = ""
-- L["Mana-neutral rotation under % mana:"] = ""
-- L["Prioritize healing under % health:"] = ""
-- L["Solo Mode when not Grouped"] = ""

elseif locale == "zhCN" then -- Simplified Chinese
-- L["Healing only under % mana:"] = ""
-- L["Mana-conscious rotation under % mana:"] = ""
-- L["Mana-neutral rotation under % mana:"] = ""
-- L["Prioritize healing under % health:"] = ""
L["Solo Mode when not Grouped"] = "无队伍时使用单人模式" -- Needs review

elseif locale == "esES" then -- Spanish
-- L["Healing only under % mana:"] = ""
-- L["Mana-conscious rotation under % mana:"] = ""
-- L["Mana-neutral rotation under % mana:"] = ""
-- L["Prioritize healing under % health:"] = ""
-- L["Solo Mode when not Grouped"] = ""

elseif locale == "zhTW" then -- Traditional Chinese
-- L["Healing only under % mana:"] = ""
-- L["Mana-conscious rotation under % mana:"] = ""
-- L["Mana-neutral rotation under % mana:"] = ""
-- L["Prioritize healing under % health:"] = ""
L["Solo Mode when not Grouped"] = "無組隊時使用單人模式" -- Needs review

end