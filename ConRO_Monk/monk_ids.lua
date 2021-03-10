local ConRO_Monk, ids = ...;

--General
	ids.Racial = {
		AncestralCall = 274738,
		ArcanePulse = 260364,
		ArcaneTorrent = 50613,
		Berserking = 26297,
		BullRush = 255654,
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
		BonedustBrew = 325216,
		FaelineStomp = 327104,
		FallenOrder = 326860,
		Fleshcraft = 324631,
		PhialofSerenity = 177278,
		Soulshape = 310143,
		SummonSteward = 324739,
		WeaponsofOrder = 310454,
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
		CelestialEffervescence = 337134,
		EvasiveStride = 337250,
		FortifyingIngredients = 336853,
		GroundingBreath = 336632,
		HarmDenial = 336379,
	--Finesse
		DizzyingTumble = 336890,
		LingeringNumbness = 336884,
		SwiftTransference = 337078,
		TumblingTechnique = 337084,
	--Potency
		BoneMarrowHops = 337295,
		CalculatedStrikes = 336526,
		CoordinatedOffensive = 336598,
		ImbuedReflections = 337301,
		InnerFury = 336452,
		JadeBond = 336773,
		NourishingChi = 337241,
		ResplendentMist = 336812,
		RisingSunRevival = 337099,
		ScaldingBrew = 337119,
		StrikewithClarity = 337286,
		WalkwiththeOx = 337264,
		WayoftheFae = 337303,
		XuensBond = 336616,
	}
	ids.Covenant_Buff = {
		BonedustBrew = 325216,		
		FaelineStomp = 327104,
		FallenOrder = 326860,
		WeaponsofOrder = 310454,		
	}
	ids.Covenant_Debuff = {	

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
	--Monk
		EscapefromReality_Chest = "item:172314::::::::::::1:7184",
		EscapefromReality_Neck = "item:178927::::::::::::1:7184",
		FatalTouch_Finger = "item:178926::::::::::::1:7081",
		FatalTouch_Wrist = "item:172321::::::::::::1:7081",
		InvokersDelight_Head = "item:172317::::::::::::1:7082",
		InvokersDelight_Shoulder = "item:172319::::::::::::1:7082",
		RollOut_Feet = "item:172315::::::::::::1:7080",
		RollOut_Waist = "item:172320::::::::::::1:7080",
	--Brewmaster
		CharredPassions_Back = "item:173242::::::::::::1:7076", -- Flag for Rotation
		CharredPassions_Feet = "item:172315::::::::::::1:7076",
		MightyPour_Feet = "item:172315::::::::::::1:7078",
		MightyPour_Legs = "item:172318::::::::::::1:7078",
		ShaohaosMight_Chest = "item:172314::::::::::::1:7079",
		ShaohaosMight_Finger = "item:178926::::::::::::1:7079",
		StormstoutsLastKeg_Hands = "item:172316::::::::::::1:7077",
		StormstoutsLastKeg_Shoulder = "item:172319::::::::::::1:7077",
	--Mistweaver
		AncientTeachingsoftheMonastery_Hands = "item:172316::::::::::::1:7075",
		AncientTeachingsoftheMonastery_Wrist = "item:172321::::::::::::1:7075",
		CloudedFocus_Neck = "item:178927::::::::::::1:7074",
		CloudedFocus_Wrist = "item:172321::::::::::::1:7074",
		TearofMorning_Head = "item:172317::::::::::::1:7072",
		TearofMorning_Waist = "item:172320::::::::::::1:7072",
		YulonsWhisper_Finger = "item:178926::::::::::::1:7073",
		YulonsWhisper_Shoulder = "item:172319::::::::::::1:7073",
	--Windwalker
		JadeIgnition_Back = "item:173242::::::::::::1:7071", -- Flag for Rotation
		JadeIgnition_Legs = "item:172318::::::::::::1:7071",
		KeefersSkyreach_Hands = "item:172316::::::::::::1:7068",
		KeefersSkyreach_Head = "item:172317::::::::::::1:7068",
		LastEmperorsCapacitor_Legs = "item:172318::::::::::::1:7069", -- Flag for Rotation
		LastEmperorsCapacitor_Waist = "item:172320::::::::::::1:7069",
		XuensBattlegear_Back = "item:173242::::::::::::1:7070",
		XuensBattlegear_Chest = "item:172314::::::::::::1:7070",
	}
	ids.Legendary_Buff = {
		CharredPassions = 338140,
		ChiEnergy = 337571,
		TheEmperorsCapacitor = 337291,
	}
	ids.Legendary_Debuff = {	

	}

