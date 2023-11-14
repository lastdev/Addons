local _, ns = ...
local points = ns.points
local textures = ns.textures
local scaling = ns.scaling
local texturesSpecial = ns.texturesSpecial
local scalingSpecial = ns.scalingSpecial

local maxFour = "There are a maximum of\nfour spawned locations\nat any one time"

points[ 379 ] = { -- Kun-Lai Summit
}

points[ 418 ] = { -- Krasarang Wilds
	[29167012] = { pinType="KW", tip=maxFour },
	[29247533] = { pinType="KW", tip=maxFour },
	[31026383] = { pinType="KW", tip=maxFour },
	[31286975] = { pinType="KW", tip=maxFour },
	[31326645] = { pinType="KW", tip=maxFour },
	[31627977] = { pinType="KW", tip=maxFour },
	[31927374] = { pinType="KW", tip=maxFour },
	[33016786] = { pinType="KW", tip=maxFour },
	[33187664] = { pinType="KW", tip="Under the tree" },
	[33317907] = { pinType="KW", tip=maxFour },
	[33376971] = { pinType="KW", tip=maxFour },
	[34066691] = { pinType="KW", tip=maxFour },
	[35187030] = { pinType="KW", tip=maxFour },
	[35696693] = { pinType="KW", tip=maxFour },
	[35797859] = { pinType="KW", tip=maxFour },
	[36037153] = { pinType="KW", tip=maxFour },
	[36207445] = { pinType="KW", tip=maxFour },
	[36367040] = { pinType="KW", tip=maxFour },
	[36897654] = { pinType="KW", tip=maxFour },
	[36987898] = { pinType="KW", tip=maxFour },
}

points[ 371 ] = { -- The Jade Forest
	[52075827] = { pinType="TJF" },
	[53866024] = { pinType="TJF" },
	[54746046] = { pinType="TJF" },
	[55005078] = { pinType="TJF" },
	[57435333] = { pinType="TJF" },
	[57926249] = { pinType="TJF" },
	[61402442] = { pinType="TJF" },
	[61472274] = { pinType="TJF" },
	[63542417] = { pinType="TJF" },
	[63773117] = { pinType="TJF" },
	[63952857] = { pinType="TJF" },
	[64822874] = { pinType="TJF" },
	[65283239] = { pinType="TJF", author=true },
	[65653041] = { pinType="TJF" },
}

points[ 388 ] = { -- Townlong Steppes
	[18184711] = { pinType="TS", },
	[18673934] = { pinType="TS", tip="Under the tree" },
	[18814187] = { pinType="TS", },
	[19881717] = { pinType="TS", },
	[20432394] = { pinType="TS", },
	[20501434] = { pinType="TS", },
	[21603774] = { pinType="TS", },
	[22505788] = { pinType="TS", },
	[23163879] = { pinType="TS", },
	[24804089] = { pinType="TS", tip="Under the tree" },
	[24845669] = { pinType="TS", },
	[25261684] = { pinType="TS", },
	[26265394] = { pinType="TS", },
	[26871842] = { pinType="TS", },
	[30692585] = { pinType="TS", },
	[33102622] = { pinType="TS", },
	[36305558] = { pinType="TS", },
	[41986346] = { pinType="TS", },
	[43146654] = { pinType="TS", },
	[43195397] = { pinType="TS", },
	[44054950] = { pinType="TS", },
}

