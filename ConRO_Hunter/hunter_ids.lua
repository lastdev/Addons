local ConRO_Hunter, ids = ...;

--General
	ids.Racial = {
		AncestralCall = 274738,
		ArcanePulse = 260364,
		ArcaneTorrent = 80483,
		Berserking = 26297,
	}
	ids.AzTrait = {
		DanceofDeath = 274441,
		FocusedFire = 278531,
		PrimalInstincts = 279806,
		SteadyAim = 277651,
		SurgingShots = 287707,
	}
	ids.AzTraitBuff = {
		DanceofDeath = 274443,
	}
	ids.AzEssence = {
		BloodoftheEnemy = 298273,
		ConcentratedFlame = 295373,
		FocusedAzeriteBeam =295258,
		GuardianofAzeroth = 299358,
		MemoryofLucidDream = 298357,
		ReapingFlames = 310690,
		TheUnboundForce = 298452,
		WorldveinResonance = 295186,	
	}
	ids.AzEssenceBuff = {
		MemoryofLucidDream = 298357,	
	}
	ids.AzEssenceDebuff = {	
		ConcentratedFlame = 295368,
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
		--Honorable Medallion
		Adaptation = 214027,
		Relentless = 196029,
		GladiatorsMedallion = 208683,
		--

	}
	ids.Surv_Form = {

	}
	ids.Surv_Buff = {
		CoordinatedAssault = 266779,
		AspectoftheEagle = 186289,
		VipersVenom = 268552,
		MongooseFury = 259388,
	}
	ids.Surv_Debuff = {
		HuntersMark = 257284,
		SerpentSting = 259491,
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