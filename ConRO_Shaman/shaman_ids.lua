local ConRO_Shaman, ids = ...;

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
		ChainHarvest = 320674,
		FaeTransfusion = 328923,
		FaeTransfusionEND = 328930,
		Fleshcraft = 324631,
		PhialofSerenity = 177278,
		PrimordialWave = 326059,
		Soulshape = 310143,
		SummonSteward = 324739,
		VesperTotem = 324386,
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
		AstralProtection = 337964,
		RefreshingWaters = 337974,
		VitalAccretion = 337981,
	--Finesse
		CripplingHex = 338054,
		SpiritualResonance = 338048,
		ThunderousPaws = 338033,
		TotemicSurge = 338042,
	--Potency
		CallofFlame = 338303,
		ChilledtotheCore = 338325,
		ElysianDirge = 339182,
		EmbraceofEarth = 338329,
		EssentialExtraction = 339183,
		FocusedLightning = 338322,
		HeavyRainfall = 338343,
		HighVoltage = 338131,
		LavishHarvest = 339185,
		MagmaFist = 338331,
		NaturesFocus = 338346,
		PyroclasticShock = 345594,
		ShaketheFoundations = 338252,
		SwirlingCurrents = 338339,
		TumblingWaves = 339186,
		UnrulyWinds = 338318,
	}
	ids.Covenant_Buff = {
		FaeTransfusion = 328933,
		PrimordialWave = 326059,
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
		StablePhantasmaLure_Back = "item:173242 ::::::::::::1:7104",
		StablePhantasmaLure_Neck = "item:178927::::::::::::1:7104",
		StablePhantasmaLure_Wrist = "item:172329::::::::::::1:7104",
		ThirdEyeoftheJailer_Head = "item:172325::::::::::::1:7105",
		ThirdEyeoftheJailer_Shoulder = "item:172327::::::::::::1:7105",
		ThirdEyeoftheJailer_Waist = "item:172328::::::::::::1:7105",
		VitalitySacrifice_Chest = "item:172322::::::::::::1:7106",
		VitalitySacrifice_Head = "item:172325::::::::::::1:7106",
		VitalitySacrifice_Shoulder = "item:172327::::::::::::1:7106",
	--Shaman
		AncestralReminder_Finger = "item:178926::::::::::::1:6985",
		AncestralReminder_Wrist = "item:172329::::::::::::1:6985",
		ChainsofDevastation_Chest = "item:172322::::::::::::1:6988",
		ChainsofDevastation_Neck = "item:178927::::::::::::1:6988",
		DeeplyRootedElements_Head = "item:172325::::::::::::1:6987",
		DeeplyRootedElements_Shoulder = "item:172327::::::::::::1:6987",
		DeeptremorStone_Feet = "item:172323::::::::::::1:6986",
		DeeptremorStone_Waist = "item:172328::::::::::::1:6986",
	--Elemental
		EchoesofGreatSundering_Hands = "item:172324::::::::::::1:6991",
		EchoesofGreatSundering_Shoulder = "item:172327::::::::::::1:6991",
		ElementalEquilibrium_Feet = "item:172323::::::::::::1:6990", -- Flag for Rotation
		ElementalEquilibrium_Legs = "item:172326::::::::::::1:6990",
		SkybreakersFieryDemise_Chest = "item:172322::::::::::::1:6989",
		SkybreakersFieryDemise_Finger = "item:178926::::::::::::1:6989",
		WindspeakersLavaResurgence_Back = "item:173242::::::::::::1:6992",
		WindspeakersLavaResurgence_Feet = "item:172323::::::::::::1:6992",
	--Enhancement
		DoomWinds_Head = "item:172325::::::::::::1:6993",
		DoomWinds_Waist = "item:172328::::::::::::1:6993",
		LegacyoftheFrostWitch_Neck = "item:178927::::::::::::1:6994",
		LegacyoftheFrostWitch_Wrist = "item:172329::::::::::::1:6994",
		PrimalLavaActuators_Hands = "item:172324::::::::::::1:6996",
		PrimalLavaActuators_Wrist = "item:172329::::::::::::1:6996",
		WitchDoctorsWolfBones_Finger = "item:178926::::::::::::1:6995",
		WitchDoctorsWolfBones_Shoulder = "item:172327::::::::::::1:6995",
	--Restoration
		EarthenHarmony_Back = "item:173242::::::::::::1:7000",
		EarthenHarmony_Chest = "item:172322::::::::::::1:7000",
		JonatsNaturalFocus_Legs = "item:172326::::::::::::1:6997",
		JonatsNaturalFocus_Waist = "item:172328::::::::::::1:6997",
		PrimalTideCore_Hands = "item:172324::::::::::::1:6999",
		PrimalTideCore_Head = "item:172325::::::::::::1:6999",
		SpiritwalkersTidalTotem_Back = "item:173242::::::::::::1:6998",
		SpiritwalkersTidalTotem_Legs = "item:172326::::::::::::1:6998",
	}
	ids.Legendary_Buff = {
		DoomWinds = 335903,
		EchoesofGreatSundering = 336217,
	}
	ids.Legendary_Debuff = {	
		DoomWinds = 335904,
	}

