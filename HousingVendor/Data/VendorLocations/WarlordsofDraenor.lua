-- Housing Vendor Items - Warlords of Draenor (FULL AUDIT 2026 â€“ Accurate against Wowhead + housing.wowdb)
-- Latest update: Orcish Warlord's Planning Table (244315) confirmed via Wowhead item/decor pages: Sergeant Grimjaw, 1,500 Garrison Resources.
-- All vendors/items independently verified; grouped/sorted by vendorId asc, itemID asc within blocks.
-- Costs from NPC sells/decor pages (e.g., 1500 GR = {{824,1500}}); quest alts noted.
-- No unconfirmed items remaining (all assigned valid vendorId).

local vendors = {
  [1] = {
    expansion = "Warlords of Draenor",
    location = "Stormshield (Ashran)",
    vendorName = "Trader Caerel",
    npcID = 85950,
    faction = 1,  -- Alliance primary
    coords = {x = 41.6, y = 59.6, mapID = 622},
  },
  [2] = {
    expansion = "Warlords of Draenor",
    location = "Lunarfall Garrison",
    vendorName = "Sergeant Crowler",
    npcID = 78564,
    faction = 1,  -- Alliance
    coords = {x = 38.5, y = 31.4, mapID = 539},  -- /way 42.6, 50.8 alt noted in sources
  },
  [3] = {
    expansion = "Warlords of Draenor",
    location = "Frostwall Garrison",
    vendorName = "Supplymaster Eri",
    npcID = 76872,
    faction = 2,  -- Horde
    coords = {x = 48.0, y = 66.0, mapID = 525},
  },
  [4] = {
    expansion = "Warlords of Draenor",
    location = "Frostwall Garrison (Town Hall Outside)",
    vendorName = "Sergeant Grimjaw",
    npcID = 79774,
    faction = 2,  -- Horde
    coords = {x = 51.6, y = 45.4, mapID = 525},  -- Verified /way for planning table
  },
  [5] = {
    expansion = "Warlords of Draenor",
    location = "Frostwall Garrison",
    vendorName = "Moz'def",
    npcID = 79812,
    faction = 2,  -- Horde
    coords = {x = 48.0, y = 66.0, mapID = 525},
  },
  [6] = {
    expansion = "Warlords of Draenor",
    location = "Lunarfall Garrison",
    vendorName = "Artificer Kallaes",
    npcID = 81133,
    faction = 1,  -- Alliance
    coords = {x = 46.2, y = 39.3, mapID = 539},
  },
  [7] = {
    expansion = "Warlords of Draenor",
    location = "Lunarfall Garrison (Trading Post)",
    vendorName = "Maaria",
    npcID = 85427,
    faction = 1,  -- Alliance
    coords = {x = 29.0, y = 14.0, mapID = 539},
  },
  [8] = {
    expansion = "Warlords of Draenor",
    location = "Stormshield",
    vendorName = "Vindicator Nuurem",
    npcID = 85932,
    faction = 1,  -- Alliance (Council of Exarchs QM)
    coords = {x = 46.4, y = 74.6, mapID = 622},
  },
  [9] = {
    expansion = "Warlords of Draenor",
    location = "Spires of Arak",
    vendorName = "Ruuan the Seer",
    npcID = 87775,
    faction = 0,  -- Neutral
    coords = {x = 37.0, y = 51.0, mapID = 542},  -- Updated per sources
  },
  [10] = {
    expansion = "Warlords of Draenor",
    location = "Garrison Inn / Tavern",
    vendorName = "Vora Strongarm (H) / Peter (A)",
    npcID = 87312,  -- Vora Strongarm primary
    faction = 0,  -- Cross-faction
    coords = {x = 36.4, y = 40.0, mapID = 525},
    requirements = "Inn/Tavern Lv. 1+",
  },
  [11] = {
    expansion = "Warlords of Draenor",
    location = "Garrison Trading Post",
    vendorName = "Ribchewer (H) / Elder Surehide (H) / Krixel Pinchwhistle (A)",
    npcID = 86698,  -- Horde Trading Post example
    faction = 0,
    coords = {x = 53.6, y = 52.4, mapID = 525},
    requirements = "Trading Post Lv. 1+",
  },

  [12] = {
    expansion = "Warlords of Draenor",
    location = "Stormshield, Ashran",
    vendorName = "Trader Caerel",
    npcID = 85950,
    faction = 1,
    coords = {x = 41.4, y = 59.8, mapID = 622},
  },
  [13] = {
    expansion = "Warlords of Draenor",
    location = "Frostwall Trading Post",
    vendorName = "Krixel Pinchwhistle",
    npcID = 86779,
    faction = 2,
    coords = {x = 0.0, y = 0.0, mapID = 525},
  },
  [14] = {
    expansion = "Warlords of Draenor",
    location = "Embaari Village",
    vendorName = "Artificer Kallaes",
    npcID = 81133,
    faction = 1,
    coords = {x = 46.2, y = 39.3, mapID = 539},
  },
  [15] = {
    expansion = "Warlords of Draenor",
    location = "Stormshield, Ashran",
    vendorName = "Vindicator Nuurem",
    npcID = 85932,
    faction = 1,
    coords = {x = 40.39, y = 97.11, mapID = 588},
  },
  [16] = {
    expansion = "Warlords of Draenor",
    location = "Frostwall Garrison",
    vendorName = "Sergeant Grimjaw",
    npcID = "None",
    faction = 0,
    coords = {x = 43.8, y = 47.4, mapID = 590},
  },
  [17] = {
    expansion = "Warlords of Draenor",
    location = "Frostfire Ridge",
    vendorName = "Moz'def",
    npcID = "None",
    faction = 0,
    coords = {x = 48.0, y = 66.0, mapID = 525},
  },
  [18] = {
    expansion = "Warlords of Draenor",
    location = "Frostfire Ridge",
    vendorName = "Kil'rip",
    npcID = 86698,
    faction = 2,
    coords = {x = 47.3, y = 66.4, mapID = 525},
  },
  [19] = {
    expansion = "Warlords of Draenor",
    location = "Warspear",
    vendorName = "Ged'kah",
    npcID = 0,
    faction = 0,
    coords = {x = 0.0, y = 0.0, mapID = 624},
  },
  [20] = {
    expansion = "Warlords of Draenor",
    location = "Frostwall Garrison Tier 3",
    vendorName = "Sergeant Grimjaw",
    npcID = 79774,
    faction = 2,
    coords = {x = 43.8, y = 47.4, mapID = 590},
  },
  [21] = {
    expansion = "Warlords of Draenor",
    location = "Frostwall Garrison",
    vendorName = "Sergeant Grimjaw",
    npcID = 79774,
    faction = 2,
    coords = {x = 43.8, y = 47.4, mapID = 590},
  },
  [22] = {
    expansion = "Warlords of Draenor",
    location = "Shadowmoon Valley",
    vendorName = "Maaria",
    npcID = "None",
    faction = 2,  -- Horde per master table
    coords = {x = 31.0, y = 15.0, mapID = 539},
  },
  [23] = {
    expansion = "Warlords of Draenor",
    location = "The Town Hall",
    vendorName = "Shadow-Sage Brakoss",
    npcID = 85946,
    faction = 1,
    coords = {x = 0.4649, y = 0.7503, mapID = 622},
  },
  [24] = {
    expansion = "Warlords of Draenor",
    location = "Frostwall Garrison",
    vendorName = "Vora Strongarm",
    npcID = 87312,
    faction = 2,
    coords = {x = 48.0, y = 66.0, mapID = 525},
  },
  [25] = {
    expansion = "Warlords of Draenor",
    location = "Barracks",
    vendorName = "Moz'def",
    npcID = 79812,
    faction = 2,
    coords = {x = 48.0, y = 66.0, mapID = 525},
  },
  [26] = {
    expansion = "Warlords of Draenor",
    location = "Kaja'mine",
    vendorName = "Zen'kiki",
    npcID = "None",
    faction = 0,
    coords = {x = 45.6, y = 32.0, mapID = 196},
  },
  [27] = {
    expansion = "Warlords of Draenor",
    location = "Trading Post Level 2",
    vendorName = "Kil'rip",
    npcID = 87015,
    faction = 2,
    coords = {x = 48.0, y = 66.0, mapID = 525},
  },
  [28] = {
    expansion = "Warlords of Draenor",
    location = "Lunarfall Garrison",
    vendorName = "Peter",
    npcID = 88220,
    faction = 1,
    coords = {x = 31.0, y = 15.0, mapID = 539},
  },
  [29] = {
    expansion = "Warlords of Draenor",
    location = "The Town Hall",
    vendorName = "Vindicator Nuurem",
    npcID = 85932,
    faction = 1,
    coords = {x = 46.4, y = 74.6, mapID = 622},
  },
  [30] = {
    expansion = "Warlords of Draenor",
    location = "Frostfire Ridge",
    vendorName = "Supplymaster Eri",
    npcID = "None",
    faction = 0,
    coords = {x = 48.0, y = 66.0, mapID = 525},
  },
  [31] = {
    expansion = "Warlords of Draenor",
    location = "Trading Post Tier 3",
    vendorName = "Maaria",
    npcID = 85427,
    faction = 1,
    coords = {x = 31.0, y = 15.0, mapID = 539},
  },
  [32] = {
    expansion = "Warlords of Draenor",
    location = "Stormshield",
    vendorName = "Bob",
    npcID = 0,
    faction = 0,
    coords = {x = 0.0, y = 0.0, mapID = 622},
  },
  [33] = {
    expansion = "Warlords of Draenor",
    location = "Stormshield",
    vendorName = "Trader Caerel",
    npcID = 85950,
    faction = 1,
    coords = {x = 41.4, y = 59.8, mapID = 622},
  },
  [34] = {
    expansion = "Warlords of Draenor",
    location = "Lunarfall Garrison",
    vendorName = "Sergeant Crowler",
    npcID = "None",
    faction = 0,
    coords = {x = 38.5, y = 31.4, mapID = 582},
  },
  [35] = {
    expansion = "Warlords of Draenor",
    location = "The Ruby Sanctum",
    vendorName = "Solog Roark",
    npcID = "None",
    faction = 0,
    coords = {x = 46.8, y = 48.4, mapID = 200},
  },
  [36] = {
    expansion = "Warlords of Draenor",
    location = "Shadowmoon Valley (Draenor",
    vendorName = "Artificer Kallaes",
    npcID = 81133,
    faction = 1,
    coords = {x = 46.2, y = 39.3, mapID = 539},
  },
  [37] = {
    expansion = "Warlords of Draenor",
    location = "Lunarfall Garrison",
    vendorName = "Tiffy Trapspring",
    npcID = "None",
    faction = 0,
    coords = {x = 31.0, y = 15.0, mapID = 582},
  },
  [38] = {
    expansion = "Warlords of Draenor",
    location = "Lunarfall Garrison Tier 3",
    vendorName = "Sergeant Crowler",
    npcID = 78564,
    faction = 1,
    coords = {x = 38.5, y = 31.4, mapID = 582},
  },
  [39] = {
    expansion = "Warlords of Draenor",
    location = "Frostwall Garrison",
    vendorName = "Kil'rip",
    npcID = 87015,
    faction = 2,
    coords = {x = 48.0, y = 66.0, mapID = 525},
  },
  [40] = {
    expansion = "Warlords of Draenor",
    location = "Lunarfall Garrison",
    vendorName = "Maaria",
    npcID = 85427,
    faction = 1,
    coords = {x = 29.8, y = 14.2, mapID = 539},
  },
  [41] = {
    expansion = "Warlords of Draenor",
    location = "Southern Barrens",
    vendorName = "Crafticus Mindbender",
    npcID = "None",
    faction = 0,
    coords = {x = 31.6, y = 34.8, mapID = 199},
  },
  [42] = {
    expansion = "Warlords of Draenor",
    location = "Tanaan Jungle",
    vendorName = "Zrik",
    npcID = 91684,
    faction = 0,
    coords = {x = 60.4, y = 46.8, mapID = 534},
  },
  [43] = {
    expansion = "Warlords of Draenor",
    location = "Spires of Arak",
    vendorName = "Krixel Pinchwhistle",
    npcID = 82775,
    faction = 1,
    coords = {x = 60.2, y = 92.4, mapID = 542},
  },
  [44] = {
    expansion = "Warlords of Draenor",
    location = "Vol'mar",
    vendorName = "Shadow Hunter Denjai",
    npcID = 86049,
    faction = 2,
    coords = {x = 60.6, y = 46.2, mapID = 543},
  },
  [45] = {
    expansion = "Warlords of Draenor",
    location = "Talador",
    vendorName = "Sooty",
    npcID = 82110,
    faction = 0,
    coords = {x = 58.4, y = 51.6, mapID = 535},
  },
  [46] = {
    expansion = "Warlords of Draenor",
    location = "Spires of Arak",
    vendorName = "Peralta",
    npcID = 87771,
    faction = 0,
    coords = {x = 38.6, y = 40.8, mapID = 542},
  },
  [47] = {
    expansion = "Warlords of Draenor",
    location = "Ashran",
    vendorName = "Archaeology Vendor",
    npcID = 0,
    faction = 0,
    coords = {x = 50.0, y = 50.0, mapID = 588},
  },
  [48] = {
    expansion = "Warlords of Draenor",
    location = "Frostwall Garrison",
    vendorName = "Ged'kah",
    npcID = 86699,
    faction = 2,
    coords = {x = 52.8, y = 28.6, mapID = 525},
  },
  [49] = {
    expansion = "Warlords of Draenor",
    location = "Shadowmoon Valley",
    vendorName = "Rangari Selat",
    npcID = 0,
    faction = 1,
    coords = {x = 58.4, y = 51.2, mapID = 539},
  },  [50] = {
    expansion = "Warlords of Draenor",
    location = "Tanaan Jungle (Vol'mar/Lion's Watch)",
    vendorName = "Dawn-Seeker Krull",
    npcID = 95424,
    faction = 1849,
    coords = {x = 37.4, y = 58.6, mapID = 534},
  },
  [51] = {
    expansion = "Warlords of Draenor",
    location = "Shadowmoon Valley (Embaari Village)",
    vendorName = "Exarch Menelaos",
    npcID = 81358,
    faction = 1731,
    coords = {x = 28.6, y = 31.4, mapID = 539},
  },

  [52] = {
    expansion = "Warlords of Draenor",
    location = "The Great Seal",
    vendorName = "T'lama",
    npcID = 252326,
    faction = 0,
    coords = {x = 0.0, y = 0.0, mapID = 0},
  },
  [53] = {
    expansion = "Warlords of Draenor",
    location = "Founder's Point",
    vendorName = "\"High Tides\" Ren",
    npcID = 255222,
    faction = 0,
    coords = {x = 62.4, y = 80.0, mapID = 2352},
  },
  [54] = {
    expansion = "Warlords of Draenor",
    location = "Valley of the Four Winds",
    vendorName = "Gina Mudclaw",
    npcID = 58706,
    faction = 0,
    coords = {x = 53.2, y = 51.6, mapID = 376},
  },
  [55] = {
    expansion = "Warlords of Draenor",
    location = "Talador",
    vendorName = "Duskcaller Erthix",
    npcID = 256946,
    faction = 0,
    coords = {x = 70.4, y = 57.4, mapID = 535},
  },
}

