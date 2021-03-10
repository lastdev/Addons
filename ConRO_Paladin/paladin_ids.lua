local ConRO_Paladin, ids = ...;

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
		Queen = 212641,	
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
		AshenHallow = 316958,
		BlessingoftheSeasons = nil,
			BlessingofSpring = 328282,
			BlessingofSummer = 328620,
			BlessingofAutumn = 328622,
			BlessingofWinter = 328281,
		DivineToll = 304971,
		Fleshcraft = 324631,
		Soulshape = 310143,
		SummonSteward = 324739,
			PhialofSerenity = 177278,	
		VanquishersHammer = 328204,
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
		DivineCall = 338741,
		GoldenPath = 339114,
		ResoluteDefender = 340023,
		RoyalDecree = 340030,
		ShieldingWords = 338787,
	--Finesse
		EchoingBlessings = 339316,
		LightsBarding = 339268,
		PureConcentration = 339124,
		WrenchEvil = 339292,
	--Potency
		EnkindledSpirit = 339570,
		Expurgation = 339371,
		FocusedLight = 339984,
		HallowedDiscernment = 340212,
		PunishtheGuilty = 340012,
		ResplendentLight = 339712,
		RighteousMight = 340192,
		RingingClarity = 340218,
		TemplarsVindication = 339531,
		TheLongSummer = 340185,
		TruthsWake = 339374,
		UntemperedDedication = 339987,
		VengefulShock = 340006,
		VirtuousCommand = 339518,
	}
	ids.Covenant_Buff = {
		AshenHallow = 316958,
		BlessingofSpring = 328282,
		BlessingofSummer = 328620,
		BlessingofAutumn = 328622,
		BlessingofWinter = 328281,
		VanquishersHammer = 328204,		
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
	--Paladin
		OfDuskandDawn_Head = "item:171415::::::::::::1:7055",
		OfDuskandDawn_Shoulder = "item:171417::::::::::::1:7055",
		RelentlessInquisitor_Back = "item:173242::::::::::::1:7066",
		RelentlessInquisitor_Legs = "item:171416::::::::::::1:7066",
		TheMadParagon_Feet = "item:171413::::::::::::1:7054",
		TheMadParagon_Waist = "item:171418::::::::::::1:7054",
		TheMagistratesJudgment_Finger = "item:178926::::::::::::1:7056", -- Flag for Rotation
		TheMagistratesJudgment_Wrist = "item:171419::::::::::::1:7056",
		UthersDevotion_Chest = "item:171412::::::::::::1:7053",
		UthersDevotion_Neck = "item:178927::::::::::::1:7053",
	--Holy
		InflorescenceoftheSunwell_Back = "item:173242::::::::::::1:7058",
		InflorescenceoftheSunwell_Feet = "item:171413::::::::::::1:7058",
		MaraadsDyingBreath_Chest = "item:171412::::::::::::1:7128",
		MaraadsDyingBreath_Finger = "item:178926::::::::::::1:7128",
		ShadowbreakerDawnoftheSun_Hands = "item:171414::::::::::::1:7057",
		ShadowbreakerDawnoftheSun_Shoulder = "item:171417::::::::::::1:7057",
		ShockBarrier_Feet = "item:171413::::::::::::1:7059",
		ShockBarrier_Legs = "item:171416::::::::::::1:7059",
	--Protection
		BulwarkofRighteousFury_Finger = "item:178926::::::::::::1:7062",
		BulwarkofRighteousFury_Shoulder = "item:171417::::::::::::1:7062",
		HolyAvengersEngravedSigil_Head = "item:171415::::::::::::1:7060",
		HolyAvengersEngravedSigil_Waist = "item:171418::::::::::::1:7060",
		ReignofEndlessKings_Hands = "item:171414::::::::::::1:7063",
		ReignofEndlessKings_Wrist = "item:171419::::::::::::1:7063",
		TheArdentProtectorsSanctum_Neck = "item:178927::::::::::::1:7061",
		TheArdentProtectorsSanctum_Wrist = "item:171419::::::::::::1:7061",
	--Retribution
		FinalVerdict_Back = "item:173242::::::::::::1:7064", -- Flag for Rotation
		FinalVerdict_Chest = "item:171412::::::::::::1:7064",
		TempestoftheLightbringer_Legs = "item:171416::::::::::::1:7067",
		TempestoftheLightbringer_Waist = "item:171418::::::::::::1:7067",
		VanguardsMomentum_Hands = "item:171414::::::::::::1:7065",
		VanguardsMomentum_Head = "item:171415::::::::::::1:7065",
	}
	ids.Legendary_Ability = {	
		FinalVerdict = 336872,
	}
	ids.Legendary_Buff = {
		TheMagistratesJudgment = 337682,
	}
	ids.Legendary_Debuff = {	

	}
	ids.Torghast_Powers = {
		--General
			SecretSpices = 295694,
			RingofUnburdening = 332545,
		--Paladin
			NegativeEnergyToken = 335069,
			OfDuskandDawn = 333121,
	}
	ids.Torghast_Buff = {
	
	}
	ids.Torghast_Debuff = {	

	}

