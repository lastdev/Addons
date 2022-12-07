---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps
local t = this.t

points['warspear'] = {
  [60705160] = {
    icon = 'warlockportal-yellow-32x32',
    portal = maps['orgrimmar'],
  },
  [49508450] = {
    icon = 'poi-door-down',
    portal = maps['ashran'],
  },
  [44103390] = {
    name = t['flight_master'],
    icon = 'flightmaster',
    type = 'world',
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
