-- Constants and Data Initialization
_G["HousingConstants"] = {}
local HousingConstants = _G["HousingConstants"]

-- Initialize the main data structure
_G["HousingData"] = {}
_G["HousingData"].vendorData = {}
local HousingData = _G["HousingData"]

-- Enhanced Data structure definition:
-- [expansionName] = {
--   [zoneName] = {
--     {
--       name = "Vendor Name",
--       type = "Vendor Type",  -- e.g., "Brawler", "Special Event", "Zone Specific"
--       coordinates = {x = 0.0, y = 0.0},
--       items = {
--         {
--           name = "Item Name",
--           type = "Item Type",  -- e.g., "Furniture", "Lighting", "Decorative", "Structural"
--           category = "Item Category",  -- e.g., "Rugs", "Tables", "Chairs", "Lights"
--           price = 100  -- in gold
--         }
--       }
--     }
--   }
-- }

-- Vendor types
HousingConstants.VENDOR_TYPES = {
  "Brawler",
  "Special Event",
  "Zone Specific",
  "World Boss",
  "Dungeon",
  "Raid",
  "Profession Trainer",
  "Neutral Vendor",
  "Faction Vendor",
  "Achievement Reward",
  "Store Exclusive",
  "Non-Vendor"
}

-- Item types
HousingConstants.ITEM_TYPES = {
  "Furniture",
  "Lighting",
  "Decorative",
  "Structural",
  "Interactive",
  "Seasonal",
  "Limited Edition"
}

-- Item categories
HousingConstants.ITEM_CATEGORIES = {
  -- Furniture categories
  "Tables",
  "Chairs",
  "Beds",
  "Benches",
  "Stools",
  "Cabinets",
  "Bookcases",
  "Desks",
  
  -- Lighting categories
  "Lanterns",
  "Torches",
  "Candles",
  "Chandeliers",
  "Street Lights",
  
  -- Decorative categories
  "Paintings",
  "Statues",
  "Plants",
  "Rugs",
  "Tapestries",
  "Ornaments",
  "Figurines",
  "Trophies",
  
  -- Structural categories
  "Walls",
  "Fences",
  "Doors",
  "Windows",
  "Roofs",
  "Stairs",
  "Buildings",
  
  -- Interactive categories
  "Mailboxes",
  "Music Boxes",
  "Teleporters",
  "Containers",
  "Training Equipment",
  
  -- Seasonal categories
  "Winter",
  "Spring",
  "Summer",
  "Autumn",
  "Halloween",
  "Christmas",
  
  -- Limited Edition categories
  "Promotional",
  "BlizzCon",
  "Anniversary",
  "Collector's Edition"
}

-- Faction restrictions
HousingConstants.FACTION_RESTRICTIONS = {
  HORDE = "Horde",
  ALLIANCE = "Alliance",
  NEUTRAL = "Neutral"
}

-- Function to determine vendor type based on vendor name
function HousingConstants:GetVendorType(vendorName)
  -- Brawler vendors
  if string.find(vendorName, "Brawl") or string.find(vendorName, "Symmes") then
    return "Brawler"
  end
  
  -- Special event vendors
  if string.find(vendorName, "Celebration") or string.find(vendorName, "Festival") or string.find(vendorName, "Event") then
    return "Special Event"
  end
  
  -- Default to Zone Specific for most vendors
  return "Zone Specific"
end

-- Function to determine item type and category based on item name
function HousingConstants:GetItemTypeAndCategory(itemName)
  if not itemName then
    return "Decorative", "Uncategorized"
  end
  
  local lowerName = string.lower(itemName)
  
  -- Furniture items
  if string.find(lowerName, "table") or string.find(lowerName, "desk") or string.find(lowerName, "cabinet") or 
     string.find(lowerName, "bookcase") then
    return "Furniture", "Tables"
  elseif string.find(lowerName, "chair") or string.find(lowerName, "bench") or string.find(lowerName, "stool") then
    return "Furniture", "Chairs"
  elseif string.find(lowerName, "bed") then
    return "Furniture", "Beds"
  end
  
  -- Lighting items
  if string.find(lowerName, "lamp") or string.find(lowerName, "lantern") or string.find(lowerName, "torch") or
     string.find(lowerName, "candle") or string.find(lowerName, "chandelier") or string.find(lowerName, "sconce") or
     string.find(lowerName, "brazier") or string.find(lowerName, "light") then
    return "Lighting", "Lanterns"
  end
  
  -- Decorative items
  if string.find(lowerName, "painting") or string.find(lowerName, "portrait") or string.find(lowerName, "statue") or
     string.find(lowerName, "figurine") or string.find(lowerName, "ornament") or string.find(lowerName, "tapestry") or
     string.find(lowerName, "trophy") then
    return "Decorative", "Ornaments"
  elseif string.find(lowerName, "plant") or string.find(lowerName, "tree") or string.find(lowerName, "flower") then
    return "Decorative", "Plants"
  elseif string.find(lowerName, "rug") or string.find(lowerName, "carpet") then
    return "Decorative", "Rugs"
  end
  
  -- Structural items
  if string.find(lowerName, "wall") or string.find(lowerName, "fence") or string.find(lowerName, "gate") or
     string.find(lowerName, "door") or string.find(lowerName, "window") or string.find(lowerName, "roof") or
     string.find(lowerName, "stair") or string.find(lowerName, "trellis") then
    if string.find(lowerName, "wall") then
      return "Structural", "Walls"
    elseif string.find(lowerName, "fence") or string.find(lowerName, "gate") or string.find(lowerName, "trellis") then
      return "Structural", "Fences"
    else
      return "Structural", "Structural"
    end
  end
  
  -- Interactive items
  if string.find(lowerName, "mailbox") or string.find(lowerName, "teleporter") or string.find(lowerName, "container") or
     string.find(lowerName, "bag") or string.find(lowerName, "pack") or string.find(lowerName, "chest") or
     string.find(lowerName, "keg") or string.find(lowerName, "barrel") or string.find(lowerName, "punching") or
     string.find(lowerName, "training") then
    if string.find(lowerName, "punching") or string.find(lowerName, "training") then
      return "Interactive", "Training Equipment"
    else
      return "Interactive", "Containers"
    end
  end
  
  -- Default to Decorative, Uncategorized
  return "Decorative", "Uncategorized"
end