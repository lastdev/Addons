---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['tot_overgrown_statuary'] = {
  [84107930] = {
    icon = 'poi-door-right',
    portal = maps['tot_royal_amphitheater'],
  },
}

points['tot_royal_amphitheater'] = {
  [17307870] = {
    icon = 'poi-door-left',
    portal = maps['tot_overgrown_statuary'],
  },
  [68701920] = {
    icon = 'poi-door-down',
    portal = maps['tot_forgotten_depths'],
  },
}

points['tot_forgotten_depths'] = {
  [74605580] = {
    icon = 'poi-door-up',
    portal = maps['tot_roots_of_jikun'],
  },
}

points['tot_roots_of_jikun'] = {
  [21701960] = {
    icon = 'poi-door-down',
    portal = maps['tot_forgotten_depths'],
  },
  [33505560] = {
    icon = 'poi-door-left',
    portal = maps['tot_halls_of_fleshshaping'],
  },
}

points['tot_halls_of_fleshshaping'] = {
  [77000840] = {
    icon = 'poi-door-right',
    portal = maps['tot_roots_of_jikun'],
  },
  [46802010] = {
    icon = 'poi-door-up',
    portal = maps['tot_hall_of_kings'],
  },
  [57207850] = {
    icon = 'poi-door-down',
    portal = maps['tot_hidden_cell'],
  },
}

points['tot_hall_of_kings'] = {
  [20506980] = {
    icon = 'poi-door-down',
    portal = maps['tot_halls_of_fleshshaping'],
  },
  [88807570] = {
    icon = 'poi-door-right',
    portal = maps['tot_pinnacle_of_storms'],
  },
}

points['tot_pinnacle_of_storms'] = {
  [46501000] = {
    icon = 'poi-door-left',
    portal = maps['tot_hall_of_kings'],
  },
}

points['tot_hidden_cell'] = {
  [52303380] = {
    icon = 'poi-door-up',
    portal = maps['tot_halls_of_fleshshaping'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
