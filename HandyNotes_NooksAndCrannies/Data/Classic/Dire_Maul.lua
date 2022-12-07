---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['drm_capital_gardens'] = {
  [39203340] = {
    icon = 'poi-door-up',
    portal = maps['drm_court_of_highborne'],
  },
  [31907290] = {
    icon = 'poi-door-down',
    portal = maps['drm_court_of_highborne'],
  },
  [24901880] = {
    icon = 'poi-door-down',
    portal = maps['drm_court_of_highborne'],
  },
  [29604310] = {
    icon = 'poi-door-left',
    portal = maps['drm_prison_of_immolthar'],
  },
}

points['drm_court_of_highborne'] = {
  [41101240] = {
    icon = 'poi-door-up',
    portal = maps['drm_capital_gardens'],
  },
  [56402530] = {
    icon = 'poi-door-down',
    portal = maps['drm_capital_gardens'],
  },
  [48407280] = {
    icon = 'poi-door-up',
    portal = maps['drm_capital_gardens'],
  },
}

points['drm_prison_of_immolthar'] = {
  [75903960] = {
    icon = 'poi-door-right',
    portal = maps['drm_capital_gardens'],
  },
}

points['drm_warpwood_quarter'] = {
  [50206310] = {
    icon = 'poi-door-right',
    portal = maps['drm_shrine_of_eldretharr'],
  },
}

points['drm_shrine_of_eldretharr'] = {
  [61508280] = {
    icon = 'poi-door-left',
    portal = maps['drm_warpwood_quarter'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
