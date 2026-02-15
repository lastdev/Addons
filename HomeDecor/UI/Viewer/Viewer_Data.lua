local ADDON, NS = ...

NS.UI = NS.UI or {}
local View = NS.UI.Viewer
if not View then return end

local Data = View.Data
if not Data then return end

local DecorIndex = NS.Systems and NS.Systems.DecorIndex
local NPCNames = NS.Systems and NS.Systems.NPCNames

Data.TEX_ALLI  = "Interface\\Icons\\INV_BannerPVP_02"
Data.TEX_HORDE = "Interface\\Icons\\INV_BannerPVP_01"

local EXPANSION_RANK = {
  Classic = 1,

  BurningCrusade = 2, ["Burning Crusade"] = 2, Outland = 2,
  Wrath = 3, ["Wrath of the Lich King"] = 3, Northrend = 3,
  Cataclysm = 4, Cata = 4,
  Pandaria = 5, MistsOfPandaria = 5, ["Mists of Pandaria"] = 5, Pandaren = 5,
  WarlordsOfDraenor = 6, ["Warlords of Draenor"] = 6, Draenor = 6,
  Legion = 7,
  BattleForAzeroth = 8, ["Battle for Azeroth"] = 8, Kul = 8,
  Shadowlands = 9,
  Dragonflight = 10, Dragon = 10,
  WarWithin = 11, TheWarWithin = 11, ["The War Within"] = 11, Khaz = 11,
}

local function ExpansionRank(name)
  if not name then return 999 end
  return EXPANSION_RANK[name] or 999
end

