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
--      [7125] = true, -- Fear
}

a.SpellIDs = {
   ["Astral Communion"] = 127663,
   ["Auto Attack"] = c.AutoAttackID,
   ["Barkskin"] = 22812,
   ["Bear Form Rage"] = 17057,
   ["Bear Form"] = 5487,
   ["Berserk"] = 106952,
   ["Bloodtalons"] = 145152, -- this is the buff
   ["Bristling Fur"] = 155835,
   ["Cat Form"] = 768,
   ["Celestial Alignment"] = 112071,
   ["Cenarion Ward"] = 102351,
   ["Clearcasting"] = 16870,
   ["Cyclone"] = 33786,
   ["Dream of Cenarius - Feral"] = 158497,
   ["Dream of Cenarius - Guardian"] = 158501,
   ["Entangling Roots"] = 339,
   ["Euphoria"] = 152222,
   ["Faerie Fire"] = 770,
   ["Faerie Swarm"] = 102355,
   ["Ferocious Bite"] = 22568,
   ["Force of Nature: Balance"] = 33831,
   ["Force of Nature: Feral"] = 102703,
   ["Force of Nature: Guardian"] = 102706,
   ["Force of Nature: Restoration"] = 102693,
   ["Frenzied Regeneration"] = 22842,
   ["Growl"] = 6795,
   ["Harmony"] = 100977,        -- buff
   ["Healing Touch"] = 5185,
   ["Heart of the Wild: Balance"] = 108291,
   ["Heart of the Wild: Feral"] = 108292,
   ["Heart of the Wild: Guardian"] = 108293,
   ["Heart of the Wild: Restoration"] = 108294,
   ["Improved Rake"] = 157276,
   ["Incapacitating Roar"] = 99,
   ["Incarnation: Chosen of Elune"] = 102560,
   ["Incarnation: King of the Jungle"] = 102543,
   ["Incarnation: Son of Ursoc"] = 102558,
   ["Incarnation: Tree of Life"] = 5420, -- or 33891 ??
   ["Lacerate"] = 33745,
   ["Lifebloom"] = 33763,
   ["Lunar Empowerment"] = 164547,
   ["Lunar Peak"] = 171743,
   ["Mangle"] = 33917,
   ["Mark of the Wild"] = 1126,
   ["Mass Entaglement"] = 102359,
   ["Maul"] = 6807,
   ["Might of Ursoc"] = 106922,
   ["Mighty Bash"] = 5211,
   ["Moonfire"] = 8921,         -- also 164812??
   ["Moonkin Form"] = 24858,
   ["Nature's Swiftness"] = 132158,
   ["Nature's Vigil"] = 124974,
   ["Omen of Clarity: Cat"] = 16864,
   ["Predatory Swiftness"] = 69369, -- buff
   ["Primal Fury Rage"] = 16959,
   ["Prowl"] = 5215,
   ["Pulverize"] = 80313,
   ["Rake Bleed"] = 155722,
   ["Rake"] = 1822,
   ["Regrowth"] = 8936,
   ["Rejuvenation"] = 774,
   ["Renewal"] = 108238,
   ["Rip"] = 1079,
   ["Savage Defense"] = 62606,
   ["Savage Roar"] = 52610,
   ["Shooting Stars"] = 93400,  -- buff
   ["Shred"] = 5221,  -- @todo danielp 2014-11-11: shred! 114236 wtf?
   ["Skull Bash"] = 106839,
   ["Solar Beam"] = 78675,
   ["Solar Empowerment"] = 164545,
   ["Solar Peak"] = 171744,
   ["Soothe"] = 2908,
   ["Soul of the Forest"] = 114113, -- cat only?
   ["Starfall"] = 48505,
   ["Starfire"] = 2912,
   ["Starsurge"] = 78674,
   ["Stellar Flare"] = 152221,
   ["Sunfire"] = 164815,
   ["Survival Instincts"] = 61336,
   ["Swift mend"] = 18562,
   ["Swipe"] = 106785,
   ["Symbiosis"] = 110309,
   ["Thrash (Bear Form)"] = 77758,
   ["Thrash (Cat Form)"] = 106830,
   ["Thrash"] = 106832,
   ["Tiger's Fury"] = 5217,
   ["Tooth and Claw"] = 135288,
   ["Tranquility"] = 740,
   ["Travel Form"] = 783,
   ["Typhoon"] = 132469,
   ["Ursol's Vortex"] = 102793,
   ["Wild Charge"] = 102401,
   ["Wild Charge: Cat"] = 49376,
   ["Wild Mushroom: Balance"] = 88747,
   ["Wild Mushroom: Restoration"] = 145205,
   ["Wrath"] = 5176,

   -- Items
   ["Sage Mender"] = 144869,

   -- Other Bleeds
   ["Deep Wounds"] = 115768,
   ["Garrote"] = 703,
   ["Hemorrhage"] = 16511,
   ["Piercing Shots"] = 53238,
   ["Pounce Bleed"] = 9007,
   ["Rupture"] = 1943,

   -- Racial ability
   ["Shadowmeld"] = 58984, -- serves as stealth for rake, etc, bonus
}

a.TalentIDs = {
   ["Balance of Power"] = 152220,
   ["Bloodtalons"] = 155672,
   ["Dream of Cenarius"] = 108373,
   ["Euphoria"] = 152222,
   ["Faerie Swarm"] = 106707,
   ["Incarnation"] = 106731,
   ["Lunar Inspiration"] = 155580,
   ["Nature's Swiftness"] = 132158,
   ["Pulverize"] = 80313,
   ["Soul of the Forest"] = 114107,
}

a.GlyphIDs = {
   ["Frenzied Regeneration"] = 54810,
   ["Might of Ursoc"] = 116238,
   ["Omens"] = 54812,
   ["Savage Roar"] = 127540,
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
--      RestorationT15 = {
--     HeadSlot = { 99013, 99638, 99178, 99436 },
--     ShoulderSlot = { 99016, 99583, 99173, 99431 },
--     ChestSlot = { 99015, 99582, 99172, 99430 },
--     HandsSlot = { 99012, 99637, 99185, 99435 },
--     LegsSlot = { 99014, 99581, 99171, 99429 },
--      },
}
