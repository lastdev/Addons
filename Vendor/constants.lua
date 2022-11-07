-- Define all constants here
-- This will not trigger loc loading because we have not defined the Default Locale yet
local AddonName, Addon = ...

-- Skeleton Constants
Addon.c_DefaultLocale = "enUS"
Addon.c_PrintColorCode = ORANGE_FONT_COLOR_CODE
Addon.c_APIMethodColorCode = YELLOW_FONT_COLOR_CODE
Addon.c_ThrottleTime = .15
Addon.c_PruneHistoryDelay = 30  -- Time in seconds after intializing addon before prune history is run
Addon.c_HoursToKeepHistory = 30*24 -- 30*24 = max blizzard item restoration window

-- Addon Constants
Addon.c_BuybackLimit = 12
Addon.c_DeleteThottle = 3
Addon.c_ItemSellerThreadName = "ItemSeller"

-- Config Constants
Addon.c_Config_AutoSell = "autosell"
Addon.c_Config_Tooltip = "tooltip_basic"
Addon.c_Config_Tooltip_Rule = "tooltip_addrule"
Addon.c_Config_SellLimit = "autosell_limit"
Addon.c_Config_MaxSellItems = "max_items_to_sell"
Addon.c_Config_SellThrottle = "sell_throttle"
Addon.c_Config_ThrottleTime = "throttle_time"
Addon.c_Config_AutoRepair = "autorepair"
Addon.c_Config_GuildRepair = "guildrepair"
Addon.c_Config_Minimap = "showminimap"
Addon.c_Config_MerchantButton = "merchantbutton"

-- Merchant button
Addon.MerchantButton = {
    NEVER = 0,
    ALWAYS = 1,
    AUTO = 2
}

-- Rule Types
Addon.RuleType = {
    SELL = "Sell",
    KEEP = "Keep",
    DESTROY  = "Destroy",
    HIDDEN = "-Hidden-",
}

-- Action Types
Addon.ActionType = {
    SELL = 1,
    DESTROY = 2,
}

Addon.ListType = {
    SELL = "sell",
    KEEP = "keep",
    DESTROY = "destroy",
    CUSTOM = "custom",
    EXTENSION = "extension"
}

Addon.SystemListId = {
    NEVER = "system:never-sell",
    ALWAYS = "system:always-sell",
    DESTROY = "system:always-destroy",
}

Addon.Events = {
    AUTO_SELL_START = "auto-sell-start",
    AUTO_SELL_COMPLETE = "auto-sell-end",
    AUTO_SELL_ITEM = "auto-sell-item",
    PROFILE_CHANGED = "profile-changed",
}

-- Blizzard Color Codes that are not in all versions
-- We create local versions so we can still use these colors regardless of game version.
Addon.COMMON_GRAY_COLOR		    = CreateColor(0.65882,	0.65882,	0.65882);
Addon.UNCOMMON_GREEN_COLOR	    = CreateColor(0.08235,	0.70196,	0.0);
Addon.RARE_BLUE_COLOR			= CreateColor(0.0,		0.56863,	0.94902);
Addon.EPIC_PURPLE_COLOR		    = CreateColor(0.78431,	0.27059,	0.98039);
Addon.LEGENDARY_ORANGE_COLOR	= CreateColor(1.0,		0.50196,	0.0);
Addon.ARTIFACT_GOLD_COLOR		= CreateColor(0.90196,	0.8,		0.50196);
Addon.HEIRLOOM_BLUE_COLOR		= CreateColor(0.0,		0.8,		1);
