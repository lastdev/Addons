local ConRO_Warlock, ids = ...;

--Generic
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
		DecimatingBolt = 325289,
		Fleshcraft = 324631,
		ImpendingCatastrophe = 321792,
		PhialofSerenity = 177278,
		ScouringTithe = 312321,
		SoulRot = 325640,
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
		AccruedVitality = 339282,
		DiabolicBloodstone = 340562,
		ResoluteBarrier = 339272,
	--Finesse
		DemonicMomentum = 339411,
		FelCelerity = 339130,
		KilroggsCunning = 58081,
		ShadeofTerror = 339379,
	--Potency
		AshenRemains = 339892,
		BorneofBlood = 339578,
		CarnivorousStalkers = 339656,
		CatastrophicOrigin = 340316,
		ColdEmbrace = 339576,
		CombustingEngine = 339896,
		CorruptingLeer = 339455,
		DuplicitousHavoc = 339890,
		FatalDecimation = 340268,
		FelCommando = 339845,
		FocusedMalignancy = 339500,
		InfernalBrand = 340041,
		RollingAgony = 339481,
		SoulEater = 340348,
		SoulTithe = 340229,
		TyrantsSoul = 339766,
	}
	ids.Covenant_Buff = {
		DecimatingBolt = 325299,
	}
	ids.Covenant_Debuff = {	
		ScouringTithe = 312321,
		SoulRot = 325640,
	}
	ids.Legendary = {
	--Neutral
		EchoofEonar_Finger = "item:178926::::::::::::1:7100",
		EchoofEonar_Waist = "item:173248::::::::::::1:7100",
		EchoofEonar_Wrist = "item:173249::::::::::::1:7100",
		JudgementoftheArbiter_Finger = "item:178926::::::::::::1:7101",
		JudgementoftheArbiter_Hands = "item:173244::::::::::::1:7101",
		JudgementoftheArbiter_Wrist = "item:173249::::::::::::1:7101",
		MawRattle_Feet = "item:173243::::::::::::1:7159",
		MawRattle_Hands = "item:173244::::::::::::1:7159",
		MawRattle_Legs = "item:173246::::::::::::1:7159",
		NorgannonsSagacity_Back = "item:173242::::::::::::1:7102",
		NorgannonsSagacity_Feet = "item:173243::::::::::::1:7102",
		NorgannonsSagacity_Legs = "item:173246::::::::::::1:7102",
		SephuzsProclamation_Chest = "item:173241::::::::::::1:7103",
		SephuzsProclamation_Neck = "item:178927::::::::::::1:7103",
		SephuzsProclamation_Shoulder = "item:173247::::::::::::1:7103",
		StablePhantasmaLure_Back = "item:173242::::::::::::1:7104",
		StablePhantasmaLure_Neck = "item:178927::::::::::::1:7104",
		StablePhantasmaLure_Wrist = "item:173249::::::::::::1:7104",
		ThirdEyeoftheJailer_Head = "item:173245::::::::::::1:7105",
		ThirdEyeoftheJailer_Shoulder = "item:173247::::::::::::1:7105",
		ThirdEyeoftheJailer_Waist = "item:173248::::::::::::1:7105",
		VitalitySacrifice_Chest = "item:173241::::::::::::1:7106",
		VitalitySacrifice_Head = "item:173245::::::::::::1:7106",
		VitalitySacrifice_Shoulder = "item:173247::::::::::::1:7106",
	--Warlock
		ClawofEndereth_Feet = "item:173243::::::::::::1:7026",
		ClawofEndereth_Waist = "item:173248::::::::::::1:7026",
		PillarsoftheDarkPortal_Chest = "item:173241::::::::::::1:7028",
		PillarsoftheDarkPortal_Neck = "item:178927::::::::::::1:7028",
		RelicofDemonicSynergy_Head = "item:173245::::::::::::1:7027",
		RelicofDemonicSynergy_Shoulder = "item:173247::::::::::::1:7027",
		WilfredsSigilofSuperiorSummoning_Finger = "item:178926::::::::::::1:7025",
		WilfredsSigilofSuperiorSummoning_Wrist = "item:173249::::::::::::1:7025",
	--Affliction
		MaleficWrath_Hands = "item:173244::::::::::::1:7031", -- Flag for Rotation
		MaleficWrath_Shoulder = "item:173247::::::::::::1:7031",
		PerpetualAgonyofAzjAqir_Chest = "item:173241::::::::::::1:7029",
		PerpetualAgonyofAzjAqir_Finger = "item:178926::::::::::::1:7029",
		SacrolashsDarkStrike_Feet = "item:173243::::::::::::1:7030",
		SacrolashsDarkStrike_Legs = "item:173246::::::::::::1:7030",
		WrathofConsumption_Back = "item:173242::::::::::::1:7032",
		WrathofConsumption_Feet = "item:173243::::::::::::1:7032",
	--Demonology
		BalespidersBurningCore_Hands = "item:173244::::::::::::1:7036",
		BalespidersBurningCore_Wrist = "item:173249::::::::::::1:7036",
		ForcesoftheHornedNightmare_Finger = "item:178926::::::::::::1:7035",
		ForcesoftheHornedNightmare_Shoulder = "item:173247::::::::::::1:7035",
		GrimInquisitorsDreadCalling_Neck = "item:178927::::::::::::1:7034",
		GrimInquisitorsDreadCalling_Wrist = "item:173249::::::::::::1:7034",
		ImplosivePotential_Head = "item:173245::::::::::::1:7033",
		ImplosivePotential_Waist = "item:173248::::::::::::1:7033",
	--Destruction
		CindersoftheAzjAqir_Back = "item:173242::::::::::::1:7038",
		CindersoftheAzjAqir_Legs = "item:173246::::::::::::1:7038",
		EmbersoftheDiabolicRaiment_Back = "item:173242::::::::::::1:7040",
		EmbersoftheDiabolicRaiment_Chest = "item:173241::::::::::::1:7040",
		MadnessoftheAzjAqir_Hands = "item:173244::::::::::::1:7039",
		MadnessoftheAzjAqir_Head = "item:173245::::::::::::1:7039",
		OdrShawloftheYmirjar_Legs = "item:173246::::::::::::1:7037",
		OdrShawloftheYmirjar_Waist = "item:173248::::::::::::1:7037",
	}
	ids.Legendary_Buff = {

	}
	ids.Legendary_Debuff = {	

	}

