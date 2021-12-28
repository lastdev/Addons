local AL = LibStub:GetLibrary("AchievementLocations-1.0")
local function A(row) AL:AddLocation(row) end

-- World Events/Winter Veil: Fa-la-la-la-Ogri'la
A{"BladesEdgeMountains", 1282, 0.2780, 0.5270, season="Feast of Winter Veil", trivia={module="seasonal_winter", category="World Events/Winter Veil", name="Fa-la-la-la-Ogri'la", description="Complete the Bomb Them Again! quest while mounted on a flying reindeer during the Feast of Winter Veil.", mapID="BladesEdgeMountains", uiMapID=105, points=10, parent="World Events"}}

-- World Events: Merrymaker
A{"BladesEdgeMountains", 1691, 0.2780, 0.5270, criterion=6265, season="Feast of Winter Veil", trivia={criteria="Fa-la-la-la-Ogri'la", module="seasonal_winter", category="World Events", name="Merrymaker", description="Complete the Winter Veil achievements listed below.", mapID="BladesEdgeMountains", uiMapID=105, points=10, type="achievement"}}

-- World Events/Winter Veil: Bros. Before Ho Ho Ho's
A{"BoreanTundra", 1685, 0.4000, 0.5400, criterion=6226, side="horde", season="Feast of Winter Veil", trivia={criteria="Durkot Wolfbrother in Warsong Hold", module="seasonal_winter", category="World Events/Winter Veil", name="Bros. Before Ho Ho Ho's", description="Use Mistletoe on the Horde \"Brothers\" during the Feast of Winter Veil.", mapID="BoreanTundra", uiMapID=114, points=10, parent="World Events", type=110}}

-- World Events/Winter Veil: BB King
A{"Darnassus", 4437, 0.4300, 0.7880, criterion=12666, side="horde", season="Feast of Winter Veil", trivia={criteria="Tyrande Whisperwind", module="seasonal_winter", category="World Events/Winter Veil", name="BB King", description="Pelt the enemy leaders listed below.", mapID="Darnassus", uiMapID=89, points=10, parent="World Events", type=110}}

-- World Events/Winter Veil: A-Caroling We Will Go
A{"Darnassus", 5854, criterion=17786, side="horde", season="Feast of Winter Veil", trivia={criteria="Darnassus", module="seasonal_winter", category="World Events/Winter Veil", name="A-Caroling We Will Go", description="Use your Gaudy Winter Veil Sweater to carol in enemy capital cities during the Feast of Winter Veil.", mapID="Darnassus", uiMapID=89, points=10, parent="World Events", type=29}}

-- World Events/Winter Veil: Bros. Before Ho Ho Ho's
A{"Dustwallow", 1686, 0.6720, 0.4720, criterion=6231, side="alliance", season="Feast of Winter Veil", trivia={criteria="Brother Karman in Theramore", module="seasonal_winter", category="World Events/Winter Veil", name="Bros. Before Ho Ho Ho's", description="Use Mistletoe on the Alliance \"Brothers\" during the Feast of Winter Veil.", mapID="DustwallowMarsh", uiMapID=70, points=10, parent="World Events", type=110}}
A{"Elwynn", 1686, 0.4100, 0.6580, criterion=6229, side="alliance", season="Feast of Winter Veil", trivia={criteria="Brother Wilhelm in Goldshire", module="seasonal_winter", category="World Events/Winter Veil", name="Bros. Before Ho Ho Ho's", description="Use Mistletoe on the Alliance \"Brothers\" during the Feast of Winter Veil.", mapID="ElwynnForest", uiMapID=37, points=10, parent="World Events", type=110}}

-- World Events/Winter Veil: Iron Armada
A{"garrisonffhorde_tier3", 10353, criterion=28987, side="horde", season="Feast of Winter Veil", trivia={criteria="Crashin' Thrashin' Killdozer", module="seasonal_winter", category="World Events/Winter Veil", name="Iron Armada", description="Collect all five toys that are part of the Crashin' Thrashin' \"Iron Armada\" set.", points=10, parent="World Events", type=36}}
A{"garrisonsmvalliance_tier3", 10353, 0.4430, 0.5110, criterion=28987, side="alliance", season="Feast of Winter Veil", trivia={criteria="Crashin' Thrashin' Killdozer", module="seasonal_winter", category="World Events/Winter Veil", name="Iron Armada", description="Collect all five toys that are part of the Crashin' Thrashin' \"Iron Armada\" set.", points=10, parent="World Events", type=36}}

