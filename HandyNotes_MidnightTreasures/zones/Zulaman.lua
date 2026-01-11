local myname, ns = ...

--[[ TODO:
A Most Violent Loa: 62267
Put a Pin in It: 62199
Gnome Alone: 62200
]]

ns.RegisterPoints(ns.ZULAMAN, {
	[44724410] = {criteria=111854, quest=90794, loot={{257444, mount=true}}, vignette=6938, note="In cave on the lower level; gather 1000x{item:259361:Vile Essence} nearby"}, -- Abandoned Ritual Skull, Hexed Vilefeather Eagle
	[46838186] = { -- Honored Warrior's Cache
		criteria=111855, quest=90793, -- 93560 for interacting with the cache
		loot={{257223, mount=true}}, -- Ancestral War Bear
		note="Fetch the four tokens",
		related={
			[32698350] = {label="{npc:255171:Nalorakk's Chosen}", loot={259219}, inbag=259219}, -- Bear Tooth
			[34553346] = {label="{npc:255232:Halazzi's Chosen}", loot={259223}, inbag=259223}, -- Lynx Claw
			[54782239] = {label="{npc:255233:Jan'alai's Chosen}", loot={259220}, inbag=259220}, -- Dragonhawk Feather
			-- This one is looting-bugged, and there's no sign of the item on wowhead via https://www.wowhead.com/beta/items?filter=104;0;Honored+Warrior%27s+Cache
			[51588492] = {label="{npc:255231:Akil'zon's Chosen}", loot={}, inbag=nil}, -- Akil'zon's Chosen 255231
			hide_before=ns.conditions.QuestComplete(93560), -- interacted with the cache for the first time
			note="Use the Honored Warrior's Urn",
			minimap=true,
		},
		vignette=6937,
	},
	[21897738] = { -- Sealed Twilight Blade Bounty
		criteria=111856, quest=93871,
		loot={{265362, quest=94570}}, -- Arsenal: Twilight Blade
		note="Solve the {spell:1270357:Sealing Orb} puzzle in each of the nearby towers",
		related={
			[26098074] = {quest=93916, label="{spell:1270357:Sealing Orb}", color={r=0.5,g=0,b=1}, minimap=true},
			[23957895] = {quest=93917, label="{spell:1270357:Sealing Orb}", color={r=0.5,g=0,b=1}, minimap=true},
			[24027566] = {quest=93918, label="{spell:1270357:Sealing Orb}", color={r=0.5,g=0,b=1}, minimap=true},
			[26097401] = {quest=93919, label="{spell:1270357:Sealing Orb}", color={r=0.5,g=0,b=1}, minimap=true},
		},
		vignette=7419,
	},
	[20846654] = { -- Bait and Tackle
		criteria=111857, quest=90795,
		loot={
			255157, -- Abyss Angler's Fish Log
			241145, -- Lucky Loa Lure
			255688, -- Achor of the Abyss
		},
		vignette=6939,
	},
	[41994778] = {criteria=111858, quest=90796, loot={254749}, vignette=6940}, -- Burrow Bounty, Phial of Burrow Balm
	[52336599] = {criteria=111859, quest=90797, loot={255428}, vignette=6941}, -- Mrruk's Mangy Trove, Tolbani's Medicine Satchel
	[40483596] = {criteria=111860, quest=90798, loot={256326}, vignette=6942}, -- Secret Formula, Fetid Dartfrog Idol
	[42645244] = {criteria=111861, quest=90799, loot={{255008, pet=4906}}, vignette=6943, note="Atop the tree"}, -- Abandoned Nest, Weathered Eagle Egg
}, {
	achievement=62125,
})

-- ns.RegisterPoints(ns.ATALAMAN, {})

ns.RegisterPoints(ns.ZULAMAN, {
	-- TODO: this wasn't interactable when I went by on 12/24, so need to check what's in it
	[44325620] = { -- Ruz'avalt's Prized Tackle
		label="Ruz'avalt's Prized Tackle",
		quest=90790,
		vignette=6934,
	},
})

-- Spiritpaw Marathon
ns.RegisterPoints(ns.ZULAMAN, {
	[32292239] = {
		achievement=62202,
		note="Talk to {npc:258938:Feeva}",
		texture=ns.atlas_texture("WildBattlePetCapturable", {r=0.8,g=0,b=1}),
		minimap=true,
	},
})

-- Shadowpine Scattered
ns.RegisterPoints(ns.ZULAMAN, {
	[52687933] = {criteria=109749, label="{npc:254808:Songseeker Baz'wa}"},
	[47328190] = {criteria=109750, label="{npc:254807:Songseeker Far'lan}"},
	[31624653] = {
		criteria=109751, label="{npc:254840:Songseeker Jebanda}",
		route={31624653, 33074390, 33204354, 33184061, 33214041, 33184004, 33023952, 32943936, 32613903, 32493896, 32363893, 32293875, 31973841, 31893824, 31763817, 31623813},
	},
	-- [] = {criteria=109752, label="{npc:254839:Songseeker Dova}"},
	[55031798] = {criteria=109753, label="{npc:254841:Songseeker Ikaja}"},
}, {
	achievement=61455,
	texture=ns.atlas_texture("AncientMana", {r=0, g=1, b=0.5}),
	minimap=true,
})

