local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetDFPetAchievements()

    -- Child Achievements Family Battler of the Dragon Isles
    local ACMChilds_FamilyBattlerOfTheDragonIsles = {
        Utilities:GetAchievementName(16512),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            16501, -- Aquatic Battler of the Dragon Isles
            16503, -- Beast Battler of the Dragon Isles
            16504, -- Critter Battler of the Dragon Isles
            16505, -- Dragonkin Battler of the Dragon Isles
            16506, -- Elemental Battler of the Dragon Isles
            16507, -- Flying Battler of the Dragon Isles
            16508, -- Humanoid Battler of the Dragon Isles
            16509, -- Magic Battler of the Dragon Isles
            16510, -- Mechanical Battler of the Dragon Isles
            16511, -- Undead Battler of the Dragon Isles
        }
    }

    -- Child Achievements Family Battler of Zaralek Cavern
    local ACMChilds_FamilyBattlerOfZaralekCavern= {
        Utilities:GetAchievementName(17934),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            17881, -- Aquatic Battler of Zaralek Cavern
            17882, -- Beast Battler of Zaralek Cavern
            17883, -- Critter Battler of Zaralek Cavern
            17890, -- Dragonkin Battler of Zaralek Cavern
            17904, -- Elemental Battler of Zaralek Cavern
            17905, -- Flying Battler of Zaralek Cavern
            17915, -- Humanoid Battler of Zaralek Cavern
            17916, -- Magic Battler of Zaralek Cavern
            17917, -- Mechanical Battler of Zaralek Cavern
            17918, -- Undead Battler of Zaralek Cavern
        }
    }

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME9, -- Dragonflight
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMListFlat[#ACMListFlat+1] = ACMChilds_FamilyBattlerOfTheDragonIsles
        ACMListFlat[#ACMListFlat+1] = ACMChilds_FamilyBattlerOfZaralekCavern
    end

    ACMListFlat[#ACMListFlat+1] = {
        18384, -- Whelp, There It Is
        17741, -- Slow and Steady Wins the Race
        19293, -- Friends In Feathers
        19792, -- Just One More Thing
        19089, -- Don't Let the Doe hit You The Way Out
        16512, -- Family Battler of the Dragon Isles
        17934, -- Family Battler of Zaralek Cavern
        15940, -- Dragon Racing Completitionist: Silver
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zone
    local ACMList_Zones_ValdrakkenZaralekCavernEmeraldDream = {
        _G.ZONE, -- Zone
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            Utilities:GetZoneNameByMapID(2112), -- Valdrakken
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                18384, -- Whelp, There It Is
            }
        },
        {
            Utilities:GetZoneNameByMapID(2130), -- Zaralek Cavern
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                17741, -- Slow and Steady Wins the Race
            }
        },
        {
            Utilities:GetZoneNameByMapID(2200), -- Emerald Dream
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                19293, -- Friends In Feathers
            }
        },
        {
            19792, -- Just One More Thing
        }
    }

    -- Raids
    local ACMList_Raids_Amirdrassil = {
        _G.RAIDS, -- Raids
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            Utilities:GetDungeonNameByLFGDungeonID(2502),
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                19089, -- Don't Let the Doe hit You The Way Out
            }
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

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMList_PetBattles[#ACMList_PetBattles+1] = ACMChilds_FamilyBattlerOfTheDragonIsles
        ACMList_PetBattles[#ACMList_PetBattles+1] = ACMChilds_FamilyBattlerOfZaralekCavern
    end

    ACMList_PetBattles[#ACMList_PetBattles+1] = {
        16512, -- Family Battler of the Dragon Isles
        17934, -- Family Battler of Zaralek Cavern
    }

    -- Dragonriding Races
    local ACMList_DragonridingRaces = {
        _G.MOUNT_JOURNAL_FILTER_DRAGONRIDING, -- Skyriding
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            15940, -- Dragon Racing Completitionist: Silver
        }
    }

    local ACMList = {
        _G.EXPANSION_NAME9, -- Dragonflight
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Zones_ValdrakkenZaralekCavernEmeraldDream,
        ACMList_Raids_Amirdrassil,
        ACMList_PetBattles,
        ACMList_DragonridingRaces
    }

    return ACMList
end