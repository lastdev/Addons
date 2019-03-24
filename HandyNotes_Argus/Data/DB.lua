-- $Id: DB.lua 69 2017-07-02 14:44:27Z arith $
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
-- Functions
local _G = getfenv(0)
local pairs = _G.pairs;
-- Libraries
-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...
local LibStub = _G.LibStub
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name);

local function GetLocaleLibBabble(typ)
	local rettab = {}
	local tab = LibStub(typ):GetBaseLookupTable()
	local loctab = LibStub(typ):GetUnstrictLookupTable()
	for k,v in pairs(loctab) do
		rettab[k] = v;
	end
	for k,v in pairs(tab) do
		if not rettab[k] then
			rettab[k] = v;
		end
	end
	return rettab;
end
local BZ = GetLocaleLibBabble("LibBabble-SubZone-3.0")

local DB = {}

private.DB = DB

DB.points = {
	--[[ structure:
	[mapID] = { -- "_terrain1" etc will be stripped from attempts to fetch this
		[coord] = {
			label=[string], 		-- label: text that'll be the label, optional
			npc=[id], 				-- related npc id, used to display names in tooltip
			type = [string], 			-- the pre-define icon type which can be found in Constant.lua
			class = [CLASS NAME],		-- specified the class name so that this node will only be available for this class
			note=[string],			-- additional notes for this node
		},
	},
	--]]
	-- Krokuun 
	[830] = { 
		[63118106] = { portal=true, label=format(L["Portal to %s"], BZ["The Vindicaar"]), },
		[62348230] = { portal=true, label=format(L["Portal to %s"], BZ["Dalaran"]), },
	},
	-- Mac'Aree
	[882] = { 
		[55468299] = { portal=true, label=format(L["Portal to %s"], BZ["The Vindicaar"]), },
	},
	-- Antoran Wastes
	[885] = { 
	},
}

