---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['dtk_vestibules_of_draktharon'] = {
  [61807170] = {
    icon = 'door-left',
    portal = maps['dtk_draktharon_overlook'],
  },
}

points['dtk_draktharon_overlook'] = {
  [50907190] = {
    icon = 'door-right',
    portal = maps['dtk_vestibules_of_draktharon'],
  },
  [38301950] = {
    icon = 'door-down',
    portal = maps['dtk_vestibules_of_draktharon'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
