local CATEGORIES = {
    { name = "The War Within",         items = { 248012 } },  -- Dornic Fir Lumber
    { name = "Dragonflight",           items = { 251773 } },  -- Dragonpine Lumber
    { name = "Shadowlands",            items = { 251772 } },  -- Arden Lumber
    { name = "Battle for Azeroth",     items = { 251768 } },  -- Darkpine Lumber
    { name = "Legion",                 items = { 251767 } },  -- Fel-touched Lumber
    { name = "Warlords of Draenor",    items = { 251766 } },  -- Shadowmoon Lumber
    { name = "Mists of Pandaria",      items = { 251763 } },  -- Bamboo Lumber
    { name = "Cataclysm",              items = { 251764 } },  -- Ashwood Lumber
    { name = "Wrath of the Lich King", items = { 251762 } },  -- Coldwind Lumber
    { name = "The Burning Crusade",    items = { 242691 } },  -- Olemba Lumber
    { name = "Classic",                items = { 245586 } },  -- Ironwood Lumber
    { name = "Midnight",               items = { 256963, 235401 } },  -- Thalassian Lumber
}
-- Per-tab item definitions

local LUMBER_ITEMS = {}
for i, cat in ipairs(CATEGORIES) do
    LUMBER_ITEMS[i] = cat.items
end

local LumberItemSet = {}
for _, items in ipairs(LUMBER_ITEMS) do
    if items then
        for _, itemID in ipairs(items) do
            LumberItemSet[itemID] = true
        end
    end
end


-- Herbs per expansion
local HERB_ITEMS = {
    [1] = { -- The War Within
        210808, -- Arathor's Spear
        210805, -- Blessing Blossom
        210799, -- Luredrop
        210796, -- Mycobloom
        210802, -- Orbinid
    },
    [2] = { -- Dragonflight
        191468, -- Bubble Poppy
        191462, -- Hochenblume
        191464, -- Saxifrage
        191470, -- Writhebark
    },
    [3] = { -- Shadowlands
        169701, -- Death Blossom
        168589, -- Marrowroot
        171315, -- Nightshade
        168586, -- Rising Glory
        170554, -- Vigil's Torch
        168583, -- Widowbloom
    },
    [4] = { -- Battle for Azeroth
        152510, -- Anchor Weed
        152507, -- Akunda's Bite
        152505, -- Riverbud
        152511, -- Sea Stalk
        152509, -- Siren's Pollen
        152506, -- Star Moss
        152508, -- Winter's Kiss
    },
    [5] = { -- Legion
        124101, -- Aethril
        151565, -- Astral Glory
        124102, -- Dreamleaf
        124106, -- Felwort
        124104, -- Fjarnskaggl
        124103, -- Foxflower
        124105, -- Starlight Rose
    },
    [6] = { -- Warlords of Draenor
        109125, -- Fireweed
        109124, -- Frostweed
        109126, -- Gorgrond Flytrap
        109128, -- Nagrand Arrowbloom
        109127, -- Starflower
        109129, -- Talador Orchid
    },
    [7] = { -- Mists of Pandaria
        79011, -- Fool's Cap
        72238, -- Golden Lotus
        72234, -- Green Tea Leaf
        72237, -- Rain Poppy
        72235, -- Silkweed
        79010, -- Snow Lily
    },
    [8] = { -- Cataclysm
        52985, -- Azshara's Veil
        52983, -- Cinderbloom
        52986, -- Heartblossom
        52984, -- Stormvine
        52987, -- Twilight Jasmine
        52988, -- Whiptail
    },
    [9] = { -- Wrath of the Lich King
        36903, -- Adder's Tongue
        39970, -- Fire Leaf
        36908, -- Frost Lotus
        36901, -- Goldclover
        36906, -- Icethorn
        36905, -- Lichbloom
        36907, -- Talandra's Rose
        36904, -- Tiger Lily
    },
    [10] = { -- The Burning Crusade
        22790, -- Ancient Lichen
        22786, -- Dreaming Glory
        22785, -- Felweed
        22794, -- Fel Lotus
        22791, -- Netherbloom
        22792, -- Nightmare Vine
        22793, -- Mana Thistle
        22787, -- Ragveil
        22789, -- Terocone
    },
    [11] = { -- Classic
        13468, -- Black Lotus
        2450,  -- Briarthorn
        13463, -- Dreamfoil
        2449,  -- Earthroot
        3818,  -- Fadeleaf
        4625,  -- Firebloom
        13464, -- Golden Sansam
        2046,  -- Goldthorn
        3369,  -- Grave Moss
        3358,  -- Khadgar's Whisker
        3356,  -- Kingsblood
        3357,  -- Liferoot
        785,   -- Mageroyal
        13465, -- Mountain Silversage
        2447,  -- Peacebloom
        13466, -- Plaguebloom
        8831,  -- Purple Lotus
        765,   -- Silverleaf
        3820,  -- Stranglekelp
        8838,  -- Sungrass
        2452,  -- Swiftthistle
        3355,  -- Wild Steelbloom
    },
     [12] = { -- Midnight
         236776, -- Argentleaf
         236774, -- Azeroot
         236778, -- Mana Lily
         236780, -- Nocturnal Lotus
         236771, -- Sanguithorn
         236761, -- Tranquility Bloom
     },
}

-- Ores and Leather

local ITEM_VARIANTS = {
    -- The War Within herbs (all qualities merged to a single display row)
    [210808] = {210808, 210809, 210810}, -- Arathor's Spear (Q1-Q3)
    [210805] = {210805, 210806, 210807}, -- Blessing Blossom (Q1-Q3)
    [210799] = {210799, 210800, 210801}, -- Luredrop (Q1-Q3)
    [210796] = {210796, 210797, 210798}, -- Mycobloom (Q1-Q3)
    [210802] = {210802, 210803, 210804}, -- Orbinid (Q1-Q3),

    -- Dragonflight herbs (all qualities merged to a single display row)
    [191468] = {191467, 191468, 191469}, -- Bubble Poppy (Q1-Q3)
    [191462] = {191460, 191461, 191462}, -- Hochenblume (Q1-Q3)
    [191464] = {191464, 191465, 191466}, -- Saxifrage (Q1-Q3)
    [191470] = {191470, 191471, 191472}, -- Writhebark (Q1-Q3),

    -- The War Within ores (all qualities merged to a single display row)
    [210933] = {210933, 210934, 210935}, -- Aqirite (Q1-Q3)
    [210930] = {210930, 210931, 210932}, -- Bismuth (Q1-Q3)
    [210936] = {210936, 210937, 210938}, -- Ironclaw (Q1-Q3)

    -- Dragonflight ores (all qualities merged to a single display row)
    [188658] = {188658, 189143, 190311}, -- Draconium (Q1-Q3)
    [190396] = {190395, 190396, 190394}, -- Serevite (Q1-Q3)
    [190312] = {190312, 190313, 190314}, -- Khaz'gorite (Q1-Q3)

    -- The War Within leather (all qualities merged to a single display row)
    [212667] = {212667, 212668, 212669}, -- Gloom Chitin (Q1-Q3)
    [212664] = {212664, 212665, 212666}, -- Stormcharged Leather (Q1-Q3)
    [212674] = {212674, 212675, 212676}, -- Sunless Carapace (Q1-Q3)
    [212670] = {212670, 212672, 212673}, -- Thunderous Hide (Q1-Q3)

    -- Dragonflight leather (all qualities merged to a single display row)
    [193213] = {193213, 193214, 193215}, -- Adamant Scales (Q1-Q3)
    [193208] = {193208, 193210, 193211}, -- Resilient Leather (Q1-Q3)
    [193222] = {193222, 193223, 193224}, -- Lustrous Scaled Hide (Q1-Q3)

    -- Legion fish (merged variants)
    [139669] = {139669, 133742}, -- Ancient Black Barracuda
    [139660] = {139660, 133733}, -- Ancient Highmountain Salmon
    [139657] = {139657, 133730}, -- Ancient Mossgill
    [139667] = {139667, 133740}, -- Axefish
    [139659] = {139659, 133732}, -- Coldriver Carp
    [139654] = {139654, 133727}, -- Ghostly Queenfish
    [133735] = {133735, 139662}, -- Graybelly Lobster
    [133725] = {133725, 139652}, -- Leyshimmer Blenny
    [139664] = {139664, 133737}, -- Magic-Eater Frog
    [133731] = {133731, 139658}, -- Mountain Puffer
    [133726] = {133726, 139653}, -- Nar'thalas Hermit
    [133734] = {133734, 139661}, -- Oodelfjisk
    [133741] = {133741, 139668}, -- Seabottom Squid
    [139665] = {139665, 133738}, -- Seerspine Puffer
    [139666] = {139666, 133739}, -- Tainted Runescale Koi
    [139655] = {139655, 133728}, -- Terrorfin
    [133729] = {133729, 139656}, -- Thorned Flounder
    [139663] = {139663, 133736}, -- Thundering Stormray
}

