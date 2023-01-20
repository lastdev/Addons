local _, ns = ...
local points = ns.points
local texturesL = ns.texturesL
local scalingL = ns.scalingL
local texturesS = ns.texturesS
local scalingS = ns.scalingS

--[[
Format
======
A	I	Q	Tip		Achievement A with criteria I and seasonal quest Q
A	I	-Q	Tip		Achievement but the quest is a daily too
A	-	0	Tip		Achievement with no relevant criteria
A/N/H	Title	0	Tip		Something not achievement or quest related but which needs to be on a map
A/N/H	Title	Q	Tip		Seasonal quest with Title and whether Neutral/Alliance/Horde
A/N/H	Title	-Q	Tip		Daily quest

(Any 5th field was going to be a title field but decided to use API data.
I mostly retained it to assist in readability)
]]

-- =============================
-- Tricks and Treats of Kalimdor
-- =============================
-- 963 = Alliance
-- 965 = Horde

points[ 97 ] = { -- Azuremyst Isle
	[48494905] = { 963, 2, 12333, "", "Azure Watch" },
	[30322500] = { 963, 9, 12337, "", "Seat of the Naaru" },
}
points[ 106 ] = { -- Bloodmyst Isle
	[55695997] = { 963, 3, 12341, "", "Blood Watch" },
}
points[ 63 ] = { -- Ashenvale
	[37014926] = { 963, 1, 12345, "Your quest phase does not matter - the bucket is always available.", "Astranaar" },
	[38664234] = { 965, 1, 28958, "Outside, easy to see", "Hellscream's Watch" },
	[50256727] = { 965, 2, 28953, "", "Silverwind Refuge" },
	[73966060] = { 965, 3, 12377, "Follow the map marker for the correct building", "Splintertree Post" },
	[13003410] = { 965, 4, 28989, "", "Zoram'gar Outpost" },
}
points[ 76 ] = { -- Azshara
	[57115017] = { 965, 5, 28992, "Exclusive Taraezor tip! Pause to check your map while you are\n"
                                    .."inside the inn next to the candy bucket. You want to stretch\n"
									.."that rested bonus for as long as possible!", "Bilgewater Harbor" },
}
points[ 62 ] = { -- Darkshore
	[50791890] = { 963, 4, 28951, "Exclusive Taraezor tip! Pause to check your map while you are\n"
                                    .."inside the inn next to the candy bucket. You want to stretch\n"
									.."that rested bonus for as long as possible!", "Lor'danel" },
}
local teldrassil = "Speak to Zidormi in Darkshore if Teldrassil seems somewhat destroyed!"
points[ 89 ] = { -- Darnassus
	[62283315] = { 963, 5, 12334, teldrassil, "Craftsmen's Terrace" },
}
points[ 66 ] = { -- Desolace
	[56725010] = { 963, 6, 28993, "", "Karnum's Glade" },
	[66330659] = { 963, 7, 12348, "", "Nigel's Point" },
	[56725014] = { 965, 6, 28993, "", "Karnum's Glade" },
	[24076829] = { 965, 7, 12381, "", "Shadowprey Village" },
}
points[ 1 ] = { -- Durotar
	[51544158] = { 965, 8, 12361, "", "Razor Hill" },
	[46940672] = { 965, 20, 12366, "", "Valley of Strength" },
}
points[ 70 ] = { -- Dustwallow Marsh
		-- Due to the more extreme scaling of the map the Alliance Mudsprocket will be overwritten
		-- by the Horde version of this data with regards to the continent map. Rather than
		-- compromise the coordinate integrity I'll just hack an Alliance version onto the continent
	[41857408] = { 963, 8, 12398, "Upstairs, inside the main hut", "Mudsprocket" },
	[36783244] = { 965, 9, 12383, "", "Brackenwall Village" },
	[41867409] = { 965, 10, 12398, "Upstairs, inside the main hut", "Mudsprocket" }, -- Best coords
	[66604528] = { "A", "Theramore (Old)", 12349, "Inside the inn. You may need to speak to Zidormi.\n"
								.."Note: Zidormi is automatically marked on your map if\n"
								.."you have completed the \"Theramore's Fall\" scenario.\n"
								.."If you have not completed the scenario then there is\n"
								.."no need for her and she will offer no time shifting." },
}
points[ 103 ] = { -- The Exodar
	[59241848] = { 963, 9, 12337, "", "Seat of the Naaru" },
}
points[ 77 ] = { -- Felwood
	[61862671] = { 963, 10, 28995, "Ever wanted to experiment with \"Particle Density\" in\n"
									.."System->Graphics->Advanced? Stand at the entrance and\n"
									.."look towards the candy bucket!", "Talonbranch Glade" },
	[44572897] = { 963, 11, 28994, "There's space inside the inn, as usual, for the candy bucket yet...\n"
									.."it's placed on the landing outside. Unusual! Spooky?", "Whisperwind Grove" },
	[44592901] = { 965, 11, 28994, "There's space inside the inn, as usual, for the candy bucket yet...\n"
									.."it's placed on the landing outside. Unusual! Spooky?", "Whisperwind Grove" },
}
points[ 69 ] = { -- Feralas
	[51071782] = { 963, 12, 28952, "", "Dreamer's Rest" },
	[46334519] = { 963, 13, 12350, "", "Feathemoon Stronghold" },
	[41451568] = { 965, 12, 28996, "", "Camp Ataya" },
	[74834514] = { 965, 13, 12386, "", "Camp Mojache" },
	[51974764] = { 965, 14, 28998, "", "Stonemaul Hold" },
}
points[ 7 ] = { -- Mulgore
	[46796041] = { 965, 15, 12362, "", "Bloodhoof Village" },
	[39703118] = { 965, 28, 12367, "Inside \"The Cat and the Shaman\" inn.", "Lower Rise" },
}
points[ 10 ] = { -- Northern Barrens
	[67347465] = { 963, 14, 12396, "Grab a Leaping Hatchling pet from nearby... oh yeah, did I mention that I\n"
									.."have an AddOn for that too? Collect all four of the adorable raptor pets!", "Ratchet" },
	[49515791] = { 965, 16, 12374, "Main building. It's the inn. De rigueur", "The Crossroads" },
	[56214003] = { 965, 17, 29002, "", "Grol'dom Farm" },
	[62511660] = { 965, 18, 29003, "Grab a Leaping Hatchling pet from nearby... oh yeah, did I mention that I\n"
									.."have an AddOn for that too? Collect all four of the adorable raptor pets!", "Nozzlepot's Outpost" },
	[67347467] = { 965, 19, 12396, "", "Ratchet" },
}
points[ 85 ] = { -- Orgrimmar
	[53937894] = { 965, 20, 12366, "", "Valley of Strength" },
	[50843631] = { 5838, 1, 29019, "Through this portal for the Deepholm candy bucket.\n"
									.."A Vashj'ir portal is closeby too!", "Temple of Earth" },
}
points[ 81 ] = { -- Silithus
	[55473678] = { 963, 15, 12401, "In the Oasis inn, below the Flight Masters." },
	[55473679] = { 965, 21, 12401, "In the Oasis inn, below the Flight Masters." }, -- Best coords
}
points[ 199 ] = { -- Southern Barrens
	[49046851] = { 963, 16, 29008, "Another candy bucket that's not in a building. Hooray!", "Fort Triumph" },
	[39021099] = { 963, 17, 29006, "It's out in the open.", "Honor's Stand" },
	[65604654] = { 963, 18, 29007, "To the south, just across the border into Dustwallow Marsh.\n"
									.."is an adorable and oh so cute raptor hatchling pet, one of\n"
									.."a set of four. Why not \"dart\" over and grab it now!", "Northwatch Hold" },
	[40706931] = { 965, 22, 29005, "", "Desolation Hold" },
	[39292009] = { 965, 23, 29004, "", "Hunter's Hill" },
}
points[ 65 ] = { -- Stonetalon Mountains
	[31536066] = { 963, 19, 29013, "Another open air Elven inn - fly right in!", "Farwatcher's Glen" },
	[71027908] = { 963, 20, 29010, "", "Northwatch Expedition Base" },
	[39483281] = { 963, 21, 29012, "", "Thal'darah Overlook" },
	[59045632] = { 963, 22, 29011, "Fallowmere Inn", "Windshear Hold" },
	[66506419] = { 965, 24, 29009, "Inside the smallest building.", "Krom'gar Fortress" },
	[50376379] = { 965, 25, 12378, "Alchemy completionists will want the Fire Protection potion\n"
									.."from Jeeda upstaits. Good luck!", "Sun Rock Retreat" },
	[40531769] = { "A", "Stonetalon Peak", 12347, "Nearby hostile mob is level 30 (max. zone level)." },
}
points[ 71 ] = { -- Tanaris
	[55706095] = { 963, 23, 29014, "", "Bootlegger Outpost" },
	[52562709] = { 963, 24, 12399, "Did you stock up on Noggenfogger while you are here?\n"
								.."Oh yeah, the candy bucket is inside \"The Road Warrior\" inn", "Gadgetzan" },
	[55706097] = { 965, 26, 29014, "", "Bootlegger Outpost" },
	[52562710] = { 965, 27, 12399, "Did you stock up on Noggenfogger while you are here?\n" -- Best coords
								.."Oh yeah, the candy bucket is inside \"The Road Warrior\" inn", "Gadgetzan" },
}
points[ 57 ] = { -- Teldrassil
	[55365229] = { 963, 25, 12331, teldrassil, "Dolanaar" },
	[34164401] = { 963, 5, 12334, teldrassil, "Craftsmen's Terrace" },
}
points[ 88 ] = { -- Thunder Bluff
	[45626493] = { 965, 28, 12367, "Inside \"The Cat and the Shaman\" inn.", "Lower Rise" },
}
points[ 78 ] = { -- Un'Goro Crater
	[55266219] = { 963, 26, 29018, "Did you get your awesome Venomhide Ravasaur mount while you were here?\n"
								.."Oh wait... you're Alliance. Oh well.", "Marshal's Stand" },
	[55266213] = { 965, 29, 29018, "Did you get your awesome Venomhide Ravasaur mount while you were here?", "Marshal's Stand" },
}
points[ 83 ] = { -- Winterspring
	[59835119] = { 963, 27, 12400, "Grab a Winterspring Cub pet from Michelle De Rum who is\n"
                                    .."standing near the candy bucket. Awwww... so cute!\n"
									.."Don't forget the Mount Hyjal locations too!", "Everlook" },
	[59835123] = { 965, 30, 12400, "Grab a Winterspring Cub pet from Michelle De Rum who is\n"
                                    .."standing near the candy bucket. Awwww... so cute!\n"
									.."Don't forget the Mount Hyjal locations too!", "Everlook" },
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
	[40064909] = { 966, 1, 28954, "If you cannot see the candy bucket then you'll\n"
									.."need to visit Zidormi. I marked her on the map.", "Refuge Point" },
	[38259009] = { 966, 1, 28954, "Zidormi is at this location. You'll probably\n"
									.."need her for the Refuge Point candy bucket.", "Refuge Point" },
	[69023327] = { 967, 1, 12380, "Well if it's not outside then it must be...", "Hammerfall" },
}
points[ 15 ] = { -- Badlands
	[20875632] = { 966, 2, 28956, "", "Dragon's Mouth" },
	[65853564] = { 966, 3, 28955, "The apple bobbing tub is outside, the pumpkin is inside", "Fuselight" },
	[65853566] = { 967, 2, 28955, "The apple bobbing tub is outside, the pumpkin is inside", "Fuselight" },
	[18354273] = { 967, 3, 28957, "", "New Kargath" },
}
points[ 17 ] = { -- Blasted Lands
	[60691407] = { 966, 4, 28960, "Erm... mobs looking a bit too red, a bit too hostile for your\n"
									.."liking? That'll be Zidormi you'll be needing. She's nearby.\n"
									.."The correct building is the one on the left of the main gate.\n"
									.."When you enter, turn right and then left. Voilà!", "Nethergarde Keep" },
	[44348759] = { 966, 5, 28961, "Hey, fun trivia... see Garrod's house nearby? You\n"
									.."won't get dismounted - you can fly around inside!\n"
									.."Oh yeah... Zidormi is not required for Surwich!", "Surwich" },
	[40471129] = { 967, 4, 28959, "If the guards are hostile... It's a Zidormi problem, sigh. She'd just nearby!", "Dreadmaul Hold" },
}
points[ 210 ] = { -- The Cape of Stranglethorn
	[40917371] = { 966, 6, 12397, "It's in the Salty Sailor Tavern" },
	[40917373] = { 967, 5, 12397, "It's in the Salty Sailor Tavern" },
	[35042722] = { 967, 6, 28969, "It's in the building next to the apple bobbing tub", "Hardwrench Hideaway" },
}
points[ 27 ] = { -- Dun Morogh
	[54495076] = { 966, 7, 12332, "Inside the Thunderbrew Distillery at the eating area." },
	[61172746] = { 966, 13, 12335, "Inside the Stonefire Tavern in The Commons" },
}
points[ 47 ] = { -- Duskwood
	[73804425] = { 966, 8, 12344, "" },
}
points[ 1431 ] = { -- Duskwood
	[73804425] = { 966, 8, 12344, "" },
}
points[ 23 ] = { -- Eastern Plaguelands
	[75575230] = { 966, 9, 12402, "" },
	[75575232] = { 967, 7, 12402, "Use a taxi between Light's Hope Chapel and Tranquillien." },
}
points[ 24 ] = { -- Light's Hope Chapel - Sanctum of Light
	[40709035] = { 966, 9, 12402, "" },
	[40709037] = { 967, 7, 12402, "" },
}
points[ 37 ] = { -- Elwynn Forest
	[43746589] = { 966, 10, 12286, "", "Elwynn Forest" },
	[24894013] = { 966, 19, 12336, "", "" },
	[32355088] = { 1040, 1, -29054, "Pickup the quest here from Gretchen Fenlow and\n"
									.."then your broomstick taxi from Gertrude Fenlow,\n"
									.."who is nearby. Soon after completion you could\n"
									.."consider logging out. You will respawn at the Scarlet\n"
									.."Watchtower in Tirisfal Glades. This will save a lot\n"
									.."of time if you also intend doing \"A Time to Lose\".", "" },									
	[29694442] = { 1040, 2, -29144, "Pickup the quest from Gretchen Fenlow who is just outside\n"
									.."the Stormwind gates. To see the orange plumes you must\n"
									.."have \"Particle Density\" at least minimally enabled. Go to\n"
									.."System->Graphics->Effects. If you get debuffed then you\n"
									.."may cleanse yourself. Shapeshifting also works.", "" },
	[32095059] = { 1040, 4, -29371, "Pickup the quest here from Keira. See my travel notes for\n"
									.."the quest \"Stink Bombs Away\". Take extra care as you\n"
									.."will have no ground/structure cover. My approach is to\n"
									.."fly in from very high and then plummet straight down.", "" },
	[22133396] = { 1041, 1, -29374, "If you logout while in Stormwind you'll respawn nearby.\n"
									.."Handy for doing \"A Time to Break Down\".", "" },
	[34104740] = { 1041, 4, -29377, "The location of the Alliance Wickerman.\n"
									.."Approach from due east. Use the large tree and the ledge\n"
									.."as cover. Stay away from the wall to avoid zoning out and\n"
									.."adding to phasing problems. Reports suggest activating\n"
									.."Warmode in Orgrimmar will help in that respect. Do NOT\n"
									.."try to target the Wickerman. Stand near it and click on\n"
									.."your Dousing Agent. Immediately mount and hit \"space\"\n"
									.."to fly straight up.", "" },
	[31241227] = { 5837, 1, 29020, "Through this portal for the Deepholm candy bucket.\n"
									.."A Vashj'ir portal is closeby too!", "Temple of Earth" },
}
points[ 1229 ] = { -- Elwynn Forest
	[43746589] = { 966, 10, 12286, "" },
}
points[ 94 ] = { -- Eversong Woods
	[43707103] = { 967, 8, 12365, "Use a taxi between Fairbreeze Village and Tranquillien.", "Fairbreeze Village" },
	[48204788] = { 967, 9, 12364, "Go through the \"blue\" doorway", "Falconwing Square" },
	[55474495] = { 967, 17, 12370, "Wayfarer's Rest inn", "The Bazaar" },
	[59294137] = { 967, 18, 12369, "Silvermoon City Inn", "The Royal Exchange" },
}
points[ 95 ] = { -- Ghostlands
	[48683190] = { 967, 10, 12373, "Use a taxi between Light's Hope Chapel and Tranquillien.\n"
									.."Use a taxi between Fairbreeze Village and Tranquillien." },
}
points[ 25 ] = { -- Hillsbrad Foothills
	[60266374] = { 967, 11, 28962, "Hooray! It's outdoors and a no-brainer to find. Wooooo!", "Eastpoint Tower" },
	[57854727] = { 967, 12, 12376, "Identical building design as Andorhal. Follow the map marker please.", "Tarren Mill" },
}
points[ 26 ] = { -- The Hinterlands
	[14194460] = { 966, 11, 12351, "The lowest level hillside building.", "Aerie Peak" },
	[66164443] = { 966, 12, 28970, "", "Stormfeather Outpost" },
	[31805787] = { 967, 13, 28971, "", "Hiri'watha Research Station" },
	[78198147] = { 967, 14, 12387, "Inside the main (only) building", "Revantusk Village" },
}
points[ 87 ] = { -- Ironforge
	[18345094] = { 966, 13, 12335, "Inside the Stonefire Tavern in The Commons", "The Commons" },
}
points[ 48 ] = { -- Loch Modan
	[83036352] = { 966, 14, 28963, "", "Farstrider Lodge" },
	[35544850] = { 966, 15, 12339, "", "Thelsamar" },
}
points[ 50 ] = { -- Northern Stranglethorn
	[53166698] = { 966, 16, 28964, "", "Fort Livingston" },
	[37385178] = { 967, 15, 12382, "At the base of the zeppelin tower", "Grom'gol Base Camp" },
}
points[ 49 ] = { -- Redridge Mountains
	[26464150] = { 966, 17, 12342, "", "Lakeshire" },
}
points[ 49 ] = { -- Redridge Mountains
	[26464150] = { 966, 17, 12342, "", "Lakeshire" },
}
points[ 1433 ] = { -- Redridge Mountains
	[27094492] = { 966, 17, 12342, "", "Lakeshire" },
}
points[ 32 ] = { -- Searing Gorge
	[39486601] = { 966, 18, 28965, "Outside, high up on a perimiter ledge", "Iron Summit" },
	[39486603] = { 967, 16, 28965, "Outside, high up on a perimiter ledge", "Iron Summit" },
}
points[ 110 ] = { -- Silvermoon City
	[38008479] = { 967, 9, 12364, "Go through the \"blue\" doorway", "Falconwing Square" },
	[67597289] = { 967, 17, 12370, "Wayfarer's Rest inn", "" },
	[70357702] = { 967, 17, 12370, "Enter through here!", "" },
	[79435765] = { 967, 18, 12369, "Silvermoon City Inn", "" },
	[83125829] = { 967, 18, 12369, "Enter through here!", "" },
}
points[ 21 ] = { -- Silverpine Forest
	[44302029] = { 967, 19, 28966, "", "Forsaken Rear Guard" },
	[46454290] = { 967, 20, 12371, "In the largest building", "The Sepulcher" },
}
points[ 224 ] = { -- Stranglethorn Vale
	[52094310] = { 966, 16, 28964, "", "Fort Livingston" },
	[37897992] = { 966, 6, 12397, "It's in the Salty Sailor Tavern", "Booty Bay" },
	[42213359] = { 967, 15, 12382, "At the base of the zeppelin tower", "Grom'gol Base Camp" },
	[37897994] = { 967, 5, 12397, "It's in the Salty Sailor Tavern", "Booty Bay" },
	[34365192] = { 967, 6, 28969, "It's in the building next to the apple bobbing tub", "Hardwrench Hideaway" },
}
points[ 84 ] = { -- Stormwind City
	[60517534] = { 966, 19, 12336, "", "Stormwind City" },
	[75419681] = { 1040, 1, -29054, "Pickup the quest here from Gretchen Fenlow and\n"
									.."then your broomstick taxi from Gertrude Fenlow,\n"
									.."who is nearby. Soon after completion you could\n"
									.."consider logging out. You will respawn at the Scarlet\n"
									.."Watchtower in Tirisfal Glades. This will save a ton\n"
									.."of time if you also intend doing \"A Time to Lose\".", "" },									
	[70108390] = { 1040, 2, -29144, "Pickup the quest from Gretchen Fenlow who is just outside\n"
									.."the Stormwind gates. To see the orange plumes you must\n"
									.."have \"Particle Density\" at least minimally enabled. Go to\n"
									.."System->Graphics->Effects. If you get debuffed then you\n"
									.."may cleanse yourself. Shapeshifting also works.", "" },
	[74889624] = { 1040, 4, -29371, "Pickup the quest here from Keira. See my travel notes for\n"
									.."the quest \"Stink Bombs Away\". Take extra care as you\n"
									.."will have no ground/structure cover. My approach is to\n"
									.."fly in from very high and then plummet straight down.", "" },
	[55006300] = { 1041, 1, -29374, "If you logout while in Stormwind you'll respawn at the\n"
									.."Eastvale Logging Camp in Elwynn Forest. Handy for\n"
									.."doing \"A Time to Break Down\".", "" },
	[78918986] = { 1041, 4, -29377, "The location of the Alliance Wickerman.\n"
									.."Approach from due east. Use the large tree and the ledge\n"
									.."as cover. Stay away from the wall to avoid zoning out and\n"
									.."adding to phasing problems. Reports suggest activating\n"
									.."Warmode in Orgrimmar will help in that respect. Do NOT\n"
									.."try to target the Wickerman. Stand near it and click on\n"
									.."your Dousing Agent. Immediately mount and hit \"space\"\n"
									.."to fly straight up.", "" },
	[73191967] = { 5837, 1, 29020, "Through this portal for the Deepholm candy bucket.\n"
									.."A Vashj'ir portal is closeby too!", "Temple of Earth" },
}
points[ 51 ] = { -- Swamp of Sorrows
	[71651409] = { 966, 20, 28967, "", "Bogpaddle" },
	[28933240] = { 966, 21, 28968, "", "The Harborage" },
	[71651411] = { 967, 21, 28967, "", "Bogpaddle" },
	[46885692] = { 967, 22, 12384, "", "Stonard" },
}
points[ 18 ] = { -- Tirisfal Glades
	[62197300] = { 967, 25, 12368, "In Undercity, which is below the Ruins of Lordaeron", "The Trade Quarter" },
	[60955141] = { 967, 23, 12363, "Brill might work as your Hearth for this event for an alt. Quick\n"
                                    .."return from Elwynn after your dailies in Stormwind, plus the\n"
									.."zeppelin post gets me to Kalimdor and Northrend for my Tricks\n"
									.."and Treats circuit. Later I switch to Orgrimmar for Pandaria etc\n"
									.."T&T accessibility. Using Brill avoids the annoying portal from\n"
									.."Orgrimmar into Undercity.", "Brill" },
	[82987207] = { 967, 24, 28972, "", "The Bulwark" },	
	[62136702] = { 1041, 1, -29374, "Pickup the quest from Candace Fenlow, nearby, and\n"
									.."get your instant taxi from Crina Fenlow. Soon after\n"
									.."completion you could consider logging out. You will\n"
									.."respawn at the Eastvale Logging Camp graveyard in\n"
									.."Elwynn Forest. This will save a ton of time if you also\n"
									.."intend doing \"A Time to Break Down\".", "" },
	[62436671] = { 1041, 2, -29375, "Pickup the quest from Candace Fenlow. To see the orange\n"
									.."plumes you must have \"Particle Density\" at least\n"
									.."minimally enabled. Go to System->Graphics->Effects. If\n"
									.."you get debuffed then you may cleanse yourself.\n"
									.."Shapeshifting also works.", "" },
	[66606200] = { 1041, 2, -29375, "If things are not \"peaceful\" then do NOT attempt to\n"
									.."enter Lordaeron. Speak to Zidormi who is nearby.", "" },
	[62126783] = { 1041, 4, -29377, "Pickup the quest here from Darkcaller Yanks. See my travel\n"
									.."notes for the quest \"Stink Bombs Away\". Approach from\n"
									.."the east, hugging the terrain. A large tree will cover your\n"
									.."final approach.", "" },
	[61508110] = { 1040, 1, -29054, "If you logout while in Undercity you'll respawn nearby.\n"
									.."Handy for doing \"A Time to Lose\"", "" },
	[62406820] = { 1040, 4, -29371, "The location of the Horde Wickerman.\n"
									.."Approach from as high up as possible. Plummet down.\n"
									.."Land between the Wickerman and the wall, preferably\n"
									.."with a pillar providing a little cover. The pillar where\n"
									.."the green bubbling liquid begins is perfect. Do NOT\n"
									.."try to target the Wickerman. Stand near it and click\n"
									.."on your Dousing Agent. Immediately mount and hit\n"
									.."\"space\" to fly straight up.", "" },
}
points[ 90 ] = { -- Undercity
	[67753742] = { 967, 25, 12368, "", "The Trade Quarter" },
	[76503301] = { 1041, 2, -29375, "To see the orange plumes you must have \"Particle Density\"\n"
									.."at least minimally enabled via System->Graphics->Effects.", "" },
	[75703300] = { 1040, 1, -29054, "If you logout while in Undercity you'll respawn nearby.\n"
									.."Handy for doing \"A Time to Lose\".", "" },
	[76105320] = { 1040, 4, -29371, "Logout while in Undercity doing \"Stink Bombs "
									.."Away\"\nfor faster travelling back to Lordaeron.", "" },
}
points[ 22 ] = { -- Western Plaguelands
	[43388437] = { 966, 22, 28988, "", "Chillwind Camp" },
	[48286365] = { 967, 26, 28987, "Impossible to describe. Trust in the coordinates / map marker please!", "Andorhal" },
}
points[ 52 ] = { -- Westfall
	[52915374] = { 966, 25, 12340, "In the Inn or atop the tower, depending upon your quest phase.\n"
									.."This map marker is for the inn.", "Sentinel Hill" },
}
points[ 56 ] = { -- Wetlands
	[10836099] = { 966, 23, 12343, "Don't go into the big fort/castle. Go around the back to the inn.", "Menethil Harbor" },
	[26072598] = { 966, 24, 28990, "", "Swiftgear Station" },
	[58213920] = { 966, 26, 28991, "Just nearby is an adorable raptor hatchling pet. It's oh so cute.\n"
									.."Steal it from her mother's nest you heartless pet collector!\n"
									.."Oh, did I say that I have an AddOn to help you collect four?", "Greenwarden's Grove" },
}

