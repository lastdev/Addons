local _, ns = ...
local points = ns.points
local textures = ns.textures
local scaling = ns.scaling
ns.map = {}

ns.crushing = "You must finish the quest \"Crushing the Crown\". The quests shown here are for the complete quest chain"
ns.dailyGetaway = "Only one of the three dailies is available, randomly, every day"
ns.gatewayNearby = "There's a Gateway to Durotar (H) Elwynn Forest (A) nearby"
ns.loveLanguage = "Not all gifts can be given the same day as the Mystery Gift varies. Additionally, you'll be prompted to return "
			.."through the portal after three gifts have been completed each day. Do so. Drop the quest. Re-pickup the quest, and "
			.."so on until completed.\n\nAvoid being mounted as that sometimes affects completion credit. You might have success "
			.."for some of the achievement criteria if you are grouped (eg. fighting), but some criteria you must be solo"
ns.relaxation = "As well as speaking to the quest NPC, you have a variety of activities in the quest area. All clearly marked with "
			.."\"sparkles\".\n\nRegardless of what you do, when you are in the deck/lounger chair area you gain 1% progress per "
			.."second anyway - for just being there. Go make coffee, kiss your partner, do a dump, catch an Amazon porch pirate, "
			.."or all of the above.\n\nActivities include petting the Pettable Critters, reading a book, sitting in a pool/beach "
			.."lounger, fishing, and a romantic boat ride.\n\nThe books do not count towards \"Higher Learning\", \"Well Read\" "
			.."and similar but they do run the gamut of all available in-game books, with special weighting for the PG+/M rated "
			.."Steamy Romance Novels.\n\nNote also that when fishing in the Curious Swirling Pools you'll have a chance to haul in "
			.."a Tarnished Engagement Ring worth 10g"
ns.relief = "Kick Discarded Trash (+3%), hit a Training Dummy (+1/sec), yell (action button, not an emote) (+6%), click on the "
			.."Abandoned Pillows (+6%).\n\nIf lazy then just auto hit on the Dummy and go admire yourself in the bathroom mirror"
ns.reliefA = "After speaking to Simeon you must go to the Old Town in Stormwind:\n\n" ..ns.relief
ns.reliefH = "After speaking to Tokag you must go to the Drag in Orgrimmar:\n\n" ..ns.relief
ns.selfCare = "One is a duel with an NPC (Challenge). Another requires you to purchase 5 x drink/food PACKAGES from "
			.."a lovely vendor and to FULLY eat it (Tasty). The third requires you to nap in the Lions Pride, Goldshire (A) or the "
			.."Razor Hill, Durotar inn (H) (Nap). You'll need to stomp out some bed bugs and fluff the pillows before your nap!"				
ns.snipSnapName = ( ns.faction == "Alliance" ) and "Inspector Snip Snagglebolt" or "Detective Snap Snagglebolt"
ns.snipSnapQuestItems = "Quest items are in the crate next to him"
ns.snipsnapSecond = "He relocates to Silverpine Forest"
ns.snipsnapThird = "He returns to here for the hand in"
ns.support = "Maximum is 10,000 per day. For that, you'll receive 10 Love Tokens in the mail. A donation of 500g will yield 3 love "
			.."tokens, which is the cheapest way to buy these, although it leaves you way short of the achievement target.\n\nThe "
			.."mail takes a few minutes to arrive.\n\nThis is an obvious gold sink to buy 10 achievement points but it's a very "
			.."welcome addition as it potentially rescues you if you are several love tokens short on the last day of the event. "
			.."Love Tokens definitely expire at the end of the event"
ns.yourself = ns.L[ "Loving Yourself, Your Way " ]

ns.feralasCompletion = "\n\nAurora (H) or Gabbo (A) will yell after you complete three gifts. Make sure you pickup the offered "
			.."gift for Hana (H) Sylandra (A). Exit the Steam Pools via the portal and hand in the gift"
ns.feralasMystery = "Obtained randomly (50%) from the \"Mystery Gift\" box." ..ns.feralasCompletion
ns.feralasSomeGift = "Gift: Any gift. " ..ns.feralasCompletion
ns.feralasTagging = "Tagging is insufficient. You must initiate the fight. Gift: Shiny New Weapon." ..ns.feralasCompletion
ns.feralasTitle = "Getaway to Scenic Feralas"
ns.feralasAngus = "Companionship\n\n" .."Angus needs his lost puppy \"Beanie\"" ..ns.feralasCompletion
ns.feralasBratley = "Beauty\n\n" .. "Gift: Bouquet of Flowers. " ..ns.feralasMystery
ns.feralasBront =  "Challenge\n\n" ..ns.feralasTagging
ns.feralasClarissa = "Festivity\n\n" .."Gift: Barrel of Wine" ..ns.feralasCompletion
ns.feralasHalene = "Style\n\n" .."Gift: Bouquet of Flowers. " ..ns.feralasMystery
ns.feralasRizzi = "Attention\n\n" ..ns.feralasSomeGift
ns.feralasTheoderic = "Comfort\n\n" .."Do a /hug emote. " ..ns.feralasSomeGift
ns.feralasVerilas = "Praise\n\n" .."Gift: Sealed Letter. " ..ns.feralasMystery
ns.feralasVernon = "Novelty\n\n" ..ns.feralasTagging
ns.feralasWilber = "Respect\n\n" .."Do a /bow emote. " ..ns.feralasSomeGift
			
-- ---------------------------------------------------------------------------------------------------------------------------------

ns.setDungeon = { dungeon=true, showAnyway=true, noCoords=true, noContinent=true, -- Dungeon focus
			achievements={ { id=4624, showAllCriteria=true,
			guide="Defeat the three Shadowfang Keep bosses, LIITA version" },
			{ id=9389, version=60003, 
			guide="Equip and use any necklace that drops from the LIITA version of Shadowfang Keep" },
			{ id=1703, guide="Drops from certain dungeon bosses. Quickest is to farm the last boss (High "
				.."Priestess Azil) in Stonecore, Deepholm. Heroic or normal the same very high chance (>50%)", }, }, }
ns.setDangerous = { dangerous=true, showAnyway=true, noCoords=true, noContinent=true, -- Crushing Crown / Steam Pools focus
			achievements={ { id=1695, guide="Complete a \"Crushing the Crown\" daily", },
			{ id=19508, showAllCriteria=true, version=100205, guide="See the Steam Pools guide", }, }, }
ns.setFoolForLove = { foolForLove=true, showAnyway=true, noCoords=true, noContinent=true, -- The meta
			achievements={ { id=1693, showAllCriteria=true, }, }, }
ns.setFistful = { fistful=true, showAnyway=true, noCoords=true, noContinent=true, achievements={ { id=1699, showAllCriteria=true, },
			{ id=1704, showAllCriteria=true, }, { id=1188, showAllCriteria=true, }, }, }
ns.setLoveRays = { loveRays=true, showAnyway=true, noCoords=true, noContinent=true, version=60003, achievements={ -- Love Rays focus
			{ id=9392, }, { id=9393, }, { id=9394, }, { id=1696, }, }, }
ns.setVendorAchieves = { vendorAchieves=true, showAnyway=true, noCoords=true, noContinent=true,
			achievements={ { id=1702, showAllCriteria=true, -- Sweet Tooth
			guide="The candies are found in Box of Chocolates, which are sold by vendors or may be in the dungeon drop" },
			{ id=1701, showAllCriteria=true, -- Be Mine
			guide="The Bag of Heart Candies (with ten charges) are sold by vendors or may be in the dungeon drop" },
			{ id=1694, -- Lovely Luck Is On Your Side
			guide="Buy a Lovely Dress Box (20 Love Tokens). 1 in 5 chance of the correct dress" },
			{ id=1700, -- Perma-Peddle
			guide="Buy a Truesilver Shafted Arrow (40 Love Tokens). After purchase you may refund if the pet is not wanted" },
			{ id=1291, }, { id=19400, }, }, }
