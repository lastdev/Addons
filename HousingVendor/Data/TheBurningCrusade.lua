-- Data for The Burning Crusade

HousingData.vendorData["The Burning Crusade"] = {
  ["Ghostlands"] = {
    {
      name = "Provisioner Vredigar",
      type = "Zone Specific",
      coordinates = {x = 47.6, y = 32.4},
      items = {
        {
          name = "Sin'dorei Crafter's Forge",
          itemID = "257419",
          modelFileID = "6033615",
           thumbnailFileID = "7416511",
          type = "Decorative",
          category = "Miscellaneous",
          price = 5000,
          mapID = 95
        },
        {
          name = "Sin'dorei Sleeper",
          itemID = "256049",
          modelFileID = "6050850",
           thumbnailFileID = "7416805",
          type = "Furniture",
          category = "Beds",
          price = 5000,
          mapID = 95
        },
      }
    },
  },
}
-- Function to enhance The Burning Crusade expansion data with map information
-- Note: mapData integration removed - map information is now handled via item.mapID

