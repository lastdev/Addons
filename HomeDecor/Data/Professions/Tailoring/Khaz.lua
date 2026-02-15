local ADDON, NS = ...

NS.Data = NS.Data or {}
NS.Data.Professions = NS.Data.Professions or {}

NS.Data.Professions["Tailoring"] = NS.Data.Professions["Tailoring"] or {}

NS.Data.Professions["Tailoring"]["Khaz"] = {
  {decorID=9167, title="Dornogal Framed Rug", decorType="Floor", source={type="profession", profession="Tailoring", expansion="Khaz", skillID=1260215, skillLevel=80, itemID=252755}, reagents={{itemID=248012, count=30}, {itemID=224824, count=6}, {itemID=224764, count=12}, {itemID=222615, count=4}}},
  {decorID=1275, title="Undermine Bean Bag Chair", decorType="Seating", source={type="profession", profession="Tailoring", expansion="Khaz", skillID=1260326, skillLevel=75, itemID=245305}, reagents={{itemID=248012, count=20}, {itemID=224828, count=2}, {itemID=224764, count=20}, {itemID=222804, count=6}}},
}