ns.setFlavour = { history=true, showAnyway=true, noCoords=true, noContinent=true,
			tip="Something is in the air in the major cities of Azeroth. Some call it love, and some just call it friendship and "
				.."admiration. Whichever it is, many guards and townsfolks now spend their days giving and receiving tokens and "
				.."gifts to other amorous citizens.\n\nThe more skeptical, however, are suspicious of the strange \"love "
				.."sickness\" clouding the hearts of so many. Will this widespread occurrence be simply taken as a recent outbreak "
				.."of amore? Or will our brave adventurers find a sinister plot behind the source of this plague of passion? Only "
				.."time will tell...\n\n((From Blizzard's offical webpage c.2025))", }

-- Not currently used
ns.setEpidemicLove = { crushing=true,
			quests={ 
				{ id=8899, name="Dearest Colara", version=10903, versionUnder=30300, faction="Alliance", qType="Seasonal",
					tip="Aldris Fourclouds, Darnassus", },
				{ id=8898, name="Dearest Colara", version=10903, versionUnder=30300, faction="Alliance", qType="Seasonal",
					tip="Tormek Stoneriver, Ironforge", },
				{ id=8897, name="Dearest Colara", version=10903, versionUnder=30300, faction="Alliance", qType="Seasonal",
					tip="Lieutenant Jocryn Heldric, Stormwind", },
				{ id=8903, name="Dangerous Love", version=10903, versionUnder=30300, faction="Alliance", qType="Seasonal", },
				{ id=8904, name="Dangerous Love", version=10903, versionUnder=30300, faction="Horde", qType="Seasonal", },
				{ id=9024, name="Aristan's Hunch", version=10903, versionUnder=30300, faction="Alliance", qType="Seasonal", },
				{ id=8979, name="Fenstad's Hunch", version=10903, versionUnder=30300, faction="Horde", qType="Seasonal", },
				{ id=9025, name="Morgan's Discovery", version=10903, versionUnder=30300, faction="Alliance", qType="Seasonal", },
				{ id=8980, name="Zinge's Assessment", version=10903, versionUnder=30300, faction="Horde", qType="Seasonal", },
				{ id=9026, name="Tracing the Source", version=10903, versionUnder=30300, faction="Alliance", qType="Seasonal", },
				{ id=8982, name="Tracing the Source", version=10903, versionUnder=30300, faction="Horde", qType="Seasonal", },
				{ id=9027, name="Tracing the Source", version=10903, versionUnder=30300, faction="Alliance", qType="Seasonal", },
				{ id=8983, name="Tracing the Source", version=10903, versionUnder=30300, faction="Horde", qType="Seasonal", },
				{ id=9028, name="The Source Revealed", version=10903, versionUnder=30300, faction="Alliance", qType="Seasonal", },
				{ id=8984, name="The Source Revealed", version=10903, versionUnder=30300, faction="Horde", qType="Seasonal", },
				{ id=9029, name="A Bubbling Cauldron", version=10903, versionUnder=30300, qType="Seasonal", }, }, }

ns.setCrushing = { crushing=true, name=( ( ns.version >= 30300 ) and "Dangerous Love" or "Nearest and Dearest" ),
				achievements={ { id=1695, showAllCriteria=true, }, }, guide=ns.crushing,
				quests={ 
				{ id=24804, name="Uncommon Scents", version=30302, versionUnder=100205, faction="Alliance", qType="Seasonal", },
				{ id=24805, name="Uncommon Scents", version=30302, versionUnder=100205, faction="Horde", qType="Seasonal", },
				{ id=24655, name="Something Stinks", version=30302, versionUnder=100205, faction="Alliance", qType="Seasonal", },
				{ id=24536, name="Something Stinks", version=30302, versionUnder=100205, faction="Horde", qType="Seasonal", },
				{ id=24656, name="Pilfering Perfume", version=30302, versionUnder=100205, faction="Alliance", qType="Seasonal", },
				{ id=24541, name="Pilfering Perfume", version=30302, versionUnder=100205, faction="Horde", qType="Seasonal", },
				{ id=24848, name="Fireworks At The Gilded Rose", version=30302, versionUnder=100205, faction="Alliance",
							qType="Seasonal", }, 
				{ id=24850, name="Snivel's Sweetheart", version=30302, versionUnder=100205, faction="Horde", qType="Seasonal", },
				{ id=24849, name="Hot On The Trail", version=30302, versionUnder=100205, faction="Alliance", qType="Seasonal", },
				{ id=24851, name="Hot On The Trail", version=30302, versionUnder=100205, faction="Horde", qType="Seasonal", },
				{ id=24657, name="A Friendly Chat...", version=30302, versionUnder=100205, faction="Alliance", qType="Seasonal", },
				{ id=24576, name="A Friendly Chat...", version=30302, versionUnder=100205, faction="Horde", qType="Seasonal", },
				{ id=24658, name="Crushing the Crown", version=30302, versionUnder=100205, level=5, levelUnder=14,
							faction="Alliance", qType="Daily", }, 
				{ id=24638, name="Crushing the Crown", version=30302, versionUnder=100205, level=5, levelUnder=14,
							faction="Horde", qType="Daily", }, 
				{ id=24659, name="Crushing the Crown", version=30302, versionUnder=100205, level=14, levelUnder=23,
							faction="Alliance", qType="Daily", }, 
				{ id=24645, name="Crushing the Crown", version=30302, versionUnder=100205, level=14, levelUnder=23,
							faction="Horde", qType="Daily", }, 
				{ id=24660, name="Crushing the Crown", version=30302, versionUnder=100205, level=23, levelUnder=32,
							faction="Alliance", qType="Daily", }, 
				{ id=24647, name="Crushing the Crown", version=30302, versionUnder=100205, level=23, levelUnder=32,
							faction="Horde", qType="Daily", }, 
				{ id=24662, name="Crushing the Crown", version=30302, versionUnder=70105, level=32, levelUnder=41,
							faction="Alliance", qType="Daily", }, 
				{ id=24648, name="Crushing the Crown", version=30302, versionUnder=70105, level=32, levelUnder=41,
							faction="Horde", qType="Daily", }, 
				{ id=24663, name="Crushing the Crown", version=30302, versionUnder=70105, level=41, levelUnder=51,
							faction="Alliance", qType="Daily", }, 
				{ id=24649, name="Crushing the Crown", version=30302, versionUnder=70105, level=41, levelUnder=51,
							faction="Horde", qType="Daily", }, 
				{ id=24664, name="Crushing the Crown", version=30302, versionUnder=70105, level=51, levelUnder=61,
							faction="Alliance", qType="Daily", }, 
				{ id=24650, name="Crushing the Crown", version=30302, versionUnder=70105, level=51, levelUnder=61,
							faction="Horde", qType="Daily", }, 
				{ id=24665, name="Crushing the Crown", version=30302, versionUnder=70105, level=61, levelUnder=71,
							faction="Alliance", qType="Daily", }, 
				{ id=24651, name="Crushing the Crown", version=30302, versionUnder=70105, level=61, levelUnder=71,
							faction="Horde", qType="Daily", }, 
				{ id=24666, name="Crushing the Crown", version=30302, versionUnder=70105, level=71, levelUnder=81,
							faction="Alliance", qType="Daily", }, 
				{ id=24652, name="Crushing the Crown", version=30302, versionUnder=70105, level=71, levelUnder=81,
							faction="Horde", qType="Daily", }, 
				{ id=28934, name="Crushing the Crown", version=40003, versionUnder=70105, level=81, levelUnder=91,
							faction="Alliance", qType="Daily", }, 
				{ id=28935, name="Crushing the Crown", version=40003, versionUnder=70105, level=81, levelUnder=91,
							faction="Horde", qType="Daily", }, 
				{ id=44558, name="Crushing the Crown", version=70105, versionUnder=100205, level=10,
							faction="Alliance", qType="Daily", }, 
				{ id=44546, name="Crushing the Crown", version=70105, versionUnder=100205, level=10,
							faction="Horde", qType="Daily", }, 
				{ id=24745, name="Something is in the Air (and it Ain't Love)", version=30302, versionUnder=100205,
							faction="Alliance", qType="Seasonal", tip="Pickup in Shadowfang Keep", }, 
				{ id=14483, name="Something is in the Air (and it Ain't Love)", version=30302, versionUnder=100205,
							faction="Horde", qType="Seasonal", tip="Pickup in Shadowfang Keep", }, 
				}, }

