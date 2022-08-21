---
--- @file
--- Map point definitions.
---

local _, this = ...

local Player = this.Player
local t = this.t
local map = this.maps['frostfire_ridge']

-- Alliance quest IDs for required quests.
local RequiredQuests = {
  -- Assault on Stonefury Cliffs
  ['assault on stonefury cliffs'] = 36648,
}

-- Horde quest IDs.
if (Player:isHorde() == true) then
  RequiredQuests = {
    -- Assault on Stonefury Cliffs
    ['assault on stonefury cliffs'] = 36669,
  }
end

-- Define NPCs we are going to use in multiple points.
local Gorok = {
  npcId = 50992,
  icon = 'monster',
  note = t['multiple_spawn_note'],
  loot = {
    item = {
      -- Great Greytusk
      [116674] = { mountId = 627 },
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
  [63407940] = Gorok,
  [22806640] = Gorok,
  [64805300] = Gorok,
  [51805060] = Gorok,
  [58001840] = Gorok,
  [51101986] = Voidtalon,
  [52401818] = Voidtalon,
  [53801732] = Voidtalon,
  [48002740] = Voidtalon,

  -- Nok-Karosh
  [13205060] = {
    npcId = 81001,
    icon = 'monster',
    loot = {
      item = {
        -- Garn Nighthowl
        [116794] = { mountId = 657 },
      },
    },
  },

  -- Giant-Slayer Kul
  [54602220] = {
    npcId = 71665,
    questId = 32918,
    icon = 'monster',
    loot = {
      item = {
        -- Giantstalker's Guile
        [111530] = { subtype = t['trinket'] },
      },
    },
  },

  -- Canyon Icemother
  [34002320] = {
    npcId = 71721,
    questId = 32941,
    icon = 'monster',
    loot = {
      item = {
        -- Icemother Milk
        [101436] = { },
      },
    },
  },

  -- Cindermaw
  [40404700] = {
    npcId = 72294,
    questId = 33014,
    icon = 'monster',
    loot = {
      item = {
        -- Cindermaw's Blazing Talon
        [111490] = { type = 'transmog' },
      },
    },
  },

  -- Broodmother Reeg'ak
  [66403140] = {
    npcId = 74613,
    questId = 33843,
    icon = 'monster',
    note = t['in_cave'],
    POI = { 64003260 },
    loot = {
      item = {
        -- Corrosive Tongue of Reeg'ak
        [111533] = { subtype = t['trinket'] },
      },
    },
  },

  -- Firefury Giant
  [71404680] = {
    npcId = 74971,
    questId = 33504,
    icon = 'monster',
    note = t['frostfury_giant_note'],
    loot = {
      item = {
        -- Smoldering Lavacore Orb
        [107661] = { type = 'transmog', subtype = t['off-hand'] },
      },
    },
  },

  -- Coldtusk
  [54606940] = {
    npcId = 76914,
    questId = 34131,
    icon = 'monster',
    loot = {
      item = {
        -- Cold Tusk
        [111484] = { type = 'transmog' },
      },
    },
  },

  -- Primalist Mur'og
  [36803400] = {
    npcId = 76918,
    questId = 33938,
    icon = 'monster',
    loot = {
      item = {
        -- Ritual Leggings of Mur'og
        [111576] = { type = 'transmog' },
      },
    },
  },

  -- Coldstomp the Griever
  [25405500] = {
    npcId = 77513,
    questId = 34129,
    icon = 'monster',
    loot = {
      item = {
        -- Coldstomp's Sorrow
        [112066] = { subtype = t['neck'] },
      },
    },
  },

  -- Scout Goreseeker
  [76406340] = {
    npcId = 77526,
    questId = 34132,
    icon = 'monster',
    loot = {
      item = {
        -- Goreseeker's Goresplattered Garb
        [112094] = { type = 'transmog' },
      },
    },
  },

  -- The Beater
  [26803160] = {
    npcId = 77527,
    questId = 34133,
    icon = 'monster',
    note = t['in_cave'],
    POI = { 27203070 },
    loot = {
      item = {
        -- Beater's Beat Stick
        [111475] = { type = 'transmog' },
      },
    },
  },

  -- Huntmaster Kuang
  [58603420] = {
    npcId = 78151,
    questId = 34130,
    icon = 'monster',
  },

  -- The Bone Crawler
  [72203300] = {
    npcId = 78265,
    questId = 34361,
    icon = 'monster',
    loot = {
      item = {
        -- The Bone Crawler's Carapace
        [111534] = { type = 'transmog' },
      },
    },
  },

  -- Pale Fishmonger
  [28206660] = {
    npcId = 78606,
    questId = 34470,
    icon = 'monster',
    note = t['in_cave'],
    POI = { 27806590 },
    loot = {
      item = {
        -- Fire Ammonite
        [111666] = { },
      },
    },
  },

  -- Cyclonic Fury
  [67407820] = {
    npcId = 78621,
    questId = 34477,
    icon = 'monster',
    loot = {
      item = {
        -- Windburnt Pauldrons
        [112086] = { type = 'transmog' },
      },
    },
  },

  -- Breathless
  [27405000] = {
    npcId = 78867,
    questId = 34497,
    icon = 'monster',
    loot = {
      item = {
        -- Stolen Breath
        [111476] = { type = 'toy' },
      },
    },
  },

  -- Ug'lok the Frozen
  [40601240] = {
    npcId = 79104,
    questId = 34522,
    icon = 'monster',
  },

  -- Yaga the Scarred
  [40402780] = {
    npcId = 79145,
    questId = 34559,
    icon = 'monster',
    loot = {
      item = {
        -- Yaga's Trophy Belt
        [111477] = { type = 'transmog' },
      },
    },
  },

  -- Gruuk
  [50305260] = {
    npcId = 80190,
    questId = 34825,
    icon = 'monster',
    loot = {
      item = {
        -- Gruuk's Evil Eye
        [111948] = { subtype = t['trinket'] },
      },
    },
  },

  -- Gurun
  [47005520] = {
    npcId = 80235,
    questId = 34839,
    icon = 'monster',
    note = t['in_cave'],
    POI = { 46305750 },
    loot = {
      item = {
        -- Skog's Drape
        [111955] = { type = 'transmog', subtype = t['cloak'] },
      },
    },
  },

  -- Chillfang
  [41206820] = {
    npcId = 80242,
    questId = 34843,
    icon = 'monster',
    note = t['in_cave'],
    POI = { 40806760 },
    loot = {
      item = {
        -- Bat-Leather Breeches
        [111953] = { type = 'transmog' },
      },
    },
  },

  -- Grutush the Pillager
  [38606300] = {
    npcId = 80312,
    questId = 34865,
    icon = 'monster',
    note = t['in_cave'],
    POI = { 38206350 },
    loot = {
      item = {
        -- Grutush's Fur-Padded Pantaloons
        [112077] = { type = 'transmog' },
      },
    },
  },

  -- Jabberjaw
  [48202340] = {
    npcId = 82616,
    questId = 37386,
    icon = 'monster',
    loot = {
      item = {
        -- Rockworm Carapace Shield
        [119390] = { type = 'transmog' },
      },
    },
  },

  -- Tor'goroth
  [43600940] = {
    npcId = 82618,
    questId = 37384,
    icon = 'monster',
    loot = {
      item = {
        -- Tor'goroth's Soul Prism
        [119379] = { type = 'transmog', subtype = t['off-hand'] },
        -- Soul Inhaler
        [119163] = { type = 'toy' },
      },
    },
  },

  -- Son of Goramal
  [38201600] = {
    npcId = 82620,
    questId = 37383,
    icon = 'monster',
    loot = {
      item = {
        -- Cudgel of the Son of Goramal
        [119399] = { type = 'transmog' },
      },
    },
  },

  -- Kaga the Ironbender
  [86804500] = {
    npcId = 84374,
    questId = 37404,
    icon = 'monster',
    loot = {
      item = {
        -- Ironstudded Scale Girdle
        [119372] = { type = 'transmog' },
      },
    },
  },

  -- Ak'ox the Slaughterer
  [88605740] = {
    npcId = 84378,
    questId = 37525,
    icon = 'monster',
    loot = {
      item = {
        -- Bloodied Tourniquet Belt
        [119365] = { type = 'transmog' },
      },
    },
  },

  -- Ragore Driftstalker
  [86604880] = {
    npcId = 84392,
    questId = 37401,
    icon = 'monster',
    note = t['in_cave'],
    POI = { 87104950 },
    loot = {
      item = {
        -- Tunic of the Driftstalker
        [119359] = { type = 'transmog' },
      },
    },
  },

  -- Hoarfrost
  [68801940] = {
    npcId = 87348,
    questId = 37382,
    icon = 'monster',
    loot = {
      item = {
        -- Frosted Icequartz Ring
        [119415] = { subtype = t['ring'] },
      },
    },
  },

  -- Vrok the Ancient
  [70603900] = {
    npcId = 87356,
    questId = 37379,
    icon = 'monster',
    loot = {
      item = {
        -- Magnaron Heart
        [119416] = { },
      },
    },
  },

  -- Valkor
  [72402420] = {
    npcId = 87357,
    questId = 37378,
    icon = 'monster',
    path = { 72402420, 72802500, 72402620, 72002800, 70402940, 69802980, 69002960, 68802880, 69802540, 70402440, 72402420 },
    loot = {
      item = {
        -- Magnaron Heart
        [119416] = { },
      },
    },
  },

  -- Jaluk the Pacifist
  [85005220] = {
    npcId = 87600,
    questId = 37556,
    icon = 'monster',
  },

  -- Ogom the Mangler
  [83604720] = {
    npcId = 87622,
    questId = 37402,
    icon = 'monster',
    loot = {
      item = {
        -- Ogom's Manacles
        [119366] = { type = 'transmog' },
      },
    },
  },

  -- Gorg'ak the Lava Guzzler
  [71002740] = {
    npcId = 72364,
    questId = 33512,
    icon = 'monster',
    loot = {
      item = {
        -- Smoldering Fist of Gorg'ak
        [111545] = { type = 'transmog' },
      },
    },
  },

  -- Gorivax
  [38001400] = {
    npcId = 82536,
    questId = 37388,
    icon = 'monster',
    note =  t['missive'],
    requirement = {
      quest = {
        [RequiredQuests['assault on stonefury cliffs']] = { state = 'active' },
      },
    },
    loot = {
      item = {
        -- Voidmesh Cloth Wristwraps
        [119358] = { type = 'transmog' },
      },
    },
  },

  -- Jehil the Climber
  [61602660] = {
    npcId = 79678,
    questId = 34708,
    icon = 'monster',
    loot = {
      item = {
        -- Jehil's Climbin' Boots
        [112078] = { type = 'transmog' },
      },
    },
  },

  -- Moltnoma
  [42602160] = {
    npcId = 82614,
    questId = 37387,
    icon = 'monster',
    loot = {
      item = {
        -- Moltonoma's Magma Mantle
        [119356] = { type = 'transmog' },
      },
    },
  },

  -- Mother of Goren
  [72602260] = {
    npcId = 87351,
    questId = 37381,
    icon = 'monster',
    loot = {
      item = {
        -- Three-Egg Pendant Necklace
        [119376] = { subtype = t['neck'] },
      },
    },
  },

  -- Slogtusk the Corpse-Eater
  [44601520] = {
    npcId = 82617,
    questId = 37385,
    icon = 'monster',
    note = t['in_cave'],
    POI = { 45701420 },
    loot = {
      item = {
        -- Frostboar Leather Helmet
        [119362] = { type = 'transmog' },
      },
    },
  },

  -- Earthshaker Holar
  [84204660] = {
    npcId = 84376,
    questId = 37403,
    icon = 'monster',
    loot = {
      item = {
        -- Gold Ogron Earring
        [119374] = { subtype = t['neck'] },
      },
    },
  },

  -- Gibblette the Cowardly
  [66602540] = {
    npcId = 87352,
    questId = 37380,
    icon = 'monster',
    loot = {
      item = {
        -- Craven Coward's Cloak
        [119349] = { type = 'transmog', subtype = t['cloak'] },
        -- Goren "Log" Roller
        [119180] = { type = 'toy' },
      }, }, },

  -- Borrok the Devourer
  [62604220] = {
    npcId = 72156,
    questId = nil,
    icon = 'monster',
    note = t['borrok_devourer_note'],
    loot = {
      item = {
        -- Carapace Shield of the Devourer
        [112110] = { type = 'transmog' },
      },
    },
  },

  --- Pet Battles
  -- Gargra
  [68606460] = {
    npcId = 87122,
    icon = 'pet',
    loot = {
      achievement = {
        -- An Awfully Big Adventure
        [9069] = { criteriaId = 26982 },
        -- Taming Draenor
        [9724] = { criteriaId = 27013 },
      },
    },
  },

  --- Achievements
  -- Breaker of Chains
  [40501670] = {
    name = t['breaker_of_chains_title'],
    icon = 'achievement',
    POI = { 43402160, 43202000, 41002120, 40402120, 40801960, 37801860, 37801840, 40001360 },
    note = t['breaker_of_chains_note'] .. '\n\n' .. t['missive'],
    loot = {
      -- Breaker of Chains
      achievement = {
        [9533] = { count = true },
      },
    },
  },
}

this.points[map] = points
