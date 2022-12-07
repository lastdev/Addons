---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['sfk_courtyard'] = {
  [15008680] = {
    icon = 'poi-door-down',
    portal = maps['sfk_dining_hall'],
  },
  [38003870] = {
    icon = 'poi-door-down',
    portal = maps['sfk_dining_hall'],
  },
  [35906690] = {
    icon = 'poi-door-up',
    portal = maps['sfk_wall_walk'],
  },
}

points['sfk_dining_hall'] = {
  [27208870] = {
    icon = 'poi-door-up',
    portal = maps['sfk_courtyard'],
  },
  [61701160] = {
    icon = 'poi-door-up',
    portal = maps['sfk_courtyard'],
  },
}

points['sfk_wall_walk'] = {
  [23707510] = {
    icon = 'poi-door-down',
    portal = maps['sfk_courtyard'],
  },
  [44203250] = {
    icon = 'poi-door-up',
    portal = maps['sfk_vacant_den'],
  },
}

points['sfk_vacant_den'] = {
  [53206050] = {
    icon = 'poi-door-down',
    portal = maps['sfk_wall_walk'],
  },
  [51708970] = {
    icon = 'poi-door-up',
    portal = maps['sfk_lower_observatory'],
  },
}

points['sfk_lower_observatory'] = {
  [52208880] = {
    icon = 'poi-door-down',
    portal = maps['sfk_vacant_den'],
  },
  [42807370] = {
    icon = 'poi-door-up',
    portal = maps['sfk_upper_observatory'],
  },
}

points['sfk_upper_observatory'] = {
  [47507660] = {
    icon = 'poi-door-down',
    portal = maps['sfk_lower_observatory'],
  },
  [42507310] = {
    icon = 'poi-door-up',
    portal = maps['sfk_lord_godfreys_chamber'],
  },
}

points['sfk_lord_godfreys_chamber'] = {
  [41808450] = {
    icon = 'poi-door-down',
    portal = maps['sfk_upper_observatory'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
