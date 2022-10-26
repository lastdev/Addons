local _, ns = ...
local points = ns.points
local texturesL = ns.texturesL
local scalingL = ns.scalingL
local texturesS = ns.texturesS
local scalingS = ns.scalingS

-- =============================
-- Tricks and Treats of Kalimdor
-- =============================
-- 963 = Alliance
-- 965 = Horde

points[ 97 ] = { -- Azuremyst Isle
	[48494905] = { 963, 2, "0", "", "Azure Watch" },
	[30322500] = { 963, 9, "0", "", "Seat of the Naaru" },
}
points[ 106 ] = { -- Bloodmyst Isle
	[55695997] = { 963, 3, "0", "", "Blood Watch" },
}
points[ 63 ] = { -- Ashenvale
	[37014926] = { 963, 1, "0", "Your quest phase does not matter - the bucket is always available.", "Astranaar" },
	[38664234] = { 965, 1, "0", "Outside, easy to see", "Hellscream's Watch" },
	[50256727] = { 965, 2, "0", "", "Silverwind Refuge" },
	[73966060] = { 965, 3, "0", "Follow the map marker for the correct building", "Splintertree Post" },
	[13003410] = { 965, 4, "0", "", "Zoram'gar Outpost" },
}
points[ 76 ] = { -- Azshara
	[57115017] = { 965, 5, "0", "Exclusive Taraezor tip! Pause to check your map while you are\n"
                                    .."inside the inn next to the candy bucket. You want to stretch\n"
									.."that rested bonus for as long as possible!", "Bilgewater Harbor" },
}
points[ 62 ] = { -- Darkshore
	[50791890] = { 963, 4, "0", "You may need to speak to Zidormi", "Lor'danel" },
}
points[ 89 ] = { -- Darnassus
	[62283315] = { 963, 5, "0", "You may need to speak to Zidormi.", "Craftsmen's Terrace" },
}
points[ 66 ] = { -- Desolace
	[56725010] = { 963, 6, "0", "", "Karnum's Glade" },
	[66330659] = { 963, 7, "0", "", "Nigel's Point" },
	[56725014] = { 965, 6, "0", "", "Karnum's Glade" },
	[24076829] = { 965, 7, "0", "", "Shadowprey Village" },
}
points[ 1 ] = { -- Durotar
	[51544158] = { 965, 8, "0", "", "Razor Hill" },
	[46940672] = { 965, 20, "0", "", "Valley of Strength" },
}
points[ 70 ] = { -- Dustwallow Marsh
	[41867407] = { 963, 8, "0", "Upstairs, inside the main hut", "Mudsprocket" },
	[36783244] = { 965, 9, "0", "", "Brackenwall Village" },
	[41867411] = { 965, 10, "0", "Upstairs, inside the main hut", "Mudsprocket" },
}
points[ 103 ] = { -- The Exodar
	[59241848] = { 963, 9, "0", "", "Seat of the Naaru" },
}
points[ 77 ] = { -- Felwood
	[61862671] = { 963, 10, "0", "Ever wanted to experiment with \"Particle Density\" in\n"
									.."System->Graphics->Effects? Stand at the entrance and\n"
									.."look towards the candy bucket!", "Talonbranch Glade" },
	[44582897] = { 963, 11, "0", "There's space inside the inn, as usual, for the candy bucket yet...\n"
									.."it's placed on the landing outside. Unusual! Spooky?", "Whisperwind Grove" },
	[44582901] = { 965, 11, "0", "There's space inside the inn, as usual, for the candy bucket yet...\n"
									.."it's placed on the landing outside. Unusual! Spooky?", "Whisperwind Grove" },
}
points[ 69 ] = { -- Feralas
	[51071782] = { 963, 12, "0", "", "Dreamer's Rest" },
	[46334519] = { 963, 13, "0", "", "Feathemoon Stronghold" },
	[41451568] = { 965, 12, "0", "", "Camp Ataya" },
	[74834514] = { 965, 13, "0", "", "Camp Mojache" },
	[51974764] = { 965, 14, "0", "", "Stonemaul Hold" },
}
points[ 7 ] = { -- Mulgore
	[46796041] = { 965, 15, "0", "", "Bloodhoof Village" },
	[39703118] = { 965, 28, "0", "Inside \"The Cat and the Shaman\" inn.", "Lower Rise" },
}
points[ 10 ] = { -- Northern Barrens
	[67347465] = { 963, 14, "0", "", "Ratchet" },
	[49515791] = { 965, 16, "0", "Main building. It's the inn. De rigueur", "The Crossroads" },
	[56214003] = { 965, 17, "0", "", "Grol'dom Farm" },
	[62511660] = { 965, 18, "0", "Grab a Leaping Hatchling pet from nearby... oh yeah, did I mention that I\n"
									.."have an AddOn for that too? Collect all four of the adorable raptor pets!", "Nozzlepot's Outpost" },
	[67347467] = { 965, 19, "0", "", "Ratchet" },
}
points[ 85 ] = { -- Orgrimmar
	[53937894] = { 965, 20, "0", "Don't forget to make a quick macro as follows:\n"
					.."#showtooltip Handful of Treats\n/use Handful of Treats", "Valley of Strength" },
	[50843631] = { 5838, 1, "0", "Through this portal for the Deepholm candy bucket.\n"
									.."A Vashj'ir portal is closeby too!", "Temple of Earth" },
}
points[ 81 ] = { -- Silithus
	[55473678] = { 963, 15, "0", "In the Oasis inn, below the Flight Masters.\n"
									.."You may need to speak to Zidormi", "Cenarion Hold" },
	[55473680] = { 965, 21, "0", "In the Oasis inn, below the Flight Masters.\n"
									.."You may need to speak to Zidormi", "Cenarion Hold" },
}
points[ 199 ] = { -- Southern Barrens
	[49046851] = { 963, 16, "0", "Another candy bucket that's not in a building. Hooray!", "Fort Triumph" },
	[39021099] = { 963, 17, "0", "It's out in the open.", "Honor's Stand" },
	[65604654] = { 963, 18, "0", "To the south, just across the border into Dustwallow Marsh.\n"
									.."is an adorable and oh so cute raptor hatchling pet, one of\n"
									.."a set of four. Why not \"dart\" over and grab it now!", "Northwatch Hold" },
	[40706931] = { 965, 22, "0", "", "Desolation Hold" },
	[39292009] = { 965, 23, "0", "", "Hunter's Hill" },
}
points[ 65 ] = { -- Stonetalon Mountains
	[31536066] = { 963, 19, "0", "Another open air Elven inn - fly right in!", "Farwatcher's Glen" },
	[71027908] = { 963, 20, "0", "", "Northwatch Expedition Base" },
	[39483281] = { 963, 21, "0", "", "Thal'darah Overlook" },
	[59045632] = { 963, 22, "0", "Fallowmere Inn", "Windshear Hold" },
	[66506419] = { 965, 24, "0", "Inside the smallest building.", "Krom'gar Fortress" },
	[50376379] = { 965, 25, "0", "Alchemy completionists will want the Fire Protection potion\n"
									.."from Jeeda upstaits. Good luck!", "Sun Rock Retreat" },
}
points[ 71 ] = { -- Tanaris
	[55706095] = { 963, 23, "0", "", "Bootlegger Outpost" },
	[52562709] = { 963, 24, "0", "Did you stock up on Noggenfogger while you are here?\n"
								.."Oh yeah, the candy bucket is inside \"The Road Warrior\" inn", "Gadgetzan" },
	[55706097] = { 965, 26, "0", "", "Bootlegger Outpost" },
	[52562711] = { 965, 27, "0", "Did you stock up on Noggenfogger while you are here?\n"
								.."Oh yeah, the candy bucket is inside \"The Road Warrior\" inn", "Gadgetzan" },
}
points[ 57 ] = { -- Teldrassil
	[55365229] = { 963, 25, "0", "Inside the inn. You can fly right in.\nYou may need to speak to Zidormi.", "Dolanaar" },
	[34164401] = { 963, 5, "0", "You may need to speak to Zidormi.", "Craftsmen's Terrace" },
}
points[ 88 ] = { -- Thunder Bluff
	[45626493] = { 965, 28, "0", "Inside \"The Cat and the Shaman\" inn.", "Lower Rise" },
}
points[ 78 ] = { -- Un'Goro Crater
	[55266219] = { 963, 26, "0", "Did you get your awesome Venomhide Ravasaur mount while you were here?\n"
								.."Oh wait... you're Alliance. Oh well.", "Marshal's Stand" },
	[55266213] = { 965, 29, "0", "Did you get your awesome Venomhide Ravasaur mount while you were here?", "Marshal's Stand" },
}
points[ 83 ] = { -- Winterspring
	[59835119] = { 963, 27, "0", "Grab a Winterspring Cub pet from Michelle De Rum who is\n"
                                    .."standing near the candy bucket. Awwww... so cute!\n"
									.."Don't forget the Mount Hyjal locations too!", "Everlook" },
	[59835123] = { 965, 30, "0", "Grab a Winterspring Cub pet from Michelle De Rum who is\n"
                                    .."standing near the candy bucket. Awwww... so cute!\n"
									.."Don't forget the Mount Hyjal locations too!", "Everlook" },
}
points[ 12 ] = { -- Kalimdor continent map hacks
	-- Azuremyst Isle
	[32402650] = { 963, 2, "0", "", "Azure Watch" },
	-- Silithus
	[44397818] = { 963, 15, "0", "In the Oasis inn, below the Flight Masters.\n"
									.."You may need to speak to Zidormi", "Cenarion Hold" },
	-- Tanaris
	[56857900] = { 963, 24, "0", "Did you stock up on Noggenfogger while you are here?\n"
								.."Oh yeah, the candy bucket is inside \"The Road Warrior\" inn", "Gadgetzan" },
	-- Teldrassil
	[43711023] = { 963, 25, "0", "Inside the inn. You can fly right in.\nYou may need to speak to Zidormi.", "Dolanaar" },
	[40320891] = { 963, 5, "0", "You may need to speak to Zidormi.", "Craftsmen's Terrace" },
}

