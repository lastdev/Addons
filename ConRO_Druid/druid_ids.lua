local ConRO_Druid, ids = ...;

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
		AdaptiveSwarm = 325727,
		ConvoketheSpirits = 323764,
		Fleshcraft = 324631,
		KindredSpirits = 326434,
			EmpowerBondDamage = 326446,
			EmpowerBondTank = 326462,
			EmpowerBondHealer = 326647,
			LoneEmpowerment = 338142,
			LoneMeditation = 338035,
			LoneProtection = 338018,
		PhialofSerenity = 177278,
		RavenousFrenzy = 323546,
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
		InnateResolve = 340543,
		LayeredMane = 340605,
		ToughasBark = 340529,
		UrsineVigor = 340540,
		WellHonedInstincts = 340553,
	--Finesse
		BornAnew = 341280,
		BornoftheWilds = 341451,
		FrontofthePack = 341450,
		TirelessPursuit = 340545,
	--Potency
		CarnivorousInstinct = 340705,
		ConfluxofElements = 341446,
		DeepAllegiance = 341378,
		EndlessThirst = 341383,
		EvolvedSwarm = 341447,
		FlashofClarity = 340616,
		FloralRecycling = 340621,
		FuryoftheSkies = 340708,
		IncessantHunter = 340686,
		PreciseAlignment = 340706,
		ReadyforAnything = 340550,
		SavageCombatant = 340609,
		StellarInspiration = 340720,
		SuddenAmbush = 340694,
		TasteforBlood = 340682,
		UmbralIntensity = 340719,
		UncheckedAggression = 340552,
		UnstoppableGrowth = 340549,
	}
	ids.Covenant_Buff = {
		KindredEmpowerment = 327022,
		KindredSpirits = 326967,
		LoneEmpowerment = 338142,
		LoneMeditation = 338035,
		LoneProtection = 338018,
		LoneSpirit = 338041,
	}
	ids.Covenant_Debuff = {	
		AdaptiveSwarm = 325733,
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
	--Druid
		CircleofLifeandDeath_Finger = "item:178926::::::::::::1:7085",	
		CircleofLifeandDeath_Head = "item:172317::::::::::::1:7085",	
		DraughtofDeepFocus_Chest = "item:172314::::::::::::1:7086",	
		DraughtofDeepFocus_Neck = "item:178927::::::::::::1:7086",	
		LycarasFleetingGlimpse_Feet = "item:172315::::::::::::1:7110",	
		LycarasFleetingGlimpse_Waist = "item:172320::::::::::::1:7110",	
		OathoftheElderDruid_Shoulder = "item:172319::::::::::::1:7084",	
		OathoftheElderDruid_Wrist = "item:172321::::::::::::1:7084",	
	--Balance
		BalanceofAllThings_Feet = "item:172315::::::::::::1:7107",
		BalanceofAllThings_Legs = "item:172318::::::::::::1:7107",
		OnethsClearVision_Back = "item:173242::::::::::::1:7087", --Flag for Rotation
		OnethsClearVision_Feet = "item:172315::::::::::::1:7087",
		PrimordialArcanicPulsar_Hands = "item:172316::::::::::::1:7088",
		PrimordialArcanicPulsar_Shoulder = "item:172319::::::::::::1:7088",
		TimewornDreambinder_Chest = "item:172314::::::::::::1:7108",
		TimewornDreambinder_Finger = "item:178926::::::::::::1:7108",
	--Feral
		ApexPredatorsCraving_Waist = "item:172320::::::::::::1:7091", --Flag for Rotation
		ApexPredatorsCraving_Shoulder = "item:172319::::::::::::1:7091",
		CateyeCurio_Finger = "item:178926::::::::::::1:7089",
		CateyeCurio_Neck = "item:178927::::::::::::1:7089",
		EyeofFearfulSymmetry_Hands = "item:172316::::::::::::1:7090",
		EyeofFearfulSymmetry_Head = "item:172317::::::::::::1:7090",
		Frenzyband_Waist = "item:172320::::::::::::1:7109",
		Frenzyband_Wrist = "item:172321::::::::::::1:7109",
	--Guardian
		LegacyoftheSleeper_Feet = "item:172315::::::::::::1:7095",
		LegacyoftheSleeper_Waist = "item:172320::::::::::::1:7095",
		LuffaInfusedEmbrace_Back = "item:173242::::::::::::1:7092", --Flag for Rotation
		LuffaInfusedEmbrace_Chest = "item:172314::::::::::::1:7092",
		TheNaturalOrdersWill_Hands = "item:172316::::::::::::1:7093",
		TheNaturalOrdersWill_Head = "item:172317::::::::::::1:7093",
		UrsocsFuryRemembered_Back = "item:173242::::::::::::1:7094",
		UrsocsFuryRemembered_Legs = "item:172318::::::::::::1:7094",
	--Restoration
		MemoryoftheMotherTree_Legs = "item:172318::::::::::::1:7096",
		MemoryoftheMotherTree_Wrist = "item:172321::::::::::::1:7096",
		TheDarkTitansLesson_Back = "item:173242::::::::::::1:7097",
		TheDarkTitansLesson_Neck = "item:178927::::::::::::1:7097",
		VerdantInfusion_Hands = "item:172316::::::::::::1:7098",
		VerdantInfusion_Shoulder = "item:172319::::::::::::1:7098",
		VisionofUnendingGrowth_Feet = "item:172315::::::::::::1:7099",
		VisionofUnendingGrowth_Head = "item:172317::::::::::::1:7099",
	}
	ids.Legendary_Buff = {

	}
	ids.Legendary_Debuff = {	

	}

