local ConRO_Warlock, ids = ...;

--Generic
	ids.Racial = {
		ArcaneTorrent = 28730,
		Berserking = 26297,
	}
	ids.AzTrait = {
		BalefulInvocation = 287059,
		ExplosivePotential = 275395,
		InevitableDemise = 273521,
	}
	ids.AzTraitBuff = {
		ExplosivePotential = 275398,
		ForbiddenKnowledge = 278738,
		InevitableDemise = 273525,
		ShadowsBite = 272944,
	}
	ids.AzEssence = {
		BloodoftheEnemy = 298273,
		ConcentratedFlame = 295373,
		FocusedAzeriteBeam =295258,		
		GuardianofAzeroth = 299358,
		MemoryofLucidDream = 298357,
		TheUnboundForce = 298452,
		WorldveinResonance = 295186,	
	}

--Affliction
	ids.Aff_Ability = {
	--Warlock
		Banish = 710,
		CommandDemon = 119898,
			CauterizeMaster = 119905, --Imp
			Suffering = 119907, --Voidwalker
			Whiplash = 119909, --Succubus
			SpellLock = 119910, --Felhunter
			ShadowLock = 171140, --Doomguard
			MeteorStrike = 171152, --Infernal
		Corruption = 172,
		CreateHealthstone = 6201,
		CreateSoulwell = 29893,
		CurseofExhaustion = 334275,
		CurseofTongues = 1714,
		CurseofWeakness = 702,
		DemonicCircleSummon = 48018,
			DemonicCircleTeleport = 48020,
		DemonicGateway = 111771,
		DrainLife = 234153,
		EyeofKilrogg = 126,
		Fear = 5782,
		FelDomination = 333889,
		HealthFunnel = 755,
		RitualofDoom = 342601,
		RitualofSummoning = 698,
		ShadowBolt = 686,
		Shadowfury = 30283,
		Soulstone = 20707,
		SubjugateDemon = 1098,
		SummonDemon = 10,
			SummonImp = 688,
			SummonVoidwalker = 697,
			SummonFelhunter = 691,
			SummonSuccubus = 712,
			SummonFelguard = 30146,
		UnendingBreath = 5697,
		UnendingResolve = 104773,
	--Affliction
		Agony = 980,
		MaleficRapture = 324536,
		SeedofCorruption = 27243,
		ShadowEmbrace = 32388,
		SummonDarkglare = 205180,
		UnstableAffliction = 316099,
	}
	ids.Aff_Passive = {
	--Warlock
		DemonicEmbrace = 288843,
		SoulLeech = 108370,
		SoulShards = 246985,
	--Affliction	
		MasteryPotentAfflictions = 77215,
	}
	ids.Aff_Talent = {
		--15
		Nightfall = 108558,
		InevitableDemise = 334319,
		DrainSoul = 198590,
		--25
		WritheinAgony = 196102,
		AbsoluteCorruption = 196103,
		SiphonLife = 63106,
		--30
		DemonSkin = 219272,
		BurningRush = 111400,
		DarkPact = 108416,
		--35
		SowtheSeeds = 196226,
		PhantomSingularity = 205179,
		VileTaint = 278350,
		--40
		Darkfury = 264874,
		MortalCoil = 6789,
		HowlofTerror = 5484,
		--45
		DarkCaller = 334183,
		Haunt = 48181,
		GrimoireofSacrifice = 108503,
		--50
		SoulConduit = 215941,
		CreepingDeath = 264000,
		DarkSoulMisery = 113860,
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
			UnstableAfflictionRA = 342938, 
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
		SiphonLife = 63106,
		UnstableAffliction = 316099,
		UnstableAfflictionRA = 342938,
		VileTaint = 278350,
	}
	ids.Aff_PetAbility = {
		CauterizeMaster = 119899, --Imp
		Suffering = 17735, --Voidwalker
		Whiplash = 6360, --Succubus
		SpellLock = 19647, --Felhunter
		DevourMagic = 19505, --Felhunter
		OpticalBlast = 115781, --Observer
		MeteorStrike = 171017, --Infernal	
		ThreateningPresence = 112042, -- Voidwalker
		Felstorm = 89751, -- Felguard
		AxeToss = 89766,
	}
		
