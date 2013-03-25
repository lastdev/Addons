local addonName, a = ...
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.AddonName = addonName
c.Init(a)

a.SpellIDs = {
	["Agony"] = 980,
	["Aura of the Elements"] = 116202,
	["Backdraft"] = 117828,
	["Backlash"] = 108563,
	["Carrion Swarm"] = 103967,
	["Chaos Bolt"] = 116858,
	["Conflagrate"] = 17962,
	["Conflagrate AoE"] = 108685,
	["Corruption"] = 172,
	["Curse of the Elements"] = 1490,
	["Dark Intent"] = 109773,
	["Dark Regeneration"] = 108359,
	["Dark Soul: Instability"] = 113858,
	["Dark Soul: Knowledge"] = 113861,
	["Dark Soul: Misery"] = 113860,
	["Doom"] = 603,
	["Drain Soul"] = 1120,
	["Ember Tap"] = 114635,
	["Fel Flame"] = 77799,
	["Fire and Brimstone"] = 108683,
	["Grimoire: Felhunter"] = 111897,
	["Grimoire: Felguard"] = 111898,
	["Grimoire: Imp"] = 111859,
	["Grimoire of Sacrifice"] = 108503,
	["Hand of Gul'dan"] = 105174,
	["Harvest Life"] = 108371,
	["Haunt"] = 48181,
	["Hellfire"] = 1949,
	["Immolate"] = 348,
	["Immolate AoE"] = 108686,
	["Immolation Aura"] = 104025,
	["Incinerate"] = 29722,
	["Incinerate AoE"] = 114654,
	["Life Tap"] = 1454,
	["Malefic Grasp"] = 103103,
	["Metamorphosis"] = 103958,
	["Molten Core"] = 122355,
	["Pandemic"] = 131973,
	["Rain of Fire"] = 104232,
	["Seed of Corruption"] = 114790,
	["Shadow Bolt"] = 686,
	["Shadow Bolt Glyphed"] = 112092,
	["Shadowburn"] = 17877,
	["Shadowflame"] = 47960,
	["Soul Fire"] = 6353,
	["Soul Swap"] = 86121,
	["Soulburn"] = 74434,
	["Soulshatter"] = 29858,
	["Soulstone"] = 20707,
	["Summon Demon"] = 10,
	["Summon Fel Imp"] = 112866,
	["Summon Felguard"] = 30146,
	["Summon Felhunter"] = 691,
	["Summon Imp"] = 688,
	["Summon Observer"] = 112869,
	["Summon Wrathguard"] = 112870,
	["Touch of Chaos"] = 103964,
	["Underwater Breath"] = 5697,
	["Unstable Affliction"] = 30108,
	["Void Ray"] = 115422,
	
	-- pet spells
	["Axe Toss"] = 103131,
	["Command Spell Lock"] = 132409,
	["Felbolt"] = 115746,
	["Felstorm"] = 119914,
	["Firebolt"] = 3110,
	["Spell Lock"] = 119910,
	["Lash of Pain"] = 7814,
	["Optical Blast"] = 119911,
	["Shadow Bite"] = 54049,
	["Super Axe Toss"] = 89766,
	["Tongue Lash"] = 115778,
	["Torment"] = 3716,
	["Wrathstorm"] = 119915,
}

a.TalentIDs = {
	["Grimoire of Sacrifice"] = 108503,
}

a.GlyphIDs = {
	["Ember Tap"] = 63304,
}

a.EquipmentSets = {
	T13 = {
	    HeadSlot = { 78797, 76342, 78702 },
	    ShoulderSlot = { 78844, 76339, 78749 },
	    ChestSlot = { 78825, 76340, 78730 },
	    HandsSlot = { 78776, 76343, 78681 },
	    LegsSlot = { 78816, 76341, 78721 },
	},
}
