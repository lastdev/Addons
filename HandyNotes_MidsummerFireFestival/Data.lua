local _, ns = ...
local points = ns.points
local textures = ns.textures
local scaling = ns.scaling
local colourPrefix		= ns.colour.prefix
local colourHighlight	= ns.colour.highlight
local colourPlaintext	= ns.colour.plaintext

-- Achievements:
-- Flame Warden of Eastern Kingdoms		1022	Alliance
-- Flame Warden of Kalimdor				1023	Alliance
-- Flame Warden of Outland				1024	Alliance
-- Flame Keeper of Eastern Kingdoms		1025	Horde
-- Flame Keeper of Kalimdor				1026	Horde
-- Flame Keeper of Outland				1027	Horde
-- Extinguishing Eastern Kingdoms		1028	Alliance
-- Extinguishing Kalimdor				1029	Alliance
-- Extinguishing Outland				1030	Alliance
-- Extinguishing Eastern Kingdoms		1031	Horde
-- Extinguishing Kalimdor				1032	Horde
-- Extinguishing Outland				1033	Horde
-- King of the Fire						1145	Alliance/Horde
-- Extinguishing Northrend				6007	Alliance
-- Flame Warden of Northrend			6008	Alliance
-- Flame Keeper of Northrend			6009	Horde
-- Extinguishing Northrend				6010	Horde
-- Flame Warden of Cataclysm			6011	Alliance
-- Flame Keeper of Cataclysm			6012	Horde
-- Extinguishing Cataclysm				6013	Alliance
-- Extinguishing Cataclysm				6014	Horde
-- Flame Keeper of Pandaria				8044	Horde
-- Flame Warden of Pandaria				8045	Alliance
-- Extinguishing Pandaria				8042	Alliance
-- Extinguishing Pandaria				8043	Horde
-- Extinguishing Draenor				11276	Alliance
-- Extinguishing Draenor				11277	Horde
-- Extinguishing the Broken Isles		11278	Alliance
-- Extinguishing the Broken Isles		11279	Horde
-- Flame Warden of the Broken Isles		11280	Alliance
-- Flame Keeper of the Broken Isles		11282	Horde
-- Flame Keeper of Draenor				11283	Alliance
-- Flame Warden of Draenor				11284	Horde
-- Flame Keeper of the Zandalar			13340	Horde
-- Flame Warden of the Kul Tiras		13341	Alliance
-- Extinguishing Kul Tiras				13342	Alliance
-- Extinguishing Zandalar				13343	Horde
-- Flame Keeper of the Dragon Isles		17737	Alliance
-- Flame Warden of the Dragon Isles		17738	Horde

local teldrassil = "Speak to Zidormi in Darkshore if\nTeldrassil seems somewhat destroyed!"
local zidormi = "Can't find the bonfire or the Warden\nor the Flame Keeper? Speak to Zidormi!"

