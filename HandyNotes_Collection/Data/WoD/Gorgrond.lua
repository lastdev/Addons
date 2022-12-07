---
--- @file
--- Map point definitions.
---

local _, this = ...

local Player = this.Player
local t = this.t
local map = this.maps['gorgrond']
local subMap = this.maps['cragplume']

-- Alliance quest IDs from Trophy of Glory.
local TrophyOfGloryQuests = {
  ['biolante'] = 36502,
  ['crater lord igneous'] = 35812,
  ['charl doomwing'] = 35816,
  ['khargax devourer'] = 35820,
  ['roardan sky terror'] = 35817,
  ['dessicus dead pools'] = 35809,
  ['erosian violent'] = 35808,
  ['fungal praetorian'] = 35813,
  ['outpost'] = 35063,
}

-- Horde quest IDs from Trophy of Glory.
if (Player:isHorde() == true) then
  TrophyOfGloryQuests = {
    ['biolante'] = 36503,
    ['crater lord igneous'] = 35811,
    ['charl doomwing'] = 35815,
    ['khargax devourer'] = 35819,
    ['roardan sky terror'] = 35818,
    ['dessicus dead pools'] = 35810,
    ['erosian violent'] = 35807,
    ['fungal praetorian'] = 35814,
    ['outpost'] = 35151,
  }
end

-- Define NPCs we are going to use in multiple points.
local Poundfist = {
  npcId = 50985,
  icon = 'monster',
  note = t['poundfist_note'],
  loot = {
    item = {
      -- Sunhide Gronnling
      [116792] = { mountId = 655 },
    },
  },
}

