local _, ns = ...
ns.points = {}
ns.textures = {}
ns.scaling = {}

-- Achievements:
-- Elders of the Dungeons		910		Alliance/Horde
-- Elders of Kalimdor			911		Alliance/Horde
-- Elders of Eastern Kingdoms	912		Alliance/Horde
-- Elders of The Horde			914		Alliance/Horde
-- Elders of The Alliance		915		Alliance/Horde
-- Elders of Northrend			1396	Alliance/Horde
-- Elders of Cataclysm			6006	Alliance/Horde
-- Elders of the Dragon Isles	17321	Alliance/Horde

ns.elderBluewolf = "He is through here. If your faction is not in control then see my Easy Glitch Guide!\n\nIf your faction is in "
			.."control then the Defender's Portal will work"
ns.elderNurgenExit = "After you exit the dungeon, use the path here and very soon after you may mount"
ns.taraezorPromo = "\n\nThanks for using my AddOn. Hope I helped! :)\n\nI'm at X, BlueSky and Ko-fi as @Taraezor. There's also my "
			.."project page at curseforge where you might find more useful AddOns!"

ns.metaGuide = "For zone Elders look for an icon on the zone map. The faction/dungeon Elder pins are in the event cluster on every "
			.."continent map. Cataclysm is near the Maelstrom on the World Map. These pins will breakdown your progress"
ns.setFlavour = { history=true, name="Lunar Festival", noCoords=true, noContinent=true, alwaysShow=true,
					tip="The Lunar Festival is a time of celebration for the peoples of Azeroth. At the beginning of each year, "
						.."elders of generations past manifest around the world to impart their wisdom upon all who listen. Should "
						.."you encounter these venerable spirits in your travels and take the time to heed their words, they may "
						.."even pass along tokens of their gratitude - Coins of Ancestry, the lessons of a past age in physical "
						.."form.\n\nThe Cenarion Circle has good cause to celebrate, for the Lunar Festival marks the return of "
						.."many Ancients that fell in battles past: Goldrinn, Malorne, Aviana, and Cenarius himself. But this "
						.."celebration is darkened by the eternal torment of one of their own - Omen, a wolf Ancient blessed by "
						.."the moon goddess Elune, has risen from the depths of Moonglade’s lake.\n\nThough Omen was once as noble "
						.."and proud as any Ancient, he was driven mad by the Burning Legion’s tainted magics during the War of "
						.."the Ancients. Turning against his allies, he raged across Azeroth, leaving death and terror in his "
						.."wake. Omen was finally defeated in Moonglade, and he now sleeps among the silt of Lake Elune'ara. But "
						.."each year, at the beginning of the festival, he stirs, forever cursed to return in his maddened state, "
						.."growing further in power each new year.\n\n((From Blizzard's offical webpage c.2025))", }
ns.setHonorElders = { honor=true, noCoords=true, noContinent=true, alwaysShow=true, 
				achievements={ { id=913, showAllCriteria=true, }, }, guide=ns.metaGuide, }
ns.setMetaFaction = { elderFaction=true, noCoords=true, noContinent=true, alwaysShow=true, 
				achievements={ { id=914, showAllCriteria=true, }, { id=915, showAllCriteria=true, },
					{ id=910, showAllCriteria=true, }, }, guide=ns.metaGuide, }
ns.set50Coins = { coins=true, noCoords=true, noContinent=true, alwaysShow=true, 
				achievements={ { id=605, }, { id=606, }, { id=607, }, { id=608, }, { id=609, }, }, }
ns.setPyro = { elderDungeon=true, noCoords=true, noContinent=true, alwaysShow=true, 
				achievements={ { id=1552, showAllCriteria=true, }, { id=1281, showAllCriteria=true, }, }, }
if ( ns.version < 60000 ) then
	ns.setElune = { seasonalQuest=true, noCoords=true, noContinent=true, alwaysShow=true, achievements={ { id=937, }, },
				quests={ { id=8868, name="Elune's Blessing", qType="Seasonal", }, }, }
	ns.setNewZones = { elder=true, noCoords=true, noContinent=true, alwaysShow=true, achievements={ { id=626, }, }, }
else
	ns.setElune = { seasonalQuest=true, noCoords=true, noContinent=true, alwaysShow=true, achievements={ { id=937, }, { id=626, }, },
				quests={ { id=8868, name="Elune's Blessing", qType="Seasonal", }, }, }
	ns.setNewZones = { elder=true, noCoords=true, noContinent=true, alwaysShow=true, guide=ns.metaGuide,
				achievements={ { id=41130, showAllCriteria=true, }, { id=17321, showAllCriteria=true, }, }, }
end

ns.setFFortitude = { crown=true, tip="Flower of Fortitude",
					quests={ { id=56903, index=1, name="Crown of Courage", version=80205, qType="One Time", }, }, }
ns.setFSincerity = { crown=true, tip="Flower of Sincerity",
					quests={ { id=56903, index=2, name="Crown of Courage", version=80205, qType="One Time", }, }, }
ns.setFVigor = { crown=true, tip="Flower of Vigor",
					quests={ { id=56903, index=3, name="Crown of Courage", version=80205, qType="One Time", }, }, }
ns.setFWealth = { crown=true, tip="Flower of Wealth",
					quests={ { id=56904, index=1, name="Crown of Prosperity", version=80205, qType="One Time", }, }, }
ns.setFPeace = { crown=true, tip="Flower of Peace",
					quests={ { id=56904, index=2, name="Crown of Prosperity", version=80205, qType="One Time", }, }, }
ns.setFFelicity = { crown=true, tip="Flower of Felicity",
					quests={ { id=56904, index=3, name="Crown of Prosperity", version=80205, qType="One Time", }, }, }
ns.setFCompassion = { crown=true, tip="Flower of Compassion",
					quests={ { id=56905, index=1, name="Crown of Dark Blossoms", version=80205, qType="One Time", }, }, }
ns.setFReflection = { crown=true, tip="Flower of Reflection",
					quests={ { id=56905, index=2, name="Crown of Dark Blossoms", version=80205, qType="One Time", }, }, }
ns.setFSolemnity = { crown=true, noZidormi=true, tip="Flower of Solemnity",
					quests={ { id=56905, index=3, name="Crown of Dark Blossoms", version=80205, qType="One Time", }, }, }
ns.setFThoughtfulness = { crown=true, tip="Flower of Thoughtfulness",
					quests={ { id=56906, index=1, name="Crown of Good Fortune", version=80205, qType="One Time", }, }, }
ns.setFLuck = { crown=true, tip="Flower of Luck",
					quests={ { id=56906, index=2, name="Crown of Good Fortune", version=80205, qType="One Time", }, }, }
ns.setFGenerosity = { crown=true, tip="Flower of Generosity",
					quests={ { id=56906, index=3, name="Crown of Good Fortune", version=80205, qType="One Time", }, }, }

--==================================================================================================================================
--
-- KALIMDOR
--
--==================================================================================================================================

ns.setMyraelLunarbloom = { preservation=true, noZidormi=true, name="Myrael Lunarbloom",
			quests={ { id=56842, name="Lunar Preservation", version=80205, qType="One Time", }, 
				{ id=56903, name="Crown of Courage", version=80205, qType="One Time", }, 
				{ id=56905, name="Crown of DarkBlossoms", version=80205, qType="One Time", }, 
				{ id=56906, name="Crown of Good Fortune", version=80205, qType="One Time", }, 
				{ id=56904, name="Crown of Prosperity", version=80205, qType="One Time", }, }, }
ns.setNighthavenMoonwell = { preservation=true, noZidormi=true, tip="Nighthaven Moonwell",
			quests={ { id=56842, index=1, name="Lunar Preservation", version=80205, qType="One Time", }, }, }				
ns.setValadarStarsong = { seasonalQuest=true, noZidormi=true, name="Valadar Starsong",
			quests={ { id=8867, qType="Seasonal", }, { id=8883, qType="Seasonal", }, { id=8868, qType="Seasonal", }, }, }

ns.points[ ns.map.ashenvale ] = { -- Ashenvale
	[35544891] = { elder=true, achievements={ { id=911, index=9, version=60000, }, 
					{ id=911, index=4, versionUnder=60000, }, },
					quests={ { id=8725, qType="Seasonal", tip="Horde be quick here!", }, }, },
	[53744600] = { preservation=true, tip="Moonwell of Purity",
					quests={ { id=56842, index=3, name="Lunar Preservation", version=80205, qType="One Time", }, }, },
	[60207290] = { preservation=true, tip="Moonwell of Cleansing",
					quests={ { id=56842, index=4, name="Lunar Preservation", version=80205, qType="One Time", }, }, },
	[04365241] = { preservation=true, tip="Stonetalon Moonwell",
					quests={ { id=56842, index=5, name="Lunar Preservation", version=80205, qType="One Time", }, }, },
	[65240609] = { elder=true, achievements={ { id=6006, index=6, }, }, quests={ { id=29739, qType="Seasonal", }, }, },
}

ns.points[ ns.map.azshara ] = { -- Azshara
	[64737934] = { elder=true, achievements={ { id=911, index=2, version=60000, },
					{ id=911, index=8, versionUnder=60000, }, }, quests={ { id=8720, qType="Seasonal", }, }, },
	[18919764] = { elderFaction=true, achievements={ { id=914, index=1, }, },
					quests={ { id=8677, qType="Seasonal", tip="Alliance need to be very quick with this one", }, }, },
}

ns.points[ ns.map.azuremyst ] = { -- Azuremyst Isle
	[33134498] = { seasonalQuest=true, name="Lunar Festival Harbinger",
					quests={ { id=8867, qType="Seasonal", }, { id=8883, qType="Seasonal", }, }, },
}

ns.points[ ns.map.darkshore  ] = { -- Darkshore
	[49541895] = { elder=true, achievements={ { id=911, index=7, version=60000, },
					{ id=911, index=16, versionUnder=60000, }, }, quests={ { id=8721, qType="Seasonal", }, }, },
	[54827242] = { elder=true, noZidormi=true, achievements={ { id=911, index=12, version=60000, },
					{ id=911, index=1, versionUnder=60000, }, }, quests={ { id=8723, qType="Seasonal", }, }, },
	[78578779] = { elder=true, noZidormi=true, achievements={ { id=6006, index=6, }, },
					quests={ { id=29739, qType="Seasonal", }, }, },
	[85400553] = ns.setNighthavenMoonwell,
	[86990663] = ns.setMyraelLunarbloom,
	[87190636] = ns.setValadarStarsong,
}

ns.points[ ns.map.darnassus ] = { -- Darnassus
	[38583028] = { seasonalQuest=true, name="Lunar Festival Harbinger",
					quests={ { id=8867, qType="Seasonal", }, { id=8883, qType="Seasonal", }, }, },
	[39203185] = { elderFaction=true, achievements={ { id=915, index=1, version=60000, },
					{ id=915, index=3, versionUnder=60000, }, }, quests={ { id=8718, qType="Seasonal", }, }, },
	[37325047] = { elderFaction=true, achievements={ { id=915, index=1, version=60000, },
					{ id=915, index=3, versionUnder=60000, }, },
					quests={ { id=8718, qType="Seasonal", faction="Horde", 
					tip="Immediately go left and up high - don't delay", }, }, },
	[30402709] = { elderFaction=true, achievements={ { id=915, index=1, version=60000, },
					{ id=915, index=3, versionUnder=60000, }, },
					quests={ { id=8718, qType="Seasonal", faction="Horde", 
					tip="Hide here for respite/cooldowns, as necessary", }, }, },
}

ns.points[ ns.map.desolace ] = { -- Desolace
	[29626248] = { elderDungeon=true, achievements={ { id=910, index=3, version=60000, },
					{ id=910, index=10, versionUnder=60000, tip=ns.taraezorPromo, }, },
					quests={ { id=8635, qType="Seasonal", tip="Enter Maraudon. Follow the markers", }, }, },
	[50225001] = ns.setFCompassion,
	[50284566] = ns.setFCompassion,
	[50904702] = ns.setFCompassion,
	[51074943] = ns.setFCompassion,
	[51384509] = ns.setFCompassion,
	[52095157] = ns.setFCompassion,
	[52774955] = ns.setFCompassion,
	[53104525] = ns.setFCompassion,
	[53335138] = ns.setFCompassion,
	[54784717] = ns.setFCompassion,
	[99184999] = { seasonalQuest=true, name="Lunar Festival Harbinger",
					quests={ { id=8867, qType="Seasonal", }, { id=8883, qType="Seasonal", }, }, },
	[99614885] = { elderFaction=true, achievements={ { id=914, index=2, version=60000, },
					{ id=914, index=3, versionUnder=60000, }, }, quests={ { id=8678, qType="Seasonal", }, }, },
}

ns.points[ ns.map.durotar ] = { -- Durotar
	[53234361] = { elder=true, achievements={ { id=911, index=1, version=60000, },
					{ id=911, index=9, versionUnder=60000, }, },
					quests={ { id=8670, qType="Seasonal", tip="Alliance need to be very quick with this one", }, }, },
	[47000300] = { elderFaction=true, achievements={ { id=914, index=1, }, },
					quests={ { id=8677, qType="Seasonal", tip="Alliance need to be very quick with this one", }, }, },
	[00334697] = ns.setFWealth,
	[00594848] = ns.setFWealth,
	[00675268] = ns.setFWealth,
	[00805135] = ns.setFWealth,
	[33357598] = { elder=true, achievements={ { id=911, index=5, version=60000, },
					{ id=911, index=7, versionUnder=60000, }, }, quests={ { id=8680, qType="Seasonal", }, }, },
	[11796435] = { elder=true, achievements={ { id=911, index=3, version=60000, },
					{ id=911, index=17, versionUnder=60000, }, }, quests={ { id=8717, qType="Seasonal", }, }, },
}

