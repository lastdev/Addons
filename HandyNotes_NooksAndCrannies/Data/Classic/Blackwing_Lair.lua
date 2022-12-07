---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['bwl_dragonmaw_garrison'] = {
  [35701240] = {
    icon = 'poi-door-up',
    portal = maps['bwl_halls_of_strife'],
  },
  [43502970] = {
    icon = 'poi-door-up',
    portal = maps['bwl_halls_of_strife'],
  },
}

points['bwl_halls_of_strife'] = {
  [45402070] = {
    icon = 'poi-door-down',
    portal = maps['bwl_dragonmaw_garrison'],
  },
  [51503370] = {
    icon = 'poi-door-down',
    portal = maps['bwl_dragonmaw_garrison'],
  },
  [50508230] = {
    icon = 'poi-door-up',
    portal = maps['bwl_crimson_laboratories'],
  },
}

points['bwl_crimson_laboratories'] = {
  [52108730] = {
    icon = 'poi-door-down',
    portal = maps['bwl_halls_of_strife'],
  },
  [40202030] = {
    icon = 'poi-door-up',
    portal = maps['bwl_nefarians_lair'],
  },
}

points['bwl_nefarians_lair'] = {
  [31804840] = {
    icon = 'poi-door-down',
    portal = maps['bwl_crimson_laboratories'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
