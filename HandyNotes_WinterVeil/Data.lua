local _, ns = ...
local points = ns.points
local textures = ns.textures
local scaling = ns.scaling

ns.armada = "\"Flamer\": Do the \"You're a mean one...\" daily and then check your stolen present each time.\n\n\"Killdozer\": You "
			.."need a level 3 Garrison. Complete the Winter Veil dailies for tokens, five of which allows you to purchase from "
			.."Izzy.\n\n\"Mortar\": Dropped by Smashum Grabb, a rare elite in Tanaan Jungle. Can drop all year so no stress.\n\n"
			.."\"Cannon\": Dropped by Gondar, a rare elite in Tanaan Jungle. Can drop all year so no stress.\n\n\"Roller\": "
			.."Dropped by Drakum, a rare elite in Tanaan Jungle. Can drop all year so no stress.\n\n(I've marked the Tanaan mob "
			.."locations. Be patient, drop rates are 10%. This pin marks your progress)"
ns.baine = "Baine is in his large teepee at Thunderbluff"
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

ns.blizzPoetry = "'Twas the feast of Great-Winter\nAnd all through the land\nAll the races were running\n"
			.."With snowballs in hand.\nThe cooks were all frantic\nAnd for those \"in the know\"\n"
			.."Swoops and owls were crashing\nLike new-fallen snow.\n\nCookies and eggnog\n"
			.."Were consumed by all\nAs the snowballs flew freely\nAnd drunks smashed into walls.\n\n"
			.."May your feast of Great-Winter\nBe one merry and bright\nAnd from all here at Blizzard\n"
			.."We wish you a fun night!\n\n(From the original holiday description!)"

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

ns.falala = "Go here and speak to Chu'a'lor. Complete \"The Crystals\" then talk to Torkus and complete \"Our Boy wants...\" then "
			.."go to Chu'a'lor and complete \"The Skyguard Outpost\" then talk to Sky Commander Keller -> Vanderlip and complete "
			.."\"Bombing Run\". Only now is the daily \"Bomb Them Again\" available. Use your Fresh/Preserved Holly now!"
ns.gourmet = "Wulmort and Macey in IF and Penney and Kaymard in Org have most of what you need, except:\n\n"
				.."Small Egg:" .." By far the best place to farm is the dragonhawks "
				.."just outside Silvermoon. The most accessible for Alliance are the barn owls along the western edge of "
				.."Duskwood.\n\n" .."Ice Cold Milk:" .." The nearby inn sells it.\n\n"
				.."Note the vanilla cooking level requirements for the recipes!"
ns.snowballs = "Snow Balls are simply purchasable from Smokywood Pastures vendors but the Holiday Snow mounds in the Alterac "
			.."Mountains / Hillsbrad Foothills (SoD/Retail), Dun Morogh (R) and Winterspring (R) will contain 3 to 6 Snowballs. "
			.."\n\nWhile doing your Level 3 Garrison dailies in Frostfire Ridge, the Snow Mounds will give a snowball 50% of the "
			.."time but the main reason for farming is the 5% chance of a cool Grumpling pet (#10 P/B)"
ns.frostyShake = "Important!!! The Winter Veil Disguise Kit is mailed to you 24 hours after you complete this small quest chain. "
			.."Give yourself enough time as the achievement must be completed while the event is ongoing.\n\n"
			.."No dance partner? No problem. All you need is two characters in Dalaran as follows:\n\n(1) Create TWO game "
			.."clients on your computer. The MOST important step. Do this by twice launching the game through Battlenet.\n\n(2) On "
			.."both clients position your characters in Dalaran. Notice that you eventually get logged out when you switch "
			.."clients. That's the key: It's not instant. Ignore any message from Blizzard.\n\n(3) Let's start. We need to be "
			.."smooth here. Quickly select the other game client. With your character you must select the other character and "
			.."/dance. Quickly as it will disappear soon! Congratulations!\n\n(4) Rinse and repeat for the second character."
			.."\n\n" ..ns.snowballs
ns.garrison = "The quests are clustered just south-west of the Bloodmaul Slag Mines dungeon in Frostfire Ridge. Grumpus will be "
			.."tough to solo.\n\nThe point of the dailies is to gain currency to then decorate your Garrison, which must be at "
			.."level 3 to even see the quest givers. Careful: Applying the Winter Veil decorations will cancel some of your "
			.."Hallow's End decorations.\n\nThe reward currency may also be used to purchase a Savage Gift, which has a 3% chance "
			.."to contain the coveted Minion of Grumpus ground mount! It can be traded on the AH.\n\nThere's a 14% chance to "
			.."obtain a Medallion of the Legion. It rewards 1000 across Draenor reputations"
ns.letItSnow = "You obtain the Snowflakes randomly by /kiss Winter Revellers in town and city Inns!"
ns.magentaPortal = "Fly into the magenta portal fast and then press the space bar / \"up\" key immediately to go straight up. This "
			.."is especially important as the guards are very agressive"
ns.owlbeast = ". While the drop rate here is barely 60%, the mobs are plentiful and with fast respawns!"
ns.pepe = "\n\nLook at the cart that's behind the vendors/quest givers. Perched on one end is Greatfather Pepe. Click on Pepe!"
ns.smallEgg = "Good Small Egg drop rate. Dragonhawk mobs in Eversong Woods have 100% drop rate. Numerous other mobs have >= 60% "
			.."drop rate. Look for this icon across all of Kalimdor / Eastern Kingdoms"
ns.tanaanSpawns = "Spawns here. Every 5 to 10 minutes but is farmable once per day. Drop rate is about 10%"
ns.teldrassil = "Why not use the Darkshore (before \"Teldrassil fire\" phase) to Rut'theran Village boat! Flying is possible too. "
			.."Make sure you choose a short fatigue path. At Rut'theran another boat takes you to Azuremyst Isle or a magenta "
			.."portal will transport you to the top of the world tree into Darnassus"
ns.threeSet = "Strictly must be the \"Winter Garb\" set, no other similarly named gear will do. The hat and chest/clothes may be "
			.."red or green. You are ready once you have the \"set bonus\".\n\n"
			.."Red Hat:" .." Easiest is Grand Magus Telestra in The Nexus dungeon in Coldarra, "
			.."Borean Tundra, Northrend. Bottom entrance. Must be Heroic. Turn left after entering. It's the second boss fight.\n\n"
			.."Green Hat:" .." Easiest is Mage-Lord Urom, the 3rd boss in heroic The Oculus. "
			.."The entrance is above The Nexus. Don't timewalk either dungeon.\n\n"
			.."Red/Green Winter Clothes & Winter Boots:" .." Use the AH or hire a tailor.\n\n"
			.."Tailoring Patterns:" .." Any capital city vendor, your level 3 Garrison or "
			.."Eebee Jinglepocket at The Aldor Bank in Shattrath for the boots. Alliance cities or your level 3 garrison for Red "
			.."Clothes. Eebee or Horde cities for the Green Clothes.\n\n"
			.."Graccu's Fruitcake: Any Smokywood Pastures food and beverage vendor"
ns.threeSetNexus = "Don't forget to set \"Heroic\". You need both The Nexus and The Oculus"
ns.vendor = "Will happily sell you a snowball, a Winter Veil Chorus Book, patterns, recipes, spices, spirits and wrapping "
			.."paper! Time is money friend!"
ns.vendorFB = "Seller of Winter Veil food and beverages"
ns.vendorL3Garr = ".\n\nYou must have a level 3 garrison"
ns.withHelper = "Get the buff here. Then queue for the Isle of Conquest BG. Man a cannon. Quick and easy way for PvEers!\n\n"
			.."Another devious way: Enter the AV BG as a healer. Spam heals. You'll get their HKs"
ns.yourHub = "Your Feast of Winter Veil hub!"

-- ---------------------------------------------------------------------------------------------------------------------------------

ns.setBlizzPoetry = { special=true, name="The Feast of Great-Winter", faction=ns.faction, noCoords=true, noContinent=true,
			tip=ns.blizzPoetry }