-- ==============================
-- Cleanup in Stormwind/Undercity - Added 4.1.0
-- ==============================
-- 1040 2 = Alliance. Quest 29144 R
-- 1041 2 = Horde. Quest 29375 R
-- ================
-- Stink Bombs Away - Added 4.1.0
-- ================
-- 1040 1 = Alliance. Quest 29054 R
-- 1041 1 = Horde. Quest 29374 R
-- =========================
-- A Time to Lose/Break Down - Added 4.2.0
-- =========================
-- 1040 4 = Alliance. Quest 29371 R
-- 1041 4 = Horde. Quest 29377 R
-- =====================================
-- Tricks and Treats of Eastern Kingdoms
-- =====================================
-- 966 = Alliance
-- 967 = Horde

points[ 14 ] = { -- Arathi Highlands
	[40064909] = { 966, 1, "0", "If you cannot see the candy bucket then you'll\n"
									.."need to visit Zidormi. I marked her on the map.", "Refuge Point" },
	[38259009] = { 966, 1, "0", "Zidormi is at this location. You'll probably\n"
									.."need her for the Refuge Pointe candy bucket.", "Refuge Point" },
	[69023327] = { 967, 1, "0", "Well if it's not outside then it must be...", "Hammerfall" },
}
points[ 15 ] = { -- Badlands
	[20875632] = { 966, 2, "0", "", "Dragon's Mouth" },
	[65853564] = { 966, 3, "0", "The apple bobbing tub is outside, the pumpkin is inside", "Fuselight" },
	[65853566] = { 967, 2, "0", "The apple bobbing tub is outside, the pumpkin is inside", "Fuselight" },
	[18354273] = { 967, 3, "0", "", "New Kargath" },
}
points[ 17 ] = { -- Blasted Lands
	[60691407] = { 966, 4, "0", "Erm... mobs looking a bit too red, a bit too hostile for your\n"
									.."liking? That'll be Zidormi you'll be needing. She's nearby.\n"
									.."The correct building is the one on the left of the main gate.\n"
									.."When you enter, turn right and then left. Voilà!", "Nethergarde Keep" },
	[44348759] = { 966, 5, "0", "Hey, fun trivia... see Garrod's house nearby? You\n"
									.."won't get dismounted - you can fly around inside!\n"
									.."Oh yeah... Zidormi is not required for Surwich!", "Surwich" },
	[40471129] = { 967, 4, "0", "If the guards are hostile... It's a Zidormi problem, sigh. She'd just nearby!", "Dreadmaul Hold" },
}
points[ 210 ] = { -- The Cape of Stranglethorn
	[40917371] = { 966, 6, "0", "It's in the Salty Sailor Tavern", "Booty Bay" },
	[40917373] = { 967, 5, "0", "It's in the Salty Sailor Tavern", "Booty Bay" },
	[35042722] = { 967, 6, "0", "It's in the building next to the apple bobbing tub", "Hardwrench Hideaway" },
}
points[ 27 ] = { -- Dun Morogh
	[54495076] = { 966, 7, "0", "Inside the Thunderbrew Distillery at the eating area.", "Kharanos" },
	[61172746] = { 966, 13, "0", "Inside the Stonefire Tavern in The Commons", "The Commons" },
}
points[ 47 ] = { -- Duskwood
	[73804425] = { 966, 8, "0", "", "Darkshire" },
}
points[ 23 ] = { -- Eastern Plaguelands
	[75575230] = { 966, 9, "0", "", "Light's Hope Chapel" },
	[75575232] = { 967, 7, "0", "Use a taxi between Light's Hope Chapel and Tranquillien.", "Light's Hope Chapel" },
}
points[ 24 ] = { -- Light's Hope Chapel - Sanctum of Light
	[40709035] = { 966, 9, "0", "", "Light's Hope Chapel" },
	[40709037] = { 967, 7, "0", "", "Light's Hope Chapel" },
}
points[ 37 ] = { -- Elwynn Forest
	[43746589] = { 966, 10, "0", "", "Goldshire" },
	[24894013] = { 966, 19, "0", "Don't forget to make a quick macro as follows:\n"
					.."#showtooltip Handful of Treats\n/use Handful of Treats", "" },
	[32355088] = { 1040, 1, 29054, "Pickup the quest here from Gretchen Fenlow and\n"
									.."then your broomstick taxi from Gertrude Fenlow,\n"
									.."who is nearby. Soon after completion you could\n"
									.."consider logging out. You will respawn at the Scarlet\n"
									.."Watchtower in Tirisfal Glades. This will save a lot\n"
									.."of time if you also intend doing \"A Time to Lose\".", "" },									
	[29694442] = { 1040, 2, 29144, "Pickup the quest from Gretchen Fenlow who is just outside\n"
									.."the Stormwind gates. To see the orange plumes you must\n"
									.."have \"Particle Density\" at least minimally enabled. Go to\n"
									.."System->Graphics->Effects. If you get debuffed then you\n"
									.."may cleanse yourself. Shapeshifting also works.", "" },
	[32095059] = { 1040, 4, 29371, "Pickup the quest here from Keira. See my travel notes for\n"
									.."the quest \"Stink Bombs Away\". Take extra care as you\n"
									.."will have no ground/structure cover. My approach is to\n"
									.."fly in from very high and then plummet straight down.", "" },
	[22133396] = { 1041, 1, 29374, "If you logout while in Stormwind you'll respawn nearby.\n"
									.."Handy for doing \"A Time to Break Down\".", "" },
	[34104740] = { 1041, 4, 29377, "The location of the Alliance Wickerman.\n"
									.."Approach from due east. Use the large tree and the ledge\n"
									.."as cover. Stay away from the wall to avoid zoning out and\n"
									.."adding to phasing problems. Reports suggest activating\n"
									.."Warmode in Orgrimmar will help in that respect. Do NOT\n"
									.."try to target the Wickerman. Stand near it and click on\n"
									.."your Dousing Agent. Immediately mount and hit \"space\"\n"
									.."to fly straight up.", "" },
	[31241227] = { 5837, 1, "0", "Through this portal for the Deepholm candy bucket.\n"
									.."A Vashj'ir portal is closeby too!", "Temple of Earth" },
}
points[ 94 ] = { -- Eversong Woods
	[43707103] = { 967, 8, "0", "Use a taxi between Fairbreeze Village and Tranquillien.", "Fairbreeze Village" },
	[48204788] = { 967, 9, "0", "Go through the \"blue\" doorway", "Falconwing Square" },
	[55474495] = { 967, 17, "0", "Wayfarer's Rest inn", "The Bazaar" },
	[59294137] = { 967, 18, "0", "Silvermoon City Inn", "The Royal Exchange" },
}
points[ 95 ] = { -- Ghostlands
	[48683190] = { 967, 10, "0", "Use a taxi between Light's Hope Chapel and Tranquillien.\n"
									.."Use a taxi between Fairbreeze Village and Tranquillien.", "Tranquillien" },
}
points[ 25 ] = { -- Hillsbrad Foothills
	[60266374] = { 967, 11, "0", "Hooray! It's outdoors and a no-brainer to find. Wooooo!", "Eastpoint Tower" },
	[57854727] = { 967, 12, "0", "Identical building design as Andorhal. Follow the map marker please.", "Tarren Mill" },
}
points[ 26 ] = { -- The Hinterlands
	[14194460] = { 966, 11, "0", "The lowest level hillside building.", "Aerie Peak" },
	[66164443] = { 966, 12, "0", "", "Stormfeather Outpost" },
	[31805787] = { 967, 13, "0", "", "Hiri'watha Research Station" },
	[78198147] = { 967, 14, "0", "Inside the main (only) building", "Revantusk Village" },
}
points[ 87 ] = { -- Ironforge
	[18345094] = { 966, 13, "0", "Inside the Stonefire Tavern in The Commons", "The Commons" },
}
points[ 48 ] = { -- Loch Modan
	[83036352] = { 966, 14, "0", "", "Farstrider Lodge" },
	[35544850] = { 966, 15, "0", "", "Thelsamar" },
}
points[ 50 ] = { -- Northern Stranglethorn
	[53166698] = { 966, 16, "0", "", "Fort Livingston" },
	[37385178] = { 967, 15, "0", "At the base of the zeppelin tower", "Grom'gol Base Camp" },
}
points[ 49 ] = { -- Redridge Mountains
	[26464150] = { 966, 17, "0", "", "Lakeshire" },
}
points[ 32 ] = { -- Searing Gorge
	[39486601] = { 966, 18, "0", "Outside, high up on a perimiter ledge", "Iron Summit" },
	[39486603] = { 967, 16, "0", "Outside, high up on a perimiter ledge", "Iron Summit" },
}
points[ 110 ] = { -- Silvermoon City
	[38008479] = { 967, 9, "0", "Go through the \"blue\" doorway", "Falconwing Square" },
	[67597289] = { 967, 17, "0", "Wayfarer's Rest inn", "" },
	[70357702] = { 967, 17, "0", "Enter through here!", "" },
	[79435765] = { 967, 18, "0", "Silvermoon City Inn", "" },
	[83125829] = { 967, 18, "0", "Enter through here!", "" },
}
points[ 21 ] = { -- Silverpine Forest
	[44302029] = { 967, 19, "0", "", "Forsaken Rear Guard" },
	[46454290] = { 967, 20, "0", "In the largest building", "The Sepulcher" },
}
points[ 224 ] = { -- Stranglethorn Vale
	[52094310] = { 966, 16, "0", "", "Fort Livingston" },
	[37897992] = { 966, 6, "0", "It's in the Salty Sailor Tavern", "Booty Bay" },
	[42213359] = { 967, 15, "0", "At the base of the zeppelin tower", "Grom'gol Base Camp" },
	[37897994] = { 967, 5, "0", "It's in the Salty Sailor Tavern", "Booty Bay" },
	[34365192] = { 967, 6, "0", "It's in the building next to the apple bobbing tub", "Hardwrench Hideaway" },
}
points[ 84 ] = { -- Stormwind City
	[60517534] = { 966, 19, "0", "Don't forget to make a quick macro as follows:\n"
					.."#showtooltip Handful of Treats\n/use Handful of Treats", "" },
	[75419681] = { 1040, 1, 29054, "Pickup the quest here from Gretchen Fenlow and\n"
									.."then your broomstick taxi from Gertrude Fenlow,\n"
									.."who is nearby. Soon after completion you could\n"
									.."consider logging out. You will respawn at the Scarlet\n"
									.."Watchtower in Tirisfal Glades. This will save a ton\n"
									.."of time if you also intend doing \"A Time to Lose\".", "" },									
	[70108390] = { 1040, 2, 29144, "Pickup the quest from Gretchen Fenlow who is just outside\n"
									.."the Stormwind gates. To see the orange plumes you must\n"
									.."have \"Particle Density\" at least minimally enabled. Go to\n"
									.."System->Graphics->Effects. If you get debuffed then you\n"
									.."may cleanse yourself. Shapeshifting also works.", "" },
	[74889624] = { 1040, 4, 29371, "Pickup the quest here from Keira. See my travel notes for\n"
									.."the quest \"Stink Bombs Away\". Take extra care as you\n"
									.."will have no ground/structure cover. My approach is to\n"
									.."fly in from very high and then plummet straight down.", "" },
	[55006300] = { 1041, 1, 29374, "If you logout while in Stormwind you'll respawn at the\n"
									.."Eastvale Logging Camp in Elwynn Forest. Handy for\n"
									.."doing \"A Time to Break Down\".", "" },
	[78918986] = { 1041, 4, 29377, "The location of the Alliance Wickerman.\n"
									.."Approach from due east. Use the large tree and the ledge\n"
									.."as cover. Stay away from the wall to avoid zoning out and\n"
									.."adding to phasing problems. Reports suggest activating\n"
									.."Warmode in Orgrimmar will help in that respect. Do NOT\n"
									.."try to target the Wickerman. Stand near it and click on\n"
									.."your Dousing Agent. Immediately mount and hit \"space\"\n"
									.."to fly straight up.", "" },
	[73191967] = { 5837, 1, "0", "Through this portal for the Deepholm candy bucket.\n"
									.."A Vashj'ir portal is closeby too!", "Temple of Earth" },
}
points[ 51 ] = { -- Swamp of Sorrows
	[71651409] = { 966, 20, "0", "", "Bogpaddle" },
	[28933240] = { 966, 21, "0", "", "The Harborage" },
	[71651411] = { 967, 21, "0", "", "Bogpaddle" },
	[46885692] = { 967, 22, "0", "", "Stonard" },
}
points[ 18 ] = { -- Tirisfal Glades
	[62197300] = { 967, 25, "0", "", "The Trade Quarter" },
	[60955141] = { 967, 23, "0", "Brill might work as your Hearth for this event for an alt. Quick\n"
                                    .."return from Elwynn after your dailies in Stormwind, plus the\n"
									.."zeppelin post gets me to Kalimdor and Northrend for my Tricks\n"
									.."and Treats circuit. Later I switch to Orgrimmar for Pandaria etc\n"
									.."T&T accessibility. Using Brill avoids the annoying portal from\n"
									.."Orgrimmar into Under City.", "Brill" },
	[82987207] = { 967, 24, "0", "", "The Bulwark" },	
	[62136702] = { 1041, 1, 29374, "Pickup the quest from Candace Fenlow, nearby, and\n"
									.."get your instant taxi from Crina Fenlow. Soon after\n"
									.."completion you could consider logging out. You will\n"
									.."respawn at the Eastvale Logging Camp graveyard in\n"
									.."Elwynn Forest. This will save a ton of time if you also\n"
									.."intend doing \"A Time to Break Down\".", "" },
	[62436671] = { 1041, 2, 29375, "Pickup the quest from Candace Fenlow. To see the orange\n"
									.."plumes you must have \"Particle Density\" at least\n"
									.."minimally enabled. Go to System->Graphics->Effects. If\n"
									.."you get debuffed then you may cleanse yourself.\n"
									.."Shapeshifting also works.", "" },
	[66606200] = { 1041, 2, 29375, "If things are not \"peaceful\" then do NOT attempt to\n"
									.."enter Lordaeron. Speak to Zidormi who is nearby.", "" },
	[62126783] = { 1041, 4, 29377, "Pickup the quest here from Darkcaller Yanks. See my travel\n"
									.."notes for the quest \"Stink Bombs Away\". Approach from\n"
									.."the east, hugging the terrain. A large tree will cover your\n"
									.."final approach.", "" },
	[61508110] = { 1040, 1, 29054, "If you logout while in Undercity you'll respawn nearby.\n"
									.."Handy for doing \"A Time to Lose\"", "" },
	[62406820] = { 1040, 4, 29371, "The location of the Horde Wickerman.\n"
									.."Approach from as high up as possible. Plummet down.\n"
									.."Land between the Wickerman and the wall, preferably\n"
									.."with a pillar providing a little cover. The pillar where\n"
									.."the green bubbling liquid begins is perfect. Do NOT\n"
									.."try to target the Wickerman. Stand near it and click\n"
									.."on your Dousing Agent. Immediately mount and hit\n"
									.."\"space\" to fly straight up.", "" },
}
points[ 90 ] = { -- Undercity
	[67753742] = { 967, 25, "0", "", "The Trade Quarter" },
	[76503301] = { 1041, 2, 29375, "To see the orange plumes you must have \"Particle Density\"\n"
									.."at least minimally enabled via System->Graphics->Effects.", "" },
	[75703300] = { 1040, 1, 29054, "If you logout while in Undercity you'll respawn nearby.\n"
									.."Handy for doing \"A Time to Lose\".", "" },
	[76105320] = { 1040, 4, 29371, "Logout while in Undercity doing \"Stink Bombs "
									.."Away\"\nfor faster travelling back to Lordaeron.", "" },
}
points[ 22 ] = { -- Western Plaguelands
	[43388437] = { 966, 22, "0", "", "Chillwind Camp" },
	[48286365] = { 967, 26, "0", "Impossible to describe. Trust in the coordinates / map marker please!", "Andorhal" },
}
points[ 52 ] = { -- Westfall
	[52915374] = { 966, 25, "0", "In the Inn or atop the tower, depending upon your quest phase.\n"
									.."This map marker is for the inn.", "Sentinel Hill" },
}
points[ 56 ] = { -- Wetlands
	[10836099] = { 966, 23, "0", "Don't go into the big fort/castle. Go around the back to the inn.", "Menethil Harbor" },
	[26072598] = { 966, 24, "0", "", "Swiftgear Station" },
	[58213920] = { 966, 26, "0", "Just nearby is an adorable raptor hatchling pet. It's oh so cute.\n"
									.."Steal it from her mother's nest you heartless pet collector!\n"
									.."Oh, did I say that I have an AddOn to help you collect four?", "Greenwarden's Grove" },
}
points[ 13 ] = { -- Eastern Kingdoms continent map hacks
	-- Searing Gorge does not display pins automatically on the continent for Alliance
	[47576726] = { 966, 18, "0", "Outside, high up on a perimiter ledge", "Iron Summit" },
	-- Same for the Eastern Plaguelands
	[57603260] = { 966, 9, "0", "", "Light's Hope Chapel" },
	-- Bogpaddle refuses to be shown. Whatever!
	[54127715] = { 966, 20, "0", "", "Bogpaddle" },
	[54127717] = { 967, 21, "0", "", "Bogpaddle" },
	-- The Cape of Stranglethorn
	[43409290] = { 966, 6, "0", "It's in the Salty Sailor Tavern", "Booty Bay" },
	-- Vashj'ir
	[34346363] = { 5837, 13, "0", "Inside Silver Tide Hollow. Dive straight down. The icon marks the entrance", "Silver Tide Hollow" },
	[36336030] = { 5837, 12, "0", "Inside Deepmist Grotto. Dive straight down. The icon marks the entrance", "Deepmist Grotto" },
	[34346364] = { 5838, 12, "0", "Inside Silver Tide Hollow. Dive straight down. The icon marks the entrance", "Silver Tide Hollow" },
}

