local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetHousingTWW()

    -- Child Achievements Slate of the Union
    local ACMChilds_SlateOfTheUnion = {
        Utilities:GetAchievementName(41186),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            40435, -- Adventurer of the Isle of Dorn
            40434, -- Treasures of the Isle of Dorn
            40606, -- Flat Earthen
            40859, -- We're Here All Night
            40860, -- A Star of Dorn
            40504, -- Rocked to Sleep
        }
    }

    -- Flat achievement list
    local ACMListFlat = {
        EXPANSION_NAME10, -- The War Within
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.decorAchievementsSettings.includeChildAchievements then
        ACMListFlat[#ACMListFlat+1] = ACMChilds_SlateOfTheUnion
    end

    ACMListFlat[#ACMListFlat+1] = {
        61451, -- Worldsoul-Searching
        41186, -- Slate or the Union
        20595, -- Sojurner of Isle of Dorn
        40859, -- We're All Night
        40504, -- Rocked to Sleep
        40542, -- Smelling History
        40894, -- Sojourner of Undermine
        41119, -- One Rank Higher
        19408, -- Professional Algari Master
        42187, -- Lorewalking: Ethereal Wisdon
        42188, -- Lorewalking: Blade's Bane
        42189, -- Lorewalking: The Lich King
        61467, -- Lorewalking: The Elves of Quel'Thalas
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.decorAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    local ACMList_Zones_IsleOfDorn = {
        Utilities:GetZoneNameByMapID(2248), -- Isle of Dorn
        false,
        {
            IgnoreCollapsedChainFilter = true
        }
    }

    if KhamulsAchievementFilter.db.profile.decorAchievementsSettings.includeChildAchievements then
        ACMList_Zones_IsleOfDorn[#ACMList_Zones_IsleOfDorn+1] = ACMChilds_SlateOfTheUnion
    end

    ACMList_Zones_IsleOfDorn[#ACMList_Zones_IsleOfDorn+1] = {
        41186, -- Slate or the Union
        20595, -- Sojurner of Isle of Dorn
        40859, -- We're All Night
    }

    -- Zones
    local ACMList_Zones = {
        _G.ZONE, -- Zone
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACMList_Zones_IsleOfDorn,
        {
            Utilities:GetZoneNameByMapID(2214), -- The Ringing Deeps
            false,
            {
                IgnoreCollapsedChainFilter = true
            },
            {
                40504, -- Rocked to Sleep
            }
        },
        {
            Utilities:GetZoneNameByMapID(2255), -- Azj-Kahet
            false,
            {
                IgnoreCollapsedChainFilter = true
            },
            {
                40542, -- Smelling History
            }
        },
        {
            Utilities:GetZoneNameByMapID(2346), -- Undermine
            false,
            {
                IgnoreCollapsedChainFilter = true
            },
            {
                40894, -- Sojourner of Undermine
            }
        }
    }

    -- Raids
    local ACMList_Raids = {
        _G.RAIDS, -- Raids
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            Utilities:GetDungeonNameByLFGDungeonID(2779),
            false,
            {
                IgnoreCollapsedChainFilter = true
            },
            {
                41119, -- One Rank Higher
            }
        }
    }

    -- Trade Skills
    local ACMList_TradeSkills = {
        _G.TRADE_SKILLS, -- Professions
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            19408, -- Professional Algari Master
        }
    }

    -- Lorewalking
    local ACMList_Lorewalking = {
        Utilities:GetAchievementCategoryNameByCategoryID(15552), -- Lorewalking
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            42187, -- Lorewalking: Ethereal Wisdon
            42188, -- Lorewalking: Blade's Bane
            42189, -- Lorewalking: The Lich King
            61467, -- Lorewalking: The Elves of Quel'Thalas
        }
    }

    local ACMList = { 
        EXPANSION_NAME10, -- The War Within
        false,
        {
            IgnoreCollapsedChainFilter = true,
            Tooltip = Utilities:ReplacePlaceholderInText(L["Tt_UseMetaAchievementPlugin"], {Utilities:GetAchievementName(61451)})
        },
        ACMList_Zones,
        ACMList_Raids,
        ACMList_TradeSkills,
        ACMList_Lorewalking,
        {
            61451
        }
    }

    return ACMList
end