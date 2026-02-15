-- Housing Vendor Items - BurningCrusade (grouped vendor data)
local vendors = {
  [1] = {
    expansion = "Burning Crusade",
    location = "Shattrath",
    vendorName = "Provisioner Vredigar",
    npcID = 16528,
    faction = 2,
    coords = {x = 48.0, y = 46.2, mapID = 111},  -- Scryers quartermaster
  },
  [2] = {
    expansion = "Burning Crusade",
    location = "Shattrath",
    vendorName = "Quartermaster Endarin",
    npcID = 19321,
    faction = 1,
    coords = {x = 48.2, y = 26.2, mapID = 111},  -- Aldor quartermaster
  },
  [3] = {
    expansion = "Burning Crusade",
    location = "Nagrand",
    vendorName = "Koren",
    npcID = 21432,
    faction = 0,
    coords = {x = 42.8, y = 42.6, mapID = 107},  -- Halaa - requires faction control
  },
  [4] = {
    expansion = "Burning Crusade",
    location = "Tanaris",
    vendorName = "Alurmi",
    npcID = 21643,
    faction = 0,
    coords = {x = 50.8, y = 70.8, mapID = 71},  -- Keepers of Time quartermaster
  },
  [5] = {
    expansion = "Burning Crusade",
    location = "Shattrath",
    vendorName = "Shattrath Engineering Trainers",
    npcID = 0,  -- Multiple trainers sell these recipes
    faction = 0,
    coords = {x = 43.6, y = 42.0, mapID = 111},  -- Lower City area
  },
  [6] = {
    expansion = "Burning Crusade",
    location = "Zangarmarsh",
    vendorName = "Fedryen Swiftspear",
    npcID = 0,
    faction = 970,  -- Sporeggar
    coords = {x = 78.5, y = 62.9, mapID = 102},
  },
  [7] = {
    expansion = "Burning Crusade",
    location = "Nagrand",
    vendorName = "Consortium Trader",
    npcID = 0,
    faction = 0,
    coords = {x = 43.6, y = 34.2, mapID = 104},
  },  [8] = {
    expansion = "The Burning Crusade",
    location = "Sporeggar (Zangarmarsh)",
    vendorName = "Mycah",
    npcID = 18382,
    faction = 970,
    coords = {x = 17.8, y = 51.2, mapID = 102},
  },
  [9] = {
    expansion = "The Burning Crusade",
    location = "Azuremyst Isle (Azure Watch)",
    vendorName = "Quartermaster Ikaros",
    npcID = 17544,
    faction = 930,
    coords = {x = 47.6, y = 70.6, mapID = 97},
  },
  [10] = {
    expansion = "The Burning Crusade",
    location = "Azuremyst Isle (Azure Watch) - Quartermaster Ikaros",
    vendorName = "Artificer's Rep",
    npcID = 17544,
    faction = 930,
    coords = {x = 47.6, y = 70.6, mapID = 97},
  },

}

