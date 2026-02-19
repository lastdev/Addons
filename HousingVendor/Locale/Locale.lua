-- Locale loader
-- This file loads after all locale files and selects the correct language based on GetLocale()

local ADDON_NAME, ns = ...

-- Global table to store all locale strings (populated by individual locale files)
if not HousingVendorLocales then
    HousingVendorLocales = {}
end

-- Get the current game locale
local gameLocale = GetLocale()
local L

-- Try to use the locale for the current game language
if HousingVendorLocales[gameLocale] then
    L = HousingVendorLocales[gameLocale]
-- Fall back to enUS if the current locale is not available
elseif HousingVendorLocales["enUS"] then
    L = HousingVendorLocales["enUS"]
else
    L = {}
    -- Final fallback: hardcoded English strings if all else fails
    L["HOUSING_VENDOR_TITLE"] = "Housing Vendor"
    L["HOUSING_VENDOR_TITLE_COMPACT"] = "Housing Decor"
    L["HOUSING_VENDOR_SUBTITLE"] = "Browse all housing decorations from vendors across Azeroth"
    L["FILTER_SEARCH"] = "Search:"
    L["FILTER_EXPANSION"] = "Expansion:"
    L["FILTER_VENDOR"] = "Vendor:"
    L["FILTER_ZONE"] = "Zone:"
    L["FILTER_TYPE"] = "Type:"
    L["FILTER_CATEGORY"] = "Category:"
    L["FILTER_FACTION"] = "Faction:"
    L["FILTER_SOURCE"] = "Source:"
    L["FILTER_PROFESSION"] = "Profession:"
    L["FILTER_CLEAR"] = "Clear Filters"
    L["FILTER_CLEAR_SHORT"] = "Clear"
    L["FILTER_ALL_EXPANSIONS"] = "All Expansions"
    L["FILTER_ALL_VENDORS"] = "All Vendors"
    L["FILTER_ALL_ZONES"] = "All Zones"
    L["FILTER_ALL_TYPES"] = "All Types"
    L["FILTER_ALL_CATEGORIES"] = "All Categories"
    L["FILTER_ALL_SOURCES"] = "All Sources"
    L["FILTER_ALL_FACTIONS"] = "All Factions"
    L["COLUMN_ITEM"] = "Item"
    L["COLUMN_ITEM_NAME"] = "Item Name"
    L["COLUMN_SOURCE"] = "Source"
    L["COLUMN_LOCATION"] = "Location"
    L["COLUMN_PRICE"] = "Price"
    L["COLUMN_COST"] = "Cost"
    L["COLUMN_VENDOR"] = "Vendor"
    L["COLUMN_TYPE"] = "Type"
    L["BUTTON_SETTINGS"] = "Settings"
    L["BUTTON_STATISTICS"] = "Statistics"
    L["BUTTON_BACK"] = "Back"
    L["BUTTON_CLOSE"] = "Close"
    L["BUTTON_WAYPOINT"] = "Set Waypoint"
    L["BUTTON_SAVE"] = "Save"
    L["BUTTON_RESET"] = "Reset"
    L["BUTTON_COMPACT_UI"] = "Compact UI"

    -- Compact UI Tooltips
    L["TOOLTIP_MAIN_UI_LINE1"] = "Opens the full interface with all panels and options."
    L["TOOLTIP_MAIN_UI_LINE2"] = "Tip: use Back to return here."
    L["TOOLTIP_COMPACT_UI_LINE1"] = "Lightweight browsing view with quick filters."
    L["TOOLTIP_COMPACT_UI_LINE2"] = "Great for fast searching without the full panels."
    L["TOOLTIP_SETTINGS_LINE1"] = "Configure Compact Mode, Zone Popups, and auto-filter options."
    L["TOOLTIP_SETTINGS_LINE2"] = "Most settings apply to both Compact UI and Full UI."
    L["TOOLTIP_ZONE_POPUP_LINE1"] = "Shows a small window for your current zone."
    L["TOOLTIP_ZONE_POPUP_LINE2"] = "Highlights uncollected decor and where it comes from (vendors/quests/achievements/drops)."
    L["TOOLTIP_AUCTION_HOUSE_LINE1"] = "Shows Auction House prices for crafting materials."
    L["TOOLTIP_AUCTION_HOUSE_LINE2"] = "Use this to estimate total craft costs and compare prices."
    L["TOOLTIP_STATS_LINE1"] = "Shows collection progress and breakdowns."
    L["TOOLTIP_STATS_LINE2"] = "Helpful for tracking what you're missing overall."
    L["TOOLTIP_REPUTATION_LINE1"] = "Shows reputation requirements for decor items."
    L["TOOLTIP_REPUTATION_LINE2"] = "Useful for planning which reputations to work on."
    L["TOOLTIP_ACHIEVEMENTS_LINE1"] = "Shows achievement-based decor and progress tracking."
    L["TOOLTIP_ACHIEVEMENTS_LINE2"] = "Click an achievement item to view details."
    L["TOOLTIP_CRAFTING_LIST_LINE1"] = "Track decor you plan to craft."
    L["TOOLTIP_CRAFTING_LIST_LINE2"] = "Shows combined reagents, owned vs missing, and cost estimates."
    L["TOOLTIP_CRAFTING_LIST_LINE3"] = "Remove items from the list inside the Crafting List window."
    L["TOOLTIP_CLOSE_LINE1"] = "Closes this window."
    L["TOOLTIP_CLOSE_LINE2"] = "Tip: the minimap button (or /hv) can reopen it."

    L["TOOLTIP_BACK_TO_COMPACT_UI"] = "Back to Compact UI"
    L["TOOLTIP_BACK_TO_COMPACT_UI_DESC"] = "Returns to Compact Mode if you opened this panel from Compact UI."

    -- Settings
    L["SETTINGS_COMPACT_MODE"] = "Compact Mode"
    L["SETTINGS_COMPACT_MODE_DESC"] = "When checked, /hv opens in Compact UI by default (until you uncheck it)."
    L["SETTINGS_HIDE_MINIMAP_BUTTON_DESC"] = "Hide the minimap button. Use /hv command to open the addon"
    L["SETTINGS_HIDE_VISITED_VENDORS_DESC"] = "Hide vendors you have already visited from the item list"
    L["SETTINGS_AUTO_FILTER_BY_ZONE_DESC"] = "Automatically filter items by your current zone when opening addon"
    L["SETTINGS_TOMTOM_INTEGRATION"] = "TomTom Integration"
    L["SETTINGS_TOMTOM_INTEGRATION_DESC"] = "Also create a TomTom waypoint (Crazy Arrow) when setting a waypoint."
    L["SETTINGS_VENDOR_MARKER_DESC"] = "Highlight vendor NPCs with colored nameplate borders (use /hv mark)"
    L["SETTINGS_VENDOR_MARKER_DISTANCE_UNIT_DESC"] = "Use meters instead of yards in the marker popup"

    -- Crafting List (Planning)
    L["PLAN_BUTTON_FMT"] = "Craft List (%d)"
    L["PLAN_TITLE"] = "Crafting List"
    L["PLAN_CLEAR_BUTTON"] = "Clear Craft List"
    L["PLAN_TARGETS_TITLE"] = "Crafting Targets"
    L["PLAN_SELECT_ITEM_PROMPT"] = "Select an item in the list to see details."
    L["PLAN_MATERIALS_TITLE"] = "Aggregated Materials (Owned vs Missing)"
    L["PLAN_MATERIALS_MISSING_FMT"] = "Aggregated Materials (Missing %d)"
    L["PLAN_SUMMARY_FMT"] = "Targets: %d  |  Mats (req/miss): %d/%d  |  Miss (alts): %d  |  Est. cost (missing): %s"
    L["PLAN_NO_PRICE"] = "No price"
    L["PLAN_REQ_OWN_MISS_FMT"] = "Req %d Own %d Miss %d"

    L["PLAN_HELP_LINE1"] = "Add decor you plan to craft to see combined reagents."
    L["PLAN_HELP_LINE2"] = "Left: crafting targets. Click a row, use X to remove."
    L["PLAN_HELP_LINE3"] = "Right: aggregated materials with owned/missing and prices."

    L["PLAN_TOOLTIP_SOURCE"] = "Source"
    L["PLAN_TOOLTIP_REQUIRED"] = "Required"
    L["PLAN_TOOLTIP_OWNED_BAGS"] = "Owned (bags)"
    L["PLAN_TOOLTIP_OWNED_BANK"] = "Owned (bank)"
    L["PLAN_TOOLTIP_OWNED_WARBAND"] = "Owned (warband)"
    L["PLAN_TOOLTIP_OWNED_ALTS"] = "Owned (alts)"
    L["PLAN_TOOLTIP_OWNED_TOTAL"] = "Owned (total)"
    L["PLAN_TOOLTIP_MISSING"] = "Missing"
    L["PLAN_TOOLTIP_MISSING_WITH_ALTS"] = "Missing (with alts)"
    L["PLAN_TOOLTIP_AH_UNIT"] = "AH unit"
    L["PLAN_TOOLTIP_AH_MISSING"] = "AH missing"
    L["PLAN_TOOLTIP_AH_ALL"] = "AH all"
    L["PLAN_TOOLTIP_USED_BY"] = "Used by:"
    L["PLAN_TOOLTIP_MORE_FMT"] = "...and %d more"
    L["PLAN_TOOLTIP_RECIPE_KNOWN"] = "Recipe: Known"
    L["PLAN_TOOLTIP_RECIPE_UNKNOWN"] = "Recipe: Unknown"
    L["PLAN_RECIPE_KNOWN_SUFFIX"] = " (Known)"

    L["PLAN_SOURCE_VENDOR"] = "Vendor"
    L["PLAN_SOURCE_GATHER"] = "Gather"
    L["PLAN_SOURCE_CRAFT"] = "Craft"
    L["PLAN_SOURCE_UNKNOWN"] = "Unknown"
    L["SETTINGS_TITLE"] = "Housing Addon Settings"
    L["SETTINGS_GENERAL_TAB"] = "General"
    L["SETTINGS_COMMUNITY_TAB"] = "Community"
    L["SETTINGS_MINIMAP_SECTION"] = "Minimap Button"
    L["SETTINGS_SHOW_MINIMAP_BUTTON"] = "Show Minimap Button"
    L["SETTINGS_UI_SCALE_SECTION"] = "UI Scale"
    L["SETTINGS_UI_SCALE"] = "UI Scale"
    L["SETTINGS_FONT_SIZE"] = "Font Size"
    L["SETTINGS_RESET"] = "Reset"
    L["SETTINGS_RESET_DEFAULTS"] = "Reset to Defaults"
    L["SETTINGS_PROGRESS_TRACKING"] = "Progress Tracking"
    L["SETTINGS_SHOW_COLLECTED"] = "Show Collected Items"
    L["SETTINGS_WAYPOINT_NAVIGATION"] = "Waypoint Navigation"
    L["SETTINGS_USE_PORTAL_NAVIGATION"] = "Use Smart Portal Navigation"
    L["TOOLTIP_SETTINGS"] = "Settings"
    L["TOOLTIP_SETTINGS_DESC"] = "Configure addon options"
    L["TOOLTIP_WAYPOINT"] = "Set Waypoint"
    L["TOOLTIP_WAYPOINT_DESC"] = "Navigate to this vendor"
    L["TOOLTIP_PORTAL_NAVIGATION_ENABLED"] = "Smart Portal Navigation Enabled"
    L["TOOLTIP_PORTAL_NAVIGATION_DESC"] = "Will automatically use the nearest portal when crossing zones"
    L["TOOLTIP_DIRECT_NAVIGATION"] = "Direct navigation enabled"
    L["TOOLTIP_DIRECT_NAVIGATION_DESC"] = "Waypoints will point directly to vendor locations (not recommended for cross-zone travel)"
    L["MESSAGE_PORTAL_NAV_ENABLED"] = "Smart portal navigation enabled. Waypoints will automatically use the nearest portal when crossing zones."
    L["MESSAGE_DIRECT_NAV_ENABLED"] = "Direct navigation enabled. Waypoints will point directly to vendor locations (not recommended for cross-zone travel)."
    L["COMMUNITY_TITLE"] = "Community & Support"
    L["COMMUNITY_INFO"] = "Join our community to share tips, report bugs, and suggest new features!"
    L["COMMUNITY_DISCORD"] = "Discord Server"
    L["COMMUNITY_GITHUB"] = "GitHub"
    L["COMMUNITY_REPORT_BUG"] = "Report Bug"
    L["COMMUNITY_SUGGEST_FEATURE"] = "Suggest Feature"
    L["PREVIEW_TITLE"] = "Item Preview"
    L["PREVIEW_NO_SELECTION"] = "Select an item to view details"
    L["STATUS_ITEMS_DISPLAYED"] = "%d items displayed (%d total)"
    L["ERROR_ADDON_NOT_INITIALIZED"] = "Housing addon not initialized"
    L["ERROR_UI_NOT_AVAILABLE"] = "HousingVendor UI not available"
    L["ERROR_CONFIG_PANEL_NOT_AVAILABLE"] = "Configuration panel not available"
    L["STATS_TITLE"] = "Statistics Dashboard"
    L["STATS_COLLECTION_PROGRESS"] = "Collection Progress"
    L["STATS_ITEMS_BY_SOURCE"] = "Items by Source"
    L["STATS_ITEMS_BY_FACTION"] = "Items by Faction"
    L["STATS_COLLECTION_BY_EXPANSION"] = "Collection by Expansion"
    L["STATS_COLLECTION_BY_CATEGORY"] = "Collection by Category"
    L["STATS_COMPLETE"] = "%d%% Complete - %d / %d items collected"
    L["FOOTER_COLOR_GUIDE"] = "Color Guide:"
    L["FOOTER_WAYPOINT_INSTRUCTION"] = "Click any item with %s to set waypoint"
    L["MAIN_SUBTITLE"] = "Housing Catalog"
    L["COMMON_FREE"] = "Free"
    L["COMMON_UNKNOWN"] = "Unknown"
    L["COMMON_NA"] = "N/A"
    L["COMMON_GOLD"] = "gold"
    L["COMMON_ITEM_ID"] = "Item ID:"
    L["COMMON_LOADING"] = "Loading..."
    L["MINIMAP_TOOLTIP"] = "Housing Vendor Browser"
    L["MINIMAP_TOOLTIP_DESC"] = "Left-click to toggle the Housing Vendor browser"
    L["MINIMAP_TOOLTIP_LEFTCLICK"] = "Left-click: open main window"
    L["MINIMAP_TOOLTIP_RIGHTCLICK"] = "Right-click: zone popup"
    L["MINIMAP_TOOLTIP_DRAG"] = "Drag: move button"
    L["BUTTON_ZONE_POPUP"] = "Zone Popup"
    L["BUTTON_MAIN_UI"] = "Main UI"
    L["SETTINGS_ZONE_POPUPS"] = "Zone Popups"
    L["SETTINGS_ZONE_POPUPS_DESC"] = "Show outstanding items popup when entering a new zone"
    L["OUTSTANDING_ITEMS_IN_ZONE"] = "Outstanding Items in Zone"
    L["OUTSTANDING_MAIN_UI_TOOLTIP_DESC"] = "Opens the main HousingVendor window filtered to this zone."
end

-- If a locale table exists but is missing newer keys, fall back to enUS for those keys.
do
    local en = HousingVendorLocales and HousingVendorLocales["enUS"] or nil
    if en and L and L ~= en then
        setmetatable(L, { __index = en })
    end
end

-- Make the localization table available via namespace and globally
ns.L = L
_G["HousingVendorL"] = L
