-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/bittens-spellflash-pally/localization/

local AddonName, a = ...
local function DefaultFunction(_, key) return key end
a.Localize = setmetatable({}, {__index = DefaultFunction})
local L = a.Localize

if GetLocale() == "ptBR" then -- Brazilian Portuguese
-- L["Demon"] = ""
-- L["Dragonkin"] = ""
-- L["Elemental"] = ""
-- L["Flash Holy"] = ""
-- L["Flash Prot"] = ""
-- L["Flash Ret"] = ""
-- L["Undead"] = ""
-- L["Wearing Prot 2pT13"] = ""

elseif GetLocale() == "frFR" then -- French
-- L["Demon"] = ""
-- L["Dragonkin"] = ""
-- L["Elemental"] = ""
-- L["Flash Holy"] = ""
-- L["Flash Prot"] = ""
-- L["Flash Ret"] = ""
-- L["Undead"] = ""
-- L["Wearing Prot 2pT13"] = ""

elseif GetLocale() == "deDE" then -- German
L["Demon"] = "Dämon" -- Needs review
L["Dragonkin"] = "Drachkin" -- Needs review
L["Elemental"] = "Elementar" -- Needs review
L["Flash Holy"] = "Aufblitzen bei Heilig" -- Needs review
L["Flash Prot"] = "Aufblitzen bei Schutz" -- Needs review
L["Flash Ret"] = "Aufblitzen bei Vergeltung" -- Needs review
L["Undead"] = "Untot" -- Needs review
L["Wearing Prot 2pT13"] = "Trage 2 Schutz T13 Teile" -- Needs review

elseif GetLocale() == "koKR" then -- Korean
-- L["Demon"] = ""
-- L["Dragonkin"] = ""
-- L["Elemental"] = ""
-- L["Flash Holy"] = ""
-- L["Flash Prot"] = ""
-- L["Flash Ret"] = ""
-- L["Undead"] = ""
-- L["Wearing Prot 2pT13"] = ""

elseif GetLocale() == "esMX" then -- Latin American Spanish
-- L["Demon"] = ""
-- L["Dragonkin"] = ""
-- L["Elemental"] = ""
-- L["Flash Holy"] = ""
-- L["Flash Prot"] = ""
-- L["Flash Ret"] = ""
-- L["Undead"] = ""
-- L["Wearing Prot 2pT13"] = ""

elseif GetLocale() == "ruRU" then -- Russian
-- L["Demon"] = ""
-- L["Dragonkin"] = ""
-- L["Elemental"] = ""
-- L["Flash Holy"] = ""
-- L["Flash Prot"] = ""
-- L["Flash Ret"] = ""
-- L["Undead"] = ""
-- L["Wearing Prot 2pT13"] = ""

elseif GetLocale() == "zhCN" then -- Simplified Chinese
-- L["Demon"] = ""
-- L["Dragonkin"] = ""
-- L["Elemental"] = ""
-- L["Flash Holy"] = ""
-- L["Flash Prot"] = ""
-- L["Flash Ret"] = ""
-- L["Undead"] = ""
-- L["Wearing Prot 2pT13"] = ""

elseif GetLocale() == "esES" then -- Spanish
-- L["Demon"] = ""
-- L["Dragonkin"] = ""
-- L["Elemental"] = ""
-- L["Flash Holy"] = ""
-- L["Flash Prot"] = ""
-- L["Flash Ret"] = ""
-- L["Undead"] = ""
-- L["Wearing Prot 2pT13"] = ""

elseif GetLocale() == "zhTW" then -- Traditional Chinese
-- L["Demon"] = ""
-- L["Dragonkin"] = ""
-- L["Elemental"] = ""
-- L["Flash Holy"] = ""
-- L["Flash Prot"] = ""
-- L["Flash Ret"] = ""
-- L["Undead"] = ""
-- L["Wearing Prot 2pT13"] = ""

end