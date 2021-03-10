local ConRO_Priest, ids = ...;

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
	ids.Glyph = {
		Lightspawn = 254224,
		Sha = 132603,
		Voidling = 254232,
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
		BoonoftheAscended = 325013,
			AscendedBlast = 325283,
			AscendedNova = 325020,
		FaeGuardians = 327661,
		Fleshcraft = 324631,
		Mindgames = 323673,
		PhialofSerenity = 177278,
		Soulshape = 310143,
		SummonSteward = 324739,
		UnholyNova = 324724,
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
		CharitableSoul = 337715,
		LightsInspiration = 337748,
		TranslucentImage = 337662,
	--Finesse
		ClearMind = 337707,
		MentalRecovery = 337954,
		MovewithGrace = 337678,
		PowerUntoOthers = 337762,
	--Potency
		CourageousAscension = 337966,
		DissonantEchoes = 338342,
			DissonantEchoes_VoidBolt = 343355,
		Exaltation = 337790,
		FaeFermata = 338305,
		FesteringTransfusion = 337979,
		FocusedMending = 337914,
		HauntingApparitions = 338319,
		HolyOration = 338345,
		LastingSpirit = 337811,
		MindDevourer = 338332,
		PainTransformation = 337786,
		RabidShadows = 338338,
		ResonantWords = 337947,
		ShatteredPerceptions = 338315,
		ShiningRadiance = 337778,
		SwiftPenitence = 337891,
	}
	ids.Covenant_Buff = {
		BoonoftheAscended = 325013,
		DissonantEchoes = 343144,
		MindDevourer = 338333,
	}
	ids.Covenant_Debuff = {	

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
	--Priest
		CauterizingShadows_Feet = "item:173243::::::::::::1:6975",
		CauterizingShadows_Waist = "item:173248::::::::::::1:6975",
		MeasuredContemplation_Chest = "item:173241::::::::::::1:7161",
		MeasuredContemplation_Neck = "item:178927::::::::::::1:7161",
		TwinsoftheSunPriestess_Head = "item:173245::::::::::::1:7002",
		TwinsoftheSunPriestess_Shoulder = "item:173247::::::::::::1:7002",
		VaultofHeavens_Finger = "item:178926::::::::::::1:6972",
		VaultofHeavens_Wrist = "item:173249::::::::::::1:6972",
	--Discipline
		ClarityofMind_Chest = "item:173241::::::::::::1:6980",
		ClarityofMind_Finger = "item:178926::::::::::::1:6980",
		CrystallineReflection_Hands = "item:173244::::::::::::1:6978",
		CrystallineReflection_Shoulder = "item:173247::::::::::::1:6978",
		KissofDeath_Feet = "item:173243::::::::::::1:6979",
		KissofDeath_Legs = "item:173246::::::::::::1:6979",
		ThePenitentOne_Back = "item:173242::::::::::::1:6976",
		ThePenitentOne_Feet = "item:173243::::::::::::1:6976",
	--Holy
		DivineImage_Head = "item:173245::::::::::::1:6973",
		DivineImage_Waist = "item:173248::::::::::::1:6973",
		FlashConcentration_Neck = "item:178927::::::::::::1:6974",
		FlashConcentration_Wrist = "item:173249::::::::::::1:6974",
		HarmoniousApparatus_Finger = "item:178926::::::::::::1:6977",
		HarmoniousApparatus_Shoulder = "item:173247::::::::::::1:6977",
		XanshiReturnofArchbishopBenedictus_Legs = "item:173246::::::::::::1:6984",
		XanshiReturnofArchbishopBenedictus_Back = "item:173242::::::::::::1:6984",		
	--Shadow
		EternalCalltotheVoid_Hands = "item:173244::::::::::::1:6983",
		EternalCalltotheVoid_Wrist = "item:173249::::::::::::1:6983",
		PainbreakerPsalm_Back = "item:173242::::::::::::1:6981",
		PainbreakerPsalm_Chest = "item:173241::::::::::::1:6981",
		ShadowflamePrism_Hands = "item:173244::::::::::::1:6982",
		ShadowflamePrism_Head = "item:173245::::::::::::1:6982",
		TalbadarsStratagem_Legs = "item:173246::::::::::::1:7162",
		TalbadarsStratagem_Waist = "item:173248::::::::::::1:7162",
	}
	ids.Legendary_Buff = {

	}
	ids.Legendary_Debuff = {	

	}

