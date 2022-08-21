---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['thot_abyssal_halls'] = {
  [50103070] = {
    icon = 'door-up',
    portal = maps['thot_throne_of_neptulon'],
  },
}

points['thot_throne_of_neptulon'] = {
  [50508310] = {
    icon = 'door-down',
    portal = maps['thot_abyssal_halls'],
  },
  [51505140] = {
    icon = 'door-down',
    portal = maps['thot_abyssal_halls'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