-- World Events/Winter Veil: On Metzen!
A{"HillsbradFoothills", 273, 0.4200, 0.4100, season="Feast of Winter Veil", trivia={module="seasonal_winter", category="World Events/Winter Veil", name="On Metzen!", description="Save Metzen the Reindeer.", mapID="HillsbradFoothills", uiMapID=25, points=10, parent="World Events"}}

-- World Events/Winter Veil: Bros. Before Ho Ho Ho's
A{"IcecrownGlacier", 1685, 0.7000, 0.4100, criterion=6662, note="on airship", side="horde", season="Feast of Winter Veil", trivia={criteria="Brother Keltan in Icecrown", module="seasonal_winter", category="World Events/Winter Veil", name="Bros. Before Ho Ho Ho's", description="Use Mistletoe on the Horde \"Brothers\" during the Feast of Winter Veil.", mapID="Icecrown", uiMapID=118, points=10, parent="World Events", type=110}}

-- World Events/Winter Veil: Simply Abominable
A{"Ironforge", 279, 0.3300, 0.6800, side="alliance", season="Feast of Winter Veil", trivia={module="seasonal_winter", category="World Events/Winter Veil", name="Simply Abominable", description="Complete the quest to retrieve Smokywood Pastures' stolen treats and receive a Smokywood Pastures' Thank You.", mapID="Ironforge", uiMapID=87, points=10, parent="World Events", type="quest"}}

-- World Events/Winter Veil: Scrooge
A{"Ironforge", 1255, side="alliance", season="Feast of Winter Veil", trivia={module="seasonal_winter", category="World Events/Winter Veil", name="Scrooge", description="Throw a snowball at Muradin Bronzebeard during the Feast of Winter Veil.", mapID="Ironforge", uiMapID=87, points=10, parent="World Events"}}

-- World Events/Winter Veil: He Knows If You've Been Naughty
A{"Ironforge", 1689, 0.3350, 0.6620, side="alliance", season="Feast of Winter Veil", trivia={module="seasonal_winter", category="World Events/Winter Veil", name="He Knows If You've Been Naughty", description="Open one of the presents underneath the Winter Veil tree once they are available.", mapID="Ironforge", uiMapID=87, points=10, parent="World Events"}}

-- World Events/Winter Veil: BB King
A{"Ironforge", 4437, 0.4000, 0.5500, criterion=12664, side="horde", season="Feast of Winter Veil", trivia={criteria="Muradin Bronzebeard", module="seasonal_winter", category="World Events/Winter Veil", name="BB King", description="Pelt the enemy leaders listed below.", mapID="Ironforge", uiMapID=87, points=10, parent="World Events", type=110}}

-- World Events/Winter Veil: A-Caroling We Will Go
A{"Ironforge", 5854, criterion=17784, side="horde", season="Feast of Winter Veil", trivia={criteria="Ironforge", module="seasonal_winter", category="World Events/Winter Veil", name="A-Caroling We Will Go", description="Use your Gaudy Winter Veil Sweater to carol in enemy capital cities during the Feast of Winter Veil.", mapID="Ironforge", uiMapID=87, points=10, parent="World Events", type=29}}

-- World Events/Winter Veil: Iron Armada
A{"Ironforge", 10353, 0.3340, 0.6560, criterion=28924, season="Feast of Winter Veil", trivia={criteria="Crashin' Thrashin' Flamer", module="seasonal_winter", category="World Events/Winter Veil", name="Iron Armada", description="Collect all five toys that are part of the Crashin' Thrashin' \"Iron Armada\" set.", mapID="Ironforge", uiMapID=87, points=10, parent="World Events", type=36}}

-- World Events/Winter Veil: Simply Abominable
A{"Orgrimmar", 279, 0.5200, 0.7700, side="horde", season="Feast of Winter Veil", trivia={module="seasonal_winter", category="World Events/Winter Veil", name="Simply Abominable", description="Complete the quest to retrieve Smokywood Pastures' stolen treats and receive a Smokywood Pastures' Thank You.", mapID="Orgrimmar", uiMapID=85, points=10, parent="World Events", type="quest"}}

