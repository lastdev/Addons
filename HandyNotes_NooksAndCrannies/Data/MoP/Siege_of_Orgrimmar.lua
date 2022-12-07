---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['soo_pools_of_power'] = {
  [11806730] = {
    icon = 'poi-door-up',
    portal = maps['soo_siege_of_orgrimmar'],
  },
}

points['soo_siege_of_orgrimmar'] = {
  [42507110] = {
    icon = 'poi-door-down',
    portal = maps['soo_vault_of_yshaarj'],
  },
}

points['soo_vault_of_yshaarj'] = {
  [61701460] = {
    icon = 'poi-door-up',
    portal = maps['soo_siege_of_orgrimmar'],
  },
  [23108190] = {
    icon = 'poi-door-up',
    portal = maps['soo_gates_of_orgrimmar'],
  },
  [19705730] = {
    icon = 'poi-door-up',
    portal = maps['soo_gates_of_orgrimmar'],
  },
}

points['soo_gates_of_orgrimmar'] = {
  [30303210] = {
    icon = 'poi-door-up',
    portal = maps['soo_valley_of_strength'],
  },
}

points['soo_valley_of_strength'] = {
  [51407800] = {
    icon = 'poi-door-down',
    portal = maps['soo_gates_of_orgrimmar'],
  },
  [56202820] = {
    icon = 'poi-door-left',
    portal = maps['soo_cleft_of_shadow'],
  },
}

points['soo_cleft_of_shadow'] = {
  [77701500] = {
    icon = 'poi-door-right',
    portal = maps['soo_valley_of_strength'],
  },
  [69804890] = {
    icon = 'poi-door-right',
    portal = maps['soo_descent'],
  },
}

points['soo_descent'] = {
  [31002000] = {
    icon = 'poi-door-left',
    portal = maps['soo_cleft_of_shadow'],
  },
  [76206130] = {
    icon = 'poi-door-down',
    portal = maps['soo_korkron_barracks'],
  },
}

points['soo_korkron_barracks'] = {
  [12708640] = {
    icon = 'poi-door-up',
    portal = maps['soo_descent'],
  },
  [77907420] = {
    icon = 'poi-door-left',
    portal = maps['soo_menagerie'],
  },
  [90406190] = {
    icon = 'poi-door-right',
    portal = maps['soo_siegeworks'],
  },
  [88407700] = {
    icon = 'poi-door-down',
    portal = maps['soo_chamber_of_paragons'],
  },
}

points['soo_siegeworks'] = {
  [25508000] = {
    icon = 'poi-door-left',
    portal = maps['soo_korkron_barracks'],
  },
}

points['soo_menagerie'] = {
  [65001640] = {
    icon = 'poi-door-right',
    portal = maps['soo_korkron_barracks'],
  },
}

points['soo_chamber_of_paragons'] = {
  [32701600] = {
    icon = 'poi-door-up',
    portal = maps['soo_korkron_barracks'],
  },
  [65409170] = {
    icon = 'poi-door-down',
    portal = maps['soo_inner_sanctum'],
  },
}

points['soo_inner_sanctum'] = {
  [53701240] = {
    icon = 'poi-door-up',
    portal = maps['soo_chamber_of_paragons'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