points[ 204 ] = { -- Abyssal Depths
	[96834446] = { aIDA=6011, aIDH=6012, indexA=4, indexH=1, quest=29031, npc=51697, group="H" },
}
points[ 14 ] = { -- Arathi Highlands
	[44304604] = { aID=1022, index=1, quest=11804, npc=25887, faction="Alliance", group="H" },
	[44574615] = { aID=1031, index=1, quest=11732, object=187914, faction="Horde", group="D" },
	[69144286] = { aID=1028, index=1, quest=11764, object=187947, faction="Alliance", group="D" },
	[69354256] = { aID=1025, index=1, quest=11840, npc=25923, faction="Horde", group="H" },
	[38259009] = { group="I", title="Zidormi", tip="Zidormi is at this location. If you can't\n"
					.."find the bonfire or the Flame Keeper or the\n"
					.."Warden then speak to her to change \"time\"!" },
}
points[ 63 ] = { -- Ashenvale
	[51356615] = { aID=1026, index=1, quest=11841, npc=25884, faction="Horde", group="H" },
	[51586666] = { aID=1029, index=1, quest=11765, object=187948, faction="Alliance", group="D" },
	[86784150] = { aID=1032, index=1, quest=11734, object=187916, faction="Horde", group="D" },
	[86944187] = { aID=1023, index=1, quest=11805, npc=25883, faction="Alliance", group="H" },
}
points[ 76 ] = { -- Azshara
	[60465343] = { aID=1029, index=2, quest=28919, object=207991, faction="Alliance", group="D" },
	[60805347] = { aID=1026, index=2, quest=28923, npc=51575, faction="Horde", group="H" },
}
points[ 630 ] = { -- Azsuna
	[48262969] = { aIDA=11280, aIDH=11282, index=1, quest=44574, npc=114492, group="H" },
}
points[ 97 ] = { -- Azuremyst Isle
	[44485252] = { aID=1023, index=2, quest=11806, npc=25888, faction="Alliance", group="H" },
	[44675267] = { aID=1032, index=2, quest=11735, object=187917, faction="Horde", group="D" },
	[24653685] = { aID=1145, quest=11933, label="The Exodar", object=188128, faction="Horde", group="T" },
}
points[ 15 ] = { -- Badlands
	[18745604] = { aID=1031, index=2, quest=28912, object=207984, faction="Horde", group="D" },
	[19015619] = { aID=1022, index=2, quest=28925, npc=51585, faction="Alliance", group="H" },
	[23093744] = { aID=1025, index=2, quest=11842, npc=25925, faction="Horde", group="H" },
	[24053709] = { aID=1028, index=2, quest=11766, object=187559, faction="Alliance", group="D" },
}
points[ 105 ] = { -- Blade's Edge Mountains
	[41576590] = { aID=1024, index=1, quest=11807, npc=25889, faction="Alliance", group="H" },
	[41766605] = { aID=1033, index=1, quest=11736, object=187919, faction="Horde", group="D" },
	[49925866] = { aID=1027, index=1, quest=11843, npc=25926, faction="Horde", group="H" },
	[50005901] = { aID=1030, index=1, quest=11767, object=187955, faction="Alliance", group="D" },
}
points[ 17 ] = { -- Blasted Lands
	[46221378] = { aID=1025, index=3, quest=28930, npc=51603, faction="Horde", group="H", tip=zidormi },
	[46301414] = { aID=1028, index=3, quest=28917, object=207989, faction="Alliance", group="D", tip=zidormi },
	[55271506] = { aID=1031, index=3, quest=11737, object=187920, faction="Horde", group="D", tip=zidormi },
	[55531488] = { aID=1022, index=3, quest=11808, npc=25890, faction="Alliance", group="H", tip=zidormi },
}
points[ 106 ] = { -- Bloodmyst Isle
	[55816789] = { aID=1023, index=3, quest=11809, npc=25891, faction="Alliance", group="H" },
	[55886845] = { aID=1032, index=3, quest=11738, object=187921, faction="Horde", group="D" },
}
points[ 114 ] = { -- Borean Tundra
	[51051179] = { aID=6007, index=1, quest=13441, object=194033, faction="Alliance", group="D" },
	[51131154] = { aID=6009, index=2, quest=13493, npc=32809, faction="Horde", group="H" },
	[55101995] = { aID=6008, index=8, quest=13485, npc=32801, faction="Alliance", group="H" },
	[55222018] = { aID=6010, index=2, quest=13440, object=194032, faction="Horde", group="D" },
}
points[ 36 ] = { -- Burning Steppes
	[51112921] = { aID=1025, index=4, quest=11844, npc=25927, faction="Horde", group="H" },
	[51452911] = { aID=1028, index=4, quest=11768, object=187956, faction="Alliance", group="D" },
	[68346064] = { aID=1022, index=4, quest=11810, npc=25892, faction="Alliance", group="H" },
	[68576018] = { aID=1031, index=4, quest=11739, object=187922, faction="Horde", group="D" },
}
points[ 127 ] = { -- Crystalsong Forest
	[77647522] = { aID=6010, index=8, quest=13447, object=194045, faction="Horde", group="D" },
	[78187495] = { aID=6008, index=2, quest=13491, npc=32807, faction="Alliance", group="H" },
	[79975321] = { aID=6009, index=8, quest=13499, npc=32815, faction="Horde", group="H" },
	[80345272] = { aID=6007, index=6, quest=13457, object=194046, faction="Alliance", group="D" },
}
points[ 62 ] = { -- Darkshore
	[48732265] = { aID=1023, index=4, quest=11811, npc=25893, faction="Alliance", group="H", tip=teldrassil },
	[48922257] = { aID=1032, index=4, quest=11740, object=187923, faction="Horde", group="D", tip=teldrassil },
}
points[ 89 ] = { -- Darnassus
	[63684707] = { aID=1145, quest=9332, label="Darnassus", object=181334, faction="Horde",
					group="T", tip=teldrassil },
}
points[ 1165 ] = { -- Dazar'alor
	[35985713] = { aID=13340, index=1, quest=54745, npc=148944, faction="Horde", group="H" },
	[36175692] = { aID=13343, index=1, quest=54744, object=316795, faction="Alliance", group="D" },
}
points[ 207 ] = { -- Deepholm
	[49405132] = { aIDA=6011, aIDH=6012, indexA=2, indexH=4, quest=29036, npc=51698, group="H" },
}
points[ 66 ] = { -- Desolace
	[26147691] = { aID=1026, index=3, quest=11845, npc=25928, faction="Horde", group="H" },
	[26197719] = { aID=1029, index=3, quest=11769, object=187957, faction="Alliance", group="D" },
	[65881693] = { aID=1032, index=5, quest=11741, object=187924, faction="Horde", group="D" },
	[66121708] = { aID=1023, index=5, quest=11812, npc=25894, faction="Alliance", group="H" },
}
points[ 115 ] = { -- Dragonblight
	[38264847] = { aID=6009, index=1, quest=13495, npc=32811, faction="Horde", group="H" },
	[38484819] = { aID=6007, index=8, quest=13451, object=194037, faction="Alliance", group="D" },
	[75064384] = { aID=6010, index=1, quest=13443, object=194036, faction="Horde", group="D" },
	[75294380] = { aID=6008, index=1, quest=13487, npc=32803, faction="Alliance", group="H" },
}
points[ 422 ] = { -- Dread Wastes
	[56076957] = { aIDA=8045, aIDH=8044, index=1, quest=32497, npc=69522, group="H" },
}
points[ 896 ] = { -- Drustvar
	[40164743] = { aID=13342, index=3, quest=54742, object=316793, faction="Horde", group="D" },
	[40224760] = { aID=13341, index=3, quest=54743, npc=148934, faction="Alliance", group="H" },
}
points[ 27 ] = { -- Dun Morogh
	[53704483] = { aID=1031, index=5, quest=11742, object=187925, faction="Horde", group="D" },
	[53804523] = { aID=1022, index=5, quest=11813, npc=25895, faction="Alliance", group="H" },
	[68642324] = { aID=1145, quest=9331, label="Ironforge", object=181333, faction="Horde", group="T" },
}
points[ 1 ] = { -- Durotar
	[52034717] = { aID=1029, index=4, quest=11770, object=187958, faction="Alliance", group="D" },
	[52244740] = { aID=1026, index=4, quest=11846, npc=25929, faction="Horde", group="H" },
}
points[ 47 ] = { -- Duskwood
	[73695461] = { aID=1022, index=6, quest=11814, npc=25896, faction="Alliance", group="H" },
	[73335491] = { aID=1031, index=6, quest=11743, object=187926, faction="Horde", group="D" },
}
points[ 70 ] = { -- Dustwallow Marsh
	[33283078] = { aID=1029, index=5, quest=11771, object=187959, faction="Alliance", group="D" },
	[33433091] = { aID=1026, index=5, quest=11847, npc=25930, faction="Horde", group="H" },
	[61824046] = { aID=1023, index=6, quest=11815, npc=25897, faction="Alliance", group="H" },
	[62044040] = { aID=1032, index=6, quest=11744, object=187927, faction="Horde", group="D" },
}
points[ 37 ] = { -- Elwynn Forest
	[19523878] = { aID=1145, quest=9330, label="Stormwind City", object=181332, faction="Horde", group="T" },
	[43166286] = { aID=1031, index=7, quest=11745, object=187928, faction="Horde", group="D" },
	[43476263] = { aID=1022, index=7, quest=11816, npc=25898, faction="Alliance", group="H" },
}
points[ 94 ] = { -- Eversong Woods
	[46395041] = { aID=1028, index=5, quest=11772, object=187960, faction="Alliance", group="D" },
	[46405060] = { aID=1025, index=5, quest=11848, npc=25931, faction="Horde", group="H" },
	[55883763] = { aID=1145, quest=11935, label="Silvermoon City", object=188129, faction="Alliance", group="T" },
}
points[ 69 ] = { -- Feralas
	[46664371] = { aID=1032, index=7, quest=11746, object=187929, faction="Horde", group="D" },
	[46824370] = { aID=1023, index=7, quest=11817, npc=25899, faction="Alliance", group="H" },
	[72374779] = { aID=1026, index=6, quest=11849, npc=25932, faction="Horde", group="H" },
	[72434762] = { aID=1029, index=6, quest=11773, object=187961, faction="Alliance", group="D" },
}
points[ 525 ] = { -- Frostfire Ridge
	[72616508] = { aID=11284, index=5, quest=44580, npc=114499, faction="Horde", group="H" },
	[72706521] = { aID=11276, quest=44583, object=259870, faction="Alliance", group="D" },
}
points[ 95 ] = { -- Ghostlands
	[46902634] = { aID=1025, index=6, quest=11850, npc=25933, faction="Horde", group="H" },
	[47062604] = { aID=1028, index=6, quest=11774, object=187964, faction="Alliance", group="D" },
}
points[ 543 ] = { -- Gorgrond
	[43929379] = { aIDA=11283, aIDH=11284, index=4, quest=44573, npc=114491, group="H" },
}
points[ 116 ] = { -- Grizzly Hills
	[19136145] = { aID=6007, index=4, quest=13454, object=194042, faction="Alliance", group="D" },
	[19326116] = { aID=6009, index=7, quest=13497, npc=32813, faction="Horde", group="H" },
	[33906045] = { aID=6008, index=7, quest=13489, npc=32805, faction="Alliance", group="H" },
	[34186061] = { aID=6010, index=7, quest=13445, object=194040, faction="Horde", group="D" },
}
points[ 100 ] = { -- Hellfire Peninsular
	[57114204] = { aID=1027, index=2, quest=11851, npc=25934, faction="Horde", group="H" },
	[57164183] = { aID=1030, index=2, quest=11775, object=187963, faction="Alliance", group="D" },
	[61975836] = { aID=1033, index=2, quest=11747, object=187930, faction="Horde", group="D" },
	[62175828] = { aID=1024, index=2, quest=11818, npc=25900, faction="Alliance", group="H" },
}
points[ 650 ] = { -- Highmountain
	[55528445] = { aIDA=11280, aIDH=11282, index=3, quest=44576, npc=114494, group="H" },
}
points[ 25 ] = { -- Hillsbrad Foothills
	[54554987] = { aID=1028, index=7, quest=11776, object=187964, faction="Alliance", group="D" },
	[54605000] = { aID=1025, index=7, quest=11853, npc=25935, faction="Horde", group="H" },
}
points[ 117 ] = { -- Howling Fjord
	[48411334] = { aID=6007, index=5, quest=13453, object=194039, faction="Alliance", group="D" },
	[48611315] = { aID=6009, index=3, quest=13496, npc=32812, faction="Horde", group="H" },
	[57771577] = { aID=6010, index=3, quest=13444, object=194038, faction="Horde", group="D" },
	[57801612] = { aID=6008, index=3, quest=13488, npc=32804, faction="Alliance", group="H" },
}
points[ 87 ] = { -- Ironforge
	[64622482] = { aID=1145, quest=9331, label="Ironforge", object=181333, faction="Horde", group="T" },
}
points[ 418 ] = { -- Krasarang Wilds
	[73990949] = { aIDA=8045, aIDH=8044, index=3, quest=32499, npc=69533, group="H" },
}
points[ 379 ] = { -- Kun-Lai Summit
	[71159086] = { aIDA=8045, aIDH=8044, index=4, quest=32500, npc=69535, group="H" },
}
points[ 48 ] = { -- Loch Modan
	[32334022] = { aID=1031, index=8, quest=11749, object=187564, faction="Horde", group="D" },
	[32564095] = { aID=1022, index=8, quest=11820, npc=25902, faction="Alliance", group="H" },
}
points[ 198 ] = { -- Mount Hyjal
	[62832271] = { aIDA=6011, aIDH=6012, indexA=5, indexH=3, quest=29030, npc=51682, group="H" },
}
points[ 7 ] = { -- Mulgore
	[35072392] = { aID=1145, quest=9325, label="Orgrimmar", object=181337, faction="Alliance", group="T" },
	[51825926] = { aID=1026, index=7, quest=11852, npc=25936, faction="Horde", group="H" },
	[51935945] = { aID=1029, index=7, quest=11777, object=187965, faction="Alliance", group="D" },
}
points[ 107 ] = { -- Nagrand
	[49616946] = { aID=1024, index=3, quest=11821, npc=25903, faction="Alliance", group="H" },
	[49676971] = { aID=1033, index=3, quest=11750, object=187933, faction="Horde", group="D" },
	[50913414] = { aID=1027, index=3, quest=11854, npc=25937, faction="Horde", group="H" },
	[51063402] = { aID=1030, index=3, quest=11778, object=187966, faction="Alliance", group="D" },
}
points[ 550 ] = { -- Nagrand
	[80554770] = { aIDA=11283, aIDH=11284, index=3, quest=44572, npc=114490, group="H" },
}
points[ 863 ] = { -- Nazmir
	[40037430] = { aID=13340, index=2, quest=54747, npc=148950, faction="Horde", group="H" },
	[40137416] = { aID=13343, index=2, quest=54746, object=316796, faction="Alliance", group="D" },
}
points[ 109 ] = { -- Netherstorm
	[31106286] = { aID=1033, index=4, quest=11759, object=187942, faction="Horde", group="D" },
	[31216266] = { aID=1024, index=4, quest=11830, npc=25913, faction="Alliance", group="H" },
	[32116832] = { aID=1027, index=4, quest=11835, npc=25918, faction="Horde", group="H" },
	[32286825] = { aID=1030, index=4, quest=11799, object=187949, faction="Alliance", group="D" },
}
points[ 10 ] = { -- Northern Barrens
	[49855439] = { aID=1029, index=8, quest=11783, object=187971, faction="Alliance", group="D" },
	[49955463] = { aID=1026, index=8, quest=11859, npc=25943, faction="Horde", group="H" },
}
points[ 50 ] = { -- Northern Stranglethorn
	[40585094] = { aID=1025, index=8, quest=28924, npc=51582, faction="Horde", group="H" },
	[40695180] = { aID=1028, index=8, quest=28911, object=207983, faction="Alliance", group="D" },
	[51746332] = { aID=1031, index=9, quest=28910, object=207982, faction="Horde", group="D" },
	[52056355] = { aID=1022, index=9, quest=28922, npc=51574, faction="Alliance", group="H" },
}
points[ 2023 ] = { -- Ohn'ahran Plains
	[63853501] = { aIDA=17737, aIDH=17738, index=2, quest=75617, npc=204413, group="H" }, -- Bonfire at 63923490
}
points[ 85 ] = { -- Orgrimmar
	[46223760] = { aID=1145, quest=9324, label="Orgrimmar", object=181336, faction="Alliance", group="T" },
}
points[ 49 ] = { -- Redridge Mountains
	[24585371] = { aID=1031, index=10, quest=11751, object=187934, faction="Horde", group="D" },
	[24885338] = { aID=1022, index=10, quest=11822, npc=25904, faction="Alliance", group="H" },
}
points[ 104 ] = { -- Shadowmoon Valley
	[33403053] = { aID=1027, index=5, quest=11855, npc=25938, faction="Horde", group="H" },
	[33493032] = { aID=1030, index=5, quest=11779, object=187967, faction="Alliance", group="D" },
	[39565442] = { aID=1033, index=5, quest=11752, object=187935, faction="Horde", group="D" },
	[39635464] = { aID=1024, index=5, quest=11823, npc=25905, faction="Alliance", group="H" },
}
points[ 539 ] = { -- Shadowmoon Valley
	[42633599] = { aID=11283, index=5, quest=44579, npc=114500, faction="Alliance", group="H" },
	[42723589] = { aID=11277, quest=44582, object=259871, faction="Horde", group="D" },
}
points[ 205 ] = { -- Shimmering Expanse in Vashj'ir
	[49354199] = { aIDA=6011, aIDH=6012, indexA=4, indexH=1, quest=29031, npc=51697, group="H" },
}
points[ 119 ] = { -- Sholazar Basin
	[47306147] = { aID=6007, index=7, quest=13450, object=194034, faction="Alliance", group="D" },
	[47506177] = { aID=6009, index=4, quest=13494, npc=32810, faction="Horde", group="H" },
	[47886626] = { aID=6010, index=4, quest=13442, object=194035, faction="Horde", group="D" },
	[48116605] = { aID=6008, index=4, quest=13486, npc=32802, faction="Alliance", group="H" },
}