-- /////////////////////////////////
-- Treasure Chest
-- /////////////////////////////////
DB.treasures = {}
DB.treasures.Krokuun = {
	[55947421] = { label=L["Precious Augari Keepsakes"], object = 277344, },
	[75186978] = { label=L["Long-Lost Augari Treasure"], object = 277343, },
	[57506350] = { },
	[59267343] = { label=L["Eredar War Supplies"] },
	[57005471] = { label=L["Eredar War Supplies"] },
	[50206670] = { label=L["Eredar War Supplies"] },
	[71366154] = { label=L["Eredar War Supplies"] },

	[52707610] = { label=L["Eredar War Supplies"] },
	[53107310] = { label=L["Eredar War Supplies"] },
	[56807220] = { label=L["Eredar War Supplies"] },
	[58207180] = { label=L["Eredar War Supplies"] },
	[59307330] = { label=L["Eredar War Supplies"] },
	[60207600] = { label=L["Eredar War Supplies"] },
	[58607985] = { label=L["Eredar War Supplies"], quest=47753 },
	[58108050] = { label=L["Eredar War Supplies"] },
	[56208050] = { label=L["Eredar War Supplies"] },
	[55208110] = { label=L["Eredar War Supplies"] },
	
	[43806700] = { label=L["Eredar War Supplies"] },
	[43806970] = { label=L["Eredar War Supplies"] },
	[45906790] = { label=L["Eredar War Supplies"] },
	[46906820] = { label=L["Eredar War Supplies"] },
	[45807300] = { label=L["Eredar War Supplies"] },
	[48267376] = { label=L["Eredar War Supplies"], quest=47997 },
	[49707580] = { label=L["Eredar War Supplies"] },
	[45907740] = { label=L["Eredar War Supplies"] },
	[46807980] = { label=L["Eredar War Supplies"] },
	[46608340] = { label=L["Eredar War Supplies"] },
	[46508510] = { label=L["Eredar War Supplies"] },
	[46508660] = { label=L["Eredar War Supplies"] },
	[44208650] = { label=L["Eredar War Supplies"] },
	[42508770] = { label=L["Eredar War Supplies"] },
	[42708580] = { label=L["Eredar War Supplies"] },
	[41608380] = { label=L["Eredar War Supplies"] },
	[41107990] = { label=L["Eredar War Supplies"] },
	[42707550] = { label=L["Eredar War Supplies"] },
	[40607530] = { label=L["Eredar War Supplies"] },
	[40307410] = { label=L["Eredar War Supplies"] },
	
	[59705210] = { label=L["Eredar War Supplies"] },
	[58505060] = { label=L["Eredar War Supplies"] },
	[57005470] = { label=L["Eredar War Supplies"] },
	[56705860] = { label=L["Eredar War Supplies"] },
	[55505850] = { label=L["Eredar War Supplies"] },
	[52005950] = { label=L["Eredar War Supplies"] },
	[51405950] = { label=L["Eredar War Supplies"] },
	[49605880] = { label=L["Eredar War Supplies"] },
	[50405130] = { label=L["Eredar War Supplies"] },
	[52205420] = { label=L["Eredar War Supplies"] },
	[53235096] = { label=L["Eredar War Supplies"], quest=47752 },
	[55505230] = { label=L["Eredar War Supplies"] },
	
	[59101880] = { label=L["Eredar War Supplies"] },
	[60901870] = { label=L["Eredar War Supplies"] },
	[66902570] = { label=L["Eredar War Supplies"] },
	[66702500] = { label=L["Eredar War Supplies"] },
	[65902290] = { label=L["Eredar War Supplies"] },
	[64602320] = { label=L["Eredar War Supplies"] },
	[62502590] = { label=L["Eredar War Supplies"] },
	[60402360] = { label=L["Eredar War Supplies"] },
	[57702620] = { label=L["Eredar War Supplies"] },
	[60802870] = { label=L["Eredar War Supplies"] },
	[60502790] = { label=L["Eredar War Supplies"] },
	[58502880] = { label=L["Eredar War Supplies"] },
	[59503050] = { label=L["Eredar War Supplies"] },
	[62303210] = { label=L["Eredar War Supplies"] },
	[60603320] = { label=L["Eredar War Supplies"] },
	[59503280] = { label=L["Eredar War Supplies"] },
	[61603520] = { label=L["Eredar War Supplies"] },
	[62703800] = { label=L["Eredar War Supplies"] },
	[62504170] = { label=L["Eredar War Supplies"] },
	[59604420] = { label=L["Eredar War Supplies"] },
	[59703950] = { label=L["Eredar War Supplies"] },
	[58303630] = { label=L["Eredar War Supplies"] },
	[55903680] = { label=L["Eredar War Supplies"] },
	[55503590] = { label=L["Eredar War Supplies"] },
	[54803180] = { label=L["Eredar War Supplies"] },
	[54003040] = { label=L["Eredar War Supplies"] },
	[52003680] = { label=L["Eredar War Supplies"] },
	[51603580] = { label=L["Eredar War Supplies"] },
	[49803670] = { label=L["Eredar War Supplies"] },
	[46223621] = { label=L["Eredar War Supplies"] },
	[47702890] = { label=L["Eredar War Supplies"] },
	[48703100] = { label=L["Eredar War Supplies"] },
	[48403350] = { label=L["Eredar War Supplies"] },
	[49103360] = { label=L["Eredar War Supplies"] },
	[51103220] = { label=L["Eredar War Supplies"] },

	[36507610] = { label=L["Eredar War Supplies"] },
	[36907430] = { label=L["Eredar War Supplies"] },
	[37807370] = { label=L["Eredar War Supplies"] },
	[32107450] = { label=L["Eredar War Supplies"] },
	[31907290] = { label=L["Eredar War Supplies"] },
	[28307130] = { label=L["Eredar War Supplies"] },
	[28607050] = { label=L["Eredar War Supplies"] },
	[26106810] = { label=L["Eredar War Supplies"] },
	[27206680] = { label=L["Eredar War Supplies"] },
	[31906750] = { label=L["Eredar War Supplies"] },
	[30306410] = { label=L["Eredar War Supplies"] },
	[29605770] = { label=L["Eredar War Supplies"] },
	[36506760] = { label=L["Eredar War Supplies"] },
	[37106410] = { label=L["Eredar War Supplies"] },
	[34606300] = { label=L["Eredar War Supplies"] },
	[40606070] = { label=L["Eredar War Supplies"] },
	[41385831] = { label=L["Eredar War Supplies"] },
	[40505550] = { label=L["Eredar War Supplies"] },
	[38905910] = { label=L["Eredar War Supplies"] },
	[38705720] = { label=L["Eredar War Supplies"] },
	[36605890] = { label=L["Eredar War Supplies"] },
	[36805620] = { label=L["Eredar War Supplies"] },
	[36205540] = { label=L["Eredar War Supplies"] },
	[35405630] = { label=L["Eredar War Supplies"] },
	[33605520] = { label=L["Eredar War Supplies"] },
	[29605770] = { label=L["Eredar War Supplies"] },
	
	[70503070] = { label=L["Eredar War Supplies"] },
	[72303250] = { label=L["Eredar War Supplies"] },
	[73503430] = { label=L["Eredar War Supplies"] },
	[72503600] = { label=L["Eredar War Supplies"] },
	[67703460] = { label=L["Eredar War Supplies"] },
	[65903510] = { label=L["Eredar War Supplies"] },
	[68503880] = { label=L["Eredar War Supplies"] },
	[64904210] = { label=L["Eredar War Supplies"] },
	[63104250] = { label=L["Eredar War Supplies"] },
	[61806420] = { label=L["Eredar War Supplies"] },
	[61306650] = { label=L["Eredar War Supplies"] },
	[54606590] = { label=L["Eredar War Supplies"] },
	[53956768] = { label=L["Eredar War Supplies"] },
	[52906280] = { label=L["Eredar War Supplies"] },
	[51606350] = { label=L["Eredar War Supplies"] },
	[46206180] = { label=L["Eredar War Supplies"] },
	[45805850] = { label=L["Eredar War Supplies"] },
	[43505520] = { label=L["Eredar War Supplies"] },
	[43505080] = { label=L["Eredar War Supplies"] },
	[46404910] = { label=L["Eredar War Supplies"] },
	[46304650] = { label=L["Eredar War Supplies"] },
	[44904350] = { label=L["Eredar War Supplies"] },
	[46104070] = { label=L["Eredar War Supplies"] },
	[47604190] = { label=L["Eredar War Supplies"] },
}
for k, v in pairs(DB.treasures.Krokuun) do
	DB.points[830][k] = v
	DB.points[830][k]["treasure"] = true