--Warlock
	ids.Warlock_Ability = {
		DrainLife = 234153,
		Corruption = 172,
		CreateHealthstone = 6201,
			Healthstone = 5512,
		CurseofWeakness = 702,
		Fear = 5782,
		HealthFunnel = 755,
		ShadowBolt = 686,
		SummonDemon = 10,
			SummonImp = 688,
			SummonVoidwalker = 697,
		UnendingResolve = 104773,
	}
	ids.Warlock_Passive = {
		SoulShards = 246985,
	}
	ids.Warlock_Debuff = {
		Corruption = 146739,
	}	

--Affliction
	ids.Aff_Ability = {
	--Warlock
		Banish = 710,
		CommandDemon = {
			CauterizeMaster = 119905, --Imp
			Suffering = 119907, --Voidwalker
			Whiplash = 119909, --Succubus
			SpellLock = 119910, --Felhunter
			ShadowLock = 171140, --Doomguard
			MeteorStrike = 171152, --Infernal
		},
		Corruption = 172,
		CreateHealthstone = 6201,
			Healthstone = 5512,
		CreateSoulwell = 29893,
		CurseofExhaustion = 334275,
		CurseofTongues = 1714,
		CurseofWeakness = 702,
		DemonicCircleSummon = 48018,
			DemonicCircleTeleport = 48020,
		DemonicGateway = 111771,
		DrainLife = 234153,
		EyeofKilrogg = 126,
		Fear = 5782,
		FelDomination = 333889,
		HealthFunnel = 755,
		RitualofDoom = 342601,
		RitualofSummoning = 698,
		ShadowBolt = 686,
		Shadowfury = 30283,
		Soulstone = 20707,
		SubjugateDemon = 1098,
		SummonDemon = 10,
			SummonImp = 688,
			SummonVoidwalker = 697,
			SummonFelhunter = 691,
			SummonSuccubus = 712,
			SummonFelguard = 30146,
		UnendingBreath = 5697,
		UnendingResolve = 104773,
	--Affliction
		Agony = 980,
		MaleficRapture = 324536,
		SeedofCorruption = 27243,
		SummonDarkglare = 205180,
		UnstableAffliction = 316099,
	}
	ids.Aff_Passive = {
	--Warlock
		DemonicEmbrace = 288843,
		ShadowEmbrace = 32388,
		SoulLeech = 108370,
		SoulShards = 246985,
	--Affliction	
		MasteryPotentAfflictions = 77215,
	}
	ids.Aff_Talent = {
		--15
		Nightfall = 108558,
		InevitableDemise = 334319,
		DrainSoul = 198590,
		--25
		WritheinAgony = 196102,
		AbsoluteCorruption = 196103,
		SiphonLife = 63106,
		--30
		DemonSkin = 219272,
		BurningRush = 111400,
		DarkPact = 108416,
		--35
		SowtheSeeds = 196226,
		PhantomSingularity = 205179,
		VileTaint = 278350,
		--40
		Darkfury = 264874,
		MortalCoil = 6789,
		HowlofTerror = 5484,
		--45
		DarkCaller = 334183,
		Haunt = 48181,
		GrimoireofSacrifice = 108503,
		--50
		SoulConduit = 215941,
		CreepingDeath = 264000,
		DarkSoulMisery = 113860,
	}
	ids.Aff_PvPTalent = {
		BaneofFragility = 199954,
		Deathbolt = 264106,
		GatewayMastery = 248855,
		RotandDecay = 212371,
		BaneofShadows = 234877,
		NetherWard = 212295,
		EssenceDrain = 221711,
		CastingCircle = 221703,
		DemonArmor = 285933,
		AmplifyCurse = 328774,
		RampantAfflictions = 335052,
			UnstableAffliction_RampantAfflictions = 342938, 
	}
	ids.Aff_Form = {
	
	}
	ids.Aff_Buff = {
		BurningRush = 111400,
		DarkPact = 108416,
		GrimoireofSacrifice = 196099,
		InevitableDemise = 334320,
	}
	ids.Aff_Debuff = {
		Agony = 980,
		Corruption = 146739,
		DrainSoul = 198590,
		Haunt = 48181,
		PhantomSingularity = 205179,
		SeedofCorruption = 27243,
		ShadowEmbrace = 32390,
		SiphonLife = 63106,
		UnstableAffliction = 316099,
		UnstableAffliction_RampantAfflictions = 342938,
		VileTaint = 278350,
	}
	ids.Aff_PetAbility = {
		CauterizeMaster = 119899, --Imp
		Suffering = 17735, --Voidwalker
		Whiplash = 6360, --Succubus
		SpellLock = 19647, --Felhunter
		DevourMagic = 19505, --Felhunter
		MeteorStrike = 171017, --Infernal	
		ThreateningPresence = 112042, -- Voidwalker
		Felstorm = 89751, -- Felguard
		AxeToss = 89766,
	}
		
