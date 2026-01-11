local myname, ns = ...

--[[ TODO:
Runestone Rush: 61961
Ever Painting: 62185
]]

local COURT = ns.rewards.Currency(ns.CURRENCY_SILVERMOONCOURT, 50)

-- Treasures

ns.RegisterPoints(ns.EVERSONGWOODS, {
	[38907607] = { -- Triple-Locked Safebox
		criteria=111472, quest=93456, loot={{243106, decor=true}, COURT}, vignette=7365, -- Gemmed Eversong Lantern
		note="Pick up the torch, and find three keys in the village",
		related={
			[37637481] = {loot={258768},minimap=true, requires=ns.conditions.AuraActive(1263972),}, -- Battered Safebox Key
			[38467346] = {loot={258769}, minimap=true, requires=ns.conditions.AuraActive(1263972),}, -- Worn Safebox Key
			[40257582] = {loot={258770}, minimap=true, requires=ns.conditions.AuraActive(1263972),}, -- Tarnished Safebox Key
			color={r=0.6,g=0.6,b=1},
		},
	},
	[40961945] = { -- Gift of the Phoenix
		criteria=111473, quest=93544, -- 93545 for placing
		loot={{263211, decor=true}, COURT}, -- Gilded Eversong Cup
		note="Take {spell:1264567:Sunstrider Vessel}, catch 5x{spell:1264565:Phoenix Cinders}",
		vignette=7395,
	},
	[43286948] = {criteria=111474, quest=93893, loot={{262616, decor=true}, COURT}, vignette=7424, note="Upper floor",}, -- Forgotten Ink and Quill
	[44624555] = {criteria=111475, quest=93908, loot={265828, COURT}, vignette=7429, note="Upper floor",}, -- Gilded Armillary Sphere
	[52344543] = {criteria=111476, quest=93455, loot={265814, COURT}, vignette=7364, note="Ground floor",}, -- Antique Nobleman's Signet Ring
	[60696729] = {criteria=111477, quest=93457, loot={265816, COURT}, vignette=7366,}, -- Farstrider's Lost Quiver
	[40446090] = {criteria=111478, quest=93061, loot={{251912, decor=true}, COURT}, vignette=7344, note="On floating platform; pick 10x{item:256232:Bunch of Ripe Grapes}, then get {item:256397:Packet of Instant Yeast} from {npc:251405:Sheri} nearby"}, -- Stone Vat of Wine (also: 86645)
	[48747544] = {criteria=111479, quest=91358, loot={{246314, pet=4974}, COURT}, vignette=7041,}, -- Burbling Paint Pot
}, {
	achievement=61960,
})
ns.RegisterPoints(ns.SILVERMOONCITY, {
	[24346928] = { -- Rookery Cache
		criteria=111471, quest=93967, -- 94626 for giving the meat
		loot={{267838, pet=true}, COURT}, -- Sunwing Hatchling
		note="In floating building; buy {item:265674:Tasty Meat} from {npc:258550:Farstrider Aerieminder}, give it to the {npc:257049:Mischevious Chick}; may need to relog to be able to place it",
		vignette=7437,
	},
}, {
	achievement=61960,
	parent=true,
})

ns.RegisterPoints(ns.SILVERMOONCITY, {
	[37805238] = { -- Incomplete Book of Sonnets
		label="{item:265832:Incomplete Booklet of Sonnets}",
		quest=94781,
		loot={{245282, decor=true}}, -- Silvermoon Library Bookcase
		related={
			[40768843] = {loot={265833}, minimap=true, inbag={265833, 265832, any=true}, note="Lower level, on a bridge"}, -- Page 1
			[33299019] = {loot={265834}, minimap=true, inbag={265834, 265832, any=true}, note="Lower level"}, -- Page 2
			[39828048] = {loot={265835}, minimap=true, inbag={265835, 265832, any=true},}, -- Page 3
		},
		vignette=7499,
	},
}, {
	parent=true,
})


-- Rares

