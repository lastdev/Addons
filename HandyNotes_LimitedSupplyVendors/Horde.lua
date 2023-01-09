


if UnitFactionGroup("player") ~= "Horde" then return end


--ToDo:  Fix Item Link Displays


local _, LimitedSupplyVendors = ...
local points = LimitedSupplyVendors.points
-- points[<mapfile>] = { [<coordinates>] = <NPC ID> }

--map icons
--inv_scroll_03 - basic
--inv_scroll_04 - gold
--inv_scroll_05 - blue
--inv_scroll_06 - green


--icons
local bs  =  "|TInterface/Icons/ui_profession_blacksmithing:16:16|t";
local tl  =  "|TInterface/Icons/ui_profession_tailoring:16:16|t";
local lw  =  "|TInterface/Icons/ui_profession_leatherworking:16:16|t";
local eng =  "|TInterface/Icons/ui_profession_engineering:16:16|t";
local enc =  "|TInterface/Icons/ui_profession_enchanting:16:16|t";
local alc =  "|TInterface/Icons/ui_profession_alchemy:16:16|t";
local jc  =  "|TInterface/Icons/ui_profession_jewelcrafting:16:16|t";
local ins =  "|TInterface/Icons/ui_profession_inscription:16:16|t";
local ck  =  "|TInterface/Icons/ui_profession_cooking:16:16|t";
local res =  "|TInterface/Icons/inv_orderhall_orderresources:16:16|t";

local quest = "|TInterface/Icons/inv_misc_questionmark:16:16|t";

local horde = "|TInterface/Icons/inv_bannerpvp_01:16:16|t";
local alliance = "|TInterface/Icons/inv_bannerpvp_02:16:16|t";

local timetraveling = "|TInterface/Icons/inv_relics_hourglass:16:16|t";


--colors
local Grey    = "cff9d9d9d";
local Red     = "cffff4e4e"; 
local Blue    = "cff0070dd"; 
local Green   = "cff1eff00"; 
local White   = "cffffffff"; 
local Orange  = "cffff8000"; 
local Purple  = "cffa335ee"; 
local Teal    = "cff00ccff"; 
local Tan     = "cffe5cc80"; 



--To be Implemented in next build.
function colorize(text, color)
	local colorizedString;
	
	if (color == Grey) then
		colorizedString = Grey .. text .. "|r";
	elseif (color == Red) then
		colorizedString = Red .. text .. "|r";
	elseif (color == Blue) then
		colorizedString = Blue .. text .. "|r";
	else
		colorizedString = White .. text .. "|r";
	end	
	
	return colorizedString;
end


--To be Implemented in next build.
function react(alliance, horde)
	--true = friendly
	--false = unfriendly

	local reactHorde;
	local reactAllaince;

	if(alliance == true) then
		reactAllaince = Green .. "A" .. "|r";
	else
		reactAllaince = Red .. "A" .. "|r";
	end

	if(horde == true) then
		reactHorde = Green .. "H" .. "|r";
	else
		reactHorde = Red .. "H" .. "|r";
	end	

	return tostring(reactAllaince .. reactHorde);
end


--To be Implemented in next build.
function cost(value)
	return GetCoinTextureString(value);
end


----------------------
-- Eastern Kingdoms --
----------------------
points[14] = { -- "Arathi"
	[70093547] = {
		npcid = 2819, --NPC ID
		name = "|cffEEC410Tunkk|r - *Requires Time Traveling* " .. timetraveling, --Vendor Name
		info = tl .." |cff1EFF0BPattern: Raptor Hide Harness|r |cffDF0101Horde only|r " .. horde, --tooltip display
		coords = 70093547, --Cordinates to vendor
		items = {13287}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {2500}, --Cost of each item?
		},

	[69213352] = {
		npcid = 2821, --NPC ID
		name = "|cffEEC410Keena|r - *Requires Time Traveling* " .. timetraveling, --Vendor Name
		info = jc .. " |cffFFFFFFDesign: Ruby Crown of Restoration|r|cffFFFFFF\n" .. lw .. " Pattern: Barbaric Leggings|r", --tooltip display
		coords = 69213352, --Cordinates to vendor
		items = {21942, 5973}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {6000, 650}, --Cost of each item?
		},

	[67773737] = {
		npcid = 6574, --NPC ID
		name = "|cffEEC410Jun'ha|r - *Requires Time Traveling* " .. timetraveling, --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Azure Silk Cloak|r |cffDF0101Horde only|r " .. horde, --tooltip display
		coords = 67773737, --Cordinates to vendor
		items = {7089}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {1500}, --Cost of each item?
		},	
}

points[15] = { -- "Badlands"
	[65073907] = {
		npcid = 48060, --NPC ID
		name = "|cffEEC410'Chef' Overheat|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Undermine Clam Chowder|r", --tooltip display
		coords = 65073907, --Cordinates to vendor
		items = {16767}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {3000}, --Cost of each item?
		},

	[90863875] = {
		npcid = 49918, --NPC ID
		name = "|cffEEC410Buckslappy|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: EZ-Thro Dynamite II|r |cffFFFFFF\n" .. eng .. " Schematic: Blue Firework|r |cffFFFFFF\n" .. eng .. " Schematic: Green Firework|r |cffFFFFFF\n" .. eng .. " Schematic: Red Firework|r", --tooltip display
		coords = 90863875, --Cordinates to vendor
		items = {18650, 18649, 18648, 18647}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {5000, 1800, 1800, 1800}, --Cost of each item?
		},


}


points[17] = { -- "BlastedLands"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}


points[27] = { -- "DunMorogh"
	[17747465] = {
		npcid = 26081, --NPC ID
		name = "|cffEEC410High Admiral 'Shelly' Jorrik|r", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Solid Iron Maul|r", --tooltip display
		coords = 17747465, --Cordinates to vendor
		items = {10858}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {3000}, --Cost of each item?
		},

}


points[47] = { -- "Duskwood"
	[81821977] = {
		npcid = 3134, --NPC ID
		name = "|cffEEC410Kzixx|r", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Holy Protection Potion|r |cffFFFFFF\n" .. eng .. " Schematic: Goblin Jumper Cables|r", --tooltip display
		coords = 81821977, --Cordinates to vendor
		items = {6053, 7561}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {800, 2000}, --Cost of each item?
		},

}


