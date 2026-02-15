
local ADDON_NAME = "HandyNotes_DecorVendors"
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local HNDecor = HandyNotes:NewModule(ADDON_NAME, "AceEvent-3.0")
local db


local ICONS = {
    dot_red    = "Interface\\Common\\Indicator-Red",
    dot_yellow = "Interface\\Common\\Indicator-Yellow",
    dot_green  = "Interface\\Common\\Indicator-Green",
    bag_brown  = "Interface\\Icons\\INV_Misc_Bag_08",
    bag_green  = "Interface\\Icons\\INV_Misc_Bag_10",
    bag_red    = "Interface\\Icons\\INV_Misc_Bag_Linen_01",
    bag_blue   = "Interface\\Icons\\INV_Misc_Bag_12",
    bag_round  = "Interface\\Icons\\INV_Misc_CoinBag_01",
    custom     = "Interface\\AddOns\\HandyNotes_DecorVendors\\myBag.tga"
}

local rawData = {
{
    name = "Brawl'gar Arena",
	expansion = "Classic",
    vendors = {
      { zone = "Brawl'gar Arena", id = 68364, title = "Paul North", x = 52.0, y = 27.8, mapID = 503 , faction = "horde" },
    }
  },
  {
    name = "Hillsbrad Foothill",
	expansion = "Classic",
    vendors = {
      { zone = "Pvp Vendor", id = 13217, title = "Thanthaldis Snowgleam", x = 44.8, y = 46.4, mapID = 25 , faction = "neutral" },
    }
  },
  {
    name = "Blasted Lands",
	expansion = "Classic",
      vendors = {
      { zone = "Surwich",  id = 44337, title = "Maurice Essman", x = 45.8, y = 88.6, mapID = 17 , faction = "alliance"  },
    }
  },
  {
    name = "Burning Steppes",
	expansion = "Classic",
      vendors = {
      { zone = "Chiselgrip", faction = "neutral" , id = 115805, title = "Hoddruc Bladebender", x = 46.8, y = 44.6, mapID = 36 },
    }
  },
  {
    name = "Darnassus",
	expansion = "Classic",
      vendors = {
      { zone = "PRE-DESTRUCTION", id = 50307, title = "Lord Candren", x = 37.2, y = 47.6, mapID = 89 , faction = "alliance" },
    }
  },
  {
    name = "Bizmo's Brawlpub",
	expansion = "Classic",
      vendors = {
      { zone = "Bizmo's Brawlpub", id = 68363, title = "Quackenbush", x = 51.0, y = 30.0, mapID = 499 , faction = "alliance"  },
    }
  },
  {
    name = "Dun Morogh",
	expansion = "Classic",
      vendors = {
      { zone = "Kharanos", id = 1247, title = "Innkeeper Belm", x = 54.4, y = 50.8, mapID = 27 , faction = "alliance"  },
    }
  },
  {
    name = "Duskwood",
	expansion = "Classic",
      vendors = {
      { zone = "Raven Hill", id = 44114, title = "Wilkinson", x = 20.27, y = 58.35, mapID = 47 , faction = "alliance" },
    }
  },
  {
    name = "Dustwallow Marsh",
	expansion = "Classic",
      vendors = {
      { zone = "Mudsprocket", faction = "neutral" , id = 23995, title = "Axle", x = 41.9, y = 73.9, mapID = 70  },
    }
  },
  {
    name = "Eastern PlagueLands",
	expansion = "Classic",
      vendors = {
        { zone = "Lights Hope Chapel", id = 45417, title = "Fiona", x = 73.8, y = 52.2, mapID = 23, faction = "neutral" },
    }
  },
  {
    name = "Loch Modan",
	expansion = "Classic",
      vendors = {
      { zone = "Thelsamar", id = 1465, title = "Drac Roughcut", x = 35.6, y = 49.0, mapID = 48 , faction = "alliance" },
    }
  },
  {
    name = "Orgrimmar",
	expansion = "Classic",
      vendors = {
      { zone = "Hall of Legends", faction = "horde" , id = 254606, title = "Joruh", x = 38.8, y = 71.93, mapID = 85 },
      { zone = "Orgrimmar", id = 50488, title = "Stone Guard Nargol", x = 50.2, y = 58.4, mapID = 85 , faction = "horde" },
      { zone = "The Drag", faction = "horde" , id = 256119, title = "Lonalo", x = 58.4, y = 50.6, mapID = 85 },
    }
  },
  {
    name = "Searing Gorge",
	expansion = "Classic",
      vendors = {
      { zone = "Thorium Point", id = 14624, title = "Master Smith Burninate", x = 38.6, y = 28.7, mapID = 32, faction = "neutral" },
	  { zone = "Dark Iron Dwarf Only", id = 144129, title = "Plugger Spazzring", x = 49.77, y = 32.22, mapID = 1186 , faction = "alliance" },
    }
  },
  {
    name = "Silverpine Forest",
	expansion = "Classic",
      vendors = {
      { zone = "The Sepulcher", id = 2140, title = "Edwin Harly", x = 44.06, y = 39.68, mapID = 21 , faction = "horde" },
    }
  },
  {
    name = "Gilneas",
	expansion = "Classic",
      vendors = {
      { zone = "Stormglen Village", id = 211065, title = "Marie Allen", x = 60.4, y = 92.4, mapID = 217 , faction = "alliance"  },
      { zone = "Stormglen Village", id = 216888, title = "Samantha Buckley", x = 65.39, y = 47.20, mapID = 218, mapIDWaypoint = 217 , faction = "alliance"  },
    }
  },
  {
    name = "Stormwind",
	expansion = "Classic",
      vendors = {
      { zone = "Stormwind", id = 49877, title = "Captain Lancy Revshon", x = 67.79, y = 73.05, mapID = 84 , faction = "alliance" },
      { zone = "Mage Quarter", faction = "alliance" ,id = 256071, title = "Solelo", x = 49.0, y = 80.0, mapID = 84 },
      { zone = "Old Town", id = 254603, title = "Riica", x = 77.8, y = 65.8, mapID = 84 , faction = "alliance" },
    }
  },
  {
    name = "Stranglethorn Vale",
	expansion = "Classic",
      vendors = {
      { zone = "Nesingwary Expedition", title = "Jacquilina Dramet", faction = "neutral" , id = 2483, x = 43.8, y = 23.2, mapID = 50 },
    }
  },
  {
    name = "Thunder Bluff",
	expansion = "Classic",
      vendors = {
      { zone = "Thunder Bluff", id = 50483, title = "Brave Tuho", x = 46.2, y = 50.6, mapID = 88 , faction = "horde" },
    }
  },
  {
    name = "Undercity",
	expansion = "Classic",
      vendors = {
      { zone = "PRE-DESTRUCTION", id = 50304, title = "Captain Donald Adams", x = 63.2, y = 49.0, mapID = 90 , faction = "horde"  },
    }
  },
  {
    name = "Wetlands",
	expansion = "Classic",
      vendors = {
      { zone = "Menethil Harbor", id = 3178, title = "Stuart Fleming", x = 6.27, y = 57.45, mapID = 56 , faction = "alliance" },
    }
  },
  {
    name = "Ironforge",
	expansion = "Classic",
      vendors = {
      { zone = "The Commons", id = 253235, title = "Dedric Sleetshaper", x = 24.72, y = 43.93, mapID = 87, faction = "alliance" },
      { zone = "Ironforge", id = 50309, title = "Captain Stonehelm", x = 55.6, y = 48.2, mapID = 87 , faction = "alliance"  },
      { zone = "The Library", faction = "alliance" ,  id = 253232, title = "Inge Brightview", x = 75.8, y = 9.4, mapID = 87 },
    }
  }, 
  {
    name = "Ghostlands",
	expansion = "Burning Crusade",
      vendors = {
      { zone = "Tranquillien - Pre Midnight", id = 16528, title = "Provisioner Vredigar", x = 47.6, y = 32.4, mapID = 95 , faction = "horde" },
    }
  },
  {
    name = "Scholazar Basin",
	expansion = "Wrath of the Lich King",
      vendors = {
      { zone = "Nesingwary Base Camp", id = 28038, title = "Purser Boulian", x = 26.8, y = 59.2, mapID = 119, faction = "neutral" },
    }
  },
  {
    name = "Grizzly Hills",
	expansion = "Wrath of the Lich King",
      vendors = {
      { zone = "Amberpine Lodge", id = 27391, title = "Woodsman Drake", x = 32.4, y = 59.8, mapID = 116, faction = "alliance" },
    }
  },
  {
    name = "Twilight Highlands",
	expansion = "Cataclysm",
      vendors = {
      { zone = "Thundermar", id = 253227, title = "Breana Bitterbrand", x = 49.6, y = 29.6, mapID = 241, faction = "alliance" },
      { zone = "Thundermar", id = 49386, title = "Craw MacGraw", x = 48.6, y = 30.6, mapID = 241, faction = "alliance" },             
    }
  },
  {
    name = "Jade Forest",
	expansion = "Mists of Pandaria",
      vendors = {
        { zone = "Arboretum", faction = "neutral", id = 58414, title = "San Redscale", x = 56.8, y = 44.4, mapID = 371 },
    }
  },
  {
    name = "Kun-Lai Summit",
	expansion = "Mists of Pandaria",
      vendors = {
        { zone = "One Keg", faction = "neutral", id = 59698, title = "Brother Furtrim", x = 57.24, y = 60.96, mapID = 379 },
    }
  },
  {
    name = "Valley of the Four Winds",
	expansion = "Mists of Pandaria",
      vendors = {
        { zone = "Halfhill", faction = "neutral", id = 58706, title = "Gina Mudclaw", x = 53.2, y = 51.8, mapID = 376 },
    }
  },
  {
    name = "Vale of Eternal Blossoms - Shrine of 2 Moons",
	expansion = "Mists of Pandaria",
      vendors = {
        { zone = "Shrine of 2 Moons", faction = "horde", id = 64001, title = "Sage Lotusbloom", x = 62.8, y = 23.2, mapID = 390 },
    }
  },
  {
    name = "Vale of Eternal Blossoms - Shrine of 7 Stars",
	expansion = "Mists of Pandaria",
      vendors = {
        { zone = "Shrine of 7 Stars", id = 64032, title = "Sage Whiteheart", x = 85.2, y = 61.6, mapID = 1530, faction = "alliance" },
    }
  },
  {
    name = "Vale of Eternal Blossoms",
	expansion = "Mists of Pandaria",
      vendors = {
        { zone = "Seat of Knowledge", faction = "neutral", id = 64605, title = "Tan Shin Tiao", x = 82.23, y = 29.33, mapID = 390 },
        { zone = "Seat of Knowledge", faction = "neutral", id = 62088, title = "Lali the Assistant", x = 82.8, y = 30.8, mapID = 390 },
    }
  },
  {
    name = "Frostwall",
	expansion = "Warlords of Draenor",
      vendors = {
        { zone = "Barracks", id = 79812, title = "Moz'def", x = 48.0, y = 66.0, mapID = 525 , faction = "horde"  },
		{ zone = "Horde Garrison", id = 76872, title = "Supplymaster Eri", x = 48.0, y = 66.0, mapID = 525 , faction = "horde" },
		{ zone = "Horde Garrison Tier 3", id = 79774, title = "Sergeant Grimjaw", x = 43.8, y = 47.4, mapID = 590 , faction = "horde" },
		{ zone = "Trading Post Level 2", id = 87015, title = "Kil'rip", x = 48.0, y = 66.0, mapID = 525 , faction = "horde"  },
		{ zone = "Horde Garrison", id = 87312, title = "Vora Strongarm", x = 48.0, y = 66.0, mapID = 525 , faction = "horde"  },
		{ zone = "Random trader in Trading Post", id = 86778, title = "Pyxni Pennypocket", faction = "horde" },		
		{ zone = "Trading Post", id = 86776, title = "Ribchewer", faction = "horde" },}
  },
  {
    name = "Lunarfall",
	expansion = "Warlords of Draenor",
      vendors = {
        { zone = "Alliance Garrison Tier 3", id = 78564, title = "Sergeant Crowler", x = 38.5, y = 31.4, mapID = 582 , faction = "alliance" },
        { zone = "Trading Post Tier 3", id = 85427, title = "Maaria", x = 31.0, y = 15.0, mapID = 539 , faction = "alliance" },
		{ zone = "Alliance Garrison", id = 88220, title = "Peter", x = 31.0, y = 15.0, mapID = 539 , faction = "alliance"  },
    }
  },
  {
    name = "Shadowmoon Valley",
	expansion = "Warlords of Draenor",
      vendors = {
        { zone = "Embaari Village", id = 81133, title = "Artificer Kallaes", x = 46.2, y = 39.3, mapID = 539 , faction = "alliance" },
    }
  },
  {
    name = "Stormshield",
	expansion = "Warlords of Draenor",
      vendors = {
        { zone = "Stormshield", id = 85950, title = "Trader Caerel", x = 41.4, y = 59.8, mapID = 622, faction = "alliance" },
        { zone = "The Town Hall", id = 85932, title = "Vindicator Nuurem", x = 46.4, y = 74.6, mapID = 622, faction = "alliance" },
		 { zone = "The Town Hall", id = 85946, title = "Shadow-Sage Brakoss", faction = "alliance", mapID = 622, x = 46.49, y = 75.03 },
		 { zone = "Warspear Hold", id = 86037, title = "Ravenspeaker Skeega", faction = "horde", mapID = 624, x = 53.30, y = 59.96 },
    }
  },
  {
    name = "Argus",
	expansion = "Legion",
      vendors = {
        { zone = "The Vindicaar", id = 127151, title = "Toraan the Revered", x = 68.22, y = 56.91, mapID = 940, faction = "neutral" },
    }
  },
  {
    name = "Azsuna",
	expansion = "Legion",
      vendors = {
        { zone = "Leyhollow Cave", id = 89939, title = "Berazus", x = 47.8, y = 23.6, mapID = 630, faction = "neutral" },
    }
  },
  {
    name = "Dalaran",
	expansion = "Legion",
      vendors = {
        { zone = "Photonic Playground", id = 112716, title = "Rasil Fireborne", x = 43.4, y = 49.4, mapID = 627, faction = "neutral" },		
		{ zone = "Sunreaver Sanctuary - Filthy Animal", id = 252043, title = "Halenthos Brightstride", x = 67.46, y = 33.89, mapID = 627, faction = "horde" },
		{ zone = "The Underbelly", id = 105333, title = "Val'zuun", x = 67.36, y = 63.22, mapID = 628, faction ="neutral"   },
    }
  },
  {
    name = "Highmountain",
	expansion = "Legion",
      vendors = {
		{ zone = "Thunder Totem", id = 106902, title = "Ransa Greyfeather", x = 38.06, y = 46.05, mapID = 750, faction = "neutral" },
        { zone = "Thunder Totem - Bottom Half", id = 108017, title = "Torv Dubstomp", faction = "neutral", mapID = 652, x = 54.80, y = 78.08 },
	    { zone = "Shipwreck Cove", id = 108537, title = "Crafty Palu", x = 41.62, y = 10.44, mapID = 650, faction = "neutral"   },
    }
  },
  {
    name = "Suramar",
	expansion = "Legion",
      vendors = {
        { zone = "Shal'Aran", id = 115736, title = "First Arcanist Thalyssra", x = 36.49, y = 45.83, mapID = 680, faction = "neutral" },
        { zone = "The Grand Promenade", id = 93971, title = "Leyweaver Inondra", x = 40.32, y = 69.73, mapID = 680, faction = "neutral"  },
		{ zone = "Concourse of Destiny", id = 252969, title = "Jocenna", x = 49.63, y = 62.83, mapID = 680, faction = "neutral" },
		{ zone = "Shimmershade Garden", id = 255101, title = "Mynde", x = 45.58, y = 69.15, mapID = 680, faction = "neutral" },
		{ zone = "Irongrove Retreat", id = 253434, title = "Sileas Duskvine", x = 79.92, y = 73.89, mapID = 641, faction = "neutral" },
        { zone = "suramar", id = 248594, title = "Sundries Merchant", x = 50.9, y = 77.78, mapID = 680, faction = "neutral" },
    }
  },
  {
    name = "Val'sharah",
	expansion = "Legion",
      vendors = {
        { zone = "Lorlathil", id = 253387, title = "Selfira Ambergrove", x = 54.26, y = 72.36, mapID = 641, faction = "neutral" },
        { zone = "Lorlathil", id = 106901, title = "Sylvia Hartshorn", x = 54.7, y = 73.25, mapID = 641, faction = "neutral" },
        { zone = "Bradenbrook", id = 252498, title = "Corbin Branbell", x = 42.09, y = 59.38, mapID = 641, faction = "neutral" },
        { zone = "Field of Dreamers (patrols)", id = 112634, title = "Hilseth Travelstride", x = 57.14, y = 71.91, mapID = 641, faction = "neutral" },
        { zone = "Lightsong", id = 109306, title = "Myria Glenbrook", x = 60.2, y = 84.86, mapID = 641, faction = "neutral" },
		{ zone = "Val'sharah", id = 256826, title = "Mrgrgrl", x = 68.72, y = 95.1, mapID = 641, faction = "neutral" },
    }
  },
  {
    name = "Class Halls",
	expansion = "Legion",
      vendors = {
      { zone = "Demon Hunter", id = 112407, title = "Falara Nightsong", x = 61.0, y = 56.73, mapID = 720, faction = "neutral" },
      { zone = "Paladin", id = 100196, title = "Eadric the Pure", x = 75.64, y = 49.09, mapID = 23, faction = "neutral" },
      { zone = "Hunter", id = 103693, title = "Outfitter Reynolds", x = 44.56, y = 48.88, mapID = 739, faction = "neutral" },
      { zone = "Druid", id = 112323, title = "Amurra Thistledew", x = 40.02, y = 17.72, mapID = 747, faction = "neutral" },
      { zone = "Rogue", id = 105986, title = "Kelsey Steelspark", x = 26.92, y = 36.83, mapID = 626, faction = "neutral" },
      { zone = "Monk", id = 112338, title = "Caydori Brightstar", x = 50.4, y = 59.0, mapID = 709, faction = "neutral" },
      { zone = "Death Knight", id = 93550, title =  "Quartermaster Ozorg", x = 43.9, y = 37.17, mapID = 647, faction = "neutral" },
      { zone = "Warlock", id = 112434, title = "Gigi Gigavoid", x = 58.76, y = 32.69, mapID = 717 , faction = "neutral" },
      { zone = "Mage", id = 112440, title = "Jackson Watkins", x = 44.75, y = 57.87, mapID = 735 , faction = "neutral" },
      { zone = "Shaman", id = 112318, title = "Flamesmith Lanying", x = 30.32, y = 60.69, mapID = 726, faction = "neutral" },
      { zone = "Warrior", id = 112392, title = "Quartermaster Durnolf", x = 55.49, y = 25.91, mapID = 695, faction = "neutral" },
      { zone = "Priest", id = 112401, title = "Meridelle Lightspark", x = 38.62, y = 23.77, mapID = 702, faction = "neutral" },
    }
  },
  {
    name = "Covenants",
	expansion = "Shadowlands",
      vendors = {
        { zone = "Revendreth - Sinfall - Venthyr Only", id = 174710, title = "Chachi the Artiste", x = 54.0, y = 24.8, mapID = 1699, faction = "neutral" },
    }
  },
  {
    name = "The Maw",
	expansion = "Shadowlands",
      vendors = {
        { zone = "Ve'nari's Refuge", id = 162804, title = "Ve'nari", x = 46.8, y = 41.6, mapID = 1543, faction = "neutral" },
    }
  },
  {
    name = "Silithus",
	expansion = "Battle for Azeroth",
      vendors = {
      { zone = "Chamber of Heart", id = 152194, title = "MOTHER", x = 48.3, y = 72.1, mapID = 1473, faction = "neutral" },
    }
  },
  {
    name = "Stormsong Valley",
	expansion = "Battle for Azeroth",
      vendors = {
      { zone = "Brennadom", id = 252313, title = "Caspian", x = 59.6, y = 69.6, mapID = 942 , faction = "alliance" },
    }
  },
  {
    name = "Mechagon",
	expansion = "Battle for Azeroth",
      vendors = {     
	  { zone = "Mechagon", id = 150716, title = "Stolen Royal Vendorbot", x = 73.7, y = 36.91, mapID = 1462, faction = "neutral" },
    }
  },
  {
    name = "Tiragarde Sound",
	expansion = "Battle for Azeroth",
      vendors = {
      { zone = "Harbormaster's Office", id = 135808, title = "Provisioner Fray", x = 67.6, y = 21.8, mapID = 1161 , faction = "alliance" },
      { zone = "Tradewinds Market", id = 252345, title = "Pearl Barlow", x = 70.74, y = 15.66, mapID = 1161, faction = "alliance" },
      { zone = "Boralus Harbor", id = 142115, title = "Fiona", x = 67.6, y = 40.8, mapID = 1161, faction = "alliance" },
	  { zone = "Hook Point", id = 246721, title = "Janey Forrest", x = 56.29, y = 45.82, mapID = 1161, faction = "alliance" },
	  { zone = "Norwington Estate", id = 252316, title = "Delphine", x = 53.4, y = 31.2, mapID = 895, faction = "neutral" },
    }
  },
  {
    name = "Nazmir",
	expansion = "Battle for Azeroth",
      vendors = {
      { zone = "Zu'jan Ruins", id = 135459, title = "Provisioner Lija", x = 39.11, y = 79.47, mapID = 863 , faction = "horde" },
    }
  },
  {
    name = "Zuldazar",
	expansion = "Battle for Azeroth",
      vendors = {
      { zone = "Port of Zandalar", id = 148924, title = "Provisioner Mukra", x = 51.22, y = 95.08, mapID = 1165 , faction = "horde" },
      { zone = "Port of Zandalar", id = 148923, title = "Captain Zen'taga", x = 44.6, y = 94.4, mapID = 1165 , faction = "horde" },
      { zone = "Zuldazar Docks", id = 251921, title = "Arcanist Peroleth", x = 58.0, y = 62.6, mapID = 862 , faction = "horde" },
      { zone = "Zuldazar - The Great Seal", id = 252326, title = "T'lama", x = 36.94, y = 59.17, mapID = 1164 , faction = "horde" },
    }
  },
  {
    name = "The Forbidden Reach",
	expansion = "Dragonflight",
      vendors = {
		{ zone = "Morqut Village", id = 253086, title = "Jolinth", x = 35.2, y = 57.0, mapID = 2151, faction = "neutral" },
    }
  },
  {
    name = "Thaldraszus - Valdrakken",
	expansion = "Dragonflight",
      vendors = {
        { zone = "The Seat of Aspects - Lower", id = 193015, title = "Unatos", x = 58.2, y = 35.6, mapID = 2112, faction = "neutral" },
        { zone = "The Parting Glass", id = 253067, title = "Silvrath", x = 71.53, y = 49.62, mapID = 2112, faction = "neutral" },
		{ zone = "Valdrakken Treasury Hoard", id = 199605, title = "Evantkis", x = 58.4, y = 57.4, mapID = 2112, faction = "neutral" },
		{ zone = "The Obsidian Enclave", id = 193659, title = "Provisioner Thom", x = 36.8, y = 50.6, mapID = 2112, faction = "neutral" },
		{ zone = "Valdrakken - evoker only maybe", id = 196637, title = "Tethalash", x = 25.52, y = 33.65, mapID = 2112, faction = "neutral" },
		{ zone = "Azerothian Archives", id = 209192, title = "Provisioner Aristta", x = 61.4, y = 31.4, mapID = 2025, faction = "neutral" },
		{ zone = "Eon's Fringe", id = 209220, title = "Ironus Coldsteel", x = 52.2, y = 80.8, mapID = 2025, faction = "neutral" },
    }
  },
  {
    name = "The Waking Shores",
	expansion = "Dragonflight",
      vendors = {
		{ zone = "Dragonscale Basecamp", id = 189226, title = "Cataloger Jakes", x = 47.0, y = 82.6, mapID = 2022, faction = "neutral" },
		{ zone = "Dragonscale Basecamp", id = 188265, title = "Rae'ana", x = 47.8, y = 82.2, mapID = 2022, faction = "neutral" },
		{ zone = "Ruby Lifeshrine", id = 191025, title = "Lifecaller Tzadrak", x = 62.0, y = 73.8, mapID = 2022, faction = "neutral" },
    }
  },
  {
    name = "Dragonflight Dreamsurge",
	expansion = "Dragonflight",
       vendors = {     
         { zone = "Dreamsurge Location",  id = 210608, title = "Celestine of the Harvest", faction = "neutral" },
    }
  },
  {
    name = "Amirdrassil",
	expansion = "Dragonflight",
      vendors = {
		{ zone = "Bel'ameth", id = 216286, title = "Moon Priestess Lasara", x = 46.6, y = 70.6, mapID = 2239 , faction = "alliance" },
        { zone = "Bel'ameth", id = 216284, title = "Mythrin'dir", x = 54.0, y = 60.8, mapID = 2239 , faction = "alliance" },
        { zone = "Bel'ameth", id = 216285, title = "Ellandrieth", x = 48.4, y = 53.6, mapID = 2239 , faction = "alliance" },
    }
  },
  {
    name = "Isle of Dorn",
	expansion = "The War Within",
      vendors = {
        { zone = "Dornogal - Foundation Hall", id = 223728, title = "Auditor Balwurz", x = 39.2, y = 24.4, mapID = 2339, faction = "neutral" },
        { zone = "Dornogal - The Forgegrounds", id = 219318, title = "Jorid", x = 57.0, y = 60.6, mapID = 2339, faction = "neutral" },
        { zone = "Dornogal - The Forgegrounds", id = 252910, title = "Garnett", x = 54.68, y = 57.24, mapID = 2339, faction = "neutral" },
		{ zone = "Dornogal", id = 252312, title = "Second Chair Pawdo", x = 52.84, y = 68.0, mapID = 2339, faction = "neutral" },
		{ zone = "Dornogal", id = 219217, title = "Velerd", x = 55.2, y = 76.4, mapID = 2339, faction = "neutral" },
        { zone = "Freywold Village", id = 252901, title = "Cinnabar", x = 42.0, y = 73.0, mapID = 2248, faction = "neutral" },
        { zone = "Isle of Dorn", id = 226205, title = "Cendvin", x = 74.4, y = 45.2, mapID = 2248, faction = "neutral" },
    }
  },
  {
    name = "The Ringing Deeps",
	expansion = "The War Within",
      vendors = {
        { zone = "Gundargaz", id = 221390, title = "Waxmonger Squick", x = 43.2, y = 32.8, mapID = 2214, faction = "neutral" },
        { zone = "Gundargaz", id = 252887, title = "Chert", x = 43.4, y = 33.0, mapID = 2214, faction = "neutral" },
		{ zone = "Gundargaz", id = 256783, title = "Gabbun", faction = "neutral", mapID = 2214, x = 43.32, y = 33.03 },
    }
  },
  {
    name = "Hallowfall",
	expansion = "The War Within",
      vendors = {
        { zone = "Mereldar", id = 217642, title = "Nalina Ironsong", x = 42.8, y = 55.83, mapID = 2215, faction = "neutral" },
        { zone = "Hallowfall", id = 240852, title = "Lars Bronsmaelt", x = 28.28, y = 56.18, mapID = 2215, faction = "neutral" },
    }
  },
  {
    name = "Undermine",
	expansion = "The War Within",
      vendors = {
        { zone = "The Incontinental Hotel", id = 251911, title = "Stacks Topskimmer", x = 43.19, y = 50.47, mapID = 2346, faction = "neutral" },
		{ zone = "The Incontinental Hotel", id = 231409, title = "Smaks Topskimmer", x = 43.8, y = 50.8, mapID = 2346, faction = "neutral" },
        { zone = "The Scrapshop", id = 231406, title = "Rocco Razzboom", x = 39.16, y = 22.2, mapID = 2346, faction = "neutral" },
        { zone = "Port Authority", id = 231405, title = "Boatswain Hardee", x = 63.43, y = 16.8, mapID = 2346, faction = "neutral" },
        { zone = "The Vatworks", id = 231408, title = "Lab Assistant Laszly", x = 27.18, y = 72.54, mapID = 2346, faction = "neutral" },
        { zone = "Venture Plaza", id = 231407, title = "Shredz the Scrapper", x = 53.34, y = 72.69, mapID = 2346, faction = "neutral" },
        { zone = "Hovel Hill", id = 231396, title = "Sitch Lowdown", x = 30.78, y = 38.93, mapID = 2346, faction = "neutral" },
        { zone = "Undermine", id = 226994, title = "Blair Bass", x = 34.0, y = 70.8, mapID = 2346, faction = "neutral" },
		{ zone = "Undermine", id = 239333, title = "Street Food Vendor", x = 26.2, y = 42.8, mapID = 2346, faction = "neutral" },      
		{ zone = "Liberation of Undermine", id = 235621, title = "Ando the Gat", x = 43.29, y = 51.89, mapID = 2406, faction = "neutral" },
    }
  },
  {
    name = "K'aresh",
	expansion = "The War Within",
      vendors = {
        { zone = "Tazavesh, the Veiled Market", faction = "neutral", id = 235314, title = "Ta'sam", x = 43.2, y = 34.8, mapID = 2472 },
		{ zone = "Tazavesh, the Veiled Market", faction = "neutral", id = 235252, title = "Om'sirik", x = 40.33, y = 29.36, mapID = 2472 },
    }
  },
  {
    name = "Azj-Kahet",
	expansion = "The War Within",
      vendors = {
		{ zone = "City of Threads",  faction = "neutral", id = 218202, title = "Thripps", x = 50.0, y = 31.6, mapID = 2213 },
    }
  },
  --[[{
    name = "Silvermoon City",
	expansion = "Midnight",
      vendors = {
		{ zone = "The Bazaar", id = 252915, title = "Corlen Hordralin", faction = "neutral", mapID = 2393, x = 44.16, y = 62.72 },
        { zone = "The Bazaar", id = 252916, title = "Hesta Forlath", faction = "neutral", mapID = 2393, x = 44.16, y = 62.72 },
        { zone = "The Bazaar", id = 242398, title = "Naleidea Rivergleam", faction = "neutral", mapID = 2393, x = 52.67, y = 77.96 },
        { zone = "Murder Row", id = 256828, title = "Dennia Silvertongue", faction = "neutral", mapID = 2393, x = 51.16, y = 56.47 },
        { zone = "Astalor's Sanctum", id = 258181, title = "Construct Ali'a", faction = "neutral", mapID = 2393, x = 55.81, y = 66.04 },
        { zone = "The Bazaar", id = 242399, title = "Telemancer Astrandis", faction = "neutral", mapID = 2393, x = 52.44, y = 78.87 },
    }
  },
  {
    name = "Harandar",
	expansion = "Midnight",
      vendors = {
        { zone = "The Den", id = 255114, title = "Maku", faction = "neutral", mapID = 2413, x = 53.12, y = 50.93 },
        { zone = "The Den", id = 240407, title = "Naynar", faction = "neutral", mapID = 2413, x = 50.95, y = 50.74 },
		{ zone = "The Den", id = 25480, title = "Hawli", faction = "neutral", mapID = 2413, x = 52.60, y = 50.60 },
    }
  },
    {
    name = "Arcantina",
	expansion = "Midnight",
      vendors = {
        { zone = "Arcantina", id = 252873, title = "Morta Gage", faction = "neutral", mapID = 2541, x = 42.00, y = 50.00 },
    }
  },
      {
    name = "Slayers Rise",
	expansion = "Midnight",
      vendors = {
        { zone = "Masters Perch", id = 258328, title = "Thraxadar", faction = "neutral", mapID = 2444, x = 39.40, y = 81.0 },
    }
  },
  {
    name = "Eversong Woods",
	expansion = "Midnight",
      vendors = {
		{ zone = "Eversong Woods", id = 242726, title = "Neriv", faction = "neutral", mapID = 2395, x = 43.49, y = 47.64 },
        { zone = "Eversong Woods", id = 242724, title = "Ranger Allorn", faction = "neutral", mapID = 2395, x = 43.46, y = 47.55 },
        { zone = "Eversong Woods", id = 242725, title = "Armorer Goldcrest", faction = "neutral", mapID = 2395, x = 43.53, y = 47.5 },
        { zone = "Eversong Woods", id = 240838, title = "Caeris Fairdawn", faction = "neutral", mapID = 2395, x = 43.47, y = 47.44 },
        { zone = "Eversong Woods", id = 242723, title = "Apprentice Diell", faction = "neutral", mapID = 2395, x = 43.53, y = 47.5 },
    }
  },]]
  {
    name = "Founders Point",
	expansion = "Midnight",
      vendors = {		
	    { zone = "Founders Point", id = 255228, title = "\"Len\" Splinthoof", x = 62.4, y = 80.0, mapID = 2352 , faction = "alliance" },
        { zone = "Founders Point", id = 255222, title = "\"High Tides\" Ren", x = 62.4, y = 80.2, mapID = 2352 , faction = "alliance" },
        { zone = "Founders Point", id = 255230, title = "\"Yen\" Malone", x = 62.23, y = 80.3, mapID = 2352 , faction = "alliance" },
        { zone = "Founders Point", id = 255203, title = "Xiao Dan", x = 51.95, y = 38.31, mapID = 2352 , faction = "alliance" },
        { zone = "Founders Point", id = 255221, title = "Trevor Grenner", x = 53.47, y = 40.93, mapID = 2352 , faction = "alliance" },
        { zone = "Founders Point", id = 256750, title = "Klasa", x = 58.3, y = 61.68, mapID = 2352, faction = "alliance" },
        { zone = "Founders Point", id = 255213, title = "Faarden the Builder", x = 52.0, y = 38.4, mapID = 2352 , faction = "alliance"},
        { zone = "Founders Point", id = 255216, title = "Balen Starfinder", x = 52.2, y = 38.0, mapID = 2352 , faction = "alliance" },
        { zone = "Founders Point", id = 255218, title = "Argan Hammerfist", x = 52.2, y = 37.8, mapID = 2352 , faction = "alliance" },
    }
  },
  {
    name = "Razorwind Shores",
	expansion = "Midnight",
      vendors = {
        { zone = "Razorwind Shores", id = 255325, title = "\"High Tides\" Ren", faction = "horde", mapID = 2351, x = 039.90, y = 72.78 },
		{ zone = "Razorwind Shores", id = 255319, title = "\"Yen\" Malone", x = 40.3, y = 73.0, mapID = 2351 , faction = "horde"  },
        { zone = "Razorwind Shores", id = 255326, title = "\"Len\" Splinthoof", x = 39.91, y = 73.3, mapID = 2351 , faction = "horde"  },
        { zone = "Razorwind Shores", id = 255297, title = "Shon'ja", x = 54.13, y = 59.05, mapID = 2351 , faction = "horde"  },
        { zone = "Razorwind Shores", id = 240465, title = "Lonomia", x = 68.29, y = 75.5, mapID = 2351 , faction = "horde"  },
        { zone = "Razorwind Shores", id = 255301, title = "Botanist Boh'an", x = 53,60, y = 57.54, mapID = 2351 , faction = "horde"  },
        { zone = "Razorwind Shores", id = 255278, title = "Gronthul", x = 54.12, y = 59.11, mapID = 2351 , faction = "horde"  },
        { zone = "Razorwind Shores", id = 255298, title = "Jehzar Starfall", x = 53.56, y = 58.49, mapID = 2351 , faction = "horde"  },
        { zone = "Razorwind Shores", id = 255299, title = "Lefton Farrer", x = 53.48, y = 58.53, mapID = 2351 , faction = "horde"  },
    }
  },
}
-- ---------------------------------------------------------
-- 2. THE DATA PROCESSING
-- ---------------------------------------------------------
local nodes = {}
local mapDirectory = {}