-- World Events/Winter Veil: He Knows If You've Been Naughty
A{"Orgrimmar", 1689, 0.4920, 0.7760, side="horde", season="Feast of Winter Veil", trivia={module="seasonal_winter", category="World Events/Winter Veil", name="He Knows If You've Been Naughty", description="Open one of the presents underneath the Winter Veil tree once they are available.", mapID="Orgrimmar", uiMapID=85, points=10, parent="World Events"}}

-- World Events/Winter Veil: BB King
A{"Orgrimmar", 4436, 0.4820, 0.7060, criterion=12658, side="alliance", season="Feast of Winter Veil", trivia={criteria="Vol'jin", module="seasonal_winter", category="World Events/Winter Veil", name="BB King", description="Pelt the enemy leaders listed below.", mapID="Orgrimmar", uiMapID=85, points=10, parent="World Events", type=110}}

-- World Events/Winter Veil: A-Caroling We Will Go
A{"Orgrimmar", 5853, criterion=17780, side="alliance", season="Feast of Winter Veil", trivia={criteria="Orgrimmar", module="seasonal_winter", category="World Events/Winter Veil", name="A-Caroling We Will Go", description="Use your Gaudy Winter Veil Sweater to carol in enemy capital cities during the Feast of Winter Veil.", mapID="Orgrimmar", uiMapID=85, points=10, parent="World Events", type=29}}

-- World Events/Winter Veil: BB King
A{"SilvermoonCity", 4436, 0.5400, 0.2060, criterion=12660, side="alliance", season="Feast of Winter Veil", trivia={criteria="Lor'themar Theron", module="seasonal_winter", category="World Events/Winter Veil", name="BB King", description="Pelt the enemy leaders listed below.", mapID="SilvermoonCity", uiMapID=110, points=10, parent="World Events", type=110}}

-- World Events/Winter Veil: A-Caroling We Will Go
A{"SilvermoonCity", 5853, criterion=17781, side="alliance", season="Feast of Winter Veil", trivia={criteria="Silvermoon City", module="seasonal_winter", category="World Events/Winter Veil", name="A-Caroling We Will Go", description="Use your Gaudy Winter Veil Sweater to carol in enemy capital cities during the Feast of Winter Veil.", mapID="SilvermoonCity", uiMapID=110, points=10, parent="World Events", type=29}}

-- World Events/Winter Veil: Bros. Before Ho Ho Ho's
A{"StormwindCity", 1686, 0.4980, 0.4560, criterion=6232, side="alliance", season="Feast of Winter Veil", trivia={criteria="Brother Joshua in Stormwind", module="seasonal_winter", category="World Events/Winter Veil", name="Bros. Before Ho Ho Ho's", description="Use Mistletoe on the Alliance \"Brothers\" during the Feast of Winter Veil.", mapID="StormwindCity", uiMapID=84, points=10, parent="World Events", type=110}}
A{"StormwindCity", 1686, 0.5260, 0.4360, criterion=6233, side="alliance", season="Feast of Winter Veil", trivia={criteria="Brother Crowley in Stormwind", module="seasonal_winter", category="World Events/Winter Veil", name="Bros. Before Ho Ho Ho's", description="Use Mistletoe on the Alliance \"Brothers\" during the Feast of Winter Veil.", mapID="StormwindCity", uiMapID=84, points=10, parent="World Events", type=110}}
A{"StormwindCity", 1686, 0.5240, 0.4540, criterion=6234, side="alliance", season="Feast of Winter Veil", trivia={criteria="Brother Cassius in Stormwind", module="seasonal_winter", category="World Events/Winter Veil", name="Bros. Before Ho Ho Ho's", description="Use Mistletoe on the Alliance \"Brothers\" during the Feast of Winter Veil.", mapID="StormwindCity", uiMapID=84, points=10, parent="World Events", type=110}}
A{"StormwindCity", 1686, 0.5460, 0.5360, criterion=6230, side="alliance", season="Feast of Winter Veil", trivia={criteria="Brother Kristoff in Stormwind", module="seasonal_winter", category="World Events/Winter Veil", name="Bros. Before Ho Ho Ho's", description="Use Mistletoe on the Alliance \"Brothers\" during the Feast of Winter Veil.", mapID="StormwindCity", uiMapID=84, points=10, parent="World Events", type=110}}
A{"StormwindCity", 1686, 0.5180, 0.4680, criterion=6235, side="alliance", season="Feast of Winter Veil", trivia={criteria="Brother Benjamin in Stormwind", module="seasonal_winter", category="World Events/Winter Veil", name="Bros. Before Ho Ho Ho's", description="Use Mistletoe on the Alliance \"Brothers\" during the Feast of Winter Veil.", mapID="StormwindCity", uiMapID=84, points=10, parent="World Events", type=110}}

