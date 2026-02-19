local ADDON, NS = ...
NS.Systems = NS.Systems or {}

local MapPins = NS.Systems.MapPins or {}
NS.Systems.MapPins = MapPins

local P = NS.Systems.MapPinsPools or {}
NS.Systems.MapPinsPools = P
MapPins.Pools = P

local CreateFrame = CreateFrame
local pairs = pairs
local wipe = wipe or function(t) for k in pairs(t) do t[k] = nil end end
local LibStub = LibStub
local HBDPins = LibStub and LibStub("HereBeDragons-Pins-2.0", true)
local U = NS.Systems.MapPinsUtil

P.pooled = {}
P.badgePooled = {}
P.usedWorld = {}
P.usedBadges = {}
P.usedMini = {}

local ICON_TEX_FALLBACK = "Interface\\AddOns\\HomeDecor\\Media\\Icon"

function P.ApplyPinStyle(button, style, color, size)
  if not button or not button.tex then return end
  size = size or 1.0
  if style == "dot" then
    if button.bg then button.bg:Hide() end
    button.tex:ClearAllPoints()
    button.tex:SetPoint("CENTER")
    button.tex:SetSize(14 * size, 14 * size)
    button.tex:SetTexture("Interface\\Common\\Indicator-Yellow")
    button.tex:SetTexCoord(0, 1, 0, 1)
    button.tex:SetVertexColor(0, 0, 0, 0.9)
    if not button.innerCircle then
      button.innerCircle = button:CreateTexture(nil, "OVERLAY")
    end
    button.innerCircle:ClearAllPoints()
    button.innerCircle:SetPoint("CENTER")
    button.innerCircle:SetSize(10 * size, 10 * size)
    button.innerCircle:SetTexture("Interface\\Common\\Indicator-Yellow")
    button.innerCircle:SetTexCoord(0, 1, 0, 1)
    button.innerCircle:SetVertexColor(color.r, color.g, color.b, 1)
    button.innerCircle:Show()
  else
    if button.innerCircle then button.innerCircle:Hide() end
    if button.bg then
      button.bg:ClearAllPoints()
      button.bg:SetAllPoints()
      button.bg:SetTexture("Interface\\Minimap\\UI-Minimap-Background")
      button.bg:SetVertexColor(0.1, 0.1, 0.1, 0.8)
      button.bg:Show()
    end
    button.tex:ClearAllPoints()
    button.tex:SetAllPoints()
    button.tex:SetTexture(U and U.ICON_TEX or ICON_TEX_FALLBACK)
    button.tex:SetTexCoord(0.1, 0.9, 0.1, 0.9)
    button.tex:SetVertexColor(color.r, color.g, color.b, 1)
  end
end

function P.ApplyBadgeStyle(frame, style, color, size)
  if not frame or not frame.icon then return end
  size = size or 1.0
  if style == "dot" then
    if frame.bg then frame.bg:Hide() end
    frame.icon:ClearAllPoints()
    frame.icon:SetPoint("CENTER")
    frame.icon:SetSize(20 * size, 20 * size)
    frame.icon:SetTexture("Interface\\Common\\Indicator-Yellow")
    frame.icon:SetTexCoord(0, 1, 0, 1)
    frame.icon:SetVertexColor(0, 0, 0, 0.9)
    if not frame.innerCircle then
      frame.innerCircle = frame:CreateTexture(nil, "OVERLAY")
    end
    frame.innerCircle:ClearAllPoints()
    frame.innerCircle:SetPoint("CENTER")
    frame.innerCircle:SetSize(16 * size, 16 * size)
    frame.innerCircle:SetTexture("Interface\\Common\\Indicator-Yellow")
    frame.innerCircle:SetTexCoord(0, 1, 0, 1)
    frame.innerCircle:SetVertexColor(color.r, color.g, color.b, 1)
    frame.innerCircle:Show()
  else
    if frame.innerCircle then frame.innerCircle:Hide() end
    if frame.bg then
      frame.bg:ClearAllPoints()
      frame.bg:SetAllPoints()
      frame.bg:SetTexture("Interface\\Minimap\\UI-Minimap-Background")
      frame.bg:SetVertexColor(0.1, 0.1, 0.1, 0.8)
      frame.bg:Show()
    end
    frame.icon:ClearAllPoints()
    frame.icon:SetAllPoints()
    frame.icon:SetTexture(U and U.ICON_TEX or ICON_TEX_FALLBACK)
    frame.icon:SetTexCoord(0.15, 0.85, 0.15, 0.85)
    frame.icon:SetVertexColor(color.r, color.g, color.b, 1)
  end
