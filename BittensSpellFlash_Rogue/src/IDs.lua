local addonName, a = ...
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.AddonName = addonName
c.Init(a)

a.NoBackstab = {
	[55294] = true, -- Ultraxion
	[56587] = true, -- Twilight Assault Drake during Warmaster Blackhorn
	[56855] = true, -- Twilight Assault Drake during Warmaster Blackhorn
	[23777] = true, -- Proto-Drake Egg
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
	["Blindside"] = 121153,
	["Crippling Poison"] = 3408,
	["Deadly Poison"] = 2823,
	["Deep Insight"] = 84747,
	["Dispatch"] = 111240,
	["Energetic Recovery"] = 79152,
	["Envenom"] = 32645,
	["Eviscerate"] = 2098,
	["Expose Armor"] = 8647,
	["Find Weakness"] = 91021,
	["Hemorrhage"] = 16511,
	["Kick"] = 1766,
	["Killing Spree"] = 51690,
	["Leeching Poison"] = 108211,
	["Marked for Death"] = 137619,
	["Master of Subtlety"] = 31665,
	["Mind-numbing Poison"] = 5761,
	["Moderate Insight"] = 84746,
	["Mutilate"] = 1329,
	["Paralytic Poison"] = 108215,
	["Poisons"] = 66,
	["Premeditation"] = 14183,
	["Preparation"] = 14185,
	["Recuperate"] = 73651,
	["Redirect"] = 73981,
	["Relentless Strikes"] = 98440,
	["Revealing Strike"] = 84617,
	["Rupture"] = 1943,
	["Shadow Blades"] = 121471,
	["Shadow Dance"] = 51713,
	["Shallow Insight"] = 84745,
	["Sinister Strike"] = 1752,
	["Slice and Dice"] = 5171,
	["Stealth"] = 115191,
	["Tricks of the Trade"] = 57934,
	["Vanish"] = 1856,
	["Venomous Wounds"] = 79134,
	["Vendetta"] = 79140,
	["Wound Poison"] = 8679,
}

a.TalentIDs = {
	["Nightstalker"] = 14062,
	["Shadow Focus"] = 108209,
	["Subterfuge"] = 108208,
	["Cloak and Dagger"] = 138106,
}

a.GlyphIDs = {
	["Tricks of the Trade"] = 63256,
	["Expose Armor"] = 56803,
	["Deadly Momentum"] = 63254,
}

a.EquipmentSets = {
	T14 = {
		HeadSlot = { 86641, 85301, 87126 },
		ShoulderSlot = { 86639, 85299, 87128 },
		ChestSlot = { 86643, 85303, 87124 },
		HandsSlot = { 86642, 85302, 87125 },
		LegsSlot = { 86640, 85300, 87127 },
	},
}
