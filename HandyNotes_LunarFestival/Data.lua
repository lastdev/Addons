local _, ns = ...
local points = ns.points
local textures = ns.textures
local scaling = ns.scaling
local colourPrefix		= ns.colour.prefix
local colourHighlight	= ns.colour.highlight
local colourPlaintext	= ns.colour.plaintext

local armada = "\"Flamer\": Do the \"You're a mean one...\" daily\n"
				.."(I've marked the Tanaan mob locations. Be patient,\n"
				.."drop rates are 10%. This pin marks your progress)"
										
-- Achievements:
-- Elders of the Dungeons		910	Alliance/Horde
-- Elders of Kalimdor			911	Alliance/Horde
-- Elders of Eastern Kingdoms	912	Alliance/Horde
-- Elders of The Horde			914	Alliance/Horde
-- Elders of The Alliance		915	Alliance/Horde
-- Elders of Northrend			1396	Alliance/Horde
-- Elders of Cataclysm			6006	Alliance/Horde

-- ===================================================
-- aIDA, aIDH, aIndexA, aIndexH, aQuestA, aQuestH, tip
-- ===================================================

points[ 63 ] = { -- Ashenvale
	[35604880] = { 911, 911, 9, 9, 8725, 8725, },
}
points[ 159 ] = { -- Azjol-Nerub - The Guilded Gate
	[54374440] = { 910, 910, 9, 9, 13022, 13022, "1) Enter the gate. You must kill the boss" },
	[66004350] = { 910, 910, 9, 9, 13022, 13022, "2) Jump down onto the left side stairs" },
	[70003450] = { 910, 910, 9, 9, 13022, 13022, "3) Go this way" },
}
points[ 158 ] = { -- Azjol-Nerub - Hadronox's Lair
	[41533715] = { 910, 910, 9, 9, 13022, 13022, "3) Go this way" },
	[61752850] = { 910, 910, 9, 9, 13022, 13022, "4) Keep going this way!" },
	[47176569] = { 910, 910, 9, 9, 13022, 13022, "5) Ignore Hadronox. Jump down here" },
	[49005820] = { 910, 910, 9, 9, 13022, 13022, "6) Now jump down again!" },
}
points[ 157 ] = { -- Azjol-Nerub - The Brood Pt
	[23005217] = { 910, 910, 9, 9, 13022, 13022, "7) You land here" },
	[36854877] = { 910, 910, 9, 9, 13022, 13022, "8) Exit is this way" },
	[75744913] = { 910, 910, 9, 9, 13022, 13022, "9) No need to kill Anub'arak" },
	[88527649] = { 910, 910, 9, 9, 13022, 13022, "10) You're welcome! :)" },
}
points[ 76 ] = { -- Azshara
	[64607920] = { 911, 911, 2, 2, 8720, 8720, },
}
points[ 97 ] = { -- Azuremyst Isle
}
points[ 242 ] = { -- Blackrock Depths - Detention Block
	[38007650] = { 910, 910, 5, 5, 8619, 8619, "1) This way" },
	[49007200] = { 910, 910, 5, 5, 8619, 8619, "2) This way" },
	[51406770] = { 910, 910, 5, 5, 8619, 8619, "3) Enter the Ring here, turn\n"
											.."in the quest and reverse to exit" },
}
points[ 34 ] = { -- Blackrock Mountain - Blackrock Caverns
	[53127138] = { 910, 910, 4, 4, 8644, 8644, "2) Continue past the barrier" },
	[52654551] = { 910, 910, 4, 4, 8644, 8644, "3) Go straight up" },
	[60142748] = { 910, 910, 4, 4, 8644, 8644, "4) Go up the ramp" },
}
points[ 35 ] = { -- Blackrock Mountain - Blackrock Depths
	[54848478] = { 910, 910, 5, 5, 8619, 8619, "1) Fly down to here" },
	[55818208] = { 910, 910, 5, 5, 8619, 8619, "2) Come this way" },
	[45716843] = { 910, 910, 5, 5, 8619, 8619, "3) This way" },
	[37714228] = { 910, 910, 5, 5, 8619, 8619, "4) This way" },
	[39171822] = { 910, 910, 5, 5, 8619, 8619, "5) Enter through here and follow the markers" },
}
points[ 33 ] = { -- Blackrock Mountain - Blackrock Spire
	[65676078] = { 910, 910, 4, 4, 8644, 8644, "1) Enter through here" },
	[72524765] = { 910, 910, 4, 4, 8644, 8644, "5) Continue upwards" },
	[70775311] = { 910, 910, 4, 4, 8644, 8644, "6) Continue upwards" },
	[63454416] = { 910, 910, 4, 4, 8644, 8644, "7) Shortcut upwards. You can fly up to here!" },
	[72903983] = { 910, 910, 4, 4, 8644, 8644, "8) Continue forward and down the ramp.\n"
											.."Portal is to your right" },
	[80324026] = { 910, 910, 4, 4, 8644, 8644, "9) Enter through here and follow the markers" },
	[39494029] = { 910, 910, 5, 5, 8619, 8619, "1) Fly down to here" },
}
points[ 251 ] = { -- Blackrock Spire - Skitterweb Tunnels
	[58904260] = { 910, 910, 4, 4, 8644, 8644, "3) Cross the bridge" },
	[65404260] = { 910, 910, 4, 4, 8644, 8644, "4) Turn in the quest. Reverse to exit" },
}
points[ 252 ] = { -- Blackrock Spire - Hordemar City
	[39004800] = { 910, 910, 4, 4, 8644, 8644, "1) Begin by following the path down\n"
												.."and then left to here. Keep going" },
	[60404270] = { 910, 910, 4, 4, 8644, 8644, "3) Cross the bridge" },
}
points[ 253 ] = { -- Blackrock Spire - Hall of Blackhand
	[48004100] = { 910, 910, 4, 4, 8644, 8644, "2) Plow on past the mobs" },
}
points[ 105 ] = { -- Blade's Edge Mountains
}
points[ 17 ] = { -- Blasted Lands
	[54204960] = { 912, 912, 2, 2, 8647, 8647, "Can't find him? Speak to Zidormi" },
}
points[ 114 ] = { -- Borean Tundra
	[59006560] = { 1396, 1396, 1, 1, 13012, 13012, },
	[57404360] = { 1396, 1396, 5, 5, 13033, 13033, },
	[33803420] = { 1396, 1396, 6, 6, 13016, 13016, },
	[43004940] = { 1396, 1396, 15, 15, 13029, 13029, },
	[27512594] = { 910, 910, 8, 8, 13021, 13021, "Enter through here and follow the markers.\n\n"
												.."The lowest portal is for The Nexus" },
}
points[ 36 ] = { -- Burning Steppes
	[70004560] = { 912, 912, 9, 9, 8636, 8636, },
	[52602400] = { 912, 912, 10, 10, 8683, 8683, },
	[20201803] = { 910, 910, 4, 4, 8644, 8644, "Enter through here and follow the markers" },
	[20201603] = { 910, 910, 5, 5, 8619, 8619, "Enter through here and follow the markers" },
	[21023744] = { 910, 910, 4, 4, 8644, 8644, "Enter through here and follow the markers" },
	[21023944] = { 910, 910, 5, 5, 8619, 8619, "Enter through here and follow the markers" },
}
points[ 127 ] = { -- Crystalsong Forest
}
points[ 125 ] = { -- Dalaran
	-- Dalaran will not show in Crystalsong Forest but it will propagate upwards
}
points[ 62 ] = { -- Darkshore
	[49501895] = { 911, 911, 7, 7, 8721, 8721, "If Teldrassil looks destroyed\n"
												.."then have a chat with Zidormi!" },
}
points[ 89 ] = { -- Darnassus
	[39603200] = { 915, 915, 1, 1, 8718, 8718, }, -- Split. horde need help
}
points[ 207 ] = { -- Deepholm
	[49605480] = { 6006, 6006, 1, 1, 29735, 29735, },
	[27606920] = { 6006, 6006, 9, 9, 29734, 29734, },
}
points[ 66 ] = { -- Desolace
	-- 67 The Wicked Grotto, 68 - Foulspore Cavern
	[29626248] = { 910, 910, 3, 3, 8635, 8635, "Enter Maraudon. Follow the markers" },
}
points[ 115 ] = { -- Dragonblight
	[29805580] = { 1396, 1396, 3, 3, 13014, 13014, },
	[47767815] = { 1396, 1396, 12, 12, 13019, 13019, },
	[35004840] = { 1396, 1396, 17, 17, 13031, 13031, },
	[26134950] = { 910, 910, 9, 9, 13022, 13022, "Drop down here, face south and locate the portal and enter" },
	[26814899] = { 910, 910, 9, 9, 13022, 13022, "After you exit the dungeon, use the path\n"
												.."here and very soon after you may mount" },
}
points[ 161 ] = { -- Drak'Tharon Keep - Drak'Tharon Overlook
	[36554553] = { 910, 910, 10, 10, 13023, 13023, "5) So you did decide to come this way. Awesome!\n"
													.."Keep going, it's all linear" },
	[43271321] = { 910, 910, 10, 10, 13023, 13023, "6) Ignore The Prophet. Just keep going" },
	[38051726] = { 910, 910, 10, 10, 13023, 13023, "7) Jump down and turn around and you'll see a\n"
													.."short hallway then jump again into the water\n"
													.."and then jump once more into the water!" },
}
points[ 160 ] = { -- Drak'Tharon Keep - The Vestibules of Drak'Tharon
	[50654047] = { 910, 910, 10, 10, 13023, 13023, "1) Go through here" },
	[60971879] = { 910, 910, 10, 10, 13023, 13023, "2) Through here. No need to whoop Trollie" },
	[67875507] = { 910, 910, 10, 10, 13023, 13023, "3) Through here. You can bypass Novos too" },
	[55636125] = { 910, 910, 10, 10, 13023, 13023, "4) Exit here" },
	[46031310] = { 910, 910, 10, 10, 13023, 13023, "8) You made it! Follow the passage. You know the rest!" },
	[66507710] = { 910, 910, 10, 10, 13023, 13023, "Elder Kilias is located here. Whew! now the exit :(...\n\n"
												.."A sad choice of backtracking or go up stairs, kill the\n"
												.."last boss and jump down. Your call" },
}
points[ 27 ] = { -- Dun Morogh
	[53804980] = { 912, 912, 1, 1, 8653, 8653, },
}
points[ 1 ] = { -- Durotar
	[53204360] = { 911, 911, 1, 1, 8670, 8670, },
}
points[ 47 ] = { -- Duskwood
}
points[ 70 ] = { -- Dustwallow Marsh
}
points[ 23 ] = { -- Eastern Plaguelands
	[35606880] = { 912, 912, 15, 15, 8688, 8688, },
	[75505450] = { 912, 912, 16, 16, 8650, 8650, },
	[26531159] = { 910, 910, 6, 6, 8727, 8727, "Enter through here and follow the markers" },
}
points[ 37 ] = { -- Elwynn Forest
	[39806360] = { 912, 912, 3, 3, 8649, 8649, },
	[34605060] = { 915, 915, 3, 3, 8646, 8646, }, -- Split. horde need help
}
points[ 94 ] = { -- Eversong Woods
}
points[ 77 ] = { -- Felwood
	[38405280] = { 911, 911, 12, 12, 8723, 8723, },
}
points[ 69 ] = { -- Feralas
	[76603780] = { 911, 911, 10, 10, 8679, 8679, "In the Lariss Pavillion" },
	[62603100] = { 911, 911, 11, 11, 8685, 8685, "In the Dire Maul arena -\n"
												.."she's not in the instance" },
}
points[ 95 ] = { -- Ghostlands
}
points[ 116 ] = { -- Grizzly Hills
	[60602760] = { 1396, 1396, 2, 2, 13013, 13013, },
	[80603700] = { 1396, 1396, 9, 9, 13025, 13025, },
	[64204700] = { 1396, 1396, 16, 16, 13030, 13030, },
	[17792703] = { 910, 910, 10, 10, 13023, 13023, "The portal is through here" },
}
points[ 154 ] = { -- Gundrak
	[58634038] = { 910, 910, 11, 11, 13065, 13065, "1) Jump in the water and exit here" },
	[58635714] = { 910, 910, 11, 11, 13065, 13065, "2) Through this doorway" },
	[47007325] = { 910, 910, 11, 11, 13065, 13065, "3) This way" },
	[46806190] = { 910, 910, 11, 11, 13065, 13065, "4) After Elder Ohanzee, reverse to exit" },
}
points[ 140 ] = { -- Halls of Stone
	[29106090] = { 910, 910, 12, 12, 13066, 13066, "Here he is!" },
}
points[ 117 ] = { -- Howling Fjord
	[58854834] = { 910, 910, 7, 7, 13017, 13017, "Utgarde Keep is this way. It at the base" },
	[57254671] = { 910, 910, 13, 13, 13067, 13067, "This is the correct portal. It's up quite high" },
}
points[ 118 ] = { -- Icecrown
}
points[ 87 ] = { -- Ironforge
	[29001700] = { 915, 915, 2, 2, 8866, 8866, }, -- Split. horde need help
}
points[ 48 ] = { -- Loch Modan
	[33204660] = { 912, 912, 7, 7, 8642, 8642, },
}
points[ 68 ] = { -- Maraudon - Foulspore Cavern
	[46788822] = { 910, 910, 3, 3, 8635, 8635, "If you are here then you have come the correct way.\n"
												.."It's a linear path. The instance portal is ahead" },
}
points[ 67 ] = { -- Maraudon - The Wicked Grotto
	-- 68 - Foulspore Cavern
	[19345583] = { 910, 910, 3, 3, 8635, 8635, "This is where you respawn if you were wondering" },
	[25004335] = { 910, 910, 3, 3, 8635, 8635, "Instance entrance/exit" },
	[17005350] = { 910, 910, 3, 3, 8635, 8635, "Follow the path.\n\n"
												.."At \"Zaetar's Choice\" enter the arch that is\n"
												.."guarded by two centaurs. Do not take the left\n"
												.."pink/purple path, nor the right red/orange path" },
}
points[ 281 ] = { -- Maraudon - Zaelar's Grave
	[28083508] = { 910, 910, 3, 3, 8635, 8635, "This is where you \"land\" upon entry\n"
												.."to the instance. Go straight ahead,\n"
												.."jumping down and through the cutting" },
	[33006070] = { 910, 910, 3, 3, 8635, 8635, "Through here and follow the path" },
	[45405480] = { 910, 910, 3, 3, 8635, 8635, "You now have a choice. Go right. In other\n"
												.."words, do not take the (left) ramp upwards" },
	[40007340] = { 910, 910, 3, 3, 8635, 8635, "You're now in an area with a waterfall, a\n"
												.."Primordial Behemoth, a bridge and a river.\n"
												.."Continue over the bridge. Don't jump down.\n"
												.."It's a linear path, you can't get lost!" },
	[51509370] = { 910, 910, 3, 3, 8635, 8635, "Elder Splitrock is here" },
	[54708660] = { 910, 910, 3, 3, 8635, 8635, "After Elder Splitrock, don't bother looking\n"
												.."for a way out down here. There isn't one.\n"
												.."Hearth or portal" },
}
points[ 198 ] = { -- Mount Hyjal
	[26606200] = { 6006, 6006, 6, 6, 29739, 29739, },
	[62602280] = { 6006, 6006, 7, 7, 29740, 29740, },
}
points[ 7 ] = { -- Mulgore
	[47606080] = { 911, 911, 8, 8, 8673, 8673, },
}
points[ 10 ] = { -- Northern Barrens
	[48605920] = { 911, 911, 3, 3, 8717, 8717, },
	[68407000] = { 911, 911, 5, 5, 8680, 8680, },
}
points[ 50 ] = { -- Northern Stranglethorn
	[71003420] = { 912, 912, 5, 5, 8716, 8716, },
}
points[ 85 ] = { -- Orgrimmar
	[52606020] = { 914, 914, 1, 1, 8677, 8677, }, -- Split. alliance need help
}
points[ 32 ] = { -- Searing Gorge
	[21307800] = { 912, 912, 12, 12, 8651, 8651, },
	[34898498] = { 910, 910, 4, 4, 8644, 8644, "Enter through here and follow the markers" },
	[34898298] = { 910, 910, 5, 5, 8619, 8619, "Enter through here and follow the markers" },
}
points[ 111 ] = { -- Shattrath City
}
points[ 205 ] = { -- Shimmering Expanse in Vashj'ir
	[57208620] = { 6006, 6006, 8, 8, 29738, 29738, },
}
points[ 119 ] = { -- Sholazar Basin
	[49806360] = { 1396, 1396, 7, 7, 13018, 13018, },
	[63804900] = { 1396, 1396, 8, 8, 13024, 13024, },
}
points[ 81 ] = { -- Silithus
	[30801350] = { 911, 911, 20, 20, 8654, 8654, "Visit Zidormi if you see a\n"
												.."huge sword stuck into Azeroth" },
	[53003560] = { 911, 911, 21, 21, 8719, 8719, "Visit Zidormi if you see a\n"
												.."huge sword stuck into Azeroth" },
}
points[ 110 ] = { -- Silvermoon City
}
points[ 21 ] = { -- Silverpine Forest
	[44924123] = { 912, 912, 14, 14, 8645, 8645, },
}
points[ 199 ] = { -- Southern Barrens
	[41504760] = { 911, 911, 4, 4, 8686, 8686, },
}
points[ 120 ] = { -- Storm Peaks
	[28807360] = { 1396, 1396, 4, 4, 13015, 13015, },
	[41008460] = { 1396, 1396, 13, 13, 13028, 13028, },
	[31203760] = { 1396, 1396, 14, 14, 13020, 13020, },
	[64605120] = { 1396, 1396, 18, 18, 13032, 13032, "BM Hunters doing the Hati quest chain\n"
													.."(to get Hati back) will be phased out" },
	[39482691] = { 910, 910, 12, 12, 13066, 13066, "Enter through here" },
}
points[ 84 ] = { -- Stormwind City
}
points[ 224 ] = { -- Stranglethorn Vale
}
points[ 317 ] = { -- Stratholme
	[73505480] = { 910, 910, 6, 6, 8727, 8727, "Lift the portcullis" },
	[78302050] = { 910, 910, 6, 6, 8727, 8727, "Exit the same way you entered" },
}
points[ 51 ] = { -- Swamp of Sorrows
	[69425487] = { 910, 910, 2, 2, 8713, 8713, "Enter the Temple of Atal'Hakkar,\n"
											.."also known as the Sunken Temple.\n\n"
											.."1) Descend the twisting path.\n"
											.."2) Momentarily submerge into the pool.\n\n"
											.."3) Resurface and follow the path and\n"
											.."enter the portal and follow the markers" },
}
points[ 534 ] = { -- Tanaan Jungle
}
points[ 71 ] = { -- Tanaris
	[37297894] = { 911, 911, 15, 15, 8671, 8671, },
	[51402880] = { 911, 911, 16, 16, 8684, 8684, },
	[39222134] = { 910, 910, 1, 1, 8676, 8676, "Enter Zul'Farrak. Follow the markers" },
}
points[ 57 ] = { -- Teldrassil
	[56805300] = { 911, 911, 6, 6, 8715, 8715, },
}
points[ 210 ] = { -- The Cape of Stranglethorn
	[40007260] = { 912, 912, 6, 6, 8674, 8674, },
}
points[ 103 ] = { -- The Exodar
}
points[ 26 ] = { -- The Hinterlands
	[50004800] = { 912, 912, 11, 11, 8643, 8643, },
}
points[ 129 ] = { -- The Nexus
	[38707760] = { 910, 910, 8, 8, 13021, 13021, "1) This way!" },
	[50006600] = { 910, 910, 8, 8, 13021, 13021, "2) This way!" },
	[61505220] = { 910, 910, 8, 8, 13021, 13021, "3) This way!" },
	[61906400] = { 910, 910, 8, 8, 13021, 13021, "4) This way!" },
	[52756990] = { 910, 910, 8, 8, 13021, 13021, "5) Come up this way for a shortcut exit!" },
}
points[ 143 ] = { -- The Oculus
}
points[ 220 ] = { -- The Temple of Atal'Hakkar
	[62503510] = { 910, 910, 2, 2, 8713, 8713, },
	[50002500] = { 910, 910, 2, 2, 8713, 8713, "Head straight for the other marker" },
}
points[ 64 ] = { -- Thousand Needles
	[46405100] = { 911, 911, 13, 13, 8682, 8682, },
	[77007560] = { 911, 911, 14, 14, 8724, 8724, },
}
points[ 88 ] = { -- Thunder Bluff
	[73602400] = { 914, 914, 2, 2, 8678, 8678, }, -- Split. alliance need help
}
points[ 18 ] = { -- Tirisfal Glades
	[61805400] = { 912, 912, 13, 13, 8652, 8652, },
}
points[ 241 ] = { -- Twilight Highlands
	[50807040] = { 6006, 6006, 4, 4, 29737, 29737, },
	[51803300] = { 6006, 6006, 5, 5, 29736, 29736, },
}
points[ 249 ] = { -- Uldum
	[65401860] = { 6006, 6006, 2, 2, 29742, 29742, "\124cFFFF0000Wrong version of Uldum. Speak to Zidormi" },
	[31606300] = { 6006, 6006, 3, 3, 29741, 29741, "\124cFFFF0000Wrong version of Uldum. Speak to Zidormi" },
}
points[ 1527 ] = { -- Uldum
	[65401860] = { 6006, 6006, 2, 2, 29742, 29742, },
	[31606300] = { 6006, 6006, 3, 3, 29741, 29741, },
}
points[ 90 ] = { -- Undercity
	[67003720] = { 914, 914, 3, 3, 8648, 8648, }, -- Split. alliance need help
}
points[ 78 ] = { -- Un'Goro
	[50607620] = { 911, 911, 17, 17, 8681, 8681, },
}
points[ 133 ] = { -- Utgarde Keep - Njorndir Preparation
	[50652851] = { 910, 910, 7, 7, 13017, 13017, "1) Defeat Dragonflayer Forgemasters\n"
												.."to remove the flaming wall barriers" },
	[23047190] = { 910, 910, 7, 7, 13017, 13017, "2) Through this way" },
	[47507080] = { 910, 910, 7, 7, 13017, 13017, "3) And when done, just retrace your steps" },
}
points[ 136 ] = { -- Utgarde Pinnacle - Lower Pinnacle
	[45858315] = { 910, 910, 13, 13, 13067, 13067, "3) Up the stairs" },
	[56112473] = { 910, 910, 13, 13, 13067, 13067, "8) Now that you're done (he's under the stairs)..\n"
													.."It's easiest to keep going" },
	[49154425] = { 910, 910, 13, 13, 13067, 13067, "9) Up the ramp" },
}
points[ 137 ] = { -- Utgarde Pinnacle - Upper Pinnacle
	[40033590] = { 910, 910, 13, 13, 13067, 13067, "1) Through this way" },
	[39906910] = { 910, 910, 13, 13, 13067, 13067, "2) Keep going, ignore Svala, she appears\n"
												.."to have enough of her own problems" },
	[64276947] = { 910, 910, 13, 13, 13067, 13067, "4) This way" },
	[68893930] = { 910, 910, 13, 13, 13067, 13067, "5) You've got to do this fight. Kill mobs here.\n"
												.."They randomly drop harpoons. Use the harpoon\n"
												.."launcher to kill Grauf. Probably three shots.\n"
												.."Skadi dismounts. You kill Skadi" },
	[64153634] = { 910, 910, 13, 13, 13067, 13067, "6) The portcullis is now open" },
	[58633831] = { 910, 910, 13, 13, 13067, 13067, "7) Jump down" },
	[44114416] = { 910, 910, 13, 13, 13067, 13067, "10) Kill Ymiron to open the portcullis.\n"
												.."Straight through and exit" },
}
points[ 52 ] = { -- Westfall
	[56604700] = { 912, 912, 8, 8, 8675, 8675, },
}
points[ 22 ] = { -- Western Plaguelands
	[39806360] = { 912, 912, 4, 4, 8722, 8722, },
	[69107350] = { 912, 912, 17, 17, 8714, 8714, },
}
points[ 56 ] = { -- Wetlands
}
points[ 123 ] = { -- Wintergrasp
	[50001627] = { 1396, 1396, 10, 10, 13026, 13026, "He is through here. If your faction is not in control then see\n"
													.."my Easy Glitch Guide!\n\n"
													.."If your faction is in control then the Defender's Portal will work" },
	[49491452] = { 1396, 1396, 10, 10, 13026, 13026, "Glitch Guide: 1) You MUST stand exactly here with your face\n"
													.."buried into the corner.\n\n"
													.."If that is not possible then you are on the wrong ledge - fly\n"
													.."around a bit.\n\n"
													.."With your face buried in the corner you must use a \"Lounge\n"
													.."Cushion\" toy such as the \"Pineapple\", \"Safari\" or \"Zhevra\"" },
	[49471373] = { 1396, 1396, 10, 10, 13026, 13026, "Glitch Guide: 2) After using your Lounge Cushion, walk exactly to\n"
													.."here and rotate your downwards view so that you can see the\n"
													.."glitched interior.\n\n"
													.."If standing here then facing at about 201 degrees (my \"X and Y\" AddOn\n"
													.."shows degrees) you can jump down onto a circular raised ledge.\n\n"
													.."Continue with the Elder then hearth/portal out" },
}
points[ 83 ] = { -- Winterspring
	[53205660] = { 911, 911, 18, 18, 8726, 8726, },
	[59804980] = { 911, 911, 19, 19, 8672, 8672, },
}
points[ 121 ] = { -- Zul'Drak
	[58805600] = { 1396, 1396, 11, 11, 13027, 13027, },
	[28978375] = { 910, 910, 10, 10, 13023, 13023, "The portal is through here" },
	[76112091] = { 910, 910, 11, 11, 13065, 13065, "Use this entrance, not the other one" },
}
points[ 219 ] = { -- Zul'Farrak
	[34443918] = { 910, 910, 1, 1, 8676, 8676, },
}

points[ 12 ] = { -- Kalimdor
}

points[ 582 ] = { -- Lunarfall Garrison in Draenor
}
points[ 539 ] = { -- Shadowmoon Valley in Draenor
}
points[ 590 ] = { -- Frostwall Garrison in Draenor
}
points[ 525 ] = { -- Frostfire Ridge in Draenor
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