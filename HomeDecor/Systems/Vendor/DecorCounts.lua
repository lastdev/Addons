local ADDON, NS = ...

NS.UI = NS.UI or {}
local DC = NS.UI.VendorDecorCounters or {}
NS.UI.VendorDecorCounters = DC

local _G = _G
local MerchantFrame = _G.MerchantFrame
local GetMerchantNumItems = _G.GetMerchantNumItems
local GetMerchantItemLink = _G.GetMerchantItemLink
local GetMerchantItemID = _G.GetMerchantItemID
local MERCHANT_ITEMS_PER_PAGE = _G.MERCHANT_ITEMS_PER_PAGE or 10

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

local function EnsureOwnedText(button)
  if button.hdVendorOwnedText then return button.hdVendorOwnedText end

  local owned = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
  owned:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -1, 1)

  owned:SetTextColor(0.86, 0.84, 0.78, 1)
  owned:Hide()

  button.hdVendorOwnedText = owned
  return owned
end

local function EnsureHeaderCounter()
  if not MerchantFrame or MerchantFrame.hdVendorHeaderCounter then return end

  local parent = MerchantFrame.TitleContainer or MerchantFrame

  local fs = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
  fs:SetJustifyH("RIGHT")
  fs:SetText("")
  fs:Hide()

  fs:ClearAllPoints()
  fs:SetPoint("TOPRIGHT", parent, "TOPRIGHT", -18, -10)

  if fs.SetDrawLayer then
    fs:SetDrawLayer("OVERLAY", 7)
  end

  MerchantFrame.hdVendorHeaderCounter = fs
end

function DC:HideAll()
  local perPage = MERCHANT_ITEMS_PER_PAGE or 10
  for i = 1, perPage do
    local button = _G["MerchantItem"..i.."ItemButton"]
    if button and button.hdVendorOwnedText then
      button.hdVendorOwnedText:Hide()
    end
  end

  if MerchantFrame and MerchantFrame.hdVendorHeaderCounter then
    MerchantFrame.hdVendorHeaderCounter:Hide()
  end
end

function DC:Refresh()
  if not MerchantFrame or not MerchantFrame:IsShown() then return end

  local db = NS.db
  local prof = db and db.profile
  if prof then
    prof.vendor = prof.vendor or {}
    if prof.vendor.showOwnedCount == nil then prof.vendor.showOwnedCount = false end
    if not prof.vendor.showOwnedCount then
      self:HideAll()
      return
    end
  end

  local DecorCounts = NS.Systems and NS.Systems.DecorCounts
  if not DecorCounts or type(DecorCounts.GetBreakdownByItem) ~= "function" then
    return
  end

  EnsureHeaderCounter()

  local numItems = (GetMerchantNumItems and GetMerchantNumItems()) or 0
  local perPage = MERCHANT_ITEMS_PER_PAGE or 10
  local page = (MerchantFrame and MerchantFrame.page) or 1

  local collected, total = 0, 0
  local missingIDs = false

  for idx = 1, numItems do
    local itemID = getMerchantItemIDSafe(idx)
    if itemID then
      total = total + 1
      local ownedTotal = DecorCounts:GetBreakdownByItem(itemID)
      ownedTotal = tonumber(ownedTotal) or 0
      if ownedTotal > 0 then
        collected = collected + 1
      end
    else
      missingIDs = true
    end
  end

  for i = 1, perPage do
    local button = _G["MerchantItem"..i.."ItemButton"]
    if button and button:IsShown() then
      local ownedText = EnsureOwnedText(button)

      local index = ((page - 1) * perPage) + i
      if index <= numItems then
        local itemID = getMerchantItemIDSafe(index)
        if itemID then
          local totalOwned = DecorCounts:GetBreakdownByItem(itemID)
          totalOwned = tonumber(totalOwned) or 0

          if totalOwned > 0 then
            ownedText:SetText(tostring(totalOwned))
            ownedText:Show()
          else
            ownedText:Hide()
          end
        else
          missingIDs = true
          ownedText:Hide()
        end
      else
        ownedText:Hide()
      end
    end
  end

  if MerchantFrame and MerchantFrame.hdVendorHeaderCounter then
    if total > 0 then
      MerchantFrame.hdVendorHeaderCounter:SetText(string.format("%d/%d", collected, total))
      MerchantFrame.hdVendorHeaderCounter:Show()
    else
      MerchantFrame.hdVendorHeaderCounter:Hide()
    end
  end

  if missingIDs and _G.C_Timer and _G.C_Timer.After then
    if not self._retryQueued then
      self._retryQueued = true
      _G.C_Timer.After(0.15, function()
        self._retryQueued = false
        if self.Refresh then pcall(self.Refresh, self) end
      end)
    end
  end
end

return DC
