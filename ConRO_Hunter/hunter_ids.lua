local ConRO_Hunter, ids = ...;

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
		DeathChakram = 325028,
		FlayedShot = 324149,
		Fleshcraft = 324631,
		PhialofSerenity = 177278,
		ResonatingArrow = 308491,
		Soulshape = 310143,
		SummonSteward = 324739,
		WildSpirits = 328231,
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
		HarmonyoftheTortollan = 339377,
		MarkmansAdvantage = 339264,
		RejuvenatingWind = 339399,
		ResilienceoftheHunter = 339459,
	--Finesse
		Ambuscade = 346747,
		CheetahsVigor = 339558,
		ReversalofFortune = 339495,
		TacticalRetreat = 339651,
	--Potency
		Bloodletting = 341440,
		BrutalProjectiles = 339924,
		DeadlyChain = 339973,
		DeadlyTandem = 341350,
		EchoingCall = 340876,
		EmpoweredRelease = 339059,
		EnfeebledMark = 339018,
		FerociousAppetite = 339704,
		FlameInfusion = 341399,
		NecroticBarrage = 339129,
		OneWiththeBeast = 339750,
		PowerfulPrecision = 340033,
		SharpshootersFocus = 339920,
		SpiritAttunement = 339109,
		StingingStrike = 341246,
		StrengthofthePack = 341222,
	}
	ids.Covenant_Buff = {
		FlayersMark = 324156,
	}
	ids.Covenant_Debuff = {	

	}
	ids.Legendary = {
	--Neutral
		EchoofEonar_Finger = "item:178926::::::::::::1:7100",
		EchoofEonar_Waist = "item:172328::::::::::::1:7100",
		EchoofEonar_Wrist = "item:172329::::::::::::1:7100",
		JudgementoftheArbiter_Finger = "item:178926::::::::::::1:7101",
		JudgementoftheArbiter_Hands = "item:172324::::::::::::1:7101",
		JudgementoftheArbiter_Wrist = "item:172329::::::::::::1:7101",
		MawRattle_Feet = "item:172323::::::::::::1:7159",
		MawRattle_Hands = "item:172324::::::::::::1:7159",
		MawRattle_Legs = "item:172326::::::::::::1:7159",
		NorgannonsSagacity_Back = "item:173242::::::::::::1:7102",
		NorgannonsSagacity_Feet = "item:172323::::::::::::1:7102",
		NorgannonsSagacity_Legs = "item:172326::::::::::::1:7102",
		SephuzsProclamation_Chest = "item:172322::::::::::::1:7103",
		SephuzsProclamation_Neck = "item:178927::::::::::::1:7103",
		SephuzsProclamation_Shoulder = "item:172327::::::::::::1:7103",
		StablePhantasmaLure_Back = "item:173242::::::::::::1:7104",
		StablePhantasmaLure_Neck = "item:178927::::::::::::1:7104",
		StablePhantasmaLure_Wrist = "item:172329::::::::::::1:7104",
		ThirdEyeoftheJailer_Head = "item:172325::::::::::::1:7105",
		ThirdEyeoftheJailer_Shoulder = "item:172327::::::::::::1:7105",
		ThirdEyeoftheJailer_Waist = "item:172328::::::::::::1:7105",
		VitalitySacrifice_Chest = "item:172322::::::::::::1:7106",
		VitalitySacrifice_Head = "item:172325::::::::::::1:7106",
		VitalitySacrifice_Shoulder = "item:172327::::::::::::1:7106",
	--Hunter
		CalloftheWild_Finger = "item:178926::::::::::::1:7003",
		CalloftheWild_Wrist = "item:172329::::::::::::1:7003",
		CravenStrategem_Chest = "item:172322::::::::::::1:7006",
		CravenStrategem_Neck = "item:178927::::::::::::1:7006",
		NesingwarysTrappingApparatus_Feet = "item:172323::::::::::::1:7004",
		NesingwarysTrappingApparatus_Waist = "item:172328::::::::::::1:7004",
		SoulforgeEmbers_Head = "item:172325::::::::::::1:7005", -- Flag for Rotation
		SoulforgeEmbers_Shoulder = "item:172327::::::::::::1:7005",
	--BeastMastery
		DireCommand_Chest = "item:172322::::::::::::1:7007",
		DireCommand_Finger = "item:178926::::::::::::1:7007",
		FlamewakersCobraSting_Feet = "item:172323::::::::::::1:7008",
		FlamewakersCobraSting_Legs = "item:172326::::::::::::1:7008",
		QaplaEredunWarOrder_Hands = "item:172324::::::::::::1:7009",
		QaplaEredunWarOrder_Shoulder = "item:172327::::::::::::1:7009",
		RylakstalkersPiercingFangs_Back = "item:173242::::::::::::1:7010",
		RylakstalkersPiercingFangs_Feet = "item:172323::::::::::::1:7010",
	--Marksmanship
		EagletalonsTrueFocus_Head = "item:172325::::::::::::1:7011",
		EagletalonsTrueFocus_Waist = "item:172328::::::::::::1:7011",
		SecretsoftheUnblinkingVigil_Hands = "item:172324::::::::::::1:7014",
		SecretsoftheUnblinkingVigil_Wrist = "item:172329::::::::::::1:7014",
		SerpentstalkersTrickery_Finger = "item:178926::::::::::::1:7013", -- Flag for Rotation
		SerpentstalkersTrickery_Shoulder = "item:172327::::::::::::1:7013",
		SurgingShots_Neck = "item:178927::::::::::::1:7012",
		SurgingShots_Wrist = "item:172329::::::::::::1:7012",
	--Survival
		ButchersBoneFragments_Back = "item:173242::::::::::::1:7018", -- Flag for Rotation
		ButchersBoneFragments_Chest = "item:172322::::::::::::1:7018",
		LatentPoisonInjectors_Hands = "item:172324::::::::::::1:7017",
		LatentPoisonInjectors_Head = "item:172325::::::::::::1:7017",
		RylakstalkersConfoundingStrikes_Back = "item:173242::::::::::::1:7016",
		RylakstalkersConfoundingStrikes_Legs = "item:172326::::::::::::1:7016",
		WildfireCluster_Legs = "item:172326::::::::::::1:7015",
		WildfireCluster_Waist = "item:172328::::::::::::1:7015",
	}
	ids.Legendary_Buff = {

	}
	ids.Legendary_Debuff = {	
		SoulforgeEmbers = 336746,
	}

