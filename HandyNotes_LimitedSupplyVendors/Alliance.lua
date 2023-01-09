
if UnitFactionGroup("player") ~= "Alliance" then return end



--ToDo:  Fix Item Link Displays

local _, LimitedSupplyVendors = ...
local points = LimitedSupplyVendors.points
-- points[<mapfile>] = { [<coordinates>] = <quest ID> }

--inv_scroll_03 - basic
--inv_scroll_04 - gold
--inv_scroll_05 - blue
--inv_scroll_06 - green


local bs  = "|TInterface/Icons/ui_profession_blacksmithing:16:16|t";
local tl  = "|TInterface/Icons/ui_profession_tailoring:16:16|t";
local lw  = "|TInterface/Icons/ui_profession_leatherworking:16:16|t";
local eng = "|TInterface/Icons/ui_profession_engineering:16:16|t";
local enc = "|TInterface/Icons/ui_profession_enchanting:16:16|t";
local alc = "|TInterface/Icons/ui_profession_alchemy:16:16|t";
local jc  = "|TInterface/Icons/ui_profession_jewelcrafting:16:16|t";
local ins = "|TInterface/Icons/ui_profession_inscription:16:16|t";
local ck  = "|TInterface/Icons/ui_profession_cooking:16:16|t";
local res = "|TInterface/Icons/ui_inv_garrison_resource:16:16|t";

local quest = "|TInterface/Icons/inv_misc_questionmark:16:16|t";

local horde    = "|TInterface/Icons/inv_bannerpvp_01:16:16|t";
local alliance = "|TInterface/Icons/inv_bannerpvp_02:16:16|t";

local timetraveling = "|TInterface/Icons/inv_relics_hourglass:16:16|t";

local Grey    = "|cff9d9d9d";
local Red     = "|cffff4e4e"; 
local Blue    = "|cff0070dd"; 
local Green   = "|cff1eff00"; 
local White   = "|cffffffff"; 
local Orange  = "|cffff8000"; 
local Purple  = "|cffa335ee"; 
local Teal    = "|cff00ccff"; 
local Tan     = "|cffe5cc80"; 
local Gold    = "|cffEEC410";



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
	[40084800] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Jannos Ironwill|r", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Solid Iron Maul|r", --tooltip display
		coords = 40084800, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[40044808] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Hammon Karwn|r", --Vendor Name
		info = jc .. "|cffFFFFFFDesign: Ruby Crown of Restoration|r |cffFFFFFF\n" .. lw .. " Pattern: Barbaric Leggings|r", --tooltip display
		coords = 40044808, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[40064802] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Drovnar Strongbrew|r", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Frost Protection Potion|r", --tooltip display
		coords = 40064802, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[39064808] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Narj Deepslice|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Barbecued Buzzard Wing|r |cff0080FFAlly only|r " .. alliance, --tooltip display
		coords = 39064808, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[39024802] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Androd Fadran|r", --Vendor Name
		info = lw .. " |cff1EFF0BPattern: Raptor Hide Belt|r |cff0080FFAlly only|r " .. alliance, --tooltip display
		coords = 39024802, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},
}