local ORE_ITEMS = {
    [1] = { -- The War Within
        210933, -- Aqirite
        210930, -- Bismuth
        210936, -- Ironclaw
    },
    [2] = { -- Dragonflight
        188658, -- Draconium
        190312, -- Khaz'gorite
        190396, -- Serevite
    },
    [3] = { -- Shadowlands
        171833, -- Elethium
        171828, -- Laestrite
        171830, -- Oxxein
        171831, -- Phaedrum
        171832, -- Sinvyr
        171829, -- Solenium
    },
    [4] = { -- Battle for Azeroth
        152512, -- Monelite
        152513, -- Platinum
        152579, -- Storm Silver
    },
    [5] = { -- Legion
        151564, -- Empyrium
        123919, -- Felslate
        123918, -- Leystone
    },
    [6] = { -- Warlords of Draenor
        109118, -- Blackrock
        109119, -- True Iron
    },
    [7] = { -- Mists of Pandaria
        72094, -- Black Trillium
        72092, -- Ghost Iron
        72093, -- Kyparite
        72103, -- White Trillium
    },
    [8] = { -- Cataclysm
        52185, -- Elementium
        53038, -- Obsidium
        52183, -- Pyrite
    },
    [9] = { -- Wrath of the Lich King
        36909, -- Cobalt
        36912, -- Saronite
        36910, -- Titanium
    },
    [10] = { -- The Burning Crusade
        23425, -- Adamantite
        23427, -- Eternium
        23424, -- Fel Iron
        23426, -- Khorium
    },
    [11] = { -- Classic
        2770,  -- Copper
        11370, -- Dark Iron
        2776,  -- Gold
        2772,  -- Iron
        3858,  -- Mithril
        2775,  -- Silver
        10620, -- Thorium
        2771,  -- Tin
        7911,  -- Truesilver
    },
     [12] = { -- Midnight
         237364, -- Brilliant Silver
         237359, -- Refulgent Copper
         237362, -- Umbral Tin
     },
}

local LEATHER_ITEMS = {
    [1] = { -- The War Within
        212667, -- Gloom Chitin
        212664, -- Stormcharged Leather
        212674, -- Sunless Carapace
        212670, -- Thunderous Hide
    },
    [2] = { -- Dragonflight
        193213, -- Adamant Scales
        193208, -- Resilient Leather
        193222, -- Lustrous Scaled Hide
    },
    [3] = { -- Shadowlands
        172094, -- Callous Hide
        172089, -- Desolate Leather
        172093, -- Desolate Leather Scraps
        172097, -- Heavy Callous Hide
        172096, -- Heavy Desolate Leather
        172092, -- Pallid Bone
    },
    [4] = { -- Battle for Azeroth
        154164, -- Blood-Stained Bone
        152541, -- Coarse Leather
        152542, -- Hardened Tempest Hide
        154722, -- Tempest Hide
    },
    [5] = { -- Legion
        151566, -- Fiendish Leather
        124113, -- Stonehide Leather
        124115, -- Stormscale
    },
    [6] = { -- Warlords of Draenor
        110611, -- Burnished Leather
        25708,  -- Thick Clefthoof Leather
        110609, -- Raw Beast Hide
        110610, -- Raw Beast Hide Scraps
    },
    [7] = { -- Mists of Pandaria
        72163, -- Magnificent Hide
        72120, -- Mist-Touched Leather
        79101, -- Prismatic Scale
        72162, -- Sha-Touched Leather
    },
    [8] = { -- Cataclysm
        56516, -- Heavy Savage Leather
        52976, -- Savage Leather
        52977, -- Savage Leather Scraps
    },
    [9] = { -- Wrath of the Lich King
        44128, -- Arctic Fur
        33568, -- Borean Leather
        33567, -- Borean Leather Scraps
        38425, -- Heavy Borean Leather
    },
    [10] = { -- The Burning Crusade
        25707, -- Fel Hide
        25700, -- Fel Scales
        25708, -- Thick Clefthoof Leather
        29547, -- Wind Scales
    },
    [11] = { -- Classic
        4231,  -- Cured Light Hide
        4232,  -- Cured Medium Hide
        4233,  -- Cured Heavy Hide
        8172,  -- Cured Thick Hide
        15417, -- Devilsaur Leather
        4235,  -- Heavy Hide
        4234,  -- Heavy Leather
        2318,  -- Light Leather
        2319,  -- Medium Leather
        4461,  -- Raptor Hide
        8171,  -- Rugged Hide
        8170,  -- Rugged Leather
        8169,  -- Thick Hide
        4304,  -- Thick Leather
        15419, -- Warbear Leather
    },
     [12] = { -- Midnight
        238625, -- Fine Void-Tempered Hide
        238628, -- Lightbloom Afflicted Hide
        238630, -- Primal Hide
        238631, -- Voidstorm Leather Sample
     },
}


