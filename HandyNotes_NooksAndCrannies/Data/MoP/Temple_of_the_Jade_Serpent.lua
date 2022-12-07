---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['tjs_temple_of_jade_serpent'] = {
  [26506230] = {
    icon = 'poi-door-left',
    portal = maps['tjs_scrollkeepers_sanctum'],
  },
  [26006780] = {
    icon = 'poi-door-right',
    portal = maps['tjs_scrollkeepers_sanctum'],
  },
}

points['tjs_scrollkeepers_sanctum'] = {
  [44302420] = {
    icon = 'poi-door-right',
    portal = maps['tjs_temple_of_jade_serpent'],
  },
  [41303920] = {
    icon = 'poi-door-left',
    portal = maps['tjs_temple_of_jade_serpent'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
