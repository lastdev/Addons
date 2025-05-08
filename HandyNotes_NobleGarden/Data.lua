local _, ns = ...
ns.points = {}
ns.textures = {}
ns.scaling = {}

-- Achievements:
-- Spring Fling							2419		Alliance	fling		Yellow
-- Spring Fling							2497		Horde		fling
-- Desert Rose							2436		Both		rose		Purple
-- Noble Garden (Hide in Silvermoon)	2420		Horde		hide		|
-- Noble Garden (Hide in Stormwind)		2421		Alliance	hide		| Blue
-- Hard Boiled							2416		Both		hardBoiled	|

-- Shake Your Bunny-Maker				2422		Alliance	-			Add to meta cluster later
-- Quacked Killer						20209		Both		daetan		Orange

-- Quests:
-- Quacking Down quest chain			Various		Alliance	quack		Turqoise
-- Quacking Down quest chain			Various		Horde		quack
-- Daetan World Boss					73192		Alliance	daetan		Orange
-- Daetan World Boss					79558		Horde		daetan
-- The Great Egg Hunt					13479		Horde		CF		Light Green
-- The Great Egg Hunt					13480		Alliance	eggHunt
-- Brightly Colored Egg					-			Both		bce			Magenta
-- An Egg-centric Discovery				73192		Alliance	?			Patch 10.0.7. 11.1.0 became Alliance Feathered Fiend
-- An Egg-centric Discovery				74955		Horde		?			Patch 10.0.7. Never made it live. Still in game files

ns.bigNest = "This is the only location of the big nest"
ns.daetanSwoop = "Daetan will briefly swoop down to here"
ns.emmeryFisk = "Go to the Wizard's Sanctum tower. After speaking to Emmery, return to Zinnia then hang around a bit"
ns.tethris = "Go to the Pathfinder's Den (Portal Room) in Orgrimmar. After speaking to Tethris, return to Sylnaria then hang "
			.."around a bit"
ns.waddle = "You'll be given a Duck Potion and you'll use it twice. Fly over to the nest location on the map. Use the potion "
			.."Now un-buff and fly over to Daetan's location. Use the potion. Daetan will appear and then leave. Now go back to "
			.."the same big nest. The heirloom will be alonside the nest and there's no need to buff up this time"

ns.quackingDownSetA = { { id=79322, name="What the Duck?", qType="Seasonal", },
			{ id=79323, name="A Fowl Concoction", qType="Seasonal", guide=ns.emmeryFisk, },
			{ id=79330, name="Duck Tales", qType="Seasonal", },
			{ id=79331, name="Just a Waddle Away", qType="Seasonal", guide=ns.waddle, },
			{ id=78274, name="Quacking Down", qType="Daily", },
			{ id=73192, name="Feathered Fiend", qType="Daily", }, }
ns.quackingDownSetH = { { id=79575, name="What the Duck?", qType="Seasonal", },
			{ id=79576, name="A Fowl Concoction", qType="Seasonal", guide=ns.tethris, },
			{ id=79577, name="Duck Tales", qType="Seasonal", },
			{ id=79578, name="Just a Waddle Away", qType="Seasonal", guide=ns.waddle, },
			{ id=79135, name="Quacking Down", qType="Daily", },
			{ id=79558, name="Feathered Fiend", qType="Daily", }, }

ns.daetanDaily = "Completing this daily once per day rewards a loot basket with 5-10% chances of various \"Spring Reveler's "
			.."Turquoise Attire\" cosmetic transmog pieces + Brightly Colored Egg(s). If you are high level you'll receive an "
			.."additional chance at a Noble Flying Carpet mount too!\n\nThis extra chance is once per day per account.\n\n"
			.."(1) Locate a Golden Egg. It is massive! The spawn timer at busy times is a reasonable 5-10 minutes.\n\n(2) Drag "
			.."the Egg to the Large Duck Nest. Progress is faster if more players join in. To avoid bugging please do not mount, "
			.."use Druid/Shaman travel  forms, etc.\n\n(3) At the nest you'll see Daetan, a large mallard duck, descend from "
			.."above. Kill for \"Noblegarden Trinket\". It's a quest starter. Open bag. Right click on it.\n\n(4) Go to Zinnia. "
			.."for your Loot-Filled Basket!!\n\n"
ns.goldenEgg = "The map pins represent the borders of the area within which to find the Golden Egg.\n\nYou may use a targeting "
			.."macro:\n/cleartarget\n/targetexact Golden Egg\n/stopmacro [noexists]\n/run SetRaidTarget(\"target\", 2)"
ns.daetanDailyDSetH = { daetan=true, name="Daetan Swiftplume", version=100000, faction="Horde", achievements={ { id=20209, }, },
					quests={ { id=79558, name="Feathered Fiend", qType="Daily", }, }, guide=ns.daetanDaily,
					tip="Location of Daetan Swiftplume's nest", }
ns.daetanDailyGESetA = { daetan=true, name="Golden Egg", version=100000, faction="Alliance", achievements={ { id=20209, }, },
					quests={ { id=73192, name="Feathered Fiend", qType="Daily", }, }, guide=ns.daetanDaily, tip=ns.goldenEgg, }
ns.daetanDailyGESetH = { daetan=true, name="Golden Egg", version=100000, faction="Horde", achievements={ { id=20209, }, },
					quests={ id=79558, name="Feathered Fiend", qType="Daily",  }, guide=ns.daetanDaily, tip=ns.goldenEgg, }

ns.baskets = "Between three wicker/skin baskets"
ns.cornerNook = "In the corner nook"
ns.shrubbery = "Concealed in the shrubbery"
ns.stairPlanks = "Between the stair planks."
ns.streetLamp = "Perched on the street lamp"
ns.topFlask = "On top of the flask"
ns.wreathEasle = "Under the wreath/easle"

ns.bce = "Brightly Colored Egg"
ns.bceSetPreWrath = { bce=true, name=ns.bce, versionUnder=30000, }
ns.bceSetPreWrathNoCont = { bce=true, name=ns.bce, versionUnder=30000, noContinent=true, }
ns.bceSetWrathOnly = { bce=true, name=ns.bce, version=30000, versionUnder=40000, }
ns.bceSetWrathOnlyNoCont = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, }
ns.bceSetWrathOnlyNoContShrubbery = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true,
			tip=ns.shrubbery, }
ns.bceSetWrathUp = { bce=true, name=ns.bce, version=30000, }
ns.bceSetWrathUpNoCont = { bce=true, name=ns.bce, version=30000, noContinent=true, }
ns.bceSetWrathUpNoContCrate = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Inside the crate", }
ns.bceSetWrathUpNoContFoliage = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Under the foliage", }
ns.bceSetWrathUpNoContLamp = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Under the lamp", }
ns.bceSetWrathUpNoContLampPost = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="On top of the lamp post", }
ns.bceSetWrathUpNoContLight = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Under the crystal light", }
ns.bceSetWrathUpNoContShrubbery = { bce=true, name=ns.bce, version=30000, noContinent=true, tip=ns.shrubbery, }
ns.bceSetWrathUpNoContTuckedIn = { bce=true, name=ns.bce, version=30000, noContinent=true,
			tip="Tucked in between a fence, a tree and the shrubs", }
ns.bceSetCataUp = { bce=true, name=ns.bce, version=40000, }
ns.bceSetCataUpNoCont = { bce=true, name=ns.bce, version=40000, noContinent=true, }
ns.bceSetCataUpNoContLamp = { bce=true, name=ns.bce, version=40000, noContinent=true, tip=ns.streetLamp, }
ns.bceSetCataUpNoContShrubbery = { bce=true, name=ns.bce, version=40000, noContinent=true, tip=ns.shrubbery, }
ns.bceSetDFUp = { bce=true, name=ns.bce, version=100000, }
ns.bceSetDFUpAuthor = { bce=true, name=ns.bce, version=100000, author=true, }
ns.bceSetDFUpNoCont = { bce=true, name=ns.bce, version=100000, noContinent=true, }
ns.bceSetDFUpNoContAuthor = { bce=true, name=ns.bce, version=100000, noContinent=true, author=true, }

ns.locations = ( ns.faction == "Alliance" ) and ( ( ns.version >= 30000 ) and "Goldshire, Kharanos, Dolanaar, and Azure Watch"
														or "Elwynn Forest, Dun Morogh, Teldrassil" )
							or ( ( ns.version >= 30000 ) and "Razor Hill, Bloodhoof Village, Brill, and Falconwatch Square"
										or "Durotar, Mulgore, Tirisfal Glades" )
ns.locations = "Go to your egg collecting hub at " ..ns.locations ..( ( ns.version >= 100000 ) and " as well as Valdrakken" or "" )

ns.anEcD = "An Egg-centric Discovery"
ns.eggHunt = "The Great Egg Hunt"
ns.eggHuntSetA = { id=13480, name=ns.eggHunt, faction="Alliance", qType="Daily", tip=ns.locations, }
ns.eggHuntSetH = { id=13479, name=ns.eggHunt, faction="Horde", qType="Daily", tip=ns.locations, }
ns.leadInEgg = "This is the correct (and only) location for the Golden Egg Heirloom. Other nearby locations are for the daily "
			.."\"Golden Egg\" task. Use the quest \"Duck Potion\" when here"
ns.tisket = "A Tisket, a Tasket, a Noblegarden Basket"
ns.TisketSetA = { id=13502, name=ns.tisket, faction="Alliance", qType="Seasonal", tip=ns.locations, }
ns.TisketSetH = { id=13503, name=ns.tisket, faction="Horde", qType="Seasonal", tip=ns.locations, }

ns.setHardShake = { hardBoiled=true, version=30000, alwaysShow=true, noContinent=true,
			achievements={ { id=2416, showAllCriteria=true, },
			{ id=2422, showAllCriteria=true, }, }, } -- Hard Boiled. Shake Your Bunny Maker
ns.setMeta = { fling=true, version=30000, alwaysShow=true, noContinent=true, achievements={ { id=2798, showAllCriteria=true, }, },
			tip="\nAhh, the dulcet sounds of spring hover in the Azerothian air. The birds are chirping, the air smells sweeter, "
			.."and cute fluffy bunnies follow you everywhere you go. You think to yourself, “Life in a war-torn and tumultuous "
			.."world isn’t so bad after all.”  It’s then that a realization comes to light, Noblegarden has arrived. Dressing in "
			.."your most festive finery, bunny ears firmly situated and basket in hand, you set out to join the celebration\n\n"
			.."((Blizzard c.2011, Nethaera aka Danielle Vanderlip))", }
ns.setTravel = { rose=true, version=30000, alwaysShow=true, noContinent=true, achievements={ { id=2421, faction="Alliance", },
			{ id=2420, faction="Horde", }, { id=2436, showAllCriteria=true, }, -- Noble Garden. Desert Rose. Spring Fling
			{ id=2419, faction="Alliance", showAllCriteria=true, }, { id=2497, faction="Horde", showAllCriteria=true, }, }, }
ns.setQuacked = { daetan=true, version=100000, alwaysShow=true, noContinent=true, achievements={ { id=20209, }, },
			quests={ { id=73192, faction="Alliance", name="Feathered Fiend", qType="Daily", }, -- Quacked Killer
			{ id=79558, faction="Horde", name="Feathered Fiend", qType="Daily", }, },
			tip="Go to Elwynn Forest (A) or Durotar (H)", }
ns.setFlavour = { flavour=true, name="Noblegarden", noCoords=true, alwaysShow=true, noContinent=true,
			tip="The great feast of Noblegarden has long been celebrated by the races of the Alliance and recently adopted by "
			.."those of the Horde. During this joyous event, it is customary for the nobles and lords from each race to hide "
			.."coins, candy, and the occasional treasures within special eggs painted to look like wildflowers. These eggs are "
			.."then scattered around major cities for the citizenry to find.\n\n((Blizzard c.2014, Nebu through to 2024. Below, "
			.."Blizzard c.2011, Nethaera))\n\n"
			.."Its origins steeped in druidic festivals from times long past, the current incarnation of Noblegarden is a contrast "
			.."between ancient traditions and modern interpretations. While some races of Azeroth try to stay true to the original "
			.."spirit of the holiday, others prefer a more lighthearted approach, like searching for festively decorated eggs and "
			.."collecting the goodies found within. One tenet all can agree on is that the feast of Noblegarden is meant to bring "
			.."communities together to share the joy of life and friendship", }
ns.setDressUp = { eggHunt=true, version=30000, alwaysShow=true, noContinent=true,
			achievements={ { id=249, }, { id=248, }, { id=2576, }, }, -- Dressed For the Occasion. Sunday's Finest. Blushing Bride
			tip="\nMay be purchased with Noblegarden Chocolate if you run out of time.", }
ns.setChocoholic = { quack=true, version=30000, alwaysShow=true, noContinent=true, 
			achievements={ { id=2676, }, { id=2417, }, { id=2418, }, }, -- I Found One, Chocolate Lover (25), Chocoholic (100)
			quests={ ns.eggHuntSetA, ns.eggHuntSetH, ns.TisketSetA, ns.TisketSetH, }, }	

