local ConRO_DeathKnight, ids = ...;

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
		AbominationLimb = 315443,
		DeathsDue = 324128,
		Fleshcraft = 324631,
		PhialofSerenity = 177278,
		ShackletheUnworthy = 312202,
		Soulshape = 310143,
		SummonSteward = 324739,
		SwarmingMist = 311648,
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
		BloodBond = 337957,
		HardenedBones = 337972,
		InsatiableAppetite = 338330,
		MeatShield = 338435,
		ReinforcedShell = 337764,
	--Finesse
		ChilledResilience = 337704,
		FleetingWind = 338089,
		SpiritDrain = 337705,
		UnendingGrip = 338311,
	--Potency
		AcceleratedCold = 337822,
		BrutalGrasp = 338651,
		ConvocationoftheDead = 338553,
		DebilitatingMalady = 338516,
		EmbraceDeath = 337980,
		EradicatingBlow = 337934,
		EternalHunger = 337381,
		Everfrost = 337988,
		ImpenetrableGloom = 338628,
		LingeringPlague = 338566,
		Proliferation = 338664,
		UnleashedFrenzy = 338492,
		WitheringGround = 341344,
		WitheringPlague = 337884,
	}
	ids.Covenant_Buff = {

	}
	ids.Covenant_Debuff = {	
		ShackletheUnworthy = 312202,
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
	--DeathKnight
		DeathsEmbrace_Finger = "item:178926::::::::::::1:6947",
		DeathsEmbrace_Wrist = "item:171419::::::::::::1:6947",
		GripoftheEverlasting_Feet = "item:171413::::::::::::1:6948",
		GripoftheEverlasting_Waist = "item:171418::::::::::::1:6948",
		Phearomones_Head = "item:171415::::::::::::1:6954",
		Phearomones_Shoulder = "item:171417::::::::::::1:6954",
		Superstrain_Chest = "item:171412::::::::::::1:6953",
		Superstrain_Neck = "item:178927::::::::::::1:6953",
	--Blood
		BryndaorsMight_Back = "item:173242::::::::::::1:6940",
		BryndaorsMight_Feet = "item:171413::::::::::::1:6940",
		CrimsonRuneWeapon_Hands = "item:171414::::::::::::1:6941",
		CrimsonRuneWeapon_Shoulder = "item:171417::::::::::::1:6941",
		GorefiendsDomination_Feet = "item:171413::::::::::::1:6943",
		GorefiendsDomination_Legs = "item:171416::::::::::::1:6943",
		VampiricAura_Chest = "item:171412::::::::::::1:6942",
		VampiricAura_Finger = "item:178926::::::::::::1:6942",
	--Frost
		AbsoluteZero_Neck = "item:178927::::::::::::1:6946",
		AbsoluteZero_Wrist = "item:171419::::::::::::1:6946",
		BitingCold_Head = "item:171415::::::::::::1:6945",
		BitingCold_Waist = "item:171418::::::::::::1:6945",
		KoltirasFavor_Finger = "item:178926::::::::::::1:6944",
		KoltirasFavor_Shoulder = "item:171417::::::::::::1:6944",
		RageoftheFrozenChampion_Hands = "item:171414::::::::::::1:7160",
		RageoftheFrozenChampion_Wrist = "item:171419::::::::::::1:7160",
	--Unholy
		DeadliestCoil_Back = "item:173242::::::::::::1:6952", --Flag for Rotation
		DeadliestCoil_Chest = "item:171412::::::::::::1:6952",
		DeathsCertainty_Hands = "item:171414::::::::::::1:6951",
		DeathsCertainty_Head = "item:171415::::::::::::1:6951",
		FrenziedMonstrosity_Back = "item:173242::::::::::::1:6950",
		FrenziedMonstrosity_Legs = "item:171416::::::::::::1:6950",
		ReanimatedShambler_Legs = "item:171416::::::::::::1:6949",
		ReanimatedShambler_Waist = "item:171418::::::::::::1:6949",
	}
	ids.Legendary_Buff = {

	}
	ids.Legendary_Debuff = {	

	}

--DeathKnight
	ids.DeathKnight_Ability = {

	}
	ids.DeathKnight_Passive = {

	}
	ids.DeathKnight_Buff = {

	}
	ids.DeathKnight_Debuff = {

	}
	