--Holy
	ids.Holy_Ability = {
	--Paladin
		AvengingWrath = 31884,
		BlessingofFreedom = 1044,
		BlessingofProtection = 1022,
		BlessingofSacrifice = 6940,
		ConcentrationAura = 317920,
		Consecration = 26573,
		CrusaderAura = 32223,
		CrusaderStrike = 35395,
		DevotionAura = 465,
		DivineShield = 642,
		DivineSteed = 190784,
		FlashofLight = 19750,
		HammerofJustice = 853,
		HammerofWrath = 24275,
		HandofReckoning = 62124,
		Judgment = 275773,
		LayonHands = 633,
		Redemption = 7328,
		RetributionAura = 183435,
		SenseUndead = 5502,
		ShieldoftheRighteous = 53600,
		TurnEvil = 10326,
		WordofGlory = 85673,
	--Holy	
		Absolution = 212056,
		AuraMastery = 31821,
		BeaconofLight = 53563,
		Cleanse = 4987,
		DivineProtection = 498,
		HolyLight = 82326,
		HolyShock = 20473,
		LightofDawn = 85222,
		LightoftheMartyr = 183998,
	}
	ids.Holy_Passive = {
		InfusionofLight = 53576,
		MasteryLightbringer = 183997,
	}
	ids.Holy_Talent = {
		--15
		CrusadersMight = 196926,
		BestowFaith = 223306,
		LightsHammer = 114158,
		--25
		SavedbytheLight = 157047,
		JudgmentofLight = 183778,
		HolyPrism = 114165,		
		--30
		FistofJustice = 234299,
		Repentance = 20066,		
		BlindingLight = 115750,
		--35
		UnbreakableSpirit = 114154,
		Cavalier = 230332,
		RuleofLaw = 214202,		
		--40
		DivinePurpose = 223817,
		HolyAvenger = 105809,
		Seraphim = 152262,
		--45
		SanctifiedWrath = 53376,
		AvengingCrusader = 216331,
		Awakening = 248033,
		--50
		GlimmerofLight = 325966,
		BeaconofFaith = 156910,
		BeaconofVirtue = 200025,
	}
	ids.Holy_PvPTalent = {

	}	   
	ids.Holy_Form = {
		BeaconofFaith = 156910,
		BeaconofLight = 53563, 
		ConcentrationAura = 317920,
		Consecration = 188370,
		CrusaderAura = 32223,
		DevotionAura = 465,
		RetributionAura = 183435,
	}
	ids.Holy_Buff = {
		AvengingWrath = 31884,
		DivinePurpose = 223819,
	}
	ids.Holy_Debuff = {
		Forbearance = 25771,
		Judgment = 197277,
	}
	ids.Holy_PetAbility = {
			
	}
		
