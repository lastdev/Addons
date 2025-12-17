local _, ns = ...
ns.points = {}
ns.achievementIQ = {}
ns.addOnName = "WinterVeil" -- For internal use to name globals etc. Should never be localised
ns.eventName = "Winter Veil" -- The player sees this in labels and titles. This gets localised

ns.aoa = {}
--ns.aoa[ 1034 ] = { acctOnly = true }

ns.bbDarnassus1 = "Once through the Magenta Portal you'll be facing due east. You need to turn 90 degrees and proceed south.\n\n"
			.."Hippogryph Riders patrol. The dome of the Temple of the Moon is NOT a safe place to rest."
ns.bbDarnassus2 = "The position is safe and yet still within the city"
ns.bbDarnassus3 = "Here's the trick. Inside, the Temple is one large open area. There is a mezzanine level which skirts the "
			.."entire perimeter. It is accessed by a ramp. There are guards at intervals. You'll die a few times.\n\n"
			.."Alternatively... Tyrande is on a platform on this mezzanine. The platform is directly above the entrance. You can "
			.."take advantage of dismount delays by flying straight in and then straight up and spining around 180 degrees. You'll "
			.."now be facing her.\n\nSpam your macro. Ensure the pond is below you. Fall into it for zero damage. Spin 180 degrees."
			.." Use an invisibility potion/spell.\n\nIf you must die then veer to the left of the exit - you need to rez and hearth"
			.." away from the guards"
ns.bbExodar1 = "Enter The Exodar through the side entrance"
ns.bbExodar2 = "No guards in this section. Pause for any cooldowns, trip to the fridge, toke, etc"
ns.bbExodar3 = "Two guards here. Hard left plus jump down then straight forward, bearing left a little"
ns.bbExodar4 = "Two guards here, three at the top of the stairs. Then take a hard right. Spam your macro now"
ns.bbExodar5 = "The Prophet is right here. Pelt him damn it!"
ns.bbExodar6 = "Safe to respawn and hearth/portal from here. Ideal place to die"
ns.bbMacro = "\n/stopmacro [noexists]\n/cancelaura Right In The Eye!\n/use Red Rider Air Rifle\n\nImportant! \"pelt\" is just one "
			.."of five outcomes of using the rifle. A short cancelable stun \"buff\" (say what) is possible. In other words, just "
			.."keep spamming. If your combat log says your ranged shot hit for one damage then you're good!" 
ns.bbMacroAR = "#showtooltip\n/cleartarget\n/tar Eitrigg\n/tar Lady Sylvanas\n/tar Lor'themar" ..ns.bbMacro
ns.bbMacroAC= "#showtooltip\n/cleartarget\n/tar Baine Bloodhoof\n/tar Garrosh\n/tar Lady Sylvanas\n/tar Lor'themar" ..ns.bbMacro
ns.bbMacroHR = "#showtooltip\n/cleartarget\n/tar Muradin\n/tar Prophet\n/tar Tyrande" ..ns.bbMacro
ns.bbMacroHC = "#showtooltip\n/cleartarget\n/tar Muradin\n/tar Prophet\n/tar Tyrande\n/tar King Varian" ..ns.bbMacro
ns.bbMuradin1 = "Fly in and stay up as high as possible. Use a small, stable mount for best visibilty and clearance"
ns.bbMuradin2 = "Fly over to this tunnel. Wait out your invisibility cooldown if necessary"
ns.bbMuradin3 = "There is a high up ledge here. Safe to pause and say your last prayers"
ns.bbMuradin4 = "Descend to here and enter \"The High Seat\" chamber"
ns.bbMuradin5 = "Try to die as close as possible to here so that you may rez safely down in the side passage"
ns.bbMuradin6 = "Spam your macro, staying close to your planned die location. Invisibility after you tag him is a nice bonus"
ns.bbOrg1 = "If finished and invisible then run to here and hearth. It's a nook behind the AH"
ns.bbOrg2 = "He's here. There's no sugar coating this: You'll die. It may take a few tries if you luck out spamming the macro"
ns.bbOrg3 = "Through here. Just inside is an okay spot to rez or pause (if you are lucky). Best to fly in - drop suddenly from "
			.."height. The doorway has a chicane. Do your best to surge through it and commence macro spamming. He's at the back. "
			.."Hopefully you get the pelt before you quickly die. A quick invisibility is always an option"
ns.bbSC1 = "The nearest flightpoint is Zul'Aman in Ghostlands. Toughest of the four. You will die. Make a dash for inside then a "
			.."sharp left and hide as per marker. BYO Invisibility pots (a LOT) or purchase a class change as a Mage!!!"
ns.bbSC2 = "He's right here. Try to pelt him from ranged as he has a lot of guards behind him. Decide where you will hearth (after "
			.."invis/rez). The translocation room at the rear or the earlier side room (with trainer NPCs)"
ns.bbSC3 = "Pinch point. The two pats are in opposite directions and you lose all visibility here. Wait at the earlier marker to "
			.."gain a sense of timing. Should be clear by now: without invisibility you'll die a lot"
ns.bbSC4 = "A couple of pats come through the Walk of Elders. You could try hiding in here with the vendors"
ns.bbSC5 = "A couple of pats come through Murder Row. You can pause over to the side as necessary"
ns.bbSC6 = "Wait out your invisibility/hearth cooldown here"
ns.bbSC7 = "So many guards here. Invisibility"
ns.bbSC8 = "2 guards here. Invisibility"
ns.bbSC9 = "12 nasty guards up ahead. Now is the time to go invisible"
ns.bbSC10 = "No guards here. A good place to hearth from invisibility"
ns.bbSC11 = "The side rooms are safe for hiding and hearthing. The NPCs here are all trainers. Also, if you used invisibility to "
			.."enter then wait out the CD here"
ns.bbSC12 = "Two guards and up ahead many more. Use invisibility"
ns.bbSC13 = "Two guards and up ahead many more. Use invisibility. For details on how to get here please see the "
			.."\"A-Caroling We Will Go\" markers"
ns.bbSeller = "Sells the Red Rider Air Rifle. Pats in this area"
ns.bbTB = "It's obvious enough that you simply swoop in and spam your macro but you really do need to plan your exit strategy in "
			.."order to minimise the unpleasant walk back to get your corpse. A movement speed buff to get you to the edge of the "
			.."mesa and then a means to slow your fall when you jump is ideal. Mages have it all with invisibility too of course. "
			.."Failing that, try to die so that you may rez at the rear of the teepee"
ns.bbUC1 = "Two guards here. Do not come this way as there's no chance later to cooldown your invisibility"
ns.bbUC2 = "Relax. No guards in this section. Use a small, stable mount for best visibility and clearance"
ns.bbUC3 = "Go this way. Guard up ahead"
ns.bbUC4 = "One guard here. Use invisibility"
ns.bbUC5 = "No guards through to here. Pause for invisibility cooldown if necessary"
ns.bbUC6 = "Enter here. Invisibility is your friend"
ns.bbUC7 = "There are two guards at each archway. Got invisibility?"
ns.bbUC8 = "The Dark Lady is up ahead. Just fire like crazy and die"

ns.armada = "\"Flamer\": Do the \"You're a mean one...\" daily and then check your stolen present each time.\n\n\"Killdozer\": You "
			.."need a level 3 Garrison. Complete the Winter Veil dailies for tokens, five of which allows you to purchase from "
			.."Izzy.\n\n\"Mortar\": Dropped by Smashum Grabb, a rare elite in Tanaan Jungle. Can drop all year so no stress.\n\n"
			.."\"Cannon\": Dropped by Gondar, a rare elite in Tanaan Jungle. Can drop all year so no stress.\n\n\"Roller\": "
			.."Dropped by Drakum, a rare elite in Tanaan Jungle. Can drop all year so no stress.\n\n(I've marked the Tanaan mob "
			.."locations. Be patient, drop rates are 10%. This pin marks your progress)"
ns.baine = "Baine is in his large teepee at Thunderbluff"
ns.broBenjamin = "He pats along the righthand side.\n\nNote: There is quest/story phasing here. If some Brothers are missing then "
			.."it's no coincdence that Anduin is nearby. Deal with him first"
ns.broCassius = "He's in tne first room on the right side"
ns.broCrowley = "He is in the basement. The stairs are in the second room on the right side"
ns.broDurkot = "Go to the ground floor. He pats through here"
ns.broJoshua = "In the Cathedral at the altar area"
ns.broKeltan = "He's on Orgrim's Hammer, a huge flying airship. Check your map for the current location"
ns.broKristoff = "Not inside the Cathedral. Near the fountain in the Cathedral's Square"

ns.caroling = "Purchase the Chorus Book from a Winter Veil vendor in any capital city, Shattrath or a level 3 Garrison. "
			.."It's a toy so place it on your hot bar and be ready to press the key."
ns.carolingCata = "The Gaudy Winter Veil Sweater is from a present from under the tree. Not before 25th December! "
			.."Place it on your hot bar and be ready to press the key"
ns.carolingDarn = "Find a quiet area on the city perimeter. A tree bough which is out of line of sight of everything is perfect!"
ns.carolingIF = "Here is a safe place. It's above the Gates of Ironforge"
ns.carolingOrg = "Fly in and land up high at the perimeter. Easy as!"
ns.carolingSC1 = "Don't bother with the old \"crack in the wall\" exploit. I tried it for testing. There is an invisible wall. "
			.."Baby Spice will not help too. If you must try then this is the location"
ns.carolingSC2 = "Without invisibility you will draw agro. Better to die/rez right here as there are more guards inside too!"
ns.carolingSC3 = "This is where you will rez, if you were wondering. Fairbreeze Village. Yeah... I took a hit for the team"
ns.carolingSC4 = "Farstrider Retreat will be to your left"
ns.carolingSC5 = "Come this way. Thuron's Livery on your left"
ns.carolingSC6 = "From Zul'Aman ride up to here. Stay on the left side of Lake Elrendar. Continue north into Eversong Woods"
ns.carolingSC7 = "Start here at the Zul'Aman flight point. If that is not possible then begin at Light's Hope Chapel in the "
			.."Eastern Plaguelands"
ns.carolingTB = "Just fly in and land on the very edge of any of the mesas. Easy peasy!"
ns.carolingUC1 = "Do NOT descend into Undercity"
ns.carolingUC1 = "The sewer entrance works perfectly fine. Stop entering when the Undercity map appears"

ns.snowballs = "Snow Balls are simply purchasable from Smokywood Pastures vendors but the Holiday Snow mounds in the Alterac "
			.."Mountains / Hillsbrad Foothills (SoD/Retail), Dun Morogh (R) and Winterspring (R) will contain 3 to 6 Snowballs. "
			.."\n\nWhile doing your Level 3 Garrison dailies in Frostfire Ridge, the Snow Mounds will give a snowball 50% of the "
			.."time but the main reason for farming is the 5% chance of a cool Grumpling pet (#10 P/B)"
ns.stolenDailySet = { { id=7043, name="You're a Mean One...", faction="Alliance", qType="Daily", },
			{ id=6983, name="You're a Mean One...", faction="Horde", qType="Daily", },
			{ id=7045, name="A Smokywood Pastures' Thank You!", faction="Alliance", qType="Seasonal", },
			{ id=6984, name="A Smokywood Pastures' Thank You!", faction="Horde", qType="Seasonal", }, }
ns.frostyShake = "Important!!! The Winter Veil Disguise Kit is mailed to you 24 hours after you complete \"A Smokey Pastures...\". "
			.."Give yourself enough time as the achievement must be completed while the event is ongoing.\n\n"
			.."No dance partner? No problem. This is NOT an illegal glitch/hack. Blizzard simply turn a blind eye to it!\n\n"
			.."All you need is two characters in Dalaran as follows:\n\n(1) Create TWO game "
			.."clients on your computer. The MOST important step. Do this by twice launching the game through Battlenet.\n\n(2) On "
			.."both clients position your characters in Dalaran. Notice that you eventually get logged out when you switch "
			.."clients. That's the key: It's not instant. Ignore any message from Blizzard.\n\n(3) Let's start. We need to be "
			.."smooth here. Quickly select the other game client. With your character you must select the other character and "
			.."/dance. Quickly as it will disappear soon! Congratulations!\n\n(4) Notice how the character on the other game got "
			.."logged out, but not right away!!! Rinse and repeat for the second character."
			.."\n\n" ..ns.snowballs

ns.falala = "Go here and speak to Chu'a'lor. Complete \"The Crystals\" then talk to Torkus and complete \"Our Boy wants...\" then "
			.."go to Chu'a'lor and complete \"The Skyguard Outpost\" then talk to Sky Commander Keller -> Vanderlip and complete "
			.."\"Bombing Run\". Only now is the daily \"Bomb Them Again\" available. Use your Fresh/Preserved Holly now!"
