local addonName, a = ...
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.AddonName = addonName
c.Init(a)

a.SpellIDs = {
   ["A Murder of Crows"] = 131894,
   ["Aimed Shot"] = 19434,
   ["Arcane Shot"] = 3044,
   ["Autoshot"] = 75,
   ["Barrage"] = 120360,
   ["Beast Cleave"] = 118455,
   ["Bestial Wrath"] = 19574,
   ["Black Arrow"] = 3674,
   ["Call Pet 1"] = 883,
   ["Call Pet 2"] = 83242,
   ["Call Pet 3"] = 83243,
   ["Call Pet 4"] = 83244,
   ["Call Pet 5"] = 83245,
   ["Call Pet"] = 9, -- this is the popout button
   ["Chimaera Shot"] = 53209,
   ["Cobra Shot"] = 77767,
   ["Counter Shot"] = 147362,
   ["Dire Beast"] = 120679,
   ["Dismiss Pet"] = 2641,
   ["Enhanced Kill Shot"] = 157707,
   ["Exhilaration"] = 109304,
   ["Explosive Shot"] = 53301,
   ["Explosive Trap Launched"] = 82939,
   ["Explosive Trap"] = 13813,
   ["Focus Fire"] = 82692,
   ["Focusing Shot"] = 152245,
   ["Frenzy"] = 19623, -- was: 19615, which looks obsolete
   ["Glaive Toss"] = 117050,
   ["Kill Command"] = 34026,
   ["Kill Shot"] = 53351,
   ["Lock and Load"] = 168980,
   ["Multi-Shot"] = 2643,
   ["Powershot"] = 109259,
   ["Rapid Fire"] = 3045,
   ["Revive Pet"] = 982,
   ["Serpent Sting"] = 118253,
   ["Stampede"] = 121818,
   ["Steady Focus"] = 177667,
   ["Steady Shot"] = 56641,
   ["Thrill of the Hunt"] = 109306,
   ["Tranquilizing Shot"] = 19801,

   -- Pet Spells
   ["Bullheaded"] = 53490,
   ["Growl"] = 2649,
   ["Heart of the Phoenix"] = 55709,
   ["Last Stand"] = 53478,
   ["Mend Pet"] = 136,
}

a.TalentIDs = {
   ["Focusing Shot"] = 152245,
   ["Steady Focus"] = 177667,
   ["Lone Wolf"] = 155228,
}

a.GlyphIDs = {
}

a.EquipmentSets = {
--      T = {
--         HeadSlot = { , ,  },
--         ShoulderSlot = { , ,  },
--         ChestSlot = { , ,  },
--         HandsSlot = { , ,  },
--         LegsSlot = { , ,  },
--      }
}
