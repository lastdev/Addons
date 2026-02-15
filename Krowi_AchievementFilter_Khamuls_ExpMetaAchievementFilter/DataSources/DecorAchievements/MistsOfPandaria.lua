local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetHousingMoP()

    -- Flat achievement list
    local ACMListFlat = {
        EXPANSION_NAME4, -- Mists of Pandaria
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            8316, -- Blood in the Snow
        }
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.decorAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    local ACMList_Scenarios = {
        Utilities:GetAchievementCategoryNameByCategoryID(15302), -- Pandaria Scenarios
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            Utilities:GetDungeonNameByLFGDungeonID(646), -- Blood in the Snow
            false,
            {
                IgnoreCollapsedChainFilter = true
            },
            {
                8316, -- Blood in the Snow
            }
        }
    }

    local ACMList = {
        EXPANSION_NAME4, -- Mists of Pandaria
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACMList_Scenarios
    }

    return ACMList
end