ns.garrison = "The quests are clustered just south-west of the Bloodmaul Slag Mines dungeon in Frostfire Ridge. Grumpus will be "
			.."tough to solo.\n\nThe point of the dailies is to gain currency to then decorate your Garrison, which must be at "
			.."level 3 to even see the quest givers. Careful: Applying the Winter Veil decorations will cancel some of your "
			.."Hallow's End decorations.\n\nThe reward currency may also be used to purchase a Savage Gift, which has a 3% chance "
			.."to contain the coveted Minion of Grumpus ground mount! It can be traded on the AH.\n\nThere's a 14% chance to "
			.."obtain a Medallion of the Legion. It rewards 1000 across Draenor reputations"
ns.oppositeFaction = "To encounter adventurers from the opposite faction you need to travel to a sanctuary where you may meet "
			.."them. This largely depends upon your \"timeline\".\n\n"
			.."Shattrath, both Dalarans, Oribos, Valdrakken, Dornogal, the Caverns of Time, amongst others, might be relevant.\n\n"
			.."You could visit enemy capital cities while completing some other task or achievement or engage in Battlegrounds.\n\n"
			.."Alterac Mountains (the Grinch/Metzen hub) is not so good due to phasing limiting the player numbers"
ns.magentaPortal = "Fly into the magenta portal fast and then press the space bar / \"up\" key immediately to go straight up. This "
			.."is especially important as the guards are very agressive"
ns.muradin = "Muradin is in his throne room in Ironforge"
ns.pepe = "Look at the vendors' cart. Perched on one end is Greatfeather Pepe. Click on Pepe. You're welcome <3\n\n"
			.."Click on Pepe any time to renew the buff"
ns.tanaanSpawns = "Spawns here. Every 5 to 10 minutes but is farmable once per day. Drop rate is about 10%"
ns.teldrassil = "Why not use the Darkshore (before \"Teldrassil fire\" phase) to Rut'theran Village boat! Flying is possible too. "
			.."Make sure you choose a short fatigue path. At Rut'theran another boat takes you to Azuremyst Isle or a magenta "
			.."portal will transport you to the top of the world tree into Darnassus"
ns.threeSet = "Strictly pieces of the \"Winter Garb\" set. Do not buy white/common items of the same name. Red or Green mixture "
			.."is okay.\n\n"
			.."The Red Winter Clothes is via a Horde only pattern from Winter Veil vendors. The Green Winter Clothes pattern is "
			.."likewise Alliance, except the Shattrath vendor who is cross faction. All vendors sell the Winter Boots pattern.\n\n"
			.."All three of the above clothes may be purchased on the AH. The hat is from a HEROIC boss drop. From WotLK onwards "
			.."these are 100% drops from Borean Tundra HEROIC dungeon bosses:\n\n"
			.."Red hat: Grand Magus Telestra in The Nexus, bottom entrance. Turn left after entering. It's the second boss fight. "
			.."Green Hat: Mage-Lord Urom, the 3rd boss in The Oculus. The entrance is above The Nexus. Do not timewalk either "
			.."dungeon.\n\nGraccu's Fruitcake: Any Smokywood Pastures food and beverage vendor from Pandaria onwards or as a "
			.."reward 24 hours after completing the Metzen rescue quest"
ns.threeSetNexus = "Don't forget to set \"Heroic\". You need both The Nexus and The Oculus"
ns.vendor = "Will happily sell you a snowball, a Winter Veil Chorus Book, patterns, recipes, spices, spirits and wrapping "
			.."paper! Time is money friend!"
ns.vendorFB = "Seller of Winter Veil food and beverages"
ns.vendorL3Garr = ".\n\nYou must have a level 3 garrison"
ns.winterReveler = "Winter Revelers are celebrating the Feast of Winter Veil in all of Azeroth's inns! If you /kiss a Reveler he "
			.."or she will reward you with a gift. This will be only once per hour as although they are raucous, they do tire of "
			.."travellers' constant attempts to pucker up under the mistletoe! The gift will be one of, in decreasing order of "
			.."frequency: a Handful of Snowflakes (Let It Snow achievement), Fresh Holly (Fa-la-la-la-Ogri'la), or Mistletoe "
			.."(Holiday Bromance)"
ns.yourHub = "Your Feast of Winter Veil hub!"

-- ---------------------------------------------------------------------------------------------------------------------------------
-- The Winter Veil Gourmet
ns.owlbeast = ". While the drop rate here is barely 60%, the mobs are plentiful and with fast respawns!"
ns.smallEgg = "Good Small Egg drop rate. Dragonhawk mobs in Eversong Woods have 100% drop rate. Numerous other mobs have >= 60% "
			.."drop rate. Look for this icon across all of Kalimdor / Eastern Kingdoms"
ns.gourmet = "Wulmort/Macey in IF, Penney/Kaymard in Org have most items. Small Egg: Purchase that on the AH or farm "
			.."it. Ice Cold Milk: The nearby inn.\n\nBest farming location for Small Eggs are by far the dragonhawks just outside "
			.."of Silvermoon City. A poor second best, but better for Alliance, are the barn owls along the western edge of "
			.."Duskwood.\n\nNote the vanilla cooking level requirements for the recipes!"
ns.gourmetA = { id=1688, showAllCriteria=true, guide=ns.gourmet, }
ns.setGourmetA = { ns.gourmetA }
ns.setTreatsForQ = { { id=7025, name="Treats for Great-father Winter", level=10, qType="Seasonal", faction="Alliance", },
			{ id=6962, name="Treats for Great-father Winter", level=10, qType="Seasonal", faction="Horde", }, }

-- ---------------------------------------------------------------------------------------------------------------------------------
-- With a Little Helper (PvP)
ns.withHelper = "Get the buff here. Then queue for the Isle of Conquest BG. Man a cannon. Quick and easy way for PvEers!\n\n"
			.."Another devious way: Enter the AV BG as a healer. Spam heals. You'll get their HKs"
ns.withALittle = { id=252, guide=ns.withHelper, }
ns.setWondervolt = { wondervolt=true, name="PX-238 Winter Wondervolt", showAnyway=true, achievements={ ns.withALittle }, }
ns.setWondervoltOver = { wondervolt=true, name="PX-238 Winter Wondervolt", showAnyway=true, version=40101,
			achievements={ ns.withALittle }, }
ns.setWondervoltUnder = { wondervolt=true, name="PX-238 Winter Wondervolt", showAnyway=true, versionUnder=40101,
			achievements={ ns.withALittle }, }

-- ---------------------------------------------------------------------------------------------------------------------------------
-- Cluster
ns.setWearTravel = { onMetzen=true, noCoords=true, alwaysShow=true, noContinent=true,
			-- On Metzen!, Simply Abom, A Frosty Shake
			quests=ns.stolenDailySet, achievements={ { id=273, tip="Complete the first quest", },
			{ id=279, tip="Complete the follow up quest", }, { id=1690, guide=ns.frostyShake, }, }, }
ns.setMeta = { bbKing=true, noCoords=true, alwaysShow=true, noContinent=true, -- Meta, BB King
			achievements={ { id=1691, showAllCriteria=true, }, { id=4436, faction="Alliance", showAllCriteria=true, },
			{ id=4437, faction="Horde", showAllCriteria=true, }, },
			tip="BB King requires the Red Rider Air Rifle. It's puchasable from the Toy vendor who pats around outside the "
			.."Stormwind Trade Quarter or Orgrimmar's drag. Also the Dalaran toy shop. Where possible I've included detailed "
			.."walkthroughs to minimise your pain with this achievement", }
ns.setReveler = { reveler=true, noCoords=true, alwaysShow=true, noContinent=true, -- Fa-la-la-la-Ogri'la, Let It Snow, Bromance
			achievements={ { id=1282, guide="Go to Blade's Edge Mountains in Outland and see the guide there. Must have a "
			.."reindeer \"mount\", rewarded from a gift under Great Father Winter's tree (Preserved Holly) or from a Winter "
			.."Reveler (Fresh Holly, see below)", }, { id=1687, showAllCriteria=true, guide=ns.oppositeFaction .."\n\nTo obtain "
			.."the Handful of Snowflakes see below", }, { id=1686, faction="Alliance", showAllCriteria=true, },
			{ id=1685, faction="Horde", showAllCriteria=true, }, }, guide=ns.winterReveler }			
ns.setFlavour = { flavour=true, name="The Feast of Great-Winter", noCoords=true, alwaysShow=true, noContinent=true,
			tip="'Twas the feast of Great-Winter\nAnd all through the land\nAll the races were running\n"
			.."With snowballs in hand.\nThe cooks were all frantic\nAnd for those \"in the know\"\n"
			.."Swoops and owls were crashing\nLike new-fallen snow.\n\nCookies and eggnog\n"
			.."Were consumed by all\nAs the snowballs flew freely\nAnd drunks smashed into walls.\n\n"
			.."May your feast of Great-Winter\nBe one merry and bright\nAnd from all here at Blizzard\n"
			.."We wish you a fun night!\n\n((From the original holiday description!))" }
ns.setEnemies = { caroling=true, noCoords=true, alwaysShow=true, noContinent=true, achievements={ { id=277, guide=ns.threeSet, },
			{ id=5853, faction="Alliance", }, { id=5854, Faction="Horde", }, { id=1689, }, -- 'Tis the Season, A-Caroling, He Knows, 
			{ id=20511, version=110000, tip="The Box of Puntables might be one of your gifts from under the tree!", }, }, } -- Punt
ns.setRacers = { armada=true, noCoords=true, alwaysShow=true, noContinent=true,
			achievements={ { id=1295, }, { id=8699, version=50400, }, -- Crashin' Thrashin', Danger Zone, Iron armada, Rock n' Roll
			{ id=10353, showAllCriteria=true, version=60202, guide=ns.armada, }, { id=15181, version=90105, }, }, }
ns.setScroogePvP = { scroogePvP=true, noCoords=true, alwaysShow=true, noContinent=true,	quests=ns.setTreatsForQ,	
			achievements={ { id=1255, faction="Alliance", tip=ns.muradin, }, { id=259, Faction="Horde", tip=ns.baine, }, -- Scrooge
			ns.gourmetA, ns.withALittle }, tip="\"With a Little...\" requires you to transform via a Wintervolt machine. There's "
			.."one in each city, locations have been marked", } -- The Winter Veil, With a Little Helper
				
-- ---------------------------------------------------------------------------------------------------------------------------------

-- Achievements:
-- With a Little Helper From My Friends - 252 Alliance/Horde
-- BB King - 4436 Alliance, 4437 Horde
-- A-Caroling We Will Go - 5853 Alliance, 5854 Horde
-- Fa-la-la-la-Ogri'la - 1282 Alliance/Horde
-- 'Tis the Season - 277 Alliance/Horde
-- Let it Snow - 1687 Alliance/Horde
-- Gourmet - 1688 Alliance/Horde
-- A Frosty Shake - 1690 Alliance/Horde
-- On Metzen - 273 Alliance/Horde
-- Iron Armada - 10353 Alliance/Horde
-- Holiday Bromance - 1686 Alliance, 1685 Horde

--	[81007600] = ns.setMerrymaker,
--	[84007100] = ns.setTisSeason,
--	[84007500] = ns.setFlavour,
--	[84007900] = ns.setIronArmada,
--	[86007400] = ns.setGourmet,

--==================================================================================================================================
--
-- KALIMDOR
--
--==================================================================================================================================

