local _, NetherwingEggs = ...
local points = NetherwingEggs.points
local textures = NetherwingEggs.textures
local scaling = NetherwingEggs.scaling

local diemetradons = "Diemetradons always drop\nthe glands that you need.\nTwelve required.\n\n(Pickup the quest at the Ledge)"
local foreman = "The foreman pats around here. He\noffers an \"okay\" daily! Hey, wait a\nminute... am I seeing double?"
local mordenai = "This is the first Netherwing \nfaction quest.\n\nSpeak to Mordenai, who\npats along this path.\n\n"
				.."Sometimes he'll dash to a\nnearby Rocknail mob"
local mordenai2 = "This will almost conclude the initial Netherwing\nfaction quests, at least in this part of the Valley.\n\n"
				.."Speak to Mordenai, who pats along this path.\n\nSometimes he'll dash to a nearby Rocknail mob.\n\n"
				.."Completion of this quest now allows farming of\neggs so quickly go back to the Fortress and\n"
				.."grab any eggs you saw there previously! ;)\n\n(Quests on the Ledge are still not available\n"
				.."although the faction members are now \"green\")"
local mordenai3 = "Speak to Mordenai, who\npats along this path.\n\nSometimes he'll dash to a\nnearby Rocknail mob"			
local neltharaku =  "Fly up to about the level of the nearby peaks.\nThis is where you pickup and hand-in for the\n"
				.."next several quests"
local neltharaku2 = "Neltharaku will be patrolling around here.\nPickup and hand-in with Neltharaku"
local neltharaku3 = "Neltharaku will be patrolling around here.\nPickup (only) with Neltharaku"
local neltharaku4 = "As per before in locating and targeting Neltharaku.\nThe Fortress is where I've already placed some pins\n"
				.."for farming eggs (much later!). Locate Neltharaku\nagain when you're done"
local neltharakuVines = "As per before in locating and targeting Neltharaku.\nThe crystals are on the ground at the base of the large\n"
				.."crystal formations. They will be bright and orange/red.\nThis is the fifth quest, you're almost halfway! :).\n\n"
				.."Curiously, if you have \"Find Minerals\" then enable\nit for easy farming. Yeah, I know... it looks like a vine\n"
				.."(i.e. Find Herbs) but, whatver!"
local sludgeCovered = "The Black Blood of Draenor, those oily\nlooking things that ooze along the ground,\ndrop Sludge-Covered Objects and a quest\n"
					.."starter might be inside. The Flayers also\nhave a tiny chance. They are everywhere.\nThe bursters, which are giant worms, also\n"
					.."have a tiny chance"
				
