local _, ns = ...
ns.points = {}
ns.textures = {}
ns.scaling = {}

-- Achievements:						ID			Faction		Pin				Default Texture in Core
-- Home Alone							1791		Both		achieves		|
-- Daily Chores							1789		Both		achieves		| Pink Cupcake
-- Aw, Isn't It Cute?					1792		Both		achieves		|
-- Veteran Nanny						275			Both		achieves		|
-- Bad Example							1788		Both		badEx			Icecream Cone			
-- Hail To The King, Baby				1790		Both		utgarde			| White Cupcake
-- School of Hard Knocks				1786		Both		utgarde			|
-- For the Children						1793		Both		meta			Light Green Teddy Bear
-- Non-CW achievements											related			Dark Blue Teddy Bear
-- Pet Parade							-			-			pets			Brown Teddy Bear
-- Flavour								-			-			flavour			Toy Train
-- Quests:
-- Orphan chains						-			-			orphan			Light Blue Teddy Bear
-- Vendors								-			-			vendor			icecream Cone

ns.wellLovedGuide = "At the conclusion of each orphan's quest chain in SW/Org, Shatt, Dal, BfA and Dorn, you may choose to "
			.."receive a Well-loved Figurine. The figurine may then be swapped for a pet of your choice in SW/Org.\n\n"
			.."All of the pets from all of the zones are available for selection, except Legs and Scooter (presumably a 2025 bug)"

ns.completeTasks = "Use your whistle to summon your Orphan. Complete several tasks and report back for your reward"
ns.frenzyheart = "Part of the Frenzyheart/Wolvar quest chain"
ns.icecreamStand = "Buy from the Children's Week ice cream stand"
ns.oracles = "Part of the Oracles quest chain"
ns.utgardePinnacle = "Location of the dungeon is the Howling Fjord, Northrend. Any difficulty level"

ns.etc = "There's a portal in Shattrath to take you to the Isle of Quel'Danas. From there it's an easy flight to Silvermoon City"
ns.shortcutETC = "This quest is part of the second tier of Salandria's tasks. " ..ns.etc
ns.ETCshortcutSet = { id=11975, name="Now, When I Grow Up...", faction="Horde", qType="Seasonal", guide=ns.shortcutETC }

ns.setBoralus = { version=80105, faction="Alliance", level=10, { id=53811, name="Children's Week", qType="Seasonal", }, -- Liam
			{ id=53859, name="The Mountain Folk", qType="Seasonal", }, { id=53861, name="Yo Ho, Yo Ho!", qType="Seasonal", },
			{ id=53862, name="The Squid Shrine", qType="Seasonal", }, { id=53863, name="Bird Friends", qType="Seasonal", },
			{ id=53864, name="Shapeshifters!", qType="Seasonal", }, { id=53865, name="Return to the Orphanage", qType="Seasonal", },
			guide="Go to Matron Westerson at the orphanage in Boralus. " ..ns.completeTasks, }
ns.setDalaran = { version=30200, level=10, -- Roo & Kekek
			{ id=13926, name="Little Orphan Roo Of The Oracles", qType="Seasonal", },
			{ id=13929, name="The Biggest Tree Ever!", qType="Seasonal", },
			{ id=13933, name="The Bronze Dragonshrine", qType="Seasonal", }, { id=13950, name="Playmates!", qType="Seasonal", },
			{ id=13956, name="Meeting a Great One", qType="Seasonal", }, { id=13954, name="The Dragon Queen", qType="Seasonal", },
			{ id=13937, name="A Trip To The Wonderworks", qType="Seasonal", },
			{ id=13959, name="Back To The Orphanage", qType="Seasonal",
				tip="Above is the \"Curious Oracle Hatchling\" quest chain", },
			{ id=13927, name="Little Orphan Kekek Of The Wolvar", qType="Seasonal", },
			{ id=13930, name="Home Of The Bear-Men", qType="Seasonal", },
			{ id=13934, name="The Bronze Dragonshrine", qType="Seasonal", }, { id=13951, name="Playmates!", qType="Seasonal", },
			{ id=13957, name="The Mighty Hemet Nesingwary", qType="Seasonal", },
			{ id=13955, name="The Dragon Queen", qType="Seasonal", },
			{ id=13938, name="A Trip To The Wonderworks", qType="Seasonal", },
			{ id=13960, name="Back To The Orphanage", qType="Seasonal", tip="Above is the \"Curious Wolvar Pup\" quest chain", },
			guide="Go to Matron Aria at the Eventide Fountain in Dalaran. " ..ns.completeTasks .."\n\nNote that it doesn't matter "
			.."about your reputation with the Frenzheart or Oracles. Both quest chains do take you to Sholazar but the locations "
			.."are far enough away from Frenzyheart Hill and Rainspeaker Canopy.", }
ns.setDazaralor = { version=80105, faction="Horde", level=10, { id=53965, name="Children's Week", qType="Seasonal", }, -- Azala
			{ id=53966, name="Loa of Winds", qType="Seasonal", }, { id=53968, name="The Shifting Pack", qType="Seasonal", },
			{ id=53967, name="The Frogmarsh", qType="Seasonal", }, { id=53970, name="The Sethrak Queen", qType="Seasonal", },
			{ id=53969, name="Hunting for Gold", qType="Seasonal", },
			{ id=53971, name="Return to the Hall of Castes", qType="Seasonal", },
			guide="Go to Caretaker Padae at the Grand Bazaar in Dazar'alor. " ..ns.completeTasks, }
ns.setOrgrimmar = { faction="Horde", level=10, { id=172, name="Children's Week", qType="Seasonal", }, -- Grunth
			{ id=910, name="Down at the Docks", versionUnder=40100, qType="Seasonal", },
			{ id=911, name="Gateway to the Frontier", versionUnder=40100, qType="Seasonal", },
			{ id=1800, name="Lordaeron Throne Room", versionUnder=40100, qType="Seasonal", },
			{ id=29146, name="Ridin' the Rocketway", version=40100, qType="Seasonal", },
			{ id=29167, name="The Banshee Queen", versionUnder=80105, version=40400, qType="Seasonal", }, 
			{ id=54146, name="Strong New allies", version=80105, qType="Seasonal", },
			{ id=29176, name="The Fallen Chieftain", version=40100, qType="Seasonal", },
			{ id=925, name="Cairne's Hoofprint", versionUnder=40100, qType="Seasonal", },
			{ id=29190, name="Let's Go Fly a Kite", version=40100, qType="Seasonal", },
			{ id=29191, name="You Scream, I Scream...", qType="Seasonal", },
			{ id=5502, name="A Warden of the Horde", qType="Seasonal", },
			guide="Go to Matron Battlewail at the orphanage in the Drag in Orgrimmar. " ..ns.completeTasks, }
