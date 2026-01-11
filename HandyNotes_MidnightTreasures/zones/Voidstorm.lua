local myname, ns = ...

local SINGULARITY = ns.rewards.Currency(ns.CURRENCY_SINGULARITY, 50)

ns.RegisterPoints(ns.VOIDSTORM, {
	[49947936] = { -- Final Clutch of Predaxas
		criteria=111863, quest=93237,
		loot={{257446, mount=true}, SINGULARITY}, -- Reins of the Insatiable Shredclaw
		vignette=7355, path=48927833
	},
	[25766728] = { -- Void-Shielded Tomb
		criteria=111864, quest=92414,
		loot={246951, SINGULARITY}, -- Stormarion Core x20
		note="Drink the potion, then fetch {item:251519:Key of Fused Darkness} from the adjacent building",
		nearby={25976863, worldmap=false, label="{item:251519:Key of Fused Darkness}"},
		vignette=7498,
	},
	[64537547] = { -- Bloody Sack
		criteria=111866, quest=93431,
		loot={{267139, toy=true}, SINGULARITY}, -- Hungry Black Hole
		note="Feed it meat",
		vignette=7359, -- Forgotten Oubliette, then 7360 Bloody Sack
	},
	[53364266] = { -- Malignant Chest
		criteria=111867, quest=93840,
		loot={{264482, decor=true}},
		vignette=7418,
		related={
			[53474321] = {quest=93812}, -- 1
			[52944333] = {quest=93813, hide_before=ns.conditions.QuestComplete(93812)}, -- 2
			[53534388] = {quest=93814, hide_before=ns.conditions.QuestComplete(93813)}, -- 3
			[53234271] = {quest=93815, hide_before=ns.conditions.QuestComplete(93814)}, -- 4
			texture=ns.atlas_texture("playerpartyblip", {r=0.4, g=0, b=1}), worldmap=false, minimap=true,
		},
	},
	[46927989] = {criteria=111869, quest=94454, loot={{250319, toy=true}, SINGULARITY}, vignette=7455, path=47987850}, -- Forgotten Researcher's Cache, Researcher's Shadowgraft
	[55367542] = {criteria=111871, quest=93553, loot={266075, SINGULARITY}, vignette=7397}, -- Embedded Spear, Harpoon of Extirpation
	[31514450] = {criteria=111872, quest=93500, loot={{266076, pet=true}, SINGULARITY}, vignette=7393}, -- Quivering Egg, Nether Siphoner
	[28337289] = {criteria=111873, quest=93498, loot={266099, SINGULARITY}, vignette=7392, note="Drink the potion, loot the sword"}, -- Exaliburn, Extinguished Exaliburn
	[35774141] = {criteria=111874, quest=93496, loot={266100, SINGULARITY}, vignette=7391}, -- Discarded Energy Pike, Barbed Riftwalker Dirk
	[43018194] = {criteria=111875, quest=93493, loot={266098, SINGULARITY}, vignette=7368}, -- Faindel's Quiver / Slain Scout's Quiver, Faindel's Longbow
	[37696976] = {criteria=111876, quest=93467, loot={{264303, pet=true}, SINGULARITY}, vignette=7367, path=38076874, note="In cave; on upper level"}, -- Half-Digested Viscera
}, {
	achievement=62126,
})
ns.RegisterPoints(2527, { -- Lair of Predaxas
	[23088392] = {criteria=111869, quest=94454, loot={{250319, toy=true}, SINGULARITY}, vignette=7455}, -- Forgotten Researcher's Cache, Researcher's Shadowgraft
}, {
	achievement=62126,
})
ns.RegisterPoints(ns.SLAYERSRISE, {
	[53203222] = { -- Stellar Stash
		criteria=111868, quest=93996, -- 94005 after pulling out
		loot={{262467, decor=true}, SINGULARITY}, -- Void Elf Round Table
		note="Inside the building; drag objects out 3x",
		vignette=7441,
	},
	[49052013] = {criteria=111870, quest=94387, loot={266101, SINGULARITY}, vignette=7447}, -- Scout's Pack, Unused Initiate's Bulwark
}, {
	achievement=62126,
	parent=true,
})

ns.RegisterPoints(ns.VOIDSTORM, {
	[24837001] = {
		quest=94742,
		label="Stormarion Cache", -- or "Void-hoarder's Corpse"
		loot={246951}, -- Stormarion Core x10
		vignette=7497,
	},
	[39306383] = {
		quest=91308,
		label="Lost Shadowstep Supplies",
		loot={208856}, -- Pocket Lint
		vignette=7000,
	},
})

-- Rares

