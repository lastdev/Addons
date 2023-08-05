---
--- @file
--- Implements functionality to integrate addon with HandyNotes.
---

local NAME, this = ...

local LibStub = this.LibStub
local HandyNotes = this.HandyNotes
local Addon = this.Addon
local Point = this.Point
local API = this.API
local Cache = this.Cache
local Map = this.Map
local GameTooltip = API.GameTooltip
local DataProviderMixin = this.DataProviderMixin

local HandyNotesPlugin = {}

---
--- This function is called when you hover over icon on the map.
---
--- @see pluginHandler:OnEnter
--- @link https://github.com/Nevcairiel/HandyNotes/blob/master/HandyNotes.lua
---
function HandyNotesPlugin:OnEnter(uiMapId, coord)
  -- Tooltip positioning in map (so it doesn't overflow window).
  local tooltipPosition = 'ANCHOR_RIGHT'
  if (self:GetCenter() > API:getUIParentCenter()) then
    tooltipPosition = 'ANCHOR_LEFT'
  end
  GameTooltip:SetOwner(self, tooltipPosition)

  -- Pass GameTooltip object and point data to another function, that will render tooltip.
  Point:prepareTooltip(GameTooltip, this.points[uiMapId][coord])
  -- Display tooltip.
  GameTooltip:Show()

  -- Set state (focus) on point, so we know, we have to render pois, if there are any.
  this.points[uiMapId][coord]['hover'] = true
  -- Render any POI / Path this point has.
  DataProviderMixin:RefreshAllData()
end

---
--- This function is called when you leave icon on the map.
---
--- @see pluginHandler:OnLeave
--- @link https://github.com/Nevcairiel/HandyNotes/blob/master/HandyNotes.lua
---
function HandyNotesPlugin:OnLeave(uiMapId, coord)
  -- Keep tooltip visible when holding alt button.
  if (API:IsAltKeyDown() == false) then
    GameTooltip:Hide()
  end

  -- Unfocus point.
  this.points[uiMapId][coord]['hover'] = false
  -- Refreshing removes all icons and adds icons for points, that are active.
  DataProviderMixin:RefreshAllData()
end

---
--- This function is called when you click icon on the map.
---
--- @see pluginHandler:OnClick
--- @link https://github.com/Nevcairiel/HandyNotes/blob/master/HandyNotes.lua
---
function HandyNotesPlugin:OnClick(button, down, uiMapId, coord)
  -- Left button actions.
  if (button == 'LeftButton') then
    -- Change map on click.
    if (API:IsShiftKeyDown() == false and down == true and this.points[uiMapId][coord]['portal']) then
      API:changeMap(this.points[uiMapId][coord]['portal'])

      return;
    end

    -- Waypoint creation on shift click.
    if (API:IsShiftKeyDown() and down == false) then
      Point:createWaypoint(uiMapId, coord)
    end
    -- Right button actions.
  elseif (button == 'RightButton' and down == true) then
    -- Each menu rewrites the previous one. If this would be an issue, we can create menu
    -- for each separate point and store it into some variable.
    local menu = Point:createContextualMenu(uiMapId, coord, this.points[uiMapId][coord])
    API:openMenu(menu, self)
  end
end

do
  -- Assign variable for map ID we are cycling.
  local mapId = nil

  ---
  --- This is an iterator that is used by HandyNotes to iterate over every node in given zone.
  ---
  --- Iterator function is required by HandyNotes.
  ---
  --- @param table
  ---   Our table with data we want to iterate over.
  --- @param prestate
  ---   Index of table we want to start at.
  ---
  local function iter(table, prestate)
    -- If we don't have any data, quit.
    if not table then
      return nil
    end

    -- Get values for first point.
    local coordinates, point = next(table, prestate)
    -- Iterate until we reach end of table with points for this map.
    while coordinates do
      -- If we have any data for our point.
      if point then
        -- Check, whether we should display point on map.
        local show = Map:showPoint(mapId, coordinates)

        if (show == true) then
          local scale, opacity = Map:prepareSize(point)

          -- Create icon for to display on map.
          local icon = API:GetAtlasInfo(point.icon)

          return coordinates, nil, icon, scale, opacity
        end
      end

      -- Load next point for this map.
      coordinates, point = next(table, coordinates)
    end

    return nil, nil, nil, nil, nil
  end

  ---
  --- Required function by HandyNotes.
  ---
  --- @param uiMapId
  ---   The zone ID we want data for.
  --- @param _
  ---   Boolean indicating if we want to get nodes to display on the minimap.
  ---
  --- @return function iter()
  ---   Our custom iterator, that will loop over each point in given map.
  --- @return table point
  ---   Our points table for given map.
  ---
  function HandyNotesPlugin:GetNodes2(uiMapId, _)
    mapId = uiMapId
    -- @todo Handle minimap (second param).
    return iter, this.points[uiMapId], nil
  end
end

---
--- Creates storage in SavedVariables for our addon and registers it with HandyNotes.
---
--- This is AceDB-3.0 function.
--- @link https://www.wowace.com/projects/ace3/pages/getting-started#title-2-2
---
function Addon:OnInitialize()
  -- Set up our database.
  self.db = LibStub('AceDB-3.0'):New(NAME .. 'DB', this.defaults)
  -- Our cache, so we don't have to query game api so much.
  HandyNotes_NooksAndCranniesCACHE = HandyNotes_NooksAndCranniesCACHE or {}
  self.cache = HandyNotes_NooksAndCranniesCACHE
  Cache:initialize()
  -- Initialize our database with HandyNotes.
  HandyNotes:RegisterPluginDB(NAME, HandyNotesPlugin, this.options)
end

---
--- Registers events when you enable addon.
---
--- This is AceDB-3.0 function.
--- @link https://www.wowace.com/projects/ace3/pages/getting-started#title-2-2
---
function Addon:OnEnable()
  -- Add our custom data provider for pois and paths.
  API.WorldMapFrame:AddDataProvider(DataProviderMixin)
end

---
--- Updates our Addon every time registered event is called.
---
--- @see Addon:OnEnable
---
function Addon:Refresh()
  self:SendMessage('HandyNotes_NotifyUpdate', NAME)
end

---
--- Handles button click in Addon Compartment.
---
--- @link https://wowpedia.fandom.com/wiki/Addon_compartment
---
function HandyNotes_NooksAndCrannies_OnAddonCompartmentClick()
  API.Settings.OpenToCategory('HandyNotes')
  LibStub('AceConfigDialog-3.0'):SelectGroup('HandyNotes', 'plugins', NAME)
end
