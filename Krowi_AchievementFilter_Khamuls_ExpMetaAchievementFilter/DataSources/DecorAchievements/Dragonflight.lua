local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetHousingDF()

    -- Flat achievement list
    local ACMListFlat = {
        EXPANSION_NAME9, -- Dragonflight
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            19458, -- A World Awoken
            17773, -- A Blue Dawn
            19507, -- Fringe Benefits
            17529, -- Forbidden  Spoils
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
            Utilities:GetZoneNameByMapID(2024), -- Azure Span
            false,
            {
                IgnoreCollapsedChainFilter = true
            },
            {
                17773, -- A Blue Dawn
            }
        },
        {
            Utilities:GetZoneNameByMapID(2025), -- Thaldraszus
            false,
            {
                IgnoreCollapsedChainFilter = true
            },
            {
                19507, -- Fringe Benefits
            }
        },
        {
            Utilities:GetZoneNameByMapID(2151), -- Forbidden Reach
            false,
            {
                IgnoreCollapsedChainFilter = true
            },
            {
                17529, -- Forbidden  Spoils
            }
        }
    }

    local ACMList = { 
        EXPANSION_NAME9, -- Dragonflight
        false,
        {
            IgnoreCollapsedChainFilter = true,
            Tooltip = Utilities:ReplacePlaceholderInText(L["Tt_UseMetaAchievementPlugin"], {Utilities:GetAchievementName(19458)})
        },
        ACMList_Zones,
        {
            19458, -- A World Awoken
        }

    }

    return ACMList
end