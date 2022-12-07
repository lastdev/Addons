local _, ns = ...
local points = ns.points
local textures = ns.textures
local scaling = ns.scaling
local texturesSpecial = ns.texturesSpecial
local scalingSpecial = ns.scalingSpecial

-- The Oceanus Cove is its own zone, rather than a sub-zone
-- Caves are used extensively in the zone. They don't necessarily have crystal spawn points
-- I show cave entrances when outside a cave. Once inside the Minimap shows the actual spawn point
-- Thus it depends where we are in the zone as to which pins to display

-- From multiple data sources it is very clear that players are copying coordinates and thus copying
-- obvious (and less obvious) errors. All locations here, except as noted, have been doubly found by
-- myself. I've included one or two from other sources which seem plausible, as well as an obvious
-- error. Some errors have come about due to Blizzard switching coordinate systems once inside a cave.

points[ns.azsuna] = {

-- "C" = Cave Crystals. The x/y Min/Max are for my "lines" to indicate whether the player is inside or
-- outside the cave. This affects whether to show the cave entrance or the actual crystal location

	[30562631] = { dt = "C", tip = "Online reports cite an Ephemeral Crystal in this cave. Very likely",
					xMin = 30.14, xMax = 31.16, yMin = 23.89, yMax = 26.80 },
	[34553568] = { dt = "C", tip = "Exact placement has not been verified\nbut the cave is rather small",
					xMin = 34.37, xMax = 34.71, yMin = 35.44, yMax = 35.90 },
	[41503080] = { dt = "C", tip = "Inside the cave, on a flat, low rock\non the right side of the entrance."
					.."\nExact placement not yet verified", -- See http://i.imgur.com/B1SR19p.jpg
					xMin = 41.26, xMax = 41.54, yMin = 30.58, yMax = 31.13 },
	[42651809] = { dt = "C", tip = "On a small rock with a skull to its\nnorth-west side and a backbone\n"
					.."and ribs skeleton to its north-east",
					xMin = 42.21, xMax = 44.17, yMin = 16.8, yMax = 18.36 },
	[49100822] = { dt = "C", tip = "Centrally placed on a flat rock\nthat projects into the water",
					xMin = 48.92, xMax = 50.07, yMin = 7.5, yMax = 9.23 },
	[50162346] = { dt = "C", tip = "Amongst the purple crystals. Look\ncarefully as only the tip is visible\n"
					.."and it is a darker purple.\nNote: Leyhollow. NOT Azurewing Repose",
					xMin = 47.26, xMax = 52.05, yMin = 19.56, yMax = 25.12 },
	[50375692] = { dt = "C", tip = "Inside the cave, on a\nchest with crescent motif",
					xMin = 50.33, xMax = 50.61, yMin = 56.66, yMax = 57.2 },
	[50552033] = { dt = "C", tip = "Against a northern wall, a small\ncrystal to its north-east and a\n"
					.."much larger one beyond that",
					xMin = 47.26, xMax = 52.05, yMin = 19.56, yMax = 25.12 },
	[50775000] = { dt = "C", tip = "On the eastern side of two seats and a table",
					xMin = 49.81, xMax = 50.99, yMin = 48.96, yMax = 50.62 },
	[53822799] = { dt = "C", tip = "Between four vertebrae\nand a natural rock pillar",
					xMin = 52.78, xMax = 53.97, yMin = 27.36, yMax = 29.45 },
	[54865233] = { dt = "C", tip = "Inside the cave, on a flat, low rock\non the right side of the entrance",
					xMin = 54.63, xMax = 54.98, yMin = 52, yMax = 52.43 },
	[56922600] = { dt = "C", tip = "Against a wall, with a small rock\nto its east and a floor-to-ceiling\n"
					.."stone support due north",
					xMin = 55.83, xMax = 57.28, yMin = 24.48, yMax = 26.16 },
	[57644229] = { dt = "C", tip = "Against a wall, behind four vertebrae,\npartly concealed by a stone ceremonial\n"
					.."structure to its north-east. Golk the\nRumble is 16-17 yards to the south",
					xMin = 57.33, xMax = 58.42, yMin = 41.87, yMax = 43.63 },
	[58504562] = { dt = "C", tip = "On a small rock with a skull to its\nnorth-west side and a skeleton's\n"
					.."backbone and ribs to its north-east.\n30 yards south of Eksis", 
					xMin = 57.89, xMax = 59.78, yMin = 44.26, yMax = 45.90 },
	[61143043] = { dt = "C", tip = "On a flat rock, nestling between exposed\nroots and the rock wall",
					xMin = 60.32, xMax = 61.29, yMin = 30.07, yMax = 30.49 },
	[63515413] = { dt = "C", tip = "On a skeleton in a nook\nframed by flat stone slabs", 
					xMin = 62.63, xMax = 63.91, yMin = 52.67, yMax = 54.38 },

--	"E" = Ephemeral Crystal

	[29843585] = { dt = "E", tip = "Southern side of the base of the\nlargest of two whithered trees" },
	[29862657] = { dt = "E", tip = "On rocks at the south west corner\nof the island, just above the water-\n"
							.."line. Accessible via the water" },						
	[34921714] = { dt = "E", tip = "Western side of ruined structure,\nadjacent to overhanging foliage\n"
							.."and close to the shoreline." },
	[35593780] = { dt = "E", tip = "Western side of the tree, near\na rocky ledge to the south\nand a path to the north" },
	[36003600] = { dt = "E", tip = "On the cliff edge. Likely, but\nnot verified by the author", author = true },
	[36042302] = { dt = "E", tip = "Nestled between two trees" },
	[36551218] = { dt = "E", tip = "On a rocky rise, north of a large\ntent, clearly visible from afar" }, 
	[37052161] = { dt = "E", tip = "Close to the stonework of the\nTimeworn Strand, north-east\nof a tree" },
	[37523292] = { dt = "E", tip = "In the grass between the tree and the\nstair-wall, at the foot of the stairs" },
	[38690931] = { dt = "E", tip = "West of the Challiane's Terrace Flight\nMaster, past the pond, one quarter\n"
							.."of the way towards the cliff edge" },
	[40273282] = { dt = "E", tip = "Northern side of the tree\nat the foot of a rocky rise" },
	[40483754] = { dt = "E", tip = "Southern side of the tree,\nsurrounded by broken stone works" },
	[40703587] = { dt = "E", tip = "In the bushes on the south\nside of the tree. Easily missed" },
	[42220835] = { dt = "E", tip = "On a landing a little way down a cliff.\nVisibility might be affected by quest phasing" },
	[43002887] = { dt = "E", tip = "Between a large rock to the south-\nwest and a thin tree and a much\n"
							.."larger tree to the north-east. Just\nyards from a sheer drop to a lake" },
	[44065987] = { dt = "E", tip = "On a rock with a shipwreck to the north.\nThe shipwreck has interior lights" },
	[45045349] = { dt = "E", tip = "On a broken beam inside a partial shipwreck,\nbeneath a huge overhanging rock" },   
	[45424537] = { dt = "E", tip = "On the south-west side of the tree" },
	[45541727] = { dt = "E", tip = "On the southern bank of a lake, at the\njunction where it drains into a river" },
	[46610845] = { dt = "E", tip = "South west side of a large tree,\nequidistant to a large rock" },
	[46585360] = { dt = "E", tip = "Atop three small flat rocks and\nringed by rocks on almost all sides" },
	[46661776] = { dt = "E", tip = "Centred on a gently sloping lower\nsection of a much steeper drop\n"
							.."down to a river to the north" },
	[46974903] = { dt = "E", tip = "South of a tree, surrounded by rocks.\nA top-most and small grassy area" },
	[47062586] = { dt = "E", tip = "Close to a tree to its south, with\na pulsing beacon to its north" },
	[47143318] = { dt = "E", tip = "On the grass above the south bank of\nthe river. Very safe area free of hostiles" },
	[47256193] = { dt = "E", tip = "Nestled in the grass on a rocking slope.\n30 yards due south of a Cave Skrog" },
	[48474812] = { dt = "E", tip = "Nestled within the foliage,\nsurrounded by rocks" }, 
	[48854561] = { dt = "E", tip = "On a rock at the water's edge" },  
	[49202424] = { dt = "E", tip = "About 15 yards south of a Spirit\nHealer, flanked by two large trees" },
	[49315053] = { dt = "E", tip = "Behind the sleeping giant,\nequidistant between two foating planks.\n"
							.."Possible to obtain without waking the giant" },
	[49275799] = { dt = "E", tip = "On the western side\nof the broken pillar" }, 
	[49333154] = { dt = "E", tip = "Two adjoining rocks lay to the north and north-\neast. Concealed by "
							.."adjacent bushes to the south" },
	[49452766] = { dt = "E", tip = "A mushroom adorned tree lays to the north-west.\nA tree with a four-way split "
							.."trunk is to the north-\neast. A massive tree is to the south. Well hidden!" },
	[49795394] = { dt = "E", tip = "Nestled in the bushes immediately\nwest of the waterfall's small lake" },
	[50083313] = { dt = "E", tip = "On a flat rise, abutting a cliff face (with\nsea-shell adornments) to the north-\n"
							.."west. A murloc platform is north-east" },
	[50511643] = { dt = "E", tip = "At the foot of a steep rocky rise to the\nsouth. Trees lay to the east and north" },
	[51316515] = { dt = "E", tip = "In between two large wooden\npylons. Visible from the south" },
	[51383759] = { dt = "E", tip = "At the bottom of El'dranil Shallows\nlake. Between a red/purple starfish\n"
							.."to the west, and a rocky rise" },
	[52007100] = { dt = "E", tip = "Frequently listed online.\nDon't bother checking here", author = true },		   
	[52163167] = { dt = "E", tip = "West of a small rock at the side of a river,\nwith a spirit healer 7 yards to the south" },
	[52282504] = { dt = "E", tip = "On the north side of a thin tree, and\nbutting a huge tree to the north-west" }, 
	[52411346] = { dt = "E", tip = "Midway between a tree to the south-west\nand a circular cairn to the north east" },
	[52675796] = { dt = "E", tip = "On the side of the hill. About\n60 yards north-west of a Cave\n"
							.."Skog and 60 yards north of a\nSpirit Healer" },   
	[52923596] = { dt = "E", tip = "In the El'dranil Shallows lake,\nunder large overhanging rocks" },
	[53906350] = { dt = "E", tip = "Frequently listed online as \"by\nthe torch\". Worth a run past", author = true },	  
	[54052762] = { dt = "E", tip = "Equidistant between a circular stone\nstructure to the south and the foot\n"
							.."of a sheer cliff rising to the north" },
	[54392592] = { dt = "E", tip = "Within the \"claw\" of large\ncreeping, exposed tree roots" },
	[54763380] = { dt = "E", tip = "In shallow water, near the shoreline.\nBasilisks roam the area" },
	[54832803] = { dt = "E", tip = "At the foot of a large tree to the east and\na few yards from a river to the west" },
	[55305581] = { dt = "E", tip = "Nestled in a grassy patch\nat the side of the cliff" },
	[55583274] = { dt = "E", tip = "At the foot of rocks rising to the north-\neast and a tree to the north-west" },
	[55611020] = { dt = "E", tip = "On a flatter, south-west sloping\nsection of a hill-side, north-west\nof the Ley-Ruins" },
	[55972932] = { dt = "E", tip = "Inside the pavillion of\nPridelord Meowl" },
	[56204050] = { dt = "E", tip = "Submerged, under the south-\nwestern edge of the bridge", author = true },
	[56491246] = { dt = "E", tip = "Several yards from a pink flower,\nbelow and slightly west of the \n"
							.."most intact part of the Ley-Ruins" },
	[56933891] = { dt = "E", tip = "On the rocks above the water line.\nClearly visible on approach" }, 
	[57093126] = { dt = "E", tip = "At the eastern end of a horizintal\nbroken masonry pillar" },
	[57411669] = { dt = "E", tip = "Near an edge overlooking the\nshallow Ley-Ruins chasm" },
	[58242449] = { dt = "E", tip = "At the base of the south side of a large\ntree, between a rock and a bush" },
	[59053748] = { dt = "E", tip = "East of a female night elf statue, just\nbeyond the paving masonry and flanked\n"
							.."by two tall, thin cylindrical trees. A dry\nwater feature and sit-down benches\n"
							.."are < 10 yards to the south-west" },
	[59383864] = { dt = "E", tip = "North-east side of a Naga tent,\njust before the grass gives way\n"
							.."to rocks rising to the north" },
	[59633793] = { dt = "E", tip = "Very close to the western side of a large\ntree, 10 yards from a drop-off to the west" },
	[60042779] = { dt = "E", tip = "At the foot of rocks with a\ngnarled tree to the south-west" },
	[60144890] = { dt = "E", tip = "Alongside the base of a small ledge with the\nland itself running down towards "
							.."the south.\nA tree is visible to the north-west " },
	[60155468] = { dt = "E", tip = "Westwards and just beyond the stone\nwork of a pavilion in the Garden of\n"
							.."Elune, under a lattice-like canopy" },
	[60193499] = { dt = "E", tip = "On the south-east edge of Lyndras'\ncircular pavilion, amongst fallen /\n"
							.."shattered debris" },
	[60374666] = { dt = "E", tip = "On the flat rock immediately to the\nleft (west) of the cave entrance" },
	[60911712] = { dt = "E", tip = "Eastern side of a tree,\nadjacent to a large rock" },
	[61713998] = { dt = "E", tip = "On the eastern side of a tree, further away\nto the south-west are the ruins of a "
							.."multi-\nlevel pavilion, a rocky rise is to the east" },
	[61913091] = { dt = "E", tip = "West of a tree, with another tree\nand some rocks nearby. A sheer\ndrop-off to the west" },
	[62205469] = { dt = "E", tip = "South-east side of the tree, nestled\nbetween the trunk and a large root" },
	[62283582] = { dt = "E", tip = "South-east of a large tree and south-\nwest of a much thinner tree, 28 yards\n"
							.."north-east of a Hatecoil Skrog" },
	[62314049] = { dt = "E", tip = "On the northern side of a tent,\nalongside a pillar to the north\n"
							.."and a small rock to the east" },
	[62665246] = { dt = "E", tip = "North side of a rock overgrown with the\nroots of a tree. West is a nearby stream" },
	[63534622] = { dt = "E", tip = "Western side of a large tree.\nSafely out of hostile NPC\n"
							.."range if you hug the cliff edge" },
	[64393322] = { dt = "E", tip = "On the northern side of a tent,\nwith a bent-over tree to the west" },
	[65472953] = { dt = "E", tip = "Inside the log. Enter\nfrom the north" },
	[65085081] = { dt = "E", tip = "Against the south-east side of the\ntree, between two shrubs. A small\n"
							.."ledge is to the east / south-east" },
	[65524252] = { dt = "E", tip = "South-east of a naga tent, just to the right\nside at the start of a path leading "
							.."up from\nthe shore. A star-shaped seashell is west" },
	[65583843] = { dt = "E", tip = "On the northern side of the central eastern north-\nsouth bridge. On a path leading "
							.."down to the\nriver banks on the western side of the bridge" },
	[67015194] = { dt = "E", tip = "Southern ledge of The Runied\nSanctum Pavilion, about\nmidway between two pillars" },
	[67134629] = { dt = "E", tip = "Set on bare ground, south-east and\nalongside a large broken tree branch,\n"
							.."with a small boulder to its north-west" },
	[67733281] = { dt = "E", tip = "Far south from the Felblaze spire, on a\ngrassy level area high above the water" },
	[68222405] = { dt = "E", tip = "North-east from the centre of the demon\ncamp, on the grassy rise before a steep\n"
							.."drop-off. Behind some rocks" },

-- dt = "CE" Cave Entrances. 
	[30122372] = { dt = "CE", name = "Grey Shoals", ecCount = "1", author = true },
	[34363606] = { dt = "CE", name = "Grey Shoals", tip = "Under a rocky ledge", ecCount = "1", author = true },
	[37913743] = { dt = "CE", name = "Nor'Danil Wellspring burrow", tip = "* Concealed Entrance *", ecCount = "?" },
	[38904534] = { dt = "CE", name = "Prison of the Demon Huntress", outlying = true, ecCount = "?" },
	[41593131] = { dt = "CE", name = "Lothien Grizzly cave", ecCount = "1", author = true },
	[41638604] = { dt = "CE", name = "Tunnel", tip = "West Entrance", outlying = true, ecCount = "?" },
	[44331728] = { dt = "CE", name = "Runas' Hovel", ecCount = "1" },
	[44957601] = { dt = "CE", name = "Fiend Lair", outlying = true, ecCount = "?" },
	[45128705] = { dt = "CE", name = "Tunnel", tip = "East Entrance", outlying = true, ecCount = "?" },
	[45505550] = { dt = "CE", name = "Oceanus Cove", tip = "West Entrance", ecCount = "3" },
	[47872508] = { dt = "CE", name = "Leyhollow", ecCount = "2" },
	[48495035] = { dt = "CE", name = "Oceanus Cove", tip = "North Entrance", ecCount = "3" },
	[48915974] = { dt = "CE", name = "Oceanus Cove", tip = "South Entrance", ecCount = "3" },
	[49234708] = { dt = "CE", name = "Ooker Dooker cave", ecCount = "?" },
	[49322615] = { dt = "CE", name = "Azurewing Repose", ecCount = "?" },
	[49658987] = { dt = "CE", name = "Salteye murloc cave", outlying = true, ecCount = "?" },
	[49738547] = { dt = "CE", name = "Malignant stalker cave", outlying = true, ecCount = "?" },
	[50104862] = { dt = "CE", name = "Shipwreck Arena cave", ecCount = "1" },
	[50220770] = { dt = "CE", name = "Lair of the Deposed", ecCount = "1" },
	[50665734] = { dt = "CE", name = "Jilted Former Lover", ecCount = "1" },
	[50735933] = { dt = "CE", name = "Oceanus Cove", tip = "South-East Entrance", ecCount = "3" },
	[50838386] = { dt = "CE", name = "Cliffdweller Fox lair", outlying = true, ecCount = "?" },
	[51087567] = { dt = "CE", name = "Cove Gull", outlying = true, ecCount = "?" },
	[51175302] = { dt = "CE", name = "El'dranil Peak", ecCount = "?" },
	[51883310] = { dt = "CE", name = "Gangamesh's Den", ecCount = "?" },
	[52387965] = { dt = "CE", name = "Withered J'im's cave", outlying = true, ecCount = "?" },
	[53312972] = { dt = "CE", name = "Llothien cave", ecCount = "1" },
	[53802238] = { dt = "CE", name = "Resting Dauorbjorn", ecCount = "?" },
	[53931794] = { dt = "CE", name = "Ley-Ruins of Zarkhenar", ecCount = "?" },
	[54605258] = { dt = "CE", name = "The Old Coast Path", ecCount = "1" },
	[55522313] = { dt = "CE", name = "Three-way tunnel", tip = "* Concealed Entrance *", ecCount = "?" },
	[55621994] = { dt = "CE", name = "Three-way tunnel", tip = "* Concealed Entrance *", ecCount = "?" },
	[55702549] = { dt = "CE", name = "Llothien river burrow", ecCount = "1" },
	[56046320] = { dt = "CE", name = "Temple of a Thousand Lights", outlying = true, ecCount = "?" },
	[57872161] = { dt = "CE", name = "Three-way tunnel", tip = "* Concealed Entrance *", ecCount = "?" },
	[58494160] = { dt = "CE", name = "Hatecoil Slave Pen", ecCount = "1" },
	[58587912] = { dt = "CE", name = "Dead Man's Bay 3", outlying = true, ecCount = "?" },
	[59216197] = { dt = "CE", name = "Mak'rana Elder", outlying = true, ecCount = "?" },
	[59636816] = { dt = "CE", name = "Dead Man's Bay 1", outlying = true, ecCount = "?" },
	[59805694] = { dt = "CE", name = "Mak'rana", ecCount = "?" },
	[59864384] = { dt = "CE", name = "Eksis' Lair", ecCount = "1" },
	[60544656] = { dt = "CE", name = "Olivian Veil", ecCount = "0" },
	[60813056] = { dt = "CE", name = "Kira Iresoul's cave", ecCount = "?" },
	[61297083] = { dt = "CE", name = "Dead Man's Bay 2", outlying = true, ecCount = "?" },
	[62956157] = { dt = "CE", name = "Cave of Queen Kraklaa", tip = "Submerged", outlying = true, ecCount = "?" },
	[64155289] = { dt = "CE", name = "Gloombound Barrow", ecCount = "1" },
	[69702951] = { dt = "CE", name = "Felblaze Ingress", tip = "Submerged", ecCount = "?" },
}

