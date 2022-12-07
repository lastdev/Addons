---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['fl_firelands'] = {
  [49301070] = {
    icon = 'poi-door-up',
    portal = maps['fl_sulfuron_keep'],
  },
}

points['fl_sulfuron_keep'] = {
  [51009540] = {
    icon = 'poi-door-down',
    portal = maps['fl_firelands'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
