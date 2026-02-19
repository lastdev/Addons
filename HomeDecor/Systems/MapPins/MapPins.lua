local ADDON, NS = ...
NS.Systems = NS.Systems or {}

local MapPins = NS.Systems.MapPins or {}
NS.Systems.MapPins = MapPins

local CreateFrame = CreateFrame
local U = NS.Systems.MapPinsUtil
local D = NS.Systems.MapPinsData
local P = NS.Systems.MapPinsPools
local R = NS.Systems.MapPinsRefresh
local LibStub = LibStub
local HBD = LibStub and LibStub("HereBeDragons-2.0", true)
local HBDPins = LibStub and LibStub("HereBeDragons-Pins-2.0", true)
local C_Map = C_Map

local activeWaypointRef = {}

function MapPins:ClearUserWaypoint()
  U.ClearUserWaypoint(activeWaypointRef)
end

function MapPins:SetUserWaypoint(mapID, x, y, npcID)
  U.SetUserWaypoint(mapID, x, y, npcID, activeWaypointRef)
end

function MapPins:IsActiveWaypoint(mapID, x, y, npcID)
  return U.IsActiveWaypoint(activeWaypointRef[1], mapID, x, y, npcID)
end

function MapPins.RefreshTooltip()
  local GameTooltip = GameTooltip
  if not GameTooltip or not GameTooltip.IsShown or not GameTooltip:IsShown() then return end
  local owner = GameTooltip.GetOwner and GameTooltip:GetOwner()
  if not owner or not (owner.isMapPin or owner.isMapBadge) then return end
  if owner.IsMouseOver and not owner:IsMouseOver() then return end
  local onEnter = owner.GetScript and owner:GetScript("OnEnter")
  if type(onEnter) ~= "function" then return end
  pcall(onEnter, owner)
end

local modifierFrame = CreateFrame("Frame")
modifierFrame:RegisterEvent("MODIFIER_STATE_CHANGED")
modifierFrame:SetScript("OnEvent", function()
  MapPins.RefreshTooltip()
end)

function MapPins:RefreshCurrentZone()
  if not self.enabled then return end
  local profile = NS.db and NS.db.profile
  if not profile then return end

  local currentMapID
  local mapTracker = NS.Systems and NS.Systems.MapTracker
  if mapTracker and type(mapTracker.GetCurrentZone) == "function" then
    local zoneName, mapID = mapTracker:GetCurrentZone()
    currentMapID = mapID
  end
  currentMapID = tonumber(currentMapID)
  if not currentMapID then return end

  if U.IsEnabled(profile, "minimap", true) then
    R.AddMiniPinsForMap(currentMapID)
  else
    P.ClearMiniPins()
  end
end

function MapPins:RefreshWorldMap()
  if not self.enabled then return end
  local profile = NS.db and NS.db.profile
  if not profile then return end

  if not U.IsEnabled(profile, "worldmap", true) then
    P.ClearWorldPins()
    P.ClearBadges()
    return
  end

  local WorldMapFrame = WorldMapFrame
  if not WorldMapFrame or type(WorldMapFrame.GetMapID) ~= "function" then return end
  local mapID = tonumber(WorldMapFrame:GetMapID())
  if not mapID then return end

  local mapInfo = C_Map and C_Map.GetMapInfo and C_Map.GetMapInfo(mapID)
  if not mapInfo then
    R.AddWorldPinsForMap(mapID)
    return
  end

  local worldType = Enum.UIMapType.World
  local cosmicType = Enum.UIMapType.Cosmic
  local continentType = Enum.UIMapType.Continent
  if mapInfo.mapType == worldType or mapInfo.mapType == cosmicType then
    P.ClearWorldPins()
    R.ShowContinentBadges()
  elseif mapInfo.mapType == continentType then
    P.ClearWorldPins()
    R.ShowZoneBadges(mapID)
  else
    P.ClearBadges()
    R.AddWorldPinsForMap(mapID)
  end
end

function MapPins:Enable()
  if self.enabled then return end
  if not HBDPins or not HBD then return end

  D.BuildIndex()
  self.enabled = true

  local worldMap = WorldMapFrame
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
      local waypoint = activeWaypointRef[1]
      if not waypoint or not waypoint.mapID then return end
      if HBD and type(HBD.GetPlayerZonePosition) == "function" then
        local playerX, playerY, playerMap = HBD:GetPlayerZonePosition(true)
        if playerMap == waypoint.mapID and playerX and playerY then
          local distance
          if type(HBD.GetZoneDistance) == "function" then
            distance = select(1, HBD:GetZoneDistance(waypoint.mapID, playerX, playerY, waypoint.mapID, waypoint.x, waypoint.y))
          end
          if not distance then
            local deltaX = waypoint.x - playerX
            local deltaY = waypoint.y - playerY
            distance = ((deltaX * deltaX + deltaY * deltaY) ^ 0.5) * 10000
          end
          local clearYards = U and U.WAYPOINT_CLEAR_YARDS or 25
          if distance and distance <= clearYards then
            MapPins:ClearUserWaypoint()
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
      if activeWaypointRef[1] then
        MapPins:ClearUserWaypoint()
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
  P.ClearWorldPins()
  P.ClearBadges()
  P.ClearMiniPins()
  self:ClearUserWaypoint()
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
