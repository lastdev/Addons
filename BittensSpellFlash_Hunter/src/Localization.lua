-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/bittens-spellflash-hunter/localization/

local AddonName, a = ...
local function DefaultFunction(_, key) return key end
a.Localize = setmetatable({}, {__index = DefaultFunction})
local L = a.Localize

if GetLocale() == "ptBR" then -- Brazilian Portuguese
L["Flash Beast Mastery"] = "Brilhar Domínio das Feras" -- Needs review
L["Flash Survival"] = "Brilhar Sobrevivência" -- Needs review

elseif GetLocale() == "frFR" then -- French
-- L["Flash Beast Mastery"] = ""
-- L["Flash Survival"] = ""

elseif GetLocale() == "deDE" then -- German
-- L["Flash Beast Mastery"] = ""
-- L["Flash Survival"] = ""

elseif GetLocale() == "koKR" then -- Korean
-- L["Flash Beast Mastery"] = ""
-- L["Flash Survival"] = ""

elseif GetLocale() == "esMX" then -- Latin American Spanish
-- L["Flash Beast Mastery"] = ""
-- L["Flash Survival"] = ""

elseif GetLocale() == "ruRU" then -- Russian
-- L["Flash Beast Mastery"] = ""
-- L["Flash Survival"] = ""

elseif GetLocale() == "zhCN" then -- Simplified Chinese
-- L["Flash Beast Mastery"] = ""
-- L["Flash Survival"] = ""

elseif GetLocale() == "esES" then -- Spanish
-- L["Flash Beast Mastery"] = ""
-- L["Flash Survival"] = ""

elseif GetLocale() == "zhTW" then -- Traditional Chinese
-- L["Flash Beast Mastery"] = ""
-- L["Flash Survival"] = ""

end