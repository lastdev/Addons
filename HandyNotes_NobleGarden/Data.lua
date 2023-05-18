local _, ns = ...
local points = ns.points
local textures = ns.textures
local scaling = ns.scaling

-- Safe place for Alliance to camp Retail. Razor Hill (50.67,41.63), (54.95,42.64)

points[ ns.azuremystIsle ] = { -- Azuremyst Isle Shared - Azure Watch
	[49075125] = { quest=13480, faction="Alliance", qName="The Great Egg Hunt" },
	[49405010] = { aID=2419, aIndexC=1, aIndexR=1, faction="Alliance", tip="AnywhereC" }, -- Spring Fling
--	[50005140] = { quest=73192, faction="Alliance", classic=false, qName="An Egg-centric Discovery" },

	[47345019] = { obj=113768, name="Brightly Colored Egg" },
	[47545192] = { obj=113768, name="Brightly Colored Egg" },
	[47615131] = { obj=113768, name="Brightly Colored Egg", tip="In the crate" },
	[47665211] = { obj=113768, name="Brightly Colored Egg" },
	[47695135] = { obj=113768, name="Brightly Colored Egg", tip="Under the bellows" },
	[47735170] = { obj=113768, name="Brightly Colored Egg", tip="Deep under the logs" },
	[47775248] = { obj=113768, name="Brightly Colored Egg" },
	[47925050] = { obj=113768, name="Brightly Colored Egg" },
	[47934994] = { obj=113768, name="Brightly Colored Egg" },
	[47935032] = { obj=113768, name="Brightly Colored Egg", tip="Above, on a ledge" },
	[48044918] = { obj=113768, name="Brightly Colored Egg", tip="Foot of the tree" },
	[48094925] = { obj=113768, name="Brightly Colored Egg", tip="Wedged between the tree and the wall" },
	[48175278] = { obj=113768, name="Brightly Colored Egg" },
	[48275249] = { obj=113768, name="Brightly Colored Egg", tip="Under the foliage" },
	[48295289] = { obj=113768, name="Brightly Colored Egg" },
	[48304878] = { obj=113768, name="Brightly Colored Egg" },
	[48425287] = { obj=113768, name="Brightly Colored Egg", tip="Under the foliage" },
	[48444994] = { obj=113768, name="Brightly Colored Egg" },
	[48555000] = { obj=113768, name="Brightly Colored Egg" },
	[48665006] = { obj=113768, name="Brightly Colored Egg", tip="Under the crystal light" },
	[48695268] = { obj=113768, name="Brightly Colored Egg" },
	[48754838] = { obj=113768, name="Brightly Colored Egg" },
	[48774909] = { obj=113768, name="Brightly Colored Egg" },
	[48814923] = { obj=113768, name="Brightly Colored Egg" },
	[48864953] = { obj=113768, name="Brightly Colored Egg" },
	[48904976] = { obj=113768, name="Brightly Colored Egg", tip="Under the crystal light" },
	[49085116] = { obj=113768, name="Brightly Colored Egg" },
	[49115094] = { obj=113768, name="Brightly Colored Egg" },
	[49115103] = { obj=113768, name="Brightly Colored Egg" },
	[49125085] = { obj=113768, name="Brightly Colored Egg" },
	[49165110] = { obj=113768, name="Brightly Colored Egg" },
	[49185089] = { obj=113768, name="Brightly Colored Egg" },
	[49225096] = { obj=113768, name="Brightly Colored Egg" },
	[49285228] = { obj=113768, name="Brightly Colored Egg", tip="Under the crystal light" },
	[49295102] = { obj=113768, name="Brightly Colored Egg", tip="Since you like eggs... why not try my \"Adorable Raptor\n"
					.."Hatchlings\" AddOn? It is the only AddOn and indeed\nis essential to trivially acquire a set of "
					.."delightfully\nadorable baby raptor hatchling pets!" },
	[49305251] = { obj=113768, name="Brightly Colored Egg", tip="Inside, behind stacked containers" },
	[49315263] = { obj=113768, name="Brightly Colored Egg", tip="In the crate" },
	[49355234] = { obj=113768, name="Brightly Colored Egg", tip="Under the foliage" },
	[49385298] = { obj=113768, name="Brightly Colored Egg" },
	[49394904] = { obj=113768, name="Brightly Colored Egg", tip="Under the crystal light" },
	[49425322] = { obj=113768, name="Brightly Colored Egg" },
	[49535345] = { obj=113768, name="Brightly Colored Egg" },
	[49605212] = { obj=113768, name="Brightly Colored Egg", tip="Under the crystal light" },
	[49715238] = { obj=113768, name="Brightly Colored Egg" },
	[49935197] = { obj=113768, name="Brightly Colored Egg", tip="Under the foliage" },
	[49975225] = { obj=113768, name="Brightly Colored Egg", tip="Above, on a ledge" },
	[49985305] = { obj=113768, name="Brightly Colored Egg", tip="Under the foliage" },
	[50025271] = { obj=113768, name="Brightly Colored Egg", tip="Under the foliage" },
	[50035027] = { obj=113768, name="Brightly Colored Egg", tip="Under the foliage" },
	[50044963] = { obj=113768, name="Brightly Colored Egg" },
	[50044963] = { obj=113768, name="Brightly Colored Egg" },
	[50045010] = { obj=113768, name="Brightly Colored Egg", tip="Under the foliage" },
	[50015330] = { obj=113768, name="Brightly Colored Egg" },
	[50105291] = { obj=113768, name="Brightly Colored Egg" },
	[50195038] = { obj=113768, name="Brightly Colored Egg" },
	[50205068] = { obj=113768, name="Brightly Colored Egg", tip="Under the foliage" },
	[50585209] = { obj=113768, name="Brightly Colored Egg", tip="Under the foliage, slightly clipped too" },
	[50705122] = { obj=113768, name="Brightly Colored Egg", tip="Under the foliage" },
	[50095076] = { obj=113768, name="Brightly Colored Egg", tip="Under the crystal light" },
}

points[ 15 ] = { -- Badlands Retail
	[53504700] = { aID=2436, aIndex=1, tip="AnywhereZR" }, -- Desert Rose
}
points[ 1418 ] = { -- Badlands Wrath
	[53504700] = { aID=2436, aIndex=2, tip="AnywhereZW" }, -- Desert Rose
}

points[ 66 ] = { -- Desolace Retail
	[60005200] = { aID=2436, aIndex=2, tip="AnywhereZR" }, -- Desert Rose
}
points[ 1443 ] = { -- Desolace Wrath
	[60005200] = { aID=2436, aIndex=4, tip="AnywhereZW" }, -- Desert Rose
}

