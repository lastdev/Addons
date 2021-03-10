local ConRO_Mage, ids = ...;

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
		Deathborne = 324220,
		Fleshcraft = 324631,
		MirrorsofTorment = 314793,
		PhialofSerenity = 177278,
		RadiantSpark = 307443,
		ShiftingPower = 314791,
		Soulshape = 310143,
		SummonSteward = 324739,
	}
	ids.Covenant_Buff = {

	}
	ids.Covenant_Debuff = {	
		MirrorsofTorment = 314793,
	}
	ids.Conduit = {
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
		CryoFreeze = 337123,
		DivertedEnergy = 337136,
		TempestBarrier = 337293,
	--Finesse
		FlowofTime = 336636,
		GroundingSurge = 336777,
		IncantationofSwiftness = 337275,
		WintersProtection = 336613,
	--Potency
		ArcaneProdigy = 336873,
		ArtificeoftheArchmage = 337240,
		ControlledDestruction = 341325,
		DisciplineoftheGrove = 336992,
		FlameAccretion = 337224,
		GiftoftheLich = 336999,
		IceBite = 336569,
		IcyPropulsion = 336522,
		InfernalCascade = 336821,
		IreoftheAscended = 337058,
		MagisBrand = 337192,
		MasterFlame = 336852,
		NetherPrecision = 336886,
		ShiveringCore = 336472,
		SiphonedMalice = 337087,
		UnrelentingCold = 336460,
	}
	ids.Conduit_Buff = {
		InfernalCascade = 336832,
	}
	ids.Conduit_Debuff = {	

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
	--Mage
		DisciplinaryCommand_Finger = "item:178926::::::::::::1:6832",
		DisciplinaryCommand_Wrist = "item:173249::::::::::::1:6832",
		ExpandedPotential_Feet = "item:173243::::::::::::1:6831",
		ExpandedPotential_Waist = "item:173248::::::::::::1:6831",
		GrislyIcicle_Head = "item:173245::::::::::::1:6937",
		GrislyIcicle_Shoulder = "item:173247::::::::::::1:6937",
		TemporalWarp_Chest = "item:173241::::::::::::1:6834", -- Flag for Rotation
		TemporalWarp_Finger = "item:178926::::::::::::1:6834",
		TriuneWard_Chest = "item:173241::::::::::::1:6936",
		TriuneWard_Neck = "item:178927::::::::::::1:6936",
	--Arcane
		ArcaneBombardment_Back = "item:173242::::::::::::1:6927",
		ArcaneBombardment_Feet = "item:173243::::::::::::1:6927",
		ArcaneHarmony_Hands = "item:173244::::::::::::1:6926",
		ArcaneHarmony_Shoulder = "item:173247::::::::::::1:6926",
		SiphonStorm_Feet = "item:173243::::::::::::1:6928",
		SiphonStorm_Legs = "item:173246::::::::::::1:6928",
	--Fire
		FeveredIncantation_Head = "item:173245::::::::::::1:6931",
		FeveredIncantation_Waist = "item:173248::::::::::::1:6931",
		Firestorm_Finger = "item:178926::::::::::::1:6932", -- Flag for Rotation
		Firestorm_Shoulder = "item:173247::::::::::::1:6932",
		MoltenSkyfall_Neck = "item:178927::::::::::::1:6933",
		MoltenSkyfall_Wrist = "item:173249::::::::::::1:6933",
		SunKingsBlessing_Hands = "item:173244::::::::::::1:6934", -- Flag for Rotation
		SunKingsBlessing_Wrist = "item:173249::::::::::::1:6934",
	--Frost
		ColdFront_Back = "item:173242::::::::::::1:6828",
		ColdFront_Chest = "item:173241::::::::::::1:6828",
		FreezingWinds_Hands = "item:173244::::::::::::1:6829",
		FreezingWinds_Head = "item:173245::::::::::::1:6829",
		GlacialFragments_Back = "item:173242::::::::::::1:6830",
		GlacialFragments_Legs = "item:173246::::::::::::1:6830",
		SlickIce_Legs = "item:173246::::::::::::1:6823",
		SlickIce_Waist = "item:173248::::::::::::1:6823",
	}
	ids.Legendary_Buff = {
		Firestorm = 333100,
	}
	ids.Legendary_Debuff = {	

	}
	