--Druid
	ids.Druid_Ability = {

	}
	ids.Druid_Passive = {

	}
	ids.Druid_Buff = {

	}
	ids.Druid_Debuff = {

	}

--Balance
	ids.Bal_Ability = {
		--Druid
		Barkskin = 22812,
		BearForm = 5487,
		CatForm = 768,
		CharmWoodlandCreature = 127757,
		Cyclone = 33786,
		Dash = 1850,
		Dreamwalk = 193753,
		EntanglingRoots = 339,
		FerociousBite = 22568,
		Flap = 164862,
		Growl = 6795,
		Hibernate = 2637,
		Ironfur = 192081,
		Mangle = 33917,
		Moonfire = 8921,
		MountForm = 210053,
		Prowl = 5215,
		Rebirth = 20484,
		Regrowth = 8936,
		Revive = 50769,
		Shred = 5221,
		Soothe = 2908,
		StampedingRoarBal = 106898,
		StampedingRoarFeral = 77764,
		StampedingRoarGuard = 77761,
		TravelForm = 783,
		TreantForm = 114282,
		Wrath = 5176,
	--Balance	
		CelestialAlignment = 194223,
		Innervate = 29166,
		MoonkinForm = 24858,
		RemoveCorruption = 2782,
		SolarBeam = 78675,
		Starfall = 191034,
		Starfire = 194153,
		Starsurge = 78674,
		Sunfire = 93402,
		Typhoon = 132469,
		Wrath = 190984,
	}
	ids.Bal_Passive = {
		AquaticForm = 276012,
		FlightForm = 276029,
		AstralInfluence = 197524,
		Eclipse = 79577,
		MasteryTotalEclipse = 326085,
		ShootingStars = 202342,
	}
	ids.Bal_Talent = {
		--15
		NaturesBalance = 202430,
		WarriorofElune = 202425,
		ForceofNature = 205636,
		--25
		TigerDash = 252216,
		Renewal = 108238,
		WildCharge = 102401,
			WildCharge_Bear = 16979,
			WildCharge_Cat = 49376,
			WildCharge_Moonkin = 102383,
		--30
		FeralAffinity = 202157,
			Rake = 1822,
			Rip = 1079,
			Swipe = 213764,
			Maim = 0,
		GuardianAffinity = 197491,
			Thrash = 0,
			FrenziedRegeneration = 22842,
			IncapacitatingRoar = 0,
		RestorationAffinity = 197492,
			Rejuenation = 774,
			Swiftmend = 18562,
			WildGrowth = 48438,
			UrsolsVortex = 0,
		--35
		MightyBash = 5211,
		MassEntanglement = 102359,
		HeartoftheWild = 319454,
		--40
		SouloftheForest = 114107,
		Starlord = 202345,
		IncarnationChosenofElune = 102560,
		--45
		StellarDrift = 202354,
		TwinMoons = 279620,
		StellarFlare = 202347,
		--50
		Soltice = 343647,
		FuryofElune = 202770,
		NewMoon = 274281,
			HalfMoon = 274282,
			FullMoon = 274283,
	}
	ids.Bal_PvPTalent = {
		CelestialGuardian = 233754,
		CrescentBurn = 200567,
		MoonandStars = 233750,
		MoonkinAura = 209740,
		DyingStars = 232546,
		DeepRoots = 233755,
		FaerieSwarm = 209749,
		PricklingThorns = 200549,
		ProtectoroftheGrove = 209730,
		Thorns = 305497,
		HighWinds = 200931,
	}
	ids.Bal_Form = {
		BearForm = 5487,
		CatForm = 768,
		Prowl = 5215,
		MoonkinForm = 24858,
		WarriorofElune = 202425,
	}
	ids.Bal_Buff = {
		Ironfur = 192081,
		Regrowth = 8936,
		CelestialAlignment = 194223,
		DawningSun = 276154,
		IncarnationChosenofElune = 102560,
		OwlkinFrenzy = 157228,
		EclipseLunar = 48518,
		EclipseSolar = 48517,
		Starfall = 191034,
		Starlord = 279709,
		StellarDrift = 202461,
	}
	ids.Bal_Debuff = {
		Moonfire = 164812,
		Sunfire = 164815,
		StellarFlare = 202347,
	}
	ids.Bal_PetAbility = {

	}
		