local function GetContinentID(mapID)
    local mapInfo = C_Map.GetMapInfo(mapID)
    if not mapInfo then return nil end
    if mapInfo.mapType == Enum.UIMapType.Continent then return mapID end
    local parent = mapInfo.parentMapID
    while parent do
        local parentInfo = C_Map.GetMapInfo(parent)
        if not parentInfo then break end
        if parentInfo.mapType == Enum.UIMapType.Continent then return parent end
        parent = parentInfo.parentMapID
    end
    return nil
end

local function ImportData()
    mapDirectory = {}
    nodes = {} 
    
    for _, expansionGroup in ipairs(rawData) do
        if expansionGroup.vendors then
            for _, v in ipairs(expansionGroup.vendors) do
                if v.mapID and v.x and v.y then
                    
                    local isVisited = db.visited_vendors[v.title]
                    
                    if not isVisited then
                        if not nodes[v.mapID] then nodes[v.mapID] = {} end
                        local coord = math.floor(v.x * 100) * 10000 + math.floor(v.y * 100)
                        
                        local factionColor = "|cFFFFFFFF"
                        if v.faction == "alliance" then factionColor = "|cFF0070DE" end
                        if v.faction == "horde" then factionColor = "|cFFFF0000" end

                        nodes[v.mapID][coord] = {
                            label = string.format("%s%s (%s)|r\n|cFF00FF00%s|r", 
                                factionColor, v.title, v.faction or "Neutral", v.zone or "Vendor"),
                            faction = v.faction,
                            name = v.title
                        }

                        local contID = GetContinentID(v.mapID)
                        if contID then
                            if not mapDirectory[contID] then mapDirectory[contID] = {} end
                            mapDirectory[contID][v.mapID] = (mapDirectory[contID][v.mapID] or 0) + 1
                        end
                    end
                end
            end
        end
    end
