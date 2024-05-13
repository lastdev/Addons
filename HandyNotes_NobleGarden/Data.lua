local _, ns = ...
local points = ns.points
local textures = ns.textures
local scaling = ns.scaling

-- Safe place for Alliance to camp Retail. Razor Hill (50.67,41.63), (54.95,42.64)

points[ ns.azuremystIsle ] = { -- Azuremyst Isle Shared - Azure Watch
	[49075125] = { quest=13480, faction="Alliance", qName="The Great Egg Hunt" },
	[49405010] = { aID=2419, aIndexC=1, aIndexR=1, faction="Alliance", tip="AnywhereC" }, -- Spring Fling
--	[50005140] = { quest=73192, faction="Alliance", preCata=false, qName="An Egg-centric Discovery" },

	[47345019] = { name="Brightly Colored Egg", preWrath=false },
	[47545192] = { name="Brightly Colored Egg", preWrath=false },
	[47615131] = { name="Brightly Colored Egg", preWrath=false, tip="In the crate" },
	[47665211] = { name="Brightly Colored Egg", preWrath=false },
	[47695135] = { name="Brightly Colored Egg", preWrath=false, tip="Under the bellows" },
	[47735170] = { name="Brightly Colored Egg", preWrath=false, tip="Deep under the logs" },
	[47775248] = { name="Brightly Colored Egg", preWrath=false },
	[47925050] = { name="Brightly Colored Egg", preWrath=false },
	[47934994] = { name="Brightly Colored Egg", preWrath=false },
	[47935032] = { name="Brightly Colored Egg", preWrath=false, tip="Above, on a ledge" },
	[48044918] = { name="Brightly Colored Egg", preWrath=false, tip="Foot of the tree" },
	[48094925] = { name="Brightly Colored Egg", preWrath=false, tip="Wedged between the tree and the wall" },
	[48175278] = { name="Brightly Colored Egg", preWrath=false },
	[48225026] = { name="Brightly Colored Egg", dragonFlight=true, tip="Under the wreath/easle" },
	[48275249] = { name="Brightly Colored Egg", preWrath=false, tip="Under the foliage" },
	[48295289] = { name="Brightly Colored Egg", preWrath=false },
	[48304878] = { name="Brightly Colored Egg", preWrath=false },
	[48425287] = { name="Brightly Colored Egg", preWrath=false, tip="Under the foliage" },
	[48444994] = { name="Brightly Colored Egg", preWrath=false },
	[48555000] = { name="Brightly Colored Egg", preWrath=false },
	[48665006] = { name="Brightly Colored Egg", preWrath=false, tip="Under the crystal light" },
	[48695268] = { name="Brightly Colored Egg", preWrath=false },
	[48754838] = { name="Brightly Colored Egg", preWrath=false },
	[48774909] = { name="Brightly Colored Egg", preWrath=false },
	[48814923] = { name="Brightly Colored Egg", preWrath=false },
	[48864953] = { name="Brightly Colored Egg", preWrath=false },
	[48904976] = { name="Brightly Colored Egg", preWrath=false, tip="Under the crystal light" },
	[49085116] = { name="Brightly Colored Egg", preWrath=false },
	[49115094] = { name="Brightly Colored Egg", preWrath=false, continentShow=true },
	[49115103] = { name="Brightly Colored Egg", preWrath=false },
	[49125085] = { name="Brightly Colored Egg", preWrath=false },
	[49165110] = { name="Brightly Colored Egg", preWrath=false },
	[49185089] = { name="Brightly Colored Egg", preWrath=false },
	[49225096] = { name="Brightly Colored Egg", preWrath=false },
	[49255073] = { name="Brightly Colored Egg", dragonFlight=true, tip="Inside the Noblegarden crate" },
	[49285228] = { name="Brightly Colored Egg", preWrath=false, tip="Under the crystal light" },
	[49295102] = { name="Brightly Colored Egg", preWrath=false, tip="Since you like eggs... why not try my \"Adorable Raptor\n"
					.."Hatchlings\" AddOn? It is the only AddOn and indeed\nis essential to trivially acquire a set of "
					.."delightfully\nadorable baby raptor hatchling pets!" },
	[49305251] = { name="Brightly Colored Egg", preWrath=false, tip="Inside, behind stacked containers" },
	[49315263] = { name="Brightly Colored Egg", preWrath=false, tip="In the crate" },
	[49355234] = { name="Brightly Colored Egg", preWrath=false, tip="Under the foliage" },
	[49385298] = { name="Brightly Colored Egg", preWrath=false },
	[49394904] = { name="Brightly Colored Egg", preWrath=false, tip="Under the crystal light" },
	[49425322] = { name="Brightly Colored Egg", preWrath=false },
	[49535345] = { name="Brightly Colored Egg", preWrath=false },
	[49605212] = { name="Brightly Colored Egg", preWrath=false, tip="Under the crystal light" },
	[49714889] = { name="Brightly Colored Egg", dragonFlight=true, tip="Under the Gryphon roost" },
	[49715238] = { name="Brightly Colored Egg", preWrath=false },
	[49864905] = { name="Brightly Colored Egg", dragonFlight=true, tip="Under the Gryphon roost" },
	[49874887] = { name="Brightly Colored Egg", dragonFlight=true, tip="Upon the Noblegarden crates" },
	[49935197] = { name="Brightly Colored Egg", preWrath=false, tip="Under the foliage" },
	[49975225] = { name="Brightly Colored Egg", preWrath=false, tip="Above, on a ledge" },
	[49985305] = { name="Brightly Colored Egg", preWrath=false, tip="Under the foliage" },
	[50025271] = { name="Brightly Colored Egg", preWrath=false, tip="Under the foliage" },
	[50035027] = { name="Brightly Colored Egg", preWrath=false, tip="Under the foliage" },
	[50044963] = { name="Brightly Colored Egg", preWrath=false },
	[50044963] = { name="Brightly Colored Egg", preWrath=false },
	[50045010] = { name="Brightly Colored Egg", preWrath=false, tip="Under the foliage" },
	[50015330] = { name="Brightly Colored Egg", preWrath=false },
	[50105291] = { name="Brightly Colored Egg", preWrath=false },
	[50195038] = { name="Brightly Colored Egg", preWrath=false },
	[50205068] = { name="Brightly Colored Egg", preWrath=false, tip="Under the foliage" },
	[50585209] = { name="Brightly Colored Egg", preWrath=false, tip="Under the foliage, slightly clipped too" },
	[50705122] = { name="Brightly Colored Egg", preWrath=false, tip="Under the foliage" },
	[50095076] = { name="Brightly Colored Egg", preWrath=false, tip="Under the crystal light" },
}

points[ 15 ] = { -- Badlands Retail
	[53504700] = { aID=2436, aIndex=1, continentShow=true, tip="AnywhereZR" }, -- Desert Rose
}
points[ 1418 ] = { -- Badlands Wrath
	[53504700] = { aID=2436, aIndex=2, preWrath=false, continentShow=true, tip="AnywhereZW" }, -- Desert Rose
}

points[ 66 ] = { -- Desolace Retail
	[60005200] = { aID=2436, aIndex=2, continentShow=true, tip="AnywhereZR" }, -- Desert Rose
}
points[ 1443 ] = { -- Desolace Wrath
	[60005200] = { aID=2436, aIndex=4, preWrath=false, continentShow=true, tip="AnywhereZW" }, -- Desert Rose
}

points[ 27 ] = { -- Dun Morogh Retail - Kharanos
	[53614977] = { aID=2419, aIndex=4, faction="Alliance", tip="AnywhereT" }, -- Spring Fling
	[53995070] = { quest=13480, faction="Alliance", qName="The Great Egg Hunt" },
--	[53085172] = { quest=73192, faction="Alliance", qName="An Egg-centric Discovery" },

	[52584929] = { name="Brightly Colored Egg" },
	[52744960] = { name="Brightly Colored Egg" },
	[52755101] = { name="Brightly Colored Egg" },
	[52755129] = { name="Brightly Colored Egg" },
	[52764941] = { name="Brightly Colored Egg" },
	[52865043] = { name="Brightly Colored Egg" },
	[52914989] = { name="Brightly Colored Egg" },
	[52934961] = { name="Brightly Colored Egg" },
	[52974994] = { name="Brightly Colored Egg" },
	[53045063] = { name="Brightly Colored Egg" },
	[53064871] = { name="Brightly Colored Egg" },
	[53075034] = { name="Brightly Colored Egg", tip="Under the inclined crate. Clever!" },
	[53094996] = { name="Brightly Colored Egg", tip="Between the two crates" },
	[53095031] = { name="Brightly Colored Egg", tip="Inside the broken cask" },
	[53215157] = { name="Brightly Colored Egg", dragonFlight=true, tip="Upon the Noblegarden crates" },
	[53344912] = { name="Brightly Colored Egg" },
	[53344930] = { name="Brightly Colored Egg" },
	[53354905] = { name="Brightly Colored Egg" },
	[53355264] = { name="Brightly Colored Egg", dragonFlight=true, tip="Alonsgide the Noblegarden crates" },
	[53364887] = { name="Brightly Colored Egg" },
	[53365073] = { name="Brightly Colored Egg", tip="Since you like eggs... why not try my \"Netherwing Eggs\"\n"
					.."AddOn? It is the only AddOn and indeed is essential to\nsucessfully farming Netherwing rep for the set of\n"
					.."awesome Netherwing Drake mounts!" },
	[53385030] = { name="Brightly Colored Egg" },
	[53385057] = { name="Brightly Colored Egg", dragonFlight=true },
	[53405202] = { name="Brightly Colored Egg" },
	[53415161] = { name="Brightly Colored Egg" },
	[53415186] = { name="Brightly Colored Egg" },
	[53415177] = { name="Brightly Colored Egg" },
	[53415186] = { name="Brightly Colored Egg" },
	[53645059] = { name="Brightly Colored Egg", dragonFlight=true, tip="Behind the direction post" },
	[53735310] = { name="Brightly Colored Egg", dragonFlight=true },
	[53775282] = { name="Brightly Colored Egg", continentShow=true },
	[53785284] = { name="Brightly Colored Egg", dragonFlight=true, tip="Under a Gryphon roost" },
	[53794913] = { name="Brightly Colored Egg" },
	[53805168] = { name="Brightly Colored Egg", tip="Half concealed by straw bales" },
	[53815052] = { name="Brightly Colored Egg" },
	[53815243] = { name="Brightly Colored Egg" },
	[53835246] = { name="Brightly Colored Egg" },
	[53844926] = { name="Brightly Colored Egg", dragonFlight=true },
	[53855182] = { name="Brightly Colored Egg", tip="Under the front wheels of the wagon" },
	[53865285] = { name="Brightly Colored Egg", dragonFlight=true, tip="Upon the Noblegarden crate" },
	[53874983] = { name="Brightly Colored Egg", dragonFlight=true, tip="Under the wreath/easle" },
	[53885055] = { name="Brightly Colored Egg" },
	[53895192] = { name="Brightly Colored Egg", tip="Under the rear wheels of the wagon" },
	[53895244] = { name="Brightly Colored Egg", dragonFlight=true, tip="Between the muskets and the tent" },
	[53895263] = { name="Brightly Colored Egg" },
	[53935200] = { name="Brightly Colored Egg", tip="Between three stacks of crates and a large barrel" },
	[53944884] = { name="Brightly Colored Egg" },
	[53965268] = { name="Brightly Colored Egg", dragonFlight=true },
	[53985045] = { name="Brightly Colored Egg" },
	[54005052] = { name="Brightly Colored Egg", tip="Top of the stairs" },
	[54015055] = { name="Brightly Colored Egg", tip="Bottom of the stairs" },
	[54015250] = { name="Brightly Colored Egg" },
	[54025013] = { name="Brightly Colored Egg", tip="On the ledge" },
	[54095202] = { name="Brightly Colored Egg" },
	[54145045] = { name="Brightly Colored Egg", tip="Behind the seat, in the corner. Well hidden!\n"
					.."Careful! Don't jump in or you might get stuck!\n\n((I have to in order to get the coordinates super-\n"
					.."accurately. Yeah... I took a hit for the team lol))" },
	[54155089] = { name="Brightly Colored Egg", tip="Behind the mailbox" },
	[54165074] = { name="Brightly Colored Egg", tip="On the ledge" },
	[54185001] = { name="Brightly Colored Egg" },
	[54195013] = { name="Brightly Colored Egg", tip="On the building ledge" },
	[54295010] = { name="Brightly Colored Egg" },
	[54315123] = { name="Brightly Colored Egg" },
	[54335158] = { name="Brightly Colored Egg" },
	[54465208] = { name="Brightly Colored Egg", tip="Alongside a crate with a clipboard" },
	[54475198] = { name="Brightly Colored Egg", tip="Inside the cauldron" },
	[54655195] = { name="Brightly Colored Egg", tip="Between a cauldron and a larger upright crate" },
	[54574969] = { name="Brightly Colored Egg" },
}

