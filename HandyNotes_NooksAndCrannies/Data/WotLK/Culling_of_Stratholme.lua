---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['cos_culling_of_stratholme'] = {
  [47302010] = {
    icon = 'poi-door-up',
    portal = maps['cos_stratholme_city'],
  },
}

points['cos_stratholme_city'] = {
  [50508610] = {
    icon = 'poi-door-down',
    portal = maps['cos_culling_of_stratholme'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
