---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['stv_steamvault'] = {
  [47607740] = {
    icon = 'door-down',
    portal = maps['stv_cooling_pools'],
  },
}

points['stv_cooling_pools'] = {
  [47907670] = {
    icon = 'door-up',
    portal = maps['stv_steamvault'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