--Demonology
	ids.Demo_Ability = {
	--Warlock
		Banish = 710,
		CommandDemon = 119898,
			CauterizeMaster = 119905, --Imp
			Suffering = 119907, --Voidwalker
			Whiplash = 119909, --Succubus
			SpellLock = 119910, --Felhunter
			ShadowLock = 171140, --Doomguard
			MeteorStrike = 171152, --Infernal
		Corruption = 172,
		CreateHealthstone = 6201,
			Healthstone = 5512,
		CreateSoulwell = 29893,
		CurseofExhaustion = 334275,
		CurseofTongues = 1714,
		CurseofWeakness = 702,
		DemonicCircleSummon = 48018,
			DemonicCircleTeleport = 48020,
		DemonicGateway = 111771,
		DrainLife = 234153,
		EyeofKilrogg = 126,
		Fear = 5782,
		FelDomination = 333889,
		HealthFunnel = 755,
		RitualofDoom = 342601,
		RitualofSummoning = 698,
		ShadowBolt = 686,
		Shadowfury = 30283,
		Soulstone = 20707,
		SubjugateDemon = 1098,
		SummonDemon = 10,
			SummonImp = 688,
			SummonVoidwalker = 697,
			SummonFelhunter = 691,
			SummonSuccubus = 712,
			SummonFelguard = 30146,
		UnendingBreath = 5697,
		UnendingResolve = 104773,
	--Demonology
		CallDreadstalkers = 104316,
		Demonbolt = 264178,
		HandofGuldan = 105174,
		Implosion = 196277,
		SummonDemonicTyrant = 265187,
	}
	ids.Demo_Passive = {
	--Warlock
		DemonicEmbrace = 288843,
		SoulLeech = 108370,
		SoulShards = 246985,
	--Demonology	
		DemonicCore = 267102,
		MasteryMasterDemonologist = 77219,
		SoulLink = 108415,
	}
	ids.Demo_Talent = {
		--15
		Dreadlash = 264078,
		BilescourgeBombers = 267211,
		DemonicStrength = 267171,
		--25
		DemonicCalling = 205145,
		PowerSiphon = 264130,
		Doom = 603,
		--30
		DemonSkin = 219272,
		BurningRush = 111400,
		DarkPact = 108416,
		--35
		FromtheShadows = 267170,
		SoulStrike = 264057,
		SummonVilefiend = 264119,
		--40
		Darkfury = 264874,		
		MortalCoil = 6789,		
		HowlofTerror = 5484,
		--45
		SoulConduit = 215941,
		InnerDemons = 267216,
		GrimoireFelguard = 111898,
		--50
		SacrificedSouls = 267214,
		DemonicConsumption = 267215,
		NetherPortal = 267217,
	}
	ids.Demo_PvPTalent = {
		SingeMagic = 212623,
		CallFelhunter = 212619,
		PleasureThroughPain = 212618,
		CallFelLord = 212459,
		CallObserver = 201996,
		MasterSummoner = 212628,
		BaneofFragility = 199954,
		GatewayMastery = 248855,
		AmplifyCurse = 328774,
		NetherWard = 212295,
		EssenceDrain = 221711,
		CastingCircle = 221703,
	}
	ids.Demo_Form = {
	
	}
	ids.Demo_Buff = {
		BurningRush = 111400,
		DarkPact = 108416,
		DemonicCalling = 205146,
		DemonicCore = 264173,
		NetherPortal = 267218,
	}
	ids.Demo_Debuff = {
		Corruption = 146739,
		Doom = 603,
	}
	ids.Demo_PetAbility = {
		CauterizeMaster = 119899, --Imp
		Suffering = 17735, --Voidwalker
		Whiplash = 6360, --Succubus
		ShadowBite = 54049,
		SpellLock = 19647, --Felhunter
		DevourMagic = 19505, --Felhunter
		MeteorStrike = 171017, --Infernal	
		ThreateningPresence = 112042, -- Voidwalker
		Felstorm = 89751, -- Felguard
		AxeToss = 89766,
	}
	
