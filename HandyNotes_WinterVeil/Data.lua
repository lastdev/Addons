local _, ns = ...
local points = ns.points
local textures = ns.textures
local scaling = ns.scaling
local colourPrefix		= ns.colour.prefix
local colourHighlight	= ns.colour.highlight
local colourPlaintext	= ns.colour.plaintext

local airRifle = " sells the \"Red Rider Air Rifle\" that\n"
				.."you need for this Achievement. He pats through here.\n\n"
				.."Note that you must \"pelt\". This effect doesn't\n"
				.."happen every time you fire the rifle.\n\n"
				.."Reality check: You are going to die a lot. If you\n"
				.."have invisibility and patience then much less so"
local almiePizzle = "offers four dailies. \"Grumpus\" will require help.\n"
				.."The quests are clustered just south-west of the\n"
				.."Bloodmaul Slag Mines dungeon at about (46.2, 27.5).\n\n"
				.."The point of the dailies is to apply Winter Veil\n"
				.."decorations to your Garrison. Beware! These will\n"
				.."replace your Hallows End decorations. Choose wisely!\n\n"
				.."And... to obtain the Minion of Grumpus from a\n"
				.."Savage Gift. 3% drop chance. Sellable on the AH"
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
local blizzPoetry = "'Twas the feast of Great-Winter\nAnd all through the land\nAll the races were running\n"
						.."With snowballs in hand.\nThe cooks were all frantic\nAnd for those \"in the know\"\n"
						.."Swoops and owls were crashing\nLike new-fallen snow.\n\nCookies and eggnog\n"
						.."Were consumed by all\nAs the snowballs flew freely\nAnd drunks smashed into walls.\n\n"
						.."May your feast of Great-Winter\nBe one merry and bright\nAnd from all here at Blizzard\n"
						.."We wish you a fun night!\n\n(From the original holiday description!)"
local brothers = "If some brothers are missing then deal\n"
				.."with Anduin, who will be nearby"
local caroling = "Use your \"Winter Veil Chorus Book\". Look for it in\n"
				.."your Toy Box or else in your bags if newly received."
local dance = "No dance partner? No problem. All you need is TWO toons as follows:\n"
				.."(1) Create TWO clients on your computer. The MOST important step.\n"
				.."Do this by navigating to \"_retail_\" and double clicking TWICE on\n"
				.."\"Wow.exe\" or twice launching the game through Battlenet.\n"
				.."(2) On client one position your first character in Dalaran.\n"
				.."(3) Alt-tab to client two. Get your second character ready too.\n"
				.."(4) Note the message from Blizzard about the other client. Ignore.\n"
				.."(5) Alt-tab to client one. Login toon one. Select toon two and \dance.\n"
				.."(6) Congratulations. Continue Alt-tabbing for the other toon if you want!"
local gourmet = "Wulmort and Macey in IF and Penny and Kaymard\n"
				.."in Org have most of what you need, except:\n\n"
				..colourHighlight .."Small Egg:" ..colourPlaintext .." By far the best place to farm is the dragonhawks\n"
				.."just outside Silvermoon. The most accessible for Alliance\n"
				.."are the barn owls along the western edge of Duskwood.\n\n"
				..colourHighlight .."Ice Cold Milk:" ..colourPlaintext .." The nearby inn sells it.\n\n"
				.."Note the vanilla cooking level requirements for the recipes!"
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
local vendor = " will happily sell you a snowball,\n"
				.."a Winter Veil Chorus Book, patterns, recipes, spices,\n"
				.."spirits and wrapping paper! Time is money friend!"