--Blood
	ids.Blood_Ability = {
	--Death Knight	
		AntiMagicShell = 48707,
		AntiMagicZone = 51052,
		ChainsofIce = 45524,
		ControlUndead = 111673,
		DarkCommand = 56222,
		DeathandDecay = 43265,
		DeathCoil = 47541,
		DeathGate = 50977,
		DeathGrip = 49576,
		DeathStrike = 49998,
		DeathsAdvance = 48265,
		IceboundFortitude = 48792,
		Lichborne = 49039,
		MindFreeze = 47528,
		PathofFrost = 3714,
		RaiseAlly = 61999,
		RaiseDead = 46585,
		Runeforging = 53428,
		SacrificialPact = 327574,
	--Blood
		Asphyxiate = 221562,
		BloodBoil = 50842,
		DancingRuneWeapon = 49028,
		DeathsCaress = 195292,
		GorefiendsGrasp = 108199,
		HeartStrike = 206930,
		Marrowrend = 195182,
		RuneTap = 194679,
		VampiricBlood = 55233,
	}
	ids.Blood_Passive = {
	--Death Knight
		OnaPaleHorse = 51986,
		VeteranoftheThirdWar = 48263,
	--Blood	
		CrimsonScourge = 81136,
		MasteryBloodShield = 77513,
	}
	ids.Blood_Talent = {
		--15
		Heartbreaker = 221536,		
		Blooddrinker = 206931,		
		Tombstone = 219809,
		--25		
		RapidDecomposition = 194662,
		Hemostasis = 273946,
		Consumption = 274156,
		--30		
		FoulBulwark = 206974,
		RelishinBlood = 317610,
		BloodTap = 221699,
		--35
		WilloftheNecropolis = 206967,
		AntiMagicBarrier = 205727,
		MarkofBlood = 206940,
		--40
		GripoftheDead = 273952,
		TighteningGrasp = 206970,
		WraithWalk = 212552,
		--45
		Voracious = 273953,
		DeathPact = 48743,
		Bloodworms = 195679,	
		--50
		Purgatory = 114556,
		RedThirst = 205723,
		Bonestorm = 194844,
	}
	ids.Blood_PvPTalent = {
		RotandWither = 202727,
		WalkingDead = 202731,
		Strangulate = 47476,
		BloodforBlood = 233411,
		LastDance = 233412,
		DeathChain = 203173,
		MurderousIntent = 207018,
		NecroticAura = 199642,
		DecomposingAura = 199720,
		DarkSimulacrum = 77606,
		DomeofAncientShadow = 328718,
	}
	ids.Blood_Form = {
	
	}
	ids.Blood_Buff = {
		BloodforBlood = 233411,
		BloodShield = 77535,
		BoneShield = 195181,
		CrimsonScourge = 81141,
		DancingRuneWeapon = 81256,
		DeathandDecay = 188290,
		Hemostasis = 273947,
		Lichborne = 49039,
		RuneTap = 194679,
	}
	ids.Blood_Debuff = {
		BloodPlague = 55078,
	}
	ids.Blood_PetAbility = {
			
	}
		
--Frost
	ids.Frost_Ability = {
	--Death Knight	
		AntiMagicShell = 48707,
		AntiMagicZone = 51052,
		ChainsofIce = 45524,
		ControlUndead = 111673,
		DarkCommand = 56222,
		DeathandDecay = 43265,
		DeathCoil = 47541,
		DeathGate = 50977,
		DeathGrip = 49576,
		DeathStrike = 49998,
		DeathsAdvance = 48265,
		IceboundFortitude = 48792,
		Lichborne = 49039,
		MindFreeze = 47528,
		PathofFrost = 3714,
		RaiseAlly = 61999,
		RaiseDead = 46585,
		Runeforging = 53428,
		SacrificialPact = 327574,
	--Frost	
		EmpowerRuneWeapon = 47568,
		FrostStrike = 49143,
		FrostwyrmsFury = 279302,
		HowlingBlast = 49184,
		Obliterate = 49020,
		PathofFrost = 3714,
		PillarofFrost = 51271,
		RaiseAlly = 61999,
		RemorselessWinter = 196770,
	}
	ids.Frost_Passive = {
	--Death Knight
		OnaPaleHorse = 51986,
		VeteranoftheThirdWar = 48263,
	--Frost
		DarkSuccor = 178819,
		KillingMachine = 51128,
		MasteryFrozenHeart = 77514,
		MightoftheFrozenWastes = 81333,
		Rime = 59057,
		RunicEmpowerment = 81229,
	}
	ids.Frost_Talent = {
		--56
		InexorableAssault = 253593,
		IcyTalons = 194878,		
		ColdHeart = 281208,
		--57
		RunicAttenuation = 207104,
		MurderousEfficiency = 207061,
		HornofWinter = 57330,
		--58		
		DeathsReach = 276079,
		Asphyxiate = 108194,
		BlindingSleet = 207167,		
		--60		
		Avalanche = 207142,
		FrozenPulse = 194909,
		Frostscythe = 207230,
		--75
		Permafrost = 207200,
		WraithWalk = 212552,
		DeathPact = 48743,
		--90
		GatheringStorm = 194912,
		HypothermicPresence = 321995,
		GlacialAdvance = 194913,
		--100
		Icecap = 207126,
		Obliteration = 281238,
		BreathofSindragosa = 152279,
	}
	ids.Frost_PvPTalent = {
		NecroticAura = 199642,
		Deathchill = 204080,
		Delirium = 233396,
		ChillStreak = 305392,
		HeartstopAura = 199719,
		DarkSimulacrum = 77606,
		CadaverousPallor = 201995,
		DeadofWinter = 287250,
		Transfusion = 288977,
		DomeofAncientShadow = 328718,
	}
	ids.Frost_Form = {
		BreathofSindragosa = 152279,
	}
	ids.Frost_Buff = {
		ColdHeart = 281209,
		DarkSuccor = 101568,
		IcyTalons = 194879,
		InexorableAssault = 253595,
		KillingMachine = 51124,
		Lichborne = 49039,
		PillarofFrost = 51271,
		RemorselessWinter = 196770,
		Rime = 59052,
		UnholyStrength = 53365,
		BloodShield = 77535,
		DeathandDecay = 188290,
		EmpowerRuneWeapon = 47568,
	}
	ids.Frost_Debuff = {
		FrostFever = 55095,
		RazorIce = 51714,
	}
	ids.Frost_PetAbility = {
		
	}

