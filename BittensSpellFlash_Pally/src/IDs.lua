local AddonName, a = ...
if a.BuildFail(50000) then return end

a.SpellIDs = {
	["Ardent Defender"] = 31850,
	["Avenger's Shield"] = 31935,
	["Avenging Wrath"] = 31884,
	["Bastion of Glory"] = 114637,
--	["Beacon of Light"] = 53563,
	["Blessing of Kings"] = 20217,
	["Blessing of Might"] = 19740,
	["Consecration"] = 26573,
	["Consecration Glyphed"] = 116467,
	["Crusader Strike"] = 35395,
--	["Daybreak"] = 88819,
--	["Divine Light"] = 82326,
--	["Divine Plea"] = 54428,
	["Divine Protection"] = 498,
	["Divine Purpose"] = 86172,
--	["Divine Storm"] = 53385,
	["Eternal Flame"] = 114163,
	["Exorcism"] = 879,
	["Glyphed Exorcism"] = 122032,
	["Flash of Light"] = 19750,
	["Grand Crusader"] = 98057,
	["Guardian of Ancient Kings"] = 86659,
	["Hammer of the Righteous"] = 53595,
	["Hammer of Wrath"] = 24275,
	["Hand of Reckoning"] = 62124,
	["Holy Avenger"] = 105809,
--	["Holy Radiance"] = 82327,
--	["Holy Shield"] = 20925,
--	["Holy Shock"] = 20473,
	["Holy Wrath"] = 119072,
--	["Infusion of Light"] = 54149,
	["Inquisition"] = 84963,
	["Judgment"] = 20271,
--	["Judgements of the Just"] = 20271,
--	["Judgements of the Pure"] = 53657,
--	["Light of Dawn"] = 85222,
	["Rebuke"] = 96231,
--	["Righteous Defense"] = 31789,
	["Righteous Fury"] = 25780,
	["Sacred Shield"] = 20925,
	["Seal of Insight"] = 20165,
--	["Seal of Justice"] = 20164,
--	["Seal of Righteousness"] = 20154,
	["Seal of Truth"] = 31801,
	["Selfless Healer"] = 114250,
	["Shield of the Righteous"] = 53600,
	["Templar's Verdict"] = 85256,
--	["The Art of War"] = 59578,
--	["Vindication"] = 35395,
	["Word of Glory"] = 85673,
	
	-- Items
	["Fire of the Deep"] = 77117,
	["Elusive"] = 107951, -- buff from the trinket Fire of the Deep
	["Veil of Lies"] = 102667, -- Buff from the trinket
	["Windwalk"] = 	74243, -- Buff from the weapon enchant
}

a.TalentIDs = {
	["Selfless Healer"] = 85804,
	["Holy Avenger"] = 105809,
	["Sanctified Wrath"] = 53376,
}

a.GlyphIDs = {
	["Divine Protection"] = 54924,
	["Holy Wrath"] = 54923,
	["Consecration"] = 54928,
	["Mass Exorcism"] = 122028,
	["Avenging Wrath"] = 54927,
}

a.EquipmentSets = {
	
}
