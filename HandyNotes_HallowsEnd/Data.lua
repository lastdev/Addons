local _, ns = ...
local points = ns.points
local texturesL = ns.texturesL
local scalingL = ns.scalingL
local texturesS = ns.texturesS
local scalingS = ns.scalingS

-- =====================================
-- Kalimdor
-- =====================================

points[ 97 ] = { -- Azuremyst Isle
	[48494905] = { achievement=963, index=2, quest=12333, location="Azure Watch" },
	[30322500] = { achievement=963, index=9, quest=12337, location="Seat of the Naaru" },
}
points[ 106 ] = { -- Bloodmyst Isle
	[55695997] = { achievement=963, index=3, quest=12341, location="Blood Watch" },
}
points[ 63 ] = { -- Ashenvale
	[37014926] = { achievement=963, index=1, quest=12345, tip="Your quest phase does not matter - the bucket is always available.", location="Astranaar" },
	[38664234] = { achievement=965, index=1, quest=28958, tip="Outside, easy to see", location="Hellscream's Watch" },
	[50256727] = { achievement=965, index=2, quest=28953, location="Silverwind Refuge" },
	[73966060] = { achievement=965, index=3, quest=12377, tip="Follow the map marker for the correct building", location="Splintertree Post" },
	[13003410] = { achievement=965, index=4, quest=28989, location="Zoram'gar Outpost" },
}
points[ 76 ] = { -- Azshara
	[57115017] = { achievement=965, index=5, quest=28992, tip="Exclusive Taraezor tip! Pause to check your map while you are\n"
                                    .."inside the inn next to the candy bucket. You want to stretch\n"
									.."that rested bonus for as long as possible!", location="Bilgewater Harbor" },
}
points[ 62 ] = { -- Darkshore
	[50791890] = { achievement=963, index=4, quest=28951, tip="Exclusive Taraezor tip! Pause to check your map while you are\n"
                                    .."inside the inn next to the candy bucket. You want to stretch\n"
									.."that rested bonus for as long as possible!", location="Lor'danel" },
}
local teldrassil = "Speak to Zidormi in Darkshore if Teldrassil seems somewhat destroyed!"
points[ 89 ] = { -- Darnassus
	[62283315] = { achievement=963, index=5, quest=12334, location="Craftsmen's Terrace" },
}
points[ 66 ] = { -- Desolace
	[56725010] = { achievement=963, index=6, quest=28993, location="Karnum's Glade" },
	[66330659] = { achievement=963, index=7, quest=12348, location="Nigel's Point" },
	[56725014] = { achievement=965, index=6, quest=28993, location="Karnum's Glade" },
	[24076829] = { achievement=965, index=7, quest=12381, location="Shadowprey Village" },
}
points[ 1 ] = { -- Durotar
	[51544158] = { achievement=965, index=8, quest=12361, location="Razor Hill" },
	[46940672] = { achievement=965, index=20, quest=12366, location="Valley of Strength" },
}
points[ 70 ] = { -- Dustwallow Marsh
		-- Due to the more extreme scaling of the map the Alliance Mudsprocket will be overwritten
		-- by the Horde version of this data with regards to the continent map. Rather than
		-- compromise the coordinate integrity I'll just hack an Alliance version onto the continent
	[41857408] = { achievement=963, index=8, quest=12398, tip="Upstairs, inside the main hut", location="Mudsprocket" },
	[36783244] = { achievement=965, index=9, quest=12383, location="Brackenwall Village" },
	[41867409] = { achievement=965, index=10, quest=12398, tip="Upstairs, inside the main hut", location="Mudsprocket" }, -- Best coords
	[66604528] = { faction="Alliance", title="Theramore (Old)", quest=12349, tip="Inside the inn. You may need to speak to Zidormi.\n"
								.."Note: Zidormi is automatically marked on your map if\n"
								.."you have completed the \"Theramore's Fall\" scenario.\n"
								.."If you have not completed the scenario then there is\n"
								.."no need for her and she will offer no time shifting." },
}
points[ 103 ] = { -- The Exodar
	[59241848] = { achievement=963, index=9, quest=12337, location="Seat of the Naaru" },
}
points[ 77 ] = { -- Felwood
	[61862671] = { achievement=963, index=10, quest=28995, tip="Ever wanted to experiment with \"Particle Density\" in\n"
									.."System->Graphics->Advanced? Stand at the entrance and\n"
									.."look towards the candy bucket!", location="Talonbranch Glade" },
	[44572897] = { achievement=963, index=11, quest=28994, tip="There's space inside the inn, as usual, for the candy bucket yet...\n"
									.."it's placed on the landing outside. Unusual! Spooky?", location="Whisperwind Grove" },
	[44592901] = { achievement=965, index=11, quest=28994, tip="There's space inside the inn, as usual, for the candy bucket yet...\n"
									.."it's placed on the landing outside. Unusual! Spooky?", location="Whisperwind Grove" },
}
points[ 69 ] = { -- Feralas
	[51071782] = { achievement=963, index=12, quest=28952, location="Dreamer's Rest" },
	[46334519] = { achievement=963, index=13, quest=12350, location="Feathemoon Stronghold" },
	[41451568] = { achievement=965, index=12, quest=28996, location="Camp Ataya" },
	[74834514] = { achievement=965, index=13, quest=12386, location="Camp Mojache" },
	[51974764] = { achievement=965, index=14, quest=28998, location="Stonemaul Hold" },
}
points[ 7 ] = { -- Mulgore
	[46796041] = { achievement=965, index=15, quest=12362, location="Bloodhoof Village" },
	[39703118] = { achievement=965, index=28, quest=12367, tip="Inside \"The Cat and the Shaman\" inn.", location="Lower Rise" },
}
points[ 10 ] = { -- Northern Barrens
	[67347465] = { achievement=963, index=14, quest=12396, tip="Grab a Leaping Hatchling pet from nearby... oh yeah, did I mention that I\n"
									.."have an AddOn for that too? Collect all four of the adorable raptor pets!", location="Ratchet" },
	[49515791] = { achievement=965, index=16, quest=12374, tip="Main building. It's the inn. De rigueur", location="The Crossroads" },
	[56214003] = { achievement=965, index=17, quest=29002, location="Grol'dom Farm" },
	[62511660] = { achievement=965, index=18, quest=29003, tip="Grab a Leaping Hatchling pet from nearby... oh yeah, did I mention that I\n"
									.."have an AddOn for that too? Collect all four of the adorable raptor pets!", location="Nozzlepot's Outpost" },
	[67347467] = { achievement=965, index=19, quest=12396, location="Ratchet" },
}
points[ 85 ] = { -- Orgrimmar
	[53937894] = { achievement=965, index=20, quest=12366, location="Valley of Strength" },
	[50843631] = { achievement=5838, index=1, quest=29019, tip="Through this portal for the Deepholm candy bucket.\n"
									.."A Vashj'ir portal is closeby too!", location="Temple of Earth" },
}
points[ 81 ] = { -- Silithus
	[55473678] = { achievement=963, index=15, quest=12401, tip="In the Oasis inn, below the Flight Masters." },
	[55473679] = { achievement=965, index=21, quest=12401, tip="In the Oasis inn, below the Flight Masters." }, -- Best coords
}
points[ 199 ] = { -- Southern Barrens
	[49046851] = { achievement=963, index=16, quest=29008, tip="Another candy bucket that's not in a building. Hooray!", location="Fort Triumph" },
	[39021099] = { achievement=963, index=17, quest=29006, tip="It's out in the open.", location="Honor's Stand" },
	[65604654] = { achievement=963, index=18, quest=29007, tip="To the south, just across the border into Dustwallow Marsh.\n"
									.."is an adorable and oh so cute raptor hatchling pet, one of\n"
									.."a set of four. Why not \"dart\" over and grab it now!", location="Northwatch Hold" },
	[40706931] = { achievement=965, index=22, quest=29005, location="Desolation Hold" },
	[39292009] = { achievement=965, index=23, quest=29004, location="Hunter's Hill" },
}
points[ 65 ] = { -- Stonetalon Mountains
	[31536066] = { achievement=963, index=19, quest=29013, tip="Another open air Elven inn - fly right in!", location="Farwatcher's Glen" },
	[71027908] = { achievement=963, index=20, quest=29010, location="Northwatch Expedition Base" },
	[39483281] = { achievement=963, index=21, quest=29012, location="Thal'darah Overlook" },
	[59045632] = { achievement=963, index=22, quest=29011, tip="Fallowmere Inn", location="Windshear Hold" },
	[66506419] = { achievement=965, index=24, quest=29009, tip="Inside the smallest building.", location="Krom'gar Fortress" },
	[50376379] = { achievement=965, index=25, quest=12378, tip="Alchemy completionists will want the Fire Protection potion\n"
									.."from Jeeda upstaits. Good luck!", location="Sun Rock Retreat" },
	[40531769] = { faction="Alliance", title="Stonetalon Peak", quest=12347, tip="Nearby hostile mob is level 30 (max. zone level)." },
}
points[ 71 ] = { -- Tanaris
	[55706095] = { achievement=963, index=23, quest=29014, location="Bootlegger Outpost" },
	[52562709] = { achievement=963, index=24, quest=12399, tip="Did you stock up on Noggenfogger while you are here?\n"
								.."Oh yeah, the candy bucket is inside \"The Road Warrior\" inn", location="Gadgetzan" },
	[55706097] = { achievement=965, index=26, quest=29014, location="Bootlegger Outpost" },
	[52562710] = { achievement=965, index=27, quest=12399, tip="Did you stock up on Noggenfogger while you are here?\n" -- Best coords
								.."Oh yeah, the candy bucket is inside \"The Road Warrior\" inn", location="Gadgetzan" },
}
points[ 57 ] = { -- Teldrassil
	[55365229] = { achievement=963, index=25, quest=12331, location="Dolanaar" },
	[34164401] = { achievement=963, index=5, quest=12334, location="Craftsmen's Terrace" },
}
points[ 88 ] = { -- Thunder Bluff
	[45626493] = { achievement=965, index=28, quest=12367, tip="Inside \"The Cat and the Shaman\" inn.", location="Lower Rise" },
}
points[ 78 ] = { -- Un'Goro Crater
	[55266219] = { achievement=963, index=26, quest=29018, tip="Did you get your awesome Venomhide Ravasaur mount while you were here?\n"
								.."Oh wait... you're Alliance. Oh well.", location="Marshal's Stand" },
	[55266213] = { achievement=965, index=29, quest=29018, tip="Did you get your awesome Venomhide Ravasaur mount while you were here?", location="Marshal's Stand" },
}
points[ 83 ] = { -- Winterspring
	[59835119] = { achievement=963, index=27, quest=12400, tip="Grab a Winterspring Cub pet from Michelle De Rum who is\n"
                                    .."standing near the candy bucket. Awwww... so cute!\n"
									.."Don't forget the Mount Hyjal locations too!", location="Everlook" },
	[59835123] = { achievement=965, index=30, quest=12400, tip="Grab a Winterspring Cub pet from Michelle De Rum who is\n"
                                    .."standing near the candy bucket. Awwww... so cute!\n"
									.."Don't forget the Mount Hyjal locations too!", location="Everlook" },
}

