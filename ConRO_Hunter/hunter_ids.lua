local ConRO_Hunter, ids = ...;

--General
	ids.Racial = {
		AncestralCall = {spellID = 274738},
		ArcanePulse = {spellID = 260364},
		ArcaneTorrent = {spellID = 50613},
		Berserking = {spellID = 26297},
		Cannibalize = {spellID = 20577},
		GiftoftheNaaru = {spellID = 59548},
		Shadowmeld = {spellID = 58984},
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
		ArcaneShot = {spellID = 185358},
		AspectoftheCheetah = {spellID = 186257},
		AspectoftheTurtle = {spellID = 186265},
		BindingShot = {spellID = 109248, talentID = 100650},
		CallPet = {
			One = {spellID = 883},
			Two = {spellID = 83242},
			Three = {spellID = 83243},
			Four = {spellID = 83244},
			Five = {spellID = 83245},
		},
		Camouflage = {spellID = 199483, talentID = 100647},
		CommandPet = {
			PrimalRage = {spellID = 272678},
			FortitudeoftheBear = {spellID = 272679},
			MastersCall = {spellID = 272682},
		},
		Barrage = {spellID = 120360, talentID = 100526},
		ConcussiveShot = {spellID = 5116, talentID = 100616},
		CounterShot = {spellID = 147362, talentID = 100624},
		DeathChakram = {spellID = 375891, talentID = 100628},
		Disengage = {spellID = 781},
		EagleEye = {spellID = 6197},
		Exhilaration = {spellID = 109304},
		ExplosiveShot = {spellID = 212431, talentID = 100626},
		EyesoftheBeast = {spellID = 321297},
		FeignDeath = {spellID = 5384},
		Flare = {spellID = 1543},
		FreezingTrap = {spellID = 187650},
		HighExplosiveTrap = {spellID = 236776, talentID = 100620},
		HuntersMark = {spellID = 257284},
		Intimidation = {spellID = 19577, talentID = 100621},
		KillCommand = {spellID = 34026, talentID = 100648},
		KillShot = {spellID = 53351, talentID = 100539},
		Misdirection = {spellID = 34477, talentID = 100637},
		PetUtility = {
			BeastLore = {spellID = 1462},
			DismissPet = {spellID = 2641},
			FeedPet = {spellID = 6991},
			RevivePet = {spellID = 982},
			MendPet = {spellID = 136},
			TameBeast = {spellID = 1515},
		},
		ScareBeast = {spellID = 1513, talentID = 100640},
		ScatterShot = {spellID = 213691, talentID = 100651},
		SentinelOwl = {spellID = 388045, talentID = 100520},
		SerpentSting = {spellID = 271788, talentID = 100615},
		Stampede = {spellID = 201430, talentID = 100629},
		SteadyShot = {spellID = 56641},
		SteelTrap = {spellID = 162488, talentID = 100618},
		SurvivaloftheFittest = {spellID = 264735, talentID = 100523},
		TarTrap = {spellID = 187698, talentID = 100641},
		TranquilizingShot = {spellID = 19801, talentID = 100617},
		WingClip = {spellID = 195645},
	--Beast Mastery
		AMurderofCrows = {spellID = 131894, talentID = 100657},
		AspectoftheWild = {spellID = 193530, talentID = 100664},
		BarbedShot = {spellID = 217200, talentID = 100683},
		BestialWrath = {spellID = 19574, talentID = 100669},
		Bloodshed = {spellID = 321530, talentID = 100525},
		CalloftheWild = {spellID = 359844, talentID = 100682},
		CobraShot = {spellID = 193455, talentID = 100663},
		DireBeast = {spellID = 120679, talentID = 100673},
		MultiShot = {spellID = 2643, talentID = 100630},
		WailingArrow = {spellID = 392060, talentID = 100652},
	}
	ids.BM_Passive = {
	--Hunter
		AlphaPredator = {spellID = 269737, talentID = 100613},
		ArcticBola = {spellID = 390231, talentID = 100514},
		BeastMaster = {spellID = 378007, talentID = 100639},
		BindingShackles = {spellID = 321468, talentID = 100633},
		BornToBeWild = {spellID = 266921, talentID = 100646},
		Entrapment = {spellID = 393344, talentID = 100692},
		HuntersAvoidance = {spellID = 384799, talentID = 100536},
		HydrasBite = {spellID = 260241, talentID = 100622},
		ImprovedKillCommand = {spellID = 378010, talentID = 100645},
		ImprovedKillShot = {spellID = 343248, talentID = 100643},
		ImprovedTranquilizingShot = {spellID = 343244, talentID = 100632},
		ImprovedTraps = {spellID = 343247, talentID = 100636},
		KeenEyesight = {spellID = 378004, talentID = 100635},
		KillerInstinct = {spellID = 273887, talentID = 100614},
		LoneSurvivor = {spellID = 388039, talentID = 100522},
		MasterMarksman = {spellID = 260309, talentID = 100625},
		NaturalMending = {spellID = 270581, talentID = 100638},
		NaturesEndurance = {spellID = 388042, talentID = 100521},
		Pathfinding = {spellID = 378002},
		PoisonInjection = {spellID = 378014, talentID = 100623},
		Posthaste = {spellID = 109215, talentID = 100634},
		RejuvenatingWind = {spellID = 385539, talentID = 100619},
		SentinelsPerception = {spellID = 388056, talentID = 100519},
		SentinelsProtection = {spellID = 388057, talentID = 100518},
		SerratedShots = {spellID = 389882, talentID = 100513},
		Trailblazer = {spellID = 199921, talentID = 100644},
		WildernessMedicine = {spellID = 343242, talentID = 100649},
	--Beast Mastery
		AnimalCompanion = {spellID = 267116, talentID = 100661},
		AspectoftheBeast = {spellID = 191384, talentID = 100658},
		BarbedWrath = {spellID = 231548, talentID = 100524},
		BeastCleave = {spellID = 115939, talentID = 100670},
		BloodyFrenzy = {spellID = 378739, talentID = 100612},
		BrutalCompanion = {spellID = 386870, talentID = 100515},
		CobraSenses = {spellID = 378244, talentID = 100678},
		CobraSting = {spellID = 378750, talentID = 100655},
		DireCommand = {spellID = 378743, talentID = 100667},
		DireFrenzy = {spellID = 385810, talentID = 100527},
		DirePack = {spellID = 378745, talentID = 100654},
		ExoticBeasts = {spellID = 53270},
		HuntersPrey = {spellID = 378210, talentID = 100665},
		KillCleave = {spellID = 378207, talentID = 100668},
		KillerCobra = {spellID = 199532, talentID = 100676},
		KillerCommand = {spellID = 378740, talentID = 100653},
		KindredSpirits = {spellID = 56315, talentID = 100671},
		MasterHandler = {spellID = 389654, talentID = 100677},
		MasteryMasterofBeasts = {spellID = 76657},
		OnewiththePack = {spellID = 199528, talentID = 100674},
		PackTactics = {spellID = 321014, talentID = 100672},
		PiercingFangs = {spellID = 392053, talentID = 100675},
		ScentofBlood = {spellID = 193532, talentID = 100680},
		SharpBarbs = {spellID = 378205, talentID = 100659},
		SnakeBite = {spellID = 389660, talentID = 100516},
		Stomp = {spellID = 199530, talentID = 1006564},
		ThrilloftheHunt = {spellID = 257944, talentID = 100679},
		TrainingExpert = {spellID = 378209, talentID = 100662},
		WarOrders = {spellID = 393933, talentID = 100666},
		WildCall = {spellID = 185789, talentID = 100681},
		WildInstincts = {spellID = 378442, talentID = 100660},
	}

	ids.BM_PvPTalent = {

	}
	ids.BM_Form = {
	
	}
	ids.BM_Buff = {
		AspectoftheWild = 193530,
		BestialWrath = 19574,
		BeastCleave = 268877,
		CalloftheWild = 359844,
		Frenzy = 272790,
		HuntersPrey = 378215,
	}
	ids.BM_Debuff = {
		HuntersMark = 257284,
		SerpentSting = 271788,
		TarTrap = 135299,
	}
	ids.BM_PetAbility = {
		Bite = {spellID = 17253},
		Claw = {spellID = 16827},
		Smack = {spellID = 49966},
		ChiJisTranquility = {spellID = 264028},
		NaturesGrace = {spellID = 264266},
		NetherShock = {spellID = 264264},
		PrimalRage = {spellID = 264667},
		SerenityDust = {spellID = 264055},
		SonicBlast = {spellID = 264263},
		SporeCloud = {spellID = 264056},
		SoothingWater = {spellID = 264262},
		SpiritShock = {spellID = 264265},
	}
		
