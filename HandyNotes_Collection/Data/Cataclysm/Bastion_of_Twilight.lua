---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['bot_twilight_enclave'] = {
  [53708940] = {
    icon = 'door-down',
    portal = maps['bot_throne_of_apocalypse'],
  },
}

points['bot_throne_of_apocalypse'] = {
  [54601200] = {
    icon = 'door-up',
    portal = maps['bot_twilight_enclave'],
  },
  [69707540] = {
    icon = 'door-down',
    portal = maps['bot_twilight_caverns'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
