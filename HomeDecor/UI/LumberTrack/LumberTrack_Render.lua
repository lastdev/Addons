local ADDON, NS = ...
NS.UI = NS.UI or {}

local R = {}
NS.UI.LumberTrackRender = R

local Utils = NS.LT.Utils

local C_Container = C_Container
local C_Item = C_Item
local GetItemInfo = GetItemInfo
local GetItemInfoInstant = GetItemInfoInstant

local Rows = NS.UI.LumberTrackRows
local MAX_META_CACHE = 150

local function GetItemMeta(itemID)
  if not itemID then return nil end
  local name, link, rarity, level, minLevel, itype, subtype, stack, equip, icon = GetItemInfo(itemID)
  if name and icon then return name, icon end
  if not name and C_Item and C_Item.RequestLoadItemDataByID then
    pcall(C_Item.RequestLoadItemDataByID, itemID)
  end
  local name2, link2, r2, l2, ml2, t2, st2, s2, e2, icon2 = GetItemInfoInstant(itemID)
  return name or name2, icon2
end

local function GetBagLumberCounts(metaCache, lumberIDs)
  local counts, total = {}, 0
  metaCache = metaCache or {}
  lumberIDs = type(lumberIDs) == "table" and lumberIDs or nil

  local function consider(itemID, stackCount)
    if not itemID or itemID <= 0 then return end
    if lumberIDs and not lumberIDs[itemID] then return end

    local m = metaCache[itemID]
    local name, icon = m and m.name, m and m.icon

    if not name then
      name, icon = GetItemMeta(itemID)
      metaCache[itemID] = { name = name, icon = icon }
    end

    if (lumberIDs and lumberIDs[itemID]) or (name and Utils.IsLumberName(name)) then
      local c = tonumber(stackCount) or 1
      counts[itemID] = (counts[itemID] or 0) + c
      total = total + c
    end
  end

  if C_Container and C_Container.GetContainerNumSlots and C_Container.GetContainerItemInfo then
    for bag = 0, 5 do
      local slots = C_Container.GetContainerNumSlots(bag) or 0
      for slot = 1, slots do
        local info = C_Container.GetContainerItemInfo(bag, slot)
        if info and info.itemID then
          consider(info.itemID, info.stackCount)
        end
      end
    end
    return counts, total
  end

  if GetContainerNumSlots and GetContainerItemID and GetContainerItemInfo then
    for bag = 0, 5 do
      local slots = GetContainerNumSlots(bag) or 0
      for slot = 1, slots do
        local itemID = GetContainerItemID(bag, slot)
        if itemID then
          local tex, stackCount = GetContainerItemInfo(bag, slot)
          consider(itemID, stackCount)
        end
      end
    end
  end

  return counts, total
end

function R:Init(ctx)
  ctx = ctx or {}
  ctx.rows = ctx.rows or {}
  ctx.list = ctx.list or {}
  ctx.counts = ctx.counts or {}
  ctx.meta = ctx.meta or {}
  ctx.total = 0
  ctx.goal = tonumber(ctx.goal) or 1000
  ctx.showIcons = ctx.showIcons ~= false
  ctx.hideZero = ctx.hideZero and true or false
  ctx.search = type(ctx.search)=="string" and ctx.search or ""
  ctx.alpha = tonumber(ctx.alpha) or 0.7

  if type(ctx.lumberIDs)~="table" then
    ctx.lumberIDs = {}
    local db = ctx.GetDB and ctx.GetDB()
    if db and type(db.lumberIDs) == "table" then
      for id in pairs(db.lumberIDs) do
        ctx.lumberIDs[id] = true
      end
    end
  end
  
  return ctx
end

local function GetMeta(ctx, itemID)
  local m = ctx.meta[itemID]
  if m then return m.name, m.icon end
  local name, icon = GetItemMeta(itemID)
  if name or icon then ctx.meta[itemID]={ name = name, icon = icon } end
  return name, icon
end

function R:Recount(ctx)
  local counts, total = GetBagLumberCounts(ctx.meta, ctx.lumberIDs)
  local bagCounts = counts or {}

  local AccountWide = NS.UI.LumberTrackAccountWide

  if AccountWide and AccountWide.ScanWarbandBank then
    local warbandCounts = AccountWide:ScanWarbandBank(ctx.lumberIDs)
    if AccountWide.SaveWarbandCounts then
      AccountWide:SaveWarbandCounts(warbandCounts)
    end
    ctx.warbandCounts = warbandCounts
  end

  if AccountWide and AccountWide.SaveCharacterBankLumber then
    AccountWide:SaveCharacterBankLumber(ctx.lumberIDs)
  end

  if AccountWide and AccountWide.IsEnabled and AccountWide:IsEnabled() then
    if AccountWide.SaveCharacterLumber then
      local db = NS.Addon and NS.Addon.db and NS.Addon.db.global
      local accountDB = db and db.lumberTrackAccount
      local charKey = AccountWide:GetCharacterKey()
      if accountDB and accountDB.characterData and accountDB.characterData[charKey] then
        for itemID in pairs(accountDB.characterData[charKey]) do
          if not bagCounts[itemID] then
            bagCounts[itemID] = 0
          end
        end
      end
      AccountWide:SaveCharacterLumber(bagCounts)
    end

    local aggregated = AccountWide:GetAggregatedCounts()
    if aggregated then
      ctx.counts = aggregated
    else
      ctx.counts = bagCounts
    end
    ctx.total = AccountWide:GetTotalCount(counts) or 0
  else
    ctx.counts = bagCounts
    ctx.total = total or 0
  end

  if type(ctx.lumberIDs)~="table" then ctx.lumberIDs={} end
  for itemID in pairs(ctx.counts) do ctx.lumberIDs[itemID]=true end
  for itemID in pairs(ctx.lumberIDs) do
    if ctx.counts[itemID]==nil then ctx.counts[itemID]=0 end
  end

  local db = ctx and ctx.GetDB and ctx.GetDB()
  if type(db)=="table" then db.lumberIDs = ctx.lumberIDs end
  self:CleanMetaCache(ctx)
