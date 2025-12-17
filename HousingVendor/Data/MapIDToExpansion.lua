-- Map ID to Expansion mapping for HousingVendor addon
-- Used for portal routing and cross-expansion waypoint management

local MapIDToExpansion = {
    -- The War Within (11.0+)
    [2339] = "The War Within", -- Dornogal
    [2248] = "The War Within", -- Isle of Dorn
    [2214] = "The War Within", -- The Ringing Deeps
    [2215] = "The War Within", -- Hallowfall
    [2255] = "The War Within", -- Azj-Kahet / Ara-Kara City of Threads
    [2213] = "The War Within", -- City of Threads Umbral Bazaar
    [2328] = "The War Within", -- The Proscenium
    [2216] = "The War Within", -- Ara-Kara City of Echoes
    [2369] = "The War Within", -- Siren Isle
    [2346] = "The War Within", -- Undermine
    [2371] = "The War Within", -- K'aresh
    [2472] = "The War Within", -- Tazavesh
    [2352] = "The War Within", -- Founders Point
    [2212] = "The War Within", -- Unknown
    [2249] = "The War Within", -- Unknown
    [2253] = "The War Within", -- Unknown
    [2256] = "The War Within", -- Unknown
    -- Dragonflight (10.0+)
    [2022] = "Dragonflight", -- Waking Shore
    [2023] = "Dragonflight", -- Ohn'ahran Plains
    [2024] = "Dragonflight", -- The Azure Span
    [2025] = "Dragonflight", -- Thaldraszus
    [2112] = "Dragonflight", -- Valdrakken
    [2151] = "Dragonflight", -- Forbidden Reach
    [2133] = "Dragonflight", -- Zaralek Cavern
    [2200] = "Dragonflight", -- Emerald Dream
    [2239] = "Dragonflight", -- Bel'ameth
    [1830] = "Dragonflight", -- Unknown
    [2026] = "Dragonflight", -- Unknown    -- Shadowlands (9.0+)
    [1550] = "Shadowlands", -- Overall Shadowlands Map
    [1565] = "Shadowlands", -- Ardenweald
    [1533] = "Shadowlands", -- Bastion
    [1536] = "Shadowlands", -- Maldraxxus
    [1525] = "Shadowlands", -- Revendreth
    [1670] = "Shadowlands", -- Oribos (main quest floor)
    [1671] = "Shadowlands", -- Oribos (FP & Portals)
    [1961] = "Shadowlands", -- Korthia
    [1543] = "Shadowlands", -- The Maw
    [1970] = "Shadowlands", -- Zereth Mortis
    
    -- Battle for Azeroth (8.0+)
    [1161] = "Battle for Azeroth", -- Boralus
    [896] = "Battle for Azeroth", -- Drustvar
    [942] = "Battle for Azeroth", -- Stormsong Valley
    [895] = "Battle for Azeroth", -- Tiragarde Sound
    [1165] = "Battle for Azeroth", -- Dazar'alor
    [1163] = "Battle for Azeroth", -- Dazar'alor The Great Seal
    [863] = "Battle for Azeroth", -- Nazmir
    [864] = "Battle for Azeroth", -- Vol'dun
    [862] = "Battle for Azeroth", -- Zuldazar
    [1462] = "Battle for Azeroth", -- Mechagon
    [1355] = "Battle for Azeroth", -- Nazjatar
    [1186] = "Battle for Azeroth", -- Unknown
    [1473] = "Battle for Azeroth", -- Unknown
    -- Legion (7.0+)
    [885] = "Legion", -- Argus: Antoran Wastes
    [882] = "Legion", -- Argus: Eredath
    [830] = "Legion", -- Argus: Krokuun
    [831] = "Legion", -- Argus: The Vindicaar
    [630] = "Legion", -- Azsuna
    [627] = "Legion", -- Dalaran
    [628] = "Legion", -- Dalaran Underbelly
    [790] = "Legion", -- Eye of Azshara
    [649] = "Legion", -- Helheim
    [650] = "Legion", -- Highmountain
    [634] = "Legion", -- Stormheim
    [680] = "Legion", -- Suramar
    [684] = "Legion", -- Suramar: Temple of Fal'adora
    [685] = "Legion", -- Suramar: Falanaar Tunnels
    [646] = "Legion", -- The Broken Shore
    [652] = "Legion", -- Thundertotem
    [750] = "Legion", -- Thundertotem (alternate)
    [641] = "Legion", -- Val'sharah
    [747] = "Legion", -- Val'sharah Dreamgrove
    [715] = "Legion", -- Val'sharah Emerald Dreamway
    [726] = "Legion", -- The Maelstrom
    [707] = "Legion", -- Helmouth Cliffs - The Hold
    [708] = "Legion", -- Helmouth Cliffs - The Naglfar
    [687] = "Legion", -- Kel'balor
    
    -- Warlords of Draenor (6.0+)    [588] = "Warlords of Draenor", -- Ashran
    [525] = "Warlords of Draenor", -- Frostfire Ridge
    [543] = "Warlords of Draenor", -- Gorgrond
    [550] = "Warlords of Draenor", -- Nagrand
    [539] = "Warlords of Draenor", -- Shadowmoon Valley
    [542] = "Warlords of Draenor", -- Spires of Arak
    [535] = "Warlords of Draenor", -- Talador
    [534] = "Warlords of Draenor", -- Tanaan Jungle
    [624] = "Warlords of Draenor", -- Warspear
    [622] = "Warlords of Draenor", -- Stormshield
    [590] = "Warlords of Draenor", -- Garrison - Horde
    [582] = "Warlords of Draenor", -- Garrison - Alliance

    -- Mists of Pandaria (5.0+)
    [422] = "Mists of Pandaria", -- Dread Wastes
    [418] = "Mists of Pandaria", -- Krasarang Wilds
    [379] = "Mists of Pandaria", -- Kun-Lai Summit
    [390] = "Mists of Pandaria", -- Shrine of the Seven Stars / Vale of Eternal Blossoms
    [392] = "Mists of Pandaria", -- Shrine of Two Moons
    [371] = "Mists of Pandaria", -- The Jade Forest
    [433] = "Mists of Pandaria", -- The Veiled Stair
    [554] = "Mists of Pandaria", -- Timeless Isle
    [388] = "Mists of Pandaria", -- Townlong Steppes
    [376] = "Mists of Pandaria", -- Valley of the Four Winds

    -- Cataclysm (4.0+)
    [207] = "Cataclysm", -- Deepholm
    [198] = "Cataclysm", -- Mount Hyjal
    [245] = "Cataclysm", -- Tol Barad
    [241] = "Cataclysm", -- Twilight Highlands

    -- Wrath of the Lich King (3.0+)
    [114] = "Wrath of the Lich King", -- Borean Tundra
    [127] = "Wrath of the Lich King", -- Crystalsong Forest
    [125] = "Wrath of the Lich King", -- Dalaran
    [126] = "Wrath of the Lich King", -- Dalaran Underbelly
    [115] = "Wrath of the Lich King", -- Dragonblight
    [116] = "Wrath of the Lich King", -- Grizzly Hills
    [117] = "Wrath of the Lich King", -- Howling Fjord
    [118] = "Wrath of the Lich King", -- Icecrown
    [119] = "Wrath of the Lich King", -- Sholazar Basin
    [120] = "Wrath of the Lich King", -- The Storm Peaks
    [123] = "Wrath of the Lich King", -- Wintergrasp
    [121] = "Wrath of the Lich King", -- Zul'Drak

    -- The Burning Crusade (2.0+)
    [101] = "The Burning Crusade", -- Outland (Twisting Nether)
    [105] = "The Burning Crusade", -- Blade's Edge Mountains
    [100] = "The Burning Crusade", -- Hellfire Peninsula
    [107] = "The Burning Crusade", -- Nagrand
    [109] = "The Burning Crusade", -- Netherstorm
    [104] = "The Burning Crusade", -- Shadowmoon Valley
    [108] = "The Burning Crusade", -- Terokkar Forest
    [102] = "The Burning Crusade", -- Zangarmarsh
    [111] = "The Burning Crusade", -- Shattrath

    -- Classic/Vanilla Zones (Kalimdor)
    [12] = "Classic", -- Kalimdor
    [63] = "Classic", -- Ashenvale
    [76] = "Classic", -- Azshara
    [97] = "Classic", -- Azuremyst Isle
    [106] = "Classic", -- Bloodmyst Isle
    [74] = "Classic", -- Caverns of Time (tunnel)
    [75] = "Classic", -- Caverns of Time (proper)
    [62] = "Classic", -- Darkshore
    [89] = "Classic", -- Darnassus
    [66] = "Classic", -- Desolace
    [1] = "Classic", -- Durotar
    [70] = "Classic", -- Dustwallow Marsh
    [463] = "Classic", -- Echo Isles
    [77] = "Classic", -- Felwood
    [69] = "Classic", -- Feralas
    [80] = "Classic", -- Moonglade
    [7] = "Classic", -- Mulgore
    [10] = "Classic", -- Northern Barrens
    [85] = "Classic", -- Orgrimmar
    [86] = "Classic", -- Orgrimmar Cleft of Shadow
    [81] = "Classic", -- Silithus
    [199] = "Classic", -- Southern Barrens
    [65] = "Classic", -- Stonetalon Mountains
    [71] = "Classic", -- Tanaris
    [57] = "Classic", -- Teldrassil
    [103] = "Classic", -- The Exodar
    [88] = "Classic", -- Thunder Bluff
    [64] = "Classic", -- Thousand Needles
    [249] = "Classic", -- Uldum (also Cataclysm)
    [78] = "Classic", -- Un'Goro Crater
    [83] = "Classic", -- Winterspring

    -- Classic/Vanilla Zones (Eastern Kingdoms)
    [13] = "Classic", -- Eastern Kingdoms
    [204] = "Classic", -- Abyssal Depths (also Cataclysm)
    [14] = "Classic", -- Arathi Highlands
    [15] = "Classic", -- Badlands
    [33] = "Classic", -- Blackrock Mountain
    [17] = "Classic", -- Blasted Lands
    [36] = "Classic", -- Burning Steppes
    [210] = "Classic", -- Cape of Stranglethorn
    [42] = "Classic", -- Deadwind Pass
    [499] = "Classic", -- Deeprun Tram
    [29] = "Classic", -- Dun Morogh
    [47] = "Classic", -- Duskwood
    [23] = "Classic", -- Eastern Plaguelands
    [37] = "Classic", -- Elwynn Forest
    [94] = "Classic", -- Eversong Woods (also TBC)
    [95] = "Classic", -- Ghostlands (also TBC)
    [25] = "Classic", -- Hillsbrad Foothills
    [87] = "Classic", -- Ironforge
    [122] = "Classic", -- Isle of Quel'Danas (also TBC)
    [201] = "Classic", -- Kelp'thar Forest (also Cataclysm)
    [48] = "Classic", -- Loch Modan
    [50] = "Classic", -- Northern Stranglethorn
    [49] = "Classic", -- Redridge Mountains
    [217] = "Classic", -- Ruins of Gilneas
    [32] = "Classic", -- Searing Gorge
    [205] = "Classic", -- Shimmering Expanse (also Cataclysm)
    [110] = "Classic", -- Silvermoon City (also TBC)
    [21] = "Classic", -- Silverpine Forest
    [84] = "Classic", -- Stormwind City
    [51] = "Classic", -- Swamp of Sorrows
    [26] = "Classic", -- The Hinterlands
    [18] = "Classic", -- Tirisfal Glades
    [2070] = "Classic", -- Tirisfal Glades (BfA updated)
    [90] = "Classic", -- Undercity
    [22] = "Classic", -- Western Plaguelands
    [52] = "Classic", -- Westfall
    [56] = "Classic", -- Wetlands

    -- BfA updated Classic zones
    [1527] = "Battle for Azeroth", -- Uldum (BfA assault version)
    [1530] = "Battle for Azeroth", -- Vale of Eternal Blossoms (BfA assault version)
}

-- Make globally accessible
_G["HousingMapIDToExpansion"] = MapIDToExpansion

return MapIDToExpansion
