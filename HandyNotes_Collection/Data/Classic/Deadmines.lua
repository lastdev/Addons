---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['dm_deadmines'] = {
  [65306780] = {
    icon = 'door-down',
    portal = maps['dm_ironclad_cove'],
  },
}

points['dm_ironclad_cove'] = {
  [17508290] = {
    icon = 'door-up',
    portal = maps['dm_deadmines'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
