local AL = LibStub:GetLibrary("AchievementLocations-1.0")
local function A(row) AL:AddLocation(row) end

-- Player vs. Player/Alterac Valley: Alterac Valley Victory
A{"AlteracValley", 218, trivia={module="pvp", category="Player vs. Player/Alterac Valley", name="Alterac Valley Victory", description="Win Alterac Valley.", mapID="AlteracValley", uiMapID=91, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Alterac Valley: Alterac Valley Veteran
A{"AlteracValley", 219, criterion=17411, trivia={criteria="Complete 100 victories in Alterac Valley", module="pvp", category="Player vs. Player/Alterac Valley", name="Alterac Valley Veteran", description="Complete 100 victories in Alterac Valley.", mapID="AlteracValley", uiMapID=91, points=10, parent="Player vs. Player", type=1}}

-- Player vs. Player/Alterac Valley: Stormpike Perfection
A{"AlteracValley", 220, side="alliance", trivia={module="pvp", category="Player vs. Player/Alterac Valley", name="Stormpike Perfection", description="Win Alterac Valley without losing a tower or captain. You must also control all of the Horde's towers.", mapID="AlteracValley", uiMapID=91, points=20, parent="Player vs. Player"}}

-- Player vs. Player/Alterac Valley: Alterac Grave Robber
A{"AlteracValley", 221, criterion=419, trivia={criteria="Take 50 graveyards", module="pvp", category="Player vs. Player/Alterac Valley", name="Alterac Grave Robber", description="Take 50 graveyards in Alterac Valley.", mapID="AlteracValley", uiMapID=91, points=10, parent="Player vs. Player", type=30}}

-- Player vs. Player/Alterac Valley: Tower Defense
A{"AlteracValley", 222, criterion=436, trivia={criteria="50 towers defended", module="pvp", category="Player vs. Player/Alterac Valley", name="Tower Defense", description="Defend 50 towers in Alterac Valley.", mapID="AlteracValley", uiMapID=91, points=10, parent="Player vs. Player", type=30}}

-- Player vs. Player/Alterac Valley: The Sickly Gazelle
A{"AlteracValley", 223, trivia={module="pvp", category="Player vs. Player/Alterac Valley", name="The Sickly Gazelle", description="In Alterac Valley, kill an enemy in the Field of Strife before they dismount.", mapID="AlteracValley", uiMapID=91, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Alterac Valley: Loyal Defender
A{"AlteracValley", 224, criterion=3362, side="horde", trivia={criteria="50 honorable kills in the Hall of the Frostwolf", module="pvp", category="Player vs. Player/Alterac Valley", name="Loyal Defender", description="In Alterac Valley, kill 50 enemy players in the Hall of the Frostwolf.", mapID="AlteracValley", uiMapID=91, points=10, parent="Player vs. Player", type=31}}

-- Player vs. Player/Alterac Valley: Everything Counts
A{"AlteracValley", 225, side="alliance", trivia={module="pvp", category="Player vs. Player/Alterac Valley", name="Everything Counts", description="Win Alterac Valley while your team controls both mines.", mapID="AlteracValley", uiMapID=91, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Alterac Valley: The Alterac Blitz
A{"AlteracValley", 226, trivia={module="pvp", category="Player vs. Player/Alterac Valley", name="The Alterac Blitz", description="Win Alterac Valley in 6 minutes.", mapID="AlteracValley", uiMapID=91, points=20, parent="Player vs. Player"}}

-- Player vs. Player/Alterac Valley: Alterac Valley All-Star
A{"AlteracValley", 582, criterion=423, trivia={criteria="Assault a tower", module="pvp", category="Player vs. Player/Alterac Valley", name="Alterac Valley All-Star", description="In a single Alterac Valley battle, assault a graveyard, defend a graveyard, assault a tower, defend a tower and slay someone in the Field of Strife.", mapID="AlteracValley", uiMapID=91, points=20, parent="Player vs. Player", type=30}}
A{"AlteracValley", 582, criterion=422, trivia={criteria="Defend a graveyard", module="pvp", category="Player vs. Player/Alterac Valley", name="Alterac Valley All-Star", description="In a single Alterac Valley battle, assault a graveyard, defend a graveyard, assault a tower, defend a tower and slay someone in the Field of Strife.", mapID="AlteracValley", uiMapID=91, points=20, parent="Player vs. Player", type=30}}
A{"AlteracValley", 582, criterion=425, trivia={criteria="Kill someone in the Field of Strife", module="pvp", category="Player vs. Player/Alterac Valley", name="Alterac Valley All-Star", description="In a single Alterac Valley battle, assault a graveyard, defend a graveyard, assault a tower, defend a tower and slay someone in the Field of Strife.", mapID="AlteracValley", uiMapID=91, points=20, parent="Player vs. Player", type=31}}
A{"AlteracValley", 582, criterion=424, trivia={criteria="Defend a tower", module="pvp", category="Player vs. Player/Alterac Valley", name="Alterac Valley All-Star", description="In a single Alterac Valley battle, assault a graveyard, defend a graveyard, assault a tower, defend a tower and slay someone in the Field of Strife.", mapID="AlteracValley", uiMapID=91, points=20, parent="Player vs. Player", type=30}}
A{"AlteracValley", 582, criterion=421, trivia={criteria="Assault a graveyard", module="pvp", category="Player vs. Player/Alterac Valley", name="Alterac Valley All-Star", description="In a single Alterac Valley battle, assault a graveyard, defend a graveyard, assault a tower, defend a tower and slay someone in the Field of Strife.", mapID="AlteracValley", uiMapID=91, points=20, parent="Player vs. Player", type=30}}

-- Player vs. Player/Alterac Valley: Frostwolf Howler
A{"AlteracValley", 706, side="horde", trivia={module="pvp", category="Player vs. Player/Alterac Valley", name="Frostwolf Howler", description="Obtain a Frostwolf Howler.", mapID="AlteracValley", uiMapID=91, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Alterac Valley: Stormpike Battle Charger
A{"AlteracValley", 707, side="alliance", trivia={module="pvp", category="Player vs. Player/Alterac Valley", name="Stormpike Battle Charger", description="Obtain a Stormpike Battle Charger.", mapID="AlteracValley", uiMapID=91, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Alterac Valley: Hero of the Frostwolf Clan
A{"AlteracValley", 708, faction=729, side="horde", trivia={module="pvp", category="Player vs. Player/Alterac Valley", name="Hero of the Frostwolf Clan", description="Gain exalted reputation with the Frostwolf Clan.", mapID="AlteracValley", uiMapID=91, points=10, parent="Player vs. Player", type="exalted"}}

-- Player vs. Player/Alterac Valley: Hero of the Stormpike Guard
A{"AlteracValley", 709, faction=730, side="alliance", trivia={module="pvp", category="Player vs. Player/Alterac Valley", name="Hero of the Stormpike Guard", description="Gain exalted reputation with the Stormpike Guard.", mapID="AlteracValley", uiMapID=91, points=10, parent="Player vs. Player", type="exalted"}}

-- Player vs. Player: The Conqueror
A{"AlteracValley", 714, criterion=5320, faction=729, side="horde", trivia={criteria="Hero of the Frostwolf Clan", module="pvp", category="Player vs. Player", name="The Conqueror", description="Raise your reputation values in Warsong Gulch, Arathi Basin and Alterac Valley to Exalted.", mapID="AlteracValley", uiMapID=91, points=20, type=46}}

-- Player vs. Player/Alterac Valley: Frostwolf Perfection
A{"AlteracValley", 873, side="horde", trivia={module="pvp", category="Player vs. Player/Alterac Valley", name="Frostwolf Perfection", description="Win Alterac Valley without losing a tower or captain. You must also control all of the Alliance's towers.", mapID="AlteracValley", uiMapID=91, points=20, parent="Player vs. Player"}}

-- Player vs. Player: The Justicar
A{"AlteracValley", 907, criterion=5335, faction=730, side="alliance", trivia={criteria="Hero of the Stormpike Guard", module="pvp", category="Player vs. Player", name="The Justicar", description="Raise your reputation values in Warsong Gulch, Arathi Basin and Alterac Valley to Exalted.", mapID="AlteracValley", uiMapID=91, points=20, type=46}}

-- Player vs. Player/Alterac Valley: Loyal Defender
A{"AlteracValley", 1151, criterion=3363, side="alliance", trivia={criteria="50 honorable kills in the Hall of the Stormpike", module="pvp", category="Player vs. Player/Alterac Valley", name="Loyal Defender", description="In Alterac Valley, kill 50 enemy players in the Hall of the Stormpike.", mapID="AlteracValley", uiMapID=91, points=10, parent="Player vs. Player", type=31}}

-- Player vs. Player/Alterac Valley: Everything Counts
A{"AlteracValley", 1164, side="horde", trivia={module="pvp", category="Player vs. Player/Alterac Valley", name="Everything Counts", description="Win Alterac Valley while your team controls both mines.", mapID="AlteracValley", uiMapID=91, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Alterac Valley: To the Looter Go the Spoils
A{"AlteracValley", 1166, trivia={module="pvp", category="Player vs. Player/Alterac Valley", name="To the Looter Go the Spoils", description="Loot the Autographed Picture of Foror & Tigule in Alterac Valley.", mapID="AlteracValley", uiMapID=91, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Alterac Valley: Master of Alterac Valley
A{"AlteracValley", 1167, criterion=3403, trivia={criteria="To the Looter Go The Spoils", module="pvp", category="Player vs. Player/Alterac Valley", name="Master of Alterac Valley", description="Complete the Alterac Valley achievements listed below.", mapID="AlteracValley", uiMapID=91, points=25, parent="Player vs. Player", type="achievement"}}
A{"AlteracValley", 1167, criterion=3392, trivia={criteria="Alterac Valley Veteran", module="pvp", category="Player vs. Player/Alterac Valley", name="Master of Alterac Valley", description="Complete the Alterac Valley achievements listed below.", mapID="AlteracValley", uiMapID=91, points=25, parent="Player vs. Player", type="achievement"}}
A{"AlteracValley", 1167, criterion=3393, trivia={criteria="Alterac Grave Robber", module="pvp", category="Player vs. Player/Alterac Valley", name="Master of Alterac Valley", description="Complete the Alterac Valley achievements listed below.", mapID="AlteracValley", uiMapID=91, points=25, parent="Player vs. Player", type="achievement"}}
A{"AlteracValley", 1167, criterion=3400, trivia={criteria="Alterac Valley All-Star", module="pvp", category="Player vs. Player/Alterac Valley", name="Master of Alterac Valley", description="Complete the Alterac Valley achievements listed below.", mapID="AlteracValley", uiMapID=91, points=25, parent="Player vs. Player", type="achievement"}}
A{"AlteracValley", 1167, criterion=3394, trivia={criteria="Tower Defense", module="pvp", category="Player vs. Player/Alterac Valley", name="Master of Alterac Valley", description="Complete the Alterac Valley achievements listed below.", mapID="AlteracValley", uiMapID=91, points=25, parent="Player vs. Player", type="achievement"}}
A{"AlteracValley", 1167, criterion=3398, trivia={criteria="The Sickly Gazelle", module="pvp", category="Player vs. Player/Alterac Valley", name="Master of Alterac Valley", description="Complete the Alterac Valley achievements listed below.", mapID="AlteracValley", uiMapID=91, points=25, parent="Player vs. Player", type="achievement"}}
A{"AlteracValley", 1167, criterion=3395, side="alliance", trivia={criteria="Loyal Defender", module="pvp", category="Player vs. Player/Alterac Valley", name="Master of Alterac Valley", description="Complete the Alterac Valley achievements listed below.", mapID="AlteracValley", uiMapID=91, points=25, parent="Player vs. Player", type="achievement"}}
A{"AlteracValley", 1167, criterion=3396, side="alliance", trivia={criteria="Everything Counts", module="pvp", category="Player vs. Player/Alterac Valley", name="Master of Alterac Valley", description="Complete the Alterac Valley achievements listed below.", mapID="AlteracValley", uiMapID=91, points=25, parent="Player vs. Player", type="achievement"}}
A{"AlteracValley", 1167, criterion=3399, side="alliance", trivia={criteria="Stormpike/Frostwolf Perfection", module="pvp", category="Player vs. Player/Alterac Valley", name="Master of Alterac Valley", description="Complete the Alterac Valley achievements listed below.", mapID="AlteracValley", uiMapID=91, points=25, parent="Player vs. Player", type="achievement"}}
A{"AlteracValley", 1167, criterion=3401, side="alliance", trivia={criteria="Stormpike Battle Charger/Frostwolf Howler", module="pvp", category="Player vs. Player/Alterac Valley", name="Master of Alterac Valley", description="Complete the Alterac Valley achievements listed below.", mapID="AlteracValley", uiMapID=91, points=25, parent="Player vs. Player", type="achievement"}}
A{"AlteracValley", 1167, criterion=3407, side="horde", trivia={criteria="Loyal Defender", module="pvp", category="Player vs. Player/Alterac Valley", name="Master of Alterac Valley", description="Complete the Alterac Valley achievements listed below.", mapID="AlteracValley", uiMapID=91, points=25, parent="Player vs. Player", type="achievement"}}
A{"AlteracValley", 1167, criterion=3408, side="horde", trivia={criteria="Everything Counts", module="pvp", category="Player vs. Player/Alterac Valley", name="Master of Alterac Valley", description="Complete the Alterac Valley achievements listed below.", mapID="AlteracValley", uiMapID=91, points=25, parent="Player vs. Player", type="achievement"}}
A{"AlteracValley", 1167, criterion=3411, side="horde", trivia={criteria="Stormpike/Frostwolf Perfection", module="pvp", category="Player vs. Player/Alterac Valley", name="Master of Alterac Valley", description="Complete the Alterac Valley achievements listed below.", mapID="AlteracValley", uiMapID=91, points=25, parent="Player vs. Player", type="achievement"}}
A{"AlteracValley", 1167, criterion=3413, side="horde", trivia={criteria="Stormpike Battle Charger/Frostwolf Howler", module="pvp", category="Player vs. Player/Alterac Valley", name="Master of Alterac Valley", description="Complete the Alterac Valley achievements listed below.", mapID="AlteracValley", uiMapID=91, points=25, parent="Player vs. Player", type="achievement"}}

-- Player vs. Player/Arathi Basin: Disgracin' The Basin
A{"ArathiBasin", 73, trivia={module="pvp", category="Player vs. Player/Arathi Basin", name="Disgracin' The Basin", description="Assault 3 bases in a single Arathi Basin battle.", mapID="ArathiBasin", uiMapID=93, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Arathi Basin: Arathi Basin Victory
A{"ArathiBasin", 154, trivia={module="pvp", category="Player vs. Player/Arathi Basin", name="Arathi Basin Victory", description="Win Arathi Basin.", mapID="ArathiBasin", uiMapID=93, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Arathi Basin: Arathi Basin Veteran
A{"ArathiBasin", 155, criterion=5896, trivia={criteria="Complete 100 victories in Arathi Basin.", module="pvp", category="Player vs. Player/Arathi Basin", name="Arathi Basin Veteran", description="Complete 100 victories in Arathi Basin.", mapID="ArathiBasin", uiMapID=93, points=10, parent="Player vs. Player", type=1}}

-- Player vs. Player/Arathi Basin: Territorial Dominance
A{"ArathiBasin", 156, criterion=1234, trivia={criteria="Win 10 Arathi Basin matches while controlling all 5 flags", module="pvp", category="Player vs. Player/Arathi Basin", name="Territorial Dominance", description="Win 10 Arathi Basin matches while controlling all 5 flags.", mapID="ArathiBasin", uiMapID=93, points=10, parent="Player vs. Player", type=1}}

-- Player vs. Player/Arathi Basin: To The Rescue!
A{"ArathiBasin", 157, criterion=414, trivia={criteria="Defend 50 bases", module="pvp", category="Player vs. Player/Arathi Basin", name="To The Rescue!", description="Come to the defense of a base in Arathi Basin 50 times by recapping the flag.", mapID="ArathiBasin", uiMapID=93, points=10, parent="Player vs. Player", type=30}}

-- Player vs. Player/Arathi Basin: Me and the Cappin' Makin' it Happen
A{"ArathiBasin", 158, criterion=308, trivia={criteria="Take 50 flags in Arathi Basin", module="pvp", category="Player vs. Player/Arathi Basin", name="Me and the Cappin' Makin' it Happen", description="Take 50 flags in Arathi Basin.", mapID="ArathiBasin", uiMapID=93, points=10, parent="Player vs. Player", type=30}}

-- Player vs. Player/Arathi Basin: Let's Get This Done
A{"ArathiBasin", 159, trivia={module="pvp", category="Player vs. Player/Arathi Basin", name="Let's Get This Done", description="Win Arathi Basin in 6 minutes.", mapID="ArathiBasin", uiMapID=93, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Arathi Basin: Resilient Victory
A{"ArathiBasin", 161, trivia={module="pvp", category="Player vs. Player/Arathi Basin", name="Resilient Victory", description="Overcome a 500 resource disadvantage in a match of Arathi Basin and claim victory.", mapID="ArathiBasin", uiMapID=93, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Arathi Basin: We Had It All Along *cough*
A{"ArathiBasin", 162, trivia={module="pvp", category="Player vs. Player/Arathi Basin", name="We Had It All Along *cough*", description="Win Arathi Basin by 50 points or less.", mapID="ArathiBasin", uiMapID=93, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Arathi Basin: Arathi Basin Perfection
A{"ArathiBasin", 165, trivia={module="pvp", category="Player vs. Player/Arathi Basin", name="Arathi Basin Perfection", description="Win Arathi Basin with a score of 1600 to 0.", mapID="ArathiBasin", uiMapID=93, points=20, parent="Player vs. Player"}}

-- Player vs. Player/Arathi Basin: Arathi Basin All-Star
A{"ArathiBasin", 583, criterion=426, trivia={criteria="Assault 2 bases", module="pvp", category="Player vs. Player/Arathi Basin", name="Arathi Basin All-Star", description="Assault and Defend 2 bases in a single Arathi Basin match.", mapID="ArathiBasin", uiMapID=93, points=20, parent="Player vs. Player", type=30}}
A{"ArathiBasin", 583, criterion=427, trivia={criteria="Defend 2 bases", module="pvp", category="Player vs. Player/Arathi Basin", name="Arathi Basin All-Star", description="Assault and Defend 2 bases in a single Arathi Basin match.", mapID="ArathiBasin", uiMapID=93, points=20, parent="Player vs. Player", type=30}}

-- Player vs. Player/Arathi Basin: Arathi Basin Assassin
A{"ArathiBasin", 584, criterion=432, trivia={criteria="Kill 5 people at the farm", module="pvp", category="Player vs. Player/Arathi Basin", name="Arathi Basin Assassin", description="Get five honorable kills at each of the bases in a single Arathi Basin battle.", mapID="ArathiBasin", uiMapID=93, points=20, parent="Player vs. Player", type=31}}
A{"ArathiBasin", 584, criterion=433, trivia={criteria="Kill 5 people at the gold mine", module="pvp", category="Player vs. Player/Arathi Basin", name="Arathi Basin Assassin", description="Get five honorable kills at each of the bases in a single Arathi Basin battle.", mapID="ArathiBasin", uiMapID=93, points=20, parent="Player vs. Player", type=31}}
A{"ArathiBasin", 584, criterion=434, trivia={criteria="Kill 5 people at the lumber mill", module="pvp", category="Player vs. Player/Arathi Basin", name="Arathi Basin Assassin", description="Get five honorable kills at each of the bases in a single Arathi Basin battle.", mapID="ArathiBasin", uiMapID=93, points=20, parent="Player vs. Player", type=31}}
A{"ArathiBasin", 584, criterion=431, trivia={criteria="Kill 5 people at the blacksmith", module="pvp", category="Player vs. Player/Arathi Basin", name="Arathi Basin Assassin", description="Get five honorable kills at each of the bases in a single Arathi Basin battle.", mapID="ArathiBasin", uiMapID=93, points=20, parent="Player vs. Player", type=31}}
A{"ArathiBasin", 584, criterion=435, trivia={criteria="Kill 5 people at the stables", module="pvp", category="Player vs. Player/Arathi Basin", name="Arathi Basin Assassin", description="Get five honorable kills at each of the bases in a single Arathi Basin battle.", mapID="ArathiBasin", uiMapID=93, points=20, parent="Player vs. Player", type=31}}

-- Player vs. Player/Arathi Basin: The Defiler
A{"ArathiBasin", 710, faction=510, side="horde", trivia={module="pvp", category="Player vs. Player/Arathi Basin", name="The Defiler", description="Gain exalted reputation with The Forsaken Defilers.", mapID="ArathiBasin", uiMapID=93, points=10, parent="Player vs. Player", type="exalted"}}

-- Player vs. Player/Arathi Basin: Knight of Arathor
A{"ArathiBasin", 711, faction=509, side="alliance", trivia={module="pvp", category="Player vs. Player/Arathi Basin", name="Knight of Arathor", description="Gain exalted reputation with The League of Arathor.", mapID="ArathiBasin", uiMapID=93, points=10, parent="Player vs. Player", type="exalted"}}

-- Player vs. Player: The Conqueror
A{"ArathiBasin", 714, criterion=5318, faction=510, side="horde", trivia={criteria="The Defiler", module="pvp", category="Player vs. Player", name="The Conqueror", description="Raise your reputation values in Warsong Gulch, Arathi Basin and Alterac Valley to Exalted.", mapID="ArathiBasin", uiMapID=93, points=20, type=46}}

-- Player vs. Player: The Justicar
A{"ArathiBasin", 907, criterion=5333, faction=509, side="alliance", trivia={criteria="Knight of Arathor", module="pvp", category="Player vs. Player", name="The Justicar", description="Raise your reputation values in Warsong Gulch, Arathi Basin and Alterac Valley to Exalted.", mapID="ArathiBasin", uiMapID=93, points=20, type=46}}

-- Player vs. Player/Arathi Basin: Overly Defensive
A{"ArathiBasin", 1153, trivia={module="pvp", category="Player vs. Player/Arathi Basin", name="Overly Defensive", description="Defend 3 bases in a single Arathi Basin battle.", mapID="ArathiBasin", uiMapID=93, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Arathi Basin: Master of Arathi Basin
A{"ArathiBasin", 1169, criterion=3432, trivia={criteria="Arathi Basin Perfection", module="pvp", category="Player vs. Player/Arathi Basin", name="Master of Arathi Basin", description="Complete the Arathi Basin achievements listed below.", mapID="ArathiBasin", uiMapID=93, points=25, parent="Player vs. Player", type="achievement"}}
A{"ArathiBasin", 1169, criterion=3433, trivia={criteria="Me and the Cappin' Makin' it Happen", module="pvp", category="Player vs. Player/Arathi Basin", name="Master of Arathi Basin", description="Complete the Arathi Basin achievements listed below.", mapID="ArathiBasin", uiMapID=93, points=25, parent="Player vs. Player", type="achievement"}}
A{"ArathiBasin", 1169, criterion=3436, trivia={criteria="To The Rescue!", module="pvp", category="Player vs. Player/Arathi Basin", name="Master of Arathi Basin", description="Complete the Arathi Basin achievements listed below.", mapID="ArathiBasin", uiMapID=93, points=25, parent="Player vs. Player", type="achievement"}}
A{"ArathiBasin", 1169, criterion=3431, trivia={criteria="Arathi Basin Veteran", module="pvp", category="Player vs. Player/Arathi Basin", name="Master of Arathi Basin", description="Complete the Arathi Basin achievements listed below.", mapID="ArathiBasin", uiMapID=93, points=25, parent="Player vs. Player", type="achievement"}}
A{"ArathiBasin", 1169, criterion=3435, trivia={criteria="Overly Defensive", module="pvp", category="Player vs. Player/Arathi Basin", name="Master of Arathi Basin", description="Complete the Arathi Basin achievements listed below.", mapID="ArathiBasin", uiMapID=93, points=25, parent="Player vs. Player", type="achievement"}}
A{"ArathiBasin", 1169, criterion=3434, trivia={criteria="Disgracin' The Basin", module="pvp", category="Player vs. Player/Arathi Basin", name="Master of Arathi Basin", description="Complete the Arathi Basin achievements listed below.", mapID="ArathiBasin", uiMapID=93, points=25, parent="Player vs. Player", type="achievement"}}
A{"ArathiBasin", 1169, criterion=3445, trivia={criteria="Arathi Basin Assassin", module="pvp", category="Player vs. Player/Arathi Basin", name="Master of Arathi Basin", description="Complete the Arathi Basin achievements listed below.", mapID="ArathiBasin", uiMapID=93, points=25, parent="Player vs. Player", type="achievement"}}
A{"ArathiBasin", 1169, criterion=3437, trivia={criteria="Resilient Victory", module="pvp", category="Player vs. Player/Arathi Basin", name="Master of Arathi Basin", description="Complete the Arathi Basin achievements listed below.", mapID="ArathiBasin", uiMapID=93, points=25, parent="Player vs. Player", type="achievement"}}
A{"ArathiBasin", 1169, criterion=3444, trivia={criteria="Arathi Basin All-Star", module="pvp", category="Player vs. Player/Arathi Basin", name="Master of Arathi Basin", description="Complete the Arathi Basin achievements listed below.", mapID="ArathiBasin", uiMapID=93, points=25, parent="Player vs. Player", type="achievement"}}
A{"ArathiBasin", 1169, criterion=3438, trivia={criteria="Territorial Dominance", module="pvp", category="Player vs. Player/Arathi Basin", name="Master of Arathi Basin", description="Complete the Arathi Basin achievements listed below.", mapID="ArathiBasin", uiMapID=93, points=25, parent="Player vs. Player", type="achievement"}}
A{"ArathiBasin", 1169, criterion=3439, trivia={criteria="Let's Get This Done", module="pvp", category="Player vs. Player/Arathi Basin", name="Master of Arathi Basin", description="Complete the Arathi Basin achievements listed below.", mapID="ArathiBasin", uiMapID=93, points=25, parent="Player vs. Player", type="achievement"}}
A{"ArathiBasin", 1169, criterion=3442, trivia={criteria="We Had It All Along *cough*", module="pvp", category="Player vs. Player/Arathi Basin", name="Master of Arathi Basin", description="Complete the Arathi Basin achievements listed below.", mapID="ArathiBasin", uiMapID=93, points=25, parent="Player vs. Player", type="achievement"}}

-- Player vs. Player/Ashran: Ashran Victory
A{"Ashran", 9102, trivia={module="pvp", category="Player vs. Player/Ashran", name="Ashran Victory", description="Kill the opposing faction Commander while controlling all points on the Road of Glory.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Ashran: Bounty Hunter
A{"Ashran", 9103, criterion=25202, side="horde", trivia={criteria="Pandaren Hide", module="pvp", category="Player vs. Player/Ashran", name="Bounty Hunter", description="Loot all the following off Alliance player corpses:", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type=42}}
A{"Ashran", 9103, criterion=25201, side="horde", trivia={criteria="Worgen Snout", module="pvp", category="Player vs. Player/Ashran", name="Bounty Hunter", description="Loot all the following off Alliance player corpses:", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type=42}}
A{"Ashran", 9103, criterion=25200, side="horde", trivia={criteria="Severed Night Elf Head", module="pvp", category="Player vs. Player/Ashran", name="Bounty Hunter", description="Loot all the following off Alliance player corpses:", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type=42}}
A{"Ashran", 9103, criterion=25199, side="horde", trivia={criteria="Dwarf Spine", module="pvp", category="Player vs. Player/Ashran", name="Bounty Hunter", description="Loot all the following off Alliance player corpses:", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type=42}}
A{"Ashran", 9103, criterion=25198, side="horde", trivia={criteria="Tuft of Gnome Hair", module="pvp", category="Player vs. Player/Ashran", name="Bounty Hunter", description="Loot all the following off Alliance player corpses:", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type=42}}
A{"Ashran", 9103, criterion=25197, side="horde", trivia={criteria="Human Bone Chip", module="pvp", category="Player vs. Player/Ashran", name="Bounty Hunter", description="Loot all the following off Alliance player corpses:", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type=42}}
A{"Ashran", 9103, criterion=25203, side="horde", trivia={criteria="Draenei Tail", module="pvp", category="Player vs. Player/Ashran", name="Bounty Hunter", description="Loot all the following off Alliance player corpses:", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type=42}}

-- Player vs. Player/Ashran: Bounty Hunter
A{"Ashran", 9104, criterion=25209, side="alliance", trivia={criteria="Blood Elf Ear", module="pvp", category="Player vs. Player/Ashran", name="Bounty Hunter", description="Loot all the following off Horde player corpses:", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type=42}}
A{"Ashran", 9104, criterion=25207, side="alliance", trivia={criteria="Tauren Hoof", module="pvp", category="Player vs. Player/Ashran", name="Bounty Hunter", description="Loot all the following off Horde player corpses:", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type=42}}
A{"Ashran", 9104, criterion=25206, side="alliance", trivia={criteria="Orc Tooth", module="pvp", category="Player vs. Player/Ashran", name="Bounty Hunter", description="Loot all the following off Horde player corpses:", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type=42}}
A{"Ashran", 9104, criterion=25205, side="alliance", trivia={criteria="Troll Feet", module="pvp", category="Player vs. Player/Ashran", name="Bounty Hunter", description="Loot all the following off Horde player corpses:", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type=42}}
A{"Ashran", 9104, criterion=25204, side="alliance", trivia={criteria="Forsaken Brains", module="pvp", category="Player vs. Player/Ashran", name="Bounty Hunter", description="Loot all the following off Horde player corpses:", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type=42}}
A{"Ashran", 9104, criterion=25208, side="alliance", trivia={criteria="Goblin Nose", module="pvp", category="Player vs. Player/Ashran", name="Bounty Hunter", description="Loot all the following off Horde player corpses:", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type=42}}
A{"Ashran", 9104, criterion=25202, side="alliance", trivia={criteria="Pandaren Hide", module="pvp", category="Player vs. Player/Ashran", name="Bounty Hunter", description="Loot all the following off Horde player corpses:", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type=42}}

-- Player vs. Player/Ashran: Tour of Duty
A{"Ashran", 9105, criterion=25789, trivia={criteria="Molten Quarry", module="pvp", category="Player vs. Player/Ashran", name="Tour of Duty", description="Complete each PvP Event at the following areas listed below.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type=28}}
A{"Ashran", 9105, criterion=25215, trivia={criteria="Brute's Rise", module="pvp", category="Player vs. Player/Ashran", name="Tour of Duty", description="Complete each PvP Event at the following areas listed below.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type=28}}
A{"Ashran", 9105, criterion=25790, trivia={criteria="Ashmaul Burial Grounds", module="pvp", category="Player vs. Player/Ashran", name="Tour of Duty", description="Complete each PvP Event at the following areas listed below.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type=28}}
A{"Ashran", 9105, criterion=25791, trivia={criteria="Amphitheater of Annihilation", module="pvp", category="Player vs. Player/Ashran", name="Tour of Duty", description="Complete each PvP Event at the following areas listed below.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type=28}}

-- Player vs. Player/Ashran: Just for Me
A{"Ashran", 9106, trivia={module="pvp", category="Player vs. Player/Ashran", name="Just for Me", description="Activate a Class Specific Book Epic Item found within Ashran.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Ashran: Hero of Stormshield
A{"Ashran", 9214, criterion=25341, faction=1682, side="alliance", trivia={criteria="Gain Exalted reputation with Wrynn's Vanguard.", module="pvp", category="Player vs. Player/Ashran", name="Hero of Stormshield", description="Gain exalted reputation with Wrynn's Vanguard.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type=46}}

-- Player vs. Player/Ashran: Hero of Warspear
A{"Ashran", 9215, criterion=25342, faction=1681, side="horde", trivia={criteria="Gain Exalted reputation with Vol'jin's Spear", module="pvp", category="Player vs. Player/Ashran", name="Hero of Warspear", description="Gain exalted reputation with Vol'jin's Spear.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type=46}}

-- Player vs. Player/Ashran: High-value Targets
A{"Ashran", 9216, criterion=25843, trivia={criteria="Elder Darkweaver Kath", module="pvp", category="Player vs. Player/Ashran", name="High-value Targets", description="Defeat all of the creatures within Ashran listed below.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9216, criterion=25844, trivia={criteria="Goregore", module="pvp", category="Player vs. Player/Ashran", name="High-value Targets", description="Defeat all of the creatures within Ashran listed below.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9216, criterion=25845, trivia={criteria="Ancient Inferno", module="pvp", category="Player vs. Player/Ashran", name="High-value Targets", description="Defeat all of the creatures within Ashran listed below.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9216, criterion=25846, trivia={criteria="Panthora", module="pvp", category="Player vs. Player/Ashran", name="High-value Targets", description="Defeat all of the creatures within Ashran listed below.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9216, criterion=25847, trivia={criteria="Mandragoraster", module="pvp", category="Player vs. Player/Ashran", name="High-value Targets", description="Defeat all of the creatures within Ashran listed below.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9216, criterion=25848, trivia={criteria="Titarus", module="pvp", category="Player vs. Player/Ashran", name="High-value Targets", description="Defeat all of the creatures within Ashran listed below.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9216, criterion=25849, trivia={criteria="Brickhouse", module="pvp", category="Player vs. Player/Ashran", name="High-value Targets", description="Defeat all of the creatures within Ashran listed below.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9216, criterion=25850, trivia={criteria="Korthall Soulgorger", module="pvp", category="Player vs. Player/Ashran", name="High-value Targets", description="Defeat all of the creatures within Ashran listed below.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9216, criterion=25851, trivia={criteria="Oraggro", module="pvp", category="Player vs. Player/Ashran", name="High-value Targets", description="Defeat all of the creatures within Ashran listed below.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}

-- Player vs. Player/Ashran: Operation Counterattack
A{"Ashran", 9217, side="horde", trivia={module="pvp", category="Player vs. Player/Ashran", name="Operation Counterattack", description="Defeat Fangraal within 8 minutes of it being summoned by the Alliance.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Ashran: Grand Theft, 1st Degree
A{"Ashran", 9218, trivia={module="pvp", category="Player vs. Player/Ashran", name="Grand Theft, 1st Degree", description="Loot 100 Artifact Fragments from enemy players.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Ashran: Grand Theft, 2nd Degree
A{"Ashran", 9219, trivia={module="pvp", category="Player vs. Player/Ashran", name="Grand Theft, 2nd Degree", description="Loot 500 Artifact Fragments from enemy players.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Ashran: Grand Theft, 3rd Degree
A{"Ashran", 9220, trivia={module="pvp", category="Player vs. Player/Ashran", name="Grand Theft, 3rd Degree", description="Loot 1000 Artifact Fragments from enemy players.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Ashran: Divide and Conquer
A{"Ashran", 9222, criterion=25792, trivia={criteria="5000 Honorable Kills In 'Ashran' Not In' Road of Glory'", module="pvp", category="Player vs. Player/Ashran", name="Divide and Conquer", description="Kill 5000 enemy players anywhere outside the Road of Glory within Ashran.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="battle"}}

-- Player vs. Player/Ashran: Take Them Out
A{"Ashran", 9224, criterion=26289, side="horde", trivia={criteria="Defeat Alune Windmane", module="pvp", category="Player vs. Player/Ashran", name="Take Them Out", description="Defeat all of the Alliance Captains listed below within The Road of Glory.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9224, criterion=26290, side="horde", trivia={criteria="Defeat Anne Otther", module="pvp", category="Player vs. Player/Ashran", name="Take Them Out", description="Defeat all of the Alliance Captains listed below within The Road of Glory.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9224, criterion=26291, side="horde", trivia={criteria="Defeat Avenger Turley", module="pvp", category="Player vs. Player/Ashran", name="Take Them Out", description="Defeat all of the Alliance Captains listed below within The Road of Glory.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9224, criterion=26293, side="horde", trivia={criteria="Defeat Chani Malflame", module="pvp", category="Player vs. Player/Ashran", name="Take Them Out", description="Defeat all of the Alliance Captains listed below within The Road of Glory.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9224, criterion=26294, side="horde", trivia={criteria="Defeat Hildie Hackerguard", module="pvp", category="Player vs. Player/Ashran", name="Take Them Out", description="Defeat all of the Alliance Captains listed below within The Road of Glory.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9224, criterion=26295, side="horde", trivia={criteria="Defeat Jackson Bajheera", module="pvp", category="Player vs. Player/Ashran", name="Take Them Out", description="Defeat all of the Alliance Captains listed below within The Road of Glory.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9224, criterion=26296, side="horde", trivia={criteria="Defeat John Swifty", module="pvp", category="Player vs. Player/Ashran", name="Take Them Out", description="Defeat all of the Alliance Captains listed below within The Road of Glory.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9224, criterion=26297, side="horde", trivia={criteria="Defeat Malda Brewbelly", module="pvp", category="Player vs. Player/Ashran", name="Take Them Out", description="Defeat all of the Alliance Captains listed below within The Road of Glory.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9224, criterion=26298, side="horde", trivia={criteria="Defeat Mathias Zunn", module="pvp", category="Player vs. Player/Ashran", name="Take Them Out", description="Defeat all of the Alliance Captains listed below within The Road of Glory.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9224, criterion=26299, side="horde", trivia={criteria="Defeat Shani Freezewind", module="pvp", category="Player vs. Player/Ashran", name="Take Them Out", description="Defeat all of the Alliance Captains listed below within The Road of Glory.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9224, criterion=26300, side="horde", trivia={criteria="Defeat Taylor Dewland", module="pvp", category="Player vs. Player/Ashran", name="Take Them Out", description="Defeat all of the Alliance Captains listed below within The Road of Glory.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9224, criterion=26301, side="horde", trivia={criteria="Defeat Tosan Galaxyfist", module="pvp", category="Player vs. Player/Ashran", name="Take Them Out", description="Defeat all of the Alliance Captains listed below within The Road of Glory.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}

-- Player vs. Player/Ashran: Take Them Out
A{"Ashran", 9225, criterion=26303, side="alliance", trivia={criteria="Defeat Captain Hoodrych", module="pvp", category="Player vs. Player/Ashran", name="Take Them Out", description="Defeat all of the Horde Captains listed below within The Road of Glory.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9225, criterion=26304, side="alliance", trivia={criteria="Defeat Elementalist Novo", module="pvp", category="Player vs. Player/Ashran", name="Take Them Out", description="Defeat all of the Horde Captains listed below within The Road of Glory.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9225, criterion=25350, side="alliance", trivia={criteria="Defeat Elliot Van Rook", module="pvp", category="Player vs. Player/Ashran", name="Take Them Out", description="Defeat all of the Horde Captains listed below within The Road of Glory.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9225, criterion=26305, side="alliance", trivia={criteria="Defeat Jared V. Hellstrike", module="pvp", category="Player vs. Player/Ashran", name="Take Them Out", description="Defeat all of the Horde Captains listed below within The Road of Glory.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9225, criterion=26306, side="alliance", trivia={criteria="Defeat Kaz Endsky", module="pvp", category="Player vs. Player/Ashran", name="Take Them Out", description="Defeat all of the Horde Captains listed below within The Road of Glory.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9225, criterion=26307, side="alliance", trivia={criteria="Defeat Lord Mes", module="pvp", category="Player vs. Player/Ashran", name="Take Them Out", description="Defeat all of the Horde Captains listed below within The Road of Glory.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9225, criterion=26308, side="alliance", trivia={criteria="Defeat Mindbender Talbadar", module="pvp", category="Player vs. Player/Ashran", name="Take Them Out", description="Defeat all of the Horde Captains listed below within The Road of Glory.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9225, criterion=26309, side="alliance", trivia={criteria="Defeat Mor'riz, The Ultimate Troll", module="pvp", category="Player vs. Player/Ashran", name="Take Them Out", description="Defeat all of the Horde Captains listed below within The Road of Glory.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9225, criterion=26310, side="alliance", trivia={criteria="Defeat Necrolord Azael", module="pvp", category="Player vs. Player/Ashran", name="Take Them Out", description="Defeat all of the Horde Captains listed below within The Road of Glory.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9225, criterion=26311, side="alliance", trivia={criteria="Defeat Nadagast", module="pvp", category="Player vs. Player/Ashran", name="Take Them Out", description="Defeat all of the Horde Captains listed below within The Road of Glory.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9225, criterion=26312, side="alliance", trivia={criteria="Defeat Razor Guerra", module="pvp", category="Player vs. Player/Ashran", name="Take Them Out", description="Defeat all of the Horde Captains listed below within The Road of Glory.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9225, criterion=26313, side="alliance", trivia={criteria="Defeat Rifthunter Yoske", module="pvp", category="Player vs. Player/Ashran", name="Take Them Out", description="Defeat all of the Horde Captains listed below within The Road of Glory.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}
A{"Ashran", 9225, criterion=26314, side="alliance", trivia={criteria="Defeat Vanguard Samuelle", module="pvp", category="Player vs. Player/Ashran", name="Take Them Out", description="Defeat all of the Horde Captains listed below within The Road of Glory.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type="slay"}}

-- Player vs. Player/Ashran: Down Goes Van Rook
A{"Ashran", 9228, side="alliance", trivia={module="pvp", category="Player vs. Player/Ashran", name="Down Goes Van Rook", description="Kill Elliott Van Rook before he remembers how to use Ice Block.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Ashran: Rescue Operation
A{"Ashran", 9256, criterion=25410, side="alliance", trivia={criteria="Commander Jobby Shortsight", module="pvp", category="Player vs. Player/Ashran", name="Rescue Operation", description="Release the following captured prisoners from the Horde Prison:", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type=28}}
A{"Ashran", 9256, criterion=25417, side="alliance", trivia={criteria="Marshal Andrea DeSousa", module="pvp", category="Player vs. Player/Ashran", name="Rescue Operation", description="Release the following captured prisoners from the Horde Prison:", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type=28}}
A{"Ashran", 9256, criterion=25416, side="alliance", trivia={criteria="Field Marshal Kerwin", module="pvp", category="Player vs. Player/Ashran", name="Rescue Operation", description="Release the following captured prisoners from the Horde Prison:", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type=28}}

-- Player vs. Player/Ashran: Rescue Operation
A{"Ashran", 9257, criterion=25447, side="horde", trivia={criteria="Warlord Jugan", module="pvp", category="Player vs. Player/Ashran", name="Rescue Operation", description="Release the following captured prisoners from the Alliance Prison:", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type=28}}
A{"Ashran", 9257, criterion=25448, side="horde", trivia={criteria="General Lizzie Heartbane", module="pvp", category="Player vs. Player/Ashran", name="Rescue Operation", description="Release the following captured prisoners from the Alliance Prison:", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type=28}}
A{"Ashran", 9257, criterion=25449, side="horde", trivia={criteria="Marshal Lyrdrea Daybreaker", module="pvp", category="Player vs. Player/Ashran", name="Rescue Operation", description="Release the following captured prisoners from the Alliance Prison:", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player", type=28}}

-- Player vs. Player/Ashran: Operation Counterattack
A{"Ashran", 9408, side="alliance", trivia={module="pvp", category="Player vs. Player/Ashran", name="Operation Counterattack", description="Defeat Kronus within 8 minutes of it being summoned by the Horde.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Ashran: Thy Kingdom Come
A{"Ashran", 9714, side="alliance", trivia={module="pvp", category="Player vs. Player/Ashran", name="Thy Kingdom Come", description="Win Kor'lok's favor for your faction by defeating his bodyguard, Muk'Mar Raz.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Ashran: Thy Kingdom Come
A{"Ashran", 9715, side="horde", trivia={module="pvp", category="Player vs. Player/Ashran", name="Thy Kingdom Come", description="Win Kor'lok's favor for your faction by defeating his bodyguard, Gaul Dun Firok.", mapID="Ashran", uiMapID=588, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Arena: World Wide Winner
A{"BladesEdgeMountains", 699, 0.5300, 0.4400, criterion=5739, trivia={criteria="Blade's Edge Arena", module="pvp", category="Player vs. Player/Arena", name="World Wide Winner", description="Win a ranked arena match in Blade's Edge, Nagrand, Dalaran Sewers, the Ruins of Lordaeron, Tol'Viron Arena and the Tiger's Peak.", mapID="BladesEdgeMountains", uiMapID=105, points=10, parent="Player vs. Player", type=32}}
A{"Dalaran", 699, criterion=8587, floor=2, trivia={criteria="Dalaran Sewers", module="pvp", category="Player vs. Player/Arena", name="World Wide Winner", description="Win a ranked arena match in Blade's Edge, Nagrand, Dalaran Sewers, the Ruins of Lordaeron, Tol'Viron Arena and the Tiger's Peak.", mapID="Dalaran_TheUnderbelly", uiMapID=126, points=10, parent="Player vs. Player", type=32}}

-- Player vs. Player: Wrath of the Horde
A{"Darnassus", 603, criterion=6638, side="horde", trivia={criteria="Darnassus", module="pvp", category="Player vs. Player", name="Wrath of the Horde", description="Kill 5 Alliance players in each of the cities listed below.", mapID="Darnassus", uiMapID=89, points=10, type="battle"}}

-- Player vs. Player: Immortal No More
A{"Darnassus", 617, 0.4300, 0.7900, side="horde", trivia={module="pvp", category="Player vs. Player", name="Immortal No More", description="Kill High Priestess Tyrande Whisperwind.", mapID="Darnassus", uiMapID=89, points=10}}

-- Player vs. Player: For The Horde!
A{"Darnassus", 619, 0.4300, 0.7900, criterion=494, side="horde", trivia={criteria="Immortal No More", module="pvp", category="Player vs. Player", name="For The Horde!", description="Slay the leaders of the Alliance.", mapID="Darnassus", uiMapID=89, points=20, type="achievement"}}

-- Player vs. Player: Grizzled Veteran
A{"GrizzlyHills", 2016, 0.3970, 0.4340, criterion=7279, side="alliance", trivia={criteria="Pieces Parts", module="pvp", category="Player vs. Player", name="Grizzled Veteran", description="Complete the Grizzly Hills PvP daily quests listed below.", mapID="GrizzlyHills", uiMapID=116, points=10, type="quest"}}
A{"GrizzlyHills", 2016, 0.4050, 0.4270, criterion=7280, side="alliance", trivia={criteria="Life or Death", module="pvp", category="Player vs. Player", name="Grizzled Veteran", description="Complete the Grizzly Hills PvP daily quests listed below.", mapID="GrizzlyHills", uiMapID=116, points=10, type="quest"}}
A{"GrizzlyHills", 2016, 0.3950, 0.4360, criterion=7281, side="alliance", trivia={criteria="Shredder Repair", module="pvp", category="Player vs. Player", name="Grizzled Veteran", description="Complete the Grizzly Hills PvP daily quests listed below.", mapID="GrizzlyHills", uiMapID=116, points=10, type="quest"}}
A{"GrizzlyHills", 2016, 0.2210, 0.8130, criterion=7283, side="alliance", trivia={criteria="Keep Them at Bay!", module="pvp", category="Player vs. Player", name="Grizzled Veteran", description="Complete the Grizzly Hills PvP daily quests listed below.", mapID="GrizzlyHills", uiMapID=116, points=10, type="quest"}}
A{"GrizzlyHills", 2016, 0.2210, 0.8130, criterion=7284, side="alliance", trivia={criteria="Down With Captain Zorna!", module="pvp", category="Player vs. Player", name="Grizzled Veteran", description="Complete the Grizzly Hills PvP daily quests listed below.", mapID="GrizzlyHills", uiMapID=116, points=10, type="quest"}}
A{"GrizzlyHills", 2016, 0.2990, 0.5980, criterion=7278, side="alliance", trivia={criteria="Blackriver Skirmish", module="pvp", category="Player vs. Player", name="Grizzled Veteran", description="Complete the Grizzly Hills PvP daily quests listed below.", mapID="GrizzlyHills", uiMapID=116, points=10, type="quest"}}
A{"GrizzlyHills", 2016, 0.2200, 0.8070, criterion=7285, side="alliance", trivia={criteria="Smoke 'Em Out", module="pvp", category="Player vs. Player", name="Grizzled Veteran", description="Complete the Grizzly Hills PvP daily quests listed below.", mapID="GrizzlyHills", uiMapID=116, points=10, type="quest"}}
A{"GrizzlyHills", 2016, 0.1480, 0.8660, criterion=7286, side="alliance", trivia={criteria="Riding the Red Rocket", module="pvp", category="Player vs. Player", name="Grizzled Veteran", description="Complete the Grizzly Hills PvP daily quests listed below.", mapID="GrizzlyHills", uiMapID=116, points=10, type="quest"}}
A{"GrizzlyHills", 2016, 0.3940, 0.4390, criterion=7282, side="alliance", trivia={criteria="Kick 'Em While They're Down", module="pvp", category="Player vs. Player", name="Grizzled Veteran", description="Complete the Grizzly Hills PvP daily quests listed below.", mapID="GrizzlyHills", uiMapID=116, points=10, type="quest"}}

-- Player vs. Player: Grizzled Veteran
A{"GrizzlyHills", 2017, criterion=7294, side="horde", trivia={criteria="Keep Them at Bay", module="pvp", category="Player vs. Player", name="Grizzled Veteran", description="Complete the Grizzly Hills PvP daily quests listed below.", mapID="GrizzlyHills", uiMapID=116, points=10, type="quest"}}
A{"GrizzlyHills", 2017, criterion=7288, side="horde", trivia={criteria="Shred the Alliance", module="pvp", category="Player vs. Player", name="Grizzled Veteran", description="Complete the Grizzly Hills PvP daily quests listed below.", mapID="GrizzlyHills", uiMapID=116, points=10, type="quest"}}
A{"GrizzlyHills", 2017, criterion=7295, side="horde", trivia={criteria="Smoke 'Em Out", module="pvp", category="Player vs. Player", name="Grizzled Veteran", description="Complete the Grizzly Hills PvP daily quests listed below.", mapID="GrizzlyHills", uiMapID=116, points=10, type="quest"}}
A{"GrizzlyHills", 2017, 0.2640, 0.6580, criterion=7287, side="horde", trivia={criteria="Blackriver Brawl", module="pvp", category="Player vs. Player", name="Grizzled Veteran", description="Complete the Grizzly Hills PvP daily quests listed below.", mapID="GrizzlyHills", uiMapID=116, points=10, type="quest"}}
A{"GrizzlyHills", 2017, criterion=7289, side="horde", trivia={criteria="Making Repairs", module="pvp", category="Player vs. Player", name="Grizzled Veteran", description="Complete the Grizzly Hills PvP daily quests listed below.", mapID="GrizzlyHills", uiMapID=116, points=10, type="quest"}}
A{"GrizzlyHills", 2017, criterion=7292, side="horde", trivia={criteria="Riding the Red Rocket", module="pvp", category="Player vs. Player", name="Grizzled Veteran", description="Complete the Grizzly Hills PvP daily quests listed below.", mapID="GrizzlyHills", uiMapID=116, points=10, type="quest"}}
A{"GrizzlyHills", 2017, criterion=7290, side="horde", trivia={criteria="Keep 'Em on their Heels", module="pvp", category="Player vs. Player", name="Grizzled Veteran", description="Complete the Grizzly Hills PvP daily quests listed below.", mapID="GrizzlyHills", uiMapID=116, points=10, type="quest"}}
A{"GrizzlyHills", 2017, criterion=7291, side="horde", trivia={criteria="Overwhelmed!", module="pvp", category="Player vs. Player", name="Grizzled Veteran", description="Complete the Grizzly Hills PvP daily quests listed below.", mapID="GrizzlyHills", uiMapID=116, points=10, type="quest"}}
A{"GrizzlyHills", 2017, criterion=7293, side="horde", trivia={criteria="Crush Captain Brightwater!", module="pvp", category="Player vs. Player", name="Grizzled Veteran", description="Complete the Grizzly Hills PvP daily quests listed below.", mapID="GrizzlyHills", uiMapID=116, points=10, type="quest"}}

-- Player vs. Player: Wrath of the Horde
A{"Ironforge", 603, criterion=6637, side="horde", trivia={criteria="Ironforge", module="pvp", category="Player vs. Player", name="Wrath of the Horde", description="Kill 5 Alliance players in each of the cities listed below.", mapID="Ironforge", uiMapID=87, points=10, type="battle"}}

-- Player vs. Player: Overthrow the Council
A{"Ironforge", 616, 0.4000, 0.5500, side="horde", trivia={module="pvp", category="Player vs. Player", name="Overthrow the Council", description="Kill Representatives Moira Thaurissan, Muradin Bronzebeard and Falstad Wildhammer.", mapID="Ironforge", uiMapID=87, points=10}}

-- Player vs. Player: For The Horde!
A{"Ironforge", 619, 0.4000, 0.5500, criterion=493, side="horde", trivia={criteria="Overthrow the Council", module="pvp", category="Player vs. Player", name="For The Horde!", description="Slay the leaders of the Alliance.", mapID="Ironforge", uiMapID=87, points=20, type="achievement"}}

-- Player vs. Player/Isle of Conquest: Isle of Conquest Victory
A{"IsleofConquest", 3776, trivia={module="pvp", category="Player vs. Player/Isle of Conquest", name="Isle of Conquest Victory", description="Win Isle of Conquest.", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Isle of Conquest: Isle of Conquest Veteran
A{"IsleofConquest", 3777, criterion=17904, trivia={criteria="Complete 100 victories in Isle of Conquest", module="pvp", category="Player vs. Player/Isle of Conquest", name="Isle of Conquest Veteran", description="Complete 100 victories in Isle of Conquest.", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player", type=1}}

-- Player vs. Player/Isle of Conquest: Isle of Conquest All-Star
A{"IsleofConquest", 3845, criterion=11488, trivia={criteria="Defend a base", module="pvp", category="Player vs. Player/Isle of Conquest", name="Isle of Conquest All-Star", description="In a single Isle of Conquest battle, assault a base, defend a base, destroy a vehicle and kill a player.", mapID="IsleOfConquest", uiMapID=169, points=20, parent="Player vs. Player", type=30}}
A{"IsleofConquest", 3845, criterion=11487, trivia={criteria="Assault a base", module="pvp", category="Player vs. Player/Isle of Conquest", name="Isle of Conquest All-Star", description="In a single Isle of Conquest battle, assault a base, defend a base, destroy a vehicle and kill a player.", mapID="IsleOfConquest", uiMapID=169, points=20, parent="Player vs. Player", type=30}}
A{"IsleofConquest", 3845, criterion=11491, trivia={criteria="Kill a player", module="pvp", category="Player vs. Player/Isle of Conquest", name="Isle of Conquest All-Star", description="In a single Isle of Conquest battle, assault a base, defend a base, destroy a vehicle and kill a player.", mapID="IsleOfConquest", uiMapID=169, points=20, parent="Player vs. Player", type=70}}
A{"IsleofConquest", 3845, criterion=12059, trivia={criteria="Destroy a vehicle", module="pvp", category="Player vs. Player/Isle of Conquest", name="Isle of Conquest All-Star", description="In a single Isle of Conquest battle, assault a base, defend a base, destroy a vehicle and kill a player.", mapID="IsleOfConquest", uiMapID=169, points=20, parent="Player vs. Player", type=28}}

-- Player vs. Player/Isle of Conquest: Resource Glut
A{"IsleofConquest", 3846, side="alliance", trivia={module="pvp", category="Player vs. Player/Isle of Conquest", name="Resource Glut", description="Win Isle of Conquest while your team controls the Quarry and Oil Refinery.", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Isle of Conquest: Four Car Garage
A{"IsleofConquest", 3847, criterion=11492, trivia={criteria="Glaive Thrower", module="pvp", category="Player vs. Player/Isle of Conquest", name="Four Car Garage", description="In Isle of Conquest, control the following vehicles:", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player", type=28}}
A{"IsleofConquest", 3847, criterion=11493, trivia={criteria="Siege Engine", module="pvp", category="Player vs. Player/Isle of Conquest", name="Four Car Garage", description="In Isle of Conquest, control the following vehicles:", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player", type=28}}
A{"IsleofConquest", 3847, criterion=11494, trivia={criteria="Demolisher", module="pvp", category="Player vs. Player/Isle of Conquest", name="Four Car Garage", description="In Isle of Conquest, control the following vehicles:", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player", type=28}}
A{"IsleofConquest", 3847, criterion=11495, trivia={criteria="Catapult", module="pvp", category="Player vs. Player/Isle of Conquest", name="Four Car Garage", description="In Isle of Conquest, control the following vehicles:", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player", type=28}}

-- Player vs. Player/Isle of Conquest: A-bomb-inable
A{"IsleofConquest", 3848, criterion=12066, trivia={criteria="Bombs used on enemy gates", module="pvp", category="Player vs. Player/Isle of Conquest", name="A-bomb-inable", description="In a single Isle of Conquest battle, use 5 Seaforium Bombs on the enemy gates.", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player", type=29}}

-- Player vs. Player/Isle of Conquest: A-bomb-ination
A{"IsleofConquest", 3849, criterion=12067, trivia={criteria="Bombs used on enemy gates", module="pvp", category="Player vs. Player/Isle of Conquest", name="A-bomb-ination", description="In a single Isle of Conquest battle, use 5 Huge Seaforium Bombs on the enemy gates.", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player", type=29}}

-- Player vs. Player/Isle of Conquest: Mowed Down
A{"IsleofConquest", 3850, criterion=12114, trivia={criteria="Vehicles killed", module="pvp", category="Player vs. Player/Isle of Conquest", name="Mowed Down", description="In Isle of Conquest, destroy 10 vehicles and 100 players with turrets.", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player", type=28}}
A{"IsleofConquest", 3850, criterion=12068, trivia={criteria="Players killed", module="pvp", category="Player vs. Player/Isle of Conquest", name="Mowed Down", description="In Isle of Conquest, destroy 10 vehicles and 100 players with turrets.", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player", type=35}}

-- Player vs. Player/Isle of Conquest: Mine
A{"IsleofConquest", 3851, side="alliance", trivia={module="pvp", category="Player vs. Player/Isle of Conquest", name="Mine", description="Win Isle of Conquest while controlling the Quarry, Oil Refinery, Shipyard, Siege Workshop and Hangar.", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Isle of Conquest: Cut the Blue Wire... No the Red Wire!
A{"IsleofConquest", 3852, criterion=16774, trivia={criteria="Bombs disarmed", module="pvp", category="Player vs. Player/Isle of Conquest", name="Cut the Blue Wire... No the Red Wire!", description="In Isle of Conquest, disarm 25 bombs.", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player", type=29}}

-- Player vs. Player/Isle of Conquest: All Over the Isle
A{"IsleofConquest", 3853, criterion=12158, trivia={criteria="Workshop", module="pvp", category="Player vs. Player/Isle of Conquest", name="All Over the Isle", description="In a single Isle of Conquest battle, kill a player at each of the following locations:", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player", type=31}}
A{"IsleofConquest", 3853, criterion=12159, trivia={criteria="Hangar", module="pvp", category="Player vs. Player/Isle of Conquest", name="All Over the Isle", description="In a single Isle of Conquest battle, kill a player at each of the following locations:", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player", type=31}}
A{"IsleofConquest", 3853, criterion=12160, trivia={criteria="Docks", module="pvp", category="Player vs. Player/Isle of Conquest", name="All Over the Isle", description="In a single Isle of Conquest battle, kill a player at each of the following locations:", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player", type=31}}
A{"IsleofConquest", 3853, criterion=12161, trivia={criteria="Horde Keep", module="pvp", category="Player vs. Player/Isle of Conquest", name="All Over the Isle", description="In a single Isle of Conquest battle, kill a player at each of the following locations:", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player", type=31}}
A{"IsleofConquest", 3853, criterion=12162, trivia={criteria="Alliance Keep", module="pvp", category="Player vs. Player/Isle of Conquest", name="All Over the Isle", description="In a single Isle of Conquest battle, kill a player at each of the following locations:", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player", type=31}}

-- Player vs. Player/Isle of Conquest: Back Door Job
A{"IsleofConquest", 3854, trivia={module="pvp", category="Player vs. Player/Isle of Conquest", name="Back Door Job", description="In Isle of Conquest, enter the enemy courtyard while their gates still stand.", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Isle of Conquest: Glaive Grave
A{"IsleofConquest", 3855, criterion=12183, trivia={criteria="Players killed", module="pvp", category="Player vs. Player/Isle of Conquest", name="Glaive Grave", description="In Isle of Conquest, kill 10 players with a Glaive Thrower without dying.", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player", type=35}}

-- Player vs. Player/Isle of Conquest: Demolition Derby
A{"IsleofConquest", 3856, criterion=11501, side="alliance", trivia={criteria="Siege Engine", module="pvp", category="Player vs. Player/Isle of Conquest", name="Demolition Derby", description="Destroy the following vehicles in Isle of Conquest", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player", type=56}}
A{"IsleofConquest", 3856, criterion=12179, side="alliance", trivia={criteria="Demolisher", module="pvp", category="Player vs. Player/Isle of Conquest", name="Demolition Derby", description="Destroy the following vehicles in Isle of Conquest", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player", type=56}}
A{"IsleofConquest", 3856, criterion=12181, side="alliance", trivia={criteria="Catapult", module="pvp", category="Player vs. Player/Isle of Conquest", name="Demolition Derby", description="Destroy the following vehicles in Isle of Conquest", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player", type=56}}
A{"IsleofConquest", 3856, criterion=11497, side="alliance", trivia={criteria="Glaive Thrower", module="pvp", category="Player vs. Player/Isle of Conquest", name="Demolition Derby", description="Destroy the following vehicles in Isle of Conquest", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player", type=56}}

-- Player vs. Player/Isle of Conquest: Master of Isle of Conquest
A{"IsleofConquest", 3857, criterion=11756, side="alliance", trivia={criteria="All Over the Isle", module="pvp", category="Player vs. Player/Isle of Conquest", name="Master of Isle of Conquest", description="Complete the Isle of Conquest achievements listed below.", mapID="IsleOfConquest", uiMapID=169, points=25, parent="Player vs. Player", type="achievement"}}
A{"IsleofConquest", 3857, criterion=11749, side="alliance", trivia={criteria="Isle of Conquest Veteran", module="pvp", category="Player vs. Player/Isle of Conquest", name="Master of Isle of Conquest", description="Complete the Isle of Conquest achievements listed below.", mapID="IsleOfConquest", uiMapID=169, points=25, parent="Player vs. Player", type="achievement"}}
A{"IsleofConquest", 3857, criterion=11751, side="alliance", trivia={criteria="Four Car Garage", module="pvp", category="Player vs. Player/Isle of Conquest", name="Master of Isle of Conquest", description="Complete the Isle of Conquest achievements listed below.", mapID="IsleOfConquest", uiMapID=169, points=25, parent="Player vs. Player", type="achievement"}}
A{"IsleofConquest", 3857, criterion=11752, side="alliance", trivia={criteria="A-bomb-inable", module="pvp", category="Player vs. Player/Isle of Conquest", name="Master of Isle of Conquest", description="Complete the Isle of Conquest achievements listed below.", mapID="IsleOfConquest", uiMapID=169, points=25, parent="Player vs. Player", type="achievement"}}
A{"IsleofConquest", 3857, criterion=11753, side="alliance", trivia={criteria="A-bomb-ination", module="pvp", category="Player vs. Player/Isle of Conquest", name="Master of Isle of Conquest", description="Complete the Isle of Conquest achievements listed below.", mapID="IsleOfConquest", uiMapID=169, points=25, parent="Player vs. Player", type="achievement"}}
A{"IsleofConquest", 3857, criterion=11754, side="alliance", trivia={criteria="Mowed Down", module="pvp", category="Player vs. Player/Isle of Conquest", name="Master of Isle of Conquest", description="Complete the Isle of Conquest achievements listed below.", mapID="IsleOfConquest", uiMapID=169, points=25, parent="Player vs. Player", type="achievement"}}
A{"IsleofConquest", 3857, criterion=11757, side="alliance", trivia={criteria="Back Door Job", module="pvp", category="Player vs. Player/Isle of Conquest", name="Master of Isle of Conquest", description="Complete the Isle of Conquest achievements listed below.", mapID="IsleOfConquest", uiMapID=169, points=25, parent="Player vs. Player", type="achievement"}}
A{"IsleofConquest", 3857, criterion=11759, side="alliance", trivia={criteria="Glaive Grave", module="pvp", category="Player vs. Player/Isle of Conquest", name="Master of Isle of Conquest", description="Complete the Isle of Conquest achievements listed below.", mapID="IsleOfConquest", uiMapID=169, points=25, parent="Player vs. Player", type="achievement"}}
A{"IsleofConquest", 3857, criterion=11755, side="alliance", trivia={criteria="Cut the Blue Wire... No the Red Wire!", module="pvp", category="Player vs. Player/Isle of Conquest", name="Master of Isle of Conquest", description="Complete the Isle of Conquest achievements listed below.", mapID="IsleOfConquest", uiMapID=169, points=25, parent="Player vs. Player", type="achievement"}}
A{"IsleofConquest", 3857, criterion=11503, side="alliance", trivia={criteria="Mine", module="pvp", category="Player vs. Player/Isle of Conquest", name="Master of Isle of Conquest", description="Complete the Isle of Conquest achievements listed below.", mapID="IsleOfConquest", uiMapID=169, points=25, parent="Player vs. Player", type="achievement"}}
A{"IsleofConquest", 3857, criterion=11511, side="alliance", trivia={criteria="Demolition Derby", module="pvp", category="Player vs. Player/Isle of Conquest", name="Master of Isle of Conquest", description="Complete the Isle of Conquest achievements listed below.", mapID="IsleOfConquest", uiMapID=169, points=25, parent="Player vs. Player", type="achievement"}}

-- Player vs. Player/Isle of Conquest: Master of Isle of Conquest
A{"IsleofConquest", 3957, criterion=11749, side="horde", trivia={criteria="Isle of Conquest Veteran", module="pvp", category="Player vs. Player/Isle of Conquest", name="Master of Isle of Conquest", description="Complete the Isle of Conquest achievements listed below.", mapID="IsleOfConquest", uiMapID=169, points=25, parent="Player vs. Player", type="achievement"}}
A{"IsleofConquest", 3957, criterion=11750, side="horde", trivia={criteria="Mine", module="pvp", category="Player vs. Player/Isle of Conquest", name="Master of Isle of Conquest", description="Complete the Isle of Conquest achievements listed below.", mapID="IsleOfConquest", uiMapID=169, points=25, parent="Player vs. Player", type="achievement"}}
A{"IsleofConquest", 3957, criterion=11751, side="horde", trivia={criteria="Four Car Garage", module="pvp", category="Player vs. Player/Isle of Conquest", name="Master of Isle of Conquest", description="Complete the Isle of Conquest achievements listed below.", mapID="IsleOfConquest", uiMapID=169, points=25, parent="Player vs. Player", type="achievement"}}
A{"IsleofConquest", 3957, criterion=11752, side="horde", trivia={criteria="A-bomb-inable", module="pvp", category="Player vs. Player/Isle of Conquest", name="Master of Isle of Conquest", description="Complete the Isle of Conquest achievements listed below.", mapID="IsleOfConquest", uiMapID=169, points=25, parent="Player vs. Player", type="achievement"}}
A{"IsleofConquest", 3957, criterion=11753, side="horde", trivia={criteria="A-bomb-ination", module="pvp", category="Player vs. Player/Isle of Conquest", name="Master of Isle of Conquest", description="Complete the Isle of Conquest achievements listed below.", mapID="IsleOfConquest", uiMapID=169, points=25, parent="Player vs. Player", type="achievement"}}
A{"IsleofConquest", 3957, criterion=11754, side="horde", trivia={criteria="Mowed Down", module="pvp", category="Player vs. Player/Isle of Conquest", name="Master of Isle of Conquest", description="Complete the Isle of Conquest achievements listed below.", mapID="IsleOfConquest", uiMapID=169, points=25, parent="Player vs. Player", type="achievement"}}
A{"IsleofConquest", 3957, criterion=11755, side="horde", trivia={criteria="Cut the Blue Wire... No the Red Wire!", module="pvp", category="Player vs. Player/Isle of Conquest", name="Master of Isle of Conquest", description="Complete the Isle of Conquest achievements listed below.", mapID="IsleOfConquest", uiMapID=169, points=25, parent="Player vs. Player", type="achievement"}}
A{"IsleofConquest", 3957, criterion=11756, side="horde", trivia={criteria="All Over the Isle", module="pvp", category="Player vs. Player/Isle of Conquest", name="Master of Isle of Conquest", description="Complete the Isle of Conquest achievements listed below.", mapID="IsleOfConquest", uiMapID=169, points=25, parent="Player vs. Player", type="achievement"}}
A{"IsleofConquest", 3957, criterion=11757, side="horde", trivia={criteria="Back Door Job", module="pvp", category="Player vs. Player/Isle of Conquest", name="Master of Isle of Conquest", description="Complete the Isle of Conquest achievements listed below.", mapID="IsleOfConquest", uiMapID=169, points=25, parent="Player vs. Player", type="achievement"}}
A{"IsleofConquest", 3957, criterion=11758, side="horde", trivia={criteria="Demolition Derby", module="pvp", category="Player vs. Player/Isle of Conquest", name="Master of Isle of Conquest", description="Complete the Isle of Conquest achievements listed below.", mapID="IsleOfConquest", uiMapID=169, points=25, parent="Player vs. Player", type="achievement"}}
A{"IsleofConquest", 3957, criterion=11759, side="horde", trivia={criteria="Glaive Grave", module="pvp", category="Player vs. Player/Isle of Conquest", name="Master of Isle of Conquest", description="Complete the Isle of Conquest achievements listed below.", mapID="IsleOfConquest", uiMapID=169, points=25, parent="Player vs. Player", type="achievement"}}

-- Player vs. Player/Isle of Conquest: Resource Glut
A{"IsleofConquest", 4176, side="horde", trivia={module="pvp", category="Player vs. Player/Isle of Conquest", name="Resource Glut", description="Win Isle of Conquest while your team controls the Quarry and Oil Refinery.", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Isle of Conquest: Mine
A{"IsleofConquest", 4177, side="horde", trivia={module="pvp", category="Player vs. Player/Isle of Conquest", name="Mine", description="Win Isle of Conquest while controlling the Quarry, Oil Refinery, Shipyard, Siege Workshop and Hangar.", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Isle of Conquest: Demolition Derby
A{"IsleofConquest", 4256, criterion=12182, side="horde", trivia={criteria="Siege Engine", module="pvp", category="Player vs. Player/Isle of Conquest", name="Demolition Derby", description="Destroy the following vehicles in Isle of Conquest", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player", type=56}}
A{"IsleofConquest", 4256, criterion=12178, side="horde", trivia={criteria="Glaive Thrower", module="pvp", category="Player vs. Player/Isle of Conquest", name="Demolition Derby", description="Destroy the following vehicles in Isle of Conquest", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player", type=56}}
A{"IsleofConquest", 4256, criterion=12179, side="horde", trivia={criteria="Demolisher", module="pvp", category="Player vs. Player/Isle of Conquest", name="Demolition Derby", description="Destroy the following vehicles in Isle of Conquest", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player", type=56}}
A{"IsleofConquest", 4256, criterion=12181, side="horde", trivia={criteria="Catapult", module="pvp", category="Player vs. Player/Isle of Conquest", name="Demolition Derby", description="Destroy the following vehicles in Isle of Conquest", mapID="IsleOfConquest", uiMapID=169, points=10, parent="Player vs. Player", type=56}}

-- Player vs. Player/Arena: World Wide Winner
A{"KunLaiSummit", 699, criterion=23502, trivia={criteria="The Tiger's Peak", module="pvp", category="Player vs. Player/Arena", name="World Wide Winner", description="Win a ranked arena match in Blade's Edge, Nagrand, Dalaran Sewers, the Ruins of Lordaeron, Tol'Viron Arena and the Tiger's Peak.", mapID="KunLaiSummit", uiMapID=379, points=10, parent="Player vs. Player", type=32}}

-- Player vs. Player/Wintergrasp: Wintergrasp Victory
A{"LakeWintergrasp", 1717, trivia={module="pvp", category="Player vs. Player/Wintergrasp", name="Wintergrasp Victory", description="Win the battle for Wintergrasp.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Wintergrasp: Wintergrasp Veteran
A{"LakeWintergrasp", 1718, criterion=6436, trivia={criteria="Win Wintergrasp 100 times", module="pvp", category="Player vs. Player/Wintergrasp", name="Wintergrasp Veteran", description="Win 100 battles for Wintergrasp.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type=28}}

-- Player vs. Player/Wintergrasp: Vehicular Gnomeslaughter
A{"LakeWintergrasp", 1723, trivia={module="pvp", category="Player vs. Player/Wintergrasp", name="Vehicular Gnomeslaughter", description="Kill 100 players in Wintergrasp using a vehicle or a cannon.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Wintergrasp: Leaning Tower
A{"LakeWintergrasp", 1727, trivia={module="pvp", category="Player vs. Player/Wintergrasp", name="Leaning Tower", description="Destroy a tower in Wintergrasp.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Wintergrasp: Destruction Derby
A{"LakeWintergrasp", 1737, criterion=9178, side="alliance", trivia={criteria="Wintergrasp Catapult", module="pvp", category="Player vs. Player/Wintergrasp", name="Destruction Derby", description="Destroy each of the vehicles listed below.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type="slay"}}
A{"LakeWintergrasp", 1737, criterion=6444, side="alliance", trivia={criteria="Wintergrasp Siege Engine", module="pvp", category="Player vs. Player/Wintergrasp", name="Destruction Derby", description="Destroy each of the vehicles listed below.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type="slay"}}
A{"LakeWintergrasp", 1737, criterion=9181, side="alliance", trivia={criteria="Wintergrasp Tower Cannon", module="pvp", category="Player vs. Player/Wintergrasp", name="Destruction Derby", description="Destroy each of the vehicles listed below.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type="slay"}}
A{"LakeWintergrasp", 1737, criterion=9179, side="alliance", trivia={criteria="Wintergrasp Demolisher", module="pvp", category="Player vs. Player/Wintergrasp", name="Destruction Derby", description="Destroy each of the vehicles listed below.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type="slay"}}

-- Player vs. Player/Wintergrasp: Didn't Stand a Chance
A{"LakeWintergrasp", 1751, criterion=7703, trivia={criteria="Kill 20 mounted players using a tower cannon", module="pvp", category="Player vs. Player/Wintergrasp", name="Didn't Stand a Chance", description="Kill 20 mounted players using a tower cannon.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type=70}}

-- Player vs. Player/Wintergrasp: Master of Wintergrasp
A{"LakeWintergrasp", 1752, criterion=9758, trivia={criteria="Wintergrasp Veteran", module="pvp", category="Player vs. Player/Wintergrasp", name="Master of Wintergrasp", description="Complete the Wintergrasp achievements listed below.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type="achievement"}}
A{"LakeWintergrasp", 1752, criterion=9766, trivia={criteria="Heroic: Archavon the Stone Watcher", module="pvp", category="Player vs. Player/Wintergrasp", name="Master of Wintergrasp", description="Complete the Wintergrasp achievements listed below.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type="achievement"}}
A{"LakeWintergrasp", 1752, criterion=9759, trivia={criteria="Within Our Grasp", module="pvp", category="Player vs. Player/Wintergrasp", name="Master of Wintergrasp", description="Complete the Wintergrasp achievements listed below.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type="achievement"}}
A{"LakeWintergrasp", 1752, criterion=9765, trivia={criteria="Archavon the Stone Watcher", module="pvp", category="Player vs. Player/Wintergrasp", name="Master of Wintergrasp", description="Complete the Wintergrasp achievements listed below.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type="achievement"}}
A{"LakeWintergrasp", 1752, criterion=9771, trivia={criteria="Didn't Stand a Chance", module="pvp", category="Player vs. Player/Wintergrasp", name="Master of Wintergrasp", description="Complete the Wintergrasp achievements listed below.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type="achievement"}}
A{"LakeWintergrasp", 1752, criterion=9761, trivia={criteria="Black War Mammoth", module="pvp", category="Player vs. Player/Wintergrasp", name="Master of Wintergrasp", description="Complete the Wintergrasp achievements listed below.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type="achievement"}}
A{"LakeWintergrasp", 1752, criterion=9770, trivia={criteria="Leaning Tower", module="pvp", category="Player vs. Player/Wintergrasp", name="Master of Wintergrasp", description="Complete the Wintergrasp achievements listed below.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type="achievement"}}
A{"LakeWintergrasp", 1752, criterion=9760, trivia={criteria="Wintergrasp Ranger", module="pvp", category="Player vs. Player/Wintergrasp", name="Master of Wintergrasp", description="Complete the Wintergrasp achievements listed below.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type="achievement"}}
A{"LakeWintergrasp", 1752, criterion=9769, trivia={criteria="Vehicular Gnomeslaughter", module="pvp", category="Player vs. Player/Wintergrasp", name="Master of Wintergrasp", description="Complete the Wintergrasp achievements listed below.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type="achievement"}}
A{"LakeWintergrasp", 1752, criterion=7732, trivia={criteria="Destruction Derby", module="pvp", category="Player vs. Player/Wintergrasp", name="Master of Wintergrasp", description="Complete the Wintergrasp achievements listed below.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type="achievement"}}

-- Player vs. Player/Wintergrasp: Within Our Grasp
A{"LakeWintergrasp", 1755, trivia={module="pvp", category="Player vs. Player/Wintergrasp", name="Within Our Grasp", description="Attack Wintergrasp and succeed in 10 minutes or less.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Wintergrasp: Black War Mammoth
A{"LakeWintergrasp", 2080, trivia={module="pvp", category="Player vs. Player/Wintergrasp", name="Black War Mammoth", description="Obtain a Black War Mammoth.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Wintergrasp: Wintergrasp Ranger
A{"LakeWintergrasp", 2199, criterion=7715, trivia={criteria="Shadowsight Tower", module="pvp", category="Player vs. Player/Wintergrasp", name="Wintergrasp Ranger", description="Kill 10 players in each of the Wintergrasp areas listed below.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type=70}}
A{"LakeWintergrasp", 2199, criterion=7709, trivia={criteria="Wintergrasp Fortress", module="pvp", category="Player vs. Player/Wintergrasp", name="Wintergrasp Ranger", description="Kill 10 players in each of the Wintergrasp areas listed below.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type=70}}
A{"LakeWintergrasp", 2199, criterion=7710, trivia={criteria="Eastspark Workshop", module="pvp", category="Player vs. Player/Wintergrasp", name="Wintergrasp Ranger", description="Kill 10 players in each of the Wintergrasp areas listed below.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type=70}}
A{"LakeWintergrasp", 2199, criterion=7711, trivia={criteria="The Broken Temple", module="pvp", category="Player vs. Player/Wintergrasp", name="Wintergrasp Ranger", description="Kill 10 players in each of the Wintergrasp areas listed below.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type=70}}
A{"LakeWintergrasp", 2199, criterion=7712, trivia={criteria="The Sunken Ring", module="pvp", category="Player vs. Player/Wintergrasp", name="Wintergrasp Ranger", description="Kill 10 players in each of the Wintergrasp areas listed below.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type=70}}
A{"LakeWintergrasp", 2199, criterion=7713, trivia={criteria="Westspark Workshop", module="pvp", category="Player vs. Player/Wintergrasp", name="Wintergrasp Ranger", description="Kill 10 players in each of the Wintergrasp areas listed below.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type=70}}
A{"LakeWintergrasp", 2199, criterion=7714, trivia={criteria="Flamewatch Tower", module="pvp", category="Player vs. Player/Wintergrasp", name="Wintergrasp Ranger", description="Kill 10 players in each of the Wintergrasp areas listed below.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type=70}}
A{"LakeWintergrasp", 2199, criterion=7716, trivia={criteria="Winter's Edge Tower", module="pvp", category="Player vs. Player/Wintergrasp", name="Wintergrasp Ranger", description="Kill 10 players in each of the Wintergrasp areas listed below.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type=70}}
A{"LakeWintergrasp", 2199, criterion=7718, trivia={criteria="The Cauldron of Flames", module="pvp", category="Player vs. Player/Wintergrasp", name="Wintergrasp Ranger", description="Kill 10 players in each of the Wintergrasp areas listed below.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type=70}}
A{"LakeWintergrasp", 2199, criterion=7719, trivia={criteria="The Chilled Quagmire", module="pvp", category="Player vs. Player/Wintergrasp", name="Wintergrasp Ranger", description="Kill 10 players in each of the Wintergrasp areas listed below.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type=70}}

-- Player vs. Player/Wintergrasp: Destruction Derby
A{"LakeWintergrasp", 2476, criterion=9178, side="horde", trivia={criteria="Wintergrasp Catapult", module="pvp", category="Player vs. Player/Wintergrasp", name="Destruction Derby", description="Destroy each of the vehicles listed below.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type="slay"}}
A{"LakeWintergrasp", 2476, criterion=9179, side="horde", trivia={criteria="Wintergrasp Demolisher", module="pvp", category="Player vs. Player/Wintergrasp", name="Destruction Derby", description="Destroy each of the vehicles listed below.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type="slay"}}
A{"LakeWintergrasp", 2476, criterion=9180, side="horde", trivia={criteria="Wintergrasp Siege Engine", module="pvp", category="Player vs. Player/Wintergrasp", name="Destruction Derby", description="Destroy each of the vehicles listed below.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type="slay"}}
A{"LakeWintergrasp", 2476, criterion=9181, side="horde", trivia={criteria="Wintergrasp Tower Cannon", module="pvp", category="Player vs. Player/Wintergrasp", name="Destruction Derby", description="Destroy each of the vehicles listed below.", mapID="Wintergrasp", uiMapID=123, points=10, parent="Player vs. Player", type="slay"}}

-- Player vs. Player/Arena: World Wide Winner
A{"Nagrand", 699, criterion=5735, trivia={criteria="Nagrand Arena", module="pvp", category="Player vs. Player/Arena", name="World Wide Winner", description="Win a ranked arena match in Blade's Edge, Nagrand, Dalaran Sewers, the Ruins of Lordaeron, Tol'Viron Arena and the Tiger's Peak.", mapID="Nagrand", uiMapID=107, points=10, parent="Player vs. Player", type=32}}

-- Player vs. Player/Eye of the Storm: Eye of the Storm Victory
A{"NetherstormArena", 208, trivia={module="pvp", category="Player vs. Player/Eye of the Storm", name="Eye of the Storm Victory", description="Win Eye of the Storm.", mapID="EyeOfTheStorm", uiMapID=112, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Eye of the Storm: Eye of the Storm Veteran
A{"NetherstormArena", 209, criterion=5897, trivia={criteria="Complete 100 victories in Eye of the Storm", module="pvp", category="Player vs. Player/Eye of the Storm", name="Eye of the Storm Veteran", description="Complete 100 victories in Eye of the Storm.", mapID="EyeOfTheStorm", uiMapID=112, points=10, parent="Player vs. Player", type=1}}

-- Player vs. Player/Eye of the Storm: Storm Glory
A{"NetherstormArena", 211, trivia={module="pvp", category="Player vs. Player/Eye of the Storm", name="Storm Glory", description="While your team holds 4 of the bases in Eye of the Storm, personally grab the flag and capture it.", mapID="EyeOfTheStorm", uiMapID=112, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Eye of the Storm: Storm Capper
A{"NetherstormArena", 212, trivia={module="pvp", category="Player vs. Player/Eye of the Storm", name="Storm Capper", description="Personally carry and capture the flag in Eye of the Storm.", mapID="EyeOfTheStorm", uiMapID=112, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Eye of the Storm: Stormtrooper
A{"NetherstormArena", 213, criterion=3685, trivia={criteria="5 Flag Carriers", module="pvp", category="Player vs. Player/Eye of the Storm", name="Stormtrooper", description="Kill 5 flag carriers in a single Eye of the Storm battle.", mapID="EyeOfTheStorm", uiMapID=112, points=10, parent="Player vs. Player", type=28}}
A{"NetherstormArena", 213, criterion=3685, trivia={criteria="5 Flag Carriers", module="pvp", category="Player vs. Player/Eye of the Storm", name="Stormtrooper", description="Kill 5 flag carriers in a single Eye of the Storm battle.", mapID="EyeOfTheStorm", uiMapID=112, points=10, parent="Player vs. Player", type=28}}

-- Player vs. Player/Eye of the Storm: Flurry
A{"NetherstormArena", 214, trivia={module="pvp", category="Player vs. Player/Eye of the Storm", name="Flurry", description="Win Eye of the Storm in under 6 minutes.", mapID="EyeOfTheStorm", uiMapID=112, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Eye of the Storm: Bound for Glory
A{"NetherstormArena", 216, trivia={module="pvp", category="Player vs. Player/Eye of the Storm", name="Bound for Glory", description="In a single Eye of the Storm match, capture the flag 3 times without dying.", mapID="EyeOfTheStorm", uiMapID=112, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Eye of the Storm: Bloodthirsty Berserker
A{"NetherstormArena", 233, trivia={module="pvp", category="Player vs. Player/Eye of the Storm", name="Bloodthirsty Berserker", description="Get a killing blow while under the effects of the berserker buff in Eye of the Storm.", mapID="EyeOfTheStorm", uiMapID=112, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Eye of the Storm: Stormy Assassin
A{"NetherstormArena", 587, criterion=443, trivia={criteria="Kill 5 people at the Fel Reaver ruins", module="pvp", category="Player vs. Player/Eye of the Storm", name="Stormy Assassin", description="In a single Eye of the Storm battle, get 5 honorable kills at each of the bases.", mapID="EyeOfTheStorm", uiMapID=112, points=10, parent="Player vs. Player", type=31}}
A{"NetherstormArena", 587, criterion=441, trivia={criteria="Kill 5 people at the Blood Elf Tower", module="pvp", category="Player vs. Player/Eye of the Storm", name="Stormy Assassin", description="In a single Eye of the Storm battle, get 5 honorable kills at each of the bases.", mapID="EyeOfTheStorm", uiMapID=112, points=10, parent="Player vs. Player", type=31}}
A{"NetherstormArena", 587, criterion=442, trivia={criteria="Kill 5 people at the Draenei Ruins", module="pvp", category="Player vs. Player/Eye of the Storm", name="Stormy Assassin", description="In a single Eye of the Storm battle, get 5 honorable kills at each of the bases.", mapID="EyeOfTheStorm", uiMapID=112, points=10, parent="Player vs. Player", type=31}}
A{"NetherstormArena", 587, criterion=444, trivia={criteria="Kill 5 people at the Mage Tower", module="pvp", category="Player vs. Player/Eye of the Storm", name="Stormy Assassin", description="In a single Eye of the Storm battle, get 5 honorable kills at each of the bases.", mapID="EyeOfTheStorm", uiMapID=112, points=10, parent="Player vs. Player", type=31}}

-- Player vs. Player/Eye of the Storm: The Perfect Storm
A{"NetherstormArena", 783, trivia={module="pvp", category="Player vs. Player/Eye of the Storm", name="The Perfect Storm", description="Win Eye of the Storm with a score of 1500 to 0.", mapID="EyeOfTheStorm", uiMapID=112, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Eye of the Storm: Eye of the Storm Domination
A{"NetherstormArena", 784, criterion=1239, trivia={criteria="Win Eye of the Storm 10 times while holding 4 bases", module="pvp", category="Player vs. Player/Eye of the Storm", name="Eye of the Storm Domination", description="Win Eye of the Storm 10 times while holding 4 bases.", mapID="EyeOfTheStorm", uiMapID=112, points=10, parent="Player vs. Player", type=1}}

-- Player vs. Player/Eye of the Storm: Master of Eye of the Storm
A{"NetherstormArena", 1171, criterion=3446, trivia={criteria="Eye of the Storm Veteran", module="pvp", category="Player vs. Player/Eye of the Storm", name="Master of Eye of the Storm", description="Complete the Eye of the Storm achievements listed below.", mapID="EyeOfTheStorm", uiMapID=112, points=25, parent="Player vs. Player", type="achievement"}}
A{"NetherstormArena", 1171, criterion=3449, trivia={criteria="Flurry", module="pvp", category="Player vs. Player/Eye of the Storm", name="Master of Eye of the Storm", description="Complete the Eye of the Storm achievements listed below.", mapID="EyeOfTheStorm", uiMapID=112, points=25, parent="Player vs. Player", type="achievement"}}
A{"NetherstormArena", 1171, criterion=3451, trivia={criteria="Storm Capper", module="pvp", category="Player vs. Player/Eye of the Storm", name="Master of Eye of the Storm", description="Complete the Eye of the Storm achievements listed below.", mapID="EyeOfTheStorm", uiMapID=112, points=25, parent="Player vs. Player", type="achievement"}}
A{"NetherstormArena", 1171, criterion=3452, trivia={criteria="Bound for Glory", module="pvp", category="Player vs. Player/Eye of the Storm", name="Master of Eye of the Storm", description="Complete the Eye of the Storm achievements listed below.", mapID="EyeOfTheStorm", uiMapID=112, points=25, parent="Player vs. Player", type="achievement"}}
A{"NetherstormArena", 1171, criterion=3447, trivia={criteria="The Perfect Storm", module="pvp", category="Player vs. Player/Eye of the Storm", name="Master of Eye of the Storm", description="Complete the Eye of the Storm achievements listed below.", mapID="EyeOfTheStorm", uiMapID=112, points=25, parent="Player vs. Player", type="achievement"}}
A{"NetherstormArena", 1171, criterion=3448, trivia={criteria="Eye of the Storm Domination", module="pvp", category="Player vs. Player/Eye of the Storm", name="Master of Eye of the Storm", description="Complete the Eye of the Storm achievements listed below.", mapID="EyeOfTheStorm", uiMapID=112, points=25, parent="Player vs. Player", type="achievement"}}
A{"NetherstormArena", 1171, criterion=3453, trivia={criteria="Bloodthirsty Berserker", module="pvp", category="Player vs. Player/Eye of the Storm", name="Master of Eye of the Storm", description="Complete the Eye of the Storm achievements listed below.", mapID="EyeOfTheStorm", uiMapID=112, points=25, parent="Player vs. Player", type="achievement"}}
A{"NetherstormArena", 1171, criterion=3450, trivia={criteria="Stormtrooper", module="pvp", category="Player vs. Player/Eye of the Storm", name="Master of Eye of the Storm", description="Complete the Eye of the Storm achievements listed below.", mapID="EyeOfTheStorm", uiMapID=112, points=25, parent="Player vs. Player", type="achievement"}}

-- Player vs. Player/Eye of the Storm: Take a Chill Pill
A{"NetherstormArena", 1258, trivia={module="pvp", category="Player vs. Player/Eye of the Storm", name="Take a Chill Pill", description="In Eye of the Storm, kill a player who is under the effects of the Berserker power-up.", mapID="EyeOfTheStorm", uiMapID=112, points=10, parent="Player vs. Player"}}

-- Player vs. Player: Wrath of the Alliance
A{"Orgrimmar", 604, criterion=6635, side="alliance", trivia={criteria="Orgrimmar", module="pvp", category="Player vs. Player", name="Wrath of the Alliance", description="Kill 5 Horde players in each of the cities listed below.", mapID="Orgrimmar", uiMapID=85, points=10, type="battle"}}

-- Player vs. Player: Death to the Warchief!
A{"Orgrimmar", 610, 0.4800, 0.7100, side="alliance", trivia={module="pvp", category="Player vs. Player", name="Death to the Warchief!", description="Kill Vol'jin.", mapID="Orgrimmar", uiMapID=85, points=10}}

-- Player vs. Player: For The Alliance!
A{"Orgrimmar", 614, 0.4800, 0.7100, criterion=484, side="alliance", trivia={criteria="Death to the Warchief!", module="pvp", category="Player vs. Player", name="For The Alliance!", description="Slay the leaders of the Horde.", mapID="Orgrimmar", uiMapID=85, points=20, type="achievement"}}

-- Player vs. Player: Wrath of the Alliance
A{"SilvermoonCity", 604, criterion=6634, side="alliance", trivia={criteria="Silvermoon City", module="pvp", category="Player vs. Player", name="Wrath of the Alliance", description="Kill 5 Horde players in each of the cities listed below.", mapID="SilvermoonCity", uiMapID=110, points=10, type="battle"}}

-- Player vs. Player: Killed in Quel'Thalas
A{"SilvermoonCity", 613, 0.5400, 0.2100, side="alliance", trivia={module="pvp", category="Player vs. Player", name="Killed in Quel'Thalas", description="Kill Lor'themar Theron.", mapID="SilvermoonCity", uiMapID=110, points=10}}

-- Player vs. Player: For The Alliance!
A{"SilvermoonCity", 614, 0.5400, 0.2100, criterion=487, side="alliance", trivia={criteria="Killed in Quel'Thalas", module="pvp", category="Player vs. Player", name="For The Alliance!", description="Slay the leaders of the Horde.", mapID="SilvermoonCity", uiMapID=110, points=20, type="achievement"}}

-- Player vs. Player: Wrath of the Horde
A{"StormwindCity", 603, criterion=6640, side="horde", trivia={criteria="Stormwind City", module="pvp", category="Player vs. Player", name="Wrath of the Horde", description="Kill 5 Alliance players in each of the cities listed below.", mapID="StormwindCity", uiMapID=84, points=10, type="battle"}}

-- Player vs. Player: Storming Stormwind
A{"StormwindCity", 615, 0.8600, 0.3200, side="horde", trivia={module="pvp", category="Player vs. Player", name="Storming Stormwind", description="Kill King Varian Wrynn.", mapID="StormwindCity", uiMapID=84, points=10}}

-- Player vs. Player: For The Horde!
A{"StormwindCity", 619, 0.8600, 0.3200, criterion=492, side="horde", trivia={criteria="Storming Stormwind", module="pvp", category="Player vs. Player", name="For The Horde!", description="Slay the leaders of the Alliance.", mapID="StormwindCity", uiMapID=84, points=20, type="achievement"}}

-- Player vs. Player/Strand of the Ancients: Strand of the Ancients Victory
A{"StrandoftheAncients", 1308, trivia={module="pvp", category="Player vs. Player/Strand of the Ancients", name="Strand of the Ancients Victory", description="Win Strand of the Ancients.", mapID="StrandOfTheAncients", uiMapID=128, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Strand of the Ancients: Strand of the Ancients Veteran
A{"StrandoftheAncients", 1309, criterion=5898, trivia={criteria="Complete 100 victories in Strand of the Ancients", module="pvp", category="Player vs. Player/Strand of the Ancients", name="Strand of the Ancients Veteran", description="Complete 100 victories in Strand of the Ancients.", mapID="StrandOfTheAncients", uiMapID=128, points=10, parent="Player vs. Player", type=1}}

-- Player vs. Player/Strand of the Ancients: Storm the Beach
A{"StrandoftheAncients", 1310, trivia={module="pvp", category="Player vs. Player/Strand of the Ancients", name="Storm the Beach", description="Capture the Titan Relic in under four minutes.", mapID="StrandOfTheAncients", uiMapID=128, points=20, parent="Player vs. Player"}}

-- Player vs. Player/Strand of the Ancients: Defense of the Ancients
A{"StrandoftheAncients", 1757, side="alliance", trivia={module="pvp", category="Player vs. Player/Strand of the Ancients", name="Defense of the Ancients", description="Defend the beach without losing any walls.", mapID="StrandOfTheAncients", uiMapID=128, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Strand of the Ancients: The Dapper Sapper
A{"StrandoftheAncients", 1761, criterion=7632, trivia={criteria="Plant 100 Seaforium charges which successfully damage a wall", module="pvp", category="Player vs. Player/Strand of the Ancients", name="The Dapper Sapper", description="Plant 100 Seaforium charges which successfully damage a wall.", mapID="StrandOfTheAncients", uiMapID=128, points=10, parent="Player vs. Player", type=28}}

-- Player vs. Player/Strand of the Ancients: Not Even a Scratch
A{"StrandoftheAncients", 1762, side="alliance", trivia={module="pvp", category="Player vs. Player/Strand of the Ancients", name="Not Even a Scratch", description="Win a Strand of the Ancients battle without losing any siege vehicles.", mapID="StrandOfTheAncients", uiMapID=128, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Strand of the Ancients: Artillery Veteran
A{"StrandoftheAncients", 1763, criterion=7625, trivia={criteria="Destroy 100 vehicles using a turret", module="pvp", category="Player vs. Player/Strand of the Ancients", name="Artillery Veteran", description="Destroy 100 vehicles using a turret.", mapID="StrandOfTheAncients", uiMapID=128, points=10, parent="Player vs. Player", type="slay"}}

-- Player vs. Player/Strand of the Ancients: Drop It!
A{"StrandoftheAncients", 1764, criterion=6446, trivia={criteria="Kill 100 players carrying seaforium", module="pvp", category="Player vs. Player/Strand of the Ancients", name="Drop It!", description="Kill 100 players carrying seaforium.", mapID="StrandOfTheAncients", uiMapID=128, points=10, parent="Player vs. Player", type=28}}

-- Player vs. Player/Strand of the Ancients: Steady Hands
A{"StrandoftheAncients", 1765, criterion=6447, trivia={criteria="Disarm 2 seaforium charges in a single battle", module="pvp", category="Player vs. Player/Strand of the Ancients", name="Steady Hands", description="Disarm 2 seaforium charges in a single battle.", mapID="StrandOfTheAncients", uiMapID=128, points=10, parent="Player vs. Player", type=29}}

-- Player vs. Player/Strand of the Ancients: Ancient Protector
A{"StrandoftheAncients", 1766, criterion=7630, trivia={criteria="Kill 10 players in the Courtyard of the Ancients in a single battle", module="pvp", category="Player vs. Player/Strand of the Ancients", name="Ancient Protector", description="Kill 10 players in the Courtyard of the Ancients in a single battle.", mapID="StrandOfTheAncients", uiMapID=128, points=10, parent="Player vs. Player", type=70}}

-- Player vs. Player/Strand of the Ancients: Artillery Expert
A{"StrandoftheAncients", 2189, criterion=7628, trivia={criteria="Destroy 5 vehicles using a turret in a single battle", module="pvp", category="Player vs. Player/Strand of the Ancients", name="Artillery Expert", description="Destroy 5 vehicles using a turret in a single battle.", mapID="StrandOfTheAncients", uiMapID=128, points=10, parent="Player vs. Player", type="slay"}}

-- Player vs. Player/Strand of the Ancients: Drop It Now!
A{"StrandoftheAncients", 2190, criterion=7629, trivia={criteria="Kill 5 players carrying seaforium in a single battle", module="pvp", category="Player vs. Player/Strand of the Ancients", name="Drop It Now!", description="Kill 5 players carrying seaforium in a single battle.", mapID="StrandOfTheAncients", uiMapID=128, points=10, parent="Player vs. Player", type=28}}

-- Player vs. Player/Strand of the Ancients: Ancient Courtyard Protector
A{"StrandoftheAncients", 2191, criterion=7631, trivia={criteria="Kill 100 players in the Courtyard of the Ancients", module="pvp", category="Player vs. Player/Strand of the Ancients", name="Ancient Courtyard Protector", description="Kill 100 players in the Courtyard of the Ancients.", mapID="StrandOfTheAncients", uiMapID=128, points=10, parent="Player vs. Player", type=70}}

-- Player vs. Player/Strand of the Ancients: Not Even a Scratch
A{"StrandoftheAncients", 2192, side="horde", trivia={module="pvp", category="Player vs. Player/Strand of the Ancients", name="Not Even a Scratch", description="Win a Strand of the Ancients battle without losing any siege vehicles.", mapID="StrandOfTheAncients", uiMapID=128, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Strand of the Ancients: Explosives Expert
A{"StrandoftheAncients", 2193, criterion=7635, trivia={criteria="Plant 5 Seaforium charges which successfully damage a wall in a single battle", module="pvp", category="Player vs. Player/Strand of the Ancients", name="Explosives Expert", description="Plant 5 Seaforium charges which successfully damage a wall in a single battle.", mapID="StrandOfTheAncients", uiMapID=128, points=10, parent="Player vs. Player", type=28}}

-- Player vs. Player/Strand of the Ancients: Master of Strand of the Ancients
A{"StrandoftheAncients", 2194, criterion=7657, trivia={criteria="The Dapper Sapper", module="pvp", category="Player vs. Player/Strand of the Ancients", name="Master of Strand of the Ancients", description="Complete the Strand of the Ancients achievements listed below.", mapID="StrandOfTheAncients", uiMapID=128, points=25, parent="Player vs. Player", type="achievement"}}
A{"StrandoftheAncients", 2194, criterion=7654, trivia={criteria="Strand of the Ancients Veteran", module="pvp", category="Player vs. Player/Strand of the Ancients", name="Master of Strand of the Ancients", description="Complete the Strand of the Ancients achievements listed below.", mapID="StrandOfTheAncients", uiMapID=128, points=25, parent="Player vs. Player", type="achievement"}}
A{"StrandoftheAncients", 2194, criterion=7658, trivia={criteria="Explosives Expert", module="pvp", category="Player vs. Player/Strand of the Ancients", name="Master of Strand of the Ancients", description="Complete the Strand of the Ancients achievements listed below.", mapID="StrandOfTheAncients", uiMapID=128, points=25, parent="Player vs. Player", type="achievement"}}
A{"StrandoftheAncients", 2194, criterion=7661, trivia={criteria="Artillery Expert", module="pvp", category="Player vs. Player/Strand of the Ancients", name="Master of Strand of the Ancients", description="Complete the Strand of the Ancients achievements listed below.", mapID="StrandOfTheAncients", uiMapID=128, points=25, parent="Player vs. Player", type="achievement"}}
A{"StrandoftheAncients", 2194, criterion=7655, trivia={criteria="Storm the Beach", module="pvp", category="Player vs. Player/Strand of the Ancients", name="Master of Strand of the Ancients", description="Complete the Strand of the Ancients achievements listed below.", mapID="StrandOfTheAncients", uiMapID=128, points=25, parent="Player vs. Player", type="achievement"}}
A{"StrandoftheAncients", 2194, criterion=7662, trivia={criteria="Drop it!", module="pvp", category="Player vs. Player/Strand of the Ancients", name="Master of Strand of the Ancients", description="Complete the Strand of the Ancients achievements listed below.", mapID="StrandOfTheAncients", uiMapID=128, points=25, parent="Player vs. Player", type="achievement"}}
A{"StrandoftheAncients", 2194, criterion=7664, trivia={criteria="Ancient Protector", module="pvp", category="Player vs. Player/Strand of the Ancients", name="Master of Strand of the Ancients", description="Complete the Strand of the Ancients achievements listed below.", mapID="StrandOfTheAncients", uiMapID=128, points=25, parent="Player vs. Player", type="achievement"}}
A{"StrandoftheAncients", 2194, criterion=7665, trivia={criteria="Ancient Courtyard Protector", module="pvp", category="Player vs. Player/Strand of the Ancients", name="Master of Strand of the Ancients", description="Complete the Strand of the Ancients achievements listed below.", mapID="StrandOfTheAncients", uiMapID=128, points=25, parent="Player vs. Player", type="achievement"}}
A{"StrandoftheAncients", 2194, criterion=7660, trivia={criteria="Artillery Veteran", module="pvp", category="Player vs. Player/Strand of the Ancients", name="Master of Strand of the Ancients", description="Complete the Strand of the Ancients achievements listed below.", mapID="StrandOfTheAncients", uiMapID=128, points=25, parent="Player vs. Player", type="achievement"}}
A{"StrandoftheAncients", 2194, criterion=7663, trivia={criteria="Drop it now!", module="pvp", category="Player vs. Player/Strand of the Ancients", name="Master of Strand of the Ancients", description="Complete the Strand of the Ancients achievements listed below.", mapID="StrandOfTheAncients", uiMapID=128, points=25, parent="Player vs. Player", type="achievement"}}
A{"StrandoftheAncients", 2194, criterion=7656, trivia={criteria="Steady Hands", module="pvp", category="Player vs. Player/Strand of the Ancients", name="Master of Strand of the Ancients", description="Complete the Strand of the Ancients achievements listed below.", mapID="StrandOfTheAncients", uiMapID=128, points=25, parent="Player vs. Player", type="achievement"}}
A{"StrandoftheAncients", 2194, criterion=7647, trivia={criteria="Not Even a Scratch", module="pvp", category="Player vs. Player/Strand of the Ancients", name="Master of Strand of the Ancients", description="Complete the Strand of the Ancients achievements listed below.", mapID="StrandOfTheAncients", uiMapID=128, points=25, parent="Player vs. Player", type="achievement"}}
A{"StrandoftheAncients", 2194, criterion=7741, trivia={criteria="Defense of the Ancients", module="pvp", category="Player vs. Player/Strand of the Ancients", name="Master of Strand of the Ancients", description="Complete the Strand of the Ancients achievements listed below.", mapID="StrandOfTheAncients", uiMapID=128, points=25, parent="Player vs. Player", type="achievement"}}

-- Player vs. Player/Strand of the Ancients: Defense of the Ancients
A{"StrandoftheAncients", 2200, side="horde", trivia={module="pvp", category="Player vs. Player/Strand of the Ancients", name="Defense of the Ancients", description="Defend the beach without losing any walls.", mapID="StrandOfTheAncients", uiMapID=128, points=10, parent="Player vs. Player"}}

-- Player vs. Player: Gurubashi Arena Master
A{"TheCapeOfStranglethorn", 389, 0.4650, 0.2610, trivia={module="pvp", category="Player vs. Player", name="Gurubashi Arena Master", description="Loot the Arena Master trinket from the Gurubashi Arena.", mapID="TheCapeOfStranglethorn", uiMapID=210, points=10}}

-- Player vs. Player: Gurubashi Arena Grand Master
A{"TheCapeOfStranglethorn", 396, 0.4500, 0.2540, trivia={module="pvp", category="Player vs. Player", name="Gurubashi Arena Grand Master", description="Complete Short John Mithril's quest to obtain the Arena Grand Master trinket.", mapID="TheCapeOfStranglethorn", uiMapID=210, points=10}}

-- Player vs. Player: Wrath of the Horde
A{"TheExodar", 603, criterion=6639, side="horde", trivia={criteria="The Exodar", module="pvp", category="Player vs. Player", name="Wrath of the Horde", description="Kill 5 Alliance players in each of the cities listed below.", mapID="TheExodar", uiMapID=103, points=10, type="battle"}}

-- Player vs. Player: Putting Out the Light
A{"TheExodar", 618, 0.3300, 0.5500, side="horde", trivia={module="pvp", category="Player vs. Player", name="Putting Out the Light", description="Kill Prophet Velen.", mapID="TheExodar", uiMapID=103, points=10}}

-- Player vs. Player: For The Horde!
A{"TheExodar", 619, 0.3300, 0.5500, criterion=495, side="horde", trivia={criteria="Putting Out the Light", module="pvp", category="Player vs. Player", name="For The Horde!", description="Slay the leaders of the Alliance.", mapID="TheExodar", uiMapID=103, points=20, type="achievement"}}

-- Player vs. Player: Wrath of the Alliance
A{"ThunderBluff", 604, criterion=6633, side="alliance", trivia={criteria="Thunder Bluff", module="pvp", category="Player vs. Player", name="Wrath of the Alliance", description="Kill 5 Horde players in each of the cities listed below.", mapID="ThunderBluff", uiMapID=88, points=10, type="battle"}}

-- Player vs. Player: Bleeding Bloodhoof
A{"ThunderBluff", 611, 0.6000, 0.5200, side="alliance", trivia={module="pvp", category="Player vs. Player", name="Bleeding Bloodhoof", description="Kill Baine Bloodhoof.", mapID="ThunderBluff", uiMapID=88, points=10}}

-- Player vs. Player: For The Alliance!
A{"ThunderBluff", 614, 0.6000, 0.5200, criterion=485, side="alliance", trivia={criteria="Bleeding Bloodhoof", module="pvp", category="Player vs. Player", name="For The Alliance!", description="Slay the leaders of the Horde.", mapID="ThunderBluff", uiMapID=88, points=20, type="achievement"}}

-- Player vs. Player: Emissary of Ordos
A{"TimelessIsle", 8716, trivia={module="pvp", category="Player vs. Player", name="Emissary of Ordos", description="Use the Censer of Eternal Agony obtained from Speaker Gulan on the Timeless Isle.", mapID="TimelessIsle", uiMapID=554, points=10}}

-- Player vs. Player/Arena: World Wide Winner
A{"Tirisfal", 699, criterion=8589, trivia={criteria="Ruins of Lordaeron", module="pvp", category="Player vs. Player/Arena", name="World Wide Winner", description="Win a ranked arena match in Blade's Edge, Nagrand, Dalaran Sewers, the Ruins of Lordaeron, Tol'Viron Arena and the Tiger's Peak.", mapID="TirisfalGlades", uiMapID=18, points=10, parent="Player vs. Player", type=32}}

-- Player vs. Player/Twin Peaks: Twin Peaking
A{"TwinPeaks", 5208, trivia={module="pvp", category="Player vs. Player/Twin Peaks", name="Twin Peaking", description="Win 2 Twin Peaks battles.", mapID="TwinPeaks", uiMapID=206, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Twin Peaks: Twin Peaks Veteran
A{"TwinPeaks", 5209, criterion=16512, trivia={criteria="Complete 100 victories in Twin Peaks", module="pvp", category="Player vs. Player/Twin Peaks", name="Twin Peaks Veteran", description="Complete 100 victories in Twin Peaks.", mapID="TwinPeaks", uiMapID=206, points=10, parent="Player vs. Player", type=1}}

-- Player vs. Player/Twin Peaks: Two-Timer
A{"TwinPeaks", 5210, trivia={module="pvp", category="Player vs. Player/Twin Peaks", name="Two-Timer", description="Personally carry and capture the flag 2 times in Twin Peaks.", mapID="TwinPeaks", uiMapID=206, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Twin Peaks: Top Defender
A{"TwinPeaks", 5211, criterion=14871, trivia={criteria="Return the flag 50 times", module="pvp", category="Player vs. Player/Twin Peaks", name="Top Defender", description="Return 50 flags as a defender in Twin Peaks.", mapID="TwinPeaks", uiMapID=206, points=10, parent="Player vs. Player", type=30}}

-- Player vs. Player/Twin Peaks: Soaring Spirits
A{"TwinPeaks", 5213, criterion=14820, side="alliance", trivia={criteria="Horde Flag Carriers", module="pvp", category="Player vs. Player/Twin Peaks", name="Soaring Spirits", description="Kill 100 flag carriers in Twin Peaks.", mapID="TwinPeaks", uiMapID=206, points=10, parent="Player vs. Player", type=70}}

-- Player vs. Player/Twin Peaks: Soaring Spirits
A{"TwinPeaks", 5214, criterion=14821, side="horde", trivia={criteria="Alliance Flag Carriers", module="pvp", category="Player vs. Player/Twin Peaks", name="Soaring Spirits", description="Kill 100 flag carriers in Twin Peaks.", mapID="TwinPeaks", uiMapID=206, points=10, parent="Player vs. Player", type=70}}

-- Player vs. Player/Twin Peaks: Twin Peaks Perfection
A{"TwinPeaks", 5215, trivia={module="pvp", category="Player vs. Player/Twin Peaks", name="Twin Peaks Perfection", description="Win Twin Peaks with a score of 3 to 0 while also getting at least 1 killing blow.", mapID="TwinPeaks", uiMapID=206, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Twin Peaks: Peak Speed
A{"TwinPeaks", 5216, trivia={module="pvp", category="Player vs. Player/Twin Peaks", name="Peak Speed", description="Win Twin Peaks in under 7 minutes.", mapID="TwinPeaks", uiMapID=206, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Twin Peaks: I'm in the White Lodge
A{"TwinPeaks", 5219, criterion=14827, side="alliance", trivia={criteria="Kill 2 flag carriers before they leave the Wildhammer Stronghold", module="pvp", category="Player vs. Player/Twin Peaks", name="I'm in the White Lodge", description="In a single Twin Peaks battle, kill 2 flag carriers before they leave the Wildhammer Stronghold.", mapID="TwinPeaks", uiMapID=206, points=10, parent="Player vs. Player", type=70}}

-- Player vs. Player/Twin Peaks: I'm in the Black Lodge
A{"TwinPeaks", 5220, criterion=14828, side="horde", trivia={criteria="Kill 2 flag carriers before they leave the Dragonmaw Forge", module="pvp", category="Player vs. Player/Twin Peaks", name="I'm in the Black Lodge", description="In a single Twin Peaks battle, kill 2 flag carriers before they leave the Dragonmaw Flag Room.", mapID="TwinPeaks", uiMapID=206, points=10, parent="Player vs. Player", type=70}}

-- Player vs. Player/Twin Peaks: Fire, Walk With Me
A{"TwinPeaks", 5221, side="alliance", trivia={module="pvp", category="Player vs. Player/Twin Peaks", name="Fire, Walk With Me", description="Grab the flag and capture it in under 75 seconds.", mapID="TwinPeaks", uiMapID=206, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Twin Peaks: Fire, Walk With Me
A{"TwinPeaks", 5222, side="horde", trivia={module="pvp", category="Player vs. Player/Twin Peaks", name="Fire, Walk With Me", description="Grab the flag and capture it in under 75 seconds.", mapID="TwinPeaks", uiMapID=206, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Twin Peaks: Master of Twin Peaks
A{"TwinPeaks", 5223, criterion=14833, trivia={criteria="Twin Peaks Veteran", module="pvp", category="Player vs. Player/Twin Peaks", name="Master of Twin Peaks", description="Complete the Twin Peaks achievements listed below.", mapID="TwinPeaks", uiMapID=206, points=25, parent="Player vs. Player", type="achievement"}}
A{"TwinPeaks", 5223, criterion=14835, trivia={criteria="Top Defender", module="pvp", category="Player vs. Player/Twin Peaks", name="Master of Twin Peaks", description="Complete the Twin Peaks achievements listed below.", mapID="TwinPeaks", uiMapID=206, points=25, parent="Player vs. Player", type="achievement"}}
A{"TwinPeaks", 5223, criterion=14837, trivia={criteria="Twin Peaks Perfection", module="pvp", category="Player vs. Player/Twin Peaks", name="Master of Twin Peaks", description="Complete the Twin Peaks achievements listed below.", mapID="TwinPeaks", uiMapID=206, points=25, parent="Player vs. Player", type="achievement"}}
A{"TwinPeaks", 5223, criterion=14838, trivia={criteria="Peak Speed", module="pvp", category="Player vs. Player/Twin Peaks", name="Master of Twin Peaks", description="Complete the Twin Peaks achievements listed below.", mapID="TwinPeaks", uiMapID=206, points=25, parent="Player vs. Player", type="achievement"}}
A{"TwinPeaks", 5223, criterion=14843, trivia={criteria="Twin Peaks Mountaineer", module="pvp", category="Player vs. Player/Twin Peaks", name="Master of Twin Peaks", description="Complete the Twin Peaks achievements listed below.", mapID="TwinPeaks", uiMapID=206, points=25, parent="Player vs. Player", type="achievement"}}
A{"TwinPeaks", 5223, criterion=14834, trivia={criteria="Two-Timer", module="pvp", category="Player vs. Player/Twin Peaks", name="Master of Twin Peaks", description="Complete the Twin Peaks achievements listed below.", mapID="TwinPeaks", uiMapID=206, points=25, parent="Player vs. Player", type="achievement"}}
A{"TwinPeaks", 5223, criterion=14836, trivia={criteria="Soaring Spirits", module="pvp", category="Player vs. Player/Twin Peaks", name="Master of Twin Peaks", description="Complete the Twin Peaks achievements listed below.", mapID="TwinPeaks", uiMapID=206, points=25, parent="Player vs. Player", type="achievement"}}
A{"TwinPeaks", 5223, criterion=14839, trivia={criteria="Cloud Nine", module="pvp", category="Player vs. Player/Twin Peaks", name="Master of Twin Peaks", description="Complete the Twin Peaks achievements listed below.", mapID="TwinPeaks", uiMapID=206, points=25, parent="Player vs. Player", type="achievement"}}
A{"TwinPeaks", 5223, criterion=14978, note="[alliance flavor?]", trivia={criteria="Drag a Maw/Wild Hammering", module="pvp", category="Player vs. Player/Twin Peaks", name="Master of Twin Peaks", description="Complete the Twin Peaks achievements listed below.", mapID="TwinPeaks", uiMapID=206, points=25, parent="Player vs. Player", type="achievement"}}
A{"TwinPeaks", 5223, criterion=14979, note="[alliance flavor?]", trivia={criteria="White Lodge/Black Lodge", module="pvp", category="Player vs. Player/Twin Peaks", name="Master of Twin Peaks", description="Complete the Twin Peaks achievements listed below.", mapID="TwinPeaks", uiMapID=206, points=25, parent="Player vs. Player", type="achievement"}}
A{"TwinPeaks", 5223, criterion=14842, trivia={criteria="Fire, Walk With Me", module="pvp", category="Player vs. Player/Twin Peaks", name="Master of Twin Peaks", description="Complete the Twin Peaks achievements listed below.", mapID="TwinPeaks", uiMapID=206, points=25, parent="Player vs. Player", type="achievement"}}
A{"TwinPeaks", 5223, criterion=14969, trivia={criteria="Double Jeopardy", module="pvp", category="Player vs. Player/Twin Peaks", name="Master of Twin Peaks", description="Complete the Twin Peaks achievements listed below.", mapID="TwinPeaks", uiMapID=206, points=25, parent="Player vs. Player", type="achievement"}}

-- Player vs. Player/Twin Peaks: Cloud Nine
A{"TwinPeaks", 5226, side="alliance", trivia={module="pvp", category="Player vs. Player/Twin Peaks", name="Cloud Nine", description="In a single Twin Peaks battle, capture and return a total of 9 flags.", mapID="TwinPeaks", uiMapID=206, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Twin Peaks: Cloud Nine
A{"TwinPeaks", 5227, side="horde", trivia={module="pvp", category="Player vs. Player/Twin Peaks", name="Cloud Nine", description="In a single Twin Peaks battle, capture and return a total of 9 flags.", mapID="TwinPeaks", uiMapID=206, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Twin Peaks: Wild Hammering
A{"TwinPeaks", 5228, criterion=14893, side="horde", trivia={criteria="Kill 5 Dwarves", module="pvp", category="Player vs. Player/Twin Peaks", name="Wild Hammering", description="Kill 5 Dwarves in a single Twin Peaks battle.", mapID="TwinPeaks", uiMapID=206, points=10, parent="Player vs. Player", type="battle"}}

-- Player vs. Player/Twin Peaks: Drag a Maw
A{"TwinPeaks", 5229, criterion=14894, side="alliance", trivia={criteria="Kill 5 Orcs", module="pvp", category="Player vs. Player/Twin Peaks", name="Drag a Maw", description="Kill 5 Orcs in a single Twin Peaks battle.", mapID="TwinPeaks", uiMapID=206, points=10, parent="Player vs. Player", type="battle"}}

-- Player vs. Player/Twin Peaks: Twin Peaks Mountaineer
A{"TwinPeaks", 5230, trivia={module="pvp", category="Player vs. Player/Twin Peaks", name="Twin Peaks Mountaineer", description="Perform a roar emote with the flag while under the effect of both a speed power up and the berserking power up.", mapID="TwinPeaks", uiMapID=206, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Twin Peaks: Double Jeopardy
A{"TwinPeaks", 5231, side="alliance", trivia={module="pvp", category="Player vs. Player/Twin Peaks", name="Double Jeopardy", description="Win a Twin Peaks battle after being behind by a score of 0 to 2.", mapID="TwinPeaks", uiMapID=206, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Twin Peaks: Double Jeopardy
A{"TwinPeaks", 5552, side="horde", trivia={module="pvp", category="Player vs. Player/Twin Peaks", name="Double Jeopardy", description="Win a Twin Peaks battle after being behind by a score of 0 to 2.", mapID="TwinPeaks", uiMapID=206, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Arena: World Wide Winner
A{"Uldum", 699, criterion=21042, trivia={criteria="Tol'Viron Arena", module="pvp", category="Player vs. Player/Arena", name="World Wide Winner", description="Win a ranked arena match in Blade's Edge, Nagrand, Dalaran Sewers, the Ruins of Lordaeron, Tol'Viron Arena and the Tiger's Peak.", mapID="Uldum", uiMapID=249, points=10, parent="Player vs. Player", type=32}}

-- Player vs. Player: Wrath of the Alliance
A{"Undercity", 604, criterion=6636, side="alliance", trivia={criteria="Undercity", module="pvp", category="Player vs. Player", name="Wrath of the Alliance", description="Kill 5 Horde players in each of the cities listed below.", mapID="Undercity", uiMapID=90, points=10, type="battle"}}

-- Player vs. Player: Downing the Dark Lady
A{"Undercity", 612, 0.5800, 0.9200, side="alliance", trivia={module="pvp", category="Player vs. Player", name="Downing the Dark Lady", description="Kill Lady Sylvanas Windrunner.", mapID="Undercity", uiMapID=90, points=10}}

-- Player vs. Player: For The Alliance!
A{"Undercity", 614, 0.5800, 0.9200, criterion=486, side="alliance", trivia={criteria="Downing the Dark Lady", module="pvp", category="Player vs. Player", name="For The Alliance!", description="Slay the leaders of the Horde.", mapID="Undercity", uiMapID=90, points=20, type="achievement"}}

-- Player vs. Player: Damage Control
A{"unknown", 227, trivia={module="pvp", category="Player vs. Player", name="Damage Control", description="Do 300,000 damage or healing in a single battle in any battleground. The damage or healing must be done to a player.", points=10}}

-- Player vs. Player: The Grim Reaper
A{"unknown", 229, trivia={module="pvp", category="Player vs. Player", name="The Grim Reaper", description="Get 30 Honorable Kills in a single battle in any battleground.", points=10}}

-- Player vs. Player: Battlemaster
A{"unknown", 230, criterion=3503, side="alliance", trivia={criteria="Master of Eye of the Storm", module="pvp", category="Player vs. Player", name="Battlemaster", description="Complete the battleground achievements listed below.", points=50, type="achievement"}}
A{"unknown", 230, criterion=226, side="alliance", trivia={criteria="Master of Alterac Valley", module="pvp", category="Player vs. Player", name="Battlemaster", description="Complete the battleground achievements listed below.", points=50, type="achievement"}}
A{"unknown", 230, criterion=229, side="alliance", trivia={criteria="Master of Warsong Gulch", module="pvp", category="Player vs. Player", name="Battlemaster", description="Complete the battleground achievements listed below.", points=50, type="achievement"}}
A{"unknown", 230, criterion=227, side="alliance", trivia={criteria="Master of Arathi Basin", module="pvp", category="Player vs. Player", name="Battlemaster", description="Complete the battleground achievements listed below.", points=50, type="achievement"}}
A{"unknown", 230, criterion=7640, side="alliance", trivia={criteria="Master of Strand of the Ancients", module="pvp", category="Player vs. Player", name="Battlemaster", description="Complete the battleground achievements listed below.", points=50, type="achievement"}}

-- Player vs. Player: Wrecking Ball
A{"unknown", 231, trivia={module="pvp", category="Player vs. Player", name="Wrecking Ball", description="Get 20 killing blows without dying in a single battle in any battleground.", points=10}}

-- Player vs. Player: An Honorable Kill
A{"unknown", 238, trivia={module="pvp", category="Player vs. Player", name="An Honorable Kill", description="Achieve an honorable kill.", points=10}}

-- Player vs. Player: 25000 Honorable Kills
A{"unknown", 239, criterion=13253, trivia={criteria="Get 25000 honorable kills", module="pvp", category="Player vs. Player", name="25000 Honorable Kills", description="Get 25000 honorable kills.", points=10, type=113}}

-- Player vs. Player: That Takes Class
A{"unknown", 245, criterion=2359, trivia={criteria="Death Knight", module="pvp", category="Player vs. Player", name="That Takes Class", description="Get an honorable, killing blow on one of each class.", points=10, type=52}}
A{"unknown", 245, criterion=2361, trivia={criteria="Hunter", module="pvp", category="Player vs. Player", name="That Takes Class", description="Get an honorable, killing blow on one of each class.", points=10, type=52}}
A{"unknown", 245, criterion=2362, trivia={criteria="Mage", module="pvp", category="Player vs. Player", name="That Takes Class", description="Get an honorable, killing blow on one of each class.", points=10, type=52}}
A{"unknown", 245, criterion=2363, trivia={criteria="Paladin", module="pvp", category="Player vs. Player", name="That Takes Class", description="Get an honorable, killing blow on one of each class.", points=10, type=52}}
A{"unknown", 245, criterion=2364, trivia={criteria="Priest", module="pvp", category="Player vs. Player", name="That Takes Class", description="Get an honorable, killing blow on one of each class.", points=10, type=52}}
A{"unknown", 245, criterion=2366, trivia={criteria="Shaman", module="pvp", category="Player vs. Player", name="That Takes Class", description="Get an honorable, killing blow on one of each class.", points=10, type=52}}
A{"unknown", 245, criterion=2367, trivia={criteria="Warlock", module="pvp", category="Player vs. Player", name="That Takes Class", description="Get an honorable, killing blow on one of each class.", points=10, type=52}}
A{"unknown", 245, criterion=2368, trivia={criteria="Warrior", module="pvp", category="Player vs. Player", name="That Takes Class", description="Get an honorable, killing blow on one of each class.", points=10, type=52}}
A{"unknown", 245, criterion=2365, trivia={criteria="Rogue", module="pvp", category="Player vs. Player", name="That Takes Class", description="Get an honorable, killing blow on one of each class.", points=10, type=52}}
A{"unknown", 245, criterion=2360, trivia={criteria="Druid", module="pvp", category="Player vs. Player", name="That Takes Class", description="Get an honorable, killing blow on one of each class.", points=10, type=52}}

-- Player vs. Player: Know Thy Enemy
A{"unknown", 246, criterion=2370, side="alliance", trivia={criteria="Orc", module="pvp", category="Player vs. Player", name="Know Thy Enemy", description="Get an honorable, killing blow on seven different races.", points=10, type=53}}
A{"unknown", 246, criterion=2372, side="alliance", trivia={criteria="Undead", module="pvp", category="Player vs. Player", name="Know Thy Enemy", description="Get an honorable, killing blow on seven different races.", points=10, type=53}}
A{"unknown", 246, criterion=2373, side="alliance", trivia={criteria="Troll", module="pvp", category="Player vs. Player", name="Know Thy Enemy", description="Get an honorable, killing blow on seven different races.", points=10, type=53}}
A{"unknown", 246, criterion=2371, side="alliance", trivia={criteria="Tauren", module="pvp", category="Player vs. Player", name="Know Thy Enemy", description="Get an honorable, killing blow on seven different races.", points=10, type=53}}
A{"unknown", 246, criterion=2369, side="alliance", trivia={criteria="Blood Elf", module="pvp", category="Player vs. Player", name="Know Thy Enemy", description="Get an honorable, killing blow on seven different races.", points=10, type=53}}
A{"unknown", 246, criterion=16764, side="alliance", trivia={criteria="Goblin", module="pvp", category="Player vs. Player", name="Know Thy Enemy", description="Get an honorable, killing blow on seven different races.", points=10, type=53}}
A{"unknown", 246, criterion=19207, side="alliance", trivia={criteria="Pandaren", module="pvp", category="Player vs. Player", name="Know Thy Enemy", description="Get an honorable, killing blow on seven different races.", points=10, type=53}}

-- Player vs. Player: Make Love, Not Warcraft
A{"unknown", 247, trivia={module="pvp", category="Player vs. Player", name="Make Love, Not Warcraft", description="Emote /hug on a dead enemy before they release corpse.", points=10}}

-- Player vs. Player: City Defender
A{"unknown", 388, criterion=0, side="alliance", trivia={criteria="Kill 50 enemy players in any of your home cities.", module="pvp", category="Player vs. Player", name="City Defender", description="Kill 50 enemy players in any of your home cities.", points=10}}

-- Player vs. Player/Arena: Step Into The Arena
A{"unknown", 397, trivia={module="pvp", category="Player vs. Player/Arena", name="Step Into The Arena", description="Win a ranked arena match.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Arena: Mercilessly Dedicated
A{"unknown", 398, criterion=306, trivia={criteria="Win 100 ranked arena matches", module="pvp", category="Player vs. Player/Arena", name="Mercilessly Dedicated", description="Win 100 ranked arena matches.", points=10, parent="Player vs. Player", type=37}}

-- Player vs. Player/Arena: Just the Two of Us: 1550
A{"unknown", 399, trivia={module="pvp", category="Player vs. Player/Arena", name="Just the Two of Us: 1550", description="Earn a 1550 personal rating in the 2v2 bracket of the arena.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Arena: Just the Two of Us: 1750
A{"unknown", 400, trivia={module="pvp", category="Player vs. Player/Arena", name="Just the Two of Us: 1750", description="Earn a 1750 personal rating in the 2v2 bracket of the arena.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Arena: Just the Two of Us: 2000
A{"unknown", 401, trivia={module="pvp", category="Player vs. Player/Arena", name="Just the Two of Us: 2000", description="Earn a 2000 personal rating in the 2v2 bracket of the arena.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Arena: Three's Company: 1550
A{"unknown", 402, trivia={module="pvp", category="Player vs. Player/Arena", name="Three's Company: 1550", description="Earn a 1550 personal rating in the 3v3 bracket of the arena.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Arena: Three's Company: 1750
A{"unknown", 403, trivia={module="pvp", category="Player vs. Player/Arena", name="Three's Company: 1750", description="Earn a 1750 personal rating in the 3v3 bracket of the arena.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Arena: High Five: 2000
A{"unknown", 404, trivia={module="pvp", category="Player vs. Player/Arena", name="High Five: 2000", description="Earn a 2000 personal rating in the 5v5 bracket of the arena.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Arena: Three's Company: 2000
A{"unknown", 405, trivia={module="pvp", category="Player vs. Player/Arena", name="Three's Company: 2000", description="Earn a 2000 personal rating in the 3v3 bracket of the arena.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Arena: High Five: 1550
A{"unknown", 406, trivia={module="pvp", category="Player vs. Player/Arena", name="High Five: 1550", description="Earn a 1550 personal rating in the 5v5 bracket of the arena.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Arena: High Five: 1750
A{"unknown", 407, trivia={module="pvp", category="Player vs. Player/Arena", name="High Five: 1750", description="Earn a 1750 personal rating in the 5v5 bracket of the arena.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Arena: Hot Streak
A{"unknown", 408, criterion=2408, trivia={criteria="Win 10 arenas without losing", module="pvp", category="Player vs. Player/Arena", name="Hot Streak", description="Win ten ranked matches in a row.", points=10, parent="Player vs. Player", type=37}}

-- Player vs. Player/Arena: Last Man Standing
A{"unknown", 409, trivia={module="pvp", category="Player vs. Player/Arena", name="Last Man Standing", description="Be the sole survivor at the end of a ranked 5v5 match.", points=10, parent="Player vs. Player"}}

-- Player vs. Player: 10000 Honorable Kills
A{"unknown", 509, criterion=13253, trivia={criteria="Get 10000 honorable kills", module="pvp", category="Player vs. Player", name="10000 Honorable Kills", description="Get 10000 honorable kills.", points=10, type=113}}

-- Player vs. Player: 5000 Honorable Kills
A{"unknown", 512, criterion=13253, trivia={criteria="Get 5000 honorable kills", module="pvp", category="Player vs. Player", name="5000 Honorable Kills", description="Get 5000 honorable kills.", points=10, type=113}}

-- Player vs. Player: 100 Honorable Kills
A{"unknown", 513, criterion=13253, trivia={criteria="Get 100 honorable kills", module="pvp", category="Player vs. Player", name="100 Honorable Kills", description="Get 100 honorable kills.", points=10, type=113}}

-- Player vs. Player: 500 Honorable Kills
A{"unknown", 515, criterion=13253, trivia={criteria="Get 500 honorable kills", module="pvp", category="Player vs. Player", name="500 Honorable Kills", description="Get 500 honorable kills.", points=10, type=113}}

-- Player vs. Player: 1000 Honorable Kills
A{"unknown", 516, criterion=13253, trivia={criteria="Get 1000 honorable kills", module="pvp", category="Player vs. Player", name="1000 Honorable Kills", description="Get 1000 honorable kills.", points=10, type=113}}

-- Player vs. Player: Freedom of the Horde
A{"unknown", 700, side="horde", trivia={module="pvp", category="Player vs. Player", name="Freedom of the Horde", description="Obtain an Insignia or Medallion of the Horde.", points=10}}

-- Player vs. Player: Freedom of the Alliance
A{"unknown", 701, side="alliance", trivia={module="pvp", category="Player vs. Player", name="Freedom of the Alliance", description="Obtain an Insignia or Medallion of the Alliance.", points=10}}

-- Player vs. Player: Call in the Cavalry
A{"unknown", 727, trivia={module="pvp", category="Player vs. Player", name="Call in the Cavalry", description="Obtain one of the war mounts through the honor system.", points=10}}

-- Player vs. Player: 50000 Honorable Kills
A{"unknown", 869, criterion=13253, trivia={criteria="Get 50000 honorable kills", module="pvp", category="Player vs. Player", name="50000 Honorable Kills", description="Get 50000 honorable kills.", points=10, type=113}}

-- Player vs. Player: 100000 Honorable Kills
A{"unknown", 870, criterion=13253, trivia={criteria="Get 100000 honorable kills", module="pvp", category="Player vs. Player", name="100000 Honorable Kills", description="Get 100000 honorable kills.", points=10, type=113}}

-- Player vs. Player/Arena: Vengefully Dedicated
A{"unknown", 875, criterion=306, trivia={criteria="Win 200 ranked arena matches", module="pvp", category="Player vs. Player/Arena", name="Vengefully Dedicated", description="Win 200 ranked arena matches.", points=10, parent="Player vs. Player", type=37}}

-- Player vs. Player/Arena: Brutally Dedicated
A{"unknown", 876, criterion=306, trivia={criteria="Win 300 ranked arena matches", module="pvp", category="Player vs. Player/Arena", name="Brutally Dedicated", description="Win 300 ranked arena matches.", points=10, parent="Player vs. Player", type=37}}

-- Player vs. Player: Call to Arms!
A{"unknown", 908, side="alliance", trivia={module="pvp", category="Player vs. Player", name="Call to Arms!", description="Complete 100 battlegrounds at max level.", points=10}}

-- Player vs. Player: Call to Arms!
A{"unknown", 909, side="horde", trivia={module="pvp", category="Player vs. Player", name="Call to Arms!", description="Complete 100 battlegrounds at max level.", points=10}}

-- Player vs. Player: Know Thy Enemy
A{"unknown", 1005, criterion=2375, side="horde", trivia={criteria="Human", module="pvp", category="Player vs. Player", name="Know Thy Enemy", description="Get an honorable, killing blow on seven different races.", points=10, type=53}}
A{"unknown", 1005, criterion=2376, side="horde", trivia={criteria="Gnome", module="pvp", category="Player vs. Player", name="Know Thy Enemy", description="Get an honorable, killing blow on seven different races.", points=10, type=53}}
A{"unknown", 1005, criterion=2377, side="horde", trivia={criteria="Dwarf", module="pvp", category="Player vs. Player", name="Know Thy Enemy", description="Get an honorable, killing blow on seven different races.", points=10, type=53}}
A{"unknown", 1005, criterion=2378, side="horde", trivia={criteria="Night Elf", module="pvp", category="Player vs. Player", name="Know Thy Enemy", description="Get an honorable, killing blow on seven different races.", points=10, type=53}}
A{"unknown", 1005, criterion=2374, side="horde", trivia={criteria="Draenei", module="pvp", category="Player vs. Player", name="Know Thy Enemy", description="Get an honorable, killing blow on seven different races.", points=10, type=53}}
A{"unknown", 1005, criterion=16765, side="horde", trivia={criteria="Worgen", module="pvp", category="Player vs. Player", name="Know Thy Enemy", description="Get an honorable, killing blow on seven different races.", points=10, type=53}}
A{"unknown", 1005, criterion=19208, side="horde", trivia={criteria="Pandaren", module="pvp", category="Player vs. Player", name="Know Thy Enemy", description="Get an honorable, killing blow on seven different races.", points=10, type=53}}

-- Player vs. Player: City Defender
A{"unknown", 1006, side="horde", trivia={module="pvp", category="Player vs. Player", name="City Defender", description="Kill 50 enemy players in any of your home cities.", points=10}}

-- Player vs. Player: Duel-icious
A{"unknown", 1157, trivia={module="pvp", category="Player vs. Player", name="Duel-icious", description="Win a duel against another player.", points=10}}

-- Player vs. Player/Arena: Just the Two of Us: 2200
A{"unknown", 1159, trivia={module="pvp", category="Player vs. Player/Arena", name="Just the Two of Us: 2200", description="Earn a 2200 personal rating in the 2v2 bracket of the arena.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Arena: Three's Company: 2200
A{"unknown", 1160, trivia={module="pvp", category="Player vs. Player/Arena", name="Three's Company: 2200", description="Earn a 2200 personal rating in the 3v3 bracket of the arena.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Arena: High Five: 2200
A{"unknown", 1161, trivia={module="pvp", category="Player vs. Player/Arena", name="High Five: 2200", description="Earn a 2200 personal rating in the 5v5 bracket of the arena.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Arena: Hotter Streak
A{"unknown", 1162, criterion=3384, trivia={criteria="Win 10 arenas without losing", module="pvp", category="Player vs. Player/Arena", name="Hotter Streak", description="Win ten ranked matches in a row with a personal rating above 1800.", points=10, parent="Player vs. Player", type=37}}

-- Player vs. Player/Arena: The Arena Master
A{"unknown", 1174, criterion=3496, trivia={criteria="Last Man Standing", module="pvp", category="Player vs. Player/Arena", name="The Arena Master", description="Complete the arena achievements listed below.", points=50, parent="Player vs. Player", type="achievement"}}
A{"unknown", 1174, criterion=3488, trivia={criteria="World Wide Winner", module="pvp", category="Player vs. Player/Arena", name="The Arena Master", description="Complete the arena achievements listed below.", points=50, parent="Player vs. Player", type="achievement"}}
A{"unknown", 1174, criterion=3494, trivia={criteria="Hotter Streak", module="pvp", category="Player vs. Player/Arena", name="The Arena Master", description="Complete the arena achievements listed below.", points=50, parent="Player vs. Player", type="achievement"}}
A{"unknown", 1174, criterion=3489, trivia={criteria="Brutally Dedicated", module="pvp", category="Player vs. Player/Arena", name="The Arena Master", description="Complete the arena achievements listed below.", points=50, parent="Player vs. Player", type="achievement"}}
A{"unknown", 1174, criterion=3492, trivia={criteria="High Five: 2200", module="pvp", category="Player vs. Player/Arena", name="The Arena Master", description="Complete the arena achievements listed below.", points=50, parent="Player vs. Player", type="achievement"}}
A{"unknown", 1174, criterion=3493, trivia={criteria="Hot Streak", module="pvp", category="Player vs. Player/Arena", name="The Arena Master", description="Complete the arena achievements listed below.", points=50, parent="Player vs. Player", type="achievement"}}
A{"unknown", 1174, criterion=3491, trivia={criteria="Three's Company: 2200", module="pvp", category="Player vs. Player/Arena", name="The Arena Master", description="Complete the arena achievements listed below.", points=50, parent="Player vs. Player", type="achievement"}}
A{"unknown", 1174, criterion=3490, trivia={criteria="Just the Two of Us: 2200", module="pvp", category="Player vs. Player/Arena", name="The Arena Master", description="Complete the arena achievements listed below.", points=50, parent="Player vs. Player", type="achievement"}}

-- Player vs. Player: Battlemaster
A{"unknown", 1175, criterion=227, side="horde", trivia={criteria="Master of Arathi Basin", module="pvp", category="Player vs. Player", name="Battlemaster", description="Complete the battleground achievements listed below.", points=50, type="achievement"}}
A{"unknown", 1175, criterion=7640, side="horde", trivia={criteria="Master of Strand of the Ancients", module="pvp", category="Player vs. Player", name="Battlemaster", description="Complete the battleground achievements listed below.", points=50, type="achievement"}}
A{"unknown", 1175, criterion=3503, side="horde", trivia={criteria="Master of Eye of the Storm", module="pvp", category="Player vs. Player", name="Battlemaster", description="Complete the battleground achievements listed below.", points=50, type="achievement"}}
A{"unknown", 1175, criterion=226, side="horde", trivia={criteria="Master of Alterac Valley", module="pvp", category="Player vs. Player", name="Battlemaster", description="Complete the battleground achievements listed below.", points=50, type="achievement"}}
A{"unknown", 1175, criterion=229, side="horde", trivia={criteria="Master of Warsong Gulch", module="pvp", category="Player vs. Player", name="Battlemaster", description="Complete the battleground achievements listed below.", points=50, type="achievement"}}

-- Player vs. Player/Arena: Challenger
A{"unknown", 2090, trivia={module="pvp", category="Player vs. Player/Arena", name="Challenger", description="Earn the Challenger title in an arena season.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Arena: Gladiator
A{"unknown", 2091, trivia={module="pvp", category="Player vs. Player/Arena", name="Gladiator", description="Earn the Gladiator title in an arena season.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Arena: Duelist
A{"unknown", 2092, trivia={module="pvp", category="Player vs. Player/Arena", name="Duelist", description="Earn the Duelist title in an arena season.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Arena: Rival
A{"unknown", 2093, trivia={module="pvp", category="Player vs. Player/Arena", name="Rival", description="Earn the Rival title in an arena season.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Battle for Gilneas: Battle for Gilneas Victory
A{"unknown", 5245, trivia={module="pvp", category="Player vs. Player/Battle for Gilneas", name="Battle for Gilneas Victory", description="Win Battle For Gilneas.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Battle for Gilneas: Battle for Gilneas Veteran
A{"unknown", 5246, criterion=16513, trivia={criteria="Complete 100 victories in the Battle For Gilneas.", module="pvp", category="Player vs. Player/Battle for Gilneas", name="Battle for Gilneas Veteran", description="Complete 100 victories in the Battle For Gilneas.", points=10, parent="Player vs. Player", type=1}}

-- Player vs. Player/Battle for Gilneas: Battle for Gilneas Perfection
A{"unknown", 5247, trivia={module="pvp", category="Player vs. Player/Battle for Gilneas", name="Battle for Gilneas Perfection", description="Win the Battle For Gilneas with a score of 2000 to 0.", points=20, parent="Player vs. Player"}}

-- Player vs. Player/Battle for Gilneas: Bustin' Caps to Make It Haps
A{"unknown", 5248, criterion=14929, trivia={criteria="Take 50 flags in the Battle for Gilneas.", module="pvp", category="Player vs. Player/Battle for Gilneas", name="Bustin' Caps to Make It Haps", description="Take 50 flags in the Battle for Gilneas.", points=10, parent="Player vs. Player", type=30}}

-- Player vs. Player/Battle for Gilneas: One Two Three You Don't Know About Me
A{"unknown", 5249, trivia={module="pvp", category="Player vs. Player/Battle for Gilneas", name="One Two Three You Don't Know About Me", description="Assault 2 bases in a single Battle for Gilneas.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Battle for Gilneas: Out of the Fog
A{"unknown", 5250, trivia={module="pvp", category="Player vs. Player/Battle for Gilneas", name="Out of the Fog", description="Defend 2 bases in a single Battle for Gilneas.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Battle for Gilneas: Not Your Average PUG'er
A{"unknown", 5251, criterion=14932, trivia={criteria="Defend 10 bases", module="pvp", category="Player vs. Player/Battle for Gilneas", name="Not Your Average PUG'er", description="Come to the defense of a base in the Battle for Gilneas 10 times by recapping the flag.", points=10, parent="Player vs. Player", type=30}}

-- Player vs. Player/Battle for Gilneas: Don't Get Cocky Kid
A{"unknown", 5252, trivia={module="pvp", category="Player vs. Player/Battle for Gilneas", name="Don't Get Cocky Kid", description="Overcome a 500 resource disadvantage in a match of the Battle for Gilneas and claim victory.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Battle for Gilneas: Full Coverage
A{"unknown", 5253, criterion=14943, trivia={criteria="Win 10 Battles for Gilneas while controlling all 3 flags", module="pvp", category="Player vs. Player/Battle for Gilneas", name="Full Coverage", description="Win 10 Battles for Gilneas while controlling all 3 flags.", points=10, parent="Player vs. Player", type=1}}

-- Player vs. Player/Battle for Gilneas: Newbs to Plowshares
A{"unknown", 5254, trivia={module="pvp", category="Player vs. Player/Battle for Gilneas", name="Newbs to Plowshares", description="Win the Battle for Gilneas in 6 minutes.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Battle for Gilneas: Jugger Not
A{"unknown", 5255, trivia={module="pvp", category="Player vs. Player/Battle for Gilneas", name="Jugger Not", description="Win the Battle for Gilneas by 100 points or less.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Battle for Gilneas: Battle for Gilneas All-Star
A{"unknown", 5256, criterion=14946, trivia={criteria="Assault a base", module="pvp", category="Player vs. Player/Battle for Gilneas", name="Battle for Gilneas All-Star", description="Assault and Defend a base in a single Battle for Gilneas.", points=20, parent="Player vs. Player", type=30}}
A{"unknown", 5256, criterion=14947, trivia={criteria="Defend a base", module="pvp", category="Player vs. Player/Battle for Gilneas", name="Battle for Gilneas All-Star", description="Assault and Defend a base in a single Battle for Gilneas.", points=20, parent="Player vs. Player", type=30}}

-- Player vs. Player/Battle for Gilneas: Battle for Gilneas Assassin
A{"unknown", 5257, criterion=14950, trivia={criteria="Kill 10 enemies at the Waterworks.", module="pvp", category="Player vs. Player/Battle for Gilneas", name="Battle for Gilneas Assassin", description="Get 10 honorable kills at each of the bases in a single Battle for Gilneas.", points=20, parent="Player vs. Player", type=31}}
A{"unknown", 5257, criterion=14949, trivia={criteria="Kill 10 enemies at the Mines.", module="pvp", category="Player vs. Player/Battle for Gilneas", name="Battle for Gilneas Assassin", description="Get 10 honorable kills at each of the bases in a single Battle for Gilneas.", points=20, parent="Player vs. Player", type=31}}
A{"unknown", 5257, criterion=14948, trivia={criteria="Kill 10 enemies at the Lighthouse.", module="pvp", category="Player vs. Player/Battle for Gilneas", name="Battle for Gilneas Assassin", description="Get 10 honorable kills at each of the bases in a single Battle for Gilneas.", points=20, parent="Player vs. Player", type=31}}

-- Player vs. Player/Battle for Gilneas: Master of the Battle for Gilneas
A{"unknown", 5258, criterion=14959, trivia={criteria="Don't Get Cocky Kid", module="pvp", category="Player vs. Player/Battle for Gilneas", name="Master of the Battle for Gilneas", description="Complete the Battle for Gilneas achievements listed below.", points=25, parent="Player vs. Player", type="achievement"}}
A{"unknown", 5258, criterion=14955, trivia={criteria="Bustin' Caps To Make It Haps", module="pvp", category="Player vs. Player/Battle for Gilneas", name="Master of the Battle for Gilneas", description="Complete the Battle for Gilneas achievements listed below.", points=25, parent="Player vs. Player", type="achievement"}}
A{"unknown", 5258, criterion=14957, trivia={criteria="Out Of The Fog", module="pvp", category="Player vs. Player/Battle for Gilneas", name="Master of the Battle for Gilneas", description="Complete the Battle for Gilneas achievements listed below.", points=25, parent="Player vs. Player", type="achievement"}}
A{"unknown", 5258, criterion=14963, trivia={criteria="Battle For Gilneas All-Star", module="pvp", category="Player vs. Player/Battle for Gilneas", name="Master of the Battle for Gilneas", description="Complete the Battle for Gilneas achievements listed below.", points=25, parent="Player vs. Player", type="achievement"}}
A{"unknown", 5258, criterion=14964, trivia={criteria="Battle For Gilneas Assassin", module="pvp", category="Player vs. Player/Battle for Gilneas", name="Master of the Battle for Gilneas", description="Complete the Battle for Gilneas achievements listed below.", points=25, parent="Player vs. Player", type="achievement"}}
A{"unknown", 5258, criterion=14953, trivia={criteria="Battle for Gilneas Veteran", module="pvp", category="Player vs. Player/Battle for Gilneas", name="Master of the Battle for Gilneas", description="Complete the Battle for Gilneas achievements listed below.", points=25, parent="Player vs. Player", type="achievement"}}
A{"unknown", 5258, criterion=14958, trivia={criteria="Not Your Average PUG'er", module="pvp", category="Player vs. Player/Battle for Gilneas", name="Master of the Battle for Gilneas", description="Complete the Battle for Gilneas achievements listed below.", points=25, parent="Player vs. Player", type="achievement"}}
A{"unknown", 5258, criterion=14962, trivia={criteria="Jugger Not", module="pvp", category="Player vs. Player/Battle for Gilneas", name="Master of the Battle for Gilneas", description="Complete the Battle for Gilneas achievements listed below.", points=25, parent="Player vs. Player", type="achievement"}}
A{"unknown", 5258, criterion=14961, trivia={criteria="Newbs To Plowshares", module="pvp", category="Player vs. Player/Battle for Gilneas", name="Master of the Battle for Gilneas", description="Complete the Battle for Gilneas achievements listed below.", points=25, parent="Player vs. Player", type="achievement"}}
A{"unknown", 5258, criterion=14954, trivia={criteria="Battle for Gilneas Perfection", module="pvp", category="Player vs. Player/Battle for Gilneas", name="Master of the Battle for Gilneas", description="Complete the Battle for Gilneas achievements listed below.", points=25, parent="Player vs. Player", type="achievement"}}
A{"unknown", 5258, criterion=14956, trivia={criteria="One Two Three You Don't Know About Me", module="pvp", category="Player vs. Player/Battle for Gilneas", name="Master of the Battle for Gilneas", description="Complete the Battle for Gilneas achievements listed below.", points=25, parent="Player vs. Player", type="achievement"}}
A{"unknown", 5258, criterion=14960, trivia={criteria="Full Coverage", module="pvp", category="Player vs. Player/Battle for Gilneas", name="Master of the Battle for Gilneas", description="Complete the Battle for Gilneas achievements listed below.", points=25, parent="Player vs. Player", type="achievement"}}
A{"unknown", 5258, criterion=14990, trivia={criteria="Double Rainbow", module="pvp", category="Player vs. Player/Battle for Gilneas", name="Master of the Battle for Gilneas", description="Complete the Battle for Gilneas achievements listed below.", points=25, parent="Player vs. Player", type="achievement"}}

-- Player vs. Player/Battle for Gilneas: Double Rainbow
A{"unknown", 5262, trivia={module="pvp", category="Player vs. Player/Battle for Gilneas", name="Double Rainbow", description="Perform a /gasp emote under the double rainbow in the Battle For Gilneas.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Arena: Three's Company: 2400
A{"unknown", 5266, trivia={module="pvp", category="Player vs. Player/Arena", name="Three's Company: 2400", description="Earn a 2400 personal rating in the 3v3 bracket of the arena.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Arena: Three's Company: 2700
A{"unknown", 5267, trivia={module="pvp", category="Player vs. Player/Arena", name="Three's Company: 2700", description="Earn a 2700 personal rating in the 3v3 bracket of the arena.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: In Service of the Alliance
A{"unknown", 5268, side="alliance", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="In Service of the Alliance", description="Win a rated battleground.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: In Service of the Horde
A{"unknown", 5269, side="horde", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="In Service of the Horde", description="Win a rated battleground.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: In Service of the Alliance
A{"unknown", 5322, criterion=15289, side="alliance", trivia={criteria="Win 10 rated battlegrounds", module="pvp", category="Player vs. Player/Rated Battleground", name="In Service of the Alliance", description="Win 10 rated battlegrounds.", points=10, parent="Player vs. Player", type=130}}

-- Player vs. Player/Rated Battleground: In Service of the Horde
A{"unknown", 5323, criterion=15289, side="horde", trivia={criteria="Win 10 rated battlegrounds", module="pvp", category="Player vs. Player/Rated Battleground", name="In Service of the Horde", description="Win 10 rated battlegrounds.", points=10, parent="Player vs. Player", type=130}}

-- Player vs. Player/Rated Battleground: In Service of the Horde
A{"unknown", 5324, criterion=15289, side="horde", trivia={criteria="Win 25 rated battlegrounds", module="pvp", category="Player vs. Player/Rated Battleground", name="In Service of the Horde", description="Win 25 rated battlegrounds.", points=10, parent="Player vs. Player", type=130}}

-- Player vs. Player/Rated Battleground: Veteran of the Horde
A{"unknown", 5325, criterion=15289, side="horde", trivia={criteria="Win 75 rated battlegrounds", module="pvp", category="Player vs. Player/Rated Battleground", name="Veteran of the Horde", description="Win 75 rated battlegrounds.", points=10, parent="Player vs. Player", type=130}}

-- Player vs. Player/Rated Battleground: Warbringer of the Horde
A{"unknown", 5326, criterion=15289, side="horde", trivia={criteria="Win 300 rated battlegrounds", module="pvp", category="Player vs. Player/Rated Battleground", name="Warbringer of the Horde", description="Win 300 rated battlegrounds.", points=10, parent="Player vs. Player", type=130}}

-- Player vs. Player/Rated Battleground: In Service of the Alliance
A{"unknown", 5327, criterion=15289, side="alliance", trivia={criteria="Win 25 rated battlegrounds", module="pvp", category="Player vs. Player/Rated Battleground", name="In Service of the Alliance", description="Win 25 rated battlegrounds.", points=10, parent="Player vs. Player", type=130}}

-- Player vs. Player/Rated Battleground: Veteran of the Alliance
A{"unknown", 5328, criterion=15289, side="alliance", trivia={criteria="Win 75 rated battlegrounds", module="pvp", category="Player vs. Player/Rated Battleground", name="Veteran of the Alliance", description="Win 75 rated battlegrounds.", points=10, parent="Player vs. Player", type=130}}

-- Player vs. Player/Rated Battleground: Warbound Veteran of the Alliance
A{"unknown", 5329, criterion=15289, side="alliance", trivia={criteria="Win 300 rated battlegrounds", module="pvp", category="Player vs. Player/Rated Battleground", name="Warbound Veteran of the Alliance", description="Win 300 rated battlegrounds.", points=10, parent="Player vs. Player", type=130}}

-- Player vs. Player/Rated Battleground: Private
A{"unknown", 5330, side="alliance", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="Private", description="Earn a battleground rating of 1100.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: Corporal
A{"unknown", 5331, side="alliance", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="Corporal", description="Earn a battleground rating of 1200.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: Sergeant
A{"unknown", 5332, side="alliance", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="Sergeant", description="Earn a battleground rating of 1300.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: Master Sergeant
A{"unknown", 5333, side="alliance", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="Master Sergeant", description="Earn a battleground rating of 1400.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: Sergeant Major
A{"unknown", 5334, side="alliance", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="Sergeant Major", description="Earn a battleground rating of 1500.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: Knight
A{"unknown", 5335, side="alliance", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="Knight", description="Earn a battleground rating of 1600.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: Knight-Lieutenant
A{"unknown", 5336, side="alliance", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="Knight-Lieutenant", description="Earn a battleground rating of 1700.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: Knight-Captain
A{"unknown", 5337, side="alliance", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="Knight-Captain", description="Earn a battleground rating of 1800.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: Centurion
A{"unknown", 5338, side="horde", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="Centurion", description="Earn a battleground rating of 1900.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: Lieutenant Commander
A{"unknown", 5339, side="alliance", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="Lieutenant Commander", description="Earn a battleground rating of 2000.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: Commander
A{"unknown", 5340, side="alliance", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="Commander", description="Earn a battleground rating of 2100.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: Marshal
A{"unknown", 5341, side="alliance", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="Marshal", description="Earn a battleground rating of 2200.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: Warlord
A{"unknown", 5342, side="horde", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="Warlord", description="Earn a battleground rating of 2300.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: Grand Marshal
A{"unknown", 5343, side="alliance", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="Grand Marshal", description="Earn a battleground rating of 2400.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: Scout
A{"unknown", 5345, side="horde", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="Scout", description="Earn a battleground rating of 1100.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: Grunt
A{"unknown", 5346, side="horde", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="Grunt", description="Earn a battleground rating of 1200.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: Sergeant
A{"unknown", 5347, side="horde", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="Sergeant", description="Earn a battleground rating of 1300.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: Senior Sergeant
A{"unknown", 5348, side="horde", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="Senior Sergeant", description="Earn a battleground rating of 1400.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: First Sergeant
A{"unknown", 5349, side="horde", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="First Sergeant", description="Earn a battleground rating of 1500.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: Stone Guard
A{"unknown", 5350, side="horde", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="Stone Guard", description="Earn a battleground rating of 1600.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: Blood Guard
A{"unknown", 5351, side="horde", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="Blood Guard", description="Earn a battleground rating of 1700.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: Legionnaire
A{"unknown", 5352, side="horde", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="Legionnaire", description="Earn a battleground rating of 1800.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: Champion
A{"unknown", 5353, side="horde", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="Champion", description="Earn a battleground rating of 2000.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: Lieutenant General
A{"unknown", 5354, side="horde", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="Lieutenant General", description="Earn a battleground rating of 2100.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: General
A{"unknown", 5355, side="horde", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="General", description="Earn a battleground rating of 2200.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: High Warlord
A{"unknown", 5356, side="horde", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="High Warlord", description="Earn a battleground rating of 2400.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: Field Marshal
A{"unknown", 5357, side="alliance", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="Field Marshal", description="Earn a battleground rating of 2300.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: Knight-Champion
A{"unknown", 5359, side="alliance", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="Knight-Champion", description="Earn a battleground rating of 1900.", points=10, parent="Player vs. Player"}}

-- Player vs. Player: 250000 Honorable Kills
A{"unknown", 5363, criterion=13253, trivia={criteria="Get 250000 honorable kills", module="pvp", category="Player vs. Player", name="250000 Honorable Kills", description="Get 250000 honorable kills.", points=10, type=113}}

-- Player vs. Player/Tol Barad: Tol Barad Victory
A{"unknown", 5412, trivia={module="pvp", category="Player vs. Player/Tol Barad", name="Tol Barad Victory", description="Win the battle for Tol Barad.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Tol Barad: Tower Plower
A{"unknown", 5415, trivia={module="pvp", category="Player vs. Player/Tol Barad", name="Tower Plower", description="Destroy a tower in Tol Barad.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Tol Barad: Tol Barad Veteran
A{"unknown", 5417, criterion=15458, side="alliance", trivia={criteria="Win Tol Barad 25 times", module="pvp", category="Player vs. Player/Tol Barad", name="Tol Barad Veteran", description="Win 25 battles for Tol Barad.", points=10, parent="Player vs. Player", type=28}}

-- Player vs. Player/Tol Barad: Tol Barad Veteran
A{"unknown", 5418, criterion=15464, side="horde", trivia={criteria="Win Tol Barad 25 times", module="pvp", category="Player vs. Player/Tol Barad", name="Tol Barad Veteran", description="Win 25 battles for Tol Barad.", points=10, parent="Player vs. Player", type=28}}

-- Player vs. Player/Tol Barad: Tol Barad All-Star
A{"unknown", 5486, criterion=15967, trivia={criteria="Get 10 honorable kills at the Slagworks", module="pvp", category="Player vs. Player/Tol Barad", name="Tol Barad All-Star", description="Get 10 honorable kills at the Ironclad Garrison, Warden's Vigil, and Slagworks.", points=10, parent="Player vs. Player", type=35}}
A{"unknown", 5486, criterion=15965, trivia={criteria="Get 10 honorable kills at the Ironclad Garrison", module="pvp", category="Player vs. Player/Tol Barad", name="Tol Barad All-Star", description="Get 10 honorable kills at the Ironclad Garrison, Warden's Vigil, and Slagworks.", points=10, parent="Player vs. Player", type=35}}
A{"unknown", 5486, criterion=15966, trivia={criteria="Get 10 honorable kills at the Warden's Vigil", module="pvp", category="Player vs. Player/Tol Barad", name="Tol Barad All-Star", description="Get 10 honorable kills at the Ironclad Garrison, Warden's Vigil, and Slagworks.", points=10, parent="Player vs. Player", type=35}}

-- Player vs. Player/Tol Barad: Tol Barad Saboteur
A{"unknown", 5487, criterion=15968, trivia={criteria="Destroy 20 deployed Siege Engines", module="pvp", category="Player vs. Player/Tol Barad", name="Tol Barad Saboteur", description="Destroy 20 deployed Siege Engines.", points=10, parent="Player vs. Player", type="slay"}}

-- Player vs. Player/Tol Barad: Towers of Power
A{"unknown", 5488, criterion=15969, trivia={criteria="Destroy 3 Siege Engines in a single battle", module="pvp", category="Player vs. Player/Tol Barad", name="Towers of Power", description="Destroy 3 Siege Engines in a single Tol Barad battle.", points=10, parent="Player vs. Player", type="slay"}}

-- Player vs. Player/Tol Barad: Master of Tol Barad
A{"unknown", 5489, criterion=15972, side="alliance", trivia={criteria="Tower Plower", module="pvp", category="Player vs. Player/Tol Barad", name="Master of Tol Barad", description="Complete the Tol Barad achievements listed below.", points=10, parent="Player vs. Player", type="achievement"}}
A{"unknown", 5489, criterion=15974, side="alliance", trivia={criteria="Tol Barad Saboteur", module="pvp", category="Player vs. Player/Tol Barad", name="Master of Tol Barad", description="Complete the Tol Barad achievements listed below.", points=10, parent="Player vs. Player", type="achievement"}}
A{"unknown", 5489, criterion=15975, side="alliance", trivia={criteria="Tol Barad All-Star", module="pvp", category="Player vs. Player/Tol Barad", name="Master of Tol Barad", description="Complete the Tol Barad achievements listed below.", points=10, parent="Player vs. Player", type="achievement"}}
A{"unknown", 5489, criterion=15973, side="alliance", trivia={criteria="Towers of Power", module="pvp", category="Player vs. Player/Tol Barad", name="Master of Tol Barad", description="Complete the Tol Barad achievements listed below.", points=10, parent="Player vs. Player", type="achievement"}}
A{"unknown", 5489, criterion=15970, side="alliance", trivia={criteria="Tol Barad Veteran", module="pvp", category="Player vs. Player/Tol Barad", name="Master of Tol Barad", description="Complete the Tol Barad achievements listed below.", points=10, parent="Player vs. Player", type="achievement"}}

-- Player vs. Player/Tol Barad: Master of Tol Barad
A{"unknown", 5490, criterion=15975, side="horde", trivia={criteria="Tol Barad All-Star", module="pvp", category="Player vs. Player/Tol Barad", name="Master of Tol Barad", description="Complete the Tol Barad achievements listed below.", points=10, parent="Player vs. Player", type="achievement"}}
A{"unknown", 5490, criterion=15972, side="horde", trivia={criteria="Tower Plower", module="pvp", category="Player vs. Player/Tol Barad", name="Master of Tol Barad", description="Complete the Tol Barad achievements listed below.", points=10, parent="Player vs. Player", type="achievement"}}
A{"unknown", 5490, criterion=15976, side="horde", trivia={criteria="Pit Lord Argaloth", module="pvp", category="Player vs. Player/Tol Barad", name="Master of Tol Barad", description="Complete the Tol Barad achievements listed below.", points=10, parent="Player vs. Player", type="achievement"}}
A{"unknown", 5490, criterion=15973, side="horde", trivia={criteria="Towers of Power", module="pvp", category="Player vs. Player/Tol Barad", name="Master of Tol Barad", description="Complete the Tol Barad achievements listed below.", points=10, parent="Player vs. Player", type="achievement"}}
A{"unknown", 5490, criterion=15974, side="horde", trivia={criteria="Tol Barad Saboteur", module="pvp", category="Player vs. Player/Tol Barad", name="Master of Tol Barad", description="Complete the Tol Barad achievements listed below.", points=10, parent="Player vs. Player", type="achievement"}}
A{"unknown", 5490, criterion=15977, side="horde", trivia={criteria="Tol Barad Veteran", module="pvp", category="Player vs. Player/Tol Barad", name="Master of Tol Barad", description="Complete the Tol Barad achievements listed below.", points=10, parent="Player vs. Player", type="achievement"}}

-- Player vs. Player: 50,000 Conquest Points
A{"unknown", 5539, trivia={module="pvp", category="Player vs. Player", name="50,000 Conquest Points", description="Earn 50,000 Conquest Points", points=10}}

-- Player vs. Player: 25,000 Conquest Points
A{"unknown", 5540, trivia={module="pvp", category="Player vs. Player", name="25,000 Conquest Points", description="Earn 25,000 Conquest Points", points=10}}

-- Player vs. Player: 5000 Conquest Points
A{"unknown", 5541, trivia={module="pvp", category="Player vs. Player", name="5000 Conquest Points", description="Earn 5000 Conquest Points", points=10}}

-- Player vs. Player: 1000 Conquest Points
A{"unknown", 5542, criterion=16309, trivia={module="pvp", category="Player vs. Player", name="1000 Conquest Points", description="Earn 1000 Conquest Points", points=10}}

-- Player vs. Player/Tol Barad: Just Another Day in Tol Barad
A{"unknown", 5718, criterion=16683, side="alliance", trivia={criteria="Rattling Their Cages", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16684, side="alliance", trivia={criteria="Boosting Morale", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16685, side="alliance", trivia={criteria="Shark Tank", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16682, side="alliance", trivia={criteria="Captain P. Harris", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16687, side="alliance", trivia={criteria="Leave No Weapon Behind", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16696, side="alliance", trivia={criteria="Teach A Man To Fish... Or Steal.", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16697, side="alliance", trivia={criteria="Thinning The Brood", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16700, side="alliance", trivia={criteria="Finish The Job", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16702, side="alliance", trivia={criteria="WANTED: Foreman Wellson", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16703, side="alliance", trivia={criteria="Bombs Away!", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16705, side="alliance", trivia={criteria="The Imprisoned Archmage", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16706, side="alliance", trivia={criteria="Learning From The Past", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16707, side="alliance", trivia={criteria="D-Block", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16708, side="alliance", trivia={criteria="Svarnos", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16710, side="alliance", trivia={criteria="Prison Revolt", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16712, side="alliance", trivia={criteria="Food From Below", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16686, side="alliance", trivia={criteria="Claiming The Keep", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16689, side="alliance", trivia={criteria="The Forgotten", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16692, side="alliance", trivia={criteria="Ghostbuster", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16691, side="alliance", trivia={criteria="First Lieutenant Connor", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16695, side="alliance", trivia={criteria="Not the Friendliest Town", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16694, side="alliance", trivia={criteria="Taking the Overlook Back", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16693, side="alliance", trivia={criteria="Cannonball!", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16701, side="alliance", trivia={criteria="Watch Out For Splinters!", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16713, side="alliance", trivia={criteria="A Huge Problem", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16698, side="alliance", trivia={criteria="A Sticky Task", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16709, side="alliance", trivia={criteria="Cursed Shackles", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16714, side="alliance", trivia={criteria="Swamp Bait", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16711, side="alliance", trivia={criteria="The Warden", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16704, side="alliance", trivia={criteria="Clearing the Depths", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16715, side="alliance", trivia={criteria="The Leftovers", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16699, side="alliance", trivia={criteria="Magnets, How Do They Work?", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5718, criterion=16690, side="alliance", trivia={criteria="Salvaging the Remains", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}

-- Player vs. Player/Tol Barad: Just Another Day in Tol Barad
A{"unknown", 5719, criterion=16717, side="horde", trivia={criteria="Rattling Their Cages", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16720, side="horde", trivia={criteria="Claiming The Keep", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16723, side="horde", trivia={criteria="The Forgotten", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16724, side="horde", trivia={criteria="Salvaging the Remains", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16725, side="horde", trivia={criteria="First Lieutenant Connor", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16726, side="horde", trivia={criteria="Ghostbuster", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16728, side="horde", trivia={criteria="Taking the Overlook Back", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16732, side="horde", trivia={criteria="A Sticky Task", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16734, side="horde", trivia={criteria="Finish The Job", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16737, side="horde", trivia={criteria="Bombs Away!", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16740, side="horde", trivia={criteria="Learning From The Past", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16741, side="horde", trivia={criteria="D-Block", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16742, side="horde", trivia={criteria="Svarnos", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16745, side="horde", trivia={criteria="The Warden", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16746, side="horde", trivia={criteria="Food From Below", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16747, side="horde", trivia={criteria="A Huge Problem", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16749, side="horde", trivia={criteria="The Leftovers", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16716, side="horde", trivia={criteria="Captain P. Harris", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16733, side="horde", trivia={criteria="Magnets, How Do They Work?", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16739, side="horde", trivia={criteria="The Imprisoned Archmage", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16727, side="horde", trivia={criteria="Cannonball!", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16735, side="horde", trivia={criteria="Watch Out For Splinters!", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16748, side="horde", trivia={criteria="Swamp Bait", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16738, side="horde", trivia={criteria="Clearing the Depths", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16729, side="horde", trivia={criteria="Not the Friendliest Town", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16736, side="horde", trivia={criteria="WANTED: Foreman Wellson", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16731, side="horde", trivia={criteria="Thinning The Brood", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16718, side="horde", trivia={criteria="Boosting Morale", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16744, side="horde", trivia={criteria="Prison Revolt", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16719, side="horde", trivia={criteria="Shark Tank", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16743, side="horde", trivia={criteria="Cursed Shackles", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16721, side="horde", trivia={criteria="Leave No Weapon Behind", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}
A{"unknown", 5719, criterion=16730, side="horde", trivia={criteria="Teach A Man To Fish... Or Steal.", module="pvp", category="Player vs. Player/Tol Barad", name="Just Another Day in Tol Barad", description="Complete all of the Tol Barad daily quests listed below.", points=10, parent="Player vs. Player", type="quest"}}

-- Player vs. Player/Rated Battleground: Veteran of the Alliance II
A{"unknown", 5823, criterion=15289, side="alliance", trivia={criteria="Win 150 rated battlegrounds", module="pvp", category="Player vs. Player/Rated Battleground", name="Veteran of the Alliance II", description="Win 150 rated battlegrounds.", points=10, parent="Player vs. Player", type=130}}

-- Player vs. Player/Rated Battleground: Veteran of the Horde II
A{"unknown", 5824, criterion=15289, side="horde", trivia={criteria="Win 150 rated battlegrounds", module="pvp", category="Player vs. Player/Rated Battleground", name="Veteran of the Horde II", description="Win 150 rated battlegrounds.", points=10, parent="Player vs. Player", type=130}}

-- Player vs. Player/Tol Barad: Alizabal
A{"unknown", 6108, trivia={module="pvp", category="Player vs. Player/Tol Barad", name="Alizabal", description="Defeat Alizabal.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Silvershard Mines: Silvershard Mines Victory
A{"unknown", 6739, trivia={module="pvp", category="Player vs. Player/Silvershard Mines", name="Silvershard Mines Victory", description="Win Silvershard Mines.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Temple of Kotmogu: Temple of Kotmogu Victory
A{"unknown", 6740, trivia={module="pvp", category="Player vs. Player/Temple of Kotmogu", name="Temple of Kotmogu Victory", description="Win Temple of Kotmogu.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Temple of Kotmogu: Temple of Kotmogu Veteran
A{"unknown", 6882, criterion=19660, trivia={criteria="Complete 100 victories in Temple of Kotmogu", module="pvp", category="Player vs. Player/Temple of Kotmogu", name="Temple of Kotmogu Veteran", description="Complete 100 victories in Temple of Kotmogu.", points=10, parent="Player vs. Player", type=1}}

-- Player vs. Player/Silvershard Mines: Silvershard Mines Veteran
A{"unknown", 6883, criterion=19659, trivia={criteria="Complete 100 victories in Silvershard Mines", module="pvp", category="Player vs. Player/Silvershard Mines", name="Silvershard Mines Veteran", description="Complete 100 victories in Silvershard Mines.", points=10, parent="Player vs. Player", type=1}}

-- Player vs. Player/Rated Battleground: Hero of the Horde
A{"unknown", 6941, side="horde", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="Hero of the Horde", description="End a PvP season in the top 0.5% of the rated battleground ladder (requires 50 games won in the current season).", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Rated Battleground: Hero of the Alliance
A{"unknown", 6942, side="alliance", trivia={module="pvp", category="Player vs. Player/Rated Battleground", name="Hero of the Alliance", description="End a PvP season in the top 0.5% of the rated battleground ladder (requires 50 games won in the current season).", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Temple of Kotmogu: Four Square
A{"unknown", 6947, criterion=20064, trivia={criteria="Cyan Orb", module="pvp", category="Player vs. Player/Temple of Kotmogu", name="Four Square", description="Hold all four Orbs of Power at least once in a single Temple of Kotmogu battle.", points=10, parent="Player vs. Player", type=69}}
A{"unknown", 6947, criterion=20065, trivia={criteria="Purple Orb", module="pvp", category="Player vs. Player/Temple of Kotmogu", name="Four Square", description="Hold all four Orbs of Power at least once in a single Temple of Kotmogu battle.", points=10, parent="Player vs. Player", type=69}}
A{"unknown", 6947, criterion=20066, trivia={criteria="Green Orb", module="pvp", category="Player vs. Player/Temple of Kotmogu", name="Four Square", description="Hold all four Orbs of Power at least once in a single Temple of Kotmogu battle.", points=10, parent="Player vs. Player", type=69}}
A{"unknown", 6947, criterion=20067, trivia={criteria="Orange Orb", module="pvp", category="Player vs. Player/Temple of Kotmogu", name="Four Square", description="Hold all four Orbs of Power at least once in a single Temple of Kotmogu battle.", points=10, parent="Player vs. Player", type=69}}

-- Player vs. Player/Temple of Kotmogu: Powerball
A{"unknown", 6950, trivia={module="pvp", category="Player vs. Player/Temple of Kotmogu", name="Powerball", description="Hold an Orb of Power in the center of the Temple of Kotmogu for 90 seconds.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Temple of Kotmogu: Blackout
A{"unknown", 6970, criterion=20104, trivia={criteria="Power Orb", module="pvp", category="Player vs. Player/Temple of Kotmogu", name="Blackout", description="Kill 100 enemies that are holding an Orb of Power.", points=10, parent="Player vs. Player", type=28}}

-- Player vs. Player/Temple of Kotmogu: I've Got the Power
A{"unknown", 6971, trivia={module="pvp", category="Player vs. Player/Temple of Kotmogu", name="I've Got the Power", description="Win Temple of Kotmogu while controlling all 4 Orbs of Power.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Temple of Kotmogu: What is Best in Life?
A{"unknown", 6972, criterion=20988, trivia={module="pvp", category="Player vs. Player/Temple of Kotmogu", name="What is Best in Life?", description="Earn 8,000 Victory Points for your team in Temple of Kotmogu.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Temple of Kotmogu: Can't Stop Won't Stop
A{"unknown", 6973, criterion=20124, trivia={module="pvp", category="Player vs. Player/Temple of Kotmogu", name="Can't Stop Won't Stop", description="Kill 100 enemies while holding an Orb of Power.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Temple of Kotmogu: Temple of Kotmogu All-Star
A{"unknown", 6980, criterion=21027, trivia={criteria="Kill four Orb carriers.", module="pvp", category="Player vs. Player/Temple of Kotmogu", name="Temple of Kotmogu All-Star", description="Hold four Orbs of Power and kill four enemies who are holding an Orb of Power in a single Temple of Kotmogu match.", points=10, parent="Player vs. Player", type=28}}
A{"unknown", 6980, criterion=21028, trivia={criteria="Four Orbs Controlled", module="pvp", category="Player vs. Player/Temple of Kotmogu", name="Temple of Kotmogu All-Star", description="Hold four Orbs of Power and kill four enemies who are holding an Orb of Power in a single Temple of Kotmogu match.", points=10, parent="Player vs. Player", type=69}}

-- Player vs. Player/Temple of Kotmogu: Master of Temple of Kotmogu
A{"unknown", 6981, criterion=20794, trivia={criteria="Temple of Kotmogu Veteran", module="pvp", category="Player vs. Player/Temple of Kotmogu", name="Master of Temple of Kotmogu", description="Complete the Temple of Kotmogu achievements listed below.", points=10, parent="Player vs. Player", type="achievement"}}
A{"unknown", 6981, criterion=20795, trivia={criteria="Four Square", module="pvp", category="Player vs. Player/Temple of Kotmogu", name="Master of Temple of Kotmogu", description="Complete the Temple of Kotmogu achievements listed below.", points=10, parent="Player vs. Player", type="achievement"}}
A{"unknown", 6981, criterion=20796, trivia={criteria="Powerball", module="pvp", category="Player vs. Player/Temple of Kotmogu", name="Master of Temple of Kotmogu", description="Complete the Temple of Kotmogu achievements listed below.", points=10, parent="Player vs. Player", type="achievement"}}
A{"unknown", 6981, criterion=20797, trivia={criteria="Blackout", module="pvp", category="Player vs. Player/Temple of Kotmogu", name="Master of Temple of Kotmogu", description="Complete the Temple of Kotmogu achievements listed below.", points=10, parent="Player vs. Player", type="achievement"}}
A{"unknown", 6981, criterion=20798, trivia={criteria="Can't Stop Won't Stop", module="pvp", category="Player vs. Player/Temple of Kotmogu", name="Master of Temple of Kotmogu", description="Complete the Temple of Kotmogu achievements listed below.", points=10, parent="Player vs. Player", type="achievement"}}
A{"unknown", 6981, criterion=20799, trivia={criteria="I've Got the Power", module="pvp", category="Player vs. Player/Temple of Kotmogu", name="Master of Temple of Kotmogu", description="Complete the Temple of Kotmogu achievements listed below.", points=10, parent="Player vs. Player", type="achievement"}}
A{"unknown", 6981, criterion=20800, trivia={criteria="What is Best in Life?", module="pvp", category="Player vs. Player/Temple of Kotmogu", name="Master of Temple of Kotmogu", description="Complete the Temple of Kotmogu achievements listed below.", points=10, parent="Player vs. Player", type="achievement"}}
A{"unknown", 6981, criterion=20801, trivia={criteria="Temple of Kogmogu All-Star", module="pvp", category="Player vs. Player/Temple of Kotmogu", name="Master of Temple of Kotmogu", description="Complete the Temple of Kotmogu achievements listed below.", points=10, parent="Player vs. Player", type="achievement"}}

-- Player vs. Player/Silvershard Mines: The Long Riders
A{"unknown", 7039, trivia={module="pvp", category="Player vs. Player/Silvershard Mines", name="The Long Riders", description="Escort a mine cart from its spawn to a depot and capture it without losing control.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Silvershard Mines: Mine Cart Courier
A{"unknown", 7049, criterion=21009, trivia={criteria="East to South Track", module="pvp", category="Player vs. Player/Silvershard Mines", name="Mine Cart Courier", description="Capture a mine cart using each of the 5 sets of tracks in a single Silvershard Mines match.", points=10, parent="Player vs. Player", type=28}}
A{"unknown", 7049, criterion=21010, trivia={criteria="East to North Track", module="pvp", category="Player vs. Player/Silvershard Mines", name="Mine Cart Courier", description="Capture a mine cart using each of the 5 sets of tracks in a single Silvershard Mines match.", points=10, parent="Player vs. Player", type=28}}
A{"unknown", 7049, criterion=21011, trivia={criteria="North to West Track", module="pvp", category="Player vs. Player/Silvershard Mines", name="Mine Cart Courier", description="Capture a mine cart using each of the 5 sets of tracks in a single Silvershard Mines match.", points=10, parent="Player vs. Player", type=28}}
A{"unknown", 7049, criterion=21012, trivia={criteria="North to East Track", module="pvp", category="Player vs. Player/Silvershard Mines", name="Mine Cart Courier", description="Capture a mine cart using each of the 5 sets of tracks in a single Silvershard Mines match.", points=10, parent="Player vs. Player", type=28}}
A{"unknown", 7049, criterion=21013, trivia={criteria="South Track", module="pvp", category="Player vs. Player/Silvershard Mines", name="Mine Cart Courier", description="Capture a mine cart using each of the 5 sets of tracks in a single Silvershard Mines match.", points=10, parent="Player vs. Player", type=28}}

-- Player vs. Player/Silvershard Mines: End of the Line
A{"unknown", 7057, trivia={module="pvp", category="Player vs. Player/Silvershard Mines", name="End of the Line", description="Seize control of a mine cart that is controlled by the opposing team within 20 yards of the depot, and then capture it.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Silvershard Mines: Mine Mine Mine!
A{"unknown", 7062, criterion=20989, trivia={module="pvp", category="Player vs. Player/Silvershard Mines", name="Mine Mine Mine!", description="Kill 250 enemies while you are defending a mine cart.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Silvershard Mines: Five for Five
A{"unknown", 7099, trivia={module="pvp", category="Player vs. Player/Silvershard Mines", name="Five for Five", description="Capture five mine carts in a single Silvershard Mines battle without dying.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Silvershard Mines: My Diamonds and Your Rust
A{"unknown", 7100, trivia={module="pvp", category="Player vs. Player/Silvershard Mines", name="My Diamonds and Your Rust", description="Win a Silvershard Mines battle without letting the enemy team capture a mine cart.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Silvershard Mines: Escort Service
A{"unknown", 7102, criterion=20992, trivia={criteria="Carts Capped", module="pvp", category="Player vs. Player/Silvershard Mines", name="Escort Service", description="Capture 100 mine carts in Silvershard Mines.", points=10, parent="Player vs. Player", type=30}}

-- Player vs. Player/Silvershard Mines: Greed is Good
A{"unknown", 7103, trivia={module="pvp", category="Player vs. Player/Silvershard Mines", name="Greed is Good", description="Gain both the Berserking and Restoration buffs at the same time in Silvershard Mines.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Silvershard Mines: Master of Silvershard Mines
A{"unknown", 7106, criterion=20785, trivia={module="pvp", category="Player vs. Player/Silvershard Mines", name="Master of Silvershard Mines", description="Complete the Silvershard Mines achievements listed below.", points=10, parent="Player vs. Player"}}

-- Player vs. Player: Khan
A{"unknown", 8052, criterion=22722, side="alliance", trivia={criteria="Master of the Battle for Gilneas", module="pvp", category="Player vs. Player", name="Khan", description="Complete the battleground achievements listed below.", points=50, type="achievement"}}
A{"unknown", 8052, criterion=22723, side="alliance", trivia={criteria="Master of Isle of Conquest", module="pvp", category="Player vs. Player", name="Khan", description="Complete the battleground achievements listed below.", points=50, type="achievement"}}
A{"unknown", 8052, criterion=22724, side="alliance", trivia={criteria="Master of Twin Peaks", module="pvp", category="Player vs. Player", name="Khan", description="Complete the battleground achievements listed below.", points=50, type="achievement"}}
A{"unknown", 8052, criterion=22725, side="alliance", trivia={criteria="Master of Silvershard Mines", module="pvp", category="Player vs. Player", name="Khan", description="Complete the battleground achievements listed below.", points=50, type="achievement"}}
A{"unknown", 8052, criterion=22726, side="alliance", trivia={criteria="Master of Temple of Kotmogu", module="pvp", category="Player vs. Player", name="Khan", description="Complete the battleground achievements listed below.", points=50, type="achievement"}}

-- Player vs. Player: Khan
A{"unknown", 8055, criterion=22722, side="horde", trivia={criteria="Master of the Battle for Gilneas", module="pvp", category="Player vs. Player", name="Khan", description="Complete the battleground achievements listed below.", points=50, type="achievement"}}
A{"unknown", 8055, criterion=22727, side="horde", trivia={criteria="Master of Isle of Conquest", module="pvp", category="Player vs. Player", name="Khan", description="Complete the battleground achievements listed below.", points=50, type="achievement"}}
A{"unknown", 8055, criterion=22724, side="horde", trivia={criteria="Master of Twin Peaks", module="pvp", category="Player vs. Player", name="Khan", description="Complete the battleground achievements listed below.", points=50, type="achievement"}}
A{"unknown", 8055, criterion=22725, side="horde", trivia={criteria="Master of Silvershard Mines", module="pvp", category="Player vs. Player", name="Khan", description="Complete the battleground achievements listed below.", points=50, type="achievement"}}
A{"unknown", 8055, criterion=22726, side="horde", trivia={criteria="Master of Temple of Kotmogu", module="pvp", category="Player vs. Player", name="Khan", description="Complete the battleground achievements listed below.", points=50, type="achievement"}}

-- Player vs. Player/Deepwind Gorge: Deepwind Gorge Victory
A{"unknown", 8331, trivia={module="pvp", category="Player vs. Player/Deepwind Gorge", name="Deepwind Gorge Victory", description="Win Deepwind Gorge.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Deepwind Gorge: Deepwind Gorge Veteran
A{"unknown", 8332, criterion=23368, trivia={criteria="Complete 100 victories in Deepwind Gorge", module="pvp", category="Player vs. Player/Deepwind Gorge", name="Deepwind Gorge Veteran", description="Complete 100 victories in Deepwind Gorge.", points=10, parent="Player vs. Player", type=1}}

-- Player vs. Player/Deepwind Gorge: Deepwind Gorge Perfection
A{"unknown", 8333, trivia={module="pvp", category="Player vs. Player/Deepwind Gorge", name="Deepwind Gorge Perfection", description="Win Deepwind Gorge with a score of 1500 to 0.", points=20, parent="Player vs. Player"}}

-- Player vs. Player/Deepwind Gorge: Mine! Mine! Mine!
A{"unknown", 8350, criterion=23421, trivia={criteria="Assault 50 mines in Deepwind Gorge", module="pvp", category="Player vs. Player/Deepwind Gorge", name="Mine! Mine! Mine!", description="Assault 50 mines in Deepwind Gorge.", points=10, parent="Player vs. Player", type=30}}

-- Player vs. Player/Deepwind Gorge: Other People's Property
A{"unknown", 8351, criterion=23422, trivia={criteria="Take 50 mine carts in Deepwind Gorge", module="pvp", category="Player vs. Player/Deepwind Gorge", name="Other People's Property", description="Capture 50 mine carts in Deepwind Gorge.", points=10, parent="Player vs. Player", type=30}}

-- Player vs. Player/Deepwind Gorge: Puddle Jumper
A{"unknown", 8354, trivia={module="pvp", category="Player vs. Player/Deepwind Gorge", name="Puddle Jumper", description="Fall 25 yards without dying in Deepwind Gorge.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Deepwind Gorge: Weighed Down
A{"unknown", 8355, trivia={module="pvp", category="Player vs. Player/Deepwind Gorge", name="Weighed Down", description="Kill an enemy carrying your mine cart before they leave your base.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Deepwind Gorge: Deepwind Gorge All-Star
A{"unknown", 8358, criterion=23425, trivia={criteria="Assault 1 mine", module="pvp", category="Player vs. Player/Deepwind Gorge", name="Deepwind Gorge All-Star", description="Assault a mine, Defend a mine, Capture a mine cart and Return a mine cart in a single Deepwind Gorge match.", points=20, parent="Player vs. Player", type=30}}
A{"unknown", 8358, criterion=23426, trivia={criteria="Defend 1 mine", module="pvp", category="Player vs. Player/Deepwind Gorge", name="Deepwind Gorge All-Star", description="Assault a mine, Defend a mine, Capture a mine cart and Return a mine cart in a single Deepwind Gorge match.", points=20, parent="Player vs. Player", type=30}}
A{"unknown", 8358, criterion=23427, trivia={criteria="Capture 1 mine cart", module="pvp", category="Player vs. Player/Deepwind Gorge", name="Deepwind Gorge All-Star", description="Assault a mine, Defend a mine, Capture a mine cart and Return a mine cart in a single Deepwind Gorge match.", points=20, parent="Player vs. Player", type=30}}
A{"unknown", 8358, criterion=23428, trivia={criteria="Return 1 mine cart", module="pvp", category="Player vs. Player/Deepwind Gorge", name="Deepwind Gorge All-Star", description="Assault a mine, Defend a mine, Capture a mine cart and Return a mine cart in a single Deepwind Gorge match.", points=20, parent="Player vs. Player", type=30}}

-- Player vs. Player/Deepwind Gorge: Capping Spree
A{"unknown", 8359, trivia={module="pvp", category="Player vs. Player/Deepwind Gorge", name="Capping Spree", description="Personally capture the enemy mine cart 4 times in a single Deepwind Gorge battleground.", points=10, parent="Player vs. Player"}}

-- Player vs. Player/Deepwind Gorge: Master of Deepwind Gorge
A{"unknown", 8360, criterion=23429, trivia={criteria="Deepwind Gorge Victory", module="pvp", category="Player vs. Player/Deepwind Gorge", name="Master of Deepwind Gorge", description="Complete the Deepwind Gorge achievements listed below.", points=10, parent="Player vs. Player", type="achievement"}}
A{"unknown", 8360, criterion=23430, trivia={criteria="Deepwind Gorge Veteran", module="pvp", category="Player vs. Player/Deepwind Gorge", name="Master of Deepwind Gorge", description="Complete the Deepwind Gorge achievements listed below.", points=10, parent="Player vs. Player", type="achievement"}}
A{"unknown", 8360, criterion=23431, trivia={criteria="Deepwind Gorge Perfection", module="pvp", category="Player vs. Player/Deepwind Gorge", name="Master of Deepwind Gorge", description="Complete the Deepwind Gorge achievements listed below.", points=10, parent="Player vs. Player", type="achievement"}}
A{"unknown", 8360, criterion=23432, trivia={criteria="Mine! Mine! Mine!", module="pvp", category="Player vs. Player/Deepwind Gorge", name="Master of Deepwind Gorge", description="Complete the Deepwind Gorge achievements listed below.", points=10, parent="Player vs. Player", type="achievement"}}
A{"unknown", 8360, criterion=23433, trivia={criteria="Other People's Property", module="pvp", category="Player vs. Player/Deepwind Gorge", name="Master of Deepwind Gorge", description="Complete the Deepwind Gorge achievements listed below.", points=10, parent="Player vs. Player", type="achievement"}}
A{"unknown", 8360, criterion=23434, trivia={criteria="Puddle Jumper", module="pvp", category="Player vs. Player/Deepwind Gorge", name="Master of Deepwind Gorge", description="Complete the Deepwind Gorge achievements listed below.", points=10, parent="Player vs. Player", type="achievement"}}
A{"unknown", 8360, criterion=23522, trivia={criteria="Weighed down", module="pvp", category="Player vs. Player/Deepwind Gorge", name="Master of Deepwind Gorge", description="Complete the Deepwind Gorge achievements listed below.", points=10, parent="Player vs. Player", type="achievement"}}
A{"unknown", 8360, criterion=23523, trivia={criteria="Capping Spree", module="pvp", category="Player vs. Player/Deepwind Gorge", name="Master of Deepwind Gorge", description="Complete the Deepwind Gorge achievements listed below.", points=10, parent="Player vs. Player", type="achievement"}}
A{"unknown", 8360, criterion=23524, trivia={criteria="Deepwind All-Star", module="pvp", category="Player vs. Player/Deepwind Gorge", name="Master of Deepwind Gorge", description="Complete the Deepwind Gorge achievements listed below.", points=10, parent="Player vs. Player", type="achievement"}}

-- Player vs. Player: Candlekeeper
A{"unknown", 8717, criterion=23999, trivia={criteria="Bloody Coins", module="pvp", category="Player vs. Player", name="Candlekeeper", description="Obtain 10 Bloody Coins as an Emissary of Ordos or Ordon Fire-Watcher.", points=10, type="earn"}}

-- Player vs. Player: Oathguard
A{"unknown", 8718, criterion=23999, trivia={criteria="Bloody Coins", module="pvp", category="Player vs. Player", name="Oathguard", description="Obtain 100 Bloody Coins as an Emissary of Ordos or Ordon Fire-Watcher.", points=10, type="earn"}}

-- Player vs. Player: Blazebinder
A{"unknown", 8719, criterion=23999, trivia={criteria="Bloody Coins", module="pvp", category="Player vs. Player", name="Blazebinder", description="Obtain 500 Bloody Coins as an Emissary of Ordos or Ordon Fire-Watcher.", points=10, type="earn"}}

-- Player vs. Player: Kilnmaster
A{"unknown", 8720, criterion=23999, trivia={criteria="Bloody Coins", module="pvp", category="Player vs. Player", name="Kilnmaster", description="Obtain 1000 Bloody Coins as an Emissary of Ordos or Ordon Fire-Watcher.", points=10, type="earn"}}

-- Player vs. Player: Fire-Watcher
A{"unknown", 8721, criterion=23999, trivia={criteria="Bloody Coins", module="pvp", category="Player vs. Player", name="Fire-Watcher", description="Obtain 2000 Bloody Coins as an Emissary of Ordos or Ordon Fire-Watcher.", points=10, type="earn"}}

-- Player vs. Player: Wild Conquest
A{"unknown", 10088, side="horde", trivia={module="pvp", category="Player vs. Player", name="Wild Conquest", description="Earn 27,000 Conquest Points in Warlords Season 2.", points=10}}

-- Player vs. Player: Wild Conquest
A{"unknown", 10089, side="alliance", trivia={module="pvp", category="Player vs. Player", name="Wild Conquest", description="Earn 27,000 Conquest Points in Warlords Season 2.", points=10}}

-- Player vs. Player: Warmongering Conquest
A{"unknown", 10090, side="horde", trivia={module="pvp", category="Player vs. Player", name="Warmongering Conquest", description="Earn 27,000 Conquest Points in Warlords Season 3.", points=10}}

-- Player vs. Player: Warmongering Conquest
A{"unknown", 10091, side="alliance", trivia={module="pvp", category="Player vs. Player", name="Warmongering Conquest", description="Earn 27,000 Conquest Points in Warlords Season 3.", points=10}}

-- Player vs. Player: Wild Combatant
A{"unknown", 10092, criterion=28386, side="horde", trivia={criteria="Win 100 Arena (3v3) matches in Warlords Season 2", module="pvp", category="Player vs. Player", name="Wild Combatant", description="Win 100 Arena (3v3) or 40 Rated Battlegrounds in Warlords Season 2", points=15, type=37}}
A{"unknown", 10092, criterion=28387, side="horde", trivia={criteria="Win 40 Rated Battleground Matches in Warlords Season 2", module="pvp", category="Player vs. Player", name="Wild Combatant", description="Win 100 Arena (3v3) or 40 Rated Battlegrounds in Warlords Season 2", points=15, type=130}}

-- Player vs. Player: Wild Combatant
A{"unknown", 10093, criterion=28386, side="alliance", trivia={criteria="Win 100 Arena (3v3) matches in Warlords Season 2", module="pvp", category="Player vs. Player", name="Wild Combatant", description="Win 100 Arena (3v3) or 40 Rated Battlegrounds in Warlords Season 2", points=15, type=37}}
A{"unknown", 10093, criterion=28387, side="alliance", trivia={criteria="Win 40 Rated Battleground Matches in Warlords Season 2", module="pvp", category="Player vs. Player", name="Wild Combatant", description="Win 100 Arena (3v3) or 40 Rated Battlegrounds in Warlords Season 2", points=15, type=130}}

-- Player vs. Player: Warmongering Combatant
A{"unknown", 10094, criterion=28389, side="horde", trivia={criteria="Win 100 Arena (3v3) matches in Warlords Season 3", module="pvp", category="Player vs. Player", name="Warmongering Combatant", description="Win 100 Arena (3v3) or 40 Rated Battlegrounds in Warlords Season 3", points=15, type=37}}
A{"unknown", 10094, criterion=28388, side="horde", trivia={criteria="Win 40 Rated Battleground Matches in Warlords Season 3", module="pvp", category="Player vs. Player", name="Warmongering Combatant", description="Win 100 Arena (3v3) or 40 Rated Battlegrounds in Warlords Season 3", points=15, type=130}}

-- Player vs. Player: Warmongering Combatant
A{"unknown", 10095, criterion=28388, side="alliance", trivia={criteria="Win 40 Rated Battleground Matches in Warlords Season 3", module="pvp", category="Player vs. Player", name="Warmongering Combatant", description="Win 100 Arena (3v3) or 40 Rated Battlegrounds in Warlords Season 3", points=15, type=130}}
A{"unknown", 10095, criterion=28389, side="alliance", trivia={criteria="Win 100 Arena (3v3) matches in Warlords Season 3", module="pvp", category="Player vs. Player", name="Warmongering Combatant", description="Win 100 Arena (3v3) or 40 Rated Battlegrounds in Warlords Season 3", points=15, type=37}}

-- Player vs. Player/Warsong Gulch: Warsong Gulch Victory
A{"WarsongGulch", 166, trivia={module="pvp", category="Player vs. Player/Warsong Gulch", name="Warsong Gulch Victory", description="Win Warsong Gulch.", mapID="WarsongGulch", uiMapID=92, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Warsong Gulch: Warsong Gulch Veteran
A{"WarsongGulch", 167, criterion=5899, trivia={criteria="Complete 100 victories in Warsong Gulch", module="pvp", category="Player vs. Player/Warsong Gulch", name="Warsong Gulch Veteran", description="Complete 100 victories in Warsong Gulch.", mapID="WarsongGulch", uiMapID=92, points=10, parent="Player vs. Player", type=1}}

-- Player vs. Player/Warsong Gulch: Warsong Gulch Perfection
A{"WarsongGulch", 168, trivia={module="pvp", category="Player vs. Player/Warsong Gulch", name="Warsong Gulch Perfection", description="Win Warsong Gulch with a score of 3 to 0.", mapID="WarsongGulch", uiMapID=92, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Warsong Gulch: Capture the Flag
A{"WarsongGulch", 199, trivia={module="pvp", category="Player vs. Player/Warsong Gulch", name="Capture the Flag", description="Personally carry and capture the flag in Warsong Gulch.", mapID="WarsongGulch", uiMapID=92, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Warsong Gulch: Persistent Defender
A{"WarsongGulch", 200, criterion=440, trivia={criteria="Return the flag 50 times", module="pvp", category="Player vs. Player/Warsong Gulch", name="Persistent Defender", description="Return 50 flags as a defender in Warsong Gulch.", mapID="WarsongGulch", uiMapID=92, points=10, parent="Player vs. Player", type=30}}

-- Player vs. Player/Warsong Gulch: Warsong Expedience
A{"WarsongGulch", 201, trivia={module="pvp", category="Player vs. Player/Warsong Gulch", name="Warsong Expedience", description="Win Warsong Gulch in under 7 minutes.", mapID="WarsongGulch", uiMapID=92, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Warsong Gulch: Quick Cap
A{"WarsongGulch", 202, side="alliance", trivia={module="pvp", category="Player vs. Player/Warsong Gulch", name="Quick Cap", description="Grab the flag and capture it in under 75 seconds.", mapID="WarsongGulch", uiMapID=92, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Warsong Gulch: Not In My House
A{"WarsongGulch", 203, criterion=7020, side="alliance", trivia={criteria="Kill 2 flag carriers before they leave the Silverwing Flag Room", module="pvp", category="Player vs. Player/Warsong Gulch", name="Not In My House", description="In a single Warsong Gulch battle, kill 2 flag carriers before they leave the Silverwing Flag Room.", mapID="WarsongGulch", uiMapID=92, points=10, parent="Player vs. Player", type=70}}

-- Player vs. Player/Warsong Gulch: Ironman
A{"WarsongGulch", 204, trivia={module="pvp", category="Player vs. Player/Warsong Gulch", name="Ironman", description="In a single Warsong Gulch battle, carry and capture the flag 3 times without dying.", mapID="WarsongGulch", uiMapID=92, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Warsong Gulch: Supreme Defender
A{"WarsongGulch", 206, criterion=3698, side="alliance", trivia={criteria="Horde Flag Carriers", module="pvp", category="Player vs. Player/Warsong Gulch", name="Supreme Defender", description="Kill 100 flag carriers in Warsong Gulch.", mapID="WarsongGulch", uiMapID=92, points=10, parent="Player vs. Player", type=70}}

-- Player vs. Player/Warsong Gulch: Save the Day
A{"WarsongGulch", 207, trivia={module="pvp", category="Player vs. Player/Warsong Gulch", name="Save the Day", description="Kill the enemy who is carrying your flag in the opposing team's flag room while the opposing team's flag is at their base, within their control.", mapID="WarsongGulch", uiMapID=92, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Warsong Gulch: Warsong Outrider
A{"WarsongGulch", 712, faction=889, side="horde", trivia={module="pvp", category="Player vs. Player/Warsong Gulch", name="Warsong Outrider", description="Gain exalted reputation with the Warsong Outriders.", mapID="WarsongGulch", uiMapID=92, points=10, parent="Player vs. Player", type="exalted"}}

-- Player vs. Player/Warsong Gulch: Silverwing Sentinel
A{"WarsongGulch", 713, faction=890, side="alliance", trivia={module="pvp", category="Player vs. Player/Warsong Gulch", name="Silverwing Sentinel", description="Gain exalted reputation with the Silverwing Sentinels.", mapID="WarsongGulch", uiMapID=92, points=10, parent="Player vs. Player", type="exalted"}}

-- Player vs. Player: The Conqueror
A{"WarsongGulch", 714, criterion=5319, faction=889, side="horde", trivia={criteria="Warsong Outrider", module="pvp", category="Player vs. Player", name="The Conqueror", description="Raise your reputation values in Warsong Gulch, Arathi Basin and Alterac Valley to Exalted.", mapID="WarsongGulch", uiMapID=92, points=20, type=46}}

-- Player vs. Player/Warsong Gulch: Frenzied Defender
A{"WarsongGulch", 872, criterion=1801, trivia={criteria="Return 5 flags in a single battle", module="pvp", category="Player vs. Player/Warsong Gulch", name="Frenzied Defender", description="Return 5 flags in a single Warsong Gulch battle.", mapID="WarsongGulch", uiMapID=92, points=10, parent="Player vs. Player", type=30}}

-- Player vs. Player: The Justicar
A{"WarsongGulch", 907, criterion=5334, faction=890, side="alliance", trivia={criteria="Silverwing Sentinel", module="pvp", category="Player vs. Player", name="The Justicar", description="Raise your reputation values in Warsong Gulch, Arathi Basin and Alterac Valley to Exalted.", mapID="WarsongGulch", uiMapID=92, points=20, type=46}}

-- Player vs. Player/Warsong Gulch: Master of Warsong Gulch
A{"WarsongGulch", 1172, criterion=3463, trivia={criteria="Persistent Defender", module="pvp", category="Player vs. Player/Warsong Gulch", name="Master of Warsong Gulch", description="Complete the Warsong Gulch achievements listed below.", mapID="WarsongGulch", uiMapID=92, points=25, parent="Player vs. Player", type="achievement"}}
A{"WarsongGulch", 1172, criterion=3464, trivia={criteria="Frenzied Defender", module="pvp", category="Player vs. Player/Warsong Gulch", name="Master of Warsong Gulch", description="Complete the Warsong Gulch achievements listed below.", mapID="WarsongGulch", uiMapID=92, points=25, parent="Player vs. Player", type="achievement"}}
A{"WarsongGulch", 1172, criterion=3472, trivia={criteria="Save The Day", module="pvp", category="Player vs. Player/Warsong Gulch", name="Master of Warsong Gulch", description="Complete the Warsong Gulch achievements listed below.", mapID="WarsongGulch", uiMapID=92, points=25, parent="Player vs. Player", type="achievement"}}
A{"WarsongGulch", 1172, criterion=3466, trivia={criteria="Warsong Expedience", module="pvp", category="Player vs. Player/Warsong Gulch", name="Master of Warsong Gulch", description="Complete the Warsong Gulch achievements listed below.", mapID="WarsongGulch", uiMapID=92, points=25, parent="Player vs. Player", type="achievement"}}
A{"WarsongGulch", 1172, criterion=3462, trivia={criteria="Capture the Flag", module="pvp", category="Player vs. Player/Warsong Gulch", name="Master of Warsong Gulch", description="Complete the Warsong Gulch achievements listed below.", mapID="WarsongGulch", uiMapID=92, points=25, parent="Player vs. Player", type="achievement"}}
A{"WarsongGulch", 1172, criterion=3465, trivia={criteria="Warsong Gulch Perfection", module="pvp", category="Player vs. Player/Warsong Gulch", name="Master of Warsong Gulch", description="Complete the Warsong Gulch achievements listed below.", mapID="WarsongGulch", uiMapID=92, points=25, parent="Player vs. Player", type="achievement"}}
A{"WarsongGulch", 1172, criterion=3461, trivia={criteria="Warsong Gulch Veteran", module="pvp", category="Player vs. Player/Warsong Gulch", name="Master of Warsong Gulch", description="Complete the Warsong Gulch achievements listed below.", mapID="WarsongGulch", uiMapID=92, points=25, parent="Player vs. Player", type="achievement"}}
A{"WarsongGulch", 1172, criterion=3467, trivia={criteria="Ironman", module="pvp", category="Player vs. Player/Warsong Gulch", name="Master of Warsong Gulch", description="Complete the Warsong Gulch achievements listed below.", mapID="WarsongGulch", uiMapID=92, points=25, parent="Player vs. Player", type="achievement"}}
A{"WarsongGulch", 1172, criterion=3469, trivia={criteria="Not In My House", module="pvp", category="Player vs. Player/Warsong Gulch", name="Master of Warsong Gulch", description="Complete the Warsong Gulch achievements listed below.", mapID="WarsongGulch", uiMapID=92, points=25, parent="Player vs. Player", type="achievement"}}
A{"WarsongGulch", 1172, criterion=3470, trivia={criteria="Quick Cap", module="pvp", category="Player vs. Player/Warsong Gulch", name="Master of Warsong Gulch", description="Complete the Warsong Gulch achievements listed below.", mapID="WarsongGulch", uiMapID=92, points=25, parent="Player vs. Player", type="achievement"}}
A{"WarsongGulch", 1172, criterion=3471, trivia={criteria="Supreme Defender", module="pvp", category="Player vs. Player/Warsong Gulch", name="Master of Warsong Gulch", description="Complete the Warsong Gulch achievements listed below.", mapID="WarsongGulch", uiMapID=92, points=25, parent="Player vs. Player", type="achievement"}}

-- Player vs. Player/Warsong Gulch: Not In My House
A{"WarsongGulch", 1251, criterion=7021, side="horde", trivia={criteria="Kill 2 flag carriers before they leave the Warsong Flag Room", module="pvp", category="Player vs. Player/Warsong Gulch", name="Not In My House", description="In a single Warsong Gulch battle, kill 2 flag carriers before they leave the Warsong Flag Room.", mapID="WarsongGulch", uiMapID=92, points=10, parent="Player vs. Player", type=70}}

-- Player vs. Player/Warsong Gulch: Supreme Defender
A{"WarsongGulch", 1252, criterion=3699, side="horde", trivia={criteria="Alliance Flag Carriers", module="pvp", category="Player vs. Player/Warsong Gulch", name="Supreme Defender", description="Kill 100 flag carriers in Warsong Gulch.", mapID="WarsongGulch", uiMapID=92, points=10, parent="Player vs. Player", type=70}}

-- Player vs. Player/Warsong Gulch: Not So Fast
A{"WarsongGulch", 1259, trivia={module="pvp", category="Player vs. Player/Warsong Gulch", name="Not So Fast", description="In Warsong Gulch, kill a player who is under the effects of the speed power-up.", mapID="WarsongGulch", uiMapID=92, points=10, parent="Player vs. Player"}}

-- Player vs. Player/Warsong Gulch: Quick Cap
A{"WarsongGulch", 1502, side="horde", trivia={module="pvp", category="Player vs. Player/Warsong Gulch", name="Quick Cap", description="Grab the flag and capture it in under 75 seconds.", mapID="WarsongGulch", uiMapID=92, points=10, parent="Player vs. Player"}}
