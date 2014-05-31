local addonName, a = ...
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.AddonName = addonName
c.Init(a)

a.SpellIDs = {
	["A Murder of Crows"] = 131894,
	["Aimed Shot"] = 19434,
	["Aimed Shot!"] = 82928,
	["Arcane Shot"] = 3044,
	["Aspect of the Hawk"] = 13165,
	["Aspect of the Iron Hawk"] = 109260,
	["Autoshot"] = 75,
	["Barrage"] = 120360,
	["Bestial Wrath"] = 19574,
	["Black Arrow"] = 3674,
	["Call Pet"] = 9,
	["Call Pet 1"] = 883,
	["Call Pet 2"] = 83242,
	["Call Pet 3"] = 83243,
	["Call Pet 4"] = 83244,
	["Call Pet 5"] = 83245,
	["Chimera Shot"] = 53209,
	["Cobra Shot"] = 77767,
	["Counter Shot"] = 147362,
	["Dire Beast"] = 120679,
--	["Distracting Shot"] = 20736,
	["Explosive Shot"] = 53301,
	["Explosive Trap"] = 13813,
	["Explosive Trap Launched"] = 82939,
	["Exhilaration"] = 109304,
--	["Feign Death"] = 5384,
	["Fervor"] = 82726,
	["Fire!"] = 82926,
	["Focus Fire"] = 82692,
	["Frenzy"] = 19615,
	["Glaive Toss"] = 117050, 
	["Hunter's Mark"] = 1130,
	["Improved Serpent Sting"] = 83077,
	["Kill Command"] = 34026,
	["Kill Shot"] = 53351,
	["Lock and Load"] = 56453,
	["Lynx Rush"] = 120697,
	["Multi-Shot"] = 2643,
	["Powershot"] = 109259,
	["Rapid Fire"] = 3045,
	["Rapid Recuperation"] = 53232,
--	["Resistance is Futile"] = 82897,
	["Revive Pet"] = 982,
	["Serpent Sting"] = 1978,
	["Serpent Sting Debuff"] = 118253,
--	["Scare Beast"] = 1513,
	["Stampede"] = 121818,
	["Steady Focus"] = 53220,
	["Steady Shot"] = 56641,
	["The Beast Within"] = 34471,
	["Thrill of the Hunt"] = 109306,
	["Tranquilizing Shot"] = 19801,
--	["Trap Launcher"] = 77769,
--	["Wyvern Sting"] = 19386,
	
	-- Pet Spells
	["Bullheaded"] = 53490,
	["Cower"] = 1742,
	["Growl"] = 2649,
	["Heart of the Phoenix"] = 55709,
	["Last Stand"] = 53478,
	["Mend Pet"] = 136,
	["Rabid"] = 53401,
}

a.TalentIDs = {
	
}

a.GlyphIDs = {
	["Aimed Shot"] = 126095,
}

--a.EquipmentSets = {
--	T = {
--		HeadSlot = { , ,  },
--		ShoulderSlot = { , ,  },
--		ChestSlot = { , ,  },
--		HandsSlot = { , ,  },
--		LegsSlot = { , ,  },
--	}
--}
