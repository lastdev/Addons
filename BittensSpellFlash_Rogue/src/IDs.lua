local AddonName, a = ...
if a.BuildFail(50000) then return end

a.NoBackstab = {
	[55294] = true, -- Ultraxion
	[56587] = true, -- Twilight Assault Drake during Warmaster Blackhorn
	[56855] = true, -- Twilight Assault Drake during Warmaster Blackhorn
	[23777] = true, -- Proto-Drake Egg
}

--a.NoShadowstep = {
--	-- automatically includes everything in NoBackstab
--	[56341] = true, -- Burning Tendon during Spine of Deathwing
--	[56575] = true, -- Burning Tendon during Spine of Deathwing
--	[56167] = true, -- Arm Tentacle during Madness of Deathwing
--	[56168] = true, -- Wing Tentacle during Madness of Deathwing
--	[56471] = true, -- Mutated Corruption during Madness of Deathwing
--	[56846] = true, -- Arm Tentacle during Madness of Deathwing
--	[57962] = true, -- Deathwing during Madness of Deathwing
--}

--a.NoKillingSpree = {
--	[56471] = true, -- Mutated Corruption during Madness of Deathwing
--	[57962] = true, -- Deathwing during Madness of Deathwing
--}

a.SpellIDs = {
--	["Adrenaline Rush"] = 13750,
	["Ambush"] = 8676,
	["Backstab"] = 53,
--	["Blade Flurry"] = 13877,
	["Blindside"] = 121153,
	["Deadly Poison"] = 2823,
	["Dispatch"] = 111240,
	["Energetic Recovery"] = 79152,
	["Envenom"] = 32645,
	["Eviscerate"] = 2098,
--	["Expose Armor"] = 8647,
	["Find Weakness"] = 91021,
--	["Garrote"] = 703,
	["Hemorrhage"] = 16511,
--	["Instant Poison"] = 6947,
	["Kick"] = 1766,
--	["Killing Spree"] = 51690,
	["Master of Subtlety"] = 31665,
	["Mutilate"] = 1329,
--	["Overkill"] = 58427,
	["Poisons"] = 66,
	["Premeditation"] = 14183,
	["Preparation"] = 14185,
	["Recuperate"] = 73651,
	["Redirect"] = 73981,
	["Relentless Strikes"] = 98440,
--	["Revealing Strike"] = 84617,
	["Rupture"] = 1943,
	["Shadow Dance"] = 51713,
--	["Shadowstep"] = 36554,
--	["Sinister Strike"] = 1752,
	["Slice and Dice"] = 5171,
	["Stealth"] = 115191,
	["Tricks of the Trade"] = 57934,
	["Vanish"] = 1856,
	["Venomous Wounds"] = 79134,
	["Vendetta"] = 79140,
--	["Wound Poison"] = 10918,
}

a.TalentIDs = {
	["Nightstalker"] = 14062,
	["Shadow Focus"] = 108209,
	["Subterfuge"] = 108208,
}

a.GlyphIDs = {
	["Tricks of the Trade"] = 63256,
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
