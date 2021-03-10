local ConRO_Warrior, ids = ...;

--General
	ids.Racial = {
		AncestralCall = 274738,
		ArcanePulse = 260364,
		ArcaneTorrent = 50613,
		Berserking = 26297,
		Cannibalize = 20577,
		GiftoftheNaaru = 59548,
		Shadowmeld = 58984,
	}
	ids.Covenant = {
		None = 0,
		Kyrian = 1,
		Venthyr = 2,
		NightFae = 3,
		Necrolord = 4,
	}
	ids.Soulbinds = {
		Niya = 1,
		Dreamweaver = 2,
		GeneralDraven = 3,
		PlagueDeviserMarileth = 4,
		Emeni = 5,
		Korayn = 6,
		Pelagos = 7,
		NadjiatheMistblade = 8,
		TheotartheMadDuke = 9,
		BonesmithHeirmir = 10,
		Kleia = 13,
		ForgelitePrimeMikanikos = 18,
	}
	ids.Covenant_Ability = {
		AncientAftershock = 325886,
		Condemn = 317349,
			CondemnMassacre = 330334,
		CondemnFury = 317485,
			CondemnMassacreFury = 330325,
		ConquerorsBanner = 324143,
		Fleshcraft = 324631,
		PhialofSerenity = 177278,
		SpearofBastion = 307865,
		Soulshape = 310143,
		SummonSteward = 324739,
	}
	ids.Covenant_Conduit = {
	--Kyrian
		--Pelagos
			CombatMeditation = 328266,
			FocusingMantra = 328261,
			RoadofTrials = 329786,
			PhialofPatience = 329777,
			BondofFriendship = 328265,
			CleansedVestments = 328263,
			LetGoofthePast = 328257,
		--Kleia
			ValiantStrikes = 329791,
			Mentorship = 334066,
			AscendantPhial = 329776,
			CleansingRites = 329784,
			EverForward = 328258,
			BearersPursuit = 329779,
			PointedCourage = 329778,
			ResonantAccolades = 329781,
		--Forgelite Prime Mikanikos
			BronsCalltoAction = 333950,
			ForgeliteFilter = 331609,
			ChargedAdditive = 331610,
			RegeneratingMaterials = 331726,
			ResilientPlumage = 331725,
			SoulsteelClamps = 331611,
			HammerofGenesis = 333935,
			SparklingDriftglobeCore = 331612,
	--Necrolord
		--Plague Deviser Marileth
			VolatileSolvent = 323074,
			OozsFrictionlessCoating = 323091,
			TravelwithBloop = 323089,
			PlagueysPreemptiveStrike = 323090,
			KevinsKeyring = 323079,
			PlaguebornCleansingSlime = 323081,
			UltimateForm = 323095,
		--Emeni
			LeadbyExample = 342156,
			EmenisMagnificentSkin = 323921,
			EmenisAmbulatoryFlesh = 341650,
			CartilaginousLegs = 324440,
			HearthKidneystone = 324441,
			GristledToes = 323918,
			GnashingChompers = 323919,
			SulfuricEmission = 323916,
		--Bonesmith Heirmir
			ForgeborneReveries = 326514,
			ResourcefulFleshcrafting = 326507,
			SerratedSpaulders = 326504,
			RuneforgedSpurs = 326512,
			BonesmithsSatchel = 326513,
			HeirmirsArsenalGorestompers = 326511,
			HeirmirsArsenalMarrowedGemstone = 326572,
			HeirmirsArsenalRavenousPendant = 326509,
	--NightFae
		--Niya
			GroveInvigoration = 322721,
			RunWithoutTiring = 342270,
			StayontheMove = 320658,
			NaturesSplendor = 320668,
			SwiftPatrol = 320687,
			NiyasToolsBurrs = 320659,
			NiyasToolsPoison = 320660,
			NiyasToolsHerbs = 320662,
		--Dreamweaver
			Podtender = 319217,
			SoothingVoice = 319211,
			SocialButterfly = 319210,
			EmpoweredChrysalis = 319213,
			FaerieDust = 319214,
			Somnambulist = 319216,
			FieldofBlossoms = 319191,
		--Korayn
			WildHuntTactics = 325066,
			HornoftheWildHunt = 325067,
			WildHuntsCharge = 325065,
			VorkaiSharpeningTechniques = 325072,
			GetInFormation = 325073,
			FaceYourFoes = 325068,
			FirstStrike = 325069,
			HoldtheLine = 325601,
	--Venthyr
		--Nadjia the Mistblade
			ThrillSeeker = 331586,
			AgentofChaos = 331576,
			FancyFootwork = 331577,
			FriendsinLowPlaces = 331579,
			FamiliarPredicaments = 331582,
			ExactingPreparation = 331580,
			DauntlessDuelist = 331584,
		--Theotar the Mad Duke
			SoothingShade = 336239,
			WatchtheShoes = 336140,
			LeisurelyGait = 336147,
			LifeoftheParty = 336247,
			ExquisiteIngredients = 336184,
			TokenofAppreciation = 336245,
			RefinedPalate = 336243,
			WastelandPropriety = 319983,
		--General Draven
			ServiceInStone = 340159,
			MoveAsOne = 319982,
			EnduringGloom = 319978,
			UnbreakableBody = 332755,
			ExpeditionLeader = 332756,
			HoldYourGround = 332754,
			SuperiorTactics = 332753,
			BuiltforWar = 319973,
	--Endurance
		BrutalVitality = 335010,
		FueledbyViolence = 347213,
		IndelibleVictory = 336191,
		StalwartGuardian = 334993,
		UnnervingFocus = 337154,
	--Finesse
		CacophonousRoar = 335250,
		DisturbthePeace = 339948,
		InspiringPresence = 335034,
		Safeguard = 335196,
	--Potency
		AshenJuggernaut = 335232,
		CrashtheRamparts = 335242,
		DepthsofInsanity = 337162,
		DestructiveReverberations = 339939,
		HackandSlash = 337214,
		HarrowingPunishment = 339370,
		MercilessBonegrinder = 335260,
		MortalCombo = 339386,
		PiercingVerdict = 339259,
		ShowofForce = 339818,
		VeteransRepute = 339265,
		ViciousContempt = 337302,
	}
	ids.Covenant_Buff = {

	}
	ids.Covenant_Debuff = {	

	}
	ids.Legendary = {
	--Neutral
		EchoofEonar_Finger = "item:178926::::::::::::1:7100",
		EchoofEonar_Waist = "item:171418::::::::::::1:7100",
		EchoofEonar_Wrist = "item:171419::::::::::::1:7100",
		JudgementoftheArbiter_Finger = "item:178926::::::::::::1:7101",
		JudgementoftheArbiter_Hands = "item:171414::::::::::::1:7101",
		JudgementoftheArbiter_Wrist = "item:171419::::::::::::1:7101",
		MawRattle_Feet = "item:171413::::::::::::1:7159",
		MawRattle_Hands = "item:171414::::::::::::1:7159",
		MawRattle_Legs = "item:171416::::::::::::1:7159",
		NorgannonsSagacity_Back = "item:173242::::::::::::1:7102",
		NorgannonsSagacity_Feet = "item:171413::::::::::::1:7102",
		NorgannonsSagacity_Legs = "item:171416::::::::::::1:7102",
		SephuzsProclamation_Chest = "item:171412::::::::::::1:7103",
		SephuzsProclamation_Neck = "item:178927::::::::::::1:7103",
		SephuzsProclamation_Shoulder = "item:171417::::::::::::1:7103",
		StablePhantasmaLure_Back = "item:173242::::::::::::1:7104",
		StablePhantasmaLure_Neck = "item:178927::::::::::::1:7104",
		StablePhantasmaLure_Wrist = "item:171419::::::::::::1:7104",
		ThirdEyeoftheJailer_Head = "item:171415::::::::::::1:7105",
		ThirdEyeoftheJailer_Shoulder = "item:171417::::::::::::1:7105",
		ThirdEyeoftheJailer_Waist = "item:171418::::::::::::1:7105",
		VitalitySacrifice_Chest = "item:171412::::::::::::1:7106",
		VitalitySacrifice_Head = "item:171415::::::::::::1:7106",
		VitalitySacrifice_Shoulder = "item:171417::::::::::::1:7106",
	--Warrior
		Leaper_Feet = "item:171413::::::::::::1:6955",
		Leaper_Waist = "item:171418::::::::::::1:6955",
		MisshapenMirror_Chest = "item:171412::::::::::::1:6958",
		MisshapenMirror_Neck = "item:178927::::::::::::1:6958",
		SeismicReverberation_Head = "item:171415::::::::::::1:6971",
		SeismicReverberation_Shoulder = "item:171417::::::::::::1:6971",
		SignetofTormentedKings_Finger = "item:178926::::::::::::1:6959",
		SignetofTormentedKings_Wrist = "item:171419::::::::::::1:6959",
	--Arms
		Battlelord_Neck = "item:178927::::::::::::1:6960", -- Flag for Rotation
		Battlelord_Wrist = "item:171419::::::::::::1:6960",
		EnduringBlow_Head = "item:171415::::::::::::1:6962",
		EnduringBlow_Waist = "item:171418::::::::::::1:6962",
		Exploiter_Finger = "item:178926::::::::::::1:6961", -- Flag for Rotation
		Exploiter_Shoulder = "item:171417::::::::::::1:6961",
		Unhinged_Hands = "item:171414::::::::::::1:6970",
		Unhinged_Wrist = "item:171419::::::::::::1:6970",
	--Fury
		CadenceofFujieda_Legs = "item:171416::::::::::::1:6963",
		CadenceofFujieda_Waist = "item:171418::::::::::::1:6963",
		Deathmaker_Back = "item:173242::::::::::::1:6964",
		Deathmaker_Legs = "item:171416::::::::::::1:6964",
		RecklessDefense_Hands = "item:171414::::::::::::1:6965",
		RecklessDefense_Head = "item:171415::::::::::::1:6965",
		WilloftheBerserker_Back = "item:173242::::::::::::1:6966",
		WilloftheBerserker_Chest = "item:171412::::::::::::1:6966",
	--Protection
		Reprisal_Feet = "item:171413::::::::::::1:6969", -- Flag for Rotation
		Reprisal_Legs = "item:171416::::::::::::1:6969",
		TheWall_Back = "item:173242::::::::::::1:6957",
		TheWall_Shoulder = "item:171417::::::::::::1:6957",
		Thunderlord_Feet = "item:171413::::::::::::1:6956",
		Thunderlord_Hands = "item:171414::::::::::::1:6956",
		UnbreakableWill_Chest = "item:171412::::::::::::1:6967",
		UnbreakableWill_Finger = "item:178926::::::::::::1:6967",
	}
	ids.Legendary_Buff = {

	}
	ids.Legendary_Debuff = {	

	}

