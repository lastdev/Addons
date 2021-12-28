local AL = LibStub:GetLibrary("AchievementLocations-1.0")
local function A(row) AL:AddLocation(row) end

-- Dungeons & Raids/Cataclysm Raid: Baradin Hold Guild Run
A{"BaradinHold", 5425, trivia={criteria="Argaloth slain", module="group", category="Dungeons & Raids/Cataclysm Raid", name="Baradin Hold Guild Run", description="Defeat the bosses in Baradin Hold while in a guild group.", mapID="BaradinHold", uiMapID=282, points=10, parent="Dungeons & Raids"}}
A{"BaradinHold", 5425, trivia={criteria="Occu'thar slain", module="group", category="Dungeons & Raids/Cataclysm Raid", name="Baradin Hold Guild Run", description="Defeat the bosses in Baradin Hold while in a guild group.", mapID="BaradinHold", uiMapID=282, points=10, parent="Dungeons & Raids"}}
A{"BaradinHold", 5425, trivia={criteria="Alizabal slain", module="group", category="Dungeons & Raids/Cataclysm Raid", name="Baradin Hold Guild Run", description="Defeat the bosses in Baradin Hold while in a guild group.", mapID="BaradinHold", uiMapID=282, points=10, parent="Dungeons & Raids"}}

-- none: Blackwing Descent Guild Run
A{"BlackwingDescent", nil, trivia={module="group", category="none", name="Blackwing Descent Guild Run"}}
A{"DragonSoul", nil, trivia={module="group", category="none", name="Dragon Soul Guild Run"}}

-- Dungeons & Raids/Cataclysm Raid: Only the Penitent...
A{"Firelands", 5799, 0.5000, 0.8200, floor=3, trivia={module="group", category="Dungeons & Raids/Cataclysm Raid", name="Only the Penitent...", description="Activate both of Fandral's Flames at once in Firelands without any raid member getting hit by Kneel to the Flame!", mapID="Firelands_SulfuronKeep", uiMapID=369, points=10, parent="Dungeons & Raids"}}

-- Dungeons & Raids: Glory of the Firelands Raider
A{"Firelands", 5828, 0.5000, 0.8200, criterion=17582, floor=3, trivia={criteria="Only the Penitent...", module="group", category="Dungeons & Raids", name="Glory of the Firelands Raider", description="Complete the Firelands raid achievements listed below.", mapID="Firelands_SulfuronKeep", uiMapID=369, points=25, type="achievement"}}

-- none: Firelands Guild Run
A{"Firelands", nil, 0.5070, 0.1530, trivia={module="group", category="none", name="Firelands Guild Run", mapID="Firelands_SulfuronKeep", uiMapID=369}}

-- Dungeons & Raids: Glory of the Hero
A{"Gundrak", 2136, 0.4650, 0.2700, criterion=7584, trivia={criteria="Share The Love", module="group", category="Dungeons & Raids", name="Glory of the Hero", description="Complete the Heroic dungeon achievements listed below.", mapID="Gundrak", uiMapID=154, points=25, type="achievement"}}

-- Dungeons & Raids/Lich King Dungeon: Share The Love
A{"Gundrak", 2152, 0.4650, 0.2700, trivia={module="group", category="Dungeons & Raids/Lich King Dungeon", name="Share The Love", description="Defeat Gal'darah in Gundrak on Heroic Difficulty and have 5 unique party members get impaled throughout the fight.", mapID="Gundrak", uiMapID=154, points=10, parent="Dungeons & Raids"}}

-- Dungeons & Raids/Pandaria Raid: Millions of Years of Evolution vs. My Fist
A{"IsleOfGiants", 8123, 0.5060, 0.5440, trivia={module="group", category="Dungeons & Raids/Pandaria Raid", name="Millions of Years of Evolution vs. My Fist", description="Defeat Oondasta on the Isle of Giants.", mapID="IsleOfGiants", uiMapID=507, points=10, parent="Dungeons & Raids"}}

-- Dungeons & Raids/Pandaria Dungeon: What Does This Button Do?
A{"MogushanPalace", 6736, 0.4040, 0.7110, floor=3, trivia={module="group", category="Dungeons & Raids/Pandaria Dungeon", name="What Does This Button Do?", description="Use Xin the Weaponmaster's secret defense mechanism against him in Mogu'shan Palace on Heroic difficulty.", mapID="MogushanPalace_ThroneOfAncientConquerors", uiMapID=455, points=10, parent="Dungeons & Raids"}}

-- Dungeons & Raids: Glory of the Pandaria Hero
A{"MogushanPalace", 6927, 0.4040, 0.7110, criterion=15254, floor=3, trivia={criteria="What Does This Button Do?", module="group", category="Dungeons & Raids", name="Glory of the Pandaria Hero", description="Complete the Pandaria Heroic dungeon achievements listed below.", mapID="MogushanPalace_ThroneOfAncientConquerors", uiMapID=455, points=25, type="achievement"}}

