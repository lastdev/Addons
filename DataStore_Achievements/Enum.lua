--[[
Achievements-related enumerations

Notes: 
	- id's below 80 are usable at will, higher are real in-game id's
	- id's below 80 are sub-categories of real in-game categories, for higher clarity/better grouping
--]]

local enum = DataStore.Enum

enum.AchievementCategories = {
	Character = 92,
	CharacterLevel = 1,
	CharacterMoney = 2,
	CharacterRiding = 3,
	CharacterOther = 4,
	
	Quests = 96,
	QuestsCompleted = 5,
	QuestsDaily = 6,
	QuestsWorld = 7,
	QuestsDungeon = 8,
	QuestsOther = 9,
	
	QuestsEasternKingdoms = 14861,
	QuestsKalimdor	= 15081,
	QuestsOutland	= 14862,
	QuestsNorthrend	= 14863,
	QuestsCataclysm = 15070,
	QuestsPandaria	= 15110,
	QuestsDraenor = 15220,
	QuestsLegion = 15252,
	QuestsBfA = 15284,
	QuestsShadowlands = 15422,
	
	Exploration = 97,
	ExplorationExplorer = 10,
	ExplorationOther = 11,
	ExplorationEasternKingdoms = 14777,
	ExplorationKalimdor	= 14778,
	ExplorationOutland	= 14779,
	ExplorationNorthrend	= 14780,
	ExplorationCataclysm = 15069,
	ExplorationPandaria	= 15113,
	ExplorationDraenor = 15235,
	ExplorationLegion = 15257,
	ExplorationBfA = 15298,
	ExplorationShadowlands = 15436,
	
	PvP = 95,
	PvPHonorableKills = 12,
	PvPKills = 13,
	PvPBattleground = 14,
	PvPOther = 15,
	PvPArena = 165,
	PvPHonor = 15266,
	PvPWorld = 15283,
	PvPRatedBattleground = 15092,
	PvPWarsongGulch = 14804,
	PvPArathi = 14802,
	PvPEyeOfTheStorm = 14803,
	PvPAlteracValley = 14801,
	PvPAshran = 15414,
	PvPIsleOfConquest = 15003,
	PvPWintergrasp = 14901,
	PvPBattleForGilneas = 15073,
	PvPTwinPeaks = 15074,
	PvPSilvershardMines = 15162,
	PvPTempleOfKotmogu = 15163,
	PvPSeethingShore = 15292,
	PvPDeepwindGorge = 15218,
	
	Dungeons	= 168,
	DungeonHero = 16,
	DungeonGloryHero = 17,
	DungeonGloryRaider = 18,
	DungeonsOther = 19,
}
