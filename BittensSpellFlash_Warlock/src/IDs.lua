local AddonName, a = ...
if a.BuildFail(50000) then return end

a.SpellIDs = {
	["Agony"] = 980,
	["Backdraft"] = 117828,
	["Chaos Bolt"] = 116858,
	["Conflagrate"] = 17962,
	["Corruption"] = 172,
	["Curse of the Elements"] = 1490,
	["Dark Intent"] = 109773,
	["Dark Soul: Instability"] = 113858,
	["Dark Soul: Misery"] = 113860,
	["Drain Soul"] = 1120,
	["Grimoire: Felhunter"] = 111897,
	["Grimoire: Imp"] = 111859,
	["Grimoire of Sacrifice"] = 108503,
	["Haunt"] = 48181,
	["Immolate"] = 348,
	["Incinerate"] = 29722,
	["Life Tap"] = 1454,
	["Malefic Grasp"] = 103103,
	["Optical Blast"] = 119911,
	["Pandemic"] = 131973,
	["Shadowburn"] = 17877,
	["Soul Swap"] = 86121,
	["Soulburn"] = 74434,
	["Summon Demon"] = 10,
	["Summon Fel Imp"] = 112866,
	["Summon Felhunter"] = 691,
	["Summon Imp"] = 688,
	["Summon Observer"] = 112869,
	["Unstable Affliction"] = 30108,
	
	-- pet spells
	["Felbolt"] = 115746,
	["Firebolt"] = 3110,
	["Spell Lock"] = 119910,
	["Lash of Pain"] = 7814,
	["Shadow Bite"] = 54049,
	["Tongue Lash"] = 115778,
	["Torment"] = 3716,
}

a.TalentIDs = {
	["Grimoire of Sacrifice"] = 108503,
}

a.GlyphIDs = {
	
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