--Marksmanship
	ids.MM_Ability = {
	--Hunter
		ArcaneShot = {spellID = 185358},
		AspectoftheCheetah = {spellID = 186257},
		AspectoftheTurtle = {spellID = 186265},
		BindingShot = {spellID = 109248, talentID = 100650},--
		CallPet = {
			One = {spellID = 883},
			Two = {spellID = 83242},
			Three = {spellID = 83243},
			Four = {spellID = 83244},
			Five = {spellID = 83245},
		},
		Camouflage = {spellID = 199483, talentID = 100647},--
		CommandPet = {
			PrimalRage = {spellID = 272678},
			FortitudeoftheBear = {spellID = 272679},
			MastersCall = {spellID = 272682},
		},
		Barrage = {spellID = 120360, talentID = 100526},--
		ConcussiveShot = {spellID = 5116, talentID = 100616},--
		CounterShot = {spellID = 147362, talentID = 100540},--
		DeathChakram = {spellID = 375891, talentID = 100628},--
		Disengage = {spellID = 781},
		EagleEye = {spellID = 6197},
		Exhilaration = {spellID = 109304},
		ExplosiveShot = {spellID = 212431, talentID = 100626},--
		EyesoftheBeast = {spellID = 321297},
		FeignDeath = {spellID = 5384},
		Flare = {spellID = 1543},
		FreezingTrap = {spellID = 187650},
		HighExplosiveTrap = {spellID = 236776, talentID = 100620},--
		HuntersMark = {spellID = 257284},
		Intimidation = {spellID = 19577, talentID = 100621},--
		KillCommand = {spellID = 34026, talentID = 100541},--
		KillShot = {spellID = 53351, talentID = 100539},--
		Misdirection = {spellID = 34477, talentID = 100637},--
		PetUtility = {
			BeastLore = {spellID = 1462},
			DismissPet = {spellID = 2641},
			FeedPet = {spellID = 6991},
			RevivePet = {spellID = 982},
			MendPet = {spellID = 136},
			TameBeast = {spellID = 1515},
		},
		ScareBeast = {spellID = 1513, talentID = 100640},--
		ScatterShot = {spellID = 213691, talentID = 100651},--
		SentinelOwl = {spellID = 388045, talentID = 100520},--
		SerpentSting = {spellID = 271788, talentID = 100615},--
		Stampede = {spellID = 201430, talentID = 100629},--
		SteadyShot = {spellID = 56641},
		SteelTrap = {spellID = 162488, talentID = 100618},--
		SurvivaloftheFittest = {spellID = 264735, talentID = 100523},--
		TarTrap = {spellID = 187698, talentID = 100641},--
		TranquilizingShot = {spellID = 19801, talentID = 100617},--
		WingClip = {spellID = 195645},
	--Marksmanship
		AimedShot = {spellID = 19434, talentID = 100578},--
		BurstingShot = {spellID = 186387, talentID = 100577},--
		ChimaeraShot = {spellID = 342049, talentID = 100627},--
		MultiShot = {spellID = 257620, talentID = 100544},--
		RapidFire = {spellID = 257044, talentID = 100585},--
		Salvo = {spellID = 400456, talentID = 100534},--
		Trueshot = {spellID = 288613, talentID = 100587},--
		Volley = {spellID = 260243, talentID = 100595},--
		WailingArrow = {spellID = 392060, talentID = 100590},--
	}
	ids.MM_Passive = {
	--Hunter
		AlphaPredator = {spellID = 269737, talentID = 100613},--
		ArcticBola = {spellID = 390231, talentID = 100514},--
		BeastMaster = {spellID = 378007, talentID = 100639},--
		BindingShackles = {spellID = 321468, talentID = 100633},--
		BornToBeWild = {spellID = 266921, talentID = 100646},--
		Entrapment = {spellID = 393344, talentID = 100692},--
		HuntersAvoidance = {spellID = 384799, talentID = 100536},--
		HydrasBite = {spellID = 260241, talentID = 100622},--
		ImprovedKillCommand = {spellID = 378010, talentID = 100645},--
		ImprovedKillShot = {spellID = 343248, talentID = 100643},--
		ImprovedTranquilizingShot = {spellID = 343244, talentID = 100632},--
		ImprovedTraps = {spellID = 343247, talentID = 100636},--
		KeenEyesight = {spellID = 378004, talentID = 100635},--
		KillerInstinct = {spellID = 273887, talentID = 100614},--
		LoneSurvivor = {spellID = 388039, talentID = 100522},--
		MasterMarksman = {spellID = 260309, talentID = 100625},--
		NaturalMending = {spellID = 270581, talentID = 100638},--
		NaturesEndurance = {spellID = 388042, talentID = 100521},--
		Pathfinding = {spellID = 378002, talentID = 100631},--
		PoisonInjection = {spellID = 378014, talentID = 100623},--
		Posthaste = {spellID = 109215, talentID = 100634},--
		RejuvenatingWind = {spellID = 385539, talentID = 100619},--
		SentinelsPerception = {spellID = 388056, talentID = 100519},--
		SentinelsProtection = {spellID = 388057, talentID = 100518},--
		SerratedShots = {spellID = 389882, talentID = 100513},--
		Trailblazer = {spellID = 199921, talentID = 100644},--
		WildernessMedicine = {spellID = 343242, talentID = 100649},--
	--Marksmanship
		Bombardment = {spellID = 378880, talentID = 100594},--
		Bulletstorm = {spellID = 389019, talentID = 100517},--
		Bullseye = {spellID = 204089, talentID = 100581},--
		CallingtheShots = {spellID = 260404, talentID = 100609},--
		CarefulAim = {spellID = 260228, talentID = 100584},--
		CrackShot = {spellID = 321293, talentID = 100600},--
		Deadeye = {spellID = 321460, talentID = 100597},--
		Deathblow = {spellID = 378769, talentID = 100588},--
		EagletalonsTrueFocus = {spellID = 389449, talentID = 100607},--
		FocusedAim = {spellID = 378767, talentID = 100601},--
		HeavyAmmo = {spellID = 378910, talentID = 100611},--
		HuntersKnowledge = {spellID = 378766, talentID = 100593},--
		ImprovedSteadyShot = {spellID = 321018, talentID = 100604},--
		KillerAccuracy = {spellID = 378765, talentID = 100606},--
		LegacyoftheWindrunners = {spellID = 190852, talentID = 100605},--
		LethalShots = {spellID = 260393, talentID = 100603},--
		LightAmmo = {spellID = 378913, talentID = 100610},--
		LockandLoad = {spellID = 194595, talentID = 100589},--
		LoneWolf = {spellID = 155228, talentID = 100576},--
		MasterySniperTraining = {spellID = 193468},
		PreciseShots = {spellID = 260240, talentID = 100582},--
		QuickLoad = {spellID = 378771, talentID = 100583},--
		RazorFragments = {spellID = 384790, talentID = 100535},--
		Readiness = {spellID = 389865, talentID = 389865},--
		SerpentstalkersTrickery = {spellID = 378888, talentID = 100586},--
		Sharpshooter = {spellID = 378907, talentID = 100592},--
		SteadyFocus = {spellID = 193533, talentID = 100596},--
		Streamline = {spellID = 260367, talentID = 100598},--
		SurgingShots = {spellID = 391559, talentID = 100602},--
		TacticalReload= {spellID = 400472, talentID = 100579},--
		TargetPractice = {spellID = 321287, talentID = 100591},--
		TrickShots = {spellID = 257621, talentID = 100580},--
		UnerringVision = {spellID = 386878, talentID = 100608},--
		WindrunnersBarrage = {spellID = 389866, talentID = 100512},--
		WindrunnersGuidance = {spellID = 378905, talentID = 100599},--
	}

	ids.MM_PvPTalent = {

	}
	ids.MM_Form = {
		LoneWolf = 164273,
	}
	ids.MM_Buff = {
		Deathblow = 378770,
		PreciseShots = 260242,
		TrickShots = 257622,
		Trueshot = 193526,
		LockandLoad = 194594,
		RazorFragments = 388998,
		SteadyFocus = 193534,
		LethalShots = 260395,
		DeadEye = 321461,
	}
	ids.MM_Debuff = {
		ExplosiveShot = 212431,
		HuntersMark = 257284,
		SerpentSting = 271788,
		TarTrap = 135299,
		Volley = 260243,
	}
	ids.MM_PetAbility = {
		Bite = {spellID = 17253},
		Claw = {spellID = 16827},
		Smack = {spellID = 49966},
		ChiJisTranquility = {spellID = 264028},
		NaturesGrace = {spellID = 264266},
		NetherShock = {spellID = 264264},
		PrimalRage = {spellID = 264667},
		SerenityDust = {spellID = 264055},
		SonicBlast = {spellID = 264263},
		SporeCloud = {spellID = 264056},
		SoothingWater = {spellID = 264262},
		SpiritShock = {spellID = 264265},
	}

