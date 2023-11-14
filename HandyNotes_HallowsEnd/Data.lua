local _, ns = ...
local points = ns.points
local texturesL = ns.texturesL
local scalingL = ns.scalingL
local texturesS = ns.texturesS
local scalingS = ns.scalingS

-- =====================================
-- Kalimdor
-- =====================================

local hatchling = "Grab a Leaping Hatchling pet from nearby... oh yeah, did I mention that I\n"
				.."have an AddOn for that too? Collect all four of the adorable raptor pets!"
local teldrassil = "Speak to Zidormi in Darkshore if Teldrassil seems somewhat destroyed!"

points[ 97 ] = { -- Azuremyst Isle
	[48494905] = { aIDA=963, indexA=2, quest=12333, location="Azure Watch" },
	[29293485] = { aIDA=963, indexA=9, quest=12337, location="Seat of the Naaru", tip="In the Exobar" },
}
points[ 1943 ] = { -- Azuremyst Isle
	[48494905] = { aIDA=963, indexA=9, quest=12333, location="Azure Watch" },
	[29293485] = { aIDA=963, indexA=9, quest=12337, location="Seat of the Naaru", tip="In the Exobar" },
}
points[ 106 ] = { -- Bloodmyst Isle
	[55695997] = { aIDA=963, indexA=3, quest=12341, location="Blood Watch" },
}
points[ 1950 ] = { -- Bloodmyst Isle
	[55695997] = { aIDA=963, indexA=5, quest=12341, location="Blood Watch" },
}
points[ 63 ] = { -- Ashenvale
	[02216659] = { aIDA=963, indexA=21, quest=29012, location="Thal'darah Overlook" },
	[13003410] = { aIDH=965, indexH=4, quest=28989, location="Zoram'gar Outpost" },
	[13369829] = { aIDH=965, indexH=25, quest=12378, location="Sun Rock Retreat" },
	[22229064] = { aIDA=963, indexA=22, quest=29011, location="Windshear Hold", tip="Fallowmere Inn" },
	[29859870] = { aIDH=965, indexH=24, quest=29009, location="Krom'gar Fortress", tip="Inside the smallest building" },
	[37014926] = { aIDA=963, indexA=1, quest=12345, location="Astranaar", tip="Your quest phase does not matter - the bucket is always available" },
	[38654234] = { aIDH=965, indexH=1, quest=28958, location="Hellscream's Watch", tip="Outside, easy to see" },
	[50256727] = { aIDH=965, indexH=2, quest=28953, location="Silverwind Refuge" },
	[73966060] = { aIDH=965, indexH=3, quest=12377, location="Splintertree Post", tip="Follow the map marker for the correct building" },
	[88269101] = { aIDH=965, indexH=18, quest=29003, location="Nozzlepot's Outpost" },
}
points[ 1440 ] = { -- Ashenvale
	[37014926] = { aIDA=963, indexA=6, quest=12345, location="Astranaar" },
	[73966060] = { aIDH=965, indexH=6, quest=12377, location="Splintertree Post" },
}
points[ 76 ] = { -- Azshara
	[57115017] = { aIDH=965, indexH=5, quest=28992, location="Bilgewater Harbor",
						tip="Exclusive Taraezor tip! Pause to check your map while you are\n"
							.."inside the inn next to the candy bucket. You want to stretch\nthat rested bonus for as long as possible!" },
}
points[ 62 ] = { -- Darkshore
	[50791890] = { aIDA=963, indexA=4, quest=28951, location="Lor'danel",
						tip="Exclusive Taraezor tip! Pause to check your map while you are\n"
							.."inside the inn next to the candy bucket. You want to stretch\nthat rested bonus for as long as possible!" },
	[60665005] = { aIDA=963, indexA=11, aIDH=965, indexH=11, quest=28994, neighbour=true, location="Whisperwind Grove" },
	[73277154] = { aIDA=5837, indexA=2, aIDH=5838, indexH=2, quest=29000, neighbour=true, location="Grove of Aessina" },
	[76874791] = { aIDA=963, indexA=10, quest=28995, neighbour=true, location="Talonbranch Glade" },
	[89077706] = { aIDA=5837, indexA=4, aIDH=5838, indexH=4, quest=29001, neighbour=true, location="Shrine of Aviana" },
}
points[ 1439 ] = { -- Darkshore
	[37004410] = { aIDA=963, indexA=1, quest=28951, location="Lor'danel",
						tip="Exclusive Taraezor tip! Pause to check your map while you are\n"
							.."inside the inn next to the candy bucket. You want to stretch\nthat rested bonus for as long as possible!" },
}
points[ 89 ] = { -- Darnassus
	[62283315] = { aIDA=963, indexA=5, quest=12334, location="Craftsmen's Terrace" },
}
points[ 1457 ] = { -- Darnassus
	[67401600] = { aIDA=963, indexA=16, quest=12334, location="Craftsmen's Terrace" },
}
points[ 66 ] = { -- Desolace
	[24076829] = { aIDH=965, indexH=7, quest=12381, location="Shadowprey Village" },
	[56725012] = { aIDA=963, indexA=6, aIDH=965, indexH=6, quest=28993, location="Karnum's Glade" },
	[66330659] = { aIDA=963, indexA=7, quest=12348, location="Nigel's Point" },
	[93265850] = { aIDH=965, indexH=17, quest=12367, location="Lower Rise", tip="Inside \"The Cat and the Shaman\" inn" },
}
points[ 1443 ] = { -- Desolace
	[24076829] = { aIDH=965, indexH=3, quest=12381, location="Shadowprey Village" },
	[66330659] = { aIDA=963, indexA=3, quest=12348, location="Nigel's Point" },
}
points[ 1 ] = { -- Durotar
	[12876288] = { aIDH=965, indexH=16, quest=12374, location="The Crossroads" },
	[20144344] = { aIDH=965, indexH=17, quest=29002, location="Grol'dom Farm" },
	[26991798] = { aIDH=965, indexH=18, quest=29003, location="Nozzlepot's Outpost" },
	[32248109] = { aIDA=963, indexA=14, aIDH=965, indexH=19, quest=12396, location="Ratchet", tip=hatchling },
	[46940672] = { aIDH=965, indexH=20, quest=12366, location="Valley of Strength" },
	[51544158] = { aIDH=965, indexH=8, quest=12361, location="Razor Hill" },
}
points[ 1411 ] = { -- Durotar
	[46940672] = { aIDH=965, indexH=2, quest=12366, location="Valley of Strength" },
	[51604170] = { aIDH=965, indexH=9, quest=12361, location="Razor Hill" },
}
points[ 70 ] = { -- Dustwallow Marsh
	[24843279] = { aIDA=963, indexA=16, quest=29008, location="Fort Triumph" },
	[36783244] = { aIDH=965, indexH=9, quest=12383, location="Brackenwall Village" },
	[41867409] = { aIDA=963, indexA=8, aIDH=965, indexH=10, quest=12398, location="Mudsprocket", tip="Upstairs, inside the main hut" },
	[48220178] = { aIDA=963, indexA=18, quest=29007, location="Northwatch Hold" },
	[66604528] = { faction="Alliance", title="Theramore (Old)", quest=12349, location="Theramore", tip="Inside the inn" },
}
points[ 1445 ] = { -- Dustwallow Marsh
	[36783244] = { aIDH=965, indexH=11, quest=12383, location="Brackenwall Village" },
	[41867409] = { aIDA=963, indexA=4, aIDH=965, indexH=16, quest=12398, location="Mudsprocket", tip="Upstairs, inside the main hut" },
	[66604530] = { aIDA=963, indexA=15, quest=12349, location="Theramore" },
}
points[ 77 ] = { -- Felwood
	[13989589] = { aIDH=965, indexH=4, quest=28989, location="Zoram'gar Outpost" },
	[44582899] = { aIDA=963, indexA=11, aIDH=965, indexH=11, quest=28994, location="Whisperwind Grove",
						tip="There's space inside the inn, as usual, for the candy bucket yet...\n"
							.."it's placed on the landing outside. Unusual! Spooky?" },
	[58035192] = { aIDA=5837, indexA=2, aIDH=5838, indexH=2, quest=29000, location="Grove of Aessina" },
	[61862671] = { aIDA=963, indexA=10, quest=28995, location="Talonbranch Glade",
						tip="Ever wanted to experiment with \"Particle Density\" in\n"
							.."System->Graphics->Advanced? Stand at the entrance and\nlook towards the candy bucket!" },
	[74875780] = { aIDA=5837, indexA=4, aIDH=5838, indexH=4, quest=29001, location="Shrine of Aviana" },
	[89144269] = { aIDA=5837, indexA=3, aIDH=5838, indexH=3, quest=28999, location="Nordrassil" },
}
points[ 69 ] = { -- Feralas
	[41451568] = { aIDH=965, indexH=12, quest=28996, location="Camp Ataya",
						tip="Hey, why not change the icons!\nESC->Interface->AddOns->HandyNotes->Plugins expand->Hallow's End" },
	[46334519] = { aIDA=963, indexA=13, quest=12350, location="Feathemoon Stronghold",
						tip="Hey, why not change the icons!\nESC->Interface->AddOns->HandyNotes->Plugins expand->Hallow's End" },
	[51071781] = { aIDA=963, indexA=12, quest=28952, location="Dreamer's Rest" },
	[51974764] = { aIDH=965, indexH=14, quest=28998, location="Stonemaul Hold" },
	[74834514] = { aIDH=965, indexH=13, quest=12386, location="Camp Mojache" },
	[67769716] = { aIDA=963, indexA=15, aIDH=965, indexH=21, quest=12401, location="Cenarion Hold", tip="In the Oasis inn, below the Flight Masters" },
	[83270000] = { aIDH=965, indexH=7, quest=12362, location="Bloodhoof Village" },
}
points[ 1444 ] = { -- Feralas
	[30904340] = { aIDA=963, indexA=14, quest=12350, location="Feathemoon Stronghold" },
	[74834514] = { aIDH=965, indexH=5, quest=12386, location="Camp Mojache" },
}
points[ 7 ] = { -- Mulgore
	[05738321] = { aIDA=963, indexA=12, quest=28952, location="Dreamer's Rest" },
	[09562427] = { aIDA=963, indexA=6, aIDH=965, indexH=6, quest=28993, location="Karnum's Glade" },
	[46796041] = { aIDH=965, indexH=15, quest=12362, location="Bloodhoof Village" },
	[39703118] = { aIDH=965, indexH=28, quest=12367, location="Lower Rise", tip="Inside \"The Cat and the Shaman\" inn" },
	[68620468] = { aIDA=963, indexA=17, quest=29006, location="Honor's Stand", tip="It's out in the open" },
	[69001706] = { aIDH=965, indexH=23, quest=29004, location="Hunter's Hill" },
	[70928401] = { aIDH=965, indexH=22, quest=29005, location="Desolation Hold" },
	[82268291] = { aIDA=963, indexA=16, quest=29008, location="Fort Triumph", tip="Another candy bucket that's not in a building. Hooray!" },
	[88940659] = { aIDH=965, indexH=16, quest=12374, location="The Crossroads", tip="Main building. It's the inn. De rigueur" },
	[93768257] = { aIDH=965, indexH=9, quest=12383, location="Brackenwall Village" },
}
points[ 1412 ] = { -- Mulgore
	[46796041] = { aIDH=965, indexH=7, quest=12362, location="Bloodhoof Village" },
	[39703118] = { aIDH=965, indexH=17, quest=12367, location="Lower Rise", tip="Inside \"The Cat and the Shaman\" inn" },
}
points[ 10 ] = { -- Northern Barrens
	[02818123] = { aIDH=965, indexH=17, quest=12367, location="Lower Rise", tip="Inside \"The Cat and the Shaman\" inn" },
	[03892430] = { aIDH=965, indexH=24, quest=29009, location="Krom'gar Fortress", tip="Inside the smallest building" },
	[08533959] = { aIDA=963, indexA=20, quest=29010, location="Northwatch Expedition Base" },
	[30245610] = { aIDA=963, indexA=17, quest=29006, location="Honor's Stand", tip="It's out in the open" },
	[30606784] = { aIDH=965, indexH=23, quest=29004, location="Hunter's Hill" },
	[67347466] = { aIDA=963, indexA=14, aIDH=965, indexH=19, quest=12396, location="Ratchet", tip=hatchling },
	[49515791] = { aIDH=965, indexH=16, quest=12374, location="The Crossroads", tip="Main building. It's the inn. De rigueur" },
	[56214003] = { aIDH=965, indexH=17, quest=29002, location="Grol'dom Farm" },
	[62511659] = { aIDH=965, indexH=18, quest=29003, location="Nozzlepot's Outpost" },
	[80870624] = { aIDH=965, indexH=20, quest=12366, location="Valley of Strength" },
	[85103831] = { aIDH=965, indexH=8, quest=12361, location="Razor Hill" },
}
points[ 85 ] = { -- Orgrimmar
	[53937894] = { aIDH=965, indexH=20, quest=12366, location="Valley of Strength" },
	[50843631] = { aIDH=5838, indexH=1, quest=29019, tip="Through this portal for the Deepholm candy bucket.\n"
						.."A Vashj'ir portal is closeby too!", location="Temple of Earth" },
}
points[ 1454 ] = { -- Orgrimmar
	[54506850] = { aIDH=965, indexH=2, quest=12366, location="Valley of Strength" },
}
points[ 81 ] = { -- Silithus
	[53929072] = { aIDA=5837, aIDH=5838, indexA=9, indexH=8, quest=29016, neighbour=true, location="Oasis of Vir'sar" },
	[55473679] = { aIDA=963, indexA=15, aIDH=965, indexH=21, quest=12401, location="Cenarion Hold", tip="In the Oasis inn, below the Flight Masters" },
}
points[ 1451 ] = { -- Silithus
	[51803900] = { aIDA=963, indexA=11, aIDH=965, indexH=4, quest=12401, location="Cenarion Hold" },
}
points[ 199 ] = { -- Southern Barrens
	[15049435] = { aIDH=965, indexH=13, quest=12386, location="Camp Mojache" },
	[17753047] = { aIDH=965, indexH=17, quest=12367, location="Lower Rise", tip="Inside \"The Cat and the Shaman\" inn" },
	[22965196] = { aIDH=965, indexH=7, quest=12362, location="Bloodhoof Village" },
	[39021099] = { aIDA=963, indexA=17, quest=29006, location="Honor's Stand", tip="It's out in the open" },
	[39292009] = { aIDH=965, indexH=23, quest=29004, location="Hunter's Hill" },
	[40706932] = { aIDH=965, indexH=22, quest=29005, location="Desolation Hold" },
	[49046850] = { aIDA=963, indexA=16, quest=29008, location="Fort Triumph", tip="Another candy bucket that's not in a building. Hooray!" },
	[53951239] = { aIDH=965, indexH=16, quest=12374, location="The Crossroads", tip="Main building. It's the inn. De rigueur" },
	[57506826] = { aIDH=965, indexH=9, quest=12383, location="Brackenwall Village" },
	[61109775] = { aIDA=963, indexA=8, aIDH=965, indexH=10, quest=12398, location="Mudsprocket", tip="Upstairs, inside the main hut" },
	[65604654] = { aIDA=963, indexA=18, quest=29007, location="Northwatch Hold", tip="To the south, just across the border into Dustwallow Marsh.\n"
						.."is an adorable and oh so cute raptor hatchling pet, one of\na set of four. Why not \"dart\" over and grab it now!" },
	[67772538] = { aIDA=963, indexA=14, aIDH=965, indexH=19, quest=12396, location="Ratchet", tip=hatchling },
	[78627735] = { faction="Alliance", title="Theramore (Old)", quest=12349, location="Theramore", tip="Inside the inn" },
}
points[ 65 ] = { -- Stonetalon Mountains
	[31536066] = { aIDA=963, indexA=19, quest=29013, location="Farwatcher's Glen", tip="Another open air Elven inn - fly right in!" },
	[39483281] = { aIDA=963, indexA=21, quest=29012, location="Thal'darah Overlook" },
	[44938007] = { aIDA=963, indexA=7, quest=12348, location="Nigel's Point" },
	[50030107] = { aIDH=965, indexH=4, quest=28989, location="Zoram'gar Outpost" },
	[50376379] = { aIDH=965, indexH=25, quest=12378, location="Sun Rock Retreat",
						tip="Alchemy completionists will want the Fire Protection potion\nfrom Jeeda upstaits. Good luck!" },
	[59045632] = { aIDA=963, indexA=22, quest=29011, location="Windshear Hold", tip="Fallowmere Inn" },
	[66506419] = { aIDH=965, indexH=24, quest=29009, location="Krom'gar Fortress", tip="Inside the smallest building" },
	[71027908] = { aIDA=963, indexA=20, quest=29010, location="Northwatch Expedition Base" },
	[73501588] = { aIDA=963, indexA=1, quest=12345, location="Astranaar", tip="Your quest phase does not matter - the bucket is always available" },
	[75100912] = { aIDH=965, indexH=1, quest=28958, location="Hellscream's Watch", tip="Outside, easy to see" },
	[86443348] = { aIDH=965, indexH=2, quest=28953, location="Silverwind Refuge" },
	[92179516] = { aIDA=963, indexA=17, quest=29006, location="Honor's Stand", tip="It's out in the open" },
}
points[ 1442 ] = { -- Stonetalon Mountains
	[47506210] = { aIDH=965, indexH=10, quest=12378, location="Sun Rock Retreat" },
	[35600650] = { aIDH=963, indexH=2, quest=12347, location="Stonetalon Peak" },
}
points[ 71 ] = { -- Tanaris
	[20093594] = { aIDH=965, indexH=29, aIDA=963, indexA=26, quest=29018, location="Marshal's Stand" },
	[52552710] = { aIDA=963, indexA=24, aIDH=965, indexH=27, quest=12399, location="Gadgetzan",
						tip="Did you stock up on Noggenfogger while you are here?\nOh yeah, the candy bucket is inside \"The Road Warrior\" inn" },
	[55706096] = { aIDA=963, indexA=23, aIDH=965, indexH=26, quest=29014, location="Bootlegger Outpost" },
}
points[ 1446 ] = { -- Tanaris
	[52562790] = { aIDA=963, indexA=8, aIDH=965, indexH=14, quest=12399, location="Gadgetzan",
						tip="Did you stock up on Noggenfogger while you are here?" },
}
points[ 57 ] = { -- Teldrassil
	[55365229] = { aIDA=963, indexA=25, quest=12331, location="Dolanaar" },
	[34164401] = { aIDA=963, indexA=5, quest=12334, location="Craftsmen's Terrace" },
}
points[ 1438 ] = { -- Teldrassil
	[55705980] = { aIDA=963, indexA=13, quest=12331, location="Dolanaar" },
	[29105030] = { aIDA=963, indexA=16, quest=12334, location="Craftsmen's Terrace" },
}
points[ 1413 ] = { -- The Barrens
	[67347465] = { aIDA=963, indexA=12, quest=12396, location="Ratchet", tip=hatchling },
	[52002990] = { aIDH=965, indexH=12, quest=12374, location="The Crossroads" },
	[62103940] = { aIDH=965, indexH=8, quest=12396, location="Ratchet", tip=hatchling },
	[45605900] = { aIDH=965, indexH=13, quest=12375, location="Camp Taurajo" },
}
points[ 103 ] = { -- The Exodar
	[59251846] = { aIDA=963, indexA=9, quest=12337, location="Seat of the Naaru", tip="In the Exobar" },
}
points[ 1947 ] = { -- The Exodar
	[59251846] = { aIDA=963, indexA=7, quest=12337, location="Seat of the Naaru", tip="In the Exobar" },
}
points[ 64 ] = { -- Thousand Needles
	[62262249] = { aIDA=963, indexA=8, aIDH=965, indexH=10, quest=12398, location="Mudsprocket", tip="Upstairs, inside the main hut" },
}
points[ 1441 ] = { -- Thousand Needles
	[46105150] = { aIDH=965, indexH=1, quest=12379, location="Freewind Post" },
}
points[ 88 ] = { -- Thunder Bluff
	[45626493] = { aIDH=965, indexH=28, quest=12367, location="Lower Rise", tip="Inside \"The Cat and the Shaman\" inn" },
}
points[ 1456 ] = { -- Thunder Bluff
	[45626493] = { aIDH=965, indexH=17, quest=12367, location="Lower Rise", tip="Inside \"The Cat and the Shaman\" inn" },
}
points[ 78 ] = { -- Un'Goro Crater
	[55266212] = { aIDH=965, indexH=29, aIDA=963, indexA=26, quest=29018, location="Marshal's Stand",
						tip="Did you get your awesome Venomhide Ravasaur mount while you were here?\nJust... make sure you're Horde!" },
}
points[ 83 ] = { -- Winterspring
	[11848913] = { aIDA=5837, indexA=2, aIDH=5838, indexH=2, quest=29000, location="Grove of Aessina" },
	[15626429] = { aIDA=963, indexA=10, quest=28995, location="Talonbranch Glade" },
	[28459493] = { aIDA=5837, indexA=4, aIDH=5838, indexH=4, quest=29001, location="Shrine of Aviana" },
	[42518004] = { aIDA=5837, indexA=3, aIDH=5838, indexH=3, quest=28999, location="Nordrassil" },
	[59835122] = { aIDA=963, indexA=27, aIDH=965, indexH=30, quest=12400, location="Everlook",
						tip="Grab a Winterspring Cub pet from Michelle De Rum who is\n"
							.."standing near the candy bucket. Awwww... so cute!\nDon't forget the Mount Hyjal locations too!" },
}
points[ 1452 ] = { -- Winterspring
	[61303880] = { aIDA=963, indexA=10, aIDH=965, indexH=15, quest=12400, location="Everlook",
						tip="Grab a Winterspring Cub pet from\nMichelle De Rum. Awwww... so cute!" },
}