ns.setHolidaySnow = { armada=true, name="Holiday Snow", achievements={ { id=1690, showAllCriteria=true, guide=ns.frostyShake, },
			{ id=259, showAllCriteria=true, faction="Horde", guide=ns.baine, },
			{ id=1255, showAllCriteria=true, faction="Alliance", guide="Muradin is on his throne in Ironforge", }, }, }
ns.setIronArmada = { armada=true, name="Iron Armada", faction=ns.faction, noCoords=true, version=60202, noContinent=true,
					achievements={ { id=10353, showAllCriteria=true, guide=ns.armada, }, }, }
ns.setSantaTreatsQ = { { id=7025, name="Treats for Great-father Winter", qType="Seasonal", faction="Alliance", },
						{ id=6962, name="Treats for Great-father Winter", qType="Seasonal", faction="Horde", }, }
ns.setSantaTreatsA = { { id=1688, showAllCriteria=true, guide=ns.gourmet, }, }
ns.setTisSeason = { tisSeason=true, name="'Tis the Season", faction=ns.faction, noCoords=true, noContinent=true,
				achievements={ { id=277, showAllCriteria=true, guide=ns.threeSet, }, }, }
ns.setWondervolt = { wondervolt=true, name="PX-238 Winter Wondervolt", showAnyway=true,
			achievements={ { id=252, guide=ns.withHelper, } }, }
ns.setWondervoltOver = { wondervolt=true, name="PX-238 Winter Wondervolt", showAnyway=true, version=40101,
			achievements={ { id=252, guide=ns.withHelper, } }, }
ns.setWondervoltUnder = { wondervolt=true, name="PX-238 Winter Wondervolt", showAnyway=true, versionUnder=40101,
			achievements={ { id=252, guide=ns.withHelper, } }, }
ns.setGourmet = { gourmet=true, name="The Winter Veil Gourmet", faction=ns.faction, noCoords=true, noContinent=true,
			achievements=ns.setSantaTreatsA, }
				
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

--==================================================================================================================================
--
-- KALIMDOR
--
--==================================================================================================================================

points[ 76 ] = { -- Azshara
	[46007800] = { gourmet=true, name="Static-Charged Hippogryph", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
	[48001700] = { gourmet=true, name="Thunderhead Hippogryph", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
}

points[ 1447 ] = { -- Azshara
	[46007800] = { gourmet=true, name="Static-Charged Hippogryph", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
	[48001700] = { gourmet=true, name="Thunderhead Hippogryph", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
}

points[ 97 ] = { -- Azuremyst Isle
	[14008300] = { gourmet=true, name="Owlbeast mobs", achievements=ns.setSantaTreatsA,
					quests=ns.setSantaTreatsQ, tip=ns.smallEgg ..ns.owlbeast, },
	[24674933] = { bbKing=true, caroling=true, name="The Exodar Side Entrance", faction="Horde",
					achievements={ { id=4437, index=2, showAllCriteria=true, guide=ns.bbMacroHR,
					tip="Look at The Exodar map before you go too far inside", },
					{ id=5854, index=2, showAllCriteria=true, guide=ns.caroling,
						tip="No need to go very far inside The Exodar. No guards in this section", }, },
					tip="Enter The Exodar through the side entrance", },
	[28404273] = { vendor=true, name="Wolgren Jinglepocket", faction="Alliance", tip=ns.vendor },
	[34634441] = ns.setWondervolt,
	[40002300] = { gourmet=true, name="Timberstrider mobs", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
	[53006100] = { gourmet=true, name="Timberstrider mobs", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
}

points[ 1943 ] = { -- Azuremyst Isle
	[14008300] = { gourmet=true, name="Owlbeast mobs", achievements=ns.setSantaTreatsA,
					quests=ns.setSantaTreatsQ, tip=ns.smallEgg ..ns.owlbeast, },
	[24674933] = { bbKing=true, caroling=true, name="The Exodar Side Entrance", faction="Horde",
					achievements={ { id=4437, index=4, showAllCriteria=true, guide=ns.bbMacroHC,
					tip="Look at The Exodar map before you go too far inside", },
					{ id=5854, index=3, showAllCriteria=true, guide=ns.carolingCata,
						tip="No need to go very far inside The Exodar. No guards in this section", }, },
					tip="Enter The Exodar through the side entrance", },
	[28404273] = { vendor=true, name="Wolgren Jinglepocket", faction="Alliance", tip=ns.vendor },
	[34634441] = ns.setWondervolt,
	[40002300] = { gourmet=true, name="Timberstrider mobs", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
	[53006100] = { gourmet=true, name="Timberstrider mobs", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
}

points[ 62 ] = { -- Darkshore
	[43605290] = { gourmet=true, name="Moonkin mobs", achievements=ns.setSantaTreatsA,
					quests=ns.setSantaTreatsQ, tip=ns.smallEgg .."\n(Early Zidormi phase)", },
	[44604540] = { gourmet=true, name="Moonkin mobs", achievements=ns.setSantaTreatsA,
					quests=ns.setSantaTreatsQ, tip=ns.smallEgg .."\n(Early Zidormi phase)", },
}

points[ 1439 ] = { -- Darkshore
	[43605290] = { gourmet=true, name="Moonkin mobs", achievements=ns.setSantaTreatsA,
					quests=ns.setSantaTreatsQ, tip=ns.smallEgg .."\n(Early Zidormi phase)", },
	[44604540] = { gourmet=true, name="Moonkin mobs", achievements=ns.setSantaTreatsA,
					quests=ns.setSantaTreatsQ, tip=ns.smallEgg .."\n(Early Zidormi phase)", },
}

points[ 89 ] = { -- Darnassus	
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
	[87004500] = ns.setIronArmada,
	[89004000] = ns.setGourmet,
	[87003700] = ns.setTisSeason,
	[87004100] = ns.setBlizzPoetry,
}

points[ 1457 ] = { -- Darnassus
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
	[81005800] = ns.setIronArmada,
	[83005300] = ns.setGourmet,
	[81005000] = ns.setTisSeason,
	[81005400] = ns.setBlizzPoetry,
}

points[ 1 ] = { -- Durotar
	[44000210] = ns.setWondervolt,
	[46480610] = { onMetzen=true, name="Kaymard Copperpinch", faction="Horde", tip=ns.vendorFB,
					achievements={ { id=273, showAllCriteria=true, }, { id=279, showAllCriteria=true, }, },
					quests={ { id=6961, name="Great-father Winter is Here!", level=10, qType="Seasonal", },
						{ id=6983, name="You're a Mean One...", level=80, qType="Daily", },
						{ id=6984, name="A Smokywood Pastures' Thank You!", level=30, qType="Seasonal", },
						{ id=8799, name="The Hero of the Day", level=40, qType="Seasonal", }, }, },
	[46530618] = { vendor=true, name="Penney Copperpinch", tip=ns.vendor },
}

points[ 1411 ] = { -- Durotar
	[45730120] = ns.setWondervoltOver,
	[50031351] = ns.setWondervoltUnder,
	[45530641] = { miscQuests=true, name="Greatfather Winter", faction="Horde", version=40101, 
					quests={ { id=6962, name="Treats for Great-father Winter", level=10, qType="Seasonal", }, }, },
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

points[ 70 ] = { -- Dustwallow Marsh
	[67404720] = { bromance=true, name="Brother Karman", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=3, tip="Old Theramore" }, }, },
}

points[ 1445 ] = { -- Dustwallow Marsh
	[67404720] = { bromance=true, name="Brother Karman", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=5, tip="Old Theramore" }, }, },
}

points[ 7 ] = { -- Mulgore
	[42003400] = { caroling=true, faction="Alliance",
					achievements={ { id=5853, index=3, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingTB }, }, },
	[42512865] = { armada=true, name="Baine Bloodhoof", tip=ns.baine,
					achievements={ { id=259, showAllCriteria=true, faction="Horde", }, }, },
	[52004500] = { gourmet=true, name="Wiry Swoop", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ, },
}

points[ 1412 ] = { -- Mulgore
	[38682887] = { vendor=true, name="Seersa Copperpinch", faction="Horde", versionUnder=40101, tip=ns.vendor, },
	[39062927] = { vendor=true, name="Seersa Copperpinch", faction="Horde", version=40101, tip=ns.vendor, },
	[38702880] = { vendor=true, name="Whulwert Copperpinch", versionUnder=40101, faction="Horde",
					quests={ { id=7021, qType="Seasonal", }, }, tip=ns.vendorFB },
	[39102933] = { vendor=true, name="Whulwert Copperpinch", version=40101, faction="Horde",
					quests={ { id=7021, qType="Seasonal", }, }, tip=ns.vendorFB },
	[42003400] = { caroling=true, faction="Alliance", version=40300,
					achievements={ { id=5853, index=1, showAllCriteria=true, guide=ns.carolingCata, tip=ns.carolingTB }, }, },
	[42512865] = { armada=true, bbKing=true, name="Baine Bloodhoof",  tip=ns.baine,
					achievements={ { id=259, showAllCriteria=true, faction="Horde", },
						{ id=4436, index=4, showAllCriteria=true, faction="Alliance", guide=ns.bbMacroAR, tip=ns.bbTB, }, }, },
	[52004500] = { gourmet=true, name="Wiry Swoop", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ, },
}

points[ 85 ] = { -- Orgrimmar
	[39534733] = { miscQuests=true, name="Sagorne Creststrider", faction="Horde",
					quests={ { id=7061, name="The Feast of Winter Veil", level=10, qType="Seasonal", }, }, },
	[48047028] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=3, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbOrg2, }, }, },
	[49637799] = { miscQuests=true, name="Greatfather Winter", faction="Horde", version=40101, 
					quests={ { id=6962, name="Treats for Great-father Winter", level=10, qType="Seasonal", }, }, },
	[50137633] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=3, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbOrg3, }, }, },
	[50256215] = ns.setWondervolt,
	[51307100] = { miscQuests=true, name="Furmund", faction="Horde",
					quests={ { id=6964, name="The Reason for the Season", level=10, qType="Seasonal", }, }, },
	[52687728] = { vendor=true, name="Penney Copperpinch", faction="Horde", tip=ns.vendor },
	[53207640] = { onMetzen=true, name="Kaymard Copperpinch", faction="Horde", tip=ns.vendorFB,
						achievements={ { id=273, showAllCriteria=true, }, { id=279, showAllCriteria=true, }, },
						quests={ { id=6961, name="Great-father Winter is Here!", level=10, qType="Seasonal", },
						{ id=6983, name="You're a Mean One...", level=30, qType="Daily", },
						{ id=6984, name="A Smokywood Pastures' Thank You!", level=10, qType="Seasonal", }, }, },
	[55487852] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=3, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbOrg1, }, }, },
	[58605380] = { bbKing=true, name="Blax Bottlerocket", faction="Horde",
					achievements={ { id=4437, showAllCriteria=true, guide=ns.bbMacroHR, tip=ns.bbSeller, }, }, },
	[58806040] = { bbKing=true, name="Blax Bottlerocket", faction="Horde",
					achievements={ { id=4437, showAllCriteria=true, guide=ns.bbMacroHR, tip=ns.bbSeller, }, }, },
	[70007000] = { caroling=true, faction="Alliance",
					achievements={ { id=5853, index=1, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingOrg }, }, },
	[77006500] = ns.setIronArmada,
	[79006000] = ns.setGourmet,
	[77005700] = ns.setTisSeason,
	[77006100] = ns.setBlizzPoetry,
}

