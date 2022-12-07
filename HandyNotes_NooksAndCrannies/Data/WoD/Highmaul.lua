---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['hm_gladiators_rest'] = {
  [46904720] = {
    icon = 'poi-door-up',
    portal = maps['hm_coliseum'],
  },
}

points['hm_coliseum'] = {
  [28002570] = {
    icon = 'poi-door-left',
    portal = maps['hm_highmaul'],
  },
}

points['hm_highmaul'] = {
  [58407780] = {
    icon = 'poi-door-right',
    portal = maps['hm_coliseum'],
  },
  [29706170] = {
    icon = 'poi-door-up',
    portal = maps['hm_chamber_of_nullification'],
  },
}

points['hm_chamber_of_nullification'] = {
  [81008830] = {
    icon = 'poi-door-down',
    portal = maps['hm_highmaul'],
  },
  [30505520] = {
    icon = 'poi-door-up',
    portal = maps['hm_imperators_rise'],
  },
}

points['hm_imperators_rise'] = {
  [36606460] = {
    icon = 'poi-door-down',
    portal = maps['hm_chamber_of_nullification'],
  },
  [44702650] = {
    icon = 'poi-door-up',
    portal = maps['hm_throne_of_imperator'],
  },
}

points['hm_throne_of_imperator'] = {
  [47002810] = {
    icon = 'poi-door-down',
    portal = maps['hm_imperators_rise'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
