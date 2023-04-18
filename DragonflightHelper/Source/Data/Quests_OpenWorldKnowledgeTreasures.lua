-- https://www.wowhead.com/guide/professions/knowledge-point-treasure-locations-dragon-isles
local SkillIds = DFH_Constants.SkillIds
local MapIds = DFH_Constants.MapIds

DFH_Constants.ProfessionQuests.OpenWorldKnowledgeTreasures = {
  title = "Knowledge Treasures",
  [SkillIds.Alchemy] = {
    {
      questId = 70289,
      item = 198685,
      waypoint = { map = MapIds.WakingShore, x = 25.1 / 100, y = 73.3 / 100, options = { title = "Well Insulated Mug" } },
    },
    {
      questId = 70274,
      item = 198663,
      waypoint = { map = MapIds.WakingShore, x = 55 / 100, y = 81 / 100, options = { title = "Frostforged Potion" } },
    },
    {
      questId = 70305,
      item = 198710,
      waypoint = {
        map = MapIds.OhnAhranPlains,
        x = 79.22 / 100,
        y = 83.71 / 100,
        options = { title = "Canteen of Suspicious Water" }
      },
    },
    {
      questId = 70208,
      item = 198599,
      waypoint = {
        map = MapIds.AzureSpan,
        x = 16.4 / 100,
        y = 38.5 / 100,
        options = { title = "Experimental Decay Sample" }
      },
    },
    {
      questId = 70309,
      item = 198712,
      waypoint = { map = MapIds.AzureSpan, x = 67 / 100, y = 13.2 / 100, options = { title = "Firewater Powder Sample" } },
    },
    {
      questId = 70278,
      item = 203471,
      waypoint = { map = MapIds.Thaldraszus, x = 55.2 / 100, y = 30.5 / 100, options = { title = "Tasty Candy" } },
    },
    {
      questId = 70301,
      item = 198697,
      waypoint = {
        map = MapIds.Thaldraszus,
        x = 59.5 / 100,
        y = 38.4 / 100,
        options = { title = "Contraband Concoction" }
      },
    },
  },
  [SkillIds.Blacksmithing] = {
    {
      questId = 70230,
      item = 198791,
      waypoint = {
        map = MapIds.WakingShore,
        x = 56.4 / 100,
        y = 19.5 / 100,
        options = { title = "Glimmer of Blacksmithing Wisdom (Take crafting mats for a primal alloy)" }
      }
    },
    {
      questId = 70246,
      item = 201007,
      waypoint = {
        map = MapIds.WakingShore,
        x = 22.0 / 100,
        y = 87.0 / 100,
        options = { title = "Ancient Monument" }
      },
    },
    {
      questId = 70312,
      item = 201005,
      waypoint = {
        map = MapIds.WakingShore,
        x = 65.5 / 100,
        y = 25.7 / 100,
        options = { title = "Curious Ingots" }
      }
    },
    {
      questId = 70296,
      item = 201008,
      waypoint = {
        map = MapIds.WakingShore,
        x = 35.5 / 100,
        y = 64.3 / 100,
        options = { title = "Molten Ingot" }
      }
    },
    {
      questId = 70310,
      item = 201010,
      waypoint = {
        map = MapIds.WakingShore,
        x = 34.5 / 100,
        y = 67.1 / 100,
        options = { title = "Qalashi Weapon Diagram" }
      },
    },
    {
      questId = 70313,
      item = 201004,
      waypoint = {
        map = MapIds.OhnAhranPlains,
        x = 81.1 / 100,
        y = 37.9 / 100,
        options = { title = "Ancient Spear Shards" }
      },
    },
    {
      questId = 70353,
      item = 201009,
      waypoint = {
        map = MapIds.OhnAhranPlains,
        x = 50.9 / 100,
        y = 66.5 / 100,
        options = { title = "Falconer Gauntlet Drawings" }
      },
    },
    {
      questId = 70314,
      item = 201011,
      waypoint = {
        map = MapIds.AzureSpan,
        x = 53.1 / 100,
        y = 65.3 / 100,
        options = { title = "Spelltouched Tongs" }
      },
    },
    {
      questId = 70311,
      item = 201006,
      waypoint = {
        map = MapIds.Thaldraszus,
        x = 52.2 / 100,
        y = 80.5 / 100,
        options = { title = "Draconic Flux" }
      },
    }
  },
  [SkillIds.Enchanting] = {
    -- There is a bug that prevents this from being looted,
    -- commenting out for now
    {
      questId = 0,
      item = 198798,
      waypoint = {
        map = MapIds.WakingShore,
        x = 57.5 / 100,
        y = 83.6 / 100,
        options = { title = "Flashfrozen Scroll" }
      }
    },
    {
      questId = 70283,
      item = 198675,
      waypoint = {
        map = MapIds.WakingShore,
        x = 68.0 / 100,
        y = 26.8 / 100,
        options = { title = "Lava-Infused Seed" }
      }
    },
    {
      questId = 70272,
      item = 201012,
      waypoint = {
        map = MapIds.WakingShore,
        x = 57.5 / 100,
        y = 58.5 / 100,
        options = { title = "Enchanted Debris (Interact with disenchanted broom" }
      }
    },
    {
      questId = 70291,
      item = 198689,
      waypoint = {
        map = MapIds.OhnAhranPlains,
        x = 61.4 / 100,
        y = 67.6 / 100,
        options = { title = "Stormbound Horn" }
      }
    },
    {
      questId = 70336,
      item = 198799,
      waypoint = {
        map = MapIds.AzureSpan,
        x = 38.5 / 100,
        y = 59.2 / 100,
        options = { title = "Forgotten Arcane Tome" }
      }
    },
    {
      questId = 70290,
      item = 201013,
      waypoint = {
        map = MapIds.AzureSpan,
        x = 45.1 / 100,
        y = 61.2 / 100,
        options = { title = "Faintly Enchanted Remains" }
      }
    },
    {
      questId = 70298,
      item = 198694,
      waypoint = {
        map = MapIds.AzureSpan,
        x = 21.55 / 100,
        y = 45.5 / 100,
        options = { title = "Enriched Earthen Shard" }
      }
    },
    {
      questId = 70342,
      item = 198800,
      waypoint = {
        map = MapIds.Thaldraszus,
        x = 59.9 / 100,
        y = 70.4 / 100,
        options = { title = "Fractured Titanic Sphere" }
      }
    },
  },
  [SkillIds.Engineering] = {
    {
      questId = 70270,
      item = 201014,
      waypoint = {
        map = MapIds.WakingShore,
        x = 56.0 / 100,
        y = 44.9 / 100,
        options = { title = "Boomthyr Rocket" }
      },
    },
    {
      questId = 70275,
      item = 198789,
      waypoint = {
        map = MapIds.WakingShore,
        x = 49.09 / 100,
        y = 77.54 / 100,
        options = { title = "Intact Coil Capacitor" }
      },
    },
  },
  [SkillIds.Inscription] = {
    {
      questId = 70306,
      item = 198704,
      waypoint = {
        map = MapIds.WakingShore,
        x = 67.87 / 100,
        y = 57.96 / 100,
        options = { title = "Pulsing Earth Rune" }
      },
    },
    {
      questId = 70307,
      item = 198703,
      waypoint = {
        map = MapIds.OhnAhranPlains,
        x = 85.7 / 100,
        y = 25.2 / 100,
        options = { title = "Sign Language Reference Sheet" }
      },
    },
    {
      -- maybe: 70297
      questId = 0,
      item = 198693,
      waypoint = {
        map = MapIds.AzureSpan,
        x = 46.2 / 100,
        y = 23.9 / 100,
        options = { title = "Dusty Darkmoon Card" }
      },
    },
    {
      questId = 70293,
      item = 198686,
      waypoint = {
        map = MapIds.AzureSpan,
        x = 43.7 / 100,
        y = 30.9 / 100,
        options = { title = "Frosted Parchment" }
      },
    },
    {
      questId = 70281,
      item = 198669,
      waypoint = {
        map = MapIds.Valdrakken,
        x = 13.2 / 100,
        y = 63.68 / 100,
        options = { title = "How to Train Your Whelpling (bugged; use bronze timelock, zone, return)" }
      },
    },
    {
      questId = 70264,
      item = 198659,
      waypoint = {
        map = MapIds.Thaldraszus,
        x = 56.29 / 100,
        y = 41.17 / 100,
        options = { title = "Forgetful Apprentice's Tome (2)" }
      },
    },
    {
      questId = 70248,
      item = 198659,
      waypoint = {
        map = MapIds.Thaldraszus,
        x = 47.24 / 100,
        y = 40.1 / 100,
        options = { title = "Forgetful Apprentice's Tome (1)" }
      },
    },
    {
      questId = 70287,
      item = 201015,
      waypoint = {
        map = MapIds.Thaldraszus,
        x = 56.1 / 100,
        y = 40.9 / 100,
        options = { title = "Counterfeit Darkmoon Deck" }
      },
    },
  },
  [SkillIds.Jewelcrafting] = {
    {
      questId = 70292,
      item = 198687,
      waypoint = {
        map = MapIds.WakingShore,
        x = 50.4 / 100,
        y = 45.1 / 100,
        options = { title = "Closely Guarded Shiny" }
      },
    },
    {
      questId = 70273,
      item = 201017,
      waypoint = {
        map = MapIds.WakingShore,
        x = 33.9 / 100,
        y = 63.7 / 100,
        options = { title = "Igneous Gem" }
      },
    },
    {
      questId = 70282,
      item = 198670,
      waypoint = {
        map = MapIds.OhnAhranPlains,
        x = 25.2 / 100,
        y = 35.4 / 100,
        options = { title = "Lofty Malygite" }
      },
    },
    {
      questId = 70263,
      item = 198660,
      waypoint = {
        map = MapIds.OhnAhranPlains,
        x = 61.8 / 100,
        y = 13.0 / 100,
        options = { title = "Fragmented Key" }
      },
    },
    {
      questId = 70277,
      item = 198664,
      waypoint = {
        map = MapIds.AzureSpan,
        x = 45.0 / 100,
        y = 61.3 / 100,
        options = { title = "Crystalline Overgrowth" }
      },
    },
    {
      questId = 70271,
      item = 201016,
      waypoint = {
        map = MapIds.AzureSpan,
        x = 44.6 / 100,
        y = 61.2 / 100,
        options = { title = "Harmonic Crystal Harmonizer" }
      },
    },
    {
      questId = 70285,
      item = 198682,
      waypoint = {
        map = MapIds.Thaldraszus,
        x = 59.8 / 100,
        y = 65.2 / 100,
        options = { title = "Alexstraszite Cluster" }
      },
    },
    {
      questId = 70261,
      item = 198656,
      waypoint = {
        map = MapIds.Thaldraszus,
        x = 56.91 / 100,
        y = 43.72 / 100,
        options = { title = "Painter's Pretty Jewel" }
      },
    },
  },
  [SkillIds.Leatherworking] = {
    {
      questId = 70308,
      item = 198711,
      waypoint = { map = MapIds.WakingShore, x = 39 / 100, y = 86 / 100, options = { title = "Poacher's Pack" } },
    },
    {
      questId = 70280,
      item = 198667,
      waypoint = { map = MapIds.WakingShore, x = 64.3 / 100, y = 25.4 / 100, options = { title = "Spare Djaradin Tools" } },
    },
    {
      questId = 70300,
      item = 198696,
      waypoint = { map = MapIds.OhnAhranPlains, x = 86.4 / 100, y = 53.7 / 100, options = { title = "Wind-Blessed Hide" } },
    },
    {
      questId = 70269,
      item = 201018,
      waypoint = { map = MapIds.AzureSpan, x = 12.5 / 100, y = 49.4 / 100, options = { title = "Well-Danced Drum" } },
    },
    {
      questId = 70266,
      item = 198658,
      waypoint = {
        map = MapIds.AzureSpan,
        x = 16.7 / 100,
        y = 38.8 / 100,
        options = { title = "Decay-Infused Tanning Oil" }
      },
    },
    {
      questId = 70286,
      item = 198683,
      waypoint = { map = MapIds.AzureSpan, x = 57.5 / 100, y = 41.3 / 100, options = { title = "Treated Hides" } },
    },
    {
      questId = 70294,
      item = 198690,
      waypoint = { map = MapIds.Thaldraszus, x = 56.8 / 100, y = 30.5 / 100, options = { title = "Decayed Scales" } },
    },
  },
  [SkillIds.Tailoring] = {
    {
      questId = 70302,
      item = 198699,
      waypoint = {
        map = MapIds.WakingShore,
        x = 74.7 / 100,
        y = 37.9 / 100,
        options = { title = "Mysterious Banner" }
      },
    },
    {
      questId = 70304,
      item = 198702,
      waypoint = {
        map = MapIds.WakingShore,
        x = 24.9 / 100,
        y = 69.7 / 100,
        options = { title = "Itinerant Singed Fabric" }
      },
    },
    {
      questId = 70295,
      item = 198692,
      waypoint = {
        map = MapIds.OhnAhranPlains,
        x = 35.34 / 100,
        y = 40.12 / 100,
        options = { title = "Noteworthy Scrap of Carpet" }
      },
    },
    {
      questId = 70303,
      item = 201020,
      waypoint = {
        map = MapIds.OhnAhranPlains,
        x = 66.1 / 100,
        y = 52.9 / 100,
        options = { title = "Silky Surprise" }
      },
    },
    {
      -- Two quests completed at the same time, so not sure if this is the right
      -- quest id or not (the other was 70525)
      questId = 70284,
      item = 198680,
      waypoint = {
        map = MapIds.AzureSpan,
        x = 16.2 / 100,
        y = 38.8 / 100,
        options = { title = "Decaying Brackenhide Blanket" }
      },
    },
    {
      questId = 70267,
      item = 198662,
      waypoint = {
        map = MapIds.AzureSpan,
        x = 40.7 / 100,
        y = 54.5 / 100,
        options = { title = "Intriguing Bolt of Blue Cloth" }
      },
    },
    {
      questId = 70288,
      item = 198684,
      waypoint = {
        map = MapIds.Thaldraszus,
        x = 60.4 / 100,
        y = 79.7 / 100,
        options = { title = "Miniature Bronze Dragonflight Banner" }
      },
    },
    {
      questId = 70372,
      item = 201019,
      waypoint = {
        map = MapIds.Thaldraszus,
        x = 58.6 / 100,
        y = 45.8 / 100,
        options = { title = "Ancient Dragonweave Bolt" }
      },
    },
  },
}
