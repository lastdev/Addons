-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/bittens-spellflash-rogue/localization/

local addonName, a = ...
local function DefaultFunction(_, key) return key end
a.Localize = setmetatable({}, {__index = DefaultFunction})
local L = a.Localize

if GetLocale() == "ptBR" then -- Brazilian Portuguese
-- L["Deadly Poison"] = ""
-- L["Flash Assassination"] = ""
-- L["Flash Combat"] = ""
-- L["Instant Poison"] = ""
-- L["Solo Mode when not Grouped"] = ""
-- L["Wound Poison"] = ""

elseif GetLocale() == "frFR" then -- French
-- L["Deadly Poison"] = ""
-- L["Flash Assassination"] = ""
-- L["Flash Combat"] = ""
-- L["Instant Poison"] = ""
-- L["Solo Mode when not Grouped"] = ""
-- L["Wound Poison"] = ""

elseif GetLocale() == "deDE" then -- German
L["Deadly Poison"] = "Tödliches Gift" -- Needs review
L["Flash Assassination"] = "Aufblitzen bei Meucheln" -- Needs review
L["Flash Combat"] = "Aufblitzen bei Kampf" -- Needs review
L["Instant Poison"] = "Sofort wirkendes Gift" -- Needs review
-- L["Solo Mode when not Grouped"] = ""
L["Wound Poison"] = "Wundgift" -- Needs review

elseif GetLocale() == "koKR" then -- Korean
-- L["Deadly Poison"] = ""
-- L["Flash Assassination"] = ""
-- L["Flash Combat"] = ""
-- L["Instant Poison"] = ""
-- L["Solo Mode when not Grouped"] = ""
-- L["Wound Poison"] = ""

elseif GetLocale() == "esMX" then -- Latin American Spanish
-- L["Deadly Poison"] = ""
-- L["Flash Assassination"] = ""
-- L["Flash Combat"] = ""
-- L["Instant Poison"] = ""
-- L["Solo Mode when not Grouped"] = ""
-- L["Wound Poison"] = ""

elseif GetLocale() == "ruRU" then -- Russian
-- L["Deadly Poison"] = ""
-- L["Flash Assassination"] = ""
-- L["Flash Combat"] = ""
-- L["Instant Poison"] = ""
-- L["Solo Mode when not Grouped"] = ""
-- L["Wound Poison"] = ""

elseif GetLocale() == "zhCN" then -- Simplified Chinese
-- L["Deadly Poison"] = ""
-- L["Flash Assassination"] = ""
-- L["Flash Combat"] = ""
-- L["Instant Poison"] = ""
-- L["Solo Mode when not Grouped"] = ""
-- L["Wound Poison"] = ""

elseif GetLocale() == "esES" then -- Spanish
-- L["Deadly Poison"] = ""
-- L["Flash Assassination"] = ""
-- L["Flash Combat"] = ""
-- L["Instant Poison"] = ""
-- L["Solo Mode when not Grouped"] = ""
-- L["Wound Poison"] = ""

elseif GetLocale() == "zhTW" then -- Traditional Chinese
-- L["Deadly Poison"] = ""
-- L["Flash Assassination"] = ""
-- L["Flash Combat"] = ""
-- L["Instant Poison"] = ""
-- L["Solo Mode when not Grouped"] = ""
-- L["Wound Poison"] = ""

end