local addonName = "Altoholic"
local addon = _G[addonName]
local colors = addon.Colors
local icons = addon.Icons

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

-- *** Dungeons ***
local DIFFICULTY_DUNGEON_HEROIC = 2
local DIFFICULTY_RAID_10P = 3
local DIFFICULTY_RAID_25P = 4
local DIFFICULTY_RAID_40P = 9
local DIFFICULTY_RAID_10PH = 5
local DIFFICULTY_RAID_25PH = 6
local DIFFICULTY_RAID_LFR = 7
local DIFFICULTY_RAID_FLEX = 14
local DIFFICULTY_RAID_HEROIC = 15
local DIFFICULTY_RAID_MYTHIC = 16
local DIFFICULTY_SCENARIO_HEROIC = 11

local Dungeons = {
	{	-- [1]
		name = EXPANSION_NAME0,	-- "Classic"
		{	-- [1] 10 player raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_10P)),
			{ id = 160, achID = 689, difficulty = DIFFICULTY_RAID_10P },	-- Ahn'Qiraj Ruins
		},
		{	-- [2] 40 player raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_40P)),
			{ id = 48, achID = 686, difficulty = DIFFICULTY_RAID_40P },	-- Molten Core
			{ id = 50, achID = 685, difficulty = DIFFICULTY_RAID_40P },	-- Blackwing Lair
			{ id = 161, achID = 687, difficulty = DIFFICULTY_RAID_40P },	-- Ahn'Qiraj Temple
		},
	},
	{	-- [2]
		name = EXPANSION_NAME1,	-- "The Burning Crusade"
		{	-- [1] heroic dungeons
			name = format("%s - %s", DUNGEONS, GetDifficultyInfo(DIFFICULTY_DUNGEON_HEROIC)),
			{ id = 178, achID = 672, difficulty = DIFFICULTY_DUNGEON_HEROIC },	-- Auchenai Crypts
			{ id = 179, achID = 671, difficulty = DIFFICULTY_DUNGEON_HEROIC },	-- Mana-Tombs
			{ id = 180, achID = 674, difficulty = DIFFICULTY_DUNGEON_HEROIC },	-- Sethekk Halls
			{ id = 181, achID = 675, difficulty = DIFFICULTY_DUNGEON_HEROIC },	-- Shadow Labyrinth
			{ id = 182, achID = 676, difficulty = DIFFICULTY_DUNGEON_HEROIC },	-- Opening of the Dark Portal
			{ id = 183, achID = 673, difficulty = DIFFICULTY_DUNGEON_HEROIC },	-- The Escape From Durnholde
			{ id = 184, achID = 669, difficulty = DIFFICULTY_DUNGEON_HEROIC },	-- Slave Pens
			{ id = 185, achID = 677, difficulty = DIFFICULTY_DUNGEON_HEROIC },	-- The Steamvault
			{ id = 186, achID = 670, difficulty = DIFFICULTY_DUNGEON_HEROIC },	-- Underbog
			{ id = 187, achID = 668, difficulty = DIFFICULTY_DUNGEON_HEROIC },	-- Blood Furnace
			{ id = 188, achID = 667, difficulty = DIFFICULTY_DUNGEON_HEROIC },	-- Hellfire Ramparts
			{ id = 189, achID = 678, difficulty = DIFFICULTY_DUNGEON_HEROIC },	-- Shattered Halls
			{ id = 190, achID = 681, difficulty = DIFFICULTY_DUNGEON_HEROIC },	-- The Arcatraz
			{ id = 191, achID = 680, difficulty = DIFFICULTY_DUNGEON_HEROIC },	-- The Botanica
			{ id = 192, achID = 679, difficulty = DIFFICULTY_DUNGEON_HEROIC },	-- The Mechanar
			{ id = 201, achID = 682, difficulty = DIFFICULTY_DUNGEON_HEROIC },	-- Magisters' Terrace
		},
		{	-- [2] 10 player raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_10P)),
			{ id = 175, achID = 690, difficulty = DIFFICULTY_RAID_10P },	-- Karazhan
		},
		{	-- [3] 25 player raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_25P)),
			{ id = 176, achID = 693, difficulty = DIFFICULTY_RAID_25P },	-- Magtheridon's Lair
			{ id = 177, achID = 692, difficulty = DIFFICULTY_RAID_25P },	-- Gruul's Lair
			{ id = 193, achID = 696, difficulty = DIFFICULTY_RAID_25P },	-- Tempest Keep
			{ id = 194, achID = 694, difficulty = DIFFICULTY_RAID_25P },	-- Serpentshrine Cavern
			{ id = 195, achID = 695, difficulty = DIFFICULTY_RAID_25P },	-- Hyjal Past
			{ id = 196, achID = 697, difficulty = DIFFICULTY_RAID_25P },	-- Black Temple
			{ id = 199, achID = 698, difficulty = DIFFICULTY_RAID_25P },	-- The Sunwell
		},
	},
	{	-- [3]
		name = EXPANSION_NAME2,	-- "Wrath of the Lich King"
		{	-- [1] heroic dungeons
			name = format("%s - %s", DUNGEONS, GetDifficultyInfo(DIFFICULTY_DUNGEON_HEROIC)),
			{ id = 205, achID = 499, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Utgarde Pinnacle
			{ id = 210, achID = 500, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	The Culling of Stratholme
			{ id = 211, achID = 498, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	The Oculus
			{ id = 212, achID = 497, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Halls of Lightning
			{ id = 213, achID = 496, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Halls of Stone
			{ id = 215, achID = 493, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Drak'Tharon Keep
			{ id = 217, achID = 495, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Gundrak
			{ id = 219, achID = 492, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Ahn'kahet: The Old Kingdom
			{ id = 221, achID = 494, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Violet Hold
			{ id = 226, achID = 490, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	The Nexus
			{ id = 241, achID = 491, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Azjol-Nerub
			{ id = 242, achID = 489, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Utgarde Keep
			{ id = 249, achID = 4298, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Trial of the Champion
			{ id = 252, achID = 4519, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	The Forge of Souls
			{ id = 254, achID = 4520, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Pit of Saron
			{ id = 256, achID = 4521, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Halls of Reflection
		},
		{	-- [2] 10 player raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_10P)),
			{ id = 46 , achID = 4396, difficulty = DIFFICULTY_RAID_10P, difficulty2 = DIFFICULTY_RAID_10PH },	--	Onyxia's Lair
			{ id = 159, achID = 576, difficulty = DIFFICULTY_RAID_10P },	--	Naxxramas
			{ id = 223, achID = 622, difficulty = DIFFICULTY_RAID_10P },	--	The Eye of Eternity
			{ id = 224, achID = 1876, difficulty = DIFFICULTY_RAID_10P },	--	The Obsidian Sanctum
			{ id = 239, achID = 4016, difficulty = DIFFICULTY_RAID_10P },	--	Vault of Archavon
			{ id = 243, achID = 2894, difficulty = DIFFICULTY_RAID_FLEX },	--	Ulduar
			{ id = 246, achID = 3917, difficulty = DIFFICULTY_RAID_10P },	--	Trial of the Crusader
			{ id = 279, achID = 4530, difficulty = DIFFICULTY_RAID_10P, difficulty2 = DIFFICULTY_RAID_10PH },	--	Icecrown Citadel
			{ id = 293, achID = 4817, difficulty = DIFFICULTY_RAID_10P },	--	Ruby Sanctum
		},
		{	-- [3] 25 player raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_25P)),
			{ id = 227, achID = 577, difficulty = DIFFICULTY_RAID_25P },	--	Naxxramas
			{ id = 237, achID = 623, difficulty = DIFFICULTY_RAID_25P },	--	The Eye of Eternity
			{ id = 238, achID = 625, difficulty = DIFFICULTY_RAID_25P },	--	The Obsidian Sanctum
			{ id = 240, achID = 4017, difficulty = DIFFICULTY_RAID_25P },	--	Vault of Archavon
			{ id = 248, achID = 3916, difficulty = DIFFICULTY_RAID_25P },	--	Trial of the Crusader
			{ id = 257, achID = 4397, difficulty = DIFFICULTY_RAID_25P, difficulty2 = DIFFICULTY_RAID_25PH },	--	Onyxia's Lair
			{ id = 280, achID = 4597, difficulty = DIFFICULTY_RAID_25P, difficulty2 = DIFFICULTY_RAID_25PH },	--	Icecrown Citadel
			{ id = 294, achID = 4815, difficulty = DIFFICULTY_RAID_25P },	--	Ruby Sanctum
		},		
		{	-- [4] 10 player heroic raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_10PH)),
			{ id = 247, achID = 3918, difficulty = DIFFICULTY_RAID_10PH },	--	Trial of the Grand Crusader
		},
		{	-- [5] 25 player heroic raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_25PH)),
			{ id = 250, achID = 3812, difficulty = DIFFICULTY_RAID_25PH },	--	Trial of the Grand Crusader
		},
	},
	{	-- [4]
		name = EXPANSION_NAME3,	-- "Cataclysm"
		{	-- [1] heroic dungeons
			name = format("%s - %s", DUNGEONS, GetDifficultyInfo(DIFFICULTY_DUNGEON_HEROIC)),
			{ id = 319, achID = 5064, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	The Vortex Pinnacle
			{ id = 320, achID = 5063, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	The Stonecore
			{ id = 321, achID = 5065, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Halls of Origination
			{ id = 322, achID = 5062, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Grim Batol
			{ id = 323, achID = 5060, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Blackrock Caverns
			{ id = 324, achID = 5061, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Throne of the Tides
			{ id = 325, achID = 5066, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Lost City of the Tol'vir
			{ id = 326, achID = 5083, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Deadmines
			{ id = 327, achID = 5093, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Shadowfang Keep
			{ id = 334, achID = 5768, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Zul'Gurub
			{ id = 340, achID = 5769, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Zul'Aman
			{ id = 435, achID = 6117, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	End Time
			{ id = 437, achID = 6118, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Well of Eternity
			{ id = 439, achID = 6119, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Hour of Twilight
		},
		{	-- [2] LFR Raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_LFR)),
			{ id = 416, achID = 6107, bosses = 4, difficulty = DIFFICULTY_RAID_LFR },	--	The Siege of Wyrmrest Temple
			{ id = 417, achID = 6107, bosses = 4, difficulty = DIFFICULTY_RAID_LFR },	--	Fall of Deathwing
		},
		{	-- [3] 10 player raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_10P)),
			{ id = 313, achID = 4842, difficulty = DIFFICULTY_RAID_10P, difficulty2 = DIFFICULTY_RAID_10PH },	--	Blackwing Descent
			{ id = 315, achID = 4850, difficulty = DIFFICULTY_RAID_10P, difficulty2 = DIFFICULTY_RAID_10PH },	--	The Bastion of Twilight
			{ id = 317, achID = 4851, difficulty = DIFFICULTY_RAID_10P, difficulty2 = DIFFICULTY_RAID_10PH },	--	Throne of the Four Winds
			{ id = 328, achID = 5425, difficulty = DIFFICULTY_RAID_10P, difficulty2 = DIFFICULTY_RAID_10PH },	--	Baradin Hold
			{ id = 361, achID = 5802, difficulty = DIFFICULTY_RAID_10P, difficulty2 = DIFFICULTY_RAID_10PH },	--	Firelands
			{ id = 447, achID = 6177, difficulty = DIFFICULTY_RAID_10P, difficulty2 = DIFFICULTY_RAID_10PH },	--	Dragon Soul
		},
		{	-- [4] 25 player raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_25P)),
			{ id = 314, achID = 4842, difficulty = DIFFICULTY_RAID_25P, difficulty2 = DIFFICULTY_RAID_25PH },	--	Blackwing Descent
			{ id = 316, achID = 4850, difficulty = DIFFICULTY_RAID_25P, difficulty2 = DIFFICULTY_RAID_25PH },	--	The Bastion of Twilight
			{ id = 318, achID = 4851, difficulty = DIFFICULTY_RAID_25P, difficulty2 = DIFFICULTY_RAID_25PH },	--	Throne of the Four Winds
			{ id = 329, achID = 5425, difficulty = DIFFICULTY_RAID_25P, difficulty2 = DIFFICULTY_RAID_25PH },	--	Baradin Hold
			{ id = 362, achID = 5802, difficulty = DIFFICULTY_RAID_25P, difficulty2 = DIFFICULTY_RAID_25PH },	--	Firelands
			{ id = 448, achID = 6177, difficulty = DIFFICULTY_RAID_25P, difficulty2 = DIFFICULTY_RAID_25PH },	--	Dragon Soul
		},		
	},
	{	-- [5]
		name = EXPANSION_NAME4,	-- "Mists of Pandaria"
		{	-- [1] heroic dungeons
			name = format("%s - %s", DUNGEONS, GetDifficultyInfo(DIFFICULTY_DUNGEON_HEROIC)),
			{ id = 468, achID = 6758, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Temple of the Jade Serpent
			{ id = 469, achID = 6456, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Stormstout Brewery
			{ id = 470, achID = 6470, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Shado-Pan Monastery
			{ id = 471, achID = 6759, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Gate of the Setting Sun
			{ id = 472, achID = 6762, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Scholomance
			{ id = 473, achID = 6760, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Scarlet Halls
			{ id = 474, achID = 6761, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Scarlet Monastery
			{ id = 519, achID = 6756, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Mogu'shan Palace
			{ id = 554, achID = 6763, difficulty = DIFFICULTY_DUNGEON_HEROIC },	--	Siege of Niuzao Temple
		},
		{	-- [2] LFR Raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_LFR)),
			{ id = 526, achID = 6689, bosses = 4, difficulty = DIFFICULTY_RAID_LFR },	--	Terrace of Endless Spring
			{ id = 527, achID = 6458, bosses = 3, difficulty = DIFFICULTY_RAID_LFR },	--	Guardians of Mogu'shan
			{ id = 528, achID = 6844, bosses = 3, difficulty = DIFFICULTY_RAID_LFR },	--	The Vault of Mysteries
			{ id = 529, achID = 6718, bosses = 3, difficulty = DIFFICULTY_RAID_LFR },	--	The Dread Approach
			{ id = 530, achID = 6845, bosses = 3, difficulty = DIFFICULTY_RAID_LFR },	--	Nightmare of Shek'zeer
			{ id = 610, achID = 8069, bosses = 3, difficulty = DIFFICULTY_RAID_LFR },	--	Last Stand of the Zandalari
			{ id = 611, achID = 8070, bosses = 3, difficulty = DIFFICULTY_RAID_LFR },	--	Forgotten Depths
			{ id = 612, achID = 8071, bosses = 3, difficulty = DIFFICULTY_RAID_LFR },	--	Halls of Flesh-Shaping
			{ id = 613, achID = 8072, bosses = 3, difficulty = DIFFICULTY_RAID_LFR },	--	Pinnacle of Storms
			{ id = 716, achID = 8458, bosses = 4, difficulty = DIFFICULTY_RAID_LFR },	--	Vale of Eternal Sorrows
			{ id = 717, achID = 8459, bosses = 4, difficulty = DIFFICULTY_RAID_LFR },	--	Gates of Retribution
			{ id = 724, achID = 8461, bosses = 3, difficulty = DIFFICULTY_RAID_LFR },	--	The Underhold
			{ id = 725, achID = 8462, bosses = 3, difficulty = DIFFICULTY_RAID_LFR },	--	Downfall
		},
		{	-- [3] heroic scenarios
			name = format("%s - %s", SCENARIOS, GetDifficultyInfo(DIFFICULTY_SCENARIO_HEROIC)),
			{ id = 588, achID = 8364, difficulty = DIFFICULTY_SCENARIO_HEROIC },	--	Battle on the High Seas
			{ id = 624, achID = 8318, difficulty = DIFFICULTY_SCENARIO_HEROIC },	--	Dark Heart of Pandaria
			{ id = 625, achID = 8327, difficulty = DIFFICULTY_SCENARIO_HEROIC },	--	The Secrets of Ragefire
			{ id = 637, achID = 8312, difficulty = DIFFICULTY_SCENARIO_HEROIC },	--	Blood in the Snow
			{ id = 639, achID = 8310, difficulty = DIFFICULTY_SCENARIO_HEROIC },	--	A Brewing Storm
			-- { id = 645, achID =  },	--	Greenstone Village
			{ id = 648, achID = 8311, difficulty = DIFFICULTY_SCENARIO_HEROIC },	--	Crypt of Forgotten Kings
			-- { id = 652, achID =  },	--	Battle on the High Seas
			-- { id = 749, achID =  },	--	Noodle Time
		},
        -- Flex raids removed
		{	-- [4] 10 player raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_10P)),
			{ id = 531, achID = 6844, difficulty = DIFFICULTY_RAID_10P, difficulty2 = DIFFICULTY_RAID_10PH },	--	Mogu'shan Vaults
			{ id = 533, achID = 6845, difficulty = DIFFICULTY_RAID_10P, difficulty2 = DIFFICULTY_RAID_10PH },	--	Heart of Fear
			{ id = 535, achID = 6689, bosses = 4, difficulty = DIFFICULTY_RAID_10P, difficulty2 = DIFFICULTY_RAID_10PH },	--	Terrace of Endless Spring
			{ id = 633, achID = 8072, difficulty = DIFFICULTY_RAID_10P, difficulty2 = DIFFICULTY_RAID_10PH },	--	Throne of Thunder
		},
		{	-- [5] 25 player raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_25P)),
			{ id = 532, achID = 6844, difficulty = DIFFICULTY_RAID_25P, difficulty2 = DIFFICULTY_RAID_25PH },	--	Mogu'shan Vaults
			{ id = 534, achID = 6845, difficulty = DIFFICULTY_RAID_25P, difficulty2 = DIFFICULTY_RAID_25PH },	--	Heart of Fear
			{ id = 536, achID = 6689, difficulty = DIFFICULTY_RAID_25P, difficulty2 = DIFFICULTY_RAID_25PH },	--	Terrace of Endless Spring
			{ id = 634, achID = 8072, difficulty = DIFFICULTY_RAID_25P, difficulty2 = DIFFICULTY_RAID_25PH },	--	Throne of Thunder
			{ id = 767, achID = 8533, difficulty = DIFFICULTY_RAID_25P },	--	Ordos
			{ id = 768, achID = 8535, difficulty = DIFFICULTY_RAID_25P },	--	Celestials
		},
        {   -- [6] Normal Siege of Orgrimmar
            name = format("%s - %s", RAIDS, "Siege of Orgrimmar Normal"),
            { id = 714, achID = 8462, difficulty = DIFFICULTY_RAID_FLEX },	--	Siege of Orgrimmar Normal
        },
        {   -- [7] Heroic Siege of Orgrimmar
            name = format("%s - %s", RAIDS, "Siege of Orgrimmar Heroic"),
            { id = 714, achID = 8462, difficulty = DIFFICULTY_RAID_HEROIC },	--	Siege of Orgrimmar Heroic
        },
        {   -- [8] Mythic Siege of Orgrimmar
            name = format("%s - %s", RAIDS, "Siege of Orgrimmar Mythic"),
            { id = 766, achID = 8462, difficulty = DIFFICULTY_RAID_MYTHIC },	--	Siege of Orgrimmar Mythic
        },
	},
	{	-- [6]
		name = EXPANSION_NAME5,	-- "Warlords of Draenor"
		{	-- [1] LFR Raids
			name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_LFR)),
			{ id = 849, achID = 8986, bosses = 3, difficulty = DIFFICULTY_RAID_LFR },	--	Walled City
			{ id = 850, achID = 8987, bosses = 3, difficulty = DIFFICULTY_RAID_LFR },	--	Arcane Sanctum
			{ id = 851, achID = 8988, bosses = 1, difficulty = DIFFICULTY_RAID_LFR },	--	Imperator's Rise
			{ id = 847, achID = 8989, bosses = 3, difficulty = DIFFICULTY_RAID_LFR },	--	Slagworks
			{ id = 846, achID = 8990, bosses = 3, difficulty = DIFFICULTY_RAID_LFR },	--	The Black Forge
			{ id = 848, achID = 8991, bosses = 3, difficulty = DIFFICULTY_RAID_LFR },	--	Iron Assembly
			{ id = 823, achID = 8992, bosses = 1, difficulty = DIFFICULTY_RAID_LFR },	--	Blackhand's Crucible
			{ id = 982, achID = 10023, bosses = 3, difficulty = DIFFICULTY_RAID_LFR }, --  Hellbreach
			{ id = 983, achID = 10024, bosses = 3, difficulty = DIFFICULTY_RAID_LFR }, --  Halls of Blood
			{ id = 984, achID = 10025, bosses = 3, difficulty = DIFFICULTY_RAID_LFR }, --  Bastion of Shadows
			{ id = 985, achID = 10026, bosses = 3, difficulty = DIFFICULTY_RAID_LFR }, --  Destructor's Rise
			{ id = 986, achID = 10027, bosses = 1, difficulty = DIFFICULTY_RAID_LFR }, --  The Black Gate
		}, -- Datamined from: https://wow.gamepedia.com/LfgDungeonID
        {   -- [2] Normal Raids
            name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_FLEX)),
            { id = 895, achID = 8988, difficulty = DIFFICULTY_RAID_FLEX },	--	Highmaul
            { id = 898, achID = 8992, difficulty = DIFFICULTY_RAID_FLEX },	-- BRF
            { id = 987, achID = 10027, difficulty = DIFFICULTY_RAID_FLEX },	-- HFC
            
        },
        {   -- [3] Heroic Raids
            name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_HEROIC)),
            { id = 896, achID = 8988, difficulty = DIFFICULTY_RAID_HEROIC },	--	Highmaul
            { id = 899, achID = 8992, difficulty = DIFFICULTY_RAID_HEROIC },	-- BRF
            { id = 988, achID = 10027, difficulty = DIFFICULTY_RAID_FLEX },	-- HFC
        },
        {   -- [4] Mythic Raids
            name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_MYTHIC)),
            { id = 897, achID = 8965, difficulty = DIFFICULTY_RAID_MYTHIC },	--	Highmaul
            { id = 900, achID = 8992, difficulty = DIFFICULTY_RAID_MYTHIC },	-- BRF
            { id = 989, achID = 10027, difficulty = DIFFICULTY_RAID_FLEX },	-- HFC
        },
	},
    { -- [7]
        name = EXPANSION_NAME6, -- "Legion"
        { -- [1] LFR
             name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_LFR)),
			{ id = 1287, achID = 10818, bosses = 3, difficulty = DIFFICULTY_RAID_LFR },	--	Darkbough
			{ id = 1288, achID = 10819, bosses = 3, difficulty = DIFFICULTY_RAID_LFR },	--	Tormented Guardians
			{ id = 1289, achID = 10820, bosses = 1, difficulty = DIFFICULTY_RAID_LFR },	--	Rift of Aln
			{ id = 1290, achID = 10829, bosses = 3, difficulty = DIFFICULTY_RAID_LFR },	--	Arcing Aqueducts
			{ id = 1291, achID = 10837, bosses = 3, difficulty = DIFFICULTY_RAID_LFR },	--	Royal Athenaeum
			{ id = 1292, achID = 10838, bosses = 3, difficulty = DIFFICULTY_RAID_LFR },	--	Nightspire
			{ id = 1293, achID = 10839, bosses = 1, difficulty = DIFFICULTY_RAID_LFR },	--	Betrayer's Rise
			{ id = 1411, achID = 11394, bosses = 3, difficulty = DIFFICULTY_RAID_LFR }, -- Trial of Valor 
			{ id = 1494, achID = 11787, bosses = 3, difficulty = DIFFICULTY_RAID_LFR }, -- The Gates of Hell
			{ id = 1495, achID = 11788, bosses = 3, difficulty = DIFFICULTY_RAID_LFR }, -- Wailing Halls
			{ id = 1496, achID = 11789, bosses = 2, difficulty = DIFFICULTY_RAID_LFR }, -- Chamber of the Avatar
			{ id = 1497, achID = 11790, bosses = 1, difficulty = DIFFICULTY_RAID_LFR }, -- Deceiver's Fall
            { id = 1610, achID = 11988, bosses = 3, difficulty = DIFFICULTY_RAID_LFR }, -- Light's Breach
			{ id = 1611, achID = 11989, bosses = 3, difficulty = DIFFICULTY_RAID_LFR }, -- Forbidden Descent
			{ id = 1612, achID = 11990, bosses = 3, difficulty = DIFFICULTY_RAID_LFR }, -- Hope's End
			{ id = 1613, achID = 11991, bosses = 2, difficulty = DIFFICULTY_RAID_LFR }, -- Seat of the Pantheon
        },
        {   -- [2] Normal Raids
            name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_FLEX)),
            { id = 1348, achID = 10820, difficulty = DIFFICULTY_RAID_FLEX },	-- TEN
            { id = 1351, achID = 10839, difficulty = DIFFICULTY_RAID_FLEX },	-- Nighthold
            { id = 1437, achID = 11394, difficulty = DIFFICULTY_RAID_FLEX },	-- Trial of Valor
            { id = 1525, achID = 11790, difficulty = DIFFICULTY_RAID_FLEX },	-- Tomb of Sargeras
            { id = 1640, achID = 11991, difficulty = DIFFICULTY_RAID_FLEX },	-- Antorus, the Burning Throne
        },
        {   -- [3] Heroic Raids
            name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_HEROIC)),
            { id = 1349, achID = 10820, difficulty = DIFFICULTY_RAID_HEROIC },	-- TEN
            { id = 1352, achID = 10839, difficulty = DIFFICULTY_RAID_HEROIC },	-- Nighthold
            { id = 1438, achID = 11394, difficulty = DIFFICULTY_RAID_HEROIC },	-- Trial of Valor
            { id = 1526, achID = 11790, difficulty = DIFFICULTY_RAID_HEROIC },	-- Tomb of Sargeras
            { id = 1641, achID = 11991, difficulty = DIFFICULTY_RAID_HEROIC },	-- Antorus, the Burning Throne
        },
        {   -- [4] Mythic Raids
            name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_MYTHIC)),
            { id = 1350, achID = 10827, difficulty = DIFFICULTY_RAID_MYTHIC },	-- TEN
            { id = 1353, achID = 10850, difficulty = DIFFICULTY_RAID_MYTHIC },	-- Nighthold
            { id = 1439, achID = 11398, difficulty = DIFFICULTY_RAID_MYTHIC },	-- Trial of Valor
            { id = 1527, achID = 11781, difficulty = DIFFICULTY_RAID_MYTHIC },	-- Tomb of Sargeras
            { id = 1642, achID = 12002, difficulty = DIFFICULTY_RAID_MYTHIC },	-- Antorus, the Burning Throne
        },
    },
    { -- [8]
        name = EXPANSION_NAME7, -- "Badtle for Azeroth"
        { -- [1] LFR
             name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_LFR)),
			{ id = 1731, achID = 12521, bosses = 3, difficulty = DIFFICULTY_RAID_LFR },	-- Halls of Containment
			{ id = 1732, achID = 12522, bosses = 3, difficulty = DIFFICULTY_RAID_LFR },	-- Crimson Descent
			{ id = 1733, achID = 12523, bosses = 2, difficulty = DIFFICULTY_RAID_LFR },	-- Heart of Corruption
			{ id = 1945, achID = 13286, bosses = 3, difficulty = DIFFICULTY_RAID_LFR },	-- Siege of Dazar'alor
			{ id = 1946, achID = 13287, bosses = 3, difficulty = DIFFICULTY_RAID_LFR },	-- Empire's Fall
			{ id = 1947, achID = 13288, bosses = 3, difficulty = DIFFICULTY_RAID_LFR },	-- Might of the Alliance
			{ id = 1948, achID = 13289, bosses = 3, difficulty = DIFFICULTY_RAID_LFR },	-- Defense of Dazar'alor
			{ id = 1949, achID = 13290, bosses = 3, difficulty = DIFFICULTY_RAID_LFR }, -- Death's Bargain  
			{ id = 1950, achID = 13291, bosses = 1, difficulty = DIFFICULTY_RAID_LFR }, -- Victory or Death 
			{ id = 1951, achID = 13414, bosses = 2, difficulty = DIFFICULTY_RAID_LFR }, -- Crucible of Storms 
			{ id = 2009, achID = 13718, bosses = 3, difficulty = DIFFICULTY_RAID_LFR }, -- The Grand Reception
			{ id = 2010, achID = 13719, bosses = 3, difficulty = DIFFICULTY_RAID_LFR }, -- Depths of the Devoted
            { id = 2011, achID = 13725, bosses = 2, difficulty = DIFFICULTY_RAID_LFR }, -- The Circle of Stars
			{ id = 2036, achID = 14193, bosses = 3, difficulty = DIFFICULTY_RAID_LFR }, -- Vision of Destiny
			{ id = 2037, achID = 14194, bosses = 4, difficulty = DIFFICULTY_RAID_LFR }, -- Halls of Devotion
			{ id = 2038, achID = 14195, bosses = 3, difficulty = DIFFICULTY_RAID_LFR }, -- Gift of Flesh
            { id = 2039, achID = 14196, bosses = 2, difficulty = DIFFICULTY_RAID_LFR }, -- The Waking Dream
        },
        {   -- [2] Normal Raids
            name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_FLEX)),
            { id = 1889, achID = 12523, difficulty = DIFFICULTY_RAID_FLEX },	-- Uldir
            { id = 1942, achID = 10839, difficulty = DIFFICULTY_RAID_FLEX },	-- Battle of Dazar'alor
            { id = 1952, achID = 13414, difficulty = DIFFICULTY_RAID_FLEX },	-- Crucible of Storms
            { id = 2014, achID = 13725, difficulty = DIFFICULTY_RAID_FLEX },	-- The Eternal Palace
            { id = 2033, achID = 14196, difficulty = DIFFICULTY_RAID_FLEX },	-- Ny'alotha, the Waking City
        },
        {   -- [3] Heroic Raids
            name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_HEROIC)),
            { id = 1888, achID = 12523, difficulty = DIFFICULTY_RAID_HEROIC },	-- Uldir 
            { id = 1943, achID = 10839, difficulty = DIFFICULTY_RAID_HEROIC },	-- Battle of Dazar'alor
            { id = 1953, achID = 13414, difficulty = DIFFICULTY_RAID_HEROIC },	-- Crucible of Storms 
            { id = 2015, achID = 13725, difficulty = DIFFICULTY_RAID_HEROIC },	-- The Eternal Palace
            { id = 2034, achID = 14196, difficulty = DIFFICULTY_RAID_HEROIC },	-- Ny'alotha, the Waking City
        },
        {   -- [4] Mythic Raids
            name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_MYTHIC)),
            { id = 1887, achID = 12533, difficulty = DIFFICULTY_RAID_MYTHIC },	-- Uldir
            { id = 1944, achID = 10850, difficulty = DIFFICULTY_RAID_MYTHIC },	-- Battle of Dazar'alor
            { id = 1954, achID = 13417, difficulty = DIFFICULTY_RAID_MYTHIC },	-- Crucible of Storms  
            { id = 2016, achID = 13733, difficulty = DIFFICULTY_RAID_MYTHIC },	-- The Eternal Palace   
            { id = 2035, achID = 14055, difficulty = DIFFICULTY_RAID_MYTHIC },	-- Ny'alotha, the Waking City   
        },
    },
    { -- [9]
        name = EXPANSION_NAME8, -- "Shadowlands"
        { -- [1] LFR
             name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_LFR)),
			{ id = 2090, achID = 14365, bosses = 3, difficulty = DIFFICULTY_RAID_LFR },	-- The Leeching Vaults
			{ id = 2091, achID = 14365, bosses = 3, difficulty = DIFFICULTY_RAID_LFR },	-- Revendreth's Last Dance
			{ id = 2092, achID = 14365, bosses = 2, difficulty = DIFFICULTY_RAID_LFR },	-- Blood from Stone
			{ id = 2096, achID = 14365, bosses = 3, difficulty = DIFFICULTY_RAID_LFR },	-- An Audience with Arrogance
        },
        {   -- [2] Normal Raids
            name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_FLEX)),
            { id = 2095, achID = 14365, difficulty = DIFFICULTY_RAID_FLEX },	-- Castle Nathria - TODO: achievement for beating the raid on normal doesn't appear to be on the PTR yet. Check for one later.
        },
        {   -- [3] Heroic Raids
            name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_HEROIC)),
            { id = 2094, achID = 14365, difficulty = DIFFICULTY_RAID_HEROIC },	-- Castle Nathria 
        },
        {   -- [4] Mythic Raids
            name = format("%s - %s", RAIDS, GetDifficultyInfo(DIFFICULTY_RAID_MYTHIC)),
            { id = 2093, achID = 14365, difficulty = DIFFICULTY_RAID_MYTHIC },	-- Castle Nathria   
        },
    },
}

