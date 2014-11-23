-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/bittens-spellflash-warlock/localization/

local addonName, a = ...
a.Localize = setmetatable({ }, { __index = function(_, key) return key end })
local L = a.Localize
local locale = GetLocale()
if locale == "ptBR" then -- Brazilian Portuguese
L["Flash Affliction"] = "Flash Sofrimento" -- Needs review
L["Flash Demonology"] = "Flash Demonologia" -- Needs review
L["Flash Destruction"] = "Flash Destruição" -- Needs review

elseif locale == "frFR" then -- French
-- L["Flash Affliction"] = ""
-- L["Flash Demonology"] = ""
-- L["Flash Destruction"] = ""

elseif locale == "deDE" then -- German
L["Flash Affliction"] = "Blitz Gebrechen" -- Needs review
L["Flash Demonology"] = "Blitz Dämonologie" -- Needs review
L["Flash Destruction"] = "Blitz Zerstörung" -- Needs review

elseif locale == "itIT" then -- Italian
L["Flash Affliction"] = "Flash L'Afflizione" -- Needs review
L["Flash Demonology"] = "Flash Demonologia" -- Needs review
L["Flash Destruction"] = "Flash Distruzione" -- Needs review

elseif locale == "koKR" then -- Korean
L["Flash Affliction"] = [=[플래시 파괴
]=] -- Needs review
L["Flash Demonology"] = "플래시 악마" -- Needs review
L["Flash Destruction"] = "플래시 파괴" -- Needs review

elseif locale == "esMX" then -- Latin American Spanish
L["Flash Affliction"] = "Flash aflicción"
L["Flash Demonology"] = "Flash demonología"
L["Flash Destruction"] = "Flash destrucción"

elseif locale == "ruRU" then -- Russian
L["Flash Affliction"] = "Флэш недугом" -- Needs review
L["Flash Demonology"] = "Флэш Demonology" -- Needs review
L["Flash Destruction"] = [=[Флэш уничтожения  
]=] -- Needs review

elseif locale == "zhCN" then -- Simplified Chinese
L["Flash Affliction"] = "闪存痛苦" -- Needs review
L["Flash Demonology"] = "闪存恶魔" -- Needs review
L["Flash Destruction"] = "闪存销毁" -- Needs review

elseif locale == "esES" then -- Spanish
L["Flash Affliction"] = "Flash aflicción"
L["Flash Demonology"] = "Flash demonología"
L["Flash Destruction"] = "Flash destrucción"

elseif locale == "zhTW" then -- Traditional Chinese
L["Flash Affliction"] = "閃存痛苦" -- Needs review
L["Flash Demonology"] = "惡魔閃光" -- Needs review
L["Flash Destruction"] = "闪存销毁" -- Needs review

end