points[ 1454 ] = { -- Orgrimmar
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
	[30005500] = ns.setIronArmada,
	[32005000] = ns.setGourmet,
	[30004700] = ns.setTisSeason,
	[30005100] = ns.setBlizzPoetry,
}

points[ 71 ] = { -- Tanaris
	[52522806] = ns.setWondervolt,
}

points[ 1446 ] = { -- Tanaris
	[53602800] = ns.setWondervolt,
--	[52522806] = ns.setWondervolt,
	[73204800] = { onMetzen=true, name="Metzen the Reindeer", versionUnder=40300, guide=ns.greench,
					achievements={ { id=273, showAllCriteria=true, }, { id=279, showAllCriteria=true, }, },
					quests={ { id=8746, qType="Seasonal", faction="Horde", },
					{ id=8762, qType="Seasonal", faction="Alliance", }, }, },
}

points[ 57 ] = { -- Teldrassil
	[42003300] = { gourmet=true, name="Strigid mobs", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
	[42005800] = { gourmet=true, name="Strigid mobs", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
	[55038822] = { bbKing=true, caroling=true, name="Magenta Portal", faction="Horde",
					achievements={ { id=4437, index=2, showAllCriteria=true, guide=ns.bbMacroHR, tip=ns.bbDarnassus, },
					{ id=5854, index=2, showAllCriteria=true, guide=ns.caroling, }, },
					tip=ns.teldrassil .."\n\n" ..ns.magentaPortal, },
	[52288948] = { bbKing=true, caroling=true, name="Portal to Azuremyst Isle", faction="Horde",
					achievements={ { id=4437, index=2, showAllCriteria=true, guide=ns.bbMacroHR, },
					{ id=5854, index=2, showAllCriteria=true, guide=ns.caroling, }, },
					tip=ns.teldrassil, },
}

points[ 1438 ] = { -- Teldrassil
	[42003300] = { gourmet=true, name="Strigid mobs", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
	[42005800] = { gourmet=true, name="Strigid mobs", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
	[55038822] = { bbKing=true, caroling=true, name="Magenta Portal", faction="Horde", version=40300,
					achievements={ { id=4437, index=3, showAllCriteria=true, guide=ns.bbMacroHC, tip=ns.bbDarnassus, },
					{ id=5854, index=1, showAllCriteria=true, guide=ns.carolingCata, }, },
					tip=ns.teldrassil .."\n\n" ..ns.magentaPortal, },
	[52288948] = { bbKing=true, caroling=true, name="Portal to Azuremyst Isle", faction="Horde", version=40300,
					achievements={ { id=4437, index=3, showAllCriteria=true, guide=ns.bbMacroHC, },
					{ id=5854, index=1, showAllCriteria=true, guide=ns.carolingCata, }, }, tip=ns.teldrassil, },
}

points[ 103 ] = { -- The Exodar
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
	[75007000] = ns.setIronArmada,
	[77006500] = ns.setGourmet,
	[75006200] = ns.setTisSeason,
	[75006600] = ns.setBlizzPoetry,
	[79795530] = ns.setWondervolt,
}

points[ 1947 ] = { -- The Exodar
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
	[75007000] = ns.setIronArmada,
	[77006500] = ns.setGourmet,
	[75006200] = ns.setTisSeason,
	[75006600] = ns.setBlizzPoetry,
	[79795530] = ns.setWondervolt,
}

points[ 88 ] = { -- Thunder Bluff
	[42505580] = { vendor=true, name="Seersa Copperpinch", faction="Horde", tip=ns.vendor },
	[42605660] = { vendor=true, name="Whulwert Copperpinch", faction="Horde",
					quests={ { id=7021, qType="Seasonal", }, }, tip=ns.vendorFB },
	[60305169] = { armada=true, name="Baine Bloodhoof", tip=ns.baine,
					achievements={ { id=259, showAllCriteria=true, faction="Horde", }, }, },
	[63003300] = { caroling=true, faction="Alliance",
					achievements={ { id=5853, index=3, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingTB }, }, },
	[77005500] = ns.setIronArmada,
	[79005000] = ns.setGourmet,
	[77004700] = ns.setTisSeason,
	[77005100] = ns.setBlizzPoetry,
}

points[ 1456 ] = { -- Thunder Bluff
	[43685918] = { vendor=true, name="Seersa Copperpinch", faction="Horde", versionUnder=40101, tip=ns.vendor, },
	[42285495] = { vendor=true, name="Seersa Copperpinch", faction="Horde", version=40101, tip=ns.vendor, },
	[43805884] = { vendor=true, name="Whulwert Copperpinch", versionUnder=40101, faction="Horde",
					quests={ { id=7021, qType="Seasonal", }, }, tip=ns.vendorFB },
	[42465526] = { vendor=true, name="Whulwert Copperpinch", version=40101, faction="Horde",
					quests={ { id=7021, qType="Seasonal", }, }, tip=ns.vendorFB },
--	[42605660] = { vendor=true, name="Whulwert Copperpinch", faction="Horde",
--					quests={ { id=7021, qType="Seasonal", }, }, tip=ns.vendorFB },
	[60305169] = { armada=true, bbKing=true, name="Baine Bloodhoof",  tip=ns.baine,
					achievements={ { id=259, showAllCriteria=true, faction="Horde", },
						{ id=4436, index=4, showAllCriteria=true, faction="Alliance", guide=ns.bbMacroAR, tip=ns.bbTB, }, }, },
	[63003300] = { caroling=true, faction="Alliance", version=40300,
					achievements={ { id=5853, index=1, cguide=ns.carolingCata, tip=ns.carolingTB }, }, },
	[77005500] = ns.setIronArmada,
	[79005000] = ns.setGourmet,
	[77004700] = ns.setTisSeason,
	[77005100] = ns.setBlizzPoetry,
}

points[ 83 ] = { -- Winterspring
	[33005300] = ns.setHolidaySnow,
	[54503450] = ns.setHolidaySnow,
	[57007900] = ns.setHolidaySnow,
}

--==================================================================================================================================
--
-- EASTERN KINGDOMS
--
--==================================================================================================================================

						
points[ 1416 ] = { -- Alterac Mountains
	[33586794] = { onMetzen=true, name="Strange Snowman", versionUnder=40300, guide=ns.greench, faction="",
					achievements={ { id=273, showAllCriteria=true, }, { id=279, showAllCriteria=true, }, },
					quests={ { id=6983, name="You're a Mean One...", qType="Daily", faction="Horde", },
						{ id=7043, name="You're a Mean One...", qType="Daily", faction="Alliance", },
						{ id=6984, name="A Smokywood Pastures' Thank You!", qType="Seasonal", faction="Horde", },
						{ id=7045, name="A Smokywood Pastures' Thank You!", qType="Seasonal", faction="Alliance", }, }, },
	[34006300] = { letItSnow=true, tip="Try hanging out here, but Dalaran works too!",
					achievements={ { id=1687, showAllCriteria=true, guide=ns.letItSnow, }, }, },
	[35406130] = ns.setHolidaySnow,
	[40306580] = ns.setHolidaySnow,
	[46304800] = ns.setHolidaySnow,
}	

points[ 27 ] = { -- Dun Morogh
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
	[61003000] = { armada=true, name="Muradin Bronzebeard", achievements={
					{ id=1255, showAllCriteria=true, faction="Alliance", guide="Muradin is on his throne in Ironforge", }, }, },
	[63572980] = { miscQuests=true, name="Greatfather Winter", faction="Alliance",
					quests={ { id=7025, name="Treats for Great-father Winter", level=10, qType="Seasonal", }, }, },
	[72004900] = ns.setHolidaySnow,
}

points[ 1426 ] = { -- Dun Morogh
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
	[53183571] = ns.setWondervolt,
--	[60333394] = ns.setWondervolt,
	[56413159] = { miscQuests=true, name="Greatfather Winter", faction="Alliance", versionUnder=40101, 
					quests={ { id=7025, name="Treats for Great-father Winter", level=10, qType="Seasonal", }, }, },
	[63572980] = { miscQuests=true, name="Greatfather Winter", faction="Alliance", version=40101,
					quests={ { id=7025, name="Treats for Great-father Winter", level=10, qType="Seasonal", }, }, },
	[56473196] = { vendor=true, name="Macey Jinglepocket", faction="Alliance", versionUnder=40101, tip=ns.vendorFB },
	[63643009] = { vendor=true, name="Macey Jinglepocket", faction="Alliance", version=40101, tip=ns.vendorFB },
	[60813290] = { caroling=true, name="Caroling", faction="Horde", version=40300,
					achievements={ { id=5854, index=4, showAllCriteria=true, guide=ns.carolingCata, tip=ns.carolingIF }, }, },
	[61003000] = { armada=true, name="Muradin Bronzebeard", achievements={
					{ id=1255, showAllCriteria=true, faction="Alliance", guide="Muradin is on his throne in Ironforge", }, }, },
	[72004900] = ns.setHolidaySnow,
}

points[ 47 ] = { -- Duskwood
	[11605000] = { gourmet=true, name="Barn Owls", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
	[17002800] = { gourmet=true, name="Barn Owls", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
}

points[ 1431 ] = { -- Duskwood
	[11605000] = { gourmet=true, name="Barn Owls", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
	[17002800] = { gourmet=true, name="Barn Owls", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
}

points[ 37 ] = { -- Elwynn Forest
	[20475698] = { caroling=true, name="Caroling", faction="Horde", achievements={
					{ id=5854, index=4, showAllCriteria=true, guide=ns.caroling, tip="Example safe location" }, }, },
	[22202290] = { bromance=true, name="Brothers (several)", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, tip="Cathedral area" }, }, },
	[25793766] = { vendor=true, name="Khole Jinglepocket", faction="Alliance", tip=ns.vendor,
					quests={ { id=7023, name="Greatfather Winter Is Here", qType="Seasonal", }, }, },
	[25893766] = { vendor=true, name="Guchie Jinglepocket", faction="Alliance", tip=ns.vendorFB },
	[28663820] = ns.setWondervolt,
	[36910742] = { caroling=true, name="Caroling", faction="Horde", achievements={ 	
					{ id=5854, index=4, showAllCriteria=true, guide=ns.caroling, tip="Example safe location" }, }, },
	[41086595] = { bromance=true, name="Brother Wilhelm", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=2, tip="Blacksmith workshop" }, }, },
}

points[ 1429 ] = { -- Elwynn Forest
	[20475698] = { caroling=true, name="Caroling", faction="Horde", version=40300, achievements={
					{ id=5854, index=4, showAllCriteria=true, guide=ns.carolingCata, tip="Example safe location" }, }, },
	[22202290] = { bromance=true, name="Brothers (several)", showAllCriteria=true, faction="Alliance",
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
	[41086595] = { bromance=true, name="Brother Wilhelm", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=7, tip="Blacksmith workshop" }, }, },
}

points[ 94 ] = { -- Eversong Woods
	[43405640] = { gourmet=true, name="Dragonhawk mobs", achievements=ns.setSantaTreatsA,
					quests=ns.setSantaTreatsQ, tip=ns.smallEgg, },
	[44347124] = { caroling=true, name="Caroling", faction="Alliance",
					achievements={ { id=5853, index=2, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingSC3, }, }, },
	[52542968] = { caroling=true, name="Caroling", faction="Alliance",
					achievements={ { id=5853, index=2, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingSC1, }, }, },
	[54504654] = { vendor=true, name="Hotoppik Copperpinch", faction="Horde", tip=ns.vendor },
	[56435164] = ns.setWondervolt,
	[56654980] = { caroling=true, name="Caroling (5)", faction="Alliance",
					achievements={ { id=5853, index=2, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingSC2 }, }, },
	[58005160] = { gourmet=true, name="Dragonhawk mobs", achievements=ns.setSantaTreatsA,
					quests=ns.setSantaTreatsQ, tip=ns.smallEgg, },
	[59405160] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=2, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSC13, }, }, },
	[61865339] = { caroling=true, name="Caroling (4)", faction="Alliance",
					achievements={ { id=5853, index=2, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingSC5, }, }, },
	[62076312] = { caroling=true, name="Caroling (3)", faction="Alliance",
					achievements={ { id=5853, index=2, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingSC4, }, }, },
}