points[23] = { -- "EasternPlaguelands"
	[74365090] = {
		npcid = 12941, --NPC ID
		name = "|cffEEC410Jase Farlane|r", --Vendor Name
		info = jc .. " |cffFFFFFFDesign: Ring of Bitter Shadows|r", --tooltip display
		coords = 74365090, --Cordinates to vendor
		items = {21954}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {10000}, --Cost of each item?
		},

}

points[94] = { -- "EversongWoods"
	[49004700] = {
		npcid = 16262, --NPC ID
		name = "|cffEEC410Landraelanis|r - Falconwing Square", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Lynx Steak|r |cffDF0101Horde only|r " .. horde, --tooltip display
		coords = 49004700, --Cordinates to vendor
		items = {27585}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {40}, --Cost of each item?
		},


}

points[95] = { -- "Ghostlands"
	[47272859] = {
		npcid = 16224, --NPC ID
		name = "|cffEEC410Rathis Tomber|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Red Linen Bag|r", --tooltip display
		coords = 47272859, --Cordinates to vendor
		items = {5771}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {2000}, --Cost of each item?
		},

	[48043100] = {
		npcid = 16253, --NPC ID
		name = "|cffEEC410Master Chef Mouldier|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Bat Bites|r |cffDF0101Horde only|r " .. horde .. "|cffFFFFFF\n" .. ck .. " Recipe: Crunchy Spider Surprise|r", --tooltip display
		coords = 48043100, --Cordinates to vendor
		items = {27687, 22647}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {400, 400}, --Cost of each item?
		},


}

points[25] = { -- "HillsbradFoothills"
	[71164522] = {
		npcid = 6777, --NPC ID
		name = "|cffEEC410Zan Shivsproket|r - *Top of Ravenholdt Manor*", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Gnomish Cloaking Device", --tooltip display
		coords = 71164522, --Cordinates to vendor
		items = {7742}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {2400}, --Cost of each item?
		},

	[57534778] = {
		npcid = 2393, --NPC ID
		name = "|cffEEC410Christoph Jeffcoat|r", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Shadow Protection Potion|r |cffDF0101Horde only|r " .. horde .. "|cff1EFF0B\n" .. lw .. " Pattern: Thick Murloc Armor|r", --tooltip display
		coords = 57534778, --Cordinates to vendor
		items = {6054, 5788}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {900, 650}, --Cost of each item?
		},

	[58064794] = {
		npcid = 2394, --NPC ID
		name = "|cffEEC410Mallen Swain|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Blue Overalls|r |cffFFFFFF\n" .. tl .. " Pattern: Dark Silk Shirt|r", --tooltip display
		coords = 58064794, --Cordinates to vendor
		items = {6274, 6401}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {400, 1100}, --Cost of each item?
		},

	[43962180] = {
		npcid = 2480, --NPC ID
		name = "|cffEEC410Bro'kin|r", --Vendor Name
		info = alc .. " |cff1EFF0BRecipe: Frost Oil|r", --tooltip display
		coords = 43962180, --Cordinates to vendor
		items = {14634}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {2500}, --Cost of each item?
		},

	[76665852] = {
		npcid = 2698, --NPC ID
		name = "|cffEEC410George Candarte|r", --Vendor Name
		info = lw .. " |cffFFFFFFPattern: Green Leather Armor|r", --tooltip display
		coords = 76665852, --Cordinates to vendor
		items = {7613}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {2000}, --Cost of each item?
		},

	[56004604] = {
		npcid = 3537, --NPC ID
		name = "|cffEEC410Zixil !WANDERING!|r", --Vendor Name
		info = enc .. " |cff1EFF0BFormula: Enchant Boots - Minor Agility|r |cffFFFFFF\n" .. lw .. " Pattern: Earthen Leather Shoulders|r |cffFFFFFF\n" .. tl .. " Pattern: Red Woolen Bag|r |cffFFFFFF\n" .. eng .. " Schematic: Goblin Jumper Cables|r", --tooltip display
		coords = 56004604, --Cordinates to vendor
		items = {6377, 7362, 5772, 7561}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {1000, 2000, 500, 2000}, --Cost of each item?
		},


}

points[26] = { -- "Hinterlands"
	[34453859] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Gigget Zipcoil|r", --Vendor Name
		info = lw .. " |cffFFFFFFPattern: Ironfeather Shoulders|r", --tooltip display
		coords = 34453859, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[34343777] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Ruppo Zipcoil|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Mithril Mechanical Dragonling|r", --tooltip display
		coords = 34343777, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

points[32] = { -- "SearingGorge"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}

points[110] = { -- "SilvermoonCity"
	[90907339] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Gelanthis|r", --Vendor Name
		info = jc .. " |cffFFFFFFDesign: Opal Necklace of Impact|r |cffFFFFFF\n" .. jc .. " Design: The Jade Eye|r |cffFFFFFF\n" .. jc .. " Design: Heavy Golden Necklace of Battle|r |cffFFFFFF\n" .. jc .. " Design: Amulet of the Moon|r", --tooltip display
		coords = 90907339, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[70292489] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Lyna|r", --Vendor Name
		info = alc .. " |cffFFFFFFFormula: Superior Mana Oil|r |cffFFFFFF\n" .. enc .. " Formula: Large Prismatic Shard|r |cffFFFFFF\n" .. alc .. " Formula: Superior Wizard Oil|r", --tooltip display
		coords = 70292489, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[55605106] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Deynna|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Bolt of Soulcloth|r", --tooltip display
		coords = 55605106, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[67151947] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Melaris|r", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Elixir of Camouflage|r |cff1EFF0B\n" .. alc .. " Recipe: Transmute Primal Might|r", --tooltip display
		coords = 67151947, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[84747857] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Zaralda|r", --Vendor Name
		info = lw .. " |cffFFFFFFPattern: Comfortable Insoles|r", --tooltip display
		coords = 84747857, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[75624071] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Yatheon|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Adamantite Rifle|r |cffFFFFFF\n" .. eng .. " Schematic: White Smoke Flare|r |cffFFFFFF\n" .. eng .. " Schematic: Fel Iron Toolbox|r", --tooltip display
		coords = 75624071, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[80343616] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Eriden|r", --Vendor Name
		info = bs.. " |cffFFFFFFPlans: Adamantite Maul|r |cffFFFFFF\n" .. bs .. " Plans: Adamantite Cleaver|r |cffFFFFFF\n" .. bs .. " Plans: Adamantite Dagger|r |cffFFFFFF\n" .. bs  .. " Plans: Adamantite Rapier|r", --tooltip display
		coords = 80343616, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

}

points[21] = { -- "Silverpine"
	[53898222] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Leo Sarn|r", --Vendor Name
		info = enc .. " |cffFFFFFFFormula: Enchant 2H Weapon - Lesser Intellect|r", --tooltip display
		coords = 3898222, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},
		
	[46894035] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Lilly|r", --Vendor Name
		info = enc .. " |cff1EFF0BFormula: Enchant Chest - Lesser Mana|r |cffDF0101Horde only|r " .. horde, --tooltip display
		coords = 46894035, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},
		
	[43224066] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Andrew Hilbert|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Blue Linen Robe|r |cffFFFFFF\n" .. ck .. " Recipe: Smoked Bear Meat|r |cffFFFFFF\n" .. lw .. " Pattern: Murloc Scale Breastplate|r |cffFFFFFF\n" .. lw .. " Pattern: Murloc Scale Belt|r |cffFFFFFF\n" .. tl .. " Pattern: Red Linen Bag|r", --tooltip display
		coords = 43224066, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},		
		
}

