-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/bittens-spellflash-hunter/localization/

local addonName, a = ...
a.Localize = setmetatable({ }, { __index = function(_, key) return key end })
local L = a.Localize
local locale = GetLocale()
if locale == "ptBR" then -- Brazilian Portuguese
L["Flash Beast Mastery"] = "Brilhar Domínio das Feras" -- Needs review
L["Flash Survival"] = "Brilhar Sobrevivência" -- Needs review

elseif locale == "frFR" then -- French
-- L["Flash Beast Mastery"] = ""
-- L["Flash Survival"] = ""

elseif locale == "deDE" then -- German
-- L["Flash Beast Mastery"] = ""
-- L["Flash Survival"] = ""

elseif locale == "itIT" then -- Italian
-- L["Flash Beast Mastery"] = ""
-- L["Flash Survival"] = ""

elseif locale == "koKR" then -- Korean
-- L["Flash Beast Mastery"] = ""
-- L["Flash Survival"] = ""

elseif locale == "esMX" then -- Latin American Spanish
-- L["Flash Beast Mastery"] = ""
-- L["Flash Survival"] = ""

elseif locale == "ruRU" then -- Russian
-- L["Flash Beast Mastery"] = ""
-- L["Flash Survival"] = ""

elseif locale == "zhCN" then -- Simplified Chinese
-- L["Flash Beast Mastery"] = ""
-- L["Flash Survival"] = ""

elseif locale == "esES" then -- Spanish
-- L["Flash Beast Mastery"] = ""
-- L["Flash Survival"] = ""

elseif locale == "zhTW" then -- Traditional Chinese
-- L["Flash Beast Mastery"] = ""
-- L["Flash Survival"] = ""

end