-- =====================================
-- Eastern Kingdoms
-- =====================================

points[ 14 ] = { -- Arathi Highlands
	[40064909] = { achievement=966, index=1, quest=28954, tip="If you cannot see the candy bucket then you'll\n"
									.."need to visit Zidormi. I marked her on the map.", location="Refuge Point" },
	[38259009] = { achievement=966, index=1, quest=28954, tip="Zidormi is at this location. You'll probably\n"
									.."need her for the Refuge Point candy bucket.", location="Refuge Point" },
	[69023327] = { achievement=967, index=1, quest=12380, tip="Well if it's not outside then it must be...", location="Hammerfall" },
}
points[ 15 ] = { -- Badlands
	[20875632] = { achievement=966, index=2, quest=28956, location="Dragon's Mouth" },
	[65853564] = { achievement=966, index=3, quest=28955, tip="The apple bobbing tub is outside, the pumpkin is inside", location="Fuselight" },
	[65853566] = { achievement=967, index=2, quest=28955, tip="The apple bobbing tub is outside, the pumpkin is inside", location="Fuselight" },
	[18354273] = { achievement=967, index=3, quest=28957, location="New Kargath" },
}
points[ 17 ] = { -- Blasted Lands
	[60691407] = { achievement=966, index=4, quest=28960, tip="Erm... mobs looking a bit too red, a bit too hostile for your\n"
									.."liking? That'll be Zidormi you'll be needing. She's nearby.\n"
									.."The correct building is the one on the left of the main gate.\n"
									.."When you enter, turn right and then left. Voilà!", location="Nethergarde Keep" },
	[44348759] = { achievement=966, index=5, quest=28961, tip="Hey, fun trivia... see Garrod's house nearby? You\n"
									.."won't get dismounted - you can fly around inside!\n"
									.."Oh yeah... Zidormi is not required for Surwich!", location="Surwich" },
	[40471129] = { achievement=967, index=4, quest=28959, tip="If the guards are hostile... It's a Zidormi problem, sigh. She'd just nearby!", location="Dreadmaul Hold" },
}
points[ 210 ] = { -- The Cape of Stranglethorn
	[40917371] = { achievement=966, index=6, quest=12397, tip="It's in the Salty Sailor Tavern" },
	[40917373] = { achievement=967, index=5, quest=12397, tip="It's in the Salty Sailor Tavern" },
	[35042722] = { achievement=967, index=6, quest=28969, tip="It's in the building next to the apple bobbing tub", location="Hardwrench Hideaway" },
}
points[ 27 ] = { -- Dun Morogh
	[54495076] = { achievement=966, index=7, quest=12332, tip="Inside the Thunderbrew Distillery at the eating area." },
	[61172746] = { achievement=966, index=13, quest=12335, tip="Inside the Stonefire Tavern in The Commons" },
}
points[ 47 ] = { -- Duskwood
	[73804425] = { achievement=966, index=8, quest=12344, tip="" },
}
points[ 1431 ] = { -- Duskwood
	[73804425] = { achievement=966, index=8, quest=12344, tip="" },
}
points[ 23 ] = { -- Eastern Plaguelands
	[75575230] = { achievement=966, index=9, quest=12402, tip="" },
	[75575232] = { achievement=967, index=7, quest=12402, tip="Use a taxi between Light's Hope Chapel and Tranquillien." },
}
points[ 24 ] = { -- Light's Hope Chapel - Sanctum of Light
	[40709035] = { achievement=966, index=9, quest=12402, tip="" },
	[40709037] = { achievement=967, index=7, quest=12402, tip="" },
}
points[ 37 ] = { -- Elwynn Forest
	[43746589] = { achievement=966, index=10, quest=12286, location="Elwynn Forest" },
	[24894013] = { achievement=966, index=19, quest=12336, location="" },
	[32355088] = { achievement=1040, index=1, daily=true, quest=29054, tip="Pickup the quest here from Gretchen Fenlow and\n"
									.."then your broomstick taxi from Gertrude Fenlow,\n"
									.."who is nearby. Soon after completion you could\n"
									.."consider logging out. You will respawn at the Scarlet\n"
									.."Watchtower in Tirisfal Glades. This will save a lot\n"
									.."of time if you also intend doing \"A Time to Lose\".", location="" },									
	[29694442] = { achievement=1040, index=2, daily=true, quest=29144, tip="Pickup the quest from Gretchen Fenlow who is just outside\n"
									.."the Stormwind gates. To see the orange plumes you must\n"
									.."have \"Particle Density\" at least minimally enabled. Go to\n"
									.."System->Graphics->Effects. If you get debuffed then you\n"
									.."may cleanse yourself. Shapeshifting also works.", location="" },
	[32095059] = { achievement=1040, index=4, daily=true, quest=29371, tip="Pickup the quest here from Keira. See my travel notes for\n"
									.."the quest \"Stink Bombs Away\". Take extra care as you\n"
									.."will have no ground/structure cover. My approach is to\n"
									.."fly in from very high and then plummet straight down.", location="" },
	[22133396] = { achievement=1041, index=1, daily=true, quest=29374, tip="If you logout while in Stormwind you'll respawn nearby.\n"
									.."Handy for doing \"A Time to Break Down\".", location="" },
	[34104740] = { achievement=1041, index=4, daily=true, quest=29377, tip="The location of the Alliance Wickerman.\n"
									.."Approach from due east. Use the large tree and the ledge\n"
									.."as cover. Stay away from the wall to avoid zoning out and\n"
									.."adding to phasing problems. Reports suggest activating\n"
									.."Warmode in Orgrimmar will help in that respect. Do NOT\n"
									.."try to target the Wickerman. Stand near it and click on\n"
									.."your Dousing Agent. Immediately mount and hit \"space\"\n"
									.."to fly straight up.", location="" },
	[31241227] = { achievement=5837, index=1, quest=29020, tip="Through this portal for the Deepholm candy bucket.\n"
									.."A Vashj'ir portal is closeby too!", location="Temple of Earth" },
}
points[ 1229 ] = { -- Elwynn Forest
	[43746589] = { achievement=966, index=10, quest=12286, tip="" },
}
points[ 94 ] = { -- Eversong Woods
	[43707103] = { achievement=967, index=8, quest=12365, tip="Use a taxi between Fairbreeze Village and Tranquillien.", location="Fairbreeze Village" },
	[48204788] = { achievement=967, index=9, quest=12364, tip="Go through the \"blue\" doorway", location="Falconwing Square" },
	[55474495] = { achievement=967, index=17, quest=12370, tip="Wayfarer's Rest inn", location="The Bazaar" },
	[59294137] = { achievement=967, index=18, quest=12369, tip="Silvermoon City Inn", location="The Royal Exchange" },
}
points[ 95 ] = { -- Ghostlands
	[48683190] = { achievement=967, index=10, quest=12373, tip="Use a taxi between Light's Hope Chapel and Tranquillien.\n"
									.."Use a taxi between Fairbreeze Village and Tranquillien." },
}
points[ 25 ] = { -- Hillsbrad Foothills
	[60266374] = { achievement=967, index=11, quest=28962, tip="Hooray! It's outdoors and a no-brainer to find. Wooooo!", location="Eastpoint Tower" },
	[57854727] = { achievement=967, index=12, quest=12376, tip="Identical building design as Andorhal. Follow the map marker please.", location="Tarren Mill" },
}
points[ 26 ] = { -- The Hinterlands
	[14194460] = { achievement=966, index=11, quest=12351, tip="The lowest level hillside building.", location="Aerie Peak" },
	[66164443] = { achievement=966, index=12, quest=28970, location="Stormfeather Outpost" },
	[31805787] = { achievement=967, index=13, quest=28971, location="Hiri'watha Research Station" },
	[78198147] = { achievement=967, index=14, quest=12387, tip="Inside the main (only) building", location="Revantusk Village" },
}
points[ 87 ] = { -- Ironforge
	[18345094] = { achievement=966, index=13, quest=12335, tip="Inside the Stonefire Tavern in The Commons", location="The Commons" },
}
points[ 48 ] = { -- Loch Modan
	[83036352] = { achievement=966, index=14, quest=28963, location="Farstrider Lodge" },
	[35544850] = { achievement=966, index=15, quest=12339, location="Thelsamar" },
}
points[ 50 ] = { -- Northern Stranglethorn
	[53166698] = { achievement=966, index=16, quest=28964, location="Fort Livingston" },
	[37385178] = { achievement=967, index=15, quest=12382, tip="At the base of the zeppelin tower", location="Grom'gol Base Camp" },
}
points[ 49 ] = { -- Redridge Mountains
	[26464150] = { achievement=966, index=17, quest=12342, location="Lakeshire" },
}
points[ 49 ] = { -- Redridge Mountains
	[26464150] = { achievement=966, index=17, quest=12342, location="Lakeshire" },
}
points[ 1433 ] = { -- Redridge Mountains
	[27094492] = { achievement=966, index=17, quest=12342, location="Lakeshire" },
}
points[ 32 ] = { -- Searing Gorge
	[39486601] = { achievement=966, index=18, quest=28965, tip="Outside, high up on a perimiter ledge", location="Iron Summit" },
	[39486603] = { achievement=967, index=16, quest=28965, tip="Outside, high up on a perimiter ledge", location="Iron Summit" },
}
points[ 110 ] = { -- Silvermoon City
	[38008479] = { achievement=967, index=9, quest=12364, tip="Go through the \"blue\" doorway", location="Falconwing Square" },
	[67597289] = { achievement=967, index=17, quest=12370, tip="Wayfarer's Rest inn", location="" },
	[70357702] = { achievement=967, index=17, quest=12370, tip="Enter through here!", location="" },
	[79435765] = { achievement=967, index=18, quest=12369, tip="Silvermoon City Inn", location="" },
	[83125829] = { achievement=967, index=18, quest=12369, tip="Enter through here!", location="" },
}
points[ 21 ] = { -- Silverpine Forest
	[44302029] = { achievement=967, index=19, quest=28966, location="Forsaken Rear Guard" },
	[46454290] = { achievement=967, index=20, quest=12371, tip="In the largest building", location="The Sepulcher" },
}
points[ 224 ] = { -- Stranglethorn Vale
	[52094310] = { achievement=966, index=16, quest=28964, location="Fort Livingston" },
	[37897992] = { achievement=966, index=6, quest=12397, tip="It's in the Salty Sailor Tavern", location="Booty Bay" },
	[42213359] = { achievement=967, index=15, quest=12382, tip="At the base of the zeppelin tower", location="Grom'gol Base Camp" },
	[37897994] = { achievement=967, index=5, quest=12397, tip="It's in the Salty Sailor Tavern", location="Booty Bay" },
	[34365192] = { achievement=967, index=6, quest=28969, tip="It's in the building next to the apple bobbing tub", location="Hardwrench Hideaway" },
}
points[ 84 ] = { -- Stormwind City
	[60517534] = { achievement=966, index=19, quest=12336, location="Stormwind City" },
	[75419681] = { achievement=1040, index=1, daily=true, quest=29054, tip="Pickup the quest here from Gretchen Fenlow and\n"
									.."then your broomstick taxi from Gertrude Fenlow,\n"
									.."who is nearby. Soon after completion you could\n"
									.."consider logging out. You will respawn at the Scarlet\n"
									.."Watchtower in Tirisfal Glades. This will save a ton\n"
									.."of time if you also intend doing \"A Time to Lose\".", location="" },									
	[70108390] = { achievement=1040, index=2, daily=true, quest=29144, tip="Pickup the quest from Gretchen Fenlow who is just outside\n"
									.."the Stormwind gates. To see the orange plumes you must\n"
									.."have \"Particle Density\" at least minimally enabled. Go to\n"
									.."System->Graphics->Effects. If you get debuffed then you\n"
									.."may cleanse yourself. Shapeshifting also works.", location="" },
	[74889624] = { achievement=1040, index=4, daily=true, quest=29371, tip="Pickup the quest here from Keira. See my travel notes for\n"
									.."the quest \"Stink Bombs Away\". Take extra care as you\n"
									.."will have no ground/structure cover. My approach is to\n"
									.."fly in from very high and then plummet straight down.", location="" },
	[55006300] = { achievement=1041, index=1, daily=true, quest=29374, tip="If you logout while in Stormwind you'll respawn at the\n"
									.."Eastvale Logging Camp in Elwynn Forest. Handy for\n"
									.."doing \"A Time to Break Down\".", location="" },
	[78918986] = { achievement=1041, index=4, daily=true, quest=29377, tip="The location of the Alliance Wickerman.\n"
									.."Approach from due east. Use the large tree and the ledge\n"
									.."as cover. Stay away from the wall to avoid zoning out and\n"
									.."adding to phasing problems. Reports suggest activating\n"
									.."Warmode in Orgrimmar will help in that respect. Do NOT\n"
									.."try to target the Wickerman. Stand near it and click on\n"
									.."your Dousing Agent. Immediately mount and hit \"space\"\n"
									.."to fly straight up.", location="" },
	[73191967] = { achievement=5837, index=1, quest=29020, tip="Through this portal for the Deepholm candy bucket.\n"
									.."A Vashj'ir portal is closeby too!", location="Temple of Earth" },
}
points[ 51 ] = { -- Swamp of Sorrows
	[71651409] = { achievement=966, index=20, quest=28967, location="Bogpaddle" },
	[28933240] = { achievement=966, index=21, quest=28968, location="The Harborage" },
	[71651411] = { achievement=967, index=21, quest=28967, location="Bogpaddle" },
	[46885692] = { achievement=967, index=22, quest=12384, location="Stonard" },
}
points[ 18 ] = { -- Tirisfal Glades
	[62197300] = { achievement=967, index=25, quest=12368, tip="In Undercity, which is below the Ruins of Lordaeron", location="The Trade Quarter" },
	[60955141] = { achievement=967, index=23, quest=12363, tip="Brill might work as your Hearth for this event for an alt. Quick\n"
                                    .."return from Elwynn after your dailies in Stormwind, plus the\n"
									.."zeppelin post gets me to Kalimdor and Northrend for my Tricks\n"
									.."and Treats circuit. Later I switch to Orgrimmar for Pandaria etc\n"
									.."T&T accessibility. Using Brill avoids the annoying portal from\n"
									.."Orgrimmar into Undercity.", location="Brill" },
	[82987207] = { achievement=967, index=24, quest=28972, location="The Bulwark" },	
	[62136702] = { achievement=1041, index=1, daily=true, quest=29374, tip="Pickup the quest from Candace Fenlow, nearby, and\n"
									.."get your instant taxi from Crina Fenlow. Soon after\n"
									.."completion you could consider logging out. You will\n"
									.."respawn at the Eastvale Logging Camp graveyard in\n"
									.."Elwynn Forest. This will save a ton of time if you also\n"
									.."intend doing \"A Time to Break Down\".", location="" },
	[62436671] = { achievement=1041, index=2, daily=true, quest=29375, tip="Pickup the quest from Candace Fenlow. To see the orange\n"
									.."plumes you must have \"Particle Density\" at least\n"
									.."minimally enabled. Go to System->Graphics->Effects. If\n"
									.."you get debuffed then you may cleanse yourself.\n"
									.."Shapeshifting also works.", location="" },
	[66606200] = { achievement=1041, index=2, daily=true, quest=29375, tip="If things are not \"peaceful\" then do NOT attempt to\n"
									.."enter Lordaeron. Speak to Zidormi who is nearby.", location="" },
	[62126783] = { achievement=1041, index=4, daily=true, quest=29377, tip="Pickup the quest here from Darkcaller Yanks. See my travel\n"
									.."notes for the quest \"Stink Bombs Away\". Approach from\n"
									.."the east, hugging the terrain. A large tree will cover your\n"
									.."final approach.", location="" },
	[61508110] = { achievement=1040, index=1, daily=true, quest=29054, tip="If you logout while in Undercity you'll respawn nearby.\n"
									.."Handy for doing \"A Time to Lose\"", location="" },
	[62406820] = { achievement=1040, index=4, daily=true, quest=29371, tip="The location of the Horde Wickerman.\n"
									.."Approach from as high up as possible. Plummet down.\n"
									.."Land between the Wickerman and the wall, preferably\n"
									.."with a pillar providing a little cover. The pillar where\n"
									.."the green bubbling liquid begins is perfect. Do NOT\n"
									.."try to target the Wickerman. Stand near it and click\n"
									.."on your Dousing Agent. Immediately mount and hit\n"
									.."\"space\" to fly straight up.", location="" },
}
points[ 90 ] = { -- Undercity
	[67753742] = { achievement=967, index=25, quest=12368, location="The Trade Quarter" },
	[76503301] = { achievement=1041, index=2, daily=true, quest=29375, tip="To see the orange plumes you must have \"Particle Density\"\n"
									.."at least minimally enabled via System->Graphics->Effects.", location="" },
	[75703300] = { achievement=1040, index=1, daily=true, quest=29054, tip="If you logout while in Undercity you'll respawn nearby.\n"
									.."Handy for doing \"A Time to Lose\".", location="" },
	[76105320] = { achievement=1040, index=4, daily=true, quest=29371, tip="Logout while in Undercity doing \"Stink Bombs "
									.."Away\"\nfor faster travelling back to Lordaeron.", location="" },
}
points[ 22 ] = { -- Western Plaguelands
	[43388437] = { achievement=966, index=22, quest=28988, location="Chillwind Camp" },
	[48286365] = { achievement=967, index=26, quest=28987, tip="Impossible to describe. Trust in the coordinates / map marker please!", location="Andorhal" },
}
points[ 52 ] = { -- Westfall
	[52915374] = { achievement=966, index=25, quest=12340, tip="In the Inn or atop the tower, depending upon your quest phase.\n"
									.."This map marker is for the inn.", location="Sentinel Hill" },
}
points[ 56 ] = { -- Wetlands
	[10836099] = { achievement=966, index=23, quest=12343, tip="Don't go into the big fort/castle. Go around the back to the inn.", location="Menethil Harbor" },
	[26072598] = { achievement=966, index=24, quest=28990, location="Swiftgear Station" },
	[58213920] = { achievement=966, index=26, quest=28991, tip="Just nearby is an adorable raptor hatchling pet. It's oh so cute.\n"
									.."Steal it from her mother's nest you heartless pet collector!\n"
									.."Oh, did I say that I have an AddOn to help you collect four?", location="Greenwarden's Grove" },
}