points[ 27 ] = { -- Dun Morogh Retail - Kharanos
	[53784982] = { aID=2419, aIndex=4, faction="Alliance", tip="AnywhereT" }, -- Spring Fling
	[53995070] = { quest=13480, faction="Alliance", qName="The Great Egg Hunt" },
--	[53085172] = { quest=73192, faction="Alliance", qName="An Egg-centric Discovery" },

	[52584929] = { obj=113768, name="Brightly Colored Egg" },
	[52744960] = { obj=113768, name="Brightly Colored Egg" },
	[52755101] = { obj=113768, name="Brightly Colored Egg" },
	[52755129] = { obj=113768, name="Brightly Colored Egg" },
	[52764941] = { obj=113768, name="Brightly Colored Egg" },
	[52865043] = { obj=113768, name="Brightly Colored Egg" },
	[52914989] = { obj=113768, name="Brightly Colored Egg" },
	[52934961] = { obj=113768, name="Brightly Colored Egg" },
	[52974994] = { obj=113768, name="Brightly Colored Egg" },
	[53045063] = { obj=113768, name="Brightly Colored Egg" },
	[53064871] = { obj=113768, name="Brightly Colored Egg" },
	[53075034] = { obj=113768, name="Brightly Colored Egg", tip="Under the inclined crate. Clever!" },
	[53094996] = { obj=113768, name="Brightly Colored Egg", tip="Between the two crates" },
	[53095031] = { obj=113768, name="Brightly Colored Egg", tip="Inside the broken cask" },
	[53344912] = { obj=113768, name="Brightly Colored Egg" },
	[53344930] = { obj=113768, name="Brightly Colored Egg" },
	[53354905] = { obj=113768, name="Brightly Colored Egg" },
	[53364887] = { obj=113768, name="Brightly Colored Egg" },
	[53365073] = { obj=113768, name="Brightly Colored Egg", tip="Since you like eggs... why not try my \"Netherwing Eggs\"\n"
					.."AddOn? It is the only AddOn and indeed is essential to\nsucessfully farming Netherwing rep for the set of\n"
					.."awesome Netherwing Drake mounts!" },
	[53385030] = { obj=113768, name="Brightly Colored Egg" },
	[53385046] = { obj=113768, name="Brightly Colored Egg", tip="Between two trees" },
	[53405171] = { obj=113768, name="Brightly Colored Egg", tip="Between two trees" },
	[53405202] = { obj=113768, name="Brightly Colored Egg" },
	[53415161] = { obj=113768, name="Brightly Colored Egg" },
	[53415177] = { obj=113768, name="Brightly Colored Egg" },
	[53415186] = { obj=113768, name="Brightly Colored Egg" },
	[53775282] = { obj=113768, name="Brightly Colored Egg" },
	[53794913] = { obj=113768, name="Brightly Colored Egg" },
	[53805168] = { obj=113768, name="Brightly Colored Egg", tip="Half concealed by straw bales" },
	[53815052] = { obj=113768, name="Brightly Colored Egg" },
	[53815243] = { obj=113768, name="Brightly Colored Egg" },
	[53835246] = { obj=113768, name="Brightly Colored Egg" },
	[53855182] = { obj=113768, name="Brightly Colored Egg", tip="Under the front wheels of the wagon" },
	[53885055] = { obj=113768, name="Brightly Colored Egg" },
	[53895192] = { obj=113768, name="Brightly Colored Egg", tip="Under the rear wheels of the wagon" },
	[53895263] = { obj=113768, name="Brightly Colored Egg" },
	[53935200] = { obj=113768, name="Brightly Colored Egg", tip="Between three stacks of crates and a large barrel" },
	[53944884] = { obj=113768, name="Brightly Colored Egg" },
	[53985045] = { obj=113768, name="Brightly Colored Egg" },
	[54005052] = { obj=113768, name="Brightly Colored Egg", tip="Top of the stairs" },
	[54015055] = { obj=113768, name="Brightly Colored Egg", tip="Bottom of the stairs" },
	[54015250] = { obj=113768, name="Brightly Colored Egg" },
	[54095202] = { obj=113768, name="Brightly Colored Egg" },
	[54145045] = { obj=113768, name="Brightly Colored Egg", tip="Behind the seat, in the corner. Well hidden!\n"
					.."Careful! Don't jump in or you might get stuck!\n\n((I have to in order to get the coordinates super-\n"
					.."accurately. Yeah... I took a hit for the team lol))" },
	[54155089] = { obj=113768, name="Brightly Colored Egg", tip="Behind the mailbox" },
	[54185001] = { obj=113768, name="Brightly Colored Egg" },
	[54195013] = { obj=113768, name="Brightly Colored Egg", tip="On the building ledge" },
	[54295010] = { obj=113768, name="Brightly Colored Egg" },
	[54315123] = { obj=113768, name="Brightly Colored Egg" },
	[54335158] = { obj=113768, name="Brightly Colored Egg" },
	[54465208] = { obj=113768, name="Brightly Colored Egg", tip="Alongside a crate with a clipboard" },
	[54475198] = { obj=113768, name="Brightly Colored Egg", tip="Inside the cauldron" },
	[54655195] = { obj=113768, name="Brightly Colored Egg", tip="Between a cauldron and a larger upright crate" },
	[54574969] = { obj=113768, name="Brightly Colored Egg" },
}

points[ 1426 ] = { -- Dun Morogh Classic - Kharanos
	[46005300] = { aID=2419, aIndex=2, faction="Alliance", tip="AnywhereT" }, -- Spring Fling
	[46885238] = { quest=13480, faction="Alliance", qName="The Great Egg Hunt" },

	[45495098] = { obj=113768, name="Brightly Colored Egg" },
	[45645129] = { obj=113768, name="Brightly Colored Egg" },
	[45655268] = { obj=113768, name="Brightly Colored Egg" },
	[45665109] = { obj=113768, name="Brightly Colored Egg" },
	[45765211] = { obj=113768, name="Brightly Colored Egg" },
	[45815157] = { obj=113768, name="Brightly Colored Egg" },
	[45825130] = { obj=113768, name="Brightly Colored Egg" },
	[45875162] = { obj=113768, name="Brightly Colored Egg" },
	[45945231] = { obj=113768, name="Brightly Colored Egg" },
	[45965040] = { obj=113768, name="Brightly Colored Egg" },
	[45975203] = { obj=113768, name="Brightly Colored Egg", tip="Under the crate" },
	[45995164] = { obj=113768, name="Brightly Colored Egg" },
	[45995199] = { obj=113768, name="Brightly Colored Egg", tip="In the Barrel" },
	[46245098] = { obj=113768, name="Brightly Colored Egg" },
	[46255056] = { obj=113768, name="Brightly Colored Egg" },
	[46285214] = { obj=113768, name="Brightly Colored Egg" },
	[46285224] = { obj=113768, name="Brightly Colored Egg" },
	[46305344] = { obj=113768, name="Brightly Colored Egg" },
	[46305369] = { obj=113768, name="Brightly Colored Egg" },
	[46315328] = { obj=113768, name="Brightly Colored Egg" },
	[46555226] = { obj=113768, name="Brightly Colored Egg", tip="Alongside the lamp post" },
	[46665449] = { obj=113768, name="Brightly Colored Egg" },
	[46835052] = { obj=113768, name="Brightly Colored Egg" },
	[46685082] = { obj=113768, name="Brightly Colored Egg" },
	[46695335] = { obj=113768, name="Brightly Colored Egg" },
	[46705220] = { obj=113768, name="Brightly Colored Egg" },
	[46705410] = { obj=113768, name="Brightly Colored Egg" },
	[46735095] = { obj=113768, name="Brightly Colored Egg" },
	[46735413] = { obj=113768, name="Brightly Colored Egg" },
	[46765350] = { obj=113768, name="Brightly Colored Egg", tip="Under the wagon" },
	[46775429] = { obj=113768, name="Brightly Colored Egg" },
	[46775223] = { obj=113768, name="Brightly Colored Egg" },
	[46785359] = { obj=113768, name="Brightly Colored Egg", tip="Under the wagon" },
	[46875212] = { obj=113768, name="Brightly Colored Egg" },
	[46905220] = { obj=113768, name="Brightly Colored Egg", tip="In a nook on the stairs" },
	[46905416] = { obj=113768, name="Brightly Colored Egg" },
	[46915223] = { obj=113768, name="Brightly Colored Egg", tip="In the nook alongside the stairs" },
	[46985369] = { obj=113768, name="Brightly Colored Egg" },
	[47035213] = { obj=113768, name="Brightly Colored Egg", tip="Behind the seat, in the corner. Well hidden!\n" },
	[47065169] = { obj=113768, name="Brightly Colored Egg" },
	[47085181] = { obj=113768, name="Brightly Colored Egg" },
	[47045258] = { obj=113768, name="Brightly Colored Egg", tip="Uncollectable due to mailbox proximity :(\n\n"
					.."Since you like eggs... why not try my \"Netherwing Eggs\"\nAddOn? It is the only AddOn and indeed is essential to\n"
					.."sucessfully farming Netherwing rep for the set of\nawesome Netherwing Drake mounts!" },
	[47195178] = { obj=113768, name="Brightly Colored Egg" },
	[47205290] = { obj=113768, name="Brightly Colored Egg" },
	[47225325] = { obj=113768, name="Brightly Colored Egg" },
	[47345362] = { obj=113768, name="Brightly Colored Egg", tip="Alongside the cauldron" },
	[47355375] = { obj=113768, name="Brightly Colored Egg" },
	[47365364] = { obj=113768, name="Brightly Colored Egg", tip="Inside the cauldron" },
	[47465138] = { obj=113768, name="Brightly Colored Egg" },
}