points[15] = { -- "Badlands"
	[65003808] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410'Chef' Overheat|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Undermine Clam Chowder|r", --tooltip display
		coords = 65003808, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[91003804] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Buckslappy|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: EZ-Thro Dynamite II|r |cffFFFFFF\n" .. eng .. " Schematic: Blue Firework|r |cffFFFFFF\n" .. eng .. " Schematic: Green Firework|r |cffFFFFFF\n" .. eng .. "Schematic: Red Firework|r", --tooltip display
		coords = 91003804, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

points[17] = { -- "BlastedLands"
	[62041600] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Nina Lightbrew|r", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Elixir of Demonslaying|r", --tooltip display
		coords = 62041600, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

points[27] = { -- "DunMorogh"
	[17087406] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410High Admiral 'Shelly' Jorrik|r", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Solid Iron Maul|r", --tooltip display
		coords = 17087406, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

}

points[47] = { -- "Duskwood"
	[81081908] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Kzixx|r", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Holy Protection Potion|r |cffFFFFFF\n" .. eng .. " Schematic: Goblin Jumper Cables|r", --tooltip display
		coords = 81081908, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[75084504] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Danielle Zipstitch & Sheri Zipstich|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Bright Yellow Shirt|r |cff0080FFAlly only|r " .. alliance.. "|cffFFFFFF\n" .. tl .. " Pattern: Greater Adept's Robe|r |cffFFFFFF\n" .. tl .. " Pattern: Dark Silk Shirt|r", --tooltip display
		coords = 75084504, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

}

points[23] = { -- "EasternPlaguelands"
	[74025100] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Jase Farlane|r", --Vendor Name
		info = jc .. " |cffFFFFFFDesign: Ring of Bitter Shadows|r", --tooltip display
		coords = 74025100, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

}

points[37] = { -- "Elwynn"
	[42006700] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Tharynn Bouden|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Blue Linen Vest|r", --tooltip display
		coords = 42006700, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[83026606] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Drake Lindgren|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Blue Linen Robe|r", --tooltip display
		coords = 83026606, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

points[25] = { -- "HillsbradFoothills"
	[71024502] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Zan Shivsproket|r All the way up", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Gnomish Cloaking Device", --tooltip display
		coords = 71024502, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[44002108] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Bro'kin|r", --Vendor Name
		info = enc .. " |cff1EFF0BRecipe: Frost Oil|r", --tooltip display
		coords = 44002108, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[56004604] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Zixil !WANDERING!|r", --Vendor Name
		info = enc .. " |cff1EFF0BFormula: Enchant Boots - Minor Agility|r |cffFFFFFF\n" .. lw .. " Pattern: Earthen Leather Shoulders|r |cffFFFFFF\n" .. tl .. " Pattern: Red Woolen Bag|r |cffFFFFFF\n" .. eng .. " Schematic: Goblin Jumper Cables|r", --tooltip display
		coords = 56004604, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}


points[26] = { -- "Hinterlands"
	[34063804] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Gigget Zipcoil|r", --Vendor Name
		info = lw .. " |cffFFFFFFPattern: Ironfeather Shoulders|r", --tooltip display
		coords = 34063804, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[34023708] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Ruppo Zipcoil|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Mithril Mechanical Dragonling|r", --tooltip display
		coords = 34023708, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[13064408] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Harggan|r", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Mithril Scale Bracers|r", --tooltip display
		coords = 13064408, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[13044302] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Nioma|r", --Vendor Name
		info = lw .. " |cff1EFF0BPattern: Nightscape Shoulders|r", --tooltip display
		coords = 13044302, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

points[87] = { -- "Ironforge"
	[40023304] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Bombus Finespindle|r", --Vendor Name
		info = lw .. " |cffFFFFFFPattern: Heavy Leather Ball|r |cffFFFFFF\n" .. enc .. " Formula: Enchant 2H Weapon - Lesser Intellect|r", --tooltip display
		coords = 40023304, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[47060706] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Transy Puddlefizz|r", --Vendor Name
		info = ck .. "|cffFFFFFFRecipe: Slitherskin Mackerel|r |cffFFFFFF\n" .. ck .. " Recipe: Longjaw Mud Snapper|r |cffFFFFFF\n" .. ck .. " Recipe: Rockscale Cod|r |cffFFFFFF\n" .. ck .. " Recipe: Mithril Head Trout|r", --tooltip display
		coords = 47060706, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[46062806] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Burbik Gearspanner|r", --Vendor Name
		info = jc .. " |cffFFFFFFDesign: Opal Necklace of Impact|r |cffFFFFFF\n" .. jc .. " Design: The Jade Eye|r", --tooltip display
		coords = 46062806, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[68024400] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Gearcutter Cogspinner|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Blue Firework|r |cffFFFFFF\n" .. eng .. " Schematic: Gnomish Universal Remote|r |cff0080FFAlly only|r " .. alliance, --tooltip display
		coords = 68024400, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[66065406] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Soolie Berryfizz|r", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Free Action Potion|r |cffFFFFFF\n" .. alc .. " Recipe: Elixir of Superior Defense|r", --tooltip display
		coords = 66065406, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[44022906] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Outfitter Eric|r Upstairs and Good-looking!", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Lavender Mageweave Shirt|r |cffFFFFFF\n" .. tl .. " Pattern: Pink Mageweave Shirt|r |cffFFFFFF\n" .. tl .. " Pattern: Tuxedo Shirt|r |cffFFFFFF\n" .. tl .. " Pattern: Tuxedo Pants|r |cffFFFFFF\n" .. tl .. " Pattern: Tuxedo Jacket|r", --tooltip display
		coords = 44022906, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

points[48] = { -- "LochModan"
	[35064900] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Drac Roughcut|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Smoked Bear Meat|r", --tooltip display
		coords = 35064900, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[36004600] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Rann Flamespinner|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Greater Adept's Robe|r |cffFFFFFF\n" .. tl .. " Pattern: Red Woolen Bag|r", --tooltip display
		coords = 36004600, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[40043904] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Khara Deepwater|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Loch Frenzy Delight|r |cff0080FFAlly only|r " .. alliance, --tooltip display
		coords = 40043904, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[82066302] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Xandar Goodbeard|r", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Rage Potion|r |cffFFFFFF\n" .. alc .. " Recipe: Holy Protection Potion|r", --tooltip display
		coords = 82066302, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

points[49] = { -- "Redridge Mountains"
	[78066306] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Clyde Ranthal|r", --Vendor Name
		info = lw .. " |cffFFFFFFPattern: Black Whelp Cloak|r |cff0080FFAlly only|r " .. alliance, --tooltip display
		coords = 78066306, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[28024304] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Amy Davenport|r", --Vendor Name
		info = lw .. " |cffFFFFFFPattern: Black Whelp Tunic|r |cff0080FFAlly only|r " .. alliance .. " |cffFFFFFF\n" .. tl .. " Pattern: Red Woolen Bag|r", --tooltip display
		coords = 28024304, --Cordinates to vendor
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

points[84] = { -- "StormwindCity"
	[64067106] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Edna Mullby|r", --Vendor Name
		info = jc .. " |cffFFFFFFDesign: Heavy Golden Necklace of Battle|r", --tooltip display
		coords = 64067106, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[42067608] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Darian Singh|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Blue Firework|r", --tooltip display
		coords = 42067608, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[55068506] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Maria Lumere|r", --Vendor Name
		info = alc .. " |cff1EFF0BRecipe: Elixir of Shadow Power|r", --tooltip display
		coords = 55068506, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[53007402] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Jessara Cordell|r", --Vendor Name
		info = enc .. " |cffFFFFFFFormula: Minor Wizard Oil|r |cffFFFFFF\n" .. enc .. " Formula: Minor Mana Oil|r |cffFFFFFF\n" .. enc .. " Formula: Lesser Wizard Oil|r |cffFFFFFF\n" .. tl .. " Pattern: Enchanted Mageweave Pouch|r", --tooltip display
		coords = 53007402, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[53028106] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Alexandra Bolero|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Blue Overalls|r |cffFFFFFF\n" .. tl .. " Pattern: White Wedding Dress|r", --tooltip display
		coords = 53028106, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[76065306] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Kendor Kabonka|r Upstairs", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Goretusk Liver Pie|r |cff0080FFAlly only|r " .. alliance.. " |cffFFFFFF\n" .. ck .. " Recipe: Crocolisk Steak|r |cff0080FFAlly only|r " .. alliance .. "  |cffFFFFFF\n" .. ck .. " Recipe: Murloc Fin Soup|r |cff0080FFAlly only|r " .. alliance .. " |cffFFFFFF\n" .. ck .. " Recipe: Redridge Goulash|r |cff0080FFAlly only|r " .. alliance .. " |cffFFFFFF\n" .. ck .. " Recipe: Crocolisk Gumbo|r |cff0080FFAlly only|r " .. alliance .. " |cffFFFFFF\n" .. ck .. "Recipe: Curiously Tasty Omelet|r |cffFFFFFF\n" .. ck .. " Recipe: Blood Sausage|r |cff0080FFAlly only|r " .. alliance.. " |cffFFFFFF\n" .. ck .. " Recipe: Beer Basted Boar Ribs|r |cff0080FFAlly only|r " .. alliance .. " |cffFFFFFF\n" .. ck .. " Recipe: Gooey Spider Cake|r |cff0080FFAlly only|r " .. alliance .. " |cffFFFFFF\n" .. ck .. " Recipe: Succulent Pork Ribs|r |cff0080FFAlly only|r " .. alliance .. " |cffFFFFFF\n" .. ck .. " Recipe: Seasoned Wolf Kabob|r |cff0080FFAlly only|r " .. alliance, --tooltip display
		coords = 76065306, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[77065302] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Erika Tate|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Smoked Sagefish|r |cffFFFFFF\n" .. ck .. " Recipe: Sagefish Delight|r", --tooltip display
		coords = 77065302, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[55006906] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Catherine Leland|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Brilliant Smallfish|r |cffFFFFFF\n" .. ck .. " Recipe: Rainbow Fin Albacore|r |cffFFFFFF\n" .. ck .. " Recipe: Bristle Whisker Catfish|r", --tooltip display
		coords = 55006906, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[63023706] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Kaita Deepforge|r", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Hardened Iron Shortsword|r", --tooltip display
		coords = 63023706, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

points[50] = { -- "NorthernStranglethorn"
	[43062300] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Jaquilina Dramet|r", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Massive Iron Axe|r", --tooltip display
		coords = 43062300, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[67066100] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Gnaz Blunderflame & Knaz Blunderflame|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Mechanical Dragonling|r |cffFFFFFF\n" .. eng .. " Schematic: Deadly Scope|r", --tooltip display
		coords = 67066100, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[47041002] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Corporal Bluth|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Roast Raptor|r |cffFFFFFF\n" .. ck .. " Recipe: Jungle Stew|r", --tooltip display
		coords = 47041002, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

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
	
	
	
	
	
	
	
	[45411554] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Jaquilina Dramet|r", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Massive Iron Axe|r", --tooltip display
		coords = 45411554, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[59673931] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Gnaz Blunderflame & Knaz Blunderflame|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Mechanical Dragonling|r |cffFFFFFF\n" .. eng .. " Schematic: Deadly Scope|r", --tooltip display
		coords = 59673931, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[48050792] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Corporal Bluth|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Roast Raptor|r |cffFFFFFF\n" .. ck .. " Recipe: Jungle Stew|r", --tooltip display
		coords = 48050792, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}



points[51] = { -- "SwampOfSorrows"
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

points[210] = { -- "TheCapeOfStranglethorn"
	[42087400] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Blixrez Goodstitch|r", --Vendor Name
		info = lw .. " |cff1EFF0BPattern: Thick Murloc Armor|r |cff1EFF0B\n" .. lw .. " Pattern: Murloc Scale Bracers|r", --tooltip display
		coords = 42087400, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[42086904] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Zarena Cromwind|r", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Moonsteel Broadsword|r", --tooltip display
		coords = 42086904, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[42066902] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Narkk|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Black Swashbuckler's Shirt|r", --tooltip display
		coords = 42066902, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[42086900] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Kelsey Yance|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Giant Clam Scorcho|r |cffFFFFFF\n" .. ck .. " Recipe: Cooked Glossy Mightfish|r |cffFFFFFF\n" .. ck .. " Recipe: Filet of Redgill|r |cffFFFFFF\n" .. ck .. " Recipe: Hot Smoked Bass|r", --tooltip display
		coords = 42086900, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[43067300] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Xizk Goodstitch|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Enchanter's Cowl|r |cffFFFFFF\n" .. tl .. " Pattern: Crimson Silk Cloak|r", --tooltip display
		coords = 43067300, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[40088202] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Cowardly Crosby|r Inside House on Top Floor", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Admiral's Hat|r", --tooltip display
		coords = 40088202, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[43027106] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Rikqiz|r House on Main Floor", --Vendor Name
		info = lw .. " |cffFFFFFFPattern: Gem-Studded Leather Belt|r |cffFFFFFF\n" .. lw .. " Pattern: Shadowskin Gloves|r", --tooltip display
		coords = 43027106, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[43007208] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Crazk Sparks|r House on Main Floor Entrance on Back", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Green Firework|r", --tooltip display
		coords = 43007208, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[41067400] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Jutak|r Outside on Main Floor", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Hardened Iron Shortsword|r", --tooltip display
		coords = 41067400, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[42067408] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Glyx Brewright|r House on Top Floor", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Frost Protection Potion|r |cffFFFFFF\n" .. alc .. " Recipe: Nature Protection Potion|r", --tooltip display
		coords = 42067408, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[42067208] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Mrs. Gant|r Lowest Floor of the House", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Undermine Clam Chowder|r", --tooltip display
		coords = 42067208, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

points[22] = { -- "WesternPlaguelands"
	[68007706] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Magnus Frostwake|r", --Vendor Name
		info = bs .. " |cff0A70D0Plans: Storm Gauntlets|r", --tooltip display
		coords = 68007706, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[43008402] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Leonard Porter|r", --Vendor Name
		info = lw .. " |cffFFFFFFPattern: Wicked Leather Gauntlets|r |cffFFFFFF\n" .. lw .. " Pattern: Stormshroud Pants|r", --tooltip display
		coords = 43008402, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

points[52] = { -- Westfall
	[36029000] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Kriggon Talsone|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Clam Chowder|r |cff0080FFAlly only|r " .. alliance .. " |cffFFFFFF\n" .. ck .. " Recipe: Spiced Chili Crab|r", --tooltip display
		coords = 36029000, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[57065308] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Gina MacGregor|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Blue Overalls|r |cffFFFFFF\n" .. lw .. " Pattern: Murloc Scale Breastplate|r |cffFFFFFF\n" .. lw .. " Pattern: Murloc Scale Belt|r |cffFFFFFF\n" .. tl .. " Pattern: Red Linen Bag|r", --tooltip display
		coords = 57065308, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

points[56] = { -- "Wetlands"
	[10005900] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Jennabink Powerseam|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Greater Adept's Robe|r |cffFFFFFF\n" .. tl .. " Pattern: Red Woolen Bag|r", --tooltip display
		coords = 10005900, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[25062508] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Wenna Silkbeard|r In an underground House", --Vendor Name
		info = lw .. " |cffFFFFFFPattern: Red Whelp Gloves|r |cff0080FFAlly only|r " .. alliance .. "|cffFFFFFF\n" .. lw .. " Pattern: Green Leather Armor|r |cffFFFFFF\n" .. tl .. " Pattern: Azure Silk Gloves|r", --tooltip display
		coords = 25062508, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[26082600] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Fradd Swiftgear|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Minor Recombobulator|r", --tooltip display
		coords = 26082600, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}


--------------
-- Kalimdor --
--------------

points[10] = { --"Northern Barrens"
	[68046902] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Gagsprocket|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Green Firework|r |cffFFFFFF\n" .. eng .. " Schematic: Minor Recombobulator|r", --tooltip display
		coords = 68046902, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[67007304] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Ranik|r", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Rage Potion|r |cffFFFFFF\n" ..jc .. " Design: Wicked Moonstone Ring|r |cffFFFFFF\n" .. tl .. " Pattern: Blue Linen Robe|r |cffFFFFFF\n" .. tl .. " Pattern: Greater Adept's Robe|r", --tooltip display
		coords = 67007304, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},
}



points[63] = { -- "Ashenvale"
	[18026000] = {
		npcid = 34601, --NPC ID
		name = "|cffEEC410Harlown Darkweave|r 'Quest to Unlock @ 17.8, 49.4'", --Vendor Name
		info = lw .. " |cff1EFF0BPattern: Herbalist's Gloves|r |cff0080FFAlly only|r " .. alliance, --tooltip display
		coords = 18026000, --Cordinates to vendor
		items = {7361}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?		
		},

	[35005200] = {
		npcid = 3954, --NPC ID
		name = "|cffEEC410Dalria|r", --Vendor Name
		info = enc .. " |cff1EFF0BFormula: Enchant Bracer - Lesser Strength|r |cffFFFFFF\n" .. jc .. " Design: Wicked Moonstone Ring|r |cff1EFF0B\n" .. enc .. " Formula: Enchant Cloak - Minor Agility|r", --tooltip display
		coords = 35005200, --Cordinates to vendor
		items = {11101, 20855, 11039}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?		
		},

	[34084908] = {
		npcid = 3958, --NPC ID
		name = "|cffEEC410Lardan|r", --Vendor Name
		info = lw .. " |cffFFFFFFPattern: Barbaric Leggings|r", --tooltip display
		coords = 34084908, --Cordinates to vendor
		items = {5973}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?		
		},

	[17084904] = {
		npcid = 24739, --NPC ID
		name = "|cffEEC410Benjari Edune|r Prequest for Harlown", --Vendor Name
		info = quest .. " |cffFFFFFFQuestname = Three Friends of the Forest|r", --tooltip display
		coords = 17084904, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?		
		},


}

points[97] = { -- "AzuremystIsle"
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


points[106] = { -- "BloodmystIsle"
	[53045606] = {
		npcid =  0000, --NPC ID
		name = "|cffEEC410Fazu|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Crunchy Spider Suprise|r", --tooltip display
		coords = 53045606, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?		
		},
}

points[62] = { -- "Darkshore"
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

points[89] = { -- "Darnassus"
	[60003702] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Saenorion UPSTAIRS & Elynna DOWNSTAIRS|r", --Vendor Name
		info = lw .. " |cffFFFFFFPattern: Barbaric Bracers|r |cff1EFF0B\n" .. lw .. " Pattern: Green Whelp Bracers|r |cffFFFFFF\n" .. tl .. " Pattern: Blue Linen Robe|r |cffFFFFFF\n" .. tl .. " Pattern: Greater Adept's Robe|r |cffFFFFFF\n" .. tl .. " Pattern: Orange Martial Shirt|r", --tooltip display
		coords = 60003702, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[54063906] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Ulthir|r", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Free Action Potion|r |cffFFFFFF\n" .. alc .. " Recipe: Great Rage Potion|r", --tooltip display
		coords = 54063906, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[58023500] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Mythrin'dir|r", --Vendor Name
		info = enc .. " |cff1EFF0BFormula: Enchant Bracer - Dodge|r |cffFFFFFF\n" .. jc .. " Design: Amulet of the Moon|r", --tooltip display
		coords = 58023500, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[56065206] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Layna Karner|r", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Hardened Iron Shortsword|r", --tooltip display
		coords = 56065206, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},
		
}

points[66] = { -- "Desolace"
	[66020606] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Janet Hommers|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Heavy Kodo Stew|r", --tooltip display
		coords = 66020606, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},
}

points[70] = { -- "Dustwallow"
	[66035104] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Helenia Olden|r", --Vendor Name
		info = jc .. " |cffFFFFFFDesign: Truesilver Crab|r |cffFFFFFF\n" .. ck .. " Recipe: Mystery Stew|r |cff0080FFAlly only|r " .. alliance .. "|cffFFFFFF\n" .. jc .. " Design: Black Pearl Panther|r |cffFFFFFF\n" .. ck .. " Recipe: Dragonbreath Chili|r |cff1EFF0B\n" .. lw .. " Pattern: Murloc Scale Bracers|r", --tooltip display
		coords = 66035104, --Cordinates to vendor
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
	[45044102] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Pratt McGrubben|r", --Vendor Name
		info = lw .. " |cff1EFF0BPattern: Green Whelp Bracers|r |cffFFFFFF\n" .. lw.. " Pattern: Living Shoulders|r |cffFFFFFF\n" .. lw .. " Pattern: Turtle Scale Gloves|r", --tooltip display
		coords = 45044102, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[46024106] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Vivianna|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Hot Wolf Ribs|r |cffFFFFFF\n" .. ck .. " Recipe: Baked Salmon|r |cffFFFFFF\n" .. ck .. " Recipe: Lobster Stew|r", --tooltip display
		coords = 46024106, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[46064300] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Logannas|r", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Nature Protection Potion|r |cffFFFFFF\n" .. alc .. " Recipe: Ghost Dye|r", --tooltip display
		coords = 46064300, --Cordinates to vendor
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


points[81] = { -- "Silithus"
	[55043606] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Calandrath|r", --Vendor Name
		info = alc .. " |cff1EFF0BRecipe: Greater Nature Protection Potion|r", --tooltip display
		coords = 55043606, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[81021806] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Zannok Hidepiercer|r", --Vendor Name
		info = lw .. " |cffFFFFFFPattern: Heavy Scorpid Bracers|r |cffFFFFFF\n" .. lw .. " Pattern: Heavy Scorpid Helm|r", --tooltip display
		coords = 81021806, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[53083404] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Mishta|r", --Vendor Name
		info = jc .. " |cffFFFFFFDesign: Emerald Crown of Destruction|r", --tooltip display
		coords = 53083404, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[55063700] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Kania|r", --Vendor Name
		info = enc .. " |cffFFFFFFFormula: Lesser Mana Oil|r |cffFFFFFF\n" .. enc .. " Formula: Wizard Oil|r |cffFFFFFF\n" .. tl .. " Pattern: Enchanted Runecloth Bag|r", --tooltip display
		coords = 55063700, --Cordinates to vendor
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

points[71] = { -- "Tanaris"
	[50062806] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Haughty Modiste & Vizzklick & Blizrik Buckshot|r", --Vendor Name
		info = tl .. "|cffFFFFFFPattern: Haliscan Pantaloons|r |cffFFFFFF\n" .. tl .. " Pattern: Dress Shoes|r |cffFFFFFF\n" .. tl .. " Pattern: Haliscan Jacket|r |cffFFFFFF\n" .. tl .. " Pattern: Crimson Silk Robe|r |cffFFFFFF\n" .. tl .. " Pattern: Soul Pouch|r |cffFFFFFF\n" .. eng .. " Schematic: EZ-Thro Dynamite II|r", --tooltip display
		coords = 50062806, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[52062900] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Dirge Quikcleave|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Tender Wolf Steak|r", --tooltip display
		coords = 52062900, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[51023002] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Krinkle Goodsteel|r", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Golden Scale Coif|r", --tooltip display
		coords = 51023002, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[50082800] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Alchemist Pestlezugg|r", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Nature Protection Potion|r |cffFFFFFF\n" .. enc .. " Recipe: Philosopher's Stone|r |cffFFFFFF\n" .. alc .. " Recipe: Transmute Iron to Gold|r |cffFFFFFF\n" .. alc .. " Recipe: Transmute Mithril to Truesilver|r |cffFFFFFF\n" .. alc .. " Recipe: Transmute Arcanite|r", --tooltip display
		coords = 50082800, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

points[103] = { -- "TheExodar"
	[53009000] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Feera|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Adamantite Rifle|r |cffFFFFFF\n" .. eng .. " Schematic: White Smoke Flare|r |cffFFFFFF\n" .. eng .. " Schematic: Fel Iron Toolbox|r", --tooltip display
		coords = 53009000, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[27086108] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Altaa|r", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Elixir of Camouflage|r |cff1EFF0B\n" .. alc .. " Recipe: Transmute Primal Might|r", --tooltip display
		coords = 27086108, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[61008900] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Arras|r", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Adamantite Dagger|r |cffFFFFFF\n" .. bs .. " Plans: Adamantite Maul|r |cffFFFFFF\n" .. bs .. " Plans: Adamantite Cleaver|r |cffFFFFFF\n" .. bs .. " Plans: Adamantite Rapier|r", --tooltip display
		coords = 61008900, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[39083908] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Egomis|r", --Vendor Name
		info = enc .. " |cffFFFFFFFormula: Superior Mana Oil|r |cffFFFFFF\n" .. enc .. " Formula: Large Prismatic Shard|r |cffFFFFFF\n" .. enc .. " Formula: Superior Wizard Oil|r", --tooltip display
		coords = 39083908, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[66067400] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Haferet|r", --Vendor Name
		info = lw .. " |cffFFFFFFPattern: Comfortable Insoles|r", --tooltip display
		coords = 66067400, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[64066806] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Neii|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Bolt of Soulcloth|r", --tooltip display
		coords = 64066806, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[45002506] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Arred|r", --Vendor Name
		info = jc .. "|cffFFFFFFDesign: Opal Necklace of Impact|r |cffFFFFFF\n" .. jc .. " Design: The Jade Eye|r |cffFFFFFF\n" .. jc .. " Design: Heavy Golden Necklace of Battle|r |cffFFFFFF\n" ..  jc .. " Design: Amulet of the Moon|r", --tooltip display
		coords = 45002506, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

points[57] = { -- "Teldrassil"
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

points[78] = { -- "UngoroCrater"
	[54086206] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Nergal|r ", --Vendor Name
		info = lw .. " |cff0A70D0Pattern: Devilsaur Leggings|r |cffFFFFFF\n" .. lw .. " Pattern: Devilsaur Gauntlets|r", --tooltip display
		coords = 54086206, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[43044106] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Dramm Riverhorn|r", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Runic Plate Boots|r |cffFFFFFF\n" .. bs .. " Plans: Runic Plate Helm|r |cffFFFFFF\n" .. bs .. " Plans: Runic Plate Shoulders|r |cffFFFFFF\n" .. bs .. " Plans: Runic Plate Leggings|r", --tooltip display
		coords = 43044106, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

}

points[83] = { -- "Winterspring"
	[59025008] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Xizzer Fizzbolt|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Delicate Arcanite Converter|r |cffFFFFFF\n" .. eng .. " Schematic: Masterwork Target Dummy|r |cffFFFFFF\n" .. eng .. " Schematic: Powerful Seaforium Charge|r |cffFFFFFF\n" .. eng .. " Schematic: Gyrofreeze Ice Reflector|r", --tooltip display
		coords = 59025008, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[59085106] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Himmik|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Monster Omelet|r", --tooltip display
		coords = 59085106, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[59064902] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Qia|r", --Vendor Name
		info = enc .. " |cffFFFFFFFormula: Enchant Chest - Major Health|r |cffFFFFFF\n" .. jc .. " Design: Necklace of the Diamond Tower|r |cffFFFFFF\n" .. lw .. " Pattern: Frostsaber Boots|r |cffFFFFFF\n" .. tl .. " Pattern: Mooncloth|r |cffFFFFFF\n" .. tl .. " Pattern: Runecloth Bag|r", --tooltip display
		coords = 59064902, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		}, 

	[58006308] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Daleohm|r", --Vendor Name
		info = bs .. " |cff0A70D0Plans:Frostguard|r", --tooltip display
		coords = 58006308, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

points[85] = { -- "Orgrimmar"
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



-------------
-- Outland --
-------------
points[105] = { -- "BladesEdgeMountains"
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

points[100] = { -- "Hellfire"
	[54026306] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Sid Limbardi|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Ravager Dog|r", --tooltip display
		coords = 54026306, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[53086508] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Alchemist Gribble|r", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Elixir of Camouflage|r", --tooltip display
		coords = 53086508, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[55066506] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Lebowski|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Ultra-Spectropic Detection Goggles|r |cffFFFFFF\n" .. eng .. " Schematic: Cogspinner Goggles|r", --tooltip display
		coords = 55066506, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[53086504] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Jezebel Bican|r", --Vendor Name
		info = ins .. " |cffFFFFFFTechnique Glyph of Counterspell|r", --tooltip display
		coords = 53086504, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

points[107] = { -- "Nagrand"
	[53027108] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Borto|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Bolt of Soulcloth|r |cffFFFFFF\n" .. tl .. " Pattern: Soulcloth Gloves|r", --tooltip display
		coords = 53027108, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[56027302] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Uriku|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Grilled Mudfish|r |cffFFFFFF\n" .. ck .. " Recipe: Poached Bluefish|r |cffFFFFFF\n" .. ck .. " Recipe: Roasted Clefthoof|r |cffFFFFFF\n" .. ck .. " Recipe: Talbuk Steak|r", --tooltip display
		coords = 56027302, --Cordinates to vendor
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
	[55085802] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Arrond !SCRYERS ONLY!|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Imbued Netherweave Robe|r |cffFFFFFF\n" .. tl .. " Pattern: Imbued Netherweave Tunic|r", --tooltip display
		coords = 55085802, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[36085404] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Daggle Ironshaper|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Adamantite Scope|r", --tooltip display
		coords = 36085404, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[36085500] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Mari Stonehand|r", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Lesser Ward of Shielding|r", --tooltip display
		coords = 36085500, --Cordinates to vendor
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
		info = bs .. " |cffFFFFFFPlans: Adamantite Maul|r |cffFFFFFF\n" .. bs .. " Plans: Adamantite Cleaver|r |cffFFFFFF\n" .. bs .. " Plans: Adamantite Dagger|r |cffFFFFFF\n" .. bs .. " Plans: Adamantite Rapier|r", --tooltip display
		coords = 64007108, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[63067000] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Madame Ruby|r", --Vendor Name
		info = enc .. " |cffFFFFFFFormula: Superior Mana Oil|r |cffFFFFFF\n" .. enc .. " Formula: Enchant Shield - Major Stamina|r |cffFFFFFF\n" .. enc .. " Formula: Large Prismatic Shard|r |cffFFFFFF\n" .. enc .. " Formula: Superior Wizard Oil|r", --tooltip display
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
	[55085300] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Supply Officer Mills|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Blackened Basilisk|r |cffFFFFFF\n" .. ck .. " Recipe: Warp Burger|r", --tooltip display
		coords = 55085300, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[57065304] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Leeli Longhaggle|r", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Sneaking Potion|r |cffFFFFFF\n" .. alc .. " Recipe: Major Dreamless Sleep Potion|r", --tooltip display
		coords = 57065304, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[56065302] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Innkeeper Biribi|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Golden Fish Sticks|r |cffFFFFFF\n" .. ck .. " Recipe: Spicy Crawdad|r", --tooltip display
		coords = 56065302, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},


}

points[102] = { -- "Zangarmarsh"
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

	[67084800] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Haalrun|r", --Vendor Name
		info = alc .. " |cffFFFFFFRecipe: Elixir of Major Frost Power|r |cffFFFFFF\n" .. alc .. " Recipe: Super Mana Potion|r |cffFFFFFF\n" .. alc .. " Recipe: Elixir of Major Defense|r", --tooltip display
		coords = 67084800, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[68065002] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Loolruna|r", --Vendor Name
		info = bs .. " |cffFFFFFFPlans: Adamantite Plate Bracers|r |cffFFFFFF\n" .. bs .. " Plans: Adamantite Plate Gloves|r |cffFFFFFF\n" .. bs .. " Plans: Adamantite Breastplate|r", --tooltip display
		coords = 68065002, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[40062802] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Muheru the Weaver|r", --Vendor Name
		info = tl .. " |cffFFFFFFPattern: Imbued Netherweave Pants|r |cffFFFFFF\n" .. tl .. " Pattern: Imbued Netherweave Boots|r", --tooltip display
		coords = 40062802, --Cordinates to vendor
		items = {00000}, --Items the vendor sells
		icon = "interface\\icons\\Inv_scroll_03", --Icon displayed on map
		cost = {999999999}, --Cost of each item?
		},

	[42022708] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Doba|r", --Vendor Name
		info = ck .. " |cffFFFFFFRecipe: Blackened Trout|r |cffFFFFFF\n" .. ck .. " Recipe: Feltail Delight|r", --tooltip display
		coords = 42022708, --Cordinates to vendor
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
		info = eng .. " |cff1eff00Schematic: Arcanite Dragonling|r |cffFFFFFF\n" .. eng .. " Schematic: Mithril Mechanical Dragonling|r |cffFFFFFF\n" .. eng .. " Schematic: Mechanical Dragonling|r", --tooltip display
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
	[72022008] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Fizzix Blastbolt !ONLY IF DALA SOLD OUT!|r", --Vendor Name
		info = eng .. " |cffFFFFFFSchematic: Titanium Toolbox|r", --tooltip display
		coords = 72022008, --Cordinates to vendor
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
	[78067602] = {
		npcid = 0000, --NPC ID
		name = "|cffEEC410Casandra Downs|r", --Vendor Name
		info = ins .. " |cffFFFFFFTechnique Glyph of Colossus Smash|r", --tooltip display
		coords = 78067602, --Cordinates to vendor
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

points[203] = { -- "Vashjir"
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

points[393] = { -- "ShrineofSevenStars"
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


-------------
-- Draenor --
-------------
points[582] = { -- "garrisonsmvalliance_tier3"
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

points[539] = { -- "ShadowmoonValleyDR"
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
