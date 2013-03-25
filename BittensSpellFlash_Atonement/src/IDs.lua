local addonName, a = ...
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.AddonName = addonName
c.Init(a)

a.SpellIDs = {
	["Atonement"] = 81751,
	["Holy Fire"] = 14914,
	["Inner Fire"] = 588,
	["Mindbender"] = 123040,
	["Penance"] = 47540,
	["Power Infusion"] = 10060,
	["Power Word: Fortitude"] = 21562,
	["Power Word: Shield"] = 17,
	["Power Word: Solace"] = 129250,
	["Power Word: Solace Heal"] = 129250,
	["Rapture"] = 47755,
	["Shadowfiend"] = 34433,
	["Shadow Word: Death"] = 32379,
	["Shadow Word: Pain"] = 589,
	["Smite"] = 585,
}

a.TalentIDs = {
	["Solace and Insanity"] = 139139,
}

a.GlyphIDs = {
	["Smite"] = 55692,
}

a.EquipmentSets = {
}
