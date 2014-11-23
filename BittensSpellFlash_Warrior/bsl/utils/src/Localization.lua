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
-- L["B"] = ""
-- L["K"] = ""
-- L["M"] = ""
-- L["T"] = ""

elseif locale == "frFR" then -- French
-- L["B"] = ""
-- L["K"] = ""
-- L["M"] = ""
-- L["T"] = ""

elseif locale == "deDE" then -- German
L["B"] = "Einbuchstabiges Kürzel für (englisch) \"Billion\"" -- Needs review
L["K"] = "Einbuchstabiges Kürzel für \"Tausend\"" -- Needs review
L["M"] = "Einbuchstabiges Kürzel für \"Million\"" -- Needs review
L["T"] = "Einbuchstabiges Kürzel für (englisch) \"Trillion\"" -- Needs review

elseif locale == "itIT" then -- Italian
-- L["B"] = ""
-- L["K"] = ""
-- L["M"] = ""
-- L["T"] = ""

elseif locale == "koKR" then -- Korean
-- L["B"] = ""
-- L["K"] = ""
-- L["M"] = ""
-- L["T"] = ""

elseif locale == "esMX" then -- Latin American Spanish
-- L["B"] = ""
-- L["K"] = ""
-- L["M"] = ""
-- L["T"] = ""

elseif locale == "ruRU" then -- Russian
-- L["B"] = ""
-- L["K"] = ""
-- L["M"] = ""
-- L["T"] = ""

elseif locale == "zhCN" then -- Simplified Chinese
-- L["B"] = ""
-- L["K"] = ""
L["M"] = "百万" -- Needs review
-- L["T"] = ""

elseif locale == "esES" then -- Spanish
-- L["B"] = ""
-- L["K"] = ""
-- L["M"] = ""
-- L["T"] = ""

elseif locale == "zhTW" then -- Traditional Chinese
-- L["B"] = ""
-- L["K"] = ""
L["M"] = "百萬" -- Needs review
-- L["T"] = ""

end