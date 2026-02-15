-- Housing Vendor Items - Classic (grouped vendor data)
-- Audited & coords updated Jan 2026 â€” no removals/reordering to preserve vendorId references
-- Invalid npcID=0 entries kept as placeholders (coords verified where possible)
local vendors = {
  [1] = {
    expansion = "Classic",
    location = "Eastern Kingdoms",
    vendorName = "Cataloger Rockbottom",
    npcID = 242398,
    faction = 0,
    coords = {x = 47.1, y = 82.6, mapID = 2022},
  },
  [2] = {
    expansion = "Classic",
    location = "Bel'ameth",
    vendorName = "Samantha Buckley",
    npcID = 216888,
    faction = 1,
    coords = {x = 58.0, y = 41.2, mapID = 218},
  },
  [3] = {
    expansion = "The War Within",
    location = "Eversong Woods",
    vendorName = "Caeris Fairdawn",
    npcID = 240838,
    faction = 0,
    coords = {x = 43.52, y = 47.52, mapID = 2395},
  },
  [4] = {
    expansion = "Classic",
    location = "Ruins of Gilneas",
    vendorName = "Wilkinson",
    npcID = 44114,
    faction = 1,
    coords = {x = 20.3, y = 58.2, mapID = 218},
  },
  [5] = {
    expansion = "The War Within",
    location = "Dun Morogh",
    vendorName = "Captain Stonehelm",
    npcID = 50309,
    faction = 1,
    coords = {x = 56.0, y = 47.0, mapID = 87},
  },
  [6] = {
    expansion = "Classic",
    location = "Zul'Aman (Ghostlands)",
    vendorName = "Stolen Royal Vendorbot",
    npcID = 161908,
    faction = 0,
    coords = {x = 73.7, y = 36.9, mapID = 95},
  },
  [7] = {
    expansion = "The War Within",
    location = "Eversong Woods",
    vendorName = "Neriv",
    npcID = 242726,
    faction = 0,
    coords = {x = 43.5, y = 47.5, mapID = 2395},
  },
  [8] = {
    expansion = "The War Within",
    location = "Silvermoon City",
    vendorName = "Naleidea Rivergleam",
    npcID = 242398,
    faction = 2,
    coords = {x = 55.2, y = 72.4, mapID = 110},
  },
  [9] = {
    expansion = "The War Within",
    location = "Stormwind City",
    vendorName = "Riica",
    npcID = 254603,
    faction = 1,
    coords = {x = 77.8, y = 65.8, mapID = 84},
  },
  [10] = {
    expansion = "The War Within",
    location = "Eversong Woods",
    vendorName = "Caeris Fairdawn",
    npcID = 242724,
    faction = 0,
    coords = {x = 43.52, y = 47.52, mapID = 2395},  -- Duplicate of #3; same location
  },
  [11] = {
    expansion = "The War Within",
    location = "Eastern Plaguelands",
    vendorName = "Eadric the Pure",
    npcID = 100196,
    faction = 0,
    coords = {x = 75.6, y = 49.1, mapID = 23},
  },
  [12] = {
    expansion = "The War Within",
    location = "Brawl'gar Arena",
    vendorName = "Dershway the Triggered",
    npcID = 151941,
    faction = 0,
    coords = {x = 50.0, y = 29.0, mapID = 369},
  },
  [13] = {
    expansion = "Classic",
    location = "Thelsamar",
    vendorName = "Innkeeper Belm",
    npcID = 1247,
    faction = 1,
    coords = {x = 34.8, y = 46.8, mapID = 48},
  },
  [14] = {
    expansion = "The War Within",
    location = "Eversong Woods",
    vendorName = "World Vendors",
    npcID = 257633,
    faction = 2,
    coords = {x = 72.0, y = 39.5, mapID = 2395},
  },
  [15] = {
    expansion = "The War Within",
    location = "Zul'Aman",
    vendorName = "Magovu",
    npcID = 240279,
    faction = 0,
    coords = {x = 45.8, y = 65.8, mapID = 2437},
  },
  [16] = {
    expansion = "The War Within",
    location = "Wetlands",
    vendorName = "Stuart Fleming",
    npcID = 3178,
    faction = 1,
    coords = {x = 6.3, y = 57.5, mapID = 56},
  },
  [17] = {
    expansion = "The War Within",
    location = "Silverpine Forest",
    vendorName = "Edwin Harly",
    npcID = 2140,
    faction = 0,  -- Neutral per master table
    coords = {x = 44.1, y = 39.7, mapID = 21},
  },
  [18] = {
    expansion = "The War Within",
    location = "Darnassus",
    vendorName = "Lord Candren",
    npcID = 50307,
    faction = 1,
    coords = {x = 56.3, y = 13.5, mapID = 89},  -- Corrected to Temple Gardens
  },
  [19] = {
    expansion = "The War Within",
    location = "Undercity",
    vendorName = "Captain Donald Adams",
    npcID = 50304,
    faction = 2,
    coords = {x = 63.2, y = 49.0, mapID = 90},
  },
  [20] = {
    expansion = "The War Within",
    location = "Blackrock Depths",
    vendorName = "Plugger Spazzring",
    npcID = 144129,
    faction = 1,
    coords = {x = 49.8, y = 32.2, mapID = 1186},
  },
  [21] = {
    expansion = "The War Within",
    location = "Thunder Bluff",
    vendorName = "Brave Tuho",
    npcID = 50483,
    faction = 2,
    coords = {x = 46.2, y = 50.6, mapID = 88},
  },
  [22] = {
    expansion = "The War Within",
    location = "Searing Gorge",
    vendorName = "Master Smith Burninate",
    npcID = 14624,
    faction = 0,
    coords = {x = 38.6, y = 28.7, mapID = 32},
  },
  [23] = {
    expansion = "The War Within",
    location = "Surwich, Blasted Lands",
    vendorName = "Maurice Essman",
    npcID = 44337,
    faction = 1,
    coords = {x = 45.8, y = 88.6, mapID = 17},
  },
  [24] = {
    expansion = "The War Within",
    location = "Thelsamar, Loch Modan",
    vendorName = "Drac Roughcut",
    npcID = 1465,
    faction = 1,
    coords = {x = 35.6, y = 49.0, mapID = 48},
  },
  [25] = {
    expansion = "The War Within",
    location = "Light's Hope Chapel",
    vendorName = "Fiona",
    npcID = 45417,
    faction = 0,
    coords = {x = 73.8, y = 52.2, mapID = 23},
  },
  [26] = {
    expansion = "The War Within",
    location = "Ironforge",
    vendorName = "Inge Brightview",
    npcID = 253232,
    faction = 1,
    coords = {x = 76.1, y = 8.2, mapID = 87},
  },
  [27] = {
    expansion = "The War Within",
    location = "Hillsbrad Foothills",
    vendorName = "Thanthaldis Snowgleam",
    npcID = 13217,
    faction = 1,
    coords = {x = 44.8, y = 46.4, mapID = 25},
  },
  [28] = {
    expansion = "The War Within",
    location = "Nesingwary Expedition",
    vendorName = "Jaquilina Dramet",
    npcID = 2483,
    faction = 0,
    coords = {x = 43.8, y = 23.2, mapID = 50},
  },
  [29] = {
    expansion = "The War Within",
    location = "Mudsprocket",
    vendorName = "Axle",
    npcID = 23995,
    faction = 0,
    coords = {x = 41.9, y = 73.9, mapID = 70},
  },
  [30] = {
    expansion = "The War Within",
    location = "Chiselgrip",
    vendorName = "Hoddruc Bladebender",
    npcID = 115805,
    faction = 0,
    coords = {x = 46.8, y = 44.6, mapID = 36},
  },
  [31] = {
    expansion = "The War Within",
    location = "Hall of Legends",
    vendorName = "Joruh",
    npcID = 254606,
    faction = 2,
    coords = {x = 38.8, y = 71.93, mapID = 85},
    factionID = "None",
    factionName = "None",
    reputation = "None",
    extra = "None",
  },
  [32] = {
    expansion = "The War Within",
    location = "Ironforge",
    vendorName = "Thargas Anvilmar",
    npcID = 0,
    faction = 1,
    coords = {x = 52.8, y = 43.2, mapID = 87},  -- Corrected approximate Ironforge Military Ward
  },
  [33] = {
    expansion = "The War Within",
    location = "Silvermoon City",
    vendorName = "Magister Kaelis",
    npcID = 0,
    faction = 2,
    coords = {x = 54.6, y = 71.0, mapID = 110},
  },
  [34] = {
    expansion = "Midnight",
    location = "Bel'ameth",
    vendorName = "Dazzel",
    npcID = 219531,
    faction = 0,
    coords = {x = 55.2, y = 33.2, mapID = 218},
  },
  [35] = {
    expansion = "Midnight",
    location = "Bel'ameth",
    vendorName = "Suntreader D'lyana",
    npcID = 219532,
    faction = 0,
    coords = {x = 54.8, y = 32.6, mapID = 218},
  },
  [36] = {
    expansion = "Midnight",
    location = "Bel'ameth",
    vendorName = "Unknown",
    npcID = 0,
    faction = 0,
    coords = {x = 54.8, y = 32.6, mapID = 218},
  },
  [37] = {
    expansion = "The War Within",
    location = "Dornogal",
    vendorName = "Sir Finley Mrrgglton",
    npcID = 219460,
    faction = 0,
    coords = {x = 46.8, y = 44.0, mapID = 2133},
  },
 

  [39] = {
    expansion = "The War Within",
    location = "Dornogal",
    vendorName = "Preyseeker Vark",
    npcID = 225141,
    faction = 0,
    coords = {x = 48.0, y = 41.0, mapID = 2133},
    factionID = "None",
    factionName = "None",
    reputation = "None",
    extra = "Preyseeker Collection (Effigies & Busts) - Nightmare/Hard Prey Hunts + renown",
  },
  [40] = {
    expansion = "Classic",
    location = "Darnassus (via Zidormi)",
    vendorName = "Lord Candren",
    npcID = 50307,
    faction = 1,
    coords = {x = 48.6, y = 63.8, mapID = 89},
    factionID = "None",
    factionName = "None",
    reputation = "None",
    extra = "Worgen's Chicken Coop, Little Wolf's Loo - time-travel required",
  },
  [41] = {
    expansion = "Classic",
    location = "Undercity (Old version, via Zidormi)",
    vendorName = "Captain Donald Adams",
    npcID = "None",
    faction = 2,
    coords = {x = 63.2, y = 48.6, mapID = 90},
    factionID = "None",
    factionName = "None",
    reputation = "None",
    extra = "Lordaeron Fence, Lordaeron Fencepost - time-travel required",
  },
  [42] = {
    expansion = "The War Within",
    location = "Shadowforge City",
    vendorName = "Larkin Thunderbrew",
    npcID = "None",
    faction = 0,
    coords = {x = 45.2, y = 49.0, mapID = 1186},
    factionID = "None",
    factionName = "None",
    reputation = "None",
    extra = "Replica Dark Iron Mole Machine",
  },
  [43] = {
    expansion = "Classic",
    location = "Thunder Bluff",
    vendorName = "Miz'ra",
    npcID = "None",
    faction = 2,
    coords = {x = 46.2, y = 55.4, mapID = 88},
    factionID = "None",
    factionName = "None",
    reputation = "None",
    extra = "Tauren Bluff Rug",
  },
  [44] = {
    expansion = "The War Within",
    location = "Blackrock Depths",
    vendorName = "Shadowforge Vendor",
    npcID = "None",
    faction = 0,
    coords = {x = 38.6, y = 42.0, mapID = 1186},
    factionID = "None",
    factionName = "None",
    reputation = "None",
    extra = "Shadowforge Wooden Box, Shadowforge Grinding Wheel",
  },
  [45] = {
    expansion = "Classic",
    location = "Surwich, Blasted Lands",
    vendorName = "Surwich Merchant",
    npcID = "None",
    faction = 0,
    coords = {x = 44.4, y = 70.7, mapID = 17},
    factionID = "None",
    factionName = "None",
    reputation = "None",
    extra = "Surwich Peddler's Wagon",
  },
  [46] = {
    expansion = "Classic",
    location = "Loch Modan (Thelsamar)",
    vendorName = "Loch Vendor",
    npcID = "None",
    faction = 1,
    coords = {x = 34.2, y = 48.4, mapID = 48},
    factionID = "None",
    factionName = "None",
    reputation = "None",
    extra = "Thelsamar Hanging Lantern",
  },
  [47] = {
    expansion = "Classic",
    location = "E. Plaguelands",
    vendorName = "Fiona",
    npcID = 45417,
    faction = 0,
    coords = {x = 44.8, y = 53.0, mapID = 23},
    factionID = "None",
    factionName = "None",
    reputation = "None",
    extra = "Goldshire Food Cart",
  },
  [48] = {
    expansion = "Classic",
    location = "Searing Gorge",
    vendorName = "Captain Stonehelm",
    npcID = 50309,
    faction = 1,
    coords = {x = 38.6, y = 49.8, mapID = 32},
    factionID = "None",
    factionName = "None",
    reputation = "None",
    extra = "Ironforge Bookcases",
  },
  [49] = {
    expansion = "Classic",
    location = "Alterac Valley",
    vendorName = "Stormpike Quartermaster",
    npcID = "None",
    faction = 1,
    coords = {x = 44.4, y = 31.8, mapID = 91},
    factionID = "None",
    factionName = "None",
    reputation = "None",
    extra = "Square Stormpike Table",
  },
  [50] = {
    expansion = "Wrath of the Lich King",
    location = "Howling Fjord",
    vendorName = "Purser Boulian",
    npcID = 28038,
    faction = 0,
    coords = {x = 58.2, y = 62.2, mapID = 495},
    factionID = "None",
    factionName = "None",
    reputation = "None",
    extra = "Nesingwary Mounted Elk Head",
  },
  [51] = {
    expansion = "Classic",
    location = "Mulgore (Bloodhoof Village)",
    vendorName = "Harb Clawhoof",
    npcID = "None",
    faction = 2,
    coords = {x = 47.4, y = 59.8, mapID = 7},
    factionID = "None",
    factionName = "None",
    reputation = "None",
    extra = "Tauren Waterwheel, Wagons",
  },
  [52] = {
    expansion = "The War Within",
    location = "Blackrock Depths",
    vendorName = "Lamppost Vendor",
    npcID = "None",
    faction = 0,
    coords = {x = 50.8, y = 30.2, mapID = 1186},
    factionID = "None",
    factionName = "None",
    reputation = "None",
    extra = "Shadowforge Lamppost",
  },
  [53] = {
    expansion = "The War Within",
    location = "Orgrimmar",
    vendorName = "Ra (Horde PvP Vendor)",
    npcID = "None",
    faction = 2,
    coords = {x = 38.0, y = 70.0, mapID = 85},
    factionID = "None",
    factionName = "None",
    reputation = "None",
    extra = "Horde Banners, Flags, and Gates",
  },
  [54] = {
    expansion = "Classic",
    location = "Stormwind City",
    vendorName = "Solelo",
    npcID = 0,
    faction = 1,
    coords = {x = 49.4, y = 80.8, mapID = 84},
    factionID = "None",
    factionName = "None",
    reputation = "None",
    extra = "Alliance housing vendor",
  },
  [55] = {
    expansion = "Classic",
    location = "Orgrimmar",
    vendorName = "Lonalo",
    npcID = 0,
    faction = 2,
    coords = {x = 58.6, y = 50.6, mapID = 85},
    factionID = "None",
    factionName = "None",
    reputation = "None",
    extra = "Horde housing vendor",
  },
  [57] = {
    expansion = "Classic",
    location = "Ironforge",
    vendorName = "Dedric Sleetshaper",
    npcID = "None",  -- TODO: Find correct NPC ID
    faction = 1,  -- Alliance
    coords = {x = 53.6, y = 52.8, mapID = 1455},
  },
  [66] = {
    expansion = "Classic",
    location = "Stormwind City",
    vendorName = "Captain Lancy Revshon",
    npcID = 45389,
    faction = 72,
    coords = {x = 75.0, y = 66.0, mapID = 84},
  },

}

