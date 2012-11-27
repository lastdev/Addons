local AddonName, a = ...
if a.BuildFail(50000) then return end

a.SpellIDs = {
	["A Murder of Crows"] = 131894,
	["Arcane Shot"] = 3044,
	["Aspect of the Fox"] = 82661,
	["Aspect of the Hawk"] = 13165,
	["Aspect of the Wild"] = 20043,
	["Autoshot"] = 75,
	["Barrage"] = 120360,
	["Bestial Wrath"] = 19574,
	["Black Arrow"] = 3674,
	["Blink Strike"] = 130392,
	["Call Pet"] = 9,
	["Call Pet 1"] = 883,
	["Call Pet 2"] = 83242,
	["Call Pet 3"] = 83243,
	["Call Pet 4"] = 83244,
	["Call Pet 5"] = 83245,
	["Cobra Shot"] = 77767,
	["Dire Beast"] = 120679,
	["Explosive Shot"] = 53301,
	["Fervor"] = 82726,
	["Focus Fire"] = 82692,
	["Frenzy"] = 19615,
	["Glaive Toss"] = 117050, 
	["Hunter's Mark"] = 1130,
	["Kill Command"] = 34026,
	["Kill Shot"] = 53351,
	["Lock and Load"] = 56453,
	["Lynx Rush"] = 120697,
	["Mend Pet"] = 136,
	["Multi-Shot"] = 2643,
	["Powershot"] = 109259,
	["Rapid Fire"] = 3045,
	["Readiness"] = 23989,
	["Revive Pet"] = 982,
	["Serpent Sting"] = 1978,
	["Stampede"] = 121818,
	["The Beast Within"] = 34471,
	["Thrill of the Hunt"] = 109306,
	
	-- Items
	["Kiroptyric Sigil"] = 77113,
}

a.TalentIDs = {
	
}

a.GlyphIDs = {
	["Marked for Death"] = 132106,
}

a.EquipmentSets = {
	T13 = {
		HeadSlot = { 78793, 77030, 78698 },
		ShoulderSlot = { 78832, 77032, 78737 },
		ChestSlot = { 78756, 77028, 78661 },
		HandsSlot = { 78769, 77029, 78674 },
		LegsSlot = { 78804, 77031, 78709 },
	}
}