--Monk
	ids.Monk_Ability = {

	}
	ids.Monk_Passive = {

	}
	ids.Monk_Buff = {

	}
	ids.Monk_Debuff = {

	}

--Brewmaster
	ids.Bm_Ability = {
	--Monk
		BlackoutKick = 205523,
		CracklingJadeLightning = 117952,
		Detox = 218164,
		ExpelHarm = 322101,
		FortifyingBrew = 115203,
		LegSweep = 119381,
		Paralysis = 115078,
		Provoke = 115546,
		Resuscitate = 115178,
		Roll = 109132,
		SpinningCraneKick = 322729,
		TigerPalm = 100780,
		TouchofDeath = 322109,
		Transcendence = 101643,
			TranscendenceTransfer = 119996,
		Vivify = 116670,
		ZenFlight = 125883,
		ZenPilgrimage = 126892,
	--Brewmaster
		BreathofFire = 115181,
		CelestialBrew = 322507,
		InvokeNiuzaotheBlackOx = 132578,
		KegSmash = 121253,
		PurifyingBrew = 119582,
		SpearHandStrike = 116705,
		ZenMeditation = 115176,
	}
	ids.Bm_Passive = {
	--Monk
		MysticTouch = 8647,
	--Brewmaster
		BrewmastersBalance = 245013,
		CelestialFortune = 216519,
		GiftoftheOx = 124502,
		MasteryElusiveBrawler = 117906,
		Shuffle = 322120,
		Stagger = 115069,
	}
	ids.Bm_Talent = {
		--15
		EyeoftheTiger = 196607,
		ChiWave = 115098,
		ChiBurst = 123986,
		--25
		Celerity = 115173,
		ChiTorpedo = 115008,
		TigersLust = 116841,
		--30
		LightBrewing = 325093,
		Spitfire = 242580,
		BlackOxBrew = 115399,
		--35
		TigerTailSweep = 264348,
		SummonBlackOxStatue = 115315,
		RingofPeace = 116844,
		--40
		BobandWeave = 280515,
		HealingElixir = 122281,
		DampenHarm = 122278,
		--45
		SpecialDelivery = 196730,
		RushingJadeWind = 116847,
		ExplodingKeg = 325153,
		--50
		HighTolerance = 196737,
		CelestialFlames = 325177,
		BlackoutCombo = 196736,
	}
	ids.Bm_PvPTalent = {

	}
	ids.Bm_Form = {
	
	}
	ids.Bm_Buff = {
		BlackoutCombo = 228563,
		ChiTorpedo = 119085,
		RushingJadeWind = 116847,
		PurifiedChi = 325092,
	}
	ids.Bm_Debuff = {
		KegSmash = 121253,
		LightStagger = 124275,
		MediumStagger = 124274,
		HighStagger = 124273,
	}
	ids.Bm_PetAbility = {

	}
		
