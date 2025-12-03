local _, ns = ...

--==================================================================================================================================
--
-- SETUP
--
--==================================================================================================================================

ns.addOnName = "PB"										-- Used to name globals etc. Unique within the Taraezor ecosystem.
ns.eventName = ns.L[ "Pilgrim's Bounty" ]				-- The player sees this in labels and titles.
ns.engine = { version=2.02, resetEngine=2.00 }			-- Set ns.engine to {} to bypass versioning. Flags are optional. version =
														-- The engine version. resetEngine: if the saved ENGINE version is < 
														-- resetEngine then erase any saved variables. resetAddOn: Same but tests
														-- against the ADDON TOC version number.
ns.slashCommands = { "/pb" }							-- Chat command shortcuts to bring up a configuration panel.
ns.db = "Taraezor_" ..ns.addOnName						-- Saved variables. Uses the WoW DB system and not the Ace DB system.
ns.points = {}											-- ns.points[ mapID ] = { titles, names, achievements, quests, etc }.
ns.wordwrap = true										-- If false then code \n. If true/false then \n\n still work as usual.
ns.noZidormiCheck = false								-- Used by AddOns zones with Zidormi phases. See Functions_Common for usage.
														-- Set to true here to ignore checking maps with Zidormi phases.
ns.series = {}											-- System for allocating textures and text colours to a "Series" of map pins.
ns.optionsSeriesDefaults = { 33, 31, 38, 37, 35 }		-- The ns.textures[i] default for each Series. Used in Options_Common.
ns.seriesMapping = { 31, 31, 31, 31, 31 } 				-- The start of each series in ns.tectures. Used in Functions_Common.

ns.clusterNames = { "tables", "meta", "dailies", "flavour", "cooking", "turkeys", "dungeon" }
								-- Used to allocate textures to pin clusters. The Pin Cluster system is separate from the Series
								-- texture system. Referenced in Functions_Common. Set to nil if there are no pin clusters.
ns.clusterMapping = { 31, 41 }	-- Index into the ns.textures file for the Pin cluster textures. Ensure that the range is at
								-- least seven. Set to nil if there are no pin clusters. Randomly allocated to the cluster pins.

ns.questTypesRequired = { false, true, false, true }
ns.achievementTypesRequired = { true, true }
	-- Whether to show One Time/Seasonal/Weekly/Daily quests and Char/Acct achievement options on the options panel.
	-- This is NOT the value of the saved flag, which asks the question "remove the pin when completed" and defaults as true.
	-- If the option is not shown on the options panel then no test will be done. These options are for the Events module.

