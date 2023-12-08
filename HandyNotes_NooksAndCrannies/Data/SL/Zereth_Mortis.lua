---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['zereth_mortis'] = {
  [63607350] = {
    icon = 'poi-door-down',
    type = 'world',
    portal = maps['blooming_foundry'],
  },
  [55705350] = {
    icon = 'poi-door-down',
    type = 'world',
    portal = maps['locrian_esper'],
  },
  [50703190] = {
    icon = 'poi-door-down',
    type = 'world',
    portal = maps['gravid_repose'],
  },
  [58004440] = {
    icon = 'poi-door-down',
    type = 'world',
    portal = maps['nexus_of_actualization'],
  },
  [49507780] = {
    icon = 'poi-door-down',
    type = 'world',
    portal = maps['catalyst_wards'],
  },
}

points['blooming_foundry'] = {
  [28201190] = {
    icon = 'poi-door-up',
    type = 'world',
    portal = maps['zereth_mortis'],
  },
}

points['locrian_esper'] = {
  [16303450] = {
    icon = 'poi-door-up',
    type = 'world',
    portal = maps['zereth_mortis'],
  },
}

points['gravid_repose'] = {
  [69600920] = {
    icon = 'poi-door-up',
    type = 'world',
    portal = maps['zereth_mortis'],
  },
}

points['nexus_of_actualization'] = {
  [31506050] = {
    icon = 'poi-door-up',
    type = 'world',
    portal = maps['zereth_mortis'],
  },
}

points['catalyst_wards'] = {
  [22901190] = {
    icon = 'poi-door-up',
    type = 'world',
    portal = maps['zereth_mortis'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