-- ============================
-- Tricks and Treats of Outland
-- ============================
-- 969 = Alliance
-- 968 = Horde

points[ 105 ] = { -- Blade's Edge Mountains
	[62903828] = { 969, 1, "0", "Inside the inn, mailbox at the front", "Evergrove" },
	[35806370] = { 969, 2, "0", "At the rear of the inn,\nbehind the main building", "Sylvanaar" },
	[61106810] = { 969, 3, "0", "At the rear of the inn,\nThe building has a mailbox", "Toshley's Station" },
	[62903832] = { 968, 1, "0", "Inside the inn, mailbox at the front", "Evergrove" },
	[76226039] = { 968, 2, "0", "Inside the main building", "Mok'Nathal Village" },
	[53435555] = { 968, 3, "0", "Inside the main building", "Thunderlord Stronghold" },
}
points[ 100 ] = { -- Hellfire Peninsula
	[54206370] = { 969, 4, "0", "In the inn, mailbox at the front", "Honor Hold" },
	[23403660] = { 969, 5, "0", "In the main building at the end of the promenade", "Temple of Telhamat" },
	[26905940] = { 968, 4, "0", "In the lower, domed building", "Falcon Watch" },
	[56803750] = { 968, 5, "0", "In the smaller of the two main buildings", "Thrallmar" },
}
points[ 107 ] = { -- Nagrand
	[54197588] = { 969, 6, "0", "Below the Flight Master", "Telaar" },
	[56683448] = { 968, 6, "0", "At the centre of the huge round building", "Garadar" },
}
points[ 109 ] = { -- Netherstorm
	[32006453] = { 969, 7, "0", "A little inside the main building", "Area 52" },
	[43313608] = { 969, 8, "0", "Fly high up. Inside the lowest building", "The Stormspire" },
	[32006457] = { 968, 7, "0", "A little inside the main building", "Area 52" },
	[43313610] = { 968, 8, "0", "Fly high up. Inside the lowest building", "The Stormspire" },
}
points[ 104 ] = { -- Shadowmoon Valley
	[61002817] = { 969, 9, "0", "You must be Aldor", "Altar of Sha'tar" },
	[56375980] = { 969, 9, "0", "You must be Scryer", "Sanctum of the Stars" },
	[37015829] = { 969, 10, "0", "In the dining area of the Kharanos-style inn with\n"
					.."brewing iconography. Don't enter the big building", "Wildhammer Stronghold" },
	[61002821] = { 968, 9, "0", "You must be Aldor", "Altar of Sha'tar" },
	[56405982] = { 968, 9, "0", "You must be Scryer", "Sanctum of the Stars" },
	[30272770] = { 968, 10, "0", "In the main building", "Shadowmoon Village" },
}
points[ 111 ] = { -- Shattrath City
	[28204900] = { 969, 11, "0", "You must be Aldor", "Aldor Rise" },
	[56308194] = { 969, 11, "0", "You must be Scryer", "Scryer's Tier" },
	[28204901] = { 968, 11, "0", "You must be Aldor", "Aldor Rise" },
	[56308196] = { 968, 11, "0", "You must be Scryer", "Scryer's Tier" },
}
points[ 108 ] = { -- Terokkar Forest
	[56605320] = { 969, 12, "0", "Inside the only round, domed (elven) building", "Allerian Stronghold" },
	[48744517] = { 968, 12, "0", "Inside the huge round building", "Stonebreaker Hold" },
}
points[ 102 ] = { -- Zangarmarsh
	[78456288] = { 969, 13, "0", "Inside the main building", "Cenarion Refuge" },
	[41902620] = { 969, 14, "0", "Inside the building with the mailbox", "Orebor Harborage" },
	[67204890] = { 969, 15, "0", "Right next to the innkeeper", "Telredor" },
	[30625087] = { 968, 13, "0", "The ground level of the inn with no name :(", "Zabra'jin" },
	[78456290] = { 968, 14, "0", "Inside the main building", "Cenarion Refuge" },
}

