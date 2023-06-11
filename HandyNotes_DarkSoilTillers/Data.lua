local _, ns = ...
local points = ns.points
local textures = ns.textures
local scaling = ns.scaling
local texturesSpecial = ns.texturesSpecial
local scalingSpecial = ns.scalingSpecial

local maxFour = "There are a maximum of\nfour spawned locations\nat any one time"

points[ 418 ] = { -- Krasarang Wilds
	[29247533] = { pinType="K", tip=maxFour },
	[31026383] = { pinType="K", tip=maxFour },
	[31326645] = { pinType="K", tip=maxFour },
	[31627977] = { pinType="K", tip=maxFour },
	[31927374] = { pinType="K", tip=maxFour },
	[33376971] = { pinType="K", tip=maxFour },
	[35187030] = { pinType="K", tip=maxFour },
}

points[ 376 ] = { -- Valley of the Four Winds
	[29633445] = { pinType="D" },
	[31085362] = { pinType="D" },
	[31403198] = { pinType="D" },
	[31403396] = { pinType="D" },
	[31702670] = { pinType="D" },
	[31925255] = { pinType="D" },
	[31925918] = { pinType="D" },
	[32165795] = { pinType="D" },
	[32395727] = { pinType="D" },
	[32562377] = { pinType="D" },
	[32583071] = { pinType="D" },
	[32595845] = { pinType="D" },
	[32675778] = { pinType="D" },
	[32824906] = { pinType="D" },
	[32844976] = { pinType="D" },
	[33015311] = { pinType="D", tip="Under the water tower" },
	[33125822] = { pinType="D" },
	[33234843] = { pinType="D" },
	[33352911] = { pinType="D" },
	[33834360] = { pinType="D" },
	[34045069] = { pinType="D" },
	[34074926] = { pinType="D" },
	[34574207] = { pinType="D" },
	[34704451] = { pinType="D" },
	[34775107] = { pinType="D" },
	[34833834] = { pinType="D" },
	[34844934] = { pinType="D" },
	[34855269] = { pinType="D" },
	[34905014] = { pinType="D" },
	[34953513] = { pinType="D" },
	[35504931] = { pinType="D" },
	[35545114] = { pinType="D" },
	[35864000] = { pinType="D" },
	[36035161] = { pinType="D" },
	[36344952] = { pinType="D" },
	[36485291] = { pinType="D" },
	[36765099] = { pinType="D" },
	[37184876] = { pinType="D" },
	[37734623] = { pinType="D" },
	[37994414] = { pinType="D" },
	[38245042] = { pinType="D" },
	[38374595] = { pinType="D" },
	[38564231] = { pinType="D", tip="Under the foliage" },
	[38591825] = { pinType="D", tip="Descend into the Springtail Crag" },
	[38824500] = { pinType="D", tip="Under the hut" },
	[38944165] = { pinType="D", tip="Same colour as the soil" },
	[39034094] = { pinType="D" },
	[39035160] = { pinType="D" },
	[39054286] = { pinType="D", tip="Under the foliage" },
	[39124424] = { pinType="D", tip="Under the hut's\nnorthern side ramp" },
	[39172073] = { pinType="D", tip="At the entrance" },
	[39251700] = { pinType="D", tip="Descend into the Springtail Crag" },
	[39504243] = { pinType="D", tip="Under the foliage" },
	[39584982] = { pinType="D" },
	[39634032] = { pinType="D", author=true },	-- *
	[39634081] = { pinType="D", tip="Under the foliage" },
	[39683888] = { pinType="D", tip="Under the trees.\nVery difficult to see" },
	[39744340] = { pinType="D", tip="Under the foliage" },
	[39835116] = { pinType="D", tip="Under the foliage" },
	[39854587] = { pinType="D" },
	[39944845] = { pinType="D", tip="Under the foliage" },
	[39985194] = { pinType="D", tip="Under the foliage" },
	[40034754] = { pinType="D", },
	[40115108] = { pinType="D", tip="Under the foliage" },
	[40233989] = { pinType="D" },
	[40283825] = { pinType="D", tip="Under the foliage" },
	[40313699] = { pinType="D", tip="Under the foliage" },
	[40475170] = { pinType="D", tip="Under the foliage" },
	[40494153] = { pinType="D" },
	[40504929] = { pinType="D", tip="Under the foliage" },
	[40564853] = { pinType="D", tip="Under the foliage" },
	[40574362] = { pinType="D" },
	[40714460] = { pinType="D" },
	[40763866] = { pinType="D" },
	[40785117] = { pinType="D", tip="Under the foliage" },
	[40824719] = { pinType="D" },
	[40833529] = { pinType="D" },
	[40883664] = { pinType="D" },
	[40903452] = { pinType="D" },
	[40914021] = { pinType="D" },
	[40915178] = { pinType="D", tip="Under the foliage" },
	[40954495] = { pinType="D", tip="Under the foliage" },
	[41004944] = { pinType="D", tip="Under the foliage" },
	[41264902] = { pinType="D", tip="Under the foliage" },
	[41404578] = { pinType="D", tip="Under the foliage" },
	[41413992] = { pinType="D", },
	[41493820] = { pinType="D", tip="Descend into the Springtail Warren" },
	[41494400] = { pinType="D", authorOnly=true, tip="Under the foliage" },	-- *
	[41585279] = { pinType="D", tip="Under the foliage" },
	[41653332] = { pinType="D" },
	[41753448] = { pinType="D" },
	[41784805] = { pinType="D", tip="Under the foliage" },
	[41865213] = { pinType="D", tip="Under the foliage" },
	[41884709] = { pinType="D" },
	[41913716] = { pinType="D", author=true },	-- *
	[42023115] = { pinType="D", tip="Under the tree, at\nthe edge of the lake" },
	[42093967] = { pinType="D", },
	[42124785] = { pinType="D", tip="Under the foliage" },
	[42174876] = { pinType="D" },
	[42185318] = { pinType="D", tip="Under the foliage" },
	[42264930] = { pinType="D" },
	[42405223] = { pinType="D", tip="Under the foliage" },
	[42413393] = { pinType="D" },
	[42443917] = { pinType="D", tip="Descend into the Springtail Warren" },
	[42524691] = { pinType="D", tip="Under the foliage" },
	[42615011] = { pinType="D" },
	[42963585] = { pinType="D" },
	[42993951] = { pinType="D" },
	[43125391] = { pinType="D", tip="Under the foliage" },
	[43143761] = { pinType="D" },
	[43264929] = { pinType="D", tip="Under the foliage" },
	[43344986] = { pinType="D", tip="Under the foliage" },
	[43435291] = { pinType="D", tip="Under the foliage" },
	[43465223] = { pinType="D", tip="Under the water tower" },
	[43623956] = { pinType="D", tip="Under the foliage" },
	[43784861] = { pinType="D" },
	[43853703] = { pinType="D", tip="Under the foliage" },
	[43915048] = { pinType="D", tip="Under the foliage" },	
	[43942011] = { pinType="D", tip="Descend into the Springtail Crag" },
	[44014759] = { pinType="D", tip="Under the foliage" },
	[44164222] = { pinType="D" },
	[44305384] = { pinType="D" },
	[44364555] = { pinType="D" },
	[44442283] = { pinType="D", tip="At the entrance" },
	[44484075] = { pinType="D" },
	[44523852] = { pinType="D" },
	[44571883] = { pinType="D", tip="Descend into the Springtail Crag" },
	[44624346] = { pinType="D" },
	[44673335] = { pinType="D", tip="Under the tree.\nIn front of Thunder" },
	[44673777] = { pinType="D" },
	[44685332] = { pinType="D", tip="Under the foliage" },
	[44853574] = { pinType="D", },
	[44923665] = { pinType="D", tip="Under the foliage" },
	[45161908] = { pinType="D", tip="Descend into the Springtail Crag" },
	[45285335] = { pinType="D", tip="Under the foliage" },
	[45434617] = { pinType="D", tip="Under the foliage" },
	[45435374] = { pinType="D" },
	[45483765] = { pinType="D", tip="Under the foliage" },
	[45555286] = { pinType="D" },
	[45624135] = { pinType="D" },
	[45824529] = { pinType="D" },
	[45843958] = { pinType="D" },
	[45845358] = { pinType="D" },
	[45893537] = { pinType="D" },
	[45985397] = { pinType="D" },
	[46083257] = { pinType="D", tip="Under the foliage" },
	[46265261] = { pinType="D", tip="Under the foliage" },
	[46333764] = { pinType="D" },
	[46383631] = { pinType="D" },
	[46453447] = { pinType="D", tip="Under the bridge" },
	[46584225] = { pinType="D", tip="Under the water tower" },
	[46635283] = { pinType="D", tip="Under the foliage" },
	[46653394] = { pinType="D", tip="Under the foliage" },
	[46743295] = { pinType="D", tip="Under the foliage" },
	[46815580] = { pinType="D", authorOnly=true },	-- *
	[46834159] = { pinType="D", },
	[46993714] = { pinType="D", },
	[46993785] = { pinType="D", tip="Same colour as the soil" },
	[47165123] = { pinType="D", tip="Under the foliage" },
	[47332116] = { pinType="D", tip="At the entrance" },
	[47373569] = { pinType="D", tip="Under the foliage" },
	[47583807] = { pinType="D" },
	[47651896] = { pinType="D", tip="Descend into the Springtail Crag" },
	[47773267] = { pinType="D" },
	[47773475] = { pinType="D" },
	[47824624] = { pinType="D" },
	[47895030] = { pinType="D" },
	[47913716] = { pinType="D" },
	[47992870] = { pinType="D" },
	[48013606] = { pinType="D" },
	[48034883] = { pinType="D", tip="Under the foliage" },
	[48283219] = { pinType="D" },
	[48321839] = { pinType="D", tip="Descend into the Springtail Crag" },
	[48353905] = { pinType="D", tip="Under the foliage" },
	[48404975] = { pinType="D" },
	[48412920] = { pinType="D" },
	[48623373] = { pinType="D" },
	[48702918] = { pinType="D" },
	[48981875] = { pinType="D", tip="Descend into the Springtail Crag" },
	[49003314] = { pinType="D", tip="Under the foliage" },
	[49372799] = { pinType="D" },
	[49503248] = { pinType="D", author=true },	-- *
	[49553184] = { pinType="D", tip="Under the foliage" },
	[50072744] = { pinType="D" },
	[50243160] = { pinType="D" },
	[50392829] = { pinType="D", tip="Under the foliage" },
	[50493382] = { pinType="D", tip="Under the foliage" },
	[50782952] = { pinType="D" },
	[51103009] = { pinType="D", tip="Under the foliage" },
	[51122822] = { pinType="D", tip="Under the foliage" },
	[51143083] = { pinType="D", tip="Under the foliage" },
	[51192938] = { pinType="D" },
	[51342897] = { pinType="D" },

	[14490986] = { pinType="V", },
	[15211190] = { pinType="V", },
	[15261088] = { pinType="V", tip="Same colour as the soil" },
	[16310801] = { pinType="V", },
	[16901412] = { pinType="V", tip="Same colour as the soil" },
	[17350042] = { pinType="V", tip="Under the foliage" },
	[19041006] = { pinType="V", tip="Same colour as the soil" },
	[21321303] = { pinType="V", },
	[23411714] = { pinType="V", },
	[25010970] = { pinType="V", },
	[25301495] = { pinType="V", },
	[25641192] = { pinType="V", },
	[27352863] = { pinType="V", tip="Under the foliage" },
	[28201801] = { pinType="V", },
	[30183039] = { pinType="V", tip="Under the foliage" },
	[30781803] = { pinType="V", tip="Half under the statue" },
	[30971676] = { pinType="V", },
	[31201235] = { pinType="V", tip="Under the foliage" },
	[33563481] = { pinType="V", tip="Under the foliage" },
	[34301050] = { pinType="V", },
	[35641431] = { pinType="V", },
	[36361882] = { pinType="V", tip="Under the foliage" },
	[36761071] = { pinType="V", },
	[38290320] = { pinType="V", tip="Under the foliage" },
	[38711243] = { pinType="V", tip="Under the foliage" },
	[38981025] = { pinType="V", },
	[39330712] = { pinType="V", },

	[29533059] = { pinType="N", friendID=1278, name="Sho" }, -- 4
	[30945310] = { pinType="N", friendID=1276, name="Old Hillpaw" },
	[31515807] = { pinType="N", friendID=1275, name="Ella" }, -- 3
	[34414676] = { pinType="N", friendID=1277, name="Chee Chee" }, -- 3
	[41733002] = { pinType="N", friendID=1282, name="Fish Fellreed" },
	[44653406] = { pinType="N", friendID=1279, name="Haohan Mudclaw" },
	[45093377] = { pinType="N", friendID=1280, name="Tina Mudclaw" , tip="Inside the building" }, -- 3
	[48283385] = { pinType="N", friendID=1283, name="Farmer Fung" },
	[53575257] = { pinType="N", friendID=1273, name="Jogu the Drunk" }, -- 4
	[53165180] = { pinType="N", friendID=1281, name="Gina Mudclaw" },

	[52254894] = { pinType="O", quest=30526, "Dog", -- Reminder: See core for how I treat 30526
					tip="Please see my \"Loose Pebble\" AddOn for\n"
					.."allowing Dog to visit (Broken Isles) Dalaran!" },
	[42395000] = { pinType="O", quest=30526, title="Lost Dog",
					tip="A Lost Dog will appear here when you\n"
					.."reach Revered +12,600 with The Tillers" },
	[52024800] = { pinType="O", quest=30252, title="Farmer Yoon",
					tip="Begin your Tillers journey here!\n"
					.."Please enable \"low level\" quests" },
	[52254879] = { pinType="O", quest=30257, title="Farmer Yoon", "Continue your Tillers journey here!" },
	[52965180] = { pinType="O", quest=31945, title="Gina's Vote Quest",
					tip="Continue your Tillers journey here!\n"
					.."Buy up to four packets of seeds as\n"
					.."your plot only has space for four.\n\n"
					.."Dark Soil is available to harvest!!!" },
	[51974832] = { pinType="O", quest=31945, title="Gina's Vote Quest",
					tip="Your sown seeds will probably have\n"
					.."problems such as weeds. Look around\n"
					.."for tools to help you or try pulling\n"
					.."on the problem seedlings!\n\n"
					.."From now on you must wait for your\n"
					.."plants to grow!\n\n"
					.."Dark Soil is available to harvest!!!" },
	[51004650] = { pinType="O", quest=31945, title="Dark Soil",
					tip="At this stage you may dig up Dark Soil\n"
					.."and turn in any valuable finds to NPCs.\n"
					.."Check the tooltips for each NPC to\n"
					.."ensure you give them their favourite\n"
					.."find.\n\n"
					.."The markers show the \"home\" location of\n"
					.."each Tillers NPC. If they are not present\n"
					.."you can find them at the market.\n\n"
					.."Set \"Ground Clutter\" to \"1\" in\n"
					.."Options -> Graphics -> Advanced" },
	[52504650] = { pinType="O", quest=31945, title="Dailies",
					tip="There will be six possible dailies.\n\n"
					.."Two out of ten NPCs will travel from\n"
					.."their home into the market. Both will\n"
					.."offer their personal daily quest.\n\n"
					.."Andi, near the market, will offer a quest\n"
					.."to earn rep with one of the ten NPCs.\n\n"
					.."Farmer Yoon, at your farm, will offer\n"
					.."both a farming and a killing quest for\n"
					.."Tillers rep.\n\n"
					.."(You'll notice a cooking daily too. This\n"
					.."does nothing for The Tillers)" },
	[54004650] = { pinType="O", quest=31945, title="One-Off Quests",
					tip="Sho (4), Ella (3), Chee Chee (4), Tina (4) and\n"
					.."Jogu (4) have one-off quests which become\n"
					.."available at reputation milestones, such as\n"
					.."when you newly attain \"Friend\" status.\n"
					.."These award a nice chunk of reputation.\n\n"
					.."Tina's quests are actually items dropped by\n"
					.."mobs and which are then turned in to her" },

	[14933373] = { pinType="B", quest=31407, item=86218 }, -- Staff of the Hidden Master
	[15422917] = { pinType="B", quest=31407, item=86218 },
	[17473586] = { pinType="B", quest=31407, item=86218 },
	[18944247] = { pinType="B", quest=31407, item=86218 },
	[19183773] = { pinType="B", quest=31407, item=86218 },
	[32886269] = { pinType="B", title="Blackhoof", item="Battle Horn" },
	[34545922] = { pinType="B", title="Blackhoof", item="Battle Horn"  },
	[36962575] = { pinType="B", title="Sulik'shor", item="Crystal of Insanity" },
	[37826040] = { pinType="B", title="Blackhoof", item="Battle Horn", },
	[39635765] = { pinType="B", title="Blackhoof", item="Battle Horn"  }, 
	[43613748] = { pinType="B", title="Cache of Pilfered Goods", quest=31406,
					tip="Descend into the Springtail Warren" },
	[45403838] = { pinType="B", title="Ghostly Pandaren Craftsman", quest=31292, tip="Standing under a tree" },
	[46802440] = { pinType="B", title="Ghostly Pandaren Fisherman", quest=31284, },
	[72540985] = { pinType="B", title="Forgotten Lockbox", quest=31867,
					tip="Second floor of the \"Tavern in the Mists\"" },
	[92083907] = { pinType="B", title="Boat-Building Instructions", quest=31869, item=87524, obj=214340 },
}

