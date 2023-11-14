local AddonInfo = {...};
_G[AddonInfo[1]] = _G[AddonInfo[1]] or {};

_G[AddonInfo[1]].UntradableMatsIDs = {
	-- Genesis Mote
	188957,

	-- Pet Mats
	189157, 189158, 189159, 189160, 189161, 189162, 189163, 189164, 189165, 189166, 189167, 189168, 189169, 189170,

	-- Mount Mats
	189171, 189172, 189173, 189174, 189175, 189176, 189177, 189178, 189179, 189180,
};

_G[AddonInfo[1]].TradableMatsIDs = {
	-- Lattice
	187634, 187636, 187633, 187635, 189146, 189145, 189147, 190388, 189148,189149, 189150, 189151, 189152, 189153, 189154, 189155, 189156,
};

-- [itemID] = {posX, posY, cost}
_G[AddonInfo[1]].CollectionItems = {
	-- Pet
	[189369] = { 1,  5, 300}, -- [Archetype of Animation]
	[187734] = { 1, 14, 350}, -- [Omnipotential Core]
	[189380] = { 2, 16, 300}, -- [Archetype of Cunning]
	[187798] = { 2, 17, 350}, -- [Tunneling Vombata]
	[189373] = { 3,  2, 450}, -- [Prototickles]
	[187795] = { 3, 17, 300}, -- [Archetype of Discovery]
	[189363] = { 4,  1, 250}, -- [Ambystan Darter]
	[187713] = { 4, 14, 300}, -- [Archetype of Focus]
	[189383] = { 5, 15, 300}, -- [Archetype of Malice]
	[189366] = { 5,  9, 200}, -- [Violent Poultrid]
	[187928] = { 6,  1, 300}, -- [Archetype of Metamorphosis]
	[189370] = { 6,  5, 400}, -- [Stabilized Geomental]
	[187803] = { 7, 10, 300}, -- [Archetype of Motion]
	[189365] = { 7, 12, 400}, -- [Fierce Scarabid]
	[189375] = { 8,  7, 300}, -- [Archetype of Multiplicity]
	[189368] = { 8,  9, 350}, -- [Multichicken]
	[189372] = { 9,  2, 400}, -- [Terror Jelly]
	[189381] = { 9, 13, 300}, -- [Archetype of Predation]
	[189371] = {10,  2, 300}, -- [Archetype of Renewal]
	[189374] = {10,  7, 250}, -- [Leaping Leporid]
	[189376] = {11,  6, 150}, -- [Microlicid]
	[189367] = {11,  9, 300}, -- [Archetype of Satisfaction]
	[189382] = {12,  3, 300}, -- [Archetype of Serenity]
	[189378] = {12,  6, 400}, -- [Shelly]
	[189364] = {13, 12, 300}, -- [Archetype of Survival]
	[187733] = {13, 14, 250}, -- [Resonant Echo]
	[189377] = {14,  6, 300}, -- [Archetype of Vigilance]
	[189379] = {14, 16, 150}, -- [Viperid Menace]

	-- Mount
	[187683] = {15,  3, 400}, -- [Goldplate Bufonid]
	[187677] = {15, 13, 400}, -- [Genesis Crawler]
	[187669] = {16,  6, 500}, -- [Serenade]
	[190580] = {16,  8, 500}, -- [Heartbond Lupine]
	[187630] = {16, 17, 400}, -- [Curious Crystalsniffer]
	[187668] = {17, 11, 450}, -- [Raptora Swooper]
	[187664] = {17, 15, 450}, -- [Forged Spiteflyer]
	[188810] = {18,  3, 350}, -- [Russet Bufonid]
	[187632] = {18, 17, 450}, -- [Adorned Vombata]
	[187641] = {19,  4, 300}, -- [Reins of the Sundered Zerethsteed]
	[187667] = {19, 11, 350}, -- [Mawdapted Raptora]
	[187631] = {19, 17, 450}, -- [Darkened Vombata]
	[187665] = {20, 15, 500}, -- [Buzz]
	[187639] = {20,  4, 400}, -- [Pale Regal Cervid]
	[187679] = {20, 13, 500}, -- [Ineffable Skitterer]
	[187672] = {21,  6, 350}, -- [Scarlet Helicid]
	[187678] = {21, 13, 450}, -- [Tarachnid Creeper]
	[188809] = {22,  3, 350}, -- [Prototype Leaper]
	[187638] = {22,  4, 450}, -- [Deathrunner]
	[187671] = {22,  6, 300}, -- [Unsuccessful Prototype Fleetpod]
	[187670] = {23,  6, 400}, -- [Bronze Helicid]
	[187663] = {23, 15, 350}, -- [Bronzewing Vespoid]
	[187666] = {24, 11, 400}, -- [Desertwing Hunter]
	[187660] = {24, 15, 400}, -- [Vespoid Flutterer]
};

-- [itemID] = {questItemID, questID}
_G[AddonInfo[1]].QuestItems = {
	-- Pet
	[189363] = {189418, 65327}, -- Ambystan Darter
	[189365] = {189434, 65332}, -- Fierce Scarabid
	[189374] = {189444, 65357}, -- Leaping Leporid
	[189376] = {189445, 65358}, -- Microlicid
	[189368] = {189435, 65333}, -- Multichicken
	[187734] = {189440, 65348}, -- Omnipotential Core
	[189373] = {189442, 65354}, -- Prototickles
	[187733] = {189441, 65351}, -- Resonant Echo
	[189378] = {189446, 65359}, -- Shelly
	[189370] = {189437, 65336}, -- Stabilized Geomental
	[189372] = {189443, 65355}, -- Terror Jelly
	[187798] = {189448, 65361}, -- Tunneling Vombata
	[189366] = {189436, 65334}, -- Violent Poultrid
	[189379] = {189447, 65360}, -- Viperid Menace

	-- Mount
	[187632] = {189478, 65401}, -- Adorned Vombata
	[187670] = {189462, 65385}, -- Bronze Helicid
	[187663] = {189473, 65396}, -- Bronzewing Vespoid
	[187665] = {189474, 65397}, -- Buzz
	[187630] = {189476, 65399}, -- Curious Crystalsniffer
	[187631] = {189477, 65400}, -- Darkened Vombata
	[187638] = {189457, 65380}, -- Deathrunner
	[187666] = {189458, 65381}, -- Desertwing Hunter
	[187664] = {189475, 65398}, -- Forged Spiteflyer
	[187677] = {189465, 65388}, -- Genesis Crawler
	[187683] = {189468, 65391}, -- Goldplate Bufonid
	[190580] = {190585, 65680}, -- Heartbond Lupine
	[187679] = {189467, 65390}, -- Ineffable Skitterer
	[187667] = {189459, 65382}, -- Mawdapted Raptora
	-- [187639] = {189455, 65375}, -- Pale Regal Cervid
	[188809] = {189469, 65393}, -- Prototype Leaper
	[187668] = {189460, 65383}, -- Raptora Swooper
	[188810] = {189471, 65394}, -- Russet Bufonid
	[187672] = {189464, 65387}, -- Scarlet Helicid
	[187669] = {189461, 65384}, -- Serenade
	[187641] = {189456, 65379}, -- Sundered Zerethsteed
	[187678] = {189466, 65389}, -- Tarachnid Creeper
	[187671] = {189463, 65386}, -- Unsuccessful Prototype Fleetpod
	[187660] = {189472, 65395}, -- Vespoid Flutterer
};

