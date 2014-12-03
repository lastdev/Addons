local addonName, a = ...
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.AddonName = addonName
c.Init(a)

a.NoBackstab = {
   [55294] = true, -- Ultraxion
   [56587] = true, -- Twilight Assault Drake during Warmaster Blackhorn
   [56855] = true, -- Twilight Assault Drake during Warmaster Blackhorn
   [23777] = true, -- Proto-Drake Egg
   [56754] = true, -- Azure Serpent
   [60709] = true, -- Qiang the Merciless
}

a.NoShadowstep = {
   -- automatically includes everything in NoBackstab
   [56341] = true, -- Burning Tendon during Spine of Deathwing
   [56575] = true, -- Burning Tendon during Spine of Deathwing
   [56167] = true, -- Arm Tentacle during Madness of Deathwing
   [56168] = true, -- Wing Tentacle during Madness of Deathwing
   [56471] = true, -- Mutated Corruption during Madness of Deathwing
   [56846] = true, -- Arm Tentacle during Madness of Deathwing
   [57962] = true, -- Deathwing during Madness of Deathwing
}

a.NoKillingSpree = {
   [56471] = true, -- Mutated Corruption during Madness of Deathwing
   [57962] = true, -- Deathwing during Madness of Deathwing
}

a.SpellIDs = {
   ["Adrenaline Rush"] = 13750,
   ["Ambush"] = 8676,
   ["Anticipation"] = 114015,
   ["Backstab"] = 53,
   ["Blade Flurry"] = 13877,
   ["Blindside"] = 121153,
   ["Crippling Poison"] = 3408,
   ["Deadly Poison"] = 2823,
   ["Deep Insight"] = 84747,
   ["Dispatch"] = 111240,
   ["Energetic Recovery"] = 79152,
   ["Envenom"] = 32645,
   ["Eviscerate"] = 2098,
--      ["Expose Armor"] = 60842, -- its ID was 8647
   ["Find Weakness"] = 91021,
   ["Hemorrhage"] = 16511,
   ["Instant Poison"] = 157584,
   ["Kick"] = 1766,
   ["Killing Spree"] = 51690,
   ["Leeching Poison"] = 108211,
   ["Marked for Death"] = 137619,
   ["Master of Subtlety"] = 31665,
--      ["Mind-numbing Poison"] = 5761,
   ["Moderate Insight"] = 84746,
   ["Mutilate"] = 1329,
--      ["Paralytic Poison"] = 108215,
   ["Poisons"] = 66,
   ["Premeditation"] = 14183,
   ["Preparation"] = 14185,
   ["Recuperate"] = 73651,
--      ["Redirect"] = 73981,
   ["Relentless Strikes"] = 98440,
   ["Revealing Strike"] = 84617,
   ["Rupture"] = 1943,
   ["Ruthlessness"] = 14161,
--      ["Ruthlessness Energize"] = 139546,
--      ["Shadow Blades"] = 121471,
   ["Shadow Dance"] = 51713,
   ["Shallow Insight"] = 84745,
   ["Shiv"] = 5938,
   ["Shuriken Toss"] = 114014,
   ["Sinister Strike"] = 1752,
   ["Slice and Dice"] = 5171,
   ["Improved Slice and Dice"] = 157513,
   ["Stealth"] = 115191,
   ["Subterfuge"] = 108208,
--      ["Tricks of the Trade"] = 57934, -- (It no longer has a damage component.)
   ["Vanish"] = 1856,
   ["Venomous Wounds"] = 79134,
   ["Vendetta"] = 79140,
   ["Wound Poison"] = 8679,
   ["Death from Above"] = 152150,
   ["Shadow Reflection"] = 152151,
}

a.TalentIDs = {
   ["Nightstalker"] = 14062,
   ["Shadow Focus"] = 108209,
   ["Subterfuge"] = 108208,
   ["Cloak and Dagger"] = 138106,
   ["Anticipation"] = 114015,
   ["Venom Rush"] = 152152,
}

a.GlyphIDs = {
--      ["Tricks of the Trade"] = 63256,
--      ["Expose Armor"] = 56803,
   ["Deadly Momentum"] = 63254,
--      ["Glyph of Energy"] = 159634,
--      ["Glyph of Energy Flows"] = 159636,
}

a.EquipmentSets = {
   T14 = {
      HeadSlot = { 86641, 85301, 87126 },
      ShoulderSlot = { 86639, 85299, 87128 },
      ChestSlot = { 86643, 85303, 87124 },
      HandsSlot = { 86642, 85302, 87125 },
      LegsSlot = { 86640, 85300, 87127 },
   },
   T15 = {
      HeadSlot = { 95937, 95307, 96681 },
      ShoulderSlot = { 95939, 95309, 96683 },
      ChestSlot = { 95935, 95305, 96679 },
      HandsSlot = { 95936, 95306, 96680 },
      LegsSlot = { 95938, 95308, 96682 },
   },
}
