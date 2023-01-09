local _, ns = ...
local points = ns.points
local textures = ns.textures
local scaling = ns.scaling
local colourPrefix		= ns.colour.prefix
local colourHighlight	= ns.colour.highlight
local colourPlaintext	= ns.colour.plaintext

local almiePizzle = "offers four dailies. \"Grumpus\" will require help.\n"
				.."The quests are clustered just south-west of the\n"
				.."Bloodmaul Slag Mines dungeon at about (46.2, 27.5).\n\n"
				.."The point of the dailies is to apply Winter Veil\n"
				.."decorations to your Garrison. Beware! These will\n"
				.."replace your Hallows End decorations. Choose wisely!\n\n"
				.."And... to obtain the Minion of Grumpus from a\n"
				.."Savage Gift. 3% drop chance. Sellable on the AH"
local dance = "No dance partner? No problem. All you need is TWO toons as follows:\n"
				.."(1) Create TWO clients on your computer. The MOST important step.\n"
				.."Do this by navigating to \"_retail_\" and double clicking TWICE on\n"
				.."\"Wow.exe\" or twice launching the game through Battlenet.\n"
				.."(2) On client one position your first character in Dalaran.\n"
				.."(3) Alt-tab to client two. Get your second character ready too.\n"
				.."(4) Note the message from Blizzard about the other client. Ignore.\n"
				.."(5) Alt-tab to client one. Login toon one. Select toon two and \dance.\n"
				.."(6) Congratulations. Continue Alt-tabbing for the other toon if you want!"
local vendor = " will happily sell you a snowball,\n"
				.."a Winter Veil Chorus Book, patterns, recipes, spices,\n"
				.."spirits and wrapping paper! Time is money friend!"
local caroling = "Use your \"Winter Veil Chorus Book\". Look for it in\n"
				.."your Toy Box or else in your bags if newly received."
local brothers = "If some brothers are missing then deal\n"
				.."with Anduin, who will be nearby"
local threeSet = "Strictly must be the \"Winter Garb\" set, no other similarly\n"
				.."named gear will do. The hat and chest/clothes may be red\n"
				.."or green. You are ready once you have the \"set bonus\".\n\n"
				..colourHighlight .."Red Hat:" ..colourPlaintext .." Easiest is Grand Magus Telestra in The Nexus\n"
				.."dungeon in Coldarra, Borean Tundra, Northrend. Bottom\n"
				.."entrance. Must be Heroic. Turn left after entering. It's the\n"
				.."second boss fight.\n\n"
				..colourHighlight .."Green Hat:" ..colourPlaintext .." Easiest is Mage-Lord Urom, the 3rd boss in\n"
				.."heroic The Oculus. The entrance is above The Nexus.\n"
				.."Don't timewalk either dungeon.\n\n"
				..colourHighlight .."Red/Green Winter Clothes & Winter Boots:" ..colourPlaintext .." Use the AH\n"
				.."or hire a tailor.\n\n"
				..colourHighlight .."Tailoring Patterns:" ..colourPlaintext .." Any capital city vendor, your level 3\n"
				.."garrison or Eebee Jinglepocket at The Aldor Bank in\n"
				.."Shattrath for the boots. Alliance cities or your level\n"
				.."3 garrison for Red Clothes. Eebee or Horde cities for the\n"
				.."Green Clothes"
local gourmet = "Wulmort and Macey in IF and Penny and Kaymard\n"
				.."in Org have most of what you need, except:\n\n"
				..colourHighlight .."Small Egg:" ..colourPlaintext .." By far the best place to farm is the dragonhawks\n"
				.."just outside Silvermoon. The most accessible for Alliance\n"
				.."are the barn owls along the western edge of Duskwood.\n\n"
				..colourHighlight .."Ice Cold Milk:" ..colourPlaintext .." The nearby inn sells it.\n\n"
				.."Note the vanilla cooking level requirements for the recipes!"
local airRifle = " sells the \"Red Rider Air Rifle\" that\n"
				.."you need for this Achievement. He pats through here.\n\n"
				.."Note that you must \"pelt\". This effect doesn't\n"
				.."happen every time you fire the rifle.\n\n"
				.."Reality check: You are going to die a lot. If you\n"
				.."have invisibility and patience then much less so"
local armada = "\"Flamer\": Do the \"You're a mean one...\" daily\n"
				.."and then check your stolen present each time.\n\n"
				.."\"Killdozer\": You need a level 3 Garrison.\n"
				.."Complete the Winter Veil dailies for tokens,\n"
				.."five of which allows you to purchase from Izzy.\n\n"
				.."\"Mortar\": Dropped by Smashum Grabb, a rare elite\n"
				.."in Tanaan Jungle. Can drop all year so no stress.\n\n"
				.."\"Cannon\": Dropped by Gondar, a rare elite in\n"
				.."Tanaan Jungle. Can drop all year so no stress.\n\n"
				.."\"Roller\": Dropped by Drakum, a rare elite in\n"
				.."Tanaan Jungle. Can drop all year so no stress.\n\n"
				.."(I've marked the Tanaan mob locations. Be patient,\n"
				.."drop rates are 10%. This pin marks your progress)"
										
