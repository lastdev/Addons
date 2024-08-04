---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['highmountain'] = {
  [42402440] = {
    icon = 'poi-door-down',
    type = 'world',
    portal = maps['stonedark_grotto'],
  },
}

points['stonedark_grotto'] = {
  [20607940] = {
    icon = 'poi-door-up',
    type = 'world',
    portal = maps['highmountain'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
