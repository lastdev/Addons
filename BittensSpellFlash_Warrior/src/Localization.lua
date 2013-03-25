-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/bittens-spellflash-warrior/localization/

local addonName, a = ...
local function DefaultFunction(_, key) return key end
a.Localize = setmetatable({}, {__index = DefaultFunction})
local L = a.Localize

if GetLocale() == "ptBR" then -- Brazilian Portuguese
-- L["Flash Arms"] = ""
-- L["Flash Fury"] = ""
-- L["Flash Protection"] = ""

elseif GetLocale() == "frFR" then -- French
-- L["Flash Arms"] = ""
-- L["Flash Fury"] = ""
-- L["Flash Protection"] = ""

elseif GetLocale() == "deDE" then -- German
-- L["Flash Arms"] = ""
-- L["Flash Fury"] = ""
-- L["Flash Protection"] = ""

elseif GetLocale() == "koKR" then -- Korean
-- L["Flash Arms"] = ""
-- L["Flash Fury"] = ""
-- L["Flash Protection"] = ""

elseif GetLocale() == "esMX" then -- Latin American Spanish
-- L["Flash Arms"] = ""
-- L["Flash Fury"] = ""
-- L["Flash Protection"] = ""

elseif GetLocale() == "ruRU" then -- Russian
-- L["Flash Arms"] = ""
-- L["Flash Fury"] = ""
-- L["Flash Protection"] = ""

elseif GetLocale() == "zhCN" then -- Simplified Chinese
-- L["Flash Arms"] = ""
-- L["Flash Fury"] = ""
-- L["Flash Protection"] = ""

elseif GetLocale() == "esES" then -- Spanish
-- L["Flash Arms"] = ""
-- L["Flash Fury"] = ""
-- L["Flash Protection"] = ""

elseif GetLocale() == "zhTW" then -- Traditional Chinese
-- L["Flash Arms"] = ""
-- L["Flash Fury"] = ""
-- L["Flash Protection"] = ""

end