points[ 1941 ] = { -- Eversong Woods
	[43405640] = { gourmet=true, name="Dragonhawk mobs", achievements=ns.setSantaTreatsA,
					quests=ns.setSantaTreatsQ, tip=ns.smallEgg, },
	[44347124] = { caroling=true, name="Caroling", faction="Alliance", version=40300,
					achievements={ { id=5853, index=4, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingSC3, }, }, },
	[52542968] = { caroling=true, name="Caroling", faction="Alliance", version=40300,
					achievements={ { id=5853, index=4, showAllCriteria=true, guide=ns.carolingCata, tip=ns.carolingSC1, }, }, },
	[54504654] = { vendor=true, name="Hotoppik Copperpinch", faction="Horde", tip=ns.vendor },
	[56435164] = ns.setWondervolt,
	[56654980] = { caroling=true, name="Caroling (5)", faction="Alliance", version=40300,
					achievements={ { id=5853, index=4, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingSC2 }, }, },
	[58005160] = { gourmet=true, name="Dragonhawk mobs", achievements=ns.setSantaTreatsA,
					quests=ns.setSantaTreatsQ, tip=ns.smallEgg, },
	[59405160] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=2, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSC13, }, }, },
	[61865339] = { caroling=true, name="Caroling (4)", faction="Alliance", version=40300,
					achievements={ { id=5853, index=4, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingSC5, }, }, },
	[62076312] = { caroling=true, name="Caroling (3)", faction="Alliance", version=40300,
					achievements={ { id=5853, index=4, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingSC4, }, }, },
}