-- World Events/Winter Veil: BB King
A{"StormwindCity", 4437, 0.8560, 0.3180, criterion=12663, side="horde", season="Feast of Winter Veil", trivia={criteria="King Varian Wrynn", module="seasonal_winter", category="World Events/Winter Veil", name="BB King", description="Pelt the enemy leaders listed below.", mapID="StormwindCity", uiMapID=84, points=10, parent="World Events", type=110}}

-- World Events/Winter Veil: A-Caroling We Will Go
A{"StormwindCity", 5854, criterion=17787, side="horde", season="Feast of Winter Veil", trivia={criteria="Stormwind City", module="seasonal_winter", category="World Events/Winter Veil", name="A-Caroling We Will Go", description="Use your Gaudy Winter Veil Sweater to carol in enemy capital cities during the Feast of Winter Veil.", mapID="StormwindCity", uiMapID=84, points=10, parent="World Events", type=29}}

-- World Events/Winter Veil: Bros. Before Ho Ho Ho's
A{"StranglethornJungle", 1686, 0.4720, 0.1100, criterion=6228, side="alliance", season="Feast of Winter Veil", trivia={criteria="Brother Nimetz in Stranglethorn Vale", module="seasonal_winter", category="World Events/Winter Veil", name="Bros. Before Ho Ho Ho's", description="Use Mistletoe on the Alliance \"Brothers\" during the Feast of Winter Veil.", mapID="NorthernStranglethorn", uiMapID=50, points=10, parent="World Events", type=110}}

-- World Events/Winter Veil: Iron Armada
A{"TanaanJungle", 10353, 0.8750, 0.5610, criterion=28988, season="Feast of Winter Veil", trivia={criteria="Crashin' Thrashin' Mortar", module="seasonal_winter", category="World Events/Winter Veil", name="Iron Armada", description="Collect all five toys that are part of the Crashin' Thrashin' \"Iron Armada\" set.", mapID="TanaanJungle", uiMapID=534, points=10, parent="World Events", type=36}}
A{"TanaanJungle", 10353, 0.8070, 0.5610, criterion=28989, season="Feast of Winter Veil", trivia={criteria="Crashin' Thrashin' Cannon", module="seasonal_winter", category="World Events/Winter Veil", name="Iron Armada", description="Collect all five toys that are part of the Crashin' Thrashin' \"Iron Armada\" set.", mapID="TanaanJungle", uiMapID=534, points=10, parent="World Events", type=36}}
A{"TanaanJungle", 10353, 0.8390, 0.4320, criterion=28990, season="Feast of Winter Veil", trivia={criteria="Crashin' Thrashin' Roller", module="seasonal_winter", category="World Events/Winter Veil", name="Iron Armada", description="Collect all five toys that are part of the Crashin' Thrashin' \"Iron Armada\" set.", mapID="TanaanJungle", uiMapID=534, points=10, parent="World Events", type=36}}

-- World Events/Winter Veil: BB King
A{"TheExodar", 4437, 0.3260, 0.5460, criterion=12667, side="horde", season="Feast of Winter Veil", trivia={criteria="Prophet Velen", module="seasonal_winter", category="World Events/Winter Veil", name="BB King", description="Pelt the enemy leaders listed below.", mapID="TheExodar", uiMapID=103, points=10, parent="World Events", type=110}}

-- World Events/Winter Veil: A-Caroling We Will Go
A{"TheExodar", 5854, criterion=17785, side="horde", season="Feast of Winter Veil", trivia={criteria="The Exodar", module="seasonal_winter", category="World Events/Winter Veil", name="A-Caroling We Will Go", description="Use your Gaudy Winter Veil Sweater to carol in enemy capital cities during the Feast of Winter Veil.", mapID="TheExodar", uiMapID=103, points=10, parent="World Events", type=29}}