points[ 1426 ] = { -- Dun Morogh Classic - Kharanos
	[46005300] = { aID=2419, aIndex=2, faction="Alliance", tip="AnywhereT" }, -- Spring Fling
	[46885238] = { quest=13480, faction="Alliance", qName="The Great Egg Hunt" },

	-- Dun Morogh Vanilla/TBC
	[20907660] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[22507130] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[22507490] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[22507500] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[227080400] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[24807580] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[26203820] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[26207950] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[26707240] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[27907240] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[28105200] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[28806610] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[29106950] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[29205480] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[29607210] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[29703630] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[30107170] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[31005860] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[31505850] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[33404990] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[34106180] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[34705290] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[35605850] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[37105320] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[38003320] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[38005070] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[41205510] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[42905180] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[43202990] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[44705410] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[45504310] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[49104980] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[49803810] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[49805920] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[52605030] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[54805520] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[55604910] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[55704910] = { name="Brightly Colored Egg", preWrath=true, continentShow=true }, -- A
	[58905220] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[59906180] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[61605690] = { name="Brightly Colored Egg", preWrath=true, author=true },

	-- Kharanos WotLK
	[45495098] = { name="Brightly Colored Egg", preWrath=false },
	[45645129] = { name="Brightly Colored Egg", preWrath=false },
	[45655268] = { name="Brightly Colored Egg", preWrath=false },
	[45665109] = { name="Brightly Colored Egg", preWrath=false },
	[45765211] = { name="Brightly Colored Egg", preWrath=false },
	[45815157] = { name="Brightly Colored Egg", preWrath=false },
	[45825130] = { name="Brightly Colored Egg", preWrath=false },
	[45875162] = { name="Brightly Colored Egg", preWrath=false },
	[45945231] = { name="Brightly Colored Egg", preWrath=false },
	[45965040] = { name="Brightly Colored Egg", preWrath=false, continentShow=true },
	[45975203] = { name="Brightly Colored Egg", preWrath=false, tip="Under the crate" },
	[45995164] = { name="Brightly Colored Egg", preWrath=false },
	[45995199] = { name="Brightly Colored Egg", preWrath=false, tip="In the Barrel" },
	[46245098] = { name="Brightly Colored Egg", preWrath=false },
	[46255056] = { name="Brightly Colored Egg", preWrath=false },
	[46285214] = { name="Brightly Colored Egg", preWrath=false },
	[46285224] = { name="Brightly Colored Egg", preWrath=false },
	[46305344] = { name="Brightly Colored Egg", preWrath=false },
	[46305369] = { name="Brightly Colored Egg", preWrath=false },
	[46315328] = { name="Brightly Colored Egg", preWrath=false },
	[46555226] = { name="Brightly Colored Egg", preWrath=false, tip="Alongside the lamp post" },
	[46665449] = { name="Brightly Colored Egg", preWrath=false },
	[46835052] = { name="Brightly Colored Egg", preWrath=false },
	[46685082] = { name="Brightly Colored Egg", preWrath=false },
	[46695335] = { name="Brightly Colored Egg", preWrath=false },
	[46705220] = { name="Brightly Colored Egg", preWrath=false },
	[46705410] = { name="Brightly Colored Egg", preWrath=false },
	[46735095] = { name="Brightly Colored Egg", preWrath=false },
	[46735413] = { name="Brightly Colored Egg", preWrath=false },
	[46765350] = { name="Brightly Colored Egg", preWrath=false, tip="Under the wagon" },
	[46775429] = { name="Brightly Colored Egg", preWrath=false },
	[46775223] = { name="Brightly Colored Egg", preWrath=false },
	[46785359] = { name="Brightly Colored Egg", preWrath=false, tip="Under the wagon" },
	[46825366] = { name="Brightly Colored Egg", preWrath=false, tip="Between three stacks of crates and a large barrel" },
	[46875212] = { name="Brightly Colored Egg", preWrath=false },
	[46905220] = { name="Brightly Colored Egg", preWrath=false, tip="In a nook on the stairs" },
	[46905416] = { name="Brightly Colored Egg", preWrath=false },
	[46915223] = { name="Brightly Colored Egg", preWrath=false, tip="In the nook alongside the stairs" },
	[46985369] = { name="Brightly Colored Egg", preWrath=false },
	[47035213] = { name="Brightly Colored Egg", preWrath=false, tip="Behind the seat, in the corner. Well hidden!\n" },
	[47065169] = { name="Brightly Colored Egg", preWrath=false },
	[47085181] = { name="Brightly Colored Egg", preWrath=false },
	[47045258] = { name="Brightly Colored Egg", preWrath=false, tip="Uncollectable due to mailbox proximity :(\n\n"
					.."Since you like eggs... why not try my \"Netherwing Eggs\"\nAddOn? It is the only AddOn and indeed is essential to\n"
					.."sucessfully farming Netherwing rep for the set of\nawesome Netherwing Drake mounts!" },
	[47195178] = { name="Brightly Colored Egg", preWrath=false },
	[47205290] = { name="Brightly Colored Egg", preWrath=false },
	[47225325] = { name="Brightly Colored Egg", preWrath=false },
	[47345362] = { name="Brightly Colored Egg", preWrath=false, tip="Alongside the cauldron" },
	[47355375] = { name="Brightly Colored Egg", preWrath=false },
	[47365364] = { name="Brightly Colored Egg", preWrath=false, tip="Inside the cauldron" },
	[47465138] = { name="Brightly Colored Egg", preWrath=false },
}

