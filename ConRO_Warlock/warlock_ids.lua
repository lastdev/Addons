local ConRO_Warlock, ids = ...;

--Generic
	ids.Racial = {
		AncestralCall = {spellID = 274738},
		ArcanePulse = {spellID = 260364},
		ArcaneTorrent = {spellID = 50613},
		Berserking = {spellID = 26297},
		Cannibalize = {spellID = 20577},
	}

--Warlock
	ids.Warlock_Ability = {
		DrainLife = {spellID = 234153},
		Corruption = {spellID = 172},
		CreateHealthstone = {spellID = 6201},
			Healthstone = 5512,
		CurseofWeakness = {spellID = 702},
		Fear = {spellID = 5782},
		HealthFunnel = {spellID = 755},
		ShadowBolt = {spellID = 686},
		SummonDemon = {spellID = 10},
			SummonImp = {spellID = 688},
			SummonVoidwalker = {spellID = 697},
		UnendingResolve = {spellID = 104773},
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
		AmplifyCurse = {spellID = 328774, talentID = 91442},
		Banish = {spellID = 710, talentID = 91454},
		BurningRush = {spellID = 111400, talentID = 91460},
		CommandDemon = {
			CauterizeMaster = {spellID = 119905}, --Imp
			Suffering = {spellID = 119907}, --Voidwalker
			Whiplash = {spellID = 119909}, --Succubus
			SpellLock = {spellID = 119910}, --Felhunter
			ShadowLock = {spellID = 171140}, --Doomguard
			MeteorStrike = {spellID = 171152}, --Infernal
		},
		Corruption = {spellID = 172},
		CurseofExhaustion = {spellID = 334275, talentID = 91462},
		CurseofTongues = {spellID = 1714, talentID = 91462},
		CurseofWeakness = {spellID = 702},
		DarkPact = {spellID = 108416, talentID = 91444},
		DemonicCircle = {
			Summon = {spellID = 48018, talentID = 91441},
			Teleport = {spellID = 48020, talentID = 91441},
		},
		DemonicGateway = {spellID = 111771, talentID = 91466},
		DrainLife = {spellID = 234153},
		EyeofKilrogg = {spellID = 126},
		Fear = {spellID = 5782},
		FelDomination = {spellID = 333889, talentID = 91439},
		HealthFunnel = {spellID = 755},
		Healthstone = {
			Create = {spellID = 6201},
			CreateSoulwell = {spellID = 29893},
			Use = 5512,
		},
		HowlofTerror = {spellID = 5484, talentID = 91458},
		InquisitorsGaze = {spellID = 386344, talentID = 91427},
		MortalCoil = {spellID = 6789, talentID = 91457},
		RitualofDoom = {spellID = 342601},
		RitualofSummoning = {spellID = 698},
		ShadowBolt = {spellID = 686},
		Shadowflame = {spellID = 384069, talentID = 91450},
		Shadowfury = {spellID = 30283, talentID = 91452},
		Soulburn = {spellID = 385899, talentID = 91469},
		Soulstone = {spellID = 20707},
		SubjugateDemon = {spellID = 1098},
		SummonDemon = {
			Imp = {spellID = 688},
			Voidwalker = {spellID = 697},
			Felhunter = {spellID = 691},
			Succubus = {spellID = 712},
			Felguard = {spellID = 30146},
		},
		SummonSoulkeeper = {spellID = 386256, talentID = 91448},
		UnendingBreath = {spellID = 5697},
		UnendingResolve = {spellID = 104773},
	--Affliction
		Agony = {spellID = 980},
		DrainSoul = {spellID = 198590, talentID = 91566},
		GrimoireofSacrifice = {spellID = 108503, talentID = 91576},
		Haunt = {spellID = 48181, talentID = 91552},
		MaleficRapture = {spellID = 324536, talentID = 91570},
		SeedofCorruption = {spellID = 27243, talentID = 91571},
		SiphonLife = {spellID = 63106, talentID = 91574},
		SoulRot = {spellID = 386997, talentID = 91578},
		SoulTap = {spellID = 387073, talentID = 91563},
		SoulSwap = {spellID = 386951, talentID = 91558},
		SummonDarkglare = {spellID = 205180, talentID = 91554},
		PhantomSingularity = {spellID = 205179, talentID = 91557},
		UnstableAffliction = {spellID = 316099, talentID = 91569},
		VileTaint = {spellID = 278350, talentID = 91556},
	}
	ids.Aff_Passive = {
	--Warlock
		AbyssWalker = {spellID = 389609, talentID = 91465},
		AccruedVitality = {spellID = 386613, talentID = 91464},
		DarkAccord = {spellID = 386659, talentID = 91467},
		Darkfury = {spellID = 264874, talentID = 91451},
		DemonSkin = {spellID = 219272, talentID = 91463},
		DemonicEmbrace = {spellID = 288843, talentID = 91438},
		DemonicFortitude = {spellID = 386617, talentID = 91430},
		DemonicInspiration = {spellID = 386858, talentID = 91436},
		DemonicResilience = {spellID = 389590, talentID = 91424},
		DesperatePact = {spellID = 386619, talentID = 91437},
		FelArmor = {spellID = 386124, talentID = 91461},
		FelPact = {spellID = 386113, talentID = 91440},
		FelSynergy = {spellID = 389367, talentID = 91425},
		FiendishStride = {spellID = 386110, talentID = 91459},
		FrequentDonor = {spellID = 386686, talentID = 91445},
		GrimFeast = {spellID = 386689, talentID = 91434},
		GrimoireofSynergy = {spellID = 171975, talentID = 91432},
		GorefiendsResolve = {spellID = 389623, talentID = 91422},
		GreaterBanish = {spellID = 386651, talentID = 91453},
		IchorofDevils = {spellID = 386664, talentID = 91446},
		Lifeblood = {spellID = 386646, talentID = 91449},
		Nightmare = {spellID = 386648, talentID = 91455},
		ProfaneBargain = {spellID = 389576, talentID = 91426},
		ResoluteBarrier = {spellID = 389359, talentID = 91421},
		SoulConduit = {spellID = 215941, talentID = 91431},
		SoulLeech = {spellID = 108370},
		SoulLink = {spellID = 108415, talentID = 91433},
		SoulShards = {spellID = 246985},
		StrengthofWill = {spellID = 317138, talentID = 91468},
		SweetSouls = {spellID = 386620, talentID = 91435},
		TeachingsoftheBlackHarvest = {spellID = 385881, talentID = 91447},
		TeachingsoftheSatyr = {spellID = 387972, talentID = 91443},
		WrathfulMinion = {spellID = 386864, talentID = 91456},
	--Affliction	
		AbsoluteCorruption = {spellID = 196103, talentID = 91575},
		AgonizingCorruption = {spellID = 386922, talentID = 91559},
		CreepingDeath = {spellID = 264000, talentID = 91580},
		DarkHarvest = {spellID = 387016, talentID = 91579},
		DoomBlossom = {spellID = 389764, talentID = 91503},
		DreadTouch = {spellID = 389775, talentID = 91420},
		InevitableDemise = {spellID = 334319, talentID = 91567},
		GrandWarlocksDesign = {spellID = 387084, talentID = 91505},
		GrimReach = {spellID = 389992, talentID = 91419},
		HarvesterofSouls = {spellID = 201424, talentID = 91564},
		HauntedSoul = {spellID = 387301, talentID = 91506},
		Nightfall = {spellID = 108558, talentID = 91568},
		MaleficAffliction = {spellID = 389761, talentID = 91429},
		MalevolentVisionary = {spellID = 387273, talentID = 91504},
		MasteryPotentAfflictions = 77215,
		PandemicInvocation = {spellID = 386759, talentID = 91573},
		SacrolashsDarkStrike = {spellID = 386986, talentID = 91555},
		SeizedVitality = {spellID = 387250, talentID = 91507},
		ShadowEmbrace = {spellID = 32388, talentID = 91565},
		SoulEatersGluttony = {spellID = 389630, talentID = 91428},
		SoulFlame = {spellID = 199471, talentID = 91562},
		SowtheSeeds = {spellID = 196226, talentID = 91560},
		TormentedCrescendo = {spellID = 387075, talentID = 91551},
		WitheringBolt = {spellID = 386976, talentID = 91577},
		WrathofConsumption = {spellID = 387065, talentID = 91553},
		WritheinAgony = {spellID = 196102, talentID = 91561},
		XavianTeachings = {spellID = 317031, talentID = 91572},
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
		CauterizeMaster = {spellID = 119899}, --Imp
		Suffering = {spellID = 17735}, --Voidwalker
		Whiplash = {spellID = 6360}, --Succubus
		SpellLock = {spellID = 19647}, --Felhunter
		DevourMagic = {spellID = 19505}, --Felhunter
		MeteorStrike = {spellID = 171017}, --Infernal	
		ThreateningPresence = {spellID = 112042}, -- Voidwalker
		Felstorm = {spellID = 89751}, -- Felguard
		AxeToss = {spellID = 89766},
	}
		
