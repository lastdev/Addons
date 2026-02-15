local ADDON, NS = ...

local Filters = {}
NS.Systems = NS.Systems or {}
NS.Systems.Filters = Filters

local Collection = NS.Systems and NS.Systems.Collection

local tinsert, tconcat, sort = table.insert, table.concat, table.sort
local type, tostring, tonumber = type, tostring, tonumber
local lower = string.lower
local pairs, ipairs, pcall = pairs, ipairs, pcall
local wipe = _G.wipe or function(t) for k in pairs(t) do t[k] = nil end end

local DyeableCache = {}

local function IsItemDyeable(decorID)
  if not decorID then return false end

  if DyeableCache[decorID] ~= nil then
    return DyeableCache[decorID]
  end

  local HC = _G.C_HousingCatalog
  if HC and HC.GetCatalogEntryInfoByRecordID then
    local ok, info = pcall(HC.GetCatalogEntryInfoByRecordID, 1, decorID, true)
    if ok and info then
      local isDyeable = info.canCustomize == true
      DyeableCache[decorID] = isDyeable
      return isDyeable
    end
  end

  DyeableCache[decorID] = false
  return false
end

local DEFAULTS = {
  hideCollected = false,
  onlyCollected = false,
  expansion     = "ALL",
  zone          = "ALL",
  faction       = "ALL",
  category      = "ALL",
  subcategory   = "ALL",
}

local Tax = {
  built = false,
  cats = {},
  catList = {},
  subcats = {},
  subByCat = {},
  nameToCatID = {},
  nameToSubID = {},
  itemCache = {},
}

local function _apiReady()
  return _G.C_HousingCatalog
     and _G.C_HousingCatalog.SearchCatalogCategories
     and _G.C_HousingCatalog.GetCatalogCategoryInfo
end

local function _orderIndex(info)
  local v = info and info.orderIndex
  if type(v) == "number" then return v end
  return 999999
end

local function _safeName(info)
  local n = info and info.name
  if type(n) == "string" and n ~= "" then return n end
  return ""
end

local function _addSubToCat(catID, subInfo)
  if not catID or not subInfo then return end
  local t = Tax.subByCat[catID]
  if not t then
    t = {}
    Tax.subByCat[catID] = t
  end
  tinsert(t, subInfo)
end

function Filters:BuildTaxonomyCache(force)
  if Tax.built and not force then return end

  Tax.built = false
  wipe(Tax.cats); wipe(Tax.catList); wipe(Tax.subcats); wipe(Tax.subByCat)
  wipe(Tax.nameToCatID); wipe(Tax.nameToSubID)
  wipe(Tax.itemCache)

  if not _apiReady() then return end

  local ctx = _G.Enum and _G.Enum.HouseEditorMode and _G.Enum.HouseEditorMode.BasicDecor or nil

  local catIDs = _G.C_HousingCatalog.SearchCatalogCategories({
    withOwnedEntriesOnly = false,
    editorModeContext = ctx,
  }) or {}

  for _, catID in ipairs(catIDs) do
    local info = _G.C_HousingCatalog.GetCatalogCategoryInfo(catID)
    if info then
      Tax.cats[catID] = info
      tinsert(Tax.catList, info)

      local ln = lower(_safeName(info))
      if ln ~= "" then Tax.nameToCatID[ln] = catID end

      if type(info.subcategoryIDs) == "table" then
        for _, sid in ipairs(info.subcategoryIDs) do
          local sinfo = _G.C_HousingCatalog.GetCatalogSubcategoryInfo and _G.C_HousingCatalog.GetCatalogSubcategoryInfo(sid)
          if sinfo then
            Tax.subcats[sid] = sinfo
            local sln = lower(_safeName(sinfo))
            if sln ~= "" then Tax.nameToSubID[sln] = sid end
            _addSubToCat(catID, sinfo)
          end
        end
      end
    end
  end

  if _G.C_HousingCatalog.SearchCatalogSubcategories and _G.C_HousingCatalog.GetCatalogSubcategoryInfo then
    local subIDs = _G.C_HousingCatalog.SearchCatalogSubcategories({
      withOwnedEntriesOnly = false,
      editorModeContext = ctx,
    }) or {}

    for _, sid in ipairs(subIDs) do
      if not Tax.subcats[sid] then
        local sinfo = _G.C_HousingCatalog.GetCatalogSubcategoryInfo(sid)
        if sinfo then
          Tax.subcats[sid] = sinfo
          local sln = lower(_safeName(sinfo))
          if sln ~= "" then Tax.nameToSubID[sln] = sid end

          local parent = sinfo.parentCategoryID or sinfo.categoryID or sinfo.categoryId
          if not parent and type(sinfo.categoryIDs) == "table" then parent = sinfo.categoryIDs[1] end
          if not parent and type(sinfo.categories) == "table" then
            local v = sinfo.categories[1]
            if type(v) == "number" then parent = v
            elseif type(v) == "table" then parent = v.ID or v.id or v.categoryID end
          end
          _addSubToCat(parent, sinfo)
        end
      end
    end
  end

  sort(Tax.catList, function(a,b)
    local oa, ob = _orderIndex(a), _orderIndex(b)
    if oa ~= ob then return oa < ob end
    return _safeName(a) < _safeName(b)
  end)

  for _, list in pairs(Tax.subByCat) do
    sort(list, function(a,b)
      local oa, ob = _orderIndex(a), _orderIndex(b)
      if oa ~= ob then return oa < ob end
      return _safeName(a) < _safeName(b)
    end)
  end

  Tax.built = true
