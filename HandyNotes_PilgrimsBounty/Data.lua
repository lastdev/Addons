local _, ns = ...
ns.points = {}
ns.achievementIQ = {}
ns.addOnName = "PilgrimsBounty" -- For internal use to name globals etc. Should never be localised
ns.eventName = "Pilgrim's Bounty" -- The player sees this in labels and titles. This gets localised

ns.aoa = {}
--ns.aoa[ 1034 ] = { acctOnly = true }

ns.dailyA = "Daily Guide placeholder Ally"
ns.dailyH = "Daily Guide placeholder Horde"
ns.seasonalA = "Seasonal Guide placeholder Ally"
ns.seasonalH = "Seasonal Guide placeholder Horde"

ns.nowCookin = "This is a convenient location to purchase recipes, cook and level Classic Cooking"
ns.sharing = "At each table there are five dishes. Eat each of these five times. Spam it!"
ns.paunch = ns.sharing .." Repeat this at each capital city"
ns.shareCare = "At any Table, sit in each chair and pass that chair's food to another chair or player"

-- Bountiful Tables (Check again if checked already)
-- Horde: Bloodhoof Village (I checked already! Removed?), Falconwing Square, Hammerfall (I checked already! Removed?), Razor Hill, 
--			Sepulcher, Shadowprey Village, Stonard, Tarren Mill, Tranquillien
-- Alliance: Azure Watch (I checked already! Removed?), Southshore (I checked already! Removed?)
-- Neutral: Ruins of Thaurissan (Burning Steppes. I checked already! Removed?)

--==================================================================================================================================
--
-- KALIMDOR
--
--==================================================================================================================================