-- ============================
-- Outland
-- ============================

points[ 105 ] = { -- Blade's Edge Mountains
	[62903828] = { achievement=969, index=1, quest=12406, tip="Inside the inn, mailbox at the front", location="Evergrove" },
	[35806370] = { achievement=969, index=2, quest=12358, tip="At the rear of the inn, behind the main building", location="Sylvanaar" },
	[61106810] = { achievement=969, index=3, quest=12359, tip="At the rear of the inn. he building has a mailbox", location="Toshley's Station" },
	[62903832] = { achievement=968, index=1, quest=12406, tip="Inside the inn, mailbox at the front", location="Evergrove" },
	[76226039] = { achievement=968, index=2, quest=12394, tip="Inside the main building", location="Mok'Nathal Village" },
	[53435555] = { achievement=968, index=3, quest=12393, tip="Inside the main building", location="Thunderlord Stronghold" },
}
points[ 100 ] = { -- Hellfire Peninsula
	[54206370] = { achievement=969, index=4, quest=12352, tip="In the inn, mailbox at the front", location="Honor Hold" },
	[23403660] = { achievement=969, index=5, quest=12353, tip="In the main building at the end of the promenade", location="Temple of Telhamat" },
	[26905940] = { achievement=968, index=4, quest=12389, tip="In the lower, domed building", location="Falcon Watch" },
	[56803750] = { achievement=968, index=5, quest=12388, tip="In the smaller of the two main buildings", location="Thrallmar" },
}
points[ 107 ] = { -- Nagrand
	[54197588] = { achievement=969, index=6, quest=12357, tip="Below the Flight Master.\nIf mobs are orange it's still okay.", location="Telaar" },
	[56683448] = { achievement=968, index=6, quest=12392, tip="At the centre of the huge round building.\n"
									.."If mobs are orange it's still okay.", location="Garadar" },
}
points[ 109 ] = { -- Netherstorm
	[32006453] = { achievement=969, index=7, quest=12407, tip="A little inside the main building", location="Area 52" },
	[43313608] = { achievement=969, index=8, quest=12408, tip="Fly high up. Inside the lowest building", location="The Stormspire" },
	[32006457] = { achievement=968, index=7, quest=12407, tip="A little inside the main building", location="Area 52" },
	[43313610] = { achievement=968, index=8, quest=12408, tip="Fly high up. Inside the lowest building", location="The Stormspire" },
}
points[ 104 ] = { -- Shadowmoon Valley
	[61002817] = { achievement=969, index=9, quest=12409, tip="You must be Aldor but... if absolutely neutral then your choice.", location="Altar of Sha'tar" },
	[56375980] = { achievement=969, index=9, quest=12409, tip="You must be Scryer but... if absolutely neutral then your choice.", location="Sanctum of the Stars" },
	[37015829] = { achievement=969, index=10, quest=12360, tip="In the dining area of the Kharanos-style inn with\n"
					.."brewing iconography. Don't enter the big building", location="Wildhammer Stronghold" },
	[61002821] = { achievement=968, index=9, quest=12409, tip="You must be Aldor but... if absolutely neutral then your choice.", location="Altar of Sha'tar" },
	[56405982] = { achievement=968, index=9, quest=12409, tip="You must be Scryer but... if absolutely neutral then your choice.", location="Sanctum of the Stars" },
	[30272770] = { achievement=968, index=10, quest=12395, tip="In the main building", location="Shadowmoon Village" },
}
points[ 111 ] = { -- Shattrath City
	[28204900] = { achievement=969, index=11, quest=12404, tip="You must be Aldor but... if absolutely neutral then your choice.", location="Aldor Rise" },
	[56308194] = { achievement=969, index=11, quest=12404, tip="You must be Scryer but... if absolutely neutral then your choice.", location="Scryer's Tier" },
	[28204901] = { achievement=968, index=11, quest=12404, tip="You must be Aldor but... if absolutely neutral then your choice.", location="Aldor Rise" },
	[56308196] = { achievement=968, index=11, quest=12404, tip="You must be Scryer but... if absolutely neutral then your choice.", location="Scryer's Tier" },
}
points[ 108 ] = { -- Terokkar Forest
	[56605320] = { achievement=969, index=12, quest=12356, tip="Inside the only round, domed (elven) building", location="Allerian Stronghold" },
	[48744517] = { achievement=968, index=12, quest=12391, tip="Inside the huge round building", location="Stonebreaker Hold" },
}
points[ 102 ] = { -- Zangarmarsh
	[78456288] = { achievement=969, index=13, quest=12403, tip="Inside the main building", location="Cenarion Refuge" },
	[41902620] = { achievement=969, index=14, quest=12355, tip="Inside the building with the mailbox", location="Orebor Harborage" },
	[67204890] = { achievement=969, index=15, quest=12354, tip="Right next to the innkeeper", location="Telredor" },
	[30625087] = { achievement=968, index=13, quest=12390, tip="The ground level of the inn with no name :(", location="Zabra'jin" },
	[78456290] = { achievement=968, index=14, quest=12403, tip="Inside the main building", location="Cenarion Refuge" },
}
points[ 101 ] = { -- Outland
	[73003880] = { title="Candy Bucket Macro", tip="#showtooltip Handful of Treats\n/use Handful of Treats" },
}

