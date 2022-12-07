---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['shadowmoon_valley'] = {
  [24503330] = {
    icon = 'poi-door-left',
    type = 'world',
    portal = maps['bloodthorn_cave'],
  },
  [54901540] = {
    icon = 'poi-door-right',
    type = 'world',
    portal = maps['den_of_secrets'],
  },
}

points['bloodthorn_cave'] = {
  [72103070] = {
    icon = 'poi-door-right',
    portal = maps['shadowmoon_valley'],
  },
}

points['den_of_secrets'] = {
  [25402660] = {
    icon = 'poi-door-left',
    portal = maps['shadowmoon_valley'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
