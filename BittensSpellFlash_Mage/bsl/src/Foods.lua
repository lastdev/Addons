local g = BittensGlobalTables
local c = g.GetTable("BittensSpellFlashLibrary")
local u = g.GetTable("BittensUtilities")
if u.SkipOrUpgrade(c, "Foods", tonumber("20141220081111") or time()) then
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
      [28] = {
         74643, -- Sauteed Carrots
      },
      [31] = {
         74647, -- Valley Stir Fry
      },
      [34] = {
         74648, -- Sea Mist Rice Noodles
         145305, -- Seasoned Pomfruit Slices
      },
   },
   Crit = {
      [11] = {
         81402, -- Toasted Fish Jerky
      },
      [23] = {
         81410, -- Green Curry Fish
         98123, -- Whale Shark Caviar
         104344, -- Lucky Mushroom Noodles
      },
      [50] = {
        160962, -- Blackrock Ham
        160978, -- Grilled Gulper
      },
    [75] = {
      160986, -- Blackrock Barbeque
    },
   },
   Dodge = {
      [11] = {
         81404, -- Dried Needle Mushrooms
      },
      [23] = {
         81412, -- Blanched Needle Mushrooms
         98125, -- Shaved Zangar Truffles
         104340, -- Crazy Snake Noodles
      },
   },
   Haste = {
      [11] = {
         81400, -- Pounded Rice Cake
         81401, -- Yak Cheese Curds
      },
    [23] = {
      89121, -- Amberseed Bun
      81408, -- Red Bean Bun
      104343, -- Golden Dragon Noodles
         98122, -- Camembert du Clefthoof
         81409, -- Tangy Yogurt
         104341, -- Steaming Goat Noodles
    },
    [31] = {
         86069, -- Rice Pudding
    },
    [34] = {
      86074, -- Spicy Vegetable Chips
    },
    [50] = {
      160966, -- Pan-Seared Talbuk
      160979, -- Sturgeon Stew
    },
    [75] = {
      160987, -- Frosty Stew
    },
   },
--      Hit = {
--         [11] = {
--            81405, -- Boiled Silkworm Pupa
--         },
--         [23] = {
--            98126, -- Mechanopeep Foie Gras
--            81413, -- Skewered Peanut Chicken
--            104342, -- Spicy Mushan Noodles
--         },
--         [31] = {
--            86070, -- Wildfowl Ginseng Soup
--         },
--         [34] = {
--            86073, -- Spicy Salmon
--         },
--      },
   Intellect = {
      [28] = {
         74644, -- Swirling Mist Soup
      },
      [31] = {
         74649, -- Braised Turtle
      },
      [34] = {
         74650, -- Mogu Fish Stew
         145307, -- Spiced Blossom Soup
      },
   },
   Mastery = {
      [11] = {
         81406, -- Roasted Barley Tea
         90457, -- Mah's Warm Yak-Tail Stew
      },
      [23] = {
         98127, -- Dented Can of Kaja'Cola
         94535, -- Grilled Dinosaur Haunch
         81414, -- Pearl Milk Tea
      },
      [34] = {
         145308, -- Mango Ice
      },
      [50] = {
        160968, -- Braised Riverbeast
        160981, -- Fat Sleeper Cakes
      },
    [75] = {
      160989, -- Sleeper Surprise
    },
   },
   Multistrike = {
    [50] = {
      160982, -- Fiery Calamari
      160969, -- Rylak Crepes
    },
    [75] = {
      160999, -- Calamari Crepes
    },
   },
   Parry = {
      [11] = {
         81403, -- Dried Peaches
      },
      [23] = {
         98124, -- Bloodberry Tart
         81411, -- Peach Pie
         104339, -- Harmonious River Noodles
      },
   },
   Smart = {
      [28] = {
         101616, -- Noodle Soup
      },
      [31] = {
         101617, -- Deluxe Noodle Soup
      },
      [34] = {
         101618, -- Pandaren Treasure Noodle Soup
      },
   },
   Spirit = {
      [28] = {
         74651, -- Shrimp Dumplings
      },
      [31] = {
         74652, -- Fire Spirit Salmon
      },
      [34] = {
         74653, -- Steamed Crab Surprise
         145309, -- Farmer's Delight
      },
   },
   Stamina = {
      [43] = {
         74654, -- Wildfowl Roast
      },
      [47] = {
         74655, -- Twin Fish Platter
      },
      [51] = {
         74656, -- Chun Tian Spring Rolls
         145310, -- Stuffed Lushrooms
      },
    [75] = {
      160958, -- Hearty Elekk Steak
      160973, -- Steamed Scorpion
    },
    [112] = {
      160984, -- Talador Surf and Turf
    },
   },
   Stats = {
      [31] = {
         88586, -- Chao Cookies
      }
   },
   Strength = {
      [28] = {
         74642, -- Charbroiled Tiger Steak
      },
      [31] = {
         74645, -- Eternal Blossom Fish
      },
      [34] = {
         74646, -- Black Pepper Ribs and Shrimp
         145311, -- Fluffy Silkfeather Omlet
      },
   },
   Versatility = {
    [50] = {
      160971, -- Clefthoof Sausages
      160983, -- Skulker Chowder
    },
    [75] = {
      161000, -- Gorgrond Chowder
    },
   },
   Armor = {
   },
}

local alreadyFed = {
   124217, -- Wed Fed
   125116, -- Refreshment
   104235, -- Food
}

local function flashFoods(stat, current, cap, conversion, size)
  if not foods[stat] then
    return -- temporary (?) measure while modules are being updated for 6.0
  end

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
   flashFoods("Smart")
   flashFoods("Stats")
   flashFoods("Versatility")
   for _, stat in pairs(stats) do
      flashFoods(stat)
   end
end