-- ============================
-- Tricks and Treats of Outland
-- ============================
-- 969 = Alliance
-- 968 = Horde

points[ 105 ] = { -- Blade's Edge Mountains
	[62903828] = { 969, 1, 12406, "Inside the inn, mailbox at the front", "Evergrove" },
	[35806370] = { 969, 2, 12358, "At the rear of the inn, behind the main building", "Sylvanaar" },
	[61106810] = { 969, 3, 12359, "At the rear of the inn. he building has a mailbox", "Toshley's Station" },
	[62903832] = { 968, 1, 12406, "Inside the inn, mailbox at the front", "Evergrove" },
	[76226039] = { 968, 2, 12394, "Inside the main building", "Mok'Nathal Village" },
	[53435555] = { 968, 3, 12393, "Inside the main building", "Thunderlord Stronghold" },
}
points[ 100 ] = { -- Hellfire Peninsula
	[54206370] = { 969, 4, 12352, "In the inn, mailbox at the front", "Honor Hold" },
	[23403660] = { 969, 5, 12353, "In the main building at the end of the promenade", "Temple of Telhamat" },
	[26905940] = { 968, 4, 12389, "In the lower, domed building", "Falcon Watch" },
	[56803750] = { 968, 5, 12388, "In the smaller of the two main buildings", "Thrallmar" },
}
points[ 107 ] = { -- Nagrand
	[54197588] = { 969, 6, 12357, "Below the Flight Master.\nIf mobs are orange it's still okay.", "Telaar" },
	[56683448] = { 968, 6, 12392, "At the centre of the huge round building.\n"
									.."If mobs are orange it's still okay.", "Garadar" },
}
points[ 109 ] = { -- Netherstorm
	[32006453] = { 969, 7, 12407, "A little inside the main building", "Area 52" },
	[43313608] = { 969, 8, 12408, "Fly high up. Inside the lowest building", "The Stormspire" },
	[32006457] = { 968, 7, 12407, "A little inside the main building", "Area 52" },
	[43313610] = { 968, 8, 12408, "Fly high up. Inside the lowest building", "The Stormspire" },
}
points[ 104 ] = { -- Shadowmoon Valley
	[61002817] = { 969, 9, 12409, "You must be Aldor but... if absolutely neutral then your choice.", "Altar of Sha'tar" },
	[56375980] = { 969, 9, 12409, "You must be Scryer but... if absolutely neutral then your choice.", "Sanctum of the Stars" },
	[37015829] = { 969, 10, 12360, "In the dining area of the Kharanos-style inn with\n"
					.."brewing iconography. Don't enter the big building", "Wildhammer Stronghold" },
	[61002821] = { 968, 9, 12409, "You must be Aldor but... if absolutely neutral then your choice.", "Altar of Sha'tar" },
	[56405982] = { 968, 9, 12409, "You must be Scryer but... if absolutely neutral then your choice.", "Sanctum of the Stars" },
	[30272770] = { 968, 10, 12395, "In the main building", "Shadowmoon Village" },
}
points[ 111 ] = { -- Shattrath City
	[28204900] = { 969, 11, 12404, "You must be Aldor but... if absolutely neutral then your choice.", "Aldor Rise" },
	[56308194] = { 969, 11, 12404, "You must be Scryer but... if absolutely neutral then your choice.", "Scryer's Tier" },
	[28204901] = { 968, 11, 12404, "You must be Aldor but... if absolutely neutral then your choice.", "Aldor Rise" },
	[56308196] = { 968, 11, 12404, "You must be Scryer but... if absolutely neutral then your choice.", "Scryer's Tier" },
}
points[ 108 ] = { -- Terokkar Forest
	[56605320] = { 969, 12, 12356, "Inside the only round, domed (elven) building", "Allerian Stronghold" },
	[48744517] = { 968, 12, 12391, "Inside the huge round building", "Stonebreaker Hold" },
}
points[ 102 ] = { -- Zangarmarsh
	[78456288] = { 969, 13, 12403, "Inside the main building", "Cenarion Refuge" },
	[41902620] = { 969, 14, 12355, "Inside the building with the mailbox", "Orebor Harborage" },
	[67204890] = { 969, 15, 12354, "Right next to the innkeeper", "Telredor" },
	[30625087] = { 968, 13, 12390, "The ground level of the inn with no name :(", "Zabra'jin" },
	[78456290] = { 968, 14, 12403, "Inside the main building", "Cenarion Refuge" },
}
points[ 101 ] = { -- Outland
	[80603200] = { "N", "Candy Bucket Macro", 0, "#showtooltip Handful of Treats\n/use Handful of Treats" },
}

