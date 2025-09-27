local _, ns = ...
ns.points = {}
ns.achievementIQ = {}
ns.addOnName = "LoveIsInTheAir" -- For internal use to name globals etc. Should never be localised
ns.eventName = "Love Is In The Air" -- The player sees this in labels and titles. This gets localised

ns.aoa = {}
--ns.aoa[ 1034 ] = { acctOnly = true }

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

ns.setDungeon = { dungeon=true, alwaysShow=true, noCoords=true, noContinent=true, -- Dungeon focus
			achievements={ { id=4624, showAllCriteria=true,
			guide="Defeat the three Shadowfang Keep bosses, LIITA version" },
			{ id=9389, version=60003, 
			guide="Equip and use any necklace that drops from the LIITA version of Shadowfang Keep" },
			{ id=1703, guide="Drops from certain dungeon bosses. Quickest is to farm the last boss (High "
				.."Priestess Azil) in Stonecore, Deepholm. Heroic or normal the same very high chance (>50%)", }, }, }
ns.setDangerous = { dangerous=true, alwaysShow=true, noCoords=true, noContinent=true, -- Crushing Crown / Steam Pools focus
			achievements={ { id=1695, guide="Complete a \"Crushing the Crown\" daily", },
			{ id=19508, showAllCriteria=true, version=100205, guide="See the Steam Pools guide", }, }, }
ns.setFoolForLove = { foolForLove=true, alwaysShow=true, noCoords=true, noContinent=true, -- The meta
			achievements={ { id=1693, showAllCriteria=true, }, }, }
ns.setFistful = { fistful=true, alwaysShow=true, noCoords=true, noContinent=true, achievements={ { id=1699, showAllCriteria=true, },
			{ id=1704, showAllCriteria=true, }, { id=1188, showAllCriteria=true, }, }, }
ns.setLoveRays = { loveRays=true, alwaysShow=true, noCoords=true, noContinent=true, version=60003, achievements={ -- Love Rays focus
			{ id=9392, }, { id=9393, }, { id=9394, }, { id=1696, }, }, }
ns.setVendorAchieves = { vendorAchieves=true, alwaysShow=true, noCoords=true, noContinent=true,
			achievements={ { id=1702, showAllCriteria=true, -- Sweet Tooth
			guide="The candies are found in Box of Chocolates, which are sold by vendors or may be in the dungeon drop" },
			{ id=1701, showAllCriteria=true, -- Be Mine
			guide="The Bag of Heart Candies (with ten charges) are sold by vendors or may be in the dungeon drop" },
			{ id=1694, -- Lovely Luck Is On Your Side
			guide="Buy a Lovely Dress Box (20 Love Tokens). 1 in 5 chance of the correct dress" },
			{ id=1700, -- Perma-Peddle
			guide="Buy a Truesilver Shafted Arrow (40 Love Tokens). After purchase you may refund if the pet is not wanted" },
			{ id=1291, }, { id=19400, }, }, }
