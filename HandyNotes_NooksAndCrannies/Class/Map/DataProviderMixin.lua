---
--- @file
--- Provides custom data (pois and paths) for map.
---

local NAME, this = ...

local API = this.API
local Map = this.Map
local points = this.points

---
--- Template for our custom pins. We need to define frame pin template.
---
--- @see DataProviderMixin.xml
---
local PinTemplate = NAME .. 'PinTemplate'

-- Create our data provider.
local DataProviderMixin = API:createFromMixins(API.MapCanvasDataProviderMixin)

---
--- Removes all our custom pins from map.
---
function DataProviderMixin:RemoveAllData()
  local map = self:GetMap()
  if not map then
    return
  end

  -- This removes all pins from our template. It also registers our pin template
  -- to world map canvas if it doesn't exists.
  map:RemoveAllPinsByTemplate(PinTemplate)
end

---
--- This method refreshes all data on map. We call it when we are hovering some point.
---
function DataProviderMixin:RefreshAllData(_)
  -- Remove all data, since we want to display only pois and paths for actual point.
  self:RemoveAllData()

  -- Load points for this map.
  local map = self:GetMap()
  local point = points[map:GetMapID()]

 -- We don't have any points on this map.
  if not point then
    return
  end

  -- Loop all points on this map
  for _, data in pairs(point) do
    -- if we are hovering point.
    if ((data['hover'] and data['hover'] == true) or (data['active'] and data['active'] == true)) then
      -- Check it for pois.
      if (data.POI) then
        -- We have pois, loop all of them.
        for _, coord in ipairs(data.POI) do
          -- Render pois.
          map:AcquirePin(PinTemplate, coord)
        end
      end
      -- Check it for paths.
      if (data.path) then
        -- Call path handler.
        Map:renderPath(data.path, map, PinTemplate)
      end
    end
  end
end

this.DataProviderMixin = DataProviderMixin
