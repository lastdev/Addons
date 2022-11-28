---
--- @file
--- Map point definitions.
---

local _, this = ...

local Player = this.Player
local t = this.t
local map = this.maps['nagrand']

-- Alliance quest IDs for required quests.
local RequiredQuests = {
  -- Assault on the Broken Precipice
  ['assault on the broken precipice'] = 36816,
}

-- Horde quest IDs.
if (Player:isHorde() == true) then
  RequiredQuests = {
    -- Assault on the Broken Precipice
    ['assault on the broken precipice'] = 36817,
  }
end

-- Define NPCs we are going to use in multiple points.
local Lukhok = {
  npcId = 50981,
  icon = 'monster',
  note = t['multiple_spawn_note'],
  loot = {
    item = {
      -- Mottled Meadowstomper
      [116661] = { mountId = 614 },
    },
  },
}

local Nakk = {
  npcId = 50990,
  icon = 'monster',
  note = t['multiple_spawn_note'],
  loot = {
    item = {
      -- Bloodhoof Bull
      [116659] = { mountId = 612 },
    },
  },
}

local Voidtalon = {
  name = t['edge_of_reality'],
  icon = 'portal',
  note = t['edge_of_reality_note'],
  loot = {
    item = {
      -- Voidtalon of the Dark Star
      [121815] = { mountId = 682 },
    },
  },
}