points[ 95 ] = { -- Ghostlands
	[69503080] = { caroling=true, name="Caroling (2)", faction="Alliance",
					achievements={ { id=5853, index=2, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingSC6, }, }, },
	[72606400] = { caroling=true, name="Caroling (1)", faction="Alliance",
					achievements={ { id=5853, index=2, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingSC7, }, }, },
}

points[ 1942 ] = { -- Ghostlands
	[69503080] = { caroling=true, name="Caroling (2)", faction="Alliance", version=40300,
					achievements={ { id=5853, index=4, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingSC6, }, }, },
	[72606400] = { caroling=true, name="Caroling (1)", faction="Alliance", version=40300,
					achievements={ { id=5853, index=4, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingSC7, }, }, },
}

points[ 25 ] = { -- Hillsbrad Foothills
	[42002900] = ns.setHolidaySnow,
	[43904090] = { letItSnow=true, tip="Try hanging out here, but Dalaran works too!",
					achievements={ { id=1687, showAllCriteria=true, guide=ns.letItSnow, }, }, },
	[45003900] = { onMetzen=true, name="Metzen the Reindeer", guide=ns.greench,
					achievements={ { id=273, showAllCriteria=true, }, { id=279, showAllCriteria=true, }, },
					quests={ { id=6983, name="You're a Mean One...", qType="Daily", faction="Horde", },
					{ id=7043, name="You're a Mean One...", qType="Daily", faction="Alliance", },
						{ id=6984, name="A Smokywood Pastures' Thank You!", qType="Seasonal", faction="Horde", },
						{ id=7045, name="A Smokywood Pastures' Thank You!", qType="Seasonal", faction="Alliance", }, }, },
	[47103620] = ns.setHolidaySnow,
	[50002500] = ns.setHolidaySnow,
	[65006800] = { gourmet=true, name="Rampaging Owlbeast", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
}

points[ 1424 ] = { -- Hillsbrad Foothills
	[42002900] = ns.setHolidaySnow,
	[43904090] = { letItSnow=true, tip="Try hanging out here, but Dalaran works too!",
					achievements={ { id=1687, showAllCriteria=true, guide=ns.letItSnow, }, }, },
	[45003900] = { onMetzen=true, name="Metzen the Reindeer", guide=ns.greench,
					achievements={ { id=273, showAllCriteria=true, }, { id=279, showAllCriteria=true, }, },
					quests={ { id=6983, name="You're a Mean One...", qType="Daily", faction="Horde", },
					{ id=7043, name="You're a Mean One...", qType="Daily", faction="Alliance", },
						{ id=6984, name="A Smokywood Pastures' Thank You!", qType="Seasonal", faction="Horde", },
						{ id=7045, name="A Smokywood Pastures' Thank You!", qType="Seasonal", faction="Alliance", }, }, },
	[47103620] = ns.setHolidaySnow,
	[50002500] = ns.setHolidaySnow,
	[65006800] = { gourmet=true, name="Rampaging Owlbeast", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
}

points[ 87 ] = { -- Ironforge
	[12918923] = { bbKing=true, name="BB King (1)", faction="Horde",
					achievements={ { id=4437, index=1, showAllCriteria=true, guide=ns.bbMacroHR, tip=ns.bbMuradin1, }, }, },
	[16128462] = { caroling=true, name="Caroling", faction="Horde",
					achievements={ { id=5854, index=3, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingIF }, }, },
	[24107473] = { bbKing=true, name="BB King (2)", faction="Horde",
					achievements={ { id=4437, index=1, showAllCriteria=true, guide=ns.bbMacroHR, tip=ns.bbMuradin3, }, }, },
	[30506050] = { miscQuests=true, name="Goli Krumn", faction="Alliance",
					quests={ { id=7062, name="The Reason for the Season", level=10, qType="Seasonal", }, }, },
	[33216542] = { miscQuests=true, name="Greatfather Winter", faction="Alliance",
					quests={ { id=7025, name="Treats for Great-father Winter", level=10, qType="Seasonal", }, }, },
	[33586794] = { onMetzen=true, name="Wulmort Jinglepocket", faction="Alliance", tip=ns.vendor,
					achievements={ { id=273, showAllCriteria=true, }, { id=279, showAllCriteria=true, }, },
					quests={ { id=7022, name="Greatfather Winter is Here!", level=10, qType="Seasonal", },
					{ id=7043, name="You're a Mean One...", level=30, qType="Daily", },
					{ id=7045, name="A Smokywood Pastures' Thank You!", level=10, qType="Seasonal", }, }, },
	[33616769] = { vendor=true, name="Macey Jinglepocket", faction="Alliance", versionUnder=40101, tip=ns.vendorFB },
	[33666727] = { vendor=true, name="Macey Jinglepocket", faction="Alliance", version=40101, tip=ns.vendorFB },
	[37356678] = { bbKing=true, name="BB King (3)", faction="Horde",
					achievements={ { id=4437, index=1, showAllCriteria=true, guide=ns.bbMacroHR, tip=ns.bbMuradin2, }, }, },
	[39675542] = { bbKing=true, name="BB King (5)", faction="Horde",
					achievements={ { id=4437, index=1, showAllCriteria=true, guide=ns.bbMacroHR, tip=ns.bbMuradin6, }, }, },
	[45007400] = ns.setIronArmada,
	[47006900] = ns.setGourmet,
	[45006600] = ns.setTisSeason,
	[45007000] = ns.setBlizzPoetry,
	[40005500] = { armada=true, name="Muradin Bronzebeard", achievements={
					{ id=1255, showAllCriteria=true, faction="Alliance", guide="Muradin is on his throne in Ironforge", }, }, },
	[45324853] = { bbKing=true, name="BB King (4)", faction="Horde",
					achievements={ { id=4437, index=1, showAllCriteria=true, guide=ns.bbMacroHR, tip=ns.bbMuradin4, }, }, },
	[45755272] = { bbKing=true, name="BB King (6)", faction="Horde",
					achievements={ { id=4437, index=1, showAllCriteria=true, guide=ns.bbMacroHR, tip=ns.bbMuradin5, }, }, },
	[77551183] = { miscQuests=true, name="Historian Karnik", faction="Alliance",
					quests={ { id=7063, name="The Feast of Winter Veil", level=10, qType="Seasonal", }, }, },
}

points[ 1455 ] = { -- Ironforge
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
	[33806770] = { vendor=true, name="Macey Jinglepocket", faction="Alliance", tip=ns.vendorFB },
	[37356678] = { bbKing=true, name="BB King (3)", faction="Horde",
					achievements={ { id=4437, index=2, showAllCriteria=true, guide=ns.bbMacroHC, tip=ns.bbMuradin2, }, }, },
	[39675542] = { bbKing=true, name="BB King (5)", faction="Horde",
					achievements={ { id=4437, index=2, showAllCriteria=true, guide=ns.bbMacroHC, tip=ns.bbMuradin6, }, }, },
	[45007400] = ns.setIronArmada,
	[47006900] = ns.setGourmet,
	[45006600] = ns.setTisSeason,
	[45007000] = ns.setBlizzPoetry,
	[39185611] = { armada=true, name="Muradin Bronzebeard", achievements={
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

points[ 48 ] = { -- Loch Modan
	[17002800] = { gourmet=true, name="Loch Buzzard", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
	[58005200] = { gourmet=true, name="Loch Buzzard", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
	[79006700] = { gourmet=true, name="Golden Eagle", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
}

points[ 1432 ] = { -- Loch Modan
	[17002800] = { gourmet=true, name="Loch Buzzard", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
	[58005200] = { gourmet=true, name="Loch Buzzard", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
	[79006700] = { gourmet=true, name="Golden Eagle", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
}

points[ 50 ] = { -- Northern Stranglethorn
	[47251110] = { bromance=true, name="Brother Nimetz", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=1, }, }, },
}

points[ 50 ] = { -- Redridge Mountains
	[18006400] = { gourmet=true, name="Dire Condor", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
}

points[ 1433 ] = { -- Redridge Mountains
	[18006400] = { gourmet=true, name="Dire Condor", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
}

points[ 1427 ] = { -- Searing Gorge
	[68753423] = { onMetzen=true, name="Metzen the Reindeer", versionUnder=40300, guide=ns.greench,
					achievements={ { id=273, showAllCriteria=true, }, { id=279, showAllCriteria=true, }, },
					quests={ { id=8746, qType="Seasonal", faction="Horde", },
					{ id=8762, qType="Seasonal", faction="Alliance", }, }, },
}

points[ 110 ] = { -- Silvermoon City
	[31004300] = ns.setIronArmada,
	[33003800] = ns.setGourmet,
	[31003500] = ns.setTisSeason,
	[31003900] = ns.setBlizzPoetry,
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

points[ 1954 ] = { -- Silvermoon City
	[31004300] = ns.setIronArmada,
	[33003800] = ns.setGourmet,
	[31003500] = ns.setTisSeason,
	[31003900] = ns.setBlizzPoetry,
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

points[ 84 ] = { -- Stormwind City
	[49514522] = { bromance=true, name="Brother Joshua", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=5, tip=ns.broJoshua }, }, },
	[52104760] = { bromance=true, name="Brother Benjamin", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=8, tip=ns.broBenjamin }, }, },
	[52414580] = { bromance=true, name="Brother Cassius", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=7, tip=ns.broCassius }, }, },
	[52604392] = { bromance=true, name="Brother Crowley", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=6, tip=ns.broCrowley }, }, },
	[55045417] = { bromance=true, name="Brother Kristoff", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=4, tip=ns.broKristoff }, }, },
	[56607040] = { bbKing=true, name="Craggle Wobbletop", faction="Alliance",
					achievements={ { id=4436, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSeller, }, }, },
	[62307040] = { vendor=true, name="Khole Jinglepocket", faction="Alliance", tip=ns.vendor,
					quests={ { id=7023, name="Greatfather Winter Is Here", qType="Seasonal", }, }, },
	[62507040] = { vendor=true, name="Guchie Jinglepocket", faction="Alliance", tip=ns.vendorFB },
	[65606292] = { bbKing=true, name="Craggle Wobbletop", faction="Alliance",
					achievements={ { id=4436, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbSeller, }, }, },
	[68057148] = ns.setWondervolt,
	[86007700] = ns.setIronArmada,
	[88007200] = ns.setGourmet,
	[86006900] = ns.setTisSeason,
	[86007300] = ns.setBlizzPoetry,
}

points[ 1453 ] = { -- Stormwind City
	[49514522] = { bromance=true, name="Brother Joshua", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=1, tip=ns.broJoshua }, }, },
	[52104760] = { bromance=true, name="Brother Benjamin", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=8, tip=ns.broBenjamin }, }, },
	[52414580] = { bromance=true, name="Brother Cassius", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=6, tip=ns.broCassius }, }, },
	[52604392] = { bromance=true, name="Brother Crowley", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=3, tip=ns.broCrowley }, }, },
	[55045417] = { bromance=true, name="Brother Kristoff", showAllCriteria=true, faction="Alliance",
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
	[86007700] = ns.setIronArmada,
	[88007200] = ns.setGourmet,
	[86006900] = ns.setTisSeason,
	[86007300] = ns.setBlizzPoetry,
}

