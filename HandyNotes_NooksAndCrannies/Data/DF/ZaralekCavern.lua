---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['zaralek_cavern'] = {
  [60503700] = {
    icon = 'poi-door-down',
    type = 'world',
    portal = maps['zaralek_cavern_mini'],
  },
  [61503880] = {
    icon = 'poi-door-down',
    type = 'world',
    portal = maps['zaralek_cavern_mini'],
  },
}

points['zaralek_cavern_mini'] = {
  [10305230] = {
    icon = 'poi-door-up',
    type = 'world',
    portal = maps['zaralek_cavern'],
  },
  [26008180] = {
    icon = 'poi-door-up',
    type = 'world',
    portal = maps['zaralek_cavern'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