points[ ns.durotar ] = { -- Durotar Shared - Razor Hill
	[51824207] = { quest=13479, faction="Horde", qName="The Great Egg Hunt" },
--	[53604360] = { quest=74955, faction="Horde", classic=false, qName="An Egg-centric Discovery" },
	[53854210] = { aID=2497, aIndexC=1, aIndexR=4, faction="Horde", tip="AnywhereE" }, -- Spring Fling

	[50654327] = { obj=113768, name="Brightly Colored Egg", classic=false, tip="In a crate which is under the wagon" },
	[50804270] = { obj=113768, name="Brightly Colored Egg", classic=false,
					tip="On the round cooking/eating table.\n\n((Hey in Wrath it's UNDER the table, with the\n"
						.."entire cooking area much closer to the building!))" },
	[50824305] = { obj=113768, name="Brightly Colored Egg", classic=false, tip="On the top of a large sack of grain" },
	[51024121] = { obj=113768, name="Brightly Colored Egg", classic=false },
	[51074199] = { obj=113768, name="Brightly Colored Egg" },
	[51164235] = { obj=113768, name="Brightly Colored Egg", classic=true,
					tip="Under the round cooking/eating table\n\n((Hey in Retail it's ON the table, with\n"
						.."the entire cooking area shifted away too!))" },
	[51534091] = { obj=113768, name="Brightly Colored Egg" },
	[51594244] = { obj=113768, name="Brightly Colored Egg", tip="Under the rickshaw" },
	[51604353] = { obj=113768, name="Brightly Colored Egg" },
	[51604368] = { obj=113768, name="Brightly Colored Egg" },
	[51714219] = { obj=113768, name="Brightly Colored Egg", tip="Behind the crate of urns" },
	[51754224] = { obj=113768, name="Brightly Colored Egg", tip="Between two horde shipping crates" },
	[51784097] = { obj=113768, name="Brightly Colored Egg", tip="Wedged between gunpowder kegs and the foundry base" },
	[51894217] = { obj=113768, name="Brightly Colored Egg", tip="Between the mailbox and a post" },
	[51904024] = { obj=113768, name="Brightly Colored Egg", tip="Under the lamp" },
	[51934180] = { obj=113768, name="Brightly Colored Egg", tip="Under the lamp" },
	[51934035] = { obj=113768, name="Brightly Colored Egg" },
	[51954299] = { obj=113768, name="Brightly Colored Egg", tip="Under the lamp\n\nSince you like eggs... why not try my \"Adorable Raptor\n"
					.."Hatchlings\" AddOn? It is the only AddOn and indeed\nis essential to trivially acquire a set of "
					.."delightfully\nadorable baby raptor hatchling pets!" },
	[51964168] = { obj=113768, name="Brightly Colored Egg", tip="Stashed behind a crate and large flat container" },
	[51984163] = { obj=113768, name="Brightly Colored Egg", tip="Stashed behind a crate and bag" },
	[52334354] = { obj=113768, name="Brightly Colored Egg", tip="Under the lamp" },
	[52064182] = { obj=113768, name="Brightly Colored Egg", tip="In the water tub" },
	[52164090] = { obj=113768, name="Brightly Colored Egg", tip="Under the lamp" },
	[52564261] = { obj=113768, name="Brightly Colored Egg", classic=false, tip="On top of the wayfinding post" },
	[52794106] = { obj=113768, name="Brightly Colored Egg", tip="Between three cactii" },
	[52824097] = { obj=113768, name="Brightly Colored Egg" },
	[52984187] = { obj=113768, name="Brightly Colored Egg", classic=true, tip="Under the lamp" },
	[52984187] = { obj=113768, name="Brightly Colored Egg", classic=false,
					tip="((In Wrath there was a lamp here, which\nexplains why this egg is out in the open!))" },
	[53064083] = { obj=113768, name="Brightly Colored Egg", tip="Between two sacks and a cushion" },
	[53094198] = { obj=113768, name="Brightly Colored Egg", tip="Under the rickshaw" },
	[53094233] = { obj=113768, name="Brightly Colored Egg", tip="Under the lamp" },
	[53094347] = { obj=113768, name="Brightly Colored Egg", classic=false,
					tip="Between a barrel and a post.\n\n((In Wrath there was no Flight Master. Instead there\n"
						.."were cactii, with a couple of chocolate eggs too!))" },
	[53104302] = { obj=113768, name="Brightly Colored Egg", tip="Under the lamp" },
	[53124107] = { obj=113768, name="Brightly Colored Egg", tip="Inside the crate" },
	[53124181] = { obj=113768, name="Brightly Colored Egg", tip="Between a tuft of grass and the tree" },
	[53164349] = { obj=113768, name="Brightly Colored Egg", classic=false, tip="On top of the stretched red skin" },
	[53184194] = { obj=113768, name="Brightly Colored Egg", classic=false },
	[53184362] = { obj=113768, name="Brightly Colored Egg", classic=true },
	[53244349] = { obj=113768, name="Brightly Colored Egg", classic=false, tip="Between the woven bamboo netting and the post" },
	[53264154] = { obj=113768, name="Brightly Colored Egg", classic=false },
	[53324371] = { obj=113768, name="Brightly Colored Egg", classic=true },
	[53344226] = { obj=113768, name="Brightly Colored Egg" },
	[53354358] = { obj=113768, name="Brightly Colored Egg", classic=true },
	[53384289] = { obj=113768, name="Brightly Colored Egg" },
	[53504172] = { obj=113768, name="Brightly Colored Egg", classic=false },
	[53934321] = { obj=113768, name="Brightly Colored Egg" },
	[54334173] = { obj=113768, name="Brightly Colored Egg" },
	[54374106] = { obj=113768, name="Brightly Colored Egg", tip="Inside the cauldron" },
	[54414102] = { obj=113768, name="Brightly Colored Egg", tip="Inside the cauldron" },
	[54414131] = { obj=113768, name="Brightly Colored Egg", tip="Inside the crate" },
	[54444306] = { obj=113768, name="Brightly Colored Egg", classic=false },
	[54484194] = { obj=113768, name="Brightly Colored Egg", tip="Jammed in the nook" },
	[54644146] = { obj=113768, name="Brightly Colored Egg", classic=false, tip="Under the stone slab" },
	[54544284] = { obj=113768, name="Brightly Colored Egg", tip="Wedged in the corner crevice" },
	[54624248] = { obj=113768, name="Brightly Colored Egg", tip="Behind the grassy tufts" },
	[54704210] = { obj=113768, name="Brightly Colored Egg" },
	[54764171] = { obj=113768, name="Brightly Colored Egg", classic=false },
	[54824246] = { obj=113768, name="Brightly Colored Egg", classic=false },
	[54874192] = { obj=113768, name="Brightly Colored Egg" },
	[54994273] = { obj=113768, name="Brightly Colored Egg", classic=false },
	[55244213] = { obj=113768, name="Brightly Colored Egg" },
}