ns.points[ 76 ] = { -- Azshara
	[46007800] = { gourmet=true, tip="Static-Charged Hippogryph", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
	[48001700] = { gourmet=true, tip="Thunderhead Hippogryph", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
}

ns.points[ 1447 ] = { -- Azshara
	[46007800] = { gourmet=true, tip="Static-Charged Hippogryph", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
	[48001700] = { gourmet=true, tip="Thunderhead Hippogryph", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
}

ns.points[ 97 ] = { -- Azuremyst Isle
	[14008300] = { gourmet=true, tip="Owlbeast mobs", achievements=ns.setGourmetA,
					quests=ns.setTreatsForQ, guide=ns.smallEgg ..ns.owlbeast, },
	[24674933] = { bbKing=true, caroling=true, name="The Exodar Side Entrance", faction="Horde",
					achievements={ { id=4437, index=2, showAllCriteria=true, guide=ns.bbMacroHR,
					tip="Look at The Exodar map before you go too far inside", },
					{ id=5854, index=2, showAllCriteria=true, guide=ns.caroling,
						tip="No need to go very far inside The Exodar. No guards in this section", }, },
					tip="Enter The Exodar through the side entrance", },
	[28404273] = { vendor=true, name="Wolgren Jinglepocket", faction="Alliance", tip=ns.vendor },
	[34634441] = ns.setWondervolt,
	[40002300] = { gourmet=true, tip="Timberstrider mobs", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
	[53006100] = { gourmet=true, tip="Timberstrider mobs", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
}

ns.points[ 1943 ] = { -- Azuremyst Isle
	[14008300] = { gourmet=true, tip="Owlbeast mobs", achievements=ns.setGourmetA,
					quests=ns.setTreatsForQ, guide=ns.smallEgg ..ns.owlbeast, },
	[24674933] = { bbKing=true, caroling=true, name="The Exodar Side Entrance", faction="Horde",
					achievements={ { id=4437, index=4, showAllCriteria=true, guide=ns.bbMacroHC,
					tip="Look at The Exodar map before you go too far inside", },
					{ id=5854, index=3, showAllCriteria=true, guide=ns.carolingCata,
						tip="No need to go very far inside The Exodar. No guards in this section", }, },
					tip="Enter The Exodar through the side entrance", },
	[28404273] = { vendor=true, name="Wolgren Jinglepocket", faction="Alliance", tip=ns.vendor },
	[34634441] = ns.setWondervolt,
	[40002300] = { gourmet=true, tip="Timberstrider mobs", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
	[53006100] = { gourmet=true, tip="Timberstrider mobs", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
}

ns.points[ 62 ] = { -- Darkshore
	[43605290] = { gourmet=true, tip="Moonkin mobs", achievements=ns.setGourmetA,
					quests=ns.setTreatsForQ, guide=ns.smallEgg, },
	[44604540] = { gourmet=true, tip="Moonkin mobs", achievements=ns.setGourmetA,
					quests=ns.setTreatsForQ, guide=ns.smallEgg, },
}

ns.points[ 1439 ] = { -- Darkshore
	[43605290] = { gourmet=true, tip="Moonkin mobs", achievements=ns.setGourmetA,
					quests=ns.setTreatsForQ, guide=ns.smallEgg, },
	[44604540] = { gourmet=true, tip="Moonkin mobs", achievements=ns.setGourmetA,
					quests=ns.setTreatsForQ, guide=ns.smallEgg, },
}

ns.points[ 89 ] = { -- Darnassus	
	[36125035] = { bbKing=true, caroling=true, name="Magenta Portal to Rut'theran Village", faction="Horde",
					achievements={ { id=4437, index=2, showAllCriteria=true, guide=ns.bbMacroHR, },
					{ id=5854, index=2, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingDarn, }, },
					tip=ns.teldrassil .."\n\n" ..ns.magentaPortal, },
	[36989615] = { bbKing=true, caroling=true, name="Chillax", faction="Horde",
					achievements={ { id=4437, index=2, showAllCriteria=true, guide=ns.bbMacroHR, tip="Good location to pause", },
					{ id=5854, index=2, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingDarn, }, }, tip=ns.bbDarnassus2, },
	[39558020] = { bbKing=true, caroling=true, name="Rez and Hearth", faction="Horde",
					achievements={ { id=4437, index=2, showAllCriteria=true, guide=ns.bbMacroHR, },
					{ id=5854, index=2, showAllCriteria=true, }, }, },
	[42977433] = { bbKing=true, name="Temple of the Moon Entrance", faction="Horde",
					achievements={ { id=4437, index=2, showAllCriteria=true, guide=ns.bbMacroHR, tip=ns.bbDarnassus3, }, }, },
}

ns.points[ 1457 ] = { -- Darnassus
	[36125035] = { bbKing=true, caroling=true, name="Magenta Portal to Rut'theran Village", faction="Horde",
					achievements={ { id=4437, index=3, showAllCriteria=true, guide=ns.bbMacroHC, },
					{ id=5854, index=1, showAllCriteria=true, guide=ns.carolingCata, tip=ns.carolingDarn, }, },
					tip=ns.teldrassil .."\n\n" ..ns.magentaPortal, },
	[36989615] = { bbKing=true, caroling=true, name="Chillax", faction="Horde",
					achievements={ { id=4437, index=3, showAllCriteria=true, guide=ns.bbMacroHC, tip="Good location to pause", },
					{ id=5854, index=1, showAllCriteria=true, guide=ns.carolingCata, tip=ns.carolingDarn, }, },
					tip=ns.bbDarnassus2, },
	[39558020] = { bbKing=true, caroling=true, name="Rez and Hearth", faction="Horde",
					achievements={ { id=4437, index=3, showAllCriteria=true, guide=ns.bbMacroHC, },
					{ id=5854, index=1, showAllCriteria=true, guide=ns.carolingCata, }, }, },
	[42977433] = { bbKing=true, name="Temple of the Moon Entrance", faction="Horde",
					achievements={ { id=4437, index=3, showAllCriteria=true, guide=ns.bbMacroHC, tip=ns.bbDarnassus3, }, }, },
}

ns.points[ 1 ] = { -- Durotar
	[44000210] = ns.setWondervolt,
	[45600656] = { miscQuests=true, name="Greatfather Winter", faction="Horde",
					quests={ { id=6962, name="Treats for Great-father Winter", level=10, qType="Seasonal", }, }, },
	[46480610] = { onMetzen=true, name="Kaymard Copperpinch", faction="Horde", tip=ns.vendorFB,
					achievements={ { id=273, showAllCriteria=true, }, { id=279, showAllCriteria=true, }, },
					quests={ { id=6961, name="Great-father Winter is Here!", level=10, qType="Seasonal", },
						{ id=6983, name="You're a Mean One...", level=80, qType="Daily", },
						{ id=6984, name="A Smokywood Pastures' Thank You!", level=30, qType="Seasonal", },
						{ id=8799, name="The Hero of the Day", level=40, qType="Seasonal", }, }, },
	[46530618] = { vendor=true, name="Penney Copperpinch", tip=ns.vendor },
}

ns.points[ 1411 ] = { -- Durotar
	[45730120] = ns.setWondervoltOver,
	[50031351] = ns.setWondervoltUnder,
	[46530618] = { vendor=true, name="Penney Copperpinch", faction="Horde", version=40101, tip=ns.vendor, },
	[46610428] = { vendor=true, name="Penney Copperpinch", faction="Horde", versionUnder=40101, tip=ns.vendor, },
	[46640444] = { onMetzen=true, name="Kaymard Copperpinch", faction="Horde", versionUnder=40101, tip=ns.vendorFB,
					achievements={ { id=273, showAllCriteria=true, }, { id=279, showAllCriteria=true, }, },
					quests={ { id=6961, name="Great-father Winter is Here!", level=10, qType="Seasonal", },
						{ id=6963, name="Stolen Winter Veil Treats", level=30, qType="Seasonal", },
						{ id=6983, name="You're a Mean One...", level=30, qType="Daily", },
						{ id=6984, name="A Smokywood Pastures' Thank You!", level=30, qType="Seasonal", },
						{ id=8746, name="Metzen the Reindeer", level=40, qType="Seasonal", },
						{ id=8799, name="The Hero of the Day", level=40, qType="Seasonal", }, }, },
	[46480610] = { onMetzen=true, name="Kaymard Copperpinch", faction="Horde", version=40101, tip=ns.vendorFB,
					achievements={ { id=273, showAllCriteria=true, }, { id=279, showAllCriteria=true, }, },
					quests={ { id=6961, name="Great-father Winter is Here!", level=10, qType="Seasonal", },
						{ id=6983, name="You're a Mean One...", level=80, qType="Daily", },
						{ id=6984, name="A Smokywood Pastures' Thank You!", level=30, qType="Seasonal", },
						{ id=8799, name="The Hero of the Day", level=40, qType="Seasonal", }, }, },
}

ns.points[ 70 ] = { -- Dustwallow Marsh
	[67404720] = { reveler=true, name="Brother Karman", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=3, tip="Old Theramore" }, }, },
}

ns.points[ 1445 ] = { -- Dustwallow Marsh
	[67404720] = { reveler=true, name="Brother Karman", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=5, tip="Old Theramore" }, }, },
}

ns.points[ 7 ] = { -- Mulgore
	[42003400] = { caroling=true, faction="Alliance",
					achievements={ { id=5853, index=3, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingTB }, }, },
	[42512865] = { scroogePvP=true, name="Baine Bloodhoof", tip=ns.baine,
					achievements={ { id=259, showAllCriteria=true, faction="Horde", }, }, },
	[52004500] = { gourmet=true, tip="Wiry Swoop", achievements=ns.setGourmetA, quests=ns.setTreatsForQ, guide=ns.smallEgg, },
}

ns.points[ 1412 ] = { -- Mulgore
	[38682887] = { vendor=true, name="Seersa Copperpinch", faction="Horde", versionUnder=40101, tip=ns.vendor, },
	[39062927] = { vendor=true, name="Seersa Copperpinch", faction="Horde", version=40101, tip=ns.vendor, },
	[38702880] = { vendor=true, name="Whulwert Copperpinch", versionUnder=40101, faction="Horde",
					quests={ { id=7021, name="Great-father Winter is Here!", level=10, qType="Seasonal", }, }, tip=ns.vendorFB },
	[39102933] = { vendor=true, name="Whulwert Copperpinch", version=40101, faction="Horde",
					quests={ { id=7021, name="Great-father Winter is Here!", level=10, qType="Seasonal", }, }, tip=ns.vendorFB },
	[42003400] = { caroling=true, faction="Alliance", version=40300,
					achievements={ { id=5853, index=1, showAllCriteria=true, guide=ns.carolingCata, tip=ns.carolingTB }, }, },
	[42502864] = { scroogePvP=true, achievements={ { id=259, showAllCriteria=true, faction="Horde", }, }, tip=ns.baine, },
	[42522866] = { bbKing=true, achievements={ { id=4436, index=4, showAllCriteria=true, faction="Alliance",
					guide=ns.bbMacroAR, tip=ns.bbTB, }, }, },
	[52004500] = { gourmet=true, tip="Wiry Swoop", achievements=ns.setGourmetA, quests=ns.setTreatsForQ, guide=ns.smallEgg, },
}

ns.points[ 85 ] = { -- Orgrimmar
	[39534733] = { miscQuests=true, name="Sagorne Creststrider", faction="Horde",
					quests={ { id=7061, name="The Feast of Winter Veil", level=10, qType="Seasonal", }, }, },
	[48047028] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=3, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbOrg2, }, }, },
	[49877845] = { miscQuests=true, name="Greatfather Winter", faction="Horde",
					quests={ { id=6962, name="Treats for Great-father Winter", level=10, qType="Seasonal", }, }, },
	[50137633] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=3, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbOrg3, }, }, },
	[50256215] = ns.setWondervolt,
	[51307100] = { miscQuests=true, name="Furmund", faction="Horde",
					quests={ { id=6964, name="The Reason for the Season", level=10, qType="Seasonal", }, }, },
	[52687728] = { vendor=true, name="Penney Copperpinch", faction="Horde", tip=ns.vendor },
	[52547706] = { onMetzen=true, name="Kaymard Copperpinch", faction="Horde", tip=ns.vendorFB,
						achievements={ { id=273, showAllCriteria=true, }, { id=279, showAllCriteria=true, }, },
						quests={ { id=6961, name="Great-father Winter is Here!", level=10, qType="Seasonal", },
						{ id=6983, name="You're a Mean One...", level=30, qType="Daily", },
						{ id=6984, name="A Smokywood Pastures' Thank You!", level=10, qType="Seasonal", }, }, },
	[52997743] = { reveler=true, name="Greatfeather Pepe", faction="Horde", tip=ns.pepe, buff=316936,
					quests={ { id=58901, name="Greatfeather Pepe", qType="One Time", }, }, },
	[55487852] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=3, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbOrg1, }, }, },
	[58605380] = { bbKing=true, name="Blax Bottlerocket", faction="Horde",
					achievements={ { id=4437, showAllCriteria=true, guide=ns.bbMacroHR, tip=ns.bbSeller, }, }, },
	[58806040] = { bbKing=true, name="Blax Bottlerocket", faction="Horde",
					achievements={ { id=4437, showAllCriteria=true, guide=ns.bbMacroHR, tip=ns.bbSeller, }, }, },
	[70007000] = { caroling=true, faction="Alliance",
					achievements={ { id=5853, index=1, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingOrg }, }, },
}

