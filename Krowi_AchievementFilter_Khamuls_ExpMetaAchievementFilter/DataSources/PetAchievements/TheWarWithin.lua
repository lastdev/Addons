local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetTWWPetAchievements()

    -- Child Achievements Family Battler of Khaz Algar
    local ACMChilds_FamilyBattlerOfKhazAlgar = {
        Utilities:GetAchievementName(40980),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            40154, -- Aquatic Battler of Khaz Algar
            40155, -- Beast Battler of Khaz Algar
            40156, -- Critter Battler of Khaz Algar
            40157, -- Dragonkin Battler of Khaz Algar
            40158, -- Elemental Battler of Khaz Algar
            40161, -- Flying Battler of Khaz Algar
            40162, -- Humanoid Battler of Khaz Algar
            40163, -- Magic Battler of Khaz Algar
            40164, -- Mechanical Battler of Khaz Algar
            40165, -- Undead Battler of Khaz Algar
        }
    }

    -- Child Achievements Family Battler of Undermine
    local ACMChilds_FamilyBattlerOfUndermine= {
        Utilities:GetAchievementName(41551),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            41542, -- Aquatic Battler of Undermine
            41543, -- Beast Battler of Undermine
            41541, -- Critter Battler of Undermine
            41544, -- Dragonkin Battler of Undermine
            41545, -- Elemental Battler of Undermine
            41546, -- Flying Battler of Undermine
            41547, -- Humanoid Battler of Undermine
            41548, -- Magic Battler of Undermine
            41549, -- Mechanical Battler of Undermine
            41550, -- Undead Battler of Undermine
        }
    }

    -- Child Achievements Reeking of Visions
    local ACMChilds_ReekingOfVisions = {
        Utilities:GetAchievementName(41928),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            41876, -- The Even More Horrific Vision of Ogrimmar
            41854 -- The Even More Horrific Vision of Stormwind
        }
    }

    -- Child Achievements War Within Dungeon Hero
    local ACMChilds_WarWithinDungeonHero = {
        Utilities:GetAchievementName(61565),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            40374, -- Heroic: Ara-Kara, City of Echoes
            40363, -- Heroic: Cinderbrew Meadery
            40377, -- Heroic: City of Threads
            40428, -- Heroic: Darkflame Cleft
            40592, -- Heroic: Priory of the Sacred Flame
            40601, -- Heroic: The Dawnbreaker
            40637, -- Heroic: The Rookery
            40644, -- Heroic: The Stonevault
            41340, -- Heroic: Operation: Floodgate
            42781, -- Heroic: Eco-Dome Al'dani
        }
    }

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME10, -- The War Within
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.includeChildAchievements then
        ACMListFlat[#ACMListFlat+1] = ACMChilds_FamilyBattlerOfKhazAlgar
        ACMListFlat[#ACMListFlat+1] = ACMChilds_FamilyBattlerOfUndermine
        ACMListFlat[#ACMListFlat+1] = ACMChilds_WarWithinDungeonHero
        ACMListFlat[#ACMListFlat+1] = ACMChilds_ReekingOfVisions
    end

    ACMListFlat[#ACMListFlat+1] = {
        40869, -- Worm Theory
        41349, -- In with the Cartels
        41979, -- Bounty Seeker
        61565, -- War Within Dungeon Hero
        40194, -- Khaz Algar Safari
        40980, -- Family Battler of Khaz Algar
        41092, -- Undermine Safari
        41551, -- Family Battler of Undermine
        41928, -- Reeking of Visions
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.petAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Pet Battle Dungeons
    local ACMList_Zones = {
        _G.ZONE, -- Zone
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            Utilities:GetZoneNameByMapID(2255), -- Azj-Kahet
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                40869, -- Worm Theory
            }
        },
        {
            Utilities:GetZoneNameByMapID(2346), -- Undermine
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                41349, -- In with the Cartels
            }
        },
        {
            Utilities:GetZoneNameByMapID(2371), -- K'aresh
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                41979, -- Bounty Seeker
            }
        },
    }

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
        ACMList_Dungeons[#ACMList_Dungeons+1] = ACMChilds_WarWithinDungeonHero
    end

    ACMList_Dungeons[#ACMList_Dungeons+1] = {
        61565, -- War Within Dungeon Hero
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
        ACMList_PetBattles[#ACMList_PetBattles+1] = ACMChilds_FamilyBattlerOfKhazAlgar
        ACMList_PetBattles[#ACMList_PetBattles+1] = ACMChilds_FamilyBattlerOfUndermine
    end

    ACMList_PetBattles[#ACMList_PetBattles+1] = {
        40194, -- Khaz Algar Safari
        40980, -- Family Battler of Khaz Algar
        41092, -- Undermine Safari
        41551, -- Family Battler of Undermine
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

    local ACMList_VisionsOfNZoth = {
        _G.SPLASH_BATTLEFORAZEROTH_8_3_0_FEATURE1_TITLE, -- Horrific Visions
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
        41928, -- Reeking of Visions
    }

    local ACMList = {
        _G.EXPANSION_NAME10, -- The War Within
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        ACMList_Zones,
        ACMList_Dungeons,
        ACMList_PetBattles,
        ACMList_VisionsOfNZoth
    }

    return ACMList
end