--Hunter
	ids.Hunter_Ability = {

	}
	ids.Hunter_Passive = {

	}
	ids.Hunter_Buff = {

	}
	ids.Hunter_Debuff = {

	}	
	
--Beast Mastery
	ids.BM_Ability = {
	--Hunter
		ArcaneShot = 185358,
		AspectoftheCheetah = 186257,
		AspectoftheTurtle = 186265,
		CallPet = nil,
			CallPetOne = 883,
			CallPetTwo = 83242,
			CallPetThree = 83243,
			CallPetFour = 83244,
			CallPetFive = 83245,
		CommandPet = 272651,
			PrimalRage = 272678,
			SurvivaloftheFittest = 272679,
			MastersCall = 272682,
		Disengage = 781,
		EagleEye = 6197,
		Exhilaration = 109304,
		EyesoftheBeast = 321297,
		FeignDeath = 5384,
		Flare = 1543,
		FreezingTrap = 187650,
		HuntersMark = 257284,
		KillShot = 53351,
		Misdirection = 34477,
		PetUtility = nil,
			BeastLore = 1462,
			DismissPet = 2641,
			FeedPet = 6991,
			RevivePet = 982,
			MendPet = 136,
			TameBeast = 1515,
		ScareBeast = 1513,	
		TarTrap = 187698,
		TranquilizingShot = 19801,
	--Beast Mastery
		AspectoftheWild = 193530,
		BarbedShot = 217200,
		BestialWrath = 19574,
		CobraShot = 193455,
		ConcussiveShot = 5116,
		CounterShot = 147362,
		Intimidation = 19577,
		KillCommand = 34026,	
		MultiShot = 2643,
	}
	ids.BM_Passive = {
		BeastCleave = 115939,
		ExoticBeasts = 53270,
		KindredSpirits = 56315,
		MasteryMasterofBeasts = 76657,
		PackTactics = 321014,
		WildCall = 185789,
	}
	ids.BM_Talent = {
		--15
		KillerInstinct = 273887,
		AnimalCompanion = 267116,
		DireBeast = 120679,
		--25
		ScentofBlood = 193532,
		OnewiththePack = 199528,
		ChimaeraShot = 53209,
		--30
		Trailblazer = 199921,
		NaturalMending = 270581,
		Camouflage = 199483,
		--35
		SpittingCobra = 257891,
		ThrilloftheHunt = 257944,
		AMurderofCrows = 131894,
		--40
		BornToBeWild = 266921,
		Posthaste = 109215,
		BindingShot = 109248,
		--45
		Stomp = 199530,
		Barrage = 120360,
		Stampede = 201430,
		--50
		AspectoftheBeast = 191384,
		KillerCobra = 199532,
		Bloodshed = 321530,
	}
	ids.BM_PvPTalent = {
		--Honorable Medallion
		Adaptation = 214027,
		Relentless = 196029,
		GladiatorsMedallion = 208683,
		--

	}
	ids.BM_Form = {
	
	}
	ids.BM_Buff = {
		AspectoftheWild = 193530,
		BestialWrath = 19574,
		BeastCleave = 268877,
		Frenzy = 272790,
	}
	ids.BM_Debuff = {
		HuntersMark = 257284,
		TarTrap = 135299,
	}
	ids.BM_PetAbility = {
		Bite = 17253,
		Claw = 16827,
		Smack = 49966,
		ChiJisTranquility = 264028,
		NaturesGrace = 264266,
		NetherShock = 264264,
		SerenityDust = 264055,
		SonicBlast = 264263,
		SporeCloud = 264056,

		SoothingWater = 264262,
		SpiritShock = 264265,		
	}
		