local points = {
  --- Rares
  [66604400] = Lukhok,
  [76203180] = Lukhok,
  [72805360] = Lukhok,
  [79205600] = Lukhok,
  [84606360] = Lukhok,
  [86806560] = Lukhok,
  [62801540] = Nakk,
  [64601960] = Nakk,
  [55003500] = Nakk,
  [50003440] = Nakk,
  [40534764] = Voidtalon,
  [44033082] = Voidtalon,
  [57262656] = Voidtalon,

  -- Hyperious
  [87005480] = {
    npcId = 78161,
    questId = 34862,
    icon = 'monster',
    note = t['hyperious_note'],
    loot = {
      item = {
        -- Smoldering Heart of Hyperious
        [116799] = { subtype = t['trinket'] },
      },
    },
  },

  -- Warmaster Blugthol
  [82607620] = {
    npcId = 79024,
    questId = 34645,
    icon = 'monster',
    loot = {
      item = {
        -- Blug'thol's Bloody Bracers
        [116805] = { type = 'transmog' },
      },
    },
  },

  -- Captain Ironbeard
  [34607700] = {
    npcId = 79725,
    questId = 34727,
    icon = 'monster',
    loot = {
      item = {
        -- Iron Buccaneer's Hat
        [118244] = { type = 'toy' },
        -- Ironbeard's Blunderbuss
        [116809] = { type = 'transmog' },
      },
    },
  },

  -- Soulfang
  [75506540] = {
    npcId = 80057,
    questId = 36128,
    icon = 'monster',
    POI = { 74606390 },
    note = t['in_cave'],
    loot = {
      item = {
        -- Soul Fang
        [116806] = { type = 'transmog' },
      },
    },
  },

  -- Explorer Nozzand
  [89004090] = {
    npcId = 82486,
    questId = 35623,
    icon = 'monster',
    POI = { 88804310 },
    note = t['explorer_nozzand_note'],
  },

  -- Redclaw the Feral
  [73605780] = {
    npcId = 82755,
    questId = 35712,
    icon = 'monster',
    loot = {
      item = {
        -- Redclaw's Gutripper
        [118243] = { },
      },
    },
  },

  -- Greatfeather
  [66805120] = {
    npcId = 82758,
    questId = 35714,
    icon = 'monster',
    loot = {
      item = {
        -- Greatfeather's Down Robe
        [116795] = { type = 'transmog' },
      },
    },
  },

  -- Gar'lua
  [52205580] = {
    npcId = 82764,
    questId = 35715,
    icon = 'monster',
    loot = {
      item = {
        -- Call of the Wolfmother
        [118246] = { subtype = t['trinket'] },
      },
    },
  },

  -- Gnarlhoof the Rabid
  [66605660] = {
    npcId = 82778,
    questId = 35717,
    icon = 'monster',
    loot = {
      item = {
        -- Rabid Talbuk Horn
        [116824] = { subtype = t['trinket'] },
      },
    },
  },

  -- Ancient Blademaster
  [84605360] = {
    npcId = 82899,
    questId = 35778,
    icon = 'monster',
    loot = {
      item = {
        -- Blademaster's Honor
        [116832] = { subtype = t['neck'] },
      },
    },
  },

  -- Grizzlemaw
  [89407260] = {
    npcId = 82912,
    questId = 35784,
    icon = 'monster',
    loot = {
      item = {
        -- Grizzled Wolfskin Cloak
        [118687] = { type = 'transmog', subtype = t['cloak'] },
      },
    },
  },

  -- Fangler
  [74801180] = {
    npcId = 82975,
    questId = 35836,
    icon = 'monster',
    t['fangler_note'],
  },

  -- Netherspawn
  [47607060] = {
    npcId = 83401,
    questId = 35865,
    icon = 'monster',
    loot = {
      item = {
        -- Netherspawn, Spawn of Netherspawn
        [116815] = { petId = 1524 },
      },
    },
  },

  -- Ophiis
  [39004900] = {
    npcId = 83409,
    questId = 35875,
    icon = 'monster',
    path = { 39004900, 40204940, 42005020, 44004860, 45404740 },
    loot = {
      item = {
        -- Positive Pantaloons
        [116765] = { type = 'transmog' },
      },
    },
  },

  -- Windcaller Korast
  [70602920] = {
    npcId = 83428,
    questId = 35877,
    icon = 'monster',
    loot = {
      item = {
        -- Whirlwind's Harvest
        [116808] = { type = 'transmog' },
      },
    },
  },

  -- Flinthide
  [69804200] = {
    npcId = 83483,
    questId = 35893,
    icon = 'monster',
    loot = {
      item = {
        -- Flinthide's Impenetrable Crest
        [116807] = { type = 'transmog' },
      },
    },
  },

  -- Gorepetal
  [93102840] = {
    npcId = 83509,
    questId = 35898,
    icon = 'monster',
    POI = { 94102620 },
    note = t['in_cave'] .. ' ' .. t['gorepetal_note'],
    loot = {
      item = {
        -- Gorepetal's Gentle Grasp
        [116916] = { type = 'transmog' },
      },
    },
  },

  -- Ru'klaa
  [57808380] = {
    npcId = 83526,
    questId = 35900,
    icon = 'monster',
    loot = {
      item = {
        -- Carapace Shell Shoulders
        [118688] = { type = 'transmog' },
      },
    },
  },

  -- Sean Whitesea
  [60804760] = {
    npcId = 83542,
    questId = 35912,
    icon = 'monster',
    loot = {
      item = {
        -- Whitesea's Waistwrap
        [116834] = { type = 'transmog' },
      },
    },
  },

  -- Tura'aka
  [65003920] = {
    npcId = 83591,
    questId = 35920,
    icon = 'monster',
    loot = {
      item = {
        -- Tura'aka's Clipped Wing
        [116814] = { type = 'transmog', subtype = t['cloak'] },
      },
    },
  },

  -- Hunter Blacktooth
  [80603060] = {
    npcId = 83603,
    questId = 35923,
    icon = 'monster',
    loot = {
      item = {
        -- Hunter Blacktooth's Ribcruncher
        [118245] = { type = 'transmog' },
      },
    },
  },

  -- Scout Pokhar
  [54806120] = {
    npcId = 83634,
    questId = 35931,
    icon = 'monster',
    loot = {
      item = {
        -- Pokhar's Eighth Axe
        [116797] = { type = 'transmog' },
      },
    },
  },

  -- Malroc Stonesunder
  [81206000] = {
    npcId = 83643,
    questId = 35932,
    icon = 'monster',
    loot = {
      item = {
        -- Malroc's Staff of Command
        [116796] = { type = 'transmog' },
      },
    },
  },

  -- Outrider Duretha
  [61806900] = {
    npcId = 83680,
    questId = 35943,
    icon = 'monster',
    loot = {
      item = {
        -- Duretha's Trail Boots
        [116800] = { type = 'transmog' },
      },
    },
  },

  -- Graveltooth
  [83803680] = {
    npcId = 84263,
    questId = 36159,
    icon = 'monster',
    note = t['graveltooth_note'],
    loot = {
      item = {
        -- Graveltooth's Manacles
        [118689] = { type = 'transmog' },
      },
    },
  },

  -- Mr. Pinchy Sr.
  [45601520] = {
    npcId = 84435,
    questId = 36229,
    icon = 'monster',
    loot = {
      item = {
        -- Empty Crawdad Trap
        [118690] = { subtype = t['trinket'] },
      },
    },
  },

  -- Bergruu
  [61001220] = {
    npcId = 86732,
    questId = 37211,
    icon = 'monster',
    path = { 61001220, 61801280, 62401440, 62201720, 63601960, 65602220, 66002440 },
    loot = {
      item = {
        -- Bergruu's Horn
        [118655] = { },
      },
    },
  },

  -- Dekorhan
  [50204120] = {
    npcId = 86743,
    questId = 37221,
    icon = 'monster',
    loot = {
      item = {
        -- Dekorhan's Tusk
        [118656] = { },
      },
    },
  },

  -- Gagrog the Brutal
  [48202220] = {
    npcId = 86771,
    questId = 37223,
    icon = 'monster',
    loot = {
      item = {
        -- Gagrog's Skull
        [118658] = { },
      },
    },
  },

  -- Xelganak
  [41604500] = {
    npcId = 86835,
    questId = 37226,
    icon = 'monster',
    loot = {
      item = {
        -- Xelganak's Stinger
        [118661] = { },
      },
    },
  },

  -- Pit Beast
  [58201840] = {
    npcId = 88208,
    questId = 37637,
    icon = 'monster',
    loot = {
      item = {
        -- Pristine Hide of the Pit Beast
        [120317] = { type = 'transmog', subtype = t['cloak'] },
      },
    },
  },

  -- Aogexon
  [51601600] = {
    npcId = 86774,
    questId = 37210,
    icon = 'monster',
    loot = {
      item = {
        -- Aogexon's Fang
        [118654] = { },
      },
    },
  },

  -- Direhoof
  [60203860] = {
    npcId = 86729,
    questId = 37222,
    icon = 'monster',
    loot = {
      item = {
        -- Direhoof's Hide
        [118657] = { },
      },
    },
  },

  -- Mu'gra
  [34005160] = {
    npcId = 87666,
    questId = 37224,
    icon = 'monster',
    loot = {
      item = {
        -- Mu'gra's Head
        [118659] = { },
      },
    },
  },

  -- Vileclaw
  [37203900] = {
    npcId = 88951,
    questId = 37520,
    icon = 'monster',
    loot = {
      item = {
        -- Vileclaw's Claw
        [120172] = { },
      },
    },
  },

  -- Berserk T-300 Series Mark II
  [76406440] = {
    npcId = 82826,
    questId = 35735,
    icon = 'monster',
    POI = { 77106440 },
    note = t['in_cave'],
    loot = {
      item = {
        -- Katealystic Konverter
        [116823] = { subtype = t['trinket'] },
      },
    },
  },

  -- Pugg
  [28503030] = {
    npcId = 98199,
    questId = 40073,
    icon = 'monster',
    loot = {
      item = {
        -- Warm Arcane Crystal
        [129217] = { petId = 1766 },
      },
    },
  },

  -- Guk
  [23803790] = {
    npcId = 98200,
    questId = 40074,
    icon = 'monster',
    loot = {
      item = {
        -- Glittering Arcane Crystal
        [129218] = { petId = 1765 },
      },
    },
  },

  -- Rukdug
  [26203420] = {
    npcId = 98198,
    questId = 40075,
    icon = 'monster',
    loot = {
      item = {
        -- Vibrating Arcane Crystal
        [129216] = { petId = 1764 },
      },
    },
  },

  -- Gaz'orda
  [43607760] = {
    npcId = 80122,
    questId = 34725,
    icon = 'monster',
    POI = { 42207860 },
    note = t['in_cave'],
    loot = {
      item = {
        -- Gaz'orda's Grim Gaze
        [116798] = { subtype = t['ring'] },
      },
    },
  },

  -- Karosh Blackwind
  [45803480] = {
    npcId = 86959,
    questId = 37399,
    icon = 'monster',
    loot = {
      achievement = {
        -- The Song of Silence
        [9541] = { criteriaId = 26140 },
      },
      item = {
        -- Leggings of Howling Winds
        [119355] = { type = 'transmog' },
      },
    },
  },

  -- Brutag Grimblade
  [43003620] = {
    npcId = 87234,
    questId = 37400,
    icon = 'monster',
    loot = {
      achievement = {
        -- The Song of Silence
        [9541] = { criteriaId = 26141 },
      },
      item = {
        -- Brutag's Iron Toe Boots
        [119380] = { type = 'transmog' },
      },
    },
  },

  -- Krud the Eviscerator
  [58201200] = {
    npcId = 88210,
    questId = 37398,
    icon = 'monster',
    note = t['krud_eviscerator_note'],
    loot = {
      achievement = {
        -- Making the Cut
        [9617] = { },
      },
      item = {
        -- Krud's Girthy Girdle
        [119384] = { type = 'transmog' },
      },
    },
  },

  -- Thek'talon
  [59603260] = {
    npcId = 86750,
    questId = 37225,
    icon = 'monster',
    path = { 59603260, 56703710, 54703780, 52004080, 51204000, 50203810, 52203680, 55003380, 57203180, 60802780,
             61602220, 62602280, 64602720, 62203020, 59603260 },
    loot = {
      item = {
        -- Thek'talon's Talon
        [118660] = { },
      },
    },
  },

  -- Durg Spinecrusher
  [38802400] = {
    npcId = 87788,
    questId = 37395,
    icon = 'monster',
    path = { 38802400, 37202400, 35802320, 35402180, 35602060, 37001980, 37802080, 38802300, 38802400 },
    loot = {
      achievement = {
        -- Broke Back Precipice
        [9571] = { criteriaId = 26318 },
      },
      item = {
        -- Durg's Heavy Maul
        [119405] = { type = 'transmog' },
      },
    },
  },

  -- Warleader Tome
  [81406040] = {
    npcId = 81330,
    -- @todo Find quest id if there is any.
    questId = nil,
    icon = 'monster',
    path = { 81406040, 81606020, 81405820, 81105570, 82005270, 82004960, 78504470, 78404320, 72503870, 71603860,
             68003990, 62903390, 62703020, 64202610, 63202260, 63002070, 62502020, 62002070, 61002320, 59802340,
             58702410, 56202360, 50601880, 46001770, 45602280, 44702280, 44802380, 45402520, 45302560, 44402640,
             45102850, 44803180, 45203360, 41103880, 41104000, 42404130, 43204190, 47104110, 49404180, 50104480,
             51504670, 51304990, 53305200, 54705280, 56905310, 58805500, 60105710, 60705900, 61005970, 59706360,
             59706590, 59906670, 59606850, 60707060, 62607190, 64407330, 67407280, 68807110, 69007070, 73006760,
             73906730, 75606830, 76506860, 79706650, 79806460, 80006310, 81406040 },
    loot = {
      item = {
        -- Outrider's Bridle Chain
        [120276] = { type = 'toy' },
      },
    },
  },

  -- Bonebreaker
  [39801320] = {
    npcId = 87837,
    questId = 37396,
    icon = 'monster',
    path = { 39801320, 38601400, 38401500, 39201580 },
    loot = {
      achievement = {
        -- Broke Back Precipice
        [9571] = { criteriaId = 26319 },
      },
      item = {
        -- Rattlekilt
        [119370] = { type = 'transmog' },
      },
    },
  },

  -- Pit Slayer
  [39601460] = {
    npcId = 87846,
    questId = 37397,
    icon = 'monster',
    note = t['pit_slayer_note'] .. '\n\n' .. t['missive'],
    requirement = {
      quest = {
        [RequiredQuests['assault on the broken precipice']] = { state = 'active' },
      },
    },
    loot = {
      achievement = {
        -- Broke Back Precipice
        [9571] = { criteriaId = 26320 },
      },
      item = {
        -- Pit-Slayer's Magmastone
        [119370] = { type = 'transmog', subtype = t['ring'] },
      },
    },
  },

  -- Krahl Deadeye
  [42403620] = {
    npcId = 87239,
    questId = 37473,
    icon = 'monster',
    note = t['song_silence_note'],
    loot = {
      achievement = {
        -- The Song of Silence
        [9541] = { criteriaId = 26142 },
      },
    },
  },

  -- Gortag Steelgrip
  [42803620] = {
    npcId = 87344,
    questId = 37472,
    icon = 'monster',
    note = t['song_silence_note'],
    loot = {
      achievement = {
        -- The Song of Silence
        [9541] = { criteriaId = 26143 },
      },
    },
  },

  --- Treasures
  -- Goldtoe's Plunder
  [38305880] = {
    name = t['goldtoes_plunder_title'],
    questId = 36109,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Treasure of Kull'krosh
  [37707060] = {
    name = t['treasure_of_kullkrosh_title'],
    questId = 34760,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Spirit Coffer
  [40406860] = {
    name = t['spirit_coffer_title'],
    questId = 37435,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Adventurer's Pack
  [45605200] = {
    name = t['adventurers_pack_title'],
    questId = 35969,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Fragment of Oshu'gun
  [45806630] = {
    name = t['fragment_of_oshugun_title'],
    questId = 36020,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Fragment of Oshu'gun
        [117981] = { type = 'transmog' },
      },
    },
  },
  -- Void-Infused Crystal
  [50006650] = {
    name = t['void-infused_crystal_title'],
    questId = 35579,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Serrated Void Crystal
        [118264] = { type = 'transmog' },
      },
    },
  },
  -- Adventurer's Pouch
  [53406430] = {
    name = t['adventurers_pouch_title'],
    questId = 36088,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Warsong Helm
  [52404440] = {
    name = t['warsong_helm_title'],
    questId = 36073,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Riverwashed Warsong Helm
        [118250] = { type = 'transmog' },
      },
    },
  },
  -- Golden Kaliri Egg
  [58205260] = {
    name = t['golden_kaliri_egg_title'],
    questId = 35694,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Golden Kaliri Egg
        [118266] = { },
      },
    },
  },
  -- Pokkar's Thirteenth Axe
  [58305940] = {
    name = t['pokkars_thirteenth_axe_title'],
    questId = 36021,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Pokhar's Thirteenth Axe
        [116688] = { type = 'transmog' },
      },
    },
  },
  -- Pale Elixir
  [57806220] = {
    name = t['pale_elixir_title'],
    questId = 36115,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Pale Vision Potion
        [118278] = { },
      },
    },
  },
  -- Lost Pendant
  [61805740] = {
    name = t['lost_pendant_title'],
    questId = 36082,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Oshu'gun Amulet
        [116687] = { subtype = t['neck'] },
      },
    },
  },
  -- Bag of Herbs
  [62506710] = {
    name = t['bag_of_herbs_title'],
    questId = 36116,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Telaar Defender Shield
  [64706580] = {
    name = t['telaar_defender_shield_title'],
    questId = 36046,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Trophy Band of Telaar
        [118253] = { subtype = t['ring'] },
      },
    },
  },
  -- Watertight Bag
  [64703580] = {
    name = t['watertight_bag_title'],
    questId = 36071,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Ogre Diving Cap
        [118235] = { },
      },
    },
  },
  -- Elemental Offering
  [66901950] = {
    name = t['elemental_offering_title'],
    questId = 35954,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Adventurer's Sack
  [73901410] = {
    name = t['adventurers_sack_title'],
    questId = 35955,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Freshwater Clam
  [73102160] = {
    name = t['freshwater_clam_title'],
    questId = 35692,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Elemental Shackles
  [78901550] = {
    name = t['elemental_shackles_title'],
    questId = 36036,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Trophy Gemstone of the Elements
        [118251] = { subtype = t['ring'] },
      },
    },
  },
  -- Adventurer's Staff
  [81501300] = {
    name = t['adventurers_staff_title'],
    questId = 35953,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Howling Staff
        [116640] = { type = 'transmog' },
      },
    },
  },
  -- Bone-Carved Dagger
  [77302820] = {
    name = t['bone-carved_dagger_title'],
    questId = 35986,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Saberon-Fang Shanker
        [116760] = { },
      },
    },
  },
  -- Brilliant Dreampetal
  [81103720] = {
    name = t['brilliant_dreampetal_title'],
    questId = 35661,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Brilliant Dreampetal
        [118262] = { },
      },
    },
  },
  -- Highmaul Sledge
  [67404900] = {
    name = t['highmaul_sledge_title'],
    questId = 36039,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Trophy Loop of the Highmaul
        [118252] = { subtype = t['ring'] },
      },
    },
  },
  -- Abandoned Cargo
  [67605980] = {
    name = t['abandoned_cargo_title'],
    questId = 35759,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Adventurer's Pack
  [69905240] = {
    name = t['adventurers_pack_title'],
    questId = 35597,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Gambler's Purse
  [75404710] = {
    name = t['gamblers_purse_title'],
    questId = 36074,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Counterfeit Coin
        [118236] = { },
      },
    },
  },
  -- Polished Saberon Skull
  [72706100] = {
    name = t['polished_saberon_skull_title'],
    questId = 36035,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Trophy Signet of the Sabermaw
        [118254] = { subtype = t['ring'] },
      },
    },
  },
  -- Adventurer's Mace
  [75806200] = {
    name = t['adventurers_mace_title'],
    questId = 36077,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Warsong Spear
  [76107000] = {
    name = t['warsong_spear_title'],
    questId = 35682,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Adventurer's Pack
  [82305660] = {
    name = t['adventurers_pack_title'],
    questId = 35765,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Ogre Beads
  [81007980] = {
    name = t['ogre_beads_title'],
    questId = 36049,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Trophy Ring of Gordal
        [118255] = { subtype = t['ring'] },
      },
    },
  },
  -- Grizzlemaw's Bonepile
  [87107290] = {
    name = t['grizzlemaws_bonepile_title'],
    questId = 36051,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Discarded Bone
        [118054] = { },
      },
    },
  },
  -- Steamwheedle Supplies
  [77805190] = {
    name = t['steamwheedle_supplies_title'],
    questId = 35591,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Steamwheedle Supplies
  [70601860] = {
    name = t['steamwheedle_supplies_title'],
    questId = 35646,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Steamwheedle Supplies
  [88304260] = {
    name = t['steamwheedle_supplies_title'],
    questId = 35616,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Steamwheedle Supplies
  [87602030] = {
    name = t['steamwheedle_supplies_title'],
    questId = 35662,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Steamwheedle Supplies
  [64601760] = {
    name = t['steamwheedle_supplies_title'],
    questId = 35648,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Steamwheedle Supplies
  [52708010] = {
    name = t['steamwheedle_supplies_title'],
    questId = 35583,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Steamwheedle Supplies
  [50108230] = {
    name = t['steamwheedle_supplies_title'],
    questId = 35577,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Genedar Debris
  [43305760] = {
    name = t['genedar_debris_title'],
    questId = 35987,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Genedar Debris
  [48106010] = {
    name = t['genedar_debris_title'],
    questId = 35999,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Genedar Debris
  [48607280] = {
    name = t['genedar_debris_title'],
    questId = 36008,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Genedar Debris
  [55306830] = {
    name = t['genedar_debris_title'],
    questId = 36011,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Genedar Debris
  [44706760] = {
    name = t['genedar_debris_title'],
    questId = 36002,
    icon = 'chest',
    note = t['genedar_debris_note'],
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Mountain Climber's Pack
  [70501380] = {
    name = t['mountain_climbers_pack_title'],
    questId = 35643,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Warsong Lockbox
  [73007040] = {
    name = t['warsong_lockbox_title'],
    questId = 35678,
    icon = 'chest',
    note = t['warsong_note'],
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Warsong Spoils
  [80606060] = {
    name = t['warsong_spoils_title'],
    questId = 35593,
    icon = 'chest',
    note = t['warsong_note'],
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Hidden Stash
  [87504500] = {
    name = t['hidden_stash_title'],
    questId = 35622,
    icon = 'chest',
    note = t['hidden_stash_note'],
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Fungus-Covered Chest
  [88901820] = {
    name = t['fungus_covered_chest_title'],
    questId = 35660,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Goblin Pack
  [47207430] = {
    name = t['goblin_pack_title'],
    questId = 35576,
    icon = 'chest',
    note = t['goblin_pack_first_note'],
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Goblin Pack
  [73006220] = {
    name = t['goblin_pack_title'],
    questId = 35590,
    icon = 'chest',
    note = t['goblin_pack_second_note'],
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Warsong Cache
  [51706030] = {
    name = t['warsong_cache_title'],
    questId = 35695,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- A Pile of Dirt
  [73101080] = {
    name = t['pile_of_dirt_title'],
    questId = 35951,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Appropriated Warsong Supplies
  [73107550] = {
    name = t['appropriated_warsong_supplies_title'],
    questId = 35673,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Bounty of the Elements
  [77101660] = {
    name = t['bounty_of_the_elements_title'],
    questId = 36174,
    icon = 'chest',
    note = t['in_cave'] .. ' ' .. t['bounty_of_the_elements_note'],
    POI = { 77101740 },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Smuggler's Cache
  [89103310] = {
    name = t['smugglers_cache_title'],
    questId = 36857,
    icon = 'chest',
    note = t['smugglers_cache_note'],
    POI = { 89003250 },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Warsong Supplies
  [89406590] = {
    name = t['warsong_supplies_title'],
    questId = 35976,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Saberon Stash
  [75206500] = {
    name = t['saberon_stash_title'],
    questId = 36102,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Important Exploration Supplies
  [75206560] = {
    name = t['important_exploration_supplies_title'],
    questId = 36099,
    icon = 'chest',
    note = t['in_cave'],
    POI = { 74906590 },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Burning Blade Cache
  [85405340] = {
    name = t['burning_blade_cache_title'],
    questId = 35696,
    icon = 'chest',
    note = t['burning_blade_cache_note'],
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },
  -- Adventurer's Pouch
  [56607290] = {
    name = t['adventurers_pouch_title'],
    questId = 36050,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  --- Pet Battles
  -- Tarr the Terrible
  [56200980] = {
    npcId = 87110,
    icon = 'pet',
    loot = {
      achievement = {
        -- An Awfully Big Adventure
        [9069] = { criteriaId = 27004 },
        -- Taming Draenor
        [9724] = { criteriaId = 27015 },
      },
    },
  },

  --- Achievements
  -- Viking Pepe
  [80105040] = {
    name = t['viking_pepe_title'],
    icon = 'achievement',
    note = t['viking_pepe_note'],
    questId = 39265,
    loot = {
      -- I Found Pepe!
      achievement = {
        [10053] = { criteriaId = 28184 },
      },
      item = {
        -- A Tiny Viking Helmet
        [127865] = { },
      },
    },
  },

  -- Krog the Dominator's Hammer
  [41201020] = {
    npcId = 88082,
    questId = 37250,
    icon = 'achievement',
    POI = {
      37631575, 35501590, 36542032, 36502030, 38201360, 37502040, 36611700, 40722491, 39501670, 36501680, 37801810,
      37831809, 38801644, 35422254, 40701520, 39761449, 38102444, 37592323, 35402270, 37421606, 35002090, 36902430,
    },
    note = t['history_of_violence_note'] .. '\n\n' .. t['missive'],
    requirement = {
      quest = {
        [RequiredQuests['assault on the broken precipice']] = { state = 'active' },
      },
    },
    loot = {
      -- History of Violence
      achievement = {
        [9610] = { criteriaId = 26397 },
      },
    },
  },

  -- Thurg the Slave Lord's Necklace
  [39701020] = {
    npcId = 88092,
    questId = 37252,
    icon = 'achievement',
    POI = {
      37631575, 35501590, 36542032, 36502030, 38201360, 37502040, 36611700, 40722491, 39501670, 36501680, 37801810,
      37831809, 38801644, 35422254, 40701520, 39761449, 38102444, 37592323, 35402270, 37421606, 35002090, 36902430,
    },
    note = t['history_of_violence_note'] .. '\n\n' .. t['missive'],
    requirement = {
      quest = {
        [RequiredQuests['assault on the broken precipice']] = { state = 'active' },
      },
    },
    loot = {
      -- History of Violence
      achievement = {
        [9610] = { criteriaId = 26400 },
      },
    },
  },

  -- Thak the Conqueror's Bust
  [41201220] = {
    npcId = 88085,
    questId = 37251,
    icon = 'achievement',
    note = t['missive'],
    requirement = {
      quest = {
        [RequiredQuests['assault on the broken precipice']] = { state = 'active' },
      },
    },
    loot = {
      -- History of Violence
      achievement = {
        [9610] = { criteriaId = 26399 },
      },
    },
  },

  -- Gorg the Subjugator's Idol
  [42701020] = {
    npcId = 88088,
    questId = 37253,
    icon = 'achievement',
    POI = {
      37631575, 35501590, 36542032, 36502030, 38201360, 37502040, 36611700, 40722491, 39501670, 36501680, 37801810,
      37831809, 38801644, 35422254, 40701520, 39761449, 38102444, 37592323, 35402270, 37421606, 35002090, 36902430,
    },
    note = t['history_of_violence_note'] .. '\n\n' .. t['missive'],
    requirement = {
      quest = {
        [RequiredQuests['assault on the broken precipice']] = { state = 'active' },
      },
    },
    loot = {
      -- History of Violence
      achievement = {
        [9610] = { criteriaId = 26404 },
      },
    },
  },

  -- Warsong Remains
  [43603880] = {
    npcId = 87525,
    questId = 37133,
    icon = 'achievement',
    POI = { 43603880, 42603760, 43203660, 44003420, 45603700, 46203420 },
    note = t['buried_treasures_note'],
    loot = {
      -- Buried Treasures
      achievement = {
        [9548] = { criteriaId = 26147 },
      },
    },
  },

  -- Wolf Pup Remains
  [43203660] = {
    npcId = 87527,
    questId = 37135,
    icon = 'achievement',
    POI = { 43603880, 42603760, 43203660, 44003420, 45603700, 46203420 },
    note = t['buried_treasures_note'],
    loot = {
      -- Buried Treasures
      achievement = {
        [9548] = { criteriaId = 26149 },
      },
    },
  },

  -- Gnarled Bone
  [44003420] = {
    npcId = 87528,
    questId = 37136,
    icon = 'achievement',
    POI = { 43603880, 42603760, 43203660, 44003420, 45603700, 46203420 },
    note = t['buried_treasures_note'],
    loot = {
      -- Buried Treasures
      achievement = {
        [9548] = { criteriaId = 26150 },
      },
    },
  },

  -- Warsong Relics
  [45503680] = {
    npcId = 87524,
    questId = 37132,
    icon = 'achievement',
    POI = { 43003650 },
    loot = {
      -- Buried Treasures
      achievement = {
        [9548] = { criteriaId = 26146 },
      },
    },
  },

  -- Garrosh's Shackles
  [41603740] = {
    npcId = 87522,
    questId = 37130,
    icon = 'achievement',
    loot = {
      -- Buried Treasures
      achievement = {
        [9548] = { criteriaId = 26145 },
      },
    },
  },

  -- Stolen Draenei Tome
  [45303380] = {
    npcId = 87526,
    questId = 37134,
    POI = { 45103820 },
    icon = 'achievement',
    loot = {
      -- Buried Treasures
      achievement = {
        [9548] = { criteriaId = 26148 },
      },
    },
  },
}

this.points[map] = points
