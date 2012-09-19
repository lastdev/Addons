local AddonName, a = ...
if a.BuildFail(50000) then return end

a.SpellIDs = {
	["Alter Time"] = 108978,
	["Arcane Barrage"] = 44425,
	["Arcane Blast"] = 30451,
	["Arcane Charge"] = 114664,
	["Arcane Missiles"] = 5143,
	["Arcane Missiles!"] = 79683,
	["Arcane Power"] = 12042,
	["Arcane Brilliance"] = 1459,
	["Brilliant Mana Gem"] = 81901,
	["Dalaran Brilliance"] = 61316,
	["Combustion"] = 11129,
	["Combustion DoT"] = 83853,
	["Conjure Mana Gem"] = 759, -- also 119316, when glyphed
	["Counterspell"] = 2139,
	["Evocation"] = 12051,
	["Fireball"] = 133,
	["Frost Bomb"] = 112948,
	["Frostfire Bolt"] = 44614,
	["Heating Up"] = 48107,
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
	["Rune of Power"] = 116011,
	["Scorch"] = 2948,
	["Spellsteal"] = 30449,
	
	-- Items
	["Mana Gem"] = 36799,
	["Combat Mind LFR"] = 109793,
	["Combat Mind"] = 107970,
	["Combat Mind Heroic"] = 109795,
	["Stolen Time"] = 105785,
}

a.TalentIDs = {
	
}

a.GlyphIDs = {
	["Mana Gem"] = 56984,
	["Frostfire Bolt"] = 61205,
}

a.EquipmentSets = {
	T13 = {
	    HeadSlot = { 78796, 76213, 78701 },
	    ShoulderSlot = { 78843, 76216, 78748 },
	    ChestSlot = { 78824, 76215, 78729 },
	    HandsSlot = { 78766, 76212, 78671 },
	    LegsSlot = { 78815, 76214, 78720 },
	}
}