--==================================================================================================================================
--
-- KALIMDOR
--
--==================================================================================================================================

ns.map.ashenvale = ( ns.version < 60000 ) and 1440 or 63
ns.map.azshara = ( ns.version < 60000 ) and 1447 or 76
ns.map.azuremyst = ( ns.version < 60000 ) and 1943 or 97
ns.map.darkshore = ( ns.version < 60000 ) and 1439 or 62
ns.map.darnassus = ( ns.version < 60000 ) and 1457 or 89
ns.map.desolace = ( ns.version < 60000 ) and 1443 or 66
ns.map.durotar =  ( ns.version < 60000 ) and 1411 or 1
ns.map.dustwallow =  ( ns.version < 60000 ) and 1445 or 70
ns.map.felwood =  ( ns.version < 60000 ) and 1448 or 77
ns.map.feralas =  ( ns.version < 60000 ) and 1444 or 69
ns.map.moonglade =  ( ns.version < 60000 ) and 1450 or 80
ns.map.mulgore =  ( ns.version < 60000 ) and 1412 or 7
ns.map.northernBarrens =  ( ns.version < 60000 ) and 1413 or 10
ns.map.orgrimmar =  ( ns.version < 60000 ) and 1454 or 85
ns.map.silithus =  ( ns.version < 60000 ) and 1451 or 81
ns.map.stonetalon =  ( ns.version < 60000 ) and 1442 or 65
ns.map.tanaris =  ( ns.version < 60000 ) and 1446 or 71
ns.map.teldrassil =  ( ns.version < 60000 ) and 1438 or 57
ns.map.theExodar =  ( ns.version < 60000 ) and 1947 or 103
ns.map.thousand =  ( ns.version < 60000 ) and 1441 or 64
ns.map.thunder =  ( ns.version < 60000 ) and 1456 or 88
ns.map.ungoro =  ( ns.version < 60000 ) and 1449 or 78
ns.map.winterspring =  ( ns.version < 60000 ) and 1452 or 83
ns.map.kalimdor =  ( ns.version < 60000 ) and 1414 or 12

points[ 76 ] = { -- Azshara
}

points[ 1447 ] = { -- Azshara
}

