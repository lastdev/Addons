local AddonName, a = ...
if a.BuildFail(40000, 50000) then return end

a.NoBackstab = {
	[55294] = true, -- Ultraxion
	[56587] = true, -- Twilight Assault Drake during Warmaster Blackhorn
	[56855] = true, -- Twilight Assault Drake during Warmaster Blackhorn
}

a.NoShadowstep = {
	-- automatically includes everything in NoBackstab
	[56341] = true, -- Burning Tendon during Spine of Deathwing
	[56575] = true, -- Burning Tendon during Spine of Deathwing
	[56167] = true, -- Arm Tentacle during Madness of Deathwing
	[56168] = true, -- Wing Tentacle during Madness of Deathwing
	[56471] = true, -- Mutated Corruption during Madness of Deathwing
	[56846] = true, -- Arm Tentacle during Madness of Deathwing
	[57962] = true, -- Deathwing during Madness of Deathwing
}

a.NoKillingSpree = {
	[56471] = true, -- Mutated Corruption during Madness of Deathwing
	[57962] = true, -- Deathwing during Madness of Deathwing
}

a.SpellIDs = {
	["Adrenaline Rush"] = 13750,
	["Ambush"] = 8676,
	["Backstab"] = 53,
	["Blade Flurry"] = 13877,
	["Deadly Poison"] = 2892,
	["Envenom"] = 32645,
	["Eviscerate"] = 2098,
	["Expose Armor"] = 8647,
	["Find Weakness"] = 91021,
	["Garrote"] = 703,
	["Hemorrhage"] = 16511,
	["Instant Poison"] = 6947,
	["Kick"] = 1766,
	["Killing Spree"] = 51690,
	["Master of Subtlety"] = 31665,
	["Mutilate"] = 1329,
	["Overkill"] = 58427,
	["Premeditation"] = 14183,
	["Preparation"] = 14185,
	["Recuperate"] = 73651,
	["Redirect"] = 73981,
	["Relentless Strikes"] = 98440,
	["Revealing Strike"] = 84617,
	["Rupture"] = 1943,
	["Shadow Dance"] = 51713,
	["Shadowstep"] = 36554,
	["Sinister Strike"] = 1752,
	["Slice and Dice"] = 5171,
	["Tricks of the Trade"] = 57934,
	["Vanish"] = 1856,
	["Vendetta"] = 79140,
	["Wound Poison"] = 10918,
}

a.TalentIDs = {
	["Energetic Recovery"] = 79152,
	["Honor Among Thieves"] = 51701,
	["Murderous Intent"] = 14158,
	["Relentless Strikes"] = 14179,
	["Venomous Wounds"] = 79134,
}

a.GlyphIDs = {
	["Glyph of Hemorrhage"] = 56807,
}

a.EquipmentSets = {
	T13 = {
		HeadSlot = { 78794, 77025, 78699 },
		ShoulderSlot = { 78833, 77027, 78738 },
		ChestSlot = { 78759, 77023, 78664 },
		HandsSlot = { 78774, 77024, 78679 },
		LegsSlot = { 78803, 77026, 78708 },
	},
}
