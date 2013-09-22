
local _, LunarFestival = ...
LunarFestival.points = {}

local points = LunarFestival.points
-- points[<mapfile>] = { [<coordinates>] = { <quest ID>, <achievement ID>, <achievement criteria ID> } }


-- Eastern Kingdoms
points["BlackrockDepths"] = {
	[50506270] = { 8619, 910, 5 }, -- Elder Morndeep
}

points["BlackrockSpire"] = {
	[47646887] = { 8644, 910, 4 }, -- Elder Stonefort
}

points["BlastedLands"] = {
	[54304950] = { 8647, 912, 2 }, -- Elder Bellowrage
}

points["BurningSteppes"] = {
	[54202420] = { 8683, 912, 10 }, -- Elder Dawnstrider
	[69904480] = { 8636, 912, 9 }, -- Elder Rumblerock
}

points["DunMorogh"] = {
	[53904980] = { 8653, 912, 1 }, -- Elder Goldwell
}

points["EasternPlaguelands"] = {
	[35206810] = { 8688, 912, 15 }, -- Elder Windrun
	[75705450] = { 8650, 912, 16 }, -- Elder Snowcrown
}

points["Elwynn"] = {
	[34005000] = { 8646, 915, 3 }, -- Elder Hammershout
	[40006300] = { 8649, 912, 3 }, -- Elder Stormbrow
}

points["Hinterlands"] = {
	[50004800] = { 8643, 912, 11 }, -- Elder Highpeak
}

points["Ironforge"] = {
	[29001700] = { 8866, 915, 2 }, -- Elder Bronzebeard
}

points["LochModan"] = {
	[33414651] = { 8642, 912, 7 }, -- Elder Silvervein
}

points["SearingGorge"] = {
	[21007800] = { 8651, 912, 12 }, -- Elder Ironband
}

points["Silverpine"] = {
	[45004110] = { 8645, 912, 14 }, -- Elder Obsidian
}

points["StranglethornJungle"] = {
	[71003400] = { 8716, 912, 5 }, -- Elder Starglade
}

points["Stratholme"] = {
	[78302050] = { 8727, 910, 6 }, -- Elder Farwhisper
}

points["TheCapeOfStranglethorn"] = {
	[40007250] = { 8674, 912, 6 }, -- Elder Winterhoof
}

points["TheTempleOfAtalHakkar"] = {
	[62003400] = { 8713, 910, 2 }, -- Elder Starsong
}

points["Tirisfal"] = {
	[61005300] = { 8652, 912, 13 }, -- Elder Graveborn
}

points["Undercity"] = {
	[66003800] = { 8648, 914, 3 }, -- Elder Darkcore
}

points["WesternPlaguelands"] = {
	[69207340] = { 8714, 912, 17 }, -- Elder Moonstrike
	[63503610] = { 8722, 912, 4 }, -- Elder Meadowrun
}

points["Westfall"] = {
	[56604710] = { 8675, 912, 8 }, -- Elder Skychaser
}


-- Kalimdor
points["Ashenvale"] = {
	[35504890] = { 8725, 911, 9 }, -- Elder Riversong
}

points["Aszhara"] = {
	[64707930] = { 8720, 911, 2 }, -- Elder Skygleam
}

points["Barrens"] = {
	[48505920] = { 8717, 911, 3 }, -- Elder Moonwarden
	[68006900] = { 8680, 911, 5 }, -- Elder Windtotem
}

points["Darkshore"] = {
	[49501890] = { 8721, 911, 7 }, -- Elder Starweave
}

points["Darnassus"] = {
	[39203190] = { 8718, 915, 1 }, -- Elder Bladeswift
}

points["Durotar"] = {
	[53204360] = { 8670, 911, 1 }, -- Elder Runetotem
}

points["Feralas"] = {
	[62563100] = { 8685, 911, 11 }, -- Elder Mistwalker
	[76703790] = { 8679, 911, 10 }, -- Elder Grimtotem
}

points["Felwood"] = {
	[38305280] = { 8723, 911, 12 }, -- Elder Nightwind
}

points["Maraudon"] = {
	[52309220] = { 8635, 910, 3 }, -- Elder Splitrock
}

points["Mulgore"] = {
	[48305340] = { 8673, 911, 8 }, -- Elder Bloodhoof
}

points["Orgrimmar"] = {
	[53205980] = { 8677, 914, 1 }, -- Elder Darkhorn
}

points["Silithus"] = {
	[30001300] = { 8654, 911, 20 }, -- Elder Primestone
	[53003540] = { 8719, 911, 21 }, -- Elder Bladesing
}

points["SouthernBarrens"] = {
	[41504740] = { 8686, 911, 4 }, -- Elder Highmountain
}