-- =====================================
-- Eastern Kingdoms
-- =====================================

local raptorHatchling = "Just nearby is an adorable raptor hatchling pet. It's oh so cute.\n"
						.."Steal it from her mother's nest you heartless pet collector!\nOh, did I say that I have an AddOn to help you collect four?"

points[ 14 ] = { -- Arathi Highlands
	[40064909] = { aIDA=966, indexA=1, quest=28954, location="Refuge Point", tip="If you cannot see the candy bucket then you'll\n"
						.."need to visit Zidormi. I marked her on the map." },
	[38259009] = { aIDA=966, indexA=1, quest=28954, location="Refuge Point", tip="Zidormi is at this location. You'll probably\n"
						.."need her for the Refuge Point candy bucket." },
	[69023327] = { aIDH=967, indexH=1, quest=12380, location="Hammerfall", tip="Well if it's not outside then it must be..." },
	[99462082] = { aIDH=967, indexH=5, quest=12387, location="Revantusk Village", tip="Inside the main (only) building" },
}
points[ 1417 ] = { -- Arathi Highlands
	[73903260] = { aIDH=967, indexH=7, quest=12380, location="Hammerfall" },
}
points[ 15 ] = { -- Badlands
	[20875632] = { aIDA=966, indexA=2, quest=28956, location="Dragon's Mouth" },
	[65863565] = { aIDA=966, indexA=3, aIDH=967, indexH=2, quest=28955, location="Fuselight", tip="The apple bobbing tub is outside, the pumpkin is inside" },
	[18364273] = { aIDH=967, indexH=3, quest=28957, location="New Kargath" },
}
points[ 1418 ] = { -- Badlands
	[02904600] = { aIDH=967, indexH=16, quest=12385, location="Kargath" },
}
points[ 17 ] = { -- Blasted Lands
	[60691407] = { aIDA=966, indexA=4, quest=28960, location="Nethergarde Keep", tip="Erm... mobs looking a bit too red, a bit too hostile for your\n"
						.."liking? That'll be Zidormi you'll be needing. She's nearby.\nThe correct building is the one on the left of the main gate.\n"
						.."When you enter, turn right and then left. Voilà!" },
	[44348759] = { aIDA=966, indexA=5, quest=28961, location="Surwich", tip="Hey, fun trivia... see Garrod's house nearby? You\n"
						.."won't get dismounted - you can fly around inside!\nOh yeah... Zidormi is not required for Surwich!" },
	[40471128] = { aIDH=967, indexH=4, quest=28959, location="Dreadmaul Hold", tip="If the guards are hostile... It's a Zidormi problem, sigh. She'd just nearby!" },
}
points[ 36 ] = { -- Burning Steppes
	[23450460] = { aIDA=966, indexA=18, aIDH=967, indexH=16, quest=28965, location="Iron Summit", tip="Outside, high up on a perimiter ledge" },
	[65930100] = { aIDA=966, indexA=2, quest=28956, location="Dragon's Mouth" },
}
points[ 42 ] = { -- Deadwind Pass
	[13043879] = { aIDA=966, indexA=8, quest=12344, location="Darkshire" },
	[73715952] = { aIDH=967, indexH=4, quest=28959, location="Dreadmaul Hold" },
	[78941265] = { aIDA=966, indexA=21, quest=28968, location="The Harborage" },
	[78951265] = { aIDA=966, indexA=21, quest=28968, location="The Harborage" },
	[96943727] = { aIDH=967, indexH=22, quest=12384, location="Stonard" },
}
points[ 27 ] = { -- Dun Morogh
	[54495076] = { aIDA=966, indexA=7, quest=12332, location="Kharanos", tip="Inside the Thunderbrew Distillery at the eating area" },
	[61172746] = { aIDA=966, indexA=13, quest=12335, location="The Commons", tip="Inside the Stonefire Tavern in The Commons" },
	[68229619] = { aIDA=966, indexA=18, aIDH=967, indexH=16, quest=28965, location="Iron Summit", tip="Outside, high up on a perimiter ledge" },
	[93998536] = { aIDH=967, indexH=3, quest=28957, location="New Kargath" },
	[95569388] = { aIDA=966, indexA=2, quest=28956, location="Dragon's Mouth" },
}
points[ 1426 ] = { -- Dun Morogh
	[45855090] = { aIDA=966, indexA=13, quest=12332, location="Kharanos", tip="Inside the Thunderbrew Distillery at the eating area" },
	[51703410] = { aIDA=966, indexA=4, quest=12335, location="The Commons", tip="Inside the Stonefire Tavern in The Commons" },
}
points[ 47 ] = { -- Duskwood
	[73804425] = { aIDA=966, indexA=8, quest=12344, location="Darkshire" },
}
points[ 1431 ] = { -- Duskwood
	[73804425] = { aIDA=966, indexA=9, quest=12344, location="Darkshire" },
}
points[ 23 ] = { -- Eastern Plaguelands
	[75575231] = { aIDA=966, indexA=9, aIDH=967, indexH=7, quest=12402, location="Light's Hope Chapel",
						tip="Use a taxi between Light's Hope Chapel and Tranquillien" },
}
points[ 24 ] = { -- Light's Hope Chapel - Sanctum of Light
	[40709036] = { aIDA=966, indexA=9, aIDH=967, indexH=7, quest=12402 },
}
points[ 1423 ] = { -- Eastern Plaguelands
	[75905230] = { aIDA=966, indexA=3, aIDH=967, indexH=15, quest=12402, location="Light's Hope Chapel" },
}
points[ 37 ] = { -- Elwynn Forest
	[43746589] = { aIDA=966, indexA=10, quest=12286, location="Goldshire" },
	[24894013] = { aIDA=966, indexA=19, quest=12336 },
	[32355088] = { aIDA=1040, indexA=1, daily=true, quest=29054, tip="Pickup the quest here from Gretchen Fenlow and\n"
						.."then your broomstick taxi from Gertrude Fenlow,\nwho is nearby. Soon after completion you could\n"
						.."consider logging out. You will respawn at the Scarlet\nWatchtower in Tirisfal Glades. This will save a lot\n"
						.."of time if you also intend doing \"A Time to Lose\"" },									
	[29694442] = { aIDA=1040, indexA=2, daily=true, quest=29144, tip="Pickup the quest from Gretchen Fenlow who is just outside\n"
						.."the Stormwind gates. To see the orange plumes you must\nhave \"Particle Density\" at least minimally enabled. Go to\n"
						.."System->Graphics->Effects. If you get debuffed then you\nmay cleanse yourself. Shapeshifting also works" },
	[32095059] = { aIDA=1040, indexA=4, daily=true, quest=29371, tip="Pickup the quest here from Keira. See my travel notes for\n"
						.."the quest \"Stink Bombs Away\". Take extra care as you\nwill have no ground/structure cover. My approach is to\n"
						.."fly in from very high and then plummet straight down" },
	[22133396] = { aIDH=1041, indexH=1, daily=true, quest=29374, tip="If you logout while in Stormwind you'll respawn nearby.\n"
						.."Handy for doing \"A Time to Break Down\"" },
	[34104740] = { aIDH=1041, indexH=4, daily=true, quest=29377, tip="The location of the Alliance Wickerman.\n"
						.."Approach from due east. Use the large tree and the ledge\nas cover. Stay away from the wall to avoid zoning out and\n"
						.."adding to phasing problems. Reports suggest activating\nWarmode in Orgrimmar will help in that respect. Do NOT\n"
						.."try to target the Wickerman. Stand near it and click on\nyour Dousing Agent. Immediately mount and hit \"space\"\n"
						.."to fly straight up" },
	[31241227] = { aIDA=5837, indexA=1, quest=29020, location="Temple of Earth", tip="Through this portal for the Deepholm candy bucket.\n"
						.."A Vashj'ir portal is closeby too!" },
}
points[ 1429 ] = { -- Elwynn Forest
	[24894014] = { aIDA=966, indexA=2, quest=12336, location="Stormwind City" },
	[43746589] = { aIDA=966, indexA=12, quest=12286, location="Goldshire" },
}
points[ 94 ] = { -- Eversong Woods
	[43707103] = { aIDH=967, indexH=8, quest=12365, location="Fairbreeze Village", tip="Use a taxi between Fairbreeze Village and Tranquillien." },
	[48204788] = { aIDH=967, indexH=9, quest=12364, location="Falconwing Square", tip="Go through the \"blue\" doorway" },
	[55474495] = { aIDH=967, indexH=17, quest=12370, location="The Bazaar", tip="Wayfarer's Rest inn" },
	[59294137] = { aIDH=967, indexH=18, quest=12369, location="The Royal Exchange", tip="Silvermoon City Inn" },
}
points[ 1941 ] = { -- Eversong Woods
	[43707103] = { aIDH=967, indexH=8, quest=12365, location="Fairbreeze Village" },
	[48204788] = { aIDH=967, indexH=14, quest=12364, location="Falconwing Square", tip="Go through the \"blue\" doorway" },
	[55474495] = { aIDH=967, indexH=13, quest=12370, location="The Bazaar", tip="Wayfarer's Rest inn" },
	[59294137] = { aIDH=967, indexH=2, quest=12369, location="The Royal Exchange", tip="Silvermoon City Inn" },
}
points[ 95 ] = { -- Ghostlands
	[48683190] = { aIDH=967, indexH=10, quest=12373, location="Tranquillien", tip="Use a taxi between Light's Hope Chapel and Tranquillien.\n"
						.."Use a taxi between Fairbreeze Village and Tranquillien." },
}
points[ 1942 ] = { -- Ghostlands
	[48683190] = { aIDH=967, indexH=6, quest=12373, location="Tranquillien" },
}
points[ 25 ] = { -- Hillsbrad Foothills
	[05361180] = { aIDH=967, indexH=19, quest=28966, location="Forsaken Rear Guard" },
	[07223134] = { aIDH=967, indexH=20, quest=12371, location="The Sepulcher", tip="In the largest building" },
	[57854727] = { aIDH=967, indexH=12, quest=12376, location="Tarren Mill", tip="Identical building design as Andorhal. Follow the map marker please." },
	[60266374] = { aIDH=967, indexH=11, quest=28962, location="Eastpoint Tower", tip="Hooray! It's outdoors and a no-brainer to find. Wooooo!" },
	[67841645] = { aIDA=966, indexA=22, quest=28988, location="Chillwind Camp" },
	[81673576] = { aIDA=966, indexA=11, quest=12351, location="Aerie Peak", tip="The lowest level hillside building" },
	[89878518] = { aIDA=966, indexA=1, quest=28954, location="Refuge Point" },
	[95624627] = { aIDH=967, indexH=13, quest=28971, location="Hiri'watha Research Station" },
}
points[ 1424 ] = { -- Hillsbrad Foothills
	[51105890] = { aIDA=966, indexA=11, quest=12346, location="Southshore" },
	[62801900] = { aIDH=967, indexH=3, quest=12376, location="Tarren Mill" },
}
points[ 87 ] = { -- Ironforge
	[18345094] = { aIDA=966, indexA=13, quest=12335, location="The Commons", tip="Inside the Stonefire Tavern in The Commons" },
}
points[ 1455 ] = { -- Ironforge
	[18345094] = { aIDA=966, indexA=4, quest=12335, location="The Commons", tip="Inside the Stonefire Tavern in The Commons" },
}
points[ 48 ] = { -- Loch Modan
	[83026353] = { aIDA=966, indexA=14, quest=28963, location="Farstrider Lodge" },
	[35544850] = { aIDA=966, indexA=15, quest=12339, location="Thelsamar" },
}
points[ 1432 ] = { -- Loch Modan
	[35544850] = { aIDA=966, indexA=8, quest=12339, location="Thelsamar" },
}
points[ 50 ] = { -- Northern Stranglethorn
	[24838108] = { aIDH=967, indexH=6, quest=28969, tip="It's in the building next to the apple bobbing tub", location="Hardwrench Hideaway" },
	[37385178] = { aIDH=967, indexH=15, quest=12382, location="Grom'gol Base Camp", tip="At the base of the zeppelin tower" },
	[53166698] = { aIDA=966, indexA=16, quest=28964, location="Fort Livingston" },
}
points[ 49 ] = { -- Redridge Mountains
	[26464150] = { aIDA=966, indexA=17, quest=12342, location="Lakeshire" },
	[51699126] = { aIDA=966, indexA=21, quest=28968, location="The Harborage" },
	[93407338] = { aIDA=966, indexA=20, aIDH=967, indexH=21, quest=28967, location="Bogpaddle" },
}
points[ 1433 ] = { -- Redridge Mountains
	[27094492] = { aIDA=966, indexA=7, quest=12342, location="Lakeshire" },
}
points[ 32 ] = { -- Searing Gorge
	[39486602] = { aIDA=966, indexA=18, aIDH=967, indexH=16, quest=28965, location="Iron Summit", tip="Outside, high up on a perimiter ledge" },
	[96044224] = { aIDH=967, indexH=3, quest=28957, location="New Kargath" },
	[99496094] = { aIDA=966, indexA=2, quest=28956, location="Dragon's Mouth" },
}
points[ 110 ] = { -- Silvermoon City
	[38008479] = { aIDH=967, indexH=9, quest=12364, location="Falconwing Square", tip="Go through the \"blue\" doorway" },
	[67597289] = { aIDH=967, indexH=17, quest=12370, location="The Bazaar", tip="Wayfarer's Rest inn" },
	[70357702] = { aIDH=967, indexH=17, quest=12370, tip="Enter through here!" },
	[79435765] = { aIDH=967, indexH=18, quest=12369, location="The Royal Exchange", tip="Silvermoon City Inn" },
	[83125829] = { aIDH=967, indexH=18, quest=12369, tip="Enter through here!" },
}
points[ 1954 ] = { -- Silvermoon City
	[38008479] = { aIDH=967, indexH=14, quest=12364, location="Falconwing Square", tip="Go through the \"blue\" doorway" },
	[67597289] = { aIDH=967, indexH=13, quest=12370, location="The Bazaar", tip="Wayfarer's Rest inn" },
	[70357702] = { aIDH=967, indexH=13, quest=12370, tip="Enter through here!" },
	[79435765] = { aIDH=967, indexH=2, quest=12369, location="The Royal Exchange", tip="Silvermoon City Inn" },
	[83125829] = { aIDH=967, indexH=2, quest=12369, tip="Enter through here!" },
}
points[ 21 ] = { -- Silverpine Forest
	[44302028] = { aIDH=967, indexH=19, quest=28966, location="Forsaken Rear Guard" },
	[46454291] = { aIDH=967, indexH=20, quest=12371, location="The Sepulcher", tip="In the largest building" },
	[76830101] = { aIDH=967, indexH=11, quest=12368, location="The Trade Quarter" },
	[99270001] = { aIDH=967, indexH=24, quest=28972, location="The Bulwark" },	
}
points[ 1421 ] = { -- Silverpine Forest
	[43204140] = { aIDH=967, indexH=4, quest=12371, location="The Sepulcher" },
}
points[ 224 ] = { -- Stranglethorn Vale
	[52094310] = { aIDA=966, indexA=16, quest=28964, location="Fort Livingston" },
	[37907993] = { aIDA=966, indexA=6, aIDH=967, indexH=5, quest=12397, tip="It's in the Salty Sailor Tavern", location="Booty Bay" },
	[42213359] = { aIDH=967, indexH=15, quest=12382, tip="At the base of the zeppelin tower", location="Grom'gol Base Camp" },
	[34365192] = { aIDH=967, indexH=6, quest=28969, tip="It's in the building next to the apple bobbing tub", location="Hardwrench Hideaway" },
	[88444023] = { aIDA=966, indexA=5, quest=28961, location="Surwich" },
}
points[ 1434 ] = { -- Stranglethorn Vale
	[27107730] = { aIDA=966, indexA=1, aIDH=967, indexH=10, quest=12397, location="Booty Bay", tip="It's in the Salty Sailor Tavern" },
	[31502970] = { aIDH=967, indexH=9, quest=12382, location="Grom'gol Base Camp" },
}
points[ 84 ] = { -- Stormwind City
	[60517534] = { aIDA=966, indexA=19, quest=12336, location="Stormwind City" },
	[75419681] = { aIDA=1040, indexA=1, daily=true, quest=29054, tip="Pickup the quest here from Gretchen Fenlow and\n"
						.."then your broomstick taxi from Gertrude Fenlow,\nwho is nearby. Soon after completion you could\n"
						.."consider logging out. You will respawn at the Scarlet\nWatchtower in Tirisfal Glades. This will save a ton\n"
						.."of time if you also intend doing \"A Time to Lose\"" },									
	[70108390] = { aIDA=1040, indexA=2, daily=true, quest=29144, tip="Pickup the quest from Gretchen Fenlow who is just outside\n"
						.."the Stormwind gates. To see the orange plumes you must\nhave \"Particle Density\" at least minimally enabled. Go to\n"
						.."System->Graphics->Effects. If you get debuffed then you\nmay cleanse yourself. Shapeshifting also works" },
	[74889624] = { aIDA=1040, indexA=4, daily=true, quest=29371, tip="Pickup the quest here from Keira. See my travel notes for\n"
						.."the quest \"Stink Bombs Away\". Take extra care as you\nwill have no ground/structure cover. My approach is to\n"
						.."fly in from very high and then plummet straight down" },
	[55006300] = { aIDH=1041, indexH=1, daily=true, quest=29374, tip="If you logout while in Stormwind you'll respawn at the\n"
						.."Eastvale Logging Camp in Elwynn Forest. Handy for\ndoing \"A Time to Break Down\"" },
	[78918986] = { aIDH=1041, indexH=4, daily=true, quest=29377, tip="The location of the Alliance Wickerman.\n"
						.."Approach from due east. Use the large tree and the ledge\nas cover. Stay away from the wall to avoid zoning out and\n"
						.."adding to phasing problems. Reports suggest activating\nWarmode in Orgrimmar will help in that respect. Do NOT\n"
						.."try to target the Wickerman. Stand near it and click on\nyour Dousing Agent. Immediately mount and hit \"space\"\n"
						.."to fly straight up" },
	[73191967] = { aIDA=5837, indexA=1, quest=29020, location="Temple of Earth",
						tip="Through this portal for the Deepholm candy bucket.\nA Vashj'ir portal is closeby too!" },
}
points[ 1453 ] = { -- Stormwind City
	[60517534] = { aIDA=966, indexA=2, quest=12336, location="Stormwind City" },
}
points[ 51 ] = { -- Swamp of Sorrows
	[23717910] = { aIDH=967, indexH=4, quest=28959, location="Dreadmaul Hold" },
	[71651410] = { aIDA=966, indexA=20, aIDH=967, indexH=21, quest=28967, location="Bogpaddle" },
	[28933240] = { aIDA=966, indexA=21, quest=28968, location="The Harborage",
						tip="Hey, why not change the icons!\nESC->Interface->AddOns->HandyNotes->Plugins expand->Hallow's End" },
	[46875693] = { aIDH=967, indexH=22, quest=12384, location="Stonard",
						tip="Hey, why not change the icons!\nESC->Interface->AddOns->HandyNotes->Plugins expand->Hallow's End" },
	[53238317] = { aIDA=966, indexA=4, quest=28960, location="Nethergarde Keep" },
}
points[ 1435 ] = { -- Swamp of Sorrows
	[46885692] = { aIDH=967, indexH=1, quest=12384, location="Stonard" },
}
points[ 210 ] = { -- The Cape of Stranglethorn
	[40917372] = { aIDA=966, indexA=6, aIDH=967, indexH=5, quest=12397, tip="It's in the Salty Sailor Tavern" },
	[35042722] = { aIDH=967, indexH=6, quest=28969, location="Hardwrench Hideaway", tip="It's in the building next to the apple bobbing tub" },
	[64481257] = { aIDA=966, indexA=16, quest=28964, location="Fort Livingston" },
}
points[ 26 ] = { -- The Hinterlands
	[14194460] = { aIDA=966, indexA=11, quest=12351, location="Aerie Peak", tip="The lowest level hillside building" },
	[66164443] = { aIDA=966, indexA=12, quest=28970, location="Stormfeather Outpost" },
	[31805787] = { aIDH=967, indexH=13, quest=28971, location="Hiri'watha Research Station" },
	[78198147] = { aIDH=967, indexH=14, quest=12387, location="Revantusk Village", tip="Inside the main (only) building" },
}
points[ 1425 ] = { -- The Hinterlands
	[14194460] = { aIDA=966, indexA=6, quest=12351, location="Aerie Peak", tip="The lowest level hillside building" },
	[50709272] = { aIDH=967, indexH=1, quest=12380, location="Hammerfall", tip="Well if it's not outside then it must be..." },
	[78198147] = { aIDH=967, indexH=5, quest=12387, location="Revantusk Village", tip="Inside the main (only) building" },
}
points[ 18 ] = { -- Tirisfal Glades
	[31959091] = { aIDH=967, indexH=19, quest=28966, location="Forsaken Rear Guard" },
	[62197300] = { aIDH=967, indexH=25, quest=12368, location="The Trade Quarter", tip="In Undercity, which is below the Ruins of Lordaeron" },
	[60995141] = { aIDH=967, indexH=23, quest=12363, location="Brill", tip="Brill might work as your Hearth for this event for an alt. Quick\n"
						.."return from Elwynn after your dailies in Stormwind, plus the\nzeppelin post gets me to Kalimdor and Northrend for my Tricks\n"
						.."and Treats circuit. Later I switch to Orgrimmar for Pandaria etc\nT&T accessibility. Using Brill avoids the annoying portal from\n"
						.."Orgrimmar into Undercity" },
	[83047207] = { aIDH=967, indexH=24, quest=28972, location="The Bulwark" },	
	[62136702] = { aIDH=1041, indexH=1, daily=true, quest=29374, tip="Pickup the quest from Candace Fenlow, nearby, and\n"
						.."get your instant taxi from Crina Fenlow. Soon after\ncompletion you could consider logging out. You will\n"
						.."respawn at the Eastvale Logging Camp graveyard in\nElwynn Forest. This will save a ton of time if you also\n"
						.."intend doing \"A Time to Break Down\"" },
	[62436671] = { aIDH=1041, indexH=2, daily=true, quest=29375, tip="Pickup the quest from Candace Fenlow. To see the orange\n"
						.."plumes you must have \"Particle Density\" at least\nminimally enabled. Go to System->Graphics->Effects. If\n"
						.."you get debuffed then you may cleanse yourself.\nShapeshifting also works" },
	[66606200] = { aIDH=1041, indexH=2, daily=true, quest=29375, tip="If things are not \"peaceful\" then do NOT attempt to\n"
						.."enter Lordaeron. Speak to Zidormi who is nearby" },
	[62126783] = { aIDH=1041, indexH=4, daily=true, quest=29377, tip="Pickup the quest here from Darkcaller Yanks. See my travel\n"
						.."notes for the quest \"Stink Bombs Away\". Approach from\nthe east, hugging the terrain. A large tree will cover your\n"
						.."final approach" },
	[61508110] = { aIDA=1040, indexA=1, daily=true, quest=29054, tip="If you logout while in Undercity you'll respawn nearby.\n"
						.."Handy for doing \"A Time to Lose\"" },
	[62406820] = { aIDA=1040, indexA=4, daily=true, quest=29371, tip="The location of the Horde Wickerman.\n"
						.."Approach from as high up as possible. Plummet down.\nLand between the Wickerman and the wall, preferably\n"
						.."with a pillar providing a little cover. The pillar where\nthe green bubbling liquid begins is perfect. Do NOT\n"
						.."try to target the Wickerman. Stand near it and click\non your Dousing Agent. Immediately mount and hit\n"
						.."\"space\" to fly straight up" },
	[99189591] = { aIDA=966, indexA=22, quest=28988, neighbour=true, location="Chillwind Camp" },
}
points[ 1420 ] = { -- Tirisfal Glades
	[62197300] = { aIDH=967, indexH=11, quest=12368, location="The Trade Quarter", tip="In Undercity, which is below the Ruins of Lordaeron" },
	[61805220] = { aIDH=967, indexH=12, quest=12363, location="Brill" },
}
points[ 90 ] = { -- Undercity
	[67753742] = { aIDH=967, indexH=25, quest=12368, location="The Trade Quarter", tip="In Undercity, which is below the Ruins of Lordaeron" },
	[76503301] = { aIDH=1041, indexH=2, daily=true, quest=29375, tip="To see the orange plumes you must have \"Particle Density\"\n"
						.."at least minimally enabled via System->Graphics->Effects" },
	[75703300] = { aIDA=1040, indexA=1, daily=true, quest=29054, tip="If you logout while in Undercity you'll respawn nearby.\n"
						.."Handy for doing \"A Time to Lose\"" },
	[76105320] = { aIDA=1040, indexA=4, daily=true, quest=29371, tip="Logout while in Undercity doing \"Stink Bombs "
						.."Away\"\nfor faster travelling back to Lordaeron" },
}
points[ 1458 ] = { -- Undercity
	[67763741] = { aIDH=967, indexH=11, quest=12368, location="The Trade Quarter" },
}
points[ 22 ] = { -- Western Plaguelands
	[03243760] = { aIDH=967, indexH=23, quest=12363, location="Brill" },
	[04506029] = { aIDH=967, indexH=11, quest=12368, location="The Trade Quarter" },
	[26425931] = { aIDH=967, indexH=24, quest=28972, location="The Bulwark" },	
	[43388437] = { aIDA=966, indexA=22, quest=28988, location="Chillwind Camp" },
	[48286365] = { aIDH=967, indexH=26, quest=28987, location="Andorhal", tip="Impossible to describe. Trust in the coordinates / map marker please!" },
}
points[ 52 ] = { -- Westfall
	[52915374] = { aIDA=966, indexA=25, quest=12340, location="Sentinel Hill",
						tip="In the Inn or atop the tower, depending upon your quest phase.\nThis map marker is for the inn" },
}
points[ 1436 ] = { -- Westfall
	[52915360] = { aIDA=966, indexA=5, quest=12340, location="Sentinel Hill" },
}
points[ 56 ] = { -- Wetlands
	[10836099] = { aIDA=966, indexA=23, quest=12343, location="Menethil Harbor", tip="Don't go into the big fort/castle. Go around the back to the inn" },
	[11349760] = { aIDA=966, indexA=13, quest=12335, location="The Commons", tip="Inside the Stonefire Tavern in The Commons" },
	[26072598] = { aIDA=966, indexA=24, quest=28990, location="Swiftgear Station" },
	[58213920] = { aIDA=966, indexA=26, quest=28991, location="Greenwarden's Grove", tip=raptorHatchling },
}
points[ 1437 ] = { -- Wetlands
	[10836099] = { aIDA=966, indexA=10, quest=12343, location="Menethil Harbor", tip=raptorHatchling },
}

