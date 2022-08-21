---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['brd_detention_block'] = {
  [65902830] = {
    icon = 'door-up',
    portal = maps['brd_shadowforge_city'],
  },
}

points['brd_shadowforge_city'] = {
  [65805610] = {
    icon = 'door-down',
    portal = maps['brd_detention_block'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
