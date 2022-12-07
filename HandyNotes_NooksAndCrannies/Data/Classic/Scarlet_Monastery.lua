---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['sm_forlorn_cloister'] = {
  [48609210] = {
    icon = 'poi-door-down',
    portal = maps['sm_crusaders_chapel'],
  },
}

points['sm_crusaders_chapel'] = {
  [49200990] = {
    icon = 'poi-door-up',
    portal = maps['sm_forlorn_cloister'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