-- A Bloody Song
ns.RegisterPoints(ns.EVERSONGWOODS, {
	[52627532] = { -- Warden of Weeds
		criteria=110166, quest=91280, -- 94681
		npc=246332,
		loot={
			264520, -- Warden's Leycrook
			264613, -- Steelbark Bulwark
		},
		vignette=7363,
	},
	[45097760] = { -- Harried Hawkstrider
		criteria=110167, quest=91315,
		npc=246633,
		loot={
			-- 251791, -- Holy Retributor's Order
			264521, -- Striderplume Focus
			264522, -- Striderplume Armbands
			258912, -- Tarnished Dawnlit Spellbinder's Robe
		},
		vignette=7002,
		note="Runs around nearby",
	},
	[54806020] = { -- Overfester Hydra
		criteria=110168, quest=92392,
		npc=240129,
		loot={
			-- 251791, -- Holy Retributor's Order
			264523, -- Hydrafang Blade
			264524, -- Lightblighted Verdant Vest
		},
	},
	[36566407] = { -- Bloated Snapdragon
		criteria=110169, quest=92366, -- 94685
		npc=250582,
		loot={
			-- 251788, -- Gift of Light
			264543, -- Snapdragon Pantaloons
			264560, -- Sharpclaw Gauntlets
			260647, -- Digested Human Hand
		},
		vignette=7294,
	},
	[62964878] = { -- Cre'van
		criteria=110170, quest=92391,
		npc=250719,
		loot={
			-- 251791, -- Holy Retributor's Order
			264573, -- Taskmaster's Sadistic Shoulderguards
			264647, -- Cre'van's Punisher
			265803, -- Bazaar Bites
		},
		vignette=7299, -- Cre'van, Cruel Taskmaster
		note="Wanders the camp a bit",
	},
	[36333636] = { -- Coralfang
		criteria=110171, quest=92389,
		npc=250683,
		loot={
			264602, -- Abyss Coral Band
			264629, -- Coralfang's Hefty Fin
		},
		vignette=7298,
	},
	[36657719] = { -- Lady Liminus
		criteria=110172, quest=92393, -- 94688
		npc=250754,
		loot={
			-- 251791, -- Holy Retributor's Order
			264612, -- Tarnished Gold Locket
			264645, -- Aged Farstrider Bow
			260655, -- Decaying Humanoid Flesh
		},
		vignette=7301,
	},
	[40408532] = { -- Terrinor
		criteria=110173, quest=92409,
		npc=250876,
		loot={
			264537, -- Winged Terror Gloves
			264546, -- Bat Fur Boots
		},
		vignette=7306,
	},
	[49048777] = { -- Bad Zed
		criteria=110174, quest=92404, -- 94690
		npc=250841,
		loot={
			-- 251791, -- Holy Retributor's Order
			-- 251788, -- Gift of Light
			264621, -- Bad Zed's Worst Channeler
			265803, -- Bazaar Bites
		},
		vignette=7305,
	},
	[34812098] = { -- Waverly
		criteria=110175, quest=92395,
		npc=250780, -- 250788 for Lovely Sunflower
		loot={
			-- 251788, -- Gift of Light
			260694, -- Foul Kelp
			264608, -- String of Lovely Blossoms
			264910, -- Shell-Cleaving Poleaxe
		},
		vignette=7302,
	},
	[56427760] = { -- Banuran
		criteria=110176, quest=92403, -- 94692
		npc=250826,
		loot={
			-- 251788, -- Gift of Light
			264526, -- Supremely Slimy Sash
			264552, -- Frogskin Grips
			-- 265027, -- Lucky Lynx Locket
		},
		vignette=7304,
	},
	[59107924] = { -- Lost Guardian
		criteria=110177, quest=92399, -- 94693
		npc=250806,
		loot={
			264555, -- Splintered Hexwood Clasps
			264575, -- Hexwood Helm
		},
		vignette=7303,
	},
	[42176897] = { -- Duskburn
		criteria=110178, quest=93550, -- 94694
		npc=255302,
		loot={
			264569, -- Void-Gorged Kickers
			264594, -- Netherscale Cloak
		},
		vignette=7396,
	},
	[51694601] = { -- Malfunctioning Construct
		criteria=110179, quest=93555,
		npc=255329,
		loot={
			264584, -- Stonecarved Smashers
			264603, -- Guardian's Gemstone Loop
		},
		vignette=7399,
	},
	[44573817] = { -- Dame Bloodshed
		criteria=110180, quest=93561, -- 94696
		npc=255348,
		loot={
			-- 251788, -- Gift of Light
			-- 251791, -- Holy Retributor's Order
			264595, -- Lynxhide Shawl
			264624, -- Fang of the Dame
		},
		note="Wanders",
		vignette=7404,
	},
}, {
	achievement=61507,
})