ns.setShattrath = { version=20501, level=10, { id=10943, name="Children's Week", faction="Alliance", qType="Seasonal", },
			{ id=10942, name="Children's Week", faction="Horde", qType="Seasonal", }, -- Dornaa & Salandria
			{ id=10950, name="Auchindoun and the Ring of Observance", faction="Alliance", qType="Seasonal", },
			{ id=10945, name="Hch'uu and the Mushroom People", faction="Horde", qType="Seasonal", }, 
			{ id=10954, name="Jheel is at Aeris Landing!", faction="Alliance", qType="Seasonal", },
			{ id=10953, name="Visit the Throne of the Elements", faction="Horde", qType="Seasonal", },
			{ id=10952, name="A Trip to the Dark Portal", faction="Alliance", qType="Seasonal", },
			{ id=10951, name="A Trip to the Dark Portal", faction="Horde", qType="Seasonal", },
			{ id=10956, name="The Seat of the Naaru", faction="Alliance", qType="Seasonal", },
			{ id=10968, name="Call on the Farseer", faction="Alliance", qType="Seasonal", },
			{ id=11975, name="Now, When I Grow Up...", faction="Horde", qType="Seasonal", },
			{ id=10962, name="Time to Visit the Caverns", faction="Alliance", qType="Seasonal", },
			{ id=10963, name="Time to Visit the Caverns", faction="Horde", qType="Seasonal", },
			{ id=10966, name="Back to the Orphanage", faction="Alliance", qType="Seasonal", },
			{ id=10967, name="Back to the Orphanage", faction="Horde", qType="Seasonal", },
			guide="Go to Matron Mercy at the orphanage in the Lower City in Shattrath. " ..ns.completeTasks, }
ns.setStormwind = { faction="Alliance", level=10, { id=1468, name="Children's Week", qType="Seasonal", }, -- Randis
			{ id=1687, name="Spooky Lighthouse", versionUnder=40100, qType="Seasonal", },
			{ id=1479, name="The Bough of the Eternals", versionUnder=40000, qType="Seasonal", },
			{ id=1558, name="The Stonewrought Dam", versionUnder=40000, qType="Seasonal", },
			{ id=558, name="Jaina's Autograph", versionUnder=40100, qType="Seasonal", },
			{ id=29093, name="Crusin' the Chasm", version=50200, qType="Seasonal", },
			{ id=29106, name="The Biggest Diamond Ever!", version=40100, qType="Seasonal", },
			{ id=29107, name="Malfurion Has Returned!", versionUnder=80105, version=40100, qType="Seasonal", },
			{ id=54130, name="Our New Friends", version=80105, qType="Seasonal", },
			{ id=29117, name="Let's Go Fly a Kite", version=40100, qType="Seasonal", },
			{ id=29119, name="You Scream, I Scream...", qType="Seasonal", },
			{ id=171, name="A Warden of the Alliance", qType="Seasonal", },
			guide="Go to Matron Nightingale at the orphanage in the Cathedral Square in Stormwind. " ..ns.completeTasks, }
			
ns.setAchieves = { achieves=true, alwaysShow=true, noCoords= true, noContinent=true,
			-- Home Alone; Daily Chores; Aw, Isn't It Cute?; School of Hard Knocks
			achievements={ { id=1791, tip="Must be your actual Hearthstone or Garrison Hearthstone", },
			{ id=1789, tip="Ensure your orphan is present during the hand in", },
			{ id=1792, tip="Completing a short quest chain in one of the quest hubs will award a pet. See the pins for details. "
			.."One character may complete up to four locations for four pets: SW/Org, Shatt, Dal, Boralus/Dazar'alor", },			
			{ id=275, showAllCriteria=true, tip="These are Shattrath orphan pets. Do NOT buy on the AH", }, }, }
ns.setMeta = { meta=true, alwaysShow=true, noCoords= true, noContinent=true, achievements={ { id=1793, showAllCriteria=true, }, }, }
ns.setBadEx = { badEx=true, alwaysShow=true, noCoords= true, noContinent=true, -- Bad Example
			achievements={ { id=1788, showAllCriteria=true, 
			guide="Ensure your orphan is out to gain credit when eating these cakes!\n\n"
			.."The Red Velvet Cupcake, Dalaran Doughnut, Dalaran Brownie and Lovely Cake (for the slice) are sold by the high Elf "
			.."Aimee. Her kiosk is located at the foot of the Bank of Dalaran stairs, Northrend and also at the Darkmoon Faire. "
			.."Her stand at Broken Isles Dalaran does not stock the Lovely Cake.\n\nThe Tasty Cupcake requires the BoP Uncommon "
			.."Nothrend recipe of the same name, a zone drop. Buy the cake on the AH.\n\nThe Delicious Chocolate Cake recipe is "
			.."from an Outland/Northrend random daily cooking reward. BoP. Buy the cake on the AH.\n\nTigule (and Foror's) "
			.."Strawberry Ice Cream is purchased from the OG vendor, Brivelthwerp, near the Thousand Needles quest hub. Also "
			.."from any Zeppelin Snack-O-Matic IV as well as Lisa McKeever, Candy Vendor, out the front of the Stormwind "
			.."Stockades since the Cataclysm. Hallow's End vendors, the Telaar/Garadar innkeepers (Nagrand) as well as the "
			.."Sweet Treats vendors at SW/Org during Children's Week too.\n\nNote the level requirements of the food too.\n\n"
			.."Two extra related achievements which are not a part of Children's Week have also been included below!", }, }, }
ns.setFlavour = { flavour=true, noCoords=true, alwaysShow=true, noCoords= true, noContinent=true,
			tip="Children's Week is here! Taking place once a year in Orgrimmar, Stormwind, Dalaran, and Shattrath City, this "
			.."week-long celebration is a time to give back to the innocents orphaned by war...\n\n Take an orphan under your "
			.."wing, perform the tasks you are presented with and you’ll show one of Azeroth’s children that you care (and be "
			.."rewarded with a special in-game pet to boot).\n\nMany orphans wish they had someone special to show them the "
			.."wonders of the world. Throughout the year, they often spend their time wandering around their home cities of "
			.."Stormwind or Orgrimmar, dreaming of the day they'll be old enough (and big enough) to venture out into the world "
			.."to see the sights their parents would have shown them.\n\nDuring Children's Week, brave heroes of the Horde and "
			.."the Alliance can make these kids' dreams come true! Visit your faction’s local orphanage to take one of these "
			.."children on a whirlwind adventure around the world.\n\n((Blizzard Website 27th April 2012, Nebu))", }
ns.setPetParade = { pets=true, name="Pet Parade", alwaysShow=true, noCoords= true, noContinent=true,
			pets={ { name="Mr. Wiggles", speciesID=126, }, { name="Scooter the Snail", speciesID=289, },		
			{ name="Speedy", speciesID=125, }, { name="Whiskers the Rat", speciesID=127, tip="Above pets are from SW/Org. "
			.."Scooter is NOT available for purchase with a Figurine token but may be acquired directly as a quest reward" , },
			{ name="Egbert", speciesID=158, version=20100, }, { name="Peanut", speciesID=159, version=20100, },
			{ name="Willy", speciesID=157, version=20100, }, { name="Legs", speciesID=308, version=40100,
			tip="Above are from Shattrath. Legs is NOT available for purchase with a Figurine token but may be acquired directly "
			.."as a quest reward", },
			{ name="Curious Oracle Hatchling", speciesID=225, version=30200, },
			{ name="Curious Wolvar Pup", speciesID=226, version=30200,
			tip="Above are from Dalaran, Northrend. Your Frenzyheart/Oracle reputation is irrelevant", },
			{ name="Beakbert", speciesID=2576, version=80105, }, { name="Froglet", speciesID=2577, version=80105, },
			{ name="Mr. Crabs", speciesID=2575, version=80105, }, { name="Scaley", speciesID=2578, version=80105,
			tip="Above are from Hook Point, Boralus or the Grand Bazaar in Dazar'alor", },
			{ name="Argos", speciesID=4466, version=110105, }, { name="Goggles", speciesID=4635, version=110105, },
			{ name="Helpful Workshop Bot", speciesID=3245, version=110105, tip="Above are from Dornogal", }, },
			guide=ns.wellLovedGuide}