end

function R:CleanMetaCache(ctx)
  if not ctx.meta then return end
  local metaCount = 0
  for k in pairs(ctx.meta) do metaCount = metaCount+1 end
  if metaCount <= MAX_META_CACHE then return end
  
  local candidates = {}
  for itemID in pairs(ctx.meta) do
    local inBags = ctx.counts and ctx.counts[itemID] and ctx.counts[itemID]>0
    local isKnownLumber = ctx.lumberIDs and ctx.lumberIDs[itemID]
    if not inBags and not isKnownLumber then candidates[#candidates+1]=itemID end
  end
  
  local toRemove = metaCount - math.floor(MAX_META_CACHE * 0.75)
  for i = 1, math.min(toRemove, #candidates) do ctx.meta[candidates[i]]=nil end
end

local function PassFilter(ctx, itemID, name, count)
  local c = tonumber(count) or 0
  if ctx.hideZero and c <= 0 then return false end
  local q = ctx.search
  if q and q~="" then
    local n = Utils.SafeLower(name or "")
    if not n:find(q, 1, true) then return false end
  end
  return true
end

function R:BuildList(ctx)
  Utils.Wipe(ctx.list)
  for itemID, count in pairs(ctx.counts) do
    count = tonumber(count) or 0
    local name = (ctx.meta[itemID] and ctx.meta[itemID].name) or select(1, GetItemMeta(itemID))
    if PassFilter(ctx, itemID, name, count) then ctx.list[#ctx.list+1]=itemID end
  end

  table.sort(ctx.list, function(a, b)
    local ca, cb = ctx.counts[a] or 0, ctx.counts[b] or 0
    if ca ~= cb then return ca > cb end
    local na = Utils.SafeLower((ctx.meta[a] and ctx.meta[a].name) or select(1, GetItemMeta(a)) or tostring(a))
    local nb = Utils.SafeLower((ctx.meta[b] and ctx.meta[b].name) or select(1, GetItemMeta(b)) or tostring(b))
    if na ~= nb then return na < nb end
    return a < b
  end)
end

function R:EnsureRow(ctx, index)
  local row = ctx.rows[index]
  if row then
    local needsCompact = ctx.compactMode and true or false
    local isCompact = (row._kind == "compact")
    if needsCompact ~= isCompact then
      row:Hide()
      row:SetParent(nil)
      ctx.rows[index] = nil
      row = nil
    end
  end
  if row then return row end
  if ctx.compactMode then
    row = Rows:CreateCompactRow(ctx.content)
  else
    row = Rows:CreateRow(ctx.content)
  end
  ctx.rows[index] = row
  return row
end

function R:LayoutRows(ctx)
  local content = ctx.content
  if not content then return end

  local y = -4
  local showIcons = ctx.showIcons ~= false
  local compactMode = ctx.compactMode and true or false
  local rowH
  if compactMode then
    rowH = 22
  else
    rowH = showIcons and 68 or 50
  end
  local gap = compactMode and 0 or (ctx.rowGap or 3)

  local n = #ctx.list
  for i = 1, n do
    local itemID = ctx.list[i]
    local row = self:EnsureRow(ctx, i)
    local count = ctx.counts[itemID] or 0
    local name, icon = GetMeta(ctx, itemID)

    row:ClearAllPoints()
    row:SetPoint("TOPLEFT", 0, y)
    row:SetPoint("TOPRIGHT", 0, y)
    row:Show()
    if compactMode then
      Rows:SetCompactRowData(row, ctx, itemID, count, name, icon)
    else
      Rows:SetRowData(row, ctx, itemID, count, name, icon)
    end
    y = y - (rowH + gap)
  end

  local maxRows = math.max(n, 20)
  for i = n+1, #ctx.rows do
    local row = ctx.rows[i]
    if row then 
      row:Hide()
      if i > maxRows then ctx.rows[i]=nil end
    end
  end
  content:SetHeight((-y) + 10)
end

function R:Refresh(ctx)
  if not ctx then return end
  self:Recount(ctx)
  self:BuildList(ctx)
  self:LayoutRows(ctx)

  if ctx.totalText then ctx.totalText:SetText("Lumber Total: "..tostring(ctx.total or 0)) end
  
  local Farming = NS.UI.LumberTrackFarming
  if Farming and ctx.farming and ctx.farming.active then
    Farming:Update(ctx)
    if ctx.farmingStatsUpdate then ctx.farmingStatsUpdate() end
  end
  
  local Rate = NS.UI.LumberTrackRate
  if Rate and Rate.UpdateAll then Rate:UpdateAll() end
end

function R:OnItemInfo(ctx, itemID)
  if not ctx or not itemID then return end
  local name, icon = GetItemMeta(itemID)
  if name or icon then
    local m = ctx.meta[itemID] or {}
    m.name, m.icon = name, icon
    ctx.meta[itemID] = m
    self:Refresh(ctx)
  end
end

return R