---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps

points['ssb_grain_cellar'] = {
  [28106070] = {
    icon = 'door-right',
    portal = maps['ssb_stormstout_brewhall'],
  },
}

points['ssb_stormstout_brewhall'] = {
  [31105980] = {
    icon = 'door-left',
    portal = maps['ssb_grain_cellar'],
  },
  [81305840] = {
    icon = 'door-left',
    portal = maps['ssb_great_wheel'],
  },
}

points['ssb_great_wheel'] = {
  [29604910] = {
    icon = 'door-left',
    portal = maps['ssb_stormstout_brewhall'],
  },
  [74903340] = {
    icon = 'door-left',
    portal = maps['ssb_tasting_room'],
  },
}

points['ssb_tasting_room'] = {
  [59303010] = {
    icon = 'door-right',
    portal = maps['ssb_great_wheel'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
