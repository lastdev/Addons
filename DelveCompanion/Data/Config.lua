local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

--- Table containing external parameters used by the addon, such as game entity IDs, Delves parameters, limits, etc.
---@class Config
local Config = {}
DelveCompanion.Config = Config

---@type integer Delves have been introduced in TWW. It's used in different frames to display relevant content depending on the selected expansion.
Config.DELVES_MIN_EXPANSION = LE_EXPANSION_WAR_WITHIN

--#region Save Data

--- Account Save Data scheme
---@class (exact) DelveCompanionAccountData
---@field delveProgressWidgetsEnabled boolean
---@field trackingType WaypointTrackingType
Config.DEFAULT_ACCOUNT_DATA = {
    delveProgressWidgetsEnabled = true,
    trackingType = DelveCompanion.Definitions.WaypointTrackingType.superTrack
}

--- Character Save Data
---@class (exact) DelveCompanionCharacterData
---@field gvDetailsEnabled boolean
---@field displayCompanionConfig boolean
---@field companionConfigLayout CompanionWidgetLayout
---@field keysCapTooltipEnabled boolean
---@field dashOverviewEnabled boolean
Config.DEFAULT_CHARACTER_DATA = {
    gvDetailsEnabled = true,
    displayCompanionConfig = true,
    companionConfigLayout = 1,
    keysCapTooltipEnabled = true,
    dashOverviewEnabled = true
}
--#endregion

