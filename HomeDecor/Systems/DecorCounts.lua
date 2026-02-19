local ADDON, NS = ...

NS.Systems = NS.Systems or {}
local DecorCounts = NS.Systems.DecorCounts or {}
NS.Systems.DecorCounts = DecorCounts

local cacheItem = DecorCounts._cacheItem or {}
DecorCounts._cacheItem = cacheItem

local function wipeTable(t)
  if wipe then
    wipe(t)
  else
    for k in pairs(t) do t[k] = nil end
  end
end

function DecorCounts:ClearCache()
  wipeTable(cacheItem)
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
  if not (C_HousingCatalog and C_HousingCatalog.GetCatalogEntryInfoByItem) then return nil end
  local ok, info = pcall(C_HousingCatalog.GetCatalogEntryInfoByItem, itemID, true)
  if not ok then return nil end
  return info
end

function DecorCounts:GetBreakdownByItem(itemID)
  if not itemID then return 0, 0, 0 end

  local c = cacheItem[itemID]
  if c then return c.total, c.placed, c.storage end

  local info = GetInfoByItem(itemID)
  if not info then
    cacheItem[itemID] = { total = 0, placed = 0, storage = 0 }
    return 0, 0, 0
  end

  local total, placed, storage = BreakdownFromInfo(info)
  cacheItem[itemID] = { total = total, placed = placed, storage = storage }
  return total, placed, storage
end

function DecorCounts:GetByItem(itemID)
  local total, placed = self:GetBreakdownByItem(itemID)
  return total, placed
end

do
  local f = CreateFrame("Frame")
  f:RegisterEvent("MERCHANT_SHOW")
  f:RegisterEvent("MERCHANT_UPDATE")
  f:RegisterEvent("MERCHANT_CLOSED")
  f:RegisterEvent("HOUSING_STORAGE_UPDATED")
  f:RegisterEvent("HOUSING_STORAGE_ENTRY_UPDATED")
  f:RegisterEvent("HOUSE_DECOR_ADDED_TO_CHEST")
  f:SetScript("OnEvent", function(_, event)
    if event == "MERCHANT_CLOSED" then
      DecorCounts:ClearCache()
      return
    end
    DecorCounts:ClearCache()
  end)
end

return DecorCounts