-- ==============================
-- Tricks and Treats of Northrend
-- ==============================
-- 5836 = Alliance
-- 5835 = Horde

points[ 114 ] = { -- Borean Tundra
	[57071907] = { 5836, 1, 13437, "Inside the main building. Icon marks the entrance", "Fizzcrank Airstrip" },
	[78454914] = { 5836, 2, 13460, "Inside the inn / main building which is above the shore", "Unu'pe" },
	[58526787] = { 5836, 3, 13436, "Quite a ways inside the inn, which is adjacent to the Flight Master", "Valiance Keep" },
	[49750998] = { 5835, 1, 13501, "", "Bor'gorok Outpost" },
	[76663747] = { 5835, 2, 13467, "", "Taunka'le Village" },
	[78454918] = { 5835, 3, 13460, "Inside the inn / main building which is above the shore", "Unu'pe" },
	[41715440] = { 5835, 4, 13468, "The lowest level. Use the south-south-east entrance\n"
									.."at ground level and enter the pidgeon hole in the stairs.\n"
									.."Do NOT ascend those stairs!", "Warsong Hold" },
}
points[ 127 ] = { -- Crystalsong Forest
	[29003239] = { 5836, 4, 13463, "Hey, did you download my \X and Y\" AddOn for cool minimap coordinates!\n"
									.."(Shameless self promotion)", "The Legerdemain Lounge" },
	[24903750] = { 5836, 5, 13473, "Don't go into the Silver Enclave.\nIt's in the adjacent \"A Hero's Welcome\" inn.\n"
					.."Under the stairs on the right side", "A Hero's Welcome" },
	[27304169] = { 5836, 6, 13472, "Cantrips & Crows", "The Underbelly" },
	[29003241] = { 5835, 5, 13463, "Hey, did you download my \X and Y\" AddOn for cool minimap coordinates!\n"
									.."(Shameless self promotion)", "The Legerdemain Lounge" },
	[30703770] = { 5835, 6, 13474, "The Filthy Animal", "Sunreaver's Sanctuary" },
	[27304171] = { 5835, 7, 13472, "Cantrips & Crows", "The Underbelly" },
}
points[ 125 ] = { -- Dalaran
	[48154127] = { 5836, 4, 13463, "Hey, did you download my \X and Y\" AddOn for cool minimap coordinates!\n"
									.."(Shameless self promotion)", "The Legerdemain Lounge" },
	[42366313] = { 5836, 5, 13473, "Don't go into the Silver Enclave.\nIt's in the adjacent \"A Hero's Welcome\" inn.\n"
					.."Under the stairs on the right side", "A Hero's Welcome" },
	[38225959] = { 5836, 6, 13472, "Cantrips & Crows", "The Underbelly" },
	[48154135] = { 5835, 5, 13463, "Hey, did you download my \X and Y\" AddOn for cool minimap coordinates!\n"
									.."(Shameless self promotion)", "The Legerdemain Lounge" },
	[66703000] = { 5835, 6, 13474, "The Filthy Animal", "Sunreaver's Sanctuary" },
	[38225965] = { 5835, 7, 13472, "Cantrips & Crows", "The Underbelly" },
}
points[ 126 ] = { -- The Underbelly
	[40205949] = { 5836, 6, 13472, "Cantrips & Crows", "The Underbelly" },
	[40205951] = { 5835, 7, 13472, "Cantrips & Crows", "The Underbelly" },
}
points[ 115 ] = { -- Dragonblight
	[48117465] = { 5836, 7, 13459, "", "Moa'ki Harbor" },
	[28955622] = { 5836, 8, 13438, "", "Stars' Rest" },
	[77285099] = { 5836, 9, 13439, "Icon marks the entrance to the inn. It's the closest building to the Flight Master", "Wintergarde Keep" },
	[60155343] = { 5836, 10, 13456, "The ground floor. Use the nearest entrance to the Gryphon Master", "Wyrmrest Temple" },
	[37834647] = { 5835, 8, 13469, "", "Agmar's Hammer" },
	[48117466] = { 5835, 9, 13459, "", "Moa'ki Harbor" },
	[76826328] = { 5835, 10, 13470, "", "Venomspite" },
	[60155347] = { 5835, 11, 13456, "The ground floor. Use the nearest entrance to the Flight Master", "Wyrmrest Temple" },
}
points[ 116 ] = { -- Grizzly Hills
	[31946021] = { 5836, 11, 12944, "", "Amberpine Lodge" },
	[59642636] = { 5836, 12, 12945, "", "Westfall Brigade" },
	[65364700] = { 5835, 12, 12947, "", "Camp Oneqwah" },
	[20896477] = { 5835, 13, 12946, "", "Conquest Hold" },
}
points[ 117 ] = { -- Howling Fjord
	[60481591] = { 5836, 13, 13435, "", "Fort Wildervar" },
	[25315912] = { 5836, 14, 13452, "Icon marks the entrance to the subterranean Inn", "Kamagua" },
	[58676316] = { 5836, 15, 13433, "The Inn entrance is at the side....\nThe Penny Pouch is awesome!\nNot :/", "Valgarde" },
	[30834205] = { 5836, 16, 13434, "The usual :). Icon marks the inn entrance", "Westguard Keep" },
	[49401080] = { 5835, 14, 13464, "", "Camp Winterhoof" },
	[25315916] = { 5835, 15, 13452, "Icon marks the entrance to the subterranean Inn", "Kamagua" },
	[52106620] = { 5835, 16, 13465, "", "New Agamand" },
	[79273063] = { 5835, 17, 13466, "The Inn entrance is at the side....\nThe Penny Pouch is awesome!\nNot :/", "Vengeance Landing" },
}
points[ 119 ] = { -- Sholazar Basin
	[26615918] = { 5836, 17, 12950, "At the rear of the larger tent", "Nesingwary Base Camp" },
	[26615922] = { 5835, 18, 12950, "At the rear of the larger tent", "Nesingwary Base Camp" },
}
points[ 120 ] = { -- Storm Peaks
	[30583693] = { 5836, 18, 13462, "Quest phasing issues reported. Icon marks the entrance", "Bouldercrag's Refuge" },
	[28727428] = { 5836, 19, 13448, "", "Frosthold" },
	[40938594] = { 5836, 20, 13461, "Icon marks the entrance to the Inn. Surprise!", "K3" },
	[30583695] = { 5835, 19, 13462, "Quest phasing issues reported. Icon marks the entrance", "Bouldercrag's Refuge" },
	[67655069] = { 5835, 20, 13471, "", "Camp Tunka'lo" },
	[37094951] = { 5835, 21, 13548, "", "Grom'arsh Crash Site" },
	[40938596] = { 5835, 22, 13461, "Icon marks the entrance to the Inn. Surprise!", "K3" },
}
points[ 121 ] = { -- Zul'Drak
	[40866602] = { 5836, 21, 12941, "", "The Argent Stand" },
	[59335719] = { 5836, 22, 12940, "Hey, why not change the icons!\n"
									.."ESC->Interface->AddOns->HandyNotes->Plugins expand->Hallow's End", "Zim'Torga" },
	[40866606] = { 5835, 23, 12941, "", "The Argent Stand" },
	[59335723] = { 5835, 24, 12940, "Hey, why not change the icons!\n"
									.."ESC->Interface->AddOns->HandyNotes->Plugins expand->Hallow's End", "Zim'Torga" },
}