--==================================================================================================================================
--
-- KALIMDOR
--
--==================================================================================================================================

ns.bceSetWrathUpNoContPod = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Alongside the pod structure", }
ns.bceSetWrathUpNoCont2Struct = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Hidden between the two structures", }

ns.points[ ns.map.azuremyst ] = { -- Azuremyst Isle
	[49075125] = { eggHunt=true, version=30000, quests={ ns.eggHuntSetA, ns.TisketSetA, }, },
	[49405010] = { fling=true, version=30000, faction="Alliance", achievements={ { id=2419, index=1, showAllCriteria=true, }, },
					tip=ns.L [ "AnywhereC" ], }, -- Index remains as 1 throughout (even though indexes are useless now in Retail)
--	[50005140] = { eggcentric=true, version=100000, faction="Alliance", quests={ { id=73192, name=ns.anEcD, qType="Daily", }, }, },

	[47345019] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Behind the rocks in plain sight!", },
	[47545192] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Alongside the tree", },
	[47615131] = ns.bceSetWrathUpNoContCrate,
	[47665211] = ns.bceSetWrathUpNoContPod,
	[47695135] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Under the bellows", },
	[47735170] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Deep under the logs", },
	[47775248] = ns.bceSetWrathUpNoContPod,
	[47925050] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Inside, behind stacked containers", },
	[47934994] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Alongside the large cerise crystals", },
	[47935032] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Above, on a ledge", },
	[48044918] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Foot of the tree", },
	[48094925] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Wedged between the tree and the wall", },
	[48175278] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Alongside the tree", },
	[48225026] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip=ns.wreathEasle, },
	[48275249] = ns.bceSetWrathUpNoContFoliage,
	[48295289] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Alongside the tree", },
	[48304878] = ns.bceSetWrathUpNoContPod,
	[48425287] = ns.bceSetWrathUpNoContFoliage,
	[48444994] = ns.bceSetWrathUpNoCont2Struct,
	[48555000] = ns.bceSetWrathUpNoCont2Struct,
	[48665006] = ns.bceSetWrathUpNoContLight,
	[48695268] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Alongside the tent", },
	[48754838] = ns.bceSetWrathUpNoContFoliage,
	[48774909] = ns.bceSetWrathUpNoCont2Struct,
	[48814923] = ns.bceSetWrathUpNoCont2Struct,
	[48864953] = ns.bceSetWrathUpNoCont2Struct,
	[48904976] = ns.bceSetWrathUpNoContLight,
	[49085116] = { bce=true, name=ns.bce, version=30000, tip="Behind the seat", },
	[49115103] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip=ns.cornerNook, },
	[49125085] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Behind the seat", },
	[49125094] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip=ns.cornerNook, },
	[49165109] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip=ns.cornerNook, },
	[49175089] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip=ns.cornerNook, },
	[49225096] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip=ns.cornerNook, },
	[49225105] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip=ns.cornerNook, },
	[49255073] = ns.bceSetWrathUpNoContCrate,
	[49285228] = ns.bceSetWrathUpNoContLight,
	[49295102] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Behind the seat", },
	[49305251] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Inside, behind stacked containers", },
	[49315263] = ns.bceSetWrathUpNoContCrate,
	[49355234] = ns.bceSetWrathUpNoContFoliage,
	[49385298] = ns.bceSetWrathUpNoContPod,
	[49394904] = ns.bceSetWrathUpNoContLight,
	[49425322] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip=ns.cornerNook, },
	[49535345] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Alongside the broken structure", },
	[49605212] = ns.bceSetWrathUpNoContLight,
	[49714889] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Under the Gryphon roost", },
	[49715238] = ns.bceSetWrathUpNoContPod,
	[49864905] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Under the Gryphon roost", },
	[49874887] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Upon the Noblegarden crates", },
	[49935197] = ns.bceSetWrathUpNoContFoliage,
	[49975225] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Above, on a ledge", },
	[49985305] = ns.bceSetWrathUpNoContFoliage,
	[50025271] = ns.bceSetWrathUpNoContFoliage,
	[50035027] = ns.bceSetWrathUpNoContFoliage,
	[50044963] = ns.bceSetWrathUpNoContPod,
	[50045010] = ns.bceSetWrathUpNoContFoliage,
	[50015330] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Alongside the piece of wreckage", },
	[50105291] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Alongside the tree", },
	[50195038] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Alongside the tent", },
	[50205068] = ns.bceSetWrathUpNoContFoliage,
	[50585209] = ns.bceSetWrathUpNoContFoliage,
	[50705122] = ns.bceSetWrathUpNoContFoliage,
	[50095076] = ns.bceSetWrathUpNoContLight,
}

ns.points[ ns.map.desolace ] = { -- Desolace
	[60005200] = { fling=true, version=30000, 
					achievements={ { id=2436, index=4, versionUnder=60000, showAllCriteria=true, tip=ns.L [ "AnywhereZW" ], }, },
					{ id=2436, index=2, version=60000, showAllCriteria=true, tip=ns.L [ "AnywhereZR" ], }, },
}

ns.points[ ns.map.durotar ] = { -- Durotar
	[44443509] = { quack=true, name="Golden Egg Heirloom", version=100000, faction="Horde", quests=ns.quackingDownSetH,
					tip=ns.bigNest, },
	[47911074] = { quack=true, name=" Tethris Dewgazer", version=100000, faction="Horde", quests=ns.quackingDownSetH, },
	[48404406] = { quack=true, name="Daetan", version=100000, faction="Horde", quests=ns.quackingDownSetH, tip=ns.daetanSwoop, },
	[52204240] = { eggHunt=true, version=30000, quests={ ns.eggHuntSetH, ns.TisketSetH, }, },
	[52654185] = { quack=true, name="Sylnaria Fareflame", version=100000, faction="Horde", quests=ns.quackingDownSetH,
					tip="Pin is nearby her location - to avoid obscuring eggs!", },
--	[53604360] = { eggcentric=true, version=100000, faction="Horde", quests={ { id=74955, name=ns.anEcD, qType="Daily", }, }, },
	[53854210] = { fling=true, faction="Horde",
					achievements={ { id=2497, index=1, version=30000, versionUnder=60000, showAllCriteria=true, },
					{ id=2497, index=4, version=60000, showAllCriteria=true, }, }, tip=ns.L [ "AnywhereE" ], },
					
	-- Daetan / Golden Egg
	[42003800] = ns.daetanDailyGESetH,
	[44003200] = ns.daetanDailyGESetH,
	[45004000] = ns.daetanDailyGESetH,
	[46003300] = ns.daetanDailyGESetH,
	[46003700] = ns.daetanDailyGESetH,
	
	-- Vanilla + TBC
	[36302650] = ns.bceSetPreWrathNoCont,
	[37002250] = ns.bceSetPreWrathNoCont,
	[37504650] = ns.bceSetPreWrathNoCont,
	[38605090] = ns.bceSetPreWrathNoCont,
	[38605670] = ns.bceSetPreWrathNoCont,
	[38906190] = ns.bceSetPreWrathNoCont,
	[40204050] = ns.bceSetPreWrathNoCont,
	[40306520] = ns.bceSetPreWrathNoCont,
	[41501850] = ns.bceSetPreWrathNoCont,
	[41502845] = ns.bceSetPreWrathNoCont,
	[41505850] = ns.bceSetPreWrathNoCont,
	[41851535] = ns.bceSetPreWrathNoCont,
	[41906340] = ns.bceSetPreWrathNoCont,
	[41906580] = ns.bceSetPreWrathNoCont,
	[42307120] = ns.bceSetPreWrathNoCont,
	[42705775] = ns.bceSetPreWrathNoCont,
	[42705880] = ns.bceSetPreWrathNoCont,
	[42905630] = ns.bceSetPreWrathNoCont,
	[43007160] = ns.bceSetPreWrathNoCont,
	[43403040] = ns.bceSetPreWrathNoCont,
	[43606270] = ns.bceSetPreWrathNoCont,
	[44105020] = ns.bceSetPreWrathNoCont,	
	[44801980] = ns.bceSetPreWrathNoCont,
	[44907300] = ns.bceSetPreWrathNoCont,
	[45307110] = ns.bceSetPreWrathNoCont,
	[45852755] = ns.bceSetPreWrathNoCont,
	[45805640] = ns.bceSetPreWrath,
	[46906110] = ns.bceSetPreWrathNoCont,
	[47104580] = ns.bceSetPreWrathNoCont,
	[47306280] = ns.bceSetPreWrathNoCont,
	[47607750] = ns.bceSetPreWrathNoCont,
	[47803320] = ns.bceSetPreWrathNoCont,
	[48007960] = ns.bceSetPreWrathNoCont,
	[48704250] = ns.bceSetPreWrathNoCont,
	[49004830] = ns.bceSetPreWrathNoCont,
	[49257425] = ns.bceSetPreWrathNoCont,
	[49801190] = ns.bceSetPreWrathNoCont,
	[50003590] = ns.bceSetPreWrathNoCont,
	[50255145] = ns.bceSetPreWrathNoCont,
	[50802615] = ns.bceSetPreWrathNoCont,
	[51001590] = ns.bceSetPreWrathNoCont,
	[51307335] = ns.bceSetPreWrathNoCont,
	[51701970] = ns.bceSetPreWrathNoCont,
	[51855495] = ns.bceSetPreWrathNoCont,
	[52106415] = ns.bceSetPreWrathNoCont,
	[52507575] = ns.bceSetPreWrathNoCont,
	[53701750] = ns.bceSetPreWrathNoCont,
	[53907990] = ns.bceSetPreWrathNoCont,
	[54706070] = ns.bceSetPreWrathNoCont,
	[54901020] = ns.bceSetPreWrathNoCont,
	[54906650] = ns.bceSetPreWrathNoCont,
	[55603460] = ns.bceSetPreWrathNoCont,
	[55852930] = ns.bceSetPreWrathNoCont,
	[56301970] = ns.bceSetPreWrathNoCont,
	[57101760] = ns.bceSetPreWrathNoCont,
	[57105670] = ns.bceSetPreWrathNoCont,
	[57503030] = ns.bceSetPreWrathNoCont,
	[57504140] = ns.bceSetPreWrathNoCont,
	[57507660] = ns.bceSetPreWrathNoCont,
	[59004580] = ns.bceSetPreWrathNoCont,
	[59205630] = ns.bceSetPreWrathNoCont,
	[60004220] = ns.bceSetPreWrathNoCont,
	[60408250] = ns.bceSetPreWrathNoCont,
	[61207850] = ns.bceSetPreWrathNoCont,
	[64957945] = ns.bceSetPreWrathNoCont,
	[66808680] = ns.bceSetPreWrathNoCont,
	[67108120] = ns.bceSetPreWrathNoCont,
	[67108350] = ns.bceSetPreWrathNoCont,
	[67807350] = ns.bceSetPreWrathNoCont,
	[68507125] = ns.bceSetPreWrathNoCont,
	[69008510] = ns.bceSetPreWrathNoCont,
	
	-- WotLK - eggs were clustered within Razor Hill and the zone wide eggs from Vanilla/TBC were removed
	-- These eggs were removed come Cataclysm
	[51164235] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true,
					tip="Under the round cooking/eating table\n\n((Hey in Retail it's ON the table, with\n"
						.."the entire cooking area shifted away too!))", },
	[52984187] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="Under the lamp", },
	[53184362] = ns.bceSetWrathOnlyNoCont,
	[53324371] = ns.bceSetWrathOnlyNoCont,
	[53354358] = ns.bceSetWrathOnlyNoCont,

	-- From WotLK and upwards through Cataclysm and onwards
	[51074199] = ns.bceSetWrathUp,
	[51534091] = ns.bceSetWrathUpNoCont,
	[51594244] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Under the rickshaw", },
	[51604353] = ns.bceSetWrathUpNoCont,
	[51604368] = ns.bceSetWrathUpNoCont,
	[51714219] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Behind the crate of urns", },
	[51754224] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Between two horde shipping crates", },
	[51784097] = { bce=true, name=ns.bce, version=30000, noContinent=true,
					tip="Wedged between gunpowder kegs and the foundry base" },
	[51894217] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Between the mailbox and a post", },
	[51904024] = ns.bceSetWrathUpNoContLamp,
	[51934035] = ns.bceSetWrathUpNoCont,
	[51934180] = ns.bceSetWrathUpNoContLamp,
	[51954299] = ns.bceSetWrathUpNoContLamp,
	[51964168] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Stashed behind a crate and large flat container", },
	[51984163] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Stashed behind a crate and bag", },
	[52334354] = ns.bceSetWrathUpNoContLamp,
	[52064182] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="In the water tub", },
	[52164090] = ns.bceSetWrathUpNoContLamp,
	[52694121] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Between three cactii", },
				-- Not sure about that one. Version specific? I think Wrath only but why would that be?
	[52794106] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Between three cactii", },
	[52824097] = ns.bceSetWrathUpNoCont,
	[53014094] = { bce=true, name=ns.bce, version=30000, noContinent=true, 
					tip="In the centre of and under the round serving table.\n\nThe best hidden egg in Razor Hill!", },
	[53064083] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Between two grain sacks and a cushion", },
	[53094198] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Under the rickshaw", },
	[53094233] = ns.bceSetWrathUpNoContLamp,
	[53104302] = ns.bceSetWrathUpNoContLamp,
	[53124107] = ns.bceSetWrathUpNoContCrate,
	[53124181] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Between a tuft of grass and the tree", },
	[53344226] = ns.bceSetWrathUpNoCont,
	[53384289] = ns.bceSetWrathUpNoCont,
	[53814175] = ns.bceSetWrathUpNoCont,
	[53934321] = ns.bceSetWrathUpNoCont,
	[54334173] = ns.bceSetWrathUpNoCont,
	[54374106] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Inside the cauldron", },
	[54414102] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Inside the cauldron", },
	[54414131] = ns.bceSetWrathUpNoContCrate,
	[54484194] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Jammed in the nook", },
	[54544284] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Wedged in the corner crevice", },
	[54624248] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Behind the grassy tufts", },
	[54704210] = ns.bceSetWrathUpNoCont,
	[54874192] = ns.bceSetWrathUpNoCont,
	[55244213] = ns.bceSetWrathUpNoCont,
	
	-- From Cataclysm and onwards. Changes were made to Razor Hill for Cataclysm, thus some previous eggs were obsoleted
	-- and replaced with these. Some were additional too
	[50654327] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="In a crate which is under the wagon", },
	[50764270] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="UNDER the round cooking/eating table.\n\n"
					.."Different side of the table and additional to the orginal Wrath location", },
	[50804270] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="On the round cooking/eating table.\n\n"
					.."Hey in Wrath it's UNDER the table, with the entire cooking area much closer to the building!", },
	[50824305] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="On the top of a large sack of grain", },
	[51024121] = ns.bceSetCataUpNoCont,
	[52564261] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="On top of the wayfinding post", },
	[52984187] = { bce=true, name=ns.bce, version=40000, noContinent=true,
					tip="In Wrath there was a lamp here, which explains why this egg is out in the open!", },
	[53094347] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Between a barrel and a post.\n\n"
					.."In Wrath there was no Flight Master. Instead there were cactii, with a couple of chocolate eggs too!", },
	[53164349] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="On top of the stretched red skin", },
	[53184194] = ns.bceSetCataUpNoCont,
	[53244349] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Between the woven bamboo netting and the post", },
	[53264154] = ns.bceSetCataUpNoCont,
	[53504172] = ns.bceSetCataUpNoCont,
	[54444306] = ns.bceSetCataUpNoCont,
	[54644146] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Under the stone slab", },
	[54764171] = ns.bceSetCataUpNoCont,
	[54824246] = ns.bceSetCataUpNoCont,
	[54994273] = ns.bceSetCataUpNoCont,

	-- These locations I found during Dragonflight. Did they exist prior? Dunno
	[51834315] = ns.bceSetWrathUpNoContCrate,
	[51834315] = ns.bceSetWrathUpNoContCrate,
	[52864367] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip=ns.wreathEasle, },
	[53334357] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip="Between the crates", },
	[54454307] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip="Between the building and the pillar",
					author=true, },
	[55194230] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip="Between the rocks", },
}

