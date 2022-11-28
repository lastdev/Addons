---
--- @file
--- Map point definitions.
---

local _, this = ...

local Player = this.Player
local t = this.t
local map = this.maps['spires_of_arak']

-- Alliance quest IDs for required quests.
local RequiredQuests = {
  -- Assault on Pillars of Fate
  ['pillars of fate'] = 36682,
  -- Assault on Lost Veil Anzu
  ['lost veil anzu'] = 36681,
  -- Assault on Skettis
  ['assault on skettis'] = 36683,
}

-- Horde quest IDs.
if (Player:isHorde() == true) then
  RequiredQuests = {
    -- Assault on Pillars of Fate
    ['pillars of fate'] = 36689,
    -- Assault on Lost Veil Anzu
    ['lost veil anzu'] = 36690,
    -- Assault on Skettis
    ['assault on skettis'] = 36688,
  }
end

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
  [36431830] = Voidtalon,
  [46822021] = Voidtalon,
  [50430631] = Voidtalon,
  [60901122] = Voidtalon,

  -- Shadowbark
  [51803560] = {
    npcId = 79938,
    questId = 36478,
    icon = 'monster',
    loot = {
      item = {
        -- Shadowbark's Shin
        [118201] = { type = 'transmog' },
      },
    },
  },

  -- Nas Dunberlin
  [36205260] = {
    npcId = 82247,
    questId = 36129,
    icon = 'monster',
    loot = {
      item = {
        -- Spooky Scythe
        [116837] = { type = 'transmog' },
      },
    },
  },

  -- Solar Magnifier
  [52000760] = {
    npcId = 83990,
    questId = 37394,
    icon = 'monster',
    loot = {
      item = {
        -- Cloudsplitter Greatstaff
        [119407] = { type = 'transmog' },
      },
    },
  },

  -- Mutafen
  [54208900] = {
    npcId = 84417,
    questId = 36396,
    icon = 'monster',
    loot = {
      item = {
        -- Mutafen's Mighty Maul
        [118206] = { type = 'transmog' },
      },
    },
  },

  -- Tesska the Broken
  [57207380] = {
    npcId = 84775,
    questId = 36254,
    icon = 'monster',
    loot = {
      item = {
        -- Tesska's Cursed Talisman
        [116852] = { subtype = t['neck'] },
      },
    },
  },

  -- Stonespite
  [33602200] = {
    npcId = 84805,
    questId = 36265,
    icon = 'monster',
    loot = {
      item = {
        -- Stonespite Scale Leggings
        [116858] = { type = 'transmog' },
      },
    },
  },

  -- Durkath Steelmaw
  [46402860] = {
    npcId = 84807,
    questId = 36267,
    icon = 'monster',
    loot = {
      item = {
        -- Steelmaw's Stompers
        [118198] = { type = 'transmog' },
      },
    },
  },

  -- Kalos the Bloodbathed
  [62803760] = {
    npcId = 84810,
    questId = 36268,
    icon = 'monster',
    loot = {
      item = {
        -- Bloodbathed Outcast Robes
        [118735] = { type = 'transmog' },
      },
    },
  },

  -- Sangrikass
  [68804900] = {
    npcId = 84833,
    questId = 36276,
    icon = 'monster',
    note = t['sangrikass_note'],
    loot = {
      item = {
        -- Moultingskin Tunic
        [118203] = { type = 'transmog' },
      },
    },
  },

  -- Talonbreaker
  [54606320] = {
    npcId = 84836,
    questId = 36278,
    icon = 'monster',
    loot = {
      item = {
        -- Talonbreaker Talisman
        [116838] = { subtype = t['neck'] },
      },
    },
  },

  -- Poisonmaster Bortusk
  [59603760] = {
    npcId = 84838,
    questId = 36279,
    icon = 'monster',
    loot = {
      item = {
        -- Poison Cask
        [118199] = { subtype = t['trinket'] },
      },
    },
  },

  -- Blightglow
  [64806640] = {
    npcId = 84856,
    questId = 36283,
    icon = 'monster',
    loot = {
      item = {
        -- Blightglow Pauldrons
        [118205] = { type = 'transmog' },
      },
    },
  },

  -- Oskiira the Vengeful
  [65005400] = {
    npcId = 84872,
    questId = 36288,
    icon = 'monster',
    loot = {
      item = {
        -- Oskiira's Mercy
        [118204] = { type = 'transmog' },
      },
    },
  },

  -- Betsi Boombasket
  [58208460] = {
    npcId = 84887,
    questId = 36291,
    icon = 'monster',
    loot = {
      item = {
        -- Betsi's Boomstick
        [116907] = { type = 'transmog' },
      },
    },
  },

  -- Festerbloom
  [54803960] = {
    npcId = 84890,
    questId = 36297,
    icon = 'monster',
    loot = {
      item = {
        -- Vile Branch of Festerbloom
        [118200] = { type = 'transmog', subtype = t['off-hand'] },
      },
    },
  },

  -- Sunderthorn
  [58604500] = {
    npcId = 84912,
    questId = 36298,
    icon = 'monster',
    note = t['sunderthorn_note'],
    loot = {
      item = {
        -- Stingtail's Toxic Stinger
        [116855] = { type = 'transmog' },
      },
    },
  },

  -- Jiasska the Sporegorger
  [56609460] = {
    npcId = 84955,
    questId = 36306,
    icon = 'monster',
    loot = {
      item = {
        -- Fungus-Infected Hydra Lung
        [118202] = { subtype = t['trinket'] },
      },
    },
  },

  -- Rotcap
  [38402740] = {
    npcId = 85504,
    questId = 36470,
    icon = 'monster',
    loot = {
      item = {
        -- Brilliant Spore
        [118107] = { petId = 1540 },
      },
    },
  },

  -- Swarmleaf
  [52805480] = {
    npcId = 85520,
    questId = 36472,
    icon = 'monster',
    loot = {
      item = {
        -- Stave of Buzzing Bark
        [116857] = { type = 'transmog' },
      },
    },
  },

  -- Hermit Palefur
  [59201500] = {
    npcId = 86724,
    questId = 36887,
    icon = 'monster',
    loot = {
      item = {
        -- Hermit's Hood
        [118279] = { type = 'transmog' },
      },
    },
  },

  -- Gaze
  [25202420] = {
    npcId = 86978,
    questId = 36943,
    icon = 'monster',
    note = t['gaze_note'],
    loot = {
      item = {
        -- Eye of Gaze
        [118696] = { subtype = t['ring'] },
      },
    },
  },

  -- Gluttonous Giant
  [74604360] = {
    npcId = 87019,
    questId = 37390,
    icon = 'monster',
    note = t['king_of_monsters_note'] .. '\n\n' .. t['missive'],
    requirement = {
      quest = {
        [RequiredQuests['lost veil anzu']] = { state = 'active' },
      },
    },
    loot = {
      achievement = {
        -- King of the Monsters
        [9601] = { criteriaId = 27426 },
      },
      item = {
        -- Glowing Morel
        [119404] = { type = 'transmog' },
      },
    },
  },

  -- Shadow Hulk
  [71203320] = {
    npcId = 87027,
    questId = 37392,
    icon = 'monster',
    note = t['in_cave'] .. '\n\n' .. t['king_of_monsters_note'] .. '\n\n' .. t['missive'],
    POI = { 73303470 },
    requirement = {
      quest = {
        [RequiredQuests['lost veil anzu']] = { state = 'active' },
      },
    },
    loot = {
      achievement = {
        -- King of the Monsters
        [9601] = { criteriaId = 27428 },
      },
      item = {
        -- Stretchy Purple Pants
        [119363] = { type = 'transmog' },
      },
    },
  },

  -- Morphed Sentient
  [73604500] = {
    npcId = 86621,
    questId = 37493,
    icon = 'monster',
    note = t['king_of_monsters_note'] .. '\n\n' .. t['missive'],
    requirement = {
      quest = {
        [RequiredQuests['lost veil anzu']] = { state = 'active' },
      },
    },
    loot = {
      achievement = {
        -- King of the Monsters
        [9601] = { criteriaId = 26368 },
      },
    },
  },

  -- Giga Sentinel
  [71604480] = {
    npcId = 87029,
    questId = 37393,
    icon = 'monster',
    note = t['king_of_monsters_note'] .. '\n\n' .. t['missive'],
    requirement = {
      quest = {
        [RequiredQuests['lost veil anzu']] = { state = 'active' },
      },
    },
    loot = {
      achievement = {
        -- King of the Monsters
        [9601] = { criteriaId = 27429 },
      },
      item = {
        -- Sentinel's Wingblade
        [119401] = { type = 'transmog' },
      },
    },
  },

  -- Mecha Plunderer
  [74403880] = {
    npcId = 87026,
    questId = 37391,
    icon = 'monster',
    note = t['king_of_monsters_note'] .. '\n\n' .. t['missive'],
    requirement = {
      quest = {
        [RequiredQuests['lost veil anzu']] = { state = 'active' },
      },
    },
    loot = {
      achievement = {
        -- King of the Monsters
        [9601] = { criteriaId = 27427 },
      },
      item = {
        -- Plunderer's Drill
        [119398] = { type = 'transmog' },
      },
    },
  },

  -- Voidreaver Urnae
  [74803250] = {
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

  -- Malgosh Shadowkeeper
  [72602450] = {
    npcId = 85451,
    questId = 37357,
    icon = 'monster',
    POI = { 72102690 },
    note = t['in_cave'] .. '\n\n' .. t['malgosh_shadowkeeper_note'],
    loot = {
      item = {
        -- Malgosh's Coif
        [119369] = { type = 'transmog' },
      },
    },
  },

  -- Formless Nightmare
  [72601940] = {
    npcId = 85036,
    questId = 37360,
    icon = 'monster',
    POI = { 72302360 },
    note = t['void_portal'] .. '\n\n' .. t['missive'],
    requirement = {
      quest = {
        [RequiredQuests['pillars of fate']] = { state = 'active' },
      },
    },
    loot = {
      item = {
        -- Nightmare-Chain Bracers
        [119373] = { type = 'transmog' },
      },
    },
  },

  -- Kenos the Unraveler
  [70502410] = {
    npcId = 85037,
    questId = 37361,
    icon = 'monster',
    POI = { 72302360 },
    note = t['void_portal'] .. '\n\n' .. t['kenos_unraveler_note'] .. '\n\n' .. t['missive'],
    requirement = {
      quest = {
        [RequiredQuests['pillars of fate']] = { state = 'active' },
      },
    },
    loot = {
      -- A-VOID-ance
      achievement = {
        [9433] = { },
      },
      item = {
        -- Cowl of the Unraveller
        [119354] = { type = 'transmog' },
      },
    },
  },

  -- Soul-Twister Torek
  [72601960] = {
    npcId = 85026,
    questId = 37358,
    icon = 'monster',
    loot = {
      item = {
        -- Black Whirlwind
        [119178] = { type = 'toy' },
        -- Soultwisting Staff
        [119410] = { type = 'transmog' },
      },
    },
  },

  -- Varasha
  [29604200] = {
    npcId = 82050,
    questId = 35334,
    icon = 'monster',
    note = t['in_cave'] .. t['varasha_note'],
    POI = { 31504330 },
    loot = {
      item = {
        -- Hydraling
        [118207] = { petId = 1541 },
      },
    },
  },

  --- Treasures
  -- Outcast's Belongings
  [36801710] = {
    name = t['outcasts_belongings_title'],
    questId = 36243,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Ephial's Dark Grimoire
  [36405780] = {
    name = t['ephials_dark_grimoire_title'],
    questId = 36418,
    icon = 'chest',
    note = t['ephials_dark_grimoire_note'],
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Ephial's Grimoire
        [116914] = { type = 'transmog', subtype = t['off-hand'] },
      },
    },
  },

  -- Garrison Supplies
  [37204750] = {
    name = t['garrison_supplies_title'],
    questId = 36420,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Orcish Signaling Horn
  [36303930] = {
    name = t['orcish_signaling_horn_title'],
    questId = 36402,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Novice Rylak Hunter's Horn
        [120337] = { subtype = t['trinket'] },
      },
    },
  },

  -- Sun-Touched Cache
  [34102750] = {
    name = t['sun-touched_cache_title'],
    questId = 36421,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Outcast's Belongings
  [42202170] = {
    name = t['outcasts_belongings_title'],
    questId = 36447,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Shattered Hand Lockbox
  [47903070] = {
    name = t['shattered_hand_lockbox_title'],
    questId = 36361,
    icon = 'chest',
    note = t['tent_note'],
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- True Steel Lockbox
        [116920] = { },
      },
    },
  },

  -- Outcast's Pouch
  [46903400] = {
    name = t['outcasts_pouch_title'],
    questId = 36446,
    icon = 'chest',
    note = t['outcasts_pouch_note'],
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Lost Ring
  [47803610] = {
    name = t['lost_ring_title'],
    questId = 36411,
    icon = 'chest',
    note = t['lost_ring_note'],
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Outcast Decoder Ring
        [116911] = { subtype = t['ring'] },
      },
    },
  },

  -- Assassin's Spear
  [49203720] = {
    name = t['assassins_spear_title'],
    questId = 36445,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Assassin's Spear
        [116835] = { type = 'transmog' },
      },
    },
  },

  -- Toxicfang Venom
  [54303250] = {
    name = t['toxicfang_venom_title'],
    questId = 36364,
    icon = 'chest',
    note = t['toxicfang_venom_note'],
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Toxicfang Venom
        [118695] = { },
      },
    },
  },

  -- Shattered Hand Cache
  [56202880] = {
    name = t['shattered_hand_cache_title'],
    questId = 36362,
    icon = 'chest',
    note = t['tent_note'],
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Iron Horde Explosives
  [50302580] = {
    name = t['iron_horde_explosives_title'],
    questId = 36444,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Lost Herb Satchel
  [50802870] = {
    name = t['lost_herb_satchel_title'],
    questId = 36247,
    icon = 'chest',
    note = t['lost_herb_satchel_note'],
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Fractured Sunstone
  [50502210] = {
    name = t['fractured_sunstone_title'],
    questId = 36246,
    icon = 'chest',
    note = t['fractured_sunstone_note'],
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Garrison Workman's Hammer
  [41905040] = {
    name = t['garrison_workmans_hammer_title'],
    questId = 36451,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Garrison Workman's Hammer
        [116918] = { type = 'transmog' },
      },
    },
  },

  -- Admiral Taylor's Coffer
  [36205450] = {
    name = t['admiral_taylors_coffer_title'],
    questId = 36462,
    icon = 'chest',
    note = t['admiral_taylors_coffer_note'],
    POI = { 37705630 },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Rooby's Roo
  [37305070] = {
    name = t['roobys_roo_title'],
    questId = 36657,
    icon = 'chest',
    note = t['roobys_roo_note'],
    POI = { 37705130 },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Rooby Roo's Ruby Rollar
        [116887] = { subtype = t['neck'] },
      },
    },
  },

  -- Abandoned Mining Pick
  [40605500] = {
    name = t['abandoned_mining_pick_title'],
    questId = 36458,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Peon's Mining Pick
        [116913] = { type = 'transmog' },
      },
    },
  },

  -- Ogron Plunder
  [58706020] = {
    name = t['ogron_plunder_title'],
    questId = 36340,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Mysterious Mushrooms
  [63606740] = {
    name = t['mysterious_mushrooms_title'],
    questId = 36454,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Starflower
        [109127] = { },
      },
    },
  },

  -- Waterlogged Satchel
  [66505650] = {
    name = t['waterlogged_satchel_title'],
    questId = 36455,
    icon = 'chest',
    note = t['waterlogged_satchel_note'],
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Sethekk Idol
  [68303890] = {
    name = t['sethekk_idol_title'],
    questId = 36375,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Sethekk Ritual Brew
  [71604860] = {
    name = t['sethekk_ritual_brew_title'],
    questId = 36450,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Spray-O-Matic 5000 XT
  [59608130] = {
    name = t['spray-o-matic_5000_xt_title'],
    questId = 36365,
    icon = 'chest',
    note = t['spray-o-matic_5000_xt_note'],
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Shredder Parts
  [60908460] = {
    name = t['shredder_parts_title'],
    questId = 36456,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Coinbender's Payment
  [68408900] = {
    name = t['coinbenders_payment_title'],
    questId = 36453,
    icon = 'chest',
    note = t['coinbenders_payment_note'],
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Sailor Zazzuk's 180-Proof Rum
  [59209060] = {
    name = t['sailor_zazzuks_180-proof_rum_title'],
    questId = 36366,
    icon = 'chest',
    note = t['sailor_zazzuks_180-proof_rum_note'],
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Campaign Contributions
  [55509080] = {
    name = t['campaign_contributions_title'],
    questId = 36367,
    icon = 'chest',
    note = t['campaign_contributions_note'],
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Rukhmar's Image
  [44301200] = {
    npcId = 85206,
    questId = 36377,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Offering to the Raven Mother
  [48405260] = {
    name = t['offering_to_the_raven_mother_title'],
    questId = 36405,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Ravenmother Offering
        [118267] = { },
      },
    },
  },

  -- Offering to the Raven Mother
  [48905470] = {
    name = t['offering_to_the_raven_mother_title'],
    questId = 36406,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Ravenmother Offering
        [118267] = { },
      },
    },
  },

  -- Offering to the Raven Mother
  [51906460] = {
    name = t['offering_to_the_raven_mother_title'],
    questId = 36407,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Ravenmother Offering
        [118267] = { },
      },
    },
  },

  -- Offering to the Raven Mother
  [53305550] = {
    name = t['offering_to_the_raven_mother_title'],
    questId = 36403,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Ravenmother Offering
        [118267] = { },
      },
    },
  },

  -- Offering to the Raven Mother
  [61006390] = {
    name = t['offering_to_the_raven_mother_title'],
    questId = 36410,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Ravenmother Offering
        [118267] = { },
      },
    },
  },

  -- Gift of Anzu
  [61105540] = {
    npcId = 86941,
    questId = 36381,
    icon = 'chest',
    note = t['gift_of_anzu_note'],
    POI = { 53108450, 69204350, 55602210, 48906250, 43802470, 43901500 },
    requirement = {
      item = {
        -- Elixir of Shadow Sight
        [115463] = { },
      },
    },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Anzu's Scything Talon
        [118240] = { },
      },
    },
  },

  -- Gift of Anzu
  [42402670] = {
    npcId = 86953,
    questId = 36388,
    icon = 'chest',
    note = t['gift_of_anzu_note'],
    POI = { 53108450, 69204350, 55602210, 48906250, 43802470, 43901500 },
    requirement = {
      item = {
        -- Elixir of Shadow Sight
        [115463] = { },
      },
    },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Anzu's Scorn
        [118242] = { },
      },
    },
  },

  -- Gift of Anzu
  [46904050] = {
    npcId = 86956,
    questId = 36389,
    icon = 'chest',
    note = t['gift_of_anzu_note'],
    POI = { 53108450, 69204350, 55602210, 48906250, 43802470, 43901500 },
    requirement = {
      item = {
        -- Elixir of Shadow Sight
        [115463] = { },
      },
    },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Anzu's Reach
        [118238] = { },
      },
    },
  },

  -- Gift of Anzu
  [48604450] = {
    name = t['gift_of_anzu_title'],
    questId = 36386,
    icon = 'chest',
    note = t['gift_of_anzu_note'],
    POI = { 53108450, 69204350, 55602210, 48906250, 43802470, 43901500 },
    requirement = {
      item = {
        -- Elixir of Shadow Sight
        [115463] = { },
      },
    },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Anzu's Malice
        [118237] = { },
      },
    },
  },

  -- Gift of Anzu
  [52001960] = {
    npcId = 86962,
    questId = 36392,
    icon = 'chest',
    note = t['gift_of_anzu_note'],
    POI = { 53108450, 69204350, 55602210, 48906250, 43802470, 43901500 },
    requirement = {
      item = {
        -- Elixir of Shadow Sight
        [115463] = { },
      },
    },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Anzu's Stoicism
        [118239] = { },
      },
    },
  },

  -- Gift of Anzu
  [57007900] = {
    npcId = 86961,
    questId = 36390,
    icon = 'chest',
    note = t['gift_of_anzu_note'],
    POI = { 53108450, 69204350, 55602210, 48906250, 43802470, 43901500 },
    requirement = {
      item = {
        -- Elixir of Shadow Sight
        [115463] = { },
      },
    },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
      item = {
        -- Anzu's Piercing Talon
        [118241] = { },
      },
    },
  },

  -- Statue of Anzu
  [57902230] = {
    npcId = 85165,
    questId = 36374,
    icon = 'chest',
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Nizzix's Chest
  [60908780] = {
    name = t['nizzixs_chest_title'],
    questId = 35481,
    icon = 'chest',
    note = t['nizzixs_chest_note'],
    POI = { 60908800 },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Relics of the Outcasts
  [45904420] = {
    name = t['relics_of_the_outcasts_title'],
    questId = 36354,
    icon = 'chest',
    note = t['relics_tree_note'] .. '\n' .. t['spires_of_arak_relics_note'],
    requirement = {
      profession = 'archaeology',
    },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Relics of the Outcasts
  [60205390] = {
    name = t['relics_of_the_outcasts_title'],
    questId = 36359,
    icon = 'chest',
    note = t['relics_tree_note'] .. '\n' .. t['spires_of_arak_relics_note'],
    requirement = {
      profession = 'archaeology',
    },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Relics of the Outcasts
  [67403980] = {
    name = t['relics_of_the_outcasts_title'],
    questId = 36356,
    icon = 'chest',
    note = t['spires_of_arak_relics_note'],
    requirement = {
      profession = 'archaeology',
    },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Relics of the Outcasts
  [51904890] = {
    name = t['relics_of_the_outcasts_title'],
    questId = 36360,
    icon = 'chest',
    note = t['spires_of_arak_relics_note'],
    requirement = {
      profession = 'archaeology',
    },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Relics of the Outcasts
  [43202720] = {
    name = t['relics_of_the_outcasts_title'],
    questId = 36355,
    icon = 'chest',
    note = t['spires_of_arak_relics_note'],
    requirement = {
      profession = 'archaeology',
    },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Relics of the Outcasts
  [43001640] = {
    name = t['relics_of_the_outcasts_title'],
    questId = 36245,
    icon = 'chest',
    note = t['spires_of_arak_relics_note'],
    requirement = {
      profession = 'archaeology',
    },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Sun-Touched Cache
  [33302730] = {
    name = t['sun-touched_cache_title'],
    questId = 36422,
    icon = 'chest',
    note = t['spires_of_arak_relics_note'],
    requirement = {
      profession = 'archaeology',
    },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Misplaced Scrolls
  [42701830] = {
    name = t['misplaced_scrolls_title'],
    questId = 36244,
    icon = 'chest',
    note = t['spires_of_arak_relics_note'],
    requirement = {
      profession = 'archaeology',
    },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Misplaced Scroll
  [52504280] = {
    name = t['misplaced_scroll_title'],
    questId = 36416,
    icon = 'chest',
    note = t['spires_of_arak_relics_note'],
    requirement = {
      profession = 'archaeology',
    },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  -- Smuggled Apexis Artifacts
  [56304530] = {
    name = t['smuggled_apexis_artifacts_title'],
    questId = 36433,
    icon = 'chest',
    note = t['spires_of_arak_relics_note'],
    requirement = {
      profession = 'archaeology',
    },
    loot = {
      achievement = {
        -- Grand Treasure Hunter
        [9728] = { count = true },
      },
    },
  },

  --- Pet Battles
  -- Vesharr
  [46404520] = {
    npcId = 87123,
    icon = 'pet',
    loot = {
      achievement = {
        -- An Awfully Big Adventure
        [9069] = { criteriaId = 27006 },
        -- Taming Draenor
        [9724] = { criteriaId = 27014 },
      },
    },
  },

  --- Achievements
  -- Pirate Pepe
  [54108360] = {
    name = t['pirate_pepe_title'],
    icon = 'achievement',
    note = t['pirate_pepe_note'],
    questId = 39268,
    loot = {
      -- I Found Pepe!
      achievement = {
        [10053] = { criteriaId = 28185 },
      },
      item = {
        -- A Tiny Pirate Hat
        [127870] = { },
      },
    },
  },

  -- Fish Gotta Swim, Birds Gotta Eat
  [53901040] = {
    name = t['fish_gotta_swim_title'],
    icon = 'achievement',
    note = t['fish_gotta_swim_note'] .. '\n\n' .. t['missive'],
    requirement = {
      quest = {
        [RequiredQuests['assault on skettis']] = { state = 'active' },
      },
    },
    loot = {
      -- Fish Gotta Swim, Birds Gotta Eat
      achievement = {
        [9613] = { },
      },
    },
  },
}

this.points[map] = points
