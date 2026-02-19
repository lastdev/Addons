local addonName, dv = ...
dv.decorItem = dv.decorItem or {}
dv.expansions = dv.expansions or {}


dv.npcs = {
  {
    name = "Grim Guzzler Non Instanced Version",
	expansion = "Race Locked",
      vendors = {
	  { zone = "Dark Iron Dwarf Only", id = 144129, model3D = 8652, title = "Plugger Spazzring", x = 49.77, y = 32.22, mapID = 1186 , faction = "neutral" },
    }
  }, 
  {
    name = "Dun Morogh",
	expansion = "Race Locked",
      vendors = {
      { zone = "Kharanos-Must be Gnome or Dwarf", id = 1247, model3D = 3434, title = "Innkeeper Belm", x = 54.4, y = 50.8, mapID = 27 , faction = "alliance"  },
    }
  },
    {
    name = "Thaldraszus - Valdrakken",
	expansion = "Race Locked",
      vendors = {
		{ zone = "Valdrakken - Dracthyr Only", id = 196637, model3D = 109197, title = "Tethalash", x = 25.52, y = 33.65, mapID = 2112, faction = "neutral" },
    }
  },
  {
    name = "Brawl'gar Arena",
	expansion = "Classic",
    vendors = {
      { zone = "Brawl'gar Arena", id = 68364, model3D = 46757, title = "Paul North", x = 52.0, y = 27.8, mapID = 503 , faction = "horde" },
    }
  },
  {
    name = "Hillsbrad Foothill",
	expansion = "Classic",
    vendors = {
      { zone = "Pvp Vendor", id = 13217, model3D = 13319, title = "Thanthaldis Snowgleam", x = 44.8, y = 46.4, mapID = 25 , faction = "neutral" },
    }
  },
  {
    name = "Blasted Lands",
	expansion = "Classic",
      vendors = {
      { zone = "Surwich",  id = 44337, model3D = 33806, title = "Maurice Essman", x = 45.8, y = 88.6, mapID = 17 , faction = "alliance"  },
    }
  },
  {
    name = "Burning Steppes",
	expansion = "Classic",
      vendors = {
      { zone = "Chiselgrip", faction = "neutral" , id = 115805, model3D = 73953, title = "Hoddruc Bladebender", x = 46.8, y = 44.6, mapID = 36 },
    }
  },
 --[[ {
    name = "Darnassus",
	expansion = "Classic",
      vendors = {
      { zone = "PRE-DESTRUCTION", id = 50307, model3D = 37015, title = "Lord Candren", x = 37.2, y = 47.6, mapID = 89 , faction = "alliance" },
    }
  },]]
  {
    name = "Bizmo's Brawlpub",
	expansion = "Classic",
      vendors = {
      { zone = "Bizmo's Brawlpub", id = 68363, model3D = 46755, title = "Quackenbush", x = 51.0, y = 30.0, mapID = 499 , faction = "alliance"  },
    }
  },
  {
    name = "Duskwood",
	expansion = "Classic",
      vendors = {
      { zone = "Raven Hill", id = 44114, model3D = 33678, title = "Wilkinson", x = 20.27, y = 58.35, mapID = 47 , faction = "alliance" },
    }
  },
  {
    name = "Dustwallow Marsh",
	expansion = "Classic",
      vendors = {
      { zone = "Mudsprocket", faction = "neutral" , id = 23995, model3D = 31082, title = "Axle", x = 41.9, y = 73.9, mapID = 70  },
    }
  },
  {
    name = "Eastern PlagueLands",
	expansion = "Classic",
      vendors = {
        { zone = "Lights Hope Chapel", id = 45417, model3D = 34450, title = "Fiona", x = 73.8, y = 52.2, mapID = 23, faction = "neutral" },
    }
  },
  {
    name = "Loch Modan",
	expansion = "Classic",
      vendors = {
      { zone = "Thelsamar", id = 1465, model3D = 1820, title = "Drac Roughcut", x = 35.6, y = 49.0, mapID = 48 , faction = "alliance" },
    }
  },
  {
    name = "Orgrimmar",
	expansion = "Classic",
      vendors = {
      { zone = "Hall of Legends", faction = "horde" , id = 254606, model3D = 138276, title = "Joruh", x = 38.8, y = 71.93, mapID = 85 },
      { zone = "Orgrimmar", id = 50488, model3D = 37020, title = "Stone Guard Nargol", x = 50.2, y = 58.4, mapID = 85 , faction = "horde" },
      { zone = "The Drag", faction = "horde" , id = 256119, model3D = 139508, title = "Lonalo", x = 58.4, y = 50.6, mapID = 85 },
	  { zone = "Near Trading Post", faction = "horde" , id = 261262, model3D = 34566, title = "Gabbi", x = 48.4, y = 81.0, mapID = 85 },
    }
  },
  {
    name = "Searing Gorge",
	expansion = "Classic",
      vendors = {
      { zone = "Thorium Point", id = 14624, model3D = 14652, title = "Master Smith Burninate", x = 38.6, y = 28.7, mapID = 32, faction = "neutral" },
    }
  },
  {
    name = "Silverpine Forest",
	expansion = "Classic",
      vendors = {
      { zone = "The Sepulcher", id = 2140, model3D = 3542, title = "Edwin Harly", x = 44.06, y = 39.68, mapID = 21 , faction = "horde" },
    }
  },
  {
    name = "Gilneas Post Takeover",
	expansion = "Cataclysm",
      vendors = {
      { zone = "Stormglen Village", id = 211065, model3D = 30289, title = "Marie Allen", x = 60.4, y = 92.4, mapID = 217 , faction = "alliance"  },
      { zone = "Gilneas City", id = 50307, model3D = 37015, title = "Lord Candren", x = 56.94, y = 55.91, mapID = 217 , faction = "alliance" },
      { zone = "Gilneas City", id = 216888, model3D = 30289, title = "Samantha Buckley", x = 65.2, y = 47.2, mapID = 217, faction = "alliance"  },
    }
  },
  {
    name = "Stormwind",
	expansion = "Classic",
      vendors = {
      { zone = "Stormwind", id = 49877, model3D = 36758, title = "Captain Lancy Revshon", x = 67.79, y = 73.05, mapID = 84 , faction = "alliance" },
      { zone = "Mage Quarter", faction = "alliance" ,id = 256071, model3D = 139467, title = "Solelo", x = 49.0, y = 80.0, mapID = 84 },
      { zone = "Old Town", id = 254603, model3D = 138274, title = "Riica", x = 77.8, y = 65.8, mapID = 84 , faction = "alliance" },
	  { zone = "Near Trading Post", id = 261231, model3D = 17507, title = "Tuuran", x = 48.6, y = 68.8, mapID = 84 , faction = "alliance"},
    }
  },
  {
    name = "Stranglethorn Vale",
	expansion = "Classic",
      vendors = {
      { zone = "Nesingwary Expedition", title = "Jacquilina Dramet", faction = "neutral" , id = 2483, model3D = 4394, x = 43.8, y = 23.2, mapID = 50 },
    }
  },
  {
    name = "Thunder Bluff",
	expansion = "Classic",
      vendors = {
      { zone = "Thunder Bluff", id = 50483, model3D = 37022, title = "Brave Tuho", x = 46.2, y = 50.6, mapID = 88 , faction = "horde" },
    }
  },
  {
    name = "Undercity",
	expansion = "Classic",
      vendors = {
      { zone = "PRE-DESTRUCTION", id = 50304, model3D = 37023, title = "Captain Donald Adams", x = 63.2, y = 49.0, mapID = 90 , faction = "horde"  },
    }
  },
  {
    name = "Wetlands",
	expansion = "Classic",
      vendors = {
      { zone = "Menethil Harbor", id = 3178, model3D = 3468, title = "Stuart Fleming", x = 6.27, y = 57.45, mapID = 56 , faction = "alliance" },
    }
  },
  {
    name = "Ironforge",
	expansion = "Classic",
      vendors = {
      { zone = "The Commons", id = 253235, model3D = 137770, title = "Dedric Sleetshaper", x = 24.72, y = 43.93, mapID = 87, faction = "alliance" },
      { zone = "Ironforge", id = 50309, model3D = 37017, title = "Captain Stonehelm", x = 55.6, y = 48.2, mapID = 87 , faction = "alliance"  },
      { zone = "The Library", faction = "alliance" ,  id = 253232, model3D = 137768, title = "Inge Brightview", x = 75.8, y = 9.4, mapID = 87 },
    }
  }, 
  {
    name = "Ghostlands",
	expansion = "The Burning Crusade",
      vendors = {
      { zone = "Tranquillien - Pre Midnight", id = 16528, model3D = 16242, title = "Provisioner Vredigar", x = 47.6, y = 32.4, mapID = 95 , faction = "horde" },
    }
  },
  {
    name = "Scholazar Basin",
	expansion = "Wrath of the Lich King",
      vendors = {
      { zone = "Nesingwary Base Camp", id = 28038, model3D = 25056, title = "Purser Boulian", x = 26.8, y = 59.2, mapID = 119, faction = "neutral" },
    }
  },
  {
    name = "Grizzly Hills",
	expansion = "Wrath of the Lich King",
      vendors = {
      { zone = "Amberpine Lodge", id = 27391, model3D = 24604, title = "Woodsman Drake", x = 32.4, y = 59.8, mapID = 116, faction = "alliance" },
    }
  },
  {
  name = "Borean Tundra",
  expansion = "Wrath of the Lich King",
      vendors = {
      { zone = "Winterfin Retreat", id = 25206, model3D = 4920, title = "Ahlurglgr", faction = "neutral" , mapID = 114, x = 43.03, y = 13.78 },
      }	
  },
  {
    name = "Twilight Highlands",
	expansion = "Cataclysm",
      vendors = {
      { zone = "Thundermar", id = 253227, model3D = 137766, title = "Breana Bitterbrand", x = 49.6, y = 29.6, mapID = 241, faction = "alliance" },
      { zone = "Thundermar", id = 49386, model3D = 36453, title = "Craw MacGraw", x = 48.6, y = 30.6, mapID = 241, faction = "alliance" },             
    }
  },
  {
    name = "Jade Forest",
	expansion = "Mists of Pandaria",
      vendors = {
        { zone = "Arboretum", faction = "neutral", id = 58414, model3D = 40146, title = "San Redscale", x = 56.8, y = 44.4, mapID = 371 },
		{ zone = "Lootable Once", faction = "neutral", id = 253602, model3D = 95785, title = "Frederick the Fabulous", x = 57.72, y = 15.68, mapID = 371 },
    }
  },
  {
    name = "Kun-Lai Summit",
	expansion = "Mists of Pandaria",
      vendors = {
        { zone = "One Keg", faction = "neutral", id = 59698, model3D = 45821, title = "Brother Furtrim", x = 57.24, y = 60.96, mapID = 379 },
    }
  },
  {
    name = "Valley of the Four Winds",
	expansion = "Mists of Pandaria",
      vendors = {
        { zone = "Halfhill", faction = "neutral", id = 58706, model3D = 41769, title = "Gina Mudclaw", x = 53.2, y = 51.8, mapID = 376 },
    }
  },
  {
    name = "Vale of Eternal Blossoms - Shrine of 2 Moons",
	expansion = "Mists of Pandaria",
      vendors = {
        { zone = "Shrine of 2 Moons", faction = "horde", id = 64001, model3D = 43420, title = "Sage Lotusbloom", x = 62.8, y = 23.2, mapID = 390 },
    }
  },
  {
    name = "Vale of Eternal Blossoms - Shrine of 7 Stars",
	expansion = "Mists of Pandaria",
      vendors = {
        { zone = "Shrine of 7 Stars", id = 64032, model3D = 44182, title = "Sage Whiteheart", x = 85.2, y = 61.6, mapID = 1530, faction = "alliance" },
    }
  },
  {
    name = "Vale of Eternal Blossoms",
	expansion = "Mists of Pandaria",
      vendors = {
        { zone = "Seat of Knowledge", faction = "neutral", id = 64605, model3D = 44814, title = "Tan Shin Tiao", x = 82.23, y = 29.33, mapID = 390 },
        { zone = "Seat of Knowledge", faction = "neutral", id = 62088, model3D = 42350, title = "Lali the Assistant", x = 82.8, y = 30.8, mapID = 390 },
    }
  },
  {
    name = "Frostwall",
	expansion = "Warlords of Draenor",
      vendors = {
        { zone = "Barracks", id = 79812, model3D = 56555, title = "Moz'def", x = 48.0, y = 66.0, mapID = 525 , faction = "horde"  },
		{ zone = "Horde Garrison", id = 76872, model3D = 53501, title = "Supplymaster Eri", x = 48.0, y = 66.0, mapID = 525 , faction = "horde" },
		{ zone = "Horde Garrison Tier 3", id = 79774, model3D = 56527, title = "Sergeant Grimjaw", x = 43.8, y = 47.4, mapID = 590 , faction = "horde" },
		{ zone = "Trading Post Level 2", id = 87015, model3D = 56923, title = "Kil'rip", x = 48.0, y = 66.0, mapID = 525 , faction = "horde"  },
		{ zone = "Horde Garrison", id = 87312, model3D = 27957, title = "Vora Strongarm", x = 48.0, y = 66.0, mapID = 525 , faction = "horde"  },
		{ zone = "Trading Post", id = 86776, model3D = 56923, title = "Ribchewer", faction = "horde" },		
		--{ zone = "Random trader in Trading Post", id = 86778, title = "Pyxni Pennypocket", faction = "horde" },		
		-- { zone = "Random trader in Trading Post", id = 86683, title = "Tai'tasi", faction = "horde" },
		-- { zone = "Trading Post Level 2", id = 86779, model3D = 56410, title = "Krixel Pinchwhistle", x = 31.0, y = 15.0, mapID = 525 , faction = "horde"  },
		-- { zone = " Trading Post", id = 86777, title = "Elder Surehide", faction = "horde" },
    }
  },
  {
    name = "Lunarfall",
	expansion = "Warlords of Draenor",
      vendors = {
        { zone = "Alliance Garrison Tier 3", id = 78564, model3D = 61187, title = "Sergeant Crowler", x = 38.5, y = 31.4, mapID = 582 , faction = "alliance" },
        { zone = "Trading Post Tier 3", id = 85427, model3D = 61418, title = "Maaria", x = 31.0, y = 15.0, mapID = 539 , faction = "alliance" },
		{ zone = "Alliance Garrison", id = 88220, model3D = 60816, title = "Peter", x = 31.0, y = 15.0, mapID = 539 , faction = "alliance"  },
		-- { zone = "Alliance Garrison", id = 86779, model3D = 56410, title = "Krixel Pinchwhistle", x = 31.0, y = 15.0, mapID = 539 , faction = "alliance"  },
    }
  },
  {
    name = "Shadowmoon Valley",
	expansion = "Warlords of Draenor",
      vendors = {
        { zone = "Embaari Village", id = 81133, model3D = 56229, title = "Artificer Kallaes", x = 46.2, y = 39.3, mapID = 539 , faction = "alliance" },
    }
  },
  {
    name = "Spires of Arak",
	expansion = "Warlords of Draenor",
      vendors = {
		{ zone = "Veil Terokk", id = 87775, model3D = 61065, title = "Ruuan the Seer", x = 46.6, y = 45.0, mapID = 542, faction = "neutral"  },
    }
  },
  {
    name = "Stormshield",
	expansion = "Warlords of Draenor",
      vendors = {
        { zone = "Stormshield", id = 85950, model3D = 59234, title = "Trader Caerel", x = 41.4, y = 59.8, mapID = 622, faction = "alliance" },
        { zone = "The Town Hall", id = 85932, model3D = 59224, title = "Vindicator Nuurem", x = 46.4, y = 74.6, mapID = 622, faction = "alliance" },
		 { zone = "The Town Hall", id = 85946, model3D = 59471, title = "Shadow-Sage Brakoss", faction = "alliance", mapID = 622, x = 46.49, y = 75.03 },
		 { zone = "Warspear Hold", id = 86037, model3D = 61112, title = "Ravenspeaker Skeega", faction = "horde", mapID = 624, x = 53.30, y = 59.96 },
    }
  },
  {
    name = "Talador",
	expansion = "Warlords of Draenor",
      vendors = {
        { zone = "Terokkar Refuge", id = 256946, model3D = 139888, title = "Duskcaller Erthix", x = 70.4, y = 57.6, mapID = 535, faction = "neutral" },
    }
  },
  {
    name = "Argus",
	expansion = "Legion",
      vendors = {
        { zone = "The Vindicaar", id = 127151, model3D = 79278, title = "Toraan the Revered", x = 68.22, y = 56.91, mapID = 831, faction = "neutral" },
    }
  },
  {
    name = "Azsuna",
	expansion = "Legion",
      vendors = {
        { zone = "Leyhollow Cave", id = 89939, model3D = 28080, title = "Berazus", x = 47.8, y = 23.6, mapID = 630, faction = "neutral" },
    }
  },
  {
    name = "Dalaran",
	expansion = "Legion",
      vendors = {
        { zone = "Photonic Playground", id = 112716, model3D = 56737, title = "Rasil Fireborne", x = 43.4, y = 49.4, mapID = 627, faction = "neutral" },		
		{ zone = "Sunreaver Sanctuary - Filthy Animal", id = 252043, model3D = 137328, title = "Halenthos Brightstride", x = 67.46, y = 33.89, mapID = 627, faction = "horde" },
		{ zone = "The Underbelly", id = 105333, model3D = 69095, title = "Val'zuun", x = 67.36, y = 63.22, mapID = 628, faction ="neutral"   },
    }
  },
  {
    name = "Highmountain",
	expansion = "Legion",
      vendors = {
		{ zone = "Thunder Totem", id = 106902, model3D = 72888, title = "Ransa Greyfeather", x = 38.06, y = 46.05, mapID = 750, faction = "neutral" },
        { zone = "Thunder Totem - Bottom Half", id = 108017, model3D = 70380, title = "Torv Dubstomp", faction = "neutral", mapID = 652, x = 54.80, y = 78.08 },
	    { zone = "Shipwreck Cove", id = 108537, model3D = 70605, title = "Crafty Palu", x = 41.62, y = 10.44, mapID = 650, faction = "neutral"   },
    }
  },
  {
    name = "Suramar",
	expansion = "Legion",
      vendors = {
        { zone = "Shal'Aran", id = 115736, model3D = 67345, title = "First Arcanist Thalyssra", x = 36.49, y = 45.83, mapID = 680, faction = "neutral" },
        { zone = "The Grand Promenade", id = 93971, model3D = 70030, title = "Leyweaver Inondra", x = 40.32, y = 69.73, mapID = 680, faction = "neutral"  },
		{ zone = "Concourse of Destiny", id = 252969, model3D = 137688, title = "Jocenna", x = 49.63, y = 62.83, mapID = 680, faction = "neutral" },
		{ zone = "Shimmershade Garden", id = 255101, model3D = 138645, title = "Mynde", x = 45.58, y = 69.15, mapID = 680, faction = "neutral" },
		{ zone = "Irongrove Retreat", id = 253434, model3D = 137851, title = "Sileas Duskvine", x = 79.92, y = 73.89, mapID = 641, faction = "neutral" },
        { zone = "suramar", id = 248594, model3D = 73413, title = "Sundries Merchant", x = 50.9, y = 77.78, mapID = 680, faction = "neutral" },
    }
  },
  {
    name = "Val'sharah",
	expansion = "Legion",
      vendors = {
        { zone = "Lorlathil", id = 253387, model3D = 137846, title = "Selfira Ambergrove", x = 54.26, y = 72.36, mapID = 641, faction = "neutral" },
        { zone = "Lorlathil", id = 106901, model3D = 74537, title = "Sylvia Hartshorn", x = 54.7, y = 73.25, mapID = 641, faction = "neutral" },
        { zone = "Bradenbrook", id = 252498, model3D = 137440, title = "Corbin Branbell", x = 42.09, y = 59.38, mapID = 641, faction = "neutral" },
        { zone = "Field of Dreamers (patrols)", id = 112634, model3D = 72149, title = "Hilseth Travelstride", x = 57.14, y = 71.91, mapID = 641, faction = "neutral" },
        { zone = "Lightsong", id = 109306, model3D = 70971, title = "Myria Glenbrook", x = 60.2, y = 84.86, mapID = 641, faction = "neutral" },
		{ zone = "Val'sharah", id = 256826, model3D = 139842, title = "Mrgrgrl", x = 68.72, y = 95.1, mapID = 641, faction = "neutral" },
    }
  },
  {
    name = "Class Halls",
	expansion = "Legion",
      vendors = {
      { zone = "Demon Hunter", id = 112407, model3D = 61734, title = "Falara Nightsong", x = 61.0, y = 56.73, mapID = 720, faction = "neutral" },
      { zone = "Paladin", id = 100196, model3D = 28836, title = "Eadric the Pure", x = 75.64, y = 49.09, mapID = 23, faction = "neutral" },
      { zone = "Hunter", id = 103693, model3D = 68326, title = "Outfitter Reynolds", x = 44.56, y = 48.88, mapID = 739, faction = "neutral" },
      { zone = "Druid", id = 112323, model3D = 72032, title = "Amurra Thistledew", x = 40.02, y = 17.72, mapID = 747, faction = "neutral" },
      { zone = "Rogue", id = 105986, model3D = 31159, title = "Kelsey Steelspark", x = 26.92, y = 36.83, mapID = 626, faction = "neutral" },
      { zone = "Monk", id = 112338, model3D = 72042, title = "Caydori Brightstar", x = 50.4, y = 59.0, mapID = 709, faction = "neutral" },
      { zone = "Death Knight", id = 93550, model3D = 15958, title =  "Quartermaster Ozorg", x = 43.9, y = 37.17, mapID = 647, faction = "neutral" },
      { zone = "Warlock", id = 112434, model3D = 72070, title = "Gigi Gigavoid", x = 58.76, y = 32.69, mapID = 717 , faction = "neutral" },
      { zone = "Mage", id = 112440, model3D = 72075, title = "Jackson Watkins", x = 44.75, y = 57.87, mapID = 735 , faction = "neutral" },
      { zone = "Shaman", id = 112318, model3D = 72029, title = "Flamesmith Lanying", x = 30.32, y = 60.69, mapID = 726, faction = "neutral" },
      { zone = "Warrior", id = 112392, model3D = 72055, title = "Quartermaster Durnolf", x = 55.49, y = 25.91, mapID = 695, faction = "neutral" },
      { zone = "Priest", id = 112401, model3D = 72056, title = "Meridelle Lightspark", x = 38.62, y = 23.77, mapID = 702, faction = "neutral" },
    }
  },
  {
    name = "Silithus",
	expansion = "Battle for Azeroth",
      vendors = {
      { zone = "Chamber of Heart", id = 152194, model3D = 91066, title = "MOTHER", x = 48.3, y = 72.1, mapID = 1473, faction = "neutral" },
    }
  },
  {
    name = "Stormsong Valley",
	expansion = "Battle for Azeroth",
      vendors = {
      { zone = "Brennadom", id = 252313, model3D = 137393, title = "Caspian", x = 59.6, y = 69.6, mapID = 942 , faction = "alliance" },
    }
  },
  {
    name = "Mechagon",
	expansion = "Battle for Azeroth",
      vendors = {     
	  { zone = "Mechagon", id = 150716, model3D = 92583, title = "Stolen Royal Vendorbot", x = 73.7, y = 36.91, mapID = 1462, faction = "neutral" },
    }
  },
  {
    name = "Tiragarde Sound",
	expansion = "Battle for Azeroth",
      vendors = {
      { zone = "Harbormaster's Office", id = 135808, model3D = 84415, title = "Provisioner Fray", x = 67.6, y = 21.8, mapID = 1161 , faction = "alliance" },
      { zone = "Tradewinds Market", id = 252345, model3D = 137409, title = "Pearl Barlow", x = 70.74, y = 15.66, mapID = 1161, faction = "alliance" },
      { zone = "Boralus Harbor", id = 142115, model3D = 34450, title = "Fiona", x = 67.6, y = 40.8, mapID = 1161, faction = "alliance" },
	  { zone = "Hook Point", id = 246721, model3D = 130151, title = "Janey Forrest", x = 56.29, y = 45.82, mapID = 1161, faction = "alliance" },
	  { zone = "Norwington Estate", id = 252316, model3D = 137394, title = "Delphine", x = 53.4, y = 31.2, mapID = 895, faction = "neutral" },
    }
  },
  {
    name = "Nazmir",
	expansion = "Battle for Azeroth",
      vendors = {
      { zone = "Zu'jan Ruins", id = 135459, model3D = 84261, title = "Provisioner Lija", x = 39.11, y = 79.47, mapID = 863 , faction = "horde" },
    }
  },
  {
    name = "Zuldazar",
	expansion = "Battle for Azeroth",
      vendors = {
      { zone = "Port of Zandalar", id = 148924, model3D = 90164, title = "Provisioner Mukra", x = 51.22, y = 95.08, mapID = 1165 , faction = "horde" },
      { zone = "Port of Zandalar", id = 148923, model3D = 90162, title = "Captain Zen'taga", x = 44.6, y = 94.4, mapID = 1165 , faction = "horde" },
      { zone = "Zuldazar Docks", id = 251921, model3D = 137265, title = "Arcanist Peroleth", x = 58.0, y = 62.6, mapID = 862 , faction = "horde" },
      { zone = "Zuldazar - The Great Seal", id = 252326, model3D = 137395, title = "T'lama", x = 36.94, y = 59.17, mapID = 1164 , faction = "horde" },
    }
  },
  {
    name = "Covenants",
	expansion = "Shadowlands",
      vendors = {
        { zone = "Revendreth - Sinfall - Venthyr Only", id = 174710, model3D = 99162, title = "Chachi the Artiste", x = 54.0, y = 24.8, mapID = 1699, faction = "neutral" },
    }
  },
  {
    name = "The Maw",
	expansion = "Shadowlands",
      vendors = {
        { zone = "Ve'nari's Refuge", id = 162804, model3D = 95004, title = "Ve'nari", x = 46.8, y = 41.6, mapID = 1543, faction = "neutral" },
    }
  },
  {
    name = "The Forbidden Reach",
	expansion = "Dragonflight",
      vendors = {
		{ zone = "Morqut Village", id = 253086, model3D = 137722, title = "Jolinth", x = 35.2, y = 57.0, mapID = 2151, faction = "neutral" },
    }
  },
  {
    name = "Thaldraszus - Valdrakken",
	expansion = "Dragonflight",
      vendors = {
        { zone = "The Seat of Aspects - Lower", id = 193015, model3D = 108045, title = "Unatos", x = 58.2, y = 35.6, mapID = 2112, faction = "neutral" },
        { zone = "The Parting Glass", id = 253067, model3D = 137718, title = "Silvrath", x = 71.53, y = 49.62, mapID = 2112, faction = "neutral" },
		{ zone = "Valdrakken Treasury Hoard", id = 199605, model3D = 110855, title = "Evantkis", x = 58.4, y = 57.4, mapID = 2112, faction = "neutral" },
		{ zone = "The Obsidian Enclave", id = 193659, model3D = 108249, title = "Provisioner Thom", x = 36.8, y = 50.6, mapID = 2112, faction = "neutral" },
		{ zone = "Valdrakken - evoker only maybe", id = 196637, model3D = 109197, title = "Tethalash", x = 25.52, y = 33.65, mapID = 2112, faction = "neutral" },
		{ zone = "Azerothian Archives", id = 209192, model3D = 113800, title = "Provisioner Aristta", x = 61.4, y = 31.4, mapID = 2025, faction = "neutral" },
		{ zone = "Eon's Fringe", id = 209220, model3D = 112638, title = "Ironus Coldsteel", x = 52.2, y = 80.8, mapID = 2025, faction = "neutral" },
    }
  },
  {
    name = "The Waking Shores",
	expansion = "Dragonflight",
      vendors = {
		{ zone = "Dragonscale Basecamp", id = 189226, model3D = 106843, title = "Cataloger Jakes", x = 47.0, y = 82.6, mapID = 2022, faction = "neutral" },
		{ zone = "Dragonscale Basecamp", id = 188265, model3D = 106418, title = "Rae'ana", x = 47.8, y = 82.2, mapID = 2022, faction = "neutral" },
		{ zone = "Ruby Lifeshrine", id = 191025, model3D = 102721, title = "Lifecaller Tzadrak", x = 62.0, y = 73.8, mapID = 2022, faction = "neutral" },	
    }
  },
  {
    name = "Dragonflight Dreamsurge",
	expansion = "Dragonflight",
       vendors = {     
         { zone = "Dreamsurge Location",  id = 210608, model3D = 33840, title = "Celestine of the Harvest", faction = "neutral" },
    }
  },
  {
    name = "Amirdrassil",
	expansion = "Dragonflight",
      vendors = {
		{ zone = "Bel'ameth", id = 216286, model3D = 113048, title = "Moon Priestess Lasara", x = 46.6, y = 70.6, mapID = 2239 , faction = "alliance" },
        { zone = "Bel'ameth", id = 216284, model3D = 113507, title = "Mythrin'dir", x = 54.0, y = 60.8, mapID = 2239 , faction = "alliance" },
        { zone = "Bel'ameth", id = 216285, model3D = 113508, title = "Ellandrieth", x = 48.4, y = 53.6, mapID = 2239 , faction = "alliance" },
    }
  },
  {
    name = "Isle of Dorn",
	expansion = "The War Within",
      vendors = {
        { zone = "Dornogal - Foundation Hall", id = 223728, model3D = 120830, title = "Auditor Balwurz", x = 39.2, y = 24.4, mapID = 2339, faction = "neutral" },
        { zone = "Dornogal - The Forgegrounds", id = 219318, model3D = 117779, title = "Jorid", x = 57.0, y = 60.6, mapID = 2339, faction = "neutral" },
        { zone = "Dornogal - The Forgegrounds", id = 252910, model3D = 137662, title = "Garnett", x = 54.68, y = 57.24, mapID = 2339, faction = "neutral" },
		{ zone = "Dornogal", id = 252312, model3D = 137392, title = "Second Chair Pawdo", x = 52.84, y = 68.0, mapID = 2339, faction = "neutral" },
		{ zone = "Dornogal", id = 219217, model3D = 120603, title = "Velerd", x = 55.2, y = 76.4, mapID = 2339, faction = "neutral" },
        { zone = "Freywold Village", id = 252901, model3D = 137660, title = "Cinnabar", x = 42.0, y = 73.0, mapID = 2248, faction = "neutral" },
        { zone = "Isle of Dorn", id = 226205, model3D = 120579, title = "Cendvin", x = 74.4, y = 45.2, mapID = 2248, faction = "neutral" },
    }
  },
  {
    name = "The Ringing Deeps",
	expansion = "The War Within",
      vendors = {
        { zone = "Gundargaz", id = 221390, model3D = 118619, title = "Waxmonger Squick", x = 43.2, y = 32.8, mapID = 2214, faction = "neutral" },
        { zone = "Gundargaz", id = 252887, model3D = 137648, title = "Chert", x = 43.4, y = 33.0, mapID = 2214, faction = "neutral" },
		{ zone = "Gundargaz", id = 256783, model3D = 139804, title = "Gabbun", faction = "neutral", mapID = 2214, x = 43.32, y = 33.03 },
    }
  },
  {
    name = "Hallowfall",
	expansion = "The War Within",
      vendors = {
        { zone = "Mereldar", id = 217642, model3D = 118635, title = "Nalina Ironsong", x = 42.8, y = 55.83, mapID = 2215, faction = "neutral" },
        { zone = "Hallowfall", id = 240852, model3D = 128126, title = "Lars Bronsmaelt", x = 28.28, y = 56.18, mapID = 2215, faction = "neutral" },
    }
  },
  {
    name = "Undermine",
	expansion = "The War Within",
      vendors = {
        { zone = "The Incontinental Hotel", id = 251911, model3D = 137264, title = "Stacks Topskimmer", x = 43.19, y = 50.47, mapID = 2346, faction = "neutral" },
		{ zone = "The Incontinental Hotel", id = 231409, model3D = 126125, title = "Smaks Topskimmer", x = 43.8, y = 50.8, mapID = 2346, faction = "neutral" },
        { zone = "The Scrapshop", id = 231406, model3D = 126189, title = "Rocco Razzboom", x = 39.16, y = 22.2, mapID = 2346, faction = "neutral" },
        { zone = "Port Authority", id = 231405, model3D = 126190, title = "Boatswain Hardee", x = 63.43, y = 16.8, mapID = 2346, faction = "neutral" },
        { zone = "The Vatworks", id = 231408, model3D = 126191, title = "Lab Assistant Laszly", x = 27.18, y = 72.54, mapID = 2346, faction = "neutral" },
        { zone = "Venture Plaza", id = 231407, model3D = 125885, title = "Shredz the Scrapper", x = 53.34, y = 72.69, mapID = 2346, faction = "neutral" },
        { zone = "Hovel Hill", id = 231396, model3D = 125504, title = "Sitch Lowdown", x = 30.78, y = 38.93, mapID = 2346, faction = "neutral" },
        { zone = "Undermine", id = 226994, model3D = 127681, title = "Blair Bass", x = 34.0, y = 70.8, mapID = 2346, faction = "neutral" },
		{ zone = "Undermine", id = 239333, model3D = 127373, title = "Street Food Vendor", x = 26.2, y = 42.8, mapID = 2346, faction = "neutral" },      
		{ zone = "Liberation of Undermine", id = 235621, model3D = 127136, title = "Ando the Gat", x = 43.29, y = 51.89, mapID = 2406, faction = "neutral" },
    }
  },
  {
    name = "K'aresh",
	expansion = "The War Within",
      vendors = {
        { zone = "Tazavesh, the Veiled Market", faction = "neutral", id = 235314, model3D = 130299, title = "Ta'sam", x = 43.2, y = 34.8, mapID = 2472 },
		{ zone = "Tazavesh, the Veiled Market", faction = "neutral", id = 235252, model3D = 124755, title = "Om'sirik", x = 40.33, y = 29.36, mapID = 2472 },
    }
  },
  {
    name = "Azj-Kahet",
	expansion = "The War Within",
      vendors = {
		{ zone = "City of Threads",  faction = "neutral", id = 218202, model3D = 114528, title = "Thripps", x = 50.0, y = 31.6, mapID = 2213 },
    }
  },
  {
    name = "Twlight Highlands",
	expansion = "Twilight Ascencision",
      vendors = {
        { zone = "Near Crushblow", faction = "neutral", id = 249196, model3D = 136463, title = "Materialist Ophinell", x = 49.6, y = 81.2, mapID = 241 },
    }
  },
  {
    name = "Founders Point",
	expansion = "The Neighborhoods",
      vendors = {		
	    { zone = "Founders Point", id = 255228, model3D = 138698, title = "\"Len\" Splinthoof", x = 62.4, y = 80.0, mapID = 2352 , faction = "alliance" },
        { zone = "Founders Point", id = 255222, model3D = 138691, title = "\"High Tides\" Ren", x = 62.4, y = 80.2, mapID = 2352 , faction = "alliance" },
        { zone = "Founders Point", id = 255230, model3D = 138699, title = "\"Yen\" Malone", x = 62.23, y = 80.3, mapID = 2352 , faction = "alliance" },
        { zone = "Founders Point", id = 255203, model3D = 138684, title = "Xiao Dan", x = 51.95, y = 38.31, mapID = 2352 , faction = "alliance" },
        { zone = "Founders Point", id = 255221, model3D = 138690, title = "Trevor Grenner", x = 53.47, y = 40.93, mapID = 2352 , faction = "alliance" },
        { zone = "Founders Point", id = 256750, model3D = 139782, title = "Klasa", x = 58.3, y = 61.68, mapID = 2352, faction = "alliance" },
        { zone = "Founders Point", id = 255213, model3D = 138687, title = "Faarden the Builder", x = 52.0, y = 38.4, mapID = 2352 , faction = "alliance"},
        { zone = "Founders Point", id = 255216, model3D = 138688, title = "Balen Starfinder", x = 52.2, y = 38.0, mapID = 2352 , faction = "alliance" },
        { zone = "Founders Point", id = 255218, model3D = 138689, title = "Argan Hammerfist", x = 52.2, y = 37.8, mapID = 2352 , faction = "alliance" },
    }
  },
  {
    name = "Razorwind Shores",
	expansion = "The Neighborhoods",
      vendors = {
        { zone = "Razorwind Shores", id = 255325, model3D = 138691, title = "\"High Tides\" Ren", faction = "horde", mapID = 2351, x = 039.90, y = 72.78 },
		{ zone = "Razorwind Shores", id = 255319, model3D = 138699, title = "\"Yen\" Malone", x = 40.3, y = 73.0, mapID = 2351 , faction = "horde"  },
        { zone = "Razorwind Shores", id = 255326, model3D = 138698, title = "\"Len\" Splinthoof", x = 39.91, y = 73.3, mapID = 2351 , faction = "horde"  },
        { zone = "Razorwind Shores", id = 255297, model3D = 138751, title = "Shon'ja", x = 54.13, y = 59.05, mapID = 2351 , faction = "horde"  },
        { zone = "Razorwind Shores", id = 240465, model3D = 127583, title = "Lonomia", x = 68.29, y = 75.5, mapID = 2351 , faction = "horde"  },
        { zone = "Razorwind Shores", id = 255301, model3D = 138755, title = "Botanist Boh'an", x = 53,60, y = 57.54, mapID = 2351 , faction = "horde"  },
        { zone = "Razorwind Shores", id = 255278, model3D = 138741, title = "Gronthul", x = 54.12, y = 59.11, mapID = 2351 , faction = "horde"  },
        { zone = "Razorwind Shores", id = 255298, model3D = 138752, title = "Jehzar Starfall", x = 53.56, y = 58.49, mapID = 2351 , faction = "horde"  },
        { zone = "Razorwind Shores", id = 255299, model3D = 138753, title = "Lefton Farrer", x = 53.48, y = 58.53, mapID = 2351 , faction = "horde"  },
    }
  },
  {
    name = "Housing Endeavor Vendors(community events)",
	expansion = "The Neighborhoods",
      vendors = {
	    { zone = "Depends on Neighborhood", id = 252916, model3D = 137667, title = "Hesta Forlath",  faction = "neutral" },
        { zone = "Depends on Neighborhood", id = 257897, model3D = 106374, title = "Harlowe Marl", faction = "neutral" },       
		{ zone = "Depends on Neighborhood", id = 252605, model3D = 140447, title = "Aeeshna", faction = "neutral" }, 
        { zone = "Depends on Neighborhood", id = 249684, model3D = 40842, title = "Brother Dovetail", faction = "neutral" }, 
        { zone = "Depends on Neighborhood", id = 250820, model3D = 136498, title = "Hordranin", faction = "neutral" }, 
        { zone = "Depends on Neighborhood", id = 248525, model3D = 92584, title = "Pascal-K1N6", faction = "neutral" }, 
        { zone = "Depends on Neighborhood", id = 253596, model3D = 136070, title = "The Last Architect", faction = "neutral" }, 
    }
  },
   {
    name = "Silvermoon City",
	expansion = "Midnight Launch",
      vendors = {
		{ zone = "The Bazaar", id = 252915, model3D = 137524, title = "Corlen Hordralin", faction = "neutral", mapID = 2393, x = 44.16, y = 62.72 },
        { zone = "The Bazaar", id = 252916, model3D = 137667, title = "Hesta Forlath", faction = "neutral", mapID = 2393, x = 44.16, y = 62.72 },
        { zone = "The Bazaar", id = 242398, model3D = 105169, title = "Naleidea Rivergleam", faction = "neutral", mapID = 2393, x = 52.67, y = 77.96 },
        { zone = "Murder Row", id = 256828, model3D = 139843, title = "Dennia Silvertongue", faction = "neutral", mapID = 2393, x = 51.16, y = 56.47 },
        { zone = "Astalor's Sanctum", id = 258181, model3D = 140647, title = "Construct Ali'a", faction = "neutral", mapID = 2393, x = 55.81, y = 66.04 },
        { zone = "The Bazaar", id = 242399, model3D = 107574, title = "Telemancer Astrandis", faction = "neutral", mapID = 2393, x = 52.44, y = 78.87 },
    }
  },
  {
    name = "Harandar",
	expansion = "Midnight Launch",
      vendors = {
        { zone = "The Den", id = 255114, model3D = 138651, title = "Maku", faction = "neutral", mapID = 2413, x = 53.12, y = 50.93 },
        { zone = "The Den", id = 240407, model3D = 137949, title = "Naynar", faction = "neutral", mapID = 2413, x = 50.95, y = 50.74 },
		{ zone = "The Den", id = 258540, model3D = 140815, title = "Hawli", faction = "neutral", mapID = 2413, x = 52.60, y = 50.60 },
    }
  },
  {
    name = "Arcantina",
	expansion = "Midnight Launch",
      vendors = {
        { zone = "Arcantina", id = 252873, model3D = 130151, title = "Morta Gage", faction = "neutral", mapID = 2541, x = 42.00, y = 50.00 },
    }
  },
  {
    name = "Voidstorm",
	expansion = "Midnight Launch",
      vendors = {
        { zone = "Masters Perch", id = 258328, model3D = 140891, title = "Thraxadar", faction = "neutral", mapID = 2444, x = 39.40, y = 81.0 },
		{ zone = "The Howling Ridge", id = 259922, model3D = 142075, title = "Void Researcher Aemely", faction = "neutral", mapID = 2405, x = 52.6, y = 72.8 },
		{ zone = "The Howling Ridge", id = 248328, model3D = 139916, title = "Void Researcher Anomander", faction = "neutral", mapID = 2405, x = 52.6, y = 72.9 },
    }
  },
  {
    name = "Eversong Woods",
	expansion = "Midnight Launch",
      vendors = {
		{ zone = "Eversong Woods", id = 242726, model3D = 137811, title = "Neriv", faction = "neutral", mapID = 2395, x = 43.49, y = 47.64 },
        { zone = "Eversong Woods", id = 242724, model3D = 137806, title = "Ranger Allorn", faction = "neutral", mapID = 2395, x = 43.46, y = 47.55 },
        { zone = "Eversong Woods", id = 242725, model3D = 137809, title = "Armorer Goldcrest", faction = "neutral", mapID = 2395, x = 43.53, y = 47.5 },
        { zone = "Eversong Woods", id = 240838, model3D = 137812, title = "Caeris Fairdawn", faction = "neutral", mapID = 2395, x = 43.47, y = 47.44 },
        { zone = "Eversong Woods", id = 242723, model3D = 137808, title = "Apprentice Diell", faction = "neutral", mapID = 2395, x = 43.53, y = 47.5 },
		{ zone = "Eversong Woods", id = 259864, model3D = 141933, title = "Sathren Azuredawn", faction = "neutral", mapID = 2395, x = 43.2, y = 47.5 },
    }
  }, 
  {
    name = "Zul'Aman",
	expansion = "Midnight Launch",
      vendors = {
		{ zone = "Amani'Zar Village", id = 240279, model3D = 141039, title = "Magovu", faction = "neutral", mapID = 2437, x = 46.0, y = 65.9 },
		{ zone = "Amani'Zar Village", id = 254944, model3D = 141092, title = "Tajaka Sawtusk", faction = "neutral", mapID = 2437, x = 46.0, y = 66.1 },
		{ zone = "Zul'Aman", id = 241928, model3D = 140057, title = "Chel the Chip", faction = "neutral", mapID = 2437, x = 31.6, y = 26.3 },
    }
  } 
}
