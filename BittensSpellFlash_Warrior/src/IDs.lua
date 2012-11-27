local AddonName, a = ...
if a.BuildFail(50000) then return end

a.SpellIDs = {
	["Battle Shout"] = 6673,
	["Battle Stance"] = 2457,
	["Berserker Rage"] = 18499,
	["Berserker Stance"] = 2458,
	["Bladestorm"] = 46924,
	["Bloodsurge"] = 46915,
	["Bloodthirst"] = 23881,
	["Charge"] = 100,
	["Colossus Smash"] = 86346,
	["Commanding Shout"] = 469,
	["Deadly Calm"] = 85730,
	["Dragon Roar"] = 118000,
	["Enrage"] = 12880,
	["Execute"] = 5308,
	["Heroic Leap"] = 6544,
	["Heroic Strike"] = 78,
	["Heroic Throw"] = 57755,
	["Impending Victory"] = 103840,
	["Mortal Strike"] = 12294,
	["Overpower"] = 7384,
	["Pummel"] = 6552,
	["Raging Blow"] = 85288,
	["Recklessness"] = 1719,
	["Shockwave"] = 46968,
	["Slam"] = 1464,
	["Storm Bolt"] = 107570,
	["Taste for Blood"] = 125831,
	["Wild Strike"] = 100130,
}

a.TalentIDs = {
	
}

a.GlyphIDs = {
	
}

a.EquipmentSets = {
	ProtT13 = {
		HeadSlot = { 78784, 76990, 78689 },
		ShoulderSlot = { 78829, 76992, 78734 },
		ChestSlot = { 78753, 76988, 78658 },
		HandsSlot = { 78764, 76989, 78669 },
		LegsSlot = { 78800, 76991, 78705 },
	},
}