-- Achievements:
-- With a Little Helper From My Friends - 252 Alliance/Horde
-- BB King - 4436 Alliance, 4437 Horde
-- 'Yis the Season - 277 Alliance/Horde
-- Let it Snow - 1687 Alliance/Horde
-- Gourmet - 1688 Alliance/Horde
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
	[28404273] = { vendor=true, tip="Wolgren Jinglepocket" ..vendor },
	[34634441] = { aID=252, tip="Winter Wondervolt machine" },
	[24674933] = { aIDH=5854, indexH=2, tip="It is sufficient to stand here" },
	[22415318] = { aIDH=4437, indexH=2, tip="For details on how to get here please see the\n"
										.."\"A-Caroling We Will Go\" markers" },
	[23504620] = { aIDH=4437, indexH=2, tip="Use this entrance into The Exodar. No guards (yet)" },
}
points[ 105 ] = { -- Blade's Edge Mountains
	[34404140] = { aID=1282, tip="You do the bombing runs here" },
	[28765737] = { aID=1282, tip="Go here and speak to Chu'a'lor. Complete \"The Crystals\"\n"
					.."then talk to Torkus and complete \"Our Boy wants...\" then\n"
					.."go to Chu'a'lor and complete \"The Skyguard Outpost\" then\n"
					.."talk to Sky Commander Keller -> Vanderlip and complete\n"
					.."\"Bombing Run\". Only now is the daily \"Bomb Them Again\"\n"
					.."available. Use your Fresh/Preserved Holly now!" },
}
points[ 114 ] = { -- Borean Tundra
	[40205500] = { aIDH=1685, indexH=2, tip="Go to the ground floor. He pats through here" },
	[31003000] = { aID=277, tip="Don't forget to set \"Heroic\". You\n"
										.."need both The Nexus and The Oculus" },
}
points[ 127 ] = { -- Crystalsong Forest
	[29563287] = { aID=1690, tip=dance },
	[27003850] = { aID=252, tip="Winter Wondervolt machine" },
}
points[ 125 ] = { -- Dalaran
	-- Dalaran will not show in Crystalsong Forest but it will propagate upwards
	[24203880] = { vendor=true, tip=blizzPoetry },
	[49394373] = { aID=252, tip="Winter Wondervolt machine" },
	[49832909] = { aID=1690, tip=dance },
}
points[ 89 ] = { -- Darnassus
	[39204320] = { vendor=true, tip=blizzPoetry },
	[44048492] = { aIDH=4437, indexH=3, tip="3) Two guards here. Go up this ramp" },
	[42977300] = { aIDH=4437, indexH=3, tip="1) Entrance is this way. Two guards, blow\n"
										.."your invisibility here and pause at the\n"
										.."next marker for a refresh" },
	[42977428] = { aIDH=4437, indexH=3, tip="5) Upstairs. Along the mezzanine perimeter are\n"
										.."more guards at intervals. Aside from invisibility\n"
										.." you'll just need to soldier on, die and rez" },
	[43808505] = { aIDH=4437, indexH=3, tip="4) Two guards here at the top of the ramp. Turning\n"
										.."right is a little more optimal than a left. There\n"
										.."is no longer an opportunity to wait out a CD so\n"
										.."delaying any rez will be optimal in that respect" },
	[46508027] = { aIDH=4437, indexH=3, tip="2) A safe place to wait out cooldowns. You'll\n"
										.."now have one more chance to go invisible" },
	[43017807] = { aIDH=4437, indexH=3, tip="6) Upstairs. Exact location of the High Priestess.\n"
										.."Use a \"tar tyrande\" macro and as soon as you\n"
										.."\"pelt\" surge straight past her and fall into\n"
										.."the shallow pool below for zero fall damage.\n"
										.."No guards here. Spin around 180 degrees and run\n"
										.."forward, veering left to avoid the two guards at\n"
										.."the exit. With luck you'll be okay to hearth but\n"
										.."certainly in a good place to rez" },
}
points[ 27 ] = { -- Dun Morogh
	[60333394] = { aID=252, tip="Winter Wondervolt machine" },
	[39804480] = { aID=1690, tip="The \"Holdiay Snow\" mounds contain 3-6 snowballs." },
	[63505550] = { aID=1690, tip="The \"Holdiay Snow\" mounds contain 3-6 snowballs." },
	[48204150] = { aID=1690, tip="The \"Holdiay Snow\" mounds contain 3-6 snowballs." },
	[59303200] = { questA=7043, tip="Wulmort Jinglepocket" ..vendor .."\n\n"
									.."A daily is also offered, leading to the \"On Metzen!\"\n"
									.."and \"Simply Abominable\" achievements" },
	[60813290] = { aIDH=5854, indexH=3, tip="Here is a safe place. It's above the Gates of Ironforge" },
	[63503400] = { aIDA=277, tip=threeSet },
	[63503100] = { aIDA=1688, tip=gourmet },
	[63502800] = { aIDA=10353, tip=armada },
	[59203010] = { aIDH=4437, indexH=1, tip="Fly in and stay up as high as possible. Use a small,\n"
										.."stable mount for best visibilty and clearance" },
}
points[ 1 ] = { -- Durotar
	[44000210] = { aID=252, tip="Winter Wondervolt machine" },
	[46530618] = { questH=6983, tip="Penny Copperpinch" ..vendor .."\n\n"
									.."A daily is also offered, leading to the \"On Metzen!\"\n"
									.."and \"Simply Abominable\" achievements" },
	[50000980] = { aIDH=5854, indexH=1, tip="The Hyjal portal might be an option for you. Fly\n"
										.."over to Teldrassil via Darkshore. Speak to Zidormi\n"
										.."if Teldrassil is destroyed!" },
	[50000980] = { aIDH=5854, indexH=2, tip="The Hyjal portal might be an option for you. Fly\n"
										.."over to Teldrassil via Darkshore. Speak to Zidormi\n"
										.."if Teldrassil is destroyed! Then look\n"
										.."for the Azuremyst Isle portal at the wharves" },
	[42000980] = { aIDH=5854, indexH=4, tip="The Zeppelin to Grom'gol is your best bet" },
	[42000980] = { aIDH=5854, indexH=3, tip="The Zeppelin to Grom'gol is your best bet" },
	[46000980] = { aIDH=1688, tip=gourmet },
	[44000980] = { aIDH=10353, tip=armada },
	[48000980] = { aIDH=277, tip=threeSet },
}
points[ 47 ] = { -- Duskwood
	[11605000] = { aIDA=1688, tip="Best place for Alliance to farm small eggs.\n"
										.."Drop rate is about 2/3rds from the barn owls" },
}
points[ 70 ] = { -- Dustwallow Marsh
	[67394741] = { aIDA=1686, indexA=3, tip="Speak to Zidormi if you can't find him" },
}
points[ 23 ] = { -- Eastern Plaguelands
	[75465322] = { aIDA=5853, indexA=2, tip="There is a direct flightpath from Ironforge to\n"
										.."Light's Hope Chapel. If possible continue\n"
										.."flying into Ghostlands and follow the markers" },
}
points[ 37 ] = { -- Elwynn Forest
	[41086595] = { aIDA=1686, indexA=2, tip="He's at the Blacksmith building" },
	[22202290] = { aIDA=1686, tip="Various Brothers at the Cathedral" },
	[30003050] = { aID=252, tip="Winter Wondervolt machine" },
	[24503220] = { vendor=true, tip="Khole Jinglepocket" ..vendor },
	[20475698] = { aIDH=5854, indexH=4, tip="Here is a safe place" },
	[36910742] = { aIDH=5854, indexH=4, tip="Here is a safe place" },
	[35003700] = { aIDA=277, tip=threeSet },
	[35003400] = { aIDA=1688, tip=gourmet },
	[35003100] = { aIDA=10353, tip=armada },
}
points[ 94 ] = { -- Eversong Woods
	[54504654] = { vendor=true, tip="Hotoppik Jinglepocket" ..vendor },
	[56435164] = { aID=252, tip="Winter Wondervolt machine" },
	[52542968] = { aIDA=5853, indexA=2, tip="Don't bother with the old \"crack in the wall\" exploit.\n"
										.."I tried it for testing. There is an invisible wall.\n"
										.."Baby Spice will not help too." },
	[56654980] = { aIDA=5853, indexA=2, tip="Without invisibility you will draw agro. Better to die/\n"
										.."rez as per marker as there are more guards inside too!" },
	[62076312] = { aIDA=5853, indexA=2, tip="Farstrider Retreat will be to your left." },
	[61865339] = { aIDA=5853, indexA=2, tip="Come this way. Thuron's Livery on your left." },
	[44347124] = { aIDA=5853, indexA=2, tip="This is where you will rez, if you were wondering.\n"
										.."Fairbreeze Village. Yeah... I took a hit for the team." },
	[59305160] = { aIDH=1688, tip="Best place for Horde to farm small eggs.\n"
										.."Drop rate is 100% from the dragonhawks" },
	[57205050] = { aIDA=4436, indexA=2, tip="Two guards and up ahead many more. Use invisibility.\n"
										.."For details on how to get here please see the\n"
										.."\"A-Caroling We Will Go\" markers" },
}
points[ 95 ] = { -- Ghostlands
	[72606400] = { aIDA=5853, indexA=2, tip="Start here at the Zul'Aman flight point. If that is not possible\n"
										.."then begin at Light's Hope Chapel in the Eastern Plaguelands" },
	[69503080] = { aIDA=5853, indexA=2, tip="From Zul'Aman ride up to here. Stay on the left side of\n"
										.."Lake Elrendar. Continue north into Eversong Woods" },
}
points[ 25 ] = { -- Hillsbrad Foothills
	[43503880] = { aID=273, tip="The Abominable Greench needs to be slayed.\nWait a while for a respawn" },
	[43904090] = { aID=1687, tip="Try hanging out here, but Dalaran works too!" },
	[50002260] = { aID=1690, tip="The \"Holdiay Snow\" mounds contain 3-6 snowballs." },
	[45903650] = { aID=1690, tip="The \"Holdiay Snow\" mounds contain 3-6 snowballs." },
}
points[ 118 ] = { -- Icecrown
	[69404240] = { aIDH=1685, indexH=3, tip="He's on Orgrim's Hammer, a huge flying airship.\n"
										.."Check your map for the current location" },
}
points[ 87 ] = { -- Ironforge
	[26005840] = { vendor=true, tip=blizzPoetry },
	[33586794] = { questA=7043, tip="Wulmort Jinglepocket" ..vendor .."\n\n"
									.."A daily is also offered, leading to the \"On Metzen!\"\n"
									.."and \"Simply Abominable\" achievements" },
	[16128462] = { aIDH=5854, indexH=3, tip="Here is a safe place. It's above the Gates of Ironforge" },
	[39675542] = { aIDH=4437, indexH=1, tip="Sure, blast Muradin until you \"pelt\" him but consider\n"
										.."your exit strategy. You need to be close to that side\n"
										.."passage so use your range and back-up ASAP. Once he\n"
										.."is tagged then use invisibility if you have it and get\n"
										.."to that side passage for hearthing or a mount and dash" },
	[45755272] = { aIDH=4437, indexH=1, tip="Try to die as close as possible to here so that\n"
										.."you may rez safely down in the side passage" },
	[45324853] = { aIDH=4437, indexH=1, tip="Descend to here and enter \"The High Seat\" chamber" },
	[37356678] = { aIDH=4437, indexH=1, tip="Fly over to this tunnel. Wait out your\n"
										.."invisibility cooldown if necessary" },
	[12918923] = { aIDH=4437, indexH=1, tip="Fly in and stay up as high as possible. Use a small,\n"
										.."stable mount for best visibilty and clearance" },
	[24107473] = { aIDH=4437, indexH=1, tip="There is a high up ledge here. Safe\n"
										.."to pause and say your last prayers" },
	[34006000] = { aIDA=1688, tip=gourmet },
	[34005700] = { aIDA=10353, tip=armada },
	[34006300] = { aIDA=277, tip=threeSet },
	[54004800] = { aIDA=5853, indexA=2, tip="There is a direct flightpath from Ironforge to\n"
										.."Light's Hope Chapel. If possible continue\n"
										.."flying into Ghostlands and follow the markers" },
	[54005100] = { aIDA=5853, indexA=4, tip="Just fly straight up to the Sewer entrance as marked" },
	[58254700] = { aIDA=5853, indexA=1, tip="Probably best to fly to Menethil Harbour,\n"
										.."boat to Kalimdor and then as per markers" },
	[56905050] = { aIDA=5853, indexA=3, tip="Probably best to fly to Menethil Harbour,\n"
										.."boat to Kalimdor and then as per markers" },
}
points[ 198 ] = { -- Mount Hyjal
	[56002000] = { aIDH=5854, tip="From Nordrassil fly over to Darkshore.\n"
										.."You may need to speak to Zidormi" },
}
points[ 7 ] = { -- Mulgore
	[39003100] = { 1, 1, tip="Seersa Copperpinch" ..vendor .."\n"
									.."Alliance, if quick, can buy the Green Winter Clothes\n"
									.."pattern before you die" },
	[42003400] = { aIDA=5853, indexA=3, tip="Just fly in and land on the very edge\n"
										.."of any of the mesas. Easy peasy!\n" ..caroling },
}
points[ 50 ] = { -- Northern Stranglethorn
	[47251110] = { aIDA=1686, indexA=1 },
}
points[ 85 ] = { -- Orgrimmar
	[52687728] = { questH=6983, tip="Penny Copperpinch" ..vendor .."\n\n"
									.."A daily is also offered, leading to the \"On Metzen!\"\n"
									.."and \"Simply Abominable\" achievements" },
	[70007000] = { aIDA=5853, indexA=1, tip="Fly in and land up high at the perimeter. Easy as!\n" .. caroling },
	[56606800] = { aIDH=10353, tip=armada },
	[56607400] = { aIDH=277, tip=threeSet },
	[50256215] = { aID=252, tip="Winter Wondervolt machine" },
	[51133829] = { aIDH=5854, indexH=2, tip="The Hyjal portal might be an option for you. Fly\n"
										.."over to Teldrassil via Darkshore. Speak to Zidormi\n"
										.."if Teldrassil is destroyed! Then look for the\n"
										.."Azuremyst Isle portal at the wharves" },
	[55005334] = { aIDH=5854, indexH=4, tip="The Zeppelin to Grom'gol is your best bet" },
	[55005334] = { aIDH=5854, indexH=3, tip="The Zeppelin to Grom'gol is your best bet" },
	[56607100] = { aIDH=1688, tip=gourmet },
	[57306810] = { vendor=true, tip=blizzPoetry },
	[58806040] = { aIDH=4437, tip="Blax Bottlerocket" ..airRifle  },
	[58605380] = { aIDH=4437, tip="Blax Bottlerocket" ..airRifle },
	[55487852] = { aIDA=4436, indexA=3, tip="If finished and invisible then run to here\n"
										.."and hearth. It's a nook behind the AH" },
	[48047028] = { aIDA=4436, indexA=3, tip="Eitrigg is here. There's no sugar coating this...\n"
										.."you'll die and it may take a few tries if you\n"
										.."luck out with the \"pelt\" buff." },
	[50137633] = { aIDA=4436, indexA=3, tip="Through here. Just inside is an okay spot\n"
										.."to rez or pause if you are lucky. Best\n"
										.."approach is to simply fly in, dropping\n"
										.."down from some height. If nimble then\n"
										.."surge past the chicane and use your\n"
										.."\"/tar Eitrigg\" macro and get that \"pelt\"\n"
										.."before you die. If lucky a quick\n"
										.."invisibility will save you" },
}
points[ 111 ] = { -- Shattrath City
	[80105846] = { aID=252, tip="Winter Wondervolt machine" },
	[51262966] = { vendor=true, tip="Eebee Jinglepocket" ..vendor },
	[60903350] = { vendor=true, tip=blizzPoetry },
}
points[ 110 ] = { -- Silvermoon City
	[63647932] = { vendor=true, tip="Hotoppik Jinglepocket" ..vendor },
	[66602630] = { vendor=true, tip=blizzPoetry },
	-- Check. Wowhead says not the two patterns or the Hot Apple Cider recipe
	[70708900] = { aIDA=5853, indexA=2, tip="The nearest flightpoint is Zul'Aman in Ghostlands.\n"
										.."Toughest of the four. You will die. Make a dash for\n"
										.."inside then a sharp left and hide as per marker.\n"
										.."Invisibility (Mages/potions) works here.\n" },
	[53792021] = { aIDA=4436, indexA=2, tip="He's right here. Try to pelt him from ranged\n"
										.."as he has a lot of guards behind him. Decide\n"
										.."where you will hearth (after invis/rez). The\n"
										.."translocation room at the rear or the earlier\n"
										.."side room (with trainer NPCs)" },
	[74405860] = { aIDA=4436, indexA=2, tip="Pinch point. The two pats are in opposite directions\n"
										.."and you lose all visibility here. Wait at the earlier\n"
										.."marker to gain a sense of timing" },
	[69956595] = { aIDA=4436, indexA=2, tip="A couple of pats come through the Walk of Elders.\n"
										.."You could try hiding in here with the vendors" },
	[73645221] = { aIDA=4436, indexA=2, tip="A couple of pats come through Murder Row.\n"
										.."You can pause over to the side as necessary" },
	[59283759] = { aIDA=4436, indexA=2, tip="Wait out your invisibility/hearth cooldown here" },
	[72298479] = { aIDA=4436, indexA=2, tip="So many guards here. Invisibility" },
	[72644365] = { aIDA=4436, indexA=2, tip="2 guards here. Invisibility" },
	[61532949] = { aIDA=4436, indexA=2, tip="12 nasty guards up ahead. Now is the time to go invisible" },
	[50661633] = { aIDA=4436, indexA=2, tip="No guards here. A good place to hearth from invisibility" },
	[54422662] = { aIDA=4436, indexA=2, tip="The side rooms are safe for hiding and hearthing.\n"
										.."The NPCs here are all trainers. Also, if you used\n"
										.."invisibility to enter then wait out the CD here" },
	[72299178] = { aIDA=4436, indexA=2, tip="Two guards and up ahead many more. Use invisibility" },
}
points[ 84 ] = { -- Stormwind City
	[68057148] = { aID=252, tip="Winter Wondervolt machine" },
	[62807005] = { vendor=true, tip="Khole Jinglepocket" ..vendor },
	[55045417] = { aIDA=1686, indexA=4, tip="" },
	[49514522] = { aIDA=1686, indexA=5, tip=brothers },
	[52604392] = { aIDA=1686, indexA=6, tip="Go downstairs.\n" ..brothers },
	[52414580] = { aIDA=1686, indexA=7, tip=brothers },
	[52104760] = { aIDA=1686, indexA=8, tip="He pats up and down here.\n" ..brothers },
	[51003500] = { aIDA=277, tip=threeSet },
	[51003200] = { aIDA=1688, tip=gourmet },
	[51002900] = { aIDA=10353, tip=armada },
	[51749780] = { aIDH=5854, indexH=4, tip="There is a safe place off the map, due south but still in Stormwind" },
	[84530997] = { aIDH=5854, indexH=4, tip="Here is a safe place" },
	[56607040] = { aIDA=4436, tip="Craggle Wobbletop" ..airRifle },
	[64606140] = { aIDA=4436, tip="Craggle Wobbletop" ..airRifle },
	[73006900] = { aIDA=5853, indexA=2, tip="There is a direct flightpath from Ironforge to\n"
										.."Light's Hope Chapel. If possible continue\n"
										.."flying into Ghostlands and follow the markers" },
	[73908250] = { vendor=true, tip=blizzPoetry },
	[74007200] = { aIDA=5853, indexA=4, tip="Just fly straight up to the Sewer entrance as marked" },
	[73007430] = { aIDA=5853, indexA=1, tip="Probably best to fly to Booty Bay, boat\n"
										.."to Kalimdor and then as per markers" },
	[71207050] = { aIDA=5853, indexA=3, tip="Probably best to fly to Booty Bay, boat\n"
										.."to Kalimdor and then as per markers" },
}
points[ 224 ] = { -- Stranglethorn Vale
	[37567622] = { aID=252, tip="Winter Wondervolt machine" },
	[48390814] = { aIDA=1686, indexA=1 },
}
points[ 534 ] = { -- Tanaan Jungle
	[88135583] = { aID=10353, index=3, tip="Smashum Grabb spawns here. Every 5 to 10 minutes\n"
											.."but is farmable once per day. Drop rate is about 10%" },
	[80375685] = { aID=10353, index=4, tip="Gondar spawns here. Every 5 to 10 minutes but\n"
											.."is farmable once per day. Drop rate is about 10%" },
	[83454366] = { aID=10353, index=5, tip="Drakum spawns here. Every 5 to 10 minutes but\n"
											.."is farmable once per day. Drop rate is about 10%" },
}
points[ 71 ] = { -- Tanaris
	[52522806] = { aID=252, tip="Winter Wondervolt machine" },
}
points[ 57 ] = { -- Teldrassil
	[55008810] = { aIDH=5854, indexH=1, tip="Fly through the pink portal and press your\n"
										.."up key (spacebar) to fly straight up in Darnassus\n"
										.."and then perch on a high safe ledge" },
	[52288947] = { aIDH=5854, indexH=2, tip="The portal to Azuremyst Isle" },
	[26224308] = { aIDH=5854, indexH=1, tip="From your safe vantage point you can now reverse\n"
										.."the procedure if you don't want to wait out a hearth\n"
										.."cooldown. As soon as you take the pink portal down,\n"
										.."surge forward and up as the guards will instantly\n"
										.."hit you and you'll not want a dismount" },
}
points[ 210 ] = { -- The Cape of Stranglethorn
	[40356756] = { aID=252, tip="Winter Wondervolt machine" },
}
points[ 103 ] = { -- The Exodar
	[64006000] = { vendor=true, tip=blizzPoetry },
	[79795530] = { aID=252, tip="Winter Wondervolt machine" },
	[55824883] = { vendor=true, tip="Wolgren Jinglepocket" ..vendor },
	[41437425] = { aIDH=5854, indexH=2, tip="It is sufficient to stand here" },
	[32865450] = { aIDH=4437, indexH=2, tip="The Prophet is right here. Get that \"pelt\"\n"
										.."and die. Nothing could be simpler" },
	[31486188] = { aIDH=4437, indexH=2, tip="Two guards here, three at the top of the stairs.\n"
										.."Then take a hard right. a \"/tar Prophet Velen\"\n"
										.."macro would be most useful. Spam it from now" },
	[42107240] = { aIDH=4437, indexH=2, tip="Enter The Exodar this way" },
	[37405993] = { aIDH=4437, indexH=2, tip="No guards through here. Pause for any cooldowns" },
	[26354940] = { aIDH=4437, indexH=2, tip="Safe to respawn and hearth/portal from here" },
	[35127476] = { aIDH=4437, indexH=2, tip="Two guards here. Left 90 degrees, jump down,\n"
										.."straight forward, bearing left a little" },
}
points[ 129 ] = { -- The Nexus
	[27503420] = { aID=277, tip="You need Grand Magus Telestra. Must be Heroic!" },
	[31507440] = { aID=277, tip="Go this way!" },
}
points[ 143 ] = { -- The Oculus
	[63004200] = { aID=277, tip="You need Mage-Lord Urom, the 3rd boss. Must be Heroic!" },
}
points[ 88 ] = { -- Thunder Bluff
	[42005520] = { vendor=true, tip="Seersa Copperpinch" ..vendor .."\n"
									.."Alliance, if quick, can buy the Green Winter Clothes\n"
									.."pattern before you die" },
	[72504780] = { vendor=true, tip=blizzPoetry },
	[63003300] = { aIDA=5853, indexA=3, tip="Just fly in and land on the very edge\n"
										.."of any of the mesas. Easy peasy!\n" ..caroling },
}
points[ 18 ] = { -- Tirisfal Glades
	[61105929] = { aID=252, tip="Winter Wondervolt machine" },
	[63197694] = { aIDA=5853, indexA=4, tip="Do NOT try to descend into Undercity. Land on a dome\n"
										.."in the ruins. This dome is fine. The largest one too.\n" ..caroling },
	[51607070] = { aIDA=5853, indexA=4, tip="The sewer entrance works perfectly fine.\n"
										.."Stop entering when the Undercity map appears.\n" ..caroling },
	[60006900] = { aIDH=1685, indexH=1, tip="Descend into Undercity" },
	[51037152] = { aIDA=4436, indexA=1, tip="Enter Undercity through the Sewers. No guards here" },
}
points[ 90 ] = { -- Undercity
	[68233886] = { vendor=true, tip="Nardstrum Copperpinch" ..vendor },
	[81605070] = { vendor=true, tip=blizzPoetry },
	[58504390] = { aIDA=5853, indexA=4, tip="Do NOT descend into Undercity" },
	[15203050] = { aIDA=5853, indexA=4, tip="The sewer entrance works perfectly fine.\n"
										.."Stop entering when the Undercity map appears.\n" ..caroling },
	[50862166] = { aIDH=1685, indexH=1, tip="Descend into Undercity" },
	[46722712] = { aIDA=4436, indexA=1, tip="Two guards here. Do not come this way as there's\n"
										.."no chance later to cooldown you invisibility" },
	[23633914] = { aIDA=4436, indexA=1, tip="Relax. No guards in this section. Use a small,\n"
										.."stable mount for best visibility and clearance" },
	[34713321] = { aIDA=4436, indexA=1, tip="Go this way. Guard up ahead" },
	[41433333] = { aIDA=4436, indexA=1, tip="One guard here. Use invisibility" },
	[46944393] = { aIDA=4436, indexA=1, tip="No guards through to here. Pause for\n"
										.."invisibility cooldown if necessary" },
	[52446384] = { aIDA=4436, indexA=1, tip="Enter here. Invisibility is your friend" },
	[45978314] = { aIDA=4436, indexA=1, tip="There are two guards at each archway. Got invisibility?" },
	[54539037] = { aIDA=4436, indexA=1, tip="The Dark Lady is up ahead. Just fire like crazy and die" },
}
points[ 56 ] = { -- Wetlands
	[09236089] = { aID=252, tip="Winter Wondervolt machine" },
}
points[ 83 ] = { -- Winterspring
	[58505730] = { aID=1690, tip="The \"Holdiay Snow\" mounds contain 3-6 snowballs." },
	[41104910] = { aID=1690, tip="The \"Holdiay Snow\" mounds contain 3-6 snowballs." },
}