-- ==================================
-- Tricks and Treats of the Cataclysm
-- ==================================
-- 5837 = Alliance
-- 5838 = Horde

points[ 207 ] = { -- Deepholm
	[47365171] = { 5837, 1, 29020, "", "Temple of Earth" },
	[51194990] = { 5838, 1, 29019, "", "Temple of Earth" },
}
local experiment = "The lake area behind the Nordrassil inn is the perfect place to\n"
					.."experiment with your advanced graphics settings. Particle Density,\n"
					.."Ground Clutter, and Liquid Detail in particular are worth trying.\n"
					.."So divinely serene and gorgeous!"
points[ 198 ] = { -- Mount Hyjal
	[18633731] = { 5837, 2, 29000, "Just this once max out \"Ground Clutter\" in your settings. You're welcome!", "Grove of Aessina" },
	[63052414] = { 5837, 3, 28999, experiment, "Nordrassil" },
	[42684571] = { 5837, 4, 29001, "", "Shrine of Aviana" },
	[18633733] = { 5838, 2, 29000, "Just this once max out \"Ground Clutter\" in your settings. You're welcome!", "Grove of Aessina" },
	[63052416] = { 5838, 3, 28999, experiment, "Nordrassil" },
	[42684573] = { 5838, 4, 29001, "", "Shrine of Aviana" },
}
points[ 241 ] = { -- Twilight Highlands
	[60365825] = { 5837, 5, 28977, "The village is under attack but the dwarves\n"
									.."saved their blessed tavern. Priorities!", "Firebeard's Patrol" },
	[78877780] = { 5837, 6, 28980, "Regardless of quest phase, you'll be okay for the candy bucket.\n"
									.."From the entrance straight to the courtyard. Right then left. ", "Highbank" },
	[49603036] = { 5837, 7, 28978, "The building with the mailbox.", "Thundermar" },
	[43505727] = { 5837, 8, 28979, "", "Victor's Point" },
	[53404284] = { 5838, 5, 28973, "Ground floor, main building", "Bloodgulch" },
	[45127681] = { 5838, 6, 28974, "Inside the only building", "Crushblow" },
	[75411653] = { 5838, 7, 28976, "Difficult to describe - trust in the coordinates please!\n"
									.."Or... just look for the apple bobbing tub at the doorway!", "The Krazzworks" },
	[75365492] = { "H", "Dragonmaw Port", 28975, "To see the liberated version of Dragonmaw Port\n"
									.."you must have completed the zone storyline up\n"
									.."to \"Returning to the Highlands\". The flight point\n"
									.."becomes available then too." },
}
points[ 249 ] = { -- Uldum
	[26600725] = { 5837, 9, 29016, "Why not grab the cool Springfur Alpaca mount while you're here!\n"
									.."You guessed it, sigh. I've an AddOn for that too! :)", "Oasis of Vir'sar" },
	[54682999] = { 5837, 10, 29017, "", "Ramkahen" },
	[26600727] = { 5838, 8, 29016, "Why not grab the cool Springfur Alpaca mount while you're here!\n"
									.."You guessed it, sigh. I've an AddOn for that too! :)", "Oasis of Vir'sar" },
	[54683301] = { 5838, 9, 29017, "", "Ramkahen" },
}
points[ 1527 ] = { -- Wrong Uldum
	[26580722] = { 5837, 9, 29016, "\124cFFFF0000Wrong version of Uldum. Speak to Zidormi." },
	[54682999] = { 5837, 10, 29017, "\124cFFFF0000Wrong version of Uldum. Speak to Zidormi." },
	[26600726] = { 5838, 8, 29016, "\124cFFFF0000Wrong version of Uldum. Speak to Zidormi." },
	[54683301] = { 5838, 9, 29017, "\124cFFFF0000Wrong version of Uldum. Speak to Zidormi." },
}
points[ 204 ] = { -- Abyssal Depths in Vashj'ir
	[61897915] = { 5837, 11, 28985, "Inside Darkbreak Cove. Dive straight down. The icon marks the entrance.\n"
									.."The cave may appear empty, Give the art assets time to appear.", "" },
	[94867350] = { 5838, 11, 28984, "Inside Legion's Rest. Dive straight down. The icon marks the entrance" },
	[60005670] = { 5838, 13, 28986, "Inside Tenebrous Cove. Dive straight down. The icon marks the entrance", "" },
}
points[ 201 ] = { -- Kelp'thar Forest in Vashj'ir
	[60686609] = { 5837, 12, 28981, "Inside Deepmist Grotto. Dive straight down. The icon marks the entrance", "" },
	[60686610] = { 5838, 10, 28981, "Inside Deepmist Grotto. Dive straight down. The icon marks the entrance", "" },
}
points[ 205 ] = { -- Shimmering Expanse in Vashj'ir
	[20007114] = { 5837, 11, 28985, "Inside Darkbreak Cove. Dive straight down. The icon marks the entrance.\n"
									.."The cave may appear empty, Give the art assets time to appear.", "" },
	[68261539] = { 5837, 12, 28981, "Inside Deepmist Grotto. Dive straight down. The icon marks the entrance", "" },
	[51564153] = { 5837, 13, 28982, "Inside Silver Tide Hollow. Dive straight down. The icon marks the entrance", "" },
	[45025707] = { 5837, 14, 28983, "Inside the Tranquil Wash. Dive straight down. The icon marks the entrance", "" },
	[68261540] = { 5838, 10, 28981, "Inside Deepmist Grotto. Dive straight down. The icon marks the entrance", " " },
	[47706640] = { 5838, 11, 28984, "Inside Legion's Rest. Dive straight down. The icon marks the entrance" },
	[51564155] = { 5838, 12, 28982, "Inside Silver Tide Hollow. Dive straight down. The icon marks the entrance", "" },
	[18415228] = { 5838, 13, 28986, "Inside Tenebrous Cove. Dive straight down. The icon marks the entrance", "" },
}
-- The Maelstrom map is not treated as a continent in the game (or is it Handy Notes?) so I need to include it here
points[ 948 ] = { -- The Maelstrom
	[50002900] = { 5837, 1, 29020, "Access via the Cataclysm portal cluster in Stormwind.", "Temple of Earth" },
	[50002901] = { 5838, 1, 29019, "Access via the Cataclysm portal cluster in Orgrimmar.", "Temple of Earth" },
}