ns.setRelated = { related=true, title="Related Achievements", alwaysShow=true, noCoords= true, noContinent=true,
			achievements={ { id=877 }, { id=1780, showAllCriteria=true, }, }, -- The Cake Is Not A Lie; Second That Emotion
			tip="\nOn Dalaran Brownies...\"Make sure you're seated while you enjoy this delicious baked good; it will take all "
			.."your concentration to navigate each gooey, decadent bite. Oozing with a chocolate glaze and dusted with cocoa and "
			.."spice, these are the brownies to beat all brownies. But don't set a bad example - bring enough to share!\" "
			.."((World of Warcraft: The Official Cookbook))", }
ns.setUtgarde = { utgarde=true, alwaysShow=true, noCoords= true, noContinent=true, -- Hail To The King, Baby; Veteran Nanny
			achievements={ { id=1790, tip=ns.utgardePinnacle, },
			{ id=1786, showAllCriteria=true, tip="Best to do this at the very start of the event. There'll be lots of other "
			.."players with their orphans and opposing players will be much more chill. The AB flag cannot be grey! WG: Watch "
			.."for flag drop trading at the start of the event. AV: You must successfully click and cast (10s) on the banner "
			.."at the top of one of the small towers. EotS: Flag click also takes about 10s. Look for friendly trading", }, }, } 

--==================================================================================================================================
--
-- KALIMDOR
--
--==================================================================================================================================

ns.alurmi = "Buy the toy dragon from Alurmi after you have met Zaladormu"
ns.blax = "Buy the kite from Blax, who pats through here"
ns.oros = "O'ros, a huge Naaru at the very bottom of The Exodar. Look for a down ramp. This is a place rarely "
					.."visited by adventurers! Note that you must actually talk to O'ros to trigger completion"
ns.tigule = ". You may buy Tigule's Strawberry Ice Cream here. See the pin cluster for other sources"
ns.zaladormu = "Meet Zaladormu first. There'll be a portal back to SW/Org near the entrance/exit"

ns.points[ ns.map.ashenvale ] = { -- Ashenvale
	[68208916] = { orphan=true, faction="Horde",
					quests={ { id=911, name="Gateway to the Frontier", versionUnder=40100, level=10, qType="Seasonal", }, },
					tip="Just walk between The Barrens and Ashenvale", },
}

ns.points[ ns.map.azshara ] = { -- Azshara
	[50707395] = { orphan=true, faction="Horde",
					quests={ { id=29146, name="Ridin' the Rocketway", version=40100, level=10, qType="Seasonal", }, },
					tip="Do NOT talk to the Rocket-Jockey goblin. You do NOT want the regular rocket ride.\n\nOn the pavillion "
					.."you'll see a Redhound Two-Seater. That's the one you'll ride, but with your orphan summoned of course!", },
}

ns.points[ ns.map.azuremyst ] = { -- Azuremyst Isle
	[28974083] = { orphan=true, faction="Alliance", quests={ { id=10956, name="The Seat of the Naaru", level=10,
					qType="Seasonal", }, }, tip=ns.oros, },
}

ns.points[ ns.map.barrens ] = { -- Northern Barrens
	[05637883] = { orphan=true, faction="Horde",
					quests={ { id=925, name="Cairne's Hoofprint", versionUnder=40100, level=10, qType="Seasonal", }, },
					tip="Cairne Bloodhoof's teepee", },
	[22827356] = { orphan=true, faction="Horde",
					quests={ { id=29176, name="The Fallen Chieftain", version=40100, level=10, qType="Seasonal", }, },
					tip="Cairne Bloodhoof's funeral pyre", },
	[47000500] = { orphan=true, faction="Horde", -- Retail: 42371473
					quests={ { id=911, name="Gateway to the Frontier", versionUnder=40100, level=10, qType="Seasonal", }, },
					tip="Just walk between The Barrens and Ashenvale", },
	[63003800] = { orphan=true, faction="Horde", -- Retail: 70157326
					quests={ { id=910, name="Down at the Docks", versionUnder=40100, level=10, qType="Seasonal", }, }, },
}

ns.points[ 75 ] = { -- Caverns of Time
	[49705425] = { orphan=true, noContinent = true, 
					quests={ { id=10962, name="Time to Visit the Caverns", faction="Alliance", level=10, qType="Seasonal", },
					{ id=10963, name="Time to Visit the Caverns", faction="Horde", level=10, qType="Seasonal", }, },
					tip=ns.zaladormu, },
	[68815628] = { orphan=true, noContinent = true,
					quests={ { id=10962, name="Time to Visit the Caverns", faction="Alliance", level=10, qType="Seasonal", },
					{ id=10963, name="Time to Visit the Caverns", faction="Horde", level=10, qType="Seasonal", }, },
					tip=ns.alurmi, },
}

ns.points[ 74 ] = { -- Caverns of Time - Timeless Tunnel
	[17427492] = { orphan=true, noContinent = true,
					quests={ { id=10962, name="Time to Visit the Caverns", faction="Alliance", level=10, qType="Seasonal", },
					{ id=10963, name="Time to Visit the Caverns", faction="Horde", level=10, qType="Seasonal", }, },
					tip=ns.zaladormu, },
	[39947732] = { orphan=true, noContinent = true,
					quests={ { id=10962, name="Time to Visit the Caverns", faction="Alliance", level=10, qType="Seasonal", },
					{ id=10963, name="Time to Visit the Caverns", faction="Horde", level=10, qType="Seasonal", }, },
					tip=ns.alurmi, },
}

ns.points[ ns.map.desolace ] = { -- Desolace
	[96865543] = { orphan=true, faction="Horde",
					quests={ { id=925, name="Cairne's Hoofprint", versionUnder=40100, level=10, qType="Seasonal", }, },
					tip="Cairne Bloodhoof's teepee", },
}

ns.points[ ns.map.durotar ] = { -- Durotar
	[47490371] = { orphan=true, version=60000, quests=ns.setOrgrimmar }, -- Selected location for visibility
	[48000540] = { orphan=true, version=40100, versionUnder=60000, quests=ns.setOrgrimmar }, -- Selected location for visibility
}

ns.points[ ns.map.mulgore ] = { -- Mulgore
	[42672865] = { orphan=true, faction="Horde",
					quests={ { id=925, name="Cairne's Hoofprint", versionUnder=40100, level=10, qType="Seasonal", }, },
					tip="Cairne Bloodhoof's teepee", },
	[60792309] = { orphan=true, faction="Horde",
					quests={ { id=29176, name="The Fallen Chieftain", version=40100, level=10, qType="Seasonal", }, },
					tip="Cairne Bloodhoof's funeral pyre", },
}