points[ 390 ] = { -- Vale of Eternal Blossoms
	[08173911] = { pinType="VEB", },
	[10544245] = { pinType="VEB", },
	[14636578] = { pinType="VEB", },
	[15102716] = { pinType="VEB", },
	[15766894] = { pinType="VEB", },
	[15846736] = { pinType="VEB", tip="Same colour as the soil" },
	[16604562] = { pinType="VEB", },
	[16613506] = { pinType="VEB", },
	[17466291] = { pinType="VEB", },
	[18212859] = { pinType="VEB", tip="Under the foliage" },
	[18377238] = { pinType="VEB", tip="Same colour as the soil" },
	[19062047] = { pinType="VEB", },
	[19075114] = { pinType="VEB", tip="Under the foliage" },
	[20504254] = { pinType="VEB", },
	[21043159] = { pinType="VEB", },
	[21686610] = { pinType="VEB", tip="Same colour as the soil" },
	[22012846] = { pinType="VEB", tip="Under the foliage" },
	[22261730] = { pinType="VEB", },
	[24642629] = { pinType="VEB", },
	[25227070] = { pinType="VEB", },
	[25603127] = { pinType="VEB", },
	[26511847] = { pinType="VEB", },
	[28467707] = { pinType="VEB", },
	[29432587] = { pinType="VEB", },
	[30946553] = { pinType="VEB", },
	[31911724] = { pinType="VEB", },
	[31397367] = { pinType="VEB", },
	[31432044] = { pinType="VEB", },
	[31916897] = { pinType="VEB", },
	[34562256] = { pinType="VEB", },
	[35543103] = { pinType="VEB", },
	[35897843] = { pinType="VEB", },
	[38313353] = { pinType="VEB", },
	[39877846] = { pinType="VEB", tip="Half under the statue" },
	[40177649] = { pinType="VEB", },
	[40536965] = { pinType="VEB", tip="Under the foliage" },
	[45336677] = { pinType="VEB", },
	[47417268] = { pinType="VEB", },
	[49156710] = { pinType="VEB", },
	[50632273] = { pinType="VEB", },
	[51515546] = { pinType="VEB", tip="Under the foliage" },
	[52166977] = { pinType="VEB", tip="Under the foliage" },
	[52596639] = { pinType="VEB", },
	[53126154] = { pinType="VEB", },
}

