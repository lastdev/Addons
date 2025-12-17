-- English (US) Localization
if not HousingVendorLocales then
    HousingVendorLocales = {}
end

local L = {}

-- Main UI Strings
L["HOUSING_VENDOR_TITLE"] = "Housing Decor Locations"
L["HOUSING_VENDOR_SUBTITLE"] = "Browse all housing decorations from vendors across Azeroth"

-- Filter Labels
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
L["FILTER_ALL_EXPANSIONS"] = "All Expansions"
L["FILTER_ALL_VENDORS"] = "All Vendors"
L["FILTER_ALL_ZONES"] = "All Zones"
L["FILTER_ALL_TYPES"] = "All Types"
L["FILTER_ALL_CATEGORIES"] = "All Categories"
L["FILTER_ALL_SOURCES"] = "All Sources"
L["FILTER_ALL_FACTIONS"] = "All Factions"

-- Column Headers
L["COLUMN_ITEM"] = "Item"
L["COLUMN_ITEM_NAME"] = "Item Name"
L["COLUMN_SOURCE"] = "Source"
L["COLUMN_LOCATION"] = "Location"
L["COLUMN_PRICE"] = "Price"
L["COLUMN_COST"] = "Cost"
L["COLUMN_VENDOR"] = "Vendor"
L["COLUMN_TYPE"] = "Type"

-- Buttons
L["BUTTON_SETTINGS"] = "Settings"
L["BUTTON_STATISTICS"] = "Statistics"
L["BUTTON_BACK"] = "Back"
L["BUTTON_CLOSE"] = "Close"
L["BUTTON_WAYPOINT"] = "Set Waypoint"
L["BUTTON_SAVE"] = "Save"
L["BUTTON_RESET"] = "Reset"

-- Settings Panel
L["SETTINGS_TITLE"] = "HousingVendor Settings"
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

-- Tooltips
L["TOOLTIP_SETTINGS"] = "Settings"
L["TOOLTIP_SETTINGS_DESC"] = "Configure addon options"
L["TOOLTIP_WAYPOINT"] = "Set Waypoint"
L["TOOLTIP_WAYPOINT_DESC"] = "Navigate to this vendor"
L["TOOLTIP_PORTAL_NAVIGATION_ENABLED"] = "Smart Portal Navigation Enabled"
L["TOOLTIP_PORTAL_NAVIGATION_DESC"] = "Will automatically use the nearest portal when crossing zones"
L["TOOLTIP_DIRECT_NAVIGATION"] = "Direct navigation enabled"
L["TOOLTIP_DIRECT_NAVIGATION_DESC"] = "Waypoints will point directly to vendor locations (not recommended for cross-zone travel)"

-- Info Panel Tooltips
L["TOOLTIP_INFO_EXPANSION"] = "The World of Warcraft expansion this item is from"
L["TOOLTIP_INFO_FACTION"] = "Which faction can purchase this item from the vendor"
L["TOOLTIP_INFO_VENDOR"] = "NPC vendor who sells this item"
L["TOOLTIP_INFO_VENDOR_WITH_COORDS"] = "NPC vendor who sells this item\n\nLocation: %s\nCoordinates: %s"
L["TOOLTIP_INFO_ZONE"] = "Zone where this vendor is located"
L["TOOLTIP_INFO_ZONE_WITH_COORDS"] = "Zone where this vendor is located\n\nCoordinates: %s"
L["TOOLTIP_INFO_REPUTATION"] = "Reputation requirement to purchase this item from the vendor"
L["TOOLTIP_INFO_RENOWN"] = "Renown level required with a major faction to unlock this item"
L["TOOLTIP_INFO_PROFESSION"] = "The profession required to craft this item"
L["TOOLTIP_INFO_PROFESSION_SKILL"] = "Skill level required in this profession to craft the item"
L["TOOLTIP_INFO_PROFESSION_RECIPE"] = "The recipe or pattern name for crafting this item"
L["TOOLTIP_INFO_EVENT"] = "Special event or holiday when this item is available"
L["TOOLTIP_INFO_CLASS"] = "This item can only be used by this class"
L["TOOLTIP_INFO_RACE"] = "This item can only be used by this race"

-- Messages
L["MESSAGE_PORTAL_NAV_ENABLED"] = "Smart portal navigation enabled. Waypoints will automatically use the nearest portal when crossing zones."
L["MESSAGE_DIRECT_NAV_ENABLED"] = "Direct navigation enabled. Waypoints will point directly to vendor locations (not recommended for cross-zone travel)."

-- Community Section
L["COMMUNITY_TITLE"] = "Community & Support"
L["COMMUNITY_INFO"] = "Join our community to share tips, report bugs, and suggest new features!"
L["COMMUNITY_DISCORD"] = "Discord Server"
L["COMMUNITY_GITHUB"] = "GitHub"
L["COMMUNITY_REPORT_BUG"] = "Report Bug"
L["COMMUNITY_SUGGEST_FEATURE"] = "Suggest Feature"

-- Preview Panel
L["PREVIEW_TITLE"] = "Item Preview"
L["PREVIEW_NO_SELECTION"] = "Select an item to view details"

-- Status Bar
L["STATUS_ITEMS_DISPLAYED"] = "%d items displayed (%d total)"

-- Errors
L["ERROR_ADDON_NOT_INITIALIZED"] = "Housing addon not initialized"
L["ERROR_UI_NOT_AVAILABLE"] = "HousingVendor UI not available"
L["ERROR_CONFIG_PANEL_NOT_AVAILABLE"] = "Configuration panel not available"

