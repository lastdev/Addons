---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['mec_mechanar'] = {
  [41702040] = {
    icon = 'door-up',
    portal = maps['mec_calculation_chamber'],
  },
}

points['mec_calculation_chamber'] = {
  [41803440] = {
    icon = 'door-down',
    portal = maps['mec_mechanar'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