-- ==============================
-- Northrend
-- ==============================

points[ 114 ] = { -- Borean Tundra
	[57071907] = { achievement=5836, index=1, quest=13437, tip="Inside the main building. Icon marks the entrance", location="Fizzcrank Airstrip" },
	[78454914] = { achievement=5836, index=2, quest=13460, tip="Inside the inn / main building which is above the shore", location="Unu'pe" },
	[58526787] = { achievement=5836, index=3, quest=13436, tip="Quite a ways inside the inn, which is adjacent to the Flight Master", location="Valiance Keep" },
	[49750998] = { achievement=5835, index=1, quest=13501, location="Bor'gorok Outpost" },
	[76663747] = { achievement=5835, index=2, quest=13467, location="Taunka'le Village" },
	[78454918] = { achievement=5835, index=3, quest=13460, tip="Inside the inn / main building which is above the shore", location="Unu'pe" },
	[41715440] = { achievement=5835, index=4, quest=13468, tip="The lowest level. Use the south-south-east entrance\n"
									.."at ground level and enter the pidgeon hole in the stairs.\n"
									.."Do NOT ascend those stairs!", location="Warsong Hold" },
}
points[ 127 ] = { -- Crystalsong Forest
	[29003239] = { achievement=5836, index=4, quest=13463, tip="Hey, did you download my \X and Y\" AddOn for cool minimap coordinates!\n"
									.."(Shameless self promotion)", location="The Legerdemain Lounge" },
	[24903750] = { achievement=5836, index=5, quest=13473, tip="Don't go into the Silver Enclave.\nIt's in the adjacent \"A Hero's Welcome\" inn.\n"
					.."Under the stairs on the right side", location="A Hero's Welcome" },
	[27304169] = { achievement=5836, index=6, quest=13472, tip="Cantrips & Crows", location="The Underbelly" },
	[29003241] = { achievement=5835, index=5, quest=13463, tip="Hey, did you download my \X and Y\" AddOn for cool minimap coordinates!\n"
									.."(Shameless self promotion)", location="The Legerdemain Lounge" },
	[30703770] = { achievement=5835, index=6, quest=13474, tip="The Filthy Animal", location="Sunreaver's Sanctuary" },
	[27304171] = { achievement=5835, index=7, quest=13472, tip="Cantrips & Crows", location="The Underbelly" },
}
points[ 125 ] = { -- Dalaran
	[48154127] = { achievement=5836, index=4, quest=13463, tip="Hey, did you download my \X and Y\" AddOn for cool minimap coordinates!\n"
									.."(Shameless self promotion)", location="The Legerdemain Lounge" },
	[42366313] = { achievement=5836, index=5, quest=13473, tip="Don't go into the Silver Enclave.\nIt's in the adjacent \"A Hero's Welcome\" inn.\n"
					.."Under the stairs on the right side", location="A Hero's Welcome" },
	[38225959] = { achievement=5836, index=6, quest=13472, tip="Cantrips & Crows", location="The Underbelly" },
	[48154135] = { achievement=5835, index=5, quest=13463, tip="Hey, did you download my \X and Y\" AddOn for cool minimap coordinates!\n"
									.."(Shameless self promotion)", location="The Legerdemain Lounge" },
	[66703000] = { achievement=5835, index=6, quest=13474, tip="The Filthy Animal", location="Sunreaver's Sanctuary" },
	[38225965] = { achievement=5835, index=7, quest=13472, tip="Cantrips & Crows", location="The Underbelly" },
}
points[ 126 ] = { -- The Underbelly
	[40205949] = { achievement=5836, index=6, quest=13472, tip="Cantrips & Crows", location="The Underbelly" },
	[40205951] = { achievement=5835, index=7, quest=13472, tip="Cantrips & Crows", location="The Underbelly" },
}
points[ 115 ] = { -- Dragonblight
	[48117465] = { achievement=5836, index=7, quest=13459, location="Moa'ki Harbor" },
	[28955622] = { achievement=5836, index=8, quest=13438, location="Stars' Rest" },
	[77285099] = { achievement=5836, index=9, quest=13439, tip="Icon marks the entrance to the inn. It's the closest building to the Flight Master", location="Wintergarde Keep" },
	[60155343] = { achievement=5836, index=10, quest=13456, tip="The ground floor. Use the nearest entrance to the Gryphon Master", location="Wyrmrest Temple" },
	[37834647] = { achievement=5835, index=8, quest=13469, location="Agmar's Hammer" },
	[48117466] = { achievement=5835, index=9, quest=13459, location="Moa'ki Harbor" },
	[76826328] = { achievement=5835, index=10, quest=13470, location="Venomspite" },
	[60155347] = { achievement=5835, index=11, quest=13456, tip="The ground floor. Use the nearest entrance to the Flight Master", location="Wyrmrest Temple" },
}
points[ 116 ] = { -- Grizzly Hills
	[31946021] = { achievement=5836, index=11, quest=12944, location="Amberpine Lodge" },
	[59642636] = { achievement=5836, index=12, quest=12945, location="Westfall Brigade" },
	[65364700] = { achievement=5835, index=12, quest=12947, location="Camp Oneqwah" },
	[20896477] = { achievement=5835, index=13, quest=12946, location="Conquest Hold" },
}
points[ 117 ] = { -- Howling Fjord
	[60481591] = { achievement=5836, index=13, quest=13435, location="Fort Wildervar" },
	[25315912] = { achievement=5836, index=14, quest=13452, tip="Icon marks the entrance to the subterranean Inn", location="Kamagua" },
	[58676316] = { achievement=5836, index=15, quest=13433, tip="The Inn entrance is at the side....\nThe Penny Pouch is awesome!\nNot :/", location="Valgarde" },
	[30834205] = { achievement=5836, index=16, quest=13434, tip="The usual :). Icon marks the inn entrance", location="Westguard Keep" },
	[49401080] = { achievement=5835, index=14, quest=13464, location="Camp Winterhoof" },
	[25315916] = { achievement=5835, index=15, quest=13452, tip="Icon marks the entrance to the subterranean Inn", location="Kamagua" },
	[52106620] = { achievement=5835, index=16, quest=13465, location="New Agamand" },
	[79273063] = { achievement=5835, index=17, quest=13466, tip="The Inn entrance is at the side....\nThe Penny Pouch is awesome!\nNot :/", location="Vengeance Landing" },
}
points[ 119 ] = { -- Sholazar Basin
	[26615918] = { achievement=5836, index=17, quest=12950, tip="At the rear of the larger tent", location="Nesingwary Base Camp" },
	[26615922] = { achievement=5835, index=18, quest=12950, tip="At the rear of the larger tent", location="Nesingwary Base Camp" },
}
points[ 120 ] = { -- Storm Peaks
	[30583693] = { achievement=5836, index=18, quest=13462, tip="Quest phasing issues reported. Icon marks the entrance", location="Bouldercrag's Refuge" },
	[28727428] = { achievement=5836, index=19, quest=13448, location="Frosthold" },
	[40938594] = { achievement=5836, index=20, quest=13461, tip="Icon marks the entrance to the Inn. Surprise!", location="K3" },
	[30583695] = { achievement=5835, index=19, quest=13462, tip="Quest phasing issues reported. Icon marks the entrance", location="Bouldercrag's Refuge" },
	[67655069] = { achievement=5835, index=20, quest=13471, location="Camp Tunka'lo" },
	[37094951] = { achievement=5835, index=21, quest=13548, location="Grom'arsh Crash Site" },
	[40938596] = { achievement=5835, index=22, quest=13461, tip="Icon marks the entrance to the Inn. Surprise!", location="K3" },
}
points[ 121 ] = { -- Zul'Drak
	[40866602] = { achievement=5836, index=21, quest=12941, location="The Argent Stand" },
	[59335719] = { achievement=5836, index=22, quest=12940, tip="Hey, why not change the icons!\n"
									.."ESC->Interface->AddOns->HandyNotes->Plugins expand->Hallow's End", location="Zim'Torga" },
	[40866606] = { achievement=5835, index=23, quest=12941, location="The Argent Stand" },
	[59335723] = { achievement=5835, index=24, quest=12940, tip="Hey, why not change the icons!\n"
									.."ESC->Interface->AddOns->HandyNotes->Plugins expand->Hallow's End", location="Zim'Torga" },
}