--Warrior
	ids.Warrior_Ability = {

	}
	ids.Warrior_Passive = {

	}
	ids.Warrior_Buff = {

	}
	ids.Warrior_Debuff = {

	}
	
--Arms
	ids.Arms_Ability = {
	--Warrior
		BattleShout = 6673,
		BerserkerRage = 18499,
		ChallengingShout = 1161,
		Charge = 100,
		Execute = 163201,
		Hamstring = 1715,
		HeroicLeap = 6544,
		HeroicThrow = 57755,
		IgnorePain = 190456,
		Intervene = 3411,
		IntimidatingShout = 5246,
		Pummel = 6552,
		RallyingCry = 97462,
		ShatteringThrow = 64382,
		ShieldBlock = 2565,
		ShieldSlam = 23922,
		Slam = 1464,
		SpellReflection = 23920,
		Taunt = 355,
		VictoryRush = 34428,
		Whirlwind = 1680,
	--Arms
		Bladestorm = 227847,
		ColossusSmash = 167105,
		DiebytheSword = 118038,
		MortalStrike = 12294,
		Overpower = 7384,
		PiercingHowl = 12323,
		SweepingStrikes = 260708,		
	}
	ids.Arms_Passive = {
		MasteryDeepWounds = 262111,
		SeasonedSoldier = 279423,
		Tactician = 184783,
	}
	ids.Arms_Talent = {
		--15
		WarMachine = 262231,
		SuddenDeath = 29725,
		Skullsplitter = 260643,
		--25
		DoubleTime = 103827,
		ImpendingVictory = 202168,
		StormBolt = 107570,
		--30
		Massacre = 281001,
			MassacreExecute = 281000,
		FervorofBattle = 202316,
		Rend = 772,
		--35
		SecondWind = 29838,
		BoundingStride = 202163,
		DefensiveStance = 197690,
			BattleStance = 212520,
		--40
		CollateralDamage = 334779,
		Warbreaker = 262161,
		Cleave = 845,
		--45
		InForTheKill = 248621,
		Avatar = 107574,
		DeadlyCalm = 262228,
		--50
		AngerManagement = 152278,
		Dreadnaught = 262150,
		Ravager = 152277,
	}
	ids.Arms_Form = {
		DefensiveStance = 197690,
	}
	ids.Arms_Buff = {
		Avatar = 107574,
		BattleShout = 6673,
		DeadlyCalm = 262228,
		IgnorePain = 190456,
		InForTheKill = 248622,
		Overpower = 7384,
		SuddenDeath = 52437,
		SweepingStrikes = 260708,
		Victorious = 32216,
	}
	ids.Arms_Debuff = {
		ColossusSmash = 208086,
		DeepWounds = 262115,
		MortalWounds = 115804,
		Rend = 772,
	}
	ids.Arms_PetAbility = {

	}
		