local view
local isViewValid

local OPTION_XPACK = "UI.Tabs.Grids.Dungeons.CurrentXPack"
local OPTION_RAIDS = "UI.Tabs.Grids.Dungeons.CurrentRaids"

local currentDDMText
local currentTexture
local dropDownFrame

local function BuildView()
	view = view or {}
	wipe(view)
	
	local currentXPack = addon:GetOption(OPTION_XPACK)
	local currentRaids = addon:GetOption(OPTION_RAIDS)

	for index, raidList in ipairs(Dungeons[currentXPack][currentRaids]) do
		table.insert(view, raidList)	-- insert the table pointer
	end
	
	isViewValid = true
end

local function OnRaidListChange(self, xpackIndex, raidListIndex)
	dropDownFrame:Close()

	addon:SetOption(OPTION_XPACK, xpackIndex)
	addon:SetOption(OPTION_RAIDS, raidListIndex)
		
	local raidList = Dungeons[xpackIndex][raidListIndex]
	currentDDMText = raidList.name
	AltoholicTabGrids:SetViewDDMText(currentDDMText)
	
	isViewValid = nil
	AltoholicTabGrids:Update()
end

local function DropDown_Initialize(frame, level)
	if not level then return end

	local info = frame:CreateInfo()
	
	local currentXPack = addon:GetOption(OPTION_XPACK)
	local currentRaids = addon:GetOption(OPTION_RAIDS)
	
	if level == 1 then
		for xpackIndex = 1, #Dungeons do
			info.text = Dungeons[xpackIndex].name
			info.hasArrow = 1
			info.checked = (currentXPack == xpackIndex)
			info.value = xpackIndex
			frame:AddButtonInfo(info, level)
		end
		frame:AddCloseMenu()
	
	elseif level == 2 then
		local menuValue = frame:GetCurrentOpenMenuValue()
		
		for raidListIndex, raidList in ipairs(Dungeons[menuValue]) do
			info.text = raidList.name
			info.func = OnRaidListChange
			info.checked = ((currentXPack == menuValue) and (currentRaids == raidListIndex))
			info.arg1 = menuValue
			info.arg2 = raidListIndex
			frame:AddButtonInfo(info, level)
		end
	end
