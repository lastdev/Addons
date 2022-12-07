---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['mgt_observation_grounds'] = {
  [83204620] = {
    icon = 'poi-door-down',
    portal = maps['mgt_grand_magisters_asylum'],
  },
}

points['mgt_grand_magisters_asylum'] = {
  [83203710] = {
    icon = 'poi-door-up',
    portal = maps['mgt_observation_grounds'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