local FISH_ITEMS = {
    [1] = { -- The War Within
        220145, -- Arathor Hammerfish
        220153, -- Awoken Coelacanth
        220137, -- Bismuth Bitterling
        220135, -- Bloody Perch
        220136, -- Crystalline Sturgeon
        220152, -- Cursed Ghoulfish
        220134, -- Dilly-Dally Dace
        220143, -- Dornish Pike
        227673, -- "Gold" Fish
        222533, -- Goldengill Trout
        220147, -- Kaheti Slum Shark
        220138, -- Nibbling Minnow
        220148, -- Pale Huskfish
        220151, -- Queen's Lurefish
        220142, -- Quiet River Bass
        220146, -- Regal Dottyback
        220144, -- Roaring Anglerseeker
        220149, -- Sanguine Dogfish
        220141, -- Specular Rainbowfish
        220150, -- Spiked Sea Raven
        220139, -- Whispering Stargazer
    },
    [2] = { -- Dragonflight
        194967, -- Aileron Seamoth
        202073, -- Calamitous Carp
        194968, -- Cerulean Spinefish
        198395, -- Dull Spined Clams
        202072, -- Frigid Floe Fish
        200074, -- Frosted Rimefin Tuna
        194970, -- Islefin Dorado
        202074, -- Kingfin
        199344, -- Magma Thresher
        200061, -- Prismatic Leaper
        194730, -- Scalebelly Mackerel
        194969, -- Temporal Dragonhead
        194966, -- Thousandbite Piranha
    },
    [3] = { -- Shadowlands
        173037, -- Elysian Thade
        173033, -- Iridescent Amberjack
        173032, -- Lost Sole
        173035, -- Pocked Bonefish
        173034, -- Silvergill Pike
        173036, -- Spinefin Piranha
    },
    [4] = { -- Battle for Azeroth
        174328, -- Aberrant Voidfin
        152545, -- Frenzied Fangtooth
        152547, -- Great Sea Catfish
        167562, -- Ionized Minnow
        152546, -- Lane Snapper
        174327, -- Malformed Gnasher
        168646, -- Mauve Stinger
        162515, -- Midnight Salmon
        152549, -- Redtail Loach
        152543, -- Sand Shifter
        152544, -- Slimy Mackerel
        152548, -- Tiragarde Perch
        168302, -- Viper Fish
    },
    [5] = { -- Legion
        139669, -- Ancient Black Barracuda
        139660, -- Ancient Highmountain Salmon
        139657, -- Ancient Mossgill
        139667, -- Axefish
        124112, -- Black Barracuda
        139659, -- Coldriver Carp
        124107, -- Cursed Queenfish
        139654, -- Ghostly Queenfish
        133735, -- Graybelly Lobster
        124109, -- Highmountain Salmon
        143748, -- Leyscale Koi
        133725, -- Leyshimmer Blenny
        139664, -- Magic-Eater Frog
        124108, -- Mossgill Perch
        133731, -- Mountain Puffer
        133726, -- Nar'thalas Hermit
        133734, -- Oodelfjisk
        124111, -- Runescale Koi
        133741, -- Seabottom Squid
        139665, -- Seerspine Puffer
        133607, -- Silver Mackerel
        124110, -- Stormray
        139666, -- Tainted Runescale Koi
        139655, -- Terrorfin
        133729, -- Thorned Flounder
        139663, -- Thundering Stormray
    },
    [6] = { -- Warlords of Draenor
        111664, -- Abyssal Gulper Eel
        118414, -- Awesomefish
        111663, -- Blackwater Whiptail
        111667, -- Blind Lake Sturgeon
        111595, -- Crescent Saberfish
        111668, -- Fat Sleeper
        111666, -- Fire Ammonite
        110508, -- "Fragrant" Pheromone Fish
        118415, -- Grieferfish
        111669, -- Jawless Skulker
        118565, -- Savage Piranha
        111665, -- Sea Scorpion
        118511, -- Tyfish
    },
    [7] = { -- Mists of Pandaria
        74859, -- Emperor Salmon
        74857, -- Giant Mantis Shrimp
        74866, -- Golden Carp
        74856, -- Jade Lungfish
        74863, -- Jewel Danio
        74865, -- Krasarang Paddlefish
        74860, -- Redbelly Mandarin
        74864, -- Reef Octopus
        74861, -- Tiger Gourami
    },
    [8] = { -- Cataclysm
        53065, -- Albino Cavefish
        53071, -- Algaefin Rockfish
        53066, -- Blackbelly Mudfish
        53072, -- Deepsea Sagefish
        53070, -- Fathom Eel
        53064, -- Highland Guppy
        53068, -- Lavascale Catfish
        53063, -- Mountain Trout
        53069, -- Murglesnout
        53062, -- Sharptooth
        53067, -- Striped Lurker
    },
    [9] = { -- Wrath of the Lich King
        41812, -- Barrelhead Goby
        41808, -- Bonescale Snapper
        41805, -- Borean Man O' War
        41800, -- Deep Sea Monsterbelly
        41807, -- Dragonfin Angelfish
        41810, -- Fangtooth Herring
        43646, -- Fountain Goldfish
        41809, -- Glacial Salmon
        41814, -- Glassfin Minnow
        41802, -- Imperial Manta Ray
        41801, -- Moonglow Cuttlefish
        41806, -- Musselback Sculpin
        41813, -- Nettlefish
        41803, -- Rockfin Grouper
        43571, -- Sewer Carp
        43647, -- Shimmering Minnow
        43652, -- Slippery Eel
    },
    [10] = { -- The Burning Crusade
        27422, -- Barbed Gill Trout
        33823, -- Bloodfin Catfish
        33824, -- Crescent-Tail Skullfish
        27435, -- Figluster's Mudfish
        27439, -- Furious Crawdad
        35285, -- Giant Sunfish
        27438, -- Golden Darter
        27437, -- Icefin Bluefish
        27425, -- Spotted Feltail
        27429, -- Zangarian Sporefish
    },
    [11] = { -- Classic
        19803, -- Brownell's Blue Striped Racer
        13888, -- Darkclaw Lobster
        12238, -- Darkshore Grouper
        6522,  -- Deviate Fish
        19806, -- Dezian Queenfish
        16967, -- Feralas Ahi
        6359,  -- Firefin Snapper
        6717,  -- Gaffer Jack
        19805, -- Keefer's Angelfish
        13893, -- Large Raw Mightfish
        13757, -- Lightning Eel
        16970, -- Misty Reed Mahi Mahi
        6458,  -- Oil Covered Fish
        6358,  -- Oily Blackmouth
        6291,  -- Raw Brilliant Smallfish
        6308,  -- Raw Bristle Whisker Catfish
        13754, -- Raw Glossy Mightfish
        21153, -- Raw Greater Sagefish
        6317,  -- Raw Loch Frenzy
        6289,  -- Raw Longjaw Mud Snapper
        8365,  -- Raw Mithril Head Trout
        13759, -- Raw Nightfin Snapper
        6361,  -- Raw Rainbow Fin Albacore
        13758, -- Raw Redgill
        6362,  -- Raw Rockscale Cod
        21071, -- Raw Sagefish
        6303,  -- Raw Slitherskin Mackerel
        4603,  -- Raw Spotted Yellowtail
        13756, -- Raw Summer Bass
        13760, -- Raw Sunscale Salmon
        13889, -- Raw Whitescale Salmon
        16968, -- Sar'theris Striker
        16969, -- Savage Coast Blue Sailfin
        6299,  -- Sickly Looking Fish
        19807, -- Speckled Tastyfish
        1467,  -- Spotted Sunfish
        13422, -- Stonescale Eel
        13755, -- Winter Squid
    },
    -- [12] = { -- Midnight
    -- },
}

local ITEM_NAME_OVERRIDES = {
    [2770]   = "Copper",
    [2771]   = "Tin",
    [2772]   = "Iron",
    [2775]   = "Silver",
    [2776]   = "Gold",
    [3858]   = "Mithril",
    [7911]   = "Truesilver",
    [10620]  = "Thorium",
    [11370]  = "Dark Iron",
    [23424]  = "Fel Iron",
    [23425]  = "Adamantite",
    [23426]  = "Khorium",
    [23427]  = "Eternium",
    [36910]  = "Titanium",
    [36909]  = "Cobalt",
    [36912]  = "Saronite",
    [52183]  = "Pyrite",
    [52185]  = "Elementium",
    [53038]  = "Obsidium",
    [72092]  = "Ghost Iron",
    [72093]  = "Kyparite",
    [72094]  = "Black Trillium",
    [72103]  = "White Trillium",
    [109118] = "Blackrock",
    [109119] = "True Iron",
    [123918] = "Leystone",
    [123919] = "Felslate",
    [151564] = "Empyrium",
    [152512] = "Monelite",
    [152513] = "Platinum",
    [152579] = "Storm Silver",
    [171828] = "Laestrite",
    [171829] = "Solenium",
    [171830] = "Oxxein",
    [171831] = "Phaedrum",
    [171832] = "Sinvyr",
    [171833] = "Elethium",
    [188658] = "Draconium",
    [190312] = "Khaz'gorite",
    [190396] = "Serevite",
    [210930] = "Bismuth",
    [210936] = "Ironclaw",
    [237359] = "Refulgent Copper",
    [237362] = "Umbral Tin",
    [237364] = "Brilliant Silver",
    [210933] = "Aqirite",
}