ns.points[ ns.map.mulgore ] = { -- Mulgore (Bloodhoof Village)
--	[46405830] = { eggcentric=true, version=100000, faction="Horde", quests={ { id=74955, name=ns.anEcD, qType="Daily", }, }, },
	[46746011] = { eggHunt=true, version=30000, versionUnder=40000, quests={ ns.eggHuntSetH, ns.TisketSetH, }, },
	[46935953] = { eggHunt=true, version=40000, quests={ ns.eggHuntSetH, ns.TisketSetH, }, },
	[47905700] = { fling=true, faction="Alliance",
					achievements={ { id=2497, index=4, version=40000, versionUnder=60000, showAllCriteria=true, },
					{ id=2497, index=1, version=60000, showAllCriteria=true, }, }, tip=ns.L [ "AnywhereC" ], },
	[48305720] = { fling=true, version=30000, versionUnder=40000, faction="Alliance",
					achievements={ { id=2497, index=4, showAllCriteria=true, }, }, tip=ns.L [ "AnywhereC" ], },

	-- Vanilla + TBC only
	[30252795] = ns.bceSetPreWrathNoCont,
	[30802270] = ns.bceSetPreWrathNoCont, -- A
	[32101810] = ns.bceSetPreWrathNoCont, -- A
	[32102860] = ns.bceSetPreWrathNoCont,
	[32604720] = ns.bceSetPreWrathNoCont,
	[32653005] = ns.bceSetPreWrathNoCont,
	[33605460] = ns.bceSetPreWrathNoCont,
	[33703350] = ns.bceSetPreWrathNoCont,
	[34104345] = ns.bceSetPreWrathNoCont,
	[34203750] = ns.bceSetPreWrathNoCont,
	[34305560] = ns.bceSetPreWrathNoCont,
	[34506220] = ns.bceSetPreWrathNoCont, -- A
	[34956145] = ns.bceSetPreWrathNoCont,
	[35001580] = ns.bceSetPreWrathNoCont,
	[35006140] = ns.bceSetPreWrathNoCont, -- A only
	[35105900] = ns.bceSetPreWrathNoCont, -- A
	[35205020] = ns.bceSetPreWrathNoCont,
	[35205900] = ns.bceSetPreWrathNoCont,
	[35207410] = ns.bceSetPreWrathNoCont, -- A only
	[35305030] = ns.bceSetPreWrathNoCont,
	[35305700] = ns.bceSetPreWrathNoCont,
	[35356525] = ns.bceSetPreWrathNoCont,
	[35403630] = ns.bceSetPreWrathNoCont,
	[35406270] = ns.bceSetPreWrathNoCont, -- A
	[35506770] = ns.bceSetPreWrathNoCont, -- A
	[36302650] = ns.bceSetPreWrathNoCont,
	[36501610] = ns.bceSetPreWrathNoCont,
	[37401310] = ns.bceSetPreWrathNoCont, -- A
	[37701050] = ns.bceSetPreWrathNoCont,
	[37704830] = ns.bceSetPreWrathNoCont,
	[38504240] = ns.bceSetPreWrathNoCont,
	[38604260] = ns.bceSetPreWrathNoCont, -- A
	[38805990] = ns.bceSetPreWrathNoCont,
	[39150895] = ns.bceSetPreWrathNoCont,
	[39608450] = ns.bceSetPreWrathNoCont, -- A
	[40201540] = ns.bceSetPreWrathNoCont,
	[40754930] = ns.bceSetPreWrathNoCont,
	[41005320] = ns.bceSetPreWrathNoCont, -- A
	[41551925] = ns.bceSetPreWrathNoCont,
	[41801730] = ns.bceSetPreWrathNoCont, -- A
	[41901540] = ns.bceSetPreWrathNoCont,
	[42005610] = ns.bceSetPreWrathNoCont, -- A
	[42304420] = ns.bceSetPreWrathNoCont,
	[42601410] = ns.bceSetPreWrathNoCont, -- A
	[43100890] = ns.bceSetPreWrathNoCont, -- A
	[43201090] = ns.bceSetPreWrathNoCont,
	[43404570] = ns.bceSetPreWrathNoCont,
	[43607235] = ns.bceSetPreWrathNoCont,
	[44105020] = ns.bceSetPreWrathNoCont,
	[44204760] = ns.bceSetPreWrathNoCont,
	[44608760] = ns.bceSetPreWrathNoCont,
	[44801980] = ns.bceSetPreWrathNoCont,
	[45902750] = ns.bceSetPreWrathNoCont,
	[46001290] = ns.bceSetPreWrathNoCont,
	[46701550] = ns.bceSetPreWrathNoCont,
	[46907240] = ns.bceSetPreWrathNoCont,
	[47507790] = ns.bceSetPreWrathNoCont, -- A
	[47607750] = ns.bceSetPreWrathNoCont,
	[48004710] = ns.bceSetPreWrathNoCont, -- A
	[49101150] = ns.bceSetPreWrathNoCont,
	[49200860] = ns.bceSetPreWrathNoCont,
	[49205620] = ns.bceSetPreWrathNoCont,
	[49901660] = ns.bceSetPreWrathNoCont,
	[50205150] = ns.bceSetPreWrathNoCont,
	[50206650] = ns.bceSetPreWrathNoCont,
	[50802620] = ns.bceSetPreWrathNoCont,
	[50852135] = ns.bceSetPreWrathNoCont,
	[50853875] = ns.bceSetPreWrath,
	[50902830] = ns.bceSetPreWrathNoCont,
	[51001590] = ns.bceSetPreWrathNoCont,
	[51906330] = ns.bceSetPreWrathNoCont, -- A
	[52001570] = ns.bceSetPreWrathNoCont,
	[52803120] = ns.bceSetPreWrathNoCont,
	[53100940] = ns.bceSetPreWrathNoCont, -- A
	[53301240] = ns.bceSetPreWrathNoCont,
	[53704260] = ns.bceSetPreWrathNoCont,
	[53751945] = ns.bceSetPreWrathNoCont, -- A
	[53906640] = ns.bceSetPreWrathNoCont,
	[54507380] = ns.bceSetPreWrathNoCont, -- A
	[54502260] = ns.bceSetPreWrathNoCont,
	[54708980] = ns.bceSetPreWrathNoCont,
	[55105490] = ns.bceSetPreWrathNoCont,
	[55505190] = ns.bceSetPreWrathNoCont,
	[55601550] = ns.bceSetPreWrathNoCont,
	[55709410] = ns.bceSetPreWrathNoCont,
	[55807720] = ns.bceSetPreWrathNoCont,
	[56106200] = ns.bceSetPreWrathNoCont,
	[56301970] = ns.bceSetPreWrathNoCont,
	[56401930] = ns.bceSetPreWrathNoCont,
	[56404645] = ns.bceSetPreWrathNoCont,
	[56501915] = ns.bceSetPreWrathNoCont,
	[56504660] = ns.bceSetPreWrathNoCont,
	[56902860] = ns.bceSetPreWrathNoCont,
	[57003400] = ns.bceSetPreWrathNoCont,
	[57101760] = ns.bceSetPreWrathNoCont,
	[57801690] = ns.bceSetPreWrathNoCont,
	[57803170] = ns.bceSetPreWrathNoCont,
	[57804430] = ns.bceSetPreWrathNoCont, -- A
	[57906450] = ns.bceSetPreWrathNoCont,
	[58604750] = ns.bceSetPreWrathNoCont, -- A
	[58701870] = ns.bceSetPreWrathNoCont,
	[59002955] = ns.bceSetPreWrathNoCont,
	[59207200] = ns.bceSetPreWrathNoCont, -- A
	[59304330] = ns.bceSetPreWrathNoCont,
	[60304830] = ns.bceSetPreWrathNoCont,
	[60802190] = ns.bceSetPreWrathNoCont,
	[60802760] = ns.bceSetPreWrathNoCont,
	[61302100] = ns.bceSetPreWrathNoCont,
	[62006190] = ns.bceSetPreWrathNoCont,
	[62957120] = ns.bceSetPreWrathNoCont,
	[63002130] = ns.bceSetPreWrathNoCont,
	[64907950] = ns.bceSetPreWrathNoCont,
	[68305910] = ns.bceSetPreWrathNoCont,

	-- WotLK - Eggs are now clustered within Bloodhoof Village rather than spread zone wide. WotLK only because the
	-- Cataclysm Mulgore map requires a different coordinate system (as though Bloodhoof Village was shunted lol)
	[44755823] = ns.bceSetWrathOnlyNoCont,
	[44865868] = ns.bceSetWrathOnlyNoCont,
	[44916007] = ns.bceSetWrathOnlyNoCont,
	[45065977] = ns.bceSetWrathOnlyNoCont,
	[45255841] = ns.bceSetWrathOnlyNoCont,
	[45415748] = ns.bceSetWrathOnlyNoCont,
	[45485883] = ns.bceSetWrathOnlyNoCont,
	[45636064] = ns.bceSetWrathOnlyNoCont,
	[45755672] = ns.bceSetWrathOnlyNoCont,
	[45866012] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip=ns.baskets, },
	[45925920] = ns.bceSetWrathOnlyNoCont,
	[45966128] = ns.bceSetWrathOnlyNoCont,
	[46066233] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="In a wicker crate in a canoe", },
	[46085745] = ns.bceSetWrathOnlyNoCont,
	[46166219] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="In a canoe", },
	[46226159] = ns.bceSetWrathOnlyNoCont,
	[46295783] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true,
					tip="Under the bath, tent side. Well hidden!", },
	[46315781] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="In the centre of the bath", },
	[46406177] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="Under the canoe. So tricky!", },
	[46446098] = ns.bceSetWrathOnlyNoCont,
	[46476181] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="Under the canoe. So devious!", },
	[46485795] = ns.bceSetWrathOnlyNoCont,
	[46586053] = ns.bceSetWrathOnlyNoCont,
	[46606045] = ns.bceSetWrathOnlyNoCont,
	[46676042] = ns.bceSetWrathOnlyNoCont,
	[46836125] = ns.bceSetWrathOnlyNoCont,
	[46946097] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true,
					tip="Under the bath, building side. Well hidden!", },
	[46966063] = ns.bceSetWrathOnlyNoCont,
	[46995715] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="Inside the flat woven bowl", },
	[46996072] = ns.bceSetWrathOnlyNoCont,
	[47045684] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip=ns.baskets, },
	[47105675] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="Beneath the huge drum", },
	[47285997] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="Between the crates", author=true, },
	[47345992] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="Under/behind the sled", },
	[47436258] = ns.bceSetWrathOnlyNoCont,
	[47466002] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true,
					tip="Between a wicker/skin basket and the totem", },
	[47475998] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="Inside the urn. Well hidden!", },
	[47495459] = ns.bceSetWrathOnlyNoCont,
	[47585857] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip=ns.baskets, },
	[47616215] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="Atop the flameless smoker", },
	[47645574] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="At the base of the loom", },
	[47705596] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true,
					tip="Beneath the plainstrider carcass", },
	[47706057] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip=ns.wreathEasle, author=true, },
	[47836143] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="Under/behind the sled" },
	[47855558] = ns.bceSetWrathOnlyNoCont,
	[48175998] = ns.bceSetWrathOnly,
	[48536020] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true,
					tip="Between the straw target dummy and the pavilion platform", },
	[48775840] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true,
					tip=ns.stairPlanks .." Devious!", },
	[48215836] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="On the crate", author=true, },
	[48815830] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true,
					tip=ns.stairPlanks .." Well hidden!", },
	[48915997] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true,
					tip="Between the steps and the pavilion platform", },
	[48966012] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true,
					tip=ns.stairPlanks .." Clever!", },
	[49026022] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true,
					tip=ns.stairPlanks .." Tricky!", },
	[52206065] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="At the base of the windmill", author=true, },
	
	-- From Cataclysm and onwards. Pretty much the same egg locations, just with different coordinates
	[45055775] = ns.bceSetCataUp,
	[45165818] = ns.bceSetCataUpNoCont,
	[45205949] = ns.bceSetCataUpNoCont,
	[45345921] = ns.bceSetCataUpNoCont,
	[45525793] = ns.bceSetCataUpNoCont,
	[45685705] = ns.bceSetCataUpNoCont,
	[45745833] = ns.bceSetCataUpNoCont,
	[45886003] = { bce=true, name=ns.bce, version=40000, noContinent=true,
					tip="You'll probably miss this one if your Ground Clutter setting is high", },
	[45995634] = ns.bceSetCataUpNoCont,
	[45995688] = ns.bceSetCataUpNoCont,
	[46056006] = ns.bceSetCataUpNoCont,
	[46105953] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip=ns.baskets, },
	[46165867] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="South-west side of a support beam", },
	[46196064] = ns.bceSetCataUpNoCont,
	[46296162] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Under the canoe in the water. Wicked stealth!", },
	[46315702] = ns.bceSetCataUpNoCont,
	[46316158] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="In the canoe. Look under too!", },
	[46386149] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Under the canoe. Devious!", },
	[46446092] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Between the beams", },
	[46505739] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Under the bath, tent side. Well hidden!", },
	[46525736] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="In the centre of the bath", },
	[46616109] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Under the canoe. So tricky!", },
	[46655819] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip=ns.wreathEasle, },
	[46656035] = ns.bceSetCataUpNoCont,
	[46685749] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Alongside the tent post", },
	[46686113] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Under the canoe. So tricky!", },
	[46775993] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Another egg nook", },
	[46795986] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Another egg nook", },
	[46805985] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Another egg nook", },
	[46856122] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Another egg nook", },
	[46865983] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="In a nook at the front of the inn", },
	[47016061] = ns.bceSetCataUpNoCont,
	[47116034] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Under the bath, building side. Well hidden!", },
	[47146002] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Well concealed at the back here!", },
	[47146018] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="In the corner covered by grass", },
	[47146036] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="In the centre of the bath", },
	[47175674] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="In the wicker bowl", },
	[47215646] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip=ns.baskets, },
	[47265638] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Beneath the huge drum", },
	[47505936] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Under/behind the sled", },
	[47586186] = ns.bceSetCataUpNoCont,
	[47605944] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Between a wicker/skin basket and the totem", },
	[47615941] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Inside the urn. Well hidden!", },
	[47635433] = ns.bceSetCataUpNoCont,
	[47715807] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip=ns.baskets, },
	[47726182] = { bce=true, name=ns.bce, version=40000, noContinent=true,
					tip="Concealed in the high grass. Can't see it if your Ground Clutter setting is high", },
	[47746145] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Atop the flameless smoker", },
	[47785540] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="At the base of the loom", },
	[47835562] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Beneath the plainstrider carcass", },
	[47845550] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Beneath the plainstrider carcass", },
	[47956077] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Under/behind the sled", },
	[47975525] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="At the base of the brazier-style lamp", },
	[48035998] = { bce=true, name=ns.bce, version=40000, noContinent=true,
					tip="In the totem brazier. May the spirits guide you... the chocolate didn't melt!", },
	[48165864] = { bce=true, name=ns.bce, version=40000, noContinent=true,
					tip="At the base of the support beam, hidden in the grass!", },
	[48285941] = ns.bceSetCataUpNoCont,
	[48615961] = { bce=true, name=ns.bce, version=40000, noContinent=true,
					tip="Between the straw target dummy and the pavilion platform", },
	[48785818] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip=ns.stairPlanks .." Well hidden!", },
	[48815804] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip=ns.stairPlanks .." Tricky!", },
	[48845792] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip=ns.stairPlanks .." Clever!", },
	[48885782] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip=ns.stairPlanks .." Devious!", },
	[48985940] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip=ns.stairPlanks .." Genius!", },
	[49025955] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip=ns.stairPlanks .." Brilliant!", },
	[49085963] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip=ns.stairPlanks .." Devilish!", },

	-- These need checking
	[46246164] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="In the canoe. Look under too!", },
}