-- ==============================
-- Tricks and Treats of Northrend
-- ==============================
-- 5836 = Alliance
-- 5835 = Horde

points[ 114 ] = { -- Borean Tundra
	[57071907] = { 5836, 1, "0", "Inside the main building. Icon marks the entrance", "Fizzcrank Airstrip" },
	[78454914] = { 5836, 2, "0", "Inside the inn / main building which is above the shore", "Unu'pe" },
	[58526787] = { 5836, 3, "0", "Quite a ways inside the inn, which is adjacent to the Flight Master", "Valiance Keep" },
	[49750998] = { 5835, 1, "0", "", "Bor'gorok Outpost" },
	[76663747] = { 5835, 2, "0", "", "Taunka'le Village" },
	[78454918] = { 5835, 3, "0", "Inside the inn / main building which is above the shore", "Unu'pe" },
	[41715440] = { 5835, 4, "0", "The lowest level. Use the south entrance at ground level.", "Warsong Hold" },
}
points[ 127 ] = { -- Crystalsong Forest
	[29003239] = { 5836, 4, "0", "Hey, did you download my \X and Y\" AddOn for cool minimap coordinates!\n"
									.."(Shameless self promotion)", "The Legerdemain Lounge" },
	[24903750] = { 5836, 5, "0", "Don't go into the Silver Enclave.\nIt's in the adjacent \"A Hero's Welcome\" inn.\n"
					.."Under the stairs on the right side", "A Hero's Welcome" },
	[27304169] = { 5836, 6, "0", "Cantrips & Crows", "The Underbelly" },
	[29003241] = { 5835, 5, "0", "Hey, did you download my \X and Y\" AddOn for cool minimap coordinates!\n"
									.."(Shameless self promotion)", "The Legerdemain Lounge" },
	[30703770] = { 5835, 6, "0", "The Filthy Animal\nDon't forget to make a quick macro as follows:\n"
					.."#showtooltip Handful of Treats\n/use Handful of Treats", "Sunreaver's Sanctuary" },
	[27304171] = { 5835, 7, "0", "Cantrips & Crows", "The Underbelly" },
}
points[ 125 ] = { -- Dalaran
	[48154127] = { 5836, 4, "0", "Hey, did you download my \X and Y\" AddOn for cool minimap coordinates!\n"
									.."(Shameless self promotion)", "The Legerdemain Lounge" },
	[42366313] = { 5836, 5, "0", "Don't go into the Silver Enclave.\nIt's in the adjacent \"A Hero's Welcome\" inn.\n"
					.."Under the stairs on the right side", "A Hero's Welcome" },
	[38225959] = { 5836, 6, "0", "Cantrips & Crows", "The Underbelly" },
	[48154135] = { 5835, 5, "0", "Hey, did you download my \X and Y\" AddOn for cool minimap coordinates!\n"
									.."(Shameless self promotion)", "The Legerdemain Lounge" },
	[66703000] = { 5835, 6, "0", "The Filthy Animal", "Sunreaver's Sanctuary" },
	[38225965] = { 5835, 7, "0", "Cantrips & Crows", "The Underbelly" },
}
points[ 126 ] = { -- The Underbelly
	[40205949] = { 5836, 6, "0", "Cantrips & Crows", "The Underbelly" },
	[40205951] = { 5835, 7, "0", "Cantrips & Crows", "The Underbelly" },
}
points[ 115 ] = { -- Dragonblight
	[48117465] = { 5836, 7, "0", "", "Moa'ki Harbor" },
	[28955622] = { 5836, 8, "0", "Don't forget to make a quick macro as follows:\n"
					.."#showtooltip Handful of Treats\n/use Handful of Treats", "Stars' Rest" },
	[77285099] = { 5836, 9, "0", "Icon marks the entrance to the inn. It's the closest building to the Flight Master", "Wintergarde Keep" },
	[60155343] = { 5836, 10, "0", "The ground floor. Use the nearest entrance to the Gryphon Master", "Wyrmrest Temple" },
	[37834647] = { 5835, 8, "0", "Don't forget to make a quick macro as follows:\n"
					.."#showtooltip Handful of Treats\n/use Handful of Treats", "Agmar's Hammer" },
	[48117466] = { 5835, 9, "0", "", "Moa'ki Harbor" },
	[76826328] = { 5835, 10, "0", "", "Venomspite" },
	[60155347] = { 5835, 11, "0", "The ground floor. Use the nearest entrance to the Flight Master", "Wyrmrest Temple" },
}
points[ 116 ] = { -- Grizzly Hills
	[31946021] = { 5836, 11, "0", "", "Amberpine Lodge" },
	[59642636] = { 5836, 12, "0", "", "Westfall Brigade" },
	[65364700] = { 5835, 12, "0", "", "Camp Oneqwah" },
	[20896477] = { 5835, 13, "0", "", "Conquest Hold" },
}
points[ 117 ] = { -- Howling Fjord
	[60481591] = { 5836, 13, "0", "My macro:\n#showtooltip Handful of Treats\n/use Handful of Treats", "Fort Wildervar" },
	[25315912] = { 5836, 14, "0", "Icon marks the entrance to the subterranean Inn", "Kamagua" },
	[58676316] = { 5836, 15, "0", "The Inn entrance is at the side....\nThe Penny Pouch is awesome!\nNot :/", "Valgarde" },
	[30834205] = { 5836, 16, "0", "The usual :). Icon marks the inn entrance", "Westguard Keep" },
	[49401080] = { 5835, 14, "0", "", "Camp Winterhoof" },
	[25315916] = { 5835, 15, "0", "Icon marks the entrance to the subterranean Inn", "Kamagua" },
	[52106620] = { 5835, 16, "0", "", "New Agamand" },
	[79273063] = { 5835, 17, "0", "The Inn entrance is at the side....\nThe Penny Pouch is awesome!\nNot :/", "Vengeance Landing" },
}
points[ 119 ] = { -- Sholazar Basin
	[26615918] = { 5836, 17, "0", "At the rear of the larger tent", "Nesingwary Base Camp" },
	[26615922] = { 5835, 18, "0", "At the rear of the larger tent", "Nesingwary Base Camp" },
}
points[ 120 ] = { -- Storm Peaks
	[30583693] = { 5836, 18, "0", "Quest phasing issues reported. Icon marks the entrance", "Bouldercrag's Refuge" },
	[28727428] = { 5836, 19, "0", "", "Frosthold" },
	[40938594] = { 5836, 20, "0", "Icon marks the entrance to the Inn. Surprise!", "K3" },
	[30583695] = { 5835, 19, "0", "Quest phasing issues reported. Icon marks the entrance", "Bouldercrag's Refuge" },
	[67655069] = { 5835, 20, "0", "", "Camp Tunka'lo" },
	[37094951] = { 5835, 21, "0", "", "Grom'arsh Crash Site" },
	[40938596] = { 5835, 22, "0", "Icon marks the entrance to the Inn. Surprise!", "K3" },
}
points[ 121 ] = { -- Zul'Drak
	[40866602] = { 5836, 21, "0", "", "The Argent Stand" },
	[59335719] = { 5836, 22, "0", "Hey, why not change the icons!\n"
									.."ESC->Interface->AddOns->HandyNotes->Plugins expand->Hallow's End", "Zim'Torga" },
	[40866606] = { 5835, 23, "0", "", "The Argent Stand" },
	[59335723] = { 5835, 24, "0", "Hey, why not change the icons!\n"
									.."ESC->Interface->AddOns->HandyNotes->Plugins expand->Hallow's End", "Zim'Torga" },
}