points[ ns.durotar ] = { -- Durotar Shared - Razor Hill
	[51824207] = { quest=13479, faction="Horde", qName="The Great Egg Hunt" },
	[52584118] = { name="Sylnaria Fareflame", quest=79135, faction="Horde", dragonFlight=true, qName="Quacking Down" },
--	[53604360] = { quest=74955, faction="Horde", preCata=false, qName="An Egg-centric Discovery" },
	[53854210] = { aID=2497, aIndexC=1, aIndexR=4, faction="Horde", tip="AnywhereE" }, -- Spring Fling

	-- Durotar Vanilla/TBC
	[38505080] = { name="Brightly Colored Egg", preWrath=true },
	[38605670] = { name="Brightly Colored Egg", preWrath=true },
	[40701690] = { name="Brightly Colored Egg", preWrath=true },
	[41502850] = { name="Brightly Colored Egg", preWrath=true },
	[43606280] = { name="Brightly Colored Egg", preWrath=true },
	[45805620] = { name="Brightly Colored Egg", preWrath=true },
	[45902750] = { name="Brightly Colored Egg", preWrath=true },
	[47006590] = { name="Brightly Colored Egg", preWrath=true },
	[47104570] = { name="Brightly Colored Egg", preWrath=true, continentShow=true },
	[47606950] = { name="Brightly Colored Egg", preWrath=true },
	[49307420] = { name="Brightly Colored Egg", preWrath=true },
	[50103590] = { name="Brightly Colored Egg", preWrath=true },
	[50205140] = { name="Brightly Colored Egg", preWrath=true },
	[51201960] = { name="Brightly Colored Egg", preWrath=true },
	[51604368] = { name="Brightly Colored Egg", preWrath=true },
	[51701960] = { name="Brightly Colored Egg", preWrath=true },
	[53803280] = { name="Brightly Colored Egg", preWrath=true },
	[55105470] = { name="Brightly Colored Egg", preWrath=true },
	[55603450] = { name="Brightly Colored Egg", preWrath=true },
	[57101750] = { name="Brightly Colored Egg", preWrath=true },
	[60108040] = { name="Brightly Colored Egg", preWrath=true },

	-- Razorhill WotLK/Retail
	[50654327] = { name="Brightly Colored Egg", preCata=false, tip="In a crate which is under the wagon" },
	[50764270] = { name="Brightly Colored Egg", preCata=false,
					tip="UNDER the round cooking/eating table.\n\n((Different side of the table and additional\n"
						.."to the orginal Wrath location))" },
	[50804270] = { name="Brightly Colored Egg", preCata=false,
					tip="On the round cooking/eating table.\n\n((Hey in Wrath it's UNDER the table, with the\n"
						.."entire cooking area much closer to the building!))" },
	[50824305] = { name="Brightly Colored Egg", preCata=false, tip="On the top of a large sack of grain" },
	[51024121] = { name="Brightly Colored Egg", preCata=false },
	[51074199] = { name="Brightly Colored Egg", preWrath=false, continentShow=true },
	[51164235] = { name="Brightly Colored Egg", preCata=true,
					tip="Under the round cooking/eating table\n\n((Hey in Retail it's ON the table, with\n"
						.."the entire cooking area shifted away too!))" },
	[51534091] = { name="Brightly Colored Egg", preWrath=false },
	[51594244] = { name="Brightly Colored Egg", preWrath=false, tip="Under the rickshaw" },
	[51604353] = { name="Brightly Colored Egg", preWrath=false },
	[51604368] = { name="Brightly Colored Egg", preWrath=false },
	[51714219] = { name="Brightly Colored Egg", preWrath=false, tip="Behind the crate of urns" },
	[51754224] = { name="Brightly Colored Egg", preWrath=false, tip="Between two horde shipping crates" },
	[51784097] = { name="Brightly Colored Egg", preWrath=false, tip="Wedged between gunpowder kegs and the foundry base" },
	[51834315] = { name="Brightly Colored Egg", preCata=false, dragonFlight=true, tip="Inside the crate" },
	[51894217] = { name="Brightly Colored Egg", preWrath=false, tip="Between the mailbox and a post" },
	[51904024] = { name="Brightly Colored Egg", preWrath=false, tip="Under the lamp" },
	[51934180] = { name="Brightly Colored Egg", preWrath=false, tip="Under the lamp" },
	[51934035] = { name="Brightly Colored Egg", preWrath=false },
	[51954299] = { name="Brightly Colored Egg", preWrath=false,
					tip="Under the lamp\n\nSince you like eggs... why not try my \"Adorable Raptor\n"
					.."Hatchlings\" AddOn? It is the only AddOn and indeed\nis essential to trivially acquire a set of "
					.."delightfully\nadorable baby raptor hatchling pets!" },
	[51964168] = { name="Brightly Colored Egg", preWrath=false, tip="Stashed behind a crate and large flat container" },
	[51984163] = { name="Brightly Colored Egg", preWrath=false, tip="Stashed behind a crate and bag" },
	[52334354] = { name="Brightly Colored Egg", preWrath=false, tip="Under the lamp" },
	[52064182] = { name="Brightly Colored Egg", preWrath=false, tip="In the water tub" },
	[52164090] = { name="Brightly Colored Egg", preWrath=false, tip="Under the lamp" },
	[52564261] = { name="Brightly Colored Egg", preCata=false, tip="On top of the wayfinding post" },
	[52684122] = { name="Brightly Colored Egg", preWrath=false,
					tip="Between three cactii" }, -- Not sure about that one. Version specific?
	[52794106] = { name="Brightly Colored Egg", preWrath=false, tip="Between three cactii" },
	[52824097] = { name="Brightly Colored Egg", preWrath=false },
	[52864367] = { name="Brightly Colored Egg", preCata=false, dragonFlight=true, tip="Under the wreath/easle" },
	[52984187] = { name="Brightly Colored Egg", preCata=true, tip="Under the lamp" },
	[52984187] = { name="Brightly Colored Egg", preCata=false,
					tip="((In Wrath there was a lamp here, which\nexplains why this egg is out in the open!))" },
	[53014094] = { name="Brightly Colored Egg", preWrath=false, 
					tip="In the centre of and under the round serving table.\n\nThe best hidden egg in Razor Hill!" },
	[53064083] = { name="Brightly Colored Egg", preWrath=false, tip="Between two sacks and a cushion" },
	[53094198] = { name="Brightly Colored Egg", preWrath=false, tip="Under the rickshaw" },
	[53094233] = { name="Brightly Colored Egg", preWrath=false, tip="Under the lamp" },
	[53094347] = { name="Brightly Colored Egg", preCata=false,
					tip="Between a barrel and a post.\n\n((In Wrath there was no Flight Master. Instead there\n"
						.."were cactii, with a couple of chocolate eggs too!))" },
	[53104302] = { name="Brightly Colored Egg", preWrath=false, tip="Under the lamp" },
	[53124107] = { name="Brightly Colored Egg", preWrath=false, tip="Inside the crate" },
	[53124181] = { name="Brightly Colored Egg", preWrath=false, tip="Between a tuft of grass and the tree" },
	[53164349] = { name="Brightly Colored Egg", preCata=false, tip="On top of the stretched red skin" },
	[53184194] = { name="Brightly Colored Egg", preCata=false },
	[53184362] = { name="Brightly Colored Egg", preCata=true },
	[53244349] = { name="Brightly Colored Egg", preCata=false, tip="Between the woven bamboo netting and the post" },
	[53264154] = { name="Brightly Colored Egg", preCata=false },
	[53324371] = { name="Brightly Colored Egg", preCata=true },
	[53334357] = { name="Brightly Colored Egg", preCata=false, dragonFlight=true, tip="Between the crates" },
	[53344226] = { name="Brightly Colored Egg", preWrath=false },
	[53354358] = { name="Brightly Colored Egg", preCata=true },
	[53384289] = { name="Brightly Colored Egg", preWrath=false },
	[53504172] = { name="Brightly Colored Egg", preCata=false },
	[53814175] = { name="Brightly Colored Egg", preWrath=false },
	[53934321] = { name="Brightly Colored Egg", preWrath=false },
	[54334173] = { name="Brightly Colored Egg", preWrath=false },
	[54374106] = { name="Brightly Colored Egg", preWrath=false, tip="Inside the cauldron" },
	[54414102] = { name="Brightly Colored Egg", preWrath=false, tip="Inside the cauldron" },
	[54414131] = { name="Brightly Colored Egg", preWrath=false, tip="Inside the crate" },
	[54444306] = { name="Brightly Colored Egg", preCata=false },
	[54484194] = { name="Brightly Colored Egg", preWrath=false, tip="Jammed in the nook" },
	[54644146] = { name="Brightly Colored Egg", preCata=false, tip="Under the stone slab" },
	[54544284] = { name="Brightly Colored Egg", preWrath=false, tip="Wedged in the corner crevice" },
	[54624248] = { name="Brightly Colored Egg", preWrath=false, tip="Behind the grassy tufts" },
	[54704210] = { name="Brightly Colored Egg", preWrath=false },
	[54764171] = { name="Brightly Colored Egg", preCata=false },
	[54824246] = { name="Brightly Colored Egg", preCata=false },
	[54874192] = { name="Brightly Colored Egg", preWrath=false },
	[54994273] = { name="Brightly Colored Egg", preCata=false },
	[55194230] = { name="Brightly Colored Egg", preCata=false, dragonFlight=true, tip="Between the rocks" },
	[55244213] = { name="Brightly Colored Egg", preWrath=false },
}