--Fury
	ids.Fury_Ability = {
	--Warrior
		BattleShout = 6673,
		BerserkerRage = 18499,
		ChallengingShout = 1161,
		Charge = 100,
		Execute = 5308,
		Hamstring = 1715,
		HeroicLeap = 6544,
		HeroicThrow = 57755,
		IgnorePain = 190456,
		Intervene = 3411,
		IntimidatingShout = 5246,
		Pummel = 6552,
		RallyingCry = 97462,
		ShatteringThrow = 64382,
		ShieldBlock = 2565,
		ShieldSlam = 23922,
		Slam = 1464,
		SpellReflection = 23920,
		Taunt = 355,
		VictoryRush = 34428,
		Whirlwind = 190411,
	--Fury
		Bloodthirst = 23881,
		EnragedRegeneration = 184364,
		PiercingHowl = 12323,
		RagingBlow = 85288,
		Rampage = 184367,
		Recklessness = 1719,		
	}
	ids.Fury_Passive = {
		Enrage = 184361,
		MasteryUnshackledFury = 76856,
		SingleMindedFury = 81099,
		TitansGrip = 46917,
	}
	ids.Fury_Talent = {
		--15
		WarMachine = 346002,
		SuddenDeath = 280721,		
		FreshMeat = 215568,		
		--25
		DoubleTime = 103827,
		ImpendingVictory = 202168,
		StormBolt = 107570,
		--30		
		Massacre = 206315,
			MassacreExecute = 280735,
		Frenzy = 335077,
		Onslaught = 315720,
		--35
		FuriousCharge = 202224,
		BoundingStride = 202163,
		Warpaint = 208154,
		--40
		Seethe = 335091,
		FrothingBerserker = 215571,
		Cruelty = 335070,
		--45
		MeatCleaver = 280392,
		DragonRoar = 118000,
		Bladestorm = 46924,
		--50
		AngerManagement = 152278,
		RecklessAbandon = 202751,
			Bloodbath = 335096,
			CrushingBlow = 335097,
		Siegebreaker = 280772,
	}
	ids.Fury_Form = {
	
	}
	ids.Fury_Buff = {
		BattleShout = 6673,
		Enrage = 184362,
		FuriousSlash = 202539,
		IgnorePain = 190456,
		Whirlwind = 85739,
		SuddenDeath = 280776,
		Recklessness = 1719,
		Victorious = 32216,
	}
	ids.Fury_Debuff = {
		Siegebreaker = 280773,
	}
	ids.Fury_PetAbility = {

	}

