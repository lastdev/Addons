-- Portal Data
-- Contains portal locations for smart navigation
-- Includes both zone coordinates (x, y in 0-100 format) and world coordinates (worldX, worldY in yards)
-- Zone coordinates are used for basic waypoint setting
-- World coordinates are used for GPS pathfinding
-- Source: PortalHelper v2.2.16 (Dec 2025) - Post-Midnight (11.2) layouts

HousingPortalData = {
  -- Stormwind City portals
  ["Stormwind City"] = {
    {
      name = "Deeprun Tram to Ironforge",
      x = 69.51,
      y = 31.21,
      mapID = 84,  -- Stormwind City map ID
      destinationMapID = 499, -- Deeprun Tram
      destinationExpansion = "Classic"
    },
    {
      name = "Portal to Darnassus",
      x = 42.0,
      y = 65.0,
      mapID = 84,  -- Stormwind City map ID
      destinationExpansion = "Classic"
    },
    {
      name = "Portal to Teldrassil",
      x = 42.0,
      y = 65.0,
      mapID = 84,  -- Stormwind City map ID
      destinationExpansion = "Classic"
    },
    {
      name = "Portal to Exodar",
      x = 43.64,
      y = 87.21,
      mapID = 84,  -- Stormwind City map ID
      destinationExpansion = "The Burning Crusade",
      -- GPS coordinates for pathfinding
      worldX = 965.4,
      worldY = -9006.1,
      zoneMapID = 84
    },
    {
      name = "Caverns of Time",
      x = 43.78,
      y = 85.47,
      mapID = 84,  -- Stormwind City map ID - Portal Room
      destinationExpansion = "Cataclysm",
      -- GPS coordinates for pathfinding
      worldX = 963.0,
      worldY = -8985.0,
      zoneMapID = 84
    },
    {
      name = "Shattrath",
      x = 44.83,
      y = 85.83,
      mapID = 84,  -- Stormwind City map ID - Portal Room
      destinationExpansion = "The Burning Crusade",
      -- GPS coordinates for pathfinding
      worldX = 943.1,
      worldY = -8989.2,
      zoneMapID = 84
    },
    {
      name = "Dalaran (Northrend)",
      x = 44.40,
      y = 88.62,
      mapID = 84,  -- Stormwind City map ID - Portal Room
      destinationExpansion = "Wrath of the Lich King",
      -- GPS coordinates for pathfinding
      worldX = 952.0,
      worldY = -9023.4,
      zoneMapID = 84
    },
    {
      name = "Paw'don Village",
      x = 45.68,
      y = 87.19,
      mapID = 84,  -- Stormwind City map ID - Portal Room (Jade Forest)
      destinationExpansion = "Mists of Pandaria",
      -- GPS coordinates for pathfinding
      worldX = 928.6,
      worldY = -9005.2,
      zoneMapID = 84
    },
    {
      name = "Stormshield",
      x = 41.23,
      y = 89.98,
      mapID = 84,  -- Stormwind City map ID - Portal Room
      destinationExpansion = "Warlords of Draenor",
      -- GPS coordinates for pathfinding
      worldX = 1004.3,
      worldY = -9036.7,
      zoneMapID = 84
    },
    {
      name = "Azsuna (Crumbled Palace)",
      x = 41.99,
      y = 91.48,
      mapID = 84,  -- Stormwind City map ID - Portal Room
      destinationExpansion = "Legion",
      -- GPS coordinates for pathfinding
      worldX = 991.5,
      worldY = -9053.6,
      zoneMapID = 84
    },
    {
      name = "Portal to Bel'ameth",
      x = 43.35,
      y = 97.52,
      mapID = 84,  -- Stormwind City map ID - Portal Room
      destinationExpansion = "Dragonflight",
      zoneMapID = 84
    },
    {
      name = "Boralus",
      x = 48.68,
      y = 95.05,
      mapID = 84,  -- Stormwind City map ID - Portal Room
      destinationExpansion = "Battle for Azeroth",
      -- GPS coordinates for pathfinding
      worldX = 875.4,
      worldY = -9099.3,
      zoneMapID = 84
    },
    {
      name = "Oribos",
      x = 47.67,
      y = 94.85,
      mapID = 84,  -- Stormwind City map ID - Portal Room
      destinationExpansion = "Shadowlands",
      -- GPS coordinates for pathfinding
      continentMapID = 0,  -- Eastern Kingdoms
      worldX = 896.4,
      worldY = -9095.6,
      zoneMapID = 84
    },
    {
      name = "Valdrakken",
      x = 48.80,
      y = 93.51,
      mapID = 84,  -- Stormwind City map ID - Portal Room
      destinationExpansion = "Dragonflight",
      -- GPS coordinates for pathfinding
      continentMapID = 0,  -- Eastern Kingdoms
      worldX = 872.9,
      worldY = -9077.6,
      zoneMapID = 84
    },
    {
      name = "Portal to Dornogal",
      x = 48.07,
      y = 92.01,
      mapID = 84,  -- Stormwind City map ID - Portal Room
      destinationExpansion = "The War Within",
      -- GPS coordinates for pathfinding
      worldX = 886.6,
      worldY = -9060.7,
      zoneMapID = 84
    },
    {
      name = "Portal to Founder's Point",
      x = 47.02,
      y = 93.27,
      mapID = 84,  -- Stormwind City map ID - Portal Room
      destinationExpansion = "The War Within",
      destinationMapID = 2352,  -- Founder's Point map ID
      -- GPS coordinates for pathfinding
      worldX = 907.7,
      worldY = -9077.3,
      zoneMapID = 84
    },
    {
      name = "Portal to Hall of Awakening",
      x = 51.55,
      y = 10.09,
      mapID = 84,
      destinationExpansion = "The War Within",
      destinationMapID = 2322,
      worldX = 827.0,
      worldY = -8112.7,
      zoneMapID = 84
    },
    {
      name = "Portal to Shadowforge City",
      x = 49.79,
      y = 10.45,
      mapID = 84,
      destinationExpansion = "The War Within",
      destinationMapID = 2369,
      zoneMapID = 84
    },
    {
      name = "Rift to Telogrus",
      x = 50.71,
      y = 8.34,
      mapID = 84,
      destinationExpansion = "Battle for Azeroth",
      destinationMapID = 971,
      zoneMapID = 84
    },
    {
      name = "Portal to Mechagon City",
      x = 48.78,
      y = 8.94,
      mapID = 84,
      destinationExpansion = "Battle for Azeroth",
      destinationMapID = 1462,
      zoneMapID = 84
    },
    {
      name = "Lightforged Beacon",
      x = 48.12,
      y = 11.39,
      mapID = 84,
      destinationExpansion = "Legion",
      destinationMapID = 650,
      zoneMapID = 84
    },
    {
      name = "Portal to Orgrimmar",
      x = 50.0,
      y = 71.0,
      mapID = 84  -- Stormwind City map ID
    },
    {
      name = "Portal to Undercity",
      x = 50.0,
      y = 71.0,
      mapID = 84  -- Stormwind City map ID
    },
    {
      name = "Portal to Thunder Bluff",
      x = 50.0,
      y = 71.0,
      mapID = 84  -- Stormwind City map ID
    },
    {
      name = "Portal to Silvermoon",
      x = 50.0,
      y = 71.0,
      mapID = 84  -- Stormwind City map ID
    }
  },

  -- Orgrimmar portals
  ["Orgrimmar"] = {
    {
      name = "Portal to Thunder Bluff",
      x = 50.0,
      y = 60.0,
      mapID = 85,  -- Orgrimmar map ID
      destinationExpansion = "Classic"
    },
    {
      name = "Portal to Undercity",
      x = 50.0,
      y = 60.0,
      mapID = 85,  -- Orgrimmar map ID
      destinationExpansion = "Classic"
    },
    {
      name = "Portal to Silvermoon",
      x = 50.0,
      y = 60.0,
      mapID = 85,  -- Orgrimmar map ID
      destinationExpansion = "The Burning Crusade"
    },
    {
      name = "Portal to Durotar",
      x = 50.0,
      y = 60.0,
      mapID = 85,  -- Orgrimmar map ID
      destinationExpansion = "Classic"
    },
    {
      name = "Caverns of Time",
      x = 46.0,
      y = 37.5,
      mapID = 85,  -- Orgrimmar map ID (Plateau north of Valley of Wisdom, portals circle Farseer Krogar NPC)
      destinationExpansion = "Cataclysm",
      -- GPS coordinates for pathfinding
      worldX = -4487.4,
      worldY = 1413.4,
      zoneMapID = 85
    },
    {
      name = "Dalaran (Northrend)",
      x = 48.5,
      y = 42.5,
      mapID = 85,  -- Orgrimmar map ID - Portal Room (back center)
      destinationExpansion = "Wrath of the Lich King",
      -- GPS coordinates for pathfinding
      worldX = -4484.8,
      worldY = 1422.9,
      zoneMapID = 85
    },
    {
      name = "Shattrath",
      x = 42.5,
      y = 38.0,
      mapID = 85,  -- Orgrimmar map ID - Portal Room (left side)
      destinationExpansion = "The Burning Crusade",
      -- GPS coordinates for pathfinding
      worldX = -4506.8,
      worldY = 1423.4,
      zoneMapID = 85
    },
    {
      name = "Paw'don Glade",
      x = 43.0,
      y = 41.5,
      mapID = 85,  -- Orgrimmar map ID - Portal Room (back left)
      destinationExpansion = "Mists of Pandaria",
      -- GPS coordinates for pathfinding
      worldX = -4505.8,
      worldY = 1417.2,
      zoneMapID = 85
    },
    {
      name = "Valdrakken",
      x = 54.5,
      y = 38.0,
      mapID = 85,  -- Orgrimmar map ID - Portal Room (right side)
      destinationExpansion = "Dragonflight",
      -- GPS coordinates for pathfinding
      worldX = -4499.9,
      worldY = 1474.7,
      zoneMapID = 85
    },
    {
      name = "Oribos",
      x = 52.0,
      y = 38.5,
      mapID = 85,  -- Orgrimmar map ID - Portal Room (center-right)
      destinationExpansion = "Shadowlands",
      -- GPS coordinates for pathfinding
      worldX = -4520.9,
      worldY = 1468.5,
      zoneMapID = 85
    },
    {
      name = "Dornogal",
      x = 48.5,
      y = 34.0,
      mapID = 85,  -- Orgrimmar map ID - Portal Room (front center)
      destinationExpansion = "The War Within",
      -- GPS coordinates for pathfinding
      worldX = -4525.2,
      worldY = 1427.0,
      zoneMapID = 85
    },
    {
      name = "Razorwind Shores",
      x = 57.45,
      y = 89.54,
      mapID = 85,  -- Orgrimmar map ID - Portal Room
      destinationExpansion = "Midnight",
      -- GPS coordinates for pathfinding
      worldX = -4531.7,
      worldY = 1448.8,
      zoneMapID = 85
    },
    {
      name = "Portal to Razorwind Shores",
      x = 53.93,
      y = 49.44,
      mapID = 85,  -- Orgrimmar map ID - Portal Room
      destinationExpansion = "Midnight",
      -- GPS coordinates for pathfinding
      worldX = -4531.7,
      worldY = 1448.8,
      zoneMapID = 85
    },
    {
      name = "Portal to Dornogal",
      x = 38.19,
      y = 27.24,
      mapID = 85,  -- Orgrimmar map ID - Portal Room
      destinationExpansion = "The War Within",
      -- GPS coordinates for pathfinding
      worldX = -4525.2,
      worldY = 1427.0,
      zoneMapID = 85
    },
    {
      name = "Oribos Portal",
      x = 58.25,
      y = 87.99,
      mapID = 85,  -- Orgrimmar map ID - Portal Room
      destinationExpansion = "Shadowlands",
      -- GPS coordinates for pathfinding
      worldX = -4520.9,
      worldY = 1468.5,
      zoneMapID = 85
    },
    {
      name = "Valdrakken Portal",
      x = 57.09,
      y = 87.26,
      mapID = 85,  -- Orgrimmar map ID - Portal Room
      destinationExpansion = "Dragonflight",
      -- GPS coordinates for pathfinding
      worldX = -4499.9,
      worldY = 1474.7,
      zoneMapID = 85
    },
    {
      name = "Dalaran, Crystalsong Forest",
      x = 56.20,
      y = 91.61,
      mapID = 85,  -- Orgrimmar map ID - Portal Room
      destinationExpansion = "Wrath of the Lich King",
      -- GPS coordinates for pathfinding
      worldX = -4484.8,
      worldY = 1422.9,
      zoneMapID = 85
    },
    {
      name = "Jade Forest Portal",
      x = 57.45,
      y = 92.16,
      mapID = 85,  -- Orgrimmar map ID - Portal Room
      destinationExpansion = "Mists of Pandaria",
      -- GPS coordinates for pathfinding
      worldX = -4505.8,
      worldY = 1417.2,
      zoneMapID = 85
    },
    {
      name = "Dornogal Portal",
      x = 58.56,
      y = 91.33,
      mapID = 85,  -- Orgrimmar map ID - Portal Room
      destinationExpansion = "The War Within",
      -- GPS coordinates for pathfinding
      worldX = -4525.2,
      worldY = 1427.0,
      zoneMapID = 85
    },
    {
      name = "Silvermoon Portal",
      x = 54.78,
      y = 90.31,
      mapID = 85,  -- Orgrimmar map ID - Portal Room
      destinationExpansion = "The Burning Crusade",
      -- GPS coordinates for pathfinding
      worldX = -4506.8,
      worldY = 1423.4,
      zoneMapID = 85
    },
    {
      name = "Warspear, Ashran",
      x = 55.24,
      y = 91.95,
      mapID = 85,  -- Orgrimmar map ID - Portal Room
      destinationExpansion = "Warlords of Draenor",
      -- GPS coordinates for pathfinding
      worldX = -4466.4,
      worldY = 1419.0,
      zoneMapID = 85
    },
    {
      name = "Caverns of Time",
      x = 56.36,
      y = 92.49,
      mapID = 85,  -- Orgrimmar map ID - Portal Room
      destinationExpansion = "Cataclysm",
      -- GPS coordinates for pathfinding
      worldX = -4487.4,
      worldY = 1413.4,
      zoneMapID = 85
    },
    {
      name = "Shattrah",
      x = 57.44,
      y = 91.58,
      mapID = 85,  -- Orgrimmar map ID - Portal Room
      destinationExpansion = "The Burning Crusade",
      -- GPS coordinates for pathfinding
      worldX = -4506.8,
      worldY = 1423.4,
      zoneMapID = 85
    },
    {
      name = "Zuldazar",
      x = 57.82,
      y = 89.83,
      mapID = 85,  -- Orgrimmar map ID - Portal Room
      destinationExpansion = "Battle for Azeroth",
      -- GPS coordinates for pathfinding
      worldX = -4513.1,
      worldY = 1445.1,
      zoneMapID = 85
    },
    {
      name = "Azsuna",
      x = 57.17,
      y = 88.31,
      mapID = 85,  -- Orgrimmar map ID - Portal Room
      destinationExpansion = "Legion",
      -- GPS coordinates for pathfinding
      worldX = -4501.7,
      worldY = 1463.3,
      zoneMapID = 85
    },
    {
      name = "Portal to Hall of Awakening",
      mapID = 85,
      destinationExpansion = "The War Within",
      worldX = -4157.3,
      worldY = 1603.1,
      zoneMapID = 85
    },
    {
      name = "Portal to Thunder Totem",
      mapID = 85,
      destinationExpansion = "Legion",
      worldX = -4170.1,
      worldY = 1613.9,
      zoneMapID = 85
    },
    {
      name = "Silvermoon City",
      x = 50.0,
      y = 60.0,
      mapID = 85,  -- Orgrimmar map ID - Cleft of Shadow
      destinationExpansion = "The Burning Crusade"
    },
    {
      name = "Thrallmar Mage (via NPC)",
      x = 46.0,
      y = 37.5,
      mapID = 85,  -- Orgrimmar map ID - Caverns of Time location
      destinationExpansion = "Classic"
    },
    {
      name = "Dazar'alor",
      x = 46.5,
      y = 41.0,
      mapID = 85,  -- Orgrimmar map ID - Portal Room (back left area)
      destinationExpansion = "Battle for Azeroth",
      -- GPS coordinates for pathfinding
      worldX = -4513.1,
      worldY = 1445.1,
      zoneMapID = 85
    },
    {
      name = "Warspear",
      x = 54.0,
      y = 41.5,
      mapID = 85,  -- Orgrimmar map ID - Portal Room (back right)
      destinationExpansion = "Warlords of Draenor",
      -- GPS coordinates for pathfinding
      worldX = -4466.4,
      worldY = 1419.0,
      zoneMapID = 85
    },
    {
      name = "Azsuna (Court of Stars emissary?)",
      x = 49.5,
      y = 38.5,
      mapID = 85,  -- Orgrimmar map ID - Portal Room (center)
      destinationExpansion = "Legion",
      -- GPS coordinates for pathfinding
      worldX = -4501.7,
      worldY = 1463.3,
      zoneMapID = 85
    },
    {
      name = "Portal to Stormwind",
      x = 50.0,
      y = 60.0,
      mapID = 85  -- Orgrimmar map ID
    },
    {
      name = "Portal to Ironforge",
      x = 50.0,
      y = 60.0,
      mapID = 85  -- Orgrimmar map ID
    },
    {
      name = "Portal to Darnassus",
      x = 50.0,
      y = 60.0,
      mapID = 85  -- Orgrimmar map ID
    },
    {
      name = "Portal to Exodar",
      x = 50.0,
      y = 60.0,
      mapID = 85  -- Orgrimmar map ID
    }
  },

  -- Valdrakken portals
  ["Valdrakken"] = {
    {
      name = "Portal to Stormwind",
      x = 60.0,
      y = 50.0,
      mapID = 2026,  -- Valdrakken sub-zone map ID
      destinationExpansion = "Classic",
      -- GPS coordinates for pathfinding
      worldX = -1069.2,
      worldY = 245.6,
      zoneMapID = 2112
    },
    {
      name = "Portal to Stormwind",
      x = 60.0,
      y = 50.0,
      mapID = 2112,  -- Valdrakken main zone map ID
      destinationExpansion = "Classic",
      destinationMapID = 84,
      -- GPS coordinates for pathfinding
      worldX = -1069.2,
      worldY = 245.6,
      zoneMapID = 2112
    },
    {
      name = "Portal to Orgrimmar",
      x = 40.0,
      y = 50.0,
      mapID = 2026,  -- Valdrakken sub-zone map ID
      destinationExpansion = "Classic",
      -- GPS coordinates for pathfinding
      worldX = -1021.6,
      worldY = 279.2,
      zoneMapID = 2112
    },
    {
      name = "Portal to Orgrimmar",
      x = 40.0,
      y = 50.0,
      mapID = 2112,  -- Valdrakken main zone map ID
      destinationExpansion = "Classic",
      destinationMapID = 85,
      -- GPS coordinates for pathfinding
      worldX = -1021.6,
      worldY = 279.2,
      zoneMapID = 2112
    }
  },

  -- Oribos portals
  ["Oribos"] = {
    {
      name = "Portal to Stormwind",
      x = 50.0,
      y = 50.0,
      mapID = 1670,  -- Oribos map ID
      destinationExpansion = "Classic",
      -- GPS coordinates for pathfinding
      worldX = 1537.7,
      worldY = -1808.4,
      zoneMapID = 1670
    },
    {
      name = "Portal to Orgrimmar",
      x = 50.0,
      y = 50.0,
      mapID = 1670,  -- Oribos map ID
      destinationExpansion = "Classic",
      -- GPS coordinates for pathfinding
      worldX = 1538.1,
      worldY = -1858.5,
      zoneMapID = 1670
    }
  },

  -- Boralus portals (Alliance)
  ["Boralus"] = {
    {
      name = "Portal to Stormwind",
      x = 68.0,
      y = 20.0,
      mapID = 1161,  -- Boralus map ID
      destinationExpansion = "Classic",
      -- GPS coordinates for pathfinding
      worldX = -525.1,
      worldY = 1132.7,
      zoneMapID = 1161
    }
  },

  -- Dazar'alor portals (Horde)
  ["Dazar'alor"] = {
    {
      name = "Portal to Orgrimmar",
      x = 50.0,
      y = 80.0,
      mapID = 1163,  -- Dazar'alor The Great Seal (portal room)
      destinationExpansion = "Classic",
      -- GPS coordinates for pathfinding
      worldX = 802.9,
      worldY = -2186.0,
      zoneMapID = 1163
    }
  },

  -- Dornogal portals
  ["Dornogal"] = {
    {
      name = "Portal to Stormwind",
      x = 41.14,
      y = 22.77,
      mapID = 2339,
      destinationExpansion = "Classic",
      -- GPS coordinates for pathfinding
      worldX = -2398.3,
      worldY = 2983.1,
      zoneMapID = 2339
    },
    {
      name = "Portal to Orgrimmar",
      x = 38.16,
      y = 27.23,
      mapID = 2339,
      destinationExpansion = "Classic",
      -- GPS coordinates for pathfinding (verified from HandyNotes_TravelGuide)
      worldX = -2334.2,
      worldY = 2918.6,
      zoneMapID = 2339
    },
    {
      name = "Portal to Undermine",
      x = 52.26,
      y = 50.87,
      mapID = 2339,
      destinationExpansion = "The War Within",
      destinationMapID = 2346,
      zoneMapID = 2339
    }
  },

  -- Founder's Point portals
  ["Founder's Point"] = {
    {
      name = "Portal to Stormwind",
      x = 57.41,
      y = 26.67,
      mapID = 2352,
      destinationExpansion = "Classic",
      destinationMapID = 84,
      -- GPS coordinates for pathfinding (placeholder - need actual coords)
      worldX = 0,
      worldY = 0,
      zoneMapID = 2352
    }
  },

  -- Hall of Awakening portals
  ["Hall of Awakening"] = {
    {
      name = "Portal to Stormwind",
      x = 7.34,
      y = 46.36,
      mapID = 2322,
      destinationExpansion = "Classic",
      destinationMapID = 84,
      zoneMapID = 2322
    },
    {
      name = "Portal to Orgrimmar",
      x = 7.21,
      y = 52.69,
      mapID = 2322,
      destinationExpansion = "Classic",
      destinationMapID = 85,
      zoneMapID = 2322
    }
  },

  -- Dalaran portals (Northrend)
  ["Dalaran"] = {
    {
      name = "Portal to Stormwind",
      x = 69.0,
      y = 41.0,
      mapID = 125,  -- Dalaran map ID
      destinationExpansion = "Classic",
      -- GPS coordinates for pathfinding
      worldX = 588.4,
      worldY = 5807.8,
      zoneMapID = 125
    },
    {
      name = "Portal to Orgrimmar",
      x = 28.0,
      y = 59.0,
      mapID = 125,  -- Dalaran map ID
      destinationExpansion = "Classic",
      -- GPS coordinates for pathfinding
      worldX = 588.5,
      worldY = 5807.8,
      zoneMapID = 125
    },
    {
      name = "Portal to Shattrath",
      x = 64.0,
      y = 30.0,
      mapID = 125,  -- Dalaran map ID
      destinationExpansion = "The Burning Crusade",
      -- GPS coordinates for pathfinding
      worldX = 588.4,
      worldY = 5807.8,
      zoneMapID = 125
    }
  },

  -- Dalaran portals (Broken Isles)
  ["Dalaran (Broken Isles)"] = {
    {
      name = "Portal to Stormwind",
      x = 40.0,
      y = 64.0,
      mapID = 627,  -- Dalaran (Broken Isles) map ID
      destinationExpansion = "Classic",
      -- GPS coordinates for pathfinding
      worldX = 4418.9,
      worldY = -714.6,
      zoneMapID = 627
    },
    {
      name = "Portal to Orgrimmar",
      x = 40.0,
      y = 64.0,
      mapID = 627,  -- Dalaran (Broken Isles) map ID
      destinationExpansion = "Classic",
      -- GPS coordinates for pathfinding
      worldX = 4418.9,
      worldY = -714.6,
      zoneMapID = 627
    }
  },

  -- Shattrath portals
  ["Shattrath City"] = {
    {
      name = "Portal to Stormwind",
      x = 58.0,
      y = 43.0,
      mapID = 111,  -- Shattrath City map ID
      destinationExpansion = "Classic",
      -- GPS coordinates for pathfinding
      worldX = 5387.8,
      worldY = -1894.1,
      zoneMapID = 111
    },
    {
      name = "Portal to Orgrimmar",
      x = 58.0,
      y = 43.0,
      mapID = 111,  -- Shattrath City map ID
      destinationExpansion = "Classic",
      -- GPS coordinates for pathfinding
      worldX = 5393.1,
      worldY = -1899.6,
      zoneMapID = 111
    }
  },

  -- Hellfire Peninsula portals
  ["Hellfire Peninsula"] = {
    {
      name = "Portal to Orgrimmar",
      mapID = 100,
      destinationExpansion = "Classic",
      worldX = 931.6,
      worldY = -222.0,
      zoneMapID = 100
    },
    {
      name = "Portal to Stormwind",
      mapID = 100,
      destinationExpansion = "Classic",
      worldX = 932.0,
      worldY = -275.4,
      zoneMapID = 100
    }
  },

  -- Jade Forest portals (Horde)
  ["Jade Forest"] = {
    {
      name = "Portal to Orgrimmar",
      x = 28.50,
      y = 14.01,
      mapID = 371,
      destinationExpansion = "Classic",
      -- GPS coordinates for pathfinding (verified from HandyNotes_TravelGuide)
      worldX = -539.8,
      worldY = 2999.7,
      zoneMapID = 371
    },
    {
      name = "Portal to Stormwind",
      x = 47.6,
      y = 89.8,
      mapID = 371,
      destinationExpansion = "Classic",
      -- Dawn's Blossom portal for Alliance
      worldX = 1390.0,
      worldY = -419.0,
      zoneMapID = 371
    }
  },

  -- Zuldazar portals (Horde)
  ["Zuldazar"] = {
    {
      name = "Portal to Orgrimmar",
      x = 52.0,
      y = 90.0,
      mapID = 1163,
      destinationExpansion = "Classic",
      worldX = 758.9,
      worldY = -1124.1,
      zoneMapID = 1163
    },
    {
      name = "Portal to Silvermoon",
      x = 51.6,
      y = 89.3,
      mapID = 1163,
      destinationExpansion = "The Burning Crusade",
      worldX = 759.2,
      worldY = -1114.4,
      zoneMapID = 1163
    },
    {
      name = "Portal to Thunder Bluff",
      x = 52.3,
      y = 91.8,
      mapID = 1163,
      destinationExpansion = "Classic",
      worldX = 759.6,
      worldY = -1132.9,
      zoneMapID = 1163
    },
    {
      name = "Portal to Silithus",
      x = 52.4,
      y = 93.9,
      mapID = 1163,
      destinationExpansion = "Classic",
      worldX = 759.6,
      worldY = -1142.7,
      zoneMapID = 1163
    },
    {
      name = "Portal to Nazjatar",
      x = 50.1,
      y = 92.8,
      mapID = 1163,
      destinationExpansion = "Battle for Azeroth",
      worldX = 779.2,
      worldY = -1142.3,
      zoneMapID = 1163
    },
    {
      name = "Portal to Mechagon",
      x = 73.5,
      y = 69.8,
      mapID = 1165,
      destinationExpansion = "Battle for Azeroth",
      worldX = 1032.9,
      worldY = -1906.3,
      zoneMapID = 1165
    }
  },

  -- Silvermoon portals (Horde)
  ["Silvermoon City"] = {
    {
      name = "Portal to Orgrimmar",
      x = 49.5,
      y = 14.8,
      mapID = 110,
      destinationExpansion = "Classic",
      worldX = -4709.7,
      worldY = 7603.1,
      zoneMapID = 110
    },
    {
      name = "Orb of Translocation to Undercity",
      x = 49.4,
      y = 14.9,
      mapID = 110,
      destinationExpansion = "Classic",
      worldX = -4600.9,
      worldY = 7634.5,
      zoneMapID = 110
    }
  },

  -- Deepholm portals
  ["Deepholm"] = {
    {
      name = "Portal to Orgrimmar",
      x = 48.0,
      y = 52.0,
      mapID = 207,
      destinationExpansion = "Classic",
      worldX = 454.6,
      worldY = 990.4,
      zoneMapID = 207
    }
  },

  -- Hyjal portals
  ["Hyjal"] = {
    {
      name = "Portal to Orgrimmar",
      x = 27.5,
      y = 56.6,
      mapID = 198,
      destinationExpansion = "Classic",
      worldX = -3624.1,
      worldY = 5503.0,
      zoneMapID = 198
    },
    {
      name = "Portal to Bel'ameth",
      x = 27.1,
      y = 62.0,
      mapID = 198,
      destinationExpansion = "Dragonflight",
      worldX = -3580.6,
      worldY = 5552.6,
      zoneMapID = 198
    }
  },

  -- Caverns of Time portals
  ["Caverns of Time"] = {
    {
      name = "Portal to Stormwind",
      x = 61.9,
      y = 56.9,
      mapID = 74,
      destinationExpansion = "Classic",
      worldX = -4817.0,
      worldY = -8153.9,
      zoneMapID = 74
    },
    {
      name = "Portal to Orgrimmar",
      x = 61.8,
      y = 57.0,
      mapID = 74,
      destinationExpansion = "Classic",
      worldX = -4808.1,
      worldY = -8152.8,
      zoneMapID = 74
    }
  },

  -- Warspear portals (Horde - Draenor)
  ["Warspear"] = {
    {
      name = "Portal to Orgrimmar",
      x = 61.5,
      y = 43.4,
      mapID = 624,
      destinationExpansion = "Classic",
      worldX = -4076.0,
      worldY = 5266.5,
      zoneMapID = 624
    }
  },

  -- Stormshield portals (Alliance - Draenor)
  ["Stormshield"] = {
    {
      name = "Portal to Stormwind",
      x = 61.6,
      y = 43.1,
      mapID = 622,
      destinationExpansion = "Classic",
      worldX = -3843.0,
      worldY = 3667.8,
      zoneMapID = 622
    }
  },

  -- Azsuna portals (Legion)
  ["Azsuna"] = {
    {
      name = "Portal to Orgrimmar",
      x = 45.5,
      y = 27.0,
      mapID = 630,
      destinationExpansion = "Classic",
      worldX = 6756.3,
      worldY = -8.2,
      zoneMapID = 630
    }
  },

  -- Vindicaar Argus portals
  ["Vindicaar"] = {
    {
      name = "Portal to Dalaran (Broken Isles)",
      x = 59.5,
      y = 42.7,
      mapID = 831,  -- Argus: The Vindicaar
      destinationExpansion = "Legion",
      worldX = 1469.7,
      worldY = 500.1,
      zoneMapID = 831
    }
  },

  -- Bel'ameth portals (Dragonflight)
  ["Bel'ameth"] = {
    {
      name = "Portal to Val'sharah",
      x = 49.8,
      y = 16.2,
      mapID = 2239,
      destinationExpansion = "Legion",
      worldX = 6864.0,
      worldY = -1967.9,
      zoneMapID = 2239
    },
    {
      name = "Portal to Hyjal",
      x = 49.3,
      y = 16.4,
      mapID = 2239,
      destinationExpansion = "Cataclysm",
      worldX = 6855.0,
      worldY = -1969.1,
      zoneMapID = 2239
    },
    {
      name = "Portal to Darkshore",
      x = 49.2,
      y = 14.9,
      mapID = 2239,
      destinationExpansion = "Classic",
      worldX = 6853.5,
      worldY = -1960.1,
      zoneMapID = 2239
    },
    {
      name = "Portal to Stormwind",
      x = 49.1,
      y = 11.5,
      mapID = 2239,
      destinationExpansion = "Classic",
      worldX = 6852.3,
      worldY = -1934.4,
      zoneMapID = 2239
    }
  },

  -- Val'sharah portals (Legion)
  ["Val'sharah"] = {
    {
      name = "Portal to Bel'ameth",
      x = 55.3,
      y = 73.4,
      mapID = 641,
      destinationExpansion = "Dragonflight",
      worldX = 6583.6,
      worldY = 2326.0,
      zoneMapID = 641
    }
  },

  -- Shrine of Two Moons portals (Horde - Pandaria)
  ["Shrine of Two Moons"] = {
    {
      name = "Portal to Orgrimmar",
      x = 73.0,
      y = 43.0,
      mapID = 1530,
      destinationExpansion = "Classic",
      worldX = 874.1,
      worldY = 1735.4,
      zoneMapID = 1530
    }
  },

  -- Shrine of Seven Stars portals (Alliance - Pandaria)
  ["Shrine of Seven Stars"] = {
    {
      name = "Portal to Stormwind",
      x = 72.6,
      y = 36.0,
      mapID = 394,
      destinationExpansion = "Classic",
      worldX = 176.3,
      worldY = 828.6,
      zoneMapID = 394
    }
  }
}