ns.points[ ns.map.dustwallow ] = { -- Dustwallow Marsh
	[28529858] = { elder=true, achievements={ { id=911, index=13, version=60000, },
					{ id=911, index=19, versionUnder=60000, }, }, quests={ { id=8682, qType="Seasonal", }, }, },
	[14330306] = { elder=true, achievements={ { id=911, index=4, version=60000, },
					{ id=911, index=21, versionUnder=60000, }, }, quests={ { id=8686, qType="Seasonal", }, }, },
}

ns.points[ ns.map.felwood ] = { -- Felwood
	[38365285] = { elder=true, achievements={ { id=911, index=12, version=60000, },
					{ id=911, index=1, versionUnder=60000, }, }, quests={ { id=8723, qType="Seasonal", }, }, },
	[44042841] = { preservation=true, tip="Whisperwind Grove Moonwell",
					quests={ { id=56842, index=2, name="Lunar Preservation", version=80205, qType="One Time", }, }, },
	[63676924] = { elder=true, achievements={ { id=6006, index=6, version=60000, },
					{ id=6006, index=6, versionUnder=60000, }, }, quests={ { id=29739, qType="Seasonal", }, }, },
	[88784176] = { elder=true, achievements={ { id=6006, index=7, version=60000, },
					{ id=6006, index=7, versionUnder=60000, }, }, quests={ { id=29740, qType="Seasonal", }, }, },
}

ns.points[ ns.map.feralas ] = { -- Feralas
	[76713790] = { elder=true, achievements={ { id=911, index=10, version=60000, },
					{ id=911, index=20, versionUnder=60000, }, },
					quests={ { id=8679, qType="Seasonal", tip="In the Lariss Pavillion", }, }, },
	[62563107] = { elder=true, achievements={ { id=911, index=11, version=60000, },
					{ id=911, index=15, versionUnder=60000, }, },
					quests={ { id=8685, qType="Seasonal", tip="In the Dire Maul arena - she's not in the instance", }, }, },
	[60214625] = { preservation=true, tip="Dire Maul Moonwell",
					quests={ { id=56842, index=6, name="Lunar Preservation", version=80205, qType="One Time", }, }, },
	[53368345] = { elder=true, achievements={ { id=911, index=20, version=60000, },
					{ id=911, index=12, versionUnder=60000, }, },
					quests={ { id=8654, qType="Seasonal", }, }, },
	[66339639] = { elder=true, achievements={ { id=911, index=21, version=60000, },
					{ id=911, index=18, versionUnder=60000, }, },
					quests={ { id=8719, qType="Seasonal", }, }, },
}

ns.points[ 68 ] = { -- Maraudon - Foulspore Cavern
	[46788822] = { elderDungeon=true, achievements={ { id=910, index=3, version=60000, },
					{ id=910, index=10, versionUnder=60000, }, }, quests={ { id=8635, qType="Seasonal",
					tip="If you are here then you have come the correct way. It's a linear path. The instance portal is "
						.."ahead", }, }, },
}

ns.points[ 67 ] = { -- Maraudon - The Wicked Grotto
	[19345583] = { elderDungeon=true, achievements={ { id=910, index=3, version=60000, },
					{ id=910, index=10, versionUnder=60000, }, },
					quests={ { id=8635, qType="Seasonal", tip="This is where you respawn if you were wondering", }, }, },
	[25004335] = { elderDungeon=true, achievements={ { id=910, index=3, version=60000, },
					{ id=910, index=10, versionUnder=60000, }, },
					quests={ { id=8635, qType="Seasonal", tip="Instance entrance/exit", }, }, },
	[17005350] = { elderDungeon=true, achievements={ { id=910, index=3, version=60000, },
					{ id=910, index=10, versionUnder=60000, }, }, quests={ { id=8635, qType="Seasonal",
					tip="Follow the path.\n\nAt \"Zaetar's Choice\" enter the arch that is guarded by two centaurs. Do not take "
						.."the left pink/purple path, nor the right red/orange path", }, }, },
}

ns.points[ 281 ] = { -- Maraudon - Zaelar's Grave
	[28083508] = { elderDungeon=true, achievements={ { id=910, index=3, version=60000, },
					{ id=910, index=10, versionUnder=60000, }, }, quests={ { id=8635, qType="Seasonal",
					tip="This is where you \"land\" upon entry to the instance. Go straight ahead, jumping down and through the "
						.."cutting", }, }, },
	[33006070] = { elderDungeon=true, achievements={ { id=910, index=3, version=60000, },
					{ id=910, index=10, versionUnder=60000, }, },
					quests={ { id=8635, qType="Seasonal", tip="Through here and follow the path", }, }, },
	[45405480] = { elderDungeon=true, achievements={ { id=910, index=3, version=60000, },
					{ id=910, index=10, versionUnder=60000, }, }, quests={ { id=8635, qType="Seasonal",
					tip="You now have a choice. Go right. In other words, do not take the (left) ramp upwards", }, }, },
	[40007340] = { elderDungeon=true, achievements={ { id=910, index=3, version=60000, },
					{ id=910, index=10, versionUnder=60000, }, }, quests={ { id=8635, qType="Seasonal",
					tip="You're now in an area with a waterfall, a Primordial Behemoth, a bridge and a river. Continue over the "
						.."bridge. Don't jump down. It's a linear path, you can't get lost!", }, }, },
	[51379385] = { elderDungeon=true, achievements={ { id=910, index=3, version=60000, },
					{ id=910, index=10, versionUnder=60000, }, },
					quests={ { id=8635, qType="Seasonal", tip="Elder Splitrock is here", }, }, },
	[54708660] = { elderDungeon=true, achievements={ { id=910, index=3, version=60000, },
					{ id=910, index=10, versionUnder=60000, }, }, quests={ { id=8635, qType="Seasonal",
					tip="After Elder Splitrock, don't bother looking for a way out down here. There isn't one. Hearth or "
						.."portal", }, }, },
}

ns.points[ ns.map.moonglade ] = { -- Moonglade
	[48643293] = { preservation=true, tip="Nighthaven Moonwell",
					quests={ { id=56842, index=1, name="Lunar Preservation", version=80205, qType="One Time", }, }, },
	[53083602] = ns.setMyraelLunarbloom,
	[53653525] = ns.setValadarStarsong,
}

ns.points[ ns.map.mulgore ] = { -- Mulgore
	[44582416] = { seasonalQuest=true, name="Lunar Festival Harbinger",
					quests={ { id=8867, qType="Seasonal", }, { id=8883, qType="Seasonal", }, }, },
	[48495323] = { elder=true, achievements={ { id=911, index=8, version=60000, },
					{ id=911, index=11, versionUnder=60000, }, }, quests={ { id=8673, qType="Seasonal", }, }, },
	[44942322] = { elderFaction=true, achievements={ { id=914, index=2, version=60000, },
					{ id=914, index=2, versionUnder=60000, }, }, quests={ { id=8678, qType="Seasonal", }, }, },
	[47473458] = ns.setFSincerity,
	[47653056] = ns.setFSincerity,
	[48112717] = ns.setFSincerity,
	[49122970] = ns.setFSincerity,
	[50982986] = ns.setFSincerity,
	[51273853] = ns.setFSincerity,
	[52423242] = ns.setFSincerity,
	[53843626] = ns.setFSincerity,
	[56472982] = ns.setFSincerity,
	[57053049] = ns.setFSincerity,
	[72145427] = { elder=true, achievements={ { id=911, index=4, version=60000, },
					{ id=911, index=21, versionUnder=60000, }, }, quests={ { id=8686, qType="Seasonal", }, }, },
	[04192417] = ns.setFCompassion,
	[04242059] = ns.setFCompassion,
	[04762171] = ns.setFCompassion,
	[04902370] = ns.setFCompassion,
	[05152012] = ns.setFCompassion,
	[05742547] = ns.setFCompassion,
	[06302380] = ns.setFCompassion,
	[06572025] = ns.setFCompassion,
	[06762530] = ns.setFCompassion,
	[07962183] = ns.setFCompassion,
	[87890802] = { elder=true, achievements={ { id=911, index=3, version=60000, },
					{ id=911, index=17, versionUnder=60000, }, }, quests={ { id=8717, qType="Seasonal", }, }, },
}

ns.points[ ns.map.barrens ] = { -- Northern Barrens
	[48525926] = { elder=true, achievements={ { id=911, index=3, version=60000, },
					{ id=911, index=17, versionUnder=60000, }, }, quests={ { id=8717, qType="Seasonal", }, }, },
	[68366996] = { elder=true, achievements={ { id=911, index=5, version=60000, },
					{ id=911, index=7, versionUnder=60000, }, }, quests={ { id=8680, qType="Seasonal", }, }, },
	[35654710] = ns.setFWealth,
	[36174300] = ns.setFWealth,
	[36204512] = ns.setFWealth,
	[37054770] = ns.setFWealth,
	[37504278] = ns.setFWealth,
	[37624591] = ns.setFWealth,
	[37974327] = ns.setFWealth,
	[38214466] = ns.setFWealth,
	[38294852] = ns.setFWealth,
	[38414730] = ns.setFWealth,	
	[10188445] = ns.setFSincerity,
	[10358064] = ns.setFSincerity,
	[10797743] = ns.setFSincerity,
	[11757982] = ns.setFSincerity,
	[13517998] = ns.setFSincerity,
	[13788820] = ns.setFSincerity,
	[14888240] = ns.setFSincerity,
	[16238605] = ns.setFSincerity,
	[18727994] = ns.setFSincerity,
	[19278058] = ns.setFSincerity,
	[07447457] = { seasonalQuest=true, name="Lunar Festival Harbinger",
					quests={ { id=8867, qType="Seasonal", }, { id=8883, qType="Seasonal", }, }, },
	[07787368] = { elderFaction=true, achievements={ { id=914, index=2, version=60000, },
					{ id=914, index=3, versionUnder=60000, }, }, quests={ { id=8678, qType="Seasonal", }, }, },
	[80370051] = { elderFaction=true, achievements={ { id=914, index=1, }, },
					quests={ { id=8677, qType="Seasonal", tip="Alliance need to be very quick with this one", }, }, },
	[86654018] = { elder=true, achievements={ { id=911, index=1, version=60000, },
					{ id=911, index=9, versionUnder=60000, }, },
					quests={ { id=8670, qType="Seasonal", tip="Alliance need to be very quick with this one", }, }, },
}

ns.points[ ns.map.orgrimmar ] = { -- Orgrimmar
	[49095581] = { seasonalQuest=true, name="Lunar Festival Harbinger",
					quests={ { id=8867, qType="Seasonal", }, { id=8883, qType="Seasonal", }, }, },
	[52266001] = { elderFaction=true, achievements={ { id=914, index=1, }, },
					quests={ { id=8677, qType="Seasonal", tip="Alliance need to be very quick with this one", }, }, },
}

ns.points[ ns.map.silithus ] = { -- Silithus
	[30801332] = { elder=true, achievements={ { id=911, index=20, version=60000, },
					{ id=911, index=12, versionUnder=60000, }, },
					quests={ { id=8654, qType="Seasonal", }, }, },
	[53023547] = { elder=true, achievements={ { id=911, index=21, version=60000, },
					{ id=911, index=18, versionUnder=60000, }, },
					quests={ { id=8719, qType="Seasonal", }, }, },
}

ns.points[ 199 ] = { -- Southern Barrens
	[41604745] = { elder=true, achievements={ { id=911, index=4, version=60000, },
					{ id=911, index=21, versionUnder=60000, }, }, quests={ { id=8686, qType="Seasonal", }, }, },
	[24224668] = { elder=true, achievements={ { id=911, index=8, version=60000, },
					{ id=911, index=11, versionUnder=60000, }, }, quests={ { id=8673, qType="Seasonal", }, }, },
	[23463297] = ns.setFSincerity,
	[23603002] = ns.setFSincerity,
	[23932753] = ns.setFSincerity,
	[24682938] = ns.setFSincerity,
	[26052950] = ns.setFSincerity,
	[26263587] = ns.setFSincerity,
	[27103138] = ns.setFSincerity,
	[28153421] = ns.setFSincerity,
	[30082947] = ns.setFSincerity,
	[30512997] = ns.setFSincerity,
	[21602462] = { elderFaction=true, achievements={ { id=914, index=2, version=60000, },
					{ id=914, index=2, versionUnder=60000, }, }, quests={ { id=8678, qType="Seasonal", }, }, },
	[43210401] = ns.setFWealth,
	[43600083] = ns.setFWealth,
	[43630248] = ns.setFWealth,
	[44290448] = ns.setFWealth,
	[44640066] = ns.setFWealth,
	[44730309] = ns.setFWealth,
	[44740309] = ns.setFWealth,
	[45010104] = ns.setFWealth,
	[45190212] = ns.setFWealth,
	[45250511] = ns.setFWealth,
	[45350417] = ns.setFWealth,
	[53181344] = { elder=true, achievements={ { id=911, index=3, version=60000, },
					{ id=911, index=17, versionUnder=60000, }, }, quests={ { id=8717, qType="Seasonal", }, }, },
	[68562174] = { elder=true, achievements={ { id=911, index=5, version=60000, },
					{ id=911, index=7, versionUnder=60000, }, }, quests={ { id=8680, qType="Seasonal", }, }, },
	[21342531] = { seasonalQuest=true, name="Lunar Festival Harbinger",
					quests={ { id=8867, qType="Seasonal", }, { id=8883, qType="Seasonal", }, }, },
}

