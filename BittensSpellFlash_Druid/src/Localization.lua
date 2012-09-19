-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/bittens-spellflash-druid/localization/

local AddonName, a = ...
local function DefaultFunction(_, key) return key end
a.Localize = setmetatable({}, {__index = DefaultFunction})
local L = a.Localize

-- Example:
L["English text goes here."] = "Translated text goes here."

if GetLocale() == "ptBR" then -- Brazilian Portuguese
-- L["Flash Balance"] = ""
-- L["Flash Feral"] = ""
-- L["Flash Guardian"] = ""
-- L["Flash Resto"] = ""

elseif GetLocale() == "frFR" then -- French
-- L["Flash Balance"] = ""
-- L["Flash Feral"] = ""
-- L["Flash Guardian"] = ""
-- L["Flash Resto"] = ""

elseif GetLocale() == "deDE" then -- German
-- L["Flash Balance"] = ""
L["Flash Feral"] = "Aufblitzen in Katzengestalt" -- Needs review
L["Flash Guardian"] = "Aufblitzen in Bärengestalt" -- Needs review
L["Flash Resto"] = "Aufblitzen bei Wiederherstellung" -- Needs review

elseif GetLocale() == "koKR" then -- Korean
-- L["Flash Balance"] = ""
-- L["Flash Feral"] = ""
-- L["Flash Guardian"] = ""
-- L["Flash Resto"] = ""

elseif GetLocale() == "esMX" then -- Latin American Spanish
-- L["Flash Balance"] = ""
-- L["Flash Feral"] = ""
-- L["Flash Guardian"] = ""
-- L["Flash Resto"] = ""

elseif GetLocale() == "ruRU" then -- Russian
-- L["Flash Balance"] = ""
-- L["Flash Feral"] = ""
-- L["Flash Guardian"] = ""
-- L["Flash Resto"] = ""

elseif GetLocale() == "zhCN" then -- Simplified Chinese
-- L["Flash Balance"] = ""
-- L["Flash Feral"] = ""
-- L["Flash Guardian"] = ""
-- L["Flash Resto"] = ""

elseif GetLocale() == "esES" then -- Spanish
-- L["Flash Balance"] = ""
-- L["Flash Feral"] = ""
-- L["Flash Guardian"] = ""
-- L["Flash Resto"] = ""

elseif GetLocale() == "zhTW" then -- Traditional Chinese
-- L["Flash Balance"] = ""
-- L["Flash Feral"] = ""
-- L["Flash Guardian"] = ""
-- L["Flash Resto"] = ""

end