points[50] = { -- "NorthernStranglethorn"
	[38744907] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Vharr|r", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Massive Iron Axe|r", --tooltip display
		coords = 38744907, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[39025100] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Nerrist|r", --Vendor Name
		info = jc .. " |cffFFFFFFDesign: Truesilver Crab|r |cffFFFFFF\n" .. ck .. " Recipe: Curiously Tasty Omelet|r |cffFFFFFF\n" .. ck .. " Recipe: Jungle Stew|r", --tooltip display
		coords = 39025100, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[37474908] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Uthok|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Spiced Chili Crab|r", --tooltip display
		coords = 37474908, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[43692319] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Jaquilina Dramet|r", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Massive Iron Axe|r", --tooltip display
		coords = 43692319, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[67556118] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Gnaz Blunderflame|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Mechanical Dragonling|r", --tooltip display
		coords = 67556118, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},
		
	[67766112] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Knaz Blunderflame|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Deadly Scope|r", --tooltip display
		coords = 67766112, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},
		
		


}


--Duplicate but added so they show on main map?
points[224] = { -- "StranglethornVale"
--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
	
	
	
		[42633207] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Vharr|r", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Massive Iron Axe|r", --tooltip display
		coords = 42633207, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[42893287] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Nerrist|r", --Vendor Name
		info = jc .. " |cffFFFFFFDesign: Truesilver Crab|r |cffFFFFFF\n" .. ck .. " Recipe: Curiously Tasty Omelet|r |cffFFFFFF\n" .. ck .. " Recipe: Jungle Stew|r", --tooltip display
		coords = 42893287, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[42473223] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Uthok|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Spiced Chili Crab|r", --tooltip display
		coords = 42473223, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},








	[46171483] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Jaquilina Dramet|r", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Massive Iron Axe|r", --tooltip display
		coords = 46171483, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[60903861] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Gnaz Blunderflame & Knaz Blunderflame|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Mechanical Dragonling|r |cffFFFFFF\n" .. eng .. " Schematic: Deadly Scope|r", --tooltip display
		coords = 60903861, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},
	
	
	
	
	[38857949] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Blixrez Goodstitch|r", --Vendor Name
		info = lw .. " |cff1EFF0BPattern: Thick Murloc Armor|r |cff1EFF0B\n" .. lw .. " Pattern: Murloc Scale Bracers|r", --tooltip display
		coords = 38857949, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[39427767] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Zarena Cromwind|r", --Vendor Name
		info = bs.. " |cffFFFFFFPlans: Moonsteel Broadsword|r", --tooltip display
		coords = 39427767, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[39227716] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Narkk|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Black Swashbuckler's Shirt|r", --tooltip display
		coords = 39227716, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[38707736] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Kelsey Yance|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Giant Clam Scorcho|r |cffFFFFFF\n" .. ck .. " Recipe: Cooked Glossy Mightfish|r |cffFFFFFF\n" .. ck .. " Recipe: Filet of Redgill|r |cffFFFFFF\n" .. ck .. " Recipe: Hot Smoked Bass|r", --tooltip display
		coords = 38707736, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[39367872] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Xizk Goodstitch|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Enchanter's Cowl|r |cffFFFFFF\n" .. tl .. " Pattern: Crimson Silk Cloak|r", --tooltip display
		coords = 39367872, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[37698553] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Cowardly Crosby|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Admiral's Hat|r", --tooltip display
		coords = 37698553, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[38847835] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Rikqiz|r House on Main Floor", --Vendor Name
		info = lw .. " |cffFFFFFFPattern: Gem-Studded Leather Belt|r |cffFFFFFF\n" .. lw .. " Pattern: Shadowskin Gloves|r", --tooltip display
		coords = 38847835, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[39047971] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Crazk Sparks|r House on Main Floor Entrance on Back", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Green Firework|r", --tooltip display
		coords = 39047971, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[38257940] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Jutak|r Outside on Main Floor", --Vendor Name
		info = bs.. " |cffFFFFFFPlans: Hardened Iron Shortsword|r", --tooltip display
		coords = 38257940, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[38658022] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Glyx Brewright|r House on Top Floor", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Frost Protection Potion|r |cffFFFFFF\n" .. alc .. " Recipe: Nature Protection Potion|r", --tooltip display
		coords = 38658022, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[38597968] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Mrs. Gant|r Lowest Floor of the House", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Undermine Clam Chowder|r", --tooltip display
		coords = 38597968, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},	
	
}



points[51] = { -- "SwampOfSorrows"
	[47025202] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Gharash|r", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Mithril Scale Bracers|r", --tooltip display
		coords = 47025202, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[47025702] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Rartar|r", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Elixir of Demonslaying|r", --tooltip display
		coords = 47025702, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[46585688] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Banalash|r", --Vendor Name
		info = enc .. " |cff1EFF0BFormula: Enchant Bracer - Dodge|r |cffFFFFFF\n" .. jc .. " Design: Black Pearl Panther|r", --tooltip display
		coords = 46585688, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}