points[ns.oceanusCove] = {
	[45442989] = { dt = "O", tip = "Sitting on some gold which has spilt from a\n"
								.."chest. Not visible from the northern entrance" },
	[50767741] = { dt = "O", tip = "Inside a wrecked ship. Visible\nfrom all approaches" },
	[84148175] = { dt = "O", tip = "Between a rock wall and broken\nbeams on its western side and\n"
							.."water directly to the north" },
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
texturesSpecial[1] = "Interface\\Common\\RingBorder"
texturesSpecial[2] = "Interface\\PlayerFrame\\DeathKnight-Energize-Blood"
texturesSpecial[3] = "Interface\\PlayerFrame\\DeathKnight-Energize-Frost"
texturesSpecial[4] = "Interface\\PlayerFrame\\DeathKnight-Energize-Unholy"
texturesSpecial[5] = "Interface\\PetBattles\\DeadPetIcon"
texturesSpecial[6] = "Interface\\RaidFrame\\UI-RaidFrame-Threat"
texturesSpecial[7] = "Interface\\PlayerFrame\\UI-PlayerFrame-DeathKnight-Frost"
texturesSpecial[8] = "Interface\\HelpFrame\\HelpIcon-CharacterStuck"	

scaling[1] = 0.85
scaling[2] = 0.85
scaling[3] = 0.83
scaling[4] = 0.83
scaling[5] = 0.83
scaling[6] = 0.83
scaling[7] = 0.95
scaling[8] = 0.95
scaling[9] = 1.2
scaling[10] = 1.2
scalingSpecial[1] = 0.58
scalingSpecial[2] = 0.77
scalingSpecial[3] = 0.77
scalingSpecial[4] = 0.77
scalingSpecial[5] = 0.68
scalingSpecial[6] = 0.65
scalingSpecial[7] = 0.62
scalingSpecial[8] = 0.93
