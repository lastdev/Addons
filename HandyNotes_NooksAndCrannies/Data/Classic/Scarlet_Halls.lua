---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['sh_training_grounds'] = {
  [55601420] = {
    icon = 'poi-door-up',
    portal = maps['sh_athenaeum'],
  },
}

points['sh_athenaeum'] = {
  [47709340] = {
    icon = 'poi-door-down',
    portal = maps['sh_training_grounds'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