--Destruction
	ids.Dest_Ability = {
	--Warlock
		Banish = 710,
		CommandDemon = 119898,
			CauterizeMaster = 119905, --Imp
			Suffering = 119907, --Voidwalker
			Whiplash = 119909, --Succubus
			SpellLock = 119910, --Felhunter
			ShadowLock = 171140, --Doomguard
			MeteorStrike = 171152, --Infernal
		Corruption = 172,
		CreateHealthstone = 6201,
			Healthstone = 5512,
		CreateSoulwell = 29893,
		CurseofExhaustion = 334275,
		CurseofTongues = 1714,
		CurseofWeakness = 702,
		DemonicCircleSummon = 48018,
			DemonicCircleTeleport = 48020,
		DemonicGateway = 111771,
		DrainLife = 234153,
		EyeofKilrogg = 126,
		Fear = 5782,
		FelDomination = 333889,
		HealthFunnel = 755,
		RitualofDoom = 342601,
		RitualofSummoning = 698,
		Shadowfury = 30283,
		Soulstone = 20707,
		SubjugateDemon = 1098,
		SummonDemon = 10,
			SummonImp = 688,
			SummonVoidwalker = 697,
			SummonFelhunter = 691,
			SummonSuccubus = 712,
			SummonFelguard = 30146,
		UnendingBreath = 5697,
		UnendingResolve = 104773,
	--Destruction
		ChaosBolt = 116858,
		Conflagrate = 17962,
		Havoc = 80240,
		Immolate = 348,
		Incinerate = 29722,
		RainofFire = 5740,
		SummonInfernal = 1122,
	}
	ids.Dest_Passive = {
	--Warlock
		DemonicEmbrace = 288843,
		SoulLeech = 108370,
		SoulShards = 246985,
	--Destruction	
		Backdraft = 196406,
		MasteryChaoticEnergies = 77220,
	}
	ids.Dest_Talent = {
		--15
		Flashover = 267115,
		Eradication = 196412,
		SoulFire = 6353,
		--25
		ReverseEntropy = 205148,
		InternalCombustion = 266134,
		Shadowburn = 17877,
		--30
		DemonSkin = 219272,
		BurningRush = 111400,
		DarkPact = 108416,
		--35
		Inferno = 270545,
		FireandBrimstone = 196408,		
		Cataclysm = 152108,
		--40
		Darkfury = 264874,
		MortalCoil = 6789,
		HowlofTerror = 5484,
		--45
		RoaringBlaze = 205184,
		RainofChaos = 266086,
		GrimoireofSacrifice = 108503,
		--50
		SoulConduit = 215941,
		ChannelDemonfire = 196447,
		DarkSoulInstability = 113858,
	}
	ids.Dest_Form = {
	
	}
	ids.Dest_Buff = {
		BackDraft = 117828,
		BurningRush = 111400,
		DarkPact = 108416,
		GrimoireofSacrifice = 196099,
		DarkSoulInstability = 113858,
 	}
	ids.Dest_Debuff = {
		Conflagrate = 265931,
		Corruption = 146739,
		Eradication = 196414,
		Havoc = 80240,
		Immolate = 157736,
	}
	ids.Dest_PetAbility = {
		CauterizeMaster = 119899, --Imp
		Suffering = 17735, --Voidwalker
		Whiplash = 6360, --Succubus
		SpellLock = 19647, --Felhunter
		DevourMagic = 19505, --Felhunter
		MeteorStrike = 171017, --Infernal	
		ThreateningPresence = 112042, -- Voidwalker
		Felstorm = 89751, -- Felguard
		AxeToss = 89766,
	}