ns.achievementIQ = {}
-- Sometimes, an achievement does not conform to Blizzard's system of querying GetAchievementCriteriaInfo() and then examining the
-- 2nd return parameter ("type") to identify the 8th parameter ("object"), which itself is a hack when the 3rd ("character
-- completion") boolean is rubbish, particularly in Retail for warbanded / account wide achievements. This allows for hard coded
-- quest IDs (usually hidden system "Flag" quests) as well as meaningful text for the criteria (eg. an item ID or name). See the
-- EAP AddOn for best use. Ensure that the achievement is removed from ns.aoa. Reminder: 10th return parm is useless to test.

ns.aoa = {}		
-- ns.aoa is a table of account only achievements, which with Warbands and account wide crediting is the vast majority of them.
-- The format of ns.aoa is: ns.aoa[ aID ] = { acctOnly = true }. If an achievement is not in this table then a valiant attempt
-- will be made to show the individual completion status, including any known hacks. Unnecessary for game versions < 10.0.0.

--ns.aoa[ 3579 ] = { acctOnly = true } -- Food Fight			| Character name for self. In game self recognised
--ns.aoa[ 3582 ] = { acctOnly = true } -- Terokkar Turkey Time	| In game self recognised
--ns.aoa[ 3578 ] = { acctOnly = true } -- The Turkinator		| Character name for self else sometimes first. In game self recognised
--ns.aoa[ 3596 ] = { acctOnly = true } -- Pilgrim's Progress (A)	| cType is 27, assetID is good but it's daily so monitor
--ns.aoa[ 3597 ] = { acctOnly = true } -- Pilgrim's Progress (H)	| Character name for self

ns.aoa[ 3559 ] = { acctOnly = true } -- Turkey Lurkey
ns.aoa[ 3576 ] = { acctOnly = true } -- Now We're Cookin' (A)	| cType is 29 but the assetID is unknown
ns.aoa[ 3577 ] = { acctOnly = true } -- Now We're Cookin' (H)	| Character name for self
ns.aoa[ 3556 ] = { acctOnly = true } -- Pilgrim's Paunch (A)	| Character name for self else first
ns.aoa[ 3557 ] = { acctOnly = true } -- Pilgrim's Paunch (H)	| cType is 69 but the assetID is unknown
ns.aoa[ 3558 ] = { acctOnly = true } -- Sharing is Caring		| Character name for self
ns.aoa[ 3580 ] = { acctOnly = true } -- Pilgrim's Peril (A)
ns.aoa[ 3581 ] = { acctOnly = true } -- Pilgrim's Peril (H)

-- Remember: It's better to do colouring and translating here than rely upon assumed default behaviour.
--           In a single tooltip AddLine(), Blizzard limits that line to 5/6 colours

--==================================================================================================================================
--
-- TEXTURES
--
--==================================================================================================================================

-- Lower numbered textures 1 to about 15 are defined in Common.

ns.textures[31] = "Interface\\AddOns\\HandyNotes_PB\\Textures\\Cornucopia"
ns.textures[32] = "Interface\\AddOns\\HandyNotes_PB\\Textures\\EmptyCornucopia"
ns.textures[33] = "Interface\\AddOns\\HandyNotes_PB\\Textures\\Turkey1"
ns.textures[34] = "Interface\\AddOns\\HandyNotes_PB\\Textures\\Turkey2"
ns.textures[35] = "Interface\\AddOns\\HandyNotes_PB\\Textures\\Turkey3"
ns.textures[36] = "Interface\\AddOns\\HandyNotes_PB\\Textures\\PumpkinPie"
ns.textures[37] = "Interface\\AddOns\\HandyNotes_PB\\Textures\\PilgrimsPaunch"
ns.textures[38] = "Interface\\AddOns\\HandyNotes_PB\\Textures\\PilgrimHatBlack"
ns.textures[39] = "Interface\\AddOns\\HandyNotes_PB\\Textures\\PilgrimHatGreen"
ns.textures[40] = "Interface\\AddOns\\HandyNotes_PB\\Textures\\PilgrimHatMagenta"
ns.textures[41] = "Interface\\AddOns\\HandyNotes_PB\\Textures\\PilgrimHatYellow"

--==================================================================================================================================
--
-- LOCAL (NAME SPACED) VARIABLES
--
--==================================================================================================================================

ns.talonKing = "Talon King Ikiss is a boss in the Sethekk Halls dungeon in Auchindoun, Outland. Any difficulty is okay.\n\n"
			.."May be completed outside of the event time. The Fine Pilgrim's Hat is also acceptable to wear."

--==================================================================================================================================
--
-- Daily Cooking
--
--==================================================================================================================================

ns.series[ 1 ] = { title=ns.L [ "Daily Cooking" ], version=30202 }

ns.cookingDailiesTitle = "Dailies - Advanced Efficiency"
ns.cookingDailies = "For your first circuit of the main city Pilgrim's Bounty locations you'll be completing a seasonal quest "
			.."chain as well as picking up dailies.\n\nWhen you arrive at a city, first purchase sufficient materials for the non-"
			.."repeatable quest. Cook the ingredients, then hand in.\n\n"
			.."Note the shopping list below. It is for the dailies only. If a vendor has an item then purchase it now. Honey and "
			.."Autumnal Herbs are available at all of the vendors.\n\n"
			.."As you sweep through the cities, if you note that you have the ingredients for a daily and your Classic Cooking is "
			.."high enough then by all means complete the daily. Less back tracking later.\n\n"
			.."Your first day though will not be efficient. The shopping list is setting you up for subsequent days.\n\n"
			.."For the first day only, purchase DOUBLE the quantities you see below. That's enough for today and tomorrow's "
			.."dailies.\n\n"
			.."If you do this then you may complete the dailies in any order tomorrow!\n\n"
			.."If you take the opportunity to farm a massive quantity of turkeys in Elwynn Forest (A) or Tirisfal Glades (H) then "
			.."you'll further cut down your work.\n\n"
			.."Tomorrow, you'll purchase single quantities. You're always purchasing for the following day. This shopping list "
			.."does not include the seasonal quests.\n\nDaily Shopping List:\n"
ns.shoppingA = "\n100 x Honey, 60 x Autumnal Herbs, 20 x Mild Spices, Simple Flour, Ripe Elwynn Pumpkin (Stormwind), Tangy Wetland "
			.."Cranberries (Ironforge), Teldrassil Sweet Potato (Darnassus), Wild Turkey (Elwynn Forest)"
ns.shoppingH = "\n100 x Honey, 60 x Autumnal Herbs, 20 x Mild Spices, Simple Flour, Ripe Tirisfal Pumpkin (Undercity), Tangy "
			.."Southfury Cranberries (Orgrimmar), Mulgore Sweet Potato (Thunderbluff), Wild Turkey (Tirisfal Glades)"

ns.cookingDailiesGSet = { ns.cookingDailies, ( ( ns.faction == "Alliance" ) and ns.shoppingA or ( ( ns.faction == "Horde" ) and
			ns.shoppingH or "" ) ) }

ns.cookingDailiesQSet = ( ns.faction == "Alliance" ) and
			{ { id=14051, name="Don't Forget The Stuffing!", qType="Daily" }, { id=14054, name="Easy As Pie", qType="Daily" },
			{ id=14053, name="We're Out of Cranberry Chutney Again?", qType="Daily" },
			{ id=14055, name="She Says Potato", qType="Daily" }, { id=14048, name="Can't Get Enough Turkey", qType="Daily" }, }
			or ( ( ns.faction  == "Horde" ) and
			{ { id=14062, name="Don't Forget The Stuffing!", qType="Daily" }, { id=14060, name="Easy As Pie", qType="Daily" },
			{ id=14059, name="We're Out of Cranberry Chutney Again?", qType="Daily" },
			{ id=14058, name="She Says Potato", qType="Daily" }, { id=14061, name="Can't Get Enough Turkey", qType="Daily" }, }
			or {} )
			
ns.cookingDailiesASet = { { id=3596, faction="Alliance", }, { id=3597, faction="Horde", }, }
			-- Pilgrim's Progress. Show all criteria removed as I cannot see if per character is available out of season

--==================================================================================================================================
--
-- Bountiful Tables
--
--==================================================================================================================================

ns.series[ 2 ] = { title=ns.L [ "Bountiful Tables" ], version=30202 }

ns.shareCare = "At any Table, sit in each chair and pass that chair's food to another chair or player"

ns.bountifulSet = { { id=3579 }, { id=3558, showAllCriteria=true, tip=ns.shareCare }, }
ns.bountifulSetH = { { id=3579 }, { id=3556, faction="Alliance" },
			{ id=3558, showAllCriteria=true, tip=ns.shareCare }, { id=3581, faction="Horde" }, }
ns.bountifulSetA = { { id=3579 }, { id=3557, faction="Horde" },
			{ id=3558, showAllCriteria=true, tip=ns.shareCare }, { id=3580, faction="Alliance" }, }
			-- FOOD FIGHT!, Pilgrim's Paunch (A/H), Sharing is Caring, Pilgrim's Peril (A/H)
			-- The A version is used at Horde capital cities. The H version is used at Alliance capital cities

ns.sharing = ns.L[ "Sharing a Bountiful Feast" ]
ns.sharingDesc = "Eat five helpings of every food at a Bountiful Table until you gain the Spirit of Sharing."
ns.bountifulQSet = { { id=14064, faction="Alliance", name=ns.sharing, qType="Seasonal", showAllCriteria=true, tip=ns.sharingDesc, },
			{ id=14065, faction="Horde", name=ns.sharing, qType="Seasonal", showAllCriteria=true, tip=ns.sharingDesc, }, }

-- Bountiful Tables (Check again if checked already)
-- Horde: Bloodhoof Village (I checked already! Removed?), Falconwing Square, Hammerfall (I checked already! Removed?), Razor Hill, 
--			Sepulcher, Shadowprey Village, Stonard, Tarren Mill, Tranquillien
-- Alliance: Azure Watch (I checked already! Removed?), Southshore (I checked already! Removed?)
-- Neutral: Ruins of Thaurissan (Burning Steppes. I checked already! Removed?)

--==================================================================================================================================
--
-- Classic Cooking
--
--==================================================================================================================================

ns.series[ 3 ] = { title=ns.L [ "Classic Cooking" ], version=30202 }

ns.cookingSeasonalTitle = "Classic Cooking to 280/300 : Basic Guide"
ns.cookingSeasonal = "Pilgrim's Bounty has a purpose built quest chain to assist with easily levelling Classic Cooking to "
			.."maximum.\n\n"
			.."First step is to purchase a Bountiful Cookbook from a Pilgrim's Bounty vendor.\n\n"
			.."All ingredients (to 280) are purchased.\n\n"
			.."When a recipe \"turns\" green then you should learn the next recipe.\n\n"
			.."The first recipe requires Spice Bread, itself a standard Vanilla recipe and it introduces you to searching for "
			.."recipes and ingredients from vendors in inns.\n\n"
			.."Some ingredients may only be purchased from one vendor in one city. Thus the quest chain introduces you to this "
			.."system too.\n\n"
			.."At 280 you learn the last recipe. You'll need to hunt down and kill turkeys to then reach cooking 300.\n\n"
			.."Note that the \"order\" of scurrying from city to city for the dailies is not the same as for the one time quests. "
			.."It's deliberately designed to slow you down by forcing you to backtrack.\n\n"
			.."For the first day this season, you cannot avoid this.\n\n"
			.."Note: For all of the Seasonal quests you must cook the recipes AFTER you've accepted the quest. You'll conveniently "
			.."purchase ingredients at the TURN IN location. You don't need to prepare in advance.\n\n"
			.."Nearby, is another pin with strategy for advance preparation for your dailies."

ns.cookingSeasonalQSet = ( ns.faction == "Alliance" ) and
			{ { id=14023, name="Spice Bread Stuffing", qType="Seasonal" }, { id=14024, name="Pumpkin Pie", qType="Seasonal" },
			{ id=14028, name="Cranberry Chutney", qType="Seasonal" },
			{ id=14030, name="They're Ravenous in Darnassus", qType="Seasonal" },
			{ id=14033, name="Candied Sweet Potatoes", qType="Seasonal" },
			{ id=14035, name="Slow-roasted Turkey", qType="Seasonal" }, } or
			( ( ns.faction == "Horde" ) and
			{ { id=14037, name="Spice Bread Stuffing", qType="Seasonal" }, { id=14040, name="Pumpkin Pie", qType="Seasonal" },
			{ id=14041, name="Cranberry Chutney", qType="Seasonal" },
			{ id=14044, name="Undersupplied in the Undercity", qType="Seasonal" },
			{ id=14043, name="Candied Sweet Potatoes", qType="Seasonal" },
			{ id=14047, name="Slow-roasted Turkey", qType="Seasonal" }, } or {} )

ns.cookingSeasonalASet = { { id=3576, faction="Alliance", showAllCriteria=true, },
			{ id=3577, faction="Horde", showAllCriteria=true, }, } -- Now We're Cookin'

--==================================================================================================================================
--
-- Turkey Lurkey
--
--==================================================================================================================================

ns.series[ 4 ] = { title=ns.L [ "Turkey Lurkey" ], version=30202 }

ns.turkeyLurkey = "You must use a Turkey Shooter against the rogues. A Turkey Shooter will be one of the rewards from completing a "
			.."Pilgrim's Bounty cooking daily. The shooter is consumed on use. Just allow a couple of days to accumulate "
			.."sufficient, with allowance for misidentifying the rogue's race.\n\n"
			..( ( ns.version > 60000 ) and ( "There is a small chance your daily reward will be a Silver-Plaited Turkey Shooter. "
			.."This is a permanent toy with a five minute cooldown.\n\n" ) or ( "" ) )
			.."There is no single best location to hang-out as you search for your rogues. A questing sanctuary for both factions "
			.."is usually the go. If you are short just one or two races then creating that race as a new (trial) character and "
			.."then having your main toon meet that character by means of rapidly quitting / relogging game clients is a tried and "
			.."true hack for achievements like this. You'll have up to 20 seconds.\n\n"
			.."Take care to not misidentify the rogue's race. You are only looking for original / classic races here."

ns.turkeyLurkeyASet = { { id=3559, showAllCriteria=true, }, } -- Turkey Lurkey

--==================================================================================================================================
--
-- The Turkinator
--
--==================================================================================================================================

ns.series[ 5 ] = { title=ns.L [ "The Turkinator" ], version=30202 }

ns.wildTurkey = "Ensure that you are targeting Wild Turkeys, indeed use a macro /tar Wild Turkey. There are prodigious amounts in "
			.."the area between the Gates of Stormwind and Goldshire, and around Goldshire generally. Over Tirisfal Glades way, "
			.."there are numerous Wild Turkeys to the south west of Brightwate Lake and between Brill and Balnir Farmstead.\n\n"
			..( ( ns.version > 100000 ) and ( "The Ohn'ahran Plains has some around the Watering Hole.\n\n" ) or ( "" ) )
			..( ( ns.version > 110000 ) and ( "South of Dornogal, on the Isle of Dorn, are some Wild Turkeys too.\n\n" ) or ( "" ) )
			.."Although the turkeys have a fast respawn, you may run out of them. A key strategy is to slow down and to let the "
			.."timer run right down. This will buy you time for respawns. Competition is usually fiercest at the beginning of "
			.."Pilgrim's Bounty as players will be farming in bulk for the cooking dailies too."

ns.turkinatorASet = { { id=3578, showAllCriteria=true, }, } -- The Turkinator

--==================================================================================================================================
--
-- Pin Cluster
--
--==================================================================================================================================

ns.setTables = { cluster="tables", alwaysShow=true, noCoords= true, noAzeroth=true,
			achievements={ { id=3579 }, { id=3556, faction="Alliance", showAllCriteria=true },
			{ id=3557, faction="Horde", showAllCriteria=true }, { id=3558, showAllCriteria=true },
			{ id=3580, faction="Alliance", showAllCriteria=true }, { id=3581, faction="Horde", showAllCriteria=true }, }, }
			-- FOOD FIGHT!, Pilgrim's Paunch (A/H), Sharing is Caring, Pilgrim's Peril (A/H)
			-- The A version is used at Horde capital cities. The H version is used at Alliance capital cities
ns.setMeta = { cluster="meta", alwaysShow=true, noCoords= true, noAzeroth=true,
			achievements={ { id=3478, showAllCriteria=true, }, }, }
ns.setDailies = { cluster="dailies", alwaysShow=true, noCoords=true, noAzeroth=true, quests=ns.cookingDailiesQSet,
			achievements={ { id=3596, faction="Alliance", showAllCriteria=true },
			{ id=3597, faction="Horde", showAllCriteria=true }, }, } -- Pilgrim's Progress
ns.flavour = "Even in hard times, the Pilgrim’s Bounty celebration comes to the lands of Azeroth, bringing with it the opportunity "
			.."to reflect and give thanks for the nourishment the land has provided.\n\nThis season is the perfect occasion to "
			.."brush up on those cooking skills while feasting upon and sharing in a veritable cornucopia of delicious offerings "
			.."that can be found on the communal dining tables located outside the capital cities.\n\nThere’s also no better time "
			.."to go on a wild turkey hunt, or, should wild turkeys prove too elusive, to transform friend and foe into tasty "
			.."turkey targets.\n\n    ((Daxxarri @ Blizzard, 2011/11/22))"
ns.setFlavour = { cluster="flavour", alwaysShow=true, noCoords=true, noAzeroth=true, tip="\n" ..ns.flavour, }
ns.setCooking = { cluster="cooking", alwaysShow=true, noCoords=true, noAzeroth=true, quests=ns.cookingSeasonalQSet,
					achievements=ns.cookingSeasonalASet, } -- Now We're Cookin'
ns.setTurkeys = { cluster="turkeys", alwaysShow=true, noCoords=true, noAzeroth=true,
			achievements={ { id=3559, showAllCriteria=true }, { id=3578 }, }, }
			-- Turkey Lurkey, The Turkinator
ns.setDungeon = { cluster="dungeon", alwaysShow=true, noCoords=true, noAzeroth=true,
			achievements={ { id=3582, }, }, tip=ns.talonKing } -- Terokkar Turkey Time (Talon King Ikiss)

--==================================================================================================================================
--
-- KALIMDOR
--
--==================================================================================================================================

ns.points[ ns.map.ashenvale ] = { -- Ashenvale
	[22219116] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.azuremyst ] = { -- Azuremyst Isle
	[33134379] = { series=4, achievements=ns.turkeyLurkeyASet, guide=ns.turkeyLurkey, },
	[33484304] = { series=1, name=ns.cookingDailiesTitle, quests=ns.cookingDailiesQSet,
					achievements=ns.cookingDailiesASet, guide=ns.cookingDailiesGSet, },
	[33654437] = { series=2, achievements=ns.bountifulSetH, quests=ns.bountifulQSet, },
	[34054368] = { series=3, name=ns.cookingSeasonalTitle, quests=ns.cookingSeasonalQSet,
					achievements=ns.cookingSeasonalASet, guide=ns.cookingSeasonal, },
}

ns.points[ ns.map.darkshore ] = { -- Darkshore
	[50581865] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.darnassus ] = { -- Darnassus
	[61664905] = { series=1, name=ns.cookingDailiesTitle, quests=ns.cookingDailiesQSet,
					achievements=ns.cookingDailiesASet, guide=ns.cookingDailiesGSet, },
	[62764599] = { series=2, achievements=ns.bountifulSetH, quests=ns.bountifulQSet, },
	[63595128] = { series=4, achievements=ns.turkeyLurkeyASet, guide=ns.turkeyLurkey, },
	[64464857] = { series=3, name=ns.cookingSeasonalTitle, quests=ns.cookingSeasonalQSet,
					achievements=ns.cookingSeasonalASet, guide=ns.cookingSeasonal, },
}

ns.points[ ns.map.desolace ] = { -- Desolace
	[65190873] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },

	[89355890] = { series=2, faction="Horde", achievements=ns.bountifulSetA, quests=ns.bountifulQSet, },
	[90065807] = { series=1, name=ns.cookingDailiesTitle, quests=ns.cookingDailiesQSet,
					achievements=ns.cookingDailiesHSet, guide=ns.cookingDailiesGSet, },
	[89815999] = { series=4, achievements=ns.turkeyLurkeyASet, guide=ns.turkeyLurkey, },
	[90325905] = { series=3, name=ns.cookingSeasonalTitle, quests=ns.cookingSeasonalQSet,
					achievements=ns.cookingSeasonalHSet, guide=ns.cookingSeasonal, },
}