ns.points[ ns.map.orgrimmar ] = { -- Orgrimmar
	[56889115] = { quack=true, name="Tethris Dewgazer", version=100000, faction="Horde", quests=ns.quackingDownSetH, },
}

ns.points[ ns.map.silithus ] = { -- Silithus
	[55003800] = { hardBoiled=true, version=30000, versionUnder=40000, achievements={ { id=2416, }, }, guide=ns.L [ "hb3" ], },
	[73003200] = { fling=true, version=30000,
					achievements={ { id=2436, index=1, versionUnder=60000, showAllCriteria=true, tip=ns.L [ "AnywhereZW" ], }, },
					{ id=2436, index=3, version=60000, showAllCriteria=true, tip=ns.L [ "AnywhereZR" ], }, },
}

ns.points[ ns.map.tanaris ] = { -- Tanaris
	[48002680] = { fling=true, version=30000,
					achievements={ { id=2436, index=3, versionUnder=60000, showAllCriteria=true, tip=ns.L [ "AnywhereZW" ], }, },
					{ id=2436, index=4, version=60000, showAllCriteria=true, tip=ns.L [ "AnywhereZR" ], }, },
}

ns.points[ ns.map.teldrassil ] = { -- Teldrassil
	[54705930] = { fling=true, version=30000, versionUnder=40000, faction="Alliance",
					achievements={ { id=2419, index=4, showAllCriteria=true, }, }, tip=ns.L [ "AnywhereT" ], },
	[55595136] = { eggHunt=true, version=40000, quests={ ns.eggHuntSetA, ns.TisketSetA, }, },
	[55885878] = { eggHunt=true, version=30000, versionUnder=40000, quests={ ns.eggHuntSetA, ns.TisketSetA, }, },
--	[56205380] = { eggcentric=true, version=100000, faction="Alliance", quests={ { id=73192, name=ns.anEcD, qType="Daily", }, }, },
	[56805210] = { fling=true, faction="Alliance",
					achievements={ { id=2419, index=4, version=40000, versionUnder=60000, showAllCriteria=true, },
					{ id=2419, index=2, version=60000, showAllCriteria=true, }, }, tip=ns.L [ "AnywhereT" ], },

	-- Vanilla + TBC only. There is little available data. Best to farm around the lakes
	[36202760] = ns.bceSetPreWrathNoCont,
	[43903820] = ns.bceSetPreWrathNoCont,
	[55307090] = ns.bceSetPreWrathNoCont,
	[55404160] = ns.bceSetPreWrathNoCont,
	[57504450] = ns.bceSetPreWrath,
	[61604630] = ns.bceSetPreWrathNoCont,
	[61803340] = ns.bceSetPreWrathNoCont,
	[65105350] = ns.bceSetPreWrathNoCont,
	[66005830] = ns.bceSetPreWrathNoCont,
	[68705450] = ns.bceSetPreWrathNoCont,

	-- WotLK - Eggs are now clustered within Dolanaar rather than spread zone wide. WotLK only because the
	-- Cataclysm Teldrassil map requires a different coordinate system
	[55466237] = ns.bceSetWrathOnlyNoContShrubbery,
	[55506225] = ns.bceSetWrathOnlyNoContShrubbery,
	[55535774] = ns.bceSetWrathOnlyNoContShrubbery,
	[55536216] = ns.bceSetWrathOnlyNoContShrubbery,
	[55565791] = ns.bceSetWrathOnlyNoContShrubbery,
	[55705876] = ns.bceSetWrathOnlyNoCont,
	[55715862] = ns.bceSetWrathOnlyNoContShrubbery,
	[55715883] = ns.bceSetWrathOnlyNoCont,
	[55735953] = ns.bceSetWrathOnlyNoCont,
	[55805815] = ns.bceSetWrathOnlyNoContShrubbery,
	[55805987] = ns.bceSetWrathOnlyNoCont,
	[55876200] = ns.bceSetWrathOnlyNoCont,
	[55886032] = ns.bceSetWrathOnlyNoContShrubbery,
	[55906346] = ns.bceSetWrathOnlyNoContShrubbery,
	[55936050] = ns.bceSetWrathOnlyNoContShrubbery,
	[55975705] = ns.bceSetWrathOnlyNoContShrubbery,
	[55996181] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="In the pool", },
	[56066050] = ns.bceSetWrathOnlyNoCont,
	[56075762] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="Under the ramp", },
	[56115742] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip=ns.topFlask, },
	[56125746] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true,
					tip="Wedged between the flasks and the ramp", },
	[56135845] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true,
					tip="Between the mailbox and the ramp", },
	[56305877] = ns.bceSetWrathOnlyNoContShrubbery,
	[56375874] = ns.bceSetWrathOnlyNoContShrubbery,
	[56396364] = ns.bceSetWrathOnlyNoContShrubbery,
	[56415916] = ns.bceSetWrathOnlyNoContShrubbery,
	[56455930] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="Under the perambulator", },
	[56456357] = ns.bceSetWrathOnlyNoContShrubbery,
	[56485944] = ns.bceSetWrathOnlyNoContShrubbery,
	[56526029] = ns.bceSetWrathOnly,
	[56535957] = ns.bceSetWrathOnlyNoContShrubbery,
	[56556003] = ns.bceSetWrathOnlyNoCont,
	[56566031] = ns.bceSetWrathOnlyNoContShrubbery,
	[56575732] = ns.bceSetWrathOnlyNoContShrubbery,
	[56575907] = ns.bceSetWrathOnlyNoContShrubbery,
	[56585970] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="Alongside the flask", },
	[56586329] = ns.bceSetWrathOnlyNoContShrubbery,
	[56605970] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip=ns.topFlask, },
	[56616014] = ns.bceSetWrathOnlyNoContShrubbery,
	[56695895] = ns.bceSetWrathOnlyNoContShrubbery,
	[56725994] = ns.bceSetWrathOnlyNoContShrubbery,
	[56755994] = ns.bceSetWrathOnlyNoContShrubbery,
	[56835915] = ns.bceSetWrathOnlyNoContShrubbery,
	[56995808] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip=ns.topFlask, },
	[56995812] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="Under the seat", },
	[57035806] = ns.bceSetWrathOnlyNoContShrubbery,
	[57316068] = ns.bceSetWrathOnlyNoContShrubbery,
	[57366045] = ns.bceSetWrathOnlyNoContShrubbery,
	[57406091] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="In the pool", },
	[57746089] = ns.bceSetWrathOnlyNoCont,
	[57806046] = ns.bceSetWrathOnlyNoCont,

	-- From Cataclysm and onwards. Pretty much the same egg locations, just with different coordinates
	[55145061] = ns.bceSetCataUpNoCont,
	[55235447] = ns.bceSetCataUpNoContShrubbery,
	[55265437] = ns.bceSetCataUpNoContShrubbery,
	[55295428] = ns.bceSetCataUpNoContShrubbery,
	[55445122] = ns.bceSetCataUpNoContShrubbery,
	[55445134] = ns.bceSetCataUpNoCont,
	[55455140] = ns.bceSetCataUpNoCont,
	[55465201] = ns.bceSetCataUpNoCont,
	[55525231] = ns.bceSetCataUpNoCont,
	[55535082] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Under the perambulator", },
	[55585415] = ns.bceSetCataUpNoCont,
	[55595269] = { bce=true, name=ns.bce, version=40000, noContinent=true,
					tip="Half concealed in the shrubbery and half\nwedged between the shrubbery and the tree", },
	[55615541] = ns.bceSetCataUpNoContShrubbery,
	[55645285] = ns.bceSetCataUpNoCont,
	[55674986] = ns.bceSetCataUpNoContShrubbery,
	[55695398] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="In the pool", },
	[55755035] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Under the ramp", },
	[55755285] = { bce=true, name=ns.bce, version=40000, noContinent=true, },
	[55805018] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip=ns.topFlask, },
	[55805107] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Between the mailbox and the ramp", },
	[55815021] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Between the ramp and the flasks", },
	[56025133] = ns.bceSetCataUpNoContShrubbery,
	[56035557] = ns.bceSetCataUpNoContShrubbery,
	[56055169] = ns.bceSetCataUpNoContShrubbery,
	[56085180] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Under the perambulator", },
	[56095550] = ns.bceSetCataUpNoContShrubbery,
	[56115192] = ns.bceSetCataUpNoContShrubbery,
	[56155195] = ns.bceSetCataUpNoContShrubbery,
	[56155205] = ns.bceSetCataUpNoContShrubbery,
	[56155267] = ns.bceSetCataUpNoCont,
	[56175244] = ns.bceSetCataUp,
	[56185161] = ns.bceSetCataUpNoContShrubbery,
	[56185268] = ns.bceSetCataUpNoContShrubbery,
	[56195010] = ns.bceSetCataUpNoContShrubbery,
	[56205216] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Wedged between the flasks and the ramp", },
	[56205526] = ns.bceSetCataUpNoContShrubbery,
	[56215263] = ns.bceSetCataUpNoContShrubbery,
	[56225215] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip=ns.topFlask, },
	[56225254] = ns.bceSetCataUpNoContShrubbery,
	[56235006] = ns.bceSetCataUpNoContShrubbery,
	[56245326] = ns.bceSetCataUpNoContShrubbery,
	[56255156] = ns.bceSetCataUpNoContShrubbery,
	[56295151] = ns.bceSetCataUpNoContShrubbery,
	[56325236] = ns.bceSetCataUpNoContShrubbery,
	[56345228] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Under the seat", },
	[56355236] = ns.bceSetCataUpNoContShrubbery,
	[56415168] = ns.bceSetCataUpNoContShrubbery,
	[56555074] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="On top of the tall flask", },
	[56555078] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Under the seat", },
	[56565074] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip=ns.topFlask, },
	[56595073] = ns.bceSetCataUpNoContShrubbery,
	[56715355] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Under the table of food", },
	[56835300] = ns.bceSetCataUpNoContShrubbery,
	[56885281] = ns.bceSetCataUpNoContShrubbery,
	[56915321] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="In the pool", },
	[57065266] = ns.bceSetCataUpNoContShrubbery,
	[57215319] = ns.bceSetCataUpNoCont,
	[57265282] = ns.bceSetCataUpNoCont,
	
	-- This location I found during Dragonflight. Did it exist prior? Dunno
	[55425033] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip="Under the Hippogryph roost", },
}

