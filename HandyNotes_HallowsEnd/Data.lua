local _, ns = ...
ns.points = {}
ns.achievementIQ = {}
ns.addOnName = "HallowsEnd" -- For internal use to name globals etc. Should never be localised
ns.eventName = "Hallow's End" -- The player sees this in labels and titles. This gets localised

ns.aoa = {}
--ns.aoa[ 1034 ] = { acctOnly = true }

-- Achievements:
-- Saviour of Hallow's End					289		Both		fires
-- Tricks and Treats of Kalimdor			963		Alliance	candy
-- Tricks and Treats of Kalimdor			965		Horde		candy
-- Tricks and Treats of Eastern Kingdoms	966		Alliance	candy
-- Tricks and Treats of Eastern Kingdoms	967		Horde		candy
-- Tricks and Treats of Outland				969		Alliance	candy
-- Tricks and Treats of Outland				968		Horde		candy
-- Tricks and Treats of Northrend			5836	Alliance	candy
-- Tricks and Treats of Northrend			5835	Horde		candy
-- Tricks and Treats of the Cataclysm		5837	Alliance	candy
-- Tricks and Treats of the Cataclysm		5838	Horde		candy
-- Tricks and Treats of Pandaria			7601	Alliance	candy
-- Tricks and Treats of Pandaria			7602	Horde		candy
-- Tricks and Treats of the Dragon Isles	18360	Both		candy
-- Rotten Hallow							1040	Alliance	rotten
-- Rotten Hallow							1041	Horde		rotten

ns.setKal = { pumpkin=true, noCoords=true, alwaysShow=true, noContinent=true,
			achievements={ { id=963, version=30002, faction="Alliance", showAllCriteria=true, },
			{ id=965, version=30002, faction="Horde", showAllCriteria=true, },
			{ id=283, version=30002, showAllCriteria=true, }, { id=289, version=30002, }, { id=972, version=30002, }, }, }
ns.setMeta = { candy=true, noCoords=true, alwaysShow=true, noContinent=true,
			achievements={ { id=1656, version=30002, showAllCriteria=true, },
			{ id=971, version=30002, showAllCriteria=true, }, { id=40862, version=110002, showAllCriteria=true, }, }, }
ns.setDragon = { ghost=true, noCoords=true, alwaysShow=true, noContinent=true,
			achievements={ { id=18360, version=100105, showAllCriteria=true, },
			{ id=18962, version=100107, }, { id=18959, version=100107, }, { id=18960, version=100107, }, }, }
ns.setFlavour = { witch=true, noCoords=true, alwaysShow=true, noContinent=true,
			achievements={ { id=979, version=30000, showAllCriteria=true, }, { id=284, version=30000, }, },
			guide="\nWickerman Festival", 
			tip="When the decorations of Hallow's End light up Azeroth's cities, you know there's mischief afoot! Seek special "
			.."vendors in Orgrimmar or Ironforge and get your hands on treats! Aid a sick orphan in a little trick-or-treating! "
			.."Darkcaller Yanka, attending the Forsaken's Wickerman Festival, and Sergeant Hartman of Southshore are seeking your "
			.."aid in keeping the enemy out of their holiday affairs - are you up to the challenge?\n\n((Blizzard Patch 1.8.0 "
			.."Notes, 10/10/05))\n\nCentral to the original event was the Wickerman Festival. The Forsaken of Lordaeron would "
			.."burn a giant Wickerman on the embankment at the side of the Ruins, on the road to Silverpine. At 19:30, 19:45 and "
			.."19:55, Darkcaller Yanka would announce the burning ceremony. Come 20:00, the Banshee Queen herself, Sylvannas "
			.."Windrunner, would deliver a powerful speech:\n\n" ..ns.colour.seasonal .."Children of the Night, heed your Queen's "
			.."call! I join you in celebration of this most revered of nights - the night we Forsaken broke the Scourge's yoke of "
			.."oppression! It is this night that our enemies fear us the most. It is THIS night that we show our enemies what it "
			.."means to stand against the Forsaken! We burn the effigy of the Wickerman as a symbol of our struggle against those "
			.."who would oppose us. We wear the ashes of the burnt Wickerman as a symbol of our neverending fight against those "
			.."who would enslave us. Now is the time to shake the world to its foundations! NOW is the time to remind those who "
			.."would enslave us that we shall never yield! NOW is the time of the Forsaken! Power to the Forsaken - NOW AND "
			.."FOREVER!!!", }
ns.setEasternK = { bat=true, noCoords=true, alwaysShow=true, noContinent=true,
			achievements={ { id=966, version=30002, faction="Alliance", showAllCriteria=true, },
			{ id=967, version=30002, faction="Horde", showAllCriteria=true, },
			{ id=291, version=30002, showAllCriteria=true, }, { id=292, version=30002, showAllCriteria=true, },
			{ id=10365, version=60200, }, }, }
ns.setOutNorth = { cat=true, noCoords=true, alwaysShow=true, noContinent=true,
			achievements={ { id=969, version=30002, faction="Alliance", showAllCriteria=true, },
			{ id=968, version=30002, faction="Horde", showAllCriteria=true, },
			{ id=5836, version=40200, faction="Alliance", showAllCriteria=true, },
			{ id=5835, version=40200, faction="Horde", showAllCriteria=true, },
			{ id=1040, version=30002, faction="Alliance", showAllCriteria=true, },
			{ id=1041, version=30002, faction="Horde", showAllCriteria=true, },
			{ id=1261, version=30002, }, }, }
ns.setCataPand = { evilP=true, noCoords=true, alwaysShow=true, noContinent=true,
			achievements={ { id=5837, version=40200, faction="Alliance", showAllCriteria=true, },
			{ id=5838, version=40200, faction="Horde", showAllCriteria=true, },
			{ id=7601, version=50004, faction="Alliance", showAllCriteria=true, },
			{ id=7602, version=50004, faction="Horde", showAllCriteria=true, },
			{ id=288, version=30002, }, { id=981, version=30002, }, }, }

-- Candy		Pumpkin		Bat			Cat			Evil P		Ghost		Witch		
-- Meta 10 		Kal 30	 	EK 26 		Out 14	 	Cata 14, 	Drag 36		Mask 24
-- Azer 3		Masq 7		Check 12	North 22	Panda 22,	S1 x 3		S1 x 1
-- Khaz 18		S1 x 2		Sin 2		Rott 4		S1 x 2					Flavour
-- 41+12=53		39+16=55	S1 x 1		S1 x 1		38+16=54	39+16=55	37+?
--							41+16=57	41+16=57
--				S1 Saviour							S1 Out		S1 Cleanse	S1 Mask
--				S1 TorT		S1 Pepe		S1 Gnerd	S1 Sparkle	S1 Don't					
--																S1 Kickin
															
ns.practice = "Fire Brigade Practice"
ns.training = "Fire Training"
ns.letFiresCome = "The idea is to form a large \"bucket brigade\" but that'd need an organised pug which of course will never "
			.."happen.\n\nAlliance: Goldshire is best. Horde: Razor Hill, sometimes Brill.\n\nYou'll eventually notice patterns. "
			.."2 or 3 buildings alight. Fire starts on the top of the roof then spreads to the eaves. You'll notice players focus "
			.."on the lower, smaller blazes. Smart you focuses on the source at the very top. When a building has been "
			.."extinguished, be ready with a bucket for it to be ignited again. Camp it.\n\nSolo: Alliance Azure Watch is doable, "
			.."Horde try Falconwing Square. The mechanics are a bit more lenient as there are fewer players expected and flying is "
			.."not possible! Focus on one building and get it extinguished then move to the next but always check for reignition of "
			.."a previous building. Don't try if the event has already started and there's nobody there. The wait is about 5 "
			.."minutes - standby with a bucket. A nice quick start is the key.\n\nHorde, if lucking out then go pickup and complete "
			.."your Stormwind dousing daily. Logout then relog. You'll now be in Elwynn. Fly to Goldshire nearby and hover above. "
			.."You'll get credit. Alliance can try Brill but it's often very quiet there.\n\nFinally, the Shade of the Horseman is "
			.."dismounted. Allow the guards to do almost all of the work. If soloing, strafe and kite in a circle to buy time for "
			.."the guards to quickly respawn.\n\nThe seasonal \"Fire Brigade Practice\" may be completed anywhere and solo. The "
			.."bucket daily names are a bit confusing. If the event is already underway you'll be given \"Stop the Fires!\" but if "
			.."it's not then you'll receive \"Let the Fires Come!\", it's as simple as that. Either counts for the achievement.\n\n"
			.."The Pumpkin daily occurs after the Headless Horseman has been defeated. A large Jack-o'-Lantern will spawn in the "
			.."town. If you arrive and the pumpkin is already there then lucky you but be quick as it will despawn after a minute." .."\n\nI leave my Alliance alts in the Goldshire inn, ready to ninja (assuming I get the same phase)!"
ns.fireQSet = { { id=11440, name=ns.practice, faction="Alliance", qType="Seasonal", tip="Azuremyst", },
					{ id=11360, name=ns.practice, faction="Alliance", qType="Seasonal", tip="Goldshire", },
					{ id=11439, name=ns.practice, faction="Alliance", qType="Seasonal", tip="Kharanos", },
					{ id=11449, name=ns.training, faction="Horde", qType="Seasonal", tip="Brill", },
					{ id=11450, name=ns.training, faction="Horde", qType="Seasonal", tip="Falconwing Square", },
					{ id=11361, name=ns.training, faction="Horde", qType="Seasonal", tip="Razor Hill", },
					{ id=12135, name="Let the Fires Come!", faction="Alliance", qType="Daily", },
					{ id=12139, name="Let the Fires Come!", faction="Horde", qType="Daily", },
					{ id=11131, name="Stop the Fires!", faction="Alliance", qType="Daily", },
					{ id=11219, name="Stop the Fires!", faction="Horde", qType="Daily", },
					{ id=12133, name="Smash the Pumpkin", faction="Alliance", qType="Daily", },
					{ id=12155, name="Smash the Pumpkin", faction="Horde", qType="Daily", }, }
-- Dun Morogh has it's own as the coordinates are too different between Cata and pre-Cata
ns.fireSetA = { fires=true, version=30000, faction="Alliance", achievements={ { id=289, }, }, quests=ns.fireQSet,
			guide=ns.letFiresCome, }
ns.fireSetH = { fires=true, version=30000, faction="Horde", achievements={ { id=289, }, }, quests=ns.fireQSet,
			guide=ns.letFiresCome, }

ns.aeriePeak = "The lowest level hillside building of Aerie Peak"
ns.astranaar = "Your quest phase does not matter - the bucket is always available"
ns.cataclysmPortals = "Through this portal for the Temple of the Earth (Deepholm) candy bucket. Convenient portals for Nordrassil, "
			.."Ramkahen, Twilight Highlands, and Vashj'ir are available too!"
ns.cenarion = "In the Oasis inn, below the Flight Masters of Cenarion Hold"
ns.cleanup = "To see the orange plumes you must have \"Particle Density\" at least minimally enabled. Go to "
			.."System->Graphics->Effects. If you get debuffed then you may cleanse yourself. Shapeshifting also works"
ns.cleanUpA = "Pickup the quest from Gretchen Fenlow who is just outside the Stormwind gates. " ..ns.cleanup
ns.cleanUpH = "Pickup the quest from Candace Fenlow. " ..ns.cleanup
ns.falconwing = "Go through the blue doorway of Falconwing Square"
ns.goEast = "Brill is a great location to set your hearth for Hallows End. There is a portal/zeppelin tower nearby. Quick access "
			.."to Grom'gol to commence an efficient circuit of Eastern Kingdoms, beginning with Grom'gol.\n\nThe key is to return "
			.."to Brill via The Hinterlands and Silverpine Forest, completely missing The Bulwark (no bucket prior to Cataclysm)." .."\n\nThen, from Brill go to The Bulwark and finish at Light's Hope Chapel where you get a taxi to Tranquillien. You "
			.."will proced to Silvermoon city via Falconwing Square. From there take the Orb of Translocation back to the Ruins of "
			.."Lordaeron"
ns.ironSummit = "Outside, high up on a perimiter ledge of the Iron Summit"
ns.jeeda = "Alchemy completionists will want the Fire Protection Potion from Jeeda, upstairs at Sun Rock Retreat. Goodluck!"
ns.lowerRise = "Inside \"The Cat and the Shaman\" inn, Lower Rise"
ns.mudsprocket = "Upstairs, inside the main hut at Mudsprocket"
ns.practice = "This quest is just solo practice for the daily\n\"extinguishing\" quest in the same area"
ns.raptorHatchling = "My \"Adorable Raptor Hatchlings\" AddOn will assist in collecting several adorable and cute baby raptor "
			.."pets! There's one nearby but you need to know the spawn locations. No battling/fighting. Go plunder the nest you "
			.."heartless collector!"
ns.royalExchange = "In the Silvermoon City Inn, The Royal Exchange"
ns.stinkBombsA = "You will ride on a broomstick taxi from Gertrude Fenlow. You'll do a \"bombing run\", with a vehicle interface, "
			.."through the Undercity!\n\nSoon after completion, and while still in the Undercity, you could consider logging out. "
			.."You will respawn at the Scarlet Watchtower in Tirisfal Glades, right at the sewer enrance/exit of The Undercity.\n\n"
			.."This will save a ton of time if you also intend doing \"A Time to Lose\" in the Ruins of Lordaeron!"
ns.stinkBombsH = "You will ride on a broomstick taxi from Crina Fenlow. You'll do a \"bombing run\", with a vehicle interface, "
			.."through Stormwind!\n\nSoon after completion, and while still in Stormwind, you could consider logging out. You'll "
			.."respawn at the Eastvale Logging Camp graveyard, at the far east of Elwynn Forest.\n\nThis will save a ton of time if "
			.."you also intend doing \"A Time to Lose\" at the Stormwind front gate!"
ns.stinkBombsLogoutA = "If you logout immediately after completion and while still in the Undercity then when you login you will "
			.."respawn near here. Perfect for \"A Time to Lose\"!"
ns.stinkBombsLogoutH = "If you logout immediately after completion and while still in Stormwind then when you login you will "
			.."respawn here. Perfect for \"A Time to Break Down\"!"
ns.taraezorTip = "Exclusive Taraezor tip! Pause to check your map while you are inside an inn near/with a candy bucket.\n\nYou "
			.."want to stretch that rested bonus for as long as possible!"
ns.taxi = "Use a taxi between Light's Hope Chapel and Tranquillien. For all of Ghostlands, Eversong Woods, Falconwing Square and "
			.."Silvermoon City there is no flying. By far the best strategy is to commence from Light's Hope Chapel. Proceed then "
			.."to Tranquillien etc, using taxis always. Saving Silvermoon City for last you may exit from there back to the Ruins "
			.."of Lordaeron via a portal from the Orb of Translocation, in a room behind Lor'themar Theron's chambers"
ns.theBazaar = "In the Wayfarer's Rest inn of The Bazaar"
ns.theTradeQuarter = "The Trade Quarter in the Undercity, which is below the Ruins of Lordaeron"
ns.timeDouse = "\n\nDo NOT try to target the Wickerman. Stand near it and click on your Dousing Agent. Immediately mount and hit "
			.."\"space\" to fly straight up. Find somewhere safe to hearth or else do nearby Candy Buckets"
ns.timeBreakDown1 = "Ideally, just as you finish your \"Stink Bombs Away!\" bombing run daily, you should immediately logout. "
			.."Relogging places you at the Eastvale Logging Camp at the far east of Elwynn Forest.\n\n Approach from due east. Use "
			.."the large tree and the ledge as cover. Stay away from the wall to avoid zoning out and adding to phasing problems. "
			.."\n\nReports suggest activating Warmode will help but that might be troll suggestion too." ..ns.timeDouse			
ns.timeBreakDown2 = "You will douse a Wickerman in front of the main gate into Stormwind. Pickup the quest here from Darkcaller "
			.."Yanks.\n\n" ..ns.timeBreakDown1
ns.timeToLose1 = "Ideally, just as you finish your \"Stink Bombs Away!\" bombing run daily, you should immediately logout. "
			.."Relogging places you nearby the Ruins of Lordaeron, at the sewer entrance/exit.\n\nTake extra care as you have no "
			.."ground cover. Hover far above then suddenly swoop down amd land on the narrow embankment near the bright green moat "
			.."and on the southern side of the wickerman. Hug the wall. There is a pat above this ledge but you'll be out of line "
			.."of sight." ..ns.timeDouse
ns.timeToLose2 = "You will douse a Wickerman in the Ruins of Lordaeron. Pickup the quest here from Keira.\n\n" ..ns.timeToLose1
ns.uldumPromo = "Within both the Cataclysm and current phases there's the opportunity to snare cool mounts. Please see my "
			.."\"Springfur Alpaca\" and \"Mysterious Camel Figurine\" AddOns!"

--==================================================================================================================================
--
-- KALIMDOR
--
--==================================================================================================================================

ns.points[ ns.map.ashenvale ] = { -- Ashenvale
	[02216659] = { candy=true, version=40000, faction="Alliance", achievements={ { id=963, index=21, version=60000, },
					{ id=963, index=27, versionUnder=60000, }, },
					quests={ { id=29012, qType="Seasonal", }, }, tip="Thal'darah Overlook", },
	[13003410] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=4, version=60000, }, 
					{ id=965, index=21, versionUnder=60000, }, },
					quests={ { id=28989, qType="Seasonal", }, }, tip="Zoram'gar Outpost", },
	[13369829] = { candy=true, version=40000, faction="Horde",
					achievements={ { id=965, index=25, version=60000, }, { id=965, index=9, versionUnder=60000, }, },
					quests={ { id=12378, qType="Seasonal", }, }, tip=ns.jeeda, },
	[22229064] = { candy=true, version=40000, faction="Alliance", achievements={ { id=963, index=22, version=60000, }, },
					quests={ { id=29011, qType="Seasonal", }, }, tip="Fallowmere Inn, Windshear Hold", },
	[29859870] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=24, version=60000, },
					{ id=965, index=22, versionUnder=60000, }, },
					quests={ { id=29009, qType="Seasonal", }, }, tip="Inside the smallest building, Krom'gar Fortress", },
	[37014926] = { candy=true, faction="Alliance", achievements={ { id=963, index=1, version=60000, }, -- or 7 or 11
					{ id=963, index=4, version=40000, versionUnder=60000, }, { id=963, index=6, versionUnder=40000, }, },
					quests={ { id=12345, qType="Seasonal", }, }, tip=ns.astranaar, },
	[38654234] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=1, version=60000, }, 
					{ id=965, index=28, versionUnder=60000, }, },
					quests={ { id=28958, qType="Seasonal", }, }, tip="Hellscream's Watch", },
	[50256727] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=2, version=60000, },
					{ id=965, index=30, versionUnder=60000, }, },
					quests={ { id=28953, qType="Seasonal", }, }, tip="Silverwind Refuge", },
	[73966060] = { candy=true, faction="Horde", achievements={ { id=965, index=3, version=60000, },
					{ id=965, index=5, version=40000, versionUnder=60000, }, -- or 4 or 7
					{ id=965, index=6, versionUnder=40000, }, }, quests={ { id=12377, qType="Seasonal", }, },
					tip="Follow the map pin for the correct building in Splintertree Post", },
	[88269101] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=18, version=60000, },
					{ id=965, index=24, versionUnder=60000, }, },
					quests={ { id=29003, qType="Seasonal", }, }, tip="Nozzlepot's Outpost", },
}

ns.points[ ns.map.azshara ] = { -- Azshara
	[57115017] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=5, version=60000, }, 
					{ id=965, index=25, versionUnder=60000, }, },
					quests={ { id=28992, qType="Seasonal", }, }, guide=ns.taraezorTip, tip="Bilgewater Harbor", },
}

ns.points[ ns.map.azuremyst ] = { -- Azuremyst Isle
	[29293485] = { candy=true, faction="Alliance", achievements={ { id=963, index=9, version=60000, }, -- or 4, 10
					{ id=963, index=5, version=40000, versionUnder=60000, }, { id=963, index=7, versionUnder=40000, }, },
					quests={ { id=12337, qType="Seasonal", }, }, tip="Seat of the Naaru, in the Exodar", },
	[48494905] = { candy=true, faction="Alliance", achievements={ { id=963, index=2, version=60000, },
					{ id=963, index=7, version=40000, versionUnder=60000, }, { id=963, index=2, versionUnder=40000, }, }, -- 3, 8 
					quests={ { id=12333, qType="Seasonal", }, }, tip="Azure Watch", },
	[49205140] = ns.fireSetA,
}

ns.points[ ns.map.bloodmyst ] = { -- Bloodmyst Isle
	[55695997] = { candy=true, faction="Alliance", achievements={ { id=963, index=3, version=40000, },
					{ id=963, index=5, versionUnder=40000, }, },
					quests={ { id=12341, qType="Seasonal", }, }, tip="Blood Watch", }, -- 5 or 12
}

ns.points[ ns.map.darkshore ] = { -- Darkshore
	[37004410] = { candy=true, versionUnder=40000, faction="Alliance", achievements={ { id=963, index=1, }, }, 
					quests={ { id=12338, qType="Seasonal", }, }, guide=ns.taraezorTip, tip="Auberdine", }, -- 6 or 16
	[50791890] = { candy=true, version=40000, faction="Alliance", achievements={ { id=963, index=4, version=60000, },
					{ id=963, index=28, versionUnder=60000, }, },
					quests={ { id=28951, qType="Seasonal", }, }, guide=ns.taraezorTip, tip="Lor'danel", },
	[60665005] = { candy=true, version=40000, achievements={ { id=963, index=11, faction="Alliance", version=60000, },
					{ id=963, index=25, faction="Alliance", versionUnder=60000, },
					{ id=965, index=11, faction="Horde", version=60000, },
					{ id=965, index=19, faction="Horde", versionUnder=60000, }, },
					quests={ { id=28994, qType="Seasonal", }, }, noZidormi=true, tip="Whisperwind Grove", },
	[73277154] = { candy=true, version=40000, achievements={ { id=5837, index=2, faction="Alliance", },
					{ id=5838, index=2, faction="Horde", }, },
					quests={ { id=29000, qType="Seasonal", }, }, noZidormi=true, tip="Grove of Aessina", },
	[76874791] = { candy=true, version=40000, faction="Alliance",
					achievements={ { id=963, index=10, version=60000, }, { id=963, index=24, versionUnder=60000, }, },
					quests={ { id=28995, qType="Seasonal", }, }, noZidormi=true, tip="Talonbranch Glade", },
	[89077706] = { candy=true, version=40000, achievements={ { id=5837, index=4, faction="Alliance", version=60000, },
					{ id=5837, index=13, faction="Alliance", versionUnder=60000, },
					{ id=5838, index=4, faction="Horde", version=60000, },
					{ id=5838, index=1, faction="Horde", versionUnder=60000, }, },
					quests={ { id=29001, qType="Seasonal", }, }, noZidormi=true, tip="Shrine of Aviana", },
}

ns.points[ ns.map.darnassus ] = { -- Darnassus
	[62283315] = { candy=true, version=40000, faction="Alliance", achievements={ { id=963, index=5, version=60000, }, 
					{ id=963, index=14, versionUnder=60000, }, },
					quests={ { id=12334, qType="Seasonal", }, }, tip="Craftsmen's Terrace", },
	[67401560] = { candy=true, versionUnder=40000, faction="Alliance", achievements={ { id=963, index=16, }, }, -- or 2 or 1
					quests={ { id=12334, qType="Seasonal", }, }, tip="Craftsmen's Terrace", },
}