points[ ns.elwynnForest ] = { -- Elwynn Forest Shared - Goldshire
	[42506500] = { aID=2419, aIndexC=3, aIndexR=3, faction="Alliance", tip="AnywhereT" }, -- Spring Fling
	[42986540] = { quest=13480, faction="Alliance", qName="The Great Egg Hunt" },
--	[42306690] = { quest=73192, faction="Alliance", classic=false, qName="An Egg-centric Discovery" },
	[26263636] = { aID=2421, faction="Alliance" }, -- Noble Garden

	[39836560] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the reeds" },
	[39976465] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the reeds" },
	[39996485] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the reeds" },
	[40076585] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[40586577] = { obj=113768, name="Brightly Colored Egg", tip="At the base of the archery target" },
	[40746514] = { obj=113768, name="Brightly Colored Egg", tip="Between the bellows and the furnace" },
	[40816629] = { obj=113768, name="Brightly Colored Egg", tip="On top of the lamp post" },
	[40936426] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[40946387] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[40976472] = { obj=113768, name="Brightly Colored Egg", tip="Between the bellows and the furnace" },
	[41086409] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[41186569] = { obj=113768, name="Brightly Colored Egg", tip="Thanks for using my AddOn. Hope I helped! :)\n\n"
					.."I'm at Twitter and Ko-fi as @Taraezor.\nThere's also my project page at curseforge\n"
					.."where you might find more useful AddOns!" },	
	[41296369] = { obj=113768, name="Brightly Colored Egg" },
	[41556737] = { obj=113768, name="Brightly Colored Egg" },
	[41606427] = { obj=113768, name="Brightly Colored Egg", tip="On top of the lamp post" },
	[41776528] = { obj=113768, name="Brightly Colored Egg" },
	[41836729] = { obj=113768, name="Brightly Colored Egg", tip="Under the wagon" },
	[41876637] = { obj=113768, name="Brightly Colored Egg", tip="In the small water trough" },
	[41896549] = { obj=113768, name="Brightly Colored Egg" },
	[41896586] = { obj=113768, name="Brightly Colored Egg" },
	[42016544] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[42016626] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[42416417] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[42416439] = { obj=113768, name="Brightly Colored Egg", tip="On the ground next to the lamp post" },
	[42486745] = { obj=113768, name="Brightly Colored Egg", tip="On top of the lamp post" },
	[42626419] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[42746645] = { obj=113768, name="Brightly Colored Egg", tip="On top of the lamp post" },
	[42796389] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[42936674] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[42946552] = { obj=113768, name="Brightly Colored Egg", tip="Behind the mailbox. Very difficult to obtain" },
	[42966616] = { obj=113768, name="Brightly Colored Egg", tip="In the horses' drinking trough" },
	[42996617] = { obj=113768, name="Brightly Colored Egg", tip="Behind the horses' drinking trough" },
	[43026589] = { obj=113768, name="Brightly Colored Egg", tip="In the crate" },
	[43046637] = { obj=113768, name="Brightly Colored Egg", tip="In the nook" },
	[43056628] = { obj=113768, name="Brightly Colored Egg", tip="On the ledge, behind the jugs" },
	[43096472] = { obj=113768, name="Brightly Colored Egg", tip="Alongside the lamp post" },
	[43096474] = { obj=113768, name="Brightly Colored Egg", tip="On top of the lamp post" },
	[43096587] = { obj=113768, name="Brightly Colored Egg" },
	[43116547] = { obj=113768, name="Brightly Colored Egg" },
	[43116650] = { obj=113768, name="Brightly Colored Egg" },
	[43206534] = { obj=113768, name="Brightly Colored Egg" },
	[43306657] = { obj=113768, name="Brightly Colored Egg" },
	[43456539] = { obj=113768, name="Brightly Colored Egg" },
	[43496653] = { obj=113768, name="Brightly Colored Egg", tip="High above on a ledge over the window" },
	[43496661] = { obj=113768, name="Brightly Colored Egg" },
	[43676664] = { obj=113768, name="Brightly Colored Egg" },
	[43706738] = { obj=113768, name="Brightly Colored Egg" },
	[43816551] = { obj=113768, name="Brightly Colored Egg", tip="High above on a ledge over the window" },
	[43866665] = { obj=113768, name="Brightly Colored Egg" },
	[43946653] = { obj=113768, name="Brightly Colored Egg" },
	[43976619] = { obj=113768, name="Brightly Colored Egg" },
	[44376627] = { obj=113768, name="Brightly Colored Egg" },
	[44036640] = { obj=113768, name="Brightly Colored Egg" },
	[44076635] = { obj=113768, name="Brightly Colored Egg" },
	[44436554] = { obj=113768, name="Brightly Colored Egg", tip="In a tuft of grass" },
	[44516615] = { obj=113768, name="Brightly Colored Egg" },
	[44556568] = { obj=113768, name="Brightly Colored Egg" },
}

points[ ns.eversongWoods ] = { -- Eversong Woods Shared - Falconwing Square
	[47604600] = { aID=2497, aIndexC=2, aIndexR=3, faction="Horde", tip="AnywhereS" }, -- Spring Fling
	[47784713] = { quest=13479, faction="Horde", qName="The Great Egg Hunt" },
	[58003900] = { aID=2420, faction="Horde", tip="hide" }, -- Noble Garden
--	[46704710] = { quest=74955, faction="Horde", classic=false, qName="An Egg-centric Discovery" },
	
	[46204688] = { obj=113768, name="Brightly Colored Egg", classic=false, tip="In the very centre of the egg display" },
	[46264606] = { obj=113768, name="Brightly Colored Egg", tip="Tucked in between a fence, a tree and the shrubs" },
	[46274721] = { obj=113768, name="Brightly Colored Egg", tip="Tucked in between a fence, a tree and the shrubs" },
	[46304692] = { obj=113768, name="Brightly Colored Egg", classic=true, tip="Tucked in between a fence, a tree and the shrubs" },
	[46344633] = { obj=113768, name="Brightly Colored Egg", tip="Tucked in between a fence, a tree and the shrubs" },
	[46344752] = { obj=113768, name="Brightly Colored Egg" },
	[46354661] = { obj=113768, name="Brightly Colored Egg", tip="Tucked in between a fence, a tree and the shrubs" },
	[46354802] = { obj=113768, name="Brightly Colored Egg",
					tip="Welcome to Falconwing Square.\n\nThanks for using my AddOn. Hope I helped! :)\n\n"
						.."I'm at Twitter and Ko-fi as @Taraezor.\nThere's also my project page at curseforge\n"
						.."where you might find more useful AddOns!" },
	[46384646] = { obj=113768, name="Brightly Colored Egg", tip="Between the fence and a shrub" },
	[46514557] = { obj=113768, name="Brightly Colored Egg", tip="Tucked in between a fence, a tree and the shrubs" },
	[46734801] = { obj=113768, name="Brightly Colored Egg", tip="Welcome to Flaconwing Square" },
	[46794570] = { obj=113768, name="Brightly Colored Egg", tip="Tucked in between a fence, a tree and the shrubs" },
	[46804654] = { obj=113768, name="Brightly Colored Egg", tip="Under the bench seat" },
	[46854763] = { obj=113768, name="Brightly Colored Egg", tip="Adjacent to three barrels and a hexagonal wooden drum " },
	[46884563] = { obj=113768, name="Brightly Colored Egg", tip="Between a tree trunk and the fence" },
	[46964641] = { obj=113768, name="Brightly Colored Egg", tip="In the fountain, by the edge" },
	[46974678] = { obj=113768, name="Brightly Colored Egg", tip="Under the bench seat" },
	[47004769] = { obj=113768, name="Brightly Colored Egg", tip="Between crates and a keg" },
	[47024767] = { obj=113768, name="Brightly Colored Egg", tip="Inside the stacked crates" },
	[47054626] = { obj=113768, name="Brightly Colored Egg", tip="In the fountain, by the edge" },
	[47054637] = { obj=113768, name="Brightly Colored Egg", tip="In the foundtain water, at the centre" },
	[47024645] = { obj=113768, name="Brightly Colored Egg", tip="In the foundtain water, at the centre" },
	[47064657] = { obj=113768, name="Brightly Colored Egg", tip="In the fountain, by the edge" },
	[47084644] = { obj=113768, name="Brightly Colored Egg", tip="In the foundtain water, at the centre" },
	[47084763] = { obj=113768, name="Brightly Colored Egg", tip="Under the wagon, concealled by crates" },
	[47104545] = { obj=113768, name="Brightly Colored Egg", tip="Jammed between the fence corner and a tree" },
	[47104607] = { obj=113768, name="Brightly Colored Egg", tip="Under the bench seat" },
	[47154771] = { obj=113768, name="Brightly Colored Egg", tip="Alongside a front wagon wheel" },
	[47164641] = { obj=113768, name="Brightly Colored Egg", tip="In the fountain, by the edge" },
	[47224791] = { obj=113768, name="Brightly Colored Egg" },
	[47244778] = { obj=113768, name="Brightly Colored Egg" },
	[47274534] = { obj=113768, name="Brightly Colored Egg", tip="Between a tree trunk and the fence" },
	[47274753] = { obj=113768, name="Brightly Colored Egg" },
	[47284630] = { obj=113768, name="Brightly Colored Egg", tip="Under the bench seat" },
	[47334754] = { obj=113768, name="Brightly Colored Egg" },
	[47464745] = { obj=113768, name="Brightly Colored Egg" },
	[47484526] = { obj=113768, name="Brightly Colored Egg", tip="Between the fence and a tree" },
	[47544527] = { obj=113768, name="Brightly Colored Egg", tip="Between a rear wagon wheel and the fence" },
	[47544539] = { obj=113768, name="Brightly Colored Egg", tip="Under the wagon, adjacent to a rear wheel" },
	[47554741] = { obj=113768, name="Brightly Colored Egg" },
	[47564535] = { obj=113768, name="Brightly Colored Egg", tip="In the wagon" },
	[47604527] = { obj=113768, name="Brightly Colored Egg", tip="Adjacent to a front wheel of the wagon" },
	[47604539] = { obj=113768, name="Brightly Colored Egg", tip="Under the wagon, adjacent to a front wheel" },
	[47634750] = { obj=113768, name="Brightly Colored Egg", tip="Let's stash it behind the tree man, nobody'll look here!" },
	[47694521] = { obj=113768, name="Brightly Colored Egg", tip="Between a tree trunk and the fence / lamp post" },
	[47774553] = { obj=113768, name="Brightly Colored Egg" },
	[47834687] = { obj=113768, name="Brightly Colored Egg" },
	[47874690] = { obj=113768, name="Brightly Colored Egg" },
	[47904709] = { obj=113768, name="Brightly Colored Egg" },
	[47914672] = { obj=113768, name="Brightly Colored Egg" },
	[47924524] = { obj=113768, name="Brightly Colored Egg" },
	[47944546] = { obj=113768, name="Brightly Colored Egg", tip="Behind the tree" },
	[47964649] = { obj=113768, name="Brightly Colored Egg" },
	[47984556] = { obj=113768, name="Brightly Colored Egg" },
	[47994584] = { obj=113768, name="Brightly Colored Egg" },
	[48004657] = { obj=113768, name="Brightly Colored Egg" },
	[48054567] = { obj=113768, name="Brightly Colored Egg", tip="Behind the tree" },
	[48134564] = { obj=113768, name="Brightly Colored Egg" },
	[48134586] = { obj=113768, name="Brightly Colored Egg", tip="Nah braaaah, if we stash it in the open here nobody'll think to look!\n\n"
															.."Brilliant man, why didn't I think of that!" },
	[48134649] = { obj=113768, name="Brightly Colored Egg" },
}