-- The Ultimate Predator
ns.RegisterPoints(ns.VOIDSTORM, {
	[29515008] = { -- Sundereth the Caller
		criteria=111877, quest=90805, -- 94728
		npc=244272,
		loot={
			264619, -- Nethersteel Spellblade
			264539, -- Robes of the Voidcaller
		},
		vignette=6949,
	},
	[34028218] = { -- Territorial Voidscythe
		criteria=111878, quest=91050, -- 94729
		npc=238498,
		loot={
			264565, -- Voidscale Shoulderpads
			264642, -- Carving Voidscythe
		},
		vignette=6961,
	},
	[36308373] = { -- Tremora
		criteria=111879, quest=91048, -- 94730
		npc=241443,
		loot={
			251786, -- Ever-Collapsing Void Fissure
		},
		path=37498452, -- or 35678113
		note="In the tunnel",
		vignette=6962,
	},
	[43685151] = { -- Screammaxa the Matriarch
		criteria=111880, quest=93966, -- 94731
		npc=256922,
		loot={
			264583, -- Barbute of the Winged Hunter
		},
		vignette=7436,
	},
	[47058063] = { -- Bane of the Vilebloods
		criteria=111881, quest=93946, -- 94732
		npc=256923,
		loot={
			264572, -- Netherplate Clasp
		},
		note="In cave",
		vignette=7433,
	},
	[39246394] = { -- Aeonelle Blackstar
		criteria=111882, quest=93944, -- 94751
		npc=256924,
		loot={
			264549, -- Ever-Devouring Shoulderguards
			264637, -- Cosmic Hunter's Glaive
		},
		note="In cave at lowest level",
		vignette=7432,
	},
	[37887178] = { -- Lotus Darkblossom
		criteria=111883, quest=93947, -- 94758
		npc=256925,
		loot={
			251786, -- Ever-Collapsing Void Fissure
			264632, -- Darkblossom's Crook
			264548, -- Sash of Cosmic Tranquility
		},
		vignette=7434,
	},
	[55727945] = { -- Queen o' War
		criteria=111884, quest=93934, -- 94761
		npc=256926,
		loot={
			251786, -- Ever-Collapsing Void Fissure
			264533, -- Queen's Tentacle Sash
			264601, -- Queen's Eye Band
		},
		note="Use the Crown",
		vignette=7430,
	},
	[48815317] = { -- Ravengerus
		criteria=111885, quest=93895, -- 94763
		npc=256808,
		loot={
			264535, -- Leggings of the Cosmic Harrower
		},
		vignette=7426,
	},
	[35485023] = { -- Bilemaw the Gluttonous
		criteria=111887, quest=93884, -- 94752
		npc=256770,
		loot={
			264623, -- Shredding Fang
		},
		path=35604931,
		vignette=7422,
	},
	[40154119] = { -- Nightbrood
		criteria=111889, quest=91051, -- 94759
		npc=245044,
		loot={
			251786, -- Ever-Collapsing Void Fissure
			264574, -- Netherterror's Legplates
		},
		vignette=6964,
	},
	[53946272] = { -- Far'thana the Mad
		criteria=111890, quest=93896, -- 94755
		npc=256821,
		loot={
			251786, -- Ever-Collapsing Void Fissure
		},
		vignette=7428,
	},
}, {
	achievement=62130,
})

ns.RegisterPoints(ns.SLAYERSRISE, {
	[41268981] = { -- Eruundi
		criteria=111888, quest=91047, -- 94754
		npc=245182,
		loot={
			264701, -- Cosmic Bell
		},
		vignette=6963, -- vignette position APIs don't work on this one...
	},
	[46384093] = { -- Rakshur the Bonegrinder
		criteria=111886, quest=93953, -- 94762
		npc=257027,
		loot={
			264630, -- Colossal Voidsunderer
		},
		vignette=7435,
	},
}, {
	achievement=62130,
	parent=true,
})

ns.RegisterPoints(ns.VOIDSTORM, {
	[30576661] = { -- Voidseer Orivane
		quest=94459, -- v
		npc=248791,
		loot={},
		vignette=7140,
	},
	[28827024] = { -- The Many-Broken
		quest=94458, -- v
		npc=248459, -- 248461, 248462
		loot={},
		vignette=7133,
	},
	[28156593] = { -- Abysslick
		quest=94462, -- v
		npc=248700,
		loot={},
		vignette=7138,
	},
	[29806787] = { -- Nullspiral
		quest=94460, -- v
		npc=248068,
		loot={},
		vignette=7129,
	},
})

ns.RegisterPoints(ns.SLAYERSRISE, {
	[28465684] = { -- Hardin Steellock
		quest=94461, -- v
		npc=257199,
		loot={
			264615, -- Hardin's Backup Blade
		},
		faction="Horde",
		vignette=7442,
	},
	[69687730] = { -- Gar'chak Skullcleave
		quest=94461, -- v
		npc=257231,
		loot={
			264609, -- Gar'chak's Mark of Honor
		},
		faction="Alliance",
		vignette=7445,
	},
}, {
	parent=true,
})