end

DB.treasures.AntoranWastes = {
	[69013346] = {},
	[71195442] = { label=L["Legion War Supplies"] },
	[72185677] = { label=L["Legion War Supplies"] },
	[76695809] = { label=L["Legion War Supplies"] },
	[75605266] = { label=L["Timeworn Fel Chest"] },
	
	[65903980] = { label=L["Ancient Legion War Cache"] },
	[52202720] = { label=L["Fel-Bound Chest"] },
	[58805920] = { label=L["Forgotten Legion Supplies"] },
	[49005930] = { label=L["Legion Treasure Hoard"] },

	[58704330] = { label=L["Legion War Supplies"] },
	[60204360] = { label=L["Legion War Supplies"] },
	[60604090] = { label=L["Legion War Supplies"] },
	[60404690] = { label=L["Legion War Supplies"] },
	[62104580] = { label=L["Legion War Supplies"] },
	[64204230] = { label=L["Legion War Supplies"] },
	[64604010] = { label=L["Legion War Supplies"] },
	[64204710] = { label=L["Legion War Supplies"] },
	[62905000] = { label=L["Legion War Supplies"] },
	[64305030] = { label=L["Legion War Supplies"] },
	[65205170] = { label=L["Legion War Supplies"] },
	[65504090] = { label=L["Legion War Supplies"] },

	[71105450] = { label=L["Legion War Supplies"] },
	[69805520] = { label=L["Legion War Supplies"] },
	[68005060] = { label=L["Legion War Supplies"] },
	[67404780] = { label=L["Legion War Supplies"] },
	[66604670] = { label=L["Legion War Supplies"] },
	[65304950] = { label=L["Legion War Supplies"] },
	[65105060] = { label=L["Legion War Supplies"] },
	[65105500] = { label=L["Legion War Supplies"] },
	[63505620] = { label=L["Legion War Supplies"] },
	[63105750] = { label=L["Legion War Supplies"] },
	[64105860] = { label=L["Legion War Supplies"] },
	
	[59601390] = { label=L["Legion War Supplies"] },
	[59301750] = { label=L["Legion War Supplies"] },
	[55901400] = { label=L["Legion War Supplies"] },
	[55901720] = { label=L["Legion War Supplies"] },
	[55502050] = { label=L["Legion War Supplies"] },
	[56002660] = { label=L["Legion War Supplies"] },
	[54202790] = { label=L["Legion War Supplies"] },
	[51502600] = { label=L["Legion War Supplies"] },
	
	[72205680] = { label=L["Legion War Supplies"] },
	[76505660] = { label=L["Legion War Supplies"] },
	[78005610] = { label=L["Legion War Supplies"] },
	[76605810] = { label=L["Legion War Supplies"] },
	[77205890] = { label=L["Legion War Supplies"] },
	[80506160] = { label=L["Legion War Supplies"] },
	[82606510] = { label=L["Legion War Supplies"] },
	[82506750] = { label=L["Legion War Supplies"] },
	[81306860] = { label=L["Legion War Supplies"] },
	[77207510] = { label=L["Legion War Supplies"] },
	[72607270] = { label=L["Legion War Supplies"] },
	[73406860] = { label=L["Legion War Supplies"] },
	[76506480] = { label=L["Legion War Supplies"] },
	[77306410] = { label=L["Legion War Supplies"] },
	
	[65502850] = { label=L["Legion War Supplies"] },
	[63703650] = { label=L["Legion War Supplies"] },
	[66703640] = { label=L["Legion War Supplies"] },
	[68903350] = { label=L["Legion War Supplies"] },
	[68004020] = { label=L["Legion War Supplies"] },
	[69503950] = { label=L["Legion War Supplies"] },
	[72504210] = { label=L["Legion War Supplies"] },
	[73504670] = { label=L["Legion War Supplies"] },
}
for k, v in pairs(DB.treasures.AntoranWastes) do
	DB.points[885][k] = v
	DB.points[885][k]["treasure"] = true
