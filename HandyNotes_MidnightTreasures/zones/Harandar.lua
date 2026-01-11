local myname, ns = ...

--[[ TODO:
From the Cradle to the Grave: 61860
Oh, No You Don't!: 61861
More Than Just Their Roots: 62188

-- Altars
altar of vigor @ 47175314, huntress spirit 254104
lost hunting knife 257024 @ 45105412
returned to altar: 93145

altar of innocence @ 51134751, child-like spirit 254030
a tattered ball 256882 @ 51085048
returned to altar: 93130
]]

local HARATI = ns.rewards.Currency(ns.CURRENCY_HARATI, 50)

-- Treasure

ns.RegisterPoints(ns.HARANDAR, {
	[71693101] = {criteria=109033, quest=92424, loot={{258963, toy=true}, HARATI}, vignette=7308}, -- Failed Shroom Jumper's Satchel
	[47085027] = {criteria=109034, quest=92426, loot={258900, ns.rewards.Currency(ns.CURRENCY_VOIDLIGHT, 150), HARATI}, vignette=7309}, -- Burning Branch of the World Tree, Charred World Tree Branch
	[73666536] = {criteria=109035, quest=92427, loot={263289, HARATI}, vignette=7311}, -- Sporelord's Fight Prize, Sporelord's Authority
	[62915125] = {criteria=109036, quest=92431, loot={263287, HARATI}, vignette=7312}, -- Reliquary's Lost Paintbrush, Reliquary-Keeper's Lost Shortbow
	[55633942] = {criteria=109037, quest=92436, loot={{258903, pet=true}, HARATI}, vignette=7313}, -- Kemet's Simmering Cauldron, Percival
	-- [] = {criteria=110254, quest=93144, loot={{259084, toy=true}, HARATI}, vignette=7351}, -- Gift of the Cycle
	[26736759] = { -- Impenatrably Sealed Gourd
		criteria=110255, quest=93508,
		loot={{260730, pet=true}, HARATI}, -- Perturbed Sporebat
		note="Collect {item:260250:Mysterious Purple Fluid}, {item:260251:Mysterious Red Fluid}, combine in the Durable Vase, use to open the Gourd",
		vignette=7394,
	},
	-- [] = {criteria=110256, quest=93650, loot={{256423, mount=true}, HARATI}, vignette=7411}, -- Sporespawned Cache, Untainted Grove Crawler
	[40642802] = {criteria=110257, quest=93587, loot={{252017, mount=true}, HARATI}, vignette=7410, note="Gather 150x {item:260531:Crystallized Resin Fragment} in the water nearby"}, -- Peculiar Cauldron, Ruddy Sporeglider
}, {
	achievement=61263,
})

-- Rares

-- Leaf None Behind
ns.RegisterPoints(ns.HARANDAR, {
	[51174530] = { -- Rhazul
		criteria=109039, quest=91832, -- 94712
		npc=248741,
		loot={
			264530, -- Grimfur Mittens
		},
		vignette=7139,
	},
	[68014033] = { -- Chironex
		criteria=109040, quest=92137, -- 94713
		npc=249844,
		loot={
			264538, -- Translucent Membrane Slippers
		},
		vignette=7156,
	},
	[67696228] = { -- Ha'kalawe
		criteria=109041, quest=92142, -- 94714
		npc=249849,
		loot={
			252957, -- Tangle of Vibrant Vines
			264553, -- Deepspore Leather Galoshes
			264592, -- Ka'kalawe's Flawless Wing
		},
		note="Wanders",
		vignette=7157,
	},
	[72636926] = { -- Tallcap the Truthspreader
		criteria=109042, quest=92148, -- 94715
		npc=249902,
		loot={
			264650, -- Truthspreader's Truth Spreader
		},
		vignette=7158,
	},
	[60104701] = { -- Queen Lashtongue
		criteria=109043, quest=92154, -- 94716
		npc=249962,
		loot={
			251782, -- Withered Saptor's Paw
			264895, -- Trials of the Florafaun Hunter
		},
		vignette=7159,
	},
	[64904810] = { -- Chlorokyll
		criteria=109044, quest=92161, -- 94717
		npc=249997,
		loot={
			264626, -- Scepter of Radiant Conversion
		},
		vignette=7161,
	},
	[65653279] = { -- Stumpy
		criteria=109045, quest=92168,
		npc=250086,
		loot={
			264635, -- Stumpy's Stump
			264578, -- Stumpy's Terrorplate
		},
		vignette=7162,
	},
	[56783422] = { -- Serrasa
		criteria=109046, quest=92170,
		npc=250180,
		loot={
			264568, -- Serrated Scale Gauntlets
		},
		vignette=7163,
	},
	[46353284] = { -- Mindrot
		criteria=109047, quest=92172, -- 94720
		npc=250226,
		loot={
			264649, -- Mindrot Claw-Hammer
		},
		vignette=7164,
	},
	[40654299] = { -- Dracaena
		criteria=109048, quest=92176, -- 94721
		npc=250231,
		loot={
			264562, -- Plated Grove Vest
			264644, -- Crawler's Mindscythe
		},
		vignette=7165,
	},
	[36597516] = { -- Treetop
		criteria=109049, quest=92183, -- 94722
		npc=250246,
		loot={
			-- {246735,mount=true,}, -- Rootstalker Grimlynx (all zone rares?)
			264633, -- Treetop Battlestave
			264968, -- Telluric Leyblossom
			264581, -- Bloombark Spaulders
		},
		vignette=7166,
	},
	[28118181] = { -- Oro'ohna
		criteria=109050, quest=92190,
		npc=250317,
		loot={
			264591, -- Radiant Petalwing's Feather
			264616, -- Lightblighted Sapdrinker
		},
		vignette=7167,
	},
	[27197021] = { -- Pterrock
		criteria=109051, quest=92191, -- 94724
		npc=250321,
		loot={
			259896, -- Bark of the Guardian Tree
			264576, -- Slatescale Grips
		},
		vignette=7168,
	},
	[39696070] = { -- Ahl'ua'huhi
		criteria=109052, quest=92193, -- 94725
		npc=250347,
		loot={
			264534, -- Bogvine Shoulderguards
			264540, -- Mirevine Wristguards
		},
		vignette=7171,
	},
	[44501610] = { -- Annulus the Worldshaker
		criteria=109053, quest=92194,
		npc=250358,
		vignette=7172,
	},
}, {
	achievement=61264,
})