points[ ns.elwynnForest ] = { -- Elwynn Forest Shared - Goldshire
	[42506500] = { aID=2419, aIndexC=3, aIndexR=3, faction="Alliance", tip="AnywhereT" }, -- Spring Fling
	[42056504] = { name="Zinnia Brooks", quest=78274, faction="Alliance", dragonFlight=true, qName="Quacking Down" },
	[42986540] = { quest=13480, faction="Alliance", qName="The Great Egg Hunt" },
--	[42306690] = { quest=73192, faction="Alliance", preCata=false, qName="An Egg-centric Discovery" },
	[26263636] = { aID=2421, faction="Alliance" }, -- Noble Garden

	-- Elwynn Forest Vanilla/TBC
	[23407560] = { name="Brightly Colored Egg", preWrath=true },
	[24509380] = { name="Brightly Colored Egg", preWrath=true },
	[26906830] = { name="Brightly Colored Egg", preWrath=true },
	[30205860] = { name="Brightly Colored Egg", preWrath=true },
	[31106480] = { name="Brightly Colored Egg", preWrath=true },
	[32708620] = { name="Brightly Colored Egg", preWrath=true },
	[32906140] = { name="Brightly Colored Egg", preWrath=true },
	[35405600] = { name="Brightly Colored Egg", preWrath=true },
	[38205960] = { name="Brightly Colored Egg", preWrath=true },
	[38408220] = { name="Brightly Colored Egg", preWrath=true },
	[40608430] = { name="Brightly Colored Egg", preWrath=true },
	[41806150] = { name="Brightly Colored Egg", preWrath=true },
	[45404670] = { name="Brightly Colored Egg", preWrath=true },
	[45907310] = { name="Brightly Colored Egg", preWrath=true },
	[47403220] = { name="Brightly Colored Egg", preWrath=true },
	[47705920] = { name="Brightly Colored Egg", preWrath=true },
	[48604140] = { name="Brightly Colored Egg", preWrath=true },
	[49004040] = { name="Brightly Colored Egg", preWrath=true },
	[49107450] = { name="Brightly Colored Egg", preWrath=true },
	[49206590] = { name="Brightly Colored Egg", preWrath=true },
	[49303170] = { name="Brightly Colored Egg", preWrath=true },
	[49505080] = { name="Brightly Colored Egg", preWrath=true },
	[49905120] = { name="Brightly Colored Egg", preWrath=true },
	[51007990] = { name="Brightly Colored Egg", preWrath=true },
	[54505660] = { name="Brightly Colored Egg", preWrath=true },
	[55007690] = { name="Brightly Colored Egg", preWrath=true },
	[56205010] = { name="Brightly Colored Egg", preWrath=true },
	[56604380] = { name="Brightly Colored Egg", preWrath=true },
	[57706920] = { name="Brightly Colored Egg", preWrath=true },
	[60905270] = { name="Brightly Colored Egg", preWrath=true, continentShow=true },
	[66604090] = { name="Brightly Colored Egg", preWrath=true },
	[69303870] = { name="Brightly Colored Egg", preWrath=true },
	[71407650] = { name="Brightly Colored Egg", preWrath=true },
	[74806060] = { name="Brightly Colored Egg", preWrath=true },
	[76308650] = { name="Brightly Colored Egg", preWrath=true },
	[78905650] = { name="Brightly Colored Egg", preWrath=true },
	[79307760] = { name="Brightly Colored Egg", preWrath=true },
	[88206730] = { name="Brightly Colored Egg", preWrath=true },
	[89507970] = { name="Brightly Colored Egg", preWrath=true },

	-- Goldshire WotLK/Retail
	[39836560] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the reeds" },
	[39976465] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the reeds" },
	[39996485] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the reeds" },
	[40076585] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[40586577] = { name="Brightly Colored Egg", preWrath=false, tip="At the base of the archery target" },
	[40746514] = { name="Brightly Colored Egg", preWrath=false, tip="Between the bellows and the furnace" },
	[40816629] = { name="Brightly Colored Egg", preWrath=false, tip="On top of the lamp post" },
	[40936426] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[40946387] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[40976472] = { name="Brightly Colored Egg", preWrath=false, tip="Between the bellows and the furnace" },
	[41086409] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[41186569] = { name="Brightly Colored Egg", preWrath=false, tip="Thanks for using my AddOn. Hope I helped! :)\n\n"
					.."I'm at Twitter and Ko-fi as @Taraezor.\nThere's also my project page at curseforge\n"
					.."where you might find more useful AddOns!" },	
	[41296369] = { name="Brightly Colored Egg", preWrath=false },
	[41556737] = { name="Brightly Colored Egg", preWrath=false },
	[41606427] = { name="Brightly Colored Egg", preWrath=false, tip="On top of the lamp post" },
	[41776528] = { name="Brightly Colored Egg", preWrath=false },
	[41836729] = { name="Brightly Colored Egg", preWrath=false, tip="Under the wagon" },
	[41876637] = { name="Brightly Colored Egg", preWrath=false, tip="In the small water trough" },
	[41896549] = { name="Brightly Colored Egg", preWrath=false },
	[41896586] = { name="Brightly Colored Egg", preWrath=false },
	[42016544] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[42016626] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[42416417] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[42416439] = { name="Brightly Colored Egg", preWrath=false, tip="On the ground next to the lamp post" },
	[42486745] = { name="Brightly Colored Egg", preWrath=false, tip="On top of the lamp post" },
	[42626419] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[42746645] = { name="Brightly Colored Egg", preWrath=false, tip="On top of the lamp post" },
	[42796389] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[42936674] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[42946552] = { name="Brightly Colored Egg", preWrath=false, tip="Behind the mailbox. Very difficult to obtain" },
	[42966616] = { name="Brightly Colored Egg", preWrath=false, tip="In the horses' drinking trough" },
	[42996617] = { name="Brightly Colored Egg", preWrath=false, tip="Behind the horses' drinking trough" },
	[43026589] = { name="Brightly Colored Egg", preWrath=false, tip="In the crate" },
	[43046637] = { name="Brightly Colored Egg", preWrath=false, tip="In the nook" },
	[43056628] = { name="Brightly Colored Egg", preWrath=false, tip="On the ledge, behind the jugs" },
	[43096472] = { name="Brightly Colored Egg", preWrath=false, tip="Alongside the lamp post" },
	[43096474] = { name="Brightly Colored Egg", preWrath=false, tip="On top of the lamp post" },
	[43096587] = { name="Brightly Colored Egg", preWrath=false },
	[43116547] = { name="Brightly Colored Egg", preWrath=false },
	[43116650] = { name="Brightly Colored Egg", preWrath=false },
	[43206534] = { name="Brightly Colored Egg", preWrath=false },
	[43306657] = { name="Brightly Colored Egg", preWrath=false },
	[43456539] = { name="Brightly Colored Egg", preWrath=false },
	[43496653] = { name="Brightly Colored Egg", preWrath=false, tip="High above on a ledge over the window" },
	[43496661] = { name="Brightly Colored Egg", preWrath=false },
	[43676664] = { name="Brightly Colored Egg", preWrath=false },
	[43706738] = { name="Brightly Colored Egg", preWrath=false },
	[43816551] = { name="Brightly Colored Egg", preWrath=false, tip="High above on a ledge over the window" },
	[43866665] = { name="Brightly Colored Egg", preWrath=false },
	[43946653] = { name="Brightly Colored Egg", preWrath=false },
	[43976619] = { name="Brightly Colored Egg", preWrath=false },
	[44376627] = { name="Brightly Colored Egg", preWrath=false },
	[44036640] = { name="Brightly Colored Egg", preWrath=false },
	[44076635] = { name="Brightly Colored Egg", preWrath=false },
	[44436554] = { name="Brightly Colored Egg", preWrath=false, tip="In a tuft of grass" },
	[44516615] = { name="Brightly Colored Egg", preWrath=false },
	[44556568] = { name="Brightly Colored Egg", preWrath=false, continentShow=true },
}

points[ ns.eversongWoods ] = { -- Eversong Woods Shared - Falconwing Square
	[47604600] = { aID=2497, aIndexC=2, aIndexR=3, faction="Horde", tip="AnywhereS" }, -- Spring Fling
	[47784713] = { quest=13479, faction="Horde", qName="The Great Egg Hunt" },
	[58003900] = { aID=2420, faction="Horde", tip="hide" }, -- Noble Garden
--	[46704710] = { quest=74955, faction="Horde", preCata=false, qName="An Egg-centric Discovery" },
	
	[46204688] = { name="Brightly Colored Egg", preCata=false, tip="In the very centre of the egg display" },
	[46264606] = { name="Brightly Colored Egg", preWrath=false, tip="Tucked in between a fence, a tree and the shrubs" },
	[46274721] = { name="Brightly Colored Egg", preWrath=false, tip="Tucked in between a fence, a tree and the shrubs" },
	[46304692] = { name="Brightly Colored Egg", preCata=true, tip="Tucked in between a fence, a tree and the shrubs" },
	[46344633] = { name="Brightly Colored Egg", preWrath=false, tip="Tucked in between a fence, a tree and the shrubs" },
	[46344752] = { name="Brightly Colored Egg", preWrath=false, continentShow=true },
	[46354661] = { name="Brightly Colored Egg", preWrath=false, tip="Tucked in between a fence, a tree and the shrubs" },
	[46354802] = { name="Brightly Colored Egg", preWrath=false,
					tip="Welcome to Falconwing Square.\n\nThanks for using my AddOn. Hope I helped! :)\n\n"
						.."I'm at Twitter and Ko-fi as @Taraezor.\nThere's also my project page at curseforge\n"
						.."where you might find more useful AddOns!" },
	[46384646] = { name="Brightly Colored Egg", preWrath=false, tip="Between the fence and a shrub" },
	[46514557] = { name="Brightly Colored Egg", preWrath=false, tip="Tucked in between a fence, a tree and the shrubs" },
	[46694563] = { name="Brightly Colored Egg", preWrath=false, tip="Partly concealed by a shrub" },
	[46734801] = { name="Brightly Colored Egg", preWrath=false, tip="Welcome to Flaconwing Square" },
	[46794570] = { name="Brightly Colored Egg", preWrath=false, tip="Tucked in between a fence, a tree and the shrubs" },
	[46804654] = { name="Brightly Colored Egg", preWrath=false, tip="Under the bench seat" },
	[46854763] = { name="Brightly Colored Egg", preWrath=false, tip="Adjacent to three barrels and a hexagonal wooden drum " },
	[46884563] = { name="Brightly Colored Egg", preWrath=false, tip="Between a tree trunk and the fence" },
	[46964641] = { name="Brightly Colored Egg", preWrath=false, tip="In the fountain, by the edge" },
	[46974678] = { name="Brightly Colored Egg", preWrath=false, tip="Under the bench seat" },
	[47004769] = { name="Brightly Colored Egg", preWrath=false, tip="Between crates and a keg" },
	[47024767] = { name="Brightly Colored Egg", preWrath=false, tip="Inside the stacked crates" },
	[47054626] = { name="Brightly Colored Egg", preWrath=false, tip="In the fountain, by the edge" },
	[47054637] = { name="Brightly Colored Egg", preWrath=false, tip="In the foundtain water, at the centre" },
	[47024645] = { name="Brightly Colored Egg", preWrath=false, tip="In the foundtain water, at the centre" },
	[47064657] = { name="Brightly Colored Egg", preWrath=false, tip="In the fountain, by the edge" },
	[47084644] = { name="Brightly Colored Egg", preWrath=false, tip="In the foundtain water, at the centre" },
	[47084763] = { name="Brightly Colored Egg", preWrath=false, tip="Under the wagon, concealled by crates" },
	[47104545] = { name="Brightly Colored Egg", preWrath=false, tip="Jammed between the fence corner and a tree" },
	[47104607] = { name="Brightly Colored Egg", preWrath=false, tip="Under the bench seat" },
	[47154771] = { name="Brightly Colored Egg", preWrath=false, tip="Alongside a front wagon wheel" },
	[47164641] = { name="Brightly Colored Egg", preWrath=false, tip="In the fountain, by the edge" },
	[47224791] = { name="Brightly Colored Egg", preWrath=false },
	[47244778] = { name="Brightly Colored Egg", preWrath=false },
	[47274534] = { name="Brightly Colored Egg", preWrath=false, tip="Between a tree trunk and the fence" },
	[47274753] = { name="Brightly Colored Egg", preWrath=false },
	[47284630] = { name="Brightly Colored Egg", preWrath=false, tip="Under the bench seat" },
	[47334754] = { name="Brightly Colored Egg", preWrath=false },
	[47464745] = { name="Brightly Colored Egg", preWrath=false },
	[47484526] = { name="Brightly Colored Egg", preWrath=false, tip="Between the fence and a tree" },
	[47544527] = { name="Brightly Colored Egg", preWrath=false, tip="Between a rear wagon wheel and the fence" },
	[47544539] = { name="Brightly Colored Egg", preWrath=false, tip="Under the wagon, adjacent to a rear wheel" },
	[47554741] = { name="Brightly Colored Egg", preWrath=false },
	[47564535] = { name="Brightly Colored Egg", preWrath=false, tip="In the wagon" },
	[47604527] = { name="Brightly Colored Egg", preWrath=false, tip="Adjacent to a front wheel of the wagon" },
	[47604539] = { name="Brightly Colored Egg", preWrath=false, tip="Under the wagon, adjacent to a front wheel" },
	[47634750] = { name="Brightly Colored Egg", preWrath=false, tip="Let's stash it behind the tree man, nobody'll look here!" },
	[47694521] = { name="Brightly Colored Egg", preWrath=false, tip="Between a tree trunk and the fence / lamp post" },
	[47774553] = { name="Brightly Colored Egg", preWrath=false },
	[47834687] = { name="Brightly Colored Egg", preWrath=false },
	[47874690] = { name="Brightly Colored Egg", preWrath=false },
	[47904709] = { name="Brightly Colored Egg", preWrath=false },
	[47914672] = { name="Brightly Colored Egg", preWrath=false },
	[47924524] = { name="Brightly Colored Egg", preWrath=false },
	[47944546] = { name="Brightly Colored Egg", preWrath=false, tip="Behind the tree" },
	[47964649] = { name="Brightly Colored Egg", preWrath=false },
	[47984556] = { name="Brightly Colored Egg", preWrath=false },
	[47994584] = { name="Brightly Colored Egg", preWrath=false },
	[48004657] = { name="Brightly Colored Egg", preWrath=false },
	[48054567] = { name="Brightly Colored Egg", preWrath=false, tip="Behind the tree" },
	[48134564] = { name="Brightly Colored Egg", preWrath=false },
	[48134586] = { name="Brightly Colored Egg", preWrath=false, tip="Nah braaaah, if we stash it in the open here nobody'll think to look!\n\n"
															.."Brilliant man, why didn't I think of that!" },
	[48134649] = { name="Brightly Colored Egg", preWrath=false },
}

