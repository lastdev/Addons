local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetHousingWotLk()

    -- Flat achievement list
    local ACMListFlat = {
        EXPANSION_NAME2, -- Wrath of the Lich King
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            938, -- The Snows of Northrend
            4405, -- More Dots! (25 player)
        }
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.decorAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    local ACMList_Zones = {
        _G.ZONE, -- Zone
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            Utilities:GetZoneNameByMapID(119), -- Sholazar Basin
            false,
            {
                IgnoreCollapsedChainFilter = true
            },
            {
                938, -- The Snows of Northrend
            }
        }
    }

    local ACMList_Raids = {
        _G.RAIDS, -- Raids
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            Utilities:GetDungeonNameByLFGDungeonID(257), -- Onyxia's Lair
            false,
            {
                IgnoreCollapsedChainFilter = true
            },
            {
                _G.RAID_DIFFICULTY2, -- 25 Player
                false,
                {
                    IgnoreCollapsedChainFilter = true
                },
                {
                    4405, -- More Dots! (25 player)
                }
            }
        }
    }

    local ACMList = {
        EXPANSION_NAME2,
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACMList_Zones,
        ACMList_Raids
    }

    return ACMList
end