local _, ns = ...
ns.points = {}
ns.achievementIQ = {}
ns.addOnName = "MidsummerFireFestival" -- For internal use to name globals etc. Should never be localised
ns.eventName = "Midsummer Fire Festival" -- The player sees this in labels and titles. This gets localised

-- Account Only Achievements (Retail)
-- I.e. impossible to know for sure if a character hasn't done (a component of) the achievement
ns.aoa = {}
ns.aoa[ 1034 ] = { acctOnly = true }
ns.aoa[ 1035 ] = { acctOnly = true }
ns.aoa[ 1036 ] = { acctOnly = true }
ns.aoa[ 1037 ] = { acctOnly = true }

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
-- The Fires of Azeroth					1034	Alliance
-- Desecration of the Horde				1035	Alliance
-- The Fires of Azeroth					1036	Horde
-- Desecration of the Alliance			1037	Horde
-- King of the Fire	Festival			1145	Alliance/Horde
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
-- Flame Warden of Draenor				11283	Alliance
-- Flame Keeper of Draenor				11284	Horde
-- Flame Keeper of the Zandalar			13340	Horde
-- Flame Warden of the Kul Tiras		13341	Alliance
-- Extinguishing Kul Tiras				13342	Alliance
-- Extinguishing Zandalar				13343	Horde
-- Flame Warden of the Dragon Isles		17737	Alliance
-- Flame Keeper of the Dragon Isles		17738	Horde
-- Flame Keeper of Khaz Algar			41631	Horde
-- Flame Warden of Khaz Algar			41632	Alliance

ns.festival = "The Festival of Fire"
ns.ffKalimdor = "FFK"
ns.ffEK = "FFEK"
ns.wildKalimdor = "WFK"
ns.wildEK = "WFEK"
ns.light1 = "A Light in Dark Places"
ns.light2 = "A Light in Dark Places"
ns.thief = "A Thief's Reward"

--==================================================================================================================================
--
-- SUMMARIES / SETS
--
--==================================================================================================================================

ns.setMain = { king=true, alwaysShow=true, noCoords= true, noContinent=true,
			quests={ versionUnder=20000, { id=9389, qType="Seasonal", name=ns.ffEK },
			{ id=9388, qType="Seasonal", name=ns.ffKalimdor }, },
			achievements={ { id=1038, faction="Alliance", showAllCriteria=true, },
			{ id=1034, faction="Alliance", showAllCriteria=true, },
			{ id=1035, faction="Alliance", showAllCriteria=true, },
			{ id=1039, faction="Horde", showAllCriteria=true, },
			{ id=1036, faction="Horde", showAllCriteria=true, },
			{ id=1037, faction="Horde", showAllCriteria=true, }, }, }
ns.setExtKalEK = { extinguish=true, alwaysShow=true, noCoords= true, noContinent=true,
			quests={ versionUnder=20000, { id=9323, qType="Seasonal", name=ns.wildEK },
			{ id=9322, qType="Seasonal", name=ns.wildKalimdor }, },
			achievements={ { id=1029, faction="Alliance", showAllCriteria=true, },
			{ id=1028, faction="Alliance", showAllCriteria=true, }, { id=1032, faction="Horde", showAllCriteria=true, },
			{ id=1031, faction="Horde", showAllCriteria=true, }, }, }
ns.setExtOther = { ext2=true, alwaysShow=(ns.version>=40000) and true, noCoords= true, noContinent=true,
			achievements={ { id=1030, faction="Alliance", showAllCriteria=true, },
			{ id=6007, faction="Alliance", showAllCriteria=true, },
			{ id=6013, faction="Alliance", showAllCriteria=true, version=40000, },
			{ id=8042, faction="Alliance", qType="Seasonal", aQuest=32496, version=50000, },
			{ id=11276, faction="Alliance", qType="Seasonal", aQuest=44583, version=60000, }, 
			{ id=11278, faction="Alliance", qType="Seasonal", aQuest=44627, version=70000, },
			{ id=13343, faction="Alliance", showAllCriteria=true, version=80000, }, 
			{ id=1033, faction="Horde", showAllCriteria=true, },
			{ id=6010, faction="Horde", showAllCriteria=true, },
			{ id=6014, faction="Horde", showAllCriteria=true, version=40000, },
			{ id=8043, faction="Horde", qType="Seasonal", aQuest=32503, version=50000, },
			{ id=11277, faction="Horde", qType="Seasonal", aQuest=44582, version=60000, },
			{ id=11279, faction="Horde", qType="Seasonal", aQuest=44624, version=70000, },
			{ id=13342, faction="Horde", showAllCriteria=true, version=80000, }, }, }
ns.setFlameKalEK = { wardenKeeper=true, alwaysShow=true, noCoords= true, noContinent=true,
			quests={ versionUnder=20000, { id=9319, qType="Seasonal", name=ns.light1 },
			{ id=9386, qType="Seasonal", name=ns.light2 }, },
			achievements={ { id=1023, faction="Alliance", showAllCriteria=true, },
			{ id=1022, faction="Alliance", showAllCriteria=true, },
			{ id=1024, faction="Alliance", showAllCriteria=true, version=60000, },
			{ id=1026, faction="Horde", showAllCriteria=true, },
			{ id=1025, faction="Horde", showAllCriteria=true, },
			{ id=1027, faction="Horde", showAllCriteria=true, version=60000, }, }, }
ns.setFlameOther = { flame2=true, alwaysShow=true, noCoords= true, noContinent=true,
			quests={ versionUnder=20000, { id=9365, qType="Seasonal", name=ns.thief, faction="Horde" },
			{ id=9339, qType="Seasonal", name=ns.thief, faction="Alliance" },
			{ id=9332, qType="Seasonal", name="Darnassus", faction="Horde" },
			{ id=9331, qType="Seasonal", name="Ironforge", faction="Horde" },
			{ id=9330, qType="Seasonal", name="Stormwind", faction="Horde" },
			{ id=9325, qType="Seasonal", name="Thunder Bluff", faction="Alliance" },
			{ id=9326, qType="Seasonal", name="Undercity", faction="Alliance",
				tip="In the Ruins of Lordaeron. No need to descend", },
			{ id=9324, qType="Seasonal", name="Orgrimmar", faction="Alliance" }, },
			achievements={ { id=1024, faction="Alliance", showAllCriteria=true, versionUnder=60000, },
			{ id=6008, faction="Alliance", showAllCriteria=true, },
			{ id=6011, faction="Alliance", showAllCriteria=true, version=40000, },
			{ id=8045, faction="Alliance", showAllCriteria=true, version=60000, },
			{ id=11283, faction="Alliance", showAllCriteria=true, version=60000, },
			{ id=11280, faction="Alliance", showAllCriteria=true, version=70000, },
			{ id=1027, faction="Horde", showAllCriteria=true, versionUnder=60000, },
			{ id=6009, faction="Horde", showAllCriteria=true, },
			{ id=6012, faction="Horde", showAllCriteria=true, version=40000, },
			{ id=8044, faction="Horde", showAllCriteria=true, version=60000, },
			{ id=11284, faction="Horde", showAllCriteria=true, version=60000, },
			{ id=11282, faction="Horde", showAllCriteria=true, version=70000, }, }, }
ns.setLeftOvers = { flame3=true, alwaysShow=(ns.version>=40000) and true, noCoords= true, noContinent=true,
			achievements={ { id=8045, faction="Alliance", showAllCriteria=true, version=50000, versionUnder=60000, },
			{ id=13341, faction="Alliance", showAllCriteria=true, version=80000, },
			{ id=17737, faction="Alliance", showAllCriteria=true, version=100000, },
			{ id=41631, faction="Alliance", showAllCriteria=true, version=110000, },
			{ id=8044, faction="Horde", showAllCriteria=true, version=50000, versionUnder=60000, },
			{ id=13340, faction="Horde", showAllCriteria=true, version=80000, },
			{ id=17738, faction="Horde", showAllCriteria=true, version=100000, },
			{ id=41632, faction="Horde", showAllCriteria=true, version=110000, }, { id=263, },
			{ id=271, }, { id=272, }, { id=1145, name=ns.thief, aQuest=9365, faction="Alliance", tip="Only need to steal one" },
			{ id=1145, name=ns.thief, aQuest=9339, faction="Horde", tip="Only need to steal one" }, }, }
ns.setFlavour = { flavour=true, alwaysShow=true, noCoords= true, noContinent=true,
			tip="Across Azeroth and Outland, brilliant bonfires have been lit to rekindle peoples’ spirits and ward off ancient "
			.."evils. Each year, new guardians are chosen to watch over the sacred flames and ensure that they are never "
			.."extinguished.\n\n((Blizzard Website 19th June 2012))\n\n((A long time ago there was also an Engineers' Explosive "
			.."Extravaganza on the calendar for US players (EU missed out) and obviously scheduled for 4th July.))\n\n"
			.."Deep within the cavernous halls of the Undermine, goblins labor and toil over their strange and fanciful "
			.."engineering  creations. When they are not constructing powerful devices of destruction, they find making fireworks "
			.."a diverting pastime. They work tirelessly over strange chemical concoctions used to produce precisely the right "
			.."color and, of course, spectacular explosions. It is an art form that comes naturally to those who find great "
			.."pleasure in making things explode in a variety of ways. Competition is fierce among the engineers as they strive "
			.."for perfection within their pyrotechnics.\n\nSince holding an exhibition indoors — particularly within range of a "
			.."goblin engineer's workshop — is completely out of the question, it was decided by the Tinkers' Union that a day "
			.."would be chosen wherein the pyrotechnicians would go out into the world and share their creations with the world "
			.."(for a modest fee, of course). For one glorious day, the sky would be alight with the fantastic creations of "
			.."engineers throughout Azeroth.\n\nWhether Alliance or Horde, these pyrotechnicians are more than happy to help you "
			.."set the sky on fire during the Engineers' Explosive Extravaganza. (Just remember, point all incendiaries away from "
			.."the face.)\n\n((Blizzard Website 6th May 2005))", }

--==================================================================================================================================
--
-- KALIMDOR
--
--==================================================================================================================================

ns.points[ ns.map.ashenvale ] = { -- Ashenvale
	[51356615] = { faction="Horde", achievements={ { id=1026, index=1, qType="Seasonal", aQuest=11841, version=50000, },
					{ id=1026, index=11, qType="Seasonal", aQuest=11841, version=40000, versionUnder=50000, }, },
					wardenKeeper=true },
	[51586666] = { faction="Alliance", achievements={ { id=1029, index=1, qType="Seasonal", aQuest=11765, version=50000, },
					{ id=1029, index=10, qType="Seasonal", aQuest=11765, version=40000, versionUnder=50000, }, }, extinguish=true },
	[64007120] = { flickering=true, versionUnder=20000, quests={ { id=9388, name=ns.ffKalimdor, qType="Seasonal", }, }, },
	[86784150] = { faction="Horde", achievements={ { id=1032, index=1, qType="Seasonal", aQuest=11734, version=50000, },
					{ id=1032, index=10, qType="Seasonal", aQuest=11734, version=40000, versionUnder=50000, }, }, extinguish=true },
	[86944187] = { faction="Alliance", achievements={ { id=1023, index=1, qType="Seasonal", aQuest=11805, version=50000, },
					{ id=1023, index=10, qType="Seasonal", aQuest=11805, version=40000, versionUnder=50000, }, },
					wardenKeeper=true },
}

ns.points[ ns.map.azshara ] = { -- Azshara
	[41304310] = { wild=true, versionUnder=20000, quests={ { id=9322, name=ns.wildKalimdor, qType="Seasonal", }, }, },
	[60465343] = { faction="Alliance", achievements={ { id=1029, index=2, qType="Seasonal", aQuest=28919, version=50000, }, },
					extinguish=true }, -- Correct. Not in the Cata table
	[60805347] = { faction="Horde", achievements={ { id=1026, index=2, qType="Seasonal", aQuest=28923, version=50000, }, },
					wardenKeeper=true }, -- Correct. Not in the Cata table
}

