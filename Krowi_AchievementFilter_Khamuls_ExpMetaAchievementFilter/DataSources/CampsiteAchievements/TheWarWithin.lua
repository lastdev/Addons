local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetTWWCampsiteList()

    -- Child Achievements All That Khaz
    local ACMChilds_AllThatKhaz = {
        Utilities:GetAchievementName(41555),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            40430, -- Khaz Algar Flight Master
            40702, -- Khaz Algar Glyph Hunter
            20596, -- Loremaster of Khaz Algar
            40762, -- Khaz Algar Lore Hunter
            41169, -- Khaz Algar Diplomat
            40307 -- Allied Races: Earthen
        }
    }

    -- Child Achievements Going Goblin Mode
    local ACMChilds_GoingGoblinMode = {
        Utilities:GetAchievementName(41586),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            41216, -- Adventurer of Undermine
            41217, -- Treasures of Undermine
            40948, -- Nine-Tenths of the Law
            41588, -- Read Between the Lines
            41589, -- That Can-Do Attitude
            41708 -- You're My Friend Now
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

    if KhamulsAchievementFilter.db.profile.campsiteAchievementsSettings.includeChildAchievements then
        ACMListFlat[#ACMListFlat+1] = ACMChilds_AllThatKhaz
        ACMListFlat[#ACMListFlat+1] = ACMChilds_GoingGoblinMode
    end

    ACMListFlat[#ACMListFlat+1] = {
        41555, -- All That Khaz
        41586, -- Going Goblin Mode
        41970, -- The Knife's Edge
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.campsiteAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Freywold Spring
    local ACMList_FreywoldSpring = {
        Utilities:GetAchievementRewardInfo(41555),
        false,
        {
            IgnoreCollapsedChainFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.campsiteAchievementsSettings.includeChildAchievements then
        ACMList_FreywoldSpring[#ACMList_FreywoldSpring+1] = ACMChilds_AllThatKhaz
    end

    ACMList_FreywoldSpring[#ACMList_FreywoldSpring+1] = {
        41555, -- All That Khaz
    }

    -- Gallagio Grand Gallery
    local ACMList_GallagioGrandGallery = {
        Utilities:GetAchievementRewardInfo(41586),
        false,
        {
            IgnoreCollapsedChainFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.campsiteAchievementsSettings.includeChildAchievements then
        ACMList_GallagioGrandGallery[#ACMList_GallagioGrandGallery+1] = ACMChilds_GoingGoblinMode
    end

    ACMList_GallagioGrandGallery[#ACMList_GallagioGrandGallery+1] = {
        41586, -- Going Goblin Mode
    }

    -- The Fate of the Devoured
    local ACMList_TheFateOfTheDevoured = {
        Utilities:GetAchievementRewardInfo(41970),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            41970, -- The Knife's Edge
        }
    }

    local ACMList = { 
        _G.EXPANSION_NAME10, -- The War Within
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACMList_FreywoldSpring,
        ACMList_GallagioGrandGallery,
        ACMList_TheFateOfTheDevoured
    }

    return ACMList
end