end

function Filters:ResolveCategoryID(v)
  if v == nil or v == "ALL" then return "ALL" end
  if type(v) == "number" then return v end
  if type(v) == "string" then
    self:BuildTaxonomyCache(false)
    local id = Tax.nameToCatID[lower(v)]
    return id or "ALL"
  end
  return "ALL"
end

function Filters:ResolveSubcategoryID(v)
  if v == nil or v == "ALL" then return "ALL" end
  if type(v) == "number" then return v end
  if type(v) == "string" then
    self:BuildTaxonomyCache(false)
    local id = Tax.nameToSubID[lower(v)]
    return id or "ALL"
  end
  return "ALL"
end

function Filters:GetCategoryOptions()
  self:BuildTaxonomyCache(false)
  local out = { { value = "ALL", text = "All Categories" } }
  if not Tax.built or #Tax.catList == 0 then return out end
  tinsert(out, { separator = true })
  for _, info in ipairs(Tax.catList) do
    local id = info.ID or info.id or info.categoryID or info.categoryId or info.ID
    local name = _safeName(info)
    if id and name ~= "" then
      tinsert(out, { value = id, text = name })
    end
  end
  return out
end

function Filters:GetSubcategoryOptions(catValue)
  self:BuildTaxonomyCache(false)
  local out = { { value = "ALL", text = "All Subcategories" } }
  if not Tax.built then return out end

  local catID = self:ResolveCategoryID(catValue)
  local list = nil

  if catID ~= "ALL" then
    list = Tax.subByCat[catID]
  end

  if not list then
    list = {}
    for _, sinfo in pairs(Tax.subcats) do tinsert(list, sinfo) end
    sort(list, function(a,b)
      local oa, ob = _orderIndex(a), _orderIndex(b)
      if oa ~= ob then return oa < ob end
      return _safeName(a) < _safeName(b)
    end)
  end

  if #list == 0 then return out end
  tinsert(out, { separator = true })

  for _, sinfo in ipairs(list) do
    local id = sinfo.ID or sinfo.id or sinfo.subcategoryID or sinfo.subcategoryId
    local name = _safeName(sinfo)
    if id and name ~= "" then
      tinsert(out, { value = id, text = name })
    end
  end

  return out
end

local function _itemIDFrom(it)
  if not it then return nil end
  if type(it.itemID) == "number" then return it.itemID end
  if it.source and type(it.source.itemID) == "number" then return it.source.itemID end
  if it.source and type(it.source.itemId) == "number" then return it.source.itemId end
  return nil
end

function Filters:ResolveItemTaxonomy(it)
  local itemID = _itemIDFrom(it)
  if not itemID then return nil, nil end

  local cached = Tax.itemCache[itemID]
  if cached then return cached.catID, cached.subID end

  if not _G.C_HousingCatalog or not _G.C_HousingCatalog.GetCatalogEntryInfoByItem then
    Tax.itemCache[itemID] = { catID = nil, subID = nil }
    return nil, nil
  end

  local entry = _G.C_HousingCatalog.GetCatalogEntryInfoByItem(itemID, true)
  local info = entry

  if entry and _G.C_HousingCatalog.GetCatalogEntryInfo then
    local ok, full = pcall(_G.C_HousingCatalog.GetCatalogEntryInfo, entry)
    if ok and full then info = full end
  end

  local catID = info and (info.categoryID or info.categoryId)
  if not catID and info and type(info.categoryIDs) == "table" then catID = info.categoryIDs[1] end
  if not catID and info and type(info.categories) == "table" then
    local v = info.categories[1]
    if type(v) == "number" then catID = v
    elseif type(v) == "table" then catID = v.ID or v.id end
  end

  local subID = info and (info.subcategoryID or info.subcategoryId)
  if not subID and info and type(info.subcategoryIDs) == "table" then subID = info.subcategoryIDs[1] end
  if not subID and info and type(info.subcategories) == "table" then
    local v = info.subcategories[1]
    if type(v) == "number" then subID = v
    elseif type(v) == "table" then subID = v.ID or v.id end
  end

  Tax.itemCache[itemID] = { catID = catID, subID = subID }
  return catID, subID