-- ==================================
-- Cataclysm
-- ==================================

points[ 207 ] = { -- Deepholm
	[47365171] = { achievement=5837, index=1, quest=29020, location="Temple of Earth" },
	[51194990] = { achievement=5838, index=1, quest=29019, location="Temple of Earth" },
}
local experiment = "The lake area behind the Nordrassil inn is the perfect place to\n"
					.."experiment with your advanced graphics settings. Particle Density,\n"
					.."Ground Clutter, and Liquid Detail in particular are worth trying.\n"
					.."So divinely serene and gorgeous!"
points[ 198 ] = { -- Mount Hyjal
	[18633731] = { achievement=5837, index=2, quest=29000, tip="Just this once max out \"Ground Clutter\" in your settings. You're welcome!", location="Grove of Aessina" },
	[63052414] = { achievement=5837, index=3, quest=28999, location="Nordrassil" },
	[42684571] = { achievement=5837, index=4, quest=29001, location="Shrine of Aviana" },
	[18633733] = { achievement=5838, index=2, quest=29000, tip="Just this once max out \"Ground Clutter\" in your settings. You're welcome!", location="Grove of Aessina" },
	[63052416] = { achievement=5838, index=3, quest=28999, location="Nordrassil" },
	[42684573] = { achievement=5838, index=4, quest=29001, location="Shrine of Aviana" },
}
points[ 241 ] = { -- Twilight Highlands
	[60365825] = { achievement=5837, index=5, quest=28977, tip="The village is under attack but the dwarves\n"
									.."saved their blessed tavern. Priorities!", location="Firebeard's Patrol" },
	[78877780] = { achievement=5837, index=6, quest=28980, tip="Regardless of quest phase, you'll be okay for the candy bucket.\n"
									.."From the entrance straight to the courtyard. Right then left. ", location="Highbank" },
	[49603036] = { achievement=5837, index=7, quest=28978, tip="The building with the mailbox.", location="Thundermar" },
	[43505727] = { achievement=5837, index=8, quest=28979, location="Victor's Point" },
	[53404284] = { achievement=5838, index=5, quest=28973, tip="Ground floor, main building", location="Bloodgulch" },
	[45127681] = { achievement=5838, index=6, quest=28974, tip="Inside the only building", location="Crushblow" },
	[75411653] = { achievement=5838, index=7, quest=28976, tip="Difficult to describe - trust in the coordinates please!\n"
									.."Or... just look for the apple bobbing tub at the doorway!", location="The Krazzworks" },
	[75365492] = { faction="Horde", title="Dragonmaw Port", quest=28975, tip="To see the liberated version of Dragonmaw Port\n"
									.."you must have completed the zone storyline up\n"
									.."to \"Returning to the Highlands\". The flight point\n"
									.."becomes available then too." },
}
points[ 249 ] = { -- Uldum
	[26600725] = { achievement=5837, index=9, quest=29016, tip="Why not grab the cool Springfur Alpaca mount while you're here!\n"
									.."You guessed it, sigh. I've an AddOn for that too! :)", location="Oasis of Vir'sar" },
	[54682999] = { achievement=5837, index=10, quest=29017, location="Ramkahen" },
	[26600727] = { achievement=5838, index=8, quest=29016, tip="Why not grab the cool Springfur Alpaca mount while you're here!\n"
									.."You guessed it, sigh. I've an AddOn for that too! :)", location="Oasis of Vir'sar" },
	[54683301] = { achievement=5838, index=9, quest=29017, location="Ramkahen" },
}
points[ 1527 ] = { -- Wrong Uldum
	[26580722] = { achievement=5837, index=9, quest=29016, tip="\124cFFFF0000Wrong version of Uldum. Speak to Zidormi." },
	[54682999] = { achievement=5837, index=10, quest=29017, tip="\124cFFFF0000Wrong version of Uldum. Speak to Zidormi." },
	[26600726] = { achievement=5838, index=8, quest=29016, tip="\124cFFFF0000Wrong version of Uldum. Speak to Zidormi." },
	[54683301] = { achievement=5838, index=9, quest=29017, tip="\124cFFFF0000Wrong version of Uldum. Speak to Zidormi." },
}
points[ 204 ] = { -- Abyssal Depths in Vashj'ir
	[61897915] = { achievement=5837, index=11, quest=28985, tip="Inside Darkbreak Cove. Dive straight down. The icon marks the entrance.\n"
									.."The cave may appear empty, Give the art assets time to appear.", location="" },
	[94867350] = { achievement=5838, index=11, quest=28984, tip="Inside Legion's Rest. Dive straight down. The icon marks the entrance" },
	[60005670] = { achievement=5838, index=13, quest=28986, tip="Inside Tenebrous Cove. Dive straight down. The icon marks the entrance", location="" },
}
points[ 201 ] = { -- Kelp'thar Forest in Vashj'ir
	[60686609] = { achievement=5837, index=12, quest=28981, tip="Inside Deepmist Grotto. Dive straight down. The icon marks the entrance", location="" },
	[60686610] = { achievement=5838, index=10, quest=28981, tip="Inside Deepmist Grotto. Dive straight down. The icon marks the entrance", location="" },
}
points[ 205 ] = { -- Shimmering Expanse in Vashj'ir
	[20007114] = { achievement=5837, index=11, quest=28985, tip="Inside Darkbreak Cove. Dive straight down. The icon marks the entrance.\n"
									.."The cave may appear empty, Give the art assets time to appear.", location="" },
	[68261539] = { achievement=5837, index=12, quest=28981, tip="Inside Deepmist Grotto. Dive straight down. The icon marks the entrance", location="" },
	[51564153] = { achievement=5837, index=13, quest=28982, tip="Inside Silver Tide Hollow. Dive straight down. The icon marks the entrance", location="" },
	[45025707] = { achievement=5837, index=14, quest=28983, tip="Inside the Tranquil Wash. Dive straight down. The icon marks the entrance", location="" },
	[68261540] = { achievement=5838, index=10, quest=28981, tip="Inside Deepmist Grotto. Dive straight down. The icon marks the entrance", location=" " },
	[47706640] = { achievement=5838, index=11, quest=28984, tip="Inside Legion's Rest. Dive straight down. The icon marks the entrance" },
	[51564155] = { achievement=5838, index=12, quest=28982, tip="Inside Silver Tide Hollow. Dive straight down. The icon marks the entrance", location="" },
	[18415228] = { achievement=5838, index=13, quest=28986, tip="Inside Tenebrous Cove. Dive straight down. The icon marks the entrance", location="" },
}
-- The Maelstrom map is not treated as a continent in the game (or is it Handy Notes?) so I need to include it here
points[ 948 ] = { -- The Maelstrom
	[50002900] = { achievement=5837, index=1, quest=29020, tip="Access via the Cataclysm portal cluster in Stormwind.", location="Temple of Earth" },
	[50002901] = { achievement=5838, index=1, quest=29019, tip="Access via the Cataclysm portal cluster in Orgrimmar.", location="Temple of Earth" },
}

