local addonName, a = ...
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.AddonName = addonName
c.Init(a)

a.SpellIDs = {
	["Anti-Magic Shell"] = 48707,
	["Anti-Magic Zone"] = 50461,
	["Asphyxiate"] = 108194,
	["Blood Boil"] = 48721,
	["Blood Charge"] = 114851,
	["Blood Plague"] = 55078,
	["Blood Presence"] = 48263,
	["Blood Shield"] = 77535,
	["Blood Tap"] = 45529,
	["Bone Shield"] = 49222,
	["Conversion"] = 119975,
	["Crimson Scourge"] = 81141,
	["Dancing Rune Weapon"] = 49028,
	["Dark Command"] = 56222,
	["Dark Transformation"] = 63560,
	["Death and Decay"] = 43265,
	["Death Coil"] = 47541,
	["Death Grip"] = 49576,
	["Death Pact"] = 48743,
	["Death Siphon"] = 108196,
	["Death Strike"] = 49998,
	["Ebon Plaguebringer"] = 51160,
	["Empower Rune Weapon"] = 47568,
	["Festering Strike"] = 85948,
	["Freezing Fog"] = 59052,
	["Frost Fever"] = 55095,
	["Frost Presence"] = 48266,
	["Frost Strike"] = 49143,
	["Heart Strike"] = 55050,
	["Horn of Winter"] = 57330,
	["Howling Blast"] = 49184,
	["Icebound Fortitude"] = 48792,
	["Icy Touch"] = 45477,
	["Killing Machine"] = 51124,
	["Mind Freeze"] = 47528,
	["Obliterate"] = 49020,
	["Outbreak"] = 77575,
	["Pestilence"] = 50842,
	["Pillar of Frost"] = 51271,
	["Plague Leech"] = 123693,
	["Plague Strike"] = 45462,
	["Raise Dead"] = 46584,
	["Rune Strike"] = 56815,
	["Rune Tap"] = 48982,
	["Runic Corruption"] = 51462,
	["Scarlet Fever"] = 81132,
	["Scent of Blood"] = 50421,
	["Scourge Strike"] = 55090,
	["Soul Reaper - Frost"] = 130735,
	["Soul Reaper - Unholy"] = 130736,
	["Shadow Infusion"] = 91342,
	["Strangulate"] = 47476,
	["Sudden Doom"] = 81340,
	["Summon Gargoyle"] = 49206,
	["Unholy Blight"] = 115989,
	["Unholy Frenzy"] = 49016,
	["Unholy Presence"] = 48265,
	["Vampiric Blood"] = 55233,
	
	-- Items
}

a.TalentIDs = {
	["Plague Leech"] = 123693,
	["Death Pact"] = 48743,
	["Death Siphon"] = 108196,
	["Blood Tap"] = 45529,
	["Runic Empowerment"] = 81229,
	["Runic Corruption"] = 51462,
}

a.GlyphIDs = {
	["Icebound Fortitude"] = 58673,
	["Loud Horn"] = 146646,
}

a.EquipmentSets = {
	BloodT14 = {
	    HeadSlot = { 86656, 85316, 86920 },
	    ShoulderSlot = { 86654, 85314, 86922 },
	    ChestSlot = { 86658, 85318, 86918 },
	    HandsSlot = { 86657, 85317, 86919 },
	    LegsSlot = { 86655, 85315, 86921 },
	},
	DpsT15 = {
	    HeadSlot = { 95827, 96571, 95227 },
	    ShoulderSlot = { 95829, 96573, 95229 },
	    ChestSlot = { 95825, 96569, 95225 },
	    HandsSlot = { 95826, 96570, 95226 },
	    LegsSlot = { 95828, 96572, 95228 },
	},
}
