---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['brc_chamber_of_incineration'] = {
  [54202310] = {
    icon = 'door-up',
    portal = maps['brc_twilight_forge'],
  },
}

points['brc_twilight_forge'] = {
  [34101410] = {
    icon = 'door-up',
    portal = maps['brc_chamber_of_incineration'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