ns.points[ ns.map.desolace ] = { -- Desolace
	[24076829] = { candy=true, faction="Horde", achievements={ { id=965, index=7, version=60000, }, -- 15 or 4
					{ id=965, index=2, version=40000, versionUnder=60000, }, { id=965, index=3, versionUnder=40000, }, },
					quests={ { id=12381, qType="Seasonal", }, }, tip="Shadowprey Village", },
	[56725012] = { candy=true, version=40000, achievements={ { id=963, index=6, faction="Alliance", version=60000, }, 
					{ id=963, index=26, faction="Alliance", versionUnder=60000, },
					{ id=965, index=6, faction="Horde", version=60000, },
					{ id=965, index=20, faction="Horde", versionUnder=60000, }, },
					quests={ { id=28993, qType="Seasonal", }, }, tip="Karnum's Glade", },
	[66330659] = { candy=true, faction="Alliance", achievements={ { id=963, index=7, version=60000, }, -- 10, 14
					{ id=963, index=1, version=40000, versionUnder=60000, }, { id=963, index=3, versionUnder=40000, }, },
					quests={ { id=12348, qType="Seasonal", }, }, tip="Nigel's Point", },					
	[93265850] = { candy=true, faction="Horde", achievements={ { id=965, index=28, version=60000, },
					{ id=965, index=15, version=40000, versionUnder=60000, }, { id=965, index=17, versionUnder=40000, }, },
					quests={ { id=12367, qType="Seasonal", }, }, tip=ns.lowerRise, }, -- or 16, 10
}

ns.points[ ns.map.durotar ] = { -- Durotar
--	[52604120] = ns.fireSetH,	
	[12876288] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=16, version=60000, },
					{ id=965, index=11, versionUnder=60000, }, },
					quests={ { id=12374, qType="Seasonal", }, }, tip="The Crossroads", },
	[52002990] = { candy=true, versionUnder=40000, faction="Horde", achievements={ { id=965, index=12, }, },
					quests={ { id=12374, qType="Seasonal", }, }, tip="The Crossroads", }, -- or 6, 13
	[20144344] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=17, version=60000, },
					{ id=965, index=29, versionUnder=60000, }, },
					quests={ { id=29002, qType="Seasonal", }, }, tip="Grol'dom Farm", },
	[26991798] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=18, version=60000, },
					{ id=965, index=24, versionUnder=60000, }, },
					quests={ { id=29003, qType="Seasonal", }, }, tip="Nozzlepot's Outpost", },
	[32248109] = { candy=true, version=40000, achievements={ { id=963, index=14, faction="Alliance", version=60000, },
					{ id=963, index=10, faction="Alliance", versionUnder=60000, },
					{ id=965, index=19, faction="Horde", version=60000, },
					{ id=965, index=7, faction="Horde", versionUnder=60000, }, },
					quests={ { id=12396, qType="Seasonal", }, }, tip="Ratchet\n\n" ..ns.raptorHatchling, },
	[46940672] = { candy=true, faction="Horde", achievements={ { id=965, index=20, version=60000, },
					{ id=965, index=1, version=40000, versionUnder=60000, },
					{ id=965, index=2, versionUnder=40000, }, }, -- or 1, 3
					quests={ { id=12366, qType="Seasonal", }, }, tip="Valley of Strength", },
	[51544158] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=8, }, },
					quests={ { id=12361, qType="Seasonal", }, }, tip="Razor Hill", },
	[51604170] = { candy=true, versionUnder=40000, faction="Horde", achievements={ { id=965, index=9, }, }, -- or 2, 1
					quests={ { id=12361, qType="Seasonal", }, }, tip="Razor Hill", },
}

ns.points[ ns.map.dustwallow ] = { -- Dustwallow Marsh
	[13073393] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=22, version=60000, },
					{ id=965, index=23, versionUnder=60000, }, noZidormi=true, },
					quests={ { id=29005, qType="Seasonal", }, }, tip="Desolation Hold", },
	[24843279] = { candy=true, version=40000, faction="Alliance", achievements={ { id=963, index=16, version=60000, }, 
					{ id=963, index=22, versionUnder=60000, }, },
					quests={ { id=29008, qType="Seasonal", }, }, noZidormi=true, tip="Fort Triumph", },
	[36783244] = { candy=true, faction="Horde", achievements={ { id=965, index=9, version=60000, },
					{ id=965, index=10, version=40000, versionUnder=60000, }, { id=965, index=11, versionUnder=40000, }, },
					quests={ { id=12383, qType="Seasonal", }, }, noZidormi=true, tip="Brackenwall Village", }, -- or 9, 12
	[41867409] = { candy=true, achievements={ { id=963, index=8, faction="Alliance", version=60000, },
					{ id=963, index=2, faction="Alliance", version=40000, versionUnder=60000, },
					{ id=963, index=4, faction="Alliance", versionUnder=40000, }, -- or 13, 13
					{ id=965, index=10, faction="Horde", version=60000, },
					{ id=965, index=14, faction="Horde", version=40000, versionUnder=60000, }, 
					{ id=965, index=16, faction="Horde", versionUnder=40000, }, }, -- or 10, 17
					quests={ { id=12398, qType="Seasonal", }, }, noZidormi=true, tip=ns.mudsprocket, },
	[48220178] = { candy=true, version=40000, faction="Alliance", achievements={ { id=963, index=18, version=60000, },
					{ id=963, index=20, versionUnder=60000, }, },
					quests={ { id=29007, qType="Seasonal", }, }, noZidormi=true, tip="Northwatch Hold", },
	[66604528] = { candy=true, faction="Alliance", -- or 12, 2
					achievements={ { id=963, index=13, version=40000, }, { id=963, index=15, versionUnder=40000, }, },
					quests={ { id=12349, qType="Seasonal", }, }, tip="Inside the inn, Theramore Isle", },
}

ns.points[ ns.map.felwood ] = { -- Felwood
	[13989589] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=4, version=60000, }, 
					{ id=965, index=21, versionUnder=60000, }, },
					quests={ { id=28989, qType="Seasonal", }, }, tip="Zoram'gar Outpost", },
	[44582899] = { candy=true, version=40000, achievements={ { id=963, index=11, faction="Alliance", version=60000, },
					{ id=963, index=25, faction="Alliance", versionUnder=60000, },
					{ id=965, index=11, faction="Horde", version=60000, },
					{ id=965, index=19, faction="Horde", versionUnder=60000, }, },
					quests={ { id=28994, qType="Seasonal", }, }, tip="Whisperwind Grove", },
	[58035192] = { candy=true, version=40000, achievements={ { id=5837, index=2, faction="Alliance", },
					{ id=5838, index=2, faction="Horde", }, },
					quests={ { id=29000, qType="Seasonal", }, }, tip="Grove of Aessina", },
	[61862671] = { candy=true, version=40000, faction="Alliance",
					achievements={ { id=963, index=10, version=60000, }, { id=963, index=24, versionUnder=60000, }, },
					quests={ { id=28995, qType="Seasonal", }, }, tip="Talonbranch Glade", }, 
	[74875780] = { candy=true, version=40000, achievements={ { id=5837, index=4, faction="Alliance", version=60000, },
					{ id=5837, index=13, faction="Alliance", versionUnder=60000, },
					{ id=5838, index=4, faction="Horde", version=60000, },
					{ id=5838, index=1, faction="Horde", versionUnder=60000, }, },
					quests={ { id=29001, qType="Seasonal", }, }, tip="Shrine of Aviana", },
	[89144269] = { candy=true, version=40000, achievements={ { id=5837, index=3, faction="Alliance", version=60000, },
					{ id=5837, index=10, faction="Alliance", versionUnder=60000, },
					{ id=5838, index=3, faction="Horde", version=60000, },
					{ id=5838, index=12, faction="Horde", versionUnder=60000, }, },
					quests={ { id=28999, qType="Seasonal", }, }, tip="Nordrassil", },
}

ns.points[ ns.map.feralas ] = { -- Feralas
	[30904340] = { candy=true, versionUnder=40000, faction="Alliance", -- or 15, 3
					achievements={ { id=963, index=14, }, },
					quests={ { id=12350, qType="Seasonal", }, }, tip="Feathemoon Stronghold", },
	[41451568] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=12, version=60000, },
					{ id=965, index=27, versionUnder=60000, }, },
					quests={ { id=28996, qType="Seasonal", }, }, tip="Camp Ataya", },
	[46334519] = { candy=true, version=40000, faction="Alliance", achievements={ { id=963, index=13, version=60000, },
					{ id=963, index=12, versionUnder=60000, }, },
					quests={ { id=12350, qType="Seasonal", }, }, tip="Feathemoon Stronghold", },
	[51071781] = { candy=true, version=40000, faction="Alliance", achievements={ { id=963, index=12, version=60000, },
					{ id=963, index=23, versionUnder=60000, }, },
					quests={ { id=28952, qType="Seasonal", }, }, tip="Dreamer's Rest", },
	[51974764] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=14, version=60000, },
					{ id=965, index=26, versionUnder=60000, }, },
					quests={ { id=28998, qType="Seasonal", }, }, tip="Stonemaul Hold", },
	[67769716] = { candy=true, version=40000, achievements={ { id=963, index=15, faction="Alliance", version=60000, },
					{ id=963, index=9, faction="Alliance", versionUnder=60000, },
					{ id=965, index=21, faction="Horde", version=60000, },
					{ id=965, index=3, faction="Horde", versionUnder=60000, }, },
					quests={ { id=12401, qType="Seasonal", }, }, tip=ns.cenarion, },
	[74834514] = { candy=true, faction="Horde", achievements={ { id=965, index=13, version=60000, }, -- or 14, 6
					{ id=965, index=4, version=40000, versionUnder=60000, }, { id=965, index=5, versionUnder=40000, }, },
					quests={ { id=12386, qType="Seasonal", }, }, tip="Camp Mojache", },
	[83270000] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=15, version=60000, }, 
					{ id=965, index=6, versionUnder=60000, }, },
					quests={ { id=12362, qType="Seasonal", }, }, tip="Bloodhoof Village", },
}

ns.points[ ns.map.mulgore ] = { -- Mulgore
	[05738321] = { candy=true, version=40000, faction="Alliance", achievements={ { id=963, index=12, version=60000, },
					{ id=963, index=23, versionUnder=60000, }, },
					quests={ { id=28952, qType="Seasonal", }, }, tip="Dreamer's Rest", },
	[09562427] = { candy=true, version=40000, achievements={ { id=963, index=6, faction="Alliance", version=60000, }, 
					{ id=963, index=26, faction="Alliance", versionUnder=60000, },
					{ id=965, index=6, faction="Horde", version=60000, },
					{ id=965, index=20, faction="Horde", versionUnder=60000, }, },
					quests={ { id=28993, qType="Seasonal", }, }, tip="Karnum's Glade", },
	[39703118] = { candy=true, faction="Horde", achievements={ { id=965, index=28, version=60000, },
					{ id=965, index=15, version=40000, versionUnder=60000, }, { id=965, index=17, versionUnder=40000, }, },
					quests={ { id=12367, qType="Seasonal", }, }, tip=ns.lowerRise, }, -- or 16, 10
	[46796041] = { candy=true, faction="Horde", achievements={ { id=965, index=15, version=60000, }, -- Or 17, 8
					{ id=965, index=6, version=40000, versionUnder=60000, }, { id=965, index=7, versionUnder=40000, }, },
					quests={ { id=12362, qType="Seasonal", }, }, tip="Bloodhoof Village", },
	[68620468] = { candy=true, version=40000, faction="Alliance", achievements={ { id=963, index=17, version=60000, },
					{ id=963, index=21, versionUnder=60000, }, },
					quests={ { id=29006, qType="Seasonal", }, }, tip="Honor's Stand", },
	[69001706] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=23, version=60000, }, 
					{ id=965, index=6, versionUnder=60000, }, },
					quests={ { id=29004, qType="Seasonal", }, }, tip="Hunter's Hill", },
	[70928401] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=22, version=60000, },
					{ id=965, index=23, versionUnder=60000, }, },
					quests={ { id=29005, qType="Seasonal", }, }, tip="Desolation Hold", },
	[82268291] = { candy=true, version=40000, faction="Alliance", achievements={ { id=963, index=16, version=60000, }, 
					{ id=963, index=22, versionUnder=60000, }, },
					quests={ { id=29008, qType="Seasonal", }, }, tip="Fort Triumph", },
	[88940659] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=16, version=60000, },
					{ id=965, index=11, versionUnder=60000, }, },
					quests={ { id=12374, qType="Seasonal", }, }, tip="The Crossroads", },
	[93768257] = { candy=true, faction="Horde", achievements={ { id=965, index=9, version=60000, },
					{ id=965, index=10, version=40000, versionUnder=60000, }, { id=965, index=11, versionUnder=40000, }, },
					quests={ { id=12383, qType="Seasonal", }, }, tip="Brackenwall Village", }, -- or 9, 12
}

ns.points[ ns.map.barrens ] = { -- Northern Barrens (Retail) / The Barrens (Classic Cata)
	[02818123] = { candy=true, faction="Horde", achievements={ { id=965, index=28, version=60000, },
					{ id=965, index=15, version=40000, versionUnder=60000, },
					{ id=965, index=17, versionUnder=40000, }, }, -- or 16, 10
					quests={ { id=12367, qType="Seasonal", }, }, tip=ns.lowerRise, },
	[03892430] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=24, version=60000, },
					{ id=965, index=22, versionUnder=60000, }, },
					quests={ { id=29009, qType="Seasonal", }, }, tip="Inside the smallest building, Krom'gar Fortress", },
	[08533959] = { candy=true, version=40000, faction="Alliance", achievements={ { id=963, index=20, version=60000, }, 
					{ id=963, index=18, versionUnder=60000, }, },
					quests={ { id=29010, qType="Seasonal", }, }, tip="Northwatch Expedition Base", },
	[30245610] = { candy=true, version=40000, faction="Alliance", achievements={ { id=963, index=17, version=60000, },
					{ id=963, index=21, versionUnder=60000, }, },
					quests={ { id=29006, qType="Seasonal", }, }, tip="Honor's Stand", },
	[30606784] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=23, version=60000, }, 
					{ id=965, index=6, versionUnder=60000, }, },
					quests={ { id=29004, qType="Seasonal", }, }, tip="Hunter's Hill", },
	[45605900] = { candy=true, versionUnder=40000, faction="Horde", achievements={ { id=965, index=13, }, },
					quests={ { id=12375, qType="Seasonal", }, }, tip="Camp Taurajo", }, -- Or 8, 14
	[49515791] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=16, version=60000, },
					{ id=965, index=11, versionUnder=60000, }, },
					quests={ { id=12374, qType="Seasonal", }, }, tip="The Crossroads", },
	[52002990] = { candy=true, versionUnder=40000, faction="Horde", achievements={ { id=965, index=12, }, },
					quests={ { id=12374, qType="Seasonal", }, }, tip="The Crossroads", }, -- or 6, 13
	[56214003] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=17, version=60000, },
					{ id=965, index=29, versionUnder=60000, }, },
					quests={ { id=29002, qType="Seasonal", }, }, tip="Grol'dom Farm", },
	[62103940] = { candy=true, versionUnder=40000, achievements={ { id=963, index=12, faction="Alliance", }, -- A: 11, 5
					{ id=965, index=8, faction="Horde", }, },
					quests={ { id=12396, qType="Seasonal", }, }, tip="Ratchet", },  -- or H: 7, 9
	[62511659] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=18, version=60000, },
					{ id=965, index=24, versionUnder=60000, }, },
					quests={ { id=29003, qType="Seasonal", }, }, tip="Nozzlepot's Outpost", },
	[67347466] = { candy=true, version=40000, achievements={ { id=963, index=14, faction="Alliance", version=60000, },
					{ id=963, index=10, faction="Alliance", versionUnder=60000, },
					{ id=965, index=19, faction="Horde", version=60000, },
					{ id=965, index=7, faction="Horde", versionUnder=60000, }, },
					quests={ { id=12396, qType="Seasonal", }, }, tip="Ratchet\n\n" ..ns.raptorHatchling, },
	[80870624] = { candy=true, faction="Horde", achievements={ { id=965, index=20, version=60000, },
					{ id=965, index=1, version=40000, versionUnder=60000, }, },
					quests={ { id=12366, qType="Seasonal", }, }, tip="Valley of Strength", },
	[85103831] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=8, }, },
					quests={ { id=12361, qType="Seasonal", }, }, tip="Razor Hill", },
}

ns.points[ ns.map.orgrimmar ] = { -- Orgrimmar
	[53937894] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=20, version=60000, }, 
					{ id=965, index=1, versionUnder=60000, }, },
					quests={ { id=12366, qType="Seasonal", }, }, tip="Valley of Strength", },
	[54506850] = { candy=true, versionUnder=40000, faction="Horde", achievements={ { id=965, index=2, }, }, 
					quests={ { id=12366, qType="Seasonal", }, }, tip="Valley of Strength", }, -- or 1, 3
	[50843631] = { candy=true, version=40000, faction="Horde", noContinent=true, 
					achievements={ { id=5838, index=1, version=60000, }, { id=5838, index=9, versionUnder=60000, }, },
					quests={ { id=29019, qType="Seasonal", }, }, tip="Temple of the Earth\n\n" ..ns.cataclysmPortals, },
}

ns.points[ ns.map.silithus ] = { -- Silithus
	[51803900] = { candy=true, versionUnder=40000, achievements={ { id=963, index=11, faction="Alliance", },
					{ id=965, index=4, faction="Horde", }, }, -- A: 16 or 6. H: 13 or 5
					quests={ { id=12401, qType="Seasonal", }, }, tip=ns.cenarion, },
	[53929072] = { candy=true, achievements={ { id=5837, index=9, faction="Alliance", version=60000, },
					{ id=5837, index=14, faction="Alliance", versionUnder=60000, },
					{ id=5838, index=8, faction="Horde", version=60000, },
					{ id=5838, index=10, faction="Horde", versionUnder=60000, }, },
					quests={ { id=29016, qType="Seasonal", }, }, noZidormi=true, tip="Oasis of Vir'sar\n\n" ..ns.uldumPromo, },
	[55473679] = { candy=true, version=40000, achievements={ { id=963, index=15, faction="Alliance", version=60000, },
					{ id=963, index=9, faction="Alliance", versionUnder=60000, },
					{ id=965, index=21, faction="Horde", version=60000, },
					{ id=965, index=3, faction="Horde", versionUnder=60000, }, },
					quests={ { id=12401, qType="Seasonal", }, }, tip=ns.cenarion, },
}

ns.points[ 199 ] = { -- Southern Barrens
	[15049435] = { candy=true, faction="Horde", achievements={ { id=965, index=13, version=60000, }, -- or 14, 6
					{ id=965, index=4, version=40000, versionUnder=60000, }, { id=965, index=5, versionUnder=40000, }, },
					quests={ { id=12386, qType="Seasonal", }, }, tip="Camp Mojache", },
	[17753047] = { candy=true, faction="Horde", achievements={ { id=965, index=28, version=60000, },
					{ id=965, index=15, version=40000, versionUnder=60000, }, { id=965, index=17, versionUnder=40000, }, },
					quests={ { id=12367, qType="Seasonal", }, }, tip=ns.lowerRise, }, -- or 16, 10
	[22965196] = { candy=true, faction="Horde", achievements={ { id=965, index=15, version=60000, }, -- Or 17, 8
					{ id=965, index=6, version=40000, versionUnder=60000, }, { id=965, index=7, versionUnder=40000, }, },
					quests={ { id=12362, qType="Seasonal", }, }, tip="Bloodhoof Village", },
	[39021099] = { candy=true, version=40000, faction="Alliance", achievements={ { id=963, index=17, version=60000, },
					{ id=963, index=21, versionUnder=60000, }, },
					quests={ { id=29006, qType="Seasonal", }, }, tip="Honor's Stand", },
	[39292009] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=23, version=60000, }, 
					{ id=965, index=6, versionUnder=60000, }, },
					quests={ { id=29004, qType="Seasonal", }, }, tip="Hunter's Hill", },	
	[40706932] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=22, version=60000, },
					{ id=965, index=23, versionUnder=60000, }, },
					quests={ { id=29005, qType="Seasonal", }, }, tip="Desolation Hold", },	
	[49046850] = { candy=true, version=40000, faction="Alliance", achievements={ { id=963, index=16, version=60000, }, 
					{ id=963, index=22, versionUnder=60000, }, },
					quests={ { id=29008, qType="Seasonal", }, }, tip="Fort Triumph", },
	[53951239] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=16, version=60000, },
					{ id=965, index=11, versionUnder=60000, }, },
					quests={ { id=12374, qType="Seasonal", }, }, tip="The Crossroads", },
	[57506826] = { candy=true, faction="Horde", achievements={ { id=965, index=9, version=60000, },
					{ id=965, index=10, version=40000, versionUnder=60000, }, { id=965, index=11, versionUnder=40000, }, },
					quests={ { id=12383, qType="Seasonal", }, }, tip="Brackenwall Village", }, -- or 9, 12
	[61109775] = { candy=true, achievements={ { id=963, index=8, faction="Alliance", version=60000, },
					{ id=963, index=2, faction="Alliance", version=40000, versionUnder=60000, },
					{ id=963, index=4, faction="Alliance", versionUnder=40000, }, -- or 13, 13
					{ id=965, index=10, faction="Horde", version=60000, },
					{ id=965, index=14, faction="Horde", version=40000, versionUnder=60000, }, 
					{ id=965, index=16, faction="Horde", versionUnder=40000, }, tip="Mudsprocket", }, -- or 10, 17
					quests={ { id=12398, qType="Seasonal", }, }, tip=ns.mudsprocket, },
	[65604654] = { candy=true, version=40000, faction="Alliance", achievements={ { id=963, index=18, version=60000, },
					{ id=963, index=20, versionUnder=60000, }, },
					quests={ { id=29007, qType="Seasonal", }, }, tip="Northwatch Hold", },
	[67772538] = { candy=true, version=40000, achievements={ { id=963, index=14, faction="Alliance", version=60000, },
					{ id=963, index=10, faction="Alliance", versionUnder=60000, },
					{ id=965, index=19, faction="Horde", version=60000, },
					{ id=965, index=7, faction="Horde", versionUnder=60000, }, },
					quests={ { id=12396, qType="Seasonal", }, }, tip="Ratchet\n\n" ..ns.raptorHatchling, },
	[78627735] = { candy=true, faction="Alliance", -- or 12, 2
					achievements={ { id=963, index=13, version=40000, }, { id=963, index=15, versionUnder=40000, }, },
					quests={ { id=12349, qType="Seasonal", }, }, tip="Inside the inn, Theramore Isle", },
}

