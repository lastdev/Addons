---
--- @file
--- Data structure and logic for points on map.
---

local _, this = ...

local API = this.API
local Cache = this.Cache
local HandyNotes = this.HandyNotes
local Text = this.Text
local t = this.t

local Point = {}

---
--- Prepares name (header) for tooltip
---
--- @param data
---   Map data for our point.
---
--- @return ?string
---   Returns name of point or nil.
---
function Point:prepareName(data)
  local name = data.name
  -- If there is no name, try to load name from game.

  -- Try to load map name.
  if name == nil and data.portal then
    name = Cache:get(data.portal, 'mapName')
    if (name == nil) then
      name = API:getMapName(data.portal)
      Cache:set(data.portal, name, 'mapName')
    end
  end

  if name ~= nil then
    -- Colorize name.
    name = Text:color(name, 'white')
  end

  -- Validate, if we got any response and send placeholder data if we didn't.
  if (name == nil) then
    name = t['fetching_data']
  end

  return name
end

---
--- Prepares content of tooltip we want to show.
---
--- @param GameTooltip
---   GameTooltip object, that will do the rendering.
--- @param data
---   Map data for our point.
--- @param uiMapId
---   Map, where we want to create waypoint.
---
function Point:prepareTooltip(GameTooltip, data, uiMapId)
  -- Up-value GameTooltip.
  self.GameTooltip = GameTooltip
  -- Define name of tooltip.
  local name = self:prepareName(data)

  -- Set tooltip header (name).
  self.GameTooltip:SetText(name)
  -- Add note to tooltip.

  self.GameTooltip:AddLine(data.note, nil, nil, nil, true)

  -- Add waypoint info to tooltip.
  self:prepareWaypointTooltip(uiMapId)
end

---
--- Prepares tooltip display for waypoint.
---
--- @param uiMapId
---   Map, where we want to create waypoint.
---
function Point:prepareWaypointTooltip(uiMapId)
  -- Waypoints on this map cannot be created.
  if (API:canSetUserWaypointOnMap(uiMapId) == false) then
    return
  end

  -- Add info, that player can create waypoint here.
  self.GameTooltip:AddLine(' ')
  self.GameTooltip:AddLine(Text:color(t['waypoint'], 'green'), nil, nil, nil, true)
end

---
--- Creates user waypoint on map (if creation is possible).
---
--- @param uiMapId
---   Map, where we want to create waypoint.
--- @param coord
---   Coordinates on map, where we will be placing waypoint.
---
function Point:createWaypoint(uiMapId, coord)
  -- Waypoints on this map cannot be created.
  if (API:canSetUserWaypointOnMap(uiMapId) == false) then
    return
  end

  -- Get map vector.
  local mapPoint = API.UiMapPoint.CreateFromCoordinates(uiMapId, HandyNotes:getXY(coord))

  -- Create waypoint and set it active.
  API:setUserWaypoint(mapPoint)
  API:setSuperTrackedUserWaypoint()
end

this.Point = Point