points[210] = { -- "TheCapeOfStranglethorn"
	[42837414] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Blixrez Goodstitch|r", --Vendor Name
		info = lw .. " |cff1EFF0BPattern: Thick Murloc Armor|r |cff1EFF0B\n" .. lw .. " Pattern: Murloc Scale Bracers|r", --tooltip display
		coords = 42837414, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[42987078] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Zarena Cromwind|r", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Moonsteel Broadsword|r", --tooltip display
		coords = 42987078, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[42646910] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Narkk|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Black Swashbuckler's Shirt|r", --tooltip display
		coords = 42646910, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[42806896] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Kelsey Yance|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Giant Clam Scorcho|r |cffFFFFFF\n" .. ck .. " Recipe: Cooked Glossy Mightfish|r |cffFFFFFF\n" .. ck .. " Recipe: Filet of Redgill|r |cffFFFFFF\n" .. ck .. " Recipe: Hot Smoked Bass|r", --tooltip display
		coords = 42806896, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[43577309] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Xizk Goodstitch|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Enchanter's Cowl|r |cffFFFFFF\n" .. tl .. " Pattern: Crimson Silk Cloak|r", --tooltip display
		coords = 43577309, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[40818213] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Cowardly Crosby|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Admiral's Hat|r", --tooltip display
		coords = 40818213, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[43217172] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Rikqiz|r House on Main Floor", --Vendor Name
		info = lw .. " |cffFFFFFFPattern: Gem-Studded Leather Belt|r |cffFFFFFF\n" .. lw .. " Pattern: Shadowskin Gloves|r", --tooltip display
		coords = 43217172, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[43017273] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Crazk Sparks|r House on Main Floor Entrance on Back", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Green Firework|r", --tooltip display
		coords = 43017273, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[41567414] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Jutak|r Outside on Main Floor", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Hardened Iron Shortsword|r", --tooltip display
		coords = 41567414, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[42667505] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Glyx Brewright|r House on Top Floor", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Frost Protection Potion|r |cffFFFFFF\n" .. alc .. " Recipe: Nature Protection Potion|r", --tooltip display
		coords = 42667505, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[42697271] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Mrs. Gant|r Lowest Floor of the House", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Undermine Clam Chowder|r", --tooltip display
		coords = 42697271, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},
		


}

points[18] = { -- "Tirisfal"
	[83026904] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Werg Thickblade|r - *Requires Time Traveling* " .. timetraveling, --Vendor Name
		info = lw .. " |cffFFFFFFPattern: Wicked Leather Gauntlets|r |cffFFFFFF\n" .. lw .. " Pattern: Stormshroud Pants|r", --tooltip display
		coords = 83026904, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[61145096] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Abigail Shiel|r - *Requires Time Traveling*", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Crispy Bat Wing|r |cffDF0101Horde only|r " .. horde, --tooltip display
		coords = 61145096, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[52595576] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Constance Brisboise|r - *Requires Time Traveling* " .. timetraveling, --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Blue Linen Vest|r", --tooltip display
		coords = 52595576, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

points[90] = { -- "Undercity"
	[64083802] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Daniel Barlett|r", --Vendor Name
		info = jc .. " |cffFFFFFFDesign: Amulet of the Moon|r", --tooltip display
		coords = 64083802, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[70082906] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Millie Gregorian|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Greater Adept's Robe|r |cffFFFFFF\n" .. tl .. " Pattern: Red Woolen Bag|r |cffFFFFFF\n" .. tl .. " Pattern: Tuxedo Shirt|r |cffFFFFFF\n" .. tl .. " Pattern: Tuxedo Pants|r |cffFFFFFF\n" .. tl .. " Pattern: Tuxedo Jacket|r", --tooltip display
		coords = 70082906, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[70065906] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Joseph Moore|r", --Vendor Name
		info = lw .. " |cffFFFFFFPattern: Barbaric Bracers|r |cff1EFF0B\n" .. lw .. " Pattern: Green Whelp Bracers|r", --tooltip display
		coords = 70065906, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[52067500] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Algernon|r", --Vendor Name
		info = alc .. " |cff1EFF0BRecipe: Elixir of Shadow Power|r", --tooltip display
		coords = 52067500, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[64084908] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Felicia Doan|r", --Vendor Name
		info = jc .. " |cffFFFFFFDesign: The Jade Eye|r", --tooltip display
		coords = 64084908, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

points[22] = { -- "WesternPlaguelands"
	[68077752] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Magnus Frostwake|r", --Vendor Name
		info = bs .. " |cff0A70D0Plans: Storm Gauntlets|r", --tooltip display
		coords = 68077752, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}


--------------
-- Kalimdor --
--------------


points[10] = { -- "Northern Barrens"
	[49005802] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Tari'qa|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Strider Stew|r |cffDF0101Horde only|r|cffFFFFFF" ..  horde .. "\n" .. ck .. " Recipe: Crispy Lizard Tail|r |cffDF0101Horde only|r " .. horde, --tooltip display
		coords = 49005802, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[50006100] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Wrahk|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Blue Linen Vest|r |cffFFFFFF\n" .. tl .. " Pattern: Blue Linen Robe|r |cffFFFFFF\n" .. tl .. " Pattern: Red Woolen Bag|r", --tooltip display
		coords = 50006100, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[50675779] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Zargh|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Hot Lion Chops|r |cffDF0101Horde only|r " .. horde, --tooltip display
		coords = 50675779, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[48515843] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Hula'mahi|r", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Holy Protection Potion|r", --tooltip display
		coords = 48515843, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[68346912] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Gagsprocket|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Green Firework|r |cffFFFFFF\n" .. eng .. " Schematic: Minor Recombobulator|r", --tooltip display
		coords = 68346912, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[67087341] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Ranik|r", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Rage Potion|r |cffFFFFFF\n" .. jc .. " Design: Wicked Moonstone Ring|r |cffFFFFFF\n" .. tl .. " Pattern: Blue Linen Robe|r |cffFFFFFF\n" .. tl .. " Pattern: Greater Adept's Robe|r", --tooltip display
		coords = 67087341, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},		
		
	[66727268] = {
		npcid = 3658, --NPC ID
		name = "|cffEEC410Lizzarik !WANDERING!|r", --Vendor Name
		info = res .. " |cff1eff00Heavy Spiked Mace|r |cff1eff00\n" .. res .. " Ironwood Maul|r |cff1eff00\n" .. res .. " Enamelled Broadsword|r |cff1eff00\n" .. res .. " Feral Blade|r ", --tooltip display
		coords = 66727268, --Cordinates to vendor
		items = {4778,4777,4765,4766}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},
		
		
		
		
		

}


points[63] = { -- "Ashenvale"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}

points[76] = { -- "Aszhara"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}


points[66] = { -- "Desolace"
	[55845653] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Muuran|r", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Solid Iron Maul|r", --tooltip display
		coords = 55845653, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[50975356] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Kireena|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Azure Silk Gloves|r |cffFFFFFF\n" .. ck .. " Recipe: Heavy Kodo Stew|r", --tooltip display
		coords = 50975356, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},	
}