local hugeSword = "Visit Zidormi if you see a\nhuge sword stuck into Azeroth"

points[ 81 ] = { -- Silithus
	[50864131] = { aID=1026, index=9, quest=11836, npc=25919, faction="Horde", group="H", tip=hugeSword },
	[50864166] = { aID=1029, index=9, quest=11800, object=187950, faction="Alliance", group="D", tip=hugeSword },
	[60313351] = { aID=1023, index=8, quest=11831, npc=25914, faction="Alliance", group="H", tip=hugeSword },
	[60543314] = { aID=1032, index=8, quest=11760, object=187943, faction="Horde", group="D", tip=hugeSword },
}
points[ 110 ] = { -- Silvemoon City
	[69264308] = { aID=1145, quest=11935, label="Silvermoon City", object=188129, faction="Alliance", group="T" },
}
points[ 21 ] = { -- Silverpine Forest
	[49613859] = { aID=1028, index=9, quest=11580, object=187559, faction="Alliance", group="D" },
	[49643822] = { aID=1025, index=9, quest=11584, npc=25939, faction="Horde", group="H" },
}
points[ 199 ] = { -- Southern Barrens
	[40716734] = { aID=1029, index=10, quest=28914, object=207986, faction="Alliance", group="D" },
	[40856779] = { aID=1026, index=10, quest=28927, npc=51587, faction="Horde", group="H" },
	[48337223] = { aID=1023, index=9, quest=28926, npc=51586, faction="Alliance", group="H" },
	[48267246] = { aID=1032, index=9, quest=28913, object=207985, faction="Horde", group="D" },
}
points[ 542 ] = { -- Spires of Arak
	[48014472] = { aIDA=11283, aIDH=11284, index=1, quest=44570, npc=114488, group="H" },
}
points[ 65 ] = { -- Stonetalon Mountains
	[49295133] = { aID=1023, index=10, quest=28928, npc=51588, faction="Alliance", group="H" },
	[49505113] = { aID=1032, index=10, quest=28915, object=207987, faction="Horde", group="D" },
	[52916245] = { aID=1026, index=11, quest=11856, npc=25940, faction="Horde", group="H" },
	[52976232] = { aID=1029, index=11, quest=11780, object=187968, faction="Alliance", group="D" },
}
points[ 120 ] = { -- Storm Peaks
	[40278535] = { aID=6009, index=5, quest=13498, npc=32814, faction="Horde", group="H" },
	[40378558] = { aID=6007, index=2, quest=13455, object=194043, faction="Alliance", group="D" },
	[41448669] = { aID=6008, index=5, quest=13490, npc=32806, faction="Alliance", group="H" },
	[41448697] = { aID=6010, index=5, quest=13446, object=194044, faction="Horde", group="D" },
}
points[ 634 ] = { -- Stormheim
	[32504213] = { aIDA=11280, aIDH=11282, index=4, quest=44577, npc=114496, group="H" },
}
points[ 942 ] = { -- Stormsong Valley
	[35855133] = { aID=13341, index=2, quest=54741, npc=148932, faction="Alliance", group="H" },
	[35935148] = { aID=13342, index=2, quest=54739, object=316791, faction="Horde", group="D" },
}

