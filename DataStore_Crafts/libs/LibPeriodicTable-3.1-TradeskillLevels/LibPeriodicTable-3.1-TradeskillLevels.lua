-- (c) 2007 Nymbia.  see LGPLv2.1.txt for full details.
--DO NOT MAKE CHANGES TO THIS FILE BEFORE READING THE WIKI PAGE REGARDING CHANGING THESE FILES
if not LibStub("LibPeriodicTable-3.1", true) then error("PT3 must be loaded before data") end
LibStub("LibPeriodicTable-3.1"):AddData("TradeskillLevels", gsub("$Rev: 436 $", "(%d+)", function(n) return n+90000 end), {
	["TradeskillLevels.Alchemy"]="",
	["TradeskillLevels.Blacksmithing"]="",
	["TradeskillLevels.Cooking.Basic"]="",
	["TradeskillLevels.Cooking.Way of the Brew"]="",
	["TradeskillLevels.Cooking.Way of the Grill"]="",
	["TradeskillLevels.Cooking.Way of the Oven"]="",
	["TradeskillLevels.Cooking.Way of the Pot"]="",
	["TradeskillLevels.Cooking.Way of the Steamer"]="",
	["TradeskillLevels.Cooking.Way of the Wok"]="",
	["TradeskillLevels.Enchanting"]="",
	["TradeskillLevels.Engineering.Basic"]="",
	["TradeskillLevels.Engineering.Gnomish"]="",
	["TradeskillLevels.Engineering.Goblin"]="",
	["TradeskillLevels.First Aid"]="",
	["TradeskillLevels.Inscription"]="",
	["TradeskillLevels.Jewelcrafting"]="",
	["TradeskillLevels.Leatherworking"]="",
	["TradeskillLevels.Smelting"]="",
	["TradeskillLevels.Tailoring"]="",
})
