local _, ns = ...
local points = ns.points
local textures = ns.textures
local scaling = ns.scaling
local colourPrefix		= ns.colour.prefix
local colourHighlight	= ns.colour.highlight
local colourPlaintext	= ns.colour.plaintext

-- Achievements:
-- Elders of the Dungeons		910		Alliance/Horde
-- Elders of Kalimdor			911		Alliance/Horde
-- Elders of Eastern Kingdoms	912		Alliance/Horde
-- Elders of The Horde			914		Alliance/Horde
-- Elders of The Alliance		915		Alliance/Horde
-- Elders of Northrend			1396	Alliance/Horde
-- Elders of Cataclysm			6006	Alliance/Horde
-- Elders of the Dragon Isles	17321	Alliance/Horde

-- ===================================================
-- aIDA, aIDH, aIndexA, aIndexH, aQuestA, aQuestH, tip
-- ===================================================

points[ 63 ] = { -- Ashenvale
	[35544891] = { aID=911, index=9, quest=8725 },
	[60207290] = { index=4, quest=56842, title="Lunar Preservation" },
	[53744600] = { index=3, quest=56842, title="Lunar Preservation" },
	[04365241] = { index=5, quest=56842, title="Lunar Preservation" },
}
points[ 159 ] = { -- Azjol-Nerub - The Guilded Gate
	[54374440] = { aID=910, index=9, quest=13022, tip="1) Enter the gate. You must kill the boss" },
	[66004350] = { aID=910, index=9, quest=13022, tip="2) Jump down onto the left side stairs" },
	[70003450] = { aID=910, index=9, quest=13022, tip="3) Go this way" },
}
points[ 158 ] = { -- Azjol-Nerub - Hadronox's Lair
	[41533715] = { aID=910, index=9, quest=13022, tip="3) Go this way" },
	[61752850] = { aID=910, index=9, quest=13022, tip="4) Keep going this way!" },
	[47176569] = { aID=910, index=9, quest=13022, tip="5) Ignore Hadronox. Jump down here" },
	[49005820] = { aID=910, index=9, quest=13022, tip="6) Now jump down again!" },
}
points[ 157 ] = { -- Azjol-Nerub - The Brood Pt
	[23005217] = { aID=910, index=9, quest=13022, tip="7) You land here" },
	[21724319] = { aID=910, index=9, quest=13022, tip="8) Elder is here" },
	[36854877] = { aID=910, index=9, quest=13022, tip="9) Exit is this way" },
	[75744913] = { aID=910, index=9, quest=13022, tip="10) No need to kill Anub'arak" },
	[88527649] = { aID=910, index=9, quest=13022, tip="11) You're welcome! :)" },
}
points[ 76 ] = { -- Azshara
	[64737934] = { aID=911, index=2, quest=8720 },
	[18919764] = { aID=914, index=1, quest=8677, tip="Alliance need to be very quick with this one" },
}
points[ 15 ] = { -- Badlands
	[06957986] = { aID=912, index=10, quest=8683 },
}
points[ 242 ] = { -- Blackrock Depths - Detention Block
	[38007650] = { aID=910, index=5, quest=8619, tip="1) This way" },
	[49007200] = { aID=910, index=5, quest=8619, tip="2) This way" },
	[51406770] = { aID=910, index=5, quest=8619, tip="3) Enter the Ring here, turn\n"
											.."in the quest and reverse to exit" },
}
points[ 34 ] = { -- Blackrock Mountain - Blackrock Caverns
	[53127138] = { aID=910, index=4, quest=8644, tip="2) Continue past the barrier" },
	[52654551] = { aID=910, index=4, quest=8644, tip="3) Go straight up" },
	[60142748] = { aID=910, index=4, quest=8644, tip="4) Go up the ramp" },
}
points[ 35 ] = { -- Blackrock Mountain - Blackrock Depths
	[54848478] = { aID=910, index=5, quest=8619, tip="1) Fly down to here" },
	[55818208] = { aID=910, index=5, quest=8619, tip="2) Come this way" },
	[45716843] = { aID=910, index=5, quest=8619, tip="3) This way" },
	[37714228] = { aID=910, index=5, quest=8619, tip="4) This way" },
	[39171822] = { aID=910, index=5, quest=8619, tip="5) Enter through here and follow the markers" },
}
points[ 33 ] = { -- Blackrock Mountain - Blackrock Spire
	[65676078] = { aID=910, index=4, quest=8644, tip="1) Enter through here" },
	[72524765] = { aID=910, index=4, quest=8644, tip="5) Continue upwards" },
	[70775311] = { aID=910, index=4, quest=8644, tip="6) Continue upwards" },
	[63454416] = { aID=910, index=4, quest=8644, tip="7) Shortcut upwards. You can fly up to here!" },
	[72903983] = { aID=910, index=4, quest=8644, tip="8) Continue forward and down the ramp.\n"
											.."Portal is to your right" },
	[80324026] = { aID=910, index=4, quest=8644, tip="9) Enter through here and follow the markers" },
	[39494029] = { aID=910, index=5, quest=8619, tip="1) Fly down to here" },
}
points[ 251 ] = { -- Blackrock Spire - Skitterweb Tunnels
	[58904260] = { aID=910, index=4, quest=8644, tip="3) Cross the bridge" },
	[61934012] = { aID=910, index=4, quest=8644, tip="4) Turn in the quest. Reverse to exit" },
}
points[ 252 ] = { -- Blackrock Spire - Hordemar City
	[39004800] = { aID=910, index=4, quest=8644, tip="1) Begin by following the path down\n"
												.."and then left to here. Keep going" },
	[60404270] = { aID=910, index=4, quest=8644, tip="3) Cross the bridge" },
}
points[ 253 ] = { -- Blackrock Spire - Hall of Blackhand
	[48004100] = { aID=910, index=4, quest=8644, tip="2) Plough on past the mobs. Depending upon your\n"
					.."graphics settings, you can see Elder Stonefort from here" },
}
points[ 17 ] = { -- Blasted Lands
	[54284950] = { aID=912, index=2, quest=8647, tip="Can't find him? Speak to Zidormi" },
}
points[ 114 ] = { -- Borean Tundra
	[59096564] = { aID=1396, index=1, quest=13012 },
	[57404372] = { aID=1396, index=5, quest=13033 },
	[33803436] = { aID=1396, index=6, quest=13016 },
	[42934957] = { aID=1396, index=15, quest=13029, tip="Actually above the Mightstone Quarry" },
	[27512594] = { aID=910, index=8, quest=13021,
					tip="Enter through here and follow the markers.\n\nThe lowest portal is for The Nexus" },
}
points[ 36 ] = { -- Burning Steppes
	[70114538] = { aID=912, index=9, quest=8636 },
	[52382393] = { aID=912, index=10, quest=8683 },
	[20201803] = { aID=910, index=4, quest=8644, tip="Enter through here and follow the markers" },
	[20201603] = { aID=910, index=5, quest=8619, tip="Enter through here and follow the markers" },
	[21023744] = { aID=910, index=4, quest=8644, tip="Enter through here and follow the markers" },
	[21023944] = { aID=910, index=5, quest=8619, tip="Enter through here and follow the markers" },
	[10581387] = { 912, 912, 12, 12, 8651, 8651, },
}
points[ 127 ] = { -- Crystalsong Forest
	[92911771] = { aID=1396, index=13, quest=13028 },
}
points[ 62 ] = { -- Darkshore
	[49541895] = { aID=911, index=7, quest=8721, tip="If Teldrassil looks destroyed then have a chat with Zidormi!\n\n"
					.."Thanks for using my AddOn. Hope I helped! :)\n\n"
					.."I'm at Twitter and Ko-fi as @Taraezor.\nThere's also my project page at curseforge\n"
					.."where you might find more useful AddOns!" },
}
points[ 89 ] = { -- Darnassus
	[39203185] = { aID=915, index=1, quest=8718 },
	[37325047] = { aID=915, index=1, quest=8718, faction="Horde", tip="Immediately go left and up high - don't delay" },
	[30402709] = { aID=915, index=1, quest=8718, faction="Horde", tip="Hide here for respite/cooldowns, as necessary" },
}
points[ 207 ] = { -- Deepholm
	[49705488] = { aID=6006, index=1, quest=29735 },
	[27706918] = { aID=6006, index=9, quest=29734 },
}
points[ 66 ] = { -- Desolace
	[29626248] = { aID=910, index=3, quest=8635, tip="Enter Maraudon. Follow the markers" },
	[50225001] = { index=1, quest=56905, obj="Flower of Compassion" },
	[50284566] = { index=1, quest=56905, obj="Flower of Compassion" },
	[50904702] = { index=1, quest=56905, obj="Flower of Compassion" },
	[51074943] = { index=1, quest=56905, obj="Flower of Compassion" },
	[51384509] = { index=1, quest=56905, obj="Flower of Compassion" },
	[52095157] = { index=1, quest=56905, obj="Flower of Compassion" },
	[52774955] = { index=1, quest=56905, obj="Flower of Compassion" },
	[53104525] = { index=1, quest=56905, obj="Flower of Compassion" },
	[53335138] = { index=1, quest=56905, obj="Flower of Compassion" },
	[54784717] = { index=1, quest=56905, obj="Flower of Compassion" },
	[99614885] = { aID=914, index=2, quest=8678 },
}
points[ 115 ] = { -- Dragonblight
	[29755591] = { aID=1396, index=3, quest=13014 },
	[48777817] = { aID=1396, index=12, quest=13019 },
	[35104835] = { aID=1396, index=17, quest=13031 },
	[26134950] = { aID=910, index=9, quest=13022, tip="Drop down here, face south and locate the portal and enter" },
	[26814899] = { aID=910, index=9, quest=13022,
					tip="After you exit the dungeon, use the path\nhere and very soon after you may mount" },
	[14000484] = { aID=1396, index=10, quest=13026 },
}
points[ 161 ] = { -- Drak'Tharon Keep - Drak'Tharon Overlook
	[36554553] = { aID=910, index=10, quest=13023, tip="5) So you did decide to come this way. Awesome!\n"
													.."Keep going, it's all linear" },
	[43271321] = { aID=910, index=10, quest=13023, tip="6) Ignore The Prophet. Just keep going" },
	[38051726] = { aID=910, index=10, quest=13023,
					tip="7) Jump down and turn around and you'll see a\nshort hallway then jump "
					.."again into the water\nand then jump once more into the water!" },
}
points[ 160 ] = { -- Drak'Tharon Keep - The Vestibules of Drak'Tharon
	[50654047] = { aID=910, index=10, quest=13023, tip="1) Go through here" },
	[60971879] = { aID=910, index=10, quest=13023, tip="2) Through here. No need to whoop Trollie" },
	[67875507] = { aID=910, index=10, quest=13023, tip="3) Through here. You can bypass Novos too" },
	[55636125] = { aID=910, index=10, quest=13023, tip="4) Exit here" },
	[46031310] = { aID=910, index=10, quest=13023, tip="8) You made it! Follow the passage. You know the rest!" },
	[69077927] = { aID=910, index=10, quest=13023,
					tip="Elder Kilias is located here. Whew! now the exit :(...\n\nA sad choice of "
					.."backtracking or go up stairs, kill the\nlast boss (optional) and jump down. Your call" },
}
points[ 27 ] = { -- Dun Morogh
	[53904991] = { aID=912, index=1, quest=8653 },
	[60173345] = { aID=915, index=2, quest=8866, faction="Horde", tip="Fly through here, keep to the left" }, 
	[45775808] = { index=2, quest=56906, obj="Flower of Luck" },
	[46125820] = { index=2, quest=56906, obj="Flower of Luck" },
	[46226042] = { index=2, quest=56906, obj="Flower of Luck" },
	[47485862] = { index=2, quest=56906, obj="Flower of Luck" },
	[48205348] = { index=2, quest=56906, obj="Flower of Luck" },
	[48265985] = { index=2, quest=56906, obj="Flower of Luck" },
	[48355544] = { index=2, quest=56906, obj="Flower of Luck" },
	[49965302] = { index=2, quest=56906, obj="Flower of Luck" },
	[51705259] = { index=2, quest=56906, obj="Flower of Luck" },
	[52545662] = { index=2, quest=56906, obj="Flower of Luck" },
}
points[ 1 ] = { -- Durotar
	[53234361] = { aID=911, index=1, quest=8670, tip="Alliance need to be very quick with this one" },
	[47000300] = { aID=914, index=1, quest=8677, tip="Alliance need to be very quick with this one" },
	[00334697] = { index=1, quest=56904, obj="Flower of Wealth" },
	[00594848] = { index=1, quest=56904, obj="Flower of Wealth" },
	[00675268] = { index=1, quest=56904, obj="Flower of Wealth" },
	[00805135] = { index=1, quest=56904, obj="Flower of Wealth" },
	[33357598] = { aID=911, index=5, quest=8680 },
	[11796435] = { aID=911, index=3, quest=8717 },
}
points[ 47 ] = { -- Duskwood
	[49153323] = { index=7, quest=56842, title="Lunar Preservation" },
	[59012185] = { index=2, quest=56905, obj="Flower of Reflection" },
	[60082518] = { index=2, quest=56905, obj="Flower of Reflection" },
	[60152031] = { index=2, quest=56905, obj="Flower of Reflection" },
	[63013300] = { index=2, quest=56905, obj="Flower of Reflection" },
	[63872163] = { index=2, quest=56905, obj="Flower of Reflection" },
	[64132513] = { index=2, quest=56905, obj="Flower of Reflection" },
	[64982878] = { index=2, quest=56905, obj="Flower of Reflection" },
	[66163376] = { index=2, quest=56905, obj="Flower of Reflection" },
	[67682256] = { index=2, quest=56905, obj="Flower of Reflection" },
	[68321900] = { index=2, quest=56905, obj="Flower of Reflection" },
}
points[ 70 ] = { -- Dustwallow Marsh
	[28529858] = { aID=911, index=13, quest=8682 },
	[14330306] = { aID=911, index=4, quest=8686 },
}
points[ 23 ] = { -- Eastern Plaguelands
	[35586882] = { aID=912, index=15, quest=8688 },
	[75505450] = { aID=912, index=16, quest=8650 },
	[26531159] = { aID=910, index=6, quest=8727, tip="Enter through here and follow the markers" },
	[02575390] = { aID=912, index=4, quest=8722, tip="Enter The Weeping Cave" },
}
points[ 37 ] = { -- Elwynn Forest
	[39796367] = { aID=912, index=3, quest=8649 },
	[34565025] = { aID=915, index=3, quest=8646 },
	[66139377] = { index=2, quest=56905, obj="Flower of Reflection" },
	[69929383] = { index=2, quest=56905, obj="Flower of Reflection" },
	[66969636] = { index=2, quest=56905, obj="Flower of Reflection" },
	[67029257] = { index=2, quest=56905, obj="Flower of Reflection" },
	[70119632] = { index=2, quest=56905, obj="Flower of Reflection" },
	[70789916] = { index=2, quest=56905, obj="Flower of Reflection" },
	[72889432] = { index=2, quest=56905, obj="Flower of Reflection" },
	[73389155] = { index=2, quest=56905, obj="Flower of Reflection" },
}
points[ 1644 ] = { -- Ember Court
	[38365285] = { quest=63213, tip="Elder Naladu" },
}
points[ 94 ] = { -- Eversong Woods
	[39426745] = { index=1, quest=56903, obj="Flower of Fortitude" },
	[40786500] = { index=1, quest=56903, obj="Flower of Fortitude" },
	[40847300] = { index=1, quest=56903, obj="Flower of Fortitude" },
	[42696870] = { index=1, quest=56903, obj="Flower of Fortitude" },
	[43456364] = { index=1, quest=56903, obj="Flower of Fortitude" },
	[44946799] = { index=1, quest=56903, obj="Flower of Fortitude" },
	[46226210] = { index=1, quest=56903, obj="Flower of Fortitude" },
	[46447190] = { index=1, quest=56903, obj="Flower of Fortitude" },
	[46506526] = { index=1, quest=56903, obj="Flower of Fortitude" },
}
points[ 77 ] = { -- Felwood
	[38365285] = { aID=911, index=12, quest=8723 },
	[44042841] = { index=2, quest=56842, title="Lunar Preservation" },
	[53225675] = { aID=911, index=18, quest=8726 },
}
points[ 69 ] = { -- Feralas
	[76713790] = { aID=911, index=10, quest=8679, tip="In the Lariss Pavillion" },
	[62563107] = { aID=911, index=11, quest=8685, tip="In the Dire Maul arena - she's not in the instance" },
	[60214625] = { index=6, quest=56842, title="Lunar Preservation" },
	[53368345] = { aID=911, index=20, quest=8654, tip="Visit Zidormi if you see a\n"
												.."huge sword stuck into Azeroth" },
	[66339639] = { aID=911, index=21, quest=8719, tip="Visit Zidormi if you see a\n"
												.."huge sword stuck into Azeroth" },
}
points[ 116 ] = { -- Grizzly Hills
	[60572768] = { aID=1396, index=2, quest=13013 },
	[80533711] = { aID=1396, index=9, quest=13025 },
	[64184699] = { aID=1396, index=16, quest=13030 },
	[17792703] = { aID=910, index=10, quest=13023, tip="The portal is through here" },
}
points[ 154 ] = { -- Gundrak
	[58634038] = { aID=910, index=11, quest=13065, tip="1) Jump in the water and exit here" },
	[58635714] = { aID=910, index=11, quest=13065, tip="2) Through this doorway" },
	[47007325] = { aID=910, index=11, quest=13065, tip="3) This way" },
	[45556119] = { aID=910, index=11, quest=13065, tip="4) After Elder Ohanzee, reverse to exit" },
}
points[ 140 ] = { -- Halls of Stone
	[29176225] = { aID=910, index=12, quest=13066, tip="Here he is!" },
}
points[ 25 ] = { -- Hillsbrad Foothills
	[46622052] = { index=1, quest=56906, obj="Flower of Thoughtfulness" },
	[47201864] = { index=1, quest=56906, obj="Flower of Thoughtfulness" },
	[47862141] = { index=1, quest=56906, obj="Flower of Thoughtfulness" },
	[48082546] = { index=1, quest=56906, obj="Flower of Thoughtfulness" },
	[48281758] = { index=1, quest=56906, obj="Flower of Thoughtfulness" },
	[49772611] = { index=1, quest=56906, obj="Flower of Thoughtfulness" },
	[50092111] = { index=1, quest=56906, obj="Flower of Thoughtfulness" },
	[51052305] = { index=1, quest=56906, obj="Flower of Thoughtfulness" },
	[52902309] = { index=1, quest=56906, obj="Flower of Thoughtfulness" },
	[53052549] = { index=1, quest=56906, obj="Flower of Thoughtfulness" },
	[90650679] = { aID=912, index=17, quest=8714 },
	[05942981] = { aID=912, index=14, quest=8645 },	
	[13752469] = { index=3, quest=56905, obj="Flower of Solemnity" },
	[14292187] = { index=3, quest=56905, obj="Flower of Solemnity" },
	[15312379] = { index=3, quest=56905, obj="Flower of Solemnity" },
	[15682052] = { index=3, quest=56905, obj="Flower of Solemnity" },
	[15832453] = { index=3, quest=56905, obj="Flower of Solemnity" },
	[15851879] = { index=3, quest=56905, obj="Flower of Solemnity" },
	[16042264] = { index=3, quest=56905, obj="Flower of Solemnity" },
	[16602521] = { index=3, quest=56905, obj="Flower of Solemnity" },
	[17712461] = { index=3, quest=56905, obj="Flower of Solemnity" },
}