function Data.GetExpansionOrder(t)
  local order = {}
  if type(t) ~= "table" then return order end
  for k in pairs(t) do order[#order + 1] = k end
  table.sort(order, function(a, b)
    local ra, rb = ExpansionRank(a), ExpansionRank(b)
    if ra ~= rb then return ra < rb end
    return tostring(a) < tostring(b)
  end)
  return order
end

local DecorIconCache, DecorNameCache = {}, {}
local AchTitleCache, QuestTitleCache = {}, {}
local VendorPickCache = {}

local function CleanVendorTitle(s)
  if type(s) ~= "string" then return nil end
  s = s:gsub("^%s+", ""):gsub("%s+$", "")
  if s == "" then return nil end
  if s:match("^%d+$") then return nil end
  return s
end

function Data.ResolveVendorTitle(vendor, refreshCallback)
  if type(vendor) ~= "table" then return nil end

  local t = CleanVendorTitle(vendor.title or vendor.name)
  if t then return t end

  local src = vendor.source or {}
  local id = tonumber((src and src.id) or vendor.npcID or vendor.id)
  if not id then return nil end

  if NPCNames and NPCNames.Get then
    local name = NPCNames.Get(id, function(npcID, resolvedName)

      if refreshCallback and type(refreshCallback) == "function" then
        refreshCallback(npcID, resolvedName)
      end
    end)
    name = CleanVendorTitle(name)
    if name then return name end
  end

  return nil
end

function Data.PrefetchVendorNames(vendors)
  if not NPCNames or not NPCNames.PrefetchVendors then return end
  NPCNames.PrefetchVendors(vendors)
end

local function VendorFaction(v)
  if type(v) ~= "table" then return nil end
  local src = v.source or {}
  local f = v.faction or src.faction
  if f == "Alliance" or f == "Horde" then return f end
  if f == "Neutral" then return "Neutral" end
  return nil
end

local function VendorKeyFromCtx(decorID, expName, zoneKey, desiredFaction)
  return tostring(expName) .. "\031" .. tostring(zoneKey) .. "\031" .. tostring(decorID) .. "\031" .. tostring(desiredFaction or "")
end

local function PickVendorFromZoneData(decorID, expName, zoneKey, desiredFaction)
  if not decorID or not expName or not zoneKey then return nil end

  local k = VendorKeyFromCtx(decorID, expName, zoneKey, desiredFaction)
  local cached = VendorPickCache[k]
  if cached ~= nil then
    if cached == false then return nil end
    return cached.vendor, cached.item
  end

  local vendorsByExp = NS.Data and NS.Data.Vendors and NS.Data.Vendors[expName]
  local list = vendorsByExp and vendorsByExp[zoneKey]
  if type(list) ~= "table" then
    VendorPickCache[k] = false
    return nil
  end

  local bestVendor, bestItem, bestScore = nil, nil, -1
  for _, v in ipairs(list) do
    local items = v and v.items
    if type(items) == "table" then
      local f = VendorFaction(v)
      local facScore = 0
      if desiredFaction and f == desiredFaction then
        facScore = 2
      elseif f == "Neutral" then
        facScore = 1
      end

      if facScore >= bestScore then
        for _, vi in ipairs(items) do
          if vi and vi.decorID == decorID then
            if facScore > bestScore or not bestVendor then
              bestScore = facScore
              bestVendor = v
              bestItem = vi
            end
            if bestScore == 2 then break end
          end
        end
      end
    end
    if bestScore == 2 then break end
  end

  if bestVendor then
    VendorPickCache[k] = { vendor = bestVendor, item = bestItem }
    return bestVendor, bestItem
  end

  VendorPickCache[k] = false
  return nil
end

function Data.SlimVendor(v)
  if type(v) ~= "table" then return nil end
  local src = v.source
  return {
    title    = v.title,
    name     = v.name,
    zone     = v.zone or (src and src.zone),
    faction  = v.faction or (src and src.faction),
    worldmap = v.worldmap or (src and src.worldmap),
    source   = src,
  }
end

function Data.GetDecorIcon(decorID)
  if not decorID then return end
  if DecorIconCache[decorID] ~= nil then return DecorIconCache[decorID] or nil end

  if not (C_HousingCatalog and C_HousingCatalog.GetCatalogEntryInfoByRecordID) then
    DecorIconCache[decorID] = false
    return
  end

  local info = C_HousingCatalog.GetCatalogEntryInfoByRecordID(1, decorID, true)
  local icon = info and info.iconTexture
  if icon then
    DecorIconCache[decorID] = icon
    return icon
  end

  DecorIconCache[decorID] = false
end

function Data.GetDecorName(decorID)
  if not decorID then return end
  if DecorNameCache[decorID] ~= nil then return DecorNameCache[decorID] or nil end

  if not (C_HousingCatalog and C_HousingCatalog.GetCatalogEntryInfoByRecordID) then
    DecorNameCache[decorID] = false
    return
  end

  local info = C_HousingCatalog.GetCatalogEntryInfoByRecordID(1, decorID, true)
  local n = info and info.name
  if type(n) == "string" and n ~= "" then
    DecorNameCache[decorID] = n
    return n
  end

  DecorNameCache[decorID] = false
end

local CategoryBreadcrumbCache = {}

local function _trim(s)
  if type(s) ~= "string" then return nil end
  s = s:gsub("^%s+", ""):gsub("%s+$", "")
  if s == "" then return nil end
  return s
end

local function _extractIDs(entry)
  if type(entry) ~= "table" then return nil, nil end

  local catID = entry.categoryID or entry.categoryId
  local subID = entry.subcategoryID or entry.subcategoryId

  if not catID and type(entry.categoryIDs) == "table" then
    catID = entry.categoryIDs[1]
  end

  if not subID and type(entry.subcategoryIDs) == "table" then
    subID = entry.subcategoryIDs[1]
  end

  if not catID and type(entry.category) == "table" then
    catID = entry.category.ID or entry.category.id or entry.category.categoryID
  end
  if not subID and type(entry.subcategory) == "table" then
    subID = entry.subcategory.ID or entry.subcategory.id or entry.subcategory.subcategoryID
  end

  catID = tonumber(catID)
  subID = tonumber(subID)
  return catID, subID
end

function Data.GetDecorBreadcrumbFromCatalog(decorID)
  if not decorID then return nil, nil, nil, nil, nil end
  
  if CategoryBreadcrumbCache[decorID] then
    local cached = CategoryBreadcrumbCache[decorID]
    return cached.catID, cached.subID, cached.breadcrumb, cached.catName, cached.subName
  end

  if not (C_HousingCatalog and C_HousingCatalog.GetCatalogEntryInfoByRecordID) then
    CategoryBreadcrumbCache[decorID] = { breadcrumb = nil }
    return nil, nil, nil, nil, nil
  end

  local info = C_HousingCatalog.GetCatalogEntryInfoByRecordID(1, decorID, true)
  if not info then
    CategoryBreadcrumbCache[decorID] = { breadcrumb = nil }
    return nil, nil, nil, nil, nil
  end

  local catID, subID = _extractIDs(info)
  local catName, subName

  if subID and C_HousingCatalog.GetCatalogSubcategoryInfo then
    local subInfo = C_HousingCatalog.GetCatalogSubcategoryInfo(subID)
    if type(subInfo) == "table" then
      subName = _trim(subInfo.name)
      if not catID then
        catID = tonumber(subInfo.categoryID or subInfo.categoryId)
        if not catID and type(subInfo.category) == "table" then
          catID = tonumber(subInfo.category.ID or subInfo.category.id)
        end
      end
    end
  end

  if catID and C_HousingCatalog.GetCatalogCategoryInfo then
    local catInfo = C_HousingCatalog.GetCatalogCategoryInfo(catID)
    if type(catInfo) == "table" then
      catName = _trim(catInfo.name)
    end
  end

  local breadcrumb
  if catName and subName then
    breadcrumb = catName .. " > " .. subName
  elseif catName then
    breadcrumb = catName
  elseif subName then
    breadcrumb = subName
  end

  CategoryBreadcrumbCache[decorID] = {
    catID = catID,
    subID = subID,
    breadcrumb = breadcrumb,
    catName = catName,
    subName = subName
  }

  return catID, subID, breadcrumb, catName, subName
end

function Data.DecorBreadcrumbFrom(it)
  if type(it) ~= "table" then return nil, nil, nil, nil, nil end

  if it.decorID then
    local catID, subID, crumb, catName, subName = Data.GetDecorBreadcrumbFromCatalog(it.decorID)
    if crumb then return catID, subID, crumb, catName, subName end
  end

  local raw = _trim(it.decorType)
  if raw then
    return nil, nil, raw, nil, nil
  end

  return nil, nil, nil, nil, nil
end

function Data.ApplyDecorBreadcrumb(it)
  if type(it) ~= "table" then return end
  local catID, subID, crumb, catName, subName = Data.DecorBreadcrumbFrom(it)
  it.catalogCategoryID = catID
  it.catalogSubcategoryID = subID
  it.catalogCategoryName = catName
  it.catalogSubcategoryName = subName
  it.decorTypeBreadcrumb = crumb
end

function Data.GetAchievementTitle(id)
  id = tonumber(id)
  if not id then return end
  if AchTitleCache[id] ~= nil then return AchTitleCache[id] or nil end

  if not GetAchievementInfo then
    AchTitleCache[id] = false
    return
  end

  local name = select(2, GetAchievementInfo(id))
  if name and name ~= "" then
    AchTitleCache[id] = name
    return name
  end

  AchTitleCache[id] = false
end

function Data.GetQuestTitle(id)
  id = tonumber(id)
  if not id then return end
  if QuestTitleCache[id] ~= nil then return QuestTitleCache[id] or nil end

  if C_QuestLog and C_QuestLog.RequestLoadQuestByID then
    C_QuestLog.RequestLoadQuestByID(id)
  end

  local name
  if C_QuestLog and C_QuestLog.GetTitleForQuestID then
    name = C_QuestLog.GetTitleForQuestID(id)
  end

  if name and name ~= "" then
    QuestTitleCache[id] = name
    return name
  end

  QuestTitleCache[id] = false
end

function Data.NormalizeExpansionNode(expNode)
  if type(expNode) ~= "table" then return {} end

  local isArray, count = true, 0
  for k in pairs(expNode) do
    if type(k) ~= "number" then isArray = false break end
    count = count + 1
  end

  if isArray and count > 0 then
    return { ["ALL"] = expNode }
  end

  return expNode
end

function Data.PickDecorIndexVendor(entry, ui, db)
  if type(entry) ~= "table" then return nil end

  local vendors = entry.vendors or (entry.vendor and { entry.vendor }) or {}
  local f = db and db.filters or {}
  local wantFaction = f.faction
  local wantZone = f.zone

  local function matches(v)
    if type(v) ~= "table" then return false end
    local src = v.source or {}
    local vf = v.faction or src.faction or "Neutral"
    local vz = v.zone or src.zone

    if wantFaction and wantFaction ~= "ALL" and vf ~= "Neutral" and vf ~= wantFaction then
      return false
    end
    if wantZone and wantZone ~= "ALL" and vz and vz ~= wantZone then
      return false
    end
    return true
  end

  for _, v in ipairs(vendors) do
    if matches(v) then return v end
  end

  return entry.vendor or vendors[1]
end

function Data.HydrateFromDecorIndex(it, ui, db)
  if not DecorIndex or not it or not it.decorID then return it end

  local entry = DecorIndex[it.decorID]
  if not entry or not entry.item then return it end

  local vitem = entry.item
  it.title = it.title or vitem.title
  it.decorType = it.decorType or vitem.decorType

  local itemID = (vitem.source and vitem.source.itemID) or vitem.itemID
  it.source = it.source or {}
  if itemID then
    it.itemID = it.itemID or itemID
    it.source.itemID = it.source.itemID or itemID
  end

  local bestVendor = Data.PickDecorIndexVendor(entry, ui, db)
  local slim = Data.SlimVendor(bestVendor)
  if slim then
    it.vendor = it.vendor or slim
    it._navVendor = it._navVendor or slim
  end

  Data.ApplyDecorBreadcrumb(it)

  return it
end

function Data.AttachVendorCtx(it, vendor)
  if type(it) ~= "table" or type(vendor) ~= "table" then return it end

  it._navVendor = vendor
  it.vendor = vendor

  local vsrc = vendor.source or {}

  local vf = vendor.faction or vsrc.faction
  if vf == "Alliance" or vf == "Horde" then
    it.faction = vf
    it.source = it.source or {}
    it.source.faction = vf
  end

  local vz = vendor.zone or vsrc.zone
  if vz then
    it.zone = vz
    it.source = it.source or {}
    it.source.zone = it.source.zone or vz
  end

  local vm = vendor.worldmap or vsrc.worldmap
  if vm then
    it.worldmap = vm
    it.source = it.source or {}
    it.source.worldmap = it.source.worldmap or vm
  end

  local vid = vsrc.id
  if vid then
    it.npcID = vid
    it.source = it.source or {}
    it.source.npcID = it.source.npcID or vid
  end

  return it
end

function Data.ResolveAchievementDecor(it)
  if not it or not it.decorID or not DecorIndex then return it end

  local st = it.source and it.source.type
  if st ~= "achievement" and st ~= "quest" and st ~= "pvp" then return it end

  local entry = DecorIndex[it.decorID]
  if not entry then return it end

  local resolved = {}
  for k, v in pairs(it) do resolved[k] = v end

  resolved.source = resolved.source or {}
  if it.source then
    for k, v in pairs(it.source) do resolved.source[k] = v end
  end

  local item = entry.item
  if item then
    resolved.title = item.title or resolved.title
    resolved.decorType = item.decorType or resolved.decorType
  end

  local desiredFaction = resolved.faction or (resolved.source and resolved.source.faction)
  if desiredFaction ~= "Alliance" and desiredFaction ~= "Horde" then
    local pf = UnitFactionGroup and UnitFactionGroup("player")
    if pf == "Alliance" or pf == "Horde" then desiredFaction = pf else desiredFaction = nil end
  end

  local picked, pickedItem
  local expName = resolved._expansion
  local zoneKey = resolved._navZoneKey
  if expName and zoneKey then
    picked, pickedItem = PickVendorFromZoneData(resolved.decorID, expName, zoneKey, desiredFaction)
  end

  local vendors = entry.vendors or (entry.vendor and { entry.vendor }) or {}

  if not picked and desiredFaction and type(vendors) == "table" then
    for _, v in ipairs(vendors) do
      if VendorFaction(v) == desiredFaction then
        picked = v
        break
      end
    end
  end

  picked = picked or entry.vendor or vendors[1]

  local vsrc = picked and picked.source
  if vsrc then
    if vsrc.id then
      resolved.npcID = resolved.npcID or vsrc.id
      resolved.source.npcID = resolved.source.npcID or vsrc.id
    end
    if vsrc.worldmap then
      resolved.worldmap = resolved.worldmap or vsrc.worldmap
      resolved.source.worldmap = resolved.source.worldmap or vsrc.worldmap
    end
    if vsrc.zone then
      resolved.zone = resolved.zone or vsrc.zone
      resolved.source.zone = resolved.source.zone or vsrc.zone
    end
    if vsrc.faction then
      resolved.faction = resolved.faction or vsrc.faction
      resolved.source.faction = resolved.source.faction or vsrc.faction
    end
  end

  local itemID
  if pickedItem and pickedItem.source and pickedItem.source.itemID then
    itemID = pickedItem.source.itemID
  elseif item and item.source and item.source.itemID then
    itemID = item.source.itemID
  end
  if itemID then
    resolved.itemID = resolved.itemID or itemID
    resolved.source.itemID = resolved.source.itemID or itemID
  end

  if resolved.source.type == "achievement" then
    local ach = item and item.requirements and item.requirements.achievement
    if ach then
      resolved.source.id = resolved.source.id or ach.id
      resolved.source.name = resolved.source.name or Data.GetAchievementTitle(ach.id) or ach.title
    end
  elseif resolved.source.type == "quest" then
    local q = (item and item.requirements and item.requirements.quest)
      or (pickedItem and pickedItem.requirements and pickedItem.requirements.quest)
      or (picked and picked.requirements and picked.requirements.quest)
    if q then
      resolved.source.id = resolved.source.id or q.id
      resolved.source.questID = resolved.source.questID or q.id
      resolved.source.name = resolved.source.name or Data.GetQuestTitle(q.id) or q.title
    end
  end

  local slim = Data.SlimVendor(picked) or picked or entry.vendor
  resolved.vendor = slim
  resolved._navVendor = slim

  Data.ApplyDecorBreadcrumb(resolved)

  return resolved
end

Data.CATEGORY_MAP = {
  ["Achievements"] = "Achievements",
  ["Quests"]       = "Quests",
  ["Vendors"]      = "Vendors",
  ["Drops"]        = "Drops",
  ["Professions"]  = "Professions",
  ["PvP"]          = "PvP",
  ["PVP"]          = "PvP",
}

function Data.GetActiveData(ui)
  ui = ui or {}
  local key = Data.CATEGORY_MAP[ui.activeCategory]
  if not key or not NS.Data then return nil end

  local t = NS.Data[key]
  if t ~= nil then return t end

  if key == "PvP" then
    return NS.Data.PvP or NS.Data.PVP or NS.Data.Pvp or NS.Data.pvp
  end
  return nil
end

function Data.KeyExp(cat, exp) return tostring(cat) .. ":exp:" .. tostring(exp) end
function Data.KeyZone(cat, exp, zone) return tostring(cat) .. ":zone:" .. tostring(exp) .. ":" .. tostring(zone) end
function Data.KeyVendor(cat, exp, zone, vendorID)
  return tostring(cat) .. ":vendor:" .. tostring(exp) .. ":" .. tostring(zone) .. ":" .. tostring(vendorID)
end

return Data