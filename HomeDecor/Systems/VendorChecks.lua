local ADDON, NS = ...
NS.Systems = NS.Systems or {}

local VendorChecks = {}
NS.Systems.VendorChecks = VendorChecks

local CHECK_ATLAS = "common-icon-checkmark"
local CHECK_FALLBACK = "Interface\\RaidFrame\\ReadyCheck-Ready"

local function itemIDFromLink(link)
  if type(link) ~= "string" then
    local ok, s = pcall(tostring, link)
    if not ok or not s then return nil end
    link = s
  end
  local ok, id = pcall(string.match, link, "item:(%d+)")
  if not ok then return nil end
  return id and tonumber(id) or nil
end

local function getMerchantItemIDSafe(index)
  if type(GetMerchantItemID) == "function" then
    local ok, id = pcall(GetMerchantItemID, index)
    if ok and type(id) == "number" and id > 0 then return id end
  end
  local link = GetMerchantItemLink(index)
  return itemIDFromLink(link)
end

local function GetCatalogInfoByItem(itemID)
  if not (C_HousingCatalog and C_HousingCatalog.GetCatalogEntryInfoByItem) then return nil end
  local ok, info = pcall(C_HousingCatalog.GetCatalogEntryInfoByItem, itemID, true)
  if not ok then return nil end
  return info
end

local function GetTotalOwned(info)
  if type(info) ~= "table" then return 0 end
  local qty = info.quantity
  local redeem = info.remainingRedeemable
  local placed = info.numPlaced
  if type(qty) ~= "number" then qty = 0 end
  if type(redeem) ~= "number" then redeem = 0 end
  if type(placed) ~= "number" then placed = 0 end
  return (qty + redeem + placed)
end

local function EnsureCheck(button)
  if button.hdCheckmark then return button.hdCheckmark end

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
  button.hdCheckmark = t
  return t
end

local function EnsureOwnedText(button)
  if button.hdOwnedText then return button.hdOwnedText end

  local owned = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
  owned:ClearAllPoints()
  owned:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -1, 1)

  owned:SetTextColor(0.86, 0.84, 0.78, 1)

  if owned.SetFontObject then
    owned:SetFontObject(GameFontNormalSmall)
  end

  owned:Hide()
  button.hdOwnedText = owned
  return owned
end

local function HideMerchantOverlays()
  local perPage = MERCHANT_ITEMS_PER_PAGE or 10
  for i = 1, perPage do
    local button = _G["MerchantItem"..i.."ItemButton"]
    if button then
      if button.hdCheckmark then button.hdCheckmark:Hide() end
      if button.hdOwnedText then button.hdOwnedText:Hide() end
    end
  end
end

local function UpdateMerchantButtons()
  if not MerchantFrame or not MerchantFrame:IsShown() then return end

  local numItems = GetMerchantNumItems() or 0
  local perPage = MERCHANT_ITEMS_PER_PAGE or 10
  local page = (MerchantFrame and MerchantFrame.page) or 1

  for i = 1, perPage do
    local button = _G["MerchantItem"..i.."ItemButton"]
    if button and button:IsShown() then
      local check = EnsureCheck(button)
      local ownedText = EnsureOwnedText(button)

      local totalOwned = 0
      local collected = false

      local index = ((page - 1) * perPage) + i
      if index <= numItems then
        local itemID = getMerchantItemIDSafe(index)
        if itemID then
          local info = GetCatalogInfoByItem(itemID)
          totalOwned = GetTotalOwned(info)
          collected = totalOwned > 0
        end
      end

      check:SetShown(collected)

      if collected then
        ownedText:SetText(tostring(totalOwned))
        ownedText:Show()
      else
        ownedText:Hide()
      end
    end
  end
end

local function HookMerchant()
  if not hooksecurefunc then return end

  if MerchantFrame_UpdateMerchantInfo then
    hooksecurefunc("MerchantFrame_UpdateMerchantInfo", function()
      UpdateMerchantButtons()
    end)
  end

  if MerchantFrame_Update then
    hooksecurefunc("MerchantFrame_Update", function()
      UpdateMerchantButtons()
    end)
  end

  if MerchantNextPageButton and MerchantNextPageButton.HookScript then
    MerchantNextPageButton:HookScript("OnClick", function()
      C_Timer.After(0, UpdateMerchantButtons)
    end)
  end
  if MerchantPrevPageButton and MerchantPrevPageButton.HookScript then
    MerchantPrevPageButton:HookScript("OnClick", function()
      C_Timer.After(0, UpdateMerchantButtons)
    end)
  end
end

local init = CreateFrame("Frame")
init:RegisterEvent("PLAYER_LOGIN")
init:RegisterEvent("MERCHANT_SHOW")
init:RegisterEvent("MERCHANT_UPDATE")
init:RegisterEvent("MERCHANT_CLOSED")
init:RegisterEvent("HOUSE_DECOR_ADDED_TO_CHEST")
init:RegisterEvent("HOUSING_STORAGE_UPDATED")
init:RegisterEvent("HOUSING_STORAGE_ENTRY_UPDATED")

init:SetScript("OnEvent", function(_, event)
  if event == "PLAYER_LOGIN" then
    HookMerchant()
    return
  end

  if event == "MERCHANT_CLOSED" then
    HideMerchantOverlays()
    return
  end

  if event == "MERCHANT_SHOW" or event == "MERCHANT_UPDATE"
    or event == "HOUSE_DECOR_ADDED_TO_CHEST"
    or event == "HOUSING_STORAGE_UPDATED"
    or event == "HOUSING_STORAGE_ENTRY_UPDATED"
  then
    C_Timer.After(0, UpdateMerchantButtons)
    return
  end
end)

return VendorChecks
