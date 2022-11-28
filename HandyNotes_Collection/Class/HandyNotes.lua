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
local Icon = this.Icon
local Map = this.Map
local Summary = this.Summary
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
  Point:prepareTooltip(GameTooltip, this.points[uiMapId][coord], uiMapId)
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
    -- Waypoint creation on shift click.
    if (API:IsShiftKeyDown() and down == false) then
      Point:createWaypoint(uiMapId, coord)
    end

    -- Activation and deactivation of a point (displaying pois and paths even if we hover out).
    local active = true
    if (down == true) then
      if (this.points[uiMapId][coord]['active'] and this.points[uiMapId][coord]['active'] == true) then
        active = false
      end
      this.points[uiMapId][coord]['active'] = active
    end
  end
end

do
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
        local scale, opacity = Map:prepareSize(point)

        -- Fill up summary point, if we have any.
        if (point.summary) then
          point.name = API:getMapName(point.summary)
          point.icon = 'summary'
          point.loot = Summary:preparePoint(this.points[point.summary])
        end

        -- Completion status for point.
        local completed = Point:isCompleted(point)

        -- Check, whether point should be shown.
        local show = Map:showPoint(completed)

        if (show == true) then
          -- Create icon for to display on map.
          local icon = {
            icon = Icon.list[point.icon],
            r = 255,
            g = 0,
            b = 0,
          }

          -- Change icon color, if they were completed.
          if (completed == true) then
            icon.r = 0
            icon.g = 255
            icon.b = 0
          end

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
  HandyNotes_CollectionCACHE = HandyNotes_CollectionCACHE or {}
  self.cache = HandyNotes_CollectionCACHE
  -- Our storage for completed stuff.
  HandyNotes_CollectionSTATUS = HandyNotes_CollectionSTATUS or {}
  self.status = HandyNotes_CollectionSTATUS
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

  self:RegisterEvent('CRITERIA_UPDATE', 'Refresh')
  self:RegisterEvent('CRITERIA_EARNED', 'Refresh')
  self:RegisterEvent('QUEST_TURNED_IN', 'Refresh')
  self:RegisterEvent('ACHIEVEMENT_EARNED', 'Refresh')
  self:RegisterEvent('NEW_PET_ADDED', 'Refresh')
  self:RegisterEvent('NEW_TOY_ADDED', 'Refresh')
  self:RegisterEvent('NEW_MOUNT_ADDED', 'Refresh')
end

---
--- Updates our Addon every time registered event is called.
---
--- @see Addon:OnEnable
---
function Addon:Refresh()
  self:SendMessage('HandyNotes_NotifyUpdate', NAME)
end