-- =================================
-- Pandaria
-- =================================

points[ 422 ] = { -- Dread Wastes
	[55933227] = { achievement=7601, index=1, quest=32024, location="Klaxxi'vess" },
	[55217119] = { achievement=7601, index=2, quest=32023, tip="Inside The Chum Bucket Inn", location="Soggy's Gamble" },
	[55933229] = { achievement=7602, index=1, quest=32024, location="Klaxxi'vess" },
	[55217121] = { achievement=7602, index=2, quest=32023, tip="Inside The Chum Bucket Inn", location="Soggy's Gamble" },
}
points[ 371 ] = { -- The Jade Forest
	[45774360] = { achievement=7601, index=3, quest=32027, tip="Inside The Drunken Hozen Inn", location="Dawn's Blossom" },
	[48093462] = { achievement=7601, index=4, quest=32029, location="Greenstone Village" },
	[54606333] = { achievement=7601, index=5, quest=32032, tip="Inside The Dancing Serpent Inn", location="Jade Temple Grounds" },
	[44818437] = { achievement=7601, index=6, quest=32049, tip="First visit to Pandaria? Always grab those flight points!", location="Paw'don Village" },
	[59568324] = { achievement=7601, index=7, quest=32033, location="Pearlfin Village" },
	[55712441] = { achievement=7601, index=8, quest=32031, tip="Yeah... it's inside the Inn!", location="Sri-La Village" },
	[41682313] = { achievement=7601, index=9, quest=32021, tip="Inside Paur's Pub", location="Tian Monastery" },
	[45774361] = { achievement=7602, index=3, quest=32027, tip="Inside The Drunken Hozen Inn", location="Dawn's Blossom" },
	[48093463] = { achievement=7602, index=4, quest=32029, location="Greenstone Village" },
	[28024738] = { achievement=7602, index=5, quest=32028, tip="The candy bucket is present even if you have\nnot yet made the Grookin friendly.", location="Grookin Hill" },
	[28451327] = { achievement=7602, index=6, quest=32050, location="Honeydew Village" },
	[54606334] = { achievement=7602, index=7, quest=32032, tip="Inside The Dancing Serpent Inn", location="Jade Temple Grounds" },
	[55712440] = { achievement=7602, index=8, quest=32031, tip="Yeah... it's inside the Inn!", location="Sri-La Village" },
	[41692315] = { achievement=7602, index=9, quest=32021, tip="Inside Paur's Pub", location="Tian Monastery" },
	[23326072] = { achievement=7601, index=17, quest=32026, tip="Tavern in the Mists", location="" },
	[23326074] = { achievement=7602, index=19, quest=32026, tip="Tavern in the Mists", location="" },
}
points[ 418 ] = { -- Krasarang Wilds
	[51407728] = { achievement=7601, index=10, quest=32034, tip="The \"Bait and Brew\". Pretty much the only building", location="Marista" },
	[75920686] = { achievement=7601, index=11, quest=32036, tip="In the Wilds' Edge Inn", location="Zhu's Watch" },
	[28255074] = { achievement=7602, index=10, quest=32020, location="Dawnchaser Retreat" },
	[51417730] = { achievement=7602, index=11, quest=32034, tip="The \"Bait and Brew\". Pretty much the only building", location="Marista" },
	[61152504] = { achievement=7602, index=12, quest=32047, location="Thunder Cleft" },
	[75920688] = { achievement=7602, index=13, quest=32036, tip="In the Wilds' Edge Inn", location="Zhu's Watch" },
}

