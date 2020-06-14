--[[----------------------------------------------------------------------------
	AzeritePowerWeights

	Helps you pick the best Azerite powers on your gear for your class and spec.

	(c) 2018 - 2020
	Sanex @ EU-Arathor / ahak @ Curseforge

---------------------------------------------------------------------------------
	1	Warrior
		71 - Arms
		72 - Fury
		73 - Protection
	2	Paladin
		65 - Holy
		66 - Protection
		70 - Retribution
	3	Hunter
		253 - Beast Mastery
		254 - Marksmanship
		255 - Survival
	4	Rogue
		259 - Assassination
		260 - Outlaw
		261 - Subtlety
	5	Priest
		256 - Discipline
		257 - Holy
		258 - Shadow
	6	Death Knight
		250 - Blood
		251 - Frost
		252 - Unholy
	7	Shaman
		262 - Elemental
		263 - Enhancement
		264 - Restoration
	8	Mage
		62 - Arcane
		63 - Fire
		64 - Frost
	9	Warlock
		265 - Affliction
		266 - Demonology
		267 - Destruction
	10	Monk
		268 - Brewmaster
		269 - Windwalker
		270 - Mistweaver
	11	Druid
		102 - Balance
		103 - Feral
		104 - Guardian
		105 - Restoration
	12	Demon Hunter
		577 - Havoc
		581 - Vengeance
----------------------------------------------------------------------------]]--
local ADDON_NAME, n = ...

local L = n.L

