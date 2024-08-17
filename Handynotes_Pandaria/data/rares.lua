local _, addon = ...;

addon.rareData = {
  -- toy rares
  [51059] = {
    name = 'Blackhoof',
    toys = 86565,
  },
  [50336] = {
    name = 'Yorik Sharpeye',
    toys = 86568,
  },
  [50349] = {
    name = 'Kang the Soul Thief',
    toys = 86571,
  },
  [50354] = {
    name = 'Havak',
    toys = 86573,
  },
  [50359] = {
    name = 'Urgolax',
    toys = 86575,
  },
  [50739] = {
    name = 'Gar\'lok',
    toys = 86578,
  },
  [50749] = {
    name = 'Kal\'tik the Blight',
    toys = 134023,
  },
  [50769] = {
    name = 'Zai the Outcast',
    toys = 86581,
  },
  [50780] = {
    name = 'Sahn Tidehunter',
    toys = 86582,
  },
  [50783] = {
    name = 'Salyin Warscout',
    toys = 86583,
  },
  [50789] = {
    name = 'Nessos the Oracle',
    toys = 86584,
  },
  [50806] = {
    name = 'Moldo One-Eye',
    description = 'Roams in the old river between the location points.',
    toys = 86586,
  },
  [50817] = {
    name = 'Ahone the Wanderer',
    toys = 86588,
  },
  [50821] = {
    name = 'Ai-Li Skymirror',
    toys = 86589,
  },
  [50822] = {
    name = 'Ai-Ran the Shifting Cloud',
    toys = 86590,
  },
  [50836] = {
    name = 'Ik-Ik the Nimble',
    toys = 86593,
  },
  [50840] = {
    name = 'Major Nanners',
    toys = 86594,
  },


  [66900] = {
    name = 'Huggalon the Heart Watcher',
    toys = 90067,
  },


  [72896] = {
    name = 'Eternal Kilnmaster',
    toys = 104309,
  },
  [72898] = {
    name = 'High Priest of Ordos',
    toys = 104329,
  },
  [72970] = {
    name = 'Golganarr',
    toys = 104262,
  },
  [73169] = {
    name = 'Jakur of Ordon',
    toys = 104331,
  },
  [73171] = {
    name = 'Champion of the Black Flame',
    toys = 104302,
  },
  [73281] = {
    name = 'Dread Ship Vazuvius',
    description = 'Kill Evermaw for the lantern to summon the ship at the ritual stone.',
    toys = 104294,
  },

  -- mount rares
  [60491] = {
    name = 'Sha of Anger',
    quest = 32099,
    mounts = 473,
  },
  [69099] = {
    name = 'Nalak',
    quest = 32518,
    mounts = 542,
  },
  [62346] = {
    name = 'Galleon',
    quest = 32098,
    mounts = 515,
  },
  [69161] = {
    name = 'Oondasta',
    quest = 32519,
    mounts = 533,
  },

  [64403] = {
    name = 'Alani',
    description = 'Cloud Serpent flying arround the Vale. Needs 10 Sky Crystals to remove immunity.',
    mounts = 517,
  },
  [73167] = {
    name = 'Huolon',
    mounts = 561,
  },
  [69769] = {
    name = 'Zandalari Warbringer',
    description = 'The color of the NPCs mounts determines the color of the mounts that can drop.',
    mounts = {534, 535, 536},
  },

  -- special rares
  [50831] = {
    description = 'Can drop item that increases reputation with all Pandaria factions by 1000.',
    special = true,
  },

  -- faction specific rares
  [68320] = {
    name = 'Ubunti the Shade',
    faction = 'Alliance',
  },
  [68321] = {
    name = 'Kar Warmaker',
    faction = 'Alliance',
  },
  [68322] = {
    name = 'Muerta',
    faction = 'Alliance',
  },
  [68317] = {
    name = 'Mavis Harms',
    faction = 'Horde',
  },
  [68318] = {
    name = 'Dalan Nightbreaker',
    faction = 'Horde',
  },
  [68319] = {
    name = 'Disha Fearwarden',
    faction = 'Horde',
  },

  -- rares with info
  [69471] = {
    description = 'Inside a cave in the wall near coast to the West. \nNeeds 3x Shan\'ze Ritual Stone to summon.',
  },
  [69633] = {
    description = 'Needs 3x Shan\'ze Ritual Stone to summon.',
  },
  [69341] = {
    description = 'Needs 3x Shan\'ze Ritual Stone to summon.',
  },
  [69339] = {
    description = 'Needs 3x Shan\'ze Ritual Stone to summon.',
  },
  [69749] = {
    description = 'Needs 3x Shan\'ze Ritual Stone to summon.',
  },
  [69767] = {
    description = 'Needs 3x Shan\'ze Ritual Stone to summon.',
  },
  [70080] = {
    description = 'Needs 3x Shan\'ze Ritual Stone to summon.',
  },
  [69396] = {
    description = 'Needs 3x Shan\'ze Ritual Stone to summon.',
  },
  [69347] = {
    description = 'Needs 3x Shan\'ze Ritual Stone to summon.',
  },
  [50356] = {
    description = 'Used to drop a bonus experience item which was removed from the game.',
  },
  [73157] = {
    description = 'Inside cave.',
  },
  [72769] = {
    description = 'Inside cave.',
  },
  [72193] = {
    description = 'Speak to Fin Longpaw on the pier to summon him.'
  },
  [71864] = {
    description = 'The rocks can be skipped with jump/chair items or blink.'
  },
  [73161] = {
    description = 'Great Turtles can respawn as this rare.'
  },
  [73166] = {
    description = 'Spineclaws can respawn as this rare.'
  },
  [72045] = {
    description = 'Click on the suspicious shell.'
  },
  [73160] = {
    description = 'Keep killing all the Ironfur mobs until it spawns.'
  },
  [72049] = {
    description = 'Kite a Fishgorged Crane from the south onto the corpse.'
  },
  [72048] = {
    description = 'Talk to Captain Zvezdan in the underwater shipwreck.'
  },

  -- other rares
  [69768] = {
    name = 'Zandalari Warscout',
  },
};