--Feral
	ids.Feral_Ability = {
	--Druid
		Barkskin = 22812,
		BearForm = 5487,
		CatForm = 768,
		CharmWoodlandCreature = 127757,
		Cyclone = 33786,
		Dash = 1850,
		Dreamwalk = 193753,
		EntanglingRoots = 339,
		FerociousBite = 22568,
		Flap = 164862,
		Growl = 6795,
		Hibernate = 2637,
		Ironfur = 192081,
		Mangle = 33917,
		Moonfire = 8921,
		MountForm = 210053,
		Prowl = 5215,
		Rebirth = 20484,
		Regrowth = 8936,
		Revive = 50769,
		Shred = 5221,
		Soothe = 2908,
		StampedingRoarBal = 106898,
		StampedingRoarFeral = 77764,
		StampedingRoarGuard = 77761,
		TravelForm = 783,
		TreantForm = 114282,
		Wrath = 5176,
	--Feral	
		Berserk = 106951,
		Maim = 22570,
		Rake = 1822,
		RemoveCorruption = 2782,
		Rip = 1079,
		SkullBash = 106839,
		SurvivalInstincts = 61336,
		Swipe = 213764,		
		Swipe_Cat = 106785,
		Swipe_Bear = 213771,
		Thrash = 106832,
		Thrash_Cat = 106830,
		Thrash_Bear = 77758,
		TigersFury = 5217,
	}
	ids.Feral_Passive = {
		AquaticForm = 276012,
		FlightForm = 276029,
		FelineAdept = 300349,
		FelineSwiftness = 131768,
		FeralInstinct = 16949,
		InfectedWounds = 48484,
		MasteryRazorClaws = 77493,
		OmenofClarity = 16864,
		PredatorySwiftness = 16974,
		PrimalFury = 159286,
	}
	ids.Feral_Talent = {
		--15
		Predator = 202021,
		Sabertooth = 202031,
		LunarInspiration = 155580,
			Moonfire_Cat = 155625,
		--25
		TigerDash = 252216,
		Renewal = 108238,
		WildCharge = 102401,
			WildCharge_Bear = 16979,
			WildCharge_Cat = 49376,
			WildCharge_Moonkin = 102383,
		--30
		BalanceAffinity = 197488,
			MoonkinForm = 0,
			Starsurge = 197626,
			Starfire = 0,
			Sunfire = 197630,
			Typhoon = 0,
		GuardianAffinity = 217615,
			FrenziedRegeneration = 22842,
			IncapacitatingRoar = 0,
		RestorationAffinity = 197492,
			Rejuenation = 774,
			Swiftmend = 18562,
			WildGrowth = 48438,
			UrsolsVortex = 0,	
		--35
		MightyBash = 5211,
		MassEntanglement = 102359,
		HeartoftheWild = 319454,
		--40
		SouloftheForest = 158476,
		SavageRoar = 52610,
		IncarnationKingoftheJungle = 102543,
		--45
		ScentofBlood = 285564,
		BrutalSlash = 202028,
		PrimalWrath = 285381,
		--50
		MomentofClarity = 236068,
		Bloodtalons = 319439,
		FeralFrenzy = 274837,
	}
	ids.Feral_PvPTalent = {
		Thorns = 236696,
		EarthenGrasp = 236023,
		FreedomoftheHerd = 213200,
		MalornesSwiftness = 236012,
		KingoftheJungle = 203052,
		EnragedMaim = 236026,
		FerociousWound = 236020,
		FreshWound = 203224,
		RipandTear = 203242,
		SavageMomentum = 205673,
		ProtectoroftheGrove = 209730,
	}
	ids.Feral_Form = {
		BearForm = 5487,
		CatForm = 768,
		Prowl = 5215,
	}
	ids.Feral_Buff = {
		Berserk = 106951,
		Ironfur = 192081,
		Regrowth = 8936,
		Bloodtalons = 145152,
		Clearcasting = 135700,
		IncarnationKingoftheJungle = 102543,
		TigersFury = 5217,
		PredatorySwiftness = 69369,
		SavageRoar = 52610,
	}
	ids.Feral_Debuff = {
		Moonfire = 155625,
		Rake = 155722,
		RakeStun = 163505,
		Rip = 1079,
		Thrash_Cat = 106830,
		Thrash_Bear = 192090,
	}
	ids.Feral_PetAbility = {

	}

