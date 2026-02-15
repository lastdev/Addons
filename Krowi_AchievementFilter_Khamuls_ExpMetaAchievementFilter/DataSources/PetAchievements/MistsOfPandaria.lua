local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetMoPPetAchievements()

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME4, -- Mists of Pandaria
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    -- Zone->AdditionalPetStuff
    local ACMList_AdditionalPetStuffZone = {
        8080, -- Fabled Pandaren Tamer
        7936, -- Pandaren Spirit Tamer
    }

    -- PetBattles->AdditionalPetStuff
    local ACMList_AdditionalPetStuffPetBattles = {
        6606, -- Taming Pandaria
    }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then
        ACMListFlat[#ACMListFlat+1] = ACMList_AdditionalPetStuffZone
        ACMListFlat[#ACMListFlat+1] = ACMList_AdditionalPetStuffPetBattles
    end

    ACMListFlat[#ACMListFlat+1] = {
        6402, -- Ling-Ting's Herbal Journey
        13469, -- Raiding with Leashes VI: Pets of Pandaria
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
        },
        {
            Utilities:GetDungeonNameByLFGDungeonID(469),
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                6402
            }
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
            13469, -- Raiding with Leashes VI: Pets of Pandaria
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

    -- Zones
    local ACMList_Zones = {
        _G.ZONE, -- Zone
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then
        ACMList_Zones[#ACMList_Zones+1] = ACMList_AdditionalPetStuffZone
    end


    local ACMList = {
        _G.EXPANSION_NAME4, -- Mists of Pandaria
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Zones,
        ACMList_PetBattles,
        ACMList_Dungeons,
        ACMList_Raids,
    }

    return ACMList
end