--Marksmanship
	ids.MM_Ability = {
	--Hunter
		ArcaneShot = 185358,
		AspectoftheCheetah = 186257,
		AspectoftheTurtle = 186265,
		CallPet = nil,
			CallPetOne = 883,
			CallPetTwo = 83242,
			CallPetThree = 83243,
			CallPetFour = 83244,
			CallPetFive = 83245,
		CommandPet = 272651,
			PrimalRage = 272678,
			SurvivaloftheFittest = 272679,
			MastersCall = 272682,
		Disengage = 781,
		EagleEye = 6197,
		Exhilaration = 109304,
		EyesoftheBeast = 321297,
		FeignDeath = 5384,
		Flare = 1543,
		FreezingTrap = 187650,
		HuntersMark = 257284,
		KillShot = 53351,
		Misdirection = 34477,
		PetUtility = nil,
			BeastLore = 1462,
			DismissPet = 2641,
			FeedPet = 6991,
			RevivePet = 982,
			MendPet = 136,
			TameBeast = 1515,
		ScareBeast = 1513,
		SteadyShot = 56641,
		SurvivaloftheFittestLW = 281195,		
		TarTrap = 187698,
		TranquilizingShot = 19801,
	--Marksmanship
		AimedShot = 19434,
		BindingShot = 109248,
		BurstingShot = 186387,
		ConcussiveShot = 5116,
		CounterShot = 147362,
		MultiShot = 257620,
		RapidFire = 257044,
		Trueshot = 288613,
	}
	ids.MM_Passive = {
		LoneWolf = 155228,
		MasterySniperTraining = 193468,
		PreciseShots = 260240,
		TrickShots = 257621,
	}
	ids.MM_Talent = {
		--15
		MasterMarksman = 260309,
		SerpentSting = 271788,
		AMurderofCrows = 131894,
		--25
		CarefulAim = 260228,
		Barrage = 120360,
		ExplosiveShot = 212431,
		--30
		Trailblazer = 199921,
		NaturalMending = 270581,
		Camouflage = 199483,		
		--35
		SteadyFocus = 193533,
		Streamline = 260367,
		ChimaeraShot = 342049,
		--40
		BornToBeWild = 266921,
		Posthaste = 109215,
		BindingShackles = 321468,
		--45
		LethalShots = 260393,
		DeadEye = 321460,
		DoubleTap = 260402,
		--50
		CallingtheShots = 260404,
		LockandLoad = 194595,
		Volley = 260243,
	}
	ids.MM_PvPTalent = {
		--Honorable Medallion
		Adaptation = 214027,
		Relentless = 196029,
		GladiatorsMedallion = 208683,
		--
		DragonscaleArmor = 202589,
		SurvivalTactics = 202746,
		ViperSting = 202797,
		ScorpidSting = 202900,
		SpiderSting = 202914,
		ScatterShot = 213691,
		HiExplosiveTrap = 236776,
		TrueshotMastery = 203129,
		RangersFinesse = 248443,
		SniperShot = 203155,
		RoarofSacrifice = 53480,
		HuntingPack = 203235,
	}
	ids.MM_Form = {
		LoneWolf = 164273,
	}
	ids.MM_Buff = {
		PreciseShots = 260242,
		TrickShots = 257622,
		Trueshot = 193526,
		LockandLoad = 194594,
		SteadyFocus = 193534,
		LethalShots = 260395,
		DoubleTap = 260402,
		DeadEye = 321461,
	}
	ids.MM_Debuff = {
		HuntersMark = 257284,
		SerpentSting = 271788,
		TarTrap = 135299,
		Volley = 260243,
	}
	ids.MM_PetAbility = {
		ChiJisTranquility = 264028,
		NaturesGrace = 264266,
		NetherShock = 264264,
		SerenityDust = 264055,
		SonicBlast = 264263,
		SporeCloud = 264056,
	}

