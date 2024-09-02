--------------------------------------------------------------------------------
--[[ Lore Achievements - Utility and wrapper functions for achievement data. ]]--
--
-- by erglo <erglo.coder+HNLM@gmail.com>
--
-- Copyright (C) 2024  Erwin D. Glockner (aka erglo, ergloCoder)
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see http://www.gnu.org/licenses.
--
--------------------------------------------------------------------------------

local AddonID, ns = ...

local LocalAchievementUtil = ns.utils.achieve
local LocalMapUtils = ns.utils.worldmap

local THE_LOREMASTER_ID = 7520  -- "The Loremaster" (category "Quests")
local LOREMASTER_OF_THE_DRAGON_ISLES_ID = 16585  -- (still optional in 11.0.2)
local LOREMASTER_OF_KHAZ_ALGAR_ID = 20596  -- (still optional in 11.0.2)
                                                                                --> TODO - Add to 'utils/worldmap.lua'
-- The War Within
LocalMapUtils.KHAZ_ALGAR_MAP_ID = 2274
LocalMapUtils.RINGING_DEEPS_MAP_ID = 2214
LocalMapUtils.HALLOWFALL_MAP_ID = 2215
LocalMapUtils.ISLE_OF_DORN_MAP_ID = 2248
LocalMapUtils.AZJ_KAHET_MAP_ID = 2255

LocalMapUtils.ZUL_DRAK_MAP_ID = 121
LocalMapUtils.VASHJIR_MAP_ID = 203
LocalMapUtils.KELPTHAR_FOREST_MAP_ID = 201
LocalMapUtils.ABYSSAL_DEPTHS_MAP_ID = 204
LocalMapUtils.SHIMMERING_EXPANSE_MAP_ID = 205
LocalMapUtils.RUINS_OF_GILNEAS_MAP_ID = 217
LocalMapUtils.KRASARANG_WILDS_MAP_ID = 418
LocalMapUtils.ISLE_OF_THUNDER_MAP_ID = 504
-- LocalMapUtils.ORIBOS_MAP_ID = 1670

LocalMapUtils.NAGRAND_MAP_ID = 107      -- Burning Crusade, Outland
LocalMapUtils.NAGRAND_WOD_MAP_ID = 550  -- Warlords Of Draenor, Draenor         --> FIXME - Change this in 'utils/worldmap.lua'
LocalMapUtils.SHOLAZAR_BASIN_MAP_ID = 119
LocalMapUtils.GARRISON_ALLIANCE = 582
LocalMapUtils.GARRISON_HORDE = 590

LocalMapUtils.BLASTED_LANDS_MAP_ID = 17
LocalMapUtils.DARKSHORE_MAP_ID = 62
LocalMapUtils.FERALAS_MAP_ID = 69
LocalMapUtils.AZSHARA_MAP_ID = 76
LocalMapUtils.FELWOOD_MAP_ID = 77
LocalMapUtils.TEROKKAR_FOREST_MAP_ID = 108
LocalMapUtils.ICECROWN_MAP_ID = 118
LocalMapUtils.MOUNT_HYJAL_MAP_ID = 198
LocalMapUtils.SILITHUS_MAP_ID = 81
LocalMapUtils.ULDUM_MAP_ID = 249        -- Cataclysm
LocalMapUtils.ULDUM_BFA_MAP_ID = 1527   -- Battle for Azeroth
LocalMapUtils.VALE_OF_ETERNAL_BLOSSOMS_MAP_ID = 390       -- Mists of Pandaria
LocalMapUtils.VALE_OF_ETERNAL_BLOSSOMS_BFA_MAP_ID = 1530  -- Battle for Azeroth
LocalMapUtils.STRANGLETHORN_MAP_ID = 224
LocalMapUtils.NORTHERN_STRANGLETHORN_MAP_ID = 50
LocalMapUtils.CAPE_OF_STRANGLETHORN_MAP_ID = 210
LocalMapUtils.DALARAN_LEGION_MAP_ID = 627
LocalMapUtils.TIRISFAL_GLADES_MAP_ID = 18
LocalMapUtils.TIRISFAL_GLADES_BFA_MAP_ID = 2070
                                                                                --> TODO - Add to 'utils/achievements.lua'
