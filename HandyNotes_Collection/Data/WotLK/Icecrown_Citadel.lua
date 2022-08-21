---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['icc_lower_citadel'] = {
  [39008270] = {
    icon = 'door-up',
    portal = maps['icc_ramparts_of_skulls'],
  },
}

points['icc_ramparts_of_skulls'] = {
  [45608420] = {
    icon = 'door-down',
    portal = maps['icc_lower_citadel'],
  },
  [66005500] = {
    icon = 'door-up',
    portal = maps['icc_deathbringers_rise'],
  },
}

points['icc_deathbringers_rise'] = {
  [51401640] = {
    icon = 'door-up',
    portal = maps['icc_upper_reaches'],
  },
}

points['icc_upper_reaches'] = {
  [51908280] = {
    icon = 'door-down',
    portal = maps['icc_deathbringers_rise'],
  },
  [42601950] = {
    icon = 'door-up',
    portal = maps['icc_royals_quarters'],
  },
  [61201950] = {
    icon = 'door-up',
    portal = maps['icc_royals_quarters'],
  },
  [76609340] = {
    icon = 'door-down',
    portal = maps['icc_front_queens_lair'],
  },
  [87005340] = {
    icon = 'door-down',
    portal = maps['icc_front_queens_lair'],
  },
  [51805330] = {
    icon = 'door-down',
    portal = maps['icc_frozen_throne'],
  },
}

points['icc_front_queens_lair'] = {
  [36509210] = {
    icon = 'door-up',
    portal = maps['icc_upper_reaches'],
  },
  [51903310] = {
    icon = 'door-up',
    portal = maps['icc_upper_reaches'],
  },
}

points['icc_royals_quarters'] = {
  [22703310] = {
    icon = 'door-down',
    portal = maps['icc_upper_reaches'],
  },
  [80003310] = {
    icon = 'door-down',
    portal = maps['icc_upper_reaches'],
  },
  [51207290] = {
    icon = 'door-down',
    portal = maps['icc_upper_reaches'],
  },
}

points['icc_frozen_throne'] = {
  [55807050] = {
    icon = 'door-up',
    portal = maps['icc_lower_citadel'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
