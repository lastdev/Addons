---
--- @file
--- Handles map manipulation.
---
---
local _, this = ...

local Map = {}

---
--- Defines scale and opacity for pin.
---
--- @param point
---   Point, we are evaluating.
---
--- @return number
---   Scale for pin.
--- @return number
---   Opacity for item (0-1).
---
function Map:prepareSize(point)
  local scale = 2 * this.Addon.db.profile.scale
  local opacity = this.Addon.db.profile.opacity

  -- Check, if we have scale or opacity configured in point and rewrite user config.
  if (point.scale) then
    scale = point.scale
  end
  if (point.opacity) then
    opacity = point.opacity
  end

  -- Convert percent to 0 - 1 values.
  opacity = opacity / 100

  return scale, opacity
end

---
--- Decides, if point should be shown on map
---
--- @param completed
---   Bool, if everything on this point has been completed.
---
--- @return boolean
---   True, if we should display point, false otherwise.
---
function Map:showPoint(completed)
  local show = false
  if (this.Addon.db.profile.showCollection == true and (completed == false or this.Addon.db.profile.completed == true)) then
    show = true
  end

  return show
end

---
--- Renders path for point (usually where npc roams).
---
--- @param paths
---   Paths we are drawing.
--- @param map
---   Map, we are drawing paths to.
--- @param template
---   Map PinTemplate, it is like a storage, so we can remove it later.
---
function Map:renderPath(paths, map, template)
  -- Storage for previous coordinate so we send both of them to map.
  local prevCoord
  -- We have path, loop all of them and check, if we have multiple paths or single.
  for _, path in ipairs(paths) do
    -- Multiple paths.
    if (type(path) == 'table') then
      prevCoord = nil
      for _, coord in ipairs(path) do
        -- Render path.
        if (prevCoord) then
          map:AcquirePin(template, coord, prevCoord)
        end
        prevCoord = coord
      end
    end
    -- Single path.
    if (type(path) == 'number') then
      -- Render path.
      if (prevCoord) then
        map:AcquirePin(template, path, prevCoord)
      end
      prevCoord = path
    end
  end
end

this.Map = Map
