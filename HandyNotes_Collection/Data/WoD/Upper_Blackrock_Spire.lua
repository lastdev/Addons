---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['ubrs_dragonspire_hall'] = {
  [30401450] = {
    icon = 'door-up',
    portal = maps['ubrs_rookery'],
  },
}

points['ubrs_rookery'] = {
  [30301550] = {
    icon = 'door-down',
    portal = maps['ubrs_dragonspire_hall'],
  },
  [28404150] = {
    icon = 'door-up',
    portal = maps['ubrs_hall_of_blackhand'],
  },
}

points['ubrs_hall_of_blackhand'] = {
  [28404020] = {
    icon = 'door-down',
    portal = maps['ubrs_rookery'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
