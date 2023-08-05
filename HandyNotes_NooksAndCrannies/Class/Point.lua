---
--- @file
--- Data structure and logic for points on map.
---

local NAME, this = ...

local Addon = this.Addon
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
---
function Point:prepareTooltip(GameTooltip, data)
  -- Up-value GameTooltip.
  self.GameTooltip = GameTooltip
  -- Define name of tooltip.
  local name = self:prepareName(data)

  -- Set tooltip header (name).
  self.GameTooltip:SetText(name)
  -- Add note to tooltip.

  self.GameTooltip:AddLine(data.note, nil, nil, nil, true)
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

---
--- Hides point from map.
---
--- @param uiMapId
---   Map, where we want to create waypoint.
--- @param coord
---   Coordinates on map, where we will be placing waypoint.
--- @param global
---   Should we hide it in global profile or personal profile.
---
function Point:hidePoint(uiMapId, coord, global)
  -- Check, whether it will be hidden in personal or global profile.
  if (global == true) then
    if (not this.Addon.db.global[uiMapId]) then
      this.Addon.db.global[uiMapId] = {}
    end
    this.Addon.db.global[uiMapId][coord] = true
  else
    if (not this.Addon.db.char[uiMapId]) then
      this.Addon.db.char[uiMapId] = {}
    end
    this.Addon.db.char[uiMapId][coord] = true
  end
  Addon:Refresh()
end

---
--- Resets hidden points on maps.
---
--- @param global
---   Should we reset only personal profile or global too.
---
function Point:resetHiddenPoints(global)
  -- Check, whether it will be hidden in personal or global profile.
  if (global == true) then
    this.Addon.db.global = {}
  end

  this.Addon.db.char = {}
end

---
--- Creates contextual menu for each point.
---
--- @link https://wowpedia.fandom.com/wiki/API_UIDropDownMenu_Initialize
---
--- @param uiMapId
---   Map, where we want to create waypoint.
--- @param coord
---   Coordinates on map, where we will be placing waypoint.
--- @param data
---   All data related to point on map.
---
--- @return table
---   Frame with menu and buttons inside.
---
function Point:createContextualMenu(uiMapId, coord, data)
  local menu = API:prepareMenu()

  menu.initialize = function()
    self:prepareMenu(uiMapId, coord, data)
  end

  return menu
end

---
--- Prepares menu content (eg. buttons, labels).
---
--- @param uiMapId
---   Map, where we want to create waypoint.
--- @param coord
---   Coordinates on map, where we will be placing waypoint.
--- @param data
---   All data related to point on map.
---
function Point:prepareMenu(uiMapId, coord, data)
  local name = self:prepareName(data)

  local button = API:menuButtonPrepare()
  -- Add header.
  button.text = name
  button.isTitle = true
  API:menuAddButton(button)

  -- Add blank line.
  API:menuAddSpacer()

  -- Add navigation button.
  button = API:menuButtonPrepare()
  button.text = t['navigate']
  -- Tooltips doesn't work without title filled.
  button.tooltipTitle = t['waypoint_title']
  button.tooltipOnButton = 1

  -- Waypoints on this map cannot be created.
  if (API:canSetUserWaypointOnMap(uiMapId) == false) then
    button.disabled = true
    button.tooltipWhileDisabled = 1
    button.tooltipWarning = t['waypoint_fail']
  else
    button.tooltipInstruction = t['waypoint']
    button.func = function()
      self:createWaypoint(uiMapId, coord)
    end

  end
  API:menuAddButton(button)

  -- Add hide point buttons.
  button = API:menuButtonPrepare()
  button.text = t['hide_personal']
  button.tooltipTitle = t['hide_tooltip_title']
  button.tooltipOnButton = 1
  button.tooltipInstruction = t['hide_tooltip']
  button.func = function()
    self:hidePoint(uiMapId, coord)
  end
  API:menuAddButton(button)

  button = API:menuButtonPrepare()
  button.text = t['hide_global']
  button.tooltipTitle = t['hide_tooltip_title']
  button.tooltipOnButton = 1
  button.tooltipInstruction = t['hide_tooltip']
  button.func = function()
    self:hidePoint(uiMapId, coord, true)
  end
  API:menuAddButton(button)

  -- Add blank line.
  API:menuAddSpacer()

  -- Add close button.
  button = API:menuButtonPrepare()
  button.text = API.closeLabel
  button.func = function()
    API:closeMenu()
  end
  API:menuAddButton(button)

  -- Add blank line.
  API:menuAddSpacer()

  -- Add addon name for references.
  button = API:menuButtonPrepare()
  button.text = NAME
  button.disabled = true
  API:menuAddButton(button)
end

this.Point = Point