end

DB.treasures.MacAree = {
	[35303588] = { label=L["Void-Seeped Cache"] },
	[32912386] = { label=L["Void-Seeped Cache"] },
	[47206250] = { label=L["Ancient Eredar Cache"] },
	[48106150] = { label=L["Ancient Eredar Cache"] },
	[52806170] = { label=L["Ancient Eredar Cache"] },
	[54905760] = { label=L["Ancient Eredar Cache"] },
	[57506170] = { label=L["Ancient Eredar Cache"] },
	[59506390] = { label=L["Ancient Eredar Cache"] },
	[59806970] = { label=L["Ancient Eredar Cache"] },
	[60907060] = { label=L["Ancient Eredar Cache"] },
	[54806700] = { label=L["Ancient Eredar Cache"] },
	[53006650] = { label=L["Ancient Eredar Cache"] },
	[50906720] = { label=L["Ancient Eredar Cache"] },
	[51807140] = { label=L["Ancient Eredar Cache"] },
	[50107590] = { label=L["Ancient Eredar Cache"] },
	[52808250] = { label=L["Ancient Eredar Cache"] },
	[53208000] = { label=L["Ancient Eredar Cache"] },
	[55107780] = { label=L["Ancient Eredar Cache"] },
	[55407350] = { label=L["Ancient Eredar Cache"] },
	[57507510] = { label=L["Ancient Eredar Cache"] },

	[53902320] = { label=L["Ancient Eredar Cache"] },
	[54902500] = { label=L["Ancient Eredar Cache"] },
	[53502750] = { label=L["Ancient Eredar Cache"] },
	[53603450] = { label=L["Ancient Eredar Cache"] },
	[55003520] = { label=L["Ancient Eredar Cache"] },
	[58704070] = { label=L["Ancient Eredar Cache"] },
	[60503350] = { label=L["Ancient Eredar Cache"] },
	[60503200] = { label=L["Ancient Eredar Cache"] },
	[62302630] = { label=L["Ancient Eredar Cache"] },
	[63302250] = { label=L["Ancient Eredar Cache"] },
	[63301990] = { label=L["Ancient Eredar Cache"] },
	[59502090] = { label=L["Ancient Eredar Cache"] },

	[47507080] = { label=L["Ancient Eredar Cache"] },
	[46907330] = { label=L["Ancient Eredar Cache"] },
	[46007220] = { label=L["Ancient Eredar Cache"] },
	[44506870] = { label=L["Ancient Eredar Cache"] },
	[43706840] = { label=L["Ancient Eredar Cache"] },
	[43607150] = { label=L["Ancient Eredar Cache"] },
	[41106890] = { label=L["Ancient Eredar Cache"] },
	[38506700] = { label=L["Ancient Eredar Cache"] },
	[36306640] = { label=L["Ancient Eredar Cache"] },
	[34206560] = { label=L["Ancient Eredar Cache"] },
	[38506440] = { label=L["Ancient Eredar Cache"] },
	[38106360] = { label=L["Ancient Eredar Cache"] },
	[37206270] = { label=L["Ancient Eredar Cache"] },
	[37106100] = { label=L["Ancient Eredar Cache"] },
	[37805870] = { label=L["Ancient Eredar Cache"] },
	[39205920] = { label=L["Ancient Eredar Cache"] },
	[40506280] = { label=L["Ancient Eredar Cache"] },
	[41606330] = { label=L["Ancient Eredar Cache"] },
	[42406150] = { label=L["Ancient Eredar Cache"] },
	[43506010] = { label=L["Ancient Eredar Cache"] },
	[42305750] = { label=L["Ancient Eredar Cache"] },
	[44005650] = { label=L["Ancient Eredar Cache"] },
	[42605380] = { label=L["Ancient Eredar Cache"] },
	[40505550] = { label=L["Ancient Eredar Cache"] },
	[37205550] = { label=L["Ancient Eredar Cache"] },
	[35705620] = { label=L["Ancient Eredar Cache"] },
	[33805550] = { label=L["Ancient Eredar Cache"] },
	[34205750] = { label=L["Ancient Eredar Cache"] },
	[34305920] = { label=L["Ancient Eredar Cache"] },
	[35605710] = { label=L["Ancient Eredar Cache"] },

	[67202820] = { label=L["Ancient Eredar Cache"] },
	[66502900] = { label=L["Ancient Eredar Cache"] },
	[64902950] = { label=L["Ancient Eredar Cache"] },
	[62003280] = { label=L["Ancient Eredar Cache"] },
	[67803190] = { label=L["Ancient Eredar Cache"] },
	[69503270] = { label=L["Ancient Eredar Cache"] },
	[70103380] = { label=L["Ancient Eredar Cache"] },
	[68803710] = { label=L["Ancient Eredar Cache"] },
	[65303560] = { label=L["Ancient Eredar Cache"] },
	[68504130] = { label=L["Ancient Eredar Cache"] },
	[65504190] = { label=L["Ancient Eredar Cache"] },
	[69504490] = { label=L["Ancient Eredar Cache"] },
	[67204620] = { label=L["Ancient Eredar Cache"] },
	[66004690] = { label=L["Ancient Eredar Cache"] },
	[68404890] = { label=L["Ancient Eredar Cache"] },
	[69604960] = { label=L["Ancient Eredar Cache"] },
	[70505110] = { label=L["Ancient Eredar Cache"] },
	[68505310] = { label=L["Ancient Eredar Cache"] },
	[67205370] = { label=L["Ancient Eredar Cache"] },
	[67205690] = { label=L["Ancient Eredar Cache"] },
	[65906010] = { label=L["Ancient Eredar Cache"] },
	[64505950] = { label=L["Ancient Eredar Cache"] },
	[64605600] = { label=L["Ancient Eredar Cache"] },
	[61505550] = { label=L["Ancient Eredar Cache"] },
	[62905050] = { label=L["Ancient Eredar Cache"] },
	[63804530] = { label=L["Ancient Eredar Cache"] },
	[59804660] = { label=L["Ancient Eredar Cache"] },
	[60904370] = { label=L["Ancient Eredar Cache"] },
	[61904270] = { label=L["Ancient Eredar Cache"] },
	[62204080] = { label=L["Ancient Eredar Cache"] },

	[58701330] = { label=L["Ancient Eredar Cache"] },
	[58001060] = { label=L["Ancient Eredar Cache"] },
	[53300850] = { label=L["Ancient Eredar Cache"] },
	[55001740] = { label=L["Ancient Eredar Cache"] },
	[52601630] = { label=L["Ancient Eredar Cache"] },
	[50001420] = { label=L["Ancient Eredar Cache"] },
	[48201210] = { label=L["Ancient Eredar Cache"] },
	[46101320] = { label=L["Ancient Eredar Cache"] },
	[46501510] = { label=L["Ancient Eredar Cache"] },
	[45101350] = { label=L["Ancient Eredar Cache"] },
	[44701850] = { label=L["Ancient Eredar Cache"] },
	[42501790] = { label=L["Ancient Eredar Cache"] },
	[47901970] = { label=L["Ancient Eredar Cache"] },
	[47602190] = { label=L["Ancient Eredar Cache"] },
	[48602110] = { label=L["Ancient Eredar Cache"] },
	[45102480] = { label=L["Ancient Eredar Cache"] },
	[49502410] = { label=L["Ancient Eredar Cache"] },
	[50002950] = { label=L["Ancient Eredar Cache"] },
	[51702860] = { label=L["Ancient Eredar Cache"] },

	[19704210] = { label=L["Ancient Eredar Cache"] },
	[24703860] = { label=L["Ancient Eredar Cache"] },
	[29003380] = { label=L["Ancient Eredar Cache"] },
	[25503000] = { label=L["Ancient Eredar Cache"] },
	[32604700] = { label=L["Ancient Eredar Cache"] },
	[47103660] = { label=L["Ancient Eredar Cache"] },
	[49503580] = { label=L["Ancient Eredar Cache"] },
	[49003950] = { label=L["Ancient Eredar Cache"] },
	[49904160] = { label=L["Ancient Eredar Cache"] },
	[53604200] = { label=L["Ancient Eredar Cache"] },
	[54704490] = { label=L["Ancient Eredar Cache"] },
	[51004770] = { label=L["Ancient Eredar Cache"] },
	[48404980] = { label=L["Ancient Eredar Cache"] },
	[49805510] = { label=L["Ancient Eredar Cache"] },
	[50605580] = { label=L["Ancient Eredar Cache"] },
	[59505870] = { label=L["Ancient Eredar Cache"] },

}
for k, v in pairs(DB.treasures.MacAree) do
	DB.points[882][k] = v
	DB.points[882][k]["treasure"] = true