---@type integer Item ID of [Delve-O-Bot 7001](https://www.wowhead.com/item=230850/delve-o-bot-7001).
Config.DELVE_O_BOT_ITEM_CODE = 230850

--#region Great Vault

---@type integer Delves' Activity ID to retrieve Great Vault rewards state.
Config.ACTIVITY_TYPE = Enum.WeeklyRewardChestThresholdType.World
---@type integer Max tier of the Delve which upgrades Great Vault rewards.
Config.GREAT_VAULT_UPGRADE_MAX_TIER = 8
---@type integer Item ID of [Bountiful Coffer](https://www.wowhead.com/item=228942/bountiful-coffer).
Config.BOUNTIFUL_COFFER_ITEM_CODE = 228942
--#endregion

--#region Restored Coffer Key

---@type integer Currency ID of [Restored Coffer Key](https://www.wowhead.com/currency=3028/restored-coffer-key).
Config.BOUNTIFUL_KEY_CURRENCY_CODE = 3028
---@type integer Currency ID of [Coffer Key Shards](https://www.wowhead.com/currency=3310/coffer-key-shards).
Config.KEY_SHARDS_CURRENCY_CODE = 3310

---@type integer Amount of [Coffer Key Shards](https://www.wowhead.com/item=236096/coffer-key-shard) required to assemble [Restored Coffer Key](https://www.wowhead.com/currency=3028/restored-coffer-key).
Config.SHARDS_FOR_KEY = 100
---@type integer Amount of [Coffer Key Shards](https://www.wowhead.com/item=236096/coffer-key-shard) player gets from a Cache like [Pinnacle Cache](https://www.wowhead.com/item=239118/pinnacle-cache).
Config.KEY_SHARDS_PER_CACHE = 50

---@type table<integer, number> Table of Quest IDs used to track [Restored Coffer Keys](https://www.wowhead.com/currency=3028/restored-coffer-key) player has received from Caches this week.
Config.BOUNTIFUL_KEY_QUESTS_DATA = {
    91175,
    91176,
    91177,
    91178
}
---@type table<integer, number> Table of Caches containing [Restored Coffer Keys](https://www.wowhead.com/currency=3028/restored-coffer-key) (e.g. [Pinnacle Cache](https://www.wowhead.com/item=239118/pinnacle-cache)).
Config.BOUNTIFUL_KEY_SOURCE_CACHES_DATA = {
    -- TWW Season 3
    244842,
    244865,
    245611,
    255676
}
---@type table<integer, number> Table of Quest IDs used to track [Coffer Key Shards](https://www.wowhead.com/item=245653/coffer-key-shard) player has received from Caches this week.
Config.KEY_SHARD_QUESTS_DATA = {
    84736,
    84737,
    84738,
    84739
}
---@type table<integer, number> Table of Caches containing [Coffer Key Shards](https://www.wowhead.com/item=245653/coffer-key-shard).
Config.KEY_SHARD_SOURCE_CACHES_DATA = {
    -- TWW Season 1
    226263,
    226273,
    226264,
    224784,
    225571,
    225572,
    225573,
    228361,
    -- TWW Season 2
    239128,
    239121,
    239126,
    239125,
    239118,
    239122,
    239124,
    238208,
    235639,
    235610,
    239120,
    -- TWW Season 3
    244883,
    244865,
    245280,
    250768,
    250766,
    250765,
    250769,
    250763,
    250764,
    250767,
    -- Others
    233014
}
--#endregion

---@type integer Currency ID of [Untainted Mana-Crystals](https://www.wowhead.com/currency=3356/untainted-mana-crystals).
Config.MANA_CRYSTALS_CURRENCY_CODE = 3356

--#region Bounty Map.

---@type table<integer, number> Item ID of Bounty Map.
Config.BOUNTY_MAPS = {
    [LE_EXPANSION_WAR_WITHIN] = 248142,
    [LE_EXPANSION_MIDNIGHT] = 252415
}

---@type integer Weekly cap of maps (par character).
Config.BOUNTY_MAP_MAX_PER_WEEK = 1
---@type integer Quest ID used to track whether player has looted Bounty Map during the week.
Config.BOUNTY_MAP_QUEST = 86371
--#endregion

--#region Gilded Stash

---@type integer Spell ID of [Gilded Stash](https://www.wowhead.com/spell=1216211/gilded-stash).
Config.GILDED_STASH_SPELL_CODE = 1216211
---@type integer [Gilded Stash](https://www.wowhead.com/spell=1216211/gilded-stash) player can open per week.
Config.GILDED_STASH_WEEKLY_CAP = 3
--#endregion

--#region Delve-related entities which are updated every season

-- TODO: Remove or use for TWW widget if still available
---@type integer Item ID of [Radiant Echo](https://www.wowhead.com/item=246771/radiant-echo).
Config.ECHO_ITEM_CODE = 246771

-- TODO: Remove or use for TWW widget if still available
---@type integer Item ID of [Coffer Key Shard](https://www.wowhead.com/item=245653/coffer-key-shard).
Config.KEY_SHARD_ITEM_CODE = 245653
--#endregion

--#region Seasonal modifiers

---@type table<table<number, number>> Spell ID of Delve affixes.
Config.AFFIXES = {
    -- [Nemesis Strongbox](https://www.wowhead.com/spell=1239535/nemesis-strongbox).
    NEMESIS = {
        [LE_EXPANSION_WAR_WITHIN] = 1239535,
        [LE_EXPANSION_MIDNIGHT] = 1270179
    }
}
--#endregion

---@type table<integer, number> Quest ID required to unlock Companions.
Config.COMPANION_UNLOCK_QUEST = {
    [LE_EXPANSION_WAR_WITHIN] = 78464,
    [LE_EXPANSION_MIDNIGHT] = 86636
}

--#region Delves data

---@type integer Khaz Algar [uiMapID](https://warcraft.wiki.gg/wiki/UiMapID).
Config.KHAZ_ALGAR_MAP_ID = 2274

---@type table<integer, number[]> List of [uiMapIDs](https://warcraft.wiki.gg/wiki/UiMapID) which contain Delves.
--- Grouped by LE_EXPANSION enum. Controls display order of zones in the list.
Config.DELVE_MAPS = {
    [LE_EXPANSION_WAR_WITHIN] = {
        2371, -- K`aresh
        2346, -- Undermine
        2248, -- Isle of Dorn
        2214, -- The Ringing Deeps
        2215, -- Hallowfall
        2255, -- Azj-Kahet
    },
    [LE_EXPANSION_MIDNIGHT] = {
        2405, -- Voidstorm
        2413, -- Harandar
        2437, -- Zul'Aman
        2395, -- Eversong Woods
        2393, -- Silvermoon City
        2424, -- Isle of Quel'Danas
    }
}

--- Table with Delve parameters.
---@class (exact) DelveConfig
---@field uiMapID number Delve [uiMapID](https://warcraft.wiki.gg/wiki/UiMapID).
---@field poiIDs {regular: number, bountiful: number?} Delve [areaPoiIDs](https://wago.tools/db2/areapoi).
---@field gildedStashUiWidgetID number? [UiWidgetID](https://wago.tools/db2/UiWidget) used to retrieve information about [Gilded Stash](https://www.wowhead.com/spell=1216211/gilded-stash) weekly progress.
---@field atlasBgID string [AtlasID](https://warcraft.wiki.gg/wiki/AtlasID) used to get Delve's background texture. These are grouped into separate atlases for major patches.
---@field achievements {chest: number, story: number}? Achievement IDs related to the Delve.
---@field coordinates MapCoord? Delve entrance coordinates. Used primarly for Boss Delves and non-Blizzard waypoints (e.g. TomTom).

---@type table<integer, DelveConfig[]> Table of all Delves in the game and their parameters. Grouped by LE_EXPANSION enum.
Config.DELVES_CONFIG = {
    [LE_EXPANSION_WAR_WITHIN] = {
        -- Earthcrawl Mines
        {
            uiMapID = 2269,
            poiIDs = {
                regular = 7863,
                bountiful = 7787
            },
            gildedStashUiWidgetID = 6723,
            atlasBgID = "delve-entrance-background-earthcrawl-mines",
            achievements = {
                chest = 40806,
                story = 40527
            }
        },
        -- Fungal Folly
        {
            uiMapID = 2249,
            poiIDs = {
                regular = 7864,
                bountiful = 7779
            },
            gildedStashUiWidgetID = 6728,
            atlasBgID = "delve-entrance-background-fungal-folly",
            achievements = {
                chest = 40803,
                story = 40525
            }
        },
        -- Kriegval's Rest
        {
            uiMapID = 2250,
            poiIDs = {
                regular = 7865,
                bountiful = 7781
            },
            gildedStashUiWidgetID = 6719,
            atlasBgID = "delve-entrance-background-kriegvals-rest",
            achievements = {
                chest = 40807,
                story = 40526
            }
        },
        -- The Waterworks
        {
            uiMapID = 2251,
            poiIDs = {
                regular = 7866,
                bountiful = 7782
            },
            gildedStashUiWidgetID = 6720,
            atlasBgID = "delve-entrance-background-the-waterworks",
            achievements = {
                chest = 40816,
                story = 40528
            }
        },
        -- The Dread Pit
        {
            uiMapID = 2302,
            poiIDs = {
                regular = 7867,
                bountiful = 7788
            },
            gildedStashUiWidgetID = 6724,
            atlasBgID = "delve-entrance-background-the-dread-pit",
            achievements = {
                chest = 40812,
                story = 40529
            }
        },
        -- Excavation Site 9
        {
            uiMapID = 2396,
            poiIDs = {
                regular = 8143,
                bountiful = 8181
            },
            gildedStashUiWidgetID = 6659,
            atlasBgID = "delve-entrance-background-the-undermine",
            achievements = {
                chest = 41100,
                story = 41098
            }
        },
        -- The Sinkhole
        {
            uiMapID = 2300,
            poiIDs = {
                regular = 7870,
                bountiful = 7783
            },
            gildedStashUiWidgetID = 6721,
            atlasBgID = "delve-entrance-background-the-sinkhole",
            achievements = {
                chest = 40813,
                story = 40532
            }
        },
        -- Nightfall Sanctum
        {
            uiMapID = 2277,
            poiIDs = {
                regular = 7868,
                bountiful = 7785
            },
            gildedStashUiWidgetID = 6727,
            atlasBgID = "delve-entrance-background-nightfall-sanctum",
            achievements = {
                chest = 40809,
                story = 40530
            }
        },
        -- Mycomancer Cavern
        {
            uiMapID = 2312,
            poiIDs = {
                regular = 7869,
                bountiful = 7780
            },
            gildedStashUiWidgetID = 6729,
            atlasBgID = "delve-entrance-background-mycomancer-cavern",
            achievements = {
                chest = 40808,
                story = 40531
            }
        },
        -- Skittering Breach
        {
            uiMapID = 2310,
            poiIDs = {
                regular = 7871,
                bountiful = 7789
            },
            gildedStashUiWidgetID = 6725,
            atlasBgID = "delve-entrance-background-skittering-breach",
            achievements = {
                chest = 40810,
                story = 40533
            }
        },
        -- The Spiral Weave
        {
            uiMapID = 2313,
            poiIDs = {
                regular = 7874,
                bountiful = 7790
            },
            gildedStashUiWidgetID = 6726,
            atlasBgID = "delve-entrance-background-the-spiral-weave",
            achievements = {
                chest = 40814,
                story = 40536
            }
        },
        -- The Underkeep
        {
            uiMapID = 2299,
            poiIDs = {
                regular = 7872,
                bountiful = 7786
            },
            gildedStashUiWidgetID = 6794,
            atlasBgID = "delve-entrance-background-the-underkeep",
            achievements = {
                chest = 40815,
                story = 40534
            }
        },
        -- Tak-Rethan Abyss
        {
            uiMapID = 2259,
            poiIDs = {
                regular = 7873,
                bountiful = 7784
            },
            gildedStashUiWidgetID = 6722,
            atlasBgID = "delve-entrance-background-tak-rethan-abyss",
            achievements = {
                chest = 40811,
                story = 40535
            }
        },
        -- Sidestreet Sluice
        {
            uiMapID = 2420,
            poiIDs = {
                regular = 8140,
                bountiful = 8246
            },
            gildedStashUiWidgetID = 6718,
            atlasBgID = "delves-entrance-background-sewers",
            achievements = {
                chest = 41101,
                story = 41099
            }
        },
        -- Demolition Dome
        {
            uiMapID = 2425,
            poiIDs = {
                regular = 8142
            },
            coordinates = {
                x = 50.43,
                y = 11.82
            },
            atlasBgID = "delve-entrance-background-goblin-boss"
        },
        -- Zekvir's Lair
        {
            uiMapID = 2348,
            poiIDs = {
                regular = 7875
            },
            coordinates = {
                x = 32.74,
                y = 76.87
            },
            atlasBgID = "delve-entrance-background-zekvirs-lair"
        },
        -- Archival Assault
        {
            uiMapID = 2452,
            poiIDs = {
                regular = 8274,
                bountiful = 8273
            },
            gildedStashUiWidgetID = 7193,
            atlasBgID = "delve-entrance-background-Archival-Assault",
            achievements = {
                chest = 42679,
                story = 42771
            }
        },
        -- Voidrazor Sanctuary
        {
            uiMapID = 2484,
            poiIDs = {
                regular = 8323
            },
            coordinates = {
                x = 64.34,
                y = 78.62
            },
            atlasBgID = "delve-entrance-background-Voidrazor-Sanctuary"
        }
    },
    [LE_EXPANSION_MIDNIGHT] = {
        -- Gulf of Memory
        {
            uiMapID = 2505,
            poiIDs = {
                regular = 8435,
                bountiful = 8436
            },
            gildedStashUiWidgetID = 6723,
            atlasBgID = "delve-entrance-background-gulf-of-memory",
            achievements = {
                chest = 61898,
                story = 61731
            }
        },
        -- Parhelion Plaza
        {
            uiMapID = 2545,
            poiIDs = {
                regular = 8427,
                bountiful = 8428
            },
            gildedStashUiWidgetID = 6723,
            atlasBgID = "delve-entrance-background-parhelion-plaza",
            achievements = {
                chest = 61893,
                story = 61725
            }
        },
        -- Atal'Aman
        {
            uiMapID = 2535,
            poiIDs = {
                regular = 8443,
                bountiful = 8444
            },
            gildedStashUiWidgetID = 6723,
            atlasBgID = "delve-entrance-background-atal-aman",
            achievements = {
                chest = 61863,
                story = 61729
            }
        },
        -- Collegiate Calamity
        {
            uiMapID = 2577,
            poiIDs = {
                regular = 8425,
                bountiful = 8426
            },
            gildedStashUiWidgetID = 6723,
            atlasBgID = "delve-entrance-background-collegiate-calamity",
            achievements = {
                chest = 61894,
                story = 61726
            }
        },
        -- Shadowguard Point
        {
            uiMapID = 2506,
            poiIDs = {
                regular = 8431,
                bountiful = 8432
            },
            gildedStashUiWidgetID = 6723,
            atlasBgID = "delve-entrance-background-shadowguard-point",
            achievements = {
                chest = 61900,
                story = 61733
            }
        },
        -- The Grudge Pit
        {
            uiMapID = 2510,
            poiIDs = {
                regular = 8433,
                bountiful = 8434
            },
            gildedStashUiWidgetID = 6723,
            atlasBgID = "delve-entrance-background-the-grudge-pit",
            achievements = {
                chest = 61897,
                story = 61724
            }
        },
        -- Twilight Crypts
        {
            uiMapID = 2503,
            poiIDs = {
                regular = 8441,
                bountiful = 8442
            },
            gildedStashUiWidgetID = 6723,
            atlasBgID = "delve-entrance-background-twilight-crypts",
            achievements = {
                chest = 61896,
                story = 61730
            }
        },
        -- Shadow Enclave
        {
            uiMapID = 2502,
            poiIDs = {
                regular = 8437,
                bountiful = 8438
            },
            gildedStashUiWidgetID = 6723,
            atlasBgID = "delve-entrance-background-the-shadow-enclave",
            achievements = {
                chest = 61892,
                story = 61727
            }
        },
        -- The Darkway
        {
            uiMapID = 2525,
            poiIDs = {
                regular = 8439,
                bountiful = 8440
            },
            gildedStashUiWidgetID = 6723,
            atlasBgID = "delve-entrance-background-the-darkway",
            achievements = {
                chest = 61895,
                story = 61728
            }
        },
        -- Sunkiller Sanctum
        {
            uiMapID = 2528,
            poiIDs = {
                regular = 8429,
                bountiful = 8430
            },
            gildedStashUiWidgetID = 6723,
            atlasBgID = "delve-entrance-background-sunkiller-sanctum",
            achievements = {
                chest = 61899,
                story = 61732
            }
        },
        -- Torment's Rise
        {
            uiMapID = 2507,
            poiIDs = {
                regular = 8445
            },
            coordinates = {
                x = 61.17,
                y = 71.6
            },
            atlasBgID = "delve-entrance-background-torments-rise"
        },
    }
}

-- TODO: REWORK LOOT INFO
--- Table with Delve Loot information
---@class DelveLootInfo
---@field bountifulLvl integer Item Level player gets opening [Bountiful Coffer](https://www.wowhead.com/item=228942/bountiful-coffer).
---@field vaultLvl integer Item Level player gets from the Great Vault completing the corresponding Delve Tier.

--- Indexed table of Delves Loot information (index = Tier).
---@type DelveLootInfo[]
Config.DELVES_LOOT_INFO_DATA = {
    [1] = {
        bountifulLvl = 655,
        vaultLvl = 668
    },
    [2] = {
        bountifulLvl = 658,
        vaultLvl = 668
    },
    [3] = {
        bountifulLvl = 662,
        vaultLvl = 671
    },
    [4] = {
        bountifulLvl = 665,
        vaultLvl = 681
    },
    [5] = {
        bountifulLvl = 668,
        vaultLvl = 688
    },
    [6] = {
        bountifulLvl = 671,
        vaultLvl = 691
    },
    [7] = {
        bountifulLvl = 681,
        vaultLvl = 691
    },
    [8] = {
        bountifulLvl = 684,
        vaultLvl = 694
    },
    [9] = {
        bountifulLvl = 684,
        vaultLvl = 694
    },
    [10] = {
        bountifulLvl = 684,
        vaultLvl = 694
    },
    [11] = {
        bountifulLvl = 684,
        vaultLvl = 694
    }
}
--#endregion
