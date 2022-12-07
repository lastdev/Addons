---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['bfd_pools_of_askar'] = {
  [60307140] = {
    icon = 'poi-door-right',
    portal = maps['bfd_moonshrine_sanctum'],
  },
}

points['bfd_moonshrine_sanctum'] = {
  [34902910] = {
    icon = 'poi-door-left',
    portal = maps['bfd_pools_of_askar'],
  },
  [45707830] = {
    icon = 'poi-door-down',
    portal = maps['bfd_forgotten_pool'],
  },
}

points['bfd_forgotten_pool'] = {
  [38306230] = {
    icon = 'poi-door-left',
    portal = maps['bfd_moonshrine_sanctum'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
