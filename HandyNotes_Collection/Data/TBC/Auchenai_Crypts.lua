---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['auc_halls_of_hereafter'] = {
  [42601720] = {
    icon = 'door-up',
    portal = maps['auc_bridge_of_souls'],
  },
}

points['auc_bridge_of_souls'] = {
  [24901230] = {
    icon = 'door-down',
    portal = maps['auc_halls_of_hereafter'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
