local addonName, addon = ...;

local L = addon.L
addon.Achievements = addon.Achievements or {}

-- Add new entry for TWW
addon.Achievements.TWW = {}
addon.Achievements.TWWMetaAchievementId = 41201

function InitializeTWW()

    local ACM_41186 = { -- Slate of the Union
        GetAchievementName(41186),
        false,
        {
            40435,
            40434,
            40606,
            40859,
            40860,
            40504
        }
    }

    local ACM_41187 = { -- Rage Aside the Machine
        GetAchievementName(41187),
        false,
        {
            40837,
            40724,
            40662,
            40585,
            40628,
            40473,
            40475
        }
    }

    local ACM_41188 = { -- Crystal Chronicled
        GetAchievementName(41188),
        false,
        {
            40851,
            40848,
            40625,
            40151,
            40622,
            40308,
            40311,
            40618,
            40313,
            40150
        }
    }

    local ACM_41189 = { -- Azj the World Turns
        GetAchievementName(41189),
        false,
        {
            40840,
            40828,
            40634,
            40633,
            40869,
            40624,
            40542,
            40629
        }
    }

    local ACM_41133 = { -- Isle Remember You
        GetAchievementName(41133),
        false,
        {
            41045,
            41042,
            41043,
            41046,
            41131,
            41050
        }
    }

    local ACMList = { -- meta achievements overview
        GetAchievementName(41201, "TWW - "),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_41186, -- Slate of the Union
        ACM_41187, -- Rage Aside the Machine
        ACM_41188, -- Crystal Chronicled
        ACM_41189, -- Azj the World Turns
        ACM_41133, -- Isle Remember You
        {
            41186,
            41187,
            41188,
            41189,
            41133
        }
    }

    addon.Achievements.TWW = ACMList
end