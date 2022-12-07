---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['snt_hollowed_out_tree'] = {
  [53808150] = {
    icon = 'poi-door-right',
    portal = maps['snt_upper_tree_ring'],
  },
}

points['snt_upper_tree_ring'] = {
  [55707900] = {
    icon = 'poi-door-left',
    portal = maps['snt_hollowed_out_tree'],
  },
  [22005240] = {
    icon = 'poi-door-left',
    portal = maps['snt_siege_of_niuzao_temple'],
  },
}

points['snt_siege_of_niuzao_temple'] = {
  [48607240] = {
    icon = 'poi-door-right',
    portal = maps['snt_upper_tree_ring'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
