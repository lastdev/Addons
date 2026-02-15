local ADDON, NS = ...

NS.Systems = NS.Systems or {}
local MapPins = {}
NS.Systems.MapPins = MapPins

local LibStub = _G.LibStub
local CreateFrame = _G.CreateFrame
local GameTooltip = _G.GameTooltip
local UIParent = _G.UIParent
local tonumber = _G.tonumber
local type = _G.type
local pairs = _G.pairs
local wipe = _G.wipe or function(t) for k in pairs(t) do t[k] = nil end end

local HBD = LibStub and LibStub("HereBeDragons-2.0", true)
local HBDPins = LibStub and LibStub("HereBeDragons-Pins-2.0", true)
local NPCNames = NS.Systems and NS.Systems.NPCNames
local TooltipSys = NS.UI and NS.UI.Tooltips

local ICON_TEX = "Interface\\AddOns\\HomeDecor\\Media\\Icon"
local PIN_SIZE_WORLD = 16
local PIN_SIZE_MINI = 14
local PIN_SIZE_BADGE = 22

local C_Map = _G.C_Map
local C_SuperTrack = _G.C_SuperTrack
local UiMapPoint = _G.UiMapPoint
local IsShiftKeyDown = _G.IsShiftKeyDown

local WAYPOINT_CLEAR_YARDS = 25

local activeWaypoint = nil 

local function clearUserWaypoint()
  if C_Map and C_Map.ClearUserWaypoint then
    pcall(C_Map.ClearUserWaypoint)
  end
  if C_SuperTrack and C_SuperTrack.SetSuperTrackedUserWaypoint then
    pcall(C_SuperTrack.SetSuperTrackedUserWaypoint, false)
  end
  activeWaypoint = nil
end

local function setUserWaypoint(mapID, x, y, npcID)
  if not (C_Map and C_Map.SetUserWaypoint and UiMapPoint and UiMapPoint.CreateFromCoordinates) then return end
  local point = UiMapPoint.CreateFromCoordinates(mapID, x, y)
  if not point then return end
  pcall(C_Map.SetUserWaypoint, point)
  if C_SuperTrack and C_SuperTrack.SetSuperTrackedUserWaypoint then
    pcall(C_SuperTrack.SetSuperTrackedUserWaypoint, true)
  end
  activeWaypoint = { mapID = mapID, x = x, y = y, npcID = npcID }
end

local function isActiveWaypoint(mapID, x, y, npcID)
  local w = activeWaypoint
  if not w then return false end
  if npcID and w.npcID and npcID == w.npcID then return true end
  if mapID and w.mapID == mapID and x and y then
    local dx = (w.x or 0) - x
    local dy = (w.y or 0) - y
    return (dx*dx + dy*dy) < 0.0000005
  end
  return false
end

local mapIndex = {}
local pooled = {}
local badgePooled = {}
local usedWorld = {}
local usedBadges = {}
local usedMini = {}

local zoneToContinent = {} 

local function parseWorldmap(worldmap)
  if type(worldmap) ~= "string" then return end
  local a,b,c = worldmap:match("^(%d+):(%d+):(%d+)$")
  if not a then return end
  local mapID = tonumber(a)
  local x = tonumber(b)
  local y = tonumber(c)
  if not mapID or not x or not y then return end
  x = x / 10000
  y = y / 10000
  if x <= 0 or y <= 0 or x >= 1 or y >= 1 then return end
  return mapID, x, y
end

local function getPinSettings()
  local prof = NS.db and NS.db.profile
  if not prof or not prof.mapPins then 
    return "house", { r = 1, g = 1, b = 1 }, 1.0
  end
  local style = prof.mapPins.pinStyle or "house"
  local color = prof.mapPins.pinColor or { r = 1, g = 1, b = 1 }
  local size = prof.mapPins.pinSize or 1.0
  return style, color, size
end

