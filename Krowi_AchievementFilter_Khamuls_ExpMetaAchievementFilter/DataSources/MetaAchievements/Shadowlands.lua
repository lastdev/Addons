local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetSLAchievementId()
    return 20501
end

function GetSLList()

    local ACM_15336 = { -- From A to Zereth
        Utilities:GetAchievementName(15336),
        true,
        {
            15259,
            15331,
            15392,
            15391,
            15402,
            15407,
            15220
        }
    }

    local ACM_15651 = { -- Myths of the Shadowlands Dungeons
        Utilities:GetAchievementName(15651),
        true,
        {
            14368,
            14415,
            14413,
            14411,
            14325,
            14417,
            14409,
            14199,
            15177
        }
    }

    local ACM_15035 = { -- On the Offensive
        Utilities:GetAchievementName(15035),
        false,
        {
            Tooltip = L["Tt_ACM_15035"]
        },
        Utilities:ShowOnlyCompletedAchievementsWhenRequirementsAreMet(4, {
            15000,
            15001,
            15037,
            15039,
            15041,
            15043,
            15004,
            15042,
            15044
        })
    }

    local ACM_15649 = { -- Shadowlands Dilettante
        Utilities:GetAchievementName(15649),
        false,
        {
            Utilities:GetAchievementName(14752),
            false,
            {
                14684,
                14748,
                14751,
                14753
            }
        },
        {
            14502,
            14723,
            14752,
            14775
        }
    }

    local ACM_15324 = { -- Tower Ranger
        Utilities:GetAchievementName(15324),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            Utilities:GetAchievementName(15092),
            false,
            {
                15093,
                15095,
                15094,
                15096
            }
        },
        {
            15322,
            15067,
            14570,
            15254,
            15092
        }
    }

    local ACM_15648 = { 
        Utilities:GetAchievementName(15648),
        true,
        {
            14895,
            14744,
            14660,
            14738,
            14656,
            14658,
            14663
        }
    }

    local ACMList = { -- meta achievements overview
        Utilities:GetAchievementName(20501, "SL - "),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACM_15336, -- From A to Zereth
        ACM_15651, -- Myths of the Shadowlands Dungeons
        ACM_15035, -- On the Offensive
        ACM_15649, -- Shadowlands Dilettante
        ACM_15324, -- Tower Ranger
        ACM_15648, -- Walking in Maw-mphis
        {
            14715,
            14961,
            15647,
            15178,
            15336,
            15079,
            15651,
            15035,
            15646,
            15025,
            15126,
            15259,
            15417,
            15649,
            15324,
            15648
        }
    }

    return ACMList
end