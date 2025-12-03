local DelveBuddy = LibStub("AceAddon-3.0"):GetAddon("DelveBuddy")

DelveBuddy.Zone = {
    IsleOfDorn = 2248,
    Hallowfall = 2215,
    RingingDeeps = 2214,
    AzjKahet = 2255,
    Undermine = 2346,
    Karesh = 2371,
}

DelveBuddy.IDS = {
    Currency = {
        RestoredCofferKey = 3028,
    },
    Quest = {
        ShardsEarned = { 84736, 84737, 84738, 84739 },
        KeyEarned = { 91175, 91176, 91177, 91178 },
        BountyLooted = 86371,
    },
    Item = {
        DelversBounty = 248142,
        CofferKeyShard = 245653,
        RadiantEcho = 246771,
        DelveOBot7001 = 230850,
        ShriekingQuartz = 248017,
    },
    Widget = {
        GildedStash = 6659,
    },
    Activity = {
        World = 6
    },
    Spell = {
        DelversBounty = { 453004, 473218 },
    },
    DelveMapToPoi = {
        [2269] = 7787, -- Earthcrawl Mines
        [2249] = 7779, -- Fungal Folly
        [2250] = 7781, -- Kriegval's Rest
        [2251] = 7782, -- The Waterworks
        [2310] = 7789, -- Skittering Breach
        [2302] = 7788, -- The Dread Pit
        [2396] = 8181, -- Excavation Site 9
        [2312] = 7780, -- Mycomancer Cavern
        [2277] = 7785, -- Nightfall Sanctum
        [2301] = 7783, -- The Sinkhole
        [2259] = 7784, -- Tak-Rethan Abyss
        [2299] = 7786, -- The Underkeep
        [2347] = 7790, -- The Spiral Weave
        [2420] = 8246, -- Sidestreet Sluice, The Pits
        [2421] = 8246, -- Sidestreet Sluice, The Low Decks
        [2422] = 8246, -- Sidestreet Sluice, The High Decks
        [2423] = 8246, -- Sidestreet Sluice, Entrance
        [2452] = 8273, -- Archival Assault
    },
    DelvePois = {
        [DelveBuddy.Zone.IsleOfDorn] = {
            { ["id"] = 7787, ["x"] = 38.60, ["y"] = 74.00, ["widgetID"] = 6723 }, -- Earthcrawl Mines
            { ["id"] = 7779, ["x"] = 52.03, ["y"] = 65.77, ["widgetID"] = 6728 }, -- Fungal Folly
            { ["id"] = 7781, ["x"] = 62.19, ["y"] = 42.70, ["widgetID"] = 6719 }, -- Kriegval's Rest
        },
        [DelveBuddy.Zone.RingingDeeps] = {
            { ["id"] = 7782, ["x"] = 42.15, ["y"] = 48.71, ["widgetID"] = 6720 }, -- The Waterworks
            { ["id"] = 7788, ["x"] = 70.20, ["y"] = 37.30, ["widgetID"] = 6724 }, -- The Dread Pit
            { ["id"] = 8181, ["x"] = 76.00, ["y"] = 96.50, ["widgetID"] = 6659 }, -- Excavation Site 9
        },
        [DelveBuddy.Zone.Hallowfall] = {
            { ["id"] = 7780, ["x"] = 71.30, ["y"] = 31.20, ["widgetID"] = 6729 }, -- Mycomancer Cavern
            { ["id"] = 7785, ["x"] = 34.32, ["y"] = 47.43, ["widgetID"] = 6727 }, -- Nightfall Sanctum
            { ["id"] = 7783, ["x"] = 50.60, ["y"] = 53.30, ["widgetID"] = 6721 }, -- The Sinkhole
            { ["id"] = 7789, ["x"] = 65.48, ["y"] = 61.74, ["widgetID"] = 6725 }, -- Skittering Breach
        },
        [DelveBuddy.Zone.AzjKahet] = {
            { ["id"] = 7790, ["x"] = 45.00, ["y"] = 19.00, ["widgetID"] = 6726 }, -- The Spiral Weave
            { ["id"] = 7784, ["x"] = 55.00, ["y"] = 73.92, ["widgetID"] = 6722 }, -- Tak-Rethan Abyss
            { ["id"] = 7786, ["x"] = 51.85, ["y"] = 88.30, ["widgetID"] = 6794 }, -- The Underkeep
        },
        [DelveBuddy.Zone.Undermine] = {
            { ["id"] = 8246, ["x"] = 35.20, ["y"] = 52.80, ["widgetID"] = 6718 }, -- Sidestreet Sluice
        },
        [DelveBuddy.Zone.Karesh] = {
            { ["id"] = 8273, ["x"] = 55.08, ["y"] = 48.08, ["widgetID"] = 7193 }, -- Archival Assault
        },
    },
    CONST = {
        UNKNOWN_GILDED_STASH_COUNT = -1,
        MAX_WEEKLY_GILDED_STASHES = 3,
        MAX_WEEKLY_SHARDS = 200,
        MAX_WEEKLY_KEYS = 4,
        MIN_BOUNTIFUL_DELVE_LEVEL = 80,
    },
}

DelveBuddy.TierToVaultiLvl = {
    [1] = 668,
    [2] = 671,
    [3] = 675,
    [4] = 678,
    [5] = 681,
    [6] = 688,
    [7] = 691,
    [8] = 694,
    [9] = 694,
    [10] = 694,
    [11] = 694,
}
