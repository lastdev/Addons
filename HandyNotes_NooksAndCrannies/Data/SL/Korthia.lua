---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['korthia'] = {
  [60203230] = {
    icon = 'poi-door-down',
    type = 'world',
    portal = maps['cavern_of_contemplation'],
  },
  [30305490] = {
    icon = 'poi-door-down',
    type = 'world',
    portal = maps['gromit_hollow'],
  },
}

points['cavern_of_contemplation'] = {
  [42609060] = {
    icon = 'poi-door-up',
    type = 'world',
    portal = maps['korthia'],
  },
}

points['gromit_hollow'] = {
  [66203460] = {
    icon = 'poi-door-up',
    type = 'world',
    portal = maps['korthia'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