ns.points[ ns.map.ashenvale ] = { -- Ashenvale
	[22219116] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.azuremyst ] = { -- Azuremyst Isle
	[33774352] = { bountifulTable=true, faction="Alliance", tip="Just outside the main entrance.\nThere are four tables",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, },
					{ id=3576, showAllCriteria=true, guide=ns.nowCookin, }, { id=3556, showAllCriteria=true, guide=ns.paunch, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.darkshore ] = { -- Darkshore
	[50581865] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.darnassus ] = { -- Darnassus
	[61904617] = { npc=true, name="Mary Allerton", faction="Alliance",
					quests={ { id=14054, name="Easy As Pie", qType="Daily", guide=ns.dailyA, }, }, },
	[61484910] = { npc=true, name="Isaac Allerton", faction="Alliance",
					quests={ { id=14033, faction="Alliance", name="Candied Sweet Potatoes", qType="Seasonal",
						guide=ns.seasonalA, }, }, },
	[63944687] = { bountifulTable=true, faction="Alliance", tip="Just outside the Warrior's Terrace.\nThere are four tables",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, },
						{ id=3576, showAllCriteria=true, guide=ns.nowCookin, guide=ns.nowCookin },
						{ id=3556, showAllCriteria=true, guide=ns.paunch, guide=ns.sharing, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.desolace ] = { -- Desolace
	[25407209] = { bountifulTable=true, faction="Horde",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[65190873] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[89685908] = { bountifulTable=true, faction="Horde", tip="There are four tables",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, },
						{ id=3577, showAllCriteria=true, guide=ns.nowCookin, guide=ns.nowCookin },
						{ id=3557, showAllCriteria=true, guide=ns.paunch, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[89835823] = { npc=true, name="Dokin Farplain", faction="Horde",
					quests={ { id=14043, name="Candied Sweet Potatoes", qType="Seasonal", guide=ns.seasonalH, }, }, },
	[89855963] = { name="Mahara Goldwheat", faction="Horde",
					quests={ { id=14060, name="Easy As Pie", qType="Daily", guide=ns.dailyH, }, }, },
}

ns.points[ ns.map.durotar ] = { -- Durotar
	[46371385] = { name="Ondani Greatmill", faction="Horde",
					quests={ { id=14062, name="Don't Forget The Stuffing!", qType="Daily", }, 
						{ id=14061, name="Can't Get Enough Turkey", qType="Daily", guide=ns.dailyH, }, }, },
	[46591380] = { npc=true, name="Francis Eaton", faction="Horde",
					quests={ { id=14041, name="Cranberry Chutney", qType="Seasonal", }, 
						{ id=14044, name="Undersupplied in the Undercity", qType="Seasonal", guide=ns.seasonalH, }, }, },
	[46671502] = { bountifulTable=true, faction="Horde", tip="There are four tables",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, },
						{ id=3577, showAllCriteria=true, guide=ns.nowCookin, guide=ns.nowCookin },
						{ id=3557, showAllCriteria=true, guide=ns.paunch, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[53104407] = { bountifulTable=true, faction="Horde", tip="There are two tables",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[12106204] = { bountifulTable=true, faction="Horde",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[33037881] = { bountifulTable=true, faction="Horde",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[33337883] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.dustwallow ] = { -- Dustwallow Marsh
	[68005078] = { bountifulTable=true, faction="Alliance", tip="Must be the old Theramore",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, tip="Something here" }, }, },
}

ns.points[ ns.map.feralas ] = { -- Feralas
	[46924534] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[74884334] = { bountifulTable=true, faction="Horde",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },

	[67799642] = { bountifulTable=true, tip="Must be the old Silithus",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.mulgore ] = { -- Mulgore
	[36753166] = { bountifulTable=true, faction="Horde", tip="There are four tables",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, },
						{ id=3577, showAllCriteria=true, guide=ns.nowCookin, guide=ns.nowCookin },
						{ id=3557, showAllCriteria=true, guide=ns.paunch, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[36873096] = { npc=true, name="Dokin Farplain", faction="Horde",
					quests={ { id=14043, name="Candied Sweet Potatoes", qType="Seasonal", guide=ns.seasonalH, }, }, },
	[36893212] = { name="Mahara Goldwheat", faction="Horde",
					quests={ { id=14060, name="Easy As Pie", qType="Daily", guide=ns.dailyH, }, }, },
	[46455921] = { bountifulTable=true, faction="Horde",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },

	[88190578] = { bountifulTable=true, faction="Horde",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.barrens ] = { -- Northern Barrens / The Barrens
	[00018169] = { bountifulTable=true, faction="Horde", tip="There are four tables",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, },
						{ id=3577, showAllCriteria=true, guide=ns.nowCookin, guide=ns.nowCookin },
						{ id=3557, showAllCriteria=true, guide=ns.paunch, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[00138102] = { npc=true, name="Dokin Farplain", faction="Horde",
					quests={ { id=14043, name="Candied Sweet Potatoes", qType="Seasonal", guide=ns.seasonalH, }, }, },
	[00148212] = { name="Mahara Goldwheat", faction="Horde",
					quests={ { id=14060, name="Easy As Pie", qType="Daily", guide=ns.dailyH, }, }, },
	[48805714] = { bountifulTable=true, faction="Horde",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[68077256] = { bountifulTable=true, faction="Horde",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[68347259] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[80341280] = { name="Ondani Greatmill", faction="Horde",
					quests={ { id=14062, name="Don't Forget The Stuffing!", qType="Daily", }, 
						{ id=14061, name="Can't Get Enough Turkey", qType="Daily", guide=ns.dailyH, }, }, },
	[80541275] = { npc=true, name="Francis Eaton", faction="Horde",
					quests={ { id=14041, name="Cranberry Chutney", qType="Seasonal", }, 
						{ id=14044, name="Undersupplied in the Undercity", qType="Seasonal", guide=ns.seasonalH, }, }, },
	[80621387] = { bountifulTable=true, faction="Horde", tip="There are four tables",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, },
						{ id=3577, showAllCriteria=true, guide=ns.nowCookin, guide=ns.nowCookin },
						{ id=3557, showAllCriteria=true, guide=ns.paunch, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[86544060] = { bountifulTable=true, faction="Horde", tip="There are two tables",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.silithus ] = { -- Silithus
	[55523553] = { bountifulTable=true, tip="Must be the old Silithus",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, },
						{ id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
							qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ 199 ] = { -- Southern Barrens
	[00730028] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
							qType="Seasonal", guide=ns.sharing, }, }, },
	[15099266] = { bountifulTable=true, faction="Horde",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
							qType="Seasonal", guide=ns.sharing, }, }, },
	[15583083] = { bountifulTable=true, faction="Horde", tip="There are four tables",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, },
						{ id=3577, showAllCriteria=true, guide=ns.nowCookin, guide=ns.nowCookin },
						{ id=3557, showAllCriteria=true, guide=ns.paunch, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
							qType="Seasonal", guide=ns.sharing, }, }, },
	[15673031] = { npc=true, name="Dokin Farplain", faction="Horde",
					quests={ { id=14043, name="Candied Sweet Potatoes", qType="Seasonal", guide=ns.seasonalH, }, }, },
	[15683116] = { name="Mahara Goldwheat", faction="Horde",
					quests={ { id=14060, name="Easy As Pie", qType="Daily", guide=ns.dailyH, }, }, },
	[22715108] = { bountifulTable=true, faction="Horde",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
							qType="Seasonal", guide=ns.sharing, }, }, },
	[53401179] = { bountifulTable=true, faction="Horde",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
							qType="Seasonal", guide=ns.sharing, }, }, },
	[68332375] = { bountifulTable=true, faction="Horde",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
							qType="Seasonal", guide=ns.sharing, }, }, },
	[68552377] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
							qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.stonetalon ] = { -- Stonetalon Mountains
	[44068171] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
							qType="Seasonal", guide=ns.sharing, }, }, },
	[59035683] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
							qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.tanaris ] = { -- Tanaris
	[51342978] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
							qType="Seasonal", guide=ns.sharing, }, }, },
	[52182701] = { bountifulTable=true, faction="Horde",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
							qType="Seasonal", guide=ns.sharing, }, }, },
	[52790660] = { bountifulTable=true,
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, },
						{ id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
							qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.teldrassil ] = { -- Teldrassil
	[33954819] = { npc=true, name="Isaac Allerton", faction="Alliance",
					quests={ { id=14033, faction="Alliance", name="Candied Sweet Potatoes", qType="Seasonal", guide=ns.seasonalA, }, }, },
	[34064743] = { npc=true, name="Mary Allerton", faction="Alliance",
					quests={ { id=14054, name="Easy As Pie", qType="Daily", guide=ns.dailyA, }, }, },
	[34594761] = { bountifulTable=true, faction="Alliance", tip="Just outside the Warrior's Terrace.\nThere are four tables",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, },
						{ id=3576, showAllCriteria=true, guide=ns.nowCookin, guide=ns.nowCookin },
						{ id=3556, showAllCriteria=true, guide=ns.paunch, guide=ns.sharing, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
							qType="Seasonal", guide=ns.sharing, }, }, },
	[56085104] = { bountifulTable=true, faction="Alliance", tip="Dolanaar",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
							qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.theExodar ] = { -- The Exodar
	[76505185] = { bountifulTable=true, faction="Alliance", tip="Just outside the main entrance.\nThere are four tables",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, },
						{ id=3576, showAllCriteria=true, guide=ns.nowCookin, guide=ns.nowCookin },
						{ id=3556, showAllCriteria=true, guide=ns.paunch, guide=ns.sharing, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.thousand ] = { -- Thousand Needles
	[78107233] = { bountifulTable=true,
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, },
						{ id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
							qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.thunder ] = { -- Thunder Bluff
	[30216743] = { bountifulTable=true, faction="Horde", tip="There are four tables",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, },
						{ id=3577, showAllCriteria=true, guide=ns.nowCookin, guide=ns.nowCookin },
						{ id=3557, showAllCriteria=true, guide=ns.paunch, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[30866376] = { npc=true, name="Dokin Farplain", faction="Horde",
					quests={ { id=14043, name="Candied Sweet Potatoes", qType="Seasonal", guide=ns.seasonalH, }, }, },
	[30936980] = { name="Mahara Goldwheat", faction="Horde",
					quests={ { id=14060, name="Easy As Pie", qType="Daily", guide=ns.dailyH, }, }, },
}

ns.points[ ns.map.winterspring ] = { -- Winterspring
	[58604838] = { bountifulTable=true, faction="Horde",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[60804909] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

--==================================================================================================================================
--
-- EASTERN KINGDOMS
--
--==================================================================================================================================

ns.points[ ns.map.arathi ] = { -- Arathi Highlands
	[40144723] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[70003786] = { bountifulTable=true, faction="Horde",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.badlands ] = { -- Badlands
	[18064168] = { bountifulTable=true, faction="Horde",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },

	[07768775] = { bountifulTable=true, faction="Horde",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.blastedLands ] = { -- Blasted Lands
	[61361790] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.burningSteppes ] = { -- Burning Steppes
	[53163162] = { bountifulTable=true, faction="Horde",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[73486704] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.deadwind ] = { -- Deadwind Pass
	[17203837] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.dunMorogh ] = { -- Dun Morogh
	[53305125] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[53805375] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[59813434] = { npc=true, name="Edward Winslow", faction="Alliance",
					quests={ { id=14028, faction="Alliance", name="Cranberry Chutney", qType="Seasonal", guide=ns.seasonalA, }, }, },
	[59903526] = { bountifulTable=true, faction="Alliance", tip="Three tables here",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, },
						{ id=3576, showAllCriteria=true, guide=ns.nowCookin, guide=ns.nowCookin },
						{ id=3556, showAllCriteria=true, guide=ns.paunch, guide=ns.sharing, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[60043431] = { npc=true, name="Caitrin Ironkettle", faction="Alliance",
					quests={ { id=14051, name="Don't Forget The Stuffing!", qType="Daily", }, 
						{ id=14048, name="Can't Get Enough Turkey", qType="Daily", guide=ns.dailyA, }, }, },

	[93808471] = { bountifulTable=true, faction="Horde",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.duskwood ] = { -- Duskwood
	[77664386] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },

	[38108956] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.easternP ] = { -- Eastern Plaguelands
	[74105212] = { bountifulTable=true, faction="Horde",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[75085434] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.elwynn ] = { -- Elwynn Forest
	[33715064] = { npc=true, name="Ellen Moore", faction="Alliance",
					quests={ { id=14053, name="We're Out of Cranberry Chutney Again?", qType="Daily", guide=ns.dailyA, }, }, },
	[33895081] = { npc=true, name="Jasper Moore", faction="Alliance",
					quests={ { id=14055, name="She Says Potato", qType="Daily", guide=ns.dailyA, },
						{ id=14024, name="Pumpkin Pie", qType="Seasonal", },
						{ id=14030, name="They're Ravenous In Darnassus", qType="Seasonal", guide=ns.seasonalA, }, }, },
	[34105144] = { npc=true, name="Gregory Tabor", faction="Alliance",
					quests={ { id=14023, faction="Alliance", name="Spice Bread Stuffing", qType="Seasonal", }, 
						{ id=14035, faction="Alliance", name="Slow-roasted Turkey", qType="Seasonal", guide=ns.seasonalA, }, }, },
	[34585081] = { bountifulTable=true, faction="Alliance", tip="There are three tables here",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, },
						{ id=3576, showAllCriteria=true, guide=ns.nowCookin, guide=ns.nowCookin },
						{ id=3556, showAllCriteria=true, guide=ns.paunch, guide=ns.sharing, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[41816388] = { bountifulTable=true, faction="Alliance", tip="There are three tables here",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.eversong ] = { -- Eversong Woods
	[55405320] = { bountifulTable=true, faction="Horde", tip="There are two tables",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, },
						{ id=3557, showAllCriteria=true, guide=ns.paunch, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.hillsbrad ] = { -- Hillsbrad Foothills
	[68631632] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[81463754] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[89938385] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.ironforge ] = { -- Ironforge
	[09919353] = { npc=true, name="Edward Winslow", faction="Alliance",
					quests={ { id=14028, faction="Alliance", name="Cranberry Chutney", qType="Seasonal", guide=ns.seasonalA, }, }, },
	[10489995] = { bountifulTable=true, faction="Alliance", tip="Three tables here",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, },
						{ id=3576, showAllCriteria=true, guide=ns.nowCookin, guide=ns.nowCookin },
						{ id=3556, showAllCriteria=true, guide=ns.paunch, guide=ns.sharing, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[11359334] = { npc=true, name="Caitrin Ironkettle", faction="Alliance",
					quests={ { id=14051, name="Don't Forget The Stuffing!", qType="Daily", }, 
						{ id=14048, name="Can't Get Enough Turkey", qType="Daily", guide=ns.dailyA, }, }, },
}

ns.points[ ns.map.lochModan ] = { -- Loch Modan
	[32174842] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.northStrangle ] = { -- Northern Stranglethorn
	[47301142] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.redridge ] = { -- Redridge Mountains
	[33104615] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[91987380] = { bountifulTable=true,
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, },
						{ id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.searingGorge ] = { -- Searing Gorge
	[95634080] = { bountifulTable=true, faction="Horde",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.stormwind ] = { -- Stormwind City

	[78149633] = { npc=true, name="Ellen Moore", faction="Alliance",
					quests={ { id=14053, name="We're Out of Cranberry Chutney Again?", qType="Daily", guide=ns.dailyA, }, }, },
	[78489666] = { npc=true, name="Jasper Moore", faction="Alliance",
					quests={ { id=14055, name="She Says Potato", qType="Daily", guide=ns.dailyA, },
						{ id=14024, name="Pumpkin Pie", qType="Seasonal", },
						{ id=14030, name="They're Ravenous In Darnassus", qType="Seasonal", guide=ns.seasonalA, }, }, },
	[78919794] = { npc=true, name="Gregory Tabor", faction="Alliance",
					quests={ { id=14023, faction="Alliance", name="Spice Bread Stuffing", qType="Seasonal", }, 
						{ id=14035, faction="Alliance", name="Slow-roasted Turkey", qType="Seasonal", guide=ns.seasonalA, }, }, },
	[79869668] = { bountifulTable=true, faction="Alliance", tip="There are three tables here",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, },
						{ id=3576, showAllCriteria=true, guide=ns.nowCookin, guide=ns.nowCookin },
						{ id=3556, showAllCriteria=true, guide=ns.paunch, guide=ns.sharing, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ 224 ] = { -- Stranglethorn Vale
	[48420834] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[97960127] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.swampOS ] = { -- Swamp of Sorrows
	[54228876] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[70191453] = { bountifulTable=true,
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, },
						{ id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.TheHinter ] = { -- The Hinterlands
	[13924685] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[51599687] = { bountifulTable=true, faction="Horde",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[79008077] = { bountifulTable=true, faction="Horde",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.tirisfal ] = { -- Tirisfal Glades
	[59125120] = { bountifulTable=true, faction="Horde",
					tip="Before The Ruins of Lordaeron were blighted\nThere are three tables here",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[61236694] = { name="Roberta Carter", faction="Horde",
					quests={ { id=14059, name="We're Out of Cranberry Chutney Again?", qType="Daily", guide=ns.dailyH, }, }, },
	[61386749] = { npc=true, name="Miles Standish", faction="Horde",
					quests={ { id=14037, name="Spice Bread Stuffing", qType="Seasonal", }, 
						{ id=14047, name="Slow-roasted Turkey", qType="Seasonal", guide=ns.seasonalH, }, }, },
	[61666808] = { npc=true, name="William Mullins", faction="Horde",
					quests={ { id=14040, name="Pumpkin Pie", qType="Seasonal", guide=ns.seasonalH, }, 				
						{ id=14058, name="She Says Potato", qType="Daily", guide=ns.dailyH, }, }, },
	[62246672] = { bountifulTable=true, faction="Horde",
					tip="Before The Ruins of Lordaeron were blighted\nThere are four tables here",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, },
						{ id=3577, showAllCriteria=true, guide=ns.nowCookin, guide=ns.nowCookin },
						{ id=3557, showAllCriteria=true, guide=ns.paunch, guide=ns.paunch, guide=ns.sharing,
						tip="Brill works for this criteria", }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.westernP ] = { -- Western Plaguelands
	[01283738] = { bountifulTable=true, faction="Horde",
					tip="Before The Ruins of Lordaeron were blighted\nThere are three tables here",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, },
						{ id=3557, showAllCriteria=true, guide=ns.paunch, guide=ns.paunch, guide=ns.sharing,
						tip="Brill works for this criteria", }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[03495392] = { name="Roberta Carter", faction="Horde",
					quests={ { id=14059, name="We're Out of Cranberry Chutney Again?", qType="Daily", guide=ns.dailyH, }, }, },
	[03695449] = { npc=true, name="Miles Standish", faction="Horde",
					quests={ { id=14037, name="Spice Bread Stuffing", qType="Seasonal", }, 
						{ id=14047, name="Slow-roasted Turkey", qType="Seasonal", guide=ns.seasonalH, }, }, },
	[03945512] = { npc=true, name="William Mullins", faction="Horde",
					quests={ { id=14040, name="Pumpkin Pie", qType="Seasonal", guide=ns.seasonalH, }, 				
						{ id=14058, name="She Says Potato", qType="Daily", guide=ns.dailyH, }, }, },
	[04555369] = { bountifulTable=true, faction="Horde",
					tip="Before The Ruins of Lordaeron were blighted\nThere are four tables here",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, },
						{ id=3577, showAllCriteria=true, guide=ns.nowCookin, guide=ns.nowCookin },
						{ id=3557, showAllCriteria=true, guide=ns.paunch, guide=ns.paunch, guide=ns.sharing,
						tip="Brill works for this criteria", }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[44278422] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.westfall ] = { -- Westfall
	[56974875] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },

	[83780078] = { bountifulTable=true, faction="Alliance", tip="There are two tables here",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
	[91788267] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ ns.map.wetlands ] = { -- Wetlands
	[09166088] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

--==================================================================================================================================
--
-- THE BURNING CRUSADE / OUTLAND
--
--==================================================================================================================================

ns.points[ ns.map.hellfire ] = { -- Hellfire Peninsula
	[56203820] = { bountifulTable=true, faction="Horde",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14065, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

--==================================================================================================================================
--
-- WRATH OF THE LICH KING / NORTHREND
--
--==================================================================================================================================

ns.points[ 115 ] = { -- Dragonblight
	[37184698] = { bountifulTable=true, faction="Horde",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Horde", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

--==================================================================================================================================
--
-- CATACLYSM
--
--==================================================================================================================================


ns.points[ 241 ] = { -- Twilight Highlands
	[08429168] = { bountifulTable=true, faction="Alliance",
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

--==================================================================================================================================
--
-- MISTS OF PANDARIA
--
--==================================================================================================================================

--==================================================================================================================================
--
-- WARLORDS OF DRAENOR / GARRISON
--
--==================================================================================================================================

--==================================================================================================================================
--
-- LEGION / BROKEN ISLES
--
--==================================================================================================================================

--==================================================================================================================================
--
-- BATTLE FOR AZEROTH / KUL TIRAS & ZANDALAR
--
--==================================================================================================================================

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

ns.points[ 2024 ] = { -- The Azure Span
	[63905859] = { bountifulTable=true,
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

ns.points[ 2112 ] = { -- Valdrakken
	[46806460] = { bountifulTable=true,
					achievements={ { id=3579, }, { id=3558, showAllCriteria=true, guide=ns.shareCare, }, },
					quests={ { id=14064, faction="Alliance", name="Sharing a Bountiful Feast", giver="Bountiful Feast Hostess",
						qType="Seasonal", guide=ns.sharing, }, }, },
}

--==================================================================================================================================
--
-- THE WAR WITHIN / KHAZ ALGAR
--
--==================================================================================================================================

--==================================================================================================================================
--
-- WORLD / OTHER
--
--==================================================================================================================================

--==================================================================================================================================
--
-- TEXTURES
--
--==================================================================================================================================