-- Dungeons & Raids/Pandaria Dungeon: School's Out Forever
A{"Scholomance", 6821, 0.8260, 0.3220, criterion=19807, trivia={criteria="Kill 50 Expired Test Subjects in 20 seconds", module="group", category="Dungeons & Raids/Pandaria Dungeon", name="School's Out Forever", description="Defeat 50 Expired Test Subjects within 20 seconds in Scholomance on Heroic Difficulty.", mapID="Scholomance_HeadmastersStudy", uiMapID=479, points=10, parent="Dungeons & Raids", type="slay"}}
A{"Scholomance", 6821, 0.1640, 0.3200, criterion=19807, trivia={criteria="Kill 50 Expired Test Subjects in 20 seconds", module="group", category="Dungeons & Raids/Pandaria Dungeon", name="School's Out Forever", description="Defeat 50 Expired Test Subjects within 20 seconds in Scholomance on Heroic Difficulty.", mapID="Scholomance_HeadmastersStudy", uiMapID=479, points=10, parent="Dungeons & Raids", type="slay"}}
A{"Scholomance", 6821, 0.4980, 0.8140, criterion=19807, trivia={criteria="Kill 50 Expired Test Subjects in 20 seconds", module="group", category="Dungeons & Raids/Pandaria Dungeon", name="School's Out Forever", description="Defeat 50 Expired Test Subjects within 20 seconds in Scholomance on Heroic Difficulty.", mapID="Scholomance_HeadmastersStudy", uiMapID=479, points=10, parent="Dungeons & Raids", type="slay"}}

-- Dungeons & Raids/Pandaria Raid: Heroic: Sha of Fear
A{"TerraceOfEndlessSpring", 6734, 0.3900, 0.4800, trivia={module="group", category="Dungeons & Raids/Pandaria Raid", name="Heroic: Sha of Fear", description="Defeat the Sha of Fear in Terrace of Endless Spring on Heroic difficulty.", mapID="TerraceOfEndlessSpring", uiMapID=456, points=10, parent="Dungeons & Raids"}}

-- Dungeons & Raids/Pandaria Raid: The Mind-Killer
A{"TerraceOfEndlessSpring", 6825, 0.3900, 0.4800, trivia={module="group", category="Dungeons & Raids/Pandaria Raid", name="The Mind-Killer", description="Defeat the Sha of Fear in Terrace of Endless Spring on Normal or Heroic difficulty without any raid members being feared by Dread Spray or Breath of Fear.", mapID="TerraceOfEndlessSpring", uiMapID=456, points=10, parent="Dungeons & Raids"}}

-- Dungeons & Raids: Tranquil Master
A{"TerraceOfEndlessSpring", 6926, 0.3900, 0.4800, criterion=19913, trivia={criteria="Sha of Fear (Normal or Heroic)", module="group", category="Dungeons & Raids", name="Tranquil Master", description="Purge Pandaria of Sha corruption, defeating each known manifestation of negative emotion.", mapID="TerraceOfEndlessSpring", uiMapID=456, points=10, type="slay"}}

-- Garrisons: Ten Hit Tunes
A{"TerraceOfEndlessSpring", 9828, 0.3900, 0.4800, criterion=27741, note="drop from Sha of Fear", side="alliance", trivia={criteria="Heart of Pandaria", module="group", category="Garrisons", name="Ten Hit Tunes", description="Collect ten Music Rolls for your garrison's jukebox.", mapID="TerraceOfEndlessSpring", uiMapID=456, points=5, type="quest"}}

-- Garrisons: Ten Hit Tunes
A{"TerraceOfEndlessSpring", 9897, 0.3900, 0.4800, criterion=27741, note="drop from Sha of Fear", side="horde", trivia={criteria="Heart of Pandaria", module="group", category="Garrisons", name="Ten Hit Tunes", description="Collect ten Music Rolls for your garrison's jukebox.", mapID="TerraceOfEndlessSpring", uiMapID=456, points=5, type="quest"}}

-- Garrisons: Azeroth's Top Twenty Tunes
A{"TerraceOfEndlessSpring", 9912, 0.3900, 0.4800, criterion=27741, note="drop from Sha of Fear", side="alliance", trivia={criteria="Heart of Pandaria", module="group", category="Garrisons", name="Azeroth's Top Twenty Tunes", description="Collect twenty Music Rolls for your garrison's jukebox.", mapID="TerraceOfEndlessSpring", uiMapID=456, points=5, type="quest"}}