ns.setFlavour = { history=true, alwaysShow=true, noCoords=true, noContinent=true,
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

ns.points[ ns.map.azuremyst ] = { -- Azuremyst Isle
	[20555436] = { introduction=true, name="Draenei Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[31574612] = { introduction=true, name="Draenei Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[33454353] = { introduction=true, name="Gabbo Blinkwink", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
}

ns.points[ ns.map.darnassus ] = { -- Darnassus	
	[44685287] = { introduction=true, name="Night Elf Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[45295808] = { introduction=true, name="Gabbo Blinkwink", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
}

ns.points[ ns.map.desolace ] = { -- Desolace	
	[92145646] = { introduction=true, name="Tauren Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[92705588] = { introduction=true, name="Aurora Vabsley", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
}

ns.points[ ns.map.durotar ] = { -- Durotar
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

ns.points[ ns.map.feralas ] = { -- Feralas
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

ns.points[ ns.map.mulgore ] = { -- Mulgore
	[38782950] = { introduction=true, name="Tauren Commoner", faction="Horde", noContinent=true,
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[39242902] = { introduction=true, name="Aurora Vabsley", faction="Horde", noContinent=true,
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
}

ns.points[ ns.map.barrens ] = { -- Northern Barrens / The Barrens
	[01947963] = { introduction=true, name="Tauren Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[02387918] = { introduction=true, name="Aurora Vabsley", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[70501210] = { selfCare=true, faction="Horde", version=100205,
					quests={ { id=78991, name="The Gift of Relaxation", version=100205, faction="Horde", qType="Daily",
								guide="Head west to Jaz by the Southfury River shore line.\n\n" ..ns.relaxation, }, }, },
}

ns.points[ ns.map.orgrimmar ] = { -- Orgrimmar
	[32236575] = { introduction=true, name="Troll Commoner", faction="Horde", noContinent=true,
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[39577804] = { introduction=true, name="Troll Commoner", faction="Horde", noContinent=true,
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[40264905] = { introduction=true, name="Tauren Commoner", faction="Horde", noContinent=true,
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[49086150] = { introduction=true, name="Troll Commoner", faction="Horde", noContinent=true,
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[51557516] = { introduction=true, name="Orc Commoner", faction="Horde", noContinent=true,
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[51607520] = { introduction=true, name="Orc Commoner", faction="Horde", noContinent=true,
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[58006205] = { selfCare=true, faction="Horde", version=100205, noContinent=true,
					quests={ { id=78990, name="The Gift of Relief", version=100205, faction="Horde", qType="Daily",
								guide=ns.relief, }, }, },
	[63603325] = { selfCare=true, faction="Horde", version=100205, noContinent=true,
					quests={ { id=78990, name="The Gift of Relief", version=100205, faction="Horde", qType="Daily",
								guide=ns.relief, }, }, },
	[69854942] = { introduction=true, name="Orc Commoner", faction="Horde", noContinent=true,
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
}

ns.points[ 199 ] = { -- Southern Barrens
	[17072924] = { introduction=true, name="Tauren Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[17412888] = { introduction=true, name="Aurora Vabsley", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
}

ns.points[ ns.map.teldrassil ] = { -- Teldrassil
	[29544918] = { introduction=true, name="Night Elf Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[29715055] = { introduction=true, name="Gabbo Blinkwink", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
}

ns.points[ ns.map.theExodar ] = { -- The Exodar
	[25589361] = { introduction=true, name="Draenei Commoner", faction="Alliance", noContinent=true,
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[68006186] = { introduction=true, name="Draenei Commoner", faction="Alliance", noContinent=true,
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[75265188] = { introduction=true, name="Gabbo Blinkwink", faction="Alliance", noContinent=true,
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
}

ns.points[ ns.map.thunder ] = { -- Thunder Bluff
	[40825613] = { introduction=true, name="Tauren Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[43225363] = { introduction=true, name="Aurora Vabsley", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
}

ns.points[ ns.map.winterspring ] = { -- Winterspring
	[22784676] = { scenicGetaway=true, alwaysShow=true, name="Scenic Getaway", version=100205,
					tip="Location of \"a relaxing wade into Winterspring hot springs\". Thanks Gabbo!\n\n" ..ns.gatewayNearby, },
}

ns.points[ ns.map.kalimdor ] = { -- Kalimdor
	[02503320] = ns.setDungeon,
	[02503750] = ns.setFoolForLove,
	[04704030] = ns.setDangerous,
	[05003600] = ns.setFlavour,
	[05203200] = ns.setFistful,
	[07303900] = ns.setLoveRays,
	[07603480] = ns.setVendorAchieves,
}

--==================================================================================================================================
--
-- EASTERN KINGDOMS
--
--==================================================================================================================================
					
ns.points[ ns.map.elwynn ] = { -- Elwynn Forest
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

ns.points[ ns.map.eversong ] = { -- Eversong Woods
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

ns.points[ ns.map.ironforge ] = { -- Ironforge
	[32407404] = { introduction=true, name="Dwarf Commoner", faction="Alliance", noContinent=true,
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[33066660] = { introduction=true, name="Gabbo Blinkwink", faction="Alliance", version=100205, noContinent=true,
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[58154940] = { introduction=true, name="Gnome Commoner", faction="Alliance", noContinent=true,
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
}

ns.points[ ns.map.northStrangle ] = { -- Northern Stranglethorn
	[79607733] = { scenicGetaway=true, alwaysShow=true, name="Scenic Getaway", version=100205,
					tip="Location of \"the lovely lakeside in Northern Stranglethorn\". Thanks Gabbo!\n\n" ..ns.gatewayNearby, },
}

ns.points[ ns.map.silvermoon ] = { -- Sivermoon City +13
	[59136077] = { introduction=true, name="Blood Elf Commoner", faction="Horde", noContinent=true,
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[62279656] = { introduction=true, name="Blood Elf Commoner", faction="Horde", noContinent=true,
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[62507380] = { introduction=true, name="Blood Elf Commoner", faction="Horde", noContinent=true,
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[64366726] = { introduction=true, name="Aurora Vabsley", faction="Horde", noContinent=true,
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[77985757] = { introduction=true, name="Blood Elf Commoner", faction="Horde", noContinent=true,
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[89564912] = { introduction=true, name="Blood Elf Commoner", faction="Horde", noContinent=true,
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
	[90245743] = { introduction=true, name="Blood Elf Commoner", faction="Horde", noContinent=true,
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
}

ns.points[ ns.map.silverpine ] = { -- Silverpine Forest
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

ns.points[ ns.map.stormwind ] = { -- Stormwind City
	[49729001] = { introduction=true, name="Human Commoner", faction="Alliance", noContinent=true,
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[62631008] = { selfCare=true, faction="Alliance", version=100205, noContinent=true,
					quests={ { id=78679, name="The Gift of Relaxation", version=100205, faction="Alliance", qType="Daily",
								guide="Go to Olivia's Pond in Stormwind.\n\n" ..ns.relaxation, }, }, },
	[61687418] = { introduction=true, name="Human Commoner", faction="Alliance", noContinent=true,
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[63753198] = { introduction=true, name="Human Commoner", faction="Alliance", noContinent=true,
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[66967251] = { introduction=true, name="Human Commoner", faction="Alliance", noContinent=true,
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[73895587] = { introduction=true, name="Human Commoner", faction="Alliance", noContinent=true,
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[74769465] = { support=true, name="Galvus Ironhammer", faction="Alliance", version=100205, noContinent=true,
					achievements={ { id=19400, guide=ns.support }, }, },
	[75029531] = { crushing=true, name="Inspector Snip Snagglebolt", faction="Alliance", version=100205, noContinent=true,
					achievements={ { id=1695, showAllCriteria=true, version=100205, } },
					quests={ { id=78332, name="I Smell Trouble", showAllCriteria=true, version=100205, faction="Alliance",
						qType="Seasonal", }, 
						{ id=78337, name="An Unwelcome Gift", version=100205, faction="Alliance", qType="Seasonal", }, 
						{ id=78729, name="Raising a Stink", version=100205, faction="Alliance", qType="Seasonal",
							tip=ns.snipsnapSecond, }, 
						{ id=78369, name="Crushing the Crown", version=100205, faction="Alliance", qType="Seasonal", }, 
						{ id=78379, name="The Stench of Revenge", version=100205, faction="Alliance", qType="Seasonal",
							tip=ns.snipsnapThird, }, }, },
	[75096235] = { selfCare=true, faction="Alliance", version=100205, noContinent=true,
					quests={ { id=78674, name="The Gift of Relief", version=100205, faction="Alliance", qType="Daily",
								guide=ns.relief, }, }, },
	[75309393] = { introduction=true, name="Luciana Delgado", faction="Alliance", version=100205, noContinent=true,
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, 
						{ id=78328, name="Take a Look Around", version=100205, faction="Alliance", qType="Seasonal", 
							guide="Speak with Kiera, Maurice, Bang, Sylandra, Gabbo, and Ying. Will unlock dailies", }, }, },
	[78569599] = { selfCare=true, name="Simeon Griswold", faction="Alliance", version=100205, noContinent=true,
					quests={ { id=78674, name="The Gift of Relief", version=100205, faction="Alliance", qType="Daily",
								guide=ns.reliefA, }, }, },
	[79299265] = { scenicGetaway=true, name="Sylandra Silverbreeze", version=100205, noContinent=true,
					quests={ { id=78594, name=ns.feralasTitle, version=100205, faction="Alliance",
								qType="Daily", tip=ns.feralasRizzi, }, 
					{ id=78328, name="Take a Look Around", version=100205, faction="Alliance",
								qType="Seasonal", tip="Quest completion NPC", }, }, },
	[79419826] = { scenicGetaway=true, name="Gabbo Blinkwink", faction="Alliance", version=100205, noContinent=true,
					quests={ { id=78594, name="Getaway to Scenic Feralas", version=100205, faction="Alliance",
								qType="Daily", }, 
						{ id=78565, name="Getaway to Scenic Grizzly Hills", version=100205, faction="Alliance",
							qType="Daily", },
						{ id=78591, name="Getaway to Scenic Nagrand", version=100205, faction="Alliance",
							qType="Daily", }, }, guide=ns.dailyGetaway, },
	[80069168] = { selfCare=true, name="Bordol Dewgarden", faction="Alliance", version=100205, noContinent=true,
					quests={ { id=78679, name="The Gift of Relaxation", version=100205, faction="Alliance", qType="Daily",
								guide="Go to the western side of Olivia's Pond in Stormwind.\n\n" ..ns.relaxation, }, }, },
	[81099604] = { selfCare=true, name="Ying", faction="Alliance", version=100205, noContinent=true,
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

ns.points[ 224 ] = { -- Stranglethorn Vale
	[68634958] = { scenicGetaway=true, alwaysShow=true, name="Scenic Getaway", version=100205, noContinent=true,
					tip="Location of \"the lovely lakeside in Northern Stranglethorn\". Thanks Gabbo!\n\n" ..ns.gatewayNearby, },
}

ns.points[ ns.map.tirisfal ] = { -- Tirisfal Glades
	[61247517] = { introduction=true, name="Forsaken Commoner", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal",
						tip="Below, in the Undercity", }, }, },
	[61356681] = { introduction=true, name="Aurora Vabsley", faction="Horde",
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
}

ns.points[ ns.map.undercity ] = { -- Undercity
	[63304763] = { introduction=true, name="Forsaken Commoner", faction="Horde", noContinent=true,
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
}

ns.points[ ns.map.easternK ] = { -- Eastern Kingdoms
	[02503320] = ns.setDungeon,
	[02503750] = ns.setFoolForLove,
	[04704030] = ns.setDangerous,
	[05003600] = ns.setFlavour,
	[05203200] = ns.setFistful,
	[07303900] = ns.setLoveRays,
	[07603480] = ns.setVendorAchieves,
}

--==================================================================================================================================
--
-- THE BURNING CRUSADE / OUTLAND
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

ns.points[ ns.map.nagrand ] = { -- Nagrand
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

ns.points[ ns.map.shattrath ] = { -- Shattrath
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
}

ns.points[ ns.map.outland ] = { -- Outland
	[02503320] = ns.setDungeon,
	[02503750] = ns.setFoolForLove,
	[04704030] = ns.setDangerous,
	[05003600] = ns.setFlavour,
	[05203200] = ns.setFistful,
	[07303900] = ns.setLoveRays,
	[07603480] = ns.setVendorAchieves,
}

--==================================================================================================================================
--
-- WRATH OF THE LICH KING / NORTHREND
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
							qType="Daily", guide=ns.grizzlyGuide, }, }, }

ns.points[ 125 ] = { -- Dalaran
	[44155890] = { introduction=true, name="Human Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[46327270] = { introduction=true, name="Human Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
}

ns.points[ 126 ] = { -- Dalaran - The Underbelly
	[33195265] = { introduction=true, name="Goblin Commoner", faction="Alliance",
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
}

ns.points[ 116 ] = { -- Grizzly Hills
	[77024914] = { scenicGetaway=true, name="Scenic Getaway Portal", version=100205,
					quests={
						{ id=78565, name=ns.grizzlyGetaway, version=100205, faction="Alliance",
							qType="Daily", guide=ns.grizzlyPortal, },
						{ id=78986, name=ns.grizzlyGetaway, version=100205, faction="Horde",
							qType="Daily", guide=ns.grizzlyPortal, }, }, },
}

ns.points[ 113 ] = { -- Northrend
	[02503320] = ns.setDungeon,
	[02503750] = ns.setFoolForLove,
	[04704030] = ns.setDangerous,
	[05003600] = ns.setFlavour,
	[05203200] = ns.setFistful,
	[07303900] = ns.setLoveRays,
	[07603480] = ns.setVendorAchieves,
}

--==================================================================================================================================
--
-- MISTS OF PANDARIA
--
--==================================================================================================================================

ns.points[ 371 ] = { -- The Jade Forest
	[43914226] = { scenicGetaway=true, alwaysShow=true, name="Scenic Getaway", version=100205,
					tip="Location of \"the thrilling peaks of the Jade Forest\". Thanks Gabbo!\n\n" ..ns.gatewayNearby, },
}

ns.points[ 424 ] = { -- Pandaria
	[02503320] = ns.setDungeon,
	[02503750] = ns.setFoolForLove,
	[04704030] = ns.setDangerous,
	[05003600] = ns.setFlavour,
	[05203200] = ns.setFistful,
	[07303900] = ns.setLoveRays,
	[07603480] = ns.setVendorAchieves,
}

--==================================================================================================================================
--
-- WARLORDS OF DRAENOR / GARRISON
--
--==================================================================================================================================

ns.points[ 572 ] = { -- Draenor
	[02503320] = ns.setDungeon,
	[02503750] = ns.setFoolForLove,
	[04704030] = ns.setDangerous,
	[05003600] = ns.setFlavour,
	[05203200] = ns.setFistful,
	[07303900] = ns.setLoveRays,
	[07603480] = ns.setVendorAchieves,
}

--==================================================================================================================================
--
-- LEGION / BROKEN ISLES
--
--==================================================================================================================================

ns.points[ 641 ] = { -- Val'sharah
	[51525844] = { scenicGetaway=true, alwaysShow=true, name="Scenic Getaway", version=100205,
					tip="Location of \"a romantic hideout in Val'sharah\". Thanks Gabbo!\n\n" ..ns.gatewayNearby, },
}

ns.points[ 619 ] = { -- Broken Isles
	[02503320] = ns.setDungeon,
	[02503750] = ns.setFoolForLove,
	[04704030] = ns.setDangerous,
	[05003600] = ns.setFlavour,
	[05203200] = ns.setFistful,
	[07303900] = ns.setLoveRays,
	[07603480] = ns.setVendorAchieves,
}

--==================================================================================================================================
--
-- BATTLE FOR AZEROTH / KUL TIRAS & ZANDALAR
--
--==================================================================================================================================

ns.points[ 876 ] = { -- Kul Tiras
	[02503320] = ns.setDungeon,
	[02503750] = ns.setFoolForLove,
	[04704030] = ns.setDangerous,
	[05003600] = ns.setFlavour,
	[05203200] = ns.setFistful,
	[07303900] = ns.setLoveRays,
	[07603480] = ns.setVendorAchieves,
}

ns.points[ 875 ] = { -- Zandalar
	[02503320] = ns.setDungeon,
	[02503750] = ns.setFoolForLove,
	[04704030] = ns.setDangerous,
	[05003600] = ns.setFlavour,
	[05203200] = ns.setFistful,
	[07303900] = ns.setLoveRays,
	[07603480] = ns.setVendorAchieves,
}

--==================================================================================================================================
--
-- SHADOWLANDS
--
--==================================================================================================================================

ns.points[ 1550 ] = { -- Shadowlands
	[02503320] = ns.setDungeon,
	[02503750] = ns.setFoolForLove,
	[04704030] = ns.setDangerous,
	[05003600] = ns.setFlavour,
	[05203200] = ns.setFistful,
	[07303900] = ns.setLoveRays,
	[07603480] = ns.setVendorAchieves,
}

--==================================================================================================================================
--
-- DRAGONFLIGHT / DRAGON ISLES
--
--==================================================================================================================================

ns.points[ 2112 ] = { -- Valdrakken
	[54206000] = { introduction=true, name="Gabbo Blinkwink", faction="Alliance", version=100205,
					quests={ { id=78329, name="Love is in the Air", version=100205, faction="Alliance", qType="Seasonal", }, }, },
	[54306100] = { introduction=true, name="Aurora Vabsley", faction="Horde", version=100205,
					quests={ { id=78981, name="Love is in the Air", version=100205, faction="Horde", qType="Seasonal", }, }, },
}

ns.points[ 1978 ] = { -- Dragon Isles
	[02503320] = ns.setDungeon,
	[02503750] = ns.setFoolForLove,
	[04704030] = ns.setDangerous,
	[05003600] = ns.setFlavour,
	[05203200] = ns.setFistful,
	[07303900] = ns.setLoveRays,
	[07603480] = ns.setVendorAchieves,
}

--==================================================================================================================================
--
-- THE WAR WITHIN / KHAZ ALGAR
--
--==================================================================================================================================

ns.points[ 2274 ] = { -- Khaz Algar
	[02503320] = ns.setDungeon,
	[02503750] = ns.setFoolForLove,
	[04704030] = ns.setDangerous,
	[05003600] = ns.setFlavour,
	[05203200] = ns.setFistful,
	[07303900] = ns.setLoveRays,
	[07603480] = ns.setVendorAchieves,
}

--==================================================================================================================================
--
-- WORLD / OTHER
--
--==================================================================================================================================

if ( ns.version < 60000 ) then
	ns.points[ 947 ] = { -- Azeroth
		[44904700] = { metaLarge=true, noCoords=true, achievements={ { id=6006, showAllCriteria=true, }, }, },
	} 
else
	ns.points[ 947 ] = { -- Azeroth
		[42004500] = { metaLarge=true, noCoords=true, achievements={ { id=6006, showAllCriteria=true, }, }, },
	}
end

--==================================================================================================================================
--
-- TEXTURES
--
-- These textures are all repurposed and as such have non-uniform sizing. In order to homogenise the sizes. I should also allow for
-- non-uniform origin placement as well as adjust the x,y offsets
--==================================================================================================================================

ns.textures[21] = "Interface\\AddOns\\HandyNotes_LoveIsInTheAir\\Basket"
ns.textures[22] = "Interface\\AddOns\\HandyNotes_LoveIsInTheAir\\CandySack"
ns.textures[23] = "Interface\\AddOns\\HandyNotes_LoveIsInTheAir\\ColognePink"
ns.textures[24] = "Interface\\AddOns\\HandyNotes_LoveIsInTheAir\\Perfume"
ns.textures[25] = "Interface\\AddOns\\HandyNotes_LoveIsInTheAir\\Ray"
ns.textures[26] = "Interface\\AddOns\\HandyNotes_LoveIsInTheAir\\Rocket"
ns.textures[27] = "Interface\\AddOns\\HandyNotes_LoveIsInTheAir\\LoveToken"
ns.textures[31] = "Interface\\AddOns\\HandyNotes_LoveIsInTheAir\\LoveBB"
ns.textures[32] = "Interface\\AddOns\\HandyNotes_LoveIsInTheAir\\LoveGG"
ns.textures[33] = "Interface\\AddOns\\HandyNotes_LoveIsInTheAir\\LoveRP"
ns.textures[34] = "Interface\\AddOns\\HandyNotes_LoveIsInTheAir\\LoveRY"
ns.textures[41] = "Interface\\AddOns\\HandyNotes_LoveIsInTheAir\\CandyB"
ns.textures[42] = "Interface\\AddOns\\HandyNotes_LoveIsInTheAir\\CandyP"

ns.scaling[21] = 0.432
ns.scaling[22] = 0.432
ns.scaling[23] = 0.432
ns.scaling[24] = 0.432
ns.scaling[25] = 0.432
ns.scaling[26] = 0.432
ns.scaling[27] = 0.432
ns.scaling[31] = 0.432
ns.scaling[32] = 0.432
ns.scaling[33] = 0.432
ns.scaling[34] = 0.432
ns.scaling[41] = 0.432
ns.scaling[42] = 0.432
