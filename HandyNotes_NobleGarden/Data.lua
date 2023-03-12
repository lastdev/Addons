local _, ns = ...
local points = ns.points
local textures = ns.textures
local scaling = ns.scaling

points[ 78 ] = { -- UnGoro Crater Retail
	[53006300] = { 2416, 0, "Hard Boiled", "hb1", "Marshall's Stand" },
	[35005400] = { 2416, 0, "Hard Boiled", "hb2", "Golakka Hot Springs" },
}
points[ 1449 ] = { -- UnGoro Crater Wrath
	[30604880] = { 2416, 0, "Hard Boiled", "hb2", "Golakka Hot Springs" },
}
points[ 71 ] = { -- Tanaris Retail
	[48002680] = { 2436, 4, "Desert Rose", "AnywhereZ", ns.tanaris },
}
points[ 1446 ] = { -- Tanaris Wrath
	[48002680] = { 2436, 3, "Desert Rose", "AnywhereZ", ns.tanaris },
}
points[ 81 ] = { -- Silithus Retail
	[73003100] = { 2436, 3, "Desert Rose", "AnywhereZ", ns.silithus },
}
points[ 1451 ] = { -- Silithus Wrath
	[55003800] = { 2416, 0, "Hard Boiled", "hb3", "Cenarion Hold" },
	[73003300] = { 2436, 1, "Desert Rose", "AnywhereZ", ns.silithus },
}
points[ 15 ] = { -- Badlands Retail
	[53504700] = { 2436, 1, "Desert Rose", "AnywhereZ", ns.badlands },
}
points[ 1418 ] = { -- Badlands Wrath
	[53504700] = { 2436, 2, "Desert Rose", "AnywhereZ", ns.badlands },
}
points[ 64 ] = { -- Thousand Needles Retail
	[75007600] = { 2436, 5, "Desert Rose", "AnywhereZ", ns.thousandNeedles },
}
points[ 1441 ] = { -- Thousand Needles Wrath
	[75007600] = { 2436, 5, "Desert Rose", "AnywhereZ", ns.thousandNeedles },
}
points[ 66 ] = { -- Desolace Retail
	[60005200] = { 2436, 2, "Desert Rose", "AnywhereZ", ns.desolace },
}
points[ 1443 ] = { -- Desolace Wrath
	[60005200] = { 2436, 4, "Desert Rose", "AnywhereZ", ns.desolace },
}
points[ 97 ] = { -- Azure Watch in Azuremyst Isle Retail
	[51005100] = { 2419, 1, "Spring Fling (Alliance)", "AnywhereC", "Azure Watch" },
}
points[ 1943 ] = { -- Azure Watch in Azuremyst Isle Wrath
	[51005100] = { 2419, 1, "Spring Fling (Alliance)", "AnywhereC", "Azure Watch" },
}
points[ 37 ] = { -- Goldshire in Elwynn Forest Retail
	[40206450] = { 2419, 3, "Spring Fling (Alliance)", "AnywhereT", "Goldshire" },
	[26905000] = { 2421, 0, "Noble Garden (Alliance)", "hide" },
}
points[ 1429 ] = { -- Goldshire in Elwynn Forest Wrath
	[40206450] = { 2419, 3, "Spring Fling (Alliance)", "AnywhereT", "Goldshire" },
	[26263636] = { 2421, 0, "Noble Garden (Alliance)", "hide" },
}
points[ 57 ] = { -- Dolanaar in Teldrassil Retail
	[54005350] = { 2419, 2, "Spring Fling (Alliance)", "AnywhereT", "Dolanaar" },
}
points[ 1438 ] = { -- Dolanaar in Teldrassil Wrath
	[57005700] = { 2419, 4, "Spring Fling (Alliance)", "AnywhereT", "Dolanaar" },
}
points[ 12 ] = { -- Dolanaar in Teldrassil -> Kalimdor Retail
	[44001050] = { 2419, 2, "Spring Fling (Alliance)", "AnywhereT", "Dolanaar" },
}
points[ 27 ] = { -- Kharanos in Dun Morogh Retail
	[53215213] = { 2419, 4, "Spring Fling (Alliance)", "AnywhereT", "Kharanos" },
}
points[ 1426 ] = { -- Kharanos in Dun Morogh Wrath
	[46005300] = { 2419, 2, "Spring Fling (Alliance)", "AnywhereT", "Kharanos" },
}
points[ 7 ] = { -- Bloodhoof Village in Mulgore Retail
	[45505800] = { 2497, 1, "Spring Fling (Horde)", "AnywhereC", "Bloodhoof Village" },
}
points[ 1412 ] = { -- Bloodhoof Village in Mulgore Wrath
	[45505800] = { 2497, 4, "Spring Fling (Horde)", "AnywhereC", "Bloodhoof Village" },
}
points[ 94 ] = { -- Falconwing Square in Eversong Woods Retail
	[47144596] = { 2497, 3, "Spring Fling (Horde)", "AnywhereS", "Falconwing Square" },
	[58003900] = { 2420, 0, "Noble Garden (Horde)", "hide" },
}
points[ 1941 ] = { -- Falconwing Square in Eversong Woods Wrath
	[47144596] = { 2497, 2, "Spring Fling (Horde)", "AnywhereS", "Falconwing Square" },
	[58003900] = { 2420, 0, "Noble Garden (Horde)", "hide" },
}
points[ 18 ] = { -- Brill in Tirisfal Glades Retail
	[60815152] = { 2497, 2, "Spring Fling (Horde)", "AnywhereT", "Brill" },
}
points[ 1420 ] = { -- Brill in Tirisfal Glades Wrath
	[60815152] = { 2497, 3, "Spring Fling (Horde)", "AnywhereT", "Brill" },
}
points[ 1 ] = { -- Razor Hill in Durotar Retail
	[55504250] = { 2497, 4, "Spring Fling (Horde)", "AnywhereE", "Razor Hill" },
}
points[ 1411 ] = { -- Razor Hill in Durotar Wrath
	[55504250] = { 2497, 1, "Spring Fling (Horde)", "AnywhereE", "Razor Hill" },
}
points[ ns.stormwindCity ] = {
	[55505600] = { 2421, 0, "Noble Garden (Alliance)", "hide" },
}
points[ ns.silvermoonCity ] = {
	[66002780] = { 2420, 0, "Noble Garden (Horde)", "hide" },
}
points[ 1414 ] = { --Kalimdor Wrath Special case
	[44001050] = { 2419, 4, "Spring Fling (Alliance)", "AnywhereT", "Dolanaar" },
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
textures[11] = "Interface\\AddOns\\HandyNotes_NobleGarden\\NobleA"
textures[12] = "Interface\\AddOns\\HandyNotes_NobleGarden\\NobleG"
textures[13] = "Interface\\AddOns\\HandyNotes_NobleGarden\\NobleP"
textures[14] = "Interface\\AddOns\\HandyNotes_NobleGarden\\NobleH"

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
scaling[11] = 0.75
scaling[12] = 0.75
scaling[13] = 0.75
scaling[14] = 0.75