ns.points[ ns.map.thousand ] = { -- Thousand Needles
	[75007600] = { fling=true, version=30000,
					achievements={ { id=2436, index=5, versionUnder=60000, showAllCriteria=true, tip=ns.L [ "AnywhereZW" ], }, },
					{ id=2436, index=5, version=60000, showAllCriteria=true, tip=ns.L [ "AnywhereZR" ], }, },
}

ns.points[ ns.map.ungoro ] = { -- UnGoro Crater
	[30604880] = { hardBoiled=true, version=30000, versionUnder=40000, achievements={ { id=2416, }, }, guide=ns.L [ "hb2" ], },
	[35805105] = { hardBoiled=true, version=40000, achievements={ { id=2416, }, }, guide=ns.L [ "hb2" ], },
	[54406240] = { hardBoiled=true, version=30000, achievements={ { id=2416, }, }, guide=ns.L [ "hb1" ], },
}

ns.points[ ns.map.kalimdor ] = { -- Kalimdor
	[02504820] = ns.setHardShake,
	[02505250] = ns.setMeta,
	[04705530] = ns.setTravel,
	[05005100] = ns.setFlavour,
	[05204700] = ns.setQuacked,
	[07305400] = ns.setDressUp,
	[07604980] = ns.setChocoholic,
}

--[[points[ 12 ] = { -- Kalimdor Retail - Special for Teldrassil/Dolanaar
	[43941020] = { aID=2419, aIndex=2, faction="Alliance", tip="AnywhereT" }, -- Spring Fling
--	[43741008] = { candy=true, version=30000, faction="Alliance", quests={ { id=13480, name=ns.eggHunt, qType="Daily", }, }, },
	[44701130] = { bce=true, name=ns.bce, version=40000, noContinent=true, preWrath=false, continentShow=true },
}
points[ 1414 ] = { --Kalimdor Classic Special case
	[43581215] = { aID=2419, aIndex=4, faction="Alliance", tip="AnywhereT" }, -- Spring Fling
--	[44001200] = { candy=true, version=30000, faction="Alliance", quests={ { id=13480, name=ns.eggHunt, qType="Daily", }, }, },
	[44601060] = { name="Brightly Colored Egg", preWrath=true, continentShow=true },
	[44901400] = { name="Brightly Colored Egg", preWrath=false, continentShow=true },
}]]

--==================================================================================================================================
--
-- EASTERN KINGDOMS
--
--==================================================================================================================================

ns.points[ ns.map.badlands ] = { -- Badlands
	[53504700] = { fling=true, version=30000,
					achievements={ { id=2436, index=2, versionUnder=60000, showAllCriteria=true, tip=ns.L [ "AnywhereZW" ], }, },
					{ id=2436, index=1, version=60000, showAllCriteria=true, tip=ns.L [ "AnywhereZR" ], }, },
}

ns.points[ ns.map.dunMorogh ] = { -- Dun Morogh
	[53995070] = { eggHunt=true, version=40000, quests={ ns.eggHuntSetA, ns.TisketSetA, }, },
	[46885238] = { eggHunt=true, version=30000, versionUnder=40000, quests={ ns.eggHuntSetA, ns.TisketSetA, }, },
	[46005300] = { fling=true, version=30000, versionUnder=40000, faction="Alliance",
					achievements={ { id=2419, index=2, showAllCriteria=true, }, }, tip=ns.L [ "AnywhereT" ], },
--	[53085172] = { eggcentric=true, version=100000, faction="Alliance", quests={ { id=73192, name=ns.anEcD, qType="Daily", }, }, },
	[53614977] = { fling=true, faction="Alliance",
					achievements={ { id=2419, index=2, version=40000, versionUnder=60000, showAllCriteria=true, }, 
					{ id=2419, index=4, version=60000, showAllCriteria=true, }, }, tip=ns.L [ "AnywhereT" ], },

	-- Vanilla + TBC only
	[20957670] = ns.bceSetPreWrathNoCont,
	[22507490] = ns.bceSetPreWrathNoCont, -- A
	[22608000] = ns.bceSetPreWrathNoCont,
	[22708040] = ns.bceSetPreWrathNoCont, -- A
	[22957475] = ns.bceSetPreWrathNoCont,
	[25207590] = ns.bceSetPreWrathNoCont,
	[26203815] = ns.bceSetPreWrathNoCont,
	[26207950] = ns.bceSetPreWrathNoCont, -- A
	[26707240] = ns.bceSetPreWrathNoCont, -- A
	[27203510] = ns.bceSetPreWrathNoCont,
	[29106950] = ns.bceSetPreWrathNoCont, -- A
	[29607210] = ns.bceSetPreWrathNoCont, -- A
	[29703630] = ns.bceSetPreWrathNoCont,
	[30207170] = ns.bceSetPreWrathNoCont,
	[31405860] = ns.bceSetPreWrathNoCont,
	[33404990] = ns.bceSetPreWrathNoCont, -- A
	[34107230] = ns.bceSetPreWrathNoCont,
	[34705290] = ns.bceSetPreWrathNoCont, -- A
	[35605850] = ns.bceSetPreWrathNoCont, -- A
	[38003320] = ns.bceSetPreWrathNoCont, -- A
	[41104870] = ns.bceSetPreWrathNoCont,
	[41404550] = ns.bceSetPreWrathNoCont,
	[42905740] = ns.bceSetPreWrathNoCont,
	[43202990] = ns.bceSetPreWrathNoCont, -- A
	[44003710] = ns.bceSetPreWrathNoCont,
	[44606680] = ns.bceSetPreWrathNoCont,
	[44705410] = ns.bceSetPreWrathNoCont, -- A
	[45705850] = ns.bceSetPreWrathNoCont,
	[45904800] = ns.bceSetPreWrathNoCont,
	[48605110] = ns.bceSetPreWrathNoCont,
	[48905760] = ns.bceSetPreWrathNoCont,
	[49703790] = ns.bceSetPreWrathNoCont,
	[50006440] = ns.bceSetPreWrathNoCont,
	[55704910] = ns.bceSetPreWrath, -- A
	[60405280] = ns.bceSetPreWrathNoCont,
	[71505240] = ns.bceSetPreWrathNoCont,
	[74805990] = ns.bceSetPreWrathNoCont,
	[78406050] = ns.bceSetPreWrathNoCont,

	-- WotLK - Eggs are now clustered within Kharanos rather than spread zone wide. WotLK only because the
	-- Cataclysm Dun Morogh map requires a different coordinate system
	[45495098] = ns.bceSetWrathOnlyNoCont,
	[45645129] = ns.bceSetWrathOnlyNoCont,
	[45655268] = ns.bceSetWrathOnlyNoCont,
	[45665109] = ns.bceSetWrathOnlyNoCont,
	[45765211] = ns.bceSetWrathOnlyNoCont,
	[45815157] = ns.bceSetWrathOnlyNoCont,
	[45825130] = ns.bceSetWrathOnlyNoCont,
	[45875162] = ns.bceSetWrathOnlyNoCont,
	[45945231] = ns.bceSetWrathOnlyNoCont,
	[45965040] = ns.bceSetWrathOnly,
	[45975203] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="Under the crate", },
	[45995164] = ns.bceSetWrathOnlyNoCont,
	[45995199] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="In the Barrel", },
	[46245098] = ns.bceSetWrathOnlyNoCont,
	[46255056] = ns.bceSetWrathOnlyNoCont,
	[46285214] = ns.bceSetWrathOnlyNoCont,
	[46285224] = ns.bceSetWrathOnlyNoCont,
	[46305344] = ns.bceSetWrathOnlyNoCont,
	[46305369] = ns.bceSetWrathOnlyNoCont,
	[46315328] = ns.bceSetWrathOnlyNoCont,
	[46555226] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="Alongside the lamp post", },
	[46665449] = ns.bceSetWrathOnlyNoCont,
	[46835052] = ns.bceSetWrathOnlyNoCont,
	[46685082] = ns.bceSetWrathOnlyNoCont,
	[46695335] = ns.bceSetWrathOnlyNoCont,
	[46705220] = ns.bceSetWrathOnlyNoCont,
	[46705410] = ns.bceSetWrathOnlyNoCont,
	[46735095] = ns.bceSetWrathOnlyNoCont,
	[46735413] = ns.bceSetWrathOnlyNoCont,
	[46765350] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="Under the wagon", },
	[46775429] = ns.bceSetWrathOnlyNoCont,
	[46775223] = ns.bceSetWrathOnlyNoCont,
	[46785359] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="Under the wagon", },
	[46825366] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, 
					tip="Between three stacks of crates and a large barrel", },
	[46875212] = ns.bceSetWrathOnlyNoCont,
	[46905220] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="In a nook on the stairs", },
	[46905416] = ns.bceSetWrathOnlyNoCont,
	[46915223] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true,
					tip="In the nook alongside the stairs", },
	[46985369] = ns.bceSetWrathOnlyNoCont,
	[47035213] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true,
					tip="Behind the seat, in the corner. Well hidden!", },
	[47065169] = ns.bceSetWrathOnlyNoCont,
	[47085181] = ns.bceSetWrathOnlyNoCont,
	[47045258] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true,
					tip="Uncollectable due to mailbox proximity", },
	[47195178] = ns.bceSetWrathOnlyNoCont,
	[47205290] = ns.bceSetWrathOnlyNoCont,
	[47225325] = ns.bceSetWrathOnlyNoCont,
	[47345362] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="Alongside the cauldron", },
	[47355375] = ns.bceSetWrathOnlyNoCont,
	[47365364] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="Inside the cauldron", },
	[47465138] = ns.bceSetWrathOnlyNoCont,

	-- From Cataclysm and onwards. Pretty much the same egg locations, just with different coordinates
	[52584929] = ns.bceSetCataUpNoCont,
	[52744960] = ns.bceSetCataUpNoCont,
	[52755101] = ns.bceSetCataUpNoCont,
	[52755129] = ns.bceSetCataUpNoCont,
	[52764941] = ns.bceSetCataUpNoCont,
	[52865043] = ns.bceSetCataUpNoCont,
	[52914989] = ns.bceSetCataUpNoCont,
	[52934961] = ns.bceSetCataUpNoCont,
	[52974994] = ns.bceSetCataUpNoCont,
	[53045063] = ns.bceSetCataUpNoCont,
	[53064871] = ns.bceSetCataUpNoCont,
	[53075034] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Under the inclined crate. Clever!", },
	[53094996] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Between the two crates", },
	[53095031] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Inside the broken cask", },
	[53344912] = ns.bceSetCataUpNoCont,
	[53344930] = ns.bceSetCataUpNoCont,
	[53354905] = ns.bceSetCataUpNoCont,
	[53364887] = ns.bceSetCataUp,
	[53365073] = ns.bceSetCataUpNoCont,
	[53385030] = ns.bceSetCataUpNoCont,
	[53405202] = ns.bceSetCataUpNoCont,
	[53415161] = ns.bceSetCataUpNoCont,
	[53415186] = ns.bceSetCataUpNoCont,
	[53415177] = ns.bceSetCataUpNoCont,
	[53415186] = ns.bceSetCataUpNoCont,
	[53775282] = { bce=true, name=ns.bce, version=40000, },
	[53794913] = ns.bceSetCataUpNoCont,
	[53805168] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Half concealed by straw bales", },
	[53815052] = ns.bceSetCataUpNoCont,
	[53815243] = ns.bceSetCataUpNoCont,
	[53835246] = ns.bceSetCataUpNoCont,
	[53855182] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Under the front wheels of the wagon", },
	[53885055] = ns.bceSetCataUpNoCont,
	[53895192] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Under the rear wheels of the wagon", },
	[53895263] = ns.bceSetCataUpNoCont,
	[53935200] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Between three stacks of crates and a large barrel", },
	[53944884] = ns.bceSetCataUpNoCont,
	[53985045] = ns.bceSetCataUpNoCont,
	[54005052] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Top of the stairs", },
	[54015055] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Bottom of the stairs", },
	[54015250] = ns.bceSetCataUpNoCont,
	[54025013] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="On the ledge", },
	[54095202] = ns.bceSetCataUpNoCont,
	[54145045] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Behind the seat, in the corner. Well hidden! "
					.."Careful! Don't jump in or you might get stuck!\n\n(I had to in order to get the coordinates super-accurately. "
					.."Yeah... I took a hit for the team lol)", },
	[54155089] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Behind the mailbox", },
	[54165074] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="On the ledge", },
	[54185001] = ns.bceSetCataUpNoCont,
	[54195013] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="On the building ledge", },
	[54295010] = ns.bceSetCataUpNoCont,
	[54315123] = ns.bceSetCataUpNoCont,
	[54335158] = ns.bceSetCataUpNoCont,
	[54465208] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Alongside a crate with a clipboard", },
	[54475198] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Inside the cauldron", },
	[54655195] = { bce=true, name=ns.bce, version=40000, noContinent=true, tip="Between a cauldron and a larger upright crate", },
	[54574969] = ns.bceSetCataUpNoCont,

	-- These locations I found during Dragonflight. Did they exist prior? Dunno
	[53215157] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip="Upon the Noblegarden crates", },
	[53355264] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip="Alonsgide the Noblegarden crates", },
	[53385057] = { bce=true, name=ns.bce, version=100000, noContinent=true, },
	[53645059] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip="Behind the direction post", },
	[53735310] = { bce=true, name=ns.bce, version=100000, noContinent=true, },
	[53785284] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip="Under a Gryphon roost", },
	[53844926] = { bce=true, name=ns.bce, version=100000, noContinent=true, },
	[53865285] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip="Upon the Noblegarden crate", },
	[53874983] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip=ns.wreathEasle, },
	[53895244] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip="Between the muskets and the tent", },
	[53965268] = { bce=true, name=ns.bce, version=100000, noContinent=true, },
}