-- 8.3 Powers for every Class and Spec
local sourceData = {
	["center"] = {
		["spellID"] = 263978,
		["icon"] = 2065624,
		["name"] = "Azerite Empowered",
		["azeritePowerID"] = 13,
	},
	["class"] = {
		{
			[73] = {
				{
					["spellID"] = 272824,
					["icon"] = 136105,
					["name"] = "Deafening Crash",
					["azeritePowerID"] = 118,
				}, -- [1]
				{
					["spellID"] = 279172,
					["icon"] = 1377132,
					["name"] = "Bloodsport",
					["azeritePowerID"] = 177,
				}, -- [2]
				{
					["spellID"] = 287377,
					["icon"] = 254108,
					["name"] = "Bastion of Might",
					["azeritePowerID"] = 237,
				}, -- [3]
				{
					["spellID"] = 278760,
					["icon"] = 132353,
					["name"] = "Callous Reprisal",
					["azeritePowerID"] = 440,
				}, -- [4]
				{
					["spellID"] = 278765,
					["icon"] = 942783,
					["name"] = "Iron Fortress",
					["azeritePowerID"] = 441,
				}, -- [5]
				{
					["spellID"] = 277636,
					["icon"] = 134951,
					["name"] = "Brace for Impact",
					["azeritePowerID"] = 450,
				}, -- [6]
			},
			[71] = {
				{
					["spellID"] = 288452,
					["icon"] = 236317,
					["name"] = "Striking the Anvil",
					["azeritePowerID"] = 121,
				}, -- [1]
				{
					["spellID"] = 273409,
					["icon"] = 236303,
					["name"] = "Gathering Storm",
					["azeritePowerID"] = 174,
				}, -- [2]
				{
					["spellID"] = 275529,
					["icon"] = 236314,
					["name"] = "Test of Might",
					["azeritePowerID"] = 226,
				}, -- [3]
				{
					["spellID"] = 277639,
					["icon"] = 132223,
					["name"] = "Seismic Wave",
					["azeritePowerID"] = 433,
				}, -- [4]
				{
					["spellID"] = 278751,
					["icon"] = 132340,
					["name"] = "Crushing Assault",
					["azeritePowerID"] = 434,
				}, -- [5]
				{
					["spellID"] = 278752,
					["icon"] = 464973,
					["name"] = "Lord of War",
					["azeritePowerID"] = 435,
				}, -- [6]
			},
			[72] = {
				{
					["spellID"] = 288056,
					["icon"] = 132344,
					["name"] = "Unbridled Ferocity",
					["azeritePowerID"] = 119,
				}, -- [1]
				{
					["spellID"] = 273409,
					["icon"] = 236303,
					["name"] = "Gathering Storm",
					["azeritePowerID"] = 174,
				}, -- [2]
				{
					["spellID"] = 288080,
					["icon"] = 236276,
					["name"] = "Cold Steel, Hot Blood",
					["azeritePowerID"] = 176,
				}, -- [3]
				{
					["spellID"] = 275632,
					["icon"] = 132352,
					["name"] = "Pulverizing Blows",
					["azeritePowerID"] = 229,
				}, -- [4]
				{
					["spellID"] = 278757,
					["icon"] = 136110,
					["name"] = "Simmering Rage",
					["azeritePowerID"] = 437,
				}, -- [5]
				{
					["spellID"] = 278758,
					["icon"] = 132147,
					["name"] = "Reckless Flurry",
					["azeritePowerID"] = 438,
				}, -- [6]
				{
					["spellID"] = 277638,
					["icon"] = 458972,
					["name"] = "Infinite Fury",
					["azeritePowerID"] = 451,
				}, -- [7]
			},
		}, -- [1]
		{
			[70] = {
				{
					["spellID"] = 272898,
					["icon"] = 135875,
					["name"] = "Avenger's Might",
					["azeritePowerID"] = 125,
				}, -- [1]
				{
					["spellID"] = 278617,
					["icon"] = 135897,
					["name"] = "Relentless Inquisitor",
					["azeritePowerID"] = 154,
				}, -- [2]
				{
					["spellID"] = 273473,
					["icon"] = 1360757,
					["name"] = "Expurgation",
					["azeritePowerID"] = 187,
				}, -- [3]
				{
					["spellID"] = 275496,
					["icon"] = 135959,
					["name"] = "Indomitable Justice",
					["azeritePowerID"] = 235,
				}, -- [4]
				{
					["spellID"] = 278593,
					["icon"] = 135917,
					["name"] = "Grace of the Justicar",
					["azeritePowerID"] = 393,
				}, -- [5]
				{
					["spellID"] = 286229,
					["icon"] = 135878,
					["name"] = "Light's Decree",
					["azeritePowerID"] = 396,
				}, -- [6]
				{
					["spellID"] = 286390,
					["icon"] = 236263,
					["name"] = "Empyrean Power",
					["azeritePowerID"] = 453,
				}, -- [7]
				{
					["spellID"] = 277675,
					["icon"] = 1603010,
					["name"] = "Judicious Defense",
					["azeritePowerID"] = 454,
				}, -- [8]
			},
			[65] = {
				{
					["spellID"] = 267892,
					["icon"] = 513195,
					["name"] = "Synergistic Growth",
					["azeritePowerID"] = 102,
				}, -- [1]
				{
					["spellID"] = 272898,
					["icon"] = 135875,
					["name"] = "Avenger's Might",
					["azeritePowerID"] = 125,
				}, -- [2]
				{
					["spellID"] = 287268,
					["icon"] = 1360764,
					["name"] = "Glimmer of Light",
					["azeritePowerID"] = 139,
				}, -- [3]
				{
					["spellID"] = 273513,
					["icon"] = 135907,
					["name"] = "Moment of Compassion",
					["azeritePowerID"] = 188,
				}, -- [4]
				{
					["spellID"] = 275463,
					["icon"] = 236254,
					["name"] = "Divine Revelations",
					["azeritePowerID"] = 233,
				}, -- [5]
				{
					["spellID"] = 275496,
					["icon"] = 135959,
					["name"] = "Indomitable Justice",
					["azeritePowerID"] = 235,
				}, -- [6]
				{
					["spellID"] = 278593,
					["icon"] = 135917,
					["name"] = "Grace of the Justicar",
					["azeritePowerID"] = 393,
				}, -- [7]
				{
					["spellID"] = 278594,
					["icon"] = 461859,
					["name"] = "Breaking Dawn",
					["azeritePowerID"] = 394,
				}, -- [8]
				{
					["spellID"] = 277674,
					["icon"] = 135972,
					["name"] = "Radiant Incandescence",
					["azeritePowerID"] = 452,
				}, -- [9]
				{
					["spellID"] = 277675,
					["icon"] = 1603010,
					["name"] = "Judicious Defense",
					["azeritePowerID"] = 454,
				}, -- [10]
			},
			[66] = {
				{
					["spellID"] = 272898,
					["icon"] = 135875,
					["name"] = "Avenger's Might",
					["azeritePowerID"] = 125,
				}, -- [1]
				{
					["spellID"] = 272976,
					["icon"] = 135943,
					["name"] = "Bulwark of Light",
					["azeritePowerID"] = 133,
				}, -- [2]
				{
					["spellID"] = 278605,
					["icon"] = 135874,
					["name"] = "Soaring Shield",
					["azeritePowerID"] = 150,
				}, -- [3]
				{
					["spellID"] = 287126,
					["icon"] = 135981,
					["name"] = "Righteous Conviction",
					["azeritePowerID"] = 189,
				}, -- [4]
				{
					["spellID"] = 275477,
					["icon"] = 236265,
					["name"] = "Inner Light",
					["azeritePowerID"] = 234,
				}, -- [5]
				{
					["spellID"] = 275496,
					["icon"] = 135959,
					["name"] = "Indomitable Justice",
					["azeritePowerID"] = 235,
				}, -- [6]
				{
					["spellID"] = 278593,
					["icon"] = 135917,
					["name"] = "Grace of the Justicar",
					["azeritePowerID"] = 393,
				}, -- [7]
				{
					["spellID"] = 278609,
					["icon"] = 133176,
					["name"] = "Inspiring Vanguard",
					["azeritePowerID"] = 395,
				}, -- [8]
				{
					["spellID"] = 277675,
					["icon"] = 1603010,
					["name"] = "Judicious Defense",
					["azeritePowerID"] = 454,
				}, -- [9]
			},
		}, -- [2]
		{
			[255] = {
				{
					["spellID"] = 272717,
					["icon"] = 132176,
					["name"] = "Serrated Jaws",
					["azeritePowerID"] = 107,
				}, -- [1]
				{
					["spellID"] = 272742,
					["icon"] = 451164,
					["name"] = "Wildfire Cluster",
					["azeritePowerID"] = 110,
				}, -- [2]
				{
					["spellID"] = 273283,
					["icon"] = 1033905,
					["name"] = "Latent Poison",
					["azeritePowerID"] = 163,
				}, -- [3]
				{
					["spellID"] = 274590,
					["icon"] = 136067,
					["name"] = "Venomous Fangs",
					["azeritePowerID"] = 213,
				}, -- [4]
				{
					["spellID"] = 287093,
					["icon"] = 236186,
					["name"] = "Dire Consequences",
					["azeritePowerID"] = 365,
				}, -- [5]
				{
					["spellID"] = 277653,
					["icon"] = 2065565,
					["name"] = "Blur of Talons",
					["azeritePowerID"] = 371,
				}, -- [6]
				{
					["spellID"] = 278532,
					["icon"] = 132214,
					["name"] = "Wilderness Survival",
					["azeritePowerID"] = 372,
				}, -- [7]
				{
					["spellID"] = 288570,
					["icon"] = 132210,
					["name"] = "Primeval Intuition",
					["azeritePowerID"] = 373,
				}, -- [8]
			},
			[254] = {
				{
					["spellID"] = 264198,
					["icon"] = 461115,
					["name"] = "In The Rhythm",
					["azeritePowerID"] = 36,
				}, -- [1]
				{
					["spellID"] = 287707,
					["icon"] = 132212,
					["name"] = "Surging Shots",
					["azeritePowerID"] = 162,
				}, -- [2]
				{
					["spellID"] = 274444,
					["icon"] = 132329,
					["name"] = "Unerring Vision",
					["azeritePowerID"] = 212,
				}, -- [3]
				{
					["spellID"] = 277651,
					["icon"] = 135130,
					["name"] = "Steady Aim",
					["azeritePowerID"] = 368,
				}, -- [4]
				{
					["spellID"] = 278530,
					["icon"] = 132330,
					["name"] = "Rapid Reload",
					["azeritePowerID"] = 369,
				}, -- [5]
				{
					["spellID"] = 278531,
					["icon"] = 878211,
					["name"] = "Focused Fire",
					["azeritePowerID"] = 370,
				}, -- [6]
			},
			[253] = {
				{
					["spellID"] = 272717,
					["icon"] = 132176,
					["name"] = "Serrated Jaws",
					["azeritePowerID"] = 107,
				}, -- [1]
				{
					["spellID"] = 273262,
					["icon"] = 132127,
					["name"] = "Haze of Rage",
					["azeritePowerID"] = 161,
				}, -- [2]
				{
					["spellID"] = 274441,
					["icon"] = 132133,
					["name"] = "Dance of Death",
					["azeritePowerID"] = 211,
				}, -- [3]
				{
					["spellID"] = 287093,
					["icon"] = 236186,
					["name"] = "Dire Consequences",
					["azeritePowerID"] = 365,
				}, -- [4]
				{
					["spellID"] = 279806,
					["icon"] = 136074,
					["name"] = "Primal Instincts",
					["azeritePowerID"] = 366,
				}, -- [5]
				{
					["spellID"] = 278529,
					["icon"] = 2058007,
					["name"] = "Feeding Frenzy",
					["azeritePowerID"] = 367,
				}, -- [6]
				{
					["spellID"] = 278530,
					["icon"] = 132330,
					["name"] = "Rapid Reload",
					["azeritePowerID"] = 369,
				}, -- [7]
			},
		}, -- [3]
		{
			[260] = {
				{
					["spellID"] = 272935,
					["icon"] = 1373908,
					["name"] = "Deadshot",
					["azeritePowerID"] = 129,
				}, -- [1]
				{
					["spellID"] = 288979,
					["icon"] = 132350,
					["name"] = "Keep Your Wits About You",
					["azeritePowerID"] = 180,
				}, -- [2]
				{
					["spellID"] = 275846,
					["icon"] = 132336,
					["name"] = "Snake Eyes",
					["azeritePowerID"] = 239,
				}, -- [3]
				{
					["spellID"] = 278675,
					["icon"] = 1373910,
					["name"] = "Paradise Lost",
					["azeritePowerID"] = 410,
				}, -- [4]
				{
					["spellID"] = 278676,
					["icon"] = 135610,
					["name"] = "Ace Up Your Sleeve",
					["azeritePowerID"] = 411,
				}, -- [5]
				{
					["spellID"] = 277676,
					["icon"] = 136206,
					["name"] = "Brigand's Blitz",
					["azeritePowerID"] = 446,
				}, -- [6]
			},
			[261] = {
				{
					["spellID"] = 286121,
					["icon"] = 237532,
					["name"] = "Replicating Shadows",
					["azeritePowerID"] = 124,
				}, -- [1]
				{
					["spellID"] = 273418,
					["icon"] = 1373907,
					["name"] = "Night's Vengeance",
					["azeritePowerID"] = 175,
				}, -- [2]
				{
					["spellID"] = 275896,
					["icon"] = 1373912,
					["name"] = "Blade In The Shadows",
					["azeritePowerID"] = 240,
				}, -- [3]
				{
					["spellID"] = 278681,
					["icon"] = 236279,
					["name"] = "The First Dance",
					["azeritePowerID"] = 413,
				}, -- [4]
				{
					["spellID"] = 278683,
					["icon"] = 252272,
					["name"] = "Inevitability",
					["azeritePowerID"] = 414,
				}, -- [5]
				{
					["spellID"] = 277673,
					["icon"] = 132090,
					["name"] = "Perforate",
					["azeritePowerID"] = 445,
				}, -- [6]
			},
			[259] = {
				{
					["spellID"] = 273007,
					["icon"] = 132304,
					["name"] = "Double Dose",
					["azeritePowerID"] = 136,
				}, -- [1]
				{
					["spellID"] = 273488,
					["icon"] = 132287,
					["name"] = "Twist the Knife",
					["azeritePowerID"] = 181,
				}, -- [2]
				{
					["spellID"] = 286573,
					["icon"] = 458726,
					["name"] = "Nothing Personal",
					["azeritePowerID"] = 249,
				}, -- [3]
				{
					["spellID"] = 277679,
					["icon"] = 132302,
					["name"] = "Scent of Blood",
					["azeritePowerID"] = 406,
				}, -- [4]
				{
					["spellID"] = 287649,
					["icon"] = 236273,
					["name"] = "Echoing Blades",
					["azeritePowerID"] = 407,
				}, -- [5]
				{
					["spellID"] = 278666,
					["icon"] = 132297,
					["name"] = "Shrouded Suffocation",
					["azeritePowerID"] = 408,
				}, -- [6]
			},
		}, -- [4]
		{
			[257] = {
				{
					["spellID"] = 267892,
					["icon"] = 513195,
					["name"] = "Synergistic Growth",
					["azeritePowerID"] = 102,
				}, -- [1]
				{
					["spellID"] = 272780,
					["icon"] = 135907,
					["name"] = "Permeating Glow",
					["azeritePowerID"] = 114,
				}, -- [2]
				{
					["spellID"] = 273313,
					["icon"] = 237541,
					["name"] = "Blessed Sanctuary",
					["azeritePowerID"] = 165,
				}, -- [3]
				{
					["spellID"] = 275602,
					["icon"] = 135943,
					["name"] = "Prayerful Litany",
					["azeritePowerID"] = 228,
				}, -- [4]
				{
					["spellID"] = 277681,
					["icon"] = 135913,
					["name"] = "Everlasting Light",
					["azeritePowerID"] = 400,
				}, -- [5]
				{
					["spellID"] = 278645,
					["icon"] = 135944,
					["name"] = "Word of Mending",
					["azeritePowerID"] = 401,
				}, -- [6]
				{
					["spellID"] = 287336,
					["icon"] = 135937,
					["name"] = "Promise of Deliverance",
					["azeritePowerID"] = 402,
				}, -- [7]
			},
			[258] = {
				{
					["spellID"] = 272788,
					["icon"] = 237565,
					["name"] = "Searing Dialogue",
					["azeritePowerID"] = 115,
				}, -- [1]
				{
					["spellID"] = 288340,
					["icon"] = 135978,
					["name"] = "Thought Harvester",
					["azeritePowerID"] = 166,
				}, -- [2]
				{
					["spellID"] = 275541,
					["icon"] = 136202,
					["name"] = "Depth of the Shadows",
					["azeritePowerID"] = 227,
				}, -- [3]
				{
					["spellID"] = 275722,
					["icon"] = 237298,
					["name"] = "Whispers of the Damned",
					["azeritePowerID"] = 236,
				}, -- [4]
				{
					["spellID"] = 277682,
					["icon"] = 458229,
					["name"] = "Spiteful Apparitions",
					["azeritePowerID"] = 403,
				}, -- [5]
				{
					["spellID"] = 278659,
					["icon"] = 136163,
					["name"] = "Death Throes",
					["azeritePowerID"] = 404,
				}, -- [6]
				{
					["spellID"] = 278661,
					["icon"] = 1386549,
					["name"] = "Chorus of Insanity",
					["azeritePowerID"] = 405,
				}, -- [7]
			},
			[256] = {
				{
					["spellID"] = 267892,
					["icon"] = 513195,
					["name"] = "Synergistic Growth",
					["azeritePowerID"] = 102,
				}, -- [1]
				{
					["spellID"] = 272775,
					["icon"] = 135936,
					["name"] = "Moment of Repose",
					["azeritePowerID"] = 113,
				}, -- [2]
				{
					["spellID"] = 273307,
					["icon"] = 237545,
					["name"] = "Weal and Woe",
					["azeritePowerID"] = 164,
				}, -- [3]
				{
					["spellID"] = 275541,
					["icon"] = 136202,
					["name"] = "Depth of the Shadows",
					["azeritePowerID"] = 227,
				}, -- [4]
				{
					["spellID"] = 287355,
					["icon"] = 135922,
					["name"] = "Sudden Revelation",
					["azeritePowerID"] = 397,
				}, -- [5]
				{
					["spellID"] = 278629,
					["icon"] = 237567,
					["name"] = "Contemptuous Homily",
					["azeritePowerID"] = 398,
				}, -- [6]
				{
					["spellID"] = 278643,
					["icon"] = 1386546,
					["name"] = "Enduring Luminescence",
					["azeritePowerID"] = 399,
				}, -- [7]
			},
		}, -- [5]
		{
			[252] = {
				{
					["spellID"] = 288417,
					["icon"] = 348276,
					["name"] = "Magus of the Dead",
					["azeritePowerID"] = 109,
				}, -- [1]
				{
					["spellID"] = 273088,
					["icon"] = 136144,
					["name"] = "Bone Spike Graveyard",
					["azeritePowerID"] = 140,
				}, -- [2]
				{
					["spellID"] = 286832,
					["icon"] = 342913,
					["name"] = "Helchains",
					["azeritePowerID"] = 142,
				}, -- [3]
				{
					["spellID"] = 274081,
					["icon"] = 1129420,
					["name"] = "Festermight",
					["azeritePowerID"] = 199,
				}, -- [4]
				{
					["spellID"] = 275929,
					["icon"] = 136145,
					["name"] = "Harrowing Decay",
					["azeritePowerID"] = 244,
				}, -- [5]
				{
					["spellID"] = 278482,
					["icon"] = 879926,
					["name"] = "Cankerous Wounds",
					["azeritePowerID"] = 350,
				}, -- [6]
				{
					["spellID"] = 278489,
					["icon"] = 136133,
					["name"] = "Last Surprise",
					["azeritePowerID"] = 351,
				}, -- [7]
			},
			[251] = {
				{
					["spellID"] = 272718,
					["icon"] = 135372,
					["name"] = "Icy Citadel",
					["azeritePowerID"] = 108,
				}, -- [1]
				{
					["spellID"] = 273093,
					["icon"] = 237520,
					["name"] = "Latent Chill",
					["azeritePowerID"] = 141,
				}, -- [2]
				{
					["spellID"] = 287283,
					["icon"] = 1580450,
					["name"] = "Frostwhelp's Indignation",
					["azeritePowerID"] = 198,
				}, -- [3]
				{
					["spellID"] = 275917,
					["icon"] = 135833,
					["name"] = "Echoing Howl",
					["azeritePowerID"] = 242,
				}, -- [4]
				{
					["spellID"] = 278480,
					["icon"] = 135305,
					["name"] = "Killer Frost",
					["azeritePowerID"] = 346,
				}, -- [5]
				{
					["spellID"] = 278487,
					["icon"] = 538770,
					["name"] = "Frozen Tempest",
					["azeritePowerID"] = 347,
				}, -- [6]
			},
			[250] = {
				{
					["spellID"] = 272684,
					["icon"] = 132155,
					["name"] = "Deep Cuts",
					["azeritePowerID"] = 106,
				}, -- [1]
				{
					["spellID"] = 273088,
					["icon"] = 136144,
					["name"] = "Bone Spike Graveyard",
					["azeritePowerID"] = 140,
				}, -- [2]
				{
					["spellID"] = 274057,
					["icon"] = 237517,
					["name"] = "Marrowblood",
					["azeritePowerID"] = 197,
				}, -- [3]
				{
					["spellID"] = 289339,
					["icon"] = 135338,
					["name"] = "Bloody Runeblade",
					["azeritePowerID"] = 243,
				}, -- [4]
				{
					["spellID"] = 278479,
					["icon"] = 135277,
					["name"] = "Eternal Rune Weapon",
					["azeritePowerID"] = 348,
				}, -- [5]
				{
					["spellID"] = 278484,
					["icon"] = 1376745,
					["name"] = "Bones of the Damned",
					["azeritePowerID"] = 349,
				}, -- [6]
			},
		}, -- [6]
		{
			[263] = {
				{
					["spellID"] = 263786,
					["icon"] = 538565,
					["name"] = "Astral Shift",
					["azeritePowerID"] = 17,
				}, -- [1]
				{
					["spellID"] = 272992,
					["icon"] = 236289,
					["name"] = "Primal Primer",
					["azeritePowerID"] = 137,
				}, -- [2]
				{
					["spellID"] = 273461,
					["icon"] = 136086,
					["name"] = "Strength of Earth",
					["azeritePowerID"] = 179,
				}, -- [3]
				{
					["spellID"] = 275388,
					["icon"] = 237443,
					["name"] = "Lightning Conduit",
					["azeritePowerID"] = 223,
				}, -- [4]
				{
					["spellID"] = 278697,
					["icon"] = 136028,
					["name"] = "Natural Harmony",
					["azeritePowerID"] = 416,
				}, -- [5]
				{
					["spellID"] = 278719,
					["icon"] = 132314,
					["name"] = "Roiling Storm",
					["azeritePowerID"] = 420,
				}, -- [6]
				{
					["spellID"] = 277666,
					["icon"] = 451167,
					["name"] = "Ancestral Resonance",
					["azeritePowerID"] = 447,
				}, -- [7]
				{
					["spellID"] = 277671,
					["icon"] = 136048,
					["name"] = "Synapse Shock",
					["azeritePowerID"] = 448,
				}, -- [8]
				{
					["spellID"] = 287768,
					["icon"] = 136046,
					["name"] = "Thunderaan's Fury",
					["azeritePowerID"] = 530,
				}, -- [9]
			},
			[264] = {
				{
					["spellID"] = 263786,
					["icon"] = 538565,
					["name"] = "Astral Shift",
					["azeritePowerID"] = 17,
				}, -- [1]
				{
					["spellID"] = 263792,
					["icon"] = 136015,
					["name"] = "Lightningburn",
					["azeritePowerID"] = 24,
				}, -- [2]
				{
					["spellID"] = 267892,
					["icon"] = 513195,
					["name"] = "Synergistic Growth",
					["azeritePowerID"] = 102,
				}, -- [3]
				{
					["spellID"] = 272978,
					["icon"] = 237582,
					["name"] = "Volcanic Lightning",
					["azeritePowerID"] = 135,
				}, -- [4]
				{
					["spellID"] = 272989,
					["icon"] = 136042,
					["name"] = "Soothing Waters",
					["azeritePowerID"] = 138,
				}, -- [5]
				{
					["spellID"] = 287300,
					["icon"] = 237590,
					["name"] = "Turn of the Tide",
					["azeritePowerID"] = 191,
				}, -- [6]
				{
					["spellID"] = 275488,
					["icon"] = 135127,
					["name"] = "Swelling Stream",
					["azeritePowerID"] = 224,
				}, -- [7]
				{
					["spellID"] = 278697,
					["icon"] = 136028,
					["name"] = "Natural Harmony",
					["azeritePowerID"] = 416,
				}, -- [8]
				{
					["spellID"] = 278713,
					["icon"] = 252995,
					["name"] = "Surging Tides",
					["azeritePowerID"] = 422,
				}, -- [9]
				{
					["spellID"] = 278715,
					["icon"] = 237586,
					["name"] = "Spouting Spirits",
					["azeritePowerID"] = 423,
				}, -- [10]
				{
					["spellID"] = 277666,
					["icon"] = 451167,
					["name"] = "Ancestral Resonance",
					["azeritePowerID"] = 447,
				}, -- [11]
				{
					["spellID"] = 277671,
					["icon"] = 136048,
					["name"] = "Synapse Shock",
					["azeritePowerID"] = 448,
				}, -- [12]
				{
					["spellID"] = 277658,
					["icon"] = 136037,
					["name"] = "Overflowing Shores",
					["azeritePowerID"] = 449,
				}, -- [13]
				{
					["spellID"] = 279829,
					["icon"] = 451169,
					["name"] = "Igneous Potential",
					["azeritePowerID"] = 457,
				}, -- [14]
			},
			[262] = {
				{
					["spellID"] = 263786,
					["icon"] = 538565,
					["name"] = "Astral Shift",
					["azeritePowerID"] = 17,
				}, -- [1]
				{
					["spellID"] = 263792,
					["icon"] = 136015,
					["name"] = "Lightningburn",
					["azeritePowerID"] = 24,
				}, -- [2]
				{
					["spellID"] = 272978,
					["icon"] = 237582,
					["name"] = "Volcanic Lightning",
					["azeritePowerID"] = 135,
				}, -- [3]
				{
					["spellID"] = 273448,
					["icon"] = 136026,
					["name"] = "Lava Shock",
					["azeritePowerID"] = 178,
				}, -- [4]
				{
					["spellID"] = 275381,
					["icon"] = 135790,
					["name"] = "Echo of the Elementals",
					["azeritePowerID"] = 222,
				}, -- [5]
				{
					["spellID"] = 278697,
					["icon"] = 136028,
					["name"] = "Natural Harmony",
					["azeritePowerID"] = 416,
				}, -- [6]
				{
					["spellID"] = 286949,
					["icon"] = 136025,
					["name"] = "Tectonic Thunder",
					["azeritePowerID"] = 417,
				}, -- [7]
				{
					["spellID"] = 277666,
					["icon"] = 451167,
					["name"] = "Ancestral Resonance",
					["azeritePowerID"] = 447,
				}, -- [8]
				{
					["spellID"] = 277671,
					["icon"] = 136048,
					["name"] = "Synapse Shock",
					["azeritePowerID"] = 448,
				}, -- [9]
				{
					["spellID"] = 279829,
					["icon"] = 451169,
					["name"] = "Igneous Potential",
					["azeritePowerID"] = 457,
				}, -- [10]
			},
		}, -- [7]
		{
			[64] = {
				{
					["spellID"] = 272968,
					["icon"] = 612394,
					["name"] = "Packed Ice",
					["azeritePowerID"] = 132,
				}, -- [1]
				{
					["spellID"] = 288164,
					["icon"] = 236209,
					["name"] = "Flash Freeze",
					["azeritePowerID"] = 170,
				}, -- [2]
				{
					["spellID"] = 279854,
					["icon"] = 2126034,
					["name"] = "Glacial Assault",
					["azeritePowerID"] = 225,
				}, -- [3]
				{
					["spellID"] = 277663,
					["icon"] = 135846,
					["name"] = "Tunnel of Ice",
					["azeritePowerID"] = 379,
				}, -- [4]
				{
					["spellID"] = 278541,
					["icon"] = 135844,
					["name"] = "Whiteout",
					["azeritePowerID"] = 380,
				}, -- [5]
				{
					["spellID"] = 278542,
					["icon"] = 135838,
					["name"] = "Frigid Grasp",
					["azeritePowerID"] = 381,
				}, -- [6]
			},
			[63] = {
				{
					["spellID"] = 272932,
					["icon"] = 135810,
					["name"] = "Flames of Alacrity",
					["azeritePowerID"] = 128,
				}, -- [1]
				{
					["spellID"] = 288755,
					["icon"] = 460698,
					["name"] = "Wildfire",
					["azeritePowerID"] = 168,
				}, -- [2]
				{
					["spellID"] = 274596,
					["icon"] = 135807,
					["name"] = "Blaster Master",
					["azeritePowerID"] = 215,
				}, -- [3]
				{
					["spellID"] = 277656,
					["icon"] = 135808,
					["name"] = "Trailing Embers",
					["azeritePowerID"] = 376,
				}, -- [4]
				{
					["spellID"] = 278538,
					["icon"] = 135812,
					["name"] = "Duplicative Incineration",
					["azeritePowerID"] = 377,
				}, -- [5]
				{
					["spellID"] = 278539,
					["icon"] = 236218,
					["name"] = "Firemind",
					["azeritePowerID"] = 378,
				}, -- [6]
			},
			[62] = {
				{
					["spellID"] = 270669,
					["icon"] = 136096,
					["name"] = "Arcane Pummeling",
					["azeritePowerID"] = 88,
				}, -- [1]
				{
					["spellID"] = 286027,
					["icon"] = 135732,
					["name"] = "Equipoise",
					["azeritePowerID"] = 127,
				}, -- [2]
				{
					["spellID"] = 273326,
					["icon"] = 136075,
					["name"] = "Brain Storm",
					["azeritePowerID"] = 167,
				}, -- [3]
				{
					["spellID"] = 274594,
					["icon"] = 236205,
					["name"] = "Arcane Pressure",
					["azeritePowerID"] = 214,
				}, -- [4]
				{
					["spellID"] = 278536,
					["icon"] = 135730,
					["name"] = "Galvanizing Spark",
					["azeritePowerID"] = 374,
				}, -- [5]
				{
					["spellID"] = 278537,
					["icon"] = 136116,
					["name"] = "Explosive Echo",
					["azeritePowerID"] = 375,
				}, -- [6]
			},
		}, -- [8]
		{
			[266] = {
				{
					["spellID"] = 272944,
					["icon"] = 136181,
					["name"] = "Shadow's Bite",
					["azeritePowerID"] = 130,
				}, -- [1]
				{
					["spellID"] = 273523,
					["icon"] = 236296,
					["name"] = "Umbral Blaze",
					["azeritePowerID"] = 190,
				}, -- [2]
				{
					["spellID"] = 275395,
					["icon"] = 2032610,
					["name"] = "Explosive Potential",
					["azeritePowerID"] = 231,
				}, -- [3]
				{
					["spellID"] = 278737,
					["icon"] = 535592,
					["name"] = "Demonic Meteor",
					["azeritePowerID"] = 428,
				}, -- [4]
				{
					["spellID"] = 287059,
					["icon"] = 237561,
					["name"] = "Baleful Invocation",
					["azeritePowerID"] = 429,
				}, -- [5]
				{
					["spellID"] = 276007,
					["icon"] = 460856,
					["name"] = "Excoriate",
					["azeritePowerID"] = 443,
				}, -- [6]
				{
					["spellID"] = 279878,
					["icon"] = 2065628,
					["name"] = "Supreme Commander",
					["azeritePowerID"] = 458,
				}, -- [7]
			},
			[267] = {
				{
					["spellID"] = 287637,
					["icon"] = 134075,
					["name"] = "Chaos Shards",
					["azeritePowerID"] = 131,
				}, -- [1]
				{
					["spellID"] = 275425,
					["icon"] = 135817,
					["name"] = "Flashpoint",
					["azeritePowerID"] = 232,
				}, -- [2]
				{
					["spellID"] = 278747,
					["icon"] = 1380866,
					["name"] = "Rolling Havoc",
					["azeritePowerID"] = 431,
				}, -- [3]
				{
					["spellID"] = 278748,
					["icon"] = 135789,
					["name"] = "Chaotic Inferno",
					["azeritePowerID"] = 432,
				}, -- [4]
				{
					["spellID"] = 277644,
					["icon"] = 236291,
					["name"] = "Crashing Chaos",
					["azeritePowerID"] = 444,
				}, -- [5]
				{
					["spellID"] = 279909,
					["icon"] = 135807,
					["name"] = "Bursting Flare",
					["azeritePowerID"] = 460,
				}, -- [6]
			},
			[265] = {
				{
					["spellID"] = 272891,
					["icon"] = 237564,
					["name"] = "Wracking Brilliance",
					["azeritePowerID"] = 123,
				}, -- [1]
				{
					["spellID"] = 273521,
					["icon"] = 537517,
					["name"] = "Inevitable Demise",
					["azeritePowerID"] = 183,
				}, -- [2]
				{
					["spellID"] = 275372,
					["icon"] = 136228,
					["name"] = "Cascading Calamity",
					["azeritePowerID"] = 230,
				}, -- [3]
				{
					["spellID"] = 278721,
					["icon"] = 136139,
					["name"] = "Sudden Onset",
					["azeritePowerID"] = 425,
				}, -- [4]
				{
					["spellID"] = 278727,
					["icon"] = 1416161,
					["name"] = "Dreadful Calling",
					["azeritePowerID"] = 426,
				}, -- [5]
				{
					["spellID"] = 289364,
					["icon"] = 136230,
					["name"] = "Pandemic Invocation",
					["azeritePowerID"] = 442,
				}, -- [6]
			},
		}, -- [9]
		{
			[269] = {
				{
					["spellID"] = 287055,
					["icon"] = 606548,
					["name"] = "Fury of Xuen",
					["azeritePowerID"] = 117,
				}, -- [1]
				{
					["spellID"] = 273291,
					["icon"] = 642415,
					["name"] = "Sunrise Technique",
					["azeritePowerID"] = 184,
				}, -- [2]
				{
					["spellID"] = 288634,
					["icon"] = 1381297,
					["name"] = "Glory of the Dawn",
					["azeritePowerID"] = 388,
				}, -- [3]
				{
					["spellID"] = 279918,
					["icon"] = 627606,
					["name"] = "Open Palm Strikes",
					["azeritePowerID"] = 389,
				}, -- [4]
				{
					["spellID"] = 278577,
					["icon"] = 606551,
					["name"] = "Pressure Point",
					["azeritePowerID"] = 390,
				}, -- [5]
				{
					["spellID"] = 286585,
					["icon"] = 607849,
					["name"] = "Dance of Chi-Ji",
					["azeritePowerID"] = 391,
				}, -- [6]
			},
			[270] = {
				{
					["spellID"] = 287829,
					["icon"] = 611418,
					["name"] = "Secret Infusion",
					["azeritePowerID"] = 76,
				}, -- [1]
				{
					["spellID"] = 267892,
					["icon"] = 513195,
					["name"] = "Synergistic Growth",
					["azeritePowerID"] = 102,
				}, -- [2]
				{
					["spellID"] = 273291,
					["icon"] = 642415,
					["name"] = "Sunrise Technique",
					["azeritePowerID"] = 184,
				}, -- [3]
				{
					["spellID"] = 273328,
					["icon"] = 775461,
					["name"] = "Overflowing Mists",
					["azeritePowerID"] = 185,
				}, -- [4]
				{
					["spellID"] = 275975,
					["icon"] = 627487,
					["name"] = "Misty Peaks",
					["azeritePowerID"] = 248,
				}, -- [5]
				{
					["spellID"] = 277667,
					["icon"] = 627485,
					["name"] = "Burst of Life",
					["azeritePowerID"] = 385,
				}, -- [6]
				{
					["spellID"] = 279875,
					["icon"] = 1360978,
					["name"] = "Font of Life",
					["azeritePowerID"] = 386,
				}, -- [7]
				{
					["spellID"] = 278576,
					["icon"] = 1020466,
					["name"] = "Uplifted Spirits",
					["azeritePowerID"] = 387,
				}, -- [8]
				{
					["spellID"] = 288634,
					["icon"] = 1381297,
					["name"] = "Glory of the Dawn",
					["azeritePowerID"] = 388,
				}, -- [9]
			},
			[268] = {
				{
					["spellID"] = 272792,
					["icon"] = 615339,
					["name"] = "Boiling Brew",
					["azeritePowerID"] = 116,
				}, -- [1]
				{
					["spellID"] = 273464,
					["icon"] = 1500803,
					["name"] = "Staggering Strikes",
					["azeritePowerID"] = 186,
				}, -- [2]
				{
					["spellID"] = 275892,
					["icon"] = 133701,
					["name"] = "Fit to Burst",
					["azeritePowerID"] = 238,
				}, -- [3]
				{
					["spellID"] = 285958,
					["icon"] = 1360979,
					["name"] = "Straight, No Chaser",
					["azeritePowerID"] = 382,
				}, -- [4]
				{
					["spellID"] = 278569,
					["icon"] = 611419,
					["name"] = "Training of Niuzao",
					["azeritePowerID"] = 383,
				}, -- [5]
				{
					["spellID"] = 278571,
					["icon"] = 642416,
					["name"] = "Elusive Footwork",
					["azeritePowerID"] = 384,
				}, -- [6]
			},
		}, -- [10]
		{
			[103] = {
				{
					["spellID"] = 279524,
					["icon"] = 236149,
					["name"] = "Blood Mist",
					["azeritePowerID"] = 111,
				}, -- [1]
				{
					["spellID"] = 273338,
					["icon"] = 132122,
					["name"] = "Untamed Ferocity",
					["azeritePowerID"] = 169,
				}, -- [2]
				{
					["spellID"] = 273344,
					["icon"] = 236169,
					["name"] = "Masterful Instincts",
					["azeritePowerID"] = 171,
				}, -- [3]
				{
					["spellID"] = 274424,
					["icon"] = 132242,
					["name"] = "Jungle Fury",
					["azeritePowerID"] = 209,
				}, -- [4]
				{
					["spellID"] = 275906,
					["icon"] = 451161,
					["name"] = "Twisted Claws",
					["azeritePowerID"] = 241,
				}, -- [5]
				{
					["spellID"] = 276021,
					["icon"] = 132134,
					["name"] = "Iron Jaws",
					["azeritePowerID"] = 247,
				}, -- [6]
				{
					["spellID"] = 278509,
					["icon"] = 132152,
					["name"] = "Gushing Lacerations",
					["azeritePowerID"] = 358,
				}, -- [7]
				{
					["spellID"] = 279527,
					["icon"] = 236305,
					["name"] = "Wild Fleshrending",
					["azeritePowerID"] = 359,
				}, -- [8]
			},
			[104] = {
				{
					["spellID"] = 269379,
					["icon"] = 136096,
					["name"] = "Long Night",
					["azeritePowerID"] = 51,
				}, -- [1]
				{
					["spellID"] = 279552,
					["icon"] = 1378702,
					["name"] = "Layered Mane",
					["azeritePowerID"] = 112,
				}, -- [2]
				{
					["spellID"] = 273344,
					["icon"] = 236169,
					["name"] = "Masterful Instincts",
					["azeritePowerID"] = 171,
				}, -- [3]
				{
					["spellID"] = 275906,
					["icon"] = 451161,
					["name"] = "Twisted Claws",
					["azeritePowerID"] = 241,
				}, -- [4]
				{
					["spellID"] = 289314,
					["icon"] = 571585,
					["name"] = "Burst of Savagery",
					["azeritePowerID"] = 251,
				}, -- [5]
				{
					["spellID"] = 279527,
					["icon"] = 236305,
					["name"] = "Wild Fleshrending",
					["azeritePowerID"] = 359,
				}, -- [6]
				{
					["spellID"] = 278510,
					["icon"] = 132091,
					["name"] = "Gory Regeneration",
					["azeritePowerID"] = 360,
				}, -- [7]
				{
					["spellID"] = 278511,
					["icon"] = 132136,
					["name"] = "Guardian's Wrath",
					["azeritePowerID"] = 361,
				}, -- [8]
			},
			[105] = {
				{
					["spellID"] = 269379,
					["icon"] = 136096,
					["name"] = "Long Night",
					["azeritePowerID"] = 51,
				}, -- [1]
				{
					["spellID"] = 267892,
					["icon"] = 513195,
					["name"] = "Synergistic Growth",
					["azeritePowerID"] = 102,
				}, -- [2]
				{
					["spellID"] = 287251,
					["icon"] = 236153,
					["name"] = "Early Harvest",
					["azeritePowerID"] = 120,
				}, -- [3]
				{
					["spellID"] = 279778,
					["icon"] = 134914,
					["name"] = "Grove Tending",
					["azeritePowerID"] = 172,
				}, -- [4]
				{
					["spellID"] = 274432,
					["icon"] = 136081,
					["name"] = "Autumn Leaves",
					["azeritePowerID"] = 210,
				}, -- [5]
				{
					["spellID"] = 278505,
					["icon"] = 236216,
					["name"] = "High Noon",
					["azeritePowerID"] = 356,
				}, -- [6]
				{
					["spellID"] = 278515,
					["icon"] = 136085,
					["name"] = "Rampant Growth",
					["azeritePowerID"] = 362,
				}, -- [7]
				{
					["spellID"] = 278513,
					["icon"] = 134157,
					["name"] = "Waking Dream",
					["azeritePowerID"] = 363,
				}, -- [8]
				{
					["spellID"] = 279642,
					["icon"] = 136048,
					["name"] = "Lively Spirit",
					["azeritePowerID"] = 364,
				}, -- [9]
			},
			[102] = {
				{
					["spellID"] = 269379,
					["icon"] = 136096,
					["name"] = "Long Night",
					["azeritePowerID"] = 51,
				}, -- [1]
				{
					["spellID"] = 272871,
					["icon"] = 136060,
					["name"] = "Streaking Stars",
					["azeritePowerID"] = 122,
				}, -- [2]
				{
					["spellID"] = 273367,
					["icon"] = 136096,
					["name"] = "Power of the Moon",
					["azeritePowerID"] = 173,
				}, -- [3]
				{
					["spellID"] = 287773,
					["icon"] = 135730,
					["name"] = "Arcanic Pulsar",
					["azeritePowerID"] = 200,
				}, -- [4]
				{
					["spellID"] = 276152,
					["icon"] = 135753,
					["name"] = "Dawning Sun",
					["azeritePowerID"] = 250,
				}, -- [5]
				{
					["spellID"] = 278505,
					["icon"] = 236216,
					["name"] = "High Noon",
					["azeritePowerID"] = 356,
				}, -- [6]
				{
					["spellID"] = 278507,
					["icon"] = 236168,
					["name"] = "Lunar Shrapnel",
					["azeritePowerID"] = 357,
				}, -- [7]
				{
					["spellID"] = 279642,
					["icon"] = 136048,
					["name"] = "Lively Spirit",
					["azeritePowerID"] = 364,
				}, -- [8]
			},
		}, -- [11]
		{
			[577] = {
				{
					["spellID"] = 279581,
					["icon"] = 1305149,
					["name"] = "Revolving Blades",
					["azeritePowerID"] = 126,
				}, -- [1]
				{
					["spellID"] = 273231,
					["icon"] = 1305156,
					["name"] = "Furious Gaze",
					["azeritePowerID"] = 159,
				}, -- [2]
				{
					["spellID"] = 273236,
					["icon"] = 1344649,
					["name"] = "Infernal Armor",
					["azeritePowerID"] = 160,
				}, -- [3]
				{
					["spellID"] = 288754,
					["icon"] = 1305157,
					["name"] = "Chaotic Transformation",
					["azeritePowerID"] = 220,
				}, -- [4]
				{
					["spellID"] = 275934,
					["icon"] = 1097741,
					["name"] = "Seething Power",
					["azeritePowerID"] = 245,
				}, -- [5]
				{
					["spellID"] = 278493,
					["icon"] = 1305152,
					["name"] = "Thirsting Blades",
					["azeritePowerID"] = 352,
				}, -- [6]
				{
					["spellID"] = 278500,
					["icon"] = 463286,
					["name"] = "Eyes of Rage",
					["azeritePowerID"] = 353,
				}, -- [7]
			},
			[581] = {
				{
					["spellID"] = 272983,
					["icon"] = 1344647,
					["name"] = "Revel in Pain",
					["azeritePowerID"] = 134,
				}, -- [1]
				{
					["spellID"] = 273236,
					["icon"] = 1344649,
					["name"] = "Infernal Armor",
					["azeritePowerID"] = 160,
				}, -- [2]
				{
					["spellID"] = 275350,
					["icon"] = 1344645,
					["name"] = "Rigid Carapace",
					["azeritePowerID"] = 221,
				}, -- [3]
				{
					["spellID"] = 288878,
					["icon"] = 615099,
					["name"] = "Hour of Reaping",
					["azeritePowerID"] = 246,
				}, -- [4]
				{
					["spellID"] = 278502,
					["icon"] = 1344652,
					["name"] = "Cycle of Binding",
					["azeritePowerID"] = 354,
				}, -- [5]
				{
					["spellID"] = 278501,
					["icon"] = 1344648,
					["name"] = "Essence Sever",
					["azeritePowerID"] = 355,
				}, -- [6]
			},
		}, -- [12]
	},
	["defensive"] = {
		{
			{
				["spellID"] = 280023,
				["icon"] = 132351,
				["name"] = "Moment of Glory",
				["azeritePowerID"] = 476,
			}, -- [1]
			{
				["spellID"] = 280128,
				["icon"] = 132342,
				["name"] = "Bury the Hatchet",
				["azeritePowerID"] = 477,
			}, -- [2]
			{
				["spellID"] = 288641,
				["icon"] = 132126,
				["name"] = "Intimidating Presence",
				["azeritePowerID"] = 554,
			}, -- [3]
		}, -- [1]
		{
			{
				["spellID"] = 274388,
				["icon"] = 524354,
				["name"] = "Stalwart Protector",
				["azeritePowerID"] = 206,
			}, -- [1]
			{
				["spellID"] = 280017,
				["icon"] = 1360759,
				["name"] = "Gallant Steed",
				["azeritePowerID"] = 471,
			}, -- [2]
			{
				["spellID"] = 287729,
				["icon"] = 135928,
				["name"] = "Empyreal Ward",
				["azeritePowerID"] = 538,
			}, -- [3]
		}, -- [2]
		{
			{
				["spellID"] = 274355,
				["icon"] = 132199,
				["name"] = "Shellshock",
				["azeritePowerID"] = 203,
			}, -- [1]
			{
				["spellID"] = 280014,
				["icon"] = 132293,
				["name"] = "Duck and Cover",
				["azeritePowerID"] = 469,
			}, -- [2]
			{
				["spellID"] = 287938,
				["icon"] = 1014024,
				["name"] = "Nature's Salve",
				["azeritePowerID"] = 543,
			}, -- [3]
		}, -- [3]
		{
			{
				["spellID"] = 274692,
				["icon"] = 132307,
				["name"] = "Footpad",
				["azeritePowerID"] = 217,
			}, -- [1]
			{
				["spellID"] = 280020,
				["icon"] = 136177,
				["name"] = "Shrouded Mantle",
				["azeritePowerID"] = 473,
			}, -- [2]
			{
				["spellID"] = 288079,
				["icon"] = 132301,
				["name"] = "Lying In Wait",
				["azeritePowerID"] = 548,
			}, -- [3]
		}, -- [4]
		{
			{
				["spellID"] = 274366,
				["icon"] = 135994,
				["name"] = "Sanctum",
				["azeritePowerID"] = 204,
			}, -- [1]
			{
				["spellID"] = 280018,
				["icon"] = 136066,
				["name"] = "Twist Magic",
				["azeritePowerID"] = 472,
			}, -- [2]
			{
				["spellID"] = 287717,
				["icon"] = 463835,
				["name"] = "Death Denied",
				["azeritePowerID"] = 537,
			}, -- [3]
		}, -- [5]
		{
			{
				["spellID"] = 280010,
				["icon"] = 136120,
				["name"] = "Runic Barrier",
				["azeritePowerID"] = 201,
			}, -- [1]
			{
				["spellID"] = 280011,
				["icon"] = 237561,
				["name"] = "March of the Damned",
				["azeritePowerID"] = 465,
			}, -- [2]
			{
				["spellID"] = 288424,
				["icon"] = 237525,
				["name"] = "Cold Hearted",
				["azeritePowerID"] = 549,
			}, -- [3]
		}, -- [6]
		{
			{
				["spellID"] = 274412,
				["icon"] = 538565,
				["name"] = "Serene Spirit",
				["azeritePowerID"] = 207,
			}, -- [1]
			{
				["spellID"] = 280021,
				["icon"] = 136095,
				["name"] = "Pack Spirit",
				["azeritePowerID"] = 474,
			}, -- [2]
			{
				["spellID"] = 287774,
				["icon"] = 133439,
				["name"] = "Ancient Ankh Talisman",
				["azeritePowerID"] = 539,
			}, -- [3]
		}, -- [7]
		{
			{
				["spellID"] = 274379,
				["icon"] = 135991,
				["name"] = "Eldritch Warding",
				["azeritePowerID"] = 205,
			}, -- [1]
			{
				["spellID"] = 280015,
				["icon"] = 135736,
				["name"] = "Cauterizing Blink",
				["azeritePowerID"] = 468,
			}, -- [2]
			{
				["spellID"] = 288121,
				["icon"] = 135754,
				["name"] = "Quick Thinking",
				["azeritePowerID"] = 546,
			}, -- [3]
		}, -- [8]
		{
			{
				["spellID"] = 274418,
				["icon"] = 538745,
				["name"] = "Lifeblood",
				["azeritePowerID"] = 208,
			}, -- [1]
			{
				["spellID"] = 280022,
				["icon"] = 136169,
				["name"] = "Desperate Power",
				["azeritePowerID"] = 475,
			}, -- [2]
			{
				["spellID"] = 287822,
				["icon"] = 136183,
				["name"] = "Terror of the Mind",
				["azeritePowerID"] = 531,
			}, -- [3]
		}, -- [9]
		{
			{
				["spellID"] = 274762,
				["icon"] = 606546,
				["name"] = "Strength of Spirit",
				["azeritePowerID"] = 218,
			}, -- [1]
			{
				["spellID"] = 280016,
				["icon"] = 642414,
				["name"] = "Sweep the Leg",
				["azeritePowerID"] = 470,
			}, -- [2]
			{
				["spellID"] = 289322,
				["icon"] = 574574,
				["name"] = "Exit Strategy",
				["azeritePowerID"] = 566,
			}, -- [3]
		}, -- [10]
		{
			{
				["spellID"] = 274813,
				["icon"] = 136080,
				["name"] = "Reawakening",
				["azeritePowerID"] = 219,
			}, -- [1]
			{
				["spellID"] = 280013,
				["icon"] = 136097,
				["name"] = "Ursoc's Endurance",
				["azeritePowerID"] = 467,
			}, -- [2]
			{
				["spellID"] = 287803,
				["icon"] = 135879,
				["name"] = "Switch Hitter",
				["azeritePowerID"] = 540,
			}, -- [3]
		}, -- [11]
		{
			{
				["spellID"] = 274344,
				["icon"] = 1305158,
				["name"] = "Soulmonger",
				["azeritePowerID"] = 202,
			}, -- [1]
			{
				["spellID"] = 280012,
				["icon"] = 828455,
				["name"] = "Burning Soul",
				["azeritePowerID"] = 466,
			}, -- [2]
			{
				["spellID"] = 288973,
				["icon"] = 1392554,
				["name"] = "Thrive in Chaos",
				["azeritePowerID"] = 564,
			}, -- [3]
		}, -- [12]
		["common"] = {
			{
				["spellID"] = 268594,
				["icon"] = 538536,
				["name"] = "Longstrider",
				["azeritePowerID"] = 14,
			}, -- [1]
			{
				["spellID"] = 263962,
				["icon"] = 1769069,
				["name"] = "Resounding Protection",
				["azeritePowerID"] = 15,
			}, -- [2]
			{
				["spellID"] = 268599,
				["icon"] = 237395,
				["name"] = "Vampiric Speed",
				["azeritePowerID"] = 44,
			}, -- [3]
			{
				["spellID"] = 268437,
				["icon"] = 1387707,
				["name"] = "Impassive Visage",
				["azeritePowerID"] = 83,
			}, -- [4]
			{
				["spellID"] = 268595,
				["icon"] = 651746,
				["name"] = "Bulwark of the Masses",
				["azeritePowerID"] = 84,
			}, -- [5]
			{
				["spellID"] = 268596,
				["icon"] = 1686575,
				["name"] = "Gemhide",
				["azeritePowerID"] = 85,
			}, -- [6]
			{
				["spellID"] = 268435,
				["icon"] = 646669,
				["name"] = "Azerite Fortification",
				["azeritePowerID"] = 86,
			}, -- [7]
			{
				["spellID"] = 268600,
				["icon"] = 413591,
				["name"] = "Self Reliance",
				["azeritePowerID"] = 87,
			}, -- [8]
		},
	},
	["role"] = {
		["healer"] = {
			{
				["spellID"] = 267880,
				["icon"] = 463526,
				["name"] = "Woundbinder",
				["azeritePowerID"] = 19,
			}, -- [1]
			{
				["spellID"] = 267883,
				["icon"] = 413576,
				["name"] = "Savior",
				["azeritePowerID"] = 42,
			}, -- [2]
			{
				["spellID"] = 267882,
				["icon"] = 970412,
				["name"] = "Concentrated Mending",
				["azeritePowerID"] = 103,
			}, -- [3]
			{
				["spellID"] = 267884,
				["icon"] = 236832,
				["name"] = "Bracing Chill",
				["azeritePowerID"] = 104,
			}, -- [4]
			{
				["spellID"] = 267886,
				["icon"] = 133020,
				["name"] = "Ephemeral Recovery",
				["azeritePowerID"] = 105,
			}, -- [5]
			{
				["spellID"] = 267889,
				["icon"] = 135905,
				["name"] = "Blessed Portents",
				["azeritePowerID"] = 463,
			}, -- [6]
		},
		["tank"] = {
			{
				["spellID"] = 267671,
				["icon"] = 1029596,
				["name"] = "Winds of War",
				["azeritePowerID"] = 43,
			}, -- [1]
			{
				["spellID"] = 267683,
				["icon"] = 1129419,
				["name"] = "Azerite Veins",
				["azeritePowerID"] = 89,
			}, -- [2]
			{
				["spellID"] = 271536,
				["icon"] = 134978,
				["name"] = "Crystalline Carapace",
				["azeritePowerID"] = 98,
			}, -- [3]
			{
				["spellID"] = 271540,
				["icon"] = 645224,
				["name"] = "Ablative Shielding",
				["azeritePowerID"] = 99,
			}, -- [4]
			{
				["spellID"] = 271546,
				["icon"] = 136031,
				["name"] = "Strength in Numbers",
				["azeritePowerID"] = 100,
			}, -- [5]
			{
				["spellID"] = 271557,
				["icon"] = 1323035,
				["name"] = "Shimmering Haven",
				["azeritePowerID"] = 101,
			}, -- [6]
		},
		["nonhealer"] = {
			{
				["spellID"] = 263984,
				["icon"] = 1029585,
				["name"] = "Elemental Whirl",
				["azeritePowerID"] = 21,
			}, -- [1]
			{
				["spellID"] = 266180,
				["icon"] = 252174,
				["name"] = "Overwhelming Power",
				["azeritePowerID"] = 30,
			}, -- [2]
			{
				["spellID"] = 266937,
				["icon"] = 132109,
				["name"] = "Gutripper",
				["azeritePowerID"] = 31,
			}, -- [3]
			{
				["spellID"] = 266936,
				["icon"] = 646670,
				["name"] = "Azerite Globules",
				["azeritePowerID"] = 462,
			}, -- [4]
		},
		["common"] = {
			{
				["spellID"] = 264108,
				["icon"] = 538560,
				["name"] = "Blood Siphon",
				["azeritePowerID"] = 18,
			}, -- [1]
			{
				["spellID"] = 267665,
				["icon"] = 236166,
				["name"] = "Lifespeed",
				["azeritePowerID"] = 20,
			}, -- [2]
			{
				["spellID"] = 263987,
				["icon"] = 237589,
				["name"] = "Heed My Call",
				["azeritePowerID"] = 22,
			}, -- [3]
			{
				["spellID"] = 267879,
				["icon"] = 132565,
				["name"] = "On My Way",
				["azeritePowerID"] = 38,
			}, -- [4]
			{
				["spellID"] = 279899,
				["icon"] = 514016,
				["name"] = "Unstable Flames",
				["azeritePowerID"] = 459,
			}, -- [5]
			{
				["spellID"] = 279926,
				["icon"] = 2065623,
				["name"] = "Earthlink",
				["azeritePowerID"] = 461,
			}, -- [6]
			{
				["spellID"] = 317137,
				["icon"] = 839910,
				["name"] = "Heart of Darkness",
				["azeritePowerID"] = 582,
			}, -- [7]
		},
	},
	["raid"] = {
		{
			["spellID"] = 280555,
			["icon"] = 2000853,
			["name"] = "Archive of the Titans",
			["azeritePowerID"] = 483,
		}, -- [1]
		{
			["spellID"] = 280559,
			["icon"] = 136039,
			["name"] = "Laser Matrix",
			["azeritePowerID"] = 485,
		}, -- [2]
		{
			["spellID"] = 288802,
			["icon"] = 895888,
			["name"] = "Bonded Souls",
			["azeritePowerID"] = 560,
		}, -- [3]
		{
			["spellID"] = 288749,
			["icon"] = 2442247,
			["name"] = "Seductive Power",
			["azeritePowerID"] = 561,
		}, -- [4]
		{
			["spellID"] = 288953,
			["icon"] = 1778226,
			["name"] = "Treacherous Covenant",
			["azeritePowerID"] = 562,
		}, -- [5]
		{
			["spellID"] = 303008,
			["icon"] = 1698701,
			["name"] = "Undulating Tides",
			["azeritePowerID"] = 575,
		}, -- [6]
		{
			["spellID"] = 303007,
			["icon"] = 136159,
			["name"] = "Loyal to the End",
			["azeritePowerID"] = 576,
		}, -- [7]
		{
			["spellID"] = 303006,
			["icon"] = 1391778,
			["name"] = "Arcane Heart",
			["azeritePowerID"] = 577,
		}, -- [8]
	},
	["zone"] = {
		{
			["spellID"] = 280710,
			["icon"] = 135885,
			["name"] = "Champion of Azeroth",
			["azeritePowerID"] = 82,
		}, -- [1]
		{
			["spellID"] = 273150,
			["icon"] = 135780,
			["name"] = "Ruinous Bolt",
			["azeritePowerID"] = 156,
		}, -- [2]
		{
			["spellID"] = 273790,
			["icon"] = 2011133,
			["name"] = "Rezan's Fury",
			["azeritePowerID"] = 157,
		}, -- [3]
		{
			["spellID"] = 273682,
			["icon"] = 132299,
			["name"] = "Meticulous Scheming",
			["azeritePowerID"] = 192,
		}, -- [4]
		{
			["spellID"] = 273823,
			["icon"] = 1778229,
			["name"] = "Blightborne Infusion",
			["azeritePowerID"] = 193,
		}, -- [5]
		{
			["spellID"] = 273834,
			["icon"] = 840409,
			["name"] = "Filthy Transfusion",
			["azeritePowerID"] = 194,
		}, -- [6]
		{
			["spellID"] = 273829,
			["icon"] = 463858,
			["name"] = "Secrets of the Deep",
			["azeritePowerID"] = 195,
		}, -- [7]
		{
			["spellID"] = 280429,
			["icon"] = 796638,
			["name"] = "Swirling Sands",
			["azeritePowerID"] = 196,
		}, -- [8]
		{
			["spellID"] = 280402,
			["icon"] = 1698701,
			["name"] = "Tidal Surge",
			["azeritePowerID"] = 478,
		}, -- [9]
		{
			["spellID"] = 280284,
			["icon"] = 135642,
			["name"] = "Dagger in the Back",
			["azeritePowerID"] = 479,
		}, -- [10]
		{
			["spellID"] = 280407,
			["icon"] = 463568,
			["name"] = "Blood Rite",
			["azeritePowerID"] = 480,
		}, -- [11]
		{
			["spellID"] = 280410,
			["icon"] = 132193,
			["name"] = "Incite the Pack",
			["azeritePowerID"] = 481,
		}, -- [12]
		{
			["spellID"] = 280380,
			["icon"] = 839983,
			["name"] = "Thunderous Blast",
			["azeritePowerID"] = 482,
		}, -- [13]
		{
			["spellID"] = 281514,
			["icon"] = 2032578,
			["name"] = "Unstable Catalyst",
			["azeritePowerID"] = 504,
		}, -- [14]
		{
			["spellID"] = 281841,
			["icon"] = 1029595,
			["name"] = "Tradewinds",
			["azeritePowerID"] = 505,
		}, -- [15]
		{
			["spellID"] = 287467,
			["icon"] = 135900,
			["name"] = "Shadow of Elune",
			["azeritePowerID"] = 521,
		}, -- [16]
		{
			["spellID"] = 287604,
			["icon"] = 874580,
			["name"] = "Ancients' Bulwark",
			["azeritePowerID"] = 522,
		}, -- [17]
		{
			["spellID"] = 287631,
			["icon"] = 463547,
			["name"] = "Apothecary's Concoctions",
			["azeritePowerID"] = 523,
		}, -- [18]
		{
			["spellID"] = 287662,
			["icon"] = 2357388,
			["name"] = "Endless Hunger",
			["azeritePowerID"] = 526,
		}, -- [19]
		{
			["spellID"] = 300168,
			["icon"] = 2115322,
			["name"] = "Person-Computer Interface",
			["azeritePowerID"] = 568,
		}, -- [20]
		{
			["spellID"] = 300170,
			["icon"] = 134377,
			["name"] = "Clockwork Heart",
			["azeritePowerID"] = 569,
		}, -- [21]
	},
	["profession"] = {
		{
			["spellID"] = 280163,
			["icon"] = 463515,
			["name"] = "Barrage Of Many Bombs",
			["azeritePowerID"] = 498,
		}, -- [1]
		{
			["spellID"] = 280168,
			["icon"] = 134427,
			["name"] = "Ricocheting Inflatable Pyrosaw",
			["azeritePowerID"] = 499,
		}, -- [2]
		{
			["spellID"] = 280174,
			["icon"] = 1320373,
			["name"] = "Synaptic Spark Capacitor",
			["azeritePowerID"] = 500,
		}, -- [3]
		{
			["spellID"] = 280178,
			["icon"] = 133873,
			["name"] = "Relational Normalization Gizmo",
			["azeritePowerID"] = 501,
		}, -- [4]
		{
			["spellID"] = 280181,
			["icon"] = 1336885,
			["name"] = "Personal Absorb-o-Tron",
			["azeritePowerID"] = 502,
		}, -- [5]
		{
			["spellID"] = 280172,
			["icon"] = 514950,
			["name"] = "Auto-Self-Cauterizer",
			["azeritePowerID"] = 503,
		}, -- [6]
	},
	["pvp"] = {
		{
			["spellID"] = 280577,
			["icon"] = 1028980,
			["name"] = "Glory in Battle",
			["azeritePowerID"] = 486,
		}, -- [1]
		{
			["spellID"] = 280579,
			["icon"] = 1035504,
			["name"] = "Retaliatory Fury",
			["azeritePowerID"] = 487,
		}, -- [2]
		{
			["spellID"] = 280582,
			["icon"] = 236646,
			["name"] = "Battlefield Focus",
			["azeritePowerID"] = 488,
		}, -- [3]
		{
			["spellID"] = 280598,
			["icon"] = 236560,
			["name"] = "Sylvanas' Resolve",
			["azeritePowerID"] = 489,
		}, -- [4]
		{
			["spellID"] = 280580,
			["icon"] = 236324,
			["name"] = "Combined Might",
			["azeritePowerID"] = 490,
		}, -- [5]
		{
			["spellID"] = 280581,
			["icon"] = 136003,
			["name"] = "Collective Will",
			["azeritePowerID"] = 491,
		}, -- [6]
		{
			["spellID"] = 280623,
			["icon"] = 1028984,
			["name"] = "Liberator's Might",
			["azeritePowerID"] = 492,
		}, -- [7]
		{
			["spellID"] = 280624,
			["icon"] = 236478,
			["name"] = "Last Gift",
			["azeritePowerID"] = 493,
		}, -- [8]
		{
			["spellID"] = 280627,
			["icon"] = 132486,
			["name"] = "Battlefield Precision",
			["azeritePowerID"] = 494,
		}, -- [9]
		{
			["spellID"] = 280628,
			["icon"] = 1042294,
			["name"] = "Anduin's Dedication",
			["azeritePowerID"] = 495,
		}, -- [10]
		{
			["spellID"] = 280625,
			["icon"] = 2022762,
			["name"] = "Stronger Together",
			["azeritePowerID"] = 496,
		}, -- [11]
		{
			["spellID"] = 280626,
			["icon"] = 236344,
			["name"] = "Stand As One",
			["azeritePowerID"] = 497,
		}, -- [12]
		{
			["spellID"] = 287818,
			["icon"] = 236310,
			["name"] = "Fight or Flight",
			["azeritePowerID"] = 541,
		}, -- [13]
	}
}
n.sourceData = sourceData
-- 8.3 Azerite Essences
local essenceData = {
	["common"] = {
		{
			["essenceID"] = 4,
			["name"] = "Worldvein Resonance",
			["icon"] = 1830317,
		}, -- [1]
		{
			["essenceID"] = 12,
			["name"] = "The Crucible of Flame",
			["icon"] = 3015740,
		}, -- [2]
		{
			["essenceID"] = 15,
			["name"] = "Ripple in Space",
			["icon"] = 2967109,
		}, -- [3]
		{
			["essenceID"] = 22,
			["name"] = "Vision of Perfection",
			["icon"] = 3015743,
		}, -- [4]
		{
			["essenceID"] = 27,
			["name"] = "Memory of Lucid Dreams",
			["icon"] = 2967104,
		}, -- [5]
		{
			["essenceID"] = 32,
			["name"] = "Conflict and Strife",
			["icon"] = 3015742,
		}, -- [6]
		{
			["essenceID"] = 37,
			["name"] = "The Formless Void",
			["icon"] = 3193845,
		}, -- [7]
	},
	["tank"] = {
		{
			["essenceID"] = 2,
			["name"] = "Azeroth's Undying Gift",
			["icon"] = 2967107,
		}, -- [1]
		{
			["essenceID"] = 3,
			["name"] = "Sphere of Suppression",
			["icon"] = 2065602,
		}, -- [2]
		{
			["essenceID"] = 7,
			["name"] = "Anima of Life and Death",
			["icon"] = 2967105,
		}, -- [3]
		{
			["essenceID"] = 13,
			["name"] = "Nullification Dynamo",
			["icon"] = 3015741,
		}, -- [4]
		{
			["essenceID"] = 25,
			["name"] = "Aegis of the Deep",
			["icon"] = 2967110,
		}, -- [5]
		{
			["essenceID"] = 33,
			["name"] = "Touch of the Everlasting",
			["icon"] = 3193847,
		}, -- [6]
		{
			["essenceID"] = 34,
			["name"] = "Strength of the Warden",
			["icon"] = 3193846,
		}, -- [7]
	},
	["healer"] = {
		{
			["essenceID"] = 16,
			["name"] = "Unwavering Ward",
			["icon"] = 3193842,
		}, -- [1]
		{
			["essenceID"] = 17,
			["name"] = "The Ever-Rising Tide",
			["icon"] = 2967108,
		}, -- [2]
		{
			["essenceID"] = 18,
			["name"] = "Artifice of Time",
			["icon"] = 2967112,
		}, -- [3]
		{
			["essenceID"] = 19,
			["name"] = "The Well of Existence",
			["icon"] = 516796,
		}, -- [4]
		{
			["essenceID"] = 20,
			["name"] = "Life-Binder's Invocation",
			["icon"] = 2967106,
		}, -- [5]
		{
			["essenceID"] = 21,
			["name"] = "Vitality Conduit",
			["icon"] = 2967100,
		}, -- [6]
		{
			["essenceID"] = 24,
			["name"] = "Spirit of Preservation",
			["icon"] = 2967101,
		}, -- [7]
	},
	["damager"] = {
		{
			["essenceID"] = 5,
			["name"] = "Essence of the Focusing Iris",
			["icon"] = 2967111,
		}, -- [1]
		{
			["essenceID"] = 6,
			["name"] = "Purification Protocol",
			["icon"] = 2967103,
		}, -- [2]
		{
			["essenceID"] = 14,
			["name"] = "Condensed Life-Force",
			["icon"] = 2967113,
		}, -- [3]
		{
			["essenceID"] = 23,
			["name"] = "Blood of the Enemy",
			["icon"] = 2032580,
		}, -- [4]
		{
			["essenceID"] = 28,
			["name"] = "The Unbound Force",
			["icon"] = 2967102,
		}, -- [5]
		{
			["essenceID"] = 35,
			["name"] = "Breath of the Dying",
			["icon"] = 3193844,
		}, -- [6]
		{
			["essenceID"] = 36,
			["name"] = "Spark of Inspiration",
			["icon"] = 3193843,
		}, -- [7]
	}
}
n.essenceData = essenceData