ns.points[ ns.map.stonetalon ] = { -- Stonetalon Mountains
	[31536066] = { candy=true, version=40000, faction="Alliance", achievements={ { id=963, index=19, }, },
					quests={ { id=29013, qType="Seasonal", }, },
					tip="Farwatcher's Glen. Another open air Elven inn. Fly right in!", },
	[35600650] = { candy=true, versionUnder=40000, faction="Alliance", -- or 9, 15
					achievements={ { id=963, index=2, }, },
					quests={ { id=12347, qType="Seasonal", }, }, tip="Stonetalon Peak", },
	[39483281] = { candy=true, version=40000, faction="Alliance", achievements={ { id=963, index=21, version=60000, },
					{ id=963, index=27, versionUnder=60000, }, },
					quests={ { id=29012, qType="Seasonal", }, }, tip="Thal'darah Overlook", },
	[44938007] = { candy=true, faction="Alliance", achievements={ { id=963, index=7, version=60000, }, -- 10, 14
					{ id=963, index=1, version=40000, versionUnder=60000, }, { id=963, index=3, versionUnder=40000, }, },
					quests={ { id=12348, qType="Seasonal", }, }, tip="Nigel's Point", },
	[47506210] = { candy=true, versionUnder=40000, faction="Horde", -- or 5, 11
					achievements={ { id=965, index=10, }, }, quests={ { id=12378, qType="Seasonal", }, }, tip=ns.jeeda, },
	[50030107] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=4, version=60000, }, 
					{ id=965, index=21, versionUnder=60000, }, },
					quests={ { id=28989, qType="Seasonal", }, }, tip="Zoram'gar Outpost", },
	[50376379] = { candy=true, version=40000, faction="Horde",
					achievements={ { id=965, index=25, version=60000, }, { id=965, index=9, versionUnder=60000, }, },
					quests={ { id=12378, qType="Seasonal", }, }, tip=ns.jeeda, },
	[59045632] = { candy=true, version=40000, faction="Alliance", achievements={ { id=963, index=22, version=60000, }, },
					quests={ { id=29011, qType="Seasonal", }, }, tip="Fallowmere Inn at Windshear Hold", },
	[66506419] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=24, version=60000, },
					{ id=965, index=22, versionUnder=60000, }, },
					quests={ { id=29009, qType="Seasonal", }, }, tip="Inside the smallest building of Krom'gar Fortress", },
	[71027908] = { candy=true, version=40000, faction="Alliance", achievements={ { id=963, index=20, version=60000, }, 
					{ id=963, index=18, versionUnder=60000, }, },
					quests={ { id=29010, qType="Seasonal", }, }, tip="Northwatch Expedition Base", },
	[73501588] = { candy=true, faction="Alliance", achievements={ { id=963, index=1, version=60000, }, -- or 7 or 11
					{ id=963, index=4, version=40000, versionUnder=60000, }, { id=963, index=6, versionUnder=40000, }, },
					quests={ { id=12345, qType="Seasonal", }, }, tip=ns.astranaar, },
	[75100912] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=1, version=60000, }, 
					{ id=965, index=28, versionUnder=60000, }, },
					quests={ { id=28958, qType="Seasonal", }, }, tip="Hellscream's Watch", },
	[86443348] = { candy=true, version=40000, faction="Horde", achievements={ { id=965, index=2, version=60000, },
					{ id=965, index=30, versionUnder=60000, }, },
					quests={ { id=28953, qType="Seasonal", }, }, tip="Silverwind Refuge", },
	[92179516] = { candy=true, version=40000, faction="Alliance", achievements={ { id=963, index=17, version=60000, },
					{ id=963, index=21, versionUnder=60000, }, },
					quests={ { id=29006, qType="Seasonal", }, }, tip="Honor's Stand", },
}

ns.points[ ns.map.tanaris ] = { -- Tanaris
	[12247531] = { candy=true, achievements={ { id=5837, index=10, faction="Alliance", version=60000, },
					{ id=5837, index=8, faction="Alliance", versionUnder=60000, },
					{ id=5838, index=9, faction="Horde", version=60000, },
					{ id=5838, index=7, faction="Horde", versionUnder=60000, }, },
					quests={ { id=29017, qType="Seasonal", }, }, tip="Ramkahen\n\n" ..ns.uldumPromo, },
	[20093594] = { candy=true, version=40000, achievements={ { id=963, index=26, faction="Alliance", version=60000, },
					{ id=963, index=15, faction="Alliance", versionUnder=60000, },
					{ id=965, index=29, faction="Horde", version=60000, },
					{ id=965, index=16, faction="Horde", versionUnder=60000, }, },
					quests={ { id=29018, qType="Seasonal", }, }, tip="Marshal's Stand\n\n" ..ns.raptorHatchling, },
	[52552710] = { candy=true, version=40000, achievements={ { id=963, index=24, faction="Alliance", version=60000, },
					{ id=963, index=6, faction="Alliance", versionUnder=60000, },
					{ id=965, index=27, faction="Horde", version=60000, },
					{ id=965, index=12, faction="Horde", versionUnder=60000, }, },
					quests={ { id=12399, qType="Seasonal", }, }, tip="Inside \"The Road Warrior\" inn, Gadgetzan", },
	[52562790] = { candy=true, versionUnder=40000, achievements={ { id=963, index=8, faction="Alliance", }, -- A: 14, 9
					{ id=965, index=14, faction="Horde", }, },
					quests={ { id=12399, qType="Seasonal", }, }, tip="Gadgetzan", }, -- H: 12, 15
	[55706096] = { candy=true, version=40000, achievements={ { id=963, index=23, faction="Alliance", version=60000, },
					{ id=963, index=16, faction="Alliance", versionUnder=60000, },
					{ id=965, index=26, faction="Horde", version=60000, },
					{ id=965, index=17, faction="Horde", versionUnder=60000, }, },
					quests={ { id=29014, qType="Seasonal", }, }, tip="Bootlegger Outpost", },

}

ns.points[ ns.map.teldrassil ] = { -- Teldrassil
	[29105030] = { candy=true, versionUnder=40000, faction="Alliance", achievements={ { id=963, index=16, }, }, -- or 2 or 1
					quests={ { id=12334, qType="Seasonal", }, }, tip="Craftsmen's Terrace", },
	[34164401] = { candy=true, version=40000, faction="Alliance", achievements={ { id=963, index=5, version=60000, }, 
					{ id=963, index=14, versionUnder=60000, }, },
					quests={ { id=12334, qType="Seasonal", }, }, tip="Craftsmen's Terrace", },
	[55365229] = { candy=true, version=40000, faction="Alliance", achievements={ { id=963, index=25, version=60000, },
					{ id=963, index=11, versionUnder=60000, }, },
					quests={ { id=12331, qType="Seasonal", }, }, tip="Dolanaar", },
	[55705980] = { candy=true, versionUnder=40000, faction="Alliance", achievements={ { id=963, index=13, }, },
					quests={ { id=12331, qType="Seasonal", }, }, tip="Dolanaar", },
}

ns.points[ ns.map.theExodar ] = { -- The Exodar
	[59251846] = { candy=true, faction="Alliance", achievements={ { id=963, index=9, version=60000, }, -- or 4, 10
					{ id=963, index=5, version=40000, versionUnder=60000, }, { id=963, index=7, versionUnder=40000, }, },
					quests={ { id=12337, qType="Seasonal", }, }, tip="Seat of the Naaru, in the Exodar", },
}

ns.points[ ns.map.thousand ] = { -- Thousand Needles
	[46105150] = { candy=true, versionUnder=40000, faction="Horde", achievements={ { id=965, index=1, }, }, -- 11, 2
					quests={ { id=12379, qType="Seasonal", }, }, tip="Freewind Post", },
	[62262249] = { candy=true, achievements={ { id=963, index=8, faction="Alliance", version=60000, },
					{ id=963, index=2, faction="Alliance", version=40000, versionUnder=60000, },
					{ id=963, index=4, faction="Alliance", versionUnder=40000, }, -- or 13, 13
					{ id=965, index=10, faction="Horde", version=60000, },
					{ id=965, index=14, faction="Horde", version=40000, versionUnder=60000, }, 
					{ id=965, index=16, faction="Horde", versionUnder=40000, }, }, -- or 10, 17
					quests={ { id=12398, qType="Seasonal", }, }, tip=ns.mudsprocket, },
}

ns.points[ ns.map.thunder ] = { -- Thunder Bluff
	[45626493] = { candy=true, faction="Horde", achievements={ { id=965, index=28, version=60000, },
					{ id=965, index=15, version=40000, versionUnder=60000, }, { id=965, index=17, versionUnder=40000, }, },
					quests={ { id=12367, qType="Seasonal", }, }, tip=ns.lowerRise, }, -- or 16, 10
}

ns.points[ ns.map.ungoro ] = { -- Un'Goro Crater
	[55266212] = { candy=true, version=40000, achievements={ { id=963, index=26, faction="Alliance", version=60000, },
					{ id=963, index=15, faction="Alliance", versionUnder=60000, },
					{ id=965, index=29, faction="Horde", version=60000, },
					{ id=965, index=16, faction="Horde", versionUnder=60000, }, },
					quests={ { id=29018, qType="Seasonal", }, }, tip="Marshal's Stand\n\n" ..ns.raptorHatchling, },
}

ns.points[ ns.map.winterspring ] = { -- Winterspring
	[11848913] = { candy=true, version=40000, achievements={ { id=5837, index=2, faction="Alliance", },
					{ id=5838, index=2, faction="Horde", }, },
					quests={ { id=29000, qType="Seasonal", }, }, tip="Grove of Aessina", },
	[15626429] = { candy=true, version=40000, faction="Alliance",
					achievements={ { id=963, index=10, version=60000, }, { id=963, index=24, versionUnder=60000, }, },
					quests={ { id=28995, qType="Seasonal", }, }, tip="Talonbranch Glade", },
	[28459493] = { candy=true, version=40000, achievements={ { id=5837, index=4, faction="Alliance", version=60000, },
					{ id=5837, index=13, faction="Alliance", versionUnder=60000, },
					{ id=5838, index=4, faction="Horde", version=60000, },
					{ id=5838, index=1, faction="Horde", versionUnder=60000, }, },
					quests={ { id=29001, qType="Seasonal", }, }, tip="Shrine of Aviana", },
	[42518004] = { candy=true, version=40000, achievements={ { id=5837, index=3, faction="Alliance", version=60000, },
					{ id=5837, index=10, faction="Alliance", versionUnder=60000, },
					{ id=5838, index=3, faction="Horde", version=60000, },
					{ id=5838, index=12, faction="Horde", versionUnder=60000, }, },
					quests={ { id=28999, qType="Seasonal", }, }, tip="Nordrassil", },
	[59835122] = { candy=true, version=40000, achievements={ { id=963, index=27, faction="Alliance", version=60000, },
					{ id=963, index=8, faction="Alliance", versionUnder=60000, },
					{ id=965, index=30, faction="Horde", version=60000, },
					{ id=965, index=13, faction="Horde", versionUnder=60000, }, },
					quests={ { id=12400, qType="Seasonal", }, }, tip="Everlook", },
	[61303880] = { candy=true, versionUnder=40000, achievements={ { id=963, index=10, faction="Alliance", }, -- A: 8, 7
					{ id=965, index=15, faction="Horde", }, },
					quests={ { id=12400, qType="Seasonal", }, }, tip="Everlook", }, -- H: 3, 16
}

ns.points[ ns.map.kalimdor ] = { -- Kalimdor
	[26007600] = { candy=true, version=40000, achievements={ { id=963, faction="Alliance", showAllCriteria=true, },
					{ id=965, faction="Horde", showAllCriteria=true, }, }, large=true, noContinent=true, alwaysShow=true,
					noCoords=true, },
	[91503320] = ns.setKal,
	[91503750] = ns.setMeta,
	[93704030] = ns.setDragon,
	[94003600] = ns.setFlavour,
	[94203200] = ns.setEasternK,
	[96303900] = ns.setCataPand,
	[96603480] = ns.setOutNorth,
}

--==================================================================================================================================
--
-- EASTERN KINGDOMS
--
--==================================================================================================================================

ns.points[ ns.map.arathi ] = { -- Arathi Highlands
	[40064909] = { candy=true, version=40000, faction="Alliance",
					achievements={ { id=966, index=1, version=60000, }, { id=966, index=26, versionUnder=60000, }, },
					quests={ { id=28954, qType="Seasonal", }, }, tip="Refuge Point", },
	[69023327] = { candy=true, version=40000, faction="Horde",
					achievements={ { id=967, index=1, version=60000, }, { id=967, index=7, versionUnder=60000, }, },
					quests={ { id=12380, qType="Seasonal", }, }, tip="Hammerfall", },
	[73903260] = { candy=true, versionUnder=40000, faction="Horde", -- or 8, 10
					achievements={ { id=967, index=7, }, }, quests={ { id=12380, qType="Seasonal", }, }, tip="Hammerfall", },
	[99462082] = { candy=true, version=40000, faction="Horde",
					achievements={ { id=967, index=14, version=60000, }, { id=967, index=5, versionUnder=60000, }, },
					quests={ { id=12387, qType="Seasonal", }, }, tip="Inside the main (only) building of Revantusk Village", },
--	[38259009] = { aIDA=966, indexA=1, quest=28954, location="Refuge Point", tip="Zidormi is at this location. You'll probably\n"
--						.."need her for the Refuge Point candy bucket." },
}

ns.points[ ns.map.badlands ] = { -- Badlands
	[02904600] = { candy=true, versionUnder=40000, faction="Horde", -- or 16, 1
					achievements={ { id=967, index=16, }, }, quests={ { id=12385, qType="Seasonal", }, }, tip="Kargath", },
	[18364273] = { candy=true, version=40000, faction="Horde",
					achievements={ { id=967, index=3, version=60000, }, { id=967, index=24, versionUnder=60000, }, },
					quests={ { id=28957, qType="Seasonal", }, }, tip="New Kargath", },
	[20875632] = { candy=true, version=40000, faction="Alliance",
					achievements={ { id=966, index=2, version=60000, }, { id=966, index=26, versionUnder=60000, }, },
					quests={ { id=28956, qType="Seasonal", }, }, tip="Dragon's Mouth", },
	[65863565] = { candy=true, version=40000, achievements={ { id=966, index=3, faction="Alliance", version=60000, },
					{ id=966, index=15, faction="Alliance", versionUnder=60000, },
					{ id=967, index=2, faction="Horde", version=60000, },
					{ id=967, index=25, faction="Horde", versionUnder=60000, }, }, quests={ { id=28955, qType="Seasonal", }, },
					tip="The apple bobbing tub is outside, the pumpkin is inside. Fuselight", },
}

ns.points[ ns.map.blastedLands ] = { -- Blasted Lands
	[44348759] = { candy=true, version=40000, faction="Alliance",
					achievements={ { id=966, index=5, version=60000, }, { id=966, index=23, versionUnder=60000, }, },
					quests={ { id=28961, qType="Seasonal", }, }, tip="Surwich", },
	[60691407] = { candy=true, version=40000, faction="Alliance",
					achievements={ { id=966, index=4, version=60000, }, { id=966, index=24, versionUnder=60000, }, },
					quests={ { id=28960, qType="Seasonal", }, }, tip="Nethergarde Keep", },
	[40471128] = { candy=true, version=40000, faction="Horde",
					achievements={ { id=967, index=4, version=60000, }, { id=967, index=18, versionUnder=60000, }, },
					quests={ { id=28959, qType="Seasonal", }, }, tip="Dreadmaul Hold", },
}

ns.points[ ns.map.burningSteppes ] = { -- Burning Steppes
	[23450460] = { candy=true, version=40000, achievements={ { id=966, index=18, faction="Alliance", version=60000, },
					{ id=966, index=14, faction="Alliance", versionUnder=60000, },
					{ id=967, index=16, faction="Horde", version=60000, },
					{ id=967, index=17, faction="Horde", versionUnder=60000, }, }, quests={ { id=28965, qType="Seasonal", }, },
					tip=ns.ironSummit, },
	[65930100] = { candy=true, version=40000, faction="Alliance",
					achievements={ { id=966, index=2, version=60000, }, { id=966, index=26, versionUnder=60000, }, },
					quests={ { id=28956, qType="Seasonal", }, }, tip="Dragon's Mouth", },
}

ns.points[ ns.map.deadwind ] = { -- Deadwind Pass
	[13043879] = { candy=true, faction="Alliance", -- Or 12, 5
					achievements={ { id=966, index=8, version=60000, }, { id=966, index=9, versionUnder=60000, },
					{ id=966, index=9, versionUnder=40000, }, },
					quests={ { id=12344, qType="Seasonal", }, }, tip="Darkshire", },
	[73715952] = { candy=true, version=40000, faction="Horde",
					achievements={ { id=967, index=4, version=60000, }, { id=967, index=18, versionUnder=60000, }, },
					quests={ { id=28959, qType="Seasonal", }, }, tip="Dreadmaul Hold", },
	[78941265] = { candy=true, version=40000, faction="Alliance",
					achievements={ { id=966, index=21, version=60000, }, { id=966, index=20, versionUnder=60000, }, },
					quests={ { id=28968, qType="Seasonal", }, }, tip="The Harborage", },
	[96943727] = { candy=true, version=40000, faction="Horde", -- Or 15, 16
					achievements={ { id=967, index=22, version=60000, }, { id=967, index=1, versionUnder=60000, },
					{ id=967, index=1, versionUnder=40000, }, },
					quests={ { id=12384, qType="Seasonal", }, }, tip="Stonard", },
}

ns.points[ ns.map.dunMorogh ] = { -- Dun Morogh
	[46205300] = { fires=true, version=30000, versionUnder=40000, faction="Alliance", achievements={ { id=289, }, },
					quests=ns.fireQSet, guide=ns.letFiresCome, },
	[53205140] = { fires=true, version=40000, faction="Alliance", achievements={ { id=289, }, }, quests=ns.fireQSet,
					guide=ns.letFiresCome, },
	[45855090] = { candy=true, versionUnder=40000, faction="Alliance", achievements={ { id=966, index=13, versionUnder=40000, }, },
					quests={ { id=12332, qType="Seasonal", }, }, tip="Inside Thunderbrew Distillery of Kharanos", }, -- Or 6, 1
	[54495076] = { candy=true, version=40000, faction="Alliance", 
					achievements={ { id=966, index=7, version=60000, }, { id=966, index=9, versionUnder=60000, }, },
					quests={ { id=12332, qType="Seasonal", }, }, tip="Inside Thunderbrew Distillery of Kharanos", },
	[61172746] = { candy=true, faction="Alliance", -- 7 or 10. Was 4 intended as shared?
					achievements={ { id=966, index=13, version=60000, }, { id=966, index=4, versionUnder=60000, },
					{ id=966, index=0, versionUnder=40000, }, },
					quests={ { id=12335, qType="Seasonal", }, }, tip="Inside the Stonefire Tavern of The Commons in Ironforge", },
	[68229619] = { candy=true, version=40000, achievements={ { id=966, index=18, faction="Alliance", version=60000, },
					{ id=966, index=14, faction="Alliance", versionUnder=60000, },
					{ id=967, index=16, faction="Horde", version=60000, },
					{ id=967, index=17, faction="Horde", versionUnder=60000, }, }, quests={ { id=28965, qType="Seasonal", }, },
					tip=ns.ironSummit, },
	[93998536] = { candy=true, version=40000, faction="Horde",
					achievements={ { id=967, index=3, version=60000, }, { id=967, index=24, versionUnder=60000, }, },
					quests={ { id=28957, qType="Seasonal", }, }, tip="New Kargath", },
	[95569388] = { candy=true, version=40000, faction="Alliance",
					achievements={ { id=966, index=2, version=60000, }, { id=966, index=26, versionUnder=60000, }, },
					quests={ { id=28956, qType="Seasonal", }, }, tip="Dragon's Mouth", },
}

ns.points[ ns.map.duskwood ] = { -- Duskwood
	[73804425] = { candy=true, faction="Alliance", -- Or 12, 5
					achievements={ { id=966, index=8, version=60000, }, { id=966, index=9, versionUnder=60000, },
					{ id=966, index=9, versionUnder=40000, }, },
					quests={ { id=12344, qType="Seasonal", }, }, tip="Darkshire", },
}

ns.points[ ns.map.easternP ] = { -- Eastern Plaguelands
	[75575231] = { candy=true, achievements={ { id=966, index=9, faction="Alliance", version=60000, },
					{ id=966, index=3, faction="Alliance", version=40000, versionUnder=60000, },
					{ id=966, index=3, faction="Alliance", versionUnder=40000, }, -- Or 1, 11
					-- Cooincidence my old data had the same indexes for Cata and Wrath, H and A?
					{ id=967, index=7, faction="Horde", version=60000, },
					{ id=967, index=15, faction="Horde", version=40000, versionUnder=60000, },
					{ id=967, index=15, faction="Horde", versionUnder=40000, }, }, -- Or 6, 2
					quests={ { id=12402, faction="Alliance", qType="Seasonal", },
					{ id=12402, faction="Horde", qType="Seasonal", guide=ns.taxi, }, }, tip="Light's Hope Chapel", },
}

ns.points[ 24 ] = { -- Light's Hope Chapel - Sanctum of Light
	[40709036] = { candy=true, version=40000, tip=ns.taxi, achievements={ { id=966, index=9, faction="Alliance", version=60000, },
					{ id=966, index=3, faction="Alliance", versionUnder=60000, },
					{ id=967, index=7, faction="Horde", version=60000, },
					{ id=967, index=15, faction="Horde", versionUnder=60000, }, },
					quests={ { id=12402, qType="Seasonal", }, }, tip="Sanctum of Light, Light's Hope Chapel", },
}

ns.points[ ns.map.elwynn ] = { -- Elwynn Forest
	[22133396] = { rotten=true, version=40000, faction="Horde",
					achievements={ { id=1041, index=1, version=60000, }, { id=1041, index=4, versionUnder=60000, }, },
					quests={ { id=29374, name="Stink Bombs Away!", qType="Daily", }, }, guide=ns.stinkBombsLogoutH, },
	[24894013] = { candy=true, version=40000, faction="Alliance", achievements={ { id=966, index=19, version=60000, }, 
					{ id=966, index=2, versionUnder=60000, }, },
					quests={ { id=12336, qType="Seasonal", }, }, tip="The Trade District, Stormwind", },
	[29694442] = { rotten=true, version=40000, faction="Alliance",
					achievements={ { id=1040, index=2, version=60000, }, { id=1040, index=4, versionUnder=60000, }, },
					quests={ { id=29144, name="Clean Up In Stormwind", qType="Daily", }, }, guide=ns.cleanUpA },
	[31241227] = { candy=true, version=40000, faction="Alliance", noContinent=true, 
					achievements={ { id=5837, index=1, version=60000, }, { id=5837, index=11, versionUnder=60000, }, },
					quests={ { id=29020, qType="Seasonal", }, }, tip="Temple of the Earth\n\n" ..ns.cataclysmPortals, },
	[32095059] = { rotten=true, version=40000, faction="Alliance",
					achievements={ { id=1040, index=4, version=60000, }, { id=1040, index=1, versionUnder=60000, }, },
					quests={ { id=29371, name="A Time to Lose", qType="Daily", }, }, guide=ns.timeToLose2, },
	[32355088] = { rotten=true, version=40000, faction="Alliance",
					achievements={ { id=1040, index=1, version=60000, }, { id=1040, index=3, versionUnder=60000, }, },
					quests={ { id=29054, name="Stink Bombs Away!", qType="Daily", }, }, guide=ns.stinkBombsA, },
	[34104740] = { rotten=true, version=40000, faction="Horde",
					achievements={ { id=1041, index=4, version=60000, }, { id=1040, index=2, versionUnder=60000, }, },
					quests={ { id=29377, name="A Time to Break Down", qType="Daily", }, }, guide=ns.timeBreakDown1 },
	[42606440] = ns.fireSetA,
	[43746589] = { candy=true, faction="Alliance", achievements={ { id=966, index=10, version=60000, }, -- or 9, 2
					{ id=966, index=11, version=40000, versionUnder=60000, }, { id=966, index=12, versionUnder=40000, }, },
					quests={ { id=12286, qType="Seasonal", }, }, tip="Goldshire", },
}

-- Memory note: Too many coincidences here? The 14xx map data elsewhere is for Wrath. But for Eversong too many matches to Cata