-- Miscellaneous Crafting Materials
local MISC_CRAFTING_MATERIALS = {
    -- Classic Materials
    10308,  -- Fel Iron Bar
    11371,  -- Dark Iron Bar
    12359,  -- Arcanite Bar
    12360,  -- Eternium Bar
    12365,  -- Dense Stone
    12808,  -- Eternium Thread
    12810,  -- Silver Rod
    14344,  -- Rune Thread
    16203,  -- Illusion Dust
    17010,  -- Runed Golden Rod
    17011,  -- Lava Core
    
    -- Outland Materials
    22445,  -- Arcane Dust
    22446,  -- Greater Planar Essence
    22449,  -- Large Prismatic Shard
    22450,  -- Void Crystal
    22452,  -- Primal Nether
    23441,  -- Adamantite Frame
    23445,  -- Fel Iron Bar
    23449,  -- Felsteel Bar
    23573,  -- Eternium Bar
    23782,  -- Knothide Leather
    23783,  -- Netherweave Cloth
    23785,  -- Primal Life
    23786,  -- Primal Shadow
    23793,  -- Fel Hide
    
    -- Northrend Materials
    35622,  -- Eternal Air
    35623,  -- Eternal Earth
    35624,  -- Eternal Fire
    35625,  -- Eternal Life
    35627,  -- Eternal Water
    36860,  -- Eternal Might
    36916,  -- Eternal Shadow
    36925,  -- Runed Orb
    36931,  -- Runed Stygian Belt
    
    -- Cataclysm Materials
    52325,  -- Dream Emerald
    52326,  -- Ember Topaz
    52327,  -- Ocean Sapphire
    52328,  -- Amberjewel
    52329,  -- Demonseye
    52555,  -- Jasper
    52722,  -- Carnelian
    52979,  -- Inferno Ruby
    52980,  -- Ember Topaz
    53010,  -- Nightstone
    53039,  -- Zephyrite
    53643,  -- Hessonite
    54440,  -- Alicite
    54450,  -- Nightstone
    54849,  -- Elusive Dream Emerald
    55053,  -- Vivid Dream Emerald
    56850,  -- Shadowspirit Diamond
    60224,  -- Maelstrom Crystal
    61978,  -- Volatile Air
    61981,  -- Volatile Earth
    67749,  -- Pyrium Bar
    
    -- Pandaria Materials
    72095,  -- Ghost Iron Bar
    72096,  -- Kyparite
    72104,  -- Trillium Bar
    72234,  -- Green Tea Leaf
    72237,  -- Rain Poppy
    72238,  -- Golden Lotus
    72988,  -- Spirit of Harmony
    74247,  -- Sha Crystal
    74248,  -- Mysterious Essence
    74662,  -- Juicycrunch Carrot
    74839,  -- Mogu Pumpkin
    74843,  -- Scallions
    74845,  -- Red Blossom Leek
    74853,  -- Ginseng
    74866,  -- Golden Carp
    76061,  -- Imperial Manta Ray
    76098,  -- Jade Lungfish
    76734,  -- Tiger Gourami
    77467,  -- Balanced Trillium Ingot
    77468,  -- Living Steel
    7910,   -- Wildfowl Egg
    79254,  -- Rice
    79255,  -- Soy Sauce
    80433,  -- Yak Milk
    87872,  -- Primal Diamond
    
    -- Draenor Materials
    109118, -- Blackrock
    109119, -- True Iron
    110609, -- Raw Beast Hide
    111245, -- Gorgrond Flytrap
    111449, -- Fireweed
    111557, -- Frostweed
    113261, -- True Iron Bar
    113262, -- Blackrock Bar
    113263, -- Steelforged Essence
    113264, -- Truesteel Bar
    113588, -- Luminous Shard
    114931, -- Gearspring Parts
    115352, -- War Paints
    115805, -- Alchemical Catalyst
    115811, -- Primal Spirit
    117454, -- Powdered Garnet
    118472, -- True Iron Nugget
    120945, -- Talador Orchid
    
    -- Legion Materials
    124105, -- Starlight Rose
    124106, -- Felwort
    124109, -- Highmountain Salmon
    124113, -- Stonehide Leather
    124116, -- Stormscale
    124124, -- Leylight Shard
    124437, -- Chaos Crystal
    124438, -- Light's Essence
    124440, -- Fjarnskaggl
    124441, -- Astral Glory
    124442, -- Dreamleaf
    124461, -- Unbroken Tooth
    127004, -- Eye of Prophecy
    127037, -- Pristine Falcosaur Feather
    127759, -- Mark of Honor
    127835, -- Unbroken Fang
    127838, -- Unbroken Claw
    12799,  -- Ichor of Undeath
    129032, -- Fel-Infused Siphon
    129034, -- Empyrial Fragment
    129100, -- Dimensional Ripper
    130175, -- Blood of Sargeras
    130176, -- Lightblood Elixir
    130183, -- Tears of the Naaru
    132514, -- Felslate
    136633, -- Leystone Seam
    136637, -- Felslate Deposit
    
    -- Battle for Azeroth Materials
    151564, -- Empyrium
    151565, -- Astral Glory
    151566, -- Fiendish Leather
    152510, -- Anchor Weed
    152511, -- Sea Stalk
    152541, -- Coarse Leather
    152542, -- Hardened Tempest Hide
    152576, -- Akunda's Bite
    154123, -- Riverbud
    154164, -- Blood-Stained Bone
    154722, -- Tempest Hide
    154886, -- Siren's Pollen
    154898, -- Star Moss
    158186, -- Winter's Kiss
    160502, -- Monelite Deposit
    160711, -- Storm Silver Deposit
    163569, -- Platinum Deposit
    166970, -- Runic Core
    168185, -- Blood-Stained Bone
    
    -- Shadowlands Materials
    171289, -- Rising Glory
    171292, -- Death Blossom
    171428, -- Soul Ash
    171441, -- Soul Cinders
    171828, -- Laestrite
    171829, -- Solenium
    171830, -- Oxxein
    171831, -- Phaedrum
    171832, -- Sinvyr
    171833, -- Elethium
    172049, -- Vigil's Torch
    172055, -- Marrowroot
    172092, -- Pallid Bone
    172093, -- Desolate Leather Scraps
    172094, -- Callous Hide
    172096, -- Heavy Desolate Leather
    172097, -- Heavy Callous Hide
    172230, -- Gravestone
    172232, -- Stygia
    172437, -- Medallion of Service
    172934, -- Cosmic Flux
    172935, -- Singularium
    172936, -- Infurious Alloy
    173032, -- Lost Sole
    173033, -- Iridescent Amberjack
    173034, -- Silvergill Pike
    173035, -- Pocked Bonefish
    173036, -- Spinefin Piranha
    173037, -- Elysian Thade
    173109, -- Everburning Core
    173110, -- Harmonious Crystal
    173170, -- Soul Ignitor
    173171, -- Sanctum Searing Core
    173173, -- Concentrated Animastore
    173202, -- Nightshade
    177061, -- Cerulean Pigment
    183953, -- Widowbloom
    
    -- Dragonflight Materials
    188658, -- Draconium Ore
    189143, -- Primeval Draconium Ore
    189541, -- Obsidian Whetstone
    190311, -- Raw Khaz'gorite
    190312, -- Khaz'gorite
    190313, -- Primal Khaz'gorite
    190314, -- Pristine Khaz'gorite
    190324, -- Keen Edge
    190394, -- Raw Serevite
    190395, -- Serevite
    190396, -- Primal Serevite
    191363, -- Artisan's Mettle
    191384, -- Primalist Pigment
    191460, -- Hochenblume Seed
    191461, -- Hochenblume Petal
    191462, -- Hochenblume
    191464, -- Saxifrage
    191465, -- Primal Saxifrage
    191466, -- Pristine Saxifrage
    191467, -- Bubble Poppy Bulb
    191468, -- Bubble Poppy
    191469, -- Primal Bubble Poppy
    191470, -- Writhebark
    191471, -- Primal Writhebark
    191472, -- Pristine Writhebark
    191496, -- Chromatic Pocketwatch
    192837, -- Time-Lost Crystal
    192840, -- Time-Lost Jewel
    192843, -- Time-Lost Prism
    192846, -- Time-Lost Gem
    192849, -- Time-Lost Ruby
    192876, -- Temporal Crystal
    192883, -- Temporal Flux
    193208, -- Resilient Leather
    193210, -- Primal Resilient Leather
    193211, -- Pristine Resilient Leather
    193213, -- Adamant Scales
    193214, -- Primal Adamant Scales
    193215, -- Pristine Adamant Scales
    193222, -- Lustrous Scaled Hide
    193223, -- Primal Lustrous Scaled Hide
    193224, -- Pristine Lustrous Scaled Hide
    193922, -- Storm Sigil
    194784, -- Stormbreaker
    194874, -- Stormcaller's Edge
    194966, -- Thousandbite Piranha
    194967, -- Aileron Seamoth
    194968, -- Cerulean Spinefish
    194969, -- Temporal Dragonhead
    194970, -- Islefin Dorado
    197745, -- Azuremire Hydra Scale
    197756, -- Ohn'ahran Windscale
    197764, -- Kal'derai Whale Scale
    197774, -- Azuremire Hydra Scale
    197776, -- Ohn'ahran Windscale
    197788, -- Kal'derai Whale Scale
    198183, -- Handful of Serevite Bolts
    198186, -- Shock-Spring Coil
    198192, -- Greased-Up Gears
    198198, -- Reinforced Machine Chassis
    198395, -- Dull Spined Clams
    198487, -- Temporal Dust
    199344, -- Magma Thresher
    200061, -- Prismatic Leaper
    200074, -- Frosted Rimefin Tuna
    200113, -- Temporal Crystal
    200953, -- Azuremire Hydra Scale
    201406, -- Temporal Dust
    202072, -- Frigid Floe Fish
    202073, -- Calamitous Carp
    202074, -- Kingfin
    204634, -- Storm Sigil
    
    -- The War Within Materials
    21071,  -- Sagefish
    210796, -- Mycobloom
    210797, -- Primal Mycobloom
    210798, -- Pristine Mycobloom
    210802, -- Orbinid
    210803, -- Primal Orbinid
    210804, -- Pristine Orbinid
    210805, -- Blessing Blossom
    210806, -- Primal Blessing Blossom
    210807, -- Pristine Blessing Blossom
    210808, -- Arathor's Spear
    210809, -- Primal Arathor's Spear
    210810, -- Pristine Arathor's Spear
    210930, -- Bismuth
    210931, -- Primal Bismuth
    210932, -- Pristine Bismuth
    210933, -- Aqirite
    210934, -- Primal Aqirite
    210935, -- Pristine Aqirite
    210936, -- Ironclaw
    210937, -- Primal Ironclaw
    210938, -- Pristine Ironclaw
    211806, -- Singed Core
    212245, -- Sulfuric Flux
    212498, -- Stormcharged Gear
    212508, -- Stormcharged Essence
    212563, -- Singed Core
    212664, -- Stormcharged Leather
    212665, -- Primal Stormcharged Leather
    212666, -- Pristine Stormcharged Leather
    212667, -- Gloom Chitin
    212668, -- Primal Gloom Chitin
    212669, -- Pristine Gloom Chitin
    212670, -- Thunderous Hide
    212672, -- Primal Thunderous Hide
    212673, -- Pristine Thunderous Hide
    212674, -- Sunless Carapace
    212675, -- Primal Sunless Carapace
    212676, -- Pristine Sunless Carapace
    213399, -- Stormcharged Gear
    213610, -- Singed Core
    219949, -- Sulfuric Flux
    219952, -- Singed Core
    221754, -- Stormcharged Essence
    221756, -- Stormcharged Gear
    221758, -- Singed Core
    221763, -- Sulfuric Flux
    221853, -- Handful of Bismuth Bolts
    221856, -- Whimsical Wiring
    221859, -- Gyrating Gear
    221865, -- Chaos Circuit
    221868, -- Entropy Enhancer
    222417, -- Core Alloy
    222420, -- Charged Alloy
    222523, -- Coreforged Skeleton Key
    222705, -- Roasted Mycobloom
    222731, -- Outsider's Provisions
    222737, -- Chopped Mycobloom
    222739, -- Spiced Meat Stock
    223971, -- Azj-Kahet Special
    224108, -- Sulfuric Flux
    224824, -- Singed Core
    224828, -- Sulfuric Flux
    226204, -- Singed Core
    226205, -- Singed Core
    
    -- Miscellaneous Items
    2325,   -- Heavy Leather
    3371,   -- Crystal Vial
    3820,   -- Stranglekelp
    3857,   -- Mageroyal
    6260,   -- Lesser Moonstone
    25708,  -- Thick Clefthoof Leather
    25867,  -- Felsteel Stabilizer
    25868,  -- Khorium Power Core
    259894, -- Salt
    2604,   -- Forest Mushroom Cap
    29539,  -- Arcane Rune
    31079,  -- Golden Pearl
    32230,  -- Primal Nether
    32423,  -- Netherweave Cloth
    33447,  -- Frost Lotus
    33458,  -- Lichbloom
    34054,  -- Adder's Tongue
    34055,  -- Goldclover
    34057,  -- Tiger Lily
    34440,  -- Dreaming Glory
    36905,  -- Lichbloom
    36908,  -- Frost Lotus
    37663,  -- Cobalt Bar
    38425,  -- Heavy Borean Leather
    38426,  -- Borean Leather
    39354,  -- Infinite Dust
    39681,  -- Cobalt Bar
    39682,  -- Saronite Bar
    39683,  -- Titanium Bar
    40077,  -- Fire Leaf
    41163,  -- Crystallized Air
    41266,  -- Crystallized Earth
    41510,  -- Crystallized Fire
    41594,  -- Crystallized Life
    41595,  -- Crystallized Shadow
    42225,  -- Crystallized Water
    43102,  -- Crystallized Life
    43119,  -- Dream Shard
    43121,  -- Infinite Dust
    43123,  -- Dream Shard
    43124,  -- Infinite Dust
    43125,  -- Dream Shard
    43126,  -- Infinite Dust
    43127,  -- Dream Shard
    4341,   -- Heavy Stock
    4342,   -- Iron Buckle
    44128,  -- Arctic Fur
    44501,  -- Saronite Bar
    45087,  -- Cobalt Bar
    52078,  -- Pyrium Bar
    52186,  -- Elementium Bar
    52190,  -- Hardened Elementium Bar
    52193,  -- Obsidium Bar
    52976,  -- Savage Leather
    52985,  -- Azshara's Veil
    52988,  -- Whiptail
    56516,  -- Heavy Savage Leather
    6037,   -- Heart of Fire
    69237,  -- Pyrium Bar
    7076,   -- Ironwood Branch
    7078,   -- Ironwood Root
    8170,   -- Rugged Leather
    82441,  -- Primal Diamond
    82444,  -- Dream Emerald
    83092,  -- Maelstrom Crystal
    94289,  -- Mysterious Essence
    
    -- High-Tier Housing Curios
    219962, -- Hungering Void Curio
    219963, -- Flame-Warped Curio
    219964, -- Excessively Bejeweled Curio
    234581, -- Slumbering Soul Serum
    243581, -- Evercore
}

