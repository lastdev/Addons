local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetHousingBfA()

    -- Flat achievement list
    local ACMListFlat = {
        EXPANSION_NAME7, -- Battle for Azeroth
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            40953, -- A Farewell to Arms
            12582, -- Come Sail Away
            12997, -- The Pride of Kul Tiras
            12479, -- Zandalar Forever!
            12509, -- Ready for War
            13049, -- The Long Con
            13039, -- Paku'ai
            13038, -- Raptari Rider
            12614, -- Loa Expectations
            13018, -- Dune Rider
            13473, -- Diversified Investments
            13475, -- Junkyard Scavenger
            13477, -- Junkyard Apprentice
            13723, -- M.C., Hammered
            12733, -- Professional Zandalari Master
            12746, -- The Zandalari Menu
            12867, -- Azeroth at War: The Barrens
            12869, -- Azeroth at War: After Lordaeron
            12870, -- Azeroth at War: Kalimdor on Fire
            13284, -- Frontline Warrior
        }
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.decorAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zones
    local ACMList_Zones = {
        _G.ZONE, -- Zone
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            Utilities:GetZoneNameByMapID(876) .. " & " .. Utilities:GetZoneNameByMapID(875), -- Kul Tiras & Zandalar
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                12582, -- Come Sail Away
                12997, -- The Pride of Kul Tiras
                12479, -- Zandalar Forever!
                12509, -- Ready for War
            }
        },
        {
            Utilities:GetZoneNameByMapID(895), -- Tiragarde Sound
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                13049, -- The Long Con
            }
        },
        {
            Utilities:GetZoneNameByMapID(862), -- Zuldazar
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                13039, -- Paku'ai
                13038, -- Raptari Rider
                12614, -- Loa Expectations
            }
        },
        {
            Utilities:GetZoneNameByMapID(864), -- Vol'dun
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                13018, -- Dune Rider
            }
        },
        {
            Utilities:GetZoneNameByMapID(1462), -- Mechagon Island
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                13473, -- Diversified Investments
                13475, -- Junkyard Scavenger
                13477, -- Junkyard Apprentice
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
        },
        {
            13723, -- M.C., Hammered
        }
    }

    local ACM_BfA_Professions_Cooking = {
        Utilities:GetAchievementCategoryNameByCategoryID(170),
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            12746
        }
    }

    local ACMList_TradeSkills = {
        _G.TRADE_SKILLS, -- Professions
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            Utilities:GetAchievementCategoryNameByCategoryID(170), -- Cooking
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                12746, -- The Zandalari Menu
            }
        },
        {
            12733, -- Professional Zandalari Master
        }
    }

    local ACMList_WarEffort = {
        Utilities:GetAchievementCategoryNameByCategoryID(15308), -- War Effort
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            12867, -- Azeroth at War: The Barrens
            12869, -- Azeroth at War: After Lordaeron
            12870, -- Azeroth at War: Kalimdor on Fire
            13284, -- Frontline Warrior
        }
    }

    local ACMList = { 
        EXPANSION_NAME7, -- Battle for Azeroth
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true,
            Tooltip = Utilities:ReplacePlaceholderInText(L["Tt_UseMetaAchievementPlugin"], {Utilities:GetAchievementName(40953)})
        },
        ACMList_Zones,
        ACMList_Dungeons,
        ACMList_TradeSkills,
        ACMList_WarEffort,
        {
            40953
        }

    }

    return ACMList
end