ns.points[ 1454 ] = { -- Orgrimmar
	[38803660] = { miscQuests=true, name="Sagorne Creststrider", faction="Horde", versionUnder=40000,
					quests={ { id=7061, name="The Feast of Winter Veil", level=10, qType="Seasonal", }, }, },
	[39534733] = { miscQuests=true, name="Sagorne Creststrider", faction="Horde", version=40000,
					quests={ { id=7061, name="The Feast of Winter Veil", level=10, qType="Seasonal", }, }, },
	[48047028] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=1, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbOrg2, }, }, },
	[50137633] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=1, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbOrg3, }, }, },
	[50256215] = ns.setWondervoltOver,
	[51027099] = { miscQuests=true, name="Furmund", faction="Horde", version=40101,
					quests={ { id=6964, name="The Reason for the Season", level=10, qType="Seasonal", }, }, },
	[49637799] = { miscQuests=true, name="Greatfather Winter", faction="Horde", version=40101, 
					quests={ { id=6962, name="Treats for Great-father Winter", level=10, qType="Seasonal", }, }, },
	[52506919] = { miscQuests=true, name="Greatfather Winter", faction="Horde", versionUnder=40101, 
					quests={ { id=6962, name="Treats for Great-father Winter", level=10, qType="Seasonal", }, }, },
	[52687728] = { vendor=true, name="Penney Copperpinch", faction="Horde", version=40101, tip=ns.vendor, },
	[53216590] = { vendor=true, name="Penney Copperpinch", faction="Horde", versionUnder=40101, tip=ns.vendor, },
	[53346648] = { onMetzen=true, name="Kaymard Copperpinch", faction="Horde", versionUnder=40101, tip=ns.vendorFB,
					achievements={ { id=273, showAllCriteria=true, }, { id=279, showAllCriteria=true, }, },
					quests={ { id=6961, name="Great-father Winter is Here!", level=10, qType="Seasonal", },
						{ id=6963, name="Stolen Winter Veil Treats", level=30, qType="Seasonal", },
						{ id=6983, name="You're a Mean One...", level=30, qType="Daily", },
						{ id=6984, name="A Smokywood Pastures' Thank You!", level=30, qType="Seasonal", },
						{ id=8746, name="Metzen the Reindeer", level=40, qType="Seasonal", },
						{ id=8799, name="The Hero of the Day", level=40, qType="Seasonal", }, }, },
	[52537705] = { onMetzen=true, name="Kaymard Copperpinch", faction="Horde", version=40101, tip=ns.vendorFB,
					achievements={ { id=273, showAllCriteria=true, }, { id=279, showAllCriteria=true, }, },
					quests={ { id=6961, name="Great-father Winter is Here!", level=10, qType="Seasonal", },
						{ id=6983, name="You're a Mean One...", level=80, qType="Daily", },
						{ id=6984, name="A Smokywood Pastures' Thank You!", level=30, qType="Seasonal", },
						{ id=8799, name="The Hero of the Day", level=40, qType="Seasonal", }, }, },
	[55487852] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=1, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbOrg1, }, }, },
	[58605380] = { bbKing=true, name="Blax Bottlerocket", faction="Horde",
					achievements={ { id=4437, showAllCriteria=true, guide=ns.bbMacroHR, tip=ns.bbSeller, }, }, },
	[58806040] = { bbKing=true, name="Blax Bottlerocket", faction="Horde",
					achievements={ { id=4437, showAllCriteria=true, guide=ns.bbMacroHR, tip=ns.bbSeller, }, }, },
	[70007000] = { caroling=true, faction="Alliance", version=40300,
					achievements={ { id=5853, index=3, showAllCriteria=true, guide=ns.carolingCata, tip=ns.carolingOrg }, }, },
}

ns.points[ 71 ] = { -- Tanaris
	[52522806] = ns.setWondervolt,
}

ns.points[ 1446 ] = { -- Tanaris
	[53602800] = ns.setWondervolt,
--	[52522806] = ns.setWondervolt,
	[73204800] = { onMetzen=true, name="Metzen the Reindeer", versionUnder=40300, guide=ns.greench,
					achievements={ { id=273, showAllCriteria=true, }, { id=279, showAllCriteria=true, }, },
					quests={ { id=8746, name="Metzen the Reindeer", level=40, qType="Seasonal", faction="Horde", },
					{ id=8762, name="Metzen the Reindeer", level=40, qType="Seasonal", faction="Alliance", }, }, },
}

ns.points[ 57 ] = { -- Teldrassil
	[42003300] = { gourmet=true, tip="Strigid mobs", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
	[42005800] = { gourmet=true, tip="Strigid mobs", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
	[55038822] = { bbKing=true, caroling=true, name="Magenta Portal", faction="Horde",
					achievements={ { id=4437, index=2, showAllCriteria=true, guide=ns.bbMacroHR, tip=ns.bbDarnassus, },
					{ id=5854, index=2, showAllCriteria=true, guide=ns.caroling, }, },
					tip=ns.teldrassil .."\n\n" ..ns.magentaPortal, },
	[52288948] = { bbKing=true, caroling=true, name="Portal to Azuremyst Isle", faction="Horde",
					achievements={ { id=4437, index=2, showAllCriteria=true, guide=ns.bbMacroHR, },
					{ id=5854, index=2, showAllCriteria=true, guide=ns.caroling, }, },
					tip=ns.teldrassil, },
}

ns.points[ 1438 ] = { -- Teldrassil
	[42003300] = { gourmet=true, tip="Strigid mobs", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
	[42005800] = { gourmet=true, tip="Strigid mobs", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
	[55038822] = { bbKing=true, caroling=true, name="Magenta Portal", faction="Horde", version=40300,
					achievements={ { id=4437, index=3, showAllCriteria=true, guide=ns.bbMacroHC, tip=ns.bbDarnassus, },
					{ id=5854, index=1, showAllCriteria=true, guide=ns.carolingCata, }, },
					tip=ns.teldrassil .."\n\n" ..ns.magentaPortal, },
	[52288948] = { bbKing=true, caroling=true, name="Portal to Azuremyst Isle", faction="Horde", version=40300,
					achievements={ { id=4437, index=3, showAllCriteria=true, guide=ns.bbMacroHC, },
					{ id=5854, index=1, showAllCriteria=true, guide=ns.carolingCata, }, }, tip=ns.teldrassil, },
}

ns.points[ 103 ] = { -- The Exodar
	[26354940] = { bbKing=true, name="BB King (6)", faction="Horde",
					achievements={ { id=4437, index=2, showAllCriteria=true, guide=ns.bbMacroHR, tip=ns.bbExodar6, }, }, },
	[31486188] = { bbKing=true, name="BB King (4)", faction="Horde",
					achievements={ { id=4437, index=2, showAllCriteria=true, guide=ns.bbMacroHR, tip=ns.bbExodar4, }, }, },
	[32865450] = { bbKing=true, name="BB King (5)", faction="Horde",
					achievements={ { id=4437, index=2, showAllCriteria=true, guide=ns.bbMacroHR, tip=ns.bbExodar5, }, }, },
	[35127476] = { bbKing=true, name="BB King (3)", faction="Horde",
					achievements={ { id=4437, index=2, showAllCriteria=true, guide=ns.bbMacroHR, tip=ns.bbExodar3, }, }, },
	[37405993] = { bbKing=true, name="BB King (2)", faction="Horde",
					achievements={ { id=4437, index=2, showAllCriteria=true, guide=ns.bbMacroHR, tip=ns.bbExodar2, }, }, },
	[42107240] = { bbKing=true, name="BB King (1)", faction="Horde",
					achievements={ { id=4437, index=2, showAllCriteria=true, guide=ns.bbMacroHR, tip=ns.bbExodar1, }, }, },
	[55604980] = { vendor=true, name="Bessbi Jinglepocket", faction="Alliance", tip=ns.vendorFB },
	[55824883] = { vendor=true, name="Wolgren Jinglepocket", faction="Alliance", tip=ns.vendor },
}

ns.points[ 1947 ] = { -- The Exodar
	[26354940] = { bbKing=true, name="BB King (6)", faction="Horde",
					achievements={ { id=4437, index=4, showAllCriteria=true, guide=ns.bbMacroHC, tip=ns.bbExodar6, }, }, },
	[31486188] = { bbKing=true, name="BB King (4)", faction="Horde",
					achievements={ { id=4437, index=4, showAllCriteria=true, guide=ns.bbMacroHC, tip=ns.bbExodar4, }, }, },
	[32865450] = { bbKing=true, name="BB King (5)", faction="Horde",
					achievements={ { id=4437, index=4, showAllCriteria=true, guide=ns.bbMacroHC, tip=ns.bbExodar5, }, }, },
	[35127476] = { bbKing=true, name="BB King (3)", faction="Horde",
					achievements={ { id=4437, index=4, showAllCriteria=true, guide=ns.bbMacroHC, tip=ns.bbExodar3, }, }, },
	[37405993] = { bbKing=true, name="BB King (2)", faction="Horde",
					achievements={ { id=4437, index=4, showAllCriteria=true, guide=ns.bbMacroHC, tip=ns.bbExodar2, }, }, },
	[42107240] = { bbKing=true, name="BB King (1)", faction="Horde",
					achievements={ { id=4437, index=4, showAllCriteria=true, guide=ns.bbMacroHC, tip=ns.bbExodar1, }, }, },
	[55604980] = { vendor=true, name="Bessbi Jinglepocket", faction="Alliance", tip=ns.vendorFB },
	[55824883] = { vendor=true, name="Wolgren Jinglepocket", faction="Alliance", tip=ns.vendor },
}

ns.points[ 88 ] = { -- Thunder Bluff
	[42505580] = { vendor=true, name="Seersa Copperpinch", faction="Horde", tip=ns.vendor },
	[42605660] = { vendor=true, name="Whulwert Copperpinch", faction="Horde",
					quests={ { id=7021, name="Great-father Winter is Here!", level=10, qType="Seasonal", }, }, tip=ns.vendorFB },
	[60305169] = { scroogePvP=true, achievements={ { id=259, showAllCriteria=true, faction="Horde", }, }, tip=ns.baine, },
	[63003300] = { caroling=true, faction="Alliance",
					achievements={ { id=5853, index=3, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingTB }, }, },
}

ns.points[ 1456 ] = { -- Thunder Bluff
	[43685918] = { vendor=true, name="Seersa Copperpinch", faction="Horde", versionUnder=40101, tip=ns.vendor, },
	[42285495] = { vendor=true, name="Seersa Copperpinch", faction="Horde", version=40101, tip=ns.vendor, },
	[43805884] = { vendor=true, name="Whulwert Copperpinch", versionUnder=40101, faction="Horde",
					quests={ { id=7021, name="Great-father Winter is Here!", level=10, qType="Seasonal", }, }, tip=ns.vendorFB },
	[42465526] = { vendor=true, name="Whulwert Copperpinch", version=40101, faction="Horde",
					quests={ { id=7021, name="Great-father Winter is Here!", level=10, qType="Seasonal", }, }, tip=ns.vendorFB },
--	[42605660] = { vendor=true, name="Whulwert Copperpinch", faction="Horde",
--					quests={ { id=7021, qType="Seasonal", }, }, tip=ns.vendorFB },
	[60295168] = { scroogePvP=true, achievements={ { id=259, showAllCriteria=true, faction="Horde", }, }, tip=ns.baine, },
	[60315170] = { bbKing=true, achievements={ { id=4436, index=4, showAllCriteria=true, faction="Alliance",
					guide=ns.bbMacroAR, tip=ns.bbTB, }, }, },
	[63003300] = { caroling=true, faction="Alliance", version=40300,
					achievements={ { id=5853, index=1, cguide=ns.carolingCata, tip=ns.carolingTB }, }, },
}

ns.points[ 83 ] = { -- Winterspring
	[33005300] = ns.setHolidaySnow,
	[54503450] = ns.setHolidaySnow,
	[57007900] = ns.setHolidaySnow,
}

ns.points[ ns.map.kalimdor ] = { -- Kalimdor
	[91506320] = ns.setWearTravel,
	[91506750] = ns.setMeta,
	[93707030] = ns.setReveler,
	[94006600] = ns.setFlavour,
	[94206200] = ns.setEnemies,
	[96306900] = ns.setRacers,
	[96606480] = ns.setScroogePvP,
}

--==================================================================================================================================
--
-- EASTERN KINGDOMS
--
--==================================================================================================================================

						
ns.points[ 1416 ] = { -- Alterac Mountains
	[33586794] = { onMetzen=true, name="Strange Snowman", versionUnder=40300, guide=ns.greench,
					achievements={ { id=273, showAllCriteria=true, }, { id=279, showAllCriteria=true, }, },
					quests={ { id=6983, name="You're a Mean One...", level=80, qType="Daily", faction="Horde", },
						{ id=7043, name="You're a Mean One...", level=80, qType="Daily", faction="Alliance", },
						{ id=6984, name="A Smokywood Pastures' Thank You!", level=30, qType="Seasonal", faction="Horde", },
						{ id=7045, name="A Smokywood Pastures' Thank You!", level=30, qType="Seasonal", faction="Alliance", }, }, },
	[34006300] = { reveler=true, achievements={ { id=1687, showAllCriteria=true, guide=ns.oppositeFaction, }, }, },
	[35406130] = ns.setHolidaySnow,
	[40306580] = ns.setHolidaySnow,
	[46304800] = ns.setHolidaySnow,
}	

ns.points[ 27 ] = { -- Dun Morogh
	[40004500] = ns.setHolidaySnow, -- Research says none in Classic or Classic Cata
	[53006000] = ns.setHolidaySnow,
	[51505410] = ns.setHolidaySnow,
	[59203010] = { bbKing=true, name="BB King", faction="Horde",
					achievements={ { id=4437, index=1, showAllCriteria=true, guide=ns.bbMacroHR, tip=ns.bbMuradin1, }, }, },
	[59303200] = { onMetzen=true, name="Wulmort Jinglepocket", faction="Alliance", tip=ns.vendor,
					achievements={ { id=273, showAllCriteria=true, }, { id=279, showAllCriteria=true, }, },
					quests={ { id=7022, name="Greatfather Winter is Here!", level=10, qType="Seasonal", },
					{ id=7043, name="You're a Mean One...", level=30, qType="Daily", },
					{ id=7045, name="A Smokywood Pastures' Thank You!", level=10, qType="Seasonal", }, }, },
	[60333394] = ns.setWondervolt,
	[60813290] = { caroling=true, name="Caroling", faction="Horde",
					achievements={ { id=5854, index=3, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingIF }, }, },
	[61003000] = { scroogePvP=true, name="Muradin Bronzebeard", achievements={
					{ id=1255, showAllCriteria=true, faction="Alliance", guide="Muradin is on his throne in Ironforge", }, }, },
	[63572980] = { miscQuests=true, name="Greatfather Winter", faction="Alliance",
					quests={ { id=7025, name="Treats for Great-father Winter", level=10, qType="Seasonal", }, }, },
	[63643009] = { vendor=true, name="Macey Jinglepocket", faction="Alliance", tip=ns.vendorFB },
	[72004900] = ns.setHolidaySnow,
}

ns.points[ 1426 ] = { -- Dun Morogh
	[59203010] = { bbKing=true, name="BB King", faction="Horde",
					achievements={ { id=4437, index=2, showAllCriteria=true, guide=ns.bbMacroHC, tip=ns.bbMuradin1, }, }, },
	[56493188] = { onMetzen=true, name="Wulmort Jinglepocket", faction="Alliance", versionUnder=40101, tip=ns.vendor,
					quests={ { id=7022, name="Greatfather Winter is Here!", level=10, qType="Seasonal", },
					{ id=7045, name="A Smokywood Pastures' Thank You!", level=30, qType="Seasonal", },
					{ id=7042, name="Stolen Winter Veil Treats", level=30, qType="Seasonal", },
					{ id=7043, name="You're a Mean One...", level=30, qType="Seasonal", },
					{ id=8762, name="Metzen the Reindeer", level=40, qType="Seasonal", },
					{ id=8763, name="The Hero of the Day", level=40, qType="Seasonal", }, }, },
	[63633020] = { onMetzen=true, name="Wulmort Jinglepocket", faction="Alliance", version=40101, tip=ns.vendor,
					achievements={ { id=273, showAllCriteria=true, }, { id=279, showAllCriteria=true, }, },
					quests={ { id=7022, name="Great-father Winter is Here!", level=10, qType="Seasonal", },
					{ id=7045, name="A Smokywood Pastures' Thank You!", level=30, qType="Seasonal", },
					{ id=7043, name="You're a Mean One...", level=80, qType="Daily", }, }, },
	[53183571] = ns.setWondervolt, -- check again. use under over?
	[56413159] = { miscQuests=true, name="Greatfather Winter", faction="Alliance", versionUnder=40101, 
					quests={ { id=7025, name="Treats for Great-father Winter", level=10, qType="Seasonal", }, }, },
	[63572980] = { miscQuests=true, name="Greatfather Winter", faction="Alliance", version=40101,
					quests={ { id=7025, name="Treats for Great-father Winter", level=10, qType="Seasonal", }, }, },
	[56473196] = { vendor=true, name="Macey Jinglepocket", faction="Alliance", versionUnder=40101, tip=ns.vendorFB },
	[63643009] = { vendor=true, name="Macey Jinglepocket", faction="Alliance", version=40101, tip=ns.vendorFB },
	[60813290] = { caroling=true, name="Caroling", faction="Horde", version=40300,
					achievements={ { id=5854, index=4, showAllCriteria=true, guide=ns.carolingCata, tip=ns.carolingIF }, }, },
	[61003000] = { scroogePvP=true, name="Muradin Bronzebeard", achievements={
					{ id=1255, showAllCriteria=true, faction="Alliance", guide="Muradin is on his throne in Ironforge", }, }, },
	[72004900] = ns.setHolidaySnow,
}

ns.points[ 47 ] = { -- Duskwood
	[11605000] = { gourmet=true, tip="Barn Owls", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
	[17002800] = { gourmet=true, tip="Barn Owls", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
}

ns.points[ 1431 ] = { -- Duskwood
	[11605000] = { gourmet=true, tip="Barn Owls", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
	[17002800] = { gourmet=true, tip="Barn Owls", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
}

ns.points[ 37 ] = { -- Elwynn Forest
	[20475698] = { caroling=true, name="Caroling", faction="Horde", achievements={
					{ id=5854, index=4, showAllCriteria=true, guide=ns.caroling, tip="Example safe location" }, }, },
	[22202290] = { reveler=true, name="Brothers (several)", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, tip="Cathedral area" }, }, },
	[26033749] = { vendor=true, name="Khole Jinglepocket", faction="Alliance", tip=ns.vendor,
					quests={ { id=7023, name="Greatfather Winter Is Here", level=10, qType="Seasonal", }, }, },
	[25923763] = { vendor=true, name="Guchie Jinglepocket", faction="Alliance", tip=ns.vendorFB },
	[28663820] = ns.setWondervolt,
	[36910742] = { caroling=true, name="Caroling", faction="Horde", achievements={ 	
					{ id=5854, index=4, showAllCriteria=true, guide=ns.caroling, tip="Example safe location" }, }, },
	[41086595] = { reveler=true, name="Brother Wilhelm", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=2, tip="Blacksmith workshop" }, }, },
}

ns.points[ 1429 ] = { -- Elwynn Forest
	[20475698] = { caroling=true, name="Caroling", faction="Horde", version=40300, achievements={
					{ id=5854, index=4, showAllCriteria=true, guide=ns.carolingCata, tip="Example safe location" }, }, },
	[22202290] = { reveler=true, name="Brothers (several)", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, tip="Cathedral area" }, }, },
	[25743752] = { vendor=true, name="Khole Jinglepocket", faction="Alliance", versionUnder=40101, tip=ns.vendor,
					quests={ { id=7023, name="Greatfather Winter Is Here", level=10, qType="Seasonal", }, }, },
	[26033748] = { vendor=true, name="Khole Jinglepocket", faction="Alliance", version=40101, tip=ns.vendor,
					quests={ { id=7023, name="Greatfather Winter Is Here", level=10, qType="Seasonal", }, }, },
	[25833750] = { vendor=true, name="Guchie Jinglepocket", faction="Alliance", versionUnder=40101, tip=ns.vendorFB },
	[25913763] = { vendor=true, name="Guchie Jinglepocket", faction="Alliance", version=40101, tip=ns.vendorFB },
	[28673819] = ns.setWondervoltUnder,
	[28673819] = ns.setWondervoltOver,
	[36910742] = { caroling=true, name="Caroling", faction="Horde", version=40300, achievements={
					{ id=5854, index=4, showAllCriteria=true, guide=ns.carolingCata, tip="Example safe location" }, }, },
	[41086595] = { reveler=true, name="Brother Wilhelm", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=7, tip="Blacksmith workshop" }, }, },
}