local Alkali = {
  npcId = 86268,
  questId = 37371,
  icon = 'monster',
  note = t['multiple_spawn_note'],
  loot = {
    achievement = {
      -- Ancient No More
      [9678] = { criteriaId = 26597 },
    },
    item = {
      -- -- Thorn-Knuckled Gloves
      [119361] = { type = 'transmog' },
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

-- Points on map.
local points = {
  --- Rares
  [41902500] = Poundfist,
  [51604310] = Poundfist,
  [45204660] = Poundfist,
  [47405530] = Poundfist,
  [43005570] = Poundfist,
  [56204080] = Alkali,
  [58604120] = Alkali,
  [71404040] = Alkali,
  [51583863] = Voidtalon,
  [54004580] = Voidtalon,
  [56004065] = Voidtalon,
  [43213420] = Voidtalon,

  -- Biolante
  [62905520] = {
    npcId = 75207,
    icon = 'monster',
    note = t['trophy_of_glory_note'],
    requirement = {
      quest = {
        [TrophyOfGloryQuests['outpost']] = { },
      },
    },
    loot = {
      achievement = {
        -- Gorgrond Monster Hunter
        [9400] = { criteriaId = 25568 },
      },
      item = {
        -- Writhing Green Tendril
        [116160] = { questId = TrophyOfGloryQuests['biolante'] },
      },
    },
    path = { 62705420, 62505270, 62005220, 61505230, 61105340, 60605370, 60505490 },
  },

  -- Crater Lord Igneous
  [43806060] = {
    npcId = 81528,
    icon = 'monster',
    note = t['trophy_of_glory_note'],
    requirement = {
      quest = {
        [TrophyOfGloryQuests['outpost']] = { },
      },
    },
    loot = {
      achievement = {
        -- Gorgrond Monster Hunter
        [9400] = { criteriaId = 25570 },
      },
      item = {
        -- Chunk of Crater Lord
        [113448] = { questId = TrophyOfGloryQuests['crater lord igneous'] },
      },
    },
  },

  -- Charl Doomwing
  [45205160] = {
    npcId = 81548,
    icon = 'monster',
    note = t['trophy_of_glory_note'],
    requirement = {
      quest = {
        [TrophyOfGloryQuests['outpost']] = { },
      },
    },
    loot = {
      achievement = {
        -- Gorgrond Monster Hunter
        [9400] = { criteriaId = 25574 },
      },
      item = {
        -- Fang of the Doomwing
        [113457] = { questId = TrophyOfGloryQuests['charl doomwing'] },
      },
    },
    path = { 45205160, 45404900, 46004680, 47804640 },
  },

  -- Khargax the Devourer
  [53206880] = {
    npcId = 81537,
    icon = 'monster',
    note = t['trophy_of_glory_note'],
    requirement = {
      quest = {
        [TrophyOfGloryQuests['outpost']] = { },
      },
    },
    loot = {
      achievement = {
        -- Gorgrond Monster Hunter
        [9400] = { criteriaId = 25572 },
      },
      item = {
        -- Shimmering Scale
        [113460] = { questId = TrophyOfGloryQuests['khargax devourer']},
      },
    },
    path = { 53206880, 52706870, 52206770, 52406660, 53406590, 54006590, 54306710, 54006750, 53806820, 53206880 },
  },

  -- Roardan the Sky Terror
  [50806760] = {
    npcId = 77093,
    icon = 'monster',
    note = t['roardan_sky_terror_note'] .. '\n\n' .. t['trophy_of_glory_note'],
    requirement = {
      quest = {
        [TrophyOfGloryQuests['outpost']] = { },
      },
    },
    loot = {
      achievement = {
        -- Gorgrond Monster Hunter
        [9400] = { criteriaId = 25569 },
      },
      item = {
        -- Ebony Feather
        [113458] = { questId = TrophyOfGloryQuests['roardan sky terror'] },
      },
    },
    POI = { 61606200, 53106300 },
  },

  -- Dessicus of the Dead Pools
  [38805120] = {
    npcId = 81529,
    icon = 'monster',
    note = t['trophy_of_glory_note'],
    requirement = {
      quest = {
        [TrophyOfGloryQuests['outpost']] = { },
      },
    },
    loot = {
      achievement = {
        -- Gorgrond Monster Hunter
        [9400] = { criteriaId = 25571 },
      },
      item = {
        -- Globe of Dead Water
        [113447] = { questId = TrophyOfGloryQuests['dessicus dead pools'] },
      },
    },
  },

  -- Erosian the Violent
  [51804160] = {
    npcId = 81540,
    icon = 'monster',
    note = t['trophy_of_glory_note'],
    requirement = {
      quest = {
        [TrophyOfGloryQuests['outpost']] = { },
      },
    },
    loot = {
      achievement = {
        -- Gorgrond Monster Hunter
        [9400] = { criteriaId = 25573 },
      },
      item = {
        -- Crystalized Steam
        [113444] = { questId = TrophyOfGloryQuests['erosian violent'] },
      },
    },
  },

  -- Fungal Praetorian
  [58006360] = {
    npcId = 80785,
    icon = 'monster',
    note = t['trophy_of_glory_note'],
    requirement = {
      quest = {
        [TrophyOfGloryQuests['outpost']] = { },
      },
    },
    loot = {
      achievement = {
        -- Gorgrond Monster Hunter
        [9400] = { criteriaId = 25575 },
      },
      item = {
        -- Precious Mushroom
        [113453] = { questId = TrophyOfGloryQuests['fungal praetorian'] },
      },
    },
  },

  -- Stomper Kreego
  [38206620] = {
    npcId = 79629,
    questId = 35910,
    icon = 'monster',
    loot = {
      item = {
        -- Ogre Brewing Kit
        [118224] = { type = 'toy' },
      },
    },
  },

  -- Mandrakor
  [50605320] = {
    npcId = 84406,
    questId = 36178,
    icon = 'monster',
    loot = {
      item = {
        -- Doom Bloom
        [118709] = { petId = 1564 },
      },
    },
  },

  -- Maniacal Madgard
  [49003300] = {
    npcId = 86562,
    questId = 37363,
    icon = 'monster',
    loot = {
      achievement = {
        -- Fight the Power
        [9655] = { criteriaId = 26542 },
      },
      item = {
        -- Unpopped Pustule Pendant
        [119230] = { subtype = t['neck'] },
      },
    },
  },

  -- Defector Dazgo
  [48202100] = {
    npcId = 86566,
    questId = 37362,
    icon = 'monster',
    loot = {
      achievement = {
        -- Fight the Power
        [9655] = { criteriaId = 26543 },
      },
      item = {
        -- Foereaver Polearm
        [119224] = { type = 'transmog' },
      },
    },
  },

  -- Durp the Hated
  [49802380] = {
    npcId = 86571,
    questId = 37366,
    icon = 'monster',
    loot = {
      achievement = {
        -- Fight the Power
        [9655] = { criteriaId = 26544 },
      },
      item = {
        -- Studded Gronn-Stitched Girdle
        [119225] = { type = 'transmog' },
      },
    },
  },

  -- Inventor Blammo
  [47603080] = {
    npcId = 86574,
    questId = 37367,
    icon = 'monster',
    loot = {
      achievement = {
        -- Fight the Power
        [9655] = { criteriaId = 26545 },
      },
      item = {
        -- Blammo's Blammer
        [119226] = { type = 'transmog' },
      },
    },
  },

  -- Horgg
  [45802660] = {
    npcId = 86577,
    questId = 37365,
    icon = 'monster',
    loot = {
      achievement = {
        -- Fight the Power
        [9655] = { criteriaId = 26548 },
      },
      item = {
        -- Horgg's Bandolier
        [119229] = { type = 'transmog' },
      },
    },
  },

  -- Blademaster Ro'gor
  [45803300] = {
    npcId = 86579,
    questId = 37368,
    icon = 'monster',
    loot = {
      achievement = {
        -- Fight the Power
        [9655] = { criteriaId = 26550 },
      },
      item = {
        -- Ro'gor's Slippers of Silence
        [119228] = { type = 'transmog' },
      },
    },
  },

  -- Morgo Kain
  [46602300] = {
    npcId = 86582,
    questId = 37364,
    icon = 'monster',
    loot = {
      achievement = {
        -- Fight the Power
        [9655] = { criteriaId = 26551 },
      },
      item = {
        -- Morgo's Unstoppable Ramming Helm
        [119227] = { type = 'transmog' },
      },
    },
  },

  -- Swift Onyx Flayer
  [59603200] = {
    npcId = 88582,
    questId = 37374,
    icon = 'monster',
    loot = {
      achievement = {
        -- Ancient No More
        [9678] = { criteriaId = 26593 },
      },
      item = {
        -- Flayerscale Carapace Stompers
        [119367] = { type = 'transmog' },
      },
    },
  },

  -- Mogamago
  [61603920] = {
    npcId = 88586,
    questId = 37376,
    icon = 'monster',
    loot = {
      achievement = {
        -- Ancient No More
        [9678] = { criteriaId = 26594 },
      },
      item = {
        -- Etched Osteoderm Shield
        [119391] = { type = 'transmog' },
      },
    },
  },

  -- Basten (Protectors of the Grove)
  [69204460] = {
    npcId = 86257,
    questId = 37369,
    icon = 'monster',
    loot = {
      achievement = {
        -- Ancient No More
        [9678] = { criteriaId = 26595 },
      },
      item = {
        -- Botani Camouflage
        [119432] = { type = 'toy' },
        -- Grovetender's Cummerbund
        [119357] = { type = 'transmog' },
      },
    },
  },

  -- Venolasix
  [63403080] = {
    npcId = 86266,
    questId = 37372,
    icon = 'monster',
    loot = {
      achievement = {
        -- Ancient No More
        [9678] = { criteriaId = 26596 },
      },
      item = {
        -- Hydratooth Dagger
        [119395] = { type = 'transmog' },
      },
    },
  },

  -- Depthroot
  [72604060] = {
    npcId = 82058,
    questId = 37370,
    icon = 'monster',
    loot = {
      achievement = {
        -- Ancient No More
        [9678] = { criteriaId = 26598 },
      },
      item = {
        -- Depthroot's Forearm
        [119406] = { type = 'transmog' },
      },
    },
  },

  -- Firestarter Grash
  [57803660] = {
    npcId = 88580,
    questId = 37373,
    icon = 'monster',
    loot = {
      achievement = {
        -- Ancient No More
        [9678] = { criteriaId = 26599 },
      },
      item = {
        -- Grash's Fireproof Handguards
        [119381] = { type = 'transmog' },
      },
    },
  },

  -- Grove Warden Yal
  [59604300] = {
    npcId = 88583,
    questId = 37375,
    icon = 'monster',
    loot = {
      achievement = {
        -- Ancient No More
        [9678] = { criteriaId = 26600 },
      },
      item = {
        -- Yal's Leafwrap Cloak
        [119414] = { type = 'transmog', subtype = t['cloak'] },
      },
    },
  },

  -- Hunter Bal'ra
  [54804620] = {
    npcId = 88672,
    questId = 37377,
    icon = 'monster',
    loot = {
      achievement = {
        -- Ancient No More
        [9678] = { criteriaId = 26606 },
      },
      item = {
        -- Bal'ra's Compound Bow
        [119412] = { type = 'transmog' },
      },
    },
  },

  -- Mother Araneae
  [53407820] = {
    npcId = 76473,
    questId = 34726,
    icon = 'monster',
    loot = {
      item = {
        -- Broodmother's Kiss
        [118208] = { type = 'transmog' },
      },
    },
  },

  -- Sulfurious
  [40606020] = {
    npcId = 80725,
    questId = 36394,
    icon = 'monster',
    loot = {
      item = {
        -- Bubble Wand
        [114227] = { type = 'toy' },
      },
    },
  },

  -- Glut
  [46005080] = {
    npcId = 80868,
    questId = 36204,
    icon = 'monster',
    loot = {
      item = {
        -- Resonant Hidecrystal of the Gorger
        [118229] = { subtype = t['trinket'] },
      },
    },
  },

  -- Gelgor of the Blue Flame
  [41804560] = {
    npcId = 81038,
    questId = 36391,
    icon = 'monster',
    loot = {
      item = {
        -- Smoldering Cerulean Stone
        [118230] = { subtype = t['trinket'] },
      },
    },
  },

  -- Bashiok
  [40007900] = {
    npcId = 82085,
    questId = 35335,
    icon = 'monster',
    loot = {
      item = {
        -- Spirit of Bashiok
        [118222] = { type = 'toy' },
      },
    },
  },

  -- Char the Burning
  [53604460] = {
    npcId = 82311,
    questId = 35503,
    icon = 'monster',
    loot = {
      item = {
        -- Char's Smoldering Fist
        [118212] = { type = 'transmog' },
      },
    },
  },

  -- Hive Queen Skrikka
  [52207020] = {
    npcId = 83522,
    questId = 35908,
    icon = 'monster',
    loot = {
      item = {
        -- Skrikka's Mandible
        [118209] = { type = 'transmog' },
      },
    },
  },

  -- Greldrok the Cunning
  [46804300] = {
    npcId = 84431,
    questId = 36186,
    icon = 'monster',
    loot = {
      item = {
        -- Greldrok's Facesmasher
        [118210] = { type = 'transmog' },
      },
    },
  },

  -- Fossilwood the Petrified
  [57406860] = {
    npcId = 85250,
    questId = 36387,
    icon = 'monster',
    loot = {
      item = {
        -- Petrification Stone
        [118221] = { type = 'toy' },
      },
    },
  },

  -- Stompalupagus
  [54407140] = {
    npcId = 86520,
    questId = 36837,
    icon = 'monster',
    loot = {
      item = {
        -- Smashalupagus
        [118228] = { type = 'transmog' },
      },
    },
  },

  -- Sunclaw
  [44609220] = {
    npcId = 86137,
    questId = 36656,
    icon = 'monster',
    loot = {
      item = {
        -- Sunclaw
        [118223] = { type = 'transmog' },
      },
    },
  },

  -- Berthora
  [39407460] = {
    npcId = 85907,
    questId = 36597,
    icon = 'monster',
    note = t['in_cave'],
    POI = { 39707630 },
    loot = {
      item = {
        -- Scaled Riverbeast Spaulders
        [118232] = { type = 'transmog' },
      },
    },
  },

  -- Riptar
  [37608140] = {
    npcId = 85970,
    questId = 36600,
    icon = 'monster',
    loot = {
      item = {
        -- Riptar's Clever Claw
        [118231] = { type = 'transmog' },
      },
    },
  },

  -- Rolkor
  [47804160] = {
    npcId = 85264,
    questId = 36393,
    icon = 'monster',
    loot = {
      item = {
        -- Rolkor's Rage
        [118211] = { subtype = t['trinket'] },
      },
    },
  },

  -- Sylldros
  [64006180] = {
    npcId = 86410,
    questId = 36794,
    icon = 'monster',
    loot = {
      item = {
        -- Slimy Sea Serpent Skin Sabatons
        [118213] = { type = 'transmog' },
      },
    },
  },

  -- Gnarljaw
  [53005350] = {
    npcId = 78269,
    questId = 37413,
    icon = 'monster',
    note = t['in_cave'],
    POI = { 54105580 },
    loot = {
      item = {
        -- Gnarled Goren Jaw
        [119397] = { type = 'transmog' },
      },
    },
  },

  -- King Slime
  [52205580] = {
    npcId = 78260,
    questId = 37412,
    icon = 'monster',
    note = t['in_cave'],
    POI = { 54105580 },
    loot = {
      item = {
        -- Slime Coated Kingscloak
        [119351] = { type = 'transmog', subtype = t['cloak'] },
      },
    },
  },

  --- Treasures
  -- Pile of Rubble
  [44007060] = {
    name = t['pile_of_rubble_treasure'],
    icon = 'chest',
    questId = 36118,
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Odd Skull
  [52506690] = {
    name = t['odd_skull_treasure'],
    icon = 'chest',
    questId = 36509,
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Beastskull Vessel
        [118717] = { type = 'transmog', subtype = t['off-hand'] },
      },
    },
  },

  -- Remains of Balik Orecrusher
  [53107450] = {
    name = t['remains_of_balik_orecrusher_treasure'],
    icon = 'chest',
    questId = 36654,
    note = t['in_cave'],
    -- Cave entrance
    POI = { 51407440 },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Warm Goren Egg
  [48904730] = {
    name = t['warm_goren_egg_treasure'],
    icon = 'chest',
    questId = 36203,
    note = t['warm_goren_egg_note'],
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Goren Garb
        [118716] = { type = 'toy' },
        -- Warm Goren Egg
        [118705] = { },
      },
    },
  },

  -- Explorer Canister
  [40407660] = {
    name = t['explorer_canister_treasure'],
    icon = 'chest',
    questId = 36621,
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Exploratron 2000 Spare Parts
        [118710] = { },
      },
    },
  },

  -- Discarded Pack
  [42408350] = {
    name = t['discarded_pack_treasure'],
    icon = 'chest',
    questId = 36625,
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Ockbar's Pack
  [43109290] = {
    name = t['ockbars_pack_treasure'],
    icon = 'chest',
    questId = 34241,
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Stashed Emergency Rucksack
  [48109340] = {
    name = t['stashed_emergency_rucksack_treasure'],
    icon = 'chest',
    questId = 36604,
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Sasha's Secret Stash
  [39006810] = {
    name = t['sashas_secret_stash_treasure'],
    icon = 'chest',
    questId = 36631,
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Vindicator's Hammer
  [59506370] = {
    name = t['vindicators_hammer_treasure'],
    icon = 'chest',
    questId = 36628,
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Huurand's Huge Hammer
        [118712] = { type = 'transmog' },
      },
    },
  },

  -- Remains of Balldir Deeprock
  [57805600] = {
    name = t['remains_if_balldir_deeprock_treasure'],
    icon = 'chest',
    questId = 36605,
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Brokor's Sack
  [41705290] = {
    name = t['brokors_sack_treasure'],
    icon = 'chest',
    questId = 36506,
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Brokor's Walking Stick
        [118702] = { type = 'transmog' },
      },
    },
  },

  -- Suntouched Spear
  [45704970] = {
    name = t['suntouched_spear_treasure'],
    icon = 'chest',
    questId = 36610,
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Weapons Cache
  [49304360] = {
    name = t['weapons_cache_treasure'],
    icon = 'chest',
    questId = 36596,
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Iron Horde Weapon Cache
        [107645] = { },
      },
    },
  },

  -- Petrified Rylak Egg
  [46204290] = {
    name = t['petrified_rylak_egg_treasure'],
    icon = 'chest',
    questId = 36521,
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Sniper's Crossbow
  [45004260] = {
    name = t['snipers_crossbow_trerasure'],
    icon = 'chest',
    questId = 36634,
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Iron Lookout's Arbalest
        [118713] = { type = 'transmog' },
      },
    },
  },

  -- Iron Supply Chest
  [43704250] = {
    name = t['iron_supply_chest_treasure'],
    icon = 'chest',
    questId = 36618,
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Evermorn Supply Cache
  [41807810] = {
    name = t['evermorn_supply_cache_treasure'],
    icon = 'chest',
    questId = 36658,
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Femur of Improbability
  [40007230] = {
    name = t['femur_of_improbability_treasure'],
    icon = 'chest',
    questId = 36170,
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Laughing Skull Cache
  [44207420] = {
    name = t['laughing_skull_cache_treasure'],
    icon = 'chest',
    questId = 35709,
    note = t['laughing_skull_note'],
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Horned Skull
  [46906870] = {
    name = t['horned_skull_treasure'],
    icon = 'chest',
    questId = 35056,
    note = t['in_cave'],
    -- Cave entrance
    POI = { 43504800 },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Harvestable Precious Crystal
  [46105000] = {
    name = t['harvestable_precious_crystal_treasure'],
    icon = 'chest',
    questId = 36651,
    note = t['in_cave'],
    -- Cave entrance
    POI = { 44505080 },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Strange Looking Dagger
  [53008000] = {
    name = t['strange_looking_dagger_treasure'],
    icon = 'chest',
    questId = 34940,
    note = t['in_cave'],
    -- Cave entrance
    POI = { 51307760 },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Pale Bloodthief Dagger
        [118718] = { type = 'transmog' },
      },
    },
  },

  -- Strange Spore
  [57106530] = {
    questId = 37249,
    icon = 'chest',
    note = t['strange_spore_treasure'],
    loot = {
      item = {
        -- Crimson Spore
        [118106] = { petId = 1537 },
      },
    },
  },

  --- Pet Battles
  -- Cymre Brightblade
  [51007060] = {
    npcId = 83837,
    icon = 'pet',
    loot = {
      achievement = {
        -- An Awfully Big Adventure
        [9069] = { criteriaId = 26978 },
        -- Taming Draenor
        [9724] = { criteriaId = 27011 },
      },
    },
  },

  --- Achievements
  -- Ninja Pepe
  [47504130] = {
    name = t['ninja_pepe_title'],
    icon = 'achievement',
    note = t['ninja_pepe_note'],
    questId = 39267,
    loot = {
      achievement = {
        -- I Found Pepe!
        [10053] = { criteriaId = 28182 },
      },
      item = {
        -- A Tiny Ninja Shroud
        [127867] = { },
      },
    },
  },

  -- Attack plans of In Plain Sight achievement
  [45802720] = {
    name = t['attack_plans_title'],
    icon = 'achievement',
    note = t['attack_plans_crane'] .. '\n\n' .. t['multiple_spawn_plans'],
    loot = {
      achievement = {
        -- In Plain Sight
        [9656] = { },
      },
    },
  },
  [48202700] = {
    name = t['attack_plans_title'],
    icon = 'achievement',
    note = t['attack_plans_tower'] .. '\n\n' .. t['multiple_spawn_plans'],
    loot = {
      achievement = {
        -- In Plain Sight
        [9656] = { },
      },
    },
  },
  [45202520] = {
    name = t['attack_plans_title'],
    icon = 'achievement',
    note = t['attack_plans_tracks'] .. '\n\n' .. t['multiple_spawn_plans'],
    loot = {
      achievement = {
        -- In Plain Sight
        [9656] = { },
      },
    },
  },
  [49002400] = {
    name = t['attack_plans_title'],
    icon = 'achievement',
    note = t['attack_plans_crane'] .. '\n\n' .. t['multiple_spawn_plans'],
    loot = {
      achievement = {
        -- In Plain Sight
        [9656] = { },
      },
    },
  },
}

-- This is minimap (mini dungeon) in Gorgrond.
local subPoints = {
  -- Gnarljaw
  [55103550] = {
    npcId = 78269,
    questId = 37413,
    icon = 'monster',
    loot = {
      item = {
        -- Gnarled Goren Jaw
        [119397] = { type = 'transmog' },
      },
    },
  },

  -- King Slime
  [41707490] = {
    npcId = 78260,
    questId = 37412,
    icon = 'monster',
    loot = {
      item = {
        -- Slime Coated Kingscloak
        [119351] = { type = 'transmog', subtype = t['cloak'] },
      },
    },
  },
}

this.points[map] = points
this.points[subMap] = subPoints