--Demonology
	ids.Demo_Ability = {
	--Warlock
		Banish = 710,
		CommandDemon = 119898,
			CauterizeMaster = 119905, --Imp
			Suffering = 119907, --Voidwalker
			Whiplash = 119909, --Succubus
			SpellLock = 119910, --Felhunter
			ShadowLock = 171140, --Doomguard
			MeteorStrike = 171152, --Infernal
		Corruption = 172,
		CreateHealthstone = 6201,
		CreateSoulwell = 29893,
		CurseofExhaustion = 334275,
		CurseofTongues = 1714,
		CurseofWeakness = 702,
		DemonicCircleSummon = 48018,
			DemonicCircleTeleport = 48020,
		DemonicGateway = 111771,
		DrainLife = 234153,
		EyeofKilrogg = 126,
		Fear = 5782,
		FelDomination = 333889,
		HealthFunnel = 755,
		RitualofDoom = 342601,
		RitualofSummoning = 698,
		ShadowBolt = 686,
		Shadowfury = 30283,
		Soulstone = 20707,
		SubjugateDemon = 1098,
		SummonDemon = 10,
			SummonImp = 688,
			SummonVoidwalker = 697,
			SummonFelhunter = 691,
			SummonSuccubus = 712,
			SummonFelguard = 30146,
		UnendingBreath = 5697,
		UnendingResolve = 104773,
	--Demonology
		CallDreadstalkers = 104316,
		Demonbolt = 264178,
		HandofGuldan = 105174,
		Implosion = 196277,
		SummonDemonicTyrant = 265187,
	}
	ids.Demo_Passive = {
	--Warlock
		DemonicEmbrace = 288843,
		SoulLeech = 108370,
		SoulShards = 246985,
	--Demonology	
		DemonicCore = 267102,
		MasteryMasterDemonologist = 77219,
		SoulLink = 108415,
	}
	ids.Demo_Talent = {
		--15
		Dreadlash = 264078,
		BilescourgeBombers = 267211,
		DemonicStrength = 267171,
		--25
		DemonicCalling = 205145,
		PowerSiphon = 264130,
		Doom = 603,
		--30
		DemonSkin = 219272,
		BurningRush = 111400,
		DarkPact = 108416,
		--35
		FromtheShadows = 267170,
		SoulStrike = 264057,
		SummonVilefiend = 264119,
		--40
		Darkfury = 264874,		
		MortalCoil = 6789,		
		HowlofTerror = 5484,
		--45
		SoulConduit = 215941,
		InnerDemons = 267216,
		GrimoireFelguard = 111898,
		--50
		SacrificedSouls = 267214,
		DemonicConsumption = 267215,
		NetherPortal = 267217,
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
		CauterizeMaster = 119899, --Imp
		Suffering = 17735, --Voidwalker
		Whiplash = 6360, --Succubus
		SpellLock = 19647, --Felhunter
		DevourMagic = 19505, --Felhunter
		OpticalBlast = 115781, --Observer
		MeteorStrike = 171017, --Infernal	
		ThreateningPresence = 112042, -- Voidwalker
		Felstorm = 89751, -- Felguard
		AxeToss = 89766,
	}
	
--Destruction
	ids.Dest_Ability = {
	--Warlock
		Banish = 710,
		CommandDemon = 119898,
			CauterizeMaster = 119905, --Imp
			Suffering = 119907, --Voidwalker
			Whiplash = 119909, --Succubus
			SpellLock = 119910, --Felhunter
			ShadowLock = 171140, --Doomguard
			MeteorStrike = 171152, --Infernal
		Corruption = 172,
		CreateHealthstone = 6201,
		CreateSoulwell = 29893,
		CurseofExhaustion = 334275,
		CurseofTongues = 1714,
		CurseofWeakness = 702,
		DemonicCircleSummon = 48018,
			DemonicCircleTeleport = 48020,
		DemonicGateway = 111771,
		DrainLife = 234153,
		EyeofKilrogg = 126,
		Fear = 5782,
		FelDomination = 333889,
		HealthFunnel = 755,
		RitualofDoom = 342601,
		RitualofSummoning = 698,
		Shadowfury = 30283,
		Soulstone = 20707,
		SubjugateDemon = 1098,
		SummonDemon = 10,
			SummonImp = 688,
			SummonVoidwalker = 697,
			SummonFelhunter = 691,
			SummonSuccubus = 712,
			SummonFelguard = 30146,
		UnendingBreath = 5697,
		UnendingResolve = 104773,
	--Destruction
		ChaosBolt = 116858,
		Conflagrate = 17962,
		Havoc = 80240,
		Immolate = 348,
		Incinerate = 29722,
		RainofFire = 5740,
		SummonInfernal = 1122,
	}
	ids.Dest_Passive = {
	--Warlock
		DemonicEmbrace = 288843,
		SoulLeech = 108370,
		SoulShards = 246985,
	--Destruction	
		Backdraft = 196406,
		MasteryChaoticEnergies = 77220,
	}
	ids.Dest_Talent = {
		--15
		Flashover = 267115,
		Eradication = 196412,
		SoulFire = 6353,
		--25
		ReverseEntropy = 205148,
		InternalCombustion = 266134,
		Shadowburn = 17877,
		--30
		DemonSkin = 219272,
		BurningRush = 111400,
		DarkPact = 108416,
		--35
		Inferno = 270545,
		FireandBrimstone = 196408,		
		Cataclysm = 152108,
		--40
		Darkfury = 264874,
		MortalCoil = 6789,
		HowlofTerror = 5484,
		--45
		RoaringBlaze = 205184,
		RainofChaos = 266086,
		GrimoireofSacrifice = 108503,
		--50
		SoulConduit = 215941,
		ChannelDemonfire = 196447,
		DarkSoulInstability = 113858,
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
		Corruption = 146739,
		Eradication = 196414,
		Havoc = 80240,
		Immolate = 157736,
	}
	ids.Dest_PetAbility = {
		CauterizeMaster = 119899, --Imp
		Suffering = 17735, --Voidwalker
		Whiplash = 6360, --Succubus
		SpellLock = 19647, --Felhunter
		DevourMagic = 19505, --Felhunter
		OpticalBlast = 115781, --Observer
		MeteorStrike = 171017, --Infernal	
		ThreateningPresence = 112042, -- Voidwalker
		Felstorm = 89751, -- Felguard
		AxeToss = 89766,
	}