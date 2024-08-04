---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['forbidden_reach'] = {
  [51606070] = {
    icon = 'poi-door-down',
    type = 'world',
    portal = maps['war_creche'],
  },
  [36903140] = {
    icon = 'poi-door-down',
    type = 'world',
    portal = maps['support_creche'],
  },
  [74505350] = {
    icon = 'poi-door-down',
    type = 'world',
    portal = maps['siege_creche'],
  },
  [60803710] = {
    icon = 'poi-door-down',
    type = 'world',
    portal = maps['froststone_vault'],
  },
  [75003610] = {
    icon = 'poi-door-down',
    type = 'world',
    portal = maps['dragonskull_island'],
  },
}

points['dragonskull_island'] = {
  [10406910] = {
    icon = 'poi-door-up',
    type = 'world',
    portal = maps['forbidden_reach'],
  },
  [31409150] = {
    icon = 'poi-door-up',
    type = 'world',
    portal = maps['forbidden_reach'],
  },
}

points['war_creche'] = {
  [67700330] = {
    icon = 'poi-door-up',
    type = 'world',
    portal = maps['forbidden_reach'],
  },
}

points['support_creche'] = {
  [85008240] = {
    icon = 'poi-door-up',
    type = 'world',
    portal = maps['forbidden_reach'],
  },
}

points['siege_creche'] = {
  [21007870] = {
    icon = 'poi-door-up',
    type = 'world',
    portal = maps['forbidden_reach'],
  },
}

points['froststone_vault'] = {
  [24808760] = {
    icon = 'poi-door-up',
    type = 'world',
    portal = maps['forbidden_reach'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
