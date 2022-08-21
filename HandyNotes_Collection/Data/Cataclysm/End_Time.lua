---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['ent_end_time'] = {
  [53107360] = {
    icon = 'door-down',
    portal = maps['ent_azure_dragonshrine'],
  },
  [38504180] = {
    icon = 'door-down',
    portal = maps['ent_ruby_dragonshrine'],
  },
  [24201460] = {
    icon = 'door-down',
    portal = maps['ent_obsidian_dragonshrine'],
  },
  [67308650] = {
    icon = 'door-down',
    portal = maps['ent_emerald_dragonshrine'],
  },
  [81002650] = {
    icon = 'door-down',
    portal = maps['ent_bronze_dragonshrine'],
  },
}

points['ent_azure_dragonshrine'] = {
  [41608050] = {
    icon = 'door-up',
    portal = maps['ent_end_time'],
  },
}

points['ent_ruby_dragonshrine'] = {
  [33704330] = {
    icon = 'door-up',
    portal = maps['ent_end_time'],
  },
}

points['ent_obsidian_dragonshrine'] = {
  [78206210] = {
    icon = 'door-up',
    portal = maps['ent_end_time'],
  },
}

points['ent_emerald_dragonshrine'] = {
  [46402120] = {
    icon = 'door-up',
    portal = maps['ent_end_time'],
  },
}

points['ent_bronze_dragonshrine'] = {
  [35407890] = {
    icon = 'door-up',
    portal = maps['ent_end_time'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