--Mistweaver
	ids.Mw_Ability = {
	--Monk
		BlackoutKick = 100784,
		CracklingJadeLightning = 117952,
		Detox = 115450,
		ExpelHarm = 322101,
		FortifyingBrew = 243435,
		LegSweep = 119381,
		Paralysis = 115078,
		Provoke = 115078,
		Resuscitate = 115178,
		Roll = 109132,
		SpinningCraneKick = 101546,
		TigerPalm = 100780,
		TouchofDeath = 322109,
		Transcendence = 101643,
			TranscendenceTransfer = 119996,
		Vivify = 116670,
		ZenFlight = 125883,
		ZenPilgrimage = 126892,
	--Mistweaver
		EnvelopingMist = 124682,
		EssenceFont = 191837,
		InvokeYulontheJadeSerpent = 322118,
		LifeCocoon = 116849,
		Reawaken = 212051,
		RenewingMist = 115151,
		Revival = 115310,
		RisingSunKick = 107428,
		SoothingMist = 115175,
		ThunderFocusTea = 116680,
	}
	ids.Mw_Passive = {
	--Monk
		MysticTouch = 8647,
	--Mistweaver
		MasteryGustofMists = 117907,
		TeachingsoftheMonastery = 116645,
	}
	ids.Mw_Talent = {
		--15
		MistWrap = 197900,
		ChiWave = 115098,
		ChiBurst = 123986,
		--25
		Celerity = 115173,
		ChiTorpedo = 115008,
		TigersLust = 116841,
		--30
		Lifecycles = 197915,
		SpiritoftheCrane = 210802,
		ManaTea = 197908,
		--35
		TigerTailSweep = 264348,
		SongofChiJi = 198898,
		RingofPeace = 116844,
		--40
		HealingElixir = 122281,
		DiffuseMagic = 122783,
		DampenHarm = 122278,
		--45
		SummonJadeSerpentStatue = 115313,
		RefreshingJadeWind = 193725,
		InvokeChiJitheRedCrane = 325197,
		--50
		FocusedThunder = 197895,
		Upwelling = 274963,
		RisingMist = 274909,
	}
	ids.Mw_PvPTalent = {
		--Honorable Medallion
		Adaptation = 214027,
		Relentless = 196029,
		GladiatorsMedallion = 208683,
		--	
	}	
	ids.Mw_Form = {
	
	}
	ids.Mw_Buff = {
		ChiTorpedo = 119085,	
		RenewingMist = 119611,
		TeachingsoftheMonastery = 202090,
	}
	ids.Mw_Debuff = {

	}
	ids.Mw_PetAbility = {

	}

--Windwalker
	ids.Ww_Ability = {
	--Monk
		BlackoutKick = 100784,
		CracklingJadeLightning = 117952,
		Detox = 218164,
		ExpelHarm = 322101,
		FortifyingBrew = 243435,
		LegSweep = 119381,
		Paralysis = 115078,
		Provoke = 115546,
		Resuscitate = 115178,
		Roll = 109132,
		SpinningCraneKick = 101546,
		TigerPalm = 100780,
		TouchofDeath = 322109,
		Transcendence = 101643,
			TranscendenceTransfer = 119996,
		Vivify = 116670,
		ZenFlight = 125883,
		ZenPilgrimage = 126892,
	--Windwalker
		Disable = 116095,
		FistsofFury = 113656,
		FlyingSerpentKick = 101545,
			FlyingSerpentKickStop = 115057,
		InvokeXuentheWhiteTiger = 123904,
		RisingSunKick = 107428,
		SpearHandStrike = 116705,
		StormEarthandFire = 137639,
		TouchofKarma = 122470,
	}
	ids.Ww_Passive = {
	--Monk
		MysticTouch = 8647,
	--Windwalker
		Afterlife = 116092,
		MasteryComboStrikes = 115636,
		Windwalking = 157411,
	}
	ids.Ww_Talent = {
		--15
		EyeoftheTiger = 196607,
		ChiWave = 115098,
		ChiBurst = 123986,
		--25
		Celerity = 115173,
		ChiTorpedo = 115008,
		TigersLust = 116841,
		--30
		Ascension = 115396,
		FistoftheWhiteTiger = 261947,
		EnergizingElixir = 115288,
		--35
		TigerTailSweep = 264348,
		GoodKarma = 280195,
		RingofPeace = 116844,
		--40
		InnerStrength = 261767,
		DiffuseMagic = 122783,
		DampenHarm = 122278,		
		--45
		HitCombo = 196740,
		RushingJadeWind = 116847,
		DanceofChiJi = 325201,
		--50
		SpiritualFocus = 280197,
		WhirlingDragonPunch = 152175,
		Serenity = 152173,
	}
	ids.Ww_PvPTalent = {
		--Honorable Medallion
		Adaptation = 214027,
		Relentless = 196029,
		GladiatorsMedallion = 208683,
		--	
		ReverseHarm = 287771,
	}	
	ids.Ww_Form = {
		TheEmperorsCapacitor = 235054,
	}
	ids.Ww_Buff = {
		BlackoutKick = 116768,
		ChiTorpedo = 119085,
		DanceofChiJi = 325202,
		Serenity = 152173,
		StormEarthandFire = 137639,
	}
	ids.Ww_Debuff = {
		MarkoftheCrane = 228287,
	}
	ids.Ww_PetAbility = {
	
	}