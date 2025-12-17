-- Reputation Faction Rewards

if not HousingReputations then
    HousingReputations = {}
end

HousingReputations = {
  -- Classic

[47] = { label = "Ironforge", rep = "standard", expansion = "Classic", faction = "Alliance", vendor = { npcID = 50309, name = "Captain Stonehelm", zone = "Ironforge", subzone = "The Great Forge", coords = { x = 55.80, y = 47.80, mapID = 87 } }, rewards = { { itemID = 246490, requiredStanding = "Friendly" }, { itemID = 246491, requiredStanding = "Friendly" }, { itemID = 252010, requiredStanding = "Honored" }, { itemID = 246426, requiredStanding = "Honored" } } },
[72] = { label = "Stormwind", rep = "standard", expansion = "Classic", faction = "Alliance", vendor = { npcID = 49877, name = "Captain Lancy Revshon", zone = "Stormwind City", subzone = "Trade District", coords = { x = 67.60, y = 72.80, mapID = 84 } }, rewards = { { itemID = 248795, requiredStanding = "Friendly" }, { itemID = 248794, requiredStanding = "Friendly" }, { itemID = 248939, requiredStanding = "Honored" }, { itemID = 248333, requiredStanding = "Honored" }, { itemID = 248620, requiredStanding = "Revered" }, { itemID = 248617, requiredStanding = "Revered" }, { itemID = 248665, requiredStanding = "Exalted" } } },

  -- The Burning Crusade

[922] = { label = "Tranquillien", rep = "standard", expansion = "The Burning Crusade", faction = "Horde", vendor = { npcID = 16528, name = "Provisioner Vredigar", zone = "Ghostlands", subzone = "Tranquillien", coords = { x = 47.60, y = 32.20, mapID = 95 } }, rewards = { { itemID = 256049, requiredStanding = "Exalted" } } },

  -- Cataclysm

[1134] = { label = "Gilneas", rep = "standard", expansion = "Cataclysm", faction = "Alliance", vendor = { npcID = 50307, name = "Lord Candren", zone = "Darnassus", subzone = "Temple Gardens", coords = { x = 37.00, y = 47.80, mapID = 89 } }, rewards = { { itemID = 245605, requiredStanding = "Honored" } } },
[1174] = { label = "Wildhammer Clan", rep = "standard", expansion = "Cataclysm", faction = "Alliance", vendor = { name = "Breana Bitterbrand", zone = "Twilight Highlands", subzone = "Thundermar", coords = { x = 49.60, y = 29.60, mapID = 241 } }, rewards = { { itemID = 246425, requiredStanding = "Friendly" } } },

  -- Mists of Pandaria

[1271] = { label = "Order of the Cloud Serpent", rep = "standard", expansion = "Mists of Pandaria", vendor = { npcID = 58414, name = "San Redscale", zone = "The Jade Forest", coords = { x = 56.60, y = 44.40, mapID = 371 } }, rewards = { { itemID = 247732, requiredStanding = "Honored" } } },
[1273] = { label = "Jogu the Drunk", rep = "friendship", expansion = "Mists of Pandaria", group = "The Tillers", vendor = { npcID = 58706, name = "Gina Mudclaw", zone = "Valley of the Four Winds", subzone = "Halfhill", coords = { x = 52.20, y = 48.60, mapID = 376 } } },
[1275] = { label = "Ella", rep = "friendship", expansion = "Mists of Pandaria", group = "The Tillers", vendor = { npcID = 58706, name = "Gina Mudclaw", zone = "Valley of the Four Winds", coords = { x = 52.20, y = 48.60, mapID = 376 } } },
[1280] = { label = "Tina Mudclaw", rep = "friendship", expansion = "Mists of Pandaria", group = "The Tillers", vendor = { npcID = 58706, name = "Gina Mudclaw", zone = "Valley of the Four Winds", coords = { x = 52.20, y = 48.60, mapID = 376 } } },
[1283] = { label = "Farmer Fung", rep = "friendship", expansion = "Mists of Pandaria", group = "The Tillers", vendor = { npcID = 58706, name = "Gina Mudclaw", zone = "Valley of the Four Winds", coords = { x = 52.20, y = 48.60, mapID = 376 } } },
[1345] = { label = "The Lorewalkers", rep = "standard", expansion = "Mists of Pandaria", vendor = { npcID = 64605, name = "Tan Shin Tiao", zone = "Vale of Eternal Blossoms", coords = { x = 82.20, y = 29.40, mapID = 390 } }, rewards = { { itemID = 245512, requiredStanding = "Friendly" }, { itemID = 247662, requiredStanding = "Honored" }, { itemID = 247855, requiredStanding = "Honored" }, { itemID = 247663, requiredStanding = "Revered" } } },

  -- Warlords of Draenor

[1708] = { label = "Laughing Skull Orcs", rep = "standard", expansion = "Warlords of Draenor", faction = "Horde", vendor = { npcID = 86698, name = "Kil'rip", zone = "Frostfire Ridge", coords = { x = 47.30, y = 66.40, mapID = 525 } }, rewards = { { itemID = 245431, requiredStanding = "Friendly" } } },
[1710] = { label = "Sha'tari Defense", rep = "standard", expansion = "Warlords of Draenor", faction = "Alliance", vendor = { npcID = 85427, name = "Maaria", zone = "Shadowmoon Valley", coords = { x = 29.80, y = 14.20, mapID = 539 } }, rewards = { { itemID = 245424, requiredStanding = "Friendly" } } },
[1731] = { label = "Council of Exarchs", rep = "standard", expansion = "Warlords of Draenor", faction = "Alliance", vendor = { npcID = 85932, name = "Vindicator Nuurem", zone = "Ashran", coords = { x = 40.39, y = 97.11, mapID = 588 } }, rewards = { { itemID = 251483, requiredStanding = "Friendly" }, { itemID = 245423, requiredStanding = "Friendly" }, { itemID = 251493, requiredStanding = "Honored" }, { itemID = 251481, requiredStanding = "Honored" }, { itemID = 251484, requiredStanding = "Revered" }, { itemID = 251476, requiredStanding = "Revered" }, { itemID = 251551, requiredStanding = "Exalted" } } },

  -- Legion

[1828] = { label = "Highmountain Tribe", rep = "standard", expansion = "Legion", vendor = { npcID = 106902, name = "Ransa Greyfeather", zone = "Highmountain", coords = { x = 45.33, y = 60.39, mapID = 650 } }, rewards = { { itemID = 245458, requiredStanding = "Friendly" }, { itemID = 245454, requiredStanding = "Friendly" }, { itemID = 248985, requiredStanding = "Honored" }, { itemID = 245452, requiredStanding = "Honored" }, { itemID = 245270, requiredStanding = "Revered" }, { itemID = 243359, requiredStanding = "Revered" }, { itemID = 245450, requiredStanding = "Exalted" } } },
[1859] = { label = "The Nightfallen", rep = "standard", expansion = "Legion", vendor = { npcID = 97140, name = "First Arcanist Thalyssra", zone = "Suramar", coords = { x = 37.00, y = 46.20, mapID = 680 } }, rewards = { { itemID = 247910, requiredStanding = "Friendly" }, { itemID = 247921, requiredStanding = "Friendly" }, { itemID = 247844, requiredStanding = "Honored" }, { itemID = 247845, requiredStanding = "Honored" }, { itemID = 247847, requiredStanding = "Revered" }, { itemID = 247924, requiredStanding = "Revered" }, { itemID = 244536, requiredStanding = "Exalted" }, { itemID = 246850, requiredStanding = "Exalted" }, { itemID = 245448, requiredStanding = "Exalted" }, { itemID = 244654, requiredStanding = "Friendly" }, { itemID = 244676, requiredStanding = "Honored" }, { itemID = 244677, requiredStanding = "Revered" }, { itemID = 244678, requiredStanding = "Friendly" }, { itemID = 246001, requiredStanding = "Honored" } } },
[1883] = { label = "Dreamweavers", rep = "standard", expansion = "Legion", vendor = { npcID = 253387, name = "Sylvia Hartshorn", zone = "Val'sharah", coords = { x = 54.60, y = 73.20, mapID = 641 } }, rewards = { { itemID = 251494, requiredStanding = "Friendly" }, { itemID = 238861, requiredStanding = "Honored" }, { itemID = 264168, requiredStanding = "Honored" }, { itemID = 245261, requiredStanding = "Revered" } } },

  -- Battle for Azeroth

[2103] = { label = "Zandalari Empire", rep = "standard", expansion = "Battle for Azeroth", faction = "Horde", vendor = { npcID = 252326, name = "T'lama", zone = "Dazar'alor", coords = { x = 49.80, y = 42.40, mapID = 1165 } }, rewards = { { itemID = 245521, requiredStanding = "Friendly" }, { itemID = 243113, requiredStanding = "Honored" }, { itemID = 243130, requiredStanding = "Honored" }, { itemID = 256919, requiredStanding = "Revered" } } },
[2156] = { label = "Talanji's Expedition", rep = "standard", expansion = "Battle for Azeroth", faction = "Horde", vendor = { npcID = 135459, name = "Provisioner Lija", zone = "Nazmir", coords = { x = 39.00, y = 79.40, mapID = 863 } }, rewards = { { itemID = 257394, requiredStanding = "Honored" }, { itemID = 245413, requiredStanding = "Honored" }, { itemID = 245500, requiredStanding = "Revered" } } },
[2157] = { label = "The Honorbound", rep = "standard", expansion = "Battle for Azeroth", faction = "Horde", vendor = { npcID = 251921, name = "Provisioner Mukra", zone = "Zuldazar", coords = { x = 58.00, y = 62.60, mapID = 862 } }, rewards = { { itemID = 245480, requiredStanding = "Honored" }, { itemID = 245478, requiredStanding = "Honored" }, { itemID = 245481, requiredStanding = "Revered" } } },
[2160] = { label = "Proudmoore Admiralty", rep = "standard", expansion = "Battle for Azeroth", faction = "Alliance", vendor = { npcID = 135808, name = "Provisioner Fray", zone = "Boralus", coords = { x = 67.50, y = 21.60, mapID = 1161 } }, rewards = { { itemID = 252388, requiredStanding = "Friendly" }, { itemID = 252387, requiredStanding = "Friendly" }, { itemID = 246222, requiredStanding = "Honored" }, { itemID = 252402, requiredStanding = "Revered" } } },
[2162] = { label = "Storm's Wake", rep = "standard", expansion = "Battle for Azeroth", faction = "Alliance", vendor = { npcID = 252313, name = "Caspian", zone = "Stormsong Valley", coords = { x = 59.40, y = 69.60, mapID = 942 } }, rewards = { { itemID = 252396, requiredStanding = "Friendly" }, { itemID = 252398, requiredStanding = "Honored" }, { itemID = 252394, requiredStanding = "Revered" } } },
[2391] = { label = "Rustbolt Resistance", rep = "standard", expansion = "Battle for Azeroth", vendor = { npcID = 150716, name = "Stolen Royal Vendorbot", zone = "Mechagon", coords = { x = 73.60, y = 36.60, mapID = 1462 } }, rewards = { { itemID = 246497, requiredStanding = "Friendly" }, { itemID = 246484, requiredStanding = "Friendly" }, { itemID = 246503, requiredStanding = "Honored" }, { itemID = 246498, requiredStanding = "Honored" }, { itemID = 246605, requiredStanding = "Revered" }, { itemID = 246499, requiredStanding = "Revered" }, { itemID = 246501, requiredStanding = "Exalted" } } },

  -- Dragonflight

[2510] = { label = "Valdrakken Accord", rep = "renown", expansion = "Dragonflight", vendor = { npcID = 253067, name = "Silvrath", zone = "Valdrakken", subzone = "Valdrakken", coords = { x = 72.00, y = 49.60, mapID = 2112 } }, rewards = { { itemID = 256169, requiredStanding = "Renown 3" }, { itemID = 248112, requiredStanding = "Renown 6" }, { itemID = 248103, requiredStanding = "Renown 14" } } },

  -- The War Within

[0] = { label = "None", rep = "standard", expansion = "The War Within" },
[2669] = { label = "Darkfuse Solutions", rep = "standard", expansion = "The War Within", vendor = { npcID = 231396, name = "Sitch Lowdown", zone = "Undermine", coords = { x = 30.60, y = 38.80, mapID = 2346 } }, rewards = { { itemID = 256327, requiredStanding = "Friendly" } } },
[2671] = { label = "Venture Company", rep = "standard", expansion = "The War Within", vendor = { npcID = 231407, name = "Shredz the Scrapper", zone = "Undermine", coords = { x = 53.20, y = 72.60, mapID = 2346 } }, rewards = { { itemID = 245311, requiredStanding = "Honored" } } },
[2673] = { label = "Bilgewater Cartel", rep = "standard", expansion = "The War Within", vendor = { npcID = 231406, name = "Rocco Razzboom", zone = "Undermine", coords = { x = 39.00, y = 22.00, mapID = 2346 } }, rewards = { { itemID = 255674, requiredStanding = "Honored" } } },
[2675] = { label = "Blackwater Cartel", rep = "standard", expansion = "The War Within", vendor = { npcID = 231405, name = "Boatswain Hardee", zone = "Undermine", coords = { x = 63.20, y = 16.80, mapID = 2346 } }, rewards = { { itemID = 255642, requiredStanding = "Honored" } } },
[2677] = { label = "Steamwheedle Cartel", rep = "standard", expansion = "The War Within", vendor = { npcID = 231408, name = "Lab Assistant Laszly", zone = "Undermine", coords = { x = 27.20, y = 72.40, mapID = 2346 } }, rewards = { { itemID = 245321, requiredStanding = "Friendly" } } },
[2688] = { label = "Flame's Radiance", rep = "renown", expansion = "The War Within", vendor = { npcID = 240852, name = "Lars Bronsmaelt", zone = "Hallowfall", coords = { x = 28.20, y = 56.20, mapID = 2215 } } },

}