end

function P.EnsurePool()
  if #P.pooled > 0 then
    local frame = P.pooled[#P.pooled]
    P.pooled[#P.pooled] = nil
    return frame
  end

  local pinSize = U and U.PIN_SIZE_WORLD or 16
  local iconTex = U and U.ICON_TEX or ICON_TEX_FALLBACK

  local button = CreateFrame("Button", nil, UIParent)
  button.isMapPin = true
  button:SetSize(pinSize, pinSize)
  button.bg = button:CreateTexture(nil, "BACKGROUND")
  button.bg:SetAllPoints()
  button.bg:SetTexture("Interface\\Minimap\\UI-Minimap-Background")
  button.bg:SetVertexColor(0.1, 0.1, 0.1, 0.8)
  button.tex = button:CreateTexture(nil, "ARTWORK")
  button.tex:SetAllPoints()
  button.tex:SetTexture(iconTex)
  button.tex:SetTexCoord(0.1, 0.9, 0.1, 0.9)
  button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
  return button
end

function P.EnsureBadgePool()
  if #P.badgePooled > 0 then
    local frame = P.badgePooled[#P.badgePooled]
    P.badgePooled[#P.badgePooled] = nil
    return frame
  end

  local pinSize = U and U.PIN_SIZE_BADGE or 22
  local iconTex = U and U.ICON_TEX or ICON_TEX_FALLBACK

  local frame = CreateFrame("Button", nil, UIParent)
  frame.isMapBadge = true
  frame:SetSize(pinSize, pinSize)
  frame:RegisterForClicks("LeftButtonUp", "RightButtonUp")
  frame.bg = frame:CreateTexture(nil, "BACKGROUND")
  frame.bg:SetAllPoints()
  frame.bg:SetTexture("Interface\\Minimap\\UI-Minimap-Background")
  frame.bg:SetVertexColor(0.1, 0.1, 0.1, 0.9)
  frame.icon = frame:CreateTexture(nil, "ARTWORK")
  frame.icon:SetAllPoints()
  frame.icon:SetTexture(iconTex)
  frame.icon:SetTexCoord(0.15, 0.85, 0.15, 0.85)
  frame.countBg = frame:CreateTexture(nil, "OVERLAY", nil, 1)
  frame.countBg:SetColorTexture(0, 0, 0, 0.8)
  frame.countBg:SetSize(18, 14)
  frame.countBg:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 4, -4)
  frame.count = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal", 2)
  frame.count:SetPoint("CENTER", frame.countBg, "CENTER", 0, 0)
  local fontPath = frame.count:GetFont()
  frame.count:SetFont(fontPath, 11, "OUTLINE")
  frame.count:SetTextColor(1, 0.82, 0)
  return frame
end

function P.RecycleFrame(frame)
  if not frame then return end
  frame.vendor = nil
  frame.badgeData = nil
  frame:Hide()
  frame:SetParent(UIParent)
  if frame.isMapBadge then
    P.badgePooled[#P.badgePooled + 1] = frame
  else
    P.pooled[#P.pooled + 1] = frame
  end
end

function P.ClearWorldPins()
  if not HBDPins then return end
  for icon in pairs(P.usedWorld) do
    HBDPins:RemoveWorldMapIcon(ADDON, icon)
    P.RecycleFrame(icon)
  end
  wipe(P.usedWorld)
end

function P.ClearBadges()
  if not HBDPins then return end
  for icon in pairs(P.usedBadges) do
    HBDPins:RemoveWorldMapIcon(ADDON, icon)
    P.RecycleFrame(icon)
  end
  wipe(P.usedBadges)
end

function P.ClearMiniPins()
  if not HBDPins then return end
  for icon in pairs(P.usedMini) do
    HBDPins:RemoveMinimapIcon(ADDON, icon)
    P.RecycleFrame(icon)
  end
  wipe(P.usedMini)
end

return P