ns.points[ ns.map.azuremyst ] = { -- Azuremyst Isle
	[44485252] = { faction="Alliance", achievements={ { id=1023, index=2, qType="Seasonal", aQuest=11806, version=50000, },
					{ id=1023, index=5, qType="Seasonal", aQuest=11806, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[44675267] = { faction="Horde", achievements={ { id=1032, index=2, qType="Seasonal", aQuest=11735, version=50000, },
					{ id=1032, index=1, qType="Seasonal", aQuest=11735, version=40000, versionUnder=50000, }, }, extinguish=true },
	[24653685] = { faction="Horde", achievements={ { id=1145, qType="Seasonal", aQuest=11933, name="The Exodar", }, }, version=40000,
					king=true, quests={ { id=11933, name="Stealing the Exodar's Flame", qType="Seasonal" }, }, },
}

ns.points[ ns.map.bloodmyst ] = { -- Bloodmyst Isle
	[55816789] = { faction="Alliance", achievements={ { id=1023, index=3, qType="Seasonal", aQuest=11809, version=50000, },
					{ id=1023, index=9, qType="Seasonal", aQuest=11809, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[55886845] = { faction="Horde", achievements={ { id=1032, index=3, qType="Seasonal", aQuest=11738, version=50000, },
					{ id=1032, index=9, qType="Seasonal", aQuest=11738, version=40000, versionUnder=50000, }, }, extinguish=true },
}

ns.points[ ns.map.darkshore ] = { -- Darkshore
	[41209000] = { flickering=true, versionUnder=20000, quests={ { id=9388, name=ns.ffKalimdor, qType="Seasonal", }, }, },
	[48732265] = { faction="Alliance", achievements={ { id=1023, index=4, qType="Seasonal", aQuest=11811, version=50000, },
					{ id=1023, index=1, qType="Seasonal", aQuest=11811, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[48922257] = { faction="Horde", achievements={ { id=1032, index=4, qType="Seasonal", aQuest=11740, version=50000, },
					{ id=1032, index=8, qType="Seasonal", aQuest=11740, version=40000, versionUnder=50000, }, }, extinguish=true },
}

ns.points[ ns.map.darnassus ] = { -- Darnassus
	[63684707] = { faction="Horde", achievements={ { id=1145, qType="Seasonal", aQuest=9332, name="Darnassus", }, }, version=40000,
					king=true, quests={ version=20000, { id=9332, name="Stealing Darnassus's Flame", qType="Seasonal" }, }, },
}

ns.points[ ns.map.desolace ] = { -- Desolace
	[26147691] = { faction="Horde", achievements={ { id=1026, index=3, qType="Seasonal", aQuest=11845, version=50000, },
					{ id=1026, index=10, qType="Seasonal", aQuest=11845, version=40000, versionUnder=50000, }, },
					wardenKeeper=true },
	[26197719] = { faction="Alliance", achievements={ { id=1029, index=3, qType="Seasonal", aQuest=11769, version=50000, },
					{ id=1029, index=9, qType="Seasonal", aQuest=11769, version=40000, versionUnder=50000, }, }, extinguish=true },
	[65881693] = { faction="Horde", achievements={ { id=1032, index=5, qType="Seasonal", aQuest=11741, version=50000, },
					{ id=1032, index=3, qType="Seasonal", aQuest=11741, version=40000, versionUnder=50000, }, }, extinguish=true },
	[66121708] = { faction="Alliance", achievements={ { id=1023, index=5, qType="Seasonal", aQuest=11812, version=50000, },
					{ id=1023, index=8, qType="Seasonal", aQuest=11812, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
}

ns.points[ ns.map.durotar ] = { -- Durotar
	[52034717] = { faction="Alliance", achievements={ { id=1029, index=4, qType="Seasonal", aQuest=11770, version=50000, },
					{ id=1029, index=2, qType="Seasonal", aQuest=11770, version=40000, versionUnder=50000, }, }, extinguish=true },
	[52244740] = { faction="Horde", achievements={ { id=1026, index=4, qType="Seasonal", aQuest=11846, version=50000, },
					{ id=1026, index=9, qType="Seasonal", aQuest=11846, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
}

ns.points[ ns.map.dustwallow ] = { -- Dustwallow Marsh
	[33283078] = { faction="Alliance", achievements={ { id=1029, index=5, qType="Seasonal", aQuest=11771, version=50000, },
					{ id=1029, index=1, qType="Seasonal", aQuest=11771, version=40000, versionUnder=50000, }, }, extinguish=true },
	[33433091] = { faction="Horde", achievements={ { id=1026, index=5, qType="Seasonal", aQuest=11847, version=50000, },
					{ id=1026, index=8, qType="Seasonal", aQuest=11847, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[61824046] = { faction="Alliance", achievements={ { id=1023, index=6, qType="Seasonal", aQuest=11815, version=50000, },
					{ id=1023, index=2, qType="Seasonal", aQuest=11815, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[62044040] = { faction="Horde", achievements={ { id=1032, index=6, qType="Seasonal", aQuest=11744, version=50000, },
					{ id=1032, index=11, qType="Seasonal", aQuest=11744, version=40000, versionUnder=50000, }, }, extinguish=true },
}

ns.points[ ns.map.feralas ] = { -- Feralas
	[46664371] = { faction="Horde", achievements={ { id=1032, index=7, qType="Seasonal", aQuest=11746, }, }, version=40000,
					extinguish=true }, -- Correct. Same index in Cata
	[46824370] = { faction="Alliance", achievements={ { id=1023, index=7, qType="Seasonal", aQuest=11817, }, }, version=40000,
					wardenKeeper=true }, -- Correct. Same index in Cata
	[72374779] = { faction="Horde", achievements={ { id=1026, index=6, qType="Seasonal", aQuest=11849, version=50000, },
					{ id=1026, index=7, qType="Seasonal", aQuest=11849, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[72434762] = { faction="Alliance", achievements={ { id=1029, index=6, qType="Seasonal", aQuest=11773, version=50000, },
					{ id=1029, index=8, qType="Seasonal", aQuest=11773, version=40000, versionUnder=50000, }, }, extinguish=true },
}

ns.points[ ns.map.mulgore ] = { -- Mulgore
	[35072392] = { faction="Alliance", achievements={ { id=1145, qType="Seasonal", aQuest=9325, name="Orgrimmar", }, },
					version=40000, king=true, quests={ version=20000, { id=9325, name="Stealing Thunder Bluff's Flame", qType="Seasonal" }, }, },
	[34002200] = { light=true, faction="Horde", versionUnder=20000, -- Actually: 34172219
					quests={ { id=9319, name=ns.light1, qType="Seasonal", }, { id=9386, name=ns.light2, qType="Seasonal", },
					{ id=9322, name=ns.wildKalimdor, qType="Seasonal", }, { id=9323, name=ns.wildEK, qType="Seasonal", }, }, },
	[34182237] = { festival=true, faction="Horde", versionUnder=20000, 
					quests={ { id=9368, name=ns.festival, qType="Seasonal", },
					{ id=9388, name=ns.ffKalimdor, qType="Seasonal", }, { id=9389, name=ns.ffEK, qType="Seasonal", }, }, },
	[51825926] = { faction="Horde", achievements={ { id=1026, index=7, qType="Seasonal", aQuest=11852, version=50000, },
					{ id=1026, index=6, qType="Seasonal", aQuest=11852, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[51935945] = { faction="Alliance", achievements={ { id=1029, index=7, qType="Seasonal", aQuest=11777, }, }, version=40000,
					extinguish=true }, -- Correct. Same index in Cata
}

ns.points[ ns.map.barrens ] = { -- Northern Barrens
	[49855439] = { faction="Alliance", achievements={ { id=1029, index=8, qType="Seasonal", aQuest=11783, version=50000, },
					{ id=1029, index=3, qType="Seasonal", aQuest=11783, version=40000, versionUnder=50000, }, }, extinguish=true },
	[49955463] = { faction="Horde", achievements={ { id=1026, index=8, qType="Seasonal", aQuest=11859, version=50000, },
					{ id=1026, index=5, qType="Seasonal", aQuest=11859, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
}

ns.points[ ns.map.orgrimmar ] = { -- Orgrimmar
	[46223760] = { faction="Alliance", achievements={ { id=1145, qType="Seasonal", aQuest=9324, name="Orgrimmar", }, },
					version=40000, king=true, quests={ version=20000, { id=9324, name="Stealing Orgrimmar's Flame", qType="Seasonal" }, }, },
	[42533461] = { festival=true, faction="Horde", versionUnder=20000, 
					quests={ { id=9368, name=ns.festival, qType="Seasonal", },
					{ id=9388, name=ns.ffKalimdor, qType="Seasonal", }, { id=9389, name=ns.ffEK, qType="Seasonal", }, }, },
	[43003500] = { light=true, faction="Horde", versionUnder=20000, -- Actual is 42633431 but way too close. Offset
					quests={ { id=9319, name=ns.light1, qType="Seasonal", }, { id=9386, name=ns.light2, qType="Seasonal", },
					{ id=9322, name=ns.wildKalimdor, qType="Seasonal", }, { id=9323, name=ns.wildEK, qType="Seasonal", }, }, },
}

ns.points[ ns.map.silithus ] = { -- Silithus
	[50864131] = { faction="Horde", achievements={ { id=1026, index=9, qType="Seasonal", aQuest=11836, version=50000, },
					{ id=1026, index=3, qType="Seasonal", aQuest=11836, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[50864166] = { faction="Alliance", achievements={ { id=1029, index=9, qType="Seasonal", aQuest=11800, version=50000, },
					{ id=1029, index=6, qType="Seasonal", aQuest=11800, version=40000, versionUnder=50000, }, }, extinguish=true },
	[60313351] = { faction="Alliance", achievements={ { id=1023, index=8, qType="Seasonal", aQuest=11831, version=50000, },
					{ id=1023, index=3, qType="Seasonal", aQuest=11831, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[60543314] = { faction="Horde", achievements={ { id=1032, index=8, qType="Seasonal", aQuest=11760, version=50000, },
					{ id=1032, index=6, qType="Seasonal", aQuest=11760, version=40000, versionUnder=50000, }, }, extinguish=true },
	[78102010] = { wild=true, versionUnder=20000, quests={ { id=9322, name=ns.wildKalimdor, qType="Seasonal", }, }, },
}

ns.points[ 199 ] = { -- Southern Barrens
	[40716734] = { faction="Alliance", achievements={ { id=1029, index=10, qType="Seasonal", aQuest=28914, version=50000, },
					{ id=1029, index=12, qType="Seasonal", aQuest=28914, version=40000, versionUnder=50000, }, }, extinguish=true },
	[40856779] = { faction="Horde", achievements={ { id=1026, index=10, qType="Seasonal", aQuest=28927, version=50000, },
					{ id=1026, index=12, qType="Seasonal", aQuest=28927, version=40000, versionUnder=50000, }, },
					wardenKeeper=true },
	[48337223] = { faction="Alliance", achievements={ { id=1023, index=9, qType="Seasonal", aQuest=28926, version=50000, },
					{ id=1023, index=12, qType="Seasonal", aQuest=28926, version=40000, versionUnder=50000, }, },
					wardenKeeper=true },
	[48267246] = { faction="Horde", achievements={ { id=1032, index=9, qType="Seasonal", aQuest=28913, version=50000, },
					{ id=1032, index=12, qType="Seasonal", aQuest=28913, version=40000, versionUnder=50000, }, }, extinguish=true },
}

ns.points[ ns.map.stonetalon ] = { -- Stonetalon Mountains
	[49295133] = { faction="Alliance", achievements={ { id=1023, index=10, qType="Seasonal", aQuest=28928, version=50000, }, },
					wardenKeeper=true }, -- Correct. Not in the Cata table
	[49505113] = { faction="Horde", achievements={ { id=1032, index=10, qType="Seasonal", aQuest=28915, version=50000, }, },
					extinguish=true }, -- Correct. Not in the Cata table
	[52916245] = { faction="Horde", achievements={ { id=1026, index=11, qType="Seasonal", aQuest=11856, version=50000, },
					{ id=1026, index=2, qType="Seasonal", aQuest=11856, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[52976232] = { faction="Alliance", achievements={ { id=1029, index=11, qType="Seasonal", aQuest=11780, version=50000, },
					{ id=1029, index=5, qType="Seasonal", aQuest=11780, version=40000, versionUnder=50000, }, }, extinguish=true },
	[59207200] = { flickering=true, versionUnder=20000, quests={ { id=9388, name=ns.ffKalimdor, qType="Seasonal", }, }, },
}

ns.points[ ns.map.tanaris ] = { -- Tanaris
	[49822788] = { faction="Horde", achievements={ { id=1026, index=12, qType="Seasonal", aQuest=11838, version=50000, },
					{ id=1026, index=1, qType="Seasonal", aQuest=11838, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[49832812] = { faction="Alliance", achievements={ { id=1029, index=12, qType="Seasonal", aQuest=11802, version=50000, },
					{ id=1029, index=4, qType="Seasonal", aQuest=11802, version=40000, versionUnder=50000, }, }, extinguish=true },
	[52002900] = { faction="Alliance", achievements={ { id=1023, index=11, qType="Seasonal", aQuest=11833, }, }, version=40000,
					wardenKeeper=true }, -- Correct. Same index
	[52643006] = { faction="Horde", achievements={ { id=1032, index=11, qType="Seasonal", aQuest=11762, version=50000, },
					{ id=1032, index=4, qType="Seasonal", aQuest=11762, version=40000, versionUnder=50000, }, }, extinguish=true },
}

ns.points[ ns.map.teldrassil ] = { -- Teldrassil
	[34524766] = { faction="Horde", achievements={ { id=1145, qType="Seasonal", aQuest=9332, name="Darnassus", }, }, version=40000,
					king=true, quests={ version=20000, { id=9332, name="Stealing Darnassus's Flame", qType="Seasonal" }, }, },
	[54755283] = { faction="Horde", achievements={ { id=1032, index=12, qType="Seasonal", aQuest=11753, version=50000, },
					{ id=1032, index=5, qType="Seasonal", aQuest=11753, version=40000, versionUnder=50000, }, }, extinguish=true },
	[54885279] = { faction="Alliance", achievements={ { id=1023, index=12, qType="Seasonal", aQuest=11824, version=50000, },
					{ id=1023, index=6, qType="Seasonal", aQuest=11824, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[56559198] = { light=true, faction="Alliance", versionUnder=20000, 
					quests={ { id=9319, name=ns.light1, qType="Seasonal", }, { id=9386, name=ns.light2, qType="Seasonal", },
					{ id=9322, name=ns.wildKalimdor, qType="Seasonal", }, { id=9323, name=ns.wildEK, qType="Seasonal", }, }, },
	[56579229] = { festival=true, faction="Alliance", versionUnder=20000, 
					quests={ { id=9367, name=ns.festival, qType="Seasonal", },
					{ id=9388, name=ns.ffKalimdor, qType="Seasonal", }, { id=9389, name=ns.ffEK, qType="Seasonal", }, }, },
}

ns.points[ ns.map.barrens ] = { -- The Barrens
	[69003900] = { flickering=true, versionUnder=20000, quests={ { id=9388, name=ns.ffKalimdor, qType="Seasonal", }, }, },
}

ns.points[ ns.map.theExodar ] = { -- The Exodar
	[41362616] = { faction="Horde", achievements={ { id=1145, qType="Seasonal", aQuest=11933, name="The Exodar", }, },
					version=40000, king=true, quests={ { id=11933, name="Stealing the Exodar's Flame", qType="Seasonal" }, }, },
}

ns.points[ ns.map.thunder ] = { -- Thunder Bluff
	[21452697] = { faction="Alliance", achievements={ { id=1145, qType="Seasonal", aQuest=9325, name="Orgrimmar", }, },
					version=40000, king=true, quests={ version=20000, { id=9325, name="Stealing Thunder Bluff's Flame", qType="Seasonal" }, }, },
	[21492587] = { light=true, faction="Horde", versionUnder=20000, 
					quests={ { id=9319, name=ns.light1, qType="Seasonal", }, { id=9386, name=ns.light2, qType="Seasonal", },
					{ id=9322, name=ns.wildKalimdor, qType="Seasonal", }, { id=9323, name=ns.wildEK, qType="Seasonal", }, }, },
	[21522718] = { festival=true, faction="Horde", versionUnder=20000, 
					quests={ { id=9368, name=ns.festival, qType="Seasonal", },
					{ id=9388, name=ns.ffKalimdor, qType="Seasonal", }, { id=9389, name=ns.ffEK, qType="Seasonal", }, }, },
}

ns.points[ ns.map.ungoro ] = { -- Un'Goro
	[56336635] = { faction="Horde", achievements={ { id=1026, index=13, qType="Seasonal", aQuest=28933, version=50000, }, },
					wardenKeeper=true }, -- Correct. Not in the Cata table
	[56496585] = { faction="Alliance", achievements={ { id=1029, index=13, qType="Seasonal", aQuest=28920, version=50000, }, },
					extinguish=true }, -- Correct. Not in the Cata table
	[59796291] = { faction="Horde", achievements={ { id=1032, index=13, qType="Seasonal", aQuest=28921, version=50000, }, },
					extinguish=true }, -- Correct. Not in the Cata table
	[59866325] = { faction="Alliance", achievements={ { id=1023, index=13, qType="Seasonal", aQuest=28932, version=50000, }, },
					wardenKeeper=true }, -- Correct. Not in the Cata table
	[70207590] = { wild=true, versionUnder=20000, quests={ { id=9322, name=ns.wildKalimdor, qType="Seasonal", }, }, },
}

ns.points[ ns.map.winterspring ] = { -- Winterspring
	[30304310] = { wild=true, versionUnder=20000, quests={ { id=9322, name=ns.wildKalimdor, qType="Seasonal", }, }, },
	[58094725] = { faction="Alliance", achievements={ { id=1029, index=14, qType="Seasonal", aQuest=11803, version=50000, },
					{ id=1029, index=11, qType="Seasonal", aQuest=11803, version=40000, versionUnder=50000, }, }, extinguish=true },
	[58144750] = { faction="Horde", achievements={ { id=1026, index=14, qType="Seasonal", aQuest=11839, version=50000, },
					{ id=1026, index=4, qType="Seasonal", aQuest=11839, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[61244725] = { faction="Alliance", achievements={ { id=1023, index=14, qType="Seasonal", aQuest=11834, version=50000, },
					{ id=1023, index=4, qType="Seasonal", aQuest=11834, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[61394717] = { faction="Horde", achievements={ { id=1032, index=14, qType="Seasonal", aQuest=11763, version=50000, },
					{ id=1032, index=2, qType="Seasonal", aQuest=11763, version=40000, versionUnder=50000, }, }, extinguish=true },
}

ns.points[ ns.map.kalimdor ] = { -- Kalimdor
	[02507820] = ns.setExtKalEK,
	[02508250] = ns.setMain,
	[04708530] = ns.setLeftOvers,
	[05008100] = ns.setFlavour,
	[05207700] = ns.setExtOther,
	[07308400] = ns.setFlameOther,
	[07607980] = ns.setFlameKalEK,
}

--==================================================================================================================================
--
-- EASTERN KINGDOMS
--
--==================================================================================================================================

ns.points[ ns.map.arathi ] = { -- Arathi Highlands
	[44304604] = { faction="Alliance", achievements={ { id=1022, index=1, qType="Seasonal", aQuest=11804, version=50000, },
					{ id=1022, index=2, qType="Seasonal", aQuest=11804, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[44574615] = { faction="Horde", achievements={ { id=1031, index=1, qType="Seasonal", aQuest=11732, version=50000, },
					{ id=1031, index=9, qType="Seasonal", aQuest=11732, version=40000, versionUnder=50000, }, }, extinguish=true },
	[69144286] = { faction="Alliance", achievements={ { id=1028, index=1, qType="Seasonal", aQuest=11764, version=50000, },
					{ id=1028, index=5, qType="Seasonal", aQuest=11764, version=40000, versionUnder=50000, }, }, extinguish=true },
	[69354256] = { faction="Horde", achievements={ { id=1025, index=1, qType="Seasonal", aQuest=11840, version=50000, },
					{ id=1025, index=10, qType="Seasonal", aQuest=11840, version=40000, versionUnder=50000, }, },
					wardenKeeper=true },
}

ns.points[ ns.map.badlands ] = { -- Badlands
	[18745604] = { faction="Horde", achievements={ { id=1031, index=2, qType="Seasonal", aQuest=28912, version=50000, }, },
					extinguish=true }, -- Correct. Not in the table for Cata
	[19015619] = { faction="Alliance", achievements={ { id=1022, index=2, qType="Seasonal", aQuest=28925, version=50000, }, },
					wardenKeeper=true }, -- Correct. Not in the table for Cata
	[23093744] = { faction="Horde", achievements={ { id=1025, index=2, qType="Seasonal", aQuest=11842, version=50000, },
					{ id=1025, index=1, qType="Seasonal", aQuest=11842, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[24053709] = { faction="Alliance", achievements={ { id=1028, index=2, qType="Seasonal", aQuest=11766, version=50000, },
					{ id=1028, index=11, qType="Seasonal", aQuest=11766, version=40000, versionUnder=50000, }, }, extinguish=true },
}

ns.points[ ns.map.blastedLands ] = { -- Blasted Lands
	[46221378] = { faction="Horde", achievements={ { id=1025, index=3, qType="Seasonal", aQuest=28930, version=50000, }, },
					wardenKeeper=true }, -- Correct. Not in the table for Cata
	[46301414] = { faction="Alliance", achievements={ { id=1028, index=3, qType="Seasonal", aQuest=28917, version=50000, }, },
					extinguish=true }, -- Correct. Not in the table for Cata
	[53603100] = { wild=true, versionUnder=20000, quests={ { id=9323, name=ns.wildEK, qType="Seasonal", }, }, },
	[55271506] = { faction="Horde", achievements={ { id=1031, index=3, qType="Seasonal", aQuest=11737, }, }, version=40000,
					extinguish=true }, -- Correct. Same index
	[55531488] = { faction="Alliance", achievements={ { id=1022, index=3, qType="Seasonal", aQuest=11808, version=50000, },
					{ id=1022, index=5, qType="Seasonal", aQuest=11808, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
}


ns.points[ ns.map.burningSteppes ] = { -- Burning Steppes
	[51112921] = { faction="Horde", achievements={ { id=1025, index=4, qType="Seasonal", aQuest=11844, version=50000, },
					{ id=1025, index=11, qType="Seasonal", aQuest=11844, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[51452911] = { faction="Alliance", achievements={ { id=1028, index=4, qType="Seasonal", aQuest=11768, version=50000, },
					{ id=1028, index=7, qType="Seasonal", aQuest=11768, version=40000, versionUnder=50000, }, }, extinguish=true },
	[68346064] = { faction="Alliance", achievements={ { id=1022, index=4, qType="Seasonal", aQuest=11810, version=50000, },
					{ id=1022, index=12, qType="Seasonal", aQuest=11810, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[68576018] = { faction="Horde", achievements={ { id=1031, index=4, qType="Seasonal", aQuest=11739, version=50000, },
					{ id=1031, index=8, qType="Seasonal", aQuest=11739, version=40000, versionUnder=50000, }, }, extinguish=true },
}

ns.points[ ns.map.dunMorogh ] = { -- Dun Morogh
	[53704483] = { faction="Horde", achievements={ { id=1031, index=5, qType="Seasonal", aQuest=11742, version=50000, },
					{ id=1031, index=12, qType="Seasonal", aQuest=11742, version=40000, versionUnder=50000, }, }, extinguish=true },
	[53804523] = { faction="Alliance", achievements={ { id=1022, index=5, qType="Seasonal", aQuest=11813, version=50000, },
					{ id=1022, index=11, qType="Seasonal", aQuest=11813, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[61292505] = { light=true, faction="Alliance", versionUnder=20000, 
					quests={ { id=9319, name=ns.light1, qType="Seasonal", }, { id=9386, name=ns.light2, qType="Seasonal", },
					{ id=9322, name=ns.wildKalimdor, qType="Seasonal", }, { id=9323, name=ns.wildEK, qType="Seasonal", }, }, },
	[61332519] = { festival=true, faction="Alliance", versionUnder=20000, 
					quests={ { id=9367, name=ns.festival, qType="Seasonal", },
					{ id=9388, name=ns.ffKalimdor, qType="Seasonal", }, { id=9389, name=ns.ffEK, qType="Seasonal", }, }, },
	[68642324] = { faction="Horde", achievements={ { id=1145, qType="Seasonal", aQuest=9331, name="Ironforge", }, }, king=true,
					quests={ version=20000, { id=9331, name="Stealing Ironforge's Flame", qType="Seasonal" }, }, },
}

ns.points[ ns.map.duskwood ] = { -- Duskwood
	[73695461] = { faction="Alliance", achievements={ { id=1022, index=6, qType="Seasonal", aQuest=11814, version=50000, },
					{ id=1022, index=4, qType="Seasonal", aQuest=11814, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[73335491] = { faction="Horde", achievements={ { id=1031, index=6, qType="Seasonal", aQuest=11743, version=50000, },
					{ id=1031, index=2, qType="Seasonal", aQuest=11743, version=40000, versionUnder=50000, }, }, extinguish=true },
}

ns.points[ ns.map.easternP ] = { -- Eastern Plaguelands
	[57507260] = { wild=true, versionUnder=20000, quests={ { id=9323, name=ns.wildEK, qType="Seasonal", }, }, },
}

ns.points[ ns.map.elwynn ] = { -- Elwynn Forest
	[19523878] = { faction="Horde", achievements={ { id=1145, qType="Seasonal", aQuest=9330, name="Stormwind City", }, },
					version=40000, king=true, quests={ version=20000, { id=9330, name="Stealing Stormwind's Flame", qType="Seasonal" }, }, },
	[43166286] = { faction="Horde", achievements={ { id=1031, index=7, qType="Seasonal", aQuest=11745, version=50000, },
					{ id=1031, index=11, qType="Seasonal", aQuest=11745, version=40000, versionUnder=50000, }, }, extinguish=true },
	[43476263] = { faction="Alliance", achievements={ { id=1022, index=7, qType="Seasonal", aQuest=11816, version=50000, },
					{ id=1022, index=13, qType="Seasonal", aQuest=11816, version=40000, versionUnder=50000, }, },
					wardenKeeper=true },
}

ns.points[ ns.map.eversong ] = { -- Eversong Woods
	[46395041] = { faction="Alliance", achievements={ { id=1028, index=5, qType="Seasonal", aQuest=11772, version=50000, },
					{ id=1028, index=10, qType="Seasonal", aQuest=11772, version=40000, versionUnder=50000, }, }, extinguish=true },
	[46405060] = { faction="Horde", achievements={ { id=1025, index=5, qType="Seasonal", aQuest=11848, version=50000, },
					{ id=1025, index=3, qType="Seasonal", aQuest=11848, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[55883763] = { faction="Alliance", achievements={ { id=1145, qType="Seasonal", aQuest=11935, name="Silvermoon City", }, },
					king=true, quests={ { id=11935, name="Stealing Silvermoon's Flame", qType="Seasonal" }, }, },
}

ns.points[ ns.map.ghostlands ] = { -- Ghostlands
	[46902634] = { faction="Horde", achievements={ { id=1025, index=6, qType="Seasonal", aQuest=11850, }, }, version=40000,
					wardenKeeper=true }, -- Correct. Same index
	[47062604] = { faction="Alliance", achievements={ { id=1028, index=6, qType="Seasonal", aQuest=11774, version=50000, },
					{ id=1028, index=9, qType="Seasonal", aQuest=11774, version=40000, versionUnder=50000, }, }, extinguish=true },
}

ns.points[ ns.map.hillsbrad ] = { -- Hillsbrad Foothills
	[54554987] = { faction="Alliance", achievements={ { id=1028, index=7, qType="Seasonal", aQuest=11776, version=50000, },
					{ id=1028, index=8, qType="Seasonal", aQuest=11776, version=40000, versionUnder=50000, }, }, extinguish=true },
	[54605000] = { faction="Horde", achievements={ { id=1025, index=7, qType="Seasonal", aQuest=11853, version=50000, },
					{ id=1025, index=4, qType="Seasonal", aQuest=11853, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[54903300] = { flickering=true, versionUnder=20000, quests={ { id=9389, name=ns.ffEK, qType="Seasonal", }, }, },
}

ns.points[ ns.map.ironforge ] = { -- Ironforge
	[63592469] = { light=true, faction="Alliance", versionUnder=20000, 
					quests={ { id=9319, name=ns.light1, qType="Seasonal", }, { id=9386, name=ns.light2, qType="Seasonal", },
					{ id=9322, name=ns.wildKalimdor, qType="Seasonal", }, { id=9323, name=ns.wildEK, qType="Seasonal", }, }, },
	[63842555] = { festival=true, faction="Alliance", versionUnder=20000, 
					quests={ { id=9367, name=ns.festival, qType="Seasonal", },
					{ id=9388, name=ns.ffKalimdor, qType="Seasonal", }, { id=9389, name=ns.ffEK, qType="Seasonal", }, }, },
	[64622482] = { faction="Horde", achievements={ { id=1145, qType="Seasonal", aQuest=9331, name="Ironforge", }, }, version=40000,
					king=true, quests={ version=20000, { id=9331, name="Stealing Ironforge's Flame", qType="Seasonal" }, }, },
}
					
ns.points[ ns.map.lochModan ] = { -- Loch Modan
	[32334022] = { faction="Horde", achievements={ { id=1031, index=8, qType="Seasonal", aQuest=11749, version=50000, },
					{ id=1031, index=10, qType="Seasonal", aQuest=11749, version=40000, versionUnder=50000, }, }, extinguish=true },
	[32564095] = { faction="Alliance", achievements={ { id=1022, index=8, qType="Seasonal", aQuest=11820, version=50000, },
					{ id=1022, index=3, qType="Seasonal", aQuest=11820, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
}

ns.points[ ns.map.northStrangle ] = { -- Northern Stranglethorn
	[40585094] = { faction="Horde", achievements={ { id=1025, index=8, qType="Seasonal", aQuest=28924, version=50000, },
					{ id=1025, index=12, qType="Seasonal", aQuest=28924, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[40695180] = { faction="Alliance", achievements={ { id=1028, index=8, qType="Seasonal", aQuest=28911, version=50000, },
					{ id=1028, index=12, qType="Seasonal", aQuest=28911, version=40000, versionUnder=50000, }, }, extinguish=true },
	[51746332] = { faction="Horde", achievements={ { id=1031, index=9, qType="Seasonal", aQuest=28910, version=50000, },
					{ id=1031, index=14, qType="Seasonal", aQuest=28910, version=40000, versionUnder=50000, }, }, extinguish=true },
	[52056355] = { faction="Alliance", achievements={ { id=1022, index=9, qType="Seasonal", aQuest=28922, version=50000, },
					{ id=1022, index=14, qType="Seasonal", aQuest=28922, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
}

ns.points[ ns.map.redridge ] = { -- Redridge Mountains
	[24585371] = { faction="Horde", achievements={ { id=1031, index=10, qType="Seasonal", aQuest=11751, version=50000, },
					{ id=1031, index=13, qType="Seasonal", aQuest=11751, version=40000, versionUnder=50000, }, }, extinguish=true },
	[24885338] = { faction="Alliance", achievements={ { id=1022, index=10, qType="Seasonal", aQuest=11822, }, }, version=40000,
					wardenKeeper=true }, -- Correct. Same index
}

ns.points[ ns.map.searingGorge ] = { -- Searing Gorge
	[31907300] = { wild=true, versionUnder=20000, quests={ { id=9323, name=ns.wildEK, qType="Seasonal", }, }, },
}

ns.points[ ns.map.silvermoon ] = { -- Silvemoon City
	[69264308] = { faction="Alliance", achievements={ { id=1145, qType="Seasonal", aQuest=11935, name="Silvermoon City", }, },
					version=40000, king=true, quests={ { id=11935, name="Stealing Silvermoon's Flame", qType="Seasonal" }, }, },
}

ns.points[ ns.map.silverpine ] = { -- Silverpine Forest
	[49613859] = { faction="Alliance", achievements={ { id=1028, index=9, qType="Seasonal", aQuest=11580, version=50000,},
					{ id=1028, index=4, qType="Seasonal", aQuest=11580, version=40000, versionUnder=50000, }, }, extinguish=true },
	[49643822] = { faction="Horde", achievements={ { id=1025, index=9, qType="Seasonal", aQuest=11584, }, }, version=40000,
					wardenKeeper=true }, -- Correct. Same index
	[53906910] = { flickering=true, versionUnder=20000, quests={ { id=9389, name=ns.ffEK, qType="Seasonal", }, }, },
}

ns.points[ ns.map.stormwind ] = { -- Stormwind City
	[38546129] = { light=true, faction="Alliance", versionUnder=20000, 
					quests={ { id=9319, name=ns.light1, qType="Seasonal", }, { id=9386, name=ns.light2, qType="Seasonal", },
					{ id=9322, name=ns.wildKalimdor, qType="Seasonal", }, { id=9323, name=ns.wildEK, qType="Seasonal", }, }, },
	[39216143] = { festival=true, faction="Alliance", versionUnder=20000, 
					quests={ { id=9367, name=ns.festival, qType="Seasonal", },
					{ id=9388, name=ns.ffKalimdor, qType="Seasonal", }, { id=9389, name=ns.ffEK, qType="Seasonal", }, }, },
	[49797263] = { faction="Horde", achievements={ { id=1145, qType="Seasonal", aQuest=9330, name="Stormwind City", }, },
					version=40000, king=true, quests={ version=20000, { id=9330, name="Stealing Stormwind's Flame", qType="Seasonal" }, }, },
}

ns.points[ 224 ] = { -- Stranglethorn Vale
	[44223306] = { faction="Horde", achievements={ { id=1025, index=8, qType="Seasonal", aQuest=28924, version=50000, },
					{ id=1025, index=12, qType="Seasonal", aQuest=28924, version=40000, versionUnder=50000, }, },
					wardenKeeper=true },
	[44283360] = { faction="Alliance", achievements={ { id=1028, index=8, qType="Seasonal", aQuest=28911, version=50000, },
					{ id=1028, index=12, qType="Seasonal", aQuest=28911, version=40000, versionUnder=50000, }, }, extinguish=true },
	[51204081] = { faction="Horde", achievements={ { id=1031, index=9, qType="Seasonal", aQuest=28910, version=50000, },
					{ id=1031, index=14, qType="Seasonal", aQuest=28910, version=40000, versionUnder=50000, }, }, extinguish=true },
	[51394095] = { faction="Alliance", achievements={ { id=1022, index=9, qType="Seasonal", aQuest=28922, version=50000, },
					{ id=1022, index=14, qType="Seasonal", aQuest=28922, version=40000, versionUnder=50000, }, },
					wardenKeeper=true },	
	[43617792] = { faction="Horde", achievements={ { id=1025, index=11, qType="Seasonal", aQuest=11837, version=50000, },
					{ id=1025, index=8, qType="Seasonal", aQuest=11837, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[43677810] = { faction="Alliance", achievements={ { id=1028, index=11, qType="Seasonal", aQuest=11801, version=50000, },
					{ id=1028, index=3, qType="Seasonal", aQuest=11801, version=40000, versionUnder=50000, }, }, extinguish=true },
	[44507607] = { faction="Horde", achievements={ { id=1031, index=12, qType="Seasonal", aQuest=11761, version=50000, },
					{ id=1031, index=7, qType="Seasonal", aQuest=11761, version=40000, versionUnder=50000, }, }, extinguish=true },
	[44567627] = { faction="Alliance", achievements={ { id=1022, index=12, qType="Seasonal", aQuest=11832, version=50000, },
					{ id=1022, index=9, qType="Seasonal", aQuest=11832, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
}

ns.points[ ns.map.swampOS ] = { -- Swamp of Sorrows
	[70211447] = { faction="Horde", achievements={ { id=1031, index=11, qType="Seasonal", aQuest=28916, version=50000, }, },
					extinguish=true }, -- Correct. Not in the table for Cata
	[70251574] = { faction="Alliance", achievements={ { id=1022, index=11, qType="Seasonal", aQuest=28929, version=50000, }, },
					wardenKeeper=true }, -- Correct. Not in the table for Cata
	[76331377] = { faction="Horde", achievements={ { id=1025, index=10, qType="Seasonal", aQuest=11857, version=50000, },
					{ id=1025, index=2, qType="Seasonal", aQuest=11857, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[76701413] = { faction="Alliance", achievements={ { id=1028, index=10, qType="Seasonal", aQuest=11781, version=50000, },
					{ id=1028, index=6, qType="Seasonal", aQuest=11781, version=40000, versionUnder=50000, }, }, extinguish=true },
}

ns.points[ 210 ] = { -- The Cape of Stranglethorn
	[50407038] = { faction="Horde", achievements={ { id=1025, index=11, qType="Seasonal", aQuest=11837, version=50000, },
					{ id=1025, index=8, qType="Seasonal", aQuest=11837, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[50497069] = { faction="Alliance", achievements={ { id=1028, index=11, qType="Seasonal", aQuest=11801, version=50000, },
					{ id=1028, index=3, qType="Seasonal", aQuest=11801, version=40000, versionUnder=50000, }, }, extinguish=true },
	[51876732] = { faction="Horde", achievements={ { id=1031, index=12, qType="Seasonal", aQuest=11761, version=50000, },
					{ id=1031, index=7, qType="Seasonal", aQuest=11761, version=40000, versionUnder=50000, }, }, extinguish=true },
	[51976764] = { faction="Alliance", achievements={ { id=1022, index=12, qType="Seasonal", aQuest=11832, version=50000, },
					{ id=1022, index=9, qType="Seasonal", aQuest=11832, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
}

ns.points[ ns.map.TheHinter ] = { -- The Hinterlands
	[14345007] = { faction="Alliance", achievements={ { id=1022, index=13, qType="Seasonal", aQuest=11826, version=50000, },
					{ id=1022, index=8, qType="Seasonal", aQuest=11826, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[14484981] = { faction="Horde", achievements={ { id=1031, index=13, qType="Seasonal", aQuest=11755, version=50000, },
					{ id=1031, index=6, qType="Seasonal", aQuest=11755, version=40000, versionUnder=50000, }, }, extinguish=true },
	[61905320] = { wild=true, versionUnder=20000, quests={ { id=9323, name=ns.wildEK, qType="Seasonal", }, }, },
	[76647497] = { faction="Horde", achievements={ { id=1025, index=12, qType="Seasonal", aQuest=11860, version=50000, },
					{ id=1025, index=7, qType="Seasonal", aQuest=11860, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[76707459] = { faction="Alliance", achievements={ { id=1028, index=12, qType="Seasonal", aQuest=11784, version=50000, },
					{ id=1028, index=2, qType="Seasonal", aQuest=11784, version=40000, versionUnder=50000, }, }, extinguish=true },
}

ns.points[ ns.map.tirisfal ] = { -- Tirisfal Glades
	[57055173] = { faction="Alliance", achievements={ { id=1028, index=13, qType="Seasonal", aQuest=11786, version=50000, },
					{ id=1028, index=1, qType="Seasonal", aQuest=11786, version=40000, versionUnder=50000, }, }, extinguish=true },
	[57235175] = { faction="Horde", achievements={ { id=1025, index=13, qType="Seasonal", aQuest=11862, version=50000, },
					{ id=1025, index=5, qType="Seasonal", aQuest=11862, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[61727277] = { light=true, faction="Horde", versionUnder=20000, 
					quests={ { id=9319, name=ns.light1, qType="Seasonal", }, { id=9386, name=ns.light2, qType="Seasonal", },
					{ id=9322, name=ns.wildKalimdor, qType="Seasonal", }, { id=9323, name=ns.wildEK, qType="Seasonal", }, },
					tip="Ruins of Lordaeron. Do NOT descend" },
	[61937313] = { festival=true, faction="Horde", versionUnder=20000, 
					quests={ { id=9368, name=ns.festival, qType="Seasonal", },
					{ id=9388, name=ns.ffKalimdor, qType="Seasonal", }, { id=9389, name=ns.ffEK, qType="Seasonal", }, },
					tip="Ruins of Lordaeron. Do NOT descend" },
	[62286691] = { faction="Alliance", achievements={ { id=1145, qType="Seasonal", aQuest=9326, name="Ruins of Lordaeron", }, },
					version=40000, king=true, quests={ version=20000, { id=9326, name="Stealing the Undercity's Flame", qType="Seasonal" }, }, },
}

ns.points[ ns.map.undercity ] = { -- Undercity
	[65543633] = { light=true, faction="Horde", versionUnder=20000, 
					quests={ { id=9319, name=ns.light1, qType="Seasonal", }, { id=9386, name=ns.light2, qType="Seasonal", },
					{ id=9322, name=ns.wildKalimdor, qType="Seasonal", }, { id=9323, name=ns.wildEK, qType="Seasonal", }, },
					tip="Ruins of Lordaeron. Do NOT descend" },
	[66523806] = { festival=true, faction="Horde", versionUnder=20000, 
					quests={ { id=9368, name=ns.festival, qType="Seasonal", },
					{ id=9388, name=ns.ffKalimdor, qType="Seasonal", }, { id=9389, name=ns.ffEK, qType="Seasonal", }, },
					tip="Ruins of Lordaeron. Do NOT descend" },
}

ns.points[ ns.map.westernP ] = { -- Western Plaguelands
	[29095659] = { faction="Alliance", achievements={ { id=1028, index=14, qType="Seasonal", aQuest=28918, version=50000, }, },
					extinguish=true }, -- Correct. Not in the Cata table
	[29165734] = { faction="Horde", achievements={ { id=1025, index=14, qType="Seasonal", aQuest=28931, version=50000, }, },
					wardenKeeper=true }, -- Correct. Not in the Cata table
	[43478233] = { faction="Alliance", achievements={ { id=1022, index=14, qType="Seasonal", aQuest=11827, version=50000, },
					{ id=1022, index=6, qType="Seasonal", aQuest=11827, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[43508258] = { faction="Horde", achievements={ { id=1031, index=14, qType="Seasonal", aQuest=11756, version=50000, },
					{ id=1031, index=5, qType="Seasonal", aQuest=11756, version=40000, versionUnder=50000, }, }, extinguish=true },
}

ns.points[ ns.map.westfall ] = { -- Westfall
	[34108030] = { flickering=true, versionUnder=20000, quests={ { id=9389, name=ns.ffEK, qType="Seasonal", }, }, },
	[44766206] = { faction="Alliance", achievements={ { id=1022, index=15, qType="Seasonal", aQuest=11583, version=50000, },
					{ id=1022, index=7, qType="Seasonal", aQuest=11583, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[45086242] = { faction="Horde", achievements={ { id=1031, index=15, qType="Seasonal", aQuest=11581, version=50000, },
					{ id=1031, index=4, qType="Seasonal", aQuest=11581, version=40000, versionUnder=50000, }, }, extinguish=true },
}

ns.points[ ns.map.wetlands ] = { -- Wetlands
	[13274717] = { faction="Horde", achievements={ { id=1031, index=16, qType="Seasonal", aQuest=11757, version=50000, },
					{ id=1031, index=1, qType="Seasonal", aQuest=11757, version=40000, versionUnder=50000, }, }, extinguish=true },
	[13464707] = { faction="Alliance", achievements={ { id=1022, index=16, qType="Seasonal", aQuest=11828, version=50000, },
					{ id=1022, index=1, qType="Seasonal", aQuest=11828, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[51101700] = { flickering=true, versionUnder=20000, quests={ { id=9389, name=ns.ffEK, qType="Seasonal", }, }, },
}

ns.points[ ns.map.easternK ] = { -- Eastern Kingdoms
	[02507820] = ns.setExtKalEK,
	[02508250] = ns.setMain,
	[04708530] = ns.setLeftOvers,
	[05008100] = ns.setFlavour,
	[05207700] = ns.setExtOther,
	[07308400] = ns.setFlameOther,
	[07607980] = ns.setFlameKalEK,
}

--==================================================================================================================================
--
-- THE BURNING CRUSADE / OUTLAND
--
--==================================================================================================================================

ns.points[ ns.map.bladesEdge ] = { -- Blade's Edge Mountains
	[41576590] = { faction="Alliance", achievements={ { id=1024, index=1, qType="Seasonal", aQuest=11807, version=50000, },
					{ id=1024, index=7, qType="Seasonal", aQuest=11807, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[41766605] = { faction="Horde", achievements={ { id=1033, index=1, qType="Seasonal", aQuest=11736, version=50000, },
					{ id=1033, index=7, qType="Seasonal", aQuest=11736, version=40000, versionUnder=50000, }, }, extinguish=true },
	[49925866] = { faction="Horde", achievements={ { id=1027, index=1, qType="Seasonal", aQuest=11843, }, }, wardenKeeper=true },
					-- Correct. Same index
	[50005901] = { faction="Alliance", achievements={ { id=1030, index=1, qType="Seasonal", aQuest=11767, version=50000, },
					{ id=1030, index=7, qType="Seasonal", aQuest=11767, version=40000, versionUnder=50000, }, }, extinguish=true },
}

ns.points[ ns.map.hellfire ] = { -- Hellfire Peninsular
	[57114204] = { faction="Horde", achievements={ { id=1027, index=2, qType="Seasonal", aQuest=11851, version=50000, },
					{ id=1027, index=7, qType="Seasonal", aQuest=11851, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[57164183] = { faction="Alliance", achievements={ { id=1030, index=2, qType="Seasonal", aQuest=11775, version=50000, },
					{ id=1030, index=4, qType="Seasonal", aQuest=11775, version=40000, versionUnder=50000, }, }, extinguish=true },
	[61975836] = { faction="Horde", achievements={ { id=1033, index=2, qType="Seasonal", aQuest=11747, version=50000, },
					{ id=1033, index=1, qType="Seasonal", aQuest=11747, version=40000, versionUnder=50000, }, }, extinguish=true },
	[62175828] = { faction="Alliance", achievements={ { id=1024, index=2, qType="Seasonal", aQuest=11818, version=50000, },
					{ id=1024, index=3, qType="Seasonal", aQuest=11818, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
}

ns.points[ ns.map.nagrand ] = { -- Nagrand
	[49616946] = { faction="Alliance", achievements={ { id=1024, index=3, qType="Seasonal", aQuest=11821, version=50000, },
					{ id=1024, index=2, qType="Seasonal", aQuest=11821, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[49676971] = { faction="Horde", achievements={ { id=1033, index=3, qType="Seasonal", aQuest=11750, version=50000, },
					{ id=1033, index=6, qType="Seasonal", aQuest=11750, version=40000, versionUnder=50000, }, }, extinguish=true },
	[50913414] = { faction="Horde", achievements={ { id=1027, index=3, qType="Seasonal", aQuest=11854, }, }, wardenKeeper=true },
					-- Correct. Index the same in Cata
	[51063402] = { faction="Alliance", achievements={ { id=1030, index=3, qType="Seasonal", aQuest=11778, version=50000, },
					{ id=1030, index=2, qType="Seasonal", aQuest=11778, version=40000, versionUnder=50000, }, }, extinguish=true },
}

ns.points[ ns.map.netherstorm ] = { -- Netherstorm
	[31106286] = { faction="Horde", achievements={ { id=1033, index=4, qType="Seasonal", aQuest=11759, version=50000, },
					{ id=1033, index=5, qType="Seasonal", aQuest=11759, version=40000, versionUnder=50000, }, }, extinguish=true },
	[31216266] = { faction="Alliance", achievements={ { id=1024, index=4, qType="Seasonal", aQuest=11830, version=50000, },
					{ id=1024, index=6, qType="Seasonal", aQuest=11830, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[32116832] = { faction="Horde", achievements={ { id=1027, index=4, qType="Seasonal", aQuest=11835, version=50000, },
					{ id=1027, index=6, qType="Seasonal", aQuest=11835, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[32286825] = { faction="Alliance", achievements={ { id=1030, index=4, qType="Seasonal", aQuest=11799, version=50000, },
					{ id=1030, index=6, qType="Seasonal", aQuest=11799, version=40000, versionUnder=50000, }, }, extinguish=true },
}

ns.points[ ns.map.shadowmoon ] = { -- Shadowmoon Valley
	[33403053] = { faction="Horde", achievements={ { id=1027, index=5, qType="Seasonal", aQuest=11855, }, }, wardenKeeper=true },
					-- Correct. Index the same in Cata
	[33493032] = { faction="Alliance", achievements={ { id=1030, index=5, qType="Seasonal", aQuest=11779, version=50000, },
					{ id=1030, index=1, qType="Seasonal", aQuest=11779, version=40000, versionUnder=50000, }, }, extinguish=true },
	[39565442] = { faction="Horde", achievements={ { id=1033, index=5, qType="Seasonal", aQuest=11752, version=50000, },
					{ id=1033, index=4, qType="Seasonal", aQuest=11752, version=40000, versionUnder=50000, }, }, extinguish=true },
	[39635464] = { faction="Alliance", achievements={ { id=1024, index=5, qType="Seasonal", aQuest=11823, }, }, wardenKeeper=true },
					-- Correct. Same index
}

ns.points[ ns.map.terokkar ] = { -- Terokkar Forest
	[51944317] = { faction="Alliance", achievements={ { id=1030, index=6, qType="Seasonal", aQuest=11782, version=50000, },
					{ id=1030, index=5, qType="Seasonal", aQuest=11782, version=40000, versionUnder=50000, }, }, extinguish=true },
	[52014291] = { faction="Horde", achievements={ { id=1027, index=6, qType="Seasonal", aQuest=11858, version=50000, },
					{ id=1027, index=4, qType="Seasonal", aQuest=11858, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[54065553] = { faction="Alliance", achievements={ { id=1024, index=6, qType="Seasonal", aQuest=11825, version=50000, },
					{ id=1024, index=1, qType="Seasonal", aQuest=11825, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[54225555] = { faction="Horde", achievements={ { id=1033, index=6, qType="Seasonal", aQuest=11754, version=50000, },
					{ id=1033, index=3, qType="Seasonal", aQuest=11754, version=40000, versionUnder=50000, }, }, extinguish=true },
}

ns.points[ ns.map.zangarmarsh ] = { -- Zangarmarsh
	[35445161] = { faction="Horde", achievements={ { id=1027, index=7, qType="Seasonal", aQuest=11863, version=50000, },
					{ id=1027, index=2, qType="Seasonal", aQuest=11863, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[35565176] = { faction="Alliance", achievements={ { id=1030, index=7, qType="Seasonal", aQuest=11787, version=50000, },
					{ id=1030, index=3, qType="Seasonal", aQuest=11787, version=40000, versionUnder=50000, }, }, extinguish=true },
	[68635214] = { faction="Horde", achievements={ { id=1033, index=7, qType="Seasonal", aQuest=11758, version=50000, },
					{ id=1033, index=2, qType="Seasonal", aQuest=11758, version=40000, versionUnder=50000, }, }, extinguish=true },
	[69795195] = { faction="Alliance", achievements={ { id=1024, index=7, qType="Seasonal", aQuest=11829, version=50000, },
					{ id=1024, index=4, qType="Seasonal", aQuest=11829, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
}

ns.points[ ns.map.outland ] = { -- Outland
	[02507820] = ns.setExtKalEK,
	[02508250] = ns.setMain,
	[04708530] = ns.setLeftOvers,
	[05008100] = ns.setFlavour,
	[05207700] = ns.setExtOther,
	[07308400] = ns.setFlameOther,
	[07607980] = ns.setFlameKalEK,
}

--==================================================================================================================================
--
-- WRATH OF THE LICH KING / NORTHREND
--
--==================================================================================================================================

ns.points[ 114 ] = { -- Borean Tundra
	[51051179] = { faction="Alliance", achievements={ { id=6007, index=1, qType="Seasonal", aQuest=13441, version=50000, },
					{ id=6007, index=7, qType="Seasonal", aQuest=13441, version=40000, versionUnder=50000, }, }, extinguish=true },
	[51131154] = { faction="Horde", achievements={ { id=6009, index=2, qType="Seasonal", aQuest=13493, version=50000, },
					{ id=6009, index=7, qType="Seasonal", aQuest=13493, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[55101995] = { faction="Alliance", achievements={ { id=6008, index=8, qType="Seasonal", aQuest=13485, version=50000, },
					{ id=6008, index=7, qType="Seasonal", aQuest=13485, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[55222018] = { faction="Horde", achievements={ { id=6010, index=2, qType="Seasonal", aQuest=13440, version=50000, },
					{ id=6010, index=7, qType="Seasonal", aQuest=13440, version=40000, versionUnder=50000, }, }, extinguish=true },
}

ns.points[ 127 ] = { -- Crystalsong Forest
	[77647522] = { faction="Horde", achievements={ { id=6010, index=8, qType="Seasonal", aQuest=13447, version=50000, },
					{ id=6010, index=6, qType="Seasonal", aQuest=13447, version=40000, versionUnder=50000, }, }, extinguish=true },
	[78187495] = { faction="Alliance", achievements={ { id=6008, index=2, qType="Seasonal", aQuest=13491, }, }, wardenKeeper=true },
					-- Correct. Same index
	[79975321] = { faction="Horde", achievements={ { id=6009, index=8, qType="Seasonal", aQuest=13499, version=50000, },
					{ id=6009, index=1, qType="Seasonal", aQuest=13499, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[80345272] = { faction="Alliance", achievements={ { id=6007, index=6, qType="Seasonal", aQuest=13457, version=50000, },
					{ id=6007, index=1, qType="Seasonal", aQuest=13457, version=40000, versionUnder=50000, }, }, extinguish=true },
	[90571936] = { faction="Horde", achievements={ { id=6009, index=5, qType="Seasonal", aQuest=13498, version=50000, },
					{ id=6009, index=4, qType="Seasonal", aQuest=13498, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[90841996] = { faction="Alliance", achievements={ { id=6007, index=2, qType="Seasonal", aQuest=13455, }, }, extinguish=true },
					-- Correct. Same index
	[93622359] = { faction="Horde", achievements={ { id=6010, index=5, qType="Seasonal", aQuest=13446, version=50000, },
					{ id=6010, index=4, qType="Seasonal", aQuest=13446, version=40000, versionUnder=50000, }, }, extinguish=true },
	[93632285] = { faction="Alliance", achievements={ { id=6008, index=5, qType="Seasonal", aQuest=13490, version=50000, },
					{ id=6008, index=1, qType="Seasonal", aQuest=13490, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
}

ns.points[ 115 ] = { -- Dragonblight
	[38264847] = { faction="Horde", achievements={ { id=6009, index=1, qType="Seasonal", aQuest=13495, version=50000, },
					{ id=6009, index=2, qType="Seasonal", aQuest=13495, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[38484819] = { faction="Alliance", achievements={ { id=6007, index=8, qType="Seasonal", aQuest=13451, version=50000, },
					{ id=6007, index=5, qType="Seasonal", aQuest=13451, version=40000, versionUnder=50000, }, }, extinguish=true },
	[75064384] = { faction="Horde", achievements={ { id=6010, index=1, qType="Seasonal", aQuest=13443, }, }, extinguish=true },
					-- Correct. Same index
	[75294380] = { faction="Alliance", achievements={ { id=6008, index=1, qType="Seasonal", aQuest=13487, version=50000, },
					{ id=6008, index=6, qType="Seasonal", aQuest=13487, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[76621171] = { faction="Horde", achievements={ { id=6010, index=8, qType="Seasonal", aQuest=13447, version=50000, },
					{ id=6010, index=6, qType="Seasonal", aQuest=13447, version=40000, versionUnder=50000, }, }, extinguish=true },
	[76891158] = { faction="Alliance", achievements={ { id=6008, index=2, qType="Seasonal", aQuest=13491, }, }, wardenKeeper=true },
					-- Correct. Same index
	[77760103] = { faction="Horde", achievements={ { id=6009, index=8, qType="Seasonal", aQuest=13499, version=50000, },
					{ id=6009, index=1, qType="Seasonal", aQuest=13499, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[77940079] = { faction="Alliance", achievements={ { id=6007, index=6, qType="Seasonal", aQuest=13457, version=50000, },
					{ id=6007, index=1, qType="Seasonal", aQuest=13457, version=40000, versionUnder=50000, }, }, extinguish=true },
}

ns.points[ 116 ] = { -- Grizzly Hills
	[19136145] = { faction="Alliance", achievements={ { id=6007, index=4, qType="Seasonal", aQuest=13454, }, }, extinguish=true },
					-- Correct. Same index
	[19326116] = { faction="Horde", achievements={ { id=6009, index=7, qType="Seasonal", aQuest=13497, version=50000, },
					{ id=6009, index=6, qType="Seasonal", aQuest=13497, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[31480638] = { faction="Alliance", achievements={ { id=6007, index=3, qType="Seasonal", aQuest=13458, version=50000, },
					{ id=6007, index=8, qType="Seasonal", aQuest=13458, version=40000, versionUnder=50000, }, }, extinguish=true },
	[31540675] = { faction="Horde", achievements={ { id=6009, index=6, qType="Seasonal", aQuest=13500, version=50000, },
					{ id=6009, index=3, qType="Seasonal", aQuest=13500, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[33906045] = { faction="Alliance", achievements={ { id=6008, index=7, qType="Seasonal", aQuest=13489, version=50000, },
					{ id=6008, index=5, qType="Seasonal", aQuest=13489, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[34186061] = { faction="Horde", achievements={ { id=6010, index=7, qType="Seasonal", aQuest=13445, version=50000, },
					{ id=6010, index=2, qType="Seasonal", aQuest=13445, version=40000, versionUnder=50000, }, }, extinguish=true },
}

ns.points[ 117 ] = { -- Howling Fjord
	[48411334] = { faction="Alliance", achievements={ { id=6007, index=5, qType="Seasonal", aQuest=13453, version=50000, },
					{ id=6007, index=3, qType="Seasonal", aQuest=13453, version=40000, versionUnder=50000, }, }, extinguish=true },
	[48611315] = { faction="Horde", achievements={ { id=6009, index=3, qType="Seasonal", aQuest=13496, version=50000, },
					{ id=6009, index=5, qType="Seasonal", aQuest=13496, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[57771577] = { faction="Horde", achievements={ { id=6010, index=3, qType="Seasonal", aQuest=13444, version=50000, },
					{ id=6010, index=5, qType="Seasonal", aQuest=13444, version=40000, versionUnder=50000, }, }, extinguish=true },
	[57801612] = { faction="Alliance", achievements={ { id=6008, index=3, qType="Seasonal", aQuest=13488, version=50000, },
					{ id=6008, index=8, qType="Seasonal", aQuest=13488, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
}

ns.points[ 118 ] = { -- Icecrown
	[09179387] = { faction="Alliance", achievements={ { id=6007, index=7, qType="Seasonal", aQuest=13450, version=50000, },
					{ id=6007, index=6, qType="Seasonal", aQuest=13450, version=40000, versionUnder=50000, }, }, extinguish=true },
	[09319407] = { faction="Horde", achievements={ { id=6009, index=4, qType="Seasonal", aQuest=13494, version=50000, },
					{ id=6009, index=8, qType="Seasonal", aQuest=13494, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[09589719] = { faction="Horde", achievements={ { id=6010, index=4, qType="Seasonal", aQuest=13442, version=50000, },
					{ id=6010, index=8, qType="Seasonal", aQuest=13442, version=40000, versionUnder=50000, }, }, extinguish=true },
	[09739705] = { faction="Alliance", achievements={ { id=6008, index=4, qType="Seasonal", aQuest=13486, version=50000, },
					{ id=6008, index=4, qType="Seasonal", aQuest=13486, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[98519305] = { faction="Horde", achievements={ { id=6009, index=8, qType="Seasonal", aQuest=13499, version=50000, },
					{ id=6009, index=1, qType="Seasonal", aQuest=13499, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[98679283] = { faction="Alliance", achievements={ { id=6007, index=6, qType="Seasonal", aQuest=13457, version=50000, },
					{ id=6007, index=1, qType="Seasonal", aQuest=13457, version=40000, versionUnder=50000, }, }, extinguish=true },
}

ns.points[ 119 ] = { -- Sholazar Basin
	[47306147] = { faction="Alliance", achievements={ { id=6007, index=7, qType="Seasonal", aQuest=13450, version=50000, },
					{ id=6007, index=6, qType="Seasonal", aQuest=13450, version=40000, versionUnder=50000, }, }, extinguish=true },
	[47506177] = { faction="Horde", achievements={ { id=6009, index=4, qType="Seasonal", aQuest=13494, version=50000, },
					{ id=6009, index=8, qType="Seasonal", aQuest=13494, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[47886626] = { faction="Horde", achievements={ { id=6010, index=4, qType="Seasonal", aQuest=13442, version=50000, },
					{ id=6010, index=8, qType="Seasonal", aQuest=13442, version=40000, versionUnder=50000, }, }, extinguish=true },
	[48116605] = { faction="Alliance", achievements={ { id=6008, index=4, qType="Seasonal", aQuest=13486, }, }, wardenKeeper=true },
					-- Correct. Same index
}

ns.points[ 120 ] = { -- The Storm Peaks
	[36219831] = { faction="Horde", achievements={ { id=6009, index=8, qType="Seasonal", aQuest=13499, version=50000, },
					{ id=6009, index=1, qType="Seasonal", aQuest=13499, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[36359812] = { faction="Alliance", achievements={ { id=6007, index=6, qType="Seasonal", aQuest=13457, version=50000, },
					{ id=6007, index=1, qType="Seasonal", aQuest=13457, version=40000, versionUnder=50000, }, }, extinguish=true },
	[40278535] = { faction="Horde", achievements={ { id=6009, index=5, qType="Seasonal", aQuest=13498, version=50000, },
					{ id=6009, index=4, qType="Seasonal", aQuest=13498, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[40378558] = { faction="Alliance", achievements={ { id=6007, index=2, qType="Seasonal", aQuest=13455, }, }, extinguish=true },
					-- Correct. Same index
	[41448669] = { faction="Alliance", achievements={ { id=6008, index=5, qType="Seasonal", aQuest=13490, version=50000, },
					{ id=6008, index=1, qType="Seasonal", aQuest=13490, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[41448697] = { faction="Horde", achievements={ { id=6010, index=5, qType="Seasonal", aQuest=13446, version=50000, },
					{ id=6010, index=4, qType="Seasonal", aQuest=13446, version=40000, versionUnder=50000, }, }, extinguish=true },
	[62689638] = { faction="Alliance", achievements={ { id=6008, index=6, qType="Seasonal", aQuest=13492, version=50000, },
					{ id=6008, index=3, qType="Seasonal", aQuest=13492, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[62779618] = { faction="Horde", achievements={ { id=6010, index=6, qType="Seasonal", aQuest=13449, version=50000, },
					{ id=6010, index=3, qType="Seasonal", aQuest=13449, version=40000, versionUnder=50000, }, }, extinguish=true },
}

ns.points[ 123 ] = { -- Wintergrasp
	[95739853] = { faction="Horde", achievements={ { id=6009, index=1, qType="Seasonal", aQuest=13495, version=50000, },
					{ id=6009, index=2, qType="Seasonal", aQuest=13495, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[96159800] = { faction="Alliance", achievements={ { id=6007, index=8, qType="Seasonal", aQuest=13451, version=50000, },
					{ id=6007, index=5, qType="Seasonal", aQuest=13451, version=40000, versionUnder=50000, }, }, extinguish=true },
}

ns.points[ 121 ] = { -- Zul'Drak
	[01417604] = { faction="Horde", achievements={ { id=6010, index=8, qType="Seasonal", aQuest=13447, version=50000, },
					{ id=6010, index=6, qType="Seasonal", aQuest=13447, version=40000, versionUnder=50000, }, }, extinguish=true },
	[01707590] = { faction="Alliance", achievements={ { id=6008, index=2, qType="Seasonal", aQuest=13491, }, }, wardenKeeper=true },
					-- Correct. Same index
	[02686405] = { faction="Horde", achievements={ { id=6009, index=8, qType="Seasonal", aQuest=13499, version=50000, },
					{ id=6009, index=1, qType="Seasonal", aQuest=13499, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[02886378] = { faction="Alliance", achievements={ { id=6007, index=6, qType="Seasonal", aQuest=13457, version=50000, },
					{ id=6007, index=1, qType="Seasonal", aQuest=13457, version=40000, versionUnder=50000, }, }, extinguish=true },
	[08464560] = { faction="Horde", achievements={ { id=6009, index=5, qType="Seasonal", aQuest=13498, version=50000, },
					{ id=6009, index=4, qType="Seasonal", aQuest=13498, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[08614592] = { faction="Alliance", achievements={ { id=6007, index=2, qType="Seasonal", aQuest=13455, }, }, extinguish=true },
					-- Correct. Same index
	[10124790] = { faction="Horde", achievements={ { id=6010, index=5, qType="Seasonal", aQuest=13446, version=50000, },
					{ id=6010, index=4, qType="Seasonal", aQuest=13446, version=40000, versionUnder=50000, }, }, extinguish=true },
	[10134750] = { faction="Alliance", achievements={ { id=6008, index=5, qType="Seasonal", aQuest=13490, version=50000, },
					{ id=6008, index=1, qType="Seasonal", aQuest=13490, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[40386130] = { faction="Alliance", achievements={ { id=6008, index=6, qType="Seasonal", aQuest=13492, version=50000, },
					{ id=6008, index=3, qType="Seasonal", aQuest=13492, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[40516101] = { faction="Horde", achievements={ { id=6010, index=6, qType="Seasonal", aQuest=13449, version=50000, },
					{ id=6010, index=3, qType="Seasonal", aQuest=13449, version=40000, versionUnder=50000, }, }, extinguish=true },
	[43327135] = { faction="Alliance", achievements={ { id=6007, index=3, qType="Seasonal", aQuest=13458, version=50000, },
					{ id=6007, index=8, qType="Seasonal", aQuest=13458, version=40000, versionUnder=50000, }, }, extinguish=true },
	[43387174] = { faction="Horde", achievements={ { id=6009, index=6, qType="Seasonal", aQuest=13500, version=50000, },
					{ id=6009, index=3, qType="Seasonal", aQuest=13500, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
}

ns.points[ 113 ] = { -- Northrend
	[02507820] = ns.setExtKalEK,
	[02508250] = ns.setMain,
	[04708530] = ns.setLeftOvers,
	[05008100] = ns.setFlavour,
	[05207700] = ns.setExtOther,
	[07308400] = ns.setFlameOther,
	[07607980] = ns.setFlameKalEK,
}

--==================================================================================================================================
--
-- CATACLYSM
--
--==================================================================================================================================

ns.points[ 204 ] = { -- Abyssal Depths
	[96834446] = { achievements={ { faction="Alliance", id=6011, index=4, qType="Seasonal", aQuest=29031, version=50000, },
					{ faction="Alliance", id=6011, index=2, qType="Seasonal", aQuest=29031, version=40000, versionUnder=50000, },
					{ faction="Horde", id=6012, index=1, qType="Seasonal", aQuest=29031, version=50000, },
					{ faction="Horde", id=6012, index=3, qType="Seasonal", aQuest=29031, version=40000, versionUnder=50000, }, },
					wardenKeeper=true },
}

ns.points[ 207 ] = { -- Deepholm
	[49405132] = { achievements={ { faction="Alliance", id=6011, index=2, qType="Seasonal", aQuest=29036, version=50000, },
					{ faction="Alliance", id=6011, index=5, qType="Seasonal", aQuest=29036, version=40000, versionUnder=50000, },
					{ faction="Horde", id=6012, index=4, qType="Seasonal", aQuest=29036, version=50000, },
					{ faction="Horde", id=6012, index=1, qType="Seasonal", aQuest=29036, version=40000, versionUnder=50000, }, },
					wardenKeeper=true },
}

ns.points[ 198 ] = { -- Mount Hyjal
	[62832271] = { achievements={ { faction="Alliance", id=6011, index=5, qType="Seasonal", aQuest=29030, version=50000, },
					{ faction="Alliance", id=6011, index=3, qType="Seasonal", aQuest=29030, version=40000, versionUnder=50000, },
					{ faction="Horde", id=6012, index=3, qType="Seasonal", aQuest=29030, version=50000, },
					{ faction="Horde", id=6012, index=5, qType="Seasonal", aQuest=29030, version=40000, versionUnder=50000, }, },
					wardenKeeper=true },
}

ns.points[ 205 ] = { -- Shimmering Expanse in Vashj'ir
	[49354199] = { achievements={ { faction="Alliance", id=6011, index=4, qType="Seasonal", aQuest=29031, version=50000, },
					{ faction="Alliance", id=6011, index=2, qType="Seasonal", aQuest=29031, version=40000, versionUnder=50000, },
					{ faction="Horde", id=6012, index=1, qType="Seasonal", aQuest=29031, version=50000, },
					{ faction="Horde", id=6012, index=3, qType="Seasonal", aQuest=29031, version=40000, versionUnder=50000, }, },
					wardenKeeper=true },
}

ns.points[ 241 ] = { -- Twilight Highlands
	[47142830] = { faction="Horde", achievements={ { id=6014, index=1, qType="Seasonal", aQuest=28943, version=50000, },
					{ id=6014, index=2, qType="Seasonal", aQuest=28943, version=40000, versionUnder=50000, }, }, extinguish=true },
	[47262896] = { faction="Alliance", achievements={ { id=6011, index=3, qType="Seasonal", aQuest=28945, version=50000, },
					{ id=6011, index=4, qType="Seasonal", aQuest=28945, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[53124618] = { faction="Horde", achievements={ { id=6012, index=2, qType="Seasonal", aQuest=28946, }, }, wardenKeeper=true },
					-- Correct. Same index
	[53274636] = { faction="Alliance", achievements={ { id=6013, index=1, qType="Seasonal", aQuest=28944, }, }, extinguish=true },
					-- Correct. Same index
}

ns.points[ 249 ] = { -- Uldum
	[52993457] = { faction="Alliance", achievements={ { id=6013, index=2, qType="Seasonal", aQuest=28948, }, }, extinguish=true },
					-- Correct. Same index
	[53153454] = { faction="Horde", achievements={ { id=6012, index=5, qType="Seasonal", aQuest=28949, version=50000, },
					{ id=6012, index=4, qType="Seasonal", aQuest=28949, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[53433188] = { faction="Horde", achievements={ { id=6014, index=2, qType="Seasonal", aQuest=28947, version=50000, },
					{ id=6014, index=1, qType="Seasonal", aQuest=28947, version=40000, versionUnder=50000, }, }, extinguish=true },
	[53603185] = { faction="Alliance", achievements={ { id=6011, index=1, qType="Seasonal", aQuest=28950, }, }, wardenKeeper=true },
					-- Correct. Same index
}

ns.points[ 1527 ] = { -- Uldum
	[52993457] = { faction="Alliance", achievements={ { id=6013, index=2, qType="Seasonal", aQuest=28948, }, }, extinguish=true },
					-- Correct. Same index
	[53153454] = { faction="Horde", achievements={ { id=6012, index=5, qType="Seasonal", aQuest=28949, version=50000, },
					{ id=6012, index=4, qType="Seasonal", aQuest=28949, version=40000, versionUnder=50000, }, }, wardenKeeper=true },
	[53433188] = { faction="Horde", achievements={ { id=6014, index=2, qType="Seasonal", aQuest=28947, version=50000, },
					{ id=6014, index=1, qType="Seasonal", aQuest=28947, version=40000, versionUnder=50000, }, }, extinguish=true },
	[53603185] = { faction="Alliance", achievements={ { id=6011, index=1, qType="Seasonal", aQuest=28950, }, }, wardenKeeper=true },
					-- Correct. Same index
}

ns.points[ 203 ] = { -- Vashj'ir
	[64315167] = { achievements={ { faction="Alliance", id=6011, index=4, qType="Seasonal", aQuest=29031, version=50000, },
					{ faction="Alliance", id=6011, index=2, qType="Seasonal", aQuest=29031, version=40000, versionUnder=50000, },
					{ faction="Horde", id=6012, index=1, qType="Seasonal", aQuest=29031, version=50000, },
					{ faction="Horde", id=6012, index=3, qType="Seasonal", aQuest=29031, version=40000, versionUnder=50000, }, },
					wardenKeeper=true },
}

--==================================================================================================================================
--
-- MISTS OF PANDARIA
--
--==================================================================================================================================

ns.points[ 422 ] = { -- Dread Wastes
	[56076957] = { achievements={ { faction="Alliance", id=8045, index=1, qType="Seasonal", aQuest=32497, },
					{ faction="Horde", id=8044, index=1, qType="Seasonal", aQuest=32497, }, }, wardenKeeper=true },
}

ns.points[ 418 ] = { -- Krasarang Wilds
	[73990949] = { achievements={ { faction="Alliance", id=8045, index=3, qType="Seasonal", aQuest=32499, },
					{ faction="Horde", id=8044, index=3, qType="Seasonal", aQuest=32499, }, }, wardenKeeper=true },
}

ns.points[ 379 ] = { -- Kun-Lai Summit
	[71159086] = { achievements={ { faction="Alliance", id=8045, index=4, qType="Seasonal", aQuest=32500, },
					{ faction="Horde", id=8044, index=4, qType="Seasonal", aQuest=32500, }, }, wardenKeeper=true },
}

ns.points[ 371 ] = { -- The Jade Forest
	[47184718] = { achievements={ { faction="Alliance", id=8045, index=2, qType="Seasonal", aQuest=32498, },
					{ faction="Horde", id=8044, index=2, qType="Seasonal", aQuest=32498, }, }, wardenKeeper=true },
}

ns.points[ 390 ] = { -- Vale of Eternal Blossoms
	[77763397] = { faction="Horde", achievements={ { id=8044, index=6, qType="Seasonal", aQuest=32509, }, }, wardenKeeper=true },
	[77793366] = { faction="Alliance", achievements={ { id=8042, qType="Seasonal", aQuest=32496, }, }, extinguish=true },
	[79683727] = { faction="Alliance", achievements={ { id=8045, index=6, qType="Seasonal", aQuest=32510, }, }, wardenKeeper=true },
	[79903729] = { faction="Horde", achievements={ { id=8043, qType="Seasonal", aQuest=32503, }, }, extinguish=true },
}

ns.points[ 376 ] = { -- Valley of the Four Winds
	[51815132] = { achievements={ { faction="Alliance", id=8045, index=7, qType="Seasonal", aQuest=32502, },
					{ faction="Horde", id=8044, index=7, qType="Seasonal", aQuest=32502, }, }, wardenKeeper=true },
}

ns.points[ 388 ] = { -- Townlong Steppes
	[71525629] = { achievements={ { faction="Alliance", id=8045, index=5, qType="Seasonal", aQuest=32501, },
					{ faction="Horde", id=8044, index=5, qType="Seasonal", aQuest=32501, }, }, wardenKeeper=true },
}

ns.points[ 424 ] = { -- Pandaria
	[02507820] = ns.setExtKalEK,
	[02508250] = ns.setMain,
	[04708530] = ns.setLeftOvers,
	[05008100] = ns.setFlavour,
	[05207700] = ns.setExtOther,
	[07308400] = ns.setFlameOther,
	[07607980] = ns.setFlameKalEK,
}

--==================================================================================================================================
--
-- WARLORDS OF DRAENOR / GARRISON
--
--==================================================================================================================================

ns.points[ 525 ] = { -- Frostfire Ridge
	[72616508] = { faction="Horde", achievements={ { id=11284, index=5, qType="Seasonal", aQuest=44580, }, }, wardenKeeper=true },
	[72706521] = { faction="Alliance", achievements={ { id=11276, qType="Seasonal", aQuest=44583, }, }, extinguish=true },
}

ns.points[ 543 ] = { -- Gorgrond
	[43929379] = { achievements={ { faction="Alliance", id=11283, index=4, qType="Seasonal", aQuest=44573, },
					{ faction="Horde", id=11284, index=4, qType="Seasonal", aQuest=44573, }, }, wardenKeeper=true },
}

ns.points[ 550 ] = { -- Nagrand
	[80554770] = { achievements={ { faction="Alliance", id=11283, index=3, qType="Seasonal", aQuest=44572, },
					{ faction="Horde", id=11284, index=3, qType="Seasonal", aQuest=44572, }, }, wardenKeeper=true },
}

ns.points[ 539 ] = { -- Shadowmoon Valley
	[42633599] = { faction="Alliance", achievements={ { id=11283, index=5, qType="Seasonal", aQuest=44579, }, }, wardenKeeper=true },
	[42723589] = { faction="Horde", achievements={ { id=11277, qType="Seasonal", aQuest=44582, }, }, extinguish=true },
}

ns.points[ 542 ] = { -- Spires of Arak
	[48014472] = { achievements={ { faction="Alliance", id=11283, index=1, qType="Seasonal", aQuest=44570, },
					{ faction="Horde", id=11284, index=1, qType="Seasonal", aQuest=44570, }, }, wardenKeeper=true },
}

ns.points[ 535 ] = { -- Talador
	[43467181] = { achievements={ { faction="Alliance", id=11283, index=2, qType="Seasonal", aQuest=44571, },
					{ faction="Horde", id=11284, index=2, qType="Seasonal", aQuest=44571, }, }, wardenKeeper=true },
}

ns.points[ 572 ] = { -- Draenor
	[02507820] = ns.setExtKalEK,
	[02508250] = ns.setMain,
	[04708530] = ns.setLeftOvers,
	[05008100] = ns.setFlavour,
	[05207700] = ns.setExtOther,
	[07308400] = ns.setFlameOther,
	[07607980] = ns.setFlameKalEK,
}

--==================================================================================================================================
--
-- LEGION / BROKEN ISLES
--
--==================================================================================================================================

ns.points[ 630 ] = { -- Azsuna
	[48262969] = { achievements={ { faction="Alliance", id=11280, index=1, qType="Seasonal", aQuest=44574, },
					{ faction="Horde", id=11282, index=1, qType="Seasonal", aQuest=44574, }, }, wardenKeeper=true },
}

ns.points[ 650 ] = { -- Highmountain
	[55528445] = { achievements={ { faction="Alliance", id=11280, index=3, qType="Seasonal", aQuest=44576, },
					{ faction="Horde", id=11282, index=3, qType="Seasonal", aQuest=44576, }, }, wardenKeeper=true },
}

ns.points[ 634 ] = { -- Stormheim
	[32504213] = { achievements={ { faction="Alliance", id=11280, index=4, qType="Seasonal", aQuest=44577, },
					{ faction="Horde", id=11282, index=4, qType="Seasonal", aQuest=44577, }, }, wardenKeeper=true },
}

ns.points[ 680 ] = { -- Suramar
	[22905827] = { faction="Horde", achievements={ { id=11279, qType="Seasonal", aQuest=44624, }, }, extinguish=true },
	[23025835] = { faction="Alliance", achievements={ { id=11280, index=5, qType="Seasonal", aQuest=44613, }, }, wardenKeeper=true },
	[30304528] = { faction="Alliance", achievements={ { id=11278, qType="Seasonal", aQuest=44627, }, }, extinguish=true },
	[30464538] = { faction="Horde", achievements={ { id=11282, index=5, qType="Seasonal", aQuest=44614, }, }, wardenKeeper=true },
}

ns.points[ 641 ] = { -- Val'sharah
	[44885793] = { achievements={ { faction="Alliance", id=11280, index=2, qType="Seasonal", aQuest=44575, },
					{ faction="Horde", id=11282, index=2, qType="Seasonal", aQuest=44575, }, }, wardenKeeper=true },
}

ns.points[ 619 ] = { -- Broken Isles
	[02507820] = ns.setExtKalEK,
	[02508250] = ns.setMain,
	[04708530] = ns.setLeftOvers,
	[05008100] = ns.setFlavour,
	[05207700] = ns.setExtOther,
	[07308400] = ns.setFlameOther,
	[07607980] = ns.setFlameKalEK,
}

--==================================================================================================================================
--
-- BATTLE FOR AZEROTH / KUL TIRAS & ZANDALAR
--
--==================================================================================================================================

ns.points[ 1165 ] = { -- Dazar'alor in Zuldazar
	[35985713] = { faction="Horde", achievements={ { id=13340, index=1, qType="Seasonal", aQuest=54745, }, }, wardenKeeper=true },
	[36175692] = { faction="Alliance", achievements={ { id=13343, index=1, qType="Seasonal", aQuest=54744, }, }, extinguish=true },
}

ns.points[ 896 ] = { -- Drustvar
	[40164743] = { faction="Horde", achievements={ { id=13342, index=3, qType="Seasonal", aQuest=54742, }, }, extinguish=true },
	[40224760] = { faction="Alliance", achievements={ { id=13341, index=3, qType="Seasonal", aQuest=54743, }, }, wardenKeeper=true },
}

ns.points[ 863 ] = { -- Nazmir
	[40037430] = { faction="Horde", achievements={ { id=13340, index=2, qType="Seasonal", aQuest=54747, }, }, wardenKeeper=true },
	[40137416] = { faction="Alliance", achievements={ { id=13343, index=2, qType="Seasonal", aQuest=54746, }, }, extinguish=true },
}

ns.points[ 942 ] = { -- Stormsong Valley
	[35855133] = { faction="Alliance", achievements={ { id=13341, index=2, qType="Seasonal", aQuest=54741, }, }, wardenKeeper=true },
	[35935148] = { faction="Horde", achievements={ { id=13342, index=2, qType="Seasonal", aQuest=54739, }, }, extinguish=true },
}

ns.points[ 895 ] = { -- Tiragarde Sound
	[76334974] = { faction="Horde", achievements={ { id=13342, index=1, qType="Seasonal", aQuest=54736, }, }, extinguish=true },
	[76354988] = { faction="Alliance", achievements={ { id=13341, index=1, qType="Seasonal", aQuest=54737, }, }, wardenKeeper=true },
}

ns.points[ 864 ] = { -- Vol'dun
	[56014776] = { faction="Horde", achievements={ { id=13340, index=3, qType="Seasonal", aQuest=54750, }, }, wardenKeeper=true },
	[55954764] = { faction="Alliance", achievements={ { id=13343, index=3, qType="Seasonal", aQuest=54749, }, }, extinguish=true },
}

ns.points[ 862 ] = { -- Zuldazar
	[53314811] = { faction="Horde", achievements={ { id=13340, index=1, qType="Seasonal", aQuest=54745, }, }, wardenKeeper=true },
	[53374804] = { faction="Alliance", achievements={ { id=13343, index=1, qType="Seasonal", aQuest=54744, }, }, extinguish=true },
}

ns.points[ 875 ] = { -- Zandalar
	[02507820] = ns.setExtKalEK,
	[02508250] = ns.setMain,
	[04708530] = ns.setLeftOvers,
	[05008100] = ns.setFlavour,
	[05207700] = ns.setExtOther,
	[07308400] = ns.setFlameOther,
	[07607980] = ns.setFlameKalEK,
}

ns.points[ 876 ] = { -- Kul Tiras
	[02507820] = ns.setExtKalEK,
	[02508250] = ns.setMain,
	[04708530] = ns.setLeftOvers,
	[05008100] = ns.setFlavour,
	[05207700] = ns.setExtOther,
	[07308400] = ns.setFlameOther,
	[07607980] = ns.setFlameKalEK,
}

--==================================================================================================================================
--
-- SHADOWLANDS
--
--==================================================================================================================================

--==================================================================================================================================
--
-- DRAGONFLIGHT / DRAGON ISLES
--
--==================================================================================================================================

ns.points[ 2023 ] = { -- Ohn'ahran Plains
	[63853501] = { achievements={ { faction="Alliance", id=17737, index=2, qType="Seasonal", aQuest=75617, },
					{ faction="Horde", id=17738, index=2, qType="Seasonal", aQuest=75617, }, }, wardenKeeper=true },
					-- Bonfire at 63923490
}

ns.points[ 2025 ] = { -- Thaldraszus
	[40436166] = { achievements={ { faction="Alliance", id=17737, index=4, qType="Seasonal", aQuest=75645, },
					{ faction="Horde", id=17738, index=4, qType="Seasonal", aQuest=75645, }, }, wardenKeeper=true },
					-- Bonfire at 40506169
}

ns.points[ 2024 ] = { -- The Azure Span
	[12214757] = { achievements={ { faction="Alliance", id=17737, index=3, qType="Seasonal", aQuest=75640, },
					{ faction="Horde", id=17738, index=3, qType="Seasonal", aQuest=75640, }, }, wardenKeeper=true },
					-- Bonfire at 12224749
}

ns.points[ 2022 ] = { -- The Waking Shores
	[45988288] = { achievements={ { faction="Alliance", id=17737, index=1, qType="Seasonal", aQuest=75398, },
					{ faction="Horde", id=17738, index=1, qType="Seasonal", aQuest=75398, }, }, wardenKeeper=true },
					-- Bonfire at 45928279
}


ns.points[ 2151 ] = { -- The Forbidden Reach
	[34986090] = { achievements={ { faction="Alliance", id=17737, index=5, qType="Seasonal", aQuest=75647, },
					{ faction="Horde", id=17738, index=5, qType="Seasonal", aQuest=75647, }, }, wardenKeeper=true },
					-- Bonfire at 34996105
}

ns.points[ 2112 ] = { -- Valdrakken
	[53396232] = { achievements={ { faction="Alliance", id=17737, index=4, qType="Seasonal", aQuest=75645, },
					{ faction="Horde", id=17738, index=4, qType="Seasonal", aQuest=75645, }, }, wardenKeeper=true },
					-- Bonfire at 53906252
}

ns.points[ 2133 ] = { -- Zaralek Cavern -- MUST use my DTL. HN/HBD is bugged
	[55175542] = { achievements={ { faction="Alliance", id=17737, index=6, qType="Seasonal", aQuest=75650, },
					{ faction="Horde", id=17738, index=6, qType="Seasonal", aQuest=75650, }, }, wardenKeeper=true },
					-- Bonfire at 55235549
}

ns.points[ 2274 ] = { -- Dragon Isles
	[02507820] = ns.setExtKalEK,
	[02508250] = ns.setMain,
	[04708530] = ns.setLeftOvers,
	[05008100] = ns.setFlavour,
	[05207700] = ns.setExtOther,
	[07308400] = ns.setFlameOther,
	[07607980] = ns.setFlameKalEK,
}

--==================================================================================================================================
--
-- THE WAR WITHIN / KHAZ ALGAR
--
--==================================================================================================================================

ns.points[ 2255 ] = { -- Azj'Kahet
	[55494337] = { noAzeroth=true, achievements={ { id=41632, index=1, qType="Seasonal", aQuest=87356, faction="Alliance", },
					{ id=41631, index=1, qType="Seasonal", aQuest=87356, faction="Horde", }, }, wardenKeeper=true },
}

ns.points[ 2339 ] = { -- Dornogal
	[48525151] = { achievements={ { id=41632, index=3, qType="Seasonal", aQuest=87342, faction="Alliance", },
					{ id=41631, index=3, qType="Seasonal", aQuest=87342, faction="Horde", }, }, wardenKeeper=true, tip="Dornogal" },
}

ns.points[ 2215 ] = { -- Hallowfall
	[42485160] = { noAzeroth=true, achievements={ { id=41632, index=2, qType="Seasonal", aQuest=87355, faction="Alliance", },
					{ id=41631, index=2, qType="Seasonal", aQuest=87355, faction="Horde", }, }, wardenKeeper=true },
}

ns.points[ 2248 ] = { -- Isle of Dorn
	[47553971] = { noAzeroth=true, achievements={ { id=41632, index=3, qType="Seasonal", aQuest=87342, faction="Alliance", },
					{ id=41631, index=3, qType="Seasonal", aQuest=87342, faction="Horde", }, }, wardenKeeper=true, tip="Dornogal" },
}

ns.points[ 2214 ] = { -- The Ringing Deeps
	[43663261] = { noAzeroth=true, achievements={ { id=41632, index=4, qType="Seasonal", aQuest=87357, faction="Alliance", },
					{ id=41631, index=4, qType="Seasonal", aQuest=87357, faction="Horde", }, }, wardenKeeper=true },
}

ns.points[ 2274 ] = { -- Khaz Algar
	[02507820] = ns.setExtKalEK,
	[02508250] = ns.setMain,
	[04708530] = ns.setLeftOvers,
	[05008100] = ns.setFlavour,
	[05207700] = ns.setExtOther,
	[07308400] = ns.setFlameOther,
	[07607980] = ns.setFlameKalEK,
}

--==================================================================================================================================
--
-- WORLD / OTHER
--
--==================================================================================================================================

--==================================================================================================================================
--
-- TEXTURES
--
-- These textures are all repurposed and as such have non-uniform sizing. In order to homogenise the sizes. I should also allow for
-- non-uniform origin placement as well as adjust the x,y offsets. First 10 are in Common.lua
--==================================================================================================================================

ns.textures[21] = "Interface\\AddOns\\HandyNotes_MidsummerFireFestival\\SymbolHighBlue"
ns.textures[22] = "Interface\\AddOns\\HandyNotes_MidsummerFireFestival\\SymbolHighCyan"
ns.textures[23] = "Interface\\AddOns\\HandyNotes_MidsummerFireFestival\\SymbolHighGold"
ns.textures[24] = "Interface\\AddOns\\HandyNotes_MidsummerFireFestival\\SymbolHighGreen"
ns.textures[25] = "Interface\\AddOns\\HandyNotes_MidsummerFireFestival\\SymbolHighLightGreen"
ns.textures[31] = "Interface\\AddOns\\HandyNotes_MidsummerFireFestival\\SymbolLowBlue"
ns.textures[32] = "Interface\\AddOns\\HandyNotes_MidsummerFireFestival\\SymbolLowGreen"
ns.textures[33] = "Interface\\AddOns\\HandyNotes_MidsummerFireFestival\\SymbolLowMagenta"
ns.textures[34] = "Interface\\AddOns\\HandyNotes_MidsummerFireFestival\\SymbolLowOrange"
ns.textures[41] = "Interface\\AddOns\\HandyNotes_MidsummerFireFestival\\FireArcane"
ns.textures[42] = "Interface\\AddOns\\HandyNotes_MidsummerFireFestival\\FireBlood"
ns.textures[43] = "Interface\\AddOns\\HandyNotes_MidsummerFireFestival\\FireFel"
ns.textures[44] = "Interface\\AddOns\\HandyNotes_MidsummerFireFestival\\FireFrost"
ns.textures[45] = "Interface\\AddOns\\HandyNotes_MidsummerFireFestival\\FireNature"
ns.textures[51] = "Interface\\AddOns\\HandyNotes_MidsummerFireFestival\\FireFlower"
ns.textures[52] = "Interface\\AddOns\\HandyNotes_MidsummerFireFestival\\FirePotion"
ns.scaling[21] = 0.432
ns.scaling[22] = 0.432
ns.scaling[23] = 0.432
ns.scaling[24] = 0.432
ns.scaling[25] = 0.432
ns.scaling[31] = 0.432
ns.scaling[32] = 0.432
ns.scaling[33] = 0.432
ns.scaling[34] = 0.432
ns.scaling[41] = 0.432
ns.scaling[42] = 0.432
ns.scaling[43] = 0.432
ns.scaling[44] = 0.432
ns.scaling[45] = 0.432
ns.scaling[51] = 0.432
ns.scaling[52] = 0.432