end

-- /////////////////////////////////
-- rare mobs
-- /////////////////////////////////
DB.rares = {}
-- Krokuun
DB.rares.Krokuun = {
	[58407610] = { npc=120393, quest=48627, label=L["Siegemaster Voraan"], },
	[40704340] = { npc=125824, quest=48561, label=L["Khazaduum"], },
	[45305890] = { npc=124775, quest=48564, label=L["Commander Endaxis"], },
	[33307620] = { npc=122912, quest=48562, label=L["Commander Sathrenael"], },
	[38305980] = { npc=122911, quest=48563, label=L["Commander Vecaya"], },
	[70503370] = { npc=126419, quest=48667, label=L["Naroua <King of the Forest>"], },
	[52803110] = { npc=123464, quest=48565, label=L["Sister Subversia <Coven of Shivarra>"], },
	[54708120] = { npc=123689, quest=48628, label=L["Talestra the Vile"], },
	[70108140] = { npc=125479, quest=48665, label=L["Tar Spitter"], },
	--[69305940] = { npc=1, label=L["Tereck the Selector - Entrance"], },
	[69205940] = { npc=124804, quest=48664, label=L["Tereck the Selector"], },
	[60901960] = { npc=125388, quest=48091, label=L["Vagath the Betrayed"], },
	[42406990] = { npc=125820, quest=48666, label=L["Imp Mother Laglath"], },
}
for k, v in pairs(DB.rares.Krokuun) do
	DB.points[830][k] = v
	DB.points[830][k]["rare"] = true
