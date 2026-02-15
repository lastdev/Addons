local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetHousingClassic()

    -- Flat achievement list
    local ACMListFlat = {
        EXPANSION_NAME0 .. " & " .. EXPANSION_NAME3, -- Classic & Cataclysm
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            19719,  -- Reclamation of Gilneas
            5442, -- Full Caravan
            940, -- The Green Hills of Stranglethorn
            4859, -- Kings Under the Mountain
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
            IgnoreCollapsedChainFilter = true
        },
        {
            Utilities:GetZoneNameByMapID(13), -- Eastern Kingdoms
            false,
            {
                IgnoreCollapsedChainFilter = true
            },
            {
                Utilities:GetZoneNameByMapID(23), -- Eastern Plaguelands
                false,
                {
                    IgnoreCollapsedChainFilter = true
                },
                {
                    5442, -- Full Caravan
                }
            },
            {
                Utilities:GetZoneNameByMapID(50), -- Northern Stranglethorn
                false,
                {
                    IgnoreCollapsedChainFilter = true
                },
                {
                    940, -- The Green Hills of Stranglethorn
                }
            },
            {
                19719,  -- Reclamation of Gilneas
            }
        }
    }

    local ACMList_TradeSkills = {
        _G.TRADE_SKILLS, -- Professions
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            Utilities:GetAchievementCategoryNameByCategoryID(15071), -- Archeology
            false,
            {
                IgnoreCollapsedChainFilter = true
            },
            {
                4859, -- Kings Under the Mountain
            }
        }
    }

    local ACMList = { 
        EXPANSION_NAME0 .. " & " .. EXPANSION_NAME3, -- Classic & Cataclysm
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACMList_Zones,
        ACMList_TradeSkills
    }

    return ACMList
end