---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['nax_lower_necropolis'] = {
  [51204640] = {
    icon = 'poi-door-left',
    portal = maps['nax_construct_quarter'],
  },
  [55604640] = {
    icon = 'poi-door-right',
    portal = maps['nax_arachnid_quarter'],
  },
  [51205250] = {
    icon = 'poi-door-left',
    portal = maps['nax_military_quarter'],
  },
  [55605250] = {
    icon = 'poi-door-right',
    portal = maps['nax_plague_quarter'],
  },
  [53304950] = {
    icon = 'poi-door-up',
    portal = maps['nax_upper_necropolis'],
  },
}

points['nax_construct_quarter'] = {
  [68307710] = {
    icon = 'poi-door-right',
    portal = maps['nax_lower_necropolis'],
  },
  [24601190] = {
    icon = 'poi-door-up',
    portal = maps['nax_lower_necropolis'],
  },
}

points['nax_arachnid_quarter'] = {
  [31107710] = {
    icon = 'poi-door-left',
    portal = maps['nax_lower_necropolis'],
  },
  [72401970] = {
    icon = 'poi-door-up',
    portal = maps['nax_lower_necropolis'],
  },
}

points['nax_military_quarter'] = {
  [66602200] = {
    icon = 'poi-door-right',
    portal = maps['nax_lower_necropolis'],
  },
  [27508080] = {
    icon = 'poi-door-up',
    portal = maps['nax_lower_necropolis'],
  },
}

points['nax_plague_quarter'] = {
  [33202290] = {
    icon = 'poi-door-left',
    portal = maps['nax_lower_necropolis'],
  },
  [80402860] = {
    icon = 'poi-door-up',
    portal = maps['nax_lower_necropolis'],
  },
}

points['nax_upper_necropolis'] = {
  [74107280] = {
    icon = 'poi-door-down',
    portal = maps['nax_lower_necropolis'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
