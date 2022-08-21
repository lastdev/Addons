---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['bwd_broken_hall'] = {
  [47004520] = {
    icon = 'door-up',
    portal = maps['bwd_shadowflame_vault'],
  },
}

points['bwd_shadowflame_vault'] = {
  [47509000] = {
    icon = 'door-down',
    portal = maps['bwd_broken_hall'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
