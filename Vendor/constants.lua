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