points[ 379 ] = { -- Kun-Lai Summit
	[72729229] = { achievement=7601, index=12, quest=32039, tip="Inside the Binan Brew and Chunder Inn", location="Binan Village" },
	[64206127] = { achievement=7601, index=13, quest=32041, tip="Inside The Two Fisted Brew", location="The Grummle Bazaar" },
	[57455995] = { achievement=7601, index=14, quest=32037, tip="Inside The Lucky Traveller", location="One Keg" },
	[54078281] = { achievement=7601, index=15, quest=32042, tip="Phasing issue here. Go to Binan Village. Complete \"Hit Medicine\",\n"
									.."\"Call Out Their Leader\", \"All of the Arrows\". Then complete\n"
									.."\"Admiral Taylor...\". Then \"Westwind Rest\" by heading over\n"
									.."towards Westwind. Finally complete \"Challenge Accepted\" from\n"
									.."Elder Tsulan. Voilà - unlocked!", location="Westwind Rest" },
	[62502901] = { achievement=7601, index=16, quest=32051, tip="Inside the North Wind Tavern. Right near the Flight Master", location="Zouchin Village" },
	[72749227] = { achievement=7602, index=14, quest=32039, tip="Inside the Binan Brew and Chunder Inn", location="Binan Village" },
	[62778050] = { achievement=7602, index=15, quest=32040, tip="Phasing issue here. Go to Binan Village. Complete \"Hit Medicine\",\n"
									.."\"Call Out Their Leader\", \"All of the Arrows\". Then complete\n"
									.."\"General Nazgrim...\". Then \n\"Eastwind Rest\" by heading over\n"
									.."towards Eastwind. Finally complete \"Challenge Accepted\" from\n"
									.."Elder Shiao. Voilà - unlocked!", location="Eastwind Rest" },
	[64226128] = { achievement=7602, index=16, quest=32041, tip="Inside The Two Fisted Brew", location="The Grummle Bazaar" },
	[57455994] = { achievement=7602, index=17, quest=32037, tip="Inside The Lucky Traveller", location="One Keg" },
	[62502900] = { achievement=7602, index=18, quest=32051, tip="Inside the North Wind Tavern. Right near the Flight Master", location="Zouchin Village" },
}
points[ 433 ] = { -- The Veiled Stair, Tavern in the Mists
	[55117223] = { achievement=7601, index=17, quest=32026, tip="Taraezor has lots of handy \"HandyNotes\" AddOns!", location="" },
	[55117225] = { achievement=7602, index=19, quest=32026, tip="Taraezor has lots of handy \"HandyNotes\" AddOns!", location="" },
}
points[ 388 ] = { -- Townlong Steppes, Longying Outpost
	[71135777] = { achievement=7601, index=18, quest=32043, location="" },
	[71145779] = { achievement=7602, index=20, quest=32043, location="" },
}
points[ 390 ] = { -- Vale of Eternal Blossoms
	[35147776] = { achievement=7601, index=19, quest=32044, tip="In The Golden Rose inn", location="Mistfall Village" },
	[87036900] = { achievement=7601, index=20, quest=32052, tip="In the Golden Lantern inn.\nThe inn is on the "
									.."right side of the Shrine's entrance", location="" },
	[35127781] = { achievement=7602, index=21, quest=32044, tip="In The Golden Rose inn", location="Mistfall Village" },
	[61981626] = { achievement=7602, index=22, quest=32022, tip="From the main entrance go up the stairs on the right side.\n"
									.."Go through each room until you arrive at the balcony /\n"
									.."mezzanine of The Keggary.", location="Shrine of Two Moons" },
}
points[ 393 ] = { -- Shrine of the Seven Stars
	[37856590] = { achievement=7601, index=20, quest=32052, tip="In the Golden Lantern inn.\nThe inn is on the "
									.."right side of the Shrine's entrance", location="" },
}
points[ 392 ] = { -- The Imperial Mercantile
	[58877836] = { achievement=7602, index=22, quest=32022, tip="From the main entrance go up the stairs on the right side.\n"
									.."Go through each room until you arrive at the balcony /\n"
									.."mezzanine of The Keggary.", location="Shrine of Two Moons" },
}
points[ 376 ] = { -- Valley of the Four Winds
	[83642013] = { achievement=7601, index=21, quest=32048, tip="Hey, you know that you can change the icons?\n"
									.."ESC->Interface->AddOns->HandyNotes->Plugins expand->Hallow's End", location="Pang's Stead" },
	[19875578] = { achievement=7601, index=22, quest=32046, tip="Yeah.. another inn... The Stone Mug Tavern", location="Stoneplow" },
	[83642015] = { achievement=7602, index=23, quest=32048, tip="Hey, you know that you can change the icons?\n"
									.."ESC->Interface->AddOns->HandyNotes->Plugins expand->Hallow's End", location="Pang's Stead" },
	[19885577] = { achievement=7602, index=24, quest=32046, tip="Yeah.. another inn... The Stone Mug Tavern", location="Stoneplow" },
	[72751031] = { achievement=7601, index=17, quest=32026, tip="Tavern in the Mists", location="" },
	[72751033] = { achievement=7602, index=19, quest=32026, tip="Tavern in the Mists", location="" },
}

-- =====================================
-- Garrison / Draenor
-- =====================================

local draenorS = "You must have a Tier 3 Town Hall or else\n"
				.."the Candy Bucket will not be present."
local draenorD = "Orukan has four dailies and Izzy Hollyfizzle\n"
				.."sells Garrison decorations, purchasable only\n"
				.."with the daily rewards. A Tier 3 Town Hall is\n"
				.."required for these NPCs to appear."

points[ 582 ] = { -- Lunarfall Garrison in Draenor
	[43515151] = { faction="Alliance", title="Draenor / Lunarfall Garrison", quest=39657, tip=draenorS },
	[44405180] = { faction="Alliance", title="Draenor / Lunarfall Garrison", daily=true, quest=39719, tip=draenorD },
	[29003440] = { faction="Alliance", title="Get Spooky - Garrison Mission", tip="Rarely and randomly occurs. Rewards 15 candy!" },
}
points[ 539 ] = { -- Shadowmoon Valley in Draenor
	[30011780] = { faction="Alliance", title="Draenor / Lunarfall Garrison", quest=39657, tip=draenorS },
	[30251805] = { faction="Alliance", title="Draenor / Lunarfall Garrison", daily=true, quest=39719, tip=draenorD },
	[28701600] = { faction="Alliance", title="Get Spooky - Garrison Mission", tip="Rarely and randomly occurs. Rewards 15 candy!" },
}
points[ 590 ] = { -- Frostwall Garrison in Draenor
	[46993759] = { faction="Horde", title="Draenor / Frostwall Garrison", quest=39657, tip=draenorS },
	[47903790] = { faction="Horde", title="Draenor / Frostwall Garrison", daily=true, quest=39719, tip=draenorD },
	[41005300] = { faction="Horde", title="Get Spooky - Garrison Mission", tip="Rarely and randomly occurs. Rewards 15 candy!" },
}
points[ 525 ] = { -- Frostfire Ridge in Draenor
	[48256435] = { faction="Horde", title="Draenor / Frostwall Garrison", quest=39657, tip=draenorS },
	[48506460] = { faction="Horde", title="Draenor / Frostwall Garrison", daily=true, quest=39719, tip=draenorD },
	[46006800] = { faction="Horde", title="Get Spooky - Garrison Mission", tip="Rarely and randomly occurs. Rewards 15 candy!" },
}

