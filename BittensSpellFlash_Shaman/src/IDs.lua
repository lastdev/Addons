local addonName, a = ...
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.AddonName = addonName
c.Init(a)

a.SpellIDs = {
   ["Ancestral Swiftness"] = 16188,
   ["Ascendance"] = 165339,
   ["Chain Lightning"] = 421,
   ["Earth Elemental Totem"] = 2062,
   ["Earth Shield"] = 974,
   ["Earth Shock"] = 8042,
   ["Earthquake"] = 61882,
   ["Echo of the Elements Buff: Ele"] = 159101,
   ["Echo of the Elements Buff: Enh"] = 159103,
   ["Echo of the Elements Buff: Resto"] = 159105,
   ["Elemental Blast"] = 117014,
   ["Elemental Fusion"] = 157174,
   ["Elemental Mastery"] = 16166,
   ["Enhanced Chain Lightning"] = 157765, -- perk
   ["Feral Spirit"] = 51533,
   ["Fire Elemental Totem"] = 2894,
   ["Flame Shock"] = 8050,
   ["Healing Stream Totem"] = 5394,
   ["Healing Surge"] = 8004,
   ["Improved Chain Lightning"] = 157766, -- buff from perk
   ["Improved Lightning Shield"] = 157774,
   ["Lava Beam"] = 114074,
   ["Lava Burst"] = 51505,
   ["Lava Lash"] = 60103,
   ["Lava Surge"] = 77762,
   ["Lightning Bolt"] = 403,
   ["Lightning Shield"] = 324,
   ["Liquid Magma"] = 152255,
   ["Maelstrom Weapon"] = 53817,
   ["Magma Totem"] = 8190,
   ["Purge"] = 370,
   ["Rolling Thunder"] = 88764,
   ["Searing Totem"] = 3599,
   ["Spiritwalker's Grace"] = 79206,
   ["Storm Elemental Totem"] = 152256,
   ["Stormblast"] = 115356,
   ["Stormstrike"] = 17364,
   ["Thunderstorm"] = 51490,
   ["Unleash Elements"] = 73680,
   ["Unleash Flame"] = 165462,
   ["Water Shield"] = 52127,
   ["Water Walking"] = 546,
   ["Weapon Imbues"] = 78,
   ["Wind Shear"] = 57994,
}

a.TalentIDs = {
   ["Echo of the Elements"] = 108283,
   ["Elemental Fusion"] = 152257,
   ["Liquid Magma"] = 152255,
   ["Totemic Persistence"] = 108284,
   ["Unleashed Fury: Elemental"] = 165477,
   ["Unleashed Fury: Enhancement"] = 117012,
   ["Unleashed Fury: Restoration"] = 165479,
}

a.GlyphIDs = {
   ["Chain Lightning"] = 55449,
   ["Fire Elemental Totem"] = 55455,
   ["Spiritwalker's Focus"] = 159650,
   ["Telluric Currents"] = 55453,
   ["Thunder"] = 63270,
   ["Thunderstorm"] = 62132,
}

a.EquipmentSets = {
   T17 = {
      LegsSlot = { 115575 },
      ShoulderSlot = { 115576 },
      ChestSlot = { 115577 },
      HandsSlot = { 115578 },
      HeadSlot = { 115579 },
   },
   ElementalT15 = {
      HeadSlot = { 95952, 95322, 96696 },
      ShoulderSlot = { 95954, 95324, 96698 },
      ChestSlot = { 95950, 95320, 96694 },
      HandsSlot = { 95951, 95321, 96695 },
      LegsSlot = { 95953, 95323, 96697 },
   },
   EnhanceT15 = {
      HeadSlot = { 95947, 95317, 96691 },
      ShoulderSlot = { 95949, 95319, 96693 },
      ChestSlot = { 95945, 95315, 96689 },
      HandsSlot = { 95946, 95316, 96690 },
      LegsSlot = { 95948, 95318, 96692 },
   },
}
