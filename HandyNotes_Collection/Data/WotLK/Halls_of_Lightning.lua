---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['hol_unyielding_garrison'] = {
  [89705370] = {
    icon = 'door-right',
    portal = maps['hol_walk_of_makers'],
  },
}

points['hol_walk_of_makers'] = {
  [56102090] = {
    icon = 'door-left',
    portal = maps['hol_unyielding_garrison'],
  },
  [19004070] = {
    icon = 'door-up',
    portal = maps['hol_unyielding_garrison'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
