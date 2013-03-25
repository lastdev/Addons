-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/bittens-spellflash-warlock/localization/

local addonName, a = ...
local function DefaultFunction(_, key) return key end
a.Localize = setmetatable({}, {__index = DefaultFunction})
local L = a.Localize

if GetLocale() == "ptBR" then -- Brazilian Portuguese
-- L["Flash Affliction"] = ""
-- L["Flash Demonology"] = ""
-- L["Flash Destruction"] = ""

elseif GetLocale() == "frFR" then -- French
-- L["Flash Affliction"] = ""
-- L["Flash Demonology"] = ""
-- L["Flash Destruction"] = ""

elseif GetLocale() == "deDE" then -- German
-- L["Flash Affliction"] = ""
-- L["Flash Demonology"] = ""
-- L["Flash Destruction"] = ""

elseif GetLocale() == "koKR" then -- Korean
-- L["Flash Affliction"] = ""
-- L["Flash Demonology"] = ""
-- L["Flash Destruction"] = ""

elseif GetLocale() == "esMX" then -- Latin American Spanish
-- L["Flash Affliction"] = ""
-- L["Flash Demonology"] = ""
-- L["Flash Destruction"] = ""

elseif GetLocale() == "ruRU" then -- Russian
-- L["Flash Affliction"] = ""
-- L["Flash Demonology"] = ""
-- L["Flash Destruction"] = ""

elseif GetLocale() == "zhCN" then -- Simplified Chinese
-- L["Flash Affliction"] = ""
-- L["Flash Demonology"] = ""
-- L["Flash Destruction"] = ""

elseif GetLocale() == "esES" then -- Spanish
-- L["Flash Affliction"] = ""
-- L["Flash Demonology"] = ""
-- L["Flash Destruction"] = ""

elseif GetLocale() == "zhTW" then -- Traditional Chinese
-- L["Flash Affliction"] = ""
-- L["Flash Demonology"] = ""
-- L["Flash Destruction"] = ""

end