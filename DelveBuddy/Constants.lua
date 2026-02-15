local DelveBuddy = LibStub("AceAddon-3.0"):GetAddon("DelveBuddy")

DelveBuddy.Zone = {
    -- TWW
    IsleOfDorn = 2248,
    Hallowfall = 2215,
    RingingDeeps = 2214,
    AzjKahet = 2255,
    Undermine = 2346,
    Karesh = 2371,
    -- Midnight
    EversongWoods = 2395,
    SilvermoonCity = 2393,
    IsleOfQuelDanas = 2424,
    Voidstorm = 2405,
    ZulAman = 2437,
    Harandar = 2413,
}

DelveBuddy.IDS = {
    Currency = {
        RestoredCofferKey = 3028,
        CofferKeyShard = 3310, -- Midnight only (in TWW it's an item)
    },
    Quest = {
        ShardsEarned = { 84736, 84737, 84738, 84739 },
        KeyEarned = { 91175, 91176, 91177, 91178 },
        BountyLooted = 86371,
    },
    Item = {
        BountyItem_Midnight = 252415,
        BountyItem_TWW = 248142,
        CofferKeyShard = 245653, -- TWW only (in Midnight it's a currency)
        RadiantEcho = 246771,
        DelveOBot7001 = 230850,
        NemesisLure_Midnight = 253342,
        NemesisLure_TWW = 248017,
    },
    Widget = {
        GildedStash = 6659,
    },
    Activity = {
        World = 6
    },
    Spell = {
        BountyBuff_TWW = { 1246363, },
        BountyBuff_Midnight = { 1254631, },
    },
    CONST = {
        UNKNOWN_GILDED_STASH_COUNT = -1,
        MAX_WEEKLY_GILDED_STASHES = 3,
        MAX_WEEKLY_SHARDS = 200,
        MAX_WEEKLY_KEYS = 4,
        MIN_BOUNTIFUL_DELVE_LEVEL = 80,
    },
}