ns.points[ ns.map.stonetalon ] = { -- Stonetalon Mountains
	[41591896] = { preservation=true, tip="Stonetalon Peak Moonwell",
					quests={ { id=56842, index=5, name="Lunar Preservation", version=80205, qType="One Time", }, }, },
	[72061554] = { elder=true, achievements={ { id=911, index=9, version=60000, },
					{ id=911, index=4, versionUnder=60000, }, }, quests={ { id=8725, qType="Seasonal", }, }, },
	[96163898] = { preservation=true, tip="Moonwell of Cleansing",
					quests={ { id=56842, index=4, name="Lunar Preservation", version=80205, qType="One Time", }, }, },
	[89851270] = { preservation=true, tip="Moonwell of Purity",
					quests={ { id=56842, index=3, name="Lunar Preservation", version=80205, qType="One Time", }, }, },
}

ns.points[ ns.map.tanaris ] = { -- Tanaris
	[37247906] = { elder=true, achievements={ { id=911, index=15, version=60000, },
					{ id=911, index=13, versionUnder=60000, }, }, quests={ { id=8671, qType="Seasonal", }, }, },
	[51402881] = { elder=true, achievements={ { id=911, index=16, version=60000, },
					{ id=911, index=2, versionUnder=60000, }, }, quests={ { id=8684, qType="Seasonal", }, }, },
	[39222134] = { elderDungeon=true, achievements={ { id=910, index=1, version=60000, },
					{ id=910, index=7, versionUnder=60000, }, },
					quests={ { id=8676, qType="Seasonal", tip="Enter Zul'Farrak. Follow the markers", }, }, },
	[17584315] = { elder=true, achievements={ { id=911, index=17, version=60000, },
					{ id=911, index=6, versionUnder=60000, }, }, quests={ { id=8681, qType="Seasonal", }, }, },
	[23711968] = ns.setFFelicity,
	[24651944] = ns.setFFelicity,
	[25081689] = ns.setFFelicity,
	[25251996] = ns.setFFelicity,
	[25301790] = ns.setFFelicity,
	[25881559] = ns.setFFelicity,
	[25982071] = ns.setFFelicity,
	[26551851] = ns.setFFelicity,
	[26932084] = ns.setFFelicity,
	[27491962] = ns.setFFelicity,
	[52170860] = { elder=true, achievements={ { id=911, index=14, version=60000, },
					{ id=911, index=14, versionUnder=60000, }, }, quests={ { id=8724, qType="Seasonal", }, }, },
	[21556299] = { elder=true, achievements={ { id=6006, index=2, version=60000, },
					{ id=6006, index=4, versionUnder=60000, }, }, quests={ { id=29742, qType="Seasonal", }, }, },
}

ns.points[ ns.map.teldrassil ] = { -- Teldrassil
	[27954326] = { seasonalQuest=true, name="Lunar Festival Harbinger",
					quests={ { id=8867, qType="Seasonal", }, { id=8883, qType="Seasonal", }, }, },
	[28114367] = { elderFaction=true, achievements={ { id=915, index=1, version=60000, },
					{ id=915, index=3, versionUnder=60000, }, }, quests={ { id=8718, qType="Seasonal", }, }, },
	[56855310] = { elder=true, achievements={ { id=911, index=6, version=60000, },
					{ id=911, index=5, versionUnder=60000, }, }, quests={ { id=8715, qType="Seasonal", }, }, },
	[55108853] = { elderFaction=true, achievements={ { id=915, index=1, version=60000, },
					{ id=915, index=3, versionUnder=60000, }, },
					quests={ { id=8718, qType="Seasonal", faction="Horde",
					tip="Fly straight into the pink portal at Rut'theran. Immediately turn left and fly up high", }, }, },
}

ns.points[ ns.map.theExodar ] = { -- The Exodar
	[74015747] = { seasonalQuest=true, name="Lunar Festival Harbinger",
					quests={ { id=8867, qType="Seasonal", }, { id=8883, qType="Seasonal", }, }, },
}

ns.points[ ns.map.thousand ] = { -- Thousand Needles
	[46345101] = { elder=true, achievements={ { id=911, index=13, version=60000, },
					{ id=911, index=19, versionUnder=60000, }, }, quests={ { id=8682, qType="Seasonal", }, }, },
	[77097561] = { elder=true, achievements={ { id=911, index=14, version=60000, },
					{ id=911, index=14, versionUnder=60000, }, }, quests={ { id=8724, qType="Seasonal", }, }, },
	[30449376] = ns.setFFelicity,
	[31989337] = ns.setFFelicity,
	[32698920] = ns.setFFelicity,
	[32969423] = ns.setFFelicity,
	[33049085] = ns.setFFelicity,
	[33998706] = ns.setFFelicity,
	[34179545] = ns.setFFelicity,
	[35089184] = ns.setFFelicity,
	[35729567] = ns.setFFelicity,
	[36639366] = ns.setFFelicity,
	[55869648] = { elderDungeon=true, achievements={ { id=910, index=1, version=60000, },
					{ id=910, index=8, versionUnder=60000, }, },
					quests={ { id=8676, qType="Seasonal", tip="Enter Zul'Farrak. Follow the markers", }, }, },
}

ns.points[ ns.map.thunder ] = { -- Thunder Bluff
	[71112823] = { seasonalQuest=true, name="Lunar Festival Harbinger",
					quests={ { id=8867, qType="Seasonal", }, { id=8883, qType="Seasonal", }, }, },
	[72982335] = { elderFaction=true, achievements={ { id=914, index=2, version=60000, },
					{ id=914, index=3, versionUnder=60000, }, }, quests={ { id=8678, qType="Seasonal", }, }, },
}

ns.points[ ns.map.ungoro ] = { -- Un'Goro
	[50377617] = { elder=true, achievements={ { id=911, index=17, version=60000, },
					{ id=911, index=6, versionUnder=60000, }, }, quests={ { id=8681, qType="Seasonal", }, }, },
	[62323042] = ns.setFFelicity,
	[64162995] = ns.setFFelicity,
	[65002499] = ns.setFFelicity,
	[65323097] = ns.setFFelicity,
	[65422696] = ns.setFFelicity,
	[66542244] = ns.setFFelicity,
	[66763242] = ns.setFFelicity,
	[67852814] = ns.setFFelicity,
	[68603269] = ns.setFFelicity,
	[69683030] = ns.setFFelicity,
	[95553366] = { elderDungeon=true, achievements={ { id=910, index=1, version=60000, },
					{ id=910, index=8, versionUnder=60000, }, },
					quests={ { id=8676, qType="Seasonal", tip="Enter Zul'Farrak. Follow the markers", }, }, },
}

ns.points[ ns.map.winterspring ] = { -- Winterspring
	[24591973] = { preservation=true, tip="Nighthaven Moonwell",
					quests={ { id=56842, index=1, name="Lunar Preservation", version=80205, qType="One Time", }, }, },
	[26262089] = ns.setMyraelLunarbloom,
	[26472061] = ns.setValadarStarsong,
	[42167912] = { elder=true, achievements={ { id=6006, index=7, }, }, quests={ { id=29740, qType="Seasonal", }, }, },
	[53225675] = { elder=true, achievements={ { id=911, index=18, version=60000, },
					{ id=911, index=3, versionUnder=60000, }, }, quests={ { id=8726, qType="Seasonal", }, }, },
	[59964994] = { elder=true, achievements={ { id=911, index=19, version=60000, },
					{ id=911, index=10, versionUnder=60000, }, }, quests={ { id=8672, qType="Seasonal", }, }, },
	[56173028] = ns.setFGenerosity,
	[55892949] = ns.setFGenerosity,
	[56173028] = ns.setFGenerosity,
	[56812862] = ns.setFGenerosity,
	[56843730] = ns.setFGenerosity,
	[57083253] = ns.setFGenerosity,
	[57682999] = ns.setFGenerosity,
	[57693201] = ns.setFGenerosity,
	[57713710] = ns.setFGenerosity,
	[57913552] = ns.setFGenerosity,
	[58883399] = ns.setFGenerosity,
}

ns.points[ 219 ] = { -- Zul'Farrak
	[34393931] = { elderDungeon=true, achievements={ { id=910, index=1, version=60000, },
					{ id=910, index=8, versionUnder=60000, }, },
					quests={ { id=8676, qType="Seasonal", tip="Follow the map directly, no need for way-markers!", }, }, },
}

ns.points[ ns.map.kalimdor ] = { -- Kalimdor
	[29007600] = { metaLarge=true, achievements={ { id=911, showAllCriteria=true, }, }, noContinent=true, alwaysShow=true, },
	[02501820] = ns.setNewZones,
	[02502250] = ns.setHonorElders,
	[04702530] = ns.setElune,
	[05002100] = ns.setFlavour,
	[05201700] = ns.setMetaFaction,
	[07302400] = ns.setPyro,
	[07601980] = ns.set50Coins,
}

--==================================================================================================================================
--
-- EASTERN KINGDOMS
--
--==================================================================================================================================

ns.points[ ns.map.badlands ] = { -- Badlands
	[06957986] = { elder=true, achievements={ { id=912, index=10, version=60000, },
					{ id=912, index=16, versionUnder=60000, }, }, quests={ { id=8683, qType="Seasonal", }, }, },
}

ns.points[ 242 ] = { -- Blackrock Depths - Detention Block
	[38007650] = { elderDungeon=true, achievements={ { id=910, index=5, version=60000, },
					{ id=910, index=11, versionUnder=60000, }, },
					quests={ { id=8619, qType="Seasonal", tip="1) This way", }, }, },
	[49007200] = { elderDungeon=true, achievements={ { id=910, index=5, version=60000, },
					{ id=910, index=11, versionUnder=60000, }, },
					quests={ { id=8619, qType="Seasonal", tip="2) This way", }, }, },
	[51406770] = { elderDungeon=true, achievements={ { id=910, index=5, version=60000, },
					{ id=910, index=11, versionUnder=60000, }, },
					quests={ { id=8619, qType="Seasonal",
					tip="3) Enter the Ring here, turn in the quest and reverse to exit", }, }, },
}

ns.points[ 34 ] = { -- Blackrock Mountain - Blackrock Caverns
	[53127138] = { elderDungeon=true, achievements={ { id=910, index=4, version=60000, },
					{ id=910, index=9, versionUnder=60000, }, },
					quests={ { id=8644, qType="Seasonal", tip="2) Continue past the barrier", }, }, },
	[52654551] = { elderDungeon=true, achievements={ { id=910, index=4, version=60000, },
					{ id=910, index=9, versionUnder=60000, }, },
					quests={ { id=8644, qType="Seasonal", tip="3) Go straight up", }, }, },
	[60142748] = { elderDungeon=true, achievements={ { id=910, index=4, version=60000, },
					{ id=910, index=9, versionUnder=60000, }, },
					quests={ { id=8644, qType="Seasonal", tip="4) Go up the ramp", }, }, },
}

ns.points[ 35 ] = { -- Blackrock Mountain - Blackrock Depths
	[54848478] = { elderDungeon=true, achievements={ { id=910, index=5, version=60000, },
					{ id=910, index=11, versionUnder=60000, }, },
					quests={ { id=8619, qType="Seasonal", tip="1) Fly down to here", }, }, },
	[55818208] = { elderDungeon=true, achievements={ { id=910, index=5, version=60000, },
					{ id=910, index=11, versionUnder=60000, }, },
					quests={ { id=8619, qType="Seasonal", tip="2) Come this way", }, }, },
	[45716843] = { elderDungeon=true, achievements={ { id=910, index=5, version=60000, },
					{ id=910, index=11, versionUnder=60000, }, },
					quests={ { id=8619, qType="Seasonal", tip="3) This way", }, }, },
	[37714228] = { elderDungeon=true, achievements={ { id=910, index=5, version=60000, },
					{ id=910, index=11, versionUnder=60000, }, },
					quests={ { id=8619, qType="Seasonal", tip="4) This way", }, }, },
	[39171822] = { elderDungeon=true, achievements={ { id=910, index=5, version=60000, },
					{ id=910, index=11, versionUnder=60000, }, },
					quests={ { id=8619, qType="Seasonal",
					tip="5) Enter through here and follow the markers", }, }, },
}

ns.points[ 33 ] = { -- Blackrock Mountain - Blackrock Spire
	[65676078] = { elderDungeon=true, achievements={ { id=910, index=4, version=60000, },
					{ id=910, index=9, versionUnder=60000, }, },
					quests={ { id=8644, qType="Seasonal", tip="1) Enter through here", }, }, },
	[72524765] = { elderDungeon=true, achievements={ { id=910, index=4, version=60000, },
					{ id=910, index=9, versionUnder=60000, }, },
					quests={ { id=8644, qType="Seasonal", tip="5) Continue upwards", }, }, },
	[70775311] = { elderDungeon=true, achievements={ { id=910, index=4, version=60000, },
					{ id=910, index=9, versionUnder=60000, }, },
					quests={ { id=8644, qType="Seasonal", tip="6) Continue upwards", }, }, },
	[63454416] = { elderDungeon=true, achievements={ { id=910, index=4, version=60000, },
					{ id=910, index=9, versionUnder=60000, }, },
					quests={ { id=8644, qType="Seasonal", tip="7) Shortcut upwards. You can fly up to here!", }, }, },
	[72903983] = { elderDungeon=true, achievements={ { id=910, index=4, version=60000, },
					{ id=910, index=9, versionUnder=60000, }, }, quests={ { id=8644, qType="Seasonal",
					tip="8) Continue forward and down the ramp. Portal is to your right", }, }, },
	[80324026] = { elderDungeon=true, achievements={ { id=910, index=4, version=60000, },
					{ id=910, index=9, versionUnder=60000, }, },
					quests={ { id=8644, qType="Seasonal", tip="9) Enter through here and follow the markers", }, }, },
	[39494029] = { elderDungeon=true, achievements={ { id=910, index=5, version=60000, },
					{ id=910, index=11, versionUnder=60000, }, },
					quests={ { id=8619, qType="Seasonal", tip="1) Fly down to here", }, }, },
}

