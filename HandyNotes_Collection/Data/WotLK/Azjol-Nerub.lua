---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['azn_gilded_gate'] = {
  [66301920] = {
    icon = 'door-down',
    portal = maps['azn_hadronoxs_lair'],
  },
}

points['azn_hadronoxs_lair'] = {
  [35502490] = {
    icon = 'door-up',
    portal = maps['azn_gilded_gate'],
  },
  [49205620] = {
    icon = 'door-down',
    portal = maps['azn_brood_pit'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
