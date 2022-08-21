---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['bf_workshop'] = {
  [28505360] = {
    icon = 'door-down',
    portal = maps['bf_black_forge'],
  },
  [50806840] = {
    icon = 'door-left',
    portal = maps['bf_slagworks'],
  },
  [53504240] = {
    icon = 'door-right',
    portal = maps['bf_iron_assembly'],
  },
  [34901510] = {
    icon = 'door-left',
    portal = maps['bf_crucible'],
  },
}

points['bf_black_forge'] = {
  [46905710] = {
    icon = 'door-up',
    portal = maps['bf_workshop'],
  },
}

points['bf_slagworks'] = {
  [65005350] = {
    icon = 'door-left',
    portal = maps['bf_workshop'],
  },
}

points['bf_iron_assembly'] = {
  [41308420] = {
    icon = 'door-left',
    portal = maps['bf_workshop'],
  },
  [54904870] = {
    icon = 'door-down',
    portal = maps['bf_black_forge'],
  },
}

points['bf_crucible'] = {
  [53209210] = {
    icon = 'door-right',
    portal = maps['bf_workshop'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
