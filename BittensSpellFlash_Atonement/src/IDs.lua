local addonName, a = ...
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.AddonName = addonName
c.Init(a)

a.SpellIDs = {
	["Atonement"] = 81751,
	["Desperate Prayer"] = 19236,
	["Dispel Magic"] = 528,
	["Holy Fire"] = 14914,
	["Lucidity"] = 137323,
	["Mindbender"] = 123040,
	["Penance"] = 47540,
	["Power Infusion"] = 10060,
	["Power Word: Fortitude"] = 21562,
	["Power Word: Shield"] = 17,
	["Power Word: Solace"] = 129250,
	["Power Word: Solace Heal"] = 129250,
  ["Silence"] = 15487,
	["Shadowfiend"] = 34433,
	["Shadow Word: Pain"] = 589,
	["Smite"] = 585,
	
	-- Items
	["Soothing Talisman of the Shado-Pan Assault"] = 94509,
}

a.TalentIDs = {
	["Power Word: Solace"] = 129250,
}

a.GlyphIDs = {
	["Smite"] = 55692,
	["Penance"] = 119866,
	["Inquisitor"] = 1155,
}

a.EquipmentSets = {
}
