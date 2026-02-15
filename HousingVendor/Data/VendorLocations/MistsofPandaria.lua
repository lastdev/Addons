local vendors = {
  [1] = {
    expansion = "Mists of Pandaria",
    location = "The Jade Forest - Dawn's Blossom",
    vendorName = "Lali the Assistant",
    npcID = 62088,
    faction = 0,
    coords = {x = 47.0, y = 48.0, mapID = 371},  -- Dawn's Blossom inn
    factionID = "None",
    factionName = "None",
    reputation = "None",
    extra = "None",
  },
  [2] = {
    expansion = "Mists of Pandaria",
    location = "Vale of Eternal Blossoms",
    vendorName = "Tan Shin Tiao",
    npcID = 64605,
    faction = 0,
    coords = {x = 82.2, y = 29.4, mapID = 390},
    factionID = "None",
    factionName = "The Lorewalkers",
    reputation = "Friendly",
    extra = "Friendly with The Lorewalkers (higher rep unlocks more items)",
  },
  [3] = {
    expansion = "Mists of Pandaria",
    location = "The Jade Forest - Arboretum",
    vendorName = "San Redscale",
    npcID = 58414,
    faction = 0,
    coords = {x = 56.7, y = 44.4, mapID = 371},  -- Arboretum ring
    factionID = "None",
    factionName = "Order of the Cloud Serpent",
    reputation = "Revered",
    extra = "Revered with Order of the Cloud Serpent",
  },
  [4] = {
    expansion = "Mists of Pandaria",
    location = "Valley of the Four Winds - Halfhill",
    vendorName = "Gina Mudclaw",
    npcID = 58706,
    faction = 0,
    coords = {x = 53.2, y = 51.6, mapID = 376},
    factionID = "None",
    factionName = "The Tillers",
    reputation = "Good Friend",
    extra = "Good Friend with The Tillers (Tillers rep items)",
  },
  [5] = {
    expansion = "Mists of Pandaria",
    location = "Vale of Eternal Blossoms - Shrine of Seven Stars",
    vendorName = "Sage Whiteheart",
    npcID = 64032,
    faction = 0,
    coords = {x = 85.2, y = 61.6, mapID = 390},
    factionID = "None",
    factionName = "None",
    reputation = "None",
    extra = "Alliance-side; Horde mirror is Sage Lotusbloom (npcID 64001)",
  },
  [6] = {
    expansion = "Mists of Pandaria",
    location = "Orgrimmar",
    vendorName = "Joruh",
    npcID = 254606,
    faction = 0,
    coords = {x = 38.8, y = 71.9, mapID = 85},  -- Hall of Legends, Orgrimmar (Horde-side Battleground Decor Specialist)
    factionID = "None",
    factionName = "None",
    reputation = "None",
    extra = "Sells PvP-themed housing decor (e.g., requires achievements like Master of Twin Peaks); Honor currency",
  },
  [7] = {
    expansion = "Mists of Pandaria",
    location = "Stormwind City - Eastern Earthshrine",
    vendorName = "Jojo Ironbrow",
    npcID = 65066,  -- Alliance-side pandaren
    faction = 0,
    coords = {x = 74.0, y = 18.0, mapID = 84},  -- Eastern Earthshrine, Stormwind
    factionID = "None",
    factionName = "None",
    reputation = "None",
    extra = "Neutral vendor for housing decor in capital cities (per user data; unconfirmed sales on Wowheadâ€”may be community/placement note)",
  },
  [8] = {
    expansion = "Mists of Pandaria",
    location = "Kun-Lai Summit - One Keg",
    vendorName = "Brother Furtrim",
    npcID = 59698,
    faction = 0,
    coords = {x = 57.2, y = 61.0, mapID = 379},  -- One Keg area
    factionID = "None",
    factionName = "None",
    reputation = "None",
    extra = "Sells Kun-Lai Lacquered Rickshaw (may require quest 'The Leader Hozen' completion)",
  },
  [9] = {
    expansion = "Mists of Pandaria",
    location = "Orgrimmar",
    vendorName = "Ji Firepaw",
    npcID = 133523,  -- Master of Huojin in Orgrimmar
    faction = 0,
    coords = {x = 51.2, y = 36.6, mapID = 85},
    factionID = "None",
    factionName = "None",
    reputation = "None",
    extra = "Horde-side pandaren leader (per user data; unconfirmed as housing vendor on Wowheadâ€”may be neutral/capital placement for Horde parity)",
  },

  [10] = {
    expansion = "Mists of Pandaria",
    location = "Shrine of the Seven Stars",
    vendorName = "Lali the Assistant",
    npcID = 62088,
    faction = 0,
    coords = {x = 82.8, y = 30.8, mapID = 390},
  },
  [11] = {
    expansion = "Mists of Pandaria",
    location = "Shrine of 2 Moons",
    vendorName = "Sage Lotusbloom",
    npcID = 64001,
    faction = 2,
    coords = {x = 62.8, y = 23.2, mapID = 390},
  },
  [12] = {
    expansion = "Mists of Pandaria",
    location = "Kun-Lai Summit",
    vendorName = "Brother Furtrim",
    npcID = 59698,
    faction = 0,
    coords = {x = 57.24, y = 60.96, mapID = 379},
  },
  [13] = {
    expansion = "Mists of Pandaria",
    location = "The Jade Forest",
    vendorName = "Uncle Keen",
    npcID = 119885,
    faction = 0,
    coords = {x = 59.6, y = 72.0, mapID = 371},
  },
  [14] = {
    expansion = "Mists of Pandaria",
    location = "Halfhill",
    vendorName = "Gina Mudclaw",
    npcID = 58706,
    faction = 0,
    coords = {x = 53.2, y = 51.8, mapID = 376},
  },
  [15] = {
    expansion = "Mists of Pandaria",
    location = "Shrine of the Seven Stars",
    vendorName = "Sage Lotusbloom",
    npcID = 62032,
    faction = 0,
    coords = {x = 62.8, y = 23.2, mapID = 390},
  },
  [16] = {
    expansion = "Mists of Pandaria",
    location = "Shrine of Two Moons",
    vendorName = "Sage Whiteheart",
    npcID = 82003,
    faction = 0,
    coords = {x = 85.2, y = 61.6, mapID = 1530},
  },
  [17] = {
    expansion = "Mists of Pandaria",
    location = "The Jade Forest",
    vendorName = "Uncle Keen",
    npcID = 56687,
    faction = 0,
    coords = {x = 59.6, y = 72.0, mapID = 371},
  },
  [18] = {
    expansion = "Mists of Pandaria",
    location = "Valley of the Four Winds",
    vendorName = "Gina Mudclaw",
    npcID = 67052,
    faction = 0,
    coords = {x = 46.0, y = 43.2, mapID = 376},
  },
  [19] = {
    expansion = "Mists of Pandaria",
    location = "Shrine of the Seven Stars",
    vendorName = "Sage Lotusbloom",
    npcID = 61911,
    faction = 0,
    coords = {x = 62.8, y = 23.2, mapID = 390},
  },
  [20] = {
    expansion = "Mists of Pandaria",
    location = "Shrine of Two Moons",
    vendorName = "Sage Whiteheart",
    npcID = 77440,
    faction = 0,
    coords = {x = 85.2, y = 61.6, mapID = 1530},
  },
  [21] = {
    expansion = "Mists of Pandaria",
    location = "Arboretum",
    vendorName = "San Redscale",
    npcID = 58414,
    faction = 0,
    coords = {x = 56.8, y = 44.4, mapID = 371},
  },
  [22] = {
    expansion = "Mists of Pandaria",
    location = "Shrine of Seven Stars, Vale of Eternal Blossoms",
    vendorName = "Sage Whiteheart",
    npcID = 64032,
    faction = 1,
    coords = {x = 85.2, y = 61.6, mapID = 1530},
  },
  [23] = {
    expansion = "Mists of Pandaria",
    location = "Shrine of the Seven Stars",
    vendorName = "Tan Shin Tiao",
    npcID = 64605,
    faction = 0,
    coords = {x = 82.23, y = 29.33, mapID = 390},
  },
  [24] = {
    expansion = "Mists of Pandaria",
    location = "Vale of Eternal Blossoms",
    vendorName = "Ambas. Fu Han",
    npcID = 64599,
    faction = 0,
    coords = {x = 82.2, y = 29.4, mapID = 390},
  },
  [25] = {
    expansion = "Mists of Pandaria",
    location = "Kun-Lai Summit",
    vendorName = "Rushi the Fox",
    npcID = 64595,
    faction = 0,
    coords = {x = 36.0, y = 46.0, mapID = 379},
  },
  [26] = {
    expansion = "Mists of Pandaria",
    location = "Dread Wastes",
    vendorName = "Sage Whiteheart",
    npcID = 64032,
    faction = 0,
    coords = {x = 55.0, y = 35.0, mapID = 388},
  },
  [27] = {
    expansion = "Mists of Pandaria",
    location = "Isle of Thunder",
    vendorName = "Krosh Firehand",
    npcID = 69971,
    faction = 0,
    coords = {x = 33.0, y = 32.0, mapID = 504},
  },
  [28] = {
    expansion = "Mists of Pandaria",
    location = "Isle of Thunder",
    vendorName = "Hiren Loresong",
    npcID = 70313,
    faction = 0,
    coords = {x = 33.0, y = 32.0, mapID = 504},
  },
  [29] = {
    expansion = "Mists of Pandaria",
    location = "Krasarang Wilds",
    vendorName = "Nat Pagle",
    npcID = 63509,
    faction = 0,
    coords = {x = 70.0, y = 30.0, mapID = 418},
  },  [30] = {
    expansion = "Mists of Pandaria",
    location = "Timeless Isle (Celestial Court)",
    vendorName = "Ku-Mo",
    npcID = 73819,
    faction = 1492,
    coords = {x = 42.2, y = 54.6, mapID = 554},
  },
  [31] = {
    expansion = "Mists of Pandaria",
    location = "Halfhill (Valley of the Four Winds)",
    vendorName = "Nam Ironpaw",
    npcID = 64395,
    faction = 1272,
    coords = {x = 52.6, y = 51.4, mapID = 376},
  },

}