-- ==================================
-- Tricks and Treats of the Cataclysm
-- ==================================
-- 5837 = Alliance
-- 5838 = Horde

points[ 207 ] = { -- Deepholm
	[47365171] = { 5837, 1, "0", "", "Temple of Earth" },
	[51194990] = { 5838, 1, "0", "", "Temple of Earth" },
}
points[ 198 ] = { -- Mount Hyjal
	[18633731] = { 5837, 2, "0", "Just this once max out \"Ground Clutter\" in your settings. You're welcome!", "Grove of Aessina" },
	[63052414] = { 5837, 3, "0", "", "Nordrassil" },
	[42684571] = { 5837, 4, "0", "", "Shrine of Aviana" },
	[18633733] = { 5838, 2, "0", "Just this once max out \"Ground Clutter\" in your settings. You're welcome!", "Grove of Aessina" },
	[63052416] = { 5838, 3, "0", "", "Nordrassil" },
	[42684573] = { 5838, 4, "0", "", "Shrine of Aviana" },
}
points[ 241 ] = { -- Twilight Highlands
	[60365825] = { 5837, 5, "0", "The village is under attack but the dwarves\n"
									.."saved their blessed tavern. Priorities!", "Firebeard's Patrol" },
	[78877780] = { 5837, 6, "0", "Regardless of quest phase, you'll be okay for the candy bucket.\n"
									.."From the entrance straight to the courtyard. Right then left. ", "Highbank" },
	[49603036] = { 5837, 7, "0", "The building with the mailbox.", "Thundermar" },
	[43505727] = { 5837, 8, "0", "", "Victor's Point" },
	[53404284] = { 5838, 5, "0", "Ground floor, main building", "Bloodgulch" },
	[45127681] = { 5838, 6, "0", "Inside the only building", "Crushblow" },
	[75411653] = { 5838, 7, "0", "Difficult to describe - trust in the coordinates please!\n"
									.."Or... just look for the apple bobbing tub at the doorway!", "The Krazzworks" },
}
points[ 249 ] = { -- Uldum
	[26590722] = { 5837, 9, "0", "Why not grab the cool Springfur Alpaca mount while you're here!\n"
									.."You guessed it, sigh. I've an AddOn for that too! :)", "Oasis of Vir'sar" },
	[54682999] = { 5837, 10, "0", "Zidormi is nearby if things seem a bit weird.\nGo right into "
									.."the inn. It's on the left.", "Ramkahen" },
	[26590726] = { 5838, 8, "0", "Why not grab the cool Springfur Alpaca mount while you're here!\n"
									.."You guessed it, sigh. I've an AddOn for that too! :)", "Oasis of Vir'sar" },
	[54683301] = { 5838, 9, "0", "Zidormi is nearby if things seem a bit weird.\nGo right into "
									.."the inn. It's on the left.", "Ramkahen" },
}
points[ 204 ] = { -- Abyssal Depths in Vashj'ir
	[61897915] = { 5837, 11, "0", "Inside Darkbreak Cove. Dive straight down. The icon marks the entrance.\n"
									.."The cave may appear empty, Give the art assets time to appear.", "" },
	[94867350] = { 5838, 11, "0", "Inside Legion's Rest. Dive straight down. The icon marks the entrance" },
	[60005670] = { 5838, 13, "0", "Inside Tenebrous Cove. Dive straight down. The icon marks the entrance", "" },
}
points[ 201 ] = { -- Kelp'thar Forest in Vashj'ir
	[60686609] = { 5837, 12, "0", "Inside Deepmist Grotto. Dive straight down. The icon marks the entrance", "" },
	[60686610] = { 5838, 10, "0", "Inside Deepmist Grotto. Dive straight down. The icon marks the entrance", "" },
}
points[ 205 ] = { -- Shimmering Expanse in Vashj'ir
	[20007114] = { 5837, 11, "0", "Inside Darkbreak Cove. Dive straight down. The icon marks the entrance.\n"
									.."The cave may appear empty, Give the art assets time to appear.", "" },
	[68261539] = { 5837, 12, "0", "Inside Deepmist Grotto. Dive straight down. The icon marks the entrance", "" },
	[51564153] = { 5837, 13, "0", "Inside Silver Tide Hollow. Dive straight down. The icon marks the entrance", "" },
	[45025707] = { 5837, 14, "0", "Inside the Tranquil Wash. Dive straight down. The icon marks the entrance", "" },
	[68261540] = { 5838, 10, "0", "Inside Deepmist Grotto. Dive straight down. The icon marks the entrance", " " },
	[47706640] = { 5838, 11, "0", "Inside Legion's Rest. Dive straight down. The icon marks the entrance" },
	[51564155] = { 5838, 12, "0", "Inside Silver Tide Hollow. Dive straight down. The icon marks the entrance", "" },
	[18415228] = { 5838, 13, "0", "Inside Tenebrous Cove. Dive straight down. The icon marks the entrance", "" },
}
points[ 203 ] = { -- Vashj'ir
	[43817203] = { 5837, 11, "0", "Inside Darkbreak Cove. Dive straight down. The icon marks the entrance.\n"
									.."The cave may appear empty, Give the art assets time to appear.", "" },
	[77513310] = { 5837, 12, "0", "Inside Deepmist Grotto. Dive straight down. The icon marks the entrance", "" },
	[65845135] = { 5837, 13, "0", "Inside Silver Tide Hollow. Dive straight down. The icon marks the entrance", "" },
	[61286220] = { 5837, 14, "0", "Inside the Tranquil Wash. Dive straight down. The icon marks the entrance", "" },
	[77513311] = { 5838, 10, "0", "Inside Deepmist Grotto. Dive straight down. The icon marks the entrance", "" },
	[63156871] = { 5838, 11, "0", "Inside Legion's Rest. Dive straight down. The icon marks the entrance" },
	[65855137] = { 5838, 12, "0", "Inside Silver Tide Hollow. Dive straight down. The icon marks the entrance", " " },
	[42705886] = { 5838, 13, "0", "Inside Tenebrous Cove. Dive straight down. The icon marks the entrance", "" },
}
points[ 948 ] = { -- The Maelstrom
	[50002900] = { 5837, 1, "0", "Access via the Cataclysm portal cluster in Stormwind.", "Temple of Earth" },
	[50002901] = { 5838, 1, "0", "Access via the Cataclysm portal cluster in Orgrimmar.", "Temple of Earth" },
}

