local addonName, addon = ...;

local L = addon.L
addon.Achievements = addon.Achievements or {}

-- Add new entry for SL
addon.Achievements.DF = {}
addon.Achievements.DFMetaAchievementId = 19458

function InitializeDF()

    local ACM_16339 = { -- Myths of the Dragonflight Dungeons
        GetAchievementName(16339),
        false,
        {
            16271,
            16257,
            16262,
            16265,
            16268,
            16274,
            16277,
            16280
        }
    }

    local ACM_16585 = { -- Loremaster of the Dragon Isles
        GetAchievementName(16585),
        false,
        {
            16334,
            16401,
            15394,
            16405,
            16336,
            16428,
            16363,
            16398
        }
    }

    local ACM_19463 = { -- Dragon Quests
        GetAchievementName(19463),
        false,
        {
            17773,
            17734,
            18958,
            17546,
            16683,
            19507
        }
    }

    local ACM_19466 = { -- Oh My God, They Were Clutchmates
        GetAchievementName(19466),
        false,
        {
            41174,
            41180,
            16529,
            41182,
            17763,
            41177,
            18615,
            16494,
            16760,
            16539,
            16537,
            17427
        }
    }

    local ACM_19307 = { -- Dragon Isles Pathfinder
        GetAchievementName(19307),
        false,
        {
            16334,
            15394,
            16336,
            16363,
            17739,
            16761,
            17766,
            19309
        }
    }

    local ACM_19486 = { -- Accross the Isles
        GetAchievementName(19486),
        false,
        {
            GetAchievementName(19479),
            true,
            {
                16570,
                16587,
                15890,
                16676,
                16568,
                16588,
                16571,
                16297
            }
        },
        {
            GetAchievementName(19481),
            false,
            {
                16540,
                16545,
                16543,
                16677,
                16541,
                16542,
                16424,
                16299
            }
        },
        {
            GetAchievementName(19482),
            false,
            {
                16443,
                16444,
                16317,
                16553,
                16563,
                16580,
                16678,
                16300
            }
        },
        {
            GetAchievementName(19483),
            false,
            {
                16411,
                16412,
                16495,
                18384,
                18383,
                16301,
                16410,
                16497,
                16496,
                17782,
                16679
            }
        },
        {
            GetAchievementName(19485),
            false,
            {
                17342,
                18635,
                18637,
                18636,
                18638,
                18639,
                18640,
                18641,
                18703,
                18704
            }
        },
        {
            GetAchievementName(16492),
            false,
            {
                GetAchievementName(16490),
                false,
                {
                    GetAchievementName(16468),
                    false,
                    {
                        16463,
                        16465,
                        16466,
                        16467
                    }
                },
                {
                    GetAchievementName(16476),
                    false,
                    {
                        16475,
                        16478,
                        16477,
                        16479
                    }
                },
                {
                    GetAchievementName(16484),
                    false,
                    {
                        16480,
                        16481,
                        16482,
                        16483
                    }
                },
                {
                    GetAchievementName(16489),
                    false,
                    {
                        16485,
                        16486,
                        16487,
                        16488
                    }
                },
                {
                    16468,
                    16476,
                    16484,
                    16489
                }
            },
            {
                16490,
                16461,
                16500,
                16502
            }
        },
        {
            19479,
            19481,
            19482,
            19483,
            19485,
            16492,
            18209,
            18867,
            19008
        }
    }

    local ACM_17543 = { -- You Know How to Reach Me
        GetAchievementName(17543),
        false,
        {
            17534,
            17526,
            17528,
            17525,
            17529,
            17530,
            17532,
            17540,
            17413,
            17509,
            17315
        }
    }

    local ACM_17785 = { --Que Zara(lek), Zara(lek)
        GetAchievementName(17785),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            17739,
            17783,
            17781,
            17766,
            17763,
            47786,
            17832
        }
    }

    local ACM_19318 = { -- Dream On
        GetAchievementName(19318),
        false,
        {
            19026,
            19316,
            19317,
            19013,
            19309,
            19312
        }
    }

    local ACM_19478 = { -- Now THIS is Dragon Racing!
        GetAchievementName(19478),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            15939,
            17492,
            16575,
            16577,
            17411,
            19306,
            17294,
            19118,
            16576,
            16578,
            18150
        }
    }

    local ACMList = { -- meta achievements overview
        GetAchievementName(19458, "DF - "),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_16339, -- Myths of the Dragonflight Dungeons
        ACM_16585, -- Loremaster of the Dragon Isles
        ACM_19463, -- Dragon Quests
        ACM_19466, -- Oh My God, They Were Clutchmates
        ACM_19307, -- Dragon Isles Pathfinder
        ACM_19486, -- Accross the Isles
        ACM_17543, -- You Know How to Reach Me
        ACM_17785, -- Que Zara(lek), Zara(lek)
        ACM_19318, -- Dream On
        ACM_19478, -- Now THIS is Dragon Racing!
        {
            16343,
            18160,
            19331,
            16339,
            16585,
            16808,
            19463,
            19466,
            19307,
            19486,
            17543,
            17785,
            19318,
            19478
        }
    }

    addon.Achievements.DF = ACMList
end