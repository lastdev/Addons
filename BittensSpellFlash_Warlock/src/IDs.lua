local addonName, a = ...
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.AddonName = addonName
c.Init(a)

a.SpellIDs = {
   -- ["Shadow Bolt Glyphed"] = 112092, -- @todo danielp 2014-11-09: absolutely no idea, missing from DB :(
   ["Aftermath"] = 109784,
   ["Agony"] = 980,
   ["Backdraft"] = 117828,
   ["Cataclysm"] = 152108,
   ["Chaos Bolt"] = 116858,
   ["Chaos Wave"] = 124916,
   ["Conflagrate AoE"] = 108685,
   ["Conflagrate"] = 17962,
   ["Corruption"] = 146739,
   ["Dark Intent"] = 109773,
   ["Dark Regeneration"] = 108359,
   ["Dark Soul: Instability"] = 113858,
   ["Dark Soul: Knowledge"] = 113861,
   ["Dark Soul: Misery"] = 113860,
   ["Demonic Synergy"] = 171982,
   ["Doom"] = 124913, -- was: 603, which is now "uncategorized"?
   ["Drain Soul"] = 103103, -- was 1120, which no longer exists
   ["Ember Tap"] = 114635,
   ["Fire and Brimstone"] = 108683,
   ["Grimoire of Sacrifice"] = 108503,
   ["Grimoire: Felguard"] = 111898,
   ["Grimoire: Felhunter"] = 111897,
   ["Grimoire: Imp"] = 111859,
   ["Hand of Gul'dan"] = 105174,
   ["Harvest Life"] = 108371,
   ["Haunt"] = 48181,
   ["Hellfire"] = 1949,
   ["Immolate AoE"] = 108686,
   ["Immolate"] = 348,
   ["Immolation Aura"] = 104025,
   ["Imp Swarm"] = 104316,
   ["Incinerate AoE"] = 114654,
   ["Incinerate"] = 29722,
   ["Life Tap"] = 1454,
   ["Mannoroth's Fury"] = 108508,
   ["Mannoroth's Fury"] = 108508,
   ["Metamorphosis"] = 103958,
   ["Molten Core"] = 122355,
   ["Rain of Fire"] = 104232,
   ["Seed of Corruption"] = 114790,
   ["Shadow Bolt"] = 686,
   ["Shadowburn"] = 17877,
   ["Shadowflame"] = 47960,
   ["Soul Fire"] = 6353,
   ["Soul Swap Exhale"] = 86213,
   ["Soul Swap Soulburn"] = 119678,
   ["Soul Swap"] = 86121,
   ["Soulburn"] = 74434,
   ["Soulshatter"] = 29858,
   ["Soulstone"] = 20707,
   ["Summon Demon"] = 10, -- NOTE: this is an undocumented hack, but it works.
   ["Summon Doomguard"] = 18540,
   ["Summon Fel Imp"] = 112866,
   ["Summon Felguard"] = 30146,
   ["Summon Felhunter"] = 691,
   ["Summon Imp"] = 688,
   ["Summon Infernal"] = 1122,
   ["Summon Observer"] = 112869,
   ["Summon Wrathguard"] = 112870,
   ["Touch of Chaos"] = 103964,
   ["Unending Breath"] = 5697,
   ["Unstable Affliction"] = 30108,

   -- pet spells
   -- ["Axe Toss"] = 103131,       -- @todo danielp 2014-11-09: does not exist
   ["Clone Magic"] = 115284,
   ["Command Spell Lock"] = 132409,
   ["Devour Magic"] = 19505,
   ["Felbolt"] = 115746,
   ["Felstorm"] = 119914,
   ["Firebolt"] = 3110,
   ["Lash of Pain"] = 7814,
   ["Optical Blast"] = 119911,
   ["Shadow Bite"] = 54049,
   ["Spell Lock"] = 119910,
   ["Super Axe Toss"] = 89766,  -- just "axe toss" now??
   ["Tongue Lash"] = 115778,
   ["Torment"] = 3716,
   ["Wrathstorm"] = 119915,
}

a.TalentIDs = {
   ["Archimonde's Darkness"] = 108505,
   ["Grimoire of Sacrifice"] = 108503,
   ["Demonic Servitude"] = 152107,
}

a.GlyphIDs = {
   ["Dark Soul"] = 159665,
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
   T15 = {
       HeadSlot = { 95982, 95326, 96726 },
       ShoulderSlot = { 95985, 95329, 96729 },
       ChestSlot = { 95984, 95328, 96728 },
       HandsSlot = { 95981, 95325, 96725 },
       LegsSlot = { 95983, 95327, 96727 },
   },
   T17 = {
       HeadSlot = { 115586 },
       ShoulderSlot = { 115589 },
       ChestSlot = { 115588 },
       HandsSlot = { 115585 },
       LegsSlot = { 115587 },
   }
}