-- =====================================
-- Legion / Broken Isles
-- =====================================

points[ 627 ] = { -- Dalaran Broken Isles
	[41476398] = { faction="Alliance", title="Dalaran Broken Isles", quest=43056, tip="In \"A Hero's Welcome\" inn." },
	[47964178] = { faction="Neutral", title="Dalaran Broken Isles", quest=43055, tip="In The Legerdemain Lounge." },
	[47294077] = { faction="Neutral", title="Beware of the Crooked Tree", quest=43259, tip="Speak to Duroc Ironjaw. "
								.."This is a simple \"fly to X\" quest\nbut with very "
								.."worthwhile XP, especially for a trivial flight.\n"
								.."The quest that follows is devilishly difficult and "
								.."is not\nrecommended. Just hearth/fly back to Dalaran." },
	[67042941] = { faction="Horde", title="Dalaran Broken Isles", quest=43057, tip="In \"The Filthy Animal\" inn." },
	[59174564] = { achievement=291, 0, tip="Just stand here with a cuppa and wait. Couldn't be easier." },
}

-- =====================================
-- Battle for Azeroth
-- =====================================

points[ 1163 ] = { -- Dazar'alor - The Great Seal
	[49828478] = { faction="Horde", title="Zuldazar", quest=54709, tip="In \"The Great Seal\" in Dazar'alor." },
}
points[ 1164 ] = { -- Dazar'alor - The Hall of Chroniclers
	[49828478] = { faction="Horde", title="Zuldazar", quest=54709, tip="In \"The Great Seal\" in Dazar'alor." },
}
points[ 1165 ] = { -- Dazar'alor
	[50014684] = { faction="Horde", title="Zuldazar", quest=54709, tip="In \"The Great Seal\" in Dazar'alor." },
}
points[ 862 ] = { -- Zuldazar
	[57984468] = { faction="Horde", title="Zuldazar", quest=54709, tip="In \"The Great Seal\" in Dazar'alor." },
}
points[ 1161 ] = { -- Boralus - Tiragarde Sound
	[73701219] = { faction="Alliance", title="Boralus Harbor", quest=54710, tip="In the \"Snug Harbor Inn\"." },
}
points[ 895 ] = { -- Tiragarde Sound
	[75182272] = { faction="Alliance", title="Boralus Harbor", quest=54710, tip="In the \"Snug Harbor Inn\"." },
}

-- =====================================
-- Dragon Isles
-- =====================================

points[ 2023 ] = { -- Ohn'ahran Plains
	[46224060] = { achievement=18360, index=1, quest=75681 }, -- Broadhoof Outpost
	[66252453] = { achievement=18360, index=2, quest=75693 }, -- Emberwatch
	[72138039] = { achievement=18360, index=3, quest=75692 }, -- Forkriver Crossing
	[62934056] = { achievement=18360, index=4, quest=75685 }, -- Maruukaï
	[57137670] = { achievement=18360, index=5, quest=75687 }, -- Ohn'iri Springs
	[81285921] = { achievement=18360, index=6, quest=75688 }, -- Pinewood Post
	[85853536] = { achievement=18360, index=7, quest=75689 }, -- Rusza'thar Reach
	[28646056] = { achievement=18360, index=8, quest=75686 }, -- Shady Sanctuary
	[41916044] = { achievement=18360, index=9, quest=75691 }, -- Teerakaï
	[85042604] = { achievement=18360, index=10, quest=75690 }, -- Timberstep Outpost
}
points[ 2025 ] = { -- Thaldraszus
	[50084273] = { achievement=18360, index=11, quest=75698 }, -- Algeth'era Court
	[35087920] = { achievement=18360, index=12, quest=75696 }, -- Garden Shrine
	[52416981] = { achievement=18360, index=13, quest=75697 }, -- Gelikyr Post
	[59858269] = { achievement=18360, index=14, quest=75695 }, -- Temporal Conflux
	[43175940] = { achievement=18360, index=15, quest=75700 }, -- Valdrakken - The Parting Glass
	[39535922] = { achievement=18360, index=16, quest=75699 }, -- Valdrakken - The Roasted Ram
	[35955841] = { achievement=18360, index=17, quest=75701 }, -- Valdrakken - Weyrnrest
}
points[ 2024 ] = { -- The Azure Span
	[47034026] = { achievement=18360, index=18, quest=75667 }, -- Camp Antonidas
	[62795774] = { achievement=18360, index=19, quest=75668 }, -- Camp Nowhere
	[12384936] = { achievement=18360, index=20, quest=75669 }, -- Iskaara
	[65501625] = { achievement=18360, index=21, quest=75670 }, -- Theron's Watch
	[18812455] = { achievement=18360, index=22, quest=75671 }, -- Three-Falls Lookout
}
points[ 2151 ] = { -- The Forbidden Reach
	[33855881] = { achievement=18360, index=23, quest=75702 }, -- Morqut Village
}
points[ 2022 ] = { -- The Waking Shores
	[24468210] = { achievement=18360, index=24, quest=75672 }, -- Apex Observatory
	[47678330] = { achievement=18360, index=25, quest=75673 }, -- Dragonscale Basecamp
	[65225793] = { achievement=18360, index=26, quest=75675 }, -- Life Vault Ruins
	[43106666] = { achievement=18360, index=27, quest=77698 }, -- Obsidian Bulwark
	[25775518] = { achievement=18360, index=28, quest=75676 }, -- Obsidian Throne
	[58036731] = { achievement=18360, index=29, quest=75674 }, -- Ruby Lifeshrine
	[76065774] = { achievement=18360, index=30, quest=75677 }, -- Skytop Observatory
	[53913903] = { achievement=18360, index=31, quest=75678 }, -- Uktulut Backwater
	[46432740] = { achievement=18360, index=32, quest=75679 }, -- Uktulut Pier
	[80422788] = { achievement=18360, index=33, quest=75682, faction="Horde" }, -- Wild Coast
	[80422788] = { achievement=18360, index=33, quest=75681, faction="Alliance" }, -- Wild Coast
	[76213541] = { achievement=18360, index=34, quest=75683 }, -- Wingrest Embassy
}
points[ 2112 ] = { -- Valdrakken
	[72374667] = { achievement=18360, index=15, quest=75700 }, -- The Parting Glass
	[47164545] = { achievement=18360, index=16, quest=75699 }, -- The Roasted Ram
	[22413985] = { achievement=18360, index=17, quest=75701 }, -- Weyrnrest
}
points[ 2133 ] = { -- Zaralek Cavern
	[56375635] = { achievement=18360, index=35, quest=75704 }, -- Loamm
	[52122645] = { achievement=18360, index=36, quest=75703 }, -- Obsidian Rest
}

-- =====================================
-- Continents & Sub-Continents
-- =====================================

points[ 12 ] = { -- Kalimdor
	-- Azuremyst Isle
	[32402650] = { achievement=963, index=2, quest=12333, location="Azure Watch" },
	-- Teldrassil
	[43711023] = { achievement=963, index=25, quest=12331, location="Dolanaar" },
	[40320891] = { achievement=963, index=5, quest=12334, location="Craftsmen's Terrace" },
}
points[ 947 ] = { -- Azeroth
	[70707500] = { title="Candy Bucket Macro", tip="#showtooltip Handful of Treats\n/use Handful of Treats" },
	[45194849] = { achievement=5837, index=1, quest=29020, tip="Access via the Cataclysm portal cluster in Stormwind.", location="Temple of Earth" },
	[45194851] = { achievement=5838, index=1, quest=29019, tip="Access via the Cataclysm portal cluster in Orgrimmar.", location="Temple of Earth" },
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

scalingL[1] = 0.55
scalingL[2] = 0.55
scalingL[3] = 0.55
scalingL[4] = 0.55
scalingL[5] = 0.55
scalingL[6] = 0.55
scalingL[7] = 0.65
scalingL[8] = 0.62
scalingL[9] = 0.75
scalingL[10] = 0.75
scalingL[11] = 0.44
scalingL[12] = 0.40
scalingL[13] = 0.415
scalingL[14] = 0.40
scalingL[15] = 0.42
scalingL[16] = 0.415
scalingL[17] = 0.415
scalingS[1] = 0.37
scalingS[2] = 0.49
scalingS[3] = 0.49
scalingS[4] = 0.49
scalingS[5] = 0.43
scalingS[6] = 0.41
scalingS[7] = 0.395
scalingS[8] = 0.57
scalingS[9] = 0.44
scalingS[10] = 0.40
scalingS[11] = 0.415
scalingS[12] = 0.40
scalingS[13] = 0.42
scalingS[14] = 0.415
scalingS[15] = 0.415