end
-- Antoran Wastes
DB.rares.AntoranWastes = {
	[73507200] = { npc=127090, quest=48817, label=L["Admiral Rel'var"], },
	[74905700] = { npc=127096, quest=48818, label=L["All-Seer Xanarian"], },
	[61703690] = { npc=122958, quest=49183, label=L["Blistermaw"], },
	[61402100] = { npc=127376, quest=48865, label=L["Chief Alchemist Munculus"], },
	[80506280] = { npc=127084, quest=48816, label=L["Commander Texlaz"], }, -- portal position
	[55704590] = { npc=122999, quest=49241, label=L["Gar'zoth"], },
	[63102520] = { npc=127288, quest=48821, label=L["Houndmaster Kerrax"], }, -- Entrance
	[61104570] = { npc=126946, quest=48815, label=L["Inquisitor Vethroz"], }, --Path Start
	[62305350] = { npc=126254, quest=48813, label=L["Lieutenant Xakaar"], },
	[57403290] = { npc=122947, quest=49240, label=L["Mistress Il'thendra"], }, -- Inside Building
	[65602660] = { npc=127705, quest=48970, label=L["Mother Rosula"], }, -- Same as Puscilla
	[65602660] = { npc=126040, quest=48809, label=L["Puscilla"], }, -- Cave Entrance
	[54703910] = { npc=127581, quest=48966, label=L["The Many-Faced Devourer"], }, -- Spot to Summon
	[64304820] = { npc=126208, quest=48812, label=L["Varga"], }, -- Cave Entrance
	[66005410] = { npc=126115, quest=48811, label=L["Ven'orn"], }, -- Cave Entrance
	[55702190] = { npc=127300, quest=48824, label=L["Void Warden Valsuran"], },
	[52903620] = { npc=126199, quest=48810, label=L["Vrax'thul"], },
	[52902940] = { npc=127291, quest=48822, label=L["Watcher Aival"], },
	[50905530] = { npc=127118, quest=48820, label=L["Worldsplitter Skuul"], },
	[61406510] = { npc=126338, quest=48814, label=L["Wrath-Lord Yarez"], },}