-- =================================
-- Tricks and Treats of the Pandaria
-- =================================
-- 7601 = Alliance
-- 7602 = Horde

points[ 422 ] = { -- Dread Wastes
	[55933227] = { 7601, 1, 32024, "", "Klaxxi'vess" },
	[55217119] = { 7601, 2, 32023, "Inside The Chum Bucket Inn", "Soggy's Gamble" },
	[55933229] = { 7602, 1, 32024, "", "Klaxxi'vess" },
	[55217121] = { 7602, 2, 32023, "Inside The Chum Bucket Inn", "Soggy's Gamble" },
}
points[ 371 ] = { -- The Jade Forest
	[45774360] = { 7601, 3, 32027, "Inside The Drunken Hozen Inn", "Dawn's Blossom" },
	[48093462] = { 7601, 4, 32029, "", "Greenstone Village" },
	[54606333] = { 7601, 5, 32032, "Inside The Dancing Serpent Inn", "Jade Temple Grounds" },
	[44818437] = { 7601, 6, 32049, "First visit to Pandaria? Always grab those flight points!", "Paw'don Village" },
	[59568324] = { 7601, 7, 32033, "", "Pearlfin Village" },
	[55712441] = { 7601, 8, 32031, "Yeah... it's inside the Inn!", "Sri-La Village" },
	[41682313] = { 7601, 9, 32021, "Inside Paur's Pub", "Tian Monastery" },
	[45774361] = { 7602, 3, 32027, "Inside The Drunken Hozen Inn", "Dawn's Blossom" },
	[48093463] = { 7602, 4, 32029, "", "Greenstone Village" },
	[28024738] = { 7602, 5, 32028, "The candy bucket is present even if you have\nnot yet made the Grookin friendly.", "Grookin Hill" },
	[28451327] = { 7602, 6, 32050, "", "Honeydew Village" },
	[54606334] = { 7602, 7, 32032, "Inside The Dancing Serpent Inn", "Jade Temple Grounds" },
	[55712440] = { 7602, 8, 32031, "Yeah... it's inside the Inn!", "Sri-La Village" },
	[41692315] = { 7602, 9, 32021, "Inside Paur's Pub", "Tian Monastery" },
	[23326072] = { 7601, 17, 32026, "Tavern in the Mists", "" },
	[23326074] = { 7602, 19, 32026, "Tavern in the Mists", "" },
}
points[ 418 ] = { -- Krasarang Wilds
	[51407728] = { 7601, 10, 32034, "The \"Bait and Brew\". Pretty much the only building", "Marista" },
	[75920686] = { 7601, 11, 32036, "In the Wilds' Edge Inn", "Zhu's Watch" },
	[28255074] = { 7602, 10, 32020, "", "Dawnchaser Retreat" },
	[51417730] = { 7602, 11, 32034, "The \"Bait and Brew\". Pretty much the only building", "Marista" },
	[61152504] = { 7602, 12, 32047, "", "Thunder Cleft" },
	[75920688] = { 7602, 13, 32036, "In the Wilds' Edge Inn", "Zhu's Watch" },
}