-- Garrisons: Azeroth's Top Twenty Tunes
A{"TerraceOfEndlessSpring", 9914, 0.3900, 0.4800, criterion=27741, note="drop from Sha of Fear", side="horde", trivia={criteria="Heart of Pandaria", module="group", category="Garrisons", name="Azeroth's Top Twenty Tunes", description="Collect twenty Music Rolls for your garrison's jukebox.", mapID="TerraceOfEndlessSpring", uiMapID=456, points=5, type="quest"}}

-- Garrisons: Full Discography
A{"TerraceOfEndlessSpring", 10015, 0.3900, 0.4800, criterion=27741, note="drop from Sha of Fear", side="alliance", trivia={criteria="Heart of Pandaria", module="group", category="Garrisons", name="Full Discography", description="Collect all of the Music Rolls available for your garrison's jukebox.", mapID="TerraceOfEndlessSpring", uiMapID=456, points=5, type="quest"}}

-- none: Heroic: Cho'gall Guild Run
A{"TheBastionofTwilight", nil, trivia={module="group", category="none", name="Heroic: Cho'gall Guild Run"}}
A{"TheBastionofTwilight", nil, 0.4880, 0.3370, floor=3, trivia={module="group", category="none", name="Heroic: Sinestra Guild Run", mapID="TheBastionOfTwilight_TheTwilightCaverns", uiMapID=296}}
A{"TheBastionofTwilight", nil, trivia={module="group", category="none", name="The Bastion of Twilight Guild Run"}}

-- none: Throne of the Four Winds Guild Run
A{"ThroneoftheFourWinds", 4987, trivia={module="group", category="none", name="Throne of the Four Winds Guild Run", mapID="ThroneOfTheFourWinds", uiMapID=328}}

-- Dungeons & Raids/Lich King Raid: Staying Buffed All Winter (10 player)
A{"Ulduar", 2969, 0.6800, 0.6500, floor=3, trivia={module="group", category="Dungeons & Raids/Lich King Raid", name="Staying Buffed All Winter (10 player)", description="Possess the effects of Toasty Fire, Storm Power and Starlight at the same time in 10-player mode.", mapID="Ulduar_TheInnerSanctumOfUlduar", uiMapID=149, points=10, parent="Dungeons & Raids"}}

-- Dungeons & Raids/Lich King Raid: Staying Buffed All Winter (25 player)
A{"Ulduar", 2970, 0.6800, 0.6500, floor=3, trivia={module="group", category="Dungeons & Raids/Lich King Raid", name="Staying Buffed All Winter (25 player)", description="Possess the effects of Toasty Fire, Storm Power and Starlight at the same time in 25-player mode.", mapID="Ulduar_TheInnerSanctumOfUlduar", uiMapID=149, points=10, parent="Dungeons & Raids"}}

-- Dungeons & Raids/Dungeon Challenges: Upper Blackrock Spire Challenger
A{"UpperBlackrockSpire", 8891, 0.1500, 0.4850, floor=3, trivia={module="group", category="Dungeons & Raids/Dungeon Challenges", name="Upper Blackrock Spire Challenger", description="Complete the Upper Blackrock Spire Challenge Mode.", mapID="UpperBlackrockSpire_HallOfBlackhand", uiMapID=618, points=10, parent="Dungeons & Raids"}}

-- Dungeons & Raids/Dungeon Challenges: Upper Blackrock Spire: Bronze
A{"UpperBlackrockSpire", 8892, 0.1500, 0.4850, floor=3, trivia={module="group", category="Dungeons & Raids/Dungeon Challenges", name="Upper Blackrock Spire: Bronze", description="Complete the Upper Blackrock Spire Challenge Mode with a rating of Bronze or better.", mapID="UpperBlackrockSpire_HallOfBlackhand", uiMapID=618, points=10, parent="Dungeons & Raids"}}

-- Dungeons & Raids/Dungeon Challenges: Upper Blackrock Spire: Silver
A{"UpperBlackrockSpire", 8893, 0.1500, 0.4850, floor=3, trivia={module="group", category="Dungeons & Raids/Dungeon Challenges", name="Upper Blackrock Spire: Silver", description="Complete the Upper Blackrock Spire Challenge Mode with a rating of Silver or better.", mapID="UpperBlackrockSpire_HallOfBlackhand", uiMapID=618, points=10, parent="Dungeons & Raids"}}

-- Dungeons & Raids/Dungeon Challenges: Upper Blackrock Spire: Gold
A{"UpperBlackrockSpire", 8894, 0.1500, 0.4850, floor=3, trivia={module="group", category="Dungeons & Raids/Dungeon Challenges", name="Upper Blackrock Spire: Gold", description="Complete the Upper Blackrock Spire Challenge Mode with a rating of Gold.", mapID="UpperBlackrockSpire_HallOfBlackhand", uiMapID=618, points=10, parent="Dungeons & Raids"}}