ns.points[ ns.map.eversong ] = { -- Eversong Woods
	[43707103] = { candy=true, faction="Horde", achievements={ { id=967, index=8, }, }, -- Or 4, 9
					quests={ { id=12365, qType="Seasonal", }, }, guide="Fairbreeze Village\n\n" ..ns.taxi, },
	[47204650] = ns.fireSetH,
	[48204788] = { candy=true, faction="Horde", -- Or 3, 3
					achievements={ { id=967, index=9, version=60000, }, { id=967, index=9, version=40000, versionUnder=60000, },
					{ id=967, index=14, versionUnder=40000, }, }, quests={ { id=12364, qType="Seasonal", }, },
					guide=ns.taxi, tip=ns.falconwing, },
	[55474495] = { candy=true, faction="Horde", -- Or 2, 4
					achievements={ { id=967, index=17, version=60000, }, { id=967, index=13, version=40000, versionUnder=60000, },
					{ id=967, index=13, versionUnder=40000, }, }, quests={ { id=12370, qType="Seasonal", }, },
					guide=ns.taxi, tip=ns.theBazaar, },
	[59294137] = { candy=true, faction="Horde", -- Or 1, 15
					achievements={ { id=967, index=18, version=60000, }, { id=967, index=2, version=40000, versionUnder=60000, },
					{ id=967, index=2, versionUnder=40000, }, }, quests={ { id=12369, qType="Seasonal", }, },
					guide=ns.taxi, tip=ns.royalExchange, },	
}

ns.points[ ns.map.ghostlands ] = { -- Ghostlands
	[48683190] = { candy=true, faction="Horde", -- Or 5, 11
					achievements={ { id=967, index=10, version=60000, }, { id=967, index=6, version=40000, versionUnder=60000, },
					{ id=967, index=6, versionUnder=40000, }, },
					quests={ { id=12373, qType="Seasonal", }, }, guide="Tranquillien\n\n" ..ns.taxi, },
}

ns.points[ ns.map.hillsbrad ] = { -- Hillsbrad Foothills
	[05361180] = { candy=true, version=40000, faction="Horde", -- 
					achievements={ { id=967, index=19, version=60000, }, { id=967, index=23, versionUnder=60000, }, },
					quests={ { id=28966, qType="Seasonal", }, }, tip="Forsaken Rear Guard", },
	[04002980] = { candy=true, versionUnder=40000, faction="Horde", achievements={ { id=967, index=4, }, },
					quests={ { id=12371, qType="Seasonal", }, }, tip="In the largest building of The Sepulcher", }, -- Or 10, 13
					-- Very approximate coords - extrapolated from actual zone comparison between Retail and Wrath
	[07223134] = { candy=true, version=40000, faction="Horde", achievements={ { id=967, index=20, version=60000, },
					{ id=967, index=4, versionUnder=60000, }, }, -- Or 10, 13
					quests={ { id=12371, qType="Seasonal", }, }, tip="In the largest building of The Sepulcher", },
	[51105890] = { candy=true, versionUnder=40000, faction="Alliance", -- or 3, 3
					achievements={ { id=966, index=11, }, }, quests={ { id=12346, qType="Seasonal", }, }, tip="Southshore", },
	[57854727] = { candy=true, version=40000, faction="Horde", -- Or 9, 14
					achievements={ { id=967, index=12, version=60000, }, { id=967, index=3, versionUnder=60000, }, },
					quests={ { id=12376, qType="Seasonal", }, }, tip="Tarren Mill", },
	[60266374] = { candy=true, version=40000, faction="Horde",
					achievements={ { id=967, index=11, version=60000, }, { id=967, index=26, versionUnder=60000, }, },
					quests={ { id=28962, qType="Seasonal", }, }, tip="Eastpoint Tower", },
	[62801900] = { candy=true, versionUnder=40000, faction="Horde", -- Or 9, 14
					achievements={ { id=967, index=3, }, },
					quests={ { id=12376, qType="Seasonal", }, }, tip="Tarren Mill", },
	[67841645] = { candy=true, version=40000, faction="Alliance",
					achievements={ { id=966, index=22, version=60000, }, { id=966, index=18, versionUnder=60000, }, },
					quests={ { id=28988, qType="Seasonal", }, }, tip="Chillwind Camp", },
	[81673576] = { candy=true, faction="Alliance", achievements={ { id=966, index=11, version=60000, },  -- or 2, 8
					{ id=966, index=6, version=40000, versionUnder=60000, }, { id=966, index=6, versionUnder=40000, }, },
					quests={ { id=12351, qType="Seasonal", }, }, tip=ns.aeriePeak, },
	[89878518] = { candy=true, version=40000, faction="Alliance",
					achievements={ { id=966, index=1, version=60000, }, { id=966, index=26, versionUnder=60000, }, },
					quests={ { id=28954, qType="Seasonal", }, }, tip="Refuge Point", },
	[95624627] = { candy=true, version=40000, faction="Horde",
					achievements={ { id=967, index=13, version=60000, }, { id=967, index=19, versionUnder=60000, }, },
					quests={ { id=28971, qType="Seasonal", }, }, tip="Hiri'watha Research Station", },
}

ns.points[ ns.map.ironforge ] = { -- Ironforge
	[18345094] = { candy=true, faction="Alliance", -- 7 or 10. Was 4 intended as shared?
					achievements={ { id=966, index=13, version=60000, }, { id=966, index=4, versionUnder=60000, },
					{ id=966, index=4, versionUnder=40000, }, },
					quests={ { id=12335, qType="Seasonal", }, }, tip="Inside the Stonefire Tavern of The Commons in Ironforge", },
}

ns.points[ ns.map.lochModan ] = { -- Loch Modan
	[83026353] = { candy=true, faction="Alliance", version=40000,
					achievements={ { id=966, index=14, version=60000, }, { id=966, index=22, versionUnder=60000, }, },
					quests={ { id=28963, qType="Seasonal", }, }, tip="Farstrider Lodge", },
	[35544850] = { candy=true, faction="Alliance", achievements={ { id=966, index=15, version=60000, }, -- Or 5, 6
					{ id=966, index=8, versionUnder=60000, }, },
					quests={ { id=12339, qType="Seasonal", }, }, tip="Thelsamar", }, -- Shared??
}

ns.points[ ns.map.redridge ] = { -- Redridge Mountains
	[26464150] = { candy=true, version=40000, faction="Alliance",
					achievements={ { id=966, index=17, version=60000, }, { id=966, index=7, versionUnder=60000, }, },
					quests={ { id=12342, qType="Seasonal", }, }, tip="Lakeshire", },
	[27094492] = { candy=true, versionUnder=40000, faction="Alliance", achievements={ { id=966, index=7, }, }, -- Or 5, 6
					quests={ { id=12342, qType="Seasonal", }, }, tip="Lakeshire", },
	[51699126] = { candy=true, version=40000, faction="Alliance",
					achievements={ { id=966, index=21, version=60000, }, { id=966, index=20, versionUnder=60000, }, },
					quests={ { id=28968, qType="Seasonal", }, }, tip="The Harborage", },
	[93407338] = { candy=true, version=40000,
					achievements={ { id=966, index=20, faction="Alliance", version=60000, },
					{ id=966, index=13, faction="Alliance", versionUnder=60000, },
					{ id=967, index=21, faction="Horde", version=60000, },
					{ id=967, index=16, faction="Horde", versionUnder=60000, },},
					quests={ { id=28967, qType="Seasonal", }, }, tip="Bogpaddle", },
}

ns.points[ ns.map.searingGorge ] = { -- Searing Gorge
	[39486602] = { candy=true, version=40000,achievements={ { id=966, index=18, faction="Alliance", version=60000, },
					{ id=966, index=14, faction="Alliance", versionUnder=60000, },
					{ id=967, index=16, faction="Horde", version=60000, },
					{ id=967, index=17, faction="Horde", versionUnder=60000, }, }, quests={ { id=28965, qType="Seasonal", }, },
					tip=ns.ironSummit, },
	[96044224] = { candy=true, version=40000, faction="Horde",
					achievements={ { id=967, index=3, version=60000, }, { id=967, index=24, versionUnder=60000, }, },
					quests={ { id=28957, qType="Seasonal", }, }, tip="New Kargath", },
	[99496094] = { candy=true, version=40000, faction="Alliance",
					achievements={ { id=966, index=2, version=60000, }, { id=966, index=26, versionUnder=60000, }, },
					quests={ { id=28956, qType="Seasonal", }, }, tip="Dragon's Mouth", },
}

ns.points[ ns.map.silvermoon ] = { -- Silvermoon City
	[38008479] = { candy=true, faction="Horde", -- Or 3, 3
					achievements={ { id=967, index=9, version=60000, }, { id=967, index=9, version=40000, versionUnder=60000, },
					{ id=967, index=14, versionUnder=40000, }, },
					quests={ { id=12364, qType="Seasonal", }, }, tip=ns.falconwing, guide=ns.taxi, },
	[67597289] = { candy=true, faction="Horde", -- Or 2, 4
					achievements={ { id=967, index=17, version=60000, }, { id=967, index=13, version=40000, versionUnder=60000, },
					{ id=967, index=13, versionUnder=40000, }, },
					quests={ { id=12370, qType="Seasonal", }, }, tip=ns.theBazaar, guide=ns.taxi, },
	[70357702] = { candy=true, faction="Horde", noContinent=true, -- Or 2, 4
					achievements={ { id=967, index=17, version=60000, }, { id=967, index=13, version=40000, versionUnder=60000, },
					{ id=967, index=13, versionUnder=40000, }, },
					quests={ { id=12370, qType="Seasonal", }, }, tip=ns.theBazaar ..". Enter through here", },
	[79435765] = { candy=true, faction="Horde", noContinent=true, -- Or 1, 15
					achievements={ { id=967, index=18, version=60000, }, { id=967, index=2, version=40000, versionUnder=60000, },
					{ id=967, index=2, versionUnder=40000, }, },
					quests={ { id=12369, qType="Seasonal", }, }, tip=ns.royalExchange ..". Enter through here", },
	[83125829] = { candy=true, faction="Horde", -- Or 1, 15
					achievements={ { id=967, index=18, version=60000, }, { id=967, index=2, version=40000, versionUnder=60000, },
					{ id=967, index=2, versionUnder=40000, }, },
					quests={ { id=12369, qType="Seasonal", }, }, guide=ns.taxi, tip=ns.royalExchange, },
}

ns.points[ ns.map.silverpine ] = { -- Silverpine Forest
	[43204140] = { candy=true, versionUnder=40000, faction="Horde", achievements={ { id=967, index=4, }, },
					quests={ { id=12371, qType="Seasonal", }, }, tip="In the largest building of The Sepulcher", }, -- Or 10, 13,
	[44302028] = { candy=true, version=40000, faction="Horde", -- Or 5, 11
					achievements={ { id=967, index=19, version=60000, }, { id=967, index=23, versionUnder=60000, }, },
					quests={ { id=28966, qType="Seasonal", }, }, guide=ns.taxi, tip="Forsaken Rear Guard", },
	[46454291] = { candy=true, version=40000, faction="Horde", achievements={ { id=967, index=20, version=60000, },
					{ id=967, index=4, versionUnder=60000, }, }, -- Or 10, 13
					quests={ { id=12371, qType="Seasonal", }, }, tip="In the largest building of The Sepulcher", },
	[76830101] = { candy=true, faction="Horde", achievements={ { id=967, index=25, version=60000, }, -- or 11, 6
					{ id=967, index=11, versionUnder=60000, }, }, -- Shared again
					quests={ { id=12368, qType="Seasonal", }, }, tip=ns.theTradeQuarter .."\n\n" ..ns.goEast, },
	[99270001] = { candy=true, version=40000, faction="Horde",
					achievements={ { id=967, index=24, version=60000, }, { id=967, index=21, versionUnder=60000, }, }, 
					quests={ { id=28972, qType="Seasonal", }, }, tip="The Bulwark", },	
}

ns.points[ ns.map.stormwind ] = { -- Stormwind City
	[55006300] = { rotten=true, version=40000, faction="Horde",
					achievements={ { id=1041, index=1, version=60000, }, { id=1041, index=4, versionUnder=60000, }, },
					quests={ { id=29374, name="Stink Bombs Away!", qType="Daily", }, }, guide=ns.stinkBombsLogoutH, },
	[60517534] = { candy=true, version=40000, faction="Alliance", achievements={ { id=966, index=19, version=60000, }, 
					{ id=966, index=2, versionUnder=60000, }, },
					quests={ { id=12336, qType="Seasonal", }, }, tip="The Trade District, Stormwind", },
	[70108390] = { rotten=true, version=40000, faction="Alliance",
					achievements={ { id=1040, index=2, version=60000, }, { id=1040, index=4, versionUnder=60000, }, },
					quests={ { id=29144, name="Clean Up In Stormwind", qType="Daily", }, }, guide=ns.cleanUpA },
	[73191967] = { candy=true, version=40000, faction="Alliance", achievements={ { id=5837, index=1, version=60000, },
					{ id=5837, index=11, versionUnder=60000, }, tip="Temple of the Earth\n\n" ..ns.cataclysmPortals, },
					quests={ { id=29020, qType="Seasonal", }, }, tip=ns.cataclysmPortals, },
	[74889624] = { rotten=true, version=40000, faction="Alliance",
					achievements={ { id=1040, index=4, version=60000, }, { id=1040, index=1, versionUnder=60000, }, },
					quests={ { id=29371, name="A Time to Lose", qType="Daily", }, }, guide=ns.timeToLose2, },
	[75419681] = { rotten=true, version=40000, faction="Alliance",
					achievements={ { id=1040, index=1, version=60000, }, { id=1040, index=3, versionUnder=60000, }, },
					quests={ { id=29054, name="Stink Bombs Away!", qType="Daily", }, }, guide=ns.stinkBombsA, },
	[78918986] = { rotten=true, version=40000, faction="Horde",
					achievements={ { id=1041, index=4, version=60000, }, { id=1040, index=2, versionUnder=60000, }, },
					quests={ { id=29377, name="A Time to Break Down", qType="Daily", }, }, guide=ns.timeBreakDown1 },
}

ns.points[ ns.map.swampOS ] = { -- Swamp of Sorrows
	[23717910] = { candy=true, version=40000, faction="Horde",
					achievements={ { id=967, index=4, version=60000, }, { id=967, index=18, versionUnder=60000, }, },
					quests={ { id=28959, qType="Seasonal", }, }, tip="Dreadmaul Hold", },
	[28933240] = { candy=true, version=40000, faction="Alliance",
					achievements={ { id=966, index=21, version=60000, }, { id=966, index=20, versionUnder=60000, }, },
					quests={ { id=28968, qType="Seasonal", }, }, tip="The Harborage", },
	[46875693] = { candy=true, version=40000, faction="Horde", -- Or 15, 16
					achievements={ { id=967, index=22, version=60000, }, { id=967, index=1, versionUnder=60000, },
					{ id=967, index=1, versionUnder=40000, }, }, quests={ { id=12384, qType="Seasonal", }, }, tip="Stonard", },
	[53238317] = { candy=true, version=40000, faction="Alliance",
					achievements={ { id=966, index=4, version=60000, }, { id=966, index=24, versionUnder=60000, }, },
					quests={ { id=28960, qType="Seasonal", }, }, tip="Nethergarde Keep", },
	[71651410] = { candy=true, version=40000,
					achievements={ { id=966, index=20, faction="Alliance", version=60000, },
					{ id=966, index=13, faction="Alliance", versionUnder=60000, },
					{ id=967, index=21, faction="Horde", version=60000, },
					{ id=967, index=16, faction="Horde", versionUnder=60000, },},
					quests={ { id=28967, qType="Seasonal", }, }, tip="Bogpaddle", },					
}

ns.points[ ns.map.TheHinter ] = { -- The Hinterlands
	[14194460] = { candy=true, faction="Alliance", achievements={ { id=966, index=11, version=60000, },  -- or 2, 8
					{ id=966, index=6, version=40000, versionUnder=60000, }, { id=966, index=6, versionUnder=40000, }, },
					quests={ { id=12351, qType="Seasonal", }, }, tip=ns.aeriePeak, },
	[50709272] = { candy=true, version=40000, faction="Horde",
					achievements={ { id=967, index=1, version=60000, }, { id=967, index=7, versionUnder=60000, }, },
					quests={ { id=12380, qType="Seasonal", }, }, tip="Hammerfall", },
	[66164443] = { candy=true, version=40000, faction="Alliance",
					achievements={ { id=966, index=12, version=60000, }, { id=966, index=19, versionUnder=60000, }, },
					quests={ { id=28970, qType="Seasonal", }, }, tip="Stormfeather Outpost", },
	[31805787] = { candy=true, version=40000, faction="Horde",
					achievements={ { id=967, index=13, version=60000, }, { id=967, index=19, versionUnder=60000, }, },
					quests={ { id=28971, qType="Seasonal", }, }, tip="Hiri'watha Research Station", },
	[78198147] = { candy=true, version=40000, faction="Horde",
					achievements={ { id=967, index=14, version=60000, }, { id=967, index=5, versionUnder=60000, }, },
					quests={ { id=12387, qType="Seasonal", }, }, tip="Inside the main (only) building of Revantusk Village", },
	[32095059] = { rotten=true, version=40000, faction="Alliance",
					achievements={ { id=1040, index=4, version=60000, }, { id=1040, index=1, versionUnder=60000, }, },
					quests={ { id=29371, name="A Time to Lose", qType="Daily", }, }, guide=ns.timeToLose1, },
	[34104740] = { rotten=true, version=40000, faction="Horde",
					achievements={ { id=1041, index=4, version=60000, }, { id=1040, index=2, versionUnder=60000, }, },
					quests={ { id=29377, name="A Time to Break Down", qType="Daily", }, }, guide=ns.timeBreakDown2 },
	[42606440] = ns.fireSetA,
}

ns.points[ ns.map.tirisfal ] = { -- Tirisfal Glades
	[31959091] = { candy=true, version=40000, faction="Horde", -- Or 5, 11
					achievements={ { id=967, index=19, version=60000, }, { id=967, index=23, versionUnder=60000, }, },
					quests={ { id=28966, qType="Seasonal", guide=ns.taxi, }, }, guide=ns.taxi, tip="Forsaken Rear Guard", },
	[60605330] = { fires=true, version=30000, versionUnder=40000, faction="Alliance", achievements={ { id=289, }, },
					quests=ns.fireQSet, guide=ns.letFiresCome, },
	[60805320] = { fires=true, version=40000, faction="Horde", achievements={ { id=289, }, }, quests=ns.fireQSet,
					guide=ns.letFiresCome, },
	[62197300] = { candy=true, faction="Horde", achievements={ { id=967, index=25, version=60000, }, -- or 11, 6
					{ id=967, index=11, versionUnder=60000, }, }, -- Shared again
					quests={ { id=12368, qType="Seasonal", }, }, guide=ns.theTradeQuarter .."\n\n" ..ns.goEast, },					
	[60995141] = { candy=true, version=40000, faction="Horde",
					achievements={ { id=967, index=23, version=60000, }, { id=967, index=12, versionUnder=60000, }, },
					quests={ { id=12363, qType="Seasonal", }, }, tip="Brill\n\n" ..ns.goEast, },
	[61508110] = { rotten=true, version=40000, faction="Alliance",
					achievements={ { id=1040, index=1, version=60000, }, { id=1040, index=3, versionUnder=60000, }, },
					quests={ { id=29054, name="Stink Bombs Away!", qType="Daily", }, }, guide=ns.stinkBombsLogoutA, },
	[61805220] = { candy=true, versionUnder=40000, faction="Horde", tip="Brill\n\n" ..ns.goEast, -- or 12, 5
					achievements={ { id=967, index=12, }, }, quests={ { id=12363, qType="Seasonal", }, }, },
	[83047207] = { candy=true, version=40000, faction="Horde",
					achievements={ { id=967, index=24, version=60000, }, { id=967, index=21, versionUnder=60000, }, }, 
					quests={ { id=28972, qType="Seasonal", }, }, tip="The Bulwark", },
	[62126783] = { rotten=true, version=40000, faction="Horde",
					achievements={ { id=1041, index=4, version=60000, }, { id=1041, index=2, versionUnder=60000, }, },
					quests={ { id=29377, name="A Time to Break Down", qType="Daily", }, }, guide=ns.timeBreakDown2, },
	[62136702] = { rotten=true, version=40000, faction="Horde",
					achievements={ { id=1041, index=1, version=60000, }, { id=1041, index=4, versionUnder=60000, }, },
					quests={ { id=29374, name="Stink Bombs Away!", qType="Daily", }, }, guide=ns.stinkBombsH, },
	[62406820] = { rotten=true, version=40000, faction="Alliance",
					achievements={ { id=1040, index=4, version=60000, }, { id=1040, index=1, versionUnder=60000, }, },
					quests={ { id=29371, name="A Time to Lose", qType="Daily", }, }, guide=ns.timeToLose1, },
	[62436671] = { rotten=true, version=40000, faction="Horde",
					achievements={ { id=1041, index=2, version=60000, }, { id=1041, index=3, versionUnder=60000, }, },
					quests={ { id=29375, name="Clean Up In Undercity", qType="Daily", }, }, guide=ns.cleanUpH },
	[99189591] = { candy=true, version=40000, faction="Alliance",
					achievements={ { id=966, index=22, version=60000, }, { id=966, index=18, versionUnder=60000, }, },
					quests={ { id=28988, qType="Seasonal", }, }, noZidormi=true, tip="Chillwind Camp", },
}

ns.points[ ns.map.undercity ] = { -- Undercity
	[67753742] = { candy=true, faction="Horde", achievements={ { id=967, index=25, version=60000, }, -- or 11, 6
					{ id=967, index=11, versionUnder=60000, }, }, -- Shared again
					quests={ { id=12368, qType="Seasonal", }, }, tip=ns.theTradeQuarter .."\n\n" ..ns.goEast, },
	[76503301] = { rotten=true, version=40000, faction="Horde",
					achievements={ { id=1041, index=2, version=60000, }, { id=1041, index=3, versionUnder=60000, }, },
					quests={ { id=29375, name="Clean Up In Undercity", qType="Daily", }, }, guide=ns.cleanUpH },
	[75703300] = { rotten=true, version=40000, faction="Alliance",
					achievements={ { id=1040, index=1, version=60000, }, { id=1040, index=3, versionUnder=60000, }, },
					quests={ { id=29054, name="Stink Bombs Away!", qType="Daily", }, }, guide=ns.stinkBombsLogoutA, },
	[76105320] = { rotten=true, version=40000, faction="Alliance",
					achievements={ { id=1040, index=4, version=60000, }, { id=1040, index=1, versionUnder=60000, }, },
					quests={ { id=29371, name="A Time to Lose", qType="Daily", }, }, guide=ns.timeToLose1, },
}

ns.points[ ns.map.westernP ] = { -- Western Plaguelands
	[03243760] = { candy=true, version=40000, faction="Horde",
					achievements={ { id=967, index=23, version=60000, }, { id=967, index=12, versionUnder=60000, }, },
					quests={ { id=12363, qType="Seasonal", }, }, tip="Brill\n\n" ..ns.goEast, },
	[04506029] = { candy=true, faction="Horde", achievements={ { id=967, index=25, version=60000, }, -- or 11, 6
					{ id=967, index=11, versionUnder=60000, }, }, -- Shared again
					quests={ { id=12368, qType="Seasonal", }, }, tip=ns.theTradeQuarter .."\n\n" ..ns.goEast, },
	[26425931] = { candy=true, version=40000, faction="Horde",
					achievements={ { id=967, index=24, version=60000, }, { id=967, index=21, versionUnder=60000, }, }, 
					quests={ { id=28972, qType="Seasonal", }, }, tip="The Bulwark", },	
	[43388437] = { candy=true, version=40000, faction="Alliance",
					achievements={ { id=966, index=22, version=60000, }, { id=966, index=18, versionUnder=60000, }, },
					quests={ { id=28988, qType="Seasonal", }, }, tip="Chillwind Camp", },
	[48286365] = { candy=true, version=40000, faction="Horde",
					achievements={ { id=967, index=26, version=60000, }, { id=967, index=20, versionUnder=60000, }, }, 
					quests={ { id=28987, qType="Seasonal", }, }, tip="Andorhal", },	
}

