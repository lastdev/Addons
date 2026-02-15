local ADDON, NS = ...

NS.Systems = NS.Systems or {}
local VendorChecks = NS.Systems.VendorChecks or {}
NS.Systems.VendorChecks = VendorChecks

local _G = _G
local CreateFrame = _G.CreateFrame
local C_Timer = _G.C_Timer
local hooksecurefunc = _G.hooksecurefunc

local function SafeCall(mod, method)
  if mod and type(mod[method]) == "function" then
    local ok = pcall(mod[method], mod)
    return ok
  end
  return false
end

local function DoRefresh()
  local CM = NS.UI and NS.UI.VendorCheckMarks
  local DC = NS.UI and NS.UI.VendorDecorCounters

  if CM and CM.Refresh then pcall(CM.Refresh, CM) end
  if DC and DC.Refresh then pcall(DC.Refresh, DC) end
end

local function QueueRefresh()
  if VendorChecks._refreshQueued then return end
  VendorChecks._refreshQueued = true

  local function run()
    VendorChecks._refreshQueued = false
    DoRefresh()
  end

  if C_Timer and C_Timer.After then

    C_Timer.After(0, run)
  else
    run()
  end
end

local function HookMerchantUpdates()
  if VendorChecks._hooked then return end
  VendorChecks._hooked = true

  if hooksecurefunc then
    if _G.MerchantFrame_UpdateMerchantInfo then
      hooksecurefunc("MerchantFrame_UpdateMerchantInfo", function()
        QueueRefresh()
      end)
    end

    if _G.MerchantFrame_Update then
      hooksecurefunc("MerchantFrame_Update", function()
        QueueRefresh()
      end)
    end
  end

  if _G.MerchantNextPageButton and _G.MerchantNextPageButton.HookScript then
    _G.MerchantNextPageButton:HookScript("OnClick", function()
      QueueRefresh()
    end)
  end
  if _G.MerchantPrevPageButton and _G.MerchantPrevPageButton.HookScript then
    _G.MerchantPrevPageButton:HookScript("OnClick", function()
      QueueRefresh()
    end)
  end
end

function VendorChecks:Enable()
  if self._enabled then return end
  self._enabled = true

  HookMerchantUpdates()

  if not self._frame then
    local f = CreateFrame("Frame")
    self._frame = f

    f:RegisterEvent("PLAYER_LOGIN")
    f:RegisterEvent("MERCHANT_SHOW")
    f:RegisterEvent("MERCHANT_UPDATE")
    f:RegisterEvent("MERCHANT_CLOSED")

    f:RegisterEvent("HOUSE_DECOR_ADDED_TO_CHEST")
    f:RegisterEvent("HOUSING_STORAGE_UPDATED")
    f:RegisterEvent("HOUSING_STORAGE_ENTRY_UPDATED")

    f:SetScript("OnEvent", function(_, event)
      if event == "PLAYER_LOGIN" then
        HookMerchantUpdates()
        return
      end

      if event == "MERCHANT_CLOSED" then
        SafeCall(NS.UI and NS.UI.VendorCheckMarks, "HideAll")
        SafeCall(NS.UI and NS.UI.VendorDecorCounters, "HideAll")
        return
      end

      QueueRefresh()
    end)
  end
end

do
  local f = CreateFrame("Frame")
  f:RegisterEvent("PLAYER_LOGIN")
  f:SetScript("OnEvent", function()
    VendorChecks:Enable()
  end)
end

return VendorChecks
