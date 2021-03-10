local ConRO_DemonHunter, ids = ...;

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
		ElysianDecree = 306830,
		ElysianDecreeCS = 327839,
		Fleshcraft = 324631,
		PhialofSerenity = 177278,
		FoddertotheFlame = 329554,
		SinfulBrand = 317009,
		Soulshape = 310143,
		SummonSteward = 324739,
		TheHunt = 323639,
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
		DemonMuzzle = 339587,
		FelDefender = 338671,
		RoaringFire = 339644,
		ShatteredRestoration = 338793,
		ViscousInk = 338682,
	--Finesse
		DemonicParole = 339048,
		FelfireHaste = 338799,
		LostinDarkness = 339149,
		RavenousConsumption = 338835,
	--Potency
		BroodingPool = 340063,
		DancingwithFate = 339228,
		GrowingInferno = 339231,
		IncreasedScrutiny = 340028,
		RelentlessOnslaught = 339151,
		RepeatDecree = 339895,
		SerratedGlaive = 339230,
		SoulFurnace = 339423,
		UnnaturalMalice = 344358,
	}
	ids.Covenant_Buff = {
	
	}
	ids.Covenant_Debuff = {	
		SinfulBrand = 317009,
	}
	ids.Legendary = {
	--Neutral
		EchoofEonar_Finger = "item:178926::::::::::::1:7100",
		EchoofEonar_Waist = "item:172320::::::::::::1:7100",
		EchoofEonar_Wrist = "item:172321::::::::::::1:7100",
		JudgementoftheArbiter_Finger = "item:178926::::::::::::1:7101",
		JudgementoftheArbiter_Hands = "item:172316::::::::::::1:7101",
		JudgementoftheArbiter_Wrist = "item:172321::::::::::::1:7101",
		MawRattle_Feet = "item:172315::::::::::::1:7159",
		MawRattle_Hands = "item:172316::::::::::::1:7159",
		MawRattle_Legs = "item:172318::::::::::::1:7159",
		NorgannonsSagacity_Back = "item:173242::::::::::::1:7102",
		NorgannonsSagacity_Feet = "item:172315::::::::::::1:7102",
		NorgannonsSagacity_Legs = "item:172318::::::::::::1:7102",
		SephuzsProclamation_Chest = "item:172314::::::::::::1:7103",
		SephuzsProclamation_Neck = "item:178927::::::::::::1:7103",
		SephuzsProclamation_Shoulder = "item:172319::::::::::::1:7103",
		StablePhantasmaLure_Back = "item:173242::::::::::::1:7104",
		StablePhantasmaLure_Neck = "item:178927::::::::::::1:7104",
		StablePhantasmaLure_Wrist = "item:172321::::::::::::1:7104",
		ThirdEyeoftheJailer_Head = "item:172317::::::::::::1:7105",
		ThirdEyeoftheJailer_Shoulder = "item:172319::::::::::::1:7105",
		ThirdEyeoftheJailer_Waist = "item:172320::::::::::::1:7105",
		VitalitySacrifice_Chest = "item:172314::::::::::::1:7106",
		VitalitySacrifice_Head = "item:172317::::::::::::1:7106",
		VitalitySacrifice_Shoulder = "item:172319::::::::::::1:7106",
	--DemonHunter
		CollectiveAnguish_Back = "item:173242::::::::::::1:7041",
		CollectiveAnguish_Wrist = "item:172321::::::::::::1:7041",
		DarkestHour_Chest = "item:172314::::::::::::1:7044",
		DarkestHour_Legs = "item:172318::::::::::::1:7044",
		DarkglareBoon_Neck = "item:178927::::::::::::1:7043",
		DarkglareBoon_Waist = "item:172320::::::::::::1:7043",
		FelBombardment_Head = "item:172317::::::::::::1:7052", -- Flag for Rotation
		FelBombardment_Shoulder = "item:172319::::::::::::1:7052",
	--Havoc
		BurningWound_Back = "item:173242::::::::::::1:7219",
		BurningWound_Chest = "item:172314::::::::::::1:7219",
		ChaosTheory_Hands = "item:172316::::::::::::1:7050", -- Flag for Rotation
		ChaosTheory_Waist = "item:172320::::::::::::1:7050",
		DarkerNature_Feet = "item:172315::::::::::::1:7218",
		DarkerNature_Shoulder = "item:172319::::::::::::1:7218",
		ErraticFelCore_Feet = "item:172315::::::::::::1:7051",
		ErraticFelCore_Finger = "item:178926::::::::::::1:7051",
	--Vengence
		FelFlameFortification_Finger = "item:178926::::::::::::1:7047",
		FelFlameFortification_Waist = "item:172320::::::::::::1:7047",
		FierySoul_Hands = "item:172316::::::::::::1:7048",
		FierySoul_Wrist = "item:172321::::::::::::1:7048",
		RazelikhsDefilement_Legs = "item:172318::::::::::::1:7046", -- Flag for Rotation
		RazelikhsDefilement_Wrist = "item:172321::::::::::::1:7046",
		SpiritoftheDarknessFlame_Head = "item:172317::::::::::::1:7045",
		SpiritoftheDarknessFlame_Neck = "item:178927::::::::::::1:7045",
	}
	ids.Legendary_Buff = {
		FelBombardment = 337849,
		ChaoticBlades = 337567,
	}
	ids.Legendary_Debuff = {	

	}

--DemonHunter
	ids.DemonHunter_Ability = {

	}
	ids.DemonHunter_Passive = {

	}
	ids.DemonHunter_Buff = {

	}
	ids.DemonHunter_Debuff = {

	}