--Arcane
	ids.Arc_Ability = {
	--Mage
		ArcaneExplosion = 1449,
		ArcaneIntellect = 1459,
		Blink = 1953,
		ConjureRefreshment = 190336,
		Counterspell = 2139,
		FireBlast = 319836,
		FrostNova = 122,
		Frostbolt = 116,
		IceBlock = 45438,
		MirrorImage = 55342,
		Polymorph = 118,
		RemoveCurse = 475,
		SlowFall = 130,
		Spellsteal = 30449,
		TimeWarp = 80353,
	--Arcane
		AlterTime = 342245,
		ArcaneBarrage = 44425,
		ArcaneBlast = 30451,	
		ArcaneMissiles = 5143,
		ArcanePower = 12042,
		ConjureManaGem = 759,
			ManaGem = 36799,
		Evocation = 12051,
		GreaterInvisibility = 110959,
		PresenceofMind = 205025,
		PrismaticBarrier = 235450,
		Slow = 31589,
		TouchoftheMagi = 321507,
	}
	ids.Arc_Passive = {
		Clearcasting = 79684,
		MasterySavant = 190740,
	}
	ids.Arc_Talent = {
		--15
		Amplification = 236628,
		RuleofThrees = 264354,
		ArcaneFamiliar = 205022,
		--25
		MasterofTime = 342249,
		Shimmer = 212653,
		Slipstream = 236457,
		--30
		IncantersFlow = 1463,
		FocusMagic = 321358,
		RuneofPower = 116011,
		--35
		Resonance = 205028,
		ArcaneEcho = 342231,
		NetherTempest = 114923,
		--40
		ChronoShift = 235711,
		IceWard = 205036,
		RingofFrost = 113724,
		--45
		Reverberate = 281482,
		ArcaneOrb = 153626,
		Supernova = 157980,
		--50
		Overpowered = 155147,
		TimeAnomaly = 210805,
		Enlightened = 321387,
	}
	ids.Arc_PvPTalent = {
		ArcaneEmpowerment = 276741,
		TormenttheWeak = 198151,
		MasterofEscape = 210476,
		RewindTime = 213220,
		MassInvisibility = 198158,
		NetherwindArmor = 198062,
		TemporalShield = 198111,
		DampenedMagic = 236788,
		Kleptomania = 198100,
		PrismaticCloak = 198064,
	}
	ids.Arc_Form = {
		PresenceofMind = 205025,
		IncantersFlow = 116267,
		RuneofPower = 116014,
	}
	ids.Arc_Buff = {
		ArcaneFamiliar = 210126,
		ArcaneIntellect = 1459,
		ArcanePower = 12042,
		Clearcasting = 263725,
		ClearcastingPvP = 276743,
		Evocation = 12051,
		PrismaticBarrier = 235450,
		RuleofThrees = 264774,
	}
	ids.Arc_Debuff = {
		NetherTempest = 114923,
		TouchoftheMagi = 210824,
	}
	ids.Arc_PetAbility = {
			
	}
		
--Fire
	ids.Fire_Ability = {
	--Mage
		ArcaneExplosion = 1449,
		ArcaneIntellect = 1459,
		Blink = 1953,
		ConjureRefreshment = 190336,
		Counterspell = 2139,
		FrostNova = 122,
		Frostbolt = 116,
		IceBlock = 45438,
		Invisibility = 66,
		MirrorImage = 55342,
		Polymorph = 118,
		RemoveCurse = 475,
		SlowFall = 130,
		Spellsteal = 30449,
		TimeWarp = 80353,
	--Fire
		AlterTime = 108978,
		BlazingBarrier = 235313,	
		Combustion = 190319,
		DragonsBreath = 31661,
		FireBlast = 108853,
		Fireball = 133,
		Flamestrike = 2120,
		PhoenixFlames = 257541,
		Pyroblast = 11366,
		Scorch = 2948,
	}
	ids.Fire_Passive = {
		Cauterize = 86949,
		CriticalMass = 117216,
		EnhancedPyrotechnics = 157642,
		HotStreak = 195283,
		MasteryIgnite = 12846,
	}
	ids.Fire_Talent = {
		--15
		Firestarter = 205026,
		Pyromaniac = 205020,
		SearingTouch = 269644,
		--25
		BlazingSoul = 235365,
		Shimmer = 212653,
		BlastWave = 157981,
		--30
		IncantersFlow = 1463,
		FocusMagic = 321358,
		RuneofPower = 116011,
		--35
		FlameOn = 205029,
		AlexstraszasFury = 235870,
		FromtheAshes = 342344,
		--40
		FreneticSpeed = 236058,
		IceWard = 205036,
		RingofFrost = 113724,
		--45
		FlamePatch = 205037,
		Conflagration = 205023,
		LivingBomb = 44457,
		--50
		Kindling = 155148,
		Pyroclasm = 269650,
		Meteor = 153561,
	}
	ids.Fire_PvPTalent = {
		--Honorable Medallion
		Adaptation = 214027,
		Relentless = 196029,
		GladiatorsMedallion = 208683,
		--
		NetherwindArmor = 198062,
		TemporalShield = 198111,
		Tinder = 203275,
		WorldinFlames = 203280,
		ControlledBurn = 280450,
		Firestarter = 203283,
		Flamecannon = 203284,
		GreaterPyroblast = 203286,
		PrismaticCloak = 198064,
		DampenedMagic = 236788,
		Kleptomania = 198100,
	}
	ids.Fire_Form = {
		RuneofPower = 116014,	
	}
	ids.Fire_Buff = {
		ArcaneIntellect = 1459,
		BlazingBarrier = 235313,
		Combustion = 190319,
		HeatingUp = 48107,
		HotStreak = 48108,
		IncantersFlow = 116267,
		LivingBomb = 217694,
		Pyroclasm = 269651, 
	}
	ids.Fire_Debuff = {
		Conflagration = 226757,
		Ignite = 12654,
	}
	ids.Fire_PetAbility = {
		
	}

