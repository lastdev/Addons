-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/bittens-spellflash-monk/localization/

local addonName, a = ...
a.Localize = setmetatable({ }, { __index = function(_, key) return key end })
local L = a.Localize
local locale = GetLocale()
if locale == "ptBR" then -- Brazilian Portuguese
-- L["Flash Brewmaster"] = ""
-- L["Flash Melee Abilities Above % Mana:"] = ""
-- L["Flash Mistweaver"] = ""
-- L["Flash Windwalker"] = ""
-- L["Solo Mode when not Grouped"] = ""

elseif locale == "frFR" then -- French
L["Flash Brewmaster"] = "Clignotements pour Maître brasseur" -- Needs review
L["Flash Melee Abilities Above % Mana:"] = "Clignotement des techniques de mêlée si au dessus de % de mana" -- Needs review
L["Flash Mistweaver"] = "Clignotements pour Tisse-brume" -- Needs review
L["Flash Windwalker"] = "Clignotements pour Marche-vent" -- Needs review
L["Solo Mode when not Grouped"] = "Mode solo si pas groupé" -- Needs review

elseif locale == "deDE" then -- German
-- L["Flash Brewmaster"] = ""
-- L["Flash Melee Abilities Above % Mana:"] = ""
-- L["Flash Mistweaver"] = ""
-- L["Flash Windwalker"] = ""
L["Solo Mode when not Grouped"] = "Solo Modus wenn nicht in einer Gruppe" -- Needs review

elseif locale == "itIT" then -- Italian
-- L["Flash Brewmaster"] = ""
-- L["Flash Melee Abilities Above % Mana:"] = ""
-- L["Flash Mistweaver"] = ""
-- L["Flash Windwalker"] = ""
L["Solo Mode when not Grouped"] = "Modalità Solitaria quando non in Gruppo" -- Needs review

elseif locale == "koKR" then -- Korean
-- L["Flash Brewmaster"] = ""
-- L["Flash Melee Abilities Above % Mana:"] = ""
-- L["Flash Mistweaver"] = ""
-- L["Flash Windwalker"] = ""
-- L["Solo Mode when not Grouped"] = ""

elseif locale == "esMX" then -- Latin American Spanish
-- L["Flash Brewmaster"] = ""
-- L["Flash Melee Abilities Above % Mana:"] = ""
-- L["Flash Mistweaver"] = ""
-- L["Flash Windwalker"] = ""
-- L["Solo Mode when not Grouped"] = ""

elseif locale == "ruRU" then -- Russian
-- L["Flash Brewmaster"] = ""
-- L["Flash Melee Abilities Above % Mana:"] = ""
-- L["Flash Mistweaver"] = ""
-- L["Flash Windwalker"] = ""
-- L["Solo Mode when not Grouped"] = ""

elseif locale == "zhCN" then -- Simplified Chinese
L["Flash Brewmaster"] = "酿酒闪光" -- Needs review
L["Flash Melee Abilities Above % Mana:"] = "近战技能在能量高于 % 时闪光:" -- Needs review
L["Flash Mistweaver"] = "织雾闪光" -- Needs review
L["Flash Windwalker"] = "风行闪光" -- Needs review
L["Solo Mode when not Grouped"] = "无队伍时使用单人模式" -- Needs review

elseif locale == "esES" then -- Spanish
-- L["Flash Brewmaster"] = ""
-- L["Flash Melee Abilities Above % Mana:"] = ""
-- L["Flash Mistweaver"] = ""
-- L["Flash Windwalker"] = ""
-- L["Solo Mode when not Grouped"] = ""

elseif locale == "zhTW" then -- Traditional Chinese
L["Flash Brewmaster"] = "釀酒閃光" -- Needs review
L["Flash Melee Abilities Above % Mana:"] = "近戰技能在能量值高過 % 時閃光:" -- Needs review
L["Flash Mistweaver"] = "織霧閃光" -- Needs review
L["Flash Windwalker"] = "御風閃光" -- Needs review
L["Solo Mode when not Grouped"] = "無組隊時使用單人模式" -- Needs review

end