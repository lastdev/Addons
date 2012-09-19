-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/bittens-spellflash-dk/localization/

local AddonName, a = ...
local function DefaultFunction(_, key) return key end
a.Localize = setmetatable({}, {__index = DefaultFunction})
local L = a.Localize

if GetLocale() == "ptBR" then -- Brazilian Portuguese
-- L["Flash Blood"] = ""
-- L["Flash Frost"] = ""
-- L["Flash Unholy"] = ""

elseif GetLocale() == "frFR" then -- French
-- L["Flash Blood"] = ""
-- L["Flash Frost"] = ""
-- L["Flash Unholy"] = ""

elseif GetLocale() == "deDE" then -- German
L["Flash Blood"] = "Aufblitzen bei Blut" -- Needs review
L["Flash Frost"] = "Aufblitzen bei Frost" -- Needs review
L["Flash Unholy"] = "Aufblitzen bei Unheilig" -- Needs review

elseif GetLocale() == "koKR" then -- Korean
-- L["Flash Blood"] = ""
-- L["Flash Frost"] = ""
-- L["Flash Unholy"] = ""

elseif GetLocale() == "esMX" then -- Latin American Spanish
-- L["Flash Blood"] = ""
-- L["Flash Frost"] = ""
-- L["Flash Unholy"] = ""

elseif GetLocale() == "ruRU" then -- Russian
-- L["Flash Blood"] = ""
-- L["Flash Frost"] = ""
-- L["Flash Unholy"] = ""

elseif GetLocale() == "zhCN" then -- Simplified Chinese
-- L["Flash Blood"] = ""
-- L["Flash Frost"] = ""
-- L["Flash Unholy"] = ""

elseif GetLocale() == "esES" then -- Spanish
-- L["Flash Blood"] = ""
-- L["Flash Frost"] = ""
-- L["Flash Unholy"] = ""

elseif GetLocale() == "zhTW" then -- Traditional Chinese
-- L["Flash Blood"] = ""
-- L["Flash Frost"] = ""
-- L["Flash Unholy"] = ""

end