local addonName, a = ...
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.AddonName = addonName
c.Init(a)

a.SpellIDs = {
   ["Alter Time"] = 108978,
   ["Arcane Barrage"] = 44425,
   ["Arcane Blast"] = 30451,
   ["Arcane Brilliance"] = 1459,
   ["Arcane Charge"] = 114664,
   ["Arcane Explosion"] = 1449,
   ["Arcane Instability"] = 166872, -- T174PC arcane
   ["Arcane Missiles!"] = 79683,
   ["Arcane Missiles"] = 5143,
   ["Arcane Orb"] = 153626,
   ["Arcane Power"] = 12042,
   ["Blast Wave"] = 157981,
   ["Blizzard"] = 10,
   ["Brain Freeze"] = 57761,
   ["Cold Snap"] = 11958,
   ["Combustion DoT"] = 83853,
   ["Combustion"] = 11129,
   ["Comet Storm"] = 153595,
   ["Cone of Cold"] = 120,
   ["Counterspell"] = 2139,
   ["Dalaran Brilliance"] = 61316,
   ["Deep Freeze"] = 44572,
   ["Dragon's Breath"] = 31661,
   ["Evocation"] = 12051,
   ["Fingers of Frost"] = 44544,
   ["Fire Blast"] = 2136,
   ["Fireball"] = 133,
   ["Flamestrike"] = 2120,
   ["Frost Bomb"] = 112948,
   ["Frost Nova"] = 122,
   ["Frostbolt"] = 116,
   ["Frostfire Bolt"] = 44614,
   ["Frozen Orb"] = 84714,
   ["Heating Up"] = 48107,
   ["Ice Barrier"] = 11426,
   ["Ice Floes"] = 108839,
   ["Ice Lance"] = 30455,
   ["Ice Nova"] = 157997,
   ["Icy Veins"] = 12472,
   ["Ignite"] = 12654,
   ["Incanter's Flow"] = 116267,
   ["Inferno Blast"] = 108853,
   ["Living Bomb"] = 44457,
   ["Meteor"] = 153561,
   ["Mirror Image"] = 55342,
   ["Nether Tempest"] = 114923,
   ["Presence of Mind"] = 12043,
   ["Prismatic Crystal"] = 152087,
   ["Pyroblast!"]= 48108,
   ["Pyroblast"] = 11366,
   ["Rune of Power"] = 116011,
   ["Scorch"] = 2948,
   ["Spellsteal"] = 30449,
   ["Summon Water Elemental"] = 31687,
   ["Supernova"] = 157980,
   ["Time Warp"] = 80353,

   -- Pet Spells
   ["Freeze"] = 33395,
   ["Water Jet"] = 135029,

   -- Items
   ["Combat Mind Heroic"] = 109795,
   ["Combat Mind LFR"] = 109793,
   ["Combat Mind"] = 107970,
   ["Profound Magic"] = 145252,
   ["Pyromaniac"] = 166868, -- Mage T17 Fire 4P Bonus
   ["Stolen Time"] = 105785,
}

a.TalentIDs = {
   ["Arcane Orb"] = 153626,
   ["Frost Bomb"] = 112948,
   ["Ice Nova"] = 157997,
   ["Incanter's Flow"] = 116267,
   ["Incanter's Ward"] = 1463,
   ["Kindling"] = 155148,
   ["Meteor"] = 153561,
   ["Overpowered"] = 155147,
   ["Prismatic Crystal"] = 152087,
   ["Rune of Power"] = 116011,
   ["Thermal Void"] = 155149,
}

a.GlyphIDs = {
   ["Combustion"] = 56368,
   ["Cone of Cold"] = 115705,
   ["Dragon's Breath"] = 159485,
   ["Evocation"] = 56380,
   ["Frostfire Bolt"] = 61205,
   ["Icy Veins"] = 56364,
}

a.EquipmentSets = {
   T17 = {
       ChestSlot    = { 115550 },
       ShoulderSlot = { 115551 },
       HandsSlot    = { 115552 },
       HeadSlot     = { 115553 },
       LegsSlot     = { 115554 },
   },
}
