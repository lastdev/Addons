-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/bittens-spellflash-atonement/localization/

local addonName, a = ...
local function DefaultFunction(_, key) return key end
a.Localize = setmetatable({}, {__index = DefaultFunction})
local L = a.Localize

if GetLocale() == "ptBR" then -- Brazilian Portuguese
L["Announce Out of Range in Party"] = "Anunciar Fora de Alcance em Grupo" -- Needs review
L["Announce Out of Range in Say"] = "Anunciar Fora de Alcance em Dizer" -- Needs review
L["Announce Out of Range in Whisper"] = "Anunciar Fora de Alcance em Sussurro" -- Needs review
L["Healing only under % mana:"] = "Cura apenas sob % de mana:" -- Needs review
L["Mana-conscious rotation under % mana:"] = "Rotação consciente de mana sob % de mana:" -- Needs review
L["Out of range announcement:"] = "Anúncio de fora de alcance:" -- Needs review
L["<Player> <is/are> out of range of <Atonement>."] = "O(s) <Jogador(es)> <está/estão> fora de alcance da <Reconciliação>." -- Needs review
L["Prioritize healing under % health:"] = "Priorizar cura sob % de vida:" -- Needs review

elseif GetLocale() == "frFR" then -- French
-- L["Announce Out of Range in Party"] = ""
-- L["Announce Out of Range in Say"] = ""
-- L["Announce Out of Range in Whisper"] = ""
-- L["Healing only under % mana:"] = ""
-- L["Mana-conscious rotation under % mana:"] = ""
-- L["Out of range announcement:"] = ""
-- L["<Player> <is/are> out of range of <Atonement>."] = ""
-- L["Prioritize healing under % health:"] = ""

elseif GetLocale() == "deDE" then -- German
-- L["Announce Out of Range in Party"] = ""
-- L["Announce Out of Range in Say"] = ""
-- L["Announce Out of Range in Whisper"] = ""
-- L["Healing only under % mana:"] = ""
-- L["Mana-conscious rotation under % mana:"] = ""
-- L["Out of range announcement:"] = ""
-- L["<Player> <is/are> out of range of <Atonement>."] = ""
-- L["Prioritize healing under % health:"] = ""

elseif GetLocale() == "koKR" then -- Korean
-- L["Announce Out of Range in Party"] = ""
-- L["Announce Out of Range in Say"] = ""
-- L["Announce Out of Range in Whisper"] = ""
-- L["Healing only under % mana:"] = ""
-- L["Mana-conscious rotation under % mana:"] = ""
-- L["Out of range announcement:"] = ""
-- L["<Player> <is/are> out of range of <Atonement>."] = ""
-- L["Prioritize healing under % health:"] = ""

elseif GetLocale() == "esMX" then -- Latin American Spanish
-- L["Announce Out of Range in Party"] = ""
-- L["Announce Out of Range in Say"] = ""
-- L["Announce Out of Range in Whisper"] = ""
-- L["Healing only under % mana:"] = ""
-- L["Mana-conscious rotation under % mana:"] = ""
-- L["Out of range announcement:"] = ""
-- L["<Player> <is/are> out of range of <Atonement>."] = ""
-- L["Prioritize healing under % health:"] = ""

elseif GetLocale() == "ruRU" then -- Russian
-- L["Announce Out of Range in Party"] = ""
-- L["Announce Out of Range in Say"] = ""
-- L["Announce Out of Range in Whisper"] = ""
-- L["Healing only under % mana:"] = ""
-- L["Mana-conscious rotation under % mana:"] = ""
-- L["Out of range announcement:"] = ""
-- L["<Player> <is/are> out of range of <Atonement>."] = ""
-- L["Prioritize healing under % health:"] = ""

elseif GetLocale() == "zhCN" then -- Simplified Chinese
-- L["Announce Out of Range in Party"] = ""
-- L["Announce Out of Range in Say"] = ""
-- L["Announce Out of Range in Whisper"] = ""
-- L["Healing only under % mana:"] = ""
-- L["Mana-conscious rotation under % mana:"] = ""
-- L["Out of range announcement:"] = ""
-- L["<Player> <is/are> out of range of <Atonement>."] = ""
-- L["Prioritize healing under % health:"] = ""

elseif GetLocale() == "esES" then -- Spanish
-- L["Announce Out of Range in Party"] = ""
-- L["Announce Out of Range in Say"] = ""
-- L["Announce Out of Range in Whisper"] = ""
-- L["Healing only under % mana:"] = ""
-- L["Mana-conscious rotation under % mana:"] = ""
-- L["Out of range announcement:"] = ""
-- L["<Player> <is/are> out of range of <Atonement>."] = ""
-- L["Prioritize healing under % health:"] = ""

elseif GetLocale() == "zhTW" then -- Traditional Chinese
-- L["Announce Out of Range in Party"] = ""
-- L["Announce Out of Range in Say"] = ""
-- L["Announce Out of Range in Whisper"] = ""
-- L["Healing only under % mana:"] = ""
-- L["Mana-conscious rotation under % mana:"] = ""
-- L["Out of range announcement:"] = ""
-- L["<Player> <is/are> out of range of <Atonement>."] = ""
-- L["Prioritize healing under % health:"] = ""

end