-- World Events/Winter Veil: Scrooge
A{"ThunderBluff", 259, 0.6000, 0.5200, side="horde", season="Feast of Winter Veil", trivia={module="seasonal_winter", category="World Events/Winter Veil", name="Scrooge", description="Throw a snowball at Baine Bloodhoof during the Feast of Winter Veil.", mapID="ThunderBluff", uiMapID=88, points=10, parent="World Events"}}

-- World Events/Winter Veil: BB King
A{"ThunderBluff", 4436, 0.5980, 0.5160, criterion=12662, side="alliance", season="Feast of Winter Veil", trivia={criteria="Baine Bloodhoof", module="seasonal_winter", category="World Events/Winter Veil", name="BB King", description="Pelt the enemy leaders listed below.", mapID="ThunderBluff", uiMapID=88, points=10, parent="World Events", type=110}}

-- World Events/Winter Veil: A-Caroling We Will Go
A{"ThunderBluff", 5853, criterion=17782, side="alliance", season="Feast of Winter Veil", trivia={criteria="Thunder Bluff", module="seasonal_winter", category="World Events/Winter Veil", name="A-Caroling We Will Go", description="Use your Gaudy Winter Veil Sweater to carol in enemy capital cities during the Feast of Winter Veil.", mapID="ThunderBluff", uiMapID=88, points=10, parent="World Events", type=29}}

-- World Events/Winter Veil: Bros. Before Ho Ho Ho's
A{"Undercity", 1685, 0.5080, 0.2170, criterion=6225, side="horde", season="Feast of Winter Veil", trivia={criteria="Brother Malach in the Undercity", module="seasonal_winter", category="World Events/Winter Veil", name="Bros. Before Ho Ho Ho's", description="Use Mistletoe on the Horde \"Brothers\" during the Feast of Winter Veil.", mapID="Undercity", uiMapID=90, points=10, parent="World Events", type=110}}

-- World Events/Winter Veil: BB King
A{"Undercity", 4436, 0.5780, 0.9160, criterion=12661, side="alliance", season="Feast of Winter Veil", trivia={criteria="Lady Sylvanas Windrunner", module="seasonal_winter", category="World Events/Winter Veil", name="BB King", description="Pelt the enemy leaders listed below.", mapID="Undercity", uiMapID=90, points=10, parent="World Events", type=110}}

-- World Events/Winter Veil: A-Caroling We Will Go
A{"Undercity", 5853, criterion=17783, side="alliance", season="Feast of Winter Veil", trivia={criteria="Undercity", module="seasonal_winter", category="World Events/Winter Veil", name="A-Caroling We Will Go", description="Use your Gaudy Winter Veil Sweater to carol in enemy capital cities during the Feast of Winter Veil.", mapID="Undercity", uiMapID=90, points=10, parent="World Events", type=29}}

-- World Events/Winter Veil: With a Little Helper from My Friends
A{"unknown", 252, criterion=0, season="Feast of Winter Veil", trivia={criteria="Earn 50 honorable kills as a Little Helper from the Winter Wondervolt machine.", module="seasonal_winter", category="World Events/Winter Veil", name="With a Little Helper from My Friends", description="Earn 50 honorable kills as a Little Helper from the Winter Wondervolt machine.", points=10, parent="World Events"}}

-- World Events/Winter Veil: Tis the Season
A{"unknown", 277, season="Feast of Winter Veil", trivia={module="seasonal_winter", category="World Events/Winter Veil", name="Tis the Season", description="During the Feast of Winter Veil, wear 3 pieces of winter clothing and eat Graccu's Mince Meat Fruitcake.", points=10, parent="World Events"}}

-- World Events/Winter Veil: Crashin' & Thrashin'
A{"unknown", 1295, criterion=4090, season="Feast of Winter Veil", trivia={criteria="Gain 25 crashes with your Crashin' Thrashin' Racer", module="seasonal_winter", category="World Events/Winter Veil", name="Crashin' & Thrashin'", description="Gain 25 crashes with your Crashin' Thrashin' Racer during the Feast of Winter Veil.", points=10, parent="World Events", type=28}}

