local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetHousingWoD()

    -- Flat achievement list
    local ACMListFlat = {
        EXPANSION_NAME5, -- Warlords of Draenor
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            9415, -- Secrets of Skettis
        }
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.decorAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    local ACM_WoD_TradeSkills_Archaeology = {
        Utilities:GetAchievementCategoryNameByCategoryID(15071),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            9415
        }
    }

    -- TradeSkills
    local ACMList_TradeSkills = {
        _G.TRADE_SKILLS, -- Professions
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            Utilities:GetAchievementCategoryNameByCategoryID(15071), -- Archeology
            false,
            {
                IgnoreCollapsedChainFilter = true
            },
            {
                9415, -- Secrets of Skettis
            }
        }
    }

    local ACMList = {
        EXPANSION_NAME5, -- Warlords of Draenor
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACMList_TradeSkills
    }

    return ACMList
end