points[ 224 ] = { -- Stranglethorn Vale
	[37567622] = ns.setWondervolt,
	[48390814] = { bromance=true, name="Brother Nimetz", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=1, }, }, },
}

points[ 1434 ] = { -- Stranglethorn Vale / Northern Stranglethorn (Cata Classic)
	[26717347] = ns.setWondervoltUnder,
--	[37567622] = ns.setWondervolt,
	[48390814] = { bromance=true, name="Brother Nimetz", showAllCriteria=true, faction="Alliance",
					achievements={ { id=1686, index=1, }, }, },
}

points[ 210 ] = { -- The Cape of Stranglethorn
	[40356756] = ns.setWondervolt,
}

points[ 18 ] = { -- Tirisfal Glades
	[60006900] = { bromance=true, name="Brother Malach", showAllCriteria=true, faction="Horde",
					achievements={ { id=1685, index=1, tip="Descend into Undercity" }, }, },
	[61105929] = ns.setWondervolt,
}

points[ 1420 ] = { -- Tirisfal Glades
	[60006900] = { bromance=true, name="Brother Malach", showAllCriteria=true, faction="Horde",
					achievements={ { id=1685, index=1, tip="Descend into Undercity" }, }, },
	[61105929] = ns.setWondervolt,
	[62277325] = { vendor=true, name="Jaycrue Copperpinch", faction="Horde", tip=ns.vendorFB },
	[62297330] = { vendor=true, name="Nardstrum Copperpinch", faction="Horde", tip=ns.vendor,
					quests={ { id=7024, name="Great-father Winter is Here", level=10, qType="Seasonal", }, }, },
}

points[ 90 ] = { -- Undercity
	[15203050] = { caroling=true, faction="Alliance",
					achievements={ { id=5853, index=4, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingUC2 }, }, },
	[23633914] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=1, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC2, }, }, },
	[34713321] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=1, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC3, }, }, },
	[36005300] = ns.setIronArmada,
	[38004800] = ns.setGourmet,
	[36004500] = ns.setTisSeason,
	[36004900] = ns.setBlizzPoetry,
	[41433333] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=1, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC4, }, }, },
	[45978314] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=1, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC7, }, }, },
	[46722712] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=1, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC1, }, }, },
	[46944393] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=1, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC5, }, }, },
	[50862166] = { bromance=true, name="Brother Malach", showAllCriteria=true, faction="Horde",
					achievements={ { id=1685, index=1, }, }, },
	[52446384] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=1, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC6, }, }, },
	[54539037] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=1, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC8, }, }, },
	[58504390] = { caroling=true, faction="Alliance",
					achievements={ { id=5853, index=4, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingUC1 }, }, },
	[68233886] = { vendor=true, name="Nardstrum Copperpinch", faction="Horde",
					quests={ { id=7024, qType="Seasonal", }, }, tip=ns.vendor, },
	[68604000] = { vendor=true, name="Jaycrue Copperpinch", faction="Horde", tip=ns.vendorFB },
}

