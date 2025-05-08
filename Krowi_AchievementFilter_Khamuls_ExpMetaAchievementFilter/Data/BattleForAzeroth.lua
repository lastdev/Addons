local addonName, addon = ...;

local L = addon.L
addon.Achievements = addon.Achievements or {}

-- Add new entry for BfA
addon.Achievements.BfA = {}
addon.Achievements.BfAMetaAchievementId = 40953

function InitializeBfA()

    local factionSpecificAchievements = {
        { -- Alliance
            13925,
            13553,
            13710,
            12881,
            13297,
            12889,
            13305,
            12884,
            13308,
            12886,
            13310,
            12896,
            12898,
            12899,
            13283,
            13133,
            13762,
            13558,
            13710,
            13553,
            13759,
            13760,
            13758
        },
        { -- Horde
            13924,
            13700,
            13709,
            12873,
            13296,
            12876,
            13306,
            12878,
            13307,
            12879,
            13309,
            12867,
            12869,
            12870,
            13284,
            13135,
            13761,
            13559,
            13709,
            13700,
            13750,
            13756,
            13757
        }
    }

    local ACM_12807 = { -- Battle for Azeroth Dungeon Hero
        GetAchievementName(12807),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            12505,
            12484,
            12837,
            12841,
            12501,
            12832,
            12825,
            12845
        },
    }

    local ACM_40956 = { -- I'm On Island Time
        GetAchievementName(40956),
        false,
        {
            IgnoreFactionFilter = true
        },
        { -- Hot Tropic
            GetAchievementName(41202),
            false,
            {
                IgnoreFactionFilter = true
            },
            {
                12944,
                12851,
                12614,
                13020,
                12482,
                13036,
                13029,
                13038
            },
        },
        { -- Sound Off
            GetAchievementName(41205),
            false,
            {
                IgnoreFactionFilter = true
            },
            {
                12939,
                12852,
                13050,
                13057,
                13061,
                13058,
                13049
            },
        },
        { -- Bown Voyage
            GetAchievementName(41203),
            false,
            {
                IgnoreFactionFilter = true
            },
            {
                12942,
                12771,
                13024,
                13023,
                12588,
                13028,
                13022,
                13021
            },
        },
        { -- Songs of Storms
            GetAchievementName(41206),
            false,
            {
                IgnoreFactionFilter = true
            },
            {
                12940,
                12853,
                13047,
                13046,
                13051,
                13045,
                13062,
                13053
            },
        },
        { -- Dune Sqpad
            GetAchievementName(41204),
            false,
            {
                IgnoreFactionFilter = true
            },
            {
                12943,
                12849,
                13016,
                13018,
                13011,
                13009,
                13017,
                13437
            },
        },
        { -- When the Drust Settles
            GetAchievementName(41207),
            false,
            {
                IgnoreFactionFilter = true
            },
            {
                12941,
                12995,
                13087,
                13083,
                13064,
                13094,
                13082
            },
        },
        { -- Loremaster of Zandalar
            GetAchievementName(13294),
            false,
            {
                IgnoreFactionFilter  = true
            },
            {
                11861,
                12478,
                11868
            },
        },
        { -- Loremaster of Kul Tiras
            GetAchievementName(12593),
            false,
            {
                IgnoreFactionFilter  = true
            },
            {
                12473,
                12496,
                12497
            },
        },
        {
            41202,
            41205,
            41203,
            41206,
            41204,
            41207,
            12988,
            13144,
            13294,
            12593
        },
    }

    local ACM_40955 = { -- War Stories
        GetAchievementName(40955),
        false,
        {
            IgnoreFactionFilter  = true
        },
        { -- Two Sides to Every Tale
            GetAchievementName(13517),
            false,
            {
                IgnoreFactionFilter  = true
            },
            {
                AchievementShowDecider(13467, 13466, factionSpecificAchievements, "completedBeforeFaction"),
                AchievementShowDecider(12891, 12479, factionSpecificAchievements, "completedBeforeFaction")
            }
        },
        {
            12555,
            12582,
            13517,
            AchievementShowDecider(13924, 13925, factionSpecificAchievements, "completedBeforeFaction"),
            13263,
            12997,
            12719,
            13251,
            AchievementShowDecider(13700, 13553, factionSpecificAchievements, "completedBeforeFaction"),
            AchievementShowDecider(13709, 13710, factionSpecificAchievements, "completedBeforeFaction"),
            14157
        },
    }

    local ACM_13134 = { -- Expedition Leader
        GetAchievementName(13134),
        false,
        {
            IgnoreFactionFilter  = true
        },
        {
            13122,
            13126,
            13124,
            13132,
            12595,
            13125,
            13127,
            13128,
            AchievementShowDecider(13135, 13133, factionSpecificAchievements, "completedBeforeFaction")
        }
    }

    local ACM_40957 = { -- Maximum Effort
        GetAchievementName(40957),
        false,
        {
            IgnoreFactionFilter  = true
        },
        {
            AchievementShowDecider(12873, 12881, factionSpecificAchievements, "completedBeforeFaction"), -- War is Hell
            AchievementShowDecider(13296, 13297, factionSpecificAchievements, "completedBeforeFaction"), -- War for the Shore
            --AchievementShowDecider(12876, 12889, factionSpecificAchievements, "completedBeforeFaction"), -- Strike Fast
            --AchievementShowDecider(13306, 13305, factionSpecificAchievements, "completedBeforeFaction"), -- Night Moves
            --AchievementShowDecider(12878, 12884, factionSpecificAchievements, "completedBeforeFaction"), -- Leader of Troops
            --AchievementShowDecider(13307, 13308, factionSpecificAchievements, "completedBeforeFaction"), -- Recruitment Officee
            --AchievementShowDecider(12879, 12886, factionSpecificAchievements, "completedBeforeFaction"), -- Tour of War
            --AchievementShowDecider(13309, 13310, factionSpecificAchievements, "completedBeforeFaction"), -- Deforester/ By Natures Call
            12872,
            AchievementShowDecider(12867, 12896, factionSpecificAchievements, "completedBeforeFaction"), -- The Barrens
            AchievementShowDecider(12869, 12898, factionSpecificAchievements, "completedBeforeFaction"), -- Lordaeron
            AchievementShowDecider(12870, 12899, factionSpecificAchievements, "completedBeforeFaction"), -- Kalimdor
            AchievementShowDecider(13284, 13283, factionSpecificAchievements, "completedBeforeFaction") -- Frontline Warrior
        }
    }

    local ACM_13638 = { -- Undersea Usurper
        GetAchievementName(13638),
        false,
        {
            IgnoreFactionFilter  = true
        },
        {
            GetAchievementName(AchievementShowDecider(13761, 13762, factionSpecificAchievements, "completedBeforeFaction")),
            false,
            {
                IgnoreFactionFilter  = true
            },
            {
                AchievementShowDecider(13750, 13759, factionSpecificAchievements, "completedBeforeFaction"),
                AchievementShowDecider(13756, 13760, factionSpecificAchievements, "completedBeforeFaction"),
                AchievementShowDecider(13757, 13758, factionSpecificAchievements, "completedBeforeFaction")
            }
        },
        {
            13635,
            13690,
            13691,
            AchievementShowDecider(13761, 13762, factionSpecificAchievements, "completedBeforeFaction"),
            13549,
            13711,
            13722,
            13699,
            13713,
            13707,
            13763,
            13764,
            13712,
            AchievementShowDecider(13558, 13559, factionSpecificAchievements, "completedBeforeFaction"),
            13765,
            AchievementShowDecider(13709, 13710, factionSpecificAchievements, "completedBeforeFaction"),
            13836
        }
    }

    local ACM_13541 = { -- Mecha-Done
        GetAchievementName(13541),
        false,
        {
            IgnoreFactionFilter  = true
        },
        {
            AchievementShowDecider(13553, 13700, factionSpecificAchievements, "completedBeforeFaction"),
            13470,
            13556,
            13479,
            13477,
            13474,
            13513,
            13686,
            13791,
            13790
        }
    }

    local ACM_40959 = { --Black Empire State of Mind
        GetAchievementName(40959),
        false,
        {
            IgnoreFactionFilter = true
        },
        {
            14154,
            14153,
            14156,
            14155,
            14159,
            14158,
            14161
        }
    }

    local ACM_13994 = { -- Through the Depths of Visions
        GetAchievementName(13994),
        false,
        {
            IgnoreFactionFilter = true
        },
        {
            14066,
            14060,
            14067,
            14061
        }
    }

    local ACM_40958 = { -- Full Heart, Can't Lose
        GetAchievementName(40958),
        false,
        {
            IgnoreFactionFilter = true
        },
        {
            12918,
            13572,
            13771,
            13777
        }
    }

    local ACM_41209 = { -- Dressed to Kill: Battle for Azeroth
        GetAchievementName(41209),
        false,
        {
            IgnoreFactionFilter = true
        },
        ShowOnlyCompletedAchievementsWhenRequirementsAreMet(4, {
            12991,
            12993,
            13385,
            13433,
            13571,
            13585,
            14058,
            14059
        })
    }

    -- try to add a new category to the specials tab 
    local ACMList = { -- meta achievements overview
        GetAchievementName(40953, "BfA - "),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_12807, -- Battle for Azeroth Dungeon Hero
        ACM_40956, -- I'm On Island Time
        ACM_40955, -- War Stories
        ACM_13134, -- Expedition Leader
        ACM_40957, -- Maximum Effort
        ACM_13638, -- Undersea Usurper
        ACM_13541, -- Mecha-Done
        ACM_40959, --Black Empire State of Mind
        ACM_13994, -- Through the Depths of Visions
        ACM_40958, -- Full Heart, Can't Lose
        ACM_41209, -- Dressed to Kill: Battle for Azeroth
        {
            40960,
            40961,
            13414,
            40962,
            40963,
            12807,
            40956,
            40955,
            12947,
            13134,
            40957,
            13638,
            13541,
            40959,
            13994,
            40958,
            41209,
            14730
        }
    }

    addon.Achievements.BfA = ACMList
end