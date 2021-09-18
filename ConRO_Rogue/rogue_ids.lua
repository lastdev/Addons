local ConRO_Rogue, ids = ...;

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
		EchoingReprimand = 323547,
		Flagellation = 323654,
		FleshCraft = 324631,
		PhialofSerenity = 177278,
		SerratedBoneSpike = 328547,
		Sepsis = 328305,
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
		CloakedinShadows = 341529,
		NimbleFingers = 341311,
		Recuperator = 341312,
	--Finesse
		FadetoNothing = 341532,
		PreparedforAll = 341535,
		QuickDecisions = 341531,
		RushedSetup = 341534,
	--Potency
		Ambidexterity = 341542,
		CounttheOdds = 341546,
		DeeperDaggers = 341549,
		LashingScars = 341310,
		LethalPoisons = 341539,
		MaimMangle = 341538,
		PerforatedVeins = 341567,
		PlannedExecution = 341556,
		PoisonedKatar = 341536,
		Reverberation = 341264,
		SepticShock = 341309,
		SleightofHand = 341543,
		StilettoStaccato = 341559,
		SuddenFractures = 341272,
		TripleThreat = 341540,
		WellPlacedSteel = 341537,
	}
	ids.Covenant_Buff = {
		EchoingReprimand_2 = 323558,
		EchoingReprimand_3 = 323559,
		EchoingReprimand_4 = 323560,
		Flagellation = 323654,
		Sepsis = 347037,
	}
	ids.Covenant_Debuff = {	
		SerratedBoneSpike = 324073,
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
	--Rogue
		DeathlyShadows_Legs = "item:172318::::::::::::1:7126",
		DeathlyShadows_Waist = "item:172320::::::::::::1:7126",
		EssenceofBloodfang_Head = "item:172317::::::::::::1:7113",
		EssenceofBloodfang_Shoulder = "item:172319::::::::::::1:7113",
		InvigoratingShadowdust_Chest = "item:172314::::::::::::1:7114",
		InvigoratingShadowdust_Neck = "item:178927::::::::::::1:7114",
		MarkoftheMasterAssassin_Finger = "item:178926::::::::::::1:7111",
		MarkoftheMasterAssassin_Wrist = "item:172321::::::::::::1:7111",
		TinyToxicBlade_Feet = "item:172315::::::::::::1:7112", -- Flag for Rotation
		TinyToxicBlade_Waist = "item:172320::::::::::::1:7112",
	--Assassination
		DashingScoundrel_Back = "item:173242::::::::::::1:7115",
		DashingScoundrel_Feet = "item:172315::::::::::::1:7115",
		Doomblade_Hands = "item:172316::::::::::::1:7116",
		Doomblade_Shoulder = "item:172319::::::::::::1:7116",
		DuskwalkersPatch_Chest = "item:172314::::::::::::1:7118",
		DuskwalkersPatch_Finger = "item:178926::::::::::::1:7118",
		ZoldyckInsignia_Feet = "item:172315::::::::::::1:7117",
		ZoldyckInsignia_Legs = "item:172318::::::::::::1:7117",
	--Outlaw
		Celerity_Finger = "item:178926::::::::::::1:7121",
		Celerity_Shoulder = "item:172319::::::::::::1:7121",
		ConcealedBlunderbuss_Hands = "item:172316::::::::::::1:7122",
		ConcealedBlunderbuss_Wrist = "item:172321::::::::::::1:7122",
		GreenskinsWickers_Head = "item:172317::::::::::::1:7119",
		GreenskinsWickers_Waist = "item:172320::::::::::::1:7119",
		GuileCharm_Neck = "item:178927::::::::::::1:7120",
		GuileCharm_Wrist = "item:172321::::::::::::1:7120",
	--Subtlety
		AkaarisSoulFragment_Hands = "item:172316::::::::::::1:7124",
		AkaarisSoulFragment_Head = "item:172317::::::::::::1:7124",
		Finality_Back = "item:173242::::::::::::1:7123",
		Finality_Chest = "item:172314::::::::::::1:7123",
		TheRotten_Back = "item:173242::::::::::::1:7125",
		TheRotten_Legs = "item:172318::::::::::::1:7125",
	}
	ids.Legendary_Buff = {

	}
	ids.Legendary_Debuff = {	

	}
--Rogue
	ids.Rogue_Ability = {

	}
	ids.Rogue_Passive = {

	}
	ids.Rogue_Buff = {

	}
	ids.Rogue_Debuff = {

	}
	