-- ============================
-- Outland
-- ============================

points[ 105 ] = { -- Blade's Edge Mountains
	[27239263] = { aIDA=969, indexA=14, quest=12355, location="Orebor Harborage", tip="Inside the building with the mailbox" },
	[35836373] = { aIDA=969, indexA=2, quest=12358, location="Sylvanaar", tip="At the rear of the inn, behind the main building" },
	[53435555] = { aIDH=968, indexH=3, quest=12393, location="Thunderlord Stronghold", tip="Inside the main building" },
	[61056808] = { aIDA=969, indexA=3, quest=12359, location="Toshley's Station", tip="At the rear of the inn. he building has a mailbox" },
	[62903833] = { aIDA=969, indexA=1, aIDH=968, indexH=1, quest=12406, location="Evergrove", tip="Inside the inn, mailbox at the front" },
	[76226039] = { aIDH=968, indexH=2, quest=12394, location="Mok'Nathal Village", tip="Inside the main building" },
	[94893725] = { aIDA=969, indexA=7, aIDH=968, indexH=7, quest=12407, location="Area 52", tip="A little inside the main building" },
}
points[ 1949 ] = { -- Blade's Edge Mountains
	[27239263] = { aIDA=969, indexA=1, quest=12355, location="Orebor Harborage", tip="Inside the building with the mailbox" },
	[35836373] = { aIDA=969, indexA=15, quest=12358, location="Sylvanaar", tip="At the rear of the inn, behind the main building" },
	[53435555] = { aIDH=968, indexH=11, quest=12393, location="Thunderlord Stronghold", tip="Inside the main building" },
	[61056808] = { aIDA=969, indexA=14, quest=12359, location="Toshley's Station", tip="At the rear of the inn. he building has a mailbox" },
	[62903833] = { aIDA=969, indexA=8, aIDH=968, indexH=14, quest=12406, location="Evergrove", tip="Inside the inn, mailbox at the front" },
	[76226039] = { aIDH=968, indexH=3, quest=12394, location="Mok'Nathal Village", tip="Inside the main building" },
	[94893725] = { aIDA=969, indexA=7, aIDH=968, indexH=13, quest=12407, location="Area 52", tip="A little inside the main building" },
}
points[ 100 ] = { -- Hellfire Peninsula
	[00164803] = { aIDA=969, indexA=13, aIDH=968, indexH=14, quest=12403, location="Cenarion Refuge", tip="Inside the main building" },
	[23423637] = { aIDA=969, indexA=5, quest=12353, location="Temple of Telhamat", tip="In the main building at the end of the promenade" },
	[26895947] = { aIDH=968, indexH=4, quest=12389, location="Falcon Watch", tip="In the lower, domed building" },
	[54256368] = { aIDA=969, indexA=4, quest=12352, location="Honor Hold", tip="In the inn, mailbox at the front" },
	[56813745] = { aIDH=968, indexH=5, quest=12388, location="Thrallmar", tip="In the smaller of the two main buildings" },
}
points[ 1944 ] = { -- Hellfire Peninsula
	[00164803] = { aIDA=969, indexA=2, aIDH=968, indexH=2, quest=12403, location="Cenarion Refuge", tip="Inside the main building" },
	[23423637] = { aIDA=969, indexA=12, quest=12353, location="Temple of Telhamat", tip="In the main building at the end of the promenade" },
	[26895947] = { aIDH=968, indexH=6, quest=12389, location="Falcon Watch", tip="In the lower, domed building" },
	[54256368] = { aIDA=969, indexA=13, quest=12352, location="Honor Hold", tip="In the inn, mailbox at the front" },
	[56813745] = { aIDH=968, indexH=9, quest=12388, location="Thrallmar", tip="In the smaller of the two main buildings" },
}
points[ 107 ] = { -- Nagrand
	[54197588] = { aIDA=969, indexA=6, quest=12357, location="Telaar", tip="Below the Flight Master.\nIf mobs are orange it's still okay" },
	[56683448] = { aIDH=968, indexH=6, quest=12392, location="Garadar", tip="At the centre of the huge round building.\nIf mobs are orange it's still okay." },
	[81985275] = { aIDA=969, indexA=11, aIDH=968, indexH=11, quest=12404, location="Aldor Rise",
						tip="You must be Aldor but... if absolutely neutral then your choice" },
	[86240582] = { aIDA=969, indexA=13, aIDH=968, indexH=14, quest=12403, location="Cenarion Refuge", tip="Inside the main building" },
	[88626052] = { aIDA=969, indexA=11, aIDH=968, indexH=11, quest=12404, location="Scryer's Tier",
						tip="You must be Scryer but... if absolutely neutral then your choice" },
}
points[ 1951 ] = { -- Nagrand
	[54197588] = { aIDA=969, indexA=3, quest=12357, location="Telaar", tip="Below the Flight Master.\nIf mobs are orange it's still okay" },
	[56683448] = { aIDH=968, indexH=1, quest=12392, location="Garadar", tip="At the centre of the huge round building.\nIf mobs are orange it's still okay." },
	[81985275] = { aIDA=969, indexA=11, aIDH=968, indexH=11, quest=12404, location="Aldor Rise",
						tip="You must be Aldor but... if absolutely neutral then your choice" },
	[86240582] = { aIDA=969, indexA=2, aIDH=968, indexH=2, quest=12403, location="Cenarion Refuge", tip="Inside the main building" },
	[88626052] = { aIDA=969, indexA=11, aIDH=968, indexH=11, quest=12404, location="Scryer's Tier",
						tip="You must be Scryer but... if absolutely neutral then your choice" },
}
points[ 109 ] = { -- Netherstorm
	[00906549] = { aIDA=969, indexA=1, aIDH=968, indexH=1, quest=12406, location="Evergrove", tip="Inside the inn, mailbox at the front" },
	[13858696] = { aIDH=968, indexH=2, quest=12394, location="Mok'Nathal Village", tip="Inside the main building" },
	[32026444] = { aIDA=969, indexA=7, aIDH=968, indexH=7, quest=12407, location="Area 52", tip="A little inside the main building" },
	[43313609] = { aIDA=969, indexA=8, aIDH=968, indexH=8, quest=12408, location="The Stormspire", tip="Fly high up. Inside the lowest building" },
}
points[ 1953 ] = { -- Netherstorm
	[00906549] = { aIDA=969, indexA=8, aIDH=968, indexH=14, quest=12406, location="Evergrove", tip="Inside the inn, mailbox at the front" },
	[13858696] = { aIDH=968, indexH=3, quest=12394, location="Mok'Nathal Village", tip="Inside the main building" },
	[32026444] = { aIDA=969, indexA=7, aIDH=968, indexH=13, quest=12407, location="Area 52", tip="A little inside the main building" },
	[43313609] = { aIDA=969, indexA=6, aIDH=968, indexH=5, quest=12408, location="The Stormspire", tip="Fly high up. Inside the lowest building" },
}
points[ 104 ] = { -- Shadowmoon Valley
	[30272770] = { aIDH=968, indexH=10, quest=12395, location="Shadowmoon Village", tip="In the main building" },
	[37015829] = { aIDA=969, indexA=10, quest=12360, location="Wildhammer Stronghold",
						tip="In the dining area of the Kharanos-style inn with\nbrewing iconography. Don't enter the big building" },
	[56375982] = { aIDA=969, indexA=9, aIDH=968, indexH=9, quest=12409, location="Sanctum of the Stars",
						tip="You must be Scryer but... if absolutely neutral then your choice." },
	[61002817] = { aIDA=969, indexA=9, aIDH=968, indexH=9, quest=12409, location="Altar of Sha'tar",
						tip="You must be Aldor but... if absolutely neutral then your choice." },
}
points[ 1948 ] = { -- Shadowmoon Valley
	[30272770] = { aIDH=968, indexH=8, quest=12395, location="Shadowmoon Village", tip="In the main building" },
	[37015829] = { aIDA=969, indexA=5, quest=12360, location="Wildhammer Stronghold",
						tip="In the dining area of the Kharanos-style inn with\nbrewing iconography. Don't enter the big building" },
	[56375982] = { aIDA=969, indexA=4, aIDH=968, indexH=4, quest=12409, location="Sanctum of the Stars",
						tip="You must be Scryer but... if absolutely neutral then your choice." },
	[61002817] = { aIDA=969, indexA=4, aIDH=968, indexH=4, quest=12409, location="Altar of Sha'tar",
						tip="You must be Aldor but... if absolutely neutral then your choice." },
}
points[ 111 ] = { -- Shattrath City
	[28234908] = { aIDA=969, indexA=11, aIDH=968, indexH=11, quest=12404, location="Aldor Rise",
						tip="You must be Aldor but... if absolutely neutral then your choice" },
	[56308195] = { aIDA=969, indexA=11, aIDH=968, indexH=11, quest=12404, location="Scryer's Tier",
						tip="You must be Scryer but... if absolutely neutral then your choice" },
}
points[ 1955 ] = { -- Shattrath City
	[28234908] = { aIDA=969, indexA=11, aIDH=968, indexH=11, quest=12404, location="Aldor Rise",
						tip="You must be Aldor but... if absolutely neutral then your choice" },
	[56308195] = { aIDA=969, indexA=11, aIDH=968, indexH=7, quest=12404, location="Scryer's Tier",
						tip="You must be Scryer but... if absolutely neutral then your choice" },
}
points[ 108 ] = { -- Terokkar Forest
	[24392504] = { aIDA=969, indexA=11, aIDH=968, indexH=11, quest=12404, location="Aldor Rise",
						tip="You must be Aldor but... if absolutely neutral then your choice" },
	[31183299] = { aIDA=969, indexA=11, aIDH=968, indexH=11, quest=12404, location="Scryer's Tier",
						tip="You must be Scryer but... if absolutely neutral then your choice" },
	[48734517] = { aIDH=968, indexH=12, quest=12391, location="Stonebreaker Hold", tip="Inside the huge round building" },
	[56595322] = { aIDA=969, indexA=12, quest=12356, location="Allerian Stronghold", tip="Inside the only round, domed (elven) building" },
	[83775454] = { aIDH=968, indexH=10, quest=12395, location="Shadowmoon Village", tip="In the main building" },
	[90638570] = { aIDA=969, indexA=10, quest=12360, location="Wildhammer Stronghold",
						tip="In the dining area of the Kharanos-style inn with\nbrewing iconography. Don't enter the big building" },
}
points[ 1952 ] = { -- Terokkar Forest
	[24392504] = { aIDA=969, indexA=11, aIDH=968, indexH=11, quest=12404, location="Aldor Rise",
						tip="You must be Aldor but... if absolutely neutral then your choice" },
	[31183299] = { aIDA=969, indexA=11, aIDH=968, indexH=11, quest=12404, location="Scryer's Tier",
						tip="You must be Scryer but... if absolutely neutral then your choice" },
	[48734517] = { aIDH=968, indexH=12, quest=12391, location="Stonebreaker Hold", tip="Inside the huge round building" },
	[56595322] = { aIDA=969, indexA=10, quest=12356, location="Allerian Stronghold", tip="Inside the only round, domed (elven) building" },
	[83775454] = { aIDH=968, indexH=8, quest=12395, location="Shadowmoon Village", tip="In the main building" },
	[90638570] = { aIDA=969, indexA=5, quest=12360, location="Wildhammer Stronghold",
						tip="In the dining area of the Kharanos-style inn with\nbrewing iconography. Don't enter the big building" },
}
points[ 102 ] = { -- Zangarmarsh
	[30625087] = { aIDH=968, indexH=13, quest=12390, location="Zabra'jin", tip="The ground level of the inn with no name :(" },
	[41902617] = { aIDA=969, indexA=14, quest=12355, location="Orebor Harborage", tip="Inside the building with the mailbox" },
	[45979438] = { aIDH=968, indexH=6, quest=12392, location="Garadar", tip="At the centre of the huge round building.\nIf mobs are orange it's still okay." },
	[67164894] = { aIDA=969, indexA=15, quest=12354, location="Telredor", tip="Right next to the innkeeper" },
	[78456289] = { aIDA=969, indexA=13, aIDH=968, indexH=14, quest=12403, location="Cenarion Refuge", tip="Inside the main building" },
}
points[ 1946 ] = { -- Zangarmarsh
	[30625087] = { aIDH=968, indexH=10, quest=12390, location="Zabra'jin", tip="The ground level of the inn with no name :(" },
	[41902617] = { aIDA=969, indexA=1, quest=12355, location="Orebor Harborage", tip="Inside the building with the mailbox" },
	[45979438] = { aIDH=968, indexH=1, quest=12392, location="Garadar", tip="At the centre of the huge round building.\nIf mobs are orange it's still okay." },
	[67164894] = { aIDA=969, indexA=9, quest=12354, location="Telredor", tip="Right next to the innkeeper" },
	[78456289] = { aIDA=969, indexA=2, aIDH=968, indexH=2, quest=12403, location="Cenarion Refuge", tip="Inside the main building" },
}
points[ 101 ] = { -- Outland
	[73003880] = { title="Candy Bucket Macro", tip="#showtooltip Handful of Treats\n/use Handful of Treats" },
}
points[ 1945 ] = { -- Outland
	[73003880] = { title="Candy Bucket Macro", tip="#showtooltip Handful of Treats\n/use Handful of Treats" },
}

