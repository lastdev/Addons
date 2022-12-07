---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['frostwall'] = {
  [63607250] = {
    icon = 'poi-door-down',
    type = 'world',
    portal = maps['frostwall_mine'],
  },
  [54801700] = {
    icon = 'poi-door-up',
    type = 'world',
    portal = maps['frostfire_ridge'],
  },
  [74804800] = {
    icon = 'warlockportal-yellow-32x32',
    portal = maps['warspear'],
  },
}

points['frostwall_mine'] = {
  [69405900] = {
    icon = 'poi-door-up',
    portal = maps['frostwall'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