local itemEntries = {
  -- Provisioner Vredigar block (Scryers)
  { vendorId = 1, itemID = "256049", itemName = "Sin'dorei Sleeper", goldCost = 5000, currencies = {}, itemCosts = {}, factionName = "Scryers", reputationLevel = "", renownLevel = 0 },
  { vendorId = 1, itemID = "257419", itemName = "Sin'dorei Crafter's Forge", goldCost = 5000, currencies = {}, itemCosts = {}, factionName = "Scryers", reputationLevel = "", renownLevel = 0 },

  -- Quartermaster Endarin block (Aldor)
  { vendorId = 2, itemID = "256044", itemName = "Draenei Sleeper", goldCost = 5000, currencies = {}, itemCosts = {}, factionName = "Aldor", reputationLevel = "", renownLevel = 0 },
  { vendorId = 2, itemID = "257417", itemName = "Draenei Crafter's Forge", goldCost = 5000, currencies = {}, itemCosts = {}, factionName = "Aldor", reputationLevel = "", renownLevel = 0 },

  -- Koren block (Halaa)
  { vendorId = 3, itemID = "252044", itemName = "Halaa Bench", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 }, -- Requires faction control of Halaa

  -- Alurmi block (Keepers of Time)
  { vendorId = 4, itemID = "252046", itemName = "Keepers of Time Map", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "Keepers of Time", reputationLevel = "Revered", renownLevel = 0 },

  -- Shattrath Engineering Trainers block
  { vendorId = 5, itemID = "251998", itemName = "Shattrath Lamppost", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 }, -- Engineering recipe
  { vendorId = 5, itemID = "251999", itemName = "Shattrath Sconce", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 }, -- Engineering recipe

  -- Fedryen Swiftspear block
  { vendorId = 6, itemID = "246802", itemName = "Zangarshroom Patch", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "Sporeggar", reputationLevel = "", renownLevel = 0 },
  { vendorId = 6, itemID = "246803", itemName = "Arched Wooden Bench", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "Sporeggar", reputationLevel = "", renownLevel = 0 },
  { vendorId = 6, itemID = "247773", itemName = "Sturdy Zangarshelf", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "Sporeggar", reputationLevel = "", renownLevel = 0 },
  { vendorId = 6, itemID = "247774", itemName = "Orange Zangarmarsh Tree", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "Sporeggar", reputationLevel = "", renownLevel = 0 },
  { vendorId = 6, itemID = "247775", itemName = "Glowing Zangarshroom Bowl", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "Sporeggar", reputationLevel = "", renownLevel = 0 },
  { vendorId = 6, itemID = "247776", itemName = "Glowing Zangarshroom Cup", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "Sporeggar", reputationLevel = "", renownLevel = 0 },
  { vendorId = 6, itemID = "247777", itemName = "Blue Zangarmarsh Tree", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "Sporeggar", reputationLevel = "", renownLevel = 0 },
  { vendorId = 6, itemID = "247780", itemName = "Withered Zangarmarsh Tree", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "Sporeggar", reputationLevel = "", renownLevel = 0 },

  -- Consortium Trader block
  { vendorId = 7, itemID = "262666", itemName = "K'areshi Incense Burner", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 7, itemID = "262667", itemName = "Oath Scale", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "", reputationLevel = "", renownLevel = 0 },
  { vendorId = 7, itemID = "262664", itemName = "K'areshi Wrappings Vol 11", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "The Consortium", reputationLevel = "", renownLevel = 0 },
  { vendorId = 7, itemID = "262665", itemName = "K'areshi Projector", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "The Consortium", reputationLevel = "", renownLevel = 0 },
  -- Mycah block
  { vendorId = 8, itemID = "247764", itemName = "Enigmatic Purple Crystal", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "Sporeggar", reputationLevel = "Exalted", renownLevel = 0 },
  { vendorId = 8, itemID = "247771", itemName = "Zangarmarsh Lamppost", goldCost = 0, currencies = {{ currencyID = 24245, amount = 15 }}, itemCosts = {}, factionName = "Sporeggar", reputationLevel = "", renownLevel = 0 },
  { vendorId = 8, itemID = "247772", itemName = "Small Zangarshroom Patch", goldCost = 0, currencies = {{ currencyID = 24245, amount = 10 }}, itemCosts = {}, factionName = "Sporeggar", reputationLevel = "", renownLevel = 0 },
  { vendorId = 8, itemID = "247778", itemName = "Green Zangarmarsh Tree", goldCost = 0, currencies = {{ currencyID = 24245, amount = 25 }}, itemCosts = {}, factionName = "Sporeggar", reputationLevel = "", renownLevel = 0 },
  { vendorId = 8, itemID = "247779", itemName = "Purple Zangarmarsh Tree", goldCost = 0, currencies = {{ currencyID = 24245, amount = 25 }}, itemCosts = {}, factionName = "Sporeggar", reputationLevel = "", renownLevel = 0 },
  { vendorId = 8, itemID = "247781", itemName = "Glowing Withered Tree", goldCost = 0, currencies = {{ currencyID = 24245, amount = 30 }}, itemCosts = {}, factionName = "Sporeggar", reputationLevel = "", renownLevel = 0 },
  { vendorId = 8, itemID = "247782", itemName = "Pulsing Zangarshroom", goldCost = 0, currencies = {{ currencyID = 24245, amount = 20 }}, itemCosts = {}, factionName = "Sporeggar", reputationLevel = "", renownLevel = 0 },

  -- Quartermaster Ikaros block
  { vendorId = 9, itemID = "251547", itemName = "Draenei Farmer's Trellis", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "Exodar", reputationLevel = "Exalted", renownLevel = 0 },

  -- Artificer's Rep block
  { vendorId = 10, itemID = "265331", itemName = "Draenei Holo-Junction", goldCost = 0, currencies = {}, itemCosts = {}, factionName = "Exodar", reputationLevel = "Exalted", renownLevel = 0 },

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