--Frost
	ids.Frost_Ability = {
	--Mage
		ArcaneExplosion = 1449,
		ArcaneIntellect = 1459,
		Blink = 1953,
		ConjureRefreshment = 190336,
		Counterspell = 2139,
		FireBlast = 319836,
		FrostNova = 122,
		Frostbolt = 116,
		IceBlock = 45438,
		Invisibility = 66,
		MirrorImage = 55342,
		Polymorph = 118,
		RemoveCurse = 475,
		SlowFall = 130,
		Spellsteal = 30449,
		TimeWarp = 80353,
	--Frost
		AlterTime = 108978,
		Blizzard = 190356,
		ColdSnap = 235219,
		ConeofCold = 120,
		Flurry = 44614,
		FrozenOrb = 84714,
		IceBarrier = 11426,
		IceLance = 30455,
		IcyVeins = 12472,
		SummonWaterElemental = 31687,
	}
	ids.Frost_Passive = {
		BrainFreeze = 190447,
		FingersofFrost = 112965,
		MasteryIcicles = 76613,
		Shatter = 12982,
	}
	ids.Frost_Talent = {
		--15
		BoneChilling = 205027,
		LonelyWinter = 205024,
		IceNova = 157997,
		--25
		GlacialInsulation = 2352974,
		Shimmer = 212653,
		IceFloes = 108839,
		--30
		IncantersFlow = 1463,
		FocusMagic = 321358,
		RuneofPower = 116011,
		--35
		FrozenTouch = 205030,
		ChainReaction = 278309,
		Ebonbolt = 257537,
		--40
		FrigidWinds = 235224,
		IceWard = 205036,
		RingofFrost = 113724,
		--45
		FreezingRain = 270233,
		SplittingIce = 56377,
		CometStorm = 153595,
		--50
		ThermalVoid = 155149,
		RayofFrost = 205021,
		GlacialSpike = 199786,
	}
	ids.Frost_PvPTalent = {
		--Honorable Medallion
		Adaptation = 214027,
		Relentless = 196029,
		GladiatorsMedallion = 208683,
		--
		DampenedMagic = 236788,
		Kleptomania = 198100,
		ChilledtotheBone = 198126,
		Frostbite = 198120,
		DeepShatter = 198123,
		ConcentratedCoolness = 198148,
			ConcentratedCoolness_FrozenOrb = 198149,
		BurstofCold = 206431,
		IceForm = 198144,
		NetherwindArmor = 198062,
		PrismaticCloak = 198064,
	}
	ids.Frost_Form = {
		RuneofPower = 116014,
	}
	ids.Frost_Buff = {
		ArcaneIntellect = 1459,
		BrainFreeze = 190446,
		FingersofFrost = 44544,
		FreezingRain = 270232,
		GlacialSpike = 199844,
		IceBarrier = 11426,
		Icicles = 205473,
		IcyVeins = 12472,
	}
	ids.Frost_Debuff = {
		WintersChill = 228358,
	}
	ids.Frost_PetAbility = {
		
	}