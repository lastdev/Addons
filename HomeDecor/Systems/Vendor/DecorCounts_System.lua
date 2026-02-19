local ADDON, NS = ...
NS.Systems = NS.Systems or {}

local DecorCounts = NS.Systems.DecorCounts or {}
NS.Systems.DecorCounts = DecorCounts

local _G = _G
local pcall = _G.pcall
local tonumber = _G.tonumber
local wipe = _G.wipe

local Catalog = _G.C_HousingCatalog

DecorCounts._cacheItem = DecorCounts._cacheItem or {}

local function wipeTable(t)
  if type(t) ~= "table" then return end
  if type(wipe) == "function" then
    wipe(t)
  else
    for k in pairs(t) do t[k] = nil end
  end
end

function DecorCounts:ClearCache()
  wipeTable(self._cacheItem)
end

local function BreakdownFromInfo(info)
  if type(info) ~= "table" then return 0, 0, 0 end
  local qty = info.quantity
  local redeem = info.remainingRedeemable
  local placed = info.numPlaced
  if type(qty) ~= "number" then qty = 0 end
  if type(redeem) ~= "number" then redeem = 0 end
  if type(placed) ~= "number" then placed = 0 end
  local storage = qty + redeem
  local total = storage + placed
  return total, placed, storage
end

local function GetInfoByItem(itemID)
  if not (Catalog and Catalog.GetCatalogEntryInfoByItem) then return nil end
  local ok, info = pcall(Catalog.GetCatalogEntryInfoByItem, itemID, true)
  if ok and type(info) == "table" then
    return info
  end
  return nil
end

function DecorCounts:GetBreakdownByItem(itemID)
  itemID = tonumber(itemID)
  if not itemID or itemID <= 0 then return 0, 0, 0 end

  local cached = self._cacheItem[itemID]
  if cached then
    return cached.total, cached.placed, cached.storage
  end

  local info = GetInfoByItem(itemID)
  if not info then
    self._cacheItem[itemID] = { total = 0, placed = 0, storage = 0 }
    return 0, 0, 0
  end

  local total, placed, storage = BreakdownFromInfo(info)
  self._cacheItem[itemID] = { total = total, placed = placed, storage = storage }
  return total, placed, storage
end

function DecorCounts:GetByItem(itemID)
  local total, placed = self:GetBreakdownByItem(itemID)
  return total, placed
end

do
  local f = _G.CreateFrame("Frame")

  local function SafeRegister(ev)
    local ok = pcall(f.RegisterEvent, f, ev)
    return ok
  end

  SafeRegister("MERCHANT_CLOSED")
  SafeRegister("HOUSING_STORAGE_UPDATED")
  SafeRegister("HOUSING_STORAGE_ENTRY_UPDATED")
  SafeRegister("HOUSE_DECOR_ADDED_TO_CHEST")

  SafeRegister("HOUSING_COLLECTION_UPDATED")
  SafeRegister("HOUSING_DECOR_ITEM_LEARNED")

  SafeRegister("BAG_UPDATE_DELAYED")
  SafeRegister("QUEST_TURNED_IN")
  SafeRegister("ACHIEVEMENT_EARNED")

  f:SetScript("OnEvent", function()
    DecorCounts:ClearCache()
  end)
end

return DecorCounts