--Demonology
	ids.Demo_Ability = {
	--Warlock
		AmplifyCurse = {spellID = 328774, talentID = 91442},
		Banish = {spellID = 710, talentID = 91454},
		BurningRush = {spellID = 111400, talentID = 91460},
		CommandDemon = {
			SingeMagic = {spellID = 119905}, --Imp
			Suffering = {spellID = 119907}, --Voidwalker
			Whiplash = {spellID = 119909}, --Succubus
			SpellLock = {spellID = 119910}, --Felhunter
			ShadowLock = {spellID = 171140}, --Doomguard
			MeteorStrike = {spellID = 171152}, --Infernal
		},
		Corruption = {spellID = 172},
		CurseofExhaustion = {spellID = 334275, talentID = 91462},
		CurseofTongues = {spellID = 1714, talentID = 91462},
		CurseofWeakness = {spellID = 702},
		DarkPact = {spellID = 108416, talentID = 91444},
		DemonicCircle = {
			Summon = {spellID = 48018, talentID = 91441},
			Teleport = {spellID = 48020, talentID = 91441},
		},
		DemonicGateway = {spellID = 111771, talentID = 91466},
		DrainLife = {spellID = 234153},
		EyeofKilrogg = {spellID = 126},
		Fear = {spellID = 5782},
		FelDomination = {spellID = 333889, talentID = 91439},
		HealthFunnel = {spellID = 755},
		Healthstone = {
			Create = {spellID = 6201},
			CreateSoulwell = {spellID = 29893},
			Use = 5512,
		},
		HowlofTerror = {spellID = 5484, talentID = 91458},
		InquisitorsGaze = {spellID = 386344, talentID = 91427},
		MortalCoil = {spellID = 6789, talentID = 91457},
		RitualofDoom = {spellID = 342601},
		RitualofSummoning = {spellID = 698},
		ShadowBolt = {spellID = 686},
		Shadowflame = {spellID = 384069, talentID = 91450},
		Shadowfury = {spellID = 30283, talentID = 91452},
		Soulburn = {spellID = 385899, talentID = 91469},
		Soulstone = {spellID = 20707},
		SubjugateDemon = {spellID = 1098},
		SummonDemon = {
			Imp = {spellID = 688},
			Voidwalker = {spellID = 697},
			Felhunter = {spellID = 691},
			Succubus = {spellID = 712},
			Felguard = {spellID = 30146},
		},
		SummonSoulkeeper = {spellID = 386256, talentID = 91448},
		UnendingBreath = {spellID = 5697},
		UnendingResolve = {spellID = 104773},
	--Demonology
		BilescourgeBombers = {spellID = 267211, talentID = 91541},
		CallDreadstalkers = {spellID = 104316, talentID = 91543},
		Demonbolt = {spellID = 264178, talentID = 91544},
		DemonicStrength = {spellID = 267171, talentID = 91540},
		Doom = {spellID = 603, talentID = 91548},
		GrimoireFelguard = {spellID = 111898, talentID = 91531},
		Guillotine = {spellID = 386833, talentID = 91523},
		HandofGuldan = {spellID = 105174},
		Implosion = {spellID = 196277, talentID = 91520},
		NetherPortal = {spellID = 267217, talentID = 91515},
		PowerSiphon = {spellID = 264130, talentID = 91521},
		SoulStrike = {spellID = 264057, talentID = 91537},
		SummonDemonicTyrant = {spellID = 265187, talentID = 91550},
		SummonVilefiend = {spellID = 264119, talentID = 91538},
	}
	ids.Demo_Passive = {
	--Warlock
		AbyssWalker = {spellID = 389609, talentID = 91465},
		AccruedVitality = {spellID = 386613, talentID = 91464},
		DarkAccord = {spellID = 386659, talentID = 91467},
		Darkfury = {spellID = 264874, talentID = 91451},
		DemonSkin = {spellID = 219272, talentID = 91463},
		DemonicEmbrace = {spellID = 288843, talentID = 91438},
		DemonicFortitude = {spellID = 386617, talentID = 91430},
		DemonicInspiration = {spellID = 386858, talentID = 91436},
		DemonicResilience = {spellID = 389590, talentID = 91424},
		DesperatePact = {spellID = 386619, talentID = 91437},
		FelArmor = {spellID = 386124, talentID = 91461},
		FelPact = {spellID = 386113, talentID = 91440},
		FelSynergy = {spellID = 389367, talentID = 91425},
		FiendishStride = {spellID = 386110, talentID = 91459},
		FrequentDonor = {spellID = 386686, talentID = 91445},
		GrimFeast = {spellID = 386689, talentID = 91434},
		GrimoireofSynergy = {spellID = 171975, talentID = 91432},
		GorefiendsResolve = {spellID = 389623, talentID = 91422},
		GreaterBanish = {spellID = 386651, talentID = 91453},
		IchorofDevils = {spellID = 386664, talentID = 91446},
		Lifeblood = {spellID = 386646, talentID = 91449},
		Nightmare = {spellID = 386648, talentID = 91455},
		ProfaneBargain = {spellID = 389576, talentID = 91426},
		ResoluteBarrier = {spellID = 389359, talentID = 91421},
		SoulConduit = {spellID = 215941, talentID = 91431},
		SoulLeech = {spellID = 108370},
		SoulLink = {spellID = 108415, talentID = 91433},
		SoulShards = {spellID = 246985},
		StrengthofWill = {spellID = 317138, talentID = 91468},
		SweetSouls = {spellID = 386620, talentID = 91435},
		TeachingsoftheBlackHarvest = {spellID = 385881, talentID = 91447},
		TeachingsoftheSatyr = {spellID = 387972, talentID = 91443},
		WrathfulMinion = {spellID = 386864, talentID = 91456},
	--Demonology	
		AnnihilanTraining = {spellID = 386174, talentID = 91542},
		AntoranArmaments = {spellID = 387494, talentID = 91526},
		BloodboundImps = {spellID = 387349, talentID = 91519},
		CarnivorousStalkers = {spellID = 386194, talentID = 91536},
		DemonicCalling = {spellID = 205145, talentID = 91535},
		DemonicCore = 267102,
		DemonicKnowledge = {spellID = 386185, talentID = 91546},
		DemonicMeteor = {spellID = 387396, talentID = 91530},
		DreadCalling = {spellID = 387391, talentID = 91517},
		Dreadlash = {spellID = 264078, talentID = 91539},
		FelandSteel = {spellID = 386200, talentID = 91534},
		FelCovenant = {spellID = 387432, talentID = 91518},
		FelMight = {spellID = 387338, talentID = 91532},
		FelSunder = {spellID = 387399, talentID = 91528},
		FromtheShadows = {spellID = 267170, talentID = 91533},
		GrandWarlocksDesign = {spellID = 387084, talentID = 91508},
		GuldansAmbition = {spellID = 387578, talentID = 91513},
		HoundsofWar = {spellID = 387488, talentID = 91529},
		ImpGangBoss = {spellID = 387445, talentID = 91516},
		InfernalCommand = {spellID = 387549, talentID = 91524},
		InnerDemons = {spellID = 267216, talentID = 96549},
		KazaaksFinalCurse = {spellID = 387483, talentID = 91549},
		MasteryMasterDemonologist = 77219,
		NerzhulsVolition = {spellID = 387526, talentID = 91514},
		PactoftheImpMother = {spellID = 387541, talentID = 91522},
		ReignofTyranny = {spellID = 390173, talentID = 91509},
		RippedthroughthePortal = {spellID = 387485, talentID = 91527},
		SacrificedSouls = {spellID = 267214, talentID = 91511},
		ShadowsBite = {spellID = 387322, talentID = 91545},
		SoulboundTyrant = {spellID = 334585, talentID = 91510},
		StolenPower = {spellID = 387602, talentID = 91525},
		TheExpendables = {spellID = 387600, talentID = 91512},
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
		CauterizeMaster = {spellID = 119899}, --Imp
		Suffering = {spellID = 17735}, --Voidwalker
		Whiplash = {spellID = 6360}, --Succubus
		ShadowBite = {spellID = 54049},
		SpellLock = {spellID = 19647}, --Felhunter
		DevourMagic = {spellID = 19505}, --Felhunter
		MeteorStrike = {spellID = 171017}, --Infernal	
		ThreateningPresence = {spellID = 112042}, -- Voidwalker
		Felstorm = {spellID = 89751}, -- Felguard
		AxeToss = {spellID = 89766},
	}
	