ns.points[ ns.map.westfall ] = { -- Westfall
	[52915360] = { candy=true, versionUnder=40000, faction="Alliance", -- or 10, 9
					achievements={ { id=966, index=5, }, }, quests={ { id=12340, qType="Seasonal", }, }, tip="Sentinel Hill", },
	[52915374] = { candy=true, version=40000, faction="Alliance", quests={ { id=12340, qType="Seasonal", }, },
					achievements={ { id=966, index=25, version=60000, }, { id=966, index=5, versionUnder=60000, }, },
					tip="Sentinel Hill. Inn marker, but could also be the top of the tower. Depends on your quest phasing", },
}

ns.points[ ns.map.wetlands ] = { -- Wetlands
	[10836099] = { candy=true, faction="Alliance", achievements={ { id=966, index=23, version=60000, }, -- or 4, 4
					{ id=966, index=10, version=40000, versionUnder=60000, }, { id=966, index=10, versionUnder=40000, }, },
					quests={ { id=12343, qType="Seasonal", }, }, tip="Menethil Harbor. In the inn that's behind the fort", },
	[11349760] = { candy=true, faction="Alliance", -- 7 or 10. Was 4 intended as shared?
					achievements={ { id=966, index=13, version=60000, }, { id=966, index=4, versionUnder=60000, },
					{ id=966, index=0, versionUnder=40000, }, tip="he Commons", },
					quests={ { id=12335, qType="Seasonal", }, }, tip="Inside the Stonefire Tavern", },
	[26072598] = { candy=true, version=40000, faction="Alliance",
					achievements={ { id=966, index=24, version=60000, }, { id=966, index=16, versionUnder=60000, }, },
					quests={ { id=28990, qType="Seasonal", }, }, tip="Swiftgear Station", },
	[58213920] = { candy=true, faction="Alliance", version=40000,
					achievements={ { id=966, index=26, version=60000, }, { id=966, index=17, versionUnder=60000, }, },
					quests={ { id=28991, qType="Seasonal", }, }, tip="Greenwarden's Grove\n\n" ..ns.raptorHatchling, },
}

ns.points[ ns.map.northStrangle ] = { -- Northern Stranglethorn
	[24838108] = { candy=true, version=60000, faction="Horde", tip="Hardwrench Hideaway",
					achievements={ { id=967, index=6, }, }, quests={ { id=28969, qType="Seasonal", }, }, },
	[25007990] = { candy=true, version=40000, versionUnder=60000, faction="Horde",  tip="Hardwrench Hideaway",
					achievements={ { id=967, index=22, }, }, quests={ { id=28969, qType="Seasonal", }, }, },
	[27107730] = { candy=true, versionUnder=40000, -- or A: 13, 13; H: 14, 7
					achievements={ { id=966, index=1, faction="Alliance", }, { id=967, index=10, faction="Horde", },},
					quests={ { id=12397, qType="Seasonal", }, }, tip="It's in the Salty Sailor Tavern at Booty Bay", },
	[31502970] = { candy=true, versionUnder=40000, faction="Horde", tip="Grom'gol Base Camp", -- or 13, 8
					achievements={ { id=967, index=9, }, }, quests={ { id=12382, qType="Seasonal", }, }, },
	[39005230] = { candy=true, version=60000, faction="Horde", tip="Grom'gol Base Camp", 
					achievements={ { id=967, index=15, }, }, quests={ { id=12382, qType="Seasonal", }, }, },
	[37305170] = { candy=true, version=40000, versionUnder=60000, faction="Horde", tip="Grom'gol Base Camp",
					achievements={ { id=967, index=9, }, }, quests={ { id=12382, qType="Seasonal", }, }, },
	[53166698] = { candy=true, version=40000, faction="Alliance",
					achievements={ { id=966, index=16, version=60000, }, { id=966, index=21, versionUnder=60000, }, },
					quests={ { id=28964, qType="Seasonal", }, }, tip="Fort Livingston", },
}

ns.points[ 210 ] = { -- The Cape of Stranglethorn
	[40917372] = { candy=true, version=40000, -- Booty Bay
					achievements={ { id=966, index=6, faction="Alliance", version=60000, },
					{ id=966, index=1, faction="Alliance", versionUnder=60000, },
					{ id=967, index=5, faction="Horde", version=60000, },
					{ id=967, index=10, faction="Horde", versionUnder=60000, },},
					quests={ { id=12397, qType="Seasonal", }, }, tip="It's in the Salty Sailor Tavern", },					
	[35042722] = { candy=true, version=40000, faction="Horde", tip="Hardwrench Hideaway",
					achievements={ { id=967, index=6, version=60000, }, { id=967, index=22, versionUnder=60000, }, },
					quests={ { id=28969, qType="Seasonal", }, }, },
	[64481257] = { candy=true, version=40000, faction="Alliance",
					achievements={ { id=966, index=16, version=60000, }, { id=966, index=21, versionUnder=60000, }, },
					quests={ { id=28964, qType="Seasonal", }, }, tip="Fort Livingston", },
}

ns.points[ 224 ] = { -- Stranglethorn Vale
	[27107730] = { candy=true, versionUnder=40000, -- Booty Bay, or A: 13, 13; H: 14, 7
					achievements={ { id=966, index=1, faction="Alliance", }, { id=967, index=10, faction="Horde", },},
					quests={ { id=12397, qType="Seasonal", }, }, tip="It's in the Salty Sailor Tavern", },					
	[34365192] = { candy=true, version=40000, faction="Horde", tip="Hardwrench Hideaway",
					achievements={ { id=967, index=6, version=60000, }, { id=967, index=22, versionUnder=60000, }, },
					quests={ { id=28969, qType="Seasonal", }, }, },
	[37907993] = { candy=true, version=40000, -- Booty Bay
					achievements={ { id=966, index=6, faction="Alliance", version=60000, },
					{ id=966, index=1, faction="Alliance", versionUnder=60000, },
					{ id=967, index=5, faction="Horde", version=60000, },
					{ id=967, index=10, faction="Horde", versionUnder=60000, },},
					quests={ { id=12397, qType="Seasonal", }, }, tip="It's in the Salty Sailor Tavern", },					
	[42213359] = { candy=true, versionUnder=40000, faction="Horde", tip="Grom'gol Base Camp", -- or 13, 8
					achievements={ { id=967, index=9, }, }, quests={ { id=12382, qType="Seasonal", }, }, },
	[42173354] = { candy=true, version=40000, versionUnder=60000, faction="Horde", tip="Grom'gol Base Camp",
					achievements={ { id=967, index=9, }, }, quests={ { id=12382, qType="Seasonal", }, }, },
	[43233392] = { candy=true, version=60000, faction="Horde", tip="Grom'gol Base Camp", 
					achievements={ { id=967, index=15, }, }, quests={ { id=12382, qType="Seasonal", }, }, },
	[51704300] = { candy=true, version=40000, faction="Alliance",
					achievements={ { id=966, index=16, version=60000, }, { id=966, index=21, versionUnder=60000, }, },
					quests={ { id=28964, qType="Seasonal", }, }, tip="Fort Livingston", },
	[88444023] = { candy=true, version=40000, faction="Alliance",
					achievements={ { id=966, index=5, version=60000, }, { id=966, index=23, versionUnder=60000, }, },
					quests={ { id=28961, qType="Seasonal", }, }, tip="Surwich", },
}

ns.points[ ns.map.easternK ] = { -- Eastern Kingdoms
	[28007600] = { candy=true, version=40000, achievements={ { id=966, faction="Alliance", showAllCriteria=true, },
					{ id=967, faction="Horde", showAllCriteria=true, }, }, large=true, alwaysShow=true, noContinent=true,
					noCoords=true, },
	[91503320] = ns.setKal,
	[91503750] = ns.setMeta,
	[93704030] = ns.setDragon,
	[94003600] = ns.setFlavour,
	[94203200] = ns.setEasternK,
	[96303900] = ns.setCataPand,
	[96603480] = ns.setOutNorth,
}

--==================================================================================================================================
--
-- THE BURNING CRUSADE / OUTLAND
--
--==================================================================================================================================

ns.aldorScryer = "but... if absolutely neutral then your choice, Aldor or Scryer, but only one"
ns.aldor = "Aldor Rise. You must be Aldor " ..ns.aldorScryer
ns.aldorSet = { candy=true, achievements={ { id=969, index=11, faction="Alliance", }, 
			{ id=968, index=11, faction="Horde", version=60000, }, { id=968, index=7, faction="Horde", versionUnder=60000, }, },
			quests={ { id=12404, qType="Seasonal", }, }, tip=ns.aldor, }
ns.scryer = "Scryer's Tier. You must be Scryer " ..ns.aldorScryer
ns.scryerSet = { candy=true, achievements={ { id=969, index=11, faction="Alliance", }, 
			{ id=968, index=11, faction="Horde", version=60000, }, { id=968, index=7, faction="Horde", versionUnder=60000, }, },
			quests={ { id=12404, qType="Seasonal", }, }, tip=ns.scryer, }

ns.area52 = "Area 52. A little inside the main building"
ns.cenarionRSet = { candy=true, achievements={ { id=969, index=13, faction="Alliance", version=60000, },
			{ id=969, index=2, faction="Alliance", version=60000, },
			{ id=968, index=14, faction="Horde", }, },
			quests={ { id=12403, qType="Seasonal", }, }, tip="Cenarion Refuge. Inside the main building", }
ns.cenarionCSet = { candy=true, achievements={ { id=969, index=2, faction="Alliance", }, { id=968, index=2, faction="Horde", }, },
			quests={ { id=12403, qType="Seasonal", }, }, tip="Cenarion Refuge. Inside the main building", }
ns.evergrove = "Evergrove. Inside the inn, mailbox at the front"
ns.garadar = "Garadar. At the centre of the huge round building. If mobs are orange it's still okay"
ns.mokNathal = "Mok'Nathal Village. Inside the main building"
ns.orebor = "Orebor Harborage. Inside the building with the mailbox"

ns.points[ ns.map.bladesEdge ] = { -- Blade's Edge Mountains
	[27239263] = { candy=true, faction="Alliance", achievements={ { id=969, index=14, version=60000, },
					{ id=969, index=1, versionUnder=60000, }, },
					quests={ { id=12355, qType="Seasonal", }, }, tip=ns.orebor, },
	[35836373] = { candy=true, faction="Alliance", achievements={ { id=969, index=2, version=60000, },
					{ id=969, index=15, versionUnder=60000, }, }, quests={ { id=12358, qType="Seasonal", }, },
					tip="Sylvanaar. At the rear of the inn, behind the main building", },
	[53435555] = { candy=true, faction="Horde", achievements={ { id=968, index=3, version=60000, },
					{ id=968, index=11, versionUnder=60000, }, },
					quests={ { id=12393, qType="Seasonal", }, }, tip="Thunderlord Stronghold. Inside the main building", },
	[61056808] = { candy=true, faction="Alliance", achievements={ { id=969, index=3, version=60000, },
					{ id=969, index=14, versionUnder=60000, }, }, quests={ { id=12359, qType="Seasonal", }, },
					tip="Toshley's Station. At the rear of the inn. The building has a mailbox", },
	[62903833] = { candy=true, achievements={ { id=969, index=1, faction="Alliance", version=60000, },
					{ id=969, index=8, faction="Alliance", versionUnder=60000, },
					{ id=968, index=14, faction="Horde", }, }, quests={ { id=12406, qType="Seasonal", }, }, tip=ns.evergrove, },
	[76226039] = { candy=true, faction="Horde", achievements={ { id=968, index=2, version=60000, },
					{ id=968, index=3, versionUnder=60000, }, },
					quests={ { id=12394, qType="Seasonal", }, }, tip=ns.mokNathal, },
	[94893725] = { candy=true, achievements={ { id=969, index=7, faction="Alliance", },
					{ id=968, index=7, faction="Horde", version=60000, },
					{ id=968, index=13, faction="Horde", versionUnder=60000, }, },
					quests={ { id=12407, qType="Seasonal", }, }, tip=ns.area52, },
}

ns.points[ ns.map.hellfire ] = { -- Hellfire Peninsula
	[00164803] = ns.cenarionRSet,
	[23423637] = { candy=true, faction="Alliance", achievements={ { id=969, index=5, version=60000, },
					{ id=969, index=12, versionUnder=60000, }, },
					quests={ { id=12353, qType="Seasonal", }, },
					tip="Temple of Telhamat. In the main building at the end of the promenade", },
	[26895947] = { candy=true, faction="Horde", achievements={ { id=968, index=4, version=60000, },
					{ id=968, index=6, versionUnder=60000, }, },
					quests={ { id=12389, qType="Seasonal", }, }, tip="Falcon Watch. In the lower, domed building", },
	[54256368] = { candy=true, faction="Alliance", achievements={ { id=969, index=4, version=60000, },
					{ id=969, index=13, versionUnder=60000, }, },
					quests={ { id=12352, qType="Seasonal", }, }, tip="Honor Hold. In the inn, mailbox at the front", },
	[56813745] = { candy=true, faction="Horde", achievements={ { id=968, index=5, version=60000, },
					{ id=968, index=9, versionUnder=60000, }, },
					quests={ { id=12388, qType="Seasonal", }, }, tip="Thrallmar. In the smaller of the two main buildings", },
}

ns.points[ ns.map.nagrand ] = { -- Nagrand
	[54197588] = { candy=true, faction="Alliance", achievements={ { id=969, index=6, version=60000, }, 
					{ id=969, index=3, versionUnder=60000, }, }, quests={ { id=12357, qType="Seasonal", }, },
					tip="Telaar. Below the Flight Master. If mobs are orange it's still okay", },
	[56683448] = { candy=true, faction="Horde", achievements={ { id=968, index=6, version=60000, },
					{ id=968, index=1, versionUnder=60000, }, }, quests={ { id=12392, qType="Seasonal", }, }, tip=ns.garadar, },
	[81985275] = ns.aldorSet,					
	[86240582] = ns.cenarionRSet,
	[88626052] = ns.scryerSet,
}

ns.points[ ns.map.netherstorm ] = { -- Netherstorm
	[00906549] = { candy=true, achievements={ { id=969, index=1, faction="Alliance", version=60000, },
					{ id=969, index=8, faction="Alliance", versionUnder=60000, },
					{ id=968, index=1, faction="Horde", version=60000, },
					{ id=968, index=14, faction="Horde", versionUnder=60000, }, },
					quests={ { id=12406, qType="Seasonal", }, }, tip=ns.evergrove, },
	[13858696] = { candy=true, faction="Horde", achievements={ { id=968, index=2, version=60000, },
					{ id=968, index=3, versionUnder=60000, }, },
					quests={ { id=12394, qType="Seasonal", }, }, tip=ns.mokNathal, },
	[32026444] = { candy=true, achievements={ { id=969, index=7, faction="Alliance", }, { id=968, index=13, faction="Horde", }, },
					quests={ { id=12407, qType="Seasonal", }, }, tip=ns.area52, },
	[43313609] = { candy=true, achievements={ { id=969, index=8, faction="Alliance", version=60000, },
					{ id=969, index=6, faction="Alliance", versionUnder=60000, },
					{ id=968, index=8, faction="Horde", version=60000, },
					{ id=968, index=5, faction="Horde", versionUnder=60000, },					},
					quests={ { id=12408, qType="Seasonal", }, }, tip="The Stormspire. Fly high up. Inside the lowest building", },
}

ns.points[ ns.map.shadowmoon ] = { -- Shadowmoon Valley
	[30272770] = { candy=true, faction="Horde", achievements={ { id=968, index=10, version=60000, },
					{ id=968, index=8, versionUnder=60000, }, },
					quests={ { id=12395, qType="Seasonal", }, }, tip="Shadowmoon Village. In the main building", },
	[37015829] = { candy=true, faction="Alliance", achievements={ { id=969, index=10, version=60000, },
					{ id=969, index=5, versionUnder=60000, }, },
					quests={ { id=12360, qType="Seasonal", }, }, tip="Wildhammer Stronghold. In the dining area of the "
						.."Kharanos-style inn with brewing iconography. Don't enter the big building", },
	[56375982] = { candy=true, achievements={ { id=969, index=9, faction="Alliance", version=60000, },
					{ id=969, index=4, faction="Alliance", versionUnder=60000, },
					{ id=968, index=9, faction="Horde", version=60000, },
					{ id=968, index=4, faction="Horde", versionUnder=60000, }, },
					quests={ { id=12409, qType="Seasonal", }, },
					tip="Sanctum of the Stars. You must be Scryer " ..ns.aldorScryer, },
	[61002817] = { candy=true, achievements={ { id=969, index=9, faction="Alliance", version=60000, },
					{ id=969, index=4, faction="Alliance", versionUnder=60000, },
					{ id=968, index=9, faction="Horde", version=60000, },
					{ id=968, index=4, faction="Horde", versionUnder=60000, }, },
					quests={ { id=12409, qType="Seasonal", }, },
					tip="Altar of Sha'tar. You must be Aldor " ..ns.aldorScryer, },
}

ns.points[ ns.map.shattrath ] = { -- Shattrath City
	[28234908] = ns.aldorSet,
	[56308195] = ns.scryerSet,
}

ns.points[ ns.map.terokkar ] = { -- Terokkar Forest
	[24392504] = ns.aldorSet,
	[31183299] = ns.scryerSet,
	[48734517] = { candy=true, faction="Horde", achievements={ { id=968, index=12, }, },
					quests={ { id=12391, qType="Seasonal", }, }, tip="Stonebreaker Hold. Inside the huge round building", },
	[56595322] = { candy=true, faction="Alliance", achievements={ { id=969, index=12, version=60000, },
					{ id=969, index=10, versionUnder=60000, }, },
					quests={ { id=12356, qType="Seasonal", }, },
					tip="Allerian Stronghold. Inside the only round, domed (elven) building", },
	[83775454] = { candy=true, faction="Horde", achievements={ { id=968, index=10, version=60000, },
					{ id=968, index=8, versionUnder=60000, }, },
					quests={ { id=12395, qType="Seasonal", }, }, tip="Shadowmoon Village. In the main building", },
	[90638570] = { candy=true, faction="Alliance", achievements={ { id=969, index=10, version=60000, },
					{ id=969, index=5, versionUnder=60000, }, },
					quests={ { id=12360, qType="Seasonal", }, }, tip="Wildhammer Stronghold. In the dining area of the "
						.."Kharanos-style inn with brewing iconography. Don't enter the big building", },
}

ns.points[ ns.map.zangarmarsh ] = { -- Zangarmarsh
	[30625087] = { candy=true, faction="Horde", achievements={ { id=968, index=13, version=60000, },
					{ id=968, index=10, versionUnder=60000, }, },
					quests={ { id=12390, qType="Seasonal", }, }, tip="Zabra'jin. The ground level of the inn with no name ", },
	[41902617] = { candy=true, faction="Alliance", achievements={ { id=969, index=14, version=60000, },
					{ id=969, index=1, versionUnder=60000, }, },
					quests={ { id=12355, qType="Seasonal", }, }, tip=ns.orebor, },
	[45979438] = { candy=true, faction="Horde", achievements={ { id=968, index=1, version=60000, },
					{ id=968, index=6, versionUnder=60000, }, },
					quests={ { id=12392, qType="Seasonal", }, }, tip=ns.garadar, },
	[67164894] = { candy=true, faction="Alliance", achievements={ { id=969, index=15, version=60000, },
					{ id=969, index=9, versionUnder=60000, }, },
					quests={ { id=12354, qType="Seasonal", }, }, tip="Telredor. Right next to the innkeeper", },
	[78456289] = ns.cenarionRSet,
}

ns.points[ ns.map.outland ] = { -- Outland
	[73003880] = { title="Candy Bucket Macro", tip="#showtooltip Handful of Treats\n/use Handful of Treats" },
	[91503320] = ns.setKal,
	[91503750] = ns.setMeta,
	[93704030] = ns.setDragon,
	[94003600] = ns.setFlavour,
	[94203200] = ns.setEasternK,
	[96303900] = ns.setCataPand,
	[96603480] = ns.setOutNorth,
}

--==================================================================================================================================
--
-- WRATH OF THE LICH KING / NORTHREND
--
--==================================================================================================================================

ns.argentStrandSet = { candy=true, version=40000, achievements={ { id=5836, index=21, faction="Alliance", version=60000, },
			{ id=5836, index=1, faction="Alliance", versionUnder=60000, }, { id=5835, index=23, faction="Horde", version=60000, },
			{ id=5835, index=1, faction="Horde", versionUnder=60000, }, }, quests={ { id=12941, qType="Seasonal", }, },
			tip="The Argent Strand", }
ns.cantripsAch = { { id=5836, index=6, faction="Alliance", version=60000, },
			{ id=5836, index=10, faction="Alliance", version=40000, versionUnder=60000, },
			{ id=5835, index=7, faction="Horde", version=60000, },
			{ id=5835, index=13, faction="Horde", version=40000, versionUnder=60000, }, }
ns.cantripsQ = { { id=13472, qType="Seasonal", }, }
ns.cantripsTip = "Cantrips & Crows, below in The Underbelly"
ns.filthyAch = { { id=5835, index=6, version=60000, }, { id=5835, index=21, version=40000, versionUnder=60000, }, }
ns.filthyQ = { { id=13474, qType="Seasonal", }, }
ns.filthyTip = "The Filthy Animal - Sunreaver's Sanctuary"
ns.heroesWelcomeAch = { { id=5836, index=5, version=60000, }, { id=5836, index=11, version=40000, versionUnder=60000, }, }
ns.heroesWelcomeQ = { { id=13473, qType="Seasonal", }, }
ns.heroesWelcomeTip = "A Hero's Welcome. Don't go into the Silver Enclave. It's in the adjacent \"A Hero's Welcome\" inn. Under "
			.."the stairs on the right side"
ns.k3Set = { candy=true, achievements={ { id=5836, index=20, faction="Alliance", version=60000, },
			{ id=5836, index=6, faction="Alliance", version=40000, versionUnder=60000, },
			{ id=5835, index=22, faction="Horde", version=60000, },
			{ id=5835, index=9, faction="Horde", version=40000, versionUnder=60000, }, },
			quests={ { id=13461, qType="Seasonal", }, }, tip="Icon marks the entrance to the Inn at K3", }
ns.legerdemainAch = { { id=5836, index=4, faction="Alliance", version=60000, },
			{ id=5836, index=12, faction="Alliance", version=40000, versionUnder=60000, },
			{ id=5835, index=5, faction="Horde", version=60000, },
			{ id=5835, index=4, faction="Horde", version=40000, versionUnder=60000, }, }
ns.legerdemainQ = { { id=13463, qType="Seasonal", }, }
ns.legerdemaintTip = "In The Legerdemain Lounge inn"
ns.legerdemainSet = { candy=true, achievements=ns.legerdemainAch, quests=ns.legerdemainQ, tip=ns.legerdemaintTip, }
									