points[ 376 ] = { -- Valley of the Four Winds
	[29633445] = { pinType="VFW" },
	[31085362] = { pinType="VFW" },
	[31403198] = { pinType="VFW" },
	[31403396] = { pinType="VFW" },
	[31702670] = { pinType="VFW" },
	[31925255] = { pinType="VFW" },
	[31925918] = { pinType="VFW" },
	[32165795] = { pinType="VFW" },
	[32395727] = { pinType="VFW" },
	[32562377] = { pinType="VFW" },
	[32583071] = { pinType="VFW" },
	[32595845] = { pinType="VFW" },
	[32675778] = { pinType="VFW" },
	[32824906] = { pinType="VFW" },
	[32844976] = { pinType="VFW" },
	[33015311] = { pinType="VFW", tip="Under the water tower" },
	[33125822] = { pinType="VFW" },
	[33234843] = { pinType="VFW" },
	[33352911] = { pinType="VFW" },
	[33754204] = { pinType="VFW" },
	[33834360] = { pinType="VFW" },
	[33925661] = { pinType="VFW" },
	[34045069] = { pinType="VFW" },
	[34074926] = { pinType="VFW" },
	[34574207] = { pinType="VFW" },
	[34704451] = { pinType="VFW" },
	[34775107] = { pinType="VFW" },
	[34833834] = { pinType="VFW" },
	[34844934] = { pinType="VFW" },
	[34855269] = { pinType="VFW" },
	[34905014] = { pinType="VFW" },
	[34953513] = { pinType="VFW" },
	[35504931] = { pinType="VFW" },
	[35545114] = { pinType="VFW" },
	[35614877] = { pinType="VFW" },
	[35864000] = { pinType="VFW" },
	[36035161] = { pinType="VFW" },
	[36344952] = { pinType="VFW" },
	[36485291] = { pinType="VFW" },
	[36765099] = { pinType="VFW" },
	[37184876] = { pinType="VFW" },
	[37734623] = { pinType="VFW" },
	[37994414] = { pinType="VFW" },
	[38245042] = { pinType="VFW" },
	[38374595] = { pinType="VFW" },
	[38564231] = { pinType="VFW", tip="Under the foliage" },
	[38591825] = { pinType="VFW", tip="Descend into the Springtail Crag" },
	[38824500] = { pinType="VFW", tip="Under the hut" },
	[38944165] = { pinType="VFW", tip="Same colour as the soil" },
	[39034094] = { pinType="VFW" },
	[39035160] = { pinType="VFW" },
	[39054286] = { pinType="VFW", tip="Under the foliage" },
	[39124424] = { pinType="VFW", tip="Under the hut's\nnorthern side ramp" },
	[39172073] = { pinType="VFW", tip="At the entrance" },
	[39251700] = { pinType="VFW", tip="Descend into the Springtail Crag" },
	[39504243] = { pinType="VFW", tip="Under the foliage" },
	[39584982] = { pinType="VFW" },
	[39634032] = { pinType="VFW", author=true },	-- *
	[39634081] = { pinType="VFW", tip="Under the foliage" },
	[39683888] = { pinType="VFW", tip="Under the trees.\nVery difficult to see" },
	[39744340] = { pinType="VFW", tip="Under the foliage" },
	[39835116] = { pinType="VFW", tip="Under the foliage" },
	[39854587] = { pinType="VFW" },
	[39944845] = { pinType="VFW", tip="Under the foliage" },
	[39985194] = { pinType="VFW", tip="Under the foliage" },
	[40034754] = { pinType="VFW", },
	[40115108] = { pinType="VFW", tip="Under the foliage" },
	[40233989] = { pinType="VFW" },
	[40283825] = { pinType="VFW", tip="Under the foliage" },
	[40313699] = { pinType="VFW", tip="Under the foliage" },
	[40475170] = { pinType="VFW", tip="Under the foliage" },
	[40494153] = { pinType="VFW" },
	[40504929] = { pinType="VFW", tip="Under the foliage" },
	[40564853] = { pinType="VFW", tip="Under the foliage" },
	[40574362] = { pinType="VFW" },
	[40714460] = { pinType="VFW" },
	[40763866] = { pinType="VFW" },
	[40785117] = { pinType="VFW", tip="Under the foliage" },
	[40824719] = { pinType="VFW" },
	[40833529] = { pinType="VFW" },
	[40883664] = { pinType="VFW" },
	[40903452] = { pinType="VFW" },
	[40914021] = { pinType="VFW" },
	[40915178] = { pinType="VFW", tip="Under the foliage" },
	[40954495] = { pinType="VFW", tip="Under the foliage" },
	[41004944] = { pinType="VFW", tip="Under the foliage" },
	[41264902] = { pinType="VFW", tip="Under the foliage" },
	[41404578] = { pinType="VFW", tip="Under the foliage" },
	[41413992] = { pinType="VFW", },
	[41493820] = { pinType="VFW", tip="Descend into the Springtail Warren" },
	[41494400] = { pinType="VFW", authorOnly=true, tip="Under the foliage" },	-- *
	[41585279] = { pinType="VFW", tip="Under the foliage" },
	[41613866] = { pinType="VFW" },
	[41653332] = { pinType="VFW" },
	[41753448] = { pinType="VFW" },
	[41784805] = { pinType="VFW", tip="Under the foliage" },
	[41865213] = { pinType="VFW", tip="Under the foliage" },
	[41884709] = { pinType="VFW" },
	[41913716] = { pinType="VFW", author=true },	-- *
	[42023115] = { pinType="VFW", tip="Under the tree, at\nthe edge of the lake" },
	[42093967] = { pinType="VFW", },
	[42124785] = { pinType="VFW", tip="Under the foliage" },
	[42174876] = { pinType="VFW" },
	[42185318] = { pinType="VFW", tip="Under the foliage" },
	[42264930] = { pinType="VFW" },
	[42405223] = { pinType="VFW", tip="Under the foliage" },
	[42413393] = { pinType="VFW" },
	[42443917] = { pinType="VFW", tip="Descend into the Springtail Warren" },
	[42524691] = { pinType="VFW", tip="Under the foliage" },
	[42615011] = { pinType="VFW" },
	[42874566] = { pinType="VFW" },
	[42963585] = { pinType="VFW" },
	[42993951] = { pinType="VFW" },
	[43074359] = { pinType="VFW" },
	[43125391] = { pinType="VFW", tip="Under the foliage" },
	[43143761] = { pinType="VFW" },
	[43214595] = { pinType="VFW" },
	[43264929] = { pinType="VFW", tip="Under the foliage" },
	[43344986] = { pinType="VFW", tip="Under the foliage" },
	[43435291] = { pinType="VFW", tip="Under the foliage" },
	[43465223] = { pinType="VFW", tip="Under the water tower" },
	[43623956] = { pinType="VFW", tip="Under the foliage" },
	[43784861] = { pinType="VFW" },
	[43853703] = { pinType="VFW", tip="Under the foliage" },
	[43915048] = { pinType="VFW", tip="Under the foliage" },	
	[43942011] = { pinType="VFW", tip="Descend into the Springtail Crag" },
	[44014759] = { pinType="VFW", tip="Under the foliage" },
	[44164222] = { pinType="VFW" },
	[44305384] = { pinType="VFW" },
	[44364555] = { pinType="VFW" },
	[44442283] = { pinType="VFW", tip="At the entrance" },
	[44484075] = { pinType="VFW" },
	[44523852] = { pinType="VFW" },
	[44571883] = { pinType="VFW", tip="Descend into the Springtail Crag" },
	[44624346] = { pinType="VFW" },
	[44673335] = { pinType="VFW", tip="Under the tree.\nIn front of Thunder" },
	[44673777] = { pinType="VFW" },
	[44685332] = { pinType="VFW", tip="Under the foliage" },
	[44853574] = { pinType="VFW", },
	[44923665] = { pinType="VFW", tip="Under the foliage" },
	[45161908] = { pinType="VFW", tip="Descend into the Springtail Crag" },
	[45285335] = { pinType="VFW", tip="Under the foliage" },
	[45434617] = { pinType="VFW", tip="Under the foliage" },
	[45435374] = { pinType="VFW" },
	[45483765] = { pinType="VFW", tip="Under the foliage" },
	[45555286] = { pinType="VFW" },
	[45624135] = { pinType="VFW" },
	[45824529] = { pinType="VFW" },
	[45843958] = { pinType="VFW" },
	[45845358] = { pinType="VFW" },
	[45893537] = { pinType="VFW" },
	[45985397] = { pinType="VFW" },
	[46083257] = { pinType="VFW", tip="Under the foliage" },
	[46265261] = { pinType="VFW", tip="Under the foliage" },
	[46333764] = { pinType="VFW" },
	[46383631] = { pinType="VFW" },
	[46453447] = { pinType="VFW", tip="Under the bridge" },
	[46584225] = { pinType="VFW", tip="Under the water tower" },
	[46635283] = { pinType="VFW", tip="Under the foliage" },
	[46653394] = { pinType="VFW", tip="Under the foliage" },
	[46743295] = { pinType="VFW", tip="Under the foliage" },
	[46815580] = { pinType="VFW", authorOnly=true },	-- *
	[46834159] = { pinType="VFW", },
	[46993714] = { pinType="VFW", },
	[46993785] = { pinType="VFW", tip="Same colour as the soil" },
	[47165123] = { pinType="VFW", tip="Under the foliage" },
	[47332116] = { pinType="VFW", tip="At the entrance" },
	[47373569] = { pinType="VFW", tip="Under the foliage" },
	[47583807] = { pinType="VFW" },
	[47651896] = { pinType="VFW", tip="Descend into the Springtail Crag" },
	[47773267] = { pinType="VFW" },
	[47773475] = { pinType="VFW" },
	[47824624] = { pinType="VFW" },
	[47895030] = { pinType="VFW" },
	[47913716] = { pinType="VFW" },
	[47992870] = { pinType="VFW" },
	[48013606] = { pinType="VFW" },
	[48034883] = { pinType="VFW", tip="Under the foliage" },
	[48283219] = { pinType="VFW" },
	[48321839] = { pinType="VFW", tip="Descend into the Springtail Crag" },
	[48353905] = { pinType="VFW", tip="Under the foliage" },
	[48404975] = { pinType="VFW" },
	[48412920] = { pinType="VFW" },
	[48623373] = { pinType="VFW" },
	[48702918] = { pinType="VFW" },
	[48981875] = { pinType="VFW", tip="Descend into the Springtail Crag" },
	[49003314] = { pinType="VFW", tip="Under the foliage" },
	[49372799] = { pinType="VFW" },
	[49503248] = { pinType="VFW", author=true },	-- *
	[49553184] = { pinType="VFW", tip="Under the foliage" },
	[50072744] = { pinType="VFW" },
	[50243160] = { pinType="VFW" },
	[50392829] = { pinType="VFW", tip="Under the foliage" },
	[50493382] = { pinType="VFW", tip="Under the foliage" },
	[50782952] = { pinType="VFW" },
	[51103009] = { pinType="VFW", tip="Under the foliage" },
	[51122822] = { pinType="VFW", tip="Under the foliage" },
	[51143083] = { pinType="VFW", tip="Under the foliage" },
	[51192938] = { pinType="VFW" },
	[51342897] = { pinType="VFW" },

	[14490986] = { pinType="VEB", },
	[15211190] = { pinType="VEB", },
	[15261088] = { pinType="VEB", tip="Same colour as the soil" },
	[16310801] = { pinType="VEB", },
	[16901412] = { pinType="VEB", tip="Same colour as the soil" },
	[17350042] = { pinType="VEB", tip="Under the foliage" },
	[19041006] = { pinType="VEB", tip="Same colour as the soil" },
	[21321303] = { pinType="VEB", },
	[23411714] = { pinType="VEB", },
	[25010970] = { pinType="VEB", },
	[25301495] = { pinType="VEB", },
	[25641192] = { pinType="VEB", },
	[27352863] = { pinType="VEB", tip="Under the foliage" },
	[28201801] = { pinType="VEB", },
	[30183039] = { pinType="VEB", tip="Under the foliage" },
	[30781803] = { pinType="VEB", tip="Half under the statue" },
	[30971676] = { pinType="VEB", },
	[31201235] = { pinType="VEB", tip="Under the foliage" },
	[33563481] = { pinType="VEB", tip="Under the foliage" },
	[34301050] = { pinType="VEB", },
	[35641431] = { pinType="VEB", },
	[36361882] = { pinType="VEB", tip="Under the foliage" },
	[36761071] = { pinType="VEB", },
	[38290320] = { pinType="VEB", tip="Under the foliage" },
	[38711243] = { pinType="VEB", tip="Under the foliage" },
	[38981025] = { pinType="VEB", },
	[39330712] = { pinType="VEB", },

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

	[52254894] = { pinType="O", quest=30526, title="Dog", -- Reminder: See core for how I treat 30526
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
texturesSpecial[9] = "Interface\\Vehicles\\UI-Vehicles-Raid-Icon"

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
scalingSpecial[1] = 0.37
scalingSpecial[2] = 0.49
scalingSpecial[3] = 0.49
scalingSpecial[4] = 0.49
scalingSpecial[5] = 0.43
scalingSpecial[6] = 0.41
scalingSpecial[7] = 0.395
scalingSpecial[8] = 0.57
scalingSpecial[9] = 0.43


