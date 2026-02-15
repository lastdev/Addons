-- Housing Vendor Items - Wrath of the Lich King (grouped vendor data)
local vendors = {  

  [1] = {
    expansion = "Wrath of the Lich King",
    location = "Borean Tundra",
    vendorName = "Ahlurglgr",
    npcID = 25206,
    faction = 0,
    coords = {x = 43.04, y = 13.81, mapID = 114},
  },
  [2] = {
    expansion = "Wrath of the Lich King",
    location = "Grizzly Hills",
    vendorName = "Woodsman Drake",
    npcID = 27391,
    faction = 1,
    coords = {x = 32.4, y = 59.8, mapID = 116},
  },
  [3] = {
    expansion = "Wrath of the Lich King",
    location = "Nesingwary Base Camp",
    vendorName = "Purser Boulian",
    npcID = 28038,
    faction = 0,
    coords = {x = 26.8, y = 59.2, mapID = 119},
    factionID = "None",
    factionName = "None",
    reputation = "None",
    extra = "None",
  },

  [4] = {
    expansion = "Wrath of the Lich King",
    location = "Sholazar Basin",
    vendorName = "Purser Boulian",
    npcID = 28038,
    faction = 0,
    coords = {x = 26.8, y = 59.2, mapID = 119},
  },
  [5] = {
    expansion = "Wrath of the Lich King",
    location = "Sholazar Basin",
    vendorName = "Purser Boulian",
    npcID = 72111,
    faction = 0,
    coords = {x = 26.8, y = 59.2, mapID = 119},
  },
  [6] = {
    expansion = "Wrath of the Lich King",
    location = "Sholazar Basin",
    vendorName = "Purser Boulian",
    npcID = 61911,
    faction = 0,
    coords = {x = 26.8, y = 59.2, mapID = 119},
  },
  [7] = {
    expansion = "Wrath of the Lich King",
    location = "Dalaran (North)",
    vendorName = "Morta Gage",
    npcID = 253228,
    faction = 0,
    coords = {x = 48.2, y = 40.2, mapID = 125},
  },
  [8] = {
    expansion = "Wrath of the Lich King",
    location = "Dalaran (North)",
    vendorName = "Arcantina",
    npcID = 253229,
    faction = 0,
    coords = {x = 48.0, y = 41.4, mapID = 125},
  },
  [9] = {
    expansion = "Wrath of the Lich King",
    location = "Icecrown (Tournament)",
    vendorName = "Dame Evamere",
    npcID = 34882,
    faction = 0,
    coords = {x = 70.8, y = 23.4, mapID = 118},
  },
  [10] = {
    expansion = "Wrath of the Lich King",
    location = "Dalaran Underbelly",
    vendorName = "Val'zuun",
    npcID = 32517,
    faction = 0,
    coords = {x = 46.2, y = 38.6, mapID = 125},
  },
  [11] = {
    expansion = "Wrath of the Lich King",
    location = "Dalaran",
    vendorName = "Kirin Tor Vendor",
    npcID = 0,
    faction = 0,
    coords = {x = 50.0, y = 45.0, mapID = 125},
  },
}

local itemEntries = {
  -- Ahlurglgr block
  { vendorId = 1, itemID = "258220", itemName = "Murloc Driftwood Hut", goldCost = 0, currencies = {}, itemCosts = {[34597] = 10}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Woodsman Drake block
  { vendorId = 2, itemID = "248622", itemName = "Wooden Outhouse", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Purser Boulian block
  { vendorId = 3, itemID = "248807", itemName = "Nesingwary Mounted Shoveltusk Head", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Morta Gage block
  { vendorId = 7, itemID = "250124", itemName = "Banner of the Ebon Blade", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Arcantina block
  { vendorId = 8, itemID = "245435", itemName = "A Frostbitten Tally", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Dame Evamere block
  { vendorId = 9, itemID = "251022", itemName = "Argent Crusade Bunting", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Val'zuun block
  { vendorId = 10, itemID = "245470", itemName = "Lordaeron Hanging Lantern", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Kirin Tor Vendor block
  { vendorId = 11, itemID = "248106", itemName = "Silver Dalaran Bench", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
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