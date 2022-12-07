---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['gm_hall_of_gears'] = {
  [34806400] = {
    icon = 'poi-door-down',
    portal = maps['gm_dormitory'],
  },
  [47708490] = {
    icon = 'poi-door-down',
    portal = maps['gm_dormitory'],
  },
}

points['gm_dormitory'] = {
  [61406050] = {
    icon = 'poi-door-up',
    portal = maps['gm_hall_of_gears'],
  },
  [73608070] = {
    icon = 'poi-door-up',
    portal = maps['gm_hall_of_gears'],
  },
  [42808300] = {
    icon = 'poi-door-down',
    portal = maps['gm_launch_bay'],
  },
}

points['gm_launch_bay'] = {
  [44604330] = {
    icon = 'poi-door-up',
    portal = maps['gm_dormitory'],
  },
  [23404980] = {
    icon = 'poi-door-down',
    portal = maps['gm_tinkers_court'],
  },
}

points['gm_tinkers_court'] = {
  [46705530] = {
    icon = 'poi-door-up',
    portal = maps['gm_launch_bay'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