ns.points[ 251 ] = { -- Blackrock Spire - Skitterweb Tunnels
	[58904260] = { elderDungeon=true, achievements={ { id=910, index=4, version=60000, },
					{ id=910, index=9, versionUnder=60000, }, },
					quests={ { id=8644, qType="Seasonal", tip="3) Cross the bridge", }, }, },
	[61934012] = { elderDungeon=true, achievements={ { id=910, index=4, version=60000, },
					{ id=910, index=9, versionUnder=60000, }, }, quests={ { id=8644, qType="Seasonal",
					tip="4) Turn in the quest. Reverse to exit", }, }, },
}

ns.points[ 252 ] = { -- Blackrock Spire - Hordemar City
	[39004800] = { elderDungeon=true, achievements={ { id=910, index=4, version=60000, },
					{ id=910, index=9, versionUnder=60000, }, },
					quests={ { id=8644, qType="Seasonal",
					tip="1) Begin by following the path down and then left to here. Keep going", }, }, },
	[60404270] = { elderDungeon=true, achievements={ { id=910, index=4, version=60000, },
					{ id=910, index=9, versionUnder=60000, }, },
					quests={ { id=8644, qType="Seasonal", tip="3) Cross the bridge", }, }, },
}

ns.points[ 253 ] = { -- Blackrock Spire - Hall of Blackhand
	[48004100] = { elderDungeon=true, achievements={ { id=910, index=4, version=60000, },
					{ id=910, index=9, versionUnder=60000, }, }, quests={ { id=8644, qType="Seasonal",
					tip="2) Plough on past the mobs. Depending upon your graphics settings, you can see Elder Stonefort from "
						.."here", }, }, },
}

ns.points[ ns.map.blastedLands ] = { -- Blasted Lands
	[54284950] = { elder=true, achievements={ { id=912, index=2, version=60000, },
					{ id=912, index=12, versionUnder=60000, }, }, quests={ { id=8647, qType="Seasonal", }, }, },
}

ns.points[ ns.map.burningSteppes ] = { -- Burning Steppes
	[10581387] = { elder=true, achievements={ { id=912, index=12, version=60000, },
					{ id=912, index=1, versionUnder=60000, }, }, quests={ { id=8651, qType="Seasonal", }, }, },
	[70114538] = { elder=true, achievements={ { id=912, index=9, version=60000, },
					{ id=912, index=9, versionUnder=60000, }, }, quests={ { id=8636, qType="Seasonal", }, }, },
	[52382393] = { elder=true, achievements={ { id=912, index=10, version=60000, },
					{ id=912, index=16, versionUnder=60000, }, }, quests={ { id=8683, qType="Seasonal", }, }, },
	[20201803] = { elderDungeon=true, achievements={ { id=910, index=4, version=60000, },
					{ id=910, index=9, versionUnder=60000, }, },
					quests={ { id=8644, qType="Seasonal", tip="Enter through here and follow the markers", }, }, },
	[20201603] = { elderDungeon=true, achievements={ { id=910, index=5, version=60000, },
					{ id=910, index=11, versionUnder=60000, }, },
					quests={ { id=8619, qType="Seasonal", tip="Enter through here and follow the markers", }, }, },
	[21023744] = { elderDungeon=true, achievements={ { id=910, index=4, version=60000, },
					{ id=910, index=9, versionUnder=60000, }, },
					quests={ { id=8644, qType="Seasonal", tip="Enter through here and follow the markers", }, }, },
	[21023944] = { elderDungeon=true, achievements={ { id=910, index=5, version=60000, },
					{ id=910, index=11, versionUnder=60000, }, },
					quests={ { id=8619, qType="Seasonal", tip="Enter through here and follow the markers", }, }, },
}

ns.points[ ns.map.dunMorogh ] = { -- Dun Morogh
	[53904991] = { elder=true, achievements={ { id=912, index=1, version=60000, },
					{ id=912, index=13, versionUnder=60000, }, }, quests={ { id=8653, qType="Seasonal", }, }, },
	[60173345] = { elderFaction=true, achievements={ { id=915, index=2, }, },
					quests={ { id=8866, qType="Seasonal", faction="Horde", tip="Fly through here, keep to the left", }, }, }, 
	[62922198] = { elderFaction=true, achievements={ { id=915, index=2, }, }, quests={ { id=8866, qType="Seasonal", }, }, },
	[62872185] = { seasonalQuest=true, name="Lunar Festival Harbinger",
					quests={ { id=8867, qType="Seasonal", }, { id=8883, qType="Seasonal", }, }, },
	[45775808] = ns.setFLuck,
	[46125820] = ns.setFLuck,
	[46226042] = ns.setFLuck,
	[47485862] = ns.setFLuck,
	[48205348] = ns.setFLuck,
	[48265985] = ns.setFLuck,
	[48355544] = ns.setFLuck,
	[49965302] = ns.setFLuck,
	[51705259] = ns.setFLuck,
	[52545662] = ns.setFLuck,
}

ns.points[ ns.map.duskwood ] = { -- Duskwood
	[49153323] = { preservation=true, tip="Twilight Grove Moonwell",
					quests={ { id=56842, index=7, name="Lunar Preservation", version=80205, qType="One Time", }, }, },
	[59012185] = ns.setFReflection,
	[60082518] = ns.setFReflection,
	[60152031] = ns.setFReflection,
	[63013300] = ns.setFReflection,
	[63872163] = ns.setFReflection,
	[64132513] = ns.setFReflection,
	[64982878] = ns.setFReflection,
	[66163376] = ns.setFReflection,
	[67682256] = ns.setFReflection,
	[68321900] = ns.setFReflection,
}

ns.points[ ns.map.easternP ] = { -- Eastern Plaguelands
	[35586882] = { elder=true, achievements={ { id=912, index=15, version=60000, },
					{ id=912, index=15, versionUnder=60000, }, }, quests={ { id=8688, qType="Seasonal", }, }, },
	[75505450] = { elder=true, achievements={ { id=912, index=16, version=60000, },
					{ id=912, index=8, versionUnder=60000, }, }, quests={ { id=8650, qType="Seasonal", }, }, },
	[26531159] = { elderDungeon=true, achievements={ { id=910, index=6, version=60000, },
					{ id=910, index=12, versionUnder=60000, }, },
					quests={ { id=8727, qType="Seasonal", tip="Enter through here and follow the markers", }, }, },
	[02575390] = { elder=true, achievements={ { id=912, index=4, version=60000, },
					{ id=910, index=11, versionUnder=60000, }, },
					quests={ { id=8722, qType="Seasonal", tip="Enter The Weeping Cave", }, }, },
}

ns.points[ ns.map.elwynn ] = { -- Elwynn Forest
	[32135280] = { elderFaction=true, version=60000, achievements={ { id=915, index=3, }, },
					quests={ { id=8646, qType="Seasonal", }, }, },
	[32475305] = { seasonalQuest=true, name="Lunar Festival Harbinger", version=60000,
					quests={ { id=8867, qType="Seasonal", }, { id=8883, qType="Seasonal", }, }, },
	[34245056] = { seasonalQuest=true, name="Lunar Festival Harbinger", versionUnder=60000,
					quests={ { id=8867, qType="Seasonal", }, { id=8883, qType="Seasonal", }, }, },
	[34565026] = { elderFaction=true, versionUnder=60000, achievements={ { id=915, index=1, }, }, 
					quests={ { id=8646, qType="Seasonal", }, }, },
	[39796367] = { elder=true, achievements={ { id=912, index=3, version=60000, },
					{ id=912, index=7, versionUnder=60000, }, }, quests={ { id=8649, qType="Seasonal", }, }, },
	[66139377] = ns.setFReflection,
	[69929383] = ns.setFReflection,
	[66969636] = ns.setFReflection,
	[67029257] = ns.setFReflection,
	[70119632] = ns.setFReflection,
	[70789916] = ns.setFReflection,
	[72889432] = ns.setFReflection,
	[73389155] = ns.setFReflection,
}

ns.points[ ns.map.eversong ] = { -- Eversong Woods
	[39426745] = ns.setFFortitude,
	[40786500] = ns.setFFortitude,
	[40847300] = ns.setFFortitude,
	[42696870] = ns.setFFortitude,
	[43456364] = ns.setFFortitude,
	[44167339] = ns.setFFortitude,
	[44946799] = ns.setFFortitude,
	[46226210] = ns.setFFortitude,
	[46447190] = ns.setFFortitude,
	[46506526] = ns.setFFortitude,
	[56824734] = { seasonalQuest=true, name="Lunar Festival Harbinger",
					quests={ { id=8867, qType="Seasonal", }, { id=8883, qType="Seasonal", }, }, },
}

ns.points[ ns.map.hillsbrad ] = { -- Hillsbrad Foothills
	[46622052] = ns.setFThoughtfulness,
	[47201864] = ns.setFThoughtfulness,
	[47862141] = ns.setFThoughtfulness,
	[48082546] = ns.setFThoughtfulness,
	[48281758] = ns.setFThoughtfulness,
	[49772611] = ns.setFThoughtfulness,
	[50092111] = ns.setFThoughtfulness,
	[51052305] = ns.setFThoughtfulness,
	[52902309] = ns.setFThoughtfulness,
	[53052549] = ns.setFThoughtfulness,
	[90650679] = { elder=true, achievements={ { id=912, index=17, version=60000, },
					{ id=912, index=14, versionUnder=60000, }, }, quests={ { id=8714, qType="Seasonal", }, }, },
	[05942981] = { elder=true, achievements={ { id=912, index=14, version=60000, },
					{ id=912, index=10, versionUnder=60000, }, }, quests={ { id=8645, qType="Seasonal", }, }, },
	[13752469] = ns.setFSolemnity,
	[14292187] = ns.setFSolemnity,
	[15312379] = ns.setFSolemnity,
	[15682052] = ns.setFSolemnity,
	[15832453] = ns.setFSolemnity,
	[15851879] = ns.setFSolemnity,
	[16042264] = ns.setFSolemnity,
	[16602521] = ns.setFSolemnity,
	[17712461] = ns.setFSolemnity,
}

ns.points[ ns.map.ironforge ] = { -- Ironforge
	[28861626] = { seasonalQuest=true, name="Lunar Festival Harbinger",
					quests={ { id=8867, qType="Seasonal", }, { id=8883, qType="Seasonal", }, }, },
	[29191705] = { elderFaction=true, achievements={ { id=915, index=2, }, }, quests={ { id=8866, qType="Seasonal", }, }, },
	[12158801] = { elderFaction=true, achievements={ { id=915, index=2, }, },
					quests={ { id=8866, qType="Seasonal", faction="Horde", tip="1) Fly through here, keep to the left", }, }, },
	[24365947] = { elderFaction=true, achievements={ { id=915, index=2, }, }, quests={ { id=8866, qType="Seasonal", faction="Horde",
					tip="2) Drop straight down into here and follow to the left", }, }, },
	[23683637] = { elderFaction=true, achievements={ { id=915, index=2, }, }, quests={ { id=8866, qType="Seasonal", faction="Horde",
					tip="3) Stick your head up a little and assess the situation", }, }, },
}

ns.points[ ns.map.lochModan ] = { -- Loch Modan
	[33334655] = { elder=true, achievements={ { id=912, index=7, version=60000, },
					{ id=912, index=17, versionUnder=60000, }, }, quests={ { id=8642, qType="Seasonal", }, }, },
}

ns.points[ 469 ] = { -- New Tinkertown
	[92376843] = { elder=true, achievements={ { id=912, index=1, version=60000, },
					{ id=912, index=13, versionUnder=60000, }, }, quests={ { id=8653, qType="Seasonal", }, }, },
}

ns.points[ ns.map.northStrangle ] = { -- Northern Stranglethorn
	[71043430] = { elder=true, achievements={ { id=912, index=5, version=60000, },
					{ id=912, index=4, versionUnder=60000, }, },
					quests={ { id=8716, qType="Seasonal", tip="Outside the instance", }, }, },
}

ns.points[ ns.map.searingGorge ] = { -- Searing Gorge
	[21297911] = { elder=true, achievements={ { id=912, index=12, version=60000, },
					{ id=912, index=1, versionUnder=60000, }, }, quests={ { id=8651, qType="Seasonal", }, }, },
	[34898498] = { elderDungeon=true, achievements={ { id=910, index=4, version=60000, },
					{ id=910, index=9, versionUnder=60000, }, },
					quests={ { id=8644, qType="Seasonal", tip="Enter through here and follow the markers", }, }, },
	[34898298] = { elderDungeon=true, achievements={ { id=910, index=5, version=60000, },
					{ id=910, index=11, versionUnder=60000, }, },
					quests={ { id=8619, qType="Seasonal", tip="Enter through here and follow the markers", }, }, },
	[80349331] = { elder=true, achievements={ { id=912, index=10, version=60000, },
					{ id=912, index=16, versionUnder=60000, }, }, quests={ { id=8683, qType="Seasonal", }, }, },
}

ns.points[ ns.map.silvermoon ] = { -- Sivermoon City
	[73068260] = { seasonalQuest=true, name="Lunar Festival Harbinger",
					quests={ { id=8867, qType="Seasonal", }, { id=8883, qType="Seasonal", }, }, },
}

