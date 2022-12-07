---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['gorgrond'] = {
  [54005580] = {
    icon = 'poi-door-down',
    type = 'world',
    portal = maps['cragplume_crater'],
  },
  [43504800] = {
    icon = 'poi-door-down',
    type = 'world',
    portal = maps['fissure_of_fury'],
  },
  [47809360] = {
    icon = 'poi-door-right',
    type = 'world',
    portal = maps['moiras_bastion'],
  },
}

points['cragplume_crater'] = {
  [74607500] = {
    icon = 'poi-door-up',
    portal = maps['gorgrond'],
  },
  [70905350] = {
    icon = 'poi-door-down',
    portal = maps['cragplume_depths'],
  },
}

points['cragplume_depths'] = {
  [65005190] = {
    icon = 'poi-door-up',
    portal = maps['cragplume_crater'],
  },
}

points['fissure_of_fury'] = {
  [67008560] = {
    icon = 'poi-door-up',
    portal = maps['gorgrond'],
  },
  [66806550] = {
    icon = 'poi-door-down',
    portal = maps['heart_of_fury'],
  },
}

points['heart_of_fury'] = {
  [65106210] = {
    icon = 'poi-door-up',
    portal = maps['fissure_of_fury'],
  },
}

points['moiras_bastion'] = {
  [59401710] = {
    icon = 'poi-door-left',
    portal = maps['gorgrond'],
  },
  [38903020] = {
    icon = 'poi-door-left',
    portal = maps['gorgrond'],
  },
  [58808300] = {
    icon = 'poi-door-down',
    portal = maps['moiras_armory'],
  },
}

points['moiras_armory'] = {
  [57708630] = {
    icon = 'poi-door-up',
    portal = maps['moiras_bastion'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
