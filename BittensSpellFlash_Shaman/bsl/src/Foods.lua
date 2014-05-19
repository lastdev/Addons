local g = BittensGlobalTables
local c = g.GetTable("BittensSpellFlashLibrary")
local u = g.GetTable("BittensUtilities")
if u.SkipOrUpgrade(c, "Foods", 4) then
	return
end

local s = SpellFlashAddon

local CR_HIT_MELEE = CR_HIT_MELEE
local CR_HIT_SPELL = CR_HIT_SPELL
local GetCombatRatingBonus = GetCombatRatingBonus
local GetExpertise = GetExpertise
local GetItemCount = GetItemCount
local OffhandHasWeapon = OffhandHasWeapon
local pairs = pairs

local foods = {
	Agility = {
		[250] = {
			74643, -- Sauteed Carrots
		},
		[275] = {
			74647, -- Valley Stir Fry
		},
		[300] = {
			74648, -- Sea Mist Rice Noodles
			145305, -- Seasoned Pomfruit Slices
		},
	},
	Crit = {
		[100] = {
			81402, -- Toasted Fish Jerky
		},
		[200] = {
			81410, -- Green Curry Fish
			98123, -- Whale Shark Caviar
			104344, -- Lucky Mushroom Noodle
		},
	}, 
	Dodge = {
		[100] = {
			81404, -- Dried Needle Mushrooms
		},
		[200] = {
			81412, -- Blanched Needle Mushrooms
			98125, -- Shaved Zangar Truffles
			104340, -- Crazy Snake Noodles
		},
	},
	Expertise = {
		[100] = {
			81400, -- Pounded Rice Cake
		},
		[200] = {
			89121, -- Amberseed Bun
			81408, -- Red Bean Bun
			104343, -- Golden Dragon Noodles
		},
		[275] = {
			86069, -- Rice Pudding
		},
		[300] = {
			86074, -- Spicy Vegetable Chips
		},
	},
	Haste = {
		[100] = {
			81401, -- Yak Cheese Curds
		},
		[200] = {
			98122, -- Camembert du Clefthoof
			81409, -- Tangy Yogurt
			104341, -- Steaming Goat Noodles
		},
	},
	Hit = {
		[100] = {
			81405, -- Boiled Silkworm Pupa
		},
		[200] = {
			98126, -- Mechanopeep Foie Gras
			81413, -- Skewered Peanut Chicken
			104342, -- Spicy Mushan Noodles
		},
		[275] = {
			86070, -- Wildfowl Ginseng Soup
		},
		[300] = {
			86073, -- Spicy Salmon
		},
	},
	Intellect = {
		[250] = {
			74644, -- Swirling Mist Soup
		},
		[275] = {
			74649, -- Braised Turtle
		},
		[300] = {
			74650, -- Mogu Fish Stew
			145307, -- Spiced Blossom Soup
		},
	},
	Mastery = {
		[100] = {
			81406, -- Roasted Barley Tea
			90457, -- Mah's Warm Yak-Tail Stew
		},
		[200] = {
			98127, -- Dented Can of Kaja'Cola
			94535, -- Grilled Dinosaur Haunch
			81414, -- Pearl Milk Tea
		},
		[300] = {
			145308, -- Mango Ice
		},
	},
	Parry = {
		[100] = {
			81403, -- Dried Peaches
		},
		[200] = {
			98124, -- Bloodberry Tart
			81411, -- Peach Pie
			104339, -- Harmonious River Noodles
		},
	},
	Smart = {
		[250] = {
			101616, -- Noodle Soup
		},
		[275] = {
			101617, -- Deluxe Noodle Soup
		},
		[300] = {
			101618, -- Pandaren Treasure Noodle Soup
		},
	},
	Spirit = {
		[250] = {
			74651, -- Shrimp Dumplings
		},
		[275] = {
			74652, -- Fire Spirit Salmon
		},
		[300] = {
			74653, -- Steamed Crab Surprise
			145309, -- Farmer's Delight
		},
	},
	Stamina = {
		[375] = {
			74654, -- Wildfowl Roast
		},
		[415] = {
			74655, -- Twin Fish Platter
		},
		[450] = {
			74656, -- Chun Tian Spring Rolls
			145310, -- Stuffed Lushrooms
		},
	},
	Stats = {
		[275] = {
			88586, -- Chao Cookies
		}
	},
	Strength = {
		[250] = {
			74642, -- Charbroiled Tiger Steak
		},
		[275] = {
			74645, -- Eternal Blossom Fish
		},
		[300] = {
			74646, -- Black Pepper Ribs and Shrimp
			145311, -- Fluffy Silkfeather Omlet
		},
	},
}

local alreadyFed = {
	124217, -- Wed Fed
	125116, -- Refreshment
	104235, -- Food
}

local function flashFoods(stat, current, cap, conversion, size)
	for rating, items in pairs(foods[stat]) do
		if cap == nil or current + rating / conversion <= cap then
			for _, item in pairs(items) do
				if GetItemCount(item, false, true) > 0 then
					s.FlashItem(item, "yellow", size)
				end
			end
		end
	end
end

function c.FlashFoods(stats)
	if c.HasBuff(alreadyFed) then
		return
	end
	
	flashFoods("Mastery")
	flashFoods("Stats")
	flashFoods("Smart")
	
	for _, stat in pairs(stats) do
		if stat == "Spell Hit" then
			local current = GetCombatRatingBonus(CR_HIT_SPELL)
			flashFoods("Hit", current, 15, 340)
			flashFoods("Expertise", current, 15, 340)
		elseif stat == "Hit from Spirit" then
			flashFoods("Spirit", GetCombatRatingBonus(CR_HIT_SPELL), 15, 340)
		elseif stat == "Melee Hit" then
			local current = GetCombatRatingBonus(CR_HIT_MELEE)
			if OffhandHasWeapon() then
				flashFoods("Hit", current, 26.5, 340, s.FlashSizePercent() / 2)
			end
			flashFoods("Hit", current, 7.5, 340)
			flashFoods("Expertise", GetExpertise(), 7.5, 340)
		elseif stat == "Tanking Hit" then
			flashFoods("Hit", GetCombatRatingBonus(CR_HIT_MELEE), 7.5, 340)
			flashFoods("Expertise", GetExpertise(), 15, 340)
		else
			flashFoods(stat)
		end
	end
end
