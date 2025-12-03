local addonName, addon = ...;

local L = addon.L
addon.Achievements = addon.Achievements or {}

-- Add new entry for DF
addon.Achievements.HousingPvP = {}

function InitializeHousingPvP()
    local ACMList = { 
        "PvP",
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            1157,
            229,
            231,
            221,
            222,
            158,
            1153,
            212,
            213,
            200,
            167,
            5245
        }

    }

    addon.Achievements.HousingPvP = ACMList
end