points[ NetherwingEggs.valley ] = {

	[63968740] = { insideMine=true, tip="In the Wheelbarrow" },
	[64098403] = { insideMine=true, tip="At the souther side and rear of the alcove. 1 to 2 yards\ntowards the rear, behind two rocks. Easily missed" },
	[64198674] = { insideMine=true, tip="Immediately in front of two side-by-side crates" },
	[64588643] = { insideMine=true, tip="In a mining cart, the first of which you encounter\nat the rail junction after the entrances" },
	[64608732] = { insideMine=true, tip="Centred between a wooden cask and a line\nof two oil drums. A large crate is to its west" },
	[64668312] = { insideMine=true, tip="On the workers platform, at the end with seats and crates.\nCentred, on the western side of three rope coils" },
	[64758520] = { insideMine=true, tip="Just east of two drums, on the west\nside of the main mine thoroughfare" },
	[64928377] = { insideMine=true, tip="In between a large square crate and some drums.\n(A quest cargo cart can spawn immediately north of it)" },
	[65068213] = { insideMine=true, tip="Adjacent to a short beam,\nwith lots of clutter nearby" },
	[65168586] = { insideMine=true, tip="On the immediate northern side of three green \"XX\" grog containers" },
	[65178491] = { insideMine=true, tip="In the last minecart, coming from the\nentrances, before the rail line divides" },
	[65468866] = { insideMine=true, tip="Inside a broken minecart near the entrance.\nThe second cart after the entrance. Not on rails" },
	[65638773] = { insideMine=true, tip="North-west side of a boulder\nattached to the wall" },
	[65968055] = { insideMine=true, tip="End of an alcove. At the south-west side\nof the head of a digging machine" },
	[66288222] = { insideMine=true, tip="Adjacent to the north-east\ncorner of a supporting beam" },
	[66928201] = { insideMine=true, tip="On the western side of a crushing wheel's feeder chute,\nbetween an empty carriage and a supporting beam" },
	[67157962] = { insideMine=true, tip="End of an alcove, ten yards from two solitary drums" },
	[67278623] = { insideMine=true, tip="Towards the southern edge and near the end of this alcove,\nclose to a shovel and also nearby \"XX\" grog containers" },
	[67878737] = { insideMine=true, tip="About 12 yards south-west from a rotary\ndigging machine, near the end of the alcove" },
	[67888544] = { insideMine=true, tip="Near the south-western corner of\na mine cart with a missing side" },
	[67958247] = { insideMine=true, tip="A relatively quiet corner.\nEasy to see from far away" },
	[68317932] = { insideMine=true, tip="End of an alcove, 5 yards behind\na hiding Murkblood Overseer" },
	[68628290] = { insideMine=true, tip="Near the ledge, several yards west of a supporting beam" },
	[68688362] = { insideMine=true, tip="Elevated rail tracks. West of a carriage" },
	[68838579] = { insideMine=true, tip="On the rail tracks, on the northern side of the third\nempty carriage as you ascend the curving track" },
	[68898358] = { insideMine=true, tip="Adjacent to the western side of a\nminecart with a broken axle. Directly\nbelow the elevated rail track" },
	[69068137] = { insideMine=true, tip="Close to the wall, between two of three trowels / shovels" },
	[69108822] = { insideMine=true, tip="Towards the rear of the alcove, at the head\nof and a yard or two south-west of a digger" },
	[69268432] = { insideMine=true, tip="On the eastern side of a beam,\n north-west of a pick axe" },
	[69338656] = { insideMine=true, tip="Between a cask, green \"XX\" grog\ncontainer, two crates and a rope coil" },
	[69468006] = { insideMine=true, tip="End of an alcove, exactly 15 yards\nbehind a hiding Murkblood Overseer" },
	[69858208] = { insideMine=true, tip="On the rails. Approaching from the west, it is\nimmediately in front of the second carriage" },
	[70218812] = { insideMine=true, tip="Almost bisecting two rope coils on the\nnorthern side of several large crates,\nseveral drums and other rope coils" },
	[70278392] = { insideMine=true, tip="Alongside four minecarts, a few\nyards west of a rail junction" },
	[70408697] = { insideMine=true, tip="On the western side of and half-way between\nthe two larger crates of a set of three. Also,\nsouth-west of a drum" },
	[70718568] = { insideMine=true, tip="Just one or two yards north-west from a wheelbarrow.\nElevated, interconnecting passage with two hostile mobs" },
	[70888218] = { insideMine=true, tip="Between three casks, closest to the\nsingleton east of the other two" },
	[71058081] = { insideMine=true, tip="End of the alcove between the western\npoint of a digger and the rock wall" },
	[71148469] = { insideMine=true, tip="On this short rail bridge. More towards\nthe western end, southern edge" },
	[71558410] = { insideMine=true, tip="On the south-eastern side of the railway line,\nnear the ledge and adjacent to a beam" },
	[71588129] = { insideMine=true, tip="At the head of a digging device,\na little to its southern side" },
	[72248790] = { insideMine=true, tip="At the foot of the chute of a large ore\ncrushing wheel in Toranaku's area" },
	[72278638] = { insideMine=true, tip="On the northern side of a sloping beam. The\nbeam points directly towards the dragon\n"
						.."Toranaku, to the south-east. (If approaching\nvia Ronag, you cannot see the egg)" },
	[72508373] = { insideMine=true, tip="South-east side of a supporting\nbeam. A Murkblood miner corpse\nis 7-8 yards south-south-west" },
	[72648886] = { insideMine=true, tip="Centrally placed in the ore chute\nfeeding into the huge crushing wheel" },
	[72829032] = { insideMine=true, tip="In the larger of the two worker areas. 6 to 16 yards south\nfrom the Crazed Murkblood Foreman's patrol path" },
	[72898217] = { insideMine=true, tip="In this alcove. Immediately behind a digging machine\nand exactly 5 yards from a Murkblood Overseer" },
	[73218428] = { insideMine=true, tip="Inside a mine cart on rails,\nthe only cart in this area" },
	[73308573] = { insideMine=true, tip="Wedged between four crates" },
	[73588511] = { insideMine=true, tip="In a mining cart. In the northern-most\nof a set of three carts" },
	[73808599] = { insideMine=true, tip="Inside a singleton minecart on rails. A pair of minecarts\nare further along the rails to the south-south-east" },
	[73978306] = { insideMine=true, tip="Almost exactly equidistant from two oil\ndrums and a wooden digging machine" },
	[74068587] = { insideMine=true, tip="Adjacent to a pillar, northern side" },
	[74318974] = { insideMine=true, tip="A yard or two on the western side of a digger,\nsouth of a Crazed Murkblood Foreman's patrol area" },
	[74348729] = { insideMine=true, tip="On the eastern side of the tunnel, north-east\nof a barrel, a yard or two from the wall" },
	[74588840] = { insideMine=true, tip="Adjacent to and south-east from a coil of rope. A\nCrazed Murkblood Miner patrols nearby.\n"
						.."A drum is west and a large rotary digger is east" },
	[74618466] = { insideMine=true, tip="Two yards west of an oil drum\nand 6 yards east of two oil drums" },
	[75198645] = { insideMine=true, tip="Alongside a digging device" },

	[59847826] = { tip="12 to 13 yards from the north-east edge\nof the crystal formation on this island" },
	[60218708] = { tip="Near the western edge of the crystal formation on this island.\nAbout 6 to 7 yards south of a Dragonmaw Peon" },
	[62308947] = { tip="About five yards from the southern base of\na crystal cluster on this very high island" },
	[62807478] = { tip="About five yards from the southern side\nof the crystal cluster on this island" },
	[63448289] = { tip="At the base of a crystal cluster, eastern\nedge towards a southern corner. Easily\nmissed from above" },
	[63948604] = { tip="On the east-south-east side of a crystal cluster.\nA Peon sometimes spawns alongside the egg.\n"
						.."A guard tower is directly behind / south-east" },
	[64929095] = { tip="35 yards south-west from the eastern\nMistress of the Mines / mine entrance" },
	[65498475] = { tip="At foot of slope, a little more than 15\nyards from Captain Skyshatter's mount" },
	[65688419] = { tip="On the north-east face of one of\nthe largest and highest crystals" },
	[65689408] = { tip="South-south-east side of the crystal formation.\nSeveral yards away in clear space" },
	[66108388] = { tip="Very top of this hill" },
	[66929153] = { tip="South-south-west side of this crystal cluster,\nclose to its base. Take care if using a large mount" },
	[67226134] = { tip="On a crate in the cart near the front entrance of the Fortress" },
	[67246236] = { tip="Lower level Fortress tower (more southern)" },
	[68055974] = { tip="Lower level Fortress tower (more northern)" },
	[68138182] = { tip="A few yards south west of the centre\nof the peak. It is safest to land at the\ntop and reach down to the egg" },
	[68149467] = { tip="Southern side of the base of\nthis island crystal cluster" },
	[68295981] = { tip="In this triangular crevice of the wall, 11.5 yards\nnorth-west from an Enslaved Netherwing Drake" },
	[68536115] = { tip="Netherwing drake stables. Approaching from\nthe entrance, the second stall on the left" },
	[68876249] = { tip="Broken hut, towards the rear, between\nthe angled wooden beam and the shaman" },
	[69386377] = { tip="Top level of Fortress shaman tower" },
	[69625854] = { tip="Fortress Nursery. The egg location\ntrisects the three bloody meat piles" },
	[69678434] = { tip="At the north-east side of\nthe crystal formation" },
	[70076201] = { tip="Top level Fortress tower (more southern)" },
	[70086030] = { tip="Top level Fortress tower (more northern)" },
	[70518397] = { tip="Southern side of this crystal formation,\nvery close to its base. In the patrol\npath of Barash" },
	[70916264] = { tip="Eastern side of the round Fortress room with a\nhole in the roof. This is the upper level room" },
	[70948145] = { tip="At the top of this large peak" },
	[70968911] = { tip="At the very top of this peak" },
	[71376074] = { tip="Very centre of the round (more northern) Fortress\nroom. On a pedestal. Easily seen from the doorway" },
	[71458645] = { tip="At the very base of the eastern\nside of the crystal formation" },
	[72598373] = { tip="On a narrow raised ledge, north-east\nof and at the base of some crystals" },
	[73358715] = { tip="Top of this hump, about one yard west of the very top.\nStanding exactly here, you might slide down the hill" },
	[73429035] = { tip="Very top of this hump" },
	[74208239] = { tip="Halfway up the eastern side of\nthe hill, on a flatter section" },
	[74288554] = { tip="At the base of a crystal cluster. Northern\nedge and just as the ground begins to rise" },
	[75228248] = { tip="In a narrow crevice at the\nbase of the cluster of crystals" },
	[75658606] = { tip="Northern side of the crystals, just\na couple of yards from the base" },
	[75769165] = { tip="Centre of this tiny island, a\nlittle towards the eastern edge" },
	[76068134] = { tip="On the Dragonmaw Transporter launch platform.\nIf approaching from the Fortress side, on the right\n"
						.."behind three crates. Beware 2 x Elites!" },
	[76408566] = { tip="At the base of a crystal cluster. Northern\nedge and just as the ground begins to rise" },
	[76558335] = { tip="In the mouth of the skeleton" },
	[77269548] = { tip="Near the northern edge of the\ncrystal formation on this island" },
	[77368586] = { tip="Very top of this peak" },
	[77619255] = { tip="Western side of the north-western crystal\ncluster on Or'kaos the Insane's island" },
	[78108112] = { tip="Very top of this peak" },
	[78828644] = { tip="Approximately 5 yards east from a crystal\ncluster. Exposed area, easily seen" },
	[78867961] = { tip="On top of this crystal. Careful! On the southern-\nmost landable edge, far from the \"point\", almost\nas far as its southern most angle" },
	[78888334] = { tip="On the smallest of the crystals in the cluster.\nDismount directly above at 78.88,83.34!\nUse your Hearthstone if you get stuck!" },
	[79588800] = { tip="Western edge of this crystal formation.\nAny closer to the crystals and you will\nfall sharply down into a crevice" },
	
	[59325870] = { quests={ { quest=10804, tip=mordenai }, { quest=11012, showAfter=10870, tip=mordenai2 }, { quest=11013, showAfter=11012, tip=mordenai3 } } },
	[60015874] = { quests={ { quest=10804, tip=mordenai }, { quest=11012, showAfter=10870, tip=mordenai2 }, { quest=11013, showAfter=11012, tip=mordenai3 } } },
	[60725884] = { quests={ { quest=10804, tip=mordenai }, { quest=11012, showAfter=10870, tip=mordenai2 }, { quest=11013, showAfter=11012, tip=mordenai3 } } },
	[61345913] = { quests={ { quest=10804, tip=mordenai }, { quest=11012, showAfter=10870, tip=mordenai2 }, { quest=11013, showAfter=11012, tip=mordenai3 } } },
	[62005956] = { quests={ { quest=10804, tip=mordenai }, { quest=11012, showAfter=10870, tip=mordenai2 }, { quest=11013, showAfter=11012, tip=mordenai3 } } },
	[62585987] = { quests={ { quest=10804, tip=mordenai }, { quest=11012, showAfter=10870, tip=mordenai2 }, { quest=11013, showAfter=11012, tip=mordenai3 } } },
	[63186028] = { quests={ { quest=10804, tip=mordenai }, { quest=11012, showAfter=10870, tip=mordenai2 }, { quest=11013, showAfter=11012, tip=mordenai3 } } },	

	[57235502] = { quests={ { quest=10811, showAfter=10804, tip=neltharaku }, { quest=10814, showAfter=10811, tip=neltharaku }, 
							{ quest=10836, showAfter=10814, tip=neltharaku4 }, { quest=10837, showAfter=10836, tip=neltharakuVines }, 
							{ quest=10854, showAfter=10837, tip=neltharaku2 }, { quest=10858, showAfter=10854, tip=neltharaku3 } } },
	[57605740] = { quests={ { quest=10811, showAfter=10804, tip=neltharaku }, { quest=10814, showAfter=10811, tip=neltharaku }, 
							{ quest=10836, showAfter=10814, tip=neltharaku4 }, { quest=10837, showAfter=10836, tip=neltharakuVines }, 
							{ quest=10854, showAfter=10837, tip=neltharaku2 }, { quest=10858, showAfter=10854, tip=neltharaku3 } } },
	[58465362] = { quests={ { quest=10811, showAfter=10804, tip=neltharaku }, { quest=10814, showAfter=10811, tip=neltharaku }, 
							{ quest=10836, showAfter=10814, tip=neltharaku4 }, { quest=10837, showAfter=10836, tip=neltharakuVines }, 
							{ quest=10854, showAfter=10837, tip=neltharaku2 }, { quest=10858, showAfter=10854, tip=neltharaku3 } } },
	[58985847] = { quests={ { quest=10811, showAfter=10804, tip=neltharaku }, { quest=10814, showAfter=10811, tip=neltharaku }, 
							{ quest=10836, showAfter=10814, tip=neltharaku4 }, { quest=10837, showAfter=10836, tip=neltharakuVines }, 
							{ quest=10854, showAfter=10837, tip=neltharaku2 }, { quest=10858, showAfter=10854, tip=neltharaku3 } } },
	[60235913] = { quests={ { quest=10811, showAfter=10804, tip=neltharaku }, { quest=10814, showAfter=10811, tip=neltharaku }, 
							{ quest=10836, showAfter=10814, tip=neltharaku4 }, { quest=10837, showAfter=10836, tip=neltharakuVines }, 
							{ quest=10854, showAfter=10837, tip=neltharaku2 }, { quest=10858, showAfter=10854, tip=neltharaku3 } } },
	[60415399] = { quests={ { quest=10811, showAfter=10804, tip=neltharaku }, { quest=10814, showAfter=10811, tip=neltharaku }, 
							{ quest=10836, showAfter=10814, tip=neltharaku4 }, { quest=10837, showAfter=10836, tip=neltharakuVines }, 
							{ quest=10854, showAfter=10837, tip=neltharaku2 }, { quest=10858, showAfter=10854, tip=neltharaku3 } } },
	[61396001] = { quests={ { quest=10811, showAfter=10804, tip=neltharaku }, { quest=10814, showAfter=10811, tip=neltharaku }, 
							{ quest=10836, showAfter=10814, tip=neltharaku4 }, { quest=10837, showAfter=10836, tip=neltharakuVines }, 
							{ quest=10854, showAfter=10837, tip=neltharaku2 }, { quest=10858, showAfter=10854, tip=neltharaku3 } } },
	[61945506] = { quests={ { quest=10811, showAfter=10804, tip=neltharaku }, { quest=10814, showAfter=10811, tip=neltharaku }, 
							{ quest=10836, showAfter=10814, tip=neltharaku4 }, { quest=10837, showAfter=10836, tip=neltharakuVines }, 
							{ quest=10854, showAfter=10837, tip=neltharaku2 }, { quest=10858, showAfter=10854, tip=neltharaku3 } } },
	[63006060] = { quests={ { quest=10811, showAfter=10804, tip=neltharaku }, { quest=10814, showAfter=10811, tip=neltharaku }, 
							{ quest=10836, showAfter=10814, tip=neltharaku4 }, { quest=10837, showAfter=10836, tip=neltharakuVines }, 
							{ quest=10854, showAfter=10837, tip=neltharaku2 }, { quest=10858, showAfter=10854, tip=neltharaku3 } } },
	[63365599] = { quests={ { quest=10811, showAfter=10804, tip=neltharaku }, { quest=10814, showAfter=10811, tip=neltharaku }, 
							{ quest=10836, showAfter=10814, tip=neltharaku4 }, { quest=10837, showAfter=10836, tip=neltharakuVines }, 
							{ quest=10854, showAfter=10837, tip=neltharaku2 }, { quest=10858, showAfter=10854, tip=neltharaku3 } } },
	[64346070] = { quests={ { quest=10811, showAfter=10804, tip=neltharaku }, { quest=10814, showAfter=10811, tip=neltharaku }, 
							{ quest=10836, showAfter=10814, tip=neltharaku4 }, { quest=10837, showAfter=10836, tip=neltharakuVines }, 
							{ quest=10854, showAfter=10837, tip=neltharaku2 }, { quest=10858, showAfter=10854, tip=neltharaku3 } } },
	[64835689] = { quests={ { quest=10811, showAfter=10804, tip=neltharaku }, { quest=10814, showAfter=10811, tip=neltharaku }, 
							{ quest=10836, showAfter=10814, tip=neltharaku4 }, { quest=10837, showAfter=10836, tip=neltharakuVines }, 
							{ quest=10854, showAfter=10837, tip=neltharaku2 }, { quest=10858, showAfter=10854, tip=neltharaku3 } } },
	[65646063] = { quests={ { quest=10811, showAfter=10804, tip=neltharaku }, { quest=10814, showAfter=10811, tip=neltharaku }, 
							{ quest=10836, showAfter=10814, tip=neltharaku4 }, { quest=10837, showAfter=10836, tip=neltharakuVines }, 
							{ quest=10854, showAfter=10837, tip=neltharaku2 }, { quest=10858, showAfter=10854, tip=neltharaku3 } } },
	[66295761] = { quests={ { quest=10811, showAfter=10804, tip=neltharaku }, { quest=10814, showAfter=10811, tip=neltharaku }, 
							{ quest=10836, showAfter=10814, tip=neltharaku4 }, { quest=10837, showAfter=10836, tip=neltharakuVines }, 
							{ quest=10854, showAfter=10837, tip=neltharaku2 }, { quest=10858, showAfter=10854, tip=neltharaku3 } } },
	[66856023] = { quests={ { quest=10811, showAfter=10804, tip=neltharaku }, { quest=10814, showAfter=10811, tip=neltharaku }, 
							{ quest=10836, showAfter=10814, tip=neltharaku4 }, { quest=10837, showAfter=10836, tip=neltharakuVines }, 
							{ quest=10854, showAfter=10837, tip=neltharaku2 }, { quest=10858, showAfter=10854, tip=neltharaku3 } } },
	[67775816] = { quests={ { quest=10811, showAfter=10804, tip=neltharaku }, { quest=10814, showAfter=10811, tip=neltharaku }, 
							{ quest=10836, showAfter=10814, tip=neltharaku4 }, { quest=10837, showAfter=10836, tip=neltharakuVines }, 
							{ quest=10854, showAfter=10837, tip=neltharaku2 }, { quest=10858, showAfter=10854, tip=neltharaku3 } } },
	[68206040] = { quests={ { quest=10811, showAfter=10804, tip=neltharaku }, { quest=10814, showAfter=10811, tip=neltharaku }, 
							{ quest=10836, showAfter=10814, tip=neltharaku4 }, { quest=10837, showAfter=10836, tip=neltharakuVines }, 
							{ quest=10854, showAfter=10837, tip=neltharaku2 }, { quest=10858, showAfter=10854, tip=neltharaku3 } } },
	[69046207] = { quests={ { quest=10811, showAfter=10804, tip=neltharaku }, { quest=10814, showAfter=10811, tip=neltharaku }, 
							{ quest=10836, showAfter=10814, tip=neltharaku4 }, { quest=10837, showAfter=10836, tip=neltharakuVines }, 
							{ quest=10854, showAfter=10837, tip=neltharaku2 }, { quest=10858, showAfter=10854, tip=neltharaku3 } } },
	[69115860] = { quests={ { quest=10811, showAfter=10804, tip=neltharaku }, { quest=10814, showAfter=10811, tip=neltharaku }, 
							{ quest=10836, showAfter=10814, tip=neltharaku4 }, { quest=10837, showAfter=10836, tip=neltharakuVines }, 
							{ quest=10854, showAfter=10837, tip=neltharaku2 }, { quest=10858, showAfter=10854, tip=neltharaku3 } } },
	[69456326] = { quests={ { quest=10811, showAfter=10804, tip=neltharaku }, { quest=10814, showAfter=10811, tip=neltharaku }, 
							{ quest=10836, showAfter=10814, tip=neltharaku4 }, { quest=10837, showAfter=10836, tip=neltharakuVines }, 
							{ quest=10854, showAfter=10837, tip=neltharaku2 }, { quest=10858, showAfter=10854, tip=neltharaku3 } } },
	[70406411] = { quests={ { quest=10811, showAfter=10804, tip=neltharaku }, { quest=10814, showAfter=10811, tip=neltharaku }, 
							{ quest=10836, showAfter=10814, tip=neltharaku4 }, { quest=10837, showAfter=10836, tip=neltharakuVines }, 
							{ quest=10854, showAfter=10837, tip=neltharaku2 }, { quest=10858, showAfter=10854, tip=neltharaku3 } } },
	[70445929] = { quests={ { quest=10811, showAfter=10804, tip=neltharaku }, { quest=10814, showAfter=10811, tip=neltharaku }, 
							{ quest=10836, showAfter=10814, tip=neltharaku4 }, { quest=10837, showAfter=10836, tip=neltharakuVines }, 
							{ quest=10854, showAfter=10837, tip=neltharaku2 }, { quest=10858, showAfter=10854, tip=neltharaku3 } } },
	[71296351] = { quests={ { quest=10811, showAfter=10804, tip=neltharaku }, { quest=10814, showAfter=10811, tip=neltharaku }, 
							{ quest=10836, showAfter=10814, tip=neltharaku4 }, { quest=10837, showAfter=10836, tip=neltharakuVines }, 
							{ quest=10854, showAfter=10837, tip=neltharaku2 }, { quest=10858, showAfter=10854, tip=neltharaku3 } } },
	[71476063] = { quests={ { quest=10811, showAfter=10804, tip=neltharaku }, { quest=10814, showAfter=10811, tip=neltharaku }, 
							{ quest=10836, showAfter=10814, tip=neltharaku4 }, { quest=10837, showAfter=10836, tip=neltharakuVines }, 
							{ quest=10854, showAfter=10837, tip=neltharaku2 }, { quest=10858, showAfter=10854, tip=neltharaku3 } } },
	[71896206] = { quests={ { quest=10811, showAfter=10804, tip=neltharaku }, { quest=10814, showAfter=10811, tip=neltharaku }, 
							{ quest=10836, showAfter=10814, tip=neltharaku4 }, { quest=10837, showAfter=10836, tip=neltharakuVines }, 
							{ quest=10854, showAfter=10837, tip=neltharaku2 }, { quest=10858, showAfter=10854, tip=neltharaku3 } } },

	[56176967] = { quests={ { quest=11020, showAfter=11019, daily=true, tip=diemetradons } } },
	[56875239] = { quests={ { quest=11020, showAfter=11019, daily=true, tip=diemetradons } } },
	[63058774] = { quests={ { quest=11076, showAfter=11075, daily=true, }, { quest=11082, showAfter=11081 } } },
	[65399017] = { quests={ { quest=11076, showAfter=11075, daily=true, }, { quest=11082, showAfter=11081 } } },
	[65898718] = { quests={ { quest=11063, showAfter=11084, tip="Ja'y has all the learn to fly quests.\nRep rewards escalate too!!!" } } },
	[66008646] = { quests={ { quest=11019, showAfter=11013, tip="Finish Yarzill's first quest in\norder to unlock his two dailies\n(and soon egg turn ins!)" },
							{ quest=11049, showAfter=11019, tip="This quest will unlock a similar and\nrepeatable quest for egg turn ins" },
							{ quest=11050, showAfter=11049, tip="Quest title says it all. Turn 'em in here!" },
							{ quest=11035, showAfter=11019, daily=true, tip="See the map for location suggestions" },
							{ quest=11020, showAfter=11019, daily=true, tip="Farm the Diemetradons at\nthe fel pools in the Valley" } } },
	[66128636] = { quests={ { quest=11053, showAfter=11014, tip="Complete to this quest and the\nfollowup to help unlock more dailies" },
							{ quest=11075, showAfter=11053, tip="Do this quest to unlock\na \"mistress daily\"" },
							{ quest=11016, showAfter=11014, daily=true, tip="You must have the Outland Skinning\nprofession levelled to at least 50.\n"
									.."Terrible drop rate - just don't :(" },
							{ quest=11017, showAfter=11014, daily=true, tip="You must have the Outland Herbalism\nprofession levelled to at least 50" },
							{ quest=11018, showAfter=11014, daily=true, tip="You must have the Outland Minning\nprofession levelled to at least 50. By\n"
									.."far the easiest of the profession quests" },
							{ quest=11015, showAfter=11014, daily=true, tip="Anywhere on the Ledge or in the mines.\nLow drop rate so complete while doing\nother quests.\n\n"
									.."Only one profession quest per day\nbut Crystals is not one of them" },
							{ quest=11084, showAfter=11053, tip="Complete this quest\nto unlock a daily" } } },
	[66228566] = { quests={ { quest=11014, showAfter=11013, tip="Speak to Overlord Mor'ghor\n\nCompleting this quest unlocks\nprofession dailies!" },
							{ quest=11086, showAfter=11084, daily=true, tip="Hey, it's your business if you think\nthis daily is worth it. I can't be fcuked\n"
									.."getting trolled by flying as far west as\npossible when I've a perfectly good\nAddOn here to get me easy egg rep!!!" } } },
	[66248575] = { quests={ { quest=11089, showAfter=11084, tip="Another nasty and potentially expensive scavenger hunt.\n\n"
									.."Qiff at Area 52, if you are really lucky, might have a\nKorium Power Core or an Adamantite Frame in stock.\n\n"
									.."Dealer Najeeb might have the Frame, if you're lucky.\n\nI've marked both on the Netherstorm map :)\n\n"
									.."The Flawless arcane Elemental in Terokkar will drop\nthe Essence. The Felsteel Bar is from the AH or your\n"
									.."Outland Mining profession.\n\nWorth it? The rep rewards are 43% higher than one egg\n"
									.."turn in. There is a much easier follow up quest with the\nsame rep reward. During Timewalking it's a huge boost.\n\n"
									.."But all told... do as I do. Be patient and use this AddOn\nto hoard eggs for when Timewalking comes around!" },
							{ quest=11090, showAfter=11089, tip="Predictably this one also requires a long flight but\nthankfully that's all. There and back pretty much\n\n"
									.."Where to fly to is not supported in game. You\nmust use this AddOn. See the Nagrand map" } } },
	[66848610] = { quests={ { quest=11054, showAfter=11053, tip="There's no doubt about it, this quest\nis deliberately messing with you.\nOpen up your continent map and pick\n"
									.."the point furthest from you. That'll be\nthe far northern tip of Netherstorm...\n\nLegend has it the quest designer is\n"
									.."still cackling to this day!\n\nThe good news: completion will\nunlock a really easy daily!!!" }, 
							{ quest=11055, showAfter=11054, daily=true } } },
	[69876144] = { quests={ { quest=10866, showAfter=10858, tip="Resume the quest chain here.\n\nAfter a while, Zuluhed will rush\nup to Karynaku.\n\n"
									.."Ranged: One shot him as he runs.\nMelee: Wait until he gets to Karynaku.\n\nDo NOT yourself rush at Zuluhed or\n"
									.."the Quest will bug.\n\nAnother problem: If Zuluhed does not\nspawn. He should spawn instantly,\n"
									.."due east from Karynaku . In this case\nyou need to reset the entire phase.\nLogout, pause, try again, sigh" }, 
							{ quest=10870, showAfter=10866, tip="Resume the quest chain here.\nIt's a taxi ride so dismount first!\n\nInterestingly, completion of\n"
									.."this quest will commence your\nfaction grind. You are still unable\nto farm eggs, do dailies etc,\n"
									.."despite possibly already having\nbeen bumped to \"Revered\"\n(due to Timewalking)" } } },
	[72017470] = { quests={ { quest=11035, showAfter=11019, daily=true, tip="stand here north" } } },
	[74528642] = { quests={ { quest=11041, showAfter=11014, tip="Kill Arvoar and obtain a \"quest starter\".\nYou must do this as a step to unlock a daily" } } },

	[63438755] = { quests={ { quest=11077, showAfter=11075, daily=true, insideMine=true, tip=foreman } } },
	[64308711] = { quests={ { quest=11077, showAfter=11075, daily=true, insideMine=true, tip=foreman } } },
	[65058729] = { quests={ { quest=11077, showAfter=11075, daily=true, insideMine=true, tip=foreman } } },
	[65388947] = { quests={ { quest=11077, showAfter=11075, daily=true, insideMine=true, tip=foreman } } },
	[65398810] = { quests={ { quest=11077, showAfter=11075, daily=true, insideMine=true, tip=foreman } } },
	[64698587] = { quests={ { quest=11081, showAfter=11075, insideMine=true, tip=sludgeCovered } } },
	[67158364] = { quests={ { quest=11081, showAfter=11075, insideMine=true, tip=sludgeCovered } } },
	[68968501] = { quests={ { quest=11081, showAfter=11075, insideMine=true, tip=sludgeCovered } } },
	[70708791] = { quests={ { quest=11081, showAfter=11075, insideMine=true, tip=sludgeCovered } } },
	[71588763] = { quests={ { quest=11083, showAfter=11075, insideMine=true, tip="Ronag's area is deep within the\nmine. He pats near Toranaku.\n\n"
									.."If you thoroughly search for eggs\nthen you'll eventually see him" } } },
}