--Havoc
	ids.Havoc_Ability = {
	--Demon Hunter
		ConsumeMagic = 278326,
		Disrupt = 183752,
		Glide = 131347,
		ImmolationAura = 258920,
		Imprison = 217832,
		Metamorphosis = 191427,
		SpectralSight = 188501,
		ThrowGlaive = 185123,
		Torment = 185245,
	--Havoc	
		Annihilation = 201427,
		BladeDance = 188499,
		Blur = 198589,
		ChaosNova = 179057,
		ChaosStrike = 162794,
		Darkness = 196718,
		DeathSweep = 210152,
		DemonsBite = 162243,
		EyeBeam = 198013,
		FelRush = 195072,
		VengefulRetreat = 198793,
	}
	ids.Havoc_Passive = {
	--Demon Hunter
		ChaosBrand = 255260,
		DemonicWards = 278386,
		DoubleJump = 196055,
		ShatteredSouls = 178940,
	--Havoc	
		MasteryDemonicPresence = 185164,
	}
	ids.Havoc_Talent = {
		--15
		BlindFury = 203550,
		DemonicAppetite = 206478,
		Felblade = 232893,
		--25
		InsatiableHunger = 258876,
		BurningHatred = 320374,
		DemonBlades = 203555,
		--30
		TrailofRuin = 258881,
		UnboundChaos = 275144,
		GlaiveTempest = 342817,
		--35
		SoulRending = 204909,
		DesperateInstincts = 205411,
		Netherwalk = 196555,
		--40
		CycleofHatred = 258887,
		FirstBlood = 206416,
		EssenceBreak = 258860,
		--45		
		UnleashedPower = 206477,
		MasteroftheGlaive = 203556,
		FelEruption = 211881,
		--50
		Demonic = 213410,
		Momentum = 206476,
		FelBarrage = 258925,		
	}
	ids.Havoc_PvPTalent = {
		CleansedbyFlame = 205625,
		ReverseMagic = 205604,
		EyeofLeotheras = 206649,
		ManaRift = 235903,
		DemonicOrigins = 235893,
		RainfromAbove = 206803,
		Detainment = 205596,
		ManaBreak = 203704,
		CoverofDarkness = 227635,
		MortalRush = 328725,
		UnendingHatred = 213480,
	}	
	ids.Havoc_Form = {
	
	}
	ids.Havoc_Buff = {
		ChaosBlades = 247938,
		InnerDemon = 337313,		
		Metamorphosis = 162264,
		Momentum = 208628,
	}
	ids.Havoc_Debuff = {

	}
	ids.Havoc_PetAbility = {

	}
		
--Vengeance
	ids.Ven_Ability = {
	--Demon Hunter
		ConsumeMagic = 278326,
		Disrupt = 183752,
		Glide = 131347,
		ImmolationAura = 258920,
		Imprison = 217832,
		Metamorphosis = 187827,
		SpectralSight = 188501,
		ThrowGlaive = 204157,
		Torment = 185245,
	--Vengeance	
		DemonSpikes = 203720,
		FelDevastation = 212084,
		FieryBrand = 204021,
		InfernalStrike = 189110,
		Shear = 203782,
		SigilofFlame = 204596,
		SigilofMisery = 207684,
		SigilofSilence = 202137,
		SoulCleave = 228477,
	}
	ids.Ven_Passive = {
	--Demon Hunter
		ChaosBrand = 281242,
		DemonicWards = 203513,
		DoubleJump = 196055,
		ShatteredSouls = 204254,
	--Vengeance		
		MasteryFelBlood = 203747,
		ThickSkin = 320380,
	}
	ids.Ven_Talent = {
		--15
		AbyssalStrike = 207550,
		AgonizingFlames = 207548,
		Felblade = 232893,
		--25
		FeastofSouls = 207697,
		Fallout = 227174,
		BurningAlive = 207739,
		--30
		InfernalArmor = 320331,
		CharredFlesh = 336639,
		SpiritBomb = 247454,
		--35
		SoulRending = 217996,		
		FeedtheDemon = 218612,
		Fracture = 263642,
		--40
		ConcentratedSigils = 207666,
			SigilofFlame = 204513,
			SigilofMisery = 202140,
			SigilofSilence = 207682,
		QuickenedSigils = 209281,
		SigilofChains = 202138,
		--45
		VoidReaver = 268175,
		Demonic = 321453,
		SoulBarrier = 263648,
		--50
		LastResort = 209258,
		RuinousBulwark = 326853,
		BulkExtraction = 320341,
	}
	ids.Ven_PvPTalent = {
		Solitude = 211509,
		CleansedbyFlame = 205625,
		EverlastingHunt = 205626,
		JaggedSpikes = 205627,
		IllidansGrasp = 205630,
		Tormentor = 207029,
		SigilMastery = 211489,
		DemonicTrample = 205629,
		ReverseMagic = 205604,
		Detainment = 205596,
		UnendingHatred = 213480,
	}		
	ids.Ven_Form = {
		SoulFragments = 203981,
	}
	ids.Ven_Buff = {
		DemonSpikes = 203819,
		ImmolationAura = 178740,
		Metamorphosis = 187827,
		SoulBarrier = 263648,
	}
	ids.Ven_Debuff = {
		FieryBrand = 207744,
		FieryDemise = 212818,
		Frailty = 247456,
		SigilofFlame = 204598,
	}
	ids.Ven_PetAbility = {

	}