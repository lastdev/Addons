local myname, ns = ...

local LORE = {
    achievement=62104,
    texture=ns.atlas_texture("loreobject-32x32", {r=1, g=1, b=0}),
    -- minimap=true,
}

-- All get 250 silvermoon court rep
ns.RegisterPoints(ns.EVERSONGWOODS, {
	[50524347] = {criteria=111830, quest=93564, vignette=7407}, -- Mirveda's Notes
	[47958820] = {criteria=111828, quest=91841, vignette=7141}, -- Memorial Plaque
	[37601378] = {criteria=111829, quest=93563, vignette=7406}, -- Shrine of Dath'remar
	[36057251] = {criteria=111831, quest=93565, vignette=7408, note="Upper floor",}, -- Profane Research
	[57815092] = {criteria=111832, quest=93562, vignette=7405}, -- Hawkstrider Husbandry: Unabridged Edition
}, LORE)
ns.RegisterPoints(ns.SILVERMOONCITY, {
	[38107699] = {criteria=111833, quest=93570, vignette=7409, parent=true}, -- Unfinished Sheet Music
}, LORE)

-- All get 250 Amani Tribe rep
ns.RegisterPoints(ns.ZULAMAN, {
	[53118211] = {criteria=111772, quest=94627, vignette=7487}, -- Tablet of Akil'zon
	[32083165] = {criteria=111773, quest=94628, vignette=7488}, -- Tablet of Halazzi
	[55121761] = {criteria=111774, quest=94631, vignette=7489}, -- Tablet of Jan'alai
	[30168466] = {criteria=111775, quest=94632, vignette=7490}, -- Tablet of Nalorakk
	[37502669] = {criteria=111776, quest=94633, vignette=7491}, -- Tablet of the Ruling Family
	[39274472] = {criteria=111777, quest=94673, vignette=7492}, -- Tablet of Kulzi
	[52933212] = {criteria=111778, quest=94674, vignette=7493}, -- Tablet of Filo
}, LORE)

ns.RegisterPoints(ns.HARANDAR, {
	[55675403] = {criteria=111823, quest=93554, vignette=7398}, -- Tarnished Mural
	[33346085] = {criteria=111824, quest=93556, vignette=7400}, -- Ancient Runestone
	[72453809] = {criteria=111825, quest=93557, vignette=7401}, -- Derelict Mural
	[68212380] = {criteria=111826, quest=93558, vignette=7402, note="Behind the tent"}, -- Forgotten Mural
	[47614723] = {criteria=111827, quest=93559, vignette=7403}, -- A Frayed Scroll
}, LORE)

ns.RegisterPoints(ns.VOIDSTORM, {
	[63427822] = {criteria=111834, quest=94389, vignette=7448}, -- Void Armor
	[50328768] = {criteria=111835, quest=94394, vignette=7449}, -- Ancient Tablet
	[40485863] = {criteria=111836, quest=94395, vignette=7450}, -- Abandoned Telescope
	[60394548] = {criteria=111837, quest=94397, vignette=7451}, -- Tattered Page
	[27835402] = {criteria=111838, quest=94398, vignette=7452}, -- Shadowgraft Harness
}, LORE)