end


function HNDecor:MERCHANT_SHOW()
    if not db.hide_visited then return end


    local npcName = UnitName("npc")
    
    if npcName then

        if not db.visited_vendors[npcName] then
            db.visited_vendors[npcName] = true
            print("|cFF00FF00[Decor Vendors]|r Marked '"..npcName.."' as visited. Pin hidden.")
            
            ImportData()
            HNDecor:Refresh()
            HNDecor:UpdateDirectory()
        end
    end
end


local DirectoryFrame = CreateFrame("Frame", "HNDecorDirectory", WorldMapFrame, "BackdropTemplate")
DirectoryFrame:SetPoint("TOPLEFT", WorldMapFrame.ScrollContainer, "TOPLEFT", 10, -10)
DirectoryFrame:SetFrameStrata("HIGH")
DirectoryFrame:Hide()

DirectoryFrame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
DirectoryFrame:SetBackdropColor(0, 0, 0, 0.8)
DirectoryFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)

local DirTitle = DirectoryFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
DirTitle:SetPoint("TOPLEFT", 10, -8)
DirTitle:SetText("|cFF00FF00Decor Vendors|r")

local MinimizeBtn = CreateFrame("Button", nil, DirectoryFrame, "UIPanelButtonTemplate")
MinimizeBtn:SetSize(20, 20)
MinimizeBtn:SetPoint("TOPRIGHT", -5, -5)
MinimizeBtn:SetText("-")
MinimizeBtn:SetScript("OnClick", function()
    db.directory_minimized = not db.directory_minimized
    HNDecor:UpdateDirectory()
end)

