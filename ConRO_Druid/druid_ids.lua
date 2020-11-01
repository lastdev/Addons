local ConRO_Druid, ids = ...;

--General
	ids.Racial = {
		Berserking = 26297,
	}
	ids.AzTrait = {
		ArcanicPulsar = 287773,
		IronJaws = 276021,
		GuardiansWrath = 278511,
		StreakingStars = 272871,
		WildFleshrending = 279527,
	}
	ids.AzTraitBuff = {
		IronJaws = 276026,
		GuardiansWrath = 279541,
	}
	ids.AzTraitDebuff = {
		ConcentratedFlame = 295368,
	}	
	ids.AzEssence = {
		BloodoftheEnemy = 298273,
		ConcentratedFlame = 295373,
		GuardianofAzeroth = 299358,
		MemoryofLucidDream = 298357,
		TheUnboundForce = 298452,
		WorldveinResonance = 295186,	
	}
	ids.AzEssenceBuff = {
		MemoryofLucidDream = 298357,	
	}

--Druid
	ids.Druid_Ability = {
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
	}
	ids.Druid_Passive = {
		AquaticForm = 276012,
		FlightForm = 276029,		
	}
	ids.Druid_Form = {
		BearForm = 5487,
		CatForm = 768,
		Prowl = 5215,
	}
	ids.Druid_Buff = {
		Ironfur = 192081,
		Regrowth = 8936,
	}
	ids.Druid_Debuff = {
		Moonfire = 164812,
	}
	ids.Druid_PetAbility = {

	}
	
--Balance
	ids.Bal_Ability = {
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
		--Honorable Medallion
		Adaptation = 214027,
		Relentless = 196029,
		GladiatorsMedallion = 208683,
		--
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
		MoonkinForm = 24858,
		WarriorofElune = 202425,
	}
	ids.Bal_Buff = {
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
		--Honorable Medallion
		Adaptation = 214027,
		Relentless = 196029,
		GladiatorsMedallion = 208683,
		--
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

	}
	ids.Feral_Buff = {
		Berserk = 106951,
		Bloodtalons = 0,
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
		--Honorable Medallion
		Adaptation = 214027,
		Relentless = 196029,
		GladiatorsMedallion = 208683,
		--
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
	
	}
	ids.Guard_Buff = {
		IncarnationGuardianofUrsoc = 102558,
		Pulverize = 158792,
		GalacticGuardian = 213708,
	}
	ids.Guard_Debuff = {
		Thrash = 192090,
		Moonfire = 164812,
	}
	ids.Guard_PetAbility = {
	
	}
	
--Restoration
	ids.Resto_Ability = {
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
		BalanceAffinity = 197488,
			MoonkinForm = 0,
			Starsurge = 197626,
			Starfire = 0,
			Typhoon = 0,
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
		--Honorable Medallion
		Adaptation = 214027,
		Relentless = 196029,
		GladiatorsMedallion = 208683,
		--
		
	}
	ids.Resto_Form = {

	}
	ids.Resto_Buff = {
		Lifebloom =	33763,
	}
	ids.Resto_Debuff = {

	}
	ids.Resto_PetAbility = {
	
	}