ns.points[ ns.map.orgrimmar ] = { -- Orgrimmar
	[36278698] = { orphan=true, faction="Horde", version=80000, noContinent = true,
					quests={ { id=29191, name="You Scream, I Scream...", level=10, qType="Seasonal", }, }, tip=ns.icecreamStand, },
	[38818704] = { orphan=true, faction="Horde", versionUnder=80000, noContinent = true,
					quests={ { id=29191, name="You Scream, I Scream...", level=10, qType="Seasonal", }, }, tip=ns.icecreamStand, },
	[39767867] = { orphan=true, faction="Horde", noContinent = true,
					quests={ { id=54146, name="Strong New allies", version=80105, level=10, qType="Seasonal", }, },
					tip="Orgrimmar Embassy", },
	[56419256] = { orphan=true, quests={ 
					{ id=10963, name="Time to Visit the Caverns", faction="Horde", level=10, qType="Seasonal", }, },
					tip="Take the portal to the Caverns of Time. It's in the lower level of the Pathfinder's Den", },
	[57405103] = { orphan=true, faction="Horde", noContinent = true,
					quests={ { id=29190, name="Let's Go Fly a Kite", version=40100, level=10, qType="Seasonal", }, },
					tip=ns.blax, },
	[57965762] = { orphan=true, quests=ns.setOrgrimmar, },
	[58055691] = { vendor=true, version=110105, name="Leilal Knitterton", guide=ns.wellLovedGuide, },

	[52206900] = { achieves=true, faction="Horde", versionUnder=40000, achievements={ { id=1788, showAllCriteria=true,
					tip="Alowicious Czervik" ..ns.tigule, }, }, },
	[53327928] = { achieves=true, faction="Horde", version=40000, achievements={ { id=1788, showAllCriteria=true,
					tip="Alowicious Czervik" ..ns.tigule, }, }, },
}

ns.points[ 199 ] = { -- Southern Barrens
	[33262452] = { orphan=true, faction="Horde",
					quests={ { id=29176, name="The Fallen Chieftain", version=40100, level=10, qType="Seasonal", }, },
					tip="Cairne Bloodhoof's funeral pyre", },
}

ns.points[ ns.map.tanaris ] = { -- Tanaris
	[59545696] = { orphan=true, versionUnder=80000, noContinent = true, 
					quests={ { id=10962, name="Time to Visit the Caverns", faction="Alliance", level=10, qType="Seasonal", },
					{ id=10963, name="Time to Visit the Caverns", faction="Horde", level=10, qType="Seasonal", }, },
					tip=ns.zaladormu, },
	[63005730] = { orphan=true, versionUnder=80000, noContinent = true,
					quests={ { id=10962, name="Time to Visit the Caverns", faction="Alliance",level=10, qType="Seasonal", },
					{ id=10963, name="Time to Visit the Caverns", faction="Horde", level=10, qType="Seasonal", }, },
					tip=ns.alurmi, },
	[64834997] = { orphan=true, quests={ { id=10962, name="Time to Visit the Caverns", faction="Alliance", level=10,
					qType="Seasonal", }, 
					{ id=10963, name="Time to Visit the Caverns", faction="Horde", level=10, qType="Seasonal", }, },
					tip="Enter the Caverns through here or take a portal from the SW/Org portal room", },
}

ns.points[ ns.map.teldrassil ] = { -- Teldrassil
}

ns.points[ ns.map.theExodar ] = { -- The Exodar
	[29763325] = { orphan=true, version=20100, faction="Alliance", quests={ { id=10968, name="Call of the Farseer", level=10,
					qType="Seasonal", }, }, tip="Nobundo is on an upper level", },
	[58004149] = { orphan=true, faction="Alliance", quests={ { id=10956, name="The Seat of the Naaru", level=10,
					qType="Seasonal", }, }, tip=ns.oros, },
}

ns.points[ ns.map.thousand ] = { -- Thousand Needles
	[69808500] = { achieves=true, achievements={ { id=1788, showAllCriteria=true, tip="Brivelthwerp" ..ns.tigule, }, }, },
}

ns.points[ ns.map.thunder ] = { -- Thunder Bluff
	[61145171] = { orphan=true, faction="Horde",
					quests={ { id=925, name="Cairne's Hoofprint", versionUnder=40100, level=10, qType="Seasonal", }, },
					tip="Cairne Bloodhoof's teepee", },
}

ns.points[ ns.map.ungoro ] = { -- UnGoro Crater
	[47540925] = { orphan=true, quests={ { id=13956, name="Meeting a Great One", level=10, qType="Seasonal", }, }, tip=ns.oracles
					.."\n\nNote that the Waygate is usable to get to Sholazar, regardless of your questing progress in Sholazar", },
}

ns.points[ ns.map.kalimdor ] = { -- Kalimdor
	[02506320] = ns.setAchieves,
	[02506750] = ns.setMeta,
	[04707030] = ns.setUtgarde,
	[05006600] = ns.setFlavour,
	[05206200] = ns.setPetParade,
	[07306900] = ns.setRelated,
	[07606480] = ns.setBadEx,
}

--==================================================================================================================================
--
-- EASTERN KINGDOMS
--
--==================================================================================================================================

ns.craggle = "Buy the kite from Craggle, who pats through here"
ns.etcUp = "The (Elite) Tauren Chieftains are on the balcony above. " ..ns.etc

ns.points[ ns.map.darnassus ] = { -- Darnassus
	[41004300] = { orphan=true, faction="Alliance", -- Retail: 43605100. Didn't do a Teldrassil map coords retail: 29264869
					quests={ { id=1479, name="The Bough of the Eternals", versionUnder=40000, level=10, qType="Seasonal", }, }, },
	[43157807] = { orphan=true, faction="Alliance", noContinent=true,
					quests={ { id=29107, name="Malfurion Has Returned!", versionUnder=80105, version=40100, level=10,
					qType="Seasonal", }, }, tip="Malfurion is on the mezzanine level of the Temple of the Moon", },
	[44018492] = { orphan=true, faction="Alliance", noContinent=true,
					quests={ { id=29107, name="Malfurion Has Returned!", versionUnder=80105, version=40100, level=10,
					qType="Seasonal", }, }, tip="The ramp up to the mezzanine level begins here", },
}

ns.points[ ns.map.dunMorogh ] = { -- Dun Morogh
	[65322761] = { orphan=true, faction="Alliance",
					quests={ { id=29106, name="The Biggest Diamond Ever!", version=40100, level=10, qType="Seasonal", }, },
					tip="Enter Ironforge and proceed to The High Seat", },
}

ns.points[ ns.map.dustwallow ] = { -- Dustwallow Marsh
	[66274904] = { orphan=true, faction="Alliance",
					quests={ { id=558, name="Jaina's Autograph", versionUnder=40100, level=10, qType="Seasonal", }, },
					tip="She's at the very top of the tower", },
}

