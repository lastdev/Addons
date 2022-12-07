---
--- @file
--- Map point definitions.
---

local _, this = ...

local Player = this.Player
local t = this.t
local map = this.maps['shadowmoon_valley']
local subMap = this.maps['bloodthorn_cave']

-- Alliance quest IDs for required quests.
local RequiredQuests = {
  -- Assault on Socrethar's Rise
  ['assault on socrethars rise'] = 36680,
  -- Assault on Darktide Roost
  ['assault on darktide roost'] = 36679,
}

-- Horde quest IDs.
if (Player:isHorde() == true) then
  RequiredQuests = {
    -- Assault on Socrethar's Rise
    ['assault on socrethars rise'] = 36691,
    -- Assault on Darktide Roost
    ['assault on darktide roost'] = 36692,
  }
end

-- Define NPCs we are going to use in multiple points.
local Pathrunner = {
  npcId = 50883,
  icon = 'monster',
  note = t['multiple_spawn_note'],
  loot = {
    item = {
      -- Swift Breezestrider
      [116773] = { mountId = 636 },
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
  [39603660] = Pathrunner,
  [43003220] = Pathrunner,
  [44604380] = Pathrunner,
  [45806820] = Pathrunner,
  [54003040] = Pathrunner,
  [56205240] = Pathrunner,
  [41907567] = Voidtalon,
  [43627138] = Voidtalon,
  [48787017] = Voidtalon,
  [50337153] = Voidtalon,
  [51687490] = Voidtalon,
  [46647018] = Voidtalon,

  -- Ku'targ the Voidseer
  [32203500] = {
    npcId = 72362,
    questId = 33039,
    icon = 'monster',
    loot = {
      item = {
        -- Ku'targ's Merciless Grips
        [109061] = { type = 'transmog' },
      },
    },
  },

  -- Leaf-Reader Kurri
  [37601460] = {
    npcId = 72537,
    questId = 33055,
    icon = 'monster',
    loot = {
      item = {
        -- Mushroom of Destiny
        [108907] = { subtype = t['trinket'] },
      },
    },
  },

  -- Gorum
  [21603310] = {
    npcId = 76380,
    questId = 33664,
    icon = 'monster',
    POI = { 24103310 },
    note = t['in_cave'],
    loot = {
      item = {
        -- Precious Bloodthorn Loop
        [113082] = { subtype = t['ring'] },
      },
    },
  },

  -- Mother Om'ra
  [44005760] = {
    npcId = 75071,
    questId = 33642,
    icon = 'monster',
    loot = {
      item = {
        -- Legacy of Om'ra
        [113527] = { subtype = t['trinket'] },
        -- Shadowberry
        [119449] = { },
      },
    },
  },

  -- Enavra
  [67806380] = {
    npcId = 82676,
    questId = 35688,
    icon = 'monster',
    loot = {
      item = {
        -- Varandi Family Crest
        [113556] = { subtype = t['neck'] },
      },
    },
  },

  -- Yggdrel
  [48806640] = {
    npcId = 75435,
    questId = 33389,
    icon = 'monster',
    loot = {
      item = {
        -- Ancient's Bloom
        [113570] = { type = 'toy' },
      },
    },
  },

  -- Veloss
  [21602100] = {
    npcId = 75482,
    questId = 33640,
    icon = 'monster',
    loot = {
      item = {
        -- Sporebat Larval Pod
        [108906] = { subtype = t['ring'] },
      },
    },
  },

  -- Dark Emanation
  [48604360] = {
    npcId = 77085,
    questId = 33064,
    icon = 'monster',
    POI = { 50004620, 46504530 },
    note = t['in_cave'],
    loot = {
      item = {
        -- Abberant's Paw
        [109075] = { type = 'transmog' },
      },
    },
  },

  -- Amaukwa
  [37203640] = {
    npcId = 77140,
    questId = 33061,
    icon = 'monster',
    path = { 37203640, 35403500, 33603380, 31003220, 29603220, 29402980, 30002960, 31402840, 32602800, 34202800,
             35202900, 37602960, 41203080, 41603180, 41603280, 41003640, 38803660, 38203660, 37203640 },
    loot = {
      item = {
        -- Rylak-Scale Vest
        [109060] = { type = 'transmog' },
      },
    },
  },

  -- Mad "King" Sporeon
  [44802080] = {
    npcId = 77310,
    questId = 35906,
    icon = 'monster',
    POI = { 44502110 },
    note = t['in_cave'],
    loot = {
      item = {
        -- Staff of the Mad Bramble King
        [113561] = { type = 'transmog' },
      },
    },
  },

  -- Hypnocroak
  [37404880] = {
    npcId = 79524,
    questId = 35558,
    icon = 'monster',
    loot = {
      item = {
        -- Hypnosis Goggles
        [113631] = { type = 'toy' },
      },
    },
  },

  -- Bahameye
  [29600620] = {
    npcId = 81406,
    questId = 35281,
    icon = 'monster',
    loot = {
      item = {
        -- Fire Ammonite
        [111666] = { },
      },
    },
  },

  -- Brambleking Fili
  [43807740] = {
    npcId = 81639,
    questId = 33383,
    icon = 'monster',
    loot = {
      item = {
        -- Staff of the One True Bramble King
        [117551] = { type = 'transmog' },
      },
    },
  },

  -- Faebright
  [61606180] = {
    npcId = 82207,
    questId = 35725,
    icon = 'monster',
    loot = {
      item = {
        -- Dragonrider's Tinkered Leggings
        [113557] = { type = 'transmog' },
      },
    },
  },

  -- Darkmaster Go'vid
  [41008300] = {
    npcId = 82268,
    questId = 35448,
    icon = 'monster',
    path = { 41008300, 40008320, 39008380, 38408360, 39208040, 41608220, 42608380, 41408280, 41008030 },
    loot = {
      item = {
        -- Darktide Summoner Staff
        [113548] = { type = 'transmog' },
      },
    },
  },

  -- Ba'ruun
  [52801680] = {
    npcId = 82326,
    questId = 35731,
    icon = 'monster',
    loot = {
      item = {
        -- Ba'ruun's Bountiful Bloom
        [113540] = { type = 'toy' },
      },
    },
  },

  -- Morva Soultwister
  [38607020] = {
    npcId = 82362,
    questId = 35523,
    icon = 'monster',
    loot = {
      item = {
        -- Void Prophecy Cudgel
        [113559] = { type = 'transmog' },
      },
    },
  },

  -- Rai'vosh
  [48602260] = {
    npcId = 82374,
    questId = 35553,
    icon = 'monster',
    loot = {
      item = {
        -- Whispers of Rai'Vosh
        [113542] = { type = 'toy' },
      },
    },
  },

  -- Darktalon
  [49604200] = {
    npcId = 82411,
    questId = 35555,
    icon = 'monster',
    loot = {
      item = {
        -- Darktalon's Drape
        [113541] = { type = 'transmog', subtype = t['cloak'] },
      },
    },
  },

  -- Insha'tar
  [57404840] = {
    npcId = 83553,
    questId = 35909,
    icon = 'monster',
    loot = {
      item = {
        -- Boots of the Shadowborn
        [113571] = { type = 'transmog' },
      },
    },
  },

  -- Demidos
  [46007160] = {
    npcId = 84911,
    questId = 37351,
    icon = 'monster',
    loot = {
      achievement = {
        -- A Demidos of Reality
        [9437] = { },
      },
      item = {
        -- Void-Touched Diamond Necklace
        [119377] = { subtype = t['neck'] },
        -- Servant of Demidos
        [119431] = { petId = 1601 },
      },
    },
  },

  -- Quartermaster Hershak
  [50207240] = {
    npcId = 84925,
    questId = 37352,
    icon = 'monster',
    loot = {
      item = {
        -- Hershak's Heavy Legguards
        [119382] = { type = 'transmog' },
      },
    },
  },

  -- Master Sergeant Milgra
  [51807920] = {
    npcId = 85001,
    questId = 37353,
    icon = 'monster',
    loot = {
      item = {
        -- Milgra's Mighty Mitts
        [119368] = { type = 'transmog' },
      },
    },
  },

  -- Avalanche
  [68208480] = {
    npcId = 85568,
    questId = 37410,
    icon = 'monster',
    POI = { 66808700 },
    note = t['in_cave'],
    loot = {
      item = {
        -- Rugged Crystal Cudgel
        [119400] = { type = 'transmog' },
      },
    },
  },

  -- Sneevel
  [27604360] = {
    npcId = 86689,
    questId = 36880,
    icon = 'monster',
    loot = {
      item = {
        -- Sneevel's Loincloth
        [118734] = { type = 'transmog' },
      },
    },
  },

  -- Killmaw
  [40804440] = {
    npcId = 74206,
    questId = 33043,
    icon = 'monster',
    loot = {
      item = {
        -- Killmaw's Canine
        [109078] = { type = 'transmog' },
      },
    },
  },

  -- Rockhoof
  [53005060] = {
    npcId = 72606,
    questId = 34068,
    icon = 'monster',
    loot = {
      item = {
        -- Rockhoof's Crest
        [109077] = { type = 'transmog' },
      },
    },
  },

  -- Venomshade
  [54607060] = {
    npcId = 75492,
    questId = 33643,
    icon = 'monster',
    loot = {
      item = {
        -- Venomshade Skin Boots
        [108957] = { type = 'transmog' },
      },
    },
  },

  -- Nagidna
  [58408680] = {
    npcId = 85555,
    questId = 37409,
    icon = 'monster',
    POI = { 59008900 },
    note = t['in_cave'],
    loot = {
      item = {
        -- Hydraskin Shoulderguards
        [119364] = { type = 'transmog' },
      },
    },
  },

  -- Slivermaw
  [61408880] = {
    npcId = 85837,
    questId = 37411,
    icon = 'monster',
    POI = { 60908690 },
    note = t['in_cave'],
    loot = {
      item = {
        -- Massive Rockworm Fang
        [119411] = { type = 'transmog' },
      },
    },
  },

  -- Malgosh Shadowkeeper
  [29605080] = {
    npcId = 85451,
    questId = 37357,
    icon = 'monster',
    POI = { 29205290 },
    note = t['in_cave'] .. '\n\n' .. t['malgosh_shadowkeeper_note'],
    loot = {
      item = {
        -- Malgosh's Coif
        [119369] = { type = 'transmog' },
      },
    },
  },

  -- Voidreaver Urnae
  [31905720] = {
    npcId = 85078,
    questId = 37359,
    icon = 'monster',
    loot = {
      item = {
        -- Voidreaver's Axe
        [119392] = { type = 'transmog' },
      },
    },
  },

  -- Aqualir
  [50807880] = {
    npcId = 86213,
    questId = 37356,
    icon = 'monster',
    note = t['aqualir_note'],
    loot = {
      item = {
        -- Loop of Drowned Souls
        [119387] = { subtype = t['ring'] },
      },
    },
  },

  -- Voidseer Kalurg
  [32604140] = {
    npcId = 83385,
    questId = 35847,
    icon = 'monster',
    note = t['voidseer_kalurg_note'],
    loot = {
      item = {
        -- Fine Void-Chain Cinch
        [109074] = { type = 'transmog' },
      },
    },
  },

  -- Shinri
  [61005520] = {
    npcId = 82415,
    questId = 35732,
    icon = 'monster',
    path = { 61005520, 61605260, 61805100, 60405140, 61605000, 63205100, 63605760, 62805800, 61605760, 59805860,
             59205780, 59205600, 60805480, 61005520 },
    loot = {
      item = {
        -- Spirit of Shinri
        [113543] = { type = 'toy' },
      },
    },
  },

  -- Windfang Matriarch
  [42804100] = {
    npcId = 75434,
    questId = 33038,
    icon = 'monster',
    note = t['windfang_matriarch_note'],
    requirement = {
      faction = 'Alliance',
    },
    loot = {
      item = {
        -- Windfang Sabre
        [113553] = { type = 'transmog' },
      },
    },
  },

  -- Lady Temptessa
  [48107760] = {
    npcId = 85121,
    questId = 37355,
    icon = 'monster',
    loot = {
      item = {
        -- Temptessa's Knee-High Boots
        [119360] = { type = 'transmog' },
      },
    },
  },

  -- Shadowspeaker Niir
  [48208100] = {
    npcId = 85029,
    questId = 37354,
    icon = 'monster',
    loot = {
      item = {
        -- Shadowspeaker's Shard
        [119396] = { type = 'transmog' },
      },
    },
  },

  --- Pet Battles
  -- Ashlei
  [50003120] = {
    npcId = 87124,
    icon = 'pet',
    loot = {
      achievement = {
        -- An Awfully Big Adventure
        [9069] = { criteriaId = 26969 },
        -- Taming Draenor
        [9724] = { criteriaId = 27012 },
      },
    },
  },

  --- Achievements
  -- It's the Stones!
  [47007600] = {
    name = t['its_the_stones_title'],
    icon = 'achievement',
    POI = { 46467162, 49557166, 47007800, 52017633, 44808250, 52638045 },
    note = t['missive'],
    requirement = {
      quest = {
        [RequiredQuests['assault on socrethars rise']] = { state = 'active' },
      },
    },
    loot = {
      -- It's the Stones!
      achievement = {
        [9436] = { count = true },
      },
    },
  },

  -- Take From Them Everything
  [48607430] = {
    name = t['take_from_them_everything_title'],
    icon = 'achievement',
    note = t['take_from_them_everything_note'] .. '\n\n' .. t['missive'],
    requirement = {
      quest = {
        [RequiredQuests['assault on socrethars rise']] = { state = 'active' },
      },
    },
    loot = {
      -- Take From Them Everything
      achievement = {
        [9435] = { },
      },
    },
  },

  -- You Have Been Rylakinated!
  [60008440] = {
    name = t['you_have_been_rylakinated_title'],
    icon = 'achievement',
    path = { 56408880, 58408460, 60008440, 60008200, 61008180, 62208460, 64008660, 63408780, 63809020 },
    note = t['you_have_been_rylakinated_note'] .. '\n\n' .. t['missive'],
    requirement = {
      quest = {
        [34355] = { },
        [RequiredQuests['assault on darktide roost']] = { state = 'active' },
      },
    },
    loot = {
      -- You Have Been Rylakinated!
      achievement = {
        [9481] = { },
      },
    },
  },
}

-- This is minimap (mini dungeon) in Shadowmoon Valley.
local subPoints = {
  -- Gorum
  [31103460] = {
    npcId = 76380,
    questId = 33664,
    icon = 'monster',
    loot = {
      item = {
        -- Precious Bloodthorn Loop
        [113082] = { subtype = t['ring'] },
      },
    },
  },
}

this.points[map] = points
this.points[subMap] = subPoints