-- ==============================
-- Northrend
-- ==============================

points[ 114 ] = { -- Borean Tundra
	[41715440] = { aIDH=5835, indexH=4, quest=13468, iabc=true, tip="The lowest level. Use the south-south-east entrance\n"
						.."at ground level and enter the pidgeon hole in the stairs.\n"
						.."Do NOT ascend those stairs!", location="Warsong Hold" },
	[49750998] = { aIDH=5835, indexH=1, quest=13501, iabc=true, location="Bor'gorok Outpost" },
	[57071907] = { aIDA=5836, indexA=1, quest=13437, iabc=true, tip="Inside the main building. Icon marks the entrance", location="Fizzcrank Airstrip" },
	[58526787] = { aIDA=5836, indexA=3, quest=13436, iabc=true, tip="Quite a ways inside the inn, which is adjacent to the Flight Master", location="Valiance Keep" },
	[76663747] = { aIDH=5835, indexH=2, quest=13467, iabc=true, location="Taunka'le Village" },
	[78454916] = { aIDA=5836, indexA=2, aIDH=5835, indexH=3, quest=13460, iabc=true, tip="Inside the inn / main building which is above the shore",
					location="Unu'pe" },
}
points[ 127 ] = { -- Crystalsong Forest
	[24903750] = { aIDA=5836, indexA=5, quest=13473, iabc=true, tip="Don't go into the Silver Enclave.\nIt's in the adjacent \"A Hero's Welcome\" inn.\n"
					.."Under the stairs on the right side", location="A Hero's Welcome" },
	[27304170] = { aIDA=5836, indexA=6, aIDH=5835, indexH=7, quest=13472, iabc=true, tip="Cantrips & Crows", location="The Underbelly" },
	[29003240] = { aIDA=5836, indexA=4, aIDH=5835, indexH=5, quest=13463, iabc=true, tip="Hey, did you download my \X and Y\" AddOn for cool minimap coordinates!\n"
									.."(Shameless self promotion)", location="The Legerdemain Lounge" },
	[30703770] = { aIDH=5835, indexH=6, quest=13474, iabc=true, tip="The Filthy Animal", location="Sunreaver's Sanctuary" },
}
points[ 125 ] = { -- Dalaran
	[38225962] = { aIDA=5836, indexA=6, aIDH=5835, indexH=7, quest=13472, iabc=true, tip="Cantrips & Crows", location="The Underbelly" },
	[42366313] = { aIDA=5836, indexA=5, quest=13473, iabc=true, tip="Don't go into the Silver Enclave.\nIt's in the adjacent \"A Hero's Welcome\" inn.\n"
					.."Under the stairs on the right side", location="A Hero's Welcome" },
	[48144132] = { aIDA=5836, indexA=4, aIDH=5835, indexH=5, quest=13463, iabc=true, tip="Hey, did you download my \X and Y\" AddOn for cool minimap coordinates!\n"
					.."(Shameless self promotion)", location="The Legerdemain Lounge" },
	[66703000] = { aIDH=5835, indexH=6, quest=13474, iabc=true, tip="The Filthy Animal", location="Sunreaver's Sanctuary" },
}
points[ 126 ] = { -- The Underbelly
	[40205950] = { aIDA=5836, indexA=6, aIDH=5835, indexH=7, quest=13472, iabc=true, tip="Cantrips & Crows", location="The Underbelly" },
}
points[ 115 ] = { -- Dragonblight
	[48117465] = { aIDA=5836, indexA=7, aIDH=5835, indexH=9, quest=13459, iabc=true, location="Moa'ki Harbor" },
	[28955622] = { aIDA=5836, indexA=8, quest=13438, iabc=true, location="Stars' Rest" },
	[77285099] = { aIDA=5836, indexA=9, quest=13439, iabc=true, tip="Icon marks the entrance to the inn. It's the closest building to the Flight Master",
					location="Wintergarde Keep" },
	[60155345] = { aIDA=5836, indexA=10, aIDH=5835, indexH=11, quest=13456, iabc=true, tip="The ground floor. Use the nearest entrance to the Gryphon Master",
					location="Wyrmrest Temple" },
	[37834647] = { aIDH=5835, indexH=8, quest=13469, iabc=true, location="Agmar's Hammer" },
	[76826328] = { aIDH=5835, indexH=10, quest=13470, iabc=true, location="Venomspite" },
}
points[ 116 ] = { -- Grizzly Hills
	[31946021] = { aIDA=5836, indexA=11, quest=12944, iabc=true, location="Amberpine Lodge" },
	[59642636] = { aIDA=5836, indexA=12, quest=12945, iabc=true, location="Westfall Brigade" },
	[65364700] = { aIDH=5835, indexH=12, quest=12947, iabc=true, location="Camp Oneqwah" },
	[20896477] = { aIDH=5835, indexH=13, quest=12946, iabc=true, location="Conquest Hold" },
}
points[ 117 ] = { -- Howling Fjord
	[25315914] = { aIDA=5836, indexA=14, aIDH=5835, indexH=15, quest=13452, iabc=true, tip="Icon marks the entrance to the subterranean Inn", location="Kamagua" },
	[30834205] = { aIDA=5836, indexA=16, quest=13434, iabc=true, tip="The usual :). Icon marks the inn entrance", location="Westguard Keep" },
	[49401080] = { aIDH=5835, indexH=14, quest=13464, iabc=true, location="Camp Winterhoof" },
	[52106620] = { aIDH=5835, indexH=16, quest=13465, iabc=true, location="New Agamand" },
	[58676316] = { aIDA=5836, indexA=15, quest=13433, iabc=true, tip="The Inn entrance is at the side....\nThe Penny Pouch is awesome!\nNot :/", location="Valgarde" },
	[60481591] = { aIDA=5836, indexA=13, quest=13435, iabc=true, location="Fort Wildervar" },
	[79273063] = { aIDH=5835, indexH=17, quest=13466, iabc=true, tip="The Inn entrance is at the side....\nThe Penny Pouch is awesome!\nNot :/",
					location="Vengeance Landing" },
}
points[ 119 ] = { -- Sholazar Basin
	[26615920] = { aIDA=5836, indexA=17, aIDH=5835, indexH=18, quest=12950, iabc=true, tip="At the rear of the larger tent", location="Nesingwary Base Camp" },
}
points[ 120 ] = { -- The Storm Peaks
	[28727428] = { aIDA=5836, indexA=19, quest=13448, iabc=true, location="Frosthold" },
	[30583694] = { aIDA=5836, indexA=18, aIDH=5835, indexH=19, quest=13462, iabc=true, tip="Quest phasing issues reported. Icon marks the entrance",
					location="Bouldercrag's Refuge" },
	[37094951] = { aIDH=5835, indexH=21, quest=13548, iabc=true, location="Grom'arsh Crash Site" },
	[40938595] = { aIDA=5836, indexA=20, aIDH=5835, indexH=22, quest=13461, iabc=true, tip="Icon marks the entrance to the Inn. Surprise!", location="K3" },
	[67655069] = { aIDH=5835, indexH=20, quest=13471, iabc=true, location="Camp Tunka'lo" },
}
points[ 121 ] = { -- Zul'Drak
	[40866604] = { aIDA=5836, indexA=21, aIDH=5835, indexH=23, quest=12941, iabc=true, location="The Argent Stand" },
	[59335721] = { aIDA=5836, indexA=22, aIDH=5835, indexH=24, quest=12940, iabc=true, location="Zim'Torga" },
}