-- Dungeons & Raids/Draenor Dungeon: Upper Blackrock Spire
A{"UpperBlackrockSpire", 9042, 0.1500, 0.4850, floor=3, trivia={module="group", category="Dungeons & Raids/Draenor Dungeon", name="Upper Blackrock Spire", description="Defeat Warlord Zaela in Upper Blackrock Spire.", mapID="UpperBlackrockSpire_HallOfBlackhand", uiMapID=618, points=10, parent="Dungeons & Raids"}}

-- Dungeons & Raids/Draenor Dungeon: Magnets, How Do They Work?
A{"UpperBlackrockSpire", 9045, 0.3050, 0.2670, floor=2, trivia={module="group", category="Dungeons & Raids/Draenor Dungeon", name="Magnets, How Do They Work?", description="Defeat Orebender Gor'ashan without allowing him to cast Thundering Cacophony 4 times in Upper Blackrock Spire on Heroic difficulty.", mapID="UpperBlackrockSpire_TheRookery", uiMapID=617, points=10, parent="Dungeons & Raids"}}

-- Dungeons & Raids/Draenor Dungeon: Heroic: Upper Blackrock Spire
A{"UpperBlackrockSpire", 9055, 0.1500, 0.4850, floor=3, trivia={module="group", category="Dungeons & Raids/Draenor Dungeon", name="Heroic: Upper Blackrock Spire", description="Defeat Warlord Zaela in Upper Blackrock Spire on Heroic difficulty.", mapID="UpperBlackrockSpire_HallOfBlackhand", uiMapID=618, points=10, parent="Dungeons & Raids"}}

-- Dungeons & Raids/Draenor Dungeon: Bridge Over Troubled Fire
A{"UpperBlackrockSpire", 9056, 0.4600, 0.4620, criterion=24998, floor=3, trivia={criteria="Kill 20 Ragefire Whelps in 10 seconds", module="group", category="Dungeons & Raids/Draenor Dungeon", name="Bridge Over Troubled Fire", description="Kill 20 Ragewing Whelps in 10 seconds while fighting Ragewing the Untamed in Upper Blackrock Spire on Heroic difficulty.", mapID="UpperBlackrockSpire_HallOfBlackhand", uiMapID=618, points=10, parent="Dungeons & Raids", type="slay"}}

-- Dungeons & Raids/Draenor Dungeon: Dragonmaw? More Like Dragonfall!
A{"UpperBlackrockSpire", 9057, 0.1500, 0.4850, floor=3, trivia={module="group", category="Dungeons & Raids/Draenor Dungeon", name="Dragonmaw? More Like Dragonfall!", description="Kill 5 Emberscale Ironflight before defeating Warlord Zaela in Upper Blackrock Spire on Heroic difficulty.", mapID="UpperBlackrockSpire_HallOfBlackhand", uiMapID=618, points=10, parent="Dungeons & Raids"}}

-- Dungeons & Raids/Draenor Dungeon: Leeeeeeeeeeeeeroy...?
A{"UpperBlackrockSpire", 9058, 0.3300, 0.3800, floor=2, trivia={module="group", category="Dungeons & Raids/Draenor Dungeon", name="Leeeeeeeeeeeeeroy...?", description="Assist Leeroy Jenkins in recovering his Devout shoulders in Upper Blackrock Spire on Heroic difficulty.", mapID="UpperBlackrockSpire_TheRookery", uiMapID=617, points=10, parent="Dungeons & Raids"}}

-- Feats of Strength: Challenge Master: Upper Blackrock Spire
A{"UpperBlackrockSpire", 9627, trivia={module="group", category="Feats of Strength", name="Challenge Master: Upper Blackrock Spire", description="Attain a realm-best time for the Upper Blackrock Spire Challenge Mode.", mapID="UpperBlackrockSpire_HallOfBlackhand", uiMapID=618, points=0}}

-- Collections: What A Strange, Interdimensional Trip It's Been
A{"UpperBlackrockSpire", 9838, 0.1500, 0.4850, criterion=27627, floor=3, trivia={criteria="Warlord Zaela", module="group", category="Collections", name="What A Strange, Interdimensional Trip It's Been", description="Defeat the following Draenor bosses while being accompanied by Pepe.", mapID="UpperBlackrockSpire_HallOfBlackhand", uiMapID=618, points=10, type=165}}

-- Dungeons & Raids/Draenor Dungeon: Mythic: Upper Blackrock Spire
A{"UpperBlackrockSpire", 10085, 0.1500, 0.4850, floor=3, trivia={module="group", category="Dungeons & Raids/Draenor Dungeon", name="Mythic: Upper Blackrock Spire", description="Defeat Warlord Zaela in Upper Blackrock Spire on Mythic difficulty.", mapID="UpperBlackrockSpire_HallOfBlackhand", uiMapID=618, points=10, parent="Dungeons & Raids"}}