local itemEntries = {
  { vendorId = 34, itemID = "264175", itemName = "Amani Strongbox", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 13, itemID = "256330", itemName = "Kharanos Stone Bed", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 28, itemID = "248808", itemName = "Nesingwary Mounted Elk Head", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 31, itemID = "247762", itemName = "Netherstorm Battlefield Flag", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 31, itemID = "247761", itemName = "Uncontested Battlefield Banner", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 31, itemID = "247756", itemName = "Challenger's Dueling Flag", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 31, itemID = "247747", itemName = "Warsong Outriders Flag", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 31, itemID = "247745", itemName = "Horde Dueling Flag", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 3, itemID = "245985", itemName = "Floating Azure Lantern", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  -- Cataloger Rockbottom block
  { vendorId = 1, itemID = "245285", itemName = "Reliquary Storage Crate", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "245287", itemName = "Long Sin'dorei Rug", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "245288", itemName = "Circular Sin'dorei Rug", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "245423", itemName = "Spherical Draenic Topiary", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "245478", itemName = "Lordaeron Sconce", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "245479", itemName = "Blightfire Sconce", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "245480", itemName = "Lordaeron Torch", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "245481", itemName = "Blightfire Torch", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "245283", itemName = "Blood Elven Candelabra", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "245286", itemName = "Rectangular Sin'dorei Rug", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "245508", itemName = "Pandaren Cooking Table", goldCost = 10000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "245433", itemName = "Blackrock Strongbox", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "245603", itemName = "Gilnean Noble's Trellis", goldCost = 3500000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "245605", itemName = "Gilnean Stone Wall", goldCost = 3000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "246222", itemName = "Boralus String Lights", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "247670", itemName = "Pandaren Pantry", goldCost = 10000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "247734", itemName = "Paw'don Well", goldCost = 8000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "247737", itemName = "Stormstout Brew Keg", goldCost = 3000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "251476", itemName = "Embroidered Embaari Tent", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "251479", itemName = "Shadowmoon Greenhouse", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "251481", itemName = "Elodor Armory Rack", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "251483", itemName = "Draenethyst Lantern", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "251484", itemName = "\"Dawning Hope\" Mosaic", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "251493", itemName = "Small Karabor Fountain", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "251551", itemName = "Grand Draenethyst Lamp", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "252036", itemName = "Tidesage's Bookcase", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "252387", itemName = "Boralus Fence", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "252388", itemName = "Boralus Fencepost", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "252394", itemName = "Bowhull Bookcase", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "252396", itemName = "Admiralty's Copper Lantern", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "252398", itemName = "Stormsong Water Pump", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "252402", itemName = "Tidesage's Double Bookshelves", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "252652", itemName = "Copper Stormsong Well", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "256049", itemName = "Sin'dorei Sleeper", goldCost = 50000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "257419", itemName = "Sin'dorei Crafter's Forge", goldCost = 50000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Marie Allen block
  { vendorId = 2, itemID = "246845", itemName = "Tome of Shadowforge Cunning", goldCost = 20000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 2, itemID = "246847", itemName = "Tome of Draenei Faith", goldCost = 20000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 2, itemID = "246848", itemName = "Scribe's Working Notes", goldCost = 20000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 2, itemID = "246860", itemName = "Tome of Forsaken Resilience", goldCost = 20000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Caeris Fairdawn block
  { vendorId = 3, itemID = "246845", itemName = "Tome of Shadowforge Cunning", goldCost = 20000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 3, itemID = "246847", itemName = "Tome of Draenei Faith", goldCost = 20000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 3, itemID = "246848", itemName = "Scribe's Working Notes", goldCost = 20000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 3, itemID = "246860", itemName = "Tome of Forsaken Resilience", goldCost = 20000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Marie Allen block (Alliance vendor for Gilnean items per master table)
  { vendorId = 2, itemID = "245520", itemName = "Gilnean Celebration Keg", goldCost = 1500000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 2, itemID = "245516", itemName = "Gilnean Bench", goldCost = 750000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 2, itemID = "245515", itemName = "Gilnean Wooden Bed", goldCost = 750000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 2, itemID = "245604", itemName = "Arched Rose Trellis", goldCost = 1000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Wilkinson block (Quest: Cry For The Moon per master table)
  { vendorId = 4, itemID = "245624", itemName = "Waning Wood Fence", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Captain Stonehelm block (Horde vendor for Shadowforge items per master table)

  -- Stolen Royal Vendorbot block
  { vendorId = 6, itemID = "253469", itemName = "Ritual-Cursed Sarcophagus", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 6, itemID = "255648", itemName = "Zul'Aman Ancestral Fountain", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 6, itemID = "256925", itemName = "Amani Spearhunter's Spit", goldCost = 0, currencies = {{ currencyID = 3316, amount = 1 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 6, itemID = "256928", itemName = "Banner of the Amani Tribe", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 6, itemID = "264255", itemName = "Amani Trophy Frame", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 6, itemID = "264257", itemName = "Zul'Aman Armament Rest", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 6, itemID = "264334", itemName = "Amani War Drum", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 6, itemID = "264335", itemName = "Colossal Amani Stone Visage", goldCost = 0, currencies = {{ currencyID = 3316, amount = 2500 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 6, itemID = "264479", itemName = "Skyweave Amani Tapestry", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 6, itemID = "264480", itemName = "Greenvine Amani Tapestry", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 6, itemID = "264481", itemName = "Earthhide Amani Tapestry", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 6, itemID = "264715", itemName = "Zul'Aman Flame Cradle", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Neriv block
  { vendorId = 7, itemID = "253485", itemName = "Sin'dorei Honor Stone", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 7, itemID = "253488", itemName = "Diamond Honor Stone", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 7, itemID = "243106", itemName = "Gemmed Eversong Lantern", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 7, itemID = "245282", itemName = "Silvermoon Library Bookcase", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 7, itemID = "244538", itemName = "Silvermoon Sundial", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 7, itemID = "244783", itemName = "Majestic Lightwood Table", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 7, itemID = "245992", itemName = "Ornate Silvermoon Candelabra", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 7, itemID = "251909", itemName = "Eversong Feast Platter", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 7, itemID = "251911", itemName = "Eversong Dessert Platter", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 7, itemID = "251912", itemName = "Goldenmist Grapes", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 7, itemID = "254773", itemName = "\"Eversong Lantern\" Painting", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 7, itemID = "257367", itemName = "Silvermoon Energy Focus", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 7, itemID = "262610", itemName = "Swirling Ritual Pedestal", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 7, itemID = "263211", itemName = "Gilded Eversong Cup", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 7, itemID = "263231", itemName = "Silvermoon Curio Shelves", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 7, itemID = "264248", itemName = "Sin'dorei Storage Jar", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 7, itemID = "264660", itemName = "Ren'dorei Spired Tent", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Naleidea Rivergleam block
  { vendorId = 8, itemID = "245290", itemName = "Long Silvermoon Table", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 8, itemID = "245941", itemName = "Silvermoon Sanctum Focus", goldCost = 0, currencies = {{ currencyID = 3316, amount = 2500 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 8, itemID = "256040", itemName = "Silvermoon Gemmed Chair", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 8, itemID = "257422", itemName = "Gilded Sunfury Chair", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 8, itemID = "263206", itemName = "Plum Eversong Rug", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 8, itemID = "263228", itemName = "Grand Lightwood Table", goldCost = 0, currencies = {{ currencyID = 3316, amount = 2500 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 8, itemID = "263229", itemName = "Ornate Lightwood Table", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 8, itemID = "263234", itemName = "Turning Silvermoon Archives", goldCost = 0, currencies = {{ currencyID = 3316, amount = 2500 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 8, itemID = "264264", itemName = "Gilded Vigil Post", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 8, itemID = "264265", itemName = "Sanctified Flame Lantern", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 8, itemID = "263212", itemName = "Farstrider's Comfy Cushion", goldCost = 0, currencies = {{ currencyID = 3379, amount = 150 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Riica block
  { vendorId = 9, itemID = "244656", itemName = "Silvermoon Painter's Cushion", goldCost = 1500000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 9, itemID = "253606", itemName = "\"Brunch and a Book\" Unframed Painting", goldCost = 15000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 9, itemID = "253609", itemName = "\"River's Protectors\" Unframed Painting", goldCost = 15000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 9, itemID = "253610", itemName = "\"Isolation\" Unframed Painting", goldCost = 15000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 9, itemID = "253611", itemName = "\"The Fallen Protectors\" Unframed Painting", goldCost = 15000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 9, itemID = "253612", itemName = "\"Autumnal Eversong\" Unframed Painting", goldCost = 15000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 9, itemID = "253613", itemName = "\"Reclamation\" Unframed Painting", goldCost = 15000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 9, itemID = "253705", itemName = "\"The Light Blooms\" Unframed Painting", goldCost = 15000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Caeris Fairdawn block
  { vendorId = 3, itemID = "246414", itemName = "Light-Infused Rotunda", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 3, itemID = "252666", itemName = "\"The High Exarch\" Painting", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 3, itemID = "252667", itemName = "\"The Ranger of the Void\" Painting", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 3, itemID = "252668", itemName = "\"The Harbinger\" Painting", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 3, itemID = "252669", itemName = "\"The Redeemer\" Painting", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "263239", itemName = "Cuddly Tan Grrgle", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "263241", itemName = "Cuddly Seafoam Grrgle", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "263242", itemName = "Cuddly Saffron Grrgle", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "263243", itemName = "Cuddly Sage Grrgle", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "263292", itemName = "Cuddly Lavender Grrgle", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "263293", itemName = "Cuddly Pink Grrgle", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "263294", itemName = "Cuddly Gold-Colored Grrgle", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "263295", itemName = "Cuddly Lime Grrgle", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "263296", itemName = "Cuddly Orange Grrgle", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  -- Caeris Fairdawn block (Horde vendor per master table)
  { vendorId = 10, itemID = "263297", itemName = "Cuddly Cerulean Grrgle", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "263300", itemName = "Cuddly Purple Grrgle", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "263301", itemName = "Cuddly Green Grrgle", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "263302", itemName = "Cuddly Red Grrgle", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "263303", itemName = "Cuddly Blue Grrgle", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "264680", itemName = "Cuddly Seagreen Grrgle", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "264681", itemName = "Cuddly Brown Grrgle", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "264682", itemName = "Cuddly Flaxen Grrgle", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "264683", itemName = "Cuddly Sanguine Grrgle", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "264684", itemName = "Cuddly Gumball Grrgle", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "264685", itemName = "Cuddly Violet Grrgle", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "264686", itemName = "Cuddly Olive Grrgle", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "264687", itemName = "Cuddly Plum Grrgle", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "264688", itemName = "Cuddly Tangerine Grrgle", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "264689", itemName = "Cuddly Sapphire Grrgle", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "264690", itemName = "Cuddly Clover Grrgle", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "264691", itemName = "Cuddly Peach Grrgle", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "265387", itemName = "Cuddly Tomato Grrgle", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "265388", itemName = "Cuddly Lemon Grrgle", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "265389", itemName = "Cuddly Cotton Candy Grrgle", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "265390", itemName = "Cuddly Mint Grrgle", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "265391", itemName = "Cuddly Magenta Grrgle", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "265392", itemName = "Cuddly Sunset Grrgle", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "265393", itemName = "Cuddly Mauve Grrgle", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "265394", itemName = "Cuddly Pearl Grrgle", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "265395", itemName = "Cuddly Charcoal Grrgle", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "265396", itemName = "Cuddly Onyx Grrgle", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "265397", itemName = "Cuddly Bright Grrgle", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "265398", itemName = "Cuddly Juniper Grrgle", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "265544", itemName = "Cuddly Basil Grrgle", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "265546", itemName = "Cuddly Fel Grrgle", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "265547", itemName = "Cuddly Spectral Grrgle", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "265548", itemName = "Cuddly Emerald Grrgle", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "265549", itemName = "Cuddly Metallic Grrgle", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "265550", itemName = "Cuddly Verdant Grrgle", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "265551", itemName = "Cuddly Cobalt Grrgle", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "265552", itemName = "Cuddly Teal Grrgle", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 10, itemID = "265553", itemName = "Cuddly Ochre Grrgle", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Eadric the Pure block
  { vendorId = 11, itemID = "245655", itemName = "Filigree Moon Lamp", goldCost = 0, currencies = {{ currencyID = 2003, amount = 10 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 11, itemID = "246487", itemName = "Gnomish Tesla Coil", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 18, itemID = "246601", itemName = "Bolt Chair", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 11, itemID = "247908", itemName = "Nightborne Lantern", goldCost = 300000, currencies = {{ currencyID = 1220, amount = 50 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 11, itemID = "247915", itemName = "Square Suramar Table", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 11, itemID = "248116", itemName = "Valdrakken Chandelier", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 11, itemID = "248934", itemName = "Golden Cloud Serpent Treasure Chest", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 11, itemID = "253168", itemName = "Earthen Storage Crate", goldCost = 10000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 11, itemID = "253173", itemName = "Meadery Storage Barrel", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 11, itemID = "256168", itemName = "Draconic Sconce", goldCost = 0, currencies = {{ currencyID = 2003, amount = 10 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- \ block

  -- Dershway the Triggered block
  -- Items 259071, 263026, 255840 are reputation-gated and in ReputationFactions.lua

  -- Innkeeper Belm block
  { vendorId = 13, itemID = "256905", itemName = "Small Gilnean Table", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- World Vendors block
  { vendorId = 14, itemID = "246425", itemName = "Round Dwarven Table", goldCost = 4000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Magovu block
  { vendorId = 15, itemID = "246425", itemName = "Round Dwarven Table", goldCost = 4000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Stuart Fleming block
  { vendorId = 16, itemID = "246426", itemName = "Ornate Ironforge Table", goldCost = 6000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 16, itemID = "257405", itemName = "Baradin Bay Fishing Rack", goldCost = 2000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Dedric Sleetshaper block (Alliance vendor for Ironforge items per master table)
  { vendorId = 57, itemID = "245426", itemName = "Dark Iron Brazier", goldCost = 7000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 57, itemID = "245427", itemName = "Dark Iron Expedition Tent", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 57, itemID = "252010", itemName = "Ornate Ironforge Bench", goldCost = 4500000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 57, itemID = "256333", itemName = "Ornate Dwarven Wardrobe", goldCost = 10000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 57, itemID = "256425", itemName = "Shadowforge Stone Chair", goldCost = 3500000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Edwin Harly block
  { vendorId = 17, itemID = "246426", itemName = "Ornate Ironforge Table", goldCost = 6000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 17, itemID = "246490", itemName = "Ironforge Fencepost", goldCost = 2500000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 17, itemID = "246491", itemName = "Ironforge Fence", goldCost = 1500000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Lord Candren block
  { vendorId = 18, itemID = "246479", itemName = "Gnomish T.O.O.L.B.O.X.", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 18, itemID = "246480", itemName = "Automated Gnomeregan Guardian", goldCost = 10000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 18, itemID = "246483", itemName = "Redundant Reclamation Rig", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 18, itemID = "246484", itemName = "Mechagon Hanging Floodlight", goldCost = 1000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 18, itemID = "246497", itemName = "Small Emergency Warning Lamp", goldCost = 1000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 18, itemID = "246498", itemName = "Emergency Warning Lamp", goldCost = 1000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 18, itemID = "246499", itemName = "Mechagon Eyelight Lamp", goldCost = 1500000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 18, itemID = "246501", itemName = "Gnomish Safety Flamethrower", goldCost = 2000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 18, itemID = "246503", itemName = "Large H.O.M.E. Cog", goldCost = 1000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 18, itemID = "246598", itemName = "Screw-Sealed Stembarrel", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 18, itemID = "246603", itemName = "Gnomish Cog Stack", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 18, itemID = "246605", itemName = "Mecha-Storage Mecha-Chest", goldCost = 1500000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 18, itemID = "246701", itemName = "Gnomish Sprocket Table", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 18, itemID = "246703", itemName = "Double-Sprocket Table", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Captain Donald Adams block
  { vendorId = 19, itemID = "246692", itemName = "Murder Row Wine Decanter", goldCost = 0, currencies = {{ currencyID = 3379, amount = 150 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Plugger Spazzring block
  { vendorId = 20, itemID = "246779", itemName = "Hanging Mana Brazier", goldCost = 0, currencies = {{ currencyID = 2803, amount = 500 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Master Smith Burninate block
  { vendorId = 22, itemID = "247740", itemName = "Kotmogu Pedestal", goldCost = 0, currencies = {{ currencyID = 1792, amount = 2000 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 22, itemID = "247741", itemName = "Kotmogu Orb of Power", goldCost = 0, currencies = {{ currencyID = 1792, amount = 1000 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 53, itemID = "247750", itemName = "Deephaul Crystal", goldCost = 0, currencies = {{ currencyID = 1792, amount = 2500 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 22, itemID = "247763", itemName = "Berserker's Empowerment", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 22, itemID = "247765", itemName = "Healer's Empowerment", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 22, itemID = "247766", itemName = "Runner's Empowerment", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 22, itemID = "247768", itemName = "Guardian's Empowerment", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 22, itemID = "247769", itemName = "Chaotic Empowerment", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 22, itemID = "247770", itemName = "Mysterious Empowerment", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 53, itemID = "253170", itemName = "Earthen Contender's Target", goldCost = 0, currencies = {{ currencyID = 1792, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 22, itemID = "256896", itemName = "Smoke Lamppost", goldCost = 0, currencies = {{ currencyID = 1792, amount = 450 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  -- Riica block (Alliance PvP vendor per master table)
  { vendorId = 9, itemID = "247744", itemName = "Alliance Dueling Flag", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 9, itemID = "247746", itemName = "Silverwing Sentinels Flag", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 9, itemID = "247756", itemName = "Challenger's Dueling Flag", goldCost = 0, currencies = {{ currencyID = 1792, amount = 1000 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 9, itemID = "247761", itemName = "Uncontested Battlefield Banner", goldCost = 0, currencies = {{ currencyID = 1792, amount = 400 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 9, itemID = "247762", itemName = "Netherstorm Battlefield Flag", goldCost = 0, currencies = {{ currencyID = 1792, amount = 300 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 22, itemID = "247757", itemName = "Alliance Battlefield Banner", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 22, itemID = "247758", itemName = "Fortified Alliance Banner", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Maurice Essman block
  { vendorId = 23, itemID = "248333", itemName = "Stormwind Large Wooden Table", goldCost = 1000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 23, itemID = "248336", itemName = "Stormwind Wooden Table", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 23, itemID = "248617", itemName = "Stormwind Keg Stand", goldCost = 1500000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 23, itemID = "248619", itemName = "Stormwind Gazebo", goldCost = 2500000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 23, itemID = "248620", itemName = "Stormwind Trellis and Basin", goldCost = 1500000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 23, itemID = "248662", itemName = "Jewelcrafter's Tent", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 23, itemID = "248665", itemName = "Stormwind Peddler's Cart", goldCost = 2500000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 23, itemID = "248794", itemName = "Elwynn Fence", goldCost = 500000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 23, itemID = "248795", itemName = "Elwynn Fencepost", goldCost = 750000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 23, itemID = "248798", itemName = "Northshire Barrel", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 23, itemID = "248801", itemName = "Stormwind Weapon Rack", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 23, itemID = "248938", itemName = "Hooded Iron Lantern", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 23, itemID = "248939", itemName = "Stormwind Lamppost", goldCost = 1000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Drac Roughcut block
  { vendorId = 24, itemID = "248797", itemName = "City Wanderer's Candleholder", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Fiona block

  -- Inge Brightview block
  { vendorId = 26, itemID = "250230", itemName = "Replica Altar of Ancient Kings", goldCost = 0, currencies = {{ currencyID = 1220, amount = 2500 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 26, itemID = "250231", itemName = "Silver Hand Banner", goldCost = 0, currencies = {{ currencyID = 1220, amount = 500 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 26, itemID = "250232", itemName = "Sanctum of Light Hallway Rug", goldCost = 0, currencies = {{ currencyID = 1220, amount = 500 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 26, itemID = "250233", itemName = "Replica Libram of Ancient Kings", goldCost = 0, currencies = {{ currencyID = 1220, amount = 2000 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 26, itemID = "250234", itemName = "Sanctum of Light Candelabra", goldCost = 0, currencies = {{ currencyID = 1220, amount = 1200 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 26, itemID = "250235", itemName = "Silver Hand Tribute to the Fallen", goldCost = 0, currencies = {{ currencyID = 1220, amount = 1000 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 26, itemID = "250236", itemName = "Silver Hand Weapon Rack", goldCost = 0, currencies = {{ currencyID = 1220, amount = 1500 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Thanthaldis Snowgleam block

  -- Jacquilina Dramet block

  -- Axle block
  -- Axle block (Alliance vendor per master table)
  { vendorId = 29, itemID = "256923", itemName = "Amani Crafter's Tool Rack", goldCost = 0, currencies = {{ currencyID = 3377, amount = 800 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 29, itemID = "264249", itemName = "Woodblock Stool", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 29, itemID = "264254", itemName = "Three-Tier Zul'Aman Shelf", goldCost = 0, currencies = {{ currencyID = 3377, amount = 800 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 29, itemID = "264655", itemName = "Amani Slate Bench", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Hoddruc Bladebender block

  -- Joruh block
  { vendorId = 31, itemID = "243088", itemName = "Standing Ornate Weapon Rack", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 31, itemID = "256924", itemName = "Hash'ey Heartbroth Cauldron", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 31, itemID = "256926", itemName = "Empty Amani Cauldron", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 31, itemID = "256927", itemName = "Carved Idol of Nalorakk, Loa of War", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 31, itemID = "256933", itemName = "Carved Idol of Jan'alai, Loa of Fire", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 31, itemID = "256934", itemName = "Boiling Amani Cauldron", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 31, itemID = "258290", itemName = "Carved Idol of Halazzi, Loa of the Hunt", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 31, itemID = "258549", itemName = "Burning Amani Pinecone", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 31, itemID = "260202", itemName = "Visage of Akil'zon, Loa of Victory", goldCost = 0, currencies = {{ currencyID = 3316, amount = 2500 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 31, itemID = "260514", itemName = "Visage of Nalorakk, Loa of War", goldCost = 0, currencies = {{ currencyID = 3316, amount = 2500 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 31, itemID = "260515", itemName = "Visage of Halazzi, Loa of the Hunt", goldCost = 0, currencies = {{ currencyID = 3316, amount = 2500 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 31, itemID = "260516", itemName = "Visage of Jan'alai, Loa of Fire", goldCost = 0, currencies = {{ currencyID = 3316, amount = 2500 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 31, itemID = "263318", itemName = "Simple Amani Basket", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 31, itemID = "263320", itemName = "Rope-Bound Amani Basket", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 31, itemID = "264333", itemName = "Amani Incense Burner", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 31, itemID = "264350", itemName = "Carved Idol of Akil'zon, Loa of Victory", goldCost = 0, currencies = {{ currencyID = 3316, amount = 750 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Thargas Anvilmar block
  { vendorId = 32, itemID = "246108", itemName = "Embellished Dwarven Tome", goldCost = 20000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Magister Kaelis block
  { vendorId = 33, itemID = "245581", itemName = "Silvermoon Round Interior Pillar", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 33, itemID = "245582", itemName = "Silvermoon Interior Narrow Wall", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 33, itemID = "245583", itemName = "Silvermoon Interior Wall", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 33, itemID = "245649", itemName = "Silvermoon Interior Doorway", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 33, itemID = "257412", itemName = "Stoppered Gilnean Barrel", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Dazzel block
  { vendorId = 34, itemID = "258535", itemName = "Simple Bone-Tied Charm", goldCost = 0, currencies = {{ currencyID = 3373, amount = 1200 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 34, itemID = "258536", itemName = "Windmark Tribal Charm", goldCost = 0, currencies = {{ currencyID = 3373, amount = 1200 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 34, itemID = "258537", itemName = "Amani Dreamer's Charm", goldCost = 0, currencies = {{ currencyID = 3373, amount = 1200 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 34, itemID = "258538", itemName = "Barebone Rope Charm", goldCost = 0, currencies = {{ currencyID = 3373, amount = 1200 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 34, itemID = "264251", itemName = "Depthdiver's Cooking Spit", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 34, itemID = "264252", itemName = "Zul'Aman Forest Hammock", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Suntreader D'lyana block
  { vendorId = 35, itemID = "263203", itemName = "Rack of Silvermoon Arms", goldCost = 0, currencies = {{ currencyID = 3379, amount = 150 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 35, itemID = "264270", itemName = "[DNT] [AUTOGEN] 12BE_BloodElf_Ritual_Tome_Bloodknight01_Open.m2", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Unknown block
  { vendorId = 36, itemID = "263224", itemName = "Gentle Floating Planter", goldCost = 0, currencies = {{ currencyID = 3379, amount = 150 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 36, itemID = "263225", itemName = "Sunlit Glass Mirror", goldCost = 0, currencies = {{ currencyID = 3379, amount = 150 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Sir Finley Mrrgglton block
  { vendorId = 37, itemID = "263994", itemName = "Fungal Chest", goldCost = 0, currencies = {{ currencyID = 3316, amount = 500 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 37, itemID = "263995", itemName = "Delver's Bountiful Coffer", goldCost = 0, currencies = {{ currencyID = 3316, amount = 500 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 37, itemID = "263996", itemName = "Twilight Tabernacle", goldCost = 0, currencies = {{ currencyID = 3316, amount = 500 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 37, itemID = "264007", itemName = "Corewarden's Spoils", goldCost = 0, currencies = {{ currencyID = 3316, amount = 500 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 37, itemID = "264170", itemName = "Ancient Kaldorei Coffer", goldCost = 0, currencies = {{ currencyID = 3316, amount = 500 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },


  -- Preyseeker Vark block
  { vendorId = 39, itemID = "265681", itemName = "Preyseeker's Magister Effigy", goldCost = 0, currencies = {{ currencyID = 3392, amount = 1200 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 39, itemID = "265682", itemName = "Preyseeker's Tinker Effigy", goldCost = 0, currencies = {{ currencyID = 3392, amount = 1200 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 39, itemID = "265683", itemName = "Preyseeker's Ethereal Effigy", goldCost = 0, currencies = {{ currencyID = 3392, amount = 1200 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 34, itemID = "265685", itemName = "Preyseeker's Amani Effigy", goldCost = 0, currencies = {{ currencyID = 3392, amount = 1200 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 39, itemID = "265686", itemName = "Preyseeker's Rutaani Effigy", goldCost = 0, currencies = {{ currencyID = 3392, amount = 1200 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 39, itemID = "265687", itemName = "Preyseeker's Vindicator Effigy", goldCost = 0, currencies = {{ currencyID = 3392, amount = 1200 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 34, itemID = "265688", itemName = "Preyseeker's Consul Effigy", goldCost = 0, currencies = {{ currencyID = 3392, amount = 1200 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 39, itemID = "265689", itemName = "Preyseeker's Executor Effigy", goldCost = 0, currencies = {{ currencyID = 3392, amount = 1200 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 39, itemID = "265690", itemName = "Preyseeker's Knight-Errant Effigy", goldCost = 0, currencies = {{ currencyID = 3392, amount = 1200 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 39, itemID = "265691", itemName = "Preyseeker's Wretched Effigy", goldCost = 0, currencies = {{ currencyID = 3392, amount = 1200 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 39, itemID = "265692", itemName = "Preyseeker's Thornspeaker Effigy", goldCost = 0, currencies = {{ currencyID = 3392, amount = 1200 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 39, itemID = "265694", itemName = "Preyseeker's Twilight Effigy", goldCost = 0, currencies = {{ currencyID = 3392, amount = 1200 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 39, itemID = "265696", itemName = "Preyseeker's Magister Bust", goldCost = 0, currencies = {{ currencyID = 3392, amount = 800 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 39, itemID = "265697", itemName = "Preyseeker's Tinker Bust", goldCost = 0, currencies = {{ currencyID = 3392, amount = 800 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 39, itemID = "265698", itemName = "Preyseeker's Ethereal Bust", goldCost = 0, currencies = {{ currencyID = 3392, amount = 800 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 34, itemID = "265700", itemName = "Preyseeker's Amani Bust", goldCost = 0, currencies = {{ currencyID = 3392, amount = 800 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 39, itemID = "265701", itemName = "Preyseeker's Rutaani Bust", goldCost = 0, currencies = {{ currencyID = 3392, amount = 800 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 39, itemID = "265702", itemName = "Preyseeker's Vindicator Bust", goldCost = 0, currencies = {{ currencyID = 3392, amount = 800 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 34, itemID = "265703", itemName = "Preyseeker's Consul Bust", goldCost = 0, currencies = {{ currencyID = 3392, amount = 800 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 39, itemID = "265704", itemName = "Preyseeker's Executor Bust", goldCost = 0, currencies = {{ currencyID = 3392, amount = 800 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 39, itemID = "265705", itemName = "Preyseeker's Knight-Errant Bust", goldCost = 0, currencies = {{ currencyID = 3392, amount = 800 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 39, itemID = "265706", itemName = "Preyseeker's Wretched Bust", goldCost = 0, currencies = {{ currencyID = 3392, amount = 800 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 39, itemID = "265707", itemName = "Preyseeker's Thornspeaker Bust", goldCost = 0, currencies = {{ currencyID = 3392, amount = 800 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 39, itemID = "265708", itemName = "Preyseeker's Twilight Bust", goldCost = 0, currencies = {{ currencyID = 3392, amount = 800 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 39, itemID = "265794", itemName = "Preyseeker's Plinth", goldCost = 0, currencies = {{ currencyID = 3392, amount = 800 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 39, itemID = "265795", itemName = "Preyseeker's Ornate Plinth", goldCost = 0, currencies = {{ currencyID = 3392, amount = 1200 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 39, itemID = "265796", itemName = "Preyseeker's Ren'dorei Effigy", goldCost = 0, currencies = {{ currencyID = 3392, amount = 1200 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 39, itemID = "265797", itemName = "Preyseeker's Farstrider Effigy", goldCost = 0, currencies = {{ currencyID = 3392, amount = 1200 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 39, itemID = "265798", itemName = "Preyseeker's Ren'dorei Bust", goldCost = 0, currencies = {{ currencyID = 3392, amount = 800 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 39, itemID = "265799", itemName = "Preyseeker's Farstrider Bust", goldCost = 0, currencies = {{ currencyID = 3392, amount = 800 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Lord Candren block
  { vendorId = 40, itemID = "245518", itemName = "Worgen's Chicken Coop", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 40, itemID = "245620", itemName = "Little Wolf's Loo", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Captain Donald Adams block
  { vendorId = 41, itemID = "245504", itemName = "Lordaeron Fence", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 41, itemID = "245505", itemName = "Lordaeron Fencepost", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Larkin Thunderbrew block
  { vendorId = 20, itemID = "245291", itemName = "Replica Dark Iron Mole Machine", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Brave Tuho block (Alliance vendor per master table)
  { vendorId = 21, itemID = "243335", itemName = "Tauren Bluff Rug", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Miz'ra block (Horde vendor per master table)
  { vendorId = 43, itemID = "243335", itemName = "Tauren Bluff Rug", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Shadowforge Vendor blockitemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 44, itemID = "246409", itemName = "Shadowforge Grinding Wheel", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Surwich Merchant block
  { vendorId = 45, itemID = "244777", itemName = "Surwich Peddler's Wagon", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Loch Vendor block
  { vendorId = 46, itemID = "246422", itemName = "Thelsamar Hanging Lantern", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Fiona block
  { vendorId = 47, itemID = "248796", itemName = "Goldshire Food Cart", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Captain Stonehelm block
  { vendorId = 48, itemID = "246411", itemName = "Ironforge Bookcase", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 48, itemID = "246412", itemName = "Small Ironforge Bookcase", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Stormpike Quartermaster block
  { vendorId = 49, itemID = "246424", itemName = "Square Stormpike Table", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Purser Boulian block

  -- Harb Clawhoof block (Horde vendor per master table)

  -- Lamppost Vendor block
  { vendorId = 52, itemID = "256331", itemName = "Shadowforge Lamppost", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Ra (Horde PvP Vendor) block
  { vendorId = 53, itemID = "247763", itemName = "Berserker's Empowerment", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 53, itemID = "247765", itemName = "Healer's Empowerment", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 53, itemID = "247766", itemName = "Runner's Empowerment", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 53, itemID = "247768", itemName = "Guardian's Empowerment", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 53, itemID = "247769", itemName = "Chaotic Empowerment", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 53, itemID = "247770", itemName = "Mysterious Empowerment", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 53, itemID = "256896", itemName = "Smoke Lamppost", goldCost = 0, currencies = {{ currencyID = 1792, amount = 450 }}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 53, itemID = "247727", itemName = "Iron Dragonmaw Gate", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 53, itemID = "247759", itemName = "Horde Battlefield Banner", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 53, itemID = "247760", itemName = "Fortified Horde Banner", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Solelo block (Alliance)
  { vendorId = 54, itemID = "239177", itemName = "Open Tome of Twilight Nihilism", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 54, itemID = "239179", itemName = "Tome of Twilight Nihilism", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 54, itemID = "245410", itemName = "Abandoned Bookcase", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 54, itemID = "250627", itemName = "Forbidden Fork", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Lonalo block (Horde)
  { vendorId = 55, itemID = "239177", itemName = "Open Tome of Twilight Nihilism", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 55, itemID = "239179", itemName = "Tome of Twilight Nihilism", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 55, itemID = "245410", itemName = "Abandoned Bookcase", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 55, itemID = "250627", itemName = "Forbidden Fork", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Captain Lancy Revshon block (Alliance vendor per master table)
  { vendorId = 66, itemID = "243088", itemName = "Standing Ornate Weapon Rack", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 66, itemID = "256673", itemName = "Stormwind Forge", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 56, itemID = "246874", itemName = "Sturdy Brazier", goldCost = 1100000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 56, itemID = "250092", itemName = "Small Wooden Footstool", goldCost = 150000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 56, itemID = "264278", itemName = "Sturdy Portable Ice Chest", goldCost = 1200000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

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
