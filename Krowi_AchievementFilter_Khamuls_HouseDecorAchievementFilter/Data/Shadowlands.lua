local addonName, addon = ...;

local L = addon.L
addon.Achievements = addon.Achievements or {}

-- Add new entry for SL
addon.Achievements.HousingSL = {}

function InitializeHousingSL()
    local ACMList = { 
        "Shadowlands",
        false,
        {
            IgnoreCollapsedChainFilter = true,
            Tooltip = HousingUtilitiesReplacePlaceholderInText(L["Tt_UseMetaAchievementPlugin"], {HousingUtilitiesGetAchievementName(20501)})
        },
        {
            20501
        }

    }

    addon.Achievements.HousingSL = ACMList
end