ns.points[ 94 ] = { -- Eversong Woods
	[43405640] = { gourmet=true, tip="Dragonhawk mobs", achievements=ns.setGourmetA,
					quests=ns.setTreatsForQ, guide=ns.smallEgg, },
	[44347124] = { caroling=true, name="Caroling", faction="Alliance",
					achievements={ { id=5853, index=2, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingSC3, }, }, },
	[52542968] = { caroling=true, name="Caroling", faction="Alliance",
					achievements={ { id=5853, index=2, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingSC1, }, }, },
	[54504654] = { vendor=true, name="Hotoppik Copperpinch", faction="Horde", tip=ns.vendor },
	[56435164] = ns.setWondervolt,
	[56654980] = { caroling=true, name="Caroling (5)", faction="Alliance",
					achievements={ { id=5853, index=2, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingSC2 }, }, },
	[58005160] = { gourmet=true, tip="Dragonhawk mobs", achievements=ns.setGourmetA,
					quests=ns.setTreatsForQ, guide=ns.smallEgg, },
	[59405160] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=2, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSC13, }, }, },
	[61865339] = { caroling=true, name="Caroling (4)", faction="Alliance",
					achievements={ { id=5853, index=2, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingSC5, }, }, },
	[62076312] = { caroling=true, name="Caroling (3)", faction="Alliance",
					achievements={ { id=5853, index=2, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingSC4, }, }, },
}

ns.points[ 1941 ] = { -- Eversong Woods
	[43405640] = { gourmet=true, tip="Dragonhawk mobs", achievements=ns.setGourmetA,
					quests=ns.setTreatsForQ, guide=ns.smallEgg, },
	[44347124] = { caroling=true, name="Caroling", faction="Alliance", version=40300,
					achievements={ { id=5853, index=4, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingSC3, }, }, },
	[52542968] = { caroling=true, name="Caroling", faction="Alliance", version=40300,
					achievements={ { id=5853, index=4, showAllCriteria=true, guide=ns.carolingCata, tip=ns.carolingSC1, }, }, },
	[54504654] = { vendor=true, name="Hotoppik Copperpinch", faction="Horde", tip=ns.vendor },
	[56435164] = ns.setWondervolt,
	[56654980] = { caroling=true, name="Caroling (5)", faction="Alliance", version=40300,
					achievements={ { id=5853, index=4, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingSC2 }, }, },
	[58005160] = { gourmet=true, tip="Dragonhawk mobs", achievements=ns.setGourmetA,
					quests=ns.setTreatsForQ, guide=ns.smallEgg, },
	[59405160] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=2, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSC13, }, }, },
	[61865339] = { caroling=true, name="Caroling (4)", faction="Alliance", version=40300,
					achievements={ { id=5853, index=4, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingSC5, }, }, },
	[62076312] = { caroling=true, name="Caroling (3)", faction="Alliance", version=40300,
					achievements={ { id=5853, index=4, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingSC4, }, }, },
}

ns.points[ 95 ] = { -- Ghostlands
	[69503080] = { caroling=true, name="Caroling (2)", faction="Alliance",
					achievements={ { id=5853, index=2, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingSC6, }, }, },
	[72606400] = { caroling=true, name="Caroling (1)", faction="Alliance",
					achievements={ { id=5853, index=2, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingSC7, }, }, },
}

ns.points[ 1942 ] = { -- Ghostlands
	[69503080] = { caroling=true, name="Caroling (2)", faction="Alliance", version=40300,
					achievements={ { id=5853, index=4, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingSC6, }, }, },
	[72606400] = { caroling=true, name="Caroling (1)", faction="Alliance", version=40300,
					achievements={ { id=5853, index=4, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingSC7, }, }, },
}