-- Default Scales Data
--[[
local defaultName = L.DefaultScaleName_Default
local defensiveName = L.DefaultScaleName_Defensive
local offensiveName = L.DefaultScaleName_Offensive
local defaultNameTable = {
	--[defaultName] = true,
	[defensiveName] = true,
	[offensiveName] = true
}
]]
local defaultName = "Default"
local defensiveName = "Defensive"
local offensiveName = "Offensive"
local defaultNameTable = {
	[defaultName] = L.DefaultScaleName_Default,
	[defensiveName] = L.DefaultScaleName_Defensive,
	[offensiveName] = L.DefaultScaleName_Offensive
}
n.defaultNameTable = defaultNameTable
local defaultScalesData = {}
n.defaultScalesData = defaultScalesData

local function insertDefaultScalesData(scaleName, classIndex, specNum, powerScales, essenceScales, timestamp)
	defaultScalesData[#defaultScalesData + 1] = {
		scaleName,
		classIndex,
		specNum,
		powerScales,
		essenceScales,
		timestamp
	}
end

do
		insertDefaultScalesData(defaultName, 12, 1, { -- Havoc Demon Hunter
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 18501 - 21003 (avg 19718), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[522] = 5.93, -- Ancients' Bulwark
			[500] = 2.03, -- Synaptic Spark Capacitor
			[497] = 0.61, -- Stand As One
			[575] = 6.36, -- Undulating Tides
			[157] = 3.87, -- Rezan's Fury
			[562] = 4.54, -- Treacherous Covenant
			[495] = 2.76, -- Anduin's Dedication
			[577] = 3.29, -- Arcane Heart
			[126] = 3.84, -- Revolving Blades
			[479] = 4.3, -- Dagger in the Back
			[485] = 3.08, -- Laser Matrix
			[18] = 0.84, -- Blood Siphon
			[582] = 5.48, -- Heart of Darkness
			[505] = 2.86, -- Tradewinds
			[501] = 3.94, -- Relational Normalization Gizmo
			[498] = 2.58, -- Barrage Of Many Bombs
			[521] = 4.41, -- Shadow of Elune
			[192] = 3.37, -- Meticulous Scheming
			[22] = 1.43, -- Heed My Call
			[523] = 3.12, -- Apothecary's Concoctions
			[576] = 1.54, -- Loyal to the End
			[193] = 5.82, -- Blightborne Infusion
			[245] = 3.13, -- Seething Power
			[461] = 0.96, -- Earthlink
			[31] = 1.92, -- Gutripper
			[494] = 3.99, -- Battlefield Precision
			[196] = 4.76, -- Swirling Sands
			[38] = 1.49, -- On My Way
			[82] = 5.45, -- Champion of Azeroth
			[478] = 3.78, -- Tidal Surge
			[352] = 4.59, -- Thirsting Blades
			[541] = 1.16, -- Fight or Flight
			[156] = 2.06, -- Ruinous Bolt
			[481] = 2.33, -- Incite the Pack
			[504] = 2.42, -- Unstable Catalyst
			[483] = 3.19, -- Archive of the Titans
			[561] = 2.32, -- Seductive Power
			[480] = 4.57, -- Blood Rite
			[353] = 5.32, -- Eyes of Rage
			[195] = 2.86, -- Secrets of the Deep
			[459] = 1.78, -- Unstable Flames
			[526] = 5.64, -- Endless Hunger
			[560] = 2.2, -- Bonded Souls
			[492] = 3.88, -- Liberator's Might
			[21] = 1.62, -- Elemental Whirl
			[482] = 3.08, -- Thunderous Blast
			[30] = 3.21, -- Overwhelming Power
			[159] = 10, -- Furious Gaze
			[462] = 1.07, -- Azerite Globules
			[220] = 3.86, -- Chaotic Transformation
			[499] = 1.24, -- Ricocheting Inflatable Pyrosaw
			[493] = 1.35, -- Last Gift
			[194] = 2.96, -- Filthy Transfusion
			[496] = 1.15, -- Stronger Together
			[20] = 2.2, -- Lifespeed
			[569] = 6.08, -- Clockwork Heart
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 17501 - 20301 (avg 19389), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[23] = { 5.87, 2.56 }, -- Blood of the Enemy
			[37] = { 2.18, 2.22 }, -- The Formless Void
			[4] = { 3.38, 0.61 }, -- Worldvein Resonance
			[6] = { 4.66, 1.93 }, -- Purification Protocol
			[22] = { 5.52, 0 }, -- Vision of Perfection
			[32] = { 0, 1.92 }, -- Conflict and Strife
			[28] = { 4.41, 1.66 }, -- The Unbound Force
			[35] = { 10, 4.46 }, -- Breath of the Dying
			[12] = { 5.09, 1.93 }, -- The Crucible of Flame
			[36] = { 0.94, 0.97 }, -- Spark of Inspiration
			[5] = { 7.31, 4.1 }, -- Essence of the Focusing Iris
			[14] = { 6.02, 2.21 }, -- Condensed Life-Force
			[27] = { 2.1, 1.13 }, -- Memory of Lucid Dreams
			[15] = { 2.48, 0 }, -- Ripple in Space
		}, 1589360400)

		insertDefaultScalesData(offensiveName, 12, 2, { -- Vengeance Demon Hunter
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 3301 - 4101 (avg 3485), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[521] = 3.81, -- Shadow of Elune
			[564] = 0.18, -- Thrive in Chaos
			[38] = 1.95, -- On My Way
			[196] = 6.16, -- Swirling Sands
			[494] = 6.39, -- Battlefield Precision
			[246] = 0.07, -- Hour of Reaping
			[502] = 0.07, -- Personal Absorb-o-Tron
			[156] = 3.83, -- Ruinous Bolt
			[500] = 3.29, -- Synaptic Spark Capacitor
			[195] = 3.41, -- Secrets of the Deep
			[501] = 4.24, -- Relational Normalization Gizmo
			[495] = 3.19, -- Anduin's Dedication
			[21] = 2.1, -- Elemental Whirl
			[42] = 0.03, -- Savior
			[560] = 1.77, -- Bonded Souls
			[462] = 1.83, -- Azerite Globules
			[480] = 4.12, -- Blood Rite
			[582] = 5.79, -- Heart of Darkness
			[485] = 5.21, -- Laser Matrix
			[482] = 5.28, -- Thunderous Blast
			[576] = 2.25, -- Loyal to the End
			[31] = 3.27, -- Gutripper
			[19] = 0.08, -- Woundbinder
			[481] = 3.29, -- Incite the Pack
			[22] = 2.71, -- Heed My Call
			[562] = 5.07, -- Treacherous Covenant
			[526] = 7.06, -- Endless Hunger
			[478] = 6.14, -- Tidal Surge
			[561] = 3.77, -- Seductive Power
			[86] = 0.12, -- Azerite Fortification
			[20] = 2.04, -- Lifespeed
			[89] = 0.05, -- Azerite Veins
			[479] = 4.71, -- Dagger in the Back
			[504] = 3.12, -- Unstable Catalyst
			[194] = 5.01, -- Filthy Transfusion
			[355] = 0.19, -- Essence Sever
			[577] = 2.24, -- Arcane Heart
			[497] = 0.78, -- Stand As One
			[43] = 0.12, -- Winds of War
			[160] = 0.03, -- Infernal Armor
			[541] = 1.24, -- Fight or Flight
			[499] = 2.6, -- Ricocheting Inflatable Pyrosaw
			[157] = 6.25, -- Rezan's Fury
			[505] = 3.48, -- Tradewinds
			[569] = 6.55, -- Clockwork Heart
			[575] = 10, -- Undulating Tides
			[99] = 0.06, -- Ablative Shielding
			[483] = 3.84, -- Archive of the Titans
			[98] = 0.54, -- Crystalline Carapace
			[522] = 6.8, -- Ancients' Bulwark
			[30] = 2.98, -- Overwhelming Power
			[493] = 1.75, -- Last Gift
			[496] = 1.55, -- Stronger Together
			[84] = 0.17, -- Bulwark of the Masses
			[193] = 7.02, -- Blightborne Infusion
			[103] = 0.14, -- Concentrated Mending
			[498] = 3.99, -- Barrage Of Many Bombs
			[492] = 4.21, -- Liberator's Might
			[459] = 2.48, -- Unstable Flames
			[82] = 6.2, -- Champion of Azeroth
			[523] = 5.28, -- Apothecary's Concoctions
			[18] = 1.29, -- Blood Siphon
			[461] = 1.03, -- Earthlink
			[192] = 5.07, -- Meticulous Scheming
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 3203 - 3700 (avg 3439), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[3] = { 3.88, 3.84 }, -- Sphere of Suppression
			[25] = { 1.01, 0.95 }, -- Aegis of the Deep
			[27] = { 1.56, 1.39 }, -- Memory of Lucid Dreams
			[12] = { 10, 2.88 }, -- The Crucible of Flame
			[32] = { 2.1, 2.07 }, -- Conflict and Strife
			[4] = { 3.45, 0.85 }, -- Worldvein Resonance
			[33] = { 0.04, 0.01 }, -- Touch of the Everlasting
			[37] = { 2.38, 2.35 }, -- The Formless Void
			[15] = { 3.43, 0 }, -- Ripple in Space
			[7] = { 5.08, 1.53 }, -- Anima of Life and Death
			[34] = { 0, 0.06 }, -- Strength of the Warden
			[13] = { 0, 0.05 }, -- Nullification Dynamo
			[22] = { 2.59, 0.78 }, -- Vision of Perfection
		}, 1589360400)

		insertDefaultScalesData(offensiveName, 6, 1, { -- Blood Death Knight
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 4601 - 5790 (avg 4988), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[82] = 6.43, -- Champion of Azeroth
			[485] = 5.29, -- Laser Matrix
			[461] = 0.9, -- Earthlink
			[20] = 1.89, -- Lifespeed
			[494] = 6.28, -- Battlefield Precision
			[31] = 3.1, -- Gutripper
			[479] = 4.45, -- Dagger in the Back
			[501] = 4.27, -- Relational Normalization Gizmo
			[582] = 6.24, -- Heart of Darkness
			[504] = 2.67, -- Unstable Catalyst
			[521] = 4.32, -- Shadow of Elune
			[496] = 1.45, -- Stronger Together
			[462] = 1.53, -- Azerite Globules
			[195] = 3.11, -- Secrets of the Deep
			[140] = 0.45, -- Bone Spike Graveyard
			[502] = 0.04, -- Personal Absorb-o-Tron
			[478] = 5.83, -- Tidal Surge
			[21] = 2.07, -- Elemental Whirl
			[482] = 5.19, -- Thunderous Blast
			[481] = 3.19, -- Incite the Pack
			[560] = 2.07, -- Bonded Souls
			[523] = 5.2, -- Apothecary's Concoctions
			[106] = 1.75, -- Deep Cuts
			[18] = 1.07, -- Blood Siphon
			[500] = 3.16, -- Synaptic Spark Capacitor
			[193] = 7.82, -- Blightborne Infusion
			[492] = 4.24, -- Liberator's Might
			[22] = 2.51, -- Heed My Call
			[499] = 2.3, -- Ricocheting Inflatable Pyrosaw
			[575] = 10, -- Undulating Tides
			[562] = 5.03, -- Treacherous Covenant
			[576] = 2.09, -- Loyal to the End
			[243] = 4.35, -- Bloody Runeblade
			[156] = 3.49, -- Ruinous Bolt
			[493] = 1.8, -- Last Gift
			[526] = 8.04, -- Endless Hunger
			[349] = 0.26, -- Bones of the Damned
			[196] = 6.31, -- Swirling Sands
			[561] = 3.77, -- Seductive Power
			[480] = 4.34, -- Blood Rite
			[30] = 3.13, -- Overwhelming Power
			[505] = 3.31, -- Tradewinds
			[483] = 3.62, -- Archive of the Titans
			[98] = 0.28, -- Crystalline Carapace
			[497] = 0.82, -- Stand As One
			[157] = 6.36, -- Rezan's Fury
			[192] = 5.58, -- Meticulous Scheming
			[348] = 3.1, -- Eternal Rune Weapon
			[577] = 1.9, -- Arcane Heart
			[541] = 0.84, -- Fight or Flight
			[495] = 3.16, -- Anduin's Dedication
			[498] = 3.87, -- Barrage Of Many Bombs
			[522] = 8.16, -- Ancients' Bulwark
			[569] = 7.56, -- Clockwork Heart
			[459] = 2.75, -- Unstable Flames
			[194] = 4.92, -- Filthy Transfusion
			[38] = 2.13, -- On My Way
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 4402 - 5103 (avg 4901), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[4] = { 3.59, 0.7 }, -- Worldvein Resonance
			[12] = { 10, 2.74 }, -- The Crucible of Flame
			[15] = { 3.6, 0 }, -- Ripple in Space
			[37] = { 2.06, 2.06 }, -- The Formless Void
			[22] = { 0.84, 0.3 }, -- Vision of Perfection
			[32] = { 2.29, 2.44 }, -- Conflict and Strife
			[3] = { 4.29, 4.32 }, -- Sphere of Suppression
			[7] = { 4.93, 1.7 }, -- Anima of Life and Death
			[25] = { 1.05, 0.99 }, -- Aegis of the Deep
			[27] = { 4.83, 3.17 }, -- Memory of Lucid Dreams
		}, 1589360400)

		insertDefaultScalesData(defaultName, 6, 2, { -- Frost Death Knight
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 16202 - 17802 (avg 17016), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[21] = 2.87, -- Elemental Whirl
			[523] = 3.98, -- Apothecary's Concoctions
			[42] = 0.19, -- Savior
			[194] = 4, -- Filthy Transfusion
			[30] = 4.08, -- Overwhelming Power
			[483] = 5.59, -- Archive of the Titans
			[569] = 8.23, -- Clockwork Heart
			[497] = 1.14, -- Stand As One
			[478] = 4.31, -- Tidal Surge
			[156] = 2.82, -- Ruinous Bolt
			[103] = 0.11, -- Concentrated Mending
			[482] = 4.07, -- Thunderous Blast
			[347] = 5.39, -- Frozen Tempest
			[504] = 4.36, -- Unstable Catalyst
			[461] = 1.56, -- Earthlink
			[44] = 0.03, -- Vampiric Speed
			[500] = 2.53, -- Synaptic Spark Capacitor
			[100] = 0.02, -- Strength in Numbers
			[479] = 5.31, -- Dagger in the Back
			[346] = 4.37, -- Killer Frost
			[85] = 0.05, -- Gemhide
			[526] = 10, -- Endless Hunger
			[522] = 9.9, -- Ancients' Bulwark
			[14] = 0.08, -- Longstrider
			[198] = 3.86, -- Frostwhelp's Indignation
			[493] = 3.29, -- Last Gift
			[242] = 4.29, -- Echoing Howl
			[485] = 3.98, -- Laser Matrix
			[496] = 1.89, -- Stronger Together
			[193] = 8.81, -- Blightborne Infusion
			[562] = 7.88, -- Treacherous Covenant
			[541] = 2.03, -- Fight or Flight
			[494] = 5.13, -- Battlefield Precision
			[549] = 0.23, -- Cold Hearted
			[87] = 0.02, -- Self Reliance
			[498] = 3.56, -- Barrage Of Many Bombs
			[31] = 2.52, -- Gutripper
			[561] = 4.34, -- Seductive Power
			[577] = 6.04, -- Arcane Heart
			[521] = 5.4, -- Shadow of Elune
			[18] = 2.71, -- Blood Siphon
			[480] = 5.61, -- Blood Rite
			[465] = 0.06, -- March of the Damned
			[575] = 7.74, -- Undulating Tides
			[505] = 6.35, -- Tradewinds
			[501] = 5.9, -- Relational Normalization Gizmo
			[157] = 5.24, -- Rezan's Fury
			[495] = 4.94, -- Anduin's Dedication
			[38] = 2.85, -- On My Way
			[560] = 2.79, -- Bonded Souls
			[582] = 8.46, -- Heart of Darkness
			[192] = 5.76, -- Meticulous Scheming
			[20] = 2.81, -- Lifespeed
			[462] = 1.58, -- Azerite Globules
			[481] = 5.78, -- Incite the Pack
			[108] = 5.67, -- Icy Citadel
			[576] = 4.16, -- Loyal to the End
			[19] = 0.15, -- Woundbinder
			[459] = 3.19, -- Unstable Flames
			[141] = 4.77, -- Latent Chill
			[22] = 2.05, -- Heed My Call
			[82] = 8.58, -- Champion of Azeroth
			[492] = 5.51, -- Liberator's Might
			[195] = 5.02, -- Secrets of the Deep
			[499] = 2.13, -- Ricocheting Inflatable Pyrosaw
			[196] = 7.3, -- Swirling Sands
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 15302 - 17702 (avg 16653), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[28] = { 4.89, 2.16 }, -- The Unbound Force
			[22] = { 2.66, 0 }, -- Vision of Perfection
			[27] = { 8.8, 4.83 }, -- Memory of Lucid Dreams
			[14] = { 5.72, 2.37 }, -- Condensed Life-Force
			[35] = { 10, 4.4 }, -- Breath of the Dying
			[15] = { 3.48, 0 }, -- Ripple in Space
			[32] = { 6.38, 2.66 }, -- Conflict and Strife
			[37] = { 3.16, 3.11 }, -- The Formless Void
			[12] = { 5.55, 2.08 }, -- The Crucible of Flame
			[36] = { 0.85, 0.96 }, -- Spark of Inspiration
			[6] = { 5.08, 1.88 }, -- Purification Protocol
			[5] = { 8, 4.04 }, -- Essence of the Focusing Iris
			[23] = { 8.12, 1.96 }, -- Blood of the Enemy
			[4] = { 5.5, 0.98 }, -- Worldvein Resonance
		}, 1589360400)

		insertDefaultScalesData(defaultName, 6, 3, { -- Unholy Death Knight
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 5800 - 8055 (avg 6277), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[576] = 3.34, -- Loyal to the End
			[478] = 4.63, -- Tidal Surge
			[522] = 9.38, -- Ancients' Bulwark
			[462] = 1.77, -- Azerite Globules
			[201] = 0.07, -- Runic Barrier
			[541] = 1.38, -- Fight or Flight
			[569] = 8.86, -- Clockwork Heart
			[84] = 0.05, -- Bulwark of the Masses
			[18] = 1.59, -- Blood Siphon
			[493] = 2.63, -- Last Gift
			[497] = 0.87, -- Stand As One
			[30] = 3.68, -- Overwhelming Power
			[485] = 4.61, -- Laser Matrix
			[561] = 4.5, -- Seductive Power
			[351] = 2.43, -- Last Surprise
			[461] = 1.86, -- Earthlink
			[20] = 2, -- Lifespeed
			[481] = 4.39, -- Incite the Pack
			[482] = 4.85, -- Thunderous Blast
			[505] = 5.04, -- Tradewinds
			[156] = 2.67, -- Ruinous Bolt
			[521] = 4.82, -- Shadow of Elune
			[83] = 0.22, -- Impassive Visage
			[38] = 2.45, -- On My Way
			[109] = 6.22, -- Magus of the Dead
			[194] = 4.86, -- Filthy Transfusion
			[459] = 3.07, -- Unstable Flames
			[193] = 8.88, -- Blightborne Infusion
			[192] = 5.56, -- Meticulous Scheming
			[82] = 7.36, -- Champion of Azeroth
			[498] = 3.64, -- Barrage Of Many Bombs
			[142] = 4.59, -- Helchains
			[523] = 4.81, -- Apothecary's Concoctions
			[492] = 5.12, -- Liberator's Might
			[480] = 4.72, -- Blood Rite
			[157] = 5.7, -- Rezan's Fury
			[526] = 9.64, -- Endless Hunger
			[244] = 5.52, -- Harrowing Decay
			[582] = 7.31, -- Heart of Darkness
			[575] = 9.36, -- Undulating Tides
			[195] = 4.89, -- Secrets of the Deep
			[196] = 7.35, -- Swirling Sands
			[560] = 2.81, -- Bonded Souls
			[504] = 4.37, -- Unstable Catalyst
			[495] = 4.77, -- Anduin's Dedication
			[562] = 7.86, -- Treacherous Covenant
			[494] = 5.78, -- Battlefield Precision
			[499] = 2.19, -- Ricocheting Inflatable Pyrosaw
			[101] = 0.02, -- Shimmering Haven
			[479] = 5.97, -- Dagger in the Back
			[103] = 0.07, -- Concentrated Mending
			[21] = 2.43, -- Elemental Whirl
			[577] = 2.92, -- Arcane Heart
			[85] = 0.14, -- Gemhide
			[19] = 0.19, -- Woundbinder
			[22] = 2.57, -- Heed My Call
			[500] = 2.45, -- Synaptic Spark Capacitor
			[496] = 2.08, -- Stronger Together
			[483] = 5.19, -- Archive of the Titans
			[199] = 10, -- Festermight
			[501] = 5.1, -- Relational Normalization Gizmo
			[31] = 2.53, -- Gutripper
			[350] = 3.78, -- Cankerous Wounds
			[549] = 0.25, -- Cold Hearted
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 5700 - 9430 (avg 6308), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[37] = { 3.01, 2.65 }, -- The Formless Void
			[14] = { 5.91, 2.43 }, -- Condensed Life-Force
			[4] = { 5.16, 0.92 }, -- Worldvein Resonance
			[5] = { 8.12, 3.12 }, -- Essence of the Focusing Iris
			[23] = { 4.76, 1 }, -- Blood of the Enemy
			[36] = { 0.6, 0.69 }, -- Spark of Inspiration
			[32] = { 2.37, 2.09 }, -- Conflict and Strife
			[15] = { 3.6, 0 }, -- Ripple in Space
			[22] = { 4.71, 1.59 }, -- Vision of Perfection
			[12] = { 5.89, 2.09 }, -- The Crucible of Flame
			[6] = { 5.29, 2.08 }, -- Purification Protocol
			[27] = { 4.68, 2.99 }, -- Memory of Lucid Dreams
			[28] = { 5.03, 2.07 }, -- The Unbound Force
			[35] = { 10, 4.55 }, -- Breath of the Dying
		}, 1589360400)

		insertDefaultScalesData(defaultName, 11, 1, { -- Balance Druid
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 4400 - 5501 (avg 4642), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[479] = 3.79, -- Dagger in the Back
			[575] = 5.7, -- Undulating Tides
			[30] = 3.02, -- Overwhelming Power
			[503] = 0.28, -- Auto-Self-Cauterizer
			[83] = 0.1, -- Impassive Visage
			[501] = 3.8, -- Relational Normalization Gizmo
			[219] = 0.18, -- Reawakening
			[195] = 3.01, -- Secrets of the Deep
			[194] = 3.2, -- Filthy Transfusion
			[523] = 3.03, -- Apothecary's Concoctions
			[44] = 0.31, -- Vampiric Speed
			[86] = 0.11, -- Azerite Fortification
			[480] = 3.93, -- Blood Rite
			[99] = 0.15, -- Ablative Shielding
			[481] = 4.08, -- Incite the Pack
			[478] = 3.23, -- Tidal Surge
			[13] = 0.1, -- Azerite Empowered
			[101] = 0.07, -- Shimmering Haven
			[156] = 1.94, -- Ruinous Bolt
			[105] = 0.08, -- Ephemeral Recovery
			[526] = 6.48, -- Endless Hunger
			[561] = 2.79, -- Seductive Power
			[483] = 3.31, -- Archive of the Titans
			[22] = 1.81, -- Heed My Call
			[482] = 3.08, -- Thunderous Blast
			[43] = 0.25, -- Winds of War
			[502] = 0.09, -- Personal Absorb-o-Tron
			[357] = 0.25, -- Lunar Shrapnel
			[98] = 0.12, -- Crystalline Carapace
			[540] = 0.07, -- Switch Hitter
			[576] = 3.1, -- Loyal to the End
			[461] = 0.98, -- Earthlink
			[18] = 1.71, -- Blood Siphon
			[562] = 4.86, -- Treacherous Covenant
			[173] = 2.45, -- Power of the Moon
			[582] = 5.67, -- Heart of Darkness
			[87] = 0.19, -- Self Reliance
			[499] = 1.41, -- Ricocheting Inflatable Pyrosaw
			[493] = 2.48, -- Last Gift
			[505] = 4.61, -- Tradewinds
			[463] = 0.19, -- Blessed Portents
			[100] = 0.1, -- Strength in Numbers
			[250] = 3.38, -- Dawning Sun
			[82] = 5.75, -- Champion of Azeroth
			[459] = 2.35, -- Unstable Flames
			[38] = 1.9, -- On My Way
			[560] = 2.16, -- Bonded Souls
			[31] = 1.84, -- Gutripper
			[200] = 10, -- Arcanic Pulsar
			[568] = 0.16, -- Person-Computer Interface
			[122] = 3.71, -- Streaking Stars
			[89] = 0.19, -- Azerite Veins
			[364] = 3.09, -- Lively Spirit
			[104] = 0.16, -- Bracing Chill
			[569] = 6.79, -- Clockwork Heart
			[521] = 3.87, -- Shadow of Elune
			[541] = 1.26, -- Fight or Flight
			[103] = 0.22, -- Concentrated Mending
			[42] = 0.26, -- Savior
			[496] = 1.5, -- Stronger Together
			[577] = 3.45, -- Arcane Heart
			[462] = 1.18, -- Azerite Globules
			[500] = 1.6, -- Synaptic Spark Capacitor
			[522] = 6.4, -- Ancients' Bulwark
			[485] = 3.06, -- Laser Matrix
			[84] = 0.14, -- Bulwark of the Masses
			[467] = 0.08, -- Ursoc's Endurance
			[85] = 0.17, -- Gemhide
			[15] = 0.19, -- Resounding Protection
			[356] = 1.58, -- High Noon
			[495] = 2.9, -- Anduin's Dedication
			[498] = 2.41, -- Barrage Of Many Bombs
			[196] = 5.45, -- Swirling Sands
			[20] = 2.1, -- Lifespeed
			[494] = 3.53, -- Battlefield Precision
			[504] = 2.99, -- Unstable Catalyst
			[492] = 3.9, -- Liberator's Might
			[497] = 1.01, -- Stand As One
			[193] = 6.4, -- Blightborne Infusion
			[192] = 4.68, -- Meticulous Scheming
			[21] = 2.28, -- Elemental Whirl
			[157] = 3.41, -- Rezan's Fury
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 4302 - 6143 (avg 4690), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[15] = { 2.36, 0.12 }, -- Ripple in Space
			[27] = { 4.9, 2.66 }, -- Memory of Lucid Dreams
			[22] = { 5.83, 2.27 }, -- Vision of Perfection
			[6] = { 4.05, 2.18 }, -- Purification Protocol
			[28] = { 4.68, 3.05 }, -- The Unbound Force
			[14] = { 6.14, 2.52 }, -- Condensed Life-Force
			[37] = { 2.76, 2.9 }, -- The Formless Void
			[5] = { 6.64, 4.3 }, -- Essence of the Focusing Iris
			[35] = { 8.58, 4.65 }, -- Breath of the Dying
			[4] = { 3.78, 1.15 }, -- Worldvein Resonance
			[36] = { 1.1, 1.14 }, -- Spark of Inspiration
			[12] = { 3.94, 2.36 }, -- The Crucible of Flame
			[23] = { 5.38, 1.88 }, -- Blood of the Enemy
			[32] = { 10, 2.63 }, -- Conflict and Strife
		}, 1589360400)

		insertDefaultScalesData(defaultName, 11, 2, { -- Feral Druid
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 5900 - 6800 (avg 6300), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[495] = 2.73, -- Anduin's Dedication
			[522] = 5.72, -- Ancients' Bulwark
			[505] = 3.71, -- Tradewinds
			[111] = 2.88, -- Blood Mist
			[463] = 0.13, -- Blessed Portents
			[483] = 3.12, -- Archive of the Titans
			[171] = 0.12, -- Masterful Instincts
			[467] = 0.01, -- Ursoc's Endurance
			[100] = 0.16, -- Strength in Numbers
			[501] = 2.97, -- Relational Normalization Gizmo
			[22] = 1.51, -- Heed My Call
			[44] = 0.09, -- Vampiric Speed
			[43] = 0.1, -- Winds of War
			[30] = 2.04, -- Overwhelming Power
			[568] = 0.11, -- Person-Computer Interface
			[504] = 2.42, -- Unstable Catalyst
			[540] = 0.02, -- Switch Hitter
			[582] = 4.78, -- Heart of Darkness
			[523] = 2.58, -- Apothecary's Concoctions
			[82] = 5.09, -- Champion of Azeroth
			[209] = 10, -- Jungle Fury
			[482] = 2.46, -- Thunderous Blast
			[89] = 0.1, -- Azerite Veins
			[561] = 2.29, -- Seductive Power
			[195] = 2.75, -- Secrets of the Deep
			[526] = 5.5, -- Endless Hunger
			[459] = 2.09, -- Unstable Flames
			[87] = 0.12, -- Self Reliance
			[21] = 1.62, -- Elemental Whirl
			[499] = 1.2, -- Ricocheting Inflatable Pyrosaw
			[38] = 1.72, -- On My Way
			[577] = 3.17, -- Arcane Heart
			[560] = 1.33, -- Bonded Souls
			[562] = 4.12, -- Treacherous Covenant
			[493] = 1.98, -- Last Gift
			[99] = 0.1, -- Ablative Shielding
			[194] = 2.31, -- Filthy Transfusion
			[461] = 0.99, -- Earthlink
			[575] = 4.91, -- Undulating Tides
			[492] = 3.35, -- Liberator's Might
			[498] = 2.08, -- Barrage Of Many Bombs
			[569] = 5.44, -- Clockwork Heart
			[98] = 0.02, -- Crystalline Carapace
			[481] = 3.41, -- Incite the Pack
			[156] = 1.81, -- Ruinous Bolt
			[20] = 1.47, -- Lifespeed
			[157] = 3.14, -- Rezan's Fury
			[358] = 3.1, -- Gushing Lacerations
			[196] = 4.95, -- Swirling Sands
			[576] = 2.47, -- Loyal to the End
			[193] = 5.83, -- Blightborne Infusion
			[497] = 0.69, -- Stand As One
			[359] = 4.18, -- Wild Fleshrending
			[85] = 0.06, -- Gemhide
			[462] = 0.85, -- Azerite Globules
			[500] = 1.72, -- Synaptic Spark Capacitor
			[192] = 3.37, -- Meticulous Scheming
			[485] = 2.7, -- Laser Matrix
			[18] = 1.23, -- Blood Siphon
			[478] = 3.13, -- Tidal Surge
			[31] = 1.55, -- Gutripper
			[241] = 0.13, -- Twisted Claws
			[19] = 0.09, -- Woundbinder
			[247] = 1.25, -- Iron Jaws
			[86] = 0.07, -- Azerite Fortification
			[494] = 3.01, -- Battlefield Precision
			[173] = 0.03, -- Power of the Moon
			[169] = 1.71, -- Untamed Ferocity
			[15] = 0.07, -- Resounding Protection
			[479] = 3.16, -- Dagger in the Back
			[541] = 1.05, -- Fight or Flight
			[521] = 2.83, -- Shadow of Elune
			[480] = 2.67, -- Blood Rite
			[496] = 1.13, -- Stronger Together
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 5701 - 6404 (avg 6146), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[22] = { 2.38, 0.8 }, -- Vision of Perfection
			[32] = { 10, 2.21 }, -- Conflict and Strife
			[6] = { 4.37, 1.79 }, -- Purification Protocol
			[35] = { 8.88, 3.78 }, -- Breath of the Dying
			[37] = { 2.29, 2.34 }, -- The Formless Void
			[5] = { 7.65, 2.76 }, -- Essence of the Focusing Iris
			[36] = { 0.69, 0.77 }, -- Spark of Inspiration
			[28] = { 3.8, 1.85 }, -- The Unbound Force
			[23] = { 4.91, 1.13 }, -- Blood of the Enemy
			[14] = { 4.61, 1.99 }, -- Condensed Life-Force
			[4] = { 4.14, 0.89 }, -- Worldvein Resonance
			[12] = { 4.83, 1.85 }, -- The Crucible of Flame
			[15] = { 2.63, 0.06 }, -- Ripple in Space
			[27] = { 3.11, 2.3 }, -- Memory of Lucid Dreams
		}, 1589360400)

		insertDefaultScalesData(offensiveName, 11, 3, { -- Guardian Druid
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 1600 - 2404 (avg 1774), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[98] = 0.82, -- Crystalline Carapace
			[483] = 4.51, -- Archive of the Titans
			[501] = 4.84, -- Relational Normalization Gizmo
			[504] = 3.56, -- Unstable Catalyst
			[494] = 6.32, -- Battlefield Precision
			[480] = 4.66, -- Blood Rite
			[478] = 6.17, -- Tidal Surge
			[89] = 0.09, -- Azerite Veins
			[462] = 1.61, -- Azerite Globules
			[82] = 7.65, -- Champion of Azeroth
			[101] = 0.02, -- Shimmering Haven
			[83] = 0.07, -- Impassive Visage
			[561] = 4.4, -- Seductive Power
			[105] = 0.21, -- Ephemeral Recovery
			[479] = 4.57, -- Dagger in the Back
			[482] = 5.37, -- Thunderous Blast
			[361] = 4.7, -- Guardian's Wrath
			[526] = 8.09, -- Endless Hunger
			[20] = 2.41, -- Lifespeed
			[495] = 3.78, -- Anduin's Dedication
			[498] = 4.38, -- Barrage Of Many Bombs
			[463] = 0.09, -- Blessed Portents
			[196] = 7.13, -- Swirling Sands
			[461] = 1.32, -- Earthlink
			[43] = 0.18, -- Winds of War
			[459] = 2.95, -- Unstable Flames
			[560] = 2.3, -- Bonded Souls
			[193] = 8.77, -- Blightborne Infusion
			[22] = 2.62, -- Heed My Call
			[241] = 3.81, -- Twisted Claws
			[497] = 0.99, -- Stand As One
			[156] = 3.88, -- Ruinous Bolt
			[157] = 6.26, -- Rezan's Fury
			[15] = 0.09, -- Resounding Protection
			[577] = 3, -- Arcane Heart
			[84] = 0.13, -- Bulwark of the Masses
			[31] = 2.95, -- Gutripper
			[541] = 1.53, -- Fight or Flight
			[18] = 1.98, -- Blood Siphon
			[195] = 4.07, -- Secrets of the Deep
			[485] = 5, -- Laser Matrix
			[30] = 3.56, -- Overwhelming Power
			[499] = 2.36, -- Ricocheting Inflatable Pyrosaw
			[502] = 0.11, -- Personal Absorb-o-Tron
			[569] = 7.72, -- Clockwork Heart
			[19] = 0.05, -- Woundbinder
			[505] = 5.48, -- Tradewinds
			[496] = 1.69, -- Stronger Together
			[171] = 0.06, -- Masterful Instincts
			[500] = 3.26, -- Synaptic Spark Capacitor
			[492] = 4.97, -- Liberator's Might
			[521] = 4.63, -- Shadow of Elune
			[21] = 2.93, -- Elemental Whirl
			[582] = 7.19, -- Heart of Darkness
			[14] = 0.13, -- Longstrider
			[576] = 3.59, -- Loyal to the End
			[251] = 5.86, -- Burst of Savagery
			[503] = 0.09, -- Auto-Self-Cauterizer
			[522] = 8.3, -- Ancients' Bulwark
			[38] = 2.46, -- On My Way
			[575] = 10, -- Undulating Tides
			[493] = 3.02, -- Last Gift
			[85] = 0.04, -- Gemhide
			[192] = 6.35, -- Meticulous Scheming
			[13] = 0.03, -- Azerite Empowered
			[523] = 5.05, -- Apothecary's Concoctions
			[359] = 1.71, -- Wild Fleshrending
			[104] = 0.15, -- Bracing Chill
			[562] = 6.39, -- Treacherous Covenant
			[194] = 5.36, -- Filthy Transfusion
			[568] = 0.01, -- Person-Computer Interface
			[481] = 5.16, -- Incite the Pack
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 1600 - 1903 (avg 1750), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[22] = { 1.39, 0 }, -- Vision of Perfection
			[15] = { 3.23, 0 }, -- Ripple in Space
			[32] = { 10, 3 }, -- Conflict and Strife
			[2] = { 0, 0.02 }, -- Azeroth's Undying Gift
			[4] = { 4.01, 1.25 }, -- Worldvein Resonance
			[25] = { 1.54, 1.7 }, -- Aegis of the Deep
			[7] = { 6.36, 2.87 }, -- Anima of Life and Death
			[33] = { 0.02, 0 }, -- Touch of the Everlasting
			[34] = { 0.05, 0 }, -- Strength of the Warden
			[3] = { 6.31, 6.29 }, -- Sphere of Suppression
			[27] = { 0.85, 0.57 }, -- Memory of Lucid Dreams
			[12] = { 9.07, 3.53 }, -- The Crucible of Flame
			[37] = { 3.31, 3.37 }, -- The Formless Void
		}, 1589360400)

		insertDefaultScalesData(defaultName, 3, 1, { -- Beast Mastery Hunter
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 3400 - 7340 (avg 3773), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[196] = 4.31, -- Swirling Sands
			[480] = 2.74, -- Blood Rite
			[500] = 1.65, -- Synaptic Spark Capacitor
			[30] = 2.01, -- Overwhelming Power
			[577] = 0.95, -- Arcane Heart
			[483] = 3.55, -- Archive of the Titans
			[469] = 0.06, -- Duck and Cover
			[562] = 4.95, -- Treacherous Covenant
			[479] = 3.18, -- Dagger in the Back
			[161] = 5.57, -- Haze of Rage
			[461] = 1.06, -- Earthlink
			[18] = 1.42, -- Blood Siphon
			[494] = 3.14, -- Battlefield Precision
			[493] = 2.06, -- Last Gift
			[478] = 3, -- Tidal Surge
			[541] = 1.18, -- Fight or Flight
			[459] = 1.8, -- Unstable Flames
			[569] = 4.82, -- Clockwork Heart
			[560] = 1.36, -- Bonded Souls
			[157] = 3.16, -- Rezan's Fury
			[561] = 2.79, -- Seductive Power
			[211] = 10, -- Dance of Death
			[485] = 2.53, -- Laser Matrix
			[526] = 4.64, -- Endless Hunger
			[576] = 2.51, -- Loyal to the End
			[195] = 3.25, -- Secrets of the Deep
			[497] = 0.72, -- Stand As One
			[568] = 0.05, -- Person-Computer Interface
			[495] = 3.09, -- Anduin's Dedication
			[366] = 6.23, -- Primal Instincts
			[498] = 2.01, -- Barrage Of Many Bombs
			[505] = 3.73, -- Tradewinds
			[523] = 2.51, -- Apothecary's Concoctions
			[194] = 2.21, -- Filthy Transfusion
			[482] = 2.56, -- Thunderous Blast
			[501] = 3.1, -- Relational Normalization Gizmo
			[21] = 1.45, -- Elemental Whirl
			[99] = 0.05, -- Ablative Shielding
			[367] = 3.07, -- Feeding Frenzy
			[504] = 2.89, -- Unstable Catalyst
			[156] = 1.75, -- Ruinous Bolt
			[20] = 1.47, -- Lifespeed
			[38] = 1.33, -- On My Way
			[481] = 3.42, -- Incite the Pack
			[522] = 4.63, -- Ancients' Bulwark
			[100] = 0.02, -- Strength in Numbers
			[192] = 3.66, -- Meticulous Scheming
			[193] = 4.82, -- Blightborne Infusion
			[521] = 2.77, -- Shadow of Elune
			[365] = 5.08, -- Dire Consequences
			[575] = 4.97, -- Undulating Tides
			[82] = 4.62, -- Champion of Azeroth
			[499] = 1.14, -- Ricocheting Inflatable Pyrosaw
			[582] = 4.39, -- Heart of Darkness
			[22] = 1.4, -- Heed My Call
			[31] = 1.43, -- Gutripper
			[492] = 3.06, -- Liberator's Might
			[87] = 0.07, -- Self Reliance
			[496] = 1.08, -- Stronger Together
			[462] = 0.82, -- Azerite Globules
			[107] = 3.41, -- Serrated Jaws
			[86] = 0.02, -- Azerite Fortification
			[503] = 0.05, -- Auto-Self-Cauterizer
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 3201 - 3901 (avg 3594), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[15] = { 3.27, 0 }, -- Ripple in Space
			[4] = { 5.45, 1.13 }, -- Worldvein Resonance
			[32] = { 2.05, 2.08 }, -- Conflict and Strife
			[12] = { 5.59, 1.93 }, -- The Crucible of Flame
			[5] = { 5.78, 3.4 }, -- Essence of the Focusing Iris
			[14] = { 3.44, 2.25 }, -- Condensed Life-Force
			[36] = { 0.6, 0.69 }, -- Spark of Inspiration
			[6] = { 4.75, 2.06 }, -- Purification Protocol
			[23] = { 2.51, 0.54 }, -- Blood of the Enemy
			[37] = { 3.24, 3.22 }, -- The Formless Void
			[22] = { 1.83, 0.61 }, -- Vision of Perfection
			[35] = { 10, 4.44 }, -- Breath of the Dying
			[27] = { 1.01, 1.22 }, -- Memory of Lucid Dreams
			[28] = { 3.99, 1.17 }, -- The Unbound Force
		}, 1589360400)

		insertDefaultScalesData(defaultName, 3, 2, { -- Marksmanship Hunter
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 13202 - 20448 (avg 14132), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[38] = 1.8, -- On My Way
			[15] = 0.23, -- Resounding Protection
			[582] = 5.76, -- Heart of Darkness
			[368] = 2.22, -- Steady Aim
			[44] = 0.07, -- Vampiric Speed
			[43] = 0.15, -- Winds of War
			[22] = 1.73, -- Heed My Call
			[99] = 0.12, -- Ablative Shielding
			[103] = 0.05, -- Concentrated Mending
			[156] = 2.27, -- Ruinous Bolt
			[461] = 1.01, -- Earthlink
			[87] = 0.03, -- Self Reliance
			[100] = 0.19, -- Strength in Numbers
			[492] = 4.37, -- Liberator's Might
			[480] = 4.73, -- Blood Rite
			[569] = 6.79, -- Clockwork Heart
			[493] = 2.4, -- Last Gift
			[162] = 4.72, -- Surging Shots
			[500] = 2.21, -- Synaptic Spark Capacitor
			[30] = 3.44, -- Overwhelming Power
			[157] = 3.65, -- Rezan's Fury
			[521] = 4.84, -- Shadow of Elune
			[575] = 5.65, -- Undulating Tides
			[560] = 2.33, -- Bonded Souls
			[478] = 3.85, -- Tidal Surge
			[20] = 2.25, -- Lifespeed
			[192] = 5.88, -- Meticulous Scheming
			[498] = 2.3, -- Barrage Of Many Bombs
			[541] = 1.3, -- Fight or Flight
			[496] = 1.54, -- Stronger Together
			[522] = 6, -- Ancients' Bulwark
			[370] = 4.99, -- Focused Fire
			[499] = 1.62, -- Ricocheting Inflatable Pyrosaw
			[576] = 3.1, -- Loyal to the End
			[104] = 0.13, -- Bracing Chill
			[369] = 0.2, -- Rapid Reload
			[561] = 2.67, -- Seductive Power
			[98] = 0.27, -- Crystalline Carapace
			[195] = 3.19, -- Secrets of the Deep
			[42] = 0.05, -- Savior
			[503] = 0.19, -- Auto-Self-Cauterizer
			[562] = 5.03, -- Treacherous Covenant
			[469] = 0.27, -- Duck and Cover
			[483] = 3.61, -- Archive of the Titans
			[505] = 4.11, -- Tradewinds
			[13] = 0.07, -- Azerite Empowered
			[83] = 0.09, -- Impassive Visage
			[84] = 0.12, -- Bulwark of the Masses
			[82] = 6.1, -- Champion of Azeroth
			[577] = 3.46, -- Arcane Heart
			[196] = 5.31, -- Swirling Sands
			[526] = 6.38, -- Endless Hunger
			[212] = 6.33, -- Unerring Vision
			[193] = 6.32, -- Blightborne Infusion
			[105] = 0.02, -- Ephemeral Recovery
			[85] = 0.2, -- Gemhide
			[497] = 0.68, -- Stand As One
			[462] = 1.2, -- Azerite Globules
			[194] = 3.2, -- Filthy Transfusion
			[479] = 4.05, -- Dagger in the Back
			[481] = 4.15, -- Incite the Pack
			[89] = 0.2, -- Azerite Veins
			[18] = 1.86, -- Blood Siphon
			[31] = 1.69, -- Gutripper
			[482] = 2.99, -- Thunderous Blast
			[485] = 2.99, -- Laser Matrix
			[203] = 0.03, -- Shellshock
			[523] = 2.94, -- Apothecary's Concoctions
			[36] = 10, -- In The Rhythm
			[504] = 2.85, -- Unstable Catalyst
			[21] = 2.11, -- Elemental Whirl
			[494] = 3.6, -- Battlefield Precision
			[495] = 3.25, -- Anduin's Dedication
			[459] = 2.41, -- Unstable Flames
			[501] = 4.5, -- Relational Normalization Gizmo
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 12904 - 17337 (avg 13917), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[27] = { 0, 0.49 }, -- Memory of Lucid Dreams
			[36] = { 1.19, 1.28 }, -- Spark of Inspiration
			[23] = { 4.02, 1.52 }, -- Blood of the Enemy
			[14] = { 5.53, 2.44 }, -- Condensed Life-Force
			[37] = { 2.79, 2.83 }, -- The Formless Void
			[28] = { 4.46, 2.49 }, -- The Unbound Force
			[12] = { 4.52, 2.43 }, -- The Crucible of Flame
			[22] = { 3.73, 0.28 }, -- Vision of Perfection
			[6] = { 4.54, 1.95 }, -- Purification Protocol
			[4] = { 4.11, 1.21 }, -- Worldvein Resonance
			[32] = { 2.42, 2.39 }, -- Conflict and Strife
			[35] = { 10, 4.52 }, -- Breath of the Dying
			[15] = { 2.42, 0.21 }, -- Ripple in Space
			[5] = { 7.83, 5.12 }, -- Essence of the Focusing Iris
		}, 1589360400)

		insertDefaultScalesData(defaultName, 3, 3, { -- Survival Hunter
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 11502 - 17123 (avg 12058), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[86] = 0.19, -- Azerite Fortification
			[478] = 5.72, -- Tidal Surge
			[30] = 5.4, -- Overwhelming Power
			[562] = 7.81, -- Treacherous Covenant
			[373] = 10, -- Primeval Intuition
			[87] = 0.2, -- Self Reliance
			[482] = 4.98, -- Thunderous Blast
			[575] = 9.44, -- Undulating Tides
			[107] = 4.02, -- Serrated Jaws
			[523] = 5, -- Apothecary's Concoctions
			[14] = 0.66, -- Longstrider
			[43] = 0.36, -- Winds of War
			[83] = 0.01, -- Impassive Visage
			[105] = 0.03, -- Ephemeral Recovery
			[480] = 7.37, -- Blood Rite
			[100] = 0.08, -- Strength in Numbers
			[459] = 3.39, -- Unstable Flames
			[463] = 0.25, -- Blessed Portents
			[365] = 5.58, -- Dire Consequences
			[481] = 5.35, -- Incite the Pack
			[497] = 1.03, -- Stand As One
			[582] = 8.78, -- Heart of Darkness
			[157] = 5.96, -- Rezan's Fury
			[503] = 0.46, -- Auto-Self-Cauterizer
			[22] = 2.9, -- Heed My Call
			[192] = 7.9, -- Meticulous Scheming
			[502] = 0.46, -- Personal Absorb-o-Tron
			[44] = 0.12, -- Vampiric Speed
			[496] = 2.4, -- Stronger Together
			[156] = 3.59, -- Ruinous Bolt
			[20] = 3.74, -- Lifespeed
			[104] = 0.62, -- Bracing Chill
			[13] = 0.1, -- Azerite Empowered
			[522] = 9.75, -- Ancients' Bulwark
			[82] = 9.44, -- Champion of Azeroth
			[101] = 0.43, -- Shimmering Haven
			[501] = 6.85, -- Relational Normalization Gizmo
			[560] = 4, -- Bonded Souls
			[577] = 5.86, -- Arcane Heart
			[493] = 3.03, -- Last Gift
			[494] = 5.65, -- Battlefield Precision
			[203] = 0.58, -- Shellshock
			[526] = 9.73, -- Endless Hunger
			[505] = 5.79, -- Tradewinds
			[568] = 0.22, -- Person-Computer Interface
			[504] = 4.49, -- Unstable Catalyst
			[541] = 1.86, -- Fight or Flight
			[194] = 5.06, -- Filthy Transfusion
			[84] = 0.27, -- Bulwark of the Masses
			[42] = 0.26, -- Savior
			[576] = 4.14, -- Loyal to the End
			[498] = 3.85, -- Barrage Of Many Bombs
			[372] = 9.23, -- Wilderness Survival
			[85] = 0.1, -- Gemhide
			[99] = 0.13, -- Ablative Shielding
			[15] = 0.09, -- Resounding Protection
			[469] = 0.29, -- Duck and Cover
			[110] = 2.79, -- Wildfire Cluster
			[213] = 4.49, -- Venomous Fangs
			[98] = 0.08, -- Crystalline Carapace
			[461] = 1.92, -- Earthlink
			[371] = 8.93, -- Blur of Talons
			[89] = 0.39, -- Azerite Veins
			[18] = 2.33, -- Blood Siphon
			[462] = 2.09, -- Azerite Globules
			[499] = 2.32, -- Ricocheting Inflatable Pyrosaw
			[543] = 0.15, -- Nature's Salve
			[561] = 4.62, -- Seductive Power
			[569] = 9.95, -- Clockwork Heart
			[479] = 6.14, -- Dagger in the Back
			[103] = 0.19, -- Concentrated Mending
			[195] = 5.28, -- Secrets of the Deep
			[485] = 4.95, -- Laser Matrix
			[495] = 5.09, -- Anduin's Dedication
			[163] = 6.21, -- Latent Poison
			[521] = 7.78, -- Shadow of Elune
			[483] = 5.56, -- Archive of the Titans
			[500] = 3.32, -- Synaptic Spark Capacitor
			[193] = 9.71, -- Blightborne Infusion
			[492] = 6.3, -- Liberator's Might
			[38] = 3.08, -- On My Way
			[31] = 3.09, -- Gutripper
			[196] = 8.22, -- Swirling Sands
			[19] = 0.38, -- Woundbinder
			[21] = 3.57, -- Elemental Whirl
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 10702 - 12303 (avg 11688), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[4] = { 4.17, 1.06 }, -- Worldvein Resonance
			[22] = { 3.98, 0.95 }, -- Vision of Perfection
			[27] = { 8.23, 3.7 }, -- Memory of Lucid Dreams
			[12] = { 5.47, 2.22 }, -- The Crucible of Flame
			[36] = { 1.01, 1.13 }, -- Spark of Inspiration
			[32] = { 2.32, 2.36 }, -- Conflict and Strife
			[5] = { 8.64, 4.58 }, -- Essence of the Focusing Iris
			[14] = { 5.03, 2.43 }, -- Condensed Life-Force
			[28] = { 4.47, 2.24 }, -- The Unbound Force
			[6] = { 4.62, 2.22 }, -- Purification Protocol
			[23] = { 4.89, 1.35 }, -- Blood of the Enemy
			[37] = { 2.83, 2.8 }, -- The Formless Void
			[15] = { 2.72, 0.04 }, -- Ripple in Space
			[35] = { 10, 4.7 }, -- Breath of the Dying
		}, 1589360400)

		insertDefaultScalesData(defaultName, 8, 1, { -- Arcane Mage
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 6100 - 7201 (avg 6425), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[196] = 6.68, -- Swirling Sands
			[88] = 5.33, -- Arcane Pummeling
			[562] = 7.09, -- Treacherous Covenant
			[526] = 9.06, -- Endless Hunger
			[105] = 0.14, -- Ephemeral Recovery
			[561] = 4.01, -- Seductive Power
			[498] = 2.88, -- Barrage Of Many Bombs
			[87] = 0.25, -- Self Reliance
			[375] = 0.03, -- Explosive Echo
			[195] = 4.35, -- Secrets of the Deep
			[13] = 0.24, -- Azerite Empowered
			[101] = 0.07, -- Shimmering Haven
			[156] = 2.83, -- Ruinous Bolt
			[496] = 1.89, -- Stronger Together
			[480] = 4.72, -- Blood Rite
			[492] = 5.81, -- Liberator's Might
			[482] = 3.51, -- Thunderous Blast
			[479] = 4.74, -- Dagger in the Back
			[499] = 1.62, -- Ricocheting Inflatable Pyrosaw
			[576] = 3.76, -- Loyal to the End
			[481] = 4.55, -- Incite the Pack
			[86] = 0.18, -- Azerite Fortification
			[560] = 3.22, -- Bonded Souls
			[461] = 1.64, -- Earthlink
			[495] = 4.27, -- Anduin's Dedication
			[167] = 2.6, -- Brain Storm
			[374] = 6.18, -- Galvanizing Spark
			[193] = 8.29, -- Blightborne Infusion
			[42] = 0.21, -- Savior
			[577] = 4.87, -- Arcane Heart
			[497] = 0.96, -- Stand As One
			[485] = 3.46, -- Laser Matrix
			[568] = 0.05, -- Person-Computer Interface
			[505] = 4.77, -- Tradewinds
			[522] = 8.86, -- Ancients' Bulwark
			[83] = 0.08, -- Impassive Visage
			[582] = 6.53, -- Heart of Darkness
			[21] = 3.02, -- Elemental Whirl
			[493] = 2.57, -- Last Gift
			[31] = 1.88, -- Gutripper
			[214] = 2.39, -- Arcane Pressure
			[38] = 2.48, -- On My Way
			[478] = 4.34, -- Tidal Surge
			[14] = 0.04, -- Longstrider
			[18] = 2.11, -- Blood Siphon
			[82] = 9.29, -- Champion of Azeroth
			[468] = 0.18, -- Cauterizing Blink
			[504] = 4.03, -- Unstable Catalyst
			[194] = 3.84, -- Filthy Transfusion
			[494] = 4.29, -- Battlefield Precision
			[483] = 4.86, -- Archive of the Titans
			[157] = 4.35, -- Rezan's Fury
			[502] = 0.02, -- Personal Absorb-o-Tron
			[30] = 4.18, -- Overwhelming Power
			[459] = 2.73, -- Unstable Flames
			[575] = 6.63, -- Undulating Tides
			[501] = 4.95, -- Relational Normalization Gizmo
			[22] = 1.82, -- Heed My Call
			[462] = 1.22, -- Azerite Globules
			[15] = 0.01, -- Resounding Protection
			[521] = 5.02, -- Shadow of Elune
			[192] = 3.5, -- Meticulous Scheming
			[541] = 1.6, -- Fight or Flight
			[84] = 0.04, -- Bulwark of the Masses
			[127] = 10, -- Equipoise
			[500] = 2.3, -- Synaptic Spark Capacitor
			[523] = 4.04, -- Apothecary's Concoctions
			[569] = 8.1, -- Clockwork Heart
			[20] = 4.42, -- Lifespeed
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 6003 - 7101 (avg 6471), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[28] = { 3.23, 2.1 }, -- The Unbound Force
			[4] = { 6.95, 1.28 }, -- Worldvein Resonance
			[37] = { 3.81, 3.6 }, -- The Formless Void
			[35] = { 9.28, 4.85 }, -- Breath of the Dying
			[36] = { 1.63, 1.6 }, -- Spark of Inspiration
			[15] = { 2.64, 0 }, -- Ripple in Space
			[14] = { 6.67, 2.56 }, -- Condensed Life-Force
			[23] = { 4.2, 1.03 }, -- Blood of the Enemy
			[22] = { 1.38, 0 }, -- Vision of Perfection
			[12] = { 4.87, 2.64 }, -- The Crucible of Flame
			[6] = { 3.93, 2.19 }, -- Purification Protocol
			[5] = { 10, 6.34 }, -- Essence of the Focusing Iris
			[27] = { 2.81, 1.66 }, -- Memory of Lucid Dreams
			[32] = { 2.95, 3.01 }, -- Conflict and Strife
		}, 1589360400)

		insertDefaultScalesData(defaultName, 8, 2, { -- Fire Mage
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 6900 - 8301 (avg 7501), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[378] = 4.7, -- Firemind
			[44] = 0.05, -- Vampiric Speed
			[31] = 2.2, -- Gutripper
			[13] = 0.04, -- Azerite Empowered
			[20] = 1.42, -- Lifespeed
			[105] = 0.12, -- Ephemeral Recovery
			[192] = 4.01, -- Meticulous Scheming
			[38] = 2.18, -- On My Way
			[523] = 4.15, -- Apothecary's Concoctions
			[560] = 1.51, -- Bonded Souls
			[128] = 3.05, -- Flames of Alacrity
			[89] = 0.14, -- Azerite Veins
			[496] = 1.61, -- Stronger Together
			[156] = 2.99, -- Ruinous Bolt
			[501] = 4.37, -- Relational Normalization Gizmo
			[482] = 4, -- Thunderous Blast
			[86] = 0.01, -- Azerite Fortification
			[205] = 0.02, -- Eldritch Warding
			[561] = 3.08, -- Seductive Power
			[168] = 7.61, -- Wildfire
			[83] = 0.1, -- Impassive Visage
			[522] = 8.15, -- Ancients' Bulwark
			[526] = 8.19, -- Endless Hunger
			[569] = 10, -- Clockwork Heart
			[478] = 4.74, -- Tidal Surge
			[193] = 8.57, -- Blightborne Infusion
			[497] = 1, -- Stand As One
			[521] = 4.25, -- Shadow of Elune
			[504] = 3.31, -- Unstable Catalyst
			[485] = 3.78, -- Laser Matrix
			[157] = 4.67, -- Rezan's Fury
			[479] = 4.7, -- Dagger in the Back
			[194] = 3.85, -- Filthy Transfusion
			[99] = 0.01, -- Ablative Shielding
			[577] = 2.68, -- Arcane Heart
			[493] = 2.39, -- Last Gift
			[495] = 3.73, -- Anduin's Dedication
			[492] = 4.33, -- Liberator's Might
			[30] = 2.73, -- Overwhelming Power
			[494] = 4.55, -- Battlefield Precision
			[196] = 7.1, -- Swirling Sands
			[18] = 1.73, -- Blood Siphon
			[562] = 5.7, -- Treacherous Covenant
			[82] = 6.28, -- Champion of Azeroth
			[568] = 0.03, -- Person-Computer Interface
			[459] = 2.57, -- Unstable Flames
			[500] = 2.45, -- Synaptic Spark Capacitor
			[499] = 1.59, -- Ricocheting Inflatable Pyrosaw
			[461] = 1.42, -- Earthlink
			[101] = 0.01, -- Shimmering Haven
			[377] = 4.11, -- Duplicative Incineration
			[480] = 4.3, -- Blood Rite
			[483] = 3.93, -- Archive of the Titans
			[19] = 0.03, -- Woundbinder
			[541] = 1.14, -- Fight or Flight
			[22] = 2.15, -- Heed My Call
			[576] = 3.05, -- Loyal to the End
			[376] = 3.26, -- Trailing Embers
			[195] = 3.43, -- Secrets of the Deep
			[505] = 4.09, -- Tradewinds
			[582] = 6.52, -- Heart of Darkness
			[21] = 2.21, -- Elemental Whirl
			[15] = 0.07, -- Resounding Protection
			[498] = 2.76, -- Barrage Of Many Bombs
			[85] = 0.09, -- Gemhide
			[462] = 1.55, -- Azerite Globules
			[215] = 6.28, -- Blaster Master
			[481] = 3.72, -- Incite the Pack
			[575] = 7.56, -- Undulating Tides
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 6702 - 8526 (avg 7330), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[14] = { 4.71, 1.8 }, -- Condensed Life-Force
			[23] = { 1.99, 0.91 }, -- Blood of the Enemy
			[22] = { 1.54, 0 }, -- Vision of Perfection
			[36] = { 0.57, 0.53 }, -- Spark of Inspiration
			[15] = { 2.63, 0 }, -- Ripple in Space
			[28] = { 3.33, 1.67 }, -- The Unbound Force
			[12] = { 3.83, 1.74 }, -- The Crucible of Flame
			[35] = { 7.03, 3.68 }, -- Breath of the Dying
			[37] = { 2.01, 1.82 }, -- The Formless Void
			[4] = { 3.27, 0.54 }, -- Worldvein Resonance
			[6] = { 3.74, 1.55 }, -- Purification Protocol
			[27] = { 10, 5.02 }, -- Memory of Lucid Dreams
			[32] = { 1.83, 1.83 }, -- Conflict and Strife
			[5] = { 5.59, 1.97 }, -- Essence of the Focusing Iris
		}, 1589360400)

		insertDefaultScalesData(defaultName, 8, 3, { -- Frost Mage
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 6901 - 8501 (avg 7306), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[504] = 2.96, -- Unstable Catalyst
			[505] = 4.66, -- Tradewinds
			[582] = 4.58, -- Heart of Darkness
			[493] = 2.57, -- Last Gift
			[568] = 0.08, -- Person-Computer Interface
			[462] = 0.72, -- Azerite Globules
			[483] = 3.7, -- Archive of the Titans
			[194] = 2.37, -- Filthy Transfusion
			[30] = 2.41, -- Overwhelming Power
			[461] = 1.1, -- Earthlink
			[492] = 3.27, -- Liberator's Might
			[84] = 0.05, -- Bulwark of the Masses
			[560] = 1.46, -- Bonded Souls
			[381] = 2.85, -- Frigid Grasp
			[85] = 0.1, -- Gemhide
			[498] = 1.67, -- Barrage Of Many Bombs
			[44] = 0.11, -- Vampiric Speed
			[546] = 0.06, -- Quick Thinking
			[22] = 1.05, -- Heed My Call
			[86] = 0.04, -- Azerite Fortification
			[569] = 5.26, -- Clockwork Heart
			[526] = 4.45, -- Endless Hunger
			[482] = 2.06, -- Thunderous Blast
			[42] = 0.06, -- Savior
			[468] = 0.06, -- Cauterizing Blink
			[104] = 0.07, -- Bracing Chill
			[561] = 2.76, -- Seductive Power
			[577] = 2.73, -- Arcane Heart
			[43] = 0.03, -- Winds of War
			[501] = 3.46, -- Relational Normalization Gizmo
			[576] = 3.06, -- Loyal to the End
			[157] = 2.53, -- Rezan's Fury
			[380] = 2.54, -- Whiteout
			[459] = 1.91, -- Unstable Flames
			[192] = 2.75, -- Meticulous Scheming
			[481] = 4.18, -- Incite the Pack
			[105] = 0.02, -- Ephemeral Recovery
			[562] = 5.1, -- Treacherous Covenant
			[13] = 0.01, -- Azerite Empowered
			[193] = 3.89, -- Blightborne Infusion
			[541] = 1.26, -- Fight or Flight
			[196] = 3.89, -- Swirling Sands
			[195] = 3.24, -- Secrets of the Deep
			[100] = 0.11, -- Strength in Numbers
			[500] = 1.39, -- Synaptic Spark Capacitor
			[20] = 1.47, -- Lifespeed
			[225] = 2.23, -- Glacial Assault
			[132] = 2.45, -- Packed Ice
			[89] = 0.14, -- Azerite Veins
			[496] = 1.14, -- Stronger Together
			[575] = 3.89, -- Undulating Tides
			[101] = 0.02, -- Shimmering Haven
			[478] = 2.67, -- Tidal Surge
			[522] = 4.45, -- Ancients' Bulwark
			[499] = 1.16, -- Ricocheting Inflatable Pyrosaw
			[485] = 2.19, -- Laser Matrix
			[497] = 0.8, -- Stand As One
			[521] = 3.14, -- Shadow of Elune
			[170] = 10, -- Flash Freeze
			[18] = 1.62, -- Blood Siphon
			[82] = 4.79, -- Champion of Azeroth
			[31] = 1.11, -- Gutripper
			[480] = 3.09, -- Blood Rite
			[495] = 3.39, -- Anduin's Dedication
			[103] = 0.02, -- Concentrated Mending
			[38] = 1.31, -- On My Way
			[21] = 1.82, -- Elemental Whirl
			[479] = 2.77, -- Dagger in the Back
			[156] = 1.57, -- Ruinous Bolt
			[83] = 0.04, -- Impassive Visage
			[494] = 2.32, -- Battlefield Precision
			[523] = 1.98, -- Apothecary's Concoctions
			[379] = 2.96, -- Tunnel of Ice
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 6708 - 7883 (avg 7153), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[28] = { 3.67, 2.14 }, -- The Unbound Force
			[6] = { 3.73, 2.26 }, -- Purification Protocol
			[27] = { 10, 6.21 }, -- Memory of Lucid Dreams
			[5] = { 6.17, 4.78 }, -- Essence of the Focusing Iris
			[15] = { 2.99, 0.23 }, -- Ripple in Space
			[4] = { 5.82, 1.81 }, -- Worldvein Resonance
			[36] = { 1.39, 1.15 }, -- Spark of Inspiration
			[22] = { 5.06, 1.2 }, -- Vision of Perfection
			[23] = { 3.81, 1.08 }, -- Blood of the Enemy
			[12] = { 2.63, 2.53 }, -- The Crucible of Flame
			[35] = { 8.3, 5.15 }, -- Breath of the Dying
			[14] = { 6.4, 2.78 }, -- Condensed Life-Force
			[37] = { 4.72, 4.79 }, -- The Formless Void
			[32] = { 2.86, 2.98 }, -- Conflict and Strife
		}, 1589360400)

		insertDefaultScalesData(offensiveName, 10, 1, { -- Brewmaster Monk
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 3600 - 4517 (avg 3854), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[576] = 1.76, -- Loyal to the End
			[157] = 6.14, -- Rezan's Fury
			[485] = 4.98, -- Laser Matrix
			[156] = 3.64, -- Ruinous Bolt
			[481] = 2.45, -- Incite the Pack
			[499] = 2.31, -- Ricocheting Inflatable Pyrosaw
			[82] = 4.4, -- Champion of Azeroth
			[501] = 2.42, -- Relational Normalization Gizmo
			[103] = 0.01, -- Concentrated Mending
			[504] = 2.06, -- Unstable Catalyst
			[194] = 5.14, -- Filthy Transfusion
			[382] = 0.1, -- Straight, No Chaser
			[479] = 4.47, -- Dagger in the Back
			[582] = 4.2, -- Heart of Darkness
			[463] = 0.04, -- Blessed Portents
			[384] = 2.56, -- Elusive Footwork
			[492] = 2.94, -- Liberator's Might
			[193] = 5.78, -- Blightborne Infusion
			[22] = 2.63, -- Heed My Call
			[560] = 0.89, -- Bonded Souls
			[569] = 4.6, -- Clockwork Heart
			[462] = 1.56, -- Azerite Globules
			[459] = 2, -- Unstable Flames
			[522] = 5.46, -- Ancients' Bulwark
			[541] = 0.99, -- Fight or Flight
			[196] = 4.85, -- Swirling Sands
			[526] = 5.4, -- Endless Hunger
			[482] = 5.29, -- Thunderous Blast
			[480] = 1.75, -- Blood Rite
			[192] = 1.95, -- Meticulous Scheming
			[478] = 5.81, -- Tidal Surge
			[116] = 1.23, -- Boiling Brew
			[496] = 0.84, -- Stronger Together
			[523] = 5.3, -- Apothecary's Concoctions
			[575] = 10, -- Undulating Tides
			[31] = 2.82, -- Gutripper
			[461] = 0.77, -- Earthlink
			[494] = 6.73, -- Battlefield Precision
			[20] = 0.71, -- Lifespeed
			[483] = 2.78, -- Archive of the Titans
			[577] = 4, -- Arcane Heart
			[21] = 1.2, -- Elemental Whirl
			[493] = 1.44, -- Last Gift
			[562] = 3.59, -- Treacherous Covenant
			[18] = 0.87, -- Blood Siphon
			[500] = 2.92, -- Synaptic Spark Capacitor
			[38] = 1.44, -- On My Way
			[195] = 2.55, -- Secrets of the Deep
			[30] = 1.06, -- Overwhelming Power
			[561] = 2.77, -- Seductive Power
			[383] = 3.47, -- Training of Niuzao
			[505] = 2.75, -- Tradewinds
			[521] = 1.55, -- Shadow of Elune
			[498] = 3.69, -- Barrage Of Many Bombs
			[495] = 2.36, -- Anduin's Dedication
			[497] = 0.61, -- Stand As One
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 3602 - 4004 (avg 3823), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[3] = { 2.88, 2.86 }, -- Sphere of Suppression
			[15] = { 3.21, 0 }, -- Ripple in Space
			[12] = { 10, 3.75 }, -- The Crucible of Flame
			[37] = { 2.08, 1.97 }, -- The Formless Void
			[2] = { 0.05, 0 }, -- Azeroth's Undying Gift
			[7] = { 3.88, 1.52 }, -- Anima of Life and Death
			[25] = { 1.01, 0.81 }, -- Aegis of the Deep
			[32] = { 2.01, 1.93 }, -- Conflict and Strife
			[4] = { 2.53, 0.6 }, -- Worldvein Resonance
		}, 1589360400)

		insertDefaultScalesData(defaultName, 10, 3, { -- Windwalker Monk
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 4603 - 5502 (avg 4975), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[390] = 6.63, -- Pressure Point
			[569] = 8.65, -- Clockwork Heart
			[38] = 2.23, -- On My Way
			[483] = 3.92, -- Archive of the Titans
			[459] = 2.4, -- Unstable Flames
			[478] = 4.52, -- Tidal Surge
			[482] = 3.85, -- Thunderous Blast
			[192] = 5.4, -- Meticulous Scheming
			[493] = 2.8, -- Last Gift
			[541] = 1.2, -- Fight or Flight
			[575] = 7.08, -- Undulating Tides
			[577] = 3.14, -- Arcane Heart
			[156] = 2.76, -- Ruinous Bolt
			[504] = 3.21, -- Unstable Catalyst
			[20] = 2.02, -- Lifespeed
			[22] = 1.89, -- Heed My Call
			[560] = 2.43, -- Bonded Souls
			[526] = 8.15, -- Endless Hunger
			[498] = 2.79, -- Barrage Of Many Bombs
			[117] = 10, -- Fury of Xuen
			[479] = 4.55, -- Dagger in the Back
			[157] = 4.62, -- Rezan's Fury
			[499] = 1.59, -- Ricocheting Inflatable Pyrosaw
			[461] = 1.13, -- Earthlink
			[462] = 1.32, -- Azerite Globules
			[561] = 3.18, -- Seductive Power
			[31] = 1.94, -- Gutripper
			[184] = 4.48, -- Sunrise Technique
			[18] = 1.43, -- Blood Siphon
			[497] = 1.04, -- Stand As One
			[196] = 5.87, -- Swirling Sands
			[576] = 3, -- Loyal to the End
			[194] = 3.68, -- Filthy Transfusion
			[521] = 4.61, -- Shadow of Elune
			[481] = 4.23, -- Incite the Pack
			[505] = 4.79, -- Tradewinds
			[501] = 4.64, -- Relational Normalization Gizmo
			[193] = 7.1, -- Blightborne Infusion
			[494] = 4.46, -- Battlefield Precision
			[30] = 3.42, -- Overwhelming Power
			[492] = 4.36, -- Liberator's Might
			[84] = 0.09, -- Bulwark of the Masses
			[85] = 0.17, -- Gemhide
			[495] = 3.7, -- Anduin's Dedication
			[21] = 2.2, -- Elemental Whirl
			[485] = 3.61, -- Laser Matrix
			[562] = 5.23, -- Treacherous Covenant
			[195] = 3.52, -- Secrets of the Deep
			[496] = 1.55, -- Stronger Together
			[522] = 7.98, -- Ancients' Bulwark
			[500] = 2.46, -- Synaptic Spark Capacitor
			[523] = 3.79, -- Apothecary's Concoctions
			[82] = 6.9, -- Champion of Azeroth
			[389] = 7.08, -- Open Palm Strikes
			[83] = 0.05, -- Impassive Visage
			[388] = 5.82, -- Glory of the Dawn
			[582] = 6.16, -- Heart of Darkness
			[391] = 4.71, -- Dance of Chi-Ji
			[480] = 4.66, -- Blood Rite
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 4400 - 6126 (avg 4923), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 13.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[4] = { 2.51, 0.51 }, -- Worldvein Resonance
			[32] = { 10, 1.38 }, -- Conflict and Strife
			[6] = { 3.34, 1.22 }, -- Purification Protocol
			[28] = { 2.88, 0.85 }, -- The Unbound Force
			[12] = { 3.75, 1.2 }, -- The Crucible of Flame
			[14] = { 3.72, 1.38 }, -- Condensed Life-Force
			[36] = { 0.48, 0.32 }, -- Spark of Inspiration
			[27] = { 2.31, 1.89 }, -- Memory of Lucid Dreams
			[22] = { 1.66, 0.99 }, -- Vision of Perfection
			[23] = { 3.38, 0.66 }, -- Blood of the Enemy
			[35] = { 6.61, 2.7 }, -- Breath of the Dying
			[15] = { 1.94, 0 }, -- Ripple in Space
			[5] = { 5.6, 2.53 }, -- Essence of the Focusing Iris
			[37] = { 1.54, 1.46 }, -- The Formless Void
		}, 1589360400)

		insertDefaultScalesData(offensiveName, 2, 2, { -- Protection Paladin
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 29602 - 33204 (avg 32244), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[125] = 3.13, -- Avenger's Might
			[82] = 6.27, -- Champion of Azeroth
			[18] = 1.16, -- Blood Siphon
			[192] = 5.87, -- Meticulous Scheming
			[497] = 0.87, -- Stand As One
			[562] = 5.52, -- Treacherous Covenant
			[526] = 6.86, -- Endless Hunger
			[505] = 3.53, -- Tradewinds
			[31] = 3.05, -- Gutripper
			[482] = 4.98, -- Thunderous Blast
			[481] = 3.22, -- Incite the Pack
			[504] = 2.94, -- Unstable Catalyst
			[150] = 1.72, -- Soaring Shield
			[479] = 4.56, -- Dagger in the Back
			[133] = 0.01, -- Bulwark of Light
			[99] = 0.01, -- Ablative Shielding
			[194] = 5.22, -- Filthy Transfusion
			[483] = 3.67, -- Archive of the Titans
			[480] = 4.64, -- Blood Rite
			[462] = 1.66, -- Azerite Globules
			[395] = 8.71, -- Inspiring Vanguard
			[21] = 2.11, -- Elemental Whirl
			[523] = 5.16, -- Apothecary's Concoctions
			[496] = 1.5, -- Stronger Together
			[569] = 6.96, -- Clockwork Heart
			[30] = 3.13, -- Overwhelming Power
			[498] = 4.23, -- Barrage Of Many Bombs
			[500] = 2.74, -- Synaptic Spark Capacitor
			[522] = 6.97, -- Ancients' Bulwark
			[157] = 6.16, -- Rezan's Fury
			[492] = 4.26, -- Liberator's Might
			[541] = 1.2, -- Fight or Flight
			[582] = 6.03, -- Heart of Darkness
			[485] = 5.15, -- Laser Matrix
			[494] = 6.64, -- Battlefield Precision
			[501] = 4.47, -- Relational Normalization Gizmo
			[471] = 0.05, -- Gallant Steed
			[20] = 1.91, -- Lifespeed
			[22] = 2.7, -- Heed My Call
			[235] = 3.28, -- Indomitable Justice
			[499] = 2.39, -- Ricocheting Inflatable Pyrosaw
			[193] = 7.09, -- Blightborne Infusion
			[234] = 1.63, -- Inner Light
			[495] = 3.26, -- Anduin's Dedication
			[521] = 4.7, -- Shadow of Elune
			[38] = 1.87, -- On My Way
			[195] = 3.51, -- Secrets of the Deep
			[538] = 0.24, -- Empyreal Ward
			[101] = 0.03, -- Shimmering Haven
			[493] = 1.78, -- Last Gift
			[502] = 0.04, -- Personal Absorb-o-Tron
			[577] = 3.86, -- Arcane Heart
			[104] = 0.01, -- Bracing Chill
			[156] = 3.29, -- Ruinous Bolt
			[196] = 6.12, -- Swirling Sands
			[560] = 2.32, -- Bonded Souls
			[561] = 3.31, -- Seductive Power
			[576] = 2.13, -- Loyal to the End
			[459] = 2.5, -- Unstable Flames
			[575] = 10, -- Undulating Tides
			[461] = 1.01, -- Earthlink
			[478] = 5.67, -- Tidal Surge
			[98] = 0.34, -- Crystalline Carapace
			[100] = 0.07, -- Strength in Numbers
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 28901 - 33200 (avg 32036), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[4] = { 5.25, 0.92 }, -- Worldvein Resonance
			[12] = { 10, 3.65 }, -- The Crucible of Flame
			[33] = { 0.09, 0 }, -- Touch of the Everlasting
			[27] = { 0.94, 0.75 }, -- Memory of Lucid Dreams
			[32] = { 2.89, 2.56 }, -- Conflict and Strife
			[3] = { 6.29, 5.97 }, -- Sphere of Suppression
			[37] = { 2.84, 3.17 }, -- The Formless Void
			[13] = { 0.1, 0 }, -- Nullification Dynamo
			[25] = { 1.19, 1.27 }, -- Aegis of the Deep
			[2] = { 0, 0.06 }, -- Azeroth's Undying Gift
			[15] = { 3.44, 0 }, -- Ripple in Space
			[22] = { 5.21, 2.31 }, -- Vision of Perfection
			[7] = { 2.57, 0 }, -- Anima of Life and Death
		}, 1589446800)

		insertDefaultScalesData(defaultName, 2, 3, { -- Retribution Paladin
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 7002 - 8502 (avg 7792), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[526] = 6.19, -- Endless Hunger
			[499] = 1.87, -- Ricocheting Inflatable Pyrosaw
			[83] = 0.2, -- Impassive Visage
			[193] = 5.71, -- Blightborne Infusion
			[461] = 1.11, -- Earthlink
			[496] = 1.54, -- Stronger Together
			[582] = 5.15, -- Heart of Darkness
			[82] = 5.46, -- Champion of Azeroth
			[19] = 0.01, -- Woundbinder
			[498] = 2.83, -- Barrage Of Many Bombs
			[393] = 0.33, -- Grace of the Justicar
			[500] = 1.97, -- Synaptic Spark Capacitor
			[453] = 4.72, -- Empyrean Power
			[86] = 0.1, -- Azerite Fortification
			[479] = 4.68, -- Dagger in the Back
			[494] = 4.3, -- Battlefield Precision
			[522] = 6.2, -- Ancients' Bulwark
			[562] = 5.28, -- Treacherous Covenant
			[84] = 0.09, -- Bulwark of the Masses
			[459] = 2.07, -- Unstable Flames
			[196] = 4.61, -- Swirling Sands
			[521] = 3.64, -- Shadow of Elune
			[22] = 1.73, -- Heed My Call
			[103] = 0.05, -- Concentrated Mending
			[42] = 0.01, -- Savior
			[454] = 0.03, -- Judicious Defense
			[99] = 0.21, -- Ablative Shielding
			[125] = 4.62, -- Avenger's Might
			[31] = 2.13, -- Gutripper
			[187] = 5.25, -- Expurgation
			[13] = 0.03, -- Azerite Empowered
			[30] = 2.8, -- Overwhelming Power
			[85] = 0.21, -- Gemhide
			[154] = 5.77, -- Relentless Inquisitor
			[480] = 3.63, -- Blood Rite
			[156] = 2.23, -- Ruinous Bolt
			[504] = 2.97, -- Unstable Catalyst
			[195] = 3.4, -- Secrets of the Deep
			[576] = 2.7, -- Loyal to the End
			[15] = 0.07, -- Resounding Protection
			[194] = 3.67, -- Filthy Transfusion
			[235] = 3.56, -- Indomitable Justice
			[481] = 3.85, -- Incite the Pack
			[523] = 3.63, -- Apothecary's Concoctions
			[396] = 10, -- Light's Decree
			[157] = 4.16, -- Rezan's Fury
			[575] = 6.87, -- Undulating Tides
			[501] = 3.85, -- Relational Normalization Gizmo
			[538] = 0.22, -- Empyreal Ward
			[492] = 3.64, -- Liberator's Might
			[463] = 0.12, -- Blessed Portents
			[497] = 0.92, -- Stand As One
			[482] = 3.65, -- Thunderous Blast
			[104] = 0.21, -- Bracing Chill
			[20] = 1.8, -- Lifespeed
			[43] = 0.05, -- Winds of War
			[541] = 1.29, -- Fight or Flight
			[505] = 4.04, -- Tradewinds
			[89] = 0.15, -- Azerite Veins
			[483] = 3.69, -- Archive of the Titans
			[561] = 3.34, -- Seductive Power
			[560] = 2.1, -- Bonded Souls
			[462] = 1.42, -- Azerite Globules
			[569] = 6.1, -- Clockwork Heart
			[21] = 1.71, -- Elemental Whirl
			[38] = 1.88, -- On My Way
			[101] = 0.16, -- Shimmering Haven
			[478] = 3.73, -- Tidal Surge
			[192] = 4.44, -- Meticulous Scheming
			[87] = 0.09, -- Self Reliance
			[18] = 1.57, -- Blood Siphon
			[105] = 0.02, -- Ephemeral Recovery
			[495] = 3.4, -- Anduin's Dedication
			[493] = 2.12, -- Last Gift
			[577] = 3.68, -- Arcane Heart
			[485] = 3.62, -- Laser Matrix
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 7002 - 8001 (avg 7616), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[14] = { 6.35, 2.86 }, -- Condensed Life-Force
			[28] = { 4.5, 1.82 }, -- The Unbound Force
			[4] = { 4.97, 0.99 }, -- Worldvein Resonance
			[6] = { 5, 2.39 }, -- Purification Protocol
			[15] = { 0.04, 0.13 }, -- Ripple in Space
			[22] = { 8.42, 2.94 }, -- Vision of Perfection
			[36] = { 0.82, 0.96 }, -- Spark of Inspiration
			[27] = { 4.43, 2.57 }, -- Memory of Lucid Dreams
			[23] = { 3.84, 0.67 }, -- Blood of the Enemy
			[12] = { 5.96, 2.42 }, -- The Crucible of Flame
			[37] = { 2.88, 2.75 }, -- The Formless Void
			[35] = { 10, 5 }, -- Breath of the Dying
			[32] = { 2.14, 2.32 }, -- Conflict and Strife
			[5] = { 7.44, 3.35 }, -- Essence of the Focusing Iris
		}, 1589446800)

		insertDefaultScalesData(defaultName, 4, 1, { -- Assassination Rogue
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 4800 - 6855 (avg 5171), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[498] = 3.5, -- Barrage Of Many Bombs
			[501] = 6.02, -- Relational Normalization Gizmo
			[482] = 4.52, -- Thunderous Blast
			[105] = 0.09, -- Ephemeral Recovery
			[30] = 3.82, -- Overwhelming Power
			[217] = 0.22, -- Footpad
			[493] = 2.66, -- Last Gift
			[541] = 1.79, -- Fight or Flight
			[38] = 3.12, -- On My Way
			[195] = 5.16, -- Secrets of the Deep
			[101] = 0.11, -- Shimmering Haven
			[478] = 4.98, -- Tidal Surge
			[502] = 0.13, -- Personal Absorb-o-Tron
			[562] = 7.76, -- Treacherous Covenant
			[20] = 2.86, -- Lifespeed
			[577] = 5.2, -- Arcane Heart
			[575] = 8.77, -- Undulating Tides
			[461] = 1.92, -- Earthlink
			[560] = 3, -- Bonded Souls
			[156] = 2.67, -- Ruinous Bolt
			[21] = 2.85, -- Elemental Whirl
			[408] = 8.49, -- Shrouded Suffocation
			[22] = 2.26, -- Heed My Call
			[196] = 8.09, -- Swirling Sands
			[406] = 3.6, -- Scent of Blood
			[194] = 4.24, -- Filthy Transfusion
			[98] = 0.04, -- Crystalline Carapace
			[492] = 5.82, -- Liberator's Might
			[576] = 3.69, -- Loyal to the End
			[15] = 0.4, -- Resounding Protection
			[494] = 5.68, -- Battlefield Precision
			[497] = 1.38, -- Stand As One
			[504] = 4.65, -- Unstable Catalyst
			[249] = 9.22, -- Nothing Personal
			[181] = 6.37, -- Twist the Knife
			[193] = 9.89, -- Blightborne Infusion
			[192] = 5.5, -- Meticulous Scheming
			[495] = 5.08, -- Anduin's Dedication
			[136] = 8.48, -- Double Dose
			[499] = 2, -- Ricocheting Inflatable Pyrosaw
			[157] = 5.45, -- Rezan's Fury
			[523] = 4.51, -- Apothecary's Concoctions
			[480] = 5.79, -- Blood Rite
			[582] = 8.51, -- Heart of Darkness
			[526] = 10, -- Endless Hunger
			[500] = 2.86, -- Synaptic Spark Capacitor
			[505] = 5.57, -- Tradewinds
			[82] = 8.7, -- Champion of Azeroth
			[479] = 5.8, -- Dagger in the Back
			[462] = 1.71, -- Azerite Globules
			[44] = 0.19, -- Vampiric Speed
			[561] = 4.63, -- Seductive Power
			[568] = 0.21, -- Person-Computer Interface
			[521] = 5.57, -- Shadow of Elune
			[569] = 9.74, -- Clockwork Heart
			[485] = 4.57, -- Laser Matrix
			[87] = 0.28, -- Self Reliance
			[473] = 0.1, -- Shrouded Mantle
			[459] = 3.52, -- Unstable Flames
			[481] = 4.98, -- Incite the Pack
			[100] = 0.11, -- Strength in Numbers
			[18] = 1.92, -- Blood Siphon
			[31] = 2.7, -- Gutripper
			[522] = 9.97, -- Ancients' Bulwark
			[483] = 5.68, -- Archive of the Titans
			[496] = 2.3, -- Stronger Together
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 4500 - 5303 (avg 5016), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[23] = { 6.32, 1.81 }, -- Blood of the Enemy
			[27] = { 7.99, 4.2 }, -- Memory of Lucid Dreams
			[36] = { 0.74, 0.9 }, -- Spark of Inspiration
			[22] = { 4.63, 1.14 }, -- Vision of Perfection
			[32] = { 2.26, 2.42 }, -- Conflict and Strife
			[37] = { 2.62, 2.65 }, -- The Formless Void
			[35] = { 10, 4.16 }, -- Breath of the Dying
			[6] = { 4.82, 1.8 }, -- Purification Protocol
			[4] = { 5.43, 0.94 }, -- Worldvein Resonance
			[14] = { 5.39, 2.29 }, -- Condensed Life-Force
			[12] = { 5.61, 1.94 }, -- The Crucible of Flame
			[15] = { 3.83, 0.01 }, -- Ripple in Space
			[28] = { 5.52, 2.55 }, -- The Unbound Force
			[5] = { 7.7, 3.57 }, -- Essence of the Focusing Iris
		}, 1589446800)

		insertDefaultScalesData(defaultName, 4, 2, { -- Outlaw Rogue
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 8903 - 11685 (avg 9534), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[84] = 0.04, -- Bulwark of the Masses
			[483] = 4.9, -- Archive of the Titans
			[410] = 3.67, -- Paradise Lost
			[239] = 3.98, -- Snake Eyes
			[504] = 3.8, -- Unstable Catalyst
			[446] = 10, -- Brigand's Blitz
			[86] = 0.09, -- Azerite Fortification
			[575] = 9.82, -- Undulating Tides
			[462] = 1.7, -- Azerite Globules
			[501] = 5.51, -- Relational Normalization Gizmo
			[561] = 3.94, -- Seductive Power
			[568] = 0.08, -- Person-Computer Interface
			[156] = 3.47, -- Ruinous Bolt
			[22] = 2.78, -- Heed My Call
			[503] = 0.02, -- Auto-Self-Cauterizer
			[562] = 6.86, -- Treacherous Covenant
			[541] = 1.56, -- Fight or Flight
			[498] = 3.95, -- Barrage Of Many Bombs
			[523] = 4.82, -- Apothecary's Concoctions
			[192] = 7.17, -- Meticulous Scheming
			[129] = 7.21, -- Deadshot
			[480] = 6.03, -- Blood Rite
			[44] = 0.06, -- Vampiric Speed
			[20] = 2.8, -- Lifespeed
			[193] = 8.27, -- Blightborne Infusion
			[482] = 4.9, -- Thunderous Blast
			[30] = 4.44, -- Overwhelming Power
			[411] = 7.8, -- Ace Up Your Sleeve
			[494] = 5.89, -- Battlefield Precision
			[196] = 6.98, -- Swirling Sands
			[83] = 0.12, -- Impassive Visage
			[560] = 2.73, -- Bonded Souls
			[522] = 9.17, -- Ancients' Bulwark
			[497] = 0.96, -- Stand As One
			[526] = 8.98, -- Endless Hunger
			[500] = 3.01, -- Synaptic Spark Capacitor
			[180] = 4.22, -- Keep Your Wits About You
			[479] = 6.51, -- Dagger in the Back
			[492] = 5.49, -- Liberator's Might
			[157] = 6.07, -- Rezan's Fury
			[195] = 4.73, -- Secrets of the Deep
			[481] = 3.67, -- Incite the Pack
			[459] = 2.87, -- Unstable Flames
			[478] = 5.73, -- Tidal Surge
			[521] = 5.92, -- Shadow of Elune
			[576] = 2.78, -- Loyal to the End
			[82] = 8.04, -- Champion of Azeroth
			[217] = 0.19, -- Footpad
			[499] = 2.47, -- Ricocheting Inflatable Pyrosaw
			[505] = 4.06, -- Tradewinds
			[31] = 3.27, -- Gutripper
			[461] = 1.59, -- Earthlink
			[89] = 0.17, -- Azerite Veins
			[194] = 4.69, -- Filthy Transfusion
			[473] = 0.05, -- Shrouded Mantle
			[104] = 0.09, -- Bracing Chill
			[493] = 2.31, -- Last Gift
			[21] = 2.69, -- Elemental Whirl
			[577] = 4.07, -- Arcane Heart
			[496] = 2.01, -- Stronger Together
			[38] = 2.64, -- On My Way
			[485] = 4.93, -- Laser Matrix
			[18] = 1.47, -- Blood Siphon
			[569] = 7.84, -- Clockwork Heart
			[502] = 0.06, -- Personal Absorb-o-Tron
			[582] = 7.43, -- Heart of Darkness
			[101] = 0.06, -- Shimmering Haven
			[85] = 0.08, -- Gemhide
			[495] = 4.29, -- Anduin's Dedication
			[19] = 0.04, -- Woundbinder
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 8202 - 9900 (avg 9187), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[12] = { 5.86, 1.99 }, -- The Crucible of Flame
			[36] = { 0.7, 1.01 }, -- Spark of Inspiration
			[27] = { 5.63, 4.19 }, -- Memory of Lucid Dreams
			[14] = { 5.17, 2.12 }, -- Condensed Life-Force
			[28] = { 3.84, 1.21 }, -- The Unbound Force
			[23] = { 2.9, 1.18 }, -- Blood of the Enemy
			[22] = { 4.67, 2.32 }, -- Vision of Perfection
			[37] = { 2.02, 2.2 }, -- The Formless Void
			[35] = { 10, 4.19 }, -- Breath of the Dying
			[6] = { 4.74, 2.02 }, -- Purification Protocol
			[4] = { 3.49, 0.7 }, -- Worldvein Resonance
			[32] = { 1.95, 1.95 }, -- Conflict and Strife
			[5] = { 6.69, 3.19 }, -- Essence of the Focusing Iris
			[15] = { 2.68, 0 }, -- Ripple in Space
		}, 1589446800)

		insertDefaultScalesData(defaultName, 4, 3, { -- Subtlety Rogue
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 5801 - 6604 (avg 6267), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[478] = 3.07, -- Tidal Surge
			[89] = 0.04, -- Azerite Veins
			[577] = 2.06, -- Arcane Heart
			[497] = 0.46, -- Stand As One
			[192] = 2.93, -- Meticulous Scheming
			[175] = 3.63, -- Night's Vengeance
			[569] = 5.17, -- Clockwork Heart
			[482] = 2.46, -- Thunderous Blast
			[21] = 1.38, -- Elemental Whirl
			[86] = 0.04, -- Azerite Fortification
			[195] = 2.25, -- Secrets of the Deep
			[22] = 1.34, -- Heed My Call
			[501] = 3.04, -- Relational Normalization Gizmo
			[504] = 2.02, -- Unstable Catalyst
			[461] = 0.84, -- Earthlink
			[499] = 1.18, -- Ricocheting Inflatable Pyrosaw
			[42] = 0.02, -- Savior
			[38] = 1.43, -- On My Way
			[157] = 3.19, -- Rezan's Fury
			[575] = 4.89, -- Undulating Tides
			[582] = 4.17, -- Heart of Darkness
			[480] = 2.93, -- Blood Rite
			[495] = 2.33, -- Anduin's Dedication
			[576] = 1.69, -- Loyal to the End
			[496] = 1.03, -- Stronger Together
			[560] = 1.57, -- Bonded Souls
			[31] = 1.43, -- Gutripper
			[505] = 2.53, -- Tradewinds
			[459] = 1.66, -- Unstable Flames
			[18] = 0.97, -- Blood Siphon
			[196] = 3.76, -- Swirling Sands
			[561] = 1.9, -- Seductive Power
			[493] = 1.28, -- Last Gift
			[20] = 1.61, -- Lifespeed
			[526] = 4.79, -- Endless Hunger
			[156] = 1.73, -- Ruinous Bolt
			[445] = 1.55, -- Perforate
			[462] = 0.82, -- Azerite Globules
			[481] = 2.37, -- Incite the Pack
			[485] = 2.45, -- Laser Matrix
			[500] = 1.54, -- Synaptic Spark Capacitor
			[193] = 4.44, -- Blightborne Infusion
			[492] = 2.9, -- Liberator's Might
			[522] = 5.09, -- Ancients' Bulwark
			[30] = 2.43, -- Overwhelming Power
			[124] = 1.39, -- Replicating Shadows
			[240] = 3.91, -- Blade In The Shadows
			[523] = 2.57, -- Apothecary's Concoctions
			[498] = 2.01, -- Barrage Of Many Bombs
			[541] = 0.74, -- Fight or Flight
			[194] = 2.31, -- Filthy Transfusion
			[82] = 4.3, -- Champion of Azeroth
			[479] = 3.24, -- Dagger in the Back
			[521] = 3.07, -- Shadow of Elune
			[562] = 3.62, -- Treacherous Covenant
			[414] = 3.73, -- Inevitability
			[483] = 2.6, -- Archive of the Titans
			[413] = 10, -- The First Dance
			[494] = 2.92, -- Battlefield Precision
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 5600 - 6402 (avg 6105), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[37] = { 2.25, 2.03 }, -- The Formless Void
			[28] = { 4.24, 1.24 }, -- The Unbound Force
			[4] = { 4.59, 0.62 }, -- Worldvein Resonance
			[22] = { 3.31, 0.87 }, -- Vision of Perfection
			[27] = { 7.43, 5.18 }, -- Memory of Lucid Dreams
			[23] = { 4.38, 0.96 }, -- Blood of the Enemy
			[36] = { 0.82, 0.74 }, -- Spark of Inspiration
			[6] = { 4.83, 1.75 }, -- Purification Protocol
			[32] = { 2.04, 1.91 }, -- Conflict and Strife
			[14] = { 4.99, 2.06 }, -- Condensed Life-Force
			[5] = { 7.17, 3.11 }, -- Essence of the Focusing Iris
			[12] = { 5.78, 1.92 }, -- The Crucible of Flame
			[15] = { 3.23, 0 }, -- Ripple in Space
			[35] = { 10, 3.95 }, -- Breath of the Dying
		}, 1589446800)

		insertDefaultScalesData(defaultName, 7, 1, { -- Elemental Shaman
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 13900 - 15605 (avg 14608), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[483] = 4.62, -- Archive of the Titans
			[105] = 0.14, -- Ephemeral Recovery
			[495] = 4.36, -- Anduin's Dedication
			[575] = 7.19, -- Undulating Tides
			[447] = 4.74, -- Ancestral Resonance
			[14] = 0.17, -- Longstrider
			[18] = 0.88, -- Blood Siphon
			[417] = 0.18, -- Tectonic Thunder
			[22] = 1.9, -- Heed My Call
			[30] = 3.47, -- Overwhelming Power
			[459] = 3.21, -- Unstable Flames
			[43] = 0.08, -- Winds of War
			[83] = 0.13, -- Impassive Visage
			[479] = 5.39, -- Dagger in the Back
			[13] = 0.16, -- Azerite Empowered
			[461] = 1.22, -- Earthlink
			[499] = 1.84, -- Ricocheting Inflatable Pyrosaw
			[582] = 6.2, -- Heart of Darkness
			[504] = 4.06, -- Unstable Catalyst
			[157] = 4.53, -- Rezan's Fury
			[505] = 2.63, -- Tradewinds
			[21] = 2.28, -- Elemental Whirl
			[416] = 8.33, -- Natural Harmony
			[31] = 2.17, -- Gutripper
			[474] = 0.19, -- Pack Spirit
			[194] = 4.06, -- Filthy Transfusion
			[100] = 0.07, -- Strength in Numbers
			[462] = 1.27, -- Azerite Globules
			[82] = 6.3, -- Champion of Azeroth
			[480] = 4.94, -- Blood Rite
			[539] = 0.19, -- Ancient Ankh Talisman
			[523] = 3.65, -- Apothecary's Concoctions
			[497] = 1.06, -- Stand As One
			[196] = 6.5, -- Swirling Sands
			[44] = 0.06, -- Vampiric Speed
			[526] = 7.68, -- Endless Hunger
			[87] = 0.19, -- Self Reliance
			[84] = 0.2, -- Bulwark of the Masses
			[38] = 2.35, -- On My Way
			[192] = 6.13, -- Meticulous Scheming
			[478] = 4.5, -- Tidal Surge
			[103] = 0.14, -- Concentrated Mending
			[560] = 2.2, -- Bonded Souls
			[561] = 3.48, -- Seductive Power
			[156] = 2.97, -- Ruinous Bolt
			[498] = 2.63, -- Barrage Of Many Bombs
			[496] = 1.65, -- Stronger Together
			[493] = 1.31, -- Last Gift
			[521] = 4.99, -- Shadow of Elune
			[501] = 4.96, -- Relational Normalization Gizmo
			[562] = 6.53, -- Treacherous Covenant
			[89] = 0.39, -- Azerite Veins
			[448] = 3.74, -- Synapse Shock
			[541] = 1.71, -- Fight or Flight
			[568] = 0.18, -- Person-Computer Interface
			[20] = 2.43, -- Lifespeed
			[195] = 4.08, -- Secrets of the Deep
			[482] = 3.61, -- Thunderous Blast
			[193] = 8.02, -- Blightborne Infusion
			[576] = 1.88, -- Loyal to the End
			[99] = 0.08, -- Ablative Shielding
			[522] = 7.48, -- Ancients' Bulwark
			[178] = 4.05, -- Lava Shock
			[485] = 3.52, -- Laser Matrix
			[222] = 3.17, -- Echo of the Elementals
			[569] = 7.32, -- Clockwork Heart
			[457] = 10, -- Igneous Potential
			[101] = 0.02, -- Shimmering Haven
			[494] = 4.3, -- Battlefield Precision
			[85] = 0.18, -- Gemhide
			[500] = 2.45, -- Synaptic Spark Capacitor
			[207] = 0.19, -- Serene Spirit
			[86] = 0.07, -- Azerite Fortification
			[481] = 2.29, -- Incite the Pack
			[502] = 0.03, -- Personal Absorb-o-Tron
			[492] = 5.09, -- Liberator's Might
			[577] = 4.9, -- Arcane Heart
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 13203 - 14932 (avg 14337), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[15] = { 3.09, 0.08 }, -- Ripple in Space
			[35] = { 10, 5.24 }, -- Breath of the Dying
			[37] = { 3.49, 3.46 }, -- The Formless Void
			[4] = { 5.63, 1.21 }, -- Worldvein Resonance
			[32] = { 9.13, 2.85 }, -- Conflict and Strife
			[12] = { 5.25, 2.77 }, -- The Crucible of Flame
			[36] = { 1.02, 1.15 }, -- Spark of Inspiration
			[23] = { 5.97, 1.16 }, -- Blood of the Enemy
			[14] = { 6.52, 2.66 }, -- Condensed Life-Force
			[5] = { 8.7, 4.54 }, -- Essence of the Focusing Iris
			[6] = { 5.01, 2.34 }, -- Purification Protocol
			[27] = { 1.91, 1.29 }, -- Memory of Lucid Dreams
			[22] = { 4.96, 1.44 }, -- Vision of Perfection
			[28] = { 5.13, 3.11 }, -- The Unbound Force
		}, 1589446800)

		insertDefaultScalesData(defaultName, 7, 2, { -- Enhancement Shaman
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 7302 - 9001 (avg 8102), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[157] = 4, -- Rezan's Fury
			[474] = 0.11, -- Pack Spirit
			[38] = 2.11, -- On My Way
			[82] = 5.99, -- Champion of Azeroth
			[483] = 3.92, -- Archive of the Titans
			[481] = 4, -- Incite the Pack
			[497] = 0.91, -- Stand As One
			[192] = 5.01, -- Meticulous Scheming
			[560] = 2.28, -- Bonded Souls
			[522] = 6.67, -- Ancients' Bulwark
			[501] = 4.07, -- Relational Normalization Gizmo
			[103] = 0.2, -- Concentrated Mending
			[89] = 0.01, -- Azerite Veins
			[416] = 8.36, -- Natural Harmony
			[498] = 2.66, -- Barrage Of Many Bombs
			[485] = 3.39, -- Laser Matrix
			[577] = 3.46, -- Arcane Heart
			[13] = 0.1, -- Azerite Empowered
			[504] = 3.17, -- Unstable Catalyst
			[195] = 3.45, -- Secrets of the Deep
			[30] = 3.07, -- Overwhelming Power
			[562] = 5.55, -- Treacherous Covenant
			[502] = 0.11, -- Personal Absorb-o-Tron
			[539] = 0.06, -- Ancient Ankh Talisman
			[461] = 1.3, -- Earthlink
			[21] = 2.21, -- Elemental Whirl
			[482] = 3.39, -- Thunderous Blast
			[495] = 3.5, -- Anduin's Dedication
			[530] = 7.4, -- Thunderaan's Fury
			[480] = 4.07, -- Blood Rite
			[43] = 0.22, -- Winds of War
			[499] = 1.78, -- Ricocheting Inflatable Pyrosaw
			[561] = 3.33, -- Seductive Power
			[496] = 1.56, -- Stronger Together
			[31] = 2.1, -- Gutripper
			[478] = 3.35, -- Tidal Surge
			[18] = 1.42, -- Blood Siphon
			[492] = 4.02, -- Liberator's Might
			[494] = 4.16, -- Battlefield Precision
			[137] = 1.47, -- Primal Primer
			[20] = 1.9, -- Lifespeed
			[87] = 0.13, -- Self Reliance
			[156] = 1.98, -- Ruinous Bolt
			[526] = 6.61, -- Endless Hunger
			[100] = 0.13, -- Strength in Numbers
			[104] = 0.15, -- Bracing Chill
			[479] = 4.28, -- Dagger in the Back
			[541] = 1.43, -- Fight or Flight
			[194] = 3.19, -- Filthy Transfusion
			[576] = 3.01, -- Loyal to the End
			[448] = 0.11, -- Synapse Shock
			[459] = 2.07, -- Unstable Flames
			[193] = 6.14, -- Blightborne Infusion
			[462] = 1.3, -- Azerite Globules
			[15] = 0.1, -- Resounding Protection
			[521] = 4.07, -- Shadow of Elune
			[98] = 0.05, -- Crystalline Carapace
			[420] = 10, -- Roiling Storm
			[179] = 3.92, -- Strength of Earth
			[503] = 0.02, -- Auto-Self-Cauterizer
			[85] = 0.19, -- Gemhide
			[500] = 1.82, -- Synaptic Spark Capacitor
			[569] = 6.04, -- Clockwork Heart
			[523] = 3.46, -- Apothecary's Concoctions
			[223] = 2.11, -- Lightning Conduit
			[493] = 2.22, -- Last Gift
			[505] = 4.22, -- Tradewinds
			[463] = 0.24, -- Blessed Portents
			[447] = 6.76, -- Ancestral Resonance
			[196] = 5.3, -- Swirling Sands
			[582] = 5.76, -- Heart of Darkness
			[42] = 0.26, -- Savior
			[99] = 0.05, -- Ablative Shielding
			[575] = 6.51, -- Undulating Tides
			[22] = 1.93, -- Heed My Call
			[101] = 0.07, -- Shimmering Haven
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 6700 - 8301 (avg 7839), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[27] = { 2.58, 1.72 }, -- Memory of Lucid Dreams
			[23] = { 7.65, 3.64 }, -- Blood of the Enemy
			[36] = { 0.93, 0.89 }, -- Spark of Inspiration
			[15] = { 3.22, 0.1 }, -- Ripple in Space
			[4] = { 5.14, 1.07 }, -- Worldvein Resonance
			[5] = { 7.77, 3.89 }, -- Essence of the Focusing Iris
			[32] = { 6.52, 2.46 }, -- Conflict and Strife
			[14] = { 6.52, 2.53 }, -- Condensed Life-Force
			[12] = { 5.41, 2.03 }, -- The Crucible of Flame
			[28] = { 4.69, 2.23 }, -- The Unbound Force
			[35] = { 10, 4.83 }, -- Breath of the Dying
			[22] = { 1.76, 0.41 }, -- Vision of Perfection
			[37] = { 2.99, 3.01 }, -- The Formless Void
			[6] = { 4.8, 2.4 }, -- Purification Protocol
		}, 1589446800)

		insertDefaultScalesData(offensiveName, 7, 3, { -- Restoration Shaman
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 22602 - 33039 (avg 25406), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[522] = 5.8, -- Ancients' Bulwark
			[30] = 3.23, -- Overwhelming Power
			[457] = 10, -- Igneous Potential
			[21] = 1.43, -- Elemental Whirl
			[503] = 0.07, -- Auto-Self-Cauterizer
			[492] = 3.57, -- Liberator's Might
			[541] = 0.87, -- Fight or Flight
			[496] = 0.99, -- Stronger Together
			[22] = 1.78, -- Heed My Call
			[497] = 0.65, -- Stand As One
			[44] = 0.01, -- Vampiric Speed
			[193] = 4.75, -- Blightborne Infusion
			[196] = 3.86, -- Swirling Sands
			[156] = 2.6, -- Ruinous Bolt
			[20] = 2.08, -- Lifespeed
			[43] = 0.13, -- Winds of War
			[481] = 0.16, -- Incite the Pack
			[526] = 5.85, -- Endless Hunger
			[195] = 2.74, -- Secrets of the Deep
			[224] = 0.06, -- Swelling Stream
			[18] = 0.22, -- Blood Siphon
			[448] = 2.77, -- Synapse Shock
			[494] = 4.03, -- Battlefield Precision
			[577] = 3.65, -- Arcane Heart
			[499] = 1.49, -- Ricocheting Inflatable Pyrosaw
			[500] = 2.3, -- Synaptic Spark Capacitor
			[521] = 4.16, -- Shadow of Elune
			[480] = 4.28, -- Blood Rite
			[14] = 0.19, -- Longstrider
			[15] = 0.06, -- Resounding Protection
			[207] = 0.06, -- Serene Spirit
			[194] = 3.85, -- Filthy Transfusion
			[38] = 1.59, -- On My Way
			[416] = 5.3, -- Natural Harmony
			[493] = 0.14, -- Last Gift
			[461] = 0.8, -- Earthlink
			[495] = 2.69, -- Anduin's Dedication
			[483] = 2.8, -- Archive of the Titans
			[575] = 6.44, -- Undulating Tides
			[82] = 4.32, -- Champion of Azeroth
			[582] = 3.93, -- Heart of Darkness
			[498] = 2.63, -- Barrage Of Many Bombs
			[501] = 3.87, -- Relational Normalization Gizmo
			[103] = 0.08, -- Concentrated Mending
			[479] = 4.66, -- Dagger in the Back
			[485] = 3.36, -- Laser Matrix
			[562] = 3.91, -- Treacherous Covenant
			[102] = 0.07, -- Synergistic Growth
			[560] = 2.14, -- Bonded Souls
			[84] = 0.31, -- Bulwark of the Masses
			[83] = 0.08, -- Impassive Visage
			[138] = 0.1, -- Soothing Waters
			[459] = 1.7, -- Unstable Flames
			[569] = 5.09, -- Clockwork Heart
			[192] = 2.66, -- Meticulous Scheming
			[89] = 0.14, -- Azerite Veins
			[504] = 2.34, -- Unstable Catalyst
			[463] = 0.05, -- Blessed Portents
			[462] = 1.06, -- Azerite Globules
			[502] = 0.08, -- Personal Absorb-o-Tron
			[85] = 0.05, -- Gemhide
			[157] = 4.18, -- Rezan's Fury
			[478] = 4.07, -- Tidal Surge
			[42] = 0.1, -- Savior
			[561] = 2.11, -- Seductive Power
			[482] = 3.44, -- Thunderous Blast
			[447] = 1.36, -- Ancestral Resonance
			[523] = 3.74, -- Apothecary's Concoctions
			[191] = 0.12, -- Turn of the Tide
			[576] = 0.03, -- Loyal to the End
			[31] = 1.73, -- Gutripper
			[98] = 0.01, -- Crystalline Carapace
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 23802 - 26200 (avg 25039), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[6] = { 3.41, 3.7 }, -- Purification Protocol
			[36] = { 1.87, 1.6 }, -- Spark of Inspiration
			[37] = { 3.58, 3.59 }, -- The Formless Void
			[32] = { 3.59, 3.5 }, -- Conflict and Strife
			[23] = { 1.64, 1.4 }, -- Blood of the Enemy
			[4] = { 3.85, 1.32 }, -- Worldvein Resonance
			[14] = { 4.06, 4.27 }, -- Condensed Life-Force
			[15] = { 3.58, 0.14 }, -- Ripple in Space
			[28] = { 3.28, 3.37 }, -- The Unbound Force
			[35] = { 7.68, 8.06 }, -- Breath of the Dying
			[27] = { 0, 0.16 }, -- Memory of Lucid Dreams
			[5] = { 6.72, 6.94 }, -- Essence of the Focusing Iris
			[12] = { 10, 5.21 }, -- The Crucible of Flame
			[22] = { 0.2, 0 }, -- Vision of Perfection
		}, 1589446800)

		insertDefaultScalesData(defaultName, 9, 1, { -- Affliction Warlock
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 21000 - 23402 (avg 22133), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[19] = 0.02, -- Woundbinder
			[425] = 3.98, -- Sudden Onset
			[14] = 0.05, -- Longstrider
			[103] = 0.34, -- Concentrated Mending
			[194] = 4.51, -- Filthy Transfusion
			[521] = 5.85, -- Shadow of Elune
			[82] = 7.79, -- Champion of Azeroth
			[526] = 8.9, -- Endless Hunger
			[500] = 2.63, -- Synaptic Spark Capacitor
			[492] = 5.35, -- Liberator's Might
			[541] = 1.4, -- Fight or Flight
			[481] = 4.55, -- Incite the Pack
			[576] = 3.13, -- Loyal to the End
			[569] = 8.04, -- Clockwork Heart
			[44] = 0.08, -- Vampiric Speed
			[99] = 0.16, -- Ablative Shielding
			[31] = 2.42, -- Gutripper
			[560] = 3.62, -- Bonded Souls
			[501] = 5.44, -- Relational Normalization Gizmo
			[497] = 0.79, -- Stand As One
			[157] = 5.1, -- Rezan's Fury
			[562] = 5.54, -- Treacherous Covenant
			[89] = 0.03, -- Azerite Veins
			[577] = 5.82, -- Arcane Heart
			[196] = 6.53, -- Swirling Sands
			[13] = 0.01, -- Azerite Empowered
			[485] = 4.26, -- Laser Matrix
			[499] = 2.01, -- Ricocheting Inflatable Pyrosaw
			[85] = 0.09, -- Gemhide
			[498] = 3.3, -- Barrage Of Many Bombs
			[22] = 2.29, -- Heed My Call
			[505] = 5.16, -- Tradewinds
			[42] = 0.02, -- Savior
			[156] = 2.97, -- Ruinous Bolt
			[20] = 2.84, -- Lifespeed
			[426] = 4.28, -- Dreadful Calling
			[195] = 3.44, -- Secrets of the Deep
			[493] = 2.48, -- Last Gift
			[504] = 3.16, -- Unstable Catalyst
			[123] = 5.13, -- Wracking Brilliance
			[442] = 4.78, -- Pandemic Invocation
			[193] = 8.16, -- Blightborne Infusion
			[459] = 2.71, -- Unstable Flames
			[502] = 0.04, -- Personal Absorb-o-Tron
			[582] = 7.58, -- Heart of Darkness
			[21] = 2.95, -- Elemental Whirl
			[494] = 5.45, -- Battlefield Precision
			[522] = 8.74, -- Ancients' Bulwark
			[523] = 4.31, -- Apothecary's Concoctions
			[18] = 1.81, -- Blood Siphon
			[479] = 5.68, -- Dagger in the Back
			[230] = 10, -- Cascading Calamity
			[462] = 1.69, -- Azerite Globules
			[461] = 1.46, -- Earthlink
			[183] = 6.31, -- Inevitable Demise
			[495] = 3.28, -- Anduin's Dedication
			[192] = 6.86, -- Meticulous Scheming
			[83] = 0.15, -- Impassive Visage
			[483] = 3.96, -- Archive of the Titans
			[561] = 3.19, -- Seductive Power
			[496] = 2.11, -- Stronger Together
			[98] = 0.03, -- Crystalline Carapace
			[575] = 7.97, -- Undulating Tides
			[480] = 5.88, -- Blood Rite
			[30] = 4.17, -- Overwhelming Power
			[482] = 4.51, -- Thunderous Blast
			[38] = 2.36, -- On My Way
			[478] = 4.75, -- Tidal Surge
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 19700 - 22707 (avg 21787), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[6] = { 5.14, 2.21 }, -- Purification Protocol
			[4] = { 2.82, 0.83 }, -- Worldvein Resonance
			[36] = { 0.98, 0.94 }, -- Spark of Inspiration
			[12] = { 5.91, 2.25 }, -- The Crucible of Flame
			[37] = { 2.18, 2.19 }, -- The Formless Void
			[28] = { 4.84, 2.3 }, -- The Unbound Force
			[14] = { 6, 2.45 }, -- Condensed Life-Force
			[32] = { 2.52, 2.6 }, -- Conflict and Strife
			[22] = { 1.86, 3.48 }, -- Vision of Perfection
			[27] = { 2, 1 }, -- Memory of Lucid Dreams
			[5] = { 9.73, 4.36 }, -- Essence of the Focusing Iris
			[35] = { 10, 4.75 }, -- Breath of the Dying
			[23] = { 6.76, 1.88 }, -- Blood of the Enemy
			[15] = { 2.7, 0.11 }, -- Ripple in Space
		}, 1589446800)

		insertDefaultScalesData(defaultName, 9, 2, { -- Demonology Warlock
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 14501 - 16502 (avg 15315), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[496] = 1.95, -- Stronger Together
			[568] = 0.05, -- Person-Computer Interface
			[84] = 0.01, -- Bulwark of the Masses
			[523] = 4.18, -- Apothecary's Concoctions
			[576] = 3.19, -- Loyal to the End
			[502] = 0.32, -- Personal Absorb-o-Tron
			[500] = 2.34, -- Synaptic Spark Capacitor
			[130] = 2.61, -- Shadow's Bite
			[19] = 0.18, -- Woundbinder
			[87] = 0.39, -- Self Reliance
			[522] = 8.36, -- Ancients' Bulwark
			[498] = 2.74, -- Barrage Of Many Bombs
			[429] = 10, -- Baleful Invocation
			[105] = 0.07, -- Ephemeral Recovery
			[561] = 3.56, -- Seductive Power
			[20] = 2.26, -- Lifespeed
			[501] = 5.36, -- Relational Normalization Gizmo
			[15] = 0.17, -- Resounding Protection
			[521] = 5.57, -- Shadow of Elune
			[44] = 0.26, -- Vampiric Speed
			[582] = 7.09, -- Heart of Darkness
			[13] = 0.08, -- Azerite Empowered
			[196] = 6.2, -- Swirling Sands
			[494] = 3.5, -- Battlefield Precision
			[195] = 4.19, -- Secrets of the Deep
			[193] = 8.32, -- Blightborne Infusion
			[482] = 3.74, -- Thunderous Blast
			[462] = 1.33, -- Azerite Globules
			[18] = 2.05, -- Blood Siphon
			[85] = 0.07, -- Gemhide
			[485] = 3.45, -- Laser Matrix
			[31] = 2.05, -- Gutripper
			[21] = 2.66, -- Elemental Whirl
			[194] = 4.23, -- Filthy Transfusion
			[38] = 2.53, -- On My Way
			[42] = 0.27, -- Savior
			[495] = 4.24, -- Anduin's Dedication
			[30] = 3.59, -- Overwhelming Power
			[562] = 6.49, -- Treacherous Covenant
			[82] = 7.44, -- Champion of Azeroth
			[483] = 4.6, -- Archive of the Titans
			[156] = 2.88, -- Ruinous Bolt
			[575] = 6.74, -- Undulating Tides
			[577] = 2.48, -- Arcane Heart
			[569] = 7.24, -- Clockwork Heart
			[99] = 0.09, -- Ablative Shielding
			[503] = 0.15, -- Auto-Self-Cauterizer
			[481] = 4.47, -- Incite the Pack
			[492] = 5.22, -- Liberator's Might
			[505] = 4.89, -- Tradewinds
			[83] = 0.04, -- Impassive Visage
			[428] = 4.55, -- Demonic Meteor
			[192] = 7.43, -- Meticulous Scheming
			[208] = 0.06, -- Lifeblood
			[479] = 4.95, -- Dagger in the Back
			[497] = 1.08, -- Stand As One
			[89] = 0.08, -- Azerite Veins
			[458] = 4.31, -- Supreme Commander
			[541] = 1.55, -- Fight or Flight
			[157] = 4.81, -- Rezan's Fury
			[475] = 0.25, -- Desperate Power
			[504] = 3.74, -- Unstable Catalyst
			[560] = 2.57, -- Bonded Souls
			[461] = 1.53, -- Earthlink
			[43] = 0.03, -- Winds of War
			[86] = 0.14, -- Azerite Fortification
			[480] = 5.75, -- Blood Rite
			[478] = 4.44, -- Tidal Surge
			[459] = 3.19, -- Unstable Flames
			[190] = 3.92, -- Umbral Blaze
			[463] = 0.18, -- Blessed Portents
			[101] = 0.04, -- Shimmering Haven
			[231] = 5.21, -- Explosive Potential
			[526] = 8.58, -- Endless Hunger
			[493] = 2.61, -- Last Gift
			[499] = 1.66, -- Ricocheting Inflatable Pyrosaw
			[22] = 1.97, -- Heed My Call
			[14] = 0.04, -- Longstrider
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 14100 - 15703 (avg 15057), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[35] = { 10, 5.45 }, -- Breath of the Dying
			[37] = { 3.97, 3.8 }, -- The Formless Void
			[6] = { 5.59, 2.55 }, -- Purification Protocol
			[23] = { 5.92, 0.63 }, -- Blood of the Enemy
			[15] = { 3.26, 0.07 }, -- Ripple in Space
			[32] = { 3.35, 3.44 }, -- Conflict and Strife
			[14] = { 6.9, 2.91 }, -- Condensed Life-Force
			[12] = { 5.85, 3.06 }, -- The Crucible of Flame
			[27] = { 5.38, 3.27 }, -- Memory of Lucid Dreams
			[5] = { 8.89, 3.94 }, -- Essence of the Focusing Iris
			[4] = { 6.61, 1.53 }, -- Worldvein Resonance
			[36] = { 1.3, 1.33 }, -- Spark of Inspiration
			[22] = { 8.32, 4.77 }, -- Vision of Perfection
			[28] = { 6.81, 3.52 }, -- The Unbound Force
		}, 1589446800)

		insertDefaultScalesData(defaultName, 9, 3, { -- Destruction Warlock
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 17400 - 19401 (avg 18277), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[523] = 4.61, -- Apothecary's Concoctions
			[82] = 8.61, -- Champion of Azeroth
			[42] = 0.16, -- Savior
			[479] = 6.25, -- Dagger in the Back
			[192] = 7.62, -- Meticulous Scheming
			[576] = 4.27, -- Loyal to the End
			[21] = 3.16, -- Elemental Whirl
			[459] = 3.38, -- Unstable Flames
			[560] = 3.56, -- Bonded Souls
			[43] = 0.21, -- Winds of War
			[521] = 6.98, -- Shadow of Elune
			[569] = 7.81, -- Clockwork Heart
			[432] = 6.55, -- Chaotic Inferno
			[30] = 5.23, -- Overwhelming Power
			[504] = 3.75, -- Unstable Catalyst
			[22] = 2.38, -- Heed My Call
			[501] = 6.53, -- Relational Normalization Gizmo
			[495] = 4.56, -- Anduin's Dedication
			[101] = 0.08, -- Shimmering Haven
			[482] = 4.2, -- Thunderous Blast
			[232] = 7.62, -- Flashpoint
			[208] = 0.11, -- Lifeblood
			[485] = 4.19, -- Laser Matrix
			[526] = 9.47, -- Endless Hunger
			[582] = 8.85, -- Heart of Darkness
			[499] = 2, -- Ricocheting Inflatable Pyrosaw
			[444] = 5.75, -- Crashing Chaos
			[480] = 7.04, -- Blood Rite
			[493] = 2.89, -- Last Gift
			[20] = 3.4, -- Lifespeed
			[31] = 2.45, -- Gutripper
			[494] = 5.24, -- Battlefield Precision
			[496] = 2.21, -- Stronger Together
			[478] = 5.05, -- Tidal Surge
			[460] = 6.34, -- Bursting Flare
			[38] = 2.65, -- On My Way
			[44] = 0.06, -- Vampiric Speed
			[462] = 1.54, -- Azerite Globules
			[481] = 5.28, -- Incite the Pack
			[492] = 6.48, -- Liberator's Might
			[431] = 0.24, -- Rolling Havoc
			[196] = 8.02, -- Swirling Sands
			[498] = 3.46, -- Barrage Of Many Bombs
			[194] = 4.75, -- Filthy Transfusion
			[157] = 5.63, -- Rezan's Fury
			[100] = 0.22, -- Strength in Numbers
			[193] = 10, -- Blightborne Infusion
			[483] = 4.9, -- Archive of the Titans
			[541] = 1.43, -- Fight or Flight
			[89] = 0.14, -- Azerite Veins
			[561] = 3.66, -- Seductive Power
			[577] = 6.68, -- Arcane Heart
			[156] = 3.04, -- Ruinous Bolt
			[500] = 2.83, -- Synaptic Spark Capacitor
			[18] = 1.97, -- Blood Siphon
			[99] = 0.19, -- Ablative Shielding
			[195] = 4.46, -- Secrets of the Deep
			[87] = 0.1, -- Self Reliance
			[562] = 6.99, -- Treacherous Covenant
			[13] = 0.08, -- Azerite Empowered
			[522] = 9.84, -- Ancients' Bulwark
			[461] = 1.67, -- Earthlink
			[86] = 0.27, -- Azerite Fortification
			[575] = 8.17, -- Undulating Tides
			[83] = 0.19, -- Impassive Visage
			[497] = 1.01, -- Stand As One
			[505] = 5.82, -- Tradewinds
			[131] = 6.14, -- Chaos Shards
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 16400 - 18805 (avg 17964), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[36] = { 1.05, 1.09 }, -- Spark of Inspiration
			[32] = { 2.25, 2.42 }, -- Conflict and Strife
			[37] = { 2.39, 2.53 }, -- The Formless Void
			[14] = { 4.35, 2.06 }, -- Condensed Life-Force
			[22] = { 10, 4.06 }, -- Vision of Perfection
			[6] = { 3.57, 1.75 }, -- Purification Protocol
			[15] = { 1.99, 0.02 }, -- Ripple in Space
			[5] = { 7.3, 4.19 }, -- Essence of the Focusing Iris
			[28] = { 2.9, 1.69 }, -- The Unbound Force
			[35] = { 7.36, 3.89 }, -- Breath of the Dying
			[4] = { 3.42, 0.99 }, -- Worldvein Resonance
			[27] = { 8.06, 2.02 }, -- Memory of Lucid Dreams
			[23] = { 3.26, 0.62 }, -- Blood of the Enemy
			[12] = { 3.76, 2.03 }, -- The Crucible of Flame
		}, 1589446800)

		insertDefaultScalesData(defaultName, 1, 1, { -- Arms Warrior
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 3703 - 4701 (avg 3983), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[38] = 1.46, -- On My Way
			[174] = 3.05, -- Gathering Storm
			[156] = 1.9, -- Ruinous Bolt
			[495] = 3.53, -- Anduin's Dedication
			[503] = 0.03, -- Auto-Self-Cauterizer
			[15] = 0.04, -- Resounding Protection
			[480] = 3.93, -- Blood Rite
			[192] = 5.01, -- Meticulous Scheming
			[194] = 3.48, -- Filthy Transfusion
			[493] = 2.57, -- Last Gift
			[31] = 2.06, -- Gutripper
			[461] = 1.21, -- Earthlink
			[505] = 4.85, -- Tradewinds
			[462] = 1.18, -- Azerite Globules
			[463] = 0.01, -- Blessed Portents
			[479] = 4.16, -- Dagger in the Back
			[569] = 6.14, -- Clockwork Heart
			[504] = 3.19, -- Unstable Catalyst
			[577] = 4.16, -- Arcane Heart
			[521] = 4.03, -- Shadow of Elune
			[561] = 3.78, -- Seductive Power
			[481] = 4.49, -- Incite the Pack
			[499] = 1.56, -- Ricocheting Inflatable Pyrosaw
			[157] = 4.05, -- Rezan's Fury
			[196] = 4.92, -- Swirling Sands
			[523] = 3.3, -- Apothecary's Concoctions
			[526] = 5.77, -- Endless Hunger
			[20] = 1.96, -- Lifespeed
			[575] = 6.78, -- Undulating Tides
			[494] = 4.37, -- Battlefield Precision
			[195] = 3.63, -- Secrets of the Deep
			[193] = 5.97, -- Blightborne Infusion
			[485] = 3.42, -- Laser Matrix
			[560] = 2.62, -- Bonded Souls
			[43] = 0.11, -- Winds of War
			[121] = 4.83, -- Striking the Anvil
			[101] = 0.11, -- Shimmering Haven
			[22] = 1.79, -- Heed My Call
			[500] = 1.6, -- Synaptic Spark Capacitor
			[576] = 3.4, -- Loyal to the End
			[433] = 2.97, -- Seismic Wave
			[478] = 2.98, -- Tidal Surge
			[82] = 6.13, -- Champion of Azeroth
			[483] = 4.19, -- Archive of the Titans
			[496] = 1.34, -- Stronger Together
			[434] = 6.23, -- Crushing Assault
			[501] = 4.06, -- Relational Normalization Gizmo
			[30] = 3.09, -- Overwhelming Power
			[459] = 2.11, -- Unstable Flames
			[582] = 5.81, -- Heart of Darkness
			[226] = 10, -- Test of Might
			[541] = 1.34, -- Fight or Flight
			[522] = 5.85, -- Ancients' Bulwark
			[482] = 3.48, -- Thunderous Blast
			[497] = 0.87, -- Stand As One
			[435] = 2.78, -- Lord of War
			[492] = 3.79, -- Liberator's Might
			[498] = 2.85, -- Barrage Of Many Bombs
			[562] = 5.61, -- Treacherous Covenant
			[21] = 1.92, -- Elemental Whirl
			[18] = 1.85, -- Blood Siphon
			[105] = 0.02, -- Ephemeral Recovery
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 3600 - 4201 (avg 3867), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[23] = { 4.88, 1.16 }, -- Blood of the Enemy
			[27] = { 10, 3.78 }, -- Memory of Lucid Dreams
			[6] = { 5.2, 2.15 }, -- Purification Protocol
			[35] = { 9.67, 5.08 }, -- Breath of the Dying
			[12] = { 5.52, 2.08 }, -- The Crucible of Flame
			[4] = { 5.28, 1.12 }, -- Worldvein Resonance
			[5] = { 7.85, 3.97 }, -- Essence of the Focusing Iris
			[36] = { 0.78, 0.95 }, -- Spark of Inspiration
			[14] = { 6.35, 2.66 }, -- Condensed Life-Force
			[32] = { 2.05, 2.03 }, -- Conflict and Strife
			[28] = { 4.26, 1.96 }, -- The Unbound Force
			[37] = { 2.98, 3.1 }, -- The Formless Void
			[15] = { 3.07, 0 }, -- Ripple in Space
		}, 1589446800)

		insertDefaultScalesData(defaultName, 1, 2, { -- Fury Warrior
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 4102 - 7748 (avg 4425), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[500] = 2.02, -- Synaptic Spark Capacitor
			[501] = 3.19, -- Relational Normalization Gizmo
			[20] = 1.31, -- Lifespeed
			[496] = 1.18, -- Stronger Together
			[156] = 2.05, -- Ruinous Bolt
			[497] = 0.68, -- Stand As One
			[523] = 3.19, -- Apothecary's Concoctions
			[13] = 0.14, -- Azerite Empowered
			[87] = 0.03, -- Self Reliance
			[522] = 5.27, -- Ancients' Bulwark
			[21] = 1.88, -- Elemental Whirl
			[462] = 1.46, -- Azerite Globules
			[526] = 5.38, -- Endless Hunger
			[504] = 2.62, -- Unstable Catalyst
			[119] = 5.98, -- Unbridled Ferocity
			[480] = 2.78, -- Blood Rite
			[195] = 2.99, -- Secrets of the Deep
			[157] = 4.8, -- Rezan's Fury
			[582] = 5.14, -- Heart of Darkness
			[481] = 4.06, -- Incite the Pack
			[561] = 3.18, -- Seductive Power
			[576] = 2.92, -- Loyal to the End
			[84] = 0.08, -- Bulwark of the Masses
			[485] = 3.86, -- Laser Matrix
			[495] = 2.79, -- Anduin's Dedication
			[483] = 3.29, -- Archive of the Titans
			[459] = 2.2, -- Unstable Flames
			[560] = 1.77, -- Bonded Souls
			[521] = 2.82, -- Shadow of Elune
			[482] = 3.88, -- Thunderous Blast
			[31] = 2.53, -- Gutripper
			[575] = 7.77, -- Undulating Tides
			[89] = 0.17, -- Azerite Veins
			[86] = 0.01, -- Azerite Fortification
			[82] = 5.39, -- Champion of Azeroth
			[438] = 5.22, -- Reckless Flurry
			[192] = 3.71, -- Meticulous Scheming
			[38] = 1.37, -- On My Way
			[22] = 2.16, -- Heed My Call
			[494] = 4.75, -- Battlefield Precision
			[437] = 4.71, -- Simmering Rage
			[451] = 3.29, -- Infinite Fury
			[562] = 4.48, -- Treacherous Covenant
			[492] = 3.32, -- Liberator's Might
			[479] = 4.06, -- Dagger in the Back
			[499] = 2.02, -- Ricocheting Inflatable Pyrosaw
			[498] = 3.14, -- Barrage Of Many Bombs
			[194] = 3.26, -- Filthy Transfusion
			[569] = 6.07, -- Clockwork Heart
			[98] = 0.11, -- Crystalline Carapace
			[478] = 3.52, -- Tidal Surge
			[193] = 5.72, -- Blightborne Infusion
			[505] = 4.41, -- Tradewinds
			[15] = 0.04, -- Resounding Protection
			[18] = 1.75, -- Blood Siphon
			[541] = 1.22, -- Fight or Flight
			[176] = 10, -- Cold Steel, Hot Blood
			[19] = 0.11, -- Woundbinder
			[30] = 1.94, -- Overwhelming Power
			[577] = 2.89, -- Arcane Heart
			[196] = 5.07, -- Swirling Sands
			[493] = 2.36, -- Last Gift
			[229] = 3.76, -- Pulverizing Blows
			[461] = 1, -- Earthlink
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 4000 - 4604 (avg 4305), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[36] = { 0.58, 0.64 }, -- Spark of Inspiration
			[27] = { 5.21, 2.33 }, -- Memory of Lucid Dreams
			[23] = { 1.43, 1.46 }, -- Blood of the Enemy
			[15] = { 1.94, 0.02 }, -- Ripple in Space
			[35] = { 10, 5.87 }, -- Breath of the Dying
			[37] = { 2.44, 2.61 }, -- The Formless Void
			[6] = { 4.95, 2.72 }, -- Purification Protocol
			[4] = { 3.67, 0.81 }, -- Worldvein Resonance
			[14] = { 6.04, 3.07 }, -- Condensed Life-Force
			[12] = { 4.79, 2.49 }, -- The Crucible of Flame
			[22] = { 2.24, 0.83 }, -- Vision of Perfection
			[28] = { 1.99, 0.64 }, -- The Unbound Force
			[5] = { 5.72, 2.46 }, -- Essence of the Focusing Iris
			[32] = { 1.96, 1.94 }, -- Conflict and Strife
		}, 1589446800)

		insertDefaultScalesData(offensiveName, 1, 3, { -- Protection Warrior
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 25301 - 29300 (avg 27744), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[43] = 0.13, -- Winds of War
			[522] = 7.38, -- Ancients' Bulwark
			[569] = 6.94, -- Clockwork Heart
			[440] = 1.22, -- Callous Reprisal
			[118] = 2, -- Deafening Crash
			[237] = 4.82, -- Bastion of Might
			[499] = 2.51, -- Ricocheting Inflatable Pyrosaw
			[44] = 0.17, -- Vampiric Speed
			[83] = 0.13, -- Impassive Visage
			[157] = 5.98, -- Rezan's Fury
			[577] = 3.89, -- Arcane Heart
			[496] = 1.62, -- Stronger Together
			[505] = 3.64, -- Tradewinds
			[479] = 4.15, -- Dagger in the Back
			[87] = 0.07, -- Self Reliance
			[101] = 0.12, -- Shimmering Haven
			[521] = 4.94, -- Shadow of Elune
			[501] = 4.62, -- Relational Normalization Gizmo
			[482] = 5.34, -- Thunderous Blast
			[493] = 2.06, -- Last Gift
			[504] = 2.87, -- Unstable Catalyst
			[156] = 3.22, -- Ruinous Bolt
			[480] = 4.64, -- Blood Rite
			[195] = 3.46, -- Secrets of the Deep
			[194] = 5.16, -- Filthy Transfusion
			[561] = 3.37, -- Seductive Power
			[14] = 0.11, -- Longstrider
			[450] = 4.6, -- Brace for Impact
			[31] = 3.13, -- Gutripper
			[478] = 5.26, -- Tidal Surge
			[100] = 0.2, -- Strength in Numbers
			[21] = 2.21, -- Elemental Whirl
			[481] = 3.42, -- Incite the Pack
			[541] = 1.32, -- Fight or Flight
			[177] = 0.03, -- Bloodsport
			[461] = 1.2, -- Earthlink
			[477] = 0.04, -- Bury the Hatchet
			[105] = 0.14, -- Ephemeral Recovery
			[18] = 1.56, -- Blood Siphon
			[526] = 7.2, -- Endless Hunger
			[495] = 3.45, -- Anduin's Dedication
			[20] = 2.42, -- Lifespeed
			[500] = 2.69, -- Synaptic Spark Capacitor
			[462] = 1.92, -- Azerite Globules
			[192] = 6.21, -- Meticulous Scheming
			[575] = 10, -- Undulating Tides
			[554] = 0.19, -- Intimidating Presence
			[483] = 4.18, -- Archive of the Titans
			[560] = 2.82, -- Bonded Souls
			[84] = 0.16, -- Bulwark of the Masses
			[485] = 5.21, -- Laser Matrix
			[562] = 5.13, -- Treacherous Covenant
			[497] = 0.84, -- Stand As One
			[582] = 6.11, -- Heart of Darkness
			[30] = 3.66, -- Overwhelming Power
			[523] = 4.34, -- Apothecary's Concoctions
			[82] = 6.49, -- Champion of Azeroth
			[441] = 2.28, -- Iron Fortress
			[576] = 2.77, -- Loyal to the End
			[459] = 2.7, -- Unstable Flames
			[193] = 7.47, -- Blightborne Infusion
			[89] = 0.02, -- Azerite Veins
			[498] = 4.11, -- Barrage Of Many Bombs
			[85] = 0.09, -- Gemhide
			[196] = 6.32, -- Swirling Sands
			[13] = 0.12, -- Azerite Empowered
			[98] = 0.43, -- Crystalline Carapace
			[38] = 1.94, -- On My Way
			[503] = 0.1, -- Auto-Self-Cauterizer
			[15] = 0.07, -- Resounding Protection
			[463] = 0.19, -- Blessed Portents
			[99] = 0.02, -- Ablative Shielding
			[502] = 0.08, -- Personal Absorb-o-Tron
			[568] = 0.01, -- Person-Computer Interface
			[22] = 2.85, -- Heed My Call
			[494] = 6.19, -- Battlefield Precision
			[492] = 4.52, -- Liberator's Might
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 25404 - 28803 (avg 27664), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Damage per Second,  Scaling: Linear 0 - 10, Precision: 2
			[7] = { 4.09, 0 }, -- Anima of Life and Death
			[3] = { 7.45, 7.76 }, -- Sphere of Suppression
			[37] = { 3.34, 3.51 }, -- The Formless Void
			[32] = { 3.51, 3.19 }, -- Conflict and Strife
			[2] = { 0.14, 0.16 }, -- Azeroth's Undying Gift
			[15] = { 4.18, 0 }, -- Ripple in Space
			[27] = { 2.49, 1.04 }, -- Memory of Lucid Dreams
			[25] = { 1.79, 1.3 }, -- Aegis of the Deep
			[4] = { 4.8, 1.44 }, -- Worldvein Resonance
			[12] = { 10, 3.94 }, -- The Crucible of Flame
			[34] = { 0.1, 0 }, -- Strength of the Warden
			[22] = { 8.29, 5.47 }, -- Vision of Perfection
			[33] = { 0.17, 0.15 }, -- Touch of the Everlasting
			[13] = { 0.29, 0.29 }, -- Nullification Dynamo
		}, 1589446800)

		insertDefaultScalesData(defensiveName, 12, 2, { -- Vengeance Demon Hunter (TMI)
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 3300 - 3604 (avg 3480), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Effective Theck-Meloree-Index,  Scaling: Linear 0 - 10, Precision: 2
			[157] = 1.3, -- Rezan's Fury
			[105] = 0.09, -- Ephemeral Recovery
			[498] = 1.33, -- Barrage Of Many Bombs
			[497] = 2.34, -- Stand As One
			[31] = 8.15, -- Gutripper
			[576] = 2.08, -- Loyal to the End
			[221] = 5.56, -- Rigid Carapace
			[18] = 1.57, -- Blood Siphon
			[500] = 3.09, -- Synaptic Spark Capacitor
			[20] = 10, -- Lifespeed
			[195] = 0.67, -- Secrets of the Deep
			[560] = 1.01, -- Bonded Souls
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 3303 - 3700 (avg 3494), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Effective Theck-Meloree-Index,  Scaling: Linear 0 - 10, Precision: 2
			[22] = { 0, 0.35 }, -- Vision of Perfection
			[3] = { 0, 5.82 }, -- Sphere of Suppression
			[12] = { 0, 0.04 }, -- The Crucible of Flame
			[27] = { 10, 0 }, -- Memory of Lucid Dreams
		}, 1589446800)

		insertDefaultScalesData(defensiveName, 11, 3, { -- Guardian Druid (TMI)
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 1600 - 3505 (avg 1755), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Effective Theck-Meloree-Index,  Scaling: Linear 0 - 10, Precision: 2
			[461] = 4.46, -- Earthlink
			[541] = 4.41, -- Fight or Flight
			[98] = 4.76, -- Crystalline Carapace
			[492] = 2.53, -- Liberator's Might
			[481] = 4.85, -- Incite the Pack
			[483] = 3.11, -- Archive of the Titans
			[171] = 5.85, -- Masterful Instincts
			[193] = 1.02, -- Blightborne Infusion
			[192] = 8.44, -- Meticulous Scheming
			[251] = 2.14, -- Burst of Savagery
			[561] = 1.15, -- Seductive Power
			[497] = 1.06, -- Stand As One
			[478] = 1.39, -- Tidal Surge
			[505] = 5.17, -- Tradewinds
			[86] = 8.64, -- Azerite Fortification
			[359] = 2.24, -- Wild Fleshrending
			[105] = 4.23, -- Ephemeral Recovery
			[467] = 2.76, -- Ursoc's Endurance
			[83] = 8, -- Impassive Visage
			[576] = 5.08, -- Loyal to the End
			[540] = 0.79, -- Switch Hitter
			[196] = 3.8, -- Swirling Sands
			[112] = 9.87, -- Layered Mane
			[568] = 1.86, -- Person-Computer Interface
			[82] = 6.29, -- Champion of Azeroth
			[20] = 5.06, -- Lifespeed
			[30] = 4.31, -- Overwhelming Power
			[502] = 3.46, -- Personal Absorb-o-Tron
			[15] = 6.7, -- Resounding Protection
			[503] = 2.77, -- Auto-Self-Cauterizer
			[14] = 5.3, -- Longstrider
			[100] = 1.02, -- Strength in Numbers
			[480] = 2.6, -- Blood Rite
			[104] = 1.42, -- Bracing Chill
			[42] = 1.76, -- Savior
			[43] = 7.71, -- Winds of War
			[504] = 3.19, -- Unstable Catalyst
			[575] = 0.79, -- Undulating Tides
			[562] = 6.49, -- Treacherous Covenant
			[87] = 3.58, -- Self Reliance
			[19] = 0.09, -- Woundbinder
			[194] = 0.58, -- Filthy Transfusion
			[500] = 2.7, -- Synaptic Spark Capacitor
			[99] = 2.25, -- Ablative Shielding
			[31] = 8.13, -- Gutripper
			[496] = 5.99, -- Stronger Together
			[577] = 0.89, -- Arcane Heart
			[493] = 0.49, -- Last Gift
			[459] = 4.96, -- Unstable Flames
			[22] = 5.6, -- Heed My Call
			[462] = 5.74, -- Azerite Globules
			[582] = 1.37, -- Heart of Darkness
			[485] = 2.44, -- Laser Matrix
			[523] = 3.73, -- Apothecary's Concoctions
			[89] = 2.74, -- Azerite Veins
			[569] = 5.3, -- Clockwork Heart
			[13] = 10, -- Azerite Empowered
			[85] = 4.35, -- Gemhide
			[526] = 5.75, -- Endless Hunger
			[157] = 1.54, -- Rezan's Fury
			[38] = 4.95, -- On My Way
			[495] = 6.58, -- Anduin's Dedication
			[103] = 2.92, -- Concentrated Mending
			[494] = 2.96, -- Battlefield Precision
			[360] = 3.33, -- Gory Regeneration
			[84] = 0.13, -- Bulwark of the Masses
			[156] = 3.67, -- Ruinous Bolt
			[499] = 0.24, -- Ricocheting Inflatable Pyrosaw
			[195] = 2.09, -- Secrets of the Deep
			[522] = 6.6, -- Ancients' Bulwark
			[44] = 6.03, -- Vampiric Speed
			[101] = 1.3, -- Shimmering Haven
			[521] = 3.76, -- Shadow of Elune
			[479] = 8.15, -- Dagger in the Back
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 1602 - 1901 (avg 1740), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Effective Theck-Meloree-Index,  Scaling: Linear 0 - 10, Precision: 2
			[34] = { 2.7, 6.46 }, -- Strength of the Warden
			[12] = { 9.79, 3.33 }, -- The Crucible of Flame
			[37] = { 10, 8.5 }, -- The Formless Void
			[32] = { 6.79, 0 }, -- Conflict and Strife
			[33] = { 7.57, 3.24 }, -- Touch of the Everlasting
			[27] = { 1.53, 7.99 }, -- Memory of Lucid Dreams
			[22] = { 2.75, 6.53 }, -- Vision of Perfection
			[2] = { 1.99, 0 }, -- Azeroth's Undying Gift
			[7] = { 0.22, 5.17 }, -- Anima of Life and Death
			[4] = { 7.92, 0 }, -- Worldvein Resonance
			[15] = { 2.37, 9.26 }, -- Ripple in Space
			[3] = { 2.73, 6.25 }, -- Sphere of Suppression
			[25] = { 7.17, 5.13 }, -- Aegis of the Deep
			[13] = { 7.58, 5.51 }, -- Nullification Dynamo
		}, 1589446800)

		insertDefaultScalesData(defensiveName, 10, 1, { -- Brewmaster Monk (TMI)
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 3700 - 4103 (avg 3908), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Effective Theck-Meloree-Index,  Scaling: Linear 0 - 10, Precision: 2
			[82] = 0.33, -- Champion of Azeroth
			[195] = 1.77, -- Secrets of the Deep
			[562] = 8.92, -- Treacherous Covenant
			[38] = 1.35, -- On My Way
			[575] = 0.04, -- Undulating Tides
			[193] = 5.86, -- Blightborne Infusion
			[238] = 0.28, -- Fit to Burst
			[483] = 1.26, -- Archive of the Titans
			[505] = 5.97, -- Tradewinds
			[383] = 5.17, -- Training of Niuzao
			[87] = 1.68, -- Self Reliance
			[496] = 2.69, -- Stronger Together
			[43] = 5.27, -- Winds of War
			[192] = 5.88, -- Meticulous Scheming
			[494] = 1.99, -- Battlefield Precision
			[218] = 4.12, -- Strength of Spirit
			[42] = 1.82, -- Savior
			[85] = 3.23, -- Gemhide
			[101] = 0.27, -- Shimmering Haven
			[99] = 5.48, -- Ablative Shielding
			[15] = 0.84, -- Resounding Protection
			[526] = 4.32, -- Endless Hunger
			[493] = 3.71, -- Last Gift
			[19] = 1.94, -- Woundbinder
			[382] = 4.14, -- Straight, No Chaser
			[44] = 5.32, -- Vampiric Speed
			[384] = 9.38, -- Elusive Footwork
			[196] = 8.01, -- Swirling Sands
			[498] = 0.35, -- Barrage Of Many Bombs
			[83] = 4.15, -- Impassive Visage
			[103] = 7.42, -- Concentrated Mending
			[569] = 4.17, -- Clockwork Heart
			[499] = 8.41, -- Ricocheting Inflatable Pyrosaw
			[105] = 2.46, -- Ephemeral Recovery
			[503] = 3.97, -- Auto-Self-Cauterizer
			[492] = 1.72, -- Liberator's Might
			[481] = 3.37, -- Incite the Pack
			[100] = 2.96, -- Strength in Numbers
			[560] = 2.35, -- Bonded Souls
			[30] = 3.17, -- Overwhelming Power
			[504] = 1.34, -- Unstable Catalyst
			[479] = 6.83, -- Dagger in the Back
			[482] = 10, -- Thunderous Blast
			[541] = 2.27, -- Fight or Flight
			[470] = 0.75, -- Sweep the Leg
			[566] = 6.13, -- Exit Strategy
			[13] = 8.31, -- Azerite Empowered
			[522] = 2.74, -- Ancients' Bulwark
			[21] = 4.65, -- Elemental Whirl
			[22] = 5.6, -- Heed My Call
			[485] = 1.6, -- Laser Matrix
			[86] = 2.01, -- Azerite Fortification
			[577] = 3.57, -- Arcane Heart
			[116] = 4.83, -- Boiling Brew
			[561] = 5.98, -- Seductive Power
			[14] = 3.38, -- Longstrider
			[194] = 3.67, -- Filthy Transfusion
			[495] = 1.54, -- Anduin's Dedication
			[478] = 6.12, -- Tidal Surge
			[461] = 0.64, -- Earthlink
			[523] = 3.54, -- Apothecary's Concoctions
			[18] = 6.19, -- Blood Siphon
			[89] = 3.63, -- Azerite Veins
			[31] = 1.09, -- Gutripper
			[576] = 2.18, -- Loyal to the End
			[501] = 1.86, -- Relational Normalization Gizmo
			[20] = 5.72, -- Lifespeed
			[521] = 6.97, -- Shadow of Elune
			[157] = 4.49, -- Rezan's Fury
			[104] = 5.06, -- Bracing Chill
			[568] = 0.08, -- Person-Computer Interface
			[98] = 5.3, -- Crystalline Carapace
			[186] = 7.53, -- Staggering Strikes
			[462] = 6.29, -- Azerite Globules
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 3700 - 4103 (avg 3891), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Effective Theck-Meloree-Index,  Scaling: Linear 0 - 10, Precision: 2
			[32] = { 0.89, 5.58 }, -- Conflict and Strife
			[7] = { 9.75, 0.77 }, -- Anima of Life and Death
			[33] = { 6.55, 8.73 }, -- Touch of the Everlasting
			[12] = { 2.66, 1.14 }, -- The Crucible of Flame
			[37] = { 3.77, 0 }, -- The Formless Void
			[2] = { 9.05, 7.38 }, -- Azeroth's Undying Gift
			[3] = { 3.21, 0 }, -- Sphere of Suppression
			[27] = { 0, 6.37 }, -- Memory of Lucid Dreams
			[22] = { 1.86, 10 }, -- Vision of Perfection
			[4] = { 4.5, 1.8 }, -- Worldvein Resonance
			[25] = { 2.76, 2.14 }, -- Aegis of the Deep
			[34] = { 6.86, 7.32 }, -- Strength of the Warden
			[15] = { 0, 7.93 }, -- Ripple in Space
		}, 1589446800)

		insertDefaultScalesData(defensiveName, 2, 2, { -- Protection Paladin (TMI)
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 31901 - 33202 (avg 32691), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Effective Theck-Meloree-Index,  Scaling: Linear 0 - 10, Precision: 2
			[499] = 1.87, -- Ricocheting Inflatable Pyrosaw
			[393] = 6.05, -- Grace of the Justicar
			[582] = 2.55, -- Heart of Darkness
			[15] = 5.81, -- Resounding Protection
			[87] = 2.23, -- Self Reliance
			[89] = 7.78, -- Azerite Veins
			[561] = 2.89, -- Seductive Power
			[22] = 3.12, -- Heed My Call
			[83] = 7.13, -- Impassive Visage
			[541] = 2.93, -- Fight or Flight
			[523] = 4.28, -- Apothecary's Concoctions
			[42] = 6.48, -- Savior
			[30] = 5.41, -- Overwhelming Power
			[479] = 6.81, -- Dagger in the Back
			[482] = 5.41, -- Thunderous Blast
			[568] = 6.3, -- Person-Computer Interface
			[98] = 8.39, -- Crystalline Carapace
			[86] = 3.4, -- Azerite Fortification
			[13] = 2.74, -- Azerite Empowered
			[492] = 1.49, -- Liberator's Might
			[38] = 5.14, -- On My Way
			[193] = 7.41, -- Blightborne Infusion
			[99] = 5.01, -- Ablative Shielding
			[31] = 3.35, -- Gutripper
			[20] = 2.98, -- Lifespeed
			[19] = 5.02, -- Woundbinder
			[526] = 6.52, -- Endless Hunger
			[500] = 3.63, -- Synaptic Spark Capacitor
			[235] = 2.47, -- Indomitable Justice
			[18] = 0.17, -- Blood Siphon
			[495] = 5.79, -- Anduin's Dedication
			[577] = 2.42, -- Arcane Heart
			[483] = 4.91, -- Archive of the Titans
			[485] = 6.89, -- Laser Matrix
			[195] = 2.9, -- Secrets of the Deep
			[503] = 3.57, -- Auto-Self-Cauterizer
			[157] = 6.7, -- Rezan's Fury
			[44] = 2.28, -- Vampiric Speed
			[498] = 5.34, -- Barrage Of Many Bombs
			[150] = 7.13, -- Soaring Shield
			[461] = 4.98, -- Earthlink
			[189] = 6.22, -- Righteous Conviction
			[196] = 4.26, -- Swirling Sands
			[194] = 6.19, -- Filthy Transfusion
			[395] = 10, -- Inspiring Vanguard
			[501] = 3.65, -- Relational Normalization Gizmo
			[504] = 2.44, -- Unstable Catalyst
			[105] = 8.09, -- Ephemeral Recovery
			[100] = 6.17, -- Strength in Numbers
			[133] = 5.88, -- Bulwark of Light
			[459] = 4.9, -- Unstable Flames
			[156] = 2.29, -- Ruinous Bolt
			[481] = 3.68, -- Incite the Pack
			[85] = 4.58, -- Gemhide
			[104] = 5.03, -- Bracing Chill
			[478] = 5.26, -- Tidal Surge
			[234] = 1.98, -- Inner Light
			[101] = 6.16, -- Shimmering Haven
			[521] = 5.4, -- Shadow of Elune
			[522] = 8.69, -- Ancients' Bulwark
			[480] = 6.71, -- Blood Rite
			[575] = 7.82, -- Undulating Tides
			[505] = 4.91, -- Tradewinds
			[454] = 3.69, -- Judicious Defense
			[84] = 4.04, -- Bulwark of the Masses
			[103] = 3.56, -- Concentrated Mending
			[192] = 4.89, -- Meticulous Scheming
			[462] = 4.1, -- Azerite Globules
			[496] = 3.95, -- Stronger Together
			[502] = 2.94, -- Personal Absorb-o-Tron
			[463] = 5.2, -- Blessed Portents
			[538] = 4.33, -- Empyreal Ward
			[21] = 4.89, -- Elemental Whirl
			[82] = 4.81, -- Champion of Azeroth
			[125] = 3.24, -- Avenger's Might
			[560] = 4.13, -- Bonded Souls
			[493] = 3.74, -- Last Gift
			[497] = 3.33, -- Stand As One
			[562] = 7.69, -- Treacherous Covenant
			[569] = 4.16, -- Clockwork Heart
			[14] = 1.18, -- Longstrider
			[494] = 0.69, -- Battlefield Precision
			[206] = 0.87, -- Stalwart Protector
			[576] = 7.8, -- Loyal to the End
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 32201 - 33502 (avg 32636), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Effective Theck-Meloree-Index,  Scaling: Linear 0 - 10, Precision: 2
			[2] = { 3.18, 2.71 }, -- Azeroth's Undying Gift
			[12] = { 6.08, 4.1 }, -- The Crucible of Flame
			[37] = { 7.82, 3.95 }, -- The Formless Void
			[4] = { 8.85, 5.08 }, -- Worldvein Resonance
			[33] = { 3.61, 6.71 }, -- Touch of the Everlasting
			[13] = { 3.97, 5 }, -- Nullification Dynamo
			[22] = { 3.7, 3.58 }, -- Vision of Perfection
			[7] = { 4.74, 2.77 }, -- Anima of Life and Death
			[15] = { 2.41, 9.06 }, -- Ripple in Space
			[25] = { 3.35, 2.3 }, -- Aegis of the Deep
			[32] = { 7.11, 0 }, -- Conflict and Strife
			[3] = { 10, 6.56 }, -- Sphere of Suppression
			[27] = { 3.51, 4.26 }, -- Memory of Lucid Dreams
			[34] = { 1.87, 3.41 }, -- Strength of the Warden
		}, 1589446800)

		insertDefaultScalesData(defensiveName, 1, 3, { -- Protection Warrior (TMI)
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 27500 - 31148 (avg 28312), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Effective Theck-Meloree-Index,  Scaling: Linear 0 - 10, Precision: 2
			[493] = 5.25, -- Last Gift
			[526] = 4.98, -- Endless Hunger
			[89] = 3.3, -- Azerite Veins
			[499] = 1.48, -- Ricocheting Inflatable Pyrosaw
			[523] = 8.22, -- Apothecary's Concoctions
			[22] = 5.43, -- Heed My Call
			[483] = 4.97, -- Archive of the Titans
			[19] = 6.32, -- Woundbinder
			[105] = 3.77, -- Ephemeral Recovery
			[476] = 5.3, -- Moment of Glory
			[504] = 3.92, -- Unstable Catalyst
			[441] = 6.86, -- Iron Fortress
			[463] = 0.15, -- Blessed Portents
			[462] = 7.13, -- Azerite Globules
			[450] = 3.94, -- Brace for Impact
			[118] = 2.61, -- Deafening Crash
			[582] = 2.86, -- Heart of Darkness
			[18] = 3.44, -- Blood Siphon
			[42] = 0.15, -- Savior
			[492] = 10, -- Liberator's Might
			[494] = 7.02, -- Battlefield Precision
			[194] = 2.91, -- Filthy Transfusion
			[561] = 0.21, -- Seductive Power
			[500] = 6.18, -- Synaptic Spark Capacitor
			[192] = 6.76, -- Meticulous Scheming
			[15] = 2.66, -- Resounding Protection
			[502] = 3.47, -- Personal Absorb-o-Tron
			[38] = 1.89, -- On My Way
			[157] = 5.36, -- Rezan's Fury
			[577] = 2.58, -- Arcane Heart
			[100] = 5.21, -- Strength in Numbers
			[459] = 1.71, -- Unstable Flames
			[495] = 3.33, -- Anduin's Dedication
			[497] = 7.47, -- Stand As One
			[84] = 4.37, -- Bulwark of the Masses
			[521] = 3.25, -- Shadow of Elune
			[14] = 1.65, -- Longstrider
			[503] = 3.71, -- Auto-Self-Cauterizer
			[440] = 2.96, -- Callous Reprisal
			[21] = 4.59, -- Elemental Whirl
			[43] = 3.77, -- Winds of War
			[541] = 1.59, -- Fight or Flight
			[575] = 7.08, -- Undulating Tides
			[479] = 4.31, -- Dagger in the Back
			[505] = 1.71, -- Tradewinds
			[99] = 8.4, -- Ablative Shielding
			[101] = 6.51, -- Shimmering Haven
			[156] = 4.32, -- Ruinous Bolt
			[86] = 4.03, -- Azerite Fortification
			[196] = 3.69, -- Swirling Sands
			[85] = 4.08, -- Gemhide
			[177] = 3.15, -- Bloodsport
			[44] = 4.69, -- Vampiric Speed
			[496] = 3.13, -- Stronger Together
			[31] = 6.62, -- Gutripper
			[461] = 4.87, -- Earthlink
			[477] = 6.69, -- Bury the Hatchet
			[30] = 4.1, -- Overwhelming Power
			[104] = 3.52, -- Bracing Chill
			[103] = 4.41, -- Concentrated Mending
			[522] = 5.89, -- Ancients' Bulwark
			[98] = 3.06, -- Crystalline Carapace
			[195] = 5.41, -- Secrets of the Deep
			[478] = 7, -- Tidal Surge
			[482] = 6.57, -- Thunderous Blast
			[480] = 4.86, -- Blood Rite
			[20] = 2.85, -- Lifespeed
			[237] = 5.16, -- Bastion of Might
			[498] = 3.87, -- Barrage Of Many Bombs
			[560] = 6.97, -- Bonded Souls
			[576] = 4.44, -- Loyal to the End
			[82] = 3.85, -- Champion of Azeroth
			[569] = 6.53, -- Clockwork Heart
			[83] = 2.74, -- Impassive Visage
			[501] = 6.88, -- Relational Normalization Gizmo
			[562] = 1.9, -- Treacherous Covenant
			[13] = 6.2, -- Azerite Empowered
			[481] = 2.51, -- Incite the Pack
			[554] = 5.69, -- Intimidating Presence
			[193] = 7.22, -- Blightborne Infusion
			[485] = 6.47, -- Laser Matrix
			[87] = 4.32, -- Self Reliance
			[568] = 4.09, -- Person-Computer Interface
		}, { -- Azerite Essences
			-- SimulationCraft 830-02 for World of Warcraft 8.3.0 Live (wow build 33051)
			-- Iterations: 27705 - 28901 (avg 28267), Target Error: 0.1, Fight Length: 240 - 360, Fight Style: Patchwerk
			-- Updated: 14.05.2020, Metric: Effective Theck-Meloree-Index,  Scaling: Linear 0 - 10, Precision: 2
			[27] = { 4.86, 7.82 }, -- Memory of Lucid Dreams
			[13] = { 3.73, 5.04 }, -- Nullification Dynamo
			[22] = { 1.73, 6.39 }, -- Vision of Perfection
			[34] = { 10, 5.1 }, -- Strength of the Warden
			[37] = { 7.09, 9.61 }, -- The Formless Void
			[2] = { 8.56, 1.98 }, -- Azeroth's Undying Gift
			[4] = { 6.83, 5.77 }, -- Worldvein Resonance
			[25] = { 5.3, 1.95 }, -- Aegis of the Deep
			[33] = { 2.94, 7.17 }, -- Touch of the Everlasting
			[15] = { 6.4, 5.73 }, -- Ripple in Space
			[12] = { 6.08, 4.94 }, -- The Crucible of Flame
			[32] = { 5.06, 6.04 }, -- Conflict and Strife
			[3] = { 6.1, 5.37 }, -- Sphere of Suppression
			[7] = { 5.82, 1.04 }, -- Anima of Life and Death
		}, 1589446800)

		insertDefaultScalesData(defaultName, 5, 3, { -- Shadow Priest
			-- Shadow Priest by WarcraftPriests (https://warcraftpriests.com/)
			-- https://github.com/WarcraftPriests/bfa-shadow-priest/blob/master/azerite-traits/AzeritePowerWeights_AS.md
			-- First Imported: 03.09.2018, Updated: 14.05.2020
			[575] = 5.08,
			[405] = 4.93,
			[193] = 4.79,
			[236] = 4.52,
			[82] = 4.45,
			[522] = 4.25,
			[196] = 4.25,
			[526] = 4.22,
			[582] = 4.08,
			[569] = 3.78,
			[192] = 3.73,
			[479] = 3.47,
			[501] = 3.35,
			[488] = 3.33,
			[157] = 3.11,
			[505] = 2.95,
			[486] = 2.94,
			[480] = 2.93,
			[521] = 2.92,
			[481] = 2.75,
			[482] = 2.73,
			[577] = 2.69,
			[523] = 2.66,
			[194] = 2.62,
			[504] = 2.61,
			[478] = 2.43,
			[404] = 2.38,
			[403] = 2.35,
			[195] = 2.33,
			[489] = 2.26,
			[30] = 2.23,
			[498] = 2.07,
			[459] = 1.66,
			[31] = 1.57,
			[487] = 1.57,
			[156] = 1.49,
			[21] = 1.46,
			[22] = 1.38,
			[500] = 1.29,
			[499] = 1.25,
			[38] = 1.22,
			[18] = 1.12,
			[490] = 1.11,
			[166] = 1.06,
			[491] = 1.02,
			[462] = 0.91,
			[541] = 0.89,
			[461] = 0.77,
			[13] = 0.4,
		}, {
		}, 1589446800)

		insertDefaultScalesData(defensiveName, 6, 1, { -- Blood Death Knight
			-- Blood Death Knight by Acherus
			-- https://github.com/ahakola/AzeritePowerWeights/pull/3
			-- First Imported: 07.09.2019, Updated: 07.09.2019
			[560] = 2.25,
			[243] = 2.5,
			[481] = 5.85,
			[196] = 3.81,
			[193] = 4.12,
			[461] = 0.72,
			[496] = 1.05,
			[43] = 0.11,
			[83] = 10,
			[349] = 1,
			[197] = 0.3,
			[495] = 1.99,
			[82] = 6.03,
			[15] = 10,
			[348] = 2,
			[18] = 5.65,
			[526] = 3.6,
			[577] = 0.92,
			[561] = 4.22,
			[30] = 3.86,
			[192] = 5.2,
			[505] = 6.41,
			[501] = 4.85,
			[493] = 3.5,
			[521] = 4.16,
			[497] = 0.9,
			[459] = 1.6,
			[195] = 2.38,
			[201] = 0.04,
			[106] = 3.85,
			[492] = 3.38,
			[21] = 1.77,
			[480] = 3.98,
			[140] = 2.69,
			[485] = 0.06,
			[44] = 3,
			[498] = 0.08,
			[19] = 0.06,
			[504] = 2.8,
			[20] = 2.2,
			[541] = 0.91,
			[562] = 3.78,
			[479] = 0.01,
			[569] = 4.52,
			[522] = 3.34,
			[38] = 0.81,
			[22] = 0.05,
			[576] = 4.35,
			[483] = 3.04,
			[104] = 0.13,
		}, {
			[32] = { 0.71, 3.7 },
			[3] = { 1.2, 0.5 },
			[7] = { 0.7, 0.3 },
			[4] = { 0.69, 0.48 },
			[25] = { 0.36, 2.5 },
			[12] = { 3, 1.7 },
			[2] = { 1.2, 0.03 },
			[22] = { 0.4, 0 },
			[15] = { 0.56, 0 },
			[27] = { 1.5, 0.7 },
		}, 1589446800)

		insertDefaultScalesData(defaultName, 5, 2, { -- Holy Priest
			-- Holy Priest by Simbiawow
			-- https://www.curseforge.com/private-messages/
			-- First Imported: 11.04.2020, Updated: 11.04.2020
			[102] = 4.5,
			[103] = 4.41,
			[104] = 1.51,
			[105] = 3.64,
			[114] = 2,
			[13] = 1,
			[14] = 3.64,
			[15] = 4.5,
			[165] = 3.11,
			[18] = 4.13,
			[192] = 1.51,
			[193] = 3.52,
			[196] = 3.64,
			[19] = 2,
			[204] = 4.13,
			[228] = 4.5,
			[30] = 1.72,
			[38] = 3.7,
			[400] = 3.26,
			[401] = 4.29,
			[402] = 3.7,
			[42] = 3.4,
			[44] = 3.7,
			[461] = 3.52,
			[463] = 4.29,
			[472] = 3.52,
			[480] = 1.72,
			[504] = 1.25,
			[576] = 4.13,
			[577] = 3.4,
			[582] = 4.41,
			[83] = 4.41,
			[84] = 1.72,
			[85] = 4.29,
			[86] = 2,
		}, {
			[24] = { 3.4, 4.11 },
			[27] = { 4.41, 3.7 },
			[37] = { 1.72, 0 },
			[18] = { 0, 2 },
			[16] = { 3.52, 4.26 },
			[32] = { 2, 4.7 },
			[5] = { 0, 0 },
			[19] = { 0, 4.64 },
			[20] = { 4.5, 4.4 },
			[21] = { 3.7, 1.72 },
			[22] = { 4.13, 3.64 },
			[12] = { 4.29, 0 },
			[17] = { 3.64, 4.52 },
		}, 1589446800)


		insertDefaultScalesData(defaultName, 7, 3, { -- Restoration Shaman

		}, {})

		insertDefaultScalesData(defaultName, 10, 2, { -- Mistweaver Monk

		}, {})

		insertDefaultScalesData(defaultName, 11, 4, { -- Restoration Druid

		}, {})

		insertDefaultScalesData(defaultName, 2, 1, { -- Holy Paladin

		}, {})

		insertDefaultScalesData(defaultName, 5, 1, { -- Discipline Priest

		}, {})

end

local tankSpecs = {
	[1] = 3, -- Protection Warrior
	[2] = 2, -- Protection Paladin
	[6] = 1, -- Blood Death Knight
	[10] = 1, -- Brewmaster Monk
	[11] = 3, -- Guardian Druid
	[12] = 2 -- Vengeance Demon Hunter
}

-- Default ScaleSets for Class and Spec Combinations
local function GetDefaultScaleSet(classID, specNum)
	if (classID) and (specNum) then
		if tankSpecs[classID] == specNum then -- Tank Case
			return "D/"..classID.."/"..specNum.."/"..defensiveName
		else -- Generic Case
			return "D/"..classID.."/"..specNum.."/"..defaultName
		end
	end
end

n.GetDefaultScaleSet = GetDefaultScaleSet

--#EOF