points[ 7 ] = { -- Mulgore Retail - Bloodhoof Village
	[47905700] = { aID=2497, aIndex=1, faction="Horde", tip="AnywhereC" }, -- Spring Fling
	[46935953] = { quest=13479, faction="Horde", qName="The Great Egg Hunt" },
--	[46405830] = { quest=74955, faction="Horde", qName="An Egg-centric Discovery" },

	[45055775] = { obj=113768, name="Brightly Colored Egg" },
	[45165818] = { obj=113768, name="Brightly Colored Egg" },
	[45205949] = { obj=113768, name="Brightly Colored Egg" },
	[45345921] = { obj=113768, name="Brightly Colored Egg" },
	[45525793] = { obj=113768, name="Brightly Colored Egg" },
	[45685705] = { obj=113768, name="Brightly Colored Egg" },
	[45745833] = { obj=113768, name="Brightly Colored Egg" },
	[45886003] = { obj=113768, name="Brightly Colored Egg",
					tip="You'll probably miss this one if your\nOptions->Graphics->Ground Clutter\nsetting is high" },
	[45995634] = { obj=113768, name="Brightly Colored Egg" },
	[45995688] = { obj=113768, name="Brightly Colored Egg" },
	[46056006] = { obj=113768, name="Brightly Colored Egg" },
	[46105953] = { obj=113768, name="Brightly Colored Egg", tip="Between three wicker/skin baskets" },
	[46196064] = { obj=113768, name="Brightly Colored Egg" },
	[46296162] = { obj=113768, name="Brightly Colored Egg", tip="Under the canoe in the water. Wicked stealth!" },
	[46315702] = { obj=113768, name="Brightly Colored Egg" },
	[46386149] = { obj=113768, name="Brightly Colored Egg", tip="Under the canoe" },
	[46446092] = { obj=113768, name="Brightly Colored Egg", tip="Between the beams" },
	[46505739] = { obj=113768, name="Brightly Colored Egg", tip="Under the bath, tent side. Well hidden!" },
	[46525736] = { obj=113768, name="Brightly Colored Egg", tip="In the centre of the bath" },
	[46616109] = { obj=113768, name="Brightly Colored Egg", tip="Under the canoe. So tricky!" },
	[46656035] = { obj=113768, name="Brightly Colored Egg" },
	[46685749] = { obj=113768, name="Brightly Colored Egg", tip="Alongside the tent post" },
	[46686113] = { obj=113768, name="Brightly Colored Egg", tip="Under the canoe. So tricky!" },
	[46775993] = { obj=113768, name="Brightly Colored Egg" },
	[46805985] = { obj=113768, name="Brightly Colored Egg", tip="Another egg nook" },
	[46856122] = { obj=113768, name="Brightly Colored Egg", tip="Another egg nook" },
	[46875983] = { obj=113768, name="Brightly Colored Egg", tip="Also well concealed at the back here!" },
	[47016061] = { obj=113768, name="Brightly Colored Egg" },
	[47116034] = { obj=113768, name="Brightly Colored Egg", tip="Under the bath, building side. Well hidden!" },
	[47146002] = { obj=113768, name="Brightly Colored Egg", tip="Well concealed at the back here!" },
	[47146018] = { obj=113768, name="Brightly Colored Egg", tip="In the corner covered by grass" },
	[47146036] = { obj=113768, name="Brightly Colored Egg", tip="In the centre of the bath" },
	[47166011] = { obj=113768, name="Brightly Colored Egg", tip="A good nook to hide an egg!" },
	[47215646] = { obj=113768, name="Brightly Colored Egg", tip="Between three wicker/skin baskets" },
	[47265638] = { obj=113768, name="Brightly Colored Egg", tip="Beneath the huge drum" },
	[47505936] = { obj=113768, name="Brightly Colored Egg", tip="Under/behind the sled" },
	[47586186] = { obj=113768, name="Brightly Colored Egg" },
	[47605944] = { obj=113768, name="Brightly Colored Egg", tip="Between a wicker/skin basket and the totem" },
	[47615941] = { obj=113768, name="Brightly Colored Egg", tip="Inside the urn. Well hidden!" },
	[47635433] = { obj=113768, name="Brightly Colored Egg" },
	[47715807] = { obj=113768, name="Brightly Colored Egg", tip="Between three wicker/skin baskets\n\n"
					.."Since you like eggs... why not try my \"Adorable Raptor\nHatchlings\" AddOn? It is the only AddOn and indeed\n"
					.."is essential to trivially acquire a set of delightfully\nadorable baby raptor hatchling pets!" },
	[47726182] = { obj=113768, name="Brightly Colored Egg",
					tip="Very well concealed by the grass!\n\nOptions->Graphics->Ground Clutter\nis best set to zero!" },
	[47746145] = { obj=113768, name="Brightly Colored Egg", tip="Atop the flameless smoker" },
	[47785540] = { obj=113768, name="Brightly Colored Egg", tip="At the base of the loom" },
	[47835562] = { obj=113768, name="Brightly Colored Egg", tip="Beneath the plainstrider carcass" },
	[47845550] = { obj=113768, name="Brightly Colored Egg", tip="Beneath the plainstrider carcass" },
	[47956077] = { obj=113768, name="Brightly Colored Egg", tip="Under/behind the sled" },
	[47975525] = { obj=113768, name="Brightly Colored Egg", tip="At the base of the brazier-style lamp" },
	[48035998] = { obj=113768, name="Brightly Colored Egg", tip="In the totem brazier. May the spirits\nguide you... the chocolate didn't melt!" },
	[48165864] = { obj=113768, name="Brightly Colored Egg", tip="At the base of the support beam, hidden in the grass!" },
	[48285941] = { obj=113768, name="Brightly Colored Egg" },
	[48615961] = { obj=113768, name="Brightly Colored Egg", tip="Between the straw target dummy and the pavilion platform" },
	[48785818] = { obj=113768, name="Brightly Colored Egg", tip="Between the stair planks. Genius!" },
	[48815804] = { obj=113768, name="Brightly Colored Egg", tip="Between the stair planks. Brilliant!" },
	[48845792] = { obj=113768, name="Brightly Colored Egg", tip="Between the stair planks. Clever!" },
	[48885782] = { obj=113768, name="Brightly Colored Egg", tip="Between the stair planks. Devious!" },
	[48985940] = { obj=113768, name="Brightly Colored Egg", tip="Between the stair planks. Genius!" },
	[49025955] = { obj=113768, name="Brightly Colored Egg", tip="Between the stair planks. Brilliant!" },
	[49085963] = { obj=113768, name="Brightly Colored Egg", tip="Between the stair planks. Clever!" },
}

