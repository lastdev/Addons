-- The default locale, which is in the English language.
local L = LibStub("AceLocale-3.0"):NewLocale("RareTrackerVale", "enUS", true, true)
if not L then return end

-- Option menu strings.
L["Rare window scale"] = "Rare window scale"
L["Set the scale of the rare window."] = "Set the scale of the rare window."
L["Disable All"] = "Disable All"
L["Disable all non-favorite rares in the list."] = "Disable all non-favorite rares in the list."
L["Enable All"] = "Enable All"
L["Enable all rares in the list."] = "Enable all rares in the list."
L["Reset Favorites"] = "Reset Favorites"
L["Reset the list of favorite rares."] = "Reset the list of favorite rares."
L["General Options"] = "General Options"
L["Rare List Options"] = "Rare List Options"
L["Active Rares"] = "Active Rares"

-- Status messages.
L["<%s> Moving to shard "] = "<%s> Moving to shard "
L["<%s> Failed to register AddonPrefix '%s'. %s will not function properly."] = "<%s> Failed to register AddonPrefix '%s'. %s will not function properly."