points[ 12 ] = { -- Kalimdor
	[47001680] = { aIDH=5854, tip="You can easily fly from Darkshore to Teldrassil.\n"
										.."There's a portal to The Exodar at the docks" },
	[42001100] = { aIDH=4437, indexH=3, tip="The High Priestess is in the Temple. There is a\n"
										.."mezzanine inside upon which she is located. You'll\n"
										.."take a ramp upstairs.\n\n"
										.."There is one safe location to wait out cooldowns\n"
										.."once inside then no other opportunities until after\n"
										.."you have hit her.\n\n"
										.."Follow the \"A-Caroling we Will Go\" markers for a\n"
										.."guide on how to get to Darnassus/Teldrassil. Click\n"
										.."on Darnassus from the Teldrassil map for details" },
	[57906130] = { aIDA=4436, indexA=3, tip="You could consider approaching via\n"
										.."Ironforge -> Menethil Harbor -> Theramore.\n"
										.."Eitrigg is in Orgrimmar" },
	[56505040] = { aIDA=4436, indexA=3, tip="You could consider approaching via\n"
										.."Stormwind -> Booty Bay -> Ratchet.\n"
										.."Eitrigg is in Orgrimmar" },
}

points[ 582 ] = { -- Lunarfall Garrison in Draenor
	[41754789] = { vendorA=true, tip="Tradurjo Jinglepocket" ..vendor .."\n\nYou must have a level 3 garrison" },
	[43755100] = { questA=39651, tip="Almie " ..almiePizzle },
	[41105050] = { aIDA=10353, tip=armada },
}
points[ 539 ] = { -- Shadowmoon Valley in Draenor
	[29901740] = { vendorA=true, tip="Tradurjo Jinglepocket" ..vendor .."\n\nYou must have a level 3 garrison" },
	[31001400] = { questA=39651, tip="Almie " ..almiePizzle },
	[30201550] = { aIDA=10353, tip=armada },
}
points[ 590 ] = { -- Frostwall Garrison in Draenor
	[50653236] = { vendorH=true, tip="Tradurjo Jinglepocket" ..vendor .."\n\nYou must have a level 3 garrison" },
	[47173796] = { questH=39651, tip="Pizzle " ..almiePizzle },
	[48703530] = { aIDH=10353, tip=armada },
}
points[ 525 ] = { -- Frostfire Ridge in Draenor
	[48556369] = { vendorH=true, tip="Tradurjo Jinglepocket" ..vendor .."\n\nYou must have a level 3 garrison" },
	[48376495] = { questH=39651, tip="Pizzle " ..almiePizzle },
	[48606420] = { aIDH=10353, tip=armada },
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
scaling[19] = 0.48
scaling[20] = 0.48