-- Achievements:
-- With a Little Helper From My Friends - 252 Alliance/Horde
-- BB King - 4436 Alliance, 4437 Horde
-- 'Yis the Season - 277 Alliance/Horde
-- Let it Snow - 1687 Alliance/Horde
-- A Frosty Shake - 1690 Alliance/Horde
-- On Metzen - 273 Alliance/Horde
-- Iron Armada - 10353 Alliance/Horde
-- Fa-la-la-la-Ogri'la - 1282 Alliance/Horde
-- A-Caroling We Will Go - 5853 Alliance, 5854 Horde
-- Holiday Bromance - 1686 Alliance, 1685 Horde
-- Vendors - 1

-- ===================================================
-- aIDA, aIDH, aIndexA, aIndexH, aQuestA, aQuestH, tip
-- ===================================================

points[ 97 ] = { -- Azuremyst Isle
	[28404273] = { 0, 0, 1, 0, 0, 0, "Wolgren Jinglepocket" ..vendor },
	[34634441] = { 252, 252, 0, 0, 0, 0, "Winter Wondervolt machine" },
	[24674933] = { 0, 5854, 0, 2, 0, 0, "It is sufficient to stand here" },
	[22415318] = { 0, 4437, 0, 2, 0, 0, "For details on how to get here please see the\n"
										.."\"A-Caroling We Will Go\" markers" },
	[23504620] = { 0, 4437, 0, 2, 0, 0, "Use this entrance into The Exodar. No guards (yet)" },
}
points[ 105 ] = { -- Blade's Edge Mountains
	[34404140] = { 1282, 1282, 0, 0, 0, 0, "You do the bombing runs here" },
	[28765737] = { 1282, 1282, 0, 0, 0, 0, "Go here and speak to Chu'a'lor. Complete \"The Crystals\"\n"
					.."then talk to Torkus and complete \"Our Boy wants...\" then\n"
					.."go to Chu'a'lor and complete \"The Skyguard Outpost\" then\n"
					.."talk to Sky Commander Keller -> Vanderlip and complete\n"
					.."\"Bombing Run\". Only now is the daily \"Bomb Them Again\"\n"
					.."available. Use your Fresh/Preserved Holly now!" },
}
points[ 114 ] = { -- Borean Tundra
	[40205500] = { 0, 1685, 0, 2, 0, 0, "Go to the ground floor. He pats through here" },
	[31003000] = { 277, 277, 0, 0, 0, 0, "Don't forget to set \"Heroic\". You\n"
										.."need both The Nexus and The Oculus" },
}
points[ 127 ] = { -- Crystalsong Forest
	[29563287] = { 1690, 1690, 0, 0, 0, 0, dance },
	[27003850] = { 252, 252, 0, 0, 0, 0, "Winter Wondervolt machine" },
}
points[ 125 ] = { -- Dalaran
	-- Dalaran will not show in Crystalsong Forest but it will propagate upwards
	[49394373] = { 252, 252, 0, 0, 0, 0, "Winter Wondervolt machine" },
	[49832909] = { 1690, 1690, 0, 0, 0, 0, dance },
}
points[ 89 ] = { -- Darnassus
	[44048492] = { 0, 4437, 0, 3, 0, 0, "3) Two guards here. Go up this ramp" },
	[42977300] = { 0, 4437, 0, 3, 0, 0, "1) Entrance is this way. Two guards, blow\n"
										.."your invisibility here and pause at the\n"
										.."next marker for a refresh" },
	[42977428] = { 0, 4437, 0, 3, 0, 0, "5) Upstairs. Along the mezzanine perimeter are\n"
										.."more guards at intervals. Aside from invisibility\n"
										.." you'll just need to soldier on, die and rez" },
	[43808505] = { 0, 4437, 0, 3, 0, 0, "4) Two guards here at the top of the ramp. Turning\n"
										.."right is a little more optimal than a left. There\n"
										.."is no longer an opportunity to wait out a CD so\n"
										.."delaying any rez will be optimal in that respect" },
	[46508027] = { 0, 4437, 0, 3, 0, 0, "2) A safe place to wait out cooldowns. You'll\n"
										.."now have one more chance to go invisible" },
	[43017807] = { 0, 4437, 0, 3, 0, 0, "6) Upstairs. Exact location of the High Priestess.\n"
										.."Use a \"tar tyrande\" macro and as soon as you\n"
										.."\"pelt\" surge straight past her and fall into\n"
										.."the shallow pool below for zero fall damage.\n"
										.."No guards here. Spin around 180 degrees and run\n"
										.."forward, veering left to avoid the two guards at\n"
										.."the exit. With luck you'll be okay to hearth but\n"
										.."certainly in a good place to rez" },
}
points[ 27 ] = { -- Dun Morogh
	[60333394] = { 252, 252, 0, 0, 0, 0, "Winter Wondervolt machine" },
	[39804480] = { 1690, 1690, 0, 0, 0, 0, "The \"Holdiay Snow\" mounds contain 3-6 snowballs." },
	[63505550] = { 1690, 1690, 0, 0, 0, 0, "The \"Holdiay Snow\" mounds contain 3-6 snowballs." },
	[48204150] = { 1690, 1690, 0, 0, 0, 0, "The \"Holdiay Snow\" mounds contain 3-6 snowballs." },
	[59303200] = { 0, 0, 1, 0, 7043, 0, "Wulmort Jinglepocket" ..vendor .."\n\n"
									.."A daily is also offered, leading to the \"On Metzen!\"\n"
									.."and \"Simply Abominable\" achievements" },
	[60813290] = { 0, 5854, 0, 3, 0, 0, "Here is a safe place. It's above the Gates of Ironforge" },
	[63503400] = { 277, 0, 0, 0, 0, 0, threeSet },
	[63503100] = { 1688, 0, 0, 0, 0, 0, gourmet },
	[63502800] = { 10353, 0, 0, 0, 0, 0, armada },
	[59203010] = { 0, 4437, 0, 1, 0, 0, "Fly in and stay up as high as possible. Use a small,\n"
										.."stable mount for best visibilty and clearance" },
}
points[ 1 ] = { -- Durotar
	[44000210] = { 252, 252, 0, 0, 0, 0, "Winter Wondervolt machine" },
	[46530618] = { 0, 0, 0, 1, 0, 6983, "Penny Copperpinch" ..vendor .."\n\n"
									.."A daily is also offered, leading to the \"On Metzen!\"\n"
									.."and \"Simply Abominable\" achievements" },
	[50000980] = { 0, 5854, 0, 1, 0, 0, "The Hyjal portal might be an option for you. Fly\n"
										.."over to Teldrassil via Darkshore. Speak to Zidormi\n"
										.."if Teldrassil is destroyed!" },
	[50000980] = { 0, 5854, 0, 2, 0, 0, "The Hyjal portal might be an option for you. Fly\n"
										.."over to Teldrassil via Darkshore. Speak to Zidormi\n"
										.."if Teldrassil is destroyed! Then look\n"
										.."for the Azuremyst Isle portal at the wharves" },
	[42000980] = { 0, 5854, 0, 4, 0, 0, "The Zeppelin to Grom'gol is your best bet" },
	[42000980] = { 0, 5854, 0, 3, 0, 0, "The Zeppelin to Grom'gol is your best bet" },
	[46000980] = { 0, 1688, 0, 0, 0, 0, gourmet },
	[44000980] = { 0, 10353, 0, 0, 0, 0, armada },
	[48000980] = { 0, 277, 0, 0, 0, 0, threeSet },
}
points[ 47 ] = { -- Duskwood
	[11605000] = { 1688, 0, 0, 0, 0, 0, "Best place for Alliance to farm small eggs.\n"
										.."Drop rate is about 2/3rds from the barn owls" },
}
points[ 70 ] = { -- Dustwallow Marsh
	[67394741] = { 1686, 0, 3, 0, 0, 0, "Speak to Zidormi if you can't find him" },
}
points[ 23 ] = { -- Eastern Plaguelands
	[75465322] = { 5853, 0, 2, 0, 0, 0, "There is a direct flightpath from Ironforge to\n"
										.."Light's Hope Chapel. If possible continue\n"
										.."flying into Ghostlands and follow the markers" },
}
points[ 37 ] = { -- Elwynn Forest
	[41086595] = { 1686, 0, 2, 0, 0, 0, "He's at the Blacksmith building" },
	[22202290] = { 1686, 0, 0, 0, 0, 0, "Various Brothers at the Cathedral" },
	[30003050] = { 252, 252, 0, 0, 0, 0, "Winter Wondervolt machine" },
	[24503220] = { 0, 0, 1, 0, 0, 0, "Khole Jinglepocket" ..vendor },
	[20475698] = { 0, 5854, 0, 4, 0, 0, "Here is a safe place" },
	[36910742] = { 0, 5854, 0, 4, 0, 0, "Here is a safe place" },
	[35003700] = { 277, 0, 0, 0, 0, 0, threeSet },
	[35003400] = { 1688, 0, 0, 0, 0, 0, gourmet },
	[35003100] = { 10353, 0, 0, 0, 0, 0, armada },
}
points[ 94 ] = { -- Eversong Woods
	[54504654] = { 0, 0, 0, 1, 0, 0, "Hotoppik Jinglepocket" ..vendor },
	[56435164] = { 252, 252, 0, 0, 0, 0, "Winter Wondervolt machine" },
	[52542968] = { 5853, 0, 2, 0, 0, 0, "Don't bother with the old \"crack in the wall\" exploit.\n"
										.."I tried it for testing. There is an invisible wall.\n"
										.."Baby Spice will not help too." },
	[56654980] = { 5853, 0, 2, 0, 0, 0, "Without invisibility you will draw agro. Better to die/\n"
										.."rez as per marker as there are more guards inside too!" },
	[62076312] = { 5853, 0, 2, 0, 0, 0, "Farstrider Retreat will be to your left." },
	[61865339] = { 5853, 0, 2, 0, 0, 0, "Come this way. Thuron's Livery on your left." },
	[44347124] = { 5853, 0, 2, 0, 0, 0, "This is where you will rez, if you were wondering.\n"
										.."Fairbreeze Village. Yeah... I took a hit for the team." },
	[59305160] = { 0, 1688, 0, 0, 0, 0, "Best place for Horde to farm small eggs.\n"
										.."Drop rate is 100% from the dragonhawks" },
	[57205050] = { 4436, 0, 2, 0, 0, 0, "Two guards and up ahead many more. Use invisibility.\n"
										.."For details on how to get here please see the\n"
										.."\"A-Caroling We Will Go\" markers" },
}
points[ 95 ] = { -- Ghostlands
	[72606400] = { 5853, 0, 2, 0, 0, 0, "Start here at the Zul'Aman flight point. If that is not possible\n"
										.."then begin at Light's Hope Chapel in the Eastern Plaguelands" },
	[69503080] = { 5853, 0, 2, 0, 0, 0, "From Zul'Aman ride up to here. Stay on the left side of\n"
										.."Lake Elrendar. Continue north into Eversong Woods" },
}
points[ 25 ] = { -- Hillsbrad Foothills
	[43503880] = { 273, 273, 0, 0, 0, 0, "The Abominable Greench needs to be slayed.\nWait a while for a respawn" },
	[43904090] = { 1687, 1687, 0, 0, 0, 0, "Try hanging out here, but Dalaran works too!" },
	[50002260] = { 1690, 1690, 0, 0, 0, 0, "The \"Holdiay Snow\" mounds contain 3-6 snowballs." },
	[45903650] = { 1690, 1690, 0, 0, 0, 0, "The \"Holdiay Snow\" mounds contain 3-6 snowballs." },
}
points[ 118 ] = { -- Icecrown
	[69404240] = { 0, 1685, 0, 3, 0, 0, "He's on Orgrim's Hammer, a huge flying airship.\n"
										.."Check your map for the current location" },
}
points[ 87 ] = { -- Ironforge
	[33586794] = { 0, 0, 1, 0, 7043, 0, "Wulmort Jinglepocket" ..vendor .."\n\n"
									.."A daily is also offered, leading to the \"On Metzen!\"\n"
									.."and \"Simply Abominable\" achievements" },
	[16128462] = { 0, 5854, 0, 3, 0, 0, "Here is a safe place. It's above the Gates of Ironforge" },
	[39675542] = { 0, 4437, 0, 1, 0, 0, "Sure, blast Muradin until you \"pelt\" him but consider\n"
										.."your exit strategy. You need to be close to that side\n"
										.."passage so use your range and back-up ASAP. Once he\n"
										.."is tagged then use invisibility if you have it and get\n"
										.."to that side passage for hearthing or a mount and dash" },
	[45755272] = { 0, 4437, 0, 1, 0, 0, "Try to die as close as possible to here so that\n"
										.."you may rez safely down in the side passage" },
	[45324853] = { 0, 4437, 0, 1, 0, 0, "Descend to here and enter \"The High Seat\" chamber" },
	[37356678] = { 0, 4437, 0, 1, 0, 0, "Fly over to this tunnel. Wait out your\n"
										.."invisibility cooldown if necessary" },
	[12918923] = { 0, 4437, 0, 1, 0, 0, "Fly in and stay up as high as possible. Use a small,\n"
										.."stable mount for best visibilty and clearance" },
	[24107473] = { 0, 4437, 0, 1, 0, 0, "There is a high up ledge here. Safe\n"
										.."to pause and say your last prayers" },
	[34006000] = { 1688, 0, 0, 0, 0, 0, gourmet },
	[34005700] = { 10353, 0, 0, 0, 0, 0, armada },
	[34006300] = { 277, 0, 0, 0, 0, 0, threeSet },
	[54004800] = { 5853, 0, 2, 0, 0, 0, "There is a direct flightpath from Ironforge to\n"
										.."Light's Hope Chapel. If possible continue\n"
										.."flying into Ghostlands and follow the markers" },
	[54005100] = { 5853, 0, 4, 0, 0, 0, "Just fly straight up to the Sewer entrance as marked" },
	[58254700] = { 5853, 0, 1, 0, 0, 0, "Probably best to fly to Menethil Harbour,\n"
										.."boat to Kalimdor and then as per markers" },
	[56905050] = { 5853, 0, 3, 0, 0, 0, "Probably best to fly to Menethil Harbour,\n"
										.."boat to Kalimdor and then as per markers" },
}
points[ 198 ] = { -- Mount Hyjal
	[56002000] = { 0, 5854, 0, 0, 0, 0, "From Nordrassil fly over to Darkshore.\n"
										.."You may need to speak to Zidormi" },
}
points[ 7 ] = { -- Mulgore
	[39003100] = { 0, 0, 1, 1, 0, 0, "Seersa Copperpinch" ..vendor .."\n"
									.."Alliance, if quick, can buy the Green Winter Clothes\n"
									.."pattern before you die" },
	[42003400] = { 5853, 0, 3, 0, 0, 0, "Just fly in and land on the very edge\n"
										.."of any of the mesas. Easy peasy!\n" ..caroling },
}
points[ 50 ] = { -- Northern Stranglethorn
	[47251110] = { 1686, 0, 1, 0, 0, 0, "" },
}
points[ 85 ] = { -- Orgrimmar
	[52687728] = { 0, 0, 0, 1, 0, 6983, "Penny Copperpinch" ..vendor .."\n\n"
									.."A daily is also offered, leading to the \"On Metzen!\"\n"
									.."and \"Simply Abominable\" achievements" },
	[70007000] = { 5853, 0, 1, 0, 0, 0, "Fly in and land up high at the perimeter. Easy as!\n" .. caroling },
	[56606800] = { 0, 10353, 0, 0, 0, 0, armada },
	[56607400] = { 0, 277, 0, 0, 0, 0, threeSet },
	[50256215] = { 252, 252, 0, 0, 0, 0, "Winter Wondervolt machine" },
	[51133829] = { 0, 5854, 0, 2, 0, 0, "The Hyjal portal might be an option for you. Fly\n"
										.."over to Teldrassil via Darkshore. Speak to Zidormi\n"
										.."if Teldrassil is destroyed! Then look for the\n"
										.."Azuremyst Isle portal at the wharves" },
	[55005334] = { 0, 5854, 0, 4, 0, 0, "The Zeppelin to Grom'gol is your best bet" },
	[55005334] = { 0, 5854, 0, 3, 0, 0, "The Zeppelin to Grom'gol is your best bet" },
	[56607100] = { 0, 1688, 0, 0, 0, 0, gourmet },
	[58806040] = { 0, 4437, 0, 0, 0, 0, "Blax Bottlerocket" ..airRifle  },
	[58605380] = { 0, 4437, 0, 0, 0, 0, "Blax Bottlerocket" ..airRifle },
	[55487852] = { 4436, 0, 3, 0, 0, 0, "If finished and invisible then run to here\n"
										.."and hearth. It's a nook behind the AH" },
	[48047028] = { 4436, 0, 3, 0, 0, 0, "Eitrigg is here. There's no sugar coating this...\n"
										.."you'll die and it may take a few tries if you\n"
										.."luck out with the \"pelt\" buff." },
	[50137633] = { 4436, 0, 3, 0, 0, 0, "Through here. Just inside is an okay spot\n"
										.."to rez or pause if you are lucky. Best\n"
										.."approach is to simply fly in, dropping\n"
										.."down from some height. If nimble then\n"
										.."surge past the chicane and use your\n"
										.."\"/tar Eitrigg\" macro and get that \"pelt\"\n"
										.."before you die. If lucky a quick\n"
										.."invisibility will save you" },
}
points[ 111 ] = { -- Shattrath City
	[80105846] = { 252, 252, 0, 0, 0, 0, "Winter Wondervolt machine" },
	[51262966] = { 0, 0, 1, 1, 0, 0, "Eebee Jinglepocket" ..vendor },
}
points[ 110 ] = { -- Silvermoon City
	[63647932] = { 0, 0, 0, 1, 0, 0, "Hotoppik Jinglepocket" ..vendor },
	-- Check. Wowhead says not the two patterns or the Hot Apple Cider recipe
	[70708900] = { 5853, 0, 2, 0, 0, 0, "The nearest flightpoint is Zul'Aman in Ghostlands.\n"
										.."Toughest of the four. You will die. Make a dash for\n"
										.."inside then a sharp left and hide as per marker.\n"
										.."Invisibility (Mages/potions) works here.\n" },
	[53792021] = { 4436, 0, 2, 0, 0, 0, "He's right here. Try to pelt him from ranged\n"
										.."as he has a lot of guards behind him. Decide\n"
										.."where you will hearth (after invis/rez). The\n"
										.."translocation room at the rear or the earlier\n"
										.."side room (with trainer NPCs)" },
	[74405860] = { 4436, 0, 2, 0, 0, 0, "Pinch point. The two pats are in opposite directions\n"
										.."and you lose all visibility here. Wait at the earlier\n"
										.."marker to gain a sense of timing" },
	[69956595] = { 4436, 0, 2, 0, 0, 0, "A couple of pats come through the Walk of Elders.\n"
										.."You could try hiding in here with the vendors" },
	[73645221] = { 4436, 0, 2, 0, 0, 0, "A couple of pats come through Murder Row.\n"
										.."You can pause over to the side as necessary" },
	[59283759] = { 4436, 0, 2, 0, 0, 0, "Wait out your invisibility/hearth cooldown here" },
	[72298479] = { 4436, 0, 2, 0, 0, 0, "So many guards here. Invisibility" },
	[72644365] = { 4436, 0, 2, 0, 0, 0, "2 guards here. Invisibility" },
	[61532949] = { 4436, 0, 2, 0, 0, 0, "12 nasty guards up ahead. Now is the time to go invisible" },
	[50661633] = { 4436, 0, 2, 0, 0, 0, "No guards here. A good place to hearth from invisibility" },
	[54422662] = { 4436, 0, 2, 0, 0, 0, "The side rooms are safe for hiding and hearthing.\n"
										.."The NPCs here are all trainers. Also, if you used\n"
										.."invisibility to enter then wait out the CD here" },
	[72299178] = { 4436, 0, 2, 0, 0, 0, "Two guards and up ahead many more. Use invisibility" },
}
points[ 84 ] = { -- Stormwind City
	[68057148] = { 252, 252, 0, 0, 0, 0, "Winter Wondervolt machine" },
	[62807005] = { 0, 0, 1, 0, 0, 0, "Khole Jinglepocket" ..vendor },
	[55045417] = { 1686, 0, 4, 0, 0, 0, "" },
	[49514522] = { 1686, 0, 5, 0, 0, 0, brothers },
	[52604392] = { 1686, 0, 6, 0, 0, 0, "Go downstairs.\n" ..brothers },
	[52414580] = { 1686, 0, 7, 0, 0, 0, brothers },
	[52104760] = { 1686, 0, 8, 0, 0, 0, "He pats up and down here.\n" ..brothers },
	[51003500] = { 277, 0, 0, 0, 0, 0, threeSet },
	[51003200] = { 1688, 0, 0, 0, 0, 0, gourmet },
	[51002900] = { 10353, 0, 0, 0, 0, 0, armada },
	[51749780] = { 0, 5854, 0, 4, 0, 0, "There is a safe place off the map, due south but still in Stormwind" },
	[84530997] = { 0, 5854, 0, 4, 0, 0, "Here is a safe place" },
	[56607040] = { 4436, 0, 0, 0, 0, 0, "Craggle Wobbletop" ..airRifle },
	[64606140] = { 4436, 0, 0, 0, 0, 0, "Craggle Wobbletop" ..airRifle },
	[73006900] = { 5853, 0, 2, 0, 0, 0, "There is a direct flightpath from Ironforge to\n"
										.."Light's Hope Chapel. If possible continue\n"
										.."flying into Ghostlands and follow the markers" },
	[74007200] = { 5853, 0, 4, 0, 0, 0, "Just fly straight up to the Sewer entrance as marked" },
	[73007430] = { 5853, 0, 1, 0, 0, 0, "Probably best to fly to Booty Bay, boat\n"
										.."to Kalimdor and then as per markers" },
	[71207050] = { 5853, 0, 3, 0, 0, 0, "Probably best to fly to Booty Bay, boat\n"
										.."to Kalimdor and then as per markers" },
}
points[ 224 ] = { -- Stranglethorn Vale
	[37567622] = { 252, 252, 0, 0, 0, 0, "Winter Wondervolt machine" },
	[48390814] = { 1686, 0, 1, 0, 0, 0, "" },
}
points[ 534 ] = { -- Tanaan Jungle
	[88135583] = { 10353, 10353, 3, 3, 0, 0, "Smashum Grabb spawns here. Every 5 to 10 minutes\n"
											.."but is farmable once per day. Drop rate is about 10%" },
	[80375685] = { 10353, 10353, 4, 4, 0, 0, "Gondar spawns here. Every 5 to 10 minutes but\n"
											.."is farmable once per day. Drop rate is about 10%" },
	[83454366] = { 10353, 10353, 5, 5, 0, 0, "Drakum spawns here. Every 5 to 10 minutes but\n"
											.."is farmable once per day. Drop rate is about 10%" },
}
points[ 71 ] = { -- Tanaris
	[52522806] = { 252, 252, 0, 0, 0, 0, "Winter Wondervolt machine" },
}
points[ 57 ] = { -- Teldrassil
	[55008810] = { 0, 5854, 0, 1, 0, 0, "Fly through the pink portal and press your\n"
										.."up key (spacebar) to fly straight up in Darnassus\n"
										.."and then perch on a high safe ledge" },
	[52288947] = { 0, 5854, 0, 2, 0, 0, "The portal to Azuremyst Isle" },
	[26224308] = { 0, 5854, 0, 1, 0, 0, "From your safe vantage point you can now reverse\n"
										.."the procedure if you don't want to wait out a hearth\n"
										.."cooldown. As soon as you take the pink portal down,\n"
										.."surge forward and up as the guards will instantly\n"
										.."hit you and you'll not want a dismount" },
}
points[ 210 ] = { -- The Cape of Stranglethorn
	[40356756] = { 252, 252, 0, 0, 0, 0, "Winter Wondervolt machine" },
}
points[ 103 ] = { -- The Exodar
	[79795530] = { 252, 252, 0, 0, 0, 0, "Winter Wondervolt machine" },
	[55824883] = { 0, 0, 1, 0, 0, 0, "Wolgren Jinglepocket" ..vendor },
	[41437425] = { 0, 5854, 0, 2, 0, 0, "It is sufficient to stand here" },
	[32865450] = { 0, 4437, 0, 2, 0, 0, "The Prophet is right here. Get that \"pelt\"\n"
										.."and die. Nothing could be simpler" },
	[31486188] = { 0, 4437, 0, 2, 0, 0, "Two guards here, three at the top of the stairs.\n"
										.."Then take a hard right. a \"/tar Prophet Velen\"\n"
										.."macro would be most useful. Spam it from now" },
	[42107240] = { 0, 4437, 0, 2, 0, 0, "Enter The Exodar this way" },
	[37405993] = { 0, 4437, 0, 2, 0, 0, "No guards through here. Pause for any cooldowns" },
	[26354940] = { 0, 4437, 0, 2, 0, 0, "Safe to respawn and hearth/portal from here" },
	[35127476] = { 0, 4437, 0, 2, 0, 0, "Two guards here. Left 90 degrees, jump down,\n"
										.."straight forward, bearing left a little" },
}
points[ 129 ] = { -- The Nexus
	[27503420] = { 277, 277, 0, 0, 0, 0, "You need Grand Magus Telestra. Must be Heroic!" },
	[31507440] = { 277, 277, 0, 0, 0, 0, "Go this way!" },
}
points[ 143 ] = { -- The Oculus
	[63004200] = { 277, 277, 0, 0, 0, 0, "You need Mage-Lord Urom, the 3rd boss. Must be Heroic!" },
}
points[ 88 ] = { -- Thunder Bluff
	[42005520] = { 0, 0, 1, 1, 0, 0, "Seersa Copperpinch" ..vendor .."\n"
									.."Alliance, if quick, can buy the Green Winter Clothes\n"
									.."pattern before you die" },
	[63003300] = { 5853, 0, 3, 0, 0, 0, "Just fly in and land on the very edge\n"
										.."of any of the mesas. Easy peasy!\n" ..caroling },
}
points[ 18 ] = { -- Tirisfal Glades
	[61105929] = { 252, 252, 0, 0, 0, 0, "Winter Wondervolt machine" },
	[63197694] = { 5853, 0, 4, 0, 0, 0, "Do NOT try to descend into Undercity. Land on a dome\n"
										.."in the ruins. This dome is fine. The largest one too.\n" ..caroling },
	[51607070] = { 5853, 0, 4, 0, 0, 0, "The sewer entrance works perfectly fine.\n"
										.."Stop entering when the Undercity map appears.\n" ..caroling },
	[60006900] = { 0, 1685, 0, 1, 0, 0, "Descend into Undercity" },
	[51037152] = { 4436, 0, 1, 0, 0, 0, "Enter Undercity through the Sewers. No guards here" },
}
points[ 90 ] = { -- Undercity
	[68233886] = { 0, 0, 0, 1, 0, 0, "Nardstrum Copperpinch" ..vendor },
	[58504390] = { 5853, 0, 4, 0, 0, 0, "Do NOT descend into Undercity" },
	[15203050] = { 5853, 0, 4, 0, 0, 0, "The sewer entrance works perfectly fine.\n"
										.."Stop entering when the Undercity map appears.\n" ..caroling },
	[50862166] = { 0, 1685, 0, 1, 0, 0, "Descend into Undercity" },
	[46722712] = { 4436, 0, 1, 0, 0, 0, "Two guards here. Do not come this way as there's\n"
										.."no chance later to cooldown you invisibility" },
	[23633914] = { 4436, 0, 1, 0, 0, 0, "Relax. No guards in this section. Use a small,\n"
										.."stable mount for best visibility and clearance" },
	[34713321] = { 4436, 0, 1, 0, 0, 0, "Go this way. Guard up ahead" },
	[41433333] = { 4436, 0, 1, 0, 0, 0, "One guard here. Use invisibility" },
	[46944393] = { 4436, 0, 1, 0, 0, 0, "No guards through to here. Pause for\n"
										.."invisibility cooldown if necessary" },
	[52446384] = { 4436, 0, 1, 0, 0, 0, "Enter here. Invisibility is your friend" },
	[45978314] = { 4436, 0, 1, 0, 0, 0, "There are two guards at each archway. Got invisibility?" },
	[54539037] = { 4436, 0, 1, 0, 0, 0, "The Dark Lady is up ahead. Just fire like crazy and die" },
}
points[ 56 ] = { -- Wetlands
	[09236089] = { 252, 252, 0, 0, 0, 0, "Winter Wondervolt machine" },
}
points[ 83 ] = { -- Winterspring
	[58505730] = { 1690, 1690, 0, 0, 0, 0, "The \"Holdiay Snow\" mounds contain 3-6 snowballs." },
	[41104910] = { 1690, 1690, 0, 0, 0, 0, "The \"Holdiay Snow\" mounds contain 3-6 snowballs." },
}

