---
--- @file
--- Map point definitions.
---

local _, this = ...

local Player = this.Player
local t = this.t
local map = this.maps['talador']
local subMap = this.maps['tomb_of_souls']

-- Alliance quest IDs for required quests.
local RequiredQuests = {
  -- Assault on Shattrath Harbor
  ['assault on shattrath harbor'] = 36649,
  -- Assault on the Heart of Shattrath
  ['assault on the heart of shattrath'] = 36685,
}

-- Horde quest IDs.
if (Player:isHorde() == true) then
  RequiredQuests = {
    -- Assault on Shattrath Harbor
    ['assault on shattrath harbor'] = 36667,
    -- Assault on the Heart of Shattrath
    ['assault on the heart of shattrath'] = 36699,
  }
end

-- Define NPCs we are going to use in multiple points.
local Silthide = {
  npcId = 51015,
  icon = 'monster',
  note = t['multiple_spawn_note'],
  loot = {
    item = {
      -- Sapphire Riverbeast
      [116767] = { mountId = 630 },
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
  [78905540] = Silthide,
  [67406000] = Silthide,
  [61803220] = Silthide,
  [62004500] = Silthide,
  [55608060] = Silthide,
  [39885561] = Voidtalon,
  [46265256] = Voidtalon,
  [47164882] = Voidtalon,
  [52144113] = Voidtalon,
  [52252587] = Voidtalon,
  [52683437] = Voidtalon,
  [50963241] = Voidtalon,

  -- Yazheera the Incinerator
  [53802580] = {
    npcId = 77529,
    questId = 34135,
    icon = 'monster',
    loot = {
      item = {
        -- Yazheera's Burning Bracers
        [112263] = { type = 'transmog' },
      },
    },
  },

  -- Frenzied Golem
  [46205500] = {
    npcId = 77614,
    questId = 34145,
    icon = 'monster',
    loot = {
      item = {
        -- Shard of Contempt
        [113288] = { type = 'transmog' },
        -- Shard of Scorn
        [113287] = { type = 'transmog' },
      },
    },
  },

  -- Cro Fleshrender
  [37607040] = {
    npcId = 77620,
    questId = 34165,
    icon = 'monster',
    loot = {
      item = {
        -- Fleshrender's Painbringer
        [116123] = { type = 'transmog' },
      },
    },
  },

  -- Hen-Mother Hami
  [75405080] = {
    npcId = 77626,
    questId = 34167,
    icon = 'monster',
    path = { 75405080, 76705070, 77005260, 78005100 },
    loot = {
      item = {
        -- Hami-Down Cloak
        [112369] = { type = 'transmog', subtype = t['cloak'] },
      },
    },
  },

  -- Hammertooth
  [61404920] = {
    npcId = 77715,
    questId = 34185,
    icon = 'monster',
    path = { 61404920, 60604800, 61304650, 62704480, 63904330, 65304330,
             65304550, 64004530, 63104590, 62304730, 61404920 },
    loot = {
      item = {
        -- Scaled Riverbeast Vest
        [116124] = { type = 'transmog' },
      },
    },
  },

  -- Glimmerwing
  [30406500] = {
    npcId = 77719,
    questId = 34189,
    icon = 'monster',
    path = { 30406500, 31206350, 32306220, 33106330, 33006460, 32706600, 31306580, 30406500 },
    loot = {
      item = {
        -- Breath of Talador
        [116113] = { type = 'toy' },
      },
    },
  },

  -- Ra'kahn
  [59405960] = {
    npcId = 77741,
    questId = 34196,
    icon = 'monster',
    note = t['in_cave'],
    POI = { 60305730 },
    loot = {
      item = {
        -- Ra'kahn's Bite
        [116112] = { type = 'transmog' },
      },
    },
  },

  -- Wandering Vindicator
  [69603360] = {
    npcId = 77776,
    questId = 34205,
    icon = 'monster',
    note = t['wandering_vindicator_note'],
    loot = {
      item = {
        -- Forgotten Vindicator's Blade
        [112261] = { type = 'transmog' },
      },
    },
  },

  -- Lo'marg Jawcrusher
  [49009200] = {
    npcId = 77784,
    questId = 34208,
    icon = 'monster',
    loot = {
      item = {
        -- Tezzakel's Terrible Talisman
        [116070] = { subtype = t['neck'] },
      },
    },
  },

  -- Echo of Murmur
  [34005720] = {
    npcId = 77828,
    questId = 34221,
    icon = 'monster',
    loot = {
      item = {
        -- Mournful Moan of Murmur
        [113670] = { type = 'toy' },
      },
    },
  },

  -- Klikixx
  [66808560] = {
    npcId = 78872,
    questId = 34498,
    icon = 'monster',
    note = t['in_cave'],
    POI = { 61308410 },
    loot = {
      item = {
        -- Klikixx's Webspinner
        [116125] = { type = 'toy' },
      },
    },
  },

  -- No'losh
  [86002960] = {
    npcId = 79334,
    questId = 34859,
    icon = 'monster',
    loot = {
      item = {
        -- Pulsating Brain of No'losh
        [116077] = { subtype = t['trinket'] },
      },
    },
  },

  -- Kurlosh Doomfang
  [37603760] = {
    npcId = 82988,
    questId = 37348,
    icon = 'monster',
    loot = {
      achievement = {
        -- Heralds of the Legion
        [9638] = { criteriaId = 26480 },
      },
      item = {
        -- Kurlosh's Kidneyslicer
        [119394] = { type = 'transmog' },
      },
    },
  },

  -- Lady Demlash
  [33603780] = {
    npcId = 82942,
    questId = 37346,
    icon = 'monster',
    loot = {
      achievement = {
        -- Heralds of the Legion
        [9638] = { criteriaId = 26478 },
      },
      item = {
        -- Demlash's Dashing Robe
        [119352] = { type = 'transmog' },
      },
    },
  },

  -- Talonpriest Zorkra
  [53809100] = {
    npcId = 79485,
    questId = 34668,
    icon = 'monster',
    loot = {
      item = {
        -- Zorkra's Hood
        [116110] = { type = 'transmog' },
      },
    },
  },

  -- Felbark
  [50208620] = {
    npcId = 80204,
    questId = 35018,
    icon = 'monster',
    path = { 50208620, 49408570, 49308440, 49108310, 50408310, 51208360, 51708430, 50908570, 50208620 },
    loot = {
      item = {
        -- Felbark's Shin
        [112373] = { type = 'transmog' },
      },
    },
  },

  -- Gennadian
  [67408060] = {
    npcId = 80471,
    questId = 34929,
    icon = 'monster',
    loot = {
      item = {
        -- Scales of Gennadian
        [116075] = { subtype = t['trinket'] },
      },
    },
  },

  -- Underseer Bloodmane
  [63602080] = {
    npcId = 80524,
    questId = 34945,
    icon = 'monster',
    loot = {
      item = {
        -- Prize's Horn-Ring
        [112475] = { subtype = t['ring'] },
      },
    },
  },

  -- Xothear, the Destroyer
  [37601460] = {
    npcId = 82922,
    questId = 37343,
    icon = 'monster',
    loot = {
      achievement = {
        -- Cut off the Head
        [9633] = { criteriaId = 26580 },
      },
      item = {
        -- Mantle of the Destroyer
        [119371] = { type = 'transmog' },
      },
    },
  },

  -- Felfire Consort
  [47603280] = {
    npcId = 82992,
    questId = 37341,
    icon = 'monster',
    loot = {
      achievement = {
        -- Cut off the Head
        [9633] = { criteriaId = 26468 },
      },
      item = {
        -- Consort's Promise Ring
        [119386] = { subtype = t['ring'] },
      },
    },
  },

  -- Matron of Sin
  [38804960] = {
    npcId = 82998,
    questId = 37349,
    icon = 'monster',
    loot = {
      achievement = {
        -- Heralds of the Legion
        [9638] = { criteriaId = 26481 },
      },
      item = {
        -- Matron's Supple Gloves
        [119353] = { type = 'transmog' },
      },
    },
  },

  -- Haakun the All-Consuming
  [48002520] = {
    npcId = 83008,
    questId = 37312,
    icon = 'monster',
    loot = {
      achievement = {
        -- Cut off the Head
        [9633] = { criteriaId = 26467 },
      },
      item = {
        -- Sargerei Soulbiter
        [119403] = { type = 'transmog' },
      },
    },
  },

  -- Gug'tol
  [47603900] = {
    npcId = 83019,
    questId = 37340,
    icon = 'monster',
    loot = {
      achievement = {
        -- Cut off the Head
        [9633] = { criteriaId = 26466 },
      },
      item = {
        -- Gug'tol's Imp Imperator
        [119402] = { type = 'transmog' },
      },
    },
  },

  -- Grrbrrgle
  [22207420] = {
    npcId = 85572,
    questId = 36919,
    icon = 'monster',
    loot = {
      item = {
        -- Mrglrgirdle
        [120436] = { type = 'transmog' },
      },
    },
  },

  -- Steeltusk
  [68003500] = {
    npcId = 86549,
    questId = 36858,
    icon = 'monster',
    loot = {
      item = {
        -- Steeltusk's Steel Tusk
        [117562] = { type = 'transmog' },
      },
    },
  },

  -- Avatar of Socrethar
  [46203140] = {
    npcId = 88043,
    questId = 37338,
    icon = 'monster',
    path = { 46203140, 45803420, 45003470, 45403660, 46203550, 48003510, 48303370 },
    loot = {
      achievement = {
        -- Cut off the Head
        [9633] = { criteriaId = 26469 },
      },
      item = {
        -- Socrethar's Stone
        [119378] = { type = 'transmog', subtype = t['off-hand'] },
      },
    },
  },

  -- Legion Vanguard
  [38002060] = {
    npcId = 88494,
    questId = 37342,
    icon = 'monster',
    note = t['legion_vanguard_note'],
    loot = {
      achievement = {
        -- Cut off the Head
        [9633] = { criteriaId = 26579 },
      },
      item = {
        -- Vanguard's Linebreaking Bracer
        [119385] = { type = 'transmog' },
      },
    },
  },

  -- Orumo the Observer
  [31404760] = {
    npcId = 87668,
    questId = 37344,
    icon = 'monster',
    note = t['orumo_the_observer_note'],
    loot = {
      achievement = {
        -- Heralds of the Legion
        [9638] = { criteriaId = 26476 },
      },
      item = {
        -- Chained Orb of Omniscience
        [119375] = { subtype = t['neck'] },
        -- Eye of Observation
        [119170] = { petId = 1576 },
      },
    },
  },

  -- Shadowflame Terrorwalker
  [41004200] = {
    npcId = 82930,
    questId = 37347,
    icon = 'monster',
    loot = {
      achievement = {
        -- Heralds of the Legion
        [9638] = { criteriaId = 26479 },
      },
      item = {
        -- Searing Shadowflame Axe
        [119393] = { type = 'transmog' },
      },
    },
  },

  -- Lord Korinak
  [31002680] = {
    npcId = 82920,
    questId = 37345,
    icon = 'monster',
    loot = {
      achievement = {
        -- Heralds of the Legion
        [9638] = { criteriaId = 26477 },
      },
      item = {
        -- Doomlord's Seal of Command
        [119388] = { subtype = t['ring'] },
      },
    },
  },

  -- Vigilant Paarthos
  [37604320] = {
    npcId = 88436,
    questId = 37350,
    icon = 'monster',
    loot = {
      achievement = {
        -- Heralds of the Legion
        [9638] = { criteriaId = 26582 },
      },
      item = {
        -- Shoulderplates of the Vigilant
        [119383] = { type = 'transmog' },
      },
    },
  },

  -- Bombadier Gu'gok
  [43203740] = {
    npcId = 87597,
    questId = 37339,
    icon = 'monster',
    path = { 43203740, 43103840, 43803910, 44203980, 44504070, 45103890, 44603750, 43803680, 43203740 },
    loot = {
      achievement = {
        -- Cut off the Head
        [9633] = { criteriaId = 26465 },
      },
      item = {
        -- Gu'gok's Rangefinder
        [119413] = { type = 'transmog' },
      },
    },
  },

  -- Taladorantula
  [59008740] = {
    npcId = 77634,
    questId = 34171,
    icon = 'monster',
    note = t['taladorantula_note'],
    loot = {
      item = {
        -- Taladorantula Terrorfang
        [116126] = { type = 'transmog' },
      },
    },
  },

  -- Kharazos the Triumphant
  [56606320] = {
    npcId = 78710,
    questId = 35220,
    icon = 'monster',
    note = t['kharazos_galzomar_sikthiss_note'],
    path = { 56606320, 56606490, 56706730 },
    loot = {
      item = {
        -- Burning Legion Missive
        [116122] = { type = 'toy' },
      },
    },
  },

  -- Galzomar
  [56606490] = {
    npcId = 78713,
    questId = 34483,
    icon = 'monster',
    note = t['kharazos_galzomar_sikthiss_note'],
    path = { 56606320, 56606490, 56706730 },
    loot = {
      item = {
        -- Burning Legion Missive
        [116122] = { type = 'toy' },
      },
    },
  },

  -- Sikthiss, Maiden of Slaughter
  [56706730] = {
    npcId = 78715,
    questId = 35219,
    icon = 'monster',
    note = t['kharazos_galzomar_sikthiss_note'],
    path = { 56606320, 56606490, 56706730 },
    loot = {
      item = {
        -- Burning Legion Missive
        [116122] = { type = 'toy' },
      },
    },
  },

  -- Sargerei War Council
  [43402700] = {
    npcId = 88071,
    questId = 37337,
    icon = 'monster',
    path = { 43402700, 44402580, 45802580, 46002700, 47302780, 47202920,
             47403090, 46403050, 45303010, 43603020, 43402700 },
    loot = {
      achievement = {
        -- Cut off the Head
        [9633] = { criteriaId = 26470 },
      },
      item = {
        -- Sargerei Councilor's Drape
        [119350] = { type = 'transmog', subtype = t['cloak'] },
      },
    },
  },

  -- Shirzir
  [43005400] = {
    npcId = 79543,
    questId = 34671,
    icon = 'monster',
    note = t['shirzir_note'],
    POI = { 41205990 },
    loot = {
      item = {
        -- Shirzir's Sticky Slippers
        [112370] = { type = 'transmog' },
      },
    },
  },

  --- Treasures
  -- Bonechewer Remnants
  [33307680] = {
    name = t['bonechewer_remnants_title'],
    questId = 34259,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Bonechewer Spear
  [37707470] = {
    name = t['bonechewer_spear_title'],
    questId = 34148,
    icon = 'chest',
    note = t['in_cave'],
    POI = { 36607540 },
    loot = {
      item = {
        -- Warpstalker-Scale Grips
        [112371] = { type = 'transmog' },
      },
    },
  },

  -- Treasure of Ango'rosh
  [38308450] = {
    name = t['treasure_of_angorosh_title'],
    questId = 34257,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Aarko's Family Treasure
  [36509610] = {
    name = t['aarkos_family_treasure_title'],
    questId = 34182,
    icon = 'chest',
    note = t['aarkos_family_treasure_note'],
    loot = {
      item = {
        -- Aarko's Antique Crossbow
        [117567] = { type = 'transmog' },
      },
    },
  },

  -- Farmer's Bounty
  [35409660] = {
    name = t['farmers_bounty_title'],
    questId = 34249,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Light of the Sea
  [38201240] = {
    name = t['light_of_the_sea_title'],
    questId = 34258,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Luminous Shell
  [52602950] = {
    name = t['luminous_shell_title'],
    questId = 34235,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Snail Shell Necklace
        [116132] = { subtype = t['neck'] },
      },
    },
  },

  -- Draenei Weapons
  [55206670] = {
    name = t['draenei_weapons_title'],
    questId = 34253,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Surplus Auchenai Weaponry
        [116118] = { },
      },
    },
  },

  -- Amethyl Crystal
  [62103240] = {
    name = t['amethyl_crystal_title'],
    questId = 34236,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Amethyl Crystal
        [116131] = { },
      },
    },
  },

  -- Barrel of Fish
  [62404800] = {
    name = t['barrel_of_fish_title'],
    questId = 34252,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Bright Coin
  [73505140] = {
    name = t['bright_coin_title'],
    questId = 34471,
    icon = 'chest',
    note = t['bright_coin_note'],
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Bright Coin
        [116127] = { subtype = t['trinket'] },
      },
    },
  },

  -- Lightbearer
  [68805620] = {
    name = t['lightbearer_title'],
    questId = 34101,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Burning Blade Cache
  [70100710] = {
    name = t['burning_blade_cache_title'],
    questId = 36937,
    icon = 'chest',
  },

  -- Relic of Aruuna
  [75804470] = {
    name = t['relic_of_aruuna_title'],
    questId = 34250,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Relic of Telmor
  [47009170] = {
    name = t['relic_of_telmor_title'],
    questId = 34256,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Charred Sword
  [77005000] = {
    name = t['charred_sword_title'],
    questId = 34248,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Blazegrease Greatsword
        [116116] = { type = 'transmog' },
      },
    },
  },

  -- Foreman's Lunchbox
  [57402870] = {
    name = t['foremans_lunchbox_title'],
    questId = 34238,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Tasty Talador Lunch
        [116120] = { type = 'toy' },
      },
    },
  },

  -- Deceptia's Smoldering Boots
  [58801210] = {
    name = t['deceptias_smoldering_boots_title'],
    questId = 33933,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Deceptia's Smoldering Boots
        [108743] = { type = 'toy' },
      },
    },
  },

  -- Webbed Sac
  [65408860] = {
    name = t['webbed_sac_title'],
    questId = 34255,
    icon = 'chest',
    note = t['in_cave'] .. '\n\n' .. t['upper_note'],
    POI = { 61308410 },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Rusted Lockbox
  [66008510] = {
    name = t['rusted_lockbox_title'],
    questId = 34276,
    icon = 'chest',
    note = t['in_cave'] .. '\n\n' .. t['rusted_lockbox_note'],
    POI = { 61308410 },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Curious Deathweb Egg
  [66508690] = {
    name = t['curious_deathweb_egg_title'],
    questId = 34239,
    icon = 'chest',
    note = t['in_cave'] .. '\n\n' .. t['curious_deathweb_egg_note'],
    POI = { 61308410 },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Giant Deathweb Egg
        [117569] = { type = 'toy' },
      },
    },
  },

  -- Iron Box
  [64607920] = {
    name = t['iron_box_title'],
    questId = 34251,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Gordunni Skullthumper
        [117571] = { type = 'transmog' },
      },
    },
  },

  -- Ketya's Stash
  [54002760] = {
    name = t['ketyas_stash_title'],
    questId = 34290,
    icon = 'chest',
    note = t['in_cave'],
    POI = { 53202600 },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Stonegrinder
        [116402] = { petId = 1515 },
      },
    },
  },

  -- Rook's Tacklebox
  [64901330] = {
    name = t['rooks_tacklebox_title'],
    questId = 34232,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Rook's Lucky Fishin' Line
        [116117] = { },
      },
    },
  },

  -- Jug of Aged Ironwine
  [65501140] = {
    name = t['jug_of_aged_ironwine_title'],
    questId = 34233,
    icon = 'chest',
    note = t['in_cave'],
    POI = { 64800930 },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Keluu's Belongings
  [75704140] = {
    name = t['keluus_belongings_title'],
    questId = 34261,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Pure Crystal Dust
  [78201470] = {
    name = t['pure_crystal_dust_title'],
    questId = 34263,
    icon = 'chest',
    note = t['in_cave'] .. '\n\n' .. t['upper_note'],
    POI = { 75302240 },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Iridium Inlaid Band
        [117572] = { subtype = t['ring'] },
      },
    },
  },

  -- Aruuna Mining Cart
  [81803490] = {
    name = t['aruuna_mining_cart_title'],
    questId = 34260,
    icon = 'chest',
    note = t['in_cave'] .. '\n\n' .. t['aruuna_mining_cart_note'],
    POI = { 78103560 },
    loot = {
      achievement = {
         -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Soulbinder's Reliquary
  [39505510] = {
    name = t['soulbinders_reliquary_title'],
    questId = 34254,
    icon = 'chest',
    note = t['in_cave'],
    POI = { 41205990 },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Auchenai Soulbinder's Signet
        [117570] = { subtype = t['ring'] },
      },
    },
  },

  -- Iron Scout
  [75103610] = {
    npcId = 75644,
    questId = 33649,
    icon = 'chest',
    note = t['iron_scout_note'],
  },

  -- Gift of the Ancients
  [28407420] = {
    name = t['gift_of_the_ancients_title'],
    questId = 36829,
    icon = 'chest',
    note = t['in_cave'] .. '\n\n' .. t['gift_of_the_ancients_note'],
    POI = { 27807550 },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Signet Ring of Gehs'taal
        [118686] = { subtype = t['ring'] },
      },
    },
  },

  -- Isaari's Cache
  [57207530] = {
    name = t['isaaris_cache_title'],
    questId = 34134,
    icon = 'chest',
    requirement = {
      faction = 'Alliance',
    },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Deathweb Toxin Vial
        [117563] = { subtype = t['neck'] },
      },
    },
  },

  -- Yuuri's Gift
  [40608950] = {
    name = t['yuuris_gift_title'],
    questId = 34140,
    icon = 'chest',
    requirement = {
      quest = {
        -- Nightmare in the Tomb
        [33530] = { },
      },
    },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Teroclaw Nest
  [39807670] = {
    name = t['teroclaw_nest_title'],
    questId = 35162,
    icon = 'chest',
    note = t['teroclaw_nest_note'],
    POI = { 39307770, 54105630, 70803200, 70903550, 72403700, 72803560, 73503070, 74303400, 74602930 },
    loot = {
      item = {
        -- Teroclaw Hatchling
        [112699] = { petId = 1416 },
      },
    },
  },

  --- Pet Battles
  -- Taralune
  [49008040] = {
    npcId = 87125,
    icon = 'pet',
    loot = {
      achievement = {
        -- An Awfully Big Adventure
        [9069] = { criteriaId = 27002 },
        -- Taming Draenor
        [9724] = { criteriaId = 27016 },
      },
    },
  },

  --- Achievements
  -- Knight Pepe
  [51006330] = {
    name = t['knight_pepe_title'],
    icon = 'achievement',
    note = t['knight_pepe_note'],
    questId = 39266,
    loot = {
      -- I Found Pepe!
      achievement = {
        [10053] = { criteriaId = 28183 },
      },
      item = {
        -- A Tiny Plated Helm
        [127869] = { },
      },
    },
  },

  -- Poor Communication
  [35804045] = {
    name = t['poor_communication_title'],
    icon = 'achievement',
    POI = {
      37884390, 37084292, 37484104, 34343990, 33784069, 33623975, 41314212, 41984631, 41984631, 43724682, 32833524,
      36104176, 36564226, 33993690, 34764064,
    },
    note = t['poor_communication_note'] .. '\n\n' .. t['missive'],
    requirement = {
      quest = {
        [RequiredQuests['assault on the heart of shattrath']] = { state = 'active' },
      },
    },
    loot = {
      -- Poor Communication
      achievement = {
        [9637] = { count = true },
      },
    },
  },

  -- United We Stand
  [45402430] = {
    name = t['united_we_stand_title'],
    icon = 'achievement',
    POI = {
      37001440, 37801880, 37602100, 43602260, 41202020, 46802080, 47202360, 44402780, 43402980, 46802760, 48402980,
      46803220, 45603680, 35201660,
    },
    note = t['united_we_stand_note'] .. '\n\n' .. t['missive'],
    requirement = {
      quest = {
        [RequiredQuests['assault on shattrath harbor']] = { state = 'active' },
      },
    },
    loot = {
      -- United We Stand
      achievement = {
        [9636] = { count = true },
      },
    },
  },

  -- Bobbing for Orcs
  [45402100] = {
    name = t['bobbing_for_orcs_title'],
    icon = 'achievement',
    POI = { 43002220, 47402230 },
    note = t['bobbing_for_orcs_note'] .. '\n\n' .. t['missive'],
    requirement = {
      quest = {
        [RequiredQuests['assault on shattrath harbor']] = { state = 'active' },
      },
    },
    loot = {
      -- Bobbing for Orcs
      achievement = {
        [9635] = { count = true },
      },
    },
  },

  -- The Power Is Yours
  [34204330] = {
    name = t['power_is_yours_title'],
    icon = 'achievement',
    POI = {
      33394030, 32803650, 33734896, 32092389, 43564606, 38384248, 38293737, 34743959, 34973750, 33673600, 36954470,
      34733980,
    },
    note = t['power_is_yours_note'] .. '\n\n' .. t['missive'],
  requirement = {
    quest = {
      [RequiredQuests['assault on the heart of shattrath']] = { state = 'active' },
    },
  },
    loot = {
      -- The Power Is Yours
      achievement = {
        [9632] = { },
      },
    },
  },
}

local subPoints = {
  -- Shirzir
  [67602310] = {
    npcId = 79543,
    questId = 34671,
    icon = 'monster',
    loot = {
      item = {
        -- Shirzir's Sticky Slippers
        [112370] = { type = 'transmog' },
      },
    },
  },
  -- Soulbinder's Reliquary
  [28303500] = {
    name = t['soulbinders_reliquary_title'],
    questId = 34254,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Auchenai Soulbinder's Signet
        [117570] = { subtype = t['ring'] },
      },
    },
  },
}

this.points[map] = points
this.points[subMap] = subPoints
