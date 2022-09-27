local _, ns = ...
local points = ns.points
local texturesL = ns.texturesL
local scalingL = ns.scalingL
local texturesS = ns.texturesS
local scalingS = ns.scalingS

points[78] = { -- UnGoro Crater
	[53006300] = { 2416, 0, "Hard Boiled", "hb1", "Marshall's Stand" },
	[35005400] = { 2416, 0, "Hard Boiled", "hb2", "Golakka Hot Springs" },
}
points[1449] = {
	[30604880] = { 2416, 0, "Hard Boiled", "hb2", "Golakka Hot Springs" },
}
points[ns.tanaris] = {
	[48002680] = { 2436, 4, "Desert Rose", "AnywhereZ", ns.tanaris },
}
points[81] = { -- Silithus
	[73003100] = { 2436, 3, "Desert Rose", "AnywhereZ", ns.silithus },
}
points[1451] = {
	[55003800] = { 2416, 0, "Hard Boiled", "hb3", "Cenarion Hold" },
	[73003300] = { 2436, 3, "Desert Rose", "AnywhereZ", ns.silithus },
}
points[ns.badlands] = {
	[53504700] = { 2436, 1, "Desert Rose", "AnywhereZ", ns.badlands },
}
points[ns.thousandNeedles] = {
	[75007600] = { 2436, 5, "Desert Rose", "AnywhereZ", ns.thousandNeedles },
}
points[ns.desolace] = {
	[60005200] = { 2436, 2, "Desert Rose", "AnywhereZ", ns.desolace },
}
points[ns.azuremystIsle] = {
	[51005100] = { 2419, 1, "Spring Fling (Alliance)", "AnywhereC", "Azure Watch" },
}
points[37] = { -- Elwynn Forest
	[40206450] = { 2419, 3, "Spring Fling (Alliance)", "AnywhereT", "Goldshire" },
	[26905000] = { 2421, 0, "Noble Garden (Alliance)", "hide" },
}
points[1429] = {
	[40206450] = { 2419, 3, "Spring Fling (Alliance)", "AnywhereT", "Goldshire" },
	[26263636] = { 2421, 0, "Noble Garden (Alliance)", "hide" },
}
points[57] = { -- Teldrassil
	[54005350] = { 2419, 2, "Spring Fling (Alliance)", "AnywhereT", "Dolanaar" },
}
points[1438] = {
	[57005700] = { 2419, 2, "Spring Fling (Alliance)", "AnywhereT", "Dolanaar" },
}
points[ns.kalimdor] = {
	[44001050] = { 2419, 2, "Spring Fling (Alliance)", "AnywhereT", "Dolanaar" },
}
points[27] = { -- Kharanos in Dun Morogh
	[53215213] = { 2419, 4, "Spring Fling (Alliance)", "AnywhereT", "Kharanos" },
}
points[1426] = {
	[46005300] = { 2419, 4, "Spring Fling (Alliance)", "AnywhereT", "Kharanos" },
}
points[ns.mulgore] = {
	[45505800] = { 2497, 1, "Spring Fling (Horde)", "AnywhereC", "Bloodhoof Village" },
}
points[ns.eversongWoods] = {
	[47144596] = { 2497, 3, "Spring Fling (Horde)", "AnywhereS", "Falconwing Square" },
	[58003900] = { 2420, 0, "Noble Garden (Horde)", "hide" },
}
points[ns.tirisfalGlades] = {
	[60815152] = { 2497, 2, "Spring Fling (Horde)", "AnywhereT", "Brill" },
}
points[ns.durotar] = {
	[55504250] = { 2497, 4, "Spring Fling (Horde)", "AnywhereE", "Razor Hill" },
}
points[ns.stormwindCity] = {
	[55505600] = { 2421, 0, "Noble Garden (Alliance)", "hide" },
}
points[ns.silvermoonCity] = {
	[66002780] = { 2420, 0, "Noble Garden (Horde)", "hide" },
}
	
-- Choice of texture
-- Note that these textures are all repurposed and as such have non-uniform sizing. I've copied my scaling factors from my old AddOn
-- in order to homogenise the sizes. I should also allow for non-uniform origin placement as well as adjust the x,y offsets
texturesL[1] = "Interface\\PlayerFrame\\MonkLightPower"
texturesL[2] = "Interface\\PlayerFrame\\MonkDarkPower"
texturesL[3] = "Interface\\Common\\Indicator-Red"
texturesL[4] = "Interface\\Common\\Indicator-Yellow"
texturesL[5] = "Interface\\Common\\Indicator-Green"
texturesL[6] = "Interface\\Common\\Indicator-Gray"
texturesL[7] = "Interface\\Common\\Friendship-ManaOrb"	
texturesL[8] = "Interface\\TargetingFrame\\UI-PhasingIcon"
texturesL[9] = "Interface\\Store\\Category-icon-pets"
texturesL[10] = "Interface\\Store\\Category-icon-featured"
texturesL[11] = "Interface\\AddOns\\HandyNotes_NobleGarden\\NobleA"
texturesL[12] = "Interface\\AddOns\\HandyNotes_NobleGarden\\NobleP"
texturesS[1] = "Interface\\Common\\RingBorder"
texturesS[2] = "Interface\\PlayerFrame\\DeathKnight-Energize-Blood"
texturesS[3] = "Interface\\PlayerFrame\\DeathKnight-Energize-Frost"
texturesS[4] = "Interface\\PlayerFrame\\DeathKnight-Energize-Unholy"
texturesS[5] = "Interface\\PetBattles\\DeadPetIcon"
texturesS[6] = "Interface\\RaidFrame\\UI-RaidFrame-Threat"
texturesS[7] = "Interface\\PlayerFrame\\UI-PlayerFrame-DeathKnight-Frost"
texturesS[8] = "Interface\\HelpFrame\\HelpIcon-CharacterStuck"	
texturesS[9] = "Interface\\AddOns\\HandyNotes_NobleGarden\\NobleH"
texturesS[10] = "Interface\\AddOns\\HandyNotes_NobleGarden\\NobleG"

scalingL[1] = 0.85
scalingL[2] = 0.85
scalingL[3] = 0.83
scalingL[4] = 0.83
scalingL[5] = 0.83
scalingL[6] = 0.83
scalingL[7] = 0.95
scalingL[8] = 0.95
scalingL[9] = 1.2
scalingL[10] = 1.2
scalingL[11] = 0.75
scalingL[12] = 0.75
scalingS[1] = 0.58
scalingS[2] = 0.77
scalingS[3] = 0.77
scalingS[4] = 0.77
scalingS[5] = 0.68
scalingS[6] = 0.65
scalingS[7] = 0.62
scalingS[8] = 0.93
scalingS[9] = 0.75
scalingS[10] = 0.75

