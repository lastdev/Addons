local _, ns = ...
local points = ns.points
local textures = ns.textures
local scaling = ns.scaling

points[ 249 ] = {
	[22096406] = { camel=true, author=true, tip="Trisected by a tent pole, three\nsand bags, and the neck yoke\nof a large wagon" },
	[24445996] = { camel=true, tip="In the very centre of a cart" },
	[25405107] = { camel=true, author=true, tip="On the cart, at its open end" },
	[25596589] = { camel=true, tip="Nestled between two kegs\nand some nearby sand bags" },
	[26276508] = { camel=true, tip="On top of the two stacked crates" },
	[28516374] = { camel=true, author=true, tip="In the last nook\nbefore the stairs" },
	[29842044] = { camel=true, tip="Between the tallest tree\nand a large rock. Not at\nall concealed by bushes" },
	[29902490] = { camel=true, author=true, tip="In the pale green shrubbery,\nclose to the water's edge" },
	[30426267] = { camel=true, author=true, tip="Careful. It's in this\nnook. Easily missed" },
	[30616050] = { camel=true, author=true, tip="Near a corner of the column" },
	[30986752] = { camel=true, author=true, tip="Below, in the nook" },
	[30996637] = { camel=true, author=true, tip="At the top of the stairs" },
	[31506926] = { camel=true, author=true, tip="At the top of the stairs,\nclose to a short stone\ncolumn to its north" },
	[31954529] = { camel=true, tip="Inside the six large bones" },
	[32734762] = { camel=true, tip="Just to the right of\nthe crypt doorway" },
	[33086013] = { camel=true, author=true, tip="On the wall, close\nto a corner column" },
	[33197204] = { camel=true, tip="Near a corner. Can see from afar" },
	[33206283] = { camel=true, author=true, tip="On the left side of the entrance.\nAn equally small purple cat\nfigurine is across from it" },
	[33276778] = { camel=true, author=true, tip="In a nook, with the stairs\nto its west side and a wall\nto its north side" },
	[33682538] = { camel=true, tip="Outside the tent. Easy to see.\nIn front of a crate and guy rope" },
	[34321963] = { camel=true, tip="Approximately between an upturned\ntable and a toppled bird carving" },
	[34382128] = { camel=true, tip="Under the tent, triscted by the\npole, the skin and the rug" },
	[37136408] = { camel=true, author=true, tip="On the sand at the corner\nof the stone column" },
	[38286070] = { camel=true, author=true, tip="Adjacent to a tall column,\non the right of the entrance\nway (as you look at it)" },
	[38495493] = { camel=true, author=true, tip="concealed slightly by two\nsand mounds and a bank\non its eastern side" },
	[39964500] = { camel=true, tip="In the corner. Outside.\nDon't go inside" },
	[40104340] = { camel=true, author=true, tip="Under the collapsed awning,\nbisected by two pieces of wood" },
	[40163841] = { camel=true, author=true, tip="In a nook with the stone wall\nstructure to its north and east" }, 
	[40834975] = { camel=true, tip="On the tip of the rock.\nVisible in a quick fly-past" },
	[45241603] = { camel=true, tip="In a corner" },
	[46254458] = { camel=true, author=true, tip="Palms flank its northern side whilst\na large green plant is to its west" }, 
	[47287669] = { camel=true, author=true, tip="To one side of a stone slab bench" },
	[48174640] = { camel=true, author=true, tip="Amongst the greenery, palms of\nvarious sizes are to its northern side" },
	[49147592] = { camel=true, tip="To one side of the stairs, halfway\nbetween a palm and a brazier" },
	[50247366] = { camel=true, tip="Between the camel's\nrear legs and the table leg" },
	[50437223] = { camel=true, tip="Alongside a bench and\nwell clear of three bags" },	
	[50483149] = { camel=true, tip="Between two palm trees, clear\nof foliage. On the northern side" },
	[50485065] = { camel=true, author=true,
					tip="On the left side of the doorway,\nnear a loose stone and green\nweeds. There is greenery overhead" },
	[51025078] = { camel=true, author=true, tip="On the ground exactly at the foot\nof the purple/gold cat statue" },
	[51147979] = { camel=true, author=true,
					tip="On the ground, trisected by three stone tiles,\na square wooden table and a human pulled cart" },
	[51475116] = { camel=true, author=true, tip="Above the building, on\nthe roof in a corner" },
	[51794934] = { camel=true, tip="In the grass, trisected by a large\npalm, a shorter one and a leafy shrub" },
	[51927081] = { camel=true, author=true, tip="On the ground at the back of a\nwagon. A camel is concealing it" },
	[52145121] = { camel=true, author=true, tip="In a nook between the\nbench and the doorway" },
	[52232804] = { camel=true, author=true, tip="Out in the open. Ideal\nfor a quick fly past" },
	[64663027] = { camel=true, author=true, tip="At the base of a small sand\nmound in a corner at the base\nof a very tall column" },
	[69875813] = { camel=true, tip="Alongside a fallen and partially\ncovered stone plinth. Easy to see" },
	[72024388] = { camel=true, author=true, tip="In this nook" },
	[73447361] = { camel=true, author=true,
					tip="Inside the altar structure. At the\nbase and to one side of a purple\nbird statue. Two baskets are nearby" },
}
points[ 1527 ] = {
	[26002700] = { testUldum=true },	
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

scaling[1] = 0.55
scaling[2] = 0.55
scaling[3] = 0.55
scaling[4] = 0.55
scaling[5] = 0.55
scaling[6] = 0.55
scaling[7] = 0.65
scaling[8] = 0.63
scaling[9] = 0.75
scaling[10] = 0.75
scaling[11] = 0.38
scaling[12] = 0.5
scaling[13] = 0.5
scaling[14] = 0.5
scaling[15] = 0.46
scaling[16] = 0.45
scaling[17] = 0.41
scaling[18] = 0.6
scaling[19] = 0.43