---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['nagrand'] = {
  [47006200] = {
    icon = 'poi-door-down',
    type = 'world',
    portal = maps['oshugun'],
  },
  [56406190] = {
    icon = 'poi-door-down',
    type = 'world',
    portal = maps['oshugun'],
  },
  [87905540] = {
    icon = 'poi-door-right',
    type = 'world',
    portal = maps['masters_cavern'],
  },
  [66904960] = {
    icon = 'poi-door-right',
    type = 'world',
    portal = maps['stonecrag_gorge'],
  },
}

points['masters_cavern'] = {
  [32201580] = {
    icon = 'poi-door-left',
    portal = maps['nagrand'],
  },
}

points['oshugun'] = {
  [93403380] = {
    icon = 'poi-door-up',
    portal = maps['nagrand'],
  },
  [07203890] = {
    icon = 'poi-door-up',
    portal = maps['nagrand'],
  },
}

points['stonecrag_gorge'] = {
  [13307600] = {
    icon = 'poi-door-left',
    portal = maps['nagrand'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