-- World Events/Winter Veil: Let It Snow
A{"unknown", 1687, criterion=6245, season="Feast of Winter Veil", trivia={criteria="Blood Elf Warlock", module="seasonal_winter", category="World Events/Winter Veil", name="Let It Snow", description="During the Feast of Winter Veil, use a Handful of Snowflakes on each of the race/class combinations listed below.", points=10, parent="World Events", type=110}}
A{"unknown", 1687, criterion=6246, season="Feast of Winter Veil", trivia={criteria="Draenei Priest", module="seasonal_winter", category="World Events/Winter Veil", name="Let It Snow", description="During the Feast of Winter Veil, use a Handful of Snowflakes on each of the race/class combinations listed below.", points=10, parent="World Events", type=110}}
A{"unknown", 1687, criterion=6237, season="Feast of Winter Veil", trivia={criteria="Orc Death Knight", module="seasonal_winter", category="World Events/Winter Veil", name="Let It Snow", description="During the Feast of Winter Veil, use a Handful of Snowflakes on each of the race/class combinations listed below.", points=10, parent="World Events", type=110}}
A{"unknown", 1687, criterion=6241, season="Feast of Winter Veil", trivia={criteria="Undead Rogue", module="seasonal_winter", category="World Events/Winter Veil", name="Let It Snow", description="During the Feast of Winter Veil, use a Handful of Snowflakes on each of the race/class combinations listed below.", points=10, parent="World Events", type=110}}
A{"unknown", 1687, criterion=6240, season="Feast of Winter Veil", trivia={criteria="Night Elf Druid", module="seasonal_winter", category="World Events/Winter Veil", name="Let It Snow", description="During the Feast of Winter Veil, use a Handful of Snowflakes on each of the race/class combinations listed below.", points=10, parent="World Events", type=110}}
A{"unknown", 1687, criterion=6238, season="Feast of Winter Veil", trivia={criteria="Human Warrior", module="seasonal_winter", category="World Events/Winter Veil", name="Let It Snow", description="During the Feast of Winter Veil, use a Handful of Snowflakes on each of the race/class combinations listed below.", points=10, parent="World Events", type=110}}
A{"unknown", 1687, criterion=6242, season="Feast of Winter Veil", trivia={criteria="Troll Hunter", module="seasonal_winter", category="World Events/Winter Veil", name="Let It Snow", description="During the Feast of Winter Veil, use a Handful of Snowflakes on each of the race/class combinations listed below.", points=10, parent="World Events", type=110}}
A{"unknown", 1687, criterion=6243, season="Feast of Winter Veil", trivia={criteria="Gnome Mage", module="seasonal_winter", category="World Events/Winter Veil", name="Let It Snow", description="During the Feast of Winter Veil, use a Handful of Snowflakes on each of the race/class combinations listed below.", points=10, parent="World Events", type=110}}
A{"unknown", 1687, criterion=6239, season="Feast of Winter Veil", trivia={criteria="Tauren Shaman", module="seasonal_winter", category="World Events/Winter Veil", name="Let It Snow", description="During the Feast of Winter Veil, use a Handful of Snowflakes on each of the race/class combinations listed below.", points=10, parent="World Events", type=110}}
A{"unknown", 1687, criterion=6244, season="Feast of Winter Veil", trivia={criteria="Dwarf Paladin", module="seasonal_winter", category="World Events/Winter Veil", name="Let It Snow", description="During the Feast of Winter Veil, use a Handful of Snowflakes on each of the race/class combinations listed below.", points=10, parent="World Events", type=110}}

-- World Events/Winter Veil: The Winter Veil Gourmet
A{"unknown", 1688, criterion=6248, season="Feast of Winter Veil", trivia={criteria="Winter Veil Egg Nog", module="seasonal_winter", category="World Events/Winter Veil", name="The Winter Veil Gourmet", description="During the Feast of Winter Veil, use your culinary expertise to produce a Gingerbread Cookie, Winter Veil Egg Nog and Hot Apple Cider.", points=10, parent="World Events", type=29}}
A{"unknown", 1688, criterion=6247, season="Feast of Winter Veil", trivia={criteria="Gingerbread Cookie", module="seasonal_winter", category="World Events/Winter Veil", name="The Winter Veil Gourmet", description="During the Feast of Winter Veil, use your culinary expertise to produce a Gingerbread Cookie, Winter Veil Egg Nog and Hot Apple Cider.", points=10, parent="World Events", type=29}}
A{"unknown", 1688, criterion=6249, season="Feast of Winter Veil", trivia={criteria="Hot Apple Cider", module="seasonal_winter", category="World Events/Winter Veil", name="The Winter Veil Gourmet", description="During the Feast of Winter Veil, use your culinary expertise to produce a Gingerbread Cookie, Winter Veil Egg Nog and Hot Apple Cider.", points=10, parent="World Events", type=29}}

