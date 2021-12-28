local AL = LibStub:GetLibrary("AchievementLocations-1.0")
local function A(row) AL:AddLocation(row) end

-- World Events/Midsummer: Flame Warden of Eastern Kingdoms
A{"Arathi", 1022, 0.4440, 0.4590, criterion=3063, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Arathi Highlands", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="ArathiHighlands", uiMapID=14, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Eastern Kingdoms
A{"Arathi", 1025, 0.6900, 0.4200, criterion=3101, side="horde", season="Midsummer Fire Festival", trivia={criteria="Arathi Highlands", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="ArathiHighlands", uiMapID=14, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"Arathi", 1028, 0.6920, 0.4310, criterion=3131, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Arathi Highlands", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Horde's bonfires in Eastern Kingdoms.", mapID="ArathiHighlands", uiMapID=14, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"Arathi", 1031, 0.6930, 0.4260, criterion=3161, note="also Refuge Point", side="horde", season="Midsummer Fire Festival", trivia={criteria="Arathi Highlands", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Alliance's bonfires in Eastern Kingdoms.", mapID="ArathiHighlands", uiMapID=14, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Kalimdor
A{"Ashenvale", 1023, 0.8700, 0.4200, criterion=3076, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Ashenvale", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Kalimdor", description="Honor the flames of Kalimdor.", mapID="Ashenvale", uiMapID=63, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Kalimdor
A{"Ashenvale", 1026, 0.5100, 0.6600, criterion=3112, side="horde", season="Midsummer Fire Festival", trivia={criteria="Ashenvale", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Kalimdor", description="Honor the flames of Kalimdor.", mapID="Ashenvale", uiMapID=63, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Kalimdor
A{"Ashenvale", 1029, 0.5170, 0.6660, criterion=3142, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Ashenvale", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Kalimdor", description="Desecrate the Horde's bonfires in Kalimdor.", mapID="Ashenvale", uiMapID=63, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Kalimdor
A{"Ashenvale", 1032, 0.8670, 0.4150, criterion=3174, side="horde", season="Midsummer Fire Festival", trivia={criteria="Ashenvale", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Kalimdor", description="Desecrate the Alliance's bonfires in Kalimdor.", mapID="Ashenvale", uiMapID=63, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Kalimdor
A{"Aszhara", 1026, 0.6000, 0.5300, criterion=23471, side="horde", season="Midsummer Fire Festival", trivia={criteria="Azshara", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Kalimdor", description="Honor the flames of Kalimdor.", mapID="Aszhara", points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Kalimdor
A{"Aszhara", 1029, 0.6040, 0.5350, criterion=23476, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Azshara", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Kalimdor", description="Desecrate the Horde's bonfires in Kalimdor.", mapID="Aszhara", points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: The Fires of Azeroth
A{"Azeroth", 1034, criterion=3193, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Flame Warden of Eastern Kingdoms", module="seasonal_mid", category="World Events/Midsummer", name="The Fires of Azeroth", description="Complete the Flame Warden achievements.", points=10, parent="World Events", type="achievement"}}

-- World Events/Midsummer: Desecration of the Horde
A{"Azeroth", 1035, criterion=3196, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Extinguishing Eastern Kingdoms", module="seasonal_mid", category="World Events/Midsummer", name="Desecration of the Horde", description="Complete all Extinguishing achievements.", points=10, parent="World Events", type="achievement"}}

-- World Events/Midsummer: The Fires of Azeroth
A{"Azeroth", 1036, criterion=3199, side="horde", season="Midsummer Fire Festival", trivia={criteria="Flame Keeper of Eastern Kingdoms", module="seasonal_mid", category="World Events/Midsummer", name="The Fires of Azeroth", description="Complete the Flame Keeper achievements.", points=10, parent="World Events", type="achievement"}}

-- World Events/Midsummer: Desecration of the Alliance
A{"Azeroth", 1037, criterion=3202, side="horde", season="Midsummer Fire Festival", trivia={criteria="Extinguishing Eastern Kingdoms", module="seasonal_mid", category="World Events/Midsummer", name="Desecration of the Alliance", description="Complete all Extinguishing achievements.", points=10, parent="World Events", type="achievement"}}

-- World Events/Midsummer: Flame Warden of Kalimdor
A{"AzuremystIsle", 1023, 0.4400, 0.5200, criterion=3077, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Azuremyst Isle", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Kalimdor", description="Honor the flames of Kalimdor.", mapID="AzuremystIsle", uiMapID=97, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Kalimdor
A{"AzuremystIsle", 1032, 0.4470, 0.5250, criterion=3175, side="horde", season="Midsummer Fire Festival", trivia={criteria="Azuremyst Isle", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Kalimdor", description="Desecrate the Alliance's bonfires in Kalimdor.", mapID="AzuremystIsle", uiMapID=97, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Eastern Kingdoms
A{"Badlands", 1022, 0.1890, 0.5630, criterion=23509, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Badlands", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="Badlands", uiMapID=15, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Eastern Kingdoms
A{"Badlands", 1025, 0.1900, 0.5600, criterion=3102, side="horde", season="Midsummer Fire Festival", trivia={criteria="Badlands", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="Badlands", uiMapID=15, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"Badlands", 1028, 0.2410, 0.3730, criterion=3132, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Badlands", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Horde's bonfires in Eastern Kingdoms.", mapID="Badlands", uiMapID=15, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"Badlands", 1031, 0.2350, 0.3730, criterion=23512, note="also Dragon's Mouth", side="horde", season="Midsummer Fire Festival", trivia={criteria="Badlands", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Alliance's bonfires in Eastern Kingdoms.", mapID="Badlands", uiMapID=15, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Kalimdor
A{"Barrens", 1026, 0.5000, 0.5500, criterion=3121, side="horde", season="Midsummer Fire Festival", trivia={criteria="Northern Barrens", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Kalimdor", description="Honor the flames of Kalimdor.", mapID="NorthernBarrens", uiMapID=10, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Kalimdor
A{"Barrens", 1029, 0.4980, 0.5420, criterion=3151, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Northern Barrens", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Kalimdor", description="Desecrate the Horde's bonfires in Kalimdor.", mapID="NorthernBarrens", uiMapID=10, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Outland
A{"BladesEdgeMountains", 1024, 0.4200, 0.6600, criterion=3089, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Blade's Edge Mountains", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Outland", description="Honor the flames of Outland.", mapID="BladesEdgeMountains", uiMapID=105, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Outland
A{"BladesEdgeMountains", 1027, 0.5000, 0.5900, criterion=3124, side="horde", season="Midsummer Fire Festival", trivia={criteria="Blade's Edge Mountains", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Outland", description="Honor the flames of Outland.", mapID="BladesEdgeMountains", uiMapID=105, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Outland
A{"BladesEdgeMountains", 1030, 0.4990, 0.5900, criterion=3154, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Blade's Edge Mountains", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Outland", description="Desecrate the Horde's bonfires in Outland.", mapID="BladesEdgeMountains", uiMapID=105, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Outland
A{"BladesEdgeMountains", 1033, 0.4180, 0.6590, criterion=3186, side="horde", season="Midsummer Fire Festival", trivia={criteria="Blade's Edge Mountains", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Outland", description="Desecrate the Alliance's bonfires in Outland.", mapID="BladesEdgeMountains", uiMapID=105, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Eastern Kingdoms
A{"BlastedLands", 1022, 0.5560, 0.1500, criterion=3064, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Blasted Lands", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="BlastedLands", uiMapID=17, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Eastern Kingdoms
A{"BlastedLands", 1025, 0.4600, 0.1400, criterion=23464, side="horde", season="Midsummer Fire Festival", trivia={criteria="Blasted Lands", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="BlastedLands", uiMapID=17, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"BlastedLands", 1028, 0.5800, 0.1700, criterion=23467, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Blasted Lands", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Horde's bonfires in Eastern Kingdoms.", mapID="BlastedLands", uiMapID=17, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"BlastedLands", 1031, 0.4620, 0.1380, criterion=3162, note="also Nethergarde Keep", side="horde", season="Midsummer Fire Festival", trivia={criteria="Blasted Lands", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Alliance's bonfires in Eastern Kingdoms.", mapID="BlastedLands", uiMapID=17, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Kalimdor
A{"BloodmystIsle", 1023, 0.5600, 0.6800, criterion=3078, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Bloodmyst Isle", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Kalimdor", description="Honor the flames of Kalimdor.", mapID="BloodmystIsle", uiMapID=106, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Kalimdor
A{"BloodmystIsle", 1032, 0.5600, 0.6850, criterion=3176, side="horde", season="Midsummer Fire Festival", trivia={criteria="Bloodmyst Isle", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Kalimdor", description="Desecrate the Alliance's bonfires in Kalimdor.", mapID="BloodmystIsle", uiMapID=106, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Northrend
A{"BoreanTundra", 6007, 0.5110, 0.1190, criterion=18163, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Borean Tundra", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Northrend", description="Desecrate the Horde's bonfires in Northrend.", mapID="BoreanTundra", uiMapID=114, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Northrend
A{"BoreanTundra", 6008, 0.5500, 0.2000, criterion=18171, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Borean Tundra", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Northrend", description="Honor the flames of Northrend.", mapID="BoreanTundra", uiMapID=114, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Northrend
A{"BoreanTundra", 6009, 0.5100, 0.1200, criterion=18179, side="horde", season="Midsummer Fire Festival", trivia={criteria="Borean Tundra", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Northrend", description="Honor the flames of Northrend.", mapID="BoreanTundra", uiMapID=114, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Northrend
A{"BoreanTundra", 6010, 0.5510, 0.2020, criterion=18187, side="horde", season="Midsummer Fire Festival", trivia={criteria="Borean Tundra", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Northrend", description="Desecrate the Alliance's bonfires in Northrend.", mapID="BoreanTundra", uiMapID=114, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Eastern Kingdoms
A{"BurningSteppes", 1022, 0.6830, 0.6040, criterion=3065, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Burning Steppes", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="BurningSteppes", uiMapID=36, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Eastern Kingdoms
A{"BurningSteppes", 1025, 0.5100, 0.2900, criterion=3103, side="horde", season="Midsummer Fire Festival", trivia={criteria="Burning Steppes", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="BurningSteppes", uiMapID=36, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"BurningSteppes", 1028, 0.5160, 0.2940, criterion=3133, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Burning Steppes", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Horde's bonfires in Eastern Kingdoms.", mapID="BurningSteppes", uiMapID=36, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"BurningSteppes", 1031, 0.5120, 0.2920, criterion=3163, note="also Morgan's Vigil", side="horde", season="Midsummer Fire Festival", trivia={criteria="Burning Steppes", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Alliance's bonfires in Eastern Kingdoms.", mapID="BurningSteppes", uiMapID=36, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Northrend
A{"CrystalsongForest", 6007, 0.8050, 0.5300, criterion=18170, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Crystalsong Forest", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Northrend", description="Desecrate the Horde's bonfires in Northrend.", mapID="CrystalsongForest", uiMapID=127, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Northrend
A{"CrystalsongForest", 6008, 0.7800, 0.7500, criterion=18172, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Crystalsong Forest", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Northrend", description="Honor the flames of Northrend.", mapID="CrystalsongForest", uiMapID=127, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Northrend
A{"CrystalsongForest", 6009, 0.8000, 0.5300, criterion=18180, side="horde", season="Midsummer Fire Festival", trivia={criteria="Crystalsong Forest", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Northrend", description="Honor the flames of Northrend.", mapID="CrystalsongForest", uiMapID=127, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Northrend
A{"CrystalsongForest", 6010, 0.7770, 0.7490, criterion=18188, side="horde", season="Midsummer Fire Festival", trivia={criteria="Crystalsong Forest", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Northrend", description="Desecrate the Alliance's bonfires in Northrend.", mapID="CrystalsongForest", uiMapID=127, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Kalimdor
A{"Darkshore", 1023, 0.4870, 0.2260, criterion=3079, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Darkshore", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Kalimdor", description="Honor the flames of Kalimdor.", mapID="Darkshore", uiMapID=62, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Kalimdor
A{"Darkshore", 1032, 0.4900, 0.2250, criterion=3177, side="horde", season="Midsummer Fire Festival", trivia={criteria="Darkshore", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Kalimdor", description="Desecrate the Alliance's bonfires in Kalimdor.", mapID="Darkshore", uiMapID=62, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Cataclysm
A{"Deepholm", 6011, 0.4940, 0.5140, criterion=18197, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Deepholm", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Cataclysm", description="Honor the flames of zones opened by the cataclysm.", mapID="Deepholm", uiMapID=207, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Cataclysm
A{"Deepholm", 6012, 0.4940, 0.5140, criterion=18197, side="horde", season="Midsummer Fire Festival", trivia={criteria="Deepholm", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Cataclysm", description="Honor the flames of zones opened by the cataclysm.", mapID="Deepholm", uiMapID=207, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Kalimdor
A{"Desolace", 1023, 0.6600, 0.1700, criterion=3080, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Desolace", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Kalimdor", description="Honor the flames of Kalimdor.", mapID="Desolace", uiMapID=66, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Kalimdor
A{"Desolace", 1026, 0.2600, 0.7600, criterion=3113, side="horde", season="Midsummer Fire Festival", trivia={criteria="Desolace", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Kalimdor", description="Honor the flames of Kalimdor.", mapID="Desolace", uiMapID=66, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Kalimdor
A{"Desolace", 1029, 0.2620, 0.7740, criterion=3143, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Desolace", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Kalimdor", description="Desecrate the Horde's bonfires in Kalimdor.", mapID="Desolace", uiMapID=66, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Kalimdor
A{"Desolace", 1032, 0.6580, 0.1700, criterion=3178, side="horde", season="Midsummer Fire Festival", trivia={criteria="Desolace", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Kalimdor", description="Desecrate the Alliance's bonfires in Kalimdor.", mapID="Desolace", uiMapID=66, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Northrend
A{"Dragonblight", 6007, 0.3850, 0.4840, criterion=18165, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Dragonblight", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Northrend", description="Desecrate the Horde's bonfires in Northrend.", mapID="Dragonblight", uiMapID=115, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Northrend
A{"Dragonblight", 6008, 0.7500, 0.4400, criterion=18173, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Dragonblight", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Northrend", description="Honor the flames of Northrend.", mapID="Dragonblight", uiMapID=115, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Northrend
A{"Dragonblight", 6009, 0.3900, 0.4800, criterion=18181, side="horde", season="Midsummer Fire Festival", trivia={criteria="Dragonblight", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Northrend", description="Honor the flames of Northrend.", mapID="Dragonblight", uiMapID=115, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Northrend
A{"Dragonblight", 6010, 0.7510, 0.4370, criterion=18189, side="horde", season="Midsummer Fire Festival", trivia={criteria="Dragonblight", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Northrend", description="Desecrate the Alliance's bonfires in Northrend.", mapID="Dragonblight", uiMapID=115, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Pandaria
A{"DreadWastes", 8044, 0.5610, 0.6950, criterion=22688, side="horde", season="Midsummer Fire Festival", trivia={criteria="Dread Wastes", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Pandaria", description="Honor the flames of Pandaria.", mapID="DreadWastes", uiMapID=422, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Pandaria
A{"DreadWastes", 8045, 0.5610, 0.6950, criterion=22688, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Dread Wastes", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Pandaria", description="Honor the flames of Pandaria.", mapID="DreadWastes", uiMapID=422, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Eastern Kingdoms
A{"DunMorogh", 1022, 0.5380, 0.4520, criterion=3066, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Dun Morogh", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="DunMorogh", uiMapID=27, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"DunMorogh", 1031, 0.5370, 0.4500, criterion=3164, side="horde", season="Midsummer Fire Festival", trivia={criteria="Dun Morogh", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Alliance's bonfires in Eastern Kingdoms.", mapID="DunMorogh", uiMapID=27, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Kalimdor
A{"Durotar", 1026, 0.5200, 0.4700, criterion=3114, side="horde", season="Midsummer Fire Festival", trivia={criteria="Durotar", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Kalimdor", description="Honor the flames of Kalimdor.", mapID="Durotar", uiMapID=1, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Kalimdor
A{"Durotar", 1029, 0.5200, 0.4700, criterion=3144, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Durotar", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Kalimdor", description="Desecrate the Horde's bonfires in Kalimdor.", mapID="Durotar", uiMapID=1, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Eastern Kingdoms
A{"Duskwood", 1022, 0.7360, 0.5480, criterion=3067, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Duskwood", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="Duskwood", uiMapID=47, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"Duskwood", 1031, 0.7350, 0.5470, criterion=3165, side="horde", season="Midsummer Fire Festival", trivia={criteria="Duskwood", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Alliance's bonfires in Eastern Kingdoms.", mapID="Duskwood", uiMapID=47, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Kalimdor
A{"Dustwallow", 1023, 0.6200, 0.4050, criterion=3081, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Dustwallow Marsh", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Kalimdor", description="Honor the flames of Kalimdor.", mapID="DustwallowMarsh", uiMapID=70, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Kalimdor
A{"Dustwallow", 1026, 0.3300, 0.3000, criterion=3115, side="horde", season="Midsummer Fire Festival", trivia={criteria="Dustwallow Marsh", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Kalimdor", description="Honor the flames of Kalimdor.", mapID="DustwallowMarsh", uiMapID=70, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Kalimdor
A{"Dustwallow", 1029, 0.3310, 0.3070, criterion=3145, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Dustwallow Marsh", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Kalimdor", description="Desecrate the Horde's bonfires in Kalimdor.", mapID="DustwallowMarsh", uiMapID=70, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Kalimdor
A{"Dustwallow", 1032, 0.6210, 0.4030, criterion=3179, side="horde", season="Midsummer Fire Festival", trivia={criteria="Dustwallow Marsh", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Kalimdor", description="Desecrate the Alliance's bonfires in Kalimdor.", mapID="DustwallowMarsh", uiMapID=70, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Eastern Kingdoms
A{"Elwynn", 1022, 0.4350, 0.6280, criterion=3068, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Elwynn Forest", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="ElwynnForest", uiMapID=37, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"Elwynn", 1031, 0.4330, 0.6270, criterion=3166, side="horde", season="Midsummer Fire Festival", trivia={criteria="Elwynn Forest", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Alliance's bonfires in Eastern Kingdoms.", mapID="ElwynnForest", uiMapID=37, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Eastern Kingdoms
A{"EversongWoods", 1025, 0.4600, 0.5000, criterion=3104, side="horde", season="Midsummer Fire Festival", trivia={criteria="Eversong Woods", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="EversongWoods", uiMapID=94, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"EversongWoods", 1028, 0.4630, 0.5030, criterion=3134, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Eversong Woods", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Horde's bonfires in Eastern Kingdoms.", mapID="EversongWoods", uiMapID=94, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: The Fires of Azeroth
A{"Expansion01", 1034, criterion=3195, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Flame Warden of Outland", module="seasonal_mid", category="World Events/Midsummer", name="The Fires of Azeroth", description="Complete the Flame Warden achievements.", points=10, parent="World Events", type="achievement"}}

-- World Events/Midsummer: Desecration of the Horde
A{"Expansion01", 1035, criterion=3198, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Extinguishing Outland", module="seasonal_mid", category="World Events/Midsummer", name="Desecration of the Horde", description="Complete all Extinguishing achievements.", points=10, parent="World Events", type="achievement"}}

-- World Events/Midsummer: The Fires of Azeroth
A{"Expansion01", 1036, criterion=3201, side="horde", season="Midsummer Fire Festival", trivia={criteria="Flame Keeper of Outland", module="seasonal_mid", category="World Events/Midsummer", name="The Fires of Azeroth", description="Complete the Flame Keeper achievements.", points=10, parent="World Events", type="achievement"}}

-- World Events/Midsummer: Desecration of the Alliance
A{"Expansion01", 1037, criterion=3204, side="horde", season="Midsummer Fire Festival", trivia={criteria="Extinguishing Outland", module="seasonal_mid", category="World Events/Midsummer", name="Desecration of the Alliance", description="Complete all Extinguishing achievements.", points=10, parent="World Events", type="achievement"}}

-- World Events/Midsummer: Flame Warden of Kalimdor
A{"Feralas", 1023, 0.4700, 0.4400, criterion=3082, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Feralas", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Kalimdor", description="Honor the flames of Kalimdor.", mapID="Feralas", uiMapID=69, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Kalimdor
A{"Feralas", 1026, 0.7200, 0.4700, criterion=3116, side="horde", season="Midsummer Fire Festival", trivia={criteria="Feralas", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Kalimdor", description="Honor the flames of Kalimdor.", mapID="Feralas", uiMapID=69, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Kalimdor
A{"Feralas", 1029, 0.7250, 0.4750, criterion=3146, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Feralas", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Kalimdor", description="Desecrate the Horde's bonfires in Kalimdor.", mapID="Feralas", uiMapID=69, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Kalimdor
A{"Feralas", 1032, 0.4660, 0.4380, criterion=3180, side="horde", season="Midsummer Fire Festival", trivia={criteria="Feralas", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Kalimdor", description="Desecrate the Alliance's bonfires in Kalimdor.", mapID="Feralas", uiMapID=69, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Eastern Kingdoms
A{"Ghostlands", 1025, 0.4600, 0.2600, criterion=3105, side="horde", season="Midsummer Fire Festival", trivia={criteria="Ghostlands", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="Ghostlands", uiMapID=95, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"Ghostlands", 1028, 0.4690, 0.2600, criterion=3135, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Ghostlands", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Horde's bonfires in Eastern Kingdoms.", mapID="Ghostlands", uiMapID=95, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Northrend
A{"GrizzlyHills", 6007, 0.1910, 0.6130, criterion=18168, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Grizzly Hills", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Northrend", description="Desecrate the Horde's bonfires in Northrend.", mapID="GrizzlyHills", uiMapID=116, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Northrend
A{"GrizzlyHills", 6008, 0.3400, 0.6100, criterion=18174, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Grizzly Hills", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Northrend", description="Honor the flames of Northrend.", mapID="GrizzlyHills", uiMapID=116, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Northrend
A{"GrizzlyHills", 6009, 0.1900, 0.6100, criterion=18182, side="horde", season="Midsummer Fire Festival", trivia={criteria="Grizzly Hills", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Northrend", description="Honor the flames of Northrend.", mapID="GrizzlyHills", uiMapID=116, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Northrend
A{"GrizzlyHills", 6010, 0.3410, 0.6070, criterion=18190, side="horde", season="Midsummer Fire Festival", trivia={criteria="Grizzly Hills", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Northrend", description="Desecrate the Alliance's bonfires in Northrend.", mapID="GrizzlyHills", uiMapID=116, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Outland
A{"Hellfire", 1024, 0.6200, 0.5800, criterion=3090, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Hellfire Peninsula", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Outland", description="Honor the flames of Outland.", mapID="HellfirePeninsula", uiMapID=100, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Outland
A{"Hellfire", 1027, 0.5500, 0.4000, criterion=3125, side="horde", season="Midsummer Fire Festival", trivia={criteria="Hellfire Peninsula", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Outland", description="Honor the flames of Outland.", mapID="HellfirePeninsula", uiMapID=100, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Outland
A{"Hellfire", 1030, 0.5730, 0.4180, criterion=3155, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Hellfire Peninsula", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Outland", description="Desecrate the Horde's bonfires in Outland.", mapID="HellfirePeninsula", uiMapID=100, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Outland
A{"Hellfire", 1033, 0.6190, 0.5850, criterion=3187, side="horde", season="Midsummer Fire Festival", trivia={criteria="Hellfire Peninsula", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Outland", description="Desecrate the Alliance's bonfires in Outland.", mapID="HellfirePeninsula", uiMapID=100, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Eastern Kingdoms
A{"HillsbradFoothills", 1025, 0.5500, 0.5000, criterion=3106, side="horde", season="Midsummer Fire Festival", trivia={criteria="Hillsbrad Foothills", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="HillsbradFoothills", uiMapID=25, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"HillsbradFoothills", 1028, 0.5440, 0.4990, criterion=3136, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Hillsbrad Foothills", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Horde's bonfires in Eastern Kingdoms.", mapID="HillsbradFoothills", uiMapID=25, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Eastern Kingdoms
A{"Hinterlands", 1022, 0.1440, 0.5020, criterion=3073, side="alliance", season="Midsummer Fire Festival", trivia={criteria="The Hinterlands", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="TheHinterlands", uiMapID=26, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Eastern Kingdoms
A{"Hinterlands", 1025, 0.7600, 0.7500, criterion=3110, side="horde", season="Midsummer Fire Festival", trivia={criteria="The Hinterlands", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="TheHinterlands", uiMapID=26, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"Hinterlands", 1028, 0.7650, 0.7450, criterion=3140, side="alliance", season="Midsummer Fire Festival", trivia={criteria="The Hinterlands", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Horde's bonfires in Eastern Kingdoms.", mapID="TheHinterlands", uiMapID=26, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"Hinterlands", 1031, 0.7660, 0.7480, criterion=3171, note="also Aerie Peak", side="horde", season="Midsummer Fire Festival", trivia={criteria="The Hinterlands", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Alliance's bonfires in Eastern Kingdoms.", mapID="TheHinterlands", uiMapID=26, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Northrend
A{"HowlingFjord", 6007, 0.4850, 0.1350, criterion=18169, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Howling Fjord", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Northrend", description="Desecrate the Horde's bonfires in Northrend.", mapID="HowlingFjord", uiMapID=117, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Northrend
A{"HowlingFjord", 6008, 0.5800, 0.1600, criterion=18175, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Howling Fjord", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Northrend", description="Honor the flames of Northrend.", mapID="HowlingFjord", uiMapID=117, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Northrend
A{"HowlingFjord", 6009, 0.4800, 0.1300, criterion=18183, side="horde", season="Midsummer Fire Festival", trivia={criteria="Howling Fjord", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Northrend", description="Honor the flames of Northrend.", mapID="HowlingFjord", uiMapID=117, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Northrend
A{"HowlingFjord", 6010, 0.5770, 0.1570, criterion=18191, side="horde", season="Midsummer Fire Festival", trivia={criteria="Howling Fjord", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Northrend", description="Desecrate the Alliance's bonfires in Northrend.", mapID="HowlingFjord", uiMapID=117, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Cataclysm
A{"Hyjal", 6012, 0.6280, 0.2260, criterion=18198, side="horde", season="Midsummer Fire Festival", trivia={criteria="Hyjal", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Cataclysm", description="Honor the flames of zones opened by the cataclysm.", mapID="MountHyjal", uiMapID=198, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: The Fires of Azeroth
A{"Kalimdor", 1034, criterion=3194, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Flame Warden of Kalimdor", module="seasonal_mid", category="World Events/Midsummer", name="The Fires of Azeroth", description="Complete the Flame Warden achievements.", points=10, parent="World Events", type="achievement"}}

-- World Events/Midsummer: Desecration of the Horde
A{"Kalimdor", 1035, criterion=3197, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Extinguishing Kalimdor", module="seasonal_mid", category="World Events/Midsummer", name="Desecration of the Horde", description="Complete all Extinguishing achievements.", points=10, parent="World Events", type="achievement"}}

-- World Events/Midsummer: The Fires of Azeroth
A{"Kalimdor", 1036, criterion=3200, side="horde", season="Midsummer Fire Festival", trivia={criteria="Flame Keeper of Kalimdor", module="seasonal_mid", category="World Events/Midsummer", name="The Fires of Azeroth", description="Complete the Flame Keeper achievements.", points=10, parent="World Events", type="achievement"}}

-- World Events/Midsummer: Desecration of the Alliance
A{"Kalimdor", 1037, criterion=3203, side="horde", season="Midsummer Fire Festival", trivia={criteria="Extinguishing Kalimdor", module="seasonal_mid", category="World Events/Midsummer", name="Desecration of the Alliance", description="Complete all Extinguishing achievements.", points=10, parent="World Events", type="achievement"}}

-- World Events/Midsummer: Flame Keeper of Pandaria
A{"Krasarang", 8044, 0.7400, 0.0940, criterion=22690, side="horde", season="Midsummer Fire Festival", trivia={criteria="Krasarang Wilds", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Pandaria", description="Honor the flames of Pandaria.", mapID="KrasarangWilds", uiMapID=418, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Pandaria
A{"Krasarang", 8045, 0.7400, 0.0940, criterion=22690, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Krasarang Wilds", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Pandaria", description="Honor the flames of Pandaria.", mapID="KrasarangWilds", uiMapID=418, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Pandaria
A{"KunLaiSummit", 8044, 0.7110, 0.9090, criterion=22691, side="horde", season="Midsummer Fire Festival", trivia={criteria="Kun-Lai Summit", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Pandaria", description="Honor the flames of Pandaria.", mapID="KunLaiSummit", uiMapID=379, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Pandaria
A{"KunLaiSummit", 8045, 0.7110, 0.9090, criterion=22691, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Kun-Lai Summit", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Pandaria", description="Honor the flames of Pandaria.", mapID="KunLaiSummit", uiMapID=379, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Eastern Kingdoms
A{"LochModan", 1022, 0.3240, 0.4100, criterion=3070, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Loch Modan", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="LochModan", uiMapID=48, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"LochModan", 1031, 0.3240, 0.4060, criterion=3168, side="horde", season="Midsummer Fire Festival", trivia={criteria="Loch Modan", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Alliance's bonfires in Eastern Kingdoms.", mapID="LochModan", uiMapID=48, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Kalimdor
A{"Mulgore", 1026, 0.5100, 0.5900, criterion=3117, side="horde", season="Midsummer Fire Festival", trivia={criteria="Mulgore", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Kalimdor", description="Honor the flames of Kalimdor.", mapID="Mulgore", uiMapID=7, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Kalimdor
A{"Mulgore", 1029, 0.5210, 0.5960, criterion=3147, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Mulgore", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Kalimdor", description="Desecrate the Horde's bonfires in Kalimdor.", mapID="Mulgore", uiMapID=7, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Outland
A{"Nagrand", 1024, 0.5000, 0.7000, criterion=3091, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Nagrand", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Outland", description="Honor the flames of Outland.", mapID="Nagrand", uiMapID=107, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Outland
A{"Nagrand", 1027, 0.5100, 0.3400, criterion=3126, side="horde", season="Midsummer Fire Festival", trivia={criteria="Nagrand", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Outland", description="Honor the flames of Outland.", mapID="Nagrand", uiMapID=107, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Outland
A{"Nagrand", 1030, 0.5110, 0.3420, criterion=3156, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Nagrand", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Outland", description="Desecrate the Horde's bonfires in Outland.", mapID="Nagrand", uiMapID=107, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Outland
A{"Nagrand", 1033, 0.4970, 0.6960, criterion=3188, side="horde", season="Midsummer Fire Festival", trivia={criteria="Nagrand", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Outland", description="Desecrate the Alliance's bonfires in Outland.", mapID="Nagrand", uiMapID=107, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Outland
A{"Netherstorm", 1024, 0.3100, 0.6300, criterion=3092, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Netherstorm", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Outland", description="Honor the flames of Outland.", mapID="Netherstorm", uiMapID=109, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Outland
A{"Netherstorm", 1027, 0.3200, 0.6800, criterion=3127, side="horde", season="Midsummer Fire Festival", trivia={criteria="Netherstorm", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Outland", description="Honor the flames of Outland.", mapID="Netherstorm", uiMapID=109, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Outland
A{"Netherstorm", 1030, 0.3230, 0.6850, criterion=3157, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Netherstorm", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Outland", description="Desecrate the Horde's bonfires in Outland.", mapID="Netherstorm", uiMapID=109, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Outland
A{"Netherstorm", 1033, 0.3110, 0.6270, criterion=3189, side="horde", season="Midsummer Fire Festival", trivia={criteria="Netherstorm", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Outland", description="Desecrate the Alliance's bonfires in Outland.", mapID="Netherstorm", uiMapID=109, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: The Fires of Azeroth
A{"Northrend", 1034, criterion=18219, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Flame Warden of Northrend", module="seasonal_mid", category="World Events/Midsummer", name="The Fires of Azeroth", description="Complete the Flame Warden achievements.", points=10, parent="World Events", type="achievement"}}

-- World Events/Midsummer: Desecration of the Horde
A{"Northrend", 1035, criterion=18215, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Extinguishing Northrend", module="seasonal_mid", category="World Events/Midsummer", name="Desecration of the Horde", description="Complete all Extinguishing achievements.", points=10, parent="World Events", type="achievement"}}

-- World Events/Midsummer: The Fires of Azeroth
A{"Northrend", 1036, criterion=18217, side="horde", season="Midsummer Fire Festival", trivia={criteria="Flame Keeper of Northrend", module="seasonal_mid", category="World Events/Midsummer", name="The Fires of Azeroth", description="Complete the Flame Keeper achievements.", points=10, parent="World Events", type="achievement"}}

-- World Events/Midsummer: Desecration of the Alliance
A{"Northrend", 1037, criterion=18213, side="horde", season="Midsummer Fire Festival", trivia={criteria="Extinguishing Northrend", module="seasonal_mid", category="World Events/Midsummer", name="Desecration of the Alliance", description="Complete all Extinguishing achievements.", points=10, parent="World Events", type="achievement"}}

-- World Events/Midsummer: Flame Warden of Eastern Kingdoms
A{"Redridge", 1022, 0.2490, 0.5360, criterion=3071, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Redridge Mountains", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="RedridgeMountains", uiMapID=49, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"Redridge", 1031, 0.2480, 0.5360, criterion=3169, side="horde", season="Midsummer Fire Festival", trivia={criteria="Redridge Mountains", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Alliance's bonfires in Eastern Kingdoms.", mapID="RedridgeMountains", uiMapID=49, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Outland
A{"ShadowmoonValley", 1024, 0.4000, 0.5500, criterion=3093, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Shadowmoon Valley", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Outland", description="Honor the flames of Outland.", mapID="ShadowmoonValley", uiMapID=104, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Outland
A{"ShadowmoonValley", 1027, 0.3300, 0.3000, criterion=3128, side="horde", season="Midsummer Fire Festival", trivia={criteria="Shadowmoon Valley", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Outland", description="Honor the flames of Outland.", mapID="ShadowmoonValley", uiMapID=104, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Outland
A{"ShadowmoonValley", 1030, 0.3360, 0.3030, criterion=3158, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Shadowmoon Valley", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Outland", description="Desecrate the Horde's bonfires in Outland.", mapID="ShadowmoonValley", uiMapID=104, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Outland
A{"ShadowmoonValley", 1033, 0.3970, 0.5450, criterion=3190, side="horde", season="Midsummer Fire Festival", trivia={criteria="Shadowmoon Valley", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Outland", description="Desecrate the Alliance's bonfires in Outland.", mapID="ShadowmoonValley", uiMapID=104, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Northrend
A{"SholazarBasin", 6007, 0.4750, 0.6150, criterion=18164, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Sholazar Basin", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Northrend", description="Desecrate the Horde's bonfires in Northrend.", mapID="SholazarBasin", uiMapID=119, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Northrend
A{"SholazarBasin", 6008, 0.4700, 0.6600, criterion=18176, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Sholazar Basin", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Northrend", description="Honor the flames of Northrend.", mapID="SholazarBasin", uiMapID=119, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Northrend
A{"SholazarBasin", 6009, 0.4700, 0.6200, criterion=18184, side="horde", season="Midsummer Fire Festival", trivia={criteria="Sholazar Basin", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Northrend", description="Honor the flames of Northrend.", mapID="SholazarBasin", uiMapID=119, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Northrend
A{"SholazarBasin", 6010, 0.4790, 0.6600, criterion=18192, side="horde", season="Midsummer Fire Festival", trivia={criteria="Sholazar Basin", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Northrend", description="Desecrate the Alliance's bonfires in Northrend.", mapID="SholazarBasin", uiMapID=119, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Kalimdor
A{"Silithus", 1023, 0.6000, 0.3300, criterion=3083, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Silithus", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Kalimdor", description="Honor the flames of Kalimdor.", mapID="Silithus", uiMapID=81, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Kalimdor
A{"Silithus", 1026, 0.5100, 0.4100, criterion=3118, side="horde", season="Midsummer Fire Festival", trivia={criteria="Silithus", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Kalimdor", description="Honor the flames of Kalimdor.", mapID="Silithus", uiMapID=81, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Kalimdor
A{"Silithus", 1029, 0.5080, 0.4190, criterion=3148, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Silithus", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Kalimdor", description="Desecrate the Horde's bonfires in Kalimdor.", mapID="Silithus", uiMapID=81, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Kalimdor
A{"Silithus", 1032, 0.6050, 0.3350, criterion=3181, side="horde", season="Midsummer Fire Festival", trivia={criteria="Silithus", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Kalimdor", description="Desecrate the Alliance's bonfires in Kalimdor.", mapID="Silithus", uiMapID=81, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Eastern Kingdoms
A{"Silverpine", 1025, 0.5000, 0.3800, criterion=3107, side="horde", season="Midsummer Fire Festival", trivia={criteria="Silverpine Forest", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="SilverpineForest", uiMapID=21, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"Silverpine", 1028, 0.4970, 0.3880, criterion=3137, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Silverpine Forest", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Horde's bonfires in Eastern Kingdoms.", mapID="SilverpineForest", uiMapID=21, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Kalimdor
A{"SouthernBarrens", 1023, 0.4820, 0.7220, criterion=17016, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Southern Barrens", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Kalimdor", description="Honor the flames of Kalimdor.", mapID="SouthernBarrens", uiMapID=199, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Kalimdor
A{"SouthernBarrens", 1026, 0.4100, 0.6800, criterion=17015, side="horde", season="Midsummer Fire Festival", trivia={criteria="Southern Barrens", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Kalimdor", description="Honor the flames of Kalimdor.", mapID="SouthernBarrens", uiMapID=199, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Kalimdor
A{"SouthernBarrens", 1029, 0.4070, 0.6720, criterion=17014, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Southern Barrens", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Kalimdor", description="Desecrate the Horde's bonfires in Kalimdor.", mapID="SouthernBarrens", uiMapID=199, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Kalimdor
A{"SouthernBarrens", 1032, 0.4820, 0.7250, criterion=17017, side="horde", season="Midsummer Fire Festival", trivia={criteria="Southern Barrens", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Kalimdor", description="Desecrate the Alliance's bonfires in Kalimdor.", mapID="SouthernBarrens", uiMapID=199, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Kalimdor
A{"StonetalonMountains", 1023, 0.4900, 0.5200, criterion=23513, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Stonetalon Mountains", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Kalimdor", description="Honor the flames of Kalimdor.", mapID="StonetalonMountains", uiMapID=65, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Kalimdor
A{"StonetalonMountains", 1026, 0.5300, 0.6200, criterion=3119, side="horde", season="Midsummer Fire Festival", trivia={criteria="Stonetalon Mountains", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Kalimdor", description="Honor the flames of Kalimdor.", mapID="StonetalonMountains", uiMapID=65, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Kalimdor
A{"StonetalonMountains", 1029, 0.5300, 0.6220, criterion=3149, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Stonetalon Mountains", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Kalimdor", description="Desecrate the Horde's bonfires in Kalimdor.", mapID="StonetalonMountains", uiMapID=65, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Kalimdor
A{"StonetalonMountains", 1032, 0.4960, 0.5110, criterion=23516, side="horde", season="Midsummer Fire Festival", trivia={criteria="Stonetalon Mountains", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Kalimdor", description="Desecrate the Alliance's bonfires in Kalimdor.", mapID="StonetalonMountains", uiMapID=65, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Eastern Kingdoms
A{"StranglethornJungle", 1022, 0.5190, 0.6360, criterion=17013, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Northern Stranglethorn", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="NorthernStranglethorn", uiMapID=50, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Eastern Kingdoms
A{"StranglethornJungle", 1025, 0.4000, 0.5100, criterion=17012, side="horde", season="Midsummer Fire Festival", trivia={criteria="Northern Stranglethorn", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="NorthernStranglethorn", uiMapID=50, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"StranglethornJungle", 1028, 0.4070, 0.5200, criterion=17010, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Northern Stranglethorn", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Horde's bonfires in Eastern Kingdoms.", mapID="NorthernStranglethorn", uiMapID=50, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"StranglethornJungle", 1031, 0.4060, 0.5130, criterion=17011, note="also Fort Livingston", side="horde", season="Midsummer Fire Festival", trivia={criteria="Northern Stranglethorn", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Alliance's bonfires in Eastern Kingdoms.", mapID="NorthernStranglethorn", uiMapID=50, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Eastern Kingdoms
A{"SwampOfSorrows", 1022, 0.7010, 0.1560, criterion=23510, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Swamp of Sorrows", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="SwampOfSorrows", uiMapID=51, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Eastern Kingdoms
A{"SwampOfSorrows", 1025, 0.7600, 0.1400, criterion=3109, side="horde", season="Midsummer Fire Festival", trivia={criteria="Swamp of Sorrows", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="SwampOfSorrows", uiMapID=51, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"SwampOfSorrows", 1028, 0.7680, 0.1420, criterion=3139, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Swamp of Sorrows", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Horde's bonfires in Eastern Kingdoms.", mapID="SwampOfSorrows", uiMapID=51, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"SwampOfSorrows", 1031, 0.7650, 0.1370, criterion=23511, side="horde", season="Midsummer Fire Festival", trivia={criteria="Swamp of Sorrows", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Alliance's bonfires in Eastern Kingdoms.", mapID="SwampOfSorrows", uiMapID=51, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Kalimdor
A{"Tanaris", 1023, 0.5250, 0.3030, criterion=3084, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Tanaris", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Kalimdor", description="Honor the flames of Kalimdor.", mapID="Tanaris", uiMapID=71, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Kalimdor
A{"Tanaris", 1026, 0.4900, 0.2700, criterion=3120, side="horde", season="Midsummer Fire Festival", trivia={criteria="Tanaris", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Kalimdor", description="Honor the flames of Kalimdor.", mapID="Tanaris", uiMapID=71, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Kalimdor
A{"Tanaris", 1029, 0.4980, 0.2830, criterion=3150, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Tanaris", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Kalimdor", description="Desecrate the Horde's bonfires in Kalimdor.", mapID="Tanaris", uiMapID=71, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Kalimdor
A{"Tanaris", 1032, 0.5270, 0.3000, criterion=3182, side="horde", season="Midsummer Fire Festival", trivia={criteria="Tanaris", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Kalimdor", description="Desecrate the Alliance's bonfires in Kalimdor.", mapID="Tanaris", uiMapID=71, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Kalimdor
A{"Teldrassil", 1023, 0.5500, 0.5300, criterion=3085, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Teldrassil", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Kalimdor", description="Honor the flames of Kalimdor.", mapID="Teldrassil", uiMapID=57, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Kalimdor
A{"Teldrassil", 1032, 0.5470, 0.5270, criterion=3183, side="horde", season="Midsummer Fire Festival", trivia={criteria="Teldrassil", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Kalimdor", description="Desecrate the Alliance's bonfires in Kalimdor.", mapID="Teldrassil", uiMapID=57, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Outland
A{"TerokkarForest", 1024, 0.5500, 0.5500, criterion=3094, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Terokkar Forest", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Outland", description="Honor the flames of Outland.", mapID="TerokkarForest", uiMapID=108, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Outland
A{"TerokkarForest", 1027, 0.5200, 0.4300, criterion=3129, side="horde", season="Midsummer Fire Festival", trivia={criteria="Terokkar Forest", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Outland", description="Honor the flames of Outland.", mapID="TerokkarForest", uiMapID=108, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Outland
A{"TerokkarForest", 1030, 0.5190, 0.4330, criterion=3159, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Terokkar Forest", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Outland", description="Desecrate the Horde's bonfires in Outland.", mapID="TerokkarForest", uiMapID=108, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Outland
A{"TerokkarForest", 1033, 0.5420, 0.5570, criterion=3191, side="horde", season="Midsummer Fire Festival", trivia={criteria="Terokkar Forest", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Outland", description="Desecrate the Alliance's bonfires in Outland.", mapID="TerokkarForest", uiMapID=108, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Eastern Kingdoms
A{"TheCapeOfStranglethorn", 1022, 0.5180, 0.6760, criterion=3072, side="alliance", season="Midsummer Fire Festival", trivia={criteria="The Cape of Stranglethorn", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="TheCapeOfStranglethorn", uiMapID=210, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Eastern Kingdoms
A{"TheCapeOfStranglethorn", 1025, 0.5000, 0.7000, criterion=3108, side="horde", season="Midsummer Fire Festival", trivia={criteria="The Cape of Stranglethorn", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="TheCapeOfStranglethorn", uiMapID=210, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"TheCapeOfStranglethorn", 1028, 0.5060, 0.7070, criterion=3138, side="alliance", season="Midsummer Fire Festival", trivia={criteria="The Cape of Stranglethorn", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Horde's bonfires in Eastern Kingdoms.", mapID="TheCapeOfStranglethorn", uiMapID=210, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"TheCapeOfStranglethorn", 1031, 0.5040, 0.7040, criterion=3170, side="horde", season="Midsummer Fire Festival", trivia={criteria="The Cape of Stranglethorn", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Alliance's bonfires in Eastern Kingdoms.", mapID="TheCapeOfStranglethorn", uiMapID=210, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Pandaria
A{"TheJadeForest", 8044, 0.4720, 0.4720, criterion=22689, side="horde", season="Midsummer Fire Festival", trivia={criteria="Jade Forest", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Pandaria", description="Honor the flames of Pandaria.", mapID="TheJadeForest", uiMapID=371, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Pandaria
A{"TheJadeForest", 8045, 0.4720, 0.4720, criterion=22689, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Jade Forest", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Pandaria", description="Honor the flames of Pandaria.", mapID="TheJadeForest", uiMapID=371, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Ice the Frost Lord
A{"TheSlavePens", 263, 0.3200, 0.5100, season="Midsummer Fire Festival", trivia={module="seasonal_mid", category="World Events/Midsummer", name="Ice the Frost Lord", description="Slay Ahune in the Slave Pens.", mapID="TheSlavePens", uiMapID=265, points=10, parent="World Events"}}

-- World Events/Midsummer: Extinguishing Northrend
A{"TheStormPeaks", 6007, 0.4030, 0.8560, criterion=18166, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Storm Peaks", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Northrend", description="Desecrate the Horde's bonfires in Northrend.", mapID="TheStormPeaks", uiMapID=120, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Northrend
A{"TheStormPeaks", 6008, 0.4200, 0.8700, criterion=18177, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Storm Peaks", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Northrend", description="Honor the flames of Northrend.", mapID="TheStormPeaks", uiMapID=120, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Northrend
A{"TheStormPeaks", 6009, 0.4000, 0.8600, criterion=18185, side="horde", season="Midsummer Fire Festival", trivia={criteria="Storm Peaks", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Northrend", description="Honor the flames of Northrend.", mapID="TheStormPeaks", uiMapID=120, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Northrend
A{"TheStormPeaks", 6010, 0.4150, 0.8710, criterion=18193, side="horde", season="Midsummer Fire Festival", trivia={criteria="Storm Peaks", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Northrend", description="Desecrate the Alliance's bonfires in Northrend.", mapID="TheStormPeaks", uiMapID=120, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Eastern Kingdoms
A{"Tirisfal", 1025, 0.5700, 0.5200, criterion=3111, side="horde", season="Midsummer Fire Festival", trivia={criteria="Tirisfal Glades", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="TirisfalGlades", uiMapID=18, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"Tirisfal", 1028, 0.5690, 0.5180, criterion=3141, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Tirisfal Glades", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Horde's bonfires in Eastern Kingdoms.", mapID="TirisfalGlades", uiMapID=18, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Pandaria
A{"TownlongWastes", 8044, 0.7150, 0.5630, criterion=22692, side="horde", season="Midsummer Fire Festival", trivia={criteria="Townlong Steppes", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Pandaria", description="Honor the flames of Pandaria.", mapID="TownlongSteppes", uiMapID=388, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Pandaria
A{"TownlongWastes", 8045, 0.7150, 0.5630, criterion=22692, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Townlong Steppes", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Pandaria", description="Honor the flames of Pandaria.", mapID="TownlongSteppes", uiMapID=388, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Cataclysm
A{"TwilightHighlands", 6011, 0.4700, 0.2800, criterion=18195, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Twilight Highlands", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Cataclysm", description="Honor the flames of zones opened by the cataclysm.", mapID="TwilightHighlands", uiMapID=241, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Cataclysm
A{"TwilightHighlands", 6012, 0.5300, 0.4600, criterion=18202, side="horde", season="Midsummer Fire Festival", trivia={criteria="Twilight Highlands", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Cataclysm", description="Honor the flames of zones opened by the cataclysm.", mapID="TwilightHighlands", uiMapID=241, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing the Cataclysm
A{"TwilightHighlands", 6013, 0.5340, 0.4640, criterion=18207, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Twilight Highlands", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing the Cataclysm", description="Desecrate the Horde's bonfires in zones opened by the cataclysm.", mapID="TwilightHighlands", uiMapID=241, points=5, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing the Cataclysm
A{"TwilightHighlands", 6014, 0.4710, 0.2850, criterion=18210, side="horde", season="Midsummer Fire Festival", trivia={criteria="Twilight Highlands", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing the Cataclysm", description="Desecrate the Alliance's bonfires in zones opened by the cataclysm.", mapID="TwilightHighlands", uiMapID=241, points=5, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Cataclysm
A{"Uldum", 6011, 0.5300, 0.3200, criterion=18196, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Uldum", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Cataclysm", description="Honor the flames of zones opened by the cataclysm.", mapID="Uldum", uiMapID=249, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Cataclysm
A{"Uldum", 6012, 0.5300, 0.3400, criterion=18203, side="horde", season="Midsummer Fire Festival", trivia={criteria="Uldum", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Cataclysm", description="Honor the flames of zones opened by the cataclysm.", mapID="Uldum", uiMapID=249, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing the Cataclysm
A{"Uldum", 6013, 0.5300, 0.3450, criterion=18208, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Uldum", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing the Cataclysm", description="Desecrate the Horde's bonfires in zones opened by the cataclysm.", mapID="Uldum", uiMapID=249, points=5, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing the Cataclysm
A{"Uldum", 6014, 0.5350, 0.3200, criterion=18211, side="horde", season="Midsummer Fire Festival", trivia={criteria="Uldum", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing the Cataclysm", description="Desecrate the Alliance's bonfires in zones opened by the cataclysm.", mapID="Uldum", uiMapID=249, points=5, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Kalimdor
A{"UngoroCrater", 1023, 0.6000, 0.6300, criterion=23514, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Un'Goro Crater", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Kalimdor", description="Honor the flames of Kalimdor.", mapID="UnGoroCrater", uiMapID=78, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Kalimdor
A{"UngoroCrater", 1026, 0.5600, 0.6600, criterion=23474, side="horde", season="Midsummer Fire Festival", trivia={criteria="Un'Goro Crater", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Kalimdor", description="Honor the flames of Kalimdor.", mapID="UnGoroCrater", uiMapID=78, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Kalimdor
A{"UngoroCrater", 1029, 0.5660, 0.6580, criterion=23477, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Un'Goro Crater", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Kalimdor", description="Desecrate the Horde's bonfires in Kalimdor.", mapID="UnGoroCrater", uiMapID=78, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Kalimdor
A{"UngoroCrater", 1032, 0.6000, 0.6290, criterion=23515, side="horde", season="Midsummer Fire Festival", trivia={criteria="Un'Goro Crater", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Kalimdor", description="Desecrate the Alliance's bonfires in Kalimdor.", mapID="UnGoroCrater", uiMapID=78, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Burning Hot Pole Dance
A{"unknown", 271, season="Midsummer Fire Festival", trivia={module="seasonal_mid", category="World Events/Midsummer", name="Burning Hot Pole Dance", description="Dance at the ribbon pole for 60 seconds while wearing completed Midsummer set.", points=10, parent="World Events"}}

-- World Events/Midsummer: Torch Juggler
A{"unknown", 272, criterion=6937, season="Midsummer Fire Festival", trivia={criteria="40 torches", module="seasonal_mid", category="World Events/Midsummer", name="Torch Juggler", description="Juggle 40 torches in 15 seconds in Dalaran.", points=10, parent="World Events", type=110}}

-- World Events/Midsummer: The Fires of Azeroth
A{"unknown", 1034, criterion=18218, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Flame Warden of Cataclysm", module="seasonal_mid", category="World Events/Midsummer", name="The Fires of Azeroth", description="Complete the Flame Warden achievements.", points=10, parent="World Events", type="achievement"}}

-- World Events/Midsummer: Desecration of the Horde
A{"unknown", 1035, criterion=18214, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Extinguishing the Cataclysm", module="seasonal_mid", category="World Events/Midsummer", name="Desecration of the Horde", description="Complete all Extinguishing achievements.", points=10, parent="World Events", type="achievement"}}

-- World Events/Midsummer: The Fires of Azeroth
A{"unknown", 1036, criterion=18216, side="horde", season="Midsummer Fire Festival", trivia={criteria="Flame Keeper of Cataclysm", module="seasonal_mid", category="World Events/Midsummer", name="The Fires of Azeroth", description="Complete the Flame Keeper achievements.", points=10, parent="World Events", type="achievement"}}

-- World Events/Midsummer: Desecration of the Alliance
A{"unknown", 1037, criterion=18212, side="horde", season="Midsummer Fire Festival", trivia={criteria="Extinguishing the Cataclysm", module="seasonal_mid", category="World Events/Midsummer", name="Desecration of the Alliance", description="Complete all Extinguishing achievements.", points=10, parent="World Events", type="achievement"}}

-- World Events: The Flame Warden
A{"unknown", 1038, criterion=7338, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Burning Hot Pole Dance", module="seasonal_mid", category="World Events", name="The Flame Warden", description="Complete the Midsummer achievements listed below.", points=20, type="achievement"}}
A{"unknown", 1038, criterion=7341, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Torch Juggler", module="seasonal_mid", category="World Events", name="The Flame Warden", description="Complete the Midsummer achievements listed below.", points=20, type="achievement"}}
A{"unknown", 1038, criterion=7339, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Ice the Frost Lord", module="seasonal_mid", category="World Events", name="The Flame Warden", description="Complete the Midsummer achievements listed below.", points=20, type="achievement"}}
A{"unknown", 1038, criterion=7340, side="alliance", season="Midsummer Fire Festival", trivia={criteria="King of the Fire Festival", module="seasonal_mid", category="World Events", name="The Flame Warden", description="Complete the Midsummer achievements listed below.", points=20, type="achievement"}}
A{"unknown", 1038, criterion=3206, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Desecration of the Horde/Alliance", module="seasonal_mid", category="World Events", name="The Flame Warden", description="Complete the Midsummer achievements listed below.", points=20, type="achievement"}}
A{"unknown", 1038, criterion=3205, side="alliance", season="Midsummer Fire Festival", trivia={criteria="The Fires of Azeroth", module="seasonal_mid", category="World Events", name="The Flame Warden", description="Complete the Midsummer achievements listed below.", points=20, type="achievement"}}

-- World Events: The Flame Keeper
A{"unknown", 1039, criterion=7338, side="horde", season="Midsummer Fire Festival", trivia={criteria="Burning Hot Pole Dance", module="seasonal_mid", category="World Events", name="The Flame Keeper", description="Complete the Midsummer achievements listed below.", points=20, type="achievement"}}
A{"unknown", 1039, criterion=7341, side="horde", season="Midsummer Fire Festival", trivia={criteria="Torch Juggler", module="seasonal_mid", category="World Events", name="The Flame Keeper", description="Complete the Midsummer achievements listed below.", points=20, type="achievement"}}
A{"unknown", 1039, criterion=7340, side="horde", season="Midsummer Fire Festival", trivia={criteria="King of the Fire Festival", module="seasonal_mid", category="World Events", name="The Flame Keeper", description="Complete the Midsummer achievements listed below.", points=20, type="achievement"}}
A{"unknown", 1039, criterion=7339, side="horde", season="Midsummer Fire Festival", trivia={criteria="Ice the Frost Lord", module="seasonal_mid", category="World Events", name="The Flame Keeper", description="Complete the Midsummer achievements listed below.", points=20, type="achievement"}}
A{"unknown", 1039, criterion=3206, side="horde", season="Midsummer Fire Festival", trivia={criteria="Desecration of the Alliance/Horde", module="seasonal_mid", category="World Events", name="The Flame Keeper", description="Complete the Midsummer achievements listed below.", points=20, type="achievement"}}
A{"unknown", 1039, criterion=3207, side="horde", season="Midsummer Fire Festival", trivia={criteria="The Fires of Azeroth", module="seasonal_mid", category="World Events", name="The Flame Keeper", description="Complete the Midsummer achievements listed below.", points=20, type="achievement"}}

-- World Events/Midsummer: King of the Fire Festival
A{"unknown", 1145, season="Midsummer Fire Festival", trivia={module="seasonal_mid", category="World Events/Midsummer", name="King of the Fire Festival", description="Complete the quest, \"A Thief's Reward\", by stealing the flames from your enemy's capital cities.", points=10, parent="World Events"}}

-- World Events: What a Long, Strange Trip It's Been
A{"unknown", 2144, criterion=7556, side="alliance", season="Midsummer Fire Festival", trivia={criteria="The Flame Warden", module="seasonal_mid", category="World Events", name="What a Long, Strange Trip It's Been", description="Complete the world events achievements listed below.", points=50, type="achievement"}}

-- World Events/Midsummer: Flame Warden of Cataclysm
A{"unknown", 6011, 0.6280, 0.2260, criterion=18198, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Hyjal", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Cataclysm", description="Honor the flames of zones opened by the cataclysm.", points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Pandaria
A{"unknown", 8042, side="alliance", season="Midsummer Fire Festival", trivia={module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Pandaria", description="Desecrate the Horde's bonfire in Pandaria's Vale of Eternal Blossoms.", points=10, parent="World Events"}}

-- World Events/Midsummer: Extinguishing Pandaria
A{"unknown", 8043, side="horde", season="Midsummer Fire Festival", trivia={module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Pandaria", description="Desecrate the Alliance's bonfire in Pandaria's Vale of Eternal Blossoms.", points=10, parent="World Events"}}

-- World Events/Midsummer: Flame Keeper of Pandaria
A{"ValeOfEternalBlossomsScenario", 8044, 0.7780, 0.3310, criterion=22693, side="horde", season="Midsummer Fire Festival", trivia={criteria="Vale of Eternal Blossoms", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Pandaria", description="Honor the flames of Pandaria.", mapID="ValeOfEternalBlossoms", uiMapID=390, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Pandaria
A{"ValeOfEternalBlossomsScenario", 8045, 0.7960, 0.3720, criterion=22695, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Vale of Eternal Blossoms", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Pandaria", description="Honor the flames of Pandaria.", mapID="ValeOfEternalBlossoms", uiMapID=390, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Pandaria
A{"ValleyoftheFourWinds", 8044, 0.5180, 0.5140, criterion=22694, side="horde", season="Midsummer Fire Festival", trivia={criteria="Valley of the Four Winds", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Pandaria", description="Honor the flames of Pandaria.", mapID="ValleyOfTheFourWinds", uiMapID=376, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Pandaria
A{"ValleyoftheFourWinds", 8045, 0.5180, 0.5140, criterion=22694, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Valley of the Four Winds", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Pandaria", description="Honor the flames of Pandaria.", mapID="ValleyOfTheFourWinds", uiMapID=376, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Cataclysm
A{"Vashjir", 6011, 0.4940, 0.4200, criterion=18199, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Vashj'ir", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Cataclysm", description="Honor the flames of zones opened by the cataclysm.", mapID="Vashjir", uiMapID=203, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Cataclysm
A{"Vashjir", 6012, 0.4940, 0.4200, criterion=18199, side="horde", season="Midsummer Fire Festival", trivia={criteria="Vashj'ir", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Cataclysm", description="Honor the flames of zones opened by the cataclysm.", mapID="Vashjir", uiMapID=203, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Eastern Kingdoms
A{"WesternPlaguelands", 1022, 0.4360, 0.8230, criterion=3074, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Western Plaguelands", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="WesternPlaguelands", uiMapID=22, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Eastern Kingdoms
A{"WesternPlaguelands", 1025, 0.2900, 0.5700, criterion=23465, side="horde", season="Midsummer Fire Festival", trivia={criteria="Western Plaguelands", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="WesternPlaguelands", uiMapID=22, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"WesternPlaguelands", 1028, 0.2910, 0.5640, criterion=23468, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Western Plaguelands", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Horde's bonfires in Eastern Kingdoms.", mapID="WesternPlaguelands", uiMapID=22, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"WesternPlaguelands", 1031, 0.2900, 0.5690, criterion=3172, note="also Chillwind Camp", side="horde", season="Midsummer Fire Festival", trivia={criteria="Western Plaguelands", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Alliance's bonfires in Eastern Kingdoms.", mapID="WesternPlaguelands", uiMapID=22, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Eastern Kingdoms
A{"Westfall", 1022, 0.4470, 0.6220, criterion=3075, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Westfall", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="Westfall", uiMapID=52, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"Westfall", 1031, 0.4480, 0.6220, criterion=3173, side="horde", season="Midsummer Fire Festival", trivia={criteria="Westfall", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Alliance's bonfires in Eastern Kingdoms.", mapID="Westfall", uiMapID=52, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Eastern Kingdoms
A{"Wetlands", 1022, 0.1350, 0.4720, criterion=5078, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Wetlands", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Eastern Kingdoms", description="Honor the flames of Eastern Kingdoms.", mapID="Wetlands", uiMapID=56, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Eastern Kingdoms
A{"Wetlands", 1031, 0.1320, 0.4710, criterion=5266, side="horde", season="Midsummer Fire Festival", trivia={criteria="Wetlands", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Eastern Kingdoms", description="Desecrate the Alliance's bonfires in Eastern Kingdoms.", mapID="Wetlands", uiMapID=56, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Kalimdor
A{"Winterspring", 1023, 0.6100, 0.4700, criterion=3087, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Winterspring", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Kalimdor", description="Honor the flames of Kalimdor.", mapID="Winterspring", uiMapID=83, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Kalimdor
A{"Winterspring", 1026, 0.5900, 0.3500, criterion=3123, side="horde", season="Midsummer Fire Festival", trivia={criteria="Winterspring", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Kalimdor", description="Honor the flames of Kalimdor.", mapID="Winterspring", uiMapID=83, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Kalimdor
A{"Winterspring", 1029, 0.5800, 0.4710, criterion=3153, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Winterspring", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Kalimdor", description="Desecrate the Horde's bonfires in Kalimdor.", mapID="Winterspring", uiMapID=83, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Kalimdor
A{"Winterspring", 1032, 0.6150, 0.4700, criterion=3185, side="horde", season="Midsummer Fire Festival", trivia={criteria="Winterspring", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Kalimdor", description="Desecrate the Alliance's bonfires in Kalimdor.", mapID="Winterspring", uiMapID=83, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Outland
A{"Zangarmarsh", 1024, 0.6900, 0.5200, criterion=3095, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Zangarmarsh", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Outland", description="Honor the flames of Outland.", mapID="Zangarmarsh", uiMapID=102, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Outland
A{"Zangarmarsh", 1027, 0.3550, 0.5160, criterion=3130, side="horde", season="Midsummer Fire Festival", trivia={criteria="Zangarmarsh", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Outland", description="Honor the flames of Outland.", mapID="Zangarmarsh", uiMapID=102, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Outland
A{"Zangarmarsh", 1030, 0.3560, 0.5190, criterion=3160, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Zangarmarsh", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Outland", description="Desecrate the Horde's bonfires in Outland.", mapID="Zangarmarsh", uiMapID=102, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Outland
A{"Zangarmarsh", 1033, 0.6860, 0.5200, criterion=3192, side="horde", season="Midsummer Fire Festival", trivia={criteria="Zangarmarsh", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Outland", description="Desecrate the Alliance's bonfires in Outland.", mapID="Zangarmarsh", uiMapID=102, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Northrend
A{"ZulDrak", 6007, 0.4320, 0.7150, criterion=18167, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Zul'Drak", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Northrend", description="Desecrate the Horde's bonfires in Northrend.", mapID="ZulDrak", uiMapID=121, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Warden of Northrend
A{"ZulDrak", 6008, 0.4100, 0.6100, criterion=18178, side="alliance", season="Midsummer Fire Festival", trivia={criteria="Zul'Drak", module="seasonal_mid", category="World Events/Midsummer", name="Flame Warden of Northrend", description="Honor the flames of Northrend.", mapID="ZulDrak", uiMapID=121, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Flame Keeper of Northrend
A{"ZulDrak", 6009, 0.4300, 0.7100, criterion=18186, side="horde", season="Midsummer Fire Festival", trivia={criteria="Zul'Drak", module="seasonal_mid", category="World Events/Midsummer", name="Flame Keeper of Northrend", description="Honor the flames of Northrend.", mapID="ZulDrak", uiMapID=121, points=10, parent="World Events", type="quest"}}

-- World Events/Midsummer: Extinguishing Northrend
A{"ZulDrak", 6010, 0.4050, 0.6090, criterion=18194, side="horde", season="Midsummer Fire Festival", trivia={criteria="Zul'Drak", module="seasonal_mid", category="World Events/Midsummer", name="Extinguishing Northrend", description="Desecrate the Alliance's bonfires in Northrend.", mapID="ZulDrak", uiMapID=121, points=10, parent="World Events", type="quest"}}
