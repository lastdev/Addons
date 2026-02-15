local _, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger

---@class Lockit
local Lockit = setmetatable(
    {},
    {
        __index = function(_, ...)
            Logger.Log("Key is not found in the Lockit: `%s`!", ...)
        end
    }
)
DelveCompanion.Lockit = Lockit
-- ====================== NO ADDON DATA BELOW, ONLY LOCKIT ===================================================

-- #region Lockit rules
--[[
- The default locale: enUS. It contains all the keys used by the addon.
- Other languages override existing keys with a corresponding translation.
- The main intent: all locales should follow in-game terms, tiltes, names, etc. Conditions when this rule can be broken:
--- To fit the text into UI. However, each case is considered separately to find the best solution.
--- There is another "word" widely used in a community to name something. E.g. `iLvl` is a common substitution for `Item Level` regardless of the language.
- Keys should have a prefixe to indicate a kind of a key:
--- UI
--- DATA
--- CONFIG
--- etc
- Keys may have a description to provide context where they are used if it matters.
]]
-- #endregion

-- #region DEFAULT LOCKIT (enUS)

-- Common

Lockit.UI_COMMON_BOUNTIFUL_DELVE_TITLE = "Bountiful Delve"
Lockit.UI_COMMON_MISSING_ADDON_TITLE = "Required AddOn is missing: %s" -- `%s`: name of the missing AddOn, e.g. DelveCompanion

-- Delves List

Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CLICK_INSTRUCTION = "<Shift click to set waypoint to the delve>"
Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CURRENT_TEXT = "Waypoint set."
Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CLEAR_INSTRUCTION = "<Shift click to clear the waypoint>"
Lockit.UI_DELVE_INSTANCE_BUTTON_TOOLTIP_CLEAR_MPE = "Please use MapPinEnhanced Tracker to remove the waypoint."

-- Delves UI

Lockit.UI_GILDED_STASH_CANNOT_RETRIEVE_DATA = "Visit Khaz Algar zones to see the progress"
Lockit.UI_GILDED_STASH_BOUNTIFUL_NOTE = "Appears only in |cnNORMAL_FONT_COLOR:Tier 11|r Bountiful Delves|A:delves-bountiful:16:16|a."
Lockit.UI_NO_ACTIVE_BOUNTIFUL = "No active delves"
Lockit.UI_LOOT_INFO_BUTTON_TOOLTIP_INSTRUCTION = "<Click to display Delves' Loot info>"

-- Loot Info

Lockit.UI_LOOT_INFO_DESCRIPTION = "Complete a delve to get:"

-- Tooltips Extension

Lockit.UI_BOUNTIFUL_KEYS_COUNT_CACHES_PREFIX = "Keys from Caches"

-- Compartment (these are shown hovering over the addon in the corresponding dropdown menu)

Lockit.UI_COMPARTMENT_DESCRIPTION_LEFT_CLICK = "|cnGREEN_FONT_COLOR:Left Click|r to show information window."
Lockit.UI_COMPARTMENT_DESCRIPTION_RIGHT_CLICK = "|cnGREEN_FONT_COLOR:Right Click|r to access Addon Options."

-- Settings

Lockit.UI_SETTINGS_SECTION_TITLE_ACCOUNT = "Account-Wide"
Lockit.UI_SETTING_DELVE_PROGRESS_WIDGETS_NAME = "Delve's Progress Info"
Lockit.UI_SETTING_DELVE_PROGRESS_WIDGETS_TOOLTIP = "Delves list: Display achievements progress for each Delve (Stories and Chests)."
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_NAME = "Waypoint Tracking Type"
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_START = "Select which type of Waypoints is used for navigation.\n\nPossible options:"
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_BLIZZARD = "- Blizzard's Map Pin (the default in-game navigation)."
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_TOMTOM = "- TomTom Waypoints."
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_MPE = "- MapPinEnhanced Waypoints."
Lockit.UI_SETTING_WAYPOINT_TRACKING_TYPE_TOOLTIP_TOMTOM_UNAVAILABLE_FORMAT = "%s (%s)."
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_BLIZZARD_NAME = "Blizzard"
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_BLIZZARD_DESCRIPTION = "Use Blizzard's Map Pin."
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_TOMTOM_NAME = "TomTom"
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_TOMTOM_DESCRIPTION = "Use TomTom Waypoints."
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_MPE_NAME = "MapPinEnhanced"
Lockit.UI_SETTING_WAYPOINT_TRACKING_OPTION_MPE_DESCRIPTION = "Use MapPinEnhanced Waypoints."

