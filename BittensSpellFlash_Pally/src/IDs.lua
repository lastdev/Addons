local AddonName, a = ...
if a.BuildFail(40000, 50000) then return end

a.SpellIDs = {
    ["Ardent Defender"] = 31850,
    ["Avenger's Shield"] = 31935,
    ["Avenging Wrath"] = 31884,
    ["Beacon of Light"] = 53563,
    ["Blessing of Kings"] = 20217,
    ["Blessing of Might"] = 19740,
    ["Concentration Aura"] = 19746,
    ["Consecration"] = 26573,
    ["Crusader Aura"] = 32223,
    ["Crusader Strike"] = 35395,
    ["Daybreak"] = 88819,
    ["Devotion Aura"] = 465,
    ["Divine Light"] = 82326,
    ["Divine Plea"] = 54428,
    ["Divine Protection"] = 498,
    ["Divine Purpose"] = 88675, -- *
    ["Divine Storm"] = 53385,
    ["Elusive"] = 107951, -- buff from the trinket Fire of the Deep
    ["Exorsism"] = 879,
    ["Flash of Light"] = 19750,
    ["Grand Crusader"] = 98057,
    ["Guardian of Ancient Kings"] = 86150,
    ["Hammer of the Righteous"] = 53595,
    ["Hammer of Wrath"] = 24275,
    ["Hand of Reckoning"] = 62124,
    ["Holy Radiance"] = 82327,
    ["Holy Shield"] = 20925,
    ["Holy Shock"] = 20473,
    ["Holy Wrath"] = 2812,
    ["Holy Wrath"] = 2812,
    ["Infusion of Light"] = 54149,
    ["Inquisition"] = 84963,
    ["Judgement"] = 20271,
    ["Judgements of the Just"] = 20271,
    ["Judgements of the Pure"] = 53657,
    ["Light of Dawn"] = 85222,
    ["Rebuke"] = 96231,
    ["Resistance Aura"] = 19891,
    ["Retribution Aura"] = 7294,
    ["Righteous Defense"] = 31789,
    ["Righteous Fury"] = 25780,
    ["Seal of Insight"] = 20165,
    ["Seal of Justice"] = 20164,
    ["Seal of Righteousness"] = 20154,
    ["Seal of Truth"] = 31801,
    ["Shield of the Righteous"] = 53600,
    ["Templar's Verdict"] = 85256,
    ["The Art of War"] = 59578,
    ["Veil of Lies"] = 102667, -- Buff from the trinket
    ["Vindication"] = 35395,
    ["Virtuous Empowerment"] = 105767, -- Energize from ret 2pt13
    ["Windwalk"] = 	74243, -- Buff from the weapon enchant
    ["Word of Glory"] = 85673,
    ["Zealotry"] = 85696,
	
	-- Items
    ["Fire of the Deep"] = 77117,
}

a.TalentIDs = {
	
	-- Holy
	["Judgements of the Pure"] = 54151,
	["Tower of Radiance"] = 85512,
	
	-- Protection
	["Judgements of the Just"] = 53695,
	["Vindication"] = 26016,
	
	-- Retribution
	["Divine Storm"] = 53385,
}

a.GlyphIDs = {
	
}

a.EquipmentSets = {
    ProtT13 = {
	    HeadSlot = { 78790, 77005, 78695 },
	    ShoulderSlot = { 78840, 77007, 78745 },
	    ChestSlot = { 78827, 77003, 78732 },
	    HandsSlot = { 78772, 77004, 78677 },
	    LegsSlot = { 78810, 77006, 78715 },
	},
	RetT13 = {
	    HeadSlot = { 78788, 76876, 78693 },
	    ShoulderSlot = { 78837, 76878, 78742 },
	    ChestSlot = { 78822, 76874, 78727 },
	    HandsSlot = { 78770, 76875, 78675 },
	    LegsSlot = { 78807, 76877, 78712 },
	},
}