points[ 1458 ] = { -- Undercity
	[15203050] = { caroling=true, faction="Alliance", version=40300,
					achievements={ { id=5853, index=2, showAllCriteria=true, guide=ns.caroling, tip=ns.carolingUC2 }, }, },
	[23633914] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=3, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC2, }, }, },
	[34713321] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=3, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC3, }, }, },
	[36005300] = ns.setIronArmada,
	[38004800] = ns.setGourmet,
	[36004500] = ns.setTisSeason,
	[36004900] = ns.setBlizzPoetry,
	[41433333] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=3, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC4, }, }, },
	[45978314] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=3, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC7, }, }, },
	[46722712] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=3, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC1, }, }, },
	[46944393] = { bbKing=true, faction="Alliance",
					achievements={ { id=4436, index=3, showAllCriteria=true, guide=ns.bbMacroAR, tip=ns.bbUC5, }, }, },
	[50862166] = { bromance=true, name="Brother Malach", showAllCriteria=true, faction="Horde",
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

points[ 52 ] = { -- Westfall
	[49003100] = { gourmet=true, name="Young Fleshripper", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
	[51001920] = { gourmet=true, name="Young Fleshripper", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
	[62005760] = { gourmet=true, name="Young Fleshripper", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
}

points[ 1436 ] = { -- Westfall
	[49003100] = { gourmet=true, name="Young Fleshripper", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
	[51001920] = { gourmet=true, name="Young Fleshripper", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
	[57604160] = { gourmet=true, name="Young Fleshripper", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
	[62005760] = { gourmet=true, name="Young Fleshripper", achievements=ns.setSantaTreatsA, quests=ns.setSantaTreatsQ,
					tip=ns.smallEgg, },
}

points[ 56 ] = { -- Wetlands
	[09236089] = ns.setWondervolt,
}

points[ 1437 ] = { -- Wetlands
	[09345831] = ns.setWondervolt,
--	[09236089] = ns.setWondervolt,
}

--==================================================================================================================================
--
-- OUTLAND
--
--==================================================================================================================================

points[ 105 ] = { -- Blade's Edge Mountains
	[28765737] = { falala=true, name="Quest Hub", achievements={ { id=1282, guide=ns.falala, }, },
					quests={ { id=11025, qType="One Time", }, { id=11030, qType="One Time", },
						{ id=11062, qType="One Time", }, { id=11010, qType="One Time", },
						{ id=11102, qType="One Time", class="Druid", }, { id=11023, qType="Daily", }, }, },
	[34404140] = { falala=true, name="Bombing Run Area", achievements={ { id=1282, tip="You do the bombing runs here" }, }, },
}

points[ 1949 ] = { -- Blade's Edge Mountains
	[28765737] = { falala=true, name="Quest Hub", achievements={ { id=1282, guide=ns.falala, }, }, },
	[34404140] = { falala=true, name="Bombing Run Area", achievements={ { id=1282, tip="You do the bombing runs here" }, }, },
}

points[ 111 ] = { -- Shattrath City
	[51262966] = { vendor=true, name="Eebee Jinglepocket", tip=ns.vendor },
	[60605720] = { vendor=true, name="Olnayvi Copperpinch", tip=ns.vendorFB },
	[66008700] = ns.setIronArmada,
	[68008200] = ns.setGourmet,
	[66007900] = ns.setTisSeason,
	[66008300] = ns.setBlizzPoetry,
	[80105846] = ns.setWondervolt,
}

--==================================================================================================================================
--
-- NORTHREND
--
--==================================================================================================================================

points[ 114 ] = { -- Borean Tundra
	[40205500] = { bromance=true, name="Durkot Wolfbrother", showAllCriteria=true, faction="Horde",
					achievements={ { id=1685, index=2, tip=ns.broDurkot }, }, },
	[31003000] = { tisSeason=true, name="'Tis the Season", noCoords=true,
					achievements={ { id=277, showAllCriteria=true, guide=ns.threeSet, tip=ns.threeSetNexus, }, }, },
}

points[ 127 ] = { -- Crystalsong Forest
	[29563287] = { frostyShake=true, achievements={ { id=1690, showAllCriteria=true, guide=ns.frostyShake, }, },
					quests={ { id=6983, name="You're a Mean One...", qType="Daily", faction="Horde", },
						{ id=7043, name="You're a Mean One...", qType="Daily", faction="Alliance", }, 
						{ id=6984, name="A Smokywood Pastures' Thank You!", qType="Seasonal", faction="Horde", },
						{ id=7045, name="A Smokywood Pastures' Thank You!", qType="Seasonal", faction="Alliance", }, }, },
	[27003850] = ns.setWondervolt,
}

points[ 125 ] = { -- Dalaran
	[49394373] = ns.setWondervolt,
	[49832909] = { frostyShake=true, achievements={ { id=1690, showAllCriteria=true, guide=ns.frostyShake, }, },
					quests={ { id=6983, name="You're a Mean One...", qType="Daily", faction="Horde", },
						{ id=7043, name="You're a Mean One...", qType="Daily", faction="Alliance", }, 
						{ id=6984, name="A Smokywood Pastures' Thank You!", qType="Seasonal", faction="Horde", },
						{ id=7045, name="A Smokywood Pastures' Thank You!", qType="Seasonal", faction="Alliance", }, }, },
	[55005400] = { letItSnow=true, tip="Try hanging out here, but Alterac Mountains might be best!",
					achievements={ { id=1687, showAllCriteria=true, guide=ns.letItSnow, }, }, },
	[90004900] = ns.setIronArmada,
	[92004400] = ns.setGourmet,
	[90004100] = ns.setTisSeason,
	[90004500] = ns.setBlizzPoetry,
}

points[ 118 ] = { -- Icecrown
	[69404240] = { bromance=true, name="Brother Keltan", showAllCriteria=true, version=60000, faction="Horde",
					achievements={ { id=1685, index=3, tip=ns.broKeltan }, }, },
}

points[ 129 ] = { -- The Nexus
	[27503420] = { tisSeason=true, name="'Tis the Season", noCoords=true,
					achievements={ { id=277, showAllCriteria=true, tip="You need Grand Magus Telestra. Must be Heroic!", }, }, },
	[31507440] = { tisSeason=true, name="'Tis the Season", noCoords=true,
					achievements={ { id=277, showAllCriteria=true, tip="You need Grand Magus Telestra. Must be Heroic!", }, }, },
}

points[ 143 ] = { -- The Oculus
	[63004200] = { tisSeason=true, name="'Tis the Season", noCoords=true,
					achievements={ { id=277, showAllCriteria=true,
					tip="You need Mage-Lord Urom, the 3rd boss. Must be Heroic!", }, }, },
}

--==================================================================================================================================
--
-- GARRISON / DRAENOR
--
--==================================================================================================================================

points[ 525 ] = { -- Frostfire Ridge
	[46202750] = { miscQuests=true, name="Daily Hub", guide=ns.garrison,
					quests={ { id=39649, name="Menacing Grumplings", qType="Daily", },
						{ id=39668, name="What Horrible Presents!", qType="Daily", },
						{ id=39648, name="Where Are the Children?", qType="Daily", },
						{ id=39651, name="Grumpus", qType="Daily", }, },
					tip="The Snow Mounds in this area have a 5% chance of a Grumpling pet!", },
	[48556369] = { vendor=true, name="Tradurjo Jinglepocket", faction="Horde", tip=ns.vendor ..ns.vendorL3Garr },
	[48266473] = { miscQuests=true, name="Pizzle", guide=ns.garrison, faction="Horde",
					quests={ { id=39649, name="Menacing Grumplings", qType="Daily", },
						{ id=39668, name="What Horrible Presents!", qType="Daily", },
						{ id=39648, name="Where Are the Children?", qType="Daily", },
						{ id=39651, name="Grumpus", qType="Daily", }, }, },
	[48306477] = { armada=true, name="Izzy Hollyfizzle", faction="Horde", version=60202,
					achievements={ { id=10353, showAllCriteria=true, guide=ns.armada, }, }, },
}

points[ 590 ] = { -- Frostwall Garrison
	[36002400] = ns.setGourmet,
	[34002100] = ns.setTisSeason,
	[34002500] = ns.setBlizzPoetry,
	[50403360] = { vendor=true, name="Ashanem Jinglepocket", faction="Horde", tip=ns.vendorFB ..ns.vendorL3Garr },
	[50653236] = { vendor=true, name="Tradurjo Jinglepocket", faction="Horde", tip=ns.vendor ..ns.vendorL3Garr },
	[47043812] = { miscQuests=true, name="Pizzle", guide=ns.garrison, faction="Horde",
					quests={ { id=39649, name="Menacing Grumplings", qType="Daily", },
						{ id=39668, name="What Horrible Presents!", qType="Daily", },
						{ id=39648, name="Where Are the Children?", qType="Daily", },
						{ id=39651, name="Grumpus", qType="Daily", }, }, },
	[47353844] = { armada=true, name="Izzy Hollyfizzle", faction="Horde", version=60202,
					achievements={ { id=10353, showAllCriteria=true, guide=ns.armada, }, }, },
}

points[ 543 ] = { -- Gorgrond
	[06267254] = { miscQuests=true, name="Pizzle", guide=ns.garrison, faction="Horde",
					quests={ { id=39649, name="Menacing Grumplings", qType="Daily", },
						{ id=39668, name="What Horrible Presents!", qType="Daily", },
						{ id=39648, name="Where Are the Children?", qType="Daily", },
						{ id=39651, name="Grumpus", qType="Daily", }, }, },
	[06287257] = { armada=true, name="Izzy Hollyfizzle", faction="Horde", version=60202,
					achievements={ { id=10353, showAllCriteria=true, guide=ns.armada, }, }, },
}

points[ 582 ] = { -- Lunarfall Garrison
	[41754789] = { vendor=true, name="Tradurjo Jinglepocket", faction="Alliance", tip=ns.vendor ..ns.vendorL3Garr },
	[42204720] = { vendor=true, name="Ashanem Jinglepocket", faction="Alliance", tip=ns.vendorFB ..ns.vendorL3Garr },
	[44005135] = { miscQuests=true, name="Almie", guide=ns.garrison, faction="Alliance",
					quests={ { id=39649, name="Menacing Grumplings", qType="Daily", },
						{ id=39668, name="What Horrible Presents!", qType="Daily", },
						{ id=39648, name="Where Are the Children?", qType="Daily", },
						{ id=39651, name="Grumpus", qType="Daily", }, }, },
	[44305104] = { armada=true, name="Izzy Hollyfizzle", version=60202, faction="Alliance",
					achievements={ { id=10353, showAllCriteria=true, guide=ns.armada, }, }, },
	[64007000] = ns.setGourmet,
	[62006700] = ns.setTisSeason,
	[62007100] = ns.setBlizzPoetry,
}

points[ 539 ] = { -- Shadowmoon Valley in Draenor
	[29901740] = { vendor=true, name="Tradurjo Jinglepocket", faction="Alliance", tip=ns.vendor ..ns.vendorL3Garr },
	[30231795] = { armada=true, name="Izzy Hollyfizzle", version=60202, faction="Alliance",
					achievements={ { id=10353, showAllCriteria=true, guide=ns.armada, }, }, },
	[30201798] = { miscQuests=true, name="Almie", guide=ns.garrison, faction="Alliance",
					quests={ { id=39649, name="Menacing Grumplings", qType="Daily", },
						{ id=39668, name="What Horrible Presents!", qType="Daily", },
						{ id=39648, name="Where Are the Children?", qType="Daily", },
						{ id=39651, name="Grumpus", qType="Daily", }, }, },
}

points[ 535 ] = { -- Talador
	[93726470] = { miscQuests=true, name="Almie", guide=ns.garrison, faction="Alliance",
					quests={ { id=39649, name="Menacing Grumplings", qType="Daily", },
						{ id=39668, name="What Horrible Presents!", qType="Daily", },
						{ id=39648, name="Where Are the Children?", qType="Daily", },
						{ id=39651, name="Grumpus", qType="Daily", }, }, },
	[93766466] = { armada=true, name="Izzy Hollyfizzle", version=60202, faction="Alliance",
					achievements={ { id=10353, showAllCriteria=true, guide=ns.armada, }, }, },
}

points[ 534 ] = { -- Tanaan Jungle
	[80375685] = { armada=true, name="Gondar", version=60202,
					achievements={ { id=10353, index=4, guide=ns.armada, tip=ns.tanaanSpawns }, }, },
	[83454366] = { armada=true, name="Drakum", version=60202,
					achievements={ { id=10353, index=5, guide=ns.armada, tip=ns.tanaanSpawns }, }, },
	[88135583] = { armada=true, name="Smashum Grabb", version=60202,
					achievements={ { id=10353, index=3, guide=ns.armada, tip=ns.tanaanSpawns }, }, },
}

--==================================================================================================================================
--
-- WORLD / OTHER
--
--==================================================================================================================================

ns.yourHub = "Your Feast of Winter Veil hub!"

points[ 946 ] = { -- Azeroth
	[45704570] = { wondervolt=true, name="Orgrimmar", showAnyway=true, faction="Horde", tip=ns.yourHub },
	[58305160] = { wondervolt=true, name="Ironforge", showAnyway=true, faction="Alliance", tip=ns.yourHub },
	[79005150] = { miscQuests=true, name="Daily Hub", guide=ns.garrison,
					quests={ { id=39649, name="Menacing Grumplings", qType="Daily", },
						{ id=39668, name="What Horrible Presents!", qType="Daily", },
						{ id=39648, name="Where Are the Children?", qType="Daily", },
						{ id=39651, name="Grumpus", qType="Daily", }, },
					tip="Pickup the dailies from your level 3 Garrison", },
	[89805850] = { armada=true, name="Gondar, Drakum, Smashum Grab", version=60202,
					achievements={ { id=10353, showAllCriteria=true, guide=ns.armada, tip=ns.tanaanSpawns }, }, },
}

-- Choice of texture
-- Note that these textures are all repurposed and as such have non-uniform sizing. I've tried to homogenise
-- the sizes. I know I should also allow for non-uniform origin placement as well as adjust the x,y offsets
textures[1] = "Interface\\PlayerFrame\\MonkLightPower"
textures[2] = "Interface\\PlayerFrame\\MonkDarkPower"
textures[3] = "Interface\\Common\\Indicator-Red"
textures[4] = "Interface\\Common\\Indicator-Yellow"
textures[5] = "Interface\\Common\\Indicator-Green"
textures[6] = "Interface\\Common\\Indicator-Gray"
textures[7] = "Interface\\AddOns\\HandyNotes_WinterVeil\\BlueRibbonBox"
textures[8] = "Interface\\AddOns\\HandyNotes_WinterVeil\\GreenRibbonBox"
textures[9] = "Interface\\AddOns\\HandyNotes_WinterVeil\\PinkRibbonBox"
textures[10] = "Interface\\AddOns\\HandyNotes_WinterVeil\\PurpleRibbonBox"
textures[11] = "Interface\\AddOns\\HandyNotes_WinterVeil\\RedRibbonBox"
textures[12] = "Interface\\AddOns\\HandyNotes_WinterVeil\\TealRibbonBox"
textures[13] = "Interface\\AddOns\\HandyNotes_WinterVeil\\BlueSantaHat"
textures[14] = "Interface\\AddOns\\HandyNotes_WinterVeil\\GreenSantaHat"
textures[15] = "Interface\\AddOns\\HandyNotes_WinterVeil\\PinkSantaHat"
textures[16] = "Interface\\AddOns\\HandyNotes_WinterVeil\\RedSantaHat"
textures[17] = "Interface\\AddOns\\HandyNotes_WinterVeil\\YellowSantaHat"
textures[18] = "Interface\\AddOns\\HandyNotes_WinterVeil\\CandyCane"
textures[19] = "Interface\\AddOns\\HandyNotes_WinterVeil\\GingerBread"
textures[20] = "Interface\\AddOns\\HandyNotes_WinterVeil\\Holly"

scaling[1] = 0.55
scaling[2] = 0.55
scaling[3] = 0.55
scaling[4] = 0.55
scaling[5] = 0.55
scaling[6] = 0.55
scaling[7] = 0.48
scaling[8] = 0.48
scaling[9] = 0.48
scaling[10] = 0.48
scaling[11] = 0.48
scaling[12] = 0.48
scaling[13] = 0.48
scaling[14] = 0.48
scaling[15] = 0.48
scaling[16] = 0.48
scaling[17] = 0.48
scaling[18] = 0.48
scaling[19] = 0.60
scaling[20] = 0.48
