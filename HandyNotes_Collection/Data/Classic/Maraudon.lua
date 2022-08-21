---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['mrd_caverns_of_maraudon'] = {
  [15105600] = {
    icon = 'door-left',
    portal = maps['mrd_zaetars_grave'],
  },
}

points['mrd_zaetars_grave'] = {
  [29100450] = {
    icon = 'door-right',
    portal = maps['mrd_caverns_of_maraudon'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