points[ NetherwingEggs.netherstorm ] = {
	[32656674] = { quests={ { quest=11089, showAfter=11084, tip="Qiff, if you are very lucky, might be stocking a\nKorium Power Core and/or an Adamantite Frame" } } },
	[44993652] = { quests={ { quest=11089, showAfter=11084, tip="Dealer Najeeb, if you are very lucky,\nmight be stocking an Adamantite Frame" } } },
}

points[ NetherwingEggs.terokkar ] = {
	[44744217] = { quests={ { quest=11089, showAfter=11084, tip="Engage with Sar'this. Follow him. The\nlast elemental drops the quest item" } } },
}

points[ NetherwingEggs.nagrand ] = {
	[09424150] = { quests={ { quest=11090, showAfter=11089, tip="Reth'hedrons pats around here.\nHe's a big one, can't miss him\n\n"
									.."Slow down! Don't one shot him!\nUse the quest item and stay\nMOUNTED and keep channeling!\n\nYou may need three channels until\n"
									.."he drops to 8% health, at which\npoint he flees into a portal gate.\n\nDo NOT try to kill him! Ensure\n"
									.."he can run into the portal when\nat very low health.\n\nAvoid auto procs etc. I stood at\n90 degrees to avoid auto melee /\n"
									.."cleave. 30 yards avoids AoE too" } } },
}