ns.points[ ns.map.silverpine ] = { -- Silverpine Forest
	[44974114] = { elder=true, achievements={ { id=912, index=14, version=60000, },
					{ id=912, index=10, versionUnder=60000, }, }, quests={ { id=8645, qType="Seasonal", }, }, },
	[54013521] = ns.setFSolemnity,
	[54023150] = ns.setFSolemnity,
	[54643194] = ns.setFSolemnity,
	[55823416] = ns.setFSolemnity,
	[56253038] = ns.setFSolemnity,
	[56423502] = ns.setFSolemnity,
	[56452838] = ns.setFSolemnity,
	[56663283] = ns.setFSolemnity,
	[57313581] = ns.setFSolemnity,
	[58603512] = ns.setFSolemnity,
}

ns.points[ ns.map.stormwind ] = { -- Stormwind City
	[79199617] = { seasonalQuest=true, name="Lunar Festival Harbinger", versionUnder=60000,
					quests={ { id=8867, qType="Seasonal", }, { id=8883, qType="Seasonal", }, }, },
	[79839557] = { elderFaction=true, versionUnder=60000, achievements={ { id=915, index=1, }, }, 
					quests={ { id=8646, qType="Seasonal", }, }, },
}

ns.points[ 224 ] = { -- Stranglethorn Vale
	[63282265] = { elder=true, achievements={ { id=912, index=5, version=60000, },
					{ id=912, index=4, versionUnder=60000, }, },
					quests={ { id=8716, qType="Seasonal", tip="Outside the instance", }, }, },
	[37327920] = { elder=true, achievements={ { id=912, index=6, version=60000, },
					{ id=912, index=3, versionUnder=60000, },}, quests={ { id=8674, qType="Seasonal", }, }, },
	[38814669] = ns.setFPeace,
	[40134704] = ns.setFPeace,
	[40874783] = ns.setFPeace,
	[41294516] = ns.setFPeace,
	[41604731] = ns.setFPeace,
	[41954612] = ns.setFPeace,
	[42254482] = ns.setFPeace,
	[42684748] = ns.setFPeace,
	[42904573] = ns.setFPeace,
	[43234966] = ns.setFPeace,
	[94001894] = { elder=true, achievements={ { id=912, index=2, version=60000, },
					{ id=912, index=12, versionUnder=60000, }, }, quests={ { id=8647, qType="Seasonal", }, }, },
}

ns.points[ 317 ] = { -- Stratholme
	[73505480] = { elderDungeon=true, achievements={ { id=910, index=6, version=60000, },
					{ id=910, index=12, versionUnder=60000, }, },
					quests={ { id=8727, qType="Seasonal", tip="Lift the portcullis", }, }, },
	[78622176] = { elderDungeon=true, achievements={ {id=910, index=6, version=60000, },
					{ id=910, index=12, versionUnder=60000, }, },
					quests={ { id=8727, qType="Seasonal", tip="Exit the same way you entered", }, }, },
}

ns.points[ ns.map.swampOS ] = { -- Swamp of Sorrows
	[69425487] = { elderDungeon=true, achievements={ {id=910, index=2, version=60000, },
					{ id=910, index=13, versionUnder=60000, }, }, quests={ { id=8713, qType="Seasonal",
					tip="Enter the Temple of Atal'Hakkar, also known as the Sunken Temple.\n\n1) Descend the twisting path. 2) "
						.."Momentarily submerge into the pool. 3) Resurface and follow the path and enter the portal and follow "
						.."the markers", }, }, },
}

ns.points[ 210 ] = { -- The Cape of Stranglethorn
	[39967251] = { elder=true, achievements={ {id=912, index=6, version=60000, },
					{ id=912, index=3, versionUnder=60000, }, }, quests={ { id=8674, qType="Seasonal", }, }, },
	[42431854] = ns.setFPeace,
	[44611912] = ns.setFPeace,
	[45852043] = ns.setFPeace,
	[46541599] = ns.setFPeace,
	[47071956] = ns.setFPeace,
	[47631759] = ns.setFPeace,
	[48141543] = ns.setFPeace,
	[48851984] = ns.setFPeace,
	[49221694] = ns.setFPeace,
	[49762346] = ns.setFPeace,
}

ns.points[ ns.map.TheHinter ] = { -- The Hinterlands
	[50004805] = { elder=true, achievements={ { id=912, index=11, version=60000, },
					{ id=912, index=5, versionUnder=60000, }, }, quests={ { id=8643, qType="Seasonal", }, }, },
	[49123983] = ns.setFVigor,
	[51853858] = ns.setFVigor,
	[54953518] = ns.setFVigor,
	[59543908] = ns.setFVigor,
	[62224140] = ns.setFVigor,
	[63644153] = ns.setFVigor,
	[65213765] = ns.setFVigor,
	[66234105] = ns.setFVigor,
	[71434483] = ns.setFVigor,
	[73114802] = ns.setFVigor,
	[25530801] = { elder=true, achievements={ { id=912, index=17, version=60000, },
					{ id=912, index=14, versionUnder=60000, }, }, quests={ { id=8714, qType="Seasonal", }, }, },
}

ns.points[ 220 ] = { -- The Temple of Atal'Hakkar
	[63073436] = { elderDungeon=true, achievements={ { id=910, index=2, version=60000, },
					{ id=910, index=13, versionUnder=60000, }, }, quests={ { id=8713, qType="Seasonal", }, }, },
	[50002500] = { elderDungeon=true, achievements={ { id=910, index=2, version=60000, },
					{ id=910, index=13, versionUnder=60000, }, },
					quests={ { id=8713, qType="Seasonal", tip="Head straight for the other marker", }, }, },
}

ns.points[ ns.map.tirisfal ] = { -- Tirisfal Glades
	[61737269] = { seasonalQuest=true, name="Lunar Festival Harbinger", tip="Not in the Undercity. She's above it",
					quests={ { id=8867, qType="Seasonal", }, { id=8883, qType="Seasonal", }, }, },
	[61865391] = { elder=true, achievements={ { id=912, index=13, version=60000, },
					{ id=912, index=2, versionUnder=60000, }, }, quests={ { id=8652, qType="Seasonal", }, }, },
	[61957317] = { elderFaction=true, achievements={ { id=914, index=3, version=60000, },
					{ id=914, index=2, versionUnder=60000, }, }, quests={ { id=8648, qType="Seasonal", }, }, },
	[61817153] = { elderFaction=true, achievements={ { id=914, index=3, version=60000, },
					{ id=914, index=2, versionUnder=60000, }, }, quests={ { id=8648, qType="Seasonal",
					tip="Drop down in to here. Elder Darkcore is a short walk away", }, }, },
	[43259844] = ns.setFSolemnity,
}

ns.points[ 2070 ] = ns.points[ ns.map.tirisfal ] -- Wrong Tirisfal

ns.points[ ns.map.undercity ] = { -- Undercity
	[65613597] = { seasonalQuest=true, name="Lunar Festival Harbinger", tip="Not in the Undercity. She's above it",
					quests={ { id=8867, qType="Seasonal", }, { id=8883, qType="Seasonal", }, }, },
	[66633821] = { elderFaction=true, achievements={ { id=914, index=3, version=60000, },
					{ id=914, index=2, versionUnder=60000, }, }, quests={ { id=8648, qType="Seasonal",
					tip="The achievement text is wrong. Elder Darkcore is NOT in the Undercity. Darkcore is above, in the Ruins "
						.."of Lordaeron", }, }, },
}

ns.points[ ns.map.westfall ] = { -- Westfall
	[56644709] = { elder=true, achievements={ { id=912, index=8, version=60000, },
					{ id=912, index=6, versionUnder=60000, }, },
					quests={ { id=8675, qType="Seasonal", }, }, },
}

ns.points[ ns.map.westernP ] = { -- Western Plaguelands
	[65303876] = { elder=true, achievements={ { id=912, index=4, version=60000, },
					{ id=912, index=11, versionUnder=60000, }, },
					quests={ { id=8722, qType="Seasonal", tip="Enter The Weeping Cave", }, }, },
	[63513611] = { elder=true, achievements={ { id=912, index=4, version=60000, },
					{ id=912, index=11, versionUnder=60000, }, },
					quests={ { id=8722, qType="Seasonal", tip="Inside The Weeping Cave", }, }, },
	[69187345] = { elder=true, achievements={ { id=912, index=17, version=60000, },
					{ id=912, index=14, versionUnder=60000, }, }, quests={ { id=8714, qType="Seasonal", }, }, },
	[04154023] = { elder=true, achievements={ { id=912, index=13, version=60000, },
					{ id=912, index=2, versionUnder=60000, }, }, quests={ { id=8652, qType="Seasonal", }, }, },
	[96255275] = { elder=true, achievements={ { id=912, index=15, version=60000, },
					{ id=912, index=15, versionUnder=60000, }, }, quests={ { id=8688, qType="Seasonal", }, }, },
}

ns.points[ ns.map.easternK ] = { -- Eastern Kingdoms
	[31007600] = { metaLarge=true, achievements={ { id=912, showAllCriteria=true, }, }, noContinent=true, alwaysShow=true, },
	[02501820] = ns.setNewZones,
	[02502250] = ns.setHonorElders,
	[04702530] = ns.setElune,
	[05002100] = ns.setFlavour,
	[05201700] = ns.setMetaFaction,
	[07302400] = ns.setPyro,
	[07601980] = ns.set50Coins,
}

--==================================================================================================================================
--
-- THE BURNING CRUSADE / OUTLAND
--
--==================================================================================================================================

ns.points[ ns.map.shattrath ] = { -- Shattrath
	[48143685] = { seasonalQuest=true, name="Lunar Festival Harbinger",
					quests={ { id=8867, qType="Seasonal", }, { id=8883, qType="Seasonal", }, }, },
	[53293309] = { seasonalQuest=true, name="Lunar Festival Harbinger",
					quests={ { id=8867, qType="Seasonal", }, { id=8883, qType="Seasonal", }, }, },
}

ns.points[ ns.map.terokkar ] = { -- Terokkar Forest
	[30452117] = { seasonalQuest=true, name="Lunar Festival Harbinger",
					quests={ { id=8867, qType="Seasonal", }, { id=8883, qType="Seasonal", }, }, },
}

ns.points[ ns.map.outland ] = { -- Outland
	[02501820] = ns.setNewZones,
	[02502250] = ns.setHonorElders,
	[04702530] = ns.setElune,
	[05002100] = ns.setFlavour,
	[05201700] = ns.setMetaFaction,
	[07302400] = ns.setPyro,
	[07601980] = ns.set50Coins,
}

--==================================================================================================================================
--
-- WRATH OF THE LICH KING / NORTHREND
--
--==================================================================================================================================

ns.points[ 159 ] = { -- Azjol-Nerub - The Guilded Gate
	[54374440] = { elderDungeon=true, achievements={ { id=910, index=9, version=60000, },
					{ id=910, index=4, versionUnder=60000, }, },
					quests={ { id=13022, qType="Seasonal", tip="1) Enter the gate. You must kill the boss", }, }, },
	[66004350] = { elderDungeon=true, achievements={ { id=910, index=9, version=60000, },
					{ id=910, index=4, versionUnder=60000, }, },
					quests={ { id=13022, qType="Seasonal", tip="2) Jump down onto the left side stairs", }, }, },
	[70003450] = { elderDungeon=true, achievements={ { id=910, index=9, version=60000, },
					{ id=910, index=4, versionUnder=60000, }, },
					quests={ { id=13022, qType="Seasonal", tip="3) Go this way", }, }, },
}

ns.points[ 158 ] = { -- Azjol-Nerub - Hadronox's Lair
	[41533715] = { elderDungeon=true, achievements={ { id=910, index=9, version=60000, },
					{ id=910, index=4, versionUnder=60000, }, },
					quests={ { id=13022, qType="Seasonal", tip="3) Go this way", }, }, },
	[61752850] = { elderDungeon=true, achievements={ { id=910, index=9, version=60000, },
					{ id=910, index=4, versionUnder=60000, }, },
					quests={ { id=13022, qType="Seasonal", tip="4) Keep going this way!", }, }, },
	[47176569] = { elderDungeon=true, achievements={ { id=910, index=9, version=60000, },
					{ id=910, index=4, versionUnder=60000, }, },
					quests={ { id=13022, qType="Seasonal", tip="5) Ignore Hadronox. Jump down here", }, }, },
	[49005820] = { elderDungeon=true, achievements={ { id=910, index=9, version=60000, },
					{ id=910, index=4, versionUnder=60000, }, },
					quests={ { id=13022, qType="Seasonal", tip="6) Now jump down again!", }, }, },
}

ns.points[ 157 ] = { -- Azjol-Nerub - The Brood Pt
	[23005217] = { elderDungeon=true, achievements={ { id=910, index=9, version=60000, },
					{ id=910, index=4, versionUnder=60000, }, },
					quests={ { id=13022, qType="Seasonal", tip="7) You land here", }, }, },
	[21724319] = { elderDungeon=true, achievements={ { id=910, index=9, version=60000, },
					{ id=910, index=4, versionUnder=60000, }, },
					quests={ { id=13022, qType="Seasonal", tip="8) Elder is here", }, }, },
	[36854877] = { elderDungeon=true, achievements={ { id=910, index=9, version=60000, },
					{ id=910, index=4, versionUnder=60000, }, },
					quests={ { id=13022, qType="Seasonal", tip="9) Exit is this way", }, }, },
	[75744913] = { elderDungeon=true, achievements={ { id=910, index=9, version=60000, },
					{ id=910, index=4, versionUnder=60000, }, },
					quests={ { id=13022, qType="Seasonal", tip="10) No need to kill Anub'arak", }, }, },
	[88527649] = { elderDungeon=true, achievements={ { id=910, index=9, version=60000, },
					{ id=910, index=4, versionUnder=60000, }, },
					quests={ { id=13022, qType="Seasonal", tip="11) You're welcome! :)", }, }, },
}