--Protection
	ids.Prot_Ability = {
	--Warrior
		BattleShout = 6673,
		BerserkerRage = 18499,
		ChallengingShout = 1161,
		Charge = 100,
		Execute = 163201,
		Hamstring = 1715,
		HeroicLeap = 6544,
		HeroicThrow = 57755,
		IgnorePain = 190456,
		Intervene = 3411,
		IntimidatingShout = 5246,
		Pummel = 6552,
		RallyingCry = 97462,
		ShatteringThrow = 64382,
		ShieldBlock = 2565,
		ShieldSlam = 23922,
		SpellReflection = 23920,
		Taunt = 355,
		VictoryRush = 34428,
		Whirlwind = 1680,
	--Protection
		Avatar = 107574,
		DemoralizingShout = 1160,
		Devastate = 20243,
		LastStand = 12975,
		Revenge = 6572,
		ShieldWall = 871,
		Shockwave = 46968,
		ThunderClap = 6343,		
	}
	ids.Prot_Passive = {
		DeepWounds = 115768,
		MasteryCriticalBlock = 76857,
		Riposte = 161798,
		Vanguard = 71,
	}
	ids.Prot_Talent = {
		--15
		WarMachine = 316733,
		Punish = 275334,		
		Devastator = 236279,		
		--25		
		DoubleTime = 103827,
		RumblingEarth = 275339,
		StormBolt = 107570,		
		--30
		BestServedCold = 202560,
		BoomingVoice = 202743,
		DragonRoar = 118000,
		--35		
		CracklingThunder = 203201,
		BoundingStrike = 202163,	
		Menace = 275338,
		--40
		NeverSurrender = 202561,
		Indomitable = 202095,
		ImpendingVictory = 202168,
		--45
		IntotheFray = 202603,
		UnstoppableForce = 275336,
		Ravager = 228920,		
		--50	
		AngerManagement = 152278,
		HeavyRepercussions = 203177,
		Bolster = 280001,	
	}
	ids.Prot_Form = {
	
	}
	ids.Prot_Buff = {
		Avatar = 107574,
		BattleShout = 6673,
		IgnorePain = 190456,
		Revenge = 5302,
		ShieldBlock = 132404,
		Victorious = 32216,
 	}
	ids.Prot_Debuff = {
		DeepWounds = 115767,
		DemoralizingShout = 1160,
	}
	ids.Prot_PetAbility = {

	}