local function applyPinStyle(button, style, color, size)
  size = size or 1.0
  if style == "dot" then
    button.bg:Hide()
    
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
    if button.innerCircle then
      button.innerCircle:Hide()
    end
    
    button.bg:ClearAllPoints()
    button.bg:SetAllPoints()
    button.bg:SetTexture("Interface\\Minimap\\UI-Minimap-Background")
    button.bg:SetVertexColor(0.1, 0.1, 0.1, 0.8)
    button.bg:Show()
    
    button.tex:ClearAllPoints()
    button.tex:SetAllPoints()
    button.tex:SetTexture(ICON_TEX)
    button.tex:SetTexCoord(0.1, 0.9, 0.1, 0.9)
    button.tex:SetVertexColor(color.r, color.g, color.b, 1)
  end
end

local function applyBadgeStyle(frame, style, color, size)
  size = size or 1.0
  if style == "dot" then
    frame.bg:Hide()

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
    if frame.innerCircle then
      frame.innerCircle:Hide()
    end
    
    frame.bg:ClearAllPoints()
    frame.bg:SetAllPoints()
    frame.bg:SetTexture("Interface\\Minimap\\UI-Minimap-Background")
    frame.bg:SetVertexColor(0.1, 0.1, 0.1, 0.9)
    frame.bg:Show()
    
    frame.icon:ClearAllPoints()
    frame.icon:SetAllPoints()
    frame.icon:SetTexture(ICON_TEX)
    frame.icon:SetTexCoord(0.15, 0.85, 0.15, 0.85)
    frame.icon:SetVertexColor(color.r, color.g, color.b, 1)
  end
end