-- Export as a shared/global dataset so UI/modules can use this as the canonical raw mats list.
_G.HousingRawMats = _G.HousingRawMats or {}
local RawMats = _G.HousingRawMats

RawMats.CATEGORIES = CATEGORIES
RawMats.LUMBER_ITEMS = LUMBER_ITEMS
RawMats.HERB_ITEMS = HERB_ITEMS
RawMats.ORE_ITEMS = ORE_ITEMS
RawMats.LEATHER_ITEMS = LEATHER_ITEMS
RawMats.FISH_ITEMS = FISH_ITEMS
RawMats.MISC_CRAFTING_MATERIALS = MISC_CRAFTING_MATERIALS
RawMats.ITEM_VARIANTS = ITEM_VARIANTS
RawMats.ITEM_NAME_OVERRIDES = ITEM_NAME_OVERRIDES

-- Optional: reagent source categorization. This is the single source of truth.
-- Values: "vendor", "gather", "craft"
-- If an itemID is missing, it will be treated as "unknown" (with some safe fallbacks in the UI).
RawMats.REAGENT_SOURCES = RawMats.REAGENT_SOURCES or {}

-- Optional: base vendor buy prices (copper). These are best-effort defaults and may vary by vendor/discount.
-- If a price is missing here, the addon can still learn it by scanning the merchant window and caching it.
RawMats.VENDOR_BASE_PRICES = RawMats.VENDOR_BASE_PRICES or {
    -- Source list: your vendor reagent list (lowest/common price when a range exists).
    [3857] = 475,     -- Coal (4s 75c)
    [14341] = 5000,   -- Rune Thread (50s)
    [38426] = 24000,  -- Eternium Thread (2g 40s)
    [83092] = 200000, -- Orb of Mystery (20g)
    [115352] = 22500, -- Telmor-Aruuna Hard Cheese (2g 25s)
    [127037] = 4000,  -- Runic Catgut (40s)
    [133588] = 25000, -- Flaked Sea Salt (2g 50s)
    [158186] = 320,   -- Distilled Water (3s 20c)
    [159959] = 48,    -- Nylon Thread (48c)
    [160298] = 20,    -- Durable Flux (20c)
    [173060] = 4000,  -- Aerated Water (40s)
    [175886] = 540,   -- Dark Parchment (5s 40c)
    [177062] = 40000, -- Penumbra Thread (4g)
    [183953] = 720,   -- Sealing Wax (7s 20c)
    [194784] = 10000, -- Glittering Parchment (1g)
    [198487] = 2000,  -- Iridescent Water (20s)
    [224764] = 560,   -- Mosswool Thread (5s 60c)
    [226204] = 1684,  -- Fresh Parchment (16s 84c)
    [226205] = 7600,  -- Distilled Algari Freshwater (76s)
    [259894] = 475,   -- Perfect Preservatives (4s 75c)
    [219962] = 100000, -- Hungering Void Curio (10g)
    [219963] = 100000, -- Flame-Warped Curio (10g)
    [219964] = 100000, -- Excessively Bejeweled Curio (10g)
    [234581] = 50000,  -- Slumbering Soul Serum (5g)
    [243581] = 75000,  -- Evercore (7g 50s)
}

