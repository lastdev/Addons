local addonName, a = ...
local c = BittensGlobalTables.GetTable("BittensSpellFlashLibrary")

a.AddonName = addonName
c.Init(a)

a.SpellIDs = {
	["Blackout Kick"] = 100784,
	["Breath of Fire"] = 115181,
	["Brewmaster Training"] = 117967,
	["Chi Brew"] = 115399,
	["Chi Burst"] = 123986,
	["Chi Sphere"] = 121283,
	["Chi Wave"] = 115098,
	["Combo Breaker: Blackout Kick"] = 116768,
	["Combo Breaker: Tiger Palm"] = 118864,
	["Crackling Jade Lightning"] = 117952,
	["Dampen Harm"] = 122278,
	["Death Note"] = 121125,
	["Diffuse Magic"] = 122783,
	["Dizzying Haze"] = 123727,
	["Elusive Brew Stacker"] = 128939,
	["Elusive Brew"] = 115308,
	["Energizing Brew"] = 115288,
	["Enveloping Mist"] = 124682,
	["Expel Harm"] = 115072,
	["Fists of Fury"] = 113656,
	["Flying Serpent Kick 1"] = 101545,
	["Flying Serpent Kick 2"] = 115057,
	["Fortifying Brew"] = 115203,
	["Guard"] = 115295,
	["Healing Elixirs"] = 122280,
	["Heavy Stagger"] = 124273,
	["Invoke Xuen, the White Tiger"] = 123904,
	["Jab"] = 100780,
	["Keg Smash"] = 121253,
	["Legacy of the Emperor"] = 115921,
	["Legacy of the White Tiger"] = 116781,
	["Light Stagger"] = 124275,
	["Mana Tea"] = 123761,
	["Moderate Stagger"] = 124274,
	["Momentum"] = 119085,
	["Muscle Memory"] = 139598,
	["Power Guard"] = 118636,
	["Power Strikes"] = 129914,
	["Provoke"] = 115546,
	["Purifying Brew"] = 119582,
	["Renewing Mist"] = 115151,
	["Rising Sun Kick"] = 107428,
	["Roll"] = 109132,
	["Rushing Jade Wind"] = 116847,
	["Serpent's Zeal"] = 127722,
	["Shuffle"] = 115307,
	["Soothing Mist"] = 115175,
	["Spear Hand Strike"] = 116705,
	["Spinning Crane Kick"] = 101546,
	["Stance of the Fierce Tiger"] = 103985,
	["Stance of the Sturdy Ox"] = 115069,
	["Stance of the Wise Serpent"] = 115070,
	["Summon Black Ox Statue"] = 115315,
	["Summon Jade Serpent Statue"] = 115313,
	["Surging Mist"] = 116694,
	["Tiger Palm"] = 100787,
	["Tiger Power"] = 125359,
	["Tigereye Brew Stacker"] = 125195,
	["Tigereye Brew"] = 116740,
	["Touch of Death"] = 115080,
	["Uplift"] = 116670,
	["Vital Mists"] = 118674,
	["Zen Meditation"] = 115176,
	["Zen Sphere"] = 124081,
}

a.TalentIDs = {
	["Momentum"] = 119085,
	["Power Strikes"] = 121817,
	["Healing Elixirs"] = 122280,
}

a.GlyphIDs = {
	["Uplift"] = 125669,
	["Fortifying Brew"] = 124997,
	["Mana Tea"] = 123763,
}

a.EquipmentSets = {
}
