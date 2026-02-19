local ADDON, NS = ...

NS.UI = NS.UI or {}
local CM = NS.UI.VendorCheckMarks or {}
NS.UI.VendorCheckMarks = CM

local _G = _G
local MerchantFrame = _G.MerchantFrame
local GetMerchantNumItems = _G.GetMerchantNumItems
local GetMerchantItemLink = _G.GetMerchantItemLink
local GetMerchantItemID = _G.GetMerchantItemID
local MERCHANT_ITEMS_PER_PAGE = _G.MERCHANT_ITEMS_PER_PAGE or 10
local C_Timer = _G.C_Timer

local CHECK_ATLAS = "common-icon-checkmark"
local CHECK_FALLBACK = "Interface\\RaidFrame\\ReadyCheck-Ready"

local function itemIDFromLink(link)
  if type(link) ~= "string" then return nil end
  local id = link:match("item:(%d+)")
  return id and tonumber(id) or nil
end

local function getMerchantItemIDSafe(index)
  if type(GetMerchantItemID) == "function" then
    local ok, id = pcall(GetMerchantItemID, index)
    if ok and type(id) == "number" and id > 0 then return id end
  end
  local link = GetMerchantItemLink and GetMerchantItemLink(index)
  return itemIDFromLink(link)
end

local function EnsureCheck(button)
  if button.hdVendorCheckmark then return button.hdVendorCheckmark end

  local t = button:CreateTexture(nil, "OVERLAY", nil, 7)
  t:SetSize(13, 13)
  t:ClearAllPoints()
  t:SetPoint("BOTTOMLEFT", button, "BOTTOMLEFT", 1, 1)

  if t.SetAtlas then
    t:SetAtlas(CHECK_ATLAS, true)
  else
    t:SetTexture(CHECK_FALLBACK)
  end

  t:SetVertexColor(0.75, 0.95, 0.75, 0.95)
  t:Hide()

  button.hdVendorCheckmark = t
  return t
end

function CM:HideAll()
  local perPage = MERCHANT_ITEMS_PER_PAGE or 10
  for i = 1, perPage do
    local button = _G["MerchantItem" .. i .. "ItemButton"]
    if button and button.hdVendorCheckmark then
      button.hdVendorCheckmark:Hide()
    end
  end
end

local function QueueRetry(self)
  if self._retryQueued then return end
  self._retryQueued = true
  if C_Timer and C_Timer.After then
    C_Timer.After(0.15, function()
      self._retryQueued = false
      if self.Refresh then pcall(self.Refresh, self) end
    end)
  else
    self._retryQueued = false
  end
end

function CM:Refresh()
  if not MerchantFrame or not MerchantFrame:IsShown() then return end

  local db = NS.db
  local prof = db and db.profile
  if prof then
    prof.vendor = prof.vendor or {}
    if prof.vendor.showCollectedCheckmark == nil then prof.vendor.showCollectedCheckmark = true end
    if not prof.vendor.showCollectedCheckmark then
      self:HideAll()
      return
    end
  end

  local DecorCounts = NS.Systems and NS.Systems.DecorCounts
  if not DecorCounts or type(DecorCounts.GetBreakdownByItem) ~= "function" then
    return
  end

  local numItems = (GetMerchantNumItems and GetMerchantNumItems()) or 0
  local perPage = MERCHANT_ITEMS_PER_PAGE or 10
  local page = (MerchantFrame and MerchantFrame.page) or 1

  local missingIDs = false

  for i = 1, perPage do
    local button = _G["MerchantItem" .. i .. "ItemButton"]
    if button and button:IsShown() then
      local check = EnsureCheck(button)

      local collected = false
      local index = ((page - 1) * perPage) + i

      if index <= numItems then
        local itemID = getMerchantItemIDSafe(index)
        if itemID then
          local totalOwned = DecorCounts:GetBreakdownByItem(itemID)
          totalOwned = tonumber(totalOwned) or 0
          collected = totalOwned > 0
        else

          missingIDs = true
        end
      end

      check:SetShown(collected)
    end
  end

  if missingIDs then
    QueueRetry(self)
  end
end

return CM