-- ==================================
-- Cataclysm
-- ==================================

points[ 207 ] = { -- Deepholm
	[47365171] = { aIDA=5837, indexA=1, quest=29020, location="Temple of Earth" },
	[51194990] = { aIDH=5838, indexH=1, quest=29019, location="Temple of Earth" },
}
local experiment = "The lake area behind the Nordrassil inn is the perfect place to\n"
					.."experiment with your advanced graphics settings. Particle Density,\n"
					.."Ground Clutter, and Liquid Detail in particular are worth trying.\n"
					.."So divinely serene and gorgeous!"
					
points[ 198 ] = { -- Mount Hyjal
	[18633732] = { aIDA=5837, indexA=2, aIDH=5838, indexH=2, quest=29000, location="Grove of Aessina",
						tip="Just this once max out \"Ground Clutter\" in your settings. You're welcome!" },
	[24100134] = { aIDA=963, indexA=10, quest=28995, location="Talonbranch Glade" },
	[63052415] = { aIDA=5837, indexA=3, aIDH=5838, indexH=3, quest=28999, location="Nordrassil" },
	[42684572] = { aIDA=5837, indexA=4, aIDH=5838, indexH=4, quest=29001, location="Shrine of Aviana" },
}
points[ 241 ] = { -- Twilight Highlands
	[06823051] = { aIDA=966, indexA=26, quest=28991, location="Greenwarden's Grove", tip=raptorHatchling },
	[10189172] = { aIDA=966, indexA=15, quest=12339, location="Thelsamar" },
	[35039958] = { aIDA=966, indexA=14, quest=28963, location="Farstrider Lodge" },
	[43505727] = { aIDA=5837, indexA=8, quest=28979, location="Victor's Point" },
	[45117681] = { aIDH=5838, indexH=6, quest=28974, location="Crushblow", tip="Inside the only building" },
	[49603036] = { aIDA=5837, indexA=7, quest=28978, location="Thundermar", tip="The building with the mailbox" },
	[53404284] = { aIDH=5838, indexH=5, quest=28973, location="Bloodgulch", tip="Ground floor, main building" },
	[60365825] = { aIDA=5837, indexA=5, quest=28977, location="Firebeard's Patrol",
						tip="The village is under attack but the dwarves\nsaved their blessed tavern. Priorities!" },
	[75411653] = { aIDH=5838, indexH=7, quest=28976, location="The Krazzworks", tip="Difficult to describe - trust in the coordinates please!\n"
									.."Or... just look for the apple bobbing tub at the doorway!" },
	[75365492] = { faction="Horde", title="Dragonmaw Port", quest=28975, tip="To see the liberated version of Dragonmaw Port\n"
						.."you must have completed the zone storyline up\nto \"Returning to the Highlands\". The flight point\nbecomes available then too" },
	[78877780] = { aIDA=5837, indexA=6, quest=28980, location="Highbank",
						tip="Regardless of quest phase, you'll be okay for the candy bucket.\nFrom the entrance straight to the courtyard. Right then left" },
}
points[ 249 ] = { -- Uldum
	[26580724] = { aIDA=5837, aIDH=5838, indexA=9, indexH=8, quest=29016, location="Oasis of Vir'sar",
						tip="Why not grab the cool Springfur Alpaca mount while you're here!\nYou guessed it, sigh. I've an AddOn for that too! :)" },
	[54683301] = { aIDA=5837, aIDH=5838, indexA=10, indexH=9, quest=29017, location="Ramkahen" },
}
points[ 1527 ] = { -- Wrong Uldum
	[26600725] = { aIDA=5837, aIDH=5838, indexA=9, indexH=8, quest=29016, tip="\124cFFFF0000Wrong version of Uldum. Speak to Zidormi." },
	[54683301] = { aIDA=5837, aIDH=5838, indexA=10, indexH=9, quest=29017, tip="\124cFFFF0000Wrong version of Uldum. Speak to Zidormi." },
}
points[ 204 ] = { -- Abyssal Depths in Vashj'ir
	[61897915] = { aIDA=5837, indexA=11, quest=28985, tip="Inside Darkbreak Cove. Dive straight down. The icon marks the entrance.\n"
						.."The cave may appear empty, Give the art assets time to appear" },
	[94867350] = { aIDH=5838, indexH=11, quest=28984, tip="Inside Legion's Rest. Dive straight down. The icon marks the entrance" },
	[60005670] = { aIDH=5838, indexH=13, quest=28986, tip="Inside Tenebrous Cove. Dive straight down. The icon marks the entrance" },
}
points[ 201 ] = { -- Kelp'thar Forest in Vashj'ir
	[60686609] = { aIDA=5837, indexA=12, aIDH=5838, indexH=10, quest=28981, tip="Inside Deepmist Grotto. Dive straight down. The icon marks the entrance" },
}
points[ 205 ] = { -- Shimmering Expanse in Vashj'ir
	[20007114] = { aIDA=5837, indexA=11, quest=28985, tip="Inside Darkbreak Cove. Dive straight down. The icon marks the entrance.\n"
									.."The cave may appear empty, Give the art assets time to appear" },
	[68261539] = { aIDA=5837, indexA=12, aIDH=5838, indexH=10, quest=28981, tip="Inside Deepmist Grotto. Dive straight down. The icon marks the entrance" },
	[51564154] = { aIDA=5837, indexA=13, aIDH=5838, indexH=12, quest=28982, tip="Inside Silver Tide Hollow. Dive straight down. The icon marks the entrance" },
	[45025707] = { aIDA=5837, indexA=14, quest=28983, tip="Inside the Tranquil Wash. Dive straight down. The icon marks the entrance" },
	[47706640] = { aIDH=5838, indexH=11, quest=28984, tip="Inside Legion's Rest. Dive straight down. The icon marks the entrance" },
	[18415228] = { aIDH=5838, indexH=13, quest=28986, tip="Inside Tenebrous Cove. Dive straight down. The icon marks the entrance" },
}
-- The Maelstrom map is not treated as a continent in the game (or is it Handy Notes?) so I need to include it here
points[ 948 ] = { -- The Maelstrom
	[50002900] = { aIDA=5837, indexA=1, quest=29020, location="Temple of Earth", tip="Access via the Cataclysm portal cluster in Stormwind" },
	[50002901] = { aIDH=5838, indexH=1, quest=29019, location="Temple of Earth", tip="Access via the Cataclysm portal cluster in Orgrimmar" },
}