ns.points[ ns.map.elwynn ] = { -- Elwynn Forest
	[18944592] = { quack=true, name="Emmery Fiske", version=100000, faction="Alliance", quests=ns.quackingDownSetA, },
	[29144697] = { hide=true, version=30000, faction="Alliance", achievements={ { id=2421, }, }, guide=ns.L[ "hide" ], },
	[30279140] = { quack=true, name="Golden Egg Heirloom", version=100000, faction="Alliance", quests=ns.quackingDownSetA,
					tip=ns.bigNest, },
	[33677082] = { quack=true, name="Golden Egg Heirloom", version=100000, faction="Alliance", quests=ns.quackingDownSetA,
					tip=ns.daetanSwoop, },
--	[42306690] = { eggcentric=true, version=100000, faction="Alliance", quests={ { id=73192, name=ns.anEcD, qType="Daily", }, }, },
	[41906380] = { fling=true, version=30000, faction="Alliance",
					achievements={ { id=2419, index=3, showAllCriteria=true, }, }, tip=ns.L [ "AnywhereT" ], },
	[43706380] = { eggHunt=true, version=30000, quests={ ns.eggHuntSetA, ns.TisketSetA, }, },
	[41306500] = { quack=true, name="Zinnia Brooks", version=100000, faction="Alliance", quests=ns.quackingDownSetA, },

	-- Daetan / Golden Egg
--	[33677084] = ns.daetanDailyDSetA,
	[29008650] = ns.daetanDailyGESetA,
	[30509100] = ns.daetanDailyGESetA,
	[34508150] = ns.daetanDailyGESetA,
	[35009050] = ns.daetanDailyGESetA,

	-- Vanilla + TBC only
	[24055850] = ns.bceSetPreWrathNoCont,
	[26906830] = ns.bceSetPreWrathNoCont,
	[27708320] = ns.bceSetPreWrathNoCont,
	[30208240] = ns.bceSetPreWrathNoCont,
	[30305860] = ns.bceSetPreWrathNoCont,
	[31106490] = ns.bceSetPreWrathNoCont,
	[32407510] = ns.bceSetPreWrathNoCont,
	[32906120] = ns.bceSetPreWrathNoCont,
	[34005770] = ns.bceSetPreWrathNoCont,
	[35405590] = ns.bceSetPreWrathNoCont,
	[37707970] = ns.bceSetPreWrathNoCont,
	[39906850] = ns.bceSetPreWrathNoCont,
	[40107445] = ns.bceSetPreWrathNoCont,
	[41408690] = ns.bceSetPreWrathNoCont,
	[41806160] = ns.bceSetPreWrathNoCont,
	[42008340] = ns.bceSetPreWrathNoCont,
	[42108340] = ns.bceSetPreWrathNoCont,
	[44603400] = ns.bceSetPreWrathNoCont,
	[45208205] = ns.bceSetPreWrathNoCont,
	[46106350] = ns.bceSetPreWrathNoCont,
	[46404670] = ns.bceSetPreWrathNoCont,
	[47203210] = ns.bceSetPreWrathNoCont,
	[47603560] = ns.bceSetPreWrathNoCont,
	[48904040] = ns.bceSetPreWrathNoCont,
	[49905100] = ns.bceSetPreWrathNoCont,
	[51806040] = ns.bceSetPreWrathNoCont,
	[53308580] = ns.bceSetPreWrathNoCont,
	[55306300] = ns.bceSetPreWrathNoCont,
	[57106210] = ns.bceSetPreWrathNoCont,
	[57806910] = ns.bceSetPreWrathNoCont,
	[62205340] = ns.bceSetPreWrath,
	[65607050] = ns.bceSetPreWrathNoCont,
	[68405090] = ns.bceSetPreWrathNoCont,
	[73105560] = ns.bceSetPreWrathNoCont,
	[73407690] = ns.bceSetPreWrathNoCont,
	[76006190] = ns.bceSetPreWrathNoCont,
	[77055015] = ns.bceSetPreWrathNoCont,
	[77103710] = ns.bceSetPreWrathNoCont,
	[77506950] = ns.bceSetPreWrathNoCont,
	[80505370] = ns.bceSetPreWrathNoCont,
	[81108230] = ns.bceSetPreWrathNoCont,
	[84508230] = ns.bceSetPreWrathNoCont,
	[88306730] = ns.bceSetPreWrathNoCont,
	[89307970] = ns.bceSetPreWrathNoCont,

	-- From WotLK and upwards through Cataclysm and onwards. Goldshire rather than spread through Elwynn Forest
	[39836560] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Concealed in the reeds", },
	[39976465] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Concealed in the reeds", },
	[39996485] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Concealed in the reeds", },
	[40076585] = ns.bceSetWrathUpNoContShrubbery,
	[40586577] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="At the base of the archery target", },
	[40746514] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Between the bellows and the furnace", },
	[40816629] = ns.bceSetWrathUpNoContLampPost,
	[40936426] = ns.bceSetWrathUpNoContShrubbery,
	[40946387] = ns.bceSetWrathUpNoContShrubbery,
	[40976472] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Between the bellows and the furnace", },
	[41086409] = ns.bceSetWrathUpNoContShrubbery,
	[41186569] = ns.bceSetWrathUpNoCont,
	[41296369] = ns.bceSetWrathUpNoCont,
	[41556737] = ns.bceSetWrathUpNoCont,
	[41606427] = ns.bceSetWrathUpNoContLampPost,
	[41776528] = ns.bceSetWrathUpNoCont,
	[41836729] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Under the wagon", },
	[41876637] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="In the small water trough", },
	[41896549] = ns.bceSetWrathUpNoCont,
	[41896586] = ns.bceSetWrathUpNoCont,
	[41996746] = ns.bceSetWrathUpNoCont,
	[42016544] = ns.bceSetWrathUpNoContShrubbery,
	[42016585] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip=ns.wreathEasle, },
	[42016626] = ns.bceSetWrathUpNoContShrubbery,
	[42296759] = ns.bceSetWrathUpNoContShrubbery,
	[42416417] = ns.bceSetWrathUpNoContShrubbery,
	[42416439] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Alongside the lamp post", },
	[42486745] = ns.bceSetWrathUpNoContLampPost,
	[42626419] = ns.bceSetWrathUpNoContShrubbery,
	[42746645] = ns.bceSetWrathUpNoContLampPost,
	[42796389] = ns.bceSetWrathUpNoContShrubbery,
	[42936674] = ns.bceSetWrathUpNoContShrubbery,
	[42946552] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Behind the mailbox. Very difficult to obtain", },
	[42966616] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="In the horses' drinking trough", },
	[42996617] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Behind the horses' drinking trough", },
	[43026589] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="In the crate", },
	[43046637] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="In the nook", },
	[43056628] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="On the ledge, behind the jugs", },
	[43096472] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Alongside the lamp post", },
	[43096474] = ns.bceSetWrathUpNoContLampPost,
	[43096587] = ns.bceSetWrathUpNoCont,
	[43116547] = ns.bceSetWrathUpNoCont,
	[43116650] = ns.bceSetWrathUpNoCont,
	[43206534] = ns.bceSetWrathUpNoCont,
	[43306657] = ns.bceSetWrathUpNoCont,
	[43456539] = ns.bceSetWrathUpNoCont,
	[43496653] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="High above on a ledge over the window", },
	[43496661] = ns.bceSetWrathUpNoCont,
	[43676664] = ns.bceSetWrathUpNoCont,
	[43706738] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Nestled between the three trees", },
	[43816551] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="High above on a ledge over the window", },
	[43866665] = ns.bceSetWrathUpNoCont,
	[43946653] = ns.bceSetWrathUpNoCont,
	[43976619] = ns.bceSetWrathUpNoCont,
	[44376627] = ns.bceSetWrathUpNoCont,
	[44036640] = ns.bceSetWrathUpNoCont,
	[44076635] = ns.bceSetWrathUpNoCont,
	[44436554] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="In a tuft of grass", },
	[44516615] = ns.bceSetWrathUpNoCont,
	[44556568] = ns.bceSetWrathUp,
}