-- REF.: <https://www.townlong-yak.com/framexml/55818/Blizzard_FrameXMLBase/Constants.lua>
local BIT_FLAG_ACCOUNT_WIDE_ACHIEVEMENT = ACHIEVEMENT_FLAGS_ACCOUNT  --> 0x00020000 == 131072

local function IsAccountWideAchievement(achievementFlags)
    if not achievementFlags then return end
    return bit.band(BIT_FLAG_ACCOUNT_WIDE_ACHIEVEMENT, achievementFlags) ~= 0
end

----- Faction Groups -----------------------------------------------------------

-- Quest faction groups: {Alliance=1, Horde=2, Neutral=3}
local QuestFactionGroupID = EnumUtil.MakeEnum(PLAYER_FACTION_GROUP[1], PLAYER_FACTION_GROUP[0], "Neutral")
QuestFactionGroupID["Player"] = QuestFactionGroupID[ UnitFactionGroup("player") ]

ns.QuestFactionGroupID = QuestFactionGroupID

--------------------------------------------------------------------------------

local LocalLoreUtil = {}
ns.lore = LocalLoreUtil

LocalLoreUtil.OptionalAchievements = {
    LOREMASTER_OF_KHAZ_ALGAR_ID,
    20597,                              -- War Within
    LOREMASTER_OF_THE_DRAGON_ISLES_ID,
    15325, 15638, 17739, 19026, 16406,  -- Dragonflight
    15515, 19719,
    14961, 15259, 15579,                -- Shadowlands
    13553, 13700, 13709, 13710, 13791,  -- Battle for Azeroth
    12479, 12891, 13466, 13467, 14157,
    13283, 13284, 13925, 13924, 13517,
    14153, 14154, 12480, 13049, 13251,
    10617, 11546, 12066, 11240, 40582,  -- Legion
    40583,
     9491,  9492,                       -- Draenor
     9606,  9602, 10265, 10072,
     9607,  9605,  9674,  9615,
     7928,  7929,  8099,                -- Pandaria
     5859,                              -- Cataclysm
     1596,                              -- Northrend
      941,   940,   939,   938,         -- Nesingwary quests
}
--[[
Notes:
    -- The War Within
    20596 --> "Loremaster of Khaz Algar"  (optional in 11.0.2)
    20597 --> "The War Within"
    -- Dragonflight
    19719 --> "Reclamation of Gilneas"  (Added in patch 10.2.5)
    19026 --> "Defenders of the Dream" (Emerald Dream storylines)
    17739 --> "Embers of Neltharion" (Zaralek Cavern storylines)
    16585 --> "Loremaster of the Dragon Isles" (still optional in 11.0.2)
    16406 --> "All Sides of the Story"
    15638 --> "Dracthyr, Awaken" (Forbidden Reach storylines, Horde)
    15515 --> "Path to Enlightenment" (Zaralek Cavern storylines)
    15325 --> "Dracthyr, Awaken" (Forbidden Reach storylines, Alliance)
    -- Shadowlands
    15259 --> "Secrets of the First Ones" (Zereth Mortis storylines)
    15579 --> "Return to Lordaeron" (Added in patch 9.2.5)
    14961 --> "Chains of Domination" (The Maw storylines)
    -- Battle for Azeroth
    13791 --> "Making the Mount" (Mechaspider storyline in Mechagon)
    13710 --> "Sunken Ambitions" (Nazjatar storylines, Alliance)
    13709 --> "Unfathomable" (Nazjatar storylines, Horde)
    13700 --> "The Mechagonian Threat" (Mechagon storyline, Horde)
    13553 --> "The Mechagonian Threat" (Mechagon storyline, Alliance)
    -- Legion
    12066 --> "You Are Now Prepared!" (Argus campaign)
    40583 --> "You Are Now Prepared! (char specific hidden copy)" (Added in patch 11.0.0)
    11546 --> "Breaching the Tomb" (Legionfall campaign)
    40582 --> "Breaching the Tomb (char specific hidden copy)" (Added in 11.0.0)
    10617 --> "Nightfallen But Not Forgotten" (Suramar Nightfallen relationship)
    -- Draenor
    9492 --> "The Garrison Campaign" (Horde)
    9491 --> "The Garrison Campaign" (Alliance)
    -- Pandaria
    8099 --> "Isle of Thunder" (Isle of Thunder storylines)
    7929 --> "Dominance Offensive Campaign" (Horde, Krasarang Wilds, Dominance Offensive storylines)
    7928 --> "Operation: Shieldwall Campaign" (Alliance, Krasarang Wilds, Operation: Shieldwall storylines)
    -- Nesingwary quests
    941 --> "Hemet Nesingwary: The Collected Quests"
    940 --> "The Green Hills of Stranglethorn" (Eastern Kingdoms, Northern Stranglethorn)
    939 --> "Hills Like White Elekk" (Outland, Nagrand)
    938 --> "The Snows of Northrend" (Northrend)

    13467 --> "Tides of Vengeance" (Battle for Azeroth War Campaign, Alliance)
    13466 --> "Tides of Vengeance" (Battle for Azeroth War Campaign, Horde)
    12891 --> "A Nation United" (extra storylines for Kul Tiras, Alliance)
    12479 --> "Zandalar Forever!" (extra storylines for Zandalar, Horde)

    14157,  -- "The Corruptor's End" (Black Empire Campaign storyline)
    14154,  -- "Defend the Vale" (N'Zoth Assaults in Vale of Eternal Blossoms)
    14153,  -- "Uldum Under Assault" (N'Zoth Assaults in Uldum)
    13925 or 13924, -- "The Fourth War" (Alliance/Horde)
    13517,  -- (meta, "Two Sides to Every Tale")
    13283 or 13284,  -- "Frontline Warrior" (Alliance/Horde)
    13251,  -- "In Teldrassil's Shadow" (Tyrande's Ascension storyline, Alliance, storyline/in-darkest-night-797)
    13049,  -- "The Long Con" (Alliance, Roko the Wandering Merchant's storyline in Tiragarde Sound)
    12480,  -- "A Bargain of Blood" (Horde, Blood Gate storyline in Zuldazar)

    10265 or 10072,  -- (meta) "Rumble in the Jungle" (Horde/Alliance)
    9674,  -- (bonus) "I Want More Talador" (Talador bonus objectives)
    9615,  -- (bonus) "With a Nagrand Cherry On Top" (Nagrand bonus objectives)
    9607,  -- (bonus) "Make It a Bonus" (Gorgrond bonus objectives)
    9606 or 9602, -- "Frostfire Fridge" (Horde) (Frostfire Ridge bonus objectives), "Shoot For the Moon" (Alliance) (Shadowmoon Valley bonus objectives)
    9605,  -- (bonus) "Arak Star" (Spires of Arak bonus objectives)

    5859,  -- (extra) "Legacy of Leyara" (Leyara quests in Mount Hyjal and the Molten Front)

    11240,  -- (extra) "Harbinger" ("Unearth the stories of the Harbingers of the Legion's invasion.")
]]

function LocalLoreUtil:IsOptionalAchievement(achievementID)
    return tContains(self.OptionalAchievements, achievementID)
end

function LocalLoreUtil:IsHiddenCharSpecificAchievement(achievementID)
    local exceptions = {
        40583,  -- "You Are Now Prepared! (char specific hidden copy)" (Added in patch 11.0.0)
        40582,  -- "Breaching the Tomb (char specific hidden copy)" (Added in 11.0.0)
        -- 40573,  -- "Shadow of the Betrayer (char specific hidden copy)" (Added in 11.0.0)
    }
    local isOptionalAchievement = self:IsOptionalAchievement(achievementID)
    local hasParentAchievement = self:HasParentAchievement(achievementID)
    return tContains(exceptions, achievementID) or (not isOptionalAchievement and not hasParentAchievement)
end

function LocalLoreUtil:IsAccountWideAchievement(achievementInfo)
    return IsAccountWideAchievement(achievementInfo.flags)
end

LocalLoreUtil.AchievementsLocationMap = {
    ----- War Within -----
    [LocalMapUtils.RINGING_DEEPS_MAP_ID] = {
        19560,  -- "The Ringing Deeps"
        40799,  -- "Sojourner of The Ringing Deeps"
    },
    [LocalMapUtils.HALLOWFALL_MAP_ID] = {
        20598,  -- "Hallowfall"
        40844,  -- "Sojourner of Hallowfall"
        40360,  -- (optional) "Life on the Farm"
    },
    [LocalMapUtils.ISLE_OF_DORN_MAP_ID] = {
        20118,  -- "The Isle of Dorn"
        20595,  -- "Sojourner of Isle of Dorn"
    },
    [LocalMapUtils.AZJ_KAHET_MAP_ID] = {
        19559,  -- "Azj-Kahet"
        40636,  -- "Sojourner of Azj-Kahet"
    },
    ----- Dragonflight -----
    [LocalMapUtils.THE_WAKING_SHORES_MAP_ID] = {
        16334, -- "Waking Hope"
        16401, -- "Sojourner of the Waking Shores"
    },
    [LocalMapUtils.OHNAHRAN_PLAINS_MAP_ID] = {
        15394, -- "Ohn'a'Roll"
        16405, -- "Sojourner of Ohn'ahran Plains"
    },
    [LocalMapUtils.THE_AZURE_SPAN_MAP_ID] = {
        16336, -- "Azure Spanner"
        16428, -- "Sojourner of Azure Span"
    },
    [LocalMapUtils.THALDRASZUS_MAP_ID] = {
        16363, -- "Just Don't Ask Me to Spell It"
        16398, -- "Sojourner of Thaldraszus"
    },
    [LocalMapUtils.ZARALEK_CAVERN_MAP_ID] = {
        17739, -- (extra storylines) "Embers of Neltharion"
    },
    [LocalMapUtils.THE_FORBIDDEN_REACH_MAP_ID] = {
        QuestFactionGroupID.Player == QuestFactionGroupID.Horde and 15638 or 15325,  -- (extra) "Dracthyr, Awaken"
    },
    [LocalMapUtils.EMERALD_DREAM_MAP_ID] = {
        19026, -- (extra) "Defenders of the Dream"
    },
    [LocalMapUtils.RUINS_OF_GILNEAS_MAP_ID] = {
        19719, -- (extra) "Reclamation of Gilneas"  (Added in patch 10.2.5)
        --> Note: This zone has no Loremaster quest by default.
    },
    ----- Shadowlands -----
    [LocalMapUtils.REVENDRETH_MAP_ID] = {
        13878, -- "The Master of Revendreth"
        14798, -- "Sojourner of Revendreth"
    },
    [LocalMapUtils.BASTION_MAP_ID] = {
        14281, -- "The Path to Ascension"
        14801, -- "Sojourner of Bastion"
    },
    [LocalMapUtils.MALDRAXXUS_MAP_ID] = {
        14206, -- "Blade of the Primus"
        14799, -- "Sojourner of Maldraxxus"
    },
    [LocalMapUtils.ARDENWEALD_MAP_ID] = {
        14164, -- "Awaken, Ardenweald"
        14800, -- "Sojourner of Ardenweald" (optional?)
    },
    [LocalMapUtils.THE_MAW_MAP_ID] = {
        14961, -- (extra) "Chains of Domination"
        --> Note: This zone has no Loremaster quest by default.
    },
    [LocalMapUtils.ZERETH_MORTIS_MAP_ID] = {
        15259, -- (extra) "Secrets of the First Ones"
        15515, -- (extra) "Path to Enlightenment"
        -- 15514, -- (meta) "Unlocking the Secrets"
        --> Note: This zone has no Loremaster quest by default.
    },
    [LocalMapUtils.TIRISFAL_GLADES_MAP_ID] = {
        15579, -- (extra storyline) "Return to Lordaeron"
        --> TODO - QuestFactionGroupID.Player == QuestFactionGroupID.Horde and 1295 or 1294  --> (storylineIDs of "Return to Lordaeron")
        --> Note: This zone has no Loremaster quest by default.
        --> Note: Two mapIDs for Tirisfal, do show same achievements on both.
    },
    [LocalMapUtils.TIRISFAL_GLADES_BFA_MAP_ID] = {
        15579, -- (extra storyline) "Return to Lordaeron"
        --> TODO - QuestFactionGroupID.Player == QuestFactionGroupID.Horde and 1295 or 1294  --> (storylineIDs of "Return to Lordaeron")
        --> Note: This zone has no Loremaster quest by default.
    },
    ----- Battle for Azeroth -----
    [LocalMapUtils.SILITHUS_MAP_ID] = {
        4934,  -- (Loremaster) "Silithus Quests"
        14157,  -- "The Corruptor's End" (Black Empire Campaign storyline)
    },
    [LocalMapUtils.DARKSHORE_MAP_ID] = {
        QuestFactionGroupID.Player == QuestFactionGroupID.Alliance and 4928,  -- (Loremaster) "Darkshore Quests" (Alliance)
        QuestFactionGroupID.Player == QuestFactionGroupID.Alliance and 13251,  -- "In Teldrassil's Shadow" (Tyrande's Ascension storyline, Alliance, storyline/in-darkest-night-797)
    },
    [LocalMapUtils.TIRAGARDE_SOUND_MAP_ID] = {
        QuestFactionGroupID.Player == QuestFactionGroupID.Alliance and 12473,  -- (Loremaster) "A Sound Plan" (Alliance)
        QuestFactionGroupID.Player == QuestFactionGroupID.Alliance and 13049,  -- "The Long Con" (Alliance, Roko the Wandering Merchant's storyline in Tiragarde Sound)
    },
    [LocalMapUtils.ZULDAZAR_MAP_ID] = {
        QuestFactionGroupID.Player == QuestFactionGroupID.Horde and 11861,  -- (Loremaster) "The Throne of Zuldazar" (Horde)
        QuestFactionGroupID.Player == QuestFactionGroupID.Horde and 12480,  -- (optional) "A Bargain of Blood" (Horde, Blood Gate storyline in Zuldazar)
    },
    [LocalMapUtils.ULDUM_MAP_ID] = {
        4872, -- (Loremaster) "Unearthing Uldum" (Cataclysm)
        14153,  -- "Uldum Under Assault" (Battle for Azeroth) 
        --> Note: Two mapIDs for Uldum, do show same achievements on both.
    },
    [LocalMapUtils.ULDUM_BFA_MAP_ID] = {
        4872, -- (Loremaster) "Unearthing Uldum" (Cataclysm)
        14153,  -- "Uldum Under Assault" (Battle for Azeroth)
    },
    [LocalMapUtils.VALE_OF_ETERNAL_BLOSSOMS_MAP_ID] = {
        14154,  -- "Defend the Vale" (N'Zoth Assaults)
        --> Note: This zone has no Loremaster quest by default.
        --> Note: Two mapIDs for Vale of Eternal Blossoms, do show same achievements on both.
    },
    [LocalMapUtils.VALE_OF_ETERNAL_BLOSSOMS_BFA_MAP_ID] = {
        14154,  -- "Defend the Vale" (N'Zoth Assaults)
        --> Note: This zone has no Loremaster quest by default.
    },

    [LocalMapUtils.NAZJATAR_MAP_ID] = {
        QuestFactionGroupID.Player == QuestFactionGroupID.Horde and 13709 or 13710,  -- (extra) "Unfathomable" (Horde), "Sunken Ambitions" (Alliance)
        -- 13638, -- (meta achievement) "Undersea Usurper"  --> "Complete the Nazjatar achievements listed below."
        --> Note: This zone has no Loremaster quest by default.
    },
    [LocalMapUtils.MECHAGON_ISLAND_MAP_ID] = {
        QuestFactionGroupID.Player == QuestFactionGroupID.Horde and 13700 or 13553,  -- (extra) "The Mechagonian Threat"
        13791,  -- (optional) "Making the Mount"
        -- 13541, -- (meta achievement) "Mecha-Done"  --> "Complete the Mechagon achievements listed below."
        --> Note: This zone has no Loremaster quest by default.
    },
    ----- Legion -----
    [LocalMapUtils.SURAMAR_MAP_ID] = {
        11124, -- (Loremaster) "Good Suramaritan"
        10617, -- (extra) "Nightfallen But Not Forgotten"
        -- 11340, -- (extra/meta) "Insurrection"  --> "Complete the Suramar storylines listed below."
    },
    -- [LocalMapUtils.DALARAN_LEGION_MAP_ID] = {                                --> FIXME - Doesn't appear on the map
    --     11240,  -- (extra) "Harbinger" (Harbingers' stories)
    --     --> Note: This zone has no Loremaster quest by default.
    -- },
    ----- Draenor -----
    [QuestFactionGroupID.Player == QuestFactionGroupID.Horde and LocalMapUtils.FROSTFIRE_RIDGE_MAP_ID or LocalMapUtils.SHADOWMOON_VALLEY_MAP_ID] = {
        QuestFactionGroupID.Player == QuestFactionGroupID.Horde and 8671 or 8845,  -- (Loremaster) "You'll Get Caught Up In The... Frostfire!" (Horde), "As I Walk Through the Valley of the Shadow of Moon" (Alliance)
        QuestFactionGroupID.Player == QuestFactionGroupID.Horde and 9606 or 9602, -- "Frostfire Fridge" (Horde) (Frostfire Ridge bonus objectives), "Shoot For the Moon" (Alliance) (Shadowmoon Valley bonus objectives)
    },
    -- [QuestFactionGroupID.Player == QuestFactionGroupID.Horde and LocalMapUtils.GARRISON_HORDE or LocalMapUtils.GARRISON_ALLIANCE] = {
    --     QuestFactionGroupID.Player == QuestFactionGroupID.Horde and 10074 or 10067,  -- (extra) "In Pursuit of Gul'dan" (Garrison Campaign chapters)
    --     QuestFactionGroupID.Player == QuestFactionGroupID.Horde and 9529 or 9528,  -- (optional) "On the Shadow's Trail" (Horde/Alliance)
    -- },                                                                       --> FIXME - Doesn't appear on the map
    [LocalMapUtils.GORGROND_MAP_ID] = {
        QuestFactionGroupID.Player == QuestFactionGroupID.Horde and 8924 or 8923,  -- (Loremaster) "Putting the Gore in Gorgrond" (Horde/Alliance)
        9607,  -- (bonus) "Make It a Bonus" (Gorgrond bonus objectives)
    },
    [LocalMapUtils.SPIRES_OF_ARAK_MAP_ID] = {
        QuestFactionGroupID.Player == QuestFactionGroupID.Horde and 8926 or 8925,  -- (Loremaster) "Between Arak and a Hard Place" (Horde/Alliance)
        9605,  -- (bonus) "Arak Star" (Spires of Arak bonus objectives)
    },
    [LocalMapUtils.TALADOR_MAP_ID] = {
        QuestFactionGroupID.Player == QuestFactionGroupID.Horde and 8919 or 8920,  -- (Loremaster) "Don't Let the Tala-door Hit You on the Way Out" (Horde/Alliance)
        9674,  -- (bonus) "I Want More Talador" (Talador bonus objectives)
    },
    [LocalMapUtils.NAGRAND_WOD_MAP_ID] = {
        QuestFactionGroupID.Player == QuestFactionGroupID.Horde and 8928 or 8927,  -- (Loremaster) "Nagrandeur" (Horde/Alliance)
        9615,  -- (bonus) "With a Nagrand Cherry On Top" (Nagrand bonus objectives)
    },
    [LocalMapUtils.TANAAN_JUNGLE_MAP_ID] = {
        QuestFactionGroupID.Player == QuestFactionGroupID.Horde and 10265 or 10072,  -- (meta) "Rumble in the Jungle" (Horde/Alliance)
        --> Note: This zone has no Loremaster quest by default.
    },
    ----- Pandaria -----
    [LocalMapUtils.KRASARANG_WILDS_MAP_ID] = {
        QuestFactionGroupID.Player == QuestFactionGroupID.Horde and 6536 or 6535,  -- (Loremaster) "Mighty Roamin' Krasaranger"
        QuestFactionGroupID.Player == QuestFactionGroupID.Horde and 7929 or 7928,  -- (extra) "Dominance Offensive Campaign" (Horde), "Operation: Shieldwall Campaign" (Alliance)
    },
    [LocalMapUtils.ISLE_OF_THUNDER_MAP_ID] = {
        8099, -- (extra storylines) "Isle of Thunder"
        -- 8121, -- (meta) "Stormbreaker"  --> "Complete the Isle of Thunder achievements listed below.""
        --> Note: This zone has no Loremaster quest by default.
    },
    ----- Cataclysm -----
    [LocalMapUtils.MOUNT_HYJAL_MAP_ID] = {
        4870,  -- (Loremaster) "Coming Down the Mountain"
        5859,  -- (extra) "Legacy of Leyara" (Leyara quests in Mount Hyjal and the Molten Front)
        -- 5879, -- (meta) "Veteran of the Molten Front"
    },
    ----- Northrend -----
    [LocalMapUtils.ZUL_DRAK_MAP_ID] = {
        36, -- (Loremaster) "The Empire of Zul'Drak"
        1596, -- (extra) "Guru of Drakuru"
    },
    [LocalMapUtils.SHOLAZAR_BASIN_MAP_ID] = {
        39, -- (Loremaster) "Into the Basin"
        938,  -- (optional) "The Snows of Northrend" (Hemet Nesingwary quests)
    },
    ----- Outland -----
    [LocalMapUtils.NAGRAND_MAP_ID] = {
        QuestFactionGroupID.Player == QuestFactionGroupID.Horde and 1273 or 1192,  -- (Loremaster) "Nagrand Slam" (Horde/Alliance)
        939,  -- (optional) "Hills Like White Elekk" (Hemet Nesingwary quests)
    },
    ----- Eastern Kingdoms -----
    [LocalMapUtils.NORTHERN_STRANGLETHORN_MAP_ID] = {
        4906,  -- (Loremaster) "Northern Stranglethorn Quests"
        940,  -- (optional) "The Green Hills of Stranglethorn" (Hemet Nesingwary quests)
    },
    [LocalMapUtils.STRANGLETHORN_MAP_ID] = {
        4906,  -- (Loremaster) "Northern Stranglethorn Quests"
        4905,  -- (Loremaster) "Cape of Stranglethorn Quests"
    },

    ----- Continents (Loremaster Achievements) -----

    [LocalMapUtils.KHAZ_ALGAR_MAP_ID] = {
        20596, --> "Loremaster of Khaz Algar" (optional in 11.0.2)
        20597, --> (optional) "The War Within"
    },
    [LocalMapUtils.DRAGON_ISLES_MAP_ID] = {
        16585, -- "Loremaster of the Dragon Isles" (still optional in 11.0.2)
        16406,  -- "All Sides of the Story"
        -- 19790, -- (meta) "The Archives Called, You Answered"
    },
    [LocalMapUtils.THE_SHADOWLANDS_MAP_ID] = {
        14280, -- "Loremaster of Shadowlands"
    },
    [QuestFactionGroupID.Player == QuestFactionGroupID.Horde and LocalMapUtils.ZANDALAR_MAP_ID or LocalMapUtils.KUL_TIRAS_MAP_ID] = {
        QuestFactionGroupID.Player == QuestFactionGroupID.Horde and 13294 or 12593,  -- "Loremaster of Zandalar" (Horde), "Loremaster of Kul Tiras" (Alliance)
        -- QuestFactionGroupID.Player == QuestFactionGroupID.Horde and 12479 or 12891,  -- (optional, part of meta below) "Zandalar Forever!" (Horde), "A Nation United" (Alliance)
        -- QuestFactionGroupID.Player == QuestFactionGroupID.Horde and 13466 or 13467,  -- (optional, part of meta below) "Tides of Vengeance" (Horde), "Tides of Vengeance" (Alliance)
        13517,  -- (meta, "Two Sides to Every Tale")
        --> TODO - 12719,  -- "Spirits Be With You" (Horde) (extra storylines in Zandalar)
    },
    [QuestFactionGroupID.Player == QuestFactionGroupID.Alliance and LocalMapUtils.ZANDALAR_MAP_ID or LocalMapUtils.KUL_TIRAS_MAP_ID] = {
        QuestFactionGroupID.Player == QuestFactionGroupID.Alliance and 13283 or 13284,  -- "Frontline Warrior" (Alliance/Horde)
        QuestFactionGroupID.Player == QuestFactionGroupID.Alliance and 13925 or 13924, -- "The Fourth War" (Alliance/Horde)
        -- QuestFactionGroupID.Player == QuestFactionGroupID.Alliance and 13467 or 13466,  -- "Tides of Vengeance" (Alliance/Horde)
    },
    [LocalMapUtils.BROKEN_ISLES_MAP_ID] = {
        11157, -- "Loremaster of Legion"
        -- 11544, -- (optional) "Defender of the Broken Isles"
        -- 11186, -- (optional) "Tehd & Marius' Excellent Adventure"
    },
    [LocalMapUtils.ARGUS_MAP_ID] = {
        12066, -- (optional) "You Are Now Prepared!" (Argus campaign)
    },
    [LocalMapUtils.DRAENOR_MAP_ID] = {
        QuestFactionGroupID.Player == QuestFactionGroupID.Horde and 9923 or 9833,  -- "Loremaster of Draenor"
        QuestFactionGroupID.Player == QuestFactionGroupID.Horde and 9492 or 9491,  -- (extra) "The Garrison Campaign"
        -- QuestFactionGroupID.Player == QuestFactionGroupID.Horde and 9562 or 9564,  -- (bonus) "Securing Draenor" (Horde/Alliance)
    },
    [LocalMapUtils.PANDARIA_MAP_ID] = {
        6541, -- "Loremaster of Pandaria"
    },
    [LocalMapUtils.THE_MAELSTROM_MAP_ID] = {
        4875, -- "Loremaster of Cataclysm"
    },
    [LocalMapUtils.NORTHREND_MAP_ID] = {
        41, -- "Loremaster of Northrend"
    },
    [LocalMapUtils.OUTLAND_MAP_ID] = {
        1262, -- "Loremaster of Outland"
        941,  -- (optional) "Hemet Nesingwary: The Collected Quests"
    },
    [LocalMapUtils.EASTERN_KINGDOMS_MAP_ID] = {
        1676, -- "Loremaster of Eastern Kingdoms"
    },
    [LocalMapUtils.KALIMDOR_MAP_ID] = {
        1678, -- "Loremaster of Kalimdor"
    },
    [LocalMapUtils.AZEROTH_MAP_ID] = {
        1678, -- "Loremaster of Kalimdor"
        1676, -- "Loremaster of Eastern Kingdoms"
    },
}

--------------------------------------------------------------------------------

-- -- REF.: <https://wowpedia.fandom.com/wiki/API_GetAchievementCriteriaInfo>      --> TODO - Add to 'utils/achievements.lua'
-- -- 
-- LocalLoreUtil.CriteriaType = {
--     Achievement = 8,
--     Quest = 27,
-- }

--------------------------------------------------------------------------------

local achievementParentList = {}  -- {childID = parentID, ...}

-- Note: some achievements combine different zones
local childParentExceptions = {
    -- 12455 --> "Westfall & Duskwood Quests" (Alliance, Eastern Kingdoms)      [works]
    -- 12456 --> "Loch Modan & Wetlands Quests" (Alliance, Eastern Kingdoms)    [needs work-around, why?]
    [4899] = 12456,  -- Loch Modan Quests (Alliance)
    [12429] = 12456, -- Wetlands Quests (Alliance)
}

LocalLoreUtil.numAchievements = 0  -- Keep track of all Loremaster achievements

local function FillAchievementParentList(parentAchievementID)
    local candidateAchievementID = parentAchievementID or THE_LOREMASTER_ID

    local criteriaInfoList = LocalAchievementUtil.GetAchievementCriteriaInfoList(candidateAchievementID)

    if criteriaInfoList then
        for i, criteriaInfo in ipairs(criteriaInfoList) do
            if C_AchievementInfo.IsValidAchievement(criteriaInfo.assetID) then
                achievementParentList[criteriaInfo.assetID] = candidateAchievementID
                LocalLoreUtil.numAchievements = LocalLoreUtil.numAchievements + 1
                FillAchievementParentList(criteriaInfo.assetID)
            end
        end
    end
end

function LocalLoreUtil:GetParentAchievementID(achievementID)
    if TableIsEmpty(achievementParentList) then
        FillAchievementParentList()
        -- Also add Dragonflight's "Loremaster of the Dragon Isles"
        -- (Not yet added by Blizzard to the main achievement)                  --> TODO - Check this frequently (latest: 2024-07-18)
        FillAchievementParentList(LOREMASTER_OF_THE_DRAGON_ISLES_ID)
    end
    return childParentExceptions[achievementID] or achievementParentList[achievementID]
end

function LocalLoreUtil:HasParentAchievement(achievementID)
    local parentAchievementID = self:GetParentAchievementID(achievementID)
    return parentAchievementID ~= nil
end

function LocalLoreUtil:GetTotalNumLoremasterAchievements()
    if (LocalLoreUtil.numAchievements == 0) then
        FillAchievementParentList()
        FillAchievementParentList(LOREMASTER_OF_THE_DRAGON_ISLES_ID)
    end
    return LocalLoreUtil.numAchievements
end