-- =================================
-- Tricks and Treats of the Pandaria
-- =================================
-- 7601 = Alliance
-- 7602 = Horde

points[ 422 ] = { -- Dread Wastes
	[55933227] = { 7601, 1, "0", "", "Klaxxi'vess" },
	[55217119] = { 7601, 2, "0", "Inside The Chum Bucket Inn", "Soggy's Gamble" },
	[55933229] = { 7602, 1, "0", "", "Klaxxi'vess" },
	[55217121] = { 7602, 2, "0", "Inside The Chum Bucket Inn", "Soggy's Gamble" },
}
points[ 371 ] = { -- The Jade Forest
	[45774360] = { 7601, 3, "0", "Inside The Drunken Hozen Inn", "Dawn's Blossom" },
	[48093462] = { 7601, 4, "0", "", "Greenstone Village" },
	[54606333] = { 7601, 5, "0", "Inside The Dancing Serpent Inn", "Jade Temple Grounds" },
	[44818437] = { 7601, 6, "0", "First visit to Pandaria? Always grab those flight points!", "Paw'don Village" },
	[59568324] = { 7601, 7, "0", "", "Pearlfin Village" },
	[55712441] = { 7601, 8, "0", "Yeah... it's inside the Inn!", "Sri-La Village" },
	[41682313] = { 7601, 9, "0", "Inside Paur's Pub", "Tian Monastery" },
	[45774361] = { 7602, 3, "0", "Inside The Drunken Hozen Inn", "Dawn's Blossom" },
	[48093463] = { 7602, 4, "0", "", "Greenstone Village" },
	[28024738] = { 7602, 5, "0", "The candy bucket is present even if you have\nnot yet made the Grookin friendly.", "Grookin Hill" },
	[28451327] = { 7602, 6, "0", "", "Honeydew Village" },
	[54606334] = { 7602, 7, "0", "Inside The Dancing Serpent Inn", "Jade Temple Grounds" },
	[55712440] = { 7602, 8, "0", "Yeah... it's inside the Inn!", "Sri-La Village" },
	[41692315] = { 7602, 9, "0", "Inside Paur's Pub", "Tian Monastery" },
	[23326072] = { 7601, 17, "0", "Tavern in the Mists", "" },
	[23326074] = { 7602, 19, "0", "Tavern in the Mists", "" },
}
points[ 418 ] = { -- Krasarang Wilds
	[51407728] = { 7601, 10, "0", "The \"Bait and Brew\". Pretty much the only building", "Marista" },
	[75920686] = { 7601, 11, "0", "In the Wilds' Edge Inn", "Zhu's Watch" },
	[28255070] = { 7602, 10, "0", "", "Dawnchaser Retreat" },
	[51417730] = { 7602, 11, "0", "The \"Bait and Brew\". Pretty much the only building", "Marista" },
	[61002510] = { 7602, 12, "0", "", "Thunder Cleft" },
	[75920688] = { 7602, 13, "0", "In the Wilds' Edge Inn", "Zhu's Watch" },
}

