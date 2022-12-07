---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['bf_workshop'] = {
  [28505360] = {
    icon = 'poi-door-down',
    portal = maps['bf_black_forge'],
  },
  [50806840] = {
    icon = 'poi-door-left',
    portal = maps['bf_slagworks'],
  },
  [53504240] = {
    icon = 'poi-door-right',
    portal = maps['bf_iron_assembly'],
  },
  [34901510] = {
    icon = 'poi-door-left',
    portal = maps['bf_crucible'],
  },
}

points['bf_black_forge'] = {
  [46905710] = {
    icon = 'poi-door-up',
    portal = maps['bf_workshop'],
  },
}

points['bf_slagworks'] = {
  [65005350] = {
    icon = 'poi-door-left',
    portal = maps['bf_workshop'],
  },
}

points['bf_iron_assembly'] = {
  [41308420] = {
    icon = 'poi-door-left',
    portal = maps['bf_workshop'],
  },
  [54904870] = {
    icon = 'poi-door-down',
    portal = maps['bf_black_forge'],
  },
}

points['bf_crucible'] = {
  [53209210] = {
    icon = 'poi-door-right',
    portal = maps['bf_workshop'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