--Shaman
	ids.Shaman_Ability = {

	}
	ids.Shaman_Passive = {

	}
	ids.Shaman_Buff = {

	}
	ids.Shaman_Debuff = {

	}

--Elemental
	ids.Ele_Ability = {
	--Shaman
		AncestralSpirit = 2008,
		AstralRecall = 556,
		AstralShift = 108271,
		CapacitorTotem = 192058,
		ChainHeal = 1064,
		ChainLightning = 188443,
		EarthElemental = 198103,
		EarthbindTotem = 2484,
		FarSight = 6196,
		FlameShock = 188389,
		FlametongueWeapon = 318038,
		FrostShock = 196840,
		GhostWolf = 2645,
		HealingStreamTotem = 5394,
		HealingSurge = 8004,
		Heroism = 32182,
		Hex = 51514,
		HaxRaptor = 210873,
		LightningBolt = 188196,
		LightningShield = 192106,
		PrimalStrike = 73899,
		Purge = 370,
		TremorTotem = 8143,
		WaterWalking = 546,
		WindShear = 57994,
	--Elemental
		CleanseSpirit = 51886,
		EarthShock = 8042,
		Earthquake = 61882,
		FireElemental = 198067,
		LavaBurst = 51505,
		SpiritwalkersGrace = 79206,
		Thunderstorm = 51490,
	}
	ids.Ele_Passive = {
		ElementalFury = 60188,
		LavaSurge = 77756,
		MasteryElementalOverload = 168534,
		Reincarnation = 20608,
	}
	ids.Ele_Talent = {
		--15
		EarthenRage = 170374,
		EchooftheElements = 333919,
		StaticDischarge = 342243,
		--25
		Aftershock = 273221,
		EchoingShock = 320125,
		ElementalBlast = 117014,
		--30
		SpiritWolf = 260878,
		EarthShield = 974,
		StaticCharge = 265046,
		--35
		MasteroftheElements = 16166,
		StormElemental = 192249,
		LiquidMagmaTotem = 192222,
		--40
		NaturesGuardian = 30884,
		AncestralGuidance = 108281,
		WindRushTotem = 192077,
		--45
		SurgeofPower = 262303,
		PrimalElementalist = 117013,
		Icefury = 210714,
		--50
		UnlimitedPower = 260895,
		Stormkeeper = 191634,
		Ascendance = 114050,
			LavaBeam = 114074,
	}
	ids.Ele_Form = {
		WindGust = 263806,
	}
	ids.Ele_Buff = {
		Ascendance = 114050,
		EarthShield = 974,
		EchoingShock = 320125,
		Icefury = 210714,
		LavaSurge = 77762,
		LightningShield = 192106,
		MasteroftheElements = 260734,
		Stormkeeper = 191634,
		SurgeofPower = 285514,
	}
	ids.Ele_Debuff = {
		FlameShock = 188389,
	}
	ids.Ele_PetAbility = {
		CallLightning = 157348,
		EyeoftheStorm = 157375,
		Meteor = nil,
	}
		