points[ 390 ] = { -- Vale of Eternal Blossoms
	[14636578] = { pinType="V", },
	[15766894] = { pinType="V", },
	[15846736] = { pinType="V", tip="Same colour as the soil" },
	[16604562] = { pinType="V", },
	[17466291] = { pinType="V", },
	[18212859] = { pinType="V", tip="Under the foliage" },
	[18377238] = { pinType="V", tip="Same colour as the soil" },
	[19075114] = { pinType="V", tip="Under the foliage" },
	[21686610] = { pinType="V", tip="Same colour as the soil" },
	[22012846] = { pinType="V", tip="Under the foliage" },
	[25227070] = { pinType="V", },
	[28467707] = { pinType="V", },
	[30946553] = { pinType="V", },
	[31911724] = { pinType="V", },
	[31397367] = { pinType="V", },
	[31916897] = { pinType="V", },
	[35897843] = { pinType="V", },
	[39877846] = { pinType="V", tip="Half under the statue" },
	[40177649] = { pinType="V", },
	[40536965] = { pinType="V", tip="Under the foliage" },
	[45336677] = { pinType="V", },
	[47417268] = { pinType="V", },
	[49156710] = { pinType="V", },
	[51515546] = { pinType="V", tip="Under the foliage" },
	[52166977] = { pinType="V", tip="Under the foliage" },
	[52596639] = { pinType="V", },
	[53126154] = { pinType="V", },
}