ns.points[ ns.map.elwynn ] = { -- Elwynn Forest
	[19124732] = { orphan=true, faction="Alliance",
					quests={ { id=29119, name="You Scream, I Scream...", level=10, qType="Seasonal", }, }, tip=ns.icecreamStand, },
	[21301009] = { orphan=true, faction="Alliance",
					quests={ { id=54130, name="Our New Friends", version=80105, level=10, qType="Seasonal", }, },
					tip="Stormwind Embassy", },
	[22783748] = { orphan=true, faction="Alliance",
					quests={ { id=29117, name="Let's Go Fly a Kite", version=40100, level=10, qType="Seasonal", }, },
					tip=ns.craggle, },
	[26473297] = { orphan=true, faction="Alliance",
					quests={ { id=29117, name="Let's Go Fly a Kite", version=40100, level=10, qType="Seasonal", }, },
					tip=ns.craggle, },
}

ns.points[ ns.map.eversong ] = { -- Eversong Woods
	[57714718] = { orphan=true, faction="Horde", quests={ { id=11975, name="Now, When I Grow Up...", level=10,
					qType="Seasonal", }, }, tip=ns.etcUp, },
}

ns.points[ 1455 ] = { -- Ironforge
	[33384766] = { orphan=true, faction="Alliance", version=80000, noContinent = true,
					quests={ { id=29106, name="The Biggest Diamond Ever!", version=40100, level=10, qType="Seasonal", }, },
					tip="Stand here in the Old Ironforge Library", },
}

ns.points[ ns.map.ironforge ] = { -- Ironforge
	[33384766] = { orphan=true, faction="Alliance", versionUnder=80000, noContinent = true,
					quests={ { id=29106, name="The Biggest Diamond Ever!", version=40100, level=10, qType="Seasonal", }, },
					tip="Stand here in the Old Ironforge Library", },
	[44025189] = { orphan=true, faction="Alliance",
					quests={ { id=29106, name="The Biggest Diamond Ever!", version=40100, level=10, qType="Seasonal", }, },
					tip="Descend to Old Ironforge via this vault door", },
}

ns.points[ ns.map.lochModan ] = { -- Loch Modan
	[48001300] = { orphan=true, faction="Alliance",
					quests={ { id=1558, name="The Stonewrought Dam", versionUnder=40000, level=10, qType="Seasonal", }, }, },
}

ns.points[ 1361 ] = { -- Old Ironforge
	[35855125] = { orphan=true, faction="Alliance", noContinent = true,
					quests={ { id=29106, name="The Biggest Diamond Ever!", version=40100, level=10, qType="Seasonal", }, },
					tip="Stand here in the Old Ironforge Library", },
}

ns.points[ ns.map.silvermoon ] = { -- Silvermoon City
	[76698194] = { orphan=true, faction="Horde", quests={ { id=11975, name="Now, When I Grow Up...", level=10,
					qType="Seasonal", }, }, tip=ns.etcUp, },
}

ns.points[ ns.map.stormwind ] = { -- Stormwind City
	[47353819] = { orphan=true, versionUnder=40000, quests=ns.setStormwind },
	[49008970] = { orphan=true, faction="Alliance", noContinent = true,
					quests={ { id=29119, name="You Scream, I Scream...", version=40100, level=10, qType="Seasonal", }, },
					tip=ns.icecreamStand, },
	[48356925] = { orphan=true, faction="Alliance", version=100000, noContinent = true,
					achievements={ { id=1788, showAllCriteria=true, }, }, tip="Lisa McKeever" ..ns.tigule, },
	[51627238] = { orphan=true, faction="Alliance", version=40000, versionUnder=100000, noContinent = true,
					achievements={ { id=1788, showAllCriteria=true, }, }, tip="Lisa McKeever" ..ns.tigule, },
	[53711592] = { orphan=true, faction="Alliance", noContinent = true,
					quests={ { id=54130, name="Our New Friends", version=80105, level=10, qType="Seasonal", }, },
					tip="Stormwind Embassy", },
	[56297003] = { orphan=true, faction="Alliance", noContinent = true,
					quests={ { id=29117, name="Let's Go Fly a Kite", version=40100, level=10, qType="Seasonal", }, },				
					tip=ns.craggle, },
	[54006550] = { achieves=true, faction="Alliance", version=20000, versionUnder=30000, tip="Emmithue Smails" ..ns.tigule,
					quests={ { id=4822, name="You Scream, I Scream...", versionUnder=40100, level=10, qType="Seasonal", }, }, },
	[54106480] = { achieves=true, faction="Alliance", versionUnder=20000, tip="Emmithue Smails" ..ns.tigule,
					quests={ { id=4822, name="You Scream, I Scream...", versionUnder=40100, level=10, qType="Seasonal", }, }, },
	[56325400] = { orphan=true, version=40000, quests=ns.setStormwind, },
	[56635427] = { vendor=true, version=110105, name="Brundia Braidhammer", guide=ns.wellLovedGuide, },
	[61507480] = { achieves=true, faction="Alliance", version=30000, versionUnder=40000, tip="Emmithue Smails" ..ns.tigule,
					achievements={ { id=1788, showAllCriteria=true, }, },
					quests={ { id=4822, name="You Scream, I Scream...", versionUnder=40100, level=10, qType="Seasonal", },
					{ id=29119, name="You Scream, I Scream...", version=40100, level=10, qType="Seasonal", }, }, },
	[61307502] = { achieves=true, faction="Alliance", version=40000, tip="Emmithue Smails" ..ns.tigule,
					achievements={ { id=1788, showAllCriteria=true, }, },
					quests={ { id=4822, name="You Scream, I Scream...", versionUnder=40100, level=10, qType="Seasonal", },
					{ id=29119, name="You Scream, I Scream...", version=40100, level=10, qType="Seasonal", }, }, },
	[62426118] = { orphan=true, faction="Alliance", noContinent = true,
					quests={ { id=29117, name="Let's Go Fly a Kite", version=40100, level=10, qType="Seasonal", }, },
					tip=ns.craggle, },
}

ns.points[ ns.map.northStrangle ] = { -- Stranglethorne
	[15691034] = { orphan=true, faction="Alliance",
					quests={ { id=1687, name="Spooky Lighthouse", versionUnder=40100, level=10, qType="Seasonal", }, }, },
}

ns.points[ ns.map.teldrassil ] = { -- Teldrassil
	[29155579] = { orphan=true, faction="Alliance",
					quests={ { id=29107, name="Malfurion Has Returned!", versionUnder=80105, version=40100, level=10,
					qType="Seasonal", }, }, tip="Malfurion is on the mezzanine level of the Temple of the Moon", },
}

ns.points[ ns.map.tirisfal ] = { -- Tirisfal Glades
	[61827288] = { orphan=true, faction="Horde",
					quests={ { id=1800, name="Lordaeron Throne Room", versionUnder=40100, level=10, qType="Seasonal", }, },
					tip="Don't descend into Undercity. Stay in the ruins. Go here to the circular throne room", },
	[61837111] = { orphan=true, faction="Horde",
					quests={ { id=29167, name="The Banshee Queen", versionUnder=80105, version=40400, level=10,
					qType="Seasonal", }, }, tip="Descend into the Undercity", },
}