local function ensurePool()
  if #pooled > 0 then
    local frame = pooled[#pooled]
    pooled[#pooled] = nil
    return frame
  end

  local button = CreateFrame("Button", nil, UIParent)
  button.__hdMapPin = true
  button:SetSize(PIN_SIZE_WORLD, PIN_SIZE_WORLD)
  
  button.bg = button:CreateTexture(nil, "BACKGROUND")
  button.bg:SetAllPoints()
  button.bg:SetTexture("Interface\\Minimap\\UI-Minimap-Background")
  button.bg:SetVertexColor(0.1, 0.1, 0.1, 0.8)

  button.tex = button:CreateTexture(nil, "ARTWORK")
  button.tex:SetAllPoints()
  button.tex:SetTexture(ICON_TEX)
  button.tex:SetTexCoord(0.1, 0.9, 0.1, 0.9)
  
  button:RegisterForClicks("LeftButtonUp", "RightButtonUp")

  button:SetScript("OnEnter", function(self)
    if not self.vendor then return end
    local vendor = self.vendor
    local npcID = vendor.id
    local zoneName = vendor.zone
    local vendorName = vendor.name
    local shiftKeyDown = _G.IsShiftKeyDown and _G.IsShiftKeyDown()

    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText(vendorName or "Vendor", 1, 1, 1)
    if zoneName then GameTooltip:AddLine(zoneName, 0.8, 0.8, 0.8) end

    GameTooltip:AddLine(" ", 0, 0, 0)
    local hasWaypoint = (vendor.mapID and isActiveWaypoint(vendor.mapID, vendor.x, vendor.y, npcID)) and true or false
    GameTooltip:AddLine(hasWaypoint and "Left-click: Clear waypoint" or "Left-click: Set waypoint", 1, 0.82, 0)
    GameTooltip:AddLine("Right-click: Open Tracker", 1, 0.82, 0)

    if shiftKeyDown and npcID then GameTooltip:AddLine("NPC ID: "..npcID, 0.8, 0.8, 0.8) end

    if npcID and TooltipSys and type(TooltipSys.AppendNpcMouseover) == "function" then
      pcall(TooltipSys.AppendNpcMouseover, GameTooltip, npcID)
    end

    GameTooltip:Show()
  end)

  button:SetScript("OnLeave", function() if GameTooltip then GameTooltip:Hide() end end)

  button:SetScript("OnClick", function(self, mouseButton)
    local vendor = self.vendor
    if not vendor then return end

    if mouseButton == "LeftButton" then
      local mapID, x, y = vendor.mapID, vendor.x, vendor.y
      if mapID and x and y then
        if isActiveWaypoint(mapID, x, y, vendor.id) then
          clearUserWaypoint()
        else
          setUserWaypoint(mapID, x, y, vendor.id)
        end
        MapPins.RefreshTooltip()
      end
      return
    end

    if mouseButton == "RightButton" then
      local Tracker = NS.UI and NS.UI.Tracker
      if Tracker and Tracker.Create then
        pcall(function()
          Tracker:Create()
          if Tracker.frame and Tracker.frame.Show then
            Tracker.frame:Show()
            if Tracker.frame.Raise then Tracker.frame:Raise() end
          end
        end)
      end
    end
  end)
  return button
end

local function ensureBadgePool()
  if #badgePooled > 0 then
    local f = badgePooled[#badgePooled]
    badgePooled[#badgePooled] = nil
    return f
  end

  local frame = CreateFrame("Button", nil, UIParent)
  frame.__hdMapBadge = true
  frame:SetSize(PIN_SIZE_BADGE, PIN_SIZE_BADGE)
  frame:RegisterForClicks("LeftButtonUp")

  frame.bg = frame:CreateTexture(nil, "BACKGROUND")
  frame.bg:SetAllPoints()
  frame.bg:SetTexture("Interface\\Minimap\\UI-Minimap-Background")
  frame.bg:SetVertexColor(0.1, 0.1, 0.1, 0.9)

  frame.icon = frame:CreateTexture(nil, "ARTWORK")
  frame.icon:SetAllPoints()
  frame.icon:SetTexture(ICON_TEX)
  frame.icon:SetTexCoord(0.15, 0.85, 0.15, 0.85)

  frame.countBg = frame:CreateTexture(nil, "OVERLAY", nil, 1)
  frame.countBg:SetColorTexture(0, 0, 0, 0.8)
  frame.countBg:SetSize(18, 14)
  frame.countBg:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 4, -4)

  frame.count = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal", 2)
  frame.count:SetPoint("CENTER", frame.countBg, "CENTER", 0, 0)
  local fontPath, _, fontFlags = frame.count:GetFont()
  frame.count:SetFont(fontPath, 11, "OUTLINE")
  frame.count:SetTextColor(1, 0.82, 0)

  frame:SetScript("OnEnter", function(self)
    if not self.badgeData then return end
    local bd = self.badgeData
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText(bd.zoneName or "Zone", 1, 1, 1)
    GameTooltip:AddLine("Decor Vendors: " .. (bd.vendorCount or 0), 1, 0.82, 0)
    GameTooltip:AddLine(" ")
    GameTooltip:AddLine("Left-click to view zone map", 0.5, 0.5, 0.5)
    GameTooltip:Show()
  end)

  frame:SetScript("OnLeave", function() if GameTooltip then GameTooltip:Hide() end end)

  frame:SetScript("OnClick", function(self, button)
    if button == "LeftButton" and self.badgeData and self.badgeData.mapID then
      local WM = _G.WorldMapFrame
      if WM and type(WM.SetMapID) == "function" then
        WM:SetMapID(self.badgeData.mapID)
      end
    end
  end)

  return frame
end

function MapPins.RefreshTooltip()
  if not GameTooltip or not GameTooltip.IsShown or not GameTooltip:IsShown() then return end
  local owner = GameTooltip.GetOwner and GameTooltip:GetOwner()
  if not owner or not (owner.__hdMapPin or owner.__hdMapBadge) then return end
  if owner.IsMouseOver and not owner:IsMouseOver() then return end
  local onEnter = owner.GetScript and owner:GetScript("OnEnter")
  if type(onEnter) ~= "function" then return end
  pcall(onEnter, owner)
end

local mod = CreateFrame("Frame")
mod:RegisterEvent("MODIFIER_STATE_CHANGED")
mod:SetScript("OnEvent", function()
  MapPins.RefreshTooltip()
end)

local function recycleFrame(frame)
  if not frame then return end
  frame.vendor = nil
  frame.badgeData = nil
  frame:Hide()
  frame:SetParent(UIParent)
  if frame.__hdMapBadge then
    badgePooled[#badgePooled + 1] = frame
  else
    pooled[#pooled + 1] = frame
  end
end

local function buildIndex()
  wipe(mapIndex)
  wipe(zoneToContinent)

  local Vendors = NS.Data and NS.Data.Vendors
  if type(Vendors) ~= "table" then return end

  for _, regions in pairs(Vendors) do
    if type(regions) == "table" then
      for _, vendorList in pairs(regions) do
        if type(vendorList) == "table" then
          for i = 1, #vendorList do
            local v = vendorList[i]
            local src = v and v.source
            local id = src and src.id
            local zone = src and src.zone
            local faction = src and src.faction
            local mapID, x, y = parseWorldmap(src and src.worldmap)
            if mapID and id then
              local t = mapIndex[mapID]
              if not t then t = {}; mapIndex[mapID] = t end
              t[#t + 1] = { id = tonumber(id), mapID = mapID, x = x, y = y, zone = zone, faction = faction }
            end
          end
        end
      end
    end
  end

  if C_Map and C_Map.GetMapInfo then
    for mapID in pairs(mapIndex) do
      local info = C_Map.GetMapInfo(mapID)
      if info and info.parentMapID then
        local parentInfo = C_Map.GetMapInfo(info.parentMapID)
        if parentInfo and parentInfo.mapType == _G.Enum.UIMapType.Continent then
          zoneToContinent[mapID] = info.parentMapID
        end
      end
    end
  end
end

local function resolveNamesFor(vendorList)
  if not NPCNames or type(NPCNames.Get) ~= "function" then return end
  for i = 1, #vendorList do
    local vendor = vendorList[i]
    if vendor and vendor.id and not vendor.name then
      local cachedName = NPCNames.Get(vendor.id, function(_, name)
        if name then vendor.name = name end
      end)
      if cachedName then vendor.name = cachedName end
    end
  end
end

local function clearWorldPins()
  if not HBDPins then return end
  for icon in pairs(usedWorld) do
    HBDPins:RemoveWorldMapIcon(ADDON, icon)
    recycleFrame(icon)
  end
  wipe(usedWorld)
end

local function clearBadges()
  if not HBDPins then return end
  for icon in pairs(usedBadges) do
    HBDPins:RemoveWorldMapIcon(ADDON, icon)
    recycleFrame(icon)
  end
  wipe(usedBadges)
end

local function clearMiniPins()
  if not HBDPins then return end
  for icon in pairs(usedMini) do
    HBDPins:RemoveMinimapIcon(ADDON, icon)
    recycleFrame(icon)
  end
  wipe(usedMini)
end

local function getZoneCenterOnMap(zoneMapID, parentMapID)
  if not C_Map or not C_Map.GetMapRectOnMap then return nil end
  local minX, maxX, minY, maxY = C_Map.GetMapRectOnMap(zoneMapID, parentMapID)
  if minX and maxX and minY and maxY then
    return { x = (minX + maxX) / 2, y = (minY + maxY) / 2 }
  end
  return nil
end

local function countVendorsInZone(zoneMapID)
  local list = mapIndex[zoneMapID]
  return list and #list or 0
end

local function showZoneBadges(continentMapID)
  clearBadges()

  local style, color, size = getPinSettings()

  local zoneCounts = {}
  for zoneMapID, continentID in pairs(zoneToContinent) do
    if continentID == continentMapID then
      local count = countVendorsInZone(zoneMapID)
      if count > 0 then
        zoneCounts[zoneMapID] = count
      end
    end
  end

  for zoneMapID, vendorCount in pairs(zoneCounts) do
    local zoneCenter = getZoneCenterOnMap(zoneMapID, continentMapID)
    if zoneCenter then
      local zoneName = "Zone"
      if C_Map and C_Map.GetMapInfo then
        local info = C_Map.GetMapInfo(zoneMapID)
        if info then zoneName = info.name end
      end

      local frame = ensureBadgePool()
      frame.badgeData = {
        mapID = zoneMapID,
        zoneName = zoneName,
        vendorCount = vendorCount,
      }
      frame:SetSize(PIN_SIZE_BADGE * size, PIN_SIZE_BADGE * size)
      applyBadgeStyle(frame, style, color, size)
      frame.count:SetText(tostring(vendorCount))
      frame:Show()
      usedBadges[frame] = true

      pcall(function()
        HBDPins:AddWorldMapIconMap(ADDON, frame, continentMapID,
          zoneCenter.x, zoneCenter.y,
          HBD_PINS_WORLDMAP_SHOW_CONTINENT)
      end)
    end
  end
end

local function showContinentBadges()
  clearBadges()
  
  local style, color, size = getPinSettings()
  
  local continentCounts = {}
  for zoneMapID, continentID in pairs(zoneToContinent) do
    local count = countVendorsInZone(zoneMapID)
    if count > 0 then
      continentCounts[continentID] = (continentCounts[continentID] or 0) + count
    end
  end

  for continentID, vendorCount in pairs(continentCounts) do
    local continentName = "Continent"
    if C_Map and C_Map.GetMapInfo then
      local info = C_Map.GetMapInfo(continentID)
      if info then continentName = info.name end
    end

    local frame = ensureBadgePool()
    frame.badgeData = {
      mapID = continentID,
      zoneName = continentName,
      vendorCount = vendorCount,
    }
    frame:SetSize(PIN_SIZE_BADGE * size, PIN_SIZE_BADGE * size)
    applyBadgeStyle(frame, style, color, size)
    frame.count:SetText(tostring(vendorCount))
    frame:Show()
    usedBadges[frame] = true

    pcall(function()
      HBDPins:AddWorldMapIconMap(ADDON, frame, continentID,
        0.5, 0.5,
        HBD_PINS_WORLDMAP_SHOW_WORLD)
    end)
  end
end

local function addWorldPinsForMap(mapID)
  if not HBDPins then return end
  clearWorldPins()
  local vendorList = mapIndex[mapID]
  if type(vendorList) ~= "table" or #vendorList == 0 then return end

  resolveNamesFor(vendorList)

  local style, color, size = getPinSettings()
  
  for i = 1, #vendorList do
    local vendor = vendorList[i]
    local pinFrame = ensurePool()
    pinFrame.vendor = vendor
    pinFrame:SetSize(PIN_SIZE_WORLD * size, PIN_SIZE_WORLD * size)
    applyPinStyle(pinFrame, style, color, size)
    pinFrame:Show()
    usedWorld[pinFrame] = true
    pcall(function()
      HBDPins:AddWorldMapIconMap(ADDON, pinFrame, mapID, vendor.x, vendor.y, HBD_PINS_WORLDMAP_SHOW_PARENT)
    end)
  end
end

local function addMiniPinsForMap(mapID)
  if not HBDPins then return end
  clearMiniPins()
  local vendorList = mapIndex[mapID]
  if type(vendorList) ~= "table" or #vendorList == 0 then return end

  resolveNamesFor(vendorList)

  local style, color, size = getPinSettings()

  for i = 1, #vendorList do
    local vendor = vendorList[i]
    local pinFrame = ensurePool()
    pinFrame.vendor = vendor
    pinFrame:SetSize(PIN_SIZE_MINI * size, PIN_SIZE_MINI * size)
    applyPinStyle(pinFrame, style, color, size)
    pinFrame:Show()
    usedMini[pinFrame] = true
    pcall(function()
      HBDPins:AddMinimapIconMap(ADDON, pinFrame, mapID, vendor.x, vendor.y, true)
    end)
  end
end

local function isEnabled(profile, key, default)
  local mp = profile and profile.mapPins
  if type(mp) ~= "table" then return default end
  local v = mp[key]
  if v == nil then return default end
  return v and true or false
end

function MapPins:RefreshCurrentZone()
  if not self.enabled then return end
  local profile = NS.db and NS.db.profile
  if not profile then return end

  local currentMapID
  local mapTracker = NS.Systems and NS.Systems.MapTracker
  if mapTracker and type(mapTracker.GetCurrentZone) == "function" then
    local _, mapID = mapTracker:GetCurrentZone()
    currentMapID = mapID
  end
  currentMapID = tonumber(currentMapID)
  if not currentMapID then return end

  if isEnabled(profile, "minimap", true) then
    addMiniPinsForMap(currentMapID)
  else
    clearMiniPins()
  end
end

function MapPins:RefreshWorldMap()
  if not self.enabled then return end
  local prof = NS.db and NS.db.profile
  if not prof then return end

  if not isEnabled(prof, "worldmap", true) then
    clearWorldPins()
    clearBadges()
    return
  end

  local WM = _G.WorldMapFrame
  if not WM or type(WM.GetMapID) ~= "function" then return end
  local mapID = tonumber(WM:GetMapID())
  if not mapID then return end

  local mapInfo = C_Map and C_Map.GetMapInfo and C_Map.GetMapInfo(mapID)
  if not mapInfo then
    addWorldPinsForMap(mapID)
    return
  end

  if mapInfo.mapType == _G.Enum.UIMapType.World or mapInfo.mapType == _G.Enum.UIMapType.Cosmic then
    clearWorldPins()
    showContinentBadges()
  elseif mapInfo.mapType == _G.Enum.UIMapType.Continent then
    clearWorldPins()
    showZoneBadges(mapID)
  else
    clearBadges()
    addWorldPinsForMap(mapID)
  end
end

function MapPins:Enable()
  if self.enabled then return end
  if not HBDPins or not HBD then return end

  buildIndex()

  self.enabled = true

  local worldMap = _G.WorldMapFrame
  if worldMap and not self.hookedWorldMap then
    self.hookedWorldMap = true
    worldMap:HookScript("OnShow", function() MapPins:RefreshWorldMap() end)
    if type(worldMap.GetMapID) == "function" then
      pcall(function()
        hooksecurefunc(worldMap, "SetMapID", function() MapPins:RefreshWorldMap() end)
      end)
    end
  end

  local mapTracker = NS.Systems and NS.Systems.MapTracker
  if mapTracker and type(mapTracker.RegisterCallback) == "function" then
    pcall(function()
      mapTracker:RegisterCallback("MapPins", function() MapPins:RefreshCurrentZone() end)
    end)
  end


  if not self.waypointFrame then
    local waypointFrame = CreateFrame("Frame")
    waypointFrame.elapsed = 0
    waypointFrame:SetScript("OnUpdate", function(self, delta)
      self.elapsed = self.elapsed + delta
      if self.elapsed < 0.35 then return end
      self.elapsed = 0

      local waypoint = activeWaypoint
      if not waypoint or not waypoint.mapID then return end

      if HBD and type(HBD.GetPlayerZonePosition) == "function" then
        local playerX, playerY, playerMap = HBD:GetPlayerZonePosition(true)
        if playerMap == waypoint.mapID and playerX and playerY then
          local distance
          if type(HBD.GetZoneDistance) == "function" then
            distance = select(1, HBD:GetZoneDistance(waypoint.mapID, playerX, playerY, waypoint.mapID, waypoint.x, waypoint.y))
          end
          if not distance then
            local dx, dy = (waypoint.x - playerX), (waypoint.y - playerY)
            distance = ((dx*dx + dy*dy)^0.5) * 10000
          end
          if distance and distance <= WAYPOINT_CLEAR_YARDS then
            clearUserWaypoint()
            MapPins.RefreshTooltip()
          end
        end
      end
    end)
    self.waypointFrame = waypointFrame
  end

  if not self.merchantFrame then
    local merchantFrame = CreateFrame("Frame")
    merchantFrame:RegisterEvent("MERCHANT_SHOW")
    merchantFrame:SetScript("OnEvent", function()
      if activeWaypoint then
        clearUserWaypoint()
        MapPins.RefreshTooltip()
      end
    end)
    self.merchantFrame = merchantFrame
  end

  self:RefreshCurrentZone()
end

function MapPins:Disable()
  if not self.enabled then return end
  self.enabled = false
  clearWorldPins()
  clearBadges()
  clearMiniPins()
  clearUserWaypoint()
  if self.waypointFrame then
    self.waypointFrame:SetScript("OnUpdate", nil)
    self.waypointFrame = nil
  end
  if self.merchantFrame then
    self.merchantFrame:SetScript("OnEvent", nil)
    self.merchantFrame:UnregisterAllEvents()
    self.merchantFrame = nil
  end
end

return MapPins