points[ 1412 ] = { -- Mulgore Classic - Bloodhoof Village
	[48305720] = { aID=2497, aIndex=4, faction="Horde", tip="AnywhereC" }, -- Spring Fling
	[46746011] = { quest=13479, faction="Horde", qName="The Great Egg Hunt" },

	[44755823] = { obj=113768, name="Brightly Colored Egg" },
	[44865868] = { obj=113768, name="Brightly Colored Egg" },
	[44916007] = { obj=113768, name="Brightly Colored Egg" },
	[45065977] = { obj=113768, name="Brightly Colored Egg" },
	[45255841] = { obj=113768, name="Brightly Colored Egg" },
	[45415748] = { obj=113768, name="Brightly Colored Egg" },
	[45485883] = { obj=113768, name="Brightly Colored Egg" },
	[45636064] = { obj=113768, name="Brightly Colored Egg" },
	[45755672] = { obj=113768, name="Brightly Colored Egg" },
	[45866012] = { obj=113768, name="Brightly Colored Egg", tip="Between three wicker/skin baskets" },
	[45925920] = { obj=113768, name="Brightly Colored Egg" },
	[45966128] = { obj=113768, name="Brightly Colored Egg" },
	[46066233] = { obj=113768, name="Brightly Colored Egg", tip="In a wicker crate in a canoe" },
	[46085745] = { obj=113768, name="Brightly Colored Egg" },
	[46166219] = { obj=113768, name="Brightly Colored Egg", tip="In a canoe" },
	[46226159] = { obj=113768, name="Brightly Colored Egg" },
	[46295783] = { obj=113768, name="Brightly Colored Egg", tip="Under the bath, tent side. Well hidden!" },
	[46315781] = { obj=113768, name="Brightly Colored Egg", tip="In the centre of the bath" },
	[46406177] = { obj=113768, name="Brightly Colored Egg", tip="Under the canoe. So tricky!\n\n((Worse awaits in Brill Classic OR Retail!!!))" },
	[46446098] = { obj=113768, name="Brightly Colored Egg" },
	[46476181] = { obj=113768, name="Brightly Colored Egg", tip="Under the canoe. So devious!" },
	[46485795] = { obj=113768, name="Brightly Colored Egg" },
	[46586053] = { obj=113768, name="Brightly Colored Egg" },
	[46606045] = { obj=113768, name="Brightly Colored Egg" },
	[46676042] = { obj=113768, name="Brightly Colored Egg" },
	[46836125] = { obj=113768, name="Brightly Colored Egg" },
	[46946097] = { obj=113768, name="Brightly Colored Egg", tip="Under the bath, building side. Well hidden!" },
	[46966063] = { obj=113768, name="Brightly Colored Egg" },
	[46995715] = { obj=113768, name="Brightly Colored Egg", tip="Inside the flat woven bowl" },
	[46996072] = { obj=113768, name="Brightly Colored Egg" },
	[47045684] = { obj=113768, name="Brightly Colored Egg", tip="Between three wicker/skin baskets" },
	[47105675] = { obj=113768, name="Brightly Colored Egg", tip="Beneath the huge drum" },
	[47345992] = { obj=113768, name="Brightly Colored Egg", tip="Under/behind the sled" },
	[47436258] = { obj=113768, name="Brightly Colored Egg" },
	[47466002] = { obj=113768, name="Brightly Colored Egg", tip="Between a wicker/skin basket and the totem" },
	[47475998] = { obj=113768, name="Brightly Colored Egg", tip="Inside the urn. Well hidden!" },
	[47495459] = { obj=113768, name="Brightly Colored Egg" },
	[47585857] = { obj=113768, name="Brightly Colored Egg", tip="Between three wicker/skin baskets\n\n"
					.."Since you like eggs... why not try my \"Adorable Raptor\nHatchlings\" AddOn? It is the only AddOn and indeed\n"
					.."is essential to trivially acquire a set of delightfully\nadorable baby raptor hatchling pets!" },
	[47616215] = { obj=113768, name="Brightly Colored Egg", tip="Atop the flameless smoker" },
	[47645574] = { obj=113768, name="Brightly Colored Egg", tip="At the base of the loom" },
	[47705596] = { obj=113768, name="Brightly Colored Egg", tip="Beneath the plainstrider carcass" },
	[47836143] = { obj=113768, name="Brightly Colored Egg", tip="Under/behind the sled" },
	[47855558] = { obj=113768, name="Brightly Colored Egg" },
	[48175998] = { obj=113768, name="Brightly Colored Egg" },
	[48536020] = { obj=113768, name="Brightly Colored Egg", tip="Between the straw target dummy and the pavilion platform" },
	[48775840] = { obj=113768, name="Brightly Colored Egg", tip="Between the stair planks. Devious!" },
	[48815830] = { obj=113768, name="Brightly Colored Egg", tip="Between the stair planks. Well hidden!" },
	[48915997] = { obj=113768, name="Brightly Colored Egg", tip="Between the steps and the pavilion platform" },
	[48966012] = { obj=113768, name="Brightly Colored Egg", tip="Between the stair planks. Clever!" },
	[49026022] = { obj=113768, name="Brightly Colored Egg", tip="Between the stair planks. Tricky!" },
}

points[ 81 ] = { -- Silithus Retail
	[73003100] = { aID=2436, aIndex=3, tip="AnywhereZR" }, -- Desert Rose
}
points[ 1451 ] = { -- Silithus Wrath
	[55003800] = { aID=2416, tip="hb3", name="Cenarion Hold" }, -- Hard Boiled
	[73003300] = { aID=2436, aIndex=1, tip="AnywhereZW" }, -- Desert Rose
}

points[ ns.silvermoonCity ] = { -- Silvermoon City
	[66002780] = { aID=2420, faction="Horde", tip="hide" }, -- Noble Garden
}

points[ ns.stormwindCity ] = { -- Stormwind City
	[50945672] = { aID=2421, faction="Alliance", tip="hide" }, -- Noble Garden
}

points[ 71 ] = { -- Tanaris Retail
	[48002680] = { aID=2436, aIndex=4, tip="AnywhereZR" }, -- Desert Rose
}
points[ 1446 ] = { -- Tanaris Classic
	[48002680] = { aID=2436, aIndex=3, tip="AnywhereZW" }, -- Desert Rose
}

points[ 57 ] = { -- Teldrassil Retail - Dolanaar
	[56805210] = { aID=2419, aIndex=2, faction="Alliance", tip="AnywhereT" }, -- Spring Fling
	[55595136] = { quest=13480, faction="Alliance", qName="The Great Egg Hunt" },
--	[56205380] = { quest=73192, faction="Alliance", qName="An Egg-centric Discovery" },

	[55145061] = { obj=113768, name="Brightly Colored Egg" },
	[55235447] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[55265437] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[55295428] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[55445122] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[55445134] = { obj=113768, name="Brightly Colored Egg" },
	[55455140] = { obj=113768, name="Brightly Colored Egg" },
	[55465201] = { obj=113768, name="Brightly Colored Egg" },
	[55525231] = { obj=113768, name="Brightly Colored Egg" },
	[55535082] = { obj=113768, name="Brightly Colored Egg", tip="Under the perambulator" },
	[55585415] = { obj=113768, name="Brightly Colored Egg" },
	[55595269] = { obj=113768, name="Brightly Colored Egg", tip="Half concealed in the shrubbery and half\n"
															.."wedged between the shrubbery and the tree" },
	[55615541] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[55645285] = { obj=113768, name="Brightly Colored Egg" },
	[55674986] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[55695398] = { obj=113768, name="Brightly Colored Egg", tip="In the pool" },
	[55755035] = { obj=113768, name="Brightly Colored Egg", tip="Under the ramp" },
	[55755285] = { obj=113768, name="Brightly Colored Egg", },
	[55805018] = { obj=113768, name="Brightly Colored Egg", tip="On top of the pitcher" },
	[55805107] = { obj=113768, name="Brightly Colored Egg", tip="Between the mailbox and the ramp" },
	[56025133] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56035557] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56055169] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56085180] = { obj=113768, name="Brightly Colored Egg", tip="Under the perambulator" },
	[56095550] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56115192] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56155195] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56155205] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56155267] = { obj=113768, name="Brightly Colored Egg" },
	[56175244] = { obj=113768, name="Brightly Colored Egg" },
	[56185161] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56185268] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56195010] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56205216] = { obj=113768, name="Brightly Colored Egg", tip="Wedged between the pitchers and the ramp" },
	[56205526] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56215263] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56225215] = { obj=113768, name="Brightly Colored Egg", tip="On top of the pitcher" },
	[56225254] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56235006] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56245326] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56255156] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56295151] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56325236] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56345228] = { obj=113768, name="Brightly Colored Egg", tip="Under the seat" },
	[56355236] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56415168] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56555078] = { obj=113768, name="Brightly Colored Egg", tip="Under the seat" },
	[56565074] = { obj=113768, name="Brightly Colored Egg", tip="On top of the pitcher" },
	[56595073] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56715355] = { obj=113768, name="Brightly Colored Egg", tip="Under the table of food" },
	[56835300] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56885281] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56915321] = { obj=113768, name="Brightly Colored Egg", tip="In the pool" },
	[57065266] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[57215319] = { obj=113768, name="Brightly Colored Egg" },
	[57265282] = { obj=113768, name="Brightly Colored Egg" },
}