points[ 97 ] = { -- Azuremyst Isle
	[20555436] = { introduction=true, name="Draenei Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[31574612] = { introduction=true, name="Draenei Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[33454353] = { introduction=true, name="Gabbo Blinkwink", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
}

points[ 1943 ] = { -- Azuremyst Isle
}

points[ 62 ] = { -- Darkshore
}

points[ 1439 ] = { -- Darkshore
}

points[ ns.map.darnassus ] = { -- Darnassus	
	[44685287] = { introduction=true, name="Night Elf Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[45295808] = { introduction=true, name="Gabbo Blinkwink", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[89507620] = ns.setDungeon,
	[89508050] = ns.setFoolForLove,
	[91708330] = ns.setDangerous,
	[92007900] = ns.setFlavour,
	[92207500] = ns.setFistful,
	[94308200] = ns.setLoveRays,
	[94407780] = ns.setVendorAchieves,
}

points[ ns.map.desolace ] = { -- Desolace	
	[92145646] = { introduction=true, name="Tauren Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[92705588] = { introduction=true, name="Aurora Vabsley", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
}

points[ 1 ] = { -- Durotar
	[41561797] = { scenicGetaway=true, name="Hana Breezeheart",
					quests={ { id=78980, name="Take a Look Around", version=100205, faction="Horde",
								qType="Seasonal", },
						{ id=78988, name=ns.feralasTitle, version=100205, faction="Horde",
								qType="Daily", }, }, tip="Quest completion NPC", },
	[41281748] = { selfCare=true, name="Tokag Bonebreaker", faction="Horde", version=100205,
					quests={ { id=78990, name="The Gift of Relief", version=100205, faction="Horde", qType="Daily",
								guide=ns.reliefH, }, }, },
	[41451612] = { scenicGetaway=true, introduction=true, name="Aurora Vabsley", faction="Horde",
					quests={ { id=78988, name="Getaway to Scenic Feralas", version=100205, faction="Horde",
								qType="Daily", }, 
						{ id=78986, name="Getaway to Scenic Grizzly Hills", version=100205, faction="Horde",
							qType="Daily", },
						{ id=78987, name="Getaway to Scenic Nagrand", version=100205, faction="Horde",
							qType="Daily", }, }, guide=ns.dailyGetaway, },
	[41631774] = { crushing=true, name="Detective Snap Snagglebolt", faction="Horde", version=100205,
					achievements={ { id=1695, showAllCriteria=true, version=100205, } },
					quests={ { id=78982, name="I Smell Trouble", showAllCriteria=true, version=100205, faction="Horde",
						qType="Seasonal", }, 
						{ id=78983, name="An Unwelcome Gift", version=100205, faction="Horde", qType="Seasonal", }, 
						{ id=78978, name="Raising a Stink", version=100205, faction="Horde", qType="Seasonal",
							tip=ns.snipsnapSecond, }, 
						{ id=78984, name="Crushing the Crown", version=100205, faction="Horde", qType="Seasonal", }, 
						{ id=78985, name="The Stench of Revenge", version=100205, faction="Horde", qType="Seasonal",
							tip=ns.snipsnapThird, }, }, },
	[41831799] = { introduction=true, name="Mahaja Cloudsong", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, 
						{ id=78980, name="Take a Look Around", version=100205, faction="Horde", qType="Seasonal",
							guide="Speak with Lythianne, Zin'boja, Zikky, Hana, Aurora, and Ning. Will unlock dailies", }, }, },
	[41851624] = { selfCare=true, name="Ning", faction="Horde", version=100205,
					quests={ { id=78991, name="The Gift of Relaxation", version=100205, faction="Horde", qType="Daily",
								guide="Head west to Jaz by the Southfury River shore line.\n\n" ..ns.relaxation, },
							{ id=78990, name="The Gift of Relief", version=100205, faction="Horde", qType="Daily",
								guide=ns.reliefH, },
							{ id=78989, name="The Gift of Self-Care", version=100205, faction="Horde", qType="Daily",
								guide="Speak again with Ning for a choice of three quest", },
							{ id=78992, name=ns.yourself, version=100205, faction="Horde", qType="Daily", tip="(Challenge)", },
							{ id=78993, name=ns.yourself, version=100205, faction="Horde", qType="Daily", tip="(Tasty)", },
							{ id=78979, name=ns.yourself, version=100205, faction="Horde", qType="Daily", tip="(Nap)",
								guide=ns.selfCare, }, }, },
	[42241816] = { support=true, name="Torgando Featherhoof", faction="Horde", version=100205,
					achievements={ { id=19400, guide=ns.support }, }, },
	[43401600] = { scenicGetaway=true, introduction=true, name="Aurora Vabsley", faction="Horde",
					tip="Just a projection. She offers no dailies",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[45340099] = { introduction=true, name="Troll Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
}

points[ 1411 ] = { -- Durotar
}

points[ 70 ] = { -- Dustwallow Marsh
}

points[ 1445 ] = { -- Dustwallow Marsh
}

points[ 69 ] = { -- Feralas
	[68757210] = { loveLanguage=true, name="Rizzi",
					achievements={ { id=19508, index=8, showAllCriteria=true, } },
					quests={ { id=78594, name=ns.feralasTitle, version=100205, faction="Alliance",
						qType="Daily", tip=ns.feralasRizzi, }, { id=78988, name=ns.feralasTitle, version=100205, faction="Horde",
						qType="Daily", tip=ns.feralasRizzi, }, }, },
	[68787367] = { loveLanguage=true, name="Halene Mistrunner",
					achievements={ { id=19508, index=9, showAllCriteria=true, } },
					quests={ { id=78594, name=ns.feralasTitle, version=100205, faction="Alliance",
						qType="Daily", tip=ns.feralasHalene, }, { id=78988, name=ns.feralasTitle, version=100205, faction="Horde",
						qType="Daily", tip=ns.feralasHalene, }, }, },
	[69017241] = { loveLanguage=true, name="Vernon Whitlock",
					achievements={ { id=19508, index=1, showAllCriteria=true, } },
					quests={ { id=78594, name=ns.feralasTitle, version=100205, faction="Alliance",
						qType="Daily", tip=ns.feralasVernon, }, { id=78988, name=ns.feralasTitle, version=100205, faction="Horde",
						qType="Daily", tip=ns.feralasVernon, }, }, },
	[69097291] = { loveLanguage=true, name="Bratley Graston",
					achievements={ { id=19508, index=2, showAllCriteria=true, } },
					quests={ { id=78594, name=ns.feralasTitle, version=100205, faction="Alliance",
						qType="Daily", tip=ns.feralasBratley, }, { id=78988, name=ns.feralasTitle, version=100205, faction="Horde",
						qType="Daily", tip=ns.feralasBratley, }, }, },
	[69007320] = { loveLanguage=true, name="Verilas Sunblood",
					achievements={ { id=19508, index=10, showAllCriteria=true, } },
					quests={ { id=78594, name=ns.feralasTitle, version=100205, faction="Alliance",
						qType="Daily", tip=ns.feralasVerilas, }, { id=78988, name=ns.feralasTitle, version=100205, faction="Horde",
						qType="Daily", tip=ns.feralasVerilas, }, }, },
	[69167265] = { loveLanguage=true, name="Clarissa Buchannan",
					achievements={ { id=19508, index=4, showAllCriteria=true, } },
					quests={ { id=78594, name=ns.feralasTitle, version=100205, faction="Alliance",
						qType="Daily", tip=ns.feralasClarissa, }, { id=78988, name=ns.feralasTitle, version=100205, faction="Horde",
						qType="Daily", tip=ns.feralasClarissa, }, }, },
	[69187263] = { loveLanguage=true, name="Wilber Campbell",
					achievements={ { id=19508, index=6, showAllCriteria=true, } },
					quests={ { id=78594, name=ns.feralasTitle, version=100205, faction="Alliance",
						qType="Daily", tip=ns.feralasWilber, }, { id=78988, name=ns.feralasTitle, version=100205, faction="Horde",
						qType="Daily", tip=ns.feralasWilber, }, }, },
	[69357320] = { scenicGetaway=true, name="Gabbo Blinkwink", faction="Alliance",
					achievements={ { id=19508, showAllCriteria=true, guide=ns.loveLanguage, }, }, },
	[69357320] = { loveLanguage=true, introduction=true, name="Aurora Vabsley", faction="Horde",
					achievements={ { id=19508, showAllCriteria=true, guide=ns.loveLanguage, }, }, },
	[69407360] = { loveLanguage=true, name="Lost Puppy",
					achievements={ { id=19508, index=7, showAllCriteria=true, } },
					quests={ { id=78594, name=ns.feralasTitle, version=100205, faction="Alliance",
						qType="Daily", tip=ns.feralasAngus, }, { id=78988, name=ns.feralasTitle, version=100205, faction="Horde",
						qType="Daily", tip=ns.feralasAngus, }, }, },
	[69447313] = { loveLanguage=true, name="Lovely Gifts", faction="Alliance",
					achievements={ { id=19508, showAllCriteria=true, }, }, },
	[69277305] = { loveLanguage=true, name="Bront Axecrusher",
					achievements={ { id=19508, index=5, showAllCriteria=true, } },
					quests={ { id=78594, name=ns.feralasTitle, version=100205, faction="Alliance",
						qType="Daily", tip=ns.feralasBront, }, { id=78988, name=ns.feralasTitle, version=100205, faction="Horde",
						qType="Daily", tip=ns.feralasBront, }, }, },
	[69767408] = { loveLanguage=true, name="Angus Flagonshot",
					achievements={ { id=19508, index=7, showAllCriteria=true, } },
					quests={ { id=78594, name=ns.feralasTitle, version=100205, faction="Alliance",
						qType="Daily", tip=ns.feralasAngus, }, { id=78988, name=ns.feralasTitle, version=100205, faction="Horde",
						qType="Daily", tip=ns.feralasAngus, }, }, },
	[69947410] = { loveLanguage=true, name="Theoderic Prescott",
					achievements={ { id=19508, index=3, showAllCriteria=true, } },
					quests={ { id=78594, name=ns.feralasTitle, version=100205, faction="Alliance",
						qType="Daily", tip=ns.feralasTheoderic, }, { id=78988, name=ns.feralasTitle, version=100205, faction="Horde",
						qType="Daily", tip=ns.feralasTheoderic, }, }, },
	[70097458] = { loveLanguage=true, name="Scenic Getaway Portal", version=100205,
					achievements={ { id=19508, showAllCriteria=true, } }, },
}

points[ 7 ] = { -- Mulgore
	[38782950] = { introduction=true, name="Tauren Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[39242902] = { introduction=true, name="Aurora Vabsley", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
}

points[ 1412 ] = { -- Mulgore
}

points[ 10 ] = { -- Northern Barrens
	[01947963] = { introduction=true, name="Tauren Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[02387918] = { introduction=true, name="Aurora Vabsley", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[70501210] = { selfCare=true, faction="Horde", version=100205,
					quests={ { id=78991, name="The Gift of Relaxation", version=100205, faction="Horde", qType="Daily",
								guide="Head west to Jaz by the Southfury River shore line.\n\n" ..ns.relaxation, }, }, },
}

points[ ns.map.orgrimmar ] = { -- Orgrimmar
	[32236575] = { introduction=true, name="Troll Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[39577804] = { introduction=true, name="Troll Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[40264905] = { introduction=true, name="Tauren Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[49086150] = { introduction=true, name="Troll Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[51557516] = { introduction=true, name="Orc Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[51607520] = { introduction=true, name="Orc Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[58006205] = { selfCare=true, faction="Horde", version=100205,
					quests={ { id=78990, name="The Gift of Relief", version=100205, faction="Horde", qType="Daily",
								guide=ns.relief, }, }, },
	[63603325] = { selfCare=true, faction="Horde", version=100205,
					quests={ { id=78990, name="The Gift of Relief", version=100205, faction="Horde", qType="Daily",
								guide=ns.relief, }, }, },
	[69854942] = { introduction=true, name="Orc Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[89507620] = ns.setDungeon,
	[89508050] = ns.setFoolForLove,
	[91708330] = ns.setDangerous,
	[92007900] = ns.setFlavour,
	[92207500] = ns.setFistful,
	[94308200] = ns.setLoveRays,
	[94407780] = ns.setVendorAchieves,
}

points[ 1454 ] = { -- Orgrimmar
}

points[ 199 ] = { -- Southern Barrens
	[17072924] = { introduction=true, name="Tauren Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[17412888] = { introduction=true, name="Aurora Vabsley", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
}

points[ 71 ] = { -- Tanaris
}

points[ 1446 ] = { -- Tanaris
}

points[ 57 ] = { -- Teldrassil
	[29544918] = { introduction=true, name="Night Elf Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[29715055] = { introduction=true, name="Gabbo Blinkwink", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
}

points[ 1438 ] = { -- Teldrassil
}

points[ ns.map.theExodar ] = { -- The Exodar
	[25589361] = { introduction=true, name="Draenei Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[68006186] = { introduction=true, name="Draenei Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[75265188] = { introduction=true, name="Gabbo Blinkwink", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[89507620] = ns.setDungeon,
	[89508050] = ns.setFoolForLove,
	[91708330] = ns.setDangerous,
	[92007900] = ns.setFlavour,
	[92207500] = ns.setFistful,
	[94308200] = ns.setLoveRays,
	[94407780] = ns.setVendorAchieves,
}

points[ ns.map.thunder ] = { -- Thunder Bluff
	[89507620] = ns.setDungeon,
	[89508050] = ns.setFoolForLove,
	[91708330] = ns.setDangerous,
	[92007900] = ns.setFlavour,
	[92207500] = ns.setFistful,
	[94308200] = ns.setLoveRays,
	[94407780] = ns.setVendorAchieves,
	[40825613] = { introduction=true, name="Tauren Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[43225363] = { introduction=true, name="Aurora Vabsley", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
}

points[ 83 ] = { -- Winterspring
	[22784676] = { scenicGetaway=true, showAnyway=true, name="Scenic Getaway", version=100205,
					tip="Location of \"a relaxing wade into Winterspring hot springs\". Thanks Gabbo!\n\n" ..ns.gatewayNearby, },
}

--==================================================================================================================================
--
-- EASTERN KINGDOMS
--
--==================================================================================================================================
					
ns.map.badlands = ( ns.version < 60000 ) and 1418 or 15
ns.map.blastedLands = ( ns.version < 60000 ) and 1419 or 17
ns.map.burningSteppes = ( ns.version < 60000 ) and 1428 or 36
ns.map.dunMorogh = ( ns.version < 60000 ) and 1426 or 27
ns.map.duskwood = ( ns.version < 60000 ) and 1431 or 47
ns.map.easternP = ( ns.version < 60000 ) and 1423 or 23
ns.map.elwynn = ( ns.version < 60000 ) and 1429 or 37
ns.map.eversong = ( ns.version < 60000 ) and 1941 or 94
ns.map.hillsbrad = ( ns.version < 60000 ) and 1424 or 25
ns.map.ironforge = ( ns.version < 60000 ) and 1455 or 87
ns.map.lochModan = ( ns.version < 60000 ) and 1432 or 48
ns.map.northStrangle = ( ns.version < 60000 ) and 1434 or 50 -- 1434 is listed as "stranglethorne"
ns.map.searingGorge = ( ns.version < 60000 ) and 1427 or 32
ns.map.silvermoon = ( ns.version < 60000 ) and 1954 or 110
ns.map.silverpine = ( ns.version < 60000 ) and 1421 or 21
ns.map.stormwind = ( ns.version < 60000 ) and 1453 or 84
ns.map.swampOS = ( ns.version < 60000 ) and 1435 or 51
ns.map.TheHint = ( ns.version < 60000 ) and 1425 or 26
ns.map.tirisfal = ( ns.version < 60000 ) and 1420 or 18
ns.map.undercity = ( ns.version < 60000 ) and 1458 or 90
ns.map.westfall = ( ns.version < 60000 ) and 1436 or 52
ns.map.westernP = ( ns.version < 60000 ) and 1422 or 22
ns.map.easternK = ( ns.version < 60000 ) and 1415 or 13

points[ 1416 ] = { -- Alterac Mountains
}	

points[ 27 ] = { -- Dun Morogh
}

points[ 1426 ] = { -- Dun Morogh
}

points[ 47 ] = { -- Duskwood
}

points[ 1431 ] = { -- Duskwood
}

points[ ns.map.elwynn ] = { -- Elwynn Forest
	[25473955] = { introduction=true, name="Human Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[25950747] = { selfCare=true, faction="Alliance", version=100205,
					quests={ { id=78679, name="The Gift of Relaxation", version=100205, faction="Alliance", qType="Daily",
								guide="Go to Olivia's Pond in Stormwind.\n\n" ..ns.relaxation, }, }, },
	[32024980] = { support=true, name="Galvus Ironhammer", faction="Alliance", version=100205,
					achievements={ { id=19400, guide=ns.support }, }, },
	[32294944] = { introduction=true, name="Luciana Delgado", faction="Alliance", version=100205,
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, 
						{ id=78328, name="Take a Look Around", version=100205, faction="Alliance",
							qType="Seasonal", 
							guide="Speak with Kiera, Maurice, Bang, Sylandra, Gabbo, and Ying. Will unlock dailies", }, }, },
	[32165013] = { crushing=true, name="Inspector Snip Snagglebolt", faction="Alliance", version=100205,
					achievements={ { id=1695, showAllCriteria=true, version=100205, } },
					quests={ { id=78332, name="I Smell Trouble", showAllCriteria=true, version=100205, faction="Alliance",
						qType="Seasonal", }, 
						{ id=78337, name="An Unwelcome Gift", version=100205, faction="Alliance", qType="Seasonal", }, 
						{ id=78729, name="Raising a Stink", version=100205, faction="Alliance", qType="Seasonal",
							tip=ns.snipsnapSecond, }, 
						{ id=78369, name="Crushing the Crown", version=100205, faction="Alliance", qType="Seasonal", }, 
						{ id=78379, name="The Stench of Revenge", version=100205, faction="Alliance", qType="Seasonal",
							tip=ns.snipsnapThird, }, }, },
	[32193363] = { selfCare=true, faction="Alliance", version=100205,
					quests={ { id=78674, name="The Gift of Relief", version=100205, faction="Alliance", qType="Daily",
								guide=ns.relief, }, }, },
	[33935047] = { selfCare=true, name="Simeon Griswold", faction="Alliance", version=100205,
					quests={ { id=78674, name="The Gift of Relief", version=100205, faction="Alliance", qType="Daily",
								guide=ns.reliefA, }, }, },
	[34294880] = { scenicGetaway=true, name="Sylandra Silverbreeze", version=100205,
					quests={ { id=78594, name=ns.feralasTitle, version=100205, faction="Alliance",
								qType="Daily", tip=ns.feralasRizzi, }, 
					{ id=78328, name="Take a Look Around", version=100205, faction="Alliance",
								qType="Seasonal", tip="Quest completion NPC", }, }, },
	[34355160] = { scenicGetaway=true, name="Gabbo Blinkwink", faction="Alliance", version=100205,
					quests={ { id=78594, name="Getaway to Scenic Feralas", version=100205, faction="Alliance",
								qType="Daily", }, 
						{ id=78565, name="Getaway to Scenic Grizzly Hills", version=100205, faction="Alliance",
							qType="Daily", },
						{ id=78591, name="Getaway to Scenic Nagrand", version=100205, faction="Alliance",
							qType="Daily", }, }, guide=ns.dailyGetaway, },
	[34684831] = { selfCare=true, name="Bordol Dewgarden", faction="Alliance", version=100205,
					quests={ { id=78679, name="The Gift of Relaxation", version=100205, faction="Alliance", qType="Daily",
								guide="Go to the western side of Olivia's Pond in Stormwind.\n\n" ..ns.relaxation, }, }, },
	[35195049] = { selfCare=true, name="Ying", faction="Alliance", version=100205,
					quests={ { id=78679, name="The Gift of Relaxation", version=100205, faction="Alliance", qType="Daily",
								guide="Go to the western side of Olivia's Pond in Stormwind.\n\n" ..ns.relaxation, },
							{ id=78674, name="The Gift of Relief", version=100205, faction="Alliance", qType="Daily",
								guide="Speak to Simeon Griswold, nearby.\n\n" ..ns.reliefA, },
							{ id=78664, name="The Gift of Self-Care", version=100205, faction="Alliance", qType="Daily",
								guide="Speak again with Ying for a choice of three quests", },
							{ id=78724, name=ns.yourself, version=100205, faction="Alliance", qType="Daily", tip="(Challenge)", },
							{ id=78726, name=ns.yourself, version=100205, faction="Alliance", qType="Daily", tip="(Tasty)", },
							{ id=78727, name=ns.yourself, version=100205, faction="Alliance", qType="Daily", tip="(Nap)", 
								guide=ns.selfCare, }, }, },
}

points[ 94 ] = { -- Eversong Woods
	[53394198] = { introduction=true, name="Blood Elf Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[54165077] = { introduction=true, name="Blood Elf Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[54224518] = { introduction=true, name="Blood Elf Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[54684357] = { introduction=true, name="Aurora Vabsley", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[58034119] = { introduction=true, name="Blood Elf Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[60883912] = { introduction=true, name="Blood Elf Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[61054116] = { introduction=true, name="Blood Elf Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
}

points[ 1941 ] = { -- Eversong Woods
}

points[ 95 ] = { -- Ghostlands
}

points[ 1942 ] = { -- Ghostlands
}

points[ 25 ] = { -- Hillsbrad Foothills
}

points[ 1424 ] = { -- Hillsbrad Foothills
}

points[ ns.map.ironforge ] = { -- Ironforge
	[32407404] = { introduction=true, name="Dwarf Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[33066660] = { introduction=true, name="Gabbo Blinkwink", faction="Alliance", version=100205,
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[58154940] = { introduction=true, name="Gnome Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },

	[89507620] = ns.setDungeon,
	[89508050] = ns.setFoolForLove,
	[91708330] = ns.setDangerous,
	[92007900] = ns.setFlavour,
	[92207500] = ns.setFistful,
	[94308200] = ns.setLoveRays,
	[94407780] = ns.setVendorAchieves,
}

points[ 48 ] = { -- Loch Modan
}

points[ 1432 ] = { -- Loch Modan
}

points[ 50 ] = { -- Northern Stranglethorn
	[79607733] = { scenicGetaway=true, showAnyway=true, name="Scenic Getaway", version=100205,
					tip="Location of \"the lovely lakeside in Northern Stranglethorn\". Thanks Gabbo!\n\n" ..ns.gatewayNearby, },
}

points[ 50 ] = { -- Redridge Mountains
}

points[ 1433 ] = { -- Redridge Mountains
}

points[ 1427 ] = { -- Searing Gorge
}

points[ ns.map.silvermoon ] = { -- Sivermoon City +13
	[31504020] = ns.setDungeon,
	[31504450] = ns.setFoolForLove,
	[33704730] = ns.setDangerous,
	[34004300] = ns.setFlavour,
	[34203900] = ns.setFistful,
	[36304600] = ns.setLoveRays,
	[36404180] = ns.setVendorAchieves,
	[59136077] = { introduction=true, name="Blood Elf Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[62279656] = { introduction=true, name="Blood Elf Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[62507380] = { introduction=true, name="Blood Elf Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[64366726] = { introduction=true, name="Aurora Vabsley", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[77985757] = { introduction=true, name="Blood Elf Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[89564912] = { introduction=true, name="Blood Elf Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[90245743] = { introduction=true, name="Blood Elf Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
}

points[ 21 ] = { -- Silverpine Forest
	[45736849] = { crushing=true, name=ns.snipSnapName, version=100205,
					quests={ { id=78729, name="Raising a Stink", version=100205, faction="Alliance", qType="Seasonal", }, 
						{ id=78369, name="Crushing the Crown", version=100205, faction="Alliance", qType="Seasonal",
							tip=ns.snipSnapQuestItems, },
						{ id=78379, name="The Stench of Revenge", version=100205, faction="Alliance", qType="Seasonal", },
						{ id=78978, name="Raising a Stink", version=100205, faction="Horde", qType="Seasonal", }, 
						{ id=78984, name="Crushing the Crown", version=100205, faction="Horde", qType="Seasonal",
							tip=ns.snipSnapQuestItems, },
						{ id=78985, name="The Stench of Revenge", version=100205, faction="Horde", qType="Seasonal", }, }, },
}

points[ ns.map.stormwind ] = { -- Stormwind City
	[49729001] = { introduction=true, name="Human Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[62631008] = { selfCare=true, faction="Alliance", version=100205,
					quests={ { id=78679, name="The Gift of Relaxation", version=100205, faction="Alliance", qType="Daily",
								guide="Go to Olivia's Pond in Stormwind.\n\n" ..ns.relaxation, }, }, },
	[61687418] = { introduction=true, name="Human Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[63753198] = { introduction=true, name="Human Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[66967251] = { introduction=true, name="Human Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[73895587] = { introduction=true, name="Human Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[74769465] = { support=true, name="Galvus Ironhammer", faction="Alliance", version=100205,
					achievements={ { id=19400, guide=ns.support }, }, },
	[75029531] = { crushing=true, name="Inspector Snip Snagglebolt", faction="Alliance", version=100205,
					achievements={ { id=1695, showAllCriteria=true, version=100205, } },
					quests={ { id=78332, name="I Smell Trouble", showAllCriteria=true, version=100205, faction="Alliance",
						qType="Seasonal", }, 
						{ id=78337, name="An Unwelcome Gift", version=100205, faction="Alliance", qType="Seasonal", }, 
						{ id=78729, name="Raising a Stink", version=100205, faction="Alliance", qType="Seasonal",
							tip=ns.snipsnapSecond, }, 
						{ id=78369, name="Crushing the Crown", version=100205, faction="Alliance", qType="Seasonal", }, 
						{ id=78379, name="The Stench of Revenge", version=100205, faction="Alliance", qType="Seasonal",
							tip=ns.snipsnapThird, }, }, },
	[75096235] = { selfCare=true, faction="Alliance", version=100205,
					quests={ { id=78674, name="The Gift of Relief", version=100205, faction="Alliance", qType="Daily",
								guide=ns.relief, }, }, },
	[75309393] = { introduction=true, name="Luciana Delgado", faction="Alliance", version=100205,
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, 
						{ id=78328, name="Take a Look Around", version=100205, faction="Alliance", qType="Seasonal", 
							guide="Speak with Kiera, Maurice, Bang, Sylandra, Gabbo, and Ying. Will unlock dailies", }, }, },
	[78569599] = { selfCare=true, name="Simeon Griswold", faction="Alliance", version=100205,
					quests={ { id=78674, name="The Gift of Relief", version=100205, faction="Alliance", qType="Daily",
								guide=ns.reliefA, }, }, },
	[79299265] = { scenicGetaway=true, name="Sylandra Silverbreeze", version=100205,
					quests={ { id=78594, name=ns.feralasTitle, version=100205, faction="Alliance",
								qType="Daily", tip=ns.feralasRizzi, }, 
					{ id=78328, name="Take a Look Around", version=100205, faction="Alliance",
								qType="Seasonal", tip="Quest completion NPC", }, }, },
	[79419826] = { scenicGetaway=true, name="Gabbo Blinkwink", faction="Alliance", version=100205,
					quests={ { id=78594, name="Getaway to Scenic Feralas", version=100205, faction="Alliance",
								qType="Daily", }, 
						{ id=78565, name="Getaway to Scenic Grizzly Hills", version=100205, faction="Alliance",
							qType="Daily", },
						{ id=78591, name="Getaway to Scenic Nagrand", version=100205, faction="Alliance",
							qType="Daily", }, }, guide=ns.dailyGetaway, },
	[80069168] = { selfCare=true, name="Bordol Dewgarden", faction="Alliance", version=100205,
					quests={ { id=78679, name="The Gift of Relaxation", version=100205, faction="Alliance", qType="Daily",
								guide="Go to the western side of Olivia's Pond in Stormwind.\n\n" ..ns.relaxation, }, }, },
	[81099604] = { selfCare=true, name="Ying", faction="Alliance", version=100205,
					quests={ { id=78679, name="The Gift of Relaxation", version=100205, faction="Alliance", qType="Daily",
								guide="Go to the western side of Olivia's Pond in Stormwind.\n\n" ..ns.relaxation, },
							{ id=78674, name="The Gift of Relief", version=100205, faction="Alliance", qType="Daily",
								guide="Speak to Simeon Griswold, nearby.\n\n" ..ns.reliefA, },
							{ id=78664, name="The Gift of Self-Care", version=100205, faction="Alliance", qType="Daily",
								guide="Speak again with Ying for a choice of three quests", },
							{ id=78724, name=ns.yourself, version=100205, faction="Alliance", qType="Daily", tip="(Challenge)", },
							{ id=78726, name=ns.yourself, version=100205, faction="Alliance", qType="Daily", tip="(Tasty)", },
							{ id=78727, name=ns.yourself, version=100205, faction="Alliance", qType="Daily", tip="(Nap)", 
								guide=ns.selfCare, }, }, },
	[89507620] = ns.setDungeon,
	[89508050] = ns.setFoolForLove,
	[91708330] = ns.setDangerous,
	[92007900] = ns.setFlavour,
	[92207500] = ns.setFistful,
	[94308200] = ns.setLoveRays,
	[94407780] = ns.setVendorAchieves,
}

points[ 224 ] = { -- Stranglethorn Vale
	[68634958] = { scenicGetaway=true, showAnyway=true, name="Scenic Getaway", version=100205,
					tip="Location of \"the lovely lakeside in Northern Stranglethorn\". Thanks Gabbo!\n\n" ..ns.gatewayNearby, },
}

points[ 1434 ] = { -- Stranglethorn Vale / Northern Stranglethorn (Cata Classic)
}

points[ 210 ] = { -- The Cape of Stranglethorn
}

points[ 18 ] = { -- Tirisfal Glades
	[61247517] = { introduction=true, name="Forsaken Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal",
						tip="Below, in the Undercity", }, }, },
	[61356681] = { introduction=true, name="Aurora Vabsley", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
}

points[ 1420 ] = { -- Tirisfal Glades
}

points[ ns.map.undercity ] = { -- Undercity +13
	[31504020] = ns.setDungeon,
	[31504450] = ns.setFoolForLove,
	[33704730] = ns.setDangerous,
	[34004300] = ns.setFlavour,
	[34203900] = ns.setFistful,
	[36304600] = ns.setLoveRays,
	[36404180] = ns.setVendorAchieves,
	[63304763] = { introduction=true, name="Forsaken Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
}

points[ 52 ] = { -- Westfall
}

points[ 1436 ] = { -- Westfall
}

points[ 56 ] = { -- Wetlands
}

points[ 1437 ] = { -- Wetlands
}

--==================================================================================================================================
--
-- OUTLAND
--
--==================================================================================================================================

ns.nagrandGuide = "You've come to the verdant hills of Nagrand to capture stunning photographs with your Borrowed Camera "
			.."(check your bags). Note that it's a two step process. Click on the camera to bring up the \"vehicle\" "
			.."interface and then hit \"1\" to snap your target.\n\n"
ns.nagrandElekk = ns.nagrandGuide .."It pats around here. Take a photograph from behind to avoid startling or else it will "
			.."enter combat. Forget about taming it or any other Hunter shenanigans"
ns.nagrandSwifthorn = ns.nagrandGuide .."It pats around here. Forget about taming it or any other Hunter shenanigans"
ns.nagrandToothy = ns.nagrandGuide .."You're tasked with a D.E.H.T.A-esque photograph of Toothy here after his attempted "
			.."killers have themselves been killed. Don't attempt beforehand. Toothy, ever the ham, will hang around for a "
			.."bit and pose for the cameras. Photograph him when his grimace, erm... smile, sparkles"
ns.nagrandWindroc = ns.nagrandGuide .."A flock of Soaring Windroc cruises through this area, doing a clockwise lap around Lake "
			.."Sunspring. Just land somewhere at water's edge ahead of them, it's as easy as that. No aggro risks here"
ns.nagrandFinal = "Don't forget this final step before you take the return portal!"
ns.nagrandGetaway = ns.L["Getaway to Scenic Nagrand"]
ns.nagrandPortal = "See the pins for details. Return to here when you are done"
ns.nagrandQuests = { { id=78591, name=ns.nagrandGetaway, version=100205, faction="Alliance", qType="Daily", },
						{ id=78987, name=ns.nagrandGetaway, version=100205, faction="Horde", qType="Daily", }, }

ns.map.shattrath = ( ns.version < 60000 ) and 1955 or 111

points[ 105 ] = { -- Blade's Edge Mountains
}

points[ 1949 ] = { -- Blade's Edge Mountains
}

points[ 107 ] = { -- Nagrand
	[28734663] = { selfCare=true, name="Beatrice Ripley", version=100205, faction="Alliance", quests=ns.nagrandQuests,
					guide=ns.nagrandFinal },
	[34654649] = { selfCare=true, name="Soaring Windroc", version=100205, quests=ns.nagrandQuests, guide=ns.nagrandWindroc },
	[37604383] = { selfCare=true, name="Karn Goreshot", version=100205, faction="Horde", quests=ns.nagrandQuests,
					guide=ns.nagrandFinal },
	[42626105] = { selfCare=true, name="Great White Elekk", version=100205, quests=ns.nagrandQuests, guide=ns.nagrandElekk },
	[48603960] = { selfCare=true, name="Swifthorn the Timid", version=100205, quests=ns.nagrandQuests, guide=ns.nagrandSwifthorn },
	[52804460] = { selfCare=true, name="Toothy", version=100205, quests=ns.nagrandQuests, guide=ns.nagrandToothy },
	[49724628] = { scenicGetaway=true, name="Scenic Getaway Portal", quests={
						{ id=78591, name=ns.nagrandGetaway, version=100205, faction="Alliance",
							qType="Daily", guide=ns.nagrandPortal, },
						{ id=78987, name=ns.nagrandGetaway, version=100205, faction="Horde",
							qType="Daily", guide=ns.nagrandPortal, }, }, },
}

points[ ns.map.shattrath ] = { -- Shattrath
	[28014704] = { introduction=true, name="Goblin Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[49113148] = { introduction=true, name="Goblin Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[53095099] = { introduction=true, name="Goblin Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[54863859] = { introduction=true, name="Goblin Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[55178059] = { introduction=true, name="Goblin Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[58124615] = { introduction=true, name="Goblin Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[58945796] = { introduction=true, name="Goblin Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[63513963] = { introduction=true, name="Goblin Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[89507620] = ns.setDungeon,
	[89508050] = ns.setFoolForLove,
	[91708330] = ns.setDangerous,
	[92007900] = ns.setFlavour,
	[92207500] = ns.setFistful,
	[94308200] = ns.setLoveRays,
	[94407780] = ns.setVendorAchieves,
}

--==================================================================================================================================
--
-- NORTHREND
--
--==================================================================================================================================

ns.grizzlyGuide = "There are three flower types. Harvesting any will yield a Grizzly Hills Flower. You must collect 12. Harvesting "
			.."the Lush version of a flower will yield 4 flowers.\n\nThe pins mark the perimeter of the farming area.\n\n"
			.."Harvesting the Sugar Orchids and Orange Illicium may result in you being attacked by an Irritaed Worker Bee and an "
			.."Anglerweed respectively. Harvesting a Lavenbloom results in you being followed by a cute Curious Critter. Clearly, "
			.."harvesting the Lush Lavenbloom is optimal\n\nOh yeah, Alliance! After the hand-in, hang around. Gabbo will toddle "
			.."off to his valentine... Awww, Bubs and Gabby-poo sitting in a tree.."		
ns.grizzlyGetaway = ns.L["Getaway to Scenic Grizzly Hills"]
ns.grizzlyPortal = "Go west to the farming area. See the pins for details. Return to here when you are done"
ns.grizzlySet = { scenicGetaway=true, name=ns.L[ "Lavenbloom" ] .."/" ..ns.L[ "Orange Illicium" ] .."/"
			..ns.L[ "Sugar Orchid" ], version=100205, quests={
						{ id=78565, name=ns.grizzlyGetaway, version=100205, faction="Alliance",
							qType="Daily", guide=ns.grizzlyGuide, },
						{ id=78986, name=ns.grizzlyGetaway, version=100205, faction="Horde",
							qType="Daily", guide=ns.grizzlyGuide, }, },
}

points[ 114 ] = { -- Borean Tundra
}

points[ 127 ] = { -- Crystalsong Forest
}

points[ 125 ] = { -- Dalaran
	[44155890] = { introduction=true, name="Human Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[46327270] = { introduction=true, name="Human Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[89507620] = ns.setDungeon,
	[89508050] = ns.setFoolForLove,
	[91708330] = ns.setDangerous,
	[92007900] = ns.setFlavour,
	[92207500] = ns.setFistful,
	[94308200] = ns.setLoveRays,
	[94407780] = ns.setVendorAchieves,
}

points[ 126 ] = { -- Dalaran - The Underbelly
	[33195265] = { introduction=true, name="Goblin Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
}

points[ 116 ] = { -- Grizzly Hills
	[65704140] = ns.grizzlySet,
	[66105070] = ns.grizzlySet,
	[68904350] = ns.grizzlySet,
	[71304130] = ns.grizzlySet,
	[71804930] = ns.grizzlySet,
	[73404630] = ns.grizzlySet,
	
--	[72574764] = ns.grizzlySet,
	[77024914] = { scenicGetaway=true, name="Scenic Getaway Portal", version=100205,
					quests={
						{ id=78565, name=ns.grizzlyGetaway, version=100205, faction="Alliance",
							qType="Daily", guide=ns.grizzlyPortal, },
						{ id=78986, name=ns.grizzlyGetaway, version=100205, faction="Horde",
							qType="Daily", guide=ns.grizzlyPortal, }, }, },
}

points[ 118 ] = { -- Icecrown
}

points[ 129 ] = { -- The Nexus
}

points[ 143 ] = { -- The Oculus
}

--==================================================================================================================================
--
-- PANDARIA
--
--==================================================================================================================================

points[ 371 ] = { -- The Jade Forest
	[43914226] = { scenicGetaway=true, showAnyway=true, name="Scenic Getaway", version=100205,
					tip="Location of \"the thrilling peaks of the Jade Forest\". Thanks Gabbo!\n\n" ..ns.gatewayNearby, },
}

--==================================================================================================================================
--
-- GARRISON / DRAENOR
--
--==================================================================================================================================

points[ 525 ] = { -- Frostfire Ridge
}

points[ 590 ] = { -- Frostwall Garrison
}

points[ 543 ] = { -- Gorgrond
}

points[ 582 ] = { -- Lunarfall Garrison
}

points[ 539 ] = { -- Shadowmoon Valley in Draenor
}

points[ 535 ] = { -- Talador
}

points[ 534 ] = { -- Tanaan Jungle
}

--==================================================================================================================================
--
-- BROKEN ISLES
--
--==================================================================================================================================

points[ 641 ] = { -- Val'sharah
	[51525844] = { scenicGetaway=true, showAnyway=true, name="Scenic Getaway", version=100205,
					tip="Location of \"a romantic hideout in Val'sharah\". Thanks Gabbo!\n\n" ..ns.gatewayNearby, },
}

--==================================================================================================================================
--
-- DRAGON ISLES
--
--==================================================================================================================================

points[ 2112 ] = { -- Valdrakken
	[54206000] = { introduction=true, name="Gabbo Blinkwink", faction="Alliance", version=100205,
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[54306100] = { introduction=true, name="Aurora Vabsley", faction="Horde", version=100205,
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
}

--==================================================================================================================================
--
-- KHAZ ALGAR / THE WAR WITHIN
--
--==================================================================================================================================

points[ 2255 ] = { -- Azj-Kahet
}

points[ 2215 ] = { -- Hallowfall
}

points[ 2248 ] = { -- Isle of Dorn
}

points[ 2214 ] = { -- The Ringing Deeps
}

points[ 2274 ] = { -- Khaz Algar
	[89507620] = ns.setDungeon,
	[89508050] = ns.setFoolForLove,
	[91708330] = ns.setDangerous,
	[92007900] = ns.setFlavour,
	[92207500] = ns.setFistful,
	[94308200] = ns.setLoveRays,
	[94407780] = ns.setVendorAchieves,
}

--==================================================================================================================================
--
-- WORLD / OTHER
--
--==================================================================================================================================

if ( ns.version < 60000 ) then
	points[ 947 ] = { -- Azeroth
		[44904700] = { metaLarge=true, noCoords=true, achievements={ { id=6006, showAllCriteria=true, }, }, },
		[53507520] = ns.setDungeon,
		[53507950] = ns.setFoolForLove,
		[55708230] = ns.setDangerous,
		[56007800] = ns.setFlavour,
		[56207400] = ns.setFistful,
		[58308100] = ns.setLoveRays,
		[58407680] = ns.setVendorAchieves,
	} 
else
	points[ 947 ] = { -- Azeroth
		[42004500] = { metaLarge=true, noCoords=true, achievements={ { id=6006, showAllCriteria=true, }, }, },
		[89507620] = ns.setDungeon,
		[89508050] = ns.setFoolForLove,
		[91708330] = ns.setDangerous,
		[92007900] = ns.setFlavour,
		[92207500] = ns.setFistful,
		[94308200] = ns.setLoveRays,
		[94407780] = ns.setVendorAchieves,
		[34008700] = { metaLarge=true, noCoords=true, achievements={ { id=41130, showAllCriteria=true, }, }, },
	}
end


--==================================================================================================================================
--
-- TEXTURES
--
-- These textures are all repurposed and as such have non-uniform sizing. In order to homogenise the sizes. I should also allow for
-- non-uniform origin placement as well as adjust the x,y offsets
--==================================================================================================================================

textures[1] = "Interface\\PlayerFrame\\MonkLightPower"
textures[2] = "Interface\\PlayerFrame\\MonkDarkPower"
textures[3] = "Interface\\Common\\Indicator-Red"
textures[4] = "Interface\\Common\\Indicator-Yellow"
textures[5] = "Interface\\Common\\Indicator-Green"
textures[6] = "Interface\\Common\\Indicator-Gray"
textures[7] = "Interface\\AddOns\\HandyNotes_LoveIsInTheAir\\Basket"
textures[8] = "Interface\\AddOns\\HandyNotes_LoveIsInTheAir\\CandySack"
textures[9] = "Interface\\AddOns\\HandyNotes_LoveIsInTheAir\\ColognePink"
textures[10] = "Interface\\AddOns\\HandyNotes_LoveIsInTheAir\\Perfume"
textures[11] = "Interface\\AddOns\\HandyNotes_LoveIsInTheAir\\Ray"
textures[12] = "Interface\\AddOns\\HandyNotes_LoveIsInTheAir\\Rocket"
textures[13] = "Interface\\AddOns\\HandyNotes_LoveIsInTheAir\\LoveBB"
textures[14] = "Interface\\AddOns\\HandyNotes_LoveIsInTheAir\\LoveGG"
textures[15] = "Interface\\AddOns\\HandyNotes_LoveIsInTheAir\\LoveRP"
textures[16] = "Interface\\AddOns\\HandyNotes_LoveIsInTheAir\\LoveRY"
textures[17] = "Interface\\AddOns\\HandyNotes_LoveIsInTheAir\\CandyB"
textures[18] = "Interface\\AddOns\\HandyNotes_LoveIsInTheAir\\CandyP"
textures[19] = "Interface\\AddOns\\HandyNotes_LoveIsInTheAir\\LoveToken"

scaling[1] = 0.55
scaling[2] = 0.55
scaling[3] = 0.55
scaling[4] = 0.55
scaling[5] = 0.55
scaling[6] = 0.55
scaling[7] = 0.48
scaling[8] = 0.48
scaling[9] = 0.54
scaling[10] = 0.50
scaling[11] = 0.48
scaling[12] = 0.48
scaling[13] = 0.48
scaling[14] = 0.48
scaling[15] = 0.48
scaling[16] = 0.48
scaling[17] = 0.48
scaling[18] = 0.48
scaling[19] = 0.48
