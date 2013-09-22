-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/bittens-utils/localization/

local u = BittensGlobalTables.GetTable("BittensUtilities")
if u.SkipOrUpgrade(u, "Localization", 1) then
	return
end
u.Localize = setmetatable({ }, { __index = function(_, key) return key end })
local L = u.Localize
local locale = GetLocale()
if locale == "ptBR" then -- Brazilian Portuguese
--@localization(locale="ptBR", format="lua_additive_table")@
elseif locale == "frFR" then -- French
--@localization(locale="frFR", format="lua_additive_table")@
elseif locale == "deDE" then -- German
--@localization(locale="deDE", format="lua_additive_table")@
elseif locale == "itIT" then -- Italian
--@localization(locale="itIT", format="lua_additive_table")@
elseif locale == "koKR" then -- Korean
--@localization(locale="koKR", format="lua_additive_table")@
elseif locale == "esMX" then -- Latin American Spanish
--@localization(locale="esMX", format="lua_additive_table")@
elseif locale == "ruRU" then -- Russian
--@localization(locale="ruRU", format="lua_additive_table")@
elseif locale == "zhCN" then -- Simplified Chinese
--@localization(locale="zhCN", format="lua_additive_table")@
elseif locale == "esES" then -- Spanish
--@localization(locale="esES", format="lua_additive_table")@
elseif locale == "zhTW" then -- Traditional Chinese
--@localization(locale="zhTW", format="lua_additive_table")@
end