points[1] = { -- "Durotar"
	[57417701] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Zansoa|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Slitherskin Mackerel|r", --tooltip display
		coords = 57417701, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[50744283] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Grimtak|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Scorpid Surprise|r |cffDF0101Horde only|r " .. horde, --tooltip display
		coords = 50744283, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

points[70] = { -- "Dustwallow"
	[36713098] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Ogg'marr|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Heavy Crocolisk Stew|r |cffDF0101Horde only|r " .. horde .. " |cffFFFFFF\n" .. ck .. " Recipe: Carrion Surprise|r |cffDF0101Horde only|r " .. horde .. " |cffFFFFFF\n" .. ck .. " Recipe: Roast Raptor|r |cffFFFFFF\n" .. ck .. " Recipe: Dragonbreath Chili|r", --tooltip display
		coords = 36713098, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[35153084] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Ghok'kah|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Icy Cloak|r |cffDF0101Horde only|r " .. horde, --tooltip display
		coords = 35153084, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},
}

points[77] = { -- "Felwood"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}

points[69] = { -- "Feralas"
	[52834711] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Jangdor Swiftstrider|r", --Vendor Name
		info = lw .. " |cff1EFF0BPattern: Green Whelp Bracers|r |cff1EFF0B\n" .. lw .. " Pattern: Nightscape Shoulders|r |cffFFFFFF\n" .. lw .. " Pattern: Living Shoulders|r |cffFFFFFF\n" .. lw .. " Pattern: Turtle Scale Gloves|r", --tooltip display
		coords = 52834711, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[74494273] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Sheendra Tallgrass|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Hot Wolf Ribs|r |cffFFFFFF\n" .. ck .. " Recipe: Baked Salmon|r |cffFFFFFF\n" .. ck .. " Recipe: Lobster Stew|r |cffFFFFFF\n" .. ck .. " Recipe: Mightfish Steak|r", --tooltip display
		coords = 74494273, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[76064329] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Bronk|r", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Nature Protection Potion|r |cffFFFFFF\n" .. alc .. " Recipe: Ghost Dye|r", --tooltip display
		coords = 76064329, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},
}


points[80] = { -- "Moonglade"
		[48064002] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Lorelae Wintersong|r", --Vendor Name
		info = enc .. " |cffFFFFFFFormula: Enchant Cloak - Superior Defense|r |cffFFFFFF\n" .. tl .. " Pattern: Felcloth Pants|r", --tooltip display
		coords = 48064002, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

}


points[7] = { -- "Mulgore"

	
	[46395777] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Wunna Darkmane|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Roasted Kodo Meat|r |cffDF0101Horde only|r " .. horde, --tooltip display
		coords = 46395777, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},
}





points[85] = { -- "Orgrimmar"
	[66064106] = {
		npcid = 3333, --NPC ID
		name = "|cffEEC410Shankys|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Rainbow Fin Albacore|r |cffFFFFFF\n" .. ck .. " Recipe: Rockscale Cod|r |cffFFFFFF\n" .. ck .. " Recipe: Mithril Head Trout|r", --tooltip display
		coords = 66064106, --Cordinates to vendor
		items = {6368, 6369, 17062}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {400, 2200, 2200}, --Cost of each item?
		},

	[47005506] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Hagrus|r", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Rage Potion|r |cffFFFFFF\n" .. alc .. " Recipe: Great Rage Potion|r", --tooltip display
		coords = 47005506, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[53024808] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Kithas|r", --Vendor Name
		info = alc .. " |cffFFFFFFFormula: Minor Wizard Oil|r |cff1EFF0B\n" .. enc .. " Formula: Enchant Chest - Lesser Mana|r |cffDF0101Horde only|r" .. horde .. "|cffFFFFFF\n" .. enc .. " Formula: Enchant 2H Weapon - Lesser Intellect|r |cffFFFFFF\n" .. enc .. " Formula: Minor Mana Oil|r |cffFFFFFF\n" .. enc .. "Formula: Lesser Wizard Oil|r |cffFFFFFF\n" .. tl .. " Pattern: Enchanted Mageweave Pouch|r", --tooltip display
		coords = 53024808, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[55064604] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Kor'geld|r", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Free Action Potion|r |cffFFFFFF\n" .. alc .. " Recipe: Elixir of Superior Defense|r", --tooltip display
		coords = 55064604, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[75083502] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Sumi|r", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Hardened Iron Shortsword|r", --tooltip display
		coords = 75083502, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[60065806] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Borya|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Blue Linen Vest|r |cffFFFFFF\n" .. tl .. " Pattern: Blue Overalls|r |cffFFFFFF\n" .. tl .. " Pattern: Red Woolen Bag|r |cffFFFFFF\n" .. tl .. " Pattern: Lavender Mageweave Shirt|r |cffFFFFFF\n" .. tl .. " Pattern: Pink Mageweave Shirt|r", --tooltip display
		coords = 60065806, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[60065404] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Tamar|r", --Vendor Name
		info = lw .. " |cffFFFFFFPattern: Heavy Leather Ball|r", --tooltip display
		coords = 60065404, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[48044708] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Felika !WANDERING!|r", --Vendor Name
		info = jc .. " |cffFFFFFFDesign: Heavy Golden Necklace of Battle|r", --tooltip display
		coords = 48044708, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[56005600] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Sovik|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Red Firework|r", --tooltip display
		coords = 56005600, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


	--NPCS below removed with addition of Horde Embassy
	--[36068608] = {
	--	npcid = 0000, --NPC ID
	--	name = "|cffEEC410Vizna Bangwrench|r", --Vendor Name
	--	info = "|cffFFFFFFSchematic: Red Firework|r", --tooltip display
	--	coords = 36068608, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},

	--[36028302] = {
	--	npcid = 0000, --NPC ID
	--	name = "|cffEEC410Zido Helmbreaker|r", --Vendor Name
	--	info = "|cffFFFFFFPlans: Hardened Iron Shortsword|r", --tooltip display
	--	coords = 36028302, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},

	--[39008506] = {
	--	npcid = 0000, --NPC ID
	--	name = "|cffEEC410Karizi Prokpatty|r", --Vendor Name
	--	info = "|cffFFFFFFRecipe: Smoked Sagefish|r |cffFFFFFF\nRecipe: Sagefish Delight|r", --tooltip display
	--	coords = 39008506, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},

	--[41007908] = {
	--	npcid = 0000, --NPC ID
	--	name = "|cffEEC410Lizna Goldweaver|r", --Vendor Name
	--	info = "|cffFFFFFFPattern: Blue Linen Vest|r |cffFFFFFF\nPattern: Blue Overalls|r |cffFFFFFF\nPattern: Red Woolen Bag|r |cffFFFFFF\nPattern: Lavender Mageweave Shirt|r |cffFFFFFF\nPattern: Pink Mageweave Shirt|r", --tooltip display
	--	coords = 41007908, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
	
	
	--NPC's below added with Horde Embassy
	[36748436] = {
		npcid = 133127, --NPC ID
		name = "|cffEEC410Thaluriel|r", --Vendor Name
		info = eng .." |cffFFFFFFSchematic: Steam Tonk Controller|r |cffFFFFFF\n" .. eng .. " Schematic: Red Firework|r", --tooltip display
		coords = 36748436, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},
	

	[45007706] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Punra|r", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Hardened Iron Shortsword|r", --tooltip display
		coords = 45007706, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},
	
}