--Discipline
	ids.Disc_Ability = {
	--Priest
		DesperatePrayer = 19236,
		DispelMagic = 528,
		Fade = 586,
		FlashHeal = 2061,
		LeapofFaith = 73325,
		Levitate = 1706,
		MassDispel = 32375,
		MindBlast = 8092,
		MindControl = 605,
		MindSoothe = 453,
		MindVision = 2096,
		PowerInfusion = 10060,
		PowerWordFortitude = 21562,
		PowerWordShield = 17,
		PsychicScream = 8122,
		Resurrection = 2006,
		ShackleUndead = 9484,
		ShadowWordDeath = 32379,
		ShadowWordPain = 589,
		Smite = 585,
	--Discipline
		HolyNova = 132157,
		MassResurrection = 212036,
		MindSear = 48045,
		PainSuppression = 33206,
		Penance = 47540,
		PowerWordBarrier = 62618,
		PowerWordRadiance = 194509,
		Purify = 527,
		Rapture = 47536,
		ShadowMend = 186263,
		Shadowfiend = 34433,
	}
	ids.Disc_Passive = {
	--Priest
		FocusedWill = 45243,
	--Discipline
		Atonement = 81749,
		MasteryGrace = 271534,
		PoweroftheDarkSide = 198068,
	}
	ids.Disc_Talent = {
		--15
		Castigation = 193134,
		TwistofFate = 265259,
		Schism = 214621,
		--30
		BodyandSoul = 64129,
		Masochism = 193063,
		AngelicFeather = 121536,
		--45
		ShieldDiscipline = 197045,
		Mindbender = 123040,
		PowerWordSolace = 129250,
		--60
		PsychicVoice = 196704,
		DominantMind = 205367,
		ShiningForce = 204263,
		--75
		SinsoftheMany = 280391,
		Contrition = 197419,
		ShadowCovenant = 314867,
		--90
		PurgetheWicked = 204197,
		DivineStar = 110744,
		Halo = 120517,
		--100
		Lenience = 238063,
		SpiritShell = 109964,
		Evangelism = 246287,
	}
	ids.Disc_PvPTalent = {	
		Purification = 196162,
		PurifiedResolve = 196439,
		Trinity = 214205,
		StrengthofSoul = 197535,
		UltimateRadiance = 236499,
		DomeofLight = 197590,
		Archangel = 197862,
		DarkArchangel = 197871,
		Thoughtsteal = 316262,
		SearingLight = 215768,
	}
	ids.Disc_Form = {
	
	}
	ids.Disc_Buff = {
		Atonement = 194384,
		PoweroftheDarkSide = 198069,
		PowerWordFortitude = 21562,
		PowerWordShield = 17,
		Rapture = 47536,
		SpiritShell = 109964,
	}
	ids.Disc_Debuff = {
		PurgetheWicked = 204213,
		ShadowWordPain = 589,	
		WeakenedSoul = 6788,		
	}
	ids.Disc_PetAbility = {
			
	}
		
--Holy
	ids.Holy_Ability = {
	--Priest
		DesperatePrayer = 19236,
		DispelMagic = 528,
		Fade = 586,
		FlashHeal = 2061,
		LeapofFaith = 73325,
		Levitate = 1706,
		MassDispel = 32375,
		MindBlast = 8092,
		MindControl = 605,
		MindSoothe = 453,
		MindVision = 2096,
		PowerInfusion = 10060,
		PowerWordFortitude = 21562,
		PowerWordShield = 17,
		PsychicScream = 8122,
		Resurrection = 2006,
		ShackleUndead = 9484,
		ShadowWordDeath = 32379,
		ShadowWordPain = 589,
		Smite = 585,
	--Holy
		CircleofHealing = 204883,
		DivineHymn = 64843,
		GuardianSpirit = 47788,
		Heal = 2060,
		HolyFire = 14914,
		HolyNova = 132157,
		HolyWordChastise = 88625,
		HolyWordSanctify = 34861,
		HolyWordSerenity = 2050,
		MassResurrection = 212036,
		PrayerofHealing = 596,
		PrayerofMending = 33076,
		PsychicScream = 8122,
		Purify = 527,
		Renew = 139,
		SymbolofHope = 64901,
	}
	ids.Holy_Passive = {
	--Priest
		FocusedWill = 45243,
	--Holy
		MasteryEchoofLight = 77485,
		SpiritofRedemption = 20711,
	}
	ids.Holy_Talent = {
		--15
		Enlightenment = 193155,		
		TrailofLight = 200128,		
		RenewedFaith = 341997,
		--25
		AngelsMercy = 238100,
		Perseverance = 235189,	
		AngelicFeather = 121536,
		--30
		CosmicRipple = 238136,
		GuardianAngel = 200209,
		Afterlife = 196707,
		--35
		PsychicVoice = 196704,
		Censure = 200199,
		ShiningForce = 204263,
		--40
		SurgeofLight = 109186,
		BindingHeal = 32546,
		PrayerCircle = 321377,
		--45
		Benediction = 193157,
		DivineStar = 110744,
		Halo = 120517,
		--50
		LightoftheNaaru = 196985,
		Apotheosis = 200183,
		HolyWordSalvation = 265202,
	}
	ids.Holy_PvPTalent = {	
		HolyWard = 213610,
		HolyWordConcentration = 289657,
		GreaterHeal = 289666,
		CardinalMending = 328529,
		MiracleWorker = 235587,
		SpiritoftheRedeemer = 215982,
		RayofHope = 197268,
		GreaterFade = 213602,
		DeliveredfromEvil = 196611,
		Thoughtsteal = 316262,
		DivineAscension = 328530,
	}
	ids.Holy_Form = {
	
	}
	ids.Holy_Buff = {
		PowerWordFortitude = 21562,
		PowerWordShield = 17,
	}
	ids.Holy_Debuff = {
		HolyFire = 14914,
		ShadowWordPain = 589,	
		WeakenedSoul = 6788,
	}
	ids.Holy_PetAbility = {
		
	}

