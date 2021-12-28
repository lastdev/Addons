local AL = LibStub:GetLibrary("AchievementLocations-1.0")
local function A(row) AL:AddLocation(row) end

-- World Events/Darkmoon Faire: Taking the Show on the Road
A{"Dalaran", 6030, criterion=27718, note="buy from Boomie Sparks (48.4,71.9)", side="alliance", season="Darkmoon Faire", trivia={criteria="Dalaran", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Taking the Show on the Road", description="Launch off Darkmoon Fireworks in every friendly capital city.", mapID="Dalaran_DalaranCity", uiMapID=125, points=10, parent="World Events", type=29}}

-- World Events/Darkmoon Faire: Taking the Show on the Road
A{"Dalaran", 6031, criterion=27718, note="buy from Boomie Sparks (48.4,71.9)", side="horde", season="Darkmoon Faire", trivia={criteria="Dalaran", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Taking the Show on the Road", description="Launch off Darkmoon Fireworks in every friendly capital city.", mapID="Dalaran_DalaranCity", uiMapID=125, points=10, parent="World Events", type=29}}

-- World Events/Darkmoon Faire: Come One, Come All!
A{"DarkmoonFaireIsland", 6019, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Come One, Come All!", description="Attend the Darkmoon Faire.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Step Right Up
A{"DarkmoonFaireIsland", 6020, 0.5250, 0.5610, criterion=18234, season="Darkmoon Faire", trivia={criteria="Cannon Blast", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Step Right Up", description="Play five different Darkmoon games.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events", type="quest"}}
A{"DarkmoonFaireIsland", 6020, 0.5150, 0.7780, criterion=18235, season="Darkmoon Faire", trivia={criteria="Ring Toss", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Step Right Up", description="Play five different Darkmoon games.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events", type="quest"}}
A{"DarkmoonFaireIsland", 6020, 0.5060, 0.6500, criterion=18237, season="Darkmoon Faire", trivia={criteria="Tonk Battle", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Step Right Up", description="Play five different Darkmoon games.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events", type="quest"}}
A{"DarkmoonFaireIsland", 6020, 0.5340, 0.5450, criterion=18238, season="Darkmoon Faire", trivia={criteria="Whack-A-Gnoll", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Step Right Up", description="Play five different Darkmoon games.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events", type="quest"}}
A{"DarkmoonFaireIsland", 6020, 0.4940, 0.6070, criterion=18236, season="Darkmoon Faire", trivia={criteria="Shooting Gallery", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Step Right Up", description="Play five different Darkmoon games.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events", type="quest"}}

-- World Events/Darkmoon Faire: Blastenheimer Bullseye
A{"DarkmoonFaireIsland", 6021, 0.5250, 0.5610, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Blastenheimer Bullseye", description="Score a bullseye when launched from the Darkmoon Cannon.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events"}}

-- World Events/Darkmoon Faire: Quick Shot
A{"DarkmoonFaireIsland", 6022, 0.4940, 0.6070, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Quick Shot", description="Score a Quick Shot at the Shooting Gallery.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events"}}

-- World Events/Darkmoon Faire: Darkmoon Duelist
A{"DarkmoonFaireIsland", 6023, 0.4740, 0.7890, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Darkmoon Duelist", description="Win the Darkmoon Deathmatch and receive a Pit Fighter trinket.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events"}}

-- World Events/Darkmoon Faire: Darkmoon Dominator
A{"DarkmoonFaireIsland", 6024, 0.4740, 0.7890, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Darkmoon Dominator", description="Win the Darkmoon Deathmatch twelve times and receive a Master Pit Fighter trinket.", mapID="DarkmoonIsland", uiMapID=408, points=20, parent="World Events"}}

-- World Events/Darkmoon Faire: I Was Promised a Pony
A{"DarkmoonFaireIsland", 6025, 0.5700, 0.8200, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="I Was Promised a Pony", description="Ride a Darkmoon Pony.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Fairegoer's Feast
A{"DarkmoonFaireIsland", 6026, 0.5280, 0.6800, criterion=7313, season="Darkmoon Faire", trivia={criteria="Darkmoon Dog", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Fairegoer's Feast", description="Consume one of every Darkmoon food and drink.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events", type=41}}
A{"DarkmoonFaireIsland", 6026, 0.5280, 0.6800, criterion=6903, season="Darkmoon Faire", trivia={criteria="Pickled Kodo Foot", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Fairegoer's Feast", description="Consume one of every Darkmoon food and drink.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events", type=41}}
A{"DarkmoonFaireIsland", 6026, 0.5040, 0.6960, criterion=4665, season="Darkmoon Faire", trivia={criteria="Cheap Beer", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Fairegoer's Feast", description="Consume one of every Darkmoon food and drink.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events", type=41}}
A{"DarkmoonFaireIsland", 6026, 0.5040, 0.6960, criterion=4661, season="Darkmoon Faire", trivia={criteria="Bottled Winterspring Water", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Fairegoer's Feast", description="Consume one of every Darkmoon food and drink.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events", type=41}}
A{"DarkmoonFaireIsland", 6026, 0.5280, 0.6800, criterion=6567, season="Darkmoon Faire", trivia={criteria="Deep Fried Candybar", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Fairegoer's Feast", description="Consume one of every Darkmoon food and drink.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events", type=41}}
A{"DarkmoonFaireIsland", 6026, 0.5040, 0.6960, criterion=4687, season="Darkmoon Faire", trivia={criteria="Fizzy Faire Drink", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Fairegoer's Feast", description="Consume one of every Darkmoon food and drink.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events", type=41}}
A{"DarkmoonFaireIsland", 6026, 0.5040, 0.6960, criterion=9015, season="Darkmoon Faire", trivia={criteria="Iced Berry Slush", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Fairegoer's Feast", description="Consume one of every Darkmoon food and drink.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events", type=41}}
A{"DarkmoonFaireIsland", 6026, 0.5280, 0.6800, criterion=6915, season="Darkmoon Faire", trivia={criteria="Red Hot Wings", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Fairegoer's Feast", description="Consume one of every Darkmoon food and drink.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events", type=41}}
A{"DarkmoonFaireIsland", 6026, 0.5280, 0.6800, criterion=7017, season="Darkmoon Faire", trivia={criteria="Spiced Beef Jerky", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Fairegoer's Feast", description="Consume one of every Darkmoon food and drink.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events", type=41}}
A{"DarkmoonFaireIsland", 6026, 0.5280, 0.6800, criterion=8030, season="Darkmoon Faire", trivia={criteria="Forest Strider Drumstick", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Fairegoer's Feast", description="Consume one of every Darkmoon food and drink.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events", type=41}}
A{"DarkmoonFaireIsland", 6026, 0.5280, 0.6800, criterion=6552, season="Darkmoon Faire", trivia={criteria="Crunchy Frog", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Fairegoer's Feast", description="Consume one of every Darkmoon food and drink.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events", type=41}}
A{"DarkmoonFaireIsland", 6026, 0.5040, 0.6960, criterion=18610, season="Darkmoon Faire", trivia={criteria="Sasparilla Sinker", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Fairegoer's Feast", description="Consume one of every Darkmoon food and drink.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events", type=41}}
A{"DarkmoonFaireIsland", 6026, 0.5280, 0.6800, criterion=18596, season="Darkmoon Faire", trivia={criteria="Salty Sea Dog", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Fairegoer's Feast", description="Consume one of every Darkmoon food and drink.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events", type=41}}
A{"DarkmoonFaireIsland", 6026, 0.5040, 0.6960, criterion=9016, season="Darkmoon Faire", trivia={criteria="Fizzy Faire Drink \"Classic\"", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Fairegoer's Feast", description="Consume one of every Darkmoon food and drink.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events", type=41}}
A{"DarkmoonFaireIsland", 6026, 0.5040, 0.6960, criterion=4678, season="Darkmoon Faire", trivia={criteria="Darkmoon Special Reserve", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Fairegoer's Feast", description="Consume one of every Darkmoon food and drink.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events", type=41}}
A{"DarkmoonFaireIsland", 6026, 0.5280, 0.6800, criterion=7957, season="Darkmoon Faire", trivia={criteria="Funnel Cake", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Fairegoer's Feast", description="Consume one of every Darkmoon food and drink.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events", type=41}}
A{"DarkmoonFaireIsland", 6026, 0.5280, 0.6800, criterion=18252, season="Darkmoon Faire", trivia={criteria="Corn-Breaded Sausage", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Fairegoer's Feast", description="Consume one of every Darkmoon food and drink.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events", type=41}}
A{"DarkmoonFaireIsland", 6026, 0.5040, 0.6960, criterion=18609, season="Darkmoon Faire", trivia={criteria="Fresh-Squeezed Limeade", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Fairegoer's Feast", description="Consume one of every Darkmoon food and drink.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events", type=41}}

-- World Events/Darkmoon Faire: Faire Favors
A{"DarkmoonFaireIsland", 6032, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Faire Favors", description="Complete at least six profession-based quests at the Darkmoon Faire.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events"}}

-- World Events/Darkmoon Faire: That Rabbit's Dynamite!
A{"DarkmoonFaireIsland", 6332, 0.7760, 0.8080, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="That Rabbit's Dynamite!", description="Slay the ferocious Darkmoon Rabbit.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events"}}

-- World Events/Darkmoon Faire: Flying High
A{"DarkmoonFaireIsland", 9250, 0.4840, 0.7140, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Flying High", description="Collect 10 Blazing Rings in one flight session of Firebird's Challenge.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events"}}

-- World Events/Darkmoon Faire: Ringmaster
A{"DarkmoonFaireIsland", 9251, 0.4840, 0.7140, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Ringmaster", description="Collect 25 Blazing Rings in one flight session of Firebird's Challenge.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events"}}

-- World Events/Darkmoon Faire: Brood of Alysrazor
A{"DarkmoonFaireIsland", 9252, 0.4840, 0.7140, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Brood of Alysrazor", description="Collect 50 Blazing Rings in one flight session of Firebird's Challenge.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events"}}

-- World Events/Darkmoon Faire: Darkmoon Race Enthusiast
A{"DarkmoonFaireIsland", 9755, 0.4900, 0.8810, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Darkmoon Race Enthusiast", description="Successfully complete Welcome to the Darkmoon Races or The Real Race with the Racing Strider.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Darkmoon Racer Novice
A{"DarkmoonFaireIsland", 9756, 0.4900, 0.8810, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Darkmoon Racer Novice", description="Complete The Real Race with the Racing Strider within 25 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Darkmoon Racer Jockey
A{"DarkmoonFaireIsland", 9759, 0.4900, 0.8810, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Darkmoon Racer Jockey", description="Complete The Real Race with the Racing Strider within 20 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Darkmoon Racer Leadfoot
A{"DarkmoonFaireIsland", 9760, 0.4900, 0.8810, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Darkmoon Racer Leadfoot", description="Complete The Real Race with the Racing Strider within 15 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Darkmoon Racer Roadhog
A{"DarkmoonFaireIsland", 9761, 0.4900, 0.8810, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Darkmoon Racer Roadhog", description="Complete The Real Race with the Racing Strider within 11 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Rocketeer: Gold
A{"DarkmoonFaireIsland", 9764, 0.4900, 0.8810, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Rocketeer: Gold", description="Complete The Real Race with the Rocketeer within 11 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Rocketeer: Silver
A{"DarkmoonFaireIsland", 9766, 0.4900, 0.8810, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Rocketeer: Silver", description="Complete The Real Race with the Rocketeer within 15 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Rocketeer: Bronze
A{"DarkmoonFaireIsland", 9769, 0.4900, 0.8810, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Rocketeer: Bronze", description="Complete The Real Race with the Rocketeer within 20 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Blast Off!
A{"DarkmoonFaireIsland", 9770, 0.4900, 0.8810, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Blast Off!", description="Complete The Real Race with the Rocketeer within 25 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Go-Getter
A{"DarkmoonFaireIsland", 9780, 0.4900, 0.8810, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Go-Getter", description="Complete The Real Race with the Powermonger within 25 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Powermonger: Bronze
A{"DarkmoonFaireIsland", 9781, 0.4900, 0.8810, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Powermonger: Bronze", description="Complete The Real Race with the Powermonger within 20 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Powermonger: Silver
A{"DarkmoonFaireIsland", 9783, 0.4900, 0.8810, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Powermonger: Silver", description="Complete The Real Race with the Powermonger within 15 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Powermonger: Gold
A{"DarkmoonFaireIsland", 9785, 0.4900, 0.8810, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Powermonger: Gold", description="Complete The Real Race with the Powermonger within 11 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Wayfarer
A{"DarkmoonFaireIsland", 9786, 0.4900, 0.8810, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Wayfarer", description="Complete The Real Race with the Wanderluster within 25 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Wanderluster: Bronze
A{"DarkmoonFaireIsland", 9787, 0.4900, 0.8810, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Wanderluster: Bronze", description="Complete The Real Race with the Wanderluster within 20 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Wanderluster: Silver
A{"DarkmoonFaireIsland", 9790, 0.4900, 0.8810, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Wanderluster: Silver", description="Complete The Real Race with the Wanderluster within 15 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Wanderluster: Gold
A{"DarkmoonFaireIsland", 9792, 0.4900, 0.8810, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Wanderluster: Gold", description="Complete The Real Race with the Wanderluster within 11 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Big Race Enthusiast
A{"DarkmoonFaireIsland", 9793, 0.5330, 0.8780, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Big Race Enthusiast", description="Complete The Real Big Race with the Racing Strider within 40 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Big Race Novice
A{"DarkmoonFaireIsland", 9794, 0.5330, 0.8780, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Big Race Novice", description="Complete The Real Big Race with the Racing Strider within 35 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Big Race Jockey
A{"DarkmoonFaireIsland", 9795, 0.5330, 0.8780, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Big Race Jockey", description="Complete The Real Big Race with the Racing Strider within 30 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Big Race Leadfoot
A{"DarkmoonFaireIsland", 9797, 0.5330, 0.8780, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Big Race Leadfoot", description="Complete The Real Big Race with the Racing Strider within 25 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Big Race Roadhog
A{"DarkmoonFaireIsland", 9799, 0.5330, 0.8780, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Big Race Roadhog", description="Complete The Real Big Race with the Racing Strider within 20 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Rocket Man
A{"DarkmoonFaireIsland", 9800, 0.5330, 0.8780, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Rocket Man", description="Complete The Real Big Race with the Rocketeer within 40 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Big Rocketeer: Bronze
A{"DarkmoonFaireIsland", 9801, 0.5330, 0.8780, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Big Rocketeer: Bronze", description="Complete The Real Big Race with the Rocketeer within 30 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Big Rocketeer: Silver
A{"DarkmoonFaireIsland", 9803, 0.5330, 0.8780, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Big Rocketeer: Silver", description="Complete The Real Big Race with the Rocketeer within 25 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Big Rocketeer: Gold
A{"DarkmoonFaireIsland", 9805, 0.5330, 0.8780, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Big Rocketeer: Gold", description="Complete The Real Big Race with the Rocketeer within 20 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Vagabond
A{"DarkmoonFaireIsland", 9806, 0.5330, 0.8780, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Vagabond", description="Complete The Real Big Race with the Wanderluster within 40 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Big Wanderluster: Bronze
A{"DarkmoonFaireIsland", 9807, 0.5330, 0.8780, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Big Wanderluster: Bronze", description="Complete The Real Big Race with the Wanderluster within 30 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Big Wanderluster: Silver
A{"DarkmoonFaireIsland", 9809, 0.5330, 0.8780, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Big Wanderluster: Silver", description="Complete The Real Big Race with the Wanderluster within 25 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Big Wanderluster: Gold
A{"DarkmoonFaireIsland", 9811, 0.5330, 0.8780, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Big Wanderluster: Gold", description="Complete The Real Big Race with the Wanderluster within 20 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Goal-Oriented
A{"DarkmoonFaireIsland", 9812, 0.5330, 0.8780, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Goal-Oriented", description="Complete The Real Big Race with the Powermonger within 40 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Big Powermonger: Bronze
A{"DarkmoonFaireIsland", 9813, 0.5330, 0.8780, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Big Powermonger: Bronze", description="Complete The Real Big Race with the Powermonger within 30 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Big Powermonger: Silver
A{"DarkmoonFaireIsland", 9815, 0.5330, 0.8780, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Big Powermonger: Silver", description="Complete The Real Big Race with the Powermonger within 25 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Big Powermonger: Gold
A{"DarkmoonFaireIsland", 9817, 0.5330, 0.8780, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Big Powermonger: Gold", description="Complete The Real Big Race with the Powermonger within 20 tolls.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Darkmoon Like the Wind
A{"DarkmoonFaireIsland", 9819, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Darkmoon Like the Wind", description="Stay aloft with the Wanderluster's Glider for more than 10 seconds.", mapID="DarkmoonIsland", uiMapID=408, points=5, parent="World Events"}}

-- World Events/Darkmoon Faire: Ace Tonk Commander
A{"DarkmoonFaireIsland", 9885, 0.5060, 0.6500, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Ace Tonk Commander", description="Score 45 hits in one session of the Tonk Challenge.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events"}}

-- World Events/Darkmoon Faire: Triumphant Turtle Tossing
A{"DarkmoonFaireIsland", 9894, 0.6150, 0.7780, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Triumphant Turtle Tossing", description="Successfully toss 10 rings onto Dubenko the Darkmoon Turtle in one session of the Ring Toss.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events"}}

-- World Events/Darkmoon Faire: That's Whack!
A{"DarkmoonFaireIsland", 9983, 0.5340, 0.5450, season="Darkmoon Faire", trivia={module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="That's Whack!", description="Score 45 points in one session of Whack-a-Gnoll.", mapID="DarkmoonIsland", uiMapID=408, points=10, parent="World Events"}}

-- World Events/Darkmoon Faire: Taking the Show on the Road
A{"Darnassus", 6030, criterion=27724, note="buy from Boomie Sparks (48.4,71.9)", side="alliance", season="Darkmoon Faire", trivia={criteria="Darnassus", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Taking the Show on the Road", description="Launch off Darkmoon Fireworks in every friendly capital city.", mapID="Darnassus", uiMapID=89, points=10, parent="World Events", type=29}}
A{"Ironforge", 6030, criterion=27726, note="buy from Boomie Sparks (48.4,71.9)", side="alliance", season="Darkmoon Faire", trivia={criteria="Ironforge", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Taking the Show on the Road", description="Launch off Darkmoon Fireworks in every friendly capital city.", mapID="Ironforge", uiMapID=87, points=10, parent="World Events", type=29}}

-- World Events/Darkmoon Faire: Taking the Show on the Road
A{"Orgrimmar", 6031, criterion=27719, note="buy from Boomie Sparks (48.4,71.9)", side="horde", season="Darkmoon Faire", trivia={criteria="Orgrimmar", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Taking the Show on the Road", description="Launch off Darkmoon Fireworks in every friendly capital city.", mapID="Orgrimmar", uiMapID=85, points=10, parent="World Events", type=29}}

-- World Events/Darkmoon Faire: Taking the Show on the Road
A{"ShattrathCity", 6030, criterion=27720, note="buy from Boomie Sparks (48.4,71.9)", side="alliance", season="Darkmoon Faire", trivia={criteria="Shattrath City", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Taking the Show on the Road", description="Launch off Darkmoon Fireworks in every friendly capital city.", mapID="ShattrathCity", uiMapID=111, points=10, parent="World Events", type=29}}

-- World Events/Darkmoon Faire: Taking the Show on the Road
A{"ShattrathCity", 6031, criterion=27720, note="buy from Boomie Sparks (48.4,71.9)", side="horde", season="Darkmoon Faire", trivia={criteria="Shattrath City", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Taking the Show on the Road", description="Launch off Darkmoon Fireworks in every friendly capital city.", mapID="ShattrathCity", uiMapID=111, points=10, parent="World Events", type=29}}
A{"SilvermoonCity", 6031, criterion=27721, note="buy from Boomie Sparks (48.4,71.9)", side="horde", season="Darkmoon Faire", trivia={criteria="Silvermoon City", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Taking the Show on the Road", description="Launch off Darkmoon Fireworks in every friendly capital city.", mapID="SilvermoonCity", uiMapID=110, points=10, parent="World Events", type=29}}

-- World Events/Darkmoon Faire: Taking the Show on the Road
A{"StormwindCity", 6030, criterion=27727, note="buy from Boomie Sparks (48.4,71.9)", side="alliance", season="Darkmoon Faire", trivia={criteria="Stormwind City", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Taking the Show on the Road", description="Launch off Darkmoon Fireworks in every friendly capital city.", mapID="StormwindCity", uiMapID=84, points=10, parent="World Events", type=29}}
A{"TheExodar", 6030, criterion=27725, note="buy from Boomie Sparks (48.4,71.9)", side="alliance", season="Darkmoon Faire", trivia={criteria="The Exodar", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Taking the Show on the Road", description="Launch off Darkmoon Fireworks in every friendly capital city.", mapID="TheExodar", uiMapID=103, points=10, parent="World Events", type=29}}

-- World Events/Darkmoon Faire: Taking the Show on the Road
A{"ThunderBluff", 6031, criterion=27722, note="buy from Boomie Sparks (48.4,71.9)", side="horde", season="Darkmoon Faire", trivia={criteria="Thunder Bluff", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Taking the Show on the Road", description="Launch off Darkmoon Fireworks in every friendly capital city.", mapID="ThunderBluff", uiMapID=88, points=10, parent="World Events", type=29}}
A{"Undercity", 6031, criterion=27723, note="buy from Boomie Sparks (48.4,71.9)", side="horde", season="Darkmoon Faire", trivia={criteria="Undercity", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Taking the Show on the Road", description="Launch off Darkmoon Fireworks in every friendly capital city.", mapID="Undercity", uiMapID=90, points=10, parent="World Events", type=29}}

-- World Events/Darkmoon Faire: Darkmoon Dungeoneer
A{"unknown", 6027, criterion=18648, season="Darkmoon Faire", trivia={criteria="Ornate Weapon", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Darkmoon Dungeoneer", description="Turn in all five dungeon Darkmoon Artifacts.", points=10, parent="World Events", type="quest"}}
A{"unknown", 6027, criterion=18644, season="Darkmoon Faire", trivia={criteria="A Treatise on Strategy", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Darkmoon Dungeoneer", description="Turn in all five dungeon Darkmoon Artifacts.", points=10, parent="World Events", type="quest"}}
A{"unknown", 6027, criterion=18646, season="Darkmoon Faire", trivia={criteria="Monstrous Egg", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Darkmoon Dungeoneer", description="Turn in all five dungeon Darkmoon Artifacts.", points=10, parent="World Events", type="quest"}}
A{"unknown", 6027, criterion=18645, season="Darkmoon Faire", trivia={criteria="Imbued Crystal", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Darkmoon Dungeoneer", description="Turn in all five dungeon Darkmoon Artifacts.", points=10, parent="World Events", type="quest"}}
A{"unknown", 6027, criterion=18647, season="Darkmoon Faire", trivia={criteria="Mysterious Grimoire", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Darkmoon Dungeoneer", description="Turn in all five dungeon Darkmoon Artifacts.", points=10, parent="World Events", type="quest"}}

-- World Events/Darkmoon Faire: Darkmoon Defender
A{"unknown", 6028, criterion=18649, season="Darkmoon Faire", trivia={criteria="Adventurer's Journal", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Darkmoon Defender", description="Turn in all three battleground Darkmoon Artifacts.", points=10, parent="World Events", type="quest"}}
A{"unknown", 6028, criterion=18650, season="Darkmoon Faire", trivia={criteria="Banner of the Fallen", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Darkmoon Defender", description="Turn in all three battleground Darkmoon Artifacts.", points=10, parent="World Events", type="quest"}}
A{"unknown", 6028, criterion=18651, season="Darkmoon Faire", trivia={criteria="Captured Insignia", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Darkmoon Defender", description="Turn in all three battleground Darkmoon Artifacts.", points=10, parent="World Events", type="quest"}}

-- World Events/Darkmoon Faire: Darkmoon Despoiler
A{"unknown", 6029, criterion=18644, season="Darkmoon Faire", trivia={criteria="A Treatise on Strategy", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Darkmoon Despoiler", description="Turn in all nine Darkmoon Artifacts.", points=10, parent="World Events", type="quest"}}
A{"unknown", 6029, criterion=18645, season="Darkmoon Faire", trivia={criteria="Imbued Crystal", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Darkmoon Despoiler", description="Turn in all nine Darkmoon Artifacts.", points=10, parent="World Events", type="quest"}}
A{"unknown", 6029, criterion=18646, season="Darkmoon Faire", trivia={criteria="Monstrous Egg", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Darkmoon Despoiler", description="Turn in all nine Darkmoon Artifacts.", points=10, parent="World Events", type="quest"}}
A{"unknown", 6029, criterion=18647, season="Darkmoon Faire", trivia={criteria="Mysterious Grimoire", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Darkmoon Despoiler", description="Turn in all nine Darkmoon Artifacts.", points=10, parent="World Events", type="quest"}}
A{"unknown", 6029, criterion=18648, season="Darkmoon Faire", trivia={criteria="Ornate Weapon", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Darkmoon Despoiler", description="Turn in all nine Darkmoon Artifacts.", points=10, parent="World Events", type="quest"}}
A{"unknown", 6029, criterion=18649, season="Darkmoon Faire", trivia={criteria="Adventurer's Journal", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Darkmoon Despoiler", description="Turn in all nine Darkmoon Artifacts.", points=10, parent="World Events", type="quest"}}
A{"unknown", 6029, criterion=18650, season="Darkmoon Faire", trivia={criteria="Banner of the Fallen", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Darkmoon Despoiler", description="Turn in all nine Darkmoon Artifacts.", points=10, parent="World Events", type="quest"}}
A{"unknown", 6029, criterion=18651, season="Darkmoon Faire", trivia={criteria="Captured Insignia", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Darkmoon Despoiler", description="Turn in all nine Darkmoon Artifacts.", points=10, parent="World Events", type="quest"}}
A{"unknown", 6029, criterion=18287, season="Darkmoon Faire", trivia={criteria="Soothsayer's Runes", module="seasonal_darkmoon", category="World Events/Darkmoon Faire", name="Darkmoon Despoiler", description="Turn in all nine Darkmoon Artifacts.", points=10, parent="World Events", type="quest"}}