ns.points[ 114 ] = { -- Borean Tundra
	[27512594] = { elderDungeon=true, achievements={ { id=910, index=8, version=60000, },
					{ id=910, index=3, versionUnder=60000, }, }, quests={ { id=13021, qType="Seasonal",
					tip="Enter through here and follow the markers.\n\nThe lowest portal is for The Nexus", }, }, },
	[33803436] = { elder=true, achievements={ { id=1396, index=6, version=60000, },
					{ id=1396, index=1, versionUnder=60000, }, }, quests={ { id=13016, qType="Seasonal", }, }, },
	[42934957] = { elder=true, achievements={ { id=1396, index=15, version=60000, },
					{ id=1396, index=5, versionUnder=60000, }, },
					quests={ { id=13029, qType="Seasonal", tip="Actually above the Mightstone Quarry", }, }, },
	[57404372] = { elder=true, achievements={ { id=1396, index=5, version=60000, },
					{ id=1396, index=16, versionUnder=60000, }, }, quests={ { id=13033, qType="Seasonal", }, }, },
	[59096564] = { elder=true, achievements={ { id=1396, index=1, version=60000, },
					{ id=1396, index=6, versionUnder=60000, }, }, quests={ { id=13012, qType="Seasonal", }, }, },
}

ns.points[ 127 ] = { -- Crystalsong Forest
	[92911771] = { elder=true, achievements={ { id=1396, index=13, version=60000, },
					{ id=1396, index=13, versionUnder=60000, }, }, quests={ { id=13028, qType="Seasonal", }, }, },
	[29243808] = { seasonalQuest=true, name="Lunar Festival Harbinger",
					quests={ { id=8867, qType="Seasonal", }, { id=8883, qType="Seasonal", }, }, },
}

ns.points[ 125 ] = { -- Dalaran
	[47654374] = { seasonalQuest=true, name="Lunar Festival Harbinger",
					quests={ { id=8867, qType="Seasonal", }, { id=8883, qType="Seasonal", }, }, },
}

ns.points[ 115 ] = { -- Dragonblight
	[14000484] = { elder=true, achievements={ { id=1396, index=10, version=60000, },
					{ id=1396, index=17, versionUnder=60000, }, },
					quests={ { id=13026, qType="Seasonal", tip=ns.elderBluewolf, }, }, },
	[26134950] = { elderDungeon=true, achievements={ { id=910, index=9, version=60000, },
					{ id=910, index=4, versionUnder=60000, }, }, quests={ { id=13022, qType="Seasonal",
					tip="Drop down here, face south and locate the portal and enter", }, }, },
	[26814899] = { elderDungeon=true, achievements={ { id=910, index=9, version=60000, },
					{ id=910, index=4, versionUnder=60000, }, },
					quests={ { id=13022, qType="Seasonal", tip=ns.elderNurgenExit, }, }, },
	[29755591] = { elder=true, achievements={ { id=1396, index=3, version=60000, },
					{ id=1396, index=4, versionUnder=60000, }, }, quests={ { id=13014, qType="Seasonal", }, }, },
	[35104835] = { elder=true, achievements={ { id=1396, index=17, version=60000, },
					{ id=1396, index=8, versionUnder=60000, }, }, quests={ { id=13031, qType="Seasonal", }, }, },
	[48777817] = { elder=true, achievements={ { id=1396, index=12, version=60000, },
					{ id=1396, index=14, versionUnder=60000, }, }, quests={ { id=13019, qType="Seasonal", }, }, },
}

ns.points[ 161 ] = { -- Drak'Tharon Keep - Drak'Tharon Overlook
	[36554553] = { elderDungeon=true, achievements={ { id=910, index=10, version=60000, },
					{ id=910, index=7, versionUnder=60000, }, }, quests={ { id=13023, qType="Seasonal",
					tip="5) So you did decide to come this way. Awesome! Keep going, it's all linear", }, }, },
	[43271321] = { elderDungeon=true, achievements={ { id=910, index=10, version=60000, },
					{ id=910, index=7, versionUnder=60000, }, }, quests={ { id=13023, qType="Seasonal",
					tip="6) Ignore The Prophet. Just keep going", }, }, },
	[38051726] = { elderDungeon=true, achievements={ { id=910, index=10, version=60000, },
					{ id=910, index=7, versionUnder=60000, }, }, quests={ { id=13023, qType="Seasonal",
					tip="7) Jump down and turn around and you'll see a short hallway then jump again into the water and then "
						.."jump once more into the water!", }, }, },
}

ns.points[ 160 ] = { -- Drak'Tharon Keep - The Vestibules of Drak'Tharon
	[50654047] = { elderDungeon=true, achievements={ { id=910, index=10, version=60000, },
					{ id=910, index=7, versionUnder=60000, }, },
					quests={ { id=13023, qType="Seasonal", tip="1) Go through here", }, }, },
	[60971879] = { elderDungeon=true, achievements={ { id=910, index=10, version=60000, },
					{ id=910, index=7, versionUnder=60000, }, },
					quests={ { id=13023, qType="Seasonal", tip="2) Through here. No need to whoop Trollie", }, }, },
	[67875507] = { elderDungeon=true, achievements={ { id=910, index=10, version=60000, },
					{ id=910, index=7, versionUnder=60000, }, },
					quests={ { id=13023, qType="Seasonal", tip="3) Through here. You can bypass Novos too", }, }, },
	[55636125] = { elderDungeon=true, achievements={ { id=910, index=10, version=60000, },
					{ id=910, index=7, versionUnder=60000, }, },
					quests={ { id=13023, qType="Seasonal", tip="4) Exit here", }, }, },
	[46031310] = { elderDungeon=true, achievements={ { id=910, index=10, version=60000, },
					{ id=910, index=7, versionUnder=60000, }, },
					quests={ { id=13023, qType="Seasonal", tip="8) You made it! Follow the passage. You know the rest!", }, }, },
	[69077927] = { elderDungeon=true, achievements={ { id=910, index=10, version=60000, },
					{ id=910, index=7, versionUnder=60000, }, }, quests={ { id=13023, qType="Seasonal",
					tip="Elder Kilias is located here. Whew! now the exit :(...\n\nA sad choice of backtracking or go up stairs, "
						.."kill the last boss (optional) and jump down. Your call", }, }, },
}

ns.points[ 116 ] = { -- Grizzly Hills
	[60572768] = { elder=true, achievements={ { id=1396, index=2, version=60000, },
					{ id=1396, index=12, versionUnder=60000, }, }, quests={ { id=13013, qType="Seasonal", }, }, },
	[80533711] = { elder=true, achievements={ { id=1396, index=9, version=60000, },
					{ id=1396, index=18, versionUnder=60000, }, }, quests={ { id=13025, qType="Seasonal", }, }, },
	[64184699] = { elder=true, achievements={ { id=1396, index=16, version=60000, },
					{ id=1396, index=10, versionUnder=60000, }, }, quests={ { id=13030, qType="Seasonal", }, }, },
	[17792703] = { elderDungeon=true, achievements={ { id=910, index=10, version=60000, },
					{ id=910, index=7, versionUnder=60000, }, },
					quests={ { id=13023, qType="Seasonal", tip="The portal is through here", }, }, },
}

ns.points[ 154 ] = { -- Gundrak
	[58634038] = { elderDungeon=true, achievements={ { id=910, index=11, version=60000, },
					{ id=910, index=6, versionUnder=60000, }, }, quests={ { id=13065, qType="Seasonal",
					tip="1) Jump in the water and exit here", }, }, },
	[58635714] = { elderDungeon=true, achievements={ { id=910, index=11, version=60000, },
					{ id=910, index=6, versionUnder=60000, }, },
					quests={ { id=13065, qType="Seasonal", tip="2) Through this doorway", }, }, },
	[47007325] = { elderDungeon=true, achievements={ { id=910, index=11, version=60000, },
					{ id=910, index=6, versionUnder=60000, }, },
					quests={ { id=13065, qType="Seasonal", tip="3) This way", }, }, },
	[45556119] = { elderDungeon=true, achievements={ { id=910, index=11, version=60000, },
					{ id=910, index=6, versionUnder=60000, }, },
					quests={ { id=13065, qType="Seasonal", tip="4) After Elder Ohanzee, reverse to exit", }, }, },
}

ns.points[ 140 ] = { -- Halls of Stone
	[29176225] = { elderDungeon=true, achievements={ { id=910, index=12, version=60000, },
					{ id=910, index=5, versionUnder=60000, }, },
					quests={ { id=13066, qType="Seasonal", tip="Here he is!", }, }, },
}

ns.points[ 117 ] = { -- Howling Fjord
	[58854834] = { elderDungeon=true, achievements={ { id=910, index=7, version=60000, },
					{ id=910, index=1, versionUnder=60000, }, },
					quests={ { id=13017, qType="Seasonal", tip="Utgarde Keep is this way. It's at the base", }, }, },
	[57254671] = { elderDungeon=true, achievements={ { id=910, index=13, version=60000, },
					{ id=910, index=2, versionUnder=60000, }, },
					quests={ { id=13067, qType="Seasonal", tip="This is the correct portal. It's up quite high", }, }, },
}

ns.points[ 118 ] = { -- Icecrown
	[10899536] = { elder=true, achievements={ { id=1396, index=7, version=60000, },
					{ id=1396, index=2, versionUnder=60000, }, }, quests={ { id=13018, qType="Seasonal", }, }, },
	[20638522] = { elder=true, achievements={ { id=1396, index=8, version=60000, },
					{ id=1396, index=15, versionUnder=60000, }, }, quests={ { id=13024, qType="Seasonal", }, }, },
	[41499646] = { elder=true, achievements={ { id=1396, index=10, version=60000, },
					{ id=1396, index=17, versionUnder=60000, }, },
					quests={ { id=13026, qType="Seasonal", tip=ns.elderBluewolf, }, }, },
	[90216517] = { elder=true, achievements={ { id=1396, index=4, version=60000, },
					{ id=1396, index=3, versionUnder=60000, }, }, quests={ { id=13015, qType="Seasonal", }, }, },
	[92902422] = { elder=true, achievements={ { id=1396, index=14, version=60000, },
					{ id=1396, index=11, versionUnder=60000, }, }, quests={ { id=13020, qType="Seasonal", }, }, },
}

ns.points[ 119 ] = { -- Sholazar Basin
	[49786362] = { elder=true, achievements={ { id=1396, index=7, version=60000, },
					{ id=1396, index=2, versionUnder=60000, }, }, quests={ { id=13018, qType="Seasonal", }, }, },
	[63804902] = { elder=true, achievements={ { id=1396, index=8, version=60000, },
					{ id=1396, index=15, versionUnder=60000, }, }, quests={ { id=13024, qType="Seasonal", }, }, },
	[93836520] = { elder=true, achievements={ { id=1396, index=10, version=60000, },
					{ id=1396, index=17, versionUnder=60000, }, },
					quests={ { id=13026, qType="Seasonal", tip=ns.elderBluewolf, }, }, },
}

ns.points[ 120 ] = { -- Storm Peaks
	[28897372] = { elder=true, achievements={ { id=1396, index=4, version=60000, },
					{ id=1396, index=3, versionUnder=60000, }, }, quests={ { id=13015, qType="Seasonal", }, }, },
	[41168472] = { elder=true, achievements={ { id=1396, index=13, version=60000, },
					{ id=1396, index=13, versionUnder=60000, }, }, quests={ { id=13028, qType="Seasonal", }, }, },
	[31263761] = { elder=true, achievements={ { id=1396, index=14, version=60000, },
					{ id=1396, index=11, versionUnder=60000, }, }, quests={ { id=13020, qType="Seasonal", }, }, },
	[64595134] = { elder=true, achievements={ { id=1396, index=18, version=60000, },
					{ id=1396, index=7, versionUnder=60000, }, }, quests={ { id=13032, qType="Seasonal",
					tip="BM Hunters doing the Hati quest chain (to get Hati back) will be phased out.\n\nElder Muraco is below "
						.."Camp Tunka'lo", }, }, },
	[39482691] = { elderDungeon=true, achievements={ { id=910, index=12, version=60000, },
					{ id=910, index=5, versionUnder=60000, }, },
					quests={ { id=13066, qType="Seasonal", tip="Enter through here", }, }, },
	[75699264] = { elder=true, achievements={ { id=1396, index=11, version=60000, },
					{ id=1396, index=9, versionUnder=60000, }, }, quests={ { id=13027, qType="Seasonal", }, }, },
	[87776802] = { elderDungeon=true, achievements={ { id=910, index=11, version=60000, },
					{ id=910, index=6, versionUnder=60000, }, }, quests={ { id=13065, qType="Seasonal",
					tip="Use this entrance, not the other one", }, }, },
}

ns.points[ 129 ] = { -- The Nexus
	[38707760] = { elderDungeon=true, achievements={ { id=910, index=8, version=60000, },
					{ id=910, index=3, versionUnder=60000, }, },
					quests={ { id=13021, qType="Seasonal", tip="1) This way!", }, }, },
	[50006600] = { elderDungeon=true, achievements={ { id=910, index=8, version=60000, },
					{ id=910, index=3, versionUnder=60000, }, },
					quests={ { id=13021, qType="Seasonal", tip="2) This way!", }, }, },
	[61505220] = { elderDungeon=true, achievements={ { id=910, index=8, version=60000, },
					{ id=910, index=3, versionUnder=60000, }, },
					quests={ { id=13021, qType="Seasonal", tip="3) This way!", }, }, },
	[61906400] = { elderDungeon=true, achievements={ { id=910, index=8, version=60000, },
					{ id=910, index=3, versionUnder=60000, }, },
					quests={ { id=13021, qType="Seasonal", tip="4) This way!", }, }, },
	[54976461] = { elderDungeon=true, achievements={ { id=910, index=8, version=60000, },
					{ id=910, index=3, versionUnder=60000, }, },
					quests={ { id=13021, qType="Seasonal", tip="5) He is here", }, }, },
	[52756990] = { elderDungeon=true, achievements={ { id=910, index=8, version=60000, },
					{ id=910, index=3, versionUnder=60000, }, }, quests={ { id=13021, qType="Seasonal",
					tip="6) Come up this way for a shortcut exit!", }, }, },
}