ns.points[ ns.map.undercity ] = { -- Undercity
	[52286402] = { orphan=true, faction="Horde",
					quests={ { id=29167, name="The Banshee Queen", versionUnder=80105, version=40400, level=10,
					qType="Seasonal", }, },
					tip="The corridor to the Royal Quarter begins here. You can also use the Tirisfal sewer entrance/exit", },
	[58059178] = { orphan=true, faction="Horde",
					quests={ { id=29167, name="The Banshee Queen", versionUnder=80105, version=40400, level=10,
					qType="Seasonal", }, }, tip="The Banshee Queen's Chamber", },
	[60003500] = { orphan=true, faction="Horde",
					quests={ { id=1800, name="Lordaeron Throne Room", versionUnder=40100, level=10, qType="Seasonal", }, },
					tip="The Throne Room is ABOVE - at the Ruins of Lordaeron", },
	[66052852] = { orphan=true, faction="Horde",
					quests={ { id=29167, name="The Banshee Queen", versionUnder=80105, version=40400, level=10,
					qType="Seasonal", }, }, tip="Descend into the Undercity", },
}

ns.points[ ns.map.westfall ] = { -- Westfall
	[30518642] = { orphan=true, faction="Alliance",
					quests={ { id=1687, name="Spooky Lighthouse", versionUnder=40100, level=10, qType="Seasonal", }, }, },
	[57715313] = { orphan=true, faction="Alliance",
					quests={ { id=29093, name="Crusin' the Chasm", version=40100, level=10, qType="Seasonal", }, },
					tip="There are choppers next to Twilber Torquewrench", },
}

ns.points[ ns.map.easternK ] = { -- Eastern Kingdoms
	[02506320] = ns.setAchieves,
	[02506750] = ns.setMeta,
	[04707030] = ns.setUtgarde,
	[05006600] = ns.setFlavour,
	[05206200] = ns.setPetParade,
	[07306900] = ns.setRelated,
	[07606480] = ns.setBadEx,
}

--==================================================================================================================================
--
-- THE BURNING CRUSADE / OUTLAND
--
--==================================================================================================================================

ns.points[ ns.map.hellfire ] = { -- Hellfire
	[07469793] = { orphan=true, quests=ns.setShattrath, },
	[88814940] = { orphan=true, tip="The Dark Portal", quests={ { id=10952, name="A Trip to the Dark Portal", faction="Alliance",
					level=10, qType="Seasonal", }, { id=10951, name="A Trip to the Dark Portal", faction="Horde", level=10,
					qType="Seasonal", }, ns.ETCshortcutSet, }, },
}

ns.points[ ns.map.nagrand ] = { -- Nagrand
	[31495761] = { orphan=true, faction="Alliance", quests={ { id=10954, name="Jheel is at Aeris Landing!", level=10,
					qType="Seasonal", }, }, tip="Jheel", },
	[54217610] = { achieves=true, faction="Alliance", achievements={ { id=1788, showAllCriteria=true,
					tip="Caregiver Isel" ..ns.tigule, }, }, },
	[56743451] = { achieves=true, faction="Horde", achievements={ { id=1788, showAllCriteria=true,
					tip="Matron Tikkit" ..ns.tigule, }, }, },
	[60662210] = { orphan=true, faction="Horde", quests={ { id=10953, name="Visit the Throne of the Elements", 
					level=10, qType="Seasonal", }, ns.ETCshortcutSet, }, tip="Elementalist Sharvak", },
	[93065247] = { orphan=true, quests=ns.setShattrath, },
	[97019153] = { orphan=true, faction="Alliance", quests={ { id=10950, name="Auchindoun and the Ring of Observance",
					level=10, qType="Seasonal", }, }, tip="Auchindoun Meeting Stone", },
}

ns.points[ ns.map.shattrath ] = { -- Shattrath
	[48584202] = { orphan=true, quests={ ns.ETCshortcutSet, }, },
	[75084790] = { orphan=true, quests=ns.setShattrath, },
}

ns.points[ ns.map.terokkar ] = { -- Terokkar Forest
	[35722475] = { orphan=true, quests=ns.setShattrath, },
	[39956471] = { orphan=true, faction="Alliance", quests={ { id=10950, name="Auchindoun and the Ring of Observance",
					level=10, qType="Seasonal", }, }, tip="Auchindoun Meeting Stone", },
}

ns.points[ ns.map.zangarmarsh ] = { -- Zangarmarsh
	[19285133] = { orphan=true, faction="Horde", quests={ { id=10945, name="Hch'uu and the Mushroom People", level=10,
					qType="Seasonal", }, ns.ETCshortcutSet, }, },
	[46039442] = { achieves=true, faction="Horde", achievements={ { id=1788, showAllCriteria=true,
					tip="Matron Tikkit" ..ns.tigule, }, }, },
}

ns.points[ ns.map.outland ] = { -- Outland
	[02506320] = ns.setAchieves,
	[02506750] = ns.setMeta,
	[04707030] = ns.setUtgarde,
	[05006600] = ns.setFlavour,
	[05206200] = ns.setPetParade,
	[07306900] = ns.setRelated,
	[07606480] = ns.setBadEx,
}

--==================================================================================================================================
--
-- WRATH OF THE LICH KING / NORTHREND
--
--==================================================================================================================================

ns.points[ 114 ] = { -- Borean Tundra
	[43601267] = { orphan=true, quests={ { id=13950, name="Playmates!", level=10, qType="Seasonal", }, },
					tip="Winterfin retreat. " ..ns.oracles, },
}

ns.points[ 125 ] = { -- Dalaran
	[43624595] = { orphan=true, quests={ { id=13937, name="A Trip To The Wonderworks", level=10, qType="Seasonal",
					tip=ns.oracles, }, { id=13938, name="A Trip To The Wonderworks", level=10, qType="Seasonal",
					tip=ns.frenzyheart, }, }, },
	[49366327] = { orphan=true, quests=ns.setDalaran, tip="Begin and end here", },
	[51242910] = { achieves=true, achievements={ { id=1788, showAllCriteria=true,
					tip="Buy the Red Velvet Cupcake, Lovely Cake (for the slice), Dalaran Brownie, and Dalaran Donut from "
					.."Aimee", }, }, },
}

ns.points[ 115 ] = { -- Dragonblight
	[46606000] = { orphan=true, quests={ { id=13951, name="Playmates!", level=10, qType="Seasonal", }, },
					tip="Snowfall Glade. " ..ns.frenzyheart, },
	[59835466] = { orphan=true, quests={ { id=13954, name="The Dragon Queen", level=10, qType="Seasonal", tip=ns.oracles, },
					{ id=13955, name="The Dragon Queen", level=10, qType="Seasonal", tip=ns.frenzyheart, }, },
					guide="She's at the very top of Wyrmrest Temple", },
	[72023971] = { orphan=true, quests={ { id=13933, name="The Bronze Dragonshrine", level=10, qType="Seasonal", tip=ns.oracles, },
					{ id=13934, name="The Bronze Dragonshrine", level=10, qType="Seasonal", tip=ns.frenzyheart, }, }, },
}

ns.points[ 116 ] = { -- Grizzly Hills
	[50614536] = { orphan=true, quests={ { id=13929, name="The Biggest Tree Ever!", level=10, qType="Seasonal", tip=ns.oracles, },
					{ id=13930, name="Home Of The Bear-Men", level=10, qType="Seasonal", tip=ns.frenzyheart, }, }, },
}

