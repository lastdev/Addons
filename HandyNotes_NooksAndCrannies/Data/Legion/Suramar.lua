---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps
local t = this.t

points['suramar'] = {
  [22903570] = {
    icon = 'poi-door-down',
    type = 'world',
    portal = maps['temple_of_faladora'],
  },
  [20805050] = {
    icon = 'poi-door-down',
    type = 'world',
    portal = maps['falanaar_tunnels'],
  },
}

points['temple_of_faladora'] = {
  [49506740] = {
    icon = 'poi-door-up',
    type = 'world',
    portal = maps['suramar'],
  },
  [33407250] = {
    icon = 'poi-door-down',
    type = 'world',
    portal = maps['falanaar_tunnels'],
  },
  [41101350] = {
    name = t['shalaran'],
    icon = 'warlockportal-yellow-32x32',
  },
}

points['falanaar_tunnels'] = {
  [46201410] = {
    icon = 'poi-door-up',
    type = 'world',
    portal = maps['temple_of_faladora'],
  },
  [47008120] = {
    icon = 'poi-door-up',
    type = 'world',
    portal = maps['suramar'],
  },
}

points['falanaar_tunnels_army_upper'] = {
  [49506740] = {
    icon = 'poi-door-up',
    type = 'world',
    portal = maps['suramar'],
  },
  [33407250] = {
    icon = 'poi-door-down',
    type = 'world',
    portal = maps['falanaar_tunnels_army_lower'],
  },
}

points['falanaar_tunnels_army_lower'] = {
  [46201410] = {
    icon = 'poi-door-up',
    type = 'world',
    portal = maps['falanaar_tunnels_army_upper'],
  },
  [47008120] = {
    icon = 'poi-door-up',
    type = 'world',
    portal = maps['suramar'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