points[ 7 ] = { -- Mulgore Retail - Bloodhoof Village
	[47905700] = { aID=2497, aIndex=1, faction="Horde", tip="AnywhereC" }, -- Spring Fling
	[46935953] = { quest=13479, faction="Horde", qName="The Great Egg Hunt" },
--	[46405830] = { quest=74955, faction="Horde", qName="An Egg-centric Discovery" },

	[45055775] = { name="Brightly Colored Egg", continentShow=true },
	[45165818] = { name="Brightly Colored Egg" },
	[45205949] = { name="Brightly Colored Egg" },
	[45345921] = { name="Brightly Colored Egg" },
	[45525793] = { name="Brightly Colored Egg" },
	[45685705] = { name="Brightly Colored Egg" },
	[45745833] = { name="Brightly Colored Egg" },
	[45886003] = { name="Brightly Colored Egg",
					tip="You'll probably miss this one if your\nOptions->Graphics->Ground Clutter\nsetting is high" },
	[45995634] = { name="Brightly Colored Egg" },
	[45995688] = { name="Brightly Colored Egg" },
	[46056006] = { name="Brightly Colored Egg" },
	[46105953] = { name="Brightly Colored Egg", tip="Between three wicker/skin baskets" },
	[46196064] = { name="Brightly Colored Egg" },
	[46296162] = { name="Brightly Colored Egg", tip="Under the canoe in the water. Wicked stealth!" },
	[46315702] = { name="Brightly Colored Egg" },
	[46386149] = { name="Brightly Colored Egg", tip="Under the canoe" },
	[46446092] = { name="Brightly Colored Egg", tip="Between the beams" },
	[46505739] = { name="Brightly Colored Egg", tip="Under the bath, tent side. Well hidden!" },
	[46525736] = { name="Brightly Colored Egg", tip="In the centre of the bath" },
	[46616109] = { name="Brightly Colored Egg", tip="Under the canoe. So tricky!" },
	[46655819] = { name="Brightly Colored Egg", preCata=false, tip="Under the wreath/easle" },
	[46656035] = { name="Brightly Colored Egg" },
	[46685749] = { name="Brightly Colored Egg", tip="Alongside the tent post" },
	[46686113] = { name="Brightly Colored Egg", tip="Under the canoe. So tricky!" },
	[46775993] = { name="Brightly Colored Egg" },
	[46805985] = { name="Brightly Colored Egg", tip="Another egg nook" },
	[46856122] = { name="Brightly Colored Egg", tip="Another egg nook" },
	[46875983] = { name="Brightly Colored Egg", tip="Also well concealed at the back here!" },
	[47016061] = { name="Brightly Colored Egg" },
	[47116034] = { name="Brightly Colored Egg", tip="Under the bath, building side. Well hidden!" },
	[47146002] = { name="Brightly Colored Egg", tip="Well concealed at the back here!" },
	[47146018] = { name="Brightly Colored Egg", tip="In the corner covered by grass" },
	[47146036] = { name="Brightly Colored Egg", tip="In the centre of the bath" },
	[47166011] = { name="Brightly Colored Egg", tip="A good nook to hide an egg!" },
	[47215646] = { name="Brightly Colored Egg", tip="Between three wicker/skin baskets" },
	[47265638] = { name="Brightly Colored Egg", tip="Beneath the huge drum" },
	[47505936] = { name="Brightly Colored Egg", tip="Under/behind the sled" },
	[47586186] = { name="Brightly Colored Egg" },
	[47605944] = { name="Brightly Colored Egg", tip="Between a wicker/skin basket and the totem" },
	[47615941] = { name="Brightly Colored Egg", tip="Inside the urn. Well hidden!" },
	[47635433] = { name="Brightly Colored Egg" },
	[47715807] = { name="Brightly Colored Egg", tip="Between three wicker/skin baskets\n\n"
					.."Since you like eggs... why not try my \"Adorable Raptor\nHatchlings\" AddOn? It is the only AddOn and indeed\n"
					.."is essential to trivially acquire a set of delightfully\nadorable baby raptor hatchling pets!" },
	[47726182] = { name="Brightly Colored Egg",
					tip="Very well concealed by the grass!\n\nOptions->Graphics->Ground Clutter\nis best set to zero!" },
	[47746145] = { name="Brightly Colored Egg", tip="Atop the flameless smoker" },
	[47785540] = { name="Brightly Colored Egg", tip="At the base of the loom" },
	[47835562] = { name="Brightly Colored Egg", tip="Beneath the plainstrider carcass" },
	[47845550] = { name="Brightly Colored Egg", tip="Beneath the plainstrider carcass" },
	[47956077] = { name="Brightly Colored Egg", tip="Under/behind the sled" },
	[47975525] = { name="Brightly Colored Egg", tip="At the base of the brazier-style lamp" },
	[48035998] = { name="Brightly Colored Egg",
					tip="In the totem brazier. May the spirits\nguide you... the chocolate didn't melt!" },
	[48165864] = { name="Brightly Colored Egg", tip="At the base of the support beam, hidden in the grass!" },
	[48285941] = { name="Brightly Colored Egg" },
	[48615961] = { name="Brightly Colored Egg", tip="Between the straw target dummy and the pavilion platform" },
	[48785818] = { name="Brightly Colored Egg", tip="Between the stair planks. Genius!" },
	[48815804] = { name="Brightly Colored Egg", tip="Between the stair planks. Brilliant!" },
	[48845792] = { name="Brightly Colored Egg", tip="Between the stair planks. Clever!" },
	[48885782] = { name="Brightly Colored Egg", tip="Between the stair planks. Devious!" },
	[48985940] = { name="Brightly Colored Egg", tip="Between the stair planks. Genius!" },
	[49025955] = { name="Brightly Colored Egg", tip="Between the stair planks. Brilliant!" },
	[49085963] = { name="Brightly Colored Egg", tip="Between the stair planks. Clever!" },
}