local buttons = {}
local function GetButton(i)
    if not buttons[i] then
        local btn = CreateFrame("Button", nil, DirectoryFrame)
        btn:SetHeight(14)
        btn:SetNormalFontObject("GameFontHighlightSmall")
        btn:SetHighlightFontObject("GameFontNormalSmall")
        btn:SetPoint("LEFT", 10, 0)
        btn:SetPoint("RIGHT", -10, 0)
        btn:SetScript("OnClick", function(self)
            if self.targetMapID then WorldMapFrame:SetMapID(self.targetMapID) end
        end)
        buttons[i] = btn
    end
    return buttons[i]
end

function HNDecor:UpdateDirectory()
    if not WorldMapFrame:IsShown() then return end
    local mapID = WorldMapFrame.mapID
    if not mapID then return end
    
    for _, btn in pairs(buttons) do btn:Hide() end
    
    local continentData = mapDirectory[mapID]
    local zoneData = nodes[mapID]
    local hasData = (continentData or zoneData) and db.show_vendors

    if hasData then
        DirectoryFrame:Show()
        
        if db.directory_minimized then
            DirectoryFrame:SetSize(140, 30)
            DirTitle:SetText("|cFF00FF00Decor (Hidden)|r")
            MinimizeBtn:SetText("+")
            return
        end

        MinimizeBtn:SetText("-")
        local index = 1
        local maxWidth = 140
        
        if continentData then
            DirTitle:SetText("|cFF00FF00Decor Zones|r")
            local sortedList = {}
            for zoneID, count in pairs(continentData) do
                local info = C_Map.GetMapInfo(zoneID)
                local name = info and info.name or "Unknown"
                table.insert(sortedList, { id = zoneID, name = name, count = count })
            end
            table.sort(sortedList, function(a,b) return a.name < b.name end)
            
            for _, data in ipairs(sortedList) do
                local btn = GetButton(index)
                btn:SetText(string.format("• %s |cFF888888(%d)|r", data.name, data.count))
                if btn:GetFontString() then btn:GetFontString():SetJustifyH("LEFT") end
                btn.targetMapID = data.id
                if index == 1 then btn:SetPoint("TOPLEFT", DirTitle, "BOTTOMLEFT", 0, -4)
                else btn:SetPoint("TOPLEFT", buttons[index-1], "BOTTOMLEFT", 0, -2) end
                local w = btn:GetFontString():GetStringWidth()
                if w > maxWidth then maxWidth = w end
                btn:Show()
                index = index + 1
            end

        elseif zoneData then
            DirTitle:SetText("|cFF00FF00Vendors Here|r")
            local sortedVendors = {}
            for coord, data in pairs(zoneData) do
                table.insert(sortedVendors, data.name or "Unknown Vendor")
            end
            table.sort(sortedVendors)

            for _, name in ipairs(sortedVendors) do
                local btn = GetButton(index)
                btn:SetText(string.format("• %s", name))
                if btn:GetFontString() then btn:GetFontString():SetJustifyH("LEFT") end
                btn.targetMapID = nil
                if index == 1 then btn:SetPoint("TOPLEFT", DirTitle, "BOTTOMLEFT", 0, -4)
                else btn:SetPoint("TOPLEFT", buttons[index-1], "BOTTOMLEFT", 0, -2) end
                local w = btn:GetFontString():GetStringWidth()
                if w > maxWidth then maxWidth = w end
                btn:Show()
                index = index + 1
            end
        end
        DirectoryFrame:SetSize(maxWidth + 35, (index * 16) + 20)
    else
        DirectoryFrame:Hide()
    end
