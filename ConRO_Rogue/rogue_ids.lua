local ConRO_Rogue, ids = ...;

--General
	ids.Racial = {
		ArcanePulse = 260364,
		ArcaneTorrent = 25046,
		Berserking = 26297,
		Shadowmeld = 58984,
	}
	ids.AzTrait = {
		AceUpYourSleeve = 278676,
		Deadshot = 272935,
		KeepYourWitsAboutYou = 288979,
		NightsVengeance = 273418,
		SnakeEyes = 275846,
		ShroudedSuffocation = 278666,
	}
	ids.AzTraitBuff = {
		Deadshot = 272940,
		KeepYourWitsAboutYou = 288988,
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
	ids.AzEssenceBuff = {
		MemoryofLucidDream = 298357,	
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
			SubStealth = 115191,
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
		SliceandDice = 5171,
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
			SubStealth = 115191,
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