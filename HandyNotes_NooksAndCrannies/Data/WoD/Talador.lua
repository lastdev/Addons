---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['talador'] = {
  [41205990] = {
    icon = 'poi-door-down',
    type = 'world',
    portal = maps['tomb_of_souls'],
  },
  [58906480] = {
    icon = 'poi-door-down',
    type = 'world',
    portal = maps['tomb_of_lights'],
  },
}

points['tomb_of_souls'] = {
  [48608810] = {
    icon = 'poi-door-up',
    portal = maps['talador'],
  },
}

points['tomb_of_lights'] = {
  [30103300] = {
    icon = 'poi-door-up',
    portal = maps['talador'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
