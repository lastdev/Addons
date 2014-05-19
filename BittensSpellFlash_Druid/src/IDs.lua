local addonName, a = ...
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.AddonName = addonName
c.Init(a)

a.NoShred = {
	[55294] = true, -- Ultraxion
	[56587] = true, -- Twilight Assault Drake during Warmaster Blackhorn
	[56855] = true, -- Twilight Assault Drake during Warmaster Blackhorn
	[23777] = true, -- Proto-Drake Egg
	[61069] = true, -- Shai Hu
	[56754] = true, -- Azure Serpent
	[60709] = true, -- Qiang the Merciless
--	[7125] = true, -- Fear
}

a.SymbiosisSelfBuffs = {
	110497, -- hunter
	110498, -- death knight
	110499, -- mage
	110500, -- monk
	110501, -- paladin
	110502, -- priest
	110503, -- rogue
	110504, -- shaman
	110505, -- warlock
	110506, -- warrior
}

a.SymbiosisRaidBuffs = {
	110478, -- death knight
	110479, -- hunter
	110482, -- mage
	110483, -- monk
	110484, -- paladin
	110485, -- priest
	110486, -- rogue
	110488, -- shaman
	110490, -- warlock
	110491, -- warrior
}

a.SymbiosisGuardianFlashIDs = {
	110309, -- w/ no buff
	122289, -- Feint
	113002, -- Spell Reflection
	122285, -- Bone Shield
	126453, -- Elusive Brew
	110600, -- Ice Trap
	110694, -- Frost Armor
	110701, -- Consecration
	110717, -- Fear Ward
	122290, -- Life Tap
	110803, -- Lightning Shield
}

a.SymbiosisFeralFlashIDs = {
	110309, -- w/ no buff
	122283, -- Death Coil
	110597, -- Play Dead
	110693, -- Frost Nova
	126449, -- Clash
	110700, -- Divine Shield
	110715, -- Dispersion
	110730, -- Redirect
	110807, -- Feral Spirit
	110810, -- Soul Swap
	112997, -- Shattering Blow
}

