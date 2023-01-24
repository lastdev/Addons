local _, ns = ...
local points = ns.points
local textures = ns.textures
local scaling = ns.scaling
local texturesSpecial = ns.texturesSpecial
local scalingSpecial = ns.scalingSpecial

points[ns.votfw] = {	-- "D", ["Author"], tip
						-- "N", idRep, name, tip
	[29633445] = { "D" },
	[31085362] = { "D" },
	[31403198] = { "D" },
	[31403396] = { "D" },
	[31702670] = { "D" },
	[31925255] = { "D" },
	[31925918] = { "D" },
	[32165795] = { "D" },
	[32583071] = { "D" },
	[32595845] = { "D", },
	[32675778] = { "D" },
	[32824906] = { "D" },
	[32844976] = { "D" },
	[33015311] = { "D", "Under the water tower" },
	[33125822] = { "D" },
	[33234843] = { "D" },
	[33352911] = { "D" },
	[33834360] = { "D" },
	[34045069] = { "D" },
	[34074926] = { "D" },
	[34574207] = { "D" },
	[34704451] = { "D" },
	[34775107] = { "D" },
	[34833834] = { "D" },
	[34844934] = { "D" },
	[34855269] = { "D" },
	[34905014] = { "D" },
	[34953513] = { "D" },
	[35504931] = { "D" },
	[35545114] = { "D" },
	[35864000] = { "D" },
	[36035161] = { "D" },
	[36344952] = { "D" },
	[36485291] = { "D" },
	[36765099] = { "D" },
	[37184876] = { "D" },
	[37734623] = { "D" },
	[37994414] = { "D" },
	[38245042] = { "D" },
	[38374595] = { "D" },
	[38564231] = { "D", "Under the foliage" },
	[38824500] = { "D", "Under the hut" },
	[38944165] = { "D" },
	[39034094] = { "D" },
	[39035160] = { "D" },
	[39054286] = { "D", "Under the foliage" },
	[39124424] = { "D", "Under the hut's\nnorthern side ramp" },
	[39504243] = { "D", "Under the foliage" },
	[39584982] = { "D" },
	[39634032] = { "D", "Author" },	-- *
	[39634081] = { "D", "Under the foliage" },
	[39683888] = { "D", "Under the trees.\nVery difficult to see" },
	[39835116] = { "D", "Under the foliage" },
	[39854587] = { "D" },
	[39944845] = { "D", "Under the foliage" },
	[39985194] = { "D", "Under the foliage" },
	[40034754] = { "D", },
	[40115108] = { "D", "Under the foliage" },
	[40233989] = { "D" },
	[40283825] = { "D", "Under the foliage" },
	[40475170] = { "D", "Under the foliage" },
	[40494153] = { "D" },
	[40504929] = { "D", "Under the foliage" },
	[40564853] = { "D", "Under the foliage" },
	[40574362] = { "D" },
	[40714460] = { "D" },
	[40763866] = { "D" },
	[40785117] = { "D", "Under the foliage" },
	[40824719] = { "D" },
	[40833529] = { "D", "Author" },	-- *
	[40883664] = { "D" },
	[40903452] = { "D" },
	[40914021] = { "D" },
	[40915178] = { "D", "Under the foliage" },
	[40954495] = { "D", "Under the foliage" },
	[41004944] = { "D", "Under the foliage" },
	[41264902] = { "D", "Under the foliage" },
	[41404578] = { "D", "Under the foliage" },
	[41413992] = { "D", "Author" },	-- *
	[41493820] = { "D", "Descend into the Springtail Warren" },
	[41494400] = { "D", "Author", "Under the foliage" },	-- *
	[41585279] = { "D", "Under the foliage" },
	[41653332] = { "D" },
	[41753448] = { "D" },
	[41784805] = { "D", "Under the foliage" },
	[41865213] = { "D", "Under the foliage" },
	[41884709] = { "D" },
	[41913716] = { "D", "Author" },	-- *
	[42023115] = { "D", "Under the tree, at\nthe edge of the lake" },
	[42093967] = { "D", "Author" },	-- *
	[42124785] = { "D", "Under the foliage" },
	[42174876] = { "D" },
	[42185318] = { "D", "Under the foliage" },
	[42264930] = { "D" },
	[42405223] = { "D", "Under the foliage" },
	[42413393] = { "D" },
	[42524691] = { "D", "Under the foliage" },
	[42615011] = { "D" },
	[42963585] = { "D" },
	[42993951] = { "D" },
	[43125391] = { "D", "Under the foliage" },
	[43143761] = { "D" },
	[43264929] = { "D", "Under the foliage" },
	[43344986] = { "D", "Under the foliage" },
	[43435291] = { "D", "Under the foliage" },
	[43465223] = { "D", "Under the water tower" },
	[43623956] = { "D", "Under the foliage" },
	[43784861] = { "D" },
	[43853703] = { "D", "Under the foliage" },
	[43915048] = { "D", "Author", "Under the foliage" },	-- *
	[44014759] = { "D", "Under the foliage" },
	[44164222] = { "D" },
	[44305384] = { "D" },
	[44484075] = { "D" },
	[44624346] = { "D" },
	[44673335] = { "D", "Under the tree.\nIn front of Thunder" },
	[44673777] = { "D" },
	[44685332] = { "D", "Under the foliage" },
	[44853574] = { "D", },
	[44923665] = { "D", "Under the foliage" },
	[45285335] = { "D", "Under the foliage" },
	[45434617] = { "D", "Under the foliage" },
	[45435374] = { "D" },
	[45483765] = { "D", "Under the foliage" },
	[45555286] = { "D" },
	[45624135] = { "D" },
	[45824529] = { "D" },
	[45843958] = { "D" },
	[45845358] = { "D" },
	[45893537] = { "D" },
	[45985397] = { "D" },
	[46083257] = { "D", "Under the foliage" },
	[46265261] = { "D", "Under the foliage" },
	[46333764] = { "D" },
	[46383631] = { "D" },
	[46453447] = { "D", "Under the bridge" },
	[46584225] = { "D", "Under the water tower" },
	[46635283] = { "D", "Under the foliage" },
	[46653394] = { "D", "Under the foliage" },
	[46743295] = { "D", "Under the foliage" },
	[46815580] = { "D", "Author" },	-- *
	[46993714] = { "D" },
	[46993785] = { "D" },
	[47165123] = { "D", "Under the foliage" },
	[47373569] = { "D", "Under the foliage" },
	[47583807] = { "D" },
	[47773267] = { "D" },
	[47773475] = { "D" },
	[47824624] = { "D" },
	[47895030] = { "D" },
	[47913716] = { "D" },
	[47992870] = { "D" },
	[48013606] = { "D" },
	[48034883] = { "D", "Under the foliage" },
	[48283219] = { "D" },
	[48353905] = { "D", "Under the foliage" },
	[48404975] = { "D" },
	[48412920] = { "D" },
	[48623373] = { "D" },
	[48702918] = { "D" },
	[49003314] = { "D", "Under the foliage" },
	[49372799] = { "D" },
	[49503248] = { "D", "Author" },	-- *
	[49553184] = { "D", "Under the foliage" },
	[50072744] = { "D" },
	[50243160] = { "D" },
	[50392829] = { "D", "Under the foliage" },
	[50493382] = { "D", "Under the foliage" },
	[50782952] = { "D" },
	[51103009] = { "D", "Under the foliage" },
	[51122822] = { "D", "Under the foliage" },
	[51143083] = { "D", "Under the foliage" },
	[51192938] = { "D" },
	[51342897] = { "D" },
	[29533059] = { "N", 1278, "Sho" }, -- 4
	[30945310] = { "N", 1276, "Old Hillpaw" },
	[31515807] = { "N", 1275, "Ella" }, -- 3
	[34414676] = { "N", 1277, "Chee Chee" }, -- 3
	[41733002] = { "N", 1282, "Fish Fellreed" },
	[44653406] = { "N", 1279, "Haohan Mudclaw" },
	[45093377] = { "N", 1280, "Tina Mudclaw" , "Inside the building" }, -- 3
	[48283385] = { "N", 1283, "Farmer Fung" },
	[53575257] = { "N", 1273, "Jogu the Drunk" }, -- 4
	[53165180] = { "N", 1281, "Gina Mudclaw" },
	[52254894] = { "O", 30526, "Dog", "Please see my \"Loose Pebble\" AddOn for\n"
										.."allowing Dog to visit (Broken Isles) Dalaran!" },
						-- Reminder: See core for how I treat 30526
	[42395000] = { "O", 30526, "Lost Dog", "A Lost Dog will appear here when you\n"
										.."reach Revered +12,600 with The Tillers" },
	[52024800] = { "O", 30252, "Farmer Yoon", "Begin your Tillers journey here!\n"
											.."Please enable \"low level\" quests" },
	[52254879] = { "O", 30257, "Farmer Yoon", "Continue your Tillers journey here!" },
	[52965180] = { "O", 31945, "Gina's Vote Quest", "Continue your Tillers journey here!\n"
											.."Buy up to four packets of seeds as\n"
											.."your plot only has space for four.\n\n"
											.."Dark Soil is available to harvest!!!" },
	[51974832] = { "O", 31945, "Gina's Vote Quest", "Your sown seeds will probably have\n"
											.."problems such as weeds. Look around\n"
											.."for tools to help you or try pulling\n"
											.."on the problem seedlings!\n\n"
											.."From now on you must wait for your\n"
											.."plants to grow!\n\n"
											.."Dark Soil is available to harvest!!!" },
	[51004650] = { "O", 31945, "Dark Soil", "At this stage you may dig up Dark Soil\n"
											.."and turn in any valuable finds to NPCs.\n"
											.."Check the tooltips for each NPC to\n"
											.."ensure you give them their favourite\n"
											.."find.\n\n"
											.."The markers show the \"home\" location of\n"
											.."each Tillers NPC. If they are not present\n"
											.."you can find them at the market.\n\n"
											.."Set \"Ground Clutter\" to \"1\" in\n"
											.."Options -> Graphics -> Advanced" },
	[52504650] = { "O", 31945, "Dailies", "There will be six possible dailies.\n\n"
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
	[54004650] = { "O", 31945, "One-Off Quests", "Sho (4), Ella (3), Chee Chee (4), Tina (4) and\n"
												.."Jogu (4) have one-off quests which become\n"
												.."available at reputation milestones, such as\n"
												.."when you newly attain \"Friend\" status.\n"
												.."These award a nice chunk of reputation.\n\n"
												.."Tina's quests are actually items dropped by\n"
												.."mobs and which are then turned in to her" },
	-- Note: Author not implemented for "B"
	[32886269] = { "B", "Blackhoof", "Battle Horn" },
	[34545922] = { "B", "Blackhoof", "Battle Horn"  },
	[36962575] = { "B", "Sulik'shor", "Crystal of Insanity" },
	[37826040] = { "B", "Blackhoof", "Battle Horn", },
	[39635765] = { "B", "Blackhoof", "Battle Horn"  }, 
	[45403838] = { "B", "Ghostly Pandaren Craftsman", 31292, "Standing under a tree" },
	[43613748] = { "B", "Cache of Pilfered Goods", 31406, "Descend into the Springtail Warren" },
	
	[18944247] = { "S", "Staff of the Hidden Master", "Confirmed" },
	[19103770] = { "S", "Staff of the Hidden Master" },
	[17503580] = { "S", "Staff of the Hidden Master" },
	[14903370] = { "S", "Staff of the Hidden Master" },
	[15502910] = { "S", "Staff of the Hidden Master" },
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

scaling[1] = 0.85
scaling[2] = 0.85
scaling[3] = 0.83
scaling[4] = 0.83
scaling[5] = 0.83
scaling[6] = 0.83
scaling[7] = 0.95
scaling[8] = 0.95
scaling[9] = 1.2
scaling[10] = 1.2
scalingSpecial[1] = 0.58
scalingSpecial[2] = 0.77
scalingSpecial[3] = 0.77
scalingSpecial[4] = 0.77
scalingSpecial[5] = 0.68
scalingSpecial[6] = 0.65
scalingSpecial[7] = 0.62
scalingSpecial[8] = 0.93