points[ 1412 ] = { -- Mulgore / Bloodhoof Village Classic 
	[48305720] = { aID=2497, aIndex=4, faction="Horde", tip="AnywhereC" }, -- Spring Fling
	[46746011] = { quest=13479, faction="Horde", qName="The Great Egg Hunt" },

	-- Mulgore Vanilla/TBC
	[30705940] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[30802270] = { name="Brightly Colored Egg", preWrath=true }, -- O & A
	[32101810] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[33902400] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[34506220] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[35006140] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[35105900] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[35204400] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[35205020] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[35207410] = { name="Brightly Colored Egg", preWrath=true }, -- O & A
	[35406270] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[35506770] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[36101240] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[37401310] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[37503650] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[38604260] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[39200910] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[39503420] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[39608450] = { name="Brightly Colored Egg", preWrath=true }, -- O & A
	[39904560] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[41005320] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[41801730] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[42005610] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[42601410] = { name="Brightly Colored Egg", preWrath=true }, -- O & A
	[43100890] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[44604860] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[46103860] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[47403010] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[47507790] = { name="Brightly Colored Egg", preWrath=true, continentShow=true }, -- A
	[47706870] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[48004710] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[49404080] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[50409170] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[51906330] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[53100940] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[63701950] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[54305600] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[54407380] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[54507380] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[54702290] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[54708970] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[55601550] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[56006680] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[56501930] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[56902870] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[57007280] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[57301780] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[57804430] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[58604750] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[59002950] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[59207200] = { name="Brightly Colored Egg", preWrath=true }, -- A
	[59707530] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[60404830] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[62807770] = { name="Brightly Colored Egg", preWrath=true, author=true },
	[68306370] = { name="Brightly Colored Egg", preWrath=true, author=true },

	-- Bloodhoof Village WotLK
	[44755823] = { name="Brightly Colored Egg", preWrath=false },
	[44865868] = { name="Brightly Colored Egg", preWrath=false },
	[44916007] = { name="Brightly Colored Egg", preWrath=false },
	[45065977] = { name="Brightly Colored Egg", preWrath=false },
	[45255841] = { name="Brightly Colored Egg", preWrath=false },
	[45415748] = { name="Brightly Colored Egg", preWrath=false },
	[45485883] = { name="Brightly Colored Egg", preWrath=false },
	[45636064] = { name="Brightly Colored Egg", preWrath=false },
	[45755672] = { name="Brightly Colored Egg", preWrath=false },
	[45866012] = { name="Brightly Colored Egg", preWrath=false, tip="Between three wicker/skin baskets" },
	[45925920] = { name="Brightly Colored Egg", preWrath=false },
	[45966128] = { name="Brightly Colored Egg", preWrath=false },
	[46066233] = { name="Brightly Colored Egg", preWrath=false, tip="In a wicker crate in a canoe" },
	[46085745] = { name="Brightly Colored Egg", preWrath=false },
	[46166219] = { name="Brightly Colored Egg", preWrath=false, tip="In a canoe" },
	[46226159] = { name="Brightly Colored Egg", preWrath=false },
	[46295783] = { name="Brightly Colored Egg", preWrath=false, tip="Under the bath, tent side. Well hidden!" },
	[46315781] = { name="Brightly Colored Egg", preWrath=false, tip="In the centre of the bath" },
	[46406177] = { name="Brightly Colored Egg", preWrath=false,
					tip="Under the canoe. So tricky!\n\n((Worse awaits in Brill Classic OR Retail!!!))" },
	[46446098] = { name="Brightly Colored Egg", preWrath=false },
	[46476181] = { name="Brightly Colored Egg", preWrath=false, tip="Under the canoe. So devious!" },
	[46485795] = { name="Brightly Colored Egg", preWrath=false },
	[46586053] = { name="Brightly Colored Egg", preWrath=false },
	[46606045] = { name="Brightly Colored Egg", preWrath=false },
	[46676042] = { name="Brightly Colored Egg", preWrath=false },
	[46836125] = { name="Brightly Colored Egg", preWrath=false },
	[46946097] = { name="Brightly Colored Egg", preWrath=false, tip="Under the bath, building side. Well hidden!" },
	[46966063] = { name="Brightly Colored Egg", preWrath=false },
	[46995715] = { name="Brightly Colored Egg", preWrath=false, tip="Inside the flat woven bowl" },
	[46996072] = { name="Brightly Colored Egg", preWrath=false },
	[47045684] = { name="Brightly Colored Egg", preWrath=false, tip="Between three wicker/skin baskets" },
	[47105675] = { name="Brightly Colored Egg", preWrath=false, tip="Beneath the huge drum" },
	[47345992] = { name="Brightly Colored Egg", preWrath=false, tip="Under/behind the sled" },
	[47436258] = { name="Brightly Colored Egg", preWrath=false },
	[47466002] = { name="Brightly Colored Egg", preWrath=false, tip="Between a wicker/skin basket and the totem" },
	[47475998] = { name="Brightly Colored Egg", preWrath=false, tip="Inside the urn. Well hidden!" },
	[47495459] = { name="Brightly Colored Egg", preWrath=false },
	[47585857] = { name="Brightly Colored Egg", preWrath=false,
					tip="Between three wicker/skin baskets\n\n"
					.."Since you like eggs... why not try my \"Adorable Raptor\nHatchlings\" AddOn? It is the only AddOn and indeed\n"
					.."is essential to trivially acquire a set of delightfully\nadorable baby raptor hatchling pets!" },
	[47616215] = { name="Brightly Colored Egg", preWrath=false, tip="Atop the flameless smoker" },
	[47645574] = { name="Brightly Colored Egg", preWrath=false, tip="At the base of the loom" },
	[47705596] = { name="Brightly Colored Egg", preWrath=false, tip="Beneath the plainstrider carcass" },
	[47836143] = { name="Brightly Colored Egg", preWrath=false, tip="Under/behind the sled" },
	[47855558] = { name="Brightly Colored Egg", preWrath=false },
	[48175998] = { name="Brightly Colored Egg", preWrath=false, continentShow=true },
	[48536020] = { name="Brightly Colored Egg", preWrath=false,
					tip="Between the straw target dummy and the pavilion platform" },
	[48775840] = { name="Brightly Colored Egg", preWrath=false, tip="Between the stair planks. Devious!" },
	[48815830] = { name="Brightly Colored Egg", preWrath=false, tip="Between the stair planks. Well hidden!" },
	[48915997] = { name="Brightly Colored Egg", preWrath=false, tip="Between the steps and the pavilion platform" },
	[48966012] = { name="Brightly Colored Egg", preWrath=false, tip="Between the stair planks. Clever!" },
	[49026022] = { name="Brightly Colored Egg", preWrath=false, tip="Between the stair planks. Tricky!" },
}

points[ 81 ] = { -- Silithus Retail
	[73003100] = { aID=2436, aIndex=3, continentShow=true, tip="AnywhereZR" }, -- Desert Rose
}
points[ 1451 ] = { -- Silithus Wrath
	[55003800] = { aID=2416, name="Cenarion Hold", preWrath=false, continentShow=true, tip="hb3" }, -- Hard Boiled
	[73003300] = { aID=2436, aIndex=1, preWrath=false, continentShow=true, tip="AnywhereZW" }, -- Desert Rose
}

points[ ns.silvermoonCity ] = { -- Silvermoon City
	[66002780] = { aID=2420, faction="Horde", tip="hide" }, -- Noble Garden
}

points[ ns.stormwindCity ] = { -- Stormwind City
	[50945672] = { aID=2421, faction="Alliance", tip="hide" }, -- Noble Garden
}

points[ 71 ] = { -- Tanaris Retail
	[48002680] = { aID=2436, aIndex=4, continentShow=true, tip="AnywhereZR" }, -- Desert Rose
}
points[ 1446 ] = { -- Tanaris Classic
	[48002680] = { aID=2436, aIndex=3, preWrath=false, continentShow=true, tip="AnywhereZW" }, -- Desert Rose
}

points[ 57 ] = { -- Teldrassil Retail - Dolanaar
	[56805210] = { aID=2419, aIndex=2, faction="Alliance", tip="AnywhereT" }, -- Spring Fling
	[55595136] = { quest=13480, faction="Alliance", qName="The Great Egg Hunt" },
--	[56205380] = { quest=73192, faction="Alliance", qName="An Egg-centric Discovery" },

	[55145061] = { name="Brightly Colored Egg" },
	[55235447] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[55265437] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[55295428] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[55425033] = { name="Brightly Colored Egg", dragonFlight=true, tip="Under the Hippogryph roost" },
	[55445122] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[55445134] = { name="Brightly Colored Egg" },
	[55455140] = { name="Brightly Colored Egg" },
	[55465201] = { name="Brightly Colored Egg" },
	[55525231] = { name="Brightly Colored Egg" },
	[55535082] = { name="Brightly Colored Egg", tip="Under the perambulator" },
	[55585415] = { name="Brightly Colored Egg" },
	[55595269] = { name="Brightly Colored Egg",
					tip="Half concealed in the shrubbery and half\nwedged between the shrubbery and the tree" },
	[55615541] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[55645285] = { name="Brightly Colored Egg" },
	[55674986] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[55695398] = { name="Brightly Colored Egg", tip="In the pool" },
	[55755035] = { name="Brightly Colored Egg", tip="Under the ramp" },
	[55755285] = { name="Brightly Colored Egg", },
	[55805018] = { name="Brightly Colored Egg", tip="On top of the flask" },
	[55805107] = { name="Brightly Colored Egg", tip="Between the mailbox and the ramp" },
	[55815021] = { name="Brightly Colored Egg", tip="Between the ramp and the flasks" },
	[56025133] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56035557] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56055169] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56085180] = { name="Brightly Colored Egg", tip="Under the perambulator" },
	[56095550] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56115192] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56155195] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56155205] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56155267] = { name="Brightly Colored Egg" },
	[56175244] = { name="Brightly Colored Egg" },
	[56185161] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56185268] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56195010] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56205216] = { name="Brightly Colored Egg", tip="Wedged between the flasks and the ramp" },
	[56205526] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56215263] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56225215] = { name="Brightly Colored Egg", tip="On top of the flask" },
	[56225254] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56235006] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56245326] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56255156] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56295151] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56325236] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56345228] = { name="Brightly Colored Egg", tip="Under the seat" },
	[56355236] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56415168] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56555074] = { name="Brightly Colored Egg", tip="On top of the tall flask" },
	[56555078] = { name="Brightly Colored Egg", tip="Under the seat" },
	[56565074] = { name="Brightly Colored Egg", tip="On top of the flask" },
	[56595073] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56715355] = { name="Brightly Colored Egg", tip="Under the table of food" },
	[56835300] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56885281] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[56915321] = { name="Brightly Colored Egg", tip="In the pool" },
	[57065266] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[57215319] = { name="Brightly Colored Egg" },
	[57265282] = { name="Brightly Colored Egg" },
}

points[ 1438 ] = { -- Teldrassil Classic - Dolanaar
	[54705930] = { aID=2419, aIndex=4, faction="Alliance", tip="AnywhereT" }, -- Spring Fling
	[55885878] = { quest=13480, faction="Alliance", qName="The Great Egg Hunt" },

	[34102810] = { name="Brightly Colored Egg", preWrath=true },
	[35803890] = { name="Brightly Colored Egg", preWrath=true },
	[36202760] = { name="Brightly Colored Egg", preWrath=true },
	[39204740] = { name="Brightly Colored Egg", preWrath=true },
	[39406700] = { name="Brightly Colored Egg", preWrath=true },
	[39606240] = { name="Brightly Colored Egg", preWrath=true },
	[40402930] = { name="Brightly Colored Egg", preWrath=true },
	[42305200] = { name="Brightly Colored Egg", preWrath=true },
	[43307130] = { name="Brightly Colored Egg", preWrath=true },
	[46005220] = { name="Brightly Colored Egg", preWrath=true },
	[46403070] = { name="Brightly Colored Egg", preWrath=true },
	[46703430] = { name="Brightly Colored Egg", preWrath=true },
	[46704720] = { name="Brightly Colored Egg", preWrath=true },
	[50306510] = { name="Brightly Colored Egg", preWrath=true },
	[53104990] = { name="Brightly Colored Egg", preWrath=true },
	[53307040] = { name="Brightly Colored Egg", preWrath=true },
	[54905130] = { name="Brightly Colored Egg", preWrath=true },
	[55106440] = { name="Brightly Colored Egg", preWrath=true },
	[55205760] = { name="Brightly Colored Egg", preWrath=true },
	[55406960] = { name="Brightly Colored Egg", preWrath=true },
	[56406780] = { name="Brightly Colored Egg", preWrath=true },
	[59704030] = { name="Brightly Colored Egg", preWrath=true },
	[61903330] = { name="Brightly Colored Egg", preWrath=true },
	[64805210] = { name="Brightly Colored Egg", preWrath=true },
	[66105840] = { name="Brightly Colored Egg", preWrath=true },
	[68106020] = { name="Brightly Colored Egg", preWrath=true },

	[55466237] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[55506225] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[55535774] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[55536216] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[55565791] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[55705876] = { name="Brightly Colored Egg", preWrath=false },
	[55715862] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[55715883] = { name="Brightly Colored Egg", preWrath=false },
	[55735953] = { name="Brightly Colored Egg", preWrath=false },
	[55805815] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[55805987] = { name="Brightly Colored Egg", preWrath=false },
	[55876200] = { name="Brightly Colored Egg", preWrath=false },
	[55886032] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[55906346] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[55936050] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[55975705] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[55996181] = { name="Brightly Colored Egg", preWrath=false, tip="In the pool" },
	[56066050] = { name="Brightly Colored Egg", preWrath=false },
	[56075762] = { name="Brightly Colored Egg", preWrath=false, tip="Under the ramp" },
	[56115742] = { name="Brightly Colored Egg", preWrath=false, tip="On top of the flask" },
	[56125746] = { name="Brightly Colored Egg", preWrath=false, tip="Wedged between the flasks and the ramp" },
	[56135845] = { name="Brightly Colored Egg", preWrath=false, tip="Between the mailbox and the ramp" },
	[56305877] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[56375874] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[56396364] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[56415916] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[56455930] = { name="Brightly Colored Egg", preWrath=false, tip="Under the perambulator" },
	[56456357] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[56485944] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[56526029] = { name="Brightly Colored Egg", preWrath=false },
	[56535957] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[56556003] = { name="Brightly Colored Egg", preWrath=false },
	[56566031] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[56575732] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[56575907] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[56585970] = { name="Brightly Colored Egg", preWrath=false, tip="Alongside the flask" },
	[56586329] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[56605970] = { name="Brightly Colored Egg", preWrath=false, tip="On top of the flask" },
	[56616014] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[56695895] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[56725994] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[56755994] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[56835915] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[56995808] = { name="Brightly Colored Egg", preWrath=false, tip="On top of the flask" },
	[56995812] = { name="Brightly Colored Egg", preWrath=false, tip="Under the seat" },
	[57035806] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[57316068] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[57366045] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[57406091] = { name="Brightly Colored Egg", preWrath=false, tip="In the pool" },
	[57746089] = { name="Brightly Colored Egg", preWrath=false },
	[57806046] = { name="Brightly Colored Egg", preWrath=false },
}