-- World Events/Winter Veil: A Frosty Shake
A{"unknown", 1690, season="Feast of Winter Veil", trivia={module="seasonal_winter", category="World Events/Winter Veil", name="A Frosty Shake", description="During the Feast of Winter Veil, use your Winter Veil Disguise kit to become a snowman and then dance with another snowman in Dalaran.", points=10, parent="World Events"}}

-- World Events: Merrymaker
A{"unknown", 1691, criterion=6262, season="Feast of Winter Veil", trivia={criteria="On Metzen!", module="seasonal_winter", category="World Events", name="Merrymaker", description="Complete the Winter Veil achievements listed below.", points=10, type="achievement"}}
A{"unknown", 1691, criterion=6266, season="Feast of Winter Veil", trivia={criteria="Tis the Season", module="seasonal_winter", category="World Events", name="Merrymaker", description="Complete the Winter Veil achievements listed below.", points=10, type="achievement"}}
A{"unknown", 1691, criterion=6269, season="Feast of Winter Veil", trivia={criteria="Let It Snow", module="seasonal_winter", category="World Events", name="Merrymaker", description="Complete the Winter Veil achievements listed below.", points=10, type="achievement"}}
A{"unknown", 1691, criterion=6271, season="Feast of Winter Veil", trivia={criteria="The Winter Veil Gourmet", module="seasonal_winter", category="World Events", name="Merrymaker", description="Complete the Winter Veil achievements listed below.", points=10, type="achievement"}}
A{"unknown", 1691, criterion=6272, season="Feast of Winter Veil", trivia={criteria="He Knows If You've Been Naughty", module="seasonal_winter", category="World Events", name="Merrymaker", description="Complete the Winter Veil achievements listed below.", points=10, type="achievement"}}
A{"unknown", 1691, criterion=6273, season="Feast of Winter Veil", trivia={criteria="A Frosty Shake", module="seasonal_winter", category="World Events", name="Merrymaker", description="Complete the Winter Veil achievements listed below.", points=10, type="achievement"}}
A{"unknown", 1691, criterion=6263, season="Feast of Winter Veil", trivia={criteria="With a Little Helper from My Friends", module="seasonal_winter", category="World Events", name="Merrymaker", description="Complete the Winter Veil achievements listed below.", points=10, type="achievement"}}
A{"unknown", 1691, criterion=6268, season="Feast of Winter Veil", trivia={criteria="Simply Abominable", module="seasonal_winter", category="World Events", name="Merrymaker", description="Complete the Winter Veil achievements listed below.", points=10, type="achievement"}}
A{"unknown", 1691, criterion=6264, season="Feast of Winter Veil", trivia={criteria="Scrooge", module="seasonal_winter", category="World Events", name="Merrymaker", description="Complete the Winter Veil achievements listed below.", points=10, type="achievement"}}
A{"unknown", 1691, criterion=6270, season="Feast of Winter Veil", trivia={criteria="Bros. Before Ho Ho Ho's", module="seasonal_winter", category="World Events", name="Merrymaker", description="Complete the Winter Veil achievements listed below.", points=10, type="achievement"}}

-- World Events: What a Long, Strange Trip It's Been
A{"unknown", 2144, criterion=7566, season="Feast of Winter Veil", trivia={criteria="Merrymaker", module="seasonal_winter", category="World Events", name="What a Long, Strange Trip It's Been", description="Complete the world events achievements listed below.", points=50, type="achievement"}}

-- World Events/Winter Veil: The Danger Zone
A{"unknown", 8699, season="Feast of Winter Veil", trivia={module="seasonal_winter", category="World Events/Winter Veil", name="The Danger Zone", description="Shoot down another player's Crashin' Thrashin' Flyer with yours.", points=10, parent="World Events"}}
