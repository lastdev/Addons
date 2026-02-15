local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetMNPetAchievements()

    -- Child Achievements Midnight Dungeon Hero
    local ACMChilds_MidnightDungeonHero = {
        Utilities:GetAchievementName(61567),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            61642, -- Heroic: Den of Nalorakk
            61213, -- Heroic: Magisters' Terrace
            61644, -- Heroic: Maisara Caverns
            41963, -- Heroic: Murder  Row
            61646, -- Heroic: Nexus-Point Xenas
            61648, -- Heroic: The Blinding Vale
            61509, -- Heroic: Voidscar Arena
            41288, -- Heroic: Windrunner Spire
        }
    }

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME11, -- Midnight
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMListFlat[#ACMListFlat+1] = ACMChilds_MidnightDungeonHero
    end

    ACMListFlat[#ACMListFlat+1] = {
        61567, -- Midnight Dungeon Hero
        61091, -- Midnight Safari
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Dungeons
    local ACMList_Dungeons = {
        _G.DUNGEONS, -- Dungeons
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMList_Dungeons[#ACMList_Dungeons+1] = ACMChilds_MidnightDungeonHero
    end

    ACMList_Dungeons[#ACMList_Dungeons+1] = {
        61567, -- Midnight Dungeon Hero
    }

    -- PetBattles
    local ACMList_PetBattles = {
        Utilities:GetAchievementCategoryNameByCategoryID(15219), -- Pet Battles
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            61091, -- Midnight Safari
        }
    }

    local ACMList = {
        _G.EXPANSION_NAME11, -- Midnight
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Dungeons,
        ACMList_PetBattles
    }

    return ACMList
end