---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['hot_hour_of_twilight'] = {
  [50008520] = {
    icon = 'door-down',
    portal = maps['hot_wyrmrest_temple'],
  },
}

points['hot_wyrmrest_temple'] = {
    [44801440] = {
    icon = 'door-up',
    portal = maps['hot_hour_of_twilight'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
