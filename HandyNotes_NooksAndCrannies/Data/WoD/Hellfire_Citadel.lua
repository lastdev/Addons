---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['hfc_hellfire_citadel'] = {
  [36705110] = {
    icon = 'poi-door-left',
    portal = maps['hfc_hellfire_antechamber'],
  },
}

points['hfc_hellfire_antechamber'] = {
  [92604750] = {
    icon = 'poi-door-right',
    portal = maps['hfc_hellfire_citadel'],
  },
  [72202160] = {
    icon = 'poi-door-up',
    portal = maps['hfc_hellfire_passage'],
  },
  [72207350] = {
    icon = 'poi-door-down',
    portal = maps['hfc_court_of_blood'],
  },
  [22704580] = {
    icon = 'poi-door-up',
    portal = maps['hfc_grommashs_torment'],
  },
}

points['hfc_hellfire_passage'] = {
  [67909050] = {
    icon = 'poi-door-down',
    portal = maps['hfc_hellfire_antechamber'],
  },
  [50802000] = {
    icon = 'poi-door-up',
    portal = maps['hfc_pits_of_mannoroth'],
  },
}

points['hfc_pits_of_mannoroth'] = {
  [60708770] = {
    icon = 'poi-door-down',
    portal = maps['hfc_hellfire_passage'],
  },
}

points['hfc_court_of_blood'] = {
  [81600880] = {
    icon = 'poi-door-up',
    portal = maps['hfc_hellfire_antechamber'],
  },
}

points['hfc_grommashs_torment'] = {
  [88005130] = {
    icon = 'poi-door-right',
    portal = maps['hfc_felborne_breach'],
  },
  [45409430] = {
    icon = 'poi-door-down',
    portal = maps['hfc_halls_of_sargerei'],
  },
  [61808580] = {
    icon = 'poi-door-down',
    portal = maps['hfc_halls_of_sargerei'],
  },
  [62006040] = {
    icon = 'poi-door-up',
    portal = maps['hfc_destructors_rise'],
  },
}

points['hfc_felborne_breach'] = {
  [18405090] = {
    icon = 'poi-door-left',
    portal = maps['hfc_grommashs_torment'],
  },
}

points['hfc_halls_of_sargerei'] = {
  [42400760] = {
    icon = 'poi-door-up',
    portal = maps['hfc_grommashs_torment'],
  },
  [29101930] = {
    icon = 'poi-door-up',
    portal = maps['hfc_grommashs_torment'],
  },
}

points['hfc_destructors_rise'] = {
  [51503590] = {
    icon = 'poi-door-up',
    portal = maps['hfc_black_gate'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