ns.points[ 114 ] = { -- Borean Tundra
	[41715440] = { candy=true, version=40000, faction="Horde", achievements={ { id=5835, index=4, version=60000, },
					{ id=5835, index=5, versionUnder=60000, }, }, quests={ { id=13468, qType="Seasonal", }, },
					tip="Warsong Hold. The lowest level. Use the south-south-east entrance at ground level and enter the pidgeon "
						.."hole in the stairs. Do NOT ascend those stairs!", },
	[49750998] = { candy=true, version=40000, faction="Horde", quests={ { id=13501, qType="Seasonal", }, }, tip="Bor'gorok Outpost",
					achievements={ { id=5835, index=1, version=60000, }, { id=5835, index=3, versionUnder=60000, }, }, },
	[57071907] = { candy=true, version=40000, faction="Alliance", quests={ { id=13437, qType="Seasonal", }, },
					achievements={ { id=5836, index=1, version=60000, }, { id=5836, index=21, versionUnder=60000, }, },
					tip="Fizzcrank Airstrip. Inside the main building. Icon marks the entrance", },
	[58526787] = { candy=true, version=40000, faction="Alliance",
					achievements={ { id=5836, index=3, version=60000, }, { id=5836, index=20, versionUnder=60000, }, },
					quests={ { id=13436, qType="Seasonal", }, tip="Valiance Keep", },
					tip="Quite a ways inside the inn, which is adjacent to the Flight Master", },
	[76663747] = { candy=true, version=40000, faction="Horde",
					achievements={ { id=5835, index=2, version=60000, }, { id=5835, index=24, versionUnder=60000, }, },
					quests={ { id=13467, qType="Seasonal", }, }, tip="Taunka'le Village", },					
	[78454916] = { candy=true, version=40000, achievements={ { id=5836, index=2, faction="Alliance", version=60000, },
					{ id=5836, index=13, faction="Alliance", versionUnder=60000, },
					{ id=5835, index=3, faction="Horde", version=60000, },
					{ id=5835, index=14, faction="Horde", versionUnder=60000, }, },
					quests={ { id=13460, qType="Seasonal", }, },
					tip="Unu'pe. Inside the inn / main building which is above the shore", },
}

ns.points[ 127 ] = { -- Crystalsong Forest
	[27284325] = { candy=true, faction="Alliance", versionUnder=60000, achievements=ns.heroesWelcomeAch,
					quests=ns.heroesWelcomeQ, tip=ns.heroesWelcomeTip, },
	[28154209] = { candy=true, faction="Alliance", version=60000, achievements=ns.heroesWelcomeAch,
					quests=ns.heroesWelcomeQ, tip=ns.heroesWelcomeTip, },
	[27294137] = { candy=true, achievements=ns.cantripsAch, quests=ns.cantripsQ, tip=ns.cantripsTip, },
	[29043660] = { candy=true, versionUnder=60000, achievements=ns.legerdemainAch, quests=ns.legerdemainQ,
					tip=ns.legerdemaintTip, },
	[29343758] = { candy=true, version=60000, achievements=ns.legerdemainAch, quests=ns.legerdemainQ, tip=ns.legerdemaintTip, },
	[34703314] = { candy=true, faction="Horde", versionUnder=60000, achievements=ns.filthyAch, quests=ns.filthyQ ,
					tip=ns.filthyTip, },
	[33183524] = { candy=true, faction="Horde", version=60000, achievements=ns.filthyAch, quests=ns.filthyQ , tip=ns.filthyTip, },
	[92292093] = ns.k3Set,
}

ns.points[ 125 ] = { -- Dalaran
	[38225962] = { candy=true, noContinent=true, achievements=ns.cantripsAch, quests=ns.cantripsQ, tip=ns.cantripsTip, },
	[42366313] = { candy=true, faction="Alliance", noContinent=true, achievements=ns.heroesWelcomeAch,
					quests=ns.heroesWelcomeQ, tip=ns.heroesWelcomeTip, },
	[48144132] = { candy=true, noContinent=true, achievements=ns.legerdemainAch, quests=ns.legerdemainQ, tip=ns.legerdemaintTip, },
	[66703000] = { candy=true, faction="Horde", noContinent=true, achievements=ns.filthyAch, quests=ns.filthyQ, tip=ns.filthyTip, },
}

ns.points[ 126 ] = { -- The Underbelly
	[38225962] = { candy=true, noContinent=true, achievements=ns.cantripsAch, quests=ns.cantripsQ, tip=ns.cantripsTip, },
}

ns.points[ 115 ] = { -- Dragonblight
	[28955622] = { candy=true, faction="Alliance", quests={ { id=13438, qType="Seasonal", }, }, tip="Star's Rest",
					achievements={ { id=5836, index=8, version=60000, },
					{ id=5836, index=17, version=40000, versionUnder=60000, }, }, },
	[48117465] = { candy=true, quests={ { id=13459, qType="Seasonal", }, },
					achievements={ { id=5836, index=7, faction="Alliance", version=60000, },
					{ id=5836, index=9, faction="Alliance", version=40000, versionUnder=60000, },
					{ id=5835, index=9, faction="Horde", version=60000, },
					{ id=5835, index=2, faction="Horde", version=40000, versionUnder=60000, }, }, tip="Moa'ki Harbor", },
	[77285099] = { candy=true, faction="Alliance", achievements={ { id=5836, index=9, version=60000, },
					{ id=5836, index=19, version=40000, versionUnder=60000, }, },
					quests={ { id=13439, qType="Seasonal", }, }, tip="Wintergarde Keep. Icon marks the entrance to the inn. "
						.."It's the closest building to the Flight Master", },
	[60155345] = { candy=true, quests={ { id=13456, qType="Seasonal", }, },
					achievements={ { id=5836, index=10, faction="Alliance", version=60000, },
					{ id=5836, index=3, faction="Alliance", version=40000, versionUnder=60000, },
					{ id=5835, index=11, faction="Horde", version=60000, },
					{ id=5835, index=20, faction="Horde", version=40000, versionUnder=60000, }, },					
					tip="Wyrmrest Temple. The ground floor. Use the nearest entrance to the Gryphon Master", },
	[37834647] = { candy=true, faction="Horde", tip="Agmar's Hammer",
					achievements={ { id=5835, index=8, version=60000, },
					{ id=5835, index=23, version=40000, versionUnder=60000, }, }, quests={ { id=13469, qType="Seasonal", }, }, },
	[76826328] = { candy=true, faction="Horde", achievements={ { id=5835, index=10, version=60000, },
					{ id=5835, index=12, version=40000, versionUnder=60000, }, },
					quests={ { id=13470, qType="Seasonal", }, }, tip="Venomspite", },
}

ns.points[ 116 ] = { -- Grizzly Hills
	[20896477] = { candy=true, faction="Horde", quests={ { id=12946, qType="Seasonal", }, },
					achievements={ { id=5835, index=13, version=60000, },
					{ id=5835, index=6, version=40000, versionUnder=60000, }, }, tip="Conquest Hold", },	
	[29140133] = ns.argentStrandSet,
	[31946021] = { candy=true, faction="Alliance", quests={ { id=12944, qType="Seasonal", }, }, 
					achievements={ { id=5836, index=11, version=60000, },
					{ id=5836, index=16, version=40000, versionUnder=60000, }, },
					tip="Amberpine Lodge", },
	[59642636] = { candy=true, faction="Alliance", quests={ { id=12945, qType="Seasonal", }, },
					achievements={ { id=5836, index=12, version=60000, },
					{ id=5836, index=8, version=40000, versionUnder=60000, }, }, tip="Westfall Brigade", },
	[62368101] = { candy=true, faction="Horde", quests={ { id=13464, qType="Seasonal", }, }, tip="Camp Winterhoof",
					achievements={ { id=5835, index=14, version=60000, },
					{ id=5835, index=19, version=40000, versionUnder=60000, }, }, },					
	[65364700] = { candy=true, faction="Horde", achievements={ { id=5835, index=12, version=60000, }, tip="Camp Oneqwah", 
					{ id=5835, index=7, version=40000, versionUnder=60000, }, }, quests={ { id=12947, qType="Seasonal", }, }, },
	[75138689] = { candy=true, faction="Alliance", quests={ { id=13435, qType="Seasonal", }, },
					achievements={ { id=5836, index=13, version=60000, },
					{ id=5836, index=18, version=40000, versionUnder=60000, }, }, tip="Fort Wildervar", },
}

ns.points[ 117 ] = { -- Howling Fjord
	[25315914] = { candy=true, achievements={ { id=5836, index=14, faction="Alliance", version=60000, },
					{ id=5836, index=2, faction="Alliance", version=40000, versionUnder=60000, },
					{ id=5835, index=15, faction="Horde", version=60000, },
					{ id=5835, index=18, faction="Horde", version=40000, versionUnder=60000, }, },
					quests={ { id=13452, qType="Seasonal", }, }, tip="Kamagua. Icon marks the entrance to the subterranean Inn", },
	[30834205] = { candy=true, faction="Alliance",
					achievements={ { id=5836, index=16, version=60000, },
					{ id=5836, index=15, version=40000, versionUnder=60000, }, },
					quests={ { id=13434, qType="Seasonal", }, }, tip="Westguard Keep. Icon marks the inn entrance", },
	[49401080] = { candy=true, faction="Horde", quests={ { id=13464, qType="Seasonal", }, }, tip="Camp Winterhoof",
					achievements={ { id=5835, index=14, version=60000, },
					{ id=5835, index=19, version=40000, versionUnder=60000, }, }, },
	[52106620] = { candy=true, faction="Horde", achievements={ { id=5835, index=16, version=60000, }, tip="New Agamand",
					{ id=5835, index=15, version=40000, versionUnder=60000, }, }, quests={ { id=13465, qType="Seasonal", }, }, },
	[58676316] = { candy=true, faction="Alliance", achievements={ { id=5836, index=15, version=60000, },
					{ id=5836, index=7, version=40000, versionUnder=60000, }, },
					quests={ { id=13433, qType="Seasonal", }, }, tip="Valgarde. The Inn entrance is at the side", },
	[60481591] = { candy=true, faction="Alliance", quests={ { id=13435, qType="Seasonal", }, },
					achievements={ { id=5836, index=13, version=60000, },
					{ id=5836, index=18, version=40000, versionUnder=60000, }, }, tip="Fort Wildervar", },
	[79273063] = { candy=true, faction="Horde", quests={ { id=13466, qType="Seasonal", }, },
					achievements={ { id=5835, index=17, version=60000, },
					{ id=5835, index=22, version=40000, versionUnder=60000, }, },
					tip="Vengeance Landing. The Inn entrance is at the side", },
}

ns.points[ 118 ] = { -- Icecrown
	[75638872] = { candy=true, faction="Alliance", versionUnder=60000, noContinent=true, achievements=ns.heroesWelcomeAch,
					quests=ns.heroesWelcomeQ, tip=ns.heroesWelcomeTip, },
	[76018822] = { candy=true, faction="Alliance", version=60000, noContinent=true, achievements=ns.heroesWelcomeAch,
					quests=ns.heroesWelcomeQ, tip=ns.heroesWelcomeTip, },
	[75648791] = { candy=true,  noContinent=true, achievements=ns.cantripsAch, quests=ns.cantripsQ,
					tip=ns.cantripsTip, },
	[76408584] = { candy=true, versionUnder=60000, noContinent=true, achievements=ns.legerdemainAch, quests=ns.legerdemainQ,
					tip=ns.legerdemaintTip, },
	[76538626] = { candy=true, version=60000, noContinent=true, achievements=ns.legerdemainAch, quests=ns.legerdemainQ,
					tip=ns.legerdemaintTip, },
	[78858434] = { candy=true, faction="Horde", versionUnder=60000, noContinent=true, achievements=ns.filthyAch, quests=ns.filthyQ,
					tip=ns.filthyTip, },
	[78208525] = { candy=true, faction="Horde", version=60000, noContinent=true, achievements=ns.filthyAch, quests=ns.filthyQ,
					tip=ns.filthyTip, },
	[90016580] = { candy=true, faction="Alliance", achievements={ { id=5836, index=19, version=60000, },
					{ id=5836, index=5, version=40000, versionUnder=60000, }, },
					quests={ { id=13448, qType="Seasonal", }, }, tip="Frosthold", },
	[92122346] = { candy=true, achievements={ { id=5836, index=18, faction="Alliance", version=60000, },
					{ id=5836, index=14, faction="Alliance", version=40000, versionUnder=60000, },
					{ id=5835, index=19, faction="Horde", version=60000, },
					{ id=5835, index=11, faction="Horde", version=40000, versionUnder=60000, }, },
					quests={ { id=13462, qType="Seasonal", }, },
					tip="Bouldercrag's Refuge. Quest phasing issues reported. Icon marks the entrance", },
	[99513771] = { candy=true, faction="Horde", quests={ { id=13548, qType="Seasonal", }, },
					achievements={ { id=5835, index=21, version=60000, },
					{ id=5835, index=16, version=40000, versionUnder=60000, }, }, tip="Grom'arsh Crash Site", },
}

ns.points[ 119 ] = { -- Sholazar Basin
	[26615920] = { candy=true, quests={ { id=12950, qType="Seasonal", }, },
					achievements={ { id=5836, index=17, faction="Alliance", version=60000, },
					{ id=5836, index=22, faction="Alliance", version=40000, versionUnder=60000, },
					{ id=5835, index=18, faction="Horde", version=60000, },
					{ id=5835, index=17, faction="Horde", version=40000, versionUnder=60000, }, }, tip="Nesingwary Base Camp", },
	[28159550] = { candy=true, faction="Horde", quests={ { id=13501, qType="Seasonal", }, }, tip="Bor'gorok Outpost",
					achievements={ { id=5835, index=1, version=60000, },
					{ id=5835, index=3, version=40000, versionUnder=60000, }, }, },
}

ns.points[ 120 ] = { -- The Storm Peaks
	[16049449] = { candy=true, faction="Alliance", versionUnder=60000, noContinent=true, achievements=ns.heroesWelcomeAch,
					quests=ns.heroesWelcomeQ, tip=ns.heroesWelcomeTip, },
	[16379405] = { candy=true, faction="Alliance", version=60000, noContinent=true, achievements=ns.heroesWelcomeAch,
					quests=ns.heroesWelcomeQ, tip=ns.heroesWelcomeTip, },
	[16049377] = { candy=true, noContinent=true, achievements=ns.cantripsAch, quests=ns.cantripsQ,
					tip=ns.cantripsTip, },
	[16719195] = { candy=true, versionUnder=60000, noContinent=true, achievements=ns.legerdemainAch, quests=ns.legerdemainQ,
					tip=ns.legerdemaintTip, },
	[16839232] = { candy=true, version=60000, noContinent=true, achievements=ns.legerdemainAch, quests=ns.legerdemainQ,
					tip=ns.legerdemaintTip, },
	[18889063] = { candy=true, faction="Horde", versionUnder=60000, noContinent=true, achievements=ns.filthyAch, quests=ns.filthyQ,
					tip=ns.filthyTip, },
	[18309143] = { candy=true, faction="Horde", version=60000, noContinent=true, achievements=ns.filthyAch, quests=ns.filthyQ,
					tip=ns.filthyTip, },
	[28727428] = { candy=true, faction="Alliance", achievements={ { id=5836, index=19, version=60000, },
					{ id=5836, index=5, version=40000, versionUnder=60000, }, }, quests={ { id=13448, qType="Seasonal", }, },
					tip="Frosthold", },
	[30583694] = { candy=true, uests={ { id=13462, qType="Seasonal", }, },
					achievements={ { id=5836, index=18, faction="Alliance", version=60000, },
					{ id=5836, index=14, faction="Alliance", version=40000, versionUnder=60000, },
					{ id=5835, index=19, faction="Horde", version=60000, },
					{ id=5835, index=11, faction="Horde", version=40000, versionUnder=60000, }, },
					tip="Bouldercrag's Refuge. Quest phasing issues reported. Icon marks the entrance", },
	[37094951] = { candy=true, faction="Horde", quests={ { id=13548, qType="Seasonal", }, },
					achievements={ { id=5835, index=21, version=60000, },
					{ id=5835, index=16, version=40000, versionUnder=60000, }, }, tip="Grom'arsh Crash Site", },
	[40938595] = ns.k3Set,
	[63029971] = ns.argentStrandSet,
	[67655069] = { candy=true, faction="Horde", quests={ { id=13471, qType="Seasonal", }, }, tip="Camp Tunka'lo",
					achievements={ { id=5835, index=20, version=60000, },
					{ id=5835, index=8, version=40000, versionUnder=60000, }, }, },
	[75999351] = { candy=true, achievements={ { id=5836, index=22, faction="Alliance", version=60000, },
					{ id=5836, index=4, faction="Alliance", version=40000, versionUnder=60000, },
					{ id=5835, index=24, faction="Horde", version=60000, },
					{ id=5835, index=10, faction="Horde", version=40000, versionUnder=60000, }, },
					quests={ { id=12940, qType="Seasonal", }, }, tip="Zim'Torga", },
}

ns.points[ 123 ] = { -- Wintergrasp
	[94919476] = { candy=true, version=40000, faction="Horde",
					achievements={ { id=5835, index=8, version=60000, }, tip="Agmar's Hammer",
					{ id=5835, index=23, version=40000, versionUnder=60000, }, }, quests={ { id=13469, qType="Seasonal", }, }, },
}

ns.points[ 121 ] = { -- Zul'Drak
	[09404645] = ns.k3Set,
	[40866604] = ns.argentStrandSet,
	[59335721] = { candy=true, achievements={ { id=5836, index=22, faction="Alliance", version=60000, },
					{ id=5836, index=4, faction="Alliance", version=40000, versionUnder=60000, },
					{ id=5835, index=24, faction="Horde", version=60000, },
					{ id=5835, index=10, faction="Horde", version=40000, versionUnder=60000, }, },
					quests={ { id=12940, qType="Seasonal", }, }, tip="Zim'Torga", },
	[72929235] = { candy=true, faction="Alliance", quests={ { id=12945, qType="Seasonal", }, },
					achievements={ { id=5836, index=12, version=60000, },
					{ id=5836, index=8, version=40000, versionUnder=60000, }, }, tip="Westfall Brigade", },
}

ns.points[ 113 ] = { -- Northrend
	[20008600] = { candy=true, version=40000, achievements={ { id=5836, faction="Alliance", showAllCriteria=true, },
					{ id=5835, faction="Horde", showAllCriteria=true, }, }, large=true, alwaysShow=true, noContinent=true,
					noCoords=true, },
	[91503320] = ns.setKal,
	[91503750] = ns.setMeta,
	[93704030] = ns.setDragon,
	[94003600] = ns.setFlavour,
	[94203200] = ns.setEasternK,
	[96303900] = ns.setCataPand,
	[96603480] = ns.setOutNorth,
}

--==================================================================================================================================
--
-- CATACLYSM / THE MAELSTROM / VASHJ'IR
--
--==================================================================================================================================

ns.points[ 207 ] = { -- Deepholm
	[47365171] = { candy=true, faction="Alliance", achievements={ { id=5837, index=1, version=60000, },
					{ id=5837, index=11, versionUnder=60000, }, },
					quests={ { id=29020, qType="Seasonal", }, }, tip="Temple of the Earth\n\n" ..ns.cataclysmPortals, },
	[51194990] = { candy=true, faction="Horde", achievements={ { id=5838, index=1, version=60000, },
					{ id=5838, index=9, versionUnder=60000, }, },
					quests={ { id=29019, qType="Seasonal", }, }, tip="Temple of the Earth\n\n" ..ns.cataclysmPortals, },
}
				
ns.points[ 198 ] = { -- Mount Hyjal
	[18633732] = { candy=true, tip="Grove of Aessina", achievements={ { id=5837, index=2, faction="Alliance", },
					{ id=5838, index=2, faction="Horde", }, }, quests={ { id=29000, qType="Seasonal", }, }, },
	[24100134] = { candy=true, faction="Alliance",
					achievements={ { id=963, index=10, version=60000, }, { id=963, index=24, versionUnder=60000, }, },
					quests={ { id=28995, qType="Seasonal", }, }, tip="Talonbranch Glade", },
	[42684572] = { candy=true, achievements={ { id=5837, index=4, faction="Alliance", version=60000, },
					{ id=5837, index=13, faction="Alliance", versionUnder=60000, },
					{ id=5838, index=4, faction="Horde", version=60000, },
					{ id=5838, index=1, faction="Horde", versionUnder=60000, }, },
					quests={ { id=29001, qType="Seasonal", }, }, tip="Shrine of Aviana", },
	[63052415] = { candy=true, achievements={ { id=5837, index=3, faction="Alliance", version=60000, },
					{ id=5837, index=10, faction="Alliance", versionUnder=60000, },
					{ id=5838, index=3, faction="Horde", version=60000, },
					{ id=5838, index=12, faction="Horde", versionUnder=60000, }, },
					quests={ { id=28999, qType="Seasonal", }, }, tip="Nordrassil", },
}

ns.points[ 241 ] = { -- Twilight Highlands
	[06823051] = { candy=true, faction="Alliance",
					achievements={ { id=966, index=26, version=60000, }, { id=966, index=17, versionUnder=60000, }, },
					quests={ { id=28991, qType="Seasonal", }, }, tip="Greenwarden's Grove\n\n" ..ns.raptorHatchling, },
	[10189172] = { candy=true, faction="Alliance", achievements={ { id=966, index=15, version=60000, }, -- Or 5, 6
					{ id=966, index=8, versionUnder=60000, }, }, quests={ { id=12339, qType="Seasonal", }, },
					tip="Thelsamar", }, -- Shared??
	[35039958] = { candy=true, faction="Alliance",
					achievements={ { id=966, index=14, version=60000, }, { id=966, index=22, versionUnder=60000, }, },
					quests={ { id=28963, qType="Seasonal", }, }, tip="Farstrider Lodge", }, 
	[43505727] = { candy=true, faction="Alliance", quests={ { id=28979, qType="Seasonal", }, }, tip="Victor's Point",
					achievements={ { id=5837, index=8, version=60000, }, { id=5837, index=1, versionUnder=60000, }, }, },
	[45117681] = { candy=true, faction="Horde",
					achievements={ { id=5838, index=6, version=60000, }, { id=5838, index=8, versionUnder=60000, }, },
					quests={ { id=28974, qType="Seasonal", }, }, tip="Crushblow. Inside the only building", },
	[49603036] = { candy=true, faction="Alliance",
					achievements={ { id=5837, index=7, version=60000, }, { id=5837, index=9, versionUnder=60000, }, },
					quests={ { id=28978, qType="Seasonal", }, }, tip="Thundermar. The building with the mailbox" },
	[53404284] = { candy=true, faction="Horde",
					achievements={ { id=5838, index=5, version=60000,}, { id=5838, index=11, versionUnder=60000, }, },
					quests={ { id=28973, qType="Seasonal", }, }, tip="Bloodgulch. Round floor, main building", },
	[60365825] = { candy=true, faction="Alliance",
					achievements={ { id=5837, index=5, version=60000, }, { id=5837, index=12, versionUnder=60000, }, },
					quests={ { id=28977, qType="Seasonal", }, }, tip="Firebeard's Patrol. The village is under attack but the "
						.."dwarves saved their blessed tavern. Priorities!" },
	[75411653] = { candy=true, faction="Horde",
					achievements={ { id=5838, index=7, version=60000, }, { id=5838, index=13, versionUnder=60000, }, },
					quests={ { id=28976, qType="Seasonal", }, }, tip="The Krazzworks. Difficult to describe - trust in the "
						.."coordinates please! Or, just look for the apple bobbing tub at the doorway!", },
	[75365492] = { candy=true, name=ns.candyBucket, faction="Horde", quests={ { id=28975, qType="Seasonal", }, },
					guide="Dragonmaw Port. To see the liberated version of Dragonmaw Port you must have completed the zone "
						.."storyline up to \"Returning to the Highlands\". The flight point becomes available then too.\n\n"
						.."NOT a Cataclysm T&T achievement bucket", },
	[78877780] = { candy=true, faction="Alliance", achievements={ { id=5837, index=6, }, },
					quests={ { id=28980, qType="Seasonal", }, }, tip="Highbank. Regardless of quest phase, you'll be okay for "
						.."the candy bucket.\n\nFrom the entrance head straight into the courtyard. Right then left" },
}