a.SpellIDs = {
	["Acquatic Form"] = 1066,
	["Astral Communion"] = 127663,
	["Astral Insight"] = 145138,
	["Auto Attack"] = c.AutoAttackID,
	["Barkskin"] = 22812,
	["Bear Form"] = 5487,
	["Bear Form Rage"] = 17057,
	["Berserk"] = 106952,
	["Cat Form"] = 768,
	["Celestial Alignment"] = 112071,
	["Cenarion Ward"] = 102351,
	["Clearcasting"] = 16870,
	["Cyclone"] = 33786,
	["Disorienting Roar"] = 99,
	["Dream of Cenarius - Feral"] = 145152,
	["Dream of Cenarius - Guardian"] = 145162,
	["Eclipse (Lunar)"] = 48518,
	["Eclipse (Solar)"] = 48517,
	["Enrage"] = 5229,
	["Entangling Roots"] = 339,
	["Euphoria"] = 81062,
	["Faerie Fire"] = 770,
	["Faerie Swarm"] = 102355,
	["Ferocious Bite"] = 22568,
	["Force of Nature"] = 106737,
	["Force of Nature: Balance"] = 33831,
	["Force of Nature: Feral"] = 102703,
	["Force of Nature: Restoration"] = 102693,
	["Flight Form"] = 33943,
	["Frenzied Regeneration"] = 22842,
	["Growl"] = 6795,
	["Harmony"] = 100977,
	["Healing Touch"] = 5185,
	["Heart of the Wild"] = 108292,
	["Incarnation: Chosen of Elune"] = 102560,
	["Incarnation: King of the Jungle"] = 102543,
	["Incarnation: Son of Ursoc"] = 102558,
	["Incarnation: Tree of Life"] = 5420,
	["Innervate"] = 29166,
	["Lacerate"] = 33745,
	["Lifebloom"] = 33763,
	["Lunar Shower"] = 81192,
	["Mangle"] = 33917,
	["Mangle(Bear Form)"] = 33878,
	["Mangle(Cat Form)"] = 33876,
	["Mark of the Wild"] = 1126,
	["Mass Entaglement"] = 102359,
	["Maul"] = 6807,
	["Might of Ursoc"] = 106922,
	["Mighty Bash"] = 5211,
	["Moonfire"] = 8921,
	["Moonkin Form"] = 24858,
	["Nature's Grace"] = 16886,
	["Nature's Swiftness"] = 132158,
	["Nature's Vigil"] = 124974,
	["Nourish"] = 50464,
	["Predatory Swiftness"] = 69369,
	["Primal Fury Rage"] = 16959,
	["Prowl"] = 5215,
	["Rake"] = 1822,
	["Ravage"] = 6785, 
	["Ravage!"] = 102545, 
	["Regrowth"] = 8936,
	["Rejuvenation"] = 774,
	["Renewal"] = 108238,
	["Rip"] = 1079,
	["Savage Defense"] = 62606,
	["Savage Roar"] = 52610,
	["Savage Roar Glyphed"] = 127538,
	["Savage Roar Unglyphed"] = 52610,
	["Shooting Stars"] = 93400,
	["Shred"] = 5221,
	["Shred!"] = 114236,
	["Skull Bash"] = 106839,
	["Solar Beam"] = 78675,
	["Soothe"] = 2908,
	["Soul of the Forest"] = 114113,
	["Starfall"] = 48505,
	["Starfire"] = 2912,
	["Starsurge"] = 78674,
	["Sunfire"] = 93402,
	["Survival Instincts"] = 61336,
	["Swiftmend"] = 18562,
	["Swipe"] = 106785,
	["Swipe(Bear Form)"] = 779,
	["Swipe(Cat Form)"] = 62078,
	["Symbiosis"] = 110309,
	["Thrash"] = 106832,
	["Thrash(Cat Form)"] = 106830,
	["Thrash(Bear Form)"] = 77758,
	["Tiger's Fury"] = 5217,
	["Tooth and Claw"] = 135288,
	["Tranquility"] = 740,
	["Travel Form"] = 783,
	["Typhoon"] = 132469,
	["Ursol's Vortex"] = 102793,
	["Wild Mushroom"] = 88747,
	["Wild Mushroom: Detonate"] = 88751,
	["Wrath"] = 5176,
	
	-- Symbiosis Spells
	["Feint"] = 122289,
	["Spell Reflection"] = 23920,
	["Bone Shield"] = 122285,
	["Elusive Brew"] = 126453,
	
	-- Items
	["Feral Fury"] = 144865,
	["Feral Rage"] = 146874,
	["Flashing Steel"] = 126484,
	["Flashing Steel Talisman"] = 81265,
	["Fortitude of the Zandalari"] = 95677,
	["Improved Regeneration"] = 138217,
	["Re-Origination"] = 139121,
	["Sage Mender"] = 144869,
	
	-- Other Bleeds
	["Deep Wounds"] = 115768,
	["Garrote"] = 703,
	["Hemorrhage"] = 16511,
	["Piercing Shots"] = 53238,
	["Pounce Bleed"] = 9007,
	["Rupture"] = 1943,
}

a.TalentIDs = {
	["Faerie Swarm"] = 106707,
	["Incarnation"] = 106731,
	["Nature's Swiftness"] = 132158,
	["Soul of the Forest"] = 114107,
	["Dream of Cenarius"] = 108373,
}

a.GlyphIDs = {
	["Frenzied Regeneration"] = 54810,
	["Might of Ursoc"] = 116238,
	["Omens"] = 54812,
	["Savagery"] = 127540,
	["Shred"] = 114234,
	["Survival Instincts"] = 114223,
}

a.EquipmentSets = {
	GuardianT14 = {
	    HeadSlot = { 86721, 85381, 86940 },
	    ShoulderSlot = { 86723, 85383, 86942 },
	    ChestSlot = { 86719, 85379, 86938 },
	    HandsSlot = { 86720, 85380, 86939 },
	    LegsSlot = { 86722, 85382, 86941 },
	},
	GuardianT15 = {
	    HeadSlot = { 95852, 95252, 96596 },
	    ShoulderSlot = { 95854, 95254, 96598 },
	    ChestSlot = { 95850, 95250, 96594 },
	    HandsSlot = { 95851, 95251, 96595 },
	    LegsSlot = { 95853, 95253, 96597 },
	},
--	RestorationT15 = {
--	    HeadSlot = { 99013, 99638, 99178, 99436 },
--	    ShoulderSlot = { 99016, 99583, 99173, 99431 },
--	    ChestSlot = { 99015, 99582, 99172, 99430 },
--	    HandsSlot = { 99012, 99637, 99185, 99435 },
--	    LegsSlot = { 99014, 99581, 99171, 99429 },
--	},
}