points["Tanaris"] = {
	[37207900] = { 8671, 911, 15 }, -- Elder Ragetotem
	[51402880] = { 8684, 911, 16 }, -- Elder Dreamseer
}

points["Teldrassil"] = {
	[56805310] = { 8715, 911, 6 }, -- Elder Bladeleaf
}

points["ThousandNeedles"] = {
	[46305100] = { 8682, 911, 13 }, -- Elder Skyseer
	[77007560] = { 8724, 911, 14 }, -- Elder Morningdew
}

points["ThunderBluff"] = {
	[72662348] = { 8678, 914, 2 }, -- Elder Wheathoof
}

points["UngoroCrater"] = {
	[50307610] = { 8681, 911, 17 }, -- Elder Thunderhorn
}

points["Winterspring"] = {
	[53205670] = { 8726, 911, 18 }, -- Elder Brightspear
	[59904990] = { 8672, 911, 19 }, -- Elder Stonespire
}

points["ZulFarrak"] = {
	[41804460] = { 8676, 910, 1 }, -- Elder Wildmane
}


-- Outland


-- Northrend
points["AzjolNerub"] = {
	[22004340] = { 13022, 910, 9 }, -- Elder Nurgen
}

points["BoreanTundra"] = {
	[33813437] = { 13016, 1396, 6 }, -- Elder Northal
	[42934958] = { 13029, 1396, 15 }, -- Elder Pamuya
	[57394373] = { 13033, 1396, 5 }, -- Elder Arp
	[59106560] = { 13012, 1396, 1 }, -- Elder Sardis
}

points["Dragonblight"] = {
	[29905610] = { 13014, 1396, 3 }, -- Elder Morthie
	[35104835] = { 13031, 1396, 17 }, -- Elder Skywarden
	[48767818] = { 13019, 1396, 12 }, -- Elder Thoim
}

points["DrakTharonKeep"] = {
	[68608090] = { 13023, 910, 10 }, -- Elder Kilias
}

points["GrizzlyHills"] = {
	[60532764] = { 13013, 1396, 2 }, -- Elder Beldak
	[64164700] = { 13030, 1396, 16 }, -- Elder Whurain
	[80523712] = { 13025, 1396, 9 }, -- Elder Lunaro
}

points["Gundrak"] = {
	[46806190] = { 13065, 910, 11 }, -- Elder Ohanzee
}

points["LakeWintergrasp"] = {
	[49001390] = { 13026, 1396, 10 }, -- Elder Bluewolf
}

points["SholazarBasin"] = {
	[49786363] = { 13018, 1396, 7 }, -- Elder Sandrene
	[63804902] = { 13024, 1396, 8 }, -- Elder Wanikaya
}

points["TheNexus"] = {
	[55106460] = { 13021, 910, 8 }, -- Elder Igasho
}

points["TheStormPeaks"] = {
	[28897371] = { 13015, 1396, 4 }, -- Elder Fargal
	[31103740] = { 13020, 1396, 14 }, -- Elder Stonebeard
	[41008400] = { 13028, 1396, 13 }, -- Elder Graymane
	[64595134] = { 13032, 1396, 18 }, -- Elder Muraco
}

points["Ulduar77"] = { -- Halls of Stone
	[29106090] = { 13066, 910, 12 }, -- Elder Yurauk
}

points["UtgardeKeep"] = {
	[47507080] = { 13017, 910, 7 }, -- Elder Jarten
}

points["UtgardePinnacle"] = {
	[48102310] = { 13067, 910, 13 }, -- Elder Chogan'gada
}

points["ZulDrak"] = {
	[58915597] = { 13027, 1396, 11 }, -- Elder Tauros
}


-- Cataclysm
points["Deepholm"] = {
	[27706920] = { 29734, 6006, 9 }, -- Elder Deepforge
	[49705490] = { 29735, 6006, 1 }, -- Elder Stonebrand
}

points["Hyjal"] = {
	[26706200] = { 29739, 6006, 6 }, -- Elder Windsong
	[62502280] = { 29740, 6006, 7 }, -- Elder Evershade
}

points["TwilightHighlands"] = {
	[50907050] = { 29737, 6006, 4 }, -- Elder Firebeard
	[51903310] = { 29736, 6006, 5 }, -- Elder Darkfeather
}

points["Uldum"] = {
	[32606300] = { 29741, 6006, 3 }, -- Elder Sekhemi
	[65501870] = { 29742, 6006, 2 }, -- Elder Menkhaf
}

points["VashjirRuins"] = {
	[57308620] = { 29738, 6006, 8 }, -- Elder Moonlance
}


-- Pandaria