ns.points[ 133 ] = { -- Utgarde Keep - Njorndir Preparation
	[50652851] = { elderDungeon=true, achievements={ { id=910, index=7, version=60000, },
					{ id=910, index=1, versionUnder=60000, }, }, quests={ { id=13017, qType="Seasonal",
					tip="1) Defeat Dragonflayer Forgemasters to remove the flaming wall barriers", }, }, },
	[23047190] = { elderDungeon=true, achievements={ { id=910, index=7, version=60000, },
					{ id=910, index=1, versionUnder=60000, }, },
					quests={ { id=13017, qType="Seasonal", tip="2) Through this way", }, }, },
	[47236936] = { elderDungeon=true, achievements={ { id=910, index=7, version=60000, },
					{ id=910, index=1, versionUnder=60000, }, }, quests={ { id=13017, qType="Seasonal",
					tip="3) And when done, just retrace your steps", }, }, },
}

ns.points[ 136 ] = { -- Utgarde Pinnacle - Lower Pinnacle
	[45858315] = { elderDungeon=true, achievements={ { id=910, index=13, version=60000, },
					{ id=910, index=2, versionUnder=60000, }, },
					quests={ { id=13067, qType="Seasonal", tip="3) Up the stairs", }, }, },
	[56112473] = { elderDungeon=true, achievements={ { id=910, index=13, version=60000, },
					{ id=910, index=2, versionUnder=60000, }, },
					quests={ { id=13067, qType="Seasonal", tip="8) Now that you're done, it's easiest to keep going", }, }, },
	[49154425] = { elderDungeon=true, achievements={ { id=910, index=13, version=60000, },
					{ id=910, index=2, versionUnder=60000, }, },
					quests={ { id=13067, qType="Seasonal", tip="9) Up the ramp", }, }, },
	[48672327] = { elderDungeon=true, achievements={ { id=910, index=13, version=60000, },
					{ id=910, index=2, versionUnder=60000, }, },
					quests={ { id=13067, qType="Seasonal", tip="Elder is here", }, }, },
}

ns.points[ 137 ] = { -- Utgarde Pinnacle - Upper Pinnacle
	[40033590] = { elderDungeon=true, achievements={ { id=910, index=13, version=60000, },
					{ id=910, index=2, versionUnder=60000, }, },
					quests={ { id=13067, qType="Seasonal", tip="1) Through this way", }, }, },
	[39906910] = { elderDungeon=true, achievements={ { id=910, index=13, version=60000, },
					{ id=910, index=2, versionUnder=60000, }, }, quests={ { id=13067, qType="Seasonal",
					tip="2) Keep going, ignore Svala, she appears to have enough of her own problems", }, }, },
	[64276947] = { elderDungeon=true, achievements={ { id=910, index=13, version=60000, },
					{ id=910, index=2, versionUnder=60000, }, },
					quests={ { id=13067, qType="Seasonal", tip="4) This way", }, }, },
	[68893930] = { elderDungeon=true, achievements={ { id=910, index=13, version=60000, },
					{ id=910, index=2, versionUnder=60000, }, }, quests={ { id=13067, qType="Seasonal",
					tip="5) You've got to do this fight. Kill mobs here. They randomly drop harpoons. Use the harpoon launcher to "
						.."kill Grauf. Probably three shots. Skadi dismounts. You kill Skadi", }, }, },
	[64153634] = { elderDungeon=true, achievements={ { id=910, index=13, version=60000, },
					{ id=910, index=2, versionUnder=60000, }, },
					quests={ { id=13067, qType="Seasonal", tip="6) The portcullis is now open", }, }, },
	[58633831] = { elderDungeon=true, achievements={ { id=910, index=13, version=60000, },
					{ id=910, index=2, versionUnder=60000, }, },
					quests={ { id=13067, qType="Seasonal", tip="7) Jump down", }, }, },
	[44114416] = { elderDungeon=true, achievements={ { id=910, index=13, version=60000, },
					{ id=910, index=2, versionUnder=60000, }, }, quests={ { id=13067, qType="Seasonal",
					tip="10) Kill Ymiron to open the portcullis. Straight through and exit", }, }, },
}

ns.points[ 123 ] = { -- Wintergrasp
	[50001627] = { elder=true, achievements={ { id=1396, index=10, version=60000, },
					{ id=1396, index=17, versionUnder=60000, }, },
					quests={ { id=13026, qType="Seasonal", tip=ns.elderBluewolf, }, }, },
	[49491452] = { elder=true, achievements={ { id=1396, index=10, version=60000, },
					{ id=1396, index=17, versionUnder=60000, }, }, quests={ { id=13026, qType="Seasonal",
					tip="Glitch Guide: 1) You MUST stand exactly here with your face buried into the corner.\n\n"
					.."If that is not possible then you are on the wrong ledge - fly around a bit.\n\n"
					.."With your face buried in the corner you must use a \"Lounge Cushion\" toy such as the "
					.."\"Pineapple\", \"Safari\" or \"Zhevra\".\n\nYou may receive a warning you are going to "
					.."be teleported outside Wintergrasp, so don't muck around!\n\nYou are now \"inside\". "
					.."The problem now is to stand up. Blizzard stopped that. A mage blink works though. YMMV", }, }, },
	[49471373] = { elder=true, achievements={ { id=1396, index=10, version=60000, },
					{ id=1396, index=17, versionUnder=60000, }, }, quests={ { id=13026, qType="Seasonal",
					tip="Glitch Guide: 2) After using your Lounge Cushion, walk exactly to here and rotate "
					.."your downwards view so that you can see the glitched interior.\n\n"
					.."If standing here then facing at about 201 degrees (my \"X and Y\" AddOn shows "
					.."degrees) you can jump down onto a circular raised ledge.\n\nCannot see the interior? "
					.."Just jump down blindly!\n\nContinue with the Elder then use the Violet Citadel "
					.."portal or the Defender's Portal", }, }, },
	[74149952] = { elderDungeon=true, achievements={ { id=910, index=9, version=60000, },
					{ id=910, index=4, versionUnder=60000, }, },
					quests={ { id=13022, qType="Seasonal", tip=ns.elderNurgenExit, }, }, },
	[89779830] = { elder=true, achievements={ { id=1396, index=17, version=60000, },
					{ id=1396, index=8, versionUnder=60000, }, }, quests={ { id=13031, qType="Seasonal", }, }, },
}

ns.points[ 121 ] = { -- Zul'Drak
	[58915597] = { elder=true, achievements={ { id=1396, index=11, version=60000, },
					{ id=1396, index=9, versionUnder=60000, }, }, quests={ { id=13027, qType="Seasonal", }, }, },
	[28978375] = { elderDungeon=true, achievements={ { id=910, index=10, version=60000, },
					{ id=910, index=7, versionUnder=60000, }, },
					quests={ { id=13023, qType="Seasonal", tip="The portal is through here", }, }, },
	[76112091] = { elderDungeon=true, achievements={ { id=910, index=11, version=60000, },
					{ id=910, index=6, versionUnder=60000, }, }, quests={ { id=13065, qType="Seasonal",
					tip="Use this entrance, not the other one." ..ns.taraezorPromo, }, }, },
	[73899374] = { elder=true, achievements={ { id=1396, index=2, version=60000, },
					{ id=1396, index=12, versionUnder=60000, }, }, quests={ { id=13013, qType="Seasonal", }, }, },
	[09734470] = { elder=true, achievements={ { id=1396, index=13, version=60000, },
					{ id=1396, index=13, versionUnder=60000, }, }, quests={ { id=13028, qType="Seasonal", }, }, },
}

ns.points[ 113 ] = { -- Northrend
	[23008600] = { metaLarge=true, achievements={ { id=1396, showAllCriteria=true, }, }, noContinent=true, alwaysShow=true, },
	[02501820] = ns.setNewZones,
	[02502250] = ns.setHonorElders,
	[04702530] = ns.setElune,
	[05002100] = ns.setFlavour,
	[05201700] = ns.setMetaFaction,
	[07302400] = ns.setPyro,
	[07601980] = ns.set50Coins,
}

--==================================================================================================================================
--
-- CATACLYSM
--
--==================================================================================================================================

ns.points[ 207 ] = { -- Deepholm
	[49705488] = { elder=true, achievements={ { id=6006, index=1, version=60000, },
					{ id=6006, index=5, versionUnder=60000, }, }, quests={ { id=29735, qType="Seasonal", }, }, },
	[27706918] = { elder=true, achievements={ { id=6006, index=9, version=60000, },
					{ id=6006, index=9, versionUnder=60000, }, }, quests={ { id=29734, qType="Seasonal", }, }, },
}

ns.points[ 198 ] = { -- Mount Hyjal
	[26696205] = { elder=true, achievements={ { id=6006, index=6, version=60000, },
					{ id=6006, index=6, versionUnder=60000, }, }, quests={ { id=29739, qType="Seasonal", }, }, },
	[62542282] = { elder=true, achievements={ { id=6006, index=7, version=60000, },
					{ id=6006, index=7, versionUnder=60000, }, }, quests={ { id=29740, qType="Seasonal", }, }, },
	[60522631] = { preservation=true, tip="Nordrassil Moonwell",
					quests={ { id=56842, index=8, name="Lunar Preservation", version=80205, qType="One Time", }, }, },
}

ns.points[ 205 ] = { -- Shimmering Expanse in Vashj'ir
	[57258614] = { elder=true, achievements={ { id=6006, index=8, version=60000, },
					{ id=6006, index=2, versionUnder=60000, }, }, quests={ { id=29738, qType="Seasonal", }, }, },
}

ns.points[ 948 ] = { -- The Maelstrom
	-- Cannot auto populate as a pseudo Continent. Must do it manually. Used a gradient of -0.65 for the two points
	[50903050] = { elder=true, achievements={ { id=6006, index=1, version=60000, },
					{ id=6006, index=5, versionUnder=60000, }, }, quests={ { id=29735, qType="Seasonal", }, }, },
	[44503470] = { elder=true, achievements={ { id=6006, index=9, version=60000, },
					{ id=6006, index=9, versionUnder=60000, }, }, quests={ { id=29734, qType="Seasonal", }, }, },
}

ns.points[ 241 ] = { -- Twilight Highlands
	[50917045] = { elder=true, achievements={ { id=6006, index=4, version=60000, },
					{ id=6006, index=8, versionUnder=60000, }, }, quests={ { id=29737, qType="Seasonal", }, }, },
	[51883307] = { elder=true, achievements={ { id=6006, index=5, version=60000, },
					{ id=6006, index=3, versionUnder=60000, }, }, quests={ { id=29736, qType="Seasonal", }, }, },
}

ns.points[ 249 ] = { -- Uldum
	[65521866] = { elder=true, achievements={ { id=6006, index=2, version=60000, },
					{ id=6006, index=4, versionUnder=60000, }, }, quests={ { id=29742, qType="Seasonal", }, }, },
	[31586298] = { elder=true, achievements={ { id=6006, index=3, version=60000, },
					{ id=6006, index=1, versionUnder=60000, }, }, quests={ { id=29741, qType="Seasonal", }, }, },
	[83793788] = { elder=true, noZidormi=true, achievements={ { id=911, index=15, version=60000, },			
					{ id=911, index=13, versionUnder=60000, }, }, quests={ { id=8671, qType="Seasonal", }, }, },
}

ns.points[ 1527 ] = { -- Wrong Uldum
	[65521866] = { elder=true, achievements={ { id=6006, index=2, version=60000, },
					{ id=6006, index=4, versionUnder=60000, }, }, quests={ { id=29742, qType="Seasonal", }, }, },
	[31586298] = { elder=true, achievements={ { id=6006, index=3, version=60000, },
					{ id=6006, index=1, versionUnder=60000, }, }, quests={ { id=29741, qType="Seasonal", }, }, },
	[83793788] = { elder=true, noZidormi=true, achievements={ { id=911, index=15, version=60000, },			
					{ id=911, index=13, versionUnder=60000, }, }, quests={ { id=8671, qType="Seasonal", }, }, },
}

--==================================================================================================================================
--
-- MISTS OF PANDARIA
--
--==================================================================================================================================

ns.points[ 501 ] = { -- The Situation in Dalaran
	[47654374] = { seasonalQuest=true, name="Lunar Festival Harbinger",
					quests={ { id=8867, qType="Seasonal", }, { id=8883, qType="Seasonal", }, }, },
}

ns.points[ 390 ] = { -- Vale of Eternal Blossoms
	[62921928] = { seasonalQuest=true, name="Lunar Festival Harbinger",
					quests={ { id=8867, qType="Seasonal", }, { id=8883, qType="Seasonal", }, }, },
	[85296487] = { seasonalQuest=true, name="Lunar Festival Harbinger",
					quests={ { id=8867, qType="Seasonal", }, { id=8883, qType="Seasonal", }, }, },
}

ns.points[ 424 ] = { -- Pandaria
	[23008600] = { metaLarge=true, achievements={ { id=1396, showAllCriteria=true, }, }, noContinent=true, alwaysShow=true, },
	[02501820] = ns.setNewZones,
	[02502250] = ns.setHonorElders,
	[04702530] = ns.setElune,
	[05002100] = ns.setFlavour,
	[05201700] = ns.setMetaFaction,
	[07302400] = ns.setPyro,
	[07601980] = ns.set50Coins,
}