ns.points[ ns.map.eversong ] = { -- Eversong Woods
--	[46704710] = { eggcentric=true, version=100000, faction="Horde", quests={ { id=74955, name=ns.anEcD, qType="Daily", }, }, },
	[47604600] = { fling=true, faction="Alliance",
					achievements={ { id=2497, index=2, version=30000, versionUnder=60000, showAllCriteria=true, },				
					{ id=2497, index=3, version=60000, showAllCriteria=true, }, }, tip=ns.L [ "AnywhereS" ], },
	[47784713] = { eggHunt=true, version=30000, quests={ ns.eggHuntSetH, ns.TisketSetH, }, },
	[58003900] = { hide=true, version=30000, faction="Horde", achievements={ { id=2420, }, }, guide=ns.L[ "hide" ], },

	-- In Classic TBC was this present? Dunno. In original retail it was not added until WotLK, so I'm going with that
	[46204688] = { name="Brightly Colored Egg", preCata=false, tip="In the very centre of the egg display" },
	[46264606] = ns.bceSetWrathUpNoContTuckedIn,
	[46274721] = ns.bceSetWrathUpNoContTuckedIn,
	[46304692] = ns.bceSetWrathUpNoContTuckedIn,
	[46344633] = ns.bceSetWrathUpNoContTuckedIn,
	[46344752] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Behind the lamp post", },
	[46354661] = ns.bceSetWrathUpNoContTuckedIn,
	[46354802] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Between the end of the fence and the wall", },
	[46384646] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Between the fence and a shrub", },
	[46514557] = ns.bceSetWrathUpNoContTuckedIn,
	[46694563] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Partly concealed by a shrub", },
	[46734801] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Between the end of the fence and the wall", },
	[46794570] = ns.bceSetWrathUpNoContTuckedIn,
	[46804654] = { bce=true, name=ns.bce, version=30000, tip="Under the bench seat", },
	[46854763] = { bce=true, name=ns.bce, version=30000, noContinent=true,
					tip="Adjacent to three barrels and a hexagonal wooden drum", },
	[46874794] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Between the crates and the wall", },
	[46884563] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Between a tree and the fence", },
	[46964641] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="In the fountain, by the edge", },
	[46974678] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Under the bench seat", },
	[47004769] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Between crates and a keg", },
	[47024645] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="In the fountain, at the centre", },
	[47024767] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Inside the stacked crates", },
	[47054626] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="In the fountain, by the edge", },
	[47054637] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="In the fountain, at the centre", },
	[47064657] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="In the fountain, by the edge", },
	[47084644] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="In the fountain, at the centre", },
	[47084763] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Under the wagon, concealled by crates", },
	[47104545] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Jammed between the fence corner and a tree", },
	[47104607] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Under the bench seat", },
	[47154771] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Alongside a front wagon wheel", },
	[47164641] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="In the fountain, by the edge", },
	[47224791] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Between the tree with the terrible box shaped "
					.."\"leaf\" patterned sides and the wall", },
	[47244778] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Between the tree and the wall", },
	[47274534] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Between a tree and the fence", },
	[47274753] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Behind a lamp post", },
	[47284630] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Under the bench seat", },
	[47334754] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Behind a tree", },
	[47464745] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Between the tree and the wall", },
	[47484526] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Between the fence and a tree", },
	[47544527] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Between a rear wagon wheel and the fence", },
	[47544539] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Under the wagon, adjacent to a rear wheel", },
	[47554741] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Behind the lamp post and teh fence", },
	[47564535] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="In the wagon", },
	[47594527] = { bce=true, name=ns.bce, version=30000, noContinent=true,
					tip="Adjacent to, and outside of, a front wheel of the wagon", },
	[47604539] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Under the wagon, adjacent to a front wheel", },
	[47634750] = { bce=true, name=ns.bce, version=30000, noContinent=true,
					tip="Let's stash it behind the tree man, nobody'll look here!", },
	[47684558] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Inside the crate", },
	[47694521] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Between a tree trunk and the fence / lamp post", },
	[47774553] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Behind the lamp post", },
	[47834687] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Behind the lamp post", },
	[47874690] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Between the tree and the wall", },
	[47904709] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="You think they'll see it if we stash it here?", },
	[47914672] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Between the tree and the wall", },
	[47924524] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Behind the tree", },
	[47944546] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Behind the tree", },
	[47964649] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Behind the lamp post", },
	[47984556] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Between the tree and the wall", },
	[47994584] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Behind the lamp post", },
	[48004657] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Between the tree and the wall", },
	[48054567] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="Behind the tree", },
	[48134564] = { bce=true, name=ns.bce, version=30000, noContinent=true, tip="In the nook", },
	[48134586] = { bce=true, name=ns.bce, version=30000, noContinent=true,
					tip="Nah braaaah, if we stash it in the open here nobody'll think to look!\n\n"
						.."Brilliant man, why didn't I think of that!", },
	[48134649] = ns.bceSetWrathUpNoCont,
}

ns.points[ ns.map.silvermoon ] = { -- Silvermoon City
	[66002780] = { hide=true, version=30000, faction="Horde", achievements={ { id=2420, }, }, guide=ns.L[ "hide" ], },
}

ns.points[ ns.map.stormwind ] = { -- Stormwind City
	[48628690] = { quack=true, name="Emmery Fiske", version=100000, faction="Alliance", quests=ns.quackingDownSetA,
					tip=ns.emmeryFisk, },
	[69008900] = { hide=true, version=30000, faction="Alliance", achievements={ { id=2421, }, }, guide=ns.L[ "hide" ], },
}

ns.points[ ns.map.tirisfal ] = { -- Tirisfal Glades
--	[60005150] = { eggcentric=true, version=100000, faction="Horde", quests={ { id=74955, name=ns.anEcD, qType="Daily", }, }, },
	[60815152] = { fling=true, version=30000, versionUnder=40000, faction="Alliance",
					achievements={ { id=2497, index=3, showAllCriteria=true, }, }, tip=ns.L [ "AnywhereT" ], },
	[60905090] = { fling=true, faction="Alliance",
					achievements={ { id=2497, index=3, version=40000, versionUnder=60000, showAllCriteria=true, },
					{ id=2497, index=2, version=60000, showAllCriteria=true, }, }, tip=ns.L [ "AnywhereT" ], },
	[61605300] = { eggHunt=true, version=40000, quests={ ns.eggHuntSetH, ns.TisketSetH, }, },
	[61635311] = { eggHunt=true, version=30000, versionUnder=40000, quests={ ns.eggHuntSetH, ns.TisketSetH, }, },

	-- Vanilla + TBC only
	[33404640] = ns.bceSetPreWrathNoCont,
	[35505920] = ns.bceSetPreWrathNoCont,
	[36006230] = ns.bceSetPreWrathNoCont,
	[37104280] = ns.bceSetPreWrathNoCont,
	[37905620] = ns.bceSetPreWrathNoCont,
	[38104710] = ns.bceSetPreWrathNoCont,
	[39605400] = ns.bceSetPreWrathNoCont,
	[40004170] = ns.bceSetPreWrathNoCont,
	[41505770] = ns.bceSetPreWrathNoCont,
	[42805840] = ns.bceSetPreWrathNoCont,
	[43104430] = ns.bceSetPreWrathNoCont,
	[44506350] = ns.bceSetPreWrathNoCont,
	[45006680] = ns.bceSetPreWrathNoCont,
	[46504560] = ns.bceSetPreWrathNoCont,
	[48806880] = ns.bceSetPreWrathNoCont,
	[49603320] = ns.bceSetPreWrathNoCont,
	[49703550] = ns.bceSetPreWrath,
	[52204800] = ns.bceSetPreWrathNoCont,
	[52502710] = ns.bceSetPreWrathNoCont,
	[53104470] = ns.bceSetPreWrathNoCont,
	[53104730] = ns.bceSetPreWrathNoCont,
	[53206120] = ns.bceSetPreWrathNoCont,
	[53505170] = ns.bceSetPreWrathNoCont,
	[53804270] = ns.bceSetPreWrathNoCont,
	[53907000] = ns.bceSetPreWrathNoCont,
	[58003390] = ns.bceSetPreWrathNoCont,
	[60506360] = ns.bceSetPreWrathNoCont,
	[61104040] = ns.bceSetPreWrathNoCont,
	[61204430] = ns.bceSetPreWrathNoCont,
	[61603260] = ns.bceSetPreWrathNoCont,
	[61804300] = ns.bceSetPreWrathNoCont,
	[68406640] = ns.bceSetPreWrathNoCont,
	[69203510] = ns.bceSetPreWrathNoCont,
	[71803100] = ns.bceSetPreWrathNoCont,
	[72505690] = ns.bceSetPreWrathNoCont,
	[75105450] = ns.bceSetPreWrathNoCont,
	[75205440] = ns.bceSetPreWrathNoCont,
	[75503300] = ns.bceSetPreWrathNoCont,
	[79304000] = ns.bceSetPreWrathNoCont,
	[79606030] = ns.bceSetPreWrathNoCont,
	[80006430] = ns.bceSetPreWrathNoCont,
	[81604820] = ns.bceSetPreWrathNoCont,
	[82604750] = ns.bceSetPreWrathNoCont,
	[88005520] = ns.bceSetPreWrathNoCont,

	-- WotLK - Eggs are now clustered within Brill rather than spread zone wide. WotLK only because the
	-- Cataclysm version of Brill was a total makeover
	[59295232] = ns.bceSetWrathOnlyNoContShrubbery,
	[59355219] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="Above, in the planter box", },
	[59395204] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="Inside the broken keg", },
	[59465259] = ns.bceSetWrathOnlyNoContShrubbery,
	[59495201] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="In the planter box", },
	[59665211] = ns.bceSetWrathOnlyNoContShrubbery,
	[59665283] = ns.bceSetWrathOnlyNoContShrubbery,
	[59695390] = ns.bceSetWrathOnlyNoContShrubbery,
	[59705290] = ns.bceSetWrathOnlyNoContShrubbery,
	[59725136] = ns.bceSetWrathOnlyNoContShrubbery,
	[59765293] = ns.bceSetWrathOnlyNoContShrubbery,
	[59895205] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip=ns.streetLamp, },
	[59925320] = ns.bceSetWrathOnlyNoCont,
	[60015363] = ns.bceSetWrathOnly,
	[60375368] = ns.bceSetWrathOnlyNoContShrubbery,
	[60385100] = ns.bceSetWrathOnlyNoContShrubbery,
	[60395407] = ns.bceSetWrathOnlyNoContShrubbery,
	[60435358] = ns.bceSetWrathOnlyNoContShrubbery,
	[60455103] = ns.bceSetWrathOnlyNoContShrubbery,
	[60565011] = ns.bceSetWrathOnlyNoContShrubbery,
	[60645007] = ns.bceSetWrathOnlyNoContShrubbery,
	[60655136] = ns.bceSetWrathOnlyNoContShrubbery,
	[60925335] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="In the well", },
	[60985181] = ns.bceSetWrathOnlyNoContShrubbery,
	[61025168] = ns.bceSetWrathOnlyNoContShrubbery,
	[61165141] = ns.bceSetWrathOnlyNoContShrubbery,
	[61245036] = ns.bceSetWrathOnlyNoContShrubbery,
	[61245254] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true,
					tip="Under the General Supplies cart", },
	[61435265] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="Under the window sill/bench", },
	[61445048] = ns.bceSetWrathOnlyNoContShrubbery,
	[61445257] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="Under the window sill/bench", },
	[61455093] = ns.bceSetWrathOnlyNoContShrubbery,
	[61485288] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true,
					tip="In a nook but the view is blocked by shrubbery", },
	[61495164] = ns.bceSetWrathOnlyNoContShrubbery,
	[61495208] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="Under the window sill/bench", },
	[61505084] = ns.bceSetWrathOnlyNoContShrubbery,
	[61515201] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="Under the window sill/bench", },
	[61525145] = ns.bceSetWrathOnlyNoContShrubbery,
	[61545173] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true,
					tip="Behind the stacked boxes, well concealed!", },
	[61565354] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip=ns.streetLamp, },
	[61655122] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true,
					tip="Behind the crate and the dilapidated keg", },
	[61795295] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true,
					tip="Under the window sill/bench and\nconcealed by shrubbery. Doubly hidden!", },
	[61865128] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true, tip="Behind two kegs", },
	[61885191] = ns.bceSetWrathOnlyNoCont,
	[61895296] = { bce=true, name=ns.bce, version=30000, versionUnder=40000, noContinent=true,
					tip="Under the window sill/bench and\nconcealed by shrubbery. Doubly hidden!", },
	[61965172] = ns.bceSetWrathOnlyNoContShrubbery,
	[62035188] = ns.bceSetWrathOnlyNoContShrubbery,
	[62035264] = ns.bceSetWrathOnlyNoCont,

	-- From Cataclysm and onwards. Brill had a makeover
	[59435221] = { bce=true, name=ns.bce, version=40000, tip="Inside the tent", },
	[59525231] = { bce=true, name=ns.bce, version=40000, tip="Inside the tent", },
	[59615325] = { bce=true, name=ns.bce, version=40000, tip="Inside the alcove, to the left as you enter", },
	[59655271] = { bce=true, name=ns.bce, version=40000, tip="Look up! Between two arcing beams of the plague centrifuge", },
	[59805241] = { bce=true, name=ns.bce, version=40000, tip="Inside the small broken barrel", },
	[59805270] = { bce=true, name=ns.bce, version=40000, tip="Above, in a nook of the plague centrifuge machine", },
	[59875243] = { bce=true, name=ns.bce, version=40000, tip="Trisected by the plague barrels", },
	[59905375] = ns.bceSetCataUpNoContShrubbery,
	[59925213] = { bce=true, name=ns.bce, version=40000, tip="Nestled snugly in the, erm, \"private parts\" of the unlucky "
					.."ogre.\n\nWARNING: Extract carefully to avoid unnecessary spillage of entrails!\n\nNow, look down at the "
					.."bench. The ogre is watching you!", },
	[59955221] = { bce=true, name=ns.bce, version=40000, tip="In the upheld palm of the rotting ogre corpse.\n\nGotta hand it t, "
					.."erm, enough puns...\n\nBut that's a serious case of rigour mortis!", },
	[59955249] = { bce=true, name=ns.bce, version=40000, tip="Behind the planter box", },
	[60045213] = ns.bceSetCataUpNoContLamp,
	[60085256] = { bce=true, name=ns.bce, version=40000, tip="To the right side of the steps as you enter", },
	[60085355] = { bce=true, name=ns.bce, version=40000, tip="In the alcove", },
	[60205348] = { bce=true, name=ns.bce, version=40000, tip="Behind and at one end of the crates", },
	[60305257] = { bce=true, name=ns.bce, version=40000, tip="In the nook", },
	[60325276] = { bce=true, name=ns.bce, version=40000, tip="Jammed in tight here", },
	[60375324] = { bce=true, name=ns.bce, version=40000, tip="Mounted on the apothecary apparatus", },
	[60405089] = { bce=true, name=ns.bce, version=40000, tip="Above, on a window ledge", },
	[60425292] = { bce=true, name=ns.bce, version=40000, tip="Look up! Between two arcing beams of the plague centrifuge", },
	[60425308] = { bce=true, name=ns.bce, version=40000, tip="Behind the two barrels", },
	[60495155] = { bce=true, name=ns.bce, version=40000, tip="Above, in the catapault basket!", },
	[60505251] = ns.bceSetCataUpNoContLamp,
	[60535059] = ns.bceSetCataUpNoCont,
	[60545275] = { bce=true, name=ns.bce, version=40000, tip="In the cart, at the high end, hidden by the plague casks", },
	[60595127] = { bce=true, name=ns.bce, version=40000, tip="In the nook here", },
	[60595338] = { bce=true, name=ns.bce, version=40000, tip="On top of the wheel of the plague tanker", },
	[60675206] = ns.bceSetCataUpNoContLamp,
	[60685352] = { bce=true, name=ns.bce, version=40000, tip="On top of the wheel of the plague tanker", },
	[60755185] = { bce=true, name=ns.bce, version=40000, tip="On the window ledge", },
	[60905223] = ns.bceSetCataUpNoContLamp,
	[60995197] = { bce=true, name=ns.bce, version=40000, tip="Between the wall and two casks", },
	[61115308] = { bce=true, name=ns.bce, version=40000, continentShow=true,
					tip="Within the iron fence at the base of statue of the Banshee Queen", },
	[61125012] = { bce=true, name=ns.bce, version=40000, tip="Concealed in the shrubbery. Glad they're not all like that!\n\n"
					.."(Fun fact: In Wrath almost all the eggs were concealed like this, making Brill despised for egg farming!)", },
	[61125184] = { bce=true, name=ns.bce, version=40000, tip="Behind and at the base of the crates", },
	[61145381] = { bce=true, name=ns.bce, version=40000, tip="adjacent to the wayfinding sign", },
	[61155187] = { bce=true, name=ns.bce, version=40000, tip="On top of the highest of the stacked crates!", },
	[61164982] = { bce=true, name=ns.bce, version=40000, tip="Ew! Buried in the (night) soil", },
	[61165233] = { bce=true, name=ns.bce, version=40000, tip="On the chef's stove", },
	[61175237] = { bce=true, name=ns.bce, version=40000, tip="(Almost) the BEST hidden egg in all of Azeroth.\n\n"
					.."Stand here and look up! Perched on the cross beams!\n\n(The best is at Bloodhoof Village!)", },
	[61235298] = { bce=true, name=ns.bce, version=40000,
					tip="Within the iron fence at the base of the statue\nof The Dark Lady, who surely watches over us", },
	[61235237] = { bce=true, name=ns.bce, version=40000, tip="In the centre and under the meat chopping bench", },
	[61275168] = { bce=true, name=ns.bce, version=40000, tip="In the pet carrying box", },
	[61295090] = { bce=true, name=ns.bce, version=40000, tip="On the slimest of window sills", },
	[61415088] = ns.bceSetCataUpNoCont,
	[61455121] = { bce=true, name=ns.bce, version=40000, tip="Above, on a window ledge", },
	[61455320] = ns.bceSetCataUpNoContLamp,
	[61485293] = ns.bceSetCataUpNoContLamp,
	[61515106] = { bce=true, name=ns.bce, version=40000, tip="Inside the small broken barrel", },
	[61525172] = { bce=true, name=ns.bce, version=40000, tip="In a corner of the low end of the cart", },
	[61675280] = ns.bceSetCataUpNoContShrubbery,
	[61755351] = { bce=true, name=ns.bce, version=40000, tip="Behind two small plague barrels", },
	[61765286] = { bce=true, name=ns.bce, version=40000, tip="Wedged in tight!", },
	[61835310] = { bce=true, name=ns.bce, version=40000, tip="Wedged in tight!", },
	[61895327] = ns.bceSetCataUpNoContShrubbery,
	[61965209] = { bce=true, name=ns.bce, version=40000, tip="Sitting on the skeletal horses' food", },
	[62105169] = { bce=true, name=ns.bce, version=40000, tip="Sitting on the skeletal horses' food", },
	[62205338] = ns.bceSetCataUpNoContShrubbery,
	[62255188] = { bce=true, name=ns.bce, version=40000, tip="Under the meat wagon", },
	[62265279] = { bce=true, name=ns.bce, version=40000, tip="Upon the split cask", },
}

