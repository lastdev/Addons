local ConRO_Evoker, ids = ...;

--General
	ids.Racial = {
		TailSwipe = {spellID = 368970},
		WingBuffet = {spellID = 357214},
	}

--Evoker
	ids.Evoker_Ability = {

	}
	ids.Evoker_Passive = {

	}
	ids.Evoker_Buff = {

	}
	ids.Evoker_Debuff = {

	}

--Devastation
	ids.Dev_Ability = {
	--Evoker
		AzureStrike = {spellID = 362969},
		BlessingoftheBronze = {spellID = 364342},
		CauterizingFlame = {spellID = 374251, talentID = 87700},
		DeepBreath = {spellID = 357210},
		Disintegrate = {spellID = 356995},
		EmeraldBlossom = {spellID = 355913},
		Expunge = {spellID = 365585, talentID = 87716},
		FireBreath = {spellID = 357208},
		FuryoftheAspects = {spellID = 390386},
		Hover = {spellID = 358267},
		Landslide = {spellID = 358385, talentID = 87708},
		LivingFlame = {spellID = 361469},
		ObsidianScales = {spellID = 363916, talentID = 87702},
		OppressingRoar = {spellID = 372048, talentID = 87695},
		Quell = {spellID = 351338, talentID = 87692},
		RenewingBlaze = {spellID = 374348, talentID = 87679},
		Rescue = {spellID = 370665, talentID = 87685},
		Return = {spellID = 361227},
		SleepWalk = {spellID = 360806, talentID = 87587},
		SourceofMagic = {spellID = 369459, talentID = 87696},
		TimeSpiral = {spellID = 374968, talentID = 87676},
		TiptheScales = {spellID = 370553, talentID = 87713},
		Unravel = {spellID = 368432, talentID = 87690},
		VerdantEmbrace = {spellID = 360995, talentID = 87716},
		Zephyr = {spellID = 374227, talentID = 87682},
	--Devastation
		Dragonrage = {spellID = 375087, talentID = 87665},
		EternitySurge = {spellID = 359073, talentID = 87647},
		Firestorm = {spellID = 368847, talentID = 87659},
		Pyre = {spellID = 357211, talentID = 87669},
		ShatteringStar = {spellID = 370452, talentID = 87641},
	}
	ids.Dev_Passive = {
	--Evoker
		AerialMastery = {spellID = 365933, talentID = 87686},
		AncientFlame = {spellID = 369990, talentID = 87698},
		AttunedtotheDream = {spellID = 376930, talentID = 87699},
		BlastFurnace = {spellID = 375510, talentID = 87694},
		BountifulBloom = {spellID = 370886, talentID = 87588},
		ClobberingSweep = {spellID = 375443, talentID = 87585},
		DraconicLegacy = {spellID = 376166, talentID = 87712},
		Enkindled = {spellID = 375554, talentID = 87704},
		ExtendedFlight = {spellID = 375517, talentID = 87706},
		Exuberance = {spellID = 375542, talentID = 87589},
		FireWithin = {spellID = 375577, talentID = 87680},
		FociofLife = {spellID = 375574, talentID = 87681},
		ForgerofMountains = {spellID = 376628, talentID = 87584},
		HeavyWingbeats = {spellID = 368838, talentID = 87586},
		InherentResistance = {spellID = 375544, talentID = 87697},
		InnateMagic = {spellID = 375520, talentID = 87710},
		InstinctiveArcana = {spellID = 376164, talentID = 87693},
		LeapingFlames = {spellID = 369939, talentID = 87689},
		LushGrowth = {spellID = 375561, talentID = 87678},
		NaturalConvergance = {spellID = 369913, talentID = 87709},
		ObsidianBulwark = {spellID = 375406, talentID = 87701},
		Overawe = {spellID = 374346, talentID = 87687},
		Panacea = {spellID = 387761, talentID = 87707},
		PermeatingChill = {spellID = 370897, talentID = 87703},
		ProtractedTalons = {spellID = 369909, talentID = 87688},
		Recall = {spellID = 371806, talentID = 87711},
		RegenerativeMagic = {spellID = 387787, talentID = 87677},
		RoarofExhilaration = {spellID = 375507, talentID = 87691},
		ScarletAdaptation = {spellID = 372469, talentID = 87714},
		Tailwind = {spellID = 375556, talentID = 87705},
		TemperedScales = {spellID = 396571},
		TerroroftheSkies = {spellID = 371032, talentID = 87675},
		TwinGuardian = {spellID = 370888, talentID = 87683},
		WallopingBlow = {spellID = 387341, talentID = 87684},
	--Devastation
		Animosity = {spellID = 375797, talentID = 87664},
		ArcaneIntensity = {spellID = 375618, talentID = 87646},
		ArcaneVigor = {spellID = 386342, talentID = 87642},
		AzureEssenceBurst = {spellID = 375721, talentID = 87668},
		Burnout = {spellID = 375801, talentID = 87657},
		Catalyze = {spellID = 386283, talentID = 87660},
		Causality = {spellID = 375777, talentID = 87639},
		ChargedBlast = {spellID = 370455, talentID = 87651},
		DenseEnergy = {spellID = 370962, talentID = 87671},
		EngulfingBlaze = {spellID = 370837, talentID = 87673},
		EssenceAttunement = {spellID = 375722, talentID = 87649},
		EssenceBurst = {spellID = 359565},
		EternitysSpan = {spellID = 375757, talentID = 87645},
		EverburningFlame = {spellID = 370819, talentID = 87636},
		EyeofInfinity = {spellID = 369375, talentID = 87640},
		FeedtheFlames = {spellID = 369846, talentID = 87637},
		FocusingIris = {spellID = 386336, talentID = 87643},
		FontofMagic = {spellID = 375783, talentID = 87656},
		HeatWave = {spellID = 375725, talentID = 87661},
		HoaredPower = {spellID = 375796, talentID = 87591},
		HonedAggression = {spellID = 371038, talentID = 87650},
		ImminentDestruction = {spellID = 370781, talentID = 87655},
		ImposingPresence = {spellID = 371016, talentID = 87667},
		InnerRadiance = {spellID = 386405, talentID = 87666},
		Iridescence = {spellID = 370867, talentID = 87638},
		LayWaste = {spellID = 371034, talentID = 87648},
		MasteryGiantkiller = {spellID = 362980},
		OnyxLegacy = {spellID = 386348, talentID = 87654},
		PowerNexus = {spellID = 369908, talentID = 87590},
		PowerSwell = {spellID = 370839, talentID = 87644},
		RedEssenceBurst = {spellID = 376872, talentID = 87670},
		RubyEmbers = {spellID = 365937, talentID = 87674},
		Scintillation = {spellID = 370821, talentID = 87653},
		Snapfire = {spellID = 370783, talentID = 87658},
		SpellweaversDominance = {spellID = 370845, talentID = 87652},
		TitanicWrath = {spellID = 386272, talentID = 87663},
		Tyranny = {spellID = 376888, talentID = 87662},
		Volatility = {spellID = 369089, talentID = 87672},
	}
	ids.Dev_PvPTalent = {
		ChronoLoop = {spellID = 383005, talentID = 5456},
		CripplingForce = {spellID = 384660, talentID = 5471},
		NullifyingShroud = {spellID = 378464, talentID = 5467},
		ObsidianMettle = {spellID = 378444, talentID = 5460},
		Precognition = {spellID = 377360, talentID = 5509},
		ScouringFlame = {spellID = 378438, talentID = 5462},
		SwoopUp = {spellID = 370388, talentID = 5466},
		TimeStop = {spellID = 378441, talentID = 5464},
		UnburdenedFlight = {spellID = 378437, talentID = 5469},
	}
	ids.Dev_Form = {

	}
	ids.Dev_Buff = {

	}
	ids.Dev_Debuff = {

	}
	ids.Dev_PetAbility = {

	}

