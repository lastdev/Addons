---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['shh_veil_sethekk'] = {
  [53309130] = {
    icon = 'door-up',
    portal = maps['shh_halls_of_mourning'],
  },
}

points['shh_halls_of_mourning'] = {
  [50309490] = {
    icon = 'door-down',
    portal = maps['shh_veil_sethekk'],
  },
  [48202720] = {
    icon = 'door-right',
    portal = maps['shh_veil_sethekk'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