points[81] = { -- "Silithus"
	[55513672] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Calandrath|r", --Vendor Name
		info = alc .. " |cff1EFF0BRecipe: Greater Nature Protection Potion|r", --tooltip display
		coords = 55513672, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[81381837] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Zannok Hidepiercer|r *Requires Time Traveling*", --Vendor Name
		info = lw .. " |cffFFFFFFPattern: Heavy Scorpid Bracers|r |cffFFFFFF\n" .. lw .. " Pattern: Heavy Scorpid Helm|r", --tooltip display
		coords = 81381837, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[53803435] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Mishta|r", --Vendor Name
		info = jc .. " |cffFFFFFFDesign: Emerald Crown of Destruction|r", --tooltip display
		coords = 53803435, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[55603723] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Kania|r", --Vendor Name
		info = enc .. " |cffFFFFFFFormula: Lesser Mana Oil|r |cffFFFFFF\n" ..  enc .. " Formula: Wizard Oil|r |cffFFFFFF\n" .. tl .. " Pattern: Enchanted Runecloth Bag|r", --tooltip display
		coords = 55603723, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

points[199] = { -- "SouthernBarrens"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}

points[65] = { -- "StonetalonMountains"
	[50536338] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Jeeda|r", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Fire Protection Potion|r |cffDF0101Horde only|r " .. horde, --tooltip display
		coords = 50536338, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[48696152] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Kulwia|r", --Vendor Name
		info = enc .. " |cff1EFF0BFormula: Enchant Bracer - Lesser Strength|r |cff1EFF0B\n" .. enc .. " Formula: Enchant Cloak - Minor Agility|r", --tooltip display
		coords = 48696152, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

points[71] = { -- "Tanaris"
	[50672863] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Haughty Modiste|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Haliscan Pantaloons|r |cffFFFFFF\n" .. tl  .. " Pattern: Dress Shoes|r |cffFFFFFF\n" .. tl .. " Pattern: Haliscan Jacket|r", --tooltip display
		coords = 50672863, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},		
		
	[50732873] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Vizzklick|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Crimson Silk Robe|r |cffFFFFFF\n" .. tl .. " Pattern: Soul Pouch|r", --tooltip display
		coords = 50732873, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},
		
	[50712852] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Blizrik Buckshot|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: EZ-Thro Dynamite II|r", --tooltip display
		coords = 50712852, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},	
		

	[52562905] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Dirge Quikcleave|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Tender Wolf Steak|r", --tooltip display
		coords = 52562905, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[51153039] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Krinkle Goodsteel|r", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Golden Scale Coif|r", --tooltip display
		coords = 51153039, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[50852797] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Alchemist Pestlezugg|r", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Nature Protection Potion|r |cffFFFFFF\n" .. alc .. " Recipe: Philosopher's Stone|r |cffFFFFFF\n"  .. alc .. " Recipe: Transmute Iron to Gold|r |cffFFFFFF\n" .. alc .. " Recipe: Transmute Mithril to Truesilver|r |cffFFFFFF\n" .. alc .. " Recipe: Transmute Arcanite|r", --tooltip display
		coords = 50852797, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

}