ns.points[ 249 ] = { -- Uldum
	[26580724] = { candy=true, achievements={ { id=5837, index=9, faction="Alliance", version=60000, },
					{ id=5837, index=14, faction="Alliance", versionUnder=60000, },
					{ id=5838, index=8, faction="Horde", version=60000, },
					{ id=5838, index=10, faction="Horde", versionUnder=60000, }, },
					quests={ { id=29016, qType="Seasonal", }, }, tip="Oasis of Vir'sar\n\n" ..ns.uldumPromo, },
	[54683301] = { candy=true, achievements={ { id=5837, index=10, faction="Alliance", version=60000, },
					{ id=5837, index=8, faction="Alliance", versionUnder=60000, },
					{ id=5838, index=9, faction="Horde", version=60000, },
					{ id=5838, index=7, faction="Horde", versionUnder=60000, }, },
					quests={ { id=29017, qType="Seasonal", }, }, tip="Ramkahen\n\n" ..ns.uldumPromo, },
}

ns.points[ 1527 ] = { -- Wrong Uldum
	[26580724] = { candy=true, achievements={ { id=5837, index=9, faction="Alliance", version=60000, },
					{ id=5837, index=14, faction="Alliance", versionUnder=60000, },
					{ id=5838, index=8, faction="Horde", version=60000, },
					{ id=5838, index=10, faction="Horde", versionUnder=60000, }, },
					quests={ { id=29016, qType="Seasonal", }, }, tip="Oasis of Vir'sar\n\n" ..ns.uldumPromo, },
	[54683301] = { candy=true, achievements={ { id=5837, index=10, faction="Alliance", version=60000, },
					{ id=5837, index=8, faction="Alliance", versionUnder=60000, },
					{ id=5838, index=9, faction="Horde", version=60000, },
					{ id=5838, index=7, faction="Horde", versionUnder=60000, }, },
					quests={ { id=29017, qType="Seasonal", }, }, tip="Ramkahen\n\n" ..ns.uldumPromo, },
}

ns.diveDown = "Dive straight down. The icon marks the entrance"
ns.diveDownDarkbreak = "Darkbreak Cove. " ..ns.diveDown .." The cave may appear empty, Give the art assets time to appear"

ns.points[ 204 ] = { -- Abyssal Depths in Vashj'ir
	[94867350] = { candy=true, faction="Horde", achievements={ { id=5838, index=11, version=60000, },
					{ id=5838, index=6, versionUnder=60000, }, }, quests={ { id=28984, qType="Seasonal", }, },
					tip="Legion's Rest. " ..ns.diveDown, },
	[60005670] = { candy=true, faction="Horde", tip="Tenebrous Cove. " ..ns.diveDown,
					achievements={ { id=5838, index=13, version=60000, }, { id=5838, index=3, versionUnder=60000, }, },
					quests={ { id=28986, qType="Seasonal", }, }, },
	[61897915] = { candy=true, faction="Alliance", quests={ { id=28985, qType="Seasonal", }, }, tip=ns.diveDownDarkbreak,
					achievements={ { id=5837, index=11, version=60000, }, { id=5837, index=4, versionUnder=60000, }, }, },
}

ns.points[ 201 ] = { -- Kelp'thar Forest in Vashj'ir
	[60686609] = { candy=true, achievements={ { id=5837, index=12, faction="Alliance", version=60000, }, 
					{ id=5837, index=3, faction="Alliance", versionUnder=60000, },
					{ id=5838, index=10, faction="Horde", version=60000, },
					{ id=5838, index=5, faction="Horde", versionUnder=60000, }, }, quests={ { id=28981, qType="Seasonal", }, },
					tip="Deepmist Grotto. " ..ns.diveDown, },
}

ns.points[ 205 ] = { -- Shimmering Expanse in Vashj'ir
	[20007114] = { candy=true, faction="Alliance", quests={ { id=28985, qType="Seasonal", }, }, tip=ns.diveDownDarkbreak,
					achievements={ { id=5837, index=11, version=60000, }, { id=5837, index=4, versionUnder=60000, }, }, },
	[68261539] = { candy=true, achievements={ { id=5837, index=12, faction="Alliance", version=60000, },
					{ id=5837, index=3, faction="Alliance", versionUnder=60000, },
					{ id=5838, index=10, faction="Horde", version=60000, },
					{ id=5838, index=5, faction="Horde", versionUnder=60000, }, }, quests={ { id=28981, qType="Seasonal", }, },
					tip="Deepmist Grotto. " ..ns.diveDown, },
	[51564154] = { candy=true, achievements={ { id=5837, index=13, faction="Alliance", version=60000, },
					{ id=5837, index=5, faction="Alliance", versionUnder=60000, },
					{ id=5838, index=12, faction="Horde", version=60000, },
					{ id=5838, index=4, faction="Horde", versionUnder=60000, }, }, quests={ { id=28982, qType="Seasonal", }, },
					tip="Silver Tide Hollow. " ..ns.diveDown, },
	[45025707] = { candy=true, faction="Alliance",
					achievements={ { id=5837, index=14, version=60000, }, { id=5837, index=7, versionUnder=60000, }, },
					quests={ { id=28983, qType="Seasonal", }, }, tip="Tranquil Wash. " ..ns.diveDown, },
	[47706640] = { candy=true, faction="Horde", achievements={ { id=5838, index=11, version=60000, },
					{ id=5838, index=6, versionUnder=60000, }, }, quests={ { id=28984, qType="Seasonal", }, },
					tip="Legion's Rest. " ..ns.diveDown, },
	[18415228] = { candy=true, faction="Horde",
					achievements={ { id=5838, index=13, version=60000, }, { id=5838, index=3, versionUnder=60000, }, },
					quests={ { id=28986, qType="Seasonal", }, }, tip="Tenebrous Cove. " ..ns.diveDown, },
}

ns.points[ 948 ] = { -- The Maelstrom
	[50002900] = { candy=true, faction="Alliance", tip=ns.templeOfEarth,
					achievements={ { id=5837, index=1, version=60000, }, { id=5837, index=11, versionUnder=60000, }, },
					quests={ { id=29020, qType="Seasonal", }, }, },
	[50002901] = { candy=true, faction="Horde", tip=ns.templeOfEarth, achievements={ { id=5838, index=1, version=60000, },
					{ id=5838, index=9, versionUnder=60000, }, }, quests={ { id=29019, qType="Seasonal", }, }, },
}

--==================================================================================================================================
--
-- MISTS OF PANDARIA
--
--==================================================================================================================================

ns.chunderInnSet = { candy=true, achievements={ { id=7601, index=12, faction="Alliance", },
					{ id=7602, index=14, faction="Horde", }, },
					quests={ { id=32039, qType="Seasonal", }, }, tip="Inside the Binan Brew and Chunder Inn at Binan Village", }
ns.goldenRoseSet = { candy=true, achievements={ { id=7601, index=19, faction="Alliance", },
					{ id=7602, index=21, faction="Horde", }, },
					quests={ { id=32044, qType="Seasonal", }, }, tip="Inside The Golden Rose inn at Mistfall Village", }
ns.grookinSet = { candy=true, faction="Horde", achievements={ { id=7602, index=5, }, }, quests={ { id=32028, qType="Seasonal", }, },
					tip="Grookin Hill\n\nThe candy bucket is present even if you have not yet made the Grookin friendly.\n\nBut "
					.."check the placement in the hut! Desperate to squeeze it in much?", }
ns.pangsSteadSet = { candy=true, achievements={ { id=7601, index=21, faction="Alliance", },
					{ id=7602, index=23, faction="Horde", }, },
					quests={ { id=32048, qType="Seasonal", }, }, tip="Pang's Stead", }
ns.stoneplowSet = { candy=true, achievements={ { id=7601, index=22, faction="Alliance", },
					{ id=7602, index=24, faction="Horde", }, },
					quests={ { id=32046, qType="Seasonal", }, }, tip="Inside The Stone Mug Tavern at Stoneplow", }
ns.wildsEdgeSet = { candy=true, achievements={ { id=7601, index=11, faction="Alliance", },
					{ id=7602, index=13, faction="Horde", }, },
					quests={ { id=32036, qType="Seasonal", }, }, tip="Inside the Wilds' Edge Inn at Zhu's Watch", }
ns.goldenLantern = "In the Golden Lantern inn, on the right side of the entrance"
ns.kunlaiTip = "Phasing issue here. Go to Binan Village. Complete \"Hit Medicine\", \"Call Out Their Leader\", \"All of the "
			.."Arrows\". Then complete "
ns.kunlaiTipA = ns.kunlaiTip .."\"Admiral Taylor...\". Then \"Westwind Rest\" by heading over towards Westwind. Finally complete "
			.."\"Challenge Accepted\" from Elder Tsulan. Voilà - unlocked!"
ns.kunlaiTipH = ns.kunlaiTip .."\"General Nazgrim...\". Then \"Eastwind Rest\" by heading over towards Eastwind. Finally complete "
			.."\"Challenge Accepted\" from Elder Shiao. Voilà - unlocked!"
ns.shrineOTM = "Shrine of Two Moons\n\nFrom the main entrance go up the stairs on the right side. Go through each room until you "
			.."arrive at the balcony / mezzanine of The Keggary."

ns.points[ 422 ] = { -- Dread Wastes
	[55217120] = { candy=true, achievements={ { id=7601, index=2, faction="Alliance", }, { id=7602, index=2, faction="Horde", }, },
					quests={ { id=32023, qType="Seasonal", }, }, tip="Inside The Chum Bucket Inn at Soggy's Gamble", },
	[55933227] = { candy=true, achievements={ { id=7601, index=1, faction="Alliance", }, { id=7602, index=1, faction="Horde", }, },
					quests={ { id=32024, qType="Seasonal", }, }, tip="Klaxxi'vess", },
	[79234989] = ns.stoneplowSet,
	[84388721] = { candy=true, faction="Horde", achievements={ { id=7602, index=10, }, },
					quests={ { id=32020, qType="Seasonal", }, }, tip="Dawnchaser Retreat", },
	[84982190] = ns.goldenRoseSet,
}

ns.points[ 418 ] = { -- Krasarang Wilds
	[22370811] = ns.stoneplowSet,
	[28255074] = { candy=true, faction="Horde", achievements={ { id=7602, index=10, }, },
					quests={ { id=32020, qType="Seasonal", }, }, tip="Dawnchaser Retreat", },
	[51407729] = { candy=true, achievements={ { id=7601, index=10, faction="Alliance", },
					{ id=7602, index=11, faction="Horde", }, },
					quests={ { id=32034, qType="Seasonal", }, }, tip="Inside the \"Bait and Brew\" at Marista", },
	[61152504] = { candy=true, faction="Horde", achievements={ { id=7602, index=12, }, },
					quests={ { id=32047, qType="Seasonal", }, }, tip="Thunder Cleft", },
	[75920687] = ns.wildsEdgeSet,
	[98660525] = { candy=true, faction="Alliance", achievements={ { id=7601, index=6, }, },
					quests={ { id=32049, qType="Seasonal", }, }, tip="Paw'don Village", },
}

ns.points[ 379 ] = { -- Kun-Lai Summit
	[29507843] = { candy=true, tip="Longying Outpost", achievements={ { id=7601, index=18, faction="Alliance", },
					{ id=7602, index=20, faction="Horde", }, }, quests={ { id=32043, qType="Seasonal", }, }, },
	[54078282] = { candy=true, faction="Alliance", achievements={ { id=7601, index=15, }, },
					quests={ { id=32042, qType="Seasonal", }, }, tip="Westwind Rest\n\n" ..ns.kunlaiTipA, },
	[57455995] = { candy=true, achievements={ { id=7601, index=14, faction="Alliance", },
					{ id=7602, index=17, faction="Horde", }, }, quests={ { id=32037, qType="Seasonal", }, },
					tip="Inside The Lucky Traveller at One Keg", },
	[62502890] = { candy=true, achievements={ { id=7601, index=16, faction="Alliance", },
					{ id=7602, index=18, faction="Horde", }, }, quests={ { id=32051, qType="Seasonal", }, },
					tip="Inside the North Wind Tavern at Zouchin Village. Right near the Flight Master", },
	[54078282] = { candy=true, faction="Horde", achievements={ { id=7602, index=15, }, },
					quests={ { id=32040, qType="Seasonal", }, }, tip="Eastwind Rest\n\n" ..ns.kunlaiTipH, },
	[62779454] = { candy=true, faction="Horde", achievements={ { id=7602, index=22, }, },
					quests={ { id=32022, qType="Seasonal", }, }, tip="Shrine of Two Moons", },
	[64216127] = { candy=true, achievements={ { id=7601, index=13, faction="Alliance", },
					{ id=7602, index=16, faction="Horde", }, },
					quests={ { id=32041, qType="Seasonal", }, }, tip="Inside The Two Fisted Brew at The Grummle Bazaar", },
	[72739228] = ns.chunderInnSet,
}

ns.points[ 393 ] = { -- Shrine of the Seven Stars
	[37876584] = { candy=true, faction="Alliance", achievements={ { id=7601, index=20, }, },
					quests={ { id=32052, qType="Seasonal", }, }, tip=ns.goldenLantern, },
}

ns.points[ 392 ] = { -- The Imperial Mercantile
	[58907831] = { candy=true, faction="Horde", achievements={ { id=7602, index=22, }, },
					quests={ { id=32022, qType="Seasonal", }, }, tip=ns.shrineOTM, },
}

ns.points[ 371 ] = { -- The Jade Forest
	[02981149] = { candy=true, achievements={ { id=7601, index=14, faction="Alliance", },
					{ id=7602, index=17, faction="Horde", }, }, quests={ { id=32037, qType="Seasonal", }, },
					tip="Inside The Lucky Traveller at One Keg", },
	[07752992] = { candy=true, faction="Horde", achievements={ { id=7602, index=15, }, },
					quests={ { id=32040, qType="Seasonal", }, }, tip="Eastwind Rest\n\n" ..ns.kunlaiTipH, },
	[07754251] = { candy=true, faction="Horde", achievements={ { id=7602, index=22, }, },
					quests={ { id=32022, qType="Seasonal", }, }, tip="Shrine of Two Moons", },
	[09041268] = { candy=true, achievements={ { id=7601, index=13, faction="Alliance", },
					{ id=7602, index=16, faction="Horde", }, },
					quests={ { id=32041, qType="Seasonal", }, }, tip="Inside The Two Fisted Brew at The Grummle Bazaar", },
	[16674048] = ns.chunderInnSet,
	[16836159] = { candy=true, faction="Alliance", achievements={ { id=7601, index=20, }, },
					quests={ { id=32052, qType="Seasonal", }, }, tip=ns.goldenLantern, },
	[23326073] = { candy=true, tip="Tavern in the Mists", achievements={ { id=7601, index=17, faction="Alliance", },
					{ id=7602, index=19, faction="Horde", }, }, quests={ { id=32026, qType="Seasonal", }, }, },
	[28024739] = ns.grookinSet,
	[28451327] = { candy=true, faction="Alliance", achievements={ { id=7601, index=6, }, },
					quests={ { id=32050, qType="Seasonal", }, }, tip="Honeydew Village", },
	[29446625] = ns.pangsSteadSet,
	[29548546] = ns.wildsEdgeSet,
	[41682314] = { candy=true, achievements={ { id=7601, index=9, faction="Alliance", }, { id=7602, index=9, faction="Horde", }, },
					quests={ { id=32021, qType="Seasonal", }, }, tip="Inside Paur's Pub at Tian Monastery", },
	[44818437] = { candy=true, faction="Alliance", achievements={ { id=7601, index=6, }, },
					quests={ { id=32049, qType="Seasonal", }, }, tip="Paw'don Village", },
	[45774360] = { candy=true, achievements={ { id=7601, index=3, faction="Alliance", }, { id=7602, index=3, faction="Horde", }, },
					quests={ { id=32027, qType="Seasonal", }, }, tip="Inside The Drunken Hozen Inn at Dawn's Blossom", },
	[48093462] = { candy=true, achievements={ { id=7601, index=4, faction="Alliance", }, { id=7602, index=4, faction="Horde", }, },
					quests={ { id=32029, qType="Seasonal", }, }, tip="Greenstone Village", },
	[54606333] = { candy=true, achievements={ { id=7601, index=5, faction="Alliance", }, { id=7602, index=7, faction="Horde", }, },
					quests={ { id=32032, qType="Seasonal", }, }, tip="Inside The Dancing Serpent Inn at the Jade Temple Grounds", },
	[55712441] = { candy=true, achievements={ { id=7601, index=8, faction="Alliance", }, { id=7602, index=8, faction="Horde", }, },
					quests={ { id=32031, qType="Seasonal", }, }, tip="Inside the inn at Sri-La Village", },
	[59568324] = { candy=true, faction="Alliance", achievements={ { id=7601, index=7, }, },
					quests={ { id=32033, qType="Seasonal", }, }, tip="Pearlfin Village", },
}

ns.points[ 433 ] = { -- The Veiled Stair
	[29887560] = { candy=true, faction="Alliance", achievements={ { id=7601, index=20, }, },
					quests={ { id=32052, qType="Seasonal", }, }, tip=ns.goldenLantern, },
	[55117224] = { candy=true, achievements={ { id=7601, index=17, faction="Alliance", },
					{ id=7602, index=19, faction="Horde", }, },
					quests={ { id=32026, qType="Seasonal", }, }, tip="Inside the Tavern in the Mists", },
	[73412031] = ns.grookinSet,
	[78969372] = ns.pangsSteadSet,
}

ns.points[ 388 ] = { -- Townlong Steppes, Longying Outpost
	[71145777] = { candy=true, tip="Longying Outpost", achievements={ { id=7601, index=18, faction="Alliance", },
					{ id=7602, index=20, faction="Horde", }, }, quests={ { id=32043, qType="Seasonal", }, }, },
	[97916256] = { candy=true, faction="Alliance", achievements={ { id=7601, index=15, }, },
					quests={ { id=32042, qType="Seasonal", }, }, tip="Westwind Rest\n\n" ..ns.kunlaiTipA, },
}

ns.points[ 390 ] = { -- Vale of Eternal Blossoms
	[35147778] = ns.goldenRoseSet,
	[61991626] = { candy=true, faction="Horde", achievements={ { id=7602, index=22, }, },
					quests={ { id=32022, qType="Seasonal", }, }, tip=ns.shrineOTM, },
	[87036888] = { candy=true, faction="Alliance", achievements={ { id=7601, index=20, }, },
					quests={ { id=32052, qType="Seasonal", }, }, tip=ns.goldenLantern, },
	[86581066] = ns.chunderInnSet,
}

ns.points[ 376 ] = { -- Valley of the Four Winds
	[19875578] = ns.stoneplowSet,
	[27721760] = ns.goldenRoseSet,
	[61211186] = { candy=true, faction="Alliance", achievements={ { id=7601, index=20, }, },
					quests={ { id=32052, qType="Seasonal", }, }, tip=ns.goldenLantern, },
	[72751032] = { candy=true, tip="Tavern in the Mists", achievements={ { id=7601, index=17, faction="Alliance", },
					{ id=7602, index=19, faction="Horde", }, }, quests={ { id=32026, qType="Seasonal", }, }, },
	[83642014] = ns.pangsSteadSet,
	[83835431] = ns.wildsEdgeSet,
}

ns.points[ 424 ] = { -- Pandaria
	[70008900] = { candy=true, version=40000, achievements={ { id=7601, faction="Alliance", showAllCriteria=true, }, -- Pandaria
					{ id=7602, faction="Horde", showAllCriteria=true, }, }, large=true, alwaysShow=true, noContinent=true,
					noCoords=true, },
	[91503320] = ns.setKal,
	[91503750] = ns.setMeta,
	[93704030] = ns.setDragon,
	[94003600] = ns.setFlavour,
	[94203200] = ns.setEasternK,
	[96303900] = ns.setCataPand,
	[96603480] = ns.setOutNorth,
}

--==================================================================================================================================
--
-- WARLORDS OF DRAENOR / GARRISON
--
--==================================================================================================================================

ns.dailiesSet = { { id=39721, name="Culling the Crew", qType="Daily", },
						{ id=39720, name="Foul Fertilizer", qType="Daily", },
						{ id=39719, name="Mutiny on the Boneship", qType="Daily", },
						{ id=39716, name="Smashing Squashlings", qType="Daily", }, }
ns.draenorS = "You must have a Tier 3 Town Hall or else the Candy Bucket will not be present."
ns.draenorD = "Orukan has four dailies and Izzy Hollyfizzle sells Garrison decorations, purchasable only with the daily rewards. A "
			.."Tier 3 Town Hall is required for these NPCs to appear"
ns.getSpooky = "Get Spooky - Garrison Mission"
ns.getSpookyTip = "Rarely and randomly occurs. Rewards 15 candy!"
ns.spookyPepe = "Sitting on the largest gravestone"
ns.wrongPepe = "Pepe seen on a branch here. It's the WRONG pepe"

ns.points[ 582 ] = { -- Lunarfall Garrison in Draenor
	[40276963] = { name="Spooky Pepe", version=60202, faction="Alliance", achievements={ { id=10365, }, }, tip=ns.spookyPepe, },
	[43515151] = { candy=true, name=ns.candyBucket, version=60202, faction="Alliance", quests={ { id=39657, qType="Seasonal", }, },
					tip=ns.draenorS, },
	[44405180] = { name="Garrison Dailies", version=60202, faction="Alliance", quests=ns.dailiesSet, tip=ns.draenorD, },
	[48904540] = { name="Spooky Pepe", version=60202, faction="Alliance", achievements={ { id=10365, }, }, tip=ns.wrongPepe, },
	[29003440] = { name=ns.getSpooky, version=80200, faction="Alliance", tip=ns.getSpookyTip, },
}
ns.points[ 539 ] = { -- Shadowmoon Valley in Draenor
	[29741983] = { name="Spooky Pepe", version=60202, faction="Alliance", achievements={ { id=10365, }, }, tip=ns.spookyPepe, },	
	[30011780] = { candy=true, name=ns.candyBucket, version=60202, faction="Alliance", quests={ { id=39657, qType="Seasonal", }, },
					tip=ns.draenorS, },
	[30251805] = { name="Garrison Dailies", version=60202, faction="Alliance", quests=ns.dailiesSet, tip=ns.draenorD, },
	[28701600] = { name=ns.getSpooky, version=80200, faction="Alliance", tip=ns.getSpookyTip, },
}
ns.points[ 590 ] = { -- Frostwall Garrison in Draenor
	[41654497] = { name="Spooky Pepe", version=60202, faction="Horde", achievements={ { id=10365, }, }, tip=ns.wrongPepe, },
	[46993759] = { candy=true, name=ns.candyBucket, version=60202, faction="Horde", quests={ { id=39657, qType="Seasonal", }, },
					tip=ns.draenorS, },
	[47903790] = { name="Garrison Dailies", version=60202, faction="Horde", quests=ns.dailiesSet, tip=ns.draenorD, },
	[41005300] = { name=ns.getSpooky, version=80200, faction="Horde", tip=ns.getSpookyTip, },
	[70768989] = { name="Spooky Pepe", version=60202, faction="Horde", achievements={ { id=10365, }, }, tip=ns.spookyPepe, },	
}
ns.points[ 525 ] = { -- Frostfire Ridge in Draenor
	[48256435] = { candy=true, name=ns.candyBucket, version=60202, faction="Horde", quests={ { id=39657, qType="Seasonal", }, },
					tip=ns.draenorS, },
	[48506460] = { name="Garrison Dailies", version=60202, faction="Horde", quests=ns.dailiesSet, tip=ns.draenorD, },
	[46006800] = { name=ns.getSpooky, version=80200, faction="Horde", tip=ns.getSpookyTip, },
	[50897046] = { name="Spooky Pepe", version=60202, faction="Horde", achievements={ { id=10365, }, }, tip=ns.spookyPepe, },	
}

