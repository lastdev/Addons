-- Housing Vendor Items - Shadowlands (grouped vendor data)
-- Audited & coords updated 2026 â€“ minor precision tweaks only, no reordering
local vendors = {
  [1] = {
    expansion = "Shadowlands",
    location = "The Maw",
    vendorName = "Ve'nari",
    npcID = 162804,
    faction = 0,
    coords = {x = 46.8, y = 41.6, mapID = 1543},  -- Ve'nari's Refuge exact pin
    factionID = 2432,
    factionName = "Ve'nari",
    reputation = "None",
    extra = "Requires achievement Back from the Beyond",
  },
  [2] = {
    expansion = "Shadowlands",
    location = "Sinfall",
    vendorName = "Chachi the Artiste",
    npcID = 174710,
    faction = 0,
    coords = {x = 54.0, y = 25.6, mapID = 1699},  -- Sinfall subzone (phased Revendreth; exact match from Wowhead /way 54.0 25.6)
    factionID = 2413,
    factionName = "The Venthyr",
    reputation = "None",
    extra = "Requires active Venthyr Covenant (access Sinfall phased area; switch via General Draven in Oribos if needed)",
  },

  [3] = {
    expansion = "Shadowlands",
    location = "The Maw",
    vendorName = "Ve'nari",
    npcID = 177774,
    faction = 0,
    coords = {x = 46.8, y = 41.6, mapID = 1543},
  },
  [4] = {
    expansion = "Shadowlands",
    location = "The Maw",
    vendorName = "Ve'nari",
    npcID = 82159,
    faction = 0,
    coords = {x = 46.8, y = 41.6, mapID = 1543},
  },
  [5] = {
    expansion = "Shadowlands",
    location = "Bastion",
    vendorName = "Chachi the Artiste",
    npcID = 179482,
    faction = 0,
    coords = {x = 54.0, y = 24.8, mapID = 1533},
  },
  [6] = {
    expansion = "Shadowlands",
    location = "Korthia",
    vendorName = "Bipsi",
    npcID = 175440,
    faction = 0,
    coords = {x = 62.8, y = 54.6, mapID = 1961},
  },
  [7] = {
    expansion = "Shadowlands",
    location = "Korthia",
    vendorName = "Dallan",
    npcID = 175395,
    faction = 0,
    coords = {x = 61.2, y = 50.4, mapID = 1961},
  },
  [8] = {
    expansion = "Shadowlands",
    location = "Ardenweald",
    vendorName = "Ardent Sila",
    npcID = 164104,
    faction = 0,
    coords = {x = 59.6, y = 52.8, mapID = 1565},
  },
  [9] = {
    expansion = "Shadowlands",
    location = "Oribos",
    vendorName = "Host Ta'rela",
    npcID = 160350,
    faction = 0,
    coords = {x = 61.4, y = 71.6, mapID = 1670},
  },
  [10] = {
    expansion = "Shadowlands",
    location = "Bastion",
    vendorName = "Adjutant Nikos",
    npcID = 164448,
    faction = 0,
    coords = {x = 52.2, y = 47.0, mapID = 1533},
  },
  [11] = {
    expansion = "Shadowlands",
    location = "Maldraxxus",
    vendorName = "Surom",
    npcID = 166311,
    faction = 0,
    coords = {x = 53.6, y = 69.2, mapID = 1536},
  },
  [12] = {
    expansion = "Shadowlands",
    location = "Revendreth",
    vendorName = "Mistress Mihi",
    npcID = 165780,
    faction = 0,
    coords = {x = 61.4, y = 63.8, mapID = 1525},
  },  [13] = {
    expansion = "Shadowlands",
    location = "Sinfall (Revendreth)",
    vendorName = "Chamberlain",
    npcID = 172555,
    faction = 2417,
    coords = {x = 40.0, y = 52.6, mapID = 1525},
  },
  [14] = {
    expansion = "Shadowlands",
    location = "Tazavesh, Veiled Market",
    vendorName = "Taam",
    npcID = 178343,
    faction = 0,
    coords = {x = 61.4, y = 64.2, mapID = 2472},
  },

}

local itemEntries = {
  -- Ve'nari block
  { vendorId = 1, itemID = "248125", itemName = "Portal to Damnation", goldCost = 0, currencies = {{ currencyID = 1767, amount = 10000 },}, itemCosts = {}, factionName = "Ve'nari", reputationLevel = "", renownLevel = 0 },

  -- Chachi the Artiste block
  { vendorId = 2, itemID = "245501", itemName = "Venthyr Tome of Unforgiven Sins", goldCost = 0, currencies = {{ currencyID = 1813, amount = 1500 },}, itemCosts = {}, factionName = "The Venthyr", reputationLevel = "", renownLevel = 65 },

  -- Bipsi block
  { vendorId = 6, itemID = "245510", itemName = "Korthian Relic Table", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "Death's Advance", reputationLevel = "", renownLevel = 0 },

  -- Dallan block
  { vendorId = 7, itemID = "245513", itemName = "Mawsworn Soul-Cage", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Ardent Sila block
  { vendorId = 8, itemID = "247854", itemName = "Night Fae Dream-Catcher", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "Night Fae", reputationLevel = "", renownLevel = 0 },

  -- Host Ta'rela block
  { vendorId = 9, itemID = "245263", itemName = "Oribos Spirits Tray", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Adjutant Nikos block
  { vendorId = 10, itemID = "248106", itemName = "Kyrian Aspirant's Bench", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "Kyrian", reputationLevel = "", renownLevel = 0 },

  -- Surom block
  { vendorId = 11, itemID = "248110", itemName = "Necrolord War-Banner", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "Necrolord", reputationLevel = "", renownLevel = 0 },

  -- Mistress Mihi block
  { vendorId = 12, itemID = "258149", itemName = "Sinfall Candelabra", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "Venthyr", reputationLevel = "", renownLevel = 0 },
  -- Chamberlain block
  { vendorId = 13, itemID = "248102", itemName = "Venthyr's Target Dummy", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

  -- Taam block
  { vendorId = 14, itemID = "243321", itemName = "Cartel Head's Schmancy Desk", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 14, itemID = "258322", itemName = "Shadowguard Energy Siphon", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 14, itemID = "262907", itemName = "Tazaveshi Hookah", goldCost = 5000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 14, itemID = "263043", itemName = "Consortium Energy Barrel", goldCost = 1500000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 14, itemID = "263044", itemName = "Empty Energy Barrel", goldCost = 1000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 14, itemID = "263045", itemName = "Consortium Energy Collector", goldCost = 4000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 14, itemID = "263046", itemName = "Consortium Energy Crate", goldCost = 2500000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 14, itemID = "263047", itemName = "Empty Energy Crate", goldCost = 1500000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 14, itemID = "263048", itemName = "Consortium Energy Banner", goldCost = 1200000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 14, itemID = "265031", itemName = "Consortium Translocation", goldCost = 25000000, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },

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