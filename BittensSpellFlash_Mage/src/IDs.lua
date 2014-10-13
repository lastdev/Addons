local addonName, a = ...
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.AddonName = addonName
c.Init(a)

a.SpellIDs = {
	["Alter Time"] = 108978,
	["Arcane Barrage"] = 44425,
	["Arcane Blast"] = 30451,
	["Arcane Charge"] = 114664,
	["Arcane Explosion"] = 1449,
	["Arcane Missiles"] = 5143,
	["Arcane Missiles!"] = 79683,
	["Arcane Power"] = 12042,
	["Arcane Brilliance"] = 1459,
	["Brain Freeze"] = 57761,
	["Dalaran Brilliance"] = 61316,
	["Cold Snap"] = 11958,
	["Combustion"] = 11129,
	["Combustion DoT"] = 83853,
	["Conjure Mana Gem"] = 759, -- also 119316, when glyphed
	["Counterspell"] = 2139,
	["Deep Freeze"] = 44572,
	["Evocation"] = 12051,
	["Fingers of Frost"] = 44544,
	["Fire Blast"] = 2136,
	["Fireball"] = 133,
	["Flamestrike"] = 2120,
	["Freeze"] = 33395,
	["Frost Armor"] = 7302,
	["Frost Bomb"] = 112948,
	["Frost Nova"] = 122,
	["Frostbolt"] = 116,
	["Frostfire Bolt"] = 44614,
	["Frozen Orb"] = 84714,
	["Heating Up"] = 48107,
	["Ice Barrier"] = 11426,
	["Ice Floes"] = 108839,
	["Ice Lance"] = 30455,
	["Icy Veins"] = 12472,
	["Icy Veins Glyphed"] = 131078,
	["Incanter's Ward"] = 1463,
	["Incanter's Absorption"] = 116267,
	["Invoker's Energy"] = 116257,
	["Ignite"] = 12654,
	["Inferno Blast"] = 108853,
	["Living Bomb"] = 44457,
	["Mage Armor"] = 6117,
	["Mirror Image"] = 55342,
	["Molten Armor"] = 30482,
	["Nether Tempest"] = 114923,
	["Presence of Mind"] = 12043,
	["Pyroblast"] = 11366,
	["Pyroblast!"]= 48108,
	["Pyromaniac"] = 132210,
	["Replenish Mana"] = 5405,
	["Rune of Power"] = 116011,
	["Scorch"] = 2948,
	["Spellsteal"] = 30449,
	["Summon Water Elemental"] = 31687,
	["Temporal Shield"] = 115610,
	
	-- Items
	["Brilliant Mana Gem"] = 81901,
	["Mana Gem"] = 36799,
	["Combat Mind LFR"] = 109793,
	["Combat Mind"] = 107970,
	["Combat Mind Heroic"] = 109795,
	["Profound Magic"] = 145252,
	["Stolen Time"] = 105785,
}

a.TalentIDs = {
	["Frost Bomb"] = 112948,
	["Incanter's Ward"] = 1463,
	["Invocation"] = 114003,
	["Rune of Power"] = 116011,
}

a.GlyphIDs = {
	["Evocation"] = 56380,
	["Frostfire Bolt"] = 61205,
	["Icy Veins"] = 56364,
	["Mana Gem"] = 56984,
}

a.EquipmentSets = {
	T13 = {
	    HeadSlot = { 78796, 76213, 78701 },
	    ShoulderSlot = { 78843, 76216, 78748 },
	    ChestSlot = { 78824, 76215, 78729 },
	    HandsSlot = { 78766, 76212, 78671 },
	    LegsSlot = { 78815, 76214, 78720 },
	},
--	T15 = {
--	    HeadSlot = { 95891, 95261, 96635 },
--	    ShoulderSlot = { 95894, 95264, 96638 },
--	    ChestSlot = { 95893, 95263, 96637 },
--	    HandsSlot = { 95890, 95260, 96634 },
--	    LegsSlot = { 95892, 95262, 96636 },
--	},
}
