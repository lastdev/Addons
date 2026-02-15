local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetSLPetAchievements()

    -- Child Achievements Family Exorcist
    local ACMChilds_FamilyExorcist = {
        Utilities:GetAchievementName(14879),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            14868, -- Aquatic Apparitions
            14869, -- Beast Busters
            14870, -- Creepy Critters
            14871, -- Deathly Dragonkin
            14872, -- Earie Elementals
            14873, -- Flickering Fliers
            14874, -- Haunted Humanoids
            14875, -- Mummified Magics
            14876, -- Macabre Mechanicals
            14877 -- Unholy Undead
        }
    }

    -- PetBattles->AdditionalPetStuff
    local ACMList_AdditionalPetStuffPetBattle = {
        14625, -- Battle in the Shadowlands
    }

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME8, -- Shadowlands
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    local ACMList_Accessoiries = {
            15508, -- Fashion of the First Ones
    }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMListFlat[#ACMListFlat+1] = ACMChilds_FamilyBattler
        ACMListFlat[#ACMListFlat+1] = ACMChilds_TeamAquashock
        ACMListFlat[#ACMListFlat+1] = ACMChilds_ReekingOfVisions
    end

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then 
        ACMListFlat[#ACMListFlat+1] = ACMList_AdditionalPetStuffPetBattle
    end

    ACMListFlat[#ACMListFlat + 1] = {
        14879, -- Family Exorcist
        14881, -- Abhorrent Adversaries of the Afterlife
        15004, -- A Sly Fox
        15079, -- Many, Many Things
        14469, -- Twisting Corridors: Layer 2
        15251, -- The Jailer's Gauntlet: Layer 1
    }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then
        ACMListFlat[#ACMListFlat+1] = ACMList_Accessoiries
    end

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

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
        ACMList_PetBattles[#ACMList_PetBattles+1] = ACMChilds_FamilyExorcist
    end

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then 
        ACMList_PetBattles[#ACMList_PetBattles+1] = ACMList_AdditionalPetStuffPetBattle
    end

    ACMList_PetBattles[#ACMList_PetBattles+1] = {
        14879, -- Family Exorcist
        14881, -- Abhorrent Adversaries of the Afterlife
        15004, -- A Sly Fox
    }

    local ACMList_Thorghast = {
        Utilities:GetDungeonNameByLFGDungeonID(1963),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            15079, -- Many, Many Things
            14469, -- Twisting Corridors: Layer 2
            15251, -- The Jailer's Gauntlet: Layer 1
        }
    }

    local ACMList_Zones = {
        _G.ZONE, -- Zone
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            Utilities:GetZoneNameByMapID(1970), -- Zereth Mortis
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                15508, -- Fashion of the First Ones
            }
        }
    }

    local ACMList = {
        _G.EXPANSION_NAME8, -- Shadowlands
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Zones,
        ACMList_PetBattles,
        ACMList_Thorghast,
    }


    return ACMList
end