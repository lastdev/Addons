local ADDON, NS = ...

NS.Data = NS.Data or {}
NS.Data.Professions = NS.Data.Professions or {}

NS.Data.Professions["Blacksmithing"] = NS.Data.Professions["Blacksmithing"] or {}

NS.Data.Professions["Blacksmithing"]["Khaz"] = {
  {decorID=1260, title="Rusting Bolted Bench", decorType="Seating", source={type="profession", profession="Blacksmithing", expansion="Khaz", skillID=1259675, skillLevel=75, itemID=245312}, reagents={{itemID=248012, count=15}, {itemID=222417, count=5}, {itemID=221853, count=4}}},
  {decorID=1270, title="Shredderwheel Storage Chest", decorType="Storage", source={type="profession", profession="Blacksmithing", expansion="Khaz", skillID=1259681, skillLevel=75, itemID=245323}, reagents={{itemID=248012, count=30}, {itemID=222523, count=1}, {itemID=222420, count=1}, {itemID=222417, count=5}, {itemID=221856, count=1}}},
}