points[ 379 ] = { -- Kun-Lai Summit
	[72729229] = { 7601, 12, 32039, "Inside the Binan Brew and Chunder Inn", "Binan Village" },
	[64206127] = { 7601, 13, 32041, "Inside The Two Fisted Brew", "The Grummle Bazaar" },
	[57455995] = { 7601, 14, 32037, "Inside The Lucky Traveller", "One Keg" },
	[54078281] = { 7601, 15, 32042, "Phasing issue here. Go to Binan Village. Complete \"Hit Medicine\",\n"
									.."\"Call Out Their Leader\", \"All of the Arrows\". Then complete\n"
									.."\"Admiral Taylor...\". Then \"Westwind Rest\" by heading over\n"
									.."towards Westwind. Finally complete \"Challenge Accepted\" from\n"
									.."Elder Tsulan. Voilà - unlocked!", "Westwind Rest" },
	[62502901] = { 7601, 16, 32051, "Inside the North Wind Tavern. Right near the Flight Master", "Zouchin Village" },
	[72749227] = { 7602, 14, 32039, "Inside the Binan Brew and Chunder Inn", "Binan Village" },
	[62778050] = { 7602, 15, 32040, "Phasing issue here. Go to Binan Village. Complete \"Hit Medicine\",\n"
									.."\"Call Out Their Leader\", \"All of the Arrows\". Then complete\n"
									.."\"General Nazgrim...\". Then \n\"Eastwind Rest\" by heading over\n"
									.."towards Eastwind. Finally complete \"Challenge Accepted\" from\n"
									.."Elder Shiao. Voilà - unlocked!", "Eastwind Rest" },
	[64226128] = { 7602, 16, 32041, "Inside The Two Fisted Brew", "The Grummle Bazaar" },
	[57455994] = { 7602, 17, 32037, "Inside The Lucky Traveller", "One Keg" },
	[62502900] = { 7602, 18, 32051, "Inside the North Wind Tavern. Right near the Flight Master", "Zouchin Village" },
}
points[ 433 ] = { -- The Veiled Stair, Tavern in the Mists
	[55117223] = { 7601, 17, 32026, "Taraezor has lots of handy \"HandyNotes\" AddOns!", "" },
	[55117225] = { 7602, 19, 32026, "Taraezor has lots of handy \"HandyNotes\" AddOns!", "" },
}
points[ 388 ] = { -- Townlong Steppes, Longying Outpost
	[71135777] = { 7601, 18, 32043, "", "" },
	[71145779] = { 7602, 20, 32043, "", "" },
}
points[ 390 ] = { -- Vale of Eternal Blossoms
	[35147776] = { 7601, 19, 32044, "In The Golden Rose inn", "Mistfall Village" },
	[87036900] = { 7601, 20, 32052, "In the Golden Lantern inn.\nThe inn is on the "
									.."right side of the Shrine's entrance", "" },
	[35127781] = { 7602, 21, 32044, "In The Golden Rose inn", "Mistfall Village" },
	[61981626] = { 7602, 22, 32022, "From the main entrance go up the stairs on the right side.\n"
									.."Go through each room until you arrive at the balcony /\n"
									.."mezzanine of The Keggary.", "Shrine of Two Moons" },
}
points[ 393 ] = { -- Shrine of the Seven Stars
	[37856590] = { 7601, 20, 32052, "In the Golden Lantern inn.\nThe inn is on the "
									.."right side of the Shrine's entrance", "" },
}
points[ 392 ] = { -- The Imperial Mercantile
	[58877836] = { 7602, 22, 32022, "From the main entrance go up the stairs on the right side.\n"
									.."Go through each room until you arrive at the balcony /\n"
									.."mezzanine of The Keggary.", "Shrine of Two Moons" },
}
points[ 376 ] = { -- Valley of the Four Winds
	[83642013] = { 7601, 21, 32048, "Hey, you know that you can change the icons?\n"
									.."ESC->Interface->AddOns->HandyNotes->Plugins expand->Hallow's End", "Pang's Stead" },
	[19875578] = { 7601, 22, 32046, "Yeah.. another inn... The Stone Mug Tavern", "Stoneplow" },
	[83642015] = { 7602, 23, 32048, "Hey, you know that you can change the icons?\n"
									.."ESC->Interface->AddOns->HandyNotes->Plugins expand->Hallow's End", "Pang's Stead" },
	[19885577] = { 7602, 24, 32046, "Yeah.. another inn... The Stone Mug Tavern", "Stoneplow" },
	[72751031] = { 7601, 17, 32026, "Tavern in the Mists", "" },
	[72751033] = { 7602, 19, 32026, "Tavern in the Mists", "" },
}

