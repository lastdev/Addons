local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetFeatsOfStrengthAndLegacyPetAchievements()
    -- Flat achievement list
    local ACMListFlat = {
       Utilities:GetAchievementCategoryNameByCategoryID(81) .. " & " .. Utilities:GetAchievementCategoryNameByCategoryID(15176), -- Feats of Strength & Legacy
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            8820, -- WoW's 10th Anniversary
            19877, -- Townlong Steppes,
            20003, -- Timeless Isle
            42319, -- Azsuna
            42541, -- Highmountain
        }
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Remix: Mists of Pandaria
    local ACMList_RemixMistsOfPandaria = {
        Utilities:GetAchievementCategoryNameByCategoryID(15536), -- "Remix: Mists of Pandaria"
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            19877, -- Townlong Steppes,
            20003, -- Timeless Isle
        }
    }

    -- Remix: Legion
    local ACMList_RemixLegion = {
        Utilities:GetAchievementCategoryNameByCategoryID(15562), -- "Legion Remix"
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            42319, -- Azsuna
            42541, -- Highmountain
        }
    }

    local ACMList = {
        Utilities:GetAchievementCategoryNameByCategoryID(81) .. " & " .. Utilities:GetAchievementCategoryNameByCategoryID(15176), -- Feats of Strength & Legacy
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_RemixMistsOfPandaria,
        ACMList_RemixLegion,
        {
            8820, -- WoW's 10th Anniversaryv
        }
    }

    return ACMList
end