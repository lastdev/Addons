---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['aq_temple_gates'] = {
  [49106310] = {
    icon = 'door-down',
    portal = maps['aq_vault_of_cthun'],
  },
}

points['aq_vault_of_cthun'] = {
  [47302790] = {
    icon = 'door-up',
    portal = maps['aq_temple_gates'],
  },
  [45204770] = {
    icon = 'door-down',
    portal = maps['aq_hive_undergrounds'],
  },
  [59004160] = {
    icon = 'door-down',
    portal = maps['aq_hive_undergrounds'],
  },
}

points['aq_hive_undergrounds'] = {
  [30905200] = {
    icon = 'door-up',
    portal = maps['aq_vault_of_cthun'],
  },
  [35004520] = {
    icon = 'door-up',
    portal = maps['aq_vault_of_cthun'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
