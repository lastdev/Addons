local AL = LibStub:GetLibrary("AchievementLocations-1.0")
local function A(row) AL:AddLocation(row) end

-- Pet Battles/Battle: Local Pet Mauler
A{"Arathi", 6558, criterion=21562, trivia={criteria="Arathi Highlands", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="ArathiHighlands", uiMapID=14, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Arathi", 6559, criterion=21562, trivia={criteria="Arathi Highlands", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="ArathiHighlands", uiMapID=14, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Arathi", 6560, criterion=21562, trivia={criteria="Arathi Highlands", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="ArathiHighlands", uiMapID=14, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Eastern Kingdoms Safari
A{"Arathi", 6586, 0.3900, 0.8900, criterion=21611, note="zone exclusive", trivia={criteria="Grasslands Cottontail", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="ArathiHighlands", uiMapID=14, points=5, parent="Pet Battles", type="catch"}}
A{"Arathi", 6586, 0.3900, 0.8900, criterion=21613, note="more common in Durotar", trivia={criteria="Prairie Dog", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="ArathiHighlands", uiMapID=14, points=5, parent="Pet Battles", type="catch"}}
A{"Arathi", 6586, 0.4600, 0.5200, criterion=21614, note="zone exclusive\nscarce\ncan be spawned by battling other pets in the zone", trivia={criteria="Tiny Twister", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="ArathiHighlands", uiMapID=14, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Eastern Kingdoms Tamer
A{"Arathi", 6613, criterion=21419, trivia={criteria="Arathi Highlands", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Tamer", description="Capture a battle pet in each of the Eastern Kingdoms zones listed below.", mapID="ArathiHighlands", uiMapID=14, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Ashenvale", 6558, criterion=21391, trivia={criteria="Ashenvale", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="Ashenvale", uiMapID=63, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Ashenvale", 6559, criterion=21391, trivia={criteria="Ashenvale", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="Ashenvale", uiMapID=63, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Ashenvale", 6560, criterion=21391, trivia={criteria="Ashenvale", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="Ashenvale", uiMapID=63, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Kalimdor Safari
A{"Ashenvale", 6585, 0.7000, 0.6000, criterion=21691, note="zone exclusive", trivia={criteria="Frog", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="Ashenvale", uiMapID=63, points=5, parent="Pet Battles", type="catch"}}
A{"Ashenvale", 6585, 0.1300, 0.2700, criterion=21703, note="zone exclusive", trivia={criteria="Rusty Snail", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="Ashenvale", uiMapID=63, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Kalimdor
A{"Ashenvale", 6602, 0.2000, 0.3000, criterion=21404, side="horde", trivia={criteria="Analynn", module="pet", category="Pet Battles", name="Taming Kalimdor", description="Defeat all of the Pet Tamers in Kalimdor listed below.", mapID="Ashenvale", uiMapID=63, points=5, type=158}}

-- Pet Battles/Collect: Kalimdor Tamer
A{"Ashenvale", 6612, criterion=21448, trivia={criteria="Ashenvale", module="pet", category="Pet Battles/Collect", name="Kalimdor Tamer", description="Capture a battle pet in each of the Kalimdor zones listed below.", mapID="Ashenvale", uiMapID=63, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"Ashenvale", 8348, 0.2000, 0.3000, criterion=23456, trivia={criteria="Analynn", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="Ashenvale", uiMapID=63, points=10, type="quest"}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Aszhara", 6558, criterion=21537, trivia={criteria="Azshara", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="Aszhara", points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Aszhara", 6559, criterion=21537, trivia={criteria="Azshara", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="Aszhara", points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Aszhara", 6560, criterion=21537, trivia={criteria="Azshara", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="Aszhara", points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Kalimdor Safari
A{"Aszhara", 6585, criterion=21707, note="zone exclusive\nalong coast", trivia={criteria="Turquoise Turtle", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="Aszhara", points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Kalimdor Tamer
A{"Aszhara", 6612, criterion=21449, trivia={criteria="Azshara", module="pet", category="Pet Battles/Collect", name="Kalimdor Tamer", description="Capture a battle pet in each of the Kalimdor zones listed below.", mapID="Aszhara", points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Local Pet Mauler
A{"AzuremystIsle", 6558, criterion=21546, trivia={criteria="Azuremyst Isle", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="AzuremystIsle", uiMapID=97, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"AzuremystIsle", 6559, criterion=21546, trivia={criteria="Azuremyst Isle", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="AzuremystIsle", uiMapID=97, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"AzuremystIsle", 6560, criterion=21546, trivia={criteria="Azuremyst Isle", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="AzuremystIsle", uiMapID=97, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Kalimdor Safari
A{"AzuremystIsle", 6585, criterion=21708, note="zone exclusive", trivia={criteria="Grey Moth", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="AzuremystIsle", uiMapID=97, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Kalimdor Tamer
A{"AzuremystIsle", 6612, criterion=21450, trivia={criteria="Azuremyst Isle", module="pet", category="Pet Battles/Collect", name="Kalimdor Tamer", description="Capture a battle pet in each of the Kalimdor zones listed below.", mapID="AzuremystIsle", uiMapID=97, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Badlands", 6558, criterion=21557, trivia={criteria="Badlands", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="Badlands", uiMapID=15, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Badlands", 6559, criterion=21557, trivia={criteria="Badlands", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="Badlands", uiMapID=15, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Badlands", 6560, criterion=21557, trivia={criteria="Badlands", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="Badlands", uiMapID=15, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Eastern Kingdoms Safari
A{"Badlands", 6586, 0.7000, 0.4600, criterion=21616, trivia={criteria="Gold Beetle", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="Badlands", uiMapID=15, points=5, parent="Pet Battles", type="catch"}}
A{"Badlands", 6586, criterion=21617, trivia={criteria="Rattlesnake", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="Badlands", uiMapID=15, points=5, parent="Pet Battles", type="catch"}}
A{"Badlands", 6586, 0.5900, 0.2000, criterion=21618, note="zone exclusive", trivia={criteria="King Snake", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="Badlands", uiMapID=15, points=5, parent="Pet Battles", type="catch"}}
A{"Badlands", 6586, 0.7000, 0.4600, criterion=21619, trivia={criteria="Spiky Lizard", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="Badlands", uiMapID=15, points=5, parent="Pet Battles", type="catch"}}
A{"Badlands", 6586, 0.7000, 0.4600, criterion=21620, trivia={criteria="Stripe-Tailed Scorpid", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="Badlands", uiMapID=15, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Eastern Kingdoms Tamer
A{"Badlands", 6613, criterion=21421, trivia={criteria="Badlands", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Tamer", description="Capture a battle pet in each of the Eastern Kingdoms zones listed below.", mapID="Badlands", uiMapID=15, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Barrens", 6558, criterion=21390, trivia={criteria="Northern Barrens", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="NorthernBarrens", uiMapID=10, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Barrens", 6559, criterion=21390, trivia={criteria="Northern Barrens", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="NorthernBarrens", uiMapID=10, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Barrens", 6560, criterion=21390, trivia={criteria="Northern Barrens", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="NorthernBarrens", uiMapID=10, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Kalimdor Safari
A{"Barrens", 6585, criterion=21737, note="zone exclusive", trivia={criteria="Cheetah Cub", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="NorthernBarrens", uiMapID=10, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Kalimdor
A{"Barrens", 6602, 0.5900, 0.5300, criterion=21403, side="horde", trivia={criteria="Dagra the Fierce", module="pet", category="Pet Battles", name="Taming Kalimdor", description="Defeat all of the Pet Tamers in Kalimdor listed below.", mapID="NorthernBarrens", uiMapID=10, points=5, type=158}}

-- Pet Battles/Collect: Kalimdor Tamer
A{"Barrens", 6612, criterion=21460, trivia={criteria="Northern Barrens", module="pet", category="Pet Battles/Collect", name="Kalimdor Tamer", description="Capture a battle pet in each of the Kalimdor zones listed below.", mapID="NorthernBarrens", uiMapID=10, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"Barrens", 8348, 0.5900, 0.5300, criterion=23455, trivia={criteria="Dagra the Fierce", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="NorthernBarrens", uiMapID=10, points=10, type="quest"}}

-- Pet Battles/Collect: Crazy for Cats
A{"Barrens", 8397, criterion=23581, trivia={criteria="Cheetah Cub", module="pet", category="Pet Battles/Collect", name="Crazy for Cats", description="Obtain 20 of the cats listed below.", mapID="NorthernBarrens", uiMapID=10, points=10, parent="Pet Battles", type=96}}

-- Pet Battles/Collect: So. Many. Pets.
A{"Barrens", 9643, criterion="Leaping Hatchling", trivia={criteria="Leaping Hatchling", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="NorthernBarrens", uiMapID=10, points=10, parent="Pet Battles", type=156}}

-- Pet Battles/Battle: Local Pet Mauler
A{"BladesEdgeMountains", 6558, criterion=21575, trivia={criteria="Blade's Edge Mountains", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="BladesEdgeMountains", uiMapID=105, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"BladesEdgeMountains", 6559, criterion=21575, trivia={criteria="Blade's Edge Mountains", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="BladesEdgeMountains", uiMapID=105, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"BladesEdgeMountains", 6560, criterion=21575, trivia={criteria="Blade's Edge Mountains", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="BladesEdgeMountains", uiMapID=105, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Outland Safari
A{"BladesEdgeMountains", 6587, criterion=21759, note="zone exclusive", trivia={criteria="Scalded Basilisk Hatchling", module="pet", category="Pet Battles/Collect", name="Outland Safari", description="Catch every battle pet in Outland.", mapID="BladesEdgeMountains", uiMapID=105, points=5, parent="Pet Battles", type="catch"}}
A{"BladesEdgeMountains", 6587, criterion=21758, note="zone exclusive", trivia={criteria="Skittering Cavern Crawler", module="pet", category="Pet Battles/Collect", name="Outland Safari", description="Catch every battle pet in Outland.", mapID="BladesEdgeMountains", uiMapID=105, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Outland Tamer
A{"BladesEdgeMountains", 6614, criterion=21468, trivia={criteria="Blade's Edge Mountains", module="pet", category="Pet Battles/Collect", name="Outland Tamer", description="Capture a battle pet in each of the Outland zones listed below.", mapID="BladesEdgeMountains", uiMapID=105, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Local Pet Mauler
A{"BlastedLands", 6558, criterion=21554, trivia={criteria="Blasted Lands", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="BlastedLands", uiMapID=17, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"BlastedLands", 6559, criterion=21554, trivia={criteria="Blasted Lands", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="BlastedLands", uiMapID=17, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"BlastedLands", 6560, criterion=21554, trivia={criteria="Blasted Lands", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="BlastedLands", uiMapID=17, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Kalimdor Safari
A{"BlastedLands", 6585, 0.6000, 0.6100, criterion=21623, note="zone exclusive", trivia={criteria="Scorpling", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="BlastedLands", uiMapID=17, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Eastern Kingdoms Safari
A{"BlastedLands", 6586, 0.4400, 0.2600, criterion=21509, trivia={criteria="Adder", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="BlastedLands", uiMapID=17, points=5, parent="Pet Battles", type="catch"}}
A{"BlastedLands", 6586, 0.5200, 0.1500, criterion=21623, note="zone exclusive\nonly found on top of the mesa", trivia={criteria="Scorpling", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="BlastedLands", uiMapID=17, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Eastern Kingdoms Tamer
A{"BlastedLands", 6613, criterion=21422, trivia={criteria="Blasted Lands", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Tamer", description="Capture a battle pet in each of the Eastern Kingdoms zones listed below.", mapID="BlastedLands", uiMapID=17, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Local Pet Mauler
A{"BloodmystIsle", 6558, criterion=21547, trivia={criteria="Bloodmyst Isle", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="BloodmystIsle", uiMapID=106, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"BloodmystIsle", 6559, criterion=21547, trivia={criteria="Bloodmyst Isle", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="BloodmystIsle", uiMapID=106, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"BloodmystIsle", 6560, criterion=21547, trivia={criteria="Bloodmyst Isle", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="BloodmystIsle", uiMapID=106, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Kalimdor Safari
A{"BloodmystIsle", 6585, criterion=21709, note="zone exclusive", trivia={criteria="Ravager Hatchling", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="BloodmystIsle", uiMapID=106, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Kalimdor Tamer
A{"BloodmystIsle", 6612, criterion=21451, trivia={criteria="Bloodmyst Isle", module="pet", category="Pet Battles/Collect", name="Kalimdor Tamer", description="Capture a battle pet in each of the Kalimdor zones listed below.", mapID="BloodmystIsle", uiMapID=106, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Local Pet Mauler
A{"BoreanTundra", 6558, criterion=21578, trivia={criteria="Borean Tundra", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="BoreanTundra", uiMapID=114, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"BoreanTundra", 6559, criterion=21578, trivia={criteria="Borean Tundra", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="BoreanTundra", uiMapID=114, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"BoreanTundra", 6560, criterion=21578, trivia={criteria="Borean Tundra", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="BoreanTundra", uiMapID=114, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Northrend Safari
A{"BoreanTundra", 6588, criterion=21768, note="zone exclusive", trivia={criteria="Borean Marmot", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", mapID="BoreanTundra", uiMapID=114, points=5, parent="Pet Battles", type="catch"}}
A{"BoreanTundra", 6588, criterion=21769, note="zone exclusive", trivia={criteria="Oily Slimeling", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", mapID="BoreanTundra", uiMapID=114, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Northrend Tamer
A{"BoreanTundra", 6615, criterion=21477, trivia={criteria="Borean Tundra", module="pet", category="Pet Battles/Collect", name="Northrend Tamer", description="Capture a battle pet in each of the Northrend zones listed below.", mapID="BoreanTundra", uiMapID=114, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Local Pet Mauler
A{"BurningSteppes", 6558, criterion=21555, trivia={criteria="Burning Steppes", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="BurningSteppes", uiMapID=36, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"BurningSteppes", 6559, criterion=21555, trivia={criteria="Burning Steppes", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="BurningSteppes", uiMapID=36, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"BurningSteppes", 6560, criterion=21555, trivia={criteria="Burning Steppes", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="BurningSteppes", uiMapID=36, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Eastern Kingdoms Safari
A{"BurningSteppes", 6586, 0.1900, 0.6500, criterion=21624, trivia={criteria="Ash Viper", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="BurningSteppes", uiMapID=36, points=5, parent="Pet Battles", type="catch"}}
A{"BurningSteppes", 6586, 0.3600, 0.5300, criterion=21626, note="zone exclusive", trivia={criteria="Lava Beetle", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="BurningSteppes", uiMapID=36, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Eastern Kingdoms
A{"BurningSteppes", 6603, 0.2600, 0.4800, criterion=21603, note="At the bottom of the ramp to Blackrock Mountain Pet Level: 17", side="alliance", trivia={criteria="Durin Darkhammer", module="pet", category="Pet Battles", name="Taming Eastern Kingdoms", description="Defeat all of the Pet Tamers in Eastern Kingdoms listed below.", mapID="BurningSteppes", uiMapID=36, points=5, type=158}}

-- Pet Battles/Collect: Eastern Kingdoms Tamer
A{"BurningSteppes", 6613, criterion=21423, trivia={criteria="Burning Steppes", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Tamer", description="Capture a battle pet in each of the Eastern Kingdoms zones listed below.", mapID="BurningSteppes", uiMapID=36, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"BurningSteppes", 8348, 0.2600, 0.4800, criterion=23451, trivia={criteria="Durin Darkhammer", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="BurningSteppes", uiMapID=36, points=10, type="quest"}}

-- Pet Battles/Collect: So. Many. Pets.
A{"BurningSteppes", 9643, criterion="Tiny Flamefly", trivia={criteria="Tiny Flamefly", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="BurningSteppes", uiMapID=36, points=10, parent="Pet Battles", type=156}}

-- Pet Battles: Taming Northrend
A{"CrystalsongForest", 6605, 0.5000, 0.5900, criterion=21849, trivia={criteria="Nearly Headless Jacob", module="pet", category="Pet Battles", name="Taming Northrend", description="Defeat all of the Pet Tamers in Northrend listed below.", mapID="CrystalsongForest", uiMapID=127, points=5, type=158}}

-- Pet Battles/Collect: Northrend Tamer
A{"CrystalsongForest", 6615, criterion=21478, trivia={criteria="Crystalsong Forest", module="pet", category="Pet Battles/Collect", name="Northrend Tamer", description="Capture a battle pet in each of the Northrend zones listed below.", mapID="CrystalsongForest", uiMapID=127, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"CrystalsongForest", 8348, 0.5000, 0.5900, criterion=23480, trivia={criteria="Nearly Headless Jacob", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="CrystalsongForest", uiMapID=127, points=10, type="quest"}}

-- Pet Battles/Battle: An Awfully Big Adventure
A{"CrystalsongForest", 9069, 0.5020, 0.5900, criterion=26993, trivia={criteria="Nearly Headless Jacob", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="CrystalsongForest", uiMapID=127, points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Collect: Crazy for Cats
A{"Dalaran", 8397, 0.5900, 0.4000, criterion=23579, note="from Breanni", trivia={criteria="Calico Cat", module="pet", category="Pet Battles/Collect", name="Crazy for Cats", description="Obtain 20 of the cats listed below.", mapID="Dalaran_DalaranCity", uiMapID=125, points=10, parent="Pet Battles", type=96}}
A{"DarkmoonFaireIsland", 8397, 0.4900, 0.7000, criterion=23583, note="from Lhara of Darkmoon Faire", trivia={criteria="Darkmoon Cub", module="pet", category="Pet Battles/Collect", name="Crazy for Cats", description="Obtain 20 of the cats listed below.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="Pet Battles", type=96}}

-- Pet Battles/Battle: An Awfully Big Adventure
A{"DarkmoonFaireIsland", 9069, criterion=26976, trivia={criteria="Christoph VonFeasel", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="Pet Battles", type=158}}
A{"DarkmoonFaireIsland", 9069, 0.4780, 0.6260, criterion=26986, trivia={criteria="Jeremy Feasel", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Darkshore", 6558, criterion=21536, trivia={criteria="Darkshore", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="Darkshore", uiMapID=62, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Darkshore", 6559, criterion=21536, trivia={criteria="Darkshore", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="Darkshore", uiMapID=62, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Darkshore", 6560, criterion=21536, trivia={criteria="Darkshore", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="Darkshore", uiMapID=62, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Kalimdor Safari
A{"Darkshore", 6585, 0.4300, 0.8000, criterion=21697, note="zone exclusive", trivia={criteria="Darkshore Cub", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="Darkshore", uiMapID=62, points=5, parent="Pet Battles", type="catch"}}
A{"Darkshore", 6585, criterion=21710, note="zone exclusive\nalong coast", trivia={criteria="Shimmershell Snail", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="Darkshore", uiMapID=62, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Kalimdor Tamer
A{"Darkshore", 6612, criterion=21452, trivia={criteria="Darkshore", module="pet", category="Pet Battles/Collect", name="Kalimdor Tamer", description="Capture a battle pet in each of the Kalimdor zones listed below.", mapID="Darkshore", uiMapID=62, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: So. Many. Pets.
A{"Darkshore", 9643, criterion="Withers", trivia={criteria="Withers", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="Darkshore", uiMapID=62, points=10, parent="Pet Battles", type=156}}

-- Pet Battles/Battle: Big City Pet Brawlin' - Alliance
A{"Darnassus", 6584, criterion=19847, trivia={criteria="Darnassus", module="pet", category="Pet Battles/Battle", name="Big City Pet Brawlin' - Alliance", description="Win a pet battle in each of the Alliance cities listed below.", mapID="Darnassus", uiMapID=89, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: So. Many. Pets.
A{"Darnassus", 9643, criterion="Hawk Owl", trivia={criteria="Hawk Owl", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="Darnassus", uiMapID=89, points=10, parent="Pet Battles", type=156}}
A{"Darnassus", 9643, criterion="Great Horned Owl", trivia={criteria="Great Horned Owl", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="Darnassus", uiMapID=89, points=10, parent="Pet Battles", type=156}}

-- Pet Battles/Collect: Eastern Kingdoms Safari
A{"DeadwindPass", 6586, 0.4500, 0.7300, criterion=21628, note="zone exclusive\nspawn exactly at midnight server time and despawn at 9am\nfound underground in the Master's Cellar\nuse either of the cellar entrances in the town", trivia={criteria="Restless Shadeling", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="DeadwindPass", uiMapID=42, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Eastern Kingdoms
A{"DeadwindPass", 6603, 0.4000, 0.7600, criterion=21602, side="alliance", trivia={criteria="Lydia Accoste", module="pet", category="Pet Battles", name="Taming Eastern Kingdoms", description="Defeat all of the Pet Tamers in Eastern Kingdoms listed below.", mapID="DeadwindPass", uiMapID=42, points=5, type=158}}

-- Pet Battles/Collect: Eastern Kingdoms Tamer
A{"DeadwindPass", 6613, criterion=21428, trivia={criteria="Deadwind Pass", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Tamer", description="Capture a battle pet in each of the Eastern Kingdoms zones listed below.", mapID="DeadwindPass", uiMapID=42, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"DeadwindPass", 8348, 0.4000, 0.7600, criterion=23452, trivia={criteria="Grand Master Lydia Accoste", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="DeadwindPass", uiMapID=42, points=10, type="quest"}}

-- Pet Battles/Battle: An Awfully Big Adventure
A{"DeadwindPass", 9069, 0.4020, 0.7640, criterion=26988, trivia={criteria="Lydia Accoste", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="DeadwindPass", uiMapID=42, points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Collect: So. Many. Pets.
A{"DeadwindPass", 9643, criterion="Arcane eye", trivia={criteria="Arcane eye", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="DeadwindPass", uiMapID=42, points=10, parent="Pet Battles", type=156}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Deepholm", 6558, criterion=21586, trivia={criteria="Deepholm", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="Deepholm", uiMapID=207, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Deepholm", 6559, criterion=21586, trivia={criteria="Deepholm", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="Deepholm", uiMapID=207, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Deepholm", 6560, criterion=21586, trivia={criteria="Deepholm", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="Deepholm", uiMapID=207, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Kalimdor Safari
A{"Deepholm", 6585, criterion=21711, trivia={criteria="Amethyst Shale Hatchling", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="Deepholm", uiMapID=207, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Cataclysm
A{"Deepholm", 7525, 0.5000, 0.5700, criterion=21859, trivia={criteria="Bordin Steadyfist", module="pet", category="Pet Battles", name="Taming Cataclysm", description="Defeat all of the Pet Tamers in Cataclysm listed below.", mapID="Deepholm", uiMapID=207, points=5, type=158}}

-- Pet Battles: The Longest Day
A{"Deepholm", 8348, 0.5000, 0.5700, criterion=23484, trivia={criteria="Bordin Steadyfist", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="Deepholm", uiMapID=207, points=10, type="quest"}}

-- Pet Battles/Battle: An Awfully Big Adventure
A{"Deepholm", 9069, 0.4980, 0.5700, criterion=26972, trivia={criteria="Bordin Steadyfist", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="Deepholm", uiMapID=207, points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Collect: Kalimdor Safari
A{"Desolace", 6585, criterion=21715, trivia={criteria="Horny Toad", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="Desolace", uiMapID=66, points=5, parent="Pet Battles", type="catch"}}
A{"Desolace", 6585, 0.7200, 0.4400, criterion=21717, note="zone exclusive\nat night", trivia={criteria="Stone Armadillo", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="Desolace", uiMapID=66, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Kalimdor
A{"Desolace", 6602, 0.5700, 0.4600, criterion=21406, side="horde", trivia={criteria="Merda Stronghoof", module="pet", category="Pet Battles", name="Taming Kalimdor", description="Defeat all of the Pet Tamers in Kalimdor listed below.", mapID="Desolace", uiMapID=66, points=5, type=158}}

-- Pet Battles/Collect: Kalimdor Tamer
A{"Desolace", 6612, criterion=21453, trivia={criteria="Desolace", module="pet", category="Pet Battles/Collect", name="Kalimdor Tamer", description="Capture a battle pet in each of the Kalimdor zones listed below.", mapID="Desolace", uiMapID=66, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"Desolace", 8348, 0.5700, 0.4600, criterion=23459, trivia={criteria="Merda Stronghoof", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="Desolace", uiMapID=66, points=10, type="quest"}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Dragonblight", 6558, criterion=21580, trivia={criteria="Dragonblight", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="Dragonblight", uiMapID=115, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Dragonblight", 6559, criterion=21580, trivia={criteria="Dragonblight", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="Dragonblight", uiMapID=115, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Dragonblight", 6560, criterion=21580, trivia={criteria="Dragonblight", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="Dragonblight", uiMapID=115, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Northrend Safari
A{"Dragonblight", 6588, criterion=21771, note="zone exclusive", trivia={criteria="Dragonbone Hatchling", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", mapID="Dragonblight", uiMapID=115, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Northrend
A{"Dragonblight", 6605, 0.5900, 0.7700, criterion=21850, trivia={criteria="Okrut Dragonwaste", module="pet", category="Pet Battles", name="Taming Northrend", description="Defeat all of the Pet Tamers in Northrend listed below.", mapID="Dragonblight", uiMapID=115, points=5, type=158}}

-- Pet Battles/Collect: Northrend Tamer
A{"Dragonblight", 6615, criterion=21479, trivia={criteria="Dragonblight", module="pet", category="Pet Battles/Collect", name="Northrend Tamer", description="Capture a battle pet in each of the Northrend zones listed below.", mapID="Dragonblight", uiMapID=115, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"Dragonblight", 8348, 0.5900, 0.7700, criterion=23479, trivia={criteria="Okrut Dragonwaste", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="Dragonblight", uiMapID=115, points=10, type="quest"}}

-- Pet Battles/Battle: An Awfully Big Adventure
A{"Dragonblight", 9069, 0.5900, 0.7700, criterion=26996, trivia={criteria="Okrut Dragonwaste", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="Dragonblight", uiMapID=115, points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Battle: Local Pet Mauler
A{"DreadWastes", 6558, criterion=21591, trivia={criteria="Dread Wastes", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="DreadWastes", uiMapID=422, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"DreadWastes", 6559, criterion=21591, trivia={criteria="Dread Wastes", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="DreadWastes", uiMapID=422, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"DreadWastes", 6560, criterion=21591, trivia={criteria="Dread Wastes", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="DreadWastes", uiMapID=422, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Pandaria Safari
A{"DreadWastes", 6589, criterion=21832, note="zone exclusive", trivia={criteria="Amber Moth", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="DreadWastes", uiMapID=422, points=5, parent="Pet Battles", type="catch"}}
A{"DreadWastes", 6589, criterion=21838, note="zone exclusive", trivia={criteria="Clouded Hedgehog", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="DreadWastes", uiMapID=422, points=5, parent="Pet Battles", type="catch"}}
A{"DreadWastes", 6589, criterion=21839, note="zone exclusive", trivia={criteria="Crunchy Scorpion", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="DreadWastes", uiMapID=422, points=5, parent="Pet Battles", type="catch"}}
A{"DreadWastes", 6589, criterion=21841, note="zone exclusive", trivia={criteria="Rapana Whelk", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="DreadWastes", uiMapID=422, points=5, parent="Pet Battles", type="catch"}}
A{"DreadWastes", 6589, criterion=21842, note="zone exclusive", trivia={criteria="Silent Hedgehog", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="DreadWastes", uiMapID=422, points=5, parent="Pet Battles", type="catch"}}
A{"DreadWastes", 6589, criterion=21843, note="zone exclusive", trivia={criteria="Resilient Roach", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="DreadWastes", uiMapID=422, points=5, parent="Pet Battles", type="catch"}}
A{"DreadWastes", 6589, criterion=21840, note="zone exclusive", trivia={criteria="Emperor Crab", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="DreadWastes", uiMapID=422, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Pandaria
A{"DreadWastes", 6606, 0.5500, 0.3700, criterion=21856, trivia={criteria="Wastewalker Shu", module="pet", category="Pet Battles", name="Taming Pandaria", description="Defeat all of the Pet Tamers in Pandaria listed below.", mapID="DreadWastes", uiMapID=422, points=5, type=158}}

-- Pet Battles/Collect: Pandaria Tamer
A{"DreadWastes", 6616, criterion=21494, trivia={criteria="Dread Wastes", module="pet", category="Pet Battles/Collect", name="Pandaria Tamer", description="Capture a battle pet in each of the Pandaria zones listed below.", mapID="DreadWastes", uiMapID=422, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"DreadWastes", 8348, 0.5500, 0.3700, criterion=23492, trivia={criteria="Grand Master Shu", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="DreadWastes", uiMapID=422, points=10, type="quest"}}
A{"DreadWastes", 8348, 0.6100, 0.8800, criterion=23494, trivia={criteria="Flowing Pandaren Spirit", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="DreadWastes", uiMapID=422, points=10, type="quest"}}
A{"DreadWastes", 8348, 0.2600, 0.5000, criterion=23500, note="[3 beasts]", trivia={criteria="Gorespine", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="DreadWastes", uiMapID=422, points=10, type="quest"}}

-- Pet Battles/Battle: An Awfully Big Adventure
A{"DreadWastes", 9069, 0.6120, 0.8760, criterion=26981, trivia={criteria="Flowing Pandaren Spirit", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="DreadWastes", uiMapID=422, points=10, parent="Pet Battles", type=158}}
A{"DreadWastes", 9069, 0.5500, 0.3740, criterion=27007, trivia={criteria="Wastewalker Shu", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="DreadWastes", uiMapID=422, points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Battle: Local Pet Mauler
A{"DunMorogh", 6558, criterion=21558, trivia={criteria="Dun Morogh", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="DunMorogh", uiMapID=27, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"DunMorogh", 6559, criterion=21558, trivia={criteria="Dun Morogh", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="DunMorogh", uiMapID=27, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"DunMorogh", 6560, criterion=21558, trivia={criteria="Dun Morogh", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="DunMorogh", uiMapID=27, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Eastern Kingdoms Safari
A{"DunMorogh", 6586, 0.5800, 0.3600, criterion=21510, trivia={criteria="Alpine Hare", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="DunMorogh", uiMapID=27, points=5, parent="Pet Battles", type="catch"}}
A{"DunMorogh", 6586, 0.2800, 0.3400, criterion=21507, note="zone exclusive", trivia={criteria="Irradiated Roach", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="DunMorogh", uiMapID=27, points=5, parent="Pet Battles", type="catch"}}
A{"DunMorogh", 6586, 0.3200, 0.7800, criterion=21516, trivia={criteria="Rat", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="DunMorogh", uiMapID=27, points=5, parent="Pet Battles", type="catch"}}
A{"DunMorogh", 6586, 0.5800, 0.3600, criterion=21520, note="zone exclusive", trivia={criteria="Snow Cub", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="DunMorogh", uiMapID=27, points=5, parent="Pet Battles", type="catch"}}
A{"DunMorogh", 6586, 0.3500, 0.4700, criterion=21653, note="zone exclusive\nonly found in daylight (until 9pm) usually on top of hills", trivia={criteria="Little Black Ram", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="DunMorogh", uiMapID=27, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Crazy for Cats
A{"DunMorogh", 8397, criterion=23593, trivia={criteria="Snow Cub", module="pet", category="Pet Battles/Collect", name="Crazy for Cats", description="Obtain 20 of the cats listed below.", mapID="DunMorogh", uiMapID=27, points=10, parent="Pet Battles", type=96}}
A{"DunMorogh", 8397, 0.2800, 0.3500, criterion=23585, trivia={criteria="Fluxfire Feline", module="pet", category="Pet Battles/Collect", name="Crazy for Cats", description="Obtain 20 of the cats listed below.", mapID="DunMorogh", uiMapID=27, points=10, parent="Pet Battles", type=96}}

-- Pet Battles/Collect: So. Many. Pets.
A{"DunMorogh", 9643, 0.7100, 0.4800, criterion="Rabbit Crate (Snowshoe)", item="7560", note="from Milli Featherwhistle\nGnomeregon exalted", trivia={criteria="Rabbit Crate (Snowshoe)", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="DunMorogh", uiMapID=27, points=10, parent="Pet Battles", type=156}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Durotar", 6558, criterion=21379, trivia={criteria="Durotar", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="Durotar", uiMapID=1, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Durotar", 6559, criterion=21389, trivia={criteria="Durotar", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="Durotar", uiMapID=1, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Durotar", 6560, criterion=21389, trivia={criteria="Durotar", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="Durotar", uiMapID=1, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Kalimdor Safari
A{"Durotar", 6585, criterion=21698, note="zone exclusive", trivia={criteria="Creepy Crawly", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="Durotar", uiMapID=1, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Kalimdor
A{"Durotar", 6602, 0.4400, 0.2900, criterion=21402, side="horde", trivia={criteria="Zunta", module="pet", category="Pet Battles", name="Taming Kalimdor", description="Defeat all of the Pet Tamers in Kalimdor listed below.", mapID="Durotar", uiMapID=1, points=5, type=158}}

-- Pet Battles/Collect: Kalimdor Tamer
A{"Durotar", 6612, criterion=21454, trivia={criteria="Durotar", module="pet", category="Pet Battles/Collect", name="Kalimdor Tamer", description="Capture a battle pet in each of the Kalimdor zones listed below.", mapID="Durotar", uiMapID=1, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"Durotar", 8348, 0.4400, 0.2900, criterion=23454, trivia={criteria="Zunta", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="Durotar", uiMapID=1, points=10, type="quest"}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Duskwood", 6558, criterion=21551, trivia={criteria="Duskwood", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="Duskwood", uiMapID=47, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Duskwood", 6559, criterion=21551, trivia={criteria="Duskwood", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="Duskwood", uiMapID=47, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Duskwood", 6560, criterion=21551, trivia={criteria="Duskwood", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="Duskwood", uiMapID=47, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Eastern Kingdoms Safari
A{"Duskwood", 6586, 0.1900, 0.4100, criterion=21511, trivia={criteria="Black Rat", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="Duskwood", uiMapID=47, points=5, parent="Pet Battles", type="catch"}}
A{"Duskwood", 6586, 0.5600, 0.1600, criterion=21630, note="zone exclusive", trivia={criteria="Dusk Spiderling", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="Duskwood", uiMapID=47, points=5, parent="Pet Battles", type="catch"}}
A{"Duskwood", 6586, 0.7400, 0.4700, criterion=21629, note="south of Darkshire in the fields", trivia={criteria="Chicken", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="Duskwood", uiMapID=47, points=5, parent="Pet Battles", type="catch"}}
A{"Duskwood", 6586, criterion=21632, note="zone exclusive\nrare can appear as a secondary pet when battling Dusk Spiderlings or Roaches", trivia={criteria="Rat Snake", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="Duskwood", uiMapID=47, points=5, parent="Pet Battles", type="catch"}}
A{"Duskwood", 6586, 0.7400, 0.4700, criterion=21631, note="around the town square", trivia={criteria="Mouse", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="Duskwood", uiMapID=47, points=5, parent="Pet Battles", type="catch"}}
A{"Duskwood", 6586, 0.5600, 0.1600, criterion=21633, trivia={criteria="Skunk", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="Duskwood", uiMapID=47, points=5, parent="Pet Battles", type="catch"}}
A{"Duskwood", 6586, 0.1900, 0.4100, criterion=21634, note="zone exclusive\neastwards toward Twilight Grove, more common at night", trivia={criteria="Widow Spiderling", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="Duskwood", uiMapID=47, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Eastern Kingdoms
A{"Duskwood", 6603, 0.2000, 0.4500, criterion=21399, note="Next to the statue. Pet Level: 7", side="alliance", trivia={criteria="Eric Davidson", module="pet", category="Pet Battles", name="Taming Eastern Kingdoms", description="Defeat all of the Pet Tamers in Eastern Kingdoms listed below.", mapID="Duskwood", uiMapID=47, points=5, type=158}}

-- Pet Battles/Collect: Eastern Kingdoms Tamer
A{"Duskwood", 6613, criterion=21386, trivia={criteria="Duskwood", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Tamer", description="Capture a battle pet in each of the Eastern Kingdoms zones listed below.", mapID="Duskwood", uiMapID=47, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"Duskwood", 8348, 0.2000, 0.4500, criterion=23444, trivia={criteria="Eric Davidson", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="Duskwood", uiMapID=47, points=10, type="quest"}}

-- Pet Battles/Collect: So. Many. Pets.
A{"Duskwood", 9643, criterion="Rat Snake", trivia={criteria="Rat Snake", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="Duskwood", uiMapID=47, points=10, parent="Pet Battles", type=156}}
A{"Duskwood", 9643, criterion="Mouse", trivia={criteria="Mouse", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="Duskwood", uiMapID=47, points=10, parent="Pet Battles", type=156}}
A{"Duskwood", 9643, criterion="Chicken Egg", trivia={criteria="Chicken Egg", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="Duskwood", uiMapID=47, points=10, parent="Pet Battles", type=156}}
A{"Duskwood", 9643, criterion="Skunk", trivia={criteria="Skunk", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="Duskwood", uiMapID=47, points=10, parent="Pet Battles", type=156}}
A{"Duskwood", 9643, criterion="Dusk Spiderling", trivia={criteria="Dusk Spiderling", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="Duskwood", uiMapID=47, points=10, parent="Pet Battles", type=156}}
A{"Duskwood", 9643, criterion="Black Rat", trivia={criteria="Black Rat", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="Duskwood", uiMapID=47, points=10, parent="Pet Battles", type=156}}
A{"Duskwood", 9643, criterion="Widow Spiderling", trivia={criteria="Widow Spiderling", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="Duskwood", uiMapID=47, points=10, parent="Pet Battles", type=156}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Dustwallow", 6558, criterion=21544, trivia={criteria="Dustwallow Marsh", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="DustwallowMarsh", uiMapID=70, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Dustwallow", 6559, criterion=21544, trivia={criteria="Dustwallow Marsh", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="DustwallowMarsh", uiMapID=70, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Dustwallow", 6560, criterion=21544, trivia={criteria="Dustwallow Marsh", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="DustwallowMarsh", uiMapID=70, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles: Taming Kalimdor
A{"Dustwallow", 6602, 0.5400, 0.7500, criterion=21410, side="horde", trivia={criteria="Grazzle the Great", module="pet", category="Pet Battles", name="Taming Kalimdor", description="Defeat all of the Pet Tamers in Kalimdor listed below.", mapID="DustwallowMarsh", uiMapID=70, points=5, type=158}}

-- Pet Battles/Collect: Kalimdor Tamer
A{"Dustwallow", 6612, criterion=21455, trivia={criteria="Dustwallow Marsh", module="pet", category="Pet Battles/Collect", name="Kalimdor Tamer", description="Capture a battle pet in each of the Kalimdor zones listed below.", mapID="DustwallowMarsh", uiMapID=70, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"Dustwallow", 8348, 0.5400, 0.7500, criterion=23461, trivia={criteria="Grazzle the Great", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="DustwallowMarsh", uiMapID=70, points=10, type="quest"}}

-- Pet Battles/Battle: Local Pet Mauler
A{"EasternPlaguelands", 6558, criterion=21567, trivia={criteria="Eastern Plaguelands", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="EasternPlaguelands", uiMapID=23, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"EasternPlaguelands", 6559, criterion=21567, trivia={criteria="Eastern Plaguelands", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="EasternPlaguelands", uiMapID=23, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"EasternPlaguelands", 6560, criterion=21567, trivia={criteria="Eastern Plaguelands", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="EasternPlaguelands", uiMapID=23, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Eastern Kingdoms Safari
A{"EasternPlaguelands", 6586, 0.3500, 0.6800, criterion=21622, note="common second pet from here to the end of the zone", trivia={criteria="Scorpid", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="EasternPlaguelands", uiMapID=23, points=5, parent="Pet Battles", type="catch"}}
A{"EasternPlaguelands", 6586, 0.0700, 0.6400, criterion=21635, trivia={criteria="Bat", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="EasternPlaguelands", uiMapID=23, points=5, parent="Pet Battles", type="catch"}}
A{"EasternPlaguelands", 6586, 0.3400, 0.8300, criterion=21636, note="zone exclusive", trivia={criteria="Festering Maggot", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="EasternPlaguelands", uiMapID=23, points=5, parent="Pet Battles", type="catch"}}
A{"EasternPlaguelands", 6586, 0.0700, 0.6400, criterion=21638, trivia={criteria="Infected Squirrel", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="EasternPlaguelands", uiMapID=23, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Eastern Kingdoms
A{"EasternPlaguelands", 6603, 0.6700, 0.5200, criterion=21599, note="on the northeast bank of the lake.  Pet level: 14", side="alliance", trivia={criteria="Deiza Plaguehorn", module="pet", category="Pet Battles", name="Taming Eastern Kingdoms", description="Defeat all of the Pet Tamers in Eastern Kingdoms listed below.", mapID="EasternPlaguelands", uiMapID=23, points=5, type=158}}

-- Pet Battles/Collect: Eastern Kingdoms Tamer
A{"EasternPlaguelands", 6613, criterion=21430, trivia={criteria="Eastern Plaguelands", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Tamer", description="Capture a battle pet in each of the Eastern Kingdoms zones listed below.", mapID="EasternPlaguelands", uiMapID=23, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"EasternPlaguelands", 8348, 0.6700, 0.5200, criterion=23448, trivia={criteria="Deiza Plaguehorn", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="EasternPlaguelands", uiMapID=23, points=10, type="quest"}}

-- Pet Battles/Collect: So. Many. Pets.
A{"EasternPlaguelands", 9643, criterion="Mr. Grubbs", item="50586", trivia={criteria="Mr. Grubbs", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="EasternPlaguelands", uiMapID=23, points=10, parent="Pet Battles", type=156}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Elwynn", 6558, criterion=21548, trivia={criteria="Elwynn Forest", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="ElwynnForest", uiMapID=37, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Elwynn", 6559, criterion=21548, trivia={criteria="Elwynn Forest", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="ElwynnForest", uiMapID=37, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Elwynn", 6560, criterion=21548, trivia={criteria="Elwynn Forest", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="ElwynnForest", uiMapID=37, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Eastern Kingdoms Safari
A{"Elwynn", 6586, criterion=21508, trivia={criteria="Rabbit", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="ElwynnForest", uiMapID=37, points=5, parent="Pet Battles", type="catch"}}
A{"Elwynn", 6586, 0.2400, 0.7600, criterion=21518, trivia={criteria="Small Frog", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="ElwynnForest", uiMapID=37, points=5, parent="Pet Battles", type="catch"}}
A{"Elwynn", 6586, criterion=21522, trivia={criteria="Squirrel", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="ElwynnForest", uiMapID=37, points=5, parent="Pet Battles", type="catch"}}
A{"Elwynn", 6586, 0.4200, 0.6500, criterion=21610, note="around Donni Anthania's house", trivia={criteria="Cat", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="ElwynnForest", uiMapID=37, points=5, parent="Pet Battles", type="catch"}}
A{"Elwynn", 6586, 0.4200, 0.6500, criterion=21639, note="in between Donnia Anthania's house and Goldshire", trivia={criteria="Fawn", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="ElwynnForest", uiMapID=37, points=5, parent="Pet Battles", type="catch"}}
A{"Elwynn", 6586, criterion=21641, trivia={criteria="Stormwind Rat", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="ElwynnForest", uiMapID=37, points=5, parent="Pet Battles", type="catch"}}
A{"Elwynn", 6586, criterion=22886, note="zone exclusive", trivia={criteria="Black Lamb", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="ElwynnForest", uiMapID=37, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Outland Safari
A{"Elwynn", 6587, criterion=21508, trivia={criteria="Rabbit", module="pet", category="Pet Battles/Collect", name="Outland Safari", description="Catch every battle pet in Outland.", mapID="ElwynnForest", uiMapID=37, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Eastern Kingdoms
A{"Elwynn", 6603, 0.4200, 0.8400, criterion=21396, note="North-east corner. Pet Level 2", side="alliance", trivia={criteria="Julia Stevens", module="pet", category="Pet Battles", name="Taming Eastern Kingdoms", description="Defeat all of the Pet Tamers in Eastern Kingdoms listed below.", mapID="ElwynnForest", uiMapID=37, points=5, type=158}}

-- Pet Battles/Collect: Eastern Kingdoms Tamer
A{"Elwynn", 6613, criterion=21380, trivia={criteria="Elwynn Forest", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Tamer", description="Capture a battle pet in each of the Eastern Kingdoms zones listed below.", mapID="ElwynnForest", uiMapID=37, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"Elwynn", 8348, 0.4200, 0.8400, criterion=23418, trivia={criteria="Julia Stevens", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="ElwynnForest", uiMapID=37, points=10, type="quest"}}

-- Pet Battles/Collect: Crazy for Cats
A{"Elwynn", 8397, 0.4400, 0.5300, criterion=23578, note="from Donni Anthania", trivia={criteria="Bombay Cat", module="pet", category="Pet Battles/Collect", name="Crazy for Cats", description="Obtain 20 of the cats listed below.", mapID="ElwynnForest", uiMapID=37, points=10, parent="Pet Battles", type=96}}
A{"Elwynn", 8397, criterion=23580, trivia={criteria="Cat", module="pet", category="Pet Battles/Collect", name="Crazy for Cats", description="Obtain 20 of the cats listed below.", mapID="ElwynnForest", uiMapID=37, points=10, parent="Pet Battles", type=96}}
A{"Elwynn", 8397, 0.4400, 0.5300, criterion=23582, note="from Donni Anthania", trivia={criteria="Cornish Rex Cat", module="pet", category="Pet Battles/Collect", name="Crazy for Cats", description="Obtain 20 of the cats listed below.", mapID="ElwynnForest", uiMapID=37, points=10, parent="Pet Battles", type=96}}
A{"Elwynn", 8397, 0.3200, 0.5000, criterion=23584, note="from Dorothy during Hallow's End", trivia={criteria="Feline Familiar", module="pet", category="Pet Battles/Collect", name="Crazy for Cats", description="Obtain 20 of the cats listed below.", mapID="ElwynnForest", uiMapID=37, points=10, parent="Pet Battles", type=96}}
A{"Elwynn", 8397, 0.4400, 0.5300, criterion=23587, note="from Donni Anthania", trivia={criteria="Orange Tabby Cat", module="pet", category="Pet Battles/Collect", name="Crazy for Cats", description="Obtain 20 of the cats listed below.", mapID="ElwynnForest", uiMapID=37, points=10, parent="Pet Battles", type=96}}
A{"Elwynn", 8397, 0.4400, 0.5300, criterion=23592, note="from Donni Anthania", trivia={criteria="Silver Tabby Cat", module="pet", category="Pet Battles/Collect", name="Crazy for Cats", description="Obtain 20 of the cats listed below.", mapID="ElwynnForest", uiMapID=37, points=10, parent="Pet Battles", type=96}}

-- Pet Battles/Collect: So. Many. Pets.
A{"Elwynn", 9643, criterion="Black Lamb", trivia={criteria="Black Lamb", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="ElwynnForest", uiMapID=37, points=10, parent="Pet Battles", type=156}}
A{"Elwynn", 9643, 0.4200, 0.6500, criterion="Cat Carrier (Bombay)", note="from Donni Anthania", trivia={criteria="Cat Carrier (Bombay)", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="ElwynnForest", uiMapID=37, points=10, parent="Pet Battles", type=156}}
A{"Elwynn", 9643, 0.4200, 0.6500, criterion="Cat Carrier (Cornish Rex)", note="from Donni Anthania", trivia={criteria="Cat Carrier (Cornish Rex)", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="ElwynnForest", uiMapID=37, points=10, parent="Pet Battles", type=156}}
A{"Elwynn", 9643, 0.4200, 0.6500, criterion="Cat Carrier (Orange Tabby)", note="from Donni Anthania", trivia={criteria="Cat Carrier (Orange Tabby)", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="ElwynnForest", uiMapID=37, points=10, parent="Pet Battles", type=156}}
A{"Elwynn", 9643, 0.4200, 0.6500, criterion="Cat Carrier (Silver Tabby)", note="from Donni Anthania", trivia={criteria="Cat Carrier (Silver Tabby)", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="ElwynnForest", uiMapID=37, points=10, parent="Pet Battles", type=156}}
A{"Elwynn", 9643, 0.4200, 0.6500, criterion="Cat", note="around Donni Anthania", trivia={criteria="Cat", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="ElwynnForest", uiMapID=37, points=10, parent="Pet Battles", type=156}}
A{"Elwynn", 9643, criterion="Fawn", trivia={criteria="Fawn", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="ElwynnForest", uiMapID=37, points=10, parent="Pet Battles", type=156}}
A{"Elwynn", 9643, criterion="Stormwind Rat", trivia={criteria="Stormwind Rat", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="ElwynnForest", uiMapID=37, points=10, parent="Pet Battles", type=156}}
A{"Elwynn", 9643, criterion="Small Frog", trivia={criteria="Small Frog", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="ElwynnForest", uiMapID=37, points=10, parent="Pet Battles", type=156}}

-- Pet Battles/Battle: Local Pet Mauler
A{"EversongWoods", 6558, criterion=21570, trivia={criteria="Eversong Woods", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="EversongWoods", uiMapID=94, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"EversongWoods", 6559, criterion=21570, trivia={criteria="Eversong Woods", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="EversongWoods", uiMapID=94, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"EversongWoods", 6560, criterion=21570, trivia={criteria="Eversong Woods", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="EversongWoods", uiMapID=94, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Eastern Kingdoms Safari
A{"EversongWoods", 6586, criterion=21644, note="zone exclusive", trivia={criteria="Ruby Sapling", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="EversongWoods", uiMapID=94, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Eastern Kingdoms Tamer
A{"EversongWoods", 6613, criterion=21432, trivia={criteria="Eversong Woods", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Tamer", description="Capture a battle pet in each of the Eastern Kingdoms zones listed below.", mapID="EversongWoods", uiMapID=94, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Felwood", 6558, criterion=21539, trivia={criteria="Felwood", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="Felwood", uiMapID=77, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Felwood", 6559, criterion=21539, trivia={criteria="Felwood", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="Felwood", uiMapID=77, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Felwood", 6560, criterion=21539, trivia={criteria="Felwood", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="Felwood", uiMapID=77, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Kalimdor Safari
A{"Felwood", 6585, 0.4500, 0.4200, criterion=21722, note="zone exclusive", trivia={criteria="Minfernal", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="Felwood", uiMapID=77, points=5, parent="Pet Battles", type="catch"}}
A{"Felwood", 6585, criterion=21725, note="zone exclusive", trivia={criteria="Tainted Rat", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="Felwood", uiMapID=77, points=5, parent="Pet Battles", type="catch"}}
A{"Felwood", 6585, criterion=21724, note="zone exclusive", trivia={criteria="Tainted Moth", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="Felwood", uiMapID=77, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Kalimdor
A{"Felwood", 6602, 0.4000, 0.5700, criterion=21411, side="horde", trivia={criteria="Zoltan", module="pet", category="Pet Battles", name="Taming Kalimdor", description="Defeat all of the Pet Tamers in Kalimdor listed below.", mapID="Felwood", uiMapID=77, points=5, type=158}}

-- Pet Battles/Collect: Kalimdor Tamer
A{"Felwood", 6612, criterion=21456, trivia={criteria="Felwood", module="pet", category="Pet Battles/Collect", name="Kalimdor Tamer", description="Capture a battle pet in each of the Kalimdor zones listed below.", mapID="Felwood", uiMapID=77, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"Felwood", 8348, 0.4000, 0.5700, criterion=23463, trivia={criteria="Zoltan", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="Felwood", uiMapID=77, points=10, type="quest"}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Feralas", 6558, criterion=21392, trivia={criteria="Feralas", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="Feralas", uiMapID=69, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Feralas", 6559, criterion=21392, trivia={criteria="Feralas", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="Feralas", uiMapID=69, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Feralas", 6560, criterion=21392, trivia={criteria="Feralas", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="Feralas", uiMapID=69, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Kalimdor Safari
A{"Feralas", 6585, 0.6400, 0.3400, criterion=21726, note="zone exclusive", trivia={criteria="Nether Faerie Dragon", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="Feralas", uiMapID=69, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Kalimdor
A{"Feralas", 6602, 0.6000, 0.5000, criterion=21407, side="horde", trivia={criteria="Traitor Gluk", module="pet", category="Pet Battles", name="Taming Kalimdor", description="Defeat all of the Pet Tamers in Kalimdor listed below.", mapID="Feralas", uiMapID=69, points=5, type=158}}

-- Pet Battles/Collect: Kalimdor Tamer
A{"Feralas", 6612, criterion=21457, trivia={criteria="Feralas", module="pet", category="Pet Battles/Collect", name="Kalimdor Tamer", description="Capture a battle pet in each of the Kalimdor zones listed below.", mapID="Feralas", uiMapID=69, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"Feralas", 8348, 0.6000, 0.5000, criterion=23458, trivia={criteria="Traitor Gluk", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="Feralas", uiMapID=69, points=10, type="quest"}}

-- Pet Battles/Battle: An Awfully Big Adventure
A{"FrostfireRidge", 9069, 0.6860, 0.6460, criterion=26982, trivia={criteria="Gargra", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="FrostfireRidge", uiMapID=525, points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Collect: Draenor Safari
A{"FrostfireRidge", 9685, criterion=27017, note="zone exclusive", trivia={criteria="Frostfur Rat", module="pet", category="Pet Battles/Collect", name="Draenor Safari", description="Catch every battle pet in Draenor.", mapID="FrostfireRidge", uiMapID=525, points=5, parent="Pet Battles", type="catch"}}
A{"FrostfireRidge", 9685, criterion=27252, note="zone exclusive", trivia={criteria="Icespine Hatchling", module="pet", category="Pet Battles/Collect", name="Draenor Safari", description="Catch every battle pet in Draenor.", mapID="FrostfireRidge", uiMapID=525, points=5, parent="Pet Battles", type="catch"}}
A{"FrostfireRidge", 9685, criterion=27263, note="zone exclusive", trivia={criteria="Frostshell Pincher", module="pet", category="Pet Battles/Collect", name="Draenor Safari", description="Catch every battle pet in Draenor.", mapID="FrostfireRidge", uiMapID=525, points=5, parent="Pet Battles", type="catch"}}
A{"FrostfireRidge", 9685, criterion=27264, note="zone exclusive", trivia={criteria="Ironclaw Scuttler", module="pet", category="Pet Battles/Collect", name="Draenor Safari", description="Catch every battle pet in Draenor.", mapID="FrostfireRidge", uiMapID=525, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Draenor
A{"FrostfireRidge", 9724, 0.6860, 0.6480, criterion=27013, trivia={criteria="Gargra", module="pet", category="Pet Battles", name="Taming Draenor", description="Defeat all of the Pet Tamers in Draenor listed below.", mapID="FrostfireRidge", uiMapID=525, points=5, type=158}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Ghostlands", 6558, criterion=21569, trivia={criteria="Ghostlands", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="Ghostlands", uiMapID=95, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Ghostlands", 6559, criterion=21569, trivia={criteria="Ghostlands", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="Ghostlands", uiMapID=95, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Ghostlands", 6560, criterion=21569, trivia={criteria="Ghostlands", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="Ghostlands", uiMapID=95, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Eastern Kingdoms Safari
A{"Ghostlands", 6586, 0.1900, 0.4300, criterion=21648, note="zone exclusive\non the coast between Windrunner and Goldenmist", trivia={criteria="Spirit Crab", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="Ghostlands", uiMapID=95, points=5, parent="Pet Battles", type="catch"}}
A{"Ghostlands", 6586, 0.4700, 0.7800, criterion=21647, note="zone exclusive\noften as a secondary pet to Maggots and Spirit Crabs", trivia={criteria="Larva", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="Ghostlands", uiMapID=95, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Eastern Kingdoms Tamer
A{"Ghostlands", 6613, criterion=21433, trivia={criteria="Ghostlands", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Tamer", description="Capture a battle pet in each of the Eastern Kingdoms zones listed below.", mapID="Ghostlands", uiMapID=95, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: An Awfully Big Adventure
A{"Gorgrond", 9069, 0.5100, 0.7060, criterion=26978, trivia={criteria="Cymre Brightblade", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="Gorgrond", uiMapID=543, points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Collect: Draenor Safari
A{"Gorgrond", 9685, criterion=27254, note="zone exclusive", trivia={criteria="Wood Wasp", module="pet", category="Pet Battles/Collect", name="Draenor Safari", description="Catch every battle pet in Draenor.", mapID="Gorgrond", uiMapID=543, points=5, parent="Pet Battles", type="catch"}}
A{"Gorgrond", 9685, criterion=27256, note="zone exclusive", trivia={criteria="Amberbarb Wasp", module="pet", category="Pet Battles/Collect", name="Draenor Safari", description="Catch every battle pet in Draenor.", mapID="Gorgrond", uiMapID=543, points=5, parent="Pet Battles", type="catch"}}
A{"Gorgrond", 9685, criterion=27258, note="zone exclusive", trivia={criteria="Junglebeak", module="pet", category="Pet Battles/Collect", name="Draenor Safari", description="Catch every battle pet in Draenor.", mapID="Gorgrond", uiMapID=543, points=5, parent="Pet Battles", type="catch"}}
A{"Gorgrond", 9685, criterion=27259, note="zone exclusive", trivia={criteria="Axebeak Hatchling", module="pet", category="Pet Battles/Collect", name="Draenor Safari", description="Catch every battle pet in Draenor.", mapID="Gorgrond", uiMapID=543, points=5, parent="Pet Battles", type="catch"}}
A{"Gorgrond", 9685, criterion=27275, note="zone exclusive", trivia={criteria="Mudback Calf", module="pet", category="Pet Battles/Collect", name="Draenor Safari", description="Catch every battle pet in Draenor.", mapID="Gorgrond", uiMapID=543, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Draenor
A{"Gorgrond", 9724, 0.5100, 0.7100, criterion=27011, trivia={criteria="Cymre Brightblade", module="pet", category="Pet Battles", name="Taming Draenor", description="Defeat all of the Pet Tamers in Draenor listed below.", mapID="Gorgrond", uiMapID=543, points=5, type=158}}

-- Pet Battles/Battle: Local Pet Mauler
A{"GrizzlyHills", 6558, criterion=21582, trivia={criteria="Grizzly Hills", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="GrizzlyHills", uiMapID=116, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"GrizzlyHills", 6559, criterion=21582, trivia={criteria="Grizzly Hills", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="GrizzlyHills", uiMapID=116, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"GrizzlyHills", 6560, criterion=21582, trivia={criteria="Grizzly Hills", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="GrizzlyHills", uiMapID=116, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Northrend Safari
A{"GrizzlyHills", 6588, criterion=21772, note="zone exclusive", trivia={criteria="Imperial Eagle Chick", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", mapID="GrizzlyHills", uiMapID=116, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Northrend Tamer
A{"GrizzlyHills", 6615, criterion=21480, trivia={criteria="Grizzly Hills", module="pet", category="Pet Battles/Collect", name="Northrend Tamer", description="Capture a battle pet in each of the Northrend zones listed below.", mapID="GrizzlyHills", uiMapID=116, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Hellfire", 6558, criterion=21571, trivia={criteria="Hellfire Peninsula", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="HellfirePeninsula", uiMapID=100, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Hellfire", 6559, criterion=21571, trivia={criteria="Hellfire Peninsula", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="HellfirePeninsula", uiMapID=100, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Hellfire", 6560, criterion=21571, trivia={criteria="Hellfire Peninsula", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="HellfirePeninsula", uiMapID=100, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Outland Safari
A{"Hellfire", 6587, criterion=21760, note="zone exclusive", trivia={criteria="Flayer Youngling", module="pet", category="Pet Battles/Collect", name="Outland Safari", description="Catch every battle pet in Outland.", mapID="HellfirePeninsula", uiMapID=100, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Outland
A{"Hellfire", 6604, 0.6400, 0.4900, criterion=21604, trivia={criteria="Nicki Tinytech", module="pet", category="Pet Battles", name="Taming Outland", description="Defeat all of the Pet Tamers in Outland listed below.", mapID="HellfirePeninsula", uiMapID=100, points=5, type=158}}

-- Pet Battles/Collect: Outland Tamer
A{"Hellfire", 6614, criterion=21469, trivia={criteria="Hellfire Peninsula", module="pet", category="Pet Battles/Collect", name="Outland Tamer", description="Capture a battle pet in each of the Outland zones listed below.", mapID="HellfirePeninsula", uiMapID=100, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"Hellfire", 8348, 0.6400, 0.4900, criterion=23473, trivia={criteria="Nicki Tinytech", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="HellfirePeninsula", uiMapID=100, points=10, type="quest"}}

-- Pet Battles/Battle: An Awfully Big Adventure
A{"Hellfire", 9069, 0.6440, 0.4920, criterion=26994, trivia={criteria="Nicki Tinytech", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="HellfirePeninsula", uiMapID=100, points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Battle: Local Pet Mauler
A{"HillsbradFoothills", 6558, criterion=21563, trivia={criteria="Hillsbrad Foothills", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="HillsbradFoothills", uiMapID=25, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"HillsbradFoothills", 6559, criterion=21563, trivia={criteria="Hillsbrad Foothills", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="HillsbradFoothills", uiMapID=25, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"HillsbradFoothills", 6560, criterion=21563, trivia={criteria="Hillsbrad Foothills", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="HillsbradFoothills", uiMapID=25, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Eastern Kingdoms Safari
A{"HillsbradFoothills", 6586, 0.5500, 0.4700, criterion=21514, note="also in Southshore Ruins and The Sludge Fields", trivia={criteria="Maggot", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="HillsbradFoothills", uiMapID=25, points=5, parent="Pet Battles", type="catch"}}
A{"HillsbradFoothills", 6586, 0.3500, 0.4700, criterion=21521, note="inside the mine", trivia={criteria="Spider", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="HillsbradFoothills", uiMapID=25, points=5, parent="Pet Battles", type="catch"}}
A{"HillsbradFoothills", 6586, 0.3500, 0.4700, criterion=21650, note="zone exclusive\nslay Mama Bears without cubs to force spawns", trivia={criteria="Infested Bear Cub", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="HillsbradFoothills", uiMapID=25, points=5, parent="Pet Battles", type="catch"}}
A{"HillsbradFoothills", 6586, 0.6200, 0.8400, criterion=21651, trivia={criteria="Red-Tailed Chipmunk", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="HillsbradFoothills", uiMapID=25, points=5, parent="Pet Battles", type="catch"}}
A{"HillsbradFoothills", 6586, 0.4800, 0.1900, criterion=21652, note="zone exclusive\ncommon as a second pet between Slaughter Hollow and Chillwind", trivia={criteria="Snowshoe Hare", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="HillsbradFoothills", uiMapID=25, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Eastern Kingdoms Tamer
A{"HillsbradFoothills", 6613, criterion=21435, trivia={criteria="Hillsbrad Foothills", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Tamer", description="Capture a battle pet in each of the Eastern Kingdoms zones listed below.", mapID="HillsbradFoothills", uiMapID=25, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Crazy for Cats
A{"HillsbradFoothills", 8397, criterion=23577, note="0.01% drop rate", trivia={criteria="Black Tabby Cat", module="pet", category="Pet Battles/Collect", name="Crazy for Cats", description="Obtain 20 of the cats listed below.", mapID="HillsbradFoothills", uiMapID=25, points=10, parent="Pet Battles", type=96}}

-- Pet Battles/Collect: So. Many. Pets.
A{"HillsbradFoothills", 9643, criterion="Cat Carrier (Black Tabby)", item="7383", note="rare drop", trivia={criteria="Cat Carrier (Black Tabby)", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="HillsbradFoothills", uiMapID=25, points=10, parent="Pet Battles", type=156}}
A{"HillsbradFoothills", 9643, 0.3400, 0.7400, criterion="Brazie's Sunflower Seeds", item="51090", note="from Lawn of the Dead", trivia={criteria="Brazie's Sunflower Seeds", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="HillsbradFoothills", uiMapID=25, points=10, parent="Pet Battles", type=156}}
A{"HillsbradFoothills", 9643, 0.3000, 0.3700, criterion="Lofty Libram", item="68806", note="rare drop\nzone exclusive", trivia={criteria="Lofty Libram", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="HillsbradFoothills", uiMapID=25, points=10, parent="Pet Battles", type=156}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Hinterlands", 6558, criterion=21564, trivia={criteria="The Hinterlands", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="TheHinterlands", uiMapID=26, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Hinterlands", 6559, criterion=21564, trivia={criteria="The Hinterlands", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="TheHinterlands", uiMapID=26, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Hinterlands", 6560, criterion=21564, trivia={criteria="The Hinterlands", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="TheHinterlands", uiMapID=26, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Eastern Kingdoms Safari
A{"Hinterlands", 6586, 0.1200, 0.4600, criterion=21612, trivia={criteria="Hare", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="TheHinterlands", uiMapID=26, points=5, parent="Pet Battles", type="catch"}}
A{"Hinterlands", 6586, criterion=21674, note="eastern half of the zone", trivia={criteria="Brown Marmot", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="TheHinterlands", uiMapID=26, points=5, parent="Pet Battles", type="catch"}}
A{"Hinterlands", 6586, 0.5800, 0.4100, criterion=21675, note="zone exclusive\ninside the cave and just outside the mouth", trivia={criteria="Jade Oozeling", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="TheHinterlands", uiMapID=26, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Eastern Kingdoms
A{"Hinterlands", 6603, 0.6300, 0.5500, criterion=21598, note="between Stormfeather & Jinth'alor Pet Level: 13", side="alliance", trivia={criteria="David Kosse", module="pet", category="Pet Battles", name="Taming Eastern Kingdoms", description="Defeat all of the Pet Tamers in Eastern Kingdoms listed below.", mapID="TheHinterlands", uiMapID=26, points=5, type=158}}

-- Pet Battles/Collect: Eastern Kingdoms Tamer
A{"Hinterlands", 6613, criterion=21437, trivia={criteria="Hinterlands", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Tamer", description="Capture a battle pet in each of the Eastern Kingdoms zones listed below.", mapID="TheHinterlands", uiMapID=26, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"Hinterlands", 8348, 0.6300, 0.5500, criterion=23447, trivia={criteria="David Kosse", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="TheHinterlands", uiMapID=26, points=10, type="quest"}}

-- Pet Battles/Battle: Local Pet Mauler
A{"HowlingFjord", 6558, criterion=21579, trivia={criteria="Howling Fjord", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="HowlingFjord", uiMapID=117, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"HowlingFjord", 6559, criterion=21579, trivia={criteria="Howling Fjord", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="HowlingFjord", uiMapID=117, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"HowlingFjord", 6560, criterion=21579, trivia={criteria="Howling Fjord", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="HowlingFjord", uiMapID=117, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Northrend Safari
A{"HowlingFjord", 6588, criterion=21775, note="zone exclusive", trivia={criteria="Fjord Worg Pup", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", mapID="HowlingFjord", uiMapID=117, points=5, parent="Pet Battles", type="catch"}}
A{"HowlingFjord", 6588, criterion=21774, note="zone exclusive", trivia={criteria="Fjord Rat", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", mapID="HowlingFjord", uiMapID=117, points=5, parent="Pet Battles", type="catch"}}
A{"HowlingFjord", 6588, criterion=21776, note="zone exclusive", trivia={criteria="Turkey", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", mapID="HowlingFjord", uiMapID=117, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Northrend
A{"HowlingFjord", 6605, 0.2700, 0.3400, criterion=21848, trivia={criteria="Beegle Blastfuse", module="pet", category="Pet Battles", name="Taming Northrend", description="Defeat all of the Pet Tamers in Northrend listed below.", mapID="HowlingFjord", uiMapID=117, points=5, type=158}}

-- Pet Battles/Collect: Northrend Tamer
A{"HowlingFjord", 6615, criterion=21481, trivia={criteria="Howling Fjord", module="pet", category="Pet Battles/Collect", name="Northrend Tamer", description="Capture a battle pet in each of the Northrend zones listed below.", mapID="HowlingFjord", uiMapID=117, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"HowlingFjord", 8348, 0.2700, 0.3400, criterion=23481, trivia={criteria="Beegle Blastfuse", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="HowlingFjord", uiMapID=117, points=10, type="quest"}}

-- Pet Battles/Battle: An Awfully Big Adventure
A{"HowlingFjord", 9069, 0.2860, 0.3380, criterion=26970, trivia={criteria="Beegle Blastfuse", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="HowlingFjord", uiMapID=117, points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Hyjal", 6558, criterion=21538, trivia={criteria="Mount Hyjal", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="MountHyjal", uiMapID=198, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Hyjal", 6559, criterion=21538, trivia={criteria="Mount Hyjal", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="MountHyjal", uiMapID=198, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Hyjal", 6560, criterion=21538, trivia={criteria="Mount Hyjal", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="MountHyjal", uiMapID=198, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Kalimdor Safari
A{"Hyjal", 6585, 0.3100, 0.7800, criterion=21730, note="zone exclusive", trivia={criteria="Carrion Rat", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="MountHyjal", uiMapID=198, points=5, parent="Pet Battles", type="catch"}}
A{"Hyjal", 6585, 0.2700, 0.3900, criterion=21731, note="zone exclusive", trivia={criteria="Death's Head Cockroach", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="MountHyjal", uiMapID=198, points=5, parent="Pet Battles", type="catch"}}
A{"Hyjal", 6585, criterion=21732, trivia={criteria="Fire-Proof Roach", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="MountHyjal", uiMapID=198, points=5, parent="Pet Battles", type="catch"}}
A{"Hyjal", 6585, 0.6200, 0.2300, criterion=21734, note="zone exclusive", trivia={criteria="Nordrassil Wisp", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="MountHyjal", uiMapID=198, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Kalimdor Tamer
A{"Hyjal", 6612, criterion=21488, trivia={criteria="Mount Hyjal", module="pet", category="Pet Battles/Collect", name="Kalimdor Tamer", description="Capture a battle pet in each of the Kalimdor zones listed below.", mapID="MountHyjal", uiMapID=198, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: Taming Cataclysm
A{"Hyjal", 7525, 0.6100, 0.3300, criterion=21858, trivia={criteria="Brok", module="pet", category="Pet Battles", name="Taming Cataclysm", description="Defeat all of the Pet Tamers in Cataclysm listed below.", mapID="MountHyjal", uiMapID=198, points=5, type=158}}

-- Pet Battles: The Longest Day
A{"Hyjal", 8348, 0.6100, 0.3300, criterion=23483, trivia={criteria="Brok", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="MountHyjal", uiMapID=198, points=10, type="quest"}}

-- Pet Battles/Battle: An Awfully Big Adventure
A{"Hyjal", 9069, 0.6140, 0.3280, criterion=26973, trivia={criteria="Brok", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="MountHyjal", uiMapID=198, points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Battle: Local Pet Mauler
A{"IcecrownGlacier", 6558, criterion=21585, trivia={criteria="Icecrown", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="Icecrown", uiMapID=118, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"IcecrownGlacier", 6559, criterion=21585, trivia={criteria="Icecrown", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="Icecrown", uiMapID=118, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"IcecrownGlacier", 6560, criterion=21585, trivia={criteria="Icecrown", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="Icecrown", uiMapID=118, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Northrend Safari
A{"IcecrownGlacier", 6588, criterion=21777, note="zone exclusive", trivia={criteria="Scourged Whelpling", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", mapID="Icecrown", uiMapID=118, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Northrend
A{"IcecrownGlacier", 6605, 0.7700, 0.2000, criterion=21852, trivia={criteria="Major Payne", module="pet", category="Pet Battles", name="Taming Northrend", description="Defeat all of the Pet Tamers in Northrend listed below.", mapID="Icecrown", uiMapID=118, points=5, type=158}}

-- Pet Battles/Collect: Northrend Tamer
A{"IcecrownGlacier", 6615, criterion=21482, trivia={criteria="Icecrown", module="pet", category="Pet Battles/Collect", name="Northrend Tamer", description="Capture a battle pet in each of the Northrend zones listed below.", mapID="Icecrown", uiMapID=118, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"IcecrownGlacier", 8348, 0.7700, 0.2000, criterion=23482, trivia={criteria="Grand Master Payne", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="Icecrown", uiMapID=118, points=10, type="quest"}}

-- Pet Battles/Battle: An Awfully Big Adventure
A{"IcecrownGlacier", 9069, 0.7740, 0.1960, criterion=26989, trivia={criteria="Major Payne", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="Icecrown", uiMapID=118, points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Battle: Big City Pet Brawlin' - Alliance
A{"Ironforge", 6584, criterion=19846, trivia={criteria="Ironforge", module="pet", category="Pet Battles/Battle", name="Big City Pet Brawlin' - Alliance", description="Win a pet battle in each of the Alliance cities listed below.", mapID="Ironforge", uiMapID=87, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Eastern Kingdoms Safari
A{"Ironforge", 6586, criterion=21513, trivia={criteria="Long-tailed Mole", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="Ironforge", uiMapID=87, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Krasarang", 6558, criterion=21589, trivia={criteria="Karasang Wilds", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="KrasarangWilds", uiMapID=418, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Krasarang", 6559, criterion=21589, trivia={criteria="Karasang Wilds", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="KrasarangWilds", uiMapID=418, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Krasarang", 6560, criterion=21589, trivia={criteria="Karasang Wilds", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="KrasarangWilds", uiMapID=418, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Pandaria Safari
A{"Krasarang", 6589, criterion=21809, note="zone exclusive", trivia={criteria="Amethyst Spiderling", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="KrasarangWilds", uiMapID=418, points=5, parent="Pet Battles", type="catch"}}
A{"Krasarang", 6589, criterion=21811, note="zone exclusive", trivia={criteria="Jungle Grub", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="KrasarangWilds", uiMapID=418, points=5, parent="Pet Battles", type="catch"}}
A{"Krasarang", 6589, criterion=21812, note="zone exclusive", trivia={criteria="Luyu Moth", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="KrasarangWilds", uiMapID=418, points=5, parent="Pet Battles", type="catch"}}
A{"Krasarang", 6589, criterion=21814, note="zone exclusive", trivia={criteria="Mei Li Sparkler", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="KrasarangWilds", uiMapID=418, points=5, parent="Pet Battles", type="catch"}}
A{"Krasarang", 6589, criterion=21815, note="zone exclusive", trivia={criteria="Savory Bettle", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="KrasarangWilds", uiMapID=418, points=5, parent="Pet Battles", type="catch"}}
A{"Krasarang", 6589, criterion=21817, note="zone exclusive", trivia={criteria="Spiny Terrapin", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="KrasarangWilds", uiMapID=418, points=5, parent="Pet Battles", type="catch"}}
A{"Krasarang", 6589, criterion=21810, note="zone exclusive", trivia={criteria="Feverbite Hatchling", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="KrasarangWilds", uiMapID=418, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Pandaria
A{"Krasarang", 6606, 0.6200, 0.4600, criterion=21871, trivia={criteria="Mo'ruk", module="pet", category="Pet Battles", name="Taming Pandaria", description="Defeat all of the Pet Tamers in Pandaria listed below.", mapID="KrasarangWilds", uiMapID=418, points=5, type=158}}

-- Pet Battles/Collect: Pandaria Tamer
A{"Krasarang", 6616, criterion=21491, trivia={criteria="Krasarang Wilds", module="pet", category="Pet Battles/Collect", name="Pandaria Tamer", description="Capture a battle pet in each of the Pandaria zones listed below.", mapID="KrasarangWilds", uiMapID=418, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"Krasarang", 8348, 0.6200, 0.4600, criterion=23489, trivia={criteria="Grand Master Mo'ruk", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="KrasarangWilds", uiMapID=418, points=10, type="quest"}}
A{"Krasarang", 8348, 0.3600, 0.3700, criterion=23499, note="[3 beasts]", trivia={criteria="Skitterer Xi'a", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="KrasarangWilds", uiMapID=418, points=10, type="quest"}}

-- Pet Battles/Battle: An Awfully Big Adventure
A{"Krasarang", 9069, 0.6220, 0.4580, criterion=26990, trivia={criteria="Mo'ruk", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="KrasarangWilds", uiMapID=418, points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Battle: Local Pet Mauler
A{"KunLaiSummit", 6558, criterion=21590, trivia={criteria="Kun-Lai Summit", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="KunLaiSummit", uiMapID=379, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"KunLaiSummit", 6559, criterion=21590, trivia={criteria="Kun-Lai Summit", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="KunLaiSummit", uiMapID=379, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"KunLaiSummit", 6560, criterion=21590, trivia={criteria="Kun-Lai Summit", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="KunLaiSummit", uiMapID=379, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Pandaria Safari
A{"KunLaiSummit", 6589, criterion=21824, note="zone exclusive", trivia={criteria="Alpine Foxling Kit", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="KunLaiSummit", uiMapID=379, points=5, parent="Pet Battles", type="catch"}}
A{"KunLaiSummit", 6589, criterion=21825, note="zone exclusive", trivia={criteria="Plains Monitor", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="KunLaiSummit", uiMapID=379, points=5, parent="Pet Battles", type="catch"}}
A{"KunLaiSummit", 6589, criterion=21823, note="zone exclusive", trivia={criteria="Alpine Foxling", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="KunLaiSummit", uiMapID=379, points=5, parent="Pet Battles", type="catch"}}
A{"KunLaiSummit", 6589, criterion=21826, note="zone exclusive", trivia={criteria="Prairie Mouse", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="KunLaiSummit", uiMapID=379, points=5, parent="Pet Battles", type="catch"}}
A{"KunLaiSummit", 6589, criterion=21827, note="zone exclusive", trivia={criteria="Summit Kid", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="KunLaiSummit", uiMapID=379, points=5, parent="Pet Battles", type="catch"}}
A{"KunLaiSummit", 6589, criterion=21828, note="zone exclusive", trivia={criteria="Szechuan Chicken", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="KunLaiSummit", uiMapID=379, points=5, parent="Pet Battles", type="catch"}}
A{"KunLaiSummit", 6589, criterion=21829, note="zone exclusive", trivia={criteria="Tolai Hare", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="KunLaiSummit", uiMapID=379, points=5, parent="Pet Battles", type="catch"}}
A{"KunLaiSummit", 6589, criterion=21830, note="zone exclusive", trivia={criteria="Tolai Hare Pup", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="KunLaiSummit", uiMapID=379, points=5, parent="Pet Battles", type="catch"}}
A{"KunLaiSummit", 6589, criterion=21831, note="zone exclusive", trivia={criteria="Zooey Snake", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="KunLaiSummit", uiMapID=379, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Pandaria
A{"KunLaiSummit", 6606, 0.3600, 0.7400, criterion=21855, trivia={criteria="Courageous Yon", module="pet", category="Pet Battles", name="Taming Pandaria", description="Defeat all of the Pet Tamers in Pandaria listed below.", mapID="KunLaiSummit", uiMapID=379, points=5, type=158}}

-- Pet Battles/Collect: Pandaria Tamer
A{"KunLaiSummit", 6616, criterion=21492, trivia={criteria="Kun-Lai Summit", module="pet", category="Pet Battles/Collect", name="Pandaria Tamer", description="Capture a battle pet in each of the Pandaria zones listed below.", mapID="KunLaiSummit", uiMapID=379, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"KunLaiSummit", 8348, 0.3600, 0.7400, criterion=23491, trivia={criteria="Grand Master Yon", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="KunLaiSummit", uiMapID=379, points=10, type="quest"}}
A{"KunLaiSummit", 8348, 0.6500, 0.9400, criterion=23496, trivia={criteria="Thundering Pandaren Spirit", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="KunLaiSummit", uiMapID=379, points=10, type="quest"}}
A{"KunLaiSummit", 8348, 0.3500, 0.5600, criterion=23498, note="[4 beasts]", trivia={criteria="Kafi", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="KunLaiSummit", uiMapID=379, points=10, type="quest"}}
A{"KunLaiSummit", 8348, 0.6800, 0.8500, criterion=23498, note="[4 beasts]", trivia={criteria="Dos-Ryga", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="KunLaiSummit", uiMapID=379, points=10, type="quest"}}

-- Pet Battles/Battle: An Awfully Big Adventure
A{"KunLaiSummit", 9069, 0.3580, 0.7360, criterion=26977, trivia={criteria="Courageous Yon", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="KunLaiSummit", uiMapID=379, points=10, parent="Pet Battles", type=158}}
A{"KunLaiSummit", 9069, 0.6480, 0.9360, criterion=27005, trivia={criteria="Thundering Pandaren Spirit", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="KunLaiSummit", uiMapID=379, points=10, parent="Pet Battles", type=158}}
A{"LakeWintergrasp", 9069, 0.6560, 0.6440, criterion=27000, trivia={criteria="Stone Cold Trixxy", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Battle: Local Pet Mauler
A{"LochModan", 6558, criterion=21559, trivia={criteria="Loch Modan", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="LochModan", uiMapID=48, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"LochModan", 6559, criterion=21559, trivia={criteria="Loch Modan", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="LochModan", uiMapID=48, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"LochModan", 6560, criterion=21559, trivia={criteria="Loch Modan", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="LochModan", uiMapID=48, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Eastern Kingdoms Tamer
A{"LochModan", 6613, criterion=21440, trivia={criteria="Loch Modan", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Tamer", description="Capture a battle pet in each of the Eastern Kingdoms zones listed below.", mapID="LochModan", uiMapID=48, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: Taming Kalimdor
A{"Moonglade", 6602, 0.4600, 0.6000, criterion=21408, side="horde", trivia={criteria="Elena Flutterfly", module="pet", category="Pet Battles", name="Taming Kalimdor", description="Defeat all of the Pet Tamers in Kalimdor listed below.", mapID="Moonglade", uiMapID=80, points=5, type=158}}

-- Pet Battles: The Longest Day
A{"Moonglade", 8348, 0.4600, 0.6000, criterion=23466, trivia={criteria="Elena Flutterfly", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="Moonglade", uiMapID=80, points=10, type="quest"}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Mulgore", 6558, criterion=21543, trivia={criteria="Mulgore", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="Mulgore", uiMapID=7, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Mulgore", 6559, criterion=21543, trivia={criteria="Mulgore", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="Mulgore", uiMapID=7, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Mulgore", 6560, criterion=21543, trivia={criteria="Mulgore", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="Mulgore", uiMapID=7, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Kalimdor Safari
A{"Mulgore", 6585, criterion=21735, note="zone exclusive", trivia={criteria="Gazelle Fawn", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="Mulgore", uiMapID=7, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Kalimdor Tamer
A{"Mulgore", 6612, criterion=21459, trivia={criteria="Mulgore", module="pet", category="Pet Battles/Collect", name="Kalimdor Tamer", description="Capture a battle pet in each of the Kalimdor zones listed below.", mapID="Mulgore", uiMapID=7, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Nagrand", 6558, criterion=21574, trivia={criteria="Nagrand", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="Nagrand", uiMapID=107, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Nagrand", 6559, criterion=21574, trivia={criteria="Nagrand", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="Nagrand", uiMapID=107, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Nagrand", 6560, criterion=21574, trivia={criteria="Nagrand", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="Nagrand", uiMapID=107, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Outland Safari
A{"Nagrand", 6587, criterion=21761, note="zone exclusive", trivia={criteria="Clefthoof Runt", module="pet", category="Pet Battles/Collect", name="Outland Safari", description="Catch every battle pet in Outland.", mapID="Nagrand", uiMapID=107, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Outland
A{"Nagrand", 6604, 0.6100, 0.4900, criterion=21606, trivia={criteria="Narrok", module="pet", category="Pet Battles", name="Taming Outland", description="Defeat all of the Pet Tamers in Outland listed below.", mapID="Nagrand", uiMapID=107, points=5, type=158}}

-- Pet Battles/Collect: Outland Tamer
A{"Nagrand", 6614, criterion=21470, trivia={criteria="Nagrand", module="pet", category="Pet Battles/Collect", name="Outland Tamer", description="Capture a battle pet in each of the Outland zones listed below.", mapID="Nagrand", uiMapID=107, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"Nagrand", 8348, 0.6100, 0.4900, criterion=23472, trivia={criteria="Narrok", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="Nagrand", uiMapID=107, points=10, type="quest"}}

-- Pet Battles/Battle: An Awfully Big Adventure
A{"Nagrand", 9069, 0.6100, 0.4940, criterion=26992, trivia={criteria="Narrok", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="Nagrand", uiMapID=107, points=10, parent="Pet Battles", type=158}}
A{"NagrandDraenor", 9069, 0.5620, 0.9800, criterion=27004, trivia={criteria="Tarr the Terrible", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="NagrandDraenor", uiMapID=550, points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Collect: Draenor Safari
A{"NagrandDraenor", 9685, criterion=27246, note="zone exclusive", trivia={criteria="Leatherhide Runt", module="pet", category="Pet Battles/Collect", name="Draenor Safari", description="Catch every battle pet in Draenor.", mapID="NagrandDraenor", uiMapID=550, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Draenor
A{"NagrandDraenor", 9724, 0.5600, 0.1000, criterion=27015, trivia={criteria="Tarr the Terrible", module="pet", category="Pet Battles", name="Taming Draenor", description="Defeat all of the Pet Tamers in Draenor listed below.", mapID="NagrandDraenor", uiMapID=550, points=5, type=158}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Netherstorm", 6558, criterion=21576, trivia={criteria="Netherstorm", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="Netherstorm", uiMapID=109, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Netherstorm", 6559, criterion=21576, trivia={criteria="Netherstorm", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="Netherstorm", uiMapID=109, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Netherstorm", 6560, criterion=21576, trivia={criteria="Netherstorm", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="Netherstorm", uiMapID=109, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Outland Safari
A{"Netherstorm", 6587, criterion=21762, note="zone exclusive", trivia={criteria="Fledgling Nether Ray", module="pet", category="Pet Battles/Collect", name="Outland Safari", description="Catch every battle pet in Outland.", mapID="Netherstorm", uiMapID=109, points=5, parent="Pet Battles", type="catch"}}
A{"Netherstorm", 6587, criterion=21763, note="zone exclusive", trivia={criteria="Nether Roach", module="pet", category="Pet Battles/Collect", name="Outland Safari", description="Catch every battle pet in Outland.", mapID="Netherstorm", uiMapID=109, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Outland Tamer
A{"Netherstorm", 6614, criterion=21475, trivia={criteria="Netherstorm", module="pet", category="Pet Battles/Collect", name="Outland Tamer", description="Capture a battle pet in each of the Outland zones listed below.", mapID="Netherstorm", uiMapID=109, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Crazy for Cats
A{"Netherstorm", 8397, 0.4300, 0.3500, criterion=23591, note="from Dealer Rashaad", trivia={criteria="Siamese Cat", module="pet", category="Pet Battles/Collect", name="Crazy for Cats", description="Obtain 20 of the cats listed below.", mapID="Netherstorm", uiMapID=109, points=10, parent="Pet Battles", type=96}}

-- Pet Battles/Battle: Big City Pet Brawlin' - Horde
A{"Orgrimmar", 6621, criterion=19849, trivia={criteria="Orgrimmar", module="pet", category="Pet Battles/Battle", name="Big City Pet Brawlin' - Horde", description="Win a pet battle in each of the Horde cities listed below.", mapID="Orgrimmar", uiMapID=85, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Redridge", 6558, criterion=21550, trivia={criteria="Redridge Mountains", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="RedridgeMountains", uiMapID=49, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Redridge", 6559, criterion=21550, trivia={criteria="Redridge Mountains", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="RedridgeMountains", uiMapID=49, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Redridge", 6560, criterion=21550, trivia={criteria="Redridge Mountains", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="RedridgeMountains", uiMapID=49, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Kalimdor Safari
A{"Redridge", 6585, criterion=21663, note="zone exclusive", trivia={criteria="Mountain Cottontail", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="RedridgeMountains", uiMapID=49, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Eastern Kingdoms Safari
A{"Redridge", 6586, 0.1800, 0.6200, criterion=21517, trivia={criteria="Roach", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="RedridgeMountains", uiMapID=49, points=5, parent="Pet Battles", type="catch"}}
A{"Redridge", 6586, 0.1800, 0.6200, criterion=21663, note="zone exclusive", trivia={criteria="Mountain Cottontail", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="RedridgeMountains", uiMapID=49, points=5, parent="Pet Battles", type="catch"}}
A{"Redridge", 6586, 0.2500, 0.2300, criterion=21662, note="zone exclusive", trivia={criteria="Fledgling Buzzard", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="RedridgeMountains", uiMapID=49, points=5, parent="Pet Battles", type="catch"}}
A{"Redridge", 6586, 0.3800, 0.6700, criterion=21664, note="zone exclusive\nall around Lakeridge Highway", trivia={criteria="Redridge Rat", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="RedridgeMountains", uiMapID=49, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Eastern Kingdoms
A{"Redridge", 6603, 0.3300, 0.5300, criterion=21398, note="opposite the Flight Master, Pet Level: 5", side="alliance", trivia={criteria="Lindsay", module="pet", category="Pet Battles", name="Taming Eastern Kingdoms", description="Defeat all of the Pet Tamers in Eastern Kingdoms listed below.", mapID="RedridgeMountains", uiMapID=49, points=5, type=158}}

-- Pet Battles/Collect: Eastern Kingdoms Tamer
A{"Redridge", 6613, criterion=21385, trivia={criteria="Redridge Mountains", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Tamer", description="Capture a battle pet in each of the Eastern Kingdoms zones listed below.", mapID="RedridgeMountains", uiMapID=49, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"Redridge", 8348, 0.3300, 0.5300, criterion=23420, trivia={criteria="Lindsay", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="RedridgeMountains", uiMapID=49, points=10, type="quest"}}

-- Pet Battles/Collect: So. Many. Pets.
A{"Redridge", 9643, criterion="Mountain Cottontail", trivia={criteria="Mountain Cottontail", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="RedridgeMountains", uiMapID=49, points=10, parent="Pet Battles", type=156}}
A{"Redridge", 9643, criterion="Roach", trivia={criteria="Roach", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="RedridgeMountains", uiMapID=49, points=10, parent="Pet Battles", type=156}}
A{"Redridge", 9643, criterion="Redridge Rat", trivia={criteria="Redridge Rat", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="RedridgeMountains", uiMapID=49, points=10, parent="Pet Battles", type=156}}
A{"Redridge", 9643, criterion="Fledgling Buzzard", trivia={criteria="Fledgling Buzzard", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="RedridgeMountains", uiMapID=49, points=10, parent="Pet Battles", type=156}}

-- Pet Battles/Battle: Local Pet Mauler
A{"SearingGorge", 6558, criterion=21556, trivia={criteria="Searing Gorge", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="SearingGorge", uiMapID=32, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"SearingGorge", 6559, criterion=21556, trivia={criteria="Searing Gorge", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="SearingGorge", uiMapID=32, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"SearingGorge", 6560, criterion=21556, trivia={criteria="Searing Gorge", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="SearingGorge", uiMapID=32, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Eastern Kingdoms Safari
A{"SearingGorge", 6586, 0.6500, 0.5800, criterion=21621, trivia={criteria="Fire Beetle", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="SearingGorge", uiMapID=32, points=5, parent="Pet Battles", type="catch"}}
A{"SearingGorge", 6586, 0.4800, 0.5200, criterion=21627, trivia={criteria="Lava Crab", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="SearingGorge", uiMapID=32, points=5, parent="Pet Battles", type="catch"}}
A{"SearingGorge", 6586, 0.6000, 0.7100, criterion=21665, trivia={criteria="Ash Spiderling", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="SearingGorge", uiMapID=32, points=5, parent="Pet Battles", type="catch"}}
A{"SearingGorge", 6586, criterion=21666, note="zone exclusive\nonly spawns in lava pools, shares spawn with lava crabs", trivia={criteria="Molten Hatchling", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="SearingGorge", uiMapID=32, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Eastern Kingdoms
A{"SearingGorge", 6603, 0.3500, 0.2800, criterion=21600, note="Pet Level: 15", side="alliance", trivia={criteria="Kortas Darkhammer", module="pet", category="Pet Battles", name="Taming Eastern Kingdoms", description="Defeat all of the Pet Tamers in Eastern Kingdoms listed below.", mapID="SearingGorge", uiMapID=32, points=5, type=158}}

-- Pet Battles/Collect: Eastern Kingdoms Tamer
A{"SearingGorge", 6613, criterion=21442, trivia={criteria="Searing Gorge", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Tamer", description="Capture a battle pet in each of the Eastern Kingdoms zones listed below.", mapID="SearingGorge", uiMapID=32, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"SearingGorge", 8348, 0.3500, 0.2800, criterion=23449, trivia={criteria="Kortas Darkhammer", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="SearingGorge", uiMapID=32, points=10, type="quest"}}

-- Pet Battles/Battle: Local Pet Mauler
A{"ShadowmoonValley", 6558, criterion=21577, trivia={criteria="Shadowmoon Valley", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="ShadowmoonValley", uiMapID=104, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"ShadowmoonValley", 6559, criterion=21577, trivia={criteria="Shadowmoon Valley", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="ShadowmoonValley", uiMapID=104, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"ShadowmoonValley", 6560, criterion=21577, trivia={criteria="Shadowmoon Valley", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="ShadowmoonValley", uiMapID=104, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles: Taming Outland
A{"ShadowmoonValley", 6604, 0.3000, 0.4200, criterion=21847, trivia={criteria="Bloodknight Antari", module="pet", category="Pet Battles", name="Taming Outland", description="Defeat all of the Pet Tamers in Outland listed below.", mapID="ShadowmoonValley", uiMapID=104, points=5, type=158}}

-- Pet Battles/Collect: Outland Tamer
A{"ShadowmoonValley", 6614, criterion=21472, trivia={criteria="Shadowmoon Valley", module="pet", category="Pet Battles/Collect", name="Outland Tamer", description="Capture a battle pet in each of the Outland zones listed below.", mapID="ShadowmoonValley", uiMapID=104, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"ShadowmoonValley", 8348, 0.3000, 0.4200, criterion=23475, trivia={criteria="Grand Master Antari", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="ShadowmoonValley", uiMapID=104, points=10, type="quest"}}

-- Pet Battles/Battle: An Awfully Big Adventure
A{"ShadowmoonValley", 9069, 0.3040, 0.4180, criterion=27471, trivia={criteria="Bloodknight Antari", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="ShadowmoonValley", uiMapID=104, points=10, parent="Pet Battles", type=158}}
A{"ShadowmoonValleyDR", 9069, 0.5000, 0.3100, criterion=26969, trivia={criteria="Ashlei", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="ShadowmoonValleyDraenor", uiMapID=539, points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Collect: Draenor Safari
A{"ShadowmoonValleyDR", 9685, criterion=27248, note="zone exclusive", trivia={criteria="Moonshell Crab", module="pet", category="Pet Battles/Collect", name="Draenor Safari", description="Catch every battle pet in Draenor.", mapID="ShadowmoonValleyDraenor", uiMapID=539, points=5, parent="Pet Battles", type="catch"}}
A{"ShadowmoonValleyDR", 9685, criterion=27250, note="zone exclusive", trivia={criteria="Mossbite Skitterer", module="pet", category="Pet Battles/Collect", name="Draenor Safari", description="Catch every battle pet in Draenor.", mapID="ShadowmoonValleyDraenor", uiMapID=539, points=5, parent="Pet Battles", type="catch"}}
A{"ShadowmoonValleyDR", 9685, criterion=27266, note="zone exclusive", trivia={criteria="Zangar Crawler", module="pet", category="Pet Battles/Collect", name="Draenor Safari", description="Catch every battle pet in Draenor.", mapID="ShadowmoonValleyDraenor", uiMapID=539, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Draenor
A{"ShadowmoonValleyDR", 9724, 0.5000, 0.3100, criterion=27012, trivia={criteria="Ashlei", module="pet", category="Pet Battles", name="Taming Draenor", description="Defeat all of the Pet Tamers in Draenor listed below.", mapID="ShadowmoonValleyDraenor", uiMapID=539, points=5, type=158}}

-- Pet Battles: Taming Outland
A{"ShattrathCity", 6604, 0.5900, 0.7000, criterion=21607, trivia={criteria="Morulu the Elder", module="pet", category="Pet Battles", name="Taming Outland", description="Defeat all of the Pet Tamers in Outland listed below.", mapID="ShattrathCity", uiMapID=111, points=5, type=158}}

-- Pet Battles: The Longest Day
A{"ShattrathCity", 8348, 0.5900, 0.7000, criterion=23470, trivia={criteria="Morulu The Elder", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="ShattrathCity", uiMapID=111, points=10, type="quest"}}

-- Pet Battles/Battle: An Awfully Big Adventure
A{"ShattrathCity", 9069, 0.5900, 0.7000, criterion=26991, trivia={criteria="Morulu the Elder", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="ShattrathCity", uiMapID=111, points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Battle: Local Pet Mauler
A{"SholazarBasin", 6558, criterion=21581, trivia={criteria="Sholozar Basin", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="SholazarBasin", uiMapID=119, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"SholazarBasin", 6559, criterion=21581, trivia={criteria="Sholozar Basin", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="SholazarBasin", uiMapID=119, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"SholazarBasin", 6560, criterion=21581, trivia={criteria="Sholozar Basin", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="SholazarBasin", uiMapID=119, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Kalimdor Safari
A{"SholazarBasin", 6585, criterion=21736, note="zone exclusive", trivia={criteria="Biletoad", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="SholazarBasin", uiMapID=119, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Northrend Safari
A{"SholazarBasin", 6588, criterion=21736, note="zone exclusive", trivia={criteria="Biletoad", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", mapID="SholazarBasin", uiMapID=119, points=5, parent="Pet Battles", type="catch"}}
A{"SholazarBasin", 6588, criterion=21778, note="zone exclusive", trivia={criteria="Stunted Shardhorn", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", mapID="SholazarBasin", uiMapID=119, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Northrend Tamer
A{"SholazarBasin", 6615, criterion=21483, trivia={criteria="Sholazar Basin", module="pet", category="Pet Battles/Collect", name="Northrend Tamer", description="Capture a battle pet in each of the Northrend zones listed below.", mapID="SholazarBasin", uiMapID=119, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Silithus", 6558, criterion=21542, trivia={criteria="Silithus", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="Silithus", uiMapID=81, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Silithus", 6559, criterion=21542, trivia={criteria="Silithus", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="Silithus", uiMapID=81, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Silithus", 6560, criterion=21542, trivia={criteria="Silithus", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="Silithus", uiMapID=81, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Kalimdor Safari
A{"Silithus", 6585, 0.3600, 0.8000, criterion=21739, note="zone exclusive\nonly during summer", trivia={criteria="Qiraji Guardling", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="Silithus", uiMapID=81, points=5, parent="Pet Battles", type="catch"}}
A{"Silithus", 6585, 0.3600, 0.8100, criterion=21740, note="zone exclusive", trivia={criteria="Scarab Hatchling", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="Silithus", uiMapID=81, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Kalimdor Tamer
A{"Silithus", 6612, criterion=21461, trivia={criteria="Silithus", module="pet", category="Pet Battles/Collect", name="Kalimdor Tamer", description="Capture a battle pet in each of the Kalimdor zones listed below.", mapID="Silithus", uiMapID=81, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Big City Pet Brawlin' - Horde
A{"SilvermoonCity", 6621, criterion=19852, trivia={criteria="Silvermoon City", module="pet", category="Pet Battles/Battle", name="Big City Pet Brawlin' - Horde", description="Win a pet battle in each of the Horde cities listed below.", mapID="SilvermoonCity", uiMapID=110, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Silverpine", 6558, criterion=21565, trivia={criteria="Silverpine Forest", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="SilverpineForest", uiMapID=21, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Silverpine", 6559, criterion=21565, trivia={criteria="Silverpine Forest", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="SilverpineForest", uiMapID=21, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Silverpine", 6560, criterion=21565, trivia={criteria="Silverpine Forest", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="SilverpineForest", uiMapID=21, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Eastern Kingdoms Safari
A{"Silverpine", 6586, criterion=21637, trivia={criteria="Infected Fawn", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="SilverpineForest", uiMapID=21, points=5, parent="Pet Battles", type="catch"}}
A{"Silverpine", 6586, criterion=21667, note="zone exclusive", trivia={criteria="Blighted Squirrel", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="SilverpineForest", uiMapID=21, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Eastern Kingdoms Tamer
A{"Silverpine", 6613, criterion=21443, trivia={criteria="Silverpine Forest", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Tamer", description="Capture a battle pet in each of the Eastern Kingdoms zones listed below.", mapID="SilverpineForest", uiMapID=21, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Local Pet Mauler
A{"SouthernBarrens", 6558, criterion=21535, trivia={criteria="Southern Barrens", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="SouthernBarrens", uiMapID=199, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"SouthernBarrens", 6559, criterion=21535, trivia={criteria="Southern Barrens", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="SouthernBarrens", uiMapID=199, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"SouthernBarrens", 6560, criterion=21535, trivia={criteria="Southern Barrens", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="SouthernBarrens", uiMapID=199, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Kalimdor Safari
A{"SouthernBarrens", 6585, criterion=21742, note="zone exclusive", trivia={criteria="Giraffe Calf", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="SouthernBarrens", uiMapID=199, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Kalimdor
A{"SouthernBarrens", 6602, 0.4000, 0.7900, criterion=21409, side="horde", trivia={criteria="Cassandra Kaboom", module="pet", category="Pet Battles", name="Taming Kalimdor", description="Defeat all of the Pet Tamers in Kalimdor listed below.", mapID="SouthernBarrens", uiMapID=199, points=5, type=158}}

-- Pet Battles/Collect: Kalimdor Tamer
A{"SouthernBarrens", 6612, criterion=21462, trivia={criteria="Southern Barrens", module="pet", category="Pet Battles/Collect", name="Kalimdor Tamer", description="Capture a battle pet in each of the Kalimdor zones listed below.", mapID="SouthernBarrens", uiMapID=199, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"SouthernBarrens", 8348, 0.4000, 0.7900, criterion=23460, trivia={criteria="Cassandra Kaboom", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="SouthernBarrens", uiMapID=199, points=10, type="quest"}}

-- Pet Battles/Battle: An Awfully Big Adventure
A{"SpiresOfArak", 9069, 0.4620, 0.4540, criterion=27006, trivia={criteria="Vesharr", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="SpiresOfArak", uiMapID=542, points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Collect: Draenor Safari
A{"SpiresOfArak", 9685, criterion=27251, note="zone exclusive", trivia={criteria="Thicket Skitterer", module="pet", category="Pet Battles/Collect", name="Draenor Safari", description="Catch every battle pet in Draenor.", mapID="SpiresOfArak", uiMapID=542, points=5, parent="Pet Battles", type="catch"}}
A{"SpiresOfArak", 9685, criterion=27253, note="zone exclusive", trivia={criteria="Bloodsting Wasp", module="pet", category="Pet Battles/Collect", name="Draenor Safari", description="Catch every battle pet in Draenor.", mapID="SpiresOfArak", uiMapID=542, points=5, parent="Pet Battles", type="catch"}}
A{"SpiresOfArak", 9685, criterion=27261, note="zone exclusive", trivia={criteria="Golden Dawnfeather", module="pet", category="Pet Battles/Collect", name="Draenor Safari", description="Catch every battle pet in Draenor.", mapID="SpiresOfArak", uiMapID=542, points=5, parent="Pet Battles", type="catch"}}
A{"SpiresOfArak", 9685, criterion=27272, note="zone exclusive", trivia={criteria="Swamplighter Firefly", module="pet", category="Pet Battles/Collect", name="Draenor Safari", description="Catch every battle pet in Draenor.", mapID="SpiresOfArak", uiMapID=542, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Draenor
A{"SpiresOfArak", 9724, 0.4600, 0.4500, criterion=27014, trivia={criteria="Vesharr", module="pet", category="Pet Battles", name="Taming Draenor", description="Defeat all of the Pet Tamers in Draenor listed below.", mapID="SpiresOfArak", uiMapID=542, points=5, type=158}}

-- Pet Battles/Battle: Local Pet Mauler
A{"StonetalonMountains", 6558, criterion=21529, trivia={criteria="Stonetalon Mountains", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="StonetalonMountains", uiMapID=65, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"StonetalonMountains", 6559, criterion=21529, trivia={criteria="Stonetalon Mountains", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="StonetalonMountains", uiMapID=65, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"StonetalonMountains", 6560, criterion=21529, trivia={criteria="Stonetalon Mountains", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="StonetalonMountains", uiMapID=65, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Kalimdor Safari
A{"StonetalonMountains", 6585, 0.4100, 0.4500, criterion=21743, note="zone exclusive", trivia={criteria="Coral Snake", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="StonetalonMountains", uiMapID=65, points=5, parent="Pet Battles", type="catch"}}
A{"StonetalonMountains", 6585, 0.5700, 0.7200, criterion=21744, note="zone exclusive", trivia={criteria="Venomspitter Hatchling", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="StonetalonMountains", uiMapID=65, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Kalimdor
A{"StonetalonMountains", 6602, 0.6000, 0.7100, criterion=21405, side="horde", trivia={criteria="Zonya the Sadist", module="pet", category="Pet Battles", name="Taming Kalimdor", description="Defeat all of the Pet Tamers in Kalimdor listed below.", mapID="StonetalonMountains", uiMapID=65, points=5, type=158}}

-- Pet Battles/Collect: Kalimdor Tamer
A{"StonetalonMountains", 6612, criterion=21463, trivia={criteria="Stonetalon Mountains", module="pet", category="Pet Battles/Collect", name="Kalimdor Tamer", description="Capture a battle pet in each of the Kalimdor zones listed below.", mapID="StonetalonMountains", uiMapID=65, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"StonetalonMountains", 8348, 0.6000, 0.7100, criterion=23457, trivia={criteria="Zonya the Sadist", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="StonetalonMountains", uiMapID=65, points=10, type="quest"}}

-- Pet Battles/Battle: Big City Pet Brawlin' - Alliance
A{"StormwindCity", 6584, criterion=19845, trivia={criteria="Stormwind", module="pet", category="Pet Battles/Battle", name="Big City Pet Brawlin' - Alliance", description="Win a pet battle in each of the Alliance cities listed below.", mapID="StormwindCity", uiMapID=84, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Eastern Kingdoms Safari
A{"StormwindCity", 6586, criterion=21640, trivia={criteria="Sea Gull", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="StormwindCity", uiMapID=84, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Crazy for Cats
A{"StormwindCity", 8397, criterion=23594, note="from Lil Timmy", trivia={criteria="White Kitten", module="pet", category="Pet Battles/Collect", name="Crazy for Cats", description="Obtain 20 of the cats listed below.", mapID="StormwindCity", uiMapID=84, points=10, parent="Pet Battles", type=96}}

-- Pet Battles/Collect: So. Many. Pets.
A{"StormwindCity", 9643, criterion="Cat Carrier (White Kitten)", item="10679", note="from Lil Timmy", trivia={criteria="Cat Carrier (White Kitten)", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="StormwindCity", uiMapID=84, points=10, parent="Pet Battles", type=156}}
A{"StormwindCity", 9643, 0.5800, 0.5200, criterion="Alliance Balloon", item="54539", trivia={criteria="Alliance Balloon", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="StormwindCity", uiMapID=84, points=10, parent="Pet Battles", type=156}}
A{"StormwindCity", 9643, criterion="Sea Gull", trivia={criteria="Sea Gull", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="StormwindCity", uiMapID=84, points=10, parent="Pet Battles", type=156}}

-- Pet Battles/Battle: Local Pet Mauler
A{"StranglethornJungle", 6558, criterion=21552, trivia={criteria="Stranglethorn Vale", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="NorthernStranglethorn", uiMapID=50, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"StranglethornJungle", 6559, criterion=21552, trivia={criteria="Stranglethorn Vale", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="NorthernStranglethorn", uiMapID=50, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"StranglethornJungle", 6560, criterion=21552, trivia={criteria="Stranglethorn Vale", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="NorthernStranglethorn", uiMapID=50, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Eastern Kingdoms Safari
A{"StranglethornJungle", 6586, 0.5900, 0.2000, criterion=21615, trivia={criteria="Beetle", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="NorthernStranglethorn", uiMapID=50, points=5, parent="Pet Battles", type="catch"}}
A{"StranglethornJungle", 6586, 0.5900, 0.2000, criterion=21655, trivia={criteria="Forest Spiderling", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="NorthernStranglethorn", uiMapID=50, points=5, parent="Pet Battles", type="catch"}}
A{"StranglethornJungle", 6586, 0.5900, 0.2000, criterion=21656, trivia={criteria="Lizard Hatchling", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="NorthernStranglethorn", uiMapID=50, points=5, parent="Pet Battles", type="catch"}}
A{"StranglethornJungle", 6586, 0.5900, 0.2000, criterion=21658, note="zone exclusive", trivia={criteria="Polly", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="NorthernStranglethorn", uiMapID=50, points=5, parent="Pet Battles", type="catch"}}
A{"StranglethornJungle", 6586, 0.5200, 0.3500, criterion=21659, trivia={criteria="Strand Crab", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="NorthernStranglethorn", uiMapID=50, points=5, parent="Pet Battles", type="catch"}}
A{"StranglethornJungle", 6586, 0.4400, 0.2300, criterion=21660, trivia={criteria="Tree Python", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="NorthernStranglethorn", uiMapID=50, points=5, parent="Pet Battles", type="catch"}}
A{"StranglethornJungle", 6586, 0.4200, 0.4000, criterion=21654, note="only found as a secondary pet\nJaquero Isle is also good", trivia={criteria="Crimson Moth", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="NorthernStranglethorn", uiMapID=50, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Eastern Kingdoms
A{"StranglethornJungle", 6603, 0.4600, 0.4000, criterion=21400, note="Between Gromgol & Venture Co [Pet Level: 9]", side="alliance", trivia={criteria="Steven Lisbane", module="pet", category="Pet Battles", name="Taming Eastern Kingdoms", description="Defeat all of the Pet Tamers in Eastern Kingdoms listed below.", mapID="NorthernStranglethorn", uiMapID=50, points=5, type=158}}

-- Pet Battles/Collect: Eastern Kingdoms Tamer
A{"StranglethornJungle", 6613, criterion=21441, trivia={criteria="Northern Stranglethorn", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Tamer", description="Capture a battle pet in each of the Eastern Kingdoms zones listed below.", mapID="NorthernStranglethorn", uiMapID=50, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"StranglethornJungle", 8348, 0.4600, 0.4000, criterion=23446, trivia={criteria="Steven Lisbane", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="NorthernStranglethorn", uiMapID=50, points=10, type="quest"}}

-- Pet Battles/Collect: Crazy for Cats
A{"StranglethornJungle", 8397, criterion=23588, trivia={criteria="Panther Cub", module="pet", category="Pet Battles/Collect", name="Crazy for Cats", description="Obtain 20 of the cats listed below.", mapID="NorthernStranglethorn", uiMapID=50, points=10, parent="Pet Battles", type=96}}

-- Pet Battles/Collect: So. Many. Pets.
A{"StranglethornJungle", 9643, criterion="Polly", trivia={criteria="Polly", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="NorthernStranglethorn", uiMapID=50, points=10, parent="Pet Battles", type=156}}
A{"StranglethornJungle", 9643, 0.4200, 0.4000, criterion="Crimson Moth", trivia={criteria="Crimson Moth", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="NorthernStranglethorn", uiMapID=50, points=10, parent="Pet Battles", type=156}}
A{"StranglethornJungle", 9643, criterion="Forest Spiderling", trivia={criteria="Forest Spiderling", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="NorthernStranglethorn", uiMapID=50, points=10, parent="Pet Battles", type=156}}
A{"StranglethornJungle", 9643, criterion="Lizard Hatchling", trivia={criteria="Lizard Hatchling", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="NorthernStranglethorn", uiMapID=50, points=10, parent="Pet Battles", type=156}}
A{"StranglethornJungle", 9643, criterion="Beetle", trivia={criteria="Beetle", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="NorthernStranglethorn", uiMapID=50, points=10, parent="Pet Battles", type=156}}
A{"StranglethornJungle", 9643, criterion="Tree Python", trivia={criteria="Tree Python", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="NorthernStranglethorn", uiMapID=50, points=10, parent="Pet Battles", type=156}}
A{"StranglethornJungle", 9643, criterion="Strand Crab", trivia={criteria="Strand Crab", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="NorthernStranglethorn", uiMapID=50, points=10, parent="Pet Battles", type=156}}
A{"StranglethornJungle", 9643, criterion="Razzashi Hatchling", item="35394", note="rare drop", trivia={criteria="Razzashi Hatchling", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="NorthernStranglethorn", uiMapID=50, points=10, parent="Pet Battles", type=156}}
A{"StranglethornJungle", 9643, criterion="Parrot Cage (Hyacinth Macaw)", item="7391", note="rare drop", trivia={criteria="Parrot Cage (Hyacinth Macaw)", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="NorthernStranglethorn", uiMapID=50, points=10, parent="Pet Battles", type=156}}
A{"StranglethornJungle", 9643, 0.4700, 0.1100, criterion="Lashtail Hatchling", item="52894", note="from Brother Nimitz quest Bad Medicine", trivia={criteria="Lashtail Hatchling", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="NorthernStranglethorn", uiMapID=50, points=10, parent="Pet Battles", type=156}}
A{"StranglethornJungle", 9643, 0.5100, 0.6500, criterion="Panther Cub", item="52226", note="from Brother Nimitz quest Some Good Will Come", trivia={criteria="Panther Cub", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="NorthernStranglethorn", uiMapID=50, points=10, parent="Pet Battles", type=156}}

-- Pet Battles/Battle: Local Pet Mauler
A{"SwampOfSorrows", 6558, criterion=21553, trivia={criteria="Swamp of Sorrows", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="SwampOfSorrows", uiMapID=51, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"SwampOfSorrows", 6559, criterion=21553, trivia={criteria="Swamp of Sorrows", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="SwampOfSorrows", uiMapID=51, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"SwampOfSorrows", 6560, criterion=21553, trivia={criteria="Swamp of Sorrows", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="SwampOfSorrows", uiMapID=51, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Eastern Kingdoms Safari
A{"SwampOfSorrows", 6586, 0.8600, 0.2400, criterion=21649, trivia={criteria="Huge Toad", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="SwampOfSorrows", uiMapID=51, points=5, parent="Pet Battles", type="catch"}}
A{"SwampOfSorrows", 6586, 0.6900, 0.7400, criterion=21657, trivia={criteria="Parrot", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="SwampOfSorrows", uiMapID=51, points=5, parent="Pet Battles", type="catch"}}
A{"SwampOfSorrows", 6586, 0.8300, 0.3900, criterion=21671, note="zone exclusive", trivia={criteria="Moccasin", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="SwampOfSorrows", uiMapID=51, points=5, parent="Pet Battles", type="catch"}}
A{"SwampOfSorrows", 6586, 0.8600, 0.2400, criterion=21672, note="zone exclusive\noften found as a secondary pet", trivia={criteria="Swamp Moth", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="SwampOfSorrows", uiMapID=51, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Eastern Kingdoms
A{"SwampOfSorrows", 6603, 0.7700, 0.4100, criterion=21601, note="Pet Level: 16", side="alliance", trivia={criteria="Everessa", module="pet", category="Pet Battles", name="Taming Eastern Kingdoms", description="Defeat all of the Pet Tamers in Eastern Kingdoms listed below.", mapID="SwampOfSorrows", uiMapID=51, points=5, type=158}}

-- Pet Battles/Collect: Eastern Kingdoms Tamer
A{"SwampOfSorrows", 6613, criterion=21444, trivia={criteria="Swamp of Sorrows", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Tamer", description="Capture a battle pet in each of the Eastern Kingdoms zones listed below.", mapID="SwampOfSorrows", uiMapID=51, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"SwampOfSorrows", 8348, 0.7700, 0.4100, criterion=23450, trivia={criteria="Everessa", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="SwampOfSorrows", uiMapID=51, points=10, type="quest"}}

-- Pet Battles/Battle: An Awfully Big Adventure
A{"Talador", 9069, 0.4900, 0.8040, criterion=27002, trivia={criteria="Taralune", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="Talador", uiMapID=535, points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Collect: Draenor Safari
A{"Talador", 9685, criterion=27260, note="zone exclusive", trivia={criteria="Brilliant Bloodfeather", module="pet", category="Pet Battles/Collect", name="Draenor Safari", description="Catch every battle pet in Draenor.", mapID="Talador", uiMapID=535, points=5, parent="Pet Battles", type="catch"}}
A{"Talador", 9685, criterion=27267, note="zone exclusive", trivia={criteria="Kelp Scuttler", module="pet", category="Pet Battles/Collect", name="Draenor Safari", description="Catch every battle pet in Draenor.", mapID="Talador", uiMapID=535, points=5, parent="Pet Battles", type="catch"}}
A{"Talador", 9685, criterion=27276, note="zone exclusive", trivia={criteria="Flat-Tooth Calf", module="pet", category="Pet Battles/Collect", name="Draenor Safari", description="Catch every battle pet in Draenor.", mapID="Talador", uiMapID=535, points=5, parent="Pet Battles", type="catch"}}
A{"Talador", 9685, criterion=27278, note="zone exclusive", trivia={criteria="Shadow Sporebat", module="pet", category="Pet Battles/Collect", name="Draenor Safari", description="Catch every battle pet in Draenor.", mapID="Talador", uiMapID=535, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Draenor
A{"Talador", 9724, 0.4900, 0.8000, criterion=27016, trivia={criteria="Taralune", module="pet", category="Pet Battles", name="Taming Draenor", description="Defeat all of the Pet Tamers in Draenor listed below.", mapID="Talador", uiMapID=535, points=5, type=158}}

-- Pet Battles/Battle: Tiny Terrors in Tanaan
A{"TanaanJungle", 10052, 0.2600, 0.3200, criterion=28796, trivia={criteria="Felsworn Sentry", module="pet", category="Pet Battles/Battle", name="Tiny Terrors in Tanaan", description="Defeat the following fel-corrupted pets in Tanaan Jungle.", mapID="TanaanJungle", uiMapID=534, points=10, parent="Pet Battles", type="catch"}}
A{"TanaanJungle", 10052, 0.5300, 0.6500, criterion=28797, trivia={criteria="Corrupted Thundertail", module="pet", category="Pet Battles/Battle", name="Tiny Terrors in Tanaan", description="Defeat the following fel-corrupted pets in Tanaan Jungle.", mapID="TanaanJungle", uiMapID=534, points=10, parent="Pet Battles", type="catch"}}
A{"TanaanJungle", 10052, 0.2700, 0.7100, criterion=28798, note="in cave", trivia={criteria="Chaos Pup", module="pet", category="Pet Battles/Battle", name="Tiny Terrors in Tanaan", description="Defeat the following fel-corrupted pets in Tanaan Jungle.", mapID="TanaanJungle", uiMapID=534, points=10, parent="Pet Battles", type="catch"}}
A{"TanaanJungle", 10052, 0.3100, 0.3800, criterion=28799, trivia={criteria="Cursed Spirit", module="pet", category="Pet Battles/Battle", name="Tiny Terrors in Tanaan", description="Defeat the following fel-corrupted pets in Tanaan Jungle.", mapID="TanaanJungle", uiMapID=534, points=10, parent="Pet Battles", type="catch"}}
A{"TanaanJungle", 10052, 0.5600, 0.8100, criterion=28800, trivia={criteria="Felfly", module="pet", category="Pet Battles/Battle", name="Tiny Terrors in Tanaan", description="Defeat the following fel-corrupted pets in Tanaan Jungle.", mapID="TanaanJungle", uiMapID=534, points=10, parent="Pet Battles", type="catch"}}
A{"TanaanJungle", 10052, 0.4300, 0.8500, criterion=28801, trivia={criteria="Tainted Maulclaw", module="pet", category="Pet Battles/Battle", name="Tiny Terrors in Tanaan", description="Defeat the following fel-corrupted pets in Tanaan Jungle.", mapID="TanaanJungle", uiMapID=534, points=10, parent="Pet Battles", type="catch"}}
A{"TanaanJungle", 10052, 0.5800, 0.3700, criterion=28802, trivia={criteria="Direflame", module="pet", category="Pet Battles/Battle", name="Tiny Terrors in Tanaan", description="Defeat the following fel-corrupted pets in Tanaan Jungle.", mapID="TanaanJungle", uiMapID=534, points=10, parent="Pet Battles", type="catch"}}
A{"TanaanJungle", 10052, 0.4200, 0.7200, criterion=28803, trivia={criteria="Mirecroak", module="pet", category="Pet Battles/Battle", name="Tiny Terrors in Tanaan", description="Defeat the following fel-corrupted pets in Tanaan Jungle.", mapID="TanaanJungle", uiMapID=534, points=10, parent="Pet Battles", type="catch"}}
A{"TanaanJungle", 10052, 0.5400, 0.3000, criterion=28804, trivia={criteria="Dark Gazer", module="pet", category="Pet Battles/Battle", name="Tiny Terrors in Tanaan", description="Defeat the following fel-corrupted pets in Tanaan Jungle.", mapID="TanaanJungle", uiMapID=534, points=10, parent="Pet Battles", type="catch"}}
A{"TanaanJungle", 10052, 0.1600, 0.4500, criterion=28805, trivia={criteria="Bleakclaw", module="pet", category="Pet Battles/Battle", name="Tiny Terrors in Tanaan", description="Defeat the following fel-corrupted pets in Tanaan Jungle.", mapID="TanaanJungle", uiMapID=534, points=10, parent="Pet Battles", type="catch"}}
A{"TanaanJungle", 10052, 0.4400, 0.4600, criterion=28806, trivia={criteria="Vile Blood of Draenor", module="pet", category="Pet Battles/Battle", name="Tiny Terrors in Tanaan", description="Defeat the following fel-corrupted pets in Tanaan Jungle.", mapID="TanaanJungle", uiMapID=534, points=10, parent="Pet Battles", type="catch"}}
A{"TanaanJungle", 10052, 0.4600, 0.5300, criterion=28807, trivia={criteria="Dreadwalker", module="pet", category="Pet Battles/Battle", name="Tiny Terrors in Tanaan", description="Defeat the following fel-corrupted pets in Tanaan Jungle.", mapID="TanaanJungle", uiMapID=534, points=10, parent="Pet Battles", type="catch"}}
A{"TanaanJungle", 10052, 0.4800, 0.3600, criterion=28810, trivia={criteria="Netherfist", module="pet", category="Pet Battles/Battle", name="Tiny Terrors in Tanaan", description="Defeat the following fel-corrupted pets in Tanaan Jungle.", mapID="TanaanJungle", uiMapID=534, points=10, parent="Pet Battles", type="catch"}}
A{"TanaanJungle", 10052, 0.4900, 0.3100, criterion=28808, trivia={criteria="Skrillix", module="pet", category="Pet Battles/Battle", name="Tiny Terrors in Tanaan", description="Defeat the following fel-corrupted pets in Tanaan Jungle.", mapID="TanaanJungle", uiMapID=534, points=10, parent="Pet Battles", type="catch"}}
A{"TanaanJungle", 10052, 0.7500, 0.3700, criterion=28809, trivia={criteria="Defiled Earth", module="pet", category="Pet Battles/Battle", name="Tiny Terrors in Tanaan", description="Defeat the following fel-corrupted pets in Tanaan Jungle.", mapID="TanaanJungle", uiMapID=534, points=10, parent="Pet Battles", type="catch"}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Tanaris", 6558, criterion=21533, trivia={criteria="Tanaris", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="Tanaris", uiMapID=71, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Tanaris", 6559, criterion=21533, trivia={criteria="Tanaris", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="Tanaris", uiMapID=71, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Tanaris", 6560, criterion=21533, trivia={criteria="Tanaris", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="Tanaris", uiMapID=71, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Kalimdor Safari
A{"Tanaris", 6585, criterion=21746, note="zone exclusive", trivia={criteria="Sand Kitten", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="Tanaris", uiMapID=71, points=5, parent="Pet Battles", type="catch"}}
A{"Tanaris", 6585, 0.3600, 0.4600, criterion=21747, note="zone exclusive\nonly during sandstorm", trivia={criteria="Silithid Hatchling", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="Tanaris", uiMapID=71, points=5, parent="Pet Battles", type="catch"}}
A{"Tanaris", 6585, criterion=21748, note="zone exclusive", trivia={criteria="Stinkbug", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="Tanaris", uiMapID=71, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Kalimdor Tamer
A{"Tanaris", 6612, criterion=21464, trivia={criteria="Tanaris", module="pet", category="Pet Battles/Collect", name="Kalimdor Tamer", description="Capture a battle pet in each of the Kalimdor zones listed below.", mapID="Tanaris", uiMapID=71, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Crazy for Cats
A{"Tanaris", 8397, criterion=23589, trivia={criteria="Sand Kitten", module="pet", category="Pet Battles/Collect", name="Crazy for Cats", description="Obtain 20 of the cats listed below.", mapID="Tanaris", uiMapID=71, points=10, parent="Pet Battles", type=96}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Teldrassil", 6558, criterion=21545, trivia={criteria="Teldrassil", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="Teldrassil", uiMapID=57, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Teldrassil", 6559, criterion=21545, trivia={criteria="Teldrassil", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="Teldrassil", uiMapID=57, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Teldrassil", 6560, criterion=21545, trivia={criteria="Teldrassil", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="Teldrassil", uiMapID=57, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Kalimdor Safari
A{"Teldrassil", 6585, criterion=22540, note="zone exclusive", trivia={criteria="Crested Owl", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="Teldrassil", uiMapID=57, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Battle: Local Pet Mauler
A{"TerokkarForest", 6558, criterion=21573, trivia={criteria="Terokkar Forest", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="TerokkarForest", uiMapID=108, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"TerokkarForest", 6559, criterion=21573, trivia={criteria="Terokkar Forest", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="TerokkarForest", uiMapID=108, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"TerokkarForest", 6560, criterion=21573, trivia={criteria="Terokkar Forest", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="TerokkarForest", uiMapID=108, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Outland Safari
A{"TerokkarForest", 6587, criterion=21765, note="zone exclusive", trivia={criteria="Warpstalker Hatchling", module="pet", category="Pet Battles/Collect", name="Outland Safari", description="Catch every battle pet in Outland.", mapID="TerokkarForest", uiMapID=108, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Outland Tamer
A{"TerokkarForest", 6614, criterion=21471, trivia={criteria="Terokkar Forest", module="pet", category="Pet Battles/Collect", name="Outland Tamer", description="Capture a battle pet in each of the Outland zones listed below.", mapID="TerokkarForest", uiMapID=108, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Eastern Kingdoms Safari
A{"TheCapeOfStranglethorn", 6586, 0.6000, 0.8200, criterion=21668, note="only when it's raining\nJaquero has its own weather", trivia={criteria="Baby Ape", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="TheCapeOfStranglethorn", uiMapID=210, points=5, parent="Pet Battles", type="catch"}}
A{"TheCapeOfStranglethorn", 6586, 0.4280, 0.7160, criterion=21670, trivia={criteria="Wharf Rat", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="TheCapeOfStranglethorn", uiMapID=210, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Eastern Kingdoms
A{"TheCapeOfStranglethorn", 6603, 0.5100, 0.7300, criterion=21401, note="near the path from Booty Bay. Pet Level 11", side="alliance", trivia={criteria="Bill Buckler", module="pet", category="Pet Battles", name="Taming Eastern Kingdoms", description="Defeat all of the Pet Tamers in Eastern Kingdoms listed below.", mapID="TheCapeOfStranglethorn", uiMapID=210, points=5, type=158}}

-- Pet Battles/Collect: Eastern Kingdoms Tamer
A{"TheCapeOfStranglethorn", 6613, criterion=21427, trivia={criteria="Cape of Stranglethorn", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Tamer", description="Capture a battle pet in each of the Eastern Kingdoms zones listed below.", mapID="TheCapeOfStranglethorn", uiMapID=210, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"TheCapeOfStranglethorn", 8348, 0.5150, 0.7340, criterion=23445, trivia={criteria="Bill Buckler", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="TheCapeOfStranglethorn", uiMapID=210, points=10, type="quest"}}

-- Pet Battles/Collect: So. Many. Pets.
A{"TheCapeOfStranglethorn", 9643, 0.4200, 0.6900, criterion="Parrot Cage (Cockatiel)", item="7390", note="from Narkk", trivia={criteria="Parrot Cage (Cockatiel)", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="TheCapeOfStranglethorn", uiMapID=210, points=10, parent="Pet Battles", type=156}}
A{"TheCapeOfStranglethorn", 9643, 0.4200, 0.6900, criterion="Parrot Cage (Senegal)", item="7389", note="from Narkk", trivia={criteria="Parrot Cage (Senegal)", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="TheCapeOfStranglethorn", uiMapID=210, points=10, parent="Pet Battles", type=156}}
A{"TheCapeOfStranglethorn", 9643, criterion="Baby Ape", item="61324", note="when raining", trivia={criteria="Baby Ape", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="TheCapeOfStranglethorn", uiMapID=210, points=10, parent="Pet Battles", type=156}}

-- Pet Battles/Battle: Big City Pet Brawlin' - Alliance
A{"TheExodar", 6584, criterion=19848, trivia={criteria="The Exodar", module="pet", category="Pet Battles/Battle", name="Big City Pet Brawlin' - Alliance", description="Win a pet battle in each of the Alliance cities listed below.", mapID="TheExodar", uiMapID=103, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: So. Many. Pets.
A{"TheExodar", 9643, criterion="Blue Moth Egg", trivia={criteria="Blue Moth Egg", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="TheExodar", uiMapID=103, points=10, parent="Pet Battles", type=156}}
A{"TheExodar", 9643, criterion="White Moth Egg", trivia={criteria="White Moth Egg", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="TheExodar", uiMapID=103, points=10, parent="Pet Battles", type=156}}
A{"TheExodar", 9643, criterion="Yellow Moth Egg", trivia={criteria="Yellow Moth Egg", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="TheExodar", uiMapID=103, points=10, parent="Pet Battles", type=156}}

-- Pet Battles/Battle: Local Pet Mauler
A{"TheJadeForest", 6558, criterion=21587, trivia={criteria="The Jade Forest", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="TheJadeForest", uiMapID=371, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"TheJadeForest", 6559, criterion=21587, trivia={criteria="The Jade Forest", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="TheJadeForest", uiMapID=371, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"TheJadeForest", 6560, criterion=21587, trivia={criteria="The Jade Forest", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="TheJadeForest", uiMapID=371, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Pandaria Safari
A{"TheJadeForest", 6589, criterion=21782, note="zone exclusive", trivia={criteria="Emerald Turtle", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="TheJadeForest", uiMapID=371, points=5, parent="Pet Battles", type="catch"}}
A{"TheJadeForest", 6589, criterion=21781, note="zone exclusive", trivia={criteria="Bucktooth Flapper", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="TheJadeForest", uiMapID=371, points=5, parent="Pet Battles", type="catch"}}
A{"TheJadeForest", 6589, criterion=21784, note="zone exclusive", trivia={criteria="Garden Frog", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="TheJadeForest", uiMapID=371, points=5, parent="Pet Battles", type="catch"}}
A{"TheJadeForest", 6589, criterion=21788, note="zone exclusive", trivia={criteria="Jungle Darter", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="TheJadeForest", uiMapID=371, points=5, parent="Pet Battles", type="catch"}}
A{"TheJadeForest", 6589, criterion=21786, note="zone exclusive", trivia={criteria="Grove Viper", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="TheJadeForest", uiMapID=371, points=5, parent="Pet Battles", type="catch"}}
A{"TheJadeForest", 6589, criterion=21787, note="zone exclusive", trivia={criteria="Jumping Spider", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="TheJadeForest", uiMapID=371, points=5, parent="Pet Battles", type="catch"}}
A{"TheJadeForest", 6589, criterion=21790, note="zone exclusive", trivia={criteria="Masked Tanuki", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="TheJadeForest", uiMapID=371, points=5, parent="Pet Battles", type="catch"}}
A{"TheJadeForest", 6589, criterion=21791, note="zone exclusive", trivia={criteria="Masked Tanuki Pup", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="TheJadeForest", uiMapID=371, points=5, parent="Pet Battles", type="catch"}}
A{"TheJadeForest", 6589, criterion=21792, note="zone exclusive", trivia={criteria="Mirror Strider", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="TheJadeForest", uiMapID=371, points=5, parent="Pet Battles", type="catch"}}
A{"TheJadeForest", 6589, criterion=21793, note="zone exclusive", trivia={criteria="Sandy Petrel", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="TheJadeForest", uiMapID=371, points=5, parent="Pet Battles", type="catch"}}
A{"TheJadeForest", 6589, criterion=21796, note="zone exclusive", trivia={criteria="Spirebound Crab", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="TheJadeForest", uiMapID=371, points=5, parent="Pet Battles", type="catch"}}
A{"TheJadeForest", 6589, criterion=21805, note="zone exclusive", trivia={criteria="Temple Snake", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="TheJadeForest", uiMapID=371, points=5, parent="Pet Battles", type="catch"}}
A{"TheJadeForest", 6589, criterion=21785, note="zone exclusive", trivia={criteria="Garden Moth", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="TheJadeForest", uiMapID=371, points=5, parent="Pet Battles", type="catch"}}
A{"TheJadeForest", 6589, criterion=21794, note="zone exclusive", trivia={criteria="Shrine Fly", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="TheJadeForest", uiMapID=371, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Pandaria
A{"TheJadeForest", 6606, 0.4800, 0.5400, criterion=21853, trivia={criteria="Hyuna of the Shrines", module="pet", category="Pet Battles", name="Taming Pandaria", description="Defeat all of the Pet Tamers in Pandaria listed below.", mapID="TheJadeForest", uiMapID=371, points=5, type=158}}

-- Pet Battles/Collect: Pandaria Tamer
A{"TheJadeForest", 6616, criterion=21489, trivia={criteria="Jade Forest", module="pet", category="Pet Battles/Collect", name="Pandaria Tamer", description="Capture a battle pet in each of the Pandaria zones listed below.", mapID="TheJadeForest", uiMapID=371, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"TheJadeForest", 8348, 0.4800, 0.5400, criterion=23488, trivia={criteria="Grand Master Hyuna", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="TheJadeForest", uiMapID=371, points=10, type="quest"}}
A{"TheJadeForest", 8348, 0.2900, 0.3600, criterion=23497, trivia={criteria="Whispering Pandaren Spirit", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="TheJadeForest", uiMapID=371, points=10, type="quest"}}
A{"TheJadeForest", 8348, 0.4800, 0.7100, criterion=23498, note="[4 beasts]", trivia={criteria="Ka'wi the Gorger", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="TheJadeForest", uiMapID=371, points=10, type="quest"}}
A{"TheJadeForest", 8348, 0.5700, 0.2900, criterion=23498, note="[4 beasts]", trivia={criteria="Nitun", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="TheJadeForest", uiMapID=371, points=10, type="quest"}}

-- Pet Battles/Battle: An Awfully Big Adventure
A{"TheJadeForest", 9069, 0.4800, 0.5400, criterion=26985, trivia={criteria="Hyuna of the Shrines", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="TheJadeForest", uiMapID=371, points=10, parent="Pet Battles", type=158}}
A{"TheJadeForest", 9069, 0.2880, 0.3600, criterion=27008, trivia={criteria="Whispering Pandaren Spirit", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="TheJadeForest", uiMapID=371, points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Battle: Local Pet Mauler
A{"TheStormPeaks", 6558, criterion=21584, trivia={criteria="The Storm Peaks", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="TheStormPeaks", uiMapID=120, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"TheStormPeaks", 6559, criterion=21584, trivia={criteria="The Storm Peaks", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="TheStormPeaks", uiMapID=120, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"TheStormPeaks", 6560, criterion=21584, trivia={criteria="The Storm Peaks", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="TheStormPeaks", uiMapID=120, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Northrend Safari
A{"TheStormPeaks", 6588, criterion=21779, note="zone exclusive", trivia={criteria="Arctic Fox Kit", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", mapID="TheStormPeaks", uiMapID=120, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Northrend Tamer
A{"TheStormPeaks", 6615, criterion=21484, trivia={criteria="Storm Peaks", module="pet", category="Pet Battles/Collect", name="Northrend Tamer", description="Capture a battle pet in each of the Northrend zones listed below.", mapID="TheStormPeaks", uiMapID=120, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Local Pet Mauler
A{"ThousandNeedles", 6558, criterion=21532, trivia={criteria="Thousand Needles", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="ThousandNeedles", uiMapID=64, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"ThousandNeedles", 6559, criterion=21532, trivia={criteria="Thousand Needles", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="ThousandNeedles", uiMapID=64, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"ThousandNeedles", 6560, criterion=21532, trivia={criteria="Thousand Needles", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="ThousandNeedles", uiMapID=64, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Kalimdor Safari
A{"ThousandNeedles", 6585, 0.3300, 0.6000, criterion=21749, note="zone exclusive", trivia={criteria="Twilight Iguana", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="ThousandNeedles", uiMapID=64, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Kalimdor
A{"ThousandNeedles", 6602, 0.3200, 0.3300, criterion=21416, side="horde", trivia={criteria="Kela Grimtotem", module="pet", category="Pet Battles", name="Taming Kalimdor", description="Defeat all of the Pet Tamers in Kalimdor listed below.", mapID="ThousandNeedles", uiMapID=64, points=5, type=158}}

-- Pet Battles/Collect: Kalimdor Tamer
A{"ThousandNeedles", 6612, criterion=21465, trivia={criteria="Thousand Needles", module="pet", category="Pet Battles/Collect", name="Kalimdor Tamer", description="Capture a battle pet in each of the Kalimdor zones listed below.", mapID="ThousandNeedles", uiMapID=64, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"ThousandNeedles", 8348, 0.3200, 0.3300, criterion=23462, trivia={criteria="Kela Grimtotem", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="ThousandNeedles", uiMapID=64, points=10, type="quest"}}

-- Pet Battles/Battle: Big City Pet Brawlin' - Horde
A{"ThunderBluff", 6621, criterion=19850, trivia={criteria="Thunder Bluff", module="pet", category="Pet Battles/Battle", name="Big City Pet Brawlin' - Horde", description="Win a pet battle in each of the Horde cities listed below.", mapID="ThunderBluff", uiMapID=88, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Crazy for Cats
A{"TimelessIsle", 8397, criterion=23600, trivia={criteria="Xu-Fu, Cub of Xuen", module="pet", category="Pet Battles/Collect", name="Crazy for Cats", description="Obtain 20 of the cats listed below.", mapID="TimelessIsle", uiMapID=554, points=10, parent="Pet Battles", type=96}}

-- Pet Battles/Battle: Master of the Masters
A{"TimelessIsle", 8518, criterion=23620, trivia={criteria="Blingtron 4000", module="pet", category="Pet Battles/Battle", name="Master of the Masters", description="Defeat all the trainers listed below from the Celestial Tournament.", mapID="TimelessIsle", uiMapID=554, points=5, parent="Pet Battles", type=158}}
A{"TimelessIsle", 8518, criterion=23610, trivia={criteria="Wrathion", module="pet", category="Pet Battles/Battle", name="Master of the Masters", description="Defeat all the trainers listed below from the Celestial Tournament.", mapID="TimelessIsle", uiMapID=554, points=5, parent="Pet Battles", type=158}}
A{"TimelessIsle", 8518, criterion=23611, trivia={criteria="Lorewalker Cho", module="pet", category="Pet Battles/Battle", name="Master of the Masters", description="Defeat all the trainers listed below from the Celestial Tournament.", mapID="TimelessIsle", uiMapID=554, points=5, parent="Pet Battles", type=158}}
A{"TimelessIsle", 8518, criterion=23616, trivia={criteria="Chen Stormstout", module="pet", category="Pet Battles/Battle", name="Master of the Masters", description="Defeat all the trainers listed below from the Celestial Tournament.", mapID="TimelessIsle", uiMapID=554, points=5, parent="Pet Battles", type=158}}
A{"TimelessIsle", 8518, criterion=23619, trivia={criteria="Wise Mari", module="pet", category="Pet Battles/Battle", name="Master of the Masters", description="Defeat all the trainers listed below from the Celestial Tournament.", mapID="TimelessIsle", uiMapID=554, points=5, parent="Pet Battles", type=158}}
A{"TimelessIsle", 8518, criterion=23607, trivia={criteria="Shademaster Kiryn", module="pet", category="Pet Battles/Battle", name="Master of the Masters", description="Defeat all the trainers listed below from the Celestial Tournament.", mapID="TimelessIsle", uiMapID=554, points=5, parent="Pet Battles", type=158}}
A{"TimelessIsle", 8518, criterion=23617, trivia={criteria="Sully \"The Pickle\" McLeary", module="pet", category="Pet Battles/Battle", name="Master of the Masters", description="Defeat all the trainers listed below from the Celestial Tournament.", mapID="TimelessIsle", uiMapID=554, points=5, parent="Pet Battles", type=158}}
A{"TimelessIsle", 8518, criterion=23618, trivia={criteria="Taran Zhu", module="pet", category="Pet Battles/Battle", name="Master of the Masters", description="Defeat all the trainers listed below from the Celestial Tournament.", mapID="TimelessIsle", uiMapID=554, points=5, parent="Pet Battles", type=158}}
A{"TimelessIsle", 8518, criterion=23621, trivia={criteria="Dr. Ion Goldbloom", module="pet", category="Pet Battles/Battle", name="Master of the Masters", description="Defeat all the trainers listed below from the Celestial Tournament.", mapID="TimelessIsle", uiMapID=554, points=5, parent="Pet Battles", type=158}}
A{"TimelessIsle", 8518, criterion=23612, trivia={criteria="Xu-Fu, Cub of Xuen", module="pet", category="Pet Battles/Battle", name="Master of the Masters", description="Defeat all the trainers listed below from the Celestial Tournament.", mapID="TimelessIsle", uiMapID=554, points=5, parent="Pet Battles", type="catch"}}
A{"TimelessIsle", 8518, criterion=23615, trivia={criteria="Chi-Chi, Hatchling of Chi-Ji", module="pet", category="Pet Battles/Battle", name="Master of the Masters", description="Defeat all the trainers listed below from the Celestial Tournament.", mapID="TimelessIsle", uiMapID=554, points=5, parent="Pet Battles", type="catch"}}
A{"TimelessIsle", 8518, criterion=23614, trivia={criteria="Zao, Calfling of Niuzao", module="pet", category="Pet Battles/Battle", name="Master of the Masters", description="Defeat all the trainers listed below from the Celestial Tournament.", mapID="TimelessIsle", uiMapID=554, points=5, parent="Pet Battles", type="catch"}}
A{"TimelessIsle", 8518, criterion=23613, trivia={criteria="Yu'la, Broodling of Yu'lon", module="pet", category="Pet Battles/Battle", name="Master of the Masters", description="Defeat all the trainers listed below from the Celestial Tournament.", mapID="TimelessIsle", uiMapID=554, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Celestial Family
A{"TimelessIsle", 8519, 0.3500, 0.6000, criterion=23600, trivia={criteria="Xu-Fu, Cub of Xuen", module="pet", category="Pet Battles/Collect", name="Celestial Family", description="Obtain all four of the celestial pets.", mapID="TimelessIsle", uiMapID=554, points=5, parent="Pet Battles", type=96}}
A{"TimelessIsle", 8519, 0.3500, 0.6100, criterion=23719, trivia={criteria="Chi-Chi, Hatchling of Chi-Ji", module="pet", category="Pet Battles/Collect", name="Celestial Family", description="Obtain all four of the celestial pets.", mapID="TimelessIsle", uiMapID=554, points=5, parent="Pet Battles", type=96}}
A{"TimelessIsle", 8519, 0.3500, 0.6200, criterion=23720, trivia={criteria="Yu'la, Broodling of Yu'lon", module="pet", category="Pet Battles/Collect", name="Celestial Family", description="Obtain all four of the celestial pets.", mapID="TimelessIsle", uiMapID=554, points=5, parent="Pet Battles", type=96}}
A{"TimelessIsle", 8519, 0.3500, 0.6300, criterion=23721, trivia={criteria="Zao, Calfling of Niuzao", module="pet", category="Pet Battles/Collect", name="Celestial Family", description="Obtain all four of the celestial pets.", mapID="TimelessIsle", uiMapID=554, points=5, parent="Pet Battles", type=96}}

-- Pet Battles/Battle: An Awfully Big Adventure
A{"TimelessIsle", 9069, 0.4020, 0.5640, criterion=26971, trivia={criteria="Blingtron 4000", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="TimelessIsle", uiMapID=554, points=10, parent="Pet Battles", type=158}}
A{"TimelessIsle", 9069, criterion=26975, trivia={criteria="Chen Stormstout", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="TimelessIsle", uiMapID=554, points=10, parent="Pet Battles", type=158}}
A{"TimelessIsle", 9069, 0.4020, 0.5620, criterion=26979, trivia={criteria="Dr. Ion Goldbloom", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="TimelessIsle", uiMapID=554, points=10, parent="Pet Battles", type=158}}
A{"TimelessIsle", 9069, 0.4000, 0.5260, criterion=26987, trivia={criteria="Lorewalker Cho", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="TimelessIsle", uiMapID=554, points=10, parent="Pet Battles", type=158}}
A{"TimelessIsle", 9069, 0.3780, 0.5720, criterion=26999, trivia={criteria="Shademaster Kiryn", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="TimelessIsle", uiMapID=554, points=10, parent="Pet Battles", type=158}}
A{"TimelessIsle", 9069, 0.3780, 0.5720, criterion=27001, trivia={criteria="Sully \"The Pickle\" McLeary", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="TimelessIsle", uiMapID=554, points=10, parent="Pet Battles", type=158}}
A{"TimelessIsle", 9069, 0.4000, 0.5260, criterion=27003, trivia={criteria="Taran Zhu", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="TimelessIsle", uiMapID=554, points=10, parent="Pet Battles", type=158}}
A{"TimelessIsle", 9069, 0.4000, 0.5260, criterion=27009, trivia={criteria="Wise Mari", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="TimelessIsle", uiMapID=554, points=10, parent="Pet Battles", type=158}}
A{"TimelessIsle", 9069, 0.3780, 0.5720, criterion=27010, trivia={criteria="Wrathion", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="TimelessIsle", uiMapID=554, points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Tirisfal", 6558, criterion=21566, trivia={criteria="Tirisfal Glades", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="TirisfalGlades", uiMapID=18, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Tirisfal", 6559, criterion=21566, trivia={criteria="Tirisfal Glades", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="TirisfalGlades", uiMapID=18, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Tirisfal", 6560, criterion=21566, trivia={criteria="Tirisfal Glades", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="TirisfalGlades", uiMapID=18, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Eastern Kingdoms Safari
A{"Tirisfal", 6586, 0.8300, 0.7000, criterion=21676, note="zone exclusive\nfound in Tirisfal and Undercity", trivia={criteria="Lost of Lordaeron", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="TirisfalGlades", uiMapID=18, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Eastern Kingdoms Tamer
A{"Tirisfal", 6613, criterion=21445, trivia={criteria="Tirisfal Glades", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Tamer", description="Capture a battle pet in each of the Eastern Kingdoms zones listed below.", mapID="TirisfalGlades", uiMapID=18, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Local Pet Mauler
A{"TownlongWastes", 6558, criterion=21592, trivia={criteria="Townlong Steppes", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="TownlongSteppes", uiMapID=388, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"TownlongWastes", 6559, criterion=21592, trivia={criteria="Townlong Steppes", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="TownlongSteppes", uiMapID=388, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"TownlongWastes", 6560, criterion=21592, trivia={criteria="Townlong Steppes", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="TownlongSteppes", uiMapID=388, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Pandaria Safari
A{"TownlongWastes", 6589, criterion=21833, note="zone exclusive", trivia={criteria="Grassland Hopper", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="TownlongSteppes", uiMapID=388, points=5, parent="Pet Battles", type="catch"}}
A{"TownlongWastes", 6589, criterion=21834, note="zone exclusive", trivia={criteria="Kuitan Mongoose", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="TownlongSteppes", uiMapID=388, points=5, parent="Pet Battles", type="catch"}}
A{"TownlongWastes", 6589, criterion=21835, note="zone exclusive", trivia={criteria="Mongoose", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="TownlongSteppes", uiMapID=388, points=5, parent="Pet Battles", type="catch"}}
A{"TownlongWastes", 6589, criterion=21836, note="zone exclusive", trivia={criteria="Mongoose Pup", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="TownlongSteppes", uiMapID=388, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Pandaria
A{"TownlongWastes", 6606, 0.3600, 0.5200, criterion=21870, trivia={criteria="Seeker Zusshi", module="pet", category="Pet Battles", name="Taming Pandaria", description="Defeat all of the Pet Tamers in Pandaria listed below.", mapID="TownlongSteppes", uiMapID=388, points=5, type=158}}

-- Pet Battles/Collect: Pandaria Tamer
A{"TownlongWastes", 6616, criterion=21493, trivia={criteria="Townlong Steppes", module="pet", category="Pet Battles/Collect", name="Pandaria Tamer", description="Capture a battle pet in each of the Pandaria zones listed below.", mapID="TownlongSteppes", uiMapID=388, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"TownlongWastes", 8348, 0.3600, 0.5200, criterion=23487, trivia={criteria="Grand Master Zusshi", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="TownlongSteppes", uiMapID=388, points=10, type="quest"}}
A{"TownlongWastes", 8348, 0.5700, 0.4200, criterion=23495, trivia={criteria="Burning Pandaren Spirit", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="TownlongSteppes", uiMapID=388, points=10, type="quest"}}
A{"TownlongWastes", 8348, 0.7200, 0.8000, criterion=23500, note="[3 beasts]", trivia={criteria="Ti'un the Wanderer", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="TownlongSteppes", uiMapID=388, points=10, type="quest"}}

-- Pet Battles/Battle: An Awfully Big Adventure
A{"TownlongWastes", 9069, 0.5700, 0.4220, criterion=26974, trivia={criteria="Burning Pandaren Spirit", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="TownlongSteppes", uiMapID=388, points=10, parent="Pet Battles", type=158}}
A{"TownlongWastes", 9069, 0.3620, 0.5220, criterion=26998, trivia={criteria="Seeker Zusshi", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="TownlongSteppes", uiMapID=388, points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Battle: Local Pet Mauler
A{"TwilightHighlands", 6558, criterion=21561, trivia={criteria="Twilight Highlands", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="TwilightHighlands", uiMapID=241, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"TwilightHighlands", 6559, criterion=21561, trivia={criteria="Twilight Highlands", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="TwilightHighlands", uiMapID=241, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"TwilightHighlands", 6560, criterion=21561, trivia={criteria="Twilight Highlands", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="TwilightHighlands", uiMapID=241, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Eastern Kingdoms Safari
A{"TwilightHighlands", 6586, criterion=21679, note="also found in Grizzly Hills and Howling Fjord", trivia={criteria="Grizzly Squirrel", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="TwilightHighlands", uiMapID=241, points=5, parent="Pet Battles", type="catch"}}
A{"TwilightHighlands", 6586, criterion=21683, note="zone exclusive", trivia={criteria="Twilight Fiendling", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="TwilightHighlands", uiMapID=241, points=5, parent="Pet Battles", type="catch"}}
A{"TwilightHighlands", 6586, criterion=21684, note="also found in Deepholm and Azshara", trivia={criteria="Twilight Spider", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="TwilightHighlands", uiMapID=241, points=5, parent="Pet Battles", type="catch"}}
A{"TwilightHighlands", 6586, criterion=21680, note="zone exclusive", trivia={criteria="Highlands Mouse", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="TwilightHighlands", uiMapID=241, points=5, parent="Pet Battles", type="catch"}}
A{"TwilightHighlands", 6586, criterion=21681, note="zone exclusive", trivia={criteria="Highlands Skunk", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="TwilightHighlands", uiMapID=241, points=5, parent="Pet Battles", type="catch"}}
A{"TwilightHighlands", 6586, criterion=21682, note="zone exclusive", trivia={criteria="Highlands Turkey", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="TwilightHighlands", uiMapID=241, points=5, parent="Pet Battles", type="catch"}}
A{"TwilightHighlands", 6586, criterion=21685, note="zone exclusive", trivia={criteria="Wildhammer Gryphon Hatchling", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="TwilightHighlands", uiMapID=241, points=5, parent="Pet Battles", type="catch"}}
A{"TwilightHighlands", 6586, criterion=21686, note="zone exclusive", trivia={criteria="Yellow-Bellied Marmot", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="TwilightHighlands", uiMapID=241, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Eastern Kingdoms Tamer
A{"TwilightHighlands", 6613, criterion=21486, trivia={criteria="Twilight Highlands", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Tamer", description="Capture a battle pet in each of the Eastern Kingdoms zones listed below.", mapID="TwilightHighlands", uiMapID=241, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: Taming Cataclysm
A{"TwilightHighlands", 7525, 0.5700, 0.5700, criterion=21860, trivia={criteria="Goz Banefury", module="pet", category="Pet Battles", name="Taming Cataclysm", description="Defeat all of the Pet Tamers in Cataclysm listed below.", mapID="TwilightHighlands", uiMapID=241, points=5, type=158}}

-- Pet Battles: The Longest Day
A{"TwilightHighlands", 8348, 0.5700, 0.5700, criterion=23485, trivia={criteria="Goz Banefury", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="TwilightHighlands", uiMapID=241, points=10, type="quest"}}

-- Pet Battles/Battle: An Awfully Big Adventure
A{"TwilightHighlands", 9069, 0.5660, 0.5680, criterion=26983, trivia={criteria="Goz Banefury", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="TwilightHighlands", uiMapID=241, points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Uldum", 6558, criterion=21541, trivia={criteria="Uldum", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="Uldum", uiMapID=249, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Uldum", 6559, criterion=21541, trivia={criteria="Uldum", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="Uldum", uiMapID=249, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Uldum", 6560, criterion=21541, trivia={criteria="Uldum", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="Uldum", uiMapID=249, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Kalimdor Safari
A{"Uldum", 6585, criterion=21701, note="zone exclusive", trivia={criteria="Horned Lizard", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="Uldum", uiMapID=249, points=5, parent="Pet Battles", type="catch"}}
A{"Uldum", 6585, criterion=21751, note="zone exclusive", trivia={criteria="Leopard Scorpid", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="Uldum", uiMapID=249, points=5, parent="Pet Battles", type="catch"}}
A{"Uldum", 6585, 0.5800, 0.5200, criterion=21752, note="zone exclusive", trivia={criteria="Locust", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="Uldum", uiMapID=249, points=5, parent="Pet Battles", type="catch"}}
A{"Uldum", 6585, 0.5800, 0.5300, criterion=21753, note="zone exclusive", trivia={criteria="Mac Frog", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="Uldum", uiMapID=249, points=5, parent="Pet Battles", type="catch"}}
A{"Uldum", 6585, 0.6200, 0.3900, criterion=21754, note="zone exclusive", trivia={criteria="Oasis Moth", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="Uldum", uiMapID=249, points=5, parent="Pet Battles", type="catch"}}
A{"Uldum", 6585, 0.4100, 0.4500, criterion=21755, note="zone exclusive", trivia={criteria="Tol'vir Scarab", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="Uldum", uiMapID=249, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Kalimdor Tamer
A{"Uldum", 6612, criterion=21487, trivia={criteria="Uldum", module="pet", category="Pet Battles/Collect", name="Kalimdor Tamer", description="Capture a battle pet in each of the Kalimdor zones listed below.", mapID="Uldum", uiMapID=249, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: Taming Cataclysm
A{"Uldum", 7525, 0.5700, 0.4200, criterion=21861, trivia={criteria="Obalis", module="pet", category="Pet Battles", name="Taming Cataclysm", description="Defeat all of the Pet Tamers in Cataclysm listed below.", mapID="Uldum", uiMapID=249, points=5, type=158}}

-- Pet Battles: The Longest Day
A{"Uldum", 8348, 0.5700, 0.4200, criterion=23486, trivia={criteria="Grand Master Obalis", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="Uldum", uiMapID=249, points=10, type="quest"}}

-- Pet Battles/Battle: An Awfully Big Adventure
A{"Uldum", 9069, 0.5660, 0.4180, criterion=26995, trivia={criteria="Obalis", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="Uldum", uiMapID=249, points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Collect: Eastern Kingdoms Safari
A{"Undercity", 6586, criterion=21677, note="zone exclusive", trivia={criteria="Undercity Rat", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="Undercity", uiMapID=90, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Battle: Big City Pet Brawlin' - Horde
A{"Undercity", 6621, criterion=19851, trivia={criteria="Undercity", module="pet", category="Pet Battles/Battle", name="Big City Pet Brawlin' - Horde", description="Win a pet battle in each of the Horde cities listed below.", mapID="Undercity", uiMapID=90, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Crazy for Cats
A{"Undercity", 8397, 0.6800, 0.0700, criterion=23584, note="from Chub during Hallow's End", trivia={criteria="Feline Familiar", module="pet", category="Pet Battles/Collect", name="Crazy for Cats", description="Obtain 20 of the cats listed below.", mapID="Undercity", uiMapID=90, points=10, parent="Pet Battles", type=96}}

-- Pet Battles/Battle: Local Pet Mauler
A{"UngoroCrater", 6558, criterion=21534, trivia={criteria="Un'goro Crater", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="UnGoroCrater", uiMapID=78, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"UngoroCrater", 6559, criterion=21534, trivia={criteria="Un'goro Crater", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="UnGoroCrater", uiMapID=78, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"UngoroCrater", 6560, criterion=21534, trivia={criteria="Un'goro Crater", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="UnGoroCrater", uiMapID=78, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Kalimdor Safari
A{"UngoroCrater", 6585, 0.3500, 0.6600, criterion=21750, note="zone exclusive", trivia={criteria="Diemetradon Hatchling", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="UnGoroCrater", uiMapID=78, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Kalimdor Tamer
A{"UngoroCrater", 6612, criterion=21466, trivia={criteria="Un'Goro Crater", module="pet", category="Pet Battles/Collect", name="Kalimdor Tamer", description="Capture a battle pet in each of the Kalimdor zones listed below.", mapID="UnGoroCrater", uiMapID=78, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Plenty of Pets
A{"unknown", 15, criterion=19598, trivia={criteria="Obtain 15 unique companion pets", module="pet", category="Pet Battles/Collect", name="Plenty of Pets", description="Collect 15 unique pets.", points=10, parent="Pet Battles", type=156}}

-- Pet Battles/Collect: Can I Keep Him?
A{"unknown", 1017, criterion=19598, trivia={criteria="Obtain a companion pet", module="pet", category="Pet Battles/Collect", name="Can I Keep Him?", description="Obtain a pet.", points=10, parent="Pet Battles", type=156}}

-- Pet Battles/Collect: Plethora of Pets
A{"unknown", 1248, criterion=19598, trivia={criteria="Obtain 25 unique companion pets", module="pet", category="Pet Battles/Collect", name="Plethora of Pets", description="Collect 25 unique pets.", points=10, parent="Pet Battles", type=156}}

-- Pet Battles/Collect: Shop Smart, Shop Pet...Smart
A{"unknown", 1250, criterion=19598, trivia={criteria="Obtain 50 unique companion pets", module="pet", category="Pet Battles/Collect", name="Shop Smart, Shop Pet...Smart", description="Collect 50 unique pets.", points=10, parent="Pet Battles", type=156}}

-- Pet Battles/Collect: Lil' Game Hunter
A{"unknown", 2516, criterion=19598, trivia={criteria="Collect 75 unique pets.", module="pet", category="Pet Battles/Collect", name="Lil' Game Hunter", description="Collect 75 unique pets.", points=10, parent="Pet Battles", type=156}}

-- Pet Battles/Collect: Littlest Pet Shop
A{"unknown", 5875, criterion=19598, trivia={criteria="Collect 150 unique pets.", module="pet", category="Pet Battles/Collect", name="Littlest Pet Shop", description="Collect 150 unique pets.", points=10, parent="Pet Battles", type=156}}

-- Pet Battles/Collect: Petting Zoo
A{"unknown", 5876, criterion=19598, trivia={criteria="Collect 100 unique pets.", module="pet", category="Pet Battles/Collect", name="Petting Zoo", description="Collect 100 unique pets.", points=10, parent="Pet Battles", type=156}}

-- Pet Battles/Collect: Menagerie
A{"unknown", 5877, criterion=19598, trivia={criteria="Collect 125 unique pets.", module="pet", category="Pet Battles/Collect", name="Menagerie", description="Collect 125 unique pets.", points=10, parent="Pet Battles", type=156}}

-- Pet Battles/Battle: Master Pet Battler
A{"unknown", 6462, criterion=19724, trivia={module="pet", category="Pet Battles/Battle", name="Master Pet Battler", description="Win 250 pet battles.", points=5, parent="Pet Battles"}}

-- Pet Battles/Collect: He's Mine!
A{"unknown", 6554, trivia={module="pet", category="Pet Battles/Collect", name="He's Mine!", description="Capture 10 pets in pet battle.", points=5, parent="Pet Battles"}}

-- Pet Battles/Collect: Building a Team
A{"unknown", 6555, trivia={module="pet", category="Pet Battles/Collect", name="Building a Team", description="Capture 25 pets in pet battle.", points=5, parent="Pet Battles"}}

-- Pet Battles/Collect: Going to Need More Traps
A{"unknown", 6556, trivia={module="pet", category="Pet Battles/Collect", name="Going to Need More Traps", description="Capture 50 pets in a pet battle.", points=5, parent="Pet Battles"}}

-- Pet Battles/Collect: Master Pet Hunter
A{"unknown", 6557, trivia={module="pet", category="Pet Battles/Collect", name="Master Pet Hunter", description="Capture 100 pets in pet battle.", points=5, parent="Pet Battles"}}

-- Pet Battles/Level: Just a Pup
A{"unknown", 6566, trivia={module="pet", category="Pet Battles/Level", name="Just a Pup", description="Raise a pet to level 5.", points=5, parent="Pet Battles"}}

-- Pet Battles/Level: Growing Up
A{"unknown", 6567, trivia={module="pet", category="Pet Battles/Level", name="Growing Up", description="Raise a pet to level 10.", points=5, parent="Pet Battles"}}

-- Pet Battles/Level: Time for a Leash
A{"unknown", 6568, trivia={module="pet", category="Pet Battles/Level", name="Time for a Leash", description="Raise a pet to level 15.", points=5, parent="Pet Battles"}}

-- Pet Battles/Level: Old Timer
A{"unknown", 6569, trivia={module="pet", category="Pet Battles/Level", name="Old Timer", description="Raise a pet to level 20.", points=5, parent="Pet Battles"}}

-- Pet Battles/Level: All Growns Up!
A{"unknown", 6570, trivia={module="pet", category="Pet Battles/Level", name="All Growns Up!", description="Raise a pet to level 25.", points=10, parent="Pet Battles"}}

-- Pet Battles/Collect: That Was Close!
A{"unknown", 6571, trivia={module="pet", category="Pet Battles/Collect", name="That Was Close!", description="Capture a battle pet at less than 5% health.", points=5, parent="Pet Battles"}}

-- Pet Battles/Level: Pro Pet Group
A{"unknown", 6578, criterion=19856, trivia={module="pet", category="Pet Battles/Level", name="Pro Pet Group", description="Raise 15 pets to level 25.", points=5, parent="Pet Battles"}}

-- Pet Battles/Level: Rookie Pet Group
A{"unknown", 6579, criterion=19853, trivia={module="pet", category="Pet Battles/Level", name="Rookie Pet Group", description="Raise 15 pets to level 10.", points=5, parent="Pet Battles"}}

-- Pet Battles/Level: Rookie Pet Crew
A{"unknown", 6580, trivia={module="pet", category="Pet Battles/Level", name="Rookie Pet Crew", description="Raise 30 pets to level 10.", points=5, parent="Pet Battles"}}

-- Pet Battles/Level: Pro Pet Crew
A{"unknown", 6581, trivia={module="pet", category="Pet Battles/Level", name="Pro Pet Crew", description="Raise 30 pets to level 25.", points=5, parent="Pet Battles"}}

-- Pet Battles/Level: Pro Pet Mob
A{"unknown", 6582, trivia={module="pet", category="Pet Battles/Level", name="Pro Pet Mob", description="Raise 75 pets to level 25.", points=10, parent="Pet Battles"}}

-- Pet Battles/Level: Rookie Pet Mob
A{"unknown", 6583, trivia={module="pet", category="Pet Battles/Level", name="Rookie Pet Mob", description="Raise 75 pets to level 10.", points=10, parent="Pet Battles"}}

-- Pet Battles/Collect: Kalimdor Safari
A{"unknown", 6585, criterion=21615, trivia={criteria="Beetle", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21514, trivia={criteria="Maggot", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21516, trivia={criteria="Rat", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21517, trivia={criteria="Roach", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21522, trivia={criteria="Squirrel", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21659, trivia={criteria="Strand Crab", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21646, trivia={criteria="Toad", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21508, trivia={criteria="Rabbit", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21633, trivia={criteria="Skunk", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21521, trivia={criteria="Spider", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21651, trivia={criteria="Red-Tailed Chipmunk", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21629, trivia={criteria="Chicken", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21637, trivia={criteria="Infected Fawn", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21638, trivia={criteria="Infected Squirrel", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21518, trivia={criteria="Small Frog", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21509, trivia={criteria="Adder", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21612, trivia={criteria="Hare", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21511, trivia={criteria="Black Rat", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21684, trivia={criteria="Twilight Spider", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21631, trivia={criteria="Mouse", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21519, trivia={criteria="Snake", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21635, trivia={criteria="Bat", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21621, trivia={criteria="Fire Beetle", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21699, trivia={criteria="Rock Viper", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21700, trivia={criteria="Twilight Beetle", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21613, trivia={criteria="Prairie Dog", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21619, trivia={criteria="Spiky Lizard", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21688, trivia={criteria="Mountain Skunk", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21617, trivia={criteria="Rattlesnake", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21640, trivia={criteria="Sea Gull", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21620, trivia={criteria="Stripe-Tailed Scorpid", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21622, trivia={criteria="Scorpid", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21625, trivia={criteria="Cockroach", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21513, trivia={criteria="Long-Tailed Mole", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21657, trivia={criteria="Parrot", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21660, trivia={criteria="Tree Python", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21510, trivia={criteria="Alpine Hare", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21702, trivia={criteria="Forest Moth", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21704, trivia={criteria="Rabid Nut Varmint 5000", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21705, trivia={criteria="Robo-Chick", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21706, trivia={criteria="Shore Crab", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21712, trivia={criteria="Desert Spider", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21713, trivia={criteria="Elfin Rabbit", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21718, trivia={criteria="Topaz Shale Hatchling", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21719, trivia={criteria="Dung Beetle", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21720, trivia={criteria="Spiny Lizard", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21721, trivia={criteria="Spawn of Onyxia", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21723, trivia={criteria="Tainted Cockroach", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21727, trivia={criteria="Silky Moth", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21728, trivia={criteria="Alpine Chipmunk", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21729, trivia={criteria="Ash Lizard", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21738, trivia={criteria="Emerald Boa", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21741, trivia={criteria="Sidewinder", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21616, trivia={criteria="Gold Beetle", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21756, trivia={criteria="Spotted Bell Frog", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6585, criterion=21661, trivia={criteria="Water Snake", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Outland Safari
A{"unknown", 6587, criterion=21674, trivia={criteria="Brown Marmot", module="pet", category="Pet Battles/Collect", name="Outland Safari", description="Catch every battle pet in Outland.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6587, criterion=21716, trivia={criteria="Rock Viper", module="pet", category="Pet Battles/Collect", name="Outland Safari", description="Catch every battle pet in Outland.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6587, criterion=21622, trivia={criteria="Scorpid", module="pet", category="Pet Battles/Collect", name="Outland Safari", description="Catch every battle pet in Outland.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6587, criterion=21509, trivia={criteria="Adder", module="pet", category="Pet Battles/Collect", name="Outland Safari", description="Catch every battle pet in Outland.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6587, criterion=21613, trivia={criteria="Prairie Dog", module="pet", category="Pet Battles/Collect", name="Outland Safari", description="Catch every battle pet in Outland.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6587, criterion=21516, trivia={criteria="Rat", module="pet", category="Pet Battles/Collect", name="Outland Safari", description="Catch every battle pet in Outland.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6587, criterion=21610, trivia={criteria="Cat", module="pet", category="Pet Battles/Collect", name="Outland Safari", description="Catch every battle pet in Outland.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6587, criterion=21522, trivia={criteria="Squirrel", module="pet", category="Pet Battles/Collect", name="Outland Safari", description="Catch every battle pet in Outland.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6587, criterion=21519, trivia={criteria="Snake", module="pet", category="Pet Battles/Collect", name="Outland Safari", description="Catch every battle pet in Outland.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6587, criterion=21631, trivia={criteria="Mouse", module="pet", category="Pet Battles/Collect", name="Outland Safari", description="Catch every battle pet in Outland.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6587, criterion=21624, trivia={criteria="Ash Viper", module="pet", category="Pet Battles/Collect", name="Outland Safari", description="Catch every battle pet in Outland.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6587, criterion=21764, trivia={criteria="Fel Flame", module="pet", category="Pet Battles/Collect", name="Outland Safari", description="Catch every battle pet in Outland.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6587, criterion=21723, trivia={criteria="Tainted Cockroach", module="pet", category="Pet Battles/Collect", name="Outland Safari", description="Catch every battle pet in Outland.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6587, criterion=21633, trivia={criteria="Skunk", module="pet", category="Pet Battles/Collect", name="Outland Safari", description="Catch every battle pet in Outland.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6587, criterion=21620, trivia={criteria="Stripe-Tailed Scorpid", module="pet", category="Pet Battles/Collect", name="Outland Safari", description="Catch every battle pet in Outland.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6587, criterion=21518, trivia={criteria="Small Frog", module="pet", category="Pet Battles/Collect", name="Outland Safari", description="Catch every battle pet in Outland.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6587, criterion=21646, trivia={criteria="Toad", module="pet", category="Pet Battles/Collect", name="Outland Safari", description="Catch every battle pet in Outland.", points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Northrend Safari
A{"unknown", 6588, criterion=21767, trivia={criteria="Arctic Hare", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6588, criterion=21522, trivia={criteria="Squirrel", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6588, criterion=21629, trivia={criteria="Chicken", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6588, criterion=21659, trivia={criteria="Strand Crab", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6588, criterion=21508, trivia={criteria="Rabbit", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6588, criterion=21516, trivia={criteria="Rat", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6588, criterion=21639, trivia={criteria="Fawn", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6588, criterion=21706, trivia={criteria="Shore Crab", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6588, criterion=21679, trivia={criteria="Grizzly Squirrel", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6588, criterion=21631, trivia={criteria="Mouse", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6588, criterion=21688, trivia={criteria="Mountain Skunk", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6588, criterion=21514, trivia={criteria="Maggot", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6588, criterion=21517, trivia={criteria="Roach", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6588, criterion=21633, trivia={criteria="Skunk", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6588, criterion=21519, trivia={criteria="Snake", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6588, criterion=21521, trivia={criteria="Spider", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6588, criterion=21625, trivia={criteria="Cockroach", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6588, criterion=21770, trivia={criteria="Tundra Penguin", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6588, criterion=21646, trivia={criteria="Toad", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6588, criterion=21649, trivia={criteria="Huge Toad", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6588, criterion=21773, trivia={criteria="Devouring Maggot", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Pandaria Safari
A{"unknown", 6589, criterion=21789, trivia={criteria="Leopard Tree Frog", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6589, criterion=21800, trivia={criteria="Malayan Quillrat", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6589, criterion=21640, trivia={criteria="Sea Gull", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6589, criterion=21706, trivia={criteria="Shore Crab", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6589, criterion=21837, trivia={criteria="Yakrat", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 6589, criterion=21795, trivia={criteria="Silkbead Snail", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: World Safari
A{"unknown", 6590, criterion=19409, trivia={criteria="Eastern Kingdoms Safari", module="pet", category="Pet Battles/Collect", name="World Safari", description="Complete the Pet Safari achievements listed below.", points=10, parent="Pet Battles", type="achievement"}}
A{"unknown", 6590, criterion=19410, trivia={criteria="Kalimdor Safari", module="pet", category="Pet Battles/Collect", name="World Safari", description="Complete the Pet Safari achievements listed below.", points=10, parent="Pet Battles", type="achievement"}}
A{"unknown", 6590, criterion=19411, trivia={criteria="Northrend Safari", module="pet", category="Pet Battles/Collect", name="World Safari", description="Complete the Pet Safari achievements listed below.", points=10, parent="Pet Battles", type="achievement"}}
A{"unknown", 6590, criterion=19412, trivia={criteria="Outland Safari", module="pet", category="Pet Battles/Collect", name="World Safari", description="Complete the Pet Safari achievements listed below.", points=10, parent="Pet Battles", type="achievement"}}
A{"unknown", 6590, criterion=19416, trivia={criteria="Pandaria Safari", module="pet", category="Pet Battles/Collect", name="World Safari", description="Complete the Pet Safari achievements listed below.", points=10, parent="Pet Battles", type="achievement"}}

-- Pet Battles/Battle: Grand Master Pet Battler
A{"unknown", 6591, criterion=19724, trivia={module="pet", category="Pet Battles/Battle", name="Grand Master Pet Battler", description="Win 1000 pet battles.", points=5, parent="Pet Battles"}}

-- Pet Battles/Battle: Legendary Pet Battler
A{"unknown", 6592, trivia={module="pet", category="Pet Battles/Battle", name="Legendary Pet Battler", description="Win 5000 pet battles.", points=10, parent="Pet Battles"}}

-- Pet Battles/Battle: Experienced Pet Battler
A{"unknown", 6593, trivia={module="pet", category="Pet Battles/Battle", name="Experienced Pet Battler", description="Win 50 pet battles.", points=5, parent="Pet Battles"}}

-- Pet Battles/Battle: Cat Fight!
A{"unknown", 6594, trivia={module="pet", category="Pet Battles/Battle", name="Cat Fight!", description="Win 10 pet battles.", points=5, parent="Pet Battles"}}

-- Pet Battles/Battle: Pet Brawler
A{"unknown", 6595, criterion=21525, trivia={module="pet", category="Pet Battles/Battle", name="Pet Brawler", description="Win 10 PvP pet battles.", points=5, parent="Pet Battles"}}

-- Pet Battles/Battle: Experienced Pet Brawler
A{"unknown", 6596, trivia={module="pet", category="Pet Battles/Battle", name="Experienced Pet Brawler", description="Win 50 PvP pet battles.", points=5, parent="Pet Battles"}}

-- Pet Battles/Battle: Master Pet Brawler
A{"unknown", 6597, trivia={module="pet", category="Pet Battles/Battle", name="Master Pet Brawler", description="Win 250 PvP pet battles.", points=5, parent="Pet Battles"}}

-- Pet Battles/Battle: Grand Master Pet Brawler
A{"unknown", 6598, trivia={module="pet", category="Pet Battles/Battle", name="Grand Master Pet Brawler", description="Win 1000 PvP pet battles.", points=5, parent="Pet Battles"}}

-- Pet Battles/Battle: Legendary Pet Brawler
A{"unknown", 6599, trivia={module="pet", category="Pet Battles/Battle", name="Legendary Pet Brawler", description="Win 5000 PvP pet battles.", points=10, parent="Pet Battles"}}

-- Pet Battles: Ultimate Trainer
A{"unknown", 6600, criterion=21256, trivia={module="pet", category="Pet Battles", name="Ultimate Trainer", description="Earn 300 pet battle achievement points.", points=5}}

-- Pet Battles: Taming the Wild
A{"unknown", 6601, trivia={module="pet", category="Pet Battles", name="Taming the Wild", description="Defeat a master pet tamer.", points=5}}

-- Pet Battles: Taming Azeroth
A{"unknown", 6607, criterion=19421, trivia={criteria="Taming Outland", module="pet", category="Pet Battles", name="Taming Azeroth", description="Complete all of the Taming achievements listed below.", points=10, type="achievement"}}
A{"unknown", 6607, criterion=19420, trivia={criteria="Taming Northrend", module="pet", category="Pet Battles", name="Taming Azeroth", description="Complete all of the Taming achievements listed below.", points=10, type="achievement"}}
A{"unknown", 6607, criterion=19422, trivia={criteria="Taming Pandaria", module="pet", category="Pet Battles", name="Taming Azeroth", description="Complete all of the Taming achievements listed below.", points=10, type="achievement"}}
A{"unknown", 6607, criterion=21862, trivia={criteria="Taming Cataclsym", module="pet", category="Pet Battles", name="Taming Azeroth", description="Complete all of the Taming achievements listed below.", points=10, type="achievement"}}
A{"unknown", 6607, criterion=19418, side="alliance", trivia={criteria="Taming Eastern Kingdoms", module="pet", category="Pet Battles", name="Taming Azeroth", description="Complete all of the Taming achievements listed below.", points=10, type="achievement"}}
A{"unknown", 6607, criterion=19419, side="horde", trivia={criteria="Taming Kalimdor", module="pet", category="Pet Battles", name="Taming Azeroth", description="Complete all of the Taming achievements listed below.", points=10, type="achievement"}}

-- Pet Battles/Collect: Family Reunion
A{"unknown", 6608, criterion=19750, trivia={criteria="Humanoid", module="pet", category="Pet Battles/Collect", name="Family Reunion", description="Capture a battle pet from each family.", points=10, parent="Pet Battles", type=157}}
A{"unknown", 6608, criterion=19751, trivia={criteria="Dragonkin", module="pet", category="Pet Battles/Collect", name="Family Reunion", description="Capture a battle pet from each family.", points=10, parent="Pet Battles", type=157}}
A{"unknown", 6608, criterion=19753, trivia={criteria="Flying", module="pet", category="Pet Battles/Collect", name="Family Reunion", description="Capture a battle pet from each family.", points=10, parent="Pet Battles", type=157}}
A{"unknown", 6608, criterion=19752, trivia={criteria="Undead", module="pet", category="Pet Battles/Collect", name="Family Reunion", description="Capture a battle pet from each family.", points=10, parent="Pet Battles", type=157}}
A{"unknown", 6608, criterion=19754, trivia={criteria="Critter", module="pet", category="Pet Battles/Collect", name="Family Reunion", description="Capture a battle pet from each family.", points=10, parent="Pet Battles", type=157}}
A{"unknown", 6608, criterion=19755, trivia={criteria="Magic", module="pet", category="Pet Battles/Collect", name="Family Reunion", description="Capture a battle pet from each family.", points=10, parent="Pet Battles", type=157}}
A{"unknown", 6608, criterion=19756, trivia={criteria="Elemental", module="pet", category="Pet Battles/Collect", name="Family Reunion", description="Capture a battle pet from each family.", points=10, parent="Pet Battles", type=157}}
A{"unknown", 6608, criterion=19757, trivia={criteria="Beast", module="pet", category="Pet Battles/Collect", name="Family Reunion", description="Capture a battle pet from each family.", points=10, parent="Pet Battles", type=157}}
A{"unknown", 6608, criterion=19758, trivia={criteria="Aquatic", module="pet", category="Pet Battles/Collect", name="Family Reunion", description="Capture a battle pet from each family.", points=10, parent="Pet Battles", type=157}}
A{"unknown", 6608, criterion=19759, trivia={criteria="Mechanical", module="pet", category="Pet Battles/Collect", name="Family Reunion", description="Capture a battle pet from each family.", points=10, parent="Pet Battles", type=157}}

-- Pet Battles/Level: No Favorites
A{"unknown", 6609, criterion=21360, trivia={criteria="Aquatic", module="pet", category="Pet Battles/Level", name="No Favorites", description="Raise a pet of every family to level 10.", points=5, parent="Pet Battles", type=160}}
A{"unknown", 6609, criterion=21361, trivia={criteria="Beast", module="pet", category="Pet Battles/Level", name="No Favorites", description="Raise a pet of every family to level 10.", points=5, parent="Pet Battles", type=160}}
A{"unknown", 6609, criterion=21362, trivia={criteria="Critter", module="pet", category="Pet Battles/Level", name="No Favorites", description="Raise a pet of every family to level 10.", points=5, parent="Pet Battles", type=160}}
A{"unknown", 6609, criterion=21363, trivia={criteria="Dragonkin", module="pet", category="Pet Battles/Level", name="No Favorites", description="Raise a pet of every family to level 10.", points=5, parent="Pet Battles", type=160}}
A{"unknown", 6609, criterion=21364, trivia={criteria="Elemental", module="pet", category="Pet Battles/Level", name="No Favorites", description="Raise a pet of every family to level 10.", points=5, parent="Pet Battles", type=160}}
A{"unknown", 6609, criterion=21365, trivia={criteria="Flying", module="pet", category="Pet Battles/Level", name="No Favorites", description="Raise a pet of every family to level 10.", points=5, parent="Pet Battles", type=160}}
A{"unknown", 6609, criterion=21366, trivia={criteria="Humanoid", module="pet", category="Pet Battles/Level", name="No Favorites", description="Raise a pet of every family to level 10.", points=5, parent="Pet Battles", type=160}}
A{"unknown", 6609, criterion=21367, trivia={criteria="Mechanical", module="pet", category="Pet Battles/Level", name="No Favorites", description="Raise a pet of every family to level 10.", points=5, parent="Pet Battles", type=160}}
A{"unknown", 6609, criterion=21368, trivia={criteria="Magic", module="pet", category="Pet Battles/Level", name="No Favorites", description="Raise a pet of every family to level 10.", points=5, parent="Pet Battles", type=160}}
A{"unknown", 6609, criterion=21369, trivia={criteria="Undead", module="pet", category="Pet Battles/Level", name="No Favorites", description="Raise a pet of every family to level 10.", points=5, parent="Pet Battles", type=160}}

-- Pet Battles/Level: All Pets Allowed
A{"unknown", 6610, criterion=21370, trivia={criteria="Aquatic", module="pet", category="Pet Battles/Level", name="All Pets Allowed", description="Raise a pet of every family to level 25.", points=10, parent="Pet Battles", type=160}}
A{"unknown", 6610, criterion=21371, trivia={criteria="Beast", module="pet", category="Pet Battles/Level", name="All Pets Allowed", description="Raise a pet of every family to level 25.", points=10, parent="Pet Battles", type=160}}
A{"unknown", 6610, criterion=21372, trivia={criteria="Critter", module="pet", category="Pet Battles/Level", name="All Pets Allowed", description="Raise a pet of every family to level 25.", points=10, parent="Pet Battles", type=160}}
A{"unknown", 6610, criterion=21373, trivia={criteria="Dragonkin", module="pet", category="Pet Battles/Level", name="All Pets Allowed", description="Raise a pet of every family to level 25.", points=10, parent="Pet Battles", type=160}}
A{"unknown", 6610, criterion=21374, trivia={criteria="Elemental", module="pet", category="Pet Battles/Level", name="All Pets Allowed", description="Raise a pet of every family to level 25.", points=10, parent="Pet Battles", type=160}}
A{"unknown", 6610, criterion=21375, trivia={criteria="Flying", module="pet", category="Pet Battles/Level", name="All Pets Allowed", description="Raise a pet of every family to level 25.", points=10, parent="Pet Battles", type=160}}
A{"unknown", 6610, criterion=21376, trivia={criteria="Humanoid", module="pet", category="Pet Battles/Level", name="All Pets Allowed", description="Raise a pet of every family to level 25.", points=10, parent="Pet Battles", type=160}}
A{"unknown", 6610, criterion=21377, trivia={criteria="Mechanical", module="pet", category="Pet Battles/Level", name="All Pets Allowed", description="Raise a pet of every family to level 25.", points=10, parent="Pet Battles", type=160}}
A{"unknown", 6610, criterion=21378, trivia={criteria="Magic", module="pet", category="Pet Battles/Level", name="All Pets Allowed", description="Raise a pet of every family to level 25.", points=10, parent="Pet Battles", type=160}}
A{"unknown", 6610, criterion=21379, trivia={criteria="Undead", module="pet", category="Pet Battles/Level", name="All Pets Allowed", description="Raise a pet of every family to level 25.", points=10, parent="Pet Battles", type=160}}

-- Pet Battles/Collect: Continental Tamer
A{"unknown", 6611, criterion=19429, trivia={criteria="Eastern Kingdoms Pet Mauler", module="pet", category="Pet Battles/Collect", name="Continental Tamer", description="Complete all of the pet battle tamer achievements listed below.", points=10, parent="Pet Battles", type="achievement"}}
A{"unknown", 6611, criterion=19430, trivia={criteria="Kalimdor Pet Mauler", module="pet", category="Pet Battles/Collect", name="Continental Tamer", description="Complete all of the pet battle tamer achievements listed below.", points=10, parent="Pet Battles", type="achievement"}}
A{"unknown", 6611, criterion=19431, trivia={criteria="Outland Pet Mauler", module="pet", category="Pet Battles/Collect", name="Continental Tamer", description="Complete all of the pet battle tamer achievements listed below.", points=10, parent="Pet Battles", type="achievement"}}
A{"unknown", 6611, criterion=19432, trivia={criteria="Northrend Pet Mauler", module="pet", category="Pet Battles/Collect", name="Continental Tamer", description="Complete all of the pet battle tamer achievements listed below.", points=10, parent="Pet Battles", type="achievement"}}
A{"unknown", 6611, criterion=19433, trivia={criteria="Pandaria Pet Mauler", module="pet", category="Pet Battles/Collect", name="Continental Tamer", description="Complete all of the pet battle tamer achievements listed below.", points=10, parent="Pet Battles", type="achievement"}}

-- Pet Battles/Battle: On A Roll
A{"unknown", 6618, trivia={module="pet", category="Pet Battles/Battle", name="On A Roll", description="Win 10 consecutive pet battles.", points=5, parent="Pet Battles"}}

-- Pet Battles/Battle: Win Streak
A{"unknown", 6619, criterion=21527, trivia={module="pet", category="Pet Battles/Battle", name="Win Streak", description="Win 25 consecutive pet battles.", points=10, parent="Pet Battles"}}

-- Pet Battles/Battle: No Time To Heal
A{"unknown", 6620, criterion=22225, trivia={module="pet", category="Pet Battles/Battle", name="No Time To Heal", description="Win 5 consecutive PvP pet battles without letting a pet die.", points=10, parent="Pet Battles"}}

-- Pet Battles/Battle: Big City Pet Brawler
A{"unknown", 6622, criterion=19435, trivia={criteria="Big City Pet Brawlin' - Alliance", module="pet", category="Pet Battles/Battle", name="Big City Pet Brawler", description="Complete each of the Big City Pet Brawlin' achievements listed below.", points=10, parent="Pet Battles", type="achievement"}}
A{"unknown", 6622, criterion=19436, trivia={criteria="Big City Pet Brawlin' - Horde", module="pet", category="Pet Battles/Battle", name="Big City Pet Brawler", description="Complete each of the Big City Pet Brawlin' achievements listed below.", points=10, parent="Pet Battles", type="achievement"}}

-- Pet Battles/Battle: Take 'Em All On!
A{"unknown", 6851, criterion=19835, trivia={criteria="Aquatic", module="pet", category="Pet Battles/Battle", name="Take 'Em All On!", description="Win a solo pet battle against a pet of every family.", points=10, parent="Pet Battles", type=158}}
A{"unknown", 6851, criterion=19836, trivia={criteria="Beast", module="pet", category="Pet Battles/Battle", name="Take 'Em All On!", description="Win a solo pet battle against a pet of every family.", points=10, parent="Pet Battles", type=158}}
A{"unknown", 6851, criterion=19837, trivia={criteria="Critter", module="pet", category="Pet Battles/Battle", name="Take 'Em All On!", description="Win a solo pet battle against a pet of every family.", points=10, parent="Pet Battles", type=158}}
A{"unknown", 6851, criterion=19838, trivia={criteria="Dragonkin", module="pet", category="Pet Battles/Battle", name="Take 'Em All On!", description="Win a solo pet battle against a pet of every family.", points=10, parent="Pet Battles", type=158}}
A{"unknown", 6851, criterion=19839, trivia={criteria="Elemental", module="pet", category="Pet Battles/Battle", name="Take 'Em All On!", description="Win a solo pet battle against a pet of every family.", points=10, parent="Pet Battles", type=158}}
A{"unknown", 6851, criterion=19840, trivia={criteria="Flying", module="pet", category="Pet Battles/Battle", name="Take 'Em All On!", description="Win a solo pet battle against a pet of every family.", points=10, parent="Pet Battles", type=158}}
A{"unknown", 6851, criterion=19841, trivia={criteria="Humanoid", module="pet", category="Pet Battles/Battle", name="Take 'Em All On!", description="Win a solo pet battle against a pet of every family.", points=10, parent="Pet Battles", type=158}}
A{"unknown", 6851, criterion=19842, trivia={criteria="Magic", module="pet", category="Pet Battles/Battle", name="Take 'Em All On!", description="Win a solo pet battle against a pet of every family.", points=10, parent="Pet Battles", type=158}}
A{"unknown", 6851, criterion=19843, trivia={criteria="Mechanical", module="pet", category="Pet Battles/Battle", name="Take 'Em All On!", description="Win a solo pet battle against a pet of every family.", points=10, parent="Pet Battles", type=158}}
A{"unknown", 6851, criterion=19844, trivia={criteria="Undead", module="pet", category="Pet Battles/Battle", name="Take 'Em All On!", description="Win a solo pet battle against a pet of every family.", points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Level: Newbie
A{"unknown", 7433, trivia={module="pet", category="Pet Battles/Level", name="Newbie", description="Raise a pet to level 3.", points=5, parent="Pet Battles"}}

-- Pet Battles/Collect: Zen Pet Hunter
A{"unknown", 7436, criterion=19749, trivia={module="pet", category="Pet Battles/Collect", name="Zen Pet Hunter", description="Capture 200 pets in pet battle.", points=10, parent="Pet Battles"}}

-- Pet Battles/Collect: A Rare Catch
A{"unknown", 7462, trivia={module="pet", category="Pet Battles/Collect", name="A Rare Catch", description="Capture a rare quality battle pet.", points=5, parent="Pet Battles"}}

-- Pet Battles/Collect: High Quality
A{"unknown", 7463, trivia={module="pet", category="Pet Battles/Collect", name="High Quality", description="Capture 10 rare quality battle pets.", points=5, parent="Pet Battles"}}

-- Pet Battles/Collect: Quality & Quantity
A{"unknown", 7464, criterion=21238, trivia={module="pet", category="Pet Battles/Collect", name="Quality & Quantity", description="Capture 50 rare quality battle pets.", points=10, parent="Pet Battles"}}

-- Pet Battles/Collect: An Uncommon Find
A{"unknown", 7465, trivia={module="pet", category="Pet Battles/Collect", name="An Uncommon Find", description="Capture an uncommon quality battle pet.", points=5, parent="Pet Battles"}}

-- Pet Battles: Trainer Extraordinaire
A{"unknown", 7482, trivia={module="pet", category="Pet Battles", name="Trainer Extraordinaire", description="Earn 100 pet battle achievement points.", points=5}}

-- Pet Battles: Battle Master
A{"unknown", 7483, trivia={module="pet", category="Pet Battles", name="Battle Master", description="Earn 200 pet battle achievement points.", points=5}}

-- Pet Battles: Taming the Great Outdoors
A{"unknown", 7498, trivia={module="pet", category="Pet Battles", name="Taming the Great Outdoors", description="Defeat 15 master pet tamers.", points=5}}

-- Pet Battles: Taming the World
A{"unknown", 7499, trivia={module="pet", category="Pet Battles", name="Taming the World", description="Defeat 40 master pet tamers.", points=10}}

-- Pet Battles/Collect: Going to Need More Leashes
A{"unknown", 7500, criterion=19598, trivia={criteria="Collect 250 unique pets.", module="pet", category="Pet Battles/Collect", name="Going to Need More Leashes", description="Collect 250 unique pets.", points=10, parent="Pet Battles", type=156}}

-- Pet Battles/Collect: That's a Lot of Pet Food
A{"unknown", 7501, criterion=19598, trivia={criteria="Collect 400 unique pets.", module="pet", category="Pet Battles/Collect", name="That's a Lot of Pet Food", description="Collect 400 unique pets.", points=10, parent="Pet Battles", type=156}}

-- Pet Battles: Time to Open a Pet Store
A{"unknown", 7521, criterion=21256, trivia={module="pet", category="Pet Battles", name="Time to Open a Pet Store", description="Earn 400 pet battle achievement points.", points=10}}

-- Pet Battles: I Choose You
A{"unknown", 7908, trivia={module="pet", category="Pet Battles", name="I Choose You", description="Complete the Grand Master Aki quest.", points=5}}

-- Pet Battles: Pandaren Spirit Tamer
A{"unknown", 7936, trivia={module="pet", category="Pet Battles", name="Pandaren Spirit Tamer", description="Complete the Pandaren Spirit Tamer quest.", points=5}}

-- Pet Battles: Fabled Pandaren Tamer
A{"unknown", 8080, trivia={module="pet", category="Pet Battles", name="Fabled Pandaren Tamer", description="Complete the Beasts of Fable quest.", points=5}}

-- Pet Battles/Battle: Merciless Pet Brawler
A{"unknown", 8297, criterion=23306, trivia={criteria="PvP Pet Battles Won", module="pet", category="Pet Battles/Battle", name="Merciless Pet Brawler", description="Win 10 PvP pet battles through Find Battle with a full team of level 25 pets.", points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Battle: Vengeful Pet Brawler
A{"unknown", 8298, criterion=23306, trivia={criteria="PvP Pet Battles Won", module="pet", category="Pet Battles/Battle", name="Vengeful Pet Brawler", description="Win 50 PvP pet battles through Find Battle with a full team of level 25 pets.", points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Battle: Brutal Pet Brawler
A{"unknown", 8300, criterion=23306, trivia={criteria="PvP Pet Battles Won", module="pet", category="Pet Battles/Battle", name="Brutal Pet Brawler", description="Win 250 PvP pet battles through Find Battle with a full team of level 25 pets.", points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Battle: Deadly Pet Brawler
A{"unknown", 8301, criterion=23306, trivia={criteria="PvP Pet Battles Won", module="pet", category="Pet Battles/Battle", name="Deadly Pet Brawler", description="Win 1000 PvP pet battles through Find Battle with a full team of level 25 pets.", points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Collect: Crazy for Cats
A{"unknown", 8397, criterion=23596, note="purchased in Blizzard Pet Store", trivia={criteria="Cinder Kitten", module="pet", category="Pet Battles/Collect", name="Crazy for Cats", description="Obtain 20 of the cats listed below.", points=10, parent="Pet Battles", type=96}}
A{"unknown", 8397, criterion=23586, note="achievement reward from Raiding with Leashes", trivia={criteria="Mr. Bigglesworth", module="pet", category="Pet Battles/Collect", name="Crazy for Cats", description="Obtain 20 of the cats listed below.", points=10, parent="Pet Battles", type=96}}
A{"unknown", 8397, criterion=23597, note="redemed from TCG", trivia={criteria="Nightsaber Cub", module="pet", category="Pet Battles/Collect", name="Crazy for Cats", description="Obtain 20 of the cats listed below.", points=10, parent="Pet Battles", type=96}}
A{"unknown", 8397, criterion=23590, note="crafted by Jewelcrafting", trivia={criteria="Sapphire Cub", module="pet", category="Pet Battles/Collect", name="Crazy for Cats", description="Obtain 20 of the cats listed below.", points=10, parent="Pet Battles", type=96}}
A{"unknown", 8397, criterion=23599, note="promotion from Battle.Net world championship 2012", trivia={criteria="Spectral Cub", module="pet", category="Pet Battles/Collect", name="Crazy for Cats", description="Obtain 20 of the cats listed below.", points=10, parent="Pet Battles", type=96}}
A{"unknown", 8397, criterion=23598, note="redemed from TCG", trivia={criteria="Spectral Tiger Cub", module="pet", category="Pet Battles/Collect", name="Crazy for Cats", description="Obtain 20 of the cats listed below.", points=10, parent="Pet Battles", type=96}}
A{"unknown", 8397, criterion=23740, note="purchased in Blizzard Pet Store.  no longer for sale.", trivia={criteria="Guardian Cub", module="pet", category="Pet Battles/Collect", name="Crazy for Cats", description="Obtain 20 of the cats listed below.", points=10, parent="Pet Battles", type=96}}

-- Pet Battles/Battle: The Celestial Tournament
A{"unknown", 8410, trivia={module="pet", category="Pet Battles/Battle", name="The Celestial Tournament", description="Complete the Celestial Tournament scenario.", points=10, parent="Pet Battles"}}

-- Pet Battles/Level: Overstuffed
A{"unknown", 9070, trivia={module="pet", category="Pet Battles/Level", name="Overstuffed", description="Raise an Elekk Plushie to level 25.", points=5, parent="Pet Battles"}}

-- Pet Battles/Battle: Draenic Pet Battler
A{"unknown", 9463, criterion=25818, trivia={module="pet", category="Pet Battles/Battle", name="Draenic Pet Battler", description="Win 150 pet battles in Draenor.", points=5, parent="Pet Battles"}}

-- Pet Battles/Collect: So. Many. Pets.
A{"unknown", 9643, criterion=19598, trivia={module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", points=10, parent="Pet Battles", type=156}}
A{"unknown", 9643, criterion=19598, trivia={module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", points=10, parent="Pet Battles", type=156}}
A{"unknown", 9643, criterion=19598, trivia={module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", points=10, parent="Pet Battles", type=156}}
A{"unknown", 9643, criterion=19598, trivia={module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", points=10, parent="Pet Battles", type=156}}
A{"unknown", 9643, criterion=19598, trivia={module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", points=10, parent="Pet Battles", type=156}}
A{"unknown", 9643, criterion=19598, trivia={module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", points=10, parent="Pet Battles", type=156}}
A{"unknown", 9643, criterion=19598, trivia={module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", points=10, parent="Pet Battles", type=156}}
A{"unknown", 9643, criterion=19598, trivia={module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", points=10, parent="Pet Battles", type=156}}
A{"unknown", 9643, criterion=19598, trivia={module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", points=10, parent="Pet Battles", type=156}}
A{"unknown", 9643, criterion=19598, trivia={module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", points=10, parent="Pet Battles", type=156}}
A{"unknown", 9643, criterion=19598, trivia={module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", points=10, parent="Pet Battles", type=156}}
A{"unknown", 9643, criterion=19598, trivia={module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", points=10, parent="Pet Battles", type=156}}
A{"unknown", 9643, criterion=19598, trivia={module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", points=10, parent="Pet Battles", type=156}}

-- Pet Battles/Collect: Draenor Safari
A{"unknown", 9685, criterion=27247, trivia={criteria="Mud Jumper", module="pet", category="Pet Battles/Collect", name="Draenor Safari", description="Catch every battle pet in Draenor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 9685, criterion=27255, trivia={criteria="Twilight Wasp", module="pet", category="Pet Battles/Collect", name="Draenor Safari", description="Catch every battle pet in Draenor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 9685, criterion=27269, trivia={criteria="Royal Moth", module="pet", category="Pet Battles/Collect", name="Draenor Safari", description="Catch every battle pet in Draenor.", points=5, parent="Pet Battles", type="catch"}}
A{"unknown", 9685, criterion=27274, trivia={criteria="Waterfly", module="pet", category="Pet Battles/Collect", name="Draenor Safari", description="Catch every battle pet in Draenor.", points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Pet Charmer
A{"unknown", 9712, criterion=26682, trivia={module="pet", category="Pet Battles", name="Pet Charmer", description="Earn 500 Pet Charms.", points=5}}

-- Pet Battles/Battle: Local Pet Mauler
A{"ValeOfEternalBlossomsScenario", 6558, criterion=21593, trivia={criteria="Vale of Eternal Blossoms", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="ValeOfEternalBlossoms", uiMapID=390, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"ValeOfEternalBlossomsScenario", 6559, criterion=21593, trivia={criteria="Vale of Eternal Blossoms", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="ValeOfEternalBlossoms", uiMapID=390, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"ValeOfEternalBlossomsScenario", 6560, criterion=21593, trivia={criteria="Vale of Eternal Blossoms", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="ValeOfEternalBlossoms", uiMapID=390, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles: Taming Pandaria
A{"ValeOfEternalBlossomsScenario", 6606, 0.3100, 0.7400, criterion=21857, trivia={criteria="Aki the Chosen", module="pet", category="Pet Battles", name="Taming Pandaria", description="Defeat all of the Pet Tamers in Pandaria listed below.", mapID="ValeOfEternalBlossoms", uiMapID=390, points=5, type=158}}

-- Pet Battles/Collect: Pandaria Tamer
A{"ValeOfEternalBlossomsScenario", 6616, criterion=21495, trivia={criteria="Vale of Eternal Blossoms", module="pet", category="Pet Battles/Collect", name="Pandaria Tamer", description="Capture a battle pet in each of the Pandaria zones listed below.", mapID="ValeOfEternalBlossoms", uiMapID=390, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"ValeOfEternalBlossomsScenario", 8348, 0.3100, 0.7400, criterion=23493, trivia={criteria="Grand Master Aki", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="ValeOfEternalBlossoms", uiMapID=390, points=10, type="quest"}}
A{"ValeOfEternalBlossomsScenario", 8348, 0.1100, 0.7100, criterion=23500, note="[3 beasts]", trivia={criteria="No-No", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="ValeOfEternalBlossoms", uiMapID=390, points=10, type="quest"}}

-- Pet Battles/Battle: An Awfully Big Adventure
A{"ValeOfEternalBlossomsScenario", 9069, 0.3120, 0.7420, criterion=25118, trivia={criteria="Aki the Chosen", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="ValeOfEternalBlossoms", uiMapID=390, points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Battle: Local Pet Mauler
A{"ValleyoftheFourWinds", 6558, criterion=21588, trivia={criteria="Valley of the Four Winds", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="ValleyOfTheFourWinds", uiMapID=376, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"ValleyoftheFourWinds", 6559, criterion=21588, trivia={criteria="Valley of the Four Winds", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="ValleyOfTheFourWinds", uiMapID=376, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"ValleyoftheFourWinds", 6560, criterion=21588, trivia={criteria="Valley of the Four Winds", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="ValleyOfTheFourWinds", uiMapID=376, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Pandaria Safari
A{"ValleyoftheFourWinds", 6589, criterion=21798, note="zone exclusive", trivia={criteria="Bandicoon", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="ValleyOfTheFourWinds", uiMapID=376, points=5, parent="Pet Battles", type="catch"}}
A{"ValleyoftheFourWinds", 6589, criterion=21799, note="zone exclusive", trivia={criteria="Bandicoon Kit", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="ValleyOfTheFourWinds", uiMapID=376, points=5, parent="Pet Battles", type="catch"}}
A{"ValleyoftheFourWinds", 6589, criterion=21802, note="zone exclusive", trivia={criteria="Marsh Fiddler", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="ValleyOfTheFourWinds", uiMapID=376, points=5, parent="Pet Battles", type="catch"}}
A{"ValleyoftheFourWinds", 6589, criterion=21801, note="zone exclusive", trivia={criteria="Malayan Quillrat Pup", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="ValleyOfTheFourWinds", uiMapID=376, points=5, parent="Pet Battles", type="catch"}}
A{"ValleyoftheFourWinds", 6589, criterion=21797, note="zone exclusive", trivia={criteria="Sifang Otter", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="ValleyOfTheFourWinds", uiMapID=376, points=5, parent="Pet Battles", type="catch"}}
A{"ValleyoftheFourWinds", 6589, criterion=21803, note="zone exclusive", trivia={criteria="Shy Bandicoon", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="ValleyOfTheFourWinds", uiMapID=376, points=5, parent="Pet Battles", type="catch"}}
A{"ValleyoftheFourWinds", 6589, criterion=21806, note="zone exclusive", trivia={criteria="Softshell Snapling", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="ValleyOfTheFourWinds", uiMapID=376, points=5, parent="Pet Battles", type="catch"}}
A{"ValleyoftheFourWinds", 6589, criterion=21816, note="zone exclusive", trivia={criteria="Sifang Otter Pup", module="pet", category="Pet Battles/Collect", name="Pandaria Safari", description="Catch every battle pet in Pandaria.", mapID="ValleyOfTheFourWinds", uiMapID=376, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Pandaria
A{"ValleyoftheFourWinds", 6606, 0.4600, 0.4400, criterion=21854, trivia={criteria="Farmer Nishi", module="pet", category="Pet Battles", name="Taming Pandaria", description="Defeat all of the Pet Tamers in Pandaria listed below.", mapID="ValleyOfTheFourWinds", uiMapID=376, points=5, type=158}}

-- Pet Battles/Collect: Pandaria Tamer
A{"ValleyoftheFourWinds", 6616, criterion=21490, trivia={criteria="Valley of the Four Winds", module="pet", category="Pet Battles/Collect", name="Pandaria Tamer", description="Capture a battle pet in each of the Pandaria zones listed below.", mapID="ValleyOfTheFourWinds", uiMapID=376, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"ValleyoftheFourWinds", 8348, 0.4600, 0.4400, criterion=23490, trivia={criteria="Grand Master Nishi", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="ValleyOfTheFourWinds", uiMapID=376, points=10, type="quest"}}
A{"ValleyoftheFourWinds", 8348, 0.2500, 0.7900, criterion=23499, note="[3 beasts]", trivia={criteria="Greyhoof", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="ValleyOfTheFourWinds", uiMapID=376, points=10, type="quest"}}
A{"ValleyoftheFourWinds", 8348, 0.4100, 0.4400, criterion=23499, note="[3 beasts]", trivia={criteria="Lucky Yi", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="ValleyOfTheFourWinds", uiMapID=376, points=10, type="quest"}}

-- Pet Battles/Battle: An Awfully Big Adventure
A{"ValleyoftheFourWinds", 9069, 0.4600, 0.4360, criterion=26980, trivia={criteria="Farmer Nishi", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="ValleyOfTheFourWinds", uiMapID=376, points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Battle: Local Pet Mauler
A{"WesternPlaguelands", 6558, criterion=21568, trivia={criteria="Western Plaguelands", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="WesternPlaguelands", uiMapID=22, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"WesternPlaguelands", 6559, criterion=21568, trivia={criteria="Western Plaguelands", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="WesternPlaguelands", uiMapID=22, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"WesternPlaguelands", 6560, criterion=21568, trivia={criteria="Western Plaguelands", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="WesternPlaguelands", uiMapID=22, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Eastern Kingdoms Tamer
A{"WesternPlaguelands", 6613, criterion=21446, trivia={criteria="Western Plaguelands", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Tamer", description="Capture a battle pet in each of the Eastern Kingdoms zones listed below.", mapID="WesternPlaguelands", uiMapID=22, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: So. Many. Pets.
A{"WesternPlaguelands", 9643, 0.4400, 0.6800, criterion="Blighthawk", item="61826", note="zone exclusive", trivia={criteria="Blighthawk", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="WesternPlaguelands", uiMapID=22, points=10, parent="Pet Battles", type=156}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Westfall", 6558, criterion=21549, trivia={criteria="Westfall", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="Westfall", uiMapID=52, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Westfall", 6559, criterion=21549, trivia={criteria="Westfall", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="Westfall", uiMapID=52, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Westfall", 6560, criterion=21549, trivia={criteria="Westfall", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="Westfall", uiMapID=52, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Eastern Kingdoms Safari
A{"Westfall", 6586, 0.5800, 0.1700, criterion=21519, trivia={criteria="Snake", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="Westfall", uiMapID=52, points=5, parent="Pet Battles", type="catch"}}
A{"Westfall", 6586, 0.5400, 0.3100, criterion=21687, note="zone exclusive", trivia={criteria="Tiny Harvester", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="Westfall", uiMapID=52, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Eastern Kingdoms
A{"Westfall", 6603, 0.6100, 0.1900, criterion=21397, note="Main road Pet Level: 3", side="alliance", trivia={criteria="Old MacDonald", module="pet", category="Pet Battles", name="Taming Eastern Kingdoms", description="Defeat all of the Pet Tamers in Eastern Kingdoms listed below.", mapID="Westfall", uiMapID=52, points=5, type=158}}

-- Pet Battles/Collect: Eastern Kingdoms Tamer
A{"Westfall", 6613, criterion=21384, trivia={criteria="Westfall", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Tamer", description="Capture a battle pet in each of the Eastern Kingdoms zones listed below.", mapID="Westfall", uiMapID=52, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"Westfall", 8348, 0.6100, 0.1900, criterion=23419, trivia={criteria="Old MacDonald", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="Westfall", uiMapID=52, points=10, type="quest"}}

-- Pet Battles/Collect: So. Many. Pets.
A{"Westfall", 9643, criterion="Shore Crab", trivia={criteria="Shore Crab", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="Westfall", uiMapID=52, points=10, parent="Pet Battles", type=156}}
A{"Westfall", 9643, criterion="Snake", trivia={criteria="Snake", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="Westfall", uiMapID=52, points=10, parent="Pet Battles", type=156}}
A{"Westfall", 9643, criterion="Tiny Harvester", trivia={criteria="Tiny Harvester", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="Westfall", uiMapID=52, points=10, parent="Pet Battles", type=156}}
A{"Westfall", 9643, criterion="Chicken Egg", note="target chicken and /chicken repeatedly, then /cheer", trivia={criteria="Chicken Egg", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="Westfall", uiMapID=52, points=10, parent="Pet Battles", type=156}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Wetlands", 6558, criterion=21560, trivia={criteria="Wetlands", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="Wetlands", uiMapID=56, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Wetlands", 6559, criterion=21560, trivia={criteria="Wetlands", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="Wetlands", uiMapID=56, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Wetlands", 6560, criterion=21560, trivia={criteria="Wetlands", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="Wetlands", uiMapID=56, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Eastern Kingdoms Safari
A{"Wetlands", 6586, 0.6900, 0.2900, criterion=21625, note="inside the cave", trivia={criteria="Cockroach", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="Wetlands", uiMapID=56, points=5, parent="Pet Battles", type="catch"}}
A{"Wetlands", 6586, 0.6000, 0.5600, criterion=21646, trivia={criteria="Toad", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="Wetlands", uiMapID=56, points=5, parent="Pet Battles", type="catch"}}
A{"Wetlands", 6586, 0.6000, 0.5600, criterion=21661, trivia={criteria="Water Snake", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="Wetlands", uiMapID=56, points=5, parent="Pet Battles", type="catch"}}
A{"Wetlands", 6586, criterion=21688, note="scarce primary and common secondary", trivia={criteria="Mountain Skunk", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="Wetlands", uiMapID=56, points=5, parent="Pet Battles", type="catch"}}
A{"Wetlands", 6586, criterion=21689, note="zone exclusive\nscarce\nfound near Mirebeasts, north to northwest of Greenwarden's\nCan be made to spawn by repeatedly clearing the entire Green Belt of ALL critters", trivia={criteria="Tiny Bog Beast", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Safari", description="Catch every battle pet in Eastern Kingdoms.", mapID="Wetlands", uiMapID=56, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles/Collect: Eastern Kingdoms Tamer
A{"Wetlands", 6613, criterion=21447, trivia={criteria="Wetlands", module="pet", category="Pet Battles/Collect", name="Eastern Kingdoms Tamer", description="Capture a battle pet in each of the Eastern Kingdoms zones listed below.", mapID="Wetlands", uiMapID=56, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: So. Many. Pets.
A{"Wetlands", 9643, criterion="Tiny Crimson Whelpling", item="7544", trivia={criteria="Tiny Crimson Whelpling", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="Wetlands", uiMapID=56, points=10, parent="Pet Battles", type=156}}
A{"Wetlands", 9643, 0.6900, 0.2900, criterion="Razormaw Hatchling", item="35398", trivia={criteria="Razormaw Hatchling", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="Wetlands", uiMapID=56, points=10, parent="Pet Battles", type=156}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Winterspring", 6558, criterion=21540, trivia={criteria="Winterspring", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="Winterspring", uiMapID=83, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Winterspring", 6559, criterion=21540, trivia={criteria="Winterspring", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="Winterspring", uiMapID=83, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Winterspring", 6560, criterion=21540, trivia={criteria="Winterspring", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="Winterspring", uiMapID=83, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Kalimdor Safari
A{"Winterspring", 6585, 0.5100, 0.5600, criterion=21512, note="zone exclusive", trivia={criteria="Crystal Spider", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="Winterspring", uiMapID=83, points=5, parent="Pet Battles", type="catch"}}
A{"Winterspring", 6585, criterion=21757, note="zone exclusive", trivia={criteria="Snowy Owl", module="pet", category="Pet Battles/Collect", name="Kalimdor Safari", description="Catch every battle pet in Kalimdor.", mapID="Winterspring", uiMapID=83, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Kalimdor
A{"Winterspring", 6602, 0.6600, 0.6400, criterion=21415, side="horde", trivia={criteria="Stone Cold Trixxy", module="pet", category="Pet Battles", name="Taming Kalimdor", description="Defeat all of the Pet Tamers in Kalimdor listed below.", mapID="Winterspring", uiMapID=83, points=5, type=158}}

-- Pet Battles/Collect: Kalimdor Tamer
A{"Winterspring", 6612, criterion=21467, trivia={criteria="Winterspring", module="pet", category="Pet Battles/Collect", name="Kalimdor Tamer", description="Capture a battle pet in each of the Kalimdor zones listed below.", mapID="Winterspring", uiMapID=83, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"Winterspring", 8348, 0.6600, 0.6400, criterion=23453, trivia={criteria="Grand Master Trixxy", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="Winterspring", uiMapID=83, points=10, type="quest"}}

-- Pet Battles/Collect: Crazy for Cats
A{"Winterspring", 8397, 0.6000, 0.5200, criterion=23595, note="from Michelle De Rum", trivia={criteria="Winterspring Cub", module="pet", category="Pet Battles/Collect", name="Crazy for Cats", description="Obtain 20 of the cats listed below.", mapID="Winterspring", uiMapID=83, points=10, parent="Pet Battles", type=96}}

-- Pet Battles/Battle: Local Pet Mauler
A{"Zangarmarsh", 6558, criterion=21572, trivia={criteria="Zangarmarsh", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="Zangarmarsh", uiMapID=102, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"Zangarmarsh", 6559, criterion=21572, trivia={criteria="Zangarmarsh", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="Zangarmarsh", uiMapID=102, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"Zangarmarsh", 6560, criterion=21572, trivia={criteria="Zangarmarsh", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="Zangarmarsh", uiMapID=102, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Outland Safari
A{"Zangarmarsh", 6587, criterion=21766, note="zone exclusive", trivia={criteria="Sporeling Sprout", module="pet", category="Pet Battles/Collect", name="Outland Safari", description="Catch every battle pet in Outland.", mapID="Zangarmarsh", uiMapID=102, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Outland
A{"Zangarmarsh", 6604, 0.1700, 0.5000, criterion=21605, trivia={criteria="Ras'an", module="pet", category="Pet Battles", name="Taming Outland", description="Defeat all of the Pet Tamers in Outland listed below.", mapID="Zangarmarsh", uiMapID=102, points=5, type=158}}

-- Pet Battles/Collect: Outland Tamer
A{"Zangarmarsh", 6614, criterion=21476, trivia={criteria="Zangarmarsh", module="pet", category="Pet Battles/Collect", name="Outland Tamer", description="Capture a battle pet in each of the Outland zones listed below.", mapID="Zangarmarsh", uiMapID=102, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"Zangarmarsh", 8348, 0.1700, 0.5000, criterion=23469, trivia={criteria="Ras'an", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="Zangarmarsh", uiMapID=102, points=10, type="quest"}}

-- Pet Battles/Battle: An Awfully Big Adventure
A{"Zangarmarsh", 9069, 0.1720, 0.5040, criterion=26997, trivia={criteria="Ras'an", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="Zangarmarsh", uiMapID=102, points=10, parent="Pet Battles", type=158}}

-- Pet Battles/Collect: So. Many. Pets.
A{"ZulAman", 9643, criterion="Mojo", item="24480", note="use Amani Hex Stick for chance of Mojo", trivia={criteria="Mojo", module="pet", category="Pet Battles/Collect", name="So. Many. Pets.", description="Collect 600 unique pets.", mapID="ZulAman", uiMapID=333, points=10, parent="Pet Battles", type=156}}

-- Pet Battles/Battle: Local Pet Mauler
A{"ZulDrak", 6558, criterion=21583, trivia={criteria="Zul'Drak", module="pet", category="Pet Battles/Battle", name="Local Pet Mauler", description="Win a pet battle in 10 different zones.", mapID="ZulDrak", uiMapID=121, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: Traveling Pet Mauler
A{"ZulDrak", 6559, criterion=21583, trivia={criteria="Zul'Drak", module="pet", category="Pet Battles/Battle", name="Traveling Pet Mauler", description="Win a pet battle in 30 different zones.", mapID="ZulDrak", uiMapID=121, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles/Battle: World Pet Mauler
A{"ZulDrak", 6560, criterion=21583, trivia={criteria="Zul'Drak", module="pet", category="Pet Battles/Battle", name="World Pet Mauler", description="Win a pet battle in 60 different zones.", mapID="ZulDrak", uiMapID=121, points=10, parent="Pet Battles", type="battle"}}

-- Pet Battles/Collect: Northrend Safari
A{"ZulDrak", 6588, criterion=21780, note="zone exclusive", trivia={criteria="Water Waveling", module="pet", category="Pet Battles/Collect", name="Northrend Safari", description="Catch every battle pet in Northrend.", mapID="ZulDrak", uiMapID=121, points=5, parent="Pet Battles", type="catch"}}

-- Pet Battles: Taming Northrend
A{"ZulDrak", 6605, 0.1300, 0.6700, criterion=21851, trivia={criteria="Gutretch", module="pet", category="Pet Battles", name="Taming Northrend", description="Defeat all of the Pet Tamers in Northrend listed below.", mapID="ZulDrak", uiMapID=121, points=5, type=158}}

-- Pet Battles/Collect: Northrend Tamer
A{"ZulDrak", 6615, criterion=21485, trivia={criteria="Zul'Drak", module="pet", category="Pet Battles/Collect", name="Northrend Tamer", description="Capture a battle pet in each of the Northrend zones listed below.", mapID="ZulDrak", uiMapID=121, points=5, parent="Pet Battles", type="battle"}}

-- Pet Battles: The Longest Day
A{"ZulDrak", 8348, 0.1300, 0.6700, criterion=23478, trivia={criteria="Gutretch", module="pet", category="Pet Battles", name="The Longest Day", description="Complete all of the pet battle daily quests listed below.", mapID="ZulDrak", uiMapID=121, points=10, type="quest"}}

-- Pet Battles/Battle: An Awfully Big Adventure
A{"ZulDrak", 9069, 0.1320, 0.6680, criterion=26984, trivia={criteria="Gutretch", module="pet", category="Pet Battles/Battle", name="An Awfully Big Adventure", description="Defeat the following trainers with an Elekk Plushie on your team.", mapID="ZulDrak", uiMapID=121, points=10, parent="Pet Battles", type=158}}