do
    local function Fill(list, value)
        if type(list) ~= "table" then return end
        for i = 1, #list do
            local id = tonumber(list[i])
            if id and RawMats.REAGENT_SOURCES[id] == nil then
                RawMats.REAGENT_SOURCES[id] = value
            end
        end
    end

    local function FillByExpansionTable(tbl, value)
        if type(tbl) ~= "table" then return end
        for _, list in pairs(tbl) do
            Fill(list, value)
        end
    end

    -- Default categorization: gathering materials
    FillByExpansionTable(HERB_ITEMS, "gather")
    FillByExpansionTable(ORE_ITEMS, "gather")
    FillByExpansionTable(LEATHER_ITEMS, "gather")
    FillByExpansionTable(FISH_ITEMS, "gather")

    -- Default categorization: processed materials
    FillByExpansionTable(LUMBER_ITEMS, "craft")
end




local ReagentSources = {
    -- Vendor (30 items)
    [74853] = "Vendor", -- 100 Year Soy Sauce
    [173060] = "Vendor", -- Aerated Water
    [2325] = "Vendor", -- Black Dye
    [6260] = "Vendor", -- Blue Dye
    [3857] = "Vendor", -- Coal
    [3371] = "Vendor", -- Crystal Vial
    [175886] = "Vendor", -- Dark Parchment
    [226205] = "Vendor", -- Distilled Algari Freshwater
    [158186] = "Vendor", -- Distilled Water
    [160298] = "Vendor", -- Durable Flux
    [38426] = "Vendor", -- Eternium Thread
    [226204] = "Vendor", -- Fresh Parchment
    [194784] = "Vendor", -- Glittering Parchment
    [82444] = "Vendor", -- Greater Pearlescent Spellthread
    [198487] = "Vendor", -- Iridescent Water
    [39354] = "Vendor", -- Light Parchment
    [224764] = "Vendor", -- Mosswool Thread
    [159959] = "Vendor", -- Nylon Thread
    [83092] = "Vendor", -- Orb of Mystery
    [222731] = "Vendor", -- Outsider's Provisions
    [177062] = "Vendor", -- Penumbra Thread
    [259894] = "Vendor", -- Perfect Preservatives
    [54450] = "Vendor", -- Powerful Ghostly Spellthread
    [4342] = "Vendor", -- Purple Dye
    [2604] = "Vendor", -- Red Dye
    [14341] = "Vendor", -- Rune Thread
    [127037] = "Vendor", -- Runic Catgut
    [183953] = "Vendor", -- Sealing Wax
    [221756] = "Vendor", -- Vial of Kaheti Oils
    [4341] = "Vendor", -- Yellow Dye

    -- Gathering (170 items)
    [34057] = "Gathering", -- Abyss Crystal
    [154123] = "Gathering", -- Amberblaze
    [212498] = "Gathering", -- Ambivalent Amber
    [36931] = "Gathering", -- Ametrine
    [152510] = "Gathering", -- Anchor Weed
    [173109] = "Gathering", -- Angerseye
    [22445] = "Gathering", -- Arcane Dust
    [44128] = "Gathering", -- Arctic Fur
    [151718] = "Gathering", -- Argulite
    [124440] = "Gathering", -- Arkhana
    [151565] = "Gathering", -- Astral Glory
    [190327] = "Gathering", -- Awakened Air
    [190316] = "Gathering", -- Awakened Earth
    [190324] = "Gathering", -- Awakened Order
    [52985] = "Gathering", -- Azshara's Veil
    [13468] = "Gathering", -- Black Lotus
    [52979] = "Gathering", -- Blackened Dragonscale
    [109118] = "Gathering", -- Blackrock Ore
    [124124] = "Gathering", -- Blood of Sargeras
    [154164] = "Gathering", -- Blood-Stained Bone
    [154165] = "Gathering", -- Calcified Bone
    [172094] = "Gathering", -- Callous Hide
    [124442] = "Gathering", -- Chaos Crystal
    [130175] = "Gathering", -- Chaotic Spinel
    [160502] = "Gathering", -- Chemical Blasting Cap
    [151720] = "Gathering", -- Chemirine
    [222737] = "Gathering", -- Chopped Mycobloom
    [152541] = "Gathering", -- Coarse Leather
    [29539] = "Gathering", -- Cobra Scales
    [222523] = "Gathering", -- Coreforged Skeleton Key
    [213610] = "Gathering", -- Crystalline Powder
    [133589] = "Gathering", -- Dalapeno Pepper
    [20520] = "Gathering", -- Dark Rune
    [56850] = "Gathering", -- Deepstone Oil
    [12365] = "Gathering", -- Dense Stone
    [172089] = "Gathering", -- Desolate Leather
    [15417] = "Gathering", -- Devilsaur Leather
    [42225] = "Gathering", -- Dragon's Eye
    [54440] = "Gathering", -- Dreamcloth
    [52193] = "Gathering", -- Ember Topaz
    [53010] = "Gathering", -- Embersilk Cloth
    [158378] = "Gathering", -- Embroidered Deep Sea Satin
    [7076] = "Gathering", -- Essence of Earth
    [7078] = "Gathering", -- Essence of Fire
    [173170] = "Gathering", -- Essence of Rebirth
    [173172] = "Gathering", -- Essence of Servitude
    [173171] = "Gathering", -- Essence of Torment
    [12808] = "Gathering", -- Essence of Undeath
    [173173] = "Gathering", -- Essence of Valor
    [35623] = "Gathering", -- Eternal Air
    [172232] = "Gathering", -- Eternal Crystal
    [35624] = "Gathering", -- Eternal Earth
    [36860] = "Gathering", -- Eternal Fire
    [35625] = "Gathering", -- Eternal Life
    [35627] = "Gathering", -- Eternal Shadow
    [35622] = "Gathering", -- Eternal Water
    [74247] = "Gathering", -- Ethereal Shard
    [127759] = "Gathering", -- Felblight
    [124116] = "Gathering", -- Felhide
    [124106] = "Gathering", -- Felwort
    [17010] = "Gathering", -- Fiery Core
    [36908] = "Gathering", -- Frost Lotus
    [43102] = "Gathering", -- Frozen Orb
    [129100] = "Gathering", -- Gem Chip
    [74845] = "Gathering", -- Ginseng
    [152875] = "Gathering", -- Gloom Dust
    [74866] = "Gathering", -- Golden Carp
    [72238] = "Gathering", -- Golden Lotus
    [13926] = "Gathering", -- Golden Pearl
    [117454] = "Gathering", -- Gorgrond Grapes
    [34055] = "Gathering", -- Greater Cosmic Essence
    [16203] = "Gathering", -- Greater Eternal Essence
    [22446] = "Gathering", -- Greater Planar Essence
    [72234] = "Gathering", -- Green Tea Leaf
    [171292] = "Gathering", -- Ground Nightshade
    [171289] = "Gathering", -- Ground Widowbloom
    [94289] = "Gathering", -- Haunting Spirit
    [56516] = "Gathering", -- Heavy Savage Leather
    [52555] = "Gathering", -- Hypnotic Dust
    [52190] = "Gathering", -- Inferno Ruby
    [34054] = "Gathering", -- Infinite Dust
    [171828] = "Gathering", -- Laestrite Ore
    [171441] = "Gathering", -- Laestrite Skeleton Key
    [14344] = "Gathering", -- Large Brilliant Shard
    [12799] = "Gathering", -- Large Opal
    [17011] = "Gathering", -- Lava Core
    [124441] = "Gathering", -- Leylight Shard
    [36905] = "Gathering", -- Lichbloom
    [173204] = "Gathering", -- Lightless Silk
    [69237] = "Gathering", -- Living Ember
    [111245] = "Gathering", -- Luminous Shard
    [52722] = "Gathering", -- Maelstrom Crystal
    [130182] = "Gathering", -- Maelstrom Sapphire
    [72163] = "Gathering", -- Magnificent Hide
    [36925] = "Gathering", -- Majestic Zircon
    [31079] = "Gathering", -- Mercurial Adamantite
    [20963] = "Gathering", -- Mithril Filigree
    [152512] = "Gathering", -- Monelite Ore
    [23441] = "Gathering", -- Nightseye
    [55053] = "Gathering", -- Obsidium Skeleton Key
    [168185] = "Gathering", -- Osmenite Ore
    [39682] = "Gathering", -- Overcharged Capacitor
    [136637] = "Gathering", -- Oversized Blasting Cap
    [154120] = "Gathering", -- Owlseye
    [171830] = "Gathering", -- Oxxein Ore
    [172092] = "Gathering", -- Pallid Bone
    [130181] = "Gathering", -- Pandemonite
    [152513] = "Gathering", -- Platinum Ore
    [22452] = "Gathering", -- Primal Earth
    [21884] = "Gathering", -- Primal Fire
    [21886] = "Gathering", -- Primal Life
    [22457] = "Gathering", -- Primal Mana
    [120945] = "Gathering", -- Primal Spirit
    [52980] = "Gathering", -- Pristine Hide
    [221758] = "Gathering", -- Profaned Tinderbox
    [72237] = "Gathering", -- Rain Poppy
    [110609] = "Gathering", -- Raw Beast Hide
    [200113] = "Gathering", -- Resonant Crystal
    [133591] = "Gathering", -- River Onion
    [8170] = "Gathering", -- Rugged Leather
    [118472] = "Gathering", -- Savage Blood
    [52976] = "Gathering", -- Savage Leather
    [74843] = "Gathering", -- Scallions
    [152511] = "Gathering", -- Sea Stalk
    [76734] = "Gathering", -- Serpent's Eye
    [74248] = "Gathering", -- Sha Crystal
    [130183] = "Gathering", -- Shadowruby
    [32230] = "Gathering", -- Shadowsong Amethyst
    [124437] = "Gathering", -- Shal'dorei Silk
    [173202] = "Gathering", -- Shrouded Cloth
    [171832] = "Gathering", -- Sinvyr Ore
    [130176] = "Gathering", -- Skystone
    [171829] = "Gathering", -- Solenium Ore
    [113264] = "Gathering", -- Sorcerous Air
    [113263] = "Gathering", -- Sorcerous Earth
    [113261] = "Gathering", -- Sorcerous Fire
    [113262] = "Gathering", -- Sorcerous Water
    [172230] = "Gathering", -- Soul Dust
    [222739] = "Gathering", -- Spiced Meat Stock
    [76061] = "Gathering", -- Spirit of Harmony
    [7910] = "Gathering", -- Star Ruby
    [124105] = "Gathering", -- Starlight Rose
    [124113] = "Gathering", -- Stonehide Leather
    [152579] = "Gathering", -- Storm Silver Ore
    [173126] = "Gathering", -- Straddling Jewel Doublet
    [3820] = "Gathering", -- Stranglekelp
    [212508] = "Gathering", -- Stunning Sapphire
    [111557] = "Gathering", -- Sumptuous Fur
    [154722] = "Gathering", -- Tempest Hide
    [113588] = "Gathering", -- Temporal Crystal
    [25708] = "Gathering", -- Thick Clefthoof Leather
    [152576] = "Gathering", -- Tidespray Linen
    [109119] = "Gathering", -- True Iron Ore
    [152876] = "Gathering", -- Umbra Shard
    [173110] = "Gathering", -- Umbryl
    [124438] = "Gathering", -- Unbroken Claw
    [152877] = "Gathering", -- Veiled Crystal
    [194124] = "Gathering", -- Vibrant Shard
    [221763] = "Gathering", -- Viridian Charmcap
    [22450] = "Gathering", -- Void Crystal
    [52328] = "Gathering", -- Volatile Air
    [52327] = "Gathering", -- Volatile Earth
    [52325] = "Gathering", -- Volatile Fire
    [52329] = "Gathering", -- Volatile Life
    [52326] = "Gathering", -- Volatile Water
    [52988] = "Gathering", -- Whiptail
    [200953] = "Gathering", -- Wild Dragon Fruit
    [193922] = "Gathering", -- Wildercloth
    [74839] = "Gathering", -- Wildfowl Breast
    [72988] = "Gathering", -- Windwool Cloth

    -- Crafted (126 items)
    [108996] = "Crafted", -- Alchemical Catalyst
    [160059] = "Crafted", -- Amber Tanning Oil
    [127835] = "Crafted", -- Ancient Mana Potion
    [12360] = "Crafted", -- Arcanite Bar
    [251772] = "Crafted", -- Arden Lumber
    [251764] = "Crafted", -- Ashwood Lumber
    [132514] = "Crafted", -- Auto-Hammer
    [223971] = "Crafted", -- Azj-Kahet Special
    [251763] = "Crafted", -- Bamboo Lumber
    [61978] = "Crafted", -- Blackfallow Ink
    [111449] = "Crafted", -- Blackrock Barbecue
    [80433] = "Crafted", -- Blood Spirit
    [53643] = "Crafted", -- Bolt of Embersilk Cloth
    [41510] = "Crafted", -- Bolt of Frostweave
    [21842] = "Crafted", -- Bolt of Imbued Netherweave
    [21840] = "Crafted", -- Bolt of Netherweave
    [14048] = "Crafted", -- Bolt of Runecloth
    [82441] = "Crafted", -- Bolt of Windwool Cloth
    [197788] = "Crafted", -- Braised Bruffalon Brisket
    [114931] = "Crafted", -- Cerulean Pigment
    [52078] = "Crafted", -- Chaos Orb
    [197774] = "Crafted", -- Charred Hornswog Steaks
    [36916] = "Crafted", -- Cobalt Bar
    [251762] = "Crafted", -- Coldwind Lumber
    [40077] = "Crafted", -- Crazy Alchemist's Potion
    [158188] = "Crafted", -- Crimson Ink
    [15407] = "Crafted", -- Cured Rugged Hide
    [11371] = "Crafted", -- Dark Iron Bar
    [43125] = "Crafted", -- Darkflame Ink
    [251768] = "Crafted", -- Darkpine Lumber
    [16006] = "Crafted", -- Delicate Arcanite Converter
    [124461] = "Crafted", -- Demonsteel Bar
    [87872] = "Crafted", -- Desecrated Oil
    [248012] = "Crafted", -- Dornic Fir Lumber
    [251773] = "Crafted", -- Dragonpine Lumber
    [25867] = "Crafted", -- Earthstorm Diamond
    [67749] = "Crafted", -- Electrified Ether
    [52186] = "Crafted", -- Elementium Bar
    [172437] = "Crafted", -- Enchanted Elethium Bar
    [12810] = "Crafted", -- Enchanted Leather
    [172439] = "Crafted", -- Enchanted Lightless Silk
    [166970] = "Crafted", -- Energy Cell
    [43124] = "Crafted", -- Ethereal Ink
    [23782] = "Crafted", -- Fel Iron Casing
    [251767] = "Crafted", -- Fel-Touched Lumber
    [23787] = "Crafted", -- Felsteel Stabilizer
    [43121] = "Crafted", -- Fiery Ink
    [256171] = "Crafted", -- Five Flights' Grimoire
    [22861] = "Crafted", -- Flask of Blinding Light
    [192872] = "Crafted", -- Fractured Glass
    [39683] = "Crafted", -- Froststeel Tube
    [72096] = "Crafted", -- Ghost Iron Bar
    [77467] = "Crafted", -- Ghost Iron Bolts
    [213399] = "Crafted", -- Glittering Glass
    [201406] = "Crafted", -- Glowing Titan Orb
    [44501] = "Crafted", -- Goblin-Machined Piston
    [115811] = "Crafted", -- Greater Haste Taladite
    [39681] = "Crafted", -- Handful of Cobalt Bolts
    [23783] = "Crafted", -- Handful of Fel Iron Bolts
    [172934] = "Crafted", -- Handful of Laestrite Bolts
    [60224] = "Crafted", -- Handful of Obsidium Bolts
    [23573] = "Crafted", -- Hardened Adamantite Bar
    [23785] = "Crafted", -- Hardened Adamantite Tube
    [53039] = "Crafted", -- Hardened Elementium Bar
    [38425] = "Crafted", -- Heavy Borean Leather
    [23793] = "Crafted", -- Heavy Knothide Leather
    [77468] = "Crafted", -- High-Explosive Gunpowder
    [32423] = "Crafted", -- Icy Blasting Primers
    [127004] = "Crafted", -- Imbued Silkweave
    [61981] = "Crafted", -- Inferno Ink
    [79254] = "Crafted", -- Ink of Dreams
    [43126] = "Crafted", -- Ink of the Sea
    [43123] = "Crafted", -- Ink of the Sky
    [163569] = "Crafted", -- Insulated Wiring
    [172049] = "Crafted", -- Iridescent Ravioli with Apple Sauce
    [245586] = "Crafted", -- Ironwood Lumber
    [23449] = "Crafted", -- Khorium Bar
    [23786] = "Crafted", -- Khorium Power Core
    [22449] = "Crafted", -- Large Prismatic Shard
    [72104] = "Crafted", -- Living Steel
    [136633] = "Crafted", -- Loose Trigger
    [173059] = "Crafted", -- Luminous Ink
    [34440] = "Crafted", -- Mad Alchemist's Potion
    [76098] = "Crafted", -- Master Mana Potion
    [115805] = "Crafted", -- Mastery Taladite
    [154898] = "Crafted", -- Meaty Haunch
    [14342] = "Crafted", -- Mooncloth
    [41594] = "Crafted", -- Moonshroud
    [172936] = "Crafted", -- Mortal Coiled Spring
    [54849] = "Crafted", -- Obsidium Bar
    [242691] = "Crafted", -- Olemba Lumber
    [172055] = "Crafted", -- Phantasmal Haunch
    [172935] = "Crafted", -- Porous Polishing Abrasive
    [21845] = "Crafted", -- Primal Mooncloth
    [221754] = "Crafted", -- Ringing Deeps Ingot
    [222705] = "Crafted", -- Roasted Mycobloom
    [129032] = "Crafted", -- Roseate Pigment
    [204634] = "Crafted", -- Rot Resistant Cauldron
    [43119] = "Crafted", -- Royal Ink
    [45087] = "Crafted", -- Runed Orb
    [33447] = "Crafted", -- Runic Healing Potion
    [197764] = "Crafted", -- Salad on the Side
    [129034] = "Crafted", -- Sallow Pigment
    [194874] = "Crafted", -- Scribe's Fastened Quill
    [10308] = "Crafted", -- Scroll of Intellect IV
    [33458] = "Crafted", -- Scroll of Intellect VI
    [24272] = "Crafted", -- Shadowcloth
    [171428] = "Crafted", -- Shadowghast Ingot
    [251766] = "Crafted", -- Shadowmoon Lumber
    [43127] = "Crafted", -- Snowfall Ink
    [24271] = "Crafted", -- Spellcloth
    [41595] = "Crafted", -- Spellweave
    [79255] = "Crafted", -- Starlight Ink
    [136693] = "Crafted", -- Straszan Mark
    [127838] = "Crafted", -- Sylvan Elixir
    [12359] = "Crafted", -- Thorium Bar
    [16000] = "Crafted", -- Thorium Tube
    [15994] = "Crafted", -- Thorium Widget
    [41163] = "Crafted", -- Titanium Bar
    [37663] = "Crafted", -- Titansteel Bar
    [175970] = "Crafted", -- Tranquil Ink
    [72095] = "Crafted", -- Trillium Bar
    [6037] = "Crafted", -- Truesilver Bar
    [177061] = "Crafted", -- Twilight Bark
    [158187] = "Crafted", -- Ultramarine Ink
    [173058] = "Crafted", -- Umbral Ink
    [160711] = "Gathering", -- Aromatic Fish Oil
    [197745] = "Gathering", -- Basilisk Eggs
    [133588] = "Vendor", -- Flaked Sea Salt
    [124109] = "Gathering", -- Highmountain Salmon
    [197756] = "Vendor", -- Pebbled Rock Salts
    [74662] = "Vendor", -- Rice Flour
    [25868] = "Crafted", -- Skyfire Diamond
    [41266] = "Crafted", -- Skyflare Diamond
    [154886] = "Gathering", -- Spiced Snapper
    [115352] = "Vendor", -- Telmor-Aruuna Hard Cheese
    [235401] = "Crafted", -- Thalassian Lumber
    [219962] = "Gathering", -- Hungering Void Curio
    [219963] = "Gathering", -- Flame-Warped Curio
    [219964] = "Gathering", -- Excessively Bejeweled Curio
    [234581] = "Crafted", -- Slumbering Soul Serum
    [243581] = "Crafted", -- Evercore

}

-- Merge explicit reagent sources into the canonical map (lowercase values expected by the UI).
do
    local function Normalize(v)
        v = type(v) == "string" and v:lower() or ""
        if v == "vendor" then return "vendor" end
        if v == "gathering" or v == "gather" then return "gather" end
        if v == "crafted" or v == "craft" then return "craft" end
        return "unknown"
    end

    for id, src in pairs(ReagentSources) do
        local itemID = tonumber(id)
        if itemID then
            RawMats.REAGENT_SOURCES[itemID] = Normalize(src)
        end
    end
end
