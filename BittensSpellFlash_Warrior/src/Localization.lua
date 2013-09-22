-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/bittens-spellflash-warrior/localization/

local addonName, a = ...
a.Localize = setmetatable({ }, { __index = function(_, key) return key end })
local L = a.Localize
local locale = GetLocale()
if locale == "ptBR" then -- Brazilian Portuguese
-- L["Flash Arms"] = ""
-- L["Flash Fury"] = ""
-- L["Flash Protection"] = ""

elseif locale == "frFR" then -- French
-- L["Flash Arms"] = ""
-- L["Flash Fury"] = ""
-- L["Flash Protection"] = ""

elseif locale == "deDE" then -- German
-- L["Flash Arms"] = ""
-- L["Flash Fury"] = ""
-- L["Flash Protection"] = ""

elseif locale == "itIT" then -- Italian
-- L["Flash Arms"] = ""
-- L["Flash Fury"] = ""
-- L["Flash Protection"] = ""

elseif locale == "koKR" then -- Korean
-- L["Flash Arms"] = ""
-- L["Flash Fury"] = ""
-- L["Flash Protection"] = ""

elseif locale == "esMX" then -- Latin American Spanish
-- L["Flash Arms"] = ""
-- L["Flash Fury"] = ""
-- L["Flash Protection"] = ""

elseif locale == "ruRU" then -- Russian
-- L["Flash Arms"] = ""
-- L["Flash Fury"] = ""
-- L["Flash Protection"] = ""

elseif locale == "zhCN" then -- Simplified Chinese
L["Flash Arms"] = "武器闪光" -- Needs review
L["Flash Fury"] = "狂怒闪光" -- Needs review
L["Flash Protection"] = "防护闪光" -- Needs review

elseif locale == "esES" then -- Spanish
-- L["Flash Arms"] = ""
-- L["Flash Fury"] = ""
-- L["Flash Protection"] = ""

elseif locale == "zhTW" then -- Traditional Chinese
L["Flash Arms"] = "武器閃光" -- Needs review
L["Flash Fury"] = "狂怒閃光" -- Needs review
L["Flash Protection"] = "防護閃光" -- Needs review

end