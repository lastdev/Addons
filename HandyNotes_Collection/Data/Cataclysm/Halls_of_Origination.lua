---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['hoo_vault_of_lights'] = {
  [89304950] = {
    icon = 'door-right',
    portal = maps['hoo_tomb_of_earthrager'],
  },
  [67504970] = {
    icon = 'door-up',
    portal = maps['hoo_four_seats'],
  },
}

points['hoo_tomb_of_earthrager'] = {
  [33404920] = {
    icon = 'door-left',
    portal = maps['hoo_vault_of_lights'],
  },
}

points['hoo_four_seats'] = {
  [47204940] = {
    icon = 'door-down',
    portal = maps['hoo_vault_of_lights'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
