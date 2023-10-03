local _, ns = ...
local points = ns.points
local textures = ns.textures
local scaling = ns.scaling

-- The EggID was used in my original AddOn to provide am item link in chat

points[ns.dalaran] = {	-- Dalaran
	[58853896] = { "Breanni", "Obsidian Hatchling", 48118 },
}

points[ns.dustwallowMarsh] = {	-- Dustwallow Marsh
	[46511716] = { "Dart's Nest", "Darting Hatchling", 48118 },
	[47981907] = { "Dart's Nest", "Darting Hatchling", 48118 },
	[48011426] = { "Dart's Nest", "Darting Hatchling", 48118 },
	[49171736] = { "Dart's Nest", "Darting Hatchling", 48118 },
}

points[ns.northernBarrens] = {	-- Northern Barrens / Barrens (WotLK Classic)
	[60951976] = { "Takk's Nest", "Leaping Hatchling", 48112, "R" },
	[62762018] = { "Takk's Nest", "Leaping Hatchling", 48112, "R" },
	[64172300] = { "Takk's Nest", "Leaping Hatchling", 48112, "R" },
	[64942860] = { "Takk's Nest", "Leaping Hatchling", 48112, "R" },
	[58450828] = { "Takk's Nest", "Leaping Hatchling", 48112, "W" }, 
	[59470851] = { "Takk's Nest", "Leaping Hatchling", 48112, "W" },
	[60281011] = { "Takk's Nest", "Leaping Hatchling", 48112, "W" },
	[60711330] = { "Takk's Nest", "Leaping Hatchling", 48112, "W" },
	[38966932] = { "Deviate Guardians & Ravagers", "Deviate Hatchling", 48114, "R",
					"Wailing Caverns dungeon.\n1 in 500 chance" },
	[46003645] = { "Deviate Guardians & Ravagers", "Deviate Hatchling", 48114, "W",
					"Wailing Caverns dungeon.\n1 in 3500 chance" },
}

points[ns.unGoroCrater] = {	-- Un'Goro Crater
	[62067336] = { "Ravasaur Matriarch's Nest", "Ravasaur Hatchling", 48122, "Under the foliage" }, -- Classic matches
	[62096523] = { "Ravasaur Matriarch's Nest", "Ravasaur Hatchling", 48122 },
	[62976308] = { "Ravasaur Matriarch's Nest", "Ravasaur Hatchling", 48122, "Under the foliage" }, -- Classic matches
	[68836679] = { "Ravasaur Matriarch's Nest", "Ravasaur Hatchling", 48122, "Under the foliage" },
	[68956106] = { "Ravasaur Matriarch's Nest", "Ravasaur Hatchling", 48122, "Under the foliage" }, -- Classic matches
}

points[ 11 ] = { -- Wailing Caverns
	[53607050] = { "Deviate Guardians & Ravagers", "Deviate Hatchling", 48114, "R",
					"Wailing Caverns dungeon.\n1 in 500 chance" },
}
points[ 279 ] = { -- Wailing Caverns
	[37704020] = { "Deviate Guardians & Ravagers", "Deviate Hatchling", 48114, "R",
					"1 in 500 chance to drop from a\nDeviate Guardian or Ravager" },
}

-- A code hack will differentiate between the two. The first is for general use, the others are for inside the cave
points[ns.wetlands] = {	-- Wetlands
	[69373491] = { "Cave Entrance", "Raptor Ridge", 48124, "Razormaw Matriarch's Nest" },
	[70032916] = { "Razormaw Matriarch's Nest", "Razormaw Hatchling", 48124, "R", "Veer to the right" },
	[70082914] = { "Razormaw Matriarch's Nest", "Razormaw Hatchling", 48124, "W", "Veer to the right" },
	[71103096] = { "Razormaw Matriarch's Nest", "Razormaw Hatchling", 48124, "W", "Between two rocks" },
	[67633063] = { "Razormaw Matriarch's Nest", "Razormaw Hatchling", 48124, "W" },
	[69073142] = { "Razormaw Matriarch's Nest", "Razormaw Hatchling", 48124, "W" }, -- Best estimate
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
