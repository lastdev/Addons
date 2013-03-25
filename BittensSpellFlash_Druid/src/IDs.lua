local addonName, a = ...
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.AddonName = addonName
c.Init(a)

a.NoShred = {
	[55294] = true, -- Ultraxion
	[56587] = true, -- Twilight Assault Drake during Warmaster Blackhorn
	[56855] = true, -- Twilight Assault Drake during Warmaster Blackhorn
	[23777] = true, -- Proto-Drake Egg
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

a.SpellIDs = {
	["Acquatic Form"] = 1066,
	["Barkskin"] = 22812,
	["Bear Form"] = 5487,
	["Berserk"] = 106952,
	["Cat Form"] = 768,
	["Celestial Alignment"] = 112071,
	["Cenarion Ward"] = 102351,
--	["Challenging Roar"] = 5209,
	["Clearcasting"] = 16870,
--	["Demoralizing Roar"] = 99,
	["Eclipse (Lunar)"] = 48518,
	["Eclipse (Solar)"] = 48517,
	["Enrage"] = 5229,
	["Euphoria"] = 81062,
	["Faerie Fire"] = 770,
	["Faerie Swarm"] = 102355,
	["Ferocious Bite"] = 22568,
	["Force of Nature"] = 106737,
	["Flight Form"] = 33943,
	["Frenzied Regeneration"] = 22842,
	["Growl"] = 6795,
	["Healing Touch"] = 5185,
	["Heart of the Wild"] = 108288,
	["Incarnation: Chosen of Elune"] = 102560,
	["Incarnation: King of the Jungle"] = 102543,
	["Incarnation: Son of Ursoc"] = 102558,
--	["Innervate"] = 29166,
	["Lacerate"] = 33745,
	["Mangle(Bear Form)"] = 33878,
	["Mangle(Cat Form)"] = 33876,
	["Mark of the Wild"] = 1126,
	["Maul"] = 6807,
	["Might of Ursoc"] = 106922,
	["Moonfire"] = 8921,
	["Moonkin Form"] = 24858,
	["Nature's Grace"] = 16886,
	["Nature's Swiftness"] = 132158,
--	["Power Torrent"] = 74241,
	["Predatory Swiftness"] = 69369,
--	["Pulverize"] = 80313,
	["Rake"] = 1822,
--	["Ravage!"] = 81170, 
	["Ravage"] = 6785, 
--	["Regrowth"] = 8936,
	["Rejuvenation"] = 774,
	["Renewal"] = 108238,
	["Rip"] = 1079,
	["Savage Defense"] = 62606,
	["Savage Roar"] = 52610,
	["Savage Roar Glyphed"] = 127538,
	["Savage Roar Unglyphed"] = 52610,
	["Shooting Stars"] = 93400,
	["Shred"] = 5221,
	["Skull Bash"] = 106839,
	["Solar Beam"] = 78675,
--	["Stampede"] = 81022,
	["Starfall"] = 48505,
	["Starfire"] = 2912,
	["Starsurge"] = 78674,
	["Sunfire"] = 93402,
	["Survival Instincts"] = 61336,
--	["Swiftmend"] = 18562,
	["Swipe"] = 62078,
	["Symbiosis"] = 110309,
	["Thrash"] = 77758,
	["Tiger's Fury"] = 5217,
	["Tooth and Claw"] = 135288,
	["Travel Form"] = 783,
--	["Tree of Life"] = 33891,
	["Wrath"] = 5176,
	
	-- Symbiosis Spells
	["Feint"] = 122289,
	["Spell Reflection"] = 23920,
	
	-- Items
--	["Fury of the Beast Heroic"] = 109864, -- staff proc
--	["Fury of the Beast LFR"] = 109861, -- staff proc
--	["Fury of the Beast"] = 108011, -- staff proc
--	["Master Tactician Heroic"] = 109776, -- trinket proc
--	["Master Tactician LFR"] = 109774, -- trinket proc
--	["Master Tactician"] = 107986, -- trinket proc
}

a.TalentIDs = {
	["Faerie Swarm"] = 106707,
	["Incarnation"] = 106731,
	["Nature's Swiftness"] = 132158,
	["Soul of the Forest"] = 114107,
}

a.GlyphIDs = {
	["Frenzied Regeneration"] = 54810,
	["Might of Ursoc"] = 116238,
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
}