--Destruction
	ids.Dest_Ability = {
	--Warlock
		AmplifyCurse = {spellID = 328774, talentID = 91442},
		Banish = {spellID = 710, talentID = 91454},
		BurningRush = {spellID = 111400, talentID = 91460},
		CommandDemon = {
			CauterizeMaster = {spellID = 119905}, --Imp
			Suffering = {spellID = 119907}, --Voidwalker
			Whiplash = {spellID = 119909}, --Succubus
			SpellLock = {spellID = 119910}, --Felhunter
			ShadowLock = {spellID = 171140}, --Doomguard
			MeteorStrike = {spellID = 171152}, --Infernal
		},
		Corruption = {spellID = 172},
		CurseofExhaustion = {spellID = 334275, talentID = 91462},
		CurseofTongues = {spellID = 1714, talentID = 91462},
		CurseofWeakness = {spellID = 702},
		DarkPact = {spellID = 108416, talentID = 91444},
		DemonicCircle = {
			Summon = {spellID = 48018, talentID = 91441},
			Teleport = {spellID = 48020, talentID = 91441},
		},
		DemonicGateway = {spellID = 111771, talentID = 91466},
		DrainLife = {spellID = 234153},
		EyeofKilrogg = {spellID = 126},
		Fear = {spellID = 5782},
		FelDomination = {spellID = 333889, talentID = 91439},
		HealthFunnel = {spellID = 755},
		Healthstone = {
			Create = {spellID = 6201},
			CreateSoulwell = {spellID = 29893},
			Use = 5512,
		},
		HowlofTerror = {spellID = 5484, talentID = 91458},
		InquisitorsGaze = {spellID = 386344, talentID = 91427},
		MortalCoil = {spellID = 6789, talentID = 91457},
		RitualofDoom = {spellID = 342601},
		RitualofSummoning = {spellID = 698},
		ShadowBolt = {spellID = 686},
		Shadowflame = {spellID = 384069, talentID = 91450},
		Shadowfury = {spellID = 30283, talentID = 91452},
		Soulburn = {spellID = 385899, talentID = 91469},
		Soulstone = {spellID = 20707},
		SubjugateDemon = {spellID = 1098},
		SummonDemon = {
			Imp = {spellID = 688},
			Voidwalker = {spellID = 697},
			Felhunter = {spellID = 691},
			Succubus = {spellID = 712},
			Felguard = {spellID = 30146},
		},
		SummonSoulkeeper = {spellID = 386256, talentID = 91448},
		UnendingBreath = {spellID = 5697},
		UnendingResolve = {spellID = 104773},
	--Destruction
		Cataclysm = {spellID = 152108, talentID = 91487},
		ChannelDemonfire = {spellID = 196447, talentID = 91586},
		ChaosBolt = {spellID = 116858, talentID = 91591},
		Conflagrate = {spellID = 17962, talentID = 91590},
		DimensionalRift = {spellID = 387976, talentID = 91423},
		GrimoireofSacrifice = {spellID = 108503, talentID = 91484},
		Havoc = {spellID = 80240, talentID = 91493},
		Immolate = {spellID = 348},
		Incinerate = {spellID = 29722},
		RainofFire = {spellID = 5740, talentID = 91592},
		Shadowburn = {spellID = 17877, talentID = 91582},
		SoulFire = {spellID = 6353, talentID = 91492},
		SummonInfernal = {spellID = 1122, talentID = 91502},
	}
	ids.Dest_Passive = {
	--Warlock
		AbyssWalker = {spellID = 389609, talentID = 91465},
		AccruedVitality = {spellID = 386613, talentID = 91464},
		DarkAccord = {spellID = 386659, talentID = 91467},
		Darkfury = {spellID = 264874, talentID = 91451},
		DemonSkin = {spellID = 219272, talentID = 91463},
		DemonicEmbrace = {spellID = 288843, talentID = 91438},
		DemonicFortitude = {spellID = 386617, talentID = 91430},
		DemonicInspiration = {spellID = 386858, talentID = 91436},
		DemonicResilience = {spellID = 389590, talentID = 91424},
		DesperatePact = {spellID = 386619, talentID = 91437},
		FelArmor = {spellID = 386124, talentID = 91461},
		FelPact = {spellID = 386113, talentID = 91440},
		FelSynergy = {spellID = 389367, talentID = 91425},
		FiendishStride = {spellID = 386110, talentID = 91459},
		FrequentDonor = {spellID = 386686, talentID = 91445},
		GrimFeast = {spellID = 386689, talentID = 91434},
		GrimoireofSynergy = {spellID = 171975, talentID = 91432},
		GorefiendsResolve = {spellID = 389623, talentID = 91422},
		GreaterBanish = {spellID = 386651, talentID = 91453},
		IchorofDevils = {spellID = 386664, talentID = 91446},
		Lifeblood = {spellID = 386646, talentID = 91449},
		Nightmare = {spellID = 386648, talentID = 91455},
		ProfaneBargain = {spellID = 389576, talentID = 91426},
		ResoluteBarrier = {spellID = 389359, talentID = 91421},
		SoulConduit = {spellID = 215941, talentID = 91431},
		SoulLeech = {spellID = 108370},
		SoulLink = {spellID = 108415, talentID = 91433},
		SoulShards = {spellID = 246985},
		StrengthofWill = {spellID = 317138, talentID = 91468},
		SweetSouls = {spellID = 386620, talentID = 91435},
		TeachingsoftheBlackHarvest = {spellID = 385881, talentID = 91447},
		TeachingsoftheSatyr = {spellID = 387972, talentID = 91443},
		WrathfulMinion = {spellID = 386864, talentID = 91456},
	--Destruction	
		AshenRemains = {spellID = 387252, talentID = 91482},
		AvatarofDestruction = {spellID = 387159, talentID = 91476},
		Backdraft = {spellID = 196406, talentID = 91589},
		Backlash = {spellID = 387384, talentID = 91500},
		BurntoAshes = {spellID = 387153, talentID = 91477},
		ChaosIncarnate = {spellID = 387275, talentID = 91479},
		ConflagrationofChaos = {spellID = 387108, talentID = 91583},
		CrashingChaos = {spellID = 387355, talentID = 91473},
		CryHavoc = {spellID = 387522, talentID = 91497},
		Decimation = {spellID = 387176, talentID = 91491},
		DiabolicEmbers = {spellID = 387173, talentID = 91481},
		Eradication = {spellID = 196412, talentID = 91501},
		ExplosivePotential = {spellID = 388827, talentID = 91581},
		FireandBrimstone = {spellID = 196408, talentID = 91499},
		Flashpoint = {spellID = 387259, talentID = 91485},
		GrandWarlocksDesign = {spellID = 387084, talentID = 91471},
		ImprovedConflagrate = {spellID = 231793, talentID = 91587},
		ImprovedImmolate = {spellID = 387093, talentID = 91490},
		InfernalBrand = {spellID = 387475, talentID = 91470},
		Inferno = {spellID = 270545, talentID = 91488},
		InternalCombustion = {spellID = 266134, talentID = 91495},
		MadnessoftheAzjAqir = {spellID = 387400, talentID = 91480},
		MasterRitualist = {spellID = 387165, talentID = 91475},
		MasteryChaoticEnergies = {spellID = 77220},
		Mayhem = {spellID = 387506, talentID = 91494},
		Pandemonium = {spellID = 387509, talentID = 91498},
		PowerOverwhelming = {spellID = 387279, talentID = 91478},
		Pyrogenics = {spellID = 387095, talentID = 91489},
		RainofChaos = {spellID = 266086, talentID = 91472},
		RagingDemonfire = {spellID = 387166, talentID = 91585},
		ReverseEntropy = {spellID = 205148, talentID = 91496},
		RitualofRuin = {spellID = 387156, talentID = 91483},
		RoaringBlaze = {spellID = 205184, talentID = 91588},
		RollingHavoc = {spellID = 387569, talentID = 91474},
		Ruin = {spellID = 387103, talentID = 91584},
		ScaldingFlames = {spellID = 388832, talentID = 91486},
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
		CauterizeMaster = {spellID = 119899}, --Imp
		Suffering = {spellID = 17735}, --Voidwalker
		Whiplash = {spellID = 6360}, --Succubus
		ShadowBite = {spellID = 54049},
		SpellLock = {spellID = 19647}, --Felhunter
		DevourMagic = {spellID = 19505}, --Felhunter
		MeteorStrike = {spellID = 171017}, --Infernal	
		ThreateningPresence = {spellID = 112042}, -- Voidwalker
		Felstorm = {spellID = 89751}, -- Felguard
		AxeToss = {spellID = 89766},
	}