end

hooksecurefunc(WorldMapFrame, "OnMapChanged", function() HNDecor:UpdateDirectory() end)



local function iter(t, prestate)
    if not t then return nil end
    local state, value = next(t, prestate)
    local currentIcon = ICONS[db.icon_choice] or ICONS.dot_red

    while state do
        if value then
            local showIt = true
            if db.hide_enemy and value.faction then
                local myFaction = string.lower(UnitFactionGroup("player"))
                if value.faction ~= "neutral" and value.faction ~= myFaction then
                    showIt = false
                end
            end
            if showIt then
                return state, nil, currentIcon, db.icon_scale, db.icon_alpha
            end
        end
        state, value = next(t, state)
    end
    return nil, nil, nil, nil, nil
end

function HNDecor:GetNodes2(uiMapID, minimap)
    return iter, nodes[uiMapID], nil
end



function HNDecor:OnEnter(uiMapID, coord)
    local nodeData = nodes[uiMapID] and nodes[uiMapID][coord]
    if not nodeData then return end
    local tooltip = GameTooltip
    if self:GetCenter() > UIParent:GetCenter() then
        tooltip:SetOwner(self, "ANCHOR_LEFT")
    else
        tooltip:SetOwner(self, "ANCHOR_RIGHT")
    end
    tooltip:SetText("Decor Vendor")
    tooltip:AddLine(nodeData.label, 1, 1, 1)
    tooltip:Show()
