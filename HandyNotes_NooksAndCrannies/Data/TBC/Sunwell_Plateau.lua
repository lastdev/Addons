---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['swp_sunwell_plateau'] = {
  [68102490] = {
    icon = 'poi-door-up',
    portal = maps['swp_shrine_of_eclipse'],
  },
}

points['swp_shrine_of_eclipse'] = {
  [53101370] = {
    icon = 'poi-door-down',
    portal = maps['swp_sunwell_plateau'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
