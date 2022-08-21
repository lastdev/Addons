---
--- @file
--- Map point definitions.
---

local _, this = ...

local points = {}
local maps = this.maps
local t = this.t

points['ds_dragon_soul'] = {
  [47805880] = {
    icon = 'door-left',
    portal = maps['ds_maw_of_gorath'],
  },
  [52205880] = {
    icon = 'door-right',
    portal = maps['ds_maw_of_shuma'],
  },
  [50906100] = {
    icon = 'door-up',
    portal = maps['ds_eye_of_eternity'],
  },
  [49105480] = {
    icon = 'door-up',
    portal = maps['ds_skyfire_airship'],
  },
}

points['ds_maw_of_gorath'] = {
  [24004080] = {
    name = t['wyrmrest_temple'],
    icon = 'door-up',
    portal = maps['ds_dragon_soul'],
  },
}

points['ds_maw_of_shuma'] = {
  [57708860] = {
    name = t['wyrmrest_temple'],
    icon = 'door-up',
    portal = maps['ds_dragon_soul'],
  },
}

points['ds_eye_of_eternity'] = {
  [52601420] = {
    name = t['wyrmrest_summit'],
    icon = 'door-up',
    portal = maps['ds_dragon_soul'],
  },
}

points['ds_skyfire_airship'] = {
  [49402470] = {
    icon = 'door-down',
    portal = maps['ds_spine_of_deathwing'],
  },
}

points['ds_spine_of_deathwing'] = {
  [35609120] = {
    icon = 'door-down',
    portal = maps['ds_maelstrom'],
  },
}

points['ds_maelstrom'] = {
  [31508180] = {
    name = t['wyrmrest_temple'],
    icon = 'door-up',
    portal = maps['ds_dragon_soul'],
  },
  [35008150] = {
    icon = 'door-up',
    portal = maps['ds_skyfire_airship'],
  },
}

-- Assign all zones to our addon.
for zoneName, data in pairs(points) do
  this.points[maps[zoneName]] = data
end