--Guardian
	ids.Guard_Ability = {
	--Druid
		Barkskin = 22812,
		BearForm = 5487,
		CatForm = 768,
		CharmWoodlandCreature = 127757,
		Cyclone = 33786,
		Dash = 1850,
		Dreamwalk = 193753,
		EntanglingRoots = 339,
		FerociousBite = 22568,
		Flap = 164862,
		Growl = 6795,
		Hibernate = 2637,
		Ironfur = 192081,
		Mangle = 33917,
		Moonfire = 8921,
		MountForm = 210053,
		Prowl = 5215,
		Rebirth = 20484,
		Regrowth = 8936,
		Revive = 50769,
		Shred = 5221,
		Soothe = 2908,
		StampedingRoarBal = 106898,
		StampedingRoarFeral = 77764,
		StampedingRoarGuard = 77761,
		TravelForm = 783,
		TreantForm = 114282,
		Wrath = 5176,
	--Guardian	
		Berserk = 50334,
		FrenziedRegeneration = 22842,
		IncapacitatingRoar = 99,
		Maul = 6807,
		RemoveCorruption = 2782,
		SkullBash = 106839,
		SurvivalInstincts = 61336,
		Swipe = 213764,
			Swipe_Bear = 213771,
			Swipe_Cat = 106785,
		Thrash = 106832,
			Thrash_Bear = 77758,
			Thrash_Cat = 106830,
	}
	ids.Guard_Passive = {
		AquaticForm = 276012,
		FlightForm = 276029,
		Gore = 210706,
		InfectedWounds = 345208,
		LightningReflexes = 231065,
		MasteryNaturesGuardian = 155783,
		ThickHide = 16931,
		UrsineAdept = 300346,
	}
	ids.Guard_Talent = {
		--15
		Brambles = 203953,
		BloodFrenzy = 203962,
		BristlingFur = 155835,
		--25
		TigerDash = 252216,
		Renewal = 108238,
		WildCharge = 102401,
			WildCharge_Bear = 16979,
			WildCharge_Cat = 49376,
			WildCharge_Moonkin = 102383,
		--30
		BalanceAffinity = 197488,
			MoonkinForm = 0,
			Starsurge = 197626,
			Starfire = 0,
			Sunfire = 197630,
			Typhoon = 0,
		FeralAffinity = 202155,
			Rake = 1822,
			Rip = 1079,
			Maim = 0,
		RestorationAffinity = 197492,
			Rejuvenation = 774,
			Swiftmend = 18562,
			WildGrowth = 48438,
			UrsolsVortex = 0,
		--35
		MightyBash = 5211,
		MassEntanglement = 102359,
		HeartoftheWild = 319454,
		--40
		SouloftheForest = 158477,
		GalacticGuardian = 203964,
		IncarnationGuardianofUrsoc = 102558,
		--45
		Earthwarden = 203974,
		SurvivaloftheFittest = 203965,
		GuardianofElune = 155578,
		--50
		RendandTear = 204053,
		ToothandClaw = 135288,
			EmpoweredMaul = 0,
		Pulverize = 80313,
	}
	ids.Guard_PvPTalent = {
		MasterShapeshifter = 236144,
		Toughness = 201259,
		DenMother = 236180,
		DemoralizingRoar = 201664,
		ClanDefender = 213951,
		RagingFrenzy = 236153,
		SharpenedClaws = 202110,
		ChargingBash = 228431,
		EntanglingClaws = 202226,
		Overrun = 202246,
		ProtectorofthePack = 202043,
		AlphaChallenge = 207017,
		MalornesSwiftness = 236147,
		RoaringSpeed = 236148,
	}
	ids.Guard_Form = {
		BearForm = 5487,
		CatForm = 768,
		Prowl = 5215,	
	}
	ids.Guard_Buff = {
		Barkskin = 22812,
		Ironfur = 192081,
		Regrowth = 8936,
		IncarnationGuardianofUrsoc = 102558,
		Pulverize = 158792,
		GalacticGuardian = 213708,
		SurvivalInstincts = 61336,
	}
	ids.Guard_Debuff = {
		Thrash = 192090,
		Moonfire = 164812,
	}
	ids.Guard_PetAbility = {
	
	}
	
