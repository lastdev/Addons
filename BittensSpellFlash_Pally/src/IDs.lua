local addonName, a = ...
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.AddonName = addonName
c.Init(a)

a.SpellIDs = {
   ["Ardent Defender"] = 31850,
   ["Avenger's Shield"] = 31935,
   ["Avenging Wrath"] = 31884, -- retribution only
   ["Bastion of Glory"] = 114637,
   ["Beacon of Light"] = 53563,
   ["Blazing Contempt"] = 166831,
   ["Blessing of Kings"] = 20217,
   ["Blessing of Might"] = 19740,
   ["Consecration Glyphed"] = 116467,
   ["Consecration"] = 26573,
   ["Crusader Strike"] = 35395,
   ["Daybreak"] = 88819,
   ["Devotion Aura"] = 31821,
   ["Divine Protection"] = 498,
   ["Divine Purpose"] = 86172,
   ["Divine Shield"] = 642,
   ["Divine Storm"] = 53385,
   ["Empowered Hammer of Wrath"] = 157496,
   ["Eternal Flame"] = 114163,
   ["Execution Sentence"] = 114157,
   ["Exorcism"] = 879,
   ["Final Verdict"] = 157048,
   ["Flash of Light"] = 19750,
   ["Forebearance"] = 25771,
   ["Glyphed Exorcism"] = 122032,
   ["Grand Crusader"] = 98057,
   ["Guardian of Ancient Kings"] = 86659,
   ["Hammer of Wrath"] = 24275,
   ["Hammer of the Righteous"] = 53595,
   ["Hand of Protection"] = 1022,
   ["Hand of Purity"] = 114039,
   ["Holy Avenger"] = 105809,
   ["Holy Prism"] = 114165,
   ["Holy Radiance"] = 82327,
   ["Holy Shock"] = 20473,
   ["Holy Wrath"] = 119072,
   ["Judgment"] = 20271,
   ["Judgments of the Wise"] = 105424,
   ["Lay on Hands"] = 633,
   ["Liadrin's Righteousness"] = 156989,
   ["Light of Dawn"] = 85222,
   ["Light's Hammer"] = 114158,
   ["Maraad's Truth"] = 156990,
   ["Rebuke"] = 96231,
   ["Reckoning"] = 62124,
   ["Righteous Fury"] = 25780,
   ["Sacred Shield"] = 20925, -- @todo danielp 2014-11-08: 148039 for holy, <<< for ret?
   ["Seal of Insight"] = 20165,
   ["Seal of Righteousness"] = 20154,
   ["Seal of Truth"] = 31801,
   ["Selfless Healer"] = 114250,
   ["Seraphim"] = 152262,
   ["Shield of the Righteous"] = 53600,
   ["Sword of Light"] = 53503,
   ["Templar's Verdict"] = 85256,
   ["Uther's Insight"] = 156988,
   ["Word of Glory"] = 85673,

   -- Items
   ["Ret 4pT15 Buff"] = 138169, -- (the name is "Templar's Verdict")
   ["Shield of Glory"] = 138242, -- Prot 2pT15 Buff
   ["Divine Crusader"] = 144595, -- Ret 2pT16 Buff
   ["Bastion of Power"] = 144569, -- Prot T16-4 buff
   ["Lawful Words"] = 166780, -- Holy T17-2
}

a.TalentIDs = {
   ["Divine Purpose"] = 86172,
   ["Empowered Seals"] = 152263,
   ["Execution Sentence"] = 114157,
   ["Final Verdict"] = 157048,
   ["Holy Avenger"] = 105809,
   ["Holy Prism"] = 114165,
   ["Light's Hammer"] = 114158,
   ["Sanctified Wrath - Holy"] = 53376,
   ["Sanctified Wrath - Prot"] = 171648,
   ["Sanctified Wrath - Ret"] = 53376,
   ["Selfless Healer"] = 85804,
   ["Seraphim"] = 152262,
}

a.GlyphIDs = {
   ["Avenging Wrath"] = 54927,
   ["Consecration"] = 54928,
   ["Divine Protection"] = 54924,
   ["Final Wrath"] = 54935,
   ["Focused Shield"] = 54930,
   ["Holy Wrath"] = 54923,
   ["Mass Exorcism"] = 122028,
}

a.EquipmentSets = {
   ProtT14 = {
       HeadSlot = { 86661, 85321, 87111 },
       ShoulderSlot = { 86659, 85319, 87113 },
       ChestSlot = { 86663, 85323, 87109 },
       HandsSlot = { 86662, 85322, 87110 },
       LegsSlot = { 86660, 85320, 87112 },
   },
   ProtT15 = {
       HeadSlot = { 95922, 95292, 96666 },
       ShoulderSlot = { 95924, 95294, 96668 },
       ChestSlot = { 95920, 95290, 96664 },
       HandsSlot = { 95921, 95291, 96665 },
       LegsSlot = { 95923, 95293, 96667 },
   },
--      RetT15 = {
--     HeadSlot = { 95912, 95282, 96656 },
--     ShoulderSlot = { 95914, 95284, 96658 },
--     ChestSlot = { 95910, 95280, 96654 },
--     HandsSlot = { 95911, 95281, 96655 },
--     LegsSlot = { 95913, 95283, 96657 },
--      },
}