end

local callbacks = {
	OnUpdate = function() 
			if not isViewValid then
				BuildView()
			end

			local currentXPack = addon:GetOption(OPTION_XPACK)
			local currentRaids = addon:GetOption(OPTION_RAIDS)
			
			AltoholicTabGrids:SetStatus(format("%s / %s", Dungeons[currentXPack].name, Dungeons[currentXPack][currentRaids].name))
		end,
	GetSize = function() return #view end,
	RowSetup = function(self, rowFrame, dataRowID)
			local dungeonID = view[dataRowID].id

			rowFrame.Name.Text:SetText(colors.white .. GetLFGDungeonInfo(dungeonID))
			rowFrame.Name.Text:SetJustifyH("LEFT")
		end,
	RowOnEnter = function()	end,
	RowOnLeave = function() end,
	ColumnSetup = function(self, button, dataRowID, character)
			local _, _, _, _, _, _, _, _, _, achImage = GetAchievementInfo(view[dataRowID].achID)
			button.Background:SetTexture(achImage)
			button.Background:SetTexCoord(0, 1, 0, 1)
			button.Background:SetDesaturated(false)
			
			local dungeonID = view[dataRowID].id
			local count = DataStore:GetLFGDungeonKillCount(character, dungeonID)
            if (not count) or (count == 0) then
                for dungeonKey, _ in pairs(DataStore:GetSavedInstances(character)) do
                    local savedDungeonName, savedDungeonID = strsplit("|", dungeonKey)
                    local name, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, name2, _ = GetLFGDungeonInfo(dungeonID)
                    local name3, name4 = "", ""
                    if view[dataRowID].difficulty2 then
                        name3 = name.." "..GetDifficultyInfo(view[dataRowID].difficulty2)
                        name4 = name2.." "..GetDifficultyInfo(view[dataRowID].difficulty2)
                    end
                    name = name.." "..GetDifficultyInfo(view[dataRowID].difficulty)
                    name2 = name2.." "..GetDifficultyInfo(view[dataRowID].difficulty)
                    if (savedDungeonName == name) or (savedDungeonName == name2) or (savedDungeonName == name3) or (savedDungeonName == name4) then
                        _, _, _, _, _, count = DataStore:GetSavedInstanceInfo(character, dungeonKey) 
                    end
                end
            end

			if tonumber(count) > 0 then 
				button.Background:SetVertexColor(1.0, 1.0, 1.0)
				button.key = character
				button:SetID(dungeonID)

				button.Name:SetJustifyH("CENTER")
				button.Name:SetPoint("BOTTOMRIGHT", 3, 2)
				button.Name:SetFontObject("NumberFontNormalSmall")

				if view[dataRowID].bosses then
					button.Name:SetText(colors.green..format("%s/%s", count, view[dataRowID].bosses))
				else
					button.Name:SetText(colors.green..format("%s/%s", count, GetLFGDungeonNumEncounters(view[dataRowID].id)))
				end
				
				-- button.Name:SetText(colors.green..count)
			else
				button.Background:SetVertexColor(0.3, 0.3, 0.3)		-- greyed out
				button.Name:SetJustifyH("CENTER")
				button.Name:SetPoint("BOTTOMRIGHT", 5, 0)
				button.Name:SetFontObject("GameFontNormalSmall")
				button.Name:SetText(icons.notReady)
				button:SetID(0)
				button.key = nil
			end
		end,
		
	OnEnter = function(frame) 
			local character = frame.key
			if not character then return end

			local dungeonID = frame:GetID()
			local dungeonName, _, _, _, _, _, _, _, _, _, _, difficulty = GetLFGDungeonInfo(dungeonID)
			
			AltoTooltip:SetOwner(frame, "ANCHOR_LEFT")
			AltoTooltip:ClearLines()
			AltoTooltip:AddLine(DataStore:GetColoredCharacterName(character),1,1,1)
			AltoTooltip:AddLine(dungeonName,1,1,1)
			AltoTooltip:AddLine(GetDifficultyInfo(difficulty),1,1,1)
			
			AltoTooltip:AddLine(" ",1,1,1)
			
			local color
			for i = 1, GetLFGDungeonNumEncounters(dungeonID) do
				local bossName = GetLFGDungeonEncounterInfo(dungeonID, i)
				
				-- current display is confusing, only show the "already looted" for the time being, skip the others until a better solution is possible
				if DataStore:IsBossAlreadyLooted(character, dungeonID, bossName) then
					AltoTooltip:AddDoubleLine(bossName, colors.red..ERR_LOOT_GONE)
				-- else
					-- AltoTooltip:AddDoubleLine(bossName, colors.green..BOSS_ALIVE)
				end
			end
			
			AltoTooltip:Show()
			
		end,
	OnClick = nil,
	OnLeave = function(self)
			AltoTooltip:Hide() 
		end,
	InitViewDDM = function(frame, title) 
			dropDownFrame = frame
			frame:Show()
			title:Show()

			local currentXPack = addon:GetOption(OPTION_XPACK)
			local currentRaids = addon:GetOption(OPTION_RAIDS)
			
			currentDDMText = Dungeons[currentXPack][currentRaids].name
			
			frame:SetMenuWidth(100) 
			frame:SetButtonWidth(20)
			frame:SetText(currentDDMText)
			frame:Initialize(DropDown_Initialize, "MENU_NO_BORDERS")
		end,
}

AltoholicTabGrids:RegisterGrid(6, callbacks)
