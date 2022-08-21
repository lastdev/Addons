---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['lbrs_hordemar_city'] = {
  [39404830] = {
    icon = 'door-right',
    portal = maps['lbrs_hall_of_blackhand'],
  },
  [50704090] = {
    icon = 'door-left',
    portal = maps['lbrs_hall_of_blackhand'],
  },
  [62805340] = {
    icon = 'door-down',
    portal = maps['lbrs_skitterweb_tunnels'],
  },
  [55005080] = {
    icon = 'door-left',
    portal = maps['lbrs_skitterweb_tunnels'],
  },
  [49907340] = {
    icon = 'door-right',
    portal = maps['lbrs_skitterweb_tunnels'],
  },
  [46906460] = {
    icon = 'door-up',
    portal = maps['lbrs_hall_of_blackhand'],
  },
}

points['lbrs_hall_of_blackhand'] = {
  [39504800] = {
    icon = 'door-left',
    portal = maps['lbrs_hordemar_city'],
  },
  [49704110] = {
    icon = 'door-right',
    portal = maps['lbrs_hordemar_city'],
  },
  [45406410] = {
    icon = 'door-down',
    portal = maps['lbrs_hordemar_city'],
  },
  [42807560] = {
    icon = 'door-up',
    portal = maps['lbrs_halycons_lair'],
  },
}

points['lbrs_skitterweb_tunnels'] = {
  [56805080] = {
    icon = 'door-right',
    portal = maps['lbrs_hordemar_city'],
  },
  [59406370] = {
    icon = 'door-down',
    portal = maps['lbrs_tazzalor'],
  },
  [64607010] = {
    icon = 'door-left',
    portal = maps['lbrs_tazzalor'],
  },
  [51907480] = {
    icon = 'door-left',
    portal = maps['lbrs_hordemar_city'],
  },
}

points['lbrs_tazzalor'] = {
  [59506410] = {
    icon = 'door-up',
    portal = maps['lbrs_skitterweb_tunnels'],
  },
  [63107000] = {
    icon = 'door-right',
    portal = maps['lbrs_skitterweb_tunnels'],
  },
}

points['lbrs_halycons_lair'] = {
  [42807540] = {
    icon = 'door-down',
    portal = maps['lbrs_hall_of_blackhand'],
  },
  [39306000] = {
    icon = 'door-right',
    portal = maps['lbrs_chamber_of_battle'],
  },
}

points['lbrs_chamber_of_battle'] = {
  [42106020] = {
    icon = 'door-left',
    portal = maps['lbrs_halycons_lair'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
