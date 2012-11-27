-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/bittens-spellflash-warlock/localization/

local AddonName, a = ...
local function DefaultFunction(_, key) return key end
a.Localize = setmetatable({}, {__index = DefaultFunction})
local L = a.Localize

if GetLocale() == "ptBR" then -- Brazilian Portuguese

elseif GetLocale() == "frFR" then -- French

elseif GetLocale() == "deDE" then -- German

elseif GetLocale() == "koKR" then -- Korean

elseif GetLocale() == "esMX" then -- Latin American Spanish

elseif GetLocale() == "ruRU" then -- Russian

elseif GetLocale() == "zhCN" then -- Simplified Chinese

elseif GetLocale() == "esES" then -- Spanish

elseif GetLocale() == "zhTW" then -- Traditional Chinese

end