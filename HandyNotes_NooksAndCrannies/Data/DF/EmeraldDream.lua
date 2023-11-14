---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['emerald_dream'] = {
  [51204270] = {
    icon = 'poi-door-down',
    type = 'world',
    portal = maps['sortheril_barrow_den'],
  },
  [63507170] = {
    icon = 'poi-door-down',
    type = 'world',
    portal = maps['barrows_of_reverie'],
  },
}

points['sortheril_barrow_den'] = {
  [71408840] = {
    icon = 'poi-door-up',
    type = 'world',
    portal = maps['emerald_dream'],
  },
}

points['barrows_of_reverie'] = {
  [66901810] = {
    icon = 'poi-door-up',
    type = 'world',
    portal = maps['emerald_dream'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