ns.points[ ns.map.durotar ] = { -- Durotar
	[46231527] = { series=2, faction="Horde", achievements=ns.bountifulSetA, quests=ns.bountifulQSet, },
	[46521439] = { series=1, name=ns.cookingDailiesTitle, quests=ns.cookingDailiesQSet,
					achievements=ns.cookingDailiesHSet, guide=ns.cookingDailiesGSet, },
	[46801575] = { series=4, achievements=ns.turkeyLurkeyASet, guide=ns.turkeyLurkey, },
	[47041496] = { series=3, name=ns.cookingSeasonalTitle, quests=ns.cookingSeasonalQSet,
					achievements=ns.cookingSeasonalHSet, guide=ns.cookingSeasonal, },
	[53104407] = { series=2, faction="Horde", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },

	[12096205] = { series=2, faction="Horde", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
	[33037881] = { series=2, achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.dustwallow ] = { -- Dustwallow Marsh
	[68005078] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, zidormiOldPhase=true, },
}

ns.points[ ns.map.feralas ] = { -- Feralas
	[46924534] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
	[74884334] = { series=2, faction="Horde", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },

	[67799643] = { series=2, achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.mulgore ] = { -- Mulgore
	[46455921] = { series=2, faction="Horde", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },

	[36483152] = { series=2, faction="Horde", achievements=ns.bountifulSetA, quests=ns.bountifulQSet, },
	[37063083] = { series=1, name=ns.cookingDailiesTitle, quests=ns.cookingDailiesQSet,
					achievements=ns.cookingDailiesHSet, guide=ns.cookingDailiesGSet, },
	[36863241] = { series=4, achievements=ns.turkeyLurkeyASet, guide=ns.turkeyLurkey, },
	[37283163] = { series=3, name=ns.cookingSeasonalTitle, quests=ns.cookingSeasonalQSet,
					achievements=ns.cookingSeasonalHSet, guide=ns.cookingSeasonal, },

	[88190578] = { series=2, faction="Horde", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.barrens ] = { -- Northern Barrens / The Barrens
	[48805714] = { series=2, faction="Horde", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
	[68077256] = { series=2, achievements=ns.bountifulSet, quests=ns.bountifulQSet, },

	[80221410] = { series=2, faction="Horde", achievements=ns.bountifulSetA, quests=ns.bountifulQSet, },
	[80481329] = { series=1, name=ns.cookingDailiesTitle, quests=ns.cookingDailiesQSet,
					achievements=ns.cookingDailiesHSet, guide=ns.cookingDailiesGSet, },
	[80741455] = { series=4, achievements=ns.turkeyLurkeyASet, guide=ns.turkeyLurkey, },
	[80961382] = { series=3, name=ns.cookingSeasonalTitle, quests=ns.cookingSeasonalQSet,
					achievements=ns.cookingSeasonalHSet, guide=ns.cookingSeasonal, },
	[86534060] = { series=2, faction="Horde", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.silithus ] = { -- Silithus
	[55523553] = { series=2, achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ 199 ] = { -- Southern Barrens

	[00730028] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
	[15109266] = { series=2, faction="Horde", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
	[22725108] = { series=2, faction="Horde", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
	[53401180] = { series=2, faction="Horde", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
	[68342375] = { series=2, achievements=ns.bountifulSet, quests=ns.bountifulQSet, }, -- Ratchet
	[79628124] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, zidormiOldPhase=true, },

	[15383072] = { series=2, faction="Horde", achievements=ns.bountifulSetA, quests=ns.bountifulQSet, },
	[15813021] = { series=1, name=ns.cookingDailiesTitle, quests=ns.cookingDailiesQSet,
					achievements=ns.cookingDailiesHSet, guide=ns.cookingDailiesGSet, },
	[15663137] = { series=4, achievements=ns.turkeyLurkeyASet, guide=ns.turkeyLurkey, },
	[15973081] = { series=3, name=ns.cookingSeasonalTitle, quests=ns.cookingSeasonalQSet,
					achievements=ns.cookingSeasonalHSet, guide=ns.cookingSeasonal, },
}

ns.points[ ns.map.stonetalon ] = { -- Stonetalon Mountains
	[44068171] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
	[59035683] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.tanaris ] = { -- Tanaris
	[51342978] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
	[52182701] = { series=2, faction="Horde", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },

	[52790660] = { series=2, achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.teldrassil ] = { -- Teldrassil
	[34004818] = { series=1, name=ns.cookingDailiesTitle, quests=ns.cookingDailiesQSet,
					achievements=ns.cookingDailiesASet, guide=ns.cookingDailiesGSet, },
	[34284738] = { series=2, achievements=ns.bountifulSetH, quests=ns.bountifulQSet, },
	[34504877] = { series=4, achievements=ns.turkeyLurkeyASet, guide=ns.turkeyLurkey, },
	[34734806] = { series=3, name=ns.cookingSeasonalTitle, quests=ns.cookingSeasonalQSet,
					achievements=ns.cookingSeasonalASet, guide=ns.cookingSeasonal, },

	[56085104] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.theExodar ] = { -- The Exodar
	[74045289] = { series=4, achievements=ns.turkeyLurkeyASet, guide=ns.turkeyLurkey, },
	[75385002] = { series=1, name=ns.cookingDailiesTitle, quests=ns.cookingDailiesQSet,
					achievements=ns.cookingDailiesASet, guide=ns.cookingDailiesGSet, },
	[76035514] = { series=2, achievements=ns.bountifulSetH, quests=ns.bountifulQSet, },
	[77575249] = { series=3, name=ns.cookingSeasonalTitle, quests=ns.cookingSeasonalQSet,
					achievements=ns.cookingSeasonalASet, guide=ns.cookingSeasonal, },
}

ns.points[ ns.map.thousand ] = { -- Thousand Needles
	[78107233] = { series=2, achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.thunder ] = { -- Thunder Bluff
	[28786666] = { series=2, faction="Horde", achievements=ns.bountifulSetA, quests=ns.bountifulQSet, },
	[31826306] = { series=1, name=ns.cookingDailiesTitle, quests=ns.cookingDailiesQSet,
					achievements=ns.cookingDailiesHSet, guide=ns.cookingDailiesGSet, },
	[30777132] = { series=4, achievements=ns.turkeyLurkeyASet, guide=ns.turkeyLurkey, },
	[32976728] = { series=3, name=ns.cookingSeasonalTitle, quests=ns.cookingSeasonalQSet,
					achievements=ns.cookingSeasonalHSet, guide=ns.cookingSeasonal, },
}

ns.points[ ns.map.winterspring ] = { -- Winterspring
	[58604838] = { series=2, faction="Horde", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
	[60804909] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.kalimdor ] = { -- Kalimdor
	[91504820] = ns.setTables,
	[91505250] = ns.setMeta,
	[93705530] = ns.setDailies,
	[94005100] = ns.setFlavour,
	[94204700] = ns.setCooking,
	[96305400] = ns.setTurkeys,
	[96604980] = ns.setDungeon,
}

--==================================================================================================================================
--
-- EASTERN KINGDOMS
--
--==================================================================================================================================

ns.points[ ns.map.arathi ] = { -- Arathi Highlands
	[40144723] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
	[70003786] = { series=2, faction="Horde", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.badlands ] = { -- Badlands
	[18064168] = { series=2, faction="Horde", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
	[07768775] = { series=2, faction="Horde", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.blastedLands ] = { -- Blasted Lands
	[61361790] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.burningSteppes ] = { -- Burning Steppes
	[53163162] = { series=2, faction="Horde", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
	[73486704] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.deadwind ] = { -- Deadwind Pass
	[17203837] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.dunMorogh ] = { -- Dun Morogh
	[52602858] = { series=1, name=ns.cookingDailiesTitle, versionUnder=40000, quests=ns.cookingDailiesQSet,
					achievements=ns.cookingDailiesASet, guide=ns.cookingDailiesGSet, },
	[59803380] = { series=1, name=ns.cookingDailiesTitle, version=40000, quests=ns.cookingDailiesQSet,
					achievements=ns.cookingDailiesASet, guide=ns.cookingDailiesGSet, },
	[52603324] = { series=2, versionUnder=40000, achievements=ns.bountifulSetH, quests=ns.bountifulQSet, },
	[60373455] = { series=2, version=40000, achievements=ns.bountifulSetH, quests=ns.bountifulQSet, },
	[59383455] = { series=4, versionUnder=40000, achievements=ns.turkeyLurkeyASet, guide=ns.turkeyLurkey, },
	[59383455] = { series=4, version=40000, achievements=ns.turkeyLurkeyASet, guide=ns.turkeyLurkey, },
	[52603790] = { series=3, name=ns.cookingSeasonalTitle, versionUnder=40000, quests=ns.cookingSeasonalQSet,
					achievements=ns.cookingSeasonalASet, guide=ns.cookingSeasonal, },
	[59803530] = { series=3, name=ns.cookingSeasonalTitle, version=40000, quests=ns.cookingSeasonalQSet,
					achievements=ns.cookingSeasonalASet, guide=ns.cookingSeasonal, },
}

ns.points[ ns.map.duskwood ] = { -- Duskwood
	[77664386] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
	[38108956] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.easternP ] = { -- Eastern Plaguelands
	[74105212] = { series=2, faction="Horde", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
	[75085434] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.elwynn ] = { -- Elwynn Forest
	[33795118] = { series=2, versionUnder=40000, achievements=ns.bountifulSetH, quests=ns.bountifulQSet, },
	[33795118] = { series=2, version=40000, achievements=ns.bountifulSetH, quests=ns.bountifulQSet, },
	[34455008] = { series=1, name=ns.cookingDailiesTitle, versionUnder=40000, quests=ns.cookingDailiesQSet,
					achievements=ns.cookingDailiesASet, guide=ns.cookingDailiesGSet, },
	[34455008] = { series=1, name=ns.cookingDailiesTitle, version=40000, quests=ns.cookingDailiesQSet,
					achievements=ns.cookingDailiesASet, guide=ns.cookingDailiesGSet, },
	[34765187] = { series=4, versionUnder=40000, achievements=ns.turkeyLurkeyASet, guide=ns.turkeyLurkey, },
	[34765187] = { series=4, version=40000, achievements=ns.turkeyLurkeyASet, guide=ns.turkeyLurkey, },
	[35365089] = { series=3, name=ns.cookingSeasonalTitle, versionUnder=40000, quests=ns.cookingSeasonalQSet,
					achievements=ns.cookingSeasonalASet, guide=ns.cookingSeasonal, },
	[35365089] = { series=3, name=ns.cookingSeasonalTitle, version=40000, quests=ns.cookingSeasonalQSet,
					achievements=ns.cookingSeasonalASet, guide=ns.cookingSeasonal, },
	[36556029] = { series=5, achievements=ns.turkinatorASet, guide=ns.wildTurkey, },
	[39776958] = { series=5, achievements=ns.turkinatorASet, guide=ns.wildTurkey, },
	[43145541] = { series=5, achievements=ns.turkinatorASet, guide=ns.wildTurkey, },

	[41816388] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.eversong ] = { -- Eversong Woods
	[53905320] = { series=2, faction="Horde", achievements=ns.bountifulSetA, quests=ns.bountifulQSet, },
	[55405120] = { series=1, name=ns.cookingDailiesTitle, quests=ns.cookingDailiesQSet,
					achievements=ns.cookingDailiesHSet, guide=ns.cookingDailiesGSet, },
	[55405520] = { series=4, achievements=ns.turkeyLurkeyASet, guide=ns.turkeyLurkey, },
	[56905320] = { series=3, name=ns.cookingSeasonalTitle, quests=ns.cookingSeasonalQSet,
					achievements=ns.cookingSeasonalHSet, guide=ns.cookingSeasonal, },
}

ns.points[ ns.map.hillsbrad ] = { -- Hillsbrad Foothills
	[68631632] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
	[81463754] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
	[89938385] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.ironforge ] = { -- Ironforge
	[52603620] = { series=1, name=ns.cookingDailiesTitle, versionUnder=40000, quests=ns.cookingDailiesQSet,
					achievements=ns.cookingDailiesASet, guide=ns.cookingDailies, },
	[09839020] = { series=1, name=ns.cookingDailiesTitle, version=40000, quests=ns.cookingDailiesQSet,
					achievements=ns.cookingDailiesASet, guide=ns.cookingDailies, },
	[13369486] = { series=2, versionUnder=40000, achievements=ns.bountifulSetH, quests=ns.bountifulQSet, },
	[13369486] = { series=2, version=40000, achievements=ns.bountifulSetH, quests=ns.bountifulQSet, },
	[07229485] = { series=4, versionUnder=40000, achievements=ns.turkeyLurkeyASet, guide=ns.turkeyLurkey, },
	[07229485] = { series=4, version=40000, achievements=ns.turkeyLurkeyASet, guide=ns.turkeyLurkey, },
	[52603790] = { series=3, name=ns.cookingSeasonalTitle, versionUnder=40000, quests=ns.cookingSeasonalQSet,
					achievements=ns.cookingSeasonalASet, guide=ns.cookingSeasonal, },
	[09829948] = { series=3, name=ns.cookingSeasonalTitle, version=40000, quests=ns.cookingSeasonalQSet,
					achievements=ns.cookingSeasonalASet, guide=ns.cookingSeasonal, },
}

ns.points[ ns.map.lochModan ] = { -- Loch Modan
	[32174842] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.northStrangle ] = { -- Northern Stranglethorn
	[47301142] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.redridge ] = { -- Redridge Mountains
	[33104615] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
	[91987380] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.searingGorge ] = { -- Searing Gorge
	[95634080] = { series=2, faction="Horde", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.stormwind ] = { -- Stormwind City
	[78299714] = { series=2, versionUnder=40000, achievements=ns.bountifulSetH, quests=ns.bountifulQSet, },
	[78299714] = { series=2, version=40000, achievements=ns.bountifulSetH, quests=ns.bountifulQSet, },
	[79619521] = { series=1, name=ns.cookingDailiesTitle, versionUnder=40000, quests=ns.cookingDailiesQSet,
					achievements=ns.cookingDailiesASet, guide=ns.cookingDailiesGSet, },
	[79619521] = { series=1, name=ns.cookingDailiesTitle, version=40000, quests=ns.cookingDailiesQSet,
					achievements=ns.cookingDailiesASet, guide=ns.cookingDailiesGSet, },
	[80229879] = { series=4, versionUnder=40000, achievements=ns.turkeyLurkeyASet, guide=ns.turkeyLurkey, },
	[80229879] = { series=4, version=40000, achievements=ns.turkeyLurkeyASet, guide=ns.turkeyLurkey, },
	[81439683] = { series=3, name=ns.cookingSeasonalTitle, versionuNDER=40000, quests=ns.cookingSeasonalQSet,
					achievements=ns.cookingSeasonalASet, guide=ns.cookingSeasonal, },
	[81439683] = { series=3, name=ns.cookingSeasonalTitle, version=40000, quests=ns.cookingSeasonalQSet,
					achievements=ns.cookingSeasonalASet, guide=ns.cookingSeasonal, },
}

ns.points[ 224 ] = { -- Stranglethorn Vale
	[48420834] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
	[97960127] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.swampOS ] = { -- Swamp of Sorrows
	[54228876] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
	[70191453] = { series=2, achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.TheHinter ] = { -- The Hinterlands
	[13924685] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
	[51599687] = { series=2, faction="Horde", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
	[79008077] = { series=2, faction="Horde", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.tirisfal ] = { -- Tirisfal Glades
	[59125120] = { series=2, faction="Horde", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
	[61156770] = { series=2, faction="Horde", achievements=ns.bountifulSetA, quests=ns.bountifulQSet, },
	[61236694] = { series=1, name=ns.cookingDailiesTitle, quests=ns.cookingDailiesQSet,
					achievements=ns.cookingDailiesHSet, guide=ns.cookingDailiesGSet, },
	[61666808] = { series=4, achievements=ns.turkeyLurkeyASet, guide=ns.turkeyLurkey, },
	[61726732] = { series=3, name=ns.cookingSeasonalTitle, quests=ns.cookingSeasonalQSet,
					achievements=ns.cookingSeasonalHSet, guide=ns.cookingSeasonal, },
	[61604463] = { series=5, achievements=ns.turkinatorASet, guide=ns.wildTurkey, },
	[63115930] = { series=5, achievements=ns.turkinatorASet, guide=ns.wildTurkey, },
	[64695103] = { series=5, achievements=ns.turkinatorASet, guide=ns.wildTurkey, },
	[68395709] = { series=5, achievements=ns.turkinatorASet, guide=ns.wildTurkey, },
}

ns.points[ 2070 ] = { -- Tirisfal Glades
	[59125120] = { series=2, faction="Horde", achievements=ns.bountifulSet, quests=ns.bountifulQSet, zidormiOldPhase=true, },
	[61156770] = { series=2, faction="Horde", achievements=ns.bountifulSetA, quests=ns.bountifulQSet, zidormiOldPhase=true, },
	[61236694] = { series=1, name=ns.cookingDailiesTitle, quests=ns.cookingDailiesQSet,
					achievements=ns.cookingDailiesHSet, guide=ns.cookingDailiesGSet, zidormiOldPhase=true, },
	[61666808] = { series=4, achievements=ns.turkeyLurkeyASet, guide=ns.turkeyLurkey, zidormiOldPhase=true, },
	[61726732] = { series=3, name=ns.cookingSeasonalTitle, quests=ns.cookingSeasonalQSet,
					achievements=ns.cookingSeasonalHSet, guide=ns.cookingSeasonal, zidormiOldPhase=true, },
	[61604463] = { series=5, achievements=ns.turkinatorASet, guide=ns.wildTurkey, },
	[63115930] = { series=5, achievements=ns.turkinatorASet, guide=ns.wildTurkey, },
	[64695103] = { series=5, achievements=ns.turkinatorASet, guide=ns.wildTurkey, },
	[68395709] = { series=5, achievements=ns.turkinatorASet, guide=ns.wildTurkey, },
}

ns.points[ ns.map.westernP ] = { -- Western Plaguelands
	[44278422] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },

	[01283738] = { series=2, faction="Horde", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
	[03415472] = { series=2, faction="Horde", achievements=ns.bountifulSetA, quests=ns.bountifulQSet, },
	[03495392] = { series=1, name=ns.cookingDailiesTitle, quests=ns.cookingDailiesQSet,
					achievements=ns.cookingDailiesHSet, guide=ns.cookingDailiesGSet, },
	[03945512] = { series=4, achievements=ns.turkeyLurkeyASet, guide=ns.turkeyLurkey, },
	[04005432] = { series=3, name=ns.cookingSeasonalTitle, quests=ns.cookingSeasonalQSet,
					achievements=ns.cookingSeasonalHSet, guide=ns.cookingSeasonal, },
	[03883048] = { series=5, achievements=ns.turkinatorASet, guide=ns.wildTurkey, },
	[05474589] = { series=5, achievements=ns.turkinatorASet, guide=ns.wildTurkey, },
	[07133720] = { series=5, achievements=ns.turkinatorASet, guide=ns.wildTurkey, },
	[11024357] = { series=5, achievements=ns.turkinatorASet, guide=ns.wildTurkey, },
}

ns.points[ ns.map.westfall ] = { -- Westfall
	[56974875] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },

	[81760643] = { series=5, achievements=ns.turkinatorASet, guide=ns.wildTurkey, },
	[83780078] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
	[91788267] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.wetlands ] = { -- Wetlands
	[09166088] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.easternK ] = { -- Eastern Kingdoms
	[91504820] = ns.setTables,
	[91505250] = ns.setMeta,
	[93705530] = ns.setDailies,
	[94005100] = ns.setFlavour,
	[94204700] = ns.setCooking,
	[96305400] = ns.setTurkeys,
	[96604980] = ns.setDungeon,
}

--==================================================================================================================================
--
-- THE BURNING CRUSADE / OUTLAND
--
--==================================================================================================================================

ns.points[ ns.map.hellfire ] = { -- Hellfire Peninsula
	[56203820] = { series=2, faction="Horde", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ ns.map.terokkar ] = { -- Terokkar Forest
	[43196562] = { series=5, achievements={ { id=3582, }, }, tip=ns.talonKing }
}

ns.points[ ns.map.outland ] = { -- Outland
	[91504820] = ns.setTables,
	[91505250] = ns.setMeta,
	[93705530] = ns.setDailies,
	[94005100] = ns.setFlavour,
	[94204700] = ns.setCooking,
	[96305400] = ns.setTurkeys,
	[96604980] = ns.setDungeon,
}

--==================================================================================================================================
--
-- WRATH OF THE LICH KING / NORTHREND
--
--==================================================================================================================================

ns.points[ 115 ] = { -- Dragonblight
	[37184698] = { series=2, faction="Horde", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ 119 ] = { -- Sholazar Basin
	[47506070] = { series=1, achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ ns.qSharingFeastASet, ns.qSharingFeastHSet }, },
}

ns.points[ 113 ] = { -- Northrend
	[91504820] = ns.setTables,
	[91505250] = ns.setMeta,
	[93705530] = ns.setDailies,
	[94005100] = ns.setFlavour,
	[94204700] = ns.setCooking,
	[96305400] = ns.setTurkeys,
	[96604980] = ns.setDungeon,
}

--==================================================================================================================================
--
-- CATACLYSM
--
--==================================================================================================================================

ns.points[ 241 ] = { -- Twilight Highlands
	[08429168] = { series=2, faction="Alliance", achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

--==================================================================================================================================
--
-- MISTS OF PANDARIA
--
--==================================================================================================================================

ns.points[ 424 ] = { -- Pandaria
	[91504820] = ns.setTables,
	[91505250] = ns.setMeta,
	[93705530] = ns.setDailies,
	[94005100] = ns.setFlavour,
	[94204700] = ns.setCooking,
	[96305400] = ns.setTurkeys,
	[96604980] = ns.setDungeon,
}

--==================================================================================================================================
--
-- WARLORDS OF DRAENOR / GARRISON
--
--==================================================================================================================================

ns.points[ 572 ] = { -- Draenor
	[91504820] = ns.setTables,
	[91505250] = ns.setMeta,
	[93705530] = ns.setDailies,
	[94005100] = ns.setFlavour,
	[94204700] = ns.setCooking,
	[96305400] = ns.setTurkeys,
	[96604980] = ns.setDungeon,
}

--==================================================================================================================================
--
-- LEGION / BROKEN ISLES
--
--==================================================================================================================================

ns.points[ 619 ] = { -- Broken Isles
	[91504820] = ns.setTables,
	[91505250] = ns.setMeta,
	[93705530] = ns.setDailies,
	[94005100] = ns.setFlavour,
	[94204700] = ns.setCooking,
	[96305400] = ns.setTurkeys,
	[96604980] = ns.setDungeon,
}

--==================================================================================================================================
--
-- BATTLE FOR AZEROTH / KUL TIRAS & ZANDALAR
--
--==================================================================================================================================

ns.points[ 876 ] = { -- Kul Tiras
	[91504820] = ns.setTables,
	[91505250] = ns.setMeta,
	[93705530] = ns.setDailies,
	[94005100] = ns.setFlavour,
	[94204700] = ns.setCooking,
	[96305400] = ns.setTurkeys,
	[96604980] = ns.setDungeon,
}

ns.points[ 875 ] = { -- Zandalar
	[91504820] = ns.setTables,
	[91505250] = ns.setMeta,
	[93705530] = ns.setDailies,
	[94005100] = ns.setFlavour,
	[94204700] = ns.setCooking,
	[96305400] = ns.setTurkeys,
	[96604980] = ns.setDungeon,
}

--==================================================================================================================================
--
-- SHADOWLANDS
--
--==================================================================================================================================

ns.points[ 1550 ] = { -- Shadowlands
	[91504820] = ns.setTables,
	[91505250] = ns.setMeta,
	[93705530] = ns.setDailies,
	[94005100] = ns.setFlavour,
	[94204700] = ns.setCooking,
	[96305400] = ns.setTurkeys,
	[96604980] = ns.setDungeon,
}

--==================================================================================================================================
--
-- DRAGONFLIGHT / DRAGON ISLES
--
--==================================================================================================================================

ns.points[ 2024 ] = { -- The Azure Span
	[37740256] = { series=5, achievements=ns.turkinatorASet, guide=ns.wildTurkey, },
	[63905859] = { series=2, achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ 2023 ] = { -- Ohn'ahran Plains
	[71775020] = { series=5, achievements=ns.turkinatorASet, guide=ns.wildTurkey, },
}

ns.points[ 2025 ] = { -- Thaldraszus
	[17127881] = { series=5, achievements=ns.turkinatorASet, guide=ns.wildTurkey, },
	[39486199] = { series=2, achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ 2112 ] = { -- Valdrakken
	[46806460] = { series=2, achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
}

ns.points[ 1978 ] = { -- Dragon Isles
	[91504820] = ns.setTables,
	[91505250] = ns.setMeta,
	[93705530] = ns.setDailies,
	[94005100] = ns.setFlavour,
	[94204700] = ns.setCooking,
	[96305400] = ns.setTurkeys,
	[96604980] = ns.setDungeon,
}

--==================================================================================================================================
--
-- THE WAR WITHIN / KHAZ ALGAR
--
--==================================================================================================================================

ns.points[ 2339 ] = { -- Dornogal
	[48204820] = { series=2, noContinent=true, achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
	[68688964] = { series=5, noContinent=true, achievements=ns.turkinatorASet, guide=ns.wildTurkey, },
}

ns.points[ 2248 ] = { -- Isle of Dorn
	[49244417] = { series=2, achievements=ns.bountifulSet, quests=ns.bountifulQSet, },
	[54275435] = { series=5, achievements=ns.turkinatorASet, guide=ns.wildTurkey, },
}

ns.points[ 2274 ] = { -- Khaz Algar
	[91504820] = ns.setTables,
	[91505250] = ns.setMeta,
	[93705530] = ns.setDailies,
	[94005100] = ns.setFlavour,
	[94204700] = ns.setCooking,
	[96305400] = ns.setTurkeys,
	[96604980] = ns.setDungeon,
}

--==================================================================================================================================
--
-- WORLD / OTHER
--
--==================================================================================================================================