ns.points[ 25 ] = { -- Hillsbrad Foothills
	[42002900] = ns.setHolidaySnow,
	[42344114] = { onMetzen=true, name="Strange Snowman", guide=ns.greench,
					achievements={ { id=273, showAllCriteria=true, }, { id=279, showAllCriteria=true, }, },
					quests={ { id=6983, name="You're a Mean One...", level=30, qType="Daily", faction="Horde", },
						{ id=7043, name="You're a Mean One...", level=30, qType="Daily", faction="Alliance", },
						{ id=6984, name="A Smokywood Pastures' Thank You!", level=10, qType="Seasonal", faction="Horde", },
						{ id=7045, name="A Smokywood Pastures' Thank You!", level=10, qType="Seasonal", faction="Alliance", }, }, },
	[43904090] = { reveler=true, achievements={ { id=1687, showAllCriteria=true, guide=ns.oppositeFaction, }, }, },
	[45003900] = { onMetzen=true, name="Metzen the Reindeer", guide=ns.greench,
					achievements={ { id=273, showAllCriteria=true, }, { id=279, showAllCriteria=true, }, },
					quests={ { id=6983, name="You're a Mean One...", qType="Daily", faction="Horde", },
					{ id=7043, name="You're a Mean One...", qType="Daily", faction="Alliance", },
						{ id=6984, name="A Smokywood Pastures' Thank You!", qType="Seasonal", faction="Horde", },
						{ id=7045, name="A Smokywood Pastures' Thank You!", qType="Seasonal", faction="Alliance", }, }, },
	[47103620] = ns.setHolidaySnow,
	[50002500] = ns.setHolidaySnow,
	[65006800] = { gourmet=true, tip="Rampaging Owlbeast", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
}

ns.points[ 1424 ] = { -- Hillsbrad Foothills
	[42002900] = ns.setHolidaySnow,
	[43904090] = { reveler=true, achievements={ { id=1687, showAllCriteria=true, guide=ns.oppositeFaction, }, }, },
	[45003900] = { onMetzen=true, name="Metzen the Reindeer", guide=ns.greench,
					achievements={ { id=273, showAllCriteria=true, }, { id=279, showAllCriteria=true, }, },
					quests={ { id=6983, name="You're a Mean One...", qType="Daily", faction="Horde", },
					{ id=7043, name="You're a Mean One...", qType="Daily", faction="Alliance", },
						{ id=6984, name="A Smokywood Pastures' Thank You!", qType="Seasonal", faction="Horde", },
						{ id=7045, name="A Smokywood Pastures' Thank You!", qType="Seasonal", faction="Alliance", }, }, },
	[47103620] = ns.setHolidaySnow,
	[50002500] = ns.setHolidaySnow,
	[65006800] = { gourmet=true, tip="Rampaging Owlbeast", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
}

ns.points[ 87 ] = { -- Ironforge
	[12918923] = { bbKing=true, name="BB King (1)", faction="Horde",
					achievements={ { id=4437, index=1, showAllCriteria=true, guide=ns.bbMacroHR, tip=ns.bbMuradin1, }, }, },
	[13139105] = ns.setWondervolt,
	[16128462] = { caroling=true, name="Caroling", faction="Horde",
					achievements={ { id=5854, index=3, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingIF }, }, },
	[24107473] = { bbKing=true, name="BB King (2)", faction="Horde",
					achievements={ { id=4437, index=1, showAllCriteria=true, guide=ns.bbMacroHR, tip=ns.bbMuradin3, }, }, },
	[30255938] = { miscQuests=true, name="Goli Krumn", faction="Alliance",
					quests={ { id=7062, name="The Reason for the Season", level=10, qType="Seasonal", faction="Alliance", }, }, },
	[33216542] = { miscQuests=true, name="Greatfather Winter", faction="Alliance",
					quests={ { id=7025, name="Treats for Great-father Winter", level=10, qType="Seasonal", }, }, },
	[33586794] = { onMetzen=true, name="Wulmort Jinglepocket", faction="Alliance", tip=ns.vendor,
					achievements={ { id=273, showAllCriteria=true, }, { id=279, showAllCriteria=true, }, },
					quests={ { id=7022, name="Greatfather Winter is Here!", level=10, qType="Seasonal", },
					{ id=7043, name="You're a Mean One...", level=30, qType="Daily", },
					{ id=7045, name="A Smokywood Pastures' Thank You!", level=10, qType="Seasonal", }, }, },
	[33656727] = { vendor=true, name="Macey Jinglepocket", faction="Alliance", tip=ns.vendorFB },
	[33956820] = { reveler=true, name="Greatfeather Pepe", faction="Alliance", tip=ns.pepe, buff=316936,
					quests={ { id=58901, name="Greatfeather Pepe", qType="One Time", }, }, },
	[37356678] = { bbKing=true, name="BB King (3)", faction="Horde",
					achievements={ { id=4437, index=1, showAllCriteria=true, guide=ns.bbMacroHR, tip=ns.bbMuradin2, }, }, },
	[39675542] = { bbKing=true, name="BB King (5)", faction="Horde",
					achievements={ { id=4437, index=1, showAllCriteria=true, guide=ns.bbMacroHR, tip=ns.bbMuradin6, }, }, },
	[39165609] = { scroogePvP=true, name="Muradin Bronzebeard", achievements={
					{ id=1255, showAllCriteria=true, faction="Alliance", guide="Muradin is on his throne in Ironforge", }, }, },
	[45324853] = { bbKing=true, name="BB King (4)", faction="Horde",
					achievements={ { id=4437, index=1, showAllCriteria=true, guide=ns.bbMacroHR, tip=ns.bbMuradin4, }, }, },
	[45755272] = { bbKing=true, name="BB King (6)", faction="Horde",
					achievements={ { id=4437, index=1, showAllCriteria=true, guide=ns.bbMacroHR, tip=ns.bbMuradin5, }, }, },
	[77551183] = { miscQuests=true, name="Historian Karnik", faction="Alliance",
					quests={ { id=7063, name="The Feast of Winter Veil", level=10, qType="Seasonal", }, }, },
}

ns.points[ 1455 ] = { -- Ironforge
	[12918923] = { bbKing=true, name="BB King (1)", faction="Horde",
					achievements={ { id=4437, index=2, showAllCriteria=true, guide=ns.bbMacroHC, tip=ns.bbMuradin1, }, }, },
	[13119105] = ns.setWondervolt,
	[16128462] = { caroling=true, name="Caroling", faction="Horde", version=40300,
					achievements={ { id=5854, index=4, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingIF }, }, },
	[24107473] = { bbKing=true, name="BB King (2)", faction="Horde",
					achievements={ { id=4437, index=2, showAllCriteria=true, guide=ns.bbMacroHC, tip=ns.bbMuradin3, }, }, },
	[30255938] = { miscQuests=true, name="Goli Krumn", faction="Alliance",
					quests={ { id=7062, name="The Reason for the Season", level=10, qType="Seasonal", faction="Alliance", }, }, },
	[32806580] = { miscQuests=true, name="Greatfather Winter", faction="Alliance", versionUnder=40101,
					quests={ { id=7025, name="Treats for Great-father Winter", level=10, qType="Seasonal", }, }, },
	[33206542] = { miscQuests=true, name="Greatfather Winter", faction="Alliance", version=40101,
					quests={ { id=7025, name="Treats for Greatfather Winter", level=10, qType="Seasonal", }, }, },
	[33706723] = { onMetzen=true, name="Wulmort Jinglepocket", faction="Alliance", versionUnder=40101, tip=ns.vendor,
					quests={ { id=7022, name="Greatfather Winter is Here!", level=10, qType="Seasonal", },
					{ id=7045, name="A Smokywood Pastures' Thank You!", level=30, qType="Seasonal", },
					{ id=7042, name="Stolen Winter Veil Treats", level=30, qType="Seasonal", },
					{ id=7043, name="You're a Mean One...", level=30, qType="Seasonal", },
					{ id=8762, name="Metzen the Reindeer", level=40, qType="Seasonal", },
					{ id=8763, name="The Hero of the Day", level=40, qType="Seasonal", }, }, },
	[33596793] = { onMetzen=true, name="Wulmort Jinglepocket", faction="Alliance", version=40101, tip=ns.vendor,
					achievements={ { id=273, showAllCriteria=true, }, { id=279, showAllCriteria=true, }, },
					quests={ { id=7022, name="Great-father Winter is Here!", level=10, qType="Seasonal", },
					{ id=7045, name="A Smokywood Pastures' Thank You!", level=30, qType="Seasonal", },
					{ id=7043, name="You're a Mean One...", level=80, qType="Daily", }, }, },					
	[33616769] = { vendor=true, name="Macey Jinglepocket", faction="Alliance", versionUnder=40101, tip=ns.vendorFB },
	[33666727] = { vendor=true, name="Macey Jinglepocket", faction="Alliance", version=40101, tip=ns.vendorFB },
	[37356678] = { bbKing=true, name="BB King (3)", faction="Horde",
					achievements={ { id=4437, index=2, showAllCriteria=true, guide=ns.bbMacroHC, tip=ns.bbMuradin2, }, }, },
	[39675542] = { bbKing=true, name="BB King (5)", faction="Horde",
					achievements={ { id=4437, index=2, showAllCriteria=true, guide=ns.bbMacroHC, tip=ns.bbMuradin6, }, }, },
	[39185611] = { scroogePvP=true, name="Muradin Bronzebeard", achievements={
					{ id=1255, showAllCriteria=true, faction="Alliance", guide="Muradin is on his throne in Ironforge", }, }, },
	[45324853] = { bbKing=true, name="BB King (4)", faction="Horde",
					achievements={ { id=4437, index=2, showAllCriteria=true, guide=ns.bbMacroHC, tip=ns.bbMuradin4, }, }, },
	[45755272] = { bbKing=true, name="BB King (6)", faction="Horde",
					achievements={ { id=4437, index=2, showAllCriteria=true, guide=ns.bbMacroHC, tip=ns.bbMuradin5, }, }, },
	[77551183] = { miscQuests=true, name="Historian Karnik", faction="Alliance", version=40101,
					quests={ { id=7063, name="The Feast of Winter Veil", level=10, qType="Seasonal", }, }, },
	[77601160] = { miscQuests=true, name="Historian Karnik", faction="Alliance", versionUnder=40101,
					quests={ { id=7063, name="The Feast of Winter Veil", level=10, qType="Seasonal", }, }, },
}

ns.points[ 48 ] = { -- Loch Modan
	[17002800] = { gourmet=true, tip="Loch Buzzard", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
	[58005200] = { gourmet=true, tip="Loch Buzzard", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
	[79006700] = { gourmet=true, tip="Golden Eagle", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
}

ns.points[ 1432 ] = { -- Loch Modan
	[17002800] = { gourmet=true, tip="Loch Buzzard", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
	[58005200] = { gourmet=true, tip="Loch Buzzard", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
	[79006700] = { gourmet=true, tip="Golden Eagle", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
}

ns.points[ 50 ] = { -- Northern Stranglethorn
	[47251110] = { reveler=true, name="Brother Nimetz", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=1, }, }, },
}

ns.points[ 50 ] = { -- Redridge Mountains
	[18006400] = { gourmet=true, tip="Dire Condor", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
}

ns.points[ 1433 ] = { -- Redridge Mountains
	[18006400] = { gourmet=true, tip="Dire Condor", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
}

ns.points[ 1427 ] = { -- Searing Gorge
	[68753423] = { onMetzen=true, name="Metzen the Reindeer", versionUnder=40300, guide=ns.greench,
					achievements={ { id=273, showAllCriteria=true, }, { id=279, showAllCriteria=true, }, },
					quests={ { id=8746, name="Metzen the Reindeer", level=40, qType="Seasonal", faction="Horde", },
					{ id=8762, name="Metzen the Reindeer", level=40, qType="Seasonal", faction="Alliance", }, }, },
}

ns.points[ 110 ] = { -- Silvermoon City
	[63647932] = { vendor=true, name="Hotoppik Copperpinch", faction="Horde", tip=ns.vendor },
	[63607900] = { vendor=true, name="Morshelz Copperpinch", faction="Horde", tip=ns.vendorFB },
	[70708900] = { bbKing=true, caroling=true, faction="Alliance", tip=ns.bbSC1, 
					achievements={ { id=5853, index=2, showAllCriteria=true, guide=ns.caroling, }, 
						{ id=4436, index=2, showAllCriteria=true, guide=ns.bbMacroAR, }, }, },
	[53792021] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=2, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSC2, }, }, },
	[74405860] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=2, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSC3, }, }, },
	[69956595] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=2, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSC4, }, }, },
	[73645221] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=2, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSC5, }, }, },
	[59283759] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=2, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSC6, }, }, },
	[72298479] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=2, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSC7, }, }, },
	[72644365] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=2, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSC8, }, }, },
	[61532949] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=2, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSC9, }, }, },
	[50661633] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=2, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSC10, }, }, },
	[54422662] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=2, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSC11, }, }, },
	[72299178] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=2, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSC12, }, }, },
}

ns.points[ 1954 ] = { -- Silvermoon City
	[63647932] = { vendor=true, name="Hotoppik Copperpinch", faction="Horde", tip=ns.vendor },
	[63607900] = { vendor=true, name="Morshelz Copperpinch", faction="Horde", tip=ns.vendorFB },
	[70708900] = { bbKing=true, caroling=true, faction="Alliance", version=40300, tip=ns.bbSC1, 
					achievements={ { id=5853, index=4, showAllCriteria=true, guide=ns.caroling, }, 
						{ id=4436, index=2, showAllCriteria=true, guide=ns.bbMacroAR, }, }, },
	[53792021] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=2, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSC2, }, }, },
	[74405860] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=2, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSC3, }, }, },
	[69956595] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=2, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSC4, }, }, },
	[73645221] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=2, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSC5, }, }, },
	[59283759] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=2, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSC6, }, }, },
	[72298479] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=2, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSC7, }, }, },
	[72644365] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=2, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSC8, }, }, },
	[61532949] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=2, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSC9, }, }, },
	[50661633] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=2, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSC10, }, }, },
	[54422662] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=2, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSC11, }, }, },
	[72299178] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=2, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSC12, }, }, },
}

ns.points[ 84 ] = { -- Stormwind City
	[49514522] = { reveler=true, name="Brother Joshua", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=5, tip=ns.broJoshua }, }, },
	[52104760] = { reveler=true, name="Brother Benjamin", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=8, tip=ns.broBenjamin }, }, },
	[52414580] = { reveler=true, name="Brother Cassius", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=7, tip=ns.broCassius }, }, },
	[52604392] = { reveler=true, name="Brother Crowley", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=6, tip=ns.broCrowley }, }, },
	[55045417] = { reveler=true, name="Brother Kristoff", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=4, tip=ns.broKristoff }, }, },
	[56607040] = { bbKing=true, name="Craggle Wobbletop", faction="Alliance",
					achievements={ { id=4436, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSeller, }, }, },
	[62807005] = { vendor=true, name="Khole Jinglepocket", faction="Alliance", tip=ns.vendor,
					quests={ { id=7023, name="Greatfather Winter Is Here", level=10, qType="Seasonal", }, }, },
	[62577033] = { vendor=true, name="Guchie Jinglepocket", faction="Alliance", tip=ns.vendorFB },
	[65606292] = { bbKing=true, name="Craggle Wobbletop", faction="Alliance",
					achievements={ { id=4436, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSeller, }, }, },
}