--Survival
	ids.Surv_Ability = {
	--Hunter
		ArcaneShot = {spellID = 185358},
		AspectoftheCheetah = {spellID = 186257},
		AspectoftheTurtle = {spellID = 186265},
		BindingShot = {spellID = 109248, talentID = 100650},
		CallPet = {
			One = {spellID = 883},
			Two = {spellID = 83242},
			Three = {spellID = 83243},
			Four = {spellID = 83244},
			Five = {spellID = 83245},
		},
		Camouflage = {spellID = 199483, talentID = 100647},
		CommandPet = {
			PrimalRage = {spellID = 272678},
			FortitudeoftheBear = {spellID = 272679},
			MastersCall = {spellID = 272682},
		},
		Barrage = {spellID = 120360, talentID = 100526},
		ConcussiveShot = {spellID = 5116, talentID = 100616},
		DeathChakram = {spellID = 375891, talentID = 100628},
		Disengage = {spellID = 781},
		EagleEye = {spellID = 6197},
		Exhilaration = {spellID = 109304},
		ExplosiveShot = {spellID = 212431, talentID = 100626},
		EyesoftheBeast = {spellID = 321297},
		FeignDeath = {spellID = 5384},
		Flare = {spellID = 1543},
		FreezingTrap = {spellID = 187650},
		HighExplosiveTrap = {spellID = 236776, talentID = 100620},
		HuntersMark = {spellID = 257284},
		Intimidation = {spellID = 19577, talentID = 100621},
		KillCommand = {spellID = 259489, talentID = 100648},
		KillShot = {spellID = 320976, talentID = 100539},
		Misdirection = {spellID = 34477, talentID = 100637},
		Muzzle = {spellID = 187707, talentID = 100543},
		PetUtility = {
			BeastLore = {spellID = 1462},
			DismissPet = {spellID = 2641},
			FeedPet = {spellID = 6991},
			RevivePet = {spellID = 982},
			MendPet = {spellID = 136},
			TameBeast = {spellID = 1515},
		},
		ScareBeast = {spellID = 1513, talentID = 100640},
		ScatterShot = {spellID = 213691, talentID = 100651},
		SentinelOwl = {spellID = 388045, talentID = 100520},
		SerpentSting = {spellID = 271788, talentID = 100615},
		Stampede = {spellID = 201430, talentID = 100629},
		SteadyShot = {spellID = 56641},
		SteelTrap = {spellID = 162488, talentID = 100618},
		SurvivaloftheFittest = {spellID = 264735, talentID = 100523},
		TarTrap = {spellID = 187698, talentID = 100641},
		TranquilizingShot = {spellID = 19801, talentID = 100617},
		WingClip = {spellID = 195645},
	--Survival
		AspectoftheEagle = {spellID = 186289, talentID = 100562},
		Butchery = {spellID = 212436, talentID = 100552},
		Carve = {spellID = 187708, talentID = 100553},
		CoordinatedAssault = {spellID = 360952, talentID = 100570},
		FlankingStrike = {spellID = 269751, talentID = 100545},
		FuryoftheEagle = {spellID = 203415, talentID = 100557},
		Harpoon = {spellID = 190925, talentID = 100546},
		MongooseBite = {spellID = 259387, talentID = 100566},
			MongooseBiteRanged = {spellID = 265888, talentID = 100566},
		RaptorStrike = {spellID = 186270, talentID = 100551},
			RaptorStrikeRanged = {spellID = 265189, talentID = 100551},
		Spearhead = {spellID = 360966, talentID = 100571},
		WildfireBomb = {spellID = 259495},
	}
	ids.Surv_Passive = {
	--Hunter
		AlphaPredator = {spellID = 269737, talentID = 100613},
		ArcticBola = {spellID = 390231, talentID = 100514},
		BeastMaster = {spellID = 378007, talentID = 100639},
		BindingShackles = {spellID = 321468, talentID = 100633},
		BornToBeWild = {spellID = 266921, talentID = 100646},
		Entrapment = {spellID = 393344, talentID = 100692},
		HuntersAvoidance = {spellID = 384799, talentID = 100536},
		HydrasBite = {spellID = 260241, talentID = 100622},
		ImprovedKillCommand = {spellID = 378010, talentID = 100645},
		ImprovedKillShot = {spellID = 343248, talentID = 100643},
		ImprovedTranquilizingShot = {spellID = 343244, talentID = 100632},
		ImprovedTraps = {spellID = 343247, talentID = 100636},
		KeenEyesight = {spellID = 378004, talentID = 100635},
		KillerInstinct = {spellID = 273887, talentID = 100614},
		LoneSurvivor = {spellID = 388039, talentID = 100522},
		MasterMarksman = {spellID = 260309, talentID = 100625},
		NaturalMending = {spellID = 270581, talentID = 100638},
		NaturesEndurance = {spellID = 388042, talentID = 100521},
		Pathfinding = {spellID = 378002},
		PoisonInjection = {spellID = 378014, talentID = 100623},
		Posthaste = {spellID = 109215, talentID = 100634},
		RejuvenatingWind = {spellID = 385539, talentID = 100619},
		SentinelsPerception = {spellID = 388056, talentID = 100519},
		SentinelsProtection = {spellID = 388057, talentID = 100518},
		SerratedShots = {spellID = 389882, talentID = 100513},
		Trailblazer = {spellID = 199921, talentID = 100644},
		WildernessMedicine = {spellID = 343242, talentID = 100649},
	--Survival
		BirdsofPrey = {spellID = 260331, talentID = 100569},
		BloodyClaws = {spellID = 385737, talentID = 100532},
		Bloodseeker = {spellID = 260248, talentID = 100564},
		Bombardier = {spellID = 389880, talentID = 100510},
		CoordinatedKill = {spellID = 385739, talentID = 100528},
		DeadlyDuo = {spellID = 378962, talentID = 100574},
		EnergeticAlly = {spellID = 378961, talentID = 100560},
		ExplosivesExpert = {spellID = 378937, talentID = 100563},
		Ferocity = {spellID = 378916, talentID = 100549},
		FlankersAdvantage = {spellID = 263186, talentID = 100565},
		FrenzyStrikes = {spellID = 294029, talentID = 100548},
		GuerillaTactics = {spellID = 264332, talentID = 100572},
		ImprovedWildfireBomb = {spellID = 321290, talentID = 100555},
		IntenseFocus = {spellID = 385709, talentID = 100531},
		KillerCompanion = {spellID = 378955, talentID = 100559},
		Lunge = {spellID = 378934, talentID = 100550},
		MasterySpiritBond = {spellID = 263135},
		QuickShot = {spellID = 378940, talentID = 100573},
		Ranger = {spellID = 385695, talentID = 100529},
		RuthlessMarauder = {spellID = 385718, talentID = 100533},
		SharpEdges = {spellID = 378948, talentID = 100547},
		SpearFocus = {spellID = 378953, talentID = 100558},
		SweepingSpear = {spellID = 378950, talentID = 100561},
		TacticalAdvantage = {spellID = 378951, talentID = 100556},
		TermsofEngagement = {spellID = 265895, talentID = 100567},
		TipoftheSpear = {spellID = 260285, talentID = 100554},
		VipersVenom = {spellID = 268501, talentID = 100530},
		WildfireInfusion = {
			ShrapnelBomb = {spellID = 270335, talentID = 100575},
			PheromoneBomb = {spellID = 270323, talentID = 100575},
			VolatileBomb = {spellID = 271045, talentID = 100575},
			}
	}
	ids.Surv_PvPTalent = {

	}
	ids.Surv_Form = {

	}
	ids.Surv_Buff = {
		AspectoftheEagle = 186289,
		CoordinatedAssault = 266779,
		DeadlyDuo = 397568,
		MongooseFury = 259388,
		Spearhead = 360966,
		TermsofEngagement = 262898,
		TipoftheSpear = 260286,
		VipersVenom = 268552,
	}
	ids.Surv_Debuff = {
		HuntersMark = 257284,
		InternalBleeding = 270343,
		LatentPoison = 378015,
		SerpentSting = 271788,
		TarTrap = 135299,
		WildfireBomb = 269747,
			ShrapnelBomb = 270339,
			PheromoneBomb = 270332,
			VolatileBomb = 271049,
	}
	ids.Surv_PetAbility = {
		Bite = {spellID = 17253},
		Claw = {spellID = 16827},
		Smack = {spellID = 49966},
		ChiJisTranquility = {spellID = 264028},
		NaturesGrace = {spellID = 264266},
		NetherShock = {spellID = 264264},
		PrimalRage = {spellID = 264667},
		SerenityDust = {spellID = 264055},
		SonicBlast = {spellID = 264263},
		SporeCloud = {spellID = 264056},
		SoothingWater = {spellID = 264262},
		SpiritShock = {spellID = 264265},
	}
