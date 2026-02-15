local ADDON, NS = ...

NS.Data = NS.Data or {}
NS.Data.Professions = NS.Data.Professions or {}

NS.Data.Professions["Blacksmithing"] = NS.Data.Professions["Blacksmithing"] or {}

NS.Data.Professions["Blacksmithing"]["Pandaren"] = {
  {decorID=3892, title="Pandaren Fireplace", decorType="Large Lights", source={type="profession", profession="Blacksmithing", expansion="Pandaren", skillID=1261234, skillLevel=60, itemID=247752}, reagents={{itemID=251763, count=40}, {itemID=76061, count=6}, {itemID=72095, count=35}}},
  {decorID=3831, title="Pandaren Signal Brazier", decorType="Large Lights", source={type="profession", profession="Blacksmithing", expansion="Pandaren", skillID=1261235, skillLevel=60, itemID=247661}, reagents={{itemID=251763, count=25}, {itemID=80433, count=4}, {itemID=72104, count=3}, {itemID=3857, count=5}}},
}
