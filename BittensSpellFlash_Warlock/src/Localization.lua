-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/bittens-spellflash-warlock/localization/

local addonName, a = ...
a.Localize = setmetatable({ }, { __index = function(_, key) return key end })
local L = a.Localize
local locale = GetLocale()
if locale == "ptBR" then -- Brazilian Portuguese
-- L["Flash Affliction"] = ""
-- L["Flash Demonology"] = ""
-- L["Flash Destruction"] = ""

elseif locale == "frFR" then -- French
-- L["Flash Affliction"] = ""
-- L["Flash Demonology"] = ""
-- L["Flash Destruction"] = ""

elseif locale == "deDE" then -- German
-- L["Flash Affliction"] = ""
-- L["Flash Demonology"] = ""
-- L["Flash Destruction"] = ""

elseif locale == "itIT" then -- Italian
-- L["Flash Affliction"] = ""
-- L["Flash Demonology"] = ""
-- L["Flash Destruction"] = ""

elseif locale == "koKR" then -- Korean
-- L["Flash Affliction"] = ""
-- L["Flash Demonology"] = ""
-- L["Flash Destruction"] = ""

elseif locale == "esMX" then -- Latin American Spanish
L["Flash Affliction"] = "Flash aflicción"
L["Flash Demonology"] = "Flash demonología"
L["Flash Destruction"] = "Flash destrucción"

elseif locale == "ruRU" then -- Russian
-- L["Flash Affliction"] = ""
-- L["Flash Demonology"] = ""
-- L["Flash Destruction"] = ""

elseif locale == "zhCN" then -- Simplified Chinese
L["Flash Affliction"] = "痛苦闪光" -- Needs review
L["Flash Demonology"] = "恶魔闪光" -- Needs review
L["Flash Destruction"] = "毁灭闪光" -- Needs review

elseif locale == "esES" then -- Spanish
L["Flash Affliction"] = "Flash aflicción"
L["Flash Demonology"] = "Flash demonología"
L["Flash Destruction"] = "Flash destrucción"

elseif locale == "zhTW" then -- Traditional Chinese
L["Flash Affliction"] = "痛苦閃光" -- Needs review
L["Flash Demonology"] = "惡魔閃光" -- Needs review
L["Flash Destruction"] = "毀滅閃光" -- Needs review

end