points[ 379 ] = { -- Kun-Lai Summit
	[72729229] = { 7601, 12, "0", "Inside the Binan Brew and Chunder Inn", "Binan Village" },
	[64206127] = { 7601, 13, "0", "Inside The Two Fisted Brew", "The Grummle Bazaar" },
	[57455995] = { 7601, 14, "0", "Inside The Lucky Traveller", "One Keg" },
	[54078281] = { 7601, 15, "0", "Phasing issue here. Go to Binan Village. Complete \"Hit Medicine\",\n"
									.."\"Call Out Their Leader\", \"All of the Arrows\". Then complete\n"
									.."\"Admiral Taylor...\" from Apothecary Cheng. Then complete\n\"Westwind"
									.." Rest\" by heading over towards Westwind. Finally\n"
									.."complete \"Challenge Accepted\" from Elder Tsulan.\n"
									.."Voilà - unlocked!", "Westwind Rest" },
	[62502901] = { 7601, 16, "0", "Inside the North Wind Tavern. Right near the Flight Master", "Zouchin Village" },
	[72749227] = { 7602, 14, "0", "Inside the Binan Brew and Chunder Inn", "Binan Village" },
	[62778050] = { 7602, 15, "0", "Phasing issue here. Go to Binan Village. Complete \"Hit Medicine\",\n"
									.."\"Call Out Their Leader\", \"All of the Arrows\". Then complete\n"
									.."\"General Nazgrim...\" from Apothecary Cheng. Then complete\n\"Eastwind"
									.." Rest\" by heading over towards Eastwind. Finally\n"
									.."complete \"Challenge Accepted\" from Elder Shiao.\n"
									.."Voilà - unlocked!", "Eastwind Rest" },
	[64226128] = { 7602, 16, "0", "Inside The Two Fisted Brew", "The Grummle Bazaar" },
	[57455994] = { 7602, 17, "0", "Inside The Lucky Traveller", "One Keg" },
	[62502900] = { 7602, 18, "0", "Inside the North Wind Tavern. Right near the Flight Master", "Zouchin Village" },
}
points[ 433 ] = { -- The Veiled Stair, Tavern in the Mists
	[55117223] = { 7601, 17, "0", "Taraezor has lots of handy \"HandyNotes\" AddOns!", "" },
	[55117225] = { 7602, 19, "0", "Taraezor has lots of handy \"HandyNotes\" AddOns!", "" },
}
points[ 388 ] = { -- Townlong Steppes, Longying Outpost
	[71135777] = { 7601, 18, "0", "Don't forget to make a quick macro as follows:\n"
					.."#showtooltip Handful of Treats\n/use Handful of Treats", "" },
	[71145779] = { 7602, 20, "0", "Don't forget to make a quick macro as follows:\n"
					.."#showtooltip Handful of Treats\n/use Handful of Treats", "" },
}
points[ 390 ] = { -- Vale of Eternal Blossoms
	[35147776] = { 7601, 19, "0", "In The Golden Rose inn", "Mistfall Village" },
	[87036900] = { 7601, 20, "0", "In the Golden Lantern inn.\nThe inn is on the "
									.."right side of the Shrine's entrance", "" },
	[35127781] = { 7602, 21, "0", "In The Golden Rose inn", "Mistfall Village" },
	[61981626] = { 7602, 22, "0", "From the main entrance go up the stairs on the right side.\n"
									.."Go through each room until you arrive at the balcony /\n"
									.."mezzanine of The Keggary.", "Shrine of Two Moons", "Shrine of Two Moons" },
}
points[ 393 ] = { -- Shrine of the Seven Stars
	[37856590] = { 7601, 20, "0", "In the Golden Lantern inn.\nThe inn is on the "
									.."right side of the Shrine's entrance", "" },
}
points[ 392 ] = { -- The Imperial Mercantile
	[58877836] = { 7602, 22, "0", "From the main entrance go up the stairs on the right side.\n"
									.."Go through each room until you arrive at the balcony /\n"
									.."mezzanine of The Keggary.", "Shrine of Two Moons" },
}
points[ 376 ] = { -- Valley of the Four Winds
	[83642013] = { 7601, 21, "0", "Hey, you know that you can change the icons?\n"
									.."ESC->Interface->AddOns->HandyNotes->Plugins expand->Hallow's End", "Pang's Stead" },
	[19875578] = { 7601, 22, "0", "Yeah.. another inn... The Stone Mug Tavern", "Stoneplow" },
	[83642015] = { 7602, 23, "0", "Hey, you know that you can change the icons?\n"
									.."ESC->Interface->AddOns->HandyNotes->Plugins expand->Hallow's End", "Pang's Stead" },
	[19885577] = { 7602, 24, "0", "Yeah.. another inn... The Stone Mug Tavern", "Stoneplow" },
	[72751031] = { 7601, 17, "0", "Tavern in the Mists", "" },
	[72751033] = { 7602, 19, "0", "Tavern in the Mists", "" },
}

-- ==========
-- Miscellany
-- ==========

-- -1 = Alliance
-- -2 = Neutral
-- -3 - Horde

local draenor = "You must have a Tier 3 Town Hall or else the Candy Bucket\n"
					.."will not be present. Orukan has four dailies and Izzy\n"
					.."Hollyfizzle sells Garrison decorations, purchasable only\n"
					.."with the daily rewards."