--Assassination
	ids.Ass_Ability = {
	--Rogue
		Ambush = 8676,
		Blind = 2094,
		CheapShot = 1833,
		CloakofShadows = 31224,
		CrimsonVial = 185311,
		Detection = 56814,
		Distract = 1725,
		Evasion = 5277,
		Feint = 1966,
		Kick = 1766,
		KidneyShot = 408,
		PickLock = 1804,
		PickPocket = 921,
		PoisonedKnife = 185565,
		Poisons = nil,
			InstantPoison = 315584,
			DeadlyPoison = 315584,
			WoundPoison = 8679,
			CripplingPoison = 3408,
			NumbingPoison = 5761,
		Sap = 6770,
		Shiv = 5938,
		ShroudofConcealment = 114018,
		SliceandDice = 315496,
		Sprint = 2983,
		Stealth = 1784,
		TricksoftheTrade = 57934,
		Vanish = 1856,
	--Assassination
		Envenom = 32645,	
		FanofKnives = 51723,	
		Garrote = 703,
		Mutilate = 1329,
		PoisonedKnife = 185565,
		Rupture = 1943,
		Shadowstep = 36554,		
		Vendetta = 79140,
	}
	ids.Ass_Passive = {
	--Rogue
		FleetFooted = 31209,
	--Assassination
		ImprovedPoisons = 14117,
		MasteryPotentAssassin = 76803,
		SealFate = 14190,
		VenomousWounds = 79134,

	}
	ids.Ass_Talent = {
		--15
		MasterPoisoner = 196864,
		ElaboratePlanning = 193640,
		Blindside = 328085,
		--25
		Nightstalker = 14062,
		Subterfuge = 108208,
			Subterfuge_Stealth = 115191,
		MasterAssassin = 255989,
		--30
		Vigor = 14983,
		DeeperStratagem = 193531,
		MarkedforDeath = 137619,
		--35
		LeechingPoison = 280716,
		CheatDeath = 31230,
		Elusiveness = 79008,
		--40
		InternalBleeding = 154904,
		IronWire = 196861,
		PreyontheWeak = 131511,
		--45
		VenomRush = 152152,
		Alacrity = 193539,
		Exsanguinate = 200806,
		--50
		PoisonBomb = 255544,
		HiddenBlades = 270061,
		CrimsonTempest = 121411,
	}
	ids.Ass_PvPTalent = {

	}
	ids.Ass_Form = {
		Stealth = 1784,
	}
	ids.Ass_Buff = {
		Blindside = 121153,
		CrimsonTempest = 121411,
		CripplingPoison = 3408,
		DeadlyPoison = 2823,
		ElaboratePlanning = 193641,
		Envenom = 32645,
		HiddenBlades = 270070,
		InstantPoison = 315584,
		InternalBleeding = 154953,
		MasterAssassin = 256735,
		SliceandDice = 315496,
		Subterfuge = 115192,
		Vanish = 11327,		
		WoundPoison = 8679,
	}
	ids.Ass_Debuff = {
		CrimsonTempest = 121411,
		DeadlyPoison = 2818,
		Garrote = 703,
		MarkedforDeath = 137619,
		Rupture = 1943,
		ToxicBlade = 245389,		
		Vendetta = 79140,
	}
	ids.Ass_PetAbility = {
			
	}
		
