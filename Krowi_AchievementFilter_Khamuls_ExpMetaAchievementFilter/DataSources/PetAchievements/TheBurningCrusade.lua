local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetTBCPetAchievements()

    -- PetBattles->AdditionalPetStuff
    local ACMList_AdditionalPetStuffPetBattles = {
        6604, -- Taming Outland
    }

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME1, -- The Burning Crusade
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            8293, -- Raiding with Leashes II: Attunement Edition
            9824 -- Raiding with Leashes III: Drinkin' From the Sunwell
        }
    }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then
        ACMListFlat[#ACMListFlat+1] = ACMList_AdditionalPetStuffPetBattles
    end

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure then
        return ACMListFlat
    end
    
    -- Raids
    local ACMList_Raids = {
        _G.RAIDS, -- Raids
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
           8293, -- Raiding with Leashes II: Attunement Edition
            9824 -- Raiding with Leashes III: Drinkin' From the Sunwell
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
        _G.EXPANSION_NAME1, -- The Burning Crusade
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_PetBattles,
        ACMList_Raids
    }

    return ACMList
end