points[ 1438 ] = { -- Teldrassil Classic - Dolanaar
	[54705930] = { aID=2419, aIndex=4, faction="Alliance", tip="AnywhereT" }, -- Spring Fling
	[55885878] = { quest=13480, faction="Alliance", qName="The Great Egg Hunt" },

	[55466237] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[55506225] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[55535774] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[55536216] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[55565791] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[55705876] = { obj=113768, name="Brightly Colored Egg" },
	[55715862] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[55715883] = { obj=113768, name="Brightly Colored Egg" },
	[55735953] = { obj=113768, name="Brightly Colored Egg" },
	[55805815] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[55805987] = { obj=113768, name="Brightly Colored Egg" },
	[55876200] = { obj=113768, name="Brightly Colored Egg" },
	[55886032] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[55906346] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[55936050] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[55975705] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[55996181] = { obj=113768, name="Brightly Colored Egg", tip="In the pool" },
	[56066050] = { obj=113768, name="Brightly Colored Egg" },
	[56075762] = { obj=113768, name="Brightly Colored Egg", tip="Under the ramp" },
	[56115742] = { obj=113768, name="Brightly Colored Egg", tip="On top of the pitcher" },
	[56125746] = { obj=113768, name="Brightly Colored Egg", tip="Wedged between the pitchers and the ramp" },
	[56135845] = { obj=113768, name="Brightly Colored Egg", tip="Between the mailbox and the ramp" },
	[56305877] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56375874] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56396364] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56415916] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56455930] = { obj=113768, name="Brightly Colored Egg", tip="Under the perambulator" },
	[56456357] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56485944] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56526029] = { obj=113768, name="Brightly Colored Egg" },
	[56535957] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56556003] = { obj=113768, name="Brightly Colored Egg" },
	[56566031] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56575732] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56575907] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56585970] = { obj=113768, name="Brightly Colored Egg", tip="Alongside the pitcher" },
	[56586329] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56605970] = { obj=113768, name="Brightly Colored Egg", tip="On top of the pitcher" },
	[56616014] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56695895] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56725994] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56755994] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56835915] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56995808] = { obj=113768, name="Brightly Colored Egg", tip="On top of the pitcher" },
	[56995812] = { obj=113768, name="Brightly Colored Egg", tip="Under the seat" },
	[57035806] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[57316068] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[57366045] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[57406091] = { obj=113768, name="Brightly Colored Egg", tip="In the pool" },
	[57746089] = { obj=113768, name="Brightly Colored Egg" },
	[57806046] = { obj=113768, name="Brightly Colored Egg" },
}

points[ 64 ] = { -- Thousand Needles Retail
	[75007600] = { aID=2436, aIndex=5, tip="AnywhereZR" }, -- Desert Rose
}
points[ 1441 ] = { -- Thousand Needles Wrath
	[75007600] = { aID=2436, aIndex=5, tip="AnywhereZW" }, -- Desert Rose
}

points[ 18 ] = { -- Tirisfal Glades Retail - Brill
	[60905090] = { aID=2497, aIndex=2, faction="Horde", tip="AnywhereT" }, -- Spring Fling
	[61605300] = { quest=13479, faction="Horde", qName="The Great Egg Hunt" },
--	[60005150] = { quest=74955, faction="Horde", qName="An Egg-centric Discovery" },

	[59435221] = { obj=113768, name="Brightly Colored Egg", tip="Inside the tent" },
	[59525231] = { obj=113768, name="Brightly Colored Egg", tip="Inside the tent" },
	[59615325] = { obj=113768, name="Brightly Colored Egg", tip="Inside the alcove, to the left as you enter.\n"
																.."To the right as you leave if I'm not mistaken" },
	[59655271] = { obj=113768, name="Brightly Colored Egg", tip="Look up! Between two arcing beams of the plague centrifuge" },
	[59805241] = { obj=113768, name="Brightly Colored Egg", tip="Inside the small broken barrel" },
	[59805270] = { obj=113768, name="Brightly Colored Egg", tip="Above, in a nook of the plague centrifuge machine" },
	[59875243] = { obj=113768, name="Brightly Colored Egg", tip="Trisected by the plague barrels" },
	[59905375] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[59925213] = { obj=113768, name="Brightly Colored Egg", tip="Nestled snugly in the... erm...\n"
					.."\"private parts\" of the unlucky ogre.\n\nWARNING: Extract carefully to avoid\n"
					.."unnecessary spillage of entrails!\n\nNow look down at the bench...\nthe ogre is watching you!" },
	[59955221] = { obj=113768, name="Brightly Colored Egg", tip="In the upheld palm of the rotting ogre corpse.\n\n"
					.."Gotta hand it to... erm... enough puns...\n\nBut that's a serious case of rigour mortis!" },
	[59955249] = { obj=113768, name="Brightly Colored Egg", tip="Behind the planter box" },
	[60045213] = { obj=113768, name="Brightly Colored Egg", tip="Perched on the street lamp" },
	[60085256] = { obj=113768, name="Brightly Colored Egg", tip="To the right side of the steps as you enter" },
	[60085355] = { obj=113768, name="Brightly Colored Egg", tip="In the alcove" },
	[60205348] = { obj=113768, name="Brightly Colored Egg", tip="Behind and at one end of the crates" },
	[60305257] = { obj=113768, name="Brightly Colored Egg", tip="In the nook" },
	[60325276] = { obj=113768, name="Brightly Colored Egg", tip="Jammed in tight here" },
	[60375324] = { obj=113768, name="Brightly Colored Egg", tip="Mounted on the apothecary apparatus" },
	[60405089] = { obj=113768, name="Brightly Colored Egg", tip="Above, on a window ledge" },
	[60425308] = { obj=113768, name="Brightly Colored Egg", tip="Behind the two barrels" },
	[60495155] = { obj=113768, name="Brightly Colored Egg", tip="Above, in the catapault basket!" },
	[60505251] = { obj=113768, name="Brightly Colored Egg", tip="Perched on the street lamp" },
	[60535059] = { obj=113768, name="Brightly Colored Egg" },
	[60545275] = { obj=113768, name="Brightly Colored Egg", tip="In the cart, at the high end, hidden by the plague casks" },
	[60595127] = { obj=113768, name="Brightly Colored Egg", tip="In the nook here" },
	[60595338] = { obj=113768, name="Brightly Colored Egg", tip="On top of the wheel of the plague tanker" },
	[60675206] = { obj=113768, name="Brightly Colored Egg", tip="Perched on the street lamp" },
	[60685352] = { obj=113768, name="Brightly Colored Egg", tip="On top of the wheel of the plague tanker" },
	[60755185] = { obj=113768, name="Brightly Colored Egg", tip="On the window ledge" },
	[60905223] = { obj=113768, name="Brightly Colored Egg",
					tip="Perched on the street lamp.\n\nYup, that's every street lamp. I checked. Sigh..." },
	[60995197] = { obj=113768, name="Brightly Colored Egg", tip="Between the wall and two casks" },
	[61115308] = { obj=113768, name="Brightly Colored Egg", tip="Within the iron fence at the base of statue of the Banshee Queen.\n\n"
					.."\"I can feel Thrall's anger at Arthas, but it pales before my own.\n"
					.."Were he as furious as any one of the Forsaken, the Horde's armies\n"
					.."would unleash their rage upon Northrend and eradicate all Scourge\nfrom that cursed, frozen wasteland\"" },
	[61125012] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery. Glad they're not all like that!\n\n"
					.."((Fun fact: In Wrath almost all the eggs were concealed\nlike this, making Brill despised for egg farming!))" },
	[61125184] = { obj=113768, name="Brightly Colored Egg", tip="Behind and at the base of the crates" },
	[61145381] = { obj=113768, name="Brightly Colored Egg", tip="adjacent to the wayfinding sign" },
	[61155187] = { obj=113768, name="Brightly Colored Egg", tip="On top of the highest of the stacked crates!" },
	[61164982] = { obj=113768, name="Brightly Colored Egg", tip="Ew! Buried in the (night) soil" },
	[61165233] = { obj=113768, name="Brightly Colored Egg", tip="On the chef's stove" },
	[61175237] = { obj=113768, name="Brightly Colored Egg", tip="(Almost) the BEST hidden egg in all of Azeroth.\n\n"
					.."Stand here and look up! Perched on the cross beams!\n\n(The best is at Bloodhoof Village!)" },
	[61235298] = { obj=113768, name="Brightly Colored Egg",
					tip="Within the iron fence at the base of the statue\nof The Dark Lady, who surely watches over us" },
	[61235237] = { obj=113768, name="Brightly Colored Egg", tip="In the centre and under the meat chopping bench" },
	[61275168] = { obj=113768, name="Brightly Colored Egg", tip="In the pet carrying box" },
	[61295090] = { obj=113768, name="Brightly Colored Egg", tip="On the slimest of window sills" },
	[61415088] = { obj=113768, name="Brightly Colored Egg" },
	[61455121] = { obj=113768, name="Brightly Colored Egg", tip="Above, on a window ledge" },
	[61455320] = { obj=113768, name="Brightly Colored Egg", tip="Perched on the street lamp" },
	[61485293] = { obj=113768, name="Brightly Colored Egg", tip="Perched on the street lamp" },
	[61515106] = { obj=113768, name="Brightly Colored Egg", tip="Inside the small broken barrel" },
	[61525172] = { obj=113768, name="Brightly Colored Egg", tip="In a corner of the low end of the cart" },
	[61675280] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[61755351] = { obj=113768, name="Brightly Colored Egg", tip="Behind two small plague barrels" },
	[61765286] = { obj=113768, name="Brightly Colored Egg", tip="Wedged in tight!" },
	[61835310] = { obj=113768, name="Brightly Colored Egg", tip="Wedged in tight!" },
	[61895327] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[61965209] = { obj=113768, name="Brightly Colored Egg", tip="Sitting on the skeletal horses' food" },
	[62105169] = { obj=113768, name="Brightly Colored Egg", tip="Sitting on the skeletal horses' food" },
	[62205338] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[62255188] = { obj=113768, name="Brightly Colored Egg", tip="Under the meat wagon" },
	[62265279] = { obj=113768, name="Brightly Colored Egg", tip="Upon the split cask" },
}

