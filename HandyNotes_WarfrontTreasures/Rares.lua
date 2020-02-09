local myname, ns = ...

local merge = ns.merge
local path = ns.path

merge(ns.points[14], { --Arathi
    --World Boss
    [38804140] = {quest=52848, npc=137374,}, -- The Lion's Roar
    [38804140] = {quest=52847, npc=138122,}, -- Doom's Howl

	--Mounts
	[65906790] = {quest=nil, npc=142709, item=163644,}, -- Beastrider Kama
	[56604450] = {quest=nil, npc=142312, item=163645,}, -- Skullripper
	[67406120] = {quest=nil, npc=142692, item=163706,}, -- Nimar the Slayer
	[33003860] = {quest=nil, npc=132074, item=163646,}, -- Overseer Krix
	[49004000] = {quest=nil, npc=142739, item=163578,note="Spawns when Horde have control?"}, -- Knight-Captain Aldrin
	[53805820] = {quest=nil, npc=142741, item=163579,note="Spawns when Alliance have control?"}, -- Doomrider Helgrim

	--Toys
	[47607790] = {quest=nil, npc=132965, item=163775,}, -- Molok the Crusher
	[28904550] = {quest=nil, npc=142684, item=163750,}, -- Kovork
	[62808080] = {quest=nil, npc=142682, item=163745,}, -- Zalas Witherbark
    [48908430] = {quest=nil, npc=135058, item=163744,}, -- Kor'gresh Coldrage
    [43005700] = {quest=nil, npc=142683, item=163741,}, -- Ruul Onestone
    [51224018] = {quest=nil, npc=142690, item=163738,}, -- Singer
    [26703260] = {quest=nil, npc=142725, item=163736,}, -- Horrific Apparition 1
    [19506090] = {quest=nil, npc=142725, item=163736,}, -- Horrific Apparition 2
    [23104670] = {quest=nil, npc=142686, item=163735,}, -- Foulbelly
    [79603030] = {quest=nil, npc=142662, item=163713,}, -- Geomancer Flintdagger

    --Pets
    [21532120] = {quest=nil, npc=126427, item=163650,}, -- Branchlord Aldrus
    [36906600] = {quest=nil, npc=142361, item=163690,}, -- Plaguefeather
    [42006100] = {quest=nil, npc=126462, item=163711,note="Patrols the roads"}, -- Fozruk
    [56705410] = {quest=nil, npc=142301, item=163648,}, -- Venomarus
    [18302760] = {quest=nil, npc=142321, item=163689,}, -- Ragebeak
    [14003690] = {quest=nil, npc=142251, item=163684,}, -- Yogursa
    [52207660] = {quest=nil, npc=142716, item=163712,}, -- Man-Hunter Rog
    [56603600] = {quest=nil, npc=141668, item=163677,}, -- Echo of Myzrael
    [50653690] = {quest=nil, npc=142688, item=163652,}, -- Darbel Montrose

    --Goliaths
    [61933150] = {quest=nil, npc=141618, item=163700,}, -- Cresting Goliath
    [45805280] = {quest=nil, npc=141616, item=163698,}, -- Thundering Goliath
    [29905960] = {quest=nil, npc=140765, item=163701,}, -- Rumbling Goliath
    [30604500] = {quest=nil, npc=141615, item=163691,}, -- Burning Goliath
})