end

local CATEGORY_MAP = {
  Achievements = "Achievements",
  Quests       = "Quests",
  Vendors      = "Vendors",
  Drops        = "Drops",
  Professions  = "Professions",
  PvP          = "PvP",
  PVP          = "PvP",
}

local DecorNameCache = {}
local ViewerData = NS.UI and NS.UI.Viewer and NS.UI.Viewer.Data

local function GetDecorName(decorID)
  decorID = tonumber(decorID)
  if not decorID then return nil end

  local v = DecorNameCache[decorID]
  if v ~= nil then return v or nil end

  local api = _G.C_HousingCatalog and _G.C_HousingCatalog.GetCatalogEntryInfoByRecordID
  if not api then DecorNameCache[decorID] = false; return nil end

  local info = api(1, decorID, true)
  local n = info and info.name
  if type(n) == "string" and n ~= "" then
    DecorNameCache[decorID] = n
    return n
  end

  DecorNameCache[decorID] = false
  return nil
end

local function Ensure(db)
  if not db then return end
  local f = db.filters
  if not f then f = {}; db.filters = f end
  for k, v in pairs(DEFAULTS) do
    if f[k] == nil then f[k] = v end
  end
  if f.decorTypes == nil then f.decorTypes = {} end
end

function Filters:EnsureDefaults(db) Ensure(db) end

function Filters:GetCategoryForDecorType(decorType)
  if not decorType or decorType == "" then return "Uncategorized" end
  return self.DecorTypeToCategory and (self.DecorTypeToCategory[decorType] or "Uncategorized") or "Uncategorized"
end

function Filters:GetActiveData(ui)
  local key = ui and CATEGORY_MAP[ui.activeCategory]
  return key and NS.Data and NS.Data[key] or nil
end