ns.points[ 572 ] = { -- Draenor
	[91503320] = ns.setKal,
	[91503750] = ns.setMeta,
	[93704030] = ns.setDragon,
	[94003600] = ns.setFlavour,
	[94203200] = ns.setEasternK,
	[96303900] = ns.setCataPand,
	[96603480] = ns.setOutNorth,
}

--==================================================================================================================================
--
-- LEGION / BROKEN ISLES
--
--==================================================================================================================================

ns.points[ 501 ] = { -- The Situation in Dalaran
	[48144132] = ns.legerdemainSet, -- Same object and quest ID so has to count for the Northrend achievement surely?
}

ns.points[ 627 ] = { -- Dalaran Broken Isles
	[41476398] = { candy=true, name=ns.candyBucket, faction="Alliance", quests={ { id=43056, qType="Seasonal", }, },
					tip="In \"A Hero's Welcome\" inn", },
	[47964178] = { candy=true, name=ns.candyBucket, quests={ { id=43055, qType="Seasonal", }, },
					tip="In The Legerdemain Lounge", },
	[47294077] = { version=70000, quests={ { id=43259, name="Beware of the Crooked Tree", qType="Seasonal", }, },
					guide="Speak to Duroc Ironjaw.\n\n This is a simple \"fly to X\" quest but with very worthwhile XP, especially "
						.."for a trivial flight. Location in Val'sharah is marked on your map.\n\nThe quest that follows is "
						.."devilishly difficult and is not recommended. Just hearth/fly back to Dalaran", },
	[67042941] = { candy=true, name=ns.candyBucket, faction="Horde", quests={ { id=43057, qType="Seasonal", }, },
					tip="In \"The Filthy Animal\" inn", },
	[59174564] = { achievements={ { id=291, }, },  tip="Just stand here with a cuppa and wait. Couldn't be easier", },
}

ns.points[ 641 ] = { -- Val'sharah 								**** 1188? ****
	[35005600] = { version=70000, quests={ { id=43162, name="Under the Crooked Tree", qType="Daily", }, },
					guide="Speak to the Hag.\n\nSoloing at the intended level is devilishly difficult and is not recommended. "
						.."Just hearth/fly back to Dalaran if you're under levelled.\n\nIf lucky, the Hag will drop one of four "
						.."possible cosmetic hats, known in the community as the \"Sister Hats\". This is what all the fuss is "
						.."about!", },
}

ns.points[ 619 ] = { -- Broken Isles
	[91503320] = ns.setKal,
	[91503750] = ns.setMeta,
	[93704030] = ns.setDragon,
	[94003600] = ns.setFlavour,
	[94203200] = ns.setEasternK,
	[96303900] = ns.setCataPand,
	[96603480] = ns.setOutNorth,
}

--==================================================================================================================================
--
-- BATTLE FOR AZEROTH / KUL TIRAS & ZANDALAR
--
--==================================================================================================================================

ns.points[ 1163 ] = { -- Dazar'alor - The Great Seal
	[49828478] = { candy=true, name=ns.candyBucket, faction="Horde", quests={ { id=54709, qType="Seasonal", }, },
					tip="In \"The Great Seal\"", },
}
ns.points[ 1164 ] = { -- Dazar'alor - The Hall of Chroniclers
	[49828478] = { candy=true, name=ns.candyBucket, faction="Horde", quests={ { id=54709, qType="Seasonal", }, },
					tip="In \"The Great Seal\"", },
}
ns.points[ 1165 ] = { -- Dazar'alor
	[50014684] = { candy=true, name=ns.candyBucket, faction="Horde", quests={ { id=54709, qType="Seasonal", }, },
					tip="In \"The Great Seal\"", },
}
ns.points[ 862 ] = { -- Zuldazar
	[57984468] = { candy=true, name=ns.candyBucket, faction="Horde", quests={ { id=54709, qType="Seasonal", }, },
					tip="In \"The Great Seal\"", },
}
ns.points[ 1161 ] = { -- Boralus - Tiragarde Sound
	[73701219] = { candy=true, name=ns.candyBucket, faction="Alliance", quests={ { id=54710, qType="Seasonal", }, },
					tip="In the \"Snug Harbor Inn\"", },
}
ns.points[ 895 ] = { -- Tiragarde Sound
	[75182272] = { candy=true, name=ns.candyBucket, faction="Alliance", quests={ { id=54710, qType="Seasonal", }, },
					tip="In the \"Snug Harbor Inn\"", },
}


ns.points[ 876 ] = { -- Kul Tiras
	[91503320] = ns.setKal,
	[91503750] = ns.setMeta,
	[93704030] = ns.setDragon,
	[94003600] = ns.setFlavour,
	[94203200] = ns.setEasternK,
	[96303900] = ns.setCataPand,
	[96603480] = ns.setOutNorth,
}

ns.points[ 875 ] = { -- Zandalar
	[91503320] = ns.setKal,
	[91503750] = ns.setMeta,
	[93704030] = ns.setDragon,
	[94003600] = ns.setFlavour,
	[94203200] = ns.setEasternK,
	[96303900] = ns.setCataPand,
	[96603480] = ns.setOutNorth,
}

--==================================================================================================================================
--
-- SHADOWLANDS
--
--==================================================================================================================================

ns.points[ 1550 ] = { -- Shadowlands
	[91503320] = ns.setKal,
	[91503750] = ns.setMeta,
	[93704030] = ns.setDragon,
	[94003600] = ns.setFlavour,
	[94203200] = ns.setEasternK,
	[96303900] = ns.setCataPand,
	[96603480] = ns.setOutNorth,
}

--==================================================================================================================================
--
-- DRAGONFLIGHT / DRAGON ISLES
--
--==================================================================================================================================

ns.points[ 2023 ] = { -- Ohn'ahran Plains
	[46224060] = { candy=true, achievements={ { id=18360, index=1, }, }, 
					quests={ { id=75684, qType="Seasonal", }, }, tip="Bloodhoof Outpost", },
	[66252453] = { candy=true, achievements={ { id=18360, index=2, }, },
					quests={ { id=75693, qType="Seasonal", }, }, tip="Emberwatch", },
	[72138039] = { candy=true, achievements={ { id=18360, index=3, }, },
					quests={ { id=75692, qType="Seasonal", }, }, tip="Forkriver Crossing", },
	[62934056] = { candy=true, achievements={ { id=18360, index=4, }, },
					quests={ { id=75685, qType="Seasonal", }, }, tip="Maruukaï", },
	[57147672] = { candy=true, achievements={ { id=18360, index=5, }, },
					quests={ { id=75687, qType="Seasonal", }, }, tip="Ohn'iri Springs", },
	[81295920] = { candy=true, achievements={ { id=18360, index=6, }, },
					quests={ { id=75688, qType="Seasonal", }, }, tip="Pinewood Post", },
	[85843536] = { candy=true, achievements={ { id=18360, index=7, }, },
					quests={ { id=75689, qType="Seasonal", }, }, tip="Rusza'thar Reach", },
	[28646056] = { candy=true, achievements={ { id=18360, index=8, }, },
					quests={ { id=75686, qType="Seasonal", }, }, tip="Shady Sanctuary", },
	[41916044] = { candy=true, achievements={ { id=18360, index=9, }, },
					quests={ { id=75691, qType="Seasonal", }, }, tip="Teerakaï", },
	[85042603] = { candy=true, achievements={ { id=18360, index=10, }, },
					quests={ { id=75690, qType="Seasonal", }, }, tip="Timberstep Outpost", },
}

ns.points[ 2025 ] = { -- Thaldraszus
	[44891063] = { candy=true, achievements={ { id=18360, index=34, }, },
					quests={ { id=75683, qType="Seasonal", }, }, tip="Wingrest Embassy", },
	[48910791] = { candy=true, faction="Alliance", achievements={ { id=18360, index=33, }, },
					quests={ { id=75681, qType="Seasonal", }, }, tip="Wild Coast", },
	[50084273] = { candy=true, achievements={ { id=18360, index=11, }, },
					quests={ { id=75698, qType="Seasonal", }, }, tip="Algeth'era Court", },
	[35087920] = { candy=true, achievements={ { id=18360, index=12, }, },
					quests={ { id=75696, qType="Seasonal", }, }, tip="Garden Shrine", },
	[52416981] = { candy=true, achievements={ { id=18360, index=13, }, },
					quests={ { id=75697, qType="Seasonal", }, }, tip="Gelikyr Post", },
	[59858269] = { candy=true, achievements={ { id=18360, index=14, }, },
					quests={ { id=75695, qType="Seasonal", }, }, tip="Temporal Conflux", },
	[43175940] = { candy=true, achievements={ { id=18360, index=15, }, },
					quests={ { id=75700, qType="Seasonal", }, }, tip="Valdrakken. The Parting Glass", },
	[39525922] = { candy=true, achievements={ { id=18360, index=16, }, },
					quests={ { id=75699, qType="Seasonal", }, }, tip="Valdrakken. The Roasted Ram", },
	[35955711] = { candy=true, achievements={ { id=18360, index=17, }, },
					quests={ { id=75701, qType="Seasonal", }, }, tip="Valdrakken. Weyrnrest", },
}

ns.points[ 2024 ] = { -- The Azure Span
	[47034026] = { candy=true, achievements={ { id=18360, index=18, }, },
					quests={ { id=75667, qType="Seasonal", }, }, tip="Camp Antonidas", },
	[62785773] = { candy=true, achievements={ { id=18360, index=19, }, },
					quests={ { id=75668, qType="Seasonal", }, }, tip="Camp Nowhere", },
	[12384933] = { candy=true, achievements={ { id=18360, index=20, }, },
					quests={ { id=75669, qType="Seasonal", }, }, tip="Iskaara", },
	[65501625] = { candy=true, achievements={ { id=18360, index=21, }, },
					quests={ { id=75670, qType="Seasonal", }, }, tip="Theron's Watch", },
	[18812455] = { candy=true, achievements={ { id=18360, index=22, }, },
					quests={ { id=75671, qType="Seasonal", }, }, tip="Three-Falls Lookout", },
}

ns.points[ 2151 ] = { -- The Forbidden Reach
	[33845881] = { candy=true, achievements={ { id=18360, index=23, }, },
					quests={ { id=75702, qType="Seasonal", }, }, tip="Morqut Village", },
}

ns.points[ 2022 ] = { -- The Waking Shores
	[24468210] = { candy=true, achievements={ { id=18360, index=24, }, },
					quests={ { id=75672, qType="Seasonal", }, }, tip="Apex Observatory", },
	[47678330] = { candy=true, achievements={ { id=18360, index=25, }, },
					quests={ { id=75673, qType="Seasonal", }, }, tip="Dragonscale Basecamp", },
	[65225793] = { candy=true, achievements={ { id=18360, index=26, }, },
					quests={ { id=75675, qType="Seasonal", }, }, tip="Life Vault Ruins", },
	[43106666] = { candy=true, achievements={ { id=18360, index=27, }, },
					quests={ { id=77698, qType="Seasonal", }, }, tip="Obsidian Bulwark", },
	[25775518] = { candy=true, achievements={ { id=18360, index=28, }, },
					quests={ { id=75676, qType="Seasonal", }, }, tip="Obsidian Throne", },
	[58036731] = { candy=true, achievements={ { id=18360, index=29, }, },
					quests={ { id=75674, qType="Seasonal", }, }, tip="Ruby Lifeshrine", },
	[76075475] = { candy=true, achievements={ { id=18360, index=30, }, },
					quests={ { id=75677, qType="Seasonal", }, }, tip="Skytop Observatory", },
	[53913903] = { candy=true, achievements={ { id=18360, index=31, }, },
					quests={ { id=75678, qType="Seasonal", }, }, tip="Uktulut Backwater", },
	[46432740] = { candy=true, achievements={ { id=18360, index=32, }, },
					quests={ { id=75679, qType="Seasonal", }, }, tip="Uktulut Pier", },
	[80422788] = { candy=true, faction="Horde", achievements={ { id=18360, indexH=33, }, },
					quests={ { id=75682, qType="Seasonal", }, }, tip="Wild Coast", },
	[81313196] = { candy=true, faction="Alliance", achievements={ { id=18360, indexA=33, }, },
					quests={ { id=75681, qType="Seasonal", }, }, tip="Wild Coast", },
	[76213541] = { candy=true, achievements={ { id=18360, index=34, }, },
					quests={ { id=75683, qType="Seasonal", }, }, tip="Wingrest Embassy", },
}

ns.points[ 2112 ] = { -- Valdrakken
	[72374667] = { candy=true, achievements={ { id=18360, index=15, }, },
					quests={ { id=75700, qType="Seasonal", }, }, tip="The Parting Glass", },
	[47134542] = { candy=true, achievements={ { id=18360, index=16, }, },
					quests={ { id=75699, qType="Seasonal", }, }, tip="The Roasted Ram", },
	[22363084] = { candy=true, achievements={ { id=18360, index=17, }, },
					quests={ { id=75701, qType="Seasonal", }, }, tip="Weyrnrest", },
}

ns.points[ 2133 ] = { -- Zaralek Cavern
	[56375636] = { candy=true, achievements={ { id=18360, index=35, }, },
					quests={ { id=75704, qType="Seasonal", }, }, tip="Loamm", },
	[52122647] = { candy=true, achievements={ { id=18360, index=36, }, },
					quests={ { id=75703, qType="Seasonal", }, }, tip="Obsidian Rest", },
}

ns.points[ 1978 ] = { -- Dragon Isles
	[82003000] = { candy=true, version=40000, achievements={ { id=18360, showAllCriteria=true, }, }, large=true, alwaysShow=true,
					noContinent=true, noCoords=true, },
	[91503320] = ns.setKal,
	[91503750] = ns.setMeta,
	[93704030] = ns.setDragon,
	[94003600] = ns.setFlavour,
	[94203200] = ns.setEasternK,
	[96303900] = ns.setCataPand,
	[96603480] = ns.setOutNorth,
}

--==================================================================================================================================
--
-- KHAZ ALGAR / THE WAR WITHIN
--
--==================================================================================================================================

ns.points[ 2255 ] = { -- Azj-Kahet
	[44846627] = { candy=true, achievements={ { id=40862, index=4, }, }, noContinent=true,
					quests={ { id=84581, qType="Seasonal", }, }, tip="Wildcamp Ul'ar", },
	[48627270] = { candy=true, achievements={ { id=40862, index=6, }, }, noContinent=true,
					quests={ { id=84578, qType="Seasonal", }, }, tip="Umbral Bazzar", },
	[51287838] = { candy=true, achievements={ { id=40862, index=7, }, }, noContinent=true,
					quests={ { id=84577, qType="Seasonal", }, }, tip="Lower, The Burrows", },
	[52797926] = { candy=true, achievements={ { id=40862, index=5, }, }, noContinent=true,
					quests={ { id=84576, qType="Seasonal", }, }, tip="High Hollows", },
	[56853899] = { candy=true, achievements={ { id=40862, index=3, }, }, noContinent=true,
					quests={ { id=84582, qType="Seasonal", }, }, tip="Weaver's Lair", },
	[58961862] = { candy=true, achievements={ { id=40862, index=1, }, }, noContinent=true,
					quests={ { id=84579, qType="Seasonal", }, }, tip="Faerin's Advance", },
	[77966280] = { candy=true, achievements={ { id=40862, index=2, }, }, noContinent=true,
					quests={ { id=84580, qType="Seasonal", }, }, tip="Mmarl", },
}

ns.points[ 2216 ] = { -- City of Threads / Azj-Kahet - Lower
	[57423847] = { candy=true, achievements={ { id=40862, index=7, }, }, noContinent=true,
					quests={ { id=84577, qType="Seasonal", }, }, tip="Lower, The Burrows", },
}

ns.points[ 2213 ] = { -- City of Threads / Azj-Kahet
	[57423847] = { candy=true, achievements={ { id=40862, index=7, }, }, noContinent=true,
					quests={ { id=84577, qType="Seasonal", }, }, tip="Lower, The Burrows", },
	[49752227] = { candy=true, achievements={ { id=40862, index=6, }, }, noContinent=true,
					quests={ { id=84578, qType="Seasonal", }, }, tip="Umbral Bazzar", },
	[62084138] = { candy=true, achievements={ { id=40862, index=5, }, }, noContinent=true,
					quests={ { id=84576, qType="Seasonal", }, }, tip="High Hollows", },
}

ns.points[ 2339 ] = { -- Dornogal City
	[45014735] = { candy=true, achievements={ { id=40862, index=12, }, },
					quests={ { id=84564, qType="Seasonal", }, }, tip="Dornogal City", },
}

ns.points[ 2215 ] = { -- Hallowfall
	[40586798] = { candy=true, achievements={ { id=40862, index=9, }, }, noContinent=true,
					quests={ { id=84574, qType="Seasonal", }, }, tip="Light's Redoubt", },
	[42765571] = { candy=true, achievements={ { id=40862, index=11, }, }, noContinent=true,
					quests={ { id=84575, qType="Seasonal", }, }, tip="Mereldar", },
	[49133954] = { candy=true, achievements={ { id=40862, index=10, }, }, noContinent=true,
					quests={ { id=84573, qType="Seasonal", }, }, tip="Lorel's Crossing", },
	[69064570] = { candy=true, achievements={ { id=40862, index=8, }, }, noContinent=true,
					quests={ { id=84572, qType="Seasonal", }, }, tip="Dunelle's Kindness", },
}

ns.points[ 2248 ] = { -- Isle of Dorn
	[42007439] = { candy=true, achievements={ { id=40862, index=13, }, },
					quests={ { id=84566, qType="Seasonal", }, }, tip="Freywold Village", },
	[48434386] = { candy=true, achievements={ { id=40862, index=12, }, },
					quests={ { id=84564, qType="Seasonal", }, }, tip="Dornogal City", },
	[58172713] = { candy=true, achievements={ { id=40862, index=14, }, },
					quests={ { id=84567, qType="Seasonal", }, }, tip="Rambleshire", },
}

ns.points[ 2214 ] = { -- The Ringing Deeps
	[47883211] = { candy=true, achievements={ { id=40862, index=16, }, }, noContinent=true,
					quests={ { id=84569, qType="Seasonal", }, }, tip="Gundargaz", },
	[59456409] = { candy=true, achievements={ { id=40862, index=15, }, }, noContinent=true,
					quests={ { id=84568, qType="Seasonal", }, }, tip="Camp Murroch", },
	[61854626] = { candy=true, achievements={ { id=40862, index=18, }, }, noContinent=true,
					quests={ { id=84571, qType="Seasonal", }, }, tip="Shadowvein Point", },
	[63407897] = { candy=true, achievements={ { id=40862, index=17, }, }, noContinent=true,
					quests={ { id=84570, qType="Seasonal", }, }, tip="Opportunity Point", },
}

ns.points[ 2274 ] = { -- Khaz Algar
	[10008400] = { candy=true, achievements={ { id=40862, showAllCriteria=true, }, }, large=true, -- Khaz Algar
					alwaysShow=true, noContinent=true, noCoords=true, },
	[91503320] = ns.setKal,
	[91503750] = ns.setMeta,
	[93704030] = ns.setDragon,
	[94003600] = ns.setFlavour,
	[94203200] = ns.setEasternK,
	[96303900] = ns.setCataPand,
	[96603480] = ns.setOutNorth,
}

--==================================================================================================================================
--
-- WORLD / OTHER
--
--==================================================================================================================================

ns.points[ 947 ] = { -- Azeroth
	[05506700] = { candy=true, version=100000, achievements={ { id=963, faction="Alliance", showAllCriteria=true, }, -- Kalimdor
					{ id=965, faction="Horde", showAllCriteria=true, }, }, large=true, alwaysShow=true, noCoords=true, },
	[06007600] = { candy=true, versionUnder=100000, achievements={ { id=963, faction="Alliance", showAllCriteria=true, },
					{ id=965, faction="Horde", showAllCriteria=true, }, }, large=true, alwaysShow=true, noCoords=true, }, -- Kal
	[18509100] = { candy=true, version=110000, achievements={ { id=40862, showAllCriteria=true, }, }, large=true, -- Khaz Algar
					alwaysShow=true, noContinent=true, noCoords=true, },
	[41502500] = { candy=true, version=100000, achievements={ { id=5836, faction="Alliance", showAllCriteria=true, }, -- Northrend
					{ id=5835, faction="Horde", showAllCriteria=true, }, }, large=true, alwaysShow=true, noCoords=true, },
	[40003400] = { candy=true, versionUnder=100000, achievements={ { id=5836, faction="Alliance", showAllCriteria=true, },
					{ id=5835, faction="Horde", showAllCriteria=true, }, }, large=true, alwaysShow=true, noCoords=true, }, -- North.
	[41502500] = { candy=true, version=100000, achievements={ { id=5837, faction="Alliance", showAllCriteria=true, }, -- Cataclysm
					{ id=5838, faction="Horde", showAllCriteria=true, }, }, large=true, alwaysShow=true, noCoords=true, },
	[42004700] = { candy=true, versionUnder=100000, achievements={ { id=5837, faction="Alliance", showAllCriteria=true, },
					{ id=5838, faction="Horde", showAllCriteria=true, }, }, large=true, alwaysShow=true, noCoords=true, }, -- Cata
	[75506700] = { candy=true, version=100000, achievements={ { id=966, faction="Alliance", showAllCriteria=true, }, -- E. Kingdoms
					{ id=967, faction="Horde", showAllCriteria=true, }, }, large=true, alwaysShow=true, noCoords=true, },
	[65507600] = { candy=true, versionUnder=100000, achievements={ { id=966, faction="Alliance", showAllCriteria=true, }, -- EK
					{ id=967, faction="Horde", showAllCriteria=true, }, }, large=true, alwaysShow=true, noCoords=true, },
	[53009100] = { candy=true, version=50000, achievements={ { id=7601, faction="Alliance", showAllCriteria=true, }, -- Pandaria
					{ id=7602, faction="Horde", showAllCriteria=true, }, }, large=true, alwaysShow=true, noCoords=true, },
	[85501750] = { candy=true, version=100000, achievements={ { id=18360, showAllCriteria=true, }, }, large=true, -- Dragon Isles
					alwaysShow=true, noCoords=true, },		
}

--==================================================================================================================================
--
-- TEXTURES
--
--==================================================================================================================================

ns.textures[21] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\AzerothCandySwirl"
ns.textures[22] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\Pumpkin"
ns.textures[23] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\EvilPumpkin"
ns.textures[24] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\HalloweenBat"
ns.textures[25] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\HalloweenCat"
ns.textures[26] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\HalloweenGhost"
ns.textures[27] = "Interface\\AddOns\\HandyNotes_HallowsEnd\\HalloweenWitch"

ns.scaling[21] = 0.432
ns.scaling[22] = 0.432
ns.scaling[23] = 0.432
ns.scaling[24] = 0.432
ns.scaling[25] = 0.432
ns.scaling[26] = 0.432
ns.scaling[27] = 0.432