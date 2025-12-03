local addonName, addon = ...;

local L = addon.L
addon.Achievements = addon.Achievements or {}

-- Add new entry for DF
addon.Achievements.HousingLegacy = {}

function InitializeHousingLegacy()
    local ACMList = { 
        "Legacy Expansions",
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            5223,
            6981,
            5442,
            940,
            938,
            4859,
            7322,
            11124,
            10698,
            11257,
            11258,
            4405,
            10996,
            8316,
            42289,
            42291,
            42298,
            42287,
            42296,
            42292,
            42294,
            42293,
            42290,
            42297,
            42295,
            42288,
            60967,
            60972,
            60964,
            60962,
            60963,
            60971,
            60969,
            60968,
            60966,
            60970,
            60965,
            60981,
            60992,
            60991,
            60983,
            60982,
            60989,
            60985,
            60990,
            60988,
            60987,
            60986,
            60984,
            42274,
            42282,
            42270,
            42280,
            42275,
            42277,
            42276,
            42273,
            42281,
            42271
        }

    }

    addon.Achievements.HousingLegacy = ACMList
end