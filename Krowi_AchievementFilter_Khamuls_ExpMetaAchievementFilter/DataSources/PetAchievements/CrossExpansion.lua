local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetCrossExpansionPetAchievements()

    -- Flat achievement list
    local ACMListFlat = {
        L["Cross-Expansion"],
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            4478, -- Looking for Multitudes
            7934, -- Raiding with Leashes
            17736, -- The Gift of Cheese
            7521, -- Time to Open a Pet Store
            1250, -- Shop Smart, Shop Pet...Smart
            2516, -- Lil' Game Hunter
            5876, -- Petting Zoo
            5877, -- Menagerie
            5875, -- Littlest Pet Shop
            7500, -- Going to Need More Leashes
            7501, -- That's a Lot of Pet Food
            9643, -- So. Many. Pets.
            12992, -- Pet Emporium
            12958, -- Master of Minions
            15641, -- Many More Mini Minions
            15642, -- Proven Pet Parent
            15643, -- What Can I Say? They Love Me.
            15644, -- Good Things Come in Small Packages
            6556, -- Going to Need More Traps
            8300, -- Brutal Pet Brawler
            6582, -- Pro Pet Mob
            12996, -- Toybox Tycoon,
            9983, -- That's Wwhack!
            18644, -- Community Rumor Mill
        }
    }

    -- Zones->AdditionalPetStuff
    local ACMList_AdditionalPetStuffZone = {
        8348, -- The Longest Day
    }

    -- PetBattles->Collect->AdditionalPetStuff
    local ACMList_AdditionalPetStuffPetBattleCollect = {
        6556, -- Going to Need More Traps
    }

    -- PetBattles->Battle->AdditionalPetStuff
    local ACMList_AdditionalPetStuffPetBattleBattle = {
        7499, -- Taming the World
    }

    -- PetBattles->Level->AdditionalPetStuff
    local ACMList_AdditionalPetStuffPetBattleLevel = {
        7433, -- Newbie
        6566, -- Just a Pup
        6581, -- Pro Pet Crew
        6582, -- Pro Pet Mob
    }


    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then
        ACMListFlat[#ACMListFlat+1] = ACMList_AdditionalPetStuffZone
        ACMListFlat[#ACMListFlat+1] = ACMList_AdditionalPetStuffPetBattleCollect
        ACMListFlat[#ACMListFlat+1] = ACMList_AdditionalPetStuffPetBattleBattle
        ACMListFlat[#ACMListFlat+1] = ACMList_AdditionalPetStuffPetBattleLevel
    end

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Dungeons & Raids
    local ACMList_DungeonsAndRaids = {
        _G.DUNGEONS .. " & " .. _G.RAIDS,
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            4478, -- Looking for Multitudes
            7934, -- Raiding with Leashes
        }
    }

    -- Professions -> Cooking
    local ACMList_Professions_Cooking = {
        _G.TRADE_SKILLS,
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            _G.PROFESSIONS_COOKING,
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                17736 -- The Gift of Cheese
            }
        }
    }

    -- PetBattles->Collect
    local ACMList_PetBattlesCollect = {
        Utilities:GetAchievementCategoryNameByCategoryID(15118), -- Collect
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            7521, -- Time to Open a Pet Store
            1250, -- Shop Smart, Shop Pet...Smart
            2516, -- Lil' Game Hunter
            5876, -- Petting Zoo
            5877, -- Menagerie
            5875, -- Littlest Pet Shop
            7500, -- Going to Need More Leashes
            7501, -- That's a Lot of Pet Food
            9643, -- So. Many. Pets.
            12992, -- Pet Emporium
            12958, -- Master of Minions
            15641, -- Many More Mini Minions
            15642, -- Proven Pet Parent
            15643, -- What Can I Say? They Love Me.
            15644, -- Good Things Come in Small Packages
        }
    }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then
        ACMList_PetBattlesCollect[#ACMList_PetBattlesCollect+1] = ACMList_AdditionalPetStuffPetBattleCollect
    end

    -- PetBattles->Battle
    local ACMList_PetBattlesBattle = {
        Utilities:GetAchievementCategoryNameByCategoryID(15119), -- Battle
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            8300 -- Brutal Pet Brawler
        }
    }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then
        ACMList_PetBattlesBattle[#ACMList_PetBattlesBattle+1] = ACMList_AdditionalPetStuffPetBattleBattle
    end

    -- PetBattles->Level
    local ACMList_PetBattlesLevel = {
        Utilities:GetAchievementCategoryNameByCategoryID(15120), -- Level
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            6582
        }
    }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includePetRelatedStuff then
        ACMList_PetBattlesLevel[#ACMList_PetBattlesLevel+1] = ACMList_AdditionalPetStuffPetBattleLevel
    end

    -- PetBattles -> Collect, Battle, Level
    local ACMList_PetBattles_CollectBattleLevel = {
        Utilities:GetAchievementCategoryNameByCategoryID(15219), -- Pet Battles
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_PetBattlesCollect,
        ACMList_PetBattlesBattle,
        ACMList_PetBattlesLevel
    }

    -- Collections
    local ACMList_Collections = {
        Utilities:GetAchievementCategoryNameByCategoryID(15246), -- Collections
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            12996 -- Toybox Tycoon
        }
    }


    -- Darkmoon Faire
    local ACMList_DarkmoonFaire = {
        Utilities:GetAchievementCategoryNameByCategoryID(15101), -- Darkmoon Faire
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            9983, -- That's Whack!
        }
    }

    -- Zones
    local  ACMList_Zones = {
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

    ACMList_Zones[#ACMList_Zones+1] = {
        18644, -- Community Rumor Mill
    }

    local ACMList = {
        L["Cross-Expansion"],
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Collections,
        ACMList_DarkmoonFaire,
        ACMList_DungeonsAndRaids,
        ACMList_PetBattles_CollectBattleLevel,
        ACMList_Professions_Cooking,
        ACMList_Zones,
    }

    return ACMList
end