points[ 84 ] = { -- Stormwind City
	[49797263] = { aID=1145, quest=9330, label="Stormwind City", object=181332, faction="Horde", group="T" },
}
points[ 224 ] = { -- Stranglethorn Vale
	[44223306] = { aID=1025, index=8, quest=28924, npc=51582, faction="Horde", group="H" },
	[44283360] = { aID=1028, index=8, quest=28911, object=207983, faction="Alliance", group="D" },
	[51204081] = { aID=1031, index=9, quest=28910, object=207982, faction="Horde", group="D" },
	[51394095] = { aID=1022, index=9, quest=28922, npc=51574, faction="Alliance", group="H" },
	
	[43617792] = { aID=1025, index=11, quest=11837, npc=25920, faction="Horde", group="H" },
	[43677810] = { aID=1028, index=11, quest=11801, object=187951, faction="Alliance", group="D" },
	[44507607] = { aID=1031, index=12, quest=11761, object=187944, faction="Horde", group="D" },
	[44567627] = { aID=1022, index=12, quest=11832, npc=25915, faction="Alliance", group="H" },
}
points[ 680 ] = { -- Suramar
	[22905827] = { aID=11279, quest=44624, object=259927, faction="Horde", group="D" },
	[23025835] = { aID=11280, index=5, quest=44613, npc=114519, faction="Alliance", group="H" },
	[30304528] = { aID=11278, quest=44627, object=259926, faction="Alliance", group="D" },
	[30464538] = { aID=11282, index=5, quest=44614, npc=114518, faction="Horde", group="H" },
}
points[ 51 ] = { -- Swamp of Sorrows
	[70211447] = { aID=1031, index=11, quest=28916, object=207988, faction="Horde", group="D" },
	[70251574] = { aID=1022, index=11, quest=28929, npc=51602, faction="Alliance", group="H" },
	[76331377] = { aID=1025, index=10, quest=11857, npc=25941, faction="Horde", group="H" },
	[76701413] = { aID=1028, index=10, quest=11781, object=187969, faction="Alliance", group="D" },
}
points[ 535 ] = { -- Talador
	[43467181] = { aIDA=11283, aIDH=11284, index=2, quest=44571, npc=114489, group="H" },
}
points[ 71 ] = { -- Tanaris
	[49822788] = { aID=1026, index=12, quest=11838, npc=25921, faction="Horde", group="H" },
	[49832812] = { aID=1029, index=12, quest=11802, object=187952, faction="Alliance", group="D" },
	[52002900] = { aID=1023, index=11, quest=11833, npc=25916, faction="Alliance", group="H" },
	[52643006] = { aID=1032, index=11, quest=11762, object=187945, faction="Horde", group="D" },
}
points[ 57 ] = { -- Teldrassil
	[34524766] = { aID=1145, quest=9332, label="Darnassus", object=181334, faction="Horde",
					group="T", tip=teldrassil },
	[54755283] = { aID=1032, index=12, quest=11753, object=187936, faction="Horde", group="D" },
	[54885279] = { aID=1023, index=12, quest=11824, npc=25906, faction="Alliance", group="H" },
}
points[ 108 ] = { -- Terokkar Forest
	[51944317] = { aID=1030, index=6, quest=11782, object=187970, faction="Alliance", group="D" },
	[52014291] = { aID=1027, index=6, quest=11858, npc=25942, faction="Horde", group="H" },
	[54065553] = { aID=1024, index=6, quest=11825, npc=25907, faction="Alliance", group="H" },
	[54225555] = { aID=1033, index=6, quest=11754, object=187937, faction="Horde", group="D" },
}
points[ 2025 ] = { -- Thaldraszus
	[40436166] = { aIDA=17737, aIDH=17738, index=4, quest=75645, npc=204415, group="H" }, -- Bonfire at 40506169
}
points[ 2024 ] = { -- The Azure Span
	[12214757] = { aIDA=17737, aIDH=17738, index=3, quest=75640, npc=204414, group="H" }, -- Bonfire at 12224749
}
points[ 103 ] = { -- The Exodar
	[41362616] = { aID=1145, quest=11933, label="The Exodar", object=188128, faction="Horde", group="T" },
}
points[ 2151 ] = { -- The Forbidden Reach
	[34986090] = { aIDA=17737, aIDH=17738, index=5, quest=75647, npc=204416, group="H" }, -- Bonfire at 34996105
}
points[ 210 ] = { -- The Cape of Stranglethorn
	[50407038] = { aID=1025, index=11, quest=11837, npc=25920, faction="Horde", group="H" },
	[50497069] = { aID=1028, index=11, quest=11801, object=187951, faction="Alliance", group="D" },
	[51876732] = { aID=1031, index=12, quest=11761, object=187944, faction="Horde", group="D" },
	[51976764] = { aID=1022, index=12, quest=11832, npc=25915, faction="Alliance", group="H" },
}
points[ 26 ] = { -- The Hinterlands
	[14345007] = { aID=1022, index=13, quest=11826, npc=25908, faction="Alliance", group="H" },
	[14484981] = { aID=1031, index=13, quest=11755, object=187938, faction="Horde", group="D" },
	[76647497] = { aID=1025, index=12, quest=11860, npc=25944, faction="Horde", group="H" },
	[76707459] = { aID=1028, index=12, quest=11784, object=187972, faction="Alliance", group="D" },
}
points[ 371 ] = { -- The Jade Forest
	[47184718] = { aIDA=8045, aIDH=8044, index=2, quest=32498, npc=69529, group="H" },
}
points[ 2022 ] = { -- The Waking Shores
	[45988288] = { aIDA=17737, aIDH=17738, index=1, quest=75398, npc=203749, group="H" }, -- Bonfire at 45928279
}
points[ 88 ] = { -- Thunder Bluff
	[21452697] = { aID=1145, quest=9325, label="Orgrimmar", object=181337, faction="Alliance", group="T" },
}
points[ 895 ] = { -- Tiragarde Sound
	[76334974] = { aID=13342, index=1, quest=54736, object=316788, faction="Horde", group="D" },
	[76354988] = { aID=13341, index=1, quest=54737, npc=148917, faction="Alliance", group="H" },
}
points[ 18 ] = { -- Tirisfal Glades
	[57055173] = { aID=1028, index=13, quest=11786, object=187974, faction="Alliance", group="D", tip=zidormi },
	[57235175] = { aID=1025, index=13, quest=11862, npc=25946, faction="Horde", group="H", tip=zidormi },
	[62286691] = { aID=1145, quest=9326, label="Ruins of Lordaeron", object=181335, faction="Alliance", group="T", tip=zidormi },
}
points[ 388 ] = { -- Townlong Steppes
	[71525629] = { aIDA=8045, aIDH=8044, index=5, quest=32501, npc=69536, group="H" },
}
points[ 241 ] = { -- Twilight Highlands
	[47142830] = { aID=6014, index=1, quest=28943, object=208089, faction="Horde", group="D" },
	[47262896] = { aID=6011, index=3, quest=28945, npc=51650, faction="Alliance", group="H" },
	[53124618] = { aID=6012, index=2, quest=28946, npc=51651, faction="Horde", group="H" },
	[53274636] = { aID=6013, index=1, quest=28944, object=208090, faction="Alliance", group="D" },
}
points[ 249 ] = { -- Uldum
	[52993457] = { aID=6013, index=2, quest=28948, object=208094, faction="Alliance", group="D" },
	[53153454] = { aID=6012, index=5, quest=28949, npc=51652, faction="Horde", group="H" },
	[53433188] = { aID=6014, index=2, quest=28947, object=208093, faction="Horde", group="D" },
	[53603185] = { aID=6011, index=1, quest=28950, npc=51653, faction="Alliance", group="H" },
}
points[ 1527 ] = { -- Uldum
	[52993457] = { aID=6013, index=2, quest=28948, object=208094, faction="Alliance", group="D",
		tip="\124cFFFF0000Wrong version of Uldum. Speak to Zidormi" },
	[53153454] = { aID=6012, index=5, quest=28949, npc=51652, faction="Horde", group="H",
		tip="\124cFFFF0000Wrong version of Uldum. Speak to Zidormi" },
	[53433188] = { aID=6014, index=2, quest=28947, object=208093, faction="Horde", group="D",
		tip="\124cFFFF0000Wrong version of Uldum. Speak to Zidormi" },
	[53603185] = { aID=6011, index=1, quest=28950, npc=51653, faction="Alliance", group="H",
		tip="\124cFFFF0000Wrong version of Uldum. Speak to Zidormi" },
}
points[ 78 ] = { -- Un'Goro
	[56336635] = { aID=1026, index=13, quest=28933, npc=51607, faction="Horde", group="H" },
	[56496585] = { aID=1029, index=13, quest=28920, object=207992, faction="Alliance", group="D" },
	[59796291] = { aID=1032, index=13, quest=28921, object=207993, faction="Horde", group="D" },
	[59866325] = { aID=1023, index=13, quest=28932, npc=51606, faction="Alliance", group="H" },
}
points[ 641 ] = { -- Val'sharah
	[44885793] = { aIDA=11280, aIDH=11282, index=2, quest=44575, npc=114493, group="H" },
}
points[ 2112 ] = { -- Valdrakken
	[53396232] = { aIDA=17737, aIDH=17738, index=4, quest=75645, npc=204415, group="H" }, -- Bonfire at 53906252
}
points[ 390 ] = { -- Vale of Eternal Blossoms
	[77763397] = { aID=8044, index=6, quest=32509, npc=69551, faction="Horde", group="H" },
	[77793366] = { aID=8042, quest=32496, object=217852, faction="Alliance", group="D" },
	[79683727] = { aID=8045, index=6, quest=32510, npc=69572, faction="Alliance", group="H" },
	[79903729] = { aID=8043, quest=32503, object=217851, faction="Horde", group="D" },
}
points[ 376 ] = { -- Valley of the Four Winds
	[51815132] = { aIDA=8045, aIDH=8044, index=7, quest=32502, npc=69550, group="H" },
}
points[ 203 ] = { -- Vashj'ir
	[64315167] = { aIDA=6011, aIDH=6012, indexA=4, indexH=1, quest=29031, npc=51697, group="H" },
}
points[ 864 ] = { -- Vol'dun
	[56014776] = { aID=13340, index=3, quest=54750, npc=148986, faction="Horde", group="H" },
	[55954764] = { aID=13343, index=3, quest=54749, object=316801, faction="Alliance", group="D" },
}
points[ 22 ] = { -- Western Plaguelands
	[29095659] = { aID=1028, index=14, quest=28918, object=207990, faction="Alliance", group="D" },
	[29165734] = { aID=1025, index=14, quest=28931, npc=51604, faction="Horde", group="H" },
	[43478233] = { aID=1022, index=14, quest=11827, npc=25909, faction="Alliance", group="H" },
	[43508258] = { aID=1031, index=14, quest=11756, object=187939, faction="Horde", group="D" },
}
points[ 52 ] = { -- Westfall
	[44766206] = { aID=1022, index=15, quest=11583, npc=25910, faction="Alliance", group="H" },
	[45086242] = { aID=1031, index=15, quest=11581, object=187564, faction="Horde", group="D" },
}
points[ 56 ] = { -- Wetlands
	[13274717] = { aID=1031, index=16, quest=11757, object=187940, faction="Horde", group="D" },
	[13464707] = { aID=1022, index=16, quest=11828, npc=25911, faction="Alliance", group="H" },
}
points[ 83 ] = { -- Winterspring
	[58094725] = { aID=1029, index=14, quest=11803, object=187953, faction="Alliance", group="D" },
	[58144750] = { aID=1026, index=14, quest=11839, npc=25922, faction="Horde", group="H" },
	[61244725] = { aID=1023, index=14, quest=11834, npc=25917, faction="Alliance", group="H" },
	[61394717] = { aID=1032, index=14, quest=11763, object=187946, faction="Horde", group="D" },
}
points[ 102 ] = { -- Zangarmarsh
	[35445161] = { aID=1027, index=7, quest=11863, npc=25947, faction="Horde", group="H" },
	[35565176] = { aID=1030, index=7, quest=11787, object=187975, faction="Alliance", group="D" },
	[68635214] = { aID=1033, index=7, quest=11758, object=187941, faction="Horde", group="D" },
	[69795195] = { aID=1024, index=7, quest=11829, npc=25912, faction="Alliance", group="H" },
}
points[ 2133 ] = { -- Zaralek Cavern
	[55175542] = { aIDA=17737, aIDH=17738, index=6, quest=75650, npc=204417, group="H" }, -- Bonfire at 55235549
}
points[ 121 ] = { -- Zul'Drak
	[40386130] = { aID=6008, index=6, quest=13492, npc=32808, faction="Alliance", group="H" },
	[40516101] = { aID=6010, index=6, quest=13449, object=194049, faction="Horde", group="D" },
	[43327135] = { aID=6007, index=3, quest=13458, object=194048, faction="Alliance", group="D" },
	[43387174] = { aID=6009, index=6, quest=13500, npc=32816, faction="Horde", group="H" },
}
points[ 862 ] = { -- Zuldazar
	[53314811] = { aID=13340, index=1, quest=54745, npc=148944, faction="Horde", group="H" },
	[53374804] = { aID=13343, index=1, quest=54744, object=316795, faction="Alliance", group="D" },
}