ns.points[ 117 ] = { -- Howling Fjord
	[57234656] = { achieves=true, achievements={ { id=1790, tip=ns.utgardePinnacle ..". Enter here", }, }, },
}

ns.points[ 119 ] = { -- Sholazar Basin
	[27115865] = { orphan=true, quests={ { id=13957, name="The Mighty Hemet Nesingwary", level=10, qType="Seasonal", }, },
					tip="Hemet's Base Camp. " ..ns.frenzyheart, },
	[40398311] = { orphan=true, quests={ { id=13956, name="Meeting a Great One", level=10, qType="Seasonal", }, }, tip=ns.oracles
					.."\n\nNote that the Waygate is usable to get to Un'Goro, regardless of your questing progress in Sholazar", },
}

ns.points[ 113 ] = { -- Northrend
	[02506320] = ns.setAchieves,
	[02506750] = ns.setMeta,
	[04707030] = ns.setUtgarde,
	[05006600] = ns.setFlavour,
	[05206200] = ns.setPetParade,
	[07306900] = ns.setRelated,
	[07606480] = ns.setBadEx,
}

--==================================================================================================================================
--
-- MISTS OF PANDARIA
--
--==================================================================================================================================

ns.points[ 424 ] = { -- Pandaria
	[02506320] = ns.setAchieves,
	[02506750] = ns.setMeta,
	[04707030] = ns.setUtgarde,
	[05006600] = ns.setFlavour,
	[05206200] = ns.setPetParade,
	[07306900] = ns.setRelated,
	[07606480] = ns.setBadEx,
}

--==================================================================================================================================
--
-- WARLORDS OF DRAENOR / GARRISON
--
--==================================================================================================================================

ns.points[ 572 ] = { -- Draenor
	[02506320] = ns.setAchieves,
	[02506750] = ns.setMeta,
	[04707030] = ns.setUtgarde,
	[05006600] = ns.setFlavour,
	[05206200] = ns.setPetParade,
	[07306900] = ns.setRelated,
	[07606480] = ns.setBadEx,
}

--==================================================================================================================================
--
-- LEGION / BROKEN ISLES
--
--==================================================================================================================================

ns.points[ 619 ] = { -- Broken Isles
	[02506320] = ns.setAchieves,
	[02506750] = ns.setMeta,
	[04707030] = ns.setUtgarde,
	[05006600] = ns.setFlavour,
	[05206200] = ns.setPetParade,
	[07306900] = ns.setRelated,
	[07606480] = ns.setBadEx,
}

--==================================================================================================================================
--
-- BATTLE FOR AZEROTH / KUL TIRAS & ZANDALAR
--
--==================================================================================================================================

ns.points[ 1161 ] = { -- Boralus
	[47984028] = { orphan=true, faction="Alliance", quests=ns.setBoralus },
}

ns.points[ 1165 ] = { -- Dazar'alor
	[54648461] = { orphan=true, faction="Horde", quests=ns.setDazaralor },
}

ns.points[ 896 ] = { -- Drustvar
	[36005120] = { orphan=true, faction="Alliance", quests={ { id=53863, name="Bird Friends", level=10, qType="Seasonal", }, },
					tip="Stand in front of the statue of Arom Waycrest", },
	[46354478] = { orphan=true, faction="Alliance", quests={ { id=53864, name="Shapeshifters!", level=10, qType="Seasonal", }, },
					tip="The entrance to Ulfar's Den. Just stay here.\n\nNote that if you are on the quest \"The Old "
					.."Bear\" then you cannot complete this quest", },
}

ns.points[ 863 ] = { -- Nazmir
	[75515683] = { orphan=true, faction="Horde", quests={ { id=53967, name="The Frogmarsh", level=10, qType="Seasonal", }, },
					tip="Krag'wa the Huge", },
}

ns.points[ 942 ] = { -- Stormsong Valley
	[72654994] = { orphan=true, faction="Alliance", quests={ { id=53862, name="The Squid Shrine", level=10, qType="Seasonal", }, },
					tip="Dismount and wait for Brother Pike to appear", },
}

ns.points[ 895 ] = { -- Tiragarde Sound
	[42592253] = { orphan=true, faction="Alliance", quests={ { id=53859, name="The Mountain Folk", level=10, qType="Seasonal", }, },
					tip="Ensure your orphan can meet Tagart", },
	[68962952] = { orphan=true, faction="Alliance", quests=ns.setBoralus },
	[79788253] = { orphan=true, faction="Alliance", quests={ { id=53861, name="Yo Ho, Yo Ho!", level=10, qType="Seasonal", }, },
					tip="Ensure your orphan can meet the Irontide Recruiter", },
}

ns.points[ 864 ] = { -- Vol'dun
	[27095256] = { orphan=true, faction="Horde", quests={ { id=53970, name="The Sethrak Queen", level=10, qType="Seasonal", }, },
					tip="Meet Vorrik at the top of the Sanctuary of the Devoted", },
	[28958870] = { orphan=true, faction="Horde", quests={ { id=53969, name="Hunting for Gold", level=10, qType="Seasonal", }, },
					tip="The Golden Isle", },
}

ns.points[ 862 ] = { -- Zuldazar
	[49103150] = { orphan=true, faction="Horde", quests={ { id=53968, name="The Shifting Pack", level=10, qType="Seasonal", }, },
					tip="The Lair of Gonk at the Garden of the Loa", },
	[59525725] = { orphan=true, faction="Horde", quests=ns.setDazaralor },
	[71404910] = { orphan=true, faction="Horde", quests={ { id=53966, name="Loa of Winds", level=10, qType="Seasonal", }, },
					tip="Pa'ku's landing", },
}

ns.points[ 876 ] = { -- Kul Tiras
	[02506320] = ns.setAchieves,
	[02506750] = ns.setMeta,
	[04707030] = ns.setUtgarde,
	[05006600] = ns.setFlavour,
	[05206200] = ns.setPetParade,
	[07306900] = ns.setRelated,
	[07606480] = ns.setBadEx,
}

ns.points[ 875 ] = { -- Zandalar
	[02506320] = ns.setAchieves,
	[02506750] = ns.setMeta,
	[04707030] = ns.setUtgarde,
	[05006600] = ns.setFlavour,
	[05206200] = ns.setPetParade,
	[07306900] = ns.setRelated,
	[07606480] = ns.setBadEx,
}

--==================================================================================================================================
--
-- SHADOWLANDS
--
--==================================================================================================================================

ns.points[ 1550 ] = { -- Shadowlands
	[02506320] = ns.setAchieves,
	[02506750] = ns.setMeta,
	[04707030] = ns.setUtgarde,
	[05006600] = ns.setFlavour,
	[05206200] = ns.setPetParade,
	[07306900] = ns.setRelated,
	[07606480] = ns.setBadEx,
}

--==================================================================================================================================
--
-- DRAGONFLIGHT / DRAGON ISLES
--
--==================================================================================================================================

ns.points[ 2112 ] = { -- Valdrakken
}

