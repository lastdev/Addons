---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['hof_oratorium_of_voice'] = {
  [31901500] = {
    icon = 'poi-door-up',
    portal = maps['hof_heart_of_fear'],
  },
}

points['hof_heart_of_fear'] = {
  [66402550] = {
    icon = 'poi-door-down',
    portal = maps['hof_oratorium_of_voice'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
