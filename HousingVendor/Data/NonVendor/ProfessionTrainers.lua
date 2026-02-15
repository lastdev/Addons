-- Profession Trainers (static lookup - grouped by profession/expansion/faction)
-- NOTE: This is a data file; it is loaded via `HousingVendor.toc` and registered for deferred processing.

HousingDataAggregator_RegisterProfessionTrainers({

  ---------------------------------------------------------------------------
  -- ALCHEMY
  ---------------------------------------------------------------------------
  Alchemy = {
    description = "Create potions, flasks, transmutations, and other alchemical items.",
    expansions = {
      Classic = {
        Alliance = { name="Lilyssia Nightbreeze", location="Stormwind City", coords ={ mapID=84, x=55.0, y=85.6 } },
        Horde    = { name="Yelmak", location="Orgrimmar",      coords ={ mapID=85, x=55.6, y=45.8 } },
      },
      TBC = {
        Alliance = { name="Alchemist Gribble", location="Hellfire Peninsula", coords ={ mapID=100, x=53.8, y=65.6 } },
        Horde    = { name="Apothecary Antonivich", location="Hellfire Peninsula", coords ={ mapID=100, x=52.4, y=36.4 } },
      },
      WotLK = {
        Both = { name="Linzy Blackbolt", location="Dalaran (Northrend)", coords ={ mapID=125, x=42.6, y=32.2 } },
      },
      Cataclysm = {
        Alliance = { name="Lilyssia Nightbreeze", location="Stormwind City", coords ={ mapID=84, x=55.0, y=85.6 } },
        Horde    = { name="Yelmak", location="Orgrimmar",      coords ={ mapID=85, x=55.6, y=45.8 } },
      },
      MoP = {
        Both = { name="Ni Gentlepaw", location="The Jade Forest", coords ={ mapID=371, x=46.8, y=45.2 } },
      },
      WoD = {
        -- WoD is special: learned via garrison buildings/books; no single fixed trainer location.
        Alliance = { name="Alchemy Lab NPC", location="Lunarfall (Garrison)", coords ={ mapID=582, x=50.0, y=50.0 }, notes="Garrison hub; exact NPC/spot varies by level/building placement; also buy \"Draenor Alchemy\" book from Ashran vendors" },
        Horde    = { name="Alchemy Lab NPC", location="Frostwall (Garrison)", coords ={ mapID=590, x=50.0, y=50.0 }, notes="Garrison hub; exact NPC/spot varies by level/building placement; also buy \"Draenor Alchemy\" book from Ashran vendors" },
      },
      Legion = {
        Both = { name="Deucus Valdera", location="Dalaran (Broken Isles)", coords ={ mapID=627, x=41.0, y=33.0 }, notes="The Agronomical Apothecary" },
      },
      BfA = {
        Alliance = { name="Elric Whalgrene", location="Boralus (Tiragarde Sound)", coords ={ mapID=1161, x=74.2, y=47.4 }, notes="Near Tradewinds Market" },
        Horde    = { name="Clever Kumali", location="Dazar'alor (Zuldazar)", coords ={ mapID=1165, x=71.8, y=30.6 }, notes="Terrace of Crafters" },
      },
      Shadowlands = {
        Both = { name="Elixirist Au'pyr", location="Oribos", coords ={ mapID=1670, x=39.4, y=41.0 } },
      },
      Dragonflight = {
        Both = { name="Conflago", location="Valdrakken", coords ={ mapID=2112, x=36.6, y=50.6 } },
      },
      TWW = {
        Both = { name="Tarig", location="Dornogal", coords ={ mapID=2339, x=41.8, y=58.2 } },
      },
    },
  },

  ---------------------------------------------------------------------------
  -- BLACKSMITHING
  ---------------------------------------------------------------------------
  Blacksmithing = {
    description = "Forge weapons, armor, keys, and other metal items.",
    expansions = {
      Classic = {
        Alliance = { name="Jordan Smith", location="Stormwind City", coords ={ mapID=84, x=64.8, y=48.2 } },
        Horde    = { name="Opuno Ironhorn", location="Orgrimmar", coords ={ mapID=85, x=40.6, y=49.8 } },
      },
      TBC = {
        Both = { name="Kradu Grimblade", location="Shattrath City", coords ={ mapID=111, x=69.8, y=42.4 } },
      },
      WotLK = {
        Both = { name="Alard Schmied", location="Dalaran (Northrend)", coords ={ mapID=125, x=45.6, y=28.6 } },
      },
      Cataclysm = {
        Alliance = { name="Jordan Smith", location="Stormwind City", coords ={ mapID=84, x=64.8, y=48.2 } },
        Horde    = { name="Opuno Ironhorn", location="Orgrimmar", coords ={ mapID=85, x=40.6, y=49.8 } },
      },
      MoP = {
        Both = { name="Len the Hammer", location="The Jade Forest", coords ={ mapID=371, x=48.4, y=36.8 } },
      },
      WoD = {
        Alliance = { name="Royce Bigbeard", location="Stormshield", coords ={ mapID=622, x=48.8, y=48.2 } },
        Horde    = { name="Nonn Threeratchet", location="Warspear", coords ={ mapID=624, x=75.2, y=37.6 } },
      },
      Legion = {
        Both = { name="Alard Schmied", location="Dalaran (Broken Isles)", coords ={ mapID=627, x=45.0, y=29.6 } },
      },
      BfA = {
        Alliance = { name="Grix \"Ironfists\" Barlow", location="Boralus", coords ={ mapID=1161, x=73.4, y=8.4 } },
        Horde    = { name="Forgemaster Zak'aal", location="Dazar'alor", coords ={ mapID=1165, x=43.6, y=38.6 } },
      },
      Shadowlands = {
        Both = { name="Smith Au'berk", location="Oribos", coords ={ mapID=1670, x=40.8, y=31.4 } },
      },
      Dragonflight = {
        Both = { name="Metalshaper Kuroko", location="Valdrakken", coords ={ mapID=2112, x=37.0, y=46.8 } },
      },
      TWW = {
        Both = { name="Darean", location="Dornogal", coords ={ mapID=2339, x=49.2, y=63.4 } },
      },
    },
  },

  ---------------------------------------------------------------------------
  -- COOKING (SECONDARY)
  ---------------------------------------------------------------------------
  Cooking = {
    description = "Prepare food that provides buffs and restores health/mana.",
    secondary = true,
    expansions = {
      MoP = {
        Both = { name="Yan Ironpaw", location="Valley of the Four Winds", coords ={ mapID=376, x=52.6, y=51.6 } },
      },
      WoD = {
        -- Garrison-only; coordinates vary by garrison level.
        Alliance = { name="Arsenio Zerep", location="Lunarfall (Garrison)", coords ={ mapID=582, x=50.0, y=50.0 }, notes="Garrison hub; exact coordinates vary by level (e.g. ~48.7 41.4 at L1)" },
        Horde    = { name="Kraank", location="Frostwall (Garrison)", coords ={ mapID=590, x=50.0, y=50.0 }, notes="Garrison hub; exact coordinates vary by level (e.g. ~36.8 39.6)" },
      },
      BfA = {
        Alliance = { name="\"Cap'n\" Byron Mehlsack", location="Boralus", coords ={ mapID=1161, x=71.2, y=10.8 } },
        Horde    = { name="T'sarah the Royal Chef", location="Dazar'alor", coords ={ mapID=1165, x=29.6, y=46.4 } },
      },
      Shadowlands = {
        Both = { name="Chef Au'krut", location="Oribos", coords ={ mapID=1670, x=47.0, y=23.6 } },
      },
      Dragonflight = {
        Both = { name="Erugosa", location="Valdrakken", coords ={ mapID=2112, x=46.6, y=46.6 } },
      },
      TWW = {
        Both = { name="Athodas", location="Dornogal", coords ={ mapID=2339, x=44.2, y=45.6 } },
      },
    },
  },

  ---------------------------------------------------------------------------
  -- LEATHERWORKING
  ---------------------------------------------------------------------------
  Leatherworking = {
    description = "Craft leather and mail armor, drums, and leg enchants.",
    expansions = {
      Classic = {
        Alliance = { name="Simon Tanner", location="Stormwind City", coords ={ mapID=84, x=71.8, y=62.8 } },
        Horde    = { name="Karolek", location="Orgrimmar", coords ={ mapID=85, x=60.8, y=54.8 } },
      },
      TBC = {
        Both = { name="Darmari", location="Shattrath City", coords ={ mapID=111, x=67.2, y=67.6 } },
      },
      WotLK = {
        Both = { name="Diane Cannings", location="Dalaran (Northrend)", coords ={ mapID=125, x=35.6, y=29.0 } },
      },
      Cataclysm = {
        Alliance = { name="Simon Tanner", location="Stormwind City", coords ={ mapID=84, x=71.8, y=62.8 } },
        Horde    = { name="Karolek", location="Orgrimmar", coords ={ mapID=85, x=60.8, y=54.8 } },
      },
      MoP = {
        Both = { name="Clean Pelt", location="Kun-Lai Summit", coords ={ mapID=379, x=64.6, y=60.8 } },
      },
      WoD = {
        Alliance = { name="Artificer Harlaan", location="Stormshield", coords ={ mapID=622, x=35.4, y=29.6 } },
        Horde    = { name="Garm Gladestride", location="Warspear", coords ={ mapID=624, x=50.4, y=27.4 } },
      },
      Legion = {
        Both = { name="Namha Moonwater", location="Dalaran (Broken Isles)", coords ={ mapID=627, x=35.4, y=29.6 } },
      },
      BfA = {
        Alliance = { name="Cassandra Brennor", location="Boralus", coords ={ mapID=1161, x=75.5, y=12.6 } },
        Horde    = { name="Xanjo", location="Dazar'alor", coords ={ mapID=1165, x=44.0, y=34.6 } },
      },
      Shadowlands = {
        Both = { name="Tanner Au'qil", location="Oribos", coords ={ mapID=1670, x=42.6, y=26.8 } },
      },
      Dragonflight = {
        Both = { name="Hideshaper Koruz", location="Valdrakken", coords ={ mapID=2112, x=28.8, y=61.6 } },
      },
      TWW = {
        Both = { name="Marbb", location="Dornogal", coords ={ mapID=2339, x=54.4, y=58.6 } },
      },
    },
  },

  ---------------------------------------------------------------------------
  -- ENCHANTING
  ---------------------------------------------------------------------------
  Enchanting = {
    description = "Enchant gear with magical effects and craft wands and rods.",
    expansions = {
      Classic = {
        Alliance = { name="Lucan Cordell", location="Stormwind City", coords ={ mapID=84, x=43.0, y=64.0 }, notes="Capital city enchanting trainer, Mage Quarter" },
        Horde    = { name="Godan", location="Orgrimmar", coords ={ mapID=85, x=53.4, y=49.4 }, notes="Capital city enchanting trainer, The Drag / Godan's Runeworks" },
      },
      TBC = {
        Both = { name="Hamanar (Aldor) / Arcanist Adurin (Scryer)", location="Shattrath City", coords ={ mapID=111, x=62.8, y=67.8 }, notes="Aldor: 62.8 67.8; Scryer: 58.6 48.4" },
      },
      WotLK = {
        Both = { name="Enchanter Nalthanis", location="Dalaran (Northrend)", coords ={ mapID=125, x=41.8, y=49.0 }, notes="Dalaran enchanting trainer (approx coords), Simply Enchanting shop" },
      },
      Cataclysm = {
        Alliance = { name="Lucan Cordell", location="Stormwind City", coords ={ mapID=84, x=43.0, y=64.0 }, notes="Capital city enchanting trainer, Mage Quarter" },
        Horde    = { name="Godan", location="Orgrimmar", coords ={ mapID=85, x=53.4, y=49.4 }, notes="Capital city enchanting trainer, The Drag / Godan's Runeworks" },
      },
      MoP = {
        Both = { name="Lai the Spellpaw", location="Dawn's Blossom (The Jade Forest)", coords ={ mapID=371, x=46.8, y=42.9 }, notes="Pandaria trainers; shrines have additional trainers" },
      },
      WoD = {
        Alliance = { name="Bil Sparktonic", location="Stormshield / Your Garrison (Enchanter's Study)", coords ={ mapID=622, x=56.0, y=65.0 }, notes="Garrison/Ashran; coordinates vary by garrison level" },
        Horde    = { name="Hane'ke", location="Warspear / Your Garrison (Enchanter's Study)", coords ={ mapID=624, x=78.0, y=52.0 }, notes="Approx coords; garrison coordinates vary by level" },
      },
      Legion = {
        Both = { name="Enchantress Illucia", location="Dalaran (Broken Isles)", coords ={ mapID=627, x=38.8, y=41.2 }, notes="Enchanting shop" },
      },
      BfA = {
        Alliance = { name="Emily Fairweather", location="Boralus", coords ={ mapID=1161, x=74.0, y=47.6 }, notes="Near Tradewinds Market" },
        Horde    = { name="Enchantress Quinni", location="Dazar'alor (Zuldazar)", coords ={ mapID=1165, x=71.6, y=30.8 }, notes="Terrace of Crafters" },
      },
      Shadowlands = {
        Both = { name="Scribe Au'tehshi", location="Oribos", coords ={ mapID=1670, x=36.5, y=36.7 }, notes="Hall of Shapes" },
      },
      Dragonflight = {
        Both = { name="Sytg", location="Valdrakken", coords ={ mapID=2112, x=31.0, y=41.0 }, notes="Artisan's Market" },
      },
      TWW = {
        Both = { name="Nagad", location="Dornogal", coords ={ mapID=2339, x=53.0, y=82.0 }, notes="South of The Foregrounds" },
      },
    },
  },

  ---------------------------------------------------------------------------
  -- ENGINEERING
  ---------------------------------------------------------------------------
  Engineering = {
    description = "Build gadgets, explosives, and mechanical devices.",
    expansions = {
      Classic = {
        Alliance = { name="Lilliam Sparkspindle", location="Stormwind City", coords ={ mapID=84, x=62.8, y=32.0 }, notes="Capital city engineering trainer, Dwarven District" },
        Horde    = { name="Roxxik", location="Orgrimmar", coords ={ mapID=85, x=76.0, y=25.0 }, notes="Capital city engineering trainer, Valley of Honor" },
      },
      TBC = {
        Both = { name="Engineer Sinbei", location="Shattrath City", coords ={ mapID=111, x=43.6, y=65.0 }, notes="Outland engineering trainer (Scryer's Tier)" },
      },
      WotLK = {
        Both = { name="Leeli-Arcane / Timofey Oshenko", location="Dalaran (Northrend)", coords ={ mapID=125, x=38.0, y=25.0 } },
      },
      Cataclysm = {
        Alliance = { name="Lilliam Sparkspindle", location="Stormwind City", coords ={ mapID=84, x=62.8, y=32.0 }, notes="Capital city engineering trainer, Dwarven District" },
        Horde    = { name="Roxxik", location="Orgrimmar", coords ={ mapID=85, x=76.0, y=25.0 }, notes="Capital city engineering trainer, Valley of Honor" },
      },
      MoP = {
        Both = { name="Sally Fizzlefury", location="Valley of the Four Winds", coords ={ mapID=376, x=16.0, y=83.0 }, notes="Pandaria Engineering trainer (per user list)" },
      },
      WoD = {
        Alliance = { name="Sean Catchpole", location="Stormshield / Your Garrison (Engineering Works)", coords ={ mapID=622, x=47.6, y=40.6 }, notes="Garrison/Ashran; coordinates vary by garrison level" },
        Horde    = { name="Nik Steelrings", location="Warspear / Your Garrison (Engineering Works)", coords ={ mapID=624, x=70.6, y=39.6 }, notes="Garrison/Ashran; coordinates vary by garrison level" },
      },
      Legion = {
        Both = { name="Hobart Grapplehammer", location="Dalaran (Broken Isles)", coords ={ mapID=627, x=38.0, y=25.0 }, notes="Like Clockwork shop" },
      },
      BfA = {
        Alliance = { name="Tinkmaster Omar", location="Boralus", coords ={ mapID=1161, x=77.4, y=34.2 } },
        Horde    = { name="Hilda Copperbrow", location="Dazar'alor (Zuldazar)", coords ={ mapID=1165, x=73.0, y=33.0 } },
      },
      Dragonflight = {
        Both = { name="Clinkyclick Shatterboom", location="Valdrakken", coords ={ mapID=2112, x=38.6, y=73.2 }, notes="Artisan's Market" },
      },
      TWW = {
        Both = { name="Thermalseer Arhdas", location="Dornogal", coords ={ mapID=2339, x=49.0, y=56.0 }, notes="Forgegrounds area (verified)" },
      },
      Shadowlands = {
        Both = { name="Machinist Au'gur", location="Oribos", coords ={ mapID=1670, x=36.1, y=44.6 }, notes="Hall of Shapes, Ring of Fates" },
      },
    },
  },

  ---------------------------------------------------------------------------
  -- INSCRIPTION
  ---------------------------------------------------------------------------
  Inscription = {
    description = "Craft glyphs, staves, off-hands, and magical inks.",
    expansions = {
      Classic = {
        Alliance = { name="Catarina Stanford", location="Stormwind City", coords ={ mapID=84, x=49.8, y=74.0 }, notes="Capital city inscription trainer" },
        Horde    = { name="Nerog", location="Orgrimmar", coords ={ mapID=85, x=55.2, y=55.8 }, notes="Capital city inscription trainer" },
      },
      TBC = {
        Alliance = { name="Recorder Lidio (Aldor)", location="Shattrath City", coords ={ mapID=111, x=36.2, y=44.6 }, notes="Aldor scribe trainer" },
        Horde    = { name="Scribe Lanloer (Scryers)", location="Shattrath City", coords ={ mapID=111, x=56.6, y=74.6 }, notes="Scryers scribe trainer" },
      },
      WotLK = {
        Both = { name="Professor Pallin", location="Dalaran (Northrend)", coords ={ mapID=125, x=40.4, y=65.6 }, notes="Scribe's Sacellum" },
      },
      Cataclysm = {
        Alliance = { name="Catarina Stanford", location="Stormwind City", coords ={ mapID=84, x=49.8, y=74.0 }, notes="Capital city inscription trainer" },
        Horde    = { name="Nerog", location="Orgrimmar", coords ={ mapID=85, x=55.2, y=55.8 }, notes="Capital city inscription trainer" },
      },
      MoP = {
        Both = { name="Inkmaster Wei", location="The Jade Forest", coords ={ mapID=371, x=54.8, y=45.0 }, notes="Pandaria Inscription trainer" },
      },
      WoD = {
        Alliance = { name="Scribe (garrison follower)", location="Lunarfall (Garrison)", coords ={ mapID=582, x=50.0, y=50.0 }, notes="Garrison hub; Scribe's Quarters NPC/spot varies by building placement" },
        Horde    = { name="Scribe (garrison follower)", location="Frostwall (Garrison)", coords ={ mapID=590, x=50.0, y=50.0 }, notes="Garrison hub; Scribe's Quarters NPC/spot varies by building placement" },
      },
      Legion = {
        Both = { name="Professor Pallin", location="Dalaran (Broken Isles)", coords ={ mapID=627, x=41.6, y=37.2 }, notes="Legion Inscription trainer" },
      },
      BfA = {
        Alliance = { name="Janet the Huffer", location="Boralus", coords ={ mapID=1161, x=74.2, y=47.4 } },
        Horde    = { name="Chronicler Kizani", location="Dazar'alor (Zuldazar)", coords ={ mapID=1165, x=71.8, y=30.6 } },
      },
      Shadowlands = {
        Both = { name="Scribe Au'tehshi", location="Oribos", coords ={ mapID=1670, x=36.5, y=36.7 } },
      },
      Dragonflight = {
        Both = { name="Talendara", location="Valdrakken", coords ={ mapID=2112, x=38.6, y=73.2 } },
      },
      TWW = {
        Both = { name="Brrigan", location="Dornogal", coords ={ mapID=2339, x=48.6, y=71.0 }, notes="Khaz Algar Inscription trainer" },
      },
    },
  },

  ---------------------------------------------------------------------------
  -- JEWELCRAFTING
  ---------------------------------------------------------------------------
  Jewelcrafting = {
    description = "Craft gems, jewelry, and stone-based items.",
    expansions = {
      Classic = {
        Alliance = { name="Theresa Denman", location="Stormwind City", coords ={ mapID=84, x=63.6, y=61.6 }, notes="Capital city jewelcrafting trainer" },
        Horde    = { name="Lugrah", location="Orgrimmar", coords ={ mapID=85, x=72.4, y=34.6 }, notes="Capital city jewelcrafting trainer" },
      },
      TBC = {
        Both = { name="Faelyssa / Hamanar", location="Shattrath City", coords ={ mapID=111, x=62.8, y=67.8 }, notes="Aldor/Scryer districts; exact trainer varies" },
      },
      WotLK = {
        Both = { name="Timothy Jones", location="Dalaran (Northrend)", coords ={ mapID=125, x=40.6, y=35.2 }, notes="Northrend Jewelcrafting trainer" },
      },
      Cataclysm = {
        Alliance = { name="Theresa Denman", location="Stormwind City", coords ={ mapID=84, x=63.6, y=61.6 }, notes="Capital city jewelcrafting trainer" },
        Horde    = { name="Lugrah", location="Orgrimmar", coords ={ mapID=85, x=72.4, y=34.6 }, notes="Capital city jewelcrafting trainer" },
      },
      MoP = {
        Both = { name="Mai the Jade Shaper", location="The Jade Forest", coords ={ mapID=371, x=48.0, y=35.0 }, notes="Pandaria Jewelcrafting trainer" },
      },
      WoD = {
        Alliance = { name="Artificer Harlaan", location="Stormshield / Your Garrison", coords ={ mapID=622, x=52.6, y=64.8 }, notes="Approx Stormshield coords; patterns via Secret of Draenor Jewelcrafting" },
        Horde    = { name="Kaevan Highwit", location="Warspear / Your Garrison", coords ={ mapID=624, x=70.6, y=39.6 }, notes="Approx Warspear coords; patterns via Secret of Draenor Jewelcrafting" },
      },
      Legion = {
        Both = { name="Timothy Jones", location="Dalaran (Broken Isles)", coords ={ mapID=627, x=39.8, y=35.0 }, notes="Legion Jewelcrafting trainer" },
      },
      BfA = {
        Alliance = { name="Samuel D. Colton III", location="Boralus", coords ={ mapID=1161, x=76.2, y=34.8 } },
        Horde    = { name="Seshuli", location="Dazar'alor (Zuldazar)", coords ={ mapID=1165, x=71.0, y=30.0 } },
      },
      Shadowlands = {
        Both = { name="Shaman Bond", location="Oribos", coords ={ mapID=1670, x=35.8, y=41.2 } },
      },
      Dragonflight = {
        Both = { name="Gammul Gammult", location="Valdrakken", coords ={ mapID=2112, x=40.4, y=33.6 } },
      },
      TWW = {
        Both = { name="Makir", location="Dornogal", coords ={ mapID=2339, x=49.6, y=71.0 }, notes="Khaz Algar Jewelcrafting trainer" },
      },
    },
  },

  ---------------------------------------------------------------------------
  -- TAILORING
  ---------------------------------------------------------------------------
  Tailoring = {
    description = "Craft cloth armor, bags, and various textiles.",
    expansions = {
      Classic = {
        Alliance = { name="Georgio Bolero", location="Stormwind City", coords ={ mapID=84, x=43.0, y=74.0 }, notes="Capital city tailoring trainer, Mage Quarter" },
        Horde    = { name="Magar", location="Orgrimmar", coords ={ mapID=85, x=63.0, y=50.0 }, notes="Capital city tailoring trainer, The Drag" },
      },
      TBC = {
        Both = { name="Gidge Spellweaver", location="Shattrath City", coords ={ mapID=111, x=63.0, y=68.0 }, notes="Aldor district" },
      },
      WotLK = {
        Both = { name="Charles Worth", location="Dalaran (Northrend)", coords ={ mapID=125, x=37.0, y=33.2 }, notes="Northrend Tailoring trainer" },
      },
      Cataclysm = {
        Alliance = { name="Georgio Bolero", location="Stormwind City", coords ={ mapID=84, x=43.0, y=74.0 }, notes="Capital city tailoring trainer, Mage Quarter" },
        Horde    = { name="Magar", location="Orgrimmar", coords ={ mapID=85, x=63.0, y=50.0 }, notes="Capital city tailoring trainer, The Drag" },
      },
      MoP = {
        Both = { name="Silkmaster Tsai", location="Valley of the Four Winds", coords ={ mapID=376, x=62.6, y=59.6 }, notes="Pandaria Tailoring trainer" },
      },
      WoD = {
        Alliance = { name="Tailoring Trainer", location="Lunarfall (Garrison)", coords ={ mapID=582, x=50.0, y=50.0 }, notes="Garrison hub; exact trainer/spot varies by building placement" },
        Horde    = { name="Tailoring Trainer", location="Frostwall (Garrison)", coords ={ mapID=590, x=50.0, y=50.0 }, notes="Garrison hub; exact trainer/spot varies by building placement" },
      },
      Legion = {
        Both = { name="Lotherias", location="Dalaran (Broken Isles)", coords ={ mapID=627, x=36.0, y=33.0 } },
      },
      BfA = {
        Alliance = { name="Eleanor", location="Boralus", coords ={ mapID=1161, x=76.0, y=34.0 } },
        Horde    = { name="Pin'jin the Patient", location="Dazar'alor (Zuldazar)", coords ={ mapID=1165, x=44.4, y=33.8 }, notes="Terrace of Crafters" },
      },
      Shadowlands = {
        Both = { name="Stitcher Au'phes", location="Oribos", coords ={ mapID=1670, x=43.2, y=31.5 }, notes="Hall of Shapes" },
      },
      Dragonflight = {
        Both = { name="Threadgill", location="Valdrakken", coords ={ mapID=2112, x=36.2, y=65.0 } },
      },
      TWW = {
        Both = { name="Layla Shadowfury", location="Dornogal", coords ={ mapID=2339, x=55.0, y=64.0 }, notes="Forgegrounds area (verified)" },
      },
    },
  },

  ---------------------------------------------------------------------------
  -- MISCELLANEOUS
  ---------------------------------------------------------------------------
  Miscellaneous = {
    description = "Non-standard profession sources (specialization systems, quest chains).",
    expansions = {
      -- Junkyard Tinkering (Mechagon) - not a traditional trainer.
      BfA = {
        Both = { name="Pascal-K1N6", location="Mechagon (Rustbolt)", coords ={ mapID=1462, x=69.0, y=31.0 }, notes="Learned via Mechagon quests/systems; coordinates can vary by phase" },
      },
    },
  },

  ---------------------------------------------------------------------------
  -- SPECIAL RECIPE VENDORS (Housing Decor)
  ---------------------------------------------------------------------------
  SpecialRecipeVendors = {
    description = "Specific vendors who sell housing decor profession recipes.",
    vendors = {
      -- Midnight Expansion Vendors
      ["Void Researcher Anomander"] = {
        location = "Voidstorm (Howling Ridge, bottom level)",
        mapID = 2405,
        coords = { mapID=2405, x=52.6, y=72.8 },
        notes = "Singularity renown quartermaster - Sells Void Elf/Ren'dorei themed recipes",
      },
      ["Caeris Fairdawn"] = {
        location = "Eversong Woods (Saltheril's Haven)",
        mapID = 2395,
        coords = { mapID=2395, x=43.4, y=47.4 },
        notes = "Silvermoon Court quartermaster - Sells Sin'dorei themed recipes",
      },
      ["Lelorian"] = {
        location = "Silvermoon City (Bazaar area)",
        mapID = 110,
        coords = { mapID=110, x=60.0, y=50.0 },
        notes = "Inscription supplies - Exact pin pending beta updates",
      },
      ["Magovu"] = {
        location = "Zul'Aman (Amani'Zar village, main building)",
        mapID = 2437,
        coords = { mapID=2437, x=45.8, y=65.8 },
        notes = "Amani Tribe quartermaster - Sells Amani themed recipes",
      },
      ["Naynar"] = {
        location = "Harandar (The Den, ground floor)",
        mapID = 2413,
        coords = { mapID=2413, x=51.0, y=50.8 },
        notes = "Hara'ti renown quartermaster - Sells Haranir themed recipes",
      },
      ["Construct V'anore"] = {
        location = "Silvermoon City (Astalor's Sanctum, Murder Row)",
        mapID = 110,
        coords = { mapID=110, x=50.0, y=40.0 },
        notes = "Prey system rewards - Sells magical construct-themed recipes",
      },
      ["Neriv"] = {
        location = "Eversong Woods (Saltheril's Haven)",
        mapID = 2395,
        coords = { mapID=2395, x=43.4, y=47.6 },
        notes = "Shades of the Row quartermaster - Sells elf-themed recipes",
      },

      -- TWW (The War Within) Vendors
      ["Lyrendal"] = {
        location = "Dornogal",
        mapID = 2339,
        coords = { mapID=2339, x=59.8, y=56.4 },
        notes = "Artisan's Consortium - Sells TWW housing recipes",
      },
      ["Auditor Balwurz"] = {
        location = "Dornogal (Foundation Hall)",
        mapID = 2339,
        coords = { mapID=2339, x=39.1, y=24.2 },
        notes = "Council of Dornogal quartermaster - Sells TWW housing recipes",
      },

      -- WoD (Warlords of Draenor) Vendors
      ["Arsenio Zerep"] = {
        location = "Shadowmoon Valley (near garrison gates)",
        mapID = 539,
        coords = { mapID=539, x=40.0, y=50.0 },
        notes = "Non-garrison vendor - Sells cooking recipes (approx coords)",
      },
      ["Nonn Threeratchet"] = {
        location = "Warspear (vendor row)",
        mapID = 624,
        coords = { mapID=624, x=50.0, y=50.0 },
        notes = "Sells Horde Draenor blacksmithing recipes (central area)",
      },
      ["Joshua Alvarez"] = {
        location = "Warspear",
        mapID = 624,
        coords = { mapID=624, x=50.0, y=50.0 },
        notes = "Sells Horde Draenor alchemy recipes (central area)",
      },
      ["Nik Steelrings"] = {
        location = "Warspear",
        mapID = 624,
        coords = { mapID=624, x=70.6, y=39.6 },
        notes = "Sells Horde Draenor engineering recipes",
      },
      ["Joao Calhandro"] = {
        location = "Lunarfall (Garrison)",
        mapID = 543, -- Lunarfall garrison
        coords = { mapID=543, x=50.0, y=50.0 },
        notes = "Sells Alliance Draenor inscription recipes (variable by building placement)",
      },
      ["Petir Starocean"] = {
        location = "Warspear",
        mapID = 624,
        coords = { mapID=624, x=50.0, y=50.0 },
        notes = "Sells Horde Draenor tailoring recipes (central area)",
      },
      ["Artificer Harlaan"] = {
        location = "Stormshield",
        mapID = 622,
        coords = { mapID=622, x=44.6, y=37.6 },
        notes = "Sells Alliance Draenor jewelcrafting recipes",
      },
      ["Garm Gladestride"] = {
        location = "Warspear",
        mapID = 624,
        coords = { mapID=624, x=50.0, y=50.0 },
        notes = "Sells Horde Draenor leatherworking recipes (central area)",
      },

      -- Classic/TBC Vendors
      ["Deynna"] = {
        location = "Silvermoon City (Bazaar)",
        mapID = 110,
        coords = { mapID=110, x=56.0, y=51.8 },
        notes = "Sells tailoring supplies and classic recipes",
      },

      -- Generic/Multiple Locations
      ["World Vendors"] = {
        location = "Scattered globally",
        mapID = nil,
        coords = nil,
        notes = "Generic vendor placeholder - recipes available from multiple sources worldwide",
      },
      ["Bob"] = {
        location = "Stormshield (Ashran)",
        mapID = 622,
        coords = { mapID=622, x=50.8, y=36.8 },
        notes = "Standing outside, behind the Auction House building, next to Engineering vendor Bil Sparktonic",
      },
    },
  },

})