points[ 582 ] = { -- Lunarfall Garrison in Draenor
	[43515151] = { -1, 39657, "Draenor / Lunarfall Garrison", draenor },
}
points[ 539 ] = { -- Shadowmoon Valley in Draenor
	[30011780] = { -1, 39657, "Draenor / Lunarfall Garrison", draenor },
}
points[ 590 ] = { -- Frostwall Garrison in Draenor
	[46993759] = { -3, 39657, "Draenor / Frostwall Garrison", draenor },
}
points[ 525 ] = { -- Frostfire Ridge in Draenor
	[48256435] = { -3, 39657, "Draenor / Frostwall Garrison", draenor },
}
points[ 572 ] = { -- Draenor
	[52516153] = { -1, 39657, "Draenor / Lunarfall Garrison", draenor },
	[33793642] = { -3, 39657, "Draenor / Frostwall Garrison", draenor },
}

points[ 1163 ] = { -- Dazar'alor - The Great Seal
	[49828478] = { -3, 54709, "Zuldazar", "In \"The Great Seal\" in Dazar'alor." },
}
points[ 1164 ] = { -- Dazar'alor - The Hall of Chroniclers
	[49828478] = { -3, 54709, "Zuldazar", "In \"The Great Seal\" in Dazar'alor." },
}
points[ 1165 ] = { -- Dazar'alor
	[50014684] = { -3, 54709, "Zuldazar", "In \"The Great Seal\" in Dazar'alor." },
}
points[ 862 ] = { -- Zuldazar
	[57984468] = { -3, 54709, "Zuldazar", "In \"The Great Seal\" in Dazar'alor." },
}
points[ 875 ] = { -- Zandalar
	[57996226] = { -3, 54709, "Zuldazar", "In \"The Great Seal\" in Dazar'alor." },
}
points[ 1161 ] = { -- Boralus - Tiragarde Sound
	[73701219] = { -1, 54710, "Boralus Harbor", "In the \"Snug Harbor Inn\"." },
}
points[ 895 ] = { -- Tiragarde Sound
	[75182272] = { -1, 54710, "Boralus Harbor", "In the \"Snug Harbor Inn\"." },
}
points[ 876 ] = { -- Kul Tiras
	[61884907] = { -1, 54710, "Boralus Harbor", "In the \"Snug Harbor Inn\"." },
}

points[ 627 ] = { -- Dalaran Broken Isles
	[41476398] = { -1, 43056, "Dalaran Broken Isles", "In \"A Hero's Welcome\" inn." },
	[47964178] = { -2, 43055, "Dalaran Broken Isles", "In The Legerdemain Lounge." },
	[47294077] = { -2, 43259, "Beware of the Crooked Tree", "Speak to Duroc Ironjaw. "
								.."This is a simple \"fly to X\" quest\nbut with very "
								.."worthwhile XP, especially for a trivial flight.\n"
								.."The quest that follows is devilishly difficult and "
								.."is not\nrecommended. Just hearth/fly back to Dalaran." },
	[67042941] = { -3, 43057, "Dalaran Broken Isles", "In \"The Filthy Animal\" inn." },
	[59174564] = { 291, 0, "", "Just stand here with a cuppa and wait. Couldn't be easier." },
}
points[ 619 ] = { -- Broken Isles
	[45486527] = { -1, 43056, "Dalaran Broken Isles", "In \"A Hero's Welcome\" inn." },
	[45776429] = { -2, 43055, "Dalaran Broken Isles", "In The Legerdemain Lounge.\n\n"
								.."There's another quest too, once you arrive." },
	[46606375] = { -3, 43057, "Dalaran Broken Isles", "In \"The Filthy Animal\" inn." },
	[46266446] = { 291, 0, "", "Just stand here with a cuppa and wait. Couldn't be easier." },
}

-- Azeroth - a Mixed Bag

points[ 947 ] = { -- Azeroth
	[73594850] = { -1, 54710, "Boralus Harbor", "In the \"Snug Harbor Inn\"." },
	[55776535] = { -3, 54709, "Zuldazar", "In \"The Great Seal\" in Dazar'alor." },
	[58504609] = { -1, 43056, "Dalaran Broken Isles", "In \"A Hero's Welcome\" inn." },
	[58564587] = { -2, 43055, "Dalaran Broken Isles", "In The Legerdemain Lounge.\n\n"
								.."There's another quest plus the \"Check Your Head\" achievement." },
	[58754575] = { -3, 43057, "Dalaran Broken Isles", "In \"The Filthy Animal\" inn." },
	[45194849] = { 5837, 1, "0", "Access via the Cataclysm portal cluster in Stormwind.", "Temple of Earth" },
	[45194851] = { 5838, 1, "0", "Access via the Cataclysm portal cluster in Orgrimmar.", "Temple of Earth" },
}

-- Choice of texture
-- Note that these textures are all repurposed and as such have non-uniform sizing. I've copied my scaling factors from my old AddOn
-- in order to homogenise the sizes. I should also allow for non-uniform origin placement as well as adjust the x,y offsets
texturesL[1] = "Interface\\PlayerFrame\\MonkLightPower"
texturesL[2] = "Interface\\PlayerFrame\\MonkDarkPower"
texturesL[3] = "Interface\\Common\\Indicator-Red"
texturesL[4] = "Interface\\Common\\Indicator-Yellow"
texturesL[5] = "Interface\\Common\\Indicator-Green"
texturesL[6] = "Interface\\Common\\Indicator-Gray"
texturesL[7] = "Interface\\Common\\Friendship-ManaOrb"	
texturesL[8] = "Interface\\TargetingFrame\\UI-PhasingIcon"
texturesL[9] = "Interface\\Store\\Category-icon-pets"
texturesL[10] = "Interface\\Store\\Category-icon-featured"
texturesL[11] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\AzerothCandySwirl"
texturesL[12] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\Pumpkin"
texturesL[13] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\EvilPumpkin"
texturesL[14] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\HalloweenBat"
texturesL[15] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\HalloweenCat"
texturesL[16] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\HalloweenGhost"
texturesL[17] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\HalloweenWitch"
texturesS[1] = "Interface\\Common\\RingBorder"
texturesS[2] = "Interface\\PlayerFrame\\DeathKnight-Energize-Blood"
texturesS[3] = "Interface\\PlayerFrame\\DeathKnight-Energize-Frost"
texturesS[4] = "Interface\\PlayerFrame\\DeathKnight-Energize-Unholy"
texturesS[5] = "Interface\\PetBattles\\DeadPetIcon"
texturesS[6] = "Interface\\RaidFrame\\UI-RaidFrame-Threat"
texturesS[7] = "Interface\\PlayerFrame\\UI-PlayerFrame-DeathKnight-Frost"
texturesS[8] = "Interface\\HelpFrame\\HelpIcon-CharacterStuck"	
texturesS[9] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\AzerothCandySwirl"
texturesS[10] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\Pumpkin"
texturesS[11] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\EvilPumpkin"
texturesS[12] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\HalloweenBat"
texturesS[13] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\HalloweenCat"
texturesS[14] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\HalloweenGhost"
texturesS[15] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\HalloweenWitch"

scalingL[1] = 0.85
scalingL[2] = 0.85
scalingL[3] = 0.83
scalingL[4] = 0.83
scalingL[5] = 0.83
scalingL[6] = 0.83
scalingL[7] = 0.95
scalingL[8] = 0.95
scalingL[9] = 1.2
scalingL[10] = 1.2
scalingL[11] = 0.75
scalingL[12] = 0.75
scalingL[13] = 0.75
scalingL[14] = 0.75
scalingL[15] = 0.75
scalingL[16] = 0.75
scalingL[17] = 0.75
scalingS[1] = 0.58
scalingS[2] = 0.77
scalingS[3] = 0.77
scalingS[4] = 0.77
scalingS[5] = 0.68
scalingS[6] = 0.65
scalingS[7] = 0.62
scalingS[8] = 0.93
scalingS[9] = 0.75
scalingS[10] = 0.75
scalingS[11] = 0.75
scalingS[12] = 0.75
scalingS[13] = 0.75
scalingS[14] = 0.75
scalingS[15] = 0.75