--==================================================================================================================================
--
-- WARLORDS OF DRAENOR / GARRISON
--
--==================================================================================================================================

ns.points[ 572 ] = { -- Draenor
	[02501820] = ns.setNewZones,
	[02502250] = ns.setHonorElders,
	[04702530] = ns.setElune,
	[05002100] = ns.setFlavour,
	[05201700] = ns.setMetaFaction,
	[07302400] = ns.setPyro,
	[07601980] = ns.set50Coins,
}

--==================================================================================================================================
--
-- LEGION / BROKEN ISLES
--
--==================================================================================================================================

ns.points[ 619 ] = { -- Broken Isles
	[02501820] = ns.setNewZones,
	[02502250] = ns.setHonorElders,
	[04702530] = ns.setElune,
	[05002100] = ns.setFlavour,
	[05201700] = ns.setMetaFaction,
	[07302400] = ns.setPyro,
	[07601980] = ns.set50Coins,
}

--==================================================================================================================================
--
-- BATTLE FOR AZEROTH / KUL TIRAS & ZANDALAR
--
--==================================================================================================================================

ns.points[ 876 ] = { -- Kul Tiras
	[02501820] = ns.setNewZones,
	[02502250] = ns.setHonorElders,
	[04702530] = ns.setElune,
	[05002100] = ns.setFlavour,
	[05201700] = ns.setMetaFaction,
	[07302400] = ns.setPyro,
	[07601980] = ns.set50Coins,
}

ns.points[ 875 ] = { -- Zandalar
	[02501820] = ns.setNewZones,
	[02502250] = ns.setHonorElders,
	[04702530] = ns.setElune,
	[05002100] = ns.setFlavour,
	[05201700] = ns.setMetaFaction,
	[07302400] = ns.setPyro,
	[07601980] = ns.set50Coins,
}

--==================================================================================================================================
--
-- SHADOWLANDS
--
--==================================================================================================================================

ns.points[ 1550 ] = { -- Shadowlands
	[02501820] = ns.setNewZones,
	[02502250] = ns.setHonorElders,
	[04702530] = ns.setElune,
	[05002100] = ns.setFlavour,
	[05201700] = ns.setMetaFaction,
	[07302400] = ns.setPyro,
	[07601980] = ns.set50Coins,
}

--==================================================================================================================================
--
-- DRAGONFLIGHT / DRAGON ISLES
--
--==================================================================================================================================

ns.points[ 2023 ] = { -- Ohn'ahran Plains
	[58413146] = { elder=true, achievements={ { id=17321, index=4, }, }, quests={ { id=73717, qType="Seasonal", }, }, },
	[83894802] = { elder=true, achievements={ { id=17321, index=3, }, }, quests={ { id=73172, qType="Seasonal", }, }, },
}

ns.points[ 2025 ] = { -- Thaldraszus
	[54854347] = { elder=true, achievements={ { id=17321, index=7, }, }, quests={ { id=73859, qType="Seasonal", }, }, },
	[50066652] = { elder=true, achievements={ { id=17321, index=8, }, }, quests={ { id=73861, qType="Seasonal", }, }, },
	[07136478] = { elder=true, achievements={ { id=17321, index=4, }, }, quests={ { id=73717, qType="Seasonal", }, }, },
	[19743301] = { elder=true, achievements={ { id=17321, index=2, }, }, quests={ { id=73716, qType="Seasonal", }, }, },
	[21600740] = { elder=true, achievements={ { id=17321, index=1, }, }, quests={ { id=73848, qType="Seasonal", }, }, },
	[26207718] = { elder=true, achievements={ { id=17321, index=3, }, }, quests={ { id=73172, qType="Seasonal", }, }, },
}

ns.points[ 2024 ] = { -- The Azure Span
	[12894905] = { elder=true, achievements={ { id=17321, index=5, }, }, quests={ { id=73858, qType="Seasonal", }, }, },
	[67414947] = { elder=true, achievements={ { id=17321, index=6, }, }, quests={ { id=73860, qType="Seasonal", }, }, },
	[46180105] = { elder=true, achievements={ { id=17321, index=3, }, }, quests={ { id=73172, qType="Seasonal", }, }, },
}

ns.points[ 2022 ] = { -- The Waking Shores
	[46663131] = { elder=true, achievements={ { id=17321, index=1, }, }, quests={ { id=73848, qType="Seasonal", }, }, },
	[44306380] = { elder=true, achievements={ { id=17321, index=2, }, }, quests={ { id=73716, qType="Seasonal", }, }, },
	[88857707] = { elder=true, achievements={ { id=17321, index=7, }, }, quests={ { id=73859, qType="Seasonal", }, }, },
}

ns.points[ 1978 ] = { -- Dragon Isles
	[85003000] = { metaLarge=true, achievements={ { id=17321, showAllCriteria=true, }, }, noContinent=true, alwaysShow=true, },
	[02501820] = ns.setNewZones,
	[02502250] = ns.setHonorElders,
	[04702530] = ns.setElune,
	[05002100] = ns.setFlavour,
	[05201700] = ns.setMetaFaction,
	[07302400] = ns.setPyro,
	[07601980] = ns.set50Coins,
}

--==================================================================================================================================
--
-- THE WAR WITHIN / KHAZ ALGAR
--
--==================================================================================================================================

ns.points[ 2255 ] = { -- Azj-Kahet
	[66918553] = { elder=true, achievements={ { id=41130, index=7, }, }, quests={ { id=85935, qType="Seasonal", }, }, },
	[46825721] = { elder=true, achievements={ { id=41130, index=8, }, }, quests={ { id=85936, qType="Seasonal", }, }, },
}

ns.points[ 2215 ] = { -- Hallowfall
	[25885193] = { elder=true, achievements={ { id=41130, index=5, }, }, quests={ { id=85933, qType="Seasonal", }, }, },
	[66274628] = { elder=true, achievements={ { id=41130, index=6, }, }, quests={ { id=85934, qType="Seasonal", }, }, },
}

ns.points[ 2248 ] = { -- Isle of Dorn
	[40918735] = { elder=true, achievements={ { id=41130, index=1, }, }, quests={ { id=85929, qType="Seasonal", }, }, },
	[48621395] = { elder=true, achievements={ { id=41130, index=2, }, }, quests={ { id=85930, qType="Seasonal", }, }, },
}

ns.points[ 2214 ] = { -- The Ringing Deeps
	[48906730] = { elder=true, achievements={ { id=41130, index=3, }, }, quests={ { id=85931, qType="Seasonal", }, }, },
	[67295298] = { elder=true, achievements={ { id=41130, index=4, }, }, quests={ { id=85932, qType="Seasonal", }, }, },
}

ns.points[ 2274 ] = { -- Khaz Algar
	[50348484] = { elder=true, achievements={ { id=41130, index=7, }, }, quests={ { id=85935, qType="Seasonal", }, }, },
	[43157606] = { elder=true, achievements={ { id=41130, index=8, }, }, quests={ { id=85936, qType="Seasonal", }, }, },
	[29065408] = { elder=true, achievements={ { id=41130, index=5, }, }, quests={ { id=85933, qType="Seasonal", }, }, },
	[45345183] = { elder=true, achievements={ { id=41130, index=6, }, }, quests={ { id=85934, qType="Seasonal", }, }, },
	[68014019] = { elder=true, achievements={ { id=41130, index=1, }, }, quests={ { id=85929, qType="Seasonal", }, }, },
	[71360702] = { elder=true, achievements={ { id=41130, index=2, }, }, quests={ { id=85930, qType="Seasonal", }, }, },
	[53446488] = { elder=true, achievements={ { id=41130, index=3, }, }, quests={ { id=85931, qType="Seasonal", }, }, },
	[61666176] = { elder=true, achievements={ { id=41130, index=4, }, }, quests={ { id=85932, qType="Seasonal", }, }, },
	[13008400] = { metaLarge=true, noCoords=true, achievements={ { id=41130, showAllCriteria=true, }, }, alwaysShow=true, },
	[02501820] = ns.setNewZones,
	[02502250] = ns.setHonorElders,
	[04702530] = ns.setElune,
	[05002100] = ns.setFlavour,
	[05201700] = ns.setMetaFaction,
	[07302400] = ns.setPyro,
	[07601980] = ns.set50Coins,
}

--==================================================================================================================================
--
-- WORLD / OTHER
--
--==================================================================================================================================

if ( ns.version < 60000 ) then
	ns.points[ 947 ] = { -- Azeroth
		[09007600] = { metaLarge=true, versionUnder=100000, achievements={ { id=911, showAllCriteria=true, }, },
					alwaysShow=true, }, -- Kalimdor
		[43003400] = { metaLarge=true, versionUnder=100000, achievements={ { id=1396, showAllCriteria=true, }, },
					alwaysShow=true, }, -- Northrend
		[45004700] = { metaLarge=true, versionUnder=100000, achievements={ { id=6006, showAllCriteria=true, }, },
					alwaysShow=true, }, -- Cataclysm
		[68507600] = { metaLarge=true, versionUnder=100000, achievements={ { id=912, showAllCriteria=true, }, },
					alwaysShow=true, }, -- E. Kingdoms
		[51305190] = { elder=true, achievements={ { id=6006, index=1, version=60000, }, -- Gradient -0.65
						{ id=6006, index=5, versionUnder=60000, }, }, quests={ { id=29735, qType="Seasonal", }, }, },
		[48705360] = { elder=true, achievements={ { id=6006, index=9, version=60000, },
						{ id=6006, index=9, versionUnder=60000, }, }, quests={ { id=29734, qType="Seasonal", }, }, },
	} 
else
	ns.points[ 947 ] = { -- Azeroth
		[08006700] = { metaLarge=true, version=100000, achievements={ { id=911, showAllCriteria=true, }, },
					alwaysShow=true, }, -- Kalimdor
		[21009100] = { metaLarge=true, version=110000, achievements={ { id=41130, showAllCriteria=true, }, },
					alwaysShow=true, }, -- Khaz Algar
		[42004500] = { metaLarge=true, version=100000, achievements={ { id=6006, showAllCriteria=true, }, },
					alwaysShow=true, }, -- Cataclysm
		[44002500] = { metaLarge=true, version=100000, achievements={ { id=1396, showAllCriteria=true, }, },
					alwaysShow=true, }, -- Northrend
		[78006700] = { metaLarge=true, version=100000, achievements={ { id=912, showAllCriteria=true, }, },
					alwaysShow=true, }, -- Eastern Kingdoms
		[88001750] = { metaLarge=true, version=100000, achievements={ { id=17321, showAllCriteria=true, }, },
					alwaysShow=true, }, -- Dragon Isles
		[46004850] = { elder=true, achievements={ { id=6006, index=1, version=60000, }, -- Gradient -0.65
						{ id=6006, index=5, versionUnder=60000, }, }, quests={ { id=29735, qType="Seasonal", }, }, },
		[44504950] = { elder=true, achievements={ { id=6006, index=9, version=60000, },
						{ id=6006, index=9, versionUnder=60000, }, }, quests={ { id=29734, qType="Seasonal", }, }, },
	}
end

--==================================================================================================================================
--
-- TEXTURES
--
-- These textures are all repurposed and as such have non-uniform sizing. In order to homogenise the sizes. I should also allow for
-- non-uniform origin placement as well as adjust the x,y offsets
--==================================================================================================================================

ns.textures[1] = "Interface\\PlayerFrame\\MonkLightPower"
ns.textures[2] = "Interface\\PlayerFrame\\MonkDarkPower"
ns.textures[3] = "Interface\\Common\\Indicator-Red"
ns.textures[4] = "Interface\\Common\\Indicator-Yellow"
ns.textures[5] = "Interface\\Common\\Indicator-Green"
ns.textures[6] = "Interface\\Common\\Indicator-Gray"
ns.textures[7] = "Interface\\AddOns\\HandyNotes_LunarFestival\\CoinOfAncestryBlue"
ns.textures[8] = "Interface\\AddOns\\HandyNotes_LunarFestival\\CoinOfAncestryDeepGreen"
ns.textures[9] = "Interface\\AddOns\\HandyNotes_LunarFestival\\CoinOfAncestryDeepPink"
ns.textures[10] = "Interface\\AddOns\\HandyNotes_LunarFestival\\CoinOfAncestryDeepRed"
ns.textures[11] = "Interface\\AddOns\\HandyNotes_LunarFestival\\CoinOfAncestryGreen"
ns.textures[12] = "Interface\\AddOns\\HandyNotes_LunarFestival\\CoinOfAncestryLightBlue"
ns.textures[13] = "Interface\\AddOns\\HandyNotes_LunarFestival\\CoinOfAncestryPink"
ns.textures[14] = "Interface\\AddOns\\HandyNotes_LunarFestival\\CoinOfAncestryPurple"
ns.textures[15] = "Interface\\AddOns\\HandyNotes_LunarFestival\\CoinOfAncestryTeal"
ns.textures[16] = "Interface\\AddOns\\HandyNotes_LunarFestival\\CoinOfAncestry"

ns.scaling[1] = 0.55
ns.scaling[2] = 0.55
ns.scaling[3] = 0.55
ns.scaling[4] = 0.55
ns.scaling[5] = 0.55
ns.scaling[6] = 0.55
ns.scaling[7] = 0.4
ns.scaling[8] = 0.4
ns.scaling[9] = 0.4
ns.scaling[10] = 0.4
ns.scaling[11] = 0.4
ns.scaling[12] = 0.4
ns.scaling[13] = 0.4
ns.scaling[14] = 0.4
ns.scaling[15] = 0.4
ns.scaling[16] = 0.4