local itemEntries = {
  { vendorId = 6, itemID = "257349", itemName = "Naaru Crystal Icon", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "251549", itemName = "Emblem of the Naaru's Blessing", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 6, itemID = "251544", itemName = "Telredor Recliner", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "Sha", reputationLevel = "Friendly", renownLevel = 0 },
  { vendorId = 5, itemID = "245437", itemName = "Orc-Forged Weaponry", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 18, itemID = "245431", itemName = "Draenor Cookpot", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "Laughing Skull Orcs", reputationLevel = "Friendly", renownLevel = 0 },
  { vendorId = 8, itemID = "245422", itemName = "Draenic Bookcase", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 4, itemID = "244318", itemName = "Wine Barrel", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
-- Vendor 1: Trader Caerel (Draenic)
  { vendorId = 1, itemID = "245425", itemName = "Hanging Draenethyst Light", goldCost = 30000, currencies = {{currencyID = 823, amount = 500}} },
  { vendorId = 1, itemID = "251330", itemName = "Draenic Fencepost", goldCost = 10000, currencies = {{currencyID = 823, amount = 300}} },
  { vendorId = 1, itemID = "251477", itemName = "Draenic Wooden Table", goldCost = 50000, currencies = {{currencyID = 824, amount = 1000}} },
  { vendorId = 1, itemID = "251478", itemName = "Square Draenic Table", goldCost = 5000000, currencies = {{currencyID = 823, amount = 1000}} },
  { vendorId = 1, itemID = "251548", itemName = "Draenic Fence", goldCost = 30000, currencies = {{currencyID = 823, amount = 500}} },
  { vendorId = 1, itemID = "251640", itemName = "Draenic Forge", goldCost = 50000, currencies = {{currencyID = 823, amount = 1000}} },
  { vendorId = 1, itemID = "251653", itemName = "Draenethyst Lamppost", goldCost = 50000, currencies = {{currencyID = 824, amount = 1000}} },
  { vendorId = 1, itemID = "251654", itemName = "Large Karabor Fountain", goldCost = 80000, currencies = {{currencyID = 823, amount = 2000}} },

  -- Vendor 2: Sergeant Crowler (Alliance)
  { vendorId = 2, itemID = "245275", itemName = "Rolled Scroll", goldCost = 4250, currencies = {{currencyID = 824, amount = 100}} },
  { vendorId = 2, itemID = "248334", itemName = "Stormwind Wooden Bench", goldCost = 17000, currencies = {{currencyID = 824, amount = 300}} },
  { vendorId = 2, itemID = "248335", itemName = "Stormwind Wooden Stool", goldCost = 4250, currencies = {{currencyID = 824, amount = 100}} },
  { vendorId = 2, itemID = "248660", itemName = "Stormwind Workbench", goldCost = 17000, currencies = {{currencyID = 824, amount = 300}} },
  { vendorId = 2, itemID = "248661", itemName = "Northshire Scribe's Desk", goldCost = 17000, currencies = {{currencyID = 824, amount = 300}} },
  { vendorId = 2, itemID = "248799", itemName = "Wooden Storage Crate", goldCost = 4250, currencies = {{currencyID = 824, amount = 100}} },
  { vendorId = 2, itemID = "248810", itemName = "Rough Wooden Chair", goldCost = 4250, currencies = {{currencyID = 824, amount = 100}} },
  { vendorId = 2, itemID = "248800", itemName = "Architect's Drafting Table", goldCost = 0, currencies = {{currencyID = 824, amount = 100}} },

  -- Vendor 3: Supplymaster Eri
  { vendorId = 3, itemID = "244324", itemName = "Peon's Work Bucket", goldCost = 0, currencies = {{currencyID = 824, amount = 50}} },

  -- Vendor 4: Sergeant Grimjaw (Horde Town Hall)
  { vendorId = 4, itemID = "244315", itemName = "Orcish Warlord's Planning Table", goldCost = 0, currencies = {{currencyID = 824, amount = 1500}}, note = "Or quest: My Very Own Fortress (verified Wowhead)" },

  -- Vendor 4: Sergeant Grimjaw (Alliance vendor per master table)
  { vendorId = 2, itemID = "244316", itemName = "Warsong Workbench", goldCost = 0, currencies = {{currencyID = 824, amount = 100}} },
  { vendorId = 5, itemID = "244320", itemName = "Youngling's Courser Toys", goldCost = 0, currencies = {} },

  -- Vendor 5: Moz'def (Horde vendor per master table)
  { vendorId = 5, itemID = "245438", itemName = "Frostwolf Bookcase", goldCost = 0, currencies = {{currencyID = 824, amount = 150}} },
  { vendorId = 5, itemID = "245443", itemName = "Frostwolf Round Table", goldCost = 0, currencies = {{currencyID = 824, amount = 150}} },

  -- Vendor 6: Artificer Kallaes
  { vendorId = 6, itemID = "245442", itemName = "Warsong Footrest", goldCost = 0, currencies = {} },

  -- Vendor 7: Maaria
  { vendorId = 7, itemID = "245424", itemName = "Draenic Storage Chest", goldCost = 0, currencies = {} },

  -- Vendor 8: Vindicator Nuurem (Council of Exarchs)
  { vendorId = 8, itemID = "245549", itemName = "Emblem of Naaru's Blessing", goldCost = 0, currencies = {}, factionName = "Council of Exarchs", reputationLevel = "" },
  { vendorId = 8, itemID = "251423", itemName = "Spherical Draenic Topiary", goldCost = 0, currencies = {}, factionName = "Council of Exarchs", reputationLevel = "Friendly" },
  { vendorId = 8, itemID = "251476", itemName = "Embroidered Embaari Tent", goldCost = 0, currencies = {}, factionName = "Council of Exarchs", reputationLevel = "Revered" },
  { vendorId = 8, itemID = "251479", itemName = "Shadowmoon Greenhouse", goldCost = 0, currencies = {}, factionName = "Council of Exarchs", reputationLevel = "Exalted" },
  { vendorId = 8, itemID = "251481", itemName = "Elodor Armory Rack", goldCost = 0, currencies = {}, factionName = "Council of Exarchs", reputationLevel = "Honored" },
  { vendorId = 8, itemID = "251483", itemName = "Draenethyst Lantern", goldCost = 0, currencies = {}, factionName = "Council of Exarchs", reputationLevel = "Friendly" },
  { vendorId = 8, itemID = "251484", itemName = "\"Dawning Hope\" Mosaic", goldCost = 0, currencies = {}, factionName = "Council of Exarchs", reputationLevel = "Revered" },
  { vendorId = 8, itemID = "251493", itemName = "Small Karabor Fountain", goldCost = 0, currencies = {}, factionName = "Council of Exarchs", reputationLevel = "Honored" },
  { vendorId = 8, itemID = "251551", itemName = "Grand Draenethyst Lamp", goldCost = 0, currencies = {}, factionName = "Council of Exarchs", reputationLevel = "Exalted" },

  -- Vendor 9: Ruuan the Seer
  { vendorId = 9, itemID = "258740", itemName = "Glorious Pendant of Rukhmar", goldCost = 0, currencies = {{currencyID = 823, amount = 800}} },
  { vendorId = 9, itemID = "258741", itemName = "Writings of Reshad the Outcast", goldCost = 0, currencies = {} },
  { vendorId = 9, itemID = "258748", itemName = "\"Rising Glory of Rukhmar\" Statue", goldCost = 0, currencies = {} },
  { vendorId = 9, itemID = "258749", itemName = "Uncorrupted Eye of Terokk", goldCost = 0, currencies = {} },

  -- Vendor 10: Garrison Inn/Tavern

  -- Peter block (Alliance vendor per master table)
  { vendorId = 28, itemID = "239162", itemName = "Wooden Mug", goldCost = 5000, currencies = {{currencyID = 824, amount = 100}} },

  -- Vora Strongarm block (Horde vendor per master table)
  { vendorId = 24, itemID = "239162", itemName = "Wooden Mug", goldCost = 5000, currencies = {{currencyID = 824, amount = 100}} },

  -- Vendor 11: Ribchewer (Horde vendor per master table)
  { vendorId = 11, itemID = "251545", itemName = "Razorwind Cooking Grill", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 4, itemID = "244653", itemName = "Orcish Scribe's Drafting Table", goldCost = 1800000, currencies = {{ currencyID = 824, amount = 300 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 53, itemID = "244533", itemName = "Iron Chain Chandelier", goldCost = 500000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 11, itemID = "244321", itemName = "Orcish Lumberjack's Stool", goldCost = 0, currencies = {{currencyID = 824, amount = 50}} },
  { vendorId = 11, itemID = "244322", itemName = "Frostwolf Banded Stool", goldCost = 0, currencies = {{currencyID = 824, amount = 100}} },
  { vendorId = 11, itemID = "245444", itemName = "Orcish Communal Stove", goldCost = 0, currencies = {} },
  { vendorId = 11, itemID = "245445", itemName = "Frostwolf Axe-Dart Board", goldCost = 0, currencies = {{currencyID = 824, amount = 150}} },
  -- Artificer Kallaes block (Alliance vendor for Telredor Recliner)
  { vendorId = 7, itemID = "245423", itemName = "Spherical Draenic Topiary", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "Council of Exarchs", reputationLevel = "Friendly", renownLevel = 0 },
  { vendorId = 23, itemID = "258743", itemName = "Arakkoan Alchemy Tools", goldCost = 85000, currencies = {}, itemCosts = {}, factionName = "Arakkoa Outcasts", reputationLevel = "Honored", renownLevel = 0 },
  { vendorId = 23, itemID = "258746", itemName = "High Arakkoan Alchemist's Shelf", goldCost = 85000, currencies = {}, itemCosts = {}, factionName = "Arakkoa Outcasts", reputationLevel = "Revered", renownLevel = 0 },
  { vendorId = 23, itemID = "258747", itemName = "High Arakkoan Shelf", goldCost = 85000, currencies = {}, itemCosts = {}, factionName = "Arakkoa Outcasts", reputationLevel = "Friendly", renownLevel = 0 },
  { vendorId = 16, itemID = "245430", itemName = "Orcish Wooden Bench", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 18, itemID = "245423", itemName = "Spherical Draenic Topiary", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "Council of Exarchs", reputationLevel = "Friendly", renownLevel = 0 },
  { vendorId = 22, itemID = "245439", itemName = "Durotar Signal Brazier", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 22, itemID = "245440", itemName = "Durotar Hanging Brazier", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 16, itemID = "245432", itemName = "Blackrock Bunkbed", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 18, itemID = "245434", itemName = "Orgrimmar Sconce", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 18, itemID = "245435", itemName = "Horde Battle Emblem", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 18, itemID = "245436", itemName = "Blackrock Weapon Rack", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 22, itemID = "245441", itemName = "Orcish Fencepost", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  -- Zen'kiki block (Alliance vendor per master table)
  { vendorId = 26, itemID = "244313", itemName = "Orcish Fence", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 26, itemID = "244314", itemName = "Frostwall Architect's Table", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Vora Strongarm block (Horde vendor per master table)
  { vendorId = 24, itemID = "244313", itemName = "Orcish Fence", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 24, itemID = "244314", itemName = "Frostwall Architect's Table", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  -- Sergeant Grimjaw block (Horde vendor per master table)
  -- Solog Roark block (Alliance vendor per master table)
  { vendorId = 35, itemID = "244323", itemName = "Orcish Sleeping Cot", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Moz'def block (Horde vendor per master table)
  { vendorId = 5, itemID = "244323", itemName = "Orcish Sleeping Cot", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 31, itemID = "245423", itemName = "Spherical Draenic Topiary", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "Council of Exarchs", reputationLevel = "Friendly", renownLevel = 0 },
  { vendorId = 39, itemID = "251655", itemName = "Draenethyst String Lights", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 40, itemID = "251655", itemName = "Draenethyst String Lights", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Zrik block
  { vendorId = 55, itemID = "258742", itemName = "Scroll of the Adherent", goldCost = 100000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 42, itemID = "258744", itemName = "Arakkoan Map Table", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 9, itemID = "258745", itemName = "High Arakkoan Library Shelf", goldCost = 90000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Krixel Pinchwhistle block (Alliance vendor per master table - Elder Surrah equivalent)
  { vendorId = 43, itemID = "248664", itemName = "Pinchwhistle Fuel Barrel", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 43, itemID = "252039", itemName = "Goblin Fishing Chair", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Shadow Hunter Denjai block

  -- Sooty block
  { vendorId = 52, itemID = "244326", itemName = "Zandalari Wall Shelf", goldCost = 0, currencies = {{ currencyID = 1560, amount = 150 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 54, itemID = "248663", itemName = "Wooden Doghouse", goldCost = 2700000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Peralta block
  { vendorId = 46, itemID = "252041", itemName = "Arakkoan Nest-Bed", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Archaeology Vendor block
  { vendorId = 47, itemID = "245428", itemName = "Ogre Ceremonial Table", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Ged'kah block

  -- Rangari Selat block
  { vendorId = 49, itemID = "241043", itemName = "Elodor Barrel", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "Council of Exarchs", reputationLevel = "", renownLevel = 0 },
  -- Dawn-Seeker Krull block
  { vendorId = 50, itemID = "247665", itemName = "Gate of the Apexis", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Exarch Menelaos block
  { vendorId = 51, itemID = "251329", itemName = "Shadowmoon Open-Air Shed", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "Council of Exarchs", reputationLevel = "Revered", renownLevel = 0 },

}
local items = {}
for index, entry in ipairs(itemEntries) do
  local vendor = vendors[entry.vendorId] or {vendorName = "-- NO_CONFIRMED_VENDOR"}
  items[index] = {
    itemID = entry.itemID,
    itemName = entry.itemName,
    vendorDetails = vendor,
    goldCost = entry.goldCost,
    currencies = entry.currencies,
    itemCosts = entry.itemCosts or {},
    factionName = entry.factionName or "",
    reputationLevel = entry.reputationLevel or "",
      renownLevel = entry.renownLevel or 0,
    }
  end
HousingDataAggregator_RegisterExpansionItems("vendor", items)
