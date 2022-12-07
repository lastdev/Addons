---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['ugk_njorndir_preparation'] = {
  [49208450] = {
    icon = 'poi-door-up',
    portal = maps['ugk_dragonflayer_ascent'],
  },
}

points['ugk_dragonflayer_ascent'] = {
  [35106450] = {
    icon = 'poi-door-down',
    portal = maps['ugk_njorndir_preparation'],
  },
  [54202560] = {
    icon = 'poi-door-up',
    portal = maps['ugk_tyrs_terrace'],
  },
}

points['ugk_tyrs_terrace'] = {
  [33204060] = {
    icon = 'poi-door-down',
    portal = maps['ugk_dragonflayer_ascent'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