ns.points[ 1453 ] = { -- Stormwind City
	[49514522] = { reveler=true, name="Brother Joshua", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=1, tip=ns.broJoshua }, }, },
	[52104760] = { reveler=true, name="Brother Benjamin", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=8, tip=ns.broBenjamin }, }, },
	[52414580] = { reveler=true, name="Brother Cassius", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=6, tip=ns.broCassius }, }, },
	[52604392] = { reveler=true, name="Brother Crowley", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=3, tip=ns.broCrowley }, }, },
	[55045417] = { reveler=true, name="Brother Kristoff", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=4, tip=ns.broKristoff }, }, },
	[56607040] = { bbKing=true, name="Craggle Wobbletop", faction="Alliance",
					achievements={ { id=4436, showAllCriteria=true, guide=ns.bbMacroAC, tip=ns.bbSeller, }, }, },
	[54985905] = { vendor=true, name="Khole Jinglepocket", faction="Alliance", versionUnder=40101, tip=ns.vendor,
					quests={ { id=7023, name="Greatfather Winter Is Here", level=10, qType="Seasonal", }, }, },
	[62807004] = { vendor=true, name="Khole Jinglepocket", faction="Alliance", version=40101, tip=ns.vendor,
					quests={ { id=7023, name="Greatfather Winter Is Here", level=10, qType="Seasonal", }, }, },
	[55195898] = { vendor=true, name="Guchie Jinglepocket", faction="Alliance", versionUnder=40101, tip=ns.vendorFB },
	[62567033] = { vendor=true, name="Guchie Jinglepocket", faction="Alliance", version=40101, tip=ns.vendorFB },
	[65606292] = { bbKing=true, name="Craggle Wobbletop", faction="Alliance",
					achievements={ { id=4436, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSeller, }, }, },
	[62536077] = ns.setWondervoltUnder,
	[68067146] = ns.setWondervoltOver,
	[83002800] = { bbKing=true, name="BB King", faction="Horde",
					achievements={ { id=4437, index=1, showAllCriteria=true, guide=ns.bbMacroHC,
					tip="Dive down into the garden. You will need to deal with guards two at a time", }, }, },
}

ns.points[ 224 ] = { -- Stranglethorn Vale
	[37567622] = ns.setWondervolt,
	[48390814] = { reveler=true, name="Brother Nimetz", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=1, }, }, },
}

ns.points[ 1434 ] = { -- Stranglethorn Vale / Northern Stranglethorn (Cata Classic)
	[26717347] = ns.setWondervoltUnder,
--	[37567622] = ns.setWondervolt,
	[48390814] = { reveler=true, name="Brother Nimetz", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=1, }, }, },
}

ns.points[ 210 ] = { -- The Cape of Stranglethorn
	[40356756] = ns.setWondervolt,
}

ns.points[ 18 ] = { -- Tirisfal Glades
	[60006900] = { reveler=true, name="Brother Malach", showAllCriteria=true, faction="Horde",
					achievements={ { id=1685, index=1, tip="Descend into Undercity" }, }, },
	[61105929] = ns.setWondervolt,
}

ns.points[ 1420 ] = { -- Tirisfal Glades
	[60006900] = { reveler=true, name="Brother Malach", showAllCriteria=true, faction="Horde",
					achievements={ { id=1685, index=1, tip="Descend into Undercity" }, }, },
	[61105929] = ns.setWondervolt,
	[62277325] = { vendor=true, name="Jaycrue Copperpinch", faction="Horde", tip=ns.vendorFB },
	[62297330] = { vendor=true, name="Nardstrum Copperpinch", faction="Horde", tip=ns.vendor,
					quests={ { id=7024, name="Great-father Winter is Here", level=10, qType="Seasonal", }, }, },
}

ns.points[ 90 ] = { -- Undercity
	[15203050] = { caroling=true, faction="Alliance",
					achievements={ { id=5853, index=4, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingUC2 }, }, },
	[23633914] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=1, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC2, }, }, },
	[34713321] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=1, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC3, }, }, },
	[41433733] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=1, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC4, }, }, },
	[45978314] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=1, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC7, }, }, },
	[46722712] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=1, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC1, }, }, },
	[46944393] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=1, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC5, }, }, },
	[50862166] = { reveler=true, name="Brother Malach", showAllCriteria=true, faction="Horde",
					achievements={ { id=1685, index=1, }, }, },
	[52446384] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=1, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC6, }, }, },
	[54539037] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=1, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC8, }, }, },
	[58504390] = { caroling=true, faction="Alliance",
					achievements={ { id=5853, index=4, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingUC1 }, }, },
	[68233886] = { vendor=true, name="Nardstrum Copperpinch", faction="Horde", tip=ns.vendor,
					quests={ { id=7024, name="Great-father Winter is Here", level=10, qType="Seasonal", }, }, },
	[68604000] = { vendor=true, name="Jaycrue Copperpinch", faction="Horde", tip=ns.vendorFB },
}

ns.points[ 1458 ] = { -- Undercity
	[15203050] = { caroling=true, faction="Alliance", version=40300,
					achievements={ { id=5853, index=2, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingUC2 }, }, },
	[23633914] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=3, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC2, }, }, },
	[34713321] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=3, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC3, }, }, },
	[41433333] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=3, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC4, }, }, },
	[45978314] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=3, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC7, }, }, },
	[46722712] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=3, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC1, }, }, },
	[46944393] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=3, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC5, }, }, },
	[50862166] = { reveler=true, name="Brother Malach", showAllCriteria=true, faction="Horde",
					achievements={ { id=1685, index=3, }, }, },
	[52446384] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=3, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC6, }, }, },
	[54539037] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=3, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC8, }, }, },
	[58504390] = { caroling=true, faction="Alliance", version=40300,
					achievements={ { id=5853, index=2, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingUC1 }, }, },
	[68233886] = { vendor=true, name="Nardstrum Copperpinch", faction="Horde", tip=ns.vendor,
					quests={ { id=7024, name="Great-father Winter is Here", level=10, qType="Seasonal", }, }, },
	[68153860] = { vendor=true, name="Jaycrue Copperpinch", faction="Horde", tip=ns.vendorFB },
}

