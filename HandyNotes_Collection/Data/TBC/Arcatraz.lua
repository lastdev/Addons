---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['arc_stasis_block_trion'] = {
  [68803110] = {
    icon = 'door-up',
    portal = maps['arc_stasis_block_maximus'],
  },
}

points['arc_stasis_block_maximus'] = {
  [85605160] = {
    icon = 'door-down',
    portal = maps['arc_stasis_block_trion'],
  },
  [44205720] = {
    icon = 'door-right',
    portal = maps['arc_containment_core'],
  },
}

points['arc_containment_core'] = {
  [21808830] = {
    icon = 'door-left',
    portal = maps['arc_stasis_block_maximus'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
