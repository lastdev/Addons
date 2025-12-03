local addonName, addon = ...;

local L = addon.L
addon.Achievements = addon.Achievements or {}

-- Add new entry for TWW
addon.Achievements.HousingTWW = {}

function InitializeHousingTWW()
    local ACMList = { 
        "The War Within",
        false,
        {
            IgnoreCollapsedChainFilter = true,
            Tooltip = HousingUtilitiesReplacePlaceholderInText(L["Tt_UseMetaAchievementPlugin"], {HousingUtilitiesGetAchievementName(61451)})
        },
        {
            40504,
            40859,
            40210,
            19408,
            61467,
            61451,
            20595
        }

    }

    addon.Achievements.HousingTWW = ACMList
end