ns.points[ 1978 ] = { -- Dragon Isles
	[02506320] = ns.setAchieves,
	[02506750] = ns.setMeta,
	[04707030] = ns.setUtgarde,
	[05006600] = ns.setFlavour,
	[05206200] = ns.setPetParade,
	[07306900] = ns.setRelated,
	[07606480] = ns.setBadEx,
}

--==================================================================================================================================
--
-- THE WAR WITHIN / KHAZ ALGAR
--
--==================================================================================================================================

ns.setDornogal = { version=110105, level=10, { id=89317, name="Children's Week in Dornogal", qType="Seasonal", }, -- Skibbles
			{ id=89318, name="Bold for a Kobold", qType="Seasonal", },
			{ id=89319, name="The Wondrous Weave", qType="Seasonal", },
			{ id=89320, name="The Eager Engineer", qType="Seasonal", },
			{ id=89321, name="Recreation for Rooks", qType="Seasonal", },
			{ id=89322, name="A Brighter Tomorrow", qType="Seasonal", },
			guide="Go to Ullna in Dornogal. " ..ns.completeTasks, }

ns.points[ 2255 ] = { -- Azj'Kahet
	[55554388] = { orphan=true, quests={ { id=89319, name="The Wondrous Weave", qType="Seasonal", }, },
					tip="The Widow Arak'nai is suspended in a web above you", },
	[56814560] = { orphan=true, quests={ { id=89319, name="The Wondrous Weave", qType="Seasonal", }, },
					tip="The weaving minigame reuires you to make the red tangled mess into white threads. I did this by "
					.."four separated loops.\n\nYou'll then go back to the Widow. Talk to her. Wait / move a bit to "
					.."trigger. I found succcess standing on the original AddOn marker for this quest", },
}

ns.points[ 2339 ] = { -- Dornogal
	[27224070] = { orphan=true, quests={ { id=89321, name="Recreation for Rooks", qType="Seasonal", }, }, },
	[50046245] = { orphan=true, quests={ { id=89321, name="Recreation for Rooks", qType="Seasonal", }, },
					tip="The trick is to stand as close as possible so that your hand may reach sufficiently far. You really "
					.."must be right on the edge of the forge press.\n\nBonus trivia: If you do accidentlly get squashed it "
					.."doesn't matter as a surprise awaits!", },
	[55302705] = { orphan=true, quests=ns.setDornogal, tip="For the very last quest, the NPC's are standing near Ullna", },
	[55892633] = { vendor=true, version=110105, name="Jepetto Joybuzz", guide=ns.wellLovedGuide, },
}

ns.points[ 2215 ] = { -- Hallowfall
	[41265387] = { orphan=true, quests={ { id=89318, name="Bold for a Kobold", qType="Seasonal", }, },
					tip="Takes place in this area. If it does not progress then dismiss skibbles. Leave the area. Dismount. "
					.."Relog. Summon Skibbles. Return to the exact area. Wait / interact with Skibbles / check if the activity "
					.."got \"ticked off\" anyway in the quest log", },
}

ns.points[ 2248 ] = { -- Isle of Dorn
	[50993897] = { orphan=true, quests=ns.setDornogal, },
	[51133879] = { vendor=true, version=110105, name="Jepetto Joybuzz", guide=ns.wellLovedGuide, },
}

ns.points[ 2214 ] = { -- The Ringing Deeps
	[72887318] = { orphan=true, quests={ { id=89320, name="The Eager Engineer", qType="Seasonal", }, },
					tip="Simply fly to here. Take the rocket drill ride", },
}

ns.points[ 2346 ] = { -- Undermine
	[19035130] = { orphan=true, quests={ { id=89320, name="The Eager Engineer", qType="Seasonal", }, },
					tip="The second step brings you to here. Doesn't matter if Undermine is new to you", },
	[27774782] = { orphan=true, quests={ { id=89320, name="The Eager Engineer", qType="Seasonal", }, },
					tip="Eventually you wind up at the College. Let the RP play out. Patience", },
	[34844086] = { orphan=true, quests={ { id=89320, name="The Eager Engineer", qType="Seasonal", }, },
					tip="Don't worry if your lobbie toon gets hammered on the way to Ullna. The Spirit Healer is not far away", },
}

ns.points[ 2274 ] = { -- Khaz Algar
	[02506320] = ns.setAchieves,
	[02506750] = ns.setMeta,
	[04707030] = ns.setUtgarde,
	[05006600] = ns.setFlavour,
	[05206200] = ns.setPetParade,
	[07306900] = ns.setRelated,
	[07606480] = ns.setBadEx,
}

--==================================================================================================================================
--
-- WORLD / OTHER
--
--==================================================================================================================================

--==================================================================================================================================
--
-- TEXTURES
--
-- These textures are all repurposed and as such have non-uniform sizing. In order to homogenise the sizes. I should also allow for
-- non-uniform origin placement as well as adjust the x,y offsets
--==================================================================================================================================

ns.textures[1] = "Interface\\PlayerFrame\\MonkLightPower"
ns.textures[2] = "Interface\\PlayerFrame\\MonkDarkPower"
ns.textures[3] = "Interface\\Common\\Indicator-Red"
ns.textures[4] = "Interface\\Common\\Indicator-Yellow"
ns.textures[5] = "Interface\\Common\\Indicator-Green"
ns.textures[6] = "Interface\\Common\\Indicator-Gray"
ns.textures[7] = "Interface\\Common\\Friendship-ManaOrb"	
ns.textures[8] = "Interface\\TargetingFrame\\UI-PhasingIcon"
ns.textures[9] = "Interface\\Store\\Category-icon-pets"
ns.textures[10] = "Interface\\Store\\Category-icon-featured"
ns.textures[11] = "Interface\\AddOns\\HandyNotes_ChildrensWeek\\CupCakePink"
ns.textures[12] = "Interface\\AddOns\\HandyNotes_ChildrensWeek\\CupCakeWhite"
ns.textures[13] = "Interface\\AddOns\\HandyNotes_ChildrensWeek\\IcecreamCone"
ns.textures[14] = "Interface\\AddOns\\HandyNotes_ChildrensWeek\\ToyTrain"
ns.textures[15] = "Interface\\AddOns\\HandyNotes_ChildrensWeek\\TeddyBrown"
ns.textures[16] = "Interface\\AddOns\\HandyNotes_ChildrensWeek\\TeddyDarkBlue"
ns.textures[17] = "Interface\\AddOns\\HandyNotes_ChildrensWeek\\TeddyLightBlue"
ns.textures[18] = "Interface\\AddOns\\HandyNotes_ChildrensWeek\\TeddyLightGreen"

ns.scaling[1] = 0.55
ns.scaling[2] = 0.55
ns.scaling[3] = 0.55
ns.scaling[4] = 0.55
ns.scaling[5] = 0.55
ns.scaling[6] = 0.55
ns.scaling[7] = 0.65
ns.scaling[8] = 0.62
ns.scaling[9] = 0.75
ns.scaling[10] = 0.75
ns.scaling[11] = 0.45
ns.scaling[12] = 0.45
ns.scaling[13] = 0.45
ns.scaling[14] = 0.45
ns.scaling[15] = 0.45
ns.scaling[16] = 0.45
ns.scaling[17] = 0.45
ns.scaling[18] = 0.45