-- Statistics UI
L["STATS_TITLE"] = "Statistics Dashboard"
L["STATS_COLLECTION_PROGRESS"] = "Collection Progress"
L["STATS_ITEMS_BY_SOURCE"] = "Items by Source"
L["STATS_ITEMS_BY_FACTION"] = "Items by Faction"
L["STATS_COLLECTION_BY_EXPANSION"] = "Collection by Expansion"
L["STATS_COLLECTION_BY_CATEGORY"] = "Collection by Category"
L["STATS_COMPLETE"] = "%d%% Complete - %d / %d items collected"

-- Footer
L["FOOTER_COLOR_GUIDE"] = "Color Guide:"
L["FOOTER_WAYPOINT_INSTRUCTION"] = "Click any item with %s to set waypoint"

-- Main UI
L["MAIN_SUBTITLE"] = "Housing Catalog"

-- Common Strings
L["COMMON_FREE"] = "Free"
L["COMMON_UNKNOWN"] = "Unknown"
L["COMMON_NA"] = "N/A"
L["COMMON_GOLD"] = "gold"
L["COMMON_ITEM_ID"] = "Item ID:"

-- Miscellaneous
L["MINIMAP_TOOLTIP"] = "Housing Vendor Browser"
L["MINIMAP_TOOLTIP_DESC"] = "Left-click to toggle the Housing Vendor browser"

-- Expansion Names
L["EXPANSION_CLASSIC"] = "Classic"
L["EXPANSION_THEBURNINGCRUSADE"] = "The Burning Crusade"
L["EXPANSION_WRATHOFTHELLICHKING"] = "Wrath of the Lich King"
L["EXPANSION_CATACLYSM"] = "Cataclysm"
L["EXPANSION_MISTSOFPANDARIA"] = "Mists of Pandaria"
L["EXPANSION_WARLORDSOF DRAENOR"] = "Warlords of Draenor"
L["EXPANSION_LEGION"] = "Legion"
L["EXPANSION_BATTLEFORAZEROTH"] = "Battle for Azeroth"
L["EXPANSION_SHADOWLANDS"] = "Shadowlands"
L["EXPANSION_DRAGONFLIGHT"] = "Dragonflight"
L["EXPANSION_THEWARWITHIN"] = "The War Within"
L["EXPANSION_MIDNIGHT"] = "Midnight"

-- Faction Names
L["FACTION_ALLIANCE"] = "Alliance"
L["FACTION_HORDE"] = "Horde"
L["FACTION_NEUTRAL"] = "Neutral"

-- Source Types
L["SOURCE_VENDOR"] = "Vendor"
L["SOURCE_ACHIEVEMENT"] = "Achievement"
L["SOURCE_QUEST"] = "Quest"
L["SOURCE_DROP"] = "Drop"
L["SOURCE_PROFESSION"] = "Profession"
L["SOURCE_REPUTATION"] = "Reputation"

-- Quality Names
L["QUALITY_POOR"] = "Poor"
L["QUALITY_COMMON"] = "Common"
L["QUALITY_UNCOMMON"] = "Uncommon"
L["QUALITY_RARE"] = "Rare"
L["QUALITY_EPIC"] = "Epic"
L["QUALITY_LEGENDARY"] = "Legendary"

-- Collection Status
L["COLLECTION_COLLECTED"] = "Collected"
L["COLLECTION_UNCOLLECTED"] = "Uncollected"

-- Requirement Types
L["REQUIREMENT_NONE"] = "None"
L["REQUIREMENT_ACHIEVEMENT"] = "Achievement"
L["REQUIREMENT_QUEST"] = "Quest"
L["REQUIREMENT_REPUTATION"] = "Reputation"
L["REQUIREMENT_RENOWN"] = "Renown"
L["REQUIREMENT_PROFESSION"] = "Profession"

-- Common Category/Type Names (add specific ones as needed)
L["CATEGORY_FURNITURE"] = "Furniture"
L["CATEGORY_DECORATIONS"] = "Decorations"
L["CATEGORY_LIGHTING"] = "Lighting"
L["CATEGORY_PLACEABLES"] = "Placeables"
L["CATEGORY_ACCESSORIES"] = "Accessories"
L["CATEGORY_RUGS"] = "Rugs"
L["CATEGORY_PLANTS"] = "Plants"
L["CATEGORY_PAINTINGS"] = "Paintings"
L["CATEGORY_BANNERS"] = "Banners"
L["CATEGORY_BOOKS"] = "Books"
L["CATEGORY_FOOD"] = "Food"
L["CATEGORY_TOYS"] = "Toys"

-- Type Names (item subtypes)
L["TYPE_CHAIR"] = "Chair"
L["TYPE_TABLE"] = "Table"
L["TYPE_BED"] = "Bed"
L["TYPE_LAMP"] = "Lamp"
L["TYPE_CANDLE"] = "Candle"
L["TYPE_RUG"] = "Rug"
L["TYPE_PAINTING"] = "Painting"
L["TYPE_BANNER"] = "Banner"
L["TYPE_PLANT"] = "Plant"
L["TYPE_BOOKSHELF"] = "Bookshelf"
L["TYPE_CHEST"] = "Chest"
L["TYPE_WEAPON_RACK"] = "Weapon Rack"

-- Filter Options
L["FILTER_HIDE_VISITED"] = "Hide Visited"
L["FILTER_ALL_QUALITIES"] = "All Qualities"
L["FILTER_ALL_REQUIREMENTS"] = "All Requirements"

-- UI Theme Names
L["THEME_MIDNIGHT"] = "Midnight"
L["THEME_ALLIANCE"] = "Alliance"
L["THEME_HORDE"] = "Horde"
L["THEME_SLEEK_BLACK"] = "Sleek Black"
L["SETTINGS_UI_THEME"] = "UI Theme"

-- Make the locale table globally available
HousingVendorLocales["enUS"] = L