-- The Frog and the Princesses
local FROG = {
	achievement=62201,
	texture=ns.atlas_texture("AncientMana", {r=0, g=1, b=0}),
	minimap=true,
	note=EMOTE59_CMD1,
}
ns.RegisterPoints(ns.ZULAMAN, {
	[31702263] = {criteria=112041, label="{npc:258937:Princess Fita}"},
	[68281931] = {criteria=112445, label="{npc:259684:Princess Gabiku}"},
	[53945957] = {criteria=112447, label="{npc:259683:Princess Tafiki}"},
	[29827915] = {criteria=112448, label="{npc:259685:Princess Zambina}"},
}, FROG)
ns.RegisterPoints(ns.ATALAMAN, {
	[27514003] = {criteria=112446, label="{npc:259682:Princess Jakobu}", parent=true},
}, FROG)

-- Rares

-- Tallest Tree in the Forest
ns.RegisterPoints(ns.ZULAMAN, {
	[34393304] = { -- Necrohexxer Raz'ka
		criteria=111839, quest=89569, -- 94683
		npc=242023,
		loot={
			251783, -- Lost Idol of the Hash'ey
			264527, -- Vile Hexxer's Mantle
			264611, -- Pendant of Siphoned Vitality
			265543, -- Tempered Amani Spearhead
		},
		vignette=6895,
	},
	[51881875] = { -- The Snapping Scourge
		criteria=111840, quest=89570, -- 94697
		npc=242024,
		loot={
			264585, -- Snapper Steppers
			264617, -- Scourge's Spike
		},
		vignette=6896,
	},
	[51847292] = { -- Skullcrusher Harak
		criteria=111841, quest=89571, -- 94698
		npc=242025,
		loot={
			251783, -- Lost Idol of the Hash'ey
			251784, -- Sylvan Wakrapuku
			264542, -- Skullcrusher's Mantle
			264631, -- Harak's Skullcutter
			265560, -- Toughened Amani Leather Wrap
		},
		vignette=6897,
	},
	[28832450] = { -- Lightwood Borer
		criteria=111842, quest=89575, -- 94699
		npc=242028,
		loot={
			251784, -- Sylvan Wakrapuku
			264640, -- Sharpened Borer Claw
		},
		vignette=6900,
	},
	[50866517] = { -- Mrrlokk
		criteria=111843, quest=91174, -- 94700
		npc=245975,
		loot={
			251783, -- Lost Idol of the Hash'ey
			264570, -- Reinforced Chainmrrl
			264580, -- Mrrlokk's Mrgl Grrdle
			265543, -- Tempered Amani Spearhead
		},
		vignette=6977,
	},
	[30574456] = { -- Spinefrill
		criteria=111845, quest=89578, -- 94702
		npc=242031,
		loot={
			264554, -- Frilly Leather Vest
			264620, -- Pufferspine Spellpierce
		},
		vignette=6903,
	},
	[46555127] = { -- Oophaga
		criteria=111846, quest=89579, -- 94703
		npc=242032,
		loot={
			264528, -- Goop-Coated Leggings
			264541, -- Egg-Swaddling Sash
		},
		vignette=6904,
	},
	[47763435] = { -- Tiny Vermin
		criteria=111847, quest=89580,
		npc=242033,
		loot={
			251784, -- Sylvan Wakrapuku
			264648, -- Verminscale Gavel
			264597, -- Leechtooth Band
		},
		vignette=6905,
	},
	[21547051] = { -- Voidtouched Crustacean
		criteria=111848, quest=89581, --94705
		npc=242034,
		loot={
			264586, -- Crustacean Carapace Chestguard
		},
		vignette=6906,
	},
	[39592097] = { -- The Devouring Invader
		criteria=111849, quest=89583,
		npc=242035,
		loot={
			264559, -- Devourer's Visage
			264638, -- Fangs of the Invader
		},
		note="In cave at the bottom of the chasm",
		vignette=6907,
	},
	[33688897] = { -- Elder Oaktalon
		criteria=111850, quest=89572, -- 94707
		npc=242026,
		loot={
			264547, -- Worn Furbolg Bindings
			264529, -- Cover of the Furbolg Elder
		},
		vignette=6898,
	},
	[47662052] = { -- Depthborn Eelamental
		criteria=111851, quest=89573, -- 94708
		npc=242027,
		loot={
			251784, -- Sylvan Wakrapuku
			264618, -- Strangely Eelastic Blade
		},
		vignette=6899,
	},
	[46394339] = { -- The Decaying Diamondback
		criteria=111852, quest=91072,
		npc=245691,
		vignette=6971,
	},
	[45284171] = { -- Ash'an the Empowered / Asha the Empowered
		criteria=111853, quest=91073,
		npc=245692,
		vignette=6972,
	},
}, {
	achievement=62122,
})

ns.RegisterPoints(ns.ATALAMAN, {
	[82972145] = { -- Poacher Rav'ik
		criteria=111844, quest=91634, -- 94701
		npc=247976,
		loot={
			264627, -- Rav'ik's Spare Hunting Spear
			264911, -- Forest Hunter's Arc
		},
		vignette=7117,
	},
}, {
	achievement=62122,
	parent=true,
})