ns.points[ 52 ] = { -- Westfall
	[49003100] = { gourmet=true, tip="Young Fleshripper", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
	[51001920] = { gourmet=true, tip="Young Fleshripper", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
	[62005760] = { gourmet=true, tip="Young Fleshripper", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
}

ns.points[ 1436 ] = { -- Westfall
	[49003100] = { gourmet=true, tip="Young Fleshripper", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
	[51001920] = { gourmet=true, tip="Young Fleshripper", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
	[57604160] = { gourmet=true, tip="Young Fleshripper", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
	[62005760] = { gourmet=true, tip="Young Fleshripper", achievements=ns.setGourmetA, quests=ns.setTreatsForQ,
					guide=ns.smallEgg, },
}

ns.points[ 56 ] = { -- Wetlands
	[09236089] = ns.setWondervolt,
}

ns.points[ 1437 ] = { -- Wetlands
	[09345831] = ns.setWondervolt,
--	[09236089] = ns.setWondervolt,
}

ns.points[ ns.map.easternK ] = { -- Eastern Kingdoms
	[91506320] = ns.setWearTravel,
	[91506750] = ns.setMeta,
	[93707030] = ns.setReveler,
	[94006600] = ns.setFlavour,
	[94206200] = ns.setEnemies,
	[96306900] = ns.setRacers,
	[96606480] = ns.setScroogePvP,
}

--==================================================================================================================================
--
-- THE BURNING CRUSADE / OUTLAND
--
--==================================================================================================================================

ns.points[ 105 ] = { -- Blade's Edge Mountains
	[28765737] = { reveler=true, name="Quest Hub", achievements={ { id=1282, guide=ns.falala, }, },
					quests={ { id=11025, name="The Crystals", level=20, qType="One Time", },
						{ id=11030, name="Our Boy Wants To Be A Skyguard Ranger", level=20, qType="One Time", },
						{ id=11062, name="The Skyguard Outpost", level=20, qType="One Time", },
						{ id=11010, name="Bombing Run", level=20, qType="One Time", },
						{ id=11102, name="Bombing Run", level=20, qType="One Time", class="Druid", },
						{ id=11023, name="Bomb Them Again!", level=20, qType="Daily", }, }, },
	[34404140] = { reveler=true, name="Bombing Run Area", achievements={ { id=1282, tip="You do the bombing runs here" }, }, },
}

ns.points[ 1949 ] = { -- Blade's Edge Mountains
	[28765737] = { reveler=true, name="Quest Hub", achievements={ { id=1282, guide=ns.falala, }, }, },
	[34404140] = { reveler=true, name="Bombing Run Area", achievements={ { id=1282, tip="You do the bombing runs here" }, }, },
}

ns.points[ 111 ] = { -- Shattrath City
	[51262966] = { vendor=true, name="Eebee Jinglepocket", tip=ns.vendor },
	[60605720] = { vendor=true, name="Olnayvi Copperpinch", tip=ns.vendorFB },
}

ns.points[ ns.map.outland ] = { -- Outland
	[91506320] = ns.setWearTravel,
	[91506750] = ns.setMeta,
	[93707030] = ns.setReveler,
	[94006600] = ns.setFlavour,
	[94206200] = ns.setEnemies,
	[96306900] = ns.setRacers,
	[96606480] = ns.setScroogePvP,
}

--==================================================================================================================================
--
-- WRATH OF THE LICH KING / NORTHREND
--
--==================================================================================================================================

ns.points[ 114 ] = { -- Borean Tundra
	[40205500] = { reveler=true, name="Durkot Wolfbrother", showAllCriteria=true, faction="Horde",
					achievements={ { id=1685, index=2, tip=ns.broDurkot }, }, },
	[31003000] = { onMetzen=true, name="'Tis the Season", noCoords=true,
					achievements={ { id=277, showAllCriteria=true, guide=ns.threeSet, tip=ns.threeSetNexus, }, }, },
}

ns.points[ 127 ] = { -- Crystalsong Forest
	[29404275] = { onMetzen=true, quests=ns.stolenDailySet, 
					achievements={ { id=1690, showAllCriteria=true, guide=ns.frostyShake, }, }, },
	[29603808] = ns.setWondervolt, 
	[31693840] = { reveler=true, achievements={ { id=1687, showAllCriteria=true, guide=ns.oppositeFaction, }, }, },
}

ns.points[ 125 ] = { -- Dalaran
	[48406630] = { onMetzen=true, quests=ns.stolenDailySet, 
					achievements={ { id=1690, showAllCriteria=true, guide=ns.frostyShake, }, }, },
	[49394373] = ns.setWondervolt,
	[59504530] = { reveler=true, achievements={ { id=1687, showAllCriteria=true, guide=ns.oppositeFaction, }, }, },
}

ns.points[ 118 ] = { -- Icecrown
	[69404240] = { reveler=true, name="Brother Keltan", showAllCriteria=true, version=60000, faction="Horde",
					achievements={ { id=1685, index=3, tip=ns.broKeltan }, }, },
	[76558851] = { onMetzen=true, quests=ns.stolenDailySet, 
					achievements={ { id=1690, showAllCriteria=true, guide=ns.frostyShake, }, }, },
	[76648648] = ns.setWondervolt,
	[77558662] = { reveler=true, achievements={ { id=1687, showAllCriteria=true, guide=ns.oppositeFaction, }, }, },
}

ns.points[ 129 ] = { -- The Nexus
	[27503420] = { onMetzen=true, name="Grand Magus Telestra", noCoords=true,
					achievements={ { id=277, showAllCriteria=true, tip="Must be Heroic!", }, }, },
	[31507440] = { onMetzen=true, name="Grand Magus Telestra", noCoords=true,
					achievements={ { id=277, showAllCriteria=true, tip="Must be Heroic!", }, }, },
}

ns.points[ 143 ] = { -- The Oculus
	[63004200] = { onMetzen=true, name="Mage-Lord Urom", noCoords=true, achievements={ { id=277, showAllCriteria=true,
					tip="The 3rd boss. Must be Heroic!", }, }, },
}

ns.points[ 120 ] = { -- The Storm Peaks
	[16859430] = { onMetzen=true, quests=ns.stolenDailySet, 
					achievements={ { id=1690, showAllCriteria=true, guide=ns.frostyShake, }, }, },
	[16939252] = ns.setWondervolt,
	[17739264] = { reveler=true, achievements={ { id=1687, showAllCriteria=true, guide=ns.oppositeFaction, }, }, },
}

ns.points[ 113 ] = { -- Northrend
	[91506320] = ns.setWearTravel,
	[91506750] = ns.setMeta,
	[93707030] = ns.setReveler,
	[94006600] = ns.setFlavour,
	[94206200] = ns.setEnemies,
	[96306900] = ns.setRacers,
	[96606480] = ns.setScroogePvP,
}

--==================================================================================================================================
--
-- MISTS OF PANDARIA
--
--==================================================================================================================================

ns.points[ 424 ] = { -- Pandaria
	[91506320] = ns.setWearTravel,
	[91506750] = ns.setMeta,
	[93707030] = ns.setReveler,
	[94006600] = ns.setFlavour,
	[94206200] = ns.setEnemies,
	[96306900] = ns.setRacers,
	[96606480] = ns.setScroogePvP,
}

--==================================================================================================================================
--
-- WARLORDS OF DRAENOR / GARRISON
--
--==================================================================================================================================

ns.points[ 525 ] = { -- Frostfire Ridge
	[46202750] = { miscQuests=true, name="Daily Hub", guide=ns.garrison,
					quests={ { id=39649, name="Menacing Grumplings", level=40, qType="Daily", },
						{ id=39668, name="What Horrible Presents!", level=40, qType="Daily", },
						{ id=39648, name="Where Are the Children?", level=40, qType="Daily", },
						{ id=39651, name="Grumpus", level=40, qType="Daily", }, },
					tip="The Snow Mounds in this area have a 5% chance of a Grumpling pet!", },
	[48286469] = { miscQuests=true, name="Pizzle", guide=ns.garrison, faction="Horde",
					quests={ { id=39649, name="Menacing Grumplings", level=40, qType="Daily", },
						{ id=39668, name="What Horrible Presents!", level=40, qType="Daily", },
						{ id=39648, name="Where Are the Children?", level=40, qType="Daily", },
						{ id=39651, name="Grumpus", level=40, qType="Daily", }, }, },
	[48306477] = { armada=true, name="Izzy Hollyfizzle", faction="Horde", version=60202,
					achievements={ { id=10353, showAllCriteria=true, guide=ns.armada, }, }, },
	[48636413] = { vendor=true, name="Ashanem Jinglepocket", faction="Horde", tip=ns.vendorFB ..ns.vendorL3Garr },
	[48706412] = { vendor=true, name="Tradurjo Jinglepocket", faction="Horde", tip=ns.vendor ..ns.vendorL3Garr,
					quests={ { id=7023, name="Greatfather Winter Is Here", level=10, qType="Seasonal", }, }, },
}

ns.points[ 590 ] = { -- Frostwall Garrison
	[47193776] = { miscQuests=true, name="Pizzle", guide=ns.garrison, faction="Horde",
					quests={ { id=39649, name="Menacing Grumplings", level=40, qType="Daily", },
						{ id=39668, name="What Horrible Presents!", level=40, qType="Daily", },
						{ id=39648, name="Where Are the Children?", level=40, qType="Daily", },
						{ id=39651, name="Grumpus", level=40, qType="Daily", }, }, },
	[47353844] = { armada=true, name="Izzy Hollyfizzle", faction="Horde", version=60202,
					achievements={ { id=10353, showAllCriteria=true, guide=ns.armada, }, }, },
	[50273293] = { vendor=true, name="Ashanem Jinglepocket", faction="Horde", tip=ns.vendorFB ..ns.vendorL3Garr },
	[50823285] = { vendor=true, name="Tradurjo Jinglepocket", faction="Horde", tip=ns.vendor ..ns.vendorL3Garr,
					quests={ { id=7023, name="Greatfather Winter Is Here", level=10, qType="Seasonal", }, }, },
}

ns.points[ 543 ] = { -- Gorgrond
	[06267254] = { miscQuests=true, name="Pizzle", guide=ns.garrison, faction="Horde",
					quests={ { id=39649, name="Menacing Grumplings", level=40, qType="Daily", },
						{ id=39668, name="What Horrible Presents!", level=40, qType="Daily", },
						{ id=39648, name="Where Are the Children?", level=40, qType="Daily", },
						{ id=39651, name="Grumpus", level=40, qType="Daily", }, }, },
	[06287257] = { armada=true, name="Izzy Hollyfizzle", faction="Horde", version=60202,
					achievements={ { id=10353, showAllCriteria=true, guide=ns.armada, }, }, },
}

ns.points[ 582 ] = { -- Lunarfall Garrison
	[41864776] = { vendor=true, name="Tradurjo Jinglepocket", faction="Alliance", tip=ns.vendor ..ns.vendorL3Garr,
					quests={ { id=7023, name="Greatfather Winter Is Here", level=10, qType="Seasonal", }, }, },
	[42354729] = { vendor=true, name="Ashanem Jinglepocket", faction="Alliance", tip=ns.vendorFB ..ns.vendorL3Garr },
	[43985143] = { miscQuests=true, name="Almie", guide=ns.garrison, faction="Alliance",
					quests={ { id=39649, name="Menacing Grumplings", level=40, qType="Daily", },
						{ id=39668, name="What Horrible Presents!", level=40, qType="Daily", },
						{ id=39648, name="Where Are the Children?", level=40, qType="Daily", },
						{ id=39651, name="Grumpus", level=40, qType="Daily", }, }, },
	[44295102] = { armada=true, name="Izzy Hollyfizzle", version=60202, faction="Alliance",
					achievements={ { id=10353, showAllCriteria=true, guide=ns.armada, }, }, },
}

ns.points[ 539 ] = { -- Shadowmoon Valley in Draenor
	[29981761] = { vendor=true, name="Tradurjo Jinglepocket", faction="Alliance", tip=ns.vendor ..ns.vendorL3Garr,
					quests={ { id=7023, name="Greatfather Winter Is Here", level=10, qType="Seasonal", }, }, },
	[30031756] = { vendor=true, name="Ashanem Jinglepocket", faction="Alliance", tip=ns.vendorFB ..ns.vendorL3Garr },
	[30201799] = { miscQuests=true, name="Almie", guide=ns.garrison, faction="Alliance",
					quests={ { id=39649, name="Menacing Grumplings", level=40, qType="Daily", },
						{ id=39668, name="What Horrible Presents!", level=40, qType="Daily", },
						{ id=39648, name="Where Are the Children?", level=40, qType="Daily", },
						{ id=39651, name="Grumpus", level=40, qType="Daily", }, }, },
	[30231794] = { armada=true, name="Izzy Hollyfizzle", version=60202, faction="Alliance",
					achievements={ { id=10353, showAllCriteria=true, guide=ns.armada, }, }, },
}

ns.points[ 535 ] = { -- Talador
	[93726470] = { miscQuests=true, name="Almie", guide=ns.garrison, faction="Alliance",
					quests={ { id=39649, name="Menacing Grumplings", level=40, qType="Daily", },
						{ id=39668, name="What Horrible Presents!", level=40, qType="Daily", },
						{ id=39648, name="Where Are the Children?", level=40, qType="Daily", },
						{ id=39651, name="Grumpus", level=40, qType="Daily", }, }, },
	[93766466] = { armada=true, name="Izzy Hollyfizzle", version=60202, faction="Alliance",
					achievements={ { id=10353, showAllCriteria=true, guide=ns.armada, }, }, },
}

ns.points[ 534 ] = { -- Tanaan Jungle
	[80375685] = { armada=true, name="Gondar", version=60202,
					achievements={ { id=10353, index=4, guide=ns.armada, tip=ns.tanaanSpawns }, }, },
	[83454366] = { armada=true, name="Drakum", version=60202,
					achievements={ { id=10353, index=5, guide=ns.armada, tip=ns.tanaanSpawns }, }, },
	[88135583] = { armada=true, name="Smashum Grabb", version=60202,
					achievements={ { id=10353, index=3, guide=ns.armada, tip=ns.tanaanSpawns }, }, },
}

ns.points[ 572 ] = { -- Draenor
	[91506320] = ns.setWearTravel,
	[91506750] = ns.setMeta,
	[93707030] = ns.setReveler,
	[94006600] = ns.setFlavour,
	[94206200] = ns.setEnemies,
	[96306900] = ns.setRacers,
	[96606480] = ns.setScroogePvP,
}

--==================================================================================================================================
--
-- LEGION / BROKEN ISLES
--
--==================================================================================================================================

ns.points[ 619 ] = { -- Broken Isles
	[91506320] = ns.setWearTravel,
	[91506750] = ns.setMeta,
	[93707030] = ns.setReveler,
	[94006600] = ns.setFlavour,
	[94206200] = ns.setEnemies,
	[96306900] = ns.setRacers,
	[96606480] = ns.setScroogePvP,
}

--==================================================================================================================================
--
-- BATTLE FOR AZEROTH / KUL TIRAS & ZANDALAR
--
--==================================================================================================================================

ns.points[ 876 ] = { -- Kul Tiras
	[91506320] = ns.setWearTravel,
	[91506750] = ns.setMeta,
	[93707030] = ns.setReveler,
	[94006600] = ns.setFlavour,
	[94206200] = ns.setEnemies,
	[96306900] = ns.setRacers,
	[96606480] = ns.setScroogePvP,
}

ns.points[ 875 ] = { -- Zandalar
	[91506320] = ns.setWearTravel,
	[91506750] = ns.setMeta,
	[93707030] = ns.setReveler,
	[94006600] = ns.setFlavour,
	[94206200] = ns.setEnemies,
	[96306900] = ns.setRacers,
	[96606480] = ns.setScroogePvP,
}

--==================================================================================================================================
--
-- SHADOWLANDS
--
--==================================================================================================================================

ns.points[ 1550 ] = { -- Shadowlands
	[91506320] = ns.setWearTravel,
	[91506750] = ns.setMeta,
	[93707030] = ns.setReveler,
	[94006600] = ns.setFlavour,
	[94206200] = ns.setEnemies,
	[96306900] = ns.setRacers,
	[96606480] = ns.setScroogePvP,
}

--==================================================================================================================================
--
-- DRAGONFLIGHT / DRAGON ISLES
--
--==================================================================================================================================

ns.points[ 2112 ] = { -- Valdrakken
	[50005400] = { reveler=true, achievements={ { id=1687, showAllCriteria=true, guide=ns.oppositeFaction, }, }, },
}

ns.points[ 1978 ] = { -- Dragon Isles
	[91506320] = ns.setWearTravel,
	[91506750] = ns.setMeta,
	[93707030] = ns.setReveler,
	[94006600] = ns.setFlavour,
	[94206200] = ns.setEnemies,
	[96306900] = ns.setRacers,
	[96606480] = ns.setScroogePvP,
}

--==================================================================================================================================
--
-- THE WAR WITHIN / KHAZ ALGAR
--
--==================================================================================================================================

ns.points[ 2339 ] = { -- Dornogal City
	[50005400] = { reveler=true, achievements={ { id=1687, showAllCriteria=true, guide=ns.oppositeFaction, }, }, },
}

ns.points[ 2274 ] = { -- Khaz Algar
	[91506320] = ns.setWearTravel,
	[91506750] = ns.setMeta,
	[93707030] = ns.setReveler,
	[94006600] = ns.setFlavour,
	[94206200] = ns.setEnemies,
	[96306900] = ns.setRacers,
	[96606480] = ns.setScroogePvP,
}

--==================================================================================================================================
--
-- WORLD / OTHER
--
--==================================================================================================================================

ns.points[ 946 ] = { -- Cosmic
	[45704570] = { wondervolt=true, name="Orgrimmar", showAnyway=true, faction="Horde", tip=ns.yourHub },
	[58305160] = { wondervolt=true, name="Ironforge", showAnyway=true, faction="Alliance", tip=ns.yourHub },
	[79005150] = { miscQuests=true, name="Daily Hub", guide=ns.garrison,
					quests={ { id=39649, name="Menacing Grumplings", level=40, qType="Daily", },
						{ id=39668, name="What Horrible Presents!", level=40, qType="Daily", },
						{ id=39648, name="Where Are the Children?", level=40, qType="Daily", },
						{ id=39651, name="Grumpus", level=40, qType="Daily", }, },
					tip="Pickup the dailies from your level 3 Garrison", },
	[89805850] = { armada=true, name="Gondar, Drakum, Smashum Grab", version=60202,
					achievements={ { id=10353, showAllCriteria=true, guide=ns.armada, tip=ns.tanaanSpawns }, }, },
}

ns.points[ 947 ] = { -- Azeroth
}

--==================================================================================================================================
--
-- TEXTURES
--
--==================================================================================================================================

ns.textures[21] = "Interface\\AddOns\\HandyNotes_WinterVeil\\BlueRibbonBox"
ns.textures[22] = "Interface\\AddOns\\HandyNotes_WinterVeil\\GreenRibbonBox"
ns.textures[23] = "Interface\\AddOns\\HandyNotes_WinterVeil\\PinkRibbonBox"
ns.textures[24] = "Interface\\AddOns\\HandyNotes_WinterVeil\\PurpleRibbonBox"
ns.textures[25] = "Interface\\AddOns\\HandyNotes_WinterVeil\\RedRibbonBox"
ns.textures[26] = "Interface\\AddOns\\HandyNotes_WinterVeil\\TurquoiseRibbonBox"
ns.textures[31] = "Interface\\AddOns\\HandyNotes_WinterVeil\\BlueSantaHat"
ns.textures[32] = "Interface\\AddOns\\HandyNotes_WinterVeil\\GreenSantaHat"
ns.textures[33] = "Interface\\AddOns\\HandyNotes_WinterVeil\\PinkSantaHat"
ns.textures[34] = "Interface\\AddOns\\HandyNotes_WinterVeil\\RedSantaHat"
ns.textures[35] = "Interface\\AddOns\\HandyNotes_WinterVeil\\YellowSantaHat"
ns.textures[41] = "Interface\\AddOns\\HandyNotes_WinterVeil\\CandyCane"
ns.textures[42] = "Interface\\AddOns\\HandyNotes_WinterVeil\\GingerBread"
ns.textures[43] = "Interface\\AddOns\\HandyNotes_WinterVeil\\Holly"

ns.scaling[21] = 0.432
ns.scaling[22] = 0.432
ns.scaling[23] = 0.432
ns.scaling[24] = 0.432
ns.scaling[25] = 0.432
ns.scaling[26] = 0.432
ns.scaling[31] = 0.432
ns.scaling[32] = 0.432
ns.scaling[33] = 0.432
ns.scaling[34] = 0.432
ns.scaling[35] = 0.432
ns.scaling[41] = 0.432
ns.scaling[42] = 0.432
ns.scaling[43] = 0.432