points[ 64 ] = { -- Thousand Needles Retail
	[75007600] = { aID=2436, aIndex=5, continentShow=true, tip="AnywhereZR" }, -- Desert Rose
}
points[ 1441 ] = { -- Thousand Needles Wrath
	[75007600] = { aID=2436, aIndex=5, preWrath=false, continentShow=true, tip="AnywhereZW" }, -- Desert Rose
}

points[ 18 ] = { -- Tirisfal Glades Retail - Brill
	[60905090] = { aID=2497, aIndex=2, faction="Horde", tip="AnywhereT" }, -- Spring Fling
	[61605300] = { quest=13479, faction="Horde", qName="The Great Egg Hunt" },
--	[60005150] = { quest=74955, faction="Horde", qName="An Egg-centric Discovery" },

	[59435221] = { name="Brightly Colored Egg", tip="Inside the tent" },
	[59525231] = { name="Brightly Colored Egg", tip="Inside the tent" },
	[59615325] = { name="Brightly Colored Egg", tip="Inside the alcove, to the left as you enter.\n"
																.."To the right as you leave if I'm not mistaken" },
	[59655271] = { name="Brightly Colored Egg", tip="Look up! Between two arcing beams of the plague centrifuge" },
	[59805241] = { name="Brightly Colored Egg", tip="Inside the small broken barrel" },
	[59805270] = { name="Brightly Colored Egg", tip="Above, in a nook of the plague centrifuge machine" },
	[59875243] = { name="Brightly Colored Egg", tip="Trisected by the plague barrels" },
	[59905375] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[59925213] = { name="Brightly Colored Egg", tip="Nestled snugly in the... erm...\n"
					.."\"private parts\" of the unlucky ogre.\n\nWARNING: Extract carefully to avoid\n"
					.."unnecessary spillage of entrails!\n\nNow look down at the bench...\nthe ogre is watching you!" },
	[59955221] = { name="Brightly Colored Egg", tip="In the upheld palm of the rotting ogre corpse.\n\n"
					.."Gotta hand it to... erm... enough puns...\n\nBut that's a serious case of rigour mortis!" },
	[59955249] = { name="Brightly Colored Egg", tip="Behind the planter box" },
	[60045213] = { name="Brightly Colored Egg", tip="Perched on the street lamp" },
	[60085256] = { name="Brightly Colored Egg", tip="To the right side of the steps as you enter" },
	[60085355] = { name="Brightly Colored Egg", tip="In the alcove" },
	[60205348] = { name="Brightly Colored Egg", tip="Behind and at one end of the crates" },
	[60305257] = { name="Brightly Colored Egg", tip="In the nook" },
	[60325276] = { name="Brightly Colored Egg", tip="Jammed in tight here" },
	[60375324] = { name="Brightly Colored Egg", tip="Mounted on the apothecary apparatus" },
	[60405089] = { name="Brightly Colored Egg", tip="Above, on a window ledge" },
	[60425292] = { name="Brightly Colored Egg", tip="Look up! Between two arcing beams of the plague centrifuge" },
	[60425308] = { name="Brightly Colored Egg", tip="Behind the two barrels" },
	[60495155] = { name="Brightly Colored Egg", tip="Above, in the catapault basket!" },
	[60505251] = { name="Brightly Colored Egg", tip="Perched on the street lamp" },
	[60535059] = { name="Brightly Colored Egg" },
	[60545275] = { name="Brightly Colored Egg", tip="In the cart, at the high end, hidden by the plague casks" },
	[60595127] = { name="Brightly Colored Egg", tip="In the nook here" },
	[60595338] = { name="Brightly Colored Egg", tip="On top of the wheel of the plague tanker" },
	[60675206] = { name="Brightly Colored Egg", tip="Perched on the street lamp" },
	[60685352] = { name="Brightly Colored Egg", tip="On top of the wheel of the plague tanker" },
	[60755185] = { name="Brightly Colored Egg", tip="On the window ledge" },
	[60905223] = { name="Brightly Colored Egg",
					tip="Perched on the street lamp.\n\nYup, that's every street lamp. I checked. Sigh..." },
	[60995197] = { name="Brightly Colored Egg", tip="Between the wall and two casks" },
	[61115308] = { name="Brightly Colored Egg", continentShow=true,
					tip="Within the iron fence at the base of statue of the Banshee Queen.\n\n"
					.."\"I can feel Thrall's anger at Arthas, but it pales before my own.\n"
					.."Were he as furious as any one of the Forsaken, the Horde's armies\n"
					.."would unleash their rage upon Northrend and eradicate all Scourge\nfrom that cursed, frozen wasteland\"" },
	[61125012] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery. Glad they're not all like that!\n\n"
					.."((Fun fact: In Wrath almost all the eggs were concealed\nlike this, making Brill despised for egg farming!))" },
	[61125184] = { name="Brightly Colored Egg", tip="Behind and at the base of the crates" },
	[61145381] = { name="Brightly Colored Egg", tip="adjacent to the wayfinding sign" },
	[61155187] = { name="Brightly Colored Egg", tip="On top of the highest of the stacked crates!" },
	[61164982] = { name="Brightly Colored Egg", tip="Ew! Buried in the (night) soil" },
	[61165233] = { name="Brightly Colored Egg", tip="On the chef's stove" },
	[61175237] = { name="Brightly Colored Egg", tip="(Almost) the BEST hidden egg in all of Azeroth.\n\n"
					.."Stand here and look up! Perched on the cross beams!\n\n(The best is at Bloodhoof Village!)" },
	[61235298] = { name="Brightly Colored Egg",
					tip="Within the iron fence at the base of the statue\nof The Dark Lady, who surely watches over us" },
	[61235237] = { name="Brightly Colored Egg", tip="In the centre and under the meat chopping bench" },
	[61275168] = { name="Brightly Colored Egg", tip="In the pet carrying box" },
	[61295090] = { name="Brightly Colored Egg", tip="On the slimest of window sills" },
	[61415088] = { name="Brightly Colored Egg" },
	[61455121] = { name="Brightly Colored Egg", tip="Above, on a window ledge" },
	[61455320] = { name="Brightly Colored Egg", tip="Perched on the street lamp" },
	[61485293] = { name="Brightly Colored Egg", tip="Perched on the street lamp" },
	[61515106] = { name="Brightly Colored Egg", tip="Inside the small broken barrel" },
	[61525172] = { name="Brightly Colored Egg", tip="In a corner of the low end of the cart" },
	[61675280] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[61755351] = { name="Brightly Colored Egg", tip="Behind two small plague barrels" },
	[61765286] = { name="Brightly Colored Egg", tip="Wedged in tight!" },
	[61835310] = { name="Brightly Colored Egg", tip="Wedged in tight!" },
	[61895327] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[61965209] = { name="Brightly Colored Egg", tip="Sitting on the skeletal horses' food" },
	[62105169] = { name="Brightly Colored Egg", tip="Sitting on the skeletal horses' food" },
	[62205338] = { name="Brightly Colored Egg", tip="Concealed in the shrubbery" },
	[62255188] = { name="Brightly Colored Egg", tip="Under the meat wagon" },
	[62265279] = { name="Brightly Colored Egg", tip="Upon the split cask" },
}