-- =================================
-- Pandaria
-- =================================

local kunlaiTip = "Phasing issue here. Go to Binan Village. Complete \"Hit Medicine\",\n"
				.."\"Call Out Their Leader\", \"All of the Arrows\". Then complete\n"
				.."\"Admiral Taylor...\". Then \"Westwind Rest\" by heading over\n"
				.."towards Westwind. Finally complete \"Challenge Accepted\" from\n"
				.."Elder Tsulan. Voilà - unlocked!"
									
points[ 422 ] = { -- Dread Wastes
	[55217120] = { aIDA=7601, indexA=2, aIDH=7602, indexH=2, quest=32023, location="Soggy's Gamble", tip="Inside The Chum Bucket Inn" },
	[55933227] = { aIDA=7601, indexA=1, aIDH=7602, indexH=1, quest=32024, location="Klaxxi'vess" },
	[79234989] = { aIDA=7601, indexA=22, aIDH=7602, indexH=24, quest=32046, location="Stoneplow", tip="Yeah.. another inn... The Stone Mug Tavern" },
	[84388721] = { aIDH=7602, indexH=10, quest=32020, location="Dawnchaser Retreat" },
	[84982190] = { aIDA=7601, indexA=19, aIDH=7602, indexH=21, quest=32044, location="Mistfall Village", tip="In The Golden Rose inn" },
}
points[ 418 ] = { -- Krasarang Wilds
	[22370811] = { aIDA=7601, indexA=22, aIDH=7602, indexH=24, quest=32046, location="Stoneplow", tip="Yeah.. another inn... The Stone Mug Tavern" },
	[28255074] = { aIDH=7602, indexH=10, quest=32020, location="Dawnchaser Retreat" },
	[51407729] = { aIDA=7601, indexA=10, aIDH=7602, indexH=11, quest=32034, location="Marista", tip="The \"Bait and Brew\". Pretty much the only building" },
	[61152504] = { aIDH=7602, indexH=12, quest=32047, location="Thunder Cleft" },
	[75920687] = { aIDA=7601, indexA=11, aIDH=7602, indexH=13, quest=32036, location="Zhu's Watch", tip="In the Wilds' Edge Inn" },
	[98660525] = { aIDA=7601, indexA=6, quest=32049, location="Paw'don Village", tip="First visit to Pandaria? Always grab those flight points!" },
}

