local addonName, addon = ...;

local L = addon.L
addon.Achievements = addon.Achievements or {}

-- Add new entry for DF
addon.Achievements.HousingBfA = {}

function InitializeHousingBfA()
    local ACMList = { 
        "Battle for Azeroth",
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            19719,
            17529,
            12582,
            13284,
            12614,
            13039,
            13038,
            12509,
            13049,
            12997,
            12479,
            12733,
            12746,
            13723,
            13473,
            13018,
            13477,
            13475,
            12869,
            12870,
            12867
        }

    }

    addon.Achievements.HousingBfA = ACMList
end