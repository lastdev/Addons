---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['ud_ulduar'] = {
  [48700950] = {
    icon = 'door-down',
    portal = maps['ud_antechamber_of_ulduar'],
  },
}

points['ud_inner_sanctum_of_ulduar'] = {
  [51208380] = {
    icon = 'door-down',
    portal = maps['ud_antechamber_of_ulduar'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