--Restoration
	ids.Resto_Ability = {
	--Druid
		Barkskin = 22812,
		BearForm = 5487,
		CatForm = 768,
		CharmWoodlandCreature = 127757,
		Cyclone = 33786,
		Dash = 1850,
		Dreamwalk = 193753,
		EntanglingRoots = 339,
		FerociousBite = 22568,
		Flap = 164862,
		Growl = 6795,
		Hibernate = 2637,
		Ironfur = 192081,
		Mangle = 33917,
		Moonfire = 8921,
		MountForm = 210053,
		Prowl = 5215,
		Rebirth = 20484,
		Regrowth = 8936,
		Revive = 50769,
		Shred = 5221,
		Soothe = 2908,
		StampedingRoarBal = 106898,
		StampedingRoarFeral = 77764,
		StampedingRoarGuard = 77761,
		TravelForm = 783,
		TreantForm = 114282,
		Wrath = 5176,
	--Restoration	
		Efflorescence = 145205,
		Innervate = 29166,
		Ironbark = 102342,
		Lifebloom = 33763,
		NaturesCure = 88423,
		Rejuvenation = 774,
		Revitalize = 212040,
		Sunfire = 93402,
		Swiftmend = 18562,
		Tranquility = 740,
		UrsolsVortex = 102793,
		WildGrowth = 48438,
	}
	ids.Resto_Passive = {
		AquaticForm = 276012,
		FlightForm = 276029,
		MasteryHarmony = 77495,
		OmenofClarity = 113043,
		YserasGift = 145108,
	}
	ids.Resto_Talent = {
		--15
		Abundance = 207383,
		Nourish = 50464,
		CenarionWard = 102351,
		--25
		TigerDash = 252216,
		Renewal = 108238,
		WildCharge = 102401,
			WildChargeBear = 16979,
			WildChargeCat = 49376,
			WildChargeMoonkin = 102383,
		--30
		BalanceAffinity = 197632,
			MoonkinForm = 197625,
			Starsurge = 197626,
			Starfire = 197628,
			Typhoon = 132469,
		FeralAffinity = 197490,
			Rake = 1822,
			Rip = 1079,
			Swipe = 213764,
			Maim = 0,
		GuardianAffinity = 197491,
			ThickHide = 16931,	
			FrenziedRegeneration = 22842,
			IncapacitatingRoar = 0,
		--35
		MightyBash = 5211,
		MassEntanglement = 102359,
		HeartoftheWild = 319454,
		--40
		SouloftheForest = 158478,
		Cultivation = 200390,
		IncarnationTreeofLife = 33891,
		--45
		InnerPeace = 197073,
		SpringBlossoms = 207385,
		Overgrowth = 203651,
		--50
		Photosynthesis = 274902,
		Germination = 155675,
		Flourish = 197721,
	}
	ids.Resto_PvPTalent = {
		
	}
	ids.Resto_Form = {
		BearForm = 5487,
		CatForm = 768,
		MoonkinForm = 197625,
		Prowl = 5215,
	}
	ids.Resto_Buff = {
		EclipseLunar = 48518,
		EclipseSolar = 48517,		
		Ironfur = 192081,
		Regrowth = 8936,
		Lifebloom =	33763,
	}
	ids.Resto_Debuff = {
		Moonfire = 164812,
		Sunfire = 164815,
	}
	ids.Resto_PetAbility = {
	
	}