--Shadow
	ids.Shad_Ability = {
	--Priest
		DesperatePrayer = 19236,
		DispelMagic = 528,
		Fade = 586,
		FlashHeal = 2061,
		LeapofFaith = 73325,
		Levitate = 1706,
		MassDispel = 32375,
		MindBlast = 8092,
		MindControl = 605,
		MindSoothe = 453,
		MindVision = 2096,
		PowerInfusion = 10060,
		PowerWordFortitude = 21562,
		PowerWordShield = 17,
		PsychicScream = 8122,
		Resurrection = 2006,
		ShackleUndead = 9484,
		ShadowWordDeath = 32379,
		ShadowWordPain = 589,
		Smite = 585,
	--Shadow	
		DevouringPlague = 335467,
		Dispersion = 47585,
		MindFlay = 15407,
		MindSear = 48045,
		PurifyDisease = 213634,
		ShadowMend = 186263,
		Shadowfiend = 34433,
		Shadowform = 232698,
		Silence = 15487,
		VampiricEmbrace = 15286,
		VampiricTouch = 34914,
		VoidBolt = 205448,
		VoidEruption = 228260,
	}
	ids.Shad_Passive = {
	--Priest
		FocusedWill = 45243,	
	--Shadow
		DarkThoughts = 341205,
		Hallucinations = 280752,
		MasteryShadowWeaving = 343690,
		ShadowyApparitions = 341491,
		VoidBolt = 228266,
		VoidForm = 228264,
	}
	ids.Shad_Talent = {
		--15
		FortressoftheMind = 193195,
		DeathandMadness = 321291,
		UnfurlingDarkness = 341273,
		--25
		BodyandSoul = 64129,
		Sanlayn = 199855,
		Intangibility = 288733,
		--30
		TwistofFate = 109142,
		Misery = 238558,
		SearingNightmare = 341385,
		--35
		LastWord = 263716,
		MindBomb = 205369,
		PsychicHorror = 64044,
		--40
		AuspiciousSpirits = 155271,
		PsychicLink = 199484,
		ShadowCrash = 205385,
		--45
		Damnation = 341374,
		Mindbender = 200174,
		VoidTorrent = 263165,
		--50
		AncientMadness = 341240,
		HungeringVoid = 345218,
		SurrendertoMadness = 319952,
	}
	ids.Shad_PvPTalent = {	
		VoidShield = 280749,
		DriventoMadness = 199259,
		MindTrauma = 199445,
		VoidShift = 108968,
		VoidOrigins = 228630,
		Psyfiend = 211522,
		GreaterFade = 213602,
		LastingPlague = 341167,
		Thoughtsteal = 316262,
	}
	ids.Shad_Form = {
		Shadowform = 232698,
		Voidform = 194249,
		SurrendertoMadness = 193223,
	}
	ids.Shad_Buff = {
		DarkThoughts = 341207,
		PowerInfusion = nil,
		PowerWordFortitude = 21562,
		PowerWordShield = 17,
		UnfurlingDarkness = 341282,
		VampiricEmbrace = 15286,
	}
	ids.Shad_Debuff = {
		DevouringPlague = 335467,
		ShadowWordPain = 589,
		VampiricTouch = 34914,
		WeakenedSoul = 6788,
	}
	ids.Shad_PetAbility = {
		
	}