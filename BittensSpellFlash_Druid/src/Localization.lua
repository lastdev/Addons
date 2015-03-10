-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/bittens-spellflash-druid/localization/

local _, a = ...
a.Localize = setmetatable({ }, { __index = function(_, key) return key end })
local L = a.Localize
local locale = GetLocale()
if locale == "ptBR" then -- Brazilian Portuguese
L["Flash Balance"] = "Flash Equilíbrio"
L["Flash Feral"] = "Flash Feral"
L["Flash Guardian"] = "Flash Guardião"
L["Flash Resto"] = "Flash Restauração"
L["Solo Mode when not Grouped"] = "Modo solo quando não estiver em grupo"

elseif locale == "frFR" then -- French
L["Flash Balance"] = "Flash Équilibre" -- Needs review
L["Flash Feral"] = "Flash Farouche" -- Needs review
L["Flash Guardian"] = "Flash Gardien" -- Needs review
L["Flash Resto"] = "Flash Restauration" -- Needs review
L["Solo Mode when not Grouped"] = "Mode solo si pas groupé" -- Needs review

elseif locale == "deDE" then -- German
L["Flash Balance"] = "Auflisten bei Gleichgewicht  (Moonkin)" -- Needs review
L["Flash Feral"] = "Aufblitzen in Katzengestalt"
L["Flash Guardian"] = "Aufblitzen in Bärengestalt"
L["Flash Resto"] = "Aufblitzen bei Wiederherstellung"
L["Solo Mode when not Grouped"] = "Solo Modus wenn nicht in einer Gruppe"

elseif locale == "itIT" then -- Italian
-- L["Flash Balance"] = ""
-- L["Flash Feral"] = ""
-- L["Flash Guardian"] = ""
-- L["Flash Resto"] = ""
L["Solo Mode when not Grouped"] = "Modalità Solitaria quando non in Gruppo" -- Needs review

elseif locale == "koKR" then -- Korean
-- L["Flash Balance"] = ""
-- L["Flash Feral"] = ""
-- L["Flash Guardian"] = ""
-- L["Flash Resto"] = ""
-- L["Solo Mode when not Grouped"] = ""

elseif locale == "esMX" then -- Latin American Spanish
L["Flash Balance"] = "Flash Balance" -- Needs review
L["Flash Feral"] = "Flash Gato" -- Needs review
L["Flash Guardian"] = "Flash Guardian" -- Needs review
L["Flash Resto"] = "Flash Restauracion" -- Needs review
L["Solo Mode when not Grouped"] = "Modo solitario cuando no esta en grupo" -- Needs review

elseif locale == "ruRU" then -- Russian
-- L["Flash Balance"] = ""
-- L["Flash Feral"] = ""
-- L["Flash Guardian"] = ""
-- L["Flash Resto"] = ""
-- L["Solo Mode when not Grouped"] = ""

elseif locale == "zhCN" then -- Simplified Chinese
L["Flash Balance"] = "平衡闪光" -- Needs review
L["Flash Feral"] = "野性闪光" -- Needs review
L["Flash Guardian"] = "守护闪光" -- Needs review
L["Flash Resto"] = "恢复闪光" -- Needs review
L["Solo Mode when not Grouped"] = "无队伍时使用单人模式" -- Needs review

elseif locale == "esES" then -- Spanish
L["Flash Balance"] = "Alertas de Equilibrio" -- Needs review
L["Flash Feral"] = "Alertas de Combate feral" -- Needs review
L["Flash Guardian"] = "Alertas de Guardián" -- Needs review
L["Flash Resto"] = "Alertas de Restauración" -- Needs review
L["Solo Mode when not Grouped"] = "Modo en solitario para cuando no estés en grupo" -- Needs review

elseif locale == "zhTW" then -- Traditional Chinese
L["Flash Balance"] = "平衡閃光" -- Needs review
L["Flash Feral"] = "野性閃光" -- Needs review
L["Flash Guardian"] = "守護閃光" -- Needs review
L["Flash Resto"] = "恢復閃光" -- Needs review
L["Solo Mode when not Grouped"] = "無隊伍時使用單人模式" -- Needs review

end