ns.points[ ns.map.easternK ] = { -- Eastern Kingdoms
	[02504820] = ns.setHardShake,
	[02505250] = ns.setMeta,
	[04705530] = ns.setTravel,
	[05005100] = ns.setFlavour,
	[05204700] = ns.setQuacked,
	[07305400] = ns.setDressUp,
	[07604980] = ns.setChocoholic,
}

--==================================================================================================================================
--
-- THE BURNING CRUSADE / OUTLAND
--
--==================================================================================================================================

ns.points[ ns.map.outland ] = { -- Outland
	[02504820] = ns.setHardShake,
	[02505250] = ns.setMeta,
	[04705530] = ns.setTravel,
	[05005100] = ns.setFlavour,
	[05204700] = ns.setQuacked,
	[07305400] = ns.setDressUp,
	[07604980] = ns.setChocoholic,
}

--==================================================================================================================================
--
-- WRATH OF THE LICH KING / NORTHREND
--
--==================================================================================================================================

ns.points[ 113 ] = { -- Northrend
	[02504820] = ns.setHardShake,
	[02505250] = ns.setMeta,
	[04705530] = ns.setTravel,
	[05005100] = ns.setFlavour,
	[05204700] = ns.setQuacked,
	[07305400] = ns.setDressUp,
	[07604980] = ns.setChocoholic,
}

--==================================================================================================================================
--
-- MISTS OF PANDARIA
--
--==================================================================================================================================

ns.points[ 424 ] = { -- Pandaria
	[02504820] = ns.setHardShake,
	[02505250] = ns.setMeta,
	[04705530] = ns.setTravel,
	[05005100] = ns.setFlavour,
	[05204700] = ns.setQuacked,
	[07305400] = ns.setDressUp,
	[07604980] = ns.setChocoholic,
}

--==================================================================================================================================
--
-- WARLORDS OF DRAENOR / GARRISON
--
--==================================================================================================================================

ns.points[ 572 ] = { -- Draenor
	[02504820] = ns.setHardShake,
	[02505250] = ns.setMeta,
	[04705530] = ns.setTravel,
	[05005100] = ns.setFlavour,
	[05204700] = ns.setQuacked,
	[07305400] = ns.setDressUp,
	[07604980] = ns.setChocoholic,
}

--==================================================================================================================================
--
-- LEGION / BROKEN ISLES
--
--==================================================================================================================================

ns.points[ 619 ] = { -- Broken Isles
	[02504820] = ns.setHardShake,
	[02505250] = ns.setMeta,
	[04705530] = ns.setTravel,
	[05005100] = ns.setFlavour,
	[05204700] = ns.setQuacked,
	[07305400] = ns.setDressUp,
	[07604980] = ns.setChocoholic,
}

--==================================================================================================================================
--
-- BATTLE FOR AZEROTH / KUL TIRAS & ZANDALAR
--
--==================================================================================================================================

ns.points[ 876 ] = { -- Kul Tiras
	[02504820] = ns.setHardShake,
	[02505250] = ns.setMeta,
	[04705530] = ns.setTravel,
	[05005100] = ns.setFlavour,
	[05204700] = ns.setQuacked,
	[07305400] = ns.setDressUp,
	[07604980] = ns.setChocoholic,
}

ns.points[ 875 ] = { -- Zandalar
	[02504820] = ns.setHardShake,
	[02505250] = ns.setMeta,
	[04705530] = ns.setTravel,
	[05005100] = ns.setFlavour,
	[05204700] = ns.setQuacked,
	[07305400] = ns.setDressUp,
	[07604980] = ns.setChocoholic,
}

--==================================================================================================================================
--
-- SHADOWLANDS
--
--==================================================================================================================================

ns.points[ 1550 ] = { -- Shadowlands
	[02504820] = ns.setHardShake,
	[02505250] = ns.setMeta,
	[04705530] = ns.setTravel,
	[05005100] = ns.setFlavour,
	[05204700] = ns.setQuacked,
	[07305400] = ns.setDressUp,
	[07604980] = ns.setChocoholic,
}

--==================================================================================================================================
--
-- DRAGONFLIGHT / DRAGON ISLES
--
--==================================================================================================================================

ns.points[ 2112 ] = { -- Valdrakken
	[53406000] = { eggHunt=true, version=100000, quests={ ns.eggHuntSetA, ns.eggHuntSetH, }, },

	[43615708] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip=ns.cornerNook, },
	[44935922] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip=ns.cornerNook, },
	[45335674] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip="On the planter ledge", },
	[45555512] = { bce=true, name=ns.bce, version=100000, noContinent=true,
				tip="Betweeb Rowie and the Noblegarden banner. Incredibly difficult to select as you'll likely select Rowie", },
	[46195167] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip="Under the big leaf", },
	[46625144] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip="Wedged between the crates", },
	[47885704] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip="Under one end of the seat", },
	[48125114] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip=ns.wreathEasle, },
	[48536402] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip="On the grass at the foot of the tree", },
	[49425763] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip="High up on a ledge of the fountain", },
	[49455850] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip=ns.cornerNook .." in the fountain", },
	[49476087] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip=ns.cornerNook, },
	[49764842] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip="In the little bucket next the Argali trough", },
	[49856342] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip="On top of the trellis", },
	[49955741] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip=ns.cornerNook .." in the fountain", },
	[49974991] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip="Under the rake", },
	[50405787] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip="Between the crates and the fountain", },
	[50456326] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip="Under the foliage, against the trellis", },
	[50875219] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip=ns.cornerNook, },
	[51074899] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip="Sitting on the crates", },
	[51235852] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip="Under the seat", },
	[51386230] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip="On the grass, against the ledge", },
	[51534977] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip="Well hidden in the shrubbery in this nook!", },
	[53145591] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip="On the books", },
	[54266152] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip="In the fountain, lower/larger level", },
	[54546436] = { bce=true, name=ns.bce, version=100000, noContinent=true, tip="On the planter ledge", },
}

ns.points[ 1978 ] = { -- Dragon Isles
	[02504820] = ns.setHardShake,
	[02505250] = ns.setMeta,
	[04705530] = ns.setTravel,
	[05005100] = ns.setFlavour,
	[05204700] = ns.setQuacked,
	[07305400] = ns.setDressUp,
	[07604980] = ns.setChocoholic,
}

--==================================================================================================================================
--
-- THE WAR WITHIN / KHAZ ALGAR
--
--==================================================================================================================================

ns.points[ 2274 ] = { -- Khaz Algar
	[02504820] = ns.setHardShake,
	[02505250] = ns.setMeta,
	[04705530] = ns.setTravel,
	[05005100] = ns.setFlavour,
	[05204700] = ns.setQuacked,
	[07305400] = ns.setDressUp,
	[07604980] = ns.setChocoholic,
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
ns.textures[11] = "Interface\\AddOns\\HandyNotes_NobleGarden\\NobleBlue"
ns.textures[12] = "Interface\\AddOns\\HandyNotes_NobleGarden\\NobleLightGreen"
ns.textures[13] = "Interface\\AddOns\\HandyNotes_NobleGarden\\NobleMagenta"
ns.textures[14] = "Interface\\AddOns\\HandyNotes_NobleGarden\\NobleOrange"
ns.textures[15] = "Interface\\AddOns\\HandyNotes_NobleGarden\\NoblePurple"
ns.textures[16] = "Interface\\AddOns\\HandyNotes_NobleGarden\\NobleRed"
ns.textures[17] = "Interface\\AddOns\\HandyNotes_NobleGarden\\NobleTurquoise"
ns.textures[18] = "Interface\\AddOns\\HandyNotes_NobleGarden\\NobleYellow"

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
ns.scaling[11] = 0.42
ns.scaling[12] = 0.42
ns.scaling[13] = 0.42
ns.scaling[14] = 0.42
ns.scaling[15] = 0.42
ns.scaling[16] = 0.42
ns.scaling[17] = 0.42
ns.scaling[18] = 0.42