points[ 117 ] = { -- Howling Fjord
	[58854834] = { aID=910, index=7, quest=13017, tip="Utgarde Keep is this way. It at the base" },
	[57254671] = { aID=910, index=13, quest=13067, tip="This is the correct portal. It's up quite high" },
}
points[ 118 ] = { -- Icecrown
	[93836520] = { 1396, 1396, 10, 10, 13026, 13026, },
	[10909536] = { 1396, 1396, 7, 7, 13018, 13018, },
	[20638522] = { 1396, 1396, 8, 8, 13024, 13024, },
	[90216517] = { 1396, 1396, 4, 4, 13015, 13015, },
	[92902422] = { 1396, 1396, 14, 14, 13020, 13020, },
}
points[ 87 ] = { -- Ironforge
	[29191705] = { aID=915, index=2, quest=8866 }, 
	[12158801] = { aID=915, index=2, quest=8866, faction="Horde", tip="1) Fly through here, keep to the left" }, 
	[24365947] = { aID=915, index=2, quest=8866, faction="Horde", tip="2) Drop straight down into here and follow to the left" }, 
	[23683637] = { aID=915, index=2, quest=8866, faction="Horde", tip="3) Stick your head up a little and assess the situation" }, 
}
points[ 48 ] = { -- Loch Modan
	[33334655] = { aID=912, index=7, quest=8642 },
}
points[ 68 ] = { -- Maraudon - Foulspore Cavern
	[46788822] = { aID=910, index=3, quest=8635, tip="If you are here then you have come the correct way.\n"
												.."It's a linear path. The instance portal is ahead" },
}
points[ 67 ] = { -- Maraudon - The Wicked Grotto
	-- 68 - Foulspore Cavern
	[19345583] = { aID=910, index=3, quest=8635, tip="This is where you respawn if you were wondering" },
	[25004335] = { aID=910, index=3, quest=8635, tip="Instance entrance/exit" },
	[17005350] = { aID=910, index=3, quest=8635,
					tip="Follow the path.\n\nAt \"Zaetar's Choice\" enter the arch that is\nguarded by "
					.."two centaurs. Do not take the left\npink/purple path, nor the right red/orange path" },
}
points[ 281 ] = { -- Maraudon - Zaelar's Grave
	[28083508] = { aID=910, index=3, quest=8635, tip="This is where you \"land\" upon entry\n"
					.."to the instance. Go straight ahead,\njumping down and through the cutting" },
	[33006070] = { aID=910, index=3, quest=8635, tip="Through here and follow the path" },
	[45405480] = { aID=910, index=3, quest=8635, tip="You now have a choice. Go right. In other\n"
												.."words, do not take the (left) ramp upwards" },
	[40007340] = { aID=910, index=3, quest=8635,
					tip="You're now in an area with a waterfall, a\nPrimordial Behemoth, a bridge and a river.\n"
					.."Continue over the bridge. Don't jump down.\nIt's a linear path, you can't get lost!" },
	[51379385] = { aID=910, index=3, quest=8635, tip="Elder Splitrock is here" },
	[54708660] = { aID=910, index=3, quest=8635,
					tip="After Elder Splitrock, don't bother looking\nfor a way out down here. "
					.."There isn't one.\nHearth or portal" },
}
points[ 80 ] = { -- Moonglade
	[48643293] = { index=1, quest=56842, title="Lunar Preservation" },
}
points[ 198 ] = { -- Mount Hyjal
	[26696205] = { aID=6006, index=6, quest=29739 },
	[62542282] = { aID=6006, index=7, quest=29740 },
	[60522631] = { index=8, quest=56842, title="Lunar Preservation" },
}
points[ 7 ] = { -- Mulgore
	[48495323] = { aID=911, index=8, quest=8673 },
	[44942322] = { aID=914, index=2, quest=8678 },
	[47473458] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[47653056] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[48112717] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[49122970] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[50982986] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[51273853] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[52423242] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[53843626] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[56472982] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[57053049] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[72145427] = { aID=911, index=4, quest=8686 },
	[04192417] = { index=1, quest=56905, obj="Flower of Compassion" },
	[04242059] = { index=1, quest=56905, obj="Flower of Compassion" },
	[04762171] = { index=1, quest=56905, obj="Flower of Compassion" },
	[04902370] = { index=1, quest=56905, obj="Flower of Compassion" },
	[05152012] = { index=1, quest=56905, obj="Flower of Compassion" },
	[05742547] = { index=1, quest=56905, obj="Flower of Compassion" },
	[06302380] = { index=1, quest=56905, obj="Flower of Compassion" },
	[06572025] = { index=1, quest=56905, obj="Flower of Compassion" },
	[06762530] = { index=1, quest=56905, obj="Flower of Compassion" },
	[07962183] = { index=1, quest=56905, obj="Flower of Compassion" },
	[87890802] = { aID=911, index=3, quest=8717 },
}
points[ 10 ] = { -- Northern Barrens
	[48525926] = { aID=911, index=3, quest=8717 },
	[68366996] = { aID=911, index=5, quest=8680 },
	[35654710] = { index=1, quest=56904, obj="Flower of Wealth" },
	[36174300] = { index=1, quest=56904, obj="Flower of Wealth" },
	[36204512] = { index=1, quest=56904, obj="Flower of Wealth" },
	[37054770] = { index=1, quest=56904, obj="Flower of Wealth" },
	[37504278] = { index=1, quest=56904, obj="Flower of Wealth" },
	[37624591] = { index=1, quest=56904, obj="Flower of Wealth" },
	[37974327] = { index=1, quest=56904, obj="Flower of Wealth" },
	[38214466] = { index=1, quest=56904, obj="Flower of Wealth" },
	[38294852] = { index=1, quest=56904, obj="Flower of Wealth" },
	[38414730] = { index=1, quest=56904, obj="Flower of Wealth" },	
	[10188445] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[10358064] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[10797743] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[11757982] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[13517998] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[13788820] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[14888240] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[16238605] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[18727994] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[19278058] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[07787368] = { aID=914, index=2, quest=8678 },
	[80370051] = { aID=914, index=1, quest=8677, "Alliance need to be very quick with this one" },
	[86654018] = { aID=911, index=1, quest=8670, "Alliance need to be very quick with this one" },
}
points[ 50 ] = { -- Northern Stranglethorn
	[71043430] = { aID=912, index=5, quest=8716, tip="Outside the instance" },
}
points[ 2023 ] = { -- Ohn'ahran Plains
	[58393146] = { aID=17321, index=4, quest=73717 },
	[83934803] = { aID=17321, index=3, quest=73172 },
}
points[ 85 ] = { -- Orgrimmar
	[52266001] = { aID=914, index=1, quest=8677, tip="Alliance need to be very quick with this one" },
}
points[ 32 ] = { -- Searing Gorge
	[21297911] = { aID=912, index=12, quest=8651 },
	[34898498] = { aID=910, index=4, quest=8644, tip="Enter through here and follow the markers" },
	[34898298] = { aID=910, index=5, quest=8619, tip="Enter through here and follow the markers" },
	[80349331] = { aID=912, index=10, quest=8683 },
}
points[ 205 ] = { -- Shimmering Expanse in Vashj'ir
	[57258614] = { aID=6006, index=8, quest=29738 },
}
points[ 119 ] = { -- Sholazar Basin
	[49786362] = { aID=1396, index=7, quest=13018 },
	[63804902] = { aID=1396, index=8, quest=13024 },
	[93836520] = { aID=1396, index=10, quest=13026 },
}
points[ 81 ] = { -- Silithus
	[30801332] = { aID=911, index=20, quest=8654,
					tip="Visit Zidormi if you see a\nhuge sword stuck into Azeroth" },
	[53023547] = { aID=911, index=21, quest=8719,
					tip="Visit Zidormi if you see a\nhuge sword stuck into Azeroth" },
}
points[ 21 ] = { -- Silverpine Forest
	[44974114] = { aID=912, index=14, quest=8645 },
	[54013521] = { index=3, quest=56905, obj="Flower of Solemnity" },
	[54023150] = { index=3, quest=56905, obj="Flower of Solemnity" },
	[54643194] = { index=3, quest=56905, obj="Flower of Solemnity" },
	[55823416] = { index=3, quest=56905, obj="Flower of Solemnity" },
	[56253038] = { index=3, quest=56905, obj="Flower of Solemnity" },
	[56423502] = { index=3, quest=56905, obj="Flower of Solemnity" },
	[56452838] = { index=3, quest=56905, obj="Flower of Solemnity" },
	[56663283] = { index=3, quest=56905, obj="Flower of Solemnity" },
	[57313581] = { index=3, quest=56905, obj="Flower of Solemnity" },
	[58603512] = { index=3, quest=56905, obj="Flower of Solemnity" },
}
points[ 199 ] = { -- Southern Barrens
	[41604745] = { aID=911, index=4, quest=8686 },
	[24224668] = { aID=911, index=8, quest=8673 },
	[23463297] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[23603002] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[23932753] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[24682938] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[26052950] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[26263587] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[27103138] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[28153421] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[30082947] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[30512997] = { index=2, quest=56903, obj="Flower of Sincerity" },
	[21602462] = { aID=914, index=2, quest=8678 },
	[43210401] = { index=1, quest=56904, obj="Flower of Wealth" },
	[43600083] = { index=1, quest=56904, obj="Flower of Wealth" },
	[43630248] = { index=1, quest=56904, obj="Flower of Wealth" },
	[44290448] = { index=1, quest=56904, obj="Flower of Wealth" },
	[44640066] = { index=1, quest=56904, obj="Flower of Wealth" },
	[44730309] = { index=1, quest=56904, obj="Flower of Wealth" },
	[44740309] = { index=1, quest=56904, obj="Flower of Wealth" },
	[45010104] = { index=1, quest=56904, obj="Flower of Wealth" },
	[45190212] = { index=1, quest=56904, obj="Flower of Wealth" },
	[45250511] = { index=1, quest=56904, obj="Flower of Wealth" },
	[45350417] = { index=1, quest=56904, obj="Flower of Wealth" },
	[68562174] = { aID=911, index=5, quest=8680 },
	[53181344] = { aID=911, index=3, quest=8717 },
}
points[ 65 ] = { -- Stonetalon Mountains
	[41591896] = { index=5, quest=56842, title="Lunar Preservation" },
	[72061554] = { aID=911, index=9, quest=8725 },
	[96163898] = { index=4, quest=56842, title="Lunar Preservation" },
	[89851270] = { index=3, quest=56842, title="Lunar Preservation" },
}
points[ 120 ] = { -- Storm Peaks
	[28897372] = { aID=1396, index=4, quest=13015 },
	[41168472] = { aID=1396, index=13, quest=13028 },
	[31263761] = { aID=1396, index=14, quest=13020 },
	[64595134] = { aID=1396, index=18, quest=13032, tip="BM Hunters doing the Hati quest chain\n"
					.."(to get Hati back) will be phased out.\n\nElder Muraco is below Camp Tunka'lo" },
	[39482691] = { aID=910, index=12, quest=13066, tip="Enter through here" },
	[75699264] = { aID=1396, index=11, quest=13027 },
	[87776802] = { aID=910, index=11, quest=13065, tip="Use this entrance, not the other one" },
}
points[ 84 ] = { -- Stormwind City
	[79839556] = { aID=915, index=3, quest=8646 },
}
points[ 224 ] = { -- Stranglethorn Vale
	[63282265] = { aID=912, index=5, quest=8716, tip="Outside the instance" },
	[37327920] = { aID=912, index=6, quest=8674 },
	[38814669] = { index=2, quest=56904, obj="Flower of Peace" },
	[40134704] = { index=2, quest=56904, obj="Flower of Peace" },
	[40874783] = { index=2, quest=56904, obj="Flower of Peace" },
	[41294516] = { index=2, quest=56904, obj="Flower of Peace" },
	[41604731] = { index=2, quest=56904, obj="Flower of Peace" },
	[41954612] = { index=2, quest=56904, obj="Flower of Peace" },
	[42254482] = { index=2, quest=56904, obj="Flower of Peace" },
	[42684748] = { index=2, quest=56904, obj="Flower of Peace" },
	[42904573] = { index=2, quest=56904, obj="Flower of Peace" },
	[43234966] = { index=2, quest=56904, obj="Flower of Peace" },
}
points[ 317 ] = { -- Stratholme
	[73505480] = { aID=910, index=6, quest=8727, tip="Lift the portcullis" },
	[78622176] = { aID=910, index=6, quest=8727, tip="Exit the same way you entered" },
}
points[ 51 ] = { -- Swamp of Sorrows
	[69425487] = { aID=910, index=2, quest=8713,
					tip="Enter the Temple of Atal'Hakkar,\nalso known as the Sunken Temple.\n\n1) "
					.."Descend the twisting path.\n2) Momentarily submerge into the pool.\n3) "
					.."Resurface and follow the path and\nenter the portal and follow the markers" },
}
points[ 71 ] = { -- Tanaris
	[37247906] = { aID=911, index=15, quest=8671 },
	[51402881] = { aID=911, index=16, quest=8684 },
	[39222134] = { aID=910, index=1, quest=8676, tip="Enter Zul'Farrak. Follow the markers" },
	[17584315] = { aID=911, index=17, quest=8681 },
	[23711968] = { index=3, quest=56904, obj="Flower of Felicity" },
	[24651944] = { index=3, quest=56904, obj="Flower of Felicity" },
	[25081689] = { index=3, quest=56904, obj="Flower of Felicity" },
	[25251996] = { index=3, quest=56904, obj="Flower of Felicity" },
	[25301790] = { index=3, quest=56904, obj="Flower of Felicity" },
	[25881559] = { index=3, quest=56904, obj="Flower of Felicity" },
	[25982071] = { index=3, quest=56904, obj="Flower of Felicity" },
	[26551851] = { index=3, quest=56904, obj="Flower of Felicity" },
	[26932084] = { index=3, quest=56904, obj="Flower of Felicity" },
	[27491962] = { index=3, quest=56904, obj="Flower of Felicity" },
	[52170860] = { aID=911, index=14, quest=8724 },
	[21556299] = { aID=6006, index=2, quest=29742 },
}
points[ 57 ] = { -- Teldrassil
	[56855310] = { aID=911, index=6, quest=8715 },
	[28114367] = { aID=915, index=1, quest=8718 },
	[55108853] = { aID=915, index=1, quest=8718, faction="Horde",
					tip="Fly straight into the pink portal at Rut'theran.\nImmediately turn left and fly up high" },
}
points[ 2025 ] = { -- Thaldraszus
	[54864337] = { aID=17321, index=7, quest=73859 },
	[50056654] = { aID=17321, index=8, quest=73861 },
}
points[ 2024 ] = { -- The Azure Span
	[12894905] = { aID=17321, index=5, quest=73858 },
	[67424949] = { aID=17321, index=6, quest=73860 },
}
points[ 210 ] = { -- The Cape of Stranglethorn
	[39967251] = { aID=912, index=6, quest=8674 },
	[42431854] = { index=2, quest=56904, obj="Flower of Peace" },
	[44611912] = { index=2, quest=56904, obj="Flower of Peace" },
	[45852043] = { index=2, quest=56904, obj="Flower of Peace" },
	[46541599] = { index=2, quest=56904, obj="Flower of Peace" },
	[47071956] = { index=2, quest=56904, obj="Flower of Peace" },
	[47631759] = { index=2, quest=56904, obj="Flower of Peace" },
	[48141543] = { index=2, quest=56904, obj="Flower of Peace" },
	[48851984] = { index=2, quest=56904, obj="Flower of Peace" },
	[49221694] = { index=2, quest=56904, obj="Flower of Peace" },
	[49762346] = { index=2, quest=56904, obj="Flower of Peace" },
}
points[ 26 ] = { -- The Hinterlands
	[50004805] = { aID=912, index=11, quest=8643 },
	[49123983] = { index=3, quest=56903, obj="Flower of Vigor" },
	[51853858] = { index=3, quest=56903, obj="Flower of Vigor" },
	[54953518] = { index=3, quest=56903, obj="Flower of Vigor" },
	[59543908] = { index=3, quest=56903, obj="Flower of Vigor" },
	[62224140] = { index=3, quest=56903, obj="Flower of Vigor" },
	[63644153] = { index=3, quest=56903, obj="Flower of Vigor" },
	[65213765] = { index=3, quest=56903, obj="Flower of Vigor" },
	[66234105] = { index=3, quest=56903, obj="Flower of Vigor" },
	[71434483] = { index=3, quest=56903, obj="Flower of Vigor" },
	[73114802] = { index=3, quest=56903, obj="Flower of Vigor" },
	[25530801] = { aID=912, index=17, quest=8714 },
}
points[ 129 ] = { -- The Nexus
	[38707760] = { aID=910, index=8, quest=13021, tip="1) This way!" },
	[50006600] = { aID=910, index=8, quest=13021, tip="2) This way!" },
	[61505220] = { aID=910, index=8, quest=13021, tip="3) This way!" },
	[61906400] = { aID=910, index=8, quest=13021, tip="4) This way!" },
	[54976461] = { aID=910, index=8, quest=13021, tip="5) He is here" },
	[52756990] = { aID=910, index=8, quest=13021, tip="6) Come up this way for a shortcut exit!" },
}
points[ 220 ] = { -- The Temple of Atal'Hakkar
	[63073436] = { aID=910, index=2, quest=8713 },
	[50002500] = { aID=910, index=2, quest=8713, tip="Head straight for the other marker" },
}
points[ 2022 ] = { -- The Waking Shores
	[46703094] = { aID=17321, index=1, quest=73848 },
	[44306379] = { aID=17321, index=2, quest=73716 },
}
points[ 64 ] = { -- Thousand Needles
	[46345101] = { aID=911, index=13, quest=8682 },
	[77097561] = { aID=911, index=14, quest=8724 },
	[30449376] = { index=3, quest=56904, obj="Flower of Felicity" },
	[31989337] = { index=3, quest=56904, obj="Flower of Felicity" },
	[32698920] = { index=3, quest=56904, obj="Flower of Felicity" },
	[32969423] = { index=3, quest=56904, obj="Flower of Felicity" },
	[33049085] = { index=3, quest=56904, obj="Flower of Felicity" },
	[33998706] = { index=3, quest=56904, obj="Flower of Felicity" },
	[34179545] = { index=3, quest=56904, obj="Flower of Felicity" },
	[35089184] = { index=3, quest=56904, obj="Flower of Felicity" },
	[35729567] = { index=3, quest=56904, obj="Flower of Felicity" },
	[36639366] = { index=3, quest=56904, obj="Flower of Felicity" },
	[55869648] = { aID=910, index=1, quest=8676, tip="Enter Zul'Farrak. Follow the markers" },
}
points[ 88 ] = { -- Thunder Bluff
	[72982335] = { aID=914, index=2, quest=8678 },
}
points[ 18 ] = { -- Tirisfal Glades
	[61865391] = { aID=912, index=13, quest=8652 },
	[61957317] = { aID=914, index=3, quest=8648 },
	[61817153] = { aID=914, index=3, quest=8648, tip="Drop down in to here. Elder Darkcore is a short walk away" },
	[43259844] = { index=3, quest=56905, obj="Flower of Solemnity" },
}
points[ 241 ] = { -- Twilight Highlands
	[50917045] = { aID=6006, index=4, quest=29737 },
	[51883307] = { aID=6006, index=5, quest=29736 },
}
points[ 249 ] = { -- Uldum
	[65521866] = { aID=6006, index=2, quest=29742,  },
	[31586298] = { aID=6006, index=3, quest=29741 },
	[83793788] = { aID=911, index=15, quest=8671 },
}
points[ 1527 ] = { -- Uldum
	[65521866] = { aID=6006, index=2, quest=29742, tip="\124cFFFF0000Wrong version of Uldum. Speak to Zidormi" },
	[31606300] = { aID=6006, index=3, quest=29741, tip="\124cFFFF0000Wrong version of Uldum. Speak to Zidormi" },
}
points[ 90 ] = { -- Undercity
	[65993053] = { aID=914, index=3, quest=8648, tip="Drop down in to here. Elder Darkcore is a short walk away" },
	[66633821] = { aID=914, index=3, quest=8648, tip="The achievement text is wrong. Elder Darkcore\n"
					.."is NOT in the Undercity. Darkcore is above, in\nThe Ruins of Lordaeron" },
}
points[ 78 ] = { -- Un'Goro
	[50377617] = { aID=911, index=17, quest=8681 },
	[62323042] = { index=3, quest=56904, obj="Flower of Felicity" },
	[64162995] = { index=3, quest=56904, obj="Flower of Felicity" },
	[65002499] = { index=3, quest=56904, obj="Flower of Felicity" },
	[65323097] = { index=3, quest=56904, obj="Flower of Felicity" },
	[65422696] = { index=3, quest=56904, obj="Flower of Felicity" },
	[66542244] = { index=3, quest=56904, obj="Flower of Felicity" },
	[66763242] = { index=3, quest=56904, obj="Flower of Felicity" },
	[67852814] = { index=3, quest=56904, obj="Flower of Felicity" },
	[68603269] = { index=3, quest=56904, obj="Flower of Felicity" },
	[69683030] = { index=3, quest=56904, obj="Flower of Felicity" },
	[95553366] = { aID=910, index=1, quest=8676, tip="Enter Zul'Farrak. Follow the markers" },
}
points[ 133 ] = { -- Utgarde Keep - Njorndir Preparation
	[50652851] = { aID=910, index=7, quest=13017, tip="1) Defeat Dragonflayer Forgemasters\n"
												.."to remove the flaming wall barriers" },
	[23047190] = { aID=910, index=7, quest=13017, tip="2) Through this way" },
	[47236936] = { aID=910, index=7, quest=13017, tip="3) And when done, just retrace your steps" },
}
points[ 136 ] = { -- Utgarde Pinnacle - Lower Pinnacle
	[45858315] = { aID=910, index=13, quest=13067, tip="3) Up the stairs" },
	[56112473] = { aID=910, index=13, quest=13067, tip="8) Now that you're done, it's easiest to keep going" },
	[49154425] = { aID=910, index=13, quest=13067, tip="9) Up the ramp" },
	[48672327] = { aID=910, index=13, quest=13067, tip="Elder is here" },
}
points[ 137 ] = { -- Utgarde Pinnacle - Upper Pinnacle
	[40033590] = { aID=910, index=13, quest=13067, tip="1) Through this way" },
	[39906910] = { aID=910, index=13, quest=13067, tip="2) Keep going, ignore Svala, she appears\n"
												.."to have enough of her own problems" },
	[64276947] = { aID=910, index=13, quest=13067, tip="4) This way" },
	[68893930] = { aID=910, index=13, quest=13067,
					tip="5) You've got to do this fight. Kill mobs here.\nThey randomly drop harpoons. Use the harpoon\n"
						.."launcher to kill Grauf. Probably three shots.\nSkadi dismounts. You kill Skadi" },
	[64153634] = { aID=910, index=13, quest=13067, tip="6) The portcullis is now open" },
	[58633831] = { aID=910, index=13, quest=13067, tip="7) Jump down" },
	[44114416] = { aID=910, index=13, quest=13067,
					tip="10) Kill Ymiron to open the portcullis.\nStraight through and exit" },
}
points[ 203 ] = { -- Vashj'ir
	[69828250] = { aID=912, index=8, quest=8675 },
}
points[ 52 ] = { -- Westfall
	[56644709] = { aID=912, index=8, quest=8675 },
}
points[ 22 ] = { -- Western Plaguelands
	[65303876] = { aID=912, index=4, quest=8722, tip="Enter The Weeping Cave"},
	[63513611] = { aID=912, index=4, quest=8722, tip="Inside The Weeping Cave"},
	[69187345] = { aID=912, index=17, quest=8714 },
	[04154023] = { aID=912, index=13, quest=8652 },
	[96255275] = { aID=912, index=15, quest=8688 },
}
points[ 123 ] = { -- Wintergrasp
	[50001627] = { aID=1396, index=10, quest=13026, tip="He is through here. If your faction is not in control then see\n"
					.."my Easy Glitch Guide!\n\nIf your faction is in control then the Defender's Portal will work" },
	[49491452] = { aID=1396, index=10, quest=13026, 
					tip="Glitch Guide: 1) You MUST stand exactly here with your face\nburied into the corner.\n\n"
					.."If that is not possible then you are on the wrong ledge - fly\naround a bit.\n\n"
					.."With your face buried in the corner you must use a \"Lounge\nCushion\" toy such as the "
					.."\"Pineapple\", \"Safari\" or \"Zhevra\".\n\nYou may receive a warning you are going to "
					.."be teleported\noutside Wintergrasp, so don't muck around!\n\nYou are now \"inside\". "
					.."The problem now is to stand up.\nBlizzard stopped that. A mage blink works though. YMMV." },
	[49471373] = { aID=1396, index=10, quest=13026, 
					tip="Glitch Guide: 2) After using your Lounge Cushion, walk\nexactly to here and rotate "
					.."your downwards view so that\nyou can see the glitched interior.\n\n"
					.."If standing here then facing at about 201 degrees\n(my \"X and Y\" AddOn shows "
					.."degrees) you can jump\ndown onto a circular raised ledge.\n\nCannot see the interior? "
					.."Just jump down blindly!\n\nContinue with the Elder then use the Violet Citadel\n"
					.."portal or the Defender's Portal" },
}
points[ 83 ] = { -- Winterspring
	[53225675] = { aID=911, index=18, quest=8726 },
	[59964994] = { aID=911, index=19, quest=8672 },
	[56173028] = { index=3, quest=56906, obj="Flower of Generosity" },
	[55892949] = { index=3, quest=56906, obj="Flower of Generosity" },
	[56173028] = { index=3, quest=56906, obj="Flower of Generosity" },
	[56812862] = { index=3, quest=56906, obj="Flower of Generosity" },
	[56843730] = { index=3, quest=56906, obj="Flower of Generosity" },
	[57083253] = { index=3, quest=56906, obj="Flower of Generosity" },
	[57682999] = { index=3, quest=56906, obj="Flower of Generosity" },
	[57693201] = { index=3, quest=56906, obj="Flower of Generosity" },
	[57713710] = { index=3, quest=56906, obj="Flower of Generosity" },
	[57913552] = { index=3, quest=56906, obj="Flower of Generosity" },
	[58883399] = { index=3, quest=56906, obj="Flower of Generosity" },
}
points[ 121 ] = { -- Zul'Drak
	[58915597] = { aID=1396, index=11, quest=13027 },
	[28978375] = { aID=910, index=10, quest=13023, tip="The portal is through here" },
	[76112091] = { aID=910, index=11, quest=13065,
					tip="Use this entrance, not the other one.\n\nThanks for using my AddOn. Hope I helped! :)\n\n"
					.."I'm at Twitter and Ko-fi as @Taraezor.\nThere's also my project page at curseforge\n"
					.."where you might find more useful AddOns!" },
	[73899374] = { aID=1396, index=2, quest=13013 },
	[09734470] = { aID=1396, index=13, quest=13028 },
}
points[ 219 ] = { -- Zul'Farrak
	[34393931] = { aID=910, index=1, quest=8676, tip="Follow the map directly, no need for way-markers!" },
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
textures[7] = "Interface\\AddOns\\HandyNotes_LunarFestival\\CoinOfAncestryBlue"
textures[8] = "Interface\\AddOns\\HandyNotes_LunarFestival\\CoinOfAncestryDeepGreen"
textures[9] = "Interface\\AddOns\\HandyNotes_LunarFestival\\CoinOfAncestryDeepPink"
textures[10] = "Interface\\AddOns\\HandyNotes_LunarFestival\\CoinOfAncestryDeepRed"
textures[11] = "Interface\\AddOns\\HandyNotes_LunarFestival\\CoinOfAncestryGreen"
textures[12] = "Interface\\AddOns\\HandyNotes_LunarFestival\\CoinOfAncestryLightBlue"
textures[13] = "Interface\\AddOns\\HandyNotes_LunarFestival\\CoinOfAncestryPink"
textures[14] = "Interface\\AddOns\\HandyNotes_LunarFestival\\CoinOfAncestryPurple"
textures[15] = "Interface\\AddOns\\HandyNotes_LunarFestival\\CoinOfAncestryTeal"
textures[16] = "Interface\\AddOns\\HandyNotes_LunarFestival\\CoinOfAncestry"

scaling[1] = 0.55
scaling[2] = 0.55
scaling[3] = 0.55
scaling[4] = 0.55
scaling[5] = 0.55
scaling[6] = 0.55
scaling[7] = 0.4
scaling[8] = 0.4
scaling[9] = 0.4
scaling[10] = 0.4
scaling[11] = 0.4
scaling[12] = 0.4
scaling[13] = 0.4
scaling[14] = 0.4
scaling[15] = 0.4
scaling[16] = 0.4