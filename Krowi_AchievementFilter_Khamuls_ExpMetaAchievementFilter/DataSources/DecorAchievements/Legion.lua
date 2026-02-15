local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetHousingLegion()

    -- Flat achievement list
    local ACMListFlat = {
        EXPANSION_NAME6, -- Legion
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            10698, -- That's Val'sharah Folks!
            11258, -- Treasures of Val'sharah
            10398, -- Drum Circle
            11257, -- Treasures of Highmountain
            11124, -- Good Suramaritan
            10996, -- Got to Ketchum All
            11699, -- Grand Fin-ale
            42270, -- The Deathlord's Campaign
            42271, -- The Slayer's Campaign
            42272, -- The Archdruid's Campaign
            42273, -- The Huntmaster's Campaign
            42274, -- The Archmage's Campaign
            42275, -- The Grandmaster's Campaign
            42276, -- The Highlord's Campaign
            42277, -- The High Priest's Campaign
            42279, -- The Shadowblade's Campaign
            42280, -- The Farseer's Campaign
            42281, -- The Netherlord's Campaign
            42282, -- The Battlelord's Campaign
            60981, -- Raise an Army for Acherus
            60982, -- Raise an Army for the Fel Hammer
            60983, -- Raise an Army for the Dreamgrove
            60984, -- Raise an Army for the Trueshot Lodge
            60985, -- Raise an Army for the Hall of the Guardians
            60986, -- Raise an Army for the Temple of Five Dawns
            60987, -- Raise an Army for the Sanctum of Light
            60988, -- Raise an Army for the Netherlight Temple
            60989, -- Raise an Army for the Hall of Shadows
            60990, -- Raise an Army for the Maelstrom
            60991, -- Raise an Army for the Dreadscar Rift
            60992, -- Raise an Army for Skyhold
            60962, -- Legendary Research of the Ebon Blade
            60963, -- Legendary Research of the Illidari
            60964, -- Legendary Research of the Dreamgrove
            60965, -- Legendary Research of the Unseen Path
            60966, -- Legendary Research of the Tirisgarde
            60967, -- Legendary Research of Five Dawns
            60968, -- Legendary Research of the Silver Hand
            60969, -- Legendary Research of the Netherlight Conclave
            60970, -- Legendary Research of the Uncrowned
            60971, -- Legendary Research of the Maelstrom
            60972, -- Legendary Research of the Black Harvest
            60973, -- Legendary Research of the Valarjar
            42287, -- Hidden Potential of the Dreathlord
            42288, -- Hidden Potential of the Slayer
            42289, -- Hidden Potential of the Archdruid
            42290, -- Hidden Potential of the Huntmaster
            42291, -- Hidden Potential of the Archmage
            42292, -- Hidden Potential of the Grandmaster
            42293, -- Hidden Potential of the Highlord
            42294, -- Hidden Potential of the High Priest
            42295, -- Hidden Potential of the Shadowblade
            42296, -- Hidden Potential of the Farseer
            42297, -- Hidden Potential of the Netherlord
            42298, -- Hidden Potential of the Battlelord
        }
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.decorAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zones
    local ACMList_Zones = {
        ZONE,
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            Utilities:GetZoneNameByMapID(641), -- Val'sharah
            false,
            {
                IgnoreCollapsedChainFilter = true
            },
            {
                10698, -- That's Val'sharah Folks!
                11258, -- Treasures of Val'sharah
            }
        },
        {
            Utilities:GetZoneNameByMapID(650), -- Hightmountain
            false,
            {
                IgnoreCollapsedChainFilter = true
            },
            {
                10398, -- Drum Circle
                11257, -- Treasures of Highmountain
            }
        },
        {
            Utilities:GetZoneNameByMapID(680), -- Suramar
            false,
            {
                IgnoreCollapsedChainFilter = true
            },
            {
                11124, -- Good Suramaritan
            }
        }
    }

    local ACM_Legion_Dungeons_NeltharionsLair = {
        Utilities:GetDungeonNameByLFGDungeonID(1206),
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            10996
        }
    }
    -- Dungeons & Raids
    local ACMList_DungeonsRaids = {
        _G.DUNGEONS .. " & " .. _G.RAIDS, -- Dungeons & Raids
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            Utilities:GetDungeonNameByLFGDungeonID(1206), -- Neltharion's Lair
            false,
            {
                IgnoreCollapsedChainFilter = true
            },
            {
                10996, -- Got to Ketchum All
            }
        },
        {
            Utilities:GetDungeonNameByLFGDungeonID(1525), -- Tomb of Sargeras
            false,
            {
                IgnoreCollapsedChainFilter = true
            },
            {
                11699 -- Grand Fin-ale
            }
        }
    }

    -- Orderhalls
    local ACMList_Orderhalls = {
        Utilities:GetAchievementCategoryNameByCategoryID(15304), -- Class Halls
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        {
            Utilities:GetAchievementName(11137), -- A Legendary Campaign
            false,
            {
                IgnoreCollapsedChainFilter = true
            },
            {
                42270, -- The Deathlord's Campaign
                42271, -- The Slayer's Campaign
                42272, -- The Archdruid's Campaign
                42273, -- The Huntmaster's Campaign
                42274, -- The Archmage's Campaign
                42275, -- The Grandmaster's Campaign
                42276, -- The Highlord's Campaign
                42277, -- The High Priest's Campaign
                42279, -- The Shadowblade's Campaign
                42280, -- The Farseer's Campaign
                42281, -- The Netherlord's Campaign
                42282, -- The Battlelord's Campaign
            }
        },
        {
            Utilities:GetAchievementName(11212), -- Raise an Army
            false,
            {
                IgnoreCollapsedChainFilter = true
            },
            {
                60981, -- Raise an Army for Acherus
                60982, -- Raise an Army for the Fel Hammer
                60983, -- Raise an Army for the Dreamgrove
                60984, -- Raise an Army for the Trueshot Lodge
                60985, -- Raise an Army for the Hall of the Guardians
                60986, -- Raise an Army for the Temple of Five Dawns
                60987, -- Raise an Army for the Sanctum of Light
                60988, -- Raise an Army for the Netherlight Temple
                60989, -- Raise an Army for the Hall of Shadows
                60990, -- Raise an Army for the Maelstrom
                60991, -- Raise an Army for the Dreadscar Rift
                60992, -- Raise an Army for Skyhold
            }
        },
        {
            Utilities:GetAchievementName(11223), -- Legendary Research
            false,
            {
                IgnoreCollapsedChainFilter = true
            },
            {
                60962, -- Legendary Research of the Ebon Blade
                60963, -- Legendary Research of the Illidari
                60964, -- Legendary Research of the Dreamgrove
                60965, -- Legendary Research of the Unseen Path
                60966, -- Legendary Research of the Tirisgarde
                60967, -- Legendary Research of Five Dawns
                60968, -- Legendary Research of the Silver Hand
                60969, -- Legendary Research of the Netherlight Conclave
                60970, -- Legendary Research of the Uncrowned
                60971, -- Legendary Research of the Maelstrom
                60972, -- Legendary Research of the Black Harvest
                60973, -- Legendary Research of the Valarjar
            }
        },
        {
            Utilities:GetAchievementName(10460), -- Hidden  Potential
            false,
            {
                IgnoreCollapsedChainFilter = true
            },
            {
                42287, -- Hidden Potential of the Dreathlord
                42288, -- Hidden Potential of the Slayer
                42289, -- Hidden Potential of the Archdruid
                42290, -- Hidden Potential of the Huntmaster
                42291, -- Hidden Potential of the Archmage
                42292, -- Hidden Potential of the Grandmaster
                42293, -- Hidden Potential of the Highlord
                42294, -- Hidden Potential of the High Priest
                42295, -- Hidden Potential of the Shadowblade
                42296, -- Hidden Potential of the Farseer
                42297, -- Hidden Potential of the Netherlord
                42298, -- Hidden Potential of the Battlelord
            }
        }
    }

    local ACMList = { 
        EXPANSION_NAME6,
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACMList_Zones,
        ACMList_DungeonsRaids,
        ACMList_Orderhalls
    }

    return ACMList
end