--Protection
	ids.Prot_Ability = {
	--Paladin
		AvengingWrath = 31884,
		BlessingofFreedom = 1044,
		BlessingofProtection = 1022,
		BlessingofSacrifice = 6940,
		ConcentrationAura = 317920,
		Consecration = 26573,
		CrusaderAura = 32223,
		CrusaderStrike = 35395,
		DevotionAura = 465,
		DivineShield = 642,
		DivineSteed = 190784,
		FlashofLight = 19750,
		HammerofJustice = 853,
		HammerofWrath = 24275,
		HandofReckoning = 62124,
		Judgment = 275779,
		LayonHands = 633,
		Redemption = 7328,
		RetributionAura = 183435,
		SenseUndead = 5502,
		ShieldoftheRighteous = 53600,
		TurnEvil = 10326,
		WordofGlory = 85673,
	--Protection	
		ArdentDefender = 31850,
		AvengersShield = 31935,
		CleanseToxins = 213644,
		GuardianofAncientKings = 86659,
		HammeroftheRighteous = 53595,
		Rebuke = 96231,
	}
	ids.Prot_Passive = {
		GrandCrusader = 85043,
		MasteryDivineBulwark = 76671,
		Riposte = 161800,
		ShiningLight = 321136,
	}
	ids.Prot_Talent = {
		--15
		HolyShield = 152261,
		Redoubt = 280373,
		BlessedHammer = 204019,
		--25
		FirstAvenger = 203776,
		CrusadersJudgment = 204023,
		MomentofGlory = 327193,
		--30
		FistofJustice = 234299,
		Repentance = 20066,
		BlindingLight = 115750,
		--35
		UnbreakableSpirit = 114154,
		Cavalier = 230332,
		BlessingofSpellwarding = 204018,
		--40
		DivinePurpose = 223817,
		HolyAvenger = 105809,
		Seraphim = 152262,		
		--45
		HandoftheProtector = 315924,
		ConsecratedGround = 204054,
		JudgmentofLight = 183778,
		--50
		SanctifiedWrath = 171648,
		RighteousProtector = 204074,
		FinalStand = 204077,
	}
	ids.Prot_PvPTalent = {

	}	
	ids.Prot_Form = {
		ConcentrationAura = 317920,
		Consecration = 188370,
		CrusaderAura = 32223,
		DevotionAura = 465,
		RetributionAura = 183435,
	}
	ids.Prot_Buff = {
		ArdentDefender = 31850,
		AvengersValor = 197561,
		AvengingWrath = 31884,
		DivinePurpose = 223819,
		GuardianofAncientKings = 86659,
		ShieldoftheRighteous = 132403,
		ShiningLight = 327510,
		ShiningLight_Stack = 182104,
	}
	ids.Prot_Debuff = {
		BlessedHammer = 204301,
		Forbearance = 25771,
		Judgment = 197277,
	}
	ids.Prot_PetAbility = {
		
	}

--Retribution
	ids.Ret_Ability = {
	--Paladin
		AvengingWrath = 31884,
		BlessingofFreedom = 1044,
		BlessingofProtection = 1022,
		BlessingofSacrifice = 6940,
		ConcentrationAura = 317920,
		Consecration = 26573,
		CrusaderAura = 32223,
		CrusaderStrike = 35395,
		DevotionAura = 465,
		DivineShield = 642,
		DivineSteed = 190784,
		FlashofLight = 19750,
		HammerofJustice = 853,
		HammerofWrath = 24275,
		HandofReckoning = 62124,
		Judgment = 20271,
		LayonHands = 633,
		Redemption = 7328,
		RetributionAura = 183435,
		SenseUndead = 5502,
		ShieldoftheRighteous = 53600,
		TurnEvil = 10326,
		WordofGlory = 85673,
	--Retribution	
		BladeofJustice = 184575,
		CleanseToxins = 213644,
		DivineStorm = 53385,
		HandofHindrance = 183218,
		Rebuke = 96231,
		ShieldofVengeance = 184662,
		TemplarsVerdict = 85256,
		WakeofAshes = 255937,
	}
	ids.Ret_Passive = {
		ArtofWar = 267344,
		MasteryHandofLight = 267316,
	}
	ids.Ret_Talent = {
		--15
		Zeal = 269569,
		RighteousVerdict = 267610,
		ExecutionSentence = 343527,
		--25
		FiresofJustice = 203316,
		BladeofWrath = 231832,
		EmpyreanPower = 326732,
		--30
		FistofJustice = 234299,
		Repentance = 20066,
		BlindingLight = 115750,
		--35
		UnbreakableSpirit = 114154,
		Cavalier = 230332,
		EyeforanEye = 205191,		
		--40		
		DivinePurpose = 223817,		
		HolyAvenger = 105809,
		Seraphim = 152262,
		--45
		SelflessHealer = 85804,
		JusticarsVengeance = 215661,
		HealingHands = 326734,
		--50		
		SanctifiedWrath = 317866,
		Crusade = 231895,
		FinalReckoning = 343721,
	}
	ids.Ret_PvPTalent = {
		Luminescence = 199428,
		UnboundFreedom = 305394,
		VengeanceAura = 210323,
		BlessingofSanctuary = 210256,
		UltimateRetribution = 287947,
		Lawbringer = 246806,
		DivinePunisher = 204914,
		Jurisdiction = 204979,
		LawandOrder = 204934,
		CleansingLight = 236186,
	}	
	ids.Ret_Form = {
		ConcentrationAura = 317920,
		Consecration = 188370,
		CrusaderAura = 32223,
		DevotionAura = 465,
		RetributionAura = 183435,
	}
	ids.Ret_Buff = {
		AvengingWrath = 31884,
		Crusade = 231895,
		RighteousVerdict = 267611,
		DivinePurpose = 223819,
		EmpyreanPower = 326733,
		FiresofJustice = 209785,
		SelflessHealer = 114250,
	}
	ids.Ret_Debuff = {
		Forbearance = 25771,
		Judgment = 197277,
	}
	ids.Ret_PetAbility = {
		
	}