local itemEntries = {
  { vendorId = 4, itemID = "247856", itemName = "Serenity Peak Tent", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  -- Lali the Assistant block
  { vendorId = 1, itemID = "245332", itemName = "Tome of Silvermoon Intrigue", goldCost = 20000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "257351", itemName = "Tale of the Penultimate Lich King", goldCost = 20000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "257354", itemName = "Scroll of K'aresh's Fall", goldCost = 20000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "257355", itemName = "Tome of the Survivor", goldCost = 20000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Tan Shin Tiao block
  { vendorId = 2, itemID = "245512", itemName = "Pandaren Cradle Stool", goldCost = 3000000, currencies = {}, itemCosts = {}, factionName = "The Lorewalkers", reputationLevel = "Friendly", renownLevel = 0 },
  { vendorId = 2, itemID = "247662", itemName = "Pandaren Scholar's Lectern", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "The Lorewalkers", reputationLevel = "Honored", renownLevel = 0 },
  { vendorId = 2, itemID = "247663", itemName = "Pandaren Scholar's Bookcase", goldCost = 20000000, currencies = {}, itemCosts = {}, factionName = "The Lorewalkers", reputationLevel = "Revered", renownLevel = 0 },
  { vendorId = 2, itemID = "247855", itemName = "Pandaren Lacquered Crate", goldCost = 3000000, currencies = {}, itemCosts = {}, factionName = "The Lorewalkers", reputationLevel = "Honored", renownLevel = 0 },
  { vendorId = 2, itemID = "247858", itemName = "Shaohao Ceremonial Bell", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 2, itemID = "258147", itemName = "Empty Lorewalker's Bookcase", goldCost = 10000000, currencies = {}, itemCosts = {}, factionName = "The Lorewalkers", reputationLevel = "Revered", renownLevel = 0 },

  -- San Redscale block
  { vendorId = 3, itemID = "247730", itemName = "Red Crane Kite", goldCost = 10000000, currencies = {}, itemCosts = {}, factionName = "Order of the Cloud Serpent", reputationLevel = "Revered", renownLevel = 0 },
  { vendorId = 3, itemID = "247732", itemName = "Lucky Hanging Lantern", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "Order of the Cloud Serpent", reputationLevel = "Honored", renownLevel = 0 },

  -- Gina Mudclaw block
  { vendorId = 4, itemID = "245508", itemName = "Pandaren Cooking Table", goldCost = 0, currencies = {{ currencyID = 1220, amount = 10000 }}, itemCosts = {}, factionName = "The Tillers", reputationLevel = "Good Friend", renownLevel = 0 },
  { vendorId = 4, itemID = "247670", itemName = "Pandaren Pantry", goldCost = 0, currencies = {{ currencyID = 1220, amount = 10000 }}, itemCosts = {}, factionName = "The Tillers", reputationLevel = "Good Friend", renownLevel = 0 },
  { vendorId = 4, itemID = "247734", itemName = "Paw'don Well", goldCost = 8000000, currencies = {}, itemCosts = {}, factionName = "The Tillers", reputationLevel = "Good Friend", renownLevel = 0 },
  { vendorId = 4, itemID = "247737", itemName = "Stormstout Brew Keg", goldCost = 3000000, currencies = {}, itemCosts = {}, factionName = "The Tillers", reputationLevel = "Good Friend", renownLevel = 0 },
  { vendorId = 4, itemID = "248663", itemName = "Wooden Doghouse", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Sage Whiteheart block
  { vendorId = 5, itemID = "247729", itemName = "Pandaren Stone Lamppost", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  -- Sage Whiteheart block (Alliance vendor per master table)
  { vendorId = 5, itemID = "264362", itemName = "Golden Pandaren Privacy Screen", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Joruh block
  { vendorId = 6, itemID = "247727", itemName = "Iron Dragonmaw Gate", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Jojo Ironbrow block
  { vendorId = 7, itemID = "247661", itemName = "Pandaren Signal Brazier", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 7, itemID = "247728", itemName = "Pandaren Stone Post", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 7, itemID = "247733", itemName = "Halfhill Cookpot", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 7, itemID = "247735", itemName = "Lucky Traveler's Bench", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 7, itemID = "247736", itemName = "Jade Temple Dragon Fountain", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 7, itemID = "247738", itemName = "Pandaren Meander Rug", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Brother Furtrim block
  { vendorId = 8, itemID = "264349", itemName = "Kun-Lai Lacquered Rickshaw", goldCost = 1000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Ji Firepaw block

  -- Sage Lotusbloom block (Horde vendor per master table)

  -- Ambas. Fu Han block
  { vendorId = 24, itemID = "264353", itemName = "Grand August Celestial Banner", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 24, itemID = "247859", itemName = "White Tiger Statue Replica", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Rushi the Fox block
  { vendorId = 25, itemID = "247857", itemName = "Shado-Pan Training Dummy", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Kil'ruk the Wind-Reaver block
  { vendorId = 26, itemID = "245511", itemName = "Klaxxi Amber Sconce", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Krosh Firehand block
  { vendorId = 27, itemID = "264336", itemName = "Sunreaver Onslaught Brazier", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Hiren Loresong block
  { vendorId = 28, itemID = "264337", itemName = "Kirin Tor Offensive Pillar", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Nat Pagle block
  { vendorId = 29, itemID = "252038", itemName = "Anglers Fishing Stool", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  -- Ku-Mo block
  { vendorId = 30, itemID = "247742", itemName = "Timeless Dumpling Cart", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Nam Ironpaw block
  { vendorId = 31, itemID = "248937", itemName = "Ironpaw Stew Cart", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

}

local items = {}
for index, entry in ipairs(itemEntries) do
  local vendor = vendors[entry.vendorId]
  if vendor then
    items[index] = {
      itemID = entry.itemID,
      itemName = entry.itemName,
      vendorDetails = vendor,
      goldCost = entry.goldCost,
      currencies = entry.currencies,
      itemCosts = entry.itemCosts,
      factionName = entry.factionName,
      reputationLevel = entry.reputationLevel,
      renownLevel = entry.renownLevel,
    }
  end
end
HousingDataAggregator_RegisterExpansionItems("vendor", items)