-- ===========================
-- Continents & Sub-Continents
-- ===========================

points[ 947 ] = { -- Deepholm, Zaralek Cavern on Azeroth
	[46704660] = { aIDA=6011, aIDH=6012, indexA=2, indexH=4, quest=29036, npc=51698, group="H" },
}	
points[ 948 ] = { -- Deepholm on The Maelstrom
	[52002700] = { aIDA=6011, aIDH=6012, indexA=2, indexH=4, quest=29036, npc=51698, group="H" },
}
points[ 1978 ] = { -- Zaralek Cavern on Dragon Isles
	[89008400] = { aIDA=17737, aIDH=17738, index=6, quest=75650, npc=204417, group="H" },
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
textures[7] = "Interface\\AddOns\\HandyNotes_MidsummerFireFestival\\FireSpirit"
textures[8] = "Interface\\AddOns\\HandyNotes_MidsummerFireFestival\\FireFlower"
textures[9] = "Interface\\AddOns\\HandyNotes_MidsummerFireFestival\\FirePotion"
textures[10] = "Interface\\AddOns\\HandyNotes_MidsummerFireFestival\\SymbolHigh"
textures[11] = "Interface\\AddOns\\HandyNotes_MidsummerFireFestival\\SymbolLow"

scaling[1] = 0.55
scaling[2] = 0.55
scaling[3] = 0.55
scaling[4] = 0.55
scaling[5] = 0.55
scaling[6] = 0.55
scaling[7] = 0.40
scaling[8] = 0.44
scaling[9] = 0.36
scaling[10] = 0.45
scaling[11] = 0.45
