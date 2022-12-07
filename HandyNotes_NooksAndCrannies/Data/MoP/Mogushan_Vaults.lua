---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['mv_dais_of_conquerors'] = {
  [32101270] = {
    icon = 'poi-door-up',
    portal = maps['mv_repository'],
  },
}

points['mv_repository'] = {
  [77808340] = {
    icon = 'poi-door-down',
    portal = maps['mv_dais_of_conquerors'],
  },
  [29305200] = {
    icon = 'poi-door-left',
    portal = maps['mv_forge_of_endless'],
  },
}

points['mv_forge_of_endless'] = {
  [64301030] = {
    icon = 'poi-door-right',
    portal = maps['mv_repository'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