-- ==========
-- Miscellany
-- ==========

local draenorS = "You must have a Tier 3 Town Hall or else\n"
				.."the Candy Bucket will not be present."
local draenorD = "Orukan has four dailies and Izzy Hollyfizzle\n"
				.."sells Garrison decorations, purchasable only\n"
				.."with the daily rewards. A Tier 3 Town Hall is\n"
				.."required for these NPCs to appear."

points[ 582 ] = { -- Lunarfall Garrison in Draenor
	[43515151] = { "A", "Draenor / Lunarfall Garrison", 39657, draenorS },
	[44405180] = { "A", "Draenor / Lunarfall Garrison", -39719, draenorD },
	[29003440] = { "A", "Get Spooky - Garrison Mission", 0, "Rarely and randomly occurs. Rewards 15 candy!" },
}
points[ 539 ] = { -- Shadowmoon Valley in Draenor
	[30011780] = { "A", "Draenor / Lunarfall Garrison", 39657, draenorS },
	[30251805] = { "A", "Draenor / Lunarfall Garrison", -39719, draenorD },
	[28701600] = { "A", "Get Spooky - Garrison Mission", 0, "Rarely and randomly occurs. Rewards 15 candy!" },
}
points[ 590 ] = { -- Frostwall Garrison in Draenor
	[46993759] = { "H", "Draenor / Frostwall Garrison", 39657, draenorS },
	[47903790] = { "H", "Draenor / Frostwall Garrison", -39719, draenorD },
	[41005300] = { "H", "Get Spooky - Garrison Mission", 0, "Rarely and randomly occurs. Rewards 15 candy!" },
}
points[ 525 ] = { -- Frostfire Ridge in Draenor
	[48256435] = { "H", "Draenor / Frostwall Garrison", 39657, draenorS },
	[48506460] = { "H", "Draenor / Frostwall Garrison", -39719, draenorD },
	[46006800] = { "H", "Get Spooky - Garrison Mission", 0, "Rarely and randomly occurs. Rewards 15 candy!" },
}