points[ 1420 ] = { -- Tirisfal Glades Classic - Brill
	[60815152] = { aID=2497, aIndex=3, faction="Horde", tip="AnywhereT" }, -- Spring Fling
	[61635311] = { quest=13479, faction="Horde", qName="The Great Egg Hunt" },

	[25404740] = { name="Brightly Colored Egg", preWrath=true },
	[29306260] = { name="Brightly Colored Egg", preWrath=true },
	[30605160] = { name="Brightly Colored Egg", preWrath=true },
	[31405950] = { name="Brightly Colored Egg", preWrath=true },
	[31704680] = { name="Brightly Colored Egg", preWrath=true },
	[33404680] = { name="Brightly Colored Egg", preWrath=true },
	[35505920] = { name="Brightly Colored Egg", preWrath=true },
	[36006230] = { name="Brightly Colored Egg", preWrath=true },
	[37104280] = { name="Brightly Colored Egg", preWrath=true },
	[37506800] = { name="Brightly Colored Egg", preWrath=true },
	[37905620] = { name="Brightly Colored Egg", preWrath=true },
	[37906050] = { name="Brightly Colored Egg", preWrath=true, continentShow=true },
	[38104710] = { name="Brightly Colored Egg", preWrath=true },
	[38503370] = { name="Brightly Colored Egg", preWrath=true },	
	[39204350] = { name="Brightly Colored Egg", preWrath=true },
	[39505410] = { name="Brightly Colored Egg", preWrath=true },
	[39605400] = { name="Brightly Colored Egg", preWrath=true },
	[40004170] = { name="Brightly Colored Egg", preWrath=true },
	[41306060] = { name="Brightly Colored Egg", preWrath=true },
	[41604660] = { name="Brightly Colored Egg", preWrath=true },
	[41605760] = { name="Brightly Colored Egg", preWrath=true },
	[42805850] = { name="Brightly Colored Egg", preWrath=true },
	[43104420] = { name="Brightly Colored Egg", preWrath=true },
	[43406780] = { name="Brightly Colored Egg", preWrath=true },
	[43903830] = { name="Brightly Colored Egg", preWrath=true },
	[44506350] = { name="Brightly Colored Egg", preWrath=true },
	[45006680] = { name="Brightly Colored Egg", preWrath=true },
	[46504560] = { name="Brightly Colored Egg", preWrath=true },
	[46504880] = { name="Brightly Colored Egg", preWrath=true },
	[47702830] = { name="Brightly Colored Egg", preWrath=true },
	[48806880] = { name="Brightly Colored Egg", preWrath=true },
	[49003410] = { name="Brightly Colored Egg", preWrath=true },
	[49603320] = { name="Brightly Colored Egg", preWrath=true },
	[49703550] = { name="Brightly Colored Egg", preWrath=true },
	[49907310] = { name="Brightly Colored Egg", preWrath=true },
	[50405520] = { name="Brightly Colored Egg", preWrath=true },
	[51006730] = { name="Brightly Colored Egg", preWrath=true },
	[52204800] = { name="Brightly Colored Egg", preWrath=true },
	[52305830] = { name="Brightly Colored Egg", preWrath=true },
	[52307300] = { name="Brightly Colored Egg", preWrath=true },
	[52502710] = { name="Brightly Colored Egg", preWrath=true },
	[53104470] = { name="Brightly Colored Egg", preWrath=true },
	[53104730] = { name="Brightly Colored Egg", preWrath=true },
	[53206120] = { name="Brightly Colored Egg", preWrath=true },
	[53204470] = { name="Brightly Colored Egg", preWrath=true },
	[53204730] = { name="Brightly Colored Egg", preWrath=true },
	[53505170] = { name="Brightly Colored Egg", preWrath=true },
	[53804270] = { name="Brightly Colored Egg", preWrath=true },
	[53206120] = { name="Brightly Colored Egg", preWrath=true },
	[56006020] = { name="Brightly Colored Egg", preWrath=true },
	[57404440] = { name="Brightly Colored Egg", preWrath=true },
	[57404610] = { name="Brightly Colored Egg", preWrath=true },
	[58504070] = { name="Brightly Colored Egg", preWrath=true },
	[58607020] = { name="Brightly Colored Egg", preWrath=true },
	[59407140] = { name="Brightly Colored Egg", preWrath=true },
	[60403350] = { name="Brightly Colored Egg", preWrath=true },
	[60506360] = { name="Brightly Colored Egg", preWrath=true },
	[61104040] = { name="Brightly Colored Egg", preWrath=true },
	[61204430] = { name="Brightly Colored Egg", preWrath=true },
	[61603260] = { name="Brightly Colored Egg", preWrath=true },
	[61804300] = { name="Brightly Colored Egg", preWrath=true },
	[62404780] = { name="Brightly Colored Egg", preWrath=true },
	[62504060] = { name="Brightly Colored Egg", preWrath=true },
	[64703040] = { name="Brightly Colored Egg", preWrath=true },
	[66305640] = { name="Brightly Colored Egg", preWrath=true },
	[66403820] = { name="Brightly Colored Egg", preWrath=true },
	[66604490] = { name="Brightly Colored Egg", preWrath=true },
	[66805740] = { name="Brightly Colored Egg", preWrath=true },
	[68406640] = { name="Brightly Colored Egg", preWrath=true },
	[69203510] = { name="Brightly Colored Egg", preWrath=true },
	[71803100] = { name="Brightly Colored Egg", preWrath=true },
	[72405690] = { name="Brightly Colored Egg", preWrath=true },
	[72505440] = { name="Brightly Colored Egg", preWrath=true },
	[72505690] = { name="Brightly Colored Egg", preWrath=true },
	[73103260] = { name="Brightly Colored Egg", preWrath=true },
	[74906800] = { name="Brightly Colored Egg", preWrath=true },
	[72505690] = { name="Brightly Colored Egg", preWrath=true },
	[72505690] = { name="Brightly Colored Egg", preWrath=true },
	[75205440] = { name="Brightly Colored Egg", preWrath=true },
	[75503300] = { name="Brightly Colored Egg", preWrath=true },
	[78006730] = { name="Brightly Colored Egg", preWrath=true },
	[79304000] = { name="Brightly Colored Egg", preWrath=true },
	[79304580] = { name="Brightly Colored Egg", preWrath=true },
	[79606030] = { name="Brightly Colored Egg", preWrath=true },
	[79702530] = { name="Brightly Colored Egg", preWrath=true },
	[80006430] = { name="Brightly Colored Egg", preWrath=true },
	[81604820] = { name="Brightly Colored Egg", preWrath=true },
	[82604750] = { name="Brightly Colored Egg", preWrath=true },
	[82905680] = { name="Brightly Colored Egg", preWrath=true },
	[84006660] = { name="Brightly Colored Egg", preWrath=true },
	[86404980] = { name="Brightly Colored Egg", preWrath=true },
	[87204330] = { name="Brightly Colored Egg", preWrath=true },
	[88005520] = { name="Brightly Colored Egg", preWrath=true },

	[59295232] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[59355219] = { name="Brightly Colored Egg", preWrath=false, tip="Above, in the planter box" },
	[59395204] = { name="Brightly Colored Egg", preWrath=false, tip="Inside the broken keg" },
	[59465259] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[59495201] = { name="Brightly Colored Egg", preWrath=false, tip="In the planter box" },
	[59665211] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[59665283] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[59695390] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[59705290] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[59725136] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[59765293] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[59895205] = { name="Brightly Colored Egg", preWrath=false, tip="On top of the street lamp" },
	[59925320] = { name="Brightly Colored Egg", preWrath=false  },
	[60015363] = { name="Brightly Colored Egg", preWrath=false },
	[60375368] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[60385100] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[60395407] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[60435358] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[60455103] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[60565011] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[60645007] = { name="Brightly Colored Egg", preWrath=false, continentShow=true, tip="Concealed in the shrubbery" },
	[60655136] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[60925335] = { name="Brightly Colored Egg", preWrath=false, tip="In the well" },
	[60985181] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[61025168] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[61165141] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[61245036] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[61245254] = { name="Brightly Colored Egg", preWrath=false, tip="Under the General Supplies cart" },
	[61435265] = { name="Brightly Colored Egg", preWrath=false, tip="Under the window sill/bench" },
	[61445048] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[61445257] = { name="Brightly Colored Egg", preWrath=false, tip="Under the window sill/bench" },
	[61455093] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[61485288] = { name="Brightly Colored Egg", preWrath=false, tip="In a nook but the view is blocked by shrubbery" },
	[61495164] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[61495208] = { name="Brightly Colored Egg", preWrath=false, tip="Under the window sill/bench" },
	[61505084] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[61515201] = { name="Brightly Colored Egg", preWrath=false, tip="Under the window sill/bench" },
	[61525145] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[61545173] = { name="Brightly Colored Egg", preWrath=false, tip="Behind the stacked boxes, well concealed!" },
	[61565354] = { name="Brightly Colored Egg", preWrath=false, tip="On top of the street lamp" },
	[61655122] = { name="Brightly Colored Egg", preWrath=false, tip="Behind the crate and the dilapidated keg" },
	[61795295] = { name="Brightly Colored Egg", preWrath=false,
					tip="Under the window sill/bench and\nconcealed by shrubbery. Doubly hidden!" },
	[61865128] = { name="Brightly Colored Egg", preWrath=false, tip="Behind two kegs" },
	[61885191] = { name="Brightly Colored Egg" },
	[61895296] = { name="Brightly Colored Egg", preWrath=false,
					tip="Under the window sill/bench and\nconcealed by shrubbery. Doubly hidden!" },
	[61965172] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[62035188] = { name="Brightly Colored Egg", preWrath=false, tip="Concealed in the shrubbery" },
	[62035264] = { name="Brightly Colored Egg" },
}
points[ 78 ] = { -- UnGoro Crater Retail
	[54406240] = { aID=2416, name="Marshall's Stand", tip="hb1" }, -- Hard Boiled
	[35805105] = { aID=2416, name="Golakka Hot Springs", continentShow=true, tip="hb2" }, -- Hard Boiled
}
points[ 1449 ] = { -- UnGoro Crater Wrath
	[30604880] = { aID=2416, tip="hb2", preWrath=false, continentShow=true, name="Golakka Hot Springs" }, -- Hard Boiled
}

points[ 12 ] = { -- Kalimdor Retail - Special for Teldrassil/Dolanaar
	[43941020] = { aID=2419, aIndex=2, faction="Alliance", tip="AnywhereT" }, -- Spring Fling
	[43741008] = { quest=13480, faction="Alliance", qName="The Great Egg Hunt" },
--	[43841047] = { quest=73192, faction="Alliance", qName="An Egg-centric Discovery" },
	[44701130] = { name="Brightly Colored Egg", preWrath=false, continentShow=true },
}
points[ 1414 ] = { --Kalimdor Classic Special case
	[43581215] = { aID=2419, aIndex=4, faction="Alliance", tip="AnywhereT" }, -- Spring Fling
	[44001200] = { quest=13480, faction="Alliance", qName="The Great Egg Hunt" }, -- Not exact coord translation
	[44601060] = { name="Brightly Colored Egg", preWrath=true, continentShow=true },
	[44901400] = { name="Brightly Colored Egg", preWrath=false, continentShow=true },
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

scaling[1] = 0.55
scaling[2] = 0.55
scaling[3] = 0.55
scaling[4] = 0.55
scaling[5] = 0.55
scaling[6] = 0.55
scaling[7] = 0.65
scaling[8] = 0.62
scaling[9] = 0.75
scaling[10] = 0.75
scaling[11] = 0.42
scaling[12] = 0.42
scaling[13] = 0.42
scaling[14] = 0.42
scaling[15] = 0.42
scaling[16] = 0.42
