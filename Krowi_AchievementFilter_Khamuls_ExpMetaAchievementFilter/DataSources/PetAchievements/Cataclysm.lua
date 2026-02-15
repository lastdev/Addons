local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetCataPetAchievements()

    -- PetBattles->AdditionalPetStuff
    local ACMList_AdditionalPetStuffPetBattles = {
        7525, -- Taming Cataclysm
    }

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME3, -- Cataclysm
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            5860, -- The 'Unbeatable?' Pterodactyl: BEATEN.
            5449, -- Rock Lover
            11856, -- Pet Battle Challenge: Deadmines
            12079, -- Raiding with Leashes V: Cuteaclysm
        }
    }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then
        ACMListFlat[#ACMListFlat+1] = ACMList_AdditionalPetStuffPetBattles
    end

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zones -> Mount Hyjal & Deepholm -> Quests
    local ACMList_Zones_MountHyjalDeepholm_Quests = {
        _G.ZONE, -- Zone
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            Utilities:GetZoneNameByMapID(198), -- Mount Hyjal
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                5860 -- The 'Unbeatable?' Pterodactyl: BEATEN.
            }
            
        },
        {
            Utilities:GetZoneNameByMapID(207), -- Deepholm
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                5449, -- Rock Lover
            }
        }
    }

    -- Pet Battle Dungeons
    local ACMList_PetBattleDungeons = {
        _G.BATTLE_PET_SOURCE_5 .. " " .. _G.DUNGEONS, -- Pet Battle Dungeons
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            11856, -- Pet Battle Challenge: Deadmines
        }
    }

    -- Raids
    local ACMList_Raids = {
        _G.RAIDS, -- Raids
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            12079, -- Raiding with Leashes V: Cuteaclysm
        }
    }

    -- PetBattles
    local ACMList_PetBattles = {
        Utilities:GetAchievementCategoryNameByCategoryID(15219), -- Pet Battles
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }
    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then
        ACMList_PetBattles[#ACMList_PetBattles+1] = ACMList_AdditionalPetStuffPetBattles
    end

    local ACMList = {
        _G.EXPANSION_NAME3, -- Cataclysm
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Zones_MountHyjalDeepholm_Quests,
        ACMList_PetBattles,
        ACMList_PetBattleDungeons,
        ACMList_Raids
    }

    return ACMList
end