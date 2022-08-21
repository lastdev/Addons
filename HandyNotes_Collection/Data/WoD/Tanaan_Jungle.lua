---
--- @file
--- Map point definitions.
---

local _, this = ...

local Player = this.Player
local t = this.t
local map = this.maps['tanaan_jungle']

-- Alliance quest IDs for required quests.
local RequiredQuests = {
  -- Garrison Campaign: The Bane of the Bleeding Hollow
  ['bleeding hollow'] = 38560,
  -- The Cipher of Damnation
  ['cipher of damnation'] = 39394,
}
-- Vendor with teleport items.
local XemirkolVendor = 57805940

-- Horde quest IDs.
if (Player:isHorde() == true) then
  RequiredQuests = {
    -- Garrison Campaign: The Bane of the Bleeding Hollow
    ['bleeding hollow'] = 38453,
    -- The Cipher of Damnation
    ['cipher of damnation'] = 38463,
  }
  XemirkolVendor = 60404660
end

local BloodhunterZulk = {
  npcId = 90936,
  questId = 38266,
  icon = 'monster',
  note = t['multiple_spawn_note'],
  loot = {
    achievement = {
      -- Jungle Stalker
      [10070] = { criteriaId = 28355 },
    },
    item = {
      -- Zulk's Sneaky Slippers
      [127303] = { type = 'transmog' },
    },
  },
}

