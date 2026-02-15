local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetBfaPetAchievements()

    -- Child Achievements Family Battler
    local ACMChilds_FamilyBattler = {
        Utilities:GetAchievementName(13279),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            13280, -- Hobbyist Aquarist
            13270, -- Best Mode
            13271, -- Critters With Huge Teeth
            13272, -- Dragons Make Everything Better
            13273, -- Element of Success
            13274, -- Fun With Flying
            13281, -- Human Resources
            13275, -- Magician's Secrets
            13277, -- Machine Learning
            13278 -- Not Quite Dead Yet
        }
    }

    -- Child Achievements Team Aquashock
    local ACMChilds_TeamAquashock = {
        Utilities:GetAchievementName(13695),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            13694, -- Nazjatari Safari
            13693, -- Mecha-Safari
            13626, -- Nautical Nuisances of Nazjatar
            13625 -- Mighty Minions of Mechagon
        }
    }

    -- Child Achievements Reeking of Visions
    local ACMChilds_ReekingOfVisions = {
        Utilities:GetAchievementName(14143),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            14065, -- The Even More Horrific Vision of Ogrimmar
            14064 -- The Even More Horrific Vision of Stormwind
        }
    }

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME7, -- Battle for Azeroth
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMListFlat[#ACMListFlat+1] = ACMChilds_FamilyBattler
        ACMListFlat[#ACMListFlat+1] = ACMChilds_TeamAquashock
        ACMListFlat[#ACMListFlat+1] = ACMChilds_ReekingOfVisions
    end

    ACMListFlat[#ACMListFlat + 1] = {
        13062, -- Let's Bee Friends
        12723, -- How to Keep a Mummy
        12930, -- Battle Safari
        13279, -- Family Battler
        13695, -- Team Aquashock
        14143 -- Reeking of Visions
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zones -> Stormsong Valley -> Quests
    local ACMList_Zones_StormsongValley_Quests = {
        _G.ZONE, -- Zone
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            Utilities:GetZoneNameByMapID(942),
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                13062 -- Let's Bee Friends
            }
        }
    }

    -- Dungeons -> Kings'Rest
    local ACMList_Dungeons_KingsRest = {
        _G.DUNGEONS, -- Dungeons
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            Utilities:GetDungeonNameByLFGDungeonID(1785),
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                12723 -- How to Keep a Mummy
            }
        }
    }

    -- Pet Battle
    local ACMList_PetBattles = {
        Utilities:GetAchievementCategoryNameByCategoryID(15219), -- Pet Battles
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMList_PetBattles[#ACMList_PetBattles+1] = ACMChilds_FamilyBattler
        ACMList_PetBattles[#ACMList_PetBattles+1] = ACMChilds_TeamAquashock
    end

    ACMList_PetBattles[#ACMList_PetBattles+1] = {
        12930, -- Battle Safari
        13279, -- Family Battler
        13695, -- Team Aquashock
    }

    local ACMList_VisionsOfNZoth = {
        _G.SPLASH_BATTLEFORAZEROTH_8_3_0_FEATURE1_TITLE,
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMList_VisionsOfNZoth[#ACMList_VisionsOfNZoth+1] = ACMChilds_ReekingOfVisions
    end

    ACMList_VisionsOfNZoth[#ACMList_VisionsOfNZoth+1] = {
        14143 -- Reeking of Visions
    }

    local ACMList = {
        _G.EXPANSION_NAME7, -- Battle for Azeroth
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Zones_StormsongValley_Quests,
        ACMList_Dungeons_KingsRest,
        ACMList_PetBattles,
        ACMList_VisionsOfNZoth
    }

    return ACMList
end