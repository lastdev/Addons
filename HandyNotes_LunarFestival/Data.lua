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
	[35544891] = { 911, 911, 9, 9, 8725, 8725, },
	[60207290] = { 0, 0, 4, 4, 56842, 56842, "Lunar Preservation" },
	[53744600] = { 0, 0, 3, 3, 56842, 56842, "Lunar Preservation" },
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
	[21724319] = { 910, 910, 9, 9, 13022, 13022, "8) Elder is here" },
	[36854877] = { 910, 910, 9, 9, 13022, 13022, "9) Exit is this way" },
	[75744913] = { 910, 910, 9, 9, 13022, 13022, "10) No need to kill Anub'arak" },
	[88527649] = { 910, 910, 9, 9, 13022, 13022, "11) You're welcome! :)" },
}
points[ 76 ] = { -- Azshara
	[64737934] = { 911, 911, 2, 2, 8720, 8720, },
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
	[61934012] = { 910, 910, 4, 4, 8644, 8644, "4) Turn in the quest. Reverse to exit" },
}
points[ 252 ] = { -- Blackrock Spire - Hordemar City
	[39004800] = { 910, 910, 4, 4, 8644, 8644, "1) Begin by following the path down\n"
												.."and then left to here. Keep going" },
	[60404270] = { 910, 910, 4, 4, 8644, 8644, "3) Cross the bridge" },
}
points[ 253 ] = { -- Blackrock Spire - Hall of Blackhand
	[48004100] = { 910, 910, 4, 4, 8644, 8644, "2) Plough on past the mobs. Depending upon your\n"
												.."graphics settings, you can see Elder Stonefort from here" },
}
points[ 17 ] = { -- Blasted Lands
	[54284950] = { 912, 912, 2, 2, 8647, 8647, "Can't find him? Speak to Zidormi" },
}
points[ 114 ] = { -- Borean Tundra
	[59096564] = { 1396, 1396, 1, 1, 13012, 13012, },
	[57404372] = { 1396, 1396, 5, 5, 13033, 13033, },
	[33803436] = { 1396, 1396, 6, 6, 13016, 13016, },
	[42934957] = { 1396, 1396, 15, 15, 13029, 13029, "Actually above the Mightstone Quarry" },
	[27512594] = { 910, 910, 8, 8, 13021, 13021, "Enter through here and follow the markers.\n\n"
												.."The lowest portal is for The Nexus" },
}
points[ 36 ] = { -- Burning Steppes
	[70114538] = { 912, 912, 9, 9, 8636, 8636, },
	[52382393] = { 912, 912, 10, 10, 8683, 8683, },
	[20201803] = { 910, 910, 4, 4, 8644, 8644, "Enter through here and follow the markers" },
	[20201603] = { 910, 910, 5, 5, 8619, 8619, "Enter through here and follow the markers" },
	[21023744] = { 910, 910, 4, 4, 8644, 8644, "Enter through here and follow the markers" },
	[21023944] = { 910, 910, 5, 5, 8619, 8619, "Enter through here and follow the markers" },
}
points[ 62 ] = { -- Darkshore
	[49541895] = { 911, 911, 7, 7, 8721, 8721, "If Teldrassil looks destroyed then have a chat with Zidormi!" },
}
points[ 89 ] = { -- Darnassus
	[39203185] = { 915, 915, 1, 1, 8718, 8718, },
	[37325047] = { 0, 915, 0, 1, 0, 8718, "Immediately go left and up high - don't delay" },
	[30402709] = { 0, 915, 0, 1, 0, 8718, "Hide here for respite/cooldowns, as necessary" },
}
points[ 207 ] = { -- Deepholm
	[49705488] = { 6006, 6006, 1, 1, 29735, 29735, },
	[27706918] = { 6006, 6006, 9, 9, 29734, 29734, },
}
points[ 66 ] = { -- Desolace
	[29626248] = { 910, 910, 3, 3, 8635, 8635, "Enter Maraudon. Follow the markers" },
	[50225001] = { 0, 0, 1, 1, 56905, 56905, "Flower of Compassion" },
	[50284566] = { 0, 0, 1, 1, 56905, 56905, "Flower of Compassion" },
	[50904702] = { 0, 0, 1, 1, 56905, 56905, "Flower of Compassion" },
	[51074943] = { 0, 0, 1, 1, 56905, 56905, "Flower of Compassion" },
	[51384509] = { 0, 0, 1, 1, 56905, 56905, "Flower of Compassion" },
	[52095157] = { 0, 0, 1, 1, 56905, 56905, "Flower of Compassion" },
	[52774955] = { 0, 0, 1, 1, 56905, 56905, "Flower of Compassion" },
	[53104525] = { 0, 0, 1, 1, 56905, 56905, "Flower of Compassion" },
	[53335138] = { 0, 0, 1, 1, 56905, 56905, "Flower of Compassion" },
	[54784717] = { 0, 0, 1, 1, 56905, 56905, "Flower of Compassion" },
}
points[ 115 ] = { -- Dragonblight
	[29755591] = { 1396, 1396, 3, 3, 13014, 13014, },
	[48777817] = { 1396, 1396, 12, 12, 13019, 13019, },
	[35104835] = { 1396, 1396, 17, 17, 13031, 13031, },
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
	[69077927] = { 910, 910, 10, 10, 13023, 13023, "Elder Kilias is located here. Whew! now the exit :(...\n\n"
												.."A sad choice of backtracking or go up stairs, kill the\n"
												.."last boss (optional) and jump down. Your call" },
}
points[ 27 ] = { -- Dun Morogh
	[53904991] = { 912, 912, 1, 1, 8653, 8653, },
	[60173345] = { 0, 915, 0, 2, 0, 8866, "Fly through here, keep to the left" }, 
	[45775808] = { 0, 0, 2, 2, 56906, 56906, "Flower of Luck" },
	[46125820] = { 0, 0, 2, 2, 56906, 56906, "Flower of Luck" },
	[46226042] = { 0, 0, 2, 2, 56906, 56906, "Flower of Luck" },
	[47485862] = { 0, 0, 2, 2, 56906, 56906, "Flower of Luck" },
	[48205348] = { 0, 0, 2, 2, 56906, 56906, "Flower of Luck" },
	[48265985] = { 0, 0, 2, 2, 56906, 56906, "Flower of Luck" },
	[48355544] = { 0, 0, 2, 2, 56906, 56906, "Flower of Luck" },
	[49965302] = { 0, 0, 2, 2, 56906, 56906, "Flower of Luck" },
	[51705259] = { 0, 0, 2, 2, 56906, 56906, "Flower of Luck" },
	[52545662] = { 0, 0, 2, 2, 56906, 56906, "Flower of Luck" },
}
points[ 1 ] = { -- Durotar
	[53234361] = { 911, 911, 1, 1, 8670, 8670, "Alliance need to be very quick with this one" },
	[47000300] = { 914, 914, 1, 1, 8677, 8677, "Alliance need to be very quick with this one" },
}
points[ 47 ] = { -- Duskwood
	[49153323] = { 0, 0, 7, 7, 56842, 56842, "Lunar Preservation" },
	[59012185] = { 0, 0, 2, 2, 56905, 56905, "Flower of Reflection" },
	[60082518] = { 0, 0, 2, 2, 56905, 56905, "Flower of Reflection" },
	[60152031] = { 0, 0, 2, 2, 56905, 56905, "Flower of Reflection" },
	[63013300] = { 0, 0, 2, 2, 56905, 56905, "Flower of Reflection" },
	[63872163] = { 0, 0, 2, 2, 56905, 56905, "Flower of Reflection" },
	[64132513] = { 0, 0, 2, 2, 56905, 56905, "Flower of Reflection" },
	[64982878] = { 0, 0, 2, 2, 56905, 56905, "Flower of Reflection" },
	[66163376] = { 0, 0, 2, 2, 56905, 56905, "Flower of Reflection" },
	[67682256] = { 0, 0, 2, 2, 56905, 56905, "Flower of Reflection" },
	[68321900] = { 0, 0, 2, 2, 56905, 56905, "Flower of Reflection" },
}
points[ 23 ] = { -- Eastern Plaguelands
	[35586882] = { 912, 912, 15, 15, 8688, 8688, },
	[75505450] = { 912, 912, 16, 16, 8650, 8650, },
	[26531159] = { 910, 910, 6, 6, 8727, 8727, "Enter through here and follow the markers" },
}
points[ 37 ] = { -- Elwynn Forest
	[39796367] = { 912, 912, 3, 3, 8649, 8649, },
	[34565025] = { 915, 915, 3, 3, 8646, 8646, },
}
points[ 1644 ] = { -- Ember Court
	[38365285] = { 0, 0, 0, 0, 63213, 63213, "Elder Naladu" },
}
points[ 94 ] = { -- Eversong Woods
	[39426745] = { 0, 0, 1, 1, 56903, 56903, "Flower of Fortitude" },
	[40786500] = { 0, 0, 1, 1, 56903, 56903, "Flower of Fortitude" },
	[40847300] = { 0, 0, 1, 1, 56903, 56903, "Flower of Fortitude" },
	[42696870] = { 0, 0, 1, 1, 56903, 56903, "Flower of Fortitude" },
	[43456364] = { 0, 0, 1, 1, 56903, 56903, "Flower of Fortitude" },
	[44946799] = { 0, 0, 1, 1, 56903, 56903, "Flower of Fortitude" },
	[46226210] = { 0, 0, 1, 1, 56903, 56903, "Flower of Fortitude" },
	[46447190] = { 0, 0, 1, 1, 56903, 56903, "Flower of Fortitude" },
	[46506526] = { 0, 0, 1, 1, 56903, 56903, "Flower of Fortitude" },
}
points[ 77 ] = { -- Felwood
	[38365285] = { 911, 911, 12, 12, 8723, 8723, },
	[44042841] = { 0, 0, 2, 2, 56842, 56842, "Lunar Preservation" },
}
points[ 69 ] = { -- Feralas
	[76713790] = { 911, 911, 10, 10, 8679, 8679, "In the Lariss Pavillion" },
	[62563107] = { 911, 911, 11, 11, 8685, 8685, "In the Dire Maul arena - she's not in the instance" },
	[60214625] = { 0, 0, 6, 6, 56842, 56842, "Lunar Preservation" },
}
points[ 116 ] = { -- Grizzly Hills
	[60572768] = { 1396, 1396, 2, 2, 13013, 13013, },
	[80533711] = { 1396, 1396, 9, 9, 13025, 13025, },
	[64184699] = { 1396, 1396, 16, 16, 13030, 13030, },
	[17792703] = { 910, 910, 10, 10, 13023, 13023, "The portal is through here" },
}
points[ 154 ] = { -- Gundrak
	[58634038] = { 910, 910, 11, 11, 13065, 13065, "1) Jump in the water and exit here" },
	[58635714] = { 910, 910, 11, 11, 13065, 13065, "2) Through this doorway" },
	[47007325] = { 910, 910, 11, 11, 13065, 13065, "3) This way" },
	[45556119] = { 910, 910, 11, 11, 13065, 13065, "4) After Elder Ohanzee, reverse to exit" },
}
points[ 140 ] = { -- Halls of Stone
	[29176225] = { 910, 910, 12, 12, 13066, 13066, "Here he is!" },
}
points[ 25 ] = { -- Hillsbrad Foothills
	[46622052] = { 0, 0, 1, 1, 56906, 56906, "Flower of Thoughtfulness" },
	[47201864] = { 0, 0, 1, 1, 56906, 56906, "Flower of Thoughtfulness" },
	[47862141] = { 0, 0, 1, 1, 56906, 56906, "Flower of Thoughtfulness" },
	[48082546] = { 0, 0, 1, 1, 56906, 56906, "Flower of Thoughtfulness" },
	[48281758] = { 0, 0, 1, 1, 56906, 56906, "Flower of Thoughtfulness" },
	[49772611] = { 0, 0, 1, 1, 56906, 56906, "Flower of Thoughtfulness" },
	[50092111] = { 0, 0, 1, 1, 56906, 56906, "Flower of Thoughtfulness" },
	[51052305] = { 0, 0, 1, 1, 56906, 56906, "Flower of Thoughtfulness" },
	[52902309] = { 0, 0, 1, 1, 56906, 56906, "Flower of Thoughtfulness" },
	[53052549] = { 0, 0, 1, 1, 56906, 56906, "Flower of Thoughtfulness" },
}