local points = {
  --- Rares
  [24505000] = BloodhunterZulk,
  [21005240] = BloodhunterZulk,
  [22805300] = BloodhunterZulk,
  [22005160] = BloodhunterZulk,
  [23804980] = BloodhunterZulk,

  -- Commander Org'mok
  [51004600] = {
    npcId = 89675,
    questId = 38749,
    icon = 'monster',
    note = t['commander_orgmok_note'],
    path = { 51004600, 50904750, 49704810, 48504680, 47404670, 47004540,
             47804440, 49304450, 50304360, 50504470, 51004600 },
    loot = {
      achievement = {
        -- Jungle Stalker
        [10070] = { criteriaId = 28731 },
      },
      item = {
        -- Org'mok's Riding Chaps
        [127313] = { type = 'transmog' },
      },
    },
  },

  -- Sergeant Mor'grak
  [43003690] = {
    npcId = 90024,
    questId = 37953,
    icon = 'monster',
    loot = {
      achievement = {
        -- Jungle Stalker
        [10070] = { criteriaId = 28339 },
      },
      item = {
        -- Iron Cleated Warboots
        [127318] = { type = 'transmog' },
      },
    },
  },

  -- Harbormaster Korak
  [39603260] = {
    npcId = 90094,
    questId = 39046,
    icon = 'monster',
    loot = {
      achievement = {
        -- Jungle Stalker
        [10070] = { criteriaId = 28724 },
      },
      item = {
        -- Korak's Reinforced Iron Tunic
        [127309] = { type = 'transmog' },
      },
    },
  },

  -- Imp-Master Valessa
  [31207220] = {
    npcId = 90429,
    questId = 38026,
    icon = 'monster',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28333 },
      },
      item = {
        -- Sassy Imp
        [127655] = { type = 'toy' },
      },
    },
  },

  -- Ceraxas
  [30906800] = {
    npcId = 90434,
    questId = 38031,
    icon = 'monster',
    note = t['in_cave'] .. ' ' .. t['ceraxas_note'],
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28336 },
      },
      item = {
        -- Fel Pup
        [129205] = { petId = 1660 },
      },
    },
  },

  -- Jax'zor
  [26607520] = {
    npcId = 90437,
    questId = 38030,
    icon = 'monster',
    note = t['in_cave'],
    POI = { 29607060 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28335 },
      },
      item = {
        -- Fel Burnished Waistguard
        [127322] = { type = 'transmog' },
      },
    },
  },

  -- Lady Oran
  [25607680] = {
    npcId = 90438,
    questId = 38029,
    icon = 'monster',
    note = t['in_cave'],
    POI = { 29607060 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28334 },
      },
      item = {
        -- Oran's Cuffs of Malice
        [127316] = { type = 'transmog' },
      },
    },
  },

  -- Mistress Thavra
  [26107910] = {
    npcId = 90442,
    questId = 38032,
    icon = 'monster',
    note = t['mistress_thavra_note'],
    POI = { 29607060 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28337 },
      },
      item = {
        -- Shivan Shoulders of Scorn
        [127300] = { type = 'transmog' },
      },
    },
  },

  -- High Priest Ikzan
  [22003780] = {
    npcId = 90777,
    questId = 38028,
    icon = 'monster',
    path = { 22604000, 20804160, 20803760, 22003780, 22604000 },
    loot = {
      item = {
        -- Cursed Feather of Ikzan
        [122117] = { type = 'toy' },
      },
    },
  },

  -- Rasthe
  [17404280] = {
    npcId = 90782,
    questId = 38034,
    icon = 'monster',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28341 },
      },
    },
  },

  -- Bilkor the Thrower
  [23605200] = {
    npcId = 90884,
    questId = 38262,
    icon = 'monster',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28351 },
      },
      item = {
        -- Battle-Scuffed Spaulders
        [127307] = { type = 'transmog' },
      },
    },
  },

  -- Rogond the Tracker
  [20404960] = {
    npcId = 90885,
    questId = 38263,
    icon = 'monster',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28352 },
      },
      item = {
        -- Rogond's Tracking Shoulderguards
        [127314] = { type = 'transmog' },
      },
    },
  },

  -- Dorg the Bloody
  [25204630] = {
    npcId = 90887,
    questId = 38265,
    icon = 'monster',
    note = t['dorg_the_bloody_note'],
    path = { 25204630, 23904730, 23504870, 21504910, 21005110, 21405280 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28353 },
      },
      item = {
        -- Bloody Aberration Strap
        [127301] = { type = 'transmog' },
      },
    },
  },

  -- Drivnul
  [25604620] = {
    npcId = 90888,
    questId = 38264,
    icon = 'monster',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28354 },
      },
      item = {
        -- Blood Infused Leggings
        [127298] = { type = 'transmog' },
      },
    },
  },

  -- Putre'thar
  [57002300] = {
    npcId = 91009,
    questId = 38457,
    icon = 'monster',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28727 },
      },
    },
  },

  -- Zeter'el
  [48402860] = {
    npcId = 91087,
    questId = 38207,
    icon = 'monster',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28331 },
      },
      item = {
        -- Felfire Lit Greatsword
        [127340] = { type = 'transmog' },
      },
    },
  },

  -- Bramblefell
  [40706980] = {
    npcId = 91093,
    questId = 38209,
    icon = 'monster',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28330 },
      },
      item = {
        -- Felflame Campfire
        [127652] = { type = 'toy' },
      },
    },
  },

  -- Felspark
  [52802560] = {
    npcId = 91098,
    questId = 38211,
    icon = 'monster',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28332 },
      },
      item = {
        -- Fel Singed Wraps
        [127656] = { type = 'transmog' },
      },
    },
  },

  -- Commander Krag'goth
  [15005420] = {
    npcId = 91232,
    questId = 38746,
    icon = 'monster',
    note = t['commander_kraggoth_note'],
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28346 },
      },
      item = {
        -- Krag'goth's Iron Gauntlets
        [127319] = { type = 'transmog' },
      },
    },
  },

  -- Tho'gar Gorefist
  [13405680] = {
    npcId = 91243,
    questId = 38747,
    icon = 'monster',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28347 },
      },
      item = {
        -- Sabatons of Radiating Ire
        [127310] = { type = 'transmog' },
      },
    },
  },

  -- Podlord Wakkawam
  [16804940] = {
    npcId = 91374,
    questId = 38282,
    icon = 'monster',
    note = t['in_cave'],
    POI = { 17005040 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28329 },
      },
      item = {
        -- Rod of the One True Podlord
        [127336] = { type = 'transmog' },
      },
    },
  },

  -- Grand Warlock Nethekurse
  [47504230] = {
    npcId = 91695,
    questId = 38400,
    icon = 'monster',
    note = t['grand_warlock_netherkurse_note'],
    path = { 46204080, 47303980, 48104120, 47504230, 47604330, 46904400, 46104260, 46204080 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28343 },
      },
      item = {
        -- Nethekurse's Robe of Contempt
        [127299] = { type = 'transmog' },
      },
    },
  },

  -- Executor Riloth
  [49803620] = {
    npcId = 91727,
    questId = 38411,
    icon = 'monster',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28380 }}, item = {
        -- Bracers of Endless Suffering
        [127323] = { type = 'transmog' },
      }, }, },

  -- Argosh the Destroyer
  [52604020] = {
    npcId = 91871,
    questId = 38430,
    icon = 'monster',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28722 },
      },
      item = {
        -- Fel Destroyer Crossbow
        [127326] = { type = 'transmog' },
      },
    },
  },

  -- Relgor
  [26205440] = {
    npcId = 92197,
    questId = 38496,
    icon = 'monster',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28356 },
      },
      item = {
        -- Relgor's Master Glaive
        [127335] = { type = 'transmog' },
      },
    },
  },

  -- Painmistress Selora
  [53602140] = {
    npcId = 92274,
    questId = 38557,
    icon = 'monster',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28342 },
      },
      item = {
        -- Selora's Crown of Thorns
        [127297] = { type = 'transmog' },
      },
    },
  },

  -- Overlord Ma'gruth
  [52401920] = {
    npcId = 92411,
    questId = 38580,
    icon = 'monster',
    note = t['overlord_magruth_note'],
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28729 },
      },
      item = {
        -- Mo'gruth's Discarded Parade Helm
        [127320] = { type = 'transmog' },
      },
    },
  },

  -- Broodlord Ixkor
  [57606720] = {
    npcId = 92429,
    questId = 38589,
    icon = 'monster',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28357 },
      },
    },
  },

  -- Varyx the Damned
  [27403260] = {
    npcId = 92451,
    questId = 37937,
    icon = 'monster',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28340 },
      },
    },
  },

  -- The Blackfang
  [48807300] = {
    npcId = 92465,
    questId = 38597,
    icon = 'monster',
    note = t['in_cave'],
    POI = { 49907440 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28361 },
      },
      item = {
        -- The Black Fang
        [127330] = { type = 'transmog' },
      },
    },
  },

  -- Soulslicer
  [62607220] = {
    npcId = 92495,
    questId = 38600,
    icon = 'monster',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28358 },
      },
      item = {
        -- Glowing Felskull Belt
        [127315] = { type = 'transmog' },
      },
    },
  },

  -- Gloomtalon
  [63208000] = {
    npcId = 92508,
    questId = 38604,
    icon = 'monster',
    note = t['in_cave'],
    POI = { 62207910 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28359 },
      },
      item = {
        -- Gloomtalon's Spare Kilt
        [127306] = { type = 'transmog' },
      },
    },
  },

  -- Krell the Serene
  [52008360] = {
    npcId = 92517,
    questId = 38605,
    icon = 'monster',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28360 },
      },
    },
  },

  -- Thromma the Gutslicer
  [34004440] = {
    npcId = 92574,
    questId = 38620,
    icon = 'monster',
    note = t['in_cave'] .. ' ' .. t['belgork_thromma_note'],
    POI = { 32104900, 38604420 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28362 },
      },
      item = {
        -- Thromma's Gutslicer
        [127327] = { type = 'transmog' },
      },
    },
  },

  -- Sylissa
  [41007880] = {
    npcId = 92606,
    questId = 38628,
    icon = 'monster',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28364 },
      },
      item = {
        -- Serpentine Gloves
        [127311] = { type = 'transmog' },
      },
    },
  },

  -- Rendrak
  [41807590] = {
    npcId = 92627,
    questId = 38631,
    icon = 'monster',
    note = t['rendrak_note'],
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28365 },
      },
    },
  },

  -- The Night Haunter
  [39407590] = {
    npcId = 92636,
    questId = 38632,
    icon = 'monster',
    note = t['the_night_haunter_note'],
    -- The Night Haunter
    POI = {
      38507890, 38407230, 42407760, 40607290, 41206890, 38807510,
      42407740, 40607750, 38007930, 38807520, 44307220, 38307210
    },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28366 },
      },
    },
  },

  -- Bleeding Hollow Horror
  [50807440] = {
    npcId = 92657,
    questId = 38696,
    icon = 'monster',
    note = t['in_cave'],
    POI = { 44507750 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28376 },
      },
    },
  },

  -- The Goreclaw
  [34407260] = {
    npcId = 92694,
    questId = 38654,
    icon = 'monster',
    note = t['in_cave'],
    POI = { 36307220 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28367 },
      },
      item = {
        -- Frayed Hunting Cowl
        [127305] = { type = 'transmog' },
      },
    },
  },

  -- Steelsnout
  [65603680] = {
    npcId = 92887,
    questId = 38700,
    icon = 'monster',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28344 },
      },
    },
  },

  -- Gorabosh
  [33203580] = {
    npcId = 92941,
    questId = 38709,
    icon = 'monster',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28368 },
      },
      item = {
        -- Cave Keeper Wraps
        [127304] = { type = 'transmog' },
      },
    },
  },

  -- The Iron Houndmaster
  [12605690] = {
    npcId = 92977,
    questId = 38751,
    icon = 'monster',
    note = t['the_iron_houndmaster_note'],
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28350 },
      },
      item = {
        -- Iron Houndmaster's Pauldrons
        [127321] = { type = 'transmog' },
      },
    },
  },

  -- Szirek the Twisted
  [15705750] = {
    npcId = 93001,
    questId = 38752,
    icon = 'monster',
    note = t['szirek_the_twisted_note'],
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28349 },
      },
      item = {
        -- Twisted Taboo Handwraps
        [127296] = { type = 'transmog' },
      },
    },
  },

  -- Magwia
  [52206520] = {
    npcId = 93002,
    questId = 38726,
    icon = 'monster',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28345 },
      },
      item = {
        -- Riverbeast Molar Club
        [127332] = { type = 'transmog' },
      },
    },
  },

  -- Driss Vile
  [20005380] = {
    npcId = 93028,
    questId = 38736,
    icon = 'monster',
    note = t['driss_vile_note'],
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28369 },
      },
      item = {
        -- Double-Scoped Long Rifle
        [127331] = { type = 'transmog' },
      },
    },
  },

  -- Grannok
  [16005920] = {
    npcId = 93057,
    questId = 38750,
    icon = 'monster',
    note = t['grannok_note'],
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28348 },
      },
    },
  },

  -- Glub'glok
  [34607800] = {
    npcId = 93125,
    questId = 38764,
    icon = 'monster',
    note = t['in_cave'],
    POI = { 37507600 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28371 },
      },
      item = {
        -- Murktide's Coveted Chestplate
        [127317] = { type = 'transmog' },
      },
    },
  },

  -- Felbore
  [28805100] = {
    npcId = 93168,
    questId = 38775,
    icon = 'monster',
    POI = { 31005330 },
    note = t['in_cave'],
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28372 },
      },
    },
  },

  -- Shadowthrash
  [49606100] = {
    npcId = 93236,
    questId = 38812,
    icon = 'monster',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28725 },
      },
      item = {
        -- Warpscaled Wristwraps
        [127665] = { type = 'transmog' },
      },
    },
  },

  -- Captain Grok'mar
  [48605720] = {
    npcId = 93264,
    questId = 38820,
    icon = 'monster',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28730 },
      },
      item = {
        -- Grokmar's Greaves of Fortification
        [127664] = { type = 'transmog' },
      },
    },
  },

  -- Kris'kar the Unredeemed
  [39606820] = {
    npcId = 93279,
    questId = 38825,
    icon = 'monster',
    note = t['in_cave'],
    POI = { 42306880 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28377 },
      },
      item = {
        -- Wingblade of Reckoning
        [127653] = { type = 'transmog' },
      },
    },
  },

  -- Drakum
  [83604360] = {
    npcId = 98283,
    questId = 40105,
    icon = 'monster',
    note = t['iron_armada_note'],
    loot = {
      item = {
        -- Crashin' Thrashin' Roller Controller
        [108631] = { type = 'toy' },
      },
    },
  },

  -- Gondar
  [80605640] = {
    npcId = 98284,
    questId = 40106,
    icon = 'monster',
    note = t['iron_armada_note'],
    loot = {
      item = {
        -- Crashin' Thrashin' Cannon Controller
        [108633] = { type = 'toy' },
      },
    },
  },

  -- Smashum Grabb
  [88005580] = {
    npcId = 98285,
    questId = 40104,
    icon = 'monster',
    note = t['iron_armada_note'],
    loot = {
      item = {
        -- Crashin' Thrashin' Mortar Controller
        [108634] = { type = 'toy' },
      },
    },
  },

  -- Xanzith the Everlasting
  [60002100] = {
    npcId = 92408,
    questId = 38579,
    icon = 'monster',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28728 },
      },
      item = {
        -- Equipment Blueprint: High Intensity Fog Lights
        [128232] = { questId = 39356 },
        -- Eye of the Beholder
        [127658] = { type = 'transmog', subtype = t['off-hand'] },
      },
    },
  },

  -- Zoug the Heavy
  [37003300] = {
    npcId = 90122,
    questId = 39045,
    icon = 'monster',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28723 },
      },
      item = {
        -- Equipment Blueprint: True Iron Rudder
        [128252] = { questId = 39360 },
        -- Zoug's Lifting Belt
        [127308] = { type = 'transmog' },
      },
    },
  },

  -- Cindral the Wildfire
  [44603760] = {
    npcId = 90519,
    questId = 37990,
    icon = 'monster',
    note = t['in_cave'],
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28338 },
      },
      item = {
        -- Equipment Blueprint: Ice Cutter
        [128255] = { questId = 39363 },
      },
    },
  },

  -- Belgork
  [34904710] = {
    npcId = 92552,
    questId = 38609,
    icon = 'monster',
    note = t['in_cave'] .. ' ' .. t['belgork_thromma_note'],
    POI = { 32104900, 38604420 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28363 },
      },
      item = {
        -- Equipment Blueprint: Bilge Pump
        [126950] = { questId = 38932 },
        -- Belgork's Bastion
        [127650] = { type = 'transmog' },
      },
    },
  },

  -- Felsmith Damorka
  [45804700] = {
    npcId = 92647,
    questId = 38634,
    icon = 'monster',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28726 },
      },
      item = {
        -- Equipment Blueprint: Felsmoke Launchers
        [128258] = { questId = 39366 },
        -- Chemical Resistant Apron
        [127302] = { type = 'transmog' },
      },
    },
  },

  -- Captain Ironbeard
  [35607990] = {
    npcId = 93076,
    questId = 38756,
    icon = 'monster',
    note = t['in_cave'],
    POI = { 37507600 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28370 },
      },
      item = {
        -- Equipment Blueprint: Ghostly Spyglass
        [128257] = { questId = 39365 },
        -- Ghostly Iron Buccaneer's Hat
        [127659] = { type = 'toy' },
      },
    },
  },

  -- Akrrilo
  [53908080] = {
    npcId = 92766,
    questId = 39399,
    icon = 'monster',
    requirement = {
      item = {
        -- Minor Blackfang Challenge Totem
        [124093] = { },
      },
    },
    note = t['akrrilo_note'],
    -- Vendor
    POI = { 55207480 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28373 },
      },
    },
  },

  -- Rendarr
  [54408130] = {
    npcId = 92817,
    questId = 39400,
    icon = 'monster',
    requirement = {
      item = {
        -- Major Blackfang Challenge Totem
        [124094] = { },
      },
    },
    note = t['rendarr_note'],
    -- Vendor
    POI = { 55207480 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28374 },
      },
    },
  },

  -- Eyepiercer
  [54408040] = {
    npcId = 92819,
    questId = 39379,
    icon = 'monster',
    requirement = {
      item = {
        -- Prime Blackfang Challenge Totem
        [124095] = { },
      }
    },
    note = t['eyepiercer_note'],
    -- Vendor
    POI = { 55207480 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10070] = { criteriaId = 28375 },
      },
    },
  },

  -- Terrorfist
  [13405960] = {
    npcId = 95044,
    questId = 39288,
    icon = 'monster',
    note = t['terrorfist_note'],
    path = { 13405960, 13806020, 14206060, 14406180, 14606280, 15206360, 15806380 },
    loot = {
      achievement = {
        -- Hellbane
        [10061] = { criteriaId = 28221 },
      },
      item = {
        -- Medallion of the Legion
        [128315] = { },
        -- Rattling Iron Cage
        [128025] = { },
        -- Tundra Icehoof
        [116658] = { mountId = 611 },
        -- Armored Razorback
        [116669] = { mountId = 622 },
        -- Warsong Direfang
        [116780] = { mountId = 643 },
      },
    },
  },

  -- Deathtalon
  [23004020] = {
    npcId = 95053,
    questId = 39287,
    icon = 'monster',
    note = t['deathtalon_note'],
    loot = {
      achievement = {
        -- Hellbane
        [10061] = { criteriaId = 28220 },
      },
      item = {
        -- Medallion of the Legion
        [128315] = { },
        -- Rattling Iron Cage
        [128025] = { },
        -- Tundra Icehoof
        [116658] = { mountId = 611 },
        -- Armored Razorback
        [116669] = { mountId = 622 },
        -- Warsong Direfang
        [116780] = { mountId = 643 },
      },
    },
  },

  -- Vengeance
  [32607400] = {
    npcId = 95054,
    questId = 39290,
    icon = 'monster',
    note = t['vengeance_note'],
    loot = {
      achievement = {
        -- Hellbane
        [10061] = { criteriaId = 28219 },
      },
      item = {
        -- Medallion of the Legion
        [128315] = { },
        -- Rattling Iron Cage
        [128025] = { },
        -- Tundra Icehoof
        [116658] = { mountId = 611 },
        -- Armored Razorback
        [116669] = { mountId = 622 },
        -- Warsong Direfang
        [116780] = { mountId = 643 },
      },
    },
  },

  -- Doomroller
  [47005260] = {
    npcId = 95056,
    questId = 39289,
    icon = 'monster',
    note = t['doomroller_note'],
    loot = {
      achievement = {
        -- Hellbane
        [10061] = { criteriaId = 28218 },
      },
      item = {
        -- Medallion of the Legion
        [128315] = { },
        -- Rattling Iron Cage
        [128025] = { },
        -- Tundra Icehoof
        [116658] = { mountId = 611 },
        -- Armored Razorback
        [116669] = { mountId = 622 },
        -- Warsong Direfang
        [116780] = { mountId = 643 },
      },
    },
  },

  -- Xemirkol
  [69603820] = {
    npcId = 96235,
    icon = 'monster',
    POI = { XemirkolVendor },
    requirement = {
      -- Jungle Stalker
      achievement = { 10070 },
      reputation = {
        -- Order of the Awakened (Exalted)
        [1849] = { level = 8 },

      },
    },
    note = t['xemirkol_note'],
    loot = {
      achievement = {
        -- Predator
        [10334] = { },
      }
    },
  },

  --- Treasures
  -- Strange Sapphire
  [36304340] = {
    questId = 37956,
    name = t['strange_sapphire_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true }
      },
      item = {
        -- Splendid Skettis Sapphire
        [127397] = { subtype = t['trinket'] },
      },
    },
  },

  -- Weathered Axe
  [15904970] = {
    questId = 38208,
    name = t['weathered_axe_treasure'],
    icon = 'chest',
    note = t['in_cave'],
    POI = { 17105080 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Weathered Memento Axe
        [127324] = { type = 'transmog' },
      },
    },
  },

  -- Stolen Captain's Chest
  [17005290] = {
    questId = 38283,
    name = t['stolen_captains_chest_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
    },
  },

  -- The Blade of Kra'nak
  [19304090] = {
    questId = 38320,
    name = t['the_blade_of_kranak_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Guardian Swiftblade of Kra'nak
        [127338] = { type = 'transmog' },
      },
    },
  },

  -- Jewel of Hellfire
  [28702330] = {
    questId = 38334,
    name = t['jewel_of_hellfire_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Jewel of Hellfire
        [127668] = { type = 'toy' },
      },
    },
  },

  -- Tome of Secrets
  [32407050] = {
    questId = 38426,
    name = t['tome_of_secrets_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Accursed Tome of the Sargerei
        [127670] = { type = 'toy' },
      },
    },
  },

  -- Forgotten Sack
  [56906510] = {
    questId = 38591,
    name = t['forgotten_sack_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
    },
  },

  -- Lodged Hunting Spear
  [54806930] = {
    questId = 38593,
    name = t['lodged_hunting_spear_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Ravager Hunting Spear
        [127334] = { type = 'transmog' },
      },
    },
  },

  -- Blackfang Island Cache
  [61207570] = {
    questId = 38601,
    name = t['blackfang_island_cache_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
    },
  },

  -- Crystallized Fel Spike
  [62007080] = {
    questId = 38602,
    name = t['crystallized_fel_spike_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Fel Shard
        [128217] = { subtype = t['trinket'] },
      },
    },
  },

  -- Polished Crystal
  [30507200] = {
    questId = 38629,
    name = t['polished_crystal_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Polished Crystal
        [127389] = { },
      },
    },
  },

  -- Snake Charmer's Flute
  [40607980] = {
    questId = 38638,
    name = t['snake_charmers_flute_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Ogra'mal Snake Charming Flute
        [127333] = { type = 'transmog' },
      },
    },
  },

  -- The Perfect Blossom
  [40807550] = {
    questId = 38639,
    name = t['the_perfect_blossom_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- The Perfect Blossom
        [127766] = { type = 'toy' },
      },
    },
  },

  -- Pale Removal Equipment
  [37104620] = {
    questId = 38640,
    name = t['pale_removal_equipment_treasure'],
    icon = 'chest',
    note = t['in_cave'],
    POI = { 38604420 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
    },
  },

  -- Forgotten Champion's Blade
  [41507340] = {
    questId = 38657,
    name = t['forgotten_champions_blade_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Forgotten Champion's Blade
        [127339] = { type = 'transmog' },
      },
    },
  },

  -- Bleeding Hollow Warchest
  [20004780] = {
    questId = 38678,
    name = t['bleeding_hollow_warchest_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
    },
  },

  -- Jewel of the Fallen Star
  [58502540] = {
    questId = 38679,
    name = t['jewel_of_the_fallen_star_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
    },
  },

  -- Censer of Torment
  [62502060] = {
    questId = 38682,
    name = t['censer_of_torment_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Tormented Skull
        [127401] = { subtype = t['trinket'] },
      },
    },
  },

  -- Looted Bleeding Hollow Treasure
  [26804420] = {
    questId = 38683,
    name = t['looted_bleeding_hollow_treasure_treasure'],
    icon = 'chest',
    requirement = {
      quest = {
        [RequiredQuests['bleeding hollow']] = { },
      },
    },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Throbbing Blood Orb
        [127709] = { type = 'toy' },
      },
    },
  },

  -- Rune Etched Femur
  [51802430] = {
    questId = 38686,
    name = t['rune_etched_femur_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Rune-Etched Femur
        [127341] = { type = 'transmog' },
      },
    },
  },

  -- Strange Fruit
  [64504210] = {
    questId = 38701,
    name = t['strange_fruit_treasure'],
    icon = 'chest',
    note = t['strange_fruit_note'],
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Strange Fruit
        [127396] = { },
        -- Podling Camouflage
        [127394] = { type = 'toy' },
      },
    },
  },

  -- Discarded Helm
  [50008120] = {
    questId = 38702,
    name = t['discarded_helm_treasure'],
    icon = 'chest',
    note = t['in_cave'],
    POI = { 51207960 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Fallen Adventurer's Helm
        [127312] = { type = 'transmog' },
      },
    },
  },

  -- Scout's Belongings
  [50007970] = {
    questId = 38703,
    name = t['scouts_belongings_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Scout's Spy Cloak
        [127354] = { type = 'transmog' },
      },
    },
  },

  -- Forgotten Iron Horde Supplies
  [69705600] = {
    questId = 38704,
    name = t['forgotten_iron_horde_supplies_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
    },
  },

  -- Crystallized Essence of the Elements
  [48007040] = {
    questId = 38705,
    name = t['crystallized_essence_of_the_elements_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Element-Infused Knuckles
        [127329] = { type = 'transmog' },
      },
    },
  },

  -- Overgrown Relic
  [50906490] = {
    questId = 38731,
    name = t['overgrown_relic_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Luminous Relic Ring
        [127412] = { subtype = t['ring'] },
      },
    },
  },

  -- Jeweled Arakkoa Effigy
  [31503110] = {
    questId = 38732,
    name = t['jeweled_arakkoa_effigy_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Jeweled Arakkoa Effigy
        [127413] = { },
      },
    },
  },

  -- 'Borrowed' Enchanted Spyglass
  [25305020] = {
    questId = 38735,
    name = t['borrowed_enchanted_spyglass_treasure'],
    icon = 'chest',
    note = t['tower_chest_note'],
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Smokeglass Lens Spyglass
        [128222] = { subtype = t['trinket'] },
      },
    },
  },

  -- Mysterious Corrupted Obelisk
  [46307270] = {
    questId = 38739,
    name = t['mysterious_corrupted_obelist_treasure'],
    icon = 'chest',
    note = t['in_cave'],
    POI = { 47307070 },
    requirement = {
      quest = {
        [RequiredQuests['cipher of damnation']] = { },
      },
    },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Corrupted Primal Obelisk
        [128320] = { },
      },
    },
  },

  -- Forgotten Shard of the Cipher
  [63302810] = {
    questId = 38740,
    name = t['forgotten_shard_of_the_cipher_treasure'],
    icon = 'chest',
    requirement = {
      quest = {
        [RequiredQuests['cipher of damnation']] = { },
      },
    },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Shard of Cyrukh
        [128309] = { petId = 1690 },
      },
    },
  },

  -- Looted Bleeding Hollow Treasure
  [26506290] = {
    questId = 38741,
    name = t['looted_bleeding_hollow_treasure_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
    },
  },

  -- Skull of the Mad Chief
  [34703470] = {
    questId = 38742,
    name = t['skull_of_the_mad_chief_treasure'],
    icon = 'chest',
    note = t['in_cave'],
    POI = { 32503730 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Skull of the Mad Chief
        [127669] = { type = 'toy' },
      },
    },
  },

  -- Axe of the Weeping Wolf
  [15505440] = {
    questId = 38754,
    name = t['axe_of_the_weeping_wolf_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Axe of the Weeping Wolf
        [127325] = { type = 'transmog' },
      },
    },
  },

  -- Spoils of War
  [17305700] = {
    questId = 38755,
    name = t['spoils_of_war_treasure'],
    icon = 'chest',
    note = t['spoils_of_war_note'],
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
    },
  },

  -- The Eye of Grannok
  [16005940] = {
    questId = 38757,
    name = t['the_eye_of_grannok_treasure'],
    icon = 'chest',
    note = t['the_eye_of_grannok_note'],
    POI = { 16405860 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Grannok's Lidless Eye
        [128220] = { subtype = t['trinket'] },
      },
    },
  },

  -- Ironbeard's Treasure
  [35907860] = {
    questId = 38758,
    name = t['ironbeards_treasure_treasure'],
    icon = 'chest',
    note = t['in_cave'],
    POI = { 37607590 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
    },
  },

  -- Stashed Iron Sea Booty
  [33907810] = {
    questId = 38760,
    name = t['stashed_iron_sea_booty_treasure'],
    icon = 'chest',
    note = t['in_cave'],
    POI = { 37607590 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
    },
  },

  -- Stashed Iron Sea Booty
  [35007720] = {
    questId = 38761,
    name = t['stashed_iron_sea_booty_treasure'],
    icon = 'chest',
    note = t['in_cave'],
    POI = { 37607590 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
    },
  },

  -- Stashed Iron Sea Booty
  [34507830] = {
    questId = 38762,
    name = t['stashed_iron_sea_booty_treasure'],
    icon = 'chest',
    note = t['in_cave'],
    POI = { 37607590 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
    },
  },

  -- Book of Zyzzix
  [46903670] = {
    questId = 38771,
    name = t['book_of_zyzzix_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Resonating Tome of Zyzzix
        [127347] = { type = 'transmog' },
      },
    },
  },

  -- Fel-Drenched Satchel
  [46904440] = {
    questId = 38773,
    name = t['fel_drenched_satchel_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Fel-Proof Goggles
        [128218] = { type = 'transmog' },
      },
    },
  },

  -- Sacrificial Blade
  [46804210] = {
    questId = 38776,
    name = t['sacrificial_blade_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Feltwisted Sacrificial Blade
        [127328] = { type = 'transmog' },
      },
    },
  },

  -- Stashed Bleeding Hollow Loot
  [73604320] = {
    questId = 38779,
    name = t['stashed_bleeding_hollow_loot_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
    },
  },

  -- Brazier of Awakening
  [37808080] = {
    questId = 38788,
    name = t['brazier_of_awakening_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Brazier of Awakening
        [127770] = { },
      },
    },
  },

  -- Bleeding Hollow Mushroom Stash
  [49907680] = {
    questId = 38809,
    name = t['bleeding_hollow_mushroom_stash_treasure'],
    icon = 'chest',
    note = t['in_cave'],
    POI = { 44607750 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Bottomless Stygana Mushroom Brew
        [128223] = { type = 'toy' },
      },
    },
  },

  -- Looted Mystical Staff
  [48607530] = {
    questId = 38814,
    name = t['looted_mystical_staff_treasure'],
    icon = 'chest',
    note = t['in_cave'],
    POI = { 44607750 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Emanating Staff of Shadow
        [127337] = { type = 'transmog' },
      },
    },
  },

  -- The Commander's Shield
  [43203830] = {
    questId = 38821,
    name = t['the_commanders_shield_treasure'],
    icon = 'chest',
    note = t['the_commanders_shield_note'],
    POI = { 42203780 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Commander's Citadel Shield
        [127348] = { type = 'transmog' },
      },
    },
  },

  -- Dazzling Rod
  [42903530] = {
    questId = 38822,
    name = t['dazzling_rod_treasure'],
    icon = 'chest',
    note = t['tower_chest_note'],
    POI = { 43003580 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
      item = {
        -- Dazzling Rod
        [127859] = { type = 'toy' },
      },
    },
  },

  -- Partially Mined Apexis Crystal
  [28903460] = {
    questId = 38863,
    name = t['partially_mined_apexis_crystal_treasure'],
    icon = 'chest',
    note = t['in_cave'],
    POI = { 29203460 },
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
    },
  },

  -- Fel-Tainted Apexis Formation
  [51603250] = {
    questId = 39075,
    name = t['fel_tainted_apexis_formation_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
    },
  },

  -- Bejeweled Egg
  [65908500] = {
    questId = 39469,
    name = t['bejeweled_egg_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
    },
  },

  -- Dead Man's Chest
  [55009070] = {
    questId = 39470,
    name = t['dead_mans_chest_treasure'],
    icon = 'chest',
    loot = {
      achievement = {
        -- Jungle Treasure Master
        [10262] = { count = true },
      },
    },
  },

  --- Pet Battles
  -- Felsworn Sentry
  [26103160] = {
    npcId = 94601,
    icon = 'pet',
    note = t['battle_pets_note'],
    loot = {
      achievement = {
        -- Tiny Terrors in Tanaan
        [10052] = { criteriaId = 28796 },
      },
      item = {
        -- Fel-Touched Battle-Training Stone
        [127755] = { },
        -- Zangar Spore
        [118101] = { petId = 1536 },
        -- Seaborne Spore
        [118105] = { petId = 1539 },
        -- Periwinkle Calf
        [127754] = { petId = 1663 },
        -- Nightmare Bell
        [127753] = { petId = 1664 },
      },
    },
  },

  -- Corrupted Thundertail
  [53106520] = {
    npcId = 94637,
    icon = 'pet',
    note = t['battle_pets_note'],
    loot = {
      achievement = {
        -- Tiny Terrors in Tanaan
        [10052] = { criteriaId = 28797 },
      },
      item = {
        -- Fel-Touched Battle-Training Stone
        [127755] = { },
        -- Zangar Spore
        [118101] = { petId = 1536 },
        -- Seaborne Spore
        [118105] = { petId = 1539 },
        -- Periwinkle Calf
        [127754] = { petId = 1663 },
        -- Nightmare Bell
        [127753] = { petId = 1664 },
      },
    },
  },

  -- Chaos Pup
  [25107620] = {
    npcId = 94638,
    icon = 'pet',
    note = t['in_cave'] .. '\n\n' .. t['battle_pets_note'],
    POI = { 29607060 },
    loot = {
      achievement = {
        -- Tiny Terrors in Tanaan
        [10052] = { criteriaId = 28798 },
      },
      item = {
        -- Fel-Touched Battle-Training Stone
        [127755] = { },
        -- Zangar Spore
        [118101] = { petId = 1536 },
        -- Seaborne Spore
        [118105] = { petId = 1539 },
        -- Periwinkle Calf
        [127754] = { petId = 1663 },
        -- Nightmare Bell
        [127753] = { petId = 1664 },
      },
    },
  },

  -- Cursed Spirit
  [31403810] = {
    npcId = 94639,
    icon = 'pet',
    note = t['battle_pets_note'],
    loot = {
      achievement = {
        -- Tiny Terrors in Tanaan
        [10052] = { criteriaId = 28799 },
      },
      item = {
        -- Fel-Touched Battle-Training Stone
        [127755] = { },
        -- Zangar Spore
        [118101] = { petId = 1536 },
        -- Seaborne Spore
        [118105] = { petId = 1539 },
        -- Periwinkle Calf
        [127754] = { petId = 1663 },
        -- Nightmare Bell
        [127753] = { petId = 1664 },
      },
    },
  },

  -- Felfly
  [55908080] = {
    npcId = 94640,
    icon = 'pet',
    note = t['battle_pets_note'],
    loot = {
      achievement = {
        -- Tiny Terrors in Tanaan
        [10052] = { criteriaId = 28800 },
      },
      item = {
        -- Fel-Touched Battle-Training Stone
        [127755] = { },
        -- Zangar Spore
        [118101] = { petId = 1536 },
        -- Seaborne Spore
        [118105] = { petId = 1539 },
        -- Periwinkle Calf
        [127754] = { petId = 1663 },
        -- Nightmare Bell
        [127753] = { petId = 1664 },
      },
    },
  },

  -- Tainted Maulclaw
  [43208450] = {
    npcId = 94641,
    icon = 'pet',
    note = t['battle_pets_note'],
    loot = {
      achievement = {
        -- Tiny Terrors in Tanaan
        [10052] = { criteriaId = 28801 },
      },
      item = {
        -- Fel-Touched Battle-Training Stone
        [127755] = { },
        -- Zangar Spore
        [118101] = { petId = 1536 },
        -- Seaborne Spore
        [118105] = { petId = 1539 },
        -- Periwinkle Calf
        [127754] = { petId = 1663 },
        -- Nightmare Bell
        [127753] = { petId = 1664 },
      },
    },
  },

  -- Direflame
  [57703740] = {
    npcId = 94642,
    icon = 'pet',
    note = t['battle_pets_note'],
    loot = {
      achievement = {
        -- Tiny Terrors in Tanaan
        [10052] = { criteriaId = 28802 },
      },
      item = {
        -- Fel-Touched Battle-Training Stone
        [127755] = { },
        -- Zangar Spore
        [118101] = { petId = 1536 },
        -- Seaborne Spore
        [118105] = { petId = 1539 },
        -- Periwinkle Calf
        [127754] = { petId = 1663 },
        -- Nightmare Bell
        [127753] = { petId = 1664 },
      },
    },
  },

  -- Mirecroak
  [42307180] = {
    npcId = 94643,
    icon = 'pet',
    note = t['battle_pets_note'],
    loot = {
      achievement = {
        -- Tiny Terrors in Tanaan
        [10052] = { criteriaId = 28803 },
      },
      item = {
        -- Fel-Touched Battle-Training Stone
        [127755] = { },
        -- Zangar Spore
        [118101] = { petId = 1536 },
        -- Seaborne Spore
        [118105] = { petId = 1539 },
        -- Periwinkle Calf
        [127754] = { petId = 1663 },
        -- Nightmare Bell
        [127753] = { petId = 1664 },
      },
    },
  },

  -- Dark Gazer
  [54002990] = {
    npcId = 94644,
    icon = 'pet',
    note = t['battle_pets_note'],
    loot = {
      achievement = {
        -- Tiny Terrors in Tanaan
        [10052] = { criteriaId = 28804 },
      },
      item = {
        -- Fel-Touched Battle-Training Stone
        [127755] = { },
        -- Zangar Spore
        [118101] = { petId = 1536 },
        -- Seaborne Spore
        [118105] = { petId = 1539 },
        -- Periwinkle Calf
        [127754] = { petId = 1663 },
        -- Nightmare Bell
        [127753] = { petId = 1664 },
      },
    },
  },

  -- Bleakclaw
  [16004480] = {
    npcId = 94645,
    icon = 'pet',
    note = t['battle_pets_note'],
    loot = {
      achievement = {
        -- Tiny Terrors in Tanaan
        [10052] = { criteriaId = 28805 },
      },
      item = {
        -- Fel-Touched Battle-Training Stone
        [127755] = { },
        -- Zangar Spore
        [118101] = { petId = 1536 },
        -- Seaborne Spore
        [118105] = { petId = 1539 },
        -- Periwinkle Calf
        [127754] = { petId = 1663 },
        -- Nightmare Bell
        [127753] = { petId = 1664 },
      },
    },
  },

  -- Vile Blood of Draenor
  [44004570] = {
    npcId = 94646,
    icon = 'pet',
    note = t['battle_pets_note'],
    loot = {
      achievement = {
        -- Tiny Terrors in Tanaan
        [10052] = { criteriaId = 28806 },
      },
      item = {
        -- Fel-Touched Battle-Training Stone
        [127755] = { },
        -- Zangar Spore
        [118101] = { petId = 1536 },
        -- Seaborne Spore
        [118105] = { petId = 1539 },
        -- Periwinkle Calf
        [127754] = { petId = 1663 },
        -- Nightmare Bell
        [127753] = { petId = 1664 },
      },
    },
  },

  -- Dreadwalker
  [46405300] = {
    npcId = 94647,
    icon = 'pet',
    note = t['battle_pets_note'],
    loot = {
      achievement = {
        -- Tiny Terrors in Tanaan
        [10052] = { criteriaId = 28807 },
      },
      item = {
        -- Fel-Touched Battle-Training Stone
        [127755] = { },
        -- Zangar Spore
        [118101] = { petId = 1536 },
        -- Seaborne Spore
        [118105] = { petId = 1539 },
        -- Periwinkle Calf
        [127754] = { petId = 1663 },
        -- Nightmare Bell
        [127753] = { petId = 1664 },
      },
    },
  },

  -- Netherfist
  [48003500] = {
    npcId = 94648,
    icon = 'pet',
    note = t['battle_pets_note'],
    loot = {
      achievement = {
        -- Tiny Terrors in Tanaan
        [10052] = { criteriaId = 28810 },
      },
      item = {
        -- Fel-Touched Battle-Training Stone
        [127755] = { },
        -- Zangar Spore
        [118101] = { petId = 1536 },
        -- Seaborne Spore
        [118105] = { petId = 1539 },
        -- Periwinkle Calf
        [127754] = { petId = 1663 },
        -- Nightmare Bell
        [127753] = { petId = 1664 },
      },
    },
  },

  -- Skrillix
  [48503130] = {
    npcId = 94649,
    icon = 'pet',
    note = t['battle_pets_note'],
    loot = {
      achievement = {
        -- Tiny Terrors in Tanaan
        [10052] = { criteriaId = 28808 },
      },
      item = {
        -- Fel-Touched Battle-Training Stone
        [127755] = { },
        -- Zangar Spore
        [118101] = { petId = 1536 },
        -- Seaborne Spore
        [118105] = { petId = 1539 },
        -- Periwinkle Calf
        [127754] = { petId = 1663 },
        -- Nightmare Bell
        [127753] = { petId = 1664 },
      },
    },
  },

  -- Defiled Earth
  [75403740] = {
    npcId = 94650,
    icon = 'pet',
    note = t['battle_pets_note'],
    loot = {
      achievement = {
        -- Tiny Terrors in Tanaan
        [10052] = { criteriaId = 28809 },
      },
      item = {
        -- Fel-Touched Battle-Training Stone
        [127755] = { },
        -- Zangar Spore
        [118101] = { petId = 1536 },
        -- Seaborne Spore
        [118105] = { petId = 1539 },
        -- Periwinkle Calf
        [127754] = { petId = 1663 },
        -- Nightmare Bell
        [127753] = { petId = 1664 },
      },
    },
  },
}

this.points[map] = points
