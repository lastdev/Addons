---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['toc_argent_coliseum'] = {
  [55505270] = {
    icon = 'poi-door-down',
    portal = maps['toc_icy_depths'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