points[88] = { -- "ThunderBluff"
	[43804507] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Mahu|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Red Woolen Bag|r |cffFFFFFF\n" .. tl .. " Pattern: Orange Martial Shirt|r |cffFFFFFF\n" .. tl .. " Pattern: White Wedding Dress|r |cffFFFFFF\n" .. tl .. " Pattern: Red Linen Bag|r", --tooltip display
		coords = 43804507, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[45003806] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Nata Dawnstrider|r", --Vendor Name
		info = enc .. " |cffFFFFFFFormula: Enchant 2H Weapon - Lesser Intellect|r |cff1EFF0B\n" .. enc .. " Formula: Enchant Boots - Minor Agility|r", --tooltip display
		coords = 45003806, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[51065208] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Naal Mistrunner|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Longjaw Mud Snapper|r", --tooltip display
		coords = 51065208, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[56004700] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Sewa Mistrunner|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Brilliant Smallfish|r |cffFFFFFF\n" .. ck .. " Recipe: Bristle Whisker Catfish|r", --tooltip display
		coords = 56004700, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[36085904] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Palehoof's Big Bag of Parts|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Red Firework|r", --tooltip display
		coords = 36085904, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[40066206] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Shadi Mistrunner|r", --Vendor Name
		info = jc .. " |cffFFFFFFDesign: Opal Necklace of Impact|r", --tooltip display
		coords = 40066206, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

points[78] = { -- "UngoroCrater"
	[54756247] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Nergal|r", --Vendor Name
		info = lw .. " |cff0A70D0Pattern: Devilsaur Leggings|r |cffFFFFFF\n" .. lw .. " Pattern: Devilsaur Gauntlets|r", --tooltip display
		coords = 54756247, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[43444157] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Dramm Riverhorn|r", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Runic Plate Boots|r |cffFFFFFF\n" .. bs .. " Plans: Runic Plate Helm|r |cffFFFFFF\n" .. bs .. " Plans: Runic Plate Shoulders|r |cffFFFFFF\n" .. bs .. " Plans: Runic Plate Leggings|r", --tooltip display
		coords = 43444157, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

points[83] = { -- "Winterspring"
	[59225092] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Xizzer Fizzbolt|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Delicate Arcanite Converter|r |cffFFFFFF\n" .. eng .. " Schematic: Masterwork Target Dummy|r |cffFFFFFF\n" .. eng .. " Schematic: Powerful Seaforium Charge|r |cffFFFFFF\n" .. eng ..  " Schematic: Gyrofreeze Ice Reflector|r", --tooltip display
		coords = 59225092, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[59825156] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Himmik|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Monster Omelet|r", --tooltip display
		coords = 59825156, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[59684931] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Qia|r", --Vendor Name
		info = enc .. " |cffFFFFFFFormula: Enchant Chest - Major Health|r |cffFFFFFF\n" .. jc .. " Design: Necklace of the Diamond Tower|r |cffFFFFFF\n" .. lw .. " Pattern: Frostsaber Boots|r |cffFFFFFF\n" .. tl .. " Pattern: Mooncloth|r |cffFFFFFF\n" .. tl .. " Pattern: Runecloth Bag|r", --tooltip display
		coords = 59684931, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[58096368] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Daleohm|r", --Vendor Name
		info = bs .. " |cff0A70D0Plans:Frostguard|r", --tooltip display
		coords = 58096368, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}


-------------
-- Outland --
-------------
points[105] = { -- "BladesEdgeMountains"
	[51005708] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Daga Ramba|r", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Super Mana Potion|r |cffFFFFFF\n" .. alc .. " Recipe: Elixir of Major Defense|r |cffFFFFFF\n" .. alc .. " Recipe: Major Dreamless Sleep Potion|r", --tooltip display
		coords = 51005708, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},
}

points[100] = { -- "Hellfire"
	[53023802] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Rohok|r", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Lesser Ward of Shielding|r", --tooltip display
		coords = 53023802, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[54064100] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Cookie One-Eye|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Ravager Dog|r", --tooltip display
		coords = 54064100, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[52023604] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Apothecary Antonivich|r", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Elixir of Camouflage|r", --tooltip display
		coords = 52023604, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[61008104] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Mixie Farshot|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Cogspinner Goggles|r |cffFFFFFF\n" .. eng .. " Schematic: Adamantite Scope|r", --tooltip display
		coords = 61008104, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[52043600] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Kul Inkspiller|r", --Vendor Name
		info = ins .. " |cffFFFFFFTechnique Glyph of Counterspell|r", --tooltip display
		coords = 52043600, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

points[107] = { -- "Nagrand"
	[55023700] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Mathar G'ochar !WANDERING!|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Bolt of Soulcloth|r |cffFFFFFF\n" .. tl .. " Pattern: Soulcloth Gloves|r", --tooltip display
		coords = 55023700, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[58003506] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Nula the Butcher|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Grilled Mudfish|r |cffFFFFFF\n" .. ck .. " Recipe: Poached Bluefish|r |cffFFFFFF\n" .. ck .. " Recipe: Roasted Clefthoof|r |cffFFFFFF\n" .. ck .. " Recipe: Talbuk Steak|r", --tooltip display
		coords = 58003506, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

points[109] = { -- "Netherstorm"
	[44003606] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Dealer Jadyan|r", --Vendor Name
		info = enc .. " |cff0A70D0Formula: Enchant Weapon - Executioner|r", --tooltip display
		coords = 44003606, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

}

points[104] = { -- "ShadowmoonValley"
	[29023100] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Krek Cragcrush|r", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Adamantite Plate Bracers|r |cffFFFFFF\n" .. bs .. " Plans: Adamantite Plate Gloves|r |cffFFFFFF\n" .. bs .. " Plans: Adamantite Breastplate|r", --tooltip display
		coords = 29023100, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[55085802] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Arrond !SCRYERS ONLY!|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Imbued Netherweave Robe|r |cffFFFFFF\n" .. tl .. " Pattern: Imbued Netherweave Tunic|r", --tooltip display
		coords = 55085802, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

points[111] = { -- "ShattrathCity"
	[72063106] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Wind Trader Lathrai|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: White Smoke Flare|r |cffFFFFFF\n" .. eng .. " Schematic: Fel Iron Toolbox|r", --tooltip display
		coords = 72063106, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[45082008] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Skerah|r", --Vendor Name
		info = alc .. " |cff1EFF0BRecipe: Transmute Primal Might|r", --tooltip display
		coords = 45082008, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[66026808] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Eiin|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Bolt of Imbued Netherweave|r |cffFFFFFF\n" .. tl .. " Pattern: Imbued Netherweave Bag|r |cffFFFFFF\n" .. tl .. " Pattern: Netherweave Robe|r |cffFFFFFF\n" .. tl .. " Pattern: Netherweave Tunic|r", --tooltip display
		coords = 66026808, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[64086906] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Viggz Shinesparked|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Adamantite Rifle|r", --tooltip display
		coords = 64086906, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[64007108] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Aaron Hollman|r", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Adamantite Maul|r |cffFFFFFF\n" .. bs .. " Plans: Adamantite Cleaver|r |cffFFFFFF\n" .. " Plans: Adamantite Dagger|r |cffFFFFFF\n" .. bs .. " Plans: Adamantite Rapier|r", --tooltip display
		coords = 64007108, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[63067000] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Madame Ruby|r", --Vendor Name
		info = enc .. " |cffFFFFFFFormula: Superior Mana Oil|r |cffFFFFFF\n" .. enc .. " Formula: Enchant Shield - Major Stamina|r |cffFFFFFF\n" .. enc .. " Formula: Large Prismatic Shard|r |cffFFFFFF\n" ..  enc .. " Formula: Superior Wizard Oil|r", --tooltip display
		coords = 63067000, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[66066804] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Nasmara Moonsong|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Primal Mooncloth|r", --tooltip display
		coords = 66066804, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[66066802] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Andrion Darkspinner|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Shadowcloth|r", --tooltip display
		coords = 66066802, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[66066806] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Gidge Spellweaver|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Spellcloth|r", --tooltip display
		coords = 66066806, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

points[108] = { -- "TerokkarForest"
	
	[27281702] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Skerah|r", --Vendor Name
		info = alc .. " |cff1EFF0BRecipe: Transmute Primal Might|r", --tooltip display
		coords = 27281702, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},		
	
	
	[33881979] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Wind Trader Lathrai|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: White Smoke Flare|r |cffFFFFFF\n" .. eng .. " Schematic: Fel Iron Toolbox|r", --tooltip display
		coords = 33881979, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},
	
	
	
	
	[48084500] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Innkeeper Grilka|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Blackened Basilisk|r |cffFFFFFF\n" .. ck .. " Recipe: Warp Burger|r", --tooltip display
		coords = 48084500, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[48084600] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Rungor|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Golden Fish Sticks|r |cffFFFFFF\n" .. ck .. " Recipe: Spicy Crawdad|r", --tooltip display
		coords = 48084600, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

points[102] = { -- "Zangarmarsh"
	[85025406] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Zurai|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Imbued Netherweave Pants|r |cffFFFFFF\n" .. tl .. " Pattern: Imbued Netherweave Boots|r |cffFFFFFF\n" .. ck .. " Recipe: Feltail Delight|r", --tooltip display
		coords = 85025406, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[31064902] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Gambarinka|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Blackened Trout|r", --tooltip display
		coords = 31064902, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[32045108] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Seer Janidi|r", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Sneaking Potion|r |cffFFFFFF\n" .. alc .. " Recipe: Elixir of Major Frost Power|r", --tooltip display
		coords = 32045108, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[17085102] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Mycah !COST 1 SHROOM!|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Clam Bar|r", --tooltip display
		coords = 17085102, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[78006600] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Juno Dufrain|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Blackened Sporefish|r", --tooltip display
		coords = 78006600, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[32044800] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Captured Gnome|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Ultra-Spectropic Detection Goggles|r |cffFFFFFF\n" .. eng .. " Schematic: White Smoke Flare|r", --tooltip display
		coords = 32044800, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}


---------------
-- Northrend --
---------------
points[114] = { -- "BoreanTundra"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}

points[127] = { -- "CrystalsongForest"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}

points[125] = { -- "Dalaran"
	[39002600] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Bryan Landers|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Titanium Toolbox|r", --tooltip display
		coords = 39002600, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[42043706] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Larana Drome|r", --Vendor Name
		info = ins .. " |cffFFFFFFTechnique Glyph of Everlasting Affliction|r |cffFFFFFF\n" .. ins .. " Technique Glyph of Counterspell|r", --tooltip display
		coords = 42043706, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},
		
	[65643807] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Kaye Toogie|r", --Vendor Name
		info = eng.. " |cff1eff00Schematic: Arcanite Dragonling|r |cffFFFFFF\n" .. eng .. " Schematic: Mithril Mechanical Dragonling|r |cffFFFFFF\n" .. eng .. " Schematic: Mechanical Dragonling|r", --tooltip display
		coords = 65643807, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

}





points[126] = { -- "DalaranUnderbelly"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}

points[115] = { -- "Dragonblight"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}

points[116] = { -- "GrizzlyHills"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}

points[117] = { -- "HowlingFjord"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}

points[118] = { -- "Icecrown"
	[72212090] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Fizzix Blastbolt !ONLY IF DALA SOLD OUT!|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Titanium Toolbox|r", --tooltip display
		coords = 72212090, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}



points[119] = { -- "SholazarBasin"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}

points[120] = { -- "TheStormPeaks"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}

points[121] = { -- "ZulDrak"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}


---------------
-- Cataclysm --
---------------
points[207] = { -- "Deepholm"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}

points[198] = { -- "Hyjal"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}

points[241] = { -- "TwilightHighlands"
	[876064904] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Una Kobuna|r", --Vendor Name
		info = ins .. " |cffFFFFFFTechnique Glyph of Colossus Smash|r", --tooltip display
		coords = 876064904, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

points[249] = { -- "Uldum"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}

points[204] = { -- "VashjirDepths"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}

points[201] = { -- "VashjirKelpForest"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}

points[205] = { -- "VashjirRuins"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}


--------------
-- Pandaria --
--------------
points[422] = { -- "DreadWastes"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}

points[418] = { -- "Krasarang"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}

points[379] = { -- "KunLaiSummit"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}

points[391] = { -- "ShrineofTwoMoons"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}

points[392] = { -- "ShrineofTwoMoons"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}

points[433] = { -- "TheHiddenPass"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}

points[371] = { -- "TheJadeForest"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}

points[388] = { -- "TownlongWastes"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}

points[390] = { -- "ValeofEternalBlossoms"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}

points[376] = { -- "ValleyoftheFourWinds"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}


points[563] = { -- "Siege of Orgrimmar - Korkron Barracks"
	[48702812] = {
		npcid = 73715, --NPC ID
		name = "Rivett Clutchpop", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Adamantite Rifle|r |cffFFFFFF\n" .. eng .. " Schematic: Ultra-Spectropic Detection Goggles|r |cffFFFFFF\n" .. eng .. " Schematic: Cogspinner Goggles|r |cffFFFFFF\n" .. eng .. " Schematic: Adamantite Scope|r |cffFFFFFF\n" .. eng .. " Schematic: Fel Iron Toolbox|r", --tooltip display
		coords = 48702812, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},
}




-------------
-- Draenor --
-------------
points[590] = { -- "garrisonffhorde_tier3"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}

points[525] = { -- "FrostfireRidge"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}


------------------
-- Broken Isles --
------------------
points[627] = { -- "Dalaran70"
	--[00000000] = {
	--	npcid = 0000, --NPC ID
	--	name = "Place Holder", --Vendor Name
	--	info = "Place Holder", --tooltip display
	--	coords = 00000000, --Cordinates to vendor
	--	items = {00000}, --Items the vendor sells
	--	icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
	--	cost = {999999999}, --Cost of each item?
	--	},
}