--Unholy
	ids.Unholy_Ability = {
	--Death Knight	
		AntiMagicShell = 48707,
		AntiMagicZone = 51052,
		ChainsofIce = 45524,
		ControlUndead = 111673,
		DarkCommand = 56222,
		DeathandDecay = 43265,
		DeathCoil = 47541,
		DeathGate = 50977,
		DeathGrip = 49576,
		DeathStrike = 49998,
		DeathsAdvance = 48265,
		IceboundFortitude = 48792,
		Lichborne = 49039,
		MindFreeze = 47528,
		PathofFrost = 3714,
		RaiseAlly = 61999,
		RaiseDead = 46585,
		Runeforging = 53428,
		SacrificialPact = 327574,
	--Unholy
		Apocalypse = 275699,
		ArmyoftheDead = 42650,
		DarkTransformation = 63560,
		Epidemic = 207317,
		FesteringStrike = 85948,
		Outbreak = 77575,
		RaiseDead = 46584,
		ScourgeStrike = 55090,
	}
	ids.Unholy_Passive = {
	--Death Knight
		OnaPaleHorse = 51986,
		VeteranoftheThirdWar = 48263,
	--Unholy
		DarkSuccor = 178819,
		MasteryDreadblade = 77515,
		RunicCorruption = 51462,
		SuddenDoom = 49530,
	}
	ids.Unholy_Talent = {
		--15
		InfectedClaws = 207272,
		AllWillServe = 194916,
		ClawingShadows = 207311,
		--25
		BurstingSores = 207264,
		EbonFever = 207269,
		UnholyBlight = 115989,
		--30
		GripoftheDead = 273952,
		DeathsReach = 276079,
		Asphyxiate = 108194,
		--35
		PestilentPustules = 194917,
		HarbingerofDoom = 276023,
		SoulReaper = 343294,
		--40
		SpellEater = 207321,
		WraithWalk = 212552,
		DeathPact = 48743,
		--45
		Pestilence = 277234,
		UnholyPact = 319230,
		Defile = 152280,
		--50
		ArmyoftheDamned = 276837,
		SummonGargoyle = 49206,
		UnholyAssault = 207289,
	}
	ids.Unholy_PvPTalent = {
		LifeandDeath = 288855,
		DarkSimulacrum = 77606,		
		NecroticStrike = 223829,
		Reanimation = 210128,
		CadaverousPallor = 201995,
		NecroticAura = 199642,		
		DecomposingAura = 199720,
		NecromancersBargain = 288848,
		RaiseAbomination = 288853,
		Transfusion = 288977,
		DomeofAncientShadow = 328718,
	}	
	ids.Unholy_Form = {
		
	}
	ids.Unholy_Buff = {
		BloodShield = 77535,
		DarkSuccor = 101568,
		DarkTransformation = 63560,
		DeathandDecay = 188290,
		Lichborne = 49039,
		SuddenDoom = 81340,
		SoulReaper = 215711,
		Transfusion = 288977,
		UnholyBlight = 115989,
	}
	ids.Unholy_Debuff = {
		FesteringWound = 194310,
		NecroticStrike = 223929,		
		ScourgeofWorlds = 191748,
		SoulReaper = 130736,
		VirulentPlague = 191587,
		UnholyBlight = 115994,
	}
	ids.Unholy_PetAbility = {
		Claw = 47468,
	}