--Survival
	ids.Surv_Ability = {
	--Hunter
		ArcaneShot = 185358,
		AspectoftheCheetah = 186257,
		AspectoftheTurtle = 186265,
		CallPet = nil,
			CallPetOne = 883,
			CallPetTwo = 83242,
			CallPetThree = 83243,
			CallPetFour = 83244,
			CallPetFive = 83245,
		CommandPet = 272651,
			PrimalRage = 272678,
			SurvivaloftheFittest = 272679,
			MastersCall = 272682,
		Disengage = 781,
		EagleEye = 6197,
		Exhilaration = 109304,
		EyesoftheBeast = 321297,
		FeignDeath = 5384,
		Flare = 1543,
		FreezingTrap = 187650,
		HuntersMark = 257284,
		KillShot = 320976,
		Misdirection = 34477,
		PetUtility = nil,
			BeastLore = 1462,
			DismissPet = 2641,
			FeedPet = 6991,
			RevivePet = 982,
			MendPet = 136,
			TameBeast = 1515,
		ScareBeast = 1513,
		SteadyShot = 56641,
		SurvivaloftheFittestLW = 281195,		
		TarTrap = 187698,
		TranquilizingShot = 19801,
		WingClip = 195645,
	--Survival
		AspectoftheEagle = 186289,
		Carve = 187708,
		CoordinatedAssault = 266779,
		Harpoon = 190925,
		Intimidation = 19577,
		KillCommand = 259489,
		Muzzle = 187707,
		RaptorStrike = 186270,
			RaptorStrikeRanged = 265189,
		SerpentSting = 259491,
		WildfireBomb = 259495,
	}
	ids.Surv_Passive = {
		MasterySpiritBond = 263135,
	}
	ids.Surv_Talent = {
		--15
		VipersVenom = 268501,
		TermsofEngagement = 265895,
		AlphaPredator = 269737,
		--25
		GuerrillaTactics = 264332,
		HydrasBite = 260241,
		Butchery = 212436,
		--30
		Trailblazer = 199921,
		NaturalMending = 270581,
		Camouflage = 199483,
		--35
		Bloodseeker = 260248,
		SteelTrap = 162488,
		AMurderofCrows = 131894,
		--40
		BornToBeWild = 266921,
		Posthaste = 109215,
		BindingShot = 109248,
		--45
		TipoftheSpear = 260285,
		MongooseBite = 259387,
			MongooseBiteRanged = 265888,
		FlankingStrike = 269751,
		--50
		BirdsofPrey = 260331,
		WildfireInfusion = 271014,
			ShrapnelBomb = 270335,
			PheromoneBomb = 270323,
			VolatileBomb = 271045,
		Chakrams = 259391,
	}
	ids.Surv_PvPTalent = {

	}
	ids.Surv_Form = {

	}
	ids.Surv_Buff = {
		AspectoftheEagle = 186289,
		CoordinatedAssault = 266779,
		MongooseFury = 259388,
		TipoftheSpear = 260286,
		VipersVenom = 268552,
	}
	ids.Surv_Debuff = {
		HuntersMark = 257284,
		InternalBleeding = 270343,
		SerpentSting = 259491,
		TarTrap = 135299,
		WildfireBomb = 269747,
			ShrapnelBomb = 270339,
			PheromoneBomb = 270332,
			VolatileBomb = 271049,
	}
	ids.Surv_PetAbility = {
		Bite = 17253,
		Claw = 16827,
		Smack = 49966,
		ToxicSting = 263858,
		ChiJisTranquility = 264028,
		NaturesGrace = 264266,
		NetherShock = 264264,
		SerenityDust = 264055,
		SonicBlast = 264263,
		SporeCloud = 264056,
	}