-- Choice of texture
-- Note that these textures are all repurposed and as such have non-uniform sizing. I've copied my scaling factors from my old AddOn
-- in order to homogenise the sizes. I should also allow for non-uniform origin placement as well as adjust the x,y offsets

textures[1] = "Interface\\PlayerFrame\\MonkLightPower"
textures[2] = "Interface\\PlayerFrame\\MonkDarkPower"
textures[3] = "Interface\\Common\\Indicator-Red"
textures[4] = "Interface\\Common\\Indicator-Yellow"
textures[5] = "Interface\\Common\\Indicator-Green"
textures[6] = "Interface\\Common\\Indicator-Gray"
textures[7] = "Interface\\Common\\Friendship-ManaOrb"	
textures[8] = "Interface\\TargetingFrame\\UI-PhasingIcon"
textures[9] = "Interface\\Store\\Category-icon-pets"
textures[10] = "Interface\\Store\\Category-icon-featured"
textures[11] = "Interface\\Common\\RingBorder"
textures[12] = "Interface\\PlayerFrame\\DeathKnight-Energize-Blood"
textures[13] = "Interface\\PlayerFrame\\DeathKnight-Energize-Frost"
textures[14] = "Interface\\PlayerFrame\\DeathKnight-Energize-Unholy"
textures[15] = "Interface\\PetBattles\\DeadPetIcon"
textures[16] = "Interface\\RaidFrame\\UI-RaidFrame-Threat"
textures[17] = "Interface\\PlayerFrame\\UI-PlayerFrame-DeathKnight-Frost"
textures[18] = "Interface\\HelpFrame\\HelpIcon-CharacterStuck"	
textures[19] = "Interface\\Vehicles\\UI-Vehicles-Raid-Icon"
textures[20] = "Interface\\AddOns\\HandyNotes_NetherwingEggs\\NetherwingEgg"

scaling[1] = 0.55
scaling[2] = 0.55
scaling[3] = 0.55
scaling[4] = 0.55
scaling[5] = 0.55
scaling[6] = 0.55
scaling[7] = 0.65
scaling[8] = 0.62
scaling[9] = 0.75
scaling[10] = 0.75
scaling[11] = 0.37
scaling[12] = 0.49
scaling[13] = 0.49
scaling[14] = 0.49
scaling[15] = 0.43
scaling[16] = 0.41
scaling[17] = 0.395
scaling[18] = 0.57
scaling[19] = 0.43
scaling[20] = 0.58