Lockit.UI_SETTINGS_SECTION_TITLE_CHARACTER = "Character-Wide"
Lockit.UI_SETTING_TOOLTIP_EXTENSION_NAME = "Extra Info in Tooltips"
Lockit.UI_SETTING_TOOLTIP_EXTENSION_TOOLTIP = "Display additional information in tooltips (e.g., the number of |cnITEM_EPIC_COLOR:Restored Coffer Keys|r received this week)."
Lockit.UI_SETTING_COMPANION_CONFIG_NAME = "Companion Configuration Widget"
Lockit.UI_SETTING_COMPANION_CONFIG_TOOLTIP = "Delves UI: Enable a widget that displays the Companion's current specialization and abilities.\nIt can be used to modify the configuration directly from the Delves UI.\nNote: layout type doesn't affect the functionality, only visual arrangement."
Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_HORIZONTAL_NAME = "Horizontal Layout"
Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_HORIZONTAL_DESCRIPTION = "A compact layout with the buttons arranged horizontally. The Companion model is shown."
Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_VERTICAL_NAME = "Vertical Layout"
Lockit.UI_SETTING_COMPANION_CONFIG_OPTION_VERTICAL_DESCRIPTION = "A more detailed layout with the buttons arranged vertically. The Companion model is hidden."
Lockit.UI_SETTING_GV_DETAILS_NAME = "Custom Great Vault"
Lockit.UI_SETTING_GV_DETAILS_TOOLTIP = "Delves UI: Display Great Vault rewards and progress (relevant for Delves) directly in the Delves UI."
Lockit.UI_SETTING_DASHBOARD_OVERVIEW_NAME = "Delves Overview Section"
Lockit.UI_SETTING_DASHBOARD_OVERVIEW_TOOLTIP = "Delves UI: Display an additional Overview section. It contains information about Gilded Stash, available Bountiful Delves, and Delve-related consumables."

Lockit.UI_SETTINGS_TRANSLATION_TITLE = "Special thanks for the translation contribution:"

Lockit.UI_SETTINGS_LINKS_TITLE = "Links"
Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_CURSEFORGE = "Click to copy the URL to the addon page on |cnNORMAL_FONT_COLOR:CurseForge|r."
Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_WAGO = "Click to copy the URL to the addon page on |cnNORMAL_FONT_COLOR:Wago.io|r."
Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_WOWINT = "Click to copy the URL to the addon page on |cnNORMAL_FONT_COLOR:WoW Interface|r."
Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_GITHUB = "Click to copy the URL to the addon page on |cnNORMAL_FONT_COLOR:GitHub|r.\n\nShare feedback, request new features, or report a bug. It helps making the addon even better!"
Lockit.UI_SETTINGS_ADDON_LINK_POPUP_TEXT = "|cnGREEN_FONT_COLOR:Ctrl + C|r to copy the |cnNORMAL_FONT_COLOR:%s|r URL." -- `%s`: website name, e.g. CurseForge.
-- #endregion

-- #region Internal keys. These ARE NOT intended to be translated.

-- Shared

Lockit.UI_ADDON_NAME = "Delve Companion"
Lockit.UI_DELVE_STORY_VARIANT_COMPLETED_SEQUENCE = format("%s %s", "|A:common-icon-checkmark:15:15|a", _G["ACHIEVEMENTFRAME_FILTER_COMPLETED"])
Lockit.UI_DELVE_STORY_VARIANT_NOT_COMPLETED_SEQUENCE = format("%s %s", "|A:QuestLegendary:15:15|a", _G["ACHIEVEMENTFRAME_FILTER_INCOMPLETE"])

-- Debug

Lockit.DEBUG_UNEXPECTED_ENUM_ELEMENT = "Enum `%s` doesn't contain element: %s."
Lockit.DEBUG_SAVED_VARIABLE_CONFLICT = "Save table `%s` doesn't contain a key: %s!"
-- #endregion
