local ADDON_NAME = ...
local KhamulsAchievementFilter = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local Utilities = KhamulsAchievementFilter:GetModule("Utilities")

local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

function GetHousingMN()

    -- Flat achievement list
    local ACMListFlat = {
        _G.EXPANSION_NAME11, -- Midnight
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            62387, -- It's Nearly Midnight
            62185, -- Ever Painting
            61574, -- Legends Never Die
            42788, -- Alchemizing at Midnight
            42792, -- Blacksmithing at Midnight
            42795, -- Cooking at Midnight
            42787, -- Enchanting at Midnight
            42798, -- Engineering at Midnight
            42797, -- Fishing at Midnight
            42793, -- Herbalism at Midnight
            42796, -- Inscribing at Midnight
            42789, -- Jewelcrafting at Midnight
            42786, -- Leatherworking at Midnight
            42791, -- Mining at Middnight
            42790, -- Skinning at Midnight
            42794, -- Tailoring at Midnight
            62144, -- Prey: Mad Magisters (Hard)
            62153, -- Prey: Insane Inventors (Hard)
            62154, -- Prey: A Different Kind of Void (Hard)
            62155, -- Prey: Ethereal Assassins (Hard)
            62156, -- Prey: Anger Management (Hard)
            62157, -- Prey: Sadistic Shamans (Hard)
            62158, -- Prey: The Fallen Farstriders (Hard)
            62159, -- Prey: Bloody Green Thumbs (Hard)
            62160, -- Prey: Blinded By The Light (Hard)
            62161, -- Prey: Outsmarting the Schemers (Hard)
            62162, -- Prey: Dominating the Void (Hard)
            62163, -- Prey: Chasing Death (Hard)
            62164, -- Prey: No Rest for the Wretched (Hard)
            62165, -- Prey: A Thorn in the Side (Hard)
            62166, -- Prey: Breaking the Blade (Hard)
            62167, -- Prey: Mad Magisters (Nightmare)
            62168, -- Prey: Insane Inventors (Nightmare)
            62169, -- Prey: A Different Kind of Void (Nightmare)
            62173, -- Prey: Ethereal Assassins (Nightmare)
            62174, -- Prey: Anger Management (Nightmare)
            62175, -- Prey: Sadistic Shamans (Nightmare)
            62176, -- Prey: The Fallen Farstriders (Nightmare)
            62177, -- Prey: Bloody Green Thumbs (Nightmare)
            62178, -- Prey: Blinded By The Light (Nightmare)
            62179, -- Prey: Outsmarting the Schemers (Nightmare)
            62180, -- Prey: Dominating the Void (Nightmare)
            62181, -- Prey: Chasing Death (Nightmare)
            62182, -- Prey: No Rest for the Wretched (Nightmare)
            62183, -- Prey: A Thorn in the Side (Nightmare)
            62184, -- Prey: Breaking the Blade (Nightmare)
        }
    }

    -- Return flat structure if set
    if KhamulsAchievementFilter.db.profile.decorAchievementsSettings.flattenStructure then
        return ACMListFlat
    end

    -- Zone
    local ACMList_Zones = {
        _G.ZONE, -- Zone
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            Utilities:GetZoneNameByMapID(1267), -- Eversong Woods
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                62185, -- Ever Painting
            }
        },
        {
            Utilities:GetZoneNameByMapID(2480), -- Harandar
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                61574, -- Legends Never Die
            }
        }
    }

    -- Trade Skills
    local ACMList_Professions = {
        _G.TRADE_SKILLS, -- Professions
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            42788, -- Alchemizing at Midnight
            42792, -- Blacksmithing at Midnight
            42795, -- Cooking at Midnight
            42787, -- Enchanting at Midnight
            42798, -- Engineering at Midnight
            42797, -- Fishing at Midnight
            42793, -- Herbalism at Midnight
            42796, -- Inscribing at Midnight
            42789, -- Jewelcrafting at Midnight
            42786, -- Leatherworking at Midnight
            42791, -- Mining at Middnight
            42790, -- Skinning at Midnight
            42794, -- Tailoring at Midnight
        }
    }

    -- Prey
    local ACMList_Prey = {
        Utilities:GetAchievementCategoryNameByCategoryID(15605),  -- Prey
        false,
        {
            IgnoreCollapsedChainFilter = true,
            IgnoreFactionFilter = true
        },
        {
            L["Hard"],
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                62144, -- Prey: Mad Magisters (Hard)
                62153, -- Prey: Insane Inventors (Hard)
                62154, -- Prey: A Different Kind of Void (Hard)
                62155, -- Prey: Ethereal Assassins (Hard)
                62156, -- Prey: Anger Management (Hard)
                62157, -- Prey: Sadistic Shamans (Hard)
                62158, -- Prey: The Fallen Farstriders (Hard)
                62159, -- Prey: Bloody Green Thumbs (Hard)
                62160, -- Prey: Blinded By The Light (Hard)
                62161, -- Prey: Outsmarting the Schemers (Hard)
                62162, -- Prey: Dominating the Void (Hard)
                62163, -- Prey: Chasing Death (Hard)
                62164, -- Prey: No Rest for the Wretched (Hard)
                62165, -- Prey: A Thorn in the Side (Hard)
                62166, -- Prey: Breaking the Blade (Hard)
            }
        },
        {
            L["Nightmare"],
            false,
            {
                IgnoreCollapsedChainFilter = true,
                IgnoreFactionFilter = true
            },
            {
                62167, -- Prey: Mad Magisters (Nightmare)
                62168, -- Prey: Insane Inventors (Nightmare)
                62169, -- Prey: A Different Kind of Void (Nightmare)
                62173, -- Prey: Ethereal Assassins (Nightmare)
                62174, -- Prey: Anger Management (Nightmare)
                62175, -- Prey: Sadistic Shamans (Nightmare)
                62176, -- Prey: The Fallen Farstriders (Nightmare)
                62177, -- Prey: Bloody Green Thumbs (Nightmare)
                62178, -- Prey: Blinded By The Light (Nightmare)
                62179, -- Prey: Outsmarting the Schemers (Nightmare)
                62180, -- Prey: Dominating the Void (Nightmare)
                62181, -- Prey: Chasing Death (Nightmare)
                62182, -- Prey: No Rest for the Wretched (Nightmare)
                62183, -- Prey: A Thorn in the Side (Nightmare)
                62184, -- Prey: Breaking the Blade (Nightmare)
            }
        }
    }

    local ACMList = { 
        _G.EXPANSION_NAME11, -- Midnight
        false,
        {
            IgnoreCollapsedChainFilter = true
        },
        ACMList_Zones,
        ACMList_Professions,
        ACMList_Prey,
        {
            62387 -- It's Nearly Midnight
        }
    }

    return ACMList
end