--Outlaw
	ids.Out_Ability = {
	--Rogue
		Ambush = 8676,
		Blind = 2094,
		CheapShot = 1833,
		CloakofShadows = 31224,
		CrimsonVial = 185311,
		Detection = 56814,
		Distract = 1725,
		Evasion = 5277,
		Eviscerate = 196819,
		Feint = 1966,
		Kick = 1766,
		KidneyShot = 408,
		PickLock = 1804,
		PickPocket = 921,
		Poisons = 0,
			InstantPoison = 315584,
			CripplingPoison = 3408,
			WoundPoison = 8679,
			NumbingPoison = 5761,
		Sap = 6770,
		Shiv = 5938,
		ShroudofConcealment = 114018,
		SinisterStrike = 193315,
		SliceandDice = 315496,
		Sprint = 2983,
		Stealth = 1784,
		TricksoftheTrade = 57934,
		Vanish = 1856,
	--Outlaw
		AdrenalineRush = 13750,
		BetweentheEyes = 315341,
		BladeFlurry = 13877,
		Dispatch = 2098,
		Gouge = 1776,
		GrapplingHook = 195457,
		PistolShot = 185763,
		RolltheBones = 315508,
	}
	ids.Out_Passive = {
	--Rogue
		FleetFooted = 31209,
	--Outlaw
		CombatPotency = 61329,
		MasteryMainGauche = 76806,
		RestlessBlades = 79096,
		Ruthlessness = 14161,
	}
	ids.Out_Talent = {
		--15
		Weaponmaster = 200733,
		QuickDraw = 196938,
		GhostlyStrike = 196937,
		--25
		AcrobaticStrikes = 196924,
		RetractableHook = 256188,
		HitandRun = 196922,
		--30
		Vigor = 14983,
		DeeperStratagem = 193531,
		MarkedforDeath = 137619,
		--35
		IronStomach = 193546,
		CheatDeath = 31230,
		Elusiveness = 79008,
		--40
		DirtyTricks = 108216,
		BlindingPowder = 256165,
		PreyontheWeak = 131511,
		--45
		LoadedDice = 256170,
		Alacrity = 193539,
		Dreadblades = 343142,
		--50
		DancingSteel = 272026,
		BladeRush = 271877,
		KillingSpree = 51690,
	}
	ids.Out_PvPTalent = {
		Maneuverability = 197000,
		TakeYourCut = 198265,
		ControlisKing = 212217,
		DrinkUpMeHearties = 212210,
		CheapTricks = 212035,
		Dismantle = 207777,
		PlunderArmor = 198529,
		BoardingParty = 209752,
		ThickasThieves = 221622,
		TurntheTables = 198020,
		HonorAmongThieves = 198032,
		SmokeBomb = 212182,
		DeathfromAbove = 269513,
	}
	ids.Out_Form = {
	
	}
	ids.Out_Buff = {
		AdrenalineRush = 13750,
		BladeFlurry = 13877,
		Broadside = 193356,
		BuriedTreasure = 199600,
		InstantPoison = 315584,
		GrandMelee = 193358,
		LoadedDice = 256171,
		Opportunity = 195627,
		RuthlessPrecision = 193357,
		SkullandCrossbones = 199603,
		SliceandDice = 315496,
		TrueBearing = 193359,
		WoundPoison = 8679,
	}
	ids.Out_Debuff = {
		GhostlyStrike = 196937,
		MarkedforDeath = 137619,
	}
	ids.Out_PetAbility = {
		
	}

--Subtlety
	ids.Sub_Ability = {
	--Rogue
		Blind = 2094,
		CheapShot = 1833,
		CloakofShadows = 31224,
		CrimsonVial = 185311,
		Detection = 56814,
		Distract = 1725,
		Evasion = 5277,
		Eviscerate = 196819,
		Feint = 1966,
		Kick = 1766,
		KidneyShot = 408,
		PickLock = 1804,
		PickPocket = 921,
		Poisons = nil,
			InstantPoison = 315584,
			CripplingPoison = 3408,
			WoundPoison = 8679,
			NumbingPoison = 5761,
		Sap = 6770,
		Shiv = 5938,
		ShroudofConcealment = 114018,
		SliceandDice = 315496,
		Sprint = 2983,
		Stealth = 1784,
		TricksoftheTrade = 57934,
		Vanish = 1856,
	--Subtlety
		Backstab = 53,
		BlackPowder = 319175,
		Rupture = 1943,
		ShadowBlades = 121471,
		ShadowDance = 185313,
		Shadowstep = 36554,
		Shadowstrike = 185438,
		ShurikenStorm = 197835,
		ShurikenToss = 114014,
		SymbolsofDeath = 212283,
	}
	ids.Sub_Passive = {
	--Rogue
		FleetFooted = 31209,
	--Subtlety
		DeepeningShadows = 185314,
		FindWeakness = 316219,
		MasteryExecutioner = 76808,
		RelentlessStrikes = 58423,
		ShadowTechniques = 196912,
	}
	ids.Sub_Talent = {
		--15
		Weaponmaster = 193537,
		Premeditation = 343160,
		Gloomblade = 200758,
		--25
		Nightstalker = 14062,
		Subterfuge = 108208,
			Subterfuge_Stealth = 115191,
		ShadowFocus = 108209,
		--30
		Vigor = 14983,
		DeeperStratagem = 193531,
		MarkedforDeath = 137619,
		--35
		SoothingDarkness = 200759,
		CheatDeath = 31230,
		Elusiveness = 79008,
		--40
		ShotintheDark = 257505,
		NightTerrors = 277953,
		PreyontheWeak = 131511,
		--45
		DarkShadow = 245687,
		Alacrity = 193539,
		EnvelopingShadows = 238104,
		--50
		MasterofShadows = 196976,
		SecretTechnique = 280719,
		ShurikenTornado = 277925,
	}
	ids.Sub_PvPTalent = {

	}
	ids.Sub_Form = {
		Premeditation = 343173,
	}
	ids.Sub_Buff = {
		InstantPoison = 315584,
		ShadowBlades = 121471,
		ShadowDance = 185422,
		SliceandDice = 315496,
		SymbolsofDeath = 212283,
		Vanish = 11327,
		WoundPoison = 8679,
	}
	ids.Sub_Debuff = {
		FindWeakness = 91021,
		MarkedforDeath = 137619,
		Nightblade = 195452,
		Rupture = 1943,
	}
	ids.Sub_PetAbility = {
		
	}