points[ 371 ] = { -- The Jade Forest
	[23206046] = { pinType="B", title="Forgotten Lockbox", quest=31867,
					tip="Second floor of the \"Tavern in the Mists\"" },
	[34187689] = { pinType="B", title="Boat-Building Instructions", quest=31869, item=87524, obj=214340 },
}
points[ 433 ] = { -- The Veiled Stair
	[54667122] = { pinType="B", title="Forgotten Lockbox", quest=31867,
					tip="Second floor of the \"Tavern in the Mists\"" },
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
texturesSpecial[1] = "Interface\\Common\\RingBorder"
texturesSpecial[2] = "Interface\\PlayerFrame\\DeathKnight-Energize-Blood"
texturesSpecial[3] = "Interface\\PlayerFrame\\DeathKnight-Energize-Frost"
texturesSpecial[4] = "Interface\\PlayerFrame\\DeathKnight-Energize-Unholy"
texturesSpecial[5] = "Interface\\PetBattles\\DeadPetIcon"
texturesSpecial[6] = "Interface\\RaidFrame\\UI-RaidFrame-Threat"
texturesSpecial[7] = "Interface\\PlayerFrame\\UI-PlayerFrame-DeathKnight-Frost"
texturesSpecial[8] = "Interface\\HelpFrame\\HelpIcon-CharacterStuck"	

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
scalingSpecial[1] = 0.46
scalingSpecial[2] = 0.62
scalingSpecial[3] = 0.62
scalingSpecial[4] = 0.62
scalingSpecial[5] = 0.54
scalingSpecial[6] = 0.52
scalingSpecial[7] = 0.5
scalingSpecial[8] = 0.74