points[ 12 ] = { -- Kalimdor
	[47001680] = { 0, 5854, 0, 0, 0, 0, "You can easily fly from Darkshore to Teldrassil.\n"
										.."There's a portal to The Exodar at the docks" },
	[42001100] = { 0, 4437, 0, 3, 0, 0, "The High Priestess is in the Temple. There is a\n"
										.."mezzanine inside upon which she is located. You'll\n"
										.."take a ramp upstairs.\n\n"
										.."There is one safe location to wait out cooldowns\n"
										.."once inside then no other opportunities until after\n"
										.."you have hit her.\n\n"
										.."Follow the \"A-Caroling we Will Go\" markers for a\n"
										.."guide on how to get to Darnassus/Teldrassil. Click\n"
										.."on Darnassus from the Teldrassil map for details" },
	[57906130] = { 4436, 0, 3, 0, 0, 0, "You could consider approaching via\n"
										.."Ironforge -> Menethil Harbor -> Theramore.\n"
										.."Eitrigg is in Orgrimmar" },
	[56505040] = { 4436, 0, 3, 0, 0, 0, "You could consider approaching via\n"
										.."Stormwind -> Booty Bay -> Ratchet.\n"
										.."Eitrigg is in Orgrimmar" },
}

points[ 582 ] = { -- Lunarfall Garrison in Draenor
	[41754789] = { 0, 0, 1, 0, 0, 0, "Tradurjo Jinglepocket" ..vendor .."\n\nYou must have a level 3 garrison" },
	[43755100] = { 0, 0, 0, 0, 39651, 0, "Almie " ..almiePizzle },
	[41105050] = { 10353, 0, 0, 0, 0, 0, armada },
}
points[ 539 ] = { -- Shadowmoon Valley in Draenor
	[29901740] = { 0, 0, 1, 0, 0, 0, "Tradurjo Jinglepocket" ..vendor .."\n\nYou must have a level 3 garrison" },
	[31001400] = { 0, 0, 0, 0, 39651, 0, "Almie " ..almiePizzle },
	[30201550] = { 10353, 0, 0, 0, 0, 0, armada },
}
points[ 590 ] = { -- Frostwall Garrison in Draenor
	[50653236] = { 0, 0, 0, 1, 0, 0, "Tradurjo Jinglepocket" ..vendor .."\n\nYou must have a level 3 garrison" },
	[47173796] = { 0, 0, 0, 0, 0, 39651, "Pizzle " ..almiePizzle },
	[48703530] = { 0, 10353, 0, 0, 0, 0, armada },
}
points[ 525 ] = { -- Frostfire Ridge in Draenor
	[48556369] = { 0, 0, 0, 1, 0, 0, "Tradurjo Jinglepocket" ..vendor .."\n\nYou must have a level 3 garrison" },
	[48376495] = { 0, 0, 0, 0, 0, 39651, "Pizzle " ..almiePizzle },
	[48606420] = { 0, 10353, 0, 0, 0, 0, armada },
}

-- ===========================
-- Continents & Sub-Continents
-- ===========================

-- Choice of texture
-- Note that these textures are all repurposed and as such have non-uniform sizing. I've copied my scaling factors from my old AddOn
-- in order to homogenise the sizes. I should also allow for non-uniform origin placement as well as adjust the x,y offsets
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

scaling[1] = 0.85
scaling[2] = 0.85
scaling[3] = 0.83
scaling[4] = 0.83
scaling[5] = 0.83
scaling[6] = 0.83
scaling[7] = 0.75
scaling[8] = 0.75
scaling[9] = 0.75
scaling[10] = 0.75
scaling[11] = 0.75
scaling[12] = 0.75
scaling[13] = 0.75
scaling[14] = 0.75
scaling[15] = 0.75
scaling[16] = 0.75
scaling[17] = 0.75
scaling[18] = 0.75
scaling[19] = 0.75
scaling[20] = 0.75
