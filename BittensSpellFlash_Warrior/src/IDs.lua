local addonName, a = ...
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.AddonName = addonName
c.Init(a)

a.SpellIDs = {
	["Avatar"] = 107574,
	["Battle Shout"] = 6673,
	["Battle Stance"] = 2457,
	["Berserker Rage"] = 18499,
	["Berserker Stance"] = 2458,
	["Bladestorm"] = 46924,
	["Bloodbath"] = 12292,
	["Bloodsurge"] = 46915,
	["Bloodthirst"] = 23881,
	["Charge"] = 100,
	["Colossus Smash"] = 86346,
	["Commanding Shout"] = 469,
	["Defensive Stance"] = 71,
	["Demoralizing Shout"] = 1160,
	["Devestate"] = 20243,
	["Disrupting Shout"] = 102060,
	["Dragon Roar"] = 118000,
	["Enrage"] = 12880,
	["Enraged Regeneration"] = 55694,
	["Execute"] = 5308,
	["Heroic Leap"] = 6544,
	["Heroic Strike"] = 78,
	["Heroic Throw"] = 57755,
	["Incite"] = 122016,
	["Impending Victory"] = 103840,
	["Last Stand"] = 12975,
	["Mortal Strike"] = 12294,
	["Overpower"] = 7384,
	["Pummel"] = 6552,
	["Raging Blow"] = 85288,
	["Rallying Cry"] = 97462,
	["Recklessness"] = 1719,
	["Revenge"] = 6572,
	["Second Wind"] = 125667,
	["Shield Barrier"] = 112048,
	["Shield Block"] = 2565,
	["Shield Slam"] = 23922,
	["Shield Wall"] = 871,
	["Shockwave"] = 46968,
	["Slam"] = 1464,
	["Spell Reflection"] = 23920,
	["Storm Bolt"] = 107570,
	["Sudden Execute"] = 139958,
	["Sunder Armor"] = 7386,
	["Sword and Board"] = 50227,
	["Taste for Blood"] = 60503,
	["Taunt"] = 355,
	["Thunder Clap"] = 6343,
	["Ultimatum"] = 122510,
	["Victorious"] = 32216,
	["Victory Rush"] = 34428,
	["Wild Strike"] = 100130,
}

a.TalentIDs = {
	["Impending Victory"] = 103840,
	["Avatar"] = 107574,
	["Bloodbath"] = 12292,
}

a.GlyphIDs = {
	["Incite"] = 122013,
	["Shield Wall"] = 63329,
	["Victory Rush"] = 58382,
}

a.EquipmentSets = {
	DpsT14 = {
	    HeadSlot = { 86673, 85333, 87192 },
	    ShoulderSlot = { 86669, 85329, 87196 },
	    ChestSlot = { 86672, 85332, 87193 },
	    HandsSlot = { 86671, 85331, 87194 },
	    LegsSlot = { 86670, 85330, 87195 },
	},
--	ProtT14 = {
--	    HeadSlot = { , ,  },
--	    ShoulderSlot = { , ,  },
--	    ChestSlot = { , ,  },
--	    HandsSlot = { , ,  },
--	    LegsSlot = { , ,  },
--	},
}