--Preservation
	ids.Pres_Ability = {
	--Evoker
		AzureStrike = {spellID = 362969},
		BlessingoftheBronze = {spellID = 364342},
		CauterizingFlame = {spellID = 374251, talentID = 87700},
		DeepBreath = {spellID = 357210},
		Disintegrate = {spellID = 356995},
		EmeraldBlossom = {spellID = 355913},
		Expunge = {spellID = 365585, talentID = 87716},
		FireBreath = {spellID = 357208},
		FuryoftheAspects = {spellID = 390386},
		Hover = {spellID = 358267},
		Landslide = {spellID = 358385, talentID = 87708},
		LivingFlame = {spellID = 361469},
		ObsidianScales = {spellID = 363916, talentID = 87702},
		OppressingRoar = {spellID = 372048, talentID = 87695},
		Quell = {spellID = 351338, talentID = 87692},
		RenewingBlaze = {spellID = 374348, talentID = 87679},
		Rescue = {spellID = 370665, talentID = 87685},
		Return = {spellID = 361227},
		SleepWalk = {spellID = 360806, talentID = 87587},
		SourceofMagic = {spellID = 369459, talentID = 87696},
		TimeSpiral = {spellID = 374968, talentID = 87676},
		TiptheScales = {spellID = 370553, talentID = 87713},
		Unravel = {spellID = 368432, talentID = 87690},
		VerdantEmbrace = {spellID = 360995, talentID = 87716},
		Zephyr = {spellID = 374227, talentID = 87682},
	--Preservation
		DreamBreath = {spellID = 355936, talentID = 87627},
		DreamFlight = {spellID = 359816, talentID = 87597},
		Echo = {spellID = 364343, talentID = 87628},
		EmeraldCommunion = {spellID = 370960, talentID = 87594},
		MassReturn = {spellID = 361178},
		Naturalize = {spellID = 360823},
		Reversion = {spellID = 366155, talentID = 87629},
		Rewind = {spellID = 363534, talentID = 87612},
		Spiritbloom = {spellID = 367226, talentID = 87625},
		Statis = {spellID = 370537, talentID = 92605},
		TemporalAnomaly = {spellID = 373861, talentID = 87611},
		TimeDilation = {spellID = 357170, talentID = 87613},
	}
	ids.Pres_Passive = {
	--Evoker
		AerialMastery = {spellID = 365933, talentID = 87686},
		AncientFlame = {spellID = 369990, talentID = 87698},
		AttunedtotheDream = {spellID = 376930, talentID = 87699},
		BlastFurnace = {spellID = 375510, talentID = 87694},
		BountifulBloom = {spellID = 370886, talentID = 87588},
		ClobberingSweep = {spellID = 375443, talentID = 87585},
		DraconicLegacy = {spellID = 376166, talentID = 87712},
		Enkindled = {spellID = 375554, talentID = 87704},
		ExtendedFlight = {spellID = 375517, talentID = 87706},
		Exuberance = {spellID = 375542, talentID = 87589},
		FireWithin = {spellID = 375577, talentID = 87680},
		FociofLife = {spellID = 375574, talentID = 87681},
		ForgerofMountains = {spellID = 376628, talentID = 87584},
		HeavyWingbeats = {spellID = 368838, talentID = 87586},
		InherentResistance = {spellID = 375544, talentID = 87697},
		InnateMagic = {spellID = 375520, talentID = 87710},
		InstinctiveArcana = {spellID = 376164, talentID = 87693},
		LeapingFlames = {spellID = 369939, talentID = 87689},
		LushGrowth = {spellID = 375561, talentID = 87678},
		NaturalConvergance = {spellID = 369913, talentID = 87709},
		ObsidianBulwark = {spellID = 375406, talentID = 87701},
		Overawe = {spellID = 374346, talentID = 87687},
		Panacea = {spellID = 387761, talentID = 87707},
		PermeatingChill = {spellID = 370897, talentID = 87703},
		ProtractedTalons = {spellID = 369909, talentID = 87688},
		Recall = {spellID = 371806, talentID = 87711},
		RegenerativeMagic = {spellID = 387787, talentID = 87677},
		RoarofExhilaration = {spellID = 375507, talentID = 87691},
		ScarletAdaptation = {spellID = 372469, talentID = 87714},
		Tailwind = {spellID = 375556, talentID = 87705},
		TemperedScales = {spellID = 396571},
		TerroroftheSkies = {spellID = 371032, talentID = 87675},
		TwinGuardian = {spellID = 370888, talentID = 87683},
		WallopingBlow = {spellID = 387341, talentID = 87684},
		--Preservation
		MasteryLifeBinder = {spellID = 363510},
	}
	ids.Pres_PvPTalent = {
		ChronoLoop = {spellID = 383005, talentID = 5455},
		DreamProjection = {spellID = 377509, talentID = 5454},
		NullifyingShroud = {spellID = 378464, talentID = 5468},
		ObsidianMettle = {spellID = 378444, talentID = 5459},
		Precognition = {spellID = 377360, talentID = 5502},
		ScouringFlame = {spellID = 378438, talentID = 5461},
		SwoopUp = {spellID = 370388, talentID = 5465},
		TimeStop = {spellID = 378441, talentID = 5463},
		UnburdenedFlight = {spellID = 378437, talentID = 5470},
	}
	ids.Pres_Form = {

	}
	ids.Pres_Buff = {

	}
	ids.Pres_Debuff = {

	}
	ids.Pres_PetAbility = {

	}
