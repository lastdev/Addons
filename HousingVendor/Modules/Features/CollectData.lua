-- Data Collection Utility for HousingVendor addon
-- This utility helps collect complete data from the website

HousingCollector = {}

function HousingCollector:PrintCurrentDataStructure()
  print("=== Current Data Structure ===")
  for expansionName, expansionData in pairs(Housing.vendorData) do
    print("Expansion: " .. expansionName)
    for zoneName, vendors in pairs(expansionData) do
      print("  Zone: " .. zoneName)
      for i, vendor in ipairs(vendors) do
        print("    Vendor: " .. vendor.name)
        print("      Currency: " .. vendor.currency)
        print("      Coordinates: " .. vendor.coordinates.x .. ", " .. vendor.coordinates.y)
        print("      Items: " .. #vendor.items)
        for j, item in ipairs(vendor.items) do
          print("        " .. j .. ". " .. item.name .. " (" .. item.quality .. ") - " .. item.price)
        end
      end
    end
  end
end

function HousingCollector:GenerateTemplateForExpansion(expansionName)
  print("=== Template for " .. expansionName .. " ===")
  print("HousingData.vendorData[\"" .. expansionName .. "\"] = {")
  print("  [\"Zone Name\"] = {")
  print("    {")
  print("      name = \"Vendor Name\",")
  print("      coordinates = {x = 0.0, y = 0.0},")
  print("      currency = \"Currency Type\",")
  print("      waypoint = \"\",")
  print("      tomTom = \"\",")
  print("      items = {")
  print("        {")
  print("          name = \"Item Name\",")
  print("          icon = \"Interface\\\\Icons\\\\INV_Misc_QuestionMark\",")
  print("          quality = \"Common\",")
  print("          price = 100,")
  print("          tooltip = \"Item tooltip text\"")
  print("        }")
  print("      }")
  print("    }")
  print("  }")
  print("}")
end

function HousingCollector:ExportAllDataAsLua()
  print("=== Exporting All Data as Lua ===")
  print("HousingData.vendorData = {")
  
  for expansionName, expansionData in pairs(Housing.vendorData) do
    print("  [\"" .. expansionName .. "\"] = {")
    for zoneName, vendors in pairs(expansionData) do
      print("    [\"" .. zoneName .. "\"] = {")
      for i, vendor in ipairs(vendors) do
        print("      {")
        print("        name = \"" .. vendor.name .. "\",")
        print("        coordinates = {x = " .. vendor.coordinates.x .. ", y = " .. vendor.coordinates.y .. "},")
        print("        currency = \"" .. vendor.currency .. "\",")
        print("        waypoint = \"" .. vendor.waypoint .. "\",")
        print("        tomTom = \"" .. vendor.tomTom .. "\",")
        print("        items = {")
        for j, item in ipairs(vendor.items) do
          print("          {")
          print("            name = \"" .. item.name .. "\",")
          print("            icon = \"" .. item.icon .. "\",")
          print("            quality = \"" .. item.quality .. "\",")
          print("            price = " .. item.price .. ",")
          print("            tooltip = \"" .. item.tooltip .. "\"")
          print("          },")
        end
        print("        }")
        print("      },")
      end
      print("    },")
    end
    print("  },")
  end
  
  print("}")
end

-- Collection Tracking System for HousingVendor addon
local HousingCollectData = {}
HousingCollectData.__index = HousingCollectData

-- Slash commands for data collection
SLASH_HOUSINGCOLLECT1 = "/hvcollect"
SlashCmdList["HOUSINGCOLLECT"] = function(msg)
  if msg == "structure" then
    HousingCollector:PrintCurrentDataStructure()
  elseif msg == "template" then
    HousingCollector:GenerateTemplateForExpansion("NewExpansion")
  elseif msg == "export" then
    HousingCollector:ExportAllDataAsLua()
  else
    print("Housing Data Collector Commands:")
    print("/hvcollect structure - Print current data structure")
    print("/hvcollect template - Generate template for new expansion")
    print("/hvcollect export - Export all data as Lua code")
  end
end