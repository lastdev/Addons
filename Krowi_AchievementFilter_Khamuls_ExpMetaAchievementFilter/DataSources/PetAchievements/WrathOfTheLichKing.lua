local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetWotLKPetAchievements()

    -- Child Achievements Family Battler of Northrend
    local ACMChilds_FamilyBattlerofNorthrend = {
        Utilities:GetAchievementName(60956),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            60942, -- Aquatic Battler of Northrend
            60951, -- Beast Battler of Northrend
            60943, -- Critter Battler of Northrend
            60944, -- Dragonkin Battler of Northrend
            60948, -- Elemental Battler of Northrend
            60949, -- Flying Battler of Northrend
            60950, -- Humanoid Battler of Northrend
            60952, -- Magic Battler of Northrend
            60953, -- Mechanical Battler of Northrend
            60954, -- Undead Battler of Northrend
        }
    }

    -- PetBattles->AdditionalPetStuff
    local ACMList_AdditionalPetStuffPetBattle = {
        11320, -- Raiding with Leashes IV: Wrath of the Lick King
        6605, -- Taming Northrend
    }

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME2, -- Wrath of the Lich King
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMListFlat[#ACMListFlat+1] = ACMChilds_FamilyBattlerofNorthrend
    end

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then
        ACMListFlat[#ACMListFlat+1] = ACMList_AdditionalPetStuffPetBattle
    end

    ACMListFlat[#ACMListFlat+1] = {
        60956, -- Family Battler of Northrend
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- PetBattles
    local ACMList_PetBattles = {
        Utilities:GetAchievementCategoryNameByCategoryID(15219), -- Pet Battles
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMList_PetBattles[#ACMList_PetBattles+1] = ACMChilds_FamilyBattlerofNorthrend
    end

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then
        ACMList_PetBattles[#ACMList_PetBattles+1] = ACMList_AdditionalPetStuffPetBattle
    end

    ACMList_PetBattles[#ACMList_PetBattles+1] = {
        60956, -- Family Battler of Northrend
    }

    local ACMList = {
        _G.EXPANSION_NAME2, -- Wrath of the Lich King
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_PetBattles
    }

    return ACMList
end