points[ 1420 ] = { -- Tirisfal Glades Classic - Brill
	[60815152] = { aID=2497, aIndex=3, faction="Horde", tip="AnywhereT" }, -- Spring Fling
	[61635311] = { quest=13479, faction="Horde", qName="The Great Egg Hunt" },

	[59295232] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[59355219] = { obj=113768, name="Brightly Colored Egg", tip="Above, in the planter box" },
	[59395204] = { obj=113768, name="Brightly Colored Egg", tip="Inside the broken keg" },
	[59465259] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[59495201] = { obj=113768, name="Brightly Colored Egg", tip="In the planter box" },
	[59665211] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[59665283] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[59695390] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[59705290] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[59725136] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[59765293] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[59895205] = { obj=113768, name="Brightly Colored Egg", tip="On top of the street lamp" },
	[59925320] = { obj=113768, name="Brightly Colored Egg" },
	[60015363] = { obj=113768, name="Brightly Colored Egg" },
	[60375368] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[60385100] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[60395407] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[60435358] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[60455103] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[60565011] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[60645007] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[60655136] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[60925335] = { obj=113768, name="Brightly Colored Egg", tip="In the well" },
	[60985181] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[61025168] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[61165141] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[61245036] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[61245254] = { obj=113768, name="Brightly Colored Egg", tip="Under the General Supplies cart" },
	[61435265] = { obj=113768, name="Brightly Colored Egg", tip="Under the window sill/bench" },
	[61445048] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[61445257] = { obj=113768, name="Brightly Colored Egg", tip="Under the window sill/bench" },
	[61455093] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[61485288] = { obj=113768, name="Brightly Colored Egg", tip="In a nook but the view is blocked by shrubbery" },
	[61495164] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[61495208] = { obj=113768, name="Brightly Colored Egg", tip="Under the window sill/bench" },
	[61505084] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[61515201] = { obj=113768, name="Brightly Colored Egg", tip="Under the window sill/bench" },
	[61525145] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[61545173] = { obj=113768, name="Brightly Colored Egg", tip="Behind the stacked boxes, well concealed!" },
	[61565354] = { obj=113768, name="Brightly Colored Egg", tip="On top of the street lamp" },
	[61655122] = { obj=113768, name="Brightly Colored Egg", tip="Behind the crate and the dilapidated keg" },
	[61795295] = { obj=113768, name="Brightly Colored Egg", tip="Under the window sill/bench and\nconcealed by shrubbery. Doubly hidden!" },
	[61865128] = { obj=113768, name="Brightly Colored Egg", tip="Behind two kegs" },
	[61885191] = { obj=113768, name="Brightly Colored Egg" },
	[61895296] = { obj=113768, name="Brightly Colored Egg", tip="Under the window sill/bench and\nconcealed by shrubbery. Doubly hidden!" },
	[61965172] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[62035188] = { obj=113768, name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[62035264] = { obj=113768, name="Brightly Colored Egg" },
}
points[ 78 ] = { -- UnGoro Crater Retail
	[54406240] = { aID=2416, tip="hb1", name="Marshall's Stand" }, -- Hard Boiled
	[35805105] = { aID=2416, tip="hb2", name="Golakka Hot Springs" }, -- Hard Boiled
}
points[ 1449 ] = { -- UnGoro Crater Wrath
	[30604880] = { aID=2416, tip="hb2", name="Golakka Hot Springs" }, -- Hard Boiled
}

points[ 12 ] = { -- Kalimdor Retail - Special for Teldrassil/Dolanaar
	[43941020] = { aID=2419, aIndex=2, faction="Alliance", tip="AnywhereT" }, -- Spring Fling
	[43741008] = { quest=13480, faction="Alliance", qName="The Great Egg Hunt" },
--	[43841047] = { quest=73192, faction="Alliance", qName="An Egg-centric Discovery" },
}
points[ 1414 ] = { --Kalimdor Classic Special case
	[43581215] = { aID=2419, aIndex=4, faction="Alliance", tip="AnywhereT" }, -- Spring Fling
	[44001200] = { quest=13480, faction="Alliance", qName="The Great Egg Hunt" }, -- Not exact coord translation
}
	
-- Choice of texture
-- Note that these textures are all repurposed and as such have non-uniform sizing. I've copied my scaling factors from my old AddOn
-- in order to homogenise the sizes. I should also allow for non-uniform origin placement as well as adjust the x,y offsets
textures[1] = "Interface\\PlayerFrame\\MonkLightPower"
textures[2] = "Interface\\PlayerFrame\\MonkDarkPower"
textures[3] = "Interface\\Common\\Indicator-Red"
textures[4] = "Interface\\Common\\Indicator-Yellow"
textures[5] = "Interface\\Common\\Indicator-Green"
textures[6] = "Interface\\Common\\Indicator-Gray"
textures[7] = "Interface\\Common\\Friendship-ManaOrb"	
textures[8] = "Interface\\TargetingFrame\\UI-PhasingIcon"
textures[9] = "Interface\\Store\\Category-icon-pets"
textures[10] = "Interface\\Store\\Category-icon-featured"
textures[11] = "Interface\\AddOns\\HandyNotes_NobleGarden\\NobleA"
textures[12] = "Interface\\AddOns\\HandyNotes_NobleGarden\\NobleG"
textures[13] = "Interface\\AddOns\\HandyNotes_NobleGarden\\NobleP"
textures[14] = "Interface\\AddOns\\HandyNotes_NobleGarden\\NobleH"
textures[15] = "Interface\\AddOns\\HandyNotes_NobleGarden\\NobleO"
textures[16] = "Interface\\AddOns\\HandyNotes_NobleGarden\\NobleY"

scaling[1] = 0.68
scaling[2] = 0.68
scaling[3] = 0.66
scaling[4] = 0.66
scaling[5] = 0.66
scaling[6] = 0.66
scaling[7] = 0.76
scaling[8] = 0.76
scaling[9] = 0.96
scaling[10] = 0.96
scaling[11] = 0.6
scaling[12] = 0.6
scaling[13] = 0.6
scaling[14] = 0.6
scaling[15] = 0.6
scaling[16] = 0.6