--Enhancement
	ids.Enh_Ability = {
	--Shaman
		AncestralSpirit = 2008,
		AstralRecall = 556,
		AstralShift = 108271,
		CapacitorTotem = 192058,
		ChainHeal = 1064,
		ChainLightning = 188443,
		EarthElemental = 198103,
		EarthbindTotem = 2484,
		FarSight = 6196,
		FlameShock = 188389,
		FlametongueWeapon = 318038,
		FrostShock = 196840,
		GhostWolf = 2645,
		HealingStreamTotem = 5394,
		HealingSurge = 8004,
		Heroism = 32182,
		Hex = 51514,
		HaxRaptor = 210873,
		LightningBolt = 188196,
		LightningShield = 192106,
		PrimalStrike = 73899,
		Purge = 370,
		TremorTotem = 8143,
		WaterWalking = 546,
		WindShear = 57994,
	--Enhancement	
		CleanseSpirit = 51886,
		CrashLightning = 187874,
		FeralSpirit = 51533,
		LavaLash = 60103,
		SpiritWalk = 58875,
		Stormstrike = 17364,
		WindfuryTotem = 8512,
		WindfuryWeapon = 33757,
	}
	ids.Enh_Passive = {
		MaelstromWeapon = 187880,
		MasteryEnhancedElements = 77223,
		Stormbringer = 201845,
		Reincarnation = 20608,
	}
	ids.Enh_Talent = {
		--15
		LashingFlames = 334046,
		ForcefulWinds = 262647,
		ElementalBlast = 117014,
		--25
		Stormflurry = 344357,
		HotHand = 201900,
		IceStrike = 342240,
		--30
		SpiritWolf = 260878,
		EarthShield = 974,
		StaticCharge = 265046,
		--35
		ElementalAssault = 210853,
		Hailstorm = 334195,
		FireNova = 333974,
		--40
		NaturesGuardian = 30884,
		FeralLunge = 196884,
		WindRushTotem = 192077,
		--45
		CrashingStorm = 192246,
		Stormkeeper = 320137,
		Sundering = 197214,
		--50
		ElementalSpirits = 262624,
		EarthenSpike = 188089,
		Ascendance = 114051,
			Windstrike = 115356,
	}
	ids.Enh_Form = {
		WindfuryTotem = 327942,
	}
	ids.Enh_Buff = {
		Ascendance = 114051,
		CrashLightning = 187878,
		EarthShield = 974,
		FlametongueWeapon = 5400,
		Frostbrand = 196834,
		ForcefulWinds = 262652,
		GatheringStorms = 198300,
		Hailstorm = 334196,
		HotHand = 215785,
		LashingFlames = 334168,
		LightningShield = 192106,
		MaelstromWeapon = 344179,
		Stormbringer = 201846,
		Stormkeeper = 320137,
		WindfuryWeapon = 5401,
	}
	ids.Enh_Debuff = {
		EarthenSpike = 188089,
		FlameShock = 188389,
	}
	ids.Enh_PetAbility = {

	}

--Restoration
	ids.Resto_Ability = {
	--Shaman
		AncestralSpirit = 2008,
		AstralRecall = 556,
		AstralShift = 108271,
		CapacitorTotem = 192058,
		ChainHeal = 1064,
		ChainLightning = 188443,
		EarthElemental = 198103,
		EarthbindTotem = 2484,
		FarSight = 6196,
		FlameShock = 188389,
		FlametongueWeapon = 318038,
		FrostShock = 196840,
		GhostWolf = 2645,
		HealingStreamTotem = 5394,
		HealingSurge = 8004,
		Heroism = 32182,
		Hex = 51514,
		HaxRaptor = 210873,
		LightningBolt = 188196,
		LightningShield = 192106,
		PrimalStrike = 73899,
		Purge = 370,
		TremorTotem = 8143,
		WaterWalking = 546,
		WindShear = 57994,
	--Restoration	
		AncestralVision = 212048,
		EarthShield = 974,
		HealingRain = 73920,
		HealingTideTotem = 108280,
		HealingWave = 77472,
		LavaBurst = 51505,
		ManaTideTotem = 16191,
		PurifySpirit = 77130,
		Riptide = 61295,
		SpiritLinkTotem = 98008,
		SpiritwalkersGrace = 79206,
		WaterShield = 52127,
	}
	ids.Resto_Passive = {
		LavaSurge = 77756,
		MasteryDeepHealing = 77226,
		Resurgence = 16196,
		TidalWaves = 51564,
		Reincarnation = 20608,
	}
	ids.Resto_Talent = {
		--15
		Torrent = 200072,
		Undulation = 200071,
		UnleashLife = 73685,
		--25
		EchooftheElements = 108283,
		Deluge = 200076,
		SurgeofEarth = 320746,
		--30
		SpiritWolf = 260878,
		EarthgrabTotem = 51485,
		StaticCharge = 265046,
		--35
		AncestralVigor = 207401,
		EarthenWallTotem = 198838,
		AncestralProtectionTotem = 207399,
		--40
		NaturesGuardian = 30884,
		GracefulSpirit = 192088,
		WindRushTotem = 192077,
		--45
		FlashFlood = 280614,
		Downpour = 207778,
		CloudburstTotem = 157153,
		--50
		HighTIde = 157154,
		Wellspring = 197995,
		Ascendance = 114052,
	}
	ids.Resto_Form = {
	
	}
	ids.Resto_Buff = {
		EarthShield = 974,
		LavaSurge = 77762,
		LightningShield = 192106,
 	}
	ids.Resto_Debuff = {
		FlameShock = 188389,	
	}
	ids.Resto_PetAbility = {

	}