for k, v in pairs(DB.rares.AntoranWastes) do
	DB.points[885][k] = v
	DB.points[885][k]["rare"] = true
end
-- Mac'Aree
DB.rares.MacAree = {
	[62695006] = { npc=126900, quest=48718, label=L["Instructor Tarahna"], },
	[33754831] = { npc=126867, quest=48705, label=L["Venomtail Skyfin"], },
	[41331224] = { npc=126864, quest=48702, label=L["Feasel the Muffin Thief"], },
}
for k, v in pairs(DB.rares.MacAree) do
	DB.points[882][k] = v
	DB.points[882][k]["rare"] = true
end

-- /////////////////////////////////
-- Entrance
-- /////////////////////////////////
--[[
DB.entrances = {
	[50201710] = { label=format(L["Entrance of %s"], L["Khazaduum"]), },
}

for k, v in pairs(DB.entrances) do
	DB.points[830][k] = v
	DB.points[830][k]["entrance"] = true
end
]]

-- /////////////////////////////////
-- Felbloom
-- /////////////////////////////////
DB.felbloom = {}
DB.felbloom.Krokuun = {
	[56365786] = {  },
	[54635520] = {  },
}
for k, v in pairs(DB.felbloom.Krokuun) do
	DB.points[830][k] = v
	DB.points[830][k]["felbloom"] = true
	DB.points[830][k]["label"] = L["Felbloom"]
end

DB.felbloom.AntoranWastes = {
	[69013346] = {},
}
for k, v in pairs(DB.felbloom.AntoranWastes) do
	DB.points[885][k] = v
	DB.points[885][k]["felbloom"] = true
	DB.points[885][k]["label"] = L["Felbloom"]
end

-- Fallen Soldier, Blessing if the Righteous
--[[
	[32847339] = {},
	[33846858] = {},
	[38646658] = {},
	[40247046] = {},
	[36376909] = {},
]]