function Filters:GetExpansions()
  local out, seen = { { value = "ALL", text = "All" } }, {}
  for _, cat in pairs(NS.Data or {}) do
    if type(cat) == "table" then
      for exp in pairs(cat) do
        if not seen[exp] then
          seen[exp] = true
          out[#out + 1] = { value = exp, text = exp }
        end
      end
    end
  end
  sort(out, function(a, b) return tostring(a.text) < tostring(b.text) end)
  return out
end

function Filters:GetZones(ui, db)
  Ensure(db)
  local out, seen = { { value = "ALL", text = "All Zones" } }, {}

  local function add(z)
    if type(z) == "string" and z ~= "" and not seen[z] then
      seen[z] = true
      out[#out + 1] = { value = z, text = z }
    end
  end

  local function sortOut()
    sort(out, function(a, b) return tostring(a.text) < tostring(b.text) end)
    return out
  end

  if ui and ui.activeCategory == "Vendors" then
    local vendors = NS.Data and NS.Data.Vendors
    local exp = (db and db.filters and db.filters.expansion) or "ALL"

    local function scanExp(expTbl)
      for _, zoneTbl in pairs(expTbl or {}) do
        for _, vendor in ipairs(zoneTbl or {}) do
          local src = type(vendor) == "table" and vendor.source
          if src then add(src.zone) end
        end
      end
    end

    if type(vendors) == "table" then
      if exp ~= "ALL" and type(vendors[exp]) == "table" then
        scanExp(vendors[exp])
      else
        for _, expTbl in pairs(vendors) do
          if type(expTbl) == "table" then scanExp(expTbl) end
        end
      end
    end

    return sortOut()
  end

  local data = self:GetActiveData(ui)
  local expFilter = (db and db.filters and db.filters.expansion) or "ALL"

  local function scanData(tbl)
    for zone in pairs(tbl or {}) do add(zone) end
  end

  if type(data) == "table" then
    if expFilter ~= "ALL" then
      scanData(data[expFilter])
    else
      for _, expTbl in pairs(data) do scanData(expTbl) end
    end
    return sortOut()
  end

  for _, catTbl in pairs(NS.Data or {}) do
    if type(catTbl) == "table" then
      for _, expTbl in pairs(catTbl) do
        scanData(expTbl)
      end
    end
  end

  return sortOut()
end

function Filters:GetCategories()
  local out = { { value = "ALL", text = "All" } }
  for _, c in ipairs(self.Categories or {}) do
    out[#out + 1] = { value = c.id, text = c.label or c.id }
  end
  return out
end

function Filters:GetSubcategories(f)
  local out = { { value = "ALL", text = "All" } }
  local cat = f and f.category
  if cat and cat ~= "ALL" then
    local subs = (self.Subcategories and self.Subcategories[cat]) or {}
    for _, s in ipairs(subs) do
      out[#out + 1] = { value = s, text = s }
    end
  end
  return out
end

local function addText(parts, v)
  if type(v) == "string" then
    if v ~= "" then parts[#parts + 1] = lower(v) end
  elseif v ~= nil then
    parts[#parts + 1] = lower(tostring(v))
  end
end

local SEARCH_CACHE_VER = 1

local function getItemSearchText(self, it, ui)
  if it._hdSearchCache and it._hdSearchCacheVer == SEARCH_CACHE_VER then
    return it._hdSearchCache
  end

  local txt = self:BuildSearchText(it, ui)
  txt = (type(txt) == "string" and txt ~= "") and lower(txt) or ""

  it._hdSearchCache = txt
  it._hdSearchCacheVer = SEARCH_CACHE_VER
  return txt
end

function Filters:PrepareSearch(ui)
  ui = ui or {}

  local q = (type(ui.search) == "string" and ui.search) or ""
  q = lower(q):gsub("^%s+", ""):gsub("%s+$", "")

  ui._searchNorm = q
  ui._searchTokens = ui._searchTokens or {}
  wipe(ui._searchTokens)

  if q ~= "" then
    for token in q:gmatch("%S+") do

      if #token >= 2 then
        tinsert(ui._searchTokens, token)
      end
    end
  end

  ui._searchLast = ui.search
end

function Filters:DebouncedSetSearch(ui, newText, onApply, delay)
  ui = ui or {}
  ui.search = newText or ""

  delay = tonumber(delay) or 0.14

  ui._hdSearchGen = (ui._hdSearchGen or 0) + 1
  local gen = ui._hdSearchGen

  if not (_G.C_Timer and _G.C_Timer.After) then
    self:PrepareSearch(ui)
    if onApply then onApply() end
    return
  end

  _G.C_Timer.After(delay, function()
    if ui._hdSearchGen ~= gen then return end
    self:PrepareSearch(ui)
    if onApply then onApply() end
  end)
end

function Filters:WarmSearchCache(items, ui, msBudget)
  if type(items) ~= "table" then return end
  ui = ui or {}
  msBudget = tonumber(msBudget) or 8

  local i, n = 1, #items
  local function step()
    local start = _G.debugprofilestop and _G.debugprofilestop() or 0
    while i <= n do
      getItemSearchText(self, items[i], ui)
      i = i + 1
      if _G.debugprofilestop and (_G.debugprofilestop() - start) > msBudget then
        if _G.C_Timer and _G.C_Timer.After then
          _G.C_Timer.After(0, step)
        end
        return
      end
    end
  end
  step()
end

function Filters:BuildSearchText(it, ui)
  ui = ui or {}
  local parts = {}

  addText(parts, it.title)

  local dn = GetDecorName(it.decorID)
  if dn then addText(parts, dn) end

  addText(parts, it.decorID)
  addText(parts, it.source and it.source.itemID)
  addText(parts, it.requirements and it.requirements.quest and it.requirements.quest.id)
  addText(parts, it.requirements and it.requirements.achievement and it.requirements.achievement.id)

  local qid =
      (it.requirements and it.requirements.quest and it.requirements.quest.id)
      or (it.quest and it.quest.id)
      or (it.source and (it.source.questID or it.source.questId))
      or ((it.source and it.source.type == "quest") and (it.source.id or it.source.quest))
  if qid and ViewerData and ViewerData.GetQuestTitle then
    addText(parts, ViewerData.GetQuestTitle(qid))
  end

  local aid =
      (it.requirements and it.requirements.achievement and it.requirements.achievement.id)
      or (it.achievement and it.achievement.id)
      or (it.source and (it.source.achievementID or it.source.achievementId))
      or ((it.source and it.source.type == "achievement") and (it.source.id or it.source.achievement))
  if aid and ViewerData and ViewerData.GetAchievementTitle then
    addText(parts, ViewerData.GetAchievementTitle(aid))
  end

  local sid = it.source and (it.source.id or it.source.npcID or it.source.npcId)
  if sid and ViewerData and ViewerData.GetVendorName then
    addText(parts, ViewerData.GetVendorName(sid))
  end

  addText(parts, it.name)
  addText(parts, it.decorType)
  addText(parts, it.profession)
  addText(parts, it.zone)
  addText(parts, it.expansion)

  local src = it.source
  if src then
    addText(parts, src.type)
    addText(parts, src.id)
    addText(parts, src.npcID or src.npcId)
    addText(parts, src.questID or src.questId)
    addText(parts, src.achievementID or src.achievementId)
    addText(parts, src.title)
    addText(parts, src.name)
    addText(parts, src.zone)
    addText(parts, src.faction)
  end

  local activeCat = ui.activeCategory
  local questCtx = (activeCat == "Quests") or (src and src.type == "quest")
  if not questCtx then
    local v = it.vendor or it._navVendor
    if v then
      addText(parts, v.title)
      addText(parts, v.name)
      addText(parts, v.zone)
      addText(parts, v.faction)
      local vs = v.source
      if vs then
        addText(parts, vs.title)
        addText(parts, vs.name)
        addText(parts, vs.zone)
        addText(parts, vs.faction)
      end
    end
  end

  local ach = it.achievement
  if ach then addText(parts, ach.title); addText(parts, ach.name) end
  local q = it.quest
  if q then addText(parts, q.title); addText(parts, q.name) end

  if it.decorID and IsItemDyeable(it.decorID) then
    addText(parts, "dyeable")
    addText(parts, "dye")
    addText(parts, "customizable")
    addText(parts, "customize")
  end

  return tconcat(parts, " ")
end

function Filters:ResolveFaction(it)
  if not it then return "Neutral" end
  local v = it._navVendor or it.vendor
  local f = (v and (v.faction or (v.source and v.source.faction))) or it.faction or (it.source and it.source.faction)
  return f or "Neutral"
end

local function splitCSV(s)
  local out = {}
  for part in s:gmatch("[^,]+") do
    local v = part:gsub("^%s+", ""):gsub("%s+$", "")
    if v ~= "" then out[#out + 1] = v end
  end
  return out
end

local function matchesValue(val, want)
  if not want or want == "ALL" then return true end
  if val == nil or val == "" then return false end
  val = tostring(val)
  if val:find(",", 1, true) then
    for _, p in ipairs(splitCSV(val)) do
      if p == want then return true end
    end
    return false
  end
  return val == want
end

function Filters:Passes(it, ui, db)
  if not it or not db then return false end
  Ensure(db)

  ui = ui or {}
  local f = db.filters or {}

  local st = it.source and it.source.type
  local isExternalish = (st == "external" or st == "event" or it._isEventTimed or it._isEventHeader)

  if f.faction ~= "ALL" and not isExternalish then
    local fac = tostring(self:ResolveFaction(it) or "Neutral")
    if fac ~= "Neutral" and not matchesValue(fac, f.faction) then return false end
  end

  if f.expansion ~= "ALL" then
    local itExp = it._expansion or it.expansion or (it.source and it.source.expansion)
    if not matchesValue(itExp, f.expansion) then return false end
  end

  if f.zone ~= "ALL" then
    local itZone = it.zone
      or (it.vendor and it.vendor.zone)
      or (it._navVendor and it._navVendor.zone)
      or (it.source and it.source.zone)

    if (not itZone or itZone == "") then
      if not isExternalish then return false end
    else
      if not matchesValue(itZone, f.zone) then return false end
    end
  end

  if f.subcategory ~= "ALL" then
    if type(f.subcategory) == "number" then
      local _, subID = self:ResolveItemTaxonomy(it)
      if subID ~= f.subcategory then return false end
    else
      if tostring(it.decorType or "") ~= tostring(f.subcategory) then return false end
    end
  elseif f.category ~= "ALL" then
    if type(f.category) == "number" then
      local catID = self:ResolveItemTaxonomy(it)
      if catID ~= f.category then return false end
    else
      if self.GetCategoryForDecorType and self:GetCategoryForDecorType(it.decorType) ~= f.category then return false end
    end
  end

  if f.hideCollected and Collection and Collection.IsCollected and Collection:IsCollected(it) then return false end
  if f.onlyCollected and Collection and Collection.IsCollected and not Collection:IsCollected(it) then return false end

  if ui.search ~= ui._searchLast then
    self:PrepareSearch(ui)
  end

  local tokens = ui._searchTokens
  if tokens and #tokens > 0 then
    local txt = getItemSearchText(self, it, ui)
    for i = 1, #tokens do
      if not txt:find(tokens[i], 1, true) then return false end
    end
  end

  return true
end

return Filters