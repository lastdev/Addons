local ConRO_Monk, ids = ...;

--General
	ids.Racial = {
		ArcanePulse = 260364,
		ArcaneTorrent = 129597,
		Berserking = 26297,
		GiftoftheNaaru = 59548,
	}
	ids.AzTrait = {
		DanceofChiJi = 286585,
		MistyPeaks = 275975,
	}
	ids.AzTraitBuff = {
		DanceofChiJi = 286587,
	}
	ids.AzEssence = {
		BloodoftheEnemy = 298273,
		ConcentratedFlame = 295373,
		FocusedAzeriteBeam =295258,
		GuardianofAzeroth = 299358,
		MemoryofLucidDream = 298357,
		ReapingFlames = 310690,		
		TheUnboundForce = 298452,
		WorldveinResonance = 295186,	
	}
	ids.AzEssenceBuff = {
		MemoryofLucidDream = 298357,	
	}
	ids.AzEssenceDebuff = {	
		ConcentratedFlame = 295368,
	}

--Brewmaster Spell Book
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
		--Honorable Medallion
		Adaptation = 214027,
		Relentless = 196029,
		GladiatorsMedallion = 208683,
		--	
	}
	ids.Bm_Form = {
	
	}
	ids.Bm_Buff = {
		BlackoutCombo = 228563,
		ChiTorpedo = 119085,
		RushingJadeWind = 116847,
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
		Serenity = 152173, --DoubleCheck
		StormEarthandFire = 137639,
	}
	ids.Ww_Debuff = {
		MarkoftheCrane = 228287,
	}
	ids.Ww_PetAbility = {
	
	}