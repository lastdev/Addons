---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['mv_dais_of_conquerors'] = {
  [32101270] = {
    icon = 'door-up',
    portal = maps['mv_repository'],
  },
}

points['mv_repository'] = {
  [77808340] = {
    icon = 'door-down',
    portal = maps['mv_dais_of_conquerors'],
  },
  [29305200] = {
    icon = 'door-left',
    portal = maps['mv_forge_of_endless'],
  },
}

points['mv_forge_of_endless'] = {
  [64301030] = {
    icon = 'door-right',
    portal = maps['mv_repository'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