points[ 379 ] = { -- Kun-Lai Summit
	[29507843] = { aIDA=7601, indexA=18, aIDH=7602, indexH=20, quest=32043, location="Longying Outpost" },
	[54078282] = { aIDA=7601, indexA=15, quest=32042, tip=kunlaiTip, location="Westwind Rest" },
	[57455995] = { aIDA=7601, indexA=14, aIDH=7602, indexH=17, quest=32037, location="One Keg", tip="Inside The Lucky Traveller" },
	[62502890] = { aIDA=7601, indexA=16, aIDH=7602, indexH=18, quest=32051, location="Zouchin Village",
							tip="Inside the North Wind Tavern. Right near the Flight Master" },
	[62778050] = { aIDH=7602, indexH=15, quest=32040, location="Eastwind Rest",
							tip="Phasing issue here. Go to Binan Village. Complete \"Hit Medicine\",\n"
									.."\"Call Out Their Leader\", \"All of the Arrows\". Then complete\n"
									.."\"General Nazgrim...\". Then \n\"Eastwind Rest\" by heading over\n"
									.."towards Eastwind. Finally complete \"Challenge Accepted\" from\nElder Shiao. Voilà - unlocked!" },
	[62779454] = { aIDH=7602, indexH=22, quest=32022, location="Shrine of Two Moons" },
	[64216127] = { aIDA=7601, indexA=13, aIDH=7602, indexH=16, quest=32041, location="The Grummle Bazaar", tip="Inside The Two Fisted Brew" },
	[72739228] = { aIDA=7601, indexA=12, aIDH=7602, indexH=14, quest=32039, location="Binan Village", tip="Inside the Binan Brew and Chunder Inn" },
}
points[ 393 ] = { -- Shrine of the Seven Stars
	[37876584] = { aIDA=7601, indexA=20, quest=32052, tip="In the Golden Lantern inn.\nThe inn is on the "
									.."right side of the Shrine's entrance" },
}
points[ 392 ] = { -- The Imperial Mercantile
	[58907831] = { aIDH=7602, indexH=22, quest=32022, location="Shrine of Two Moons",
							tip="From the main entrance go up the stairs on the right side.\n"
									.."Go through each room until you arrive at the balcony /\nmezzanine of The Keggary." },
}
points[ 371 ] = { -- The Jade Forest
	[02981149] = { aIDA=7601, indexA=14, aIDH=7602, indexH=17, quest=32037, location="One Keg", tip="Inside The Lucky Traveller" },
	[07752992] = { aIDH=7602, indexH=15, quest=32040, location="Eastwind Rest" },
	[07754251] = { aIDH=7602, indexH=22, quest=32022, location="Shrine of Two Moons" },
	[09041268] = { aIDA=7601, indexA=13, aIDH=7602, indexH=16, quest=32041, location="The Grummle Bazaar", tip="Inside The Two Fisted Brew" },
	[16674048] = { aIDA=7601, indexA=12, aIDH=7602, indexH=14, quest=32039, location="Binan Village", tip="Inside the Binan Brew and Chunder Inn" },
	[16836159] = { aIDA=7601, indexA=20, quest=32052, tip="In the Golden Lantern inn.\nThe inn is on the "
									.."right side of the Shrine's entrance" },
	[23326073] = { aIDA=7601, indexA=17, aIDH=7602, indexH=19, quest=32026, tip="Tavern in the Mists" },
	[28024739] = { aIDH=7602, indexH=5, quest=32028, location="Grookin Hill",
						tip="The candy bucket is present even if you have\nnot yet made the Grookin friendly.\n\n"
							.."But check the placement in the hut.\nDesperate to squeeze it in much?" },
	[28451327] = { aIDH=7602, indexH=6, quest=32050, location="Honeydew Village" },
	[29446625] = { aIDA=7601, indexA=21, aIDH=7602, indexH=23, quest=32048, location="Pang's Stead", tip="Hey, you know that you can change the icons?\n"
									.."ESC->Interface->AddOns->HandyNotes->Plugins expand->Hallow's End" },
	[29548546] = { aIDA=7601, indexA=11, aIDH=7602, indexH=13, quest=32036, location="Zhu's Watch", tip="In the Wilds' Edge Inn" },
	[41682314] = { aIDA=7601, indexA=9, aIDH=7602, indexH=9, quest=32021, location="Tian Monastery", tip="Inside Paur's Pub" },
	[44818437] = { aIDA=7601, indexA=6, quest=32049, location="Paw'don Village", tip="First visit to Pandaria? Always grab those flight points!" },
	[45774360] = { aIDA=7601, indexA=3, aIDH=7602, indexH=3, quest=32027, location="Dawn's Blossom", tip="Inside The Drunken Hozen Inn" },
	[48093462] = { aIDA=7601, indexA=4, aIDH=7602, indexH=4, quest=32029, location="Greenstone Village" },
	[54606333] = { aIDA=7601, indexA=5, aIDH=7602, indexH=7, quest=32032, location="Jade Temple Grounds", tip="Inside The Dancing Serpent Inn" },
	[55712441] = { aIDA=7601, indexA=8, aIDH=7602, indexH=8, quest=32031, location="Sri-La Village", tip="Yeah... it's inside the Inn!" },
	[59568324] = { aIDA=7601, indexA=7, quest=32033, location="Pearlfin Village" },
}
points[ 433 ] = { -- The Veiled Stair
	[29887560] = { aIDA=7601, indexA=20, quest=32052, tip="In the Golden Lantern inn.\nThe inn is on the "
									.."right side of the Shrine's entrance" },
	[55117224] = { aIDA=7601, indexA=17, aIDH=7602, indexH=19, quest=32026, tip="Taraezor has lots of handy \"HandyNotes\" AddOns!" },
	[73412031] = { aIDH=7602, indexH=5, quest=32028, location="Grookin Hill" },
	[78969372] = { aIDA=7601, indexA=21, aIDH=7602, indexH=23, quest=32048, location="Pang's Stead",
							tip="Hey, you know that you can change the icons?\n"
									.."ESC->Interface->AddOns->HandyNotes->Plugins expand->Hallow's End" },
}
points[ 388 ] = { -- Townlong Steppes, Longying Outpost
	[71145777] = { aIDA=7601, indexA=18, aIDH=7602, indexH=20, quest=32043, location="Longying Outpost" },
	[97916256] = { aIDA=7601, indexA=15, quest=32042, tip=kunlaiTip, location="Westwind Rest" },
}
points[ 390 ] = { -- Vale of Eternal Blossoms
	[35147778] = { aIDA=7601, indexA=19, aIDH=7602, indexH=21, quest=32044, location="Mistfall Village", tip="In The Golden Rose inn" },
	[61991626] = { aIDH=7602, indexH=22, quest=32022, location="Shrine of Two Moons",
						tip="From the main entrance go up the stairs on the right side.\n"
									.."Go through each room until you arrive at the balcony /\nmezzanine of The Keggary." },
	[87036888] = { aIDA=7601, indexA=20, quest=32052, tip="In the Golden Lantern inn.\nThe inn is on the "
									.."right side of the Shrine's entrance" },
	[86581066] = { aIDA=7601, indexA=12, aIDH=7602, indexH=14, quest=32039, location="Binan Village", tip="Inside the Binan Brew and Chunder Inn" },
}
points[ 376 ] = { -- Valley of the Four Winds
	[19875578] = { aIDA=7601, indexA=22, aIDH=7602, indexH=24, quest=32046, location="Stoneplow", tip="Yeah.. another inn... The Stone Mug Tavern" },
	[27721760] = { aIDA=7601, indexA=19, aIDH=7602, indexH=21, quest=32044, location="Mistfall Village", tip="In The Golden Rose inn" },
	[61211186] = { aIDA=7601, indexA=20, quest=32052, tip="In the Golden Lantern inn.\nThe inn is on the "
									.."right side of the Shrine's entrance" },
	[72751032] = { aIDA=7601, indexA=17, aIDH=7602, indexH=19, quest=32026, tip="Tavern in the Mists" },
	[83642014] = { aIDA=7601, indexA=21, aIDH=7602, indexH=23, quest=32048, location="Pang's Stead",
								tip="Hey, you know that you can change the icons?\n"
									.."ESC->Interface->AddOns->HandyNotes->Plugins expand->Hallow's End" },
	[83835431] = { aIDA=7601, indexA=11, aIDH=7602, indexH=13, quest=32036, location="Zhu's Watch", tip="In the Wilds' Edge Inn" },
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
	[40276963] = { achievement=10365, title="Spooky Pepe", item=128874, tip="Sitting on the largest gravestone" },	
	[43515151] = { faction="Alliance", title="Draenor / Lunarfall Garrison", quest=39657, tip=draenorS },
	[44405180] = { faction="Alliance", title="Draenor / Lunarfall Garrison", daily=true, quest=39719, tip=draenorD },
	[48904540] = { achievement=10365, title="Pepe", item=128874, tip="Pepe seen on a branch here. It's the WRONG pepe" },
	[29003440] = { faction="Alliance", title="Get Spooky - Garrison Mission", tip="Rarely and randomly occurs. Rewards 15 candy!" },
}
points[ 539 ] = { -- Shadowmoon Valley in Draenor
	[29741983] = { achievement=10365, title="Spooky Pepe", item=128874, tip="Sitting on the largest gravestone" },	
	[30011780] = { faction="Alliance", title="Draenor / Lunarfall Garrison", quest=39657, tip=draenorS },
	[30251805] = { faction="Alliance", title="Draenor / Lunarfall Garrison", daily=true, quest=39719, tip=draenorD },
	[28701600] = { faction="Alliance", title="Get Spooky - Garrison Mission", tip="Rarely and randomly occurs. Rewards 15 candy!" },
}
points[ 590 ] = { -- Frostwall Garrison in Draenor
	[41654497] = { achievement=10365, title="Pepe", item=128874, tip="Pepe seen on a branch here. It's the WRONG pepe" },
	[46993759] = { faction="Horde", title="Draenor / Frostwall Garrison", quest=39657, tip=draenorS },
	[47903790] = { faction="Horde", title="Draenor / Frostwall Garrison", daily=true, quest=39719, tip=draenorD },
	[41005300] = { faction="Horde", title="Get Spooky - Garrison Mission", tip="Rarely and randomly occurs. Rewards 15 candy!" },
	[70768989] = { achievement=10365, title="Spooky Pepe", item=128874, tip="Sitting on the largest gravestone" },	
}
points[ 525 ] = { -- Frostfire Ridge in Draenor
	[48256435] = { faction="Horde", title="Draenor / Frostwall Garrison", quest=39657, tip=draenorS },
	[48506460] = { faction="Horde", title="Draenor / Frostwall Garrison", daily=true, quest=39719, tip=draenorD },
	[46006800] = { faction="Horde", title="Get Spooky - Garrison Mission", tip="Rarely and randomly occurs. Rewards 15 candy!" },
	[50897046] = { achievement=10365, title="Spooky Pepe", item=128874, tip="Sitting on the largest gravestone" },	
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
	[46224060] = { achievement=18360, index=1, quest=75684 }, -- Bloodhoof Outpost
	[66252453] = { achievement=18360, index=2, quest=75693 }, -- Emberwatch
	[72138039] = { achievement=18360, index=3, quest=75692 }, -- Forkriver Crossing
	[62934056] = { achievement=18360, index=4, quest=75685 }, -- Maruukaï
	[57147672] = { achievement=18360, index=5, quest=75687 }, -- Ohn'iri Springs
	[81295920] = { achievement=18360, index=6, quest=75688 }, -- Pinewood Post
	[85843536] = { achievement=18360, index=7, quest=75689 }, -- Rusza'thar Reach
	[28646056] = { achievement=18360, index=8, quest=75686 }, -- Shady Sanctuary
	[41916044] = { achievement=18360, index=9, quest=75691 }, -- Teerakaï
	[85042603] = { achievement=18360, index=10, quest=75690 }, -- Timberstep Outpost
}
points[ 2025 ] = { -- Thaldraszus
	[44891063] = { achievement=18360, index=34, quest=75683 }, -- Wingrest Embassy
	[48910791] = { aIDA=18360, indexA=33, quest=75681 }, -- Wild Coast
	[50084273] = { achievement=18360, index=11, quest=75698 }, -- Algeth'era Court
	[35087920] = { achievement=18360, index=12, quest=75696 }, -- Garden Shrine
	[52416981] = { achievement=18360, index=13, quest=75697 }, -- Gelikyr Post
	[59858269] = { achievement=18360, index=14, quest=75695 }, -- Temporal Conflux
	[43175940] = { achievement=18360, index=15, quest=75700 }, -- Valdrakken - The Parting Glass
	[39525922] = { achievement=18360, index=16, quest=75699 }, -- Valdrakken - The Roasted Ram
	[35955711] = { achievement=18360, index=17, quest=75701 }, -- Valdrakken - Weyrnrest
}
points[ 2024 ] = { -- The Azure Span
	[47034026] = { achievement=18360, index=18, quest=75667 }, -- Camp Antonidas
	[62785773] = { achievement=18360, index=19, quest=75668 }, -- Camp Nowhere
	[12384933] = { achievement=18360, index=20, quest=75669 }, -- Iskaara
	[65501625] = { achievement=18360, index=21, quest=75670 }, -- Theron's Watch
	[18812455] = { achievement=18360, index=22, quest=75671 }, -- Three-Falls Lookout
}
points[ 2151 ] = { -- The Forbidden Reach
	[33845881] = { achievement=18360, index=23, quest=75702 }, -- Morqut Village
}
points[ 2022 ] = { -- The Waking Shores
	[24468210] = { achievement=18360, index=24, quest=75672 }, -- Apex Observatory
	[47678330] = { achievement=18360, index=25, quest=75673 }, -- Dragonscale Basecamp
	[65225793] = { achievement=18360, index=26, quest=75675 }, -- Life Vault Ruins
	[43106666] = { achievement=18360, index=27, quest=77698 }, -- Obsidian Bulwark
	[25775518] = { achievement=18360, index=28, quest=75676 }, -- Obsidian Throne
	[58036731] = { achievement=18360, index=29, quest=75674 }, -- Ruby Lifeshrine
	[76075475] = { achievement=18360, index=30, quest=75677 }, -- Skytop Observatory
	[53913903] = { achievement=18360, index=31, quest=75678 }, -- Uktulut Backwater
	[46432740] = { achievement=18360, index=32, quest=75679 }, -- Uktulut Pier
	[80422788] = { aIDH=18360, indexH=33, quest=75682 }, -- Wild Coast
	[81313196] = { aIDA=18360, indexA=33, quest=75681 }, -- Wild Coast
	[76213541] = { achievement=18360, index=34, quest=75683 }, -- Wingrest Embassy
}
points[ 2112 ] = { -- Valdrakken
	[72374667] = { achievement=18360, index=15, quest=75700 }, -- The Parting Glass
	[47134542] = { achievement=18360, index=16, quest=75699 }, -- The Roasted Ram
	[22363084] = { achievement=18360, index=17, quest=75701 }, -- Weyrnrest
}
points[ 2133 ] = { -- Zaralek Cavern
	[56375636] = { achievement=18360, index=35, quest=75704 }, -- Loamm
	[52122647] = { achievement=18360, index=36, quest=75703 }, -- Obsidian Rest
}

-- =====================================
-- Continents & Sub-Continents
-- =====================================

points[ 12 ] = { -- Kalimdor
	-- Azuremyst Isle
	[32402650] = { aIDA=963, indexA=2, quest=12333, location="Azure Watch" },
	-- Teldrassil
	[43711023] = { aIDA=963, indexA=25, quest=12331, location="Dolanaar" },
	[40320891] = { aIDA=963, indexA=5, quest=12334, location="Craftsmen's Terrace" },
}
points[ 947 ] = { -- Azeroth
	[70707500] = { title="Candy Bucket Macro", tip="#showtooltip Handful of Treats\n/use Handful of Treats" },
	[45194849] = { aIDA=5837, indexA=1, quest=29020, iabc=true, ibc=true, tip="Access via the Cataclysm portal cluster in Stormwind.", location="Temple of Earth" },
	[45194851] = { aIDH=5838, indexH=1, quest=29019, iabc=true, ibc=true, tip="Access via the Cataclysm portal cluster in Orgrimmar.", location="Temple of Earth" },
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