points[ 1163 ] = { -- Dazar'alor - The Great Seal
	[49828478] = { "H", "Zuldazar", 54709, "In \"The Great Seal\" in Dazar'alor." },
}
points[ 1164 ] = { -- Dazar'alor - The Hall of Chroniclers
	[49828478] = { "H", "Zuldazar", 54709, "In \"The Great Seal\" in Dazar'alor." },
}
points[ 1165 ] = { -- Dazar'alor
	[50014684] = { "H", "Zuldazar", 54709, "In \"The Great Seal\" in Dazar'alor." },
}
points[ 862 ] = { -- Zuldazar
	[57984468] = { "H", "Zuldazar", 54709, "In \"The Great Seal\" in Dazar'alor." },
}
points[ 1161 ] = { -- Boralus - Tiragarde Sound
	[73701219] = { "A", "Boralus Harbor", 54710, "In the \"Snug Harbor Inn\"." },
}
points[ 895 ] = { -- Tiragarde Sound
	[75182272] = { "A", "Boralus Harbor", 54710, "In the \"Snug Harbor Inn\"." },
}

points[ 627 ] = { -- Dalaran Broken Isles
	[41476398] = { "A", "Dalaran Broken Isles", 43056,  "In \"A Hero's Welcome\" inn." },
	[47964178] = { "N", "Dalaran Broken Isles", 43055, "In The Legerdemain Lounge." },
	[47294077] = { "N", "Beware of the Crooked Tree", 43259, "Speak to Duroc Ironjaw. "
								.."This is a simple \"fly to X\" quest\nbut with very "
								.."worthwhile XP, especially for a trivial flight.\n"
								.."The quest that follows is devilishly difficult and "
								.."is not\nrecommended. Just hearth/fly back to Dalaran." },
	[67042941] = { "H", "Dalaran Broken Isles", 43057, "In \"The Filthy Animal\" inn." },
	[59174564] = { 291, 0, 0, "Just stand here with a cuppa and wait. Couldn't be easier." },
}

-- ===========================
-- Continents & Sub-Continents
-- ===========================

points[ 12 ] = { -- Kalimdor
	-- Azuremyst Isle
	[32402650] = { 963, 2, 12333, "", "Azure Watch" },
	-- Teldrassil
	[43711023] = { 963, 25, 12331, teldrassil, "Dolanaar" },
	[40320891] = { 963, 5, 12334, teldrassil, "Craftsmen's Terrace" },
}
points[ 947 ] = { -- Azeroth
	[70007500] = { "N", "Candy Bucket Macro", 0, "#showtooltip Handful of Treats\n/use Handful of Treats" },
	[45194849] = { 5837, 1, 29020, "Access via the Cataclysm portal cluster in Stormwind.", "Temple of Earth" },
	[45194851] = { 5838, 1, 29019, "Access via the Cataclysm portal cluster in Orgrimmar.", "Temple of Earth" },
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

