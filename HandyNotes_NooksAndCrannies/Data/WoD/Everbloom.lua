---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['evb_everbloom'] = {
  [43803480] = {
    icon = 'poi-door-left',
    portal = maps['evb_overlook'],
  },
}

points['evb_overlook'] = {
  [45109090] = {
    icon = 'poi-door-down',
    portal = maps['evb_everbloom'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
