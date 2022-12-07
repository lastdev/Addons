---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['sbg_crypt_of_ancients'] = {
  [90005180] = {
    icon = 'poi-door-down',
    portal = maps['sbg_altar_of_shadow'],
  },
}

points['sbg_altar_of_shadow'] = {
  [06706410] = {
    icon = 'poi-door-up',
    portal = maps['sbg_crypt_of_ancients'],
  },
  [75607350] = {
    icon = 'poi-door-down',
    portal = maps['sbg_edge_of_reality'],
  },
}

points['sbg_edge_of_reality'] = {
  [44103850] = {
    icon = 'poi-door-up',
    portal = maps['sbg_crypt_of_ancients'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
