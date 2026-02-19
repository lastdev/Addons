local ADDON, NS = ...

NS.Systems = NS.Systems or {}

local VendorNPCTooltip = {}
NS.Systems.VendorNPCTooltip = VendorNPCTooltip

local _G = _G
local GameTooltip = _G.GameTooltip
local UnitGUID = _G.UnitGUID
local tonumber = _G.tonumber
local type = _G.type

local function GetNPCIDFromGUID(guid)
  if type(guid) ~= "string" then return nil end
  local npcID = guid:match("Creature%-%d+%-%d+%-%d+%-%d+%-(%d+)%-%x+")
  return npcID and tonumber(npcID) or nil
end

local function IsEnabled()
  local db = NS.db
  local prof = db and db.profile
  if not prof then return false end
  prof.vendor = prof.vendor or {}
  if prof.vendor.showVendorNPCTooltip == nil then prof.vendor.showVendorNPCTooltip = false end
  return prof.vendor.showVendorNPCTooltip
end

local function GetVendorCollectedStats(npcID)
  local vendors = NS.Data and NS.Data.Vendors
  local DecorCounts = NS.Systems and NS.Systems.DecorCounts
  if not vendors or not DecorCounts then return nil, nil end

  local total = 0
  local collected = 0
  local seen = {}

  for _, vendor in ipairs(vendors) do
    local src = vendor and vendor.source
    local id = src and src.id or vendor and vendor.id
    if tonumber(id) == npcID then
      local itemID = vendor.itemID or (src and src.itemID)
      itemID = tonumber(itemID)
      if itemID and not seen[itemID] then
        seen[itemID] = true
        total = total + 1
        local owned = DecorCounts:GetBreakdownByItem(itemID)
        owned = tonumber(owned) or 0
        if owned > 0 then
          collected = collected + 1
        end
      end
    end
  end

  if total > 0 then
    return collected, total
  end
  return nil, nil
end

local function AppendVendorInfo(tooltip)
  if not IsEnabled() then return end

  local unit, guid = tooltip:GetUnit()
  if not unit and not guid then return end

  if not guid and unit then
    guid = UnitGUID(unit)
  end
  if not guid then return end

  local npcID = GetNPCIDFromGUID(guid)
  if not npcID then return end

  local collected, total = GetVendorCollectedStats(npcID)
  if not total then return end

  tooltip:AddLine(" ")
  tooltip:AddLine("HomeDecor", 1, 0.82, 0, 1)
  tooltip:AddDoubleLine(
    "Decor collected:",
    string.format("%d / %d", collected, total),
    0.7, 0.7, 0.7,
    collected == total and 0.4 or 0.9,
    collected == total and 0.9 or 0.9,
    0.2
  )
  tooltip:Show()
end

function VendorNPCTooltip:Enable()
  if self._enabled then return end
  self._enabled = true

  local TDP = _G.TooltipDataProcessor
  if TDP and TDP.AddTooltipPostCall and _G.Enum and _G.Enum.TooltipDataType then
    local ok = pcall(function()
      TDP.AddTooltipPostCall(_G.Enum.TooltipDataType.Unit, function(tooltip)
        if tooltip == GameTooltip then
          AppendVendorInfo(tooltip)
        end
      end)
    end)
    if ok then return end
  end

  if GameTooltip and GameTooltip.HookScript then
    GameTooltip:HookScript("OnShow", function(tooltip)
      AppendVendorInfo(tooltip)
    end)
  end
end

do
  local f = _G.CreateFrame("Frame")
  f:RegisterEvent("PLAYER_LOGIN")
  f:SetScript("OnEvent", function()
    VendorNPCTooltip:Enable()
  end)
end

return VendorNPCTooltip