points[ 117 ] = { -- Howling Fjord
	[58854834] = { 910, 910, 7, 7, 13017, 13017, "Utgarde Keep is this way. It at the base" },
	[57254671] = { 910, 910, 13, 13, 13067, 13067, "This is the correct portal. It's up quite high" },
}
points[ 87 ] = { -- Ironforge
	[29191705] = { 915, 915, 2, 2, 8866, 8866, }, 
	[12158801] = { 0, 915, 0, 2, 0, 8866, "1) Fly through here, keep to the left" }, 
	[24365947] = { 0, 915, 0, 2, 0, 8866, "2) Drop straight down into here and follow to the left" }, 
	[23683637] = { 0, 915, 0, 2, 0, 8866, "3) Stick your head up a little and assess the situation" }, 
}
points[ 48 ] = { -- Loch Modan
	[33334655] = { 912, 912, 7, 7, 8642, 8642, },
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
	[51379385] = { 910, 910, 3, 3, 8635, 8635, "Elder Splitrock is here" },
	[54708660] = { 910, 910, 3, 3, 8635, 8635, "After Elder Splitrock, don't bother looking\n"
												.."for a way out down here. There isn't one.\n"
												.."Hearth or portal" },
}
points[ 80 ] = { -- Moonglade
	[48643293] = { 0, 0, 1, 1, 56842, 56842, "Lunar Preservation" },
}
points[ 198 ] = { -- Mount Hyjal
	[26696205] = { 6006, 6006, 6, 6, 29739, 29739, },
	[62542282] = { 6006, 6006, 7, 7, 29740, 29740, },
	[60522631] = { 0, 0, 8, 8, 56842, 56842, "Lunar Preservation" },
}
points[ 7 ] = { -- Mulgore
	[48495323] = { 911, 911, 8, 8, 8673, 8673, },
	[44942322] = { 914, 914, 2, 2, 8678, 8678, },
	[47473458] = { 0, 0, 2, 2, 56903, 56903, "Flower of Sincerity" },
	[47653056] = { 0, 0, 2, 2, 56903, 56903, "Flower of Sincerity" },
	[48112717] = { 0, 0, 2, 2, 56903, 56903, "Flower of Sincerity" },
	[49122970] = { 0, 0, 2, 2, 56903, 56903, "Flower of Sincerity" },
	[50982986] = { 0, 0, 2, 2, 56903, 56903, "Flower of Sincerity" },
	[51273853] = { 0, 0, 2, 2, 56903, 56903, "Flower of Sincerity" },
	[52423242] = { 0, 0, 2, 2, 56903, 56903, "Flower of Sincerity" },
	[53843626] = { 0, 0, 2, 2, 56903, 56903, "Flower of Sincerity" },
	[56472982] = { 0, 0, 2, 2, 56903, 56903, "Flower of Sincerity" },
	[57053049] = { 0, 0, 2, 2, 56903, 56903, "Flower of Sincerity" },
}
points[ 10 ] = { -- Northern Barrens
	[48525926] = { 911, 911, 3, 3, 8717, 8717, },
	[68366996] = { 911, 911, 5, 5, 8680, 8680, },
	[35654710] = { 0, 0, 1, 1, 56904, 56904, "Flower of Wealth" },
	[36174300] = { 0, 0, 1, 1, 56904, 56904, "Flower of Wealth" },
	[36204512] = { 0, 0, 1, 1, 56904, 56904, "Flower of Wealth" },
	[37054770] = { 0, 0, 1, 1, 56904, 56904, "Flower of Wealth" },
	[37504278] = { 0, 0, 1, 1, 56904, 56904, "Flower of Wealth" },
	[37624591] = { 0, 0, 1, 1, 56904, 56904, "Flower of Wealth" },
	[37974327] = { 0, 0, 1, 1, 56904, 56904, "Flower of Wealth" },
	[38214466] = { 0, 0, 1, 1, 56904, 56904, "Flower of Wealth" },
	[38294852] = { 0, 0, 1, 1, 56904, 56904, "Flower of Wealth" },
	[38414730] = { 0, 0, 1, 1, 56904, 56904, "Flower of Wealth" },
}
points[ 50 ] = { -- Northern Stranglethorn
	[71043430] = { 912, 912, 5, 5, 8716, 8716, "Outside the instance" },
}
points[ 2023 ] = { -- Ohn'ahran Plains
	[58393146] = { 17321, 17321, 4, 4, 73717, 73717, },
	[83934803] = { 17321, 17321, 3, 3, 73172, 73172, },
}
points[ 85 ] = { -- Orgrimmar
	[52266001] = { 914, 914, 1, 1, 8677, 8677, "Alliance need to be very quick with this one" },
}
points[ 32 ] = { -- Searing Gorge
	[21297911] = { 912, 912, 12, 12, 8651, 8651, },
	[34898498] = { 910, 910, 4, 4, 8644, 8644, "Enter through here and follow the markers" },
	[34898298] = { 910, 910, 5, 5, 8619, 8619, "Enter through here and follow the markers" },
}
points[ 205 ] = { -- Shimmering Expanse in Vashj'ir
	[57258614] = { 6006, 6006, 8, 8, 29738, 29738, },
}
points[ 119 ] = { -- Sholazar Basin
	[49786362] = { 1396, 1396, 7, 7, 13018, 13018, },
	[63804902] = { 1396, 1396, 8, 8, 13024, 13024, },
}
points[ 81 ] = { -- Silithus
	[30801332] = { 911, 911, 20, 20, 8654, 8654, "Visit Zidormi if you see a\n"
												.."huge sword stuck into Azeroth" },
	[53023547] = { 911, 911, 21, 21, 8719, 8719, "Visit Zidormi if you see a\n"
												.."huge sword stuck into Azeroth" },
}
points[ 21 ] = { -- Silverpine Forest
	[44974114] = { 912, 912, 14, 14, 8645, 8645, },
	[54013521] = { 0, 0, 3, 3, 56905, 56905, "Flower of Solemnity" },
	[54023150] = { 0, 0, 3, 3, 56905, 56905, "Flower of Solemnity" },
	[54643194] = { 0, 0, 3, 3, 56905, 56905, "Flower of Solemnity" },
	[55823416] = { 0, 0, 3, 3, 56905, 56905, "Flower of Solemnity" },
	[56253038] = { 0, 0, 3, 3, 56905, 56905, "Flower of Solemnity" },
	[56423502] = { 0, 0, 3, 3, 56905, 56905, "Flower of Solemnity" },
	[56452838] = { 0, 0, 3, 3, 56905, 56905, "Flower of Solemnity" },
	[56663283] = { 0, 0, 3, 3, 56905, 56905, "Flower of Solemnity" },
	[57313581] = { 0, 0, 3, 3, 56905, 56905, "Flower of Solemnity" },
	[58603512] = { 0, 0, 3, 3, 56905, 56905, "Flower of Solemnity" },
}
points[ 199 ] = { -- Southern Barrens
	[41604745] = { 911, 911, 4, 4, 8686, 8686, },
}
points[ 65 ] = { -- Stonetalon Mountains
	[41591896] = { 0, 0, 5, 5, 56842, 56842, "Lunar Preservation" },
}
points[ 120 ] = { -- Storm Peaks
	[28897372] = { 1396, 1396, 4, 4, 13015, 13015, },
	[41168472] = { 1396, 1396, 13, 13, 13028, 13028, },
	[31263761] = { 1396, 1396, 14, 14, 13020, 13020, },
	[64595134] = { 1396, 1396, 18, 18, 13032, 13032, "BM Hunters doing the Hati quest chain\n"
													.."(to get Hati back) will be phased out.\n\n"
													.."Elder Muraco is below Camp Tunka'lo" },
	[39482691] = { 910, 910, 12, 12, 13066, 13066, "Enter through here" },
}
points[ 84 ] = { -- Stormwind City
	[79839556] = { 915, 915, 3, 3, 8646, 8646, },
}
points[ 224 ] = { -- Stranglethorn Vale
	[63282265] = { 912, 912, 5, 5, 8716, 8716, "Outside the instance" },
	[37327920] = { 912, 912, 6, 6, 8674, 8674, },
	[38814669] = { 0, 0, 2, 2, 56904, 56904, "Flower of Peace" },
	[40134704] = { 0, 0, 2, 2, 56904, 56904, "Flower of Peace" },
	[40874783] = { 0, 0, 2, 2, 56904, 56904, "Flower of Peace" },
	[41294516] = { 0, 0, 2, 2, 56904, 56904, "Flower of Peace" },
	[41604731] = { 0, 0, 2, 2, 56904, 56904, "Flower of Peace" },
	[41954612] = { 0, 0, 2, 2, 56904, 56904, "Flower of Peace" },
	[42254482] = { 0, 0, 2, 2, 56904, 56904, "Flower of Peace" },
	[42684748] = { 0, 0, 2, 2, 56904, 56904, "Flower of Peace" },
	[42904573] = { 0, 0, 2, 2, 56904, 56904, "Flower of Peace" },
	[43234966] = { 0, 0, 2, 2, 56904, 56904, "Flower of Peace" },
}
points[ 317 ] = { -- Stratholme
	[73505480] = { 910, 910, 6, 6, 8727, 8727, "Lift the portcullis" },
	[78622176] = { 910, 910, 6, 6, 8727, 8727, "Exit the same way you entered" },
}
points[ 51 ] = { -- Swamp of Sorrows
	[69425487] = { 910, 910, 2, 2, 8713, 8713, "Enter the Temple of Atal'Hakkar,\n"
											.."also known as the Sunken Temple.\n\n"
											.."1) Descend the twisting path.\n"
											.."2) Momentarily submerge into the pool.\n\n"
											.."3) Resurface and follow the path and\n"
											.."enter the portal and follow the markers" },
}
points[ 71 ] = { -- Tanaris
	[37247906] = { 911, 911, 15, 15, 8671, 8671, },
	[51402881] = { 911, 911, 16, 16, 8684, 8684, },
	[39222134] = { 910, 910, 1, 1, 8676, 8676, "Enter Zul'Farrak. Follow the markers" },
}
points[ 57 ] = { -- Teldrassil
	[56855310] = { 911, 911, 6, 6, 8715, 8715, },
	[28114367] = { 915, 915, 1, 1, 8718, 8718, },
	[55108853] = { 0, 915, 0, 1, 0, 8718, "Fly straight into the pink portal at Rut'theran.\n"
											.."Immediately turn left and fly up high" },
}
points[ 2025 ] = { -- Thaldraszus
	[54864337] = { 17321, 17321, 7, 7, 73859, 73859, },
	[50056654] = { 17321, 17321, 8, 8, 73861, 73861, },
}
points[ 2024 ] = { -- The Azure Span
	[12894905] = { 17321, 17321, 5, 5, 73858, 73858, },
	[67424949] = { 17321, 17321, 6, 6, 73860, 73860, },
}
points[ 210 ] = { -- The Cape of Stranglethorn
	[39967251] = { 912, 912, 6, 6, 8674, 8674, },
	[42431854] = { 0, 0, 2, 2, 56904, 56904, "Flower of Peace" },
	[44611912] = { 0, 0, 2, 2, 56904, 56904, "Flower of Peace" },
	[45852043] = { 0, 0, 2, 2, 56904, 56904, "Flower of Peace" },
	[46541599] = { 0, 0, 2, 2, 56904, 56904, "Flower of Peace" },
	[47071956] = { 0, 0, 2, 2, 56904, 56904, "Flower of Peace" },
	[47631759] = { 0, 0, 2, 2, 56904, 56904, "Flower of Peace" },
	[48141543] = { 0, 0, 2, 2, 56904, 56904, "Flower of Peace" },
	[48851984] = { 0, 0, 2, 2, 56904, 56904, "Flower of Peace" },
	[49221694] = { 0, 0, 2, 2, 56904, 56904, "Flower of Peace" },
	[49762346] = { 0, 0, 2, 2, 56904, 56904, "Flower of Peace" },
}
points[ 26 ] = { -- The Hinterlands
	[50004805] = { 912, 912, 11, 11, 8643, 8643, },
	[49123983] = { 0, 0, 3, 3, 56903, 56903, "Flower of Vigor" },
	[51853858] = { 0, 0, 3, 3, 56903, 56903, "Flower of Vigor" },
	[54953518] = { 0, 0, 3, 3, 56903, 56903, "Flower of Vigor" },
	[59543908] = { 0, 0, 3, 3, 56903, 56903, "Flower of Vigor" },
	[62224140] = { 0, 0, 3, 3, 56903, 56903, "Flower of Vigor" },
	[63644153] = { 0, 0, 3, 3, 56903, 56903, "Flower of Vigor" },
	[65213765] = { 0, 0, 3, 3, 56903, 56903, "Flower of Vigor" },
	[66234105] = { 0, 0, 3, 3, 56903, 56903, "Flower of Vigor" },
	[71434483] = { 0, 0, 3, 3, 56903, 56903, "Flower of Vigor" },
	[73114802] = { 0, 0, 3, 3, 56903, 56903, "Flower of Vigor" },
}
points[ 129 ] = { -- The Nexus
	[38707760] = { 910, 910, 8, 8, 13021, 13021, "1) This way!" },
	[50006600] = { 910, 910, 8, 8, 13021, 13021, "2) This way!" },
	[61505220] = { 910, 910, 8, 8, 13021, 13021, "3) This way!" },
	[61906400] = { 910, 910, 8, 8, 13021, 13021, "4) This way!" },
	[54976461] = { 910, 910, 8, 8, 13021, 13021, "5) He is here" },
	[52756990] = { 910, 910, 8, 8, 13021, 13021, "6) Come up this way for a shortcut exit!" },
}
points[ 220 ] = { -- The Temple of Atal'Hakkar
	[63073436] = { 910, 910, 2, 2, 8713, 8713, },
	[50002500] = { 910, 910, 2, 2, 8713, 8713, "Head straight for the other marker" },
}
points[ 2022 ] = { -- The Waking Shores
	[46703094] = { 17321, 17321, 1, 1, 73848, 73848, },
	[44306379] = { 17321, 17321, 2, 2, 73716, 73716, },
}
points[ 64 ] = { -- Thousand Needles
	[46345101] = { 911, 911, 13, 13, 8682, 8682, },
	[77097561] = { 911, 911, 14, 14, 8724, 8724, },
}
points[ 88 ] = { -- Thunder Bluff
	[72982335] = { 914, 914, 2, 2, 8678, 8678, },
}
points[ 18 ] = { -- Tirisfal Glades
	[61865391] = { 912, 912, 13, 13, 8652, 8652, },
	[61957317] = { 914, 914, 3, 3, 8648, 8648, },
	[61817153] = { 914, 914, 3, 3, 8648, 8648, "Drop down in to here. Elder Darkcore is a short walk away" },
}
points[ 241 ] = { -- Twilight Highlands
	[50917045] = { 6006, 6006, 4, 4, 29737, 29737, },
	[51883307] = { 6006, 6006, 5, 5, 29736, 29736, },
}
points[ 249 ] = { -- Uldum
	[65521866] = { 6006, 6006, 2, 2, 29742, 29742,  },
	[31586298] = { 6006, 6006, 3, 3, 29741, 29741, },
}
points[ 1527 ] = { -- Uldum
	[65521866] = { 6006, 6006, 2, 2, 29742, 29742, "\124cFFFF0000Wrong version of Uldum. Speak to Zidormi" },
	[31606300] = { 6006, 6006, 3, 3, 29741, 29741, "\124cFFFF0000Wrong version of Uldum. Speak to Zidormi" },
}
points[ 90 ] = { -- Undercity
	[65993053] = { 914, 914, 3, 3, 8648, 8648, "Drop down in to here. Elder Darkcore is a short walk away" },
	[66633821] = { 914, 914, 3, 3, 8648, 8648, "The achievement text is wrong. Elder Darkcore\n"
												.."is NOT in the Undercity. Darkcore is above, in\n"
												.."The Ruins of Lordaeron" },
}
points[ 78 ] = { -- Un'Goro
	[50377617] = { 911, 911, 17, 17, 8681, 8681, },
	[62323042] = { 0, 0, 3, 3, 56904, 56904, "Flower of Felicity" },
	[64162995] = { 0, 0, 3, 3, 56904, 56904, "Flower of Felicity" },
	[65002499] = { 0, 0, 3, 3, 56904, 56904, "Flower of Felicity" },
	[65323097] = { 0, 0, 3, 3, 56904, 56904, "Flower of Felicity" },
	[65422696] = { 0, 0, 3, 3, 56904, 56904, "Flower of Felicity" },
	[66542244] = { 0, 0, 3, 3, 56904, 56904, "Flower of Felicity" },
	[66763242] = { 0, 0, 3, 3, 56904, 56904, "Flower of Felicity" },
	[67852814] = { 0, 0, 3, 3, 56904, 56904, "Flower of Felicity" },
	[68603269] = { 0, 0, 3, 3, 56904, 56904, "Flower of Felicity" },
	[69683030] = { 0, 0, 3, 3, 56904, 56904, "Flower of Felicity" },
}
points[ 133 ] = { -- Utgarde Keep - Njorndir Preparation
	[50652851] = { 910, 910, 7, 7, 13017, 13017, "1) Defeat Dragonflayer Forgemasters\n"
												.."to remove the flaming wall barriers" },
	[23047190] = { 910, 910, 7, 7, 13017, 13017, "2) Through this way" },
	[47236936] = { 910, 910, 7, 7, 13017, 13017, "3) And when done, just retrace your steps" },
}
points[ 136 ] = { -- Utgarde Pinnacle - Lower Pinnacle
	[45858315] = { 910, 910, 13, 13, 13067, 13067, "3) Up the stairs" },
	[56112473] = { 910, 910, 13, 13, 13067, 13067, "8) Now that you're done, it's easiest to keep going" },
	[49154425] = { 910, 910, 13, 13, 13067, 13067, "9) Up the ramp" },
	[48672327] = { 910, 910, 13, 13, 13067, 13067, "Elder is here" },
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
points[ 203 ] = { -- Vashj'ir
	[69828250] = { 912, 912, 8, 8, 8675, 8675, },
}
points[ 52 ] = { -- Westfall
	[56644709] = { 912, 912, 8, 8, 8675, 8675, },
}
points[ 22 ] = { -- Western Plaguelands
	[65303876] = { 912, 912, 4, 4, 8722, 8722, "Enter The Weeping Cave"},
	[63513611] = { 912, 912, 4, 4, 8722, 8722, "Inside The Weeping Cave"},
	[69187345] = { 912, 912, 17, 17, 8714, 8714, },
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
													.."Cushion\" toy such as the \"Pineapple\", \"Safari\" or \"Zhevra\".\n\n"
													.."You may receive a warning you are going to be teleported\n"
													.."outside Wintergrasp, so don't muck around!\n\n"
													.."You are now \"inside\". The problem now is to stand up.\n"
													.."Blizzard stopped that. A mage blink works though. YMMV." },
	[49471373] = { 1396, 1396, 10, 10, 13026, 13026, "Glitch Guide: 2) After using your Lounge Cushion, walk\n"
													.."exactly to here and rotate your downwards view so that\n"
													.."you can see the glitched interior.\n\n"
													.."If standing here then facing at about 201 degrees\n"
													.."(my \"X and Y\" AddOn shows degrees) you can jump\n"
													.."down onto a circular raised ledge.\n\n"
													.."Cannot see the interior? Just jump down blindly!\n\n"
													.."Continue with the Elder then use the Violet Citadel\n"
													.."portal or the Defender's Portal" },
}
points[ 83 ] = { -- Winterspring
	[53225675] = { 911, 911, 18, 18, 8726, 8726, },
	[59964994] = { 911, 911, 19, 19, 8672, 8672, },
	[56173028] = { 0, 0, 3, 3, 56906, 56906, "Flower of Generosity" },
	[55892949] = { 0, 0, 3, 3, 56906, 56906, "Flower of Generosity" },
	[56173028] = { 0, 0, 3, 3, 56906, 56906, "Flower of Generosity" },
	[56812862] = { 0, 0, 3, 3, 56906, 56906, "Flower of Generosity" },
	[56843730] = { 0, 0, 3, 3, 56906, 56906, "Flower of Generosity" },
	[57083253] = { 0, 0, 3, 3, 56906, 56906, "Flower of Generosity" },
	[57682999] = { 0, 0, 3, 3, 56906, 56906, "Flower of Generosity" },
	[57693201] = { 0, 0, 3, 3, 56906, 56906, "Flower of Generosity" },
	[57713710] = { 0, 0, 3, 3, 56906, 56906, "Flower of Generosity" },
	[57913552] = { 0, 0, 3, 3, 56906, 56906, "Flower of Generosity" },
	[58883399] = { 0, 0, 3, 3, 56906, 56906, "Flower of Generosity" },
}
points[ 121 ] = { -- Zul'Drak
	[58915597] = { 1396, 1396, 11, 11, 13027, 13027, },
	[28978375] = { 910, 910, 10, 10, 13023, 13023, "The portal is through here" },
	[76112091] = { 910, 910, 11, 11, 13065, 13065, "Use this entrance, not the other one" },
}
points[ 219 ] = { -- Zul'Farrak
	[34393931] = { 910, 910, 1, 1, 8676, 8676, "Follow the map directly, no need for way-markers!" },
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
textures[16] = "Interface\\AddOns\\HandyNotes_LunarFestival\\CoinOfAncestry"

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
scaling[16] = 0.75