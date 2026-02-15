-- Housing Vendor Items - Cataclysm (grouped vendor data)
local vendors = {  
  [1] = {
    expansion = "Cataclysm",
    location = "Bel'ameth",
    vendorName = "Marie Allen",
    npcID = 211065,
    faction = 0,
    coords = {x = 58.0, y = 41.2, mapID = 217},
  },
  [2] = {
    expansion = "Cataclysm",
    location = "Twilight Highlands",
    vendorName = "Breana Bitterbrand",
    npcID = 253227,
    faction = 1,
    coords = {x = 49.6, y = 29.4, mapID = 241},
  },
  [3] = {
    expansion = "Cataclysm",
    location = "The Maelstrom (Order Hall)",
    vendorName = "Flamesmith Lanying",
    npcID = 112318,
    faction = 0,
    coords = {x = 30.32, y = 60.69, mapID = 726},
  },
  [4] = {
    expansion = "Cataclysm",
    location = "Twilight Highlands",
    vendorName = "Materialist Ophinell",
    npcID = 45408,
    faction = 1172,
    coords = {x = 49.0, y = 81.0, mapID = 241},
  },

  [5] = {
    expansion = "Cataclysm",
    location = "Silvermoon City",
    vendorName = "Dethelin",
    npcID = 0,
    faction = 0,
    coords = {x = 0, y = 0, mapID = 110},
    extra = "Post-event vendor (available after March 2, 2026). Items use Resonance Crystals currency (converted from Twilight's Blade Insignias).",
  },

}


local itemEntries = {
  -- Marie Allen block
  { vendorId = 1, itemID = "245520", itemName = "Gilnean Celebration Keg", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },  -- Achievement "Reclamation of Gilneas" unlock
  { vendorId = 1, itemID = "245516", itemName = "Gilnean Bench", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "245515", itemName = "Gilnean Wooden Bed", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "245604", itemName = "Arched Rose Trellis", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "245617", itemName = "Gilnean Stocks", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "258301", itemName = "Gilnean Washing Line", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Breana Bitterbrand block
  { vendorId = 2, itemID = "246427", itemName = "Dilapidated Wildhammer Well", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },  -- Quest reward unlock
  { vendorId = 2, itemID = "246428", itemName = "Overgrown Wildhammer Fountain", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 2, itemID = "246108", itemName = "Embellished Dwarven Tome", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 2, itemID = "246425", itemName = "Round Dwarven Table", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Flamesmith Lanying block
  { vendorId = 3, itemID = "250914", itemName = "Elemental Altar of the Maelstrom", goldCost = 0, currencies = {{ currencyID = 1220, amount = 2500 },}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 2, itemID = "250915", itemName = "Replica Words of Wind and Earth", goldCost = 0, currencies = {{ currencyID = 1220, amount = 2000 },}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 2, itemID = "250916", itemName = "Pedestal of Maelstrom's Wisdom", goldCost = 0, currencies = {{ currencyID = 1220, amount = 500 },}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 2, itemID = "250918", itemName = "Maelstrom Banner", goldCost = 0, currencies = {{ currencyID = 1220, amount = 1000 },}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 2, itemID = "251014", itemName = "Earthen Ring Scouting Map", goldCost = 0, currencies = {{ currencyID = 1220, amount = 1500 },}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 2, itemID = "251015", itemName = "Maelstrom Chimes", goldCost = 0, currencies = {{ currencyID = 1220, amount = 500 },}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 2, itemID = "257403", itemName = "Maelstrom Lava Lamp", goldCost = 0, currencies = {{ currencyID = 1220, amount = 1200 },}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  -- Materialist Ophinell block (Twilight Ascension event vendor - available until March 2, 2026)
  { vendorId = 4, itemID = "245284", itemName = "Silvermoon Wooden Chair", goldCost = 0, currencies = {{ currencyID = 3319, amount = 50 }}, itemCosts = {}, factionName = "Twilight's Blade", reputationLevel = "", renownLevel = 0 }, -- Requires quest "The Cult Within"
  { vendorId = 4, itemID = "251997", itemName = "Sin'dorei Winged Chaise", goldCost = 0, currencies = {{ currencyID = 3319, amount = 75 }}, itemCosts = {}, factionName = "Twilight's Blade", reputationLevel = "", renownLevel = 0 }, -- Requires quest "The Cult Within"
  { vendorId = 4, itemID = "245330", itemName = "Enchanted Blood Elven Candelabra", goldCost = 0, currencies = {{ currencyID = 3319, amount = 50 }}, itemCosts = {}, factionName = "Twilight's Blade", reputationLevel = "", renownLevel = 0 }, -- Requires quest "The Cult Within"

  -- Dethelin block (Post-event vendor - available after March 2, 2026 in Silvermoon City)
  -- All items will use Resonance Crystals currency (Twilight's Blade Insignias convert to Resonance Crystals)
  { vendorId = 5, itemID = "245281", itemName = "Sin'dorei Display Case", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 }, -- Post-event: Available (New) - Uses Resonance Crystals
  { vendorId = 5, itemID = "250868", itemName = "Crimson Crystal Column", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 }, -- Post-event: Available (New) - Uses Resonance Crystals
  { vendorId = 5, itemID = "250869", itemName = "Crimson Crystal Core", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 }, -- Post-event: Available (New) - Uses Resonance Crystals
  { vendorId = 5, itemID = "250870", itemName = "Crimson Crystal Fragment", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 }, -- Post-event: Available (New) - Uses Resonance Crystals

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