end

function HNDecor:OnLeave(uiMapID, coord)
    GameTooltip:Hide()
end



local options = {
    type = "group",
    name = "Decor Vendors",
    get = function(info) return db[info[#info]] end,
    set = function(info, v)
        db[info[#info]] = v
        if info[#info] == "hide_visited" then ImportData() end
        HNDecor:Refresh()
        HNDecor:UpdateDirectory()
    end,
    args = {
        desc = { name = "Map Settings", type = "description", order = 0 },
        show_vendors = { name = "Enable Addon", type = "toggle", width = "full", order = 1 },
        hide_visited = { 
            name = "Hide on Visit", 
            desc = "Remove pin after you talk to the vendor.",
            type = "toggle", 
            width = "full", 
            order = 2 
        },
        reset_visits = {
            name = "Reset Visited Vendors",
            desc = "Show all hidden pins again.",
            type = "execute",
            width = "full",
            order = 3,
            func = function()
                db.visited_vendors = {} 
                print("|cFF00FF00[Decor Vendors]|r All pins reset!")
                ImportData()
                HNDecor:Refresh()
                HNDecor:UpdateDirectory()
            end
        },
        icon_choice = {
            name = "Icon Style",
            type = "select",
            values = {
                dot_red = "Dot (Red)", dot_yellow = "Dot (Yellow)", dot_green = "Dot (Green)",
                bag_brown = "Bag (Classic)", bag_green = "Bag (Green)", bag_red = "Bag (Red)",
                bag_blue = "Bag (Blue)", bag_round = "Bag (Round)", custom = "My Custom Icon"
            },
            order = 4,
        },
        header_visual = { type = "header", name = "Adjustments", order = 10 },
        icon_scale = { name = "Scale", type = "range", min = 0.5, max = 3, step = 0.1, order = 11 },
        icon_alpha = { name = "Transparency", type = "range", min = 0, max = 1, step = 0.1, order = 12 },
        hide_enemy = { name = "Hide Enemy Faction", type = "toggle", width = "full", order = 13 },
    },
}

function HNDecor:OnInitialize()
    local defaults = {
        profile = {
            show_vendors = true,
            hide_enemy = true,
            hide_visited = true, 
            visited_vendors = {}, 
            icon_scale = 1.5,
            icon_alpha = 1.0,
            icon_choice = "dot_red",
            directory_minimized = false,
        },
    }
    self.db = LibStub("AceDB-3.0"):New("HandyNotes_DecorVendorsDB", defaults, "Default")
    db = self.db.profile
    
    ImportData()
    
    self:RegisterEvent("PLAYER_ENTERING_WORLD", "WorldEnter")
    self:RegisterEvent("MERCHANT_SHOW") 
end

function HNDecor:WorldEnter()
    self:UnregisterEvent("PLAYER_ENTERING_WORLD")
    C_Timer.After(2, function() 
        self:RegisterWithHandyNotes() 
        HNDecor:UpdateDirectory()
    end)
end

function HNDecor:RegisterWithHandyNotes()
    HandyNotes:RegisterPluginDB(ADDON_NAME, HNDecor, options)
    self:Refresh()
end

function HNDecor:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", ADDON_NAME)
end