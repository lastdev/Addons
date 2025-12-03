local addonName, addon = ...;

local L = addon.L
addon.Achievements = addon.Achievements or {}

-- Add new entry for DF
addon.Achievements.HousingDF = {}

function InitializeHousingDF()
    local ACMList = { 
        "Dragonflight",
        false,
        {
            IgnoreCollapsedChainFilter = true,
            Tooltip = HousingUtilitiesReplacePlaceholderInText(L["Tt_UseMetaAchievementPlugin"], {HousingUtilitiesGetAchievementName(19458)})
        },
        {
            17773,
            19507,
            